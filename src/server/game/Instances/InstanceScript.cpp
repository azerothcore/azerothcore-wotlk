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

#include "InstanceScript.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "DatabaseEnv.h"
#include "GameObject.h"
#include "Group.h"
#include "InstanceSaveMgr.h"
#include "LFGMgr.h"
#include "Log.h"
#include "Map.h"
#include "Opcodes.h"
#include "Pet.h"
#include "Player.h"
#include "Spell.h"
#include "WorldSession.h"

BossBoundaryData::~BossBoundaryData()
{
    for (const_iterator it = begin(); it != end(); ++it)
        delete it->boundary;
}

void InstanceScript::SaveToDB()
{
    std::string data = GetSaveData();
    //if (data.empty()) // pussywizard: encounterMask can be updated and theres no reason to not save
    //    return;

    // pussywizard:
    InstanceSave* save = sInstanceSaveMgr->GetInstanceSave(instance->GetInstanceId());
    if (save)
        save->SetInstanceData(data);

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_INSTANCE_SAVE_DATA);
    stmt->SetData(0, data);
    stmt->SetData(1, instance->GetInstanceId());
    CharacterDatabase.Execute(stmt);
}

void InstanceScript::OnCreatureCreate(Creature* creature)
{
    AddObject(creature, true);
    AddMinion(creature, true);
}

void InstanceScript::OnCreatureRemove(Creature* creature)
{
    AddObject(creature, false);
    AddMinion(creature, false);
}

void InstanceScript::OnGameObjectCreate(GameObject* go)
{
    AddObject(go, true);
    AddDoor(go, true);
}

void InstanceScript::OnGameObjectRemove(GameObject* go)
{
    AddObject(go, false);
    AddDoor(go, false);
}

ObjectGuid InstanceScript::GetObjectGuid(uint32 type) const
{
    ObjectGuidMap::const_iterator i = _objectGuids.find(type);

    if (i != _objectGuids.end())
    {
        return i->second;
    }

    return ObjectGuid::Empty;
}

ObjectGuid InstanceScript::GetGuidData(uint32 type) const
{
    return GetObjectGuid(type);
}

Creature* InstanceScript::GetCreature(uint32 type)
{
    return instance->GetCreature(GetObjectGuid(type));
}

GameObject* InstanceScript::GetGameObject(uint32 type)
{
    return instance->GetGameObject(GetObjectGuid(type));
}

void InstanceScript::HandleGameObject(ObjectGuid GUID, bool open, GameObject* go)
{
    if (!go)
        go = instance->GetGameObject(GUID);
    if (go)
        go->SetGoState(open ? GO_STATE_ACTIVE : GO_STATE_READY);
    else
    {
        LOG_DEBUG("scripts.ai", "InstanceScript: HandleGameObject failed");
    }
}

bool InstanceScript::IsEncounterInProgress() const
{
    for (std::vector<BossInfo>::const_iterator itr = bosses.begin(); itr != bosses.end(); ++itr)
        if (itr->state == IN_PROGRESS)
            return true;

    return false;
}

void InstanceScript::LoadBossBoundaries(const BossBoundaryData& data)
{
    for (BossBoundaryEntry const& entry : data)
        if (entry.bossId < bosses.size())
            bosses[entry.bossId].boundary.push_back(entry.boundary);
}

void InstanceScript::LoadMinionData(const MinionData* data)
{
    while (data->entry)
    {
        if (data->bossId < bosses.size())
            minions.insert(std::make_pair(data->entry, MinionInfo(&bosses[data->bossId])));

        ++data;
    }
    LOG_DEBUG("scripts.ai", "InstanceScript::LoadMinionData: {} minions loaded.", uint64(minions.size()));
}

void InstanceScript::LoadDoorData(const DoorData* data)
{
    while (data->entry)
    {
        if (data->bossId < bosses.size())
            doors.insert(std::make_pair(data->entry, DoorInfo(&bosses[data->bossId], data->type)));

        ++data;
    }
    LOG_DEBUG("scripts.ai", "InstanceScript::LoadDoorData: {} doors loaded.", uint64(doors.size()));
}

void InstanceScript::LoadObjectData(ObjectData const* creatureData, ObjectData const* gameObjectData)
{
    if (creatureData)
    {
        LoadObjectData(creatureData, _creatureInfo);
    }

    if (gameObjectData)
    {
        LoadObjectData(gameObjectData, _gameObjectInfo);
    }

    LOG_DEBUG("scripts", "InstanceScript::LoadObjectData: {} objects loaded.", _creatureInfo.size() + _gameObjectInfo.size());
}

