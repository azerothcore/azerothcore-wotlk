/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "black_temple.h"

enum Says
{
    SAY_BROKEN_FREE_0               = 0,
    SAY_BROKEN_FREE_1               = 1,
    SAY_BROKEN_FREE_2               = 2,
    SAY_BROKEN_S1                   = 0,
    SAY_BROKEN_S2                   = 1
};

enum Spells
{
    SPELL_STEALTH                   = 34189,
    SPELL_AKAMA_SOUL_CHANNEL        = 40447,
    SPELL_SHADE_SOUL_CHANNEL        = 40401,
    SPELL_CHAIN_LIGHTNING           = 39945,
    SPELL_DESTRUCTIVE_POISON        = 40874,
    SPELL_SHADE_OF_AKAMA_TRIGGER    = 40955,
    SPELL_AKAMA_SOUL_RETRIEVE       = 40902,

    SPELL_ASHTONGUE_WAVE_B           = 42035,
    SPELL_SUMMON_ASHTONGUE_SORCERER  = 40476,
    SPELL_SUMMON_ASHTONGUE_DEFENDER  = 40474
};

enum Creatures
{
    NPC_ASHTONGUE_CHANNELER         = 23421,
    NPC_CREATURE_GENERATOR_AKAMA    = 23210,
    NPC_ASHTONGUE_SORCERER          = 23215,
    NPC_ASHTONGUE_BROKEN            = 23319
};

enum Misc
{
    SUMMON_GROUP_BROKENS            = 1,

    POINT_START                     = 0,
    POINT_CHANNEL_SOUL              = 1,

    ACTION_AKAMA_DIED               = 1,
    ACTION_START_ENCOUNTER          = 2,
    ACTION_STOP_SPAWNING            = 3,
    ACTION_DESPAWN_ALL              = 4,
    ACTION_CHANNELERS_START_CHANNEL = 5,
    ACTION_KILL_CHANNELERS          = 6,
    ACTION_NO_SORCERERS             = 7,
    ACTION_SHADE_DIED               = 8,

    EVENT_AKAMA_START_ENCOUNTER     = 1,
    EVENT_AKAMA_START_CHANNEL       = 2,
    EVENT_SPELL_CHAIN_LIGHTNING     = 4,
    EVENT_SPELL_DESTRUCTIVE_POISON  = 5,

    EVENT_SHADE_CHECK_DISTANCE      = 10,
    EVENT_SHADE_RESET_ENCOUNTER     = 11,
    EVENT_SHADE_GATHER_NPCS         = 12,

    EVENT_SUMMON_WAVE_B             = 20,
    EVENT_SUMMON_ASHTONGUE_SORCERER = 21,
    EVENT_SUMMON_ASHTONGUE_DEFENDER = 22,

    EVENT_AKAMA_SCENE0              = 29,
    EVENT_AKAMA_SCENE1              = 30,
    EVENT_AKAMA_SCENE2              = 31,
    EVENT_AKAMA_SCENE3              = 32,
    EVENT_AKAMA_SCENE4              = 33,
    EVENT_AKAMA_SCENE5              = 34,
    EVENT_AKAMA_SCENE6              = 35,
    EVENT_AKAMA_SCENE7              = 36
};

class boss_shade_of_akama : public CreatureScript
{
    public:
        boss_shade_of_akama() : CreatureScript("boss_shade_of_akama") { }

        struct boss_shade_of_akamaAI : public BossAI
        {
            boss_shade_of_akamaAI(Creature* creature) : BossAI(creature, DATA_SHADE_OF_AKAMA), summonsChanneler(me), summonsGenerator(me)
            {
                events2.ScheduleEvent(EVENT_SHADE_GATHER_NPCS, 1000);
            }

            SummonList summonsChanneler;
            SummonList summonsGenerator;
            EventMap events2;

            void ChannelersAction(int32 action)
            {   
                for (SummonList::const_iterator i = summonsChanneler.begin(); i != summonsChanneler.end(); ++i)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                    {
                        if (action == ACTION_CHANNELERS_START_CHANNEL)
                        {
                            summon->CastSpell(me, SPELL_SHADE_SOUL_CHANNEL, true);
                            summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        }
                        else if (action == ACTION_START_ENCOUNTER)
                        {
                            summon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        }
                        else if (action == ACTION_KILL_CHANNELERS)
                        {
                            Unit::Kill(me, summon);
                        }
                    }
            }

