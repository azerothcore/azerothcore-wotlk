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

#include "ConditionMgr.h"
#include "AchievementMgr.h"
#include "GameEventMgr.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"
#include "Pet.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "WorldState.h"

// Checks if object meets the condition
// Can have CONDITION_SOURCE_TYPE_NONE && !mReferenceId if called from a special event (ie: eventAI)
bool Condition::Meets(ConditionSourceInfo& sourceInfo)
{
    // ASSERT(ConditionTarget < MAX_CONDITION_TARGETS);
    if (ConditionTarget >= MAX_CONDITION_TARGETS)
    {
        LOG_ERROR("condition", "ConditionTarget {} for for condition (Entry: {} Type: {} Group: {}) is greater or equal than MAX_CONDITION_TARGETS", ConditionTarget, SourceEntry, SourceType, SourceGroup);
        return false;
    }

    WorldObject* object = sourceInfo.mConditionTargets[ConditionTarget];
    // object not present, return false
    if (!object)
    {
        LOG_DEBUG("condition", "Condition object not found for condition (Entry: {} Type: {} Group: {})", SourceEntry, SourceType, SourceGroup);
        return false;
    }
    bool condMeets = false;
    switch (ConditionType)
    {
    case CONDITION_NONE:
        condMeets = true; // empty condition, always met
        break;
    case CONDITION_AURA:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->HasAuraEffect(ConditionValue1, ConditionValue2);
        break;
    }
    case CONDITION_ITEM:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                // don't allow 0 items (it's checked during table load)
                ASSERT(ConditionValue2);
                bool checkBank = ConditionValue3;
                condMeets = player->HasItemCount(ConditionValue1, ConditionValue2, checkBank);
            }
        }
        break;
    }
    case CONDITION_ITEM_EQUIPPED:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->HasItemOrGemWithIdEquipped(ConditionValue1, 1);
            }
        }
        break;
    }
    case CONDITION_ZONEID:
        condMeets = object->GetZoneId() == ConditionValue1;
        break;
    case CONDITION_REPUTATION_RANK:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                if (FactionEntry const* faction = sFactionStore.LookupEntry(ConditionValue1))
                {
                    condMeets = (ConditionValue2 & (1 << player->GetReputationMgr().GetRank(faction)));
                }
            }
        }
        break;
    }
    case CONDITION_ACHIEVEMENT:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->HasAchieved(ConditionValue1);
            }
        }
        break;
    }
    case CONDITION_TEAM:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                // Xinef: DB Data compatibility...
                uint32 teamOld = player->GetTeamId() == TEAM_ALLIANCE ? ALLIANCE : HORDE;
                condMeets = teamOld == ConditionValue1;
            }
        }
        break;
    }
    case CONDITION_CLASS:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->getClassMask() & ConditionValue1;
        break;
    }
    case CONDITION_RACE:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->getRaceMask() & ConditionValue1;
        break;
    }
    case CONDITION_GENDER:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->getGender() == ConditionValue1;
            }
        }
        break;
    }
    case CONDITION_SKILL:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->HasSkill(ConditionValue1) && player->GetBaseSkillValue(ConditionValue1) >= ConditionValue2;
            }
        }
        break;
    }
    case CONDITION_QUESTREWARDED:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->GetQuestRewardStatus(ConditionValue1);
            }
        }
        break;
    }
    case CONDITION_QUESTTAKEN:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                QuestStatus status = player->GetQuestStatus(ConditionValue1);
                condMeets = (status == QUEST_STATUS_INCOMPLETE);
            }
        }
        break;
    }
    case CONDITION_QUEST_COMPLETE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                QuestStatus status = player->GetQuestStatus(ConditionValue1);
                condMeets = (status == QUEST_STATUS_COMPLETE && !player->GetQuestRewardStatus(ConditionValue1));
            }
        }
        break;
    }
    case CONDITION_QUEST_NONE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                QuestStatus status = player->GetQuestStatus(ConditionValue1);
                condMeets = (status == QUEST_STATUS_NONE);
            }
        }
        break;
    }
    case CONDITION_QUEST_SATISFY_EXCLUSIVE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                // Xinef: cannot be null, checked at loading
                const Quest* quest = sObjectMgr->GetQuestTemplate(ConditionValue1);
                condMeets = !player->IsQuestRewarded(ConditionValue1) && player->SatisfyQuestExclusiveGroup(quest, false);
            }
        }
        break;
    }
    case CONDITION_ACTIVE_EVENT:
        condMeets = sGameEventMgr->IsActiveEvent(ConditionValue1);
        break;
    case CONDITION_INSTANCE_INFO:
    {
        Map* map = object->GetMap();
        if (map->IsDungeon())
        {
            if (InstanceScript const* instance = map->ToInstanceMap()->GetInstanceScript())
            {
                switch (ConditionValue3)
                {
                    case INSTANCE_INFO_DATA:
                        condMeets = instance->GetData(ConditionValue1) == ConditionValue2;
                        break;
                    case INSTANCE_INFO_GUID_DATA:
                        condMeets = instance->GetGuidData(ConditionValue1) == ObjectGuid(uint64(ConditionValue2));
                        break;
                    case INSTANCE_INFO_BOSS_STATE:
                        condMeets = instance->GetBossState(ConditionValue1) == EncounterState(ConditionValue2);
                        break;
                    case INSTANCE_INFO_DATA64:
                        condMeets = instance->GetData64(ConditionValue1) == ConditionValue2;
                        break;
                }
            }
        }
        break;
    }
    case CONDITION_MAPID:
        condMeets = object->GetMapId() == ConditionValue1;
        break;
    case CONDITION_AREAID:
        condMeets = object->GetAreaId() == ConditionValue1;
        break;
    case CONDITION_SPELL:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->HasSpell(ConditionValue1);
            }
        }
        break;
    }
    case CONDITION_LEVEL:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = CompareValues(static_cast<ComparisionType>(ConditionValue2), static_cast<uint32>(unit->GetLevel()), ConditionValue1);
        break;
    }
    case CONDITION_DRUNKENSTATE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = (uint32)Player::GetDrunkenstateByValue(player->GetDrunkValue()) >= ConditionValue1;
            }
        }
        break;
    }
    case CONDITION_NEAR_CREATURE:
    {
        condMeets = static_cast<bool>(GetClosestCreatureWithEntry(object, ConditionValue1, static_cast<float>(ConditionValue2), !ConditionValue3));
        break;
    }
    case CONDITION_NEAR_GAMEOBJECT:
    {
        if (!ConditionValue3)
        {
            condMeets = static_cast<bool>(GetClosestGameObjectWithEntry(object, ConditionValue1, static_cast<float>(ConditionValue2)));
            break;
        }
        else
        {
            if (GameObject* go = GetClosestGameObjectWithEntry(object, ConditionValue1, static_cast<float>(ConditionValue2)))
            {
                if ((go->GetGoState() == GO_STATE_READY && ConditionValue3 == 1) || (go->GetGoState() != GO_STATE_READY && ConditionValue3 == 2))
                    condMeets = true;
                else
                    condMeets = false;
            }
            break;
        }
    }
    case CONDITION_OBJECT_ENTRY_GUID:
    {
        if (ConditionValue3 == 1 && object->ToUnit()) // pussywizard: if == 1, ignore not attackable/selectable targets
            if (object->ToUnit()->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE))
                break;

        if (uint32(object->GetTypeId()) == ConditionValue1)
        {
            condMeets = !ConditionValue2 || (object->GetEntry() == ConditionValue2);

            if (ConditionValue3 > 1)
            {
                switch (object->GetTypeId())
                {
                    case TYPEID_UNIT:
                        condMeets &= object->ToCreature()->GetSpawnId() == ConditionValue3;
                        break;
                    case TYPEID_GAMEOBJECT:
                        condMeets &= object->ToGameObject()->GetSpawnId() == ConditionValue3;
                        break;
                    default:
                        break;
                }
            }
        }
        break;
    }
    case CONDITION_TYPE_MASK:
    {
        condMeets = object->isType(ConditionValue1);
        break;
    }
    case CONDITION_RELATION_TO:
    {
        if (WorldObject* toObject = sourceInfo.mConditionTargets[ConditionValue1])
        {
            Unit* toUnit = toObject->ToUnit();
            Unit* unit   = object->ToUnit();
            if (toUnit && unit)
            {
                switch (ConditionValue2)
                {
                    case RELATION_SELF:
                        condMeets = unit == toUnit;
                        break;
                    case RELATION_IN_PARTY:
                        condMeets = unit->IsInPartyWith(toUnit);
                        break;
                    case RELATION_IN_RAID_OR_PARTY:
                        condMeets = unit->IsInRaidWith(toUnit);
                        break;
                    case RELATION_OWNED_BY:
                        condMeets = unit->GetOwnerGUID() == toUnit->GetGUID();
                        break;
                    case RELATION_PASSENGER_OF:
                        condMeets = unit->IsOnVehicle(toUnit);
                        break;
                    case RELATION_CREATED_BY:
                        condMeets = unit->GetCreatorGUID() == toUnit->GetGUID();
                        break;
                }
            }
        }
        break;
    }
    case CONDITION_REACTION_TO:
    {
        if (WorldObject* toObject = sourceInfo.mConditionTargets[ConditionValue1])
        {
            Unit* toUnit = toObject->ToUnit();
            Unit* unit   = object->ToUnit();
            if (toUnit && unit)
                condMeets = (1 << unit->GetReactionTo(toUnit)) & ConditionValue2;
        }
        break;
    }
    case CONDITION_DISTANCE_TO:
    {
        if (WorldObject* toObject = sourceInfo.mConditionTargets[ConditionValue1])
            condMeets = CompareValues(static_cast<ComparisionType>(ConditionValue3), object->GetDistance(toObject), static_cast<float>(ConditionValue2));
        break;
    }
    case CONDITION_ALIVE:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->IsAlive();
        break;
    }
    case CONDITION_HP_VAL:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = CompareValues(static_cast<ComparisionType>(ConditionValue2), unit->GetHealth(), static_cast<uint32>(ConditionValue1));
        break;
    }
    case CONDITION_HP_PCT:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = CompareValues(static_cast<ComparisionType>(ConditionValue2), unit->GetHealthPct(), static_cast<float>(ConditionValue1));
        break;
    }
    case CONDITION_WORLD_STATE:
    {
        condMeets = ConditionValue2 == sWorldState->getWorldState(ConditionValue1);
        break;
    }
    case CONDITION_PHASEMASK:
    {
        condMeets = object->GetPhaseMask() & ConditionValue1;
        break;
    }
    case CONDITION_TITLE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->HasTitle(ConditionValue1);
            }
        }
        break;
    }
    case CONDITION_SPAWNMASK:
    {
        condMeets = ((1 << object->GetMap()->GetSpawnMode()) & ConditionValue1);
        break;
    }
    case CONDITION_UNIT_STATE:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->HasUnitState(ConditionValue1);
        break;
    }
    case CONDITION_CREATURE_TYPE:
    {
        if (Creature* creature = object->ToCreature())
            condMeets = creature->GetCreatureTemplate()->type == ConditionValue1;
        break;
    }
    case CONDITION_REALM_ACHIEVEMENT:
    {
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(ConditionValue1);
        if (achievement && sAchievementMgr->IsRealmCompleted(achievement))
            condMeets = true;
        break;
    }
    case CONDITION_IN_WATER:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->IsInWater();
        break;
    }
    case CONDITION_QUESTSTATE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                uint32 queststateConditionValue1 = player->GetQuestStatus(ConditionValue1);
                if (((ConditionValue2 & (1 << QUEST_STATUS_NONE)) && (queststateConditionValue1 == QUEST_STATUS_NONE)) ||
                    ((ConditionValue2 & (1 << QUEST_STATUS_COMPLETE)) && (queststateConditionValue1 == QUEST_STATUS_COMPLETE)) ||
                    ((ConditionValue2 & (1 << QUEST_STATUS_INCOMPLETE)) && (queststateConditionValue1 == QUEST_STATUS_INCOMPLETE)) ||
                    ((ConditionValue2 & (1 << QUEST_STATUS_FAILED)) && (queststateConditionValue1 == QUEST_STATUS_FAILED)) ||
                    ((ConditionValue2 & (1 << QUEST_STATUS_REWARDED)) && player->GetQuestRewardStatus(ConditionValue1)))
                {
                    condMeets = true;
                }
            }
        }
        break;
    }
    case CONDITION_DAILY_QUEST_DONE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->IsDailyQuestDone(ConditionValue1);
            }
        }
        break;
    }
    case CONDITION_QUEST_OBJECTIVE_PROGRESS:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                Quest const* quest = ASSERT_NOTNULL(sObjectMgr->GetQuestTemplate(ConditionValue1));
                uint16 log_slot = player->FindQuestSlot(quest->GetQuestId());
                if (log_slot >= MAX_QUEST_LOG_SIZE)
                {
                    break;
                }

                if (player->GetQuestSlotCounter(log_slot, ConditionValue2) == ConditionValue3)
                {
                    condMeets = true;
                }
            }
        }
        break;
    }
    case CONDITION_HAS_AURA_TYPE:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->HasAuraType(AuraType(ConditionValue1));
        break;
    }
    case CONDITION_STAND_STATE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (ConditionValue1 == 0)
            {
                condMeets = (unit->getStandState() == ConditionValue2);
            }
            else if (ConditionValue2 == 0)
            {
                condMeets = unit->IsStandState();
            }
            else if (ConditionValue2 == 1)
            {
                condMeets = unit->IsSitState();
            }
        }

        break;
    }
    case CONDITION_DIFFICULTY_ID:
    {
        condMeets = object->GetMap()->GetDifficulty() == ConditionValue1;
        break;
    }
    case CONDITION_PLAYER_QUEUED_RANDOM_DUNGEON:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->ToPlayer())
            {
                if (sLFGMgr->IsPlayerQueuedForRandomDungeon(player->GetGUID()))
                {
                    if (!ConditionValue1)
                        condMeets = true;
                    else if (Map* map = player->GetMap())
                        condMeets = map->GetDifficulty() == Difficulty(ConditionValue2);
                }
            }
        }
        break;
    }
    case CONDITION_PET_TYPE:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                if (Pet* pet = player->GetPet())
                {
                    condMeets = (((1 << pet->getPetType()) & ConditionValue1) != 0);
                }
            }
        }
        break;
    }
    case CONDITION_TAXI:
    {
        if (Unit* unit = object->ToUnit())
        {
            if (Player* player = unit->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                condMeets = player->IsInFlight();
            }
        }
        break;
    }
    case CONDITION_CHARMED:
    {
        if (Unit* unit = object->ToUnit())
            condMeets = unit->IsCharmed();
        break;
    }
    case CONDITION_WORLD_SCRIPT:
    {
        condMeets = sWorldState->IsConditionFulfilled(ConditionValue1, ConditionValue2);
        break;
    }
    case CONDITION_AI_DATA:
    {
        if (Creature* creature = object->ToCreature())
            condMeets = creature->AI() && creature->AI()->GetData(ConditionValue1) == ConditionValue2;
        else if (GameObject* go = object->ToGameObject())
            condMeets = go->AI() && go->AI()->GetData(ConditionValue1) == ConditionValue2;
        break;
    }
    default:
        condMeets = false;
        break;
    }

    if (NegativeCondition)
        condMeets = !condMeets;

    if (!condMeets)
        sourceInfo.mLastFailedCondition = this;

    // bool script = sScriptMgr->OnConditionCheck(this, sourceInfo); // Returns true by default. // pussywizard: optimization
    return condMeets; // && script;
}

