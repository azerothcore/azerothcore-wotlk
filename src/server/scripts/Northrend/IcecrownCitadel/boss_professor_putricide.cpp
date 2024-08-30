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
#include "GridNotifiers.h"
#include "Group.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "icecrown_citadel.h"

enum ScriptTexts
{
    // Festergut
    SAY_FESTERGUT_GASEOUS_BLIGHT    = 0,
    SAY_FESTERGUT_DEATH             = 1,

    // Rotface
    SAY_ROTFACE_OOZE_FLOOD          = 2,
    SAY_ROTFACE_DEATH               = 3,

    // Professor Putricide
    SAY_AGGRO                       = 4,
    EMOTE_UNSTABLE_EXPERIMENT       = 5,
    SAY_PHASE_TRANSITION_HEROIC     = 6,
    SAY_TRANSFORM_1                 = 7,
    SAY_TRANSFORM_2                 = 8,    // always used for phase2 change, DO NOT GROUP WITH SAY_TRANSFORM_1
    EMOTE_MALLEABLE_GOO             = 9,
    EMOTE_CHOKING_GAS_BOMB          = 10,
    SAY_KILL                        = 11,
    SAY_BERSERK                     = 12,
    SAY_DEATH                       = 13,
};

enum Spells
{
    // Festergut
    SPELL_RELEASE_GAS_VISUAL                = 69125,
    SPELL_GASEOUS_BLIGHT_LARGE              = 69157,
    SPELL_GASEOUS_BLIGHT_MEDIUM             = 69162,
    SPELL_GASEOUS_BLIGHT_SMALL              = 69164,

    // Rotface - not needed here

    // Professor Putricide
    SPELL_SLIME_PUDDLE_TRIGGER              = 70341,
    SPELL_MALLEABLE_GOO_BALCONY             = 72296,
    SPELL_MALLEABLE_GOO                     = 70852,
    SPELL_UNSTABLE_EXPERIMENT               = 70351,
    SPELL_TEAR_GAS                          = 71617,    // phase transition
    SPELL_TEAR_GAS_CREATURE                 = 71618,
    SPELL_TEAR_GAS_CANCEL                   = 71620,
    SPELL_TEAR_GAS_PERIODIC_TRIGGER         = 73170,
    SPELL_CREATE_CONCOCTION                 = 71621,
    SPELL_GUZZLE_POTIONS                    = 71893,
    SPELL_OOZE_TANK_PROTECTION              = 71770,    // protects the tank
    SPELL_CHOKING_GAS_BOMB                  = 71255,
    SPELL_OOZE_VARIABLE                     = 74118,
    SPELL_GAS_VARIABLE                      = 74119,
    SPELL_UNBOUND_PLAGUE                    = 70911,
    SPELL_UNBOUND_PLAGUE_SEARCHER           = 70917,
    SPELL_PLAGUE_SICKNESS                   = 70953,
    SPELL_UNBOUND_PLAGUE_PROTECTION         = 70955,
    SPELL_MUTATED_PLAGUE                    = 72451,
    SPELL_MUTATED_PLAGUE_CLEAR              = 72618,

    // Slime Puddle
    SPELL_GROW_STACKER                      = 70345,
    SPELL_GROW                              = 70347,
    SPELL_SLIME_PUDDLE_AURA                 = 70343,

    // Gas Cloud
    SPELL_GASEOUS_BLOAT_PROC                = 70215,
    SPELL_GASEOUS_BLOAT                     = 70672,
    SPELL_GASEOUS_BLOAT_PROTECTION          = 70812,
    SPELL_EXPUNGED_GAS                      = 70701,

    // Volatile Ooze
    SPELL_OOZE_ERUPTION                     = 70492,
    SPELL_VOLATILE_OOZE_ADHESIVE            = 70447,
    SPELL_OOZE_ERUPTION_SEARCH_PERIODIC     = 70457,
    SPELL_VOLATILE_OOZE_PROTECTION          = 70530,

    // Choking Gas Bomb
    SPELL_CHOKING_GAS_BOMB_PERIODIC         = 71259,
    SPELL_CHOKING_GAS_EXPLOSION_TRIGGER     = 71280,

    // Mutated Abomination vehicle
    SPELL_ABOMINATION_VEHICLE_POWER_DRAIN   = 70385,
    SPELL_MUTATED_TRANSFORMATION            = 70311,
    SPELL_MUTATED_TRANSFORMATION_DAMAGE     = 70405,
    SPELL_MUTATED_TRANSFORMATION_NAME       = 72401,

    // Unholy Infusion
    SPELL_UNHOLY_INFUSION                   = 71516,
    SPELL_UNHOLY_INFUSION_CREDIT            = 71518,
};

enum PutricideData
{
    DATA_EXPERIMENT_STAGE = 1,
    DATA_PHASE = 2,
    DATA_ABOMINATION = 3,
};

enum Events
{
    EVENT_NONE,
    EVENT_BERSERK,
    EVENT_SLIME_PUDDLE,
    EVENT_UNSTABLE_EXPERIMENT,
    EVENT_GO_TO_TABLE,
    EVENT_TABLE_DRINK_STUFF,
    EVENT_PHASE_TRANSITION,
    EVENT_RESUME_ATTACK,
    EVENT_UNBOUND_PLAGUE,
    EVENT_MALLEABLE_GOO,
    EVENT_CHOKING_GAS_BOMB,
};

#define EVENT_GROUP_ABILITIES 1

enum Points
{
    POINT_FESTERGUT = 366260,
    POINT_ROTFACE   = 366270,
    POINT_TABLE     = 366780,
    POINT_TABLE_COMBAT = 366781,
};

Position const festergutWatchPos = {4324.820f, 3166.03f, 389.3831f, 3.316126f}; //emote 432 (release gas)
Position const rotfaceWatchPos   = {4390.371f, 3164.50f, 389.3890f, 5.497787f}; //emote 432 (release ooze)
Position const tablePos          = {4356.190f, 3262.90f, 389.4820f, 1.483530f};

class AbominationDespawner
{
public:
    explicit AbominationDespawner(Unit* owner) : _owner(owner) { }

