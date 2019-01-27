/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "SpellMgr.h"
#include "Log.h"
#include "Opcodes.h"
#include "Spell.h"
#include "ObjectAccessor.h"
#include "CreatureAI.h"
#include "Util.h"
#include "Pet.h"
#include "World.h"
#include "Group.h"
#include "SpellInfo.h"
#include "Player.h"
#include "Chat.h"

class LoadPetFromDBQueryHolder : public SQLQueryHolder
{
    private:
        const uint32 m_petNumber;
        const bool   m_current;
        const uint32 m_diffTime;
        const std::string m_actionBar;
        const uint32 m_savedHealth;
        const uint32 m_savedMana;

    public:
        LoadPetFromDBQueryHolder(uint32 petNumber, bool current, uint32 diffTime, std::string actionBar, uint32 health, uint32 mana)
            : m_petNumber(petNumber), m_current(current), m_diffTime(diffTime), m_actionBar(actionBar),
              m_savedHealth(health), m_savedMana(mana) { }

        uint32 GetPetNumber() const { return m_petNumber; }
        uint32 GetDiffTime() const { return m_diffTime; }
        bool  GetCurrent() const { return m_current; }
        uint32 GetSavedHealth() const { return m_savedHealth; }
        uint32 GetSavedMana() const { return m_savedMana; }
        std::string GetActionBar() const { return m_actionBar; }
        bool Initialize();
};

bool LoadPetFromDBQueryHolder::Initialize()
{
    SetSize(MAX_PET_LOAD_QUERY);

    bool res = true;
    PreparedStatement* stmt = NULL;

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_AURA);
    stmt->setUInt32(0, m_petNumber);
    res &= SetPreparedQuery(PET_LOAD_QUERY_LOADAURAS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_SPELL);
    stmt->setUInt32(0, m_petNumber);
    res &= SetPreparedQuery(PET_LOAD_QUERY_LOADSPELLS, stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PET_SPELL_COOLDOWN);
    stmt->setUInt32(0, m_petNumber);
    res &= SetPreparedQuery(PET_LOAD_QUERY_LOADSPELLCOOLDOWN, stmt);

    return res;
}

