/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Ragnaros
SD%Complete: 95
SDComment: some spells doesnt work correctly
SDCategory: Molten Core
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Texts
{
    SAY_SUMMON_MAJ              = 0,
    SAY_ARRIVAL1_RAG            = 1,
    SAY_ARRIVAL2_MAJ            = 2,
    SAY_ARRIVAL3_RAG            = 3,
    SAY_ARRIVAL5_RAG            = 4,
    SAY_REINFORCEMENTS1         = 5,
    SAY_REINFORCEMENTS2         = 6,
    SAY_HAND                    = 7,
    SAY_WRATH                   = 8,
    SAY_KILL                    = 9,
    SAY_MAGMABURST              = 10
};

enum Spells
{
    SPELL_HAND_OF_RAGNAROS      = 19780,
    SPELL_WRATH_OF_RAGNAROS     = 20566,
    SPELL_LAVA_BURST            = 21158,
    SPELL_MAGMA_BLAST           = 20565,                   // Ranged attack
    SPELL_SONS_OF_FLAME_DUMMY   = 21108,                   // Server side effect
    SPELL_RAGSUBMERGE           = 21107,                   // Stealth aura
    SPELL_RAGEMERGE             = 20568,
    SPELL_MELT_WEAPON           = 21388,
    SPELL_ELEMENTAL_FIRE        = 20564,
    SPELL_ERRUPTION             = 17731
};

enum Events
{
    EVENT_ERUPTION              = 1,
    EVENT_WRATH_OF_RAGNAROS     = 2,
    EVENT_HAND_OF_RAGNAROS      = 3,
    EVENT_LAVA_BURST            = 4,
    EVENT_ELEMENTAL_FIRE        = 5,
    EVENT_MAGMA_BLAST           = 6,
    EVENT_SUBMERGE              = 7,

    EVENT_INTRO_1               = 8,
    EVENT_INTRO_2               = 9,
    EVENT_INTRO_3               = 10,
    EVENT_INTRO_4               = 11,
    EVENT_INTRO_5               = 12
};


class boss_ragnaros : public CreatureScript
{
    public:
        boss_ragnaros() : CreatureScript("boss_ragnaros") { }

