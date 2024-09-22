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

#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "GameGraveyard.h"
#include "Language.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "UpdateMask.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include <cmath>

enum StableResultCode
{
    STABLE_ERR_MONEY        = 0x01,                         // "you don't have enough money"
    STABLE_ERR_STABLE       = 0x06,                         // currently used in most fail cases
    STABLE_SUCCESS_STABLE   = 0x08,                         // stable success
    STABLE_SUCCESS_UNSTABLE = 0x09,                         // unstable/swap success
    STABLE_SUCCESS_BUY_SLOT = 0x0A,                         // buy slot success
    STABLE_ERR_EXOTIC       = 0x0C,                         // "you are unable to control exotic creatures"
};

void WorldSession::HandleTabardVendorActivateOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_TABARDDESIGNER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleTabardVendorActivateOpcode - Unit ({}) not found or you can not interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    SendTabardVendorActivate(guid);
}

void WorldSession::SendTabardVendorActivate(ObjectGuid guid)
{
    WorldPacket data(MSG_TABARDVENDOR_ACTIVATE, 8);
    data << guid;
    SendPacket(&data);
}

void WorldSession::SendShowMailBox(ObjectGuid guid)
{
    WorldPacket data(SMSG_SHOW_MAILBOX, 8);
    data << guid;
    SendPacket(&data);
}

void WorldSession::HandleTrainerListOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;

    recvData >> guid;
    SendTrainerList(guid);
}

void WorldSession::SendTrainerList(ObjectGuid guid)
{
    std::string str = GetAcoreString(LANG_NPC_TAINER_HELLO);
    SendTrainerList(guid, str);
}

void WorldSession::SendTrainerList(ObjectGuid guid, const std::string& strTitle)
{
    LOG_DEBUG("network", "WORLD: SendTrainerList");

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_TRAINER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: SendTrainerList - Unit ({}) not found or you can not interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    CreatureTemplate const* ci = unit->GetCreatureTemplate();

    if (!ci)
    {
        LOG_DEBUG("network", "WORLD: SendTrainerList - ({}) NO CREATUREINFO!", guid.ToString());
        return;
    }

    TrainerSpellData const* trainer_spells = unit->GetTrainerSpells();
    if (!trainer_spells)
    {
        LOG_DEBUG("network", "WORLD: SendTrainerList - Training spells not found for creature ({})", guid.ToString());
        return;
    }

    WorldPacket data(SMSG_TRAINER_LIST, 8 + 4 + 4 + trainer_spells->spellList.size() * 38 + strTitle.size() + 1);
    data << guid;
    data << uint32(trainer_spells->trainerType);

    std::size_t count_pos = data.wpos();
    data << uint32(trainer_spells->spellList.size());

    // reputation discount
    float fDiscountMod = _player->GetReputationPriceDiscount(unit);
    bool can_learn_primary_prof = GetPlayer()->GetFreePrimaryProfessionPoints() > 0;

    uint32 count = 0;
    for (TrainerSpellMap::const_iterator itr = trainer_spells->spellList.begin(); itr != trainer_spells->spellList.end(); ++itr)
    {
        TrainerSpell const* tSpell = &itr->second;

        bool valid = true;
        bool primary_prof_first_rank = false;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (!tSpell->learnedSpell[i])
                continue;
            if (!_player->IsSpellFitByClassAndRace(tSpell->learnedSpell[i]))
            {
                valid = false;
                break;
            }
            SpellInfo const* learnedSpellInfo = sSpellMgr->GetSpellInfo(tSpell->learnedSpell[i]);
            if (learnedSpellInfo && learnedSpellInfo->IsPrimaryProfessionFirstRank())
                primary_prof_first_rank = true;
        }

        if (!valid)
            continue;

        if (tSpell->reqSpell && !_player->HasSpell(tSpell->reqSpell))
        {
            continue;
        }

        TrainerSpellState state = _player->GetTrainerSpellState(tSpell);

        data << uint32(tSpell->spell);                      // learned spell (or cast-spell in profession case)
        data << uint8(state == TRAINER_SPELL_GREEN_DISABLED ? TRAINER_SPELL_GREEN : state);
        data << uint32(std::floor(tSpell->spellCost * fDiscountMod));

        data << uint32(primary_prof_first_rank && can_learn_primary_prof ? 1 : 0);
        // primary prof. learn confirmation dialog
        data << uint32(primary_prof_first_rank ? 1 : 0);    // must be equal prev. field to have learn button in enabled state
        data << uint8(tSpell->reqLevel);
        data << uint32(tSpell->reqSkill);
        data << uint32(tSpell->reqSkillValue);
        //prev + req or req + 0
        uint8 maxReq = 0;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (!tSpell->learnedSpell[i])
                continue;
            if (uint32 prevSpellId = sSpellMgr->GetPrevSpellInChain(tSpell->learnedSpell[i]))
            {
                data << uint32(prevSpellId);
                ++maxReq;
            }
            if (maxReq == 3)
                break;
            SpellsRequiringSpellMapBounds spellsRequired = sSpellMgr->GetSpellsRequiredForSpellBounds(tSpell->learnedSpell[i]);
            for (SpellsRequiringSpellMap::const_iterator itr2 = spellsRequired.first; itr2 != spellsRequired.second && maxReq < 3; ++itr2)
            {
                data << uint32(itr2->second);
                ++maxReq;
            }
            if (maxReq == 3)
                break;
        }
        while (maxReq < 3)
        {
            data << uint32(0);
            ++maxReq;
        }

        ++count;
    }

    data << strTitle;

    data.put<uint32>(count_pos, count);
    SendPacket(&data);
}

void WorldSession::HandleTrainerBuySpellOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    uint32 spellId = 0;

    recvData >> guid >> spellId;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_TRAINER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleTrainerBuySpellOpcode - Unit ({}) not found or you can not interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // check present spell in trainer spell list
    TrainerSpellData const* trainer_spells = unit->GetTrainerSpells();
    if (!trainer_spells)
        return;

    // not found, cheat?
    TrainerSpell const* trainer_spell = trainer_spells->Find(spellId);
    if (!trainer_spell)
        return;

    if (trainer_spell->reqSpell && !_player->HasSpell(trainer_spell->reqSpell))
    {
        return;
    }

    // can't be learn, cheat? Or double learn with lags...
    if (_player->GetTrainerSpellState(trainer_spell) != TRAINER_SPELL_GREEN)
        return;

    // apply reputation discount
    uint32 nSpellCost = uint32(std::floor(trainer_spell->spellCost * _player->GetReputationPriceDiscount(unit)));

    // check money requirement
    if (!_player->HasEnoughMoney(nSpellCost))
        return;

    _player->ModifyMoney(-int32(nSpellCost));

    unit->SendPlaySpellVisual(179); // 53 SpellCastDirected
    unit->SendPlaySpellImpact(_player->GetGUID(), 362); // 113 EmoteSalute

    // learn explicitly or cast explicitly
    if (trainer_spell->IsCastable())
        _player->CastSpell(_player, trainer_spell->spell, true);
    else
        _player->learnSpell(spellId);

    WorldPacket data(SMSG_TRAINER_BUY_SUCCEEDED, 12);
    data << guid;
    data << uint32(spellId);                                // should be same as in packet from client
    SendPacket(&data);
}

