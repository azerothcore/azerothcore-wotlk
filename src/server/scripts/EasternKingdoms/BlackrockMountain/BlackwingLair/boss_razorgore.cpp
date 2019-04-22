/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "blackwing_lair.h"
#include "Player.h"

enum Say
{
    SAY_EGGS_BROKEN1        = 0,
    SAY_EGGS_BROKEN2        = 1,
    SAY_EGGS_BROKEN3        = 2,
    SAY_DEATH               = 3,
};

enum GrethokTalk
{
    SAY_GRETHOK_DEATH = 0,
};

enum Spells
{
    SPELL_MINDCONTROL       = 42013,
    SPELL_CHANNEL           = 45537,
    SPELL_EGG_DESTROY       = 19873,

    SPELL_CLEAVE            = 22540,
    SPELL_WARSTOMP          = 24375,
    SPELL_FIREBALLVOLLEY    = 22425,
    SPELL_CONFLAGRATION     = 23023,

    SPELL_GRETHOK_GREATER_POLYMORPH = 22274,
    SPELL_GRETHOK_DOMINATE_MIND     = 14515,
    SPELL_GRETHOK_SLOW              = 13747,
    SPELL_GRETHOK_ARCANE_MISSILES   = 22273,
};

enum Summons
{
    NPC_ELITE_DRACHKIN      = 12422,
    NPC_ELITE_WARRIOR       = 12458,
    NPC_WARRIOR             = 12416,
    NPC_MAGE                = 12420,
    NPC_WARLOCK             = 12459,

    GO_EGG                  = 177807
};

enum EVENTS
{
    EVENT_CLEAVE            = 1,
    EVENT_STOMP             = 2,
    EVENT_FIREBALL          = 3,
    EVENT_CONFLAGRATION     = 4,
    EVENT_RAZOR_SPAWN       = 5,
    EVENT_GRETHOK_SPELL_GP  = 6,
    EVENT_GRETHOK_SPELL_DM  = 7,
    EVENT_GRETHOK_SPELL_S   = 8,
    EVENT_GRETHOK_SPELL_AM  = 9,
};

Position const SummonPosition[8] =
{
    {-7661.207520f, -1043.268188f, 407.199554f, 6.280452f},
    {-7644.145020f, -1065.628052f, 407.204956f, 0.501492f},
    {-7624.260742f, -1095.196899f, 407.205017f, 0.544694f},
    {-7608.501953f, -1116.077271f, 407.199921f, 0.816443f},
    {-7531.841797f, -1063.765381f, 407.199615f, 2.874187f},
    {-7547.319336f, -1040.971924f, 407.205078f, 3.789175f},
    {-7568.547852f, -1013.112488f, 407.204926f, 3.773467f},
    {-7584.175781f, -989.6691289f, 407.199585f, 4.527447f},
};

uint32 const Entry[5] = { 12422, 12458, 12416, 12420, 12459 };

class boss_razorgore : public CreatureScript
{
public:
    boss_razorgore() : CreatureScript("boss_razorgore") { }

    struct boss_razorgoreAI : public BossAI
    {
        boss_razorgoreAI(Creature* creature) : BossAI(creature, BOSS_RAZORGORE) , summons(me) { }