    bool operator()(ObjectGuid guid)
    {
        if (Unit* summon = ObjectAccessor::GetUnit(*_owner, guid))
        {
            if (summon->GetEntry() == NPC_MUTATED_ABOMINATION_10 || summon->GetEntry() == NPC_MUTATED_ABOMINATION_25)
            {
                if (Vehicle* veh = summon->GetVehicleKit())
                    veh->RemoveAllPassengers(); // also despawns the vehicle

                // Found unit is Mutated Abomination, remove it
                return true;
            }

            // Found unit is not Mutated Abomintaion, leave it
            return false;
        }

        // No unit found, remove from SummonList
        return true;
    }

private:
    Unit* _owner;
};

class UnboundPlagueTargetSelector
{
public:
    UnboundPlagueTargetSelector(Creature* source) : _source(source) { }

    bool operator()(WorldObject* object) const
    {
        if (!object)
            return false;
        if (Player* p = object->ToPlayer())
        {
            if (p == _source->GetVictim() || p->GetExactDist(_source) >= 45.0f)
                return false;

            return true;
        }
        return false;
    }
private:
    Creature const* _source;
};

// xinef: malleable goo selector, check for target validity
struct MalleableGooSelector
{
public:
    MalleableGooSelector(Unit const* unit) : me(unit) { }

    bool operator()(Unit const* target) const
    {
        if (!me || !target || target->GetTypeId() != TYPEID_PLAYER)
            return false;

        if (me->IsWithinCombatRange(target, 7.0f))
            return false;

        return me->IsValidAttackTarget(target);
    }
private:
    Unit const* me;
};

class boss_professor_putricide : public CreatureScript
{
public:
    boss_professor_putricide() : CreatureScript("boss_professor_putricide") { }

    struct boss_professor_putricideAI : public BossAI
    {
        boss_professor_putricideAI(Creature* creature) : BossAI(creature, DATA_PROFESSOR_PUTRICIDE)
        {
            bCallEvade = false;
            bEnteredCombat = false;
        }

        uint16 sayFestergutDeathTimer;
        uint16 sayRotfaceDeathTimer;
        bool bCallEvade;
        uint8 _experimentState;
        uint8 _phase;
        bool bChangePhase;
        bool bEnteredCombat; // needed for failing an attempt in JustReachedHome()

        void Reset() override
        {
            sayFestergutDeathTimer = 0;
            sayRotfaceDeathTimer = 0;
            _experimentState = 0;
            _phase = 1;
            bChangePhase = false;
            _Reset();
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetStandState(UNIT_STAND_STATE_STAND);

            if (instance->GetBossState(DATA_ROTFACE) == DONE && instance->GetBossState(DATA_FESTERGUT) == DONE)
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_EXPERIMENT_STAGE:
                    return (uint32)_experimentState;
                case DATA_PHASE:
                    return (uint32)_phase;
                case DATA_ABOMINATION:
                    return (uint32)(const_cast<SummonList*>(&summons)->HasEntry(NPC_MUTATED_ABOMINATION_10) || const_cast<SummonList*>(&summons)->HasEntry(NPC_MUTATED_ABOMINATION_25));
            }

            return 0;
        }

        void SetData(uint32 id, uint32 data) override
        {
            if (id == DATA_EXPERIMENT_STAGE)
                _experimentState = (data ? 1 : 0);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return me->IsVisible() && target->GetPositionZ() > 388.0f && target->GetPositionZ() < 410.0f && target->GetPositionY() > 3157.1f && target->GetExactDist2dSq(4356.0f, 3211.0f) < 80.0f * 80.0f;
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                BossAI::MoveInLineOfSight(who);
        }