uint8 WorldSession::HandleLoadPetFromDBFirstCallback(PreparedQueryResult result, uint8 asynchLoadType)
{
    if (!GetPlayer() || GetPlayer()->GetPet() || GetPlayer()->GetVehicle() || GetPlayer()->IsSpectator())
        return PET_LOAD_ERROR;

    if (!result)
        return PET_LOAD_NO_RESULT;

    Field* fields = result->Fetch();

    // Xinef: this can happen if fetch is called twice, impossibru.
    if (!fields)
        return PET_LOAD_ERROR;

    Player* owner = GetPlayer();

    // update for case of current pet "slot = 0"
    uint32 petentry = fields[1].GetUInt32();
    if (!petentry)
        return PET_LOAD_NO_RESULT;

    uint8 petSlot = fields[7].GetUInt8();
    bool current = petSlot == PET_SAVE_AS_CURRENT;
    uint32 summon_spell_id = fields[15].GetUInt32();
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(summon_spell_id); // CANT BE NULL
    bool is_temporary_summoned = spellInfo && spellInfo->GetDuration() > 0;
    uint32 pet_number = fields[0].GetUInt32();
    uint32 savedhealth = fields[10].GetUInt32();
    uint32 savedmana = fields[11].GetUInt32();
    PetType pet_type = PetType(fields[16].GetUInt8());

    // xinef: BG resurrect, overwrite saved value
    if (asynchLoadType == PET_LOAD_BG_RESURRECT)
        savedhealth = 1;

    if (pet_type == HUNTER_PET && savedhealth == 0 && asynchLoadType != PET_LOAD_SUMMON_DEAD_PET)
    {
        WorldPacket data(SMSG_CAST_FAILED, 1+4+1+4);
        data << uint8(0);
        data << uint32(883);
        data << uint8(SPELL_FAILED_TARGETS_DEAD);
        SendPacket(&data);
        owner->RemoveSpellCooldown(883, false);
        return PET_LOAD_ERROR;
    }

    // check temporary summoned pets like mage water elemental
    if (current && is_temporary_summoned)
        return PET_LOAD_ERROR;

    if (pet_type == HUNTER_PET)
    {
        CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(petentry);
        if (!creatureInfo || !creatureInfo->IsTameable(owner->CanTameExoticPets()))
            return PET_LOAD_ERROR;
    }

    Map* map = owner->GetMap();
    uint32 guid = sObjectMgr->GenerateLowGuid(HIGHGUID_PET);
    Pet* pet = new Pet(owner, pet_type);
    LoadPetFromDBQueryHolder* holder = new LoadPetFromDBQueryHolder(pet_number, current, uint32(time(NULL) - fields[14].GetUInt32()), fields[13].GetString(), savedhealth, savedmana);
    if (!pet->Create(guid, map, owner->GetPhaseMask(), petentry, pet_number) || !holder->Initialize())
    {
        delete pet;
        delete holder;
        return PET_LOAD_ERROR;
    }

    float px, py, pz;
    owner->GetClosePoint(px, py, pz, pet->GetCombatReach(), PET_FOLLOW_DIST, pet->GetFollowAngle());
    if (!pet->IsPositionValid())
    {
        sLog->outError("Pet (guidlow %d, entry %d) not loaded. Suggested coordinates isn't valid (X: %f Y: %f)", pet->GetGUIDLow(), pet->GetEntry(), pet->GetPositionX(), pet->GetPositionY());
        delete pet;
        delete holder;
        return PET_LOAD_ERROR;
    }

    pet->SetLoading(true);
    pet->Relocate(px, py, pz, owner->GetOrientation());
    pet->setPetType(pet_type);
    pet->setFaction(owner->getFaction());
    pet->SetUInt32Value(UNIT_CREATED_BY_SPELL, summon_spell_id);

    if (pet->IsCritter())
    {
        map->AddToMap(pet->ToCreature(), true);
        pet->SetLoading(false); // xinef, mine
        delete holder;
        return PET_LOAD_OK;
    }

    pet->GetCharmInfo()->SetPetNumber(pet_number, pet->IsPermanentPetFor(owner));

    pet->SetDisplayId(fields[3].GetUInt32());
    pet->SetNativeDisplayId(fields[3].GetUInt32());
    uint32 petlevel = fields[4].GetUInt16();
    pet->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
    pet->SetName(fields[8].GetString());

    switch (pet->getPetType())
    {
        case SUMMON_PET:
            petlevel = owner->getLevel();

            if (pet->IsPetGhoul())
                pet->SetUInt32Value(UNIT_FIELD_BYTES_0, 0x400); // class = rogue
            else
                pet->SetUInt32Value(UNIT_FIELD_BYTES_0, 0x800); // class = mage

            pet->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
                                                            // this enables popup window (pet dismiss, cancel)
            break;
        case HUNTER_PET:
            pet->SetUInt32Value(UNIT_FIELD_BYTES_0, 0x02020100); // class = warrior, gender = none, power = focus
            pet->SetSheath(SHEATH_STATE_MELEE);
            pet->SetByteFlag(UNIT_FIELD_BYTES_2, 2, fields[9].GetBool() ? UNIT_CAN_BE_ABANDONED : UNIT_CAN_BE_RENAMED | UNIT_CAN_BE_ABANDONED);

            pet->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
                                                            // this enables popup window (pet abandon, cancel)
            pet->SetMaxPower(POWER_HAPPINESS, pet->GetCreatePowers(POWER_HAPPINESS));
            pet->SetPower(POWER_HAPPINESS, fields[12].GetUInt32());
            pet->setPowerType(POWER_FOCUS);
            break;
        default:
            if (!pet->IsPetGhoul())
                sLog->outError("Pet have incorrect type (%u) for pet loading.", pet->getPetType());
            break;
    }

    pet->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, uint32(time(NULL))); // cast can't be helped here
    pet->SetCreatorGUID(owner->GetGUID());
    owner->SetMinion(pet, true);

    pet->InitStatsForLevel(petlevel);
    pet->SetUInt32Value(UNIT_FIELD_PETEXPERIENCE, fields[5].GetUInt32());

    pet->SynchronizeLevelWithOwner();

    pet->SetReactState(ReactStates(fields[6].GetUInt8()));
    pet->SetCanModifyStats(true);

    // set current pet as current
    // 0=current
    // 1..MAX_PET_STABLES in stable slot
    // PET_SAVE_NOT_IN_SLOT(100) = not stable slot (summoning))
    if (petSlot)
    {
        SQLTransaction trans = CharacterDatabase.BeginTransaction();

        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UDP_CHAR_PET_SLOT_BY_SLOT_EXCLUDE_ID);
        stmt->setUInt8(0, uint8(PET_SAVE_NOT_IN_SLOT));
        stmt->setUInt32(1, owner->GetGUIDLow());
        stmt->setUInt8(2, uint8(PET_SAVE_AS_CURRENT));
        stmt->setUInt32(3, pet_number);
        trans->Append(stmt);

        stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
        stmt->setUInt8(0, uint8(PET_SAVE_AS_CURRENT));
        stmt->setUInt32(1, owner->GetGUIDLow());
        stmt->setUInt32(2, pet_number);
        trans->Append(stmt);

        CharacterDatabase.CommitTransaction(trans);
    }

    // Send fake summon spell cast - this is needed for correct cooldown application for spells
    // Example: 46584 - without this cooldown (which should be set always when pet is loaded) isn't set clientside
    // TODO: pets should be summoned from real cast instead of just faking it?
    if (summon_spell_id)
    {
        WorldPacket data(SMSG_SPELL_GO, (8+8+4+4+2));
        data.append(owner->GetPackGUID());
        data.append(owner->GetPackGUID());
        data << uint8(0);
        data << uint32(summon_spell_id);
        data << uint32(256); // CAST_FLAG_UNKNOWN3
        data << uint32(0);
        owner->SendMessageToSet(&data, true);
    }

    // do it as early as possible!
    pet->InitTalentForLevel();                                   // set original talents points before spell loading
    if (!is_temporary_summoned)
        pet->GetCharmInfo()->InitPetActionBar();

    map->AddToMap(pet->ToCreature(), true);
    if (pet->getPetType() == SUMMON_PET && !current)              //all (?) summon pets come with full health when called, but not when they are current
        pet->SetPower(POWER_MANA, pet->GetMaxPower(POWER_MANA));
    else
    {
        pet->SetHealth(savedhealth > pet->GetMaxHealth() ? pet->GetMaxHealth() : savedhealth);
        pet->SetPower(POWER_MANA, savedmana > pet->GetMaxPower(POWER_MANA) ? pet->GetMaxPower(POWER_MANA) : savedmana);
    }

    pet->SetAsynchLoadType(asynchLoadType);

    // xinef: clear any old result
    if (_loadPetFromDBSecondCallback.ready())
    {
        SQLQueryHolder* param;
        _loadPetFromDBSecondCallback.get(param);
        delete param;
    }
    _loadPetFromDBSecondCallback.cancel();

    _loadPetFromDBSecondCallback = CharacterDatabase.DelayQueryHolder((SQLQueryHolder*)holder);
    return PET_LOAD_OK;
}

