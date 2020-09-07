/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ahnkahet.h"
#include "Containers.h"
#include "ObjectAccessor.h"
#include "SpellScript.h"
#include "TemporarySummon.h"

enum Yells
{
    TEXT_AGGRO          = 0,
    TEXT_SACRIFICE_1    = 1,
    TEXT_SACRIFICE_2    = 2,
    TEXT_SLAY           = 3,
    TEXT_DEATH          = 4,
    TEXT_PREACHING      = 5
};

enum Spells
{
    // VISUALS
    SPELL_PINK_SPHERE                       = 56075,
    SPELL_WHITE_SPHERE                      = 56102,
    SPELL_LIGHTNING_BOLTS                   = 56327,
    SPELL_ACTIVATE_INITIATE                 = 56868,
    SPELL_SACRIFICE_VISUAL                  = 56133,

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
    EVENT_JEDOGA_CYCLONE                    = 1,
    EVENT_JEDOGA_LIGHTNING_BOLT             = 2,
    EVENT_JEDOGA_THUNDERSHOCK               = 3,
    EVENT_JEDOGA_PREPARE_RITUAL             = 4,
    EVENT_JEDOGA_MOVE_DOWN                  = 5,
};

enum Creatures
{
    NPC_JEDOGA_CONTROLLER                   = 30181,
    NPC_INITIATE                            = 30114,
};

enum Misc
{
    MAX_COMBAT_INITIATES                    = 25,
};

enum SummonGroups
{
    SUMMON_GROUP_OUT_OF_COMBAT              = 0,
};

enum Points
{
    POINT_DOWN                              = 1,
    POINT_UP                                = 2,
    POINT_UP_START                          = 3,
    POINT_RITUAL                            = 4,
    POINT_INITIAL                           = 5,
};

enum Phases
{
    PHASE_NORMAL                            = 0x01,
    PHASE_RITUAL                            = 0x02,
};

enum Actions
{
    ACTION_ACTIVATE                         = 1,
};

const Position JedogaPosition[3] =
{
    { 372.330994f, -705.278015f, -2.459692f,  5.628908f },      // Up
    { 372.330994f, -705.278015f, -16.179716f, 5.628908f },      // Down
    { 373.48f, -706.00f, -16.18f, 0.0f }                        // Jedoga visual trigger used for ritual
};

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

class boss_jedoga_shadowseeker : public CreatureScript
{
public:
    boss_jedoga_shadowseeker() : CreatureScript("boss_jedoga_shadowseeker") { }

    struct boss_jedoga_shadowseekerAI : public BossAI
    {
        boss_jedoga_shadowseekerAI(Creature* pCreature) : BossAI(pCreature, DATA_JEDOGA_SHADOWSEEKER_EVENT), combatSummonsSummoned(false), volunteerWork(true)
        {
        }

        // Disabled events
        void JustSummoned(Creature* /*summon*/) override {}
        void MoveInLineOfSight(Unit* /*who*/) override {}

