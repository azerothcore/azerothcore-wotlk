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

#include "Containers.h"
#include "molten_core.h"
#include "ObjectAccessor.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"

enum Texts
{
    EMOTE_MASS_ERRUPTION                = 0,
};

enum Spells
{
    // Garr
    SPELL_ANTIMAGIC_PULSE               = 19492,
    SPELL_MAGMA_SHACKLES                = 19496,
    SPELL_ENRAGE                        = 19516,
    //SPELL_SEPARATION_ANXIETY            = 23487,    // Aura cast on himself by Garr, if adds move out of range, they will cast spell 23492 on themselves

    // Fireworn
    SPELL_SEPARATION_ANXIETY_MINION     = 23492,
    SPELL_ERUPTION                      = 19497,
    SPELL_MASSIVE_ERUPTION              = 20483,
    SPELL_ERUPTION_TRIGGER              = 20482,    // Removes banish auras and applied immunity to banish
};

enum Events
{
    EVENT_ANTIMAGIC_PULSE    = 1,
    EVENT_MAGMA_SHACKLES,
};

class boss_garr : public CreatureScript
{
public:
    boss_garr() : CreatureScript("boss_garr") {}

    struct boss_garrAI : public BossAI
    {
        boss_garrAI(Creature* creature) : BossAI(creature, DATA_GARR),
            massEruptionTimer(600000)
        {
        }

        void Reset() override
        {
            _Reset();
            massEruptionTimer = 600000;
        }

        void EnterCombat(Unit* /*attacker*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_ANTIMAGIC_PULSE, 15000);
            events.ScheduleEvent(EVENT_MAGMA_SHACKLES, 10000);
            massEruptionTimer = 600000;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (massEruptionTimer <= diff)
            {
                Talk(EMOTE_MASS_ERRUPTION, me);
                DoCastAOE(SPELL_ERUPTION_TRIGGER, true);
                massEruptionTimer = 20000;
            }
            else
            {
                massEruptionTimer -= diff;
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

    private:
        uint32 massEruptionTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_garrAI>(creature);
    }
};

class npc_firesworn : public CreatureScript
{
public:
    npc_firesworn() : CreatureScript("npc_firesworn") {}

    struct npc_fireswornAI : public ScriptedAI
    {
        npc_fireswornAI(Creature* creature) : ScriptedAI(creature),
            instance(creature->GetInstanceScript()),
            anxietyTimer(10000),
            canErrupt(true)
        {
        }

        void EnterCombat(Unit* /*attacker*/) override {}

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            if (canErrupt && damage >= me->GetHealth() && attacker->GetGUID() != me->GetGUID())
            {
                canErrupt = false;
                DoCastAOE(SPELL_ERUPTION, true);
                Unit::Kill(attacker, me);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* garr = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_GARR)))
            {
                garr->CastSpell(garr, SPELL_ENRAGE, true);
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* pSpell) override
        {
            if (pSpell->Id == SPELL_ERUPTION_TRIGGER)
            {
                canErrupt = false;
                DoCastAOE(SPELL_MASSIVE_ERUPTION);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (anxietyTimer <= diff)
            {
                if (!me->HasAura(SPELL_SEPARATION_ANXIETY_MINION))
                {
                    if (Creature const* garr = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_GARR)))
                    {
                        if (me->IsWithinDist(garr, 45.0f))
                        {
                            DoCastSelf(SPELL_SEPARATION_ANXIETY_MINION);
                        }
                    }
                }

                anxietyTimer = 250;
            }
            else
            {
                anxietyTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    private:
        InstanceScript const* instance;
        uint32 anxietyTimer;
        bool canErrupt;
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