            void Reset()
            {
                BossAI::Reset();
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC|UNIT_FLAG_NOT_SELECTABLE);
                me->SetWalk(true);
            }

            void EnterEvadeMode()
            {
                BossAI::EnterEvadeMode();
                summonsGenerator.DoAction(ACTION_DESPAWN_ALL);
                events2.ScheduleEvent(EVENT_SHADE_RESET_ENCOUNTER, 20000);
                me->SetVisible(false);
                ChannelersAction(ACTION_KILL_CHANNELERS);                   
            }

            void JustDied(Unit* killer)
            {
                BossAI::JustDied(killer);
                summonsGenerator.DoAction(ACTION_DESPAWN_ALL);
                summonsChanneler.DespawnAll();
                me->CastSpell(me, SPELL_SHADE_OF_AKAMA_TRIGGER, true);
                if (Creature* akama = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_AKAMA_SHADE)))
                {
                    akama->SetHomePosition(*akama);
                    akama->AI()->DoAction(ACTION_SHADE_DIED);
                }
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_START_ENCOUNTER)
                {
                    summonsGenerator.DoAction(ACTION_START_ENCOUNTER);
                    ChannelersAction(ACTION_START_ENCOUNTER);
                    events.ScheduleEvent(EVENT_SHADE_CHECK_DISTANCE, 1000);
                }
                else if (param == ACTION_AKAMA_DIED)
                {
                    EnterEvadeMode();
                }
            }

            void UpdateAI(uint32 diff)
            {
                events2.Update(diff);
                switch (events2.ExecuteEvent())
                {
                    case EVENT_SHADE_GATHER_NPCS:
                    {
                        std::list<Creature*> ChannelerList;
                        me->GetCreaturesWithEntryInRange(ChannelerList, 100.0f, NPC_ASHTONGUE_CHANNELER);
                        for (std::list<Creature*>::const_iterator itr = ChannelerList.begin(); itr != ChannelerList.end(); ++itr)
                            summonsChanneler.Summon(*itr);

                        std::list<Creature*> SpawnerList;
                        me->GetCreaturesWithEntryInRange(SpawnerList, 100.0f, NPC_CREATURE_GENERATOR_AKAMA);
                        for (std::list<Creature*>::const_iterator itr = SpawnerList.begin(); itr != SpawnerList.end(); ++itr)
                            summonsGenerator.Summon(*itr);

                        summonsChanneler.Respawn();
                        summonsGenerator.Respawn();
                        ChannelersAction(ACTION_CHANNELERS_START_CHANNEL);
                        
                        if (Creature* akama = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_AKAMA_SHADE)))
                            akama->Respawn(true);
                        break;
                    }
                    case EVENT_SHADE_RESET_ENCOUNTER:
                        me->SetVisible(true);
                        summonsGenerator.Respawn();
                        summonsChanneler.Respawn();
                        ChannelersAction(ACTION_CHANNELERS_START_CHANNEL);

                        if (Creature* akama = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_AKAMA_SHADE)))
                            akama->Respawn(true);
                        break;
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SHADE_CHECK_DISTANCE:
                        if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
                        {
                            int32 slow = me->GetMaxNegativeAuraModifier(SPELL_AURA_MOD_DECREASE_SPEED);
                            if (slow > -100)
                            {
                                me->SetWalk(true);
                                me->GetMotionMaster()->MovePoint(POINT_START, 510.0f, 400.7993f, 112.7837f);
                            }
                        }
                        else
                        {
                            int32 slow = me->GetMaxNegativeAuraModifier(SPELL_AURA_MOD_DECREASE_SPEED);
                            if (slow < -100)
                                me->GetMotionMaster()->Clear();
                            else if (slow == 0)
                            {
                                summonsGenerator.DoAction(ACTION_NO_SORCERERS);
                                me->SetWalk(false);
                            }
                        }

                        if (me->IsWithinMeleeRange(me->GetVictim()))
                        {
                            me->SetReactState(REACT_AGGRESSIVE);
                            DoResetThreat();
                            me->GetVictim()->InterruptNonMeleeSpells(false);
                            me->AddThreat(me->GetVictim(), 1000000.0f);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC|UNIT_FLAG_NOT_SELECTABLE);
                            summonsGenerator.DoAction(ACTION_STOP_SPAWNING);
                            break;
                        }
                        events.ScheduleEvent(EVENT_SHADE_CHECK_DISTANCE, 1000);
                        break;
                }

                DoMeleeAttackIfReady();
                EnterEvadeIfOutOfCombatArea();
            }
    
            bool CheckEvadeIfOutOfCombatArea() const
            {
                return !SelectTargetFromPlayerList(120.0f);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_shade_of_akamaAI>(creature);
        }
};

