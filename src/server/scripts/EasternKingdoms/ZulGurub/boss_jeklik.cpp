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
#include "zulgurub.h"

enum Says
{
    SAY_AGGRO                   = 0,
    SAY_RAIN_FIRE               = 1,
    SAY_DEATH                   = 2
};

enum Spells
{
    // Intro
    SPELL_GREEN_CHANNELING      = 13540,
    SPELL_BAT_FORM              = 23966,

    // Phase one
    SPELL_PIERCE_ARMOR          = 12097,
    SPELL_BLOOD_LEECH           = 22644,
    SPELL_CHARGE                = 22911,
    SPELL_SONIC_BURST           = 23918,
    SPELL_SWOOP                 = 23919,
    SPELL_SUMMON_BATS           = 23974,

    // Phase two
    SPELL_CURSE_OF_BLOOD        = 16098,
    SPELL_PSYCHIC_SCREAM        = 22884,
    SPELL_SHADOW_WORD_PAIN      = 23952,
    SPELL_MIND_FLAY             = 23953,
    SPELL_GREATER_HEAL          = 23954,

    // Batriders Spell
    SPELL_BOMB                  = 40332 // Wrong ID but Magmadars bomb is not working...
};

enum BatIds
{
    NPC_BLOODSEEKER_BAT         = 11368,
    NPC_FRENZIED_BAT            = 14965
};

enum Events
{
    // Phase one
    EVENT_CHARGE_JEKLIK         = 1,
    EVENT_PIERCE_ARMOR,
    EVENT_BLOOD_LEECH,
    EVENT_SONIC_BURST,
    EVENT_SWOOP,
    EVENT_SUMMON_BATS,

    // Phase two
    EVENT_CURSE_OF_BLOOD,
    EVENT_PSYCHIC_SCREAM,
    EVENT_SHADOW_WORD_PAIN,
    EVENT_MIND_FLAY,
    EVENT_GREATER_HEAL,
    EVENT_SPAWN_FLYING_BATS
};

enum Phase
{
    PHASE_ONE                   = 1,
    PHASE_TWO                   = 2
};

Position const SpawnBat[6] =
{
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12291.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12289.6220f, -1380.2640f, 144.8304f, 5.483f },
    { -12293.6220f, -1380.2640f, 144.8304f, 5.483f }
};

class boss_jeklik : public CreatureScript
{
public:
    boss_jeklik() : CreatureScript("boss_jeklik") { }

    struct boss_jeklikAI : public BossAI
    {
        boss_jeklikAI(Creature* creature) : BossAI(creature, DATA_JEKLIK) { }

        void Reset() override
        {
            DoCast(me, SPELL_GREEN_CHANNELING);
            _Reset();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(SAY_AGGRO);
            events.SetPhase(PHASE_ONE);

            events.ScheduleEvent(EVENT_CHARGE_JEKLIK, urand(15000, 25000), 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_PIERCE_ARMOR, urand(5000, 15000), 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_BLOOD_LEECH, urand(10000, 20000), 0, PHASE_ONE);            
            events.ScheduleEvent(EVENT_SONIC_BURST, urand(10000, 20000), 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_SWOOP, urand(10000, 20000), 0, PHASE_ONE);
            events.ScheduleEvent(EVENT_SUMMON_BATS, 60000, 0, PHASE_ONE);

            me->SetDisableGravity(true);
            me->RemoveAurasDueToSpell(SPELL_GREEN_CHANNELING);
            DoCast(me, SPELL_BAT_FORM);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (events.IsInPhase(PHASE_ONE) && !HealthAbovePct(50))
            {
                me->RemoveAurasDueToSpell(SPELL_BAT_FORM);
                me->SetDisableGravity(false);
                DoResetThreat();
                events.SetPhase(PHASE_TWO);

                events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, urand(5000, 10000), 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 6000, 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, urand(10000, 30000), 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_MIND_FLAY, 11000, 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_GREATER_HEAL, 25000, 0, PHASE_TWO);
                events.ScheduleEvent(EVENT_SPAWN_FLYING_BATS, 10000, 0, PHASE_TWO);

                return;
            }
        }

