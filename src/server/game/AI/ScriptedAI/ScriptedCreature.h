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

#ifndef SCRIPTEDCREATURE_H_
#define SCRIPTEDCREATURE_H_

#include "Creature.h"
#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "EventMap.h"
#include "InstanceScript.h"
#include "TaskScheduler.h"

#define CAST_AI(a, b)   (dynamic_cast<a*>(b))

typedef std::list<WorldObject*> ObjectList;

class InstanceScript;

class SummonList
{
public:
    typedef GuidList StorageType;
    typedef StorageType::iterator iterator;
    typedef StorageType::const_iterator const_iterator;
    typedef StorageType::size_type size_type;
    typedef StorageType::value_type value_type;

    explicit SummonList(Creature* creature)
        : me(creature)
    { }

    // And here we see a problem of original inheritance approach. People started
    // to exploit presence of std::list members, so I have to provide wrappers

    iterator begin()
    {
        return storage_.begin();
    }

    const_iterator begin() const
    {
        return storage_.begin();
    }

    iterator end()
    {
        return storage_.end();
    }

    const_iterator end() const
    {
        return storage_.end();
    }

    iterator erase(iterator i)
    {
        return storage_.erase(i);
    }

    bool empty() const
    {
        return storage_.empty();
    }

    size_type size() const
    {
        return storage_.size();
    }

    void clear()
    {
        storage_.clear();
    }

    void Summon(Creature const* summon) { storage_.push_back(summon->GetGUID()); }
    void Despawn(Creature const* summon) { storage_.remove(summon->GetGUID()); }
    void DespawnEntry(uint32 entry);
    void DespawnAll(uint32 delay = 0);
    bool IsAnyCreatureAlive() const;
    bool IsAnyCreatureWithEntryAlive(uint32 entry) const;
    bool IsAnyCreatureInCombat() const;

    template <typename T>
    void DespawnIf(T const& predicate)
    {
        storage_.remove_if(predicate);
    }

    void DoAction(int32 info, uint16 max = 0)
    {
        if (max)
            RemoveNotExisting(); // pussywizard: when max is set, non existing can be chosen and nothing will happen

        StorageType listCopy = storage_;
        for (StorageType::const_iterator i = listCopy.begin(); i != listCopy.end(); ++i)
        {
            if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                if (summon->IsAIEnabled)
                    summon->AI()->DoAction(info);
        }
    }

    template <class Predicate>
    void DoAction(int32 info, Predicate&& predicate, uint16 max = 0)
    {
        if (max)
            RemoveNotExisting(); // pussywizard: when max is set, non existing can be chosen and nothing will happen

        // We need to use a copy of SummonList here, otherwise original SummonList would be modified
        StorageType listCopy = storage_;
        Acore::Containers::RandomResize<StorageType, Predicate>(listCopy, std::forward<Predicate>(predicate), max);

        for (auto const& guid : listCopy)
        {
            Creature* summon = ObjectAccessor::GetCreature(*me, guid);
            if (summon && summon->IsAIEnabled)
            {
                summon->AI()->DoAction(info);
            }
            else if (!summon)
            {
                storage_.remove(guid);
            }
        }
    }

    void DoForAllSummons(std::function<void(WorldObject*)> exec)
    {
        // We need to use a copy of SummonList here, otherwise original SummonList would be modified
        StorageType listCopy = storage_;

        for (auto const& guid : listCopy)
        {
            if (WorldObject* summon = ObjectAccessor::GetWorldObject(*me, guid))
            {
                exec(summon);
            }
        }
    }

    void DoZoneInCombat(uint32 entry = 0);
    void RemoveNotExisting();
    bool HasEntry(uint32 entry) const;
    uint32 GetEntryCount(uint32 entry) const;
    void Respawn();
    Creature* GetCreatureWithEntry(uint32 entry) const;

private:
    Creature* me;
    StorageType storage_;
};

class EntryCheckPredicate
{
public:
    EntryCheckPredicate(uint32 entry) : _entry(entry) {}
    bool operator()(ObjectGuid guid) { return guid.GetEntry() == _entry; }

private:
    uint32 _entry;
};

class PlayerOrPetCheck
{
public:
    bool operator() (WorldObject* unit) const
    {
        if (unit->GetTypeId() != TYPEID_PLAYER)
            if (!unit->ToUnit()->GetOwnerGUID().IsPlayer())
                return true;

        return false;
    }
};