        void JustEngagedWith(Unit* who) override
        {
            Position homePos = me->GetHomePosition();
            if (!instance->CheckRequiredBosses(DATA_PROFESSOR_PUTRICIDE, who->ToPlayer()) || me->GetExactDist2d(&homePos) > 10.0f || !me->IsVisible()) // check home position because during festergut/rotface fight, trigger missile after their death can trigger putricide combat
            {
                me->CombatStop();
                me->RemoveAllAuras();
                return;
            }

            bEnteredCombat = true;
            me->CastSpell(me, SPELL_OOZE_TANK_PROTECTION, true);
            events.Reset();
            events.ScheduleEvent(EVENT_BERSERK, 10min);
            events.ScheduleEvent(EVENT_SLIME_PUDDLE, 10s, EVENT_GROUP_ABILITIES);
            events.ScheduleEvent(EVENT_UNSTABLE_EXPERIMENT, 30s, 35s, EVENT_GROUP_ABILITIES);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_UNBOUND_PLAGUE, 20s, EVENT_GROUP_ABILITIES);

            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAS_VARIABLE);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_OOZE_VARIABLE);

            me->setActive(true);
            Talk(SAY_AGGRO);
            DoZoneInCombat(me);
            instance->SetBossState(DATA_PROFESSOR_PUTRICIDE, IN_PROGRESS);
            instance->SetData(DATA_NAUSEA_ACHIEVEMENT, uint32(true));
        }

        void JustReachedHome() override
        {
            _JustReachedHome();
            if (bEnteredCombat)
            {
                bEnteredCombat = false;
                instance->SetBossState(DATA_PROFESSOR_PUTRICIDE, FAIL);
            }

            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAS_VARIABLE);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_OOZE_VARIABLE);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
                Talk(SAY_KILL);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            Talk(SAY_DEATH);

            if (Is25ManRaid() && me->HasAura(SPELL_SHADOWS_FATE))
                DoCastAOE(SPELL_UNHOLY_INFUSION_CREDIT, true); // ReqTargetAura in dbc

            me->CastSpell((Unit*)nullptr, SPELL_MUTATED_PLAGUE_CLEAR, true);
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() != 38308 && summon->GetEntry() != 38309 && (!me->IsInCombat() || me->IsInEvadeMode()))
            {
                summon->DespawnOrUnsummon(1);
                return;
            }

            summons.Summon(summon);

            switch (summon->GetEntry())
            {
                case NPC_GROWING_OOZE_PUDDLE:
                    // blizzard casts this spell 7 times initially (confirmed in sniff)
                    for (uint8 i = 0; i < 7; ++i)
                        summon->CastSpell(summon, SPELL_GROW, true);
                    return;
                case NPC_GAS_CLOUD:
                    // no possible aura seen in sniff adding the aurastate
                    summon->ModifyAuraState(AURA_STATE_UNKNOWN22, true);
                    summon->CastSpell(summon, SPELL_GASEOUS_BLOAT_PROC, true);
                    summon->SetReactState(REACT_PASSIVE);
                    break;
                case NPC_VOLATILE_OOZE:
                    // no possible aura seen in sniff adding the aurastate
                    summon->ModifyAuraState(AURA_STATE_UNKNOWN19, true);
                    summon->CastSpell(summon, SPELL_OOZE_ERUPTION_SEARCH_PERIODIC, true);
                    summon->SetReactState(REACT_PASSIVE);
                    break;
                case NPC_CHOKING_GAS_BOMB:
                    summon->CastSpell(summon, SPELL_CHOKING_GAS_BOMB_PERIODIC, true);
                    summon->CastSpell(summon, SPELL_CHOKING_GAS_EXPLOSION_TRIGGER, true);
                    return;
                case NPC_MUTATED_ABOMINATION_10:
                case NPC_MUTATED_ABOMINATION_25:
                    return;
            }

            if (me->IsInCombat())
                summon->SetInCombatWithZone();
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType  /*damagetype*/, SpellSchoolMask  /*damageSchoolMask*/) override
        {
            if (bChangePhase)
                return;

            switch (_phase)
            {
                case 1:
                    if (HealthAbovePct(80))
                        return;
                    me->SetReactState(REACT_PASSIVE);
                    bChangePhase = true;
                    break;
                case 2:
                    if (HealthAbovePct(35))
                        return;
                    me->SetReactState(REACT_PASSIVE);
                    bChangePhase = true;
                    break;
                default:
                    break;
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;
            switch (id)
            {
                case POINT_FESTERGUT:
                    if (Creature* c = instance->instance->GetCreature(instance->GetGuidData(DATA_FESTERGUT)))
                    {
                        if (c->IsInCombat())
                        {
                            instance->SetBossState(DATA_FESTERGUT, IN_PROGRESS);
                            me->SetFacingTo(festergutWatchPos.GetOrientation());
                            DoAction(ACTION_FESTERGUT_GAS);
                            c->CastSpell(c, SPELL_GASEOUS_BLIGHT_LARGE, true, nullptr, nullptr, c->GetGUID());
                        }
                        else
                        {
                            bCallEvade = true;
                        }
                    }
                    break;
                case POINT_ROTFACE:
                    if (Creature* c = instance->instance->GetCreature(instance->GetGuidData(DATA_ROTFACE)))
                    {
                        if (c->IsInCombat())
                        {
                            instance->SetBossState(DATA_ROTFACE, IN_PROGRESS);
                            me->SetFacingTo(rotfaceWatchPos.GetOrientation());
                        }
                        else
                        {
                            bCallEvade = true;
                        }
                    }
                    break;
                case POINT_TABLE:
                    me->SetFacingTo(tablePos.GetOrientation());
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
                    break;
                case POINT_TABLE_COMBAT:
                    me->SetFacingTo(tablePos.GetOrientation());
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    events.ScheduleEvent(EVENT_TABLE_DRINK_STUFF, IsHeroic() ? 25s : 0ms);
                    break;
            }
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_FESTERGUT_COMBAT:
                    me->GetMotionMaster()->MoveCharge(festergutWatchPos.GetPositionX(), festergutWatchPos.GetPositionY(), festergutWatchPos.GetPositionZ(), 15.0f, POINT_FESTERGUT);
                    break;
                case ACTION_FESTERGUT_DEATH:
                    sayFestergutDeathTimer = 4000;
                    break;
                case ACTION_FESTERGUT_GAS:
                    Talk(SAY_FESTERGUT_GASEOUS_BLIGHT);
                    DoCast(me, SPELL_RELEASE_GAS_VISUAL, true);
                    break;
                case ACTION_ROTFACE_COMBAT:
                    me->GetMotionMaster()->MoveCharge(rotfaceWatchPos.GetPositionX(), rotfaceWatchPos.GetPositionY(), rotfaceWatchPos.GetPositionZ(), 15.0f, POINT_ROTFACE);
                    break;
                case ACTION_ROTFACE_DEATH:
                    sayRotfaceDeathTimer = 4500;
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (sayFestergutDeathTimer)
            {
                if (sayFestergutDeathTimer <= diff)
                {
                    sayFestergutDeathTimer = 0;
                    Talk(SAY_FESTERGUT_DEATH);
                    EnterEvadeMode(EVADE_REASON_OTHER);
                }
                else
                    sayFestergutDeathTimer -= diff;
            }
            else if (sayRotfaceDeathTimer)
            {
                if (sayRotfaceDeathTimer <= diff)
                {
                    sayRotfaceDeathTimer = 0;
                    Talk(SAY_ROTFACE_DEATH);
                    EnterEvadeMode(EVADE_REASON_OTHER);
                }
                else
                    sayRotfaceDeathTimer -= diff;
            }
            else if (bCallEvade)
            {
                bCallEvade = false;
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (bChangePhase)
            {
                ChangePhase();
                bChangePhase = false;
                return;
            }

            switch (events.ExecuteEvent())
            {
                case EVENT_BERSERK:
                    Talk(SAY_BERSERK);
                    DoCast(me, SPELL_BERSERK2);
                    break;
                case EVENT_SLIME_PUDDLE:
                    {
                        std::list<Unit*> targets;
                        SelectTargetList(targets, 2, SelectTargetMethod::Random, 0, 0.0f, true);
                        if (!targets.empty())
                            for (std::list<Unit*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                                me->CastSpell(*itr, SPELL_SLIME_PUDDLE_TRIGGER, true);
                        events.ScheduleEvent(EVENT_SLIME_PUDDLE, 35s, EVENT_GROUP_ABILITIES);
                    }
                    break;
                case EVENT_UNSTABLE_EXPERIMENT:
                    Talk(EMOTE_UNSTABLE_EXPERIMENT);
                    me->CastSpell(me, SPELL_UNSTABLE_EXPERIMENT, false);
                    events.ScheduleEvent(EVENT_UNSTABLE_EXPERIMENT, 35s, 40s, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_GO_TO_TABLE:
                    me->CastSpell(me, SPELL_TEAR_GAS_PERIODIC_TRIGGER, true);
                    me->GetMotionMaster()->MoveCharge(tablePos.GetPositionX(), tablePos.GetPositionY(), tablePos.GetPositionZ(), 15.0f, POINT_TABLE_COMBAT);
                    break;
                case EVENT_TABLE_DRINK_STUFF:
                    switch (_phase)
                    {
                        case 2:
                            {
                                SpellInfo const* spell = sSpellMgr->GetSpellInfo(SPELL_CREATE_CONCOCTION);
                                me->CastSpell(me, SPELL_CREATE_CONCOCTION, false);
                                events.ScheduleEvent(EVENT_PHASE_TRANSITION, sSpellMgr->GetSpellForDifficultyFromSpell(spell, me)->CalcCastTime() + 2250);
                                break;
                            }
                        case 3:
                            {
                                SpellInfo const* spell = sSpellMgr->GetSpellInfo(SPELL_GUZZLE_POTIONS);
                                me->CastSpell(me, SPELL_GUZZLE_POTIONS, false);
                                events.ScheduleEvent(EVENT_PHASE_TRANSITION, sSpellMgr->GetSpellForDifficultyFromSpell(spell, me)->CalcCastTime() + 2250);
                                break;
                            }
                        default:
                            break;
                    }
                    break;
                case EVENT_PHASE_TRANSITION:
                    {
                        switch (_phase)
                        {
                            case 2:
                                if (Creature* face = me->FindNearestCreature(NPC_TEAR_GAS_TARGET_STALKER, 50.0f))
                                    me->SetFacingToObject(face);
                                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                Talk(SAY_TRANSFORM_1);
                                events.ScheduleEvent(EVENT_RESUME_ATTACK, 5500ms);
                                break;
                            case 3:
                                if (Creature* face = me->FindNearestCreature(NPC_TEAR_GAS_TARGET_STALKER, 50.0f))
                                    me->SetFacingToObject(face);
                                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                Talk(SAY_TRANSFORM_2);
                                events.ScheduleEvent(EVENT_RESUME_ATTACK, 8500ms);
                                break;
                            default:
                                break;
                        }
                    }
                    break;
                case EVENT_RESUME_ATTACK:
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    AttackStart(me->GetVictim());
                    // remove Tear Gas
                    me->RemoveAurasDueToSpell(SPELL_TEAR_GAS_PERIODIC_TRIGGER);
                    DoCastAOE(SPELL_TEAR_GAS_CANCEL);
                    if (_phase == 3)
                        summons.DespawnIf(AbominationDespawner(me));
                    instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_GAS_VARIABLE);
                    instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_OOZE_VARIABLE);
                    break;
                case EVENT_UNBOUND_PLAGUE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, UnboundPlagueTargetSelector(me)))
                    {
                        me->CastSpell(target, SPELL_UNBOUND_PLAGUE, false);
                        me->CastSpell(target, SPELL_UNBOUND_PLAGUE_SEARCHER, false);
                        events.ScheduleEvent(EVENT_UNBOUND_PLAGUE, 90s, EVENT_GROUP_ABILITIES);
                    }
                    else
                        events.ScheduleEvent(EVENT_UNBOUND_PLAGUE, 3500ms, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_MALLEABLE_GOO:
                    if (Is25ManRaid())
                    {
                        std::list<Unit*> targets;
                        SelectTargetList(targets, (IsHeroic() ? 3 : 2), SelectTargetMethod::Random, 0, MalleableGooSelector(me));

                        if (!targets.empty())
                        {
                            Talk(EMOTE_MALLEABLE_GOO);
                            for (std::list<Unit*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                                me->CastSpell(*itr, SPELL_MALLEABLE_GOO, true);
                        }
                    }
                    else
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, MalleableGooSelector(me)))
                        {
                            Talk(EMOTE_MALLEABLE_GOO);
                            me->CastSpell(target, SPELL_MALLEABLE_GOO, true);
                        }
                    }
                    events.ScheduleEvent(EVENT_MALLEABLE_GOO, 25s, 30s, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_CHOKING_GAS_BOMB:
                    Talk(EMOTE_CHOKING_GAS_BOMB);
                    me->CastSpell(me, SPELL_CHOKING_GAS_BOMB, false);
                    events.ScheduleEvent(EVENT_CHOKING_GAS_BOMB, 35s, 40s, EVENT_GROUP_ABILITIES);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            Position p = me->GetHomePosition();
            if (!me->IsInCombat() && me->GetExactDist2d(&p) > 10.0f)
                me->GetMotionMaster()->MoveCharge(tablePos.GetPositionX(), tablePos.GetPositionY(), tablePos.GetPositionZ(), 15.0f, POINT_TABLE);
            BossAI::EnterEvadeMode(why);
        }

        void ChangePhase()
        {
            uint32 heroicDelay = (IsHeroic() ? 25000 : 0);
            events.DelayEvents(24000 + heroicDelay, EVENT_GROUP_ABILITIES);
            me->AttackStop();
            if (!IsHeroic())
            {
                me->CastSpell(me, SPELL_TEAR_GAS, false);
                events.ScheduleEvent(EVENT_GO_TO_TABLE, 2500ms);
            }
            else
            {
                Talk(SAY_PHASE_TRANSITION_HEROIC);
                DoCast(me, SPELL_UNSTABLE_EXPERIMENT, true);
                DoCast(me, SPELL_UNSTABLE_EXPERIMENT, true);
                // cast variables
                if (Is25ManRaid())
                {
                    std::list<Unit*> targetList;

                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            if (!p->IsGameMaster())
                                targetList.push_back(p);

                    std::size_t half = targetList.size() / 2;
                    // half gets ooze variable
                    while (half < targetList.size())
                    {
                        std::list<Unit*>::iterator itr = targetList.begin();
                        advance(itr, urand(0, targetList.size() - 1));
                        (*itr)->CastSpell(*itr, SPELL_OOZE_VARIABLE, true);
                        targetList.erase(itr);
                    }
                    // and half gets gas
                    for (std::list<Unit*>::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
                        (*itr)->CastSpell(*itr, SPELL_GAS_VARIABLE, true);
                }

                me->GetMotionMaster()->MoveCharge(tablePos.GetPositionX(), tablePos.GetPositionY(), tablePos.GetPositionZ(), 15.0f, POINT_TABLE_COMBAT);
            }

            switch (_phase)
            {
                case 1:
                    _phase = 2;
                    events.ScheduleEvent(EVENT_MALLEABLE_GOO, urand(25000, 28000) + heroicDelay, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_CHOKING_GAS_BOMB, urand(35000, 40000) + heroicDelay, EVENT_GROUP_ABILITIES);
                    break;
                case 2:
                    _phase = 3;
                    events.CancelEvent(EVENT_UNSTABLE_EXPERIMENT);
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<boss_professor_putricideAI>(creature);
    }
};

class npc_putricide_oozeAI : public ScriptedAI
{
public:
    npc_putricide_oozeAI(Creature* creature, uint32 hitTargetSpellId) : ScriptedAI(creature),
        _hitTargetSpellId(hitTargetSpellId), _newTargetSelectTimer(0)
    {
        me->SetReactState(REACT_PASSIVE);
    }

    ObjectGuid targetGUID;

    void SetGUID(ObjectGuid guid, int32 type) override
    {
        if (type == -1)
            targetGUID = guid;
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        if (InstanceScript* instance = me->GetInstanceScript())
            if (Creature* professor = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE)))
            {
                if (!professor->IsInCombat())
                    me->DespawnOrUnsummon(1);
                else
                    professor->AI()->JustSummoned(me);
            }
    }

    void SelectNewTarget()
    {
        targetGUID.Clear();
        me->InterruptNonMeleeSpells(true);
        me->AttackStop();
        me->GetMotionMaster()->Clear();
        me->StopMoving();
        _newTargetSelectTimer = 1000;
    }

    void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell) override
    {
        if (!_newTargetSelectTimer && spell->Id == sSpellMgr->GetSpellIdForDifficulty(_hitTargetSpellId, me))
            SelectNewTarget();
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
    {
        if (spell->Id == SPELL_TEAR_GAS_CREATURE)
            SelectNewTarget();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!_newTargetSelectTimer)
        {
            if ((!me->HasUnitState(UNIT_STATE_CASTING) && !me->GetVictim()) || !me->IsNonMeleeSpellCast(false, false, true, false, true))
                SelectNewTarget();
            else if (targetGUID)
            {
                Unit* target = ObjectAccessor::GetUnit(*me, targetGUID);
                if (me->GetVictim()->GetGUID() != targetGUID || !target || !me->IsValidAttackTarget(target) || target->HasUnitFlag2(UNIT_FLAG2_FEIGN_DEATH) || target->GetExactDist2dSq(4356.0f, 3211.0f) > 80.0f * 80.0f || target->GetPositionZ() < 380.0f || target->GetPositionZ() > 405.0f)
                    SelectNewTarget();
            }
        }

        DoMeleeAttackIfReady();

        if (!_newTargetSelectTimer)
            return;

        if (me->HasAura(SPELL_TEAR_GAS_CREATURE))
            return;

        if (_newTargetSelectTimer <= diff)
        {
            _newTargetSelectTimer = 0;
            CastMainSpell();
        }
        else
            _newTargetSelectTimer -= diff;
    }

    virtual void CastMainSpell() = 0;

