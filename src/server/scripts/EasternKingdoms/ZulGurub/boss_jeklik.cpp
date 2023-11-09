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

#include "GameObjectAI.h"
#include "MoveSplineInit.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"
#include "SpellScript.h"
#include "TaskScheduler.h"
#include "WaypointMgr.h"
#include "zulgurub.h"

enum BossSays
{
    SAY_AGGRO                   = 0,
    SAY_CALL_RIDERS             = 1,
    SAY_DEATH                   = 2,
    EMOTE_SUMMON_BATS           = 3,
    EMOTE_GREAT_HEAL            = 4
};

enum BatRiderSays
{
    EMOTE_LOW_HEALTH            = 0
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

    // Phase two
    SPELL_CURSE_OF_BLOOD        = 16098,
    SPELL_PSYCHIC_SCREAM        = 22884,
    SPELL_SHADOW_WORD_PAIN      = 23952,
    SPELL_MIND_FLAY             = 23953,
    SPELL_GREATER_HEAL          = 23954,

    // Bat Rider (Boss)
    SPELL_THROW_LIQUID_FIRE     = 23970,
    SPELL_SUMMON_LIQUID_FIRE    = 23971,

    // Bat Rider (Trash)
    SPELL_DEMO_SHOUT            = 23511,
    SPELL_BATTLE_COMMAND        = 5115,
    SPELL_INFECTED_BITE         = 16128,
    SPELL_PASSIVE_THRASH        = 8876,
    SPELL_UNSTABLE_CONCOCTION    = 24024
};

enum BatIds
{
    NPC_BLOODSEEKER_BAT         = 11368,
    NPC_BAT_RIDER               = 14750
};

enum Events
{
    // Phase one
    EVENT_CHARGE_JEKLIK         = 1,
    EVENT_PIERCE_ARMOR,
    EVENT_BLOOD_LEECH,
    EVENT_SONIC_BURST,
    EVENT_SWOOP,
    EVENT_SPAWN_BATS,

    // Phase two
    EVENT_CURSE_OF_BLOOD,
    EVENT_PSYCHIC_SCREAM,
    EVENT_SHADOW_WORD_PAIN,
    EVENT_MIND_FLAY,
    EVENT_GREATER_HEAL,
    EVENT_SPAWN_FLYING_BATS,

    // Bat Riders (Boss)
    EVENT_BAT_RIDER_THROW_BOMB,

    // Bat Riders (Trash)
    EVENT_DEMO_SHOUT,
    EVENT_BATTLE_COMMAND,
    EVENT_INFECTED_BITE,
    EVENT_UNSTABLE_CONCOCTION
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

Position const SpawnBatRider = { -12301.689, -1371.2921, 145.09244 };
Position const JeklikCaveHomePosition = { -12291.9f, -1380.08f, 144.902f, 2.28638f };

enum PathID
{
    PATH_JEKLIK_INTRO   = 145170,
    PATH_BAT_RIDER_LOOP = 147500
};

enum BatRiderMode
{
    BAT_RIDER_MODE_TRASH = 1,
    BAT_RIDER_MODE_BOSS
};

// High Priestess Jeklik (14517)
struct boss_jeklik : public BossAI
{
    // Bat Riders (14750) counter
    uint8 batRidersCount = 0;

    boss_jeklik(Creature* creature) : BossAI(creature, DATA_JEKLIK) { }

    void InitializeAI() override
    {
        BossAI::InitializeAI();
        me->SetHomePosition(JeklikCaveHomePosition);
    }

    void Reset() override
    {
        BossAI::Reset();

        me->SetDisableGravity(false);
        me->SetReactState(REACT_PASSIVE);
        BossAI::SetCombatMovement(false);
        batRidersCount = 0;

        // once the path for her to come down to the ground starts, it appears to be near-impossible to stop it
        // instead, simply wait the 3 seconds it takes the path to complete, then teleport her home
        scheduler.Schedule(3s, [this](TaskContext)
        {
            // teleport back to cave
            float x, y, z, o;
            JeklikCaveHomePosition.GetPosition(x, y, z, o);

            me->NearTeleportTo(x, y, z, o);
        });

        // casting effect
        scheduler.Schedule(4s, [this](TaskContext)
        {
            DoCastSelf(SPELL_GREEN_CHANNELING, true);
        });

        // visibility and unlock root
        scheduler.Schedule(5s, [this](TaskContext)
        {
            me->SetVisible(true);
            me->ClearUnitState(UNIT_STATE_ROOT);
        });
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        // cancel the casting effect if it hasn't happened already
        scheduler.CancelAll();

        Talk(SAY_AGGRO);
        DoZoneInCombat();

        me->RemoveAurasDueToSpell(SPELL_GREEN_CHANNELING);
        me->SetDisableGravity(true);
        DoCastSelf(SPELL_BAT_FORM, true);

        me->GetMotionMaster()->MovePath(PATH_JEKLIK_INTRO, false);
    }