void WorldSession::HandleGossipHelloOpcode(WorldPacket& recvData)
{
    ObjectGuid guid;
    recvData >> guid;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_NONE);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleGossipHelloOpcode - Unit ({}) not found or you can not interact with him.", guid.ToString());
        return;
    }

    // xinef: check if we have ANY npc flags
    if (unit->GetNpcFlags() == UNIT_NPC_FLAG_NONE)
        return;

    // set faction visible if needed
    if (FactionTemplateEntry const* factionTemplateEntry = sFactionTemplateStore.LookupEntry(unit->GetFaction()))
        _player->GetReputationMgr().SetVisible(factionTemplateEntry);

    GetPlayer()->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TALK);
    // remove fake death
    //if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
    //    GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // Stop the npc if moving
    if (uint32 pause = unit->GetMovementTemplate().GetInteractionPauseTimer())
        unit->PauseMovement(pause);
    unit->SetHomePosition(unit->GetPosition());

    // If spiritguide, no need for gossip menu, just put player into resurrect queue
    if (unit->IsSpiritGuide())
    {
        Battleground* bg = _player->GetBattleground();
        if (bg)
        {
            bg->AddPlayerToResurrectQueue(unit->GetGUID(), _player->GetGUID());
            sBattlegroundMgr->SendAreaSpiritHealerQueryOpcode(_player, bg, unit->GetGUID());
            return;
        }
    }

    if (!sScriptMgr->OnGossipHello(_player, unit))
    {
        //        _player->TalkedToCreature(unit->GetEntry(), unit->GetGUID());
        _player->PrepareGossipMenu(unit, unit->GetCreatureTemplate()->GossipMenuId, true);
        _player->SendPreparedGossip(unit);
    }
    unit->AI()->sGossipHello(_player);
}

/*void WorldSession::HandleGossipSelectOptionOpcode(WorldPacket & recvData)
{
    LOG_DEBUG("network.opcode", "WORLD: CMSG_GOSSIP_SELECT_OPTION");

    uint32 option;
    uint32 unk;
    ObjectGuid guid;
    std::string code = "";

    recvData >> guid >> unk >> option;

    if (_player->PlayerTalkClass->GossipOptionCoded(option))
    {
        LOG_DEBUG("network.opcode", "reading string");
        recvData >> code;
        LOG_DEBUG("network.opcode", "string read: {}", code);
    }

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_NONE);
    if (!unit)
    {
        LOG_DEBUG("network.opcode", "WORLD: HandleGossipSelectOptionOpcode - Unit ({}) not found or you can't interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    if (!code.empty())
    {
        if (!Script->GossipSelectWithCode(_player, unit, _player->PlayerTalkClass->GossipOptionSender (option), _player->PlayerTalkClass->GossipOptionAction(option), code.c_str()))
            unit->OnGossipSelect (_player, option);
    }
    else
    {
        if (!Script->OnGossipSelect (_player, unit, _player->PlayerTalkClass->GossipOptionSender (option), _player->PlayerTalkClass->GossipOptionAction (option)))
           unit->OnGossipSelect (_player, option);
    }
}*/

void WorldSession::HandleSpiritHealerActivateOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: CMSG_SPIRIT_HEALER_ACTIVATE");

    ObjectGuid guid;

    recvData >> guid;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_SPIRITHEALER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleSpiritHealerActivateOpcode - Unit ({}) not found or you can not interact with him.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    SendSpiritResurrect();
}

void WorldSession::SendSpiritResurrect()
{
    _player->ResurrectPlayer(0.5f, true);

    _player->DurabilityLossAll(0.25f, true);

    // get corpse nearest graveyard
    GraveyardStruct const* corpseGrave = nullptr;

    // Search for any graveyards near the player's corpse.
    corpseGrave = sGraveyard->GetClosestGraveyard(_player, _player->GetTeamId(), _player->HasCorpse());

    // now can spawn bones
    _player->SpawnCorpseBones();

    // teleport to nearest from corpse graveyard, if different from nearest to player ghost
    if (corpseGrave)
    {
        GraveyardStruct const* ghostGrave = sGraveyard->GetClosestGraveyard(_player, _player->GetTeamId());

        if (corpseGrave != ghostGrave)
            _player->TeleportTo(corpseGrave->Map, corpseGrave->x, corpseGrave->y, corpseGrave->z, _player->GetOrientation());
        // or update at original position
        //else
        //    _player->UpdateObjectVisibility(); // xinef: not needed, called in ResurrectPlayer
    }
    // or update at original position
    //else
    //    _player->UpdateObjectVisibility(); // xinef: not needed, called in ResurrectPlayer
}