void WorldSession::HandleLoadPetFromDBSecondCallback(LoadPetFromDBQueryHolder* holder)
{
    if (!GetPlayer())
        return;

    Player* owner = GetPlayer();
    Pet* pet = owner->GetPet();
    if (!pet)
        return;

    pet->_LoadAuras(holder->GetPreparedResult(PET_LOAD_QUERY_LOADAURAS), holder->GetDiffTime());
    bool current = holder->GetCurrent();
    uint32 summon_spell_id = pet->GetUInt32Value(UNIT_CREATED_BY_SPELL);
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(summon_spell_id); // CANT BE NULL
    bool is_temporary_summoned = spellInfo && spellInfo->GetDuration() > 0;

    // load action bar, if data broken will fill later by default spells.
    if (!is_temporary_summoned)
    {
        pet->_LoadSpells(holder->GetPreparedResult(PET_LOAD_QUERY_LOADSPELLS));
        pet->InitTalentForLevel();                               // re-init to check talent count
        pet->_LoadSpellCooldowns(holder->GetPreparedResult(PET_LOAD_QUERY_LOADSPELLCOOLDOWN));
        pet->LearnPetPassives();
        pet->InitLevelupSpellsForLevel();
        pet->CastPetAuras(current);

        pet->GetCharmInfo()->LoadPetActionBar(holder->GetActionBar()); // action bar stored in already read string
    }

    pet->CleanupActionBar();                                     // remove unknown spells from action bar after load
    owner->PetSpellInitialize();
    owner->SendTalentsInfoData(true);
    if (owner->GetGroup())
        owner->SetGroupUpdateFlag(GROUP_UPDATE_PET);

    //set last used pet number (for use in BG's)
    if (owner->GetTypeId() == TYPEID_PLAYER && pet->isControlled() && !pet->isTemporarySummoned() && (pet->getPetType() == SUMMON_PET || pet->getPetType() == HUNTER_PET))
    {
        owner->ToPlayer()->SetLastPetNumber(holder->GetPetNumber());
        owner->SetLastPetSpell(pet->GetUInt32Value(UNIT_CREATED_BY_SPELL));
    }

    if (pet->getPetType() == SUMMON_PET && !current)              //all (?) summon pets come with full health when called, but not when they are current
    {
        pet->SetPower(POWER_MANA, pet->GetMaxPower(POWER_MANA));
        pet->SetHealth(pet->GetMaxHealth());
    }
    else
    {
        if (!holder->GetSavedHealth() && pet->getPetType() == HUNTER_PET && pet->GetAsynchLoadType() != PET_LOAD_SUMMON_DEAD_PET)
            pet->setDeathState(JUST_DIED);
        else
        {
            pet->SetHealth(holder->GetSavedHealth() > pet->GetMaxHealth() ? pet->GetMaxHealth() : holder->GetSavedHealth());
            pet->SetPower(POWER_MANA, holder->GetSavedMana() > pet->GetMaxPower(POWER_MANA) ? pet->GetMaxPower(POWER_MANA) : holder->GetSavedMana());
        }
    }

    pet->SetLoading(false);
    owner->SetTemporaryUnsummonedPetNumber(0); // clear this only if pet is loaded successfuly

    // current
    if (current && owner->IsPetNeedBeTemporaryUnsummoned())
    {
        owner->UnsummonPetTemporaryIfAny();
        return;
    }

    pet->HandleAsynchLoadSucceed();
    return;
}