uint32 Condition::GetSearcherTypeMaskForCondition()
{
    // build mask of types for which condition can return true
    // this is used for speeding up gridsearches
    if (NegativeCondition)
        return (GRID_MAP_TYPE_MASK_ALL);
    uint32 mask = 0;
    switch (ConditionType)
    {
    case CONDITION_NONE:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_AURA:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_ITEM:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_ITEM_EQUIPPED:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_ZONEID:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_REPUTATION_RANK:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_ACHIEVEMENT:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_TEAM:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_CLASS:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_RACE:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_SKILL:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_QUESTREWARDED:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_QUESTTAKEN:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_QUEST_COMPLETE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_QUEST_NONE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_QUEST_SATISFY_EXCLUSIVE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_ACTIVE_EVENT:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_INSTANCE_INFO:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_MAPID:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_AREAID:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_SPELL:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_LEVEL:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_DRUNKENSTATE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_NEAR_CREATURE:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_NEAR_GAMEOBJECT:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_OBJECT_ENTRY_GUID:
        switch (ConditionValue1)
        {
        case TYPEID_UNIT:
            mask |= GRID_MAP_TYPE_MASK_CREATURE;
            break;
        case TYPEID_PLAYER:
            mask |= GRID_MAP_TYPE_MASK_PLAYER;
            break;
        case TYPEID_GAMEOBJECT:
            mask |= GRID_MAP_TYPE_MASK_GAMEOBJECT;
            break;
        case TYPEID_CORPSE:
            mask |= GRID_MAP_TYPE_MASK_CORPSE;
            break;
        default:
            break;
        }
        break;
    case CONDITION_TYPE_MASK:
        if (ConditionValue1 & TYPEMASK_UNIT)
            mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        if (ConditionValue1 & TYPEMASK_PLAYER)
            mask |= GRID_MAP_TYPE_MASK_PLAYER;
        if (ConditionValue1 & TYPEMASK_GAMEOBJECT)
            mask |= GRID_MAP_TYPE_MASK_GAMEOBJECT;
        if (ConditionValue1 & TYPEMASK_CORPSE)
            mask |= GRID_MAP_TYPE_MASK_CORPSE;
        break;
    case CONDITION_RELATION_TO:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_REACTION_TO:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_DISTANCE_TO:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_ALIVE:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_HP_VAL:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_HP_PCT:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_WORLD_STATE:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_PHASEMASK:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_TITLE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_SPAWNMASK:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_GENDER:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_UNIT_STATE:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_CREATURE_TYPE:
        mask |= GRID_MAP_TYPE_MASK_CREATURE;
        break;
    case CONDITION_REALM_ACHIEVEMENT:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_IN_WATER:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_QUESTSTATE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_DAILY_QUEST_DONE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_QUEST_OBJECTIVE_PROGRESS:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_HAS_AURA_TYPE:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_STAND_STATE:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_DIFFICULTY_ID:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_PET_TYPE:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_TAXI:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_CHARMED:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_PLAYER_QUEUED_RANDOM_DUNGEON:
        mask |= GRID_MAP_TYPE_MASK_PLAYER;
        break;
    case CONDITION_WORLD_SCRIPT:
        mask |= GRID_MAP_TYPE_MASK_ALL;
        break;
    case CONDITION_AI_DATA:
        mask |= GRID_MAP_TYPE_MASK_CREATURE | GRID_MAP_TYPE_MASK_GAMEOBJECT;
        break;
    default:
        ASSERT(false && "Condition::GetSearcherTypeMaskForCondition - missing condition handling!");
        break;
    }
    return mask;
}

