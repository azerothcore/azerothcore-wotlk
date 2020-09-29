/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_eye.h"
#include "WorldPacket.h"
#include "Opcodes.h"

enum Yells
{
    // Kael'thas Speech
    SAY_INTRO                           = 0,
    SAY_INTRO_CAPERNIAN                 = 1,
    SAY_INTRO_TELONICUS                 = 2,
    SAY_INTRO_THALADRED                 = 3,
    SAY_INTRO_SANGUINAR                 = 4,
    SAY_PHASE2_WEAPON                   = 5,
    SAY_PHASE3_ADVANCE                  = 6,
    SAY_PHASE4_INTRO2                   = 7,
    SAY_PHASE5_NUTS                     = 8,
    SAY_SLAY                            = 9,
    SAY_MINDCONTROL                     = 10,
    SAY_GRAVITYLAPSE                    = 11,
    SAY_SUMMON_PHOENIX                  = 12,
    SAY_DEATH                           = 13,
    SAY_PYROBLAST                       = 14,

    // Advisors
    SAY_THALADRED_AGGRO                 = 0,
    SAY_SANGUINAR_AGGRO                 = 0,
    SAY_CAPERNIAN_AGGRO                 = 0,
    SAY_TELONICUS_AGGRO                 = 0
};

enum Spells
{
    // Phase 2 spells
    SPELL_SUMMON_WEAPONS                = 36976,
    SPELL_SUMMON_WEAPONA                = 36958,
    SPELL_SUMMON_WEAPONB                = 36959,
    SPELL_SUMMON_WEAPONC                = 36960,
    SPELL_SUMMON_WEAPOND                = 36961,
    SPELL_SUMMON_WEAPONE                = 36962,
    SPELL_SUMMON_WEAPONF                = 36963,
    SPELL_SUMMON_WEAPONG                = 36964,

    // Phase 3 spells
    SPELL_RESURRECTION                  = 36450,

    // Phase 4 spells
    SPELL_FIREBALL                      = 36805,
    SPELL_ARCANE_DISRUPTION             = 36834,
    SPELL_PHOENIX                       = 36723,
    SPELL_MIND_CONTROL                  = 36797,
    SPELL_SHOCK_BARRIER                 = 36815,
    SPELL_PYROBLAST                     = 36819,
    SPELL_FLAME_STRIKE                  = 36735,
    SPELL_FLAME_STRIKE_DAMAGE           = 36731,

    // Event
    SPELL_NETHERBEAM_AURA1              = 36364,
    SPELL_NETHERBEAM_AURA2              = 36370,
    SPELL_NETHERBEAM_AURA3              = 36371,
    SPELL_NETHERBEAM1                   = 36089,
    SPELL_NETHERBEAM2                   = 36090,
    SPELL_KAEL_GAINING_POWER            = 36091,
    SPELL_KAEL_EXPLODES1                = 36376,
    SPELL_KAEL_EXPLODES2                = 36375,
    SPELL_KAEL_EXPLODES3                = 36373,
    SPELL_KAEL_EXPLODES4                = 36354,
    SPELL_KAEL_EXPLODES5                = 36092,
    SPELL_GROW                          = 36184,
    SPELL_KEAL_STUNNED                  = 36185,
    SPELL_KAEL_FULL_POWER               = 36187,
    SPELL_FLOATING_DROWNED              = 36550,

    SPELL_PURE_NETHER_BEAM1             = 36196,
    SPELL_PURE_NETHER_BEAM2             = 36197,
    SPELL_PURE_NETHER_BEAM3             = 36198,

    // Phase 5 spells
    SPELL_GRAVITY_LAPSE                 = 35941,
    SPELL_GRAVITY_LAPSE_TELEPORT1       = 35966,
    SPELL_GRAVITY_LAPSE_KNOCKBACK       = 34480,
    SPELL_GRAVITY_LAPSE_AURA            = 39432,
    SPELL_SUMMON_NETHER_VAPOR           = 35865,
    SPELL_NETHER_BEAM                   = 35869,
    SPELL_NETHER_BEAM_DAMAGE            = 35873,


    SPELL_REMOTE_TOY_STUN               = 37029
};

enum Misc
{
    POINT_MIDDLE                        = 1,
    POINT_AIR                           = 2,
    POINT_START_LAST_PHASE              = 3,
    DATA_RESURRECT_CAST                 = 1,
    NPC_WORLD_TRIGGER                   = 19871,
    NPC_NETHER_VAPOR                    = 21002,

    PHASE_NONE                          = 0,
    PHASE_SINGLE_ADVISOR                = 1,
    PHASE_WEAPONS                       = 2,
    PHASE_ALL_ADVISORS                  = 3,
    PHASE_FINAL                         = 4,

