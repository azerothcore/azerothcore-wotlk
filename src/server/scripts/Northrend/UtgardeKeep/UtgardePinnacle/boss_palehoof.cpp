/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "utgarde_pinnacle.h"

enum Misc
{
    SAY_AGGRO                               = 0,
    SAY_SLAY                                = 1,
    SOUND_DEATH                             = 13467,

    // EVENT
    SPELL_ORB_VISUAL                        = 48044,
    SPELL_ORB_CHANNEL                       = 48048,
    NPC_ORB_TRIGGER                         = 22515,
    SPELL_AWAKEN_SUBBOSS                    = 47669,

    // PALEHOOF
    SPELL_ARCING_SMASH                      = 48260,
    SPELL_IMPALE_N                          = 48261,
    SPELL_IMPALE_H                          = 59268,
    SPELL_WITHERING_ROAR_N                  = 48256,
    SPELL_WITHERING_ROAR_H                  = 59267,
    SPELL_FREEZE                            = 16245,

    // Massive Jormungar
    SPELL_ACID_SPIT                         = 48132,
    SPELL_ACID_SPLATTER_N                   = 48136,
    SPELL_ACID_SPLATTER_H                   = 59272,
    SPELL_POISON_BREATH_N                   = 48133,
    SPELL_POISON_BREATH_H                   = 59271,
    NPC_JORMUNGAR_WORM                      = 27228,

    // Ferocious Rhino
    SPELL_GORE_N                            = 48130,
    SPELL_GORE_H                            = 59264,
    SPELL_GRIEVOUS_WOUND_N                  = 48105,
    SPELL_GRIEVOUS_WOUND_H                  = 59263,
    SPELL_STOMP                             = 48131,

    // Ravenous Furbolg
    SPELL_CHAIN_LIGHTING_N                  = 48140,
    SPELL_CHAIN_LIGHTING_H                  = 59273,
    SPELL_CRAZED                            = 48139,
    SPELL_TERRIFYING_ROAR                   = 48144,

    // Frenzied Worgen
    SPELL_MORTAL_WOUND_N                    = 48137,
    SPELL_MORTAL_WOUND_H                    = 59265,
    SPELL_ENRAGE_1                          = 48138,
    SPELL_ENRAGE_2                          = 48142,

    // ACTIONS
    ACTION_START_EVENT                      = 1,
    ACTION_UNFREEZE                         = 2,
    ACTION_DESPAWN_ADDS                     = 3,
    ACTION_MINIBOSS_DIED                    = 4,
    ACTION_UNFREEZE2                        = 5,
};

enum Events
{
    EVENT_UNFREEZE_MONSTER                  = 1,
    EVENT_START_FIGHT                       = 2,
    EVENT_UNFREEZE_MONSTER2                 = 3,

    EVENT_PALEHOOF_START                    = 4,
    EVENT_PALEHOOF_START2                   = 5,
    EVENT_PALEHOOF_WITHERING_ROAR           = 6,
    EVENT_PALEHOOF_IMPALE                   = 7,
    EVENT_PALEHOOF_ARCING_SMASH             = 8,

    EVENT_JORMUNGAR_ACID_SPIT               = 10,
    EVENT_JORMUNGAR_ACID_SPLATTER           = 11,
    EVENT_JORMUNGAR_POISON_BREATH           = 12,

    EVENT_RHINO_STOMP                       = 20,
    EVENT_RHINO_GORE                        = 21,
    EVENT_RHINO_WOUND                       = 22,

    EVENT_FURBOLG_CHAIN                     = 30,
    EVENT_FURBOLG_CRAZED                    = 31,
    EVENT_FURBOLG_ROAR                      = 32,

    EVENT_WORGEN_MORTAL                     = 40,
    EVENT_WORGEN_ENRAGE1                    = 41,
    EVENT_WORGEN_ENRAGE2                    = 42,
};

/*######
## Mob Gortok Palehoof
######*/

