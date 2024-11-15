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

/* ScriptData
SDName: boss_Akilzon
SD%Complete: 75%
SDComment: Missing timer for Call Lightning and Sound ID's
SQLUpdate:
#Temporary fix for Soaring Eagles

EndScriptData */

#include "Cell.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ScriptedCreature.h"
#include "Weather.h"
#include "zulaman.h"

enum Spells
{
    SPELL_STATIC_DISRUPTION     = 43622,
    SPELL_STATIC_VISUAL         = 45265,
    SPELL_CALL_LIGHTNING        = 43661, // Missing timer
    SPELL_GUST_OF_WIND          = 43621,
    SPELL_ELECTRICAL_STORM      = 43648,
    SPELL_BERSERK               = 45078,
    SPELL_ELECTRICAL_OVERLOAD   = 43658,
    SPELL_EAGLE_SWOOP           = 44732,
    SPELL_ZAP                   = 43137,
    SPELL_SAND_STORM            = 25160
};

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_SUMMON                  = 1,
    SAY_INTRO                   = 2, // Not used in script
    SAY_ENRAGE                  = 3,
    SAY_KILL                    = 4,
    SAY_DEATH                   = 5
};

constexpr auto NPC_SOARING_EAGLE = 24858;

class boss_akilzon : public CreatureScript
{
public:
    boss_akilzon() : CreatureScript("boss_akilzon") { }

    struct boss_akilzonAI : public BossAI
    {
        boss_akilzonAI(Creature* creature) : BossAI(creature, DATA_AKILZON) { }

        void Reset() override
        {
            _Reset();

            TargetGUID.Clear();
            CloudGUID.Clear();
            CycloneGUID.Clear();

            StormCount = 0;
            isRaining = false;

            SetWeather(WEATHER_STATE_FINE, 0.0f);

            me->m_Events.KillAllEvents(false);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            ScheduleTimedEvent(10s, 20s, [&]{
                Unit* target = SelectTarget(SelectTargetMethod::Random, 1);
                if (!target)
                    target = me->GetVictim();
                if (target)
                {
                    TargetGUID = target->GetGUID();
                    DoCast(target, SPELL_STATIC_DISRUPTION, false);
                    me->SetInFront(me->GetVictim());
                }
            }, 10s, 18s);

            ScheduleTimedEvent(20s, 30s, [&] {
                Unit* target = SelectTarget(SelectTargetMethod::Random, 1);
                if (!target)
                    target = me->GetVictim();
                if (target)
                    DoCast(target, SPELL_GUST_OF_WIND);
            }, 20s, 30s);

            ScheduleTimedEvent(10s, 20s, [&] {
                DoCastVictim(SPELL_CALL_LIGHTNING);
            }, 12s, 17s);

            ScheduleTimedEvent(1min, [&] {
                Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50, true);
                if (!target)
                {
                    EnterEvadeMode();
                    return;
                }
                target->CastSpell(target, 44007, true); // cloud visual
                DoCast(target, SPELL_ELECTRICAL_STORM, false); // storm cyclon + visual
                float x, y, z;
                target->GetPosition(x, y, z);

                Unit* Cloud = me->SummonTrigger(x, y, me->GetPositionZ() + 16, 0, 15000);
                if (Cloud)
                {
                    target->GetMotionMaster()->MoveJump(Cloud->GetPosition(), 1.0f, 1.0f);

                    CloudGUID = Cloud->GetGUID();
                    Cloud->SetDisableGravity(true);
                    Cloud->StopMoving();
                    Cloud->SetObjectScale(1.0f);
                    Cloud->SetFaction(FACTION_FRIENDLY);
                    Cloud->SetMaxHealth(9999999);
                    Cloud->SetHealth(9999999);
                    Cloud->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

                    me->m_Events.AddEventAtOffset([&, Cloud] {
                        HandleStormSequence(Cloud);
                    }, 3s);
                }

                StormCount = 1;

                me->m_Events.AddEventAtOffset([&] {
                    if (!isRaining)
                    {
                        SetWeather(WEATHER_STATE_HEAVY_RAIN, 0.9999f);
                        isRaining = true;
                    }
                }, Seconds(urand(47, 52)));
            }, 1min);

            ScheduleTimedEvent(47s, 52s, [&] {
                if (!isRaining)
                {
                    SetWeather(WEATHER_STATE_HEAVY_RAIN, 0.9999f);
                    isRaining = true;
                }
            }, 47s, 52s);

            me->m_Events.AddEventAtOffset([&] {
                Talk(SAY_ENRAGE);
                DoCastSelf(SPELL_BERSERK, true);
            }, 10min);

            Talk(SAY_AGGRO);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            _JustDied();
            me->m_Events.KillAllEvents(false);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                Talk(SAY_KILL);
        }

        void SetWeather(uint32 weather, float grade)
        {
            me->GetMap()->SetZoneWeather(me->GetZoneId(), WeatherState(weather), grade);
        }

