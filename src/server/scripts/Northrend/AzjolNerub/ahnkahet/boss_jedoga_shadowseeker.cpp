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

#include "AchievementCriteriaScript.h"
#include "Containers.h"
#include "CreatureScript.h"
#include "ObjectAccessor.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TemporarySummon.h"
#include "ahnkahet.h"

enum Yells
{
    SAY_AGGRO                               = 0,
    SAY_SACRIFICE_1                         = 1,
    SAY_SACRIFICE_2                         = 2,
    SAY_SLAY                                = 3,
    SAY_DEATH                               = 4,
    SAY_PREACHING                           = 5,

    // Initiate
    SAY_CHOSEN                              = 0,
    SAY_SACRIFICED                          = 1,
};

enum Spells
{
    // VISUALS
    SPELL_SPHERE_VISUAL                     = 56075,
    SPELL_WHITE_SPHERE                      = 56102,
    SPELL_LIGHTNING_BOLTS                   = 56327,
    SPELL_ACTIVATE_INITIATE                 = 56868,
    SPELL_SACRIFICE_VISUAL                  = 56133,
    SPELL_SACRIFICE_BEAM                    = 56150,
    SPELL_HOVER_FALL                        = 56100,
    SPELL_BEAM_VISUAL_JEDOGA                = 56312,

    // FIGHT
    SPELL_GIFT_OF_THE_HERALD                = 56219,
    SPELL_CYCLONE_STRIKE                    = 56855, // Self
    SPELL_CYCLONE_STRIKE_H                  = 60030,
    SPELL_LIGHTNING_BOLT                    = 56891, // 40Y
    SPELL_LIGHTNING_BOLT_H                  = 60032, // 40Y
    SPELL_THUNDERSHOCK                      = 56926, // 30Y
    SPELL_THUNDERSHOCK_H                    = 60029  // 30Y
};

enum Events
{
    // Jedoga
    EVENT_JEDOGA_CYCLONE                    = 1,
    EVENT_JEDOGA_LIGHTNING_BOLT,
    EVENT_JEDOGA_THUNDERSHOCK,
    EVENT_JEDOGA_PREPARE_RITUAL,
    EVENT_JEDOGA_MOVE_UP,
    EVENT_JEDOGA_MOVE_DOWN,
    EVENT_JEDGA_START_RITUAL,

    // Initiate
    EVENT_RITUAL_BEGIN_MOVE,
};

enum Creatures
{
    NPC_TWILIGHT_INITIATE                   = 30114,
    NPC_TWILIGHT_VOLUNTEER                  = 30385,
};

enum Misc : uint32
{
    MAX_COMBAT_INITIATES                    = 25,
    DATA_VOLUNTEER_WORK                     = 1,
};

enum SummonGroups
{
    SUMMON_GROUP_OOC                        = 0,
    SUMMON_GROUP_OOC_TRIGGERS               = 1,
};

enum Points
{
    POINT_DOWN                              = 1,
    POINT_UP,
    POINT_RITUAL,
    POINT_INITIAL,
};

enum Phases
{
    PHASE_NORMAL                            = 0x01,
    PHASE_RITUAL                            = 0x02,
};

enum Actions
{
    ACTION_RITUAL_BEGIN                     = 1,
    ACTION_SACRAFICE,
};

const Position JedogaPosition[3] =
{
    { 372.330994f,  -705.278015f,   -2.459692f  },     // POINT_DOWN
    { 372.330994f,  -705.278015f,   -16.179716f },     // POINT_UP
    { 373.48f,      -706.00f,       -16.18f     }      // POINT_RITUAL and POINT_INITIAL. This positions also is used for visual trigger used for ritual
};

