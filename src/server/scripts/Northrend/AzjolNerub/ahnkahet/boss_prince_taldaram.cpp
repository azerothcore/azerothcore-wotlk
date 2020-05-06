/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"
#include "SpellInfo.h"

enum Spells
{
    SPELL_BLOODTHIRST                       = 55968, //Trigger Spell + add aura
    SPELL_CONJURE_FLAME_SPHERE              = 55931,
    SPELL_FLAME_SPHERE_SPAWN_EFFECT         = 55891,
    SPELL_FLAME_SPHERE_VISUAL               = 55928,
    SPELL_FLAME_SPHERE_PERIODIC             = 55926,
    SPELL_FLAME_SPHERE_PERIODIC_H           = 59508,
    SPELL_FLAME_SPHERE_DEATH_EFFECT         = 55947,
    SPELL_BEAM_VISUAL                       = 60342,
    SPELL_EMBRACE_OF_THE_VAMPYR             = 55959,
    SPELL_EMBRACE_OF_THE_VAMPYR_H           = 59513,
    SPELL_VANISH                            = 55964,
    CREATURE_FLAME_SPHERE                   = 30106,
    CREATURE_FLAME_SPHERE_1                 = 31686,
    CREATURE_FLAME_SPHERE_2                 = 31687,
};
enum Misc
{
    DATA_EMBRACE_DMG                        = 20000,
    DATA_EMBRACE_DMG_H                      = 40000,
    DATA_SPHERE_DISTANCE                    = 30,
    ACTION_FREE                             = 1,
    ACTION_SPHERE                           = 2,
};

enum Event
{
    EVENT_PRINCE_FLAME_SPHERES              = 1,
    EVENT_PRINCE_VANISH                     = 2,
    EVENT_PRINCE_BLOODTHIRST                = 3,
    EVENT_PRINCE_VANISH_RUN                 = 4,
    EVENT_PRINCE_RESCHEDULE                 = 5,
};

#define DATA_GROUND_POSITION_Z             11.4f

enum Yells
{
    SAY_1                                         = 0,
    SAY_WARNING                                   = 1,
    SAY_AGGRO                                     = 2,
    SAY_SLAY                                      = 3,
    SAY_DEATH                                     = 4,
    SAY_FEED                                      = 5,
    SAY_VANISH                                    = 6,
};

class boss_taldaram : public CreatureScript
{
public:
    boss_taldaram() : CreatureScript("boss_taldaram") { }

    struct boss_taldaramAI : public ScriptedAI
    {
        boss_taldaramAI(Creature *c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint64 vanishTarget;
        uint32 vanishDamage;

        void Reset()
        {
            if (me->GetPositionZ() > 15.0f)
                me->CastSpell(me, SPELL_BEAM_VISUAL, true);

            events.Reset();
            summons.DespawnAll();
            vanishDamage = 0;
            vanishTarget = 0;

            if (pInstance)
            {
                pInstance->SetData(DATA_PRINCE_TALDARAM_EVENT, NOT_STARTED);

                // Event not started
                if (pInstance->GetData(DATA_SPHERE_EVENT) == DONE)
                    DoAction(ACTION_FREE);
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_FREE)
            {
                me->RemoveAllAuras();
                me->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);

                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), DATA_GROUND_POSITION_Z, me->GetOrientation());
                me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), DATA_GROUND_POSITION_Z, me->GetOrientation(), true);

                if (pInstance)
                    pInstance->HandleGameObject(pInstance->GetData64(DATA_PRINCE_TALDARAM_PLATFORM), true);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (pInstance)
                pInstance->SetData(DATA_PRINCE_TALDARAM_EVENT, IN_PROGRESS);

            Talk(SAY_AGGRO);
            ScheduleEvents();

            me->RemoveAllAuras();
            me->InterruptNonMeleeSpells(true);
        }

        void ScheduleEvents()
        {
            events.Reset();
            events.ScheduleEvent(EVENT_PRINCE_FLAME_SPHERES, 10000);
            events.ScheduleEvent(EVENT_PRINCE_BLOODTHIRST, 10000);
            vanishTarget = 0;
            vanishDamage = 0;
        }

        void SpellHitTarget(Unit *, const SpellInfo *spellInfo)
        {
            if (spellInfo->Id == SPELL_CONJURE_FLAME_SPHERE)
                summons.DoAction(ACTION_SPHERE);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_PRINCE_BLOODTHIRST:
                {
                    me->CastSpell(me->GetVictim(), SPELL_BLOODTHIRST, false);
                    events.RepeatEvent(10000);
                    break;
                }
                case EVENT_PRINCE_FLAME_SPHERES:
                {
                    me->CastSpell(me->GetVictim(), SPELL_CONJURE_FLAME_SPHERE, false);
                    events.RescheduleEvent(EVENT_PRINCE_VANISH, 14000);
                    Creature *cr;
                    if ((cr = me->SummonCreature(CREATURE_FLAME_SPHERE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+5.0f, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 10*IN_MILLISECONDS)))
                        summons.Summon(cr);

                    if (me->GetMap()->IsHeroic())
                    {
                        if ((cr = me->SummonCreature(CREATURE_FLAME_SPHERE_1, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+5.0f, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 10*IN_MILLISECONDS)))
                            summons.Summon(cr);

                        if ((cr = me->SummonCreature(CREATURE_FLAME_SPHERE_2, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+5.0f, 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 10*IN_MILLISECONDS)))
                            summons.Summon(cr);
                    }
                    events.RepeatEvent(15000);
                    break;
                }
                case EVENT_PRINCE_VANISH:
                {
                    events.PopEvent();
                    //Count alive players
                    uint8 count = 0;
                    Unit *pTarget;
                    std::list<HostileReference *> t_list = me->getThreatManager().getThreatList();
                    for (std::list<HostileReference *>::const_iterator itr = t_list.begin(); itr!= t_list.end(); ++itr)
                    {
                        pTarget = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid());
                        if (pTarget && pTarget->GetTypeId() == TYPEID_PLAYER && pTarget->IsAlive())
                            count++;
                    }
                    //He only vanishes if there are 3 or more alive players
                    if (count > 2)
                    {
                        Talk(SAY_VANISH);
                        me->CastSpell(me, SPELL_VANISH, false);

                        events.CancelEvent(EVENT_PRINCE_FLAME_SPHERES);
                        events.CancelEvent(EVENT_PRINCE_BLOODTHIRST);
                        events.ScheduleEvent(EVENT_PRINCE_VANISH_RUN, 2499);
                        if (Unit* pEmbraceTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                            vanishTarget = pEmbraceTarget->GetGUID();
                    }
                    break;
                }
                case EVENT_PRINCE_VANISH_RUN:
                {
                    if (Unit *vT = ObjectAccessor::GetUnit(*me, vanishTarget))
                    {
                        me->UpdatePosition(vT->GetPositionX(), vT->GetPositionY(), vT->GetPositionZ(), me->GetAngle(vT), true);
                        me->CastSpell(vT, SPELL_EMBRACE_OF_THE_VAMPYR, false);
                        me->RemoveAura(SPELL_VANISH);
                    }

                    events.PopEvent();
                    events.ScheduleEvent(EVENT_PRINCE_RESCHEDULE, 20000);
                    break;
                }
                case EVENT_PRINCE_RESCHEDULE:
                {
                    events.PopEvent();
                    ScheduleEvents();
                    break;
                }
            }

            if (me->IsVisible())
                DoMeleeAttackIfReady();
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (vanishTarget)
            {
                vanishDamage += damage;
                if (vanishDamage > (uint32) DUNGEON_MODE(DATA_EMBRACE_DMG, DATA_EMBRACE_DMG_H))
                {
                    ScheduleEvents();
                    me->CastStop();
                }
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);

            if (pInstance)
                pInstance->SetData(DATA_PRINCE_TALDARAM_EVENT, DONE);
        }

        void KilledUnit(Unit * victim)
        {
            if (urand(0,1))
                return;

            if (vanishTarget && victim->GetGUID() == vanishTarget)
                ScheduleEvents();

            Talk(SAY_SLAY);
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_taldaramAI(creature);
    }
};

