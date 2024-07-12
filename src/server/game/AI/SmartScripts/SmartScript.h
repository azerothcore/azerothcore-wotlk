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

#ifndef ACORE_SMARTSCRIPT_H
#define ACORE_SMARTSCRIPT_H

#include "Common.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "GridNotifiers.h"
#include "SmartScriptMgr.h"
#include "Spell.h"
#include "Unit.h"

class SmartScript
{
public:
    SmartScript();
    ~SmartScript();

    void OnInitialize(WorldObject* obj, AreaTrigger const* at = nullptr);
    void GetScript();
    void FillScript(SmartAIEventList e, WorldObject* obj, AreaTrigger const* at);

    void ProcessEventsFor(SMART_EVENT e, Unit* unit = nullptr, uint32 var0 = 0, uint32 var1 = 0, bool bvar = false, SpellInfo const* spell = nullptr, GameObject* gob = nullptr);
    void ProcessEvent(SmartScriptHolder& e, Unit* unit = nullptr, uint32 var0 = 0, uint32 var1 = 0, bool bvar = false, SpellInfo const* spell = nullptr, GameObject* gob = nullptr);
    bool CheckTimer(SmartScriptHolder const& e) const;
    static void RecalcTimer(SmartScriptHolder& e, uint32 min, uint32 max);
    void UpdateTimer(SmartScriptHolder& e, uint32 const diff);
    static void InitTimer(SmartScriptHolder& e);
    void ProcessAction(SmartScriptHolder& e, Unit* unit = nullptr, uint32 var0 = 0, uint32 var1 = 0, bool bvar = false, SpellInfo const* spell = nullptr, GameObject* gob = nullptr);
    void ProcessTimedAction(SmartScriptHolder& e, uint32 const& min, uint32 const& max, Unit* unit = nullptr, uint32 var0 = 0, uint32 var1 = 0, bool bvar = false, SpellInfo const* spell = nullptr, GameObject* gob = nullptr);
    void GetTargets(ObjectVector& targets, SmartScriptHolder const& e, Unit* invoker = nullptr) const;
    void GetWorldObjectsInDist(ObjectVector& objects, float dist) const;
    void InstallTemplate(SmartScriptHolder const& e);
    static SmartScriptHolder CreateSmartEvent(SMART_EVENT e, uint32 event_flags, uint32 event_param1, uint32 event_param2, uint32 event_param3, uint32 event_param4, uint32 event_param5, uint32 event_param6, SMART_ACTION action, uint32 action_param1, uint32 action_param2, uint32 action_param3, uint32 action_param4, uint32 action_param5, uint32 action_param6, SMARTAI_TARGETS t, uint32 target_param1, uint32 target_param2, uint32 target_param3, uint32 target_param4, uint32 phaseMask);
    void AddEvent(SMART_EVENT e, uint32 event_flags, uint32 event_param1, uint32 event_param2, uint32 event_param3, uint32 event_param4, uint32 event_param5, uint32 event_param6, SMART_ACTION action, uint32 action_param1, uint32 action_param2, uint32 action_param3, uint32 action_param4, uint32 action_param5, uint32 action_param6, SMARTAI_TARGETS t, uint32 target_param1, uint32 target_param2, uint32 target_param3, uint32 target_param4, uint32 phaseMask);
    void SetPathId(uint32 id) { mPathId = id; }
    uint32 GetPathId() const { return mPathId; }
    WorldObject* GetBaseObject() const
    {
        WorldObject* obj = nullptr;
        if (me)
            obj = me;
        else if (go)
            obj = go;
        return obj;
    }

    static bool IsUnit(WorldObject* obj);
    static bool IsPlayer(WorldObject* obj);
    static bool IsCreature(WorldObject* obj);
    static bool IsCharmedCreature(WorldObject* obj);
    static bool IsGameObject(WorldObject* obj);

    void OnUpdate(const uint32 diff);
    void OnMoveInLineOfSight(Unit* who);

    Unit* DoSelectLowestHpFriendly(float range, uint32 MinHPDiff) const;
    Unit* DoSelectLowestHpPercentFriendly(float range, uint32 minHpPct, uint32 maxHpPct) const;
    void DoFindFriendlyCC(std::vector<Creature*>& creatures, float range) const;
    void DoFindFriendlyMissingBuff(std::vector<Creature*>& creatures, float range, uint32 spellid) const;
    Unit* DoFindClosestFriendlyInRange(float range, bool playerOnly) const;

    bool IsSmart(Creature* c, bool silent = false) const;
    bool IsSmart(GameObject* g, bool silent = false) const;
    bool IsSmart(bool silent = false) const;

    void StoreTargetList(ObjectVector const& targets, uint32 id)
    {
        // insert or replace
        _storedTargets.erase(id);
        _storedTargets.emplace(id, ObjectGuidVector(targets));
    }

    ObjectVector const* GetStoredTargetVector(uint32 id, WorldObject const& ref) const
    {
        auto itr = _storedTargets.find(id);
        if (itr != _storedTargets.end())
            return itr->second.GetObjectVector(ref);
        return nullptr;
    }

