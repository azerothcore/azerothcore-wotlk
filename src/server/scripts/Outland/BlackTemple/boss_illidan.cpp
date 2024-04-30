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
#include "ScriptedEscortAI.h"
#include "SpellScriptLoader.h"
#include "black_temple.h"

enum Says
{
    SAY_ILLIDAN_MINION                  = 0,
    SAY_ILLIDAN_KILL                    = 1,
    SAY_ILLIDAN_TAKEOFF                 = 2,
    SAY_ILLIDAN_SUMMONFLAMES            = 3,
    SAY_ILLIDAN_EYE_BLAST               = 4,
    SAY_ILLIDAN_MORPH                   = 5,
    SAY_ILLIDAN_ENRAGE                  = 6,
    SAY_ILLIDAN_TAUNT                   = 7,
    SAY_ILLIDAN_AKAMA1                  = 8,
    SAY_ILLIDAN_AKAMA2                  = 9,
    SAY_ILLIDAN_AKAMA3                  = 10,
    SAY_ILLIDAN_MAIEV1                  = 11,
    SAY_ILLIDAN_MAIEV2                  = 12,
    SAY_ILLIDAN_MAIEV3                  = 13,
    SAY_ILLIDAN_FRENZY                  = 14,

    SAY_UDALO                           = 0,
    SAY_OLUM                            = 0,
    SAY_AKAMA_DOORS                     = 0,
    SAY_AKAMA_FAIL                      = 1,
    SAY_AKAMA_BEWARE                    = 2,
    SAY_AKAMA_LEAVE                     = 3,
    SAY_AKAMA_ILLIDAN1                  = 4,
    SAY_AKAMA_ILLIDAN2                  = 5,
    SAY_AKAMA_ILLIDAN3                  = 6,
    SAY_AKAMA_COUNCIL_1                 = 9,
    SAY_AKAMA_COUNCIL_2                 = 10,

    SAY_MAIEV_SHADOWSONG_TAUNT          = 0,
    SAY_MAIEV_SHADOWSONG_ILLIDAN1       = 1,
    SAY_MAIEV_SHADOWSONG_ILLIDAN2       = 2,
    SAY_MAIEV_SHADOWSONG_ILLIDAN3       = 3,
    SAY_MAIEV_SHADOWSONG_ILLIDAN4       = 4,
    SAY_MAIEV_SHADOWSONG_ILLIDAN5       = 5,

    EMOTE_AZZINOTH_GAZE                 = 0
};

enum Spells
{
    // Phase 1
    SPELL_DUAL_WIELD                    = 42459,
    SPELL_BERSERK                       = 45078,
    SPELL_FLAME_CRASH                   = 40832,
    SPELL_DRAW_SOUL                     = 40904,
    SPELL_DRAW_SOUL_HEAL                = 40903,
    SPELL_PARASITIC_SHADOWFIEND         = 41917,
    SPELL_PARASITIC_SHADOWFIEND_TRIGGER = 41914,
    SPELL_SUMMON_PARASITIC_SHADOWFIENDS = 41915,

    // Phase 2
    SPELL_THROW_GLAIVE                  = 39635,
    SPELL_THROW_GLAIVE2                 = 39849,
    SPELL_GLAIVE_RETURNS                = 39873,
    SPELL_SUMMON_GLAIVE                 = 41466,
    SPELL_FIREBALL                      = 40598,
    SPELL_DARK_BARRAGE                  = 40585,
    SPELL_EYE_BLAST                     = 39908,
    SPELL_UNCAGED_WRATH                 = 39869,
    SPELL_FLAME_BLAST                   = 40631,
    SPELL_CHARGE                        = 42003,

    // Phase 3
    SPELL_AGONIZING_FLAMES              = 40932,
    SPELL_SUMMON_MAIEV                  = 40403,
    SPELL_SHADOW_PRISON                 = 40647,
    SPELL_TELEPORT_VISUAL_ONLY          = 41232,

    // Phase 4
    SPELL_DEMON_TRANSFORM_1             = 40511,
    SPELL_DEMON_TRANSFORM_2             = 40398,
    SPELL_DEMON_TRANSFORM_3             = 40510,
    SPELL_DEMON_FORM                    = 40506,
    SPELL_SHADOW_BLAST                  = 41078,
    SPELL_FLAME_BURST                   = 41126,
    SPELL_FLAME_BURST_EFFECT            = 41131,
    SPELL_SUMMON_SHADOW_DEMON           = 41117,
    SPELL_CONSUME_SOUL                  = 41080,
    SPELL_FIND_TARGET                   = 41081,

    // Phase 5
    SPELL_FRENZY                        = 40683,
    SPELL_TELEPORT_MAIEV                = 41221,
    SPELL_SHADOW_STRIKE                 = 40685,
    SPELL_THROW_DAGGER                  = 41152,
    SPELL_DEATH                         = 41220,

    // Cage
    SPELL_CAGED_DEBUFF                  = 40695,
    SPELL_CAGED_SUMMON1                 = 40696,
    SPELL_CAGED_SUMMON8                 = 40703,
    SPELL_CAGE_TRAP                     = 40760
};

enum Misc
{
    ACTION_ILLIDARI_COUNCIL_DONE    = 0,
    ACTION_FIGHT_MINIONS            = 1,
    ACTION_RETURN_BLADE             = 2,
    ACTION_ILLIDAN_CAGED            = 3,
    ACTION_ILLIDAN_DEAD             = 4,
    ACTION_MAIEV_SET_DIST30         = 5,
    ACTION_MAIEV_SET_DIST0          = 6,
    ACTION_MAIEV_OUTRO              = 7,

    MAX_EYE_BEAM_POS                = 4,

    POINT_ILLIDAN_HOVER             = 10,
    POINT_ILLIDAN_MIDDLE            = 11,

    NPC_ILLIDAN_DB_TARGET           = 23070,
    NPC_MAIEV_SHADOWSONG            = 23197,

    GO_CAGE_TRAP                    = 185916,

    PATH_AKAMA_ILLIDARI_COUNCIL_1   = 230891
};

enum Events
{
    EVENT_SPELL_FLAME_CRASH             = 1,
    EVENT_SPELL_BERSERK                 = 2,
    EVENT_SPELL_DRAW_SOUL               = 3,
    EVENT_SPELL_PARASITIC_SHADOWFIEND   = 4,
    EVENT_SPELL_AGONIZING_FLAMES        = 5,
    EVENT_SPELL_FRENZY                  = 6,