void WorldSession::HandleDismissCritter(WorldPacket &recvData)
{
    uint64 guid;
    recvData >> guid;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_DISMISS_CRITTER for GUID " UI64FMTD, guid);
#endif

    Unit* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, guid);

    if (!pet)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "Vanitypet (guid: %u) does not exist - player '%s' (guid: %u / account: %u) attempted to dismiss it (possibly lagged out)", uint32(GUID_LOPART(guid)), GetPlayer()->GetName().c_str(), GetPlayer()->GetGUIDLow(), GetAccountId());
#endif
        return;
    }

    if (_player->GetCritterGUID() == pet->GetGUID())
    {
         if (pet->GetTypeId() == TYPEID_UNIT && pet->ToCreature()->IsSummon())
             pet->ToTempSummon()->UnSummon();
    }
}

void WorldSession::HandlePetAction(WorldPacket & recvData)
{
    uint64 guid1;
    uint32 data;
    uint64 guid2;
    recvData >> guid1;                                     //pet guid
    recvData >> data;
    recvData >> guid2;                                     //tag guid

    uint32 spellid = UNIT_ACTION_BUTTON_ACTION(data);
    uint8 flag = UNIT_ACTION_BUTTON_TYPE(data);             //delete = 0x07 CastSpell = C1

    // used also for charmed creature
    Unit* pet= ObjectAccessor::GetUnit(*_player, guid1);
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDetail("HandlePetAction: Pet %u - flag: %u, spellid: %u, target: %u.", uint32(GUID_LOPART(guid1)), uint32(flag), spellid, uint32(GUID_LOPART(guid2)));
#endif

    if (!pet)
    {
        sLog->outError("HandlePetAction: Pet (GUID: %u) doesn't exist for player '%s'", uint32(GUID_LOPART(guid1)), GetPlayer()->GetName().c_str());
        return;
    }

    if (pet != GetPlayer()->GetFirstControlled())
    {
        sLog->outError("HandlePetAction: Pet (GUID: %u) does not belong to player '%s'", uint32(GUID_LOPART(guid1)), GetPlayer()->GetName().c_str());
        return;
    }

    if (!pet->IsAlive())
    {
        // xinef: allow dissmis dead pets
        SpellInfo const* spell = (flag == ACT_ENABLED || flag == ACT_PASSIVE) ? sSpellMgr->GetSpellInfo(spellid) : NULL;
        if ((flag != ACT_COMMAND || spellid != COMMAND_ABANDON) && (!spell || !spell->HasAttribute(SPELL_ATTR0_CASTABLE_WHILE_DEAD)))
            return;
    }

    // Xinef: allow to controll players
    if (pet->GetTypeId() == TYPEID_PLAYER && flag != ACT_COMMAND && flag != ACT_REACTION)
        return;

    if (GetPlayer()->m_Controlled.size() == 1)
        HandlePetActionHelper(pet, guid1, spellid, flag, guid2);
    else
    {
        //If a pet is dismissed, m_Controlled will change
        std::vector<Unit*> controlled;
        for (Unit::ControlSet::iterator itr = GetPlayer()->m_Controlled.begin(); itr != GetPlayer()->m_Controlled.end(); ++itr)
        {
            // xinef: allow to dissmis dead pets
            if ((*itr)->GetEntry() == pet->GetEntry() && ((*itr)->IsAlive() || (flag == ACT_COMMAND && spellid == COMMAND_ABANDON)))
                controlled.push_back(*itr);
            // xinef: mirror image blizzard crappness
            else if ((*itr)->GetEntry() == NPC_MIRROR_IMAGE && flag == ACT_COMMAND && spellid == COMMAND_FOLLOW)
            {
                (*itr)->InterruptNonMeleeSpells(false);
            }
        }

        for (std::vector<Unit*>::iterator itr = controlled.begin(); itr != controlled.end(); ++itr)
            HandlePetActionHelper(*itr, guid1, spellid, flag, guid2);
    }
}

void WorldSession::HandlePetStopAttack(WorldPacket &recvData)
{
    uint64 guid;
    recvData >> guid;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: Received CMSG_PET_STOP_ATTACK for GUID " UI64FMTD "", guid);
#endif

    Unit* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, guid);

    if (!pet)
    {
        sLog->outError("HandlePetStopAttack: Pet %u does not exist", uint32(GUID_LOPART(guid)));
        return;
    }

    if (pet != GetPlayer()->GetPet() && pet != GetPlayer()->GetCharm())
    {
        sLog->outError("HandlePetStopAttack: Pet GUID %u isn't a pet or charmed creature of player %s", uint32(GUID_LOPART(guid)), GetPlayer()->GetName().c_str());
        return;
    }

    if (!pet->IsAlive())
        return;

    pet->AttackStop();
    pet->ClearInPetCombat();
}

