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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_VANISH            = 24699,
    SPELL_AMBUSH            = 24337,
    SPELL_GOUGE             = 24698,
    SPELL_THOUSAND_BLADES   = 24649,
    SPELL_THRASH            = 3417,
    SPELL_ENRAGE            = 8269
};

enum Events
{
    EVENT_VANISH            = 1,
    EVENT_AMBUSH            = 2,
    EVENT_GOUGE             = 3,
    EVENT_THOUSAND_BLADES   = 4
};

class boss_renataki : public CreatureScript
{
public:
    boss_renataki() : CreatureScript("boss_renataki") { }

    struct boss_renatakiAI : public BossAI
    {
        boss_renatakiAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

        void Reset() override
        {
            _Reset();
            me->SetReactState(REACT_AGGRESSIVE);
            _enraged = false;
            _thousandBladesCount = urand(2, 5);
            _thousandBladesTargets.clear();
            _dynamicFlags = me->GetDynamicFlags();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_VANISH, 23s, 25s);
            events.ScheduleEvent(EVENT_GOUGE, 5s, 10s);
            events.ScheduleEvent(EVENT_THOUSAND_BLADES, 15s, 20s);

            DoCastSelf(SPELL_THRASH, true);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (!_enraged && HealthBelowPct(30))
            {
                me->TextEmote("%s becomes enraged", me, false);
                DoCast(me, SPELL_ENRAGE);
                _enraged = true;
            }
        }

        bool CanAIAttack(Unit const* target) const override
        {
            if (me->GetThreatMgr().GetThreatListSize() > 1)
            {
                ThreatContainer::StorageType::const_iterator lastRef = me->GetThreatMgr().GetOnlineContainer().GetThreatList().end();
                --lastRef;
                if (Unit* lastTarget = (*lastRef)->getTarget())
                {
                    if (lastTarget != target)
                    {
                        return !target->HasAura(SPELL_GOUGE);
                    }
                }
            }

            return true;
        }

        bool CanBeSeen(Player const* /*player*/) override
        {
            return me->GetReactState() == REACT_AGGRESSIVE;
        }

        bool CanSeeAlways(WorldObject const* obj) override
        {
            if (me->GetReactState() == REACT_PASSIVE)
            {
                return obj->ToCreature() && obj->ToCreature()->IsPet();
            }

            return false;
        }

        bool CanAlwaysBeDetectable(WorldObject const* seer) override
        {
            if (me->GetReactState() == REACT_PASSIVE)
            {
                return seer->ToCreature() && seer->ToCreature()->IsPet();
            }

            return false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_VANISH:
                        me->SetReactState(REACT_PASSIVE);
                        _dynamicFlags = me->GetDynamicFlags();
                        me->RemoveDynamicFlag(UNIT_DYNFLAG_TRACK_UNIT);
                        DoCastSelf(SPELL_VANISH);
                        events.DelayEvents(5s);
                        events.ScheduleEvent(EVENT_AMBUSH, 5s);
                        events.ScheduleEvent(EVENT_VANISH, 38s, 45s);
                        return;
                    case EVENT_AMBUSH:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, false, false))
                        {
                            me->NearTeleportTo(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), me->GetOrientation());
                            DoCast(target, SPELL_AMBUSH, true);
                        }
                        me->SetDynamicFlag(_dynamicFlags);
                        me->RemoveAurasDueToSpell(SPELL_VANISH);
                        me->SetReactState(REACT_AGGRESSIVE);
                        break;
                    case EVENT_GOUGE:
                        DoCastAOE(SPELL_GOUGE);
                        events.ScheduleEvent(EVENT_GOUGE, 10s, 15s);
                        return;
                    case EVENT_THOUSAND_BLADES:
                    {
                        if (_thousandBladesTargets.empty())
                        {
                            std::vector<Unit*> targetList;
                            ThreatContainer::StorageType const& threatlist = me->GetThreatMgr().GetThreatList();
                            for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
                            {
                                if (Unit* target = (*itr)->getTarget())
                                {
                                    if (target->IsAlive() && target->IsWithinDist2d(me, 100.f))
                                    {
                                        targetList.push_back(target);
                                    }
                                }
                            }

                            if (!targetList.empty())
                            {
                                Acore::Containers::RandomShuffle(targetList);

                                // First get ranged targets
                                for (Unit* target : targetList)
                                {
                                    if (!target->IsWithinMeleeRange(me))
                                    {
                                        _thousandBladesTargets.push_back(target->GetGUID());
                                    }
                                }

                                if (_thousandBladesTargets.size() < _thousandBladesCount)
                                {
                                    // if still not enough, get melee targets
                                    for (Unit* target : targetList)
                                    {
                                        if (target->IsWithinMeleeRange(me))
                                        {
                                            _thousandBladesTargets.push_back(target->GetGUID());
                                        }
                                    }
                                }

                                if (!_thousandBladesTargets.empty())
                                {
                                    Acore::Containers::RandomResize(_thousandBladesTargets, _thousandBladesCount);
                                }
                            }
                        }

                        if (!_thousandBladesTargets.empty())
                        {
                            GuidVector::iterator itr = _thousandBladesTargets.begin();
                            std::advance(itr, urand(0, _thousandBladesTargets.size() - 1));

                            if (Unit* target = ObjectAccessor::GetUnit(*me, *itr))
                            {
                                DoCast(target, SPELL_THOUSAND_BLADES);
                            }

                            if (_thousandBladesTargets.erase(itr) != _thousandBladesTargets.end())
                            {
                                events.ScheduleEvent(EVENT_THOUSAND_BLADES, 500ms);
                            }
                            else
                            {
                                _thousandBladesCount = urand(2, 5);
                                events.ScheduleEvent(EVENT_THOUSAND_BLADES, 15s, 22s);
                            }
                        }
                        else
                        {
                            _thousandBladesCount = urand(2, 5);
                            events.ScheduleEvent(EVENT_THOUSAND_BLADES, 15s, 22s);
                        }
                        break;
                    }
                    default:
                        break;
                }
            }

            if (me->GetReactState() == REACT_AGGRESSIVE)
                DoMeleeAttackIfReady();
        }

    private:
        bool _enraged;
        uint32 _dynamicFlags;
        uint8 _thousandBladesCount;
        GuidVector _thousandBladesTargets;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_renatakiAI>(creature);
    }
};

void AddSC_boss_renataki()
{
    new boss_renataki();
}