    EVENT_PREFIGHT_PHASE11              = 1,
    EVENT_PREFIGHT_PHASE12              = 2,
    EVENT_PREFIGHT_PHASE21              = 3,
    EVENT_PREFIGHT_PHASE22              = 4,
    EVENT_PREFIGHT_PHASE31              = 5,
    EVENT_PREFIGHT_PHASE32              = 6,
    EVENT_PREFIGHT_PHASE41              = 7,
    EVENT_PREFIGHT_PHASE42              = 8,
    EVENT_PREFIGHT_PHASE51              = 9,
    EVENT_PREFIGHT_PHASE52              = 10,
    EVENT_PREFIGHT_PHASE61              = 11,
    EVENT_PREFIGHT_PHASE62              = 12,
    EVENT_PREFIGHT_PHASE63              = 13,
    EVENT_PREFIGHT_PHASE71              = 14,
    EVENT_GATHER_ADVISORS               = 15,

    EVENT_SPELL_SEQ_1                   = 30,
    EVENT_SPELL_SEQ_2                   = 31,
    EVENT_SPELL_SEQ_3                   = 32,
    EVENT_SPELL_FIREBALL                = 33,
    EVENT_SPELL_PYROBLAST               = 34,
    EVENT_SPELL_FLAMESTRIKE             = 35,
    EVENT_SPELL_ARCANE_DISRUPTION       = 36,
    EVENT_SPELL_MIND_CONTROL            = 37,
    EVENT_SPELL_SUMMON_PHOENIX          = 38,
    EVENT_CHECK_HEALTH                  = 39,
    EVENT_SPELL_GRAVITY_LAPSE           = 40,
    EVENT_GRAVITY_LAPSE_END             = 41,
    EVENT_SPELL_SHOCK_BARRIER           = 42,
    EVENT_SPELL_NETHER_BEAM             = 43,
    EVENT_SPELL_NETHER_VAPOR            = 44,

    EVENT_SCENE_1                       = 50,
    EVENT_SCENE_2                       = 51,
    EVENT_SCENE_3                       = 52,
    EVENT_SCENE_4                       = 53,
    EVENT_SCENE_5                       = 54,
    EVENT_SCENE_6                       = 55,
    EVENT_SCENE_7                       = 56,
    EVENT_SCENE_8                       = 57,
    EVENT_SCENE_9                       = 58,
    EVENT_SCENE_10                      = 59,
    EVENT_SCENE_11                      = 60,
    EVENT_SCENE_12                      = 61,
    EVENT_SCENE_13                      = 62,
    EVENT_SCENE_14                      = 63,
    EVENT_SCENE_15                      = 64,
    EVENT_SCENE_16                      = 65
};

const Position triggersPos[6] =
{
    {799.11f, -38.95f, 85.0f, 0.0f},
    {800.16f, 37.65f, 85.0f, 0.0f},
    {847.64f, -16.19f, 64.05f, 0.0f},
    {847.53f, 15.01f, 63.69f, 0.0f},
    {843.44f, -7.87f, 67.14f, 0.0f},
    {843.35f, 6.35f, 67.14f, 0.0f}
};

class boss_kaelthas : public CreatureScript
{
    public:
        boss_kaelthas() : CreatureScript("boss_kaelthas") { }

        struct boss_kaelthasAI : public BossAI
        {
            boss_kaelthasAI(Creature* creature) : BossAI(creature, DATA_KAELTHAS) { }

            uint8 phase;
            EventMap events2;
            
            void PrepareAdvisors()
            {
                for (uint8 i = DATA_KAEL_ADVISOR1; i <= DATA_KAEL_ADVISOR4; ++i)
                    if (Creature* advisor = ObjectAccessor::GetCreature(*me, instance->GetData64(i)))
                    {
                        advisor->Respawn(true);
                        advisor->StopMovingOnCurrentPos();
                        advisor->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        advisor->SetReactState(REACT_PASSIVE);
                        summons.Summon(advisor);
                    }
            }

            void SetData(uint32 type, uint32 data)
            {
                if (type == DATA_RESURRECT_CAST && data == DATA_RESURRECT_CAST)
                {
                    for (SummonList::const_iterator i = summons.begin(); i != summons.end(); ++i)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                            if (summon->GetDBTableGUIDLow())
                            {
                                summon->SetReactState(REACT_PASSIVE);
                                summon->setDeathState(JUST_RESPAWNED);
                                summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            }
                }
            }

            void SetRoomState(GOState state)
            {
                if (GameObject* window = ObjectAccessor::GetGameObject(*me, instance->GetData64(GO_BRIDGE_WINDOW)))
                    window->SetGoState(state);
                if (GameObject* window = ObjectAccessor::GetGameObject(*me, instance->GetData64(GO_KAEL_STATUE_RIGHT)))
                    window->SetGoState(state);
                if (GameObject* window = ObjectAccessor::GetGameObject(*me, instance->GetData64(GO_KAEL_STATUE_LEFT)))
                    window->SetGoState(state);
            }

