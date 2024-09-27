/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Common.h"
#include "CharmInfo.h"
#include "CreatureAI.h"
#include "DisableMgr.h"
#include "GameTime.h"
#include "Group.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "PetPackets.h"
#include "Player.h"
#include "QueryHolder.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Util.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

void WorldSession::HandleDismissCritter(WorldPackets::Pet::DismissCritter& packet)
{
    Unit* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, packet.CritterGUID);

    if (!pet)
    {
        LOG_DEBUG("network", "Vanitypet ({}) does not exist - player {} ({} / account: {}) attempted to dismiss it (possibly lagged out)",
                  packet.CritterGUID.ToString(), GetPlayer()->GetName(), GetPlayer()->GetGUID().ToString(), GetAccountId());
        return;
    }

    if (_player->GetCritterGUID() == pet->GetGUID())
    {
        if (pet->IsCreature() && pet->ToCreature()->IsSummon())
            pet->ToTempSummon()->UnSummon();
    }
}

void WorldSession::HandlePetAction(WorldPacket& recvData)
{
    ObjectGuid guid1;
    uint32 data;
    ObjectGuid guid2;
    recvData >> guid1;                                     //pet guid
    recvData >> data;
    recvData >> guid2;                                     //tag guid

    uint32 spellId = UNIT_ACTION_BUTTON_ACTION(data);
    uint8 flag = UNIT_ACTION_BUTTON_TYPE(data);             //delete = 0x07 CastSpell = C1

    // used also for charmed creature
    Unit* pet = ObjectAccessor::GetUnit(*_player, guid1);
    LOG_DEBUG("network.opcode", "HandlePetAction: Pet {} - flag: {}, spellId: {}, target: {}.", guid1.ToString(), uint32(flag), spellId, guid2.ToString());

    if (!pet)
    {
        LOG_ERROR("network.opcode", "HandlePetAction: Pet ({}) doesn't exist for player {}", guid1.ToString(), GetPlayer()->GetName());
        return;
    }

    if (pet != GetPlayer()->GetFirstControlled())
    {
        LOG_ERROR("network.opcode", "HandlePetAction: Pet ({}) does not belong to player {}", guid1.ToString(), GetPlayer()->GetName());
        return;
    }

    if (!pet->IsAlive())
    {
        // xinef: allow dissmis dead pets
        SpellInfo const* spell = (flag == ACT_ENABLED || flag == ACT_PASSIVE) ? sSpellMgr->GetSpellInfo(spellId) : nullptr;
        if ((flag != ACT_COMMAND || spellId != COMMAND_ABANDON) && (!spell || !spell->HasAttribute(SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD)))
            return;
    }

    // Xinef: allow to controll players
    if (pet->IsPlayer() && flag != ACT_COMMAND && flag != ACT_REACTION)
        return;

    // Do not follow itself vehicle
    if (spellId == COMMAND_FOLLOW && _player->IsOnVehicle(pet))
    {
        return;
    }

    if (GetPlayer()->m_Controlled.size() == 1)
        HandlePetActionHelper(pet, guid1, spellId, flag, guid2);
    else
    {
        //If a pet is dismissed, m_Controlled will change
        std::vector<Unit*> controlled;
        for (Unit::ControlSet::iterator itr = GetPlayer()->m_Controlled.begin(); itr != GetPlayer()->m_Controlled.end(); ++itr)
        {
            // xinef: allow to dissmis dead pets
            if ((*itr)->GetEntry() == pet->GetEntry() && ((*itr)->IsAlive() || (flag == ACT_COMMAND && spellId == COMMAND_ABANDON)))
                controlled.push_back(*itr);
            // xinef: mirror image blizzard
            else if ((*itr)->GetEntry() == NPC_MIRROR_IMAGE && flag == ACT_COMMAND && spellId == COMMAND_FOLLOW)
            {
                (*itr)->InterruptNonMeleeSpells(false);
            }
        }

        for (Unit* pet : controlled)
            if (pet && pet->IsInWorld() && pet->GetMap() == _player->GetMap())
                HandlePetActionHelper(pet, guid1, spellId, flag, guid2);
    }
}

void WorldSession::HandlePetStopAttack(WorldPackets::Pet::PetStopAttack& packet)
{
    Unit* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, packet.PetGUID);

    if (!pet)
    {
        LOG_ERROR("network.opcode", "HandlePetStopAttack: Pet {} does not exist", packet.PetGUID.ToString());
        return;
    }

    if (pet != GetPlayer()->GetPet() && pet != GetPlayer()->GetCharm())
    {
        LOG_ERROR("network.opcode", "HandlePetStopAttack: Pet {} isn't a pet or charmed creature of player {}", packet.PetGUID.ToString(), GetPlayer()->GetName());
        return;
    }

    if (!pet->IsAlive())
        return;

    pet->AttackStop();
    pet->ClearInPetCombat();
}

