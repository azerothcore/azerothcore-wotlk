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
    SAY_HAND                                = 7,
    SAY_WRATH                               = 8,
    SAY_KILL                                = 9,
    SAY_MAGMABURST                          = 10
};

enum Spells
{
    SPELL_HAND_OF_RAGNAROS                  = 19780,
    SPELL_WRATH_OF_RAGNAROS                 = 20566,
    SPELL_LAVA_BURST                        = 21158,
    SPELL_MAGMA_BLAST                       = 20565,                   // Ranged attack
    SPELL_SONS_OF_FLAME_DUMMY               = 21108,                   // Server side effect
    SPELL_RAGSUBMERGE                       = 21107,                   // Stealth aura
    SPELL_RAGNA_SUBMERGE_VISUAL             = 20567,                   // Visual for submerging into lava
    SPELL_RAGEMERGE                         = 20568,
    SPELL_MELT_WEAPON                       = 21387,
    SPELL_ELEMENTAL_FIRE                    = 20563,
    SPELL_ERRUPTION                         = 17731,
    SPELL_RAGNAROS_SUBMERGE_EFFECT          = 21859,    // Applies pacify state and applies all schools immunity
};

enum Events
{
    EVENT_ERUPTION              = 1,
    EVENT_WRATH_OF_RAGNAROS,
    EVENT_HAND_OF_RAGNAROS,
    EVENT_LAVA_BURST,
    EVENT_MAGMA_BLAST,
    EVENT_SUBMERGE,

    EVENT_INTRO_1,
    EVENT_INTRO_2,
    EVENT_INTRO_3,
    EVENT_INTRO_4,
    EVENT_INTRO_5,
};

enum Creatures
{
    NPC_SON_OF_FLAME            = 12143,
};

enum Misc
{
    MAX_SON_OF_FLAME_COUNT      = 8,
};

constexpr float DEATH_ORIENTATION = 4.0f;

class boss_ragnaros : public CreatureScript
{
public:
    boss_ragnaros() : CreatureScript("boss_ragnaros") {}

    struct boss_ragnarosAI : public BossAI
    {
        boss_ragnarosAI(Creature* creature) : BossAI(creature, DATA_RAGNAROS),
            attackableTImer(0),
            _emergeTimer(90000),
            _hasYelledMagmaBurst(false),
            _hasSubmergedOnce(false),
            _isBanished(false)
        {
            creature->SetReactState(REACT_PASSIVE);
            creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void Reset() override
        {
            _Reset();
            _emergeTimer = 90000;
            _hasYelledMagmaBurst = false;
            _hasSubmergedOnce = false;
            _isBanished = false;
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
            DoCastSelf(SPELL_MELT_WEAPON, true);
            DoCastSelf(SPELL_ELEMENTAL_FIRE, true);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_FINISH_RAGNAROS_INTRO)
            {
                attackableTImer = 10000;
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
        {
            summons.Despawn(summon);
        }

        void EnterCombat(Unit* /*victim*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_ERUPTION, 15000);
            events.ScheduleEvent(EVENT_WRATH_OF_RAGNAROS, 30000);
            events.ScheduleEvent(EVENT_HAND_OF_RAGNAROS, 25000);
            events.ScheduleEvent(EVENT_LAVA_BURST, 10000);
            events.ScheduleEvent(EVENT_MAGMA_BLAST, 2000);
            events.ScheduleEvent(EVENT_SUBMERGE, 180000);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            me->SetFacingTo(DEATH_ORIENTATION);
        }

        void KilledUnit(Unit* victim) override
        {
            if (roll_chance_i(25) && victim->GetTypeId() == TYPEID_PLAYER)
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
            if (attackableTImer)
            {
                if (attackableTImer <= diff)
                {
                    me->RemoveAurasDueToSpell(SPELL_RAGNAROS_SUBMERGE_EFFECT);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NON_ATTACKABLE);
                    me->SetReactState(REACT_AGGRESSIVE);
                    DoZoneInCombat();
                    attackableTImer = 0;
                }
                else
                {
                    attackableTImer -= diff;
                }
            }

            if (_isBanished && (_emergeTimer <= diff || !summons.HasEntry(NPC_SON_OF_FLAME)))
            {
                //Become unbanished again
                me->SetReactState(REACT_AGGRESSIVE);
                me->SetFaction(14);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                {
                    AttackStart(target);
                }

                _isBanished = false;
            }
            else if (_isBanished)
            {
                _emergeTimer -= diff;
                return;
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
            while (uint32 const eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ERUPTION:
                    {
                        DoCastVictim(SPELL_ERRUPTION);
                        events.RepeatEvent(urand(20000, 45000));
                        break;
                    }
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
                        if (urand(0, 1))
                        {
                            Talk(SAY_HAND);
                        }
                        events.RepeatEvent(20000);
                        break;
                    }
                    case EVENT_LAVA_BURST:
                    {
                        DoCastVictim(SPELL_LAVA_BURST);
                        events.RepeatEvent(10000);
                        break;
                    }
                    case EVENT_MAGMA_BLAST:
                    {
                        Unit* victim = me->GetVictim();
                        if (victim && !me->IsWithinMeleeRange(victim))
                        {
                            DoCast(victim, SPELL_MAGMA_BLAST);
                            if (!_hasYelledMagmaBurst)
                            {
                                Talk(SAY_MAGMABURST);
                                _hasYelledMagmaBurst = true;
                            }
                        }
                        events.RepeatEvent(2500);
                        break;
                    }
                    case EVENT_SUBMERGE:
                    {
                        if (!_isBanished)
                        {
                            me->InterruptNonMeleeSpells(false);
                            me->AttackStop();
                            DoResetThreat();
                            me->SetReactState(REACT_PASSIVE);
                            me->SetFaction(35);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_SUBMERGED);
                            DoCastSelf(SPELL_RAGNA_SUBMERGE_VISUAL, true);
                            //me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);
                            SummonMinions();
                        }
                        events.ScheduleEvent(EVENT_SUBMERGE, 180000);
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
        uint32 attackableTImer;     // used after intro
        uint32 _emergeTimer;
        bool _hasYelledMagmaBurst;
        bool _hasSubmergedOnce;
        bool _isBanished;

        void SummonMinions()
        {
            Talk(_hasSubmergedOnce ? SAY_REINFORCEMENTS2 : SAY_REINFORCEMENTS1);

            for (uint8 i = 0; i < MAX_SON_OF_FLAME_COUNT; ++i)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                {
                    if (Creature* summoned = me->SummonCreature(NPC_SON_OF_FLAME, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 900000))
                    {
                        summoned->AI()->AttackStart(target);
                    }
                }
            }

            _isBanished = true;
            _emergeTimer = 90000;
            if (!_hasSubmergedOnce)
            {
                _hasSubmergedOnce = true;
            }
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
