/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "CreatureTextMgr.h"
#include "ObjectMgr.h"
#include "ruins_of_ahnqiraj.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_MORTALWOUND       = 25646,
    SPELL_SANDTRAP          = 25648,
    SPELL_ENRAGE            = 26527,
    SPELL_SUMMON_PLAYER     = 26446,
    SPELL_TRASH             =  3391, // Should perhaps be triggered by an aura? Couldn't find any though
    SPELL_WIDE_SLASH        = 25814
};

enum Events
{
    EVENT_MORTAL_WOUND      = 1,
    EVENT_SANDTRAP          = 2,
    EVENT_TRASH             = 3,
    EVENT_WIDE_SLASH        = 4
};

enum Texts
{
    SAY_KURINAXX_DEATH      = 5, // Yelled by Ossirian the Unscarred
};

class boss_kurinnaxx : public CreatureScript
{
public:
    boss_kurinnaxx() : CreatureScript("boss_kurinnaxx") { }

    struct boss_kurinnaxxAI : public BossAI
    {
        boss_kurinnaxxAI(Creature* creature) : BossAI(creature, DATA_KURINNAXX)
        {
        }

        void Reset() override
        {
            _Reset();
            _enraged = false;
            events.ScheduleEvent(EVENT_MORTAL_WOUND, 8000);
            events.ScheduleEvent(EVENT_SANDTRAP, urand(5000, 15000));
            events.ScheduleEvent(EVENT_TRASH, 1000);
            events.ScheduleEvent(EVENT_WIDE_SLASH, 11000);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (!_enraged && HealthBelowPct(30))
            {
                DoCast(me, SPELL_ENRAGE);
                _enraged = true;
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            if (Creature* Ossirian = me->GetMap()->GetCreature(instance->GetGuidData(DATA_OSSIRIAN)))
                sCreatureTextMgr->SendChat(Ossirian, SAY_KURINAXX_DEATH, nullptr, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_ZONE);
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
                    case EVENT_MORTAL_WOUND:
                        DoCastVictim(SPELL_MORTALWOUND);
                        events.ScheduleEvent(EVENT_MORTAL_WOUND, 8000);
                        break;
                    case EVENT_SANDTRAP:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            target->CastSpell(target, SPELL_SANDTRAP, true);
                        else if (Unit* victim = me->GetVictim())
                            victim->CastSpell(victim, SPELL_SANDTRAP, true);
                        events.ScheduleEvent(EVENT_SANDTRAP, urand(5000, 15000));
                        break;
                    case EVENT_WIDE_SLASH:
                        DoCast(me, SPELL_WIDE_SLASH);
                        events.ScheduleEvent(EVENT_WIDE_SLASH, 11000);
                        break;
                    case EVENT_TRASH:
                        DoCast(me, SPELL_TRASH);
                        events.ScheduleEvent(EVENT_WIDE_SLASH, 16000);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    private:
        bool _enraged;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetRuinsOfAhnQirajAI<boss_kurinnaxxAI>(creature);
    }
};

void AddSC_boss_kurinnaxx()
{
    new boss_kurinnaxx();
}