void WorldSession::HandlePetActionHelper(Unit* pet, ObjectGuid guid1, uint32 spellId, uint16 flag, ObjectGuid guid2)
{
    CharmInfo* charmInfo = pet->GetCharmInfo();
    if (!charmInfo)
    {
        LOG_ERROR("network.opcode", "WorldSession::HandlePetAction(petGuid: {}, tagGuid: {}, spellId: {}, flag: {}): object ({}) is considered pet-like but doesn't have a charminfo!",
                       guid1.ToString(), guid2.ToString(), spellId, flag, pet->GetGUID().ToString());
        return;
    }

    switch (flag)
    {
        case ACT_COMMAND:                                   //0x07
            switch (spellId)
            {
                case COMMAND_STAY:                          //flat=1792  //STAY
                    {
                        bool controlledMotion = pet->GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) != NULL_MOTION_TYPE;
                        if (!controlledMotion)
                        {
                            pet->StopMovingOnCurrentPos();
                            pet->GetMotionMaster()->Clear(false);
                            pet->GetMotionMaster()->MoveIdle();
                        }

                        charmInfo->SetCommandState(COMMAND_STAY);
                        charmInfo->SetIsCommandAttack(false);
                        charmInfo->SetIsCommandFollow(false);
                        charmInfo->SetIsFollowing(false);
                        charmInfo->SetIsReturning(false);
                        charmInfo->SetIsAtStay(!controlledMotion);
                        charmInfo->SaveStayPosition(controlledMotion);
                        if (pet->ToPet())
                            pet->ToPet()->ClearCastWhenWillAvailable();

                        charmInfo->SetForcedSpell(0);
                        charmInfo->SetForcedTargetGUID();
                        break;
                    }
                case COMMAND_FOLLOW:                        //spellId=1792  //FOLLOW
                    {
                        pet->AttackStop();
                        pet->InterruptNonMeleeSpells(false);
                        pet->ClearInPetCombat();
                        pet->GetMotionMaster()->MoveFollow(_player, PET_FOLLOW_DIST, pet->GetFollowAngle());
                        if (pet->ToPet())
                            pet->ToPet()->ClearCastWhenWillAvailable();
                        charmInfo->SetCommandState(COMMAND_FOLLOW);

                        charmInfo->SetIsCommandAttack(false);
                        charmInfo->SetIsAtStay(false);
                        charmInfo->SetIsReturning(true);
                        charmInfo->SetIsCommandFollow(true);
                        charmInfo->SetIsFollowing(false);
                        charmInfo->RemoveStayPosition();
                        charmInfo->SetForcedSpell(0);
                        charmInfo->SetForcedTargetGUID();
                        break;
                    }
                case COMMAND_ATTACK:                        //spellId=1792  //ATTACK
                    {
                        // Can't attack if owner is pacified
                        if (_player->HasAuraType(SPELL_AURA_MOD_PACIFY))
                        {
                            //pet->SendPetCastFail(spellId, SPELL_FAILED_PACIFIED);
                            //TODO: Send proper error message to client
                            return;
                        }

                        // only place where pet can be player
                        Unit* TargetUnit = ObjectAccessor::GetUnit(*_player, guid2);
                        if (!TargetUnit)
                            return;

                        if (Unit* owner = pet->GetOwner())
                            if (!owner->IsValidAttackTarget(TargetUnit))
                                return;

                        // pussywizard (excluded charmed)
                        if (!pet->IsCharmed())
                            if (Creature* creaturePet = pet->ToCreature())
                                if (!creaturePet->CanCreatureAttack(TargetUnit))
                                    return;

                        // Not let attack through obstructions
                        bool checkLos = !DisableMgr::IsPathfindingEnabled(pet->GetMap()) ||
                                        (TargetUnit->IsCreature() && (TargetUnit->ToCreature()->isWorldBoss() || TargetUnit->ToCreature()->IsDungeonBoss()));

                        if (checkLos && !pet->IsWithinLOSInMap(TargetUnit))
                        {
                            WorldPacket data(SMSG_CAST_FAILED, 1 + 4 + 1);
                            data << uint8(0);
                            data << uint32(7389);
                            data << uint8(SPELL_FAILED_LINE_OF_SIGHT);
                            SendPacket(&data);
                            return;
                        }

                        pet->ClearUnitState(UNIT_STATE_FOLLOW);
                        // This is true if pet has no target or has target but targets differs.
                        if (pet->GetVictim() != TargetUnit || (pet->GetVictim() == TargetUnit && !pet->GetCharmInfo()->IsCommandAttack()))
                        {
                            pet->AttackStop();

                            if (!pet->IsPlayer() && pet->ToCreature()->IsAIEnabled)
                            {
                                charmInfo->SetIsCommandAttack(true);
                                charmInfo->SetIsAtStay(false);
                                charmInfo->SetIsFollowing(false);
                                charmInfo->SetIsCommandFollow(false);
                                charmInfo->SetIsReturning(false);

                                pet->ToCreature()->AI()->AttackStart(TargetUnit);

                                //10% chance to play special pet attack talk, else growl
                                if (pet->IsPet() && ((Pet*)pet)->getPetType() == SUMMON_PET && pet != TargetUnit && urand(0, 100) < 10)
                                    pet->SendPetTalk((uint32)PET_TALK_ATTACK);
                                else
                                {
                                    // 90% chance for pet and 100% chance for charmed creature
                                    pet->SendPetAIReaction(guid1);
                                }
                            }
                            else                                // charmed player
                            {
                                charmInfo->SetIsCommandAttack(true);
                                charmInfo->SetIsAtStay(false);
                                charmInfo->SetIsFollowing(false);
                                charmInfo->SetIsCommandFollow(false);
                                charmInfo->SetIsReturning(false);

                                pet->Attack(TargetUnit, true);
                                pet->SendPetAIReaction(guid1);
                            }
                        }
                        break;
                    }
                case COMMAND_ABANDON:                       // abandon (hunter pet) or dismiss (summoned pet)
                    if (pet->GetCharmerGUID() == GetPlayer()->GetGUID())
                    {
                        _player->StopCastingCharm();
                    }
                    else if (pet->GetOwnerGUID() == GetPlayer()->GetGUID())
                    {
                        ASSERT(pet->IsCreature());
                        if (pet->IsPet())
                        {
                            if (pet->ToPet()->getPetType() == HUNTER_PET)
                                GetPlayer()->RemovePet(pet->ToPet(), PET_SAVE_AS_DELETED);
                            else
                                //dismissing a summoned pet is like killing them (this prevents returning a soulshard...)
                                pet->setDeathState(DeathState::Corpse);
                        }
                        else if (pet->HasUnitTypeMask(UNIT_MASK_MINION | UNIT_MASK_SUMMON | UNIT_MASK_GUARDIAN | UNIT_MASK_CONTROLABLE_GUARDIAN))
                        {
                            pet->ToTempSummon()->UnSummon();
                        }
                    }
                    break;
                default:
                    LOG_ERROR("network.opcode", "WORLD: unknown PET flag Action {} and spellId {}.", uint32(flag), spellId);
            }
            break;
        case ACT_REACTION:                                  // 0x6
            switch (spellId)
            {
                case REACT_PASSIVE:                         //passive
                    pet->AttackStop();
                    if (pet->ToPet())
                        pet->ToPet()->ClearCastWhenWillAvailable();
                    pet->ClearInPetCombat();
                    [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.

                case REACT_DEFENSIVE:                       //recovery
                case REACT_AGGRESSIVE:                      //activete
                    if (pet->IsCreature())
                        pet->ToCreature()->SetReactState(ReactStates(spellId));
                    else
                        charmInfo->SetPlayerReactState(ReactStates(spellId));
                    break;
            }
            break;
        case ACT_DISABLED:                                  // 0x81    spell (disabled), ignore
        case ACT_PASSIVE:                                   // 0x01
        case ACT_ENABLED:                                   // 0xC1    spell
            {
                Unit* unit_target = nullptr;

                // do not cast unknown spells
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
                if (!spellInfo)
                {
                    LOG_ERROR("network.opcode", "WORLD: unknown PET spell id {}", spellId);
                    return;
                }

                if (guid2)
                    unit_target = ObjectAccessor::GetUnit(*_player, guid2);
                else if (!spellInfo->IsPositive())
                    return;

                for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (spellInfo->Effects[i].TargetA.GetTarget() == TARGET_UNIT_SRC_AREA_ENEMY || spellInfo->Effects[i].TargetA.GetTarget() == TARGET_UNIT_DEST_AREA_ENEMY || spellInfo->Effects[i].TargetA.GetTarget() == TARGET_DEST_DYNOBJ_ENEMY)
                        return;
                }

                TriggerCastFlags triggerCastFlags = TRIGGERED_NONE;

                if (spellInfo->IsPassive())
                    return;

                // cast only learned spells
                if (!pet->HasSpell(spellId))
                {
                    bool allow = false;

                    // allow casting of spells triggered by clientside periodic trigger auras
                    if (pet->HasAuraTypeWithTriggerSpell(SPELL_AURA_PERIODIC_TRIGGER_SPELL_FROM_CLIENT, spellId))
                    {
                        allow = true;
                        triggerCastFlags = TRIGGERED_FULL_MASK;
                    }

                    if (!allow)
                        return;
                }

                Spell* spell = new Spell(pet, spellInfo, triggerCastFlags);
                spell->LoadScripts(); // xinef: load for CheckPetCast

                SpellCastResult result = spell->CheckPetCast(unit_target);

                //auto turn to target unless possessed
                if (result == SPELL_FAILED_UNIT_NOT_INFRONT && !pet->isPossessed() && !pet->IsVehicle())
                {
                    if (unit_target)
                    {
                        pet->SetInFront(unit_target);
                        if (unit_target->IsPlayer())
                            pet->SendUpdateToPlayer(unit_target->ToPlayer());
                    }
                    else if (Unit* unit_target2 = spell->m_targets.GetUnitTarget())
                    {
                        pet->SetInFront(unit_target2);
                        if (unit_target2->IsPlayer())
                            pet->SendUpdateToPlayer(unit_target2->ToPlayer());
                    }
                    if (Unit* powner = pet->GetCharmerOrOwner())
                        if (powner->IsPlayer())
                            pet->SendUpdateToPlayer(powner->ToPlayer());

                    result = SPELL_CAST_OK;
                }

                if (result == SPELL_CAST_OK)
                {
                    if (!spellInfo->IsCooldownStartedOnEvent())
                    {
                        pet->ToCreature()->AddSpellCooldown(spellId, 0, 0);
                    }

                    unit_target = spell->m_targets.GetUnitTarget();

                    //10% chance to play special pet attack talk, else growl
                    //actually this only seems to happen on special spells, fire shield for imp, torment for voidwalker, but it's stupid to check every spell
                    if (pet->IsPet() && (((Pet*)pet)->getPetType() == SUMMON_PET) && (pet != unit_target) && (urand(0, 100) < 10))
                        pet->SendPetTalk((uint32)PET_TALK_SPECIAL_SPELL);
                    else
                    {
                        pet->SendPetAIReaction(guid1);
                    }

                    if (unit_target && !GetPlayer()->IsFriendlyTo(unit_target) && !pet->isPossessed() && !pet->IsVehicle())
                    {
                        // This is true if pet has no target or has target but targets differs.
                        if (pet->GetVictim() != unit_target)
                        {
                            if (pet->ToCreature()->IsAIEnabled)
                                pet->ToCreature()->AI()->AttackStart(unit_target);
                        }
                    }

                    spell->prepare(&(spell->m_targets));

                    charmInfo->SetForcedSpell(0);
                    charmInfo->SetForcedTargetGUID();
                }
                else if (pet->ToPet() && (result == SPELL_FAILED_LINE_OF_SIGHT || result == SPELL_FAILED_OUT_OF_RANGE))
                {
                    unit_target = spell->m_targets.GetUnitTarget();
                    bool haspositiveeffect = false;

                    if (!unit_target)
                        return;

                    // search positive effects for spell
                    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    {
                        if (spellInfo->_IsPositiveEffect(i, true))
                        {
                            haspositiveeffect = true;
                            break;
                        }
                    }

                    if (pet->isPossessed() || pet->IsVehicle())
                        Spell::SendCastResult(GetPlayer(), spellInfo, 0, result);
                    else if (GetPlayer()->IsFriendlyTo(unit_target) && !haspositiveeffect)
                        spell->SendPetCastResult(SPELL_FAILED_TARGET_FRIENDLY);
                    else
                        spell->SendPetCastResult(SPELL_FAILED_DONT_REPORT);

                    if (!pet->HasSpellCooldown(spellId))
                        if (pet->ToPet())
                            pet->ToPet()->RemoveSpellCooldown(spellId, true);

                    spell->finish(false);
                    delete spell;

                    if (_player->HasAuraType(SPELL_AURA_MOD_PACIFY))
                        return;

                    bool tempspellIsPositive = false;

                    if (!GetPlayer()->IsFriendlyTo(unit_target))
                    {
                        // only place where pet can be player
                        Unit* TargetUnit = ObjectAccessor::GetUnit(*_player, guid2);
                        if (!TargetUnit)
                            return;

                        if (Unit* owner = pet->GetOwner())
                            if (!owner->IsValidAttackTarget(TargetUnit))
                                return;

                        pet->ClearUnitState(UNIT_STATE_FOLLOW);
                        // This is true if pet has no target or has target but targets differs.
                        if (pet->GetVictim() != TargetUnit || (pet->GetVictim() == TargetUnit && !pet->GetCharmInfo()->IsCommandAttack()))
                        {
                            if (pet->GetVictim())
                                pet->AttackStop();

                            if (!pet->IsPlayer() && pet->ToCreature() && pet->ToCreature()->IsAIEnabled)
                            {
                                charmInfo->SetIsCommandAttack(true);
                                charmInfo->SetIsAtStay(false);
                                charmInfo->SetIsFollowing(false);
                                charmInfo->SetIsCommandFollow(false);
                                charmInfo->SetIsReturning(false);

                                pet->ToCreature()->AI()->AttackStart(TargetUnit);

                                if (pet->IsPet() && ((Pet*)pet)->getPetType() == SUMMON_PET && pet != TargetUnit && urand(0, 100) < 10)
                                    pet->SendPetTalk((uint32)PET_TALK_SPECIAL_SPELL);
                                else
                                    pet->SendPetAIReaction(guid1);
                            }
                            else // charmed player
                            {
                                if (pet->GetVictim() && pet->GetVictim() != TargetUnit)
                                    pet->AttackStop();

                                charmInfo->SetIsCommandAttack(true);
                                charmInfo->SetIsAtStay(false);
                                charmInfo->SetIsFollowing(false);
                                charmInfo->SetIsCommandFollow(false);
                                charmInfo->SetIsReturning(false);

                                pet->Attack(TargetUnit, true);
                                pet->SendPetAIReaction(guid1);
                            }

                            pet->ToPet()->CastWhenWillAvailable(spellId, unit_target, ObjectGuid::Empty, tempspellIsPositive);
                        }
                    }
                    else if (haspositiveeffect)
                    {
                        bool tmpSpellIsPositive = true;
                        pet->ClearUnitState(UNIT_STATE_FOLLOW);
                        // This is true if pet has no target or has target but targets differs.
                        Unit* victim = pet->GetVictim();
                        if (victim)
                        {
                            pet->AttackStop();
                        }
                        else
                            victim = nullptr;

                        if (!pet->IsPlayer() && pet->ToCreature() && pet->ToCreature()->IsAIEnabled)
                        {
                            pet->StopMoving();
                            pet->GetMotionMaster()->Clear();

                            charmInfo->SetIsCommandAttack(false);
                            charmInfo->SetIsAtStay(false);
                            charmInfo->SetIsFollowing(false);
                            charmInfo->SetIsCommandFollow(false);
                            charmInfo->SetIsReturning(false);

                            pet->GetMotionMaster()->MoveFollow(unit_target, PET_FOLLOW_DIST, rand_norm() * 2 * M_PI);

                            if (pet->IsPet() && ((Pet*)pet)->getPetType() == SUMMON_PET && pet != unit_target && urand(0, 100) < 10)
                                pet->SendPetTalk((uint32)PET_TALK_SPECIAL_SPELL);
                            else
                            {
                                pet->SendPetAIReaction(guid1);
                            }

                            ObjectGuid oldTarget = ObjectGuid::Empty;
                            if (victim)
                                oldTarget = victim->GetGUID();

                            pet->ToPet()->CastWhenWillAvailable(spellId, unit_target, oldTarget, tmpSpellIsPositive);
                        }
                    }
                }
                else
                {
                    // dont spam alerts
                    if (!charmInfo->GetForcedSpell())
                    {
                        if (pet->isPossessed() || pet->IsVehicle())
                            Spell::SendCastResult(GetPlayer(), spellInfo, 0, result);
                        else
                            spell->SendPetCastResult(result);
                    }

                    if (!pet->ToCreature()->HasSpellCooldown(spellId))
                        GetPlayer()->SendClearCooldown(spellId, pet);

                    spell->finish(false);
                    delete spell;

                    // reset specific flags in case of spell fail. AI will reset other flags
                    pet->PetSpellFail(spellInfo, unit_target, result);
                }
                break;
            }
        default:
            LOG_ERROR("network.opcode", "WORLD: unknown PET flag Action {} and spellId {}.", uint32(flag), spellId);
    }
}