uint32 Condition::GetMaxAvailableConditionTargets()
{
    // returns number of targets which are available for given source type
    switch (SourceType)
    {
        case CONDITION_SOURCE_TYPE_SMART_EVENT:
            return 3;
        case CONDITION_SOURCE_TYPE_SPELL:
        case CONDITION_SOURCE_TYPE_SPELL_IMPLICIT_TARGET:
        case CONDITION_SOURCE_TYPE_CREATURE_TEMPLATE_VEHICLE:
        case CONDITION_SOURCE_TYPE_VEHICLE_SPELL:
        case CONDITION_SOURCE_TYPE_SPELL_CLICK_EVENT:
        case CONDITION_SOURCE_TYPE_GOSSIP_MENU:
        case CONDITION_SOURCE_TYPE_GOSSIP_MENU_OPTION:
        case CONDITION_SOURCE_TYPE_NPC_VENDOR:
        case CONDITION_SOURCE_TYPE_SPELL_PROC:
        case CONDITION_SOURCE_TYPE_CREATURE_VISIBILITY:
            return 2;
        default:
            break;
    }

    return 1;
}

ConditionMgr::ConditionMgr() {}

ConditionMgr::~ConditionMgr()
{
    Clean();
}

ConditionMgr* ConditionMgr::instance()
{
    static ConditionMgr instance;
    return &instance;
}

ConditionList ConditionMgr::GetConditionReferences(uint32 refId)
{
    ConditionList                               conditions;
    ConditionReferenceContainer::const_iterator ref = ConditionReferenceStore.find(refId);
    if (ref != ConditionReferenceStore.end())
        conditions = (*ref).second;
    return conditions;
}

uint32 ConditionMgr::GetSearcherTypeMaskForConditionList(ConditionList const& conditions)
{
    if (conditions.empty())
        return GRID_MAP_TYPE_MASK_ALL;
    //     groupId, typeMask
    std::map<uint32, uint32> ElseGroupStore;
    for (ConditionList::const_iterator i = conditions.begin(); i != conditions.end(); ++i)
    {
        // no point of having not loaded conditions in list
        ASSERT((*i)->isLoaded() && "ConditionMgr::GetSearcherTypeMaskForConditionList - not yet loaded condition found in list");
        std::map<uint32, uint32>::const_iterator itr = ElseGroupStore.find((*i)->ElseGroup);
        // group not filled yet, fill with widest mask possible
        if (itr == ElseGroupStore.end())
            ElseGroupStore[(*i)->ElseGroup] = GRID_MAP_TYPE_MASK_ALL;
        // no point of checking anymore, empty mask
        else if (!(*itr).second)
            continue;

        if ((*i)->ReferenceId) // handle reference
        {
            ConditionReferenceContainer::const_iterator ref = ConditionReferenceStore.find((*i)->ReferenceId);
            ASSERT(ref != ConditionReferenceStore.end() && "ConditionMgr::GetSearcherTypeMaskForConditionList - incorrect reference");
            ElseGroupStore[(*i)->ElseGroup] &= GetSearcherTypeMaskForConditionList((*ref).second);
        }
        else // handle normal condition
        {
            // object will match conditions in one ElseGroupStore only when it matches all of them
            // so, let's find a smallest possible mask which satisfies all conditions
            ElseGroupStore[(*i)->ElseGroup] &= (*i)->GetSearcherTypeMaskForCondition();
        }
    }
    // object will match condition when one of the checks in ElseGroupStore is matching
    // so, let's include all possible masks
    uint32 mask = 0;
    for (std::map<uint32, uint32>::const_iterator i = ElseGroupStore.begin(); i != ElseGroupStore.end(); ++i) mask |= i->second;

    return mask;
}

bool ConditionMgr::IsObjectMeetToConditionList(ConditionSourceInfo& sourceInfo, ConditionList const& conditions)
{
    //     groupId, groupCheckPassed
    std::map<uint32, bool> ElseGroupStore;
    for (ConditionList::const_iterator i = conditions.begin(); i != conditions.end(); ++i)
    {
        LOG_DEBUG("condition", "ConditionMgr::IsPlayerMeetToConditionList condType: {} val1: {}", (*i)->ConditionType, (*i)->ConditionValue1);
        if ((*i)->isLoaded())
        {
            //! Find ElseGroup in ElseGroupStore
            std::map<uint32, bool>::const_iterator itr = ElseGroupStore.find((*i)->ElseGroup);
            //! If not found, add an entry in the store and set to true (placeholder)
            if (itr == ElseGroupStore.end())
                ElseGroupStore[(*i)->ElseGroup] = true;
            else if (!(*itr).second)
                continue;

            if ((*i)->ReferenceId) // handle reference
            {
                ConditionReferenceContainer::const_iterator ref = ConditionReferenceStore.find((*i)->ReferenceId);
                if (ref != ConditionReferenceStore.end())
                {
                    if (!IsObjectMeetToConditionList(sourceInfo, (*ref).second))
                        ElseGroupStore[(*i)->ElseGroup] = false;
                }
                else
                {
                    LOG_DEBUG("condition", "IsPlayerMeetToConditionList: Reference template -{} not found", (*i)->ReferenceId);
                }
            }
            else // handle normal condition
            {
                if (!(*i)->Meets(sourceInfo))
                    ElseGroupStore[(*i)->ElseGroup] = false;
            }
        }
    }
    for (std::map<uint32, bool>::const_iterator i = ElseGroupStore.begin(); i != ElseGroupStore.end(); ++i)
        if (i->second)
            return true;

    return false;
}

bool ConditionMgr::IsObjectMeetToConditions(WorldObject* object, ConditionList const& conditions)
{
    ConditionSourceInfo srcInfo = ConditionSourceInfo(object);
    return IsObjectMeetToConditions(srcInfo, conditions);
}

bool ConditionMgr::IsObjectMeetToConditions(WorldObject* object1, WorldObject* object2, ConditionList const& conditions)
{
    ConditionSourceInfo srcInfo = ConditionSourceInfo(object1, object2);
    return IsObjectMeetToConditions(srcInfo, conditions);
}

bool ConditionMgr::IsObjectMeetToConditions(ConditionSourceInfo& sourceInfo, ConditionList const& conditions)
{
    if (conditions.empty())
        return true;

    LOG_DEBUG("condition", "ConditionMgr::IsObjectMeetToConditions");
    return IsObjectMeetToConditionList(sourceInfo, conditions);
}

bool ConditionMgr::CanHaveSourceGroupSet(ConditionSourceType sourceType) const
{
    return (sourceType == CONDITION_SOURCE_TYPE_CREATURE_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_DISENCHANT_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_FISHING_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_GAMEOBJECT_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_ITEM_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_MAIL_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_MILLING_LOOT_TEMPLATE ||
            sourceType == CONDITION_SOURCE_TYPE_PICKPOCKETING_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_PROSPECTING_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_REFERENCE_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_SKINNING_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_SPELL_LOOT_TEMPLATE || sourceType == CONDITION_SOURCE_TYPE_GOSSIP_MENU || sourceType == CONDITION_SOURCE_TYPE_GOSSIP_MENU_OPTION || sourceType == CONDITION_SOURCE_TYPE_VEHICLE_SPELL ||
            sourceType == CONDITION_SOURCE_TYPE_SPELL_IMPLICIT_TARGET || sourceType == CONDITION_SOURCE_TYPE_SPELL_CLICK_EVENT || sourceType == CONDITION_SOURCE_TYPE_SMART_EVENT || sourceType == CONDITION_SOURCE_TYPE_NPC_VENDOR || sourceType == CONDITION_SOURCE_TYPE_PLAYER_LOOT_TEMPLATE);
}

bool ConditionMgr::CanHaveSourceIdSet(ConditionSourceType sourceType) const
{
    return (sourceType == CONDITION_SOURCE_TYPE_SMART_EVENT);
}

ConditionList ConditionMgr::GetConditionsForNotGroupedEntry(ConditionSourceType sourceType, uint32 entry)
{
    ConditionList spellCond;
    if (sourceType > CONDITION_SOURCE_TYPE_NONE && sourceType < CONDITION_SOURCE_TYPE_MAX)
    {
        ConditionContainer::const_iterator itr = ConditionStore.find(sourceType);
        if (itr != ConditionStore.end())
        {
            ConditionTypeContainer::const_iterator i = (*itr).second.find(entry);
            if (i != (*itr).second.end())
            {
                spellCond = (*i).second;
                LOG_DEBUG("condition", "GetConditionsForNotGroupedEntry: found conditions for type {} and entry {}", uint32(sourceType), entry);
            }
        }
    }
    return spellCond;
}

ConditionList ConditionMgr::GetConditionsForSpellClickEvent(uint32 creatureId, uint32 spellId)
{
    ConditionList                                   cond;
    CreatureSpellConditionContainer::const_iterator itr = SpellClickEventConditionStore.find(creatureId);
    if (itr != SpellClickEventConditionStore.end())
    {
        ConditionTypeContainer::const_iterator i = (*itr).second.find(spellId);
        if (i != (*itr).second.end())
        {
            cond = (*i).second;
            LOG_DEBUG("condition", "GetConditionsForSpellClickEvent: found conditions for Vehicle entry {} spell {}", creatureId, spellId);
        }
    }
    return cond;
}

ConditionList ConditionMgr::GetConditionsForVehicleSpell(uint32 creatureId, uint32 spellId)
{
    ConditionList                                   cond;
    CreatureSpellConditionContainer::const_iterator itr = VehicleSpellConditionStore.find(creatureId);
    if (itr != VehicleSpellConditionStore.end())
    {
        ConditionTypeContainer::const_iterator i = (*itr).second.find(spellId);
        if (i != (*itr).second.end())
        {
            cond = (*i).second;
            LOG_DEBUG("condition", "GetConditionsForVehicleSpell: found conditions for Vehicle entry {} spell {}", creatureId, spellId);
        }
    }
    return cond;
}