        void HandleStormSequence(Unit* Cloud) // 1: begin, 2-9: tick, 10: end
        {
            if (!Cloud)
                return;

            if (StormCount < 10 && StormCount > 1)
            {
                // deal damage
                int32 bp0 = 800;
                for (uint8 i = 2; i < StormCount; ++i)
                    bp0 *= 2;

                std::list<Unit*> tempUnitMap;

                Acore::AnyAoETargetUnitInObjectRangeCheck u_check(me, me, SIZE_OF_GRIDS);
                Acore::UnitListSearcher<Acore::AnyAoETargetUnitInObjectRangeCheck> searcher(me, tempUnitMap, u_check);
                Cell::VisitAllObjects(me, searcher, SIZE_OF_GRIDS);

                // deal damage
                for (auto const& target : tempUnitMap)
                {
                    if (target)
                    {
                        if (Cloud && !Cloud->IsWithinDist(target, 6, false))
                            Cloud->CastCustomSpell(target, SPELL_ZAP, &bp0, nullptr, nullptr, true, 0, 0, me->GetGUID());
                    }
                }

                // visual
                float x, y, z;
                z = me->GetPositionZ();
                for (uint8 i = 0; i < 5 + rand() % 5; ++i)
                {
                    x = 343.0f + rand() % 60;
                    y = 1380.0f + rand() % 60;
                    if (Unit* trigger = me->SummonTrigger(x, y, z, 0, 2000))
                    {
                        trigger->SetFaction(FACTION_FRIENDLY);
                        trigger->SetMaxHealth(100000);
                        trigger->SetHealth(100000);
                        trigger->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        if (Cloud)
                            Cloud->CastCustomSpell(trigger, /*43661*/SPELL_ZAP, &bp0, nullptr, nullptr, true, 0, 0, Cloud->GetGUID());
                    }
                }
            }

            ++StormCount;

            if (StormCount > 10)
            {
                StormCount = 0; // finish

                me->m_Events.AddEventAtOffset([&] {
                    SummonEagles();
                }, 5s);

                me->InterruptNonMeleeSpells(false);
                CloudGUID.Clear();
                if (Cloud)
                    Cloud->KillSelf();
                SetWeather(WEATHER_STATE_FINE, 0.0f);
                isRaining = false;
            }

            me->m_Events.AddEventAtOffset([&] {
                Unit* target = ObjectAccessor::GetUnit(*me, CloudGUID);
                if (!target || !target->IsAlive())
                    return;
                else if (Unit* Cyclone = ObjectAccessor::GetUnit(*me, CycloneGUID))
                    Cyclone->CastSpell(target, SPELL_SAND_STORM, true); // keep casting or...
                HandleStormSequence(target);
            }, 1s);
        }

        void SummonEagles()
        {
            Talk(SAY_SUMMON);

            float x, y, z;
            me->GetPosition(x, y, z);

            for (uint8 i = 0; i < 8; ++i)
            {
                Unit* bird = ObjectAccessor::GetUnit(*me, BirdGUIDs[i]);
                if (!bird) //they despawned on die
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        x = target->GetPositionX() + irand(-10, 10);
                        y = target->GetPositionY() + irand(-10, 10);
                        z = target->GetPositionZ() + urand(16, 20);
                        if (z > 95)
                            z = 95.0f - urand(0, 5);
                    }
;
                    if (Creature* creature = me->SummonCreature(NPC_SOARING_EAGLE, x, y, z, 0, TEMPSUMMON_CORPSE_DESPAWN, 0))
                    {
                        creature->AddThreat(me->GetVictim(), 1.0f);
                        creature->AI()->AttackStart(me->GetVictim());
                        BirdGUIDs[i] = creature->GetGUID();
                    }
                }
            }
        }

    private:
        ObjectGuid BirdGUIDs[8];
        ObjectGuid TargetGUID;
        ObjectGuid CycloneGUID;
        ObjectGuid CloudGUID;
        uint8  StormCount;
        bool   isRaining;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulAmanAI<boss_akilzonAI>(creature);
    }
};

class npc_akilzon_eagle : public CreatureScript
{
public:
    npc_akilzon_eagle() : CreatureScript("npc_akilzon_eagle") { }

    struct npc_akilzon_eagleAI : public ScriptedAI
    {
        npc_akilzon_eagleAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 EagleSwoop_Timer;
        bool arrived;
        ObjectGuid TargetGUID;

        void Reset() override
        {
            EagleSwoop_Timer = urand(5000, 10000);
            arrived = true;
            TargetGUID.Clear();
            me->SetDisableGravity(true);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoZoneInCombat();
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }

        void MovementInform(uint32, uint32) override
        {
            arrived = true;
            if (TargetGUID)
            {
                if (Unit* target = ObjectAccessor::GetUnit(*me, TargetGUID))
                    DoCast(target, SPELL_EAGLE_SWOOP, true);
                TargetGUID.Clear();
                me->SetSpeed(MOVE_RUN, 1.2f);
                EagleSwoop_Timer = urand(5000, 10000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (EagleSwoop_Timer <= diff)
                EagleSwoop_Timer = 0;
            else
                EagleSwoop_Timer -= diff;

            if (arrived)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                {
                    float x, y, z;
                    if (EagleSwoop_Timer)
                    {
                        x = target->GetPositionX() + irand(-10, 10);
                        y = target->GetPositionY() + irand(-10, 10);
                        z = target->GetPositionZ() + urand(10, 15);
                        if (z > 95)
                            z = 95.0f - urand(0, 5);
                    }
                    else
                    {
                        target->GetContactPoint(me, x, y, z);
                        z += 2;
                        me->SetSpeed(MOVE_RUN, 5.0f);
                        TargetGUID = target->GetGUID();
                    }
                    me->GetMotionMaster()->MovePoint(0, x, y, z);
                    arrived = false;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulAmanAI<npc_akilzon_eagleAI>(creature);
    }
};

void AddSC_boss_akilzon()
{
    new boss_akilzon();
    new npc_akilzon_eagle();
}