        void UpdateAI(uint32 diff) override
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
                    case EVENT_CHARGE_JEKLIK:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            DoCast(target, SPELL_CHARGE);
                            AttackStart(target);
                        }
                        events.ScheduleEvent(EVENT_CHARGE_JEKLIK, urand(15000, 25000), 0, PHASE_ONE);
                        break;
                    case EVENT_PIERCE_ARMOR:
                        DoCastVictim(SPELL_PIERCE_ARMOR);
                        events.ScheduleEvent(EVENT_PIERCE_ARMOR, urand(20000, 40000), 0, PHASE_ONE);
                        break;
                    case EVENT_BLOOD_LEECH:
                        DoCastVictim(SPELL_BLOOD_LEECH);
                        events.ScheduleEvent(EVENT_BLOOD_LEECH, urand(10000, 20000), 0, PHASE_ONE);
                        break;
                    case EVENT_SONIC_BURST:
                        DoCastVictim(SPELL_SONIC_BURST);
                        events.ScheduleEvent(EVENT_SONIC_BURST, urand(20000, 40000), 0, PHASE_ONE);
                        break;
                    case EVENT_SWOOP:
                        DoCastVictim(SPELL_SWOOP);
                        events.ScheduleEvent(EVENT_SWOOP, urand(10000, 20000), 0, PHASE_ONE);
                        break;
                    case EVENT_SUMMON_BATS:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                            for (uint8 i = 0; i < 6; ++i)
                                if (Creature* bat = me->SummonCreature(NPC_BLOODSEEKER_BAT, SpawnBat[i], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                    bat->AI()->AttackStart(target);
                        events.ScheduleEvent(EVENT_SUMMON_BATS, 60000, 0, PHASE_ONE);
                        break;
                    //Phase two
                    case EVENT_CURSE_OF_BLOOD:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        {
                            DoCast(target, SPELL_CURSE_OF_BLOOD);
                            AttackStart(target);
                        }
                        events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, urand(20000, 30000), 0, PHASE_TWO);
                        break;
                    case EVENT_PSYCHIC_SCREAM:
                        DoCastVictim(SPELL_PSYCHIC_SCREAM);
                        events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, urand(35000, 40000), 0, PHASE_TWO);
                        break;                   
                    case EVENT_SHADOW_WORD_PAIN:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                            DoCast(target, SPELL_SHADOW_WORD_PAIN);
                        events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, urand(12000, 18000), 0, PHASE_TWO);
                        break;
                    case EVENT_MIND_FLAY:
                        DoCastVictim(SPELL_MIND_FLAY);
                        events.ScheduleEvent(EVENT_MIND_FLAY, 16000, 0, PHASE_TWO);
                        break;
                    case EVENT_GREATER_HEAL:
                        me->InterruptNonMeleeSpells(false);
                        DoCastSelf(SPELL_GREATER_HEAL);
                        events.ScheduleEvent(EVENT_GREATER_HEAL, urand(25000, 35000), 0, PHASE_TWO);
                        break;
                    case EVENT_SPAWN_FLYING_BATS:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                            if (Creature* flyingBat = me->SummonCreature(NPC_FRENZIED_BAT, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ() + 15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                flyingBat->AI()->AttackStart(target);
                        events.ScheduleEvent(EVENT_SPAWN_FLYING_BATS, urand(10000, 15000), 0, PHASE_TWO);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_jeklikAI>(creature);
    }
};

// Flying Bat
class npc_batrider : public CreatureScript
{
public:
    npc_batrider() : CreatureScript("npc_batrider") { }

    struct npc_batriderAI : public ScriptedAI
    {
        npc_batriderAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 Bomb_Timer;

        void Reset() override
        {
            Bomb_Timer = 2000;
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->AddUnitState(UNIT_STATE_ROOT);
        }

        void EnterCombat(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (Bomb_Timer <= diff)
            {
                std::list<Unit*> targets;
                SelectTargetList(targets, 1, SelectTargetMethod::Random, 500.0f, true);
                if (!targets.empty())
                {
                    if (targets.size() > 1)
                    {
                        targets.resize(1);
                    }
                }

                for (std::list<Unit*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                {
                    me->CastSpell((*itr), SPELL_BOMB);
                }

                Bomb_Timer = 7000;
            }
            else
                Bomb_Timer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<npc_batriderAI>(creature);
    }
};

void AddSC_boss_jeklik()
{
    new boss_jeklik();
    new npc_batrider();
}
