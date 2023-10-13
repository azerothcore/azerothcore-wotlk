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
#include "ChallengeModeMgr.h"
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
#include "ObjectMgr.h"

struct MapChallengeModeEntry;

uint32 GO_REWARD_CHEST  = 1000001;
uint64 GO_KEY_START = 1000000;

BossBoundaryData::~BossBoundaryData()
{
    for (const_iterator it = begin(); it != end(); ++it)
        delete it->boundary;
}

void InstanceScript::SaveToDB()
{
    std::string data = GetSaveData();

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

    Difficulty difficulty = instance->GetDifficulty();
    if (difficulty != Difficulty::REGULAR_DIFFICULTY) {
        if (InstanceDifficultyMultiplier const* multiplier = sObjectMgr->GetInstanceDifficultyMultiplier(instance->GetId(), difficulty))
            creature->SetBaseHealth(creature->GetMaxHealth() * multiplier->healthMultiplier);

        creature->SetLevel(DEFAULT_MAX_LEVEL);
    }

    if (IsChallengeModeStarted())
        if (!creature->IsPet())
            CastChallengeCreatureSpell(creature);
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

void InstanceScript::OnPlayerEnter(Player* player)
{
    if (IsChallengeModeStarted())
    {
        SendChallengeModeStart(player);
        SendChallengeModeElapsedTimer(player);
        SendChallengeModeDeathCount(player);

        CastChallengePlayerSpell(player);
    }
}

void InstanceScript::OnPlayerExit(Player* player)
{
    player->RemoveAurasDueToSpell(SPELL_CHALLENGER_BURDEN);
}

void InstanceScript::OnPlayerDeath(Player* /*player*/)
{
    if (IsChallengeModeStarted())
    {
        _challengeModeDeathCount++;

        DoOnPlayers([this](Player* player)
            {
                SendChallengeModeElapsedTimer(player);
                SendChallengeModeDeathCount(player);
            });
    }
}

void InstanceScript::UpdateOperations(uint32 const diff)
{
    for (auto itr = timedDelayedOperations.begin(); itr != timedDelayedOperations.end(); itr++)
    {
        itr->first -= diff;

        if (itr->first < 0)
        {
            itr->second();
            itr->second = nullptr;
        }
    }

    uint32 timedDelayedOperationCountToRemove = std::count_if(std::begin(timedDelayedOperations), std::end(timedDelayedOperations), [](const std::pair<int32, std::function<void()>>& pair) -> bool
        {
            return pair.second == nullptr;
        });

    for (uint32 i = 0; i < timedDelayedOperationCountToRemove; i++)
    {
        auto itr = std::find_if(std::begin(timedDelayedOperations), std::end(timedDelayedOperations), [](const std::pair<int32, std::function<void()>>& p_Pair) -> bool
            {
                return p_Pair.second == nullptr;
            });

        if (itr != std::end(timedDelayedOperations))
            timedDelayedOperations.erase(itr);
    }

    if (timedDelayedOperations.empty() && !emptyWarned)
    {
        emptyWarned = true;
        LastOperationCalled();
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

void InstanceScript::DoRemoveAurasDueToSpellOnPlayers(uint32 spell)
{
    DoOnPlayers([spell](Player* player)
        {
            player->RemoveAurasDueToSpell(spell);

            if (Pet* pet = player->GetPet())
                pet->RemoveAurasDueToSpell(spell);
        });
}

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
            if (controlled->IsInWorld() && controlled->GetTypeId() == TYPEID_UNIT)
                controlled->CastSpell(player, spell, true);
    }
}


void InstanceScript::DoCastSpellOnPlayers(uint32 spell, Unit* caster /*= nullptr*/, bool triggered /*= true*/)
{
    DoOnPlayers([spell, caster, triggered](Player* player)
        {
            Unit* spellCaster = caster ? caster : player;
            spellCaster->CastSpell(player, spell, triggered);
        });
}

void InstanceScript::DoOnPlayers(std::function<void(Player*)>&& function)
{
    Map::PlayerList const& plrList = instance->GetPlayers();

    if (!plrList.IsEmpty())
        for (Map::PlayerList::const_iterator i = plrList.begin(); i != plrList.end(); ++i)
            if (Player* player = i->GetSource())
                function(player);
}

void InstanceScript::DoNearTeleportPlayers(const Position pos, bool casting /*=false*/)
{
    DoOnPlayers([pos, casting](Player* player)
        {
            player->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), casting);
        });
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