// Combat summon locations
const Position VolunteerSpotPositions[MAX_COMBAT_INITIATES][2] =
{
        //        Spawn position           ||            Move position
    { { 400.7701f, -784.8928f, -31.60143f }, { 365.9514f, -719.1235f, -16.17974f } },
    { { 397.3595f, -788.5157f, -31.59679f }, { 359.7433f, -715.017f,  -16.17974f } },
    { { 399.3177f, -787.2599f, -31.59631f }, { 362.0263f, -719.1036f, -16.17974f } },
    { { 460.4623f, -719.2227f, -31.58718f }, { 389.266f,  -679.3693f, -16.17973f } },
    { { 456.0909f, -724.3412f, -31.58718f }, { 400.5992f, -691.7954f, -16.17973f } },
    { { 452.6613f, -726.9518f, -31.58718f }, { 400.3423f, -701.5115f, -16.17974f } },
    { { 447.8852f, -732.3298f, -31.58718f }, { 389.861f,  -710.6993f, -16.17974f } },
    { { 457.562f,  -721.1855f, -31.58718f }, { 395.4494f, -684.5345f, -16.17973f } },
    { { 451.7243f, -730.2181f, -31.58718f }, { 397.0945f, -708.4188f, -15.99747f } },
    { { 413.9582f, -777.132f,  -31.58716f }, { 388.1394f, -723.124f,  -15.9938f  } },
    { { 411.5661f, -781.2356f, -31.58716f }, { 381.7102f, -730.0745f, -15.99554f } },
    { { 407.395f,  -786.793f,  -31.58716f }, { 366.9791f, -737.3303f, -16.17974f } },
    { { 404.9166f, -788.3472f, -31.58716f }, { 358.6124f, -735.9944f, -15.9855f  } },
    { { 401.5697f, -791.2033f, -31.58717f }, { 351.9383f, -729.6436f, -16.17974f } },
    { { 410.1105f, -785.4691f, -31.58716f }, { 373.1659f, -736.2893f, -16.17974f } },
    { { 442.5644f, -730.2499f, -31.59826f }, { 390.5955f, -714.6851f, -16.17974f } },
    { { 445.5233f, -725.9542f, -31.60173f }, { 393.9694f, -708.1727f, -16.17974f } },
    { { 448.5531f, -722.5888f, -31.60066f }, { 395.2702f, -702.556f,  -16.17974f } },
    { { 449.8521f, -719.7265f, -31.58849f }, { 394.5757f, -695.1004f, -16.17974f } },
    { { 453.5134f, -717.7018f, -31.59883f }, { 387.6152f, -690.1782f, -16.17974f } },
    { { 457.8564f, -711.7424f, -31.59773f }, { 378.6874f, -687.1343f, -16.17973f } },
    { { 410.0583f, -774.4119f, -31.60115f }, { 383.8151f, -723.4276f, -16.17974f } },
    { { 408.7458f, -777.955f,  -31.59873f }, { 376.9857f, -725.0735f, -16.17974f } },
    { { 405.2404f, -779.6614f, -31.60512f }, { 373.3736f, -722.7498f, -16.17974f } },
    { { 404.0797f, -783.829f,  -31.59497f }, { 367.8631f, -722.5212f, -16.17974f } }
};

struct boss_jedoga_shadowseeker : public BossAI
{
    boss_jedoga_shadowseeker(Creature* pCreature) : BossAI(pCreature, DATA_JEDOGA_SHADOWSEEKER),
        sayPreachTimer(120000),
        combatSummonsSummoned(false),
        ritualTriggered(false),
        volunteerWork(true)
    { }

    // Disabled events
    void MoveInLineOfSight(Unit* /*who*/) override {}

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToAll(true);
        me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
        me->SetDisableGravity(true);
        me->SetHover(true);
        me->GetMotionMaster()->MovePoint(POINT_INITIAL, JedogaPosition[0], false);

        _Reset();
        events.SetPhase(PHASE_NORMAL);

