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
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "steam_vault.h"

enum Texts
{
    SAY_INTRO       = 0,
    SAY_REGEN       = 1,
    SAY_AGGRO       = 2,
    SAY_SLAY        = 3,
    SAY_DEATH       = 4,
    EMOTE_DISTILLER = 5
};

enum Spells
{
    SPELL_SPELL_REFLECTION        = 31534,
    SPELL_IMPALE                  = 39061,
    SPELL_HEAD_CRACK              = 16172,
    SPELL_WARLORDS_RAGE           = 37081,
    SPELL_WARLORDS_RAGE_DISTILLER = 31543,
    SPELL_WARLORDS_RAGE_PROC      = 36453
};

enum Misc
{
    POINT_DISTILLER = 1
};

struct boss_warlord_kalithresh : public BossAI
{
    boss_warlord_kalithresh(Creature* creature) : BossAI(creature, DATA_WARLORD_KALITHRESH), _introDone(false) { }

    void Reset() override
    {
        _Reset();
        instance->DoForAllMinions(DATA_WARLORD_KALITHRESH, [&](Creature* minion) {
            minion->SetReactState(REACT_PASSIVE);
            minion->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_introDone && who->IsPlayer() && me->IsWithinDistInMap(who, 35.0f))
        {
            Talk(SAY_INTRO);
            _introDone = true;
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        _JustEngagedWith();

        scheduler.Schedule(20s, 36s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_SPELL_REFLECTION);
            context.Repeat();
        }).Schedule(7s, 14s, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_IMPALE, 0, 10.0f);
            context.Repeat(7500ms, 12500ms);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_HEAD_CRACK);
            context.Repeat(45s, 55s);
        }).Schedule(20s, [this](TaskContext context)
        {
            Talk(SAY_REGEN);
            Talk(EMOTE_DISTILLER);

            if (Creature* distiller = me->FindNearestCreature(NPC_NAGA_DISTILLER, 8.0f))
            {
                distiller->AI()->DoCast(me, SPELL_WARLORDS_RAGE_DISTILLER, true);
                distiller->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            }
            else
            {
                if (Creature* distiller = me->FindNearestCreature(NPC_NAGA_DISTILLER, 100.0f))
                {
                    me->GetMotionMaster()->MoveFollow(distiller, 8.0f, 0.0f);

                    scheduler.Schedule(1s, [this](TaskContext chaseContext)
                    {
                        if (Creature* distiller = me->FindNearestCreature(NPC_NAGA_DISTILLER, 8.0f))
                        {
                            distiller->AI()->DoCast(me, SPELL_WARLORDS_RAGE_DISTILLER, true);
                            distiller->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                            me->ResumeChasingVictim();
                        }
                        else
                        {
                            chaseContext.Repeat();
                        }
                    });
                }
            }

            context.Repeat(45s);
        });
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
        instance->DoForAllMinions(DATA_WARLORD_KALITHRESH, [&](Creature* minion) {
            minion->KillSelf();
        });
    }

private:
    bool _introDone;
};

// 31543 - Warlord's Rage
class spell_warlords_rage : public AuraScript
{
    PrepareAuraScript(spell_warlords_rage);

    void HandleAfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
        {
            if (GetTarget())
            {
                GetTarget()->CastSpell(GetTarget(), SPELL_WARLORDS_RAGE_PROC, true);
            }
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_warlords_rage::HandleAfterRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

void AddSC_boss_warlord_kalithresh()
{
    RegisterSteamvaultCreatureAI(boss_warlord_kalithresh);
    RegisterSpellScript(spell_warlords_rage);
}