ConditionList ConditionMgr::GetConditionsForSmartEvent(int32 entryOrGuid, uint32 eventId, uint32 sourceType)
{
    ConditionList                                cond;
    SmartEventConditionContainer::const_iterator itr = SmartEventConditionStore.find(std::make_pair(entryOrGuid, sourceType));
    if (itr != SmartEventConditionStore.end())
    {
        ConditionTypeContainer::const_iterator i = (*itr).second.find(eventId + 1);
        if (i != (*itr).second.end())
        {
            cond = (*i).second;
            LOG_DEBUG("condition", "GetConditionsForSmartEvent: found conditions for Smart Event entry or guid {} event_id {}", entryOrGuid, eventId);
        }
    }
    return cond;
}

ConditionList ConditionMgr::GetConditionsForNpcVendorEvent(uint32 creatureId, uint32 itemId)
{
    ConditionList                               cond;
    NpcVendorConditionContainer::const_iterator itr = NpcVendorConditionContainerStore.find(creatureId);
    if (itr != NpcVendorConditionContainerStore.end())
    {
        ConditionTypeContainer::const_iterator i = (*itr).second.find(itemId);
        if (i != (*itr).second.end())
        {
            cond = (*i).second;
            if (itemId)
            {
                LOG_DEBUG("condition", "GetConditionsForNpcVendorEvent: found conditions for creature entry {} item {}", creatureId, itemId);
            }
            else
            {
                LOG_DEBUG("condition", "GetConditionsForNpcVendorEvent: found conditions for creature entry {}", creatureId);
            }
        }
    }
    return cond;
}

void ConditionMgr::LoadConditions(bool isReload)
{
    uint32 oldMSTime = getMSTime();

    Clean();

    // must clear all custom handled cases (groupped types) before reload
    if (isReload)
    {
        LOG_INFO("server.loading", "Reseting Loot Conditions...");
        LootTemplates_Creature.ResetConditions();
        LootTemplates_Fishing.ResetConditions();
        LootTemplates_Gameobject.ResetConditions();
        LootTemplates_Item.ResetConditions();
        LootTemplates_Mail.ResetConditions();
        LootTemplates_Milling.ResetConditions();
        LootTemplates_Pickpocketing.ResetConditions();
        LootTemplates_Reference.ResetConditions();
        LootTemplates_Skinning.ResetConditions();
        LootTemplates_Disenchant.ResetConditions();
        LootTemplates_Prospecting.ResetConditions();
        LootTemplates_Spell.ResetConditions();
        LootTemplates_Player.ResetConditions();

        LOG_INFO("server.loading", "Reloading `gossip_menu` Table for Conditions!");
        sObjectMgr->LoadGossipMenu();

        LOG_INFO("server.loading", "Reloading `gossip_menu_option` Table for Conditions!");
        sObjectMgr->LoadGossipMenuItems();
        sSpellMgr->UnloadSpellInfoImplicitTargetConditionLists();
    }

    QueryResult result = WorldDatabase.Query("SELECT SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, "
                                             " ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName FROM conditions");

    if (!result)
    {
        LOG_WARN("server.loading", ">> Loaded 0 conditions. DB table `conditions` is empty!");
        return;
    }

    uint32 count = 0;

    do
    {
        Field* fields = result->Fetch();

        Condition* cond                     = new Condition();
        int32      iSourceTypeOrReferenceId = fields[0].Get<int32>();
        cond->SourceGroup                   = fields[1].Get<uint32>();
        cond->SourceEntry                   = fields[2].Get<int32>();
        cond->SourceId                      = fields[3].Get<int32>();
        cond->ElseGroup                     = fields[4].Get<uint32>();
        int32 iConditionTypeOrReference     = fields[5].Get<int32>();
        cond->ConditionTarget               = fields[6].Get<uint8>();
        cond->ConditionValue1               = fields[7].Get<uint32>();
        cond->ConditionValue2               = fields[8].Get<uint32>();
        cond->ConditionValue3               = fields[9].Get<uint32>();
        cond->NegativeCondition             = fields[10].Get<uint8>();
        cond->ErrorType                     = fields[11].Get<uint32>();
        cond->ErrorTextId                   = fields[12].Get<uint32>();
        cond->ScriptId                      = sObjectMgr->GetScriptId(fields[13].Get<std::string>());

        if (iConditionTypeOrReference >= 0)
            cond->ConditionType = ConditionTypes(iConditionTypeOrReference);

        if (iSourceTypeOrReferenceId >= 0)
            cond->SourceType = ConditionSourceType(iSourceTypeOrReferenceId);

        if (iConditionTypeOrReference < 0) // it has a reference
        {
            if (iConditionTypeOrReference == iSourceTypeOrReferenceId) // self referencing, skip
            {
                LOG_ERROR("sql.sql", "Condition reference {} is referencing self, skipped", iSourceTypeOrReferenceId);
                delete cond;
                continue;
            }
            cond->ReferenceId = uint32(std::abs(iConditionTypeOrReference));

            const char* rowType = "reference template";
            if (iSourceTypeOrReferenceId >= 0)
                rowType = "reference";
            // check for useless data
            if (cond->ConditionTarget)
                LOG_ERROR("sql.sql", "Condition {} {} has useless data in ConditionTarget ({})!", rowType, iSourceTypeOrReferenceId, cond->ConditionTarget);
            if (cond->ConditionValue1)
                LOG_ERROR("sql.sql", "Condition {} {} has useless data in value1 ({})!", rowType, iSourceTypeOrReferenceId, cond->ConditionValue1);
            if (cond->ConditionValue2)
                LOG_ERROR("sql.sql", "Condition {} {} has useless data in value2 ({})!", rowType, iSourceTypeOrReferenceId, cond->ConditionValue2);
            if (cond->ConditionValue3)
                LOG_ERROR("sql.sql", "Condition {} {} has useless data in value3 ({})!", rowType, iSourceTypeOrReferenceId, cond->ConditionValue3);
            if (cond->NegativeCondition)
                LOG_ERROR("sql.sql", "Condition {} {} has useless data in NegativeCondition ({})!", rowType, iSourceTypeOrReferenceId, cond->NegativeCondition);
            if (cond->SourceGroup && iSourceTypeOrReferenceId < 0)
                LOG_ERROR("sql.sql", "Condition {} {} has useless data in SourceGroup ({})!", rowType, iSourceTypeOrReferenceId, cond->SourceGroup);
            if (cond->SourceEntry && iSourceTypeOrReferenceId < 0)
                LOG_ERROR("sql.sql", "Condition {} {} has useless data in SourceEntry ({})!", rowType, iSourceTypeOrReferenceId, cond->SourceEntry);
        }
        else if (!isConditionTypeValid(cond)) // doesn't have reference, validate ConditionType
        {
            delete cond;
            continue;
        }

        if (iSourceTypeOrReferenceId < 0) // it is a reference template
        {
            uint32 uRefId = std::abs(iSourceTypeOrReferenceId);
            if (ConditionReferenceStore.find(uRefId) == ConditionReferenceStore.end()) // make sure we have a list for our conditions, based on reference id
            {
                ConditionList mCondList;
                ConditionReferenceStore[uRefId] = mCondList;
            }
            ConditionReferenceStore[uRefId].push_back(cond); // add to reference storage
            count++;
            continue;
        } // end of reference templates

        // if not a reference and SourceType is invalid, skip
        if (iConditionTypeOrReference >= 0 && !isSourceTypeValid(cond))
        {
            delete cond;
            continue;
        }

        // Grouping is only allowed for some types (loot templates, gossip menus, gossip items)
        if (cond->SourceGroup && !CanHaveSourceGroupSet(cond->SourceType))
        {
            LOG_ERROR("sql.sql", "Condition type {} has not allowed value of SourceGroup = {}!", uint32(cond->SourceType), cond->SourceGroup);
            delete cond;
            continue;
        }
        if (cond->SourceId && !CanHaveSourceIdSet(cond->SourceType))
        {
            LOG_ERROR("sql.sql", "Condition type {} has not allowed value of SourceId = {}!", uint32(cond->SourceType), cond->SourceId);
            delete cond;
            continue;
        }

        if (cond->ErrorType && cond->SourceType != CONDITION_SOURCE_TYPE_SPELL)
        {
            LOG_ERROR("condition", "Condition type {} entry {} can't have ErrorType ({}), set to 0!", uint32(cond->SourceType), cond->SourceEntry, cond->ErrorType);
            cond->ErrorType = 0;
        }

        if (cond->ErrorTextId && !cond->ErrorType)
        {
            LOG_ERROR("condition", "Condition type {} entry {} has any ErrorType, ErrorTextId ({}) is set, set to 0!", uint32(cond->SourceType), cond->SourceEntry, cond->ErrorTextId);
            cond->ErrorTextId = 0;
        }

        if (cond->SourceGroup || cond->SourceType == CONDITION_SOURCE_TYPE_PLAYER_LOOT_TEMPLATE)
        {
            bool valid = false;
            // handle grouped conditions
            switch (cond->SourceType)
            {
            case CONDITION_SOURCE_TYPE_CREATURE_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Creature.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_DISENCHANT_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Disenchant.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_FISHING_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Fishing.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_GAMEOBJECT_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Gameobject.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_ITEM_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Item.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_MAIL_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Mail.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_MILLING_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Milling.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_PICKPOCKETING_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Pickpocketing.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_PROSPECTING_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Prospecting.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_REFERENCE_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Reference.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_SKINNING_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Skinning.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_SPELL_LOOT_TEMPLATE:
                valid = addToLootTemplate(cond, LootTemplates_Spell.GetLootForConditionFill(cond->SourceGroup));
                break;
            case CONDITION_SOURCE_TYPE_GOSSIP_MENU:
                valid = addToGossipMenus(cond);
                break;
            case CONDITION_SOURCE_TYPE_GOSSIP_MENU_OPTION:
                valid = addToGossipMenuItems(cond);
                break;
            case CONDITION_SOURCE_TYPE_SPELL_CLICK_EVENT:
            {
                SpellClickEventConditionStore[cond->SourceGroup][cond->SourceEntry].push_back(cond);
                valid = true;
                ++count;
                continue; // do not add to m_AllocatedMemory to avoid double deleting
            }
            case CONDITION_SOURCE_TYPE_SPELL_IMPLICIT_TARGET:
                valid = addToSpellImplicitTargetConditions(cond);
                break;
            case CONDITION_SOURCE_TYPE_VEHICLE_SPELL:
            {
                VehicleSpellConditionStore[cond->SourceGroup][cond->SourceEntry].push_back(cond);
                valid = true;
                ++count;
                continue; // do not add to m_AllocatedMemory to avoid double deleting
            }
            case CONDITION_SOURCE_TYPE_SMART_EVENT:
            {
                //! TODO: PAIR_32 ?
                std::pair<int32, uint32> key = std::make_pair(cond->SourceEntry, cond->SourceId);
                SmartEventConditionStore[key][cond->SourceGroup].push_back(cond);
                valid = true;
                ++count;
                continue;
            }
            case CONDITION_SOURCE_TYPE_NPC_VENDOR:
            {
                NpcVendorConditionContainerStore[cond->SourceGroup][cond->SourceEntry].push_back(cond);
                valid = true;
                ++count;
                continue;
            }
            case CONDITION_SOURCE_TYPE_PLAYER_LOOT_TEMPLATE:
            {
                valid = addToLootTemplate(cond, LootTemplates_Player.GetLootForConditionFill(cond->SourceGroup));
                break;
            }
            default:
                break;
            }

            if (!valid)
            {
                LOG_ERROR("sql.sql", "Not handled grouped condition, SourceGroup {}", cond->SourceGroup);
                delete cond;
            }
            else
            {
                AllocatedMemoryStore.push_back(cond);
                ++count;
            }
            continue;
        }

        // handle not grouped conditions
        // make sure we have a storage list for our SourceType
        if (ConditionStore.find(cond->SourceType) == ConditionStore.end())
        {
            ConditionTypeContainer mTypeMap;
            ConditionStore[cond->SourceType] = mTypeMap; // add new empty list for SourceType
        }

        // make sure we have a condition list for our SourceType's entry
        if (ConditionStore[cond->SourceType].find(cond->SourceEntry) == ConditionStore[cond->SourceType].end())
        {
            ConditionList mCondList;
            ConditionStore[cond->SourceType][cond->SourceEntry] = mCondList;
        }

        // add new Condition to storage based on Type/Entry
        ConditionStore[cond->SourceType][cond->SourceEntry].push_back(cond);
        ++count;
    } while (result->NextRow());

    LOG_INFO("server.loading", ">> Loaded {} conditions in {} ms", count, GetMSTimeDiffToNow(oldMSTime));
    LOG_INFO("server.loading", " ");
}