void WorldSession::HandleBinderActivateOpcode(WorldPacket& recvData)
{
    ObjectGuid npcGUID;
    recvData >> npcGUID;

    if (!GetPlayer()->IsInWorld() || !GetPlayer()->IsAlive())
        return;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(npcGUID, UNIT_NPC_FLAG_INNKEEPER);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleBinderActivateOpcode - Unit ({}) not found or you can not interact with him.", npcGUID.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    SendBindPoint(unit);
}

void WorldSession::SendBindPoint(Creature* npc)
{
    // prevent set homebind to instances in any case
    if (GetPlayer()->GetMap()->Instanceable())
        return;

    uint32 bindspell = 3286;

    // send spell for homebinding (3286)
    npc->CastSpell(_player, bindspell, true);

    WorldPacket data(SMSG_TRAINER_BUY_SUCCEEDED, (8 + 4));
    data << npc->GetGUID();
    data << uint32(bindspell);
    SendPacket(&data);

    _player->PlayerTalkClass->SendCloseGossip();
}

void WorldSession::HandleListStabledPetsOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recv MSG_LIST_STABLED_PETS");
    ObjectGuid npcGUID;

    recvData >> npcGUID;

    if (!CheckStableMaster(npcGUID))
        return;

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // remove mounts this fix bug where getting pet from stable while mounted deletes pet.
    if (GetPlayer()->IsMounted())
        GetPlayer()->RemoveAurasByType(SPELL_AURA_MOUNTED);

    SendStablePet(npcGUID);
}

void WorldSession::SendStablePet(ObjectGuid guid)
{
    LOG_DEBUG("network", "WORLD: Recv MSG_LIST_STABLED_PETS Send.");

    WorldPacket data(MSG_LIST_STABLED_PETS, 200);           // guess size
    data << guid;
    std::size_t wpos = data.wpos();
    data << uint8(0);                                       // place holder for slot show number

    PetStable* petStable = GetPlayer()->GetPetStable();
    if (!petStable)
    {
        data << uint8(0);                                   // stable slots
        SendPacket(&data);
        return;
    }

    data << uint8(petStable->MaxStabledPets);

    uint8 num = 0;                                          // counter for place holder

    // not let move dead pet in slot
    if (petStable->CurrentPet)
    {
        PetStable::PetInfo const& pet = *petStable->CurrentPet;
        data << uint32(pet.PetNumber);
        data << uint32(pet.CreatureId);
        data << uint32(pet.Level);
        data << pet.Name;                                   // petname
        data << uint8(1);                                   // flags: 1 active, 2 inactive
        ++num;
    }
    else
    {
        if (PetStable::PetInfo const* pet = petStable->GetUnslottedHunterPet())
        {
            data << uint32(pet->PetNumber);
            data << uint32(pet->CreatureId);
            data << uint32(pet->Level);
            data << pet->Name;                                   // petname
            data << uint8(1);                                   // flags: 1 active, 2 inactive
            ++num;
        }
    }

    for (Optional<PetStable::PetInfo> const& stabledSlot : petStable->StabledPets)
    {
        if (stabledSlot)
        {
            PetStable::PetInfo const& pet = *stabledSlot;
            data << uint32(pet.PetNumber);
            data << uint32(pet.CreatureId);
            data << uint32(pet.Level);
            data << pet.Name;                               // petname
            data << uint8(2);                               // flags: 1 active, 2 inactive
            ++num;
        }
    }

    data.put<uint8>(wpos, num);                             // set real data to placeholder
    SendPacket(&data);
}

void WorldSession::SendStableResult(uint8 res)
{
    WorldPacket data(SMSG_STABLE_RESULT, 1);
    data << uint8(res);
    SendPacket(&data);
}

