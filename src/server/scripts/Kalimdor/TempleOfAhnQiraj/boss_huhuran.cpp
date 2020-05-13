/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Huhuran
SD%Complete: 100
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum Huhuran
{
    EMOTE_FRENZY_KILL           = 0,
    EMOTE_BERSERK               = 1,

    SPELL_FRENZY                = 26051,
    SPELL_BERSERK               = 26068,
    SPELL_POISONBOLT            = 26052,
    SPELL_NOXIOUSPOISON         = 26053,
    SPELL_WYVERNSTING           = 26180,
    SPELL_ACIDSPIT              = 26050
};

enum Events
{
    EVENT_FRENZY        = 1,
    EVENT_WYVERN        = 2,
    EVENT_SPIT          = 3,
    EVENT_POISONBOLT    = 4,
    EVENT_NOXIOUSPOISON = 5,
    EVENT_FRENZYBACK    = 6,
    EVENT_BERSERK       = 7
};

class boss_huhuran : public CreatureScript
{
public:
    boss_huhuran() : CreatureScript("boss_huhuran") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_huhuranAI(creature);
    }

    struct boss_huhuranAI : public ScriptedAI
    {
        boss_huhuranAI(Creature* creature) : ScriptedAI(creature)
        {
            Frenzy = false;
            Berserk = false;
        }

        void JustDied(Unit* /*killer*/) override { events.Reset(); }

        void Reset() override
        {
            events.Reset();

            Frenzy = false;
            Berserk = false;
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_FRENZY, urand(25000, 35000));
            events.ScheduleEvent(EVENT_WYVERN, urand(18000, 28000));
            events.ScheduleEvent(EVENT_SPIT, 8000);
            events.ScheduleEvent(EVENT_POISONBOLT, 4000);
            events.ScheduleEvent(EVENT_NOXIOUSPOISON, urand(10000, 20000));
            events.ScheduleEvent(EVENT_FRENZYBACK, 15000);
            events.ScheduleEvent(EVENT_BERSERK, 2000);
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            while (uint32 eventid = events.ExecuteEvent())
            {
                switch (eventid)
                {
                case EVENT_FRENZY:
                    if (!Frenzy)
                    {
                        DoCast(me, SPELL_FRENZY);
                        Talk(EMOTE_FRENZY_KILL);
                        Frenzy = true;

                        events.CancelEvent(EVENT_POISONBOLT);
                        events.ScheduleEvent(EVENT_POISONBOLT, 3000);
                    }
                    events.RepeatEvent(urand(25000, 35000));
                    break;
                case EVENT_WYVERN:
                    if (Unit* pUnit = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        DoCast(pUnit, SPELL_WYVERNSTING);
                    events.RepeatEvent(urand(15000, 32000));
                    break;
                case EVENT_SPIT:
                    DoCastVictim(SPELL_ACIDSPIT);
                    events.RepeatEvent(urand(5000, 10000));
                    break;
                case EVENT_NOXIOUSPOISON:
                    DoCastVictim(SPELL_NOXIOUSPOISON);
                    events.RepeatEvent(urand(12000, 24000));
                    break;
                case EVENT_POISONBOLT:
                    if (Frenzy || Berserk)
                    {
                        DoCastVictim(SPELL_POISONBOLT);
                        events.RepeatEvent(3000);
                    }
                    break;
                case EVENT_FRENZYBACK:
                    if (Frenzy)
                    {
                        me->InterruptNonMeleeSpells(false);
                        Frenzy = false;
                        events.RepeatEvent(15000);
                    }
                    break;
                case EVENT_BERSERK:
                    if (!Berserk && HealthBelowPct(31))
                    {
                        me->InterruptNonMeleeSpells(false);
                        Talk(EMOTE_BERSERK);
                        DoCast(me, SPELL_BERSERK);
                        Berserk = true;
                    }
                    events.RepeatEvent(2000);
                    break;
                }
            }
            if (!Berserk && HealthBelowPct(31))
            {
                me->InterruptNonMeleeSpells(false);
                Talk(EMOTE_BERSERK);
                DoCast(me, SPELL_BERSERK);
                Berserk = true;
            }

            DoMeleeAttackIfReady();
        }
    private:
        EventMap events;
        bool Frenzy;
        bool Berserk;

    };

};

void AddSC_boss_huhuran()
{
    new boss_huhuran();
}
