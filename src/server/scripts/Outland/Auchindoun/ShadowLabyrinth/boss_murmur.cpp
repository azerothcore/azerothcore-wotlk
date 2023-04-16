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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "shadow_labyrinth.h"

enum Murmur
{
    EMOTE_SONIC_BOOM            = 0,

    SPELL_RESONANCE                 = 33657,
    SPELL_MAGNETIC_PULL             = 33689,
    SPELL_SONIC_SHOCK               = 38797,
    SPELL_THUNDERING_STORM          = 39365,

    SPELL_SONIC_BOOM_CAST_N         = 33923,
    SPELL_SONIC_BOOM_CAST_H         = 38796,
    SPELL_SONIC_BOOM_EFFECT_N       = 38795,
    SPELL_SONIC_BOOM_EFFECT_H       = 33666,
    SPELL_MURMURS_TOUCH_N           = 33711,
    SPELL_MURMURS_TOUCH_H           = 38794
};

struct boss_murmur : public BossAI
{
    boss_murmur(Creature* creature) : BossAI(creature, DATA_MURMUR)
    {
        SetCombatMovement(false);
    }

    void Reset() override
    {
        _Reset();
        me->SetHealth(me->CountPctFromMaxHealth(40));
        me->ResetPlayerDamageReq();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(30s, [this](TaskContext context)
        {
            Talk(EMOTE_SONIC_BOOM);
            DoCastAOE(DUNGEON_MODE(SPELL_SONIC_BOOM_CAST_N, SPELL_SONIC_BOOM_CAST_H));

            scheduler.Schedule(1500ms, [this](TaskContext)
            {
                DoCastAOE(DUNGEON_MODE(SPELL_SONIC_BOOM_EFFECT_N, SPELL_SONIC_BOOM_EFFECT_H), true);
            });

            context.Repeat(28500ms);
        }).Schedule(8s, 20s, [this](TaskContext context)
        {
            DoCastRandomTarget(DUNGEON_MODE(SPELL_MURMURS_TOUCH_N, SPELL_MURMURS_TOUCH_H));
            context.Repeat(25s, 35s);
        }).Schedule(5s, [this](TaskContext context)
        {
            if (!me->IsWithinMeleeRange(me->GetVictim()))
            {
                DoCastVictim(SPELL_RESONANCE);
            }

            context.Repeat(5000ms);
        }).Schedule(15s, 30s, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_MAGNETIC_PULL, 0, 80.0f) == SPELL_CAST_OK)
            {
                context.Repeat(15s, 30s);
            }
            else
            {
                context.Repeat(500ms);
            }
        });

        if (IsHeroic())
        {
            scheduler.Schedule(15s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_THUNDERING_STORM);
                context.Repeat(15s);
            }).Schedule(10s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SONIC_SHOCK);
                context.Repeat(10s, 20s);
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim() || me->HasUnitState(UNIT_STATE_CASTING))
            return;

        scheduler.Update(diff);

        if (!me->isAttackReady())
            return;

        if (!me->IsWithinMeleeRange(me->GetVictim()))
        {
            ThreatContainer::StorageType threatlist = me->GetThreatMgr().GetThreatList();
            for (ThreatContainer::StorageType::const_iterator i = threatlist.begin(); i != threatlist.end(); ++i)
                if (Unit* target = ObjectAccessor::GetUnit(*me, (*i)->getUnitGuid()))
                    if (target->IsAlive() && me->IsWithinMeleeRange(target))
                    {
                        me->TauntApply(target);
                        break;
                    }
        }

        DoMeleeAttackIfReady();
    }
};

class spell_murmur_sonic_boom_effect : public SpellScript
{
    PrepareSpellScript(spell_murmur_sonic_boom_effect)

public:
    spell_murmur_sonic_boom_effect() : SpellScript() { }

    void RecalculateDamage()
    {
        SetHitDamage(GetHitUnit()->CountPctFromMaxHealth(90));
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_murmur_sonic_boom_effect::RecalculateDamage);
    }
};

class spell_murmur_thundering_storm : public SpellScript
{
    PrepareSpellScript(spell_murmur_thundering_storm);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 100.0f, true));
        targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 25.0f, false));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_murmur_thundering_storm::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_boss_murmur()
{
    RegisterShadowLabyrinthCreatureAI(boss_murmur);
    RegisterSpellScript(spell_murmur_sonic_boom_effect);
    RegisterSpellScript(spell_murmur_thundering_storm);
}