void InstanceScript::LoadObjectData(ObjectData const* data, ObjectInfoMap& objectInfo)
{
    while (data->entry)
    {
        objectInfo[data->entry] = data->type;
        ++data;
    }
}

void InstanceScript::UpdateMinionState(Creature* minion, EncounterState state)
{
    switch (state)
    {
        case NOT_STARTED:
            if (!minion->IsAlive())
                minion->Respawn();
            else if (minion->IsInCombat())
                minion->AI()->EnterEvadeMode();
            break;
        case IN_PROGRESS:
            if (!minion->IsAlive())
                minion->Respawn();
            else
            {
                minion->AI()->DoZoneInCombat(nullptr, 100.0f);
            }
            break;
        default:
            break;
    }
}

void InstanceScript::UpdateDoorState(GameObject* door)
{
    DoorInfoMapBounds range = doors.equal_range(door->GetEntry());
    if (range.first == range.second)
        return;

    // xinef: doors can be assigned to few bosses, if any of them demands doors closed - they should be closed (added & operator for assigment)
    bool open = true;
    for (; range.first != range.second && open; ++range.first)
    {
        DoorInfo const& info = range.first->second;
        switch (info.type)
        {
            case DOOR_TYPE_ROOM:
                open &= (info.bossInfo->state != IN_PROGRESS);
                break;
            case DOOR_TYPE_PASSAGE:
                open &= (info.bossInfo->state == DONE);
                break;
            case DOOR_TYPE_SPAWN_HOLE:
                open &= (info.bossInfo->state == IN_PROGRESS);
                break;
            default:
                break;
        }
    }

    door->SetGoState(open ? GO_STATE_ACTIVE : GO_STATE_READY);
}

void InstanceScript::AddObject(Creature* obj, bool add)
{
    ObjectInfoMap::const_iterator j = _creatureInfo.find(obj->GetEntry());
    if (j != _creatureInfo.end())
    {
        AddObject(obj, j->second, add);
    }
}

void InstanceScript::AddObject(GameObject* obj, bool add)
{
    ObjectInfoMap::const_iterator j = _gameObjectInfo.find(obj->GetEntry());
    if (j != _gameObjectInfo.end())
    {
        AddObject(obj, j->second, add);
    }
}

void InstanceScript::AddObject(WorldObject* obj, uint32 type, bool add)
{
    if (add)
    {
        _objectGuids[type] = obj->GetGUID();
    }
    else
    {
        ObjectGuidMap::iterator i = _objectGuids.find(type);
        if (i != _objectGuids.end() && i->second == obj->GetGUID())
        {
            _objectGuids.erase(i);
        }
    }
}

void InstanceScript::AddDoor(GameObject* door, bool add)
{
    DoorInfoMapBounds range = doors.equal_range(door->GetEntry());
    if (range.first == range.second)
        return;

    for (; range.first != range.second; ++range.first)
    {
        DoorInfo const& data = range.first->second;

        if (add)
        {
            data.bossInfo->door[data.type].insert(door);
        }
        else
            data.bossInfo->door[data.type].erase(door);
    }

    if (add)
        UpdateDoorState(door);
}

void InstanceScript::AddMinion(Creature* minion, bool add)
{
    MinionInfoMap::iterator itr = minions.find(minion->GetEntry());
    if (itr == minions.end())
        return;

    if (add)
        itr->second.bossInfo->minion.insert(minion);
    else
        itr->second.bossInfo->minion.erase(minion);
}

bool InstanceScript::SetBossState(uint32 id, EncounterState state)
{
    if (id < bosses.size())
    {
        BossInfo* bossInfo = &bosses[id];
        if (bossInfo->state == TO_BE_DECIDED) // loading
        {
            bossInfo->state = state;
            return false;
        }
        else
        {
            if (bossInfo->state == state)
                return false;

            if (state == DONE)
                for (MinionSet::iterator i = bossInfo->minion.begin(); i != bossInfo->minion.end(); ++i)
                    if ((*i)->isWorldBoss() && (*i)->IsAlive())
                        return false;

            bossInfo->state = state;
            SaveToDB();
        }

        for (uint32 type = 0; type < MAX_DOOR_TYPES; ++type)
            for (DoorSet::iterator i = bossInfo->door[type].begin(); i != bossInfo->door[type].end(); ++i)
                UpdateDoorState(*i);

        for (MinionSet::iterator i = bossInfo->minion.begin(); i != bossInfo->minion.end(); ++i)
            UpdateMinionState(*i, state);

        return true;
    }
    return false;
}