            void Reset()
            {
                BossAI::Reset();
                events2.Reset();
                events2.ScheduleEvent(EVENT_GATHER_ADVISORS, 1000);
                phase = PHASE_NONE;

                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HOVER, true);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_DISABLE_MOVE);
                SetRoomState(GO_STATE_READY);
                me->SetDisableGravity(false);
                me->SetWalk(false);
            }

            void AttackStart(Unit* who)
            {
                if (phase == PHASE_FINAL && events.GetNextEventTime(EVENT_GRAVITY_LAPSE_END) == 0)
                    BossAI::AttackStart(who);
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (phase == PHASE_NONE && who->GetTypeId() == TYPEID_PLAYER && me->IsValidAttackTarget(who))
                {
                    phase = PHASE_SINGLE_ADVISOR;
                    me->SetInCombatWithZone();
                    Talk(SAY_INTRO);
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE11, 23000);
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE12, 30000);
                }
            }

            void EnterCombat(Unit* who)
            {
                BossAI::EnterCombat(who);
            }

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_SLAY);
            }

            void JustSummoned(Creature* summon)
            {
                summons.Summon(summon);
                if (summon->GetEntry() == NPC_NETHER_VAPOR)
                    summon->GetMotionMaster()->MoveRandom(20.0f);
            }

            void SummonedCreatureDies(Creature* summon, Unit*)
            {
                if (phase == PHASE_FINAL)
                    return;

                if (summon->GetDBTableGUIDLow() && phase == PHASE_ALL_ADVISORS)
                {
                    for (SummonList::const_iterator i = summons.begin(); i != summons.end(); ++i)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                            if (summon->GetDBTableGUIDLow() && summon->IsAlive())
                                return;

                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE71, 2000);
                    return;
                }

                if (summon->GetEntry() == NPC_THALADRED)
                {
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE21, 2000);
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE22, 14500);
                }
                else if (summon->GetEntry() == NPC_LORD_SANGUINAR)
                {
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE31, 2000);
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE32, 9000);
                }
                else if (summon->GetEntry() == NPC_CAPERNIAN)
                {
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE41, 2000);
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE42, 10400);
                }
                else if (summon->GetEntry() == NPC_TELONICUS)
                {
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE51, 3000);
                    events2.ScheduleEvent(EVENT_PREFIGHT_PHASE52, 9000);
                }
            }

            void JustDied(Unit* killer)
            {
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_NOT_SELECTABLE);

                Talk(SAY_DEATH);
                BossAI::JustDied(killer);
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != POINT_MOTION_TYPE)
                    return;

                if (point == POINT_MIDDLE)
                {
                    events2.ScheduleEvent(EVENT_SCENE_1, 0);
                    events2.ScheduleEvent(EVENT_SCENE_2, 2500);
                    events2.ScheduleEvent(EVENT_SCENE_3, 4000);
                    events2.ScheduleEvent(EVENT_SCENE_4, 7000);
                    events2.ScheduleEvent(EVENT_SCENE_5, 10000);
                    events2.ScheduleEvent(EVENT_SCENE_6, 14000);
                    events2.ScheduleEvent(EVENT_SCENE_7, 17500);
                    events2.ScheduleEvent(EVENT_SCENE_8, 19000);
                    events2.ScheduleEvent(EVENT_SCENE_9, 22000); // two first lightnings + aura
                    events2.ScheduleEvent(EVENT_SCENE_10, 22800); // two
                    events2.ScheduleEvent(EVENT_SCENE_11, 23600); // two
                    events2.ScheduleEvent(EVENT_SCENE_12, 24500); // two
                    events2.ScheduleEvent(EVENT_SCENE_13, 24800); // two
                    events2.ScheduleEvent(EVENT_SCENE_14, 25300); // two
                    events2.ScheduleEvent(EVENT_SCENE_15, 32000); // full power
                    events2.ScheduleEvent(EVENT_SCENE_16, 36000); // remove lightnings + aura, move down
                }
                else if (point == POINT_START_LAST_PHASE)
                {
                    me->SetDisableGravity(false);
                    me->SetWalk(false);
                    me->RemoveAurasDueToSpell(SPELL_KAEL_FULL_POWER);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                    events.SetTimer(60000);
                    events.ScheduleEvent(EVENT_SPELL_FIREBALL, 0);
                    events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 10000);
                    events.ScheduleEvent(EVENT_SPELL_SUMMON_PHOENIX, 20000);
                    events.ScheduleEvent(EVENT_SPELL_GRAVITY_LAPSE, 5000);
                    if (me->GetVictim())
                    {
                        me->SetTarget(me->GetVictim()->GetGUID());
                        AttackStart(me->GetVictim());
                    }
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (EnterEvadeIfOutOfCombatArea())
                    return;

                events2.Update(diff);
                switch (events2.ExecuteEvent())
                {
                    case EVENT_GATHER_ADVISORS:
                        PrepareAdvisors();
                        break;
                    case EVENT_PREFIGHT_PHASE11:
                        Talk(SAY_INTRO_THALADRED);
                        break;
                    case EVENT_PREFIGHT_PHASE12:
                        if (Creature* advisor = summons.GetCreatureWithEntry(NPC_THALADRED))
                        {
                            advisor->SetReactState(REACT_AGGRESSIVE);
                            advisor->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                advisor->AI()->AttackStart(target);
                            advisor->SetInCombatWithZone();
                            advisor->AI()->Talk(SAY_THALADRED_AGGRO);
                        }
                        break;
                    case EVENT_PREFIGHT_PHASE21:
                        Talk(SAY_INTRO_SANGUINAR);
                        break;
                    case EVENT_PREFIGHT_PHASE22:
                        if (Creature* advisor = summons.GetCreatureWithEntry(NPC_LORD_SANGUINAR))
                        {
                            advisor->SetReactState(REACT_AGGRESSIVE);
                            advisor->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                advisor->AI()->AttackStart(target);
                            advisor->SetInCombatWithZone();
                            advisor->AI()->Talk(SAY_SANGUINAR_AGGRO);
                        }
                        break;
                    case EVENT_PREFIGHT_PHASE31:
                        Talk(SAY_INTRO_CAPERNIAN);
                        break;
                    case EVENT_PREFIGHT_PHASE32:
                        if (Creature* advisor = summons.GetCreatureWithEntry(NPC_CAPERNIAN))
                        {
                            advisor->SetReactState(REACT_AGGRESSIVE);
                            advisor->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                advisor->AI()->AttackStart(target);
                            advisor->SetInCombatWithZone();
                            advisor->AI()->Talk(SAY_CAPERNIAN_AGGRO);
                        }
                        break;
                    case EVENT_PREFIGHT_PHASE41:
                        Talk(SAY_INTRO_TELONICUS);
                        break;
                    case EVENT_PREFIGHT_PHASE42:
                        if (Creature* advisor = summons.GetCreatureWithEntry(NPC_TELONICUS))
                        {
                            advisor->SetReactState(REACT_AGGRESSIVE);
                            advisor->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                advisor->AI()->AttackStart(target);
                            advisor->SetInCombatWithZone();
                            advisor->AI()->Talk(SAY_TELONICUS_AGGRO);
                        }
                        break;
                    case EVENT_PREFIGHT_PHASE51:
                        Talk(SAY_PHASE2_WEAPON);
                        me->CastSpell(me, SPELL_SUMMON_WEAPONS, false);
                        phase = PHASE_WEAPONS;
                        break;
                    case EVENT_PREFIGHT_PHASE52:
                        for (SummonList::const_iterator i = summons.begin(); i != summons.end(); ++i)
                        {
                            if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                                if (!summon->GetDBTableGUIDLow())
                                {
                                    summon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_NON_ATTACKABLE);
                                    summon->SetInCombatWithZone();
                                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                        summon->AI()->AttackStart(target);
                                }
                        }
                        events2.ScheduleEvent(EVENT_PREFIGHT_PHASE61, 2*MINUTE*IN_MILLISECONDS);
                        events2.ScheduleEvent(EVENT_PREFIGHT_PHASE62, 2*MINUTE*IN_MILLISECONDS+6000);
                        events2.ScheduleEvent(EVENT_PREFIGHT_PHASE63, 2*MINUTE*IN_MILLISECONDS+12000);
                        break;
                    case EVENT_PREFIGHT_PHASE61:
                        phase = PHASE_ALL_ADVISORS;
                        Talk(SAY_PHASE3_ADVANCE);
                        break;
                    case EVENT_PREFIGHT_PHASE62:
                        me->CastSpell(me, SPELL_RESURRECTION, false);
                        break;
                    case EVENT_PREFIGHT_PHASE63:
                        for (SummonList::const_iterator i = summons.begin(); i != summons.end(); ++i)
                            if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                                if (summon->GetDBTableGUIDLow())
                                {
                                    summon->SetReactState(REACT_AGGRESSIVE);
                                    summon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                                    summon->SetInCombatWithZone();
                                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                        summon->AI()->AttackStart(target);
                                }
                        events2.ScheduleEvent(EVENT_PREFIGHT_PHASE71, 3*MINUTE*IN_MILLISECONDS);
                        break;
                    case EVENT_PREFIGHT_PHASE71:
                        events2.CancelEvent(EVENT_PREFIGHT_PHASE71);
                        Talk(SAY_PHASE4_INTRO2);
                        phase = PHASE_FINAL;
                        DoResetThreat();
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_DISABLE_MOVE);
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            AttackStart(target);

                        events2.Reset();
                        events.Reset();
                        events.ScheduleEvent(EVENT_SPELL_FIREBALL, 1000);
                        events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 15000);
                        events.ScheduleEvent(EVENT_SPELL_SUMMON_PHOENIX, 30000);
                        events.ScheduleEvent(EVENT_SPELL_SEQ_1, 20000);
                        events.ScheduleEvent(EVENT_SPELL_SEQ_2, 40000);
                        events.ScheduleEvent(EVENT_SPELL_SEQ_3, 60000);
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        break;
                    case EVENT_SCENE_1:
                        me->SetTarget(0);
                        me->SetFacingTo(M_PI);
                        me->SetWalk(true);
                        Talk(SAY_PHASE5_NUTS);
                        break;
                    case EVENT_SCENE_2:
                        me->SetTarget(0);
                        me->CastSpell(me, SPELL_KAEL_EXPLODES1, true);
                        me->CastSpell(me, SPELL_KAEL_GAINING_POWER, false);
                        me->SetDisableGravity(true);
                        break;
                    case EVENT_SCENE_3:
                        me->SetTarget(0);
                        for (uint8 i = 0; i < 2; ++i)
                            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, triggersPos[i], TEMPSUMMON_TIMED_DESPAWN, 60000))
                                trigger->CastSpell(me, SPELL_NETHERBEAM1+i, false);
                        me->GetMotionMaster()->MovePoint(POINT_AIR, me->GetPositionX(), me->GetPositionY(), 76.0f, false, true);
                        me->CastSpell(me, SPELL_GROW, true);
                        break;
                    case EVENT_SCENE_4:
                        me->SetTarget(0);
                        me->CastSpell(me, SPELL_GROW, true);
                        me->CastSpell(me, SPELL_KAEL_EXPLODES2, true);
                        me->CastSpell(me, SPELL_NETHERBEAM_AURA1, true);
                        for (uint8 i = 0; i < 2; ++i)
                            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, triggersPos[i+2], TEMPSUMMON_TIMED_DESPAWN, 60000))
                                trigger->CastSpell(me, SPELL_NETHERBEAM1+i, false);
                        break;
                    case EVENT_SCENE_5:
                        me->SetTarget(0);
                        me->CastSpell(me, SPELL_GROW, true);
                        me->CastSpell(me, SPELL_KAEL_EXPLODES3, true);
                        me->CastSpell(me, SPELL_NETHERBEAM_AURA2, true);
                        for (uint8 i = 0; i < 2; ++i)
                            if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, triggersPos[i+4], TEMPSUMMON_TIMED_DESPAWN, 60000))
                                trigger->CastSpell(me, SPELL_NETHERBEAM1+i, false);
                        break;
                    case EVENT_SCENE_6:
                        me->CastSpell(me, SPELL_GROW, true);
                        me->CastSpell(me, SPELL_KAEL_EXPLODES4, true);
                        me->CastSpell(me, SPELL_NETHERBEAM_AURA3, true);
                        break;
                    case EVENT_SCENE_7:
                        SetRoomState(GO_STATE_ACTIVE);
                        me->SetUnitMovementFlags(MOVEMENTFLAG_HOVER|MOVEMENTFLAG_WALKING|MOVEMENTFLAG_DISABLE_GRAVITY);
                        me->SendMovementFlagUpdate();
                        break;
                    case EVENT_SCENE_8:
                        summons.DespawnEntry(WORLD_TRIGGER);
                        me->RemoveAurasDueToSpell(SPELL_NETHERBEAM_AURA1);
                        me->RemoveAurasDueToSpell(SPELL_NETHERBEAM_AURA2);
                        me->RemoveAurasDueToSpell(SPELL_NETHERBEAM_AURA3);
                        me->CastSpell(me, SPELL_KAEL_EXPLODES5, true);
                        me->CastSpell(me, SPELL_FLOATING_DROWNED, false);
                        //me->CastSpell(me, SPELL_KEAL_STUNNED, true);
                        break;
                    case EVENT_SCENE_9:
                        me->CastSpell(me, 52241, true); // WRONG VISUAL, ZOMG!
                        me->CastSpell(me, 34807, true);
                        me->SummonCreature(NPC_WORLD_TRIGGER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000);
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()+5, me->GetPositionY(), me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM1, true);
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()-5, me->GetPositionY(), me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM2, true);
                        break;
                    case EVENT_SCENE_10:
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()-5, me->GetPositionY()-5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM3, true);
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()+5, me->GetPositionY()+5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM1, true);
                        break;
                    case EVENT_SCENE_11:
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX(), me->GetPositionY()+5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM2, true);
                        break;
                    case EVENT_SCENE_12:
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX(), me->GetPositionY()-5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM3, true);
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()+5, me->GetPositionY()-5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM1, true);
                        break;
                    case EVENT_SCENE_13:
                        if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()-5, me->GetPositionY()+5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                            trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM2, true);
                        break;
                    case EVENT_SCENE_14:
                        //if (Creature* trigger = me->SummonCreature(WORLD_TRIGGER, me->GetPositionX()-5, me->GetPositionY()+5, me->GetPositionZ()+15.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 60000))
                        //  trigger->CastSpell(me, SPELL_PURE_NETHER_BEAM3, true);
                        break;
                    case EVENT_SCENE_15:
                        me->RemoveAurasDueToSpell(SPELL_FLOATING_DROWNED);
                        me->RemoveAurasDueToSpell(SPELL_KEAL_STUNNED);
                        me->CastSpell(me, SPELL_KAEL_FULL_POWER, false);
                        me->CastSpell(me, 36709, true);
                        me->CastSpell(me, 36201, true);
                        me->CastSpell(me, 36290, true);
                        me->CastSpell(me, 36291, true);
                        me->SetUnitMovementFlags(MOVEMENTFLAG_DISABLE_GRAVITY|MOVEMENTFLAG_WALKING);
                        me->SendMovementFlagUpdate();
                        break;
                    case EVENT_SCENE_16:
                        summons.DespawnEntry(WORLD_TRIGGER);
                        me->RemoveAurasDueToSpell(52241); // WRONG VISUAL, ZOMG!
                        me->GetMotionMaster()->MovePoint(POINT_START_LAST_PHASE, me->GetHomePosition(), false, true);
                        break;
                }

                if (!events2.Empty())
                    return;

                if (!UpdateVictim())
                    return;

                events.Update(diff);
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_SPELL_SEQ_1:
                        events.ScheduleEvent(EVENT_SPELL_MIND_CONTROL, 0);
                        events.ScheduleEvent(EVENT_SPELL_ARCANE_DISRUPTION, 3000);
                        events.ScheduleEvent(EVENT_SPELL_SEQ_1, 50000);
                        break;
                    case EVENT_SPELL_SEQ_2:
                        events.ScheduleEvent(EVENT_SPELL_MIND_CONTROL, 3000);
                        events.ScheduleEvent(EVENT_SPELL_ARCANE_DISRUPTION, 6000);
                        events.ScheduleEvent(EVENT_SPELL_SEQ_2, 50000);
                        break;
                    case EVENT_SPELL_SEQ_3:
                        Talk(SAY_PYROBLAST);
                        me->CastSpell(me, SPELL_SHOCK_BARRIER, false);
                        events.ScheduleEvent(EVENT_SPELL_SEQ_3, 50000);
                        events.DelayEvents(10000);
                        events.ScheduleEvent(EVENT_SPELL_PYROBLAST, 0);
                        events.ScheduleEvent(EVENT_SPELL_PYROBLAST, 4000);
                        events.ScheduleEvent(EVENT_SPELL_PYROBLAST, 8000);
                        break;
                    case EVENT_SPELL_SHOCK_BARRIER:
                        me->CastSpell(me, SPELL_SHOCK_BARRIER, false);
                        break;
                    case EVENT_SPELL_FIREBALL:
                        me->CastSpell(me->GetVictim(), SPELL_FIREBALL, false);
                        events.ScheduleEvent(EVENT_SPELL_FIREBALL, roll_chance_i(70) ? 2000: 4000);
                        break;
                    case EVENT_SPELL_PYROBLAST:
                        me->CastSpell(me->GetVictim(), SPELL_PYROBLAST, false);
                        break;
                    case EVENT_SPELL_FLAMESTRIKE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                            me->CastSpell(target, SPELL_FLAME_STRIKE, false);
                        events.ScheduleEvent(EVENT_SPELL_FLAMESTRIKE, 20000);
                        break;
                    case EVENT_SPELL_ARCANE_DISRUPTION:
                        me->CastSpell(me, SPELL_ARCANE_DISRUPTION, false);
                        break;
                    case EVENT_SPELL_MIND_CONTROL:
                        if (roll_chance_i(50))
                            Talk(SAY_MINDCONTROL);
                        me->CastCustomSpell(SPELL_MIND_CONTROL, SPELLVALUE_MAX_TARGETS, 3, me, false);
                        break;
                    case EVENT_SPELL_SUMMON_PHOENIX:
                        Talk(SAY_SUMMON_PHOENIX);
                        me->CastSpell(me, SPELL_PHOENIX, false);
                        events.ScheduleEvent(EVENT_SPELL_SUMMON_PHOENIX, 40000);
                        break;
                    case EVENT_CHECK_HEALTH:
                        if (me->HealthBelowPct(51))
                        {
                            events.Reset();
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                            me->SetReactState(REACT_PASSIVE);
                            me->GetMotionMaster()->MovePoint(POINT_MIDDLE, me->GetHomePosition(), true, true); 
                            me->ClearUnitState(UNIT_STATE_MELEE_ATTACKING);
                            me->SendMeleeAttackStop();
                            break;
                        }
                        events.ScheduleEvent(EVENT_CHECK_HEALTH, 1000);
                        break;
                    case EVENT_SPELL_GRAVITY_LAPSE:
                        events.DelayEvents(30000);
                        me->setAttackTimer(BASE_ATTACK, 30000);
                        events.ScheduleEvent(EVENT_SPELL_GRAVITY_LAPSE, 90000);
                        events.ScheduleEvent(EVENT_GRAVITY_LAPSE_END, 32000);
                        events.ScheduleEvent(EVENT_SPELL_SHOCK_BARRIER, 20000);
                        events.ScheduleEvent(EVENT_SPELL_SHOCK_BARRIER, 10000);
                        events.ScheduleEvent(EVENT_SPELL_NETHER_BEAM, 4000);
                        events.ScheduleEvent(EVENT_SPELL_NETHER_VAPOR, 0);
                        me->CastSpell(me, SPELL_SHOCK_BARRIER, false);
                        me->CastSpell(me, SPELL_GRAVITY_LAPSE, false);
                        me->SetTarget(0);
                        me->GetMotionMaster()->Clear();
                        me->StopMoving();
                        Talk(SAY_GRAVITYLAPSE);
                        break;
                    case EVENT_SPELL_NETHER_VAPOR:
                        me->CastSpell(me, SPELL_SUMMON_NETHER_VAPOR, false);
                        break;
                    case EVENT_SPELL_NETHER_BEAM:
                        me->CastSpell(me, SPELL_NETHER_BEAM, false);
                        events.ScheduleEvent(EVENT_SPELL_NETHER_BEAM, 4000);
                        break;
                    case EVENT_GRAVITY_LAPSE_END:
                        summons.DespawnEntry(NPC_NETHER_VAPOR);
                        events.CancelEvent(EVENT_SPELL_NETHER_BEAM);
                        me->SetTarget(me->GetVictim()->GetGUID());
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                        break;
                }

                DoMeleeAttackIfReady();
            }

            bool CheckEvadeIfOutOfCombatArea() const
            {
                return me->GetHomePosition().GetExactDist2d(me) > 165.0f || !SelectTargetFromPlayerList(165.0f);
            }

        };
        CreatureAI* GetAI(Creature* creature) const
        {
            return GetInstanceAI<boss_kaelthasAI>(creature);
        }
};

