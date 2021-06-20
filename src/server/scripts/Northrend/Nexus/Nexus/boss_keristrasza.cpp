
/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "nexus.h"

enum eEnums
{
    SPELL_FROZEN_PRISON             = 47854,
    SPELL_TAIL_SWEEP                = 50155,
    SPELL_CRYSTAL_CHAINS            = 50997,
    SPELL_ENRAGE                    = 8599,
    SPELL_CRYSTALFIRE_BREATH        = 48096,
    SPELL_CRYSTALIZE                = 48179,
    SPELL_INTENSE_COLD              = 48094,
    SPELL_INTENSE_COLD_TRIGGER      = 48095,
};

enum Yells
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_ENRAGE                      = 2,
    SAY_DEATH                       = 3,
    SAY_CRYSTAL_NOVA                = 4,
    EMOTE_FRENZY                    = 5
};

enum Events
{
    EVENT_CRYSTALFIRE_BREATH        = 1,
    EVENT_CRYSTAL_CHAINS            = 2,
    EVENT_TAIL_SWEEP                = 3,
    EVENT_HEALTH_CHECK              = 4,
    EVENT_ACHIEVEMENT_CHECK         = 5,
    EVENT_KILL_TALK                 = 6
};

class boss_keristrasza : public CreatureScript
{
    public:
        boss_keristrasza() : CreatureScript("boss_keristrasza") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_keristraszaAI>(creature);
        }

        struct boss_keristraszaAI : public BossAI
        {
            boss_keristraszaAI(Creature* creature) : BossAI(creature, DATA_KERISTRASZA_EVENT)
            {
            }

            std::set<uint32> aGuids;

            void Reset()
            {
                BossAI::Reset();
                RemovePrison(CanRemovePrison());
                aGuids.clear();
            }

            void EnterCombat(Unit* who)
            {
                Talk(SAY_AGGRO);
                BossAI::EnterCombat(who);

                me->CastSpell(me, SPELL_INTENSE_COLD, true);
                events.ScheduleEvent(EVENT_CRYSTALFIRE_BREATH, 14000);
                events.ScheduleEvent(EVENT_CRYSTAL_CHAINS, DUNGEON_MODE(20000,11000));
                events.ScheduleEvent(EVENT_TAIL_SWEEP, 5000);
                events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
                events.ScheduleEvent(EVENT_ACHIEVEMENT_CHECK, 1000);
            }

            void JustDied(Unit* killer)
            {
                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
            }

            void KilledUnit(Unit*)
            {
                if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
                {
                    Talk(SAY_SLAY);
                    events.ScheduleEvent(EVENT_KILL_TALK, 6000);
                }
            }

            void SetData(uint32 type, uint32)
            {
                if (type == me->GetEntry() && CanRemovePrison())
                    RemovePrison(true);
            }

            bool CanRemovePrison()
            {
                for (uint8 i = DATA_TELESTRA_ORB; i <= DATA_ORMOROK_ORB; ++i)
                    if (instance->GetBossState(i) != DONE)
                        return false;
                return true;
            }

            void RemovePrison(bool remove)
            {
                if (remove)
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->RemoveAurasDueToSpell(SPELL_FROZEN_PRISON);             
                }
                else
                {
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->CastSpell(me, SPELL_FROZEN_PRISON, true);
                }
            }

            uint32 GetData(uint32 guid) const
            {
                return aGuids.find(guid) == aGuids.end();
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
                    case EVENT_HEALTH_CHECK:
                        if (me->HealthBelowPct(26))
                        {
                            Talk(SAY_ENRAGE);
                            Talk(EMOTE_FRENZY);
                            me->CastSpell(me, SPELL_ENRAGE, true);
                            break;
                        }
                        events.ScheduleEvent(EVENT_HEALTH_CHECK, 1000);
                        break;
                    case EVENT_ACHIEVEMENT_CHECK:
                    {
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                            if (Aura *aur = itr->GetSource()->GetAura(SPELL_INTENSE_COLD_TRIGGER))
                                if (aur->GetStackAmount() > 2)
                                    aGuids.insert(itr->GetSource()->GetGUIDLow());
                        events.ScheduleEvent(EVENT_ACHIEVEMENT_CHECK, 500);
                        break;
                    }
                    case EVENT_CRYSTALFIRE_BREATH:
                        me->CastSpell(me->GetVictim(), SPELL_CRYSTALFIRE_BREATH, false);
                        events.ScheduleEvent(EVENT_CRYSTALFIRE_BREATH, 14000);
                        break;
                    case EVENT_TAIL_SWEEP:
                        me->CastSpell(me, SPELL_TAIL_SWEEP, false);
                        events.ScheduleEvent(EVENT_TAIL_SWEEP, 5000);
                        break;
                    case EVENT_CRYSTAL_CHAINS:
                        Talk(SAY_CRYSTAL_NOVA);
                        if (IsHeroic())
                            me->CastSpell(me, SPELL_CRYSTALIZE, false);
                        else if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 40.0f, true))
                            me->CastSpell(target, SPELL_CRYSTAL_CHAINS, false);
                        events.ScheduleEvent(EVENT_CRYSTAL_CHAINS, DUNGEON_MODE(20000, 11000));
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class achievement_intense_cold : public AchievementCriteriaScript
{
    public:
        achievement_intense_cold() : AchievementCriteriaScript("achievement_intense_cold")
        {
        }

        bool OnCheck(Player* player, Unit* target)
        {
            if (!target)
                return false;

            return target->GetAI()->GetData(player->GetGUIDLow());
        }
};

void AddSC_boss_keristrasza()
{
    new boss_keristrasza();
    new achievement_intense_cold();
}