void WorldSession::HandlePetActionHelper(Unit* pet, uint64 guid1, uint16 spellid, uint16 flag, uint64 guid2)
{
    CharmInfo* charmInfo = pet->GetCharmInfo();
    if (!charmInfo)
    {
        sLog->outError("WorldSession::HandlePetAction(petGuid: " UI64FMTD ", tagGuid: " UI64FMTD ", spellId: %u, flag: %u): object (entry: %u TypeId: %u) is considered pet-like but doesn't have a charminfo!",
            guid1, guid2, spellid, flag, pet->GetGUIDLow(), pet->GetTypeId());
        return;
    }

    switch (flag)
    {
        case ACT_COMMAND:                                   //0x07
            switch (spellid)
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
                    charmInfo->SetForcedTargetGUID(0);
                    break;
                }
                case COMMAND_FOLLOW:                        //spellid=1792  //FOLLOW
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
                    charmInfo->SetForcedTargetGUID(0);
                    break;
                }
                case COMMAND_ATTACK:                        //spellid=1792  //ATTACK
                {
                    // Can't attack if owner is pacified
                    if (_player->HasAuraType(SPELL_AURA_MOD_PACIFY))
                    {
                        //pet->SendPetCastFail(spellid, SPELL_FAILED_PACIFIED);
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

                    // pussywizard:
                    if (Creature* creaturePet = pet->ToCreature())
                        if (!creaturePet->_CanDetectFeignDeathOf(TargetUnit) || !creaturePet->CanCreatureAttack(TargetUnit) || creaturePet->isTargetNotAcceptableByMMaps(TargetUnit->GetGUID(), sWorld->GetGameTime(), TargetUnit))
                            return;

                    // Not let attack through obstructions
                    bool checkLos = !MMAP::MMapFactory::IsPathfindingEnabled(pet->GetMap()) || 
                                    (TargetUnit->GetTypeId() == TYPEID_UNIT && (TargetUnit->ToCreature()->isWorldBoss() || TargetUnit->ToCreature()->IsDungeonBoss()));

                    if (checkLos && !pet->IsWithinLOSInMap(TargetUnit))
                    {
                        WorldPacket data(SMSG_CAST_FAILED, 1+4+1);
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

                        if (pet->GetTypeId() != TYPEID_PLAYER && pet->ToCreature()->IsAIEnabled)
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
                        if (pet->IsSummon())
                            pet->ToTempSummon()->UnSummon();
                        else
                            _player->StopCastingCharm();
                    }
                    else if (pet->GetOwnerGUID() == GetPlayer()->GetGUID())
                    {
                        ASSERT(pet->GetTypeId() == TYPEID_UNIT);
                        if (pet->IsPet())
                        {
                            if (pet->ToPet()->getPetType() == HUNTER_PET)
                                GetPlayer()->RemovePet(pet->ToPet(), PET_SAVE_AS_DELETED);
                            else
                                //dismissing a summoned pet is like killing them (this prevents returning a soulshard...)
                                pet->setDeathState(CORPSE);
                        }
                        else if (pet->HasUnitTypeMask(UNIT_MASK_MINION|UNIT_MASK_SUMMON|UNIT_MASK_GUARDIAN|UNIT_MASK_CONTROLABLE_GUARDIAN))
                        {
                            pet->ToTempSummon()->UnSummon();
                        }
                    }
                    break;
                default:
                    sLog->outError("WORLD: unknown PET flag Action %i and spellid %i.", uint32(flag), spellid);
            }
            break;
        case ACT_REACTION:                                  // 0x6
            switch (spellid)
            {
                case REACT_PASSIVE:                         //passive
                    pet->AttackStop();
                    if (pet->ToPet())
                        pet->ToPet()->ClearCastWhenWillAvailable();
                    pet->ClearInPetCombat();

                case REACT_DEFENSIVE:                       //recovery
                case REACT_AGGRESSIVE:                      //activete
                    if (pet->GetTypeId() == TYPEID_UNIT)
                        pet->ToCreature()->SetReactState(ReactStates(spellid));
                    else
                        charmInfo->SetPlayerReactState(ReactStates(spellid));
                    break;
            }
            break;
        case ACT_DISABLED:                                  // 0x81    spell (disabled), ignore
        case ACT_PASSIVE:                                   // 0x01
        case ACT_ENABLED:                                   // 0xC1    spell
        {
            Unit* unit_target = NULL;

            // do not cast unknown spells
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellid);
            if (!spellInfo)
            {
                sLog->outError("WORLD: unknown PET spell id %i", spellid);
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

            // do not cast not learned spells
            if (!pet->HasSpell(spellid) || spellInfo->IsPassive())
                return;

            //  Clear the flags as if owner clicked 'attack'. AI will reset them
            //  after AttackStart, even if spell failed
            charmInfo->SetIsAtStay(false);
            charmInfo->SetIsCommandAttack(!pet->ToCreature()->HasReactState(REACT_PASSIVE));
            charmInfo->SetIsReturning(false);
            charmInfo->SetIsFollowing(false);

            Spell* spell = new Spell(pet, spellInfo, TRIGGERED_NONE);
            spell->LoadScripts(); // xinef: load for CheckPetCast

            SpellCastResult result = spell->CheckPetCast(unit_target);

            //auto turn to target unless possessed
            if (result == SPELL_FAILED_UNIT_NOT_INFRONT && !pet->isPossessed() && !pet->IsVehicle())
            {
                if (unit_target)
                {
                    pet->SetInFront(unit_target);
                    if (unit_target->GetTypeId() == TYPEID_PLAYER)
                        pet->SendUpdateToPlayer(unit_target->ToPlayer());
                }
                else if (Unit* unit_target2 = spell->m_targets.GetUnitTarget())
                {
                    pet->SetInFront(unit_target2);
                    if (unit_target2->GetTypeId() == TYPEID_PLAYER)
                        pet->SendUpdateToPlayer(unit_target2->ToPlayer());
                }
                if (Unit* powner = pet->GetCharmerOrOwner())
                    if (powner->GetTypeId() == TYPEID_PLAYER)
                        pet->SendUpdateToPlayer(powner->ToPlayer());

                result = SPELL_CAST_OK;
            }

            if (result == SPELL_CAST_OK)
            {
                pet->ToCreature()->AddSpellCooldown(spellid, 0, 0);

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
                charmInfo->SetForcedTargetGUID(0);
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

                if (!pet->HasSpellCooldown(spellid))
                    if(pet->ToPet())
                        pet->ToPet()->RemoveSpellCooldown(spellid, true);

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

                        if (pet->GetTypeId() != TYPEID_PLAYER && pet->ToCreature() && pet->ToCreature()->IsAIEnabled)
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

                        pet->ToPet()->CastWhenWillAvailable(spellid, unit_target, NULL, tempspellIsPositive);
                    }
                }
                else if (haspositiveeffect)
                {
                    bool tempspellIsPositive = true;
                    pet->ClearUnitState(UNIT_STATE_FOLLOW);
                    // This is true if pet has no target or has target but targets differs.
                    Unit* victim = pet->GetVictim();
                    if (victim)
                    {
                        pet->AttackStop();
                    }
                    else
                        victim = NULL;

                    if (pet->GetTypeId() != TYPEID_PLAYER && pet->ToCreature() && pet->ToCreature()->IsAIEnabled)
                    {
                        pet->StopMoving();
                        pet->GetMotionMaster()->Clear();

                        charmInfo->SetIsCommandAttack(false);
                        charmInfo->SetIsAtStay(false);
                        charmInfo->SetIsFollowing(false);
                        charmInfo->SetIsCommandFollow(false);
                        charmInfo->SetIsReturning(false);

                        pet->GetMotionMaster()->MoveChase(unit_target);

                        if (pet->IsPet() && ((Pet*)pet)->getPetType() == SUMMON_PET && pet != unit_target && urand(0, 100) < 10)
                            pet->SendPetTalk((uint32)PET_TALK_SPECIAL_SPELL);
                        else
                        {
                            pet->SendPetAIReaction(guid1);
                        }

                        pet->ToPet()->CastWhenWillAvailable(spellid, unit_target, victim, tempspellIsPositive);
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

                if (!pet->ToCreature()->HasSpellCooldown(spellid))
                    GetPlayer()->SendClearCooldown(spellid, pet);

                spell->finish(false);
                delete spell;

                // reset specific flags in case of spell fail. AI will reset other flags
                pet->PetSpellFail(spellInfo, unit_target, result);
            }
            break;
        }
        default:
            sLog->outError("WORLD: unknown PET flag Action %i and spellid %i.", uint32(flag), spellid);
    }
}

