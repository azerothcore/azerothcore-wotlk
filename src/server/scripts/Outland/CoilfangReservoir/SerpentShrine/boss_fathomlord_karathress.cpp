/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "serpent_shrine.h"

enum Talk
{
    SAY_AGGRO                       = 0,
    SAY_GAIN_BLESSING               = 1,
    SAY_GAIN_ABILITY1               = 2,
    SAY_GAIN_ABILITY2               = 3,
    SAY_GAIN_ABILITY3               = 4,
    SAY_SLAY                        = 5,
    SAY_DEATH                       = 6
};

enum Spells
{
    SPELL_CATACLYSMIC_BOLT          = 38441,
    SPELL_SEAR_NOVA                 = 38445,
    SPELL_ENRAGE                    = 24318,
    SPELL_BLESSING_OF_THE_TIDES     = 38449
};

enum Misc
{
    MAX_ADVISORS                    = 3,
    NPC_FATHOM_GUARD_CARIBDIS       = 21964,
    NPC_FATHOM_GUARD_TIDALVESS      = 21965,
    NPC_FATHOM_GUARD_SHARKKIS       = 21966,
    NPC_SEER_OLUM                   = 22820,
    GO_CAGE                         = 185952,

    EVENT_SPELL_CATACLYSMIC_BOLT    = 1,
    EVENT_SPELL_ENRAGE              = 2,
    EVENT_SPELL_SEAR_NOVA           = 3,
    EVENT_HEALTH_CHECK              = 4,
    EVENT_KILL_TALK                 = 5
};

const Position advisorsPosition[MAX_ADVISORS+2] = 
{
    {459.61f, -534.81f, -7.54f, 3.82f},
    {463.83f, -540.23f, -7.54f, 3.15f},
    {459.94f, -547.28f, -7.54f, 2.42f},
    {448.37f, -544.71f, -7.54f, 0.00f},
    {457.37f, -544.71f, -7.54f, 0.00f}
};

class boss_fathomlord_karathress : public CreatureScript
{
    public:
        boss_fathomlord_karathress() : CreatureScript("boss_fathomlord_karathress") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_fathomlord_karathressAI>(creature);
        }

        struct boss_fathomlord_karathressAI : public BossAI
        {
            boss_fathomlord_karathressAI(Creature* creature) : BossAI(creature, DATA_FATHOM_LORD_KARATHRESS)
            {
            }

            void Reset()
            {
                BossAI::Reset();

                me->SummonCreature(NPC_FATHOM_GUARD_TIDALVESS, advisorsPosition[0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);
                me->SummonCreature(NPC_FATHOM_GUARD_SHARKKIS, advisorsPosition[1], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);
                me->SummonCreature(NPC_FATHOM_GUARD_CARIBDIS, advisorsPosition[2], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 600000);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() == NPC_SEER_OLUM)
                {
                    summon->SetWalk(true);
                    summon->GetMotionMaster()->MovePoint(0, advisorsPosition[MAX_ADVISORS+1], false);
                }
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                summons.Despawn(summon);
                if (summon->GetEntry() == NPC_FATHOM_GUARD_TIDALVESS)
                    Talk(SAY_GAIN_ABILITY1);
                if (summon->GetEntry() == NPC_FATHOM_GUARD_SHARKKIS)
                    Talk(SAY_GAIN_ABILITY2);
                if (summon->GetEntry() == NPC_FATHOM_GUARD_CARIBDIS)
                    Talk(SAY_GAIN_ABILITY3);
            }

            void KilledUnit(Unit* /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
                me->SummonCreature(NPC_SEER_OLUM, advisorsPosition[MAX_ADVISORS], TEMPSUMMON_TIMED_DESPAWN, 3600000);
                if (GameObject* gobject = me->FindNearestGameObject(GO_CAGE, 100.0f))
                    gobject->SetGoState(GO_STATE_ACTIVE);
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
                Talk(SAY_AGGRO);
                me->CallForHelp(10.0f);

                events.ScheduleEvent(EVENT_SPELL_CATACLYSMIC_BOLT, 10000);
                events.ScheduleEvent(EVENT_SPELL_ENRAGE, 600000);
                events.ScheduleEvent(EVENT_SPELL_SEAR_NOVA, 25000);
                events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_ENRAGE:
                        me->CastSpell(me, SPELL_ENRAGE, true);
                        break;
                    case EVENT_SPELL_CATACLYSMIC_BOLT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, PowerUsersSelector(me, POWER_MANA, 50.0f, true)))
                            me->CastSpell(target, SPELL_CATACLYSMIC_BOLT, false);
                        events.ScheduleEvent(EVENT_SPELL_CATACLYSMIC_BOLT, 6000);
                        break;
                    case EVENT_SPELL_SEAR_NOVA:
                        me->CastSpell(me, SPELL_SEAR_NOVA, false);
                        events.ScheduleEvent(EVENT_SPELL_SEAR_NOVA, 20000+urand(0, 20000));
                        break;
                    case EVENT_HEALTH_CHECK:
                        if (me->HealthBelowPct(76))
                        {
                            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                                if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                                    if (summon->GetMaxHealth() > 500000)
                                        summon->CastSpell(me, SPELL_BLESSING_OF_THE_TIDES, true);

                            if (me->HasAura(SPELL_BLESSING_OF_THE_TIDES))
                                Talk(SAY_GAIN_BLESSING);
                            break;
                        }
                        events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class spell_karathress_power_of_caribdis : public SpellScriptLoader
{
    public:
        spell_karathress_power_of_caribdis() : SpellScriptLoader("spell_karathress_power_of_caribdis") { }

        class spell_karathress_power_of_caribdis_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_karathress_power_of_caribdis_AuraScript);

            void OnPeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                if (Unit* victim = GetUnitOwner()->GetVictim())
                    GetUnitOwner()->CastSpell(victim, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
            }

            void Register()
            {
                 OnEffectPeriodic += AuraEffectPeriodicFn(spell_karathress_power_of_caribdis_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_karathress_power_of_caribdis_AuraScript();
        }
};

void AddSC_boss_fathomlord_karathress()
{
    new boss_fathomlord_karathress();
    new spell_karathress_power_of_caribdis();
}
