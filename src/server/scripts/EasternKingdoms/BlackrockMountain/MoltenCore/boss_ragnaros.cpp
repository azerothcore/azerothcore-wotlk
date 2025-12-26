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
#include "SpellScript.h"
#include "SpellScriptLoader.h"
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
    SPELL_LAVA_BURST                        = 21908,    // Randomly trigger one of server side spells (21886, 21900 - 21907) which summons Go 178088
    SPELL_MAGMA_BLAST                       = 20565,    // Ranged attack
    SPELL_SONS_OF_FLAME_DUMMY               = 21108,    // Server side effect
    SPELL_RAGSUBMERGE                       = 21107,    // Stealth aura
    SPELL_RAGNA_SUBMERGE_VISUAL             = 20567,    // Visual for submerging into lava
    SPELL_RAGEMERGE                         = 20568,
    SPELL_RAGNAROS_SUBMERGE_EFFECT          = 21859,    // Applies pacify state and applies all schools immunity (server side)
    SPELL_ELEMENTAL_FIRE_KILL               = 19773,    // Spell is used only on Majordomo
    SPELL_MIGHT_OF_RAGNAROS                 = 21154,
    SPELL_INTENSE_HEAT                      = 21155,
    SPELL_SUMMON_SONS_FLAME                 = 21108,    // Trigger the eight spells summoning the Son of Flame adds

    SPELL_LAVA_BURST_A                      = 21886,
    SPELL_LAVA_BURST_B                      = 21900,
    SPELL_LAVA_BURST_C                      = 21901,
    SPELL_LAVA_BURST_D                      = 21902,
    SPELL_LAVA_BURST_E                      = 21903,
    SPELL_LAVA_BURST_F                      = 21905,
    SPELL_LAVA_BURST_G                      = 21906,
    SPELL_LAVA_BURST_H                      = 21907,
    SPELL_LAVA_BURST_TRAP                   = 21158,

    SPELL_SUMMON_SON_OF_FLAME_A             = 21117,
    SPELL_SUMMON_SON_OF_FLAME_B             = 21110,
    SPELL_SUMMON_SON_OF_FLAME_C             = 21111,
    SPELL_SUMMON_SON_OF_FLAME_D             = 21112,
    SPELL_SUMMON_SON_OF_FLAME_E             = 21113,
    SPELL_SUMMON_SON_OF_FLAME_F             = 21114,
    SPELL_SUMMON_SON_OF_FLAME_G             = 21115,
    SPELL_SUMMON_SON_OF_FLAME_H             = 21116
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
    EVENT_LAVA_BURST_TRIGGER,

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
            _processingMagmaBurst(false),
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
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
                me->SetImmuneToAll(false);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
            }

            _hasYelledMagmaBurst = false;
            _processingMagmaBurst = false;
            _hasSubmergedOnce = false;
            _isKnockbackEmoteAllowed = true;
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
            me->SetControlled(true, UNIT_STATE_ROOT);
            _lavaBurstGUIDS.clear();
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (events.IsInPhase(PHASE_SUBMERGED) && damage >= me->GetHealth())
            {
                damage = 0;
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_FINISH_RAGNAROS_INTRO)
            {
                extraEvents.SetPhase(PHASE_INTRO);
                extraEvents.ScheduleEvent(EVENT_INTRO_SAY, 5s, 0, PHASE_INTRO);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            BossAI::JustSummoned(summon);
            if (summon->GetEntry() == NPC_FLAME_OF_RAGNAROS)
            {
                summon->CastSpell((Unit*)nullptr, SPELL_INTENSE_HEAT, true, nullptr, nullptr, me->GetGUID());
            }
            else if (summon->GetEntry() == NPC_SON_OF_FLAME)
            {
                DoZoneInCombat(summon);
            }
        }

        void SetGUID(ObjectGuid const& guid, int32 index) override
        {
            if (index == GO_LAVA_BURST)
            {
                if (_lavaBurstGUIDS.empty())
                {
                    extraEvents.ScheduleEvent(EVENT_LAVA_BURST_TRIGGER, 1ms);
                }

                _lavaBurstGUIDS.insert(guid);
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

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
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

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!me->GetThreatMgr().GetThreatList().empty())
            {
                if (!_processingMagmaBurst)
                {
                    // Boss try to evade, but still got some targets on threat list - it means that none of these targets are in melee range - cast magma blast
                    _processingMagmaBurst = true;
                    events.ScheduleEvent(EVENT_MAGMA_BLAST, 4s, PHASE_EMERGED, PHASE_EMERGED);
                }
            }
            else
            {
                BossAI::EnterEvadeMode(why);
            }
        }

        bool CanAIAttack(Unit const* victim) const override
        {
            return me->IsWithinMeleeRange(victim);
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
                            extraEvents.ScheduleEvent(EVENT_INTRO_MAKE_ATTACKABLE, 2500ms, 0, PHASE_INTRO);
                            break;
                        }
                        case EVENT_INTRO_MAKE_ATTACKABLE:
                        {
                            _isIntroDone = true;
                            extraEvents.SetPhase(PHASE_EMERGED);
                            me->RemoveAurasDueToSpell(SPELL_RAGNAROS_SUBMERGE_EFFECT);
                            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            me->SetImmuneToAll(false);
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
                        case EVENT_LAVA_BURST_TRIGGER:
                        {
                            if (!_lavaBurstGUIDS.empty())
                            {
                                ObjectGuid lavaBurstGUID = Acore::Containers::SelectRandomContainerElement(_lavaBurstGUIDS);

                                if (GameObject* go = ObjectAccessor::GetGameObject(*me, lavaBurstGUID))
                                {
                                    go->CastSpell(nullptr, SPELL_LAVA_BURST_TRAP);
                                    go->SendCustomAnim(0);
                                }

                                _lavaBurstGUIDS.erase(lavaBurstGUID);
                                extraEvents.Repeat(1s);
                            }
                            else
                            {
                                events.RescheduleEvent(EVENT_LAVA_BURST, 10s, PHASE_EMERGED, PHASE_EMERGED);
                            }

                            break;
                        }
                    }
                }
            }

            if (!UpdateVictim())
            {
                if (!_processingMagmaBurst)
                {
                    return;
                }
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
                        events.Repeat(25s);
                        break;
                    }
                    case EVENT_HAND_OF_RAGNAROS:
                    {
                        DoCastSelf(SPELL_HAND_OF_RAGNAROS);
                        if (_isKnockbackEmoteAllowed)
                        {
                            Talk(SAY_KNOCKBACK);
                            _isKnockbackEmoteAllowed = false;
                            extraEvents.RescheduleEvent(EVENT_RESET_KNOCKBACK_EMOTE, 5s);
                        }
                        events.Repeat(20s);
                        break;
                    }
                    case EVENT_LAVA_BURST:
                    {
                        DoCastAOE(SPELL_LAVA_BURST);
                        break;
                    }
                    case EVENT_MAGMA_BLAST:
                    {
                        _processingMagmaBurst = false;

                        if (!IsVictimWithinMeleeRange())
                        {
                            DoCastRandomTarget(SPELL_MAGMA_BLAST);

                            if (!_hasYelledMagmaBurst)
                            {
                                Talk(SAY_MAGMABURST);
                                _hasYelledMagmaBurst = true;
                            }
                        }

                        break;
                    }
                    case EVENT_MIGHT_OF_RAGNAROS:
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, [](Unit const* target)
                        {
                            return target->IsPlayer() && target->getPowerType() == POWER_MANA;
                        }))
                        {
                            if (me->CastSpell(target, SPELL_MIGHT_OF_RAGNAROS) == SPELL_CAST_OK && _isKnockbackEmoteAllowed)
                            {
                                Talk(SAY_KNOCKBACK, me);
                                _isKnockbackEmoteAllowed = false;
                                extraEvents.RescheduleEvent(EVENT_RESET_KNOCKBACK_EMOTE, 5s);
                            }
                        }
                        events.Repeat(11s, 30s);
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
                        DoResetThreatList();
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_SUBMERGED);
                        DoCastSelf(SPELL_RAGNA_SUBMERGE_VISUAL, true);
                        //me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);

                        Talk(_hasSubmergedOnce ? SAY_REINFORCEMENTS2 : SAY_REINFORCEMENTS1);

                        DoCastAOE(SPELL_SUMMON_SONS_FLAME);

                        if (!_hasSubmergedOnce)
                        {
                            _hasSubmergedOnce = true;
                        }

                        extraEvents.ScheduleEvent(EVENT_EMERGE, 90s, PHASE_SUBMERGED, PHASE_SUBMERGED);
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
        bool _processingMagmaBurst;
        bool _hasSubmergedOnce;
        bool _isKnockbackEmoteAllowed;  // Prevents possible text overlap

        GuidSet _lavaBurstGUIDS;

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
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
            me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);

            me->RemoveAurasDueToSpell(SPELL_RAGNA_SUBMERGE_VISUAL);

            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
            {
                AttackStart(target);
            }
        }

        void ScheduleCombatEvents()
        {
            events.RescheduleEvent(EVENT_ERUPTION, 15s, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_WRATH_OF_RAGNAROS, 30s, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_HAND_OF_RAGNAROS, 25s, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_LAVA_BURST, 10s, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_SUBMERGE, 180s, PHASE_EMERGED, PHASE_EMERGED);
            events.RescheduleEvent(EVENT_MIGHT_OF_RAGNAROS, 11s, PHASE_EMERGED, PHASE_EMERGED);
        }

        bool IsVictimWithinMeleeRange() const
        {
            return me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim());
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_ragnarosAI>(creature);
    }
};