private:
    uint32 _hitTargetSpellId;
    uint32 _newTargetSelectTimer;
};

class npc_volatile_ooze : public CreatureScript
{
public:
    npc_volatile_ooze() : CreatureScript("npc_volatile_ooze") { }

    struct npc_volatile_oozeAI : public npc_putricide_oozeAI
    {
        npc_volatile_oozeAI(Creature* creature) : npc_putricide_oozeAI(creature, SPELL_OOZE_ERUPTION)
        {
        }

        void CastMainSpell() override
        {
            me->CastSpell(me, SPELL_VOLATILE_OOZE_ADHESIVE, false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_volatile_oozeAI>(creature);
    }
};

class npc_gas_cloud : public CreatureScript
{
public:
    npc_gas_cloud() : CreatureScript("npc_gas_cloud") { }

    struct npc_gas_cloudAI : public npc_putricide_oozeAI
    {
        npc_gas_cloudAI(Creature* creature) : npc_putricide_oozeAI(creature, SPELL_EXPUNGED_GAS)
        {
            _newTargetSelectTimer = 0;
        }

        void CastMainSpell() override
        {
            me->CastCustomSpell(SPELL_GASEOUS_BLOAT, SPELLVALUE_AURA_STACK, 10, me, false);
        }

    private:
        uint32 _newTargetSelectTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gas_cloudAI>(creature);
    }
};

class spell_putricide_slime_puddle : public SpellScript
{
    PrepareSpellScript(spell_putricide_slime_puddle);