struct ScriptedAI : public CreatureAI
{
    explicit ScriptedAI(Creature* creature);
    ~ScriptedAI() override {}

    // *************
    //CreatureAI Functions
    // *************

    void AttackStartNoMove(Unit* target);

    // Called at any Damage from any attacker (before damage apply)
    void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/, DamageEffectType /*damagetype*/, SpellSchoolMask /*damageSchoolMask*/) override {}

    //Called at World update tick
    void UpdateAI(uint32 diff) override;

    //Called at creature death
    void JustDied(Unit* /*killer*/) override {}

    //Called at creature killing another unit
    void KilledUnit(Unit* /*victim*/) override {}

    // Called when the creature summon successfully other creature
    void JustSummoned(Creature* /*summon*/) override {}

    // Called when a summoned creature is despawned
    void SummonedCreatureDespawn(Creature* /*summon*/) override {}

    // Called when hit by a spell
    void SpellHit(Unit* /*caster*/, SpellInfo const* /*spell*/) override {}

    // Called when spell hits a target
    void SpellHitTarget(Unit* /*target*/, SpellInfo const* /*spell*/) override {}

    //Called at waypoint reached or PointMovement end
    void MovementInform(uint32 /*type*/, uint32 /*id*/) override {}

    // Called when AI is temporarily replaced or put back when possess is applied or removed
    void OnPossess(bool /*apply*/) {}

    enum class Axis
    {
        AXIS_X,
        AXIS_Y
    };

    /* This is called for bosses whenever an encounter is happening.
     * - Arguments:
     * - Position has to be passed as a constant pointer (&Position)
     * - Axis is the X or Y axis that is used to decide the position threshold
     * - Above decides if the boss position should be above the passed position
     *   or below.
     * Example:
     * Hodir is in room until his Y position is below the Door position:
     * IsInRoom(doorPosition, AXIS_Y, false);
     */
    bool IsInRoom(const Position* pos, Axis axis, bool above)
    {
        if (!pos)
        {
            return true;
        }

        switch (axis)
        {
            case Axis::AXIS_X:
                if ((!above && me->GetPositionX() < pos->GetPositionX()) || me->GetPositionX() > pos->GetPositionX())
                {
                    EnterEvadeMode();
                    return false;
                }
                break;
            case Axis::AXIS_Y:
                if ((!above && me->GetPositionY() < pos->GetPositionY())  || me->GetPositionY() > pos->GetPositionY())
                {
                    EnterEvadeMode();
                    return false;
                }

                break;
        }

        return true;
    }

    // *************
    // Variables
    // *************

    //Pointer to creature we are manipulating
    Creature* me;

    //For fleeing
    bool IsFleeing;

    // *************
    //Pure virtual functions
    // *************

    //Called at creature reset either by death or evade
    void Reset() override {}

    //Called at creature aggro either by MoveInLOS or Attack Start
    void JustEngagedWith(Unit* /*who*/) override {}

    // Called before JustEngagedWith even before the creature is in combat.
    void AttackStart(Unit* /*target*/) override;

    // *************
    //AI Helper Functions
    // *************

    //Start movement toward victim
    void DoStartMovement(Unit* target, float distance = 0.0f, float angle = 0.0f);

    //Start no movement on victim
    void DoStartNoMovement(Unit* target);

    //Stop attack of current victim
    void DoStopAttack();

    //Cast spell by spell info
    void DoCastSpell(Unit* target, SpellInfo const* spellInfo, bool triggered = false);

    //Plays a sound to all nearby players
    void DoPlaySoundToSet(WorldObject* source, uint32 soundId);

    //Plays music for all players in the zone (zone = true) or the area (zone = false)
    void DoPlayMusic(uint32 soundId, bool zone);

    // Add specified amount of threat directly to victim (ignores redirection effects) - also puts victim in combat and engages them if necessary
    void DoAddThreat(Unit* unit, float amount);

    // Adds/removes the specified percentage from the specified victim's threat (to who, or me if not specified)
    void DoModifyThreatByPercent(Unit* unit, int32 pct);

    //Drops all threat to 0%. Does not remove players from the threat list
    void DoResetThreat(Unit* unit);

    // Resets the specified unit's threat list (me if not specified) - does not delete entries, just sets their threat to zero
    void DoResetThreatList();

    // Returns the threat level of victim towards who (or me if not specified)
    float DoGetThreat(Unit* unit);

    //Teleports a player without dropping threat (only teleports to same map)
    void DoTeleportPlayer(Unit* unit, float x, float y, float z, float o);
    void DoTeleportAll(float x, float y, float z, float o);

    //Returns friendly unit with the most amount of hp missing from max hp
    Unit* DoSelectLowestHpFriendly(float range, uint32 minHPDiff = 1);

    //Returns a list of friendly CC'd units within range
    std::list<Creature*> DoFindFriendlyCC(float range);

    //Returns a list of all friendly units missing a specific buff within range
    std::list<Creature*> DoFindFriendlyMissingBuff(float range, uint32 spellId);

    //Return a player with at least minimumRange from me
    Player* GetPlayerAtMinimumRange(float minRange);

    //Spawns a creature relative to me
    Creature* DoSpawnCreature(uint32 entry, float offsetX, float offsetY, float offsetZ, float angle, uint32 type, uint32 despawntime);

    bool IsUniqueTimedEventDone(uint32 id) const { return _uniqueTimedEvents.find(id) != _uniqueTimedEvents.end(); }
    void SetUniqueTimedEventDone(uint32 id) { _uniqueTimedEvents.insert(id); }
    void ResetUniqueTimedEvent(uint32 id) { _uniqueTimedEvents.erase(id); }
    void ClearUniqueTimedEventsDone() { _uniqueTimedEvents.clear(); }

    // Schedules a timed event using task scheduler.
    void ScheduleTimedEvent(Milliseconds timerMin, Milliseconds timerMax, std::function<void()> exec, Milliseconds repeatMin, Milliseconds repeatMax = 0s, uint32 uniqueId = 0);
    void ScheduleTimedEvent(Milliseconds timerMax, std::function<void()> exec, Milliseconds repeatMin, Milliseconds repeatMax = 0s, uint32 uniqueId = 0) { ScheduleTimedEvent(0s, timerMax, exec, repeatMin, repeatMax, uniqueId); };

    // Schedules a timed event using task scheduler that never repeats. Requires an unique non-zero ID.
    void ScheduleUniqueTimedEvent(Milliseconds timer, std::function<void()> exec, uint32 uniqueId) { ScheduleTimedEvent(0s, timer, exec, 0s, 0s, uniqueId); };

    bool HealthBelowPct(uint32 pct) const { return me->HealthBelowPct(pct); }
    bool HealthAbovePct(uint32 pct) const { return me->HealthAbovePct(pct); }

    //Returns spells that meet the specified criteria from the creatures spell list
    SpellInfo const* SelectSpell(Unit* target, uint32 school, uint32 mechanic, SelectTargetType targets, uint32 powerCostMin, uint32 powerCostMax, float rangeMin, float rangeMax, SelectEffect effect);

    void SetEquipmentSlots(bool loadDefault, int32 mainHand = EQUIP_NO_CHANGE, int32 offHand = EQUIP_NO_CHANGE, int32 ranged = EQUIP_NO_CHANGE);

    virtual bool CheckEvadeIfOutOfCombatArea() const { return false; }

    // return true for heroic mode. i.e.
    //   - for dungeon in mode 10-heroic,
    //   - for raid in mode 10-Heroic
    //   - for raid in mode 25-heroic
    // DO NOT USE to check raid in mode 25-normal.
    bool IsHeroic() const { return _isHeroic; }

    // return the dungeon or raid difficulty
    Difficulty GetDifficulty() const { return _difficulty; }

    // return true for 25 man or 25 man heroic mode
    bool Is25ManRaid() const { return _difficulty & RAID_DIFFICULTY_MASK_25MAN; }

    template<class T> inline
    const T& DUNGEON_MODE(const T& normal5, const T& heroic10) const
    {
        switch (_difficulty)
        {
            case DUNGEON_DIFFICULTY_NORMAL:
                return normal5;
            case DUNGEON_DIFFICULTY_HEROIC:
                return heroic10;
            default:
                break;
        }

        return heroic10;
    }

    template<class T> inline
    const T& RAID_MODE(const T& normal10, const T& normal25) const
    {
        switch (_difficulty)
        {
            case RAID_DIFFICULTY_10MAN_NORMAL:
                return normal10;
            case RAID_DIFFICULTY_25MAN_NORMAL:
                return normal25;
            default:
                break;
        }

        return normal25;
    }

    template<class T> inline
    const T& RAID_MODE(const T& normal10, const T& normal25, const T& heroic10, const T& heroic25) const
    {
        switch (_difficulty)
        {
            case RAID_DIFFICULTY_10MAN_NORMAL:
                return normal10;
            case RAID_DIFFICULTY_25MAN_NORMAL:
                return normal25;
            case RAID_DIFFICULTY_10MAN_HEROIC:
                return heroic10;
            case RAID_DIFFICULTY_25MAN_HEROIC:
                return heroic25;
            default:
                break;
        }

        return heroic25;
    }

    Player* SelectTargetFromPlayerList(float maxdist, uint32 excludeAura = 0, bool mustBeInLOS = false) const;

