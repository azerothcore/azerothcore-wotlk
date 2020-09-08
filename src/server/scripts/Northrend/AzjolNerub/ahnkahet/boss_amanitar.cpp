/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"

enum Spells
{
    SPELL_BASH                              = 57094,
    SPELL_ENTANGLING_ROOTS                  = 57095,
    SPELL_MINI                              = 57055,
    SPELL_VENOM_BOLT_VOLLEY                 = 57088,
    SPELL_HEALTHY_MUSHROOM_POTENT_FUNGUS    = 56648,
    SPELL_POISONOUS_MUSHROOM_POISON_CLOUD   = 57061,
    SPELL_POISONOUS_MUSHROOM_VISUAL_AURA    = 56741,
    SPELL_HEALTHY_MUSHROOM_VISUAL_AURA      = 56740,
};

enum Creatures
{
    NPC_HEALTHY_MUSHROOM                    = 30391,
    NPC_POISONOUS_MUSHROOM                  = 30435
};

enum Events
{
    EVENT_AMANITAR_SPAWN                    = 1,
    EVENT_AMANITAR_ROOTS                    = 2,
    EVENT_AMANITAR_BASH                     = 3,
    EVENT_AMANITAR_BOLT                     = 4,
    EVENT_AMANITAR_MINI                     = 5
};

class boss_amanitar : public CreatureScript
{
public:
    boss_amanitar() : CreatureScript("boss_amanitar") { }

    struct boss_amanitarAI : public ScriptedAI
    {
        boss_amanitarAI(Creature *c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
            me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            me->SetMeleeDamageSchool(SPELL_SCHOOL_NATURE);

            if (pInstance)
            {
                pInstance->SetData(DATA_AMANITAR_EVENT, NOT_STARTED);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MINI);
            }
        }

        void JustDied(Unit* /*Killer*/)
        {
            summons.DespawnAll();
            if (pInstance)
            {
                pInstance->SetData(DATA_AMANITAR_EVENT, DONE);
                pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_MINI);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (pInstance)
                pInstance->SetData(DATA_AMANITAR_EVENT, IN_PROGRESS);

            events.ScheduleEvent(EVENT_AMANITAR_ROOTS, urand(5000, 9000));
            events.ScheduleEvent(EVENT_AMANITAR_BASH, urand(10000, 14000));
            events.ScheduleEvent(EVENT_AMANITAR_BOLT, urand(15000, 20000));
            events.ScheduleEvent(EVENT_AMANITAR_MINI, 30000);
            events.ScheduleEvent(EVENT_AMANITAR_SPAWN, 0);
        }

        void JustSummoned(Creature *cr) { summons.Summon(cr); }

        void SpawnAdds()
        {
            summons.DespawnAll();
            Position center;
            center.Relocate(362.6f, -870, -75);

            for (uint8 i = 0; i < 25; ++i)
            {
                float orientation = 2*rand_norm()*M_PI;
                float x = center.GetPositionX() + i*2*cos(orientation);
                float y = center.GetPositionY() + i*2*sin(orientation);
                me->SummonCreature(NPC_POISONOUS_MUSHROOM, x, y, me->GetMap()->GetHeight(x, y, MAX_HEIGHT));
            }

            for (uint8 i = 0; i < 25; ++i)
            {
                float orientation = 2*rand_norm()*M_PI;
                float x = center.GetPositionX() + i*2*cos(orientation);
                float y = center.GetPositionY() + i*2*sin(orientation);
                me->SummonCreature(NPC_HEALTHY_MUSHROOM, x, y, me->GetMap()->GetHeight(x, y, MAX_HEIGHT));
            }
        }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_AMANITAR_SPAWN:
                {
                    SpawnAdds();
                    events.RepeatEvent(urand(35000, 40000));
                    break;
                }
                case EVENT_AMANITAR_ROOTS:
                {
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        me->CastSpell(pTarget, SPELL_ENTANGLING_ROOTS, false);

                    events.RepeatEvent(urand(15000, 20000));
                    break;
                }
                case EVENT_AMANITAR_BASH:
                {
                    me->CastSpell(me->GetVictim(), SPELL_BASH, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                }
                case EVENT_AMANITAR_BOLT:
                {
                    if (Unit *pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        me->CastSpell(pTarget, SPELL_VENOM_BOLT_VOLLEY, false);
                    
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                }
                case EVENT_AMANITAR_MINI:
                {
                    me->CastSpell(me, SPELL_MINI, false);
                    events.RepeatEvent(30000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_amanitarAI(creature);
    }
};

class npc_amanitar_mushrooms : public CreatureScript
{
public:
    npc_amanitar_mushrooms() : CreatureScript("npc_amanitar_mushrooms") { }

    struct npc_amanitar_mushroomsAI : public ScriptedAI
    {
        npc_amanitar_mushroomsAI(Creature* c) : ScriptedAI(c)
        {
            SetCombatMovement(false);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        uint32 Timer;
        void Reset()
        {
            me->CastSpell(me, 31690, true);

            Timer = 0;
            if (me->GetEntry() == NPC_POISONOUS_MUSHROOM)
            {
                me->CastSpell(me, SPELL_POISONOUS_MUSHROOM_VISUAL_AURA, true);
                me->CastSpell(me, SPELL_POISONOUS_MUSHROOM_POISON_CLOUD, false);
            }
            else
                me->CastSpell(me, SPELL_HEALTHY_MUSHROOM_VISUAL_AURA, true);
        }

        void JustDied(Unit* killer)
        {
            if (!killer)
                return;

            if (me->GetEntry() == NPC_HEALTHY_MUSHROOM)
            {
                if (killer->HasAura(SPELL_MINI))
                {
                    killer->RemoveAurasDueToSpell(SPELL_MINI);
                }
                else
                {
                    DoCast(killer, SPELL_HEALTHY_MUSHROOM_POTENT_FUNGUS);
                }
            }
        }

        void EnterCombat(Unit* /*who*/) {}
        void AttackStart(Unit* /*victim*/) {}

        void UpdateAI(uint32 diff)
        {
            if (me->GetEntry() == NPC_POISONOUS_MUSHROOM)
            {
                Timer += diff;
                if (Timer >= 7000)
                {
                    me->CastSpell(me, SPELL_POISONOUS_MUSHROOM_POISON_CLOUD, false);
                    Timer = 0;
                }
            }
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_amanitar_mushroomsAI(creature);
    }
};

void AddSC_boss_amanitar()
{
    new boss_amanitar;
    new npc_amanitar_mushrooms;
}
