/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CombatAI.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "Vehicle.h"
#include "utgarde_pinnacle.h"

enum Misc
{
    // TEXTS
    SAY_AGGRO                           = 0,
    SAY_KILL                            = 1,
    SAY_DEATH                           = 3,
    SAY_DRAKE_DEATH                     = 5,
    SAY_DRAKE_BREATH                    = 6,

    // EMOTES
    EMOTE_DEEP_BREATH                   = 0,
    EMOTE_RANGE                         = 1,

    // SPELLS
    SPELL_CRUSH_N                       = 50234,
    SPELL_CRUSH_H                       = 59330,
    SPELL_POISONED_SPEAR_N              = 50255,
    SPELL_POISONED_SPEAR_H              = 59331,
    SPELL_WHIRLWIND_N                   = 50228,
    SPELL_WHIRLWIND_H                   = 50228,

    SPELL_FREEZING_CLOUD_VISUAL         = 47592,
    SPELL_FREEZING_CLOUD_N              = 47579,
    SPELL_FREEZING_CLOUD_H              = 60020,

    SPELL_LAUNCH_HARPOON                = 48642,

    // NPCS
    NPC_YMIRJAR_WARRIOR                 = 26690,
    NPC_YMIRJAR_WITCH_DOCTOR            = 26691,
    NPC_YMIRJAR_HARPOONER               = 26692,
    NPC_GRAUF                           = 26893,
    NPC_BREATH_TRIGGER                  = 28351,
    EQUIP_MACE                          = 17193,

    // ACTIONS
    ACTION_START_EVENT                  = 1,
    ACTION_REMOVE_SKADI                 = 2,
    ACTION_PHASE2                       = 3,
    ACTION_MYGIRL_ACHIEVEMENT           = 4,

    // ACHIEVEMENTS
    ACHIEV_TIMED_LODI_DODI              = 17726,
};

enum Events
{
    // SKADI
    EVENT_SKADI_START                   = 1,
    EVENT_SKADI_CRUSH                   = 2,
    EVENT_SKADI_SPEAR                   = 3,
    EVENT_SKADI_WHIRLWIND               = 4,

    // GRAUF
    EVENT_GRAUF_START                   = 10,
    EVENT_GRAUF_MOVE                    = 11,
    EVENT_GRAUF_SUMMON_HELPERS          = 12,
    EVENT_GRAUF_CHECK                   = 13,
    EVENT_GRAUF_REMOVE_SKADI            = 14,
};

static Position TrashPosition[] =
{
    {441.236f, -512.000f, 104.930f, 0.0f},
    {478.436f, -494.475f, 104.730f, 0.0f}
};

static Position SkadiPosition[] =
{
    {338.679f, -507.254f, 124.122f, 0.0f},
    {338.679f, -513.254f, 124.122f, 0.0f},
    {490.096f, -510.86f, 123.368f, 0.0f},
    {490.76f, -517.389f, 123.368f, 0.0f}
};

enum phase
{
    PHASE_NONE,
    PHASE_START,
    PHASE_FLIGHT,
    PHASE_LAND,
    PHASE_GROUND
};

