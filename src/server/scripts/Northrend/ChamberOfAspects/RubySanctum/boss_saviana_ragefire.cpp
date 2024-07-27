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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "ruby_sanctum.h"
#include "SpellScript.h"

enum Texts
{
    SAY_AGGRO                   = 0,
    SAY_CONFLAGRATION           = 1,
    EMOTE_ENRAGED               = 2,
    SAY_KILL                    = 3
};

enum Spells
{
    SPELL_CONFLAGRATION         = 74452,
    SPELL_FLAME_BEACON          = 74453,
    SPELL_CONFLAGRATION_MISSLE  = 74454,
    SPELL_ENRAGE                = 78722,
    SPELL_FLAME_BREATH          = 74403,
};

enum Events
{
    EVENT_ENRAGE                = 1,
    EVENT_FLIGHT                = 2,
    EVENT_FLAME_BREATH          = 3,
    EVENT_CONFLAGRATION         = 4,
    EVENT_LAND_GROUND           = 5,
    EVENT_AIR_MOVEMENT          = 6,
    EVENT_LAND_BACK             = 7,
    EVENT_KILL_TALK             = 8
};

enum Misc
{
    POINT_FLIGHT                = 1,
    POINT_LAND                  = 2,
    POINT_TAKEOFF               = 3,

    SOUND_ID_DEATH              = 17531
};

class boss_saviana_ragefire : public CreatureScript
{
public:
    boss_saviana_ragefire() : CreatureScript("boss_saviana_ragefire") { }

    struct boss_saviana_ragefireAI : public BossAI
    {
        boss_saviana_ragefireAI(Creature* creature) : BossAI(creature, DATA_SAVIANA_RAGEFIRE)
        {
        }

        void Reset() override
        {
            BossAI::Reset();
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_ENRAGE, 15s);
            events.ScheduleEvent(EVENT_FLAME_BREATH, 10s);
            events.ScheduleEvent(EVENT_FLIGHT, 30s);
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            me->PlayDirectSound(SOUND_ID_DEATH);
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
                return;

            switch (point)
            {
                case POINT_FLIGHT:
                    me->SetFacingTo(4.69f);
                    events.ScheduleEvent(EVENT_CONFLAGRATION, 1s);
                    events.ScheduleEvent(EVENT_LAND_BACK, 7s);
                    Talk(SAY_CONFLAGRATION);
                    break;
                case POINT_LAND:
                    me->SetDisableGravity(false);
                    events.ScheduleEvent(EVENT_LAND_GROUND, 500ms);
                    break;
            }
        }

        void JustReachedHome() override
        {
            BossAI::JustReachedHome();
            me->SetDisableGravity(false);
            me->SetHover(false);
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_FLIGHT:
                    {
                        me->SetReactState(REACT_PASSIVE);
                        me->AttackStop();
                        me->SetDisableGravity(true);
                        me->GetMotionMaster()->MovePoint(POINT_TAKEOFF, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 6.0f, false);
                        events.ScheduleEvent(EVENT_FLIGHT, 50s);
                        events.DelayEvents(15s);
                        events.ScheduleEvent(EVENT_AIR_MOVEMENT, 2s);
                        break;
                    }
                case EVENT_CONFLAGRATION:
                    me->CastCustomSpell(SPELL_CONFLAGRATION, SPELLVALUE_MAX_TARGETS, RAID_MODE(3, 6, 3, 6), me, true);
                    break;
                case EVENT_ENRAGE:
                    me->CastSpell(me, SPELL_ENRAGE, false);
                    Talk(EMOTE_ENRAGED);
                    events.ScheduleEvent(EVENT_ENRAGE, 15s, 20s);
                    break;
                case EVENT_FLAME_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_FLAME_BREATH, false);
                    events.ScheduleEvent(EVENT_FLAME_BREATH, 20s, 30s);
                    break;
                case EVENT_AIR_MOVEMENT:
                    me->GetMotionMaster()->MovePoint(POINT_FLIGHT, 3155.51f, 683.844f, 95.0f, false);
                    break;
                case EVENT_LAND_BACK:
                    me->GetMotionMaster()->MovePoint(POINT_LAND, 3151.07f, 636.443f, 80.0f, false);
                    break;
                case EVENT_LAND_GROUND:
                    me->SetReactState(REACT_AGGRESSIVE);
                    if (me->GetVictim())
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRubySanctumAI<boss_saviana_ragefireAI>(creature);
    }
};

class spell_saviana_conflagration_init : public SpellScript
{
    PrepareSpellScript(spell_saviana_conflagration_init);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLAME_BEACON, SPELL_CONFLAGRATION_MISSLE });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->CastSpell(GetHitUnit(), SPELL_FLAME_BEACON, true);
        GetCaster()->CastSpell(GetHitUnit(), SPELL_CONFLAGRATION_MISSLE, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_saviana_conflagration_init::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_saviana_conflagration_throwback : public SpellScript
{
    PrepareSpellScript(spell_saviana_conflagration_throwback);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetHitUnit()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_saviana_conflagration_throwback::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_saviana_ragefire()
{
    new boss_saviana_ragefire();
    RegisterSpellScript(spell_saviana_conflagration_init);
    RegisterSpellScript(spell_saviana_conflagration_throwback);
}