bool ConditionMgr::addToLootTemplate(Condition* cond, LootTemplate* loot)
{
    if (!loot)
    {
        LOG_ERROR("sql.sql", "ConditionMgr: LootTemplate {} not found", cond->SourceGroup);
        return false;
    }

    if (loot->addConditionItem(cond))
        return true;

    LOG_ERROR("sql.sql", "ConditionMgr: Item {} not found in LootTemplate {}", cond->SourceEntry, cond->SourceGroup);
    return false;
}

bool ConditionMgr::addToGossipMenus(Condition* cond)
{
    GossipMenusMapBoundsNonConst pMenuBounds = sObjectMgr->GetGossipMenusMapBoundsNonConst(cond->SourceGroup);

    if (pMenuBounds.first != pMenuBounds.second)
    {
        for (GossipMenusContainer::iterator itr = pMenuBounds.first; itr != pMenuBounds.second; ++itr)
        {
            if ((*itr).second.MenuID == cond->SourceGroup && (*itr).second.TextID == uint32(cond->SourceEntry))
            {
                (*itr).second.Conditions.push_back(cond);
                return true;
            }
        }
    }

    LOG_ERROR("sql.sql", "addToGossipMenus: GossipMenu {} not found", cond->SourceGroup);
    return false;
}

bool ConditionMgr::addToGossipMenuItems(Condition* cond)
{
    GossipMenuItemsMapBoundsNonConst pMenuItemBounds = sObjectMgr->GetGossipMenuItemsMapBoundsNonConst(cond->SourceGroup);
    if (pMenuItemBounds.first != pMenuItemBounds.second)
    {
        for (GossipMenuItemsContainer::iterator itr = pMenuItemBounds.first; itr != pMenuItemBounds.second; ++itr)
        {
            if ((*itr).second.MenuID == cond->SourceGroup && (*itr).second.OptionID == uint32(cond->SourceEntry))
            {
                (*itr).second.Conditions.push_back(cond);
                return true;
            }
        }
    }

    LOG_ERROR("sql.sql", "addToGossipMenuItems: GossipMenuId {} Item {} not found", cond->SourceGroup, cond->SourceEntry);
    return false;
}

bool ConditionMgr::addToSpellImplicitTargetConditions(Condition* cond)
{
    uint32            conditionEffMask = cond->SourceGroup;
    SpellInfo*        spellInfo        = const_cast<SpellInfo*>(sSpellMgr->AssertSpellInfo(cond->SourceEntry));
    std::list<uint32> sharedMasks;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // check if effect is already a part of some shared mask
        bool found = false;
        for (std::list<uint32>::iterator itr = sharedMasks.begin(); itr != sharedMasks.end(); ++itr)
        {
            if ((1 << i) & *itr)
            {
                found = true;
                break;
            }
        }
        if (found)
            continue;

        // build new shared mask with found effect
        uint32         sharedMask = (1 << i);
        ConditionList* cmp        = spellInfo->Effects[i].ImplicitTargetConditions;
        for (uint8 effIndex = i + 1; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
        {
            if (spellInfo->Effects[effIndex].ImplicitTargetConditions == cmp)
                sharedMask |= 1 << effIndex;
        }
        sharedMasks.push_back(sharedMask);
    }

    for (std::list<uint32>::iterator itr = sharedMasks.begin(); itr != sharedMasks.end(); ++itr)
    {
        // some effect indexes should have same data
        if (uint32 commonMask = *itr & conditionEffMask)
        {
            uint8 firstEffIndex = 0;
            for (; firstEffIndex < MAX_SPELL_EFFECTS; ++firstEffIndex)
                if ((1 << firstEffIndex) & *itr)
                    break;

            if (firstEffIndex >= MAX_SPELL_EFFECTS)
                return false;

            // get shared data
            ConditionList* sharedList = spellInfo->Effects[firstEffIndex].ImplicitTargetConditions;

            // there's already data entry for that sharedMask
            if (sharedList)
            {
                // we have overlapping masks in db
                if (conditionEffMask != *itr)
                {
                    LOG_ERROR("sql.sql",
                              "SourceEntry {} in `condition` table, has incorrect SourceGroup {} (spell effectMask) set - "
                              "effect masks are overlapping (all SourceGroup values having given bit set must be equal) - ignoring.",
                              cond->SourceEntry, cond->SourceGroup);
                    return false;
                }
            }
            // no data for shared mask, we can create new submask
            else
            {
                // add new list, create new shared mask
                sharedList    = new ConditionList();
                bool assigned = false;
                for (uint8 i = firstEffIndex; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if ((1 << i) & commonMask)
                    {
                        spellInfo->Effects[i].ImplicitTargetConditions = sharedList;
                        assigned                                       = true;
                    }
                }

                if (!assigned)
                    delete sharedList;
            }
            if (sharedList)
                sharedList->push_back(cond);
            break;
        }
    }
    return true;
}