std::string InstanceScript::LoadBossState(const char* data)
{
    if (!data)
        return nullptr;
    std::istringstream loadStream(data);
    uint32 buff;
    uint32 bossId = 0;
    for (std::vector<BossInfo>::iterator i = bosses.begin(); i != bosses.end(); ++i, ++bossId)
    {
        loadStream >> buff;
        if (buff < TO_BE_DECIDED)
            SetBossState(bossId, (EncounterState)buff);
    }
    return loadStream.str();
}

std::string InstanceScript::GetBossSaveData()
{
    std::ostringstream saveStream;
    for (std::vector<BossInfo>::iterator i = bosses.begin(); i != bosses.end(); ++i)
        saveStream << (uint32)i->state << ' ';
    return saveStream.str();
}

void InstanceScript::DoUseDoorOrButton(ObjectGuid uiGuid, uint32 uiWithRestoreTime, bool bUseAlternativeState)
{
    if (!uiGuid)
        return;

    GameObject* go = instance->GetGameObject(uiGuid);

    if (go)
    {
        if (go->GetGoType() == GAMEOBJECT_TYPE_DOOR || go->GetGoType() == GAMEOBJECT_TYPE_BUTTON)
        {
            if (go->getLootState() == GO_READY)
                go->UseDoorOrButton(uiWithRestoreTime, bUseAlternativeState);
            else if (go->getLootState() == GO_ACTIVATED)
                go->ResetDoorOrButton();
        }
        else
            LOG_ERROR("scripts.ai", "SD2: Script call DoUseDoorOrButton, but gameobject entry {} is type {}.", go->GetEntry(), go->GetGoType());
    }
}

void InstanceScript::DoRespawnGameObject(ObjectGuid uiGuid, uint32 uiTimeToDespawn)
{
    if (GameObject* go = instance->GetGameObject(uiGuid))
    {
        //not expect any of these should ever be handled
        if (go->GetGoType() == GAMEOBJECT_TYPE_FISHINGNODE || go->GetGoType() == GAMEOBJECT_TYPE_DOOR ||
                go->GetGoType() == GAMEOBJECT_TYPE_BUTTON || go->GetGoType() == GAMEOBJECT_TYPE_TRAP)
            return;

        if (go->isSpawned())
            return;

        go->SetRespawnTime(uiTimeToDespawn);
    }
}

void InstanceScript::DoRespawnCreature(ObjectGuid guid, bool force)
{
    if (Creature* creature = instance->GetCreature(guid))
    {
        creature->Respawn(force);
    }
}

void InstanceScript::DoRespawnCreature(uint32 type, bool force)
{
    if (Creature* creature = instance->GetCreature(GetObjectGuid(type)))
    {
        creature->Respawn(force);
    }
}

void InstanceScript::DoUpdateWorldState(uint32 uiStateId, uint32 uiStateData)
{
    Map::PlayerList const& lPlayers = instance->GetPlayers();

    if (!lPlayers.IsEmpty())
    {
        for (Map::PlayerList::const_iterator itr = lPlayers.begin(); itr != lPlayers.end(); ++itr)
            if (Player* player = itr->GetSource())
                player->SendUpdateWorldState(uiStateId, uiStateData);
    }
    else
    {
        LOG_DEBUG("scripts.ai", "DoUpdateWorldState attempt send data but no players in map.");
    }
}

// Send Notify to all players in instance
void InstanceScript::DoSendNotifyToInstance(char const* format, ...)
{
    InstanceMap::PlayerList const& players = instance->GetPlayers();

    if (!players.IsEmpty())
    {
        va_list ap;
        va_start(ap, format);
        char buff[1024];
        vsnprintf(buff, 1024, format, ap);
        va_end(ap);
        for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
            if (Player* player = i->GetSource())
                player->GetSession()->SendNotification("%s", buff);
    }
}

// Update Achievement Criteria for all players in instance
void InstanceScript::DoUpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 /*= 0*/, uint32 miscValue2 /*= 0*/, Unit* unit /*= nullptr*/)
{
    Map::PlayerList const& PlayerList = instance->GetPlayers();

    if (!PlayerList.IsEmpty())
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* player = i->GetSource())
                player->UpdateAchievementCriteria(type, miscValue1, miscValue2, unit);
}