    EVENT_SUMMON_MINIONS                = 20,
    EVENT_SUMMON_MINIONS2               = 21,

    EVENT_PHASE_2_START                 = 40,
    EVENT_SPELL_FIREBALL                = 41,
    EVENT_SPELL_DARK_BARRAGE            = 42,
    EVENT_START_PHASE_2_END             = 43,
    EVENT_START_PHASE_2_WEAPON          = 44,
    EVENT_START_PHASE_3_LAND            = 45,
    EVENT_PHASE_2_SUMMON1               = 46,
    EVENT_PHASE_2_SUMMON2               = 47,
    EVENT_PHASE_2_EYE_BEAM              = 48,
    EVENT_PHASE_2_EYE_BEAM_START        = 49,
    EVENT_PHASE_2_CHANGE_POS            = 50,
    EVENT_PHASE_2_INTERRUPT             = 51,

    EVENT_PHASE_4_START                 = 60,
    EVENT_PHASE_5_START                 = 61,
    EVENT_PHASE_5_SCENE1                = 62,
    EVENT_PHASE_5_SCENE2                = 63,
    EVENT_PHASE_5_SCENE3                = 64,
    EVENT_PHASE_5_SCENE4                = 65,
    EVENT_PHASE_5_SCENE5                = 66,

    EVENT_REMOVE_DEMON_FORM             = 80,
    EVENT_SPELL_FLAME_BURST             = 81,
    EVENT_SPELL_SHADOW_BLAST            = 82,
    EVENT_SPELL_SHADOW_DEMONS           = 83,
    EVENT_MOVE_MAIEV                    = 84,
    EVENT_FINISH_TRANSFORM              = 85, // Dummy, counter only

    EVENT_OUTRO_DEMON                   = 90,
    EVENT_OUTRO_1                       = 91,
    EVENT_OUTRO_2                       = 92,
    EVENT_OUTRO_3                       = 93,

    EVENT_KILL_TALK                     = 100,
    EVENT_SAY_TAUNT                     = 101,

    GROUP_PHASE_2_ABILITY               = 1
};

const Position eyeBeamPos[MAX_EYE_BEAM_POS * 2] =
{
    {639.97f, 301.63f, 354.0f, 0.0f},
    {658.83f, 265.10f, 354.0f, 0.0f},
    {656.86f, 344.07f, 354.0f, 0.0f},
    {640.70f, 310.47f, 354.0f, 0.0f},

    {706.22f, 273.26f, 354.0f, 0.0f},
    {717.55f, 328.33f, 354.0f, 0.0f},
    {718.06f, 286.08f, 354.0f, 0.0f},
    {705.92f, 337.14f, 354.0f, 0.0f}
};

const Position airHoverPos[MAX_EYE_BEAM_POS] =
{
    {658.83f, 265.10f, 356.0f, 0.0f},
    {706.22f, 273.26f, 356.0f, 0.0f},
    {705.92f, 337.14f, 356.0f, 0.0f},
    {656.86f, 344.07f, 356.0f, 0.0f}
};

class boss_illidan_stormrage : public CreatureScript
{
public:
    boss_illidan_stormrage() : CreatureScript("boss_illidan_stormrage") { }

    struct boss_illidan_stormrageAI : public BossAI
    {
        boss_illidan_stormrageAI(Creature* creature) : BossAI(creature, DATA_ILLIDAN_STORMRAGE)
        {
        }

        EventMap events2;
        uint8 beamPosId;

        void Reset() override
        {
            BossAI::Reset();
            events2.Reset();
            me->SetDisableGravity(false);
            me->CastSpell(me, SPELL_DUAL_WIELD, true);
            me->LoadEquipment(0, true);
            me->SetImmuneToAll(true);
            beamPosId = urand(0, 3);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (Creature* akama = instance->GetCreature(DATA_AKAMA_ILLIDAN))
                akama->DespawnOrUnsummon();

            BossAI::EnterEvadeMode(why);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetEntry() != NPC_AKAMA_ILLIDAN && target->GetEntry() != NPC_MAIEV_SHADOWSONG;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_ILLIDAN_CAGED)
            {
                me->RemoveAurasDueToSpell(SPELL_FRENZY);
                events.Reset();
                events.ScheduleEvent(EVENT_PHASE_4_START, 16000);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_ILLIDAN_DB_TARGET)
                me->CastSpell(summon, SPELL_EYE_BLAST, false);
            else if (summon->GetEntry() == NPC_MAIEV_SHADOWSONG)
            {
                me->SetTarget(summon->GetGUID());
                me->SetFacingToObject(summon);
                summon->SetFacingToObject(me);
                summon->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                summon->SetReactState(REACT_PASSIVE);
                summon->CastSpell(summon, SPELL_TELEPORT_VISUAL_ONLY, true);
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            summons.Despawn(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            summons.Despawn(summon);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == POINT_ILLIDAN_HOVER)
            {
                if (events2.GetNextEventTime(EVENT_START_PHASE_2_END) == 0)
                {
                    events.ScheduleEvent(EVENT_PHASE_2_SUMMON2, 2000);
                    events.ScheduleEvent(EVENT_PHASE_2_CHANGE_POS, 6000);
                    events.ScheduleEvent(EVENT_PHASE_2_EYE_BEAM, 15000, GROUP_PHASE_2_ABILITY);
                    events2.ScheduleEvent(EVENT_START_PHASE_2_END, 10000);
                }
                me->SetFacingTo(me->GetAngle(676.02f, 305.45f));
            }
            else if (id == POINT_ILLIDAN_MIDDLE)
            {
                EntryCheckPredicate pred(NPC_BLADE_OF_AZZINOTH);
                summons.DoAction(ACTION_RETURN_BLADE, pred);
                events.ScheduleEvent(EVENT_START_PHASE_2_WEAPON, 1500);
                events.ScheduleEvent(EVENT_START_PHASE_3_LAND, 4000);
            }
        }

        void ScheduleNormalEvents(uint8 phase)
        {
            events.ScheduleEvent(EVENT_SPELL_FLAME_CRASH, 15000);
            events.ScheduleEvent(EVENT_SPELL_DRAW_SOUL, 30000);
            events.ScheduleEvent(EVENT_SPELL_PARASITIC_SHADOWFIEND, 20000);
            events.ScheduleEvent(EVENT_SAY_TAUNT, 40000);
            if (phase >= 3)
            {
                events.ScheduleEvent(EVENT_PHASE_4_START, 60000);
                events.ScheduleEvent(EVENT_SPELL_AGONIZING_FLAMES, 10000);
            }
            if (phase >= 5)
                events.ScheduleEvent(EVENT_SPELL_FRENZY, 40000);
        }