        DespawnOOCSummons();
        std::list<TempSummon*> tempOOCSummons;
        me->SummonCreatureGroup(SUMMON_GROUP_OOC, &tempOOCSummons);
        if (!tempOOCSummons.empty())
        {
            for (TempSummon* summon : tempOOCSummons)
            {
                if (summon)
                {
                    summon->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
                    summon->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_MAGIC, false);
                    summon->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
                    summon->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                    summon->SetStandState(UNIT_STAND_STATE_KNEEL);
                    oocSummons.push_back(summon->GetGUID());
                }
            }
        }

        tempOOCSummons.clear();

        me->SummonCreatureGroup(SUMMON_GROUP_OOC_TRIGGERS, &tempOOCSummons);
        if (!tempOOCSummons.empty())
        {
            for (TempSummon* trigger : tempOOCSummons)
            {
                if (trigger)
                {
                    oocTriggers.push_back(trigger->GetGUID());
                }
            }
        }

        sacraficeTarget_GUID.Clear();
        sayPreachTimer = 120000;
        ritualTriggered = false;
        volunteerWork = true;
        combatSummonsSummoned = false;
    }

    void JustSummoned(Creature* summon) override
    {
        if (summon->GetEntry() == NPC_JEDOGA_CONTROLLER)
        {
            summons.Summon(summon);
        }
    }

    void SummonedCreatureDies(Creature* summon, Unit* killer) override
    {
        switch (summon->GetEntry())
        {
            case NPC_TWILIGHT_INITIATE:
            {
                GuidList::iterator itr = std::find(oocSummons.begin(), oocSummons.end(), summon->GetGUID());
                if (itr == oocSummons.end())
                {
                    break;
                }

                oocSummons.erase(itr);
                if (!oocSummons.empty())
                {
                    break;
                }

                DespawnOOCSummons();
                DoCastSelf(SPELL_HOVER_FALL);
                me->GetMotionMaster()->MoveIdle();
                me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1], false);

                if (!combatSummonsSummoned)
                {
                    summons.DespawnEntry(NPC_TWILIGHT_VOLUNTEER);
                    for (uint8 i = 0; i < MAX_COMBAT_INITIATES; ++i)
                    {
                        if (TempSummon* summon = me->SummonCreature(NPC_TWILIGHT_VOLUNTEER, VolunteerSpotPositions[i][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                        {
                            summon->GetMotionMaster()->MovePoint(POINT_INITIAL, VolunteerSpotPositions[i][1]);
                            summon->SetReactState(REACT_PASSIVE);
                            summon->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                            summon->SetImmuneToAll(true);
                            summons.Summon(summon);
                        }
                    }
                    combatSummonsSummoned = true;
                }

                break;
            }
            case NPC_TWILIGHT_VOLUNTEER:
            {
                if (sacraficeTarget_GUID && summon->GetGUID() != sacraficeTarget_GUID)
                {
                    break;
                }

                if (killer != me && killer->GetGUID() != sacraficeTarget_GUID)
                {
                    volunteerWork = false;
                }
                else
                {
                    DoCastSelf(SPELL_GIFT_OF_THE_HERALD, true);
                }
                events.ScheduleEvent(EVENT_JEDOGA_MOVE_DOWN, 1s, 0, PHASE_RITUAL);
                break;
            }
        }

        summons.Despawn(summon);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*school*/) override
    {
        if (!ritualTriggered && me->HealthBelowPctDamaged(55, damage) && events.IsInPhase(PHASE_NORMAL))
        {
            me->SetCombatMovement(false);
            me->InterruptNonMeleeSpells(false);
            me->AttackStop();
            me->SetReactState(REACT_PASSIVE);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

            events.SetPhase(PHASE_RITUAL);
            events.ScheduleEvent(EVENT_JEDOGA_PREPARE_RITUAL, 1s, 0, PHASE_RITUAL);
            ritualTriggered = true;
            return;
        }

        if (events.IsInPhase(PHASE_RITUAL))
        {
            damage = 0;
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_SACRAFICE)
        {
            if (Creature* target = ObjectAccessor::GetCreature(*me, sacraficeTarget_GUID))
            {
                Unit::Kill(me, target);
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        Talk(SAY_AGGRO);
        ReschedulleCombatEvents();
    }

    void KilledUnit(Unit* who) override
    {
        if (who->GetTypeId() != TYPEID_PLAYER)
        {
            return;
        }

        Talk(SAY_SLAY);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        DespawnOOCSummons();
        Talk(SAY_DEATH);
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (!(type == POINT_MOTION_TYPE || type == EFFECT_MOTION_TYPE))
        {
            return;
        }

        switch (pointId)
        {
            case POINT_DOWN:
            {
                me->ClearUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                ReschedulleCombatEvents();
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetImmuneToAll(false);
                me->SetReactState(REACT_AGGRESSIVE);

                me->RemoveAurasDueToSpell(SPELL_SPHERE_VISUAL);
                me->RemoveAurasDueToSpell(SPELL_LIGHTNING_BOLTS);
                me->RemoveAurasDueToSpell(SPELL_HOVER_FALL);
                me->SetCombatMovement(true);

                me->SetDisableGravity(false);
                me->SetHover(false);

                me->SetInCombatWithZone();
                if (Unit* victim = me->GetVictim())
                {
                    me->StopMoving();
                    AttackStart(victim);
                }
                break;
            }
            case POINT_UP:
            {
                me->SetFacingTo(5.66f);
                if (!summons.empty())
                {
                    sacraficeTarget_GUID = Acore::Containers::SelectRandomContainerElement(summons);
                    if (ObjectAccessor::GetCreature(*me, sacraficeTarget_GUID))
                    {
                        events.ScheduleEvent(EVENT_JEDGA_START_RITUAL, 3s, 0, PHASE_RITUAL);
                    }
                    // Something failed, let players continue but do not grant achievement
                    else
                    {
                        volunteerWork = false;
                        me->GetMotionMaster()->Clear();
                        DoCastSelf(SPELL_HOVER_FALL);
                        me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1], false);
                    }
                }
                break;
            }
            case POINT_RITUAL:
            {
                me->SetFacingTo(5.66f);
                DoCastSelf(SPELL_HOVER_FALL);
                events.ScheduleEvent(EVENT_JEDOGA_MOVE_UP, 1s, 0, PHASE_RITUAL);
                break;
            }
            case POINT_INITIAL:
            {
                me->SetFacingTo(5.66f);
                DoCastSelf(SPELL_SPHERE_VISUAL, true);
                DoCastSelf(SPELL_LIGHTNING_BOLTS, true);
                if (!oocTriggers.empty())
                {
                    for (ObjectGuid const& guid : oocTriggers)
                    {
                        if (Creature* trigger = ObjectAccessor::GetCreature(*me, guid))
                        {
                            trigger->CastSpell(nullptr, SPELL_BEAM_VISUAL_JEDOGA);
                        }
                    }
                }
                break;
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            if (instance->GetBossState(DATA_PRINCE_TALDARAM) == DONE)
            {
                if (sayPreachTimer <= diff)
                {
                    Talk(SAY_PREACHING);
                    sayPreachTimer = 120000;    // 2 min
                }
                else
                {
                    sayPreachTimer -= diff;
                }
            }
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
                // Normal phase
                case EVENT_JEDOGA_CYCLONE:
                {
                    DoCastSelf(DUNGEON_MODE(SPELL_CYCLONE_STRIKE, SPELL_CYCLONE_STRIKE_H), false);
                    events.Repeat(10s, 14s);
                    break;
                }
                case EVENT_JEDOGA_LIGHTNING_BOLT:
                {
                    if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(pTarget, DUNGEON_MODE(SPELL_LIGHTNING_BOLT, SPELL_LIGHTNING_BOLT_H), false);
                    }
                    events.Repeat(11s, 15s);
                    break;
                }
                case EVENT_JEDOGA_THUNDERSHOCK:
                {
                    if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                    {
                        DoCast(pTarget, DUNGEON_MODE(SPELL_THUNDERSHOCK, SPELL_THUNDERSHOCK_H), false);
                    }

                    events.Repeat(16s, 22s);
                    break;
                }
                // Ritual phase
                case EVENT_JEDOGA_PREPARE_RITUAL:
                {
                    me->GetMotionMaster()->Clear(true);
                    me->GetMotionMaster()->MovePoint(POINT_RITUAL, JedogaPosition[1]);
                    break;
                }
                case EVENT_JEDOGA_MOVE_UP:
                {
                    me->GetMotionMaster()->Clear(true);
                    me->SetDisableGravity(true);
                    me->SetHover(true);
                    me->GetMotionMaster()->MoveTakeoff(POINT_UP, JedogaPosition[0], 7.0f);
                    break;
                }
                case EVENT_JEDOGA_MOVE_DOWN:
                {
                    summons.DespawnEntry(NPC_JEDOGA_CONTROLLER);
                    DoCastSelf(SPELL_HOVER_FALL);
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1], false);
                    break;
                }
                case EVENT_JEDGA_START_RITUAL:
                {
                    sacraficeTarget_GUID = Acore::Containers::SelectRandomContainerElement(summons);
                    if (Creature* volunteer = ObjectAccessor::GetCreature(*me, sacraficeTarget_GUID))
                    {
                        Talk(SAY_SACRIFICE_1);
                        sacraficeTarget_GUID = volunteer->GetGUID();
                        volunteer->AI()->DoAction(ACTION_RITUAL_BEGIN);
                    }
                    break;
                }
            }
        }

        DoMeleeAttackIfReady();
    }

    uint32 GetData(uint32 type) const override
    {
        if (type == DATA_VOLUNTEER_WORK)
        {
            return volunteerWork ? 1 : 0;
        }

        return 0;
    }

