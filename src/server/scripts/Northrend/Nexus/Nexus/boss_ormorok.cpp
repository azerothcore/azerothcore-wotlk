/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "nexus.h"
#include "Player.h"

enum eEnums
{
    SPELL_CRYSTAL_SPIKES                    = 47958,
    SPELL_CRYSTAL_SPIKE_DAMAGE              = 47944,
    SPELL_CRYSTAL_SPIKE_PREVISUAL           = 50442,
    SPELL_SPELL_REFLECTION                  = 47981,
    SPELL_TRAMPLE                           = 48016,
    SPELL_FRENZY                            = 48017,
    SPELL_SUMMON_CRYSTALLINE_TANGLER        = 61564,
    SPELL_CRYSTAL_CHAINS                    = 47698,
};

enum Yells
{
    SAY_AGGRO                               = 1,
    SAY_DEATH                               = 2,
    SAY_REFLECT                             = 3,
    SAY_CRYSTAL_SPIKES                      = 4,
    SAY_KILL                                = 5,
    EMOTE_FRENZY                            = 6
};

enum Events
{
    EVENT_ORMOROK_CRYSTAL_SPIKES            = 1,
    EVENT_ORMOROK_TRAMPLE                   = 2,
    EVENT_ORMOROK_SPELL_REFLECTION          = 3,
    EVENT_ORMOROK_SUMMON                    = 4,
    EVENT_ORMOROK_HEALTH                    = 5,
    EVENT_ORMOROK_SUMMON_SPIKES             = 6,
    EVENT_KILL_TALK                         = 7
};

enum Misc
{
    NPC_CRYSTAL_SPIKE                       = 27099,
    NPC_CRYSTALLINE_TANGLER                 = 32665,
    GO_CRYSTAL_SPIKE                        = 188537
};

class boss_ormorok : public CreatureScript
{
    public:
        boss_ormorok() : CreatureScript("boss_ormorok") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_ormorokAI>(creature);
        }

        struct boss_ormorokAI : public BossAI
        {
            boss_ormorokAI(Creature* creature) : BossAI(creature, DATA_ORMOROK_EVENT)
            {
            }

            uint8 _spikesCount;

            void Reset()
            {
                _spikesCount = 0;
                BossAI::Reset();
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);

                events.ScheduleEvent(EVENT_ORMOROK_CRYSTAL_SPIKES, 12000);
                events.ScheduleEvent(EVENT_ORMOROK_TRAMPLE, 10000);
                events.ScheduleEvent(EVENT_ORMOROK_SPELL_REFLECTION, 30000);
                events.ScheduleEvent(EVENT_ORMOROK_HEALTH, 1000);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_ORMOROK_SUMMON, 17000);
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
            }

            void KilledUnit(Unit * /*victim*/)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_KILL);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
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
                    case EVENT_ORMOROK_HEALTH:
                        if (me->HealthBelowPct(26))
                        {
                            me->CastSpell(me, SPELL_FRENZY, true);
                            Talk(EMOTE_FRENZY);
                            break;
                        }
                        events.ScheduleEvent(EVENT_ORMOROK_HEALTH, 1000);
                        break;
                    case EVENT_ORMOROK_TRAMPLE:
                        me->CastSpell(me, SPELL_TRAMPLE, false);
                        events.ScheduleEvent(EVENT_ORMOROK_TRAMPLE, 10000);
                        break;
                    case EVENT_ORMOROK_SPELL_REFLECTION:
                        Talk(SAY_REFLECT);
                        me->CastSpell(me, SPELL_SPELL_REFLECTION, false);
                        events.ScheduleEvent(EVENT_ORMOROK_SPELL_REFLECTION, 30000);
                        break;
                    case EVENT_ORMOROK_SUMMON:
                        if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0, 50.0f, true))
                            me->CastSpell(target, SPELL_SUMMON_CRYSTALLINE_TANGLER, true);
                        events.ScheduleEvent(EVENT_ORMOROK_SUMMON, 17000);
                        break;
                    case EVENT_ORMOROK_CRYSTAL_SPIKES:
                        Talk(SAY_CRYSTAL_SPIKES);
                        me->CastSpell(me, SPELL_CRYSTAL_SPIKES, false);
                        _spikesCount = 0;
                        events.ScheduleEvent(EVENT_ORMOROK_SUMMON_SPIKES, 300);
                        events.ScheduleEvent(EVENT_ORMOROK_CRYSTAL_SPIKES, 20000);
                        break;
                    case EVENT_ORMOROK_SUMMON_SPIKES:
                        if (++_spikesCount > 9)
                            break;
                        for (uint8 i = 0; i < 4; ++i)
                        {
                            float o = rand_norm()*2.0f*M_PI;
                            float x = me->GetPositionX()+5.0f*_spikesCount*cos(o);
                            float y = me->GetPositionY()+5.0f*_spikesCount*sin(o);
                            float h = me->GetMap()->GetHeight(x, y, me->GetPositionZ()+5.0f);

                            if (h != INVALID_HEIGHT)
                                me->SummonCreature(NPC_CRYSTAL_SPIKE, x, y, h, 0, TEMPSUMMON_TIMED_DESPAWN, 7000);
                        }
                        events.ScheduleEvent(EVENT_ORMOROK_SUMMON_SPIKES, 200);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class npc_crystal_spike : public CreatureScript
{
    public:
        npc_crystal_spike() : CreatureScript("npc_crystal_spike") { }

        CreatureAI* GetAI(Creature* pCreature) const
        {
            return GetInstanceAI<npc_crystal_spikeAI>(pCreature);
        }

        struct npc_crystal_spikeAI : public NullCreatureAI
        {
            npc_crystal_spikeAI(Creature *c) : NullCreatureAI(c)
            {
            }

            int32 _damageTimer;
            uint64 _gameObjectGUID;

            void Reset()
            {
                if (GameObject* gameobject = me->SummonGameObject(GO_CRYSTAL_SPIKE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 3500))
                    _gameObjectGUID = gameobject->GetGUID();

                _damageTimer = 1;
            }

            void UpdateAI(uint32 diff)
            {
                if (_damageTimer)
                {
                    _damageTimer += diff;
                    if (_damageTimer >= 2000)
                    {
                        if (GameObject* gameobject = ObjectAccessor::GetGameObject(*me, _gameObjectGUID))
                            gameobject->SetGoState(GO_STATE_ACTIVE);

                        me->CastSpell(me, SPELL_CRYSTAL_SPIKE_DAMAGE, false);
                        _damageTimer = 0;
                    }
                }
            }
        };
};

void AddSC_boss_ormorok()
{
    new boss_ormorok();
    new npc_crystal_spike();
}
