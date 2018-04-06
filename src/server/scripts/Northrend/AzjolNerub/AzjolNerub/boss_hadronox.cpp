/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "azjol_nerub.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

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

enum Events
{
    EVENT_HADRONOX_MOVE1        = 1,
    EVENT_HADRONOX_MOVE2        = 2,
    EVENT_HADRONOX_MOVE3        = 3,
    EVENT_HADRONOX_MOVE4        = 4,
    EVENT_HADRONOX_ACID         = 5,
    EVENT_HADRONOX_LEECH        = 6,
    EVENT_HADRONOX_PIERCE       = 7,
    EVENT_HADRONOX_GRAB         = 8,
    EVENT_HADRONOX_SUMMON       = 9,

    EVENT_CRUSHER_SMASH         = 20,
    EVENT_CHECK_HEALTH          = 21
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

class boss_hadronox : public CreatureScript
{
    public:
        boss_hadronox() : CreatureScript("boss_hadronox") { }

        struct boss_hadronoxAI : public BossAI
        {
            boss_hadronoxAI(Creature* creature) : BossAI(creature, DATA_HADRONOX_EVENT)
            {
            }

            void Reset()
            {
                summons.DoAction(ACTION_DESPAWN_ADDS);
                BossAI::Reset();                
                me->SummonCreature(NPC_ANUB_AR_CRUSHER, 542.9f, 519.5f, 741.24f, 2.14f);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_START_EVENT)
                {
                    instance->SetBossState(DATA_HADRONOX_EVENT, IN_PROGRESS);
                    me->setActive(true);
                    events.ScheduleEvent(EVENT_HADRONOX_MOVE1, 20000);
                    events.ScheduleEvent(EVENT_HADRONOX_MOVE2, 40000);
                    events.ScheduleEvent(EVENT_HADRONOX_MOVE3, 60000);
                    events.ScheduleEvent(EVENT_HADRONOX_MOVE4, 80000);
                }
            }

            uint32 GetData(uint32 data) const
            {
                if (data == me->GetEntry())
                    return !me->isActiveObject() || events.GetNextEventTime(EVENT_HADRONOX_MOVE4) != 0;
                return 0;
            }

            void JustSummoned(Creature* summon)
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

            void KilledUnit(Unit* victim)
            {
                if (!me->IsAlive() || !victim->HasAura(SPELL_LEECH_POISON))
                    return;

                me->ModifyHealth(int32(me->CountPctFromMaxHealth(10)));
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
            }

            void EnterCombat(Unit*)
            {
                events.RescheduleEvent(EVENT_HADRONOX_ACID, 10000);
                events.RescheduleEvent(EVENT_HADRONOX_LEECH, 4000);
                events.RescheduleEvent(EVENT_HADRONOX_PIERCE, 1000);
                events.RescheduleEvent(EVENT_HADRONOX_GRAB, 15000);
            }

            bool AnyPlayerValid() const
            {
                Map::PlayerList const& playerList = me->GetMap()->GetPlayers();
                for(Map::PlayerList::const_iterator itr = playerList.begin(); itr != playerList.end(); ++itr)
                    if (me->GetDistance(itr->GetSource()) < 130.0f && itr->GetSource()->IsAlive() && !itr->GetSource()->IsGameMaster() && me->CanCreatureAttack(itr->GetSource()) && me->_CanDetectFeignDeathOf(itr->GetSource()))
                        return true;

                return false;
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (uint32 eventId = events.ExecuteEvent())
                {
                    case EVENT_HADRONOX_PIERCE:
                        me->CastSpell(me->GetVictim(), SPELL_PIERCE_ARMOR, false);
                        events.ScheduleEvent(EVENT_HADRONOX_PIERCE, 8000);
                        break;
                    case EVENT_HADRONOX_ACID:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, false))
                            me->CastSpell(target, SPELL_ACID_CLOUD, false);
                        events.ScheduleEvent(EVENT_HADRONOX_ACID, 25000);
                        break;
                    case EVENT_HADRONOX_LEECH:
                        me->CastSpell(me, SPELL_LEECH_POISON, false);
                        events.ScheduleEvent(EVENT_HADRONOX_LEECH, 12000);
                        break;
                    case EVENT_HADRONOX_GRAB:
                        me->CastSpell(me, SPELL_WEB_GRAB, false);
                        events.ScheduleEvent(EVENT_HADRONOX_GRAB, 25000);
                        break;
                    case EVENT_HADRONOX_MOVE4:
                        me->CastSpell(me, SPELL_WEB_FRONT_DOORS, true);
                    case EVENT_HADRONOX_MOVE1:
                    case EVENT_HADRONOX_MOVE2:
                    case EVENT_HADRONOX_MOVE3:
                        Talk(SAY_HADRONOX_EMOTE);
                        me->GetMotionMaster()->MoveCharge(hadronoxSteps[eventId-1].GetPositionX(), hadronoxSteps[eventId-1].GetPositionY(), hadronoxSteps[eventId-1].GetPositionZ(), 10.0f, 0, NULL, true);
                        break;

                }

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
                    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->isActiveObject() && !AnyPlayerValid();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_hadronoxAI(creature);
        }
};

class npc_anub_ar_crusher : public CreatureScript
{
    public:
        npc_anub_ar_crusher() : CreatureScript("npc_anub_ar_crusher") { }

