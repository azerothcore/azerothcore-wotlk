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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "utgarde_pinnacle.h"

enum Misc
{
    // TEXTS
    SAY_AGGRO                               = 0,
    SAY_SLAY                                = 1,
    SAY_DEATH                               = 2,
    SAY_SUMMON_BJORN                        = 3,
    SAY_SUMMON_HALDOR                       = 4,
    SAY_SUMMON_RANULF                       = 5,
    SAY_SUMMON_TORGYN                       = 6,

    // SPELLS
    SPELL_BANE_N                            = 48294,
    SPELL_BANE_H                            = 59301,
    SPELL_DARK_SLASH                        = 48292,
    SPELL_FETID_ROT_N                       = 48291,
    SPELL_FETID_ROT_H                       = 59300,
    SPELL_SCREAMS_OF_THE_DEAD               = 51750,
    SPELL_SPIRIT_BURST_N                    = 48529, // when Ranulf
    SPELL_SPIRIT_BURST_H                    = 59305, // when Ranulf
    SPELL_SPIRIT_STRIKE_N                   = 48423, // when Haldor
    SPELL_SPIRIT_STRIKE_H                   = 59304, // when Haldor

    SPELL_SUMMON_AVENGING_SPIRIT            = 48592,
    SPELL_SUMMON_SPIRIT_FOUNT               = 48386,

    SPELL_CHANNEL_SPIRIT_TO_YMIRON          = 48316,
    SPELL_CHANNEL_YMIRON_TO_SPIRIT          = 48307,

    SPELL_SPIRIT_FOUNT_N                    = 48380,
    SPELL_SPIRIT_FOUNT_H                    = 59320,

    SPELL_FLAMES                            = 39199,

    // NPCS
    NPC_BJORN                               = 27303, // Near Right Boat, summon Spirit Fount
    NPC_BJORN_VISUAL                        = 27304,
    NPC_HALDOR                              = 27307, // Near Left Boat, debuff Spirit Strike on player
    NPC_HALDOR_VISUAL                       = 27310,
    NPC_RANULF                              = 27308, // Far Left Boat, ability to cast spirit burst
    NPC_RANULF_VISUAL                       = 27311,
    NPC_TORGYN                              = 27309, // Far Right Boat, summon 4 Avenging Spirit
    NPC_TORGYN_VISUAL                       = 27312,

    NPC_SPIRIT_FOUNT                        = 27339,
    NPC_AVENGING_SPIRIT                     = 27386,
};

enum Events
{
    EVENT_YMIRON_HEALTH_CHECK           = 1,
    EVENT_YMIRON_BANE                   = 2,
    EVENT_YMIRON_FETID_ROT              = 3,
    EVENT_YMIRON_DARK_SLASH             = 4,
    EVENT_YMIRON_ACTIVATE_BOAT          = 5,
    EVENT_YMIRON_BJORN_ABILITY          = 6,
    EVENT_YMIRON_RANULF_ABILITY         = 7,
    EVENT_YMIRON_HALDOR_ABILITY         = 8,
    EVENT_YMIRON_TORGYN_ABILITY         = 9,
    EVENT_YMIRON_RESTORE                = 10,
};

struct ActiveBoatStruct
{
    uint32 trigger;
    uint32 npc;
    uint32 say;
    float MoveX, MoveY, MoveZ, SpawnX, SpawnY, SpawnZ, SpawnO;
};

static ActiveBoatStruct BoatStructure[4] =
{
    {NPC_RANULF,  NPC_RANULF_VISUAL,  SAY_SUMMON_RANULF,  404.379f, -335.335f, 104.756f, 413.594f, -335.408f, 107.995f, 3.157f},
    {NPC_TORGYN, NPC_TORGYN_VISUAL, SAY_SUMMON_TORGYN, 380.813f, -335.069f, 104.756f, 369.994f, -334.771f, 107.995f, 6.232f},
    {NPC_BJORN, NPC_BJORN_VISUAL, SAY_SUMMON_BJORN, 381.546f, -314.362f, 104.756f, 370.841f, -314.426f, 107.995f, 6.232f},
    {NPC_HALDOR, NPC_HALDOR_VISUAL, SAY_SUMMON_HALDOR, 404.310f, -314.761f, 104.756f, 413.992f, -314.703f, 107.995f, 3.157f}
};