void WorldSession::HandlePetNameQuery(WorldPacket& recvData)
{
    LOG_DEBUG("network.opcode", "HandlePetNameQuery. CMSG_PET_NAME_QUERY");

    uint32 petnumber;
    ObjectGuid petguid;

    recvData >> petnumber;
    recvData >> petguid;

    SendPetNameQuery(petguid, petnumber);
}

void WorldSession::SendPetNameQuery(ObjectGuid petguid, uint32 petnumber)
{
    Creature* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, petguid);
    if (!pet)
    {
        WorldPacket data(SMSG_PET_NAME_QUERY_RESPONSE, (4 + 1 + 4 + 1));
        data << uint32(petnumber);
        data << uint8(0);
        data << uint32(0);
        data << uint8(0);
        SendPacket(&data);
        return;
    }

    std::string name;
    if (pet->GetEntry() == NPC_WATER_ELEMENTAL_PERM)
    {
        // Use localized creature name for the mage pet
        LocaleConstant loc_idx = GetSessionDbLocaleIndex();
        if (loc_idx != DEFAULT_LOCALE)
            name = pet->GetNameForLocaleIdx(loc_idx);
        else
            name = pet->GetCreatureTemplate()->Name;
    }
    else
        name = pet->GetName();

    WorldPacket data(SMSG_PET_NAME_QUERY_RESPONSE, (4 + 4 + name.size() + 1));
    data << uint32(petnumber);
    data << name.c_str();
    data << uint32(pet->GetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP));

    if (pet->IsPet() && ((Pet*)pet)->GetDeclinedNames())
    {
        data << uint8(1);
        for (uint8 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
            data << ((Pet*)pet)->GetDeclinedNames()->name[i];
    }
    else
        data << uint8(0);

    SendPacket(&data);
}

