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

#include "Cell.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ScriptedCreature.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Weather.h"
#include "zulaman.h"

enum Spells
{
    SPELL_STATIC_DISRUPTION     = 43622,
    SPELL_STATIC_VISUAL         = 45265,
    SPELL_CALL_LIGHTNING        = 43661, // Missing timer
    SPELL_GUST_OF_WIND          = 43621,
    SPELL_ELECTRICAL_STORM      = 43648,
    SPELL_ELECTRICAL_STORM_AREA = 44007, // Safe within the eye of the storm
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

enum Misc
{
    ACTION_STORM_EXPIRE         = 1,
    GROUP_ELECTRICAL_STORM      = 1,
    GROUP_STATIC_DISRUPTION     = 2
};

constexpr auto NPC_SOARING_EAGLE = 24858;

struct boss_akilzon : public BossAI
{
    boss_akilzon(Creature* creature) : BossAI(creature, DATA_AKILZON), _isRaining(false) { }

    void Reset() override
    {
        _Reset();

        _targetGUID.Clear();
        _cycloneGUID.Clear();
        _isRaining = false;

        SetWeather(WEATHER_STATE_FINE, 0.0f);

        me->m_Events.KillAllEvents(false);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(10s, 20s, GROUP_STATIC_DISRUPTION, [this](TaskContext context)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 1);
            if (!target)
                target = me->GetVictim();
            if (target)
            {
                _targetGUID = target->GetGUID();
                DoCast(target, SPELL_STATIC_DISRUPTION, false);
                me->SetInFront(me->GetVictim());
            }

            context.Repeat(10s, 18s);
        });

        ScheduleTimedEvent(20s, 30s, [&] {
            if (scheduler.GetNextGroupOccurrence(GROUP_ELECTRICAL_STORM) > 5s)
                DoCastRandomTarget(SPELL_GUST_OF_WIND, 1);
        }, 20s, 30s);

        ScheduleTimedEvent(10s, 20s, [&] {
            DoCastVictim(SPELL_CALL_LIGHTNING);
        }, 12s, 17s);

        scheduler.Schedule(1min, GROUP_ELECTRICAL_STORM, [this](TaskContext context)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50, true);
            if (!target)
            {
                EnterEvadeMode();
                return;
            }

            DoCast(target, SPELL_ELECTRICAL_STORM); // storm cyclon + visual
            target->CastSpell(target, SPELL_ELECTRICAL_STORM_AREA, true); // cloud visual

            if (DynamicObject* dynObj = target->GetDynObject(SPELL_ELECTRICAL_STORM_AREA))
                dynObj->SetDuration(8500);

            float x, y, z;
            target->GetPosition(x, y, z);
            target->GetMotionMaster()->MoveJump(x, y, target->GetPositionZ() + 16.0f, 1.0f, 1.0f);

            me->m_Events.AddEventAtOffset([&] {
                HandleStormSequence();
            }, 3s);

            me->m_Events.AddEventAtOffset([&] {
                if (!_isRaining)
                {
                    SetWeather(WEATHER_STATE_HEAVY_RAIN, 0.9999f);
                    _isRaining = true;
                }
            }, Seconds(urand(47, 52)));

            context.Repeat();
        });

        ScheduleTimedEvent(47s, 52s, [&] {
            if (!_isRaining)
            {
                SetWeather(WEATHER_STATE_HEAVY_RAIN, 0.9999f);
                _isRaining = true;
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

    void HandleStormSequence()
    {
        me->m_Events.AddEventAtOffset([&] {
            HandleStormSequence();
        }, 1s);
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == ACTION_STORM_EXPIRE)
        {
            scheduler.DelayGroup(GROUP_STATIC_DISRUPTION, 3s);
            me->m_Events.AddEventAtOffset([&] {
                SummonEagles();
            }, 5s);

            me->InterruptNonMeleeSpells(false);

            SetWeather(WEATHER_STATE_FINE, 0.0f);
            _isRaining = false;
        }
    }

    void SummonEagles()
    {
        Talk(SAY_SUMMON);

        float x, y, z;
        me->GetPosition(x, y, z);

        for (uint8 i = 0; i < 8; ++i)
        {
            Unit* bird = ObjectAccessor::GetUnit(*me, _birdGUIDs[i]);
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
                    _birdGUIDs[i] = creature->GetGUID();
                }
            }
        }
    }

private:
    ObjectGuid _birdGUIDs[8];
    ObjectGuid _targetGUID;
    ObjectGuid _cycloneGUID;
    bool   _isRaining;
};

struct npc_akilzon_eagle : public ScriptedAI
{
    npc_akilzon_eagle(Creature* creature) : ScriptedAI(creature) { }

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

// 43648 - Electrical Storm
class spell_electrial_storm : public AuraScript
{
    PrepareAuraScript(spell_electrial_storm);

    bool Load() override
    {
        return GetCaster() && GetCaster()->IsCreature();
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
            GetCaster()->ToCreature()->AI()->DoAction(ACTION_STORM_EXPIRE);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_electrial_storm::OnRemove, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
    }
};

// 43657 - Electrical Storm
class spell_electrical_storm_proc : public SpellScript
{
    PrepareSpellScript(spell_electrical_storm_proc);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_ELECTRICAL_STORM_AREA));
    }

    void HandleDamageCalc(SpellEffIndex /*effIndex*/)
    {
        if (Aura* aura = GetCaster()->GetAura(SPELL_ELECTRICAL_STORM))
        {
            uint8 multiplier = aura->GetEffect(EFFECT_1)->GetTickNumber();
            SetHitDamage(GetHitDamage() * multiplier);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_electrical_storm_proc::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
        OnEffectHitTarget += SpellEffectFn(spell_electrical_storm_proc::HandleDamageCalc, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void AddSC_boss_akilzon()
{
    RegisterZulAmanCreatureAI(boss_akilzon);
    RegisterZulAmanCreatureAI(npc_akilzon_eagle);
    RegisterSpellScript(spell_electrial_storm);
    RegisterSpellScript(spell_electrical_storm_proc);
}