// Start timed achievement for all players in instance
void InstanceScript::DoStartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
    Map::PlayerList const& PlayerList = instance->GetPlayers();

    if (!PlayerList.IsEmpty())
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* player = i->GetSource())
                player->StartTimedAchievement(type, entry);
}

// Stop timed achievement for all players in instance
void InstanceScript::DoStopTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
    Map::PlayerList const& PlayerList = instance->GetPlayers();

    if (!PlayerList.IsEmpty())
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* player = i->GetSource())
                player->RemoveTimedAchievement(type, entry);
}

// Remove Auras due to Spell on all players in instance
void InstanceScript::DoRemoveAurasDueToSpellOnPlayers(uint32 spell)
{
    Map::PlayerList const& PlayerList = instance->GetPlayers();
    if (!PlayerList.IsEmpty())
    {
        for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
        {
            if (Player* player = itr->GetSource())
            {
                player->RemoveAurasDueToSpell(spell);
                if (Pet* pet = player->GetPet())
                    pet->RemoveAurasDueToSpell(spell);
            }
        }
    }
}

// Cast spell on all players in instance
void InstanceScript::DoCastSpellOnPlayers(uint32 spell)
{
    Map::PlayerList const& PlayerList = instance->GetPlayers();

    if (!PlayerList.IsEmpty())
        for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            if (Player* player = i->GetSource())
                player->CastSpell(player, spell, true);
}

bool InstanceScript::CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target*/ /*= nullptr*/, uint32 /*miscvalue1*/ /*= 0*/)
{
    LOG_ERROR("scripts.ai", "Achievement system call InstanceScript::CheckAchievementCriteriaMeet but instance script for map {} not have implementation for achievement criteria {}",
                   instance->GetId(), criteria_id);
    return false;
}

void InstanceScript::SetCompletedEncountersMask(uint32 newMask, bool save)
{
    if (completedEncounters == newMask)
        return;
    completedEncounters = newMask;
    // pussywizard:
    if (save)
    {
        InstanceSave* iSave = sInstanceSaveMgr->GetInstanceSave(instance->GetInstanceId());
        if (iSave)
            iSave->SetCompletedEncounterMask(completedEncounters);

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_INSTANCE_SAVE_ENCOUNTERMASK);
        stmt->SetData(0, completedEncounters);
        stmt->SetData(1, instance->GetInstanceId());
        CharacterDatabase.Execute(stmt);
    }
}

void InstanceScript::SendEncounterUnit(uint32 type, Unit* unit /*= nullptr*/, uint8 param1 /*= 0*/, uint8 param2 /*= 0*/)
{
    // size of this packet is at most 15 (usually less)
    WorldPacket data(SMSG_UPDATE_INSTANCE_ENCOUNTER_UNIT, 15);
    data << uint32(type);

    switch (type)
    {
        case ENCOUNTER_FRAME_ENGAGE:
        case ENCOUNTER_FRAME_DISENGAGE:
        case ENCOUNTER_FRAME_UPDATE_PRIORITY:
            data << unit->GetPackGUID();
            data << uint8(param1);
            break;
        case ENCOUNTER_FRAME_ADD_TIMER:
        case ENCOUNTER_FRAME_ENABLE_OBJECTIVE:
        case ENCOUNTER_FRAME_DISABLE_OBJECTIVE:
            data << uint8(param1);
            break;
        case ENCOUNTER_FRAME_UPDATE_OBJECTIVE:
            data << uint8(param1);
            data << uint8(param2);
            break;
        case ENCOUNTER_FRAME_REFRESH_FRAMES:
        default:
            break;
    }

    instance->SendToPlayers(&data);
}

std::string InstanceScript::GetBossStateName(uint8 state)
{
    // See enum EncounterState in InstanceScript.h
    switch (state)
    {
        case NOT_STARTED:
            return "NOT_STARTED";
        case IN_PROGRESS:
            return "IN_PROGRESS";
        case FAIL:
            return "FAIL";
        case DONE:
            return "DONE";
        case SPECIAL:
            return "SPECIAL";
        case TO_BE_DECIDED:
            return "TO_BE_DECIDED";
        default:
            return "INVALID";
    }
}

bool InstanceHasScript(WorldObject const* obj, char const* scriptName)
{
    if (InstanceMap* instance = obj->GetMap()->ToInstanceMap())
    {
        return instance->GetScriptName() == scriptName;
    }

    return false;
}