bool WorldSession::CheckStableMaster(ObjectGuid guid)
{
    // spell case or GM
    if (guid == GetPlayer()->GetGUID())
    {
        if (!GetPlayer()->IsGameMaster() && !GetPlayer()->HasAuraType(SPELL_AURA_OPEN_STABLE))
        {
            LOG_DEBUG("network.opcode", "Player ({}) attempt open stable in cheating way.", guid.ToString());
            return false;
        }
    }
    // stable master case
    else
    {
        if (!GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_STABLEMASTER))
        {
            LOG_DEBUG("network.opcode", "Stablemaster ({}) not found or you can't interact with him.", guid.ToString());
            return false;
        }
    }
    return true;
}

void WorldSession::HandlePetSetAction(WorldPacket& recvData)
{
    LOG_DEBUG("network.opcode", "HandlePetSetAction. CMSG_PET_SET_ACTION");

    ObjectGuid petguid;
    uint8  count;

    recvData >> petguid;

    Unit* checkPet = ObjectAccessor::GetUnit(*_player, petguid);
    if (!checkPet || checkPet != _player->GetFirstControlled())
    {
        LOG_ERROR("network.opcode", "HandlePetSetAction: Unknown pet ({}) or pet owner ({})", petguid.ToString(), _player->GetGUID().ToString());
        return;
    }

    count = (recvData.size() == 24) ? 2 : 1;

    uint32 position[2];
    uint32 data[2];
    bool move_command = false;

    for (uint8 i = 0; i < count; ++i)
    {
        recvData >> position[i];
        recvData >> data[i];

        uint8 act_state = UNIT_ACTION_BUTTON_TYPE(data[i]);

        //ignore invalid position
        if (position[i] >= MAX_UNIT_ACTION_BAR_INDEX)
            return;

        // in the normal case, command and reaction buttons can only be moved, not removed
        // at moving count == 2, at removing count == 1
        // ignore attempt to remove command|reaction buttons (not possible at normal case)
        if (act_state == ACT_COMMAND || act_state == ACT_REACTION)
        {
            if (count == 1)
                return;

            move_command = true;
        }
    }

    Unit::ControlSet petsSet;
    if (checkPet->GetEntry() != petguid.GetEntry())
        petsSet.insert(checkPet);
    else
        petsSet = _player->m_Controlled;

    // Xinef: loop all pets with same entry (fixes partial state change for feral spirits)
    for (Unit::ControlSet::const_iterator itr = petsSet.begin(); itr != petsSet.end(); ++itr)
    {
        Unit* pet = *itr;
        if (checkPet->GetEntry() == petguid.GetEntry() && pet->GetEntry() != petguid.GetEntry())
            continue;

        CharmInfo* charmInfo = pet->GetCharmInfo();
        if (!charmInfo)
        {
            LOG_ERROR("network.opcode", "WorldSession::HandlePetSetAction: object ({} TypeId: {}) is considered pet-like but doesn't have a charminfo!",
                pet->GetGUID().ToString(), pet->GetTypeId());
            continue;
        }

        // check swap (at command->spell swap client remove spell first in another packet, so check only command move correctness)
        if (move_command)
        {
            uint8 act_state_0 = UNIT_ACTION_BUTTON_TYPE(data[0]);
            if (act_state_0 == ACT_COMMAND || act_state_0 == ACT_REACTION)
            {
                uint32 spell_id_0 = UNIT_ACTION_BUTTON_ACTION(data[0]);
                UnitActionBarEntry const* actionEntry_1 = charmInfo->GetActionBarEntry(position[1]);
                if (!actionEntry_1 || spell_id_0 != actionEntry_1->GetAction() ||
                        act_state_0 != actionEntry_1->GetType())
                    continue;
            }

            uint8 act_state_1 = UNIT_ACTION_BUTTON_TYPE(data[1]);
            if (act_state_1 == ACT_COMMAND || act_state_1 == ACT_REACTION)
            {
                uint32 spell_id_1 = UNIT_ACTION_BUTTON_ACTION(data[1]);
                UnitActionBarEntry const* actionEntry_0 = charmInfo->GetActionBarEntry(position[0]);
                if (!actionEntry_0 || spell_id_1 != actionEntry_0->GetAction() ||
                        act_state_1 != actionEntry_0->GetType())
                    continue;
            }
        }

        for (uint8 i = 0; i < count; ++i)
        {
            uint32 spell_id = UNIT_ACTION_BUTTON_ACTION(data[i]);
            uint8 act_state = UNIT_ACTION_BUTTON_TYPE(data[i]);

            //if it's act for spell (en/disable/cast) and there is a spell given (0 = remove spell) which pet doesn't know, don't add
            if (!((act_state == ACT_ENABLED || act_state == ACT_DISABLED || act_state == ACT_PASSIVE) && spell_id && !pet->HasSpell(spell_id)))
            {
                if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell_id))
                {
                    //sign for autocast
                    if (act_state == ACT_ENABLED)
                    {
                        if (pet->IsCreature() && pet->IsPet())
                        {
                            ((Pet*)pet)->ToggleAutocast(spellInfo, true);
                        }
                        else
                        {
                            for (auto iterator = GetPlayer()->m_Controlled.begin(); iterator != GetPlayer()->m_Controlled.end(); ++iterator)
                            {
                                if ((*iterator)->GetEntry() == pet->GetEntry())
                                {
                                    (*iterator)->GetCharmInfo()->ToggleCreatureAutocast(spellInfo, true);
                                }
                            }
                        }
                    }
                    //sign for no/turn off autocast
                    else if (act_state == ACT_DISABLED)
                    {
                        if (pet->IsCreature() && pet->IsPet())
                        {
                            ((Pet*)pet)->ToggleAutocast(spellInfo, false);
                        }
                        else
                        {
                            for (auto iterator = GetPlayer()->m_Controlled.begin(); iterator != GetPlayer()->m_Controlled.end(); ++iterator)
                            {
                                if ((*iterator)->GetEntry() == pet->GetEntry())
                                {
                                    (*iterator)->GetCharmInfo()->ToggleCreatureAutocast(spellInfo, false);
                                }
                            }
                        }
                    }
                }

                charmInfo->SetActionBar(position[i], spell_id, ActiveStates(act_state));
            }
        }
    }
}