class spell_kaelthas_kael_phase_two : public SpellScriptLoader
{
    public:
        spell_kaelthas_kael_phase_two() : SpellScriptLoader("spell_kaelthas_kael_phase_two") { }

        class spell_kaelthas_kael_phase_two_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kaelthas_kael_phase_two_SpellScript);

            bool Load()
            {
                if (GetCaster()->GetTypeId() == TYPEID_UNIT)
                    if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                        if (Creature* kael = ObjectAccessor::GetCreature(*GetCaster(), instance->GetData64(NPC_KAELTHAS)))
                            kael->AI()->SummonedCreatureDies(GetCaster()->ToCreature(), nullptr);
                return true;
            }

            void Register()
            {
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kaelthas_kael_phase_two_SpellScript();
        }
};

class spell_kaelthas_remote_toy : public SpellScriptLoader
{
    public:
        spell_kaelthas_remote_toy() : SpellScriptLoader("spell_kaelthas_remote_toy") { }

        class spell_kaelthas_remote_toy_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kaelthas_remote_toy_AuraScript);

            void HandlePeriodic(AuraEffect const*  /*aurEff*/)
            {
                PreventDefaultAction();
                if (roll_chance_i(66))
                    GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_REMOTE_TOY_STUN, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_kaelthas_remote_toy_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kaelthas_remote_toy_AuraScript();
        }
};