        void JustEngagedWith(Unit* who) override
        {
            summons.DespawnAll();
            BossAI::JustEngagedWith(who);
            ScheduleNormalEvents(1);
            events.ScheduleEvent(EVENT_SPELL_BERSERK, 25 * MINUTE * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_SUMMON_MINIONS, 1000);
            events.ScheduleEvent(EVENT_PHASE_2_START, 1000);
        }

        void AttackStart(Unit* victim) override
        {
            if (victim && me->Attack(victim, true))
                me->GetMotionMaster()->MoveChase(victim, events.GetNextEventTime(EVENT_REMOVE_DEMON_FORM) != 0 ? 35.0f : 0.0f);
        }

        void MoveInLineOfSight(Unit*) override { }

        void JustDied(Unit*  /*killer*/) override
        {
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            summons.DespawnEntry(NPC_PARASITIC_SHADOWFIEND);
            _JustDied();
        }

        void KilledUnit(Unit*  /*victim*/) override
        {
            if (events.GetNextEventTime(EVENT_KILL_TALK) == 0)
            {
                Talk(SAY_ILLIDAN_KILL);
                events.ScheduleEvent(EVENT_KILL_TALK, 6000);
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = 0;

                // xinef: do not allow to start outro when transforming
                if (events.GetNextEventTime(EVENT_FINISH_TRANSFORM))
                    return;

                if (!me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
                {
                    if (Creature* maiev = summons.GetCreatureWithEntry(NPC_MAIEV_SHADOWSONG))
                    {
                        maiev->StopMovingOnCurrentPos();
                        maiev->GetMotionMaster()->Clear();
                        maiev->SetReactState(REACT_PASSIVE);
                        maiev->SetFullHealth();
                        maiev->RemoveAllAuras();
                        maiev->CombatStop();
                    }

                    if (events.GetNextEventTime(EVENT_REMOVE_DEMON_FORM) != 0)
                    {
                        me->CastSpell(me, SPELL_DEMON_TRANSFORM_1, true);
                        events2.ScheduleEvent(EVENT_OUTRO_DEMON, 12000);
                    }
                    else
                    {
                        me->CastSpell(me, SPELL_TELEPORT_MAIEV, true);
                        me->CastSpell(me, SPELL_DEATH, true);
                        events2.ScheduleEvent(EVENT_OUTRO_1, 1000);
                    }

                    if (Creature* maiev = summons.GetCreatureWithEntry(NPC_MAIEV_SHADOWSONG))
                    {
                        maiev->SetTarget(me->GetGUID());
                        maiev->SetFacingToObject(me);
                    }

                    events.Reset();
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_SUMMON_MINIONS2:
                    if (Creature* akama = instance->GetCreature(DATA_AKAMA_ILLIDAN))
                        akama->AI()->DoAction(ACTION_FIGHT_MINIONS);
                    break;
                case EVENT_PHASE_2_EYE_BEAM_START:
                    Talk(SAY_ILLIDAN_EYE_BLAST);
                    if (Creature* trigger = summons.GetCreatureWithEntry(NPC_ILLIDAN_DB_TARGET))
                        trigger->GetMotionMaster()->MovePoint(0, eyeBeamPos[beamPosId + MAX_EYE_BEAM_POS], false, true);
                    break;
                case EVENT_PHASE_2_INTERRUPT:
                    me->InterruptNonMeleeSpells(false);
                    break;
                case EVENT_START_PHASE_2_END:
                    summons.RemoveNotExisting();
                    if (!summons.HasEntry(NPC_FLAME_OF_AZZINOTH))
                    {
                        events.Reset();
                        events2.Reset();
                        me->InterruptNonMeleeSpells(false);
                        me->GetMotionMaster()->MovePoint(POINT_ILLIDAN_MIDDLE, 676.02f, 305.45f, 353.6f);
                        break;
                    }
                    events2.ScheduleEvent(EVENT_START_PHASE_2_END, 1000);
                    break;
                case EVENT_OUTRO_DEMON:
                    me->CastSpell(me, SPELL_TELEPORT_MAIEV, true);
                    me->CastSpell(me, SPELL_DEATH, true);
                    events2.ScheduleEvent(EVENT_OUTRO_1, 1000);
                    break;
                case EVENT_OUTRO_1:
                    if (Creature* maiev = summons.GetCreatureWithEntry(NPC_MAIEV_SHADOWSONG))
                    {
                        maiev->SetTarget(me->GetGUID());
                        maiev->SetFacingToObject(me);
                        maiev->AI()->DoAction(ACTION_MAIEV_OUTRO);
                        maiev->AI()->Talk(SAY_MAIEV_SHADOWSONG_ILLIDAN3);
                    }

                    if (Creature* akama = instance->GetCreature(DATA_AKAMA_ILLIDAN))
                    {
                        akama->AI()->DoAction(ACTION_ILLIDAN_DEAD);
                        akama->SetTarget(me->GetGUID());
                        akama->GetMotionMaster()->MovePoint(0, 695.63f, 306.63f, 354.26f);
                    }
                    events2.ScheduleEvent(EVENT_OUTRO_2, 6000);
                    break;
                case EVENT_OUTRO_2:
                    Talk(SAY_ILLIDAN_MAIEV3);
                    events2.ScheduleEvent(EVENT_OUTRO_3, 17000);
                    break;
                case EVENT_OUTRO_3:
                    Unit::Kill(nullptr, me);
                    break;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SUMMON_MINIONS:
                    if (me->HealthBelowPct(90))
                    {
                        Talk(SAY_ILLIDAN_MINION);
                        events2.ScheduleEvent(EVENT_SUMMON_MINIONS2, 10000);
                        break;
                    }
                    events.ScheduleEvent(EVENT_SUMMON_MINIONS, 1000);
                    break;
                // ///////////////////////////
                // PHASE 1, 3, 5
                // ///////////////////////////
                case EVENT_SPELL_BERSERK:
                    Talk(SAY_ILLIDAN_ENRAGE);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_SPELL_FLAME_CRASH:
                    me->CastSpell(me->GetVictim(), SPELL_FLAME_CRASH, false);
                    events.ScheduleEvent(EVENT_SPELL_FLAME_CRASH, 25000);
                    break;
                case EVENT_SPELL_DRAW_SOUL:
                    me->CastSpell(me->GetVictim(), SPELL_DRAW_SOUL, false);
                    events.ScheduleEvent(EVENT_SPELL_DRAW_SOUL, 40000);
                    break;
                case EVENT_SPELL_PARASITIC_SHADOWFIEND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                        me->CastSpell(target, SPELL_PARASITIC_SHADOWFIEND, false);
                    events.ScheduleEvent(EVENT_SPELL_PARASITIC_SHADOWFIEND, 30000);
                    break;
                case EVENT_SAY_TAUNT:
                    Talk(SAY_ILLIDAN_TAUNT);
                    events.ScheduleEvent(EVENT_SAY_TAUNT, urand(30000, 60000));
                    break;
                case EVENT_SPELL_FRENZY:
                    Talk(SAY_ILLIDAN_FRENZY);
                    me->CastSpell(me, SPELL_FRENZY, false);
                    break;
                case EVENT_SPELL_AGONIZING_FLAMES:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                        me->CastSpell(target, SPELL_AGONIZING_FLAMES, false);
                    break;
                case EVENT_PHASE_5_START:
                    if (me->HealthBelowPct(30))
                    {
                        me->CastSpell(me, SPELL_SHADOW_PRISON, true);
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                        Talk(SAY_ILLIDAN_MAIEV1);
                        events.Reset();
                        events.ScheduleEvent(EVENT_PHASE_5_SCENE1, 9000);
                        events.ScheduleEvent(EVENT_PHASE_5_SCENE2, 18000);
                        events.ScheduleEvent(EVENT_PHASE_5_SCENE3, 24000);
                        events.ScheduleEvent(EVENT_PHASE_5_SCENE4, 27000);
                        events.ScheduleEvent(EVENT_PHASE_5_SCENE5, 30000);
                        break;
                    }
                    events.ScheduleEvent(EVENT_PHASE_5_START, 1000);
                    break;
                case EVENT_PHASE_5_SCENE1:
                    me->CastSpell(me, SPELL_SUMMON_MAIEV, true);
                    break;
                case EVENT_PHASE_5_SCENE2:
                    Talk(SAY_ILLIDAN_MAIEV2);
                    break;
                case EVENT_PHASE_5_SCENE3:
                    if (Creature* maiev = summons.GetCreatureWithEntry(NPC_MAIEV_SHADOWSONG))
                        maiev->AI()->Talk(SAY_MAIEV_SHADOWSONG_ILLIDAN2);
                    break;
                case EVENT_PHASE_5_SCENE4:
                    if (Creature* maiev = summons.GetCreatureWithEntry(NPC_MAIEV_SHADOWSONG))
                        maiev->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                    break;
                case EVENT_PHASE_5_SCENE5:
                    me->SetTarget(me->GetVictim()->GetGUID());
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                    if (Creature* maiev = summons.GetCreatureWithEntry(NPC_MAIEV_SHADOWSONG))
                    {
                        maiev->SetReactState(REACT_AGGRESSIVE);
                        maiev->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        maiev->AI()->AttackStart(me);
                    }
                    ScheduleNormalEvents(5);
                    break;
                // ///////////////////////////
                // PHASE 2
                // ///////////////////////////
                case EVENT_PHASE_2_START:
                    if (me->HealthBelowPct(65))
                    {
                        if (events2.GetNextEventTime(EVENT_SUMMON_MINIONS2) != 0)
                            events2.RescheduleEvent(EVENT_SUMMON_MINIONS2, 0);

                        Talk(SAY_ILLIDAN_TAKEOFF);
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->SetTarget();
                        me->GetMotionMaster()->Clear();
                        me->StopMovingOnCurrentPos();
                        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                        me->HandleEmoteCommand(EMOTE_ONESHOT_LIFTOFF);
                        me->SetDisableGravity(true);

                        events.Reset();
                        events.ScheduleEvent(EVENT_PHASE_2_SUMMON1, 6000);
                        break;
                    }
                    events.ScheduleEvent(EVENT_PHASE_2_START, 1000);
                    break;
                case EVENT_PHASE_2_SUMMON1:
                    me->LoadEquipment(1, true);
                    me->GetMotionMaster()->MovePoint(POINT_ILLIDAN_HOVER, 727.875f, 305.365f, 356.0f, false, true);
                    break;
                case EVENT_PHASE_2_SUMMON2:
                    Talk(SAY_ILLIDAN_SUMMONFLAMES);
                    me->LoadEquipment(0, true);
                    me->CastSpell(me, SPELL_THROW_GLAIVE, false);
                    me->CastSpell(me, SPELL_THROW_GLAIVE2, false);
                    break;
                case EVENT_PHASE_2_CHANGE_POS:
                    beamPosId = (beamPosId + 1) % MAX_EYE_BEAM_POS;
                    events.ScheduleEvent(EVENT_SPELL_FIREBALL, 8000, GROUP_PHASE_2_ABILITY);
                    events.ScheduleEvent(EVENT_SPELL_DARK_BARRAGE, 18000, GROUP_PHASE_2_ABILITY);
                    events.ScheduleEvent(EVENT_PHASE_2_EYE_BEAM, urand(25000, 50000), GROUP_PHASE_2_ABILITY);
                    me->GetMotionMaster()->MovePoint(POINT_ILLIDAN_HOVER, airHoverPos[beamPosId], false, true);
                    break;
                case EVENT_PHASE_2_EYE_BEAM:
                    me->SummonCreature(NPC_ILLIDAN_DB_TARGET, eyeBeamPos[beamPosId], TEMPSUMMON_TIMED_DESPAWN, 15000);
                    events.CancelEventGroup(GROUP_PHASE_2_ABILITY);
                    events.ScheduleEvent(EVENT_PHASE_2_CHANGE_POS, 20000);

                    events2.ScheduleEvent(EVENT_PHASE_2_EYE_BEAM_START, 2000);
                    events2.ScheduleEvent(EVENT_PHASE_2_INTERRUPT, 20000);
                    break;
                case EVENT_SPELL_FIREBALL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                        me->CastSpell(target, SPELL_FIREBALL, false);
                    events.ScheduleEvent(EVENT_SPELL_FIREBALL, 2200, GROUP_PHASE_2_ABILITY);
                    break;
                case EVENT_SPELL_DARK_BARRAGE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                        me->CastSpell(target, SPELL_DARK_BARRAGE, false);
                    events.ScheduleEvent(EVENT_SPELL_DARK_BARRAGE, 30000, GROUP_PHASE_2_ABILITY);
                    break;
                case EVENT_START_PHASE_2_WEAPON:
                    me->LoadEquipment(1, true);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
                    me->SetDisableGravity(false);
                    break;
                case EVENT_START_PHASE_3_LAND:
                    me->GetThreatMgr().ResetAllThreat();
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->SetTarget(me->GetVictim()->GetGUID());
                    AttackStart(me->GetVictim());
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    ScheduleNormalEvents(3);
                    events.ScheduleEvent(EVENT_PHASE_5_START, 1000);
                    break;
                // ///////////////////////////
                // PHASE 4
                // ///////////////////////////
                case EVENT_PHASE_4_START:
                    me->CastSpell(me, SPELL_DEMON_TRANSFORM_1, true);
                    me->GetThreatMgr().ResetAllThreat();
                    me->GetMotionMaster()->MoveChase(me->GetVictim(), 35.0f);
                    events.Reset();
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_BLAST, 11000);
                    events.ScheduleEvent(EVENT_MOVE_MAIEV, 5000);
                    events.ScheduleEvent(EVENT_FINISH_TRANSFORM, 10500);
                    events.ScheduleEvent(EVENT_SPELL_FLAME_BURST, 21000);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_DEMONS, 36000);
                    events.ScheduleEvent(EVENT_REMOVE_DEMON_FORM, 60000);
                    break;
                case EVENT_SPELL_SHADOW_BLAST:
                    me->CastSpell(me->GetVictim(), SPELL_SHADOW_BLAST, false);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_BLAST, 2200);
                    break;
                case EVENT_SPELL_FLAME_BURST:
                    me->CastSpell(me, SPELL_FLAME_BURST, false);
                    events.ScheduleEvent(EVENT_SPELL_FLAME_BURST, 22000);
                    break;
                case EVENT_SPELL_SHADOW_DEMONS:
                    me->CastSpell(me, SPELL_SUMMON_SHADOW_DEMON, false);
                    break;
                case EVENT_REMOVE_DEMON_FORM:
                    me->CastSpell(me, SPELL_DEMON_TRANSFORM_1, true);
                    me->GetThreatMgr().ResetAllThreat();
                    events.Reset();
                    if (summons.HasEntry(NPC_MAIEV_SHADOWSONG))
                    {
                        ScheduleNormalEvents(5);
                        events.DelayEvents(11000);
                        events.ScheduleEvent(EVENT_MOVE_MAIEV, 10000);
                        events.ScheduleEvent(EVENT_FINISH_TRANSFORM, 10500);
                    }
                    else
                    {
                        ScheduleNormalEvents(3);
                        events.ScheduleEvent(EVENT_PHASE_5_START, 1000);
                        events.DelayEvents(11000);
                        events.ScheduleEvent(EVENT_FINISH_TRANSFORM, 10500);
                    }
                    break;
                case EVENT_MOVE_MAIEV:
                    if (Creature* maiev = summons.GetCreatureWithEntry(NPC_MAIEV_SHADOWSONG))
                    {
                        if (events.GetNextEventTime(EVENT_REMOVE_DEMON_FORM) != 0)
                        {
                            maiev->AI()->DoAction(ACTION_MAIEV_SET_DIST30);
                            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, -25.0f, true))
                                maiev->GetMotionMaster()->MoveCharge(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), 7.0f, 0);
                            else
                                maiev->GetMotionMaster()->MoveCharge(678.04f, 378.34f, 353.0f, 7.0f, 0);
                        }
                        else
                        {
                            maiev->AI()->DoAction(ACTION_MAIEV_SET_DIST0);
                            maiev->GetMotionMaster()->MoveChase(me, 0.0f);
                        }
                    }
                    break;
                case EVENT_FINISH_TRANSFORM:
                    me->GetMotionMaster()->MoveChase(me->GetVictim(), events.GetNextEventTime(EVENT_REMOVE_DEMON_FORM) != 0 ? 35.0f : 0.0f);
                    break;
            }

            if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                DoMeleeAttackIfReady();
        }

        bool CheckEvadeIfOutOfCombatArea() const override
        {
            return me->GetHomePosition().GetExactDist(me) > 90.0f || !SelectTargetFromPlayerList(80.0f);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackTempleAI<boss_illidan_stormrageAI>(creature);
    }
};

