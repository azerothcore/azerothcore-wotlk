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

    SPELL_SUPPRESSION               = 33332,
    SPELL_SHOCKWAVE                 = 33686,
    SPELL_SHOCKWAVE_SERVERSIDE      = 33673,
    SPELL_RESONANCE                 = 33657,
    SPELL_MAGNETIC_PULL             = 33689,
    SPELL_SONIC_SHOCK               = 38797,
    SPELL_THUNDERING_STORM          = 39365,
    SPELL_MURMUR_WRATH_AOE          = 33329,
    SPELL_MURMUR_WRATH              = 33331,

    SPELL_SONIC_BOOM_CAST_N         = 33923,
    SPELL_SONIC_BOOM_CAST_H         = 38796,
    SPELL_SONIC_BOOM_EFFECT_N       = 38795,
    SPELL_SONIC_BOOM_EFFECT_H       = 33666,
    SPELL_MURMURS_TOUCH_N           = 33711,
    SPELL_MURMURS_TOUCH_H           = 38794,

    GROUP_RESONANCE                 = 1,
    GROUP_OOC_CAST                  = 2,

    GUID_MURMUR_NPCS                = 1
};

enum Creatures
{
    NPC_CABAL_SPELLBINDER           = 18639
};

struct boss_murmur : public BossAI
{
    boss_murmur(Creature* creature) : BossAI(creature, DATA_MURMUR)
    {
        SetCombatMovement(false);

        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _Reset();
        me->SetHealth(me->CountPctFromMaxHealth(40));
        me->ResetPlayerDamageReq();
        CastSupressionOOC();
    }

    void CastSupressionOOC()
    {
        me->m_Events.CancelEventGroup(GROUP_OOC_CAST);

        me->m_Events.AddEventAtOffset([this] {
            if (me->FindNearestCreature(NPC_CABAL_SPELLBINDER, 35.0f))
            {
                me->CastCustomSpell(SPELL_SUPPRESSION, SPELLVALUE_MAX_TARGETS, 5, (Unit*)nullptr, false);
                CastSupressionOOC();
            }
        }, 3600ms, 10900ms, GROUP_OOC_CAST);
    }

    bool CanAIAttack(Unit const* victim) const override
    {
        return me->IsWithinMeleeRange(victim);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (me->GetThreatMgr().GetThreatList().empty())
        {
            BossAI::EnterEvadeMode(why);
        }
    }

    bool ShouldCastResonance()
    {
        if (Unit* victim = me->GetVictim())
        {
            if (!me->IsWithinMeleeRange(victim))
            {
                return true;
            }

            if (Unit* victimTarget = victim->GetVictim())
            {
                return victimTarget != me;
            }
        }

        return true;
    }

    void SetGUID(ObjectGuid guid, int32 index) override
    {
        if (index == GUID_MURMUR_NPCS)
        {
            if (Creature* creature = ObjectAccessor::GetCreature(*me, guid))
            {
                DoCast(creature, SPELL_MURMUR_WRATH, true);
            }
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        if (!who->IsInCombatWith(me))
        {
            return;
        }

        _JustEngagedWith();

        scheduler.Schedule(28s, [this](TaskContext context)
        {
            Talk(EMOTE_SONIC_BOOM);
            DoCastAOE(DUNGEON_MODE(SPELL_SONIC_BOOM_CAST_N, SPELL_SONIC_BOOM_CAST_H));

            scheduler.Schedule(1500ms, [this](TaskContext)
            {
                DoCastAOE(DUNGEON_MODE(SPELL_SONIC_BOOM_EFFECT_N, SPELL_SONIC_BOOM_EFFECT_H), true);
            });

            context.Repeat(34s, 40s);
        }).Schedule(14600ms, 25500ms, [this](TaskContext context)
        {
            DoCastRandomTarget(DUNGEON_MODE(SPELL_MURMURS_TOUCH_N, SPELL_MURMURS_TOUCH_H));
            context.Repeat(14600ms, 25500ms);
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
        }).Schedule(3s, [this](TaskContext context)
        {
            if (ShouldCastResonance())
            {
                if (!scheduler.IsGroupScheduled(GROUP_RESONANCE))
                {
                    scheduler.Schedule(5s, 5s, GROUP_RESONANCE, [this](TaskContext context)
                    {
                        if (ShouldCastResonance())
                        {
                            DoCastAOE(SPELL_RESONANCE);
                            context.Repeat(6s, 18s);
                        }
                    });
                }
            }

            context.Repeat();
        });

        if (IsHeroic())
        {
            scheduler.Schedule(5s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_THUNDERING_STORM);
                context.Repeat(6050ms, 10s);
            }).Schedule(3650ms, 9150ms, [this](TaskContext context)
            {
                DoCastVictim(SPELL_SONIC_SHOCK);
                context.Repeat(3650ms, 9150ms);
            });
        }

        me->m_Events.CancelEventGroup(GROUP_OOC_CAST);
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

// 33711/38794 - Murmur's Touch
class spell_murmur_touch : public AuraScript
{
    PrepareAuraScript(spell_murmur_touch);

    void HandleAfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
        {
            if (GetTarget())
            {
                GetTarget()->CastSpell(GetTarget(), SPELL_SHOCKWAVE_SERVERSIDE, true);
            }
        }
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_murmur_touch::HandleAfterRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_murmur_sonic_boom_effect : public SpellScript
{
    PrepareSpellScript(spell_murmur_sonic_boom_effect)

public:
    spell_murmur_sonic_boom_effect() : SpellScript() { }

    void RecalculateDamage()
    {
        SetHitDamage(GetHitUnit()->CountPctFromCurHealth(80));
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_murmur_sonic_boom_effect::RecalculateDamage);
    }
};

void AddSC_boss_murmur()
{
    RegisterShadowLabyrinthCreatureAI(boss_murmur);
    RegisterSpellScript(spell_murmur_thundering_storm);
    RegisterSpellScript(spell_murmur_touch);
    RegisterSpellScript(spell_murmur_sonic_boom_effect);
}