class boss_palehoof : public CreatureScript
{
public:
    boss_palehoof() : CreatureScript("boss_palehoof") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_palehoofAI (pCreature);
    }

    struct boss_palehoofAI : public ScriptedAI
    {
        boss_palehoofAI(Creature *pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript *m_pInstance;
        EventMap events;
        SummonList summons;
        uint64 OrbGUID;
        uint8 Counter;
        uint8 RandomUnfreeze[4];

        void Reset()
        {
            for (uint8 i = 0; i < 4; ++i)
            {
                bool good;
                do
                {
                    good = true;
                    RandomUnfreeze[i] = urand(0,3);

                    for (uint8 j = 0; j < i; ++j)
                        if (RandomUnfreeze[i] == RandomUnfreeze[j])
                        {
                            good = false;
                            break;
                        }
                }
                while (!good);
            }

            events.Reset();
            summons.DoAction(ACTION_DESPAWN_ADDS);
            summons.DespawnAll();
            OrbGUID = 0;
            Counter = 0;
            me->CastSpell(me, SPELL_FREEZE, true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_STUNNED);

            if (m_pInstance)
            {
                m_pInstance->SetData(DATA_GORTOK_PALEHOOF, NOT_STARTED);

                // Reset statue
                if (GameObject *statisGenerator = m_pInstance->instance->GetGameObject(m_pInstance->GetData64(STATIS_GENERATOR)))
                {
                    statisGenerator->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    statisGenerator->SetGoState(GO_STATE_READY);
                }

                // Reset mini bosses
                for(uint8 i = 0; i < 4; ++i)
                {
                    if(Creature *Animal = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_NPC_FRENZIED_WORGEN+i)))
                    {
                        Animal->SetPosition(Animal->GetHomePosition());
                        Animal->StopMovingOnCurrentPos();
                        if(Animal->isDead())
                            Animal->Respawn(true);

                        Animal->CastSpell(Animal, SPELL_FREEZE, true);
                    }
                }
            }
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_START_EVENT)
            {
                if (Creature *cr = me->SummonCreature(NPC_ORB_TRIGGER, 238.608f, -460.71f, 109.567f))
                {
                    OrbGUID = cr->GetGUID();
                    cr->AddAura(SPELL_ORB_VISUAL, cr);
                    summons.Summon(cr);
                    cr->SetDisableGravity(true);
                    cr->GetMotionMaster()->MovePoint(0, 275.4f, -453, 110); // ROOM CENTER
                    events.RescheduleEvent(EVENT_UNFREEZE_MONSTER, 10000);
                    me->SetInCombatWithZone();
                    me->SetControlled(true, UNIT_STATE_STUNNED);
                }
            }
            else if (param == ACTION_MINIBOSS_DIED)
            {
                if (Counter > (IsHeroic() ? 3 : 1))
                    events.RescheduleEvent(EVENT_PALEHOOF_START, 3000);
                else
                    events.RescheduleEvent(EVENT_UNFREEZE_MONSTER, 3000);
            }
        }
        void EnterCombat(Unit*  /*pWho*/)
        {
            if (m_pInstance)
                m_pInstance->SetData(DATA_GORTOK_PALEHOOF, IN_PROGRESS);
        }

        void MoveInLineOfSight(Unit *who)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome()
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_UNFREEZE_MONSTER:
                {
                    if (Creature *orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                    {
                        if (Creature *miniBoss = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_NPC_FRENZIED_WORGEN+RandomUnfreeze[Counter])))
                        {
                            Counter++;
                            miniBoss->AI()->DoAction(ACTION_UNFREEZE);
                            orb->CastSpell(miniBoss, SPELL_AWAKEN_SUBBOSS, true);
                            events.ScheduleEvent(EVENT_UNFREEZE_MONSTER2, 6000);
                        }
                        else
                            EnterEvadeMode();
                    }
                    events.PopEvent();
                    break;
                }
                case EVENT_UNFREEZE_MONSTER2:
                {
                    if (Creature *orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                    {
                        if (Creature *miniBoss = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_NPC_FRENZIED_WORGEN+RandomUnfreeze[Counter-1])))
                        {
                            miniBoss->AI()->DoAction(ACTION_UNFREEZE2);
                            orb->RemoveAurasDueToSpell(SPELL_AWAKEN_SUBBOSS);
                        }
                        else
                            EnterEvadeMode();
                    }
                    events.PopEvent();
                    break;
                }
                case EVENT_PALEHOOF_START:
                {
                    if (Creature *orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                    {
                        orb->CastSpell(me, SPELL_AWAKEN_SUBBOSS, true);
                        events.ScheduleEvent(EVENT_PALEHOOF_START2, 6000);
                    }
                    events.PopEvent();
                    break;
                }
                case EVENT_PALEHOOF_START2:
                {
                    Talk(SAY_AGGRO);
                    if (Creature *orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                        orb->RemoveAurasDueToSpell(SPELL_AWAKEN_SUBBOSS);

                    me->RemoveAurasDueToSpell(SPELL_FREEZE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    // SETINCOMBATWITHZONE

                    // schedule combat events
                    events.ScheduleEvent(EVENT_PALEHOOF_WITHERING_ROAR, 10000);
                    events.ScheduleEvent(EVENT_PALEHOOF_IMPALE, 12000);
                    events.ScheduleEvent(EVENT_PALEHOOF_ARCING_SMASH, 15000);
                    events.PopEvent();
                    break;
                }
                case EVENT_PALEHOOF_WITHERING_ROAR:
                {
                    me->CastSpell(me, IsHeroic() ? SPELL_WITHERING_ROAR_H : SPELL_WITHERING_ROAR_N, false);
                    events.RepeatEvent(8000 + rand()%4000);
                    break;
                }
                case EVENT_PALEHOOF_IMPALE:
                {
                    if (Unit *tgt = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(tgt, IsHeroic() ? SPELL_IMPALE_H : SPELL_IMPALE_N, false);

                    events.RepeatEvent(8000 + rand()%4000);
                    break;
                }
                case EVENT_PALEHOOF_ARCING_SMASH:
                {
                    me->CastSpell(me->GetVictim(), SPELL_ARCING_SMASH, false);
                    events.RepeatEvent(13000 + rand()%4000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/)
        {
            me->SendPlaySound(SOUND_DEATH, false);
            if(m_pInstance)
                m_pInstance->SetData(DATA_GORTOK_PALEHOOF, DONE);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
        }
    };
};

/*######
## Mob Massive Jormungar
######*/

class npc_massive_jormungar : public CreatureScript
{
public:
    npc_massive_jormungar() : CreatureScript("npc_massive_jormungar") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_massive_jormungarAI (pCreature);
    }

    struct npc_massive_jormungarAI : public ScriptedAI
    {
        npc_massive_jormungarAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript *m_pInstance;
        EventMap events;
        SummonList summons;

        void Reset()
        {
            summons.DespawnAll();
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
        }

        void EnterCombat(Unit *) {}

        void DoAction(int32 param)
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_JORMUNGAR_ACID_SPIT, 3000);
                events.ScheduleEvent(EVENT_JORMUNGAR_ACID_SPLATTER, 12000);
                events.ScheduleEvent(EVENT_JORMUNGAR_POISON_BREATH, 10000);
            }
            else if (param == ACTION_DESPAWN_ADDS)
                summons.DespawnAll();
        }

        void MoveInLineOfSight(Unit *who)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome()
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_JORMUNGAR_ACID_SPIT:
                {
                    if (Unit *tgt = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(tgt, SPELL_ACID_SPIT, false);

                    events.RepeatEvent(2000 + rand()%2000);
                    break;
                }
                case EVENT_JORMUNGAR_ACID_SPLATTER:
                {
                    me->CastSpell(me, IsHeroic() ? SPELL_ACID_SPLATTER_H : SPELL_ACID_SPLATTER_N, false);

                    // Aura summon wont work because of duration
                    float x, y, z;
                    me->GetPosition(x, y, z);
                    for (uint8 i = 0; i < 6; ++i)
                    {
                        if (Creature* pJormungarWorm = me->SummonCreature(NPC_JORMUNGAR_WORM, x+rand()%10, y+rand()%10, z, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 360000))
                        {
                            summons.Summon(pJormungarWorm);
                            pJormungarWorm->SetInCombatWithZone();
                        }
                    }
                    events.RepeatEvent(10000 + rand()%4000);
                    break;
                }
                case EVENT_JORMUNGAR_POISON_BREATH:
                {
                    if (Unit *tgt = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(tgt, IsHeroic() ? SPELL_POISON_BREATH_H : SPELL_POISON_BREATH_N, false);

                    events.RepeatEvent(8000 + rand()%4000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/)
        {
            if (m_pInstance)
            {
                if (Creature *palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_GORTOK_PALEHOOF)))
                    palehoof->AI()->DoAction(ACTION_MINIBOSS_DIED);
            }
        }
    };
};