void WorldSession::HandlePetRename(WorldPacket& recvData)
{
    LOG_DEBUG("network.opcode", "HandlePetRename. CMSG_PET_RENAME");

    ObjectGuid petguid;
    uint8 isdeclined;

    std::string name;
    DeclinedName declinedname;

    recvData >> petguid;
    recvData >> name;
    recvData >> isdeclined;

    PetStable* petStable = _player->GetPetStable();

    Pet* pet = ObjectAccessor::GetPet(*_player, petguid);

    // check it!
    if (!pet || !pet->IsPet() || ((Pet*)pet)->getPetType() != HUNTER_PET ||
        !pet->HasByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED) ||
        pet->GetOwnerGUID() != _player->GetGUID() || !pet->GetCharmInfo() ||
        !petStable || !petStable->CurrentPet || petStable->CurrentPet->PetNumber != pet->GetCharmInfo()->GetPetNumber())
    {
        return;
    }

    PetNameInvalidReason res = ObjectMgr::CheckPetName(name);
    if (res != PET_NAME_SUCCESS)
    {
        SendPetNameInvalid(res, name, nullptr);
        return;
    }

    pet->SetName(name);

    Unit* owner = pet->GetOwner();
    if (owner && (owner->IsPlayer()) && owner->ToPlayer()->GetGroup())
        owner->ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_NAME);

    pet->RemoveByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED);

    petStable->CurrentPet->Name = name;
    petStable->CurrentPet->WasRenamed = true;

    if (isdeclined)
    {
        for (uint8 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
        {
            recvData >> declinedname.name[i];
        }

        std::wstring wname;
        Utf8toWStr(name, wname);
        if (!ObjectMgr::CheckDeclinedNames(wname, declinedname))
        {
            SendPetNameInvalid(PET_NAME_DECLENSION_DOESNT_MATCH_BASE_NAME, name, &declinedname);
            return;
        }
    }

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
    if (isdeclined)
    {
        if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
        {
            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME);
            stmt->SetData(0, pet->GetCharmInfo()->GetPetNumber());
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_ADD_CHAR_PET_DECLINEDNAME);
            stmt->SetData(0, _player->GetGUID().GetCounter());

            for (uint8 i = 0; i < 5; i++)
                stmt->SetData(i + 1, declinedname.name[i]);

            trans->Append(stmt);
        }
    }

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_NAME);
    stmt->SetData(0, name);
    stmt->SetData(1, _player->GetGUID().GetCounter());
    stmt->SetData(2, pet->GetCharmInfo()->GetPetNumber());
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    pet->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, uint32(GameTime::GetGameTime().count())); // cast can't be helped
}