void InstanceScript::SetEntranceLocation(uint32 worldSafeLocationId)
{
    _entranceId = worldSafeLocationId;
    if (_temporaryEntranceId)
        _temporaryEntranceId = 0;
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

class ChallengeModeWorker
{
public:
    ChallengeModeWorker(InstanceScript* instance) : _instance(instance) { }

    void Visit(std::unordered_map<ObjectGuid, Creature*>& creatureMap)
    {
        for (auto const& p : creatureMap)
        {
            if (p.second->IsInWorld() && !p.second->IsPet())
            {
                if (!p.second->IsAlive())
                    p.second->Respawn();

                Difficulty difficulty = _instance->instance->GetDifficulty();
                if (difficulty != Difficulty::REGULAR_DIFFICULTY) {
                    if (InstanceDifficultyMultiplier const* multiplier = sObjectMgr->GetInstanceDifficultyMultiplier(_instance->instance->GetId(), difficulty))
                        p.second->SetBaseHealth(p.second->GetMaxHealth() * multiplier->healthMultiplier);

                    p.second->SetLevel(DEFAULT_MAX_LEVEL);
                }

                _instance->CastChallengeCreatureSpell(p.second);
            }
        }
    }

    template<class T>
    void Visit(std::unordered_map<ObjectGuid, T*>&) { }

private:
    InstanceScript* _instance;
};

void InstanceScript::StartChallengeMode(Player* player, KeyInfo* key, uint8 level, uint32 affixOne, uint32 affixTwo, uint32 affixThree)
{
    if (IsChallengeModeStarted())
        return;

    if (GetCompletedEncounterMask() != 0)
        return;

    //GameObject const* go = ObjectAccessor::GetGameObject(*player, ObjectGuid(GO_KEY_START));
    //if (go && go->IsWithinDistInMap(player, go->GetCombatReach() + 5.0f))
    //{
    //    instance->RemoveFromMap(go, false);
    //}

    _challengeModeStarted = true;
    _challengeModeLevel = level;
    _challengeOwner = player;
    _challengeEntranceLoc;

    tierOneAffix = affixOne;
    tierTwoAffix = affixTwo;
    tierThreeAffix = affixThree;

    _challengeKey = key;
    _challengeModeTimerMax = key->baseTimer;
    if (auto affix = sObjectMgr->GetAffix(tierOneAffix))
        _challengeModeTimerMax += affix->timerDiff;
    if (auto affix = sObjectMgr->GetAffix(tierTwoAffix))
        _challengeModeTimerMax += affix->timerDiff;
    if (auto affix = sObjectMgr->GetAffix(tierThreeAffix))
        _challengeModeTimerMax += affix->timerDiff;

    _challengeModeCriteria = new ChallengeModeCriteria(instance);

    // Add the health/dmg modifier aura to all creatures
    ChallengeModeWorker worker(this);
    TypeContainerVisitor<ChallengeModeWorker, MapStoredObjectTypesContainer> visitor(worker);
    visitor.Visit(instance->GetObjectsStore());

    // Tp back all players to begin
    if (WorldSafeLocsEntry const* entranceSafeLocEntry = sObjectMgr->GetWorldSafeLoc(GetEntranceLocation()))
        _challengeEntranceLoc.Relocate(entranceSafeLocEntry->Loc);
    else if (AreaTriggerTeleport const* areaTrigger = sObjectMgr->GetMapEntranceTrigger(instance->GetId()))
        _challengeEntranceLoc.Relocate(areaTrigger->target_X, areaTrigger->target_Y, areaTrigger->target_Z, areaTrigger->target_Orientation);
    DoNearTeleportPlayers(_challengeEntranceLoc);

    if (_challengeModeDoorPosition.has_value())
        instance->SummonGameObject(GOB_CHALLENGER_DOOR, *_challengeModeDoorPosition, 0, 0, 0, 1.0f, WEEK);

    DoOnPlayers([this](Player* player)
        {
            CastChallengePlayerSpell(player);
        });

    AddTimedDelayedOperation(10000, [this]()
        {
            _challengeModeStartTime = getMSTime();
            DoOnPlayers([this](Player* player)
                {
                    SendChallengeModeStart(player);
                });

            if (GameObject* door = GetGameObject(GOB_CHALLENGER_DOOR))
                DoUseDoorOrButton(door->GetGUID(), WEEK);
        });
}

void InstanceScript::CompleteChallengeMode(Position pos)
{
    if (!IsChallengeModeStarted())
        return;

    uint32 totalDuration = GetChallengeModeCurrentDuration();

    uint8 mythicIncrement = 0;

    if (totalDuration < _challengeModeTimerMax)
        ++mythicIncrement;
    if (totalDuration < _challengeModeTimerMax*.8)
        ++mythicIncrement;
    if (totalDuration < _challengeModeTimerMax*.6)
        ++mythicIncrement;

    _challengeOwner->DestroyItemCount(_challengeKey->itemId, 1, true);
    DoOnPlayers([this, mythicIncrement](Player* player)
        {
            player->SendForgeUIMsg(ForgeTopic::MYTHIC_KEY_COMPLETED, "done");
            player->AddChallengeKey(sChallengeModeMgr->GetRandomChallengeId(), std::max(_challengeModeLevel + mythicIncrement, 10));
        });

    // Achievements only if timer respected
    if (mythicIncrement)
    {
        // Potential for m+ achievements
        /*if (_challengeModeLevel >= 2)
            DoCompleteAchievement(11183);

        if (_challengeModeLevel >= 5)
            DoCompleteAchievement(11184);

        if (_challengeModeLevel >= 10)
            DoCompleteAchievement(11185);

        if (_challengeModeLevel >= 15)
        {
            DoCompleteAchievement(11162);
            DoCompleteAchievement(11224);
        }*/
    }
    _challengeModeStarted = false;
    SpawnChallengeModeRewardChest(pos);

    DoOnPlayers([this](Player* player)
        {
            sChallengeModeMgr->Reward(player, _challengeModeLevel);
        });

}

uint32 InstanceScript::GetChallengeModeCurrentDuration() 
{
    return uint32(GetMSTimeDiffToNow(_challengeModeStartTime) / 1000) + (5 * _challengeModeDeathCount);
}

void InstanceScript::SendChallengeModeStart(Player* player) 
{
    auto challengeMod = sObjectMgr->GetMythicDifficultyScale(_challengeModeLevel);
    if (!challengeMod)
        return;

    std::string initKey = (std::string)instance->GetMapName() + "*" + std::to_string(_challengeModeLevel) + "*" + std::to_string(_challengeModeTimerMax);
    player->SendForgeUIMsg(ForgeTopic::MYTHIC_SET_AFFIXES_AND_START, initKey);

    SendChallengeModeDeathCount(player);
    SendChallengeModeElapsedTimer(player);
    SendChallengeModeCriteria(player);
}

void InstanceScript::SendChallengeModeCriteria(Player* player)
{
    if (IsChallengeModeStarted()) {
        std::string out = "";
        int i = 0;
        for (auto criterion : _challengeModeCriteria->_criteria) {
            auto delim = "";
            if (i > 0)
                delim = "*";

            std::string name = std::to_string(criterion.first);
            auto value = std::to_string(criterion.second);
            if (criterion.first > 0) {
                if (auto ct = sObjectMgr->GetCreatureTemplate(criterion.first)) {
                    name = ct->Name;
                    value = value.substr(0, 1);
                }
            }
            else
                value = value.substr(0, value.find(".") + 2);

            // crit id to status
            out += delim + name + "~" + value;
            i++;
        }

        player->SendForgeUIMsg(ForgeTopic::MYTHIC_UPDATE_CRITERIA, out);
    }
}

void InstanceScript::SendChallengeModeDeathCount(Player* player/* = nullptr*/) 
{
    if (IsChallengeModeStarted())
        player->SendForgeUIMsg(ForgeTopic::MYTHIC_UPDATE_DEATHS, std::to_string(_challengeModeDeathCount));
}

void InstanceScript::SendChallengeModeElapsedTimer(Player* player/* = nullptr*/)
{
    if (IsChallengeModeStarted()) {
        auto duration = GetChallengeModeCurrentDuration();
        player->SendForgeUIMsg(ForgeTopic::MYTHIC_UPDATE_TIMER, std::to_string(duration));
    }
}

void InstanceScript::CastChallengeCreatureSpell(Creature* creature)
{
    if (auto challengeMod = sObjectMgr->GetMythicDifficultyScale(_challengeModeLevel)) {
        float mod = challengeMod->mod;
        CustomSpellValues values;
        values.AddSpellMod(SPELLVALUE_BASE_POINT0, mod);
        values.AddSpellMod(SPELLVALUE_BASE_POINT1, mod);

        // Affixes
        //values.AddSpellMod(SPELLVALUE_BASE_POINT2, 0); // 6 Raging
        //values.AddSpellMod(SPELLVALUE_BASE_POINT3, 0); // 7 Bolstering
        //values.AddSpellMod(SPELLVALUE_BASE_POINT4, 0); // 9 Tyrannical
        //values.AddSpellMod(SPELLVALUE_BASE_POINT5, 0); //
        //values.AddSpellMod(SPELLVALUE_BASE_POINT6, 0); //
        //values.AddSpellMod(SPELLVALUE_BASE_POINT7, 0); // 3 Volcanic
        //values.AddSpellMod(SPELLVALUE_BASE_POINT8, 0); // 4 Necrotic
        //values.AddSpellMod(SPELLVALUE_BASE_POINT9, 0); // 10 Fortified
        //values.AddSpellMod(SPELLVALUE_BASE_POINT10, 0); // 8 Sanguine
        //values.AddSpellMod(SPELLVALUE_BASE_POINT11, 0); // 14 Quaking
        //values.AddSpellMod(SPELLVALUE_BASE_POINT12, 0); // 13 Explosive
        //values.AddSpellMod(SPELLVALUE_BASE_POINT13, 0); // 11 Bursting

        creature->CastCustomSpell(SPELL_CHALLENGER_MIGHT, values, creature, TRIGGERED_FULL_MASK);
    }
}

void InstanceScript::CastChallengePlayerSpell(Player* player)
{
    CustomSpellValues values;

    // Affixes
    values.AddSpellMod(SPELLVALUE_BASE_POINT0, 0); // 12 Grievous
    values.AddSpellMod(SPELLVALUE_BASE_POINT1, 0); // 2 Skittish
    values.AddSpellMod(SPELLVALUE_BASE_POINT2, 0); //

    player->CastCustomSpell(SPELL_CHALLENGER_BURDEN, values, player, TRIGGERED_FULL_MASK);
}

bool InstanceHasScript(WorldObject const* obj, char const* scriptName)
{
    if (InstanceMap* instance = obj->GetMap()->ToInstanceMap())
    {
        return instance->GetScriptName() == scriptName;
    }

    return false;
}

void InstanceScript::SpawnChallengeModeRewardChest(Position p) {
    if (IsChallengeModeStarted()) {
        GameObject* chest = _challengeOwner->SummonGameObject(GO_REWARD_CHEST, p.GetPositionX(), p.GetPositionY(), p.GetPositionZ(), 0, 0, 0, 0, 0, 0);
    }
}