class npc_akama_shade : public CreatureScript
{
    public:
        npc_akama_shade() : CreatureScript("npc_akama_shade") { }

        struct npc_akamaAI : public ScriptedAI
        {
            npc_akamaAI(Creature* creature) : ScriptedAI(creature), summons(me)
            {
                instance = creature->GetInstanceScript();
            }

            InstanceScript* instance;
            EventMap events;
            EventMap events2;
            SummonList summons;

            void Reset()
            {
                if (instance->GetBossState(DATA_SHADE_OF_AKAMA) == DONE)
                {
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    return;
                }

                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                me->CastSpell(me, SPELL_STEALTH, true);
                events.Reset();
                events2.Reset();
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != POINT_MOTION_TYPE || point != POINT_CHANNEL_SOUL)
                    return;

                me->SetFacingTo(0.0f);
                events2.ScheduleEvent(EVENT_AKAMA_SCENE1, 1000);
                events2.ScheduleEvent(EVENT_AKAMA_SCENE2, 16500);
                events2.ScheduleEvent(EVENT_AKAMA_SCENE3, 17500);
                events2.ScheduleEvent(EVENT_AKAMA_SCENE4, 27000);
                events2.ScheduleEvent(EVENT_AKAMA_SCENE5, 37000);
                events2.ScheduleEvent(EVENT_AKAMA_SCENE6, 51000);
                events2.ScheduleEvent(EVENT_AKAMA_SCENE7, 56000);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_SHADE_DIED)
                    events2.ScheduleEvent(EVENT_AKAMA_SCENE0, 1000);
            }

            void JustDied(Unit* /*killer*/)
            {
                if (Creature* shade = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_SHADE_OF_AKAMA)))
                    shade->AI()->DoAction(ACTION_AKAMA_DIED);
            }

            void EnterCombat(Unit* /*who*/)
            {
                events.ScheduleEvent(EVENT_SPELL_CHAIN_LIGHTNING, 2000);
                events.ScheduleEvent(EVENT_SPELL_DESTRUCTIVE_POISON, 5000);
            }

            void JustSummoned(Creature* summon)
            {
                float dist = frand(30.0f, 32.0f);
                summon->SetWalk(true);
                summon->GetMotionMaster()->MovePoint(POINT_START, summon->GetPositionX()+dist*cos(summon->GetOrientation()), summon->GetPositionY()+dist*sin(summon->GetOrientation()), summon->GetPositionZ(), false);
                summons.Summon(summon);
            }

            void UpdateAI(uint32 diff)
            {
                events2.Update(diff);
                switch (events2.ExecuteEvent())
                {
                    case EVENT_AKAMA_START_ENCOUNTER:
                        me->RemoveAura(SPELL_STEALTH);
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(POINT_START, 517.4877f, 400.7993f, 112.7837f, false);
                        events2.ScheduleEvent(EVENT_AKAMA_START_CHANNEL, 11000);
                        break;
                    case EVENT_AKAMA_START_CHANNEL:
                        me->CastSpell(me, SPELL_AKAMA_SOUL_CHANNEL, false);
                        if (Creature* shade = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_SHADE_OF_AKAMA)))
                        {
                            shade->AI()->AttackStart(me);
                            shade->GetMotionMaster()->Clear();
                            shade->AI()->DoAction(ACTION_START_ENCOUNTER);
                        }
                        break;
                    case EVENT_AKAMA_SCENE0:
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(POINT_CHANNEL_SOUL, 467.0f, 400.7993f, 118.537f);
                        break;
                    case EVENT_AKAMA_SCENE1:
                        me->CastSpell(me, SPELL_AKAMA_SOUL_RETRIEVE, true);
                        break;
                    case EVENT_AKAMA_SCENE2:
                        Talk(SAY_BROKEN_FREE_0);
                        break;
                    case EVENT_AKAMA_SCENE3:
                        me->SummonCreatureGroup(SUMMON_GROUP_BROKENS);
                        break;
                    case EVENT_AKAMA_SCENE4:
                        Talk(SAY_BROKEN_FREE_1);
                        break;
                    case EVENT_AKAMA_SCENE5:
                        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                            if (Creature* broken = ObjectAccessor::GetCreature(*me, *itr))
                                broken->SetStandState(UNIT_STAND_STATE_KNEEL);
                        Talk(SAY_BROKEN_FREE_2);
                        break;
                    case EVENT_AKAMA_SCENE6:
                        if (Creature* broken = summons.GetCreatureWithEntry(NPC_ASHTONGUE_BROKEN))
                            broken->AI()->Talk(SAY_BROKEN_S1);
                        break;
                    case EVENT_AKAMA_SCENE7:
                        for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                            if (Creature* broken = ObjectAccessor::GetCreature(*me, *itr))
                                broken->AI()->Talk(SAY_BROKEN_S2);
                        break;
                }

                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_CHAIN_LIGHTNING:
                        me->CastSpell(me->GetVictim(), SPELL_CHAIN_LIGHTNING, false);
                        events.ScheduleEvent(EVENT_SPELL_CHAIN_LIGHTNING, urand(10000, 15000));
                        break;
                    case EVENT_SPELL_DESTRUCTIVE_POISON:
                        me->CastSpell(me, SPELL_DESTRUCTIVE_POISON, false);
                        events.ScheduleEvent(EVENT_SPELL_DESTRUCTIVE_POISON, urand(4000, 5000));
                        break;
                }

                DoMeleeAttackIfReady();
            }

            void sGossipSelect(Player* player, uint32 /*sender*/, uint32 action)
            {
                if (action == 0)
                {
                    CloseGossipMenuFor(player);
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    events2.ScheduleEvent(EVENT_AKAMA_START_ENCOUNTER, 0);
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_akamaAI>(creature);
        }
};