void WorldSession::HandlePetNameQuery(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDetail("HandlePetNameQuery. CMSG_PET_NAME_QUERY");
#endif

    uint32 petnumber;
    uint64 petguid;

    recvData >> petnumber;
    recvData >> petguid;

    SendPetNameQuery(petguid, petnumber);
}

void WorldSession::SendPetNameQuery(uint64 petguid, uint32 petnumber)
{
    Creature* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, petguid);
    if (!pet)
    {
        WorldPacket data(SMSG_PET_NAME_QUERY_RESPONSE, (4+1+4+1));
        data << uint32(petnumber);
        data << uint8(0);
        data << uint32(0);
        data << uint8(0);
        SendPacket(&data);
        return;
    }

    std::string name = pet->GetName();

    WorldPacket data(SMSG_PET_NAME_QUERY_RESPONSE, (4+4+name.size()+1));
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

bool WorldSession::CheckStableMaster(uint64 guid)
{
    // spell case or GM
    if (guid == GetPlayer()->GetGUID())
    {
        if (!GetPlayer()->IsGameMaster() && !GetPlayer()->HasAuraType(SPELL_AURA_OPEN_STABLE))
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outStaticDebug("Player (GUID:%u) attempt open stable in cheating way.", GUID_LOPART(guid));
#endif
            return false;
        }
    }
    // stable master case
    else
    {
        if (!GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_STABLEMASTER))
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outStaticDebug("Stablemaster (GUID:%u) not found or you can't interact with him.", GUID_LOPART(guid));
#endif
            return false;
        }
    }
    return true;
}