private:
    GuidList oocSummons;
    GuidList oocTriggers;
    ObjectGuid sacraficeTarget_GUID;
    uint32 sayPreachTimer;
    bool combatSummonsSummoned;
    bool ritualTriggered;
    bool volunteerWork; // true = success, false = failed

    void ReschedulleCombatEvents()
    {
        events.SetPhase(PHASE_NORMAL);
        events.RescheduleEvent(EVENT_JEDOGA_CYCLONE, 3s, 0, PHASE_NORMAL);
        events.RescheduleEvent(EVENT_JEDOGA_LIGHTNING_BOLT, 7s, 0, PHASE_NORMAL);
        events.RescheduleEvent(EVENT_JEDOGA_THUNDERSHOCK, 12s, 0, PHASE_NORMAL);
    }

    void DespawnOOCSummons()
    {
        if (!oocTriggers.empty())
        {
            for (ObjectGuid const& guid : oocTriggers)
            {
                if (Creature* summon = ObjectAccessor::GetCreature(*me, guid))
                {
                    summon->DespawnOrUnsummon();
                }
            }
            oocTriggers.clear();
        }

        if (!oocSummons.empty())
        {
            for (ObjectGuid const& guid : oocSummons)
            {
                if (Creature* summon = ObjectAccessor::GetCreature(*me, guid))
                {
                    summon->DespawnOrUnsummon();
                }
            }
            oocSummons.clear();
        }
    }
};