private:
    Difficulty _difficulty;
    bool _isHeroic;
    std::unordered_set<uint32> _uniqueTimedEvents;
};

struct HealthCheckEventData
{
    HealthCheckEventData(uint8 healthPct, std::function<void()> exec) : _healthPct(healthPct), _exec(exec) { };

    uint8 _healthPct;
    std::function<void()> _exec;
};

class BossAI : public ScriptedAI
{
public:
    BossAI(Creature* creature, uint32 bossId);
    ~BossAI() override {}

    float callForHelpRange;

    InstanceScript* const instance;

    bool CanRespawn() override;

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override;
    void JustSummoned(Creature* summon) override;
    void SummonedCreatureDespawn(Creature* summon) override;
    void SummonedCreatureDespawnAll() override;

    void UpdateAI(uint32 diff) override;

    void ScheduleHealthCheckEvent(uint32 healthPct, std::function<void()> exec);
    void ScheduleHealthCheckEvent(std::initializer_list<uint8> healthPct, std::function<void()> exec);

    // Hook used to execute events scheduled into EventMap without the need
    // to override UpdateAI
    // note: You must re-schedule the event within this method if the event
    // is supposed to run more than once
    virtual void ExecuteEvent(uint32 /*eventId*/) { }

    virtual void ScheduleTasks() { }

