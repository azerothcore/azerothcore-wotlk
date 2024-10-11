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
#include "SpellInfo.h"
#include "SpellScriptLoader.h"
#include "shadow_labyrinth.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_SUPPRESSION               = 33332,
    SPELL_SHOCKWAVE                 = 33686,
    SPELL_SHOCKWAVE_SERVERSIDE      = 33673,
    SPELL_RESONANCE                 = 33657,
    SPELL_MAGNETIC_PULL             = 33689,
    SPELL_SONIC_SHOCK               = 38797,
    SPELL_THUNDERING_STORM          = 39365,
    SPELL_MURMUR_WRATH_AOE          = 33329,
    SPELL_MURMUR_WRATH              = 33331,

    SPELL_SONIC_BOOM_CAST           = 33923,
    SPELL_SONIC_BOOM_EFFECT         = 38795,
    SPELL_MURMURS_TOUCH             = 33711
};

enum Misc
{
    EMOTE_SONIC_BOOM                = 0,

    GROUP_RESONANCE                 = 1,
    GROUP_OOC_CAST                  = 2,

    GUID_MURMUR_NPCS                = 1
};

enum Npc
{
    NPC_CABAL_SPELLBINDER           = 18639
};

struct boss_murmur : public BossAI
{
    boss_murmur(Creature* creature) : BossAI(creature, DATA_MURMUR)
    {
        me->SetCombatMovement(false);
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
        // Boss engages mobs during roleplay, this checks prevents it from setting the zone in combat before players engage it.
        if (who->IsPlayer() || who->IsPet() || who->IsGuardian())
        {
            _JustEngagedWith();
        }

        scheduler.Schedule(28s, [this](TaskContext context)
        {
            Talk(EMOTE_SONIC_BOOM);
            DoCastAOE(SPELL_SONIC_BOOM_CAST);

            scheduler.Schedule(1500ms, [this](TaskContext)
            {
                DoCastAOE(SPELL_SONIC_BOOM_EFFECT, true);
            });

            context.Repeat(34s, 40s);
        }).Schedule(14600ms, 25500ms, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_MURMURS_TOUCH);
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

// 33686 - Shockwave (Murmur's Touch final explosion)
class spell_shockwave_knockback : public SpellScript
{
    PrepareSpellScript(spell_shockwave_knockback);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHOCKWAVE_SERVERSIDE });
    }

    void HandleOnHit()
    {
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_SHOCKWAVE_SERVERSIDE, true);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_shockwave_knockback::HandleOnHit);
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
    RegisterSpellScript(spell_shockwave_knockback);
    RegisterSpellScript(spell_murmur_sonic_boom_effect);
}