struct npc_twilight_volunteer : public ScriptedAI
{
    npc_twilight_volunteer(Creature* pCreature) : ScriptedAI(pCreature),
        pInstance(pCreature->GetInstanceScript()),
        isSacraficeTarget(false)
    {
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_RITUAL_BEGIN)
        {
            isSacraficeTarget = true;
            me->SetRegeneratingHealth(false);
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
            DoCastSelf(SPELL_ACTIVATE_INITIATE, true);
            me->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
            me->SetControlled(false, UNIT_STATE_STUNNED);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
            me->SetImmuneToAll(false);

            Talk(SAY_CHOSEN);
            me->SetStandState(UNIT_STAND_STATE_STAND);

            events.ScheduleEvent(EVENT_RITUAL_BEGIN_MOVE, 1500ms);
        }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (!isSacraficeTarget)
        {
            ScriptedAI::EnterEvadeMode(why);
        }
    }

    void AttackStart(Unit* who) override
    {
        if (!isSacraficeTarget)
        {
            ScriptedAI::AttackStart(who);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE)
        {
            return;
        }

        if (id == POINT_INITIAL)
        {
            me->SetFacingTo(me->GetAngle(&JedogaPosition[0]));
            me->SendMovementFlagUpdate();
            DoCastSelf(SPELL_WHITE_SPHERE, false);
            me->SetControlled(true, UNIT_STATE_STUNNED);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
        }
        else if (id == POINT_RITUAL)
        {
            if (Creature* jedoga = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_JEDOGA_SHADOWSEEKER)))
            {
                jedoga->AI()->Talk(SAY_SACRIFICE_2);
                jedoga->CastSpell(nullptr, SPELL_SACRIFICE_BEAM); /// @todo: Visual is not working. (cosmetic)
                jedoga->AI()->DoAction(ACTION_SACRAFICE);
            }

            Talk(SAY_SACRIFICED);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!events.Empty())
        {
            events.Update(diff);
            if (events.ExecuteEvent() == EVENT_RITUAL_BEGIN_MOVE)
            {
                me->GetMotionMaster()->Clear();
                me->SetHomePosition(JedogaPosition[2]);
                me->SetWalk(true);
                me->GetMotionMaster()->MovePoint(POINT_RITUAL, JedogaPosition[2], false);

                if (Creature* jedoga = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_JEDOGA_SHADOWSEEKER)))
                {
                    if (Creature* ritualTrigger = jedoga->SummonCreature(NPC_JEDOGA_CONTROLLER, JedogaPosition[2], TEMPSUMMON_TIMED_DESPAWN, 15000))
                    {
                        ritualTrigger->CastSpell(ritualTrigger, SPELL_SACRIFICE_VISUAL);
                    }
                }
            }
        }

        if (!isSacraficeTarget && UpdateVictim())
        {
            DoMeleeAttackIfReady();
        }
    }

private:
    InstanceScript* pInstance;
    EventMap events;
    bool isSacraficeTarget;
};

// 56328 - Random Lightning Visual Effect
class spell_random_lightning_visual_effect : public SpellScript
{
    PrepareSpellScript(spell_random_lightning_visual_effect);

    void ModDestHeight(SpellDestination& dest)
    {
        Position const offset = { frand(-15.0f, 15.0f), frand(-15.0f, 15.0f), -19.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_random_lightning_visual_effect::ModDestHeight, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
    }
};

// CriteriaID 7359, Volunteer Work (2056)
class achievement_volunteer_work : public AchievementCriteriaScript
{
    public:
        achievement_volunteer_work() : AchievementCriteriaScript("achievement_volunteer_work")
        {
        }

        bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
        {
            if (Creature const* jedoga = target ? target->ToCreature() : nullptr)
            {
                return jedoga->AI()->GetData(DATA_VOLUNTEER_WORK) == 1;
            }

            return false;
        }
};

void AddSC_boss_jedoga_shadowseeker()
{
    // Creatures
    RegisterAhnKahetCreatureAI(boss_jedoga_shadowseeker);
    RegisterAhnKahetCreatureAI(npc_twilight_volunteer);

    // Spells
    RegisterSpellScript(spell_random_lightning_visual_effect);

    // Achievements
    new achievement_volunteer_work();
}