        struct npc_anub_ar_crusherAI : public ScriptedAI
        {
            npc_anub_ar_crusherAI(Creature *c) : ScriptedAI(c), summons(me) {}

            EventMap events;
            SummonList summons;

            void Reset()
            {
                summons.DespawnAll();
                events.Reset();

                if (me->ToTempSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                        if (summoner->GetEntry() == me->GetEntry())
                        {
                            me->CastSpell(me, RAND(SPELL_SUMMON_ANUBAR_CHAMPION, SPELL_SUMMON_ANUBAR_CRYPT_FIEND, SPELL_SUMMON_ANUBAR_NECROMANCER), true);
                            me->CastSpell(me, RAND(SPELL_SUMMON_ANUBAR_CHAMPION, SPELL_SUMMON_ANUBAR_CRYPT_FIEND, SPELL_SUMMON_ANUBAR_NECROMANCER), true);
                        }
            }

            void JustSummoned(Creature* summon)
            {
                if(summon->GetEntry() != me->GetEntry())
                {
                    summon->GetMotionMaster()->MovePoint(0, *me, false);
                    summon->GetMotionMaster()->MoveFollow(me, 0.1f, 0.0f + M_PI*0.3f*summons.size());
                }
                summons.Summon(summon);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_DESPAWN_ADDS)
                {
                    summons.DoAction(ACTION_DESPAWN_ADDS);
                    summons.DespawnAll();
                }
            }

            void EnterCombat(Unit*)
            {
                if (me->ToTempSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                        if (summoner->GetEntry() != me->GetEntry())
                        {
                            summoner->GetAI()->DoAction(ACTION_START_EVENT);
                            me->SummonCreature(NPC_ANUB_AR_CRUSHER, 519.58f, 573.73f, 734.30f, 4.50f);
                            me->SummonCreature(NPC_ANUB_AR_CRUSHER, 539.38f, 573.25f, 732.20f, 4.738f);
                            Talk(SAY_CRUSHER_AGGRO);
                        }

                events.ScheduleEvent(EVENT_CRUSHER_SMASH, 8000, 0, 0);
                events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
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
                    case EVENT_CRUSHER_SMASH:
                        me->CastSpell(me->GetVictim(), SPELL_SMASH, false);
                        events.ScheduleEvent(EVENT_CRUSHER_SMASH, 15000);
                        break;
                    case EVENT_CHECK_HEALTH:
                        if (me->HealthBelowPct(30))
                        {
                            Talk(SAY_CRUSHER_EMOTE);
                            me->CastSpell(me, SPELL_FRENZY, false);
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_anub_ar_crusherAI(creature);
        }
};

class spell_hadronox_summon_periodic : public SpellScriptLoader
{
    public:
        spell_hadronox_summon_periodic(const char* name, uint32 delay, uint32 spellEntry) : SpellScriptLoader(name), _delay(delay), _spellEntry(spellEntry) { }

        class spell_hadronox_summon_periodic_AuraScript : public AuraScript
        {
        public:
            spell_hadronox_summon_periodic_AuraScript(uint32 delay, uint32 spellEntry) : _delay(delay), _spellEntry(spellEntry) { }
            PrepareAuraScript(spell_hadronox_summon_periodic_AuraScript);

            void HandlePeriodic(AuraEffect const* /*aurEff*/)
            {
                PreventDefaultAction();
                Unit* owner = GetUnitOwner();
                if (InstanceScript* instance = owner->GetInstanceScript())
                    if (instance->GetBossState(DATA_HADRONOX_EVENT) != DONE)
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

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_hadronox_summon_periodic_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
                OnEffectApply += AuraEffectApplyFn(spell_hadronox_summon_periodic_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

        private:
            uint32 _delay;
            uint32 _spellEntry;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hadronox_summon_periodic_AuraScript(_delay, _spellEntry);
        }

    private:
        uint32 _delay;
        uint32 _spellEntry;
};

class spell_hadronox_leech_poison : public SpellScriptLoader
{
    public:
        spell_hadronox_leech_poison() : SpellScriptLoader("spell_hadronox_leech_poison") { }

        class spell_hadronox_leech_poison_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_hadronox_leech_poison_AuraScript)

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {                
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
                    if (Unit* caster = GetCaster())
                        caster->CastSpell(caster, SPELL_LEECH_POISON_HEAL, true);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_hadronox_leech_poison_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_LEECH, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_hadronox_leech_poison_AuraScript();
        }
};

class achievement_hadronox_denied : public AchievementCriteriaScript
{
    public:
        achievement_hadronox_denied() : AchievementCriteriaScript("achievement_hadronox_denied")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target)
        {
            if (!target)
                return false;

            return target->GetAI()->GetData(target->GetEntry());
        }
};

void AddSC_boss_hadronox()
{
    new boss_hadronox();
    new npc_anub_ar_crusher();
    new spell_hadronox_summon_periodic("spell_hadronox_summon_periodic_champion", 15000, SPELL_SUMMON_ANUBAR_CHAMPION);
    new spell_hadronox_summon_periodic("spell_hadronox_summon_periodic_necromancer", 10000, SPELL_SUMMON_ANUBAR_NECROMANCER);
    new spell_hadronox_summon_periodic("spell_hadronox_summon_periodic_crypt_fiend", 5000, SPELL_SUMMON_ANUBAR_CRYPT_FIEND);
    new spell_hadronox_leech_poison();
    new achievement_hadronox_denied();
}