void WorldSession::HandlePetSetAction(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDetail("HandlePetSetAction. CMSG_PET_SET_ACTION");
#endif

    uint64 petguid;
    uint8  count;

    recvData >> petguid;

    Unit* checkPet = ObjectAccessor::GetUnit(*_player, petguid);
    if (!checkPet || checkPet != _player->GetFirstControlled())
    {
        sLog->outError("HandlePetSetAction: Unknown pet (GUID: %u) or pet owner (GUID: %u)", GUID_LOPART(petguid), _player->GetGUIDLow());
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
    if (checkPet->GetEntry() != GUID_ENPART(petguid))
        petsSet.insert(checkPet);
    else
        petsSet = _player->m_Controlled;

    // Xinef: loop all pets with same entry (fixes partial state change for feral spirits)
    for (Unit::ControlSet::const_iterator itr = petsSet.begin(); itr != petsSet.end(); ++itr)
    {
        Unit* pet = *itr;
        if (checkPet->GetEntry() == GUID_ENPART(petguid) && pet->GetEntry() != GUID_ENPART(petguid))
            continue;

        CharmInfo* charmInfo = pet->GetCharmInfo();
        if (!charmInfo)
        {
            sLog->outError("WorldSession::HandlePetSetAction: object (GUID: %u TypeId: %u) is considered pet-like but doesn't have a charminfo!", pet->GetGUIDLow(), pet->GetTypeId());
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
                        if (pet->GetTypeId() == TYPEID_UNIT && pet->IsPet())
                            ((Pet*)pet)->ToggleAutocast(spellInfo, true);
                        else
                            for (Unit::ControlSet::iterator itr = GetPlayer()->m_Controlled.begin(); itr != GetPlayer()->m_Controlled.end(); ++itr)
                                if ((*itr)->GetEntry() == pet->GetEntry())
                                    (*itr)->GetCharmInfo()->ToggleCreatureAutocast(spellInfo, true);
                    }
                    //sign for no/turn off autocast
                    else if (act_state == ACT_DISABLED)
                    {
                        if (pet->GetTypeId() == TYPEID_UNIT && pet->IsPet())
                            ((Pet*)pet)->ToggleAutocast(spellInfo, false);
                        else
                            for (Unit::ControlSet::iterator itr = GetPlayer()->m_Controlled.begin(); itr != GetPlayer()->m_Controlled.end(); ++itr)
                                if ((*itr)->GetEntry() == pet->GetEntry())
                                    (*itr)->GetCharmInfo()->ToggleCreatureAutocast(spellInfo, false);
                    }
                }

                charmInfo->SetActionBar(position[i], spell_id, ActiveStates(act_state));
            }
        }
    }
}

void WorldSession::HandlePetRename(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDetail("HandlePetRename. CMSG_PET_RENAME");
#endif

    uint64 petguid;
    uint8 isdeclined;

    std::string name;
    DeclinedName declinedname;

    recvData >> petguid;
    recvData >> name;
    recvData >> isdeclined;

    Pet* pet = ObjectAccessor::FindPet(petguid);
                                                            // check it!
    if (!pet || !pet->IsPet() || ((Pet*)pet)->getPetType()!= HUNTER_PET ||
        !pet->HasByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED) ||
        pet->GetOwnerGUID() != _player->GetGUID() || !pet->GetCharmInfo())
        return;

    PetNameInvalidReason res = ObjectMgr::CheckPetName(name);
    if (res != PET_NAME_SUCCESS)
    {
        SendPetNameInvalid(res, name, NULL);
        return;
    }

    if (sObjectMgr->IsReservedName(name))
    {
        SendPetNameInvalid(PET_NAME_RESERVED, name, NULL);
        return;
    }

    pet->SetName(name);

    Unit* owner = pet->GetOwner();
    if (owner && (owner->GetTypeId() == TYPEID_PLAYER) && owner->ToPlayer()->GetGroup())
        owner->ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_NAME);

    pet->RemoveByteFlag(UNIT_FIELD_BYTES_2, 2, UNIT_CAN_BE_RENAMED);

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

    SQLTransaction trans = CharacterDatabase.BeginTransaction();
    if (isdeclined)
    {
        if (sWorld->getBoolConfig(CONFIG_DECLINED_NAMES_USED))
        {
            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME);
            stmt->setUInt32(0, pet->GetCharmInfo()->GetPetNumber());
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_ADD_CHAR_PET_DECLINEDNAME);
            stmt->setUInt32(0, _player->GetGUIDLow());

            for (uint8 i = 0; i < 5; i++)
                stmt->setString(i+1, declinedname.name[i]);

            trans->Append(stmt);
        }
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_NAME);
    stmt->setString(0, name);
    stmt->setUInt32(1, _player->GetGUIDLow());
    stmt->setUInt32(2, pet->GetCharmInfo()->GetPetNumber());
    trans->Append(stmt);

    CharacterDatabase.CommitTransaction(trans);

    pet->SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, uint32(time(NULL))); // cast can't be helped
}