/*######
## Mob Ferocious Rhino
######*/

class npc_ferocious_rhino : public CreatureScript
{
public:
    npc_ferocious_rhino() : CreatureScript("npc_ferocious_rhino") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ferocious_rhinoAI (pCreature);
    }

    struct npc_ferocious_rhinoAI : public ScriptedAI
    {
        npc_ferocious_rhinoAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript *m_pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
        }

        void EnterCombat(Unit *) {}

        void DoAction(int32 param)
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_RHINO_STOMP, 3000);
                events.ScheduleEvent(EVENT_RHINO_GORE, 12000);
                events.ScheduleEvent(EVENT_RHINO_WOUND, 10000);
            }
        }

        void MoveInLineOfSight(Unit *who)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome()
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_RHINO_STOMP:
                {
                    me->CastSpell(me->GetVictim(), SPELL_STOMP, false);
                    events.RepeatEvent(8000 + rand()%4000);
                    break;
                }
                case EVENT_RHINO_GORE:
                {
                    me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_GORE_H : SPELL_GORE_N, false);
                    events.RepeatEvent(13000 + rand()%4000);
                    break;
                }
                case EVENT_RHINO_WOUND:
                {
                    if (Unit *tgt = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(tgt, IsHeroic() ? SPELL_GRIEVOUS_WOUND_H : SPELL_GRIEVOUS_WOUND_N, false);

                    events.RepeatEvent(18000 + rand()%4000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/)
        {
            if (m_pInstance)
            {
                if (Creature *palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_GORTOK_PALEHOOF)))
                    palehoof->AI()->DoAction(ACTION_MINIBOSS_DIED);
            }
        }
    };
};