enum Akama
{
    POINT_DOORS                 = 20,
    POINT_ILLIDAN               = 32,
    POINT_FIGHT_MINIONS         = 40,

    SPELL_AKAMA_DOOR_OPEN       = 41268,
    SPELL_AKAMA_DOOR_FAIL       = 41271,
    SPELL_DEATHSWORN_DOOR_OPEN  = 41269,
    SPELL_HEALING_POTION        = 40535,
    SPELL_CHAIN_LIGHTNING       = 40536,

    NPC_SPIRIT_OF_OLUM          = 23411,
    NPC_SPIRIT_OF_UDALO         = 23410,
    NPC_ILLIDARI_ELITE          = 23226,

    EVENT_AKAMA_SCENE_1         = 1,
    EVENT_AKAMA_SCENE_2         = 2,
    EVENT_AKAMA_SCENE_3         = 3,
    EVENT_AKAMA_SCENE_4         = 4,
    EVENT_AKAMA_SCENE_5         = 5,
    EVENT_AKAMA_SCENE_6         = 6,
    EVENT_AKAMA_SCENE_7         = 7,
    EVENT_AKAMA_SCENE_8         = 8,
    EVENT_AKAMA_SCENE_9         = 9,
    EVENT_AKAMA_SCENE_10        = 10,
    EVENT_AKAMA_SCENE_11        = 11,
    EVENT_AKAMA_SCENE_20        = 20,
    EVENT_AKAMA_SCENE_21        = 21,
    EVENT_AKAMA_SCENE_22        = 22,
    EVENT_AKAMA_SCENE_23        = 23,
    EVENT_AKAMA_SCENE_24        = 24,
    EVENT_AKAMA_SCENE_25        = 25,
    EVENT_AKAMA_SCENE_26        = 26,
    EVENT_AKAMA_SCENE_27        = 27,
    EVENT_AKAMA_SCENE_28        = 28,
    EVENT_AKAMA_SCENE_29        = 29,