        void SummonedCreatureDies(Creature* summon, Unit* killer) override
        {
            if (summon->GetEntry() == NPC_INITIATE)
            {
                if (choosenInitiate_GUID && summon->GetGUID() == choosenInitiate_GUID)
                {
                    if (killer != me && killer->GetGUID() != choosenInitiate_GUID)
                    {
                        volunteerWork = false;
                    }
                    else
                    {
                        DoCastSelf(SPELL_GIFT_OF_THE_HERALD, true);
                    }
                    events.ScheduleEvent(EVENT_JEDOGA_MOVE_DOWN, 1000, 0, PHASE_RITUAL);
                }
                else if (!oocSummons.empty() && instance->GetBossState(DATA_JEDOGA_SHADOWSEEKER) != IN_PROGRESS)
                {
                    std::list<uint64>::iterator itr = std::find(oocSummons.begin(), oocSummons.end(), summon->GetGUID());
                    if (itr != oocSummons.end())
                    {
                        oocSummons.erase(itr);
                        if (oocSummons.empty())
                        {
                            me->GetMotionMaster()->MoveIdle();
                            me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1]);
                        }
                    }
                }
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellSchoolMask /*school*/) override
        {
            if (me->HealthBelowPctDamaged(55, damage) && events.IsInPhase(PHASE_NORMAL))
            {
                SetCombatMovement(false);
                me->SetReactState(REACT_PASSIVE);
                me->InterruptNonMeleeSpells(false);
                me->AttackStop();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);

                events.Reset();
                events.SetPhase(PHASE_RITUAL);
                events.ScheduleEvent(EVENT_JEDOGA_PREPARE_RITUAL, 1000, 0, PHASE_RITUAL);
            }
        }

        void Reset() override
        {
            instance->SetData(DATA_JEDOGA_ACHIEVEMENT, true);
            me->SetReactState(REACT_PASSIVE);

            _Reset();
            events.SetPhase(PHASE_NORMAL);
            events.RescheduleEvent(EVENT_JEDOGA_CYCLONE, 3000, 0, PHASE_NORMAL);
            events.RescheduleEvent(EVENT_JEDOGA_LIGHTNING_BOLT, 7000, 0, PHASE_NORMAL);
            events.RescheduleEvent(EVENT_JEDOGA_THUNDERSHOCK, 12000, 0, PHASE_NORMAL);
            //events.RescheduleEvent(EVENT_JEDOGA_MOVE_UP, urand(20000, 25000), 0, PHASE_NORMAL);

            if (!oocSummons.empty())
            {
                for (uint64 const guid : oocSummons)
                {
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, guid))
                    {
                        summon->DespawnOrUnsummon();
                    }
                }
                oocSummons.clear();
            }

            std::list<TempSummon*> tempOOCSummons;
            me->SummonCreatureGroup(SUMMON_GROUP_OUT_OF_COMBAT, &tempOOCSummons);
            if (!tempOOCSummons.empty())
            {
                for (TempSummon const* summon : tempOOCSummons)
                {
                    if (summon)
                    {
                        oocSummons.push_back(summon->GetGUID());
                    }
                }
            }

            choosenInitiate_GUID = 0;
            volunteerWork = true;
            combatSummonsSummoned = false;

            me->SetDisableGravity(true);
            me->GetMotionMaster()->MovePoint(0, JedogaPosition[0]);
            DoCastSelf(SPELL_PINK_SPHERE, true);
            DoCastSelf(SPELL_LIGHTNING_BOLTS, true);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            Talk(TEXT_AGGRO);
        }

        void KilledUnit(Unit* who) override
        {
            if (!who || who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(TEXT_SLAY);
        }

        void JustDied(Unit* /*Killer*/) override
        {
            _JustDied();
            Talk(TEXT_DEATH);
        }
        
        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type != POINT_MOTION_TYPE) 
                return;

            switch (pointId)
            {
            case POINT_DOWN:
            {
                events.SetPhase(PHASE_NORMAL);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetReactState(REACT_AGGRESSIVE);
                me->RemoveAurasDueToSpell(SPELL_PINK_SPHERE);
                me->RemoveAurasDueToSpell(SPELL_LIGHTNING_BOLTS);
                SetCombatMovement(true);

                me->SetInCombatWithZone();
                me->SetDisableGravity(false);
                if (!combatSummonsSummoned)
                {
                    combatSummonsSummoned = true;
                    summons.DespawnEntry(NPC_INITIATE);
                    for (uint8 i = 0; i < MAX_COMBAT_INITIATES; ++i)
                    {
                        if (TempSummon* summon = me->SummonCreature(NPC_INITIATE, VolunteerSpotPositions[i][0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                        {
                            summon->GetMotionMaster()->MovePoint(0, VolunteerSpotPositions[i][1]);
                            summons.Summon(summon);
                        }
                    }
                }

                if (Unit* victim = me->GetVictim())
                {
                    me->StopMoving();
                    AttackStart(victim);
                }
            }break;
            case POINT_UP:
            {
                if (!summons.empty())
                {
                    uint32 const initiateGUID = acore::Containers::SelectRandomContainerElement(summons);
                    if (Creature* initiate = ObjectAccessor::GetCreature(*me, initiateGUID))
                    {
                        Talk(TEXT_SACRIFICE_1);
                        choosenInitiate_GUID = initiate->GetGUID();
                        initiate->AI()->DoAction(ACTION_ACTIVATE);

                        if (Creature* ritualTrigger = me->SummonCreature(NPC_JEDOGA_CONTROLLER, JedogaPosition[2]))
                        {
                            ritualTrigger->CastSpell(ritualTrigger, SPELL_SACRIFICE_VISUAL, true);
                            summons.Summon(ritualTrigger);
                        }
                    }
                    // Something failed, let players continue but do not grant achievement
                    else
                    {
                        volunteerWork = false;
                        me->GetMotionMaster()->MoveIdle();
                        me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1]);
                    }
                }
                break;
            }
            case POINT_RITUAL:
            {
                me->GetMotionMaster()->Clear(true);
                me->SetFacingTo(5.66f);
                me->GetMotionMaster()->MovePoint(POINT_UP, JedogaPosition[0]);
                break;
            }
            }                
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 const eventId = events.GetEvent())
            {
                switch (eventId)
                {

                // Normal phase

                case EVENT_JEDOGA_CYCLONE:
                {
                    me->CastSpell(me, IsHeroic() ? SPELL_CYCLONE_STRIKE_H : SPELL_CYCLONE_STRIKE, false);
                    events.RepeatEvent(urand(10000, 14000));
                    break;
                }
                case EVENT_JEDOGA_LIGHTNING_BOLT:
                {
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        me->CastSpell(pTarget, IsHeroic() ? SPELL_LIGHTNING_BOLT_H : SPELL_LIGHTNING_BOLT, false);

                    events.RepeatEvent(urand(11000, 15000));
                    break;
                }
                case EVENT_JEDOGA_THUNDERSHOCK:
                {
                    if (Unit* pTarget = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                        me->CastSpell(pTarget, IsHeroic() ? SPELL_THUNDERSHOCK_H : SPELL_THUNDERSHOCK, false);

                    events.RepeatEvent(urand(16000, 22000));
                    break;
                }

                // Ritual
                case EVENT_JEDOGA_PREPARE_RITUAL:
                {
                    me->GetMotionMaster()->Clear(true);
                    me->GetMotionMaster()->MovePoint(POINT_RITUAL, JedogaPosition[1]);
                    events.PopEvent();
                    break;
                }
                case EVENT_JEDOGA_MOVE_DOWN:
                {
                    Talk(TEXT_SACRIFICE_2);
                    summons.DespawnEntry(NPC_JEDOGA_CONTROLLER);
                    me->GetMotionMaster()->MoveIdle();
                    me->GetMotionMaster()->MovePoint(POINT_DOWN, JedogaPosition[1]);
                    events.PopEvent();
                    break;
                }
                }
            }

            DoMeleeAttackIfReady();
        }
    private:
        std::list<uint64> oocSummons;
        uint64 choosenInitiate_GUID;

        bool combatSummonsSummoned;
        bool volunteerWork; // true = success, false = failed
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new boss_jedoga_shadowseekerAI(creature);
    }
};