class spell_kaelthas_summon_weapons : public SpellScriptLoader
{
    public:
        spell_kaelthas_summon_weapons() : SpellScriptLoader("spell_kaelthas_summon_weapons") { }

        class spell_kaelthas_summon_weapons_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kaelthas_summon_weapons_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                for (uint32 i = SPELL_SUMMON_WEAPONA; i <= SPELL_SUMMON_WEAPONG; ++i)
                    GetCaster()->CastSpell(GetCaster(), i, true);               
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kaelthas_summon_weapons_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kaelthas_summon_weapons_SpellScript();
        }
};

class spell_kaelthas_resurrection : public SpellScriptLoader
{
    public:
        spell_kaelthas_resurrection() : SpellScriptLoader("spell_kaelthas_resurrection") { }

        class spell_kaelthas_resurrection_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kaelthas_resurrection_SpellScript);

            void HandleBeforeCast()
            {
                GetCaster()->GetAI()->SetData(DATA_RESURRECT_CAST, DATA_RESURRECT_CAST);
            }

            void Register()
            {
                BeforeCast += SpellCastFn(spell_kaelthas_resurrection_SpellScript::HandleBeforeCast);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kaelthas_resurrection_SpellScript();
        }
};

class spell_kaelthas_mind_control : public SpellScriptLoader
{
    public:
        spell_kaelthas_mind_control() : SpellScriptLoader("spell_kaelthas_mind_control") { }