    void ScaleRange(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 2.5f * GetCaster()->GetFloatValue(OBJECT_FIELD_SCALE_X), true));
    }

    // big hax to unlock Abomination Eat Ooze ability, requires caster aura spell from difficulty X, but unlocks clientside when got base aura
    void HandleScript(SpellEffIndex  /*effIndex*/)
    {
        SpellInfo const* s1 = sSpellMgr->GetSpellInfo(70346);
        SpellInfo const* s2 = sSpellMgr->GetSpellInfo(72456);
        if (s1 && s2)
            if (Unit* target = GetHitUnit())
            {
                Aura::TryRefreshStackOrCreate(s1, MAX_EFFECT_MASK, target, target);
                Aura::TryRefreshStackOrCreate(s2, MAX_EFFECT_MASK, target, target);
            }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_slime_puddle::ScaleRange, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_slime_puddle::ScaleRange, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_putricide_slime_puddle::HandleScript, EFFECT_1, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_putricide_slime_puddle_spawn : public SpellScript
{
    PrepareSpellScript(spell_putricide_slime_puddle_spawn);

    void SelectDest()
    {
        if (Position* dest = const_cast<WorldLocation*>(GetExplTargetDest()))
        {
            float destZ = 395.0f; // random number close to ground, get exact in next call
            GetCaster()->UpdateGroundPositionZ(dest->GetPositionX(), dest->GetPositionY(), destZ);
            dest->m_positionZ = destZ;
        }
    }

    void Register() override
    {
        BeforeCast += SpellCastFn(spell_putricide_slime_puddle_spawn::SelectDest);
    }
};

class spell_putricide_grow_stacker_aura : public AuraScript
{
    PrepareAuraScript(spell_putricide_grow_stacker_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TEAR_GAS_CREATURE });
    }