void WorldSession::HandleStablePet(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recv CMSG_STABLE_PET");
    ObjectGuid npcGUID;

    recvData >> npcGUID;

    if (!GetPlayer()->IsAlive())
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    if (!CheckStableMaster(npcGUID))
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    PetStable* petStable = GetPlayer()->GetPetStable();
    if (!petStable)
        return;

    Pet* pet = _player->GetPet();

    // can't place in stable dead pet
    if ((pet && (!pet->IsAlive() || pet->getPetType() != HUNTER_PET))
        || (!pet && (petStable->UnslottedPets.size() != 1 || !petStable->UnslottedPets[0].Health || petStable->UnslottedPets[0].Type != HUNTER_PET)))
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    for (uint32 freeSlot = 0; freeSlot < petStable->MaxStabledPets; ++freeSlot)
    {
        if (!petStable->StabledPets[freeSlot])
        {
            if (pet)
            {
                // stable summoned pet
                _player->RemovePet(pet, PetSaveMode(PET_SAVE_FIRST_STABLE_SLOT + freeSlot));
                std::swap(petStable->StabledPets[freeSlot], petStable->CurrentPet);
                SendStableResult(STABLE_SUCCESS_STABLE);
                return;
            }

            CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
            stmt->SetData(0, PetSaveMode(PET_SAVE_FIRST_STABLE_SLOT + freeSlot));
            stmt->SetData(1, _player->GetGUID().GetCounter());
            stmt->SetData(2, petStable->UnslottedPets[0].PetNumber);
            CharacterDatabase.Execute(stmt);

            // stable unsummoned pet
            petStable->StabledPets[freeSlot] = std::move(petStable->UnslottedPets.back());
            petStable->UnslottedPets.pop_back();
            SendStableResult(STABLE_SUCCESS_STABLE);
            return;
        }
    }

    // not free stable slot
    SendStableResult(STABLE_ERR_STABLE);
}