    EVENT_AKAMA_SUMMON_ILLIDARI = 100,
    EVENT_AKAMA_SPELL_CHAIN     = 101,
    EVENT_AKAMA_HEALTH          = 102
};

Position AkamaTeleport = { 609.772f, 308.456f, 271.826f, 6.1972566f };

class npc_akama_illidan : public CreatureScript
{
public:
    npc_akama_illidan() : CreatureScript("npc_akama_illidan") { }

    struct npc_akama_illidanAI : public npc_escortAI
    {
        npc_akama_illidanAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
            if (instance->GetBossState(DATA_AKAMA_ILLIDAN) == DONE)
            {
                me->GetMap()->LoadGrid(751.664f, 238.933f);
                me->SetHomePosition(751.664f, 238.933f, 353.106f, 2.18f);
                me->NearTeleportTo(751.664f, 238.933f, 353.106f, 2.18f);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_FIGHT_MINIONS)
            {
                me->CombatStop(true);
                events.ScheduleEvent(EVENT_AKAMA_SUMMON_ILLIDARI, 8000);
                events.ScheduleEvent(EVENT_AKAMA_SPELL_CHAIN, 7000);
                events.ScheduleEvent(EVENT_AKAMA_HEALTH, 1000);
                me->GetMotionMaster()->MoveCharge(741.97f, 358.74f, 353.0f, 10.0f, POINT_FIGHT_MINIONS);
                Talk(SAY_AKAMA_LEAVE);
            }
            else if (param == ACTION_ILLIDAN_DEAD)
            {
                events.Reset();
                summons.DespawnAll();
                me->CombatStop(true);
            }
            else if (param == ACTION_ILLIDARI_COUNCIL_DONE)
            {
                me->NearTeleportTo(AkamaTeleport);
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->GetMotionMaster()->MovePath(PATH_AKAMA_ILLIDARI_COUNCIL_1, false);
            }
        }

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->setActive(false);
            events.Reset();
            summons.DespawnAll();
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32  /*action*/) override
        {
            CloseGossipMenuFor(player);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->setActive(true);

            if (instance->GetBossState(DATA_AKAMA_ILLIDAN) != DONE)
            {
                me->SetReactState(REACT_PASSIVE);
                Start(false, true);
                SetDespawnAtEnd(false);
            }
            else
            {
                me->GetMotionMaster()->MovePoint(POINT_ILLIDAN, 744.45f, 304.84f, 353.0f);
                events.Reset();
                events.ScheduleEvent(EVENT_AKAMA_SCENE_20, 5000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_21, 8000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_22, 10000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_23, 23000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_24, 34000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_25, 41000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_26, 46000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_27, 49000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_28, 49200);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_29, 52000);
            }
        }

        void PathEndReached(uint32 pathId) override
        {
            if (pathId == PATH_AKAMA_ILLIDARI_COUNCIL_1)
            {
                ScheduleUniqueTimedEvent(200ms, [&]
                {
                    Talk(SAY_AKAMA_COUNCIL_1);
                }, 1);
                ScheduleUniqueTimedEvent(7800ms, [&]
                {
                    Talk(SAY_AKAMA_COUNCIL_2);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                }, 2);
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            summon->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            if (summon->GetEntry() == NPC_ILLIDARI_ELITE)
            {
                me->AddThreat(summon, 1000000.0f);
                summon->AddThreat(me, 1000000.0f);
                summon->AI()->AttackStart(me);
                AttackStart(summon);
            }
        }

        void WaypointReached(uint32 pointId) override
        {
            if (pointId == POINT_DOORS)
            {
                SetEscortPaused(true);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_1, 0);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_2, 4000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_3, 7000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_4, 17000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_5, 23000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_6, 25000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_7, 31000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_8, 40000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_9, 54000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_10, 57000);
                events.ScheduleEvent(EVENT_AKAMA_SCENE_11, 62000);
            }
            else if (pointId == POINT_ILLIDAN)
            {
                me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_GOSSIP);
                me->setActive(false);
                me->SetReactState(REACT_AGGRESSIVE);
            }
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
                damage = 0;
        }

        void UpdateEscortAI(uint32 diff) override
        {
            scheduler.Update(diff);
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_AKAMA_SCENE_1:
                    me->SetFacingTo(0.0f);
                    break;
                case EVENT_AKAMA_SCENE_2:
                    Talk(SAY_AKAMA_DOORS);
                    break;
                case EVENT_AKAMA_SCENE_3:
                    me->CastSpell(me, SPELL_AKAMA_DOOR_FAIL, false);
                    break;
                case EVENT_AKAMA_SCENE_4:
                    Talk(SAY_AKAMA_FAIL);
                    break;
                case EVENT_AKAMA_SCENE_5:
                    me->SummonCreature(NPC_SPIRIT_OF_UDALO, me->GetPositionX() - 5.0f, me->GetPositionY() + 8.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000);
                    me->SummonCreature(NPC_SPIRIT_OF_OLUM, me->GetPositionX() - 5.0f, me->GetPositionY() - 8.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000);
                    break;
                case EVENT_AKAMA_SCENE_6:
                    if (Creature* udalo = me->FindNearestCreature(NPC_SPIRIT_OF_UDALO, 15.0f))
                        udalo->AI()->Talk(SAY_UDALO);
                    break;
                case EVENT_AKAMA_SCENE_7:
                    if (Creature* olum = me->FindNearestCreature(NPC_SPIRIT_OF_OLUM, 15.0f))
                        olum->AI()->Talk(SAY_OLUM);
                    break;
                case EVENT_AKAMA_SCENE_8:
                    me->CastSpell(me, SPELL_AKAMA_DOOR_OPEN, false);
                    if (Creature* olum = me->FindNearestCreature(NPC_SPIRIT_OF_OLUM, 15.0f))
                        olum->CastSpell(olum, SPELL_AKAMA_DOOR_OPEN, false);
                    if (Creature* udalo = me->FindNearestCreature(NPC_SPIRIT_OF_UDALO, 15.0f))
                        udalo->CastSpell(udalo, SPELL_AKAMA_DOOR_OPEN, false);
                    break;
                case EVENT_AKAMA_SCENE_9:
                    instance->SetBossState(DATA_AKAMA_ILLIDAN, NOT_STARTED);
                    instance->SetBossState(DATA_AKAMA_ILLIDAN, DONE);
                    break;
                case EVENT_AKAMA_SCENE_10:
                    Talk(SAY_AKAMA_BEWARE);
                    break;
                case EVENT_AKAMA_SCENE_11:
                    SetEscortPaused(false);
                    break;
                case EVENT_AKAMA_SCENE_20:
                    if (Creature* illidan = instance->GetCreature(DATA_ILLIDAN_STORMRAGE))
                        illidan->SetStandState(UNIT_STAND_STATE_STAND);
                    break;
                case EVENT_AKAMA_SCENE_21:
                    me->SetFacingTo(M_PI);
                    break;
                case EVENT_AKAMA_SCENE_22:
                    if (Creature* illidan = instance->GetCreature(DATA_ILLIDAN_STORMRAGE))
                        illidan->AI()->Talk(SAY_ILLIDAN_AKAMA1);
                    break;
                case EVENT_AKAMA_SCENE_23:
                    Talk(SAY_AKAMA_ILLIDAN1);
                    break;
                case EVENT_AKAMA_SCENE_24:
                    if (Creature* illidan = instance->GetCreature(DATA_ILLIDAN_STORMRAGE))
                        illidan->AI()->Talk(SAY_ILLIDAN_AKAMA2);
                    break;
                case EVENT_AKAMA_SCENE_25:
                    Talk(SAY_AKAMA_ILLIDAN2);
                    break;
                case EVENT_AKAMA_SCENE_26:
                    if (Creature* illidan = instance->GetCreature(DATA_ILLIDAN_STORMRAGE))
                        illidan->AI()->Talk(SAY_ILLIDAN_AKAMA3);
                    break;
                case EVENT_AKAMA_SCENE_27:
                    if (Creature* illidan = instance->GetCreature(DATA_ILLIDAN_STORMRAGE))
                        illidan->LoadEquipment(1, true);
                    break;
                case EVENT_AKAMA_SCENE_28:
                    if (Creature* illidan = instance->GetCreature(DATA_ILLIDAN_STORMRAGE))
                        illidan->HandleEmoteCommand(EMOTE_ONESHOT_TALK_NO_SHEATHE);
                    break;
                case EVENT_AKAMA_SCENE_29:
                    if (Creature* illidan = instance->GetCreature(DATA_ILLIDAN_STORMRAGE))
                    {
                        illidan->SetImmuneToAll(false);
                        illidan->SetInCombatWithZone();
                        AttackStart(illidan);
                    }
                    break;
                case EVENT_AKAMA_SUMMON_ILLIDARI:
                    me->SummonCreature(NPC_ILLIDARI_ELITE, 742.55f, 359.12f, 353.0f, 4.35f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30000);
                    events.ScheduleEvent(EVENT_AKAMA_SUMMON_ILLIDARI, urand(2000, 6000));
                    break;
                case EVENT_AKAMA_SPELL_CHAIN:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_CHAIN_LIGHTNING, false);
                    events.ScheduleEvent(EVENT_AKAMA_SPELL_CHAIN, 20000);
                    break;
                case EVENT_AKAMA_HEALTH:
                    if (me->HealthBelowPct(20))
                        me->CastSpell(me, SPELL_HEALING_POTION, false);
                    events.ScheduleEvent(EVENT_AKAMA_HEALTH, 1000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap events;
        SummonList summons;
        InstanceScript* instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackTempleAI<npc_akama_illidanAI>(creature);
    }
};

