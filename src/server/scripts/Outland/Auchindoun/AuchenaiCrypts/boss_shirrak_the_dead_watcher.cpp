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
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "auchenai_crypts.h"

enum Spells
{
    SPELL_INHIBIT_MAGIC         = 32264,
    SPELL_ATTRACT_MAGIC         = 32265,
    SPELL_CARNIVOROUS_BITE      = 36383,
    SPELL_FIERY_BLAST           = 32302,
    SPELL_FOCUS_FIRE_VISUAL     = 32286,
    SPELL_FOCUS_CAST            = 32300,

    SPELL_POSSESS_INSTANT       = 32830,
    SPELL_POSSESS_CHANNELED     = 33401
};

enum Misc
{
    ENTRY_FOCUS_FIRE            = 18374,
    EMOTE_FOCUSED               = 0
};

struct boss_shirrak_the_dead_watcher : public BossAI
{
    boss_shirrak_the_dead_watcher(Creature* creature) : BossAI(creature, DATA_SHIRRAK_THE_DEAD_WATCHER)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    ObjectGuid focusGUID;

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetControlled(false, UNIT_STATE_ROOT);
        CreatureAI::EnterEvadeMode(why);
    }

    void Reset() override
    {
        _Reset();
        focusGUID.Clear();
        me->SetControlled(false, UNIT_STATE_ROOT);
    }

    void JustEngagedWith(Unit*) override
    {
        _JustEngagedWith();
        scheduler.Schedule(1ms, [this] (TaskContext context)
        {
            Map::PlayerList const& PlayerList = me->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (Player* player = i->GetSource())
                {
                    float dist = me->GetDistance(player);
                    if (player->IsAlive() && dist < 45.0f)
                    {
                        Aura* aura = player->GetAura(SPELL_INHIBIT_MAGIC);
                        if (!aura)
                        {
                            aura = me->AddAura(SPELL_INHIBIT_MAGIC, player);
                        }
                        else
                        {
                            aura->RefreshDuration();
                        }

                        if (aura)
                        {
                            aura->SetStackAmount(getStackCount(dist));
                        }
                    }
                    else
                    {
                        player->RemoveAurasDueToSpell(SPELL_INHIBIT_MAGIC);
                    }
                }
            }
            context.Repeat(3s);
        }).Schedule(28s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_ATTRACT_MAGIC);
            context.Repeat(30s);
            scheduler.Schedule(1500ms, [this](TaskContext context)
            {
                DoCastSelf(SPELL_CARNIVOROUS_BITE);
                context.Repeat(10s);
            });
        }).Schedule(10s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_CARNIVOROUS_BITE);
            context.Repeat(10s);
        }).Schedule(17s, [this](TaskContext context)
        {
            //npcbot
            /*
            //end npcbot
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 60.0f, true))
            //npcbot
            */
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 60.0f))
            //end npcbot
            {
                if (Creature* cr = me->SummonCreature(ENTRY_FOCUS_FIRE, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 7000))
                {
                    focusGUID = cr->GetGUID();
                }
                Talk(EMOTE_FOCUSED, target);
            }
            context.Repeat(15s, 20s);
            scheduler.Schedule(3s, [this](TaskContext /*context*/)
            {
                if (Unit* flare = ObjectAccessor::GetCreature(*me, focusGUID))
                {
                    me->CastSpell(flare, SPELL_FOCUS_CAST, true);
                }
            }).Schedule(3500ms, [this](TaskContext /*context*/)
            {
                if (Unit* flare = ObjectAccessor::GetCreature(*me, focusGUID))
                {
                    me->CastSpell(flare, SPELL_FOCUS_CAST, true);
                }
            }).Schedule(4s, [this](TaskContext /*context*/)
            {
                if (Unit* flare = ObjectAccessor::GetCreature(*me, focusGUID))
                {
                    me->CastSpell(flare, SPELL_FOCUS_CAST, true);
                }
            }).Schedule(5s, [this](TaskContext /*context*/)
            {
                me->SetControlled(false, UNIT_STATE_ROOT);
            });
            me->SetControlled(true, UNIT_STATE_ROOT);
        });
    }

    void JustSummoned(Creature* summon) override
    {
        summon->CastSpell(summon, SPELL_FOCUS_FIRE_VISUAL, true);
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_FOCUS_CAST)
        {
            target->CastSpell(target, SPELL_FIERY_BLAST, false);
        }
    }

    uint8 getStackCount(float dist)
    {
        if (dist < 15)
            return 4;
        if (dist < 25)
            return 3;
        if (dist < 35)
            return 2;
        return 1;
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

class spell_auchenai_possess : public AuraScript
{
    PrepareAuraScript(spell_auchenai_possess);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
        {
            return;
        }

        if (Unit* caster = GetCaster())
        {
            if (Unit* target = GetTarget())
            {
                caster->CastSpell(target, SPELL_POSSESS_INSTANT, true);
            }
        }
    }

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = 2000;
    }

    void Update(AuraEffect* /*effect*/)
    {
        if (Unit* owner = GetUnitOwner())
        {
            if (owner->GetHealthPct() <= 50)
            {
                SetDuration(0);
            }
        }
    }

    void Register() override
    {
        if (m_scriptSpellId == SPELL_POSSESS_CHANNELED)
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_auchenai_possess::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        }
        else
        {
            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_auchenai_possess::CalcPeriodic, EFFECT_0, SPELL_AURA_MOD_CHARM);
            OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_auchenai_possess::Update, EFFECT_0, SPELL_AURA_MOD_CHARM);
        }
    }
};

void AddSC_boss_shirrak_the_dead_watcher()
{
    RegisterAuchenaiCryptsCreatureAI(boss_shirrak_the_dead_watcher);
    RegisterSpellScript(spell_auchenai_possess);
}