void WorldSession::HandleUnstablePet(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recv CMSG_UNSTABLE_PET.");
    ObjectGuid npcGUID;
    uint32 petnumber;

    recvData >> npcGUID >> petnumber;

    if (!CheckStableMaster(npcGUID))
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    PetStable* petStable = GetPlayer()->GetPetStable();
    if (!petStable)
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    auto stabledPet = std::find_if(petStable->StabledPets.begin(), petStable->StabledPets.end(), [petnumber](Optional<PetStable::PetInfo> const& pet)
    {
        return pet && pet->PetNumber == petnumber;
    });

    if (stabledPet == petStable->StabledPets.end())
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate((*stabledPet)->CreatureId);
    if (!creatureInfo || !creatureInfo->IsTameable(_player->CanTameExoticPets()))
    {
        // if problem in exotic pet
        if (creatureInfo && creatureInfo->IsTameable(true))
            SendStableResult(STABLE_ERR_EXOTIC);
        else
            SendStableResult(STABLE_ERR_STABLE);

        return;
    }

    Pet* oldPet = _player->GetPet();
    if (oldPet)
    {
        // try performing a swap, client sends this packet instead of swap when starting from stabled slot
        if (!oldPet->IsAlive() || !oldPet->IsHunterPet())
        {
            SendStableResult(STABLE_ERR_STABLE);
            return;
        }

        _player->RemovePet(oldPet, PetSaveMode(PET_SAVE_FIRST_STABLE_SLOT + std::distance(petStable->StabledPets.begin(), stabledPet)));
    }
    else if (petStable->UnslottedPets.size() == 1)
    {
        if (petStable->CurrentPet || !petStable->UnslottedPets[0].Health || petStable->UnslottedPets[0].Type != HUNTER_PET)
        {
            SendStableResult(STABLE_ERR_STABLE);
            return;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
        stmt->SetData(0, PetSaveMode(PET_SAVE_FIRST_STABLE_SLOT + std::distance(petStable->StabledPets.begin(), stabledPet)));
        stmt->SetData(1, _player->GetGUID().GetCounter());
        stmt->SetData(2, petStable->UnslottedPets[0].PetNumber);
        CharacterDatabase.Execute(stmt);

        // move unsummoned pet into CurrentPet slot so that it gets moved into stable slot later
        petStable->CurrentPet = std::move(petStable->UnslottedPets.back());
        petStable->UnslottedPets.pop_back();
    }
    else if (petStable->CurrentPet || !petStable->UnslottedPets.empty())
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    Pet* newPet = new Pet(_player, HUNTER_PET);
    if (!newPet->LoadPetFromDB(_player, 0, petnumber, false))
    {
        delete newPet;

        petStable->UnslottedPets.push_back(std::move(*petStable->CurrentPet));
        petStable->CurrentPet.reset();

        // update current pet slot in db immediately to maintain slot consistency, dismissed pet was already saved
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
        stmt->SetData(0, PET_SAVE_NOT_IN_SLOT);
        stmt->SetData(1, _player->GetGUID().GetCounter());
        stmt->SetData(2, petnumber);
        CharacterDatabase.Execute(stmt);

        SendStableResult(STABLE_ERR_STABLE);
    }
    else
    {
        // update current pet slot in db immediately to maintain slot consistency, dismissed pet was already saved
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
        stmt->SetData(0, PET_SAVE_AS_CURRENT);
        stmt->SetData(1, _player->GetGUID().GetCounter());
        stmt->SetData(2, petnumber);
        CharacterDatabase.Execute(stmt);

        SendStableResult(STABLE_SUCCESS_UNSTABLE);
    }
}

void WorldSession::HandleBuyStableSlot(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recv CMSG_BUY_STABLE_SLOT.");
    ObjectGuid npcGUID;

    recvData >> npcGUID;

    if (!CheckStableMaster(npcGUID))
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    PetStable& petStable = GetPlayer()->GetOrInitPetStable();
    if (petStable.MaxStabledPets < MAX_PET_STABLES)
    {
        StableSlotPricesEntry const* SlotPrice = sStableSlotPricesStore.LookupEntry(petStable.MaxStabledPets + 1);
        if (_player->HasEnoughMoney(SlotPrice->Price))
        {
            ++petStable.MaxStabledPets;
            _player->ModifyMoney(-int32(SlotPrice->Price));
            SendStableResult(STABLE_SUCCESS_BUY_SLOT);
        }
        else
            SendStableResult(STABLE_ERR_MONEY);
    }
    else
        SendStableResult(STABLE_ERR_STABLE);
}

void WorldSession::HandleStableRevivePet(WorldPacket& /* recvData */)
{
    LOG_DEBUG("network", "HandleStableRevivePet: Not implemented");
}

void WorldSession::HandleStableSwapPet(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recv CMSG_STABLE_SWAP_PET.");
    ObjectGuid npcGUID;
    uint32 petId;

    recvData >> npcGUID >> petId;

    if (!CheckStableMaster(npcGUID))
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    PetStable* petStable = GetPlayer()->GetPetStable();
    if (!petStable)
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    // Find swapped pet slot in stable
    auto stabledPet = std::find_if(petStable->StabledPets.begin(), petStable->StabledPets.end(), [petId](Optional<PetStable::PetInfo> const& pet)
    {
        return pet && pet->PetNumber == petId;
    });

    if (stabledPet == petStable->StabledPets.end())
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate((*stabledPet)->CreatureId);
    if (!creatureInfo || !creatureInfo->IsTameable(_player->CanTameExoticPets()))
    {
        // if problem in exotic pet
        if (creatureInfo && creatureInfo->IsTameable(true))
            SendStableResult(STABLE_ERR_EXOTIC);
        else
            SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    Pet* oldPet = _player->GetPet();
    if (oldPet)
    {
        if (!oldPet->IsAlive() || !oldPet->IsHunterPet())
        {
            SendStableResult(STABLE_ERR_STABLE);
            return;
        }

        _player->RemovePet(oldPet, PetSaveMode(PET_SAVE_FIRST_STABLE_SLOT + std::distance(petStable->StabledPets.begin(), stabledPet)));
    }
    else if (petStable->UnslottedPets.size() == 1)
    {
        if (petStable->CurrentPet || !petStable->UnslottedPets[0].Health || petStable->UnslottedPets[0].Type != HUNTER_PET)
        {
            SendStableResult(STABLE_ERR_STABLE);
            return;
        }

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
        stmt->SetData(0, PetSaveMode(PET_SAVE_FIRST_STABLE_SLOT + std::distance(petStable->StabledPets.begin(), stabledPet)));
        stmt->SetData(1, _player->GetGUID().GetCounter());
        stmt->SetData(2, petStable->UnslottedPets[0].PetNumber);
        CharacterDatabase.Execute(stmt);

        // move unsummoned pet into CurrentPet slot so that it gets moved into stable slot later
        petStable->CurrentPet = std::move(petStable->UnslottedPets.back());
        petStable->UnslottedPets.pop_back();
    }
    else if (petStable->CurrentPet || !petStable->UnslottedPets.empty())
    {
        SendStableResult(STABLE_ERR_STABLE);
        return;
    }

    // summon unstabled pet
    Pet* newPet = new Pet(_player, HUNTER_PET);
    if (!newPet->LoadPetFromDB(_player, 0, petId, false))
    {
        delete newPet;
        SendStableResult(STABLE_ERR_STABLE);

        petStable->UnslottedPets.push_back(std::move(*petStable->CurrentPet));
        petStable->CurrentPet.reset();

        // update current pet slot in db immediately to maintain slot consistency, dismissed pet was already saved
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
        stmt->SetData(0, PET_SAVE_NOT_IN_SLOT);
        stmt->SetData(1, _player->GetGUID().GetCounter());
        stmt->SetData(2, petId);
        CharacterDatabase.Execute(stmt);
    }
    else
    {
        // update current pet slot in db immediately to maintain slot consistency, dismissed pet was already saved
        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID);
        stmt->SetData(0, PET_SAVE_AS_CURRENT);
        stmt->SetData(1, _player->GetGUID().GetCounter());
        stmt->SetData(2, petId);
        CharacterDatabase.Execute(stmt);

        SendStableResult(STABLE_SUCCESS_UNSTABLE);
    }
}

void WorldSession::HandleRepairItemOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: CMSG_REPAIR_ITEM");

    ObjectGuid npcGUID, itemGUID;
    uint8 guildBank;                                        // new in 2.3.2, bool that means from guild bank money

    recvData >> npcGUID >> itemGUID >> guildBank;

    Creature* unit = GetPlayer()->GetNPCIfCanInteractWith(npcGUID, UNIT_NPC_FLAG_REPAIR);
    if (!unit)
    {
        LOG_DEBUG("network", "WORLD: HandleRepairItemOpcode - Unit ({}) not found or you can not interact with him.", npcGUID.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    // reputation discount
    float discountMod = _player->GetReputationPriceDiscount(unit);

    sScriptMgr->OnBeforePlayerDurabilityRepair(_player, npcGUID, itemGUID, discountMod, guildBank);

    if (itemGUID)
    {
        LOG_DEBUG("network", "ITEM: Repair item, item {}, npc {}", itemGUID.ToString(), npcGUID.ToString());

        Item* item = _player->GetItemByGuid(itemGUID);
        if (item)
            _player->DurabilityRepair(item->GetPos(), true, discountMod, guildBank);
    }
    else
    {
        LOG_DEBUG("network", "ITEM: Repair all items, npc {}", npcGUID.ToString());
        _player->DurabilityRepairAll(true, discountMod, guildBank);
    }
}