    void HandleTriggerSpell(AuraEffect const*  /*aurEff*/)
    {
        if (Unit* target = GetTarget())
            if (target->HasAura(SPELL_TEAR_GAS_CREATURE))
                PreventDefaultAction();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_putricide_grow_stacker_aura::HandleTriggerSpell, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_putricide_unstable_experiment : public SpellScript
{
    PrepareSpellScript(spell_putricide_unstable_experiment);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GetCaster()->GetTypeId() != TYPEID_UNIT)
            return;

        Creature* creature = GetCaster()->ToCreature();

        uint8 stage = creature->AI()->GetData(DATA_EXPERIMENT_STAGE);
        creature->AI()->SetData(DATA_EXPERIMENT_STAGE, stage ? 0 : 1);

        Creature* target = nullptr;
        std::list<Creature*> creList;
        GetCreatureListWithEntryInGrid(creList, GetCaster(), NPC_ABOMINATION_WING_MAD_SCIENTIST_STALKER, 200.0f);
        for (std::list<Creature*>::iterator itr = creList.begin(); itr != creList.end(); ++itr)
            if (((*itr)->GetPositionX() > 4350.0f && stage == 0) || ((*itr)->GetPositionX() < 4350.0f && stage == 1))
            {
                target = (*itr);
                break;
            }

        if (target)
        {
            if (Aura* aura = target->GetAura(uint32(GetSpellInfo()->Effects[stage].CalcValue())))
                if (aura->GetOwner() == target) // avoid assert(false) at any cost
                    aura->UpdateOwner(5000, target); // update whole aura so previous periodic ticks before refreshed by new one
        }

        GetCaster()->CastSpell(target, uint32(GetSpellInfo()->Effects[stage].CalcValue()), true, nullptr, nullptr, GetCaster()->GetGUID());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_putricide_unstable_experiment::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_putricide_tear_gas_effect : public SpellScript
{
    PrepareSpellScript(spell_putricide_tear_gas_effect);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        // vanish rank 1-3, mage invisibility
        targets.remove_if(Acore::UnitAuraCheck(true, 11327));
        targets.remove_if(Acore::UnitAuraCheck(true, 11329));
        targets.remove_if(Acore::UnitAuraCheck(true, 26888));
        targets.remove_if(Acore::UnitAuraCheck(true, 32612));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_tear_gas_effect::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_tear_gas_effect::FilterTargets, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_putricide_gaseous_bloat_aura : public AuraScript
{
    PrepareAuraScript(spell_putricide_gaseous_bloat_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GASEOUS_BLOAT });
    }

    void HandleExtraEffect(AuraEffect const* /*aurEff*/)
    {
        Unit* target = GetTarget();
        target->RemoveAuraFromStack(GetSpellInfo()->Id, GetCasterGUID());
        /*if (!target->HasAura(GetId()))
            if (Unit* caster = GetCaster())
                caster->CastCustomSpell(SPELL_GASEOUS_BLOAT, SPELLVALUE_AURA_STACK, 10, caster, false);*/
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_putricide_gaseous_bloat_aura::HandleExtraEffect, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_putricide_ooze_channel : public SpellScript
{
    PrepareSpellScript(spell_putricide_ooze_channel);

    bool Validate(SpellInfo const* spell) override
    {
        return ValidateSpellInfo({ spell->ExcludeTargetAuraSpell });
    }

    // set up initial variables and check if caster is creature
    // this will let use safely use ToCreature() casts in entire script
    bool Load() override
    {
        _target = nullptr;
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        // dbc has only 1 field for excluding, this will prevent anyone from getting both at the same time
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_VOLATILE_OOZE_PROTECTION));
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_GASEOUS_BLOAT_PROTECTION));

        if (targets.empty())
        {
            FinishCast(SPELL_FAILED_NO_VALID_TARGETS);
            GetCaster()->ToCreature()->DespawnOrUnsummon(1);    // despawn next update
            return;
        }

        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
        _target = target;
    }

    void SetTarget(std::list<WorldObject*>& targets)
    {
        targets.clear();
        if (_target)
            targets.push_back(_target);
    }

    void StartAttack()
    {
        GetCaster()->ClearUnitState(UNIT_STATE_CASTING);
        GetCaster()->GetThreatMgr().ClearAllThreat();
        GetCaster()->ToCreature()->SetInCombatWithZone();
        GetCaster()->ToCreature()->AI()->AttackStart(GetHitUnit());
        GetCaster()->AddThreat(GetHitUnit(), 500000000.0f);    // value seen in sniff
        if (Creature* c = GetCaster()->ToCreature())
            c->AI()->SetGUID(GetHitUnit()->GetGUID(), -1);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_ooze_channel::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_ooze_channel::SetTarget, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_ooze_channel::SetTarget, EFFECT_2, TARGET_UNIT_SRC_AREA_ENEMY);
        AfterHit += SpellHitFn(spell_putricide_ooze_channel::StartAttack);
    }

private:
    WorldObject* _target;
};