    void Reset() override { _Reset(); }
    void JustEngagedWith(Unit* /*who*/) override { _JustEngagedWith(); }
    void JustDied(Unit* /*killer*/) override { _JustDied(); }
    void JustReachedHome() override { _JustReachedHome(); }

protected:
    void _Reset();
    void _JustEngagedWith();
    void _JustDied();
    void _JustReachedHome() { me->setActive(false); }
    [[nodiscard]] bool _ProccessHealthCheckEvent(uint8 healthPct, uint32 damage, std::function<void()> exec) const;

    void TeleportCheaters();

    SummonList summons;

private:
    uint32 const _bossId;
    std::list<HealthCheckEventData> _healthCheckEvents;
};

class WorldBossAI : public ScriptedAI
{
public:
    WorldBossAI(Creature* creature);
    ~WorldBossAI() override {}

    void JustSummoned(Creature* summon) override;
    void SummonedCreatureDespawn(Creature* summon) override;

    void UpdateAI(uint32 diff) override;

    // Hook used to execute events scheduled into EventMap without the need
    // to override UpdateAI
    // note: You must re-schedule the event within this method if the event
    // is supposed to run more than once
    virtual void ExecuteEvent(uint32 /*eventId*/) { }

    void Reset() override { _Reset(); }
    void JustEngagedWith(Unit* /*who*/) override { _JustEngagedWith(); }
    void JustDied(Unit* /*killer*/) override { _JustDied(); }

protected:
    void _Reset();
    void _JustEngagedWith();
    void _JustDied();

    EventMap events;
    SummonList summons;
};

// SD2 grid searchers.
Creature* GetClosestCreatureWithEntry(WorldObject* source, uint32 entry, float maxSearchRange, bool alive = true);
GameObject* GetClosestGameObjectWithEntry(WorldObject* source, uint32 entry, float maxSearchRange, bool onlySpawned = false);
void GetCreatureListWithEntryInGrid(std::list<Creature*>& list, WorldObject* source, uint32 entry, float maxSearchRange);
void GetGameObjectListWithEntryInGrid(std::list<GameObject*>& list, WorldObject* source, uint32 entry, float maxSearchRange);
void GetDeadCreatureListInGrid(std::list<Creature*>& list, WorldObject* source, float maxSearchRange, bool alive = false);

#endif // SCRIPTEDCREATURE_H_