void WorldSession::HandlePetAbandon(WorldPacket & recvData)
{
    uint64 guid;
    recvData >> guid;                                      //pet guid
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDetail("HandlePetAbandon. CMSG_PET_ABANDON pet guid is %u", GUID_LOPART(guid));
#endif

    if (!_player->IsInWorld())
        return;

    // pet/charmed
    Creature* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, guid);
    if (pet && pet->ToPet() && pet->ToPet()->getPetType() == HUNTER_PET)
    {
        if (pet->IsPet())
        {
            if (pet->GetGUID() == _player->GetPetGUID())
            {
                uint32 feelty = pet->GetPower(POWER_HAPPINESS);
                pet->SetPower(POWER_HAPPINESS, feelty > 50000 ? (feelty-50000) : 0);
            }

            _player->RemovePet((Pet*)pet, PET_SAVE_AS_DELETED);
        }
        else if (pet->GetGUID() == _player->GetCharmGUID())
            _player->StopCastingCharm();
    }
}

void WorldSession::HandlePetSpellAutocastOpcode(WorldPacket& recvPacket)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDetail("CMSG_PET_SPELL_AUTOCAST");
#endif
    uint64 guid;
    uint32 spellid;
    uint8  state;                                           //1 for on, 0 for off
    recvPacket >> guid >> spellid >> state;

    if (!_player->GetGuardianPet() && !_player->GetCharm())
        return;

    if (IS_PLAYER_GUID(guid))
        return;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellid);
    if (!spellInfo)
        return;

    Creature* checkPet = ObjectAccessor::GetCreatureOrPetOrVehicle(*_player, guid);
    if (!checkPet || (checkPet != _player->GetGuardianPet() && checkPet != _player->GetCharm()))
    {
        sLog->outError("HandlePetSpellAutocastOpcode.Pet %u isn't pet of player %s .", uint32(GUID_LOPART(guid)), GetPlayer()->GetName().c_str());
        return;
    }

    Unit::ControlSet petsSet;
    if (checkPet->GetEntry() != GUID_ENPART(guid))
        petsSet.insert(checkPet);
    else
        petsSet = _player->m_Controlled;

    // Xinef: loop all pets with same entry (fixes partial state change for feral spirits)
    for (Unit::ControlSet::const_iterator itr = petsSet.begin(); itr != petsSet.end(); ++itr)
    {
        Unit* pet = *itr;
        if (checkPet->GetEntry() == GUID_ENPART(guid) && pet->GetEntry() != GUID_ENPART(guid))
            continue;

        // do not add not learned spells/ passive spells
        if (!pet->HasSpell(spellid) || !spellInfo->IsAutocastable())
            continue;

        CharmInfo* charmInfo = pet->GetCharmInfo();
        if (!charmInfo)
        {
            sLog->outError("WorldSession::HandlePetSpellAutocastOpcod: object (GUID: %u TypeId: %u) is considered pet-like but doesn't have a charminfo!", pet->GetGUIDLow(), pet->GetTypeId());
            continue;
        }

        if (pet->IsPet())
            ((Pet*)pet)->ToggleAutocast(spellInfo, state);
        else
            pet->GetCharmInfo()->ToggleCreatureAutocast(spellInfo, state);

        charmInfo->SetSpellAutocast(spellInfo, state);
    }
}

void WorldSession::HandlePetCastSpellOpcode(WorldPacket& recvPacket)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: CMSG_PET_CAST_SPELL");
#endif

    uint64 guid;
    uint8  castCount;
    uint32 spellId;
    uint8  castFlags;

    recvPacket >> guid >> castCount >> spellId >> castFlags;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: CMSG_PET_CAST_SPELL, guid: " UI64FMTD ", castCount: %u, spellId %u, castFlags %u", guid, castCount, spellId, castFlags);
#endif

    // This opcode is also sent from charmed and possessed units (players and creatures)
    if (!_player->GetGuardianPet() && !_player->GetCharm())
        return;

    Unit* caster = ObjectAccessor::GetUnit(*_player, guid);

    if (!caster || (caster != _player->GetGuardianPet() && caster != _player->GetCharm()))
    {
        sLog->outError("HandlePetCastSpellOpcode: Pet %u isn't pet of player %s .", uint32(GUID_LOPART(guid)), GetPlayer()->GetName().c_str());
        return;
    }

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        sLog->outError("WORLD: unknown PET spell id %i", spellId);
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

        if (caster->GetTypeId() == TYPEID_PLAYER)
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

void WorldSession::SendPetNameInvalid(uint32 error, const std::string& name, DeclinedName *declinedName)
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

void WorldSession::HandlePetLearnTalent(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "WORLD: CMSG_PET_LEARN_TALENT");
#endif

    uint64 guid;
    uint32 talent_id, requested_rank;
    recvData >> guid >> talent_id >> requested_rank;

    _player->LearnPetTalent(guid, talent_id, requested_rank);
    _player->SendTalentsInfoData(true);
}

void WorldSession::HandleLearnPreviewTalentsPet(WorldPacket & recvData)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_NETWORKIO, "CMSG_LEARN_PREVIEW_TALENTS_PET");
#endif

    uint64 guid;
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
