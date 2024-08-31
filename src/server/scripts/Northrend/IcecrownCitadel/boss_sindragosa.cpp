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
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "icecrown_citadel.h"

enum Texts
{
    SAY_AGGRO                           = 0, // You are fools to have come to this place! The icy winds of Northrend will consume your souls!
    SAY_UNCHAINED_MAGIC                 = 1, // Suffer, mortals, as your pathetic magic betrays you!
    EMOTE_WARN_BLISTERING_COLD          = 2, // %s prepares to unleash a wave of blistering cold!
    SAY_BLISTERING_COLD                 = 3, // Can you feel the cold hand of death upon your heart?
    SAY_RESPITE_FOR_A_TORMENTED_SOUL    = 4, // Aaah! It burns! What sorcery is this?!
    SAY_AIR_PHASE                       = 5, // Your incursion ends here! None shall survive!
    SAY_PHASE_2                         = 6, // Now feel my master's limitless power and despair!
    EMOTE_WARN_FROZEN_ORB               = 7, // %s fires a frozen orb towards $N!
    SAY_KILL                            = 8, // Perish!
    // A flaw of mortality...
    SAY_BERSERK                         = 9, // Enough! I tire of these games!
    SAY_DEATH                           = 10, // Free...at last...
    EMOTE_BERSERK_RAID                  = 11,
    EMOTE_WEAKENING                     = 101, // %s appears to be weakening!
};

enum Spells
{
    // Sindragosa
    SPELL_SINDRAGOSA_S_FURY     = 70608,
    SPELL_TANK_MARKER           = 71039,
    SPELL_TANK_MARKER_AURA      = 71038,
    SPELL_FROST_AURA            = 70084,
    SPELL_PERMAEATING_CHILL     = 70109,
    SPELL_CLEAVE                = 19983,
    SPELL_TAIL_SMASH            = 71077,
    SPELL_FROST_BREATH_P1       = 69649,
    SPELL_FROST_BREATH_P2       = 73061,
    SPELL_UNCHAINED_MAGIC       = 69762,
    SPELL_INSTABILITY           = 69766,
    SPELL_BACKLASH              = 69770,
    SPELL_ICY_GRIP              = 70117,
    SPELL_ICY_GRIP_JUMP         = 70122,
    SPELL_BLISTERING_COLD       = 70123,
    SPELL_FROST_BEACON          = 70126,
    SPELL_ICE_TOMB_TARGET       = 69712,
    SPELL_ICE_TOMB_DUMMY        = 69675,
    SPELL_ICE_TOMB_UNTARGETABLE = 69700,
    SPELL_ICE_TOMB_DAMAGE       = 70157,
    SPELL_ASPHYXIATION          = 71665,
    SPELL_FROST_BOMB_TRIGGER    = 69846,
    SPELL_FROST_BOMB_VISUAL     = 70022,
    SPELL_BIRTH_NO_VISUAL       = 40031,
    SPELL_FROST_BOMB            = 69845,
    SPELL_MYSTIC_BUFFET         = 70128,

    // Spinestalker
    SPELL_BELLOWING_ROAR        = 36922,
    SPELL_CLEAVE_SPINESTALKER   = 40505,
    SPELL_TAIL_SWEEP            = 71370,

    // Rimefang
    SPELL_FROST_BREATH          = 71386,
    SPELL_FROST_AURA_RIMEFANG   = 71387,
    SPELL_ICY_BLAST             = 71376,
    SPELL_ICY_BLAST_AREA        = 71380,

    // Frostwarden Handler
    SPELL_FOCUS_FIRE            = 71350,
    SPELL_ORDER_WHELP           = 71357,
    SPELL_CONCUSSIVE_SHOCK      = 71337,
};

enum Shadowmourne
{
    QUEST_FROST_INFUSION        = 24757,
    SPELL_FROST_INFUSION_CREDIT = 72289,
    SPELL_FROST_IMBUED_BLADE    = 72290,
    SPELL_FROST_INFUSION        = 72292,
};

enum Events
{
    EVENT_NONE,

    // Sindragosa
    EVENT_BERSERK,
    EVENT_CLEAVE,
    EVENT_TAIL_SMASH,
    EVENT_FROST_BREATH,
    EVENT_UNROOT,
    EVENT_UNCHAINED_MAGIC,
    EVENT_ICY_GRIP,
    EVENT_BLISTERING_COLD,
    EVENT_BLISTERING_COLD_YELL,
    EVENT_AIR_PHASE,
    EVENT_AIR_MOVEMENT,
    EVENT_AIR_MOVEMENT_FAR,
    EVENT_LAND,
    EVENT_LAND_GROUND,
    EVENT_FROST_BOMB,
    EVENT_THIRD_PHASE_CHECK,
    EVENT_ICE_TOMB,

    // Spinestalker
    EVENT_BELLOWING_ROAR            = 13,
    EVENT_CLEAVE_SPINESTALKER       = 14,
    EVENT_TAIL_SWEEP                = 15,

    // Rimefang
    EVENT_FROST_BREATH_RIMEFANG     = 16,
    EVENT_ICY_BLAST                 = 17,
    EVENT_ICY_BLAST_CAST            = 18,

    // Trash
    EVENT_FROSTWARDEN_ORDER_WHELP   = 19,
    EVENT_CONCUSSIVE_SHOCK          = 20,
    EVENT_WHELP_FROST_BLAST         = 21,

    // event groups
    EVENT_GROUP_LAND_PHASE          = 1,
};

enum FrostwingData
{
    DATA_MYSTIC_BUFFET_STACK    = 0,
    DATA_FROSTWYRM_OWNER        = 1,
    DATA_WHELP_MARKER           = 2,
    DATA_LINKED_GAMEOBJECT      = 3,
    DATA_TRAPPED_PLAYER         = 4,
};

enum MovementPoints
{
    POINT_FROSTWYRM_FLY_IN  = 1,
    POINT_FROSTWYRM_LAND    = 2,
    POINT_AIR_PHASE         = 3,
    POINT_TAKEOFF           = 4,
    POINT_LAND              = 5,
    POINT_AIR_PHASE_FAR     = 6,
    POINT_LAND_GROUND       = 7,
    POINT_CHASE_VICTIM      = 8,
};

Position const RimefangFlyPos      = {4413.309f, 2456.421f, 233.3795f, 2.890186f};
Position const RimefangLandPos     = {4413.309f, 2456.421f, 203.3848f, 2.890186f};
Position const SpinestalkerFlyPos  = {4418.895f, 2514.233f, 230.4864f, 3.396045f};
Position const SpinestalkerLandPos = {4418.895f, 2514.233f, 203.3848f, 3.396045f};
Position const SindragosaFlyInPos  = {4420.190f, 2484.360f, 232.5150f, 3.141593f};
Position const SindragosaLandPos   = {4419.190f, 2484.570f, 203.3848f, 3.141593f};
Position const SindragosaAirPos    = {4475.990f, 2484.430f, 247.9340f, 3.141593f};
Position const SindragosaAirPosFar = {4525.600f, 2485.150f, 245.0820f, 3.141593f};

class FrostwyrmLandEvent : public BasicEvent
{
public:
    FrostwyrmLandEvent(Creature& owner, Position const& dest) : _owner(owner), _dest(dest) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.GetMotionMaster()->MoveLand(POINT_FROSTWYRM_LAND, _dest, 8.5f);
        return true;
    }