class spell_putricide_ooze_eruption_searcher : public SpellScript
{
    PrepareSpellScript(spell_putricide_ooze_eruption_searcher);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_OOZE_ERUPTION });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        uint32 adhesiveId = sSpellMgr->GetSpellIdForDifficulty(SPELL_VOLATILE_OOZE_ADHESIVE, GetCaster());
        if (GetHitUnit()->HasAura(adhesiveId))
        {
            GetHitUnit()->RemoveAurasDueToSpell(adhesiveId, GetCaster()->GetGUID(), 0, AURA_REMOVE_BY_ENEMY_SPELL);
            GetCaster()->CastSpell(GetHitUnit(), SPELL_OOZE_ERUPTION, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_putricide_ooze_eruption_searcher::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_putricide_mutated_plague_aura : public AuraScript
{
    PrepareAuraScript(spell_putricide_mutated_plague_aura);

    void HandleTriggerSpell(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        Unit* caster = GetCaster();
        if (!caster)
            return;

        uint32 triggerSpell = GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell;
        SpellInfo const* spell = sSpellMgr->AssertSpellInfo(triggerSpell);
        spell = sSpellMgr->GetSpellForDifficultyFromSpell(spell, caster);

        int32 damage = spell->Effects[EFFECT_0].CalcValue(caster);
        damage = damage * pow(2.5f, GetStackAmount());

        GetTarget()->CastCustomSpell(triggerSpell, SPELLVALUE_BASE_POINT0, damage, GetTarget(), true, nullptr, aurEff, GetCasterGUID());
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        uint32 healSpell = uint32(GetSpellInfo()->Effects[EFFECT_0].CalcValue());
        SpellInfo const* spell = sSpellMgr->GetSpellInfo(healSpell);
        if (!spell)
            return;
        spell = sSpellMgr->GetSpellForDifficultyFromSpell(spell, GetTarget());
        int32 healAmount = spell->Effects[EFFECT_0].CalcValue();
        healAmount *= GetStackAmount();
        GetTarget()->CastCustomSpell(healSpell, SPELLVALUE_BASE_POINT0, healAmount, GetTarget(), TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_putricide_mutated_plague_aura::HandleTriggerSpell, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_putricide_mutated_plague_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_putricide_unbound_plague : public SpellScript
{
    PrepareSpellScript(spell_putricide_unbound_plague);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_UNBOUND_PLAGUE, SPELL_UNBOUND_PLAGUE_SEARCHER });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (AuraEffect const* eff = GetCaster()->GetAuraEffect(SPELL_UNBOUND_PLAGUE_SEARCHER, EFFECT_0))
        {
            if (eff->GetTickNumber() < 2)
            {
                targets.clear();
                return;
            }
        }

        targets.remove_if(Acore::UnitAuraCheck(true, sSpellMgr->GetSpellIdForDifficulty(SPELL_UNBOUND_PLAGUE, GetCaster())));
        Acore::Containers::RandomResize(targets, 1);
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (!GetHitUnit())
            return;

        InstanceScript* instance = GetCaster()->GetInstanceScript();
        if (!instance)
            return;

        uint32 plagueId = sSpellMgr->GetSpellIdForDifficulty(SPELL_UNBOUND_PLAGUE, GetCaster());

        if (!GetHitUnit()->HasAura(plagueId))
        {
            if (Creature* professor = ObjectAccessor::GetCreature(*GetCaster(), instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE)))
            {
                if (Aura* oldPlague = GetCaster()->GetAura(plagueId, professor->GetGUID()))
                {
                    if (Aura* newPlague = professor->AddAura(plagueId, GetHitUnit()))
                    {
                        newPlague->SetMaxDuration(oldPlague->GetMaxDuration());
                        newPlague->SetDuration(oldPlague->GetDuration());
                        oldPlague->Remove();
                        GetCaster()->RemoveAurasDueToSpell(SPELL_UNBOUND_PLAGUE_SEARCHER);
                        GetCaster()->CastSpell(GetCaster(), SPELL_PLAGUE_SICKNESS, true);
                        GetCaster()->CastSpell(GetCaster(), SPELL_UNBOUND_PLAGUE_PROTECTION, true);
                        professor->CastSpell(GetHitUnit(), SPELL_UNBOUND_PLAGUE_SEARCHER, true);
                    }
                }
            }
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_unbound_plague::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
        OnEffectHitTarget += SpellEffectFn(spell_putricide_unbound_plague::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_putricide_unbound_plague_dmg_aura : public AuraScript
{
    PrepareAuraScript(spell_putricide_unbound_plague_dmg_aura);

    void HandlePeriodic(AuraEffect* aurEff)
    {
        int32 baseAmt = aurEff->GetSpellInfo()->Effects[0].CalcValue();
        int32 dmg = int32(baseAmt * pow(1.25f, float(aurEff->GetTickNumber())));
        if (dmg <= 0) // safety check, impossible
            return;
        aurEff->SetAmount(dmg);
    }

    void Register() override
    {
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_putricide_unbound_plague_dmg_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_putricide_choking_gas_bomb : public SpellScript
{
    PrepareSpellScript(spell_putricide_choking_gas_bomb);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        uint32 skipIndex = urand(0, 2);
        for (uint32 i = 0; i < 3; ++i)
        {
            if (i == skipIndex)
                continue;

            uint32 spellId = uint32(GetSpellInfo()->Effects[i].CalcValue());
            GetCaster()->CastSpell(GetCaster(), spellId, true, nullptr, nullptr, GetCaster()->GetGUID());
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_putricide_choking_gas_bomb::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// Removes aura with id stored in effect value
class spell_putricide_clear_aura_effect_value : public SpellScript
{
    PrepareSpellScript(spell_putricide_clear_aura_effect_value);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        uint32 auraId = sSpellMgr->GetSpellIdForDifficulty(uint32(GetEffectValue()), GetCaster());
        GetHitUnit()->RemoveAurasDueToSpell(auraId);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_putricide_clear_aura_effect_value::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_putricide_mutation_init : public SpellScript
{
    PrepareSpellScript(spell_putricide_mutation_init);

    SpellCastResult CheckRequirementInternal(SpellCustomErrors& extendedError)
    {
        InstanceScript* instance = GetExplTargetUnit()->GetInstanceScript();
        if (!instance)
            return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

        Creature* professor = ObjectAccessor::GetCreature(*GetExplTargetUnit(), instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE));
        if (!professor)
            return SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

        if (professor->AI()->GetData(DATA_PHASE) == 3 || !professor->IsAlive())
        {
            extendedError = SPELL_CUSTOM_ERROR_ALL_POTIONS_USED;
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        if (professor->AI()->GetData(DATA_ABOMINATION))
        {
            extendedError = SPELL_CUSTOM_ERROR_TOO_MANY_ABOMINATIONS;
            return SPELL_FAILED_CUSTOM_ERROR;
        }

        return SPELL_CAST_OK;
    }

    SpellCastResult CheckRequirement()
    {
        if (!GetExplTargetUnit())
            return SPELL_FAILED_BAD_TARGETS;

        if (GetExplTargetUnit()->GetTypeId() != TYPEID_PLAYER)
            return SPELL_FAILED_TARGET_NOT_PLAYER;

        SpellCustomErrors extension = SPELL_CUSTOM_ERROR_NONE;
        SpellCastResult result = CheckRequirementInternal(extension);
        if (result != SPELL_CAST_OK)
        {
            Spell::SendCastResult(GetExplTargetUnit()->ToPlayer(), GetSpellInfo(), 0, result, extension);
            return result;
        }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_putricide_mutation_init::CheckRequirement);
    }
};

class spell_putricide_mutation_init_aura : public AuraScript
{
    PrepareAuraScript(spell_putricide_mutation_init_aura);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        uint32 spellId = 70311;
        if (GetTarget()->GetMap()->GetSpawnMode() & 1)
            spellId = 71503;

        GetTarget()->CastSpell(GetTarget(), spellId, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_putricide_mutation_init_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_putricide_mutated_transformation : public SpellScript
{
    PrepareSpellScript(spell_putricide_mutated_transformation);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({
            SPELL_ABOMINATION_VEHICLE_POWER_DRAIN,
            SPELL_MUTATED_TRANSFORMATION_DAMAGE,
            SPELL_MUTATED_TRANSFORMATION_NAME,
            VEHICLE_SPELL_RIDE_HARDCODED
        });
    }

    void HandleSummon(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* caster = GetOriginalCaster();
        if (!caster)
            return;

        InstanceScript* instance = caster->GetInstanceScript();
        if (!instance)
            return;

        Creature* putricide = ObjectAccessor::GetCreature(*caster, instance->GetGuidData(DATA_PROFESSOR_PUTRICIDE));
        if (!putricide)
            return;

        if (putricide->AI()->GetData(DATA_ABOMINATION))
        {
            if (Player* player = caster->ToPlayer())
                Spell::SendCastResult(player, GetSpellInfo(), 0, SPELL_FAILED_CUSTOM_ERROR, SPELL_CUSTOM_ERROR_TOO_MANY_ABOMINATIONS);
            return;
        }

        if (!putricide->IsInCombat())
            putricide->SetInCombatWithZone();

        uint32 entry = uint32(GetSpellInfo()->Effects[effIndex].MiscValue);
        SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(uint32(GetSpellInfo()->Effects[effIndex].MiscValueB));
        uint32 duration = uint32(GetSpellInfo()->GetDuration());

        Position pos = caster->GetPosition();
        TempSummon* summon = caster->GetMap()->SummonCreature(entry, pos, properties, duration, caster, GetSpellInfo()->Id);
        if (!summon || !summon->IsVehicle())
            return;

        summon->CastSpell(summon, SPELL_ABOMINATION_VEHICLE_POWER_DRAIN, true);
        summon->CastSpell(summon, SPELL_MUTATED_TRANSFORMATION_DAMAGE, true);
        caster->CastSpell(summon, SPELL_MUTATED_TRANSFORMATION_NAME, true);

        //EnterVehicle(summon, 0);    // VEHICLE_SPELL_RIDE_HARDCODED is used according to sniff, this is ok
        caster->CastCustomSpell(VEHICLE_SPELL_RIDE_HARDCODED, SPELLVALUE_BASE_POINT0, 1, summon, TRIGGERED_FULL_MASK);
        summon->SetCreatorGUID(caster->GetGUID());
        putricide->AI()->JustSummoned(summon);

        summon->setPowerType(POWER_ENERGY);
        summon->SetMaxPower(POWER_ENERGY, 100);
        summon->SetPower(POWER_ENERGY, 0);
        summon->SetStatFloatValue(UNIT_FIELD_POWER_REGEN_INTERRUPTED_FLAT_MODIFIER, 0);
        summon->SetStatFloatValue(UNIT_FIELD_POWER_REGEN_FLAT_MODIFIER, 0);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_putricide_mutated_transformation::HandleSummon, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};

class spell_putricide_mutated_transformation_dismiss_aura : public AuraScript
{
    PrepareAuraScript(spell_putricide_mutated_transformation_dismiss_aura);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Vehicle* veh = GetTarget()->GetVehicleKit())
            veh->RemoveAllPassengers();
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_putricide_mutated_transformation_dismiss_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_putricide_mutated_transformation_dmg : public SpellScript
{
    PrepareSpellScript(spell_putricide_mutated_transformation_dmg);

    void FilterTargetsInitial(std::list<WorldObject*>& targets)
    {
        if (Unit* owner = ObjectAccessor::GetUnit(*GetCaster(), GetCaster()->GetCreatorGUID()))
            targets.remove(owner);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_mutated_transformation_dmg::FilterTargetsInitial, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

class spell_putricide_eat_ooze : public SpellScript
{
    PrepareSpellScript(spell_putricide_eat_ooze);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GROW_STACKER });
    }

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
        WorldObject* target = targets.front();
        targets.clear();
        targets.push_back(target);
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Creature* target = GetHitCreature();
        if (!target)
            return;

        if (Aura* grow = target->GetAura(uint32(GetEffectValue())))
        {
            if (grow->GetStackAmount() <= 4)
            {
                target->RemoveAurasDueToSpell(SPELL_GROW_STACKER);
                target->RemoveAura(grow);
                target->DespawnOrUnsummon(1);
            }
            else
                grow->ModStackAmount(-4);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_putricide_eat_ooze::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_putricide_eat_ooze::SelectTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
    }
};

class spell_putricide_regurgitated_ooze : public SpellScript
{
    PrepareSpellScript(spell_putricide_regurgitated_ooze);

    // the only purpose of this hook is to fail the achievement
    void ExtraEffect(SpellEffIndex /*effIndex*/)
    {
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
            instance->SetData(DATA_NAUSEA_ACHIEVEMENT, uint32(false));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_putricide_regurgitated_ooze::ExtraEffect, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

void AddSC_boss_professor_putricide()
{
    new boss_professor_putricide();
    new npc_volatile_ooze();
    new npc_gas_cloud();
    RegisterSpellScript(spell_putricide_slime_puddle);
    RegisterSpellScript(spell_putricide_slime_puddle_spawn);
    RegisterSpellScript(spell_putricide_grow_stacker_aura);
    RegisterSpellScript(spell_putricide_unstable_experiment);
    RegisterSpellScript(spell_putricide_tear_gas_effect);
    RegisterSpellScript(spell_putricide_gaseous_bloat_aura);
    RegisterSpellScript(spell_putricide_ooze_channel);
    RegisterSpellScript(spell_putricide_ooze_eruption_searcher);
    RegisterSpellScript(spell_putricide_mutated_plague_aura);
    RegisterSpellScript(spell_putricide_unbound_plague);
    RegisterSpellScript(spell_putricide_unbound_plague_dmg_aura);
    RegisterSpellScript(spell_putricide_choking_gas_bomb);
    RegisterSpellScript(spell_putricide_clear_aura_effect_value);
    RegisterSpellAndAuraScriptPair(spell_putricide_mutation_init, spell_putricide_mutation_init_aura);
    RegisterSpellScript(spell_putricide_mutated_transformation);
    RegisterSpellScript(spell_putricide_mutated_transformation_dismiss_aura);
    RegisterSpellScript(spell_putricide_mutated_transformation_dmg);
    RegisterSpellScript(spell_putricide_eat_ooze);
    RegisterSpellScript(spell_putricide_regurgitated_ooze);
}
