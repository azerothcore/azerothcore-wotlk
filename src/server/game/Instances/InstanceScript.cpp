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
#include "Chat.h"
#include "Creature.h"
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
#include "ScriptMgr.h"
#include "Spell.h"
#include "WorldSession.h"

//npcbot
#include "botmgr.h"
//end npcbot

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
    AddObject(creature);
    AddMinion(creature);
}

void InstanceScript::OnCreatureRemove(Creature* creature)
{
    RemoveObject(creature);
    RemoveMinion(creature);
}

void InstanceScript::OnGameObjectCreate(GameObject* go)
{
    AddObject(go);
    AddDoor(go);
    sScriptMgr->AfterInstanceGameObjectCreate(instance, go);
}

void InstanceScript::OnGameObjectRemove(GameObject* go)
{
    RemoveObject(go);
    RemoveDoor(go);
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

void InstanceScript::SetHeaders(std::string const& dataHeaders)
{
    for (char header : dataHeaders)
    {
        if (isalpha(header))
        {
            headers.push_back(header);
        }
    }
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
                if (minion->GetReactState() == REACT_AGGRESSIVE)
                {
                    minion->AI()->DoZoneInCombat(nullptr, 100.0f);
                }
            }
            break;
        default:
            break;
    }
}

void InstanceScript::Update(uint32 diff)
{
    scheduler.Update(diff);
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

void InstanceScript::RemoveObject(Creature* obj)
{
    AddObject(obj, false);
}

void InstanceScript::AddObject(GameObject* obj, bool add)
{
    ObjectInfoMap::const_iterator j = _gameObjectInfo.find(obj->GetEntry());
    if (j != _gameObjectInfo.end())
    {
        AddObject(obj, j->second, add);
    }
}

void InstanceScript::RemoveObject(GameObject* obj)
{
    AddObject(obj, false);
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

void InstanceScript::RemoveObject(WorldObject* obj, uint32 type)
{
    AddObject(obj, type, false);
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

void InstanceScript::RemoveDoor(GameObject* door)
{
    AddDoor(door, false);
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

void InstanceScript::RemoveMinion(Creature* minion)
{
    AddMinion(minion, false);
}

bool InstanceScript::SetBossState(uint32 id, EncounterState state)
{
    if (id < bosses.size())
    {
        BossInfo* bossInfo = &bosses[id];
        sScriptMgr->OnBeforeSetBossState(id, state, bossInfo->state, instance);
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

void InstanceScript::StorePersistentData(uint32 index, uint32 data)
{
    if (index > persistentData.size())
    {
        LOG_ERROR("scripts", "InstanceScript::StorePersistentData() index larger than storage size. Index: {} Size: {} Data: {}.", index, persistentData.size(), data);
        return;
    }

    persistentData[index] = data;
}

void InstanceScript::DoForAllMinions(uint32 id, std::function<void(Creature*)> exec)
{
    BossInfo* bossInfo = &bosses[id];
    MinionSet listCopy = bossInfo->minion;

    for (auto const& minion : listCopy)
    {
        if (minion)
        {
            exec(minion);
        }
    }
}

void InstanceScript::Load(const char* data)
{
    if (!data)
    {
        OUT_LOAD_INST_DATA_FAIL;
        return;
    }

    OUT_LOAD_INST_DATA(data);

    std::istringstream loadStream(data);

    if (ReadSaveDataHeaders(loadStream))
    {
        ReadSaveDataBossStates(loadStream);
        ReadSavePersistentData(loadStream);
        ReadSaveDataMore(loadStream);
    }
    else
        OUT_LOAD_INST_DATA_FAIL;

    OUT_LOAD_INST_DATA_COMPLETE;
}

bool InstanceScript::ReadSaveDataHeaders(std::istringstream& data)
{
    for (char header : headers)
    {
        char buff;
        data >> buff;

        if (header != buff)
            return false;
    }

    return true;
}

void InstanceScript::ReadSaveDataBossStates(std::istringstream& data)
{
    uint32 bossId = 0;
    for (std::vector<BossInfo>::iterator i = bosses.begin(); i != bosses.end(); ++i, ++bossId)
    {
        uint32 buff;
        data >> buff;
        if (buff == IN_PROGRESS || buff == FAIL || buff == SPECIAL)
            buff = NOT_STARTED;

        if (buff < TO_BE_DECIDED)
            SetBossState(bossId, EncounterState(buff));
    }
}

void InstanceScript::ReadSavePersistentData(std::istringstream& data)
{
    for (uint32 i = 0; i < persistentData.size(); ++i)
    {
        data >> persistentData[i];
    }
}

std::string InstanceScript::GetSaveData()
{
    OUT_SAVE_INST_DATA;

    std::ostringstream saveStream;

    WriteSaveDataHeaders(saveStream);
    WriteSaveDataBossStates(saveStream);
    WritePersistentData(saveStream);
    WriteSaveDataMore(saveStream);

    OUT_SAVE_INST_DATA_COMPLETE;

    return saveStream.str();
}

void InstanceScript::WriteSaveDataHeaders(std::ostringstream& data)
{
    for (char header : headers)
    {
        data << header << ' ';
    }
}

void InstanceScript::WriteSaveDataBossStates(std::ostringstream& data)
{
    for (BossInfo const& bossInfo : bosses)
    {
        data << uint32(bossInfo.state) << ' ';
    }
}

void InstanceScript::WritePersistentData(std::ostringstream& data)
{
    for (auto const& entry : persistentData)
    {
        data << entry << ' ';
    }
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
        switch (go->GetGoType())
        {
            case GAMEOBJECT_TYPE_DOOR:
            case GAMEOBJECT_TYPE_BUTTON:
            case GAMEOBJECT_TYPE_TRAP:
            case GAMEOBJECT_TYPE_FISHINGNODE:
                // not expect any of these should ever be handled
                LOG_ERROR("scripts", "InstanceScript: DoRespawnGameObject can't respawn gameobject entry {}, because type is {}.", go->GetEntry(), go->GetGoType());
                return;
            default:
                break;
        }

        if (go->isSpawned())
            return;

        go->SetRespawnTime(uiTimeToDespawn);
    }
    else
        LOG_DEBUG("scripts", "InstanceScript: DoRespawnGameObject failed");
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
    if (!instance->GetPlayers().IsEmpty())
    {
        va_list ap;
        va_start(ap, format);
        char buff[1024];
        vsnprintf(buff, 1024, format, ap);
        va_end(ap);

        instance->DoForAllPlayers([&, buff](Player* player)
        {
            ChatHandler(player->GetSession()).SendNotification("{}", buff);
        });
    }
}

// Update Achievement Criteria for all players in instance
void InstanceScript::DoUpdateAchievementCriteria(AchievementCriteriaTypes type, uint32 miscValue1 /*= 0*/, uint32 miscValue2 /*= 0*/, Unit* unit /*= nullptr*/)
{
    instance->DoForAllPlayers([&](Player* player)
    {
        player->UpdateAchievementCriteria(type, miscValue1, miscValue2, unit);
    });
}

// Start timed achievement for all players in instance
void InstanceScript::DoStartTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
    instance->DoForAllPlayers([&](Player* player)
    {
        player->StartTimedAchievement(type, entry);
    });
}

// Stop timed achievement for all players in instance
void InstanceScript::DoStopTimedAchievement(AchievementCriteriaTimedTypes type, uint32 entry)
{
    instance->DoForAllPlayers([&](Player* player)
    {
        player->RemoveTimedAchievement(type, entry);
    });
}

// Remove Auras due to Spell on all players in instance
void InstanceScript::DoRemoveAurasDueToSpellOnPlayers(uint32 spell)
{
    instance->DoForAllPlayers([&](Player* player)
    {
        player->RemoveAurasDueToSpell(spell);
        if (Pet* pet = player->GetPet())
            pet->RemoveAurasDueToSpell(spell);
                //npcbot: include bots
                if (player->HaveBot())
                {
                    for (auto const& bitr : *player->GetBotMgr()->GetBotMap())
                        if (bitr.second && bitr.second->IsInWorld())
                            DoRemoveAurasDueToSpellOnNPCBot(bitr.second, spell);
                }
                //end npcbot
    });
}

// Cast spell on all players in instance
void InstanceScript::DoCastSpellOnPlayers(uint32 spell)
{
    instance->DoForAllPlayers([&](Player* player)
    {
        player->CastSpell(player, spell, true);
        //npcbot: include bots
        if (player->HaveBot())
        {
            for (auto const& bitr : *player->GetBotMgr()->GetBotMap())
                if (bitr.second && bitr.second->IsInWorld())
                    DoCastSpellOnNPCBot(bitr.second, spell);
        }
        //end npcbot
    });
}

//npcbot: hooks
void InstanceScript::DoRemoveAurasDueToSpellOnNPCBot(Creature* bot, uint32 spell)
{
    ASSERT(bot && bot->IsNPCBot() && bot->IsInWorld() && !bot->IsFreeBot());
    bot->RemoveAurasDueToSpell(spell);
    if (Unit* botpet = bot->GetBotsPet())
        botpet->RemoveAurasDueToSpell(spell);
}

void InstanceScript::DoCastSpellOnNPCBot(Creature* bot, uint32 spell)
{
    ASSERT(bot && bot->IsNPCBot() && bot->IsInWorld() && !bot->IsFreeBot());
    bot->CastSpell(bot, spell, true);
    if (Unit* botpet = bot->GetBotsPet())
        botpet->CastSpell(botpet, spell, true);
}
//end npcbot

void InstanceScript::DoCastSpellOnPlayer(Player* player, uint32 spell, bool includePets /*= false*/, bool includeControlled /*= false*/)
{
    if (!player)
        return;

    player->CastSpell(player, spell, true);

    if (!includePets)
        return;

    for (uint8 itr2 = 0; itr2 < MAX_SUMMON_SLOT; ++itr2)
    {
        ObjectGuid summonGUID = player->m_SummonSlot[itr2];
        if (!summonGUID.IsEmpty())
            if (Creature* summon = instance->GetCreature(summonGUID))
                summon->CastSpell(player, spell, true);
    }

    if (!includeControlled)
        return;

    for (auto itr2 = player->m_Controlled.begin(); itr2 != player->m_Controlled.end(); ++itr2)
    {
        if (Unit* controlled = *itr2)
            if (controlled->IsInWorld() && controlled->IsCreature())
                controlled->CastSpell(player, spell, true);
    }
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

void InstanceScript::LoadInstanceSavedGameobjectStateData()
{
    _objectStateMap.clear();

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SELECT_INSTANCE_SAVED_DATA);
    stmt->SetData(0, instance->GetInstanceId());

    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
    {
        Field* fields;

        do
        {
            fields = result->Fetch();
            StoreGameObjectState(fields[0].Get<uint32>(), fields[1].Get<uint8>());

        } while (result->NextRow());
    }
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

uint8 InstanceScript::GetStoredGameObjectState(ObjectGuid::LowType spawnId) const
{
    auto i = _objectStateMap.find(spawnId);

    if (i != _objectStateMap.end())
    {
        return i->second;
    }

    return 3; // Any state higher than 2 to get the default state for the object we are loading.
}

bool InstanceHasScript(WorldObject const* obj, char const* scriptName)
{
    if (InstanceMap* instance = obj->GetMap()->ToInstanceMap())
    {
        return instance->GetScriptName() == scriptName;
    }

    return false;
}
