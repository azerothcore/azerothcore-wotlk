/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: boss_kri, boss_yauj, boss_vem : The Bug Trio
SD%Complete: 100
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_CLEAVE       = 26350,
    SPELL_TOXIC_VOLLEY = 25812,
    SPELL_POISON_CLOUD = 38718, //Only Spell with right dmg.
    SPELL_ENRAGE       = 34624, //Changed cause 25790 is cast on gamers too. Same prob with old explosion of twin emperors.

    SPELL_CHARGE       = 26561,
    SPELL_KNOCKBACK    = 26027,

    SPELL_HEAL         = 25807,
    SPELL_FEAR         = 19408
};

enum Events
{
    // Kri
    EVENT_KRI_CLEAVE      = 1,
    EVENT_KRI_TOXICVOLLEY = 2,
    EVENT_KRI_CHECK       = 3,

    // Vem
    EVENT_VEM_CHARGE      = 1,
    EVENT_VEM_KNOCKBACK   = 2,
    EVENT_VEM_ENRAGE      = 3,

    // Yauj
    EVENT_YAUJ_HEAL       = 1,
    EVENT_YAUJ_FEAR       = 2,
    EVENT_YAUJ_CHECK      = 3
};

class boss_kri : public CreatureScript
{
public:
    boss_kri() : CreatureScript("boss_kri") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_kriAI>(creature);
    }

    struct boss_kriAI : public ScriptedAI
    {
        boss_kriAI(Creature* creature) : ScriptedAI(creature)
        {
            VemDead = false;
            Death = false;

            instance = creature->GetInstanceScript();
        }

        bool VemDead;
        bool Death;

        void Reset() override
        {
            events.Reset();

            VemDead = false;
            Death = false;
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_KRI_CLEAVE, urand(4000, 8000));
            events.ScheduleEvent(EVENT_KRI_TOXICVOLLEY, urand(6000, 12000));
            events.ScheduleEvent(EVENT_KRI_CHECK, 2000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (instance->GetData(DATA_BUG_TRIO_DEATH) < 2)// Unlootable if death
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);

            instance->SetData(DATA_BUG_TRIO_DEATH, 1);
        }
        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (!HealthAbovePct(5) && !Death)
            {
                DoCastVictim(SPELL_POISON_CLOUD);
                Death = true;
            }

            events.Update(diff);

            while (uint32 eventid = events.ExecuteEvent())
            {
                switch (eventid)
                {
                case EVENT_KRI_CLEAVE:
                    DoCastVictim(SPELL_CLEAVE);
                    events.RepeatEvent(urand(5000, 12000));
                    break;
                case EVENT_KRI_TOXICVOLLEY:
                    DoCastVictim(SPELL_TOXIC_VOLLEY);
                    events.RepeatEvent(urand(10000, 15000));
                    break;
                case EVENT_KRI_CHECK:
                    if (!VemDead)
                    {
                        if (instance->GetData(DATA_VEMISDEAD))
                        {
                            DoCast(me, SPELL_ENRAGE);
                            VemDead = true;
                        }
                    }
                    events.RepeatEvent(2000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        InstanceScript* instance;

    };

};

class boss_vem : public CreatureScript
{
public:
    boss_vem() : CreatureScript("boss_vem") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_vemAI>(creature);
    }

    struct boss_vemAI : public ScriptedAI
    {
        boss_vemAI(Creature* creature) : ScriptedAI(creature)
        {
            Enraged = false;

            instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            events.Reset();

            Enraged = false;
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetData(DATA_VEM_DEATH, 0);
            if (instance->GetData(DATA_BUG_TRIO_DEATH) < 2)// Unlootable if death
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
            instance->SetData(DATA_BUG_TRIO_DEATH, 1);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_VEM_CHARGE, urand(15000, 27000));
            events.ScheduleEvent(EVENT_VEM_KNOCKBACK, urand(8000, 20000));
            events.ScheduleEvent(EVENT_VEM_ENRAGE, 120000);
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
                case EVENT_VEM_CHARGE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    {
                        DoCast(target, SPELL_CHARGE);
                        AttackStart(target);
                    }
                    events.RepeatEvent(urand(8000, 16000));
                    break;
                case EVENT_VEM_KNOCKBACK:
                    DoCastVictim(SPELL_KNOCKBACK);
                    if (DoGetThreat(me->GetVictim()))
                        DoModifyThreatPercent(me->GetVictim(), -80);
                    events.RepeatEvent(urand(15000, 25000));
                    break;
                case EVENT_VEM_ENRAGE:
                    if (!Enraged)
                    {
                        DoCast(me, SPELL_ENRAGE);
                        Enraged = true;
                    }
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    private:
        EventMap events;
        InstanceScript* instance;
        bool Enraged;

    };

};

class boss_yauj : public CreatureScript
{
public:
    boss_yauj() : CreatureScript("boss_yauj") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_yaujAI>(creature);
    }

    struct boss_yaujAI : public ScriptedAI
    {
        boss_yaujAI(Creature* creature) : ScriptedAI(creature)
        {
            VemDead = false;

            instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            events.Reset();

            VemDead = false;
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (instance->GetData(DATA_BUG_TRIO_DEATH) < 2)// Unlootable if death
                me->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
            instance->SetData(DATA_BUG_TRIO_DEATH, 1);

            for (uint8 i = 0; i < 10; ++i)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                {
                    if (Creature* Summoned = me->SummonCreature(15621, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 90000))
                        Summoned->AI()->AttackStart(target);
                }
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            events.ScheduleEvent(EVENT_YAUJ_HEAL, urand(25000, 40000));
            events.ScheduleEvent(EVENT_YAUJ_FEAR, urand(12000, 24000));
            events.ScheduleEvent(EVENT_YAUJ_CHECK, 2000);
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
                case EVENT_YAUJ_FEAR:
                    DoCastVictim(SPELL_FEAR);
                    DoResetThreat();
                    events.RepeatEvent(20000);
                    break;
                case EVENT_YAUJ_HEAL:
                    switch (urand(0, 2))
                    {
                        case 0:
                            if (Creature* kri = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_KRI)))
                                DoCast(kri, SPELL_HEAL);
                            break;
                        case 1:
                            if (Creature* vem = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_VEM)))
                                DoCast(vem, SPELL_HEAL);
                            break;
                        case 2:
                            DoCast(me, SPELL_HEAL);
                            break;
                    }
                    events.RepeatEvent(15000 + rand() % 15000);
                    break;
                case EVENT_YAUJ_CHECK:
                    if (!VemDead)
                    {
                        if (instance->GetData(DATA_VEMISDEAD))
                        {
                            DoCast(me, SPELL_ENRAGE);
                            VemDead = true;
                        }
                    }
                    events.RepeatEvent(2000);
                    break;
                }
            }


            DoMeleeAttackIfReady();
        }
    private:
        EventMap events;
        InstanceScript* instance;
        bool VemDead;
    };

};

void AddSC_bug_trio()
{
    new boss_kri();
    new boss_vem();
    new boss_yauj();
}