// ########################################################
// Creature Generator Akama
// ########################################################

class npc_creature_generator_akama : public CreatureScript
{
    public:
        npc_creature_generator_akama() : CreatureScript("npc_creature_generator_akama") { }

        struct npc_creature_generator_akamaAI : public NullCreatureAI
        {
            npc_creature_generator_akamaAI(Creature* creature) : NullCreatureAI(creature), summons(me)
            {
                instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                events.Reset();
                summons.DespawnAll();
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() == NPC_ASHTONGUE_SORCERER)
                {
                    std::list<Creature*> channelerList;
                    me->GetCreaturesWithEntryInRange(channelerList, 120.0f, NPC_ASHTONGUE_CHANNELER);
                    for (std::list<Creature*>::const_iterator itr = channelerList.begin(); itr != channelerList.end(); ++itr)
                    {
                        if ((*itr)->IsAlive() || (*itr)->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                            continue;

                        summon->SetInCombatWithZone();
                        summon->SetReactState(REACT_PASSIVE);
                        summon->GetMotionMaster()->MovePoint(POINT_START, **itr);
                        (*itr)->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        return;
                    }
                }

                summon->SetInCombatWithZone();
                if (Unit* akama = ObjectAccessor::GetCreature(*me, instance->GetData64(NPC_AKAMA_SHADE)))
                {
                    summon->AddThreat(akama, 500.0f);
                    summon->AI()->AttackStart(akama);
                }
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                summon->DespawnOrUnsummon(10000);
                summons.Despawn(summon);
            }

