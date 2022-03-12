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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "violet_hold.h"

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SPAWN                                   = 3,
    SAY_DISRUPTION                              = 4,
    SAY_BREATH_ATTACK                           = 5,
    SAY_SPECIAL_ATTACK                          = 6
};

enum eSpells
{
    SPELL_ARCANE_VACUUM                             = 58694,
    SPELL_BLIZZARD_N                                = 58693,
    SPELL_BLIZZARD_H                                = 59369,
    SPELL_MANA_DESTRUCTION                          = 59374,
    SPELL_TAIL_SWEEP_N                              = 58690,
    SPELL_TAIL_SWEEP_H                              = 59283,
    SPELL_UNCONTROLLABLE_ENERGY_N                   = 58688,
    SPELL_UNCONTROLLABLE_ENERGY_H                   = 59281,
};

#define SPELL_BLIZZARD                              DUNGEON_MODE(SPELL_BLIZZARD_N, SPELL_BLIZZARD_H)
#define SPELL_TAIL_SWEEP                            DUNGEON_MODE(SPELL_TAIL_SWEEP_N, SPELL_TAIL_SWEEP_H)
#define SPELL_UNCONTROLLABLE_ENERGY                 DUNGEON_MODE(SPELL_UNCONTROLLABLE_ENERGY_N, SPELL_UNCONTROLLABLE_ENERGY_H)

enum eEvents
{
    EVENT_SPELL_ARCANE_VACUUM = 1,
    EVENT_SPELL_BLIZZARD,
    EVENT_SPELL_MANA_DESTRUCTION,
    EVENT_SPELL_TAIL_SWEEP,
    EVENT_SPELL_UNCONTROLLABLE_ENERGY,
    EVENT_UNROOT,
};

class boss_cyanigosa : public CreatureScript
{
public:
    boss_cyanigosa() : CreatureScript("boss_cyanigosa") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<boss_cyanigosaAI>(pCreature);
    }

    struct boss_cyanigosaAI : public ScriptedAI
    {
        boss_cyanigosaAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();
            Talk(SAY_AGGRO);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_ARCANE_VACUUM, 30000);
            events.RescheduleEvent(EVENT_SPELL_BLIZZARD, urand(5000, 10000));
            events.RescheduleEvent(EVENT_SPELL_TAIL_SWEEP, urand(15000, 20000));
            events.RescheduleEvent(EVENT_SPELL_UNCONTROLLABLE_ENERGY, urand(5000, 8000));
            if (IsHeroic())
                events.RescheduleEvent(EVENT_SPELL_MANA_DESTRUCTION, 20000);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (!target || !spell)
                return;
            switch(spell->Id)
            {
                case SPELL_ARCANE_VACUUM:
                    target->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 10.0f, target->GetOrientation());
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_ARCANE_VACUUM:
                    me->CastSpell((Unit*)nullptr, SPELL_ARCANE_VACUUM, false);
                    DoResetThreat();
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->setAttackTimer(BASE_ATTACK, 3000);
                    events.RepeatEvent(30000);
                    events.ScheduleEvent(EVENT_UNROOT, 3000);
                    break;
                case EVENT_UNROOT:
                    me->SetControlled(false, UNIT_STATE_ROOT);

                    break;
                case EVENT_SPELL_BLIZZARD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 45.0f, true))
                        me->CastSpell(target, SPELL_BLIZZARD, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SPELL_MANA_DESTRUCTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_MANA_DESTRUCTION, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_TAIL_SWEEP:
                    me->CastSpell(me->GetVictim(), SPELL_TAIL_SWEEP, false);
                    events.RepeatEvent(urand(15000, 20000));
                    break;
                case EVENT_SPELL_UNCONTROLLABLE_ENERGY:
                    me->CastSpell(me->GetVictim(), SPELL_UNCONTROLLABLE_ENERGY, false);
                    events.RepeatEvent(urand(20000, 25000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
            float h = me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            if (h != INVALID_HEIGHT && me->GetPositionZ() - h > 3.0f)
            {
                me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), h, me->GetOrientation(), true); // move to ground
                me->StopMovingOnCurrentPos();
                me->DestroyForNearbyPlayers();
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;
            Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void EnterEvadeMode() override
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode();
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

void AddSC_boss_cyanigosa()
{
    new boss_cyanigosa();
}
