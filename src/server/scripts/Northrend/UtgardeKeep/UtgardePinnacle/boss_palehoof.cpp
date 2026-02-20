/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "GameObjectScript.h"
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
    SPELL_IMPALE                            = 48261,
    SPELL_WITHERING_ROAR                    = 48256,
    SPELL_FREEZE                            = 16245,

    // Massive Jormungar
    SPELL_ACID_SPIT                         = 48132,
    SPELL_ACID_SPLATTER                     = 48136,
    SPELL_POISON_BREATH                     = 48133,
    NPC_JORMUNGAR_WORM                      = 27228,

    // Ferocious Rhino
    SPELL_GORE                              = 48130,
    SPELL_GRIEVOUS_WOUND                    = 48105,
    SPELL_STOMP                             = 48131,

    // Ravenous Furbolg
    SPELL_CHAIN_LIGHTNING                    = 48140,
    SPELL_CRAZED                            = 48139,
    SPELL_TERRIFYING_ROAR                   = 48144,

    // Frenzied Worgen
    SPELL_MORTAL_WOUND                      = 48137,
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<boss_palehoofAI>(pCreature);
    }

    struct boss_palehoofAI : public ScriptedAI
    {
        boss_palehoofAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        ObjectGuid OrbGUID;
        uint8 Counter;
        uint8 RandomUnfreeze[4];

        void Reset() override
        {
            for (uint8 i = 0; i < 4; ++i)
            {
                bool good;
                do
                {
                    good = true;
                    RandomUnfreeze[i] = urand(0, 3);

                    for (uint8 j = 0; j < i; ++j)
                        if (RandomUnfreeze[i] == RandomUnfreeze[j])
                        {
                            good = false;
                            break;
                        }
                } while (!good);
            }

            events.Reset();
            summons.DoAction(ACTION_DESPAWN_ADDS);
            summons.DespawnAll();
            OrbGUID.Clear();
            Counter = 0;
            me->CastSpell(me, SPELL_FREEZE, true);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_STUNNED);

            if (m_pInstance)
            {
                m_pInstance->SetData(DATA_GORTOK_PALEHOOF, NOT_STARTED);

                // Reset statue
                if (GameObject* statisGenerator = m_pInstance->instance->GetGameObject(m_pInstance->GetGuidData(STATIS_GENERATOR)))
                {
                    statisGenerator->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    statisGenerator->SetGoState(GO_STATE_READY);
                }

                // Reset mini bosses
                for(uint8 i = 0; i < 4; ++i)
                {
                    if (Creature* Animal = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(DATA_NPC_FRENZIED_WORGEN + i)))
                    {
                        Animal->SetPosition(Animal->GetHomePosition());
                        Animal->StopMovingOnCurrentPos();
                        if (Animal->isDead())
                            Animal->Respawn(true);

                        Animal->CastSpell(Animal, SPELL_FREEZE, true);
                    }
                }
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_EVENT)
            {
                if (Creature* cr = me->SummonCreature(NPC_ORB_TRIGGER, 238.608f, -460.71f, 109.567f))
                {
                    OrbGUID = cr->GetGUID();
                    cr->AddAura(SPELL_ORB_VISUAL, cr);
                    summons.Summon(cr);
                    cr->SetDisableGravity(true);
                    cr->GetMotionMaster()->MovePoint(0, 275.4f, -453, 110); // ROOM CENTER
                    events.RescheduleEvent(EVENT_UNFREEZE_MONSTER, 10s);
                    me->SetInCombatWithZone();
                    me->SetControlled(true, UNIT_STATE_STUNNED);
                }
            }
            else if (param == ACTION_MINIBOSS_DIED)
            {
                if (Counter > (IsHeroic() ? 3 : 1))
                    events.RescheduleEvent(EVENT_PALEHOOF_START, 3s);
                else
                    events.RescheduleEvent(EVENT_UNFREEZE_MONSTER, 3s);
            }
        }
        void JustEngagedWith(Unit*  /*pWho*/) override
        {
            if (m_pInstance)
                m_pInstance->SetData(DATA_GORTOK_PALEHOOF, IN_PROGRESS);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome() override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_UNFREEZE_MONSTER:
                    {
                        if (Creature* orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                        {
                            if (Creature* miniBoss = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(DATA_NPC_FRENZIED_WORGEN + RandomUnfreeze[Counter])))
                            {
                                Counter++;
                                miniBoss->AI()->DoAction(ACTION_UNFREEZE);
                                orb->CastSpell(miniBoss, SPELL_AWAKEN_SUBBOSS, true);
                                events.ScheduleEvent(EVENT_UNFREEZE_MONSTER2, 6s);
                            }
                            else
                                EnterEvadeMode();
                        }
                        break;
                    }
                case EVENT_UNFREEZE_MONSTER2:
                    {
                        if (Creature* orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                        {
                            if (Creature* miniBoss = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(DATA_NPC_FRENZIED_WORGEN + RandomUnfreeze[Counter - 1])))
                            {
                                miniBoss->AI()->DoAction(ACTION_UNFREEZE2);
                                orb->RemoveAurasDueToSpell(SPELL_AWAKEN_SUBBOSS);
                            }
                            else
                                EnterEvadeMode();
                        }
                        break;
                    }
                case EVENT_PALEHOOF_START:
                    {
                        if (Creature* orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                        {
                            orb->CastSpell(me, SPELL_AWAKEN_SUBBOSS, true);
                            events.ScheduleEvent(EVENT_PALEHOOF_START2, 6s);
                        }
                        break;
                    }
                case EVENT_PALEHOOF_START2:
                    {
                        Talk(SAY_AGGRO);
                        if (Creature* orb = ObjectAccessor::GetCreature(*me, OrbGUID))
                            orb->RemoveAurasDueToSpell(SPELL_AWAKEN_SUBBOSS);

                        me->RemoveAurasDueToSpell(SPELL_FREEZE);
                        me->GetThreatMgr().ResetAllThreat();
                        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                        me->SetControlled(false, UNIT_STATE_STUNNED);
                        // SETINCOMBATWITHZONE

                        // schedule combat events
                        events.ScheduleEvent(EVENT_PALEHOOF_WITHERING_ROAR, 10s);
                        events.ScheduleEvent(EVENT_PALEHOOF_IMPALE, 12s);
                        events.ScheduleEvent(EVENT_PALEHOOF_ARCING_SMASH, 15s);
                        break;
                    }
                case EVENT_PALEHOOF_WITHERING_ROAR:
                    {
                        me->CastSpell(me, SPELL_WITHERING_ROAR, false);
                        events.Repeat(8s, 12s);
                        break;
                    }
                case EVENT_PALEHOOF_IMPALE:
                    {
                        if (Unit* tgt = SelectTarget(SelectTargetMethod::Random, 0))
                            me->CastSpell(tgt, SPELL_IMPALE, false);

                        events.Repeat(8s, 12s);
                        break;
                    }
                case EVENT_PALEHOOF_ARCING_SMASH:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_ARCING_SMASH, false);
                        events.Repeat(13s, 17s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/) override
        {
            me->PlayDirectSound(SOUND_DEATH);
            if (m_pInstance)
                m_pInstance->SetData(DATA_GORTOK_PALEHOOF, DONE);
        }

        void KilledUnit(Unit* victim) override
        {
            if (!victim->IsPlayer())
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<npc_massive_jormungarAI>(pCreature);
    }

    struct npc_massive_jormungarAI : public ScriptedAI
    {
        npc_massive_jormungarAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            summons.DespawnAll();
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        }

        void JustEngagedWith(Unit*) override {}

        void DoAction(int32 param) override
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_JORMUNGAR_ACID_SPIT, 3s);
                events.ScheduleEvent(EVENT_JORMUNGAR_ACID_SPLATTER, 12s);
                events.ScheduleEvent(EVENT_JORMUNGAR_POISON_BREATH, 10s);
            }
            else if (param == ACTION_DESPAWN_ADDS)
                summons.DespawnAll();
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome() override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_JORMUNGAR_ACID_SPIT:
                    {
                        if (Unit* tgt = SelectTarget(SelectTargetMethod::Random, 0))
                            me->CastSpell(tgt, SPELL_ACID_SPIT, false);

                        events.Repeat(2s, 4s);
                        break;
                    }
                case EVENT_JORMUNGAR_ACID_SPLATTER:
                    {
                        me->CastSpell(me, SPELL_ACID_SPLATTER, false);

                        // Aura summon wont work because of duration
                        float x, y, z;
                        me->GetPosition(x, y, z);
                        for (uint8 i = 0; i < 6; ++i)
                        {
                            if (Creature* pJormungarWorm = me->SummonCreature(NPC_JORMUNGAR_WORM, x + rand() % 10, y + rand() % 10, z, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 360000))
                            {
                                summons.Summon(pJormungarWorm);
                                pJormungarWorm->SetInCombatWithZone();
                            }
                        }
                        events.Repeat(10s, 15s);
                        break;
                    }
                case EVENT_JORMUNGAR_POISON_BREATH:
                    {
                        if (Unit* tgt = SelectTarget(SelectTargetMethod::Random, 0))
                            me->CastSpell(tgt, SPELL_POISON_BREATH, false);

                        events.Repeat(8s, 12s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/) override
        {
            if (m_pInstance)
            {
                if (Creature* palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(DATA_GORTOK_PALEHOOF)))
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<npc_ferocious_rhinoAI>(pCreature);
    }

    struct npc_ferocious_rhinoAI : public ScriptedAI
    {
        npc_ferocious_rhinoAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        }

        void JustEngagedWith(Unit*) override {}

        void DoAction(int32 param) override
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_RHINO_STOMP, 3s);
                events.ScheduleEvent(EVENT_RHINO_GORE, 12s);
                events.ScheduleEvent(EVENT_RHINO_WOUND, 10s);
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome() override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_RHINO_STOMP:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_STOMP, false);
                        events.Repeat(8s, 12s);
                        break;
                    }
                case EVENT_RHINO_GORE:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_GORE, false);
                        events.Repeat(13s, 17s);
                        break;
                    }
                case EVENT_RHINO_WOUND:
                    {
                        if (Unit* tgt = SelectTarget(SelectTargetMethod::Random, 0))
                            me->CastSpell(tgt, SPELL_GRIEVOUS_WOUND, false);

                        events.Repeat(18s, 22s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/) override
        {
            if (m_pInstance)
            {
                if (Creature* palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(DATA_GORTOK_PALEHOOF)))
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<npc_ravenous_furbolgAI>(pCreature);
    }

    struct npc_ravenous_furbolgAI : public ScriptedAI
    {
        npc_ravenous_furbolgAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        }

        void JustEngagedWith(Unit*) override {}

        void DoAction(int32 param) override
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_FURBOLG_CHAIN, 3s);
                events.ScheduleEvent(EVENT_FURBOLG_CRAZED, 12s);
                events.ScheduleEvent(EVENT_FURBOLG_ROAR, 10s);
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome() override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_FURBOLG_CHAIN:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_CHAIN_LIGHTNING, false);
                        events.Repeat(4s, 7s);
                        break;
                    }
                case EVENT_FURBOLG_CRAZED:
                    {
                        me->CastSpell(me, SPELL_CRAZED, false);
                        events.Repeat(8s, 12s);
                        break;
                    }
                case EVENT_FURBOLG_ROAR:
                    {
                        me->CastSpell(me, SPELL_TERRIFYING_ROAR, false);
                        events.Repeat(10s, 15s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/) override
        {
            if (m_pInstance)
            {
                if (Creature* palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(DATA_GORTOK_PALEHOOF)))
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

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<npc_frenzied_worgenAI>(pCreature);
    }

    struct npc_frenzied_worgenAI : public ScriptedAI
    {
        npc_frenzied_worgenAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        }

        void JustEngagedWith(Unit*) override {}

        void DoAction(int32 param) override
        {
            if (param == ACTION_UNFREEZE)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
            else if (param == ACTION_UNFREEZE2)
            {
                me->RemoveAurasDueToSpell(SPELL_FREEZE);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetInCombatWithZone();

                events.ScheduleEvent(EVENT_WORGEN_MORTAL, 3s);
                events.ScheduleEvent(EVENT_WORGEN_ENRAGE1, 12s);
                events.ScheduleEvent(EVENT_WORGEN_ENRAGE2, 10s);
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustReachedHome() override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
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
                case EVENT_WORGEN_MORTAL:
                    {
                        me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                        events.Repeat(4s, 7s);
                        break;
                    }
                case EVENT_WORGEN_ENRAGE1:
                    {
                        me->CastSpell(me, SPELL_ENRAGE_1, false);
                        events.Repeat(15s);
                        break;
                    }
                case EVENT_WORGEN_ENRAGE2:
                    {
                        me->CastSpell(me, SPELL_ENRAGE_2, false);
                        events.Repeat(10s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/) override
        {
            if (m_pInstance)
            {
                if (Creature* palehoof = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(DATA_GORTOK_PALEHOOF)))
                    palehoof->AI()->DoAction(ACTION_MINIBOSS_DIED);
            }
        }
    };
};

class go_palehoof_sphere : public GameObjectScript
{
public:
    go_palehoof_sphere() : GameObjectScript("go_palehoof_sphere") { }

    bool OnGossipHello(Player* /*pPlayer*/, GameObject* go) override
    {
        InstanceScript* pInstance = go->GetInstanceScript();

        Creature* pPalehoof = ObjectAccessor::GetCreature(*go, pInstance ? pInstance->GetGuidData(DATA_GORTOK_PALEHOOF) : ObjectGuid::Empty);
        if (pPalehoof && pPalehoof->IsAlive())
        {
            // maybe these are hacks :(
            go->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
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