class npc_taldaram_flamesphere : public CreatureScript
{
public:
    npc_taldaram_flamesphere() : CreatureScript("npc_taldaram_flamesphere") { }

    struct npc_taldaram_flamesphereAI : public ScriptedAI
    {
        npc_taldaram_flamesphereAI(Creature *c) : ScriptedAI(c)
        {
        }

        uint32 uiDespawnTimer;

        void DoAction(int32 param)
        {
            if (param == ACTION_SPHERE)
            {
                me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_FLAME_SPHERE_PERIODIC_H : SPELL_FLAME_SPHERE_PERIODIC, true);

                float angle = rand_norm()*2*M_PI;
                float x = me->GetPositionX() + DATA_SPHERE_DISTANCE * cos(angle);
                float y = me->GetPositionY() + DATA_SPHERE_DISTANCE * sin(angle);
                me->GetMotionMaster()->MovePoint(0, x, y, me->GetPositionZ());
            }
        }

        void MovementInform(uint32  /*type*/, uint32 id)
        {
            if (id == 0)
                me->DisappearAndDie();
        }

        void Reset()
        {
            me->CastSpell(me, SPELL_FLAME_SPHERE_SPAWN_EFFECT, true);
            me->CastSpell(me, SPELL_FLAME_SPHERE_VISUAL, true);
            uiDespawnTimer = 13*IN_MILLISECONDS;
        }

        void EnterCombat(Unit * /*who*/) {}
        void MoveInLineOfSight(Unit * /*who*/) {}

        void JustDied(Unit* /*who*/)
        {
            me->CastSpell(me, SPELL_FLAME_SPHERE_DEATH_EFFECT, true);
        }

        void UpdateAI(uint32 diff)
        {
            if (uiDespawnTimer <= diff)
                me->DisappearAndDie();
            else
                uiDespawnTimer -= diff;
        }
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_taldaram_flamesphereAI(creature);
    }
};

class go_prince_taldaram_sphere : public GameObjectScript
{
public:
    go_prince_taldaram_sphere() : GameObjectScript("go_prince_taldaram_sphere") { }

    bool OnGossipHello(Player * /*pPlayer*/, GameObject *go) override
    {
        InstanceScript *pInstance = go->GetInstanceScript();
        if (!pInstance)
            return false;

        Creature *pPrinceTaldaram = ObjectAccessor::GetCreature(*go, pInstance->GetData64(DATA_PRINCE_TALDARAM));
        if (pPrinceTaldaram && pPrinceTaldaram->IsAlive())
        {
            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
            go->SetGoState(GO_STATE_ACTIVE);

            if (pInstance->GetData(DATA_SPHERE_EVENT) == NOT_STARTED)
            {
                pInstance->SetData(DATA_SPHERE_EVENT, DONE);
                return true;
            }

            pPrinceTaldaram->AI()->DoAction(ACTION_FREE);
        }

        return true;
    }
};

void AddSC_boss_taldaram()
{
    new boss_taldaram();
    new npc_taldaram_flamesphere();
    new go_prince_taldaram_sphere();
}