/*######
## Mob Ravenous Furbolg
######*/

class npc_ravenous_furbolg : public CreatureScript
{
public:
    npc_ravenous_furbolg() : CreatureScript("npc_ravenous_furbolg") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_ravenous_furbolgAI (pCreature);
    }

    struct npc_ravenous_furbolgAI : public ScriptedAI
    {
        npc_ravenous_furbolgAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript *m_pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
        }

        void EnterCombat(Unit *) {}

        void DoAction(int32 param)
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_FURBOLG_CHAIN, 3000);
                events.ScheduleEvent(EVENT_FURBOLG_CRAZED, 12000);
                events.ScheduleEvent(EVENT_FURBOLG_ROAR, 10000);
            }
        }

        void MoveInLineOfSight(Unit *who)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome()
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_FURBOLG_CHAIN:
                {
                    me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_CHAIN_LIGHTING_H : SPELL_CHAIN_LIGHTING_N, false);
                    events.RepeatEvent(4000 + rand()%3000);
                    break;
                }
                case EVENT_FURBOLG_CRAZED:
                {
                    me->CastSpell(me, SPELL_CRAZED, false);
                    events.RepeatEvent(8000 + rand()%4000);
                    break;
                }
                case EVENT_FURBOLG_ROAR:
                {
                    me->CastSpell(me, SPELL_TERRIFYING_ROAR, false);
                    events.RepeatEvent(10000 + rand()%5000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/)
        {
            if (m_pInstance)
            {
                if (Creature *palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_GORTOK_PALEHOOF)))
                    palehoof->AI()->DoAction(ACTION_MINIBOSS_DIED);
            }
        }
    };
};

/*######
## Mob Frenzied Worgen
######*/

class npc_frenzied_worgen : public CreatureScript
{
public:
    npc_frenzied_worgen() : CreatureScript("npc_frenzied_worgen") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_frenzied_worgenAI (pCreature);
    }

    struct npc_frenzied_worgenAI : public ScriptedAI
    {
        npc_frenzied_worgenAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript *m_pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
        }

        void EnterCombat(Unit *) {}

        void DoAction(int32 param)
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_WORGEN_MORTAL, 3000);
                events.ScheduleEvent(EVENT_WORGEN_ENRAGE1, 12000);
                events.ScheduleEvent(EVENT_WORGEN_ENRAGE2, 10000);
            }
        }

        void MoveInLineOfSight(Unit *who)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome()
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_WORGEN_MORTAL:
                {
                    me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_MORTAL_WOUND_H : SPELL_MORTAL_WOUND_N, false);
                    events.RepeatEvent(4000 + rand()%3000);
                    break;
                }
                case EVENT_WORGEN_ENRAGE1:
                {
                    me->CastSpell(me, SPELL_ENRAGE_1, false);
                    events.RepeatEvent(15000);
                    break;
                }
                case EVENT_WORGEN_ENRAGE2:
                {
                    me->CastSpell(me, SPELL_ENRAGE_2, false);
                    events.RepeatEvent(10000);
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/)
        {
            if (m_pInstance)
            {
                if (Creature *palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetData64(DATA_GORTOK_PALEHOOF)))
                    palehoof->AI()->DoAction(ACTION_MINIBOSS_DIED);
            }
        }
    };
};

class go_palehoof_sphere : public GameObjectScript
{
public:
    go_palehoof_sphere() : GameObjectScript("go_palehoof_sphere") { }

    bool OnGossipHello(Player * /*pPlayer*/, GameObject *go) override
    {
        InstanceScript *pInstance = go->GetInstanceScript();

        Creature *pPalehoof = ObjectAccessor::GetCreature(*go, pInstance ? pInstance->GetData64(DATA_GORTOK_PALEHOOF) : 0);
        if (pPalehoof && pPalehoof->IsAlive())
        {
            // maybe these are hacks :(
            go->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_NOT_SELECTABLE);
            go->SetGoState(GO_STATE_ACTIVE);

            pPalehoof->AI()->DoAction(ACTION_START_EVENT);
        }
        return true;
    }
};

void AddSC_boss_palehoof()
{
    new boss_palehoof();
    new npc_massive_jormungar();
    new npc_ferocious_rhino();
    new npc_ravenous_furbolg();
    new npc_frenzied_worgen();
    new go_palehoof_sphere();
}
