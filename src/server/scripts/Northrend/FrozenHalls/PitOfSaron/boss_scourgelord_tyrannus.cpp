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
#include "ScriptedCreature.h"
#include "Vehicle.h"
#include "pit_of_saron.h"

enum Texts
{
    SAY_AGGRO                           = 2,
    SAY_SLAY                            = 3,
    SAY_DEATH                           = 4,
    SAY_MARK                            = 5,
    EMOTE_MARK                          = 6,
    SAY_DARK_MIGHT                      = 7,
    EMOTE_DARK_MIGHT                    = 8,
};

enum Spells
{
    SPELL_OVERLORDS_BRAND               = 69172,
    SPELL_OVERLORDS_BRAND_HEAL          = 69190,
    SPELL_OVERLORDS_BRAND_DAMAGE        = 69189,
    SPELL_FORCEFUL_SMASH                = 69155,
    SPELL_UNHOLY_POWER                  = 69167,
    SPELL_RIMEFANG_ICY_BLAST            = 69232,
    SPELL_MARK_OF_RIMEFANG              = 69275,
    SPELL_RIMEFANG_HOARFROST            = 69246,
    SPELL_RIDE_VEHICLE_HARDCODED        = 46598,
    SPELL_FULL_HEAL                     = 43979,
};

enum Events
{
    EVENT_SPELL_FORCEFUL_SMASH = 1,
    EVENT_SPELL_UNHOLY_POWER,
    EVENT_SPELL_OVERLORDS_BRAND,
    EVENT_RIMEFANG_ICY_BLAST,
    EVENT_SPELL_MARK_OF_RIMEFANG,
};

class boss_tyrannus : public CreatureScript
{
public:
    boss_tyrannus() : CreatureScript("boss_tyrannus") { }

    struct boss_tyrannusAI : public ScriptedAI
    {
        boss_tyrannusAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = me->GetInstanceScript();
            me->SetReactState(REACT_PASSIVE);
            if (Creature* rimefang = _instance->instance->GetCreature(_instance->GetGuidData(DATA_RIMEFANG_GUID)))
                rimefang->SetCanFly(true);
        }

        void Reset() override
        {
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            events.Reset();
            _instance->SetData(DATA_TYRANNUS, NOT_STARTED);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (Creature* general = _instance->instance->GetCreature(_instance->GetGuidData(DATA_MARTIN_OR_GORKUN_GUID)))
            {
                general->AI()->DoAction(ACTION_DESPAWN_SUMMONS);
                general->DespawnOrUnsummon();
                _instance->SetGuidData(DATA_MARTIN_OR_GORKUN_GUID, ObjectGuid::Empty);
            }

            // Tyrannus is temporarily spawned as Rimefang's rider. If he evades, despawn Rimefang.
            // Tyrannus will be respawned once Rimefang respawns.
            if (Creature* rimefang = _instance->instance->GetCreature(_instance->GetGuidData(DATA_RIMEFANG_GUID)))
                rimefang->DespawnOnEvade();

            me->DespawnOrUnsummon();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_TYRANNUS_FIGHT)
            {
                Position const exitPos = {1023.46f, 159.12f, 628.2f, 5.23f};
                if (Creature* rimefang = _instance->instance->GetCreature(_instance->GetGuidData(DATA_RIMEFANG_GUID)))
                {
                    rimefang->RemoveAura(SPELL_RIDE_VEHICLE_HARDCODED);
                    rimefang->GetMotionMaster()->Clear();
                    rimefang->GetMotionMaster()->MoveWaypoint(PATH_RIMEFANG_TYRANNUS_FIGHT, true);
                }
                me->SetHomePosition(exitPos);
                me->GetMotionMaster()->MoveJump(exitPos, 10.0f, 2.0f);

                // start real fight
                me->RemoveAllAuras();
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToPC(false);
                DoZoneInCombat();
                DoCastSelf(SPELL_FULL_HEAL, true);
                Talk(SAY_AGGRO);
                events.Reset();
                events.RescheduleEvent(EVENT_SPELL_FORCEFUL_SMASH, 14s, 16s);
                events.RescheduleEvent(EVENT_SPELL_OVERLORDS_BRAND, 4s, 6s);
                events.RescheduleEvent(EVENT_RIMEFANG_ICY_BLAST, 5s);
                events.RescheduleEvent(EVENT_SPELL_MARK_OF_RIMEFANG, 25s);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (me->GetVictim())
            {
                float x, y, z;
                me->GetVictim()->GetPosition(x, y, z);
                if (TSDistCheckPos.GetExactDist(x, y, z) > 100.0f || z > TSDistCheckPos.GetPositionZ() + 20.0f || z < TSDistCheckPos.GetPositionZ() - 20.0f)
                {
                    me->SetHealth(me->GetMaxHealth());
                    EnterEvadeMode(EVADE_REASON_OTHER);
                    return;
                }
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_FORCEFUL_SMASH:
                    if (me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        DoCastVictim(SPELL_FORCEFUL_SMASH);

                        events.RescheduleEvent(EVENT_SPELL_UNHOLY_POWER, 1s);
                        break;
                    }
                    events.Repeat(3s);
                    break;
                case EVENT_SPELL_UNHOLY_POWER:
                    Talk(SAY_DARK_MIGHT);
                    Talk(EMOTE_DARK_MIGHT);
                    DoCastSelf(SPELL_UNHOLY_POWER);

                    events.ScheduleEvent(EVENT_SPELL_FORCEFUL_SMASH, 40s, 48s);
                    break;
                case EVENT_SPELL_OVERLORDS_BRAND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 95.0f, true))
                        DoCast(target, SPELL_OVERLORDS_BRAND);
                    events.Repeat(11s, 12s);
                    break;
                case EVENT_RIMEFANG_ICY_BLAST:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 190.0f, true))
                        if (Creature* rimefang = _instance->instance->GetCreature(_instance->GetGuidData(DATA_RIMEFANG_GUID)))
                            rimefang->CastSpell(target, SPELL_RIMEFANG_ICY_BLAST, false);
                    events.Repeat(5s);
                    break;
                case EVENT_SPELL_MARK_OF_RIMEFANG:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 190.0f, true))
                        if (Creature* rimefang = _instance->instance->GetCreature(_instance->GetGuidData(DATA_RIMEFANG_GUID)))
                        {
                            Talk(SAY_MARK);
                            Talk(EMOTE_MARK, target);
                            rimefang->CastSpell(target, SPELL_RIMEFANG_HOARFROST, false);
                        }
                    events.Repeat(25s);
                    events.RescheduleEvent(EVENT_RIMEFANG_ICY_BLAST, 10s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            _instance->SetData(DATA_TYRANNUS, DONE);
            if (me->IsSummon())
                me->ToTempSummon()->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                Talk(SAY_SLAY);
        }

        bool CanAIAttack(Unit const* who) const override
        {
            switch (who->GetEntry())
            {
                case NPC_MARTIN_VICTUS_2:
                case NPC_GORKUN_IRONSKULL_2:
                case NPC_FREED_SLAVE_1_ALLIANCE:
                case NPC_FREED_SLAVE_2_ALLIANCE:
                case NPC_FREED_SLAVE_3_ALLIANCE:
                case NPC_FREED_SLAVE_1_HORDE:
                case NPC_FREED_SLAVE_2_HORDE:
                case NPC_FREED_SLAVE_3_HORDE:
                    return false;
                default:
                    return true;
            }
        }

    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<boss_tyrannusAI>(creature);
    }
};

void AddSC_boss_tyrannus()
{
    new boss_tyrannus();
}