constexpr std::array<uint32, 8> RagnarosLavaBurstSpells = { SPELL_LAVA_BURST_A, SPELL_LAVA_BURST_B, SPELL_LAVA_BURST_C, SPELL_LAVA_BURST_D, SPELL_LAVA_BURST_E, SPELL_LAVA_BURST_F, SPELL_LAVA_BURST_G, SPELL_LAVA_BURST_H };

// 21908 - Lava Burst Randomizer (server side)
class spell_ragnaros_lava_burst_randomizer : public SpellScript
{
    PrepareSpellScript(spell_ragnaros_lava_burst_randomizer);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(RagnarosLavaBurstSpells);
    }

    void HandleScript()
    {
        if (Unit* caster = GetCaster())
        {
            // Select three random spells. Can select the same spell twice.
            for (uint8 i = 0; i < 3; ++i)
            {
                uint32 spell = Acore::Containers::SelectRandomContainerElement(RagnarosLavaBurstSpells);
                caster->CastSpell(caster, spell, true);
            }
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_ragnaros_lava_burst_randomizer::HandleScript);
    }
};

constexpr std::array<uint32, 8> RagnarosSoFSpells = { SPELL_SUMMON_SON_OF_FLAME_A, SPELL_SUMMON_SON_OF_FLAME_B, SPELL_SUMMON_SON_OF_FLAME_C, SPELL_SUMMON_SON_OF_FLAME_D, SPELL_SUMMON_SON_OF_FLAME_E, SPELL_SUMMON_SON_OF_FLAME_F, SPELL_SUMMON_SON_OF_FLAME_G, SPELL_SUMMON_SON_OF_FLAME_H };

// 21108 - Summon Sons of Flame (server side)
class spell_ragnaros_summon_sons_of_flame : public SpellScript
{
    PrepareSpellScript(spell_ragnaros_summon_sons_of_flame);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(RagnarosSoFSpells);
    }

    void HandleScript()
    {
        if (Unit* caster = GetCaster())
        {
            for (uint32 spell : RagnarosSoFSpells)
            {
                caster->CastSpell(caster, spell, true);
            }
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_ragnaros_summon_sons_of_flame::HandleScript);
    }
};

void AddSC_boss_ragnaros()
{
    new boss_ragnaros();
    RegisterSpellScript(spell_ragnaros_lava_burst_randomizer);
    RegisterSpellScript(spell_ragnaros_summon_sons_of_flame);
}