class boss_skadi : public CreatureScript
{
public:
    boss_skadi() : CreatureScript("boss_skadi") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<boss_skadiAI>(pCreature);
    }

    struct boss_skadiAI : public ScriptedAI
    {
        boss_skadiAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        ObjectGuid GraufGUID;
        bool SecondPhase, EventStarted;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            if (Creature* cr = me->SummonCreature(NPC_GRAUF, 341.741f, -516.955f, 116.669f, 3.12414f))
            {
                GraufGUID = cr->GetGUID();
                summons.Summon(cr);
            }
            SecondPhase = false;
            EventStarted = false;

            me->RemoveAllAuras();
            me->SetControlled(false, UNIT_STATE_ROOT);
            me->UpdatePosition(343.02f, -507.325f, 104.567f, M_PI, true);
            me->StopMovingOnCurrentPos();

            if(m_pInstance)
            {
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_LODI_DODI);
                m_pInstance->SetData(DATA_SKADI_THE_RUTHLESS, NOT_STARTED);
                m_pInstance->SetData(SKADI_IN_RANGE, 0);
                m_pInstance->SetData(SKADI_HITS, 0);
                m_pInstance->SetData(DATA_SKADI_ACHIEVEMENT, false);
            }
        }

        Creature* GetGrauf() { return ObjectAccessor::GetCreature(*me, GraufGUID); }

        void JustEngagedWith(Unit*  /*pWho*/) override
        {
            if (!EventStarted)
            {
                EventStarted = true;
                Talk(SAY_AGGRO);
                if (m_pInstance)
                {
                    if (IsHeroic())
                        m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_LODI_DODI);

                    m_pInstance->SetData(DATA_SKADI_THE_RUTHLESS, IN_PROGRESS);
                }

                me->SetControlled(true, UNIT_STATE_ROOT);
                me->SetInCombatWithZone();
                events.RescheduleEvent(EVENT_SKADI_START, 2s);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_PHASE2)
            {
                SecondPhase = true;
                events.ScheduleEvent(EVENT_SKADI_CRUSH, 8s);
                events.ScheduleEvent(EVENT_SKADI_SPEAR, 10s);
                events.ScheduleEvent(EVENT_SKADI_WHIRLWIND, 15s);

                if (me->GetVictim())
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                else
                    me->SetInCombatWithZone();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && SecondPhase)
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SKADI_START:
                    {
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        if (Creature* cr = GetGrauf())
                        {
                            me->EnterVehicleUnattackable(cr, 0);
                            cr->AI()->DoAction(ACTION_START_EVENT);
                        }
                        else
                            EnterEvadeMode();

                        break;
                    }
                case EVENT_SKADI_CRUSH:
                    {
                        me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_CRUSH_H : SPELL_CRUSH_N, false);
                        events.Repeat(8s);
                        break;
                    }
                case EVENT_SKADI_SPEAR:
                    {
                        if (Unit* tgt = SelectTarget(SelectTargetMethod::Random, 0))
                            me->CastSpell(tgt, IsHeroic() ? SPELL_POISONED_SPEAR_H : SPELL_POISONED_SPEAR_N, false);

                        events.Repeat(10s);
                        break;
                    }
                case EVENT_SKADI_WHIRLWIND:
                    {
                        me->CastSpell(me, IsHeroic() ? SPELL_WHIRLWIND_H : SPELL_WHIRLWIND_N, false);
                        events.Repeat(15s, 20s);
                        events.DelayEvents(10s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/) override
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);

            if (m_pInstance)
            {
                m_pInstance->SetData(DATA_SKADI_THE_RUTHLESS, DONE);
                m_pInstance->HandleGameObject(m_pInstance->GetGuidData(SKADI_DOOR), true);
            }
        }

        void KilledUnit(Unit*  /*pVictim*/) override
        {
            if (urand(0, 1))
                return;

            Talk(SAY_KILL);
        }
    };
};