void WorldSession::HandlePetAbandon(WorldPackets::Pet::PetAbandon& packet)
{
    if (!_player->IsInWorld())
        return;

    // pet/charmed
    Creature* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, packet.PetGUID);
    if (pet && pet->ToPet() && pet->ToPet()->getPetType() == HUNTER_PET)
    {
        if (pet->IsPet())
        {
            if (pet->GetGUID() == _player->GetPetGUID())
            {
                uint32 feelty = pet->GetPower(POWER_HAPPINESS);
                pet->SetPower(POWER_HAPPINESS, feelty > 50000 ? (feelty - 50000) : 0);
            }

            _player->RemovePet(pet->ToPet(), PET_SAVE_AS_DELETED);
        }
        else if (pet->GetGUID() == _player->GetCharmGUID())
            _player->StopCastingCharm();
    }
}

void WorldSession::HandlePetSpellAutocastOpcode(WorldPackets::Pet::PetSpellAutocast& packet)
{
    Creature* checkPet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, packet.PetGUID);
    if (!checkPet)
    {
        LOG_ERROR("entities.pet", "WorldSession::HandlePetSpellAutocastOpcode: Pet {} not found.", packet.PetGUID.ToString());
        return;
    }

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(packet.SpellID);
    if (!spellInfo)
    {
        LOG_ERROR("spells.pet", "WorldSession::HandlePetSpellAutocastOpcode: Unknown spell id {} used by {}.", packet.SpellID, packet.PetGUID.ToString());
        return;
    }

    if (checkPet != _player->GetGuardianPet() && checkPet != _player->GetCharm())
    {
        LOG_ERROR("entities.pet", "WorldSession::HandlePetSpellAutocastOpcode: {} isn't pet of player {} ({}).",
                  packet.PetGUID.ToString(), GetPlayer()->GetName(), GetPlayer()->GetGUID().ToString());
        return;
    }

    Unit::ControlSet petsSet;
    if (checkPet->GetEntry() != packet.PetGUID.GetEntry())
        petsSet.insert(checkPet);
    else
        petsSet = _player->m_Controlled;

    // Xinef: loop all pets with same entry (fixes partial state change for feral spirits)
    for (Unit* pet : petsSet)
    {
        if (checkPet->GetEntry() == packet.PetGUID.GetEntry() && pet->GetEntry() != packet.PetGUID.GetEntry())
            continue;

        // do not add not learned spells/ passive spells
        if (!pet->HasSpell(packet.SpellID) || !spellInfo->IsAutocastable())
            continue;

        CharmInfo* charmInfo = pet->GetCharmInfo();
        if (!charmInfo)
        {
            LOG_ERROR("network.opcode", "WorldSession::HandlePetSpellAutocastOpcode: object ({} TypeId: {}) is considered pet-like but doesn't have a charminfo!",
                pet->GetGUID().ToString(), pet->GetTypeId());
            continue;
        }

        if (Pet* summon = pet->ToPet())
            summon->ToggleAutocast(spellInfo, packet.AutocastEnabled);
        else
            charmInfo->ToggleCreatureAutocast(spellInfo, packet.AutocastEnabled);

        charmInfo->SetSpellAutocast(spellInfo, packet.AutocastEnabled);
    }
}