class npc_jedoga_initiand : public CreatureScript
{
public:
    npc_jedoga_initiand() : CreatureScript("npc_jedoga_initiand") { }

    struct npc_jedoga_initiandAI : public ScriptedAI
    {
        npc_jedoga_initiandAI(Creature* c) : ScriptedAI(c), pInstance(c->GetInstanceScript()), activationTimer(0)
        {
        }

        void AttackStart(Unit* who)
        {
            if (!activationTimer)
            {
                ScriptedAI::AttackStart(who);
            }
        }

        void MoveInLineOfSight(Unit *who) 
        {
            if (!activationTimer)
            {
                ScriptedAI::MoveInLineOfSight(who);
            }
        }

        void Reset()
        {
            activationTimer = 0;

            if (!pInstance)
            {
                return;
            }

            if (pInstance->GetData(DATA_JEDOGA_SHADOWSEEKER_EVENT) != IN_PROGRESS)
            {
                me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, false);
                me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_MAGIC, false);
                me->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
            }
            else
            {
                if (Creature* jedoga = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_JEDOGA_SHADOWSEEKER)))
                {
                    me->SetFacingToObject(jedoga);
                }
                me->SendMovementFlagUpdate();
                me->CastSpell(me, SPELL_WHITE_SPHERE, false);
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE + UNIT_FLAG_NON_ATTACKABLE);
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_ACTIVATE)
            {
                activationTimer = 1500;
                DoCastSelf(SPELL_ACTIVATE_INITIATE, true);
            }
        }

        void MovementInform(uint32 Type, uint32 PointId)
        {
            if (Type == POINT_MOTION_TYPE && PointId == POINT_RITUAL)
            {
                Unit::Kill(me, me);
                me->DespawnOrUnsummon(5000);
                //if (Creature* boss = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_JEDOGA_SHADOWSEEKER)))
                    //boss->AI()->DoAction(ACTION_HERALD);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (activationTimer)
            {
                activationTimer -= diff;
                if (activationTimer <= 0)
                {
                    me->CombatStop();
                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    me->RemoveAurasDueToSpell(SPELL_WHITE_SPHERE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE);
                    me->SetWalk(true);

                    float const distance = me->GetDistance(JedogaPosition[1]);

                    // TODO: remove this
                    if (distance < 9.0f)
                    {
                        me->SetSpeed(MOVE_WALK, 0.5f, true);
                    }
                    else if (distance < 15.0f)
                    {
                        me->SetSpeed(MOVE_WALK, 0.75f, true);
                    }
                    else if (distance < 20.0f)
                    {
                        me->SetSpeed(MOVE_WALK, 1.0f, true);
                    }

                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MovePoint(POINT_RITUAL, 373.48f, -706.00f, -16.18f);

                    activationTimer = 10000000;
                }

                return;
            }

            if (!UpdateVictim())
            {
                return;
            }

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* pInstance;
        int32 activationTimer;
    };

    CreatureAI *GetAI(Creature *creature) const
    {
        return new npc_jedoga_initiandAI(creature);
    }
};

// 56328 - Random Lightning Visual Effect
class spell_random_lightning_visual_effect : public SpellScriptLoader
{
    public:
        spell_random_lightning_visual_effect() : SpellScriptLoader("spell_random_lightning_visual_effect") { }

    class spell_random_lightning_visual_effect_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_random_lightning_visual_effect_SpellScript);

        void ModDestHeight(SpellDestination& dest)
        {
            Position const offset = { frand(-15.0f, 15.0f), frand(-15.0f, 15.0f), -19.0f, 0.0f };
            dest.RelocateOffset(offset);
        }

        void Register() override
        {
            OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_random_lightning_visual_effect_SpellScript::ModDestHeight, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_random_lightning_visual_effect_SpellScript();
    }
};

void AddSC_boss_jedoga_shadowseeker()
{
    new boss_jedoga_shadowseeker();
    new npc_jedoga_initiand();

    // Spells
    new spell_random_lightning_visual_effect();
}
