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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "halls_of_lightning.h"

enum LokenSpells
{
    SPELL_ARC_LIGHTNING             = 52921,
    SPELL_LIGHTNING_NOVA            = 52960,
    SPELL_LIGHTNING_NOVA_VISUAL     = 56502,
    SPELL_LIGHTNING_NOVA_THUNDERS   = 52663,

    SPELL_PULSING_SHOCKWAVE         = 52961,

    // Achievement
    ACHIEVEMENT_TIMELY_DEATH        = 20384
};

enum Yells
{
    SAY_INTRO_1                     = 0,
    SAY_INTRO_2                     = 1,
    SAY_AGGRO                       = 2,
    SAY_NOVA                        = 3,
    SAY_SLAY                        = 4,
    SAY_75HEALTH                    = 5,
    SAY_50HEALTH                    = 6,
    SAY_25HEALTH                    = 7,
    SAY_DEATH                       = 8,
    EMOTE_NOVA                      = 9
};

enum LokenEvents
{
    EVENT_LIGHTNING_NOVA            = 1,
    EVENT_SHOCKWAVE                 = 2,
    EVENT_ARC_LIGHTNING             = 3,
    EVENT_CHECK_HEALTH              = 4,
    EVENT_AURA_REMOVE               = 5
};

struct boss_loken : public BossAI
{
    boss_loken(Creature* creature) : BossAI(creature, DATA_LOKEN), _introDone(false) { }

    void Reset() override
    {
        _Reset();
        instance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMELY_DEATH);

        me->RemoveAllAuras();

        ScheduleHealthCheckEvent(75, [&] {
            Talk(SAY_75HEALTH);
        });

        ScheduleHealthCheckEvent(50, [&] {
            Talk(SAY_50HEALTH);
        });

        ScheduleHealthCheckEvent(25, [&] {
            Talk(SAY_25HEALTH);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        BossAI::MoveInLineOfSight(who);

        if (_introDone || !who->IsPlayer() || !me->IsWithinDistInMap(who, 40.0f))
            return;

        Talk(SAY_INTRO_1);
        Talk(SAY_INTRO_2, 10s);
        _introDone = true;
    }

    void JustEngagedWith(Unit*) override
    {
        me->m_Events.KillAllEvents(false);
        _JustEngagedWith();
        Talk(SAY_AGGRO);

        events.ScheduleEvent(EVENT_ARC_LIGHTNING, 10s);
        events.ScheduleEvent(EVENT_SHOCKWAVE, 3s);
        events.ScheduleEvent(EVENT_LIGHTNING_NOVA, 15s);

        if (IsHeroic())
            instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMELY_DEATH);
    }

    void JustDied(Unit*) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer())
            return;

        Talk(SAY_SLAY);
    }

    void UpdateAI(uint32 diff) override
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
            case EVENT_LIGHTNING_NOVA:
                Talk(SAY_NOVA);
                events.Repeat(15s);
                me->CastSpell(me, SPELL_LIGHTNING_NOVA_VISUAL, true);
                me->CastSpell(me, SPELL_LIGHTNING_NOVA_THUNDERS, true);

                events.DelayEvents(5s);
                events.ScheduleEvent(EVENT_AURA_REMOVE, me->GetMap()->IsHeroic() ? 4s : 5s);

                me->CastSpell(me, SPELL_LIGHTNING_NOVA, false);
                break;
            case EVENT_SHOCKWAVE:
                me->CastSpell(me, SPELL_PULSING_SHOCKWAVE, false);
                break;
            case EVENT_ARC_LIGHTNING:
                if (Unit* target = SelectTargetFromPlayerList(100, SPELL_ARC_LIGHTNING))
                    me->CastSpell(target, SPELL_ARC_LIGHTNING, false);

                events.Repeat(12s);
                break;
            case EVENT_AURA_REMOVE:
                me->RemoveAura(SPELL_LIGHTNING_NOVA_THUNDERS);
                break;
        }

        DoMeleeAttackIfReady();
    }
    private:
        bool _introDone;
};

class spell_loken_pulsing_shockwave : public SpellScript
{
    PrepareSpellScript(spell_loken_pulsing_shockwave);

    void CalculateDamage(SpellEffIndex /*effIndex*/)
    {
        if (!GetHitUnit())
            return;

        float distance = GetCaster()->GetDistance2d(GetHitUnit());
        if (distance > 1.0f)
            SetHitDamage(int32(GetHitDamage() * distance));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_loken_pulsing_shockwave::CalculateDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void AddSC_boss_loken()
{
    RegisterHallOfLightningCreatureAI(boss_loken);
    RegisterSpellScript(spell_loken_pulsing_shockwave);
}