    void PathEndReached(uint32 pathId) override
    {
        BossAI::PathEndReached(pathId);

        LOG_DEBUG("scripts.ai", "boss_jeklik:: PHASE ONE");

        me->SetDisableGravity(false);
        SetCombatMovement(true);
        me->SetReactState(REACT_AGGRESSIVE);
        events.SetPhase(PHASE_ONE);
        events.ScheduleEvent(EVENT_CHARGE_JEKLIK, 10s, 20s, PHASE_ONE);
        events.ScheduleEvent(EVENT_PIERCE_ARMOR, 5s, 15s, PHASE_ONE);
        events.ScheduleEvent(EVENT_BLOOD_LEECH, 5s, 15s, PHASE_ONE);
        events.ScheduleEvent(EVENT_SONIC_BURST, 5s, 15s, PHASE_ONE);
        events.ScheduleEvent(EVENT_SWOOP, 20s, PHASE_ONE);
        events.ScheduleEvent(EVENT_SPAWN_BATS, 30s, PHASE_ONE);

        // at 50%, switch to phase 2
        ScheduleHealthCheckEvent(50, [&] {
            LOG_DEBUG("scripts.ai", "boss_jeklik:: PHASE TWO");
            me->RemoveAurasDueToSpell(SPELL_BAT_FORM);
            DoResetThreatList();
            events.SetPhase(PHASE_TWO);
            events.CancelEventGroup(PHASE_ONE);

            events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, 5s, 15s, PHASE_TWO);
            events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 10s, 15s, PHASE_TWO);
            events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, 25s, 35s, PHASE_TWO);
            events.ScheduleEvent(EVENT_MIND_FLAY, 10s, 30s, PHASE_TWO);
            events.ScheduleEvent(EVENT_GREATER_HEAL, 25s, PHASE_TWO);
            events.ScheduleEvent(EVENT_SPAWN_FLYING_BATS, 10s, PHASE_TWO);
        });
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (why != EvadeReason::EVADE_REASON_NO_PATH)
        {
            // make invisible to hide wonky-looking movement
            me->SetVisible(false);

            // cancel any pending moves and stop moving
            me->GetMotionMaster()->Clear();
            me->AddUnitState(UNIT_STATE_ROOT);

            // cancel all pending events
            events.CancelEventGroup(PHASE_ONE);
            events.CancelEventGroup(PHASE_TWO);
            scheduler.CancelAll();
        }

        // enter evade mode
        CreatureAI::_EnterEvadeMode(why);
        Reset();
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        scheduler.Update(diff);

        // update boss target (victim)
        // if none, return
        if (!UpdateVictim())
        {
            return;
        }

        // if casting, return
        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                // PHASE_ONE
                case EVENT_CHARGE_JEKLIK:
                    // charge the nearest player that is at least 8 yards away (charge min distance)
                    if (Unit* target = SelectTarget(SelectTargetMethod::MinDistance, 0, -8.0f, false, false))
                    {
                        LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: EVENT_CHARGE_JEKLIK (target: {})", target->GetName());
                        DoCast(target, SPELL_CHARGE);
                        AttackStart(target);
                    }
                    else
                    {
                        LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: EVENT_CHARGE_JEKLIK (no target available)");
                    }
                    events.ScheduleEvent(EVENT_CHARGE_JEKLIK, 15s, 30s, PHASE_ONE);
                    break;
                case EVENT_PIERCE_ARMOR:
                    DoCastVictim(SPELL_PIERCE_ARMOR);
                    events.ScheduleEvent(EVENT_PIERCE_ARMOR, 20s, 30s, PHASE_ONE);
                    break;
                case EVENT_BLOOD_LEECH:
                    DoCastVictim(SPELL_BLOOD_LEECH);
                    events.ScheduleEvent(EVENT_BLOOD_LEECH, 10s, 20s, PHASE_ONE);
                    break;
                case EVENT_SONIC_BURST:
                    DoCastVictim(SPELL_SONIC_BURST);
                    events.ScheduleEvent(EVENT_SONIC_BURST, 20s, 30s, PHASE_ONE);
                    break;
                case EVENT_SWOOP:
                    DoCastVictim(SPELL_SWOOP);
                    events.ScheduleEvent(EVENT_SWOOP, 20s, 30s, PHASE_ONE);
                    break;
                case EVENT_SPAWN_BATS:
                    LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: EVENT_SPAWN_BATS");
                    Talk(EMOTE_SUMMON_BATS);
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        for (uint8 i = 0; i < 6; ++i)
                            if (Creature* bat = me->SummonCreature(NPC_BLOODSEEKER_BAT, SpawnBat[i], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000))
                                bat->AI()->AttackStart(target);
                    events.ScheduleEvent(EVENT_SPAWN_BATS, 30s, PHASE_ONE);
                    break;
                // PHASE_TWO
                case EVENT_CURSE_OF_BLOOD:
                    DoCastSelf(SPELL_CURSE_OF_BLOOD);
                    events.ScheduleEvent(EVENT_CURSE_OF_BLOOD, 25s, 30s, PHASE_TWO);
                    break;
                case EVENT_PSYCHIC_SCREAM:
                    DoCastVictim(SPELL_PSYCHIC_SCREAM);
                    events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, 35s, 45s, PHASE_TWO);
                    break;
                case EVENT_SHADOW_WORD_PAIN:
                    DoCastRandomTarget(SPELL_SHADOW_WORD_PAIN, 0, true);
                    events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 12s, 18s, PHASE_TWO);
                    break;
                case EVENT_MIND_FLAY:
                    DoCastVictim(SPELL_MIND_FLAY);
                    events.ScheduleEvent(EVENT_MIND_FLAY, 20s, 40s, PHASE_TWO);
                    break;
                case EVENT_GREATER_HEAL:
                    LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: EVENT_GREATER_HEAL");
                    Talk(EMOTE_GREAT_HEAL);
                    me->InterruptNonMeleeSpells(false);
                    DoCastSelf(SPELL_GREATER_HEAL);
                    events.ScheduleEvent(EVENT_GREATER_HEAL, 25s, PHASE_TWO);
                    break;
                case EVENT_SPAWN_FLYING_BATS:
                    if (me->GetThreatMgr().GetThreatListSize())
                    {
                        // summon up to 2 bat riders
                        if (batRidersCount < 2)
                        {
                            LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: EVENT_SPAWN_FLYING_BATS (Summoning {} of 2)", batRidersCount + 1);

                            // Yell
                            Talk(SAY_CALL_RIDERS);

                            // only if the bat rider was successfully created
                            if (me->SummonCreature(NPC_BAT_RIDER, SpawnBatRider, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000))
                            {
                                // increase the counter
                                batRidersCount++;
                            }

                            if (batRidersCount == 1)
                            {
                                events.ScheduleEvent(EVENT_SPAWN_FLYING_BATS, 10s, 15s, PHASE_TWO);
                            }
                        }
                        else
                        {
                            LOG_DEBUG("scripts.ai", "boss_jeklik::UpdateAI:: EVENT_SPAWN_FLYING_BATS (No new bats, count already at {})", batRidersCount);
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};

// Gurubashi Bat Rider (14750) - trash and boss summon are same creature ID
struct npc_batrider : public CreatureAI
{
    BatRiderMode _mode; // the version of this creature (trash or boss)

    npc_batrider(Creature* creature) : CreatureAI(creature)
    {
        // if this is a summon of Jeklik, it is in boss mode
        if
        (
            me->GetEntry() == NPC_BAT_RIDER &&
            me->IsSummon() &&
            me->ToTempSummon() &&
            me->ToTempSummon()->GetSummoner() &&
            me->ToTempSummon()->GetSummoner()->GetEntry() == NPC_PRIESTESS_JEKLIK
        )
        {
            LOG_DEBUG("scripts.ai", "npc_batrider::constructor: BAT_RIDER_MODE_BOSS");
            _mode = BAT_RIDER_MODE_BOSS;

            // make the bat rider unattackable
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);

            // keep the bat from attacking players directly
            me->SetReactState(REACT_PASSIVE);

            // make the bat rider move the correct speed
            me->SetSpeed(MOVE_WALK, 5.0f, true);

        }
        // otherwise, trash mode
        else
        {
            LOG_DEBUG("scripts.ai", "npc_batrider::constructor: BAT_RIDER_MODE_TRASH");
            me->SetReactState(REACT_DEFENSIVE);
            _mode = BAT_RIDER_MODE_TRASH;
        }
    }

    void Reset() override
    {
        CreatureAI::Reset();

        switch (_mode)
        {
            case BAT_RIDER_MODE_BOSS:
                events.Reset();
                me->GetMotionMaster()->Clear();
                break;
            case BAT_RIDER_MODE_TRASH:
                events.Reset();

                // apply the Thrash (8876) spell to the bat rider (passive ability)
                me->CastSpell(me, SPELL_PASSIVE_THRASH);

                break;
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        CreatureAI::JustEngagedWith(who);

        switch (_mode)
        {
            case BAT_RIDER_MODE_BOSS:
                events.ScheduleEvent(EVENT_BAT_RIDER_THROW_BOMB, 2s);
                break;
            case BAT_RIDER_MODE_TRASH:
                events.ScheduleEvent(EVENT_DEMO_SHOUT, 1s);
                events.ScheduleEvent(EVENT_BATTLE_COMMAND, 8s);
                events.ScheduleEvent(EVENT_INFECTED_BITE, 6500ms);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (_mode == BAT_RIDER_MODE_BOSS)
        {
            // if the creature isn't moving, run the loop
            if (!me->isMoving())
            {
                LOG_DEBUG("scripts.ai", "npc_batrider::UpdateAI: not moving, running loop");
                // enable flying
                me->SetDisableGravity(true);
                // send the rider on its loop
                me->GetMotionMaster()->MoveSplinePath(PATH_BAT_RIDER_LOOP);
            }

            // event handling
            switch (events.ExecuteEvent())
            {
                case EVENT_BAT_RIDER_THROW_BOMB:
                    LOG_DEBUG("scripts.ai", "npc_batrider::UpdateAI: EVENT_BAT_RIDER_THROW_BOMB");
                    DoCastRandomTarget(SPELL_THROW_LIQUID_FIRE);
                    events.ScheduleEvent(EVENT_BAT_RIDER_THROW_BOMB, 8s);
                    break;
                default:
                    break;
            }
        }
        else if (_mode == BAT_RIDER_MODE_TRASH)
        {
            if (!UpdateVictim())
            {
                return;
            }

            // don't interrupt casting
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            // if health goes below 30%, cast Unstable Concotion
            if (me->HealthBelowPct(30))
            {
                events.ScheduleEvent(EVENT_UNSTABLE_CONCOCTION, 0);
            }

            // event handling
            switch (events.ExecuteEvent())
            {
                case EVENT_DEMO_SHOUT:
                    DoCastSelf(SPELL_DEMO_SHOUT);
                    break;
                case EVENT_BATTLE_COMMAND:
                    DoCastSelf(SPELL_BATTLE_COMMAND);
                    events.ScheduleEvent(EVENT_BATTLE_COMMAND, 25s);
                    break;
                case EVENT_INFECTED_BITE:
                    DoCastVictim(SPELL_INFECTED_BITE);
                    events.ScheduleEvent(EVENT_INFECTED_BITE, 8s);
                    break;
                case EVENT_UNSTABLE_CONCOCTION:
                    Talk(EMOTE_LOW_HEALTH);
                    DoCastSelf(SPELL_UNSTABLE_CONCOCTION);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }
    }
};

class spell_batrider_bomb : public SpellScript
{
    PrepareSpellScript(spell_batrider_bomb);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_LIQUID_FIRE });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_SUMMON_LIQUID_FIRE, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_batrider_bomb::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_boss_jeklik()
{
    RegisterCreatureAI(boss_jeklik);
    RegisterCreatureAI(npc_batrider);
    RegisterSpellScript(spell_batrider_bomb);
}