private:
    Creature& _owner;
    Position const& _dest;
};

class FrostBombExplosion : public BasicEvent
{
public:
    FrostBombExplosion(Creature* owner, ObjectGuid sindragosaGUID) : _owner(owner), _sindragosaGUID(sindragosaGUID) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner->CastSpell((Unit*)nullptr, SPELL_FROST_BOMB, false, nullptr, nullptr, _sindragosaGUID);
        _owner->RemoveAurasDueToSpell(SPELL_FROST_BOMB_VISUAL);
        return true;
    }

private:
    Creature* _owner;
    ObjectGuid _sindragosaGUID;
};

class IceTombSummonEvent : public BasicEvent
{
public:
    IceTombSummonEvent(Unit* owner, ObjectGuid sindragosaGUID) : _owner(owner), _sindragosaGUID(sindragosaGUID) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        if (!_owner->IsAlive() || !_owner->HasAura(SPELL_ICE_TOMB_DAMAGE))
            return true;
        if (Creature* sindragosa = ObjectAccessor::GetCreature(*_owner, _sindragosaGUID))
        {
            if (!sindragosa->IsAlive())
                return true;

            Position pos = _owner->GetPosition();
            _owner->UpdateGroundPositionZ(pos.m_positionX, pos.m_positionY, pos.m_positionZ);

            if (TempSummon* summon = sindragosa->SummonCreature(NPC_ICE_TOMB, pos))
            {
                summon->AI()->SetGUID(_owner->GetGUID(), DATA_TRAPPED_PLAYER);
                _owner->CastSpell(_owner, SPELL_ICE_TOMB_UNTARGETABLE, true);
                if (GameObject* go = summon->SummonGameObject(GO_ICE_BLOCK, pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 0))
                {
                    go->SetSpellId(SPELL_ICE_TOMB_DAMAGE);
                    summon->AddGameObject(go);
                }
            }
        }
        return true;
    }

private:
    Unit* _owner;
    ObjectGuid _sindragosaGUID;
};

struct LastPhaseIceTombTargetSelector
{
public:
    LastPhaseIceTombTargetSelector(Creature* source) : _source(source) { }
    bool operator()(Unit const* target) const
    {
        if (!target)
            return false;

        if (target->GetExactDist(_source) > 80.0f)
            return false;

        if (target->GetTypeId() != TYPEID_PLAYER)
            return false;

        if (target->HasAura(SPELL_FROST_IMBUED_BLADE))
            return false;

        if (target->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL) || target->HasAura(SPELL_ICE_TOMB_UNTARGETABLE) || target->HasAura(SPELL_ICE_TOMB_DAMAGE) || target->HasAura(SPELL_TANK_MARKER_AURA) || target->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
            return false;

        return target != _source->GetVictim();
    }

private:
    Creature const* _source;
};

class boss_sindragosa : public CreatureScript
{
public:
    boss_sindragosa() : CreatureScript("boss_sindragosa") { }

    struct boss_sindragosaAI : public BossAI
    {
        boss_sindragosaAI(Creature* creature) : BossAI(creature, DATA_SINDRAGOSA)
        {
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_HASTE_SPELLS, true);
        }