class spell_illidan_draw_soul : public SpellScriptLoader
{
public:
    spell_illidan_draw_soul() : SpellScriptLoader("spell_illidan_draw_soul") { }

    class spell_illidan_draw_soul_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_illidan_draw_soul_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
                target->CastSpell(GetCaster(), SPELL_DRAW_SOUL_HEAL, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_illidan_draw_soul_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_illidan_draw_soul_SpellScript();
    }
};

class spell_illidan_parasitic_shadowfiend : public SpellScriptLoader
{
public:
    spell_illidan_parasitic_shadowfiend() : SpellScriptLoader("spell_illidan_parasitic_shadowfiend") { }

    class spell_illidan_parasitic_shadowfiend_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_illidan_parasitic_shadowfiend_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (!GetTarget()->HasAura(SPELL_SHADOW_PRISON) && GetTarget()->GetInstanceScript() && GetTarget()->GetInstanceScript()->IsEncounterInProgress())
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_PARASITIC_SHADOWFIENDS, true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_illidan_parasitic_shadowfiend_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_illidan_parasitic_shadowfiend_AuraScript();
    }
};

class spell_illidan_parasitic_shadowfiend_trigger : public SpellScriptLoader
{
public:
    spell_illidan_parasitic_shadowfiend_trigger() : SpellScriptLoader("spell_illidan_parasitic_shadowfiend_trigger") { }

