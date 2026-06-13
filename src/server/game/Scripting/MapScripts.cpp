/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CellImpl.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Map.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Transport.h"
#include "WaypointMgr.h"

/// Put scripts in the execution queue
void Map::ScriptsStart(ScriptMapMap const& scripts, uint32 id, Object* source, Object* target)
{
    ///- Find the script map
    ScriptMapMap::const_iterator s = scripts.find(id);
    if (s == scripts.end())
        return;

    // prepare static data
    ObjectGuid sourceGUID = source ? source->GetGUID() : ObjectGuid::Empty; //some script commands doesn't have source
    ObjectGuid targetGUID = target ? target->GetGUID() : ObjectGuid::Empty;
    ObjectGuid ownerGUID  = (source && source->IsItem()) ? ((Item*)source)->GetOwnerGUID() : ObjectGuid::Empty;

    ///- Schedule script execution for all scripts in the script map
    ScriptMap const* s2 = &(s->second);
    bool immedScript = false;
    for (ScriptMap::const_iterator iter = s2->begin(); iter != s2->end(); ++iter)
    {
        ScriptAction sa;
        sa.sourceGUID = sourceGUID;
        sa.targetGUID = targetGUID;
        sa.ownerGUID  = ownerGUID;

        sa.script = &iter->second;
        m_scriptSchedule.insert(ScriptScheduleMap::value_type(time_t(GameTime::GetGameTime().count() + iter->first), sa));
        if (iter->first == 0)
            immedScript = true;

        sScriptMgr->IncreaseScheduledScriptsCount();
    }
    ///- If one of the effects should be immediate, launch the script execution
    if (/*start &&*/ immedScript && !i_scriptLock)
    {
        i_scriptLock = true;
        ScriptsProcess();
        i_scriptLock = false;
    }
}

void Map::ScriptCommandStart(ScriptInfo const& script, uint32 delay, Object* source, Object* target)
{
    // NOTE: script record _must_ exist until command executed

    // prepare static data
    ObjectGuid sourceGUID = source ? source->GetGUID() : ObjectGuid::Empty;
    ObjectGuid targetGUID = target ? target->GetGUID() : ObjectGuid::Empty;
    ObjectGuid ownerGUID  = (source && source->IsItem()) ? ((Item*)source)->GetOwnerGUID() : ObjectGuid::Empty;

    ScriptAction sa;
    sa.sourceGUID = sourceGUID;
    sa.targetGUID = targetGUID;
    sa.ownerGUID  = ownerGUID;

    sa.script = &script;
    m_scriptSchedule.insert(ScriptScheduleMap::value_type(time_t(GameTime::GetGameTime().count() + delay), sa));

    sScriptMgr->IncreaseScheduledScriptsCount();

    ///- If effects should be immediate, launch the script execution
    if (delay == 0 && !i_scriptLock)
    {
        i_scriptLock = true;
        ScriptsProcess();
        i_scriptLock = false;
    }
}

// Helpers for ScriptProcess method.
inline Player* Map::_GetScriptPlayerSourceOrTarget(Object* source, Object* target, const ScriptInfo* scriptInfo) const
{
    Player* player = nullptr;
    if (!source && !target)
        LOG_ERROR("maps.script", "{} source and target objects are nullptr.", scriptInfo->GetDebugInfo());
    else
    {
        // Check target first, then source.
        if (target)
            player = target->ToPlayer();
        if (!player && source)
            player = source->ToPlayer();

        if (!player)
            LOG_ERROR("maps.script", "{} neither source nor target object is player (source: TypeId: {}, Entry: {}, GUID: {}; target: TypeId: {}, Entry: {}, GUID: {}), skipping.",
                           scriptInfo->GetDebugInfo(),
                           source ? source->GetTypeId() : 0, source ? source->GetEntry() : 0, source ? source->GetGUID().ToString() : "",
                           target ? target->GetTypeId() : 0, target ? target->GetEntry() : 0, target ? target->GetGUID().ToString() : "");
    }
    return player;
}

inline Creature* Map::_GetScriptCreatureSourceOrTarget(Object* source, Object* target, const ScriptInfo* scriptInfo, bool bReverse) const
{
    Creature* creature = nullptr;
    if (!source && !target)
        LOG_ERROR("maps.script", "{} source and target objects are nullptr.", scriptInfo->GetDebugInfo());
    else
    {
        if (bReverse)
        {
            // Check target first, then source.
            if (target)
                creature = target->ToCreature();
            if (!creature && source)
                creature = source->ToCreature();
        }
        else
        {
            // Check source first, then target.
            if (source)
                creature = source->ToCreature();
            if (!creature && target)
                creature = target->ToCreature();
        }

        if (!creature)
            LOG_ERROR("maps.script", "{} neither source nor target are creatures (source: TypeId: {}, Entry: {}, GUID: {}; target: TypeId: {}, Entry: {}, GUID: {}), skipping.",
                           scriptInfo->GetDebugInfo(),
                           source ? source->GetTypeId() : 0, source ? source->GetEntry() : 0, source ? source->GetGUID().ToString() : "",
                           target ? target->GetTypeId() : 0, target ? target->GetEntry() : 0, target ? target->GetGUID().ToString() : "");
    }
    return creature;
}