        void Reset() override
        {
            _isBelow20Pct = false;
            _isThirdPhase = false;
            _isLanding = false;
            _bombCount = 0;
            _mysticBuffetStack = 0;
            _Reset();
            me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
            me->SetReactState(REACT_AGGRESSIVE);
            me->CastSpell(me, SPELL_TANK_MARKER, true);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!me->HasUnitMovementFlag(MOVEMENTFLAG_CAN_FLY))
                BossAI::MoveInLineOfSight(who);
        }

        void JustDied(Unit* /* killer */) override
        {
            _JustDied();
            Talk(SAY_DEATH);

            if (Is25ManRaid() && me->HasAura(SPELL_SHADOWS_FATE))
                DoCastAOE(SPELL_FROST_INFUSION_CREDIT, true);

            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_FROST_BEACON);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_TARGET);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_DUMMY);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_UNTARGETABLE);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ICE_TOMB_DAMAGE);
            instance->DoRemoveAurasDueToSpellOnPlayers(SPELL_ASPHYXIATION);
        }

        void JustEngagedWith(Unit* who) override
        {
            if (!instance->CheckRequiredBosses(DATA_SINDRAGOSA, who->ToPlayer()) || !me->IsVisible())
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                return;
            }

            _isBelow20Pct = false;
            _isThirdPhase = false;
            _bombCount = 0;
            _mysticBuffetStack = 0;

            summons.DespawnAll();
            events.Reset();
            events.ScheduleEvent(EVENT_BERSERK, 10min);
            events.ScheduleEvent(EVENT_AIR_PHASE, 50s);
            events.ScheduleEvent(EVENT_CLEAVE, 10s, EVENT_GROUP_LAND_PHASE);
            events.ScheduleEvent(EVENT_TAIL_SMASH, 20s, EVENT_GROUP_LAND_PHASE);
            events.ScheduleEvent(EVENT_FROST_BREATH, 8s, 12s, EVENT_GROUP_LAND_PHASE);
            events.ScheduleEvent(EVENT_UNCHAINED_MAGIC, 9s, 14s, EVENT_GROUP_LAND_PHASE);
            events.ScheduleEvent(EVENT_ICY_GRIP, 33s + 500ms, EVENT_GROUP_LAND_PHASE);

            me->setActive(true);
            me->SetInCombatWithZone();
            instance->SetBossState(DATA_SINDRAGOSA, IN_PROGRESS);

            me->CastSpell(me, SPELL_FROST_AURA, true);
            me->CastSpell(me, SPELL_PERMAEATING_CHILL, true);
            Talk(SAY_AGGRO);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return me->IsVisible() && target->GetEntry() != NPC_CROK_SCOURGEBANE;
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            instance->SetBossState(DATA_SINDRAGOSA, FAIL);
            BossAI::EnterEvadeMode(why);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
                Talk(SAY_KILL);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_FROSTWYRM && !_isLanding)
            {
                _isLanding = true;

                if (TempSummon* summon = me->ToTempSummon())
                    summon->SetTempSummonType(TEMPSUMMON_DEAD_DESPAWN);

                if (me->isDead())
                    return;

                me->setActive(true);
                me->SetDisableGravity(true);
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetSpeed(MOVE_RUN, 4.28571f);
                float moveTime = me->GetExactDist(&SindragosaFlyInPos) / (me->GetSpeed(MOVE_RUN) * 0.001f);
                me->m_Events.AddEvent(new FrostwyrmLandEvent(*me, SindragosaLandPos), me->m_Events.CalculateTime(uint64(moveTime) + 250));
                me->GetMotionMaster()->MovePoint(POINT_FROSTWYRM_FLY_IN, SindragosaFlyInPos);

                if (!instance->GetData(DATA_SINDRAGOSA_INTRO))
                {
                    DoCastAOE(SPELL_SINDRAGOSA_S_FURY);
                }
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_MYSTIC_BUFFET_STACK)
                return _mysticBuffetStack;
            return 0xFFFFFFFF;
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type != POINT_MOTION_TYPE && type != EFFECT_MOTION_TYPE)
                return;

            switch (point)
            {
                case POINT_FROSTWYRM_LAND:
                    me->setActive(false);
                    me->SetDisableGravity(false);
                    me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
                    me->SetHomePosition(SindragosaLandPos);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);

                    // Sindragosa enters combat as soon as she lands
                    me->SetInCombatWithZone();
                    break;
                case POINT_TAKEOFF:
                    events.ScheduleEvent(EVENT_AIR_MOVEMENT, 0ms);
                    break;
                case POINT_AIR_PHASE:
                    me->CastCustomSpell(SPELL_ICE_TOMB_TARGET, SPELLVALUE_MAX_TARGETS, RAID_MODE<int32>(2, 5, 2, 6), nullptr);
                    me->SetFacingTo(float(M_PI));
                    events.ScheduleEvent(EVENT_AIR_MOVEMENT_FAR, 0ms); // won't be processed during cast time anyway, so 0
                    events.ScheduleEvent(EVENT_FROST_BOMB, 7s);
                    _bombCount = 0;
                    break;
                case POINT_AIR_PHASE_FAR:
                    me->SetFacingTo(float(M_PI));
                    break;
                case POINT_LAND:
                    events.ScheduleEvent(EVENT_LAND_GROUND, 0ms);
                    break;
                case POINT_LAND_GROUND:
                    {
                        _isInAirPhase = false;
                        me->SetDisableGravity(false);
                        me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
                        me->SetReactState(REACT_AGGRESSIVE);
                        if (Unit* target = me->SelectVictim())
                            AttackStart(target);
                        break;
                    }
                default:
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!damage || me->IsInEvadeMode())
                return;

            if (!_isThirdPhase)
            {
                if (!HealthAbovePct(35))
                {
                    _isThirdPhase = true;
                    events.CancelEvent(EVENT_AIR_PHASE);
                    events.ScheduleEvent(EVENT_THIRD_PHASE_CHECK, 1s);
                }
            }
            else if (!_isBelow20Pct)
            {
                if (!HealthAbovePct(20))
                {
                    _isBelow20Pct = true;
                    if (instance->GetData(DATA_WEEKLY_QUEST_ID) == QUEST_RESPITE_FOR_A_TORMENTED_SOUL_10)
                        Talk(EMOTE_WEAKENING);
                }
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (summon->GetEntry() == NPC_FROST_BOMB)
                summon->m_Events.AddEvent(new FrostBombExplosion(summon, me->GetGUID()), summon->m_Events.CalculateTime(5500));
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            BossAI::SummonedCreatureDespawn(summon);
            if (summon->GetEntry() == NPC_ICE_TOMB)
                summon->AI()->JustDied(summon);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (target->IsPlayer())
                if (uint32 spellId = sSpellMgr->GetSpellIdForDifficulty(70127, me))
                    if (spellId == spell->Id)
                        if (Aura const* mysticBuffet = target->GetAura(spell->Id))
                            _mysticBuffetStack = std::max<uint8>(_mysticBuffetStack, mysticBuffet->GetStackAmount());
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BERSERK:
                    Talk(EMOTE_BERSERK_RAID);
                    Talk(SAY_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.ScheduleEvent(EVENT_CLEAVE, 10s, 15s, EVENT_GROUP_LAND_PHASE);
                    break;
                case EVENT_TAIL_SMASH:
                    me->DisableRotate(true);
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->SendMovementFlagUpdate();
                    me->CastSpell(me->GetVictim(), SPELL_TAIL_SMASH, false);
                    events.DelayEventsToMax(1, 0);
                    events.ScheduleEvent(EVENT_UNROOT, 0ms);
                    events.ScheduleEvent(EVENT_TAIL_SMASH, 22s, 27s, EVENT_GROUP_LAND_PHASE);
                    break;
                case EVENT_FROST_BREATH:
                    me->DisableRotate(true);
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->SendMovementFlagUpdate();
                    me->CastSpell(me->GetVictim(), _isThirdPhase ? SPELL_FROST_BREATH_P2 : SPELL_FROST_BREATH_P1, false);
                    events.DelayEventsToMax(1, 0);
                    events.ScheduleEvent(EVENT_UNROOT, 0ms);
                    events.ScheduleEvent(EVENT_FROST_BREATH, 20s, 25s, EVENT_GROUP_LAND_PHASE);
                    break;
                case EVENT_UNROOT:
                    me->DisableRotate(false);
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    break;
                case EVENT_UNCHAINED_MAGIC:
                    Talk(SAY_UNCHAINED_MAGIC);
                    me->CastSpell((Unit*)nullptr, SPELL_UNCHAINED_MAGIC, false);
                    events.ScheduleEvent(EVENT_UNCHAINED_MAGIC, 30s, 35s, EVENT_GROUP_LAND_PHASE);
                    break;
                case EVENT_ICY_GRIP:
                    me->CastSpell((Unit*)nullptr, SPELL_ICY_GRIP, false);
                    events.DelayEventsToMax(1001, 0);
                    events.ScheduleEvent(EVENT_BLISTERING_COLD, 1s, EVENT_GROUP_LAND_PHASE);
                    if (uint32 evTime = events.GetNextEventTime(EVENT_ICE_TOMB))
                        if (events.GetTimer() > evTime || evTime - events.GetTimer() < 7000)
                            events.RescheduleEvent(EVENT_ICE_TOMB, 7s);
                    break;
                case EVENT_BLISTERING_COLD:
                    Talk(EMOTE_WARN_BLISTERING_COLD);
                    me->CastSpell(me, SPELL_BLISTERING_COLD, false);
                    events.ScheduleEvent(EVENT_BLISTERING_COLD_YELL, 5s, EVENT_GROUP_LAND_PHASE);
                    if (_isThirdPhase)
                        events.RescheduleEvent(EVENT_ICY_GRIP, 65s, 70s);
                    break;
                case EVENT_BLISTERING_COLD_YELL:
                    Talk(SAY_BLISTERING_COLD);
                    break;

                // AIR PHASE EVENTS BELOW:
                case EVENT_AIR_PHASE:
                    // pussywizard: unroot may be scheduled after this event cos of events (time must be unique)
                    if (me->HasUnitState(UNIT_STATE_ROOT))
                    {
                        events.CancelEvent(EVENT_UNROOT);
                        me->DisableRotate(false);
                        me->SetControlled(false, UNIT_STATE_ROOT);
                    }

                    _isInAirPhase = true;
                    Talk(SAY_AIR_PHASE);
                    me->SetReactState(REACT_PASSIVE);
                    me->SetSpeed(MOVE_RUN, 4.28571f);
                    me->SendMeleeAttackStop(me->GetVictim());
                    me->AttackStop();
                    me->GetMotionMaster()->MoveIdle();
                    me->StopMoving();
                    me->SetDisableGravity(true);
                    me->GetMotionMaster()->MoveTakeoff(POINT_TAKEOFF, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 20.0f, 10.0f);
                    events.CancelEventGroup(EVENT_GROUP_LAND_PHASE);
                    events.ScheduleEvent(EVENT_AIR_PHASE, 110s);
                    break;
                case EVENT_AIR_MOVEMENT:
                    me->GetMotionMaster()->MovePoint(POINT_AIR_PHASE, SindragosaAirPos);
                    break;
                case EVENT_AIR_MOVEMENT_FAR:
                    me->GetMotionMaster()->MovePoint(POINT_AIR_PHASE_FAR, SindragosaAirPosFar);
                    break;
                case EVENT_FROST_BOMB:
                    {
                        ++_bombCount;
                        float destX, destY, destZ;
                        std::list<GameObject*> gl;
                        me->GetGameObjectListWithEntryInGrid(gl, GO_ICE_BLOCK, SIZE_OF_GRIDS);
                        uint8 triesLeft = 10;
                        do
                        {
                            destX = float(rand_norm()) * 75.0f + 4350.0f;
                            destY = float(rand_norm()) * 75.0f + 2450.0f;
                            destZ = 205.0f; // random number close to ground, get exact in next call
                            me->UpdateGroundPositionZ(destX, destY, destZ);
                            bool ok = true;
                            for (std::list<GameObject*>::const_iterator itr = gl.begin(); itr != gl.end(); ++itr)
                                if ((*itr)->GetExactDist2dSq(destX, destY) < 3.0f * 3.0f)
                                {
                                    ok = false;
                                    break;
                                }
                            if (ok)
                                break;
                        } while (--triesLeft);

                        me->CastSpell(destX, destY, destZ, SPELL_FROST_BOMB_TRIGGER, false);
                        if (_bombCount >= 4)
                            events.ScheduleEvent(EVENT_LAND, 5500ms);
                        else
                            events.ScheduleEvent(EVENT_FROST_BOMB, 6s);
                        break;
                    }
                case EVENT_LAND:
                    me->GetMotionMaster()->MovePoint(POINT_LAND, SindragosaFlyInPos);
                    break;
                case EVENT_LAND_GROUND:
                    events.ScheduleEvent(EVENT_CLEAVE, 13s, 15s, EVENT_GROUP_LAND_PHASE);
                    events.ScheduleEvent(EVENT_TAIL_SMASH, 19s, 23s, EVENT_GROUP_LAND_PHASE);
                    events.ScheduleEvent(EVENT_FROST_BREATH, 7s, 10s, EVENT_GROUP_LAND_PHASE);
                    events.ScheduleEvent(EVENT_UNCHAINED_MAGIC, 12s, 17s, EVENT_GROUP_LAND_PHASE);
                    events.ScheduleEvent(EVENT_ICY_GRIP, 35s, 40s, EVENT_GROUP_LAND_PHASE);
                    me->GetMotionMaster()->MoveLand(POINT_LAND_GROUND, SindragosaLandPos, 10.0f);
                    break;
                case EVENT_THIRD_PHASE_CHECK:
                    if (!_isInAirPhase)
                    {
                        Talk(SAY_PHASE_2);
                        events.ScheduleEvent(EVENT_ICE_TOMB, 7s, 10s);
                        events.RescheduleEvent(EVENT_ICY_GRIP, 35s, 40s, EVENT_GROUP_LAND_PHASE);
                        me->CastSpell(me, SPELL_MYSTIC_BUFFET, true);
                    }
                    else
                        events.ScheduleEvent(EVENT_THIRD_PHASE_CHECK, 5s);
                    break;
                case EVENT_ICE_TOMB:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, LastPhaseIceTombTargetSelector(me)))
                    {
                        Talk(EMOTE_WARN_FROZEN_ORB, target);
                        me->CastSpell(target, SPELL_ICE_TOMB_DUMMY, true);
                        me->CastSpell(target, SPELL_FROST_BEACON, true);
                        if (uint32 evTime = events.GetNextEventTime(EVENT_ICY_GRIP))
                            if (events.GetTimer() > evTime || evTime - events.GetTimer() < 8000)
                                events.RescheduleEvent(EVENT_ICY_GRIP, 8s, EVENT_GROUP_LAND_PHASE);
                    }
                    events.ScheduleEvent(EVENT_ICE_TOMB, 18s, 22s);
                    break;
                default:
                    break;
            }

            if (me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()) && me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE && !me->IsWithinLOSInMap(me->GetVictim()))
                me->GetMotionMaster()->MoveCharge(me->GetVictim()->GetPositionX(), me->GetVictim()->GetPositionY(), me->GetVictim()->GetPositionZ(), me->GetSpeed(MOVE_RUN), POINT_CHASE_VICTIM);
            DoMeleeAttackIfReady();
        }

    private:
        uint8 _bombCount;
        uint8 _mysticBuffetStack;
        bool _isBelow20Pct;
        bool _isThirdPhase;
        bool _isInAirPhase;
        bool _isLanding;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<boss_sindragosaAI>(creature);
    }
};

