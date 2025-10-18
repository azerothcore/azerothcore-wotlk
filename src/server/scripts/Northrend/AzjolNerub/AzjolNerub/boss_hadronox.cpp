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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "azjol_nerub.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_SUMMON_ANUBAR_CHAMPION            = 53064,
    SPELL_SUMMON_ANUBAR_CRYPT_FIEND         = 53065,
    SPELL_SUMMON_ANUBAR_NECROMANCER         = 53066,
    SPELL_WEB_FRONT_DOORS                   = 53177,
    SPELL_WEB_SIDE_DOORS                    = 53185,
    SPELL_ACID_CLOUD                        = 53400,
    SPELL_LEECH_POISON                      = 53030,
    SPELL_LEECH_POISON_HEAL                 = 53800,
    SPELL_WEB_GRAB                          = 57731,
    SPELL_PIERCE_ARMOR                      = 53418,

    SPELL_SMASH                             = 53318,
    SPELL_FRENZY                            = 53801
};

enum Misc
{
    NPC_ANUB_AR_CRUSHER         = 28922,

    SAY_CRUSHER_AGGRO           = 0,
    SAY_CRUSHER_EMOTE           = 1,
    SAY_HADRONOX_EMOTE          = 0,

    ACTION_DESPAWN_ADDS         = 1,
    ACTION_START_EVENT          = 2
};

const Position hadronoxSteps[4] =
{
    {607.9f, 512.8f, 695.3f, 0.0f},
    {611.67f, 564.11f, 720.0f, 0.0f},
    {576.1f, 580.0f, 727.5f, 0.0f},
    {534.87f, 554.0f, 733.0f, 0.0f}
};

struct boss_hadronox : public BossAI
{
    explicit boss_hadronox(Creature* creature) : BossAI(creature, DATA_HADRONOX)
    {
    }

    void Reset() override
    {
        summons.DoAction(ACTION_DESPAWN_ADDS);
        BossAI::Reset();
        me->SummonCreature(NPC_ANUB_AR_CRUSHER, 542.9f, 519.5f, 741.24f, 2.14f);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_START_EVENT)
        {
            instance->SetBossState(DATA_HADRONOX, IN_PROGRESS);
            me->setActive(true);

            scheduler.Schedule(20s, [this](TaskContext const& /*context*/)
            {
                Talk(SAY_HADRONOX_EMOTE);
                me->GetMotionMaster()->MoveCharge(hadronoxSteps[0].GetPositionX(), hadronoxSteps[0].GetPositionY(), hadronoxSteps[0].GetPositionZ(), 10.0f, 0, nullptr, true);
            }).Schedule(40s, [this](TaskContext const& /*context*/)
            {
                Talk(SAY_HADRONOX_EMOTE);
                me->GetMotionMaster()->MoveCharge(hadronoxSteps[1].GetPositionX(), hadronoxSteps[1].GetPositionY(), hadronoxSteps[1].GetPositionZ(), 10.0f, 0, nullptr, true);
            }).Schedule(60s, [this](TaskContext const& /*context*/)
            {
                Talk(SAY_HADRONOX_EMOTE);
                me->GetMotionMaster()->MoveCharge(hadronoxSteps[2].GetPositionX(), hadronoxSteps[2].GetPositionY(), hadronoxSteps[2].GetPositionZ(), 10.0f, 0, nullptr, true);
            }).Schedule(80s, [this](TaskContext const& /*context*/)
            {
                Talk(SAY_HADRONOX_EMOTE);
                me->GetMotionMaster()->MoveCharge(hadronoxSteps[3].GetPositionX(), hadronoxSteps[3].GetPositionY(), hadronoxSteps[3].GetPositionZ(), 10.0f, 0, nullptr, true);
                DoCastAOE(SPELL_WEB_FRONT_DOORS, true);
            });
        }
    }

    uint32 GetData(uint32 data) const override
    {
        if (data == me->GetEntry())
            return !me->isActiveObject() ? 1 : 0;
        return 0;
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);

        // Xinef: cannot use pathfinding...
        if (summon->GetDistance(477.0f, 618.0f, 771.0f) < 5.0f)
            summon->GetMotionMaster()->MovePath(3000012, false);
        else if (summon->GetDistance(583.0f, 617.0f, 771.0f) < 5.0f)
            summon->GetMotionMaster()->MovePath(3000013, false);
        else if (summon->GetDistance(581.0f, 608.5f, 739.0f) < 5.0f)
            summon->GetMotionMaster()->MovePath(3000014, false);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!me->IsAlive() || !victim->HasAura(SPELL_LEECH_POISON))
            return;

        me->ModifyHealth(int32(me->CountPctFromMaxHealth(10)));
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
    }

    void JustEngagedWith(Unit*) override
    {
        scheduler.Schedule(10s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, false))
                DoCast(target, SPELL_ACID_CLOUD);
            context.Repeat(25s);
        }).Schedule(4s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_LEECH_POISON);
            context.Repeat(12s);
        }).Schedule(1s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_PIERCE_ARMOR);
            context.Repeat(8s);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_WEB_GRAB);
            context.Repeat();
        });
    }

    bool AnyPlayerValid() const
    {
        Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
        for (auto const& itr : playerList)
        {
            if (Player* player = itr.GetSource())
            {
                if (!player->IsAlive() || player->IsGameMaster())
                    continue;

                if (me->GetDistance(player) < 130.0f && me->CanCreatureAttack(player))
                    return true;
            }
        }

        return false;
    }

    void DamageTaken(Unit* who, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*damageSchoolMask*/) override
    {
        if ((!who || !who->IsControlledByPlayer()) && me->HealthBelowPct(70))
        {
            if (me->HealthBelowPctDamaged(5, damage))
                damage = 0;
            else
                damage = static_cast<uint32>(static_cast<float>(damage) * (me->GetHealthPct() - 5.0f) / 65.0f);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }

    bool CheckEvadeIfOutOfCombatArea() const override
    {
        return me->isActiveObject() && !AnyPlayerValid();
    }
};