        class spell_kaelthas_mind_control_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kaelthas_mind_control_SpellScript);

            void SelectTarget(std::list<WorldObject*>& targets)
            {
                if (Unit* victim = GetCaster()->GetVictim())
                    targets.remove_if(acore::ObjectGUIDCheck(victim->GetGUID(), true));
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kaelthas_mind_control_SpellScript::SelectTarget, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kaelthas_mind_control_SpellScript();
        }
};

class spell_kaelthas_burn : public SpellScriptLoader
{
    public:
        spell_kaelthas_burn() : SpellScriptLoader("spell_kaelthas_burn") { }

        class spell_kaelthas_burn_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kaelthas_burn_AuraScript);

            void HandlePeriodic(AuraEffect const*  /*aurEff*/)
            {
                Unit::DealDamage(GetUnitOwner(), GetUnitOwner(), GetUnitOwner()->CountPctFromMaxHealth(5)+1);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_kaelthas_burn_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kaelthas_burn_AuraScript();
        }
};

class spell_kaelthas_flame_strike : public SpellScriptLoader
{
    public:
        spell_kaelthas_flame_strike() : SpellScriptLoader("spell_kaelthas_flame_strike") { }

        class spell_kaelthas_flame_strike_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kaelthas_flame_strike_AuraScript);

            bool Load()
            {
                return GetUnitOwner()->GetTypeId() == TYPEID_UNIT;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetUnitOwner()->RemoveAllAuras();
                GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_FLAME_STRIKE_DAMAGE, true);
                GetUnitOwner()->ToCreature()->DespawnOrUnsummon(2000);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_kaelthas_flame_strike_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kaelthas_flame_strike_AuraScript();
        }
};