inline Unit* Map::_GetScriptUnit(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const
{
    Unit* unit = nullptr;
    if (!obj)
        LOG_ERROR("maps.script", "{} {} object is nullptr.", scriptInfo->GetDebugInfo(), isSource ? "source" : "target");
    else if (!obj->IsUnit())
        LOG_ERROR("maps.script", "{} {} object is not unit (TypeId: {}, Entry: {}, GUID: {}), skipping.",
                       scriptInfo->GetDebugInfo(), isSource ? "source" : "target", obj->GetTypeId(), obj->GetEntry(), obj->GetGUID().ToString());
    else
    {
        unit = obj->ToUnit();
        if (!unit)
            LOG_ERROR("maps.script", "{} {} object could not be casted to unit.",
                           scriptInfo->GetDebugInfo(), isSource ? "source" : "target");
    }
    return unit;
}

inline Player* Map::_GetScriptPlayer(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const
{
    Player* player = nullptr;
    if (!obj)
        LOG_ERROR("maps.script", "{} {} object is nullptr.", scriptInfo->GetDebugInfo(), isSource ? "source" : "target");
    else
    {
        player = obj->ToPlayer();
        if (!player)
            LOG_ERROR("maps.script", "{} {} object is not a player ({}).",
                           scriptInfo->GetDebugInfo(), isSource ? "source" : "target", obj->GetGUID().ToString());
    }
    return player;
}

inline Creature* Map::_GetScriptCreature(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const
{
    Creature* creature = nullptr;
    if (!obj)
        LOG_ERROR("maps.script", "{} {} object is nullptr.", scriptInfo->GetDebugInfo(), isSource ? "source" : "target");
    else
    {
        creature = obj->ToCreature();
        if (!creature)
            LOG_ERROR("maps.script", "{} {} object is not a creature ({}).", scriptInfo->GetDebugInfo(),
                           isSource ? "source" : "target", obj->GetGUID().ToString());
    }
    return creature;
}

inline WorldObject* Map::_GetScriptWorldObject(Object* obj, bool isSource, const ScriptInfo* scriptInfo) const
{
    WorldObject* pWorldObject = nullptr;
    if (!obj)
        LOG_ERROR("maps.script", "{} {} object is nullptr.",
                       scriptInfo->GetDebugInfo(), isSource ? "source" : "target");
    else
    {
        pWorldObject = dynamic_cast<WorldObject*>(obj);
        if (!pWorldObject)
            LOG_ERROR("maps.script", "{} {} object is not a world object ({}).",
                           scriptInfo->GetDebugInfo(), isSource ? "source" : "target", obj->GetGUID().ToString());
    }
    return pWorldObject;
}

inline void Map::_ScriptProcessDoor(Object* source, Object* target, const ScriptInfo* scriptInfo) const
{
    bool bOpen = false;
    ObjectGuid::LowType guid = scriptInfo->ToggleDoor.GOGuid;
    int32 nTimeToToggle = std::max(15, int32(scriptInfo->ToggleDoor.ResetDelay));
    switch (scriptInfo->command)
    {
        case SCRIPT_COMMAND_OPEN_DOOR:
            bOpen = true;
            break;
        case SCRIPT_COMMAND_CLOSE_DOOR:
            break;
        default:
            LOG_ERROR("maps.script", "{} unknown command for _ScriptProcessDoor.", scriptInfo->GetDebugInfo());
            return;
    }
    if (!guid)
        LOG_ERROR("maps.script", "{} door guid is not specified.", scriptInfo->GetDebugInfo());
    else if (!source)
        LOG_ERROR("maps.script", "{} source object is nullptr.", scriptInfo->GetDebugInfo());
    else if (!source->IsUnit())
        LOG_ERROR("maps.script", "{} source object is not unit ({}), skipping.", scriptInfo->GetDebugInfo(), source->GetGUID().ToString());
    else
    {
        WorldObject* wSource = dynamic_cast <WorldObject*> (source);
        if (!wSource)
            LOG_ERROR("maps.script", "{} source object could not be casted to world object ({}), skipping.", scriptInfo->GetDebugInfo(), source->GetGUID().ToString());
        else
        {
            GameObject* pDoor = _FindGameObject(wSource, guid);
            if (!pDoor)
                LOG_ERROR("maps.script", "{} gameobject was not found (guid: {}).", scriptInfo->GetDebugInfo(), guid);
            else if (pDoor->GetGoType() != GAMEOBJECT_TYPE_DOOR)
                LOG_ERROR("maps.script", "{} gameobject is not a door ({}).",
                               scriptInfo->GetDebugInfo(), pDoor->GetGUID().ToString());
            else if (bOpen == (pDoor->GetGoState() == GO_STATE_READY))
            {
                pDoor->UseDoorOrButton(nTimeToToggle);

                if (target && target->isType(TYPEMASK_GAMEOBJECT))
                {
                    GameObject* goTarget = target->ToGameObject();
                    if (goTarget && goTarget->GetGoType() == GAMEOBJECT_TYPE_BUTTON)
                        goTarget->UseDoorOrButton(nTimeToToggle);
                }
            }
        }
    }
}

inline GameObject* Map::_FindGameObject(WorldObject* searchObject, ObjectGuid::LowType guid) const
{
    auto bounds = searchObject->GetMap()->GetGameObjectBySpawnIdStore().equal_range(guid);
    if (bounds.first == bounds.second)
        return nullptr;

    return bounds.first->second;
}

/// Process queued scripts
void Map::ScriptsProcess()
{
    if (m_scriptSchedule.empty())
        return;

    ///- Process overdue queued scripts
    ScriptScheduleMap::iterator iter = m_scriptSchedule.begin();
    // ok as multimap is a *sorted* associative container
    while (!m_scriptSchedule.empty() && (iter->first <= GameTime::GetGameTime().count()))
    {
        ScriptAction const& step = iter->second;

        Object* source = nullptr;
        if (step.sourceGUID)
        {
            switch (step.sourceGUID.GetHigh())
            {
                case HighGuid::Item: // as well as HIGHGUID_CONTAINER
                    if (Player* player = ObjectAccessor::GetPlayer(this, step.ownerGUID))
                        source = player->GetItemByGuid(step.sourceGUID);
                    break;
                case HighGuid::Unit:
                case HighGuid::Vehicle:
                    source = GetCreature(step.sourceGUID);
                    break;
                case HighGuid::Pet:
                    source = GetPet(step.sourceGUID);
                    break;
                case HighGuid::Player:
                    source = HashMapHolder<Player>::Find(step.sourceGUID);
                    break;
                case HighGuid::Transport:
                case HighGuid::GameObject:
                    source = GetGameObject(step.sourceGUID);
                    break;
                case HighGuid::Corpse:
                    source = GetCorpse(step.sourceGUID);
                    break;
                case HighGuid::Mo_Transport:
                    source = GetTransport(step.sourceGUID);
                    break;
                default:
                    LOG_ERROR("maps.script", "{} source with unsupported high guid ({}).",
                                   step.script->GetDebugInfo(), step.sourceGUID.ToString());
                    break;
            }
        }

        WorldObject* target = nullptr;
        if (step.targetGUID)
        {
            switch (step.targetGUID.GetHigh())
            {
                case HighGuid::Unit:
                case HighGuid::Vehicle:
                    target = GetCreature(step.targetGUID);
                    break;
                case HighGuid::Pet:
                    target = GetPet(step.targetGUID);
                    break;
                case HighGuid::Player:                       // empty GUID case also
                    target = HashMapHolder<Player>::Find(step.targetGUID);
                    break;
                case HighGuid::Transport:
                case HighGuid::GameObject:
                    target = GetGameObject(step.targetGUID);
                    break;
                case HighGuid::Corpse:
                    target = GetCorpse(step.targetGUID);
                    break;
                case HighGuid::Mo_Transport:
                    target = GetTransport(step.targetGUID);
                    break;
                default:
                    LOG_ERROR("maps.script", "{} target with unsupported high guid ({}).",
                                   step.script->GetDebugInfo(), step.targetGUID.ToString());
                    break;
            }
        }

        switch (step.script->command)
        {
            case SCRIPT_COMMAND_TALK:
            {
                if (step.script->Talk.ChatType > CHAT_TYPE_WHISPER && step.script->Talk.ChatType != CHAT_MSG_RAID_BOSS_WHISPER)
                {
                    LOG_ERROR("maps.script", "{} invalid chat type ({}) specified, skipping.", step.script->GetDebugInfo(), step.script->Talk.ChatType);
                    break;
                }

                if (step.script->Talk.Flags & SF_TALK_USE_PLAYER)
                {
                    source = _GetScriptPlayerSourceOrTarget(source, target, step.script);
                }
                else
                {
                    source = _GetScriptCreatureSourceOrTarget(source, target, step.script);
                }

                if (source)
                {
                    Unit* sourceUnit = source->ToUnit();
                    if (!sourceUnit)
                    {
                        LOG_ERROR("scripts", "{} source object ({}) is not an unit, skipping.", step.script->GetDebugInfo(), source->GetGUID().ToString());
                        break;
                    }

                    switch (step.script->Talk.ChatType)
                    {
                        case CHAT_TYPE_SAY:
                            sourceUnit->Say(step.script->Talk.TextID, target);
                            break;
                        case CHAT_TYPE_YELL:
                            sourceUnit->Yell(step.script->Talk.TextID, target);
                            break;
                        case CHAT_TYPE_TEXT_EMOTE:
                        case CHAT_TYPE_BOSS_EMOTE:
                            sourceUnit->TextEmote(step.script->Talk.TextID, target, step.script->Talk.ChatType == CHAT_TYPE_BOSS_EMOTE);
                            break;
                        case CHAT_TYPE_WHISPER:
                        case CHAT_MSG_RAID_BOSS_WHISPER:
                        {
                            Player* receiver = target ? target->ToPlayer() : nullptr;
                            if (!receiver)
                                LOG_ERROR("scripts", "{} attempt to whisper to non-player unit, skipping.", step.script->GetDebugInfo());
                            else
                                sourceUnit->Whisper(step.script->Talk.TextID, receiver, step.script->Talk.ChatType == CHAT_MSG_RAID_BOSS_WHISPER);
                            break;
                        }
                        default:
                            break;                              // must be already checked at load
                    }
                }
                break;
            }
            case SCRIPT_COMMAND_EMOTE:
                // Source or target must be Creature.
                if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script))
                {
                    if (step.script->Emote.Flags & SF_EMOTE_USE_STATE)
                        cSource->SetUInt32Value(UNIT_NPC_EMOTESTATE, step.script->Emote.EmoteID);
                    else
                        cSource->HandleEmoteCommand(step.script->Emote.EmoteID);
                }
                break;

            case SCRIPT_COMMAND_FIELD_SET:
                // Source or target must be Creature.
                if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script))
                {
                    // Validate field number.
                    if (step.script->FieldSet.FieldID <= OBJECT_FIELD_ENTRY || step.script->FieldSet.FieldID >= cSource->GetValuesCount())
                        LOG_ERROR("maps.script", "{} wrong field {} (max count: {}) in object ({}) specified, skipping.",
                                       step.script->GetDebugInfo(), step.script->FieldSet.FieldID, cSource->GetValuesCount(), cSource->GetGUID().ToString());
                    else
                        cSource->SetUInt32Value(step.script->FieldSet.FieldID, step.script->FieldSet.FieldValue);
                }
                break;

            case SCRIPT_COMMAND_MOVE_TO:
                // Source or target must be Creature.
                if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script))
                {
                    Unit* unit = (Unit*)cSource;
                    if (step.script->MoveTo.TravelTime != 0)
                    {
                        float speed = unit->GetDistance(step.script->MoveTo.DestX, step.script->MoveTo.DestY, step.script->MoveTo.DestZ) / ((float)step.script->MoveTo.TravelTime * 0.001f);
                        unit->GetMotionMaster()->MovePoint(0, step.script->MoveTo.DestX, step.script->MoveTo.DestY, step.script->MoveTo.DestZ, FORCED_MOVEMENT_NONE, speed);
                    }
                    else
                        unit->NearTeleportTo(step.script->MoveTo.DestX, step.script->MoveTo.DestY, step.script->MoveTo.DestZ, unit->GetOrientation());
                }
                break;

            case SCRIPT_COMMAND_FLAG_SET:
                // Source or target must be Creature.
                if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script))
                {
                    // Validate field number.
                    if (step.script->FlagToggle.FieldID <= OBJECT_FIELD_ENTRY || step.script->FlagToggle.FieldID >= cSource->GetValuesCount())
                        LOG_ERROR("maps.script", "{} wrong field {} (max count: {}) in object ({}) specified, skipping.",
                                       step.script->GetDebugInfo(), step.script->FlagToggle.FieldID, cSource->GetValuesCount(), cSource->GetGUID().ToString());
                    else
                        cSource->SetFlag(step.script->FlagToggle.FieldID, step.script->FlagToggle.FieldValue);
                }
                break;

            case SCRIPT_COMMAND_FLAG_REMOVE:
                // Source or target must be Creature.
                if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script))
                {
                    // Validate field number.
                    if (step.script->FlagToggle.FieldID <= OBJECT_FIELD_ENTRY || step.script->FlagToggle.FieldID >= cSource->GetValuesCount())
                        LOG_ERROR("maps.script", "{} wrong field {} (max count: {}) in object ({}) specified, skipping.",
                                       step.script->GetDebugInfo(), step.script->FlagToggle.FieldID, cSource->GetValuesCount(),  cSource->GetGUID().ToString());
                    else
                        cSource->RemoveFlag(step.script->FlagToggle.FieldID, step.script->FlagToggle.FieldValue);
                }
                break;

            case SCRIPT_COMMAND_TELEPORT_TO:
                if (step.script->TeleportTo.Flags & SF_TELEPORT_USE_CREATURE)
                {
                    // Source or target must be Creature.
                    if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script, true))
                        cSource->NearTeleportTo(step.script->TeleportTo.DestX, step.script->TeleportTo.DestY, step.script->TeleportTo.DestZ, step.script->TeleportTo.Orientation);
                }
                else
                {
                    // Source or target must be Player.
                    if (Player* player = _GetScriptPlayerSourceOrTarget(source, target, step.script))
                        player->TeleportTo(step.script->TeleportTo.MapID, step.script->TeleportTo.DestX, step.script->TeleportTo.DestY, step.script->TeleportTo.DestZ, step.script->TeleportTo.Orientation);
                }
                break;

            case SCRIPT_COMMAND_QUEST_EXPLORED:
                {
                    if (!source)
                    {
                        LOG_ERROR("maps.script", "{} source object is nullptr.", step.script->GetDebugInfo());
                        break;
                    }
                    if (!target)
                    {
                        LOG_ERROR("maps.script", "{} target object is nullptr.", step.script->GetDebugInfo());
                        break;
                    }

                    // when script called for item spell casting then target == (unit or GO) and source is player
                    WorldObject* worldObject;
                    Player* player = target->ToPlayer();
                    if (player)
                    {
                        if (!source->IsCreature() && !source->IsGameObject() && !source->IsPlayer())
                        {
                            LOG_ERROR("maps.script", "{} source is not unit, gameobject or player ({}), skipping.", step.script->GetDebugInfo(), source->GetGUID().ToString());
                            break;
                        }
                        worldObject = dynamic_cast<WorldObject*>(source);
                    }
                    else
                    {
                        player = source->ToPlayer();
                        if (player)
                        {
                            if (!target->IsCreature() && !target->IsGameObject() && !target->IsPlayer())
                            {
                                LOG_ERROR("maps.script", "{} target is not unit, gameobject or player ({}), skipping.", step.script->GetDebugInfo(), target->GetGUID().ToString());
                                break;
                            }
                            worldObject = dynamic_cast<WorldObject*>(target);
                        }
                        else
                        {
                            LOG_ERROR("maps.script", "{} neither source nor target is player (source: {}; target: {}), skipping.",
                                           step.script->GetDebugInfo(), source->GetGUID().ToString(), target->GetGUID().ToString());
                            break;
                        }
                    }

                    // quest id and flags checked at script loading
                    if ((!worldObject->IsCreature() || ((Unit*)worldObject)->IsAlive()) &&
                            (step.script->QuestExplored.Distance == 0 || worldObject->IsWithinDistInMap(player, float(step.script->QuestExplored.Distance))))
                        player->GroupEventHappens(step.script->QuestExplored.QuestID, worldObject);
                    else
                        player->FailQuest(step.script->QuestExplored.QuestID);

                    break;
                }

            case SCRIPT_COMMAND_KILL_CREDIT:
                // Source or target must be Player.
                if (Player* player = _GetScriptPlayerSourceOrTarget(source, target, step.script))
                {
                    if (step.script->KillCredit.Flags & SF_KILLCREDIT_REWARD_GROUP)
                        player->RewardPlayerAndGroupAtEvent(step.script->KillCredit.CreatureEntry, player);
                    else
                        player->KilledMonsterCredit(step.script->KillCredit.CreatureEntry);
                }
                break;

            case SCRIPT_COMMAND_RESPAWN_GAMEOBJECT:
                if (!step.script->RespawnGameobject.GOGuid)
                {
                    LOG_ERROR("maps.script", "{} gameobject guid (datalong) is not specified.", step.script->GetDebugInfo());
                    break;
                }

                // Source or target must be WorldObject.
                if (WorldObject* pSummoner = _GetScriptWorldObject(source, true, step.script))
                {
                    GameObject* pGO = _FindGameObject(pSummoner, step.script->RespawnGameobject.GOGuid);
                    if (!pGO)
                    {
                        LOG_ERROR("maps.script", "{} gameobject was not found (guid: {}).", step.script->GetDebugInfo(), step.script->RespawnGameobject.GOGuid);
                        break;
                    }

                    if (pGO->GetGoType() == GAMEOBJECT_TYPE_FISHINGNODE ||
                            pGO->GetGoType() == GAMEOBJECT_TYPE_DOOR        ||
                            pGO->GetGoType() == GAMEOBJECT_TYPE_BUTTON      ||
                            pGO->GetGoType() == GAMEOBJECT_TYPE_TRAP)
                    {
                        LOG_ERROR("maps.script", "{} can not be used with gameobject of type {} (guid: {}).",
                                       step.script->GetDebugInfo(), uint32(pGO->GetGoType()), step.script->RespawnGameobject.GOGuid);
                        break;
                    }

                    // Check that GO is not spawned
                    if (!pGO->isSpawned())
                    {
                        int32 nTimeToDespawn = std::max(5, int32(step.script->RespawnGameobject.DespawnDelay));
                        pGO->SetLootState(GO_READY);
                        pGO->SetRespawnTime(nTimeToDespawn);

                        pGO->GetMap()->AddToMap(pGO);
                    }
                }
                break;

            case SCRIPT_COMMAND_TEMP_SUMMON_CREATURE:
                {
                    // Source must be WorldObject.
                    if (WorldObject* pSummoner = _GetScriptWorldObject(source, true, step.script))
                    {
                        if (!step.script->TempSummonCreature.CreatureEntry)
                            LOG_ERROR("maps.script", "{} creature entry (datalong) is not specified.", step.script->GetDebugInfo());
                        else
                        {
                            uint32 entry = step.script->TempSummonCreature.CreatureEntry;

                            float x = step.script->TempSummonCreature.PosX;
                            float y = step.script->TempSummonCreature.PosY;
                            float z = step.script->TempSummonCreature.PosZ;
                            float o = step.script->TempSummonCreature.Orientation;

                            if (step.script->TempSummonCreature.CheckIfExists)
                                if (Unit* trigger = pSummoner->SummonTrigger(x, y, z, o, 1))
                                    if (trigger->FindNearestCreature(entry, 60.0f))
                                        break;

                            if (!pSummoner->SummonCreature(entry, x, y, z, o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, step.script->TempSummonCreature.DespawnDelay))
                                LOG_ERROR("maps.script", "{} creature was not spawned (entry: {}).", step.script->GetDebugInfo(), step.script->TempSummonCreature.CreatureEntry);
                        }
                    }
                    break;
                }

            case SCRIPT_COMMAND_OPEN_DOOR:
            case SCRIPT_COMMAND_CLOSE_DOOR:
                _ScriptProcessDoor(source, target, step.script);
                break;

            case SCRIPT_COMMAND_ACTIVATE_OBJECT:
                // Source must be Unit.
                if (Unit* unit = _GetScriptUnit(source, true, step.script))
                {
                    // Target must be GameObject.
                    if (!target)
                    {
                        LOG_ERROR("maps.script", "{} target object is nullptr.", step.script->GetDebugInfo());
                        break;
                    }

                    if (!target->IsGameObject())
                    {
                        LOG_ERROR("maps.script", "{} target object is not gameobject ({}), skipping.", step.script->GetDebugInfo(), target->GetGUID().ToString());
                        break;
                    }

                    if (GameObject* pGO = target->ToGameObject())
                        pGO->Use(unit);
                }
                break;

            case SCRIPT_COMMAND_REMOVE_AURA:
                {
                    // Source (datalong2 != 0) or target (datalong2 == 0) must be Unit.
                    bool bReverse = step.script->RemoveAura.Flags & SF_REMOVEAURA_REVERSE;
                    if (Unit* unit = _GetScriptUnit(bReverse ? source : target, bReverse, step.script))
                        unit->RemoveAurasDueToSpell(step.script->RemoveAura.SpellID);
                    break;
                }

            case SCRIPT_COMMAND_CAST_SPELL:
                {
                    /// @todo: Allow gameobjects to be targets and casters
                    if (!source && !target)
                    {
                        LOG_ERROR("maps.script", "{} source and target objects are nullptr.", step.script->GetDebugInfo());
                        break;
                    }

                    Unit* uSource = nullptr;
                    Unit* uTarget = nullptr;
                    // source/target cast spell at target/source (script->datalong2: 0: s->t 1: s->s 2: t->t 3: t->s
                    switch (step.script->CastSpell.Flags)
                    {
                        case SF_CASTSPELL_SOURCE_TO_TARGET: // source -> target
                            uSource = source ? source->ToUnit() : nullptr;
                            uTarget = target ? target->ToUnit() : nullptr;
                            break;
                        case SF_CASTSPELL_SOURCE_TO_SOURCE: // source -> source
                            uSource = source ? source->ToUnit() : nullptr;
                            uTarget = uSource;
                            break;
                        case SF_CASTSPELL_TARGET_TO_TARGET: // target -> target
                            uSource = target ? target->ToUnit() : nullptr;
                            uTarget = uSource;
                            break;
                        case SF_CASTSPELL_TARGET_TO_SOURCE: // target -> source
                            uSource = target ? target->ToUnit() : nullptr;
                            uTarget = source ? source->ToUnit() : nullptr;
                            break;
                        case SF_CASTSPELL_SEARCH_CREATURE: // source -> creature with entry
                            uSource = source ? source->ToUnit() : nullptr;
                            uTarget = uSource ? GetClosestCreatureWithEntry(uSource, std::abs(step.script->CastSpell.CreatureEntry), step.script->CastSpell.SearchRadius) : nullptr;
                            break;
                    }

                    if (!uSource || !uSource->IsUnit())
                    {
                        LOG_ERROR("maps.script", "{} no source unit found for spell {}", step.script->GetDebugInfo(), step.script->CastSpell.SpellID);
                        break;
                    }

                    if (!uTarget || !uTarget->IsUnit())
                    {
                        LOG_ERROR("maps.script", "{} no target unit found for spell {}", step.script->GetDebugInfo(), step.script->CastSpell.SpellID);
                        break;
                    }

                    bool triggered = (step.script->CastSpell.Flags != 4) ?
                                     step.script->CastSpell.CreatureEntry & SF_CASTSPELL_TRIGGERED :
                                     step.script->CastSpell.CreatureEntry < 0;
                    uSource->CastSpell(uTarget, step.script->CastSpell.SpellID, triggered);
                    break;
                }

            case SCRIPT_COMMAND_PLAY_SOUND:
                // Source must be WorldObject.
                if (WorldObject* object = _GetScriptWorldObject(source, true, step.script))
                {
                    // Playsound.Flags bitmask: 0/1=anyone/target
                    Player* player = nullptr;
                    if (step.script->Playsound.Flags & SF_PLAYSOUND_TARGET_PLAYER)
                    {
                        // Target must be Player.
                        player = _GetScriptPlayer(target, false, step.script);
                        if (!target)
                            break;
                    }

                    // Playsound.Flags bitmask: 0/2/4=without/with distance dependent/radius
                    if (step.script->Playsound.Flags & SF_PLAYSOUND_DISTANCE_RADIUS)
                        object->PlayRadiusSound(step.script->Playsound.SoundID, step.script->Playsound.Radius);
                    else if (step.script->Playsound.Flags & SF_PLAYSOUND_DISTANCE_SOUND)
                        object->PlayDistanceSound(step.script->Playsound.SoundID, player);
                    else
                        object->PlayDirectSound(step.script->Playsound.SoundID, player);
                }
                break;

            case SCRIPT_COMMAND_CREATE_ITEM:
                // Target or source must be Player.
                if (Player* pReceiver = _GetScriptPlayerSourceOrTarget(source, target, step.script))
                {
                    ItemPosCountVec dest;
                    InventoryResult msg = pReceiver->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, step.script->CreateItem.ItemEntry, step.script->CreateItem.Amount);
                    if (msg == EQUIP_ERR_OK)
                    {
                        if (Item* item = pReceiver->StoreNewItem(dest, step.script->CreateItem.ItemEntry, true))
                            pReceiver->SendNewItem(item, step.script->CreateItem.Amount, false, true);
                    }
                    else
                        pReceiver->SendEquipError(msg, nullptr, nullptr, step.script->CreateItem.ItemEntry);
                }
                break;

            case SCRIPT_COMMAND_DESPAWN_SELF:
                // Target or source must be Creature.
                if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script, true))
                    cSource->DespawnOrUnsummon(Milliseconds(step.script->DespawnSelf.DespawnDelay));
                break;

            case SCRIPT_COMMAND_LOAD_PATH:
                // Source must be Unit.
                if (Unit* unit = _GetScriptUnit(source, true, step.script))
                {
                    if (!sWaypointMgr->GetPath(step.script->LoadPath.PathID))
                        LOG_ERROR("maps.script", "{} source object has an invalid path ({}), skipping.", step.script->GetDebugInfo(), step.script->LoadPath.PathID);
                    else
                        unit->GetMotionMaster()->MoveWaypoint(step.script->LoadPath.PathID, step.script->LoadPath.IsRepeatable);
                }
                break;

            case SCRIPT_COMMAND_CALLSCRIPT_TO_UNIT:
                {
                    if (!step.script->CallScript.CreatureEntry)
                    {
                        LOG_ERROR("maps.script", "{} creature entry is not specified, skipping.", step.script->GetDebugInfo());
                        break;
                    }
                    if (!step.script->CallScript.ScriptID)
                    {
                        LOG_ERROR("maps.script", "{} script id is not specified, skipping.", step.script->GetDebugInfo());
                        break;
                    }

                    Creature* cTarget = nullptr;
                    auto creatureBounds = _creatureBySpawnIdStore.equal_range(step.script->CallScript.CreatureEntry);
                    if (creatureBounds.first != creatureBounds.second)
                    {
                        // Prefer alive (last respawned) creature
                        auto creatureItr = std::find_if(creatureBounds.first, creatureBounds.second, [](Map::CreatureBySpawnIdContainer::value_type const& pair)
                        {
                            return pair.second->IsAlive();
                        });
                        cTarget = creatureItr != creatureBounds.second ? creatureItr->second : creatureBounds.first->second;
                    }

                    if (!cTarget)
                    {
                        LOG_ERROR("maps.script", "{} target was not found (entry: {})", step.script->GetDebugInfo(), step.script->CallScript.CreatureEntry);
                        break;
                    }

                    //Lets choose our ScriptMap map
                    ScriptMapMap* datamap = GetScriptsMapByType(ScriptsType(step.script->CallScript.ScriptType));
                    //if no scriptmap present...
                    if (!datamap)
                    {
                        LOG_ERROR("maps.script", "{} unknown scriptmap ({}) specified, skipping.", step.script->GetDebugInfo(), step.script->CallScript.ScriptType);
                        break;
                    }

                    // Insert script into schedule but do not start it
                    ScriptsStart(*datamap, step.script->CallScript.ScriptID, cTarget, nullptr);
                    break;
                }

            case SCRIPT_COMMAND_KILL:
                // Source or target must be Creature.
                if (Creature* cSource = _GetScriptCreatureSourceOrTarget(source, target, step.script))
                {
                    if (cSource->isDead())
                        LOG_ERROR("maps.script", "{} creature is already dead ({})", step.script->GetDebugInfo(), cSource->GetGUID().ToString());
                    else
                    {
                        cSource->setDeathState(DeathState::JustDied);
                        if (step.script->Kill.RemoveCorpse == 1)
                            cSource->RemoveCorpse();
                    }
                }
                break;

            case SCRIPT_COMMAND_ORIENTATION:
                // Source must be Unit.
                if (Unit* sourceUnit = _GetScriptUnit(source, true, step.script))
                {
                    if (step.script->Orientation.Flags & SF_ORIENTATION_FACE_TARGET)
                    {
                        // Target must be Unit.
                        Unit* targetUnit = _GetScriptUnit(target, false, step.script);
                        if (!targetUnit)
                            break;

                        sourceUnit->SetFacingToObject(targetUnit);
                    }
                    else
                        sourceUnit->SetFacingTo(step.script->Orientation.Orientation);
                }
                break;

            case SCRIPT_COMMAND_EQUIP:
                // Source must be Creature.
                if (Creature* cSource = _GetScriptCreature(source, true, step.script))
                    cSource->LoadEquipment(step.script->Equip.EquipmentID);
                break;

            case SCRIPT_COMMAND_MODEL:
                // Source must be Creature.
                if (Creature* cSource = _GetScriptCreature(source, true, step.script))
                    cSource->SetDisplayId(step.script->Model.ModelID);
                break;

            case SCRIPT_COMMAND_CLOSE_GOSSIP:
                // Source must be Player.
                if (Player* player = _GetScriptPlayer(source, true, step.script))
                    player->PlayerTalkClass->SendCloseGossip();
                break;

            case SCRIPT_COMMAND_PLAYMOVIE:
                // Source must be Player.
                if (Player* player = _GetScriptPlayer(source, true, step.script))
                    player->SendMovieStart(step.script->PlayMovie.MovieID);
                break;

            case SCRIPT_COMMAND_MOVEMENT:
                // Source must be Creature.
                if (Creature* cSource = _GetScriptCreature(source, true, step.script))
                {
                    if (!cSource->IsAlive())
                        return;

                    cSource->GetMotionMaster()->MoveIdle();

                    switch (step.script->Movement.MovementType)
                    {
                        case RANDOM_MOTION_TYPE:
                            cSource->GetMotionMaster()->MoveRandom((float)step.script->Movement.MovementDistance);
                            break;
                        case WAYPOINT_MOTION_TYPE:
                            cSource->GetMotionMaster()->MoveWaypoint(step.script->Movement.Path, false);
                            break;
                    }
                }
                break;

            default:
                LOG_ERROR("maps.script", "Unknown script command {}.", step.script->GetDebugInfo());
                break;
        }

        m_scriptSchedule.erase(iter);
        iter = m_scriptSchedule.begin();
        sScriptMgr->DecreaseScheduledScriptCount();
    }
}