bool ConditionMgr::isSourceTypeValid(Condition* cond)
{
    if (cond->SourceType == CONDITION_SOURCE_TYPE_NONE || cond->SourceType >= CONDITION_SOURCE_TYPE_MAX)
    {
        LOG_ERROR("sql.sql", "Invalid ConditionSourceType {} in `condition` table, ignoring.", uint32(cond->SourceType));
        return false;
    }

    switch (cond->SourceType)
    {
    case CONDITION_SOURCE_TYPE_TERRAIN_SWAP:
    case CONDITION_SOURCE_TYPE_PHASE:
    case CONDITION_SOURCE_TYPE_GRAVEYARD:
    {
        LOG_ERROR("sql.sql", "ConditionSourceType {} in `condition` table is not supported on 3.3.5a, ignoring.", uint32(cond->SourceType));
        return false;
    }
    case CONDITION_SOURCE_TYPE_CREATURE_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Creature.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `creature_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Creature.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_DISENCHANT_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Disenchant.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `disenchant_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Disenchant.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_FISHING_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Fishing.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `fishing_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Fishing.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_GAMEOBJECT_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Gameobject.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `gameobject_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Gameobject.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_ITEM_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Item.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `item_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Item.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_MAIL_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Mail.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `mail_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Mail.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_MILLING_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Milling.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `milling_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Milling.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_PICKPOCKETING_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Pickpocketing.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `pickpocketing_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Pickpocketing.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_PROSPECTING_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Prospecting.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `prospecting_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Prospecting.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_REFERENCE_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Reference.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `reference_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Reference.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_SKINNING_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Skinning.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `skinning_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Skinning.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_SPELL_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Spell.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `spell_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate*       loot       = LootTemplates_Spell.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_SPELL_IMPLICIT_TARGET:
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(cond->SourceEntry);
        if (!spellInfo)
        {
            LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table, does not exist in `spell.dbc`, ignoring.", cond->SourceEntry);
            return false;
        }

        if ((cond->SourceGroup > MAX_EFFECT_MASK) || !cond->SourceGroup)
        {
            LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table, has incorrect SourceGroup {} (spell effectMask) set , ignoring.", cond->SourceEntry, cond->SourceGroup);
            return false;
        }

        uint32 origGroup = cond->SourceGroup;

        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (!((1 << i) & cond->SourceGroup))
                continue;

            switch (spellInfo->Effects[i].TargetA.GetSelectionCategory())
            {
            case TARGET_SELECT_CATEGORY_NEARBY:
            case TARGET_SELECT_CATEGORY_CONE:
            case TARGET_SELECT_CATEGORY_AREA:
            case TARGET_SELECT_CATEGORY_TRAJ:
                continue;
            default:
                break;
            }

            switch (spellInfo->Effects[i].TargetB.GetSelectionCategory())
            {
            case TARGET_SELECT_CATEGORY_NEARBY:
            case TARGET_SELECT_CATEGORY_CONE:
            case TARGET_SELECT_CATEGORY_AREA:
            case TARGET_SELECT_CATEGORY_TRAJ:
                continue;
            default:
                break;
            }

            switch (spellInfo->Effects[i].Effect)
            {
                case SPELL_EFFECT_PERSISTENT_AREA_AURA:
                case SPELL_EFFECT_APPLY_AREA_AURA_PARTY:
                case SPELL_EFFECT_APPLY_AREA_AURA_RAID:
                case SPELL_EFFECT_APPLY_AREA_AURA_FRIEND:
                case SPELL_EFFECT_APPLY_AREA_AURA_ENEMY:
                case SPELL_EFFECT_APPLY_AREA_AURA_PET:
                case SPELL_EFFECT_APPLY_AREA_AURA_OWNER:
                    continue;
                default:
                    break;
            }

            // Xinef: chain targets are treated as area targets! Apply conditions!
            if (spellInfo->Effects[i].ChainTarget > 1)
                continue;

            LOG_ERROR("sql.sql", "SourceEntry {} SourceGroup {} in `condition` table - spell {} does not have implicit targets of types: _AREA_, _CONE_, _NEARBY_ for effect {}, SourceGroup needs correction, ignoring.", cond->SourceEntry, origGroup, cond->SourceEntry, uint32(i));
            cond->SourceGroup &= ~(1 << i);
        }
        // all effects were removed, no need to add the condition at all
        if (!cond->SourceGroup)
            return false;
        break;
    }
    case CONDITION_SOURCE_TYPE_CREATURE_TEMPLATE_VEHICLE:
    {
        if (!sObjectMgr->GetCreatureTemplate(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table, does not exist in `creature_template`, ignoring.", cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_SPELL:
    case CONDITION_SOURCE_TYPE_SPELL_PROC:
    {
        SpellInfo const* spellProto = sSpellMgr->GetSpellInfo(cond->SourceEntry);
        if (!spellProto)
        {
            LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table, does not exist in `spell.dbc`, ignoring.", cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_QUEST_AVAILABLE:
        if (!sObjectMgr->GetQuestTemplate(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "CONDITION_SOURCE_TYPE_QUEST_AVAILABLE specifies non-existing quest ({}), skipped", cond->SourceEntry);
            return false;
        }
        break;
    case CONDITION_SOURCE_TYPE_UNUSED_20:
        LOG_ERROR("sql.sql", "CONDITION_SOURCE_TYPE_UNUSED_20 is not in use. SourceEntry = ({}), skipped", cond->SourceEntry);
        break;
    case CONDITION_SOURCE_TYPE_VEHICLE_SPELL:
    case CONDITION_SOURCE_TYPE_SPELL_CLICK_EVENT:
        if (!sObjectMgr->GetCreatureTemplate(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table, does not exist in `creature_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        if (!sSpellMgr->GetSpellInfo(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table, does not exist in `spell.dbc`, ignoring.", cond->SourceEntry);
            return false;
        }
        break;
    case CONDITION_SOURCE_TYPE_NPC_VENDOR:
    {
        if (!sObjectMgr->GetCreatureTemplate(cond->SourceGroup))
        {
            LOG_ERROR("condition", "SourceEntry {} in `condition` table, does not exist in `creature_template`, ignoring.", cond->SourceGroup);
            return false;
        }
        if (cond->SourceEntry)
        {
            ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(cond->SourceEntry);
            if (!itemTemplate)
            {
                LOG_ERROR("condition", "SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceEntry);
                return false;
            }
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_PLAYER_LOOT_TEMPLATE:
    {
        if (!LootTemplates_Player.HaveLootFor(cond->SourceGroup))
        {
            LOG_ERROR("sql.sql", "SourceGroup {} in `condition` table, does not exist in `player_loot_template`, ignoring.", cond->SourceGroup);
            return false;
        }

        LootTemplate* loot = LootTemplates_Player.GetLootForConditionFill(cond->SourceGroup);
        ItemTemplate const* pItemProto = sObjectMgr->GetItemTemplate(cond->SourceEntry);
        if (!pItemProto && !loot->isReference(cond->SourceEntry))
        {
            LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, does not exist in `item_template`, ignoring.", cond->SourceType, cond->SourceEntry);
            return false;
        }
        break;
    }
    case CONDITION_SOURCE_TYPE_GOSSIP_MENU:
    case CONDITION_SOURCE_TYPE_GOSSIP_MENU_OPTION:
    case CONDITION_SOURCE_TYPE_SMART_EVENT:
    case CONDITION_SOURCE_TYPE_NONE:
    default:
        break;
    }

    return true;
}
bool ConditionMgr::isConditionTypeValid(Condition* cond)
{
    if (cond->ConditionType == CONDITION_NONE || (cond->ConditionType >= CONDITION_TC_END && cond->ConditionType <= CONDITION_AC_START) || (cond->ConditionType >= CONDITION_AC_END))
    {
        LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table has an invalid ConditionType ({}), ignoring.", cond->SourceEntry, uint32(cond->ConditionType));
        return false;
    }
    switch (cond->ConditionType)
    {
    case CONDITION_TERRAIN_SWAP:
        LOG_ERROR("sql.sql", "SourceEntry {} in `condition` table has a ConditionType that is not supported on 3.3.5a ({}), ignoring.", cond->SourceEntry, uint32(cond->ConditionType));
        return false;
    default:
        break;
    }

    if (cond->ConditionTarget >= cond->GetMaxAvailableConditionTargets())
    {
        LOG_ERROR("sql.sql", "SourceType {}, SourceEntry {} in `condition` table, has incorrect ConditionTarget set, ignoring.", cond->SourceType, cond->SourceEntry);
        return false;
    }

    switch (cond->ConditionType)
    {
    case CONDITION_AURA:
    {
        if (!sSpellMgr->GetSpellInfo(cond->ConditionValue1))
        {
            LOG_ERROR("sql.sql", "Aura condition has non existing spell (Id: {}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2 > EFFECT_2)
        {
            LOG_ERROR("sql.sql", "Aura condition has non existing effect index ({}) (must be 0..2), skipped", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Aura condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_ITEM:
    {
        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(cond->ConditionValue1);
        if (!proto)
        {
            LOG_ERROR("sql.sql", "Item condition has non existing item ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (!cond->ConditionValue2)
        {
            LOG_ERROR("sql.sql", "Item condition has 0 set for item count in value2 ({}), skipped", cond->ConditionValue2);
            return false;
        }
        break;
    }
    case CONDITION_ITEM_EQUIPPED:
    {
        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(cond->ConditionValue1);
        if (!proto)
        {
            LOG_ERROR("sql.sql", "ItemEquipped condition has non existing item ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "ItemEquipped condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "ItemEquipped condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_ZONEID:
    {
        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(cond->ConditionValue1);
        if (!areaEntry)
        {
            LOG_ERROR("sql.sql", "ZoneID condition has non existing area ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (areaEntry->zone != 0)
        {
            LOG_ERROR("sql.sql", "ZoneID condition requires to be in area ({}) which is a subzone but zone expected, skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "ZoneID condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "ZoneID condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_REPUTATION_RANK:
    {
        FactionEntry const* factionEntry = sFactionStore.LookupEntry(cond->ConditionValue1);
        if (!factionEntry)
        {
            LOG_ERROR("sql.sql", "Reputation condition has non existing faction ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Reputation condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_TEAM:
    {
        if (cond->ConditionValue1 != ALLIANCE && cond->ConditionValue1 != HORDE)
        {
            LOG_ERROR("sql.sql", "Team condition specifies unknown team ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Team condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Team condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_SKILL:
    {
        SkillLineEntry const* pSkill = sSkillLineStore.LookupEntry(cond->ConditionValue1);
        if (!pSkill)
        {
            LOG_ERROR("sql.sql", "Skill condition specifies non-existing skill ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2 < 1 || cond->ConditionValue2 > sWorld->GetConfigMaxSkillValue())
        {
            LOG_ERROR("sql.sql", "Skill condition specifies invalid skill value ({}), skipped", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Skill condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_QUESTREWARDED:
    case CONDITION_QUESTTAKEN:
    case CONDITION_QUEST_NONE:
    case CONDITION_QUEST_COMPLETE:
    case CONDITION_DAILY_QUEST_DONE:
    case CONDITION_QUEST_SATISFY_EXCLUSIVE:
    {
        if (!sObjectMgr->GetQuestTemplate(cond->ConditionValue1))
        {
            LOG_ERROR("sql.sql", "Quest condition specifies non-existing quest ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2 > 1)
        {
            LOG_ERROR("sql.sql", "Quest condition has useless data in value2 ({})!", cond->ConditionValue2);
        }
        if (cond->ConditionValue3)
        {
            LOG_ERROR("sql.sql", "Quest condition has useless data in value3 ({})!", cond->ConditionValue3);
        }
        break;
    }
    case CONDITION_QUESTSTATE:
        if (cond->ConditionValue2 >= (1 << MAX_QUEST_STATUS))
        {
            LOG_ERROR("sql.sql", "ConditionType ({}) has invalid state mask ({}), skipped.", cond->ConditionType, cond->ConditionValue2);
            return false;
        }
        break;
    case CONDITION_ACTIVE_EVENT:
    {
        GameEventMgr::GameEventDataMap const& events = sGameEventMgr->GetEventMap();
        if (cond->ConditionValue1 >= events.size() || !events[cond->ConditionValue1].isValid())
        {
            LOG_ERROR("sql.sql", "ActiveEvent condition has non existing event id ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "ActiveEvent condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "ActiveEvent condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_ACHIEVEMENT:
    {
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(cond->ConditionValue1);
        if (!achievement)
        {
            LOG_ERROR("sql.sql", "Achivement condition has non existing achivement id ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Achivement condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Achivement condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_CLASS:
    {
        if (!(cond->ConditionValue1 & CLASSMASK_ALL_PLAYABLE))
        {
            LOG_ERROR("sql.sql", "Class condition has non existing classmask ({}), skipped", cond->ConditionValue1 & ~CLASSMASK_ALL_PLAYABLE);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Class condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Class condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_RACE:
    {
        if (!(cond->ConditionValue1 & RACEMASK_ALL_PLAYABLE))
        {
            LOG_ERROR("sql.sql", "Race condition has non existing racemask ({}), skipped", cond->ConditionValue1 & ~RACEMASK_ALL_PLAYABLE);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Race condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Race condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_GENDER:
    {
        if (!Player::IsValidGender(uint8(cond->ConditionValue1)))
        {
            LOG_ERROR("condition", "Gender condition has invalid gender ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("condition", "Gender condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("condition", "Gender condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_MAPID:
    {
        MapEntry const* mapId = sMapStore.LookupEntry(cond->ConditionValue1);
        if (!mapId)
        {
            LOG_ERROR("sql.sql", "Map condition has non existing map ({}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Map condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Map condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_SPELL:
    {
        if (!sSpellMgr->GetSpellInfo(cond->ConditionValue1))
        {
            LOG_ERROR("sql.sql", "Spell condition has non existing spell (Id: {}), skipped", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Spell condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Spell condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_LEVEL:
    {
        if (cond->ConditionValue2 >= COMP_TYPE_MAX)
        {
            LOG_ERROR("sql.sql", "Level condition has invalid option ({}), skipped", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Level condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_DRUNKENSTATE:
    {
        if (cond->ConditionValue1 > DRUNKEN_SMASHED)
        {
            LOG_ERROR("sql.sql", "DrunkState condition has invalid state ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue2)
        {
            LOG_ERROR("sql.sql", "DrunkState condition has useless data in value2 ({})!", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "DrunkState condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_NEAR_CREATURE:
    {
        if (!sObjectMgr->GetCreatureTemplate(cond->ConditionValue1))
        {
            LOG_ERROR("sql.sql", "NearCreature condition has non existing creature template entry ({}), skipped", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_NEAR_GAMEOBJECT:
    {
        if (!sObjectMgr->GetGameObjectTemplate(cond->ConditionValue1))
        {
            LOG_ERROR("sql.sql", "NearGameObject condition has non existing gameobject template entry ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue3 > 2)
            LOG_ERROR("sql.sql", "NearGameObject condition for gameobject ID ({}) has data over 2 for value3 ({})!", cond->ConditionValue1, cond->ConditionValue3);
        break;
    }
    case CONDITION_OBJECT_ENTRY_GUID:
    {
        switch (cond->ConditionValue1)
        {
        case TYPEID_UNIT:
            if (cond->ConditionValue2 && !sObjectMgr->GetCreatureTemplate(cond->ConditionValue2))
            {
                LOG_ERROR("sql.sql", "ObjectEntryGuid condition has non existing creature template entry ({}), skipped", cond->ConditionValue2);
                return false;
            }
            if (cond->ConditionValue3 > 1)
            {
                if (CreatureData const* creatureData = sObjectMgr->GetCreatureData(cond->ConditionValue3))
                {
                    if (cond->ConditionValue2 && creatureData->id1 != cond->ConditionValue2)
                    {
                        LOG_ERROR("sql.sql", "ObjectEntryGuid condition has guid {} set but does not match creature entry ({}), skipped", cond->ConditionValue3, cond->ConditionValue2);
                        return false;
                    }
                }
                else
                {
                    LOG_ERROR("sql.sql", "ObjectEntryGuid condition has non existing creature guid ({}), skipped", cond->ConditionValue3);
                    return false;
                }
            }
            break;
        case TYPEID_GAMEOBJECT:
            if (cond->ConditionValue2 && !sObjectMgr->GetGameObjectTemplate(cond->ConditionValue2))
            {
                LOG_ERROR("sql.sql", "ObjectEntryGuid condition has non existing gameobject template entry ({}), skipped", cond->ConditionValue2);
                return false;
            }
            if (cond->ConditionValue3)
            {
                if (GameObjectData const* goData = sObjectMgr->GetGameObjectData(cond->ConditionValue3))
                {
                    if (cond->ConditionValue2 && goData->id != cond->ConditionValue2)
                    {
                        LOG_ERROR("sql.sql", "ObjectEntryGuid condition has guid {} set but does not match gameobject entry ({}), skipped", cond->ConditionValue3, cond->ConditionValue2);
                        return false;
                    }
                }
                else
                {
                    LOG_ERROR("sql.sql", "ObjectEntryGuid condition has non existing gameobject guid ({}), skipped", cond->ConditionValue3);
                    return false;
                }
            }
            break;
        case TYPEID_PLAYER:
        case TYPEID_CORPSE:
            if (cond->ConditionValue2)
                LOG_ERROR("sql.sql", "ObjectEntryGuid condition has useless data in value2 ({})!", cond->ConditionValue2);
            if (cond->ConditionValue3)
                LOG_ERROR("sql.sql", "ObjectEntryGuid condition has useless data in value3 ({})!", cond->ConditionValue3);
            break;
        default:
            LOG_ERROR("sql.sql", "ObjectEntryGuid condition has wrong typeid set ({}), skipped", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_TYPE_MASK:
    {
        if (!cond->ConditionValue1 || (cond->ConditionValue1 & ~(TYPEMASK_UNIT | TYPEMASK_PLAYER | TYPEMASK_GAMEOBJECT | TYPEMASK_CORPSE)))
        {
            LOG_ERROR("sql.sql", "TypeMask condition has invalid typemask set ({}), skipped", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "TypeMask condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "TypeMask condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_RELATION_TO:
    {
        if (cond->ConditionValue1 >= cond->GetMaxAvailableConditionTargets())
        {
            LOG_ERROR("sql.sql", "RelationTo condition has invalid ConditionValue1(ConditionTarget selection) ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue1 == cond->ConditionTarget)
        {
            LOG_ERROR("sql.sql", "RelationTo condition has ConditionValue1(ConditionTarget selection) set to self ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue2 >= RELATION_MAX)
        {
            LOG_ERROR("sql.sql", "RelationTo condition has invalid ConditionValue2(RelationType) ({}), skipped", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "RelationTo condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_REACTION_TO:
    {
        if (cond->ConditionValue1 >= cond->GetMaxAvailableConditionTargets())
        {
            LOG_ERROR("sql.sql", "ReactionTo condition has invalid ConditionValue1(ConditionTarget selection) ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue1 == cond->ConditionTarget)
        {
            LOG_ERROR("sql.sql", "ReactionTo condition has ConditionValue1(ConditionTarget selection) set to self ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (!cond->ConditionValue2)
        {
            LOG_ERROR("sql.sql", "mConditionValue2 condition has invalid ConditionValue2(rankMask) ({}), skipped", cond->ConditionValue2);
            return false;
        }
        break;
    }
    case CONDITION_DISTANCE_TO:
    {
        if (cond->ConditionValue1 >= cond->GetMaxAvailableConditionTargets())
        {
            LOG_ERROR("sql.sql", "DistanceTo condition has invalid ConditionValue1(ConditionTarget selection) ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue1 == cond->ConditionTarget)
        {
            LOG_ERROR("sql.sql", "DistanceTo condition has ConditionValue1(ConditionTarget selection) set to self ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue3 >= COMP_TYPE_MAX)
        {
            LOG_ERROR("sql.sql", "DistanceTo condition has invalid ComparisionType ({}), skipped", cond->ConditionValue3);
            return false;
        }
        break;
    }
    case CONDITION_ALIVE:
    {
        if (cond->ConditionValue1)
            LOG_ERROR("sql.sql", "Alive condition has useless data in value1 ({})!", cond->ConditionValue1);
        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Alive condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Alive condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_HP_VAL:
    {
        if (cond->ConditionValue2 >= COMP_TYPE_MAX)
        {
            LOG_ERROR("sql.sql", "HpVal condition has invalid ComparisionType ({}), skipped", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "HpVal condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_HP_PCT:
    {
        if (cond->ConditionValue1 > 100)
        {
            LOG_ERROR("sql.sql", "HpPct condition has too big percent value ({}), skipped", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue2 >= COMP_TYPE_MAX)
        {
            LOG_ERROR("sql.sql", "HpPct condition has invalid ComparisionType ({}), skipped", cond->ConditionValue2);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "HpPct condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_AREAID:
    case CONDITION_INSTANCE_INFO:
        break;
    case CONDITION_WORLD_STATE:
    {
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "World state condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_PHASEMASK:
    {
        if (cond->ConditionValue2)
            LOG_ERROR("sql.sql", "Phasemask condition has useless data in value2 ({})!", cond->ConditionValue2);
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "Phasemask condition has useless data in value3 ({})!", cond->ConditionValue3);
        break;
    }
    case CONDITION_TITLE:
    {
        CharTitlesEntry const* titleEntry = sCharTitlesStore.LookupEntry(cond->ConditionValue1);
        if (!titleEntry)
        {
            LOG_ERROR("sql.sql", "Title condition has non existing title in value1 ({}), skipped", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_SPAWNMASK:
    {
        if (cond->ConditionValue1 > SPAWNMASK_RAID_ALL)
        {
            LOG_ERROR("condition", "SpawnMask condition has non existing SpawnMask in value1 ({}), skipped", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_UNIT_STATE:
    {
        if (!(cond->ConditionValue1 & UNIT_STATE_ALL_STATE_SUPPORTED))
        {
            LOG_ERROR("condition", "UnitState condition has non existing UnitState in value1 ({}), skipped", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_CREATURE_TYPE:
    {
        if (!cond->ConditionValue1 || cond->ConditionValue1 > CREATURE_TYPE_GAS_CLOUD)
        {
            LOG_ERROR("condition", "CreatureType condition has non existing CreatureType in value1 ({}), skipped", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_REALM_ACHIEVEMENT:
    {
        AchievementEntry const* achievement = sAchievementStore.LookupEntry(cond->ConditionValue1);
        if (!achievement)
        {
            LOG_ERROR("condition", "CONDITION_REALM_ACHIEVEMENT has non existing realm first achivement id ({}), skipped.", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_QUEST_OBJECTIVE_PROGRESS:
    {
        const Quest* quest = sObjectMgr->GetQuestTemplate(cond->ConditionValue1);
        if (!quest)
        {
            LOG_ERROR("sql.sql", "CONDITION_QUEST_OBJECTIVE_PROGRESS points to non-existing quest ({}), skipped.", cond->ConditionValue1);
            return false;
        }

        if (cond->ConditionValue2 > 3)
        {
            LOG_ERROR("sql.sql", "CONDITION_QUEST_OBJECTIVE_PROGRESS has out-of-range quest objective index specified ({}), it must be a number between 0 and 3. skipped.", cond->ConditionValue2);
            return false;
        }

        if (quest->RequiredNpcOrGo[cond->ConditionValue2] == 0)
        {
            LOG_ERROR("sql.sql", "CONDITION_QUEST_OBJECTIVE_PROGRESS has quest objective {} for quest {}, but the field RequiredNPCOrGo{} is 0, skipped.", cond->ConditionValue2, cond->ConditionValue1, cond->ConditionValue2);
            return false;
        }

        if (cond->ConditionValue3 > quest->RequiredNpcOrGoCount[cond->ConditionValue2])
        {
            LOG_ERROR("sql.sql", "CONDITION_QUEST_OBJECTIVE_PROGRESS has quest objective count {} in value3, but quest {} has a maximum objective count of {} in RequiredNPCOrGOCount{}, skipped.", cond->ConditionValue3, cond->ConditionValue2, quest->RequiredNpcOrGoCount[cond->ConditionValue2], cond->ConditionValue2);
            return false;
        }
        break;
    }
    case CONDITION_HAS_AURA_TYPE:
    {
        if (cond->ConditionValue1 == SPELL_AURA_NONE || cond->ConditionValue1 >= TOTAL_AURAS)
        {
            LOG_ERROR("sql.sql", "Has Aura Effect condition has non existing aura ({}), skipped", cond->ConditionValue1);
            return false;
        }
        break;
    }
    case CONDITION_STAND_STATE:
    {
        bool valid = false;
        switch (cond->ConditionValue1)
        {
            case 0:
                valid = cond->ConditionValue2 <= UNIT_STAND_STATE_SUBMERGED;
                break;
            case 1:
                valid = cond->ConditionValue2 <= 1;
                break;
            default:
                valid = false;
                break;
        }
        if (!valid)
        {
            LOG_ERROR("sql.sql", "CONDITION_STAND_STATE has non-existing stand state ({},{}), skipped.", cond->ConditionValue1, cond->ConditionValue2);
            return false;
        }
        break;
    }
    case CONDITION_DIFFICULTY_ID:
        if (cond->ConditionValue1 >= MAX_DIFFICULTY)
        {
            LOG_ERROR("sql.sql", "CONDITION_DIFFICULTY_ID has non existing difficulty in value1 ({}), skipped.", cond->ConditionValue1);
            return false;
        }
        break;
    case CONDITION_PLAYER_QUEUED_RANDOM_DUNGEON:
        if (cond->ConditionValue1 > 1)
        {
            LOG_ERROR("sql.sql", "RandomDungeon condition has useless data in value1 ({}).", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue2 >= MAX_DIFFICULTY)
        {
            LOG_ERROR("sql.sql", "RandomDungeon condition has invalid difficulty in value2 ({}).", cond->ConditionValue1);
            return false;
        }
        if (cond->ConditionValue3)
            LOG_ERROR("sql.sql", "RandomDungeon condition has useless data in value3 ({}).", cond->ConditionValue3);
        break;
    case CONDITION_PET_TYPE:
        if (cond->ConditionValue1 >= (1 << MAX_PET_TYPE))
        {
            LOG_ERROR("sql.sql", "CONDITION_PET_TYPE has non-existing pet type {}, skipped.", cond->ConditionValue1);
            return false;
        }
        break;
    case CONDITION_TAXI:
    case CONDITION_IN_WATER:
    case CONDITION_CHARMED:
    default:
        break;
    }
    return true;
}

void ConditionMgr::Clean()
{
    for (ConditionReferenceContainer::iterator itr = ConditionReferenceStore.begin(); itr != ConditionReferenceStore.end(); ++itr)
    {
        for (ConditionList::const_iterator it = itr->second.begin(); it != itr->second.end(); ++it) delete *it;
        itr->second.clear();
    }

    ConditionReferenceStore.clear();

    for (ConditionContainer::iterator itr = ConditionStore.begin(); itr != ConditionStore.end(); ++itr)
    {
        for (ConditionTypeContainer::iterator it = itr->second.begin(); it != itr->second.end(); ++it)
        {
            for (ConditionList::const_iterator i = it->second.begin(); i != it->second.end(); ++i) delete *i;
            it->second.clear();
        }
        itr->second.clear();
    }

    ConditionStore.clear();

    for (CreatureSpellConditionContainer::iterator itr = VehicleSpellConditionStore.begin(); itr != VehicleSpellConditionStore.end(); ++itr)
    {
        for (ConditionTypeContainer::iterator it = itr->second.begin(); it != itr->second.end(); ++it)
        {
            for (ConditionList::const_iterator i = it->second.begin(); i != it->second.end(); ++i) delete *i;
            it->second.clear();
        }
        itr->second.clear();
    }

    VehicleSpellConditionStore.clear();

    for (SmartEventConditionContainer::iterator itr = SmartEventConditionStore.begin(); itr != SmartEventConditionStore.end(); ++itr)
    {
        for (ConditionTypeContainer::iterator it = itr->second.begin(); it != itr->second.end(); ++it)
        {
            for (ConditionList::const_iterator i = it->second.begin(); i != it->second.end(); ++i) delete *i;
            it->second.clear();
        }
        itr->second.clear();
    }

    SmartEventConditionStore.clear();

    for (CreatureSpellConditionContainer::iterator itr = SpellClickEventConditionStore.begin(); itr != SpellClickEventConditionStore.end(); ++itr)
    {
        for (ConditionTypeContainer::iterator it = itr->second.begin(); it != itr->second.end(); ++it)
        {
            for (ConditionList::const_iterator i = it->second.begin(); i != it->second.end(); ++i) delete *i;
            it->second.clear();
        }
        itr->second.clear();
    }

    SpellClickEventConditionStore.clear();

    for (NpcVendorConditionContainer::iterator itr = NpcVendorConditionContainerStore.begin(); itr != NpcVendorConditionContainerStore.end(); ++itr)
    {
        for (ConditionTypeContainer::iterator it = itr->second.begin(); it != itr->second.end(); ++it)
        {
            for (ConditionList::const_iterator i = it->second.begin(); i != it->second.end(); ++i) delete *i;
            it->second.clear();
        }
        itr->second.clear();
    }

    NpcVendorConditionContainerStore.clear();

    // this is a BIG hack, feel free to fix it if you can figure out the ConditionMgr ;)
    for (std::list<Condition*>::const_iterator itr = AllocatedMemoryStore.begin(); itr != AllocatedMemoryStore.end(); ++itr) delete *itr;

    AllocatedMemoryStore.clear();
}