class lapseTeleport : public BasicEvent
{
    public:
        lapseTeleport(Player* owner) : _owner(owner)
        {
        }

        bool Execute(uint64 /*execTime*/, uint32 /*diff*/)
        {
            if (_owner->IsBeingTeleportedNear())
                _owner->m_Events.AddEvent(new lapseTeleport(_owner), _owner->m_Events.CalculateTime(1));
            else if (!_owner->IsBeingTeleported())
            {
                _owner->CastSpell(_owner, SPELL_GRAVITY_LAPSE_KNOCKBACK, true);
                _owner->CastSpell(_owner, SPELL_GRAVITY_LAPSE_AURA, true);
            }
            return true;
        }

    private:
        Player* _owner;
};

class spell_kaelthas_gravity_lapse : public SpellScriptLoader
{
    public:
        spell_kaelthas_gravity_lapse() : SpellScriptLoader("spell_kaelthas_gravity_lapse") { }

        class spell_kaelthas_gravity_lapse_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kaelthas_gravity_lapse_SpellScript);

            bool Load()
            {
                _currentSpellId = SPELL_GRAVITY_LAPSE_TELEPORT1;
                return true;
            }

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                if (_currentSpellId < SPELL_GRAVITY_LAPSE_TELEPORT1+25)
                    if (Player* target = GetHitPlayer())
                    {
                        GetCaster()->CastSpell(target, _currentSpellId++, true);
                        target->m_Events.AddEvent(new lapseTeleport(target), target->m_Events.CalculateTime(1));
                    }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kaelthas_gravity_lapse_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }

        private:
            uint32 _currentSpellId;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kaelthas_gravity_lapse_SpellScript();
        }
};