            void DoAction(int32 param)
            {
                if (param == ACTION_STOP_SPAWNING || param == ACTION_DESPAWN_ALL)
                {
                    events.Reset();
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    {
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                        {
                            if (summon->GetEntry() != NPC_ASHTONGUE_SORCERER)
                                continue;
                            summon->InterruptNonMeleeSpells(false);
                            summon->GetMotionMaster()->Clear();
                            summon->SetInCombatWithZone();
                        }
                    }
                }
                if (param == ACTION_DESPAWN_ALL)
                    summons.DespawnAll();
                else if (param == ACTION_NO_SORCERERS)
                    events.CancelEvent(EVENT_SUMMON_ASHTONGUE_SORCERER);
                else if (param == ACTION_START_ENCOUNTER)
                {
                    events.ScheduleEvent(EVENT_SUMMON_WAVE_B, 5000);
                    events.ScheduleEvent(EVENT_SUMMON_ASHTONGUE_DEFENDER, 20000);
                    events.ScheduleEvent(EVENT_SUMMON_ASHTONGUE_SORCERER, 35000);
                }
            }

            void UpdateAI(uint32 diff)
            {
                events.Update(diff);

                switch (events.ExecuteEvent())
                {
                    case EVENT_SUMMON_WAVE_B:
                        me->CastSpell(me, SPELL_ASHTONGUE_WAVE_B, true);
                        events.ScheduleEvent(EVENT_SUMMON_WAVE_B, 45000);
                        break;
                    case EVENT_SUMMON_ASHTONGUE_SORCERER: // left
                        me->CastSpell(me, SPELL_SUMMON_ASHTONGUE_SORCERER, true);
                        events.ScheduleEvent(EVENT_SUMMON_ASHTONGUE_SORCERER, 45000);
                        break;
                    case EVENT_SUMMON_ASHTONGUE_DEFENDER: // right
                        me->CastSpell(me, SPELL_SUMMON_ASHTONGUE_DEFENDER, true);
                        events.ScheduleEvent(EVENT_SUMMON_ASHTONGUE_DEFENDER, 45000);
                        break;
                    default:
                        break;
                }
            }

            private:
                EventMap events;
                SummonList summons;
                InstanceScript* instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_creature_generator_akamaAI>(creature);
        }
};

class spell_shade_of_akama_shade_soul_channel : public SpellScriptLoader
{
    public:
        spell_shade_of_akama_shade_soul_channel() : SpellScriptLoader("spell_shade_of_akama_shade_soul_channel") { }

        class spell_shade_of_akama_shade_soul_channel_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_shade_of_akama_shade_soul_channel_AuraScript)
            
            void HandleEffectApply(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                    caster->SetFacingToObject(GetTarget());
            }

            void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Aura* aura = GetTarget()->GetAura(GetSpellInfo()->Effects[EFFECT_1].TriggerSpell))
                    aura->ModStackAmount(-1);
            }

            void Register()
            {
                AfterEffectApply += AuraEffectApplyFn(spell_shade_of_akama_shade_soul_channel_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_shade_of_akama_shade_soul_channel_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_shade_of_akama_shade_soul_channel_AuraScript();
        }
};

class spell_shade_of_akama_akama_soul_expel : public SpellScriptLoader
{
    public:
        spell_shade_of_akama_akama_soul_expel() : SpellScriptLoader("spell_shade_of_akama_akama_soul_expel") { }

        class spell_shade_of_akama_akama_soul_expel_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_shade_of_akama_akama_soul_expel_SpellScript);

            void SetDest(SpellDestination& dest)
            {
                // Adjust effect summon position
                Position const offset = { 0.0f, 0.0f, 25.0f, 0.0f };
                dest.RelocateOffset(offset);
            }

            void Register()
            {
                OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_shade_of_akama_akama_soul_expel_SpellScript::SetDest, EFFECT_0, TARGET_DEST_CASTER_RADIUS);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_shade_of_akama_akama_soul_expel_SpellScript();
        }
};

void AddSC_boss_shade_of_akama()
{
    new boss_shade_of_akama();
    new npc_akama_shade();
    new npc_creature_generator_akama();
    new spell_shade_of_akama_shade_soul_channel();
    new spell_shade_of_akama_akama_soul_expel();
}