class boss_skadi_grauf : public CreatureScript
{
public:
    boss_skadi_grauf() : CreatureScript("boss_skadi_grauf") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<boss_skadi_graufAI>(pCreature);
    }

    struct boss_skadi_graufAI : public VehicleAI
    {
        boss_skadi_graufAI(Creature* pCreature) : VehicleAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        uint8 currentPos;
        uint8 AchievementHitCount;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
            currentPos = 0;
            AchievementHitCount = 0;
            me->RemoveAllAuras();
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_EVENT)
            {
                events.RescheduleEvent(EVENT_GRAUF_CHECK, 5s);
                events.RescheduleEvent(EVENT_GRAUF_START, 2s);
            }
            else if (param == ACTION_REMOVE_SKADI)
            {
                if (Unit* passenger = me->GetVehicleKit()->GetPassenger(0))
                    if (Creature* skadi = passenger->ToCreature())
                        skadi->AI()->Talk(SAY_DRAKE_DEATH);
                me->GetMotionMaster()->MovePoint(10, 480.0f, -513.0f, 108.0f);
                events.ScheduleEvent(EVENT_GRAUF_REMOVE_SKADI, 2s);
            }
            else if (param == ACTION_MYGIRL_ACHIEVEMENT)
            {
                AchievementHitCount++;
                if (AchievementHitCount >= 3 && m_pInstance)
                    m_pInstance->SetData(DATA_SKADI_ACHIEVEMENT, true);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == 47593) // SPELL_FREEZING_CLOUD_VISUAL trigger
                target->CastSpell(target, me->GetMap()->IsHeroic() ? SPELL_FREEZING_CLOUD_H : SPELL_FREEZING_CLOUD_N, true);
        }

        void SpawnFlameTriggers(uint8 point)
        {
            for(uint8 j = 0; j < 50; ++j)
            {
                if (point == 1)
                    me->SummonCreature(NPC_BREATH_TRIGGER, 480.0f - (j * 3), -518.0f + (j / 16.0f), 105.0f, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000);
                else
                    me->SummonCreature(NPC_BREATH_TRIGGER, 480.0f - (j * 3), -510.0f + (j / 16.0f), 105.0f, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000);
            }
            // and out of loop, cover the small room
            if (point == 0)
            {
                Creature* cr;
                if ((cr = me->SummonCreature(NPC_BREATH_TRIGGER, 483, -484.9f, 105, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000)))
                    cr->CastSpell(cr, cr->GetMap()->IsHeroic() ? SPELL_FREEZING_CLOUD_H : SPELL_FREEZING_CLOUD_N, true);
                if ((cr = me->SummonCreature(NPC_BREATH_TRIGGER, 471.0f, -484.7f, 105, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000)))
                    cr->CastSpell(cr, cr->GetMap()->IsHeroic() ? SPELL_FREEZING_CLOUD_H : SPELL_FREEZING_CLOUD_N, true);

                for (uint8 j = 0; j < 7; j++)
                    if ((cr = me->SummonCreature(NPC_BREATH_TRIGGER, 477.0f, -507.0f + (j * 3), 105.0f, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 30000)))
                        cr->CastSpell(cr, cr->GetMap()->IsHeroic() ? SPELL_FREEZING_CLOUD_H : SPELL_FREEZING_CLOUD_N, true);
            }
        }

        void MovementInform(uint32  /*uiType*/, uint32 Id) override
        {
            switch(Id)
            {
                case 0:
                case 1:
                    me->RemoveAurasDueToSpell(SPELL_FREEZING_CLOUD_VISUAL);
                    me->SetFacingTo(M_PI * 2);
                    break;
                case 2:
                case 3:
                    if (m_pInstance)
                        m_pInstance->SetData(SKADI_IN_RANGE, 1);
                    Talk(EMOTE_RANGE);
                    me->SetFacingTo(M_PI);
                    break;
            }
        }

        uint8 SelectNextPos(uint8 Position)
        {
            switch (Position)
            {
                case 0:
                case 1:
                    return 2 + urand(0, 1);
                default:
                    if (me->GetPositionY() < -515.0f)
                        return 1;
                    else
                        return 0;
            }
        }

        void JustEngagedWith(Unit*) override
        {
            me->SetInCombatWithZone();
        }

        void RemoveSkadi(bool withEvade)
        {
            if (Unit* skadi = me->GetVehicleKit()->GetPassenger(0))
            {
                summons.DespawnAll();
                skadi->ExitVehicle();
                if (withEvade)
                {
                    skadi->ToCreature()->AI()->EnterEvadeMode();
                    skadi->UpdatePosition(343.02f, -507.325f, 104.567f, M_PI, true);
                }
                else
                    skadi->ToCreature()->AI()->DoAction(ACTION_PHASE2);

                skadi->StopMovingOnCurrentPos();
            }
        }

        void CheckPlayers()
        {
            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
            {
                if (itr->GetSource()->GetPositionX() < 320.0f || itr->GetSource()->IsGameMaster() || !itr->GetSource()->IsAlive())
                    continue;

                return;
            }

            RemoveSkadi(true);
        }

        void SpawnHelpers(uint8 Spot)
        {
            if (Creature* Harpooner = me->SummonCreature(NPC_YMIRJAR_HARPOONER, TrashPosition[Spot].GetPositionX() + rand() % 5, TrashPosition[Spot].GetPositionY() + rand() % 5, TrashPosition[Spot].GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
            {
                Harpooner->SetInCombatWithZone();
                summons.Summon(Harpooner);
            }
            if (Creature* Second = me->SummonCreature((urand(0, 1) ? NPC_YMIRJAR_WARRIOR : NPC_YMIRJAR_WITCH_DOCTOR), TrashPosition[Spot].GetPositionX() + rand() % 5, TrashPosition[Spot].GetPositionY() + rand() % 5, TrashPosition[Spot].GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
            {
                Second->SetInCombatWithZone();
                summons.Summon(Second);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_GRAUF_CHECK:
                    {
                        CheckPlayers();
                        events.Repeat(2s);
                        break;
                    }
                case EVENT_GRAUF_START:
                    {
                        me->GetMotionMaster()->Clear(true);
                        me->GetMotionMaster()->MoveTakeoff(10, SkadiPosition[0].GetPositionX(), SkadiPosition[0].GetPositionY(), SkadiPosition[0].GetPositionZ(), 3.0f);

                        SpawnHelpers(0);
                        SpawnHelpers(0);
                        events.ScheduleEvent(EVENT_GRAUF_MOVE, 15s);
                        events.ScheduleEvent(EVENT_GRAUF_SUMMON_HELPERS, 20s);
                        break;
                    }
                case EVENT_GRAUF_MOVE:
                    {
                        AchievementHitCount = 0;
                        uint8 targetPoint = SelectNextPos(currentPos);
                        me->GetMotionMaster()->MovePoint(targetPoint, SkadiPosition[targetPoint].GetPositionX(), SkadiPosition[targetPoint].GetPositionY(), SkadiPosition[targetPoint].GetPositionZ());
                        if (targetPoint <= 1)
                        {
                            Talk(EMOTE_DEEP_BREATH);
                            SpawnFlameTriggers(targetPoint);
                            me->CastSpell(me, SPELL_FREEZING_CLOUD_VISUAL, false);
                        }

                        if (m_pInstance)
                            m_pInstance->SetData(SKADI_IN_RANGE, 0);

                        currentPos = targetPoint;
                        events.Repeat(25s);
                        break;
                    }
                case EVENT_GRAUF_SUMMON_HELPERS:
                    {
                        SpawnHelpers(1);
                        events.Repeat(15s);
                        break;
                    }
                case EVENT_GRAUF_REMOVE_SKADI:
                    {
                        RemoveSkadi(false);
                        me->DespawnOrUnsummon();
                        break;
                    }
            }
        }
    };
};

class go_harpoon_canon : public GameObjectScript
{
public:
    go_harpoon_canon() : GameObjectScript("go_harpoon_canon") { }

    bool OnGossipHello(Player* pPlayer, GameObject* go) override
    {
        InstanceScript* m_pInstance = go->GetInstanceScript();
        if (m_pInstance && m_pInstance->GetData(DATA_SKADI_THE_RUTHLESS) == IN_PROGRESS)
            if (m_pInstance->GetData(SKADI_IN_RANGE) == 1)
            {
                uint8 count = m_pInstance->GetData(SKADI_HITS) + 1;
                m_pInstance->SetData(SKADI_HITS, count);

                if (Creature* grauf = ObjectAccessor::GetCreature(*pPlayer, m_pInstance->GetGuidData(DATA_GRAUF)))
                {
                    if (count >= 3)
                    {
                        m_pInstance->SetData(SKADI_IN_RANGE, 0);
                        grauf->AI()->DoAction(ACTION_REMOVE_SKADI);
                    }

                    grauf->AI()->DoAction(ACTION_MYGIRL_ACHIEVEMENT);
                }
                go->CastSpell((Unit*)nullptr, SPELL_LAUNCH_HARPOON);
            }

        return true;
    }
};

void AddSC_boss_skadi()
{
    new boss_skadi();
    new boss_skadi_grauf();
    new go_harpoon_canon();
}
