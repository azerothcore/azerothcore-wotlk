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
#include "molten_core.h"

enum Texts
{
    SAY_SUMMON_MAJ                          = 0,
    SAY_ARRIVAL1_RAG                        = 1,
    SAY_ARRIVAL2_MAJ                        = 2,
    SAY_ARRIVAL3_RAG                        = 3,
    SAY_ARRIVAL5_RAG                        = 4,
    SAY_REINFORCEMENTS1                     = 5,
    SAY_REINFORCEMENTS2                     = 6,
    SAY_KNOCKBACK                           = 7,        // Text is used for SPELL_HAND_OF_RAGNAROS & SPELL_MIGHT_OF_RAGNAROS. "By fire be purged!"
    SAY_WRATH                               = 8,
    SAY_KILL                                = 9,
    SAY_MAGMABURST                          = 10,
};

enum Spells
{
    SPELL_HAND_OF_RAGNAROS                  = 19780,
    SPELL_WRATH_OF_RAGNAROS                 = 20566,
    SPELL_LAVA_BURST                        = 21908,    // Randomly trigger one of server side spells (21886, 21900 - 21907) which summons Go 178088 (TODO)
    SPELL_MAGMA_BLAST                       = 20565,    // Ranged attack
    SPELL_SONS_OF_FLAME_DUMMY               = 21108,    // Server side effect
    SPELL_RAGSUBMERGE                       = 21107,    // Stealth aura
    SPELL_RAGNA_SUBMERGE_VISUAL             = 20567,    // Visual for submerging into lava
    SPELL_RAGEMERGE                         = 20568,
    SPELL_RAGNAROS_SUBMERGE_EFFECT          = 21859,    // Applies pacify state and applies all schools immunity (server side)
    SPELL_ELEMENTAL_FIRE_KILL               = 19773,    // Spell is used only on Majordomo
    SPELL_MIGHT_OF_RAGNAROS                 = 21154,
    SPELL_INTENSE_HEAT                      = 21155,
    SPELL_SUMMON_SONS_FLAME                 = 21108,    // Trigger the eight spells summoning the Son of Flame adds (TODO)
};

enum Events
{
    EVENT_ERUPTION                          = 1,
    EVENT_WRATH_OF_RAGNAROS,
    EVENT_HAND_OF_RAGNAROS,
    EVENT_MIGHT_OF_RAGNAROS,
    EVENT_LAVA_BURST,
    EVENT_MAGMA_BLAST,
    EVENT_SUBMERGE,

    // Submerge
    EVENT_EMERGE,

    // Intro
    EVENT_INTRO_SAY,
    EVENT_INTRO_MAKE_ATTACKABLE,

    // Misc
    EVENT_RESET_KNOCKBACK_EMOTE,
};

enum Creatures
{
    NPC_SON_OF_FLAME                        = 12143,
    NPC_FLAME_OF_RAGNAROS                   = 13148,
};

enum Misc
{
    MAX_SON_OF_FLAME_COUNT                  = 8,

    // Event phase
    PHASE_INTRO                             = 1,        // Intro events with Majordomu
    PHASE_EMERGED                           = 2,        // events which are executed while Ragnaros is visible
    PHASE_SUBMERGED                         = 3,        // events which are executed while Ragnaros is submerged (not visible)
};

constexpr float DEATH_ORIENTATION = 4.0f;

class boss_ragnaros : public CreatureScript
{
public:
    boss_ragnaros() : CreatureScript("boss_ragnaros") {}

    struct boss_ragnarosAI : public BossAI
    {
        boss_ragnarosAI(Creature* creature) : BossAI(creature, DATA_RAGNAROS),
            _isIntroDone(false),
            _hasYelledMagmaBurst(false),
            _hasSubmergedOnce(false),
            _isKnockbackEmoteAllowed(true)
        {
        }