class npc_ice_tomb : public CreatureScript
{
public:
    npc_ice_tomb() : CreatureScript("npc_ice_tomb") { }

    struct npc_ice_tombAI : public NullCreatureAI
    {
        npc_ice_tombAI(Creature* creature) : NullCreatureAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            _existenceCheckTimer = 1000;
            _asphyxiationTimer = 22500;
        }

        ObjectGuid _trappedPlayerGUID;
        uint32 _existenceCheckTimer;
        uint16 _asphyxiationTimer;

        void SetGUID(ObjectGuid guid, int32 type) override
        {
            if (type == DATA_TRAPPED_PLAYER)
                _trappedPlayerGUID = guid;
        }

        void DamageTaken(Unit*, uint32& dmg, DamageEffectType, SpellSchoolMask) override
        {
            if (dmg >= me->GetHealth())
                me->m_positionZ = me->GetPositionZ() - 5.0f;
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->RemoveAllGameObjects();

            if (Player* player = ObjectAccessor::GetPlayer(*me, _trappedPlayerGUID))
            {
                _trappedPlayerGUID.Clear();
                player->RemoveAurasDueToSpell(SPELL_ICE_TOMB_DAMAGE);
                player->RemoveAurasDueToSpell(SPELL_ASPHYXIATION);
                player->RemoveAurasDueToSpell(SPELL_ICE_TOMB_UNTARGETABLE);
                me->DespawnOrUnsummon(5000);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!_trappedPlayerGUID)
                return;

            if (_existenceCheckTimer <= diff)
            {
                Player* player = ObjectAccessor::GetPlayer(*me, _trappedPlayerGUID);
                if (!player || !player->IsAlive() || !player->HasAura(SPELL_ICE_TOMB_DAMAGE))
                {
                    // Remove object
                    JustDied(me);
                    me->DespawnOrUnsummon();
                    return;
                }
                _existenceCheckTimer = 1000;
            }
            else
                _existenceCheckTimer -= diff;

            if (_asphyxiationTimer)
            {
                if (_asphyxiationTimer <= diff)
                {
                    _asphyxiationTimer = 0;
                    if (Player* player = ObjectAccessor::GetPlayer(*me, _trappedPlayerGUID))
                    {
                        player->RemoveAurasDueToSpell(SPELL_ICE_TOMB_UNTARGETABLE);
                        player->CastSpell(player, SPELL_ASPHYXIATION, true);
                    }
                }
                else
                    _asphyxiationTimer -= diff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_ice_tombAI>(creature);
    }
};

class spell_sindragosa_s_fury : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_s_fury);

    bool Load() override
    {
        _targetCount = 0;

        // This script should execute only in Icecrown Citadel
        if (InstanceMap* instance = GetCaster()->GetMap()->ToInstanceMap())
            if (instance->GetInstanceScript())
                if (instance->GetScriptId() == sObjectMgr->GetScriptId(ICCScriptName))
                    return true;

        return false;
    }

    void SelectDest()
    {
        if (Position* dest = const_cast<WorldLocation*>(GetExplTargetDest()))
        {
            float destX = float(rand_norm()) * 75.0f + 4350.0f;
            float destY = float(rand_norm()) * 75.0f + 2450.0f;
            float destZ = 205.0f; // random number close to ground, get exact in next call
            GetCaster()->UpdateGroundPositionZ(destX, destY, destZ);
            dest->Relocate(destX, destY, destZ);
        }
    }

    void CountTargets(std::list<WorldObject*>& targets)
    {
        _targetCount = targets.size();
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (!GetHitUnit()->IsAlive() || (GetHitUnit()->IsPlayer() && GetHitUnit()->ToPlayer()->IsGameMaster()) || !_targetCount)
            return;

        float resistance = float(GetHitUnit()->GetResistance(SpellSchoolMask(GetSpellInfo()->SchoolMask)));
        float ResistFactor = ((resistance * 2.0f) / (resistance + 510.0f));
        if (ResistFactor > 0.9f)
            ResistFactor = 0.9f;

        uint32 damage = uint32( (GetEffectValue() / _targetCount) * (1.0f - ResistFactor) );

        SpellNonMeleeDamage damageInfo(GetCaster(), GetHitUnit(), GetSpellInfo(), GetSpellInfo()->SchoolMask);
        damageInfo.damage = damage;
        GetCaster()->SendSpellNonMeleeDamageLog(&damageInfo);
        GetCaster()->DealSpellDamage(&damageInfo, false);
    }

    void Register() override
    {
        BeforeCast += SpellCastFn(spell_sindragosa_s_fury::SelectDest);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_s_fury::CountTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_sindragosa_s_fury::HandleDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }

private:
    uint32 _targetCount;
};

class UnchainedMagicTargetSelector
{
public:
    UnchainedMagicTargetSelector(bool removeHealers) : _removeHealers(removeHealers) { }

    bool operator()(WorldObject* object) const
    {
        if (Player* p = object->ToPlayer())
        {
            if (p->getPowerType() != POWER_MANA)
                return true;
            if (p->IsClass(CLASS_HUNTER))
                return true;
            uint8 maxIndex = p->GetMostPointsTalentTree();
            if ((p->IsClass(CLASS_PALADIN) && maxIndex >= 1) || (p->IsClass(CLASS_SHAMAN) && maxIndex == 1) || (p->IsClass(CLASS_DRUID) && maxIndex == 1))
                return true;
            if (_removeHealers == ((p->IsClass(CLASS_DRUID) && maxIndex == 2) || (p->IsClass(CLASS_PALADIN) && maxIndex == 0) || (p->IsClass(CLASS_PRIEST) && maxIndex <= 1) || (p->IsClass(CLASS_SHAMAN) && maxIndex == 2)))
                return true;

            return false;
        }
        return true;
    }
private:
    bool _removeHealers;
};

class spell_sindragosa_unchained_magic : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_unchained_magic);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        std::list<WorldObject*> healList = unitList;
        std::list<WorldObject*> dpsList = unitList;
        unitList.clear();
        uint32 maxSize = uint32(GetCaster()->GetMap()->GetSpawnMode() & 1 ? 3 : 1);
        healList.remove_if(UnchainedMagicTargetSelector(false));
        if (healList.size() > maxSize)
            Acore::Containers::RandomResize(healList, maxSize);
        dpsList.remove_if(UnchainedMagicTargetSelector(true));
        if (dpsList.size() > maxSize)
            Acore::Containers::RandomResize(dpsList, maxSize);
        unitList.splice(unitList.begin(), healList);
        unitList.splice(unitList.begin(), dpsList);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_unchained_magic::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_sindragosa_permeating_chill_aura : public AuraScript
{
    PrepareAuraScript(spell_sindragosa_permeating_chill_aura);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetProcTarget() && eventInfo.GetProcTarget()->GetEntry() == NPC_SINDRAGOSA;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_sindragosa_permeating_chill_aura::CheckProc);
    }
};

class spell_sindragosa_instability_aura : public AuraScript
{
    PrepareAuraScript(spell_sindragosa_instability_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_BACKLASH });
    }

    void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
            GetTarget()->CastCustomSpell(SPELL_BACKLASH, SPELLVALUE_BASE_POINT0, aurEff->GetAmount(), GetTarget(), true, nullptr, aurEff, GetCasterGUID());
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_sindragosa_instability_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_sindragosa_icy_grip : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_icy_grip);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_ICY_GRIP_JUMP });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (!GetHitUnit()->IsWithinLOSInMap(GetCaster()) || GetHitUnit()->HasAura(SPELL_TANK_MARKER_AURA))
            return;

        GetHitUnit()->CastSpell(GetCaster(), SPELL_ICY_GRIP_JUMP, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_sindragosa_icy_grip::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_sindragosa_icy_grip_jump : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_icy_grip_jump);

    void HandleSpecial(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        float x = GetHitUnit()->GetPositionX();
        float y = GetHitUnit()->GetPositionY();
        float z = GetHitUnit()->GetPositionZ() + 0.1f;
        float speedXY, speedZ;

        if (GetSpellInfo()->Effects[effIndex].MiscValue)
            speedZ = float(GetSpellInfo()->Effects[effIndex].MiscValue) / 10;
        else if (GetSpellInfo()->Effects[effIndex].MiscValueB)
            speedZ = float(GetSpellInfo()->Effects[effIndex].MiscValueB) / 10;
        else
            speedZ = 10.0f;
        speedXY = GetCaster()->GetExactDist2d(x, y) * 10.0f / speedZ;

        GetCaster()->GetMotionMaster()->MoveJump(x, y, z, speedXY, speedZ);
    }

    void Register() override
    {
        OnEffectLaunchTarget += SpellEffectFn(spell_sindragosa_icy_grip_jump::HandleSpecial, EFFECT_0, SPELL_EFFECT_JUMP);
    }
};

class spell_sindragosa_frost_beacon_aura : public AuraScript
{
    PrepareAuraScript(spell_sindragosa_frost_beacon_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_ICE_TOMB_DAMAGE });
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            caster->CastSpell(GetTarget(), SPELL_ICE_TOMB_DAMAGE, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_sindragosa_frost_beacon_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class SindragosaIceTombCheck
{
public:
    bool operator()(Unit* unit) const
    {
        //npcbot
        if (!unit->IsPlayer())
            return true;
        //end npcbot

        return unit->HasAura(SPELL_FROST_IMBUED_BLADE) || unit->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL);
    }

    bool operator()(WorldObject* object) const
    {
        //npcbot
        if (!object->IsPlayer())
            return true;
        //end npcbot

        return object->ToUnit() && (object->ToUnit()->HasAura(SPELL_FROST_IMBUED_BLADE) || object->ToUnit()->IsImmunedToDamageOrSchool(SPELL_SCHOOL_MASK_ALL));
    }
};

class spell_sindragosa_ice_tomb_filter : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_ice_tomb_filter);

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        unitList.remove_if(SindragosaIceTombCheck());
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_ice_tomb_filter::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_sindragosa_ice_tomb_trap : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_ice_tomb_trap);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        if (!sObjectMgr->GetCreatureTemplate(NPC_ICE_TOMB))
            return false;
        if (!sObjectMgr->GetGameObjectTemplate(GO_ICE_BLOCK))
            return false;
        return true;
    }

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
            //npcbot
            unitList.remove_if(SindragosaIceTombCheck());
            //end npcbot

        unitList.remove_if(Acore::UnitAuraCheck(true, GetSpellInfo()->Id));
        _targetList.clear();
        _targetList = unitList;
    }

    void FilterTargetsSubseq(std::list<WorldObject*>& unitList)
    {
        unitList.clear();
        unitList = _targetList;
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_ice_tomb_trap::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_ice_tomb_trap::FilterTargetsSubseq, EFFECT_2, TARGET_UNIT_DEST_AREA_ENEMY);
    }