class spell_kaelthas_nether_beam : public SpellScriptLoader
{
    public:
        spell_kaelthas_nether_beam() : SpellScriptLoader("spell_kaelthas_nether_beam") { }

        class spell_kaelthas_nether_beam_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kaelthas_nether_beam_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                                   
                ThreatContainer::StorageType const & ThreatList = GetCaster()-> getThreatManager().getThreatList();
                std::list<Unit*> targetList;
                for (ThreatContainer::StorageType::const_iterator itr = ThreatList.begin(); itr != ThreatList.end(); ++itr)
                {
                    Unit* target = ObjectAccessor::GetUnit(*GetCaster(), (*itr)->getUnitGuid());
                    if (target && target->GetTypeId() == TYPEID_PLAYER)
                        targetList.push_back(target);
                }

                acore::Containers::RandomResizeList(targetList, 5);
                for (std::list<Unit*>::const_iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
                    GetCaster()->CastSpell(*itr, SPELL_NETHER_BEAM_DAMAGE, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kaelthas_nether_beam_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kaelthas_nether_beam_SpellScript();
        }
};

class spell_kaelthas_summon_nether_vapor : public SpellScriptLoader
{
    public:
        spell_kaelthas_summon_nether_vapor() : SpellScriptLoader("spell_kaelthas_summon_nether_vapor") { }

        class spell_kaelthas_summon_nether_vapor_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kaelthas_summon_nether_vapor_SpellScript);

            void HandleScriptEffect(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                for (uint32 i = 0; i < 5; ++i)
                    GetCaster()->SummonCreature(NPC_NETHER_VAPOR, GetCaster()->GetPositionX()+6*cos(i/5.0f*2*M_PI), GetCaster()->GetPositionY()+6*sin(i/5.0f*2*M_PI), GetCaster()->GetPositionZ()+7.0f+i, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 30000);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kaelthas_summon_nether_vapor_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kaelthas_summon_nether_vapor_SpellScript();
        }
};

void AddSC_boss_kaelthas()
{
    new boss_kaelthas();
    new spell_kaelthas_kael_phase_two();
    new spell_kaelthas_remote_toy();
    new spell_kaelthas_summon_weapons();
    new spell_kaelthas_resurrection();
    new spell_kaelthas_mind_control();
    new spell_kaelthas_burn();
    new spell_kaelthas_flame_strike();
    new spell_kaelthas_gravity_lapse();
    new spell_kaelthas_nether_beam();
    new spell_kaelthas_summon_nether_vapor();
}