        void Reset() override
        {
            _Reset();

            // Never reset intro events!
            if (_isIntroDone && !(extraEvents.GetPhaseMask() & (1 << (PHASE_INTRO - 1))))
            {
                extraEvents.Reset();
                extraEvents.SetPhase(PHASE_EMERGED);
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
            }

            _hasYelledMagmaBurst = false;
            _hasSubmergedOnce = false;
            _isKnockbackEmoteAllowed = true;
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_FINISH_RAGNAROS_INTRO)
            {
                extraEvents.SetPhase(PHASE_INTRO);
                extraEvents.ScheduleEvent(EVENT_INTRO_SAY, 5000, 0, PHASE_INTRO);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            BossAI::JustSummoned(summon);
            if (summon->GetEntry() == NPC_FLAME_OF_RAGNAROS)
            {
                summon->CastSpell((Unit*)nullptr, SPELL_INTENSE_HEAT, true, nullptr, nullptr, me->GetGUID());
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
        {
            summons.Despawn(summon);
            if (events.IsInPhase(PHASE_SUBMERGED) && !summons.HasEntry(NPC_SON_OF_FLAME))
            {
                HandleEmerge();
            }
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();
            events.SetPhase(PHASE_EMERGED);
            ScheduleCombatEvents();
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            extraEvents.Reset();
            me->SetFacingTo(DEATH_ORIENTATION);
        }

        void KilledUnit(Unit* victim) override
        {
            if (roll_chance_i(25) && victim->IsPlayer())
            {
                Talk(SAY_KILL);
            }
        }

        void AttackStart(Unit* target) override
        {
            if (target && me->Attack(target, true))
            {
                DoStartNoMovement(target);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!extraEvents.Empty())
            {
                extraEvents.Update(diff);

                while (uint32 const eventId = extraEvents.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        // Intro events
                        case EVENT_INTRO_SAY:
                        {
                            Talk(SAY_ARRIVAL5_RAG);
                            extraEvents.ScheduleEvent(EVENT_INTRO_MAKE_ATTACKABLE, 2500, 0, PHASE_INTRO);
                            break;
                        }
                        case EVENT_INTRO_MAKE_ATTACKABLE:
                        {
                            _isIntroDone = true;
                            extraEvents.SetPhase(PHASE_EMERGED);
                            me->RemoveAurasDueToSpell(SPELL_RAGNAROS_SUBMERGE_EFFECT);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NON_ATTACKABLE);
                            me->SetReactState(REACT_AGGRESSIVE);
                            DoZoneInCombat();
                            break;
                        }
                        // Submerge events
                        case EVENT_EMERGE:
                        {
                            HandleEmerge();
                            break;
                        }
                        case EVENT_RESET_KNOCKBACK_EMOTE:
                        {
                            _isKnockbackEmoteAllowed = true;
                            break;
                        }
                    }
                }
            }

            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            // Base combat events - (mainly emerge phase)
            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_WRATH_OF_RAGNAROS:
                    {
                        DoCastVictim(SPELL_WRATH_OF_RAGNAROS);
                        if (urand(0, 1))
                        {
                            Talk(SAY_WRATH);
                        }
                        events.RepeatEvent(25000);
                        break;
                    }
                    case EVENT_HAND_OF_RAGNAROS:
                    {
                        DoCastSelf(SPELL_HAND_OF_RAGNAROS);
                        if (_isKnockbackEmoteAllowed)
                        {
                            Talk(SAY_KNOCKBACK);
                            _isKnockbackEmoteAllowed = false;
                            extraEvents.RescheduleEvent(EVENT_RESET_KNOCKBACK_EMOTE, 5000);
                        }
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_LAVA_BURST:
                    {
                        DoCastAOE(SPELL_LAVA_BURST);
                        events.RepeatEvent(10000);
                        break;
                    }
                    case EVENT_MAGMA_BLAST:
                    {
                        Unit const* victim = me->GetVictim();
                        if (victim && !me->IsWithinMeleeRange(victim))
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            {
                                DoCast(target, SPELL_MAGMA_BLAST);
                            }

                            if (!_hasYelledMagmaBurst)
                            {
                                Talk(SAY_MAGMABURST);
                                _hasYelledMagmaBurst = true;
                            }
                        }
                        else if (_hasYelledMagmaBurst)
                        {
                            _hasYelledMagmaBurst = false;
                        }

                        events.RepeatEvent(500);
                        break;
                    }
                    case EVENT_MIGHT_OF_RAGNAROS:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, [](Unit const* target)
                        {
                            return target->IsPlayer() && target->getPowerType() == POWER_MANA;
                        }))
                        {
                            if (me->CastSpell(target, SPELL_MIGHT_OF_RAGNAROS) == SPELL_CAST_OK && _isKnockbackEmoteAllowed)
                            {
                                Talk(SAY_KNOCKBACK, me);
                                _isKnockbackEmoteAllowed = false;
                                extraEvents.RescheduleEvent(EVENT_RESET_KNOCKBACK_EMOTE, 5000);
                            }
                        }
                        events.RepeatEvent(urand(11000, 30000));
                        break;
                    }
                    case EVENT_SUBMERGE:
                    {
                        events.CancelEventGroup(PHASE_EMERGED);
                        events.SetPhase(PHASE_SUBMERGED);
                        extraEvents.SetPhase(PHASE_SUBMERGED);
                        me->SetReactState(REACT_PASSIVE);
                        me->InterruptNonMeleeSpells(false);
                        me->AttackStop();
                        DoResetThreat();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_SUBMERGED);
                        DoCastSelf(SPELL_RAGNA_SUBMERGE_VISUAL, true);
                        //me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);

                        Talk(_hasSubmergedOnce ? SAY_REINFORCEMENTS2 : SAY_REINFORCEMENTS1);

                        for (uint8 i = 0; i < MAX_SON_OF_FLAME_COUNT; ++i)
                        {
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                            {
                                if (Creature* summoned = me->SummonCreature(NPC_SON_OF_FLAME, target->GetPosition(), TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 900000))
                                {
                                    summoned->AI()->AttackStart(target);
                                }
                            }
                        }

                        if (!_hasSubmergedOnce)
                        {
                            _hasSubmergedOnce = true;
                        }

                        extraEvents.ScheduleEvent(EVENT_EMERGE, 90000, PHASE_SUBMERGED, PHASE_SUBMERGED);
                        break;
                    }
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap extraEvents;
        bool _isIntroDone;
        bool _hasYelledMagmaBurst;
        bool _hasSubmergedOnce;
        bool _isKnockbackEmoteAllowed;  // Prevents possible text overlap

        void HandleEmerge()
        {
            if (events.IsInPhase(PHASE_EMERGED))
            {
                return;
            }

            events.SetPhase(PHASE_EMERGED);
            ScheduleCombatEvents();
            extraEvents.CancelEventGroup(PHASE_SUBMERGED);
            extraEvents.SetPhase(PHASE_EMERGED);

            me->SetReactState(REACT_AGGRESSIVE);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
            me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);

            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
            {
                AttackStart(target);
            }
        }

        void ScheduleCombatEvents()
        {
            events.RescheduleEvent(EVENT_ERUPTION, 15000, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_WRATH_OF_RAGNAROS, 30000, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_HAND_OF_RAGNAROS, 25000, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_LAVA_BURST, 10000, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_MAGMA_BLAST, 500, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_SUBMERGE, 180000, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_MIGHT_OF_RAGNAROS, 11000, PHASE_EMERGED, PHASE_EMERGED);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_ragnarosAI>(creature);
    }
};

void AddSC_boss_ragnaros()
{
    new boss_ragnaros();
}
