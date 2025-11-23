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
    SPELL_PULSING_SHOCKWAVE_AURA    = 59414,

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

    void OnAuraRemove(AuraApplication* auraApp, AuraRemoveMode /*mode*/) override
    {
        if (auraApp->GetBase()->GetId() == SPELL_LIGHTNING_NOVA_VISUAL)
        {
            me->RemoveAura(SPELL_LIGHTNING_NOVA_THUNDERS);
            me->ClearUnitState(UNIT_STATE_CASTING);
            me->ResumeChasingVictim();
        }
    }

    void ScheduleTasks() override
    {
        me->m_Events.AddEventAtOffset([&] {
            DoCastAOE(SPELL_PULSING_SHOCKWAVE_AURA, true);
            me->ClearUnitState(UNIT_STATE_CASTING); // the aura above is a channeled spell, so we need this
            DoCastSelf(SPELL_PULSING_SHOCKWAVE);
        }, 3s);

        ScheduleTimedEvent(15s, [&] {
            Talk(SAY_NOVA);
            Talk(EMOTE_NOVA);
            DoCastSelf(SPELL_LIGHTNING_NOVA_VISUAL, true);
            DoCastSelf(SPELL_LIGHTNING_NOVA_THUNDERS, true);
            DoCastAOE(SPELL_LIGHTNING_NOVA);
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
        }, 15s);

        if (IsHeroic())
        {
            ScheduleTimedEvent(10s, [&] {
                DoCastRandomTarget(SPELL_ARC_LIGHTNING, 0, 100.0f, false);
            }, 12s);

            instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMELY_DEATH);
        }
    }

    void JustEngagedWith(Unit*) override
    {
        me->m_Events.KillAllEvents(false);
        _JustEngagedWith();
        Talk(SAY_AGGRO);
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