private:
    std::list<WorldObject*> _targetList;
};

class spell_sindragosa_ice_tomb_trap_aura : public AuraScript
{
    PrepareAuraScript(spell_sindragosa_ice_tomb_trap_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ASPHYXIATION, SPELL_ICE_TOMB_UNTARGETABLE });
    }

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
    }

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* c = GetCaster())
            GetTarget()->m_Events.AddEvent(new IceTombSummonEvent(GetTarget(), c->GetGUID()), GetTarget()->m_Events.CalculateTime(500));
    }

    void ExtraRemoveEffect(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_ASPHYXIATION);
        GetTarget()->RemoveAurasDueToSpell(SPELL_ICE_TOMB_UNTARGETABLE);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_sindragosa_ice_tomb_trap_aura::PeriodicTick, EFFECT_2, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_sindragosa_ice_tomb_trap_aura::ExtraRemoveEffect, EFFECT_1, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
        AfterEffectApply += AuraEffectApplyFn(spell_sindragosa_ice_tomb_trap_aura::AfterApply, EFFECT_1, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
    }
};

class MysticBuffetTargetFilter
{
public:
    explicit MysticBuffetTargetFilter(Unit* caster) : _caster(caster) { }

    bool operator()(WorldObject* unit) const
    {
        if (!unit->IsInMap(_caster))
            return true;

        // for standard creatures check full LOS
        if (Creature* c = unit->ToCreature())
            if (!c->IsPet() && c->GetSpawnId())
                return !_caster->IsWithinLOSInMap(unit);

        // for players and pets check only dynamic los (ice block gameobjects)
        float ox, oy, oz;
        _caster->GetPosition(ox, oy, oz);
        DynamicMapTree const& dTree = unit->GetMap()->GetDynamicMapTree();
        return !dTree.isInLineOfSight(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ() + 2.f, ox, oy, oz + 2.f, unit->GetPhaseMask(), VMAP::ModelIgnoreFlags::Nothing);
    }

private:
    Unit* _caster;
};

class spell_sindragosa_mystic_buffet : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_mystic_buffet);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(MysticBuffetTargetFilter(GetCaster()));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_sindragosa_mystic_buffet::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_sindragosa_soul_preservation_aura : public AuraScript
{
    PrepareAuraScript(spell_sindragosa_soul_preservation_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ 72466, 72424 });
    }

    void PeriodicTick(AuraEffect const*  /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* s = GetTarget())
            if (GetStackAmount() >= (s->GetMap()->Is25ManRaid() ? 75 : 30))
            {
                s->CastSpell(s, 72466, true);
                s->RemoveAurasDueToSpell(72424);
                if (s->GetTypeId() == TYPEID_UNIT) s->ToCreature()->SetLootMode(3);
                SetDuration(1);
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_sindragosa_soul_preservation_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class achievement_all_you_can_eat : public AchievementCriteriaScript
{
public:
    achievement_all_you_can_eat() : AchievementCriteriaScript("achievement_all_you_can_eat") { }

    bool OnCheck(Player* /*source*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target || target->GetEntry() != NPC_SINDRAGOSA)
            return false;
        return target->GetAI()->GetData(DATA_MYSTIC_BUFFET_STACK) <= 5;
    }
};

class npc_spinestalker : public CreatureScript
{
public:
    npc_spinestalker() : CreatureScript("npc_spinestalker") { }

    struct npc_spinestalkerAI : public ScriptedAI
    {
        npc_spinestalkerAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()), _summoned(false)
        {
        }

        void InitializeAI() override
        {
            if (!me->isDead())
            {
                _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetSpawnId());  // this cannot be in Reset because reset also happens on evade
                Reset();
            }
        }

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_BELLOWING_ROAR, 20s, 25s);
            _events.ScheduleEvent(EVENT_CLEAVE_SPINESTALKER, 10s, 15s);
            _events.ScheduleEvent(EVENT_TAIL_SWEEP, 8s, 12s);
            me->SetReactState(REACT_DEFENSIVE);

            if (!_summoned)
            {
                me->SetDisableGravity(true);
            }
        }

        void JustReachedHome() override
        {
            ScriptedAI::JustReachedHome();
            if (_summoned)
            {
                me->SetDisableGravity(false);
            }
        }

        void JustRespawned() override
        {
            ScriptedAI::JustRespawned();
            _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetSpawnId());  // this cannot be in Reset because reset also happens on evade
        }

        void JustDied(Unit* /*killer*/) override
        {
            _events.Reset();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_FROSTWYRM)
            {
                if (_summoned)
                    return;

                _summoned = true;
                if (me->isDead())
                    return;

                me->setActive(true);
                me->SetImmuneToPC(true);
                float moveTime = me->GetExactDist(&SpinestalkerFlyPos) / (me->GetSpeed(MOVE_RUN) * 0.001f);
                me->m_Events.AddEvent(new FrostwyrmLandEvent(*me, SpinestalkerLandPos), me->m_Events.CalculateTime(uint64(moveTime) + 250));
                me->SetDefaultMovementType(IDLE_MOTION_TYPE);
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                me->GetMotionMaster()->MovePoint(POINT_FROSTWYRM_FLY_IN, SpinestalkerFlyPos);
            }
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type != EFFECT_MOTION_TYPE || point != POINT_FROSTWYRM_LAND)
                return;

            me->setActive(false);
            me->SetDisableGravity(false);
            me->SetHomePosition(SpinestalkerLandPos);
            me->SetFacingTo(SpinestalkerLandPos.GetOrientation());
            me->SetImmuneToPC(false);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_BELLOWING_ROAR:
                    me->CastSpell(me, SPELL_BELLOWING_ROAR, false);
                    _events.ScheduleEvent(EVENT_BELLOWING_ROAR, 25s, 30s);
                    break;
                case EVENT_CLEAVE_SPINESTALKER:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE_SPINESTALKER, false);
                    _events.ScheduleEvent(EVENT_CLEAVE_SPINESTALKER, 10s, 15s);
                    break;
                case EVENT_TAIL_SWEEP:
                    me->CastSpell(me->GetVictim(), SPELL_TAIL_SWEEP, false);
                    _events.ScheduleEvent(EVENT_TAIL_SWEEP, 22s, 25s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
        bool _summoned;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_spinestalkerAI>(creature);
    }
};

class npc_rimefang : public CreatureScript
{
public:
    npc_rimefang() : CreatureScript("npc_rimefang_icc") { }

    struct npc_rimefangAI : public ScriptedAI
    {
        npc_rimefangAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()), _summoned(false)
        {
        }