    class spell_illidan_parasitic_shadowfiend_trigger_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_illidan_parasitic_shadowfiend_trigger_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (!GetTarget()->HasAura(SPELL_SHADOW_PRISON) && GetTarget()->GetInstanceScript() && GetTarget()->GetInstanceScript()->IsEncounterInProgress())
                GetTarget()->CastSpell(GetTarget(), SPELL_SUMMON_PARASITIC_SHADOWFIENDS, true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_illidan_parasitic_shadowfiend_trigger_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_illidan_parasitic_shadowfiend_trigger_AuraScript();
    }

    class spell_illidan_parasitic_shadowfiend_trigger_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_illidan_parasitic_shadowfiend_trigger_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Creature* target = GetHitCreature())
                target->DespawnOrUnsummon(1);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_illidan_parasitic_shadowfiend_trigger_SpellScript::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_illidan_parasitic_shadowfiend_trigger_SpellScript();
    }
};

class spell_illidan_glaive_throw : public SpellScriptLoader
{
public:
    spell_illidan_glaive_throw() : SpellScriptLoader("spell_illidan_glaive_throw") { }

    class spell_illidan_glaive_throw_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_illidan_glaive_throw_SpellScript);

        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitEffect(effIndex);
            if (Unit* target = GetHitUnit())
                target->CastSpell(target, SPELL_SUMMON_GLAIVE, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_illidan_glaive_throw_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_illidan_glaive_throw_SpellScript();
    }
};

class spell_illidan_tear_of_azzinoth_summon_channel : public SpellScriptLoader
{
public:
    spell_illidan_tear_of_azzinoth_summon_channel() : SpellScriptLoader("spell_illidan_tear_of_azzinoth_summon_channel") { }

    class spell_illidan_tear_of_azzinoth_summon_channel_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_illidan_tear_of_azzinoth_summon_channel_AuraScript);

        void OnPeriodic(AuraEffect const*  /*aurEff*/)
        {
            PreventDefaultAction();
            if (Unit* caster = GetCaster())
            {
                if (GetTarget()->GetDistance2d(caster) > 25.0f)
                {
                    SetDuration(0);
                    GetTarget()->CastSpell(GetTarget(), SPELL_UNCAGED_WRATH, true);
                }
            }

            // xinef: ugly hax, dunno how it really works on blizz
            Map::PlayerList const& pl = GetTarget()->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                if (Player* player = itr->GetSource())
                    if (player->GetPositionX() > 693.4f || player->GetPositionY() < 271.8f || player->GetPositionX() < 658.43f || player->GetPositionY() > 338.68f)
                    {
                        GetTarget()->CastSpell(player, SPELL_CHARGE, true);
                        break;
                    }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_illidan_tear_of_azzinoth_summon_channel_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_illidan_tear_of_azzinoth_summon_channel_AuraScript();
    }
};

