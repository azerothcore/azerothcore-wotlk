/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "vault_of_archavon.h"
#include "SpellAuras.h"
#include "SpellScript.h"

enum Spells
{
    SPELL_OVERCHARGED               = 64217,
    SPELL_OVERCHARGED_BLAST         = 64219,
    SPELL_OVERCHARGE                = 64218,
    SPELL_BERSERK                   = 26662,

    SPELL_CHAIN_LIGHTNING_10        = 64213,
    SPELL_CHAIN_LIGHTNING_25        = 64215,
    SPELL_LIGHTNING_NOVA_10         = 64216,
    SPELL_LIGHTNING_NOVA_25         = 65279,
};

enum Events
{
    EVENT_CHAIN_LIGHTNING           = 1,
    EVENT_LIGHTNING_NOVA            = 2,
    EVENT_OVERCHARGE                = 3,
    EVENT_BERSERK                   = 4,
    EVENT_SUMMON_NEXT_MINION        = 5,
};

enum Misc
{
    EMOTE_OVERCHARGE                = 0,
    EMOTE_MINION_RESPAWN            = 1,
    EMOTE_BERSERK                   = 2,

    NPC_TEMPEST_MINION              = 33998,
    MAX_TEMPEST_MINIONS             = 4,
};

struct Position TempestMinions[MAX_TEMPEST_MINIONS] =
{
    {-203.980103f, -281.287720f, 91.650223f, 1.598807f},
    {-233.489410f, -281.139282f, 91.652412f, 1.598807f},
    {-233.267578f, -297.104645f, 91.681915f, 1.598807f},
    {-203.842529f, -297.097015f, 91.745163f, 1.598807f}
};

/*######
##  Emalon the Storm Watcher
######*/
class boss_emalon : public CreatureScript
{
    public:
        boss_emalon() : CreatureScript("boss_emalon") { }

        struct boss_emalonAI : public ScriptedAI
        {
            boss_emalonAI(Creature* creature) : ScriptedAI(creature), summons(me)
            {
                pInstance = me->GetInstanceScript();
            }

            InstanceScript* pInstance;
            EventMap events;
            SummonList summons;

            void ResetSummons()
            {
                summons.DespawnAll();
                for (uint8 i = 0; i < MAX_TEMPEST_MINIONS; ++i)
                    me->SummonCreature(NPC_TEMPEST_MINION, TempestMinions[i], TEMPSUMMON_CORPSE_DESPAWN, 0);
            }

            void Reset()
            {
                events.Reset();
                ResetSummons();

                if (pInstance)
                {
                    if (pInstance->GetData(DATA_STONED))
                    {
                        if (Aura* aur = me->AddAura(SPELL_STONED_AURA, me))
                        {
                            aur->SetMaxDuration(60 * MINUTE* IN_MILLISECONDS);
                            aur->SetDuration(60 * MINUTE* IN_MILLISECONDS);
                        }
                    }
                    pInstance->SetData(EVENT_EMALON, NOT_STARTED);
                }
            }

            void AttackStart(Unit* who)
            {
                if (me->HasAura(SPELL_STONED_AURA))
                    return;

                ScriptedAI::AttackStart(who);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
            }

            void SummonedCreatureDies(Creature* cr, Unit*)
            {
                summons.Despawn(cr);
                events.ScheduleEvent(EVENT_SUMMON_NEXT_MINION, 4000);
            }

            void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
            {
                // restore minions health
                if (spellInfo->Id == SPELL_OVERCHARGE)
                    target->SetFullHealth();
            }

            void EnterCombat(Unit*  /*who*/)
            {
                events.Reset();
                if (summons.size() < 4)
                    ResetSummons();

                summons.DoZoneInCombat();

                events.ScheduleEvent(EVENT_CHAIN_LIGHTNING, 5000);
                events.ScheduleEvent(EVENT_LIGHTNING_NOVA, 40000);
                events.ScheduleEvent(EVENT_BERSERK, 360000);
                events.ScheduleEvent(EVENT_OVERCHARGE, 47000);

                if (pInstance)
                    pInstance->SetData(EVENT_EMALON, IN_PROGRESS);
            }

            void JustDied(Unit* )
            {
                summons.DespawnAll();
                events.Reset();
                if (pInstance)
                    pInstance->SetData(EVENT_EMALON, DONE);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.GetEvent())
                {
                    case EVENT_CHAIN_LIGHTNING:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->CastSpell(target, RAID_MODE(SPELL_CHAIN_LIGHTNING_10, SPELL_CHAIN_LIGHTNING_25), false);
                        events.RepeatEvent(25000);
                        break;
                    case EVENT_LIGHTNING_NOVA:
                        me->CastSpell(me, RAID_MODE(SPELL_LIGHTNING_NOVA_10, SPELL_LIGHTNING_NOVA_25), false);
                        events.RepeatEvent(40000);
                        break;
                    case EVENT_OVERCHARGE:
                        if (!summons.empty())
                            me->CastCustomSpell(SPELL_OVERCHARGE, SPELLVALUE_MAX_TARGETS, 1, me, true);
                        Talk(EMOTE_OVERCHARGE);
                        events.RepeatEvent(40000);
                        break;
                    case EVENT_BERSERK:
                        me->CastSpell(me, SPELL_BERSERK, true);
                        Talk(EMOTE_BERSERK);
                        break;
                    case EVENT_SUMMON_NEXT_MINION:
                        me->SummonCreature(NPC_TEMPEST_MINION, TempestMinions[urand(0,3)], TEMPSUMMON_CORPSE_DESPAWN, 0);
                        events.PopEvent();
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_emalonAI(creature);
        }
};

class spell_voa_overcharge : public SpellScriptLoader
{
    public:
        spell_voa_overcharge() : SpellScriptLoader("spell_voa_overcharge") { }

        class spell_voa_overcharge_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_voa_overcharge_AuraScript);

            void HandlePeriodicDummy(AuraEffect const*  /*aurEff*/)
            {
                Unit* target = GetTarget();
                if (target->GetTypeId() == TYPEID_UNIT && GetAura()->GetStackAmount() >= 10)
                {
                    target->CastSpell(target, SPELL_OVERCHARGED_BLAST, true);
                    target->ToCreature()->DespawnOrUnsummon(500);
                }

                PreventDefaultAction();
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_voa_overcharge_AuraScript::HandlePeriodicDummy, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_voa_overcharge_AuraScript();
        }
};

class spell_voa_lightning_nova : public SpellScriptLoader
{
    public:
        spell_voa_lightning_nova() : SpellScriptLoader("spell_voa_lightning_nova") { }

        class spell_voa_lightning_nova_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_voa_lightning_nova_SpellScript);

            void HandleOnHit()
            {
                int32 damage = 0;
                if (Unit* target = GetHitUnit())
                {
                    float dist = target->GetDistance(GetCaster());
                    damage = int32(GetHitDamage() * (70.0f - std::min(70.0f, dist)) / 70.0f);
                }

                SetHitDamage(damage);
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_voa_lightning_nova_SpellScript::HandleOnHit);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_voa_lightning_nova_SpellScript();
        }
};

void AddSC_boss_emalon()
{
    new boss_emalon();

    new spell_voa_overcharge();
    new spell_voa_lightning_nova();
}