        void InitializeAI() override
        {
            if (!me->isDead())
            {
                _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetSpawnId());  // this cannot be in Reset because reset also happens on evade
                Reset();
            }
        }

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_FROST_BREATH_RIMEFANG, 12s, 15s);
            _events.ScheduleEvent(EVENT_ICY_BLAST, 30s, 35s);
            me->SetReactState(REACT_DEFENSIVE);
            _icyBlastCounter = 0;

            if (!_summoned)
            {
                me->SetDisableGravity(true);
            }
        }

        void JustReachedHome() override
        {
            ScriptedAI::JustReachedHome();
            if (_summoned)
            {
                me->SetDisableGravity(false);
            }
        }

        void JustRespawned() override
        {
            ScriptedAI::JustRespawned();
            _instance->SetData(DATA_SINDRAGOSA_FROSTWYRMS, me->GetSpawnId());  // this cannot be in Reset because reset also happens on evade
        }

        void JustDied(Unit* /*killer*/) override
        {
            _events.Reset();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_START_FROSTWYRM)
            {
                if (_summoned)
                    return;

                _summoned = true;
                if (me->isDead())
                    return;

                me->setActive(true);
                me->SetImmuneToPC(true);
                float moveTime = me->GetExactDist(&RimefangFlyPos) / (me->GetSpeed(MOVE_RUN) * 0.001f);
                me->m_Events.AddEvent(new FrostwyrmLandEvent(*me, RimefangLandPos), me->m_Events.CalculateTime(uint64(moveTime) + 250));
                me->SetDefaultMovementType(IDLE_MOTION_TYPE);
                me->GetMotionMaster()->MoveIdle();
                me->StopMoving();
                me->GetMotionMaster()->MovePoint(POINT_FROSTWYRM_FLY_IN, RimefangFlyPos);
            }
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type != EFFECT_MOTION_TYPE)
                return;

            if (point == POINT_FROSTWYRM_LAND)
            {
                me->setActive(false);
                me->SetDisableGravity(false);
                me->SetHomePosition(RimefangLandPos);
                me->SetFacingTo(RimefangLandPos.GetOrientation());
                me->SetImmuneToPC(false);
            }
            else if (point == POINT_LAND_GROUND)
            {
                me->SetDisableGravity(false);
                me->SetReactState(REACT_DEFENSIVE);
                if (Unit* victim = me->SelectVictim())
                    AttackStart(victim);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->CastSpell(me, SPELL_FROST_AURA_RIMEFANG, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_FROST_BREATH_RIMEFANG:
                    if (!me->IsFlying())
                    {
                        me->CastSpell(me->GetVictim(), SPELL_FROST_BREATH, false);
                        _events.ScheduleEvent(EVENT_FROST_BREATH_RIMEFANG, 20s, 25s);
                    }
                    else
                        _events.ScheduleEvent(EVENT_FROST_BREATH_RIMEFANG, 5s);
                    break;
                case EVENT_ICY_BLAST:
                    {
                        _icyBlastCounter = RAID_MODE<uint8>(5, 7, 6, 8);
                        me->SetReactState(REACT_PASSIVE);

                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->SendMeleeAttackStop(me->GetVictim());

                        me->AttackStop();
                        me->SetDisableGravity(true);
                        float floorZ = me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                        float destZ;
                        if (floorZ > 190.0f) destZ = floorZ + 25.0f;
                        else destZ = me->GetPositionZ() + 25.0f;
                        me->GetMotionMaster()->MoveTakeoff(0, me->GetPositionX(), me->GetPositionY(), destZ, me->GetSpeed(MOVE_RUN));
                        float moveTime = std::fabs(destZ - me->GetPositionZ()) / (me->GetSpeed(MOVE_RUN) * 0.001f);
                        _events.ScheduleEvent(EVENT_ICY_BLAST, uint32(moveTime) + urand(60000, 70000));
                        _events.ScheduleEvent(EVENT_ICY_BLAST_CAST, uint32(moveTime) + 250);
                        break;
                    }
                case EVENT_ICY_BLAST_CAST:
                    if (--_icyBlastCounter)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                        {
                            me->SetFacingToObject(target);
                            me->CastSpell(target, SPELL_ICY_BLAST, false);
                        }
                        _events.ScheduleEvent(EVENT_ICY_BLAST_CAST, 3s);
                    }
                    else
                    {
                        float floorZ = me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                        float destZ;
                        if (floorZ > 190.0f) destZ = floorZ;
                        else destZ = me->GetPositionZ() - 25.0f;
                        me->SendMeleeAttackStop(me->GetVictim());
                        me->GetMotionMaster()->MoveLand(POINT_LAND_GROUND, me->GetPositionX(), me->GetPositionY(), destZ, me->GetSpeed(MOVE_RUN));
                    }
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
        uint8 _icyBlastCounter;
        bool _summoned;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_rimefangAI>(creature);
    }
};

class spell_rimefang_icy_blast : public SpellScript
{
    PrepareSpellScript(spell_rimefang_icy_blast);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_ICY_BLAST_AREA });
    }

    void HandleTriggerMissile(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Position const* pos = GetExplTargetDest())
            if (TempSummon* summon = GetCaster()->SummonCreature(NPC_ICY_BLAST, *pos, TEMPSUMMON_TIMED_DESPAWN, 40000))
                summon->CastSpell(summon, SPELL_ICY_BLAST_AREA, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_rimefang_icy_blast::HandleTriggerMissile, EFFECT_1, SPELL_EFFECT_TRIGGER_MISSILE);
    }
};

class at_sindragosa_lair : public AreaTriggerScript
{
public:
    at_sindragosa_lair() : AreaTriggerScript("at_sindragosa_lair") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (!instance->GetData(DATA_SPINESTALKER))
                if (Creature* spinestalker = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_SPINESTALKER)))
                    spinestalker->AI()->DoAction(ACTION_START_FROSTWYRM);

            if (!instance->GetData(DATA_RIMEFANG))
                if (Creature* rimefang = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_RIMEFANG)))
                    rimefang->AI()->DoAction(ACTION_START_FROSTWYRM);

            if (!instance->GetData(DATA_SINDRAGOSA_FROSTWYRMS) && instance->GetBossState(DATA_SINDRAGOSA) != IN_PROGRESS)
            {
                player->GetMap()->LoadGrid(SindragosaSpawnPos.GetPositionX(), SindragosaSpawnPos.GetPositionY());
                if (Creature* sindragosa = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_SINDRAGOSA)))
                    sindragosa->AI()->DoAction(ACTION_START_FROSTWYRM);
            }
        }

        return true;
    }
};

/*** TRASH ***/

class npc_sindragosa_trash : public CreatureScript
{
public:
    npc_sindragosa_trash() : CreatureScript("npc_sindragosa_trash") { }

    struct npc_sindragosa_trashAI : public ScriptedAI
    {
        npc_sindragosa_trashAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void InitializeAI() override
        {
            _frostwyrmId = (me->GetHomePosition().GetPositionY() < 2484.35f) ? DATA_RIMEFANG : DATA_SPINESTALKER;
            if (!me->isDead())
            {
                if (me->GetEntry() == NPC_FROSTWING_WHELP)
                    _instance->SetData(_frostwyrmId, me->GetSpawnId());  // this cannot be in Reset because reset also happens on evade
                Reset();
            }
        }

        void Reset() override
        {
            _isTaunted = false;
            _events.Reset();
            if (me->GetEntry() == NPC_FROSTWARDEN_HANDLER)
            {
                _events.ScheduleEvent(EVENT_FROSTWARDEN_ORDER_WHELP, 3s);
                _events.ScheduleEvent(EVENT_CONCUSSIVE_SHOCK, 8s, 10s);
            }
            else
                _events.ScheduleEvent(EVENT_WHELP_FROST_BLAST, 3s, 6s);
        }

