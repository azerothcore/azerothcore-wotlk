/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Garr
SD%Complete: 50
SDComment: Adds NYI
SDCategory: Molten Core
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Spells
{
    // Garr
    SPELL_ANTIMAGIC_PULSE   = 19492,
    SPELL_MAGMA_SHACKLES    = 19496,
    SPELL_ENRAGE            = 19516,

    // Adds
    SPELL_ERUPTION          = 19497,
    SPELL_IMMOLATE          = 20294,
};

enum Events
{
    EVENT_ANTIMAGIC_PULSE    = 1,
    EVENT_MAGMA_SHACKLES     = 2,
};

class boss_garr : public CreatureScript
{
public:
    boss_garr() : CreatureScript("boss_garr") { }

    struct boss_garrAI : public BossAI
    {
        boss_garrAI(Creature* creature) : BossAI(creature, BOSS_GARR)
        {
        }

        void EnterCombat(Unit* /*attacker*/)
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_ANTIMAGIC_PULSE, 15000);
            events.ScheduleEvent(EVENT_MAGMA_SHACKLES, 10000);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ANTIMAGIC_PULSE:
                    {
                        DoCastSelf(SPELL_ANTIMAGIC_PULSE);
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_MAGMA_SHACKLES:
                    {
                        DoCastSelf(SPELL_MAGMA_SHACKLES);
                        events.RepeatEvent(15000);
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_garrAI>(creature);
    }
};

class npc_firesworn : public CreatureScript
{
public:
    npc_firesworn() : CreatureScript("npc_firesworn") { }

    struct npc_fireswornAI : public ScriptedAI
    {
        npc_fireswornAI(Creature* creature) : ScriptedAI(creature),
            immolateTimer(4000)
        {
        }

        void Reset() override
        {
            immolateTimer = 4000;   // These times are probably wrong
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (me->HealthBelowPctDamaged(10, damage))
            {
                damage = 0;
                DoCastVictim(SPELL_ERUPTION);
                me->DespawnOrUnsummon();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (immolateTimer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    DoCast(target, SPELL_IMMOLATE);

                immolateTimer = urand(5000, 10000);
            }
            else
            {
                immolateTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint32 immolateTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_fireswornAI>(creature);
    }
};

void AddSC_boss_garr()
{
    new boss_garr();
    new npc_firesworn();
}