class boss_ymiron : public CreatureScript
{
public:
    boss_ymiron() : CreatureScript("boss_ymiron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUtgardePinnacleAI<boss_ymironAI>(pCreature);
    }

    struct boss_ymironAI : public ScriptedAI
    {
        boss_ymironAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me), summons2(me)
        {
            pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        SummonList summons2;
        uint8 BoatNum;
        uint8 BoatOrder[4];

        void Reset() override
        {
            for (uint8 i = 0; i < 4; ++i)
            {
                bool good;
                do
                {
                    good = true;
                    BoatOrder[i] = urand(0, 3);

                    for (uint8 j = 0; j < i; ++j)
                        if (BoatOrder[i] == BoatOrder[j])
                        {
                            good = false;
                            break;
                        }
                } while (!good);
            }

            events.Reset();
            summons.DespawnAll();
            summons2.DespawnAll();
            BoatNum = 0;

            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);

            if (pInstance)
            {
                pInstance->SetData(DATA_KING_YMIRON, NOT_STARTED);
                pInstance->SetData(DATA_YMIRON_ACHIEVEMENT, true);

                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                if (pInstance->GetData(DATA_SKADI_THE_RUTHLESS) == DONE)
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode(why);
        }

        void JustEngagedWith(Unit*  /*pWho*/) override
        {
            Talk(SAY_AGGRO);
            if (pInstance)
            {
                pInstance->SetData(DATA_KING_YMIRON, IN_PROGRESS);
                if (pInstance->GetData(DATA_SKADI_THE_RUTHLESS) == DONE)
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }

            events.RescheduleEvent(EVENT_YMIRON_BANE, 18s);
            events.RescheduleEvent(EVENT_YMIRON_FETID_ROT, 8s);
            events.RescheduleEvent(EVENT_YMIRON_DARK_SLASH, 28s);
            events.RescheduleEvent(EVENT_YMIRON_HEALTH_CHECK, 1s);
        }

        void MovementInform(uint32 uiType, uint32 point) override
        {
            if (uiType != POINT_MOTION_TYPE)
                return;

            if (point == 0)
            {
                Talk(BoatStructure[BoatOrder[BoatNum - 1]].say);
                if (Creature* cr = me->FindNearestCreature(BoatStructure[BoatOrder[BoatNum - 1]].trigger, 50.0f))
                    me->CastSpell(cr, SPELL_CHANNEL_YMIRON_TO_SPIRIT, true);

                events.ScheduleEvent(EVENT_YMIRON_ACTIVATE_BOAT, 6s);
            }
        }

        void SpellHitTarget(Unit*, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == 59302 && pInstance) // Bane trigger
                pInstance->SetData(DATA_YMIRON_ACHIEVEMENT, false);
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
                case EVENT_YMIRON_HEALTH_CHECK:
                    {
                        if (me->GetHealth() < std::max(0.0f, float(me->GetMaxHealth() * (1.0f - (IsHeroic() ? 0.2f : 0.334f)*float(BoatNum + 1)))))
                        {
                            events.DelayEvents(12000);
                            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            me->InterruptNonMeleeSpells(true);
                            me->CastSpell(me, SPELL_SCREAMS_OF_THE_DEAD, true);
                            me->GetMotionMaster()->Clear();
                            me->GetMotionMaster()->MovePoint(0, BoatStructure[BoatOrder[BoatNum]].MoveX, BoatStructure[BoatOrder[BoatNum]].MoveY, BoatStructure[BoatOrder[BoatNum]].MoveZ);
                            me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                            summons.DespawnAll();

                            // Spawn flames in previous boat if any
                            if (BoatNum) // different than 0
                                if (Creature* cr = me->SummonTrigger(BoatStructure[BoatOrder[BoatNum - 1]].SpawnX, BoatStructure[BoatOrder[BoatNum - 1]].SpawnY, BoatStructure[BoatOrder[BoatNum - 1]].SpawnZ, 0, 1800000))
                                {
                                    cr->AddAura(SPELL_FLAMES, cr);
                                    summons2.Summon(cr);
                                }

                            BoatNum++;
                        }

                        events.Repeat(1s);
                        break;
                    }
                case EVENT_YMIRON_BANE:
                    {
                        me->CastSpell(me, IsHeroic() ? SPELL_BANE_H : SPELL_BANE_N, false);
                        events.Repeat(20s, 25s);
                        break;
                    }
                case EVENT_YMIRON_FETID_ROT:
                    {
                        me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_FETID_ROT_H : SPELL_FETID_ROT_N, false);
                        events.Repeat(10s, 13s);
                        break;
                    }
                case EVENT_YMIRON_DARK_SLASH:
                    {
                        int32 dmg = me->GetVictim()->GetHealth() / 2;
                        me->CastCustomSpell(me->GetVictim(), SPELL_DARK_SLASH, &dmg, 0, 0, false);
                        events.Repeat(30s, 35s);
                        break;
                    }
                case EVENT_YMIRON_ACTIVATE_BOAT:
                    {
                        // Spawn it!
                        if (Creature* king = me->SummonCreature(BoatStructure[BoatOrder[BoatNum - 1]].npc, BoatStructure[BoatOrder[BoatNum - 1]].SpawnX, BoatStructure[BoatOrder[BoatNum - 1]].SpawnY, BoatStructure[BoatOrder[BoatNum - 1]].SpawnZ, BoatStructure[BoatOrder[BoatNum - 1]].SpawnO, TEMPSUMMON_CORPSE_DESPAWN, 0))
                        {
                            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            king->CastSpell(me, SPELL_CHANNEL_SPIRIT_TO_YMIRON, true);
                            summons.Summon(king);
                            king->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                            king->SetDisableGravity(true);
                            me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                            switch (BoatOrder[BoatNum - 1])
                            {
                                case 0:
                                    events.ScheduleEvent(EVENT_YMIRON_RANULF_ABILITY, 3s, 1);
                                    break;
                                case 1:
                                    events.ScheduleEvent(EVENT_YMIRON_TORGYN_ABILITY, 3s, 1);
                                    break;
                                case 2:
                                    events.ScheduleEvent(EVENT_YMIRON_BJORN_ABILITY, 3s, 1);
                                    break;
                                case 3:
                                    events.ScheduleEvent(EVENT_YMIRON_HALDOR_ABILITY, 3s, 1);
                                    break;
                            }
                        }

                        break;
                    }
                case EVENT_YMIRON_BJORN_ABILITY:
                    {
                        if (Creature* sf = me->SummonCreature(NPC_SPIRIT_FOUNT, 385 + rand() % 10, -330 + rand() % 10, 104.756f, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 180000))
                        {
                            summons.Summon(sf);
                            sf->SetSpeed(MOVE_RUN, 0.4f);
                            sf->AddAura(IsHeroic() ? SPELL_SPIRIT_FOUNT_H : SPELL_SPIRIT_FOUNT_N, sf);
                            sf->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            sf->GetMotionMaster()->MoveFollow(me->GetVictim(), 0, rand_norm()*M_PI * 2);
                        }
                        break;
                    }
                case EVENT_YMIRON_HALDOR_ABILITY:
                    {
                        me->CastSpell(me->GetVictim(), IsHeroic() ? SPELL_SPIRIT_STRIKE_H : SPELL_SPIRIT_STRIKE_N, false);
                        events.Repeat(5s);
                        break;
                    }
                case EVENT_YMIRON_RANULF_ABILITY:
                    {
                        me->CastSpell(me, IsHeroic() ? SPELL_SPIRIT_BURST_H : SPELL_SPIRIT_BURST_N, false);
                        events.Repeat(10s);
                        break;
                    }
                case EVENT_YMIRON_TORGYN_ABILITY:
                    {
                        for(uint8 i = 0; i < 4; ++i)
                        {
                            if (Creature* as = me->SummonCreature(NPC_AVENGING_SPIRIT, me->GetPositionX() + rand() % 10, me->GetPositionY() + rand() % 10, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                            {
                                summons.Summon(as);
                                as->SetInCombatWithZone();
                            }
                        }
                        events.Repeat(15s);
                        break;
                    }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit*  /*pKiller*/) override
        {
            Talk(SAY_DEATH);
            summons.DespawnAll();
            summons2.DespawnAll();

            if (pInstance)
                pInstance->SetData(DATA_KING_YMIRON, DONE);
        }

        void KilledUnit(Unit*  /*pVictim*/) override
        {
            if (urand(0, 1))
                return;

            Talk(SAY_SLAY);
        }
    };
};

void AddSC_boss_ymiron()
{
    new boss_ymiron();
}