    void StoreCounter(uint32 id, uint32 value, uint32 reset, uint32 subtract)
    {
        CounterMap::iterator itr = mCounterList.find(id);
        if (itr != mCounterList.end())
        {
            if (!reset && !subtract)
            {
                itr->second += value;
            }
            else if (subtract)
            {
                itr->second -= value;
            }
            else
            {
                itr->second = value;
            }
        }
        else
        {
            mCounterList.insert(std::make_pair(id, value));
        }

        ProcessEventsFor(SMART_EVENT_COUNTER_SET, nullptr, id);
    }

    uint32 GetCounterValue(uint32 id)
    {
        CounterMap::iterator itr = mCounterList.find(id);
        if (itr != mCounterList.end())
            return itr->second;
        return 0;
    }

    GameObject* FindGameObjectNear(WorldObject* searchObject, ObjectGuid::LowType guid) const
    {
        auto bounds = searchObject->GetMap()->GetGameObjectBySpawnIdStore().equal_range(guid);
        if (bounds.first == bounds.second)
            return nullptr;

        return bounds.first->second;
    }

    Creature* FindCreatureNear(WorldObject* searchObject, ObjectGuid::LowType guid) const
    {
        auto bounds = searchObject->GetMap()->GetCreatureBySpawnIdStore().equal_range(guid);
        if (bounds.first == bounds.second)
            return nullptr;

        auto creatureItr = std::find_if(bounds.first, bounds.second, [](Map::CreatureBySpawnIdContainer::value_type const& pair)
        {
            return pair.second->IsAlive();
        });

        return creatureItr != bounds.second ? creatureItr->second : bounds.first->second;
    }

    void OnReset();
    void ResetBaseObject()
    {
        WorldObject* lookupRoot = me;
        if (!lookupRoot)
            lookupRoot = go;

        if (lookupRoot)
        {
            if (meOrigGUID)
            {
                if (Creature* m = ObjectAccessor::GetCreature(*lookupRoot, meOrigGUID))
                {
                    me = m;
                    go = nullptr;
                }
            }

            if (goOrigGUID)
            {
                if (GameObject* o = ObjectAccessor::GetGameObject(*lookupRoot, goOrigGUID))
                {
                    me = nullptr;
                    go = o;
                }
            }
        }

        goOrigGUID.Clear();
        meOrigGUID.Clear();
    }

    //TIMED_ACTIONLIST (script type 9 aka script9)
    void SetScript9(SmartScriptHolder& e, uint32 entry);
    Unit* GetLastInvoker(Unit* invoker = nullptr) const;
    ObjectGuid mLastInvoker;
    typedef std::unordered_map<uint32, uint32> CounterMap;
    CounterMap mCounterList;

    bool AllowPhaseReset() const { return _allowPhaseReset; }
    void SetPhaseReset(bool allow) { _allowPhaseReset = allow; }

    void AddCreatureSummon(ObjectGuid const& guid);
    void RemoveCreatureSummon(ObjectGuid const& guid);

private:
    void IncPhase(uint32 p);
    void DecPhase(uint32 p);
    void SetPhase(uint32 p);
    bool IsInPhase(uint32 p) const;

    void SortEvents(SmartAIEventList& events);
    void RaisePriority(SmartScriptHolder& e);
    void RetryLater(SmartScriptHolder& e, bool ignoreChanceRoll = false);

    SmartAIEventList mEvents;
    SmartAIEventList mInstallEvents;
    SmartAIEventList mTimedActionList;
    bool isProcessingTimedActionList;
    Creature* me;
    ObjectGuid meOrigGUID;
    GameObject* go;
    ObjectGuid goOrigGUID;
    AreaTrigger const* trigger;
    SmartScriptType mScriptType;
    uint32 mEventPhase;

    std::unordered_map<int32, int32> mStoredDecimals;
    uint32 mPathId;
    SmartAIEventStoredList mStoredEvents;
    std::list<uint32> mRemIDs;

    uint32 mTextTimer;
    uint32 mLastTextID;
    uint32 mTalkerEntry;
    bool mUseTextTimer;
    uint32 mCurrentPriority;
    bool mEventSortingRequired;

    // Xinef: misc
    bool _allowPhaseReset;

    ObjectVectorMap _storedTargets;

    SMARTAI_TEMPLATE mTemplate;
    void InstallEvents();

    void RemoveStoredEvent (uint32 id)
    {
        if (!mStoredEvents.empty())
        {
            for (SmartAIEventStoredList::iterator i = mStoredEvents.begin(); i != mStoredEvents.end(); ++i)
            {
                if (i->event_id == id)
                {
                    mStoredEvents.erase(i);
                    return;
                }
            }
        }
    }
    SmartScriptHolder FindLinkedEvent (uint32 link)
    {
        if (!mEvents.empty())
        {
            for (SmartAIEventList::iterator i = mEvents.begin(); i != mEvents.end(); ++i)
            {
                if (i->event_id == link)
                {
                    return (*i);
                }
            }
        }
        SmartScriptHolder s;
        return s;
    }

    GuidUnorderedSet _summonList;
};

#endif