struct npc_anub_ar_crusher : public ScriptedAI
{
    explicit npc_anub_ar_crusher(Creature* c) : ScriptedAI(c), _summons(me)
    {
        scheduler.SetValidator([&]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        _summons.DespawnAll();
        scheduler.CancelAll();

        if (me->ToTempSummon())
            if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                if (summoner->GetEntry() == me->GetEntry())
                {
                    DoCastSelf(RAND(SPELL_SUMMON_ANUBAR_CHAMPION, SPELL_SUMMON_ANUBAR_CRYPT_FIEND, SPELL_SUMMON_ANUBAR_NECROMANCER), true);
                    DoCastSelf(RAND(SPELL_SUMMON_ANUBAR_CHAMPION, SPELL_SUMMON_ANUBAR_CRYPT_FIEND, SPELL_SUMMON_ANUBAR_NECROMANCER), true);
                }
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() != me->GetEntry())
        {
            summon->GetMotionMaster()->MovePoint(0, *me, FORCED_MOVEMENT_NONE, 0.f, false);
            summon->GetMotionMaster()->MoveFollow(me, 0.1f, std::numbers::pi_v<float> * 0.3f * static_cast<float>(_summons.size()));
        }
        _summons.Summon(summon);
    }

    void DoAction(int32 param) override
    {
        if (param == ACTION_DESPAWN_ADDS)
        {
            _summons.DoAction(ACTION_DESPAWN_ADDS);
            _summons.DespawnAll();
        }
    }

    void JustEngagedWith(Unit*) override
    {
        if (me->ToTempSummon())
            if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                if (summoner->GetEntry() != me->GetEntry())
                {
                    summoner->GetAI()->DoAction(ACTION_START_EVENT);
                    me->SummonCreature(NPC_ANUB_AR_CRUSHER, 519.58f, 573.73f, 734.30f, 4.50f);
                    me->SummonCreature(NPC_ANUB_AR_CRUSHER, 539.38f, 573.25f, 732.20f, 4.738f);
                    Talk(SAY_CRUSHER_AGGRO);
                }

        scheduler.Schedule(8s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SMASH);
            context.Repeat(15s);
        }).Schedule(1s, [this](TaskContext context)
        {
            if (me->HealthBelowPct(30))
            {
                Talk(SAY_CRUSHER_EMOTE);
                DoCastSelf(SPELL_FRENZY);
            }
            else
                context.Repeat(1s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);

        DoMeleeAttackIfReady();
    }
private:
    SummonList _summons;
};

class spell_hadronox_summon_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_hadronox_summon_periodic_aura);

public:
    spell_hadronox_summon_periodic_aura(int32 delay, uint32 spellEntry) : _delay(delay), _spellEntry(spellEntry) { }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WEB_FRONT_DOORS });
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        Unit* owner = GetUnitOwner();
        if (InstanceScript* instance = owner->GetInstanceScript())
            if (!instance->IsBossDone(DATA_HADRONOX))
            {
                if (!owner->HasAura(SPELL_WEB_FRONT_DOORS))
                    owner->CastSpell(owner, _spellEntry, true);
                else if (!instance->IsEncounterInProgress())
                    owner->RemoveAurasDueToSpell(SPELL_WEB_FRONT_DOORS);
            }
    }

    void OnApply(AuraEffect const* auraEffect, AuraEffectHandleModes)
    {
        GetAura()->GetEffect(auraEffect->GetEffIndex())->SetPeriodicTimer(_delay);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_hadronox_summon_periodic_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectApply += AuraEffectApplyFn(spell_hadronox_summon_periodic_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    int32 _delay;
    uint32 _spellEntry;
};

class spell_hadronox_leech_poison_aura : public AuraScript
{
    PrepareAuraScript(spell_hadronox_leech_poison_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LEECH_POISON_HEAL });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
            if (Unit* caster = GetCaster())
                caster->CastSpell(caster, SPELL_LEECH_POISON_HEAL, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_hadronox_leech_poison_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_LEECH, AURA_EFFECT_HANDLE_REAL);
    }
};

class achievement_hadronox_denied : public AchievementCriteriaScript
{
public:
    achievement_hadronox_denied() : AchievementCriteriaScript("achievement_hadronox_denied")
    {
    }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_hadronox()
{
    RegisterCreatureAI(boss_hadronox);
    RegisterCreatureAI(npc_anub_ar_crusher);
    RegisterSpellScriptWithArgs(spell_hadronox_summon_periodic_aura, "spell_hadronox_summon_periodic_champion_aura", 15'000, SPELL_SUMMON_ANUBAR_CHAMPION);
    RegisterSpellScriptWithArgs(spell_hadronox_summon_periodic_aura, "spell_hadronox_summon_periodic_necromancer_aura", 10'000, SPELL_SUMMON_ANUBAR_NECROMANCER);
    RegisterSpellScriptWithArgs(spell_hadronox_summon_periodic_aura, "spell_hadronox_summon_periodic_crypt_fiend_aura", 5'000, SPELL_SUMMON_ANUBAR_CRYPT_FIEND);
    RegisterSpellScript(spell_hadronox_leech_poison_aura);
    new achievement_hadronox_denied();
}