        struct boss_ragnarosAI : public BossAI
        {
            boss_ragnarosAI(Creature* creature) : BossAI(creature, BOSS_RAGNAROS)
            {
                _introState = 0;
                me->SetReactState(REACT_PASSIVE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }

            void Reset() override
            {
                BossAI::Reset();
                _emergeTimer = 90000;
                _hasYelledMagmaBurst = false;
                _hasSubmergedOnce = false;
                _isBanished = false;
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
            }

            void EnterCombat(Unit* victim) override
            {
                BossAI::EnterCombat(victim);
                events.ScheduleEvent(EVENT_ERUPTION, 15000);
                events.ScheduleEvent(EVENT_WRATH_OF_RAGNAROS, 30000);
                events.ScheduleEvent(EVENT_HAND_OF_RAGNAROS, 25000);
                events.ScheduleEvent(EVENT_LAVA_BURST, 10000);
                events.ScheduleEvent(EVENT_ELEMENTAL_FIRE, 3000);
                events.ScheduleEvent(EVENT_MAGMA_BLAST, 2000);
                events.ScheduleEvent(EVENT_SUBMERGE, 180000);
            }
            
            void JustDied(Unit* killer) override
            {
                BossAI::JustDied(killer);
                me->SetFacingTo(DEATH_ORIENTATION);
            }

            void KilledUnit(Unit* /*victim*/) override
            {
                if (urand(0, 99) < 25)
                    Talk(SAY_KILL);
            }

            void AttackStart(Unit* target) override
            {
                if (target && me->Attack(target, true))
                    DoStartNoMovement(target);
            }

            void UpdateAI(uint32 diff) override
            {
                if (_introState != 2)
                {
                    if (!_introState)
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                        events.ScheduleEvent(EVENT_INTRO_1, 4000);
                        events.ScheduleEvent(EVENT_INTRO_2, 23000);
                        events.ScheduleEvent(EVENT_INTRO_3, 42000);
                        events.ScheduleEvent(EVENT_INTRO_4, 43000);
                        events.ScheduleEvent(EVENT_INTRO_5, 53000);
                        _introState = 1;
                    }

                    events.Update(diff);

                    while (uint32 eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                        case EVENT_INTRO_1:
                            Talk(SAY_ARRIVAL1_RAG);
                            break;
                        case EVENT_INTRO_2:
                            Talk(SAY_ARRIVAL3_RAG);
                            break;
                        case EVENT_INTRO_3:
                            me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
                            break;
                        case EVENT_INTRO_4:
                            Talk(SAY_ARRIVAL5_RAG);
                            if (Creature* executus = ObjectAccessor::GetCreature(*me, instance->GetData64(BOSS_MAJORDOMO_EXECUTUS)))
                                Unit::Kill(me, executus);
                            break;
                        case EVENT_INTRO_5:
                            me->SetReactState(REACT_AGGRESSIVE);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            _introState = 2;
                            break;
                        default:
                            break;
                        }
                    }
                }
                else
                {
                    if (_isBanished && ((_emergeTimer <= diff) || (instance->GetData(DATA_RAGNAROS_ADDS)) > 8))
                    {
                        //Become unbanished again
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->setFaction(14);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            AttackStart(target);
                        instance->SetData(DATA_RAGNAROS_ADDS, 0);
                        _isBanished = false;
                    }
                    else if (_isBanished)
                    {
                        _emergeTimer -= diff;
                        return;
                    }

                    if (!UpdateVictim())
                        return;

                    events.Update(diff);

                    while (uint32 eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case EVENT_ERUPTION:
                                DoCastVictim(SPELL_ERRUPTION);
                                events.ScheduleEvent(EVENT_ERUPTION, urand(20000, 45000));
                                break;
                            case EVENT_WRATH_OF_RAGNAROS:
                                DoCastVictim(SPELL_WRATH_OF_RAGNAROS);
                                if (urand(0, 1))
                                    Talk(SAY_WRATH);
                                events.ScheduleEvent(EVENT_WRATH_OF_RAGNAROS, 25000);
                                break;
                            case EVENT_HAND_OF_RAGNAROS:
                                DoCast(me, SPELL_HAND_OF_RAGNAROS);
                                if (urand(0, 1))
                                    Talk(SAY_HAND);
                                events.ScheduleEvent(EVENT_HAND_OF_RAGNAROS, 20000);
                                break;
                            case EVENT_LAVA_BURST:
                                DoCastVictim(SPELL_LAVA_BURST);
                                events.ScheduleEvent(EVENT_LAVA_BURST, 10000);
                                break;
                            case EVENT_ELEMENTAL_FIRE:
                                DoCastVictim(SPELL_ELEMENTAL_FIRE);
                                events.ScheduleEvent(EVENT_ELEMENTAL_FIRE, urand(10000, 14000));
                                break;
                            case EVENT_MAGMA_BLAST:
                                if (!me->IsWithinMeleeRange(me->GetVictim()))
                                {
                                    DoCastVictim(SPELL_MAGMA_BLAST);
                                    if (!_hasYelledMagmaBurst)
                                    {
                                        Talk(SAY_MAGMABURST);
                                        _hasYelledMagmaBurst = true;
                                    }
                                }
                                events.ScheduleEvent(EVENT_MAGMA_BLAST, 2500);
                                break;
                            case EVENT_SUBMERGE:
                            {
                                if (!_isBanished)
                                {
                                    // TODO: There is a spell to summon him
                                    me->AttackStop();
                                    DoResetThreat();
                                    me->SetReactState(REACT_PASSIVE);
                                    me->InterruptNonMeleeSpells(false);
                                    me->setFaction(35);
                                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_SUBMERGED);
                                    me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);
                                    instance->SetData(DATA_RAGNAROS_ADDS, 0);

                                    if (!_hasSubmergedOnce)
                                    {
                                        Talk(SAY_REINFORCEMENTS1);

                                        // summon 8 elementals
                                        for (uint8 i = 0; i < 8; ++i)
                                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                                if (Creature* summoned = me->SummonCreature(12143, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 900000))
                                                    summoned->AI()->AttackStart(target);

                                        _hasSubmergedOnce = true;
                                        _isBanished = true;
                                        _emergeTimer = 90000;

                                    }
                                    else
                                    {
                                        Talk(SAY_REINFORCEMENTS2);

                                        for (uint8 i = 0; i < 8; ++i)
                                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                                if (Creature* summoned = me->SummonCreature(12143, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 900000))
                                                    summoned->AI()->AttackStart(target);

                                        _isBanished = true;
                                        _emergeTimer = 90000;
                                    }
                                }
                                events.ScheduleEvent(EVENT_SUBMERGE, 180000);
                                break;
                            }
                            default:
                                break;
                        }
                    }

                    DoMeleeAttackIfReady();
                }
            }

        private:
            float const DEATH_ORIENTATION = 4.0f;
            uint32 _emergeTimer;
            uint8 _introState;
            bool _hasYelledMagmaBurst;
            bool _hasSubmergedOnce;
            bool _isBanished;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_ragnarosAI>(creature);
        }
};

class npc_son_of_flame : public CreatureScript
{
    public:
        npc_son_of_flame() : CreatureScript("npc_SonOfFlame") { }

        struct npc_son_of_flameAI : public ScriptedAI
        {
            npc_son_of_flameAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = me->GetInstanceScript();
            }

            void JustDied(Unit* /*killer*/) override { instance->SetData(DATA_RAGNAROS_ADDS, 1); }

            void UpdateAI(uint32 /*diff*/) override
            {
                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }

        private:
            InstanceScript* instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<npc_son_of_flameAI>(creature);
        }
};

void AddSC_boss_ragnaros()
{
    new boss_ragnaros();
    new npc_son_of_flame();
}