class spell_illidan_shadow_prison : public SpellScriptLoader
{
public:
    spell_illidan_shadow_prison() : SpellScriptLoader("spell_illidan_shadow_prison") { }

    class spell_illidan_shadow_prison_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_illidan_shadow_prison_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(PlayerOrPetCheck());
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_illidan_shadow_prison_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_illidan_shadow_prison_SpellScript();
    }
};

class spell_illidan_demon_transform1 : public SpellScriptLoader
{
public:
    spell_illidan_demon_transform1() : SpellScriptLoader("spell_illidan_demon_transform1") { }

    class spell_illidan_demon_transform1_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_illidan_demon_transform1_AuraScript);

        bool Load() override
        {
            return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
        }

        void OnPeriodic(AuraEffect const*  /*aurEff*/)
        {
            PreventDefaultAction();
            SetDuration(0);
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_DEMON_TRANSFORM_2, true);
            GetUnitOwner()->ToCreature()->LoadEquipment(0, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_illidan_demon_transform1_AuraScript::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_illidan_demon_transform1_AuraScript();
    }
};

class spell_illidan_demon_transform2 : public SpellScriptLoader
{
public:
    spell_illidan_demon_transform2() : SpellScriptLoader("spell_illidan_demon_transform2") { }

    class spell_illidan_demon_transform2_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_illidan_demon_transform2_AuraScript);

        bool Load() override
        {
            return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
        }

        void OnPeriodic(AuraEffect const* aurEff)
        {
            PreventDefaultAction();

            if (aurEff->GetTickNumber() == 1)
            {
                if (GetUnitOwner()->GetDisplayId() == GetUnitOwner()->GetNativeDisplayId())
                    GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_DEMON_FORM, true);
                else
                    GetUnitOwner()->RemoveAurasDueToSpell(SPELL_DEMON_FORM);
            }
            else if (aurEff->GetTickNumber() == 2)
            {
                SetDuration(0);
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_DEMON_TRANSFORM_3, true);
                if (Aura* aura = GetUnitOwner()->GetAura(SPELL_DEMON_TRANSFORM_3))
                    aura->SetDuration(4500);

                if (!GetUnitOwner()->HasAura(SPELL_DEMON_FORM))
                    GetUnitOwner()->ToCreature()->LoadEquipment(1, true);
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_illidan_demon_transform2_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_illidan_demon_transform2_AuraScript();
    }
};

class spell_illidan_flame_burst : public SpellScriptLoader
{
public:
    spell_illidan_flame_burst() : SpellScriptLoader("spell_illidan_flame_burst") { }

    class spell_illidan_flame_burst_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_illidan_flame_burst_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitEffect(effIndex);
            if (Unit* target = GetHitUnit())
                target->CastSpell(target, SPELL_FLAME_BURST_EFFECT, true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_illidan_flame_burst_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_illidan_flame_burst_SpellScript();
    }
};

class spell_illidan_found_target : public SpellScriptLoader
{
public:
    spell_illidan_found_target() : SpellScriptLoader("spell_illidan_found_target") { }

    class spell_illidan_found_target_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_illidan_found_target_SpellScript);

        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitEffect(effIndex);
            if (Unit* target = GetHitUnit())
                if (GetCaster()->GetDistance(target) < 2.0f)
                {
                    GetCaster()->CastSpell(target, SPELL_CONSUME_SOUL, true);
                    GetCaster()->CastSpell(GetCaster(), SPELL_FIND_TARGET, true);
                }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_illidan_found_target_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_illidan_found_target_SpellScript();
    }
};

class spell_illidan_cage_trap : public SpellScriptLoader
{
public:
    spell_illidan_cage_trap() : SpellScriptLoader("spell_illidan_cage_trap") { }

    class spell_illidan_cage_trap_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_illidan_cage_trap_SpellScript);

        bool Load() override
        {
            return GetCaster()->GetTypeId() == TYPEID_UNIT;
        }

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitEffect(effIndex);
            if (Creature* target = GetHitCreature())
                if (GetCaster()->GetExactDist2d(target) < 4.0f)
                {
                    target->AI()->DoAction(ACTION_ILLIDAN_CAGED);
                    target->CastSpell(target, SPELL_CAGE_TRAP, true);
                    GetCaster()->ToCreature()->DespawnOrUnsummon(1);
                    if (GameObject* gobject = GetCaster()->FindNearestGameObject(GO_CAGE_TRAP, 10.0f))
                        gobject->SetLootState(GO_JUST_DEACTIVATED);
                }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_illidan_cage_trap_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_illidan_cage_trap_SpellScript();
    }
};

class spell_illidan_cage_trap_stun : public SpellScriptLoader
{
public:
    spell_illidan_cage_trap_stun() : SpellScriptLoader("spell_illidan_cage_trap_stun") { }

    class spell_illidan_cage_trap_stun_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_illidan_cage_trap_stun_AuraScript);

        void OnPeriodic(AuraEffect const*  /*aurEff*/)
        {
            PreventDefaultAction();
            SetDuration(0);

            for (uint32 i = SPELL_CAGED_SUMMON1; i <= SPELL_CAGED_SUMMON8; ++i)
                GetTarget()->CastSpell(GetTarget(), i, true);
            GetTarget()->CastSpell(GetTarget(), SPELL_CAGED_DEBUFF, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_illidan_cage_trap_stun_AuraScript::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_illidan_cage_trap_stun_AuraScript();
    }
};

void AddSC_boss_illidan()
{
    new boss_illidan_stormrage();
    new npc_akama_illidan();
    new spell_illidan_draw_soul();
    new spell_illidan_parasitic_shadowfiend();
    new spell_illidan_parasitic_shadowfiend_trigger();
    new spell_illidan_glaive_throw();
    new spell_illidan_tear_of_azzinoth_summon_channel();
    new spell_illidan_shadow_prison();
    new spell_illidan_demon_transform1();
    new spell_illidan_demon_transform2();
    new spell_illidan_flame_burst();
    new spell_illidan_found_target();
    new spell_illidan_cage_trap();
    new spell_illidan_cage_trap_stun();
}

