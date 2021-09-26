/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackrock_depths.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_HEAL                                             = 10917,
    SPELL_RENEW                                            = 10929,
    SPELL_SHIELD                                           = 10901,
    SPELL_MINDBLAST                                        = 10947,
    SPELL_SHADOWWORDPAIN                                   = 10894,
    SPELL_SMITE                                            = 10934
};

enum SpellTimers
{
    TIMER_HEAL        = 12000, // These times are probably wrong
    TIMER_MINDBLAST   = 16000,
    TIMER_SHADOW_WORD = 14000,
    TIMER_SMITE       = 8000,
    TIMER_SHIELD      = 12000,
    TIMER_RENEW       = 12000
};

struct boss_moira_bronzebeardAI : public BossAI
{
    boss_moira_bronzebeardAI(Creature* creature) : BossAI(creature, DATA_MOIRA) {}
    boss_moira_bronzebeardAI(Creature* creature, uint32 data) : BossAI(creature, data) {}
    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        events.ScheduleEvent(SPELL_MINDBLAST, urand(17000, 20000));
        events.ScheduleEvent(SPELL_SHADOWWORDPAIN, urand(1000, 1500));
        events.ScheduleEvent(SPELL_HEAL, urand(2000, 5000));
        events.ScheduleEvent(SPELL_SMITE, urand(4000, 8000));
        events.ScheduleEvent(SPELL_SHIELD, urand(8000, 10000));
        events.ScheduleEvent(SPELL_RENEW, urand(TIMER_RENEW, TIMER_RENEW));
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case SPELL_MINDBLAST:
                DoCastVictim(SPELL_MINDBLAST);
                events.ScheduleEvent(SPELL_MINDBLAST, urand(TIMER_MINDBLAST - 2000, TIMER_MINDBLAST + 2000));
                break;
            case SPELL_SHADOWWORDPAIN:
                DoCastVictim(SPELL_SHADOWWORDPAIN);
                events.ScheduleEvent(SPELL_SHADOWWORDPAIN, urand(TIMER_SHADOW_WORD - 2000, TIMER_SHADOW_WORD + 2000));
                break;
            case SPELL_SMITE:
                DoCastVictim(SPELL_SMITE);
                events.ScheduleEvent(SPELL_SMITE, urand(TIMER_SMITE - 2000, TIMER_SMITE + 2000));
                break;
            case SPELL_HEAL:
                CastOnEmperorIfPossible(SPELL_HEAL, TIMER_HEAL);
                break;
            case SPELL_SHIELD:
                CastOnEmperorIfPossible(SPELL_SHIELD, TIMER_SHIELD);
                break;
            case SPELL_RENEW:
                CastOnEmperorIfPossible(SPELL_RENEW, TIMER_RENEW);
            default:
                break;
            }
        }
        DoMeleeAttackIfReady();
    }

    void CastOnEmperorIfPossible(uint32 spell, uint32 timer)
    {
        Creature* emperor = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_EMPEROR));
        if (emperor && emperor->HealthBelowPct(90))
        {
            DoCast(emperor, spell);
        }
        else if (HealthBelowPct(90))
        {
            DoCastSelf(spell);
        }
        events.ScheduleEvent(spell, urand(timer - 2000, timer + 2000));
    }
};

// high priestess should be identical to Moira except that she talks on combat start.
// Running away when emperor dies is handled through GUID from emperor, therefore not relevant here.
struct boss_high_priestess_thaurissanAI : public boss_moira_bronzebeardAI
{
    boss_high_priestess_thaurissanAI(Creature* creature) : boss_moira_bronzebeardAI(creature, DATA_PRIESTESS) {}

    void EnterCombat(Unit* /*who*/) override
    {
        boss_moira_bronzebeardAI::EnterCombat(nullptr);
        Talk(0);
    }
};

class boss_moira_bronzebeard : public CreatureScript
{
public:
    boss_moira_bronzebeard() : CreatureScript("boss_moira_bronzebeard") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_moira_bronzebeardAI>(creature);
    }
};

class boss_high_priestess_thaurissan : public CreatureScript
{
public:
    boss_high_priestess_thaurissan() : CreatureScript("boss_high_priestess_thaurissan") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_high_priestess_thaurissanAI>(creature);
    }
};

void AddSC_boss_moira_bronzebeard()
{
    new boss_moira_bronzebeard();
}

void AddSC_boss_high_priestess_thaurissan()
{
    new boss_high_priestess_thaurissan();
}