void WorldSession::HandlePetCastSpellOpcode(WorldPacket& recvPacket)
{
    LOG_DEBUG("network", "WORLD: CMSG_PET_CAST_SPELL");

    ObjectGuid guid;
    uint8  castCount;
    uint32 spellId;
    uint8  castFlags;

    recvPacket >> guid >> castCount >> spellId >> castFlags;

    LOG_DEBUG("network", "WORLD: CMSG_PET_CAST_SPELL, guid: {}, castCount: {}, spellId {}, castFlags {}", guid.ToString(), castCount, spellId, castFlags);

    // This opcode is also sent from charmed and possessed units (players and creatures)
    if (!_player->GetGuardianPet() && !_player->GetCharm())
        return;

    Unit* caster = ObjectAccessor::GetUnit(*_player, guid);

    if (!caster || (caster != _player->GetGuardianPet() && caster != _player->GetCharm()))
    {
        LOG_ERROR("network.opcode", "HandlePetCastSpellOpcode: Pet {} isn't pet of player {} .", guid.ToString(), GetPlayer()->GetName());
        return;
    }

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        LOG_ERROR("network.opcode", "WORLD: unknown PET spell id {}", spellId);
        return;
    }

    // do not cast not learned spells
    if (!caster->HasSpell(spellId) || spellInfo->IsPassive())
        return;

    SpellCastTargets targets;
    targets.Read(recvPacket, caster);
    HandleClientCastFlags(recvPacket, castFlags, targets);

    bool SetFollow = caster->HasUnitState(UNIT_STATE_FOLLOW);
    caster->ClearUnitState(UNIT_STATE_FOLLOW);

    Spell* spell = new Spell(caster, spellInfo, TRIGGERED_NONE);
    spell->m_cast_count = castCount;                    // probably pending spell cast
    spell->m_targets = targets;
    spell->LoadScripts();

    // Xinef: Send default target, fixes return on NeedExplicitUnitTarget
    Unit* target = targets.GetUnitTarget();
    if (!target && spell->m_spellInfo->NeedsExplicitUnitTarget())
        target = _player->GetSelectedUnit();

    SpellCastResult result = spell->CheckPetCast(target);

    if (result == SPELL_CAST_OK)
    {
        if (Creature* creature = caster->ToCreature())
        {
            creature->AddSpellCooldown(spellId, 0, 0);
            if (Pet* pet = creature->ToPet())
            {
                // 10% chance to play special pet attack talk, else growl
                // actually this only seems to happen on special spells, fire shield for imp, torment for voidwalker, but it's stupid to check every spell
                if (pet->getPetType() == SUMMON_PET && (urand(0, 100) < 10))
                    pet->SendPetTalk(PET_TALK_SPECIAL_SPELL);
                else
                    pet->SendPetAIReaction(guid);
            }
        }

        spell->prepare(&(spell->m_targets));
    }
    else
    {
        if (!caster->GetCharmInfo() || !caster->GetCharmInfo()->GetForcedSpell())
            spell->SendPetCastResult(result);

        if (caster->IsPlayer())
        {
            if (!caster->ToPlayer()->HasSpellCooldown(spellId))
                GetPlayer()->SendClearCooldown(spellId, caster);
        }
        else
        {
            if (!caster->ToCreature()->HasSpellCooldown(spellId))
                GetPlayer()->SendClearCooldown(spellId, caster);

            // reset specific flags in case of spell fail. AI will reset other flags
            if (caster->IsPet())
                caster->PetSpellFail(spellInfo, targets.GetUnitTarget(), result);
        }

        spell->finish(false);
        delete spell;
    }

    if (SetFollow && !caster->IsInCombat())
        caster->AddUnitState(UNIT_STATE_FOLLOW);
}

