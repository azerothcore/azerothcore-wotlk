/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "mechanar.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_DOMINATION                  = 1,
    SAY_SUMMON                      = 2,
    SAY_ENRAGE                      = 3,
    SAY_SLAY                        = 4,
    SAY_DEATH                       = 5,
    SAY_APPEAR                      = 6
};

enum Spells
{
    SPELL_ARCANE_EXPLOSION          = 15453,
    SPELL_DISGRUNTLED_ANGER         = 35289,
    SPELL_ARCANE_TORRENT            = 36022,
    SPELL_MANA_TAP                  = 36021,
    SPELL_DOMINATION                = 35280,
    SPELL_SUMMON_NETHER_WRAITH_1    = 35285,
    SPELL_SUMMON_NETHER_WRAITH_2    = 35286,
    SPELL_SUMMON_NETHER_WRAITH_3    = 35287,
    SPELL_SUMMON_NETHER_WRAITH_4    = 35288,
};

enum Events
{
    EVENT_SUMMON                    = 1,
    EVENT_MANA_TAP                  = 2,
    EVENT_ARCANE_TORRENT            = 3,
    EVENT_DOMINATION                = 4,
    EVENT_ARCANE_EXPLOSION          = 5,
    EVENT_FRENZY                    = 6,
};

class boss_pathaleon_the_calculator : public CreatureScript
{
    public:
        boss_pathaleon_the_calculator(): CreatureScript("boss_pathaleon_the_calculator") { }

        struct boss_pathaleon_the_calculatorAI : public BossAI
        {
            boss_pathaleon_the_calculatorAI(Creature* creature) : BossAI(creature, DATA_PATHALEON_THE_CALCULATOR) { }

            void InitializeAI()
            {
                BossAI::InitializeAI();
                me->SetVisible(false);
                me->SetReactState(REACT_PASSIVE);
            }

            void DoAction(int32  /*param*/)
            {
                me->SetVisible(true);
                me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
                me->SetReactState(REACT_AGGRESSIVE);
                Talk(SAY_APPEAR);
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
                events.ScheduleEvent(EVENT_SUMMON, 30000);
                events.ScheduleEvent(EVENT_MANA_TAP, 12000);
                events.ScheduleEvent(EVENT_ARCANE_TORRENT, 16000);
                events.ScheduleEvent(EVENT_DOMINATION, 25000);
                events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, 8000);
                events.ScheduleEvent(EVENT_FRENZY, 1000);
                Talk(SAY_AGGRO);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_SLAY);
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
                Talk(SAY_DEATH);
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
                    case EVENT_ARCANE_EXPLOSION:
                        me->CastSpell(me, SPELL_ARCANE_EXPLOSION, false);
                        events.ScheduleEvent(EVENT_ARCANE_EXPLOSION, 12000);
                        break;
                    case EVENT_ARCANE_TORRENT:
                        me->RemoveAurasDueToSpell(SPELL_MANA_TAP);
                        me->ModifyPower(POWER_MANA, 5000);
                        me->CastSpell(me, SPELL_ARCANE_TORRENT, false);
                        events.ScheduleEvent(EVENT_ARCANE_TORRENT, 15000);
                        break;
                    case EVENT_MANA_TAP:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
                            me->CastSpell(target, SPELL_MANA_TAP, false);
                        events.ScheduleEvent(EVENT_MANA_TAP, 18000);
                        break;
                    case EVENT_DOMINATION:
                        Talk(SAY_DOMINATION);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 50.0f))
                            me->CastSpell(target, SPELL_DOMINATION, false);
                        events.ScheduleEvent(EVENT_DOMINATION, 30000);
                        break;
                    case EVENT_FRENZY:
                        if (me->HealthBelowPct(20))
                        {
                            summons.DespawnAll();
                            me->CastSpell(me, SPELL_DISGRUNTLED_ANGER, true);
                            Talk(SAY_ENRAGE);
                            break;
                        }
                        events.ScheduleEvent(EVENT_FRENZY, 1000);
                        break;
                    case EVENT_SUMMON:
                        for (uint8 i = 0; i < DUNGEON_MODE(3, 4); ++i)
                            me->CastSpell(me, SPELL_SUMMON_NETHER_WRAITH_1+i, true);

                        Talk(SAY_SUMMON);
                        events.ScheduleEvent(EVENT_SUMMON, urand(30000, 45000));
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_pathaleon_the_calculatorAI(creature);
        }
};

void AddSC_boss_pathaleon_the_calculator()
{
    new boss_pathaleon_the_calculator();
}