        void JustEngagedWith(Unit* who) override
        {
            if (me->GetEntry() == NPC_FROSTWARDEN_HANDLER)
            {
                std::list<Creature*> unitList;
                GetCreatureListWithEntryInGrid(unitList, me, NPC_FROSTWING_WHELP, 40.0f);
                for (std::list<Creature*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                    if (!(*itr)->IsInCombat())
                        (*itr)->AI()->AttackStart(who);
            }
            else
            {
                if (Creature* c = me->FindNearestCreature(NPC_FROSTWARDEN_HANDLER, 40.0f, true))
                    if (!c->IsInCombat())
                        c->AI()->AttackStart(who);
                me->CallForHelp(15.0f);
            }
        }

        void JustRespawned() override
        {
            ScriptedAI::JustRespawned();

            // Increase add count
            if (me->GetEntry() == NPC_FROSTWING_WHELP)
                _instance->SetData(_frostwyrmId, me->GetSpawnId());  // this cannot be in Reset because reset also happens on evade
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_WHELP_MARKER)
                _isTaunted = data != 0;
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_FROSTWYRM_OWNER)
                return _frostwyrmId;
            else if (type == DATA_WHELP_MARKER)
                return uint32(_isTaunted);
            return 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_FROSTWARDEN_ORDER_WHELP:
                    me->CastSpell(me, SPELL_ORDER_WHELP, false);
                    _events.ScheduleEvent(EVENT_FROSTWARDEN_ORDER_WHELP, 3s);
                    break;
                case EVENT_CONCUSSIVE_SHOCK:
                    me->CastSpell(me, SPELL_CONCUSSIVE_SHOCK, false);
                    _events.ScheduleEvent(EVENT_CONCUSSIVE_SHOCK, 10s, 13s);
                    break;
                case EVENT_WHELP_FROST_BLAST:
                    me->CastSpell(me->GetVictim(), 71361, false);
                    _events.ScheduleEvent(EVENT_WHELP_FROST_BLAST, 5s, 8s);
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
        uint32 _frostwyrmId;
        bool _isTaunted; // Frostwing Whelp only
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_sindragosa_trashAI>(creature);
    }
};

class OrderWhelpTargetSelector
{
public:
    explicit OrderWhelpTargetSelector(Creature* owner) : _owner(owner) { }

    bool operator()(Creature* creature)
    {
        if (!creature->AI()->GetData(DATA_WHELP_MARKER) && creature->AI()->GetData(DATA_FROSTWYRM_OWNER) == _owner->AI()->GetData(DATA_FROSTWYRM_OWNER))
            return false;
        return true;
    }

private:
    Creature* _owner;
};

class spell_frostwarden_handler_order_whelp : public SpellScript
{
    PrepareSpellScript(spell_frostwarden_handler_order_whelp);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_FOCUS_FIRE });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
        if (targets.empty())
            return;

        WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(target);
    }

    void HandleForcedCast(SpellEffIndex effIndex)
    {
        // caster is Frostwarden Handler, target is player, caster of triggered is whelp
        PreventHitDefaultEffect(effIndex);
        std::list<Creature*> unitList;
        GetCreatureListWithEntryInGrid(unitList, GetCaster(), NPC_FROSTWING_WHELP, 150.0f);
        if (Creature* creature = GetCaster()->ToCreature())
            unitList.remove_if(OrderWhelpTargetSelector(creature));

        if (unitList.empty())
            return;

        Acore::Containers::SelectRandomContainerElement(unitList)->CastSpell(GetHitUnit(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_frostwarden_handler_order_whelp::HandleForcedCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_frostwarden_handler_order_whelp::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

class spell_frostwarden_handler_focus_fire : public SpellScript
{
    PrepareSpellScript(spell_frostwarden_handler_focus_fire);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->AddThreat(GetHitUnit(), float(GetEffectValue()));
        GetCaster()->GetAI()->SetData(DATA_WHELP_MARKER, 1);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_frostwarden_handler_focus_fire::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_frostwarden_handler_focus_fire_aura : public AuraScript
{
    PrepareAuraScript(spell_frostwarden_handler_focus_fire_aura);

    void PeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
        {
            caster->AddThreat(GetTarget(), -float(GetSpellInfo()->Effects[EFFECT_1].CalcValue()));
            caster->GetAI()->SetData(DATA_WHELP_MARKER, 0);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_frostwarden_handler_focus_fire_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_sindragosa_frost_breath : public SpellScript
{
    PrepareSpellScript(spell_sindragosa_frost_breath);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_UNSATED_CRAVING, SPELL_FROST_IMBUED_BLADE, SPELL_FROST_INFUSION });
    }

    void HandleInfusion()
    {
        Player* target = GetHitPlayer();
        if (!target)
            return;

        // Check difficulty and quest status
        if (!(target->GetRaidDifficulty() & RAID_DIFFICULTY_MASK_25MAN) || target->GetQuestStatus(QUEST_FROST_INFUSION) != QUEST_STATUS_INCOMPLETE)
            return;

        // Check if player has Shadow's Edge equipped and not ready for infusion
        if (!target->HasAura(SPELL_UNSATED_CRAVING) || target->HasAura(SPELL_FROST_IMBUED_BLADE))
            return;

        Aura* infusion = target->GetAura(SPELL_FROST_INFUSION, target->GetGUID());
        if (infusion && infusion->GetStackAmount() >= 3)
        {
            target->RemoveAura(infusion);
            target->CastSpell(target, SPELL_FROST_IMBUED_BLADE, TRIGGERED_FULL_MASK);
        }
        else
            target->CastSpell(target, SPELL_FROST_INFUSION, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_sindragosa_frost_breath::HandleInfusion);
    }
};

void AddSC_boss_sindragosa()
{
    new boss_sindragosa();
    new npc_ice_tomb();
    RegisterSpellScript(spell_sindragosa_s_fury);
    RegisterSpellScript(spell_sindragosa_unchained_magic);
    RegisterSpellScript(spell_sindragosa_permeating_chill_aura);
    RegisterSpellScript(spell_sindragosa_instability_aura);
    RegisterSpellScript(spell_sindragosa_icy_grip);
    RegisterSpellScript(spell_sindragosa_icy_grip_jump);
    RegisterSpellScript(spell_sindragosa_ice_tomb_filter);
    RegisterSpellScriptWithArgs(spell_trigger_spell_from_caster, "spell_sindragosa_ice_tomb", SPELL_ICE_TOMB_DUMMY);
    RegisterSpellScriptWithArgs(spell_trigger_spell_from_caster, "spell_sindragosa_ice_tomb_dummy", SPELL_FROST_BEACON);
    RegisterSpellScript(spell_sindragosa_frost_beacon_aura);
    RegisterSpellAndAuraScriptPair(spell_sindragosa_ice_tomb_trap, spell_sindragosa_ice_tomb_trap_aura);
    RegisterSpellScript(spell_sindragosa_mystic_buffet);
    RegisterSpellScript(spell_sindragosa_soul_preservation_aura);
    new achievement_all_you_can_eat();

    new npc_spinestalker();
    new npc_rimefang();
    RegisterSpellScript(spell_rimefang_icy_blast);
    new at_sindragosa_lair();

    new npc_sindragosa_trash();
    RegisterSpellScript(spell_frostwarden_handler_order_whelp);
    RegisterSpellAndAuraScriptPair(spell_frostwarden_handler_focus_fire, spell_frostwarden_handler_focus_fire_aura);

    RegisterSpellScript(spell_sindragosa_frost_breath);
}