        void Reset()
        {
            _Reset();
            summons.DespawnAll();
            secondPhase = false;
            instance->SetData(DATA_EGG_EVENT, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();
            Talk(SAY_DEATH);

            instance->SetData(DATA_EGG_EVENT, NOT_STARTED);
        }

        void DoChangePhase()
        {
            events.ScheduleEvent(EVENT_CLEAVE, 15000);
            events.ScheduleEvent(EVENT_STOMP, 35000);
            events.ScheduleEvent(EVENT_FIREBALL, 7000);
            events.ScheduleEvent(EVENT_CONFLAGRATION, 12000);
            events.CancelEvent(EVENT_RAZOR_SPAWN);

            secondPhase = true;
            me->RemoveAllAuras();
            me->SetHealth(me->GetMaxHealth());
        }

        void DoAction(int32 action)
        {
            if (action == ACTION_PHASE_TWO)
                DoChangePhase();
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (!secondPhase)
                damage = 0;
        }

        void UpdateAI(uint32 diff)
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
                    case EVENT_RAZOR_SPAWN:
                        for (uint8 i = urand(2, 5); i > 0; --i)
                            if (Creature* cr = me->SummonCreature(Entry[urand(0, 4)], SummonPosition[urand(0, 7)]))
                            {
                                cr->SetInCombatWithZone();
                                summons.Summon(cr);
                            }
                        events.ScheduleEvent(EVENT_RAZOR_SPAWN, urand(12, 17)*IN_MILLISECONDS);
                        break;
                    case EVENT_CLEAVE:
                        DoCastVictim(SPELL_CLEAVE);
                        events.ScheduleEvent(EVENT_CLEAVE, urand(7000, 10000));
                        break;
                    case EVENT_STOMP:
                        DoCastVictim(SPELL_WARSTOMP);
                        events.ScheduleEvent(EVENT_STOMP, urand(15000, 25000));
                        break;
                    case EVENT_FIREBALL:
                        DoCastVictim(SPELL_FIREBALLVOLLEY);
                        events.ScheduleEvent(EVENT_FIREBALL, urand(12000, 15000));
                        break;
                    case EVENT_CONFLAGRATION:
                        DoCastVictim(SPELL_CONFLAGRATION);
                        if (me->GetVictim() && me->GetVictim()->HasAura(SPELL_CONFLAGRATION))
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 100, true))
                                me->TauntApply(target);
                        events.ScheduleEvent(EVENT_CONFLAGRATION, 30000);
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

    private:
        bool secondPhase;
        SummonList summons;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_razorgoreAI>(creature);
    }
};

class boss_grethok : public CreatureScript
{
public:
    boss_grethok() : CreatureScript("boss_grethok") { }

    struct boss_grethokAI : public BossAI
    {
        boss_grethokAI(Creature* creature) : BossAI(creature, NPC_RAZORGORE) { }

        EventMap events;

        void Reset() override
        {
            instance->SetBossState(DATA_RAZORGORE_THE_UNTAMED, NOT_STARTED);
            me->HandleEmoteCommand(EMOTE_STATE_SPELL_CHANNEL_DIRECTED);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_GRETHOK_DEATH);
        }

        void EnterCombat(Unit * who) override
        {
            instance->SetBossState(DATA_RAZORGORE_THE_UNTAMED, IN_PROGRESS);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_GRETHOK_SPELL_AM:
                    DoCastVictim(SPELL_GRETHOK_ARCANE_MISSILES);
                    events.ScheduleEvent(EVENT_GRETHOK_SPELL_AM, urand(12500, 14000));
                    break;
                case EVENT_GRETHOK_SPELL_S:
                    DoCastVictim(SPELL_GRETHOK_SLOW);
                    events.ScheduleEvent(EVENT_GRETHOK_SPELL_S, urand(20000, 21000));
                    break;
                case EVENT_GRETHOK_SPELL_DM:
                    DoCastVictim(SPELL_GRETHOK_DOMINATE_MIND);
                    events.ScheduleEvent(EVENT_GRETHOK_SPELL_DM, urand(20000, 21000));
                    break;
                case EVENT_GRETHOK_SPELL_GP:
                    DoCastVictim(SPELL_GRETHOK_GREATER_POLYMORPH);
                    events.ScheduleEvent(EVENT_GRETHOK_SPELL_GP, urand(5000, 10000));
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_grethokAI>(creature);
    }
};

class go_orb_of_domination : public GameObjectScript
{
public:
    go_orb_of_domination() : GameObjectScript("go_orb_of_domination") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
            if (instance->GetData(DATA_EGG_EVENT) != DONE)
                if (Creature* razor = ObjectAccessor::GetCreature(*go, instance->GetData64(DATA_RAZORGORE_THE_UNTAMED)))
                {
                    razor->Attack(player, true);
                    player->CastSpell(razor, SPELL_MINDCONTROL);
                }
        return true;
    }
};

class spell_egg_event : public SpellScriptLoader
{
    public:
        spell_egg_event() : SpellScriptLoader("spell_egg_event") { }

        class spell_egg_eventSpellScript : public SpellScript
        {
            PrepareSpellScript(spell_egg_eventSpellScript);

            void HandleOnHit()
            {
                if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                    instance->SetData(DATA_EGG_EVENT, SPECIAL);
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_egg_eventSpellScript::HandleOnHit);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_egg_eventSpellScript();
        }
};

void AddSC_boss_razorgore()
{
    new boss_grethok();
    new boss_razorgore();
    new go_orb_of_domination();
    new spell_egg_event();
}