void WorldSession::SendPetNameInvalid(uint32 error, const std::string& name, DeclinedName* declinedName)
{
    WorldPacket data(SMSG_PET_NAME_INVALID, 4 + name.size() + 1 + 1);
    data << uint32(error);
    data << name;
    if (declinedName)
    {
        data << uint8(1);
        for (uint32 i = 0; i < MAX_DECLINED_NAME_CASES; ++i)
            data << declinedName->name[i];
    }
    else
        data << uint8(0);
    SendPacket(&data);
}

void WorldSession::HandlePetLearnTalent(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: CMSG_PET_LEARN_TALENT");

    ObjectGuid guid;
    uint32 talent_id, requested_rank;
    recvData >> guid >> talent_id >> requested_rank;

    _player->LearnPetTalent(guid, talent_id, requested_rank);
    _player->SendTalentsInfoData(true);
}

void WorldSession::HandleLearnPreviewTalentsPet(WorldPacket& recvData)
{
    LOG_DEBUG("network", "CMSG_LEARN_PREVIEW_TALENTS_PET");

    ObjectGuid guid;
    recvData >> guid;

    uint32 talentsCount;
    recvData >> talentsCount;

    uint32 talentId, talentRank;

    // Client has max 24 talents, rounded up : 30
    uint32 const MaxTalentsCount = 30;

    for (uint32 i = 0; i < talentsCount && i < MaxTalentsCount; ++i)
    {
        recvData >> talentId >> talentRank;

        _player->LearnPetTalent(guid, talentId, talentRank);
    }

    _player->SendTalentsInfoData(true);

    recvData.rfinish();
}
