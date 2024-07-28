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

#include "Unit.h"
#include "AccountMgr.h"
#include "ArenaSpectator.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "CellImpl.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "ChatPackets.h"
#include "ChatTextBuilder.h"
#include "Common.h"
#include "ConditionMgr.h"
#include "Creature.h"
#include "CreatureAIImpl.h"
#include "CreatureGroups.h"
#include "DisableMgr.h"
#include "DynamicVisibility.h"
#include "Formulas.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
#include "InstanceSaveMgr.h"
#include "Log.h"
#include "MapMgr.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "MovementGenerator.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "OutdoorPvP.h"
#include "PassiveAI.h"
#include "Pet.h"
#include "PetAI.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "StringConvert.h"
#include "TargetedMovementGenerator.h"
#include "TemporarySummon.h"
#include "Tokenize.h"
#include "Totem.h"
#include "TotemAI.h"
#include "Transport.h"
#include "UpdateFieldFlags.h"
#include "Util.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldPacket.h"
#include <math.h>

float baseMoveSpeed[MAX_MOVE_TYPE] =
{
    2.5f,                  // MOVE_WALK
    7.0f,                  // MOVE_RUN
    4.5f,                  // MOVE_RUN_BACK
    4.722222f,             // MOVE_SWIM
    2.5f,                  // MOVE_SWIM_BACK
    3.141594f,             // MOVE_TURN_RATE
    7.0f,                  // MOVE_FLIGHT
    4.5f,                  // MOVE_FLIGHT_BACK
    3.14f                  // MOVE_PITCH_RATE
};

float playerBaseMoveSpeed[MAX_MOVE_TYPE] =
{
    2.5f,                  // MOVE_WALK
    7.0f,                  // MOVE_RUN
    4.5f,                  // MOVE_RUN_BACK
    4.722222f,             // MOVE_SWIM
    2.5f,                  // MOVE_SWIM_BACK
    3.141594f,             // MOVE_TURN_RATE
    7.0f,                  // MOVE_FLIGHT
    4.5f,                  // MOVE_FLIGHT_BACK
    3.14f                  // MOVE_PITCH_RATE
};

// Used for prepare can/can`t triggr aura
static bool InitTriggerAuraData();
// Define can trigger auras
static bool isTriggerAura[TOTAL_AURAS];
// Define can't trigger auras (need for disable second trigger)
static bool isNonTriggerAura[TOTAL_AURAS];
// Triggered always, even from triggered spells
static bool isAlwaysTriggeredAura[TOTAL_AURAS];
// Prepare lists
static bool procPrepared = InitTriggerAuraData();

DamageInfo::DamageInfo(Unit* _attacker, Unit* _victim, uint32 _damage, SpellInfo const* _spellInfo, SpellSchoolMask _schoolMask, DamageEffectType _damageType, uint32 cleanDamage)
    : m_attacker(_attacker), m_victim(_victim), m_damage(_damage), m_spellInfo(_spellInfo), m_schoolMask(_schoolMask),
      m_damageType(_damageType), m_attackType(BASE_ATTACK), m_cleanDamage(cleanDamage)
{
    m_absorb = 0;
    m_resist = 0;
    m_block = 0;
}

DamageInfo::DamageInfo(CalcDamageInfo const& dmgInfo) : DamageInfo(DamageInfo(dmgInfo, 0), DamageInfo(dmgInfo, 1))
{
}

DamageInfo::DamageInfo(DamageInfo const& dmg1, DamageInfo const& dmg2)
    : m_attacker(dmg1.m_attacker), m_victim(dmg1.m_victim), m_damage(dmg1.m_damage + dmg2.m_damage), m_spellInfo(dmg1.m_spellInfo), m_schoolMask(SpellSchoolMask(dmg1.m_schoolMask | dmg2.m_schoolMask)),
    m_damageType(dmg1.m_damageType), m_attackType(dmg1.m_attackType), m_absorb(dmg1.m_absorb + dmg2.m_absorb), m_resist(dmg1.m_resist + dmg2.m_resist), m_block(dmg1.m_block),
    m_cleanDamage(dmg1.m_cleanDamage + dmg1.m_cleanDamage)
{
}

DamageInfo::DamageInfo(CalcDamageInfo const& dmgInfo, uint8 damageIndex)
    : m_attacker(dmgInfo.attacker), m_victim(dmgInfo.target), m_damage(dmgInfo.damages[damageIndex].damage), m_spellInfo(nullptr), m_schoolMask(SpellSchoolMask(dmgInfo.damages[damageIndex].damageSchoolMask)),
      m_damageType(DIRECT_DAMAGE), m_attackType(dmgInfo.attackType), m_absorb(dmgInfo.damages[damageIndex].absorb), m_resist(dmgInfo.damages[damageIndex].resist), m_block(dmgInfo.blocked_amount),
      m_cleanDamage(dmgInfo.cleanDamage)
{
}

DamageInfo::DamageInfo(SpellNonMeleeDamage const& spellNonMeleeDamage, DamageEffectType damageType)
    : m_attacker(spellNonMeleeDamage.attacker), m_victim(spellNonMeleeDamage.target), m_damage(spellNonMeleeDamage.damage),
      m_spellInfo(spellNonMeleeDamage.spellInfo), m_schoolMask(SpellSchoolMask(spellNonMeleeDamage.schoolMask)), m_damageType(damageType),
      m_absorb(spellNonMeleeDamage.absorb), m_resist(spellNonMeleeDamage.resist), m_block(spellNonMeleeDamage.blocked),
      m_cleanDamage(spellNonMeleeDamage.cleanDamage)
{
}

void DamageInfo::ModifyDamage(int32 amount)
{
    amount = std::min(amount, int32(GetDamage()));
    m_damage += amount;
}

void DamageInfo::AbsorbDamage(uint32 amount)
{
    amount = std::min(amount, GetDamage());
    m_absorb += amount;
    m_damage -= amount;
}

void DamageInfo::ResistDamage(uint32 amount)
{
    amount = std::min(amount, GetDamage());
    m_resist += amount;
    m_damage -= amount;
}

void DamageInfo::BlockDamage(uint32 amount)
{
    amount = std::min(amount, GetDamage());
    m_block += amount;
    m_damage -= amount;
}

uint32 DamageInfo::GetUnmitigatedDamage() const
{
    return m_damage + m_cleanDamage + m_absorb + m_resist;
}

ProcEventInfo::ProcEventInfo(Unit* actor, Unit* actionTarget, Unit* procTarget, uint32 typeMask, uint32 spellTypeMask, uint32 spellPhaseMask, uint32 hitMask, Spell const* spell, DamageInfo* damageInfo, HealInfo* healInfo, SpellInfo const* triggeredByAuraSpell, int8 procAuraEffectIndex)
    : _actor(actor), _actionTarget(actionTarget), _procTarget(procTarget), _typeMask(typeMask), _spellTypeMask(spellTypeMask), _spellPhaseMask(spellPhaseMask),
      _hitMask(hitMask), _spell(spell), _damageInfo(damageInfo), _healInfo(healInfo), _triggeredByAuraSpell(triggeredByAuraSpell), _procAuraEffectIndex(procAuraEffectIndex)
{
    _chance.reset();
}

SpellInfo const* ProcEventInfo::GetSpellInfo() const
{
    if (_spell)
        return _spell->GetSpellInfo();

    if (_damageInfo)
        return _damageInfo->GetSpellInfo();

    if (_healInfo)
        return _healInfo->GetSpellInfo();

    return nullptr;
}

// we can disable this warning for this since it only
// causes undefined behavior when passed to the base class constructor
#ifdef _MSC_VER
#pragma warning(disable:4355)
#endif
Unit::Unit(bool isWorldObject) : WorldObject(isWorldObject),
    m_movedByPlayer(nullptr),
    m_lastSanctuaryTime(0),
    IsAIEnabled(false),
    NeedChangeAI(false),
    m_ControlledByPlayer(false),
    m_CreatedByPlayer(false),
    movespline(new Movement::MoveSpline()),
    i_AI(nullptr),
    i_disabledAI(nullptr),
    m_realRace(0),
    m_race(0),
    m_AutoRepeatFirstCast(false),
    m_procDeep(0),
    m_removedAurasCount(0),
    i_motionMaster(new MotionMaster(this)),
    m_regenTimer(0),
    m_ThreatMgr(this),
    m_vehicle(nullptr),
    m_vehicleKit(nullptr),
    m_unitTypeMask(UNIT_MASK_NONE),
    m_HostileRefMgr(this),
    m_comboTarget(nullptr),
    m_comboPoints(0)
{
#ifdef _MSC_VER
#pragma warning(default:4355)
#endif
    m_objectType |= TYPEMASK_UNIT;
    m_objectTypeId = TYPEID_UNIT;

    m_updateFlag = (UPDATEFLAG_LIVING | UPDATEFLAG_STATIONARY_POSITION);

    m_attackTimer[BASE_ATTACK] = 0;
    m_attackTimer[OFF_ATTACK] = 0;
    m_attackTimer[RANGED_ATTACK] = 0;
    m_modAttackSpeedPct[BASE_ATTACK] = 1.0f;
    m_modAttackSpeedPct[OFF_ATTACK] = 1.0f;
    m_modAttackSpeedPct[RANGED_ATTACK] = 1.0f;

    m_canDualWield = false;

    m_rootTimes = 0;

    m_state = 0;
    m_deathState = DeathState::Alive;

    for (uint8 i = 0; i < CURRENT_MAX_SPELL; ++i)
        m_currentSpells[i] = nullptr;

    for (uint8 i = 0; i < MAX_SUMMON_SLOT; ++i)
        m_SummonSlot[i].Clear();

    for (uint8 i = 0; i < MAX_GAMEOBJECT_SLOT; ++i)
        m_ObjectSlot[i].Clear();

    m_auraUpdateIterator = m_ownedAuras.end();

    m_interruptMask = 0;
    m_transform = 0;
    m_canModifyStats = false;

    for (uint8 i = 0; i < MAX_SPELL_IMMUNITY; ++i)
        m_spellImmune[i].clear();

    for (uint8 i = 0; i < UNIT_MOD_END; ++i)
    {
        m_auraModifiersGroup[i][BASE_VALUE] = 0.0f;
        m_auraModifiersGroup[i][BASE_PCT] = 1.0f;
        m_auraModifiersGroup[i][TOTAL_VALUE] = 0.0f;
        m_auraModifiersGroup[i][TOTAL_PCT] = 1.0f;
    }
    // implement 50% base damage from offhand
    m_auraModifiersGroup[UNIT_MOD_DAMAGE_OFFHAND][TOTAL_PCT] = 0.5f;

    for (uint8 i = 0; i < MAX_ATTACK; ++i)
    {
        m_weaponDamage[i][MINDAMAGE][0] = BASE_MINDAMAGE;
        m_weaponDamage[i][MAXDAMAGE][0] = BASE_MAXDAMAGE;

        m_weaponDamage[i][MINDAMAGE][1] = 0.f;
        m_weaponDamage[i][MAXDAMAGE][1] = 0.f;
    }

    for (uint8 i = 0; i < MAX_STATS; ++i)
        m_createStats[i] = 0.0f;

    m_attacking = nullptr;
    m_modMeleeHitChance = 0.0f;
    m_modRangedHitChance = 0.0f;
    m_modSpellHitChance = 0.0f;
    m_baseSpellCritChance = 5;

    m_CombatTimer = 0;
    m_lastManaUse = 0;

    for (uint8 i = 0; i < MAX_SPELL_SCHOOL; ++i)
        m_threatModifier[i] = 1.0f;

    for (uint8 i = 0; i < MAX_MOVE_TYPE; ++i)
        m_speed_rate[i] = 1.0f;

    m_charmInfo = nullptr;

    _redirectThreatInfo = RedirectThreatInfo();

    // remove aurastates allowing special moves
    for (uint8 i = 0; i < MAX_REACTIVE; ++i)
        m_reactiveTimer[i] = 0;

    m_cleanupDone = false;
    m_duringRemoveFromWorld = false;

    m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GHOST, GHOST_VISIBILITY_ALIVE);

    m_last_notify_position.Relocate(-5000.0f, -5000.0f, -5000.0f, 0.0f);
    m_last_notify_mstime = 0;
    m_delayed_unit_relocation_timer = 0;
    m_delayed_unit_ai_notify_timer = 0;
    bRequestForcedVisibilityUpdate = false;

    m_applyResilience = false;
    _instantCast = false;

    _lastLiquid = nullptr;

    _oldFactionId = 0;

    _isWalkingBeforeCharm = false;

    _lastExtraAttackSpell = 0;
}

////////////////////////////////////////////////////////////
// Methods of class GlobalCooldownMgr
bool GlobalCooldownMgr::HasGlobalCooldown(SpellInfo const* spellInfo) const
{
    GlobalCooldownList::const_iterator itr = m_GlobalCooldowns.find(spellInfo->StartRecoveryCategory);
    return itr != m_GlobalCooldowns.end() && itr->second.duration && getMSTimeDiff(itr->second.cast_time, GameTime::GetGameTimeMS().count()) < itr->second.duration;
}

void GlobalCooldownMgr::AddGlobalCooldown(SpellInfo const* spellInfo, uint32 gcd)
{
    m_GlobalCooldowns[spellInfo->StartRecoveryCategory] = GlobalCooldown(gcd, GameTime::GetGameTimeMS().count());
}

void GlobalCooldownMgr::CancelGlobalCooldown(SpellInfo const* spellInfo)
{
    m_GlobalCooldowns[spellInfo->StartRecoveryCategory].duration = 0;
}

////////////////////////////////////////////////////////////
// Methods of class Unit
Unit::~Unit()
{
    // set current spells as deletable
    for (uint8 i = 0; i < CURRENT_MAX_SPELL; ++i)
        if (m_currentSpells[i])
        {
            m_currentSpells[i]->SetReferencedFromCurrent(false);
            m_currentSpells[i] = nullptr;
        }

    _DeleteRemovedAuras();

    delete i_motionMaster;
    delete m_charmInfo;
    delete movespline;

    ASSERT(!m_duringRemoveFromWorld);
    ASSERT(!m_attacking);
    ASSERT(m_attackers.empty());

    // pussywizard: clear m_sharedVision along with back references
    if (!m_sharedVision.empty())
    {
        do
        {
            Player* p = *(m_sharedVision.begin());
            p->m_isInSharedVisionOf.erase(this);
            m_sharedVision.remove(p);
        } while (!m_sharedVision.empty());
    }

    ASSERT(m_Controlled.empty());
    ASSERT(m_appliedAuras.empty());
    ASSERT(m_ownedAuras.empty());
    ASSERT(m_removedAuras.empty());
    ASSERT(m_gameObj.empty());
    ASSERT(m_dynObj.empty());

    if (m_movedByPlayer && m_movedByPlayer != this)
        LOG_INFO("misc", "Unit::~Unit (A1)");

    HandleSafeUnitPointersOnDelete(this);
}

void Unit::Update(uint32 p_time)
{
    sScriptMgr->OnUnitUpdate(this, p_time);

    // WARNING! Order of execution here is important, do not change.
    // Spells must be processed with event system BEFORE they go to _UpdateSpells.
    // Or else we may have some SPELL_STATE_FINISHED spells stalled in pointers, that is bad.
    m_Events.Update(p_time);

    if (!IsInWorld())
        return;

    // pussywizard:
    if (GetTypeId() != TYPEID_PLAYER || (!ToPlayer()->IsBeingTeleported() && !bRequestForcedVisibilityUpdate))
    {
        if (m_delayed_unit_relocation_timer)
        {
            if (m_delayed_unit_relocation_timer <= p_time)
            {
                m_delayed_unit_relocation_timer = 0;
                //ExecuteDelayedUnitRelocationEvent();
                FindMap()->i_objectsForDelayedVisibility.insert(this);
            }
            else
                m_delayed_unit_relocation_timer -= p_time;
        }
        if (m_delayed_unit_ai_notify_timer)
        {
            if (m_delayed_unit_ai_notify_timer <= p_time)
            {
                m_delayed_unit_ai_notify_timer = 0;
                ExecuteDelayedUnitAINotifyEvent();
            }
            else
                m_delayed_unit_ai_notify_timer -= p_time;
        }
    }

    _UpdateSpells( p_time );

    if (CanHaveThreatList() && GetThreatMgr().isNeedUpdateToClient(p_time))
        SendThreatListUpdate();

    // update combat timer only for players and pets (only pets with PetAI)
    if (IsInCombat() && (GetTypeId() == TYPEID_PLAYER || ((IsPet() || HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN)) && IsControlledByPlayer())))
    {
        // Check UNIT_STATE_MELEE_ATTACKING or UNIT_STATE_CHASE (without UNIT_STATE_FOLLOW in this case) so pets can reach far away
        // targets without stopping half way there and running off.
        // These flags are reset after target dies or another command is given.
        if (m_HostileRefMgr.IsEmpty())
        {
            // m_CombatTimer set at aura start and it will be freeze until aura removing
            if (m_CombatTimer <= p_time)
                ClearInCombat();
            else
                m_CombatTimer -= p_time;
        }
    }

    _lastDamagedTargetGuid = ObjectGuid::Empty;
    if (_lastExtraAttackSpell)
    {
        while (!extraAttacksTargets.empty())
        {
            auto itr = extraAttacksTargets.begin();
            ObjectGuid targetGuid = itr->first;
            uint32 count = itr->second;
            extraAttacksTargets.erase(itr);
            if (Unit* victim = ObjectAccessor::GetUnit(*this, targetGuid))
            {
                if (_lastExtraAttackSpell == SPELL_SWORD_SPECIALIZATION || _lastExtraAttackSpell == SPELL_HACK_AND_SLASH
                    || victim->IsWithinMeleeRange(this))
                {
                    HandleProcExtraAttackFor(victim, count);
                }
            }
        }
        _lastExtraAttackSpell = 0;
    }

    // not implemented before 3.0.2
    // xinef: if attack time > 0, reduce by diff
    // if on next update, attack time < 0 assume player didnt attack - set to 0
    bool suspendAttackTimer = false;
    bool suspendRangedAttackTimer = false;
    if (IsPlayer() && HasUnitState(UNIT_STATE_CASTING))
    {
        for (Spell* spell : m_currentSpells)
        {
            if (spell)
            {
                if (spell->GetSpellInfo()->HasAttribute(SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS))
                {
                    if (spell->IsChannelActive())
                    {
                        suspendRangedAttackTimer = true;
                    }

                    suspendAttackTimer = true;
                    break;
                }
            }
        }
    }

    if (!suspendAttackTimer)
    {
        if (int32 base_attack = getAttackTimer(BASE_ATTACK))
        {
            setAttackTimer(BASE_ATTACK, base_attack > 0 ? base_attack - (int32) p_time : 0);
        }

        if (int32 off_attack = getAttackTimer(OFF_ATTACK))
        {
            setAttackTimer(OFF_ATTACK, off_attack > 0 ? off_attack - (int32) p_time : 0);
        }
    }

    if (!suspendRangedAttackTimer)
    {
        if (int32 ranged_attack = getAttackTimer(RANGED_ATTACK))
        {
            setAttackTimer(RANGED_ATTACK, ranged_attack > 0 ? ranged_attack - (int32)p_time : 0);
        }
    }

    // update abilities available only for fraction of time
    UpdateReactives(p_time);

    ModifyAuraState(AURA_STATE_HEALTHLESS_20_PERCENT, IsAlive() ? HealthBelowPct(20) : false);
    ModifyAuraState(AURA_STATE_HEALTHLESS_35_PERCENT, IsAlive() ? HealthBelowPct(35) : false);
    ModifyAuraState(AURA_STATE_HEALTH_ABOVE_75_PERCENT, IsAlive() ? HealthAbovePct(75) : false);

    UpdateSplineMovement(p_time);
    GetMotionMaster()->UpdateMotion(p_time);

    InvalidateValuesUpdateCache();
}

bool Unit::haveOffhandWeapon() const
{
    if (Player const* player = ToPlayer())
        return player->GetWeaponForAttack(OFF_ATTACK, true);

    return CanDualWield();
}

void Unit::MonsterMoveWithSpeed(float x, float y, float z, float speed)
{
    Movement::MoveSplineInit init(this);
    init.MoveTo(x, y, z);
    init.SetVelocity(speed);
    init.Launch();
}

void Unit::SendMonsterMove(float NewPosX, float NewPosY, float NewPosZ, uint32 TransitTime, SplineFlags sf)
{
    WorldPacket data(SMSG_MONSTER_MOVE, 1 + 12 + 4 + 1 + 4 + 4 + 4 + 12 + GetPackGUID().size());
    data << GetPackGUID();

    data << uint8(0);                                       // new in 3.1
    data << GetPositionX() << GetPositionY() << GetPositionZ();
    data << GameTime::GetGameTimeMS().count();
    data << uint8(0);
    data << uint32(sf);
    data << TransitTime;                                           // Time in between points
    data << uint32(1);                                      // 1 single waypoint
    data << NewPosX << NewPosY << NewPosZ;                  // the single waypoint Point B

    SendMessageToSet(&data, true);
}

class SplineHandler
{
public:
    SplineHandler(Unit* unit) : _unit(unit) { }

    bool operator()(Movement::MoveSpline::UpdateResult result)
    {
        if ((result & (Movement::MoveSpline::Result_NextSegment | Movement::MoveSpline::Result_JustArrived)) &&
                _unit->GetTypeId() == TYPEID_UNIT && _unit->GetMotionMaster()->GetCurrentMovementGeneratorType() == ESCORT_MOTION_TYPE &&
                _unit->movespline->GetId() == _unit->GetMotionMaster()->GetCurrentSplineId())
        {
            _unit->ToCreature()->AI()->MovementInform(ESCORT_MOTION_TYPE, _unit->movespline->currentPathIdx() - 1);
        }

        return true;
    }

private:
    Unit* _unit;
};

void Unit::UpdateSplineMovement(uint32 t_diff)
{
    if (movespline->Finalized())
        return;

    // xinef: process movementinform
    // this code cant be placed inside EscortMovementGenerator, because we cant delete active MoveGen while it is updated
    SplineHandler handler(this);
    movespline->updateState(t_diff, handler);
    // Xinef: Spline was cleared by StopMoving, return
    if (!movespline->Initialized())
    {
        DisableSpline();
        return;
    }

    bool arrived = movespline->Finalized();

    if (arrived)
    {
        DisableSpline();

        if (movespline->HasAnimation() && GetTypeId() == TYPEID_UNIT && IsAlive())
            SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, movespline->GetAnimationType());
    }

    // pussywizard: update always! not every 400ms, because movement generators need the actual position
    //m_movesplineTimer.Update(t_diff);
    //if (m_movesplineTimer.Passed() || arrived)
    UpdateSplinePosition();
}

void Unit::UpdateSplinePosition()
{
    //static uint32 const positionUpdateDelay = 400;

    //m_movesplineTimer.Reset(positionUpdateDelay);
    Movement::Location loc = movespline->ComputePosition();

    if (movespline->onTransport)
    {
        Position& pos = m_movementInfo.transport.pos;
        pos.m_positionX = loc.x;
        pos.m_positionY = loc.y;
        pos.m_positionZ = loc.z;
        pos.SetOrientation(loc.orientation);

        if (TransportBase* transport = GetDirectTransport())
            transport->CalculatePassengerPosition(loc.x, loc.y, loc.z, &loc.orientation);
    }

    // Xinef: if we had spline running update orientation along with position
    //if (HasUnitState(UNIT_STATE_CANNOT_TURN))
    //    loc.orientation = GetOrientation();

    if (GetTypeId() == TYPEID_PLAYER)
        UpdatePosition(loc.x, loc.y, loc.z, loc.orientation);
    else
        ToCreature()->SetPosition(loc.x, loc.y, loc.z, loc.orientation);
}

void Unit::DisableSpline()
{
    m_movementInfo.RemoveMovementFlag(MovementFlags(MOVEMENTFLAG_SPLINE_ENABLED | MOVEMENTFLAG_FORWARD | MOVEMENTFLAG_BACKWARD));
    movespline->_Interrupt();
}

void Unit::resetAttackTimer(WeaponAttackType type)
{
    int32 time = int32(GetAttackTime(type) * m_modAttackSpeedPct[type]);
    m_attackTimer[type] = std::min(m_attackTimer[type] + time, time);
}

bool Unit::IsWithinCombatRange(Unit const* obj, float dist2compare) const
{
    if (!obj || !IsInMap(obj) || !InSamePhase(obj))
        return false;

    float dx = GetPositionX() - obj->GetPositionX();
    float dy = GetPositionY() - obj->GetPositionY();
    float dz = GetPositionZ() - obj->GetPositionZ();
    float distsq = dx * dx + dy * dy + dz * dz;

    float sizefactor = GetCombatReach() + obj->GetCombatReach();
    float maxdist = dist2compare + sizefactor;

    return distsq < maxdist * maxdist;
}

bool Unit::IsWithinMeleeRange(Unit const* obj, float dist) const
{
    if (!obj || !IsInMap(obj) || !InSamePhase(obj))
        return false;

    float dx = GetPositionX() - obj->GetPositionX();
    float dy = GetPositionY() - obj->GetPositionY();
    float dz = GetPositionZ() - obj->GetPositionZ();
    float distsq = dx * dx + dy * dy + dz * dz;

    float maxdist = dist + GetMeleeRange(obj);

    return distsq < maxdist * maxdist;
}

float Unit::GetMeleeRange(Unit const* target) const
{
    float range = GetCombatReach() + target->GetCombatReach() + 4.0f / 3.0f;
    return std::max(range, NOMINAL_MELEE_RANGE);
}

bool Unit::IsWithinRange(Unit const* obj, float dist) const
{
    if (!obj || !IsInMap(obj) || !InSamePhase(obj))
    {
        return false;
    }

    auto dx = GetPositionX() - obj->GetPositionX();
    auto dy = GetPositionY() - obj->GetPositionY();
    auto dz = GetPositionZ() - obj->GetPositionZ();
    auto distsq = dx * dx + dy * dy + dz * dz;

    return distsq <= dist * dist;
}

bool Unit::GetRandomContactPoint(Unit const* obj, float& x, float& y, float& z, bool force) const
{
    float combat_reach = GetCombatReach();
    if (combat_reach < 0.1f) // sometimes bugged for players
        combat_reach = DEFAULT_COMBAT_REACH;

    uint32 attacker_number = getAttackers().size();
    if (attacker_number > 0)
        --attacker_number;
    Creature const* c = obj->ToCreature();
    if (c)
        if (c->isWorldBoss() || c->IsDungeonBoss() || (obj->IsPet() && const_cast<Unit*>(obj)->ToPet()->isControlled()))
            attacker_number = 0; // pussywizard: pets and bosses just come to target from their angle

    GetNearPoint(obj, x, y, z, isMoving() ? (obj->GetCombatReach() > 7.75f ? obj->GetCombatReach() - 7.5f : 0.25f) : obj->GetCombatReach(), 0.0f,
                 GetAngle(obj) + (attacker_number ? (static_cast<float>(M_PI / 2) - static_cast<float>(M_PI) * (float)rand_norm()) * float(attacker_number) / combat_reach * 0.3f : 0));

    // pussywizard
    if (std::fabs(this->GetPositionZ() - z) > this->GetCollisionHeight() || !IsWithinLOS(x, y, z))
    {
        x = this->GetPositionX();
        y = this->GetPositionY();
        z = this->GetPositionZ();
        obj->UpdateAllowedPositionZ(x, y, z);
    }
    float maxDist = GetMeleeRange(obj);
    if (GetExactDistSq(x, y, z) >= maxDist * maxDist)
    {
        if (force)
        {
            x = this->GetPositionX();
            y = this->GetPositionY();
            z = this->GetPositionZ();
            return true;
        }
        return false;
    }
    return true;
}

void Unit::UpdateInterruptMask()
{
    m_interruptMask = 0;
    for (AuraApplicationList::const_iterator i = m_interruptableAuras.begin(); i != m_interruptableAuras.end(); ++i)
        m_interruptMask |= (*i)->GetBase()->GetSpellInfo()->AuraInterruptFlags;

    if (Spell* spell = m_currentSpells[CURRENT_CHANNELED_SPELL])
        if (spell->getState() == SPELL_STATE_CASTING)
            m_interruptMask |= spell->m_spellInfo->ChannelInterruptFlags;
}

bool Unit::HasAuraTypeWithFamilyFlags(AuraType auraType, uint32 familyName, uint32 familyFlags) const
{
    if (!HasAuraType(auraType))
        return false;
    AuraEffectList const& auras = GetAuraEffectsByType(auraType);
    for (AuraEffectList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
        if (SpellInfo const* iterSpellProto = (*itr)->GetSpellInfo())
            if (iterSpellProto->SpellFamilyName == familyName && iterSpellProto->SpellFamilyFlags[0] & familyFlags)
                return true;
    return false;
}

bool Unit::HasBreakableByDamageAuraType(AuraType type, uint32 excludeAura) const
{
    AuraEffectList const& auras = GetAuraEffectsByType(type);
    for (AuraEffectList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
        if ((!excludeAura || excludeAura != (*itr)->GetSpellInfo()->Id) && //Avoid self interrupt of channeled Crowd Control spells like Seduction
                ((*itr)->GetSpellInfo()->AuraInterruptFlags & AURA_INTERRUPT_FLAG_TAKE_DAMAGE))
            return true;
    return false;
}

bool Unit::HasBreakableByDamageCrowdControlAura(Unit* excludeCasterChannel) const
{
    uint32 excludeAura = 0;
    if (Spell* currentChanneledSpell = excludeCasterChannel ? excludeCasterChannel->GetCurrentSpell(CURRENT_CHANNELED_SPELL) : nullptr)
        excludeAura = currentChanneledSpell->GetSpellInfo()->Id; //Avoid self interrupt of channeled Crowd Control spells like Seduction

    return (   HasBreakableByDamageAuraType(SPELL_AURA_MOD_CONFUSE, excludeAura)
               || HasBreakableByDamageAuraType(SPELL_AURA_MOD_FEAR, excludeAura)
               || HasBreakableByDamageAuraType(SPELL_AURA_MOD_STUN, excludeAura)
               || HasBreakableByDamageAuraType(SPELL_AURA_MOD_ROOT, excludeAura)
               || HasBreakableByDamageAuraType(SPELL_AURA_TRANSFORM, excludeAura));
}

void Unit::DealDamageMods(Unit const* victim, uint32& damage, uint32* absorb)
{
    if (!victim || !victim->IsAlive() || victim->IsInFlight() || (victim->GetTypeId() == TYPEID_UNIT && victim->ToCreature()->IsEvadingAttacks()))
    {
        if (absorb)
            *absorb += damage;
        damage = 0;
    }
}

uint32 Unit::DealDamage(Unit* attacker, Unit* victim, uint32 damage, CleanDamage const* cleanDamage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask, SpellInfo const* spellProto, bool durabilityLoss, bool /*allowGM*/, Spell const* damageSpell /*= nullptr*/)
{
    // Xinef: initialize damage done for rage calculations
    // Xinef: its rare to modify damage in hooks, however training dummy's sets damage to 0
    uint32 rage_damage = damage + ((cleanDamage != nullptr) ? cleanDamage->absorbed_damage : 0);

    //if (attacker)
    {
        if (victim->IsAIEnabled)
            victim->GetAI()->DamageTaken(attacker, damage, damagetype, damageSchoolMask);

        if (attacker && attacker->IsAIEnabled)
            attacker->GetAI()->DamageDealt(victim, damage, damagetype);
    }

    // Hook for OnDamage Event
    sScriptMgr->OnDamage(attacker, victim, damage);

    if (victim->GetTypeId() == TYPEID_PLAYER && attacker != victim)
    {
        // Signal to pets that their owner was attacked
        Pet* pet = victim->ToPlayer()->GetPet();

        if (pet && pet->IsAlive())
            pet->AI()->OwnerAttackedBy(attacker);
    }

    //Dont deal damage to unit if .cheat god is enable.
    if (victim->GetTypeId() == TYPEID_PLAYER)
    {
        if (victim->ToPlayer()->GetCommandStatus(CHEAT_GOD))
        {
            return 0;
        }
    }

    // Signal the pet it was attacked so the AI can respond if needed
    if (victim->GetTypeId() == TYPEID_UNIT && attacker != victim && victim->IsPet() && victim->IsAlive())
        victim->ToPet()->AI()->AttackedBy(attacker);

    if (damagetype != NODAMAGE)
    {
        // interrupting auras with AURA_INTERRUPT_FLAG_DAMAGE before checking !damage (absorbed damage breaks that type of auras)
        if (spellProto)
        {
            if (!spellProto->HasAttribute(SPELL_ATTR4_REACTIVE_DAMAGE_PROC))
                victim->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TAKE_DAMAGE, spellProto->Id);
        }
        else
            victim->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TAKE_DAMAGE, 0);

        // interrupt spells with SPELL_INTERRUPT_FLAG_ABORT_ON_DMG on absorbed damage (no dots)
        if (!damage && damagetype != DOT && cleanDamage && cleanDamage->absorbed_damage)
        {
            if (victim != attacker && victim->GetTypeId() == TYPEID_PLAYER)
            {
                if (Spell* spell = victim->m_currentSpells[CURRENT_GENERIC_SPELL])
                {
                    if (spell->getState() == SPELL_STATE_PREPARING)
                    {
                        uint32 interruptFlags = spell->m_spellInfo->InterruptFlags;
                        if (interruptFlags & SPELL_INTERRUPT_FLAG_ABORT_ON_DMG)
                        {
                            victim->InterruptNonMeleeSpells(false);
                        }
                    }
                }
            }
        }

        // We're going to call functions which can modify content of the list during iteration over it's elements
        // Let's copy the list so we can prevent iterator invalidation
        AuraEffectList vCopyDamageCopy(victim->GetAuraEffectsByType(SPELL_AURA_SHARE_DAMAGE_PCT));
        // copy damage to casters of this aura
        for (AuraEffectList::iterator i = vCopyDamageCopy.begin(); i != vCopyDamageCopy.end(); ++i)
        {
            // Check if aura was removed during iteration - we don't need to work on such auras
            if (!((*i)->GetBase()->IsAppliedOnTarget(victim->GetGUID())))
                continue;
            // check damage school mask
            if (((*i)->GetMiscValue() & damageSchoolMask) == 0)
                continue;

            Unit* shareDamageTarget = (*i)->GetCaster();
            if (!shareDamageTarget)
                continue;
            SpellInfo const* spell = (*i)->GetSpellInfo();

            uint32 shareDamage = CalculatePct(damage, (*i)->GetAmount());

            uint32 shareAbsorb = 0;
            uint32 shareResist = 0;

            if (shareDamageTarget->IsImmunedToDamageOrSchool(damageSchoolMask))
            {
                shareAbsorb = shareDamage;
                shareDamage = 0;
            }
            else
            {
                DamageInfo sharedDamageInfo(attacker, shareDamageTarget, shareDamage, spellProto, damageSchoolMask, damagetype);
                Unit::CalcAbsorbResist(sharedDamageInfo, true);
                shareAbsorb = sharedDamageInfo.GetAbsorb();
                shareResist = sharedDamageInfo.GetResist();
                shareDamage = sharedDamageInfo.GetDamage();
                Unit::DealDamageMods(shareDamageTarget, shareDamage, &shareAbsorb);
            }

            if (attacker && shareDamageTarget->GetTypeId() == TYPEID_PLAYER)
            {
                attacker->SendSpellNonMeleeDamageLog(shareDamageTarget, spell, shareDamage, damageSchoolMask, shareAbsorb, shareResist, damagetype == DIRECT_DAMAGE, 0, false, true);
            }

            Unit::DealDamage(attacker, shareDamageTarget, shareDamage, cleanDamage, NODAMAGE, damageSchoolMask, spellProto, false, false, damageSpell);
        }
    }

    // Rage from Damage made (only from direct weapon damage)
    if (attacker && cleanDamage && damagetype == DIRECT_DAMAGE && attacker != victim && attacker->HasActivePowerType(POWER_RAGE))
    {
        uint32 weaponSpeedHitFactor;

        switch (cleanDamage->attackType)
        {
            case BASE_ATTACK:
            case OFF_ATTACK:
                {
                    weaponSpeedHitFactor = uint32(attacker->GetAttackTime(cleanDamage->attackType) / 1000.0f * (cleanDamage->attackType == BASE_ATTACK ? 3.5f : 1.75f));
                    if (cleanDamage->hitOutCome == MELEE_HIT_CRIT)
                        weaponSpeedHitFactor *= 2;

                    attacker->RewardRage(rage_damage, weaponSpeedHitFactor, true);
                    break;
                }
            case RANGED_ATTACK:
                break;
            default:
                break;
        }
    }

    if (!damage)
    {
        // Rage from absorbed damage
        if (cleanDamage && cleanDamage->absorbed_damage)
        {
            if (victim->HasActivePowerType(POWER_RAGE))
                victim->RewardRage(cleanDamage->absorbed_damage, 0, false);

            if (attacker && attacker->HasActivePowerType(POWER_RAGE))
                attacker->RewardRage(cleanDamage->absorbed_damage, 0, true);
        }

        return 0;
    }

    LOG_DEBUG("entities.unit", "DealDamageStart");

    uint32 health = victim->GetHealth();
    LOG_DEBUG("entities.unit", "deal dmg:{} to health:{} ", damage, health);

    // duel ends when player has 1 or less hp
    bool duel_hasEnded = false;
    bool duel_wasMounted = false;
    if (victim->GetTypeId() == TYPEID_PLAYER && victim->ToPlayer()->duel && damage >= (health - 1))
    {
        // xinef: situation not possible earlier, just return silently.
        if (!attacker)
            return 0;

        // prevent kill only if killed in duel and killed by opponent or opponent controlled creature
        if (victim->ToPlayer()->duel->Opponent == attacker || victim->ToPlayer()->duel->Opponent->GetGUID() == attacker->GetOwnerGUID())
            damage = health - 1;

        duel_hasEnded = true;
    }
    else if (victim->IsVehicle() && damage >= (health - 1) && victim->GetCharmer() && victim->GetCharmer()->GetTypeId() == TYPEID_PLAYER)
    {
        Player* victimRider = victim->GetCharmer()->ToPlayer();

        if (victimRider && victimRider->duel && victimRider->duel->IsMounted)
        {
            // xinef: situation not possible earlier, just return silently.
            if (!attacker)
                return 0;

            // prevent kill only if killed in duel and killed by opponent or opponent controlled creature
            if (victimRider->duel->Opponent == attacker || victimRider->duel->Opponent->GetGUID() == attacker->GetCharmerGUID())
                damage = health - 1;

            duel_wasMounted = true;
            duel_hasEnded = true;
        }
    }

    if (attacker && attacker != victim)
        if (Player* killer = attacker->GetCharmerOrOwnerPlayerOrPlayerItself())
        {
            // pussywizard: don't allow GMs to deal damage in normal way (this leaves no evidence in logs!), they have commands to do so
            //if (!allowGM && killer->GetSession()->GetSecurity() && killer->GetSession()->GetSecurity() <= SEC_ADMINISTRATOR)
            //  return 0;

            if (Battleground* bg = killer->GetBattleground())
            {
                bg->UpdatePlayerScore(killer, SCORE_DAMAGE_DONE, damage);
                killer->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_DAMAGE_DONE, damage, 0, victim); // pussywizard: InBattleground() optimization
            }
            //killer->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HIT_DEALT, damage); // pussywizard: optimization
        }

    if (victim->GetTypeId() == TYPEID_PLAYER)
        ;//victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HIT_RECEIVED, damage); // pussywizard: optimization
    else if (!victim->IsControlledByPlayer() || victim->IsVehicle())
    {
        if (!victim->ToCreature()->hasLootRecipient())
            victim->ToCreature()->SetLootRecipient(attacker);

        if (!attacker || attacker->IsControlledByPlayer() || attacker->IsCreatedByPlayer())
        {
            uint32 unDamage = health < damage ? health : damage;
            bool damagedByPlayer = unDamage && attacker && (attacker->IsPlayer() || attacker->m_movedByPlayer != nullptr);
            victim->ToCreature()->LowerPlayerDamageReq(unDamage, damagedByPlayer);
        }
    }

    if (health <= damage)
    {
        LOG_DEBUG("entities.unit", "DealDamage: victim just died");

        //if (attacker && victim->GetTypeId() == TYPEID_PLAYER && victim != attacker)
        //victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_TOTAL_DAMAGE_RECEIVED, health); // pussywizard: optimization
        Unit::Kill(attacker, victim, durabilityLoss, cleanDamage ? cleanDamage->attackType : BASE_ATTACK, spellProto, damageSpell);
    }
    else
    {
        LOG_DEBUG("entities.unit", "DealDamageAlive");

        //if (victim->GetTypeId() == TYPEID_PLAYER)
        //    victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_TOTAL_DAMAGE_RECEIVED, damage); // pussywizard: optimization

        victim->ModifyHealth(- (int32)damage);

        if (damagetype == DIRECT_DAMAGE || damagetype == SPELL_DIRECT_DAMAGE)
            victim->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_DIRECT_DAMAGE, spellProto ? spellProto->Id : 0);

        if (victim->GetTypeId() != TYPEID_PLAYER)
        {
            // Part of Evade mechanics. DoT's and Thorns / Retribution Aura do not contribute to this
            if (damagetype != DOT && damage > 0 && !victim->GetOwnerGUID().IsPlayer() && (!spellProto || !spellProto->HasAura(SPELL_AURA_DAMAGE_SHIELD)))
                victim->ToCreature()->SetLastDamagedTime(GameTime::GetGameTime().count() + MAX_AGGRO_RESET_TIME);

            if (attacker)
            {
                if (spellProto && victim->CanHaveThreatList() && !victim->HasUnitState(UNIT_STATE_EVADE) && !victim->IsInCombatWith(attacker))
                {
                    victim->CombatStart(attacker, !(spellProto->AttributesEx3 & SPELL_ATTR3_SUPRESS_TARGET_PROCS));
                }

                victim->AddThreat(attacker, float(damage), damageSchoolMask, spellProto);
            }
        }
        else                                                // victim is a player
        {
            // random durability for items (HIT TAKEN)
            if (roll_chance_f(sWorld->getRate(RATE_DURABILITY_LOSS_DAMAGE)))
            {
                EquipmentSlots slot = EquipmentSlots(urand(0, EQUIPMENT_SLOT_END - 1));
                victim->ToPlayer()->DurabilityPointLossForEquipSlot(slot);
            }
        }

        // Rage from damage received
        if (attacker != victim && victim->HasActivePowerType(POWER_RAGE))
        {
            uint32 rageDamage = damage + (cleanDamage ? cleanDamage->absorbed_damage : 0);
            victim->RewardRage(rageDamage, 0, false);
        }

        if (attacker && attacker->GetTypeId() == TYPEID_PLAYER)
        {
            // random durability for items (HIT DONE)
            if (roll_chance_f(sWorld->getRate(RATE_DURABILITY_LOSS_DAMAGE)))
            {
                EquipmentSlots slot = EquipmentSlots(urand(0, EQUIPMENT_SLOT_END - 1));
                attacker->ToPlayer()->DurabilityPointLossForEquipSlot(slot);
            }
        }

        if (damagetype != NODAMAGE && damage && (!spellProto || !(spellProto->HasAttribute(SPELL_ATTR3_TREAT_AS_PERIODIC) || spellProto->HasAttribute(SPELL_ATTR7_DONT_CAUSE_SPELL_PUSHBACK))))
        {
            if (victim != attacker && victim->GetTypeId() == TYPEID_PLAYER) // does not support creature push_back
            {
                if (damagetype != DOT && !(damageSpell && damageSpell->m_targets.HasDstChannel()))
                {
                    if (Spell* spell = victim->m_currentSpells[CURRENT_GENERIC_SPELL])
                    {
                        if (spell->getState() == SPELL_STATE_PREPARING)
                        {
                            uint32 interruptFlags = spell->m_spellInfo->InterruptFlags;
                            if (interruptFlags & SPELL_INTERRUPT_FLAG_ABORT_ON_DMG)
                            {
                                victim->InterruptNonMeleeSpells(false);
                            }
                            else if (interruptFlags & SPELL_INTERRUPT_FLAG_PUSH_BACK)
                            {
                                spell->Delayed();
                            }
                        }
                    }

                    if (Spell* spell = victim->m_currentSpells[CURRENT_CHANNELED_SPELL])
                        if (spell->getState() == SPELL_STATE_CASTING)
                        {
                            if ((spell->m_spellInfo->ChannelInterruptFlags & CHANNEL_FLAG_DELAY) != 0)
                            {
                                spell->DelayedChannel();
                            }
                        }
                }
            }
        }

        // last damage from duel opponent
        if (duel_hasEnded)
        {
            Player* he = duel_wasMounted ? victim->GetCharmer()->ToPlayer() : victim->ToPlayer();

            ASSERT_NODEBUGINFO(he && he->duel);

            if (duel_wasMounted) // In this case victim==mount
                victim->SetHealth(1);
            else
                he->SetHealth(1);

            he->duel->Opponent->CombatStopWithPets(true);
            he->CombatStopWithPets(true);

            he->CastSpell(he, 7267, true);                  // beg
            he->DuelComplete(DUEL_WON);
        }
    }

    LOG_DEBUG("entities.unit", "DealDamageEnd returned {} damage", damage);

    return damage;
}

void Unit::CastStop(uint32 except_spellid, bool withInstant)
{
    for (uint32 i = CURRENT_FIRST_NON_MELEE_SPELL; i < CURRENT_MAX_SPELL; i++)
        if (m_currentSpells[i] && m_currentSpells[i]->m_spellInfo->Id != except_spellid)
            InterruptSpell(CurrentSpellTypes(i), false, withInstant);
}

SpellCastResult Unit::CastSpell(SpellCastTargets const& targets, SpellInfo const* spellInfo, CustomSpellValues const* value, TriggerCastFlags triggerFlags, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    if (!spellInfo)
    {
        LOG_ERROR("entities.unit", "CastSpell: unknown spell by caster {}", GetGUID().ToString());
        return SPELL_FAILED_SPELL_UNAVAILABLE;
    }

    /// @todo: this is a workaround - not needed anymore, but required for some scripts :(
    if (!originalCaster && triggeredByAura)
    {
        originalCaster = triggeredByAura->GetCasterGUID();
    }

    Spell* spell = new Spell(this, spellInfo, triggerFlags, originalCaster);

    if (value)
    {
        for (CustomSpellValues::const_iterator itr = value->begin(); itr != value->end(); ++itr)
        {
            spell->SetSpellValue(itr->first, itr->second);
        }
    }

    spell->m_CastItem = castItem;
    return spell->prepare(&targets, triggeredByAura);
}

SpellCastResult Unit::CastSpell(Unit* victim, uint32 spellId, bool triggered, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    return CastSpell(victim, spellId, triggered ? TRIGGERED_FULL_MASK : TRIGGERED_NONE, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastSpell(Unit* victim, uint32 spellId, TriggerCastFlags triggerFlags /*= TRIGGER_NONE*/, Item* castItem /*= nullptr*/, AuraEffect const* triggeredByAura /*= nullptr*/, ObjectGuid originalCaster /*= ObjectGuid::Empty*/)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        LOG_ERROR("entities.unit", "CastSpell: unknown spell {} by caster {}", spellId, GetGUID().ToString());
        return SPELL_FAILED_SPELL_UNAVAILABLE;
    }

    return CastSpell(victim, spellInfo, triggerFlags, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastSpell(Unit* victim, SpellInfo const* spellInfo, bool triggered, Item* castItem/*= nullptr*/, AuraEffect const* triggeredByAura /*= nullptr*/, ObjectGuid originalCaster /*= ObjectGuid::Empty*/)
{
    return CastSpell(victim, spellInfo, triggered ? TRIGGERED_FULL_MASK : TRIGGERED_NONE, castItem, triggeredByAura, originalCaster);
}

SpellCastResult  Unit::CastSpell(Unit* victim, SpellInfo const* spellInfo, TriggerCastFlags triggerFlags, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    SpellCastTargets targets;
    targets.SetUnitTarget(victim);
    return CastSpell(targets, spellInfo, nullptr, triggerFlags, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastCustomSpell(Unit* target, uint32 spellId, int32 const* bp0, int32 const* bp1, int32 const* bp2, bool triggered, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    CustomSpellValues values;
    if (bp0)
        values.AddSpellMod(SPELLVALUE_BASE_POINT0, *bp0);
    if (bp1)
        values.AddSpellMod(SPELLVALUE_BASE_POINT1, *bp1);
    if (bp2)
        values.AddSpellMod(SPELLVALUE_BASE_POINT2, *bp2);
    return CastCustomSpell(spellId, values, target, triggered ? TRIGGERED_FULL_MASK : TRIGGERED_NONE, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastCustomSpell(uint32 spellId, SpellValueMod mod, int32 value, Unit* target, bool triggered, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    CustomSpellValues values;
    values.AddSpellMod(mod, value);
    return CastCustomSpell(spellId, values, target, triggered ? TRIGGERED_FULL_MASK : TRIGGERED_NONE, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastCustomSpell(uint32 spellId, SpellValueMod mod, int32 value, Unit* target, TriggerCastFlags triggerFlags, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    CustomSpellValues values;
    values.AddSpellMod(mod, value);
    return CastCustomSpell(spellId, values, target, triggerFlags, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastCustomSpell(uint32 spellId, CustomSpellValues const& value, Unit* victim, TriggerCastFlags triggerFlags, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        LOG_ERROR("entities.unit", "CastSpell: unknown spell {} by caster {}", spellId, GetGUID().ToString());
        return SPELL_FAILED_SPELL_UNAVAILABLE;
    }

    SpellCastTargets targets;
    targets.SetUnitTarget(victim);

    return CastSpell(targets, spellInfo, &value, triggerFlags, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastSpell(float x, float y, float z, uint32 spellId, bool triggered, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        LOG_ERROR("entities.unit", "CastSpell: unknown spell {} by caster {}", spellId, GetGUID().ToString());
        return SPELL_FAILED_SPELL_UNAVAILABLE;
    }

    SpellCastTargets targets;
    targets.SetDst(x, y, z, GetOrientation());

    return CastSpell(targets, spellInfo, nullptr, triggered ? TRIGGERED_FULL_MASK : TRIGGERED_NONE, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastSpell(GameObject* go, uint32 spellId, bool triggered, Item* castItem, AuraEffect* triggeredByAura, ObjectGuid originalCaster)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
    {
        LOG_ERROR("entities.unit", "CastSpell: unknown spell {} by caster {}", spellId, GetGUID().ToString());
        return SPELL_FAILED_SPELL_UNAVAILABLE;
    }

    SpellCastTargets targets;
    targets.SetGOTarget(go);

    return CastSpell(targets, spellInfo, nullptr, triggered ? TRIGGERED_FULL_MASK : TRIGGERED_NONE, castItem, triggeredByAura, originalCaster);
}

void Unit::CalculateSpellDamageTaken(SpellNonMeleeDamage* damageInfo, int32 damage, SpellInfo const* spellInfo, WeaponAttackType attackType, bool crit)
{
    if (damage < 0)
        return;

    Unit* victim = damageInfo->target;
    if (!victim || !victim->IsAlive())
        return;

    SpellSchoolMask damageSchoolMask = SpellSchoolMask(damageInfo->schoolMask);
    uint32 crTypeMask = victim->GetCreatureTypeMask();

     // Script Hook For CalculateSpellDamageTaken -- Allow scripts to change the Damage post class mitigation calculations
    sScriptMgr->ModifySpellDamageTaken(damageInfo->target, damageInfo->attacker, damage, spellInfo);

    if (victim->GetAI())
    {
        victim->GetAI()->OnCalculateSpellDamageReceived(damage, this);
    }

    int32 cleanDamage = 0;
    if (Unit::IsDamageReducedByArmor(damageSchoolMask, spellInfo))
    {
        int32 oldDamage = damage;
        damage = Unit::CalcArmorReducedDamage(this, victim, damage, spellInfo, 0, attackType);
        cleanDamage = oldDamage - damage;
    }

    bool blocked = false;
    // Per-school calc
    switch (spellInfo->DmgClass)
    {
        // Melee and Ranged Spells
        case SPELL_DAMAGE_CLASS_RANGED:
        case SPELL_DAMAGE_CLASS_MELEE:
            {
                // Physical Damage
                if (damageSchoolMask & SPELL_SCHOOL_MASK_NORMAL)
                {
                    // Get blocked status
                    blocked = isSpellBlocked(victim, spellInfo, attackType);
                }

                if (crit)
                {
                    damageInfo->HitInfo |= SPELL_HIT_TYPE_CRIT;

                    // Calculate crit bonus
                    uint32 crit_bonus = damage;
                    // Apply crit_damage bonus for melee spells
                    if (Player* modOwner = GetSpellModOwner())
                        modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_CRIT_DAMAGE_BONUS, crit_bonus);
                    damage += crit_bonus;

                    // Apply SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_DAMAGE or SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_DAMAGE
                    float critPctDamageMod = 0.0f;
                    if (attackType == RANGED_ATTACK)
                        critPctDamageMod += victim->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_DAMAGE);
                    else
                        critPctDamageMod += victim->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_DAMAGE);

                    // Increase crit damage from SPELL_AURA_MOD_CRIT_DAMAGE_BONUS
                    critPctDamageMod += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, spellInfo->GetSchoolMask());

                    // Increase crit damage from SPELL_AURA_MOD_CRIT_PERCENT_VERSUS
                    critPctDamageMod += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_CRIT_PERCENT_VERSUS, crTypeMask);

                    if (critPctDamageMod != 0)
                        AddPct(damage, critPctDamageMod);
                }

                // Spell weapon based damage CAN BE crit & blocked at same time
                if (blocked)
                {
                    damageInfo->blocked = victim->GetShieldBlockValue();
                    // double blocked amount if block is critical
                    if (victim->isBlockCritical())
                        damageInfo->blocked *= 2;
                    if (damage < int32(damageInfo->blocked))
                        damageInfo->blocked = uint32(damage);

                    damage -= damageInfo->blocked;
                    cleanDamage += damageInfo->blocked;
                }

                int32 resilienceReduction = damage;
                if (CanApplyResilience())
                {
                    if (attackType != RANGED_ATTACK)
                    {
                        Unit::ApplyResilience(victim, nullptr, &resilienceReduction, crit, CR_CRIT_TAKEN_MELEE);
                    }
                    else
                    {
                        Unit::ApplyResilience(victim, nullptr, &resilienceReduction, crit, CR_CRIT_TAKEN_RANGED);
                    }
                }

                resilienceReduction = damage - resilienceReduction;
                damage -= resilienceReduction;
                cleanDamage += resilienceReduction;
                break;
            }
        // Magical Attacks
        case SPELL_DAMAGE_CLASS_NONE:
        case SPELL_DAMAGE_CLASS_MAGIC:
            {
                // If crit add critical bonus
                if (crit)
                {
                    damageInfo->HitInfo |= SPELL_HIT_TYPE_CRIT;
                    damage = Unit::SpellCriticalDamageBonus(this, spellInfo, damage, victim);
                }

                int32 resilienceReduction = damage;
                if (CanApplyResilience())
                {
                    Unit::ApplyResilience(victim, nullptr, &resilienceReduction, crit, CR_CRIT_TAKEN_SPELL);
                }

                resilienceReduction = damage - resilienceReduction;
                damage -= resilienceReduction;
                cleanDamage += resilienceReduction;
                break;
            }
        default:
            break;
    }

    damageInfo->cleanDamage = std::max(0, cleanDamage);
    damageInfo->damage = std::max(0, damage);

    // Calculate absorb resist
    if (damageInfo->damage > 0)
    {
        DamageInfo dmgInfo(*damageInfo, SPELL_DIRECT_DAMAGE);
        Unit::CalcAbsorbResist(dmgInfo);
        damageInfo->absorb = dmgInfo.GetAbsorb();
        damageInfo->resist = dmgInfo.GetResist();
        damageInfo->damage = dmgInfo.GetDamage();
    }
}

void Unit::DealSpellDamage(SpellNonMeleeDamage* damageInfo, bool durabilityLoss, Spell const* spell /*= nullptr*/)
{
    if (damageInfo == 0)
        return;

    Unit* victim = damageInfo->target;

    if (!victim)
        return;

    if (!victim->IsAlive() || victim->IsInFlight() || (victim->GetTypeId() == TYPEID_UNIT && victim->ToCreature()->IsEvadingAttacks()))
        return;

    SpellInfo const* spellProto = damageInfo->spellInfo;
    if (!spellProto)
    {
        LOG_DEBUG("entities.unit", "Unit::DealSpellDamage has wrong damageInfo");
        return;
    }

    // Call default DealDamage
    CleanDamage cleanDamage(damageInfo->cleanDamage, damageInfo->absorb, BASE_ATTACK, MELEE_HIT_NORMAL);
    Unit::DealDamage(this, victim, damageInfo->damage, &cleanDamage, SPELL_DIRECT_DAMAGE, SpellSchoolMask(damageInfo->schoolMask), spellProto, durabilityLoss, false, spell);
}

// @todo for melee need create structure as in
void Unit::CalculateMeleeDamage(Unit* victim, CalcDamageInfo* damageInfo, WeaponAttackType attackType, const bool sittingVictim)
{
    damageInfo->attacker         = this;
    damageInfo->target           = victim;

    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        damageInfo->damages[i].damageSchoolMask = GetMeleeDamageSchoolMask(attackType, i);
        damageInfo->damages[i].damage = 0;
        damageInfo->damages[i].absorb = 0;
        damageInfo->damages[i].resist = 0;
    }

    damageInfo->attackType       = attackType;
    damageInfo->cleanDamage      = 0;
    damageInfo->blocked_amount   = 0;

    damageInfo->TargetState      = 0;
    damageInfo->HitInfo          = 0;
    damageInfo->procAttacker     = PROC_FLAG_NONE;
    damageInfo->procVictim       = PROC_FLAG_NONE;
    damageInfo->procEx           = PROC_EX_NONE;
    damageInfo->hitOutCome       = MELEE_HIT_EVADE;

    if (!victim)
        return;

    if (!IsAlive() || !victim->IsAlive())
        return;

    // Select HitInfo/procAttacker/procVictim flag based on attack type
    switch (attackType)
    {
        case BASE_ATTACK:
            damageInfo->procAttacker = PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_DONE_MAINHAND_ATTACK;
            damageInfo->procVictim   = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
            break;
        case OFF_ATTACK:
            damageInfo->procAttacker = PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_DONE_OFFHAND_ATTACK;
            damageInfo->procVictim   = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
            damageInfo->HitInfo      = HITINFO_OFFHAND;
            break;
        default:
            return;
    }

    // School Immune check
    uint8 immunedMask = 0;
    bool hasNonPhysicalSchoolMask = false;
    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        if (damageInfo->target->IsImmunedToDamageOrSchool(SpellSchoolMask(damageInfo->damages[i].damageSchoolMask)))
        {
            immunedMask |= (1 << i);
            if (damageInfo->damages[i].damageSchoolMask != SPELL_SCHOOL_MASK_NORMAL)
            {
                hasNonPhysicalSchoolMask = true;
            }
        }
    }

    // School Immune check
    if (immunedMask & ((1 << 0) | (1 << 1)))
    {
        if (hasNonPhysicalSchoolMask || immunedMask == ((1 << 0) | (1 << 1)))
        {
            damageInfo->HitInfo |= HITINFO_NORMALSWING;
            damageInfo->TargetState = VICTIMSTATE_IS_IMMUNE;

            damageInfo->procEx |= PROC_EX_IMMUNE;
            return;
        }
    }

    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        // only players have secondary weapon damage
        if (i > 0 && GetTypeId() != TYPEID_PLAYER)
        {
            break;
        }

        if (immunedMask & (1 << i))
        {
            continue;
        }

        SpellSchoolMask schoolMask = SpellSchoolMask(damageInfo->damages[i].damageSchoolMask);
        bool const addPctMods = (schoolMask & SPELL_SCHOOL_MASK_NORMAL);

        uint32 damage = 0;
        uint8 itemDamagesMask = (GetTypeId() == TYPEID_PLAYER) ? (1 << i) : 0;

        damage += CalculateDamage(damageInfo->attackType, false, addPctMods, itemDamagesMask);
        // Add melee damage bonus
        damage = MeleeDamageBonusDone(damageInfo->target, damage, damageInfo->attackType, nullptr, schoolMask);
        damage = damageInfo->target->MeleeDamageBonusTaken(this, damage, damageInfo->attackType, nullptr, schoolMask);

        // Script Hook For CalculateMeleeDamage -- Allow scripts to change the Damage pre class mitigation calculations
        sScriptMgr->ModifyMeleeDamage(damageInfo->target, damageInfo->attacker, damage);

        if (victim->GetAI())
        {
            victim->GetAI()->OnCalculateMeleeDamageReceived(damage, this);
        }

        // Calculate armor reduction
        if (IsDamageReducedByArmor((SpellSchoolMask)(damageInfo->damages[i].damageSchoolMask)))
        {
            damageInfo->damages[i].damage = Unit::CalcArmorReducedDamage(this, damageInfo->target, damage, nullptr, 0, damageInfo->attackType);
            damageInfo->cleanDamage += damage - damageInfo->damages[i].damage;
        }
        else
        {
            damageInfo->damages[i].damage = damage;
        }
    }

    damageInfo->hitOutCome = RollMeleeOutcomeAgainst(damageInfo->target, damageInfo->attackType);

    // If the victim was a sitting player and we didn't roll a miss, then crit.
    if (sittingVictim && damageInfo->hitOutCome != MELEE_HIT_MISS)
    {
        damageInfo->hitOutCome = MELEE_HIT_CRIT;
    }
    switch (damageInfo->hitOutCome)
    {
        case MELEE_HIT_EVADE:
            damageInfo->HitInfo        |= HITINFO_MISS | HITINFO_SWINGNOHITSOUND;
            damageInfo->TargetState     = VICTIMSTATE_EVADES;
            damageInfo->procEx         |= PROC_EX_EVADE;

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->damages[i].damage = 0;
            }

            damageInfo->cleanDamage = 0;
            return;
        case MELEE_HIT_MISS:
            damageInfo->HitInfo        |= HITINFO_MISS;
            damageInfo->TargetState     = VICTIMSTATE_INTACT;
            damageInfo->procEx         |= PROC_EX_MISS;

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->damages[i].damage = 0;
            }
            damageInfo->cleanDamage     = 0;
            break;
        case MELEE_HIT_NORMAL:
            damageInfo->TargetState     = VICTIMSTATE_HIT;
            damageInfo->procEx         |= PROC_EX_NORMAL_HIT;
            break;
        case MELEE_HIT_CRIT:
            {
                damageInfo->HitInfo        |= HITINFO_CRITICALHIT;
                damageInfo->TargetState     = VICTIMSTATE_HIT;

                damageInfo->procEx         |= PROC_EX_CRITICAL_HIT;
                // Crit bonus calc
                for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
                {
                    damageInfo->damages[i].damage *= 2;

                    float mod = 0.0f;
                    // Apply SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_DAMAGE or SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_DAMAGE
                    if (damageInfo->attackType == RANGED_ATTACK)
                    {
                        mod += damageInfo->target->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_DAMAGE);
                    }
                    else
                    {
                        mod += damageInfo->target->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_DAMAGE);

                        // Increase crit damage from SPELL_AURA_MOD_CRIT_DAMAGE_BONUS
                        mod += (GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, damageInfo->damages[i].damageSchoolMask) - 1.0f) * 100;
                    }

                    uint32 crTypeMask = damageInfo->target->GetCreatureTypeMask();

                    // Increase crit damage from SPELL_AURA_MOD_CRIT_PERCENT_VERSUS
                    mod += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_CRIT_PERCENT_VERSUS, crTypeMask);
                    if (mod != 0)
                    {
                        AddPct(damageInfo->damages[i].damage, mod);
                    }
                }
                break;
            }
        case MELEE_HIT_PARRY:
            damageInfo->TargetState  = VICTIMSTATE_PARRY;
            damageInfo->procEx      |= PROC_EX_PARRY;
            damageInfo->cleanDamage = 0;

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->cleanDamage += damageInfo->damages[i].damage;
                damageInfo->damages[i].damage = 0;
            }
            break;
        case MELEE_HIT_DODGE:
            damageInfo->TargetState  = VICTIMSTATE_DODGE;
            damageInfo->procEx      |= PROC_EX_DODGE;
            damageInfo->cleanDamage = 0;

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->cleanDamage += damageInfo->damages[i].damage;
                damageInfo->damages[i].damage = 0;
            }
            break;
        case MELEE_HIT_BLOCK:
        {
            damageInfo->TargetState = VICTIMSTATE_HIT;
            damageInfo->HitInfo |= HITINFO_BLOCK;
            damageInfo->procEx |= PROC_EX_BLOCK;
            damageInfo->blocked_amount = damageInfo->target->GetShieldBlockValue();
            // double blocked amount if block is critical
            if (damageInfo->target->isBlockCritical())
                damageInfo->blocked_amount += damageInfo->blocked_amount;

            uint32 remainingBlock = damageInfo->blocked_amount;
            uint8 fullBlockMask = 0;
            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                if (remainingBlock && remainingBlock >= damageInfo->damages[i].damage)
                {
                    fullBlockMask |= (1 << i);

                    remainingBlock -= damageInfo->damages[i].damage;
                    damageInfo->cleanDamage += damageInfo->damages[i].damage;
                    damageInfo->damages[i].damage = 0;
                }
                else
                {
                    damageInfo->cleanDamage += remainingBlock;
                    damageInfo->damages[i].damage -= remainingBlock;
                    remainingBlock = 0;
                }
            }

            // full block
            if (fullBlockMask == ((1 << 0) | (1 << 1)))
            {
                damageInfo->TargetState = VICTIMSTATE_BLOCKS;
                damageInfo->procEx |= PROC_EX_FULL_BLOCK;
                damageInfo->blocked_amount -= remainingBlock;
            }
            break;
        }
        case MELEE_HIT_GLANCING:
        {
            damageInfo->HitInfo     |= HITINFO_GLANCING;
            damageInfo->TargetState  = VICTIMSTATE_HIT;
            damageInfo->procEx      |= PROC_EX_NORMAL_HIT;
            int32 leveldif = int32(victim->GetLevel()) - int32(GetLevel());
            if (leveldif > 3)
                leveldif = 3;
            float reducePercent = 1 - leveldif * 0.1f;

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                uint32 reducedDamage = uint32(reducePercent * damageInfo->damages[i].damage);
                damageInfo->cleanDamage += damageInfo->damages[i].damage - reducedDamage;
                damageInfo->damages[i].damage = reducedDamage;
            }
            break;
        }
        case MELEE_HIT_CRUSHING:
            damageInfo->HitInfo     |= HITINFO_CRUSHING;
            damageInfo->TargetState  = VICTIMSTATE_HIT;
            damageInfo->procEx      |= PROC_EX_NORMAL_HIT;

            // 150% normal damage
            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->damages[i].damage += (damageInfo->damages[i].damage / 2);
            }
            break;
        default:
            break;
    }

    // Always apply HITINFO_AFFECTS_VICTIM in case its not a miss
    if (!(damageInfo->HitInfo & HITINFO_MISS))
        damageInfo->HitInfo |= HITINFO_AFFECTS_VICTIM;

    uint32 tmpHitInfo[MAX_ITEM_PROTO_DAMAGES] = { };

    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        int32 dmg = damageInfo->damages[i].damage;
        int32 cleanDamage = damageInfo->cleanDamage;
        // attackType is checked already for BASE_ATTACK or OFF_ATTACK so it can't be RANGED_ATTACK here
        if (CanApplyResilience())
        {
            int32 resilienceReduction = damageInfo->damages[i].damage;
            Unit::ApplyResilience(victim, nullptr, &resilienceReduction, (damageInfo->hitOutCome == MELEE_HIT_CRIT), CR_CRIT_TAKEN_MELEE);

            resilienceReduction = damageInfo->damages[i].damage - resilienceReduction;
            dmg -= resilienceReduction;
            cleanDamage += resilienceReduction;
        }

        damageInfo->damages[i].damage = std::max(0, dmg);
        damageInfo->cleanDamage = std::max(0, cleanDamage);

        // Calculate absorb resist
        if (damageInfo->damages[i].damage > 0)
        {
            damageInfo->procVictim |= PROC_FLAG_TAKEN_DAMAGE;

            // Calculate absorb & resists
            DamageInfo dmgInfo(*damageInfo, i);
            Unit::CalcAbsorbResist(dmgInfo);
            damageInfo->damages[i].absorb = dmgInfo.GetAbsorb();
            damageInfo->damages[i].resist = dmgInfo.GetResist();

            if (damageInfo->damages[i].absorb)
            {
                tmpHitInfo[i] |= (damageInfo->damages[i].damage - damageInfo->damages[i].absorb == 0 ? HITINFO_FULL_ABSORB : HITINFO_PARTIAL_ABSORB);
            }

            if (damageInfo->damages[i].resist)
            {
                tmpHitInfo[i] |= (damageInfo->damages[i].damage - damageInfo->damages[i].resist == 0 ? HITINFO_FULL_RESIST : HITINFO_PARTIAL_RESIST);
            }

            damageInfo->damages[i].damage = dmgInfo.GetDamage();
        }
    }

    // set proper HitInfo flags
    if ((tmpHitInfo[0] & HITINFO_FULL_ABSORB) != 0)
    {
        // set partial absorb when secondary damage isn't full absorbed
        damageInfo->HitInfo |= ((tmpHitInfo[1] & HITINFO_PARTIAL_ABSORB) != 0) ? HITINFO_PARTIAL_ABSORB : HITINFO_FULL_ABSORB;
    }
    else
    {
        damageInfo->HitInfo |= (tmpHitInfo[0] & HITINFO_PARTIAL_ABSORB);
    }

    if ((tmpHitInfo[0] & HITINFO_FULL_RESIST) != 0)
    {
        // set partial resist when secondary damage isn't full resisted
        damageInfo->HitInfo |= ((tmpHitInfo[1] & HITINFO_PARTIAL_RESIST) != 0) ? HITINFO_PARTIAL_RESIST : HITINFO_FULL_RESIST;
    }
    else
    {
        damageInfo->HitInfo |= (tmpHitInfo[0] & HITINFO_PARTIAL_RESIST);
    }

    if (damageInfo->HitInfo & (HITINFO_PARTIAL_ABSORB | HITINFO_FULL_ABSORB))
    {
        damageInfo->procEx |= PROC_EX_ABSORB;
    }

    if (damageInfo->HitInfo & HITINFO_FULL_RESIST)
    {
        damageInfo->procEx |= PROC_EX_RESIST;
    }
}

void Unit::DealMeleeDamage(CalcDamageInfo* damageInfo, bool durabilityLoss)
{
    Unit* victim = damageInfo->target;

    auto canTakeMeleeDamage = [&]()
    {
        return victim->IsAlive() && !victim->HasUnitState(UNIT_STATE_IN_FLIGHT) && (victim->GetTypeId() != TYPEID_UNIT || !victim->ToCreature()->IsEvadingAttacks());
    };

    if (!canTakeMeleeDamage())
    {
        return;
    }

    // Hmmmm dont like this emotes client must by self do all animations
    if (damageInfo->HitInfo & HITINFO_CRITICALHIT)
        victim->HandleEmoteCommand(EMOTE_ONESHOT_WOUND_CRITICAL);
    if (damageInfo->blocked_amount && damageInfo->TargetState != VICTIMSTATE_BLOCKS)
        victim->HandleEmoteCommand(EMOTE_ONESHOT_PARRY_SHIELD);

    if (damageInfo->TargetState == VICTIMSTATE_PARRY)
    {
        // Get attack timers
        float offtime  = float(victim->getAttackTimer(OFF_ATTACK));
        float basetime = float(victim->getAttackTimer(BASE_ATTACK));
        // Reduce attack time
        if (victim->haveOffhandWeapon() && offtime < basetime)
        {
            float percent20 = victim->GetAttackTime(OFF_ATTACK) * 0.20f;
            float percent60 = 3.0f * percent20;
            if (offtime > percent20 && offtime <= percent60)
                victim->setAttackTimer(OFF_ATTACK, uint32(percent20));
            else if (offtime > percent60)
            {
                offtime -= 2.0f * percent20;
                victim->setAttackTimer(OFF_ATTACK, uint32(offtime));
            }
        }
        else
        {
            float percent20 = victim->GetAttackTime(BASE_ATTACK) * 0.20f;
            float percent60 = 3.0f * percent20;
            if (basetime > percent20 && basetime <= percent60)
                victim->setAttackTimer(BASE_ATTACK, uint32(percent20));
            else if (basetime > percent60)
            {
                basetime -= 2.0f * percent20;
                victim->setAttackTimer(BASE_ATTACK, uint32(basetime));
            }
        }
    }

    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        if (!canTakeMeleeDamage() || (!damageInfo->damages[i].damage && !damageInfo->damages[i].absorb && !damageInfo->damages[i].resist))
        {
            continue;
        }

        // Call default DealDamage
        CleanDamage cleanDamage(damageInfo->cleanDamage, damageInfo->damages[i].absorb, damageInfo->attackType, damageInfo->hitOutCome);
        Unit::DealDamage(this, victim, damageInfo->damages[i].damage, &cleanDamage, DIRECT_DAMAGE, SpellSchoolMask(damageInfo->damages[i].damageSchoolMask), nullptr, durabilityLoss);
    }

    // If this is a creature and it attacks from behind it has a probability to daze it's victim
    if ((damageInfo->damages[0].damage + damageInfo->damages[1].damage) && ((damageInfo->hitOutCome == MELEE_HIT_CRIT || damageInfo->hitOutCome == MELEE_HIT_CRUSHING || damageInfo->hitOutCome == MELEE_HIT_NORMAL || damageInfo->hitOutCome == MELEE_HIT_GLANCING) &&
                               GetTypeId() != TYPEID_PLAYER && !ToCreature()->IsControlledByPlayer() && !victim->HasInArc(M_PI, this)
                               && (victim->GetTypeId() == TYPEID_PLAYER || !victim->ToCreature()->isWorldBoss()) && !victim->IsVehicle()))
    {
        // -probability is between 0% and 40%
        // 20% base chance
        float Probability = 20.0f;

        // there is a newbie protection, at level 10 just 7% base chance; assuming linear function
        if (victim->GetLevel() < 30)
            Probability = 0.65f * victim->GetLevel() + 0.5f;

        uint32 VictimDefense = victim->GetDefenseSkillValue();
        uint32 AttackerMeleeSkill = GetUnitMeleeSkill();

        // xinef: fix daze mechanics
        Probability -= ((float)VictimDefense - AttackerMeleeSkill) * 0.1428f;

        if (Probability > 40.0f)
            Probability = 40.0f;

        // Daze application
        if (sWorld->getBoolConfig(CONFIG_ENABLE_DAZE))
            if (roll_chance_f(std::max(0.0f, Probability)))
                CastSpell(victim, 1604, true);
    }

    if (GetTypeId() == TYPEID_PLAYER)
        ToPlayer()->CastItemCombatSpell(victim, damageInfo->attackType, damageInfo->procVictim, damageInfo->procEx);

    // Do effect if any damage done to target
    if (damageInfo->damages[0].damage + damageInfo->damages[1].damage)
    {
        // We're going to call functions which can modify content of the list during iteration over it's elements
        // Let's copy the list so we can prevent iterator invalidation
        AuraEffectList vDamageShieldsCopy(victim->GetAuraEffectsByType(SPELL_AURA_DAMAGE_SHIELD));
        for (AuraEffectList::const_iterator dmgShieldItr = vDamageShieldsCopy.begin(); dmgShieldItr != vDamageShieldsCopy.end(); ++dmgShieldItr)
        {
            SpellInfo const* i_spellProto = (*dmgShieldItr)->GetSpellInfo();
            // Damage shield can be resisted...
            if (SpellMissInfo missInfo = victim->SpellHitResult(this, i_spellProto, false))
            {
                victim->SendSpellMiss(this, i_spellProto->Id, missInfo);
                continue;
            }

            // ...or immuned
            if (IsImmunedToDamageOrSchool(i_spellProto))
            {
                victim->SendSpellDamageImmune(this, i_spellProto->Id);
                continue;
            }

            uint32 damage = uint32(std::max(0, (*dmgShieldItr)->GetAmount())); // xinef: done calculated at amount calculation

            if (Unit* caster = (*dmgShieldItr)->GetCaster())
            {
                damage = caster->SpellDamageBonusDone(this, i_spellProto, damage, SPELL_DIRECT_DAMAGE, (*dmgShieldItr)->GetEffIndex());
                damage = this->SpellDamageBonusTaken(caster, i_spellProto, damage, SPELL_DIRECT_DAMAGE);
            }

            uint32 absorb = 0;

            DamageInfo dmgInfo(victim, this, damage, i_spellProto, i_spellProto->GetSchoolMask(), SPELL_DIRECT_DAMAGE);
            Unit::CalcAbsorbResist(dmgInfo);
            absorb = dmgInfo.GetAbsorb();
            damage = dmgInfo.GetDamage();

            Unit::DealDamageMods(this, damage, &absorb);

            /// @todo: Move this to a packet handler
            WorldPacket data(SMSG_SPELLDAMAGESHIELD, (8 + 8 + 4 + 4 + 4 + 4));
            data << victim->GetGUID();
            data << GetGUID();
            data << uint32(i_spellProto->Id);
            data << uint32(damage);                  // Damage
            int32 overkill = int32(damage) - int32(GetHealth());
            data << uint32(overkill > 0 ? overkill : 0); // Overkill
            data << uint32(i_spellProto->GetSchoolMask());
            victim->SendMessageToSet(&data, true);

            Unit::DealDamage(victim, this, damage, 0, SPELL_DIRECT_DAMAGE, i_spellProto->GetSchoolMask(), i_spellProto, true);
        }
    }
}

void Unit::HandleEmoteCommand(uint32 emoteId)
{
    WorldPackets::Chat::Emote packet;
    packet.EmoteID = emoteId;
    packet.Guid = GetGUID();
    SendMessageToSet(packet.Write(), true);
}

bool Unit::IsDamageReducedByArmor(SpellSchoolMask schoolMask, SpellInfo const* spellInfo, uint8 effIndex)
{
    // only physical spells damage gets reduced by armor
    if ((schoolMask & SPELL_SCHOOL_MASK_NORMAL) == 0)
        return false;
    if (spellInfo)
    {
        // there are spells with no specific attribute but they have "ignores armor" in tooltip
        if (spellInfo->HasAttribute(SPELL_ATTR0_CU_IGNORE_ARMOR))
            return false;

        // bleeding effects are not reduced by armor
        if (effIndex != MAX_SPELL_EFFECTS)
        {
            if (spellInfo->Effects[effIndex].ApplyAuraName == SPELL_AURA_PERIODIC_DAMAGE ||
                    spellInfo->Effects[effIndex].Effect == SPELL_EFFECT_SCHOOL_DAMAGE)
                if (spellInfo->GetEffectMechanicMask(effIndex) & (1 << MECHANIC_BLEED))
                    return false;
        }
    }
    return true;
}

uint32 Unit::CalcArmorReducedDamage(Unit const* attacker, Unit const* victim, const uint32 damage, SpellInfo const* spellInfo, uint8 attackerLevel, WeaponAttackType /*attackType*/)
{
    float armor = float(victim->GetArmor());

    // Ignore enemy armor by SPELL_AURA_MOD_TARGET_RESISTANCE aura
    if (attacker)
    {
        armor += attacker->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_TARGET_RESISTANCE, SPELL_SCHOOL_MASK_NORMAL);

        if (spellInfo)
            if (Player* modOwner = attacker->GetSpellModOwner())
                modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_IGNORE_ARMOR, armor);

        AuraEffectList const& ResIgnoreAurasAb = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_ABILITY_IGNORE_TARGET_RESIST);
        for (AuraEffectList::const_iterator j = ResIgnoreAurasAb.begin(); j != ResIgnoreAurasAb.end(); ++j)
        {
            if ((*j)->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL
                    && (*j)->IsAffectedOnSpell(spellInfo))
                armor = floor(AddPct(armor, -(*j)->GetAmount()));
        }

        AuraEffectList const& ResIgnoreAuras = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_IGNORE_TARGET_RESIST);
        for (AuraEffectList::const_iterator j = ResIgnoreAuras.begin(); j != ResIgnoreAuras.end(); ++j)
        {
            if ((*j)->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL)
                armor = floor(AddPct(armor, -(*j)->GetAmount()));
        }

        // Apply Player CR_ARMOR_PENETRATION rating and buffs from stances\specializations etc.
        if (attacker->GetTypeId() == TYPEID_PLAYER)
        {
            float bonusPct = 0;
            AuraEffectList const& armorPenAuras = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_ARMOR_PENETRATION_PCT);
            for (AuraEffectList::const_iterator itr = armorPenAuras.begin(); itr != armorPenAuras.end(); ++itr)
            {
                if ((*itr)->GetSpellInfo()->EquippedItemClass == -1)
                {
                    if (!spellInfo || (*itr)->IsAffectedOnSpell(spellInfo) || (*itr)->GetMiscValue() & spellInfo->GetSchoolMask())
                        bonusPct += (*itr)->GetAmount();
                    else if (!(*itr)->GetMiscValue() && !(*itr)->HasSpellClassMask())
                        bonusPct += (*itr)->GetAmount();
                }
                else
                {
                    if (attacker->ToPlayer()->HasItemFitToSpellRequirements((*itr)->GetSpellInfo()))
                        bonusPct += (*itr)->GetAmount();
                }
            }

            float maxArmorPen = 0;
            if (victim->GetLevel() < 60)
                maxArmorPen = float(400 + 85 * victim->GetLevel());
            else
                maxArmorPen = 400 + 85 * victim->GetLevel() + 4.5f * 85 * (victim->GetLevel() - 59);

            // Cap armor penetration to this number
            maxArmorPen = std::min((armor + maxArmorPen) / 3, armor);
            // Figure out how much armor do we ignore
            float armorPen = CalculatePct(maxArmorPen, bonusPct + attacker->ToPlayer()->GetRatingBonusValue(CR_ARMOR_PENETRATION));
            // Got the value, apply it
            armor -= std::min(armorPen, maxArmorPen);
        }
    }

    if (armor < 0.0f)
        armor = 0.0f;

    float levelModifier = attacker ? attacker->GetLevel() : attackerLevel;
    if (levelModifier > 59)
        levelModifier = levelModifier + (4.5f * (levelModifier - 59));

    float tmpvalue = 0.1f * armor / (8.5f * levelModifier + 40);
    tmpvalue = tmpvalue / (1.0f + tmpvalue);

    if (tmpvalue < 0.0f)
        tmpvalue = 0.0f;
    if (tmpvalue > 0.75f)
        tmpvalue = 0.75f;

    return uint32(std::ceil(std::max(damage * (1.0f - tmpvalue), 0.0f)));
}

float Unit::GetEffectiveResistChance(Unit const* owner, SpellSchoolMask schoolMask, Unit const* victim)
{
    float victimResistance = float(victim->GetResistance(schoolMask));
    if (owner)
    {
        // Xinef: pets inherit 100% of masters penetration
        // Xinef: excluding traps
        Player const* player = owner->GetSpellModOwner();
        if (player && owner->GetEntry() != WORLD_TRIGGER)
        {
            victimResistance += float(player->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_TARGET_RESISTANCE, schoolMask));
            victimResistance -= float(player->GetSpellPenetrationItemMod());
        }
        else
            victimResistance += float(owner->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_TARGET_RESISTANCE, schoolMask));
    }

    victimResistance = std::max(victimResistance, 0.0f);
    if (owner)
        victimResistance += std::max((float(victim->GetLevel()) - float(owner->GetLevel())) * 5.0f, 0.0f);

    static uint32 const BOSS_LEVEL = 83;
    static float const BOSS_RESISTANCE_CONSTANT = 510.0f;
    uint32 level = victim->GetLevel();
    float resistanceConstant = 0.0f;

    if (level == BOSS_LEVEL)
        resistanceConstant = BOSS_RESISTANCE_CONSTANT;
    else
        resistanceConstant = level * 5.0f;

    return victimResistance / (victimResistance + resistanceConstant);
}

void Unit::CalcAbsorbResist(DamageInfo& dmgInfo, bool Splited)
{
    Unit* victim = dmgInfo.GetVictim();
    Unit* attacker = dmgInfo.GetAttacker();
    uint32 damage = dmgInfo.GetDamage();
    SpellSchoolMask schoolMask = dmgInfo.GetSchoolMask();
    SpellInfo const* spellInfo = dmgInfo.GetSpellInfo();

    if (!victim || !victim->IsAlive() || !damage)
        return;

    // Magic damage, check for resists
    // Ignore spells that cant be resisted
    // Xinef: holy resistance exists for npcs
    if (!(schoolMask & SPELL_SCHOOL_MASK_NORMAL) && (!(schoolMask & SPELL_SCHOOL_MASK_HOLY) || victim->GetTypeId() == TYPEID_UNIT) && (!spellInfo || (!spellInfo->HasAttribute(SPELL_ATTR0_CU_BINARY_SPELL) && !spellInfo->HasAttribute(SPELL_ATTR4_NO_CAST_LOG))))
    {
        float averageResist = Unit::GetEffectiveResistChance(attacker, schoolMask, victim);

        float discreteResistProbability[11];
        for (uint32 i = 0; i < 11; ++i)
        {
            discreteResistProbability[i] = 0.5f - 2.5f * std::fabs(0.1f * i - averageResist);
            if (discreteResistProbability[i] < 0.0f)
                discreteResistProbability[i] = 0.0f;
        }

        if (averageResist <= 0.1f)
        {
            discreteResistProbability[0] = 1.0f - 7.5f * averageResist;
            discreteResistProbability[1] = 5.0f * averageResist;
            discreteResistProbability[2] = 2.5f * averageResist;
        }

        float r = float(rand_norm());
        uint32 i = 0;
        float probabilitySum = discreteResistProbability[0];

        while (r >= probabilitySum && i < 10)
            probabilitySum += discreteResistProbability[++i];

        float damageResisted = float(damage * i / 10);

        if (damageResisted) // if equal to 0, checking these is pointless
        {
            if (attacker)
            {
                AuraEffectList const& ResIgnoreAurasAb = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_ABILITY_IGNORE_TARGET_RESIST);
                for (AuraEffectList::const_iterator j = ResIgnoreAurasAb.begin(); j != ResIgnoreAurasAb.end(); ++j)
                    if (((*j)->GetMiscValue() & schoolMask) && (*j)->IsAffectedOnSpell(spellInfo))
                        AddPct(damageResisted, -(*j)->GetAmount());

                AuraEffectList const& ResIgnoreAuras = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_IGNORE_TARGET_RESIST);
                for (AuraEffectList::const_iterator j = ResIgnoreAuras.begin(); j != ResIgnoreAuras.end(); ++j)
                    if ((*j)->GetMiscValue() & schoolMask)
                        AddPct(damageResisted, -(*j)->GetAmount());
            }

            // pussywizard:
            if (spellInfo && spellInfo->HasAttribute(SPELL_ATTR0_CU_SCHOOLMASK_NORMAL_WITH_MAGIC))
            {
                uint32 damageAfterArmor = Unit::CalcArmorReducedDamage(attacker, victim, damage, spellInfo, 0, BASE_ATTACK);
                uint32 armorReduction = damage - damageAfterArmor;
                if (armorReduction < damageResisted) // pick the lower one, the weakest resistance counts
                    damageResisted = armorReduction;
            }
        }

        dmgInfo.ResistDamage(uint32(damageResisted));
    }

    // Ignore Absorption Auras
    float auraAbsorbMod = 0;
    if (attacker)
    {
        AuraEffectList const& AbsIgnoreAurasA = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_TARGET_ABSORB_SCHOOL);
        for (AuraEffectList::const_iterator itr = AbsIgnoreAurasA.begin(); itr != AbsIgnoreAurasA.end(); ++itr)
        {
            if (!((*itr)->GetMiscValue() & schoolMask))
                continue;

            if ((*itr)->GetAmount() > auraAbsorbMod)
                auraAbsorbMod = float((*itr)->GetAmount());
        }

        AuraEffectList const& AbsIgnoreAurasB = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_TARGET_ABILITY_ABSORB_SCHOOL);
        for (AuraEffectList::const_iterator itr = AbsIgnoreAurasB.begin(); itr != AbsIgnoreAurasB.end(); ++itr)
        {
            if (!((*itr)->GetMiscValue() & schoolMask))
                continue;

            if (((*itr)->GetAmount() > auraAbsorbMod) && (*itr)->IsAffectedOnSpell(spellInfo))
                auraAbsorbMod = float((*itr)->GetAmount());
        }
        RoundToInterval(auraAbsorbMod, 0.0f, 100.0f);
    }

    // We're going to call functions which can modify content of the list during iteration over it's elements
    // Let's copy the list so we can prevent iterator invalidation
    AuraEffectList vSchoolAbsorbCopy(victim->GetAuraEffectsByType(SPELL_AURA_SCHOOL_ABSORB));
    vSchoolAbsorbCopy.sort(Acore::AbsorbAuraOrderPred());

    // absorb without mana cost
    for (AuraEffectList::iterator itr = vSchoolAbsorbCopy.begin(); (itr != vSchoolAbsorbCopy.end()) && (dmgInfo.GetDamage() > 0); ++itr)
    {
        AuraEffect* absorbAurEff = *itr;
        // Check if aura was removed during iteration - we don't need to work on such auras
        AuraApplication const* aurApp = absorbAurEff->GetBase()->GetApplicationOfTarget(victim->GetGUID());
        if (!aurApp)
            continue;
        if (!(absorbAurEff->GetMiscValue() & schoolMask))
            continue;

        // get amount which can be still absorbed by the aura
        int32 currentAbsorb = absorbAurEff->GetAmount();
        // aura with infinite absorb amount - let the scripts handle absorbtion amount, set here to 0 for safety
        if (currentAbsorb < 0)
            currentAbsorb = 0;

        uint32 tempAbsorb = uint32(currentAbsorb);

        bool defaultPrevented = false;

        absorbAurEff->GetBase()->CallScriptEffectAbsorbHandlers(absorbAurEff, aurApp, dmgInfo, tempAbsorb, defaultPrevented);
        currentAbsorb = tempAbsorb;

        if (defaultPrevented)
            continue;

        // absorb must be smaller than the damage itself
        currentAbsorb = RoundToInterval(currentAbsorb, 0, int32(dmgInfo.GetDamage()));

        // xinef: do this after absorb is rounded to damage...
        AddPct(currentAbsorb, -auraAbsorbMod);

        dmgInfo.AbsorbDamage(currentAbsorb);

        tempAbsorb = currentAbsorb;
        absorbAurEff->GetBase()->CallScriptEffectAfterAbsorbHandlers(absorbAurEff, aurApp, dmgInfo, tempAbsorb);

        // Check if our aura is using amount to count damage
        if (absorbAurEff->GetAmount() >= 0)
        {
            // Reduce shield amount
            absorbAurEff->SetAmount(absorbAurEff->GetAmount() - currentAbsorb);
            // Aura cannot absorb anything more - remove it
            if (absorbAurEff->GetAmount() <= 0)
                absorbAurEff->GetBase()->Remove(AURA_REMOVE_BY_ENEMY_SPELL);
        }
    }

    // absorb by mana cost
    AuraEffectList vManaShieldCopy(victim->GetAuraEffectsByType(SPELL_AURA_MANA_SHIELD));
    for (AuraEffectList::const_iterator itr = vManaShieldCopy.begin(); (itr != vManaShieldCopy.end()) && (dmgInfo.GetDamage() > 0); ++itr)
    {
        AuraEffect* absorbAurEff = *itr;
        // Check if aura was removed during iteration - we don't need to work on such auras
        AuraApplication const* aurApp = absorbAurEff->GetBase()->GetApplicationOfTarget(victim->GetGUID());
        if (!aurApp)
            continue;
        // check damage school mask
        if (!(absorbAurEff->GetMiscValue() & schoolMask))
            continue;

        // get amount which can be still absorbed by the aura
        int32 currentAbsorb = absorbAurEff->GetAmount();
        // aura with infinite absorb amount - let the scripts handle absorbtion amount, set here to 0 for safety
        if (currentAbsorb < 0)
            currentAbsorb = 0;

        uint32 tempAbsorb = currentAbsorb;

        bool defaultPrevented = false;

        absorbAurEff->GetBase()->CallScriptEffectManaShieldHandlers(absorbAurEff, aurApp, dmgInfo, tempAbsorb, defaultPrevented);
        currentAbsorb = tempAbsorb;

        if (defaultPrevented)
            continue;

        // absorb must be smaller than the damage itself
        currentAbsorb = RoundToInterval(currentAbsorb, 0, int32(dmgInfo.GetDamage()));

        // xinef: do this after absorb is rounded to damage...
        AddPct(currentAbsorb, -auraAbsorbMod);

        int32 manaReduction = currentAbsorb;

        // lower absorb amount by talents
        if (float manaMultiplier = absorbAurEff->GetSpellInfo()->Effects[absorbAurEff->GetEffIndex()].CalcValueMultiplier(absorbAurEff->GetCaster()))
            manaReduction = int32(float(manaReduction) * manaMultiplier);

        int32 manaTaken = -victim->ModifyPower(POWER_MANA, -manaReduction);

        // take case when mana has ended up into account
        currentAbsorb = currentAbsorb ? int32(float(currentAbsorb) * (float(manaTaken) / float(manaReduction))) : 0;

        dmgInfo.AbsorbDamage(currentAbsorb);

        tempAbsorb = currentAbsorb;
        absorbAurEff->GetBase()->CallScriptEffectAfterManaShieldHandlers(absorbAurEff, aurApp, dmgInfo, tempAbsorb);

        // Check if our aura is using amount to count damage
        if (absorbAurEff->GetAmount() >= 0)
        {
            absorbAurEff->SetAmount(absorbAurEff->GetAmount() - currentAbsorb);
            if ((absorbAurEff->GetAmount() <= 0))
                absorbAurEff->GetBase()->Remove(AURA_REMOVE_BY_ENEMY_SPELL);
        }
    }

    // split damage auras - only when not damaging self
    // Xinef: not true - Warlock Hellfire
    if (/*victim != attacker &&*/ !Splited)
    {
        // We're going to call functions which can modify content of the list during iteration over it's elements
        // Let's copy the list so we can prevent iterator invalidation
        AuraEffectList vSplitDamageFlatCopy(victim->GetAuraEffectsByType(SPELL_AURA_SPLIT_DAMAGE_FLAT)); // Not used by any spell
        for (AuraEffectList::iterator itr = vSplitDamageFlatCopy.begin(); (itr != vSplitDamageFlatCopy.end()) && (dmgInfo.GetDamage() > 0); ++itr)
        {
            // Check if aura was removed during iteration - we don't need to work on such auras
            if (!((*itr)->GetBase()->IsAppliedOnTarget(victim->GetGUID())))
                continue;
            // check damage school mask
            if (!((*itr)->GetMiscValue() & schoolMask))
                continue;

            // Damage can be splitted only if aura has an alive caster
            Unit* caster = (*itr)->GetCaster();
            if (!caster || (caster == victim) || !caster->IsInWorld() || !caster->IsAlive())
                continue;

            // Limit effect range to spell's cast range. (Only for single target auras, AreaAuras don't need it)
            // Ignore LOS attribute is only used for the cast portion of the spell
            SpellInfo const* splitSpellInfo = (*itr)->GetSpellInfo();
            if (!splitSpellInfo->Effects[(*itr)->GetEffIndex()].IsAreaAuraEffect())
                if (!caster->IsWithinDist(victim, splitSpellInfo->GetMaxRange(splitSpellInfo->IsPositive(), caster)))
                    continue;

            int32 splitDamage = (*itr)->GetAmount();

            // absorb must be smaller than the damage itself
            splitDamage = RoundToInterval(splitDamage, 0, int32(dmgInfo.GetDamage()));

            dmgInfo.AbsorbDamage(splitDamage);

            uint32 splitted = splitDamage;
            uint32 splitted_absorb = 0;
            uint32 splitted_resist = 0;

            uint32 procAttacker = 0, procVictim = 0, procEx = PROC_EX_NORMAL_HIT;
            DamageInfo splittedDmgInfo(attacker, caster, splitted, spellInfo, schoolMask, dmgInfo.GetDamageType());
            if (caster->IsImmunedToDamageOrSchool(schoolMask))
            {
                procEx |= PROC_EX_IMMUNE;
                splittedDmgInfo.AbsorbDamage(splitted);
            }
            else
            {
                Unit::CalcAbsorbResist(splittedDmgInfo, true);
                Unit::DealDamageMods(caster, splitted, &splitted_absorb);
            }

            splitted_absorb = splittedDmgInfo.GetAbsorb();
            splitted_resist = splittedDmgInfo.GetResist();
            splitted = splittedDmgInfo.GetDamage();

            // create procs
            createProcFlags(spellInfo, BASE_ATTACK, false, procAttacker, procVictim);
            caster->ProcDamageAndSpellFor(true, attacker, procVictim, procEx, BASE_ATTACK, spellInfo, splitted, nullptr, -1, nullptr, &splittedDmgInfo);

            if (attacker)
            {
                attacker->SendSpellNonMeleeDamageLog(caster, (*itr)->GetSpellInfo(), splitted, schoolMask, splitted_absorb, splitted_resist, false, 0, false, true);
            }

            CleanDamage cleanDamage = CleanDamage(splitted, 0, BASE_ATTACK, MELEE_HIT_NORMAL);
            Unit::DealDamage(attacker, caster, splitted, &cleanDamage, DIRECT_DAMAGE, schoolMask, (*itr)->GetSpellInfo(), false);
        }

        // We're going to call functions which can modify content of the list during iteration over it's elements
        // Let's copy the list so we can prevent iterator invalidation
        AuraEffectList vSplitDamagePctCopy(victim->GetAuraEffectsByType(SPELL_AURA_SPLIT_DAMAGE_PCT));
        for (AuraEffectList::iterator itr = vSplitDamagePctCopy.begin(), next; (itr != vSplitDamagePctCopy.end()) &&  (dmgInfo.GetDamage() > 0); ++itr)
        {
            // Check if aura was removed during iteration - we don't need to work on such auras
            AuraApplication const* aurApp = (*itr)->GetBase()->GetApplicationOfTarget(victim->GetGUID());
            if (!aurApp)
                continue;

            // check damage school mask
            if (!((*itr)->GetMiscValue() & schoolMask))
                continue;

            // Damage can be splitted only if aura has an alive caster
            Unit* caster = (*itr)->GetCaster();
            if (!caster || (caster == victim) || !caster->IsInWorld() || !caster->IsAlive())
                continue;

            // Limit effect range to spell's cast range. (Only for single target auras, AreaAuras don't need it)
            // Ignore LOS attribute is only used for the cast portion of the spell
            SpellInfo const* splitSpellInfo = (*itr)->GetSpellInfo();
            if (!splitSpellInfo->Effects[(*itr)->GetEffIndex()].IsAreaAuraEffect())
                if (!caster->IsWithinDist(victim, splitSpellInfo->GetMaxRange(splitSpellInfo->IsPositive(), caster)))
                    continue;

            uint32 splitDamage = CalculatePct(dmgInfo.GetDamage(), (*itr)->GetAmount());
            SpellSchoolMask splitSchoolMask  = schoolMask;

            (*itr)->GetBase()->CallScriptEffectSplitHandlers(*itr, aurApp, dmgInfo, splitDamage);

            // absorb must be smaller than the damage itself
            splitDamage = RoundToInterval(splitDamage, uint32(0), uint32(dmgInfo.GetDamage()));

            // Roar of Sacrifice, dont absorb it
            if (splitSpellInfo->Id != 53480)
                dmgInfo.AbsorbDamage(splitDamage);
            else
                splitSchoolMask = SPELL_SCHOOL_MASK_NATURE;

            uint32 splitted = splitDamage;
            uint32 splitted_absorb = 0;
            uint32 splitted_resist = 0;

            uint32 procAttacker = 0, procVictim = 0, procEx = PROC_EX_NORMAL_HIT;
            DamageInfo splittedDmgInfo(attacker, caster, splitted, spellInfo, splitSchoolMask, dmgInfo.GetDamageType());
            if (caster->IsImmunedToDamageOrSchool(schoolMask))
            {
                procEx |= PROC_EX_IMMUNE;
                splittedDmgInfo.AbsorbDamage(splitted);
            }
            else
            {
                Unit::CalcAbsorbResist(splittedDmgInfo, true);
                Unit::DealDamageMods(caster, splitted, &splitted_absorb);
            }

            splitted_absorb = splittedDmgInfo.GetAbsorb();
            splitted_resist = splittedDmgInfo.GetResist();
            splitted = splittedDmgInfo.GetDamage();

            // create procs
            createProcFlags(spellInfo, BASE_ATTACK, false, procAttacker, procVictim);
            caster->ProcDamageAndSpellFor(true, attacker, procVictim, procEx, BASE_ATTACK, spellInfo, splitted);

            if (attacker)
            {
                attacker->SendSpellNonMeleeDamageLog(caster, splitSpellInfo, splitted, splitSchoolMask, splitted_absorb, splitted_resist, false, 0, false, true);
            }

            CleanDamage cleanDamage = CleanDamage(splitted, 0, BASE_ATTACK, MELEE_HIT_NORMAL);
            Unit::DealDamage(attacker, caster, splitted, &cleanDamage, DIRECT_DAMAGE, splitSchoolMask, splitSpellInfo, false);
        }
    }
}

void Unit::CalcHealAbsorb(HealInfo& healInfo)
{
    if (!healInfo.GetHeal())
        return;

    int32 const healing = static_cast<int32>(healInfo.GetHeal());
    int32 absorbAmount = 0;

    // Need remove expired auras after
    bool existExpired = false;

    // absorb without mana cost
    AuraEffectList const& vHealAbsorb = healInfo.GetTarget()->GetAuraEffectsByType(SPELL_AURA_SCHOOL_HEAL_ABSORB);
    for (AuraEffectList::const_iterator i = vHealAbsorb.begin(); i != vHealAbsorb.end() && absorbAmount <= healing; ++i)
    {
        if (!((*i)->GetMiscValue() & healInfo.GetSpellInfo()->SchoolMask))
            continue;

        // Max Amount can be absorbed by this aura
        int32 currentAbsorb = (*i)->GetAmount();

        // Found empty aura (impossible but..)
        if (currentAbsorb <= 0)
        {
            existExpired = true;
            continue;
        }

        // currentAbsorb - damage can be absorbed by shield
        // If need absorb less damage
        if (healing < currentAbsorb + absorbAmount)
            currentAbsorb = healing - absorbAmount;

        absorbAmount += currentAbsorb;

        // Reduce shield amount
        (*i)->SetAmount((*i)->GetAmount() - currentAbsorb);
        // Need remove it later
        if ((*i)->GetAmount() <= 0)
            existExpired = true;
    }

    // Remove all expired absorb auras
    if (existExpired)
    {
        for (AuraEffectList::const_iterator i = vHealAbsorb.begin(); i != vHealAbsorb.end();)
        {
            AuraEffect* auraEff = *i;
            ++i;
            if (auraEff->GetAmount() <= 0)
            {
                uint32 removedAuras = healInfo.GetTarget()->m_removedAurasCount;
                auraEff->GetBase()->Remove(AURA_REMOVE_BY_ENEMY_SPELL);
                if (removedAuras + 1 < healInfo.GetTarget()->m_removedAurasCount)
                    i = vHealAbsorb.begin();
            }
        }
    }

    if (absorbAmount > 0)
        healInfo.AbsorbHeal(absorbAmount);
}

void Unit::AttackerStateUpdate(Unit* victim, WeaponAttackType attType /*= BASE_ATTACK*/, bool extra /*= false*/, bool ignoreCasting /*= false*/)
{
    if (HasUnitFlag(UNIT_FLAG_PACIFIED))
    {
        return;
    }

    if (HasUnitState(UNIT_STATE_CANNOT_AUTOATTACK) && !extra && !ignoreCasting)
    {
        return;
    }

    if (!victim->IsAlive())
        return;

    if ((attType == BASE_ATTACK || attType == OFF_ATTACK) && !IsWithinLOSInMap(victim))
        return;

    // CombatStart puts the target into stand state, so we need to cache sit state here to know if we should crit later
    const bool sittingVictim = victim->GetTypeId() == TYPEID_PLAYER && (victim->IsSitState() || victim->getStandState() == UNIT_STAND_STATE_SLEEP);

    CombatStart(victim);
    RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_MELEE_ATTACK);

    if (attType != BASE_ATTACK && attType != OFF_ATTACK)
        return;                                             // ignore ranged case

    if (!extra && _lastExtraAttackSpell)
    {
        _lastExtraAttackSpell = 0;
    }

    bool meleeAttack = true;

    // melee attack spell casted at main hand attack only - no normal melee dmg dealt
    if (attType == BASE_ATTACK && m_currentSpells[CURRENT_MELEE_SPELL] && !extra)
    {
        meleeAttack = false; // The melee attack is replaced by the melee spell

        Spell* meleeSpell = m_currentSpells[CURRENT_MELEE_SPELL];
        SpellCastResult castResult = meleeSpell->CheckCast(false);
        if (castResult != SPELL_CAST_OK)
        {
            meleeSpell->SendCastResult(castResult);
            meleeSpell->SendInterrupted(0);

            meleeSpell->finish(false);
            meleeSpell->SetExecutedCurrently(false);

            if (castResult == SPELL_FAILED_NO_POWER)
            {
                // Not enough rage, do a regular melee attack instead
                meleeAttack = true;
            }
        }
        else
        {
            meleeSpell->cast(true);
        }
    }
    if (meleeAttack)
    {
        // attack can be redirected to another target
        victim = GetMeleeHitRedirectTarget(victim);
        CalcDamageInfo damageInfo;
        CalculateMeleeDamage(victim, &damageInfo, attType, sittingVictim);

        // Send log damage message to client
        for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
        {
            Unit::DealDamageMods(victim, damageInfo.damages[i].damage, &damageInfo.damages[i].absorb);
        }

        SendAttackStateUpdate(&damageInfo);

        //TriggerAurasProcOnEvent(damageInfo);

        _lastDamagedTargetGuid = victim->GetGUID();

        DealMeleeDamage(&damageInfo, true);

        DamageInfo dmgInfo(damageInfo);
        Unit::ProcDamageAndSpell(damageInfo.attacker, damageInfo.target, damageInfo.procAttacker, damageInfo.procVictim, damageInfo.procEx, dmgInfo.GetDamage(),
            damageInfo.attackType, nullptr, nullptr, -1, nullptr, &dmgInfo);

        if (GetTypeId() == TYPEID_PLAYER)
            LOG_DEBUG("entities.unit", "AttackerStateUpdate: (Player) {} attacked {} for {} dmg, absorbed {}, blocked {}, resisted {}.",
                                 GetGUID().ToString(), victim->GetGUID().ToString(), dmgInfo.GetDamage(), dmgInfo.GetAbsorb(), dmgInfo.GetBlock(), dmgInfo.GetResist());
        else
            LOG_DEBUG("entities.unit", "AttackerStateUpdate: (NPC) {} attacked {} for {} dmg, absorbed {}, blocked {}, resisted {}.",
                                 GetGUID().ToString(), victim->GetGUID().ToString(), dmgInfo.GetDamage(), dmgInfo.GetAbsorb(), dmgInfo.GetBlock(), dmgInfo.GetResist());

        // Let the pet know we've started attacking someting. Handles melee attacks only
        // Spells such as auto-shot and others handled in WorldSession::HandleCastSpellOpcode
        if (GetTypeId() == TYPEID_PLAYER && !m_Controlled.empty())
            for (Unit::ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
                if (Unit* pet = *itr)
                    if (pet->IsAlive() && pet->GetTypeId() == TYPEID_UNIT)
                        pet->ToCreature()->AI()->OwnerAttacked(victim);
    }
}

bool Unit::GetMeleeAttackPoint(Unit* attacker, Position& pos)
{
    if (!attacker)
    {
        return false;
    }

    AttackerSet attackers = getAttackers();

    if (attackers.size() <= 1) // if the attackers are not more than one
    {
        return false;
    }

    float meleeReach = GetExactDist2d(attacker);
    if (meleeReach <= 0)
    {
        return false;
    }

    float minAngle = 0;
    Unit *refUnit = nullptr;
    uint32 validAttackers = 0;

    double attackerSize = attacker->GetCollisionRadius();

    for (const auto& otherAttacker: attackers)
    {
        // if the otherAttacker is not valid, skip
        if (!otherAttacker || otherAttacker->GetGUID() == attacker->GetGUID() ||
            !otherAttacker->IsWithinMeleeRange(this) || otherAttacker->isMoving())
        {
            continue;
        }

        float curretAngle = atan(attacker->GetExactDist2d(otherAttacker) / meleeReach);
        if (minAngle == 0 || curretAngle < minAngle)
        {
            minAngle = curretAngle;
            refUnit = otherAttacker;
        }

        validAttackers++;
    }

    if (!validAttackers || !refUnit)
    {
        return false;
    }

    float contactDist = attackerSize + refUnit->GetCollisionRadius();
    float requiredAngle = atan(contactDist / meleeReach);
    float attackersAngle = atan(attacker->GetExactDist2d(refUnit) / meleeReach);

    // in instance: the more attacker there are, the higher will be the tollerance
    // outside: creatures should not intersecate
    float angleTollerance = attacker->GetMap()->IsDungeon() ? requiredAngle - requiredAngle * tanh(validAttackers / 5.0f) : requiredAngle;

    if (attackersAngle > angleTollerance)
    {
        return false;
    }

    double angle = atan(contactDist / meleeReach);

    float angularRadius = frand(0.1f, 0.3f) + angle;
    int8 direction = (urand(0, 1) ? -1 : 1);
    float currentAngle = GetAngle(refUnit);
    float absAngle = currentAngle + angularRadius * direction;

    float x, y, z;
    float distance = meleeReach - GetObjectSize();
    GetNearPoint(attacker, x, y, z, distance, 0.0f, absAngle);

    if (!GetMap()->CanReachPositionAndGetValidCoords(this, x, y, z, true, true))
    {
        GetNearPoint(attacker, x, y, z, distance, 0.0f, absAngle * -1); // try the other side

        if (!GetMap()->CanReachPositionAndGetValidCoords(this, x, y, z, true, true))
        {
            return false;
        }
    }

    pos.Relocate(x, y, z);

    return true;
}

void Unit::HandleProcExtraAttackFor(Unit* victim, uint32 count)
{
    while (count)
    {
        --count;
        AttackerStateUpdate(victim, BASE_ATTACK, true);
    }
}

void Unit::AddExtraAttacks(uint32 count)
{
    ObjectGuid targetGUID = _lastDamagedTargetGuid;
    if (!targetGUID)
    {
        if (ObjectGuid selection = GetTarget())
        {
            targetGUID = selection; // Spell was cast directly (not triggered by aura)
        }
        else
            return;
    }

    extraAttacksTargets[targetGUID] += count;
}

MeleeHitOutcome Unit::RollMeleeOutcomeAgainst(Unit const* victim, WeaponAttackType attType) const
{
    // This is only wrapper

    // Miss chance based on melee
    //float miss_chance = MeleeMissChanceCalc(victim, attType);
    float miss_chance = MeleeSpellMissChance(victim, attType, int32(GetWeaponSkillValue(attType, victim)) - int32(victim->GetMaxSkillValueForLevel(this)), 0);

    // Critical hit chance
    float crit_chance = GetUnitCriticalChance(attType, victim);
    if( crit_chance < 0 )
        crit_chance = 0;

    float dodge_chance = victim->GetUnitDodgeChance();
    float block_chance = victim->GetUnitBlockChance();
    float parry_chance = victim->GetUnitParryChance();

    // Useful if want to specify crit & miss chances for melee, else it could be removed
    //LOG_DEBUG("entities.unit", "MELEE OUTCOME: miss {} crit {} dodge {} parry {} block {}", miss_chance, crit_chance, dodge_chance, parry_chance, block_chance);

    return RollMeleeOutcomeAgainst(victim, attType, int32(crit_chance * 100), int32(miss_chance * 100), int32(dodge_chance * 100), int32(parry_chance * 100), int32(block_chance * 100));
}

MeleeHitOutcome Unit::RollMeleeOutcomeAgainst(Unit const* victim, WeaponAttackType attType, int32 crit_chance, int32 miss_chance, int32 dodge_chance, int32 parry_chance, int32 block_chance) const
{
    if (victim->GetTypeId() == TYPEID_UNIT && victim->ToCreature()->IsEvadingAttacks())
    {
        return MELEE_HIT_EVADE;
    }

    int32 attackerMaxSkillValueForLevel = GetMaxSkillValueForLevel(victim);
    int32 victimMaxSkillValueForLevel = victim->GetMaxSkillValueForLevel(this);

    int32 attackerWeaponSkill = GetWeaponSkillValue(attType, victim);
    int32 victimDefenseSkill = victim->GetDefenseSkillValue(this);

    sScriptMgr->OnBeforeRollMeleeOutcomeAgainst(this, victim, attType, attackerMaxSkillValueForLevel, victimMaxSkillValueForLevel, attackerWeaponSkill, victimDefenseSkill, crit_chance, miss_chance, dodge_chance, parry_chance, block_chance);

    // bonus from skills is 0.04%
    int32    skillBonus  = 4 * (attackerWeaponSkill - victimMaxSkillValueForLevel);
    int32    sum = 0, tmp = 0;
    int32    roll = urand (0, 10000);

    LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: skill bonus of {} for attacker", skillBonus);
    //LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: rolled {}, miss {}, dodge {}, parry {}, block {}, crit {}",
    //    roll, miss_chance, dodge_chance, parry_chance, block_chance, crit_chance);

    tmp = miss_chance;

    if (tmp > 0 && roll < (sum += tmp))
    {
        LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: MISS");
        return MELEE_HIT_MISS;
    }

    // Dodge chance

    // only players can't dodge if attacker is behind
    if (victim->GetTypeId() == TYPEID_PLAYER && !victim->HasInArc(M_PI, this) && !victim->HasAuraType(SPELL_AURA_IGNORE_HIT_DIRECTION))
    {
        //LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: attack came from behind and victim was a player.");
    }
    // Xinef: do not allow to dodge with CREATURE_FLAG_EXTRA_NO_DODGE flag
    else if (victim->GetTypeId() == TYPEID_PLAYER || !(victim->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_DODGE))
    {
        // Reduce dodge chance by attacker expertise rating
        if (GetTypeId() == TYPEID_PLAYER)
            dodge_chance -= int32(ToPlayer()->GetExpertiseDodgeOrParryReduction(attType) * 100);
        else
            dodge_chance -= GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE) * 25;

        // Modify dodge chance by attacker SPELL_AURA_MOD_COMBAT_RESULT_CHANCE
        dodge_chance += GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_COMBAT_RESULT_CHANCE, VICTIMSTATE_DODGE) * 100;
        dodge_chance = int32 (float (dodge_chance) * GetTotalAuraMultiplier(SPELL_AURA_MOD_ENEMY_DODGE));

        tmp = dodge_chance;

        // xinef: if casting or stunned - cant dodge
        if (victim->IsNonMeleeSpellCast(false, false, true) || victim->HasUnitState(UNIT_STATE_CONTROLLED))
            tmp = 0;

        if ((tmp > 0)                                        // check if unit _can_ dodge
                && ((tmp -= skillBonus) > 0)
                && roll < (sum += tmp))
        {
            LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: DODGE <{}, {})", sum - tmp, sum);
            return MELEE_HIT_DODGE;
        }
    }

    // parry & block chances

    // check if attack comes from behind, nobody can parry or block if attacker is behind
    if (!victim->HasInArc(M_PI, this) && !victim->HasAuraType(SPELL_AURA_IGNORE_HIT_DIRECTION))
    {
        LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: attack came from behind.");
    }
    else
    {
        // Reduce parry chance by attacker expertise rating
        if (GetTypeId() == TYPEID_PLAYER)
            parry_chance -= int32(ToPlayer()->GetExpertiseDodgeOrParryReduction(attType) * 100);
        else
            parry_chance -= GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE) * 25;

        if (victim->GetTypeId() == TYPEID_PLAYER || !(victim->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_PARRY))
        {
            tmp = parry_chance;

            // xinef: cant parry while casting or while stunned
            if (victim->IsNonMeleeSpellCast(false, false, true) || victim->HasUnitState(UNIT_STATE_CONTROLLED))
                tmp = 0;

            if (tmp > 0                                         // check if unit _can_ parry
                    && (tmp -= skillBonus) > 0
                    && roll < (sum += tmp))
            {
                LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: PARRY <{}, {})", sum - tmp, sum);
                return MELEE_HIT_PARRY;
            }
        }

        if (victim->GetTypeId() == TYPEID_PLAYER || !(victim->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_BLOCK))
        {
            tmp = block_chance;

            // xinef: cant block while casting or while stunned
            if (victim->IsNonMeleeSpellCast(false, false, true) || victim->HasUnitState(UNIT_STATE_CONTROLLED))
                tmp = 0;

            if (tmp > 0                                          // check if unit _can_ block
                    && (tmp -= skillBonus) > 0
                    && roll < (sum += tmp))
            {
                LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: BLOCK <{}, {})", sum - tmp, sum);
                return MELEE_HIT_BLOCK;
            }
        }
    }

    // Max 40% chance to score a glancing blow against mobs that are higher level (can do only players and pets and not with ranged weapon)
    if (attType != RANGED_ATTACK &&
            (GetTypeId() == TYPEID_PLAYER || IsPet()) &&
            victim->GetTypeId() != TYPEID_PLAYER && !victim->IsPet() &&
            GetLevel() < victim->getLevelForTarget(this))
    {
        // cap possible value (with bonuses > max skill)
        int32 skill = attackerWeaponSkill;
        int32 maxskill = attackerMaxSkillValueForLevel;
        skill = (skill > maxskill) ? maxskill : skill;

        tmp = (10 + (victimDefenseSkill - skill)) * 100;
        tmp = tmp > 4000 ? 4000 : tmp;
        if (roll < (sum += tmp))
        {
            LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: GLANCING <{}, {})", sum - 4000, sum);
            return MELEE_HIT_GLANCING;
        }
    }

    // mobs can score crushing blows if they're 4 or more levels above victim
    if (getLevelForTarget(victim) >= victim->getLevelForTarget(this) + 4 &&
            // can be from by creature (if can) or from controlled player that considered as creature
            !IsControlledByPlayer() &&
            !(GetTypeId() == TYPEID_UNIT && ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_CRUSHING_BLOWS))
    {
        // when their weapon skill is 15 or more above victim's defense skill
        tmp = victimDefenseSkill;
        int32 tmpmax = victimMaxSkillValueForLevel;
        // having defense above your maximum (from items, talents etc.) has no effect
        tmp = tmp > tmpmax ? tmpmax : tmp;
        // tmp = mob's level * 5 - player's current defense skill
        tmp = attackerMaxSkillValueForLevel - tmp;
        if (tmp >= 15)
        {
            // add 2% chance per lacking skill point, min. is 15%
            tmp = tmp * 200 - 1500;
            if (roll < (sum += tmp))
            {
                LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: CRUSHING <{}, {})", sum - tmp, sum);
                return MELEE_HIT_CRUSHING;
            }
        }
    }

    // Critical chance
    tmp = crit_chance;

    if (tmp > 0 && roll < (sum += tmp))
    {
        LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: CRIT <{}, {})", sum - tmp, sum);
        if (GetTypeId() == TYPEID_UNIT && (ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_CRIT))
        {
            LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: CRIT DISABLED)");
        }
        else
            return MELEE_HIT_CRIT;
    }

    LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: NORMAL");
    return MELEE_HIT_NORMAL;
}

uint32 Unit::CalculateDamage(WeaponAttackType attType, bool normalized, bool addTotalPct, uint8 itemDamagesMask /*= 0*/)
{
    float minDamage = 0.0f;
    float maxDamage = 0.0f;

    if (normalized || !addTotalPct || itemDamagesMask)
    {
        // get both by default
        if (!itemDamagesMask)
        {
            itemDamagesMask = (1 << 0) | (1 << 1);
        }

        for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
        {
            if (itemDamagesMask & (1 << i))
            {
                float minTmp, maxTmp;
                CalculateMinMaxDamage(attType, normalized, addTotalPct, minTmp, maxTmp, i);
                minDamage += minTmp;
                maxDamage += maxTmp;
            }
        }
    }
    else
    {
        switch (attType)
        {
            case RANGED_ATTACK:
                minDamage = GetFloatValue(UNIT_FIELD_MINRANGEDDAMAGE);
                maxDamage = GetFloatValue(UNIT_FIELD_MAXRANGEDDAMAGE);
                break;
            case BASE_ATTACK:
                minDamage = GetFloatValue(UNIT_FIELD_MINDAMAGE);
                maxDamage = GetFloatValue(UNIT_FIELD_MAXDAMAGE);
                break;
            case OFF_ATTACK:
                minDamage = GetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE);
                maxDamage = GetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE);
                break;
            default:
                break;
        }
    }

    minDamage = std::max(0.f, minDamage);
    maxDamage = std::max(0.f, maxDamage);

    if (minDamage > maxDamage)
    {
        std::swap(minDamage, maxDamage);
    }

    return urand(uint32(minDamage), uint32(maxDamage));
}

float Unit::CalculateLevelPenalty(SpellInfo const* spellProto) const
{
    if (GetTypeId() != TYPEID_PLAYER)
        return 1.0f;

    if (spellProto->SpellLevel <= 0 || spellProto->SpellLevel >= spellProto->MaxLevel)
        return 1.0f;

    float LvlPenalty = 0.0f;

    // xinef: added brackets
    if (spellProto->SpellLevel < 20)
        LvlPenalty = (20.0f - spellProto->SpellLevel) * 3.75f;

    float LvlFactor = (float(spellProto->SpellLevel) + 6.0f) / float(GetLevel());
    if (LvlFactor > 1.0f)
        LvlFactor = 1.0f;

    return AddPct(LvlFactor, -LvlPenalty);
}

void Unit::SendMeleeAttackStart(Unit* victim, Player* sendTo)
{
    WorldPacket data(SMSG_ATTACKSTART, 8 + 8);
    data << GetGUID();
    data << victim->GetGUID();
    if (sendTo)
        sendTo->SendDirectMessage(&data);
    else
        SendMessageToSet(&data, true);
    LOG_DEBUG("entities.unit", "WORLD: Sent SMSG_ATTACKSTART");
}

void Unit::SendMeleeAttackStop(Unit* victim)
{
    // pussywizard: calling SendMeleeAttackStop without clearing UNIT_STATE_MELEE_ATTACKING and then AttackStart the same player may spoil npc rotating!
    // pussywizard: this happens in some boss scripts, just add clearing here
    // ClearUnitState(UNIT_STATE_MELEE_ATTACKING); // commented out for now

    WorldPacket data(SMSG_ATTACKSTOP, (8 + 8 + 4));
    data << GetPackGUID();

    if (victim)
    {
        data << victim->GetPackGUID();
        data << (uint32)victim->isDead();
    }
    SendMessageToSet(&data, true);
    LOG_DEBUG("entities.unit", "WORLD: Sent SMSG_ATTACKSTOP");

    if (victim)
        LOG_DEBUG("entities.unit", "{} {} stopped attacking {} {}", (GetTypeId() == TYPEID_PLAYER ? "Player" : "Creature"), GetGUID().ToString(), (victim->GetTypeId() == TYPEID_PLAYER ? "player" : "creature"), victim->GetGUID().ToString());
    else
        LOG_DEBUG("entities.unit", "{} {} stopped attacking", (GetTypeId() == TYPEID_PLAYER ? "Player" : "Creature"), GetGUID().ToString());
}

bool Unit::isSpellBlocked(Unit* victim, SpellInfo const* spellProto, WeaponAttackType attackType)
{
    // These spells can't be blocked
    if (spellProto && spellProto->HasAttribute(SPELL_ATTR0_NO_ACTIVE_DEFENSE))
        return false;

    if (victim->HasAuraType(SPELL_AURA_IGNORE_HIT_DIRECTION) || victim->HasInArc(M_PI, this))
    {
        // Check creatures flags_extra for disable block
        if (victim->GetTypeId() == TYPEID_UNIT &&
                victim->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_NO_BLOCK)
            return false;

        float blockChance = victim->GetUnitBlockChance();
        blockChance += (int32(GetWeaponSkillValue(attackType)) - int32(victim->GetMaxSkillValueForLevel())) * 0.04f;

        // xinef: cant block while casting or while stunned
        if (blockChance < 0.0f || victim->IsNonMeleeSpellCast(false, false, true) || victim->HasUnitState(UNIT_STATE_CONTROLLED))
            blockChance = 0.0f;

        if (roll_chance_f(blockChance))
            return true;
    }
    return false;
}

bool Unit::isBlockCritical()
{
    if (roll_chance_i(GetTotalAuraModifier(SPELL_AURA_MOD_BLOCK_CRIT_CHANCE)))
        return true;
    return false;
}

int32 Unit::GetMechanicResistChance(SpellInfo const* spell)
{
    if (!spell)
        return 0;
    int32 resist_mech = 0;
    for (uint8 eff = 0; eff < MAX_SPELL_EFFECTS; ++eff)
    {
        if (!spell->Effects[eff].IsEffect())
            break;
        int32 effect_mech = spell->GetEffectMechanic(eff);
        if (effect_mech)
        {
            int32 temp = GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_MECHANIC_RESISTANCE, effect_mech);
            if (resist_mech < temp)
                resist_mech = temp;
        }
    }
    return resist_mech;
}

// Melee based spells hit result calculations
SpellMissInfo Unit::MeleeSpellHitResult(Unit* victim, SpellInfo const* spellInfo)
{
    // Spells with SPELL_ATTR3_ALWAYS_HIT will additionally fully ignore
    // resist and deflect chances
    if (spellInfo->HasAttribute(SPELL_ATTR3_ALWAYS_HIT))
        return SPELL_MISS_NONE;

    WeaponAttackType attType = BASE_ATTACK;

    // Check damage class instead of attack type to correctly handle judgements
    // - they are meele, but can't be dodged/parried/deflected because of ranged dmg class
    if (spellInfo->DmgClass == SPELL_DAMAGE_CLASS_RANGED)
        attType = RANGED_ATTACK;

    int32 attackerWeaponSkill;
    // skill value for these spells (for example judgements) is 5* level
    if (spellInfo->DmgClass == SPELL_DAMAGE_CLASS_RANGED && !spellInfo->IsRangedWeaponSpell())
        attackerWeaponSkill = GetLevel() * 5;
    // bonus from skills is 0.04% per skill Diff
    else
        attackerWeaponSkill = int32(GetWeaponSkillValue(attType, victim));

    int32 skillDiff = attackerWeaponSkill - int32(victim->GetMaxSkillValueForLevel(this));

    uint32 roll = urand (0, 10000);

    uint32 missChance = uint32(MeleeSpellMissChance(victim, attType, skillDiff, spellInfo->Id) * 100.0f);
    // Roll miss
    uint32 tmp = missChance;
    if (roll < tmp)
        return SPELL_MISS_MISS;

    bool canDodge = !spellInfo->HasAttribute(SPELL_ATTR7_NO_ATTACK_DODGE);
    bool canParry = !spellInfo->HasAttribute(SPELL_ATTR7_NO_ATTACK_PARRY);
    bool canBlock = spellInfo->HasAttribute(SPELL_ATTR3_COMPLETELY_BLOCKED) && !spellInfo->HasAttribute(SPELL_ATTR0_CU_DIRECT_DAMAGE);

    // Same spells cannot be parry/dodge
    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_ACTIVE_DEFENSE))
        return SPELL_MISS_NONE;

    // Chance resist mechanic
    int32 resist_chance = victim->GetMechanicResistChance(spellInfo) * 100;
    tmp += resist_chance;
    if (roll < tmp)
        return SPELL_MISS_RESIST;

    // Ranged attacks can only miss, resist and deflect
    if (attType == RANGED_ATTACK)
    {
        // only if in front
        if (!victim->HasUnitState(UNIT_STATE_STUNNED) && (victim->HasInArc(M_PI, this) || victim->HasAuraType(SPELL_AURA_IGNORE_HIT_DIRECTION)))
        {
            int32 deflect_chance = victim->GetTotalAuraModifier(SPELL_AURA_DEFLECT_SPELLS) * 100;
            tmp += deflect_chance;
            if (roll < tmp)
                return SPELL_MISS_DEFLECT;
        }

        canDodge = false;
        canParry = false;
    }

    // Check for attack from behind
    // xinef: if from behind or spell requires cast from behind
    if (!victim->HasInArc(M_PI, this))
    {
        if (!victim->HasAuraType(SPELL_AURA_IGNORE_HIT_DIRECTION) || spellInfo->HasAttribute(SPELL_ATTR0_CU_REQ_CASTER_BEHIND_TARGET))
        {
            // Can`t dodge from behind in PvP (but its possible in PvE)
            if (victim->GetTypeId() == TYPEID_PLAYER)
            {
                canDodge = false;
            }

            // Can`t parry or block
            canParry = false;
            canBlock = false;
        }
    }

    // Check creatures flags_extra for disable parry
    if (victim->GetTypeId() == TYPEID_UNIT)
    {
        uint32 flagEx = victim->ToCreature()->GetCreatureTemplate()->flags_extra;
        // Xinef: no dodge flag
        if (flagEx & CREATURE_FLAG_EXTRA_NO_DODGE)
            canDodge = false;
        if (flagEx & CREATURE_FLAG_EXTRA_NO_PARRY)
            canParry = false;
        // Check creatures flags_extra for disable block
        if (flagEx & CREATURE_FLAG_EXTRA_NO_BLOCK)
            canBlock = false;
    }
    // Ignore combat result aura
    AuraEffectList const& ignore = GetAuraEffectsByType(SPELL_AURA_IGNORE_COMBAT_RESULT);
    for (AuraEffectList::const_iterator i = ignore.begin(); i != ignore.end(); ++i)
    {
        if (!(*i)->IsAffectedOnSpell(spellInfo))
            continue;
        switch ((*i)->GetMiscValue())
        {
            case MELEE_HIT_DODGE:
                canDodge = false;
                break;
            case MELEE_HIT_BLOCK:
                canBlock = false;
                break;
            case MELEE_HIT_PARRY:
                canParry = false;
                break;
            default:
                LOG_DEBUG("entities.unit", "Spell {} SPELL_AURA_IGNORE_COMBAT_RESULT has unhandled state {}", (*i)->GetId(), (*i)->GetMiscValue());
                break;
        }
    }

    if (canDodge)
    {
        // Roll dodge
        int32 dodgeChance = int32(victim->GetUnitDodgeChance() * 100.0f) - skillDiff * 4;
        // Reduce enemy dodge chance by SPELL_AURA_MOD_COMBAT_RESULT_CHANCE
        dodgeChance += GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_COMBAT_RESULT_CHANCE, VICTIMSTATE_DODGE) * 100;
        dodgeChance = int32(float(dodgeChance) * GetTotalAuraMultiplier(SPELL_AURA_MOD_ENEMY_DODGE));
        // Reduce dodge chance by attacker expertise rating
        if (GetTypeId() == TYPEID_PLAYER)
            dodgeChance -= int32(ToPlayer()->GetExpertiseDodgeOrParryReduction(attType) * 100.0f);
        else
            dodgeChance -= GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE) * 25;

        // xinef: cant dodge while casting or while stunned
        if (dodgeChance < 0 || victim->IsNonMeleeSpellCast(false, false, true) || victim->HasUnitState(UNIT_STATE_CONTROLLED))
            dodgeChance = 0;

        tmp += dodgeChance;
        if (roll < tmp)
            return SPELL_MISS_DODGE;
    }

    if (canParry)
    {
        // Roll parry
        int32 parryChance = int32(victim->GetUnitParryChance() * 100.0f)  - skillDiff * 4;
        // Reduce parry chance by attacker expertise rating
        if (GetTypeId() == TYPEID_PLAYER)
            parryChance -= int32(ToPlayer()->GetExpertiseDodgeOrParryReduction(attType) * 100.0f);
        else
            parryChance -= GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE) * 25;

        // xinef: cant parry while casting or while stunned
        if (parryChance < 0 || victim->IsNonMeleeSpellCast(false, false, true) || victim->HasUnitState(UNIT_STATE_CONTROLLED))
            parryChance = 0;

        tmp += parryChance;
        if (roll < tmp)
            return SPELL_MISS_PARRY;
    }

    if (canBlock)
    {
        int32 blockChance = int32(victim->GetUnitBlockChance() * 100.0f) - skillDiff * 4;

        // xinef: cant block while casting or while stunned
        if (blockChance < 0 || victim->IsNonMeleeSpellCast(false, false, true) || victim->HasUnitState(UNIT_STATE_CONTROLLED))
            blockChance = 0;

        tmp += blockChance;
        if (roll < tmp)
            return SPELL_MISS_BLOCK;
    }

    return SPELL_MISS_NONE;
}

SpellMissInfo Unit::MagicSpellHitResult(Unit* victim, SpellInfo const* spellInfo)
{
    // Can`t miss on dead target (on skinning for example)
    if (!victim->IsAlive() && victim->GetTypeId() != TYPEID_PLAYER)
        return SPELL_MISS_NONE;

    // vehicles cant miss
    if (IsVehicle())
        return SPELL_MISS_NONE;

    // Spells with SPELL_ATTR3_ALWAYS_HIT will additionally fully ignore
    // resist and deflect chances
    // xinef: skip all calculations, proof: Toxic Tolerance quest
    if (spellInfo->HasAttribute(SPELL_ATTR3_ALWAYS_HIT))
        return SPELL_MISS_NONE;

    if (spellInfo->HasAttribute(SPELL_ATTR7_NO_ATTACK_MISS))
    {
        return SPELL_MISS_NONE;
    }

    SpellSchoolMask schoolMask = spellInfo->GetSchoolMask();
    int32 thisLevel = getLevelForTarget(victim);
    if (GetTypeId() == TYPEID_UNIT && ToCreature()->IsTrigger())
        thisLevel = std::max<int32>(thisLevel, spellInfo->SpellLevel);
    int32 levelDiff = int32(victim->getLevelForTarget(this)) - thisLevel;

    int32 MISS_CHANCE_MULTIPLIER;
    if (sWorld->getBoolConfig(CONFIG_MISS_CHANCE_MULTIPLIER_ONLY_FOR_PLAYERS) && GetTypeId() != TYPEID_PLAYER) // keep it as it was originally (7 and 11)
    {
        MISS_CHANCE_MULTIPLIER = victim->GetTypeId() == TYPEID_PLAYER ? 7 : 11;
    }
    else
    {
        MISS_CHANCE_MULTIPLIER = sWorld->getRate(
            victim->GetTypeId() == TYPEID_PLAYER
            ? RATE_MISS_CHANCE_MULTIPLIER_TARGET_PLAYER
            : RATE_MISS_CHANCE_MULTIPLIER_TARGET_CREATURE);
    }

    // Base hit chance from attacker and victim levels
    int32 modHitChance = levelDiff < 3
            ? 96 - levelDiff
            : 94 - (levelDiff - 2) * MISS_CHANCE_MULTIPLIER;

    // Spellmod from SPELLMOD_RESIST_MISS_CHANCE
    if (Player* modOwner = GetSpellModOwner())
        modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_RESIST_MISS_CHANCE, modHitChance);

    // Increase from attacker SPELL_AURA_MOD_INCREASES_SPELL_PCT_TO_HIT auras
    modHitChance += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_INCREASES_SPELL_PCT_TO_HIT, schoolMask);

    // Spells with SPELL_ATTR3_ALWAYS_HIT will ignore target's avoidance effects
    // xinef: imo it should completly ignore all calculations, eg: 14792. Hits 80 level players on blizz without any problems
    //if (!spell->HasAttribute(SPELL_ATTR3_ALWAYS_HIT))
    {
        // Chance hit from victim SPELL_AURA_MOD_ATTACKER_SPELL_HIT_CHANCE auras
        modHitChance += victim->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_ATTACKER_SPELL_HIT_CHANCE, schoolMask);
        // Reduce spell hit chance for Area of effect spells from victim SPELL_AURA_MOD_AOE_AVOIDANCE aura
        if (spellInfo->IsAffectingArea())
            modHitChance -= victim->GetTotalAuraModifier(SPELL_AURA_MOD_AOE_AVOIDANCE);

        // Decrease hit chance from victim rating bonus
        if (victim->GetTypeId() == TYPEID_PLAYER)
            modHitChance -= int32(victim->ToPlayer()->GetRatingBonusValue(CR_HIT_TAKEN_SPELL));
    }

    int32 HitChance = modHitChance * 100;
    // Increase hit chance from attacker SPELL_AURA_MOD_SPELL_HIT_CHANCE and attacker ratings
    // Xinef: Totems should inherit casters ratings?
    if (IsTotem())
    {
        if (Unit* owner = GetOwner())
            HitChance += int32(owner->m_modSpellHitChance * 100.0f);
    }
    else
        HitChance += int32(m_modSpellHitChance * 100.0f);

    if (HitChance < 100)
        HitChance = 100;
    else if (HitChance > 10000)
        HitChance = 10000;

    int32 tmp = 10000 - HitChance;

    int32 rand = irand(1, 10000); // Needs to be  1 to 10000 to avoid the 1/10000 chance to miss on 100% hit rating

    if (rand < tmp)
        return SPELL_MISS_MISS;

    // Chance resist mechanic (select max value from every mechanic spell effect)
    int32 resist_chance = victim->GetMechanicResistChance(spellInfo) * 100;
    tmp += resist_chance;

    // Chance resist debuff
    if (!spellInfo->IsPositive() && !spellInfo->HasAttribute(SPELL_ATTR4_NO_CAST_LOG))
    {
        bool bNegativeAura = true;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            // Xinef: Check if effect exists!
            if (spellInfo->Effects[i].IsEffect() && spellInfo->Effects[i].ApplyAuraName == 0)
            {
                bNegativeAura = false;
                break;
            }
        }

        if (bNegativeAura)
        {
            tmp += victim->GetMaxPositiveAuraModifierByMiscValue(SPELL_AURA_MOD_DEBUFF_RESISTANCE, int32(spellInfo->Dispel)) * 100;
            tmp += victim->GetMaxNegativeAuraModifierByMiscValue(SPELL_AURA_MOD_DEBUFF_RESISTANCE, int32(spellInfo->Dispel)) * 100;
        }

        // Players resistance for binary spells
        if (spellInfo->HasAttribute(SPELL_ATTR0_CU_BINARY_SPELL) && (spellInfo->GetSchoolMask() & (SPELL_SCHOOL_MASK_NORMAL | SPELL_SCHOOL_MASK_HOLY)) == 0)
            tmp += int32(Unit::GetEffectiveResistChance(this, spellInfo->GetSchoolMask(), victim) * 10000.0f); // 100 for spell calculations, and 100 for return value percentage
    }

    // Roll chance
    if (rand < tmp)
        return SPELL_MISS_RESIST;

    // cast by caster in front of victim
    if (!victim->HasUnitState(UNIT_STATE_STUNNED) && (victim->HasInArc(M_PI, this) || victim->HasAuraType(SPELL_AURA_IGNORE_HIT_DIRECTION)))
    {
        int32 deflect_chance = victim->GetTotalAuraModifier(SPELL_AURA_DEFLECT_SPELLS) * 100;
        tmp += deflect_chance;
        if (rand < tmp)
            return SPELL_MISS_DEFLECT;
    }

    return SPELL_MISS_NONE;
}

// Calculate spell hit result can be:
// Every spell can: Evade/Immune/Reflect/Sucesful hit
// For melee based spells:
//   Miss
//   Dodge
//   Parry
// For spells
//   Resist
SpellMissInfo Unit::SpellHitResult(Unit* victim, SpellInfo const* spell, bool CanReflect)
{
    // Check for immune
    if (victim->IsImmunedToSpell(spell))
        return SPELL_MISS_IMMUNE;

    // All positive spells can`t miss
    /// @todo: client not show miss log for this spells - so need find info for this in dbc and use it!
    if ((spell->IsPositive() || spell->HasEffect(SPELL_EFFECT_DISPEL))
            && (!IsHostileTo(victim))) // prevent from affecting enemy by "positive" spell
        return SPELL_MISS_NONE;

    // Check for immune
    // xinef: check for school immunity only
    if (victim->IsImmunedToSchool(spell))
        return SPELL_MISS_IMMUNE;

    if (this == victim)
        return SPELL_MISS_NONE;

    // Return evade for units in evade mode
    if (victim->GetTypeId() == TYPEID_UNIT && victim->ToCreature()->IsEvadingAttacks() && !spell->HasAura(SPELL_AURA_CONTROL_VEHICLE)
        && !spell->HasAttribute(SPELL_ATTR0_CU_IGNORE_EVADE) && !spell->HasAttribute(SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT))
        return SPELL_MISS_EVADE;

    // Try victim reflect spell
    if (CanReflect)
    {
        int32 reflectchance = victim->GetTotalAuraModifier(SPELL_AURA_REFLECT_SPELLS);
        Unit::AuraEffectList const& mReflectSpellsSchool = victim->GetAuraEffectsByType(SPELL_AURA_REFLECT_SPELLS_SCHOOL);
        for (Unit::AuraEffectList::const_iterator i = mReflectSpellsSchool.begin(); i != mReflectSpellsSchool.end(); ++i)
            if ((*i)->GetMiscValue() & spell->GetSchoolMask())
                reflectchance += (*i)->GetAmount();
        if (reflectchance > 0 && roll_chance_i(reflectchance))
        {
            // Start triggers for remove charges if need (trigger only for victim, and mark as active spell)
            //ProcDamageAndSpell(victim, PROC_FLAG_NONE, PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG, PROC_EX_REFLECT, 1, BASE_ATTACK, spell);
            return SPELL_MISS_REFLECT;
        }
    }

    switch (spell->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_RANGED:
        case SPELL_DAMAGE_CLASS_MELEE:
            return MeleeSpellHitResult(victim, spell);
        case SPELL_DAMAGE_CLASS_NONE:
            {
                if (spell->SpellFamilyName)
                {
                    return SPELL_MISS_NONE;
                }
                // Xinef: apply DAMAGE_CLASS_MAGIC conditions to damaging DAMAGE_CLASS_NONE spells
                for (uint8 i = EFFECT_0; i < MAX_SPELL_EFFECTS; ++i)
                    if (spell->Effects[i].Effect && spell->Effects[i].Effect != SPELL_EFFECT_SCHOOL_DAMAGE)
                        if (spell->Effects[i].ApplyAuraName != SPELL_AURA_PERIODIC_DAMAGE)
                            return SPELL_MISS_NONE;
                [[fallthrough]];
            }
        case SPELL_DAMAGE_CLASS_MAGIC:
            return MagicSpellHitResult(victim, spell);
    }
    return SPELL_MISS_NONE;
}

SpellMissInfo Unit::SpellHitResult(Unit* victim, Spell const* spell, bool CanReflect)
{
    SpellInfo const* spellInfo = spell->GetSpellInfo();

    // Check for immune
    if (victim->IsImmunedToSpell(spellInfo, spell))
    {
        return SPELL_MISS_IMMUNE;
    }

    // All positive spells can`t miss
    /// @todo: client not show miss log for this spells - so need find info for this in dbc and use it!
    if ((spellInfo->IsPositive() || spellInfo->HasEffect(SPELL_EFFECT_DISPEL))
        && (!IsHostileTo(victim))) // prevent from affecting enemy by "positive" spell
    {
        return SPELL_MISS_NONE;
    }

    // Check for immune
    // xinef: check for school immunity only
    if (victim->IsImmunedToSchool(spell))
    {
        return SPELL_MISS_IMMUNE;
    }

    if (this == victim)
    {
        return SPELL_MISS_NONE;
    }

    // Return evade for units in evade mode
    if (victim->GetTypeId() == TYPEID_UNIT && victim->ToCreature()->IsEvadingAttacks() && !spellInfo->HasAura(SPELL_AURA_CONTROL_VEHICLE) &&
        !spellInfo->HasAttribute(SPELL_ATTR0_CU_IGNORE_EVADE) && !spellInfo->HasAttribute(SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT))
    {
        return SPELL_MISS_EVADE;
    }

    // Try victim reflect spell
    if (CanReflect)
    {
        int32 reflectchance = victim->GetTotalAuraModifier(SPELL_AURA_REFLECT_SPELLS);
        Unit::AuraEffectList const& mReflectSpellsSchool = victim->GetAuraEffectsByType(SPELL_AURA_REFLECT_SPELLS_SCHOOL);
        for (Unit::AuraEffectList::const_iterator i = mReflectSpellsSchool.begin(); i != mReflectSpellsSchool.end(); ++i)
        {
            if ((*i)->GetMiscValue() & spell->GetSpellSchoolMask())
            {
                reflectchance += (*i)->GetAmount();
            }
        }

        if (reflectchance > 0 && roll_chance_i(reflectchance))
        {
            // Start triggers for remove charges if need (trigger only for victim, and mark as active spell)
            //ProcDamageAndSpell(victim, PROC_FLAG_NONE, PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG, PROC_EX_REFLECT, 1, BASE_ATTACK, spell);
            return SPELL_MISS_REFLECT;
        }
    }

    switch (spellInfo->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_RANGED:
        case SPELL_DAMAGE_CLASS_MELEE:
            return MeleeSpellHitResult(victim, spellInfo);
        case SPELL_DAMAGE_CLASS_NONE:
        {
            if (spellInfo->SpellFamilyName)
            {
                return SPELL_MISS_NONE;
            }

            // Xinef: apply DAMAGE_CLASS_MAGIC conditions to damaging DAMAGE_CLASS_NONE spells
            for (uint8 i = EFFECT_0; i < MAX_SPELL_EFFECTS; ++i)
            {
                if (spellInfo->Effects[i].Effect && spellInfo->Effects[i].Effect != SPELL_EFFECT_SCHOOL_DAMAGE)
                {
                    if (spellInfo->Effects[i].ApplyAuraName != SPELL_AURA_PERIODIC_DAMAGE)
                    {
                        return SPELL_MISS_NONE;
                    }
                }
            }
            [[fallthrough]];
        }
        case SPELL_DAMAGE_CLASS_MAGIC:
            return MagicSpellHitResult(victim, spellInfo);
    }

    return SPELL_MISS_NONE;
}

uint32 Unit::GetDefenseSkillValue(Unit const* target) const
{
    if (GetTypeId() == TYPEID_PLAYER)
    {
        // in PvP use full skill instead current skill value
        uint32 value = (target && target->GetTypeId() == TYPEID_PLAYER)
                       ? ToPlayer()->GetMaxSkillValue(SKILL_DEFENSE)
                       : ToPlayer()->GetSkillValue(SKILL_DEFENSE);
        value += uint32(ToPlayer()->GetRatingBonusValue(CR_DEFENSE_SKILL));
        return value;
    }
    else
        return GetUnitMeleeSkill(target);
}

float Unit::GetUnitDodgeChance() const
{
    if (GetTypeId() == TYPEID_PLAYER)
        return ToPlayer()->GetRealDodge(); //GetFloatValue(PLAYER_DODGE_PERCENTAGE);
    else
    {
        if (ToCreature()->IsTotem())
            return 0.0f;
        else
        {
            float dodge = ToCreature()->isWorldBoss() ? 5.85f : 5.0f; // Xinef: bosses should have 6.5% dodge (5.9 + 0.6 from defense skill difference)
            dodge += GetTotalAuraModifier(SPELL_AURA_MOD_DODGE_PERCENT);
            return dodge > 0.0f ? dodge : 0.0f;
        }
    }
}

float Unit::GetUnitParryChance() const
{
    float chance = 0.0f;

    if (Player const* player = ToPlayer())
    {
        if (player->CanParry())
        {
            Item* tmpitem = player->GetWeaponForAttack(BASE_ATTACK, true);
            if (!tmpitem)
                tmpitem = player->GetWeaponForAttack(OFF_ATTACK, true);

            if (tmpitem)
                chance = player->GetRealParry(); //GetFloatValue(PLAYER_PARRY_PERCENTAGE);
        }
    }
    else if (GetTypeId() == TYPEID_UNIT)
    {
        if (ToCreature()->isWorldBoss())
            chance = 13.4f; // + 0.6 by skill diff
        else if (GetCreatureType() == CREATURE_TYPE_HUMANOID)
            chance = 5.0f;

        // Xinef: if aura is present, type should not matter
        chance += GetTotalAuraModifier(SPELL_AURA_MOD_PARRY_PERCENT);
    }

    return chance > 0.0f ? chance : 0.0f;
}

float Unit::GetUnitMissChance(WeaponAttackType attType) const
{
    float miss_chance = 5.00f;

    if (Player const* player = ToPlayer())
        miss_chance += player->GetMissPercentageFromDefence();

    if (attType == RANGED_ATTACK)
        miss_chance -= GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_RANGED_HIT_CHANCE);
    else
        miss_chance -= GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_MELEE_HIT_CHANCE);

    return miss_chance;
}

float Unit::GetUnitBlockChance() const
{
    if (Player const* player = ToPlayer())
    {
        if (player->CanBlock())
        {
            Item* tmpitem = player->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
            if (tmpitem && !tmpitem->IsBroken() && tmpitem->GetTemplate()->Block)
                return GetFloatValue(PLAYER_BLOCK_PERCENTAGE);
        }
        // is player but has no block ability or no not broken shield equipped
        return 0.0f;
    }
    else
    {
        if (ToCreature()->IsTotem())
            return 0.0f;
        else
        {
            float block = 5.0f;
            block += GetTotalAuraModifier(SPELL_AURA_MOD_BLOCK_PERCENT);
            return block > 0.0f ? block : 0.0f;
        }
    }
}

float Unit::GetUnitCriticalChance(WeaponAttackType attackType, Unit const* victim) const
{
    float crit;

    if (GetTypeId() == TYPEID_PLAYER)
    {
        switch (attackType)
        {
            case BASE_ATTACK:
                crit = GetFloatValue(PLAYER_CRIT_PERCENTAGE);
                break;
            case OFF_ATTACK:
                crit = GetFloatValue(PLAYER_OFFHAND_CRIT_PERCENTAGE);
                break;
            case RANGED_ATTACK:
                crit = GetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE);
                break;
            // Just for good manner
            default:
                crit = 0.0f;
                break;
        }
    }
    else
    {
        crit = 5.0f;
        crit += GetTotalAuraModifier(SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
        crit += GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_PCT);
    }

    // flat aura mods
    if (attackType == RANGED_ATTACK)
        crit += victim->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_CHANCE);
    else
        crit += victim->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE);

    AuraEffectList const& mTotalAuraList = victim->GetAuraEffectsByType(SPELL_AURA_MOD_CRIT_CHANCE_FOR_CASTER);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if (GetGUID() != (*i)->GetCasterGUID())
            continue;

        crit += (*i)->GetAmount();
    }

    // reduce crit chance from Rating for players
    if (attackType != RANGED_ATTACK)
        Unit::ApplyResilience(victim, &crit, nullptr, false, CR_CRIT_TAKEN_MELEE);
    else
        Unit::ApplyResilience(victim, &crit, nullptr, false, CR_CRIT_TAKEN_RANGED);

    // Apply crit chance from defence skill
    crit += (int32(GetMaxSkillValueForLevel(victim)) - int32(victim->GetDefenseSkillValue(this))) * 0.04f;

    // xinef: SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE should be calculated at the end
    crit += victim->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE);

    if (crit < 0.0f)
        crit = 0.0f;
    return crit;
}

uint32 Unit::GetWeaponSkillValue (WeaponAttackType attType, Unit const* target) const
{
    uint32 value = 0;
    if (Player const* player = ToPlayer())
    {
        Item* item = player->GetWeaponForAttack(attType, true);

        // feral or unarmed skill only for base attack
        if (attType != BASE_ATTACK && !item)
            return 0;

        if (IsInFeralForm())
            return GetMaxSkillValueForLevel();              // always maximized SKILL_FERAL_COMBAT in fact

        // weapon skill or (unarmed for base attack)
        uint32 skill = SKILL_UNARMED;
        if (item)
            skill = item->GetSkill();

        // in PvP use full skill instead current skill value
        value = (target && target->IsControlledByPlayer())
                ? player->GetMaxSkillValue(skill)
                : player->GetSkillValue(skill);
        // Modify value from ratings
        value += uint32(player->GetRatingBonusValue(CR_WEAPON_SKILL));
        switch (attType)
        {
            case BASE_ATTACK:
                value += uint32(player->GetRatingBonusValue(CR_WEAPON_SKILL_MAINHAND));
                break;
            case OFF_ATTACK:
                value += uint32(player->GetRatingBonusValue(CR_WEAPON_SKILL_OFFHAND));
                break;
            case RANGED_ATTACK:
                value += uint32(player->GetRatingBonusValue(CR_WEAPON_SKILL_RANGED));
                break;
            default:
                break;
        }
    }
    else
        value = GetUnitMeleeSkill(target);
    return value;
}

void Unit::_DeleteRemovedAuras()
{
    while (!m_removedAuras.empty())
    {
        delete m_removedAuras.front();
        m_removedAuras.pop_front();
    }
}

void Unit::_UpdateSpells(uint32 time)
{
    if (m_currentSpells[CURRENT_AUTOREPEAT_SPELL])
        _UpdateAutoRepeatSpell();

    // remove finished spells from current pointers
    for (uint32 i = 0; i < CURRENT_MAX_SPELL; ++i)
    {
        if (m_currentSpells[i] && m_currentSpells[i]->getState() == SPELL_STATE_FINISHED)
        {
            m_currentSpells[i]->SetReferencedFromCurrent(false);
            m_currentSpells[i] = nullptr;                      // remove pointer
        }
    }

    // m_auraUpdateIterator can be updated in indirect called code at aura remove to skip next planned to update but removed auras
    for (m_auraUpdateIterator = m_ownedAuras.begin(); m_auraUpdateIterator != m_ownedAuras.end();)
    {
        Aura* i_aura = m_auraUpdateIterator->second;
        ++m_auraUpdateIterator;                            // need shift to next for allow update if need into aura update
        i_aura->UpdateOwner(time, this);
    }

    // remove expired auras - do that after updates(used in scripts?)
    for (AuraMap::iterator i = m_ownedAuras.begin(); i != m_ownedAuras.end();)
    {
        if (i->second->IsExpired())
            RemoveOwnedAura(i, AURA_REMOVE_BY_EXPIRE);
        else if (i->second->GetSpellInfo()->IsChanneled() && i->second->GetCasterGUID() != GetGUID() && !ObjectAccessor::GetWorldObject(*this, i->second->GetCasterGUID()))
            RemoveOwnedAura(i, AURA_REMOVE_BY_CANCEL); // remove channeled auras when caster is not on the same map
        else
            ++i;
    }

    for (VisibleAuraMap::iterator itr = m_visibleAuras.begin(); itr != m_visibleAuras.end(); ++itr)
        if (itr->second->IsNeedClientUpdate())
            itr->second->ClientUpdate();

    _DeleteRemovedAuras();

    if (!m_gameObj.empty())
    {
        for (GameObjectList::iterator itr = m_gameObj.begin(); itr != m_gameObj.end();)
        {
            if (GameObject* go = ObjectAccessor::GetGameObject(*this, *itr))
                if (!go->isSpawned())
                {
                    go->SetOwnerGUID(ObjectGuid::Empty);
                    go->SetRespawnTime(0);
                    go->Delete();
                    m_gameObj.erase(itr++);
                    continue;
                }
            ++itr;
        }
    }
}

void Unit::_UpdateAutoRepeatSpell()
{
    SpellInfo const* spellProto = nullptr;
    if (m_currentSpells[CURRENT_AUTOREPEAT_SPELL])
    {
        spellProto = m_currentSpells[CURRENT_AUTOREPEAT_SPELL]->m_spellInfo;
    }

    if (!spellProto)
    {
        return;
    }

    static uint32 const HUNTER_AUTOSHOOT = 75;

    // Check "realtime" interrupts
    if ((GetTypeId() == TYPEID_PLAYER && ToPlayer()->isMoving() && spellProto->Id != HUNTER_AUTOSHOOT) || IsNonMeleeSpellCast(false, false, true, spellProto->Id == HUNTER_AUTOSHOOT))
    {
        // cancel wand shoot
        if (spellProto->Id != HUNTER_AUTOSHOOT)
            InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
        m_AutoRepeatFirstCast = true;
        return;
    }

    // Apply delay (Hunter's autoshoot not affected)
    if (m_AutoRepeatFirstCast && getAttackTimer(RANGED_ATTACK) < 500 && spellProto->Id != HUNTER_AUTOSHOOT)
    {
        setAttackTimer(RANGED_ATTACK, 500);
    }

    m_AutoRepeatFirstCast = false;

    // Check for ranged attack timer
    if (isAttackReady(RANGED_ATTACK))
    {
        SpellCastResult result = m_currentSpells[CURRENT_AUTOREPEAT_SPELL]->CheckCast(true);
        if (result != SPELL_CAST_OK)
        {
            if (spellProto->Id != HUNTER_AUTOSHOOT)
            {
                InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
            }

            return;
        }

        // We want to shoot
        Spell* spell = new Spell(this, spellProto, TRIGGERED_FULL_MASK);
        spell->prepare(&(m_currentSpells[CURRENT_AUTOREPEAT_SPELL]->m_targets));

        // Reset attack
        resetAttackTimer(RANGED_ATTACK);
    }
}

void Unit::SetCurrentCastedSpell(Spell* pSpell)
{
    ASSERT(pSpell);                                         // nullptr may be never passed here, use InterruptSpell or InterruptNonMeleeSpells

    CurrentSpellTypes CSpellType = pSpell->GetCurrentContainer();

    if (pSpell == m_currentSpells[CSpellType])             // avoid breaking self
        return;

    bool bySelf = m_currentSpells[CSpellType] && m_currentSpells[CSpellType]->m_spellInfo->Id == pSpell->m_spellInfo->Id;

    // break same type spell if it is not delayed
    InterruptSpell(CSpellType, false, true, bySelf);

    // special breakage effects:
    switch (CSpellType)
    {
        case CURRENT_GENERIC_SPELL:
            {
                // generic spells always break channeled not delayed spells
                if (Spell* s = GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                {
                    if (!s->GetSpellInfo()->IsActionAllowedChannel())
                    {
                        InterruptSpell(CURRENT_CHANNELED_SPELL, false);
                    }
                }

                // autorepeat breaking
                if (m_currentSpells[CURRENT_AUTOREPEAT_SPELL])
                {
                    // break autorepeat if not Auto Shot
                    if (m_currentSpells[CURRENT_AUTOREPEAT_SPELL]->m_spellInfo->Id != 75)
                        InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
                    m_AutoRepeatFirstCast = true;
                }

                // melee spells breaking
                if (m_currentSpells[CURRENT_MELEE_SPELL])
                {
                    // break melee spells if cast time
                    if (pSpell->GetCastTime() > 0)
                    {
                        InterruptSpell(CURRENT_MELEE_SPELL);
                    }
                }
                if (pSpell->GetCastTime() > 0)
                    AddUnitState(UNIT_STATE_CASTING);

                break;
            }
        case CURRENT_CHANNELED_SPELL:
            {
                // channel spells always break generic non-delayed and any channeled spells
                InterruptSpell(CURRENT_GENERIC_SPELL, false);
                InterruptSpell(CURRENT_CHANNELED_SPELL, true, true, bySelf);

                // it also does break autorepeat if not Auto Shot
                if (m_currentSpells[CURRENT_AUTOREPEAT_SPELL] &&
                        m_currentSpells[CURRENT_AUTOREPEAT_SPELL]->m_spellInfo->Id != 75)
                    InterruptSpell(CURRENT_AUTOREPEAT_SPELL);
                AddUnitState(UNIT_STATE_CASTING);

                break;
            }
        case CURRENT_AUTOREPEAT_SPELL:
            {
                // only Auto Shoot does not break anything
                if (pSpell->m_spellInfo->Id != 75)
                {
                    // generic autorepeats break generic non-delayed and channeled non-delayed spells
                    if (Spell* s = GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                    {
                        if (!s->GetSpellInfo()->IsActionAllowedChannel())
                        {
                            InterruptSpell(CURRENT_CHANNELED_SPELL, false);
                        }
                    }

                    InterruptSpell(CURRENT_CHANNELED_SPELL, false);
                }
                // special action: set first cast flag
                m_AutoRepeatFirstCast = true;

                break;
            }

        default:
            // other spell types don't break anything now
            break;
    }

    // current spell (if it is still here) may be safely deleted now
    if (m_currentSpells[CSpellType])
        m_currentSpells[CSpellType]->SetReferencedFromCurrent(false);

    // set new current spell
    m_currentSpells[CSpellType] = pSpell;
    pSpell->SetReferencedFromCurrent(true);

    pSpell->m_selfContainer = &(m_currentSpells[pSpell->GetCurrentContainer()]);
}

void Unit::InterruptSpell(CurrentSpellTypes spellType, bool withDelayed, bool withInstant, bool bySelf)
{
    //LOG_DEBUG("entities.unit", "Interrupt spell for unit {}.", GetEntry());
    Spell* spell = m_currentSpells[spellType];
    if (spell
            && (withDelayed || spell->getState() != SPELL_STATE_DELAYED)
            && (withInstant || spell->GetCastTime() > 0 || spell->getState() == SPELL_STATE_CASTING)) // xinef: or spell is in casting state (channeled spells only)
    {
        // for example, do not let self-stun aura interrupt itself
        if (!spell->IsInterruptable())
            return;

        // send autorepeat cancel message for autorepeat spells
        if (spellType == CURRENT_AUTOREPEAT_SPELL)
            if (GetTypeId() == TYPEID_PLAYER)
                ToPlayer()->SendAutoRepeatCancel(this);

        if (spell->getState() != SPELL_STATE_FINISHED)
            spell->cancel(bySelf);

        m_currentSpells[spellType] = nullptr;
        spell->SetReferencedFromCurrent(false);
    }
}

void Unit::FinishSpell(CurrentSpellTypes spellType, bool ok /*= true*/)
{
    Spell* spell = m_currentSpells[spellType];
    if (!spell)
        return;

    if (spellType == CURRENT_CHANNELED_SPELL)
        spell->SendChannelUpdate(0);

    spell->finish(ok);
}

bool Unit::IsNonMeleeSpellCast(bool withDelayed, bool skipChanneled, bool skipAutorepeat, bool isAutoshoot, bool skipInstant) const
{
    // We don't do loop here to explicitly show that melee spell is excluded.
    // Maybe later some special spells will be excluded too.

    // generic spells are cast when they are not finished and not delayed
    if (m_currentSpells[CURRENT_GENERIC_SPELL] &&
            (m_currentSpells[CURRENT_GENERIC_SPELL]->getState() != SPELL_STATE_FINISHED) &&
            (withDelayed || m_currentSpells[CURRENT_GENERIC_SPELL]->getState() != SPELL_STATE_DELAYED))
    {
        if (!skipInstant || m_currentSpells[CURRENT_GENERIC_SPELL]->GetCastTime())
        {
            if (!isAutoshoot || !m_currentSpells[CURRENT_GENERIC_SPELL]->m_spellInfo->HasAttribute(SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS))
                return true;
        }
    }
    // channeled spells may be delayed, but they are still considered cast
    if (!skipChanneled && m_currentSpells[CURRENT_CHANNELED_SPELL] &&
            (m_currentSpells[CURRENT_CHANNELED_SPELL]->getState() != SPELL_STATE_FINISHED))
    {
        if (!isAutoshoot || !m_currentSpells[CURRENT_CHANNELED_SPELL]->m_spellInfo->HasAttribute(SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS))
            return true;
    }
    // autorepeat spells may be finished or delayed, but they are still considered cast
    if (!skipAutorepeat && m_currentSpells[CURRENT_AUTOREPEAT_SPELL])
        return true;

    return false;
}

void Unit::InterruptNonMeleeSpells(bool withDelayed, uint32 spell_id, bool withInstant, bool bySelf)
{
    // generic spells are interrupted if they are not finished or delayed
    if (m_currentSpells[CURRENT_GENERIC_SPELL] && (!spell_id || m_currentSpells[CURRENT_GENERIC_SPELL]->m_spellInfo->Id == spell_id))
        InterruptSpell(CURRENT_GENERIC_SPELL, withDelayed, withInstant, bySelf);

    // autorepeat spells are interrupted if they are not finished or delayed
    if (m_currentSpells[CURRENT_AUTOREPEAT_SPELL] && (!spell_id || m_currentSpells[CURRENT_AUTOREPEAT_SPELL]->m_spellInfo->Id == spell_id))
        InterruptSpell(CURRENT_AUTOREPEAT_SPELL, withDelayed, withInstant, bySelf);

    // channeled spells are interrupted if they are not finished, even if they are delayed
    if (m_currentSpells[CURRENT_CHANNELED_SPELL] && (!spell_id || m_currentSpells[CURRENT_CHANNELED_SPELL]->m_spellInfo->Id == spell_id))
        InterruptSpell(CURRENT_CHANNELED_SPELL, true, true, bySelf);
}

Spell* Unit::FindCurrentSpellBySpellId(uint32 spell_id) const
{
    for (uint32 i = 0; i < CURRENT_MAX_SPELL; i++)
        if (m_currentSpells[i] && m_currentSpells[i]->m_spellInfo->Id == spell_id)
            return m_currentSpells[i];
    return nullptr;
}

int32 Unit::GetCurrentSpellCastTime(uint32 spell_id) const
{
    if (Spell const* spell = FindCurrentSpellBySpellId(spell_id))
        return spell->GetCastTime();
    return 0;
}

bool Unit::IsMovementPreventedByCasting() const
{
    // can always move when not casting
    if (!HasUnitState(UNIT_STATE_CASTING))
    {
        return false;
    }

    // channeled spells during channel stage (after the initial cast timer) allow movement with a specific spell attribute
    if (Spell* spell = m_currentSpells[CURRENT_CHANNELED_SPELL])
    {
        if (spell->getState() != SPELL_STATE_FINISHED && spell->IsChannelActive())
        {
            if (spell->GetSpellInfo()->IsActionAllowedChannel())
            {
                return false;
            }
        }
    }

    // prohibit movement for all other spell casts
    return true;
}

bool Unit::isInFrontInMap(Unit const* target, float distance,  float arc) const
{
    return IsWithinDistInMap(target, distance) && HasInArc(arc, target);
}

bool Unit::isInBackInMap(Unit const* target, float distance, float arc) const
{
    return IsWithinDistInMap(target, distance) && !HasInArc(2 * M_PI - arc, target);
}

bool Unit::isInAccessiblePlaceFor(Creature const* c) const
{
    if (c->GetMapId() == 618) // Ring of Valor
    {
        // skip transport check, check for being below floor level
        if (this->GetPositionZ() < 28.0f)
            return false;
        if (BattlegroundMap* bgMap = c->GetMap()->ToBattlegroundMap())
            if (Battleground* bg = bgMap->GetBG())
                if (bg->GetStartTime() < 80133) // 60000ms preparation time + 20133ms elevator rise time
                    return false;
    }
    else if (c->GetMapId() == 631) // Icecrown Citadel
    {
        // if static transport doesn't match - return false
        if (c->GetTransport() != this->GetTransport() && ((c->GetTransport() && c->GetTransport()->IsStaticTransport()) || (this->GetTransport() && this->GetTransport()->IsStaticTransport())))
            return false;

        // special handling for ICC (map 631), for non-flying pets in Gunship Battle, for trash npcs this is done via CanAIAttack
        if (c->GetOwnerGUID().IsPlayer() && !c->CanFly())
        {
            if (c->GetTransport() != this->GetTransport())
                return false;
            if (this->GetTransport())
            {
                if (c->GetPositionY() < 2033.0f)
                {
                    if (this->GetPositionY() > 2033.0f)
                        return false;
                }
                else if (c->GetPositionY() < 2438.0f)
                {
                    if (this->GetPositionY() < 2033.0f || this->GetPositionY() > 2438.0f)
                        return false;
                }
                else if (this->GetPositionY() < 2438.0f)
                    return false;
            }
        }
    }
    else
    {
        // pussywizard: prevent any bugs by passengers exiting transports or normal creatures flying away
        if (c->GetTransport() != this->GetTransport())
            return false;
    }

    LiquidStatus liquidStatus = GetLiquidData().Status;
    bool isInWater = (liquidStatus & MAP_LIQUID_STATUS_IN_CONTACT) != 0;

    // In water or jumping in water
    if (isInWater || (liquidStatus == LIQUID_MAP_ABOVE_WATER && (IsFalling() || (ToPlayer() && ToPlayer()->IsFalling()))))
    {
        return c->CanEnterWater();
    }
    else
    {
        return c->CanWalk() || c->CanFly();
    }
}

void Unit::ProcessPositionDataChanged(PositionFullTerrainStatus const& data)
{
    WorldObject::ProcessPositionDataChanged(data);
    ProcessTerrainStatusUpdate();
}

void Unit::ProcessTerrainStatusUpdate()
{
    if (GetTypeId() == TYPEID_UNIT)
        ToCreature()->UpdateMovementFlags();

    if (IsFlying() || (!IsControlledByPlayer()))
        return;

    LiquidData const& liquidData = GetLiquidData();

    // remove appropriate auras if we are swimming/not swimming respectively
    if (liquidData.Status & MAP_LIQUID_STATUS_SWIMMING)
        RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_NOT_ABOVEWATER);
    else if (!isSwimming())
        RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_NOT_UNDERWATER);

    // liquid aura handling
    LiquidTypeEntry const* curLiquid = nullptr;
    if ((liquidData.Status & MAP_LIQUID_STATUS_SWIMMING))
        curLiquid = sLiquidTypeStore.LookupEntry(liquidData.Entry);

    if (curLiquid != _lastLiquid)
    {
        if (_lastLiquid && _lastLiquid->SpellId)
            RemoveAurasDueToSpell(_lastLiquid->SpellId);

        // Set _lastLiquid before casting liquid spell to avoid infinite loops
        _lastLiquid = curLiquid;

        Player* player = GetCharmerOrOwnerPlayerOrPlayerItself();
        if (curLiquid && curLiquid->SpellId && (!player || !player->IsGameMaster()))
            CastSpell(this, curLiquid->SpellId, true);
    }
}

SafeUnitPointer::~SafeUnitPointer()
{
    if (ptr != defaultValue && ptr) ptr->RemovePointedBy(this);
    ptr = defaultValue;
}

void SafeUnitPointer::SetPointedTo(Unit* u)
{
    if (ptr != defaultValue && ptr) ptr->RemovePointedBy(this);
    ptr = u;
    if (ptr != defaultValue && ptr) ptr->AddPointedBy(this);
}

void SafeUnitPointer::UnitDeleted()
{
    LOG_INFO("misc", "SafeUnitPointer::UnitDeleted !!!");
    if (defaultValue)
    {
        if (Player* p = defaultValue->ToPlayer())
        {
            LOG_INFO("misc", "SafeUnitPointer::UnitDeleted (A1) - {}, {}, {}, {}, {}, {}, {}, {}",
                p->GetGUID().ToString(), p->GetMapId(), p->GetInstanceId(), p->FindMap()->GetId(), p->IsInWorld() ? 1 : 0, p->IsDuringRemoveFromWorld() ? 1 : 0, p->IsBeingTeleported() ? 1 : 0, p->isBeingLoaded() ? 1 : 0);
            if (ptr)
                LOG_INFO("misc", "SafeUnitPointer::UnitDeleted (A2)");

            p->GetSession()->KickPlayer("Unit deleted");
        }
    }
    else if (ptr)
        LOG_INFO("misc", "SafeUnitPointer::UnitDeleted (B1)");

    ptr = defaultValue;
}

void Unit::HandleSafeUnitPointersOnDelete(Unit* thisUnit)
{
    if (thisUnit->SafeUnitPointerSet.empty())
        return;
    for (std::set<SafeUnitPointer*>::iterator itr = thisUnit->SafeUnitPointerSet.begin(); itr != thisUnit->SafeUnitPointerSet.end(); ++itr)
        (*itr)->UnitDeleted();

    thisUnit->SafeUnitPointerSet.clear();
}

bool Unit::IsInWater() const
{
    return (GetLiquidData().Status & MAP_LIQUID_STATUS_SWIMMING) != 0;
}

bool Unit::IsUnderWater() const
{
    return GetLiquidData().Status == LIQUID_MAP_UNDER_WATER;
}

void Unit::DeMorph()
{
    SetDisplayId(GetNativeDisplayId());
}

Aura* Unit::_TryStackingOrRefreshingExistingAura(SpellInfo const* newAura, uint8 effMask, Unit* caster, int32* baseAmount /*= nullptr*/, Item* castItem /*= nullptr*/, ObjectGuid casterGUID /*= ObjectGuid::Empty*/, bool periodicReset /*= false*/)
{
    ASSERT(casterGUID || caster);
    if (!casterGUID)
        casterGUID = caster->GetGUID();

    // Xinef: Hax for mixology, best solution qq
    if (sSpellMgr->GetSpellGroup(newAura->Id) == 1)
        return nullptr;

    // passive and Incanter's Absorption and auras with different type can stack with themselves any number of times
    if (!newAura->IsMultiSlotAura())
    {
        // check if cast item changed
        ObjectGuid castItemGUID;
        if (castItem)
            castItemGUID = castItem->GetGUID();

        // find current aura from spell and change it's stackamount, or refresh it's duration
        if (Aura* foundAura = GetOwnedAura(newAura->Id, newAura->HasAttribute(SPELL_ATTR0_CU_SINGLE_AURA_STACK) ? ObjectGuid::Empty : casterGUID, newAura->HasAttribute(SPELL_ATTR0_CU_ENCHANT_PROC) ? castItemGUID : ObjectGuid::Empty, 0))
        {
            // effect masks do not match
            // extremely rare case
            // let's just recreate aura
            if (effMask != foundAura->GetEffectMask())
                return nullptr;

            // update basepoints with new values - effect amount will be recalculated in ModStackAmount
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            {
                if (!foundAura->HasEffect(i))
                    continue;

                int bp;
                if (baseAmount)
                    bp = *(baseAmount + i);
                else
                    bp = foundAura->GetSpellInfo()->Effects[i].BasePoints;

                int32* oldBP = const_cast<int32*>(&(foundAura->GetEffect(i)->m_baseAmount));
                *oldBP = bp;
            }

            // correct cast item guid if needed
            if (castItemGUID != foundAura->GetCastItemGUID())
            {
                ObjectGuid* oldGUID = const_cast<ObjectGuid*>(&foundAura->m_castItemGuid);
                *oldGUID = castItemGUID;
            }

            // try to increase stack amount
            foundAura->ModStackAmount(1, AURA_REMOVE_BY_DEFAULT, periodicReset);
            sScriptMgr->OnAuraApply(this, foundAura);
            return foundAura;
        }
    }

    return nullptr;
}

void Unit::_AddAura(UnitAura* aura, Unit* caster)
{
    ASSERT(!m_cleanupDone);
    m_ownedAuras.insert(AuraMap::value_type(aura->GetId(), aura));

    _RemoveNoStackAurasDueToAura(aura);

    if (aura->IsRemoved())
        return;

    aura->SetIsSingleTarget(caster && (aura->GetSpellInfo()->IsSingleTarget() || aura->HasEffectType(SPELL_AURA_CONTROL_VEHICLE)));
    if (aura->IsSingleTarget())
    {
        ASSERT((IsInWorld() && !IsDuringRemoveFromWorld()) || (aura->GetCasterGUID() == GetGUID()));
        /* @HACK: Player is not in world during loading auras.
         *        Single target auras are not saved or loaded from database
         *        but may be created as a result of aura links (player mounts with passengers)
         */

        // register single target aura
        caster->GetSingleCastAuras().push_back(aura);
        // remove other single target auras
        Unit::AuraList& scAuras = caster->GetSingleCastAuras();
        for (Unit::AuraList::iterator itr = scAuras.begin(); itr != scAuras.end();)
        {
            if ((*itr) != aura &&
                    (*itr)->IsSingleTargetWith(aura))
            {
                (*itr)->Remove();
                itr = scAuras.begin();
            }
            else
                ++itr;
        }
    }
}

// creates aura application instance and registers it in lists
// aura application effects are handled separately to prevent aura list corruption
AuraApplication* Unit::_CreateAuraApplication(Aura* aura, uint8 effMask)
{
    // can't apply aura on unit which is going to be deleted - to not create a memory leak
    ASSERT(!m_cleanupDone);
    // aura musn't be removed
    ASSERT(!aura->IsRemoved());

    // aura mustn't be already applied on target
    ASSERT (!aura->IsAppliedOnTarget(GetGUID()) && "Unit::_CreateAuraApplication: aura musn't be applied on target");

    SpellInfo const* aurSpellInfo = aura->GetSpellInfo();
    uint32 aurId = aurSpellInfo->Id;

    // ghost spell check, allow apply any auras at player loading in ghost mode (will be cleanup after load)
    // Xinef: Added IsAllowingDeadTarget check
    if (!IsAlive() && !aurSpellInfo->IsDeathPersistent() && !aurSpellInfo->IsAllowingDeadTarget() && (GetTypeId() != TYPEID_PLAYER || !ToPlayer()->GetSession()->PlayerLoading()))
        return nullptr;

    Unit* caster = aura->GetCaster();

    AuraApplication* aurApp = new AuraApplication(this, caster, aura, effMask);
    m_appliedAuras.insert(AuraApplicationMap::value_type(aurId, aurApp));

    // xinef: do not insert our application to interruptible list if application target is not the owner (area auras)
    // xinef: even if it gets removed, it will be reapplied in a second
    if (aurSpellInfo->AuraInterruptFlags && this == aura->GetOwner())
    {
        m_interruptableAuras.push_back(aurApp);
        AddInterruptMask(aurSpellInfo->AuraInterruptFlags);
    }

    if (AuraStateType aState = aura->GetSpellInfo()->GetAuraState())
        m_auraStateAuras.insert(AuraStateAurasMap::value_type(aState, aurApp));

    aura->_ApplyForTarget(this, caster, aurApp);
    return aurApp;
}

void Unit::_ApplyAuraEffect(Aura* aura, uint8 effIndex)
{
    ASSERT(aura);
    ASSERT(aura->HasEffect(effIndex));
    AuraApplication* aurApp = aura->GetApplicationOfTarget(GetGUID());
    ASSERT(aurApp);
    if (!aurApp->GetEffectMask())
        _ApplyAura(aurApp, 1 << effIndex);
    else
        aurApp->_HandleEffect(effIndex, true);
}

// handles effects of aura application
// should be done after registering aura in lists
void Unit::_ApplyAura(AuraApplication* aurApp, uint8 effMask)
{
    Aura* aura = aurApp->GetBase();

    _RemoveNoStackAurasDueToAura(aura);

    if (aurApp->GetRemoveMode())
        return;

    Unit* caster = aura->GetCaster();

    // Update target aura state flag
    SpellInfo const* spellInfo = aura->GetSpellInfo();
    if (AuraStateType aState = spellInfo->GetAuraState())
    {
        uint32 aStateMask = (1 << (aState - 1));
        // force update so the new caster registers it
        if ((aStateMask & PER_CASTER_AURA_STATE_MASK) && HasFlag(UNIT_FIELD_AURASTATE, aStateMask))
            ForceValuesUpdateAtIndex(UNIT_FIELD_AURASTATE);
        else
            ModifyAuraState(aState, true);
    }

    if (aurApp->GetRemoveMode())
        return;

    // Sitdown on apply aura req seated
    if (spellInfo->AuraInterruptFlags & AURA_INTERRUPT_FLAG_NOT_SEATED && !IsSitState())
        SetStandState(UNIT_STAND_STATE_SIT);

    if (aurApp->GetRemoveMode())
        return;

    aura->HandleAuraSpecificMods(aurApp, caster, true, false);

    // apply effects of the aura
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (effMask & 1 << i && (!aurApp->GetRemoveMode()))
            aurApp->_HandleEffect(i, true);
    }

    sScriptMgr->OnAuraApply(this, aura);
}

// removes aura application from lists and unapplies effects
void Unit::_UnapplyAura(AuraApplicationMap::iterator& i, AuraRemoveMode removeMode)
{
    AuraApplication* aurApp = i->second;
    ASSERT(aurApp);
    ASSERT(!aurApp->GetRemoveMode());
    ASSERT(aurApp->GetTarget() == this);

    aurApp->SetRemoveMode(removeMode);
    Aura* aura = aurApp->GetBase();
    LOG_DEBUG("spells.aura", "Aura {} now is remove mode {}", aura->GetId(), removeMode);

    // dead loop is killing the server probably
    ASSERT(m_removedAurasCount < 0xFFFFFFFF);

    ++m_removedAurasCount;

    Unit* caster = aura->GetCaster();

    // Remove all pointers from lists here to prevent possible pointer invalidation on spellcast/auraapply/auraremove
    m_appliedAuras.erase(i);

    // xinef: do not insert our application to interruptible list if application target is not the owner (area auras)
    // xinef: event if it gets removed, it will be reapplied in a second
    if (aura->GetSpellInfo()->AuraInterruptFlags && this == aura->GetOwner())
    {
        m_interruptableAuras.remove(aurApp);
        UpdateInterruptMask();
    }

    bool auraStateFound = false;
    AuraStateType auraState = aura->GetSpellInfo()->GetAuraState();
    if (auraState)
    {
        bool canBreak = false;
        // Get mask of all aurastates from remaining auras
        for (AuraStateAurasMap::iterator itr = m_auraStateAuras.lower_bound(auraState); itr != m_auraStateAuras.upper_bound(auraState) && !(auraStateFound && canBreak);)
        {
            if (itr->second == aurApp)
            {
                m_auraStateAuras.erase(itr);
                itr = m_auraStateAuras.lower_bound(auraState);
                canBreak = true;
                continue;
            }
            auraStateFound = true;
            ++itr;
        }
    }

    aurApp->_Remove();
    aura->_UnapplyForTarget(this, caster, aurApp);

    // remove effects of the spell - needs to be done after removing aura from lists
    for (uint8 itr = 0; itr < MAX_SPELL_EFFECTS; ++itr)
    {
        if (aurApp->HasEffect(itr))
            aurApp->_HandleEffect(itr, false);
    }

    // all effect mustn't be applied
    ASSERT(!aurApp->GetEffectMask());

    // Remove totem at next update if totem loses its aura
    if (aurApp->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE && IsTotem() && GetGUID() == aura->GetCasterGUID())
    {
        if (ToTotem()->GetSpell() == aura->GetId() && ToTotem()->GetTotemType() == TOTEM_PASSIVE)
            ToTotem()->setDeathState(DeathState::JustDied);
    }

    // Remove aurastates only if needed and were not found
    if (auraState)
    {
        if (!auraStateFound)
            ModifyAuraState(auraState, false);
        else
        {
            // update for casters, some shouldn't 'see' the aura state
            uint32 aStateMask = (1 << (auraState - 1));
            if ((aStateMask & PER_CASTER_AURA_STATE_MASK) != 0)
                ForceValuesUpdateAtIndex(UNIT_FIELD_AURASTATE);
        }
    }

    aura->HandleAuraSpecificMods(aurApp, caster, false, false);

    // only way correctly remove all auras from list
    //if (removedAuras != m_removedAurasCount) new aura may be added
    i = m_appliedAuras.begin();

    sScriptMgr->OnAuraRemove(this, aurApp, removeMode);
}

void Unit::_UnapplyAura(AuraApplication* aurApp, AuraRemoveMode removeMode)
{
    // aura can be removed from unit only if it's applied on it, shouldn't happen
    ASSERT(aurApp->GetBase()->GetApplicationOfTarget(GetGUID()) == aurApp);

    uint32 spellId = aurApp->GetBase()->GetId();
    AuraApplicationMapBoundsNonConst range = m_appliedAuras.equal_range(spellId);

    for (AuraApplicationMap::iterator iter = range.first; iter != range.second;)
    {
        if (iter->second == aurApp)
        {
            _UnapplyAura(iter, removeMode);
            return;
        }
        else
            ++iter;
    }
    ABORT();
}

void Unit::_RemoveNoStackAurasDueToAura(Aura* aura)
{
    //SpellInfo const* spellProto = aura->GetSpellInfo();

    // passive spell special case (only non stackable with ranks)

    // xinef: this check makes caster to have 2 area auras thanks to spec switch
    // if (spellProto->IsPassiveStackableWithRanks())
    //    return;

    bool remove = false;
    for (AuraApplicationMap::iterator i = m_appliedAuras.begin(); i != m_appliedAuras.end(); ++i)
    {
        if (remove)
        {
            remove = false;
            i = m_appliedAuras.begin();
        }

        if (aura->CanStackWith(i->second->GetBase(), true))
            continue;

        RemoveAura(i, AURA_REMOVE_BY_DEFAULT);
        if (i == m_appliedAuras.end())
            break;
        remove = true;
    }
}

void Unit::_RegisterAuraEffect(AuraEffect* aurEff, bool apply)
{
    if (apply)
        m_modAuras[aurEff->GetAuraType()].push_back(aurEff);
    else
        m_modAuras[aurEff->GetAuraType()].remove(aurEff);
}

// All aura base removes should go threw this function!
void Unit::RemoveOwnedAura(AuraMap::iterator& i, AuraRemoveMode removeMode)
{
    Aura* aura = i->second;
    ASSERT(!aura->IsRemoved());

    // if unit currently update aura list then make safe update iterator shift to next
    if (m_auraUpdateIterator == i && m_auraUpdateIterator != m_ownedAuras.end())
        ++m_auraUpdateIterator;

    m_ownedAuras.erase(i);
    m_removedAuras.push_back(aura);

    // Unregister single target aura
    if (aura->IsSingleTarget())
        aura->UnregisterSingleTarget();

    aura->_Remove(removeMode);

    i = m_ownedAuras.begin();
}

void Unit::RemoveOwnedAura(uint32 spellId, ObjectGuid casterGUID, uint8 reqEffMask, AuraRemoveMode removeMode)
{
    for (AuraMap::iterator itr = m_ownedAuras.lower_bound(spellId); itr != m_ownedAuras.upper_bound(spellId);)
        if (((itr->second->GetEffectMask() & reqEffMask) == reqEffMask) && (!casterGUID || itr->second->GetCasterGUID() == casterGUID))
        {
            RemoveOwnedAura(itr, removeMode);
            itr = m_ownedAuras.lower_bound(spellId);
        }
        else
            ++itr;
}

void Unit::RemoveOwnedAura(Aura* aura, AuraRemoveMode removeMode)
{
    if (aura->IsRemoved())
        return;

    ASSERT(aura->GetOwner() == this);

    uint32 spellId = aura->GetId();
    AuraMapBoundsNonConst range = m_ownedAuras.equal_range(spellId);

    for (AuraMap::iterator itr = range.first; itr != range.second; ++itr)
    {
        if (itr->second == aura)
        {
            RemoveOwnedAura(itr, removeMode);
            return;
        }
    }

    ABORT();
}

Aura* Unit::GetOwnedAura(uint32 spellId, ObjectGuid casterGUID, ObjectGuid itemCasterGUID, uint8 reqEffMask, Aura* except) const
{
    AuraMapBounds range = m_ownedAuras.equal_range(spellId);
    for (AuraMap::const_iterator itr = range.first; itr != range.second; ++itr)
    {
        if (((itr->second->GetEffectMask() & reqEffMask) == reqEffMask)
                && (!casterGUID || itr->second->GetCasterGUID() == casterGUID)
                && (!itemCasterGUID || itr->second->GetCastItemGUID() == itemCasterGUID)
                && (!except || except != itr->second))
        {
            return itr->second;
        }
    }
    return nullptr;
}

void Unit::RemoveAura(AuraApplicationMap::iterator& i, AuraRemoveMode mode)
{
    AuraApplication* aurApp = i->second;
    // Do not remove aura which is already being removed
    if (aurApp->GetRemoveMode())
        return;
    Aura* aura = aurApp->GetBase();
    _UnapplyAura(i, mode);
    // Remove aura - for Area and Target auras
    if (aura->GetOwner() == this)
        aura->Remove(mode);
}

void Unit::RemoveAura(uint32 spellId, ObjectGuid caster, uint8 reqEffMask, AuraRemoveMode removeMode)
{
    AuraApplicationMapBoundsNonConst range = m_appliedAuras.equal_range(spellId);
    for (AuraApplicationMap::iterator iter = range.first; iter != range.second;)
    {
        Aura const* aura = iter->second->GetBase();
        if (((aura->GetEffectMask() & reqEffMask) == reqEffMask)
                && (!caster || aura->GetCasterGUID() == caster))
        {
            RemoveAura(iter, removeMode);
            return;
        }
        else
            ++iter;
    }
}

void Unit::RemoveAura(AuraApplication* aurApp, AuraRemoveMode mode)
{
    // we've special situation here, RemoveAura called while during aura removal
    // this kind of call is needed only when aura effect removal handler
    // or event triggered by it expects to remove
    // not yet removed effects of an aura
    if (aurApp->GetRemoveMode())
    {
        // remove remaining effects of an aura
        for (uint8 itr = 0; itr < MAX_SPELL_EFFECTS; ++itr)
        {
            if (aurApp->HasEffect(itr))
                aurApp->_HandleEffect(itr, false);
        }
        return;
    }
    // no need to remove
    if (aurApp->GetBase()->GetApplicationOfTarget(GetGUID()) != aurApp || aurApp->GetBase()->IsRemoved())
        return;

    uint32 spellId = aurApp->GetBase()->GetId();
    AuraApplicationMapBoundsNonConst range = m_appliedAuras.equal_range(spellId);

    for (AuraApplicationMap::iterator iter = range.first; iter != range.second;)
    {
        if (aurApp == iter->second)
        {
            // Prevent Arena Preparation aura from being removed by player actions
            // It's an invisibility spell so any interaction/spell cast etc. removes it.
            // Should only be removed by the arena script, once the match starts.
            if (aurApp->GetBase()->HasEffectType(SPELL_AURA_ARENA_PREPARATION))
            {
                return;
            }

            RemoveAura(iter, mode);
            return;
        }
        else
            ++iter;
    }
}

void Unit::RemoveAura(Aura* aura, AuraRemoveMode mode)
{
    if (aura->IsRemoved())
        return;
    if (AuraApplication* aurApp = aura->GetApplicationOfTarget(GetGUID()))
        RemoveAura(aurApp, mode);
}

void Unit::RemoveOwnedAuras(std::function<bool(Aura const*)> const& check)
{
    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        if (check(iter->second))
        {
            RemoveOwnedAura(iter);
            continue;
        }
        ++iter;
    }
}

void Unit::RemoveAppliedAuras(std::function<bool(AuraApplication const*)> const& check)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        if (check(iter->second))
        {
            RemoveAura(iter);
            continue;
        }
        ++iter;
    }
}

void Unit::RemoveOwnedAuras(uint32 spellId, std::function<bool(Aura const*)> const& check)
{
    for (AuraMap::iterator iter = m_ownedAuras.lower_bound(spellId); iter != m_ownedAuras.upper_bound(spellId);)
    {
        if (check(iter->second))
        {
            RemoveOwnedAura(iter);
            continue;
        }
        ++iter;
    }
}

void Unit::RemoveAppliedAuras(uint32 spellId, std::function<bool(AuraApplication const*)> const& check)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.lower_bound(spellId); iter != m_appliedAuras.upper_bound(spellId);)
    {
        if (check(iter->second))
        {
            RemoveAura(iter);
            continue;
        }
        ++iter;
    }
}

void Unit::RemoveAurasDueToSpell(uint32 spellId, ObjectGuid casterGUID, uint8 reqEffMask, AuraRemoveMode removeMode)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.lower_bound(spellId); iter != m_appliedAuras.upper_bound(spellId);)
    {
        Aura const* aura = iter->second->GetBase();
        if (((aura->GetEffectMask() & reqEffMask) == reqEffMask)
                && (!casterGUID || aura->GetCasterGUID() == casterGUID))
        {
            RemoveAura(iter, removeMode);
            iter = m_appliedAuras.lower_bound(spellId);
        }
        else
            ++iter;
    }
}

void Unit::RemoveAuraFromStack(uint32 spellId, ObjectGuid casterGUID, AuraRemoveMode removeMode)
{
    AuraMapBoundsNonConst range = m_ownedAuras.equal_range(spellId);
    for (AuraMap::iterator iter = range.first; iter != range.second;)
    {
        Aura* aura = iter->second;
        if ((aura->GetType() == UNIT_AURA_TYPE)
                && (!casterGUID || aura->GetCasterGUID() == casterGUID))
        {
            aura->ModStackAmount(-1, removeMode);
            return;
        }
        else
            ++iter;
    }
}

void Unit::RemoveAurasDueToSpellByDispel(uint32 spellId, uint32 dispellerSpellId, ObjectGuid casterGUID, Unit* dispeller, uint8 chargesRemoved/*= 1*/)
{
    AuraMapBoundsNonConst range = m_ownedAuras.equal_range(spellId);
    for (AuraMap::iterator iter = range.first; iter != range.second;)
    {
        Aura* aura = iter->second;
        if (aura->GetCasterGUID() == casterGUID)
        {
            DispelInfo dispelInfo(dispeller, dispellerSpellId, chargesRemoved);

            // Call OnDispel hook on AuraScript
            aura->CallScriptDispel(&dispelInfo);

            if (aura->GetSpellInfo()->HasAttribute(SPELL_ATTR7_DISPEL_REMOVES_CHARGES))
                aura->ModCharges(-dispelInfo.GetRemovedCharges(), AURA_REMOVE_BY_ENEMY_SPELL);
            else
                aura->ModStackAmount(-dispelInfo.GetRemovedCharges(), AURA_REMOVE_BY_ENEMY_SPELL);

            // Call AfterDispel hook on AuraScript
            aura->CallScriptAfterDispel(&dispelInfo);

            switch (aura->GetSpellInfo()->SpellFamilyName)
            {
                case SPELLFAMILY_HUNTER:
                    {
                        // Noxious Stings
                        if (aura->GetSpellInfo()->SpellFamilyFlags[1] & 0x1000)
                        {
                            if (Unit* caster = aura->GetCaster())
                            {
                                if (AuraEffect* aureff = caster->GetAuraEffect(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS, SPELLFAMILY_HUNTER, 3521, 1))
                                {
                                    if (Aura* noxious = Aura::TryCreate(aura->GetSpellInfo(), aura->GetEffectMask(), dispeller, caster))
                                    {
                                        noxious->SetDuration(aura->GetDuration() * aureff->GetAmount() / 100);
                                        if (aura->GetUnitOwner() )
                                            if (const std::vector<int32>* spell_triggered = sSpellMgr->GetSpellLinked(-int32(aura->GetId())))
                                                for (std::vector<int32>::const_iterator itr = spell_triggered->begin(); itr != spell_triggered->end(); ++itr)
                                                    aura->GetUnitOwner()->RemoveAurasDueToSpell(*itr);
                                    }
                                }
                            }
                        }
                        break;
                    }
                case SPELLFAMILY_DEATHKNIGHT:
                    {
                        // Icy Clutch, remove with Frost Fever
                        if (aura->GetSpellInfo()->SpellFamilyFlags[1] & 0x4000000)
                        {
                            if (AuraEffect* aureff = GetAuraEffect(SPELL_AURA_MOD_DECREASE_SPEED, SPELLFAMILY_DEATHKNIGHT, 0, 0x40000, 0, casterGUID))
                                RemoveAurasDueToSpell(aureff->GetId());
                        }
                    }
                default:
                    break;
            }
            return;
        }
        else
            ++iter;
    }
}

void Unit::RemoveAurasDueToSpellBySteal(uint32 spellId, ObjectGuid casterGUID, Unit* stealer)
{
    AuraMapBoundsNonConst range = m_ownedAuras.equal_range(spellId);
    for (AuraMap::iterator iter = range.first; iter != range.second;)
    {
        Aura* aura = iter->second;
        if (aura->GetCasterGUID() == casterGUID)
        {
            int32 damage[MAX_SPELL_EFFECTS];
            int32 baseDamage[MAX_SPELL_EFFECTS];
            uint8 effMask = 0;
            uint8 recalculateMask = 0;
            Unit* caster = aura->GetCaster();
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            {
                if (aura->GetEffect(i))
                {
                    baseDamage[i] = aura->GetEffect(i)->GetBaseAmount();
                    damage[i] = aura->GetEffect(i)->GetAmount();
                    effMask |= (1 << i);
                    if (aura->GetEffect(i)->CanBeRecalculated())
                        recalculateMask |= (1 << i);
                }
                else
                {
                    baseDamage[i] = 0;
                    damage[i] = 0;
                }
            }

            bool stealCharge = aura->GetSpellInfo()->HasAttribute(SPELL_ATTR7_DISPEL_REMOVES_CHARGES);
            // Cast duration to unsigned to prevent permanent aura's such as Righteous Fury being permanently added to caster
            uint32 dur = std::min(2u * MINUTE * IN_MILLISECONDS, uint32(aura->GetDuration()));

            if (Aura* oldAura = stealer->GetAura(aura->GetId(), aura->GetCasterGUID()))
            {
                if (stealCharge)
                    oldAura->ModCharges(1);
                else
                    oldAura->ModStackAmount(1);
                oldAura->SetDuration(int32(dur));
            }
            else
            {
                // single target state must be removed before aura creation to preserve existing single target aura
                if (aura->IsSingleTarget())
                    aura->UnregisterSingleTarget();

                // Xinef: if stealer has same aura
                Aura* curAura = stealer->GetAura(aura->GetId());
                if (!curAura || (!curAura->IsPermanent() && curAura->GetDuration() < (int32)dur))
                    if (Aura* newAura = Aura::TryRefreshStackOrCreate(aura->GetSpellInfo(), effMask, stealer, nullptr, &baseDamage[0], nullptr, aura->GetCasterGUID()))
                    {
                        // created aura must not be single target aura,, so stealer won't loose it on recast
                        if (newAura->IsSingleTarget())
                        {
                            newAura->UnregisterSingleTarget();
                            // bring back single target aura status to the old aura
                            aura->SetIsSingleTarget(true);
                            caster->GetSingleCastAuras().push_back(aura);
                        }
                        // FIXME: using aura->GetMaxDuration() maybe not blizzlike but it fixes stealing of spells like Innervate
                        newAura->SetLoadedState(aura->GetMaxDuration(), int32(dur), stealCharge ? 1 : aura->GetCharges(), 1, recalculateMask, &damage[0]);
                        newAura->ApplyForTargets();
                    }
            }

            if (stealCharge)
                aura->ModCharges(-1, AURA_REMOVE_BY_ENEMY_SPELL);
            else
                aura->ModStackAmount(-1, AURA_REMOVE_BY_ENEMY_SPELL);

            return;
        }
        else
            ++iter;
    }
}

void Unit::RemoveAurasDueToItemSpell(uint32 spellId, ObjectGuid castItemGuid)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.lower_bound(spellId); iter != m_appliedAuras.upper_bound(spellId);)
    {
        if (iter->second->GetBase()->GetCastItemGUID() == castItemGuid)
        {
            RemoveAura(iter);
            iter = m_appliedAuras.lower_bound(spellId);
        }
        else
            ++iter;
    }
}

void Unit::RemoveAurasByType(AuraType auraType, ObjectGuid casterGUID, Aura* except, bool negative, bool positive)
{
    // simple check if list is empty
    if (m_modAuras[auraType].empty())
        return;

    for (AuraEffectList::iterator iter = m_modAuras[auraType].begin(); iter != m_modAuras[auraType].end();)
    {
        Aura* aura = (*iter)->GetBase();
        AuraApplication* aurApp = aura->GetApplicationOfTarget(GetGUID());

        ++iter;
        if (aura != except && (!casterGUID || aura->GetCasterGUID() == casterGUID)
                && ((negative && !aurApp->IsPositive()) || (positive && aurApp->IsPositive())))
        {
            uint32 removedAuras = m_removedAurasCount;
            RemoveAura(aurApp);
            if (m_removedAurasCount > removedAuras + 1)
                iter = m_modAuras[auraType].begin();
        }
    }
}

void Unit::RemoveAurasWithAttribute(uint32 flags)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        SpellInfo const* spell = iter->second->GetBase()->GetSpellInfo();
        if (spell->Attributes & flags)
            RemoveAura(iter);
        else
            ++iter;
    }
}

void Unit::RemoveNotOwnSingleTargetAuras()
{
    // single target auras from other casters
    // Iterate m_ownedAuras - aura is marked as single target in Unit::AddAura (and pushed to m_ownedAuras).
    // m_appliedAuras will NOT contain the aura before first Unit::Update after adding it to m_ownedAuras.
    // Quickly removing such an aura will lead to it not being unregistered from caster's single cast auras container
    // leading to assertion failures if the aura was cast on a player that can
    // (and is changing map at the point where this function is called).
    // Such situation occurs when player is logging in inside an instance and fails the entry check for any reason.
    // The aura that was loaded from db (indirectly, via linked casts) gets removed before it has a chance
    // to register in m_appliedAuras
    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        Aura const* aura = iter->second;

        if (aura->GetCasterGUID() != GetGUID() && aura->IsSingleTarget())
            RemoveOwnedAura(iter);
        else
            ++iter;
    }

    // single target auras at other targets
    AuraList& scAuras = GetSingleCastAuras();
    for (AuraList::iterator iter = scAuras.begin(); iter != scAuras.end();)
    {
        Aura* aura = *iter;
        if (aura->GetUnitOwner() != this)
        {
            aura->Remove();
            iter = scAuras.begin();
        }
        else
            ++iter;
    }
}

void Unit::RemoveAurasWithInterruptFlags(uint32 flag, uint32 except, bool isAutoshot /*= false*/)
{
    if (!(m_interruptMask & flag))
        return;

    // interrupt auras
    for (AuraApplicationList::iterator iter = m_interruptableAuras.begin(); iter != m_interruptableAuras.end();)
    {
        Aura* aura = (*iter)->GetBase();
        ++iter;
        if ((aura->GetSpellInfo()->AuraInterruptFlags & flag) && (!except || aura->GetId() != except))
        {
            uint32 removedAuras = m_removedAurasCount;
            RemoveAura(aura);
            if (m_removedAurasCount > removedAuras + 1)
                iter = m_interruptableAuras.begin();
        }
    }

    // interrupt channeled spell
    if (Spell* spell = m_currentSpells[CURRENT_CHANNELED_SPELL])
    {
        if (spell->getState() == SPELL_STATE_CASTING && (spell->m_spellInfo->ChannelInterruptFlags & flag) && spell->m_spellInfo->Id != except)
        {
            // Do not interrupt if auto shot
            if (!(isAutoshot && spell->m_spellInfo->HasAttribute(SPELL_ATTR2_DO_NOT_RESET_COMBAT_TIMERS)))
            {
                InterruptNonMeleeSpells(false, spell->m_spellInfo->Id);
            }
        }
    }

    UpdateInterruptMask();
}

void Unit::RemoveAurasWithFamily(SpellFamilyNames family, uint32 familyFlag1, uint32 familyFlag2, uint32 familyFlag3, ObjectGuid casterGUID)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if (!casterGUID || aura->GetCasterGUID() == casterGUID)
        {
            SpellInfo const* spell = aura->GetSpellInfo();
            if (spell->SpellFamilyName == uint32(family) && spell->SpellFamilyFlags.HasFlag(familyFlag1, familyFlag2, familyFlag3))
            {
                RemoveAura(iter);
                continue;
            }
        }
        ++iter;
    }
}

void Unit::RemoveMovementImpairingAuras(bool withRoot)
{
    if (withRoot)
        RemoveAurasWithMechanic(1 << MECHANIC_ROOT);

    // Snares
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if (aura->GetSpellInfo()->Mechanic == MECHANIC_SNARE)
        {
            RemoveAura(iter);
            continue;
        }

        // Xinef: turn off snare auras by setting amount to 0 :)
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (((1 << i) & iter->second->GetEffectMask()) && aura->GetSpellInfo()->Effects[i].Mechanic == MECHANIC_SNARE)
                aura->GetEffect(i)->ChangeAmount(0);

        ++iter;
    }
}

void Unit::RemoveAurasWithMechanic(uint32 mechanic_mask, AuraRemoveMode removemode, uint32 except)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if (!except || aura->GetId() != except)
        {
            if (aura->GetSpellInfo()->GetAllEffectsMechanicMask() & mechanic_mask)
            {
                RemoveAura(iter, removemode);
                continue;
            }
        }
        ++iter;
    }
}

void Unit::RemoveAurasByShapeShift()
{
    uint32 mechanic_mask = (1 << MECHANIC_SNARE) | (1 << MECHANIC_ROOT);
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if ((aura->GetSpellInfo()->GetAllEffectsMechanicMask() & mechanic_mask) &&
            (!aura->GetSpellInfo()->HasAttribute(SPELL_ATTR0_CU_AURA_CC) || (aura->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_WARRIOR && (aura->GetSpellInfo()->SpellFamilyFlags[1] & 0x20))))
        {
            RemoveAura(iter);
            continue;
        }
        ++iter;
    }
}

void Unit::RemoveAreaAurasDueToLeaveWorld()
{
    // make sure that all area auras not applied on self are removed - prevent access to deleted pointer later
    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        Aura* aura = iter->second;
        ++iter;
        Aura::ApplicationMap const& appMap = aura->GetApplicationMap();
        for (Aura::ApplicationMap::const_iterator itr = appMap.begin(); itr != appMap.end();)
        {
            AuraApplication* aurApp = itr->second;
            ++itr;
            Unit* target = aurApp->GetTarget();
            if (target == this)
                continue;
            target->RemoveAura(aurApp);
            // things linked on aura remove may apply new area aura - so start from the beginning
            iter = m_ownedAuras.begin();
        }
    }

    // remove area auras owned by others
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        if (iter->second->GetBase()->GetOwner() != this)
        {
            RemoveAura(iter);
        }
        else
            ++iter;
    }
}

void Unit::RemoveAllAuras()
{
    // this may be a dead loop if some events on aura remove will continiously apply aura on remove
    // we want to have all auras removed, so use your brain when linking events
    while (!m_appliedAuras.empty() || !m_ownedAuras.empty())
    {
        AuraApplicationMap::iterator aurAppIter;
        for (aurAppIter = m_appliedAuras.begin(); aurAppIter != m_appliedAuras.end();)
            _UnapplyAura(aurAppIter, AURA_REMOVE_BY_DEFAULT);

        AuraMap::iterator aurIter;
        for (aurIter = m_ownedAuras.begin(); aurIter != m_ownedAuras.end();)
            RemoveOwnedAura(aurIter);
    }
}

void Unit::RemoveArenaAuras()
{
    // in join, remove positive buffs, on end, remove negative
    // used to remove positive visible auras in arenas
    RemoveAppliedAuras([](AuraApplication const* aurApp)
    {
        Aura const* aura = aurApp->GetBase();
        return (!aura->GetSpellInfo()->HasAttribute(SPELL_ATTR4_ALLOW_ENETRING_ARENA)                          // don't remove stances, shadowform, pally/hunter auras
            && !aura->IsPassive()                                                                              // don't remove passive auras
            && (aurApp->IsPositive() || !aura->GetSpellInfo()->HasAttribute(SPELL_ATTR3_ALLOW_AURA_WHILE_DEAD))) || // not negative death persistent auras
            aura->GetSpellInfo()->HasAttribute(SPELL_ATTR5_REMOVE_ENTERING_ARENA);                             // special marker, always remove
    });
}

void Unit::RemoveAllAurasOnDeath()
{
    // used just after dieing to remove all visible auras
    // and disable the mods for the passive ones
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if ((!aura->IsPassive() || aura->GetSpellInfo()->HasAttribute(SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD)) && !aura->IsDeathPersistent())
            _UnapplyAura(iter, AURA_REMOVE_BY_DEATH);
        else
            ++iter;
    }

    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        Aura* aura = iter->second;
        if ((!aura->IsPassive() || aura->GetSpellInfo()->HasAttribute(SPELL_ATTR7_DISABLE_AURA_WHILE_DEAD)) && !aura->IsDeathPersistent())
            RemoveOwnedAura(iter, AURA_REMOVE_BY_DEATH);
        else
            ++iter;
    }
}

void Unit::RemoveAllAurasRequiringDeadTarget()
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if (!aura->IsPassive() && aura->GetSpellInfo()->IsRequiringDeadTarget())
            _UnapplyAura(iter, AURA_REMOVE_BY_DEFAULT);
        else
            ++iter;
    }

    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        Aura* aura = iter->second;
        if (!aura->IsPassive() && aura->GetSpellInfo()->IsRequiringDeadTarget())
            RemoveOwnedAura(iter, AURA_REMOVE_BY_DEFAULT);
        else
            ++iter;
    }
}

void Unit::RemoveAllAurasExceptType(AuraType type)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if (aura->GetSpellInfo()->HasAura(type))
            ++iter;
        else
            _UnapplyAura(iter, AURA_REMOVE_BY_DEFAULT);
    }

    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        Aura* aura = iter->second;
        if (aura->GetSpellInfo()->HasAura(type))
            ++iter;
        else
            RemoveOwnedAura(iter, AURA_REMOVE_BY_DEFAULT);
    }
}

// pussywizard: replaced with Unit::RemoveEvadeAuras()
/*void Unit::RemoveAllAurasExceptType(AuraType type1, AuraType type2)
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        if (aura->GetSpellInfo()->HasAura(type1) || aura->GetSpellInfo()->HasAura(type2))
            ++iter;
        else
            _UnapplyAura(iter, AURA_REMOVE_BY_DEFAULT);
    }

    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        Aura* aura = iter->second;
        if (aura->GetSpellInfo()->HasAura(type1) || aura->GetSpellInfo()->HasAura(type2))
            ++iter;
        else
            RemoveOwnedAura(iter, AURA_REMOVE_BY_DEFAULT);
    }
}*/

// Xinef: We should not remove passive auras on evade, if npc has player owner (scripted one cast auras)
void Unit::RemoveEvadeAuras()
{
    for (AuraApplicationMap::iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end();)
    {
        Aura const* aura = iter->second->GetBase();
        SpellInfo const* spellInfo = aura->GetSpellInfo();
        if (spellInfo->HasAttribute(SPELL_ATTR0_CU_IGNORE_EVADE) || spellInfo->HasAttribute(SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT) || spellInfo->HasAura(SPELL_AURA_CONTROL_VEHICLE)
            || spellInfo->HasAura(SPELL_AURA_CLONE_CASTER) || (aura->IsPassive() && GetOwnerGUID().IsPlayer()))
            ++iter;
        else
            _UnapplyAura(iter, AURA_REMOVE_BY_DEFAULT);
    }

    for (AuraMap::iterator iter = m_ownedAuras.begin(); iter != m_ownedAuras.end();)
    {
        Aura* aura = iter->second;
        SpellInfo const* spellInfo = aura->GetSpellInfo();
        if (spellInfo->HasAttribute(SPELL_ATTR0_CU_IGNORE_EVADE) || spellInfo->HasAttribute(SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT) || spellInfo->HasAura(SPELL_AURA_CONTROL_VEHICLE)
            || spellInfo->HasAura(SPELL_AURA_CLONE_CASTER) || (aura->IsPassive() && GetOwnerGUID().IsPlayer()))
            ++iter;
        else
            RemoveOwnedAura(iter, AURA_REMOVE_BY_DEFAULT);
    }
}

void Unit::DelayOwnedAuras(uint32 spellId, ObjectGuid caster, int32 delaytime)
{
    AuraMapBoundsNonConst range = m_ownedAuras.equal_range(spellId);
    for (; range.first != range.second; ++range.first)
    {
        Aura* aura = range.first->second;
        if (!caster || aura->GetCasterGUID() == caster)
        {
            if (aura->GetDuration() < delaytime)
                aura->SetDuration(0);
            else
                aura->SetDuration(aura->GetDuration() - delaytime);

            // update for out of range group members (on 1 slot use)
            aura->SetNeedClientUpdateForTargets();
            LOG_DEBUG("spells.aura", "Aura {} partially interrupted on unit {}, new duration: {} ms", aura->GetId(), GetGUID().ToString(), aura->GetDuration());
        }
    }
}

void Unit::_RemoveAllAuraStatMods()
{
    for (AuraApplicationMap::iterator i = m_appliedAuras.begin(); i != m_appliedAuras.end(); ++i)
        (*i).second->GetBase()->HandleAllEffects(i->second, AURA_EFFECT_HANDLE_STAT, false);
}

void Unit::_ApplyAllAuraStatMods()
{
    for (AuraApplicationMap::iterator i = m_appliedAuras.begin(); i != m_appliedAuras.end(); ++i)
        (*i).second->GetBase()->HandleAllEffects(i->second, AURA_EFFECT_HANDLE_STAT, true);
}

AuraEffect* Unit::GetAuraEffect(uint32 spellId, uint8 effIndex, ObjectGuid caster) const
{
    AuraApplicationMapBounds range = m_appliedAuras.equal_range(spellId);
    for (AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
    {
        if (itr->second->HasEffect(effIndex)
                && (!caster || itr->second->GetBase()->GetCasterGUID() == caster))
        {
            return itr->second->GetBase()->GetEffect(effIndex);
        }
    }
    return nullptr;
}

AuraEffect* Unit::GetAuraEffectOfRankedSpell(uint32 spellId, uint8 effIndex, ObjectGuid caster) const
{
    uint32 rankSpell = sSpellMgr->GetFirstSpellInChain(spellId);
    while (rankSpell)
    {
        if (AuraEffect* aurEff = GetAuraEffect(rankSpell, effIndex, caster))
            return aurEff;
        rankSpell = sSpellMgr->GetNextSpellInChain(rankSpell);
    }
    return nullptr;
}

AuraEffect* Unit::GetAuraEffect(AuraType type, SpellFamilyNames name, uint32 iconId, uint8 effIndex) const
{
    AuraEffectList const& auras = GetAuraEffectsByType(type);
    for (Unit::AuraEffectList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
    {
        if (effIndex != (*itr)->GetEffIndex())
            continue;
        SpellInfo const* spell = (*itr)->GetSpellInfo();
        if (spell->SpellIconID == iconId && spell->SpellFamilyName == name)
            return *itr;
    }
    return nullptr;
}

AuraEffect* Unit::GetAuraEffect(AuraType type, SpellFamilyNames family, uint32 familyFlag1, uint32 familyFlag2, uint32 familyFlag3, ObjectGuid casterGUID) const
{
    AuraEffectList const& auras = GetAuraEffectsByType(type);
    for (AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
    {
        SpellInfo const* spell = (*i)->GetSpellInfo();
        if (spell->SpellFamilyName == uint32(family) && spell->SpellFamilyFlags.HasFlag(familyFlag1, familyFlag2, familyFlag3))
        {
            if (casterGUID && (*i)->GetCasterGUID() != casterGUID)
                continue;
            return (*i);
        }
    }
    return nullptr;
}

AuraEffect* Unit::GetAuraEffectDummy(uint32 spellid) const
{
    AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_DUMMY);
    for (Unit::AuraEffectList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
    {
        if ((*itr)->GetId() == spellid)
            return *itr;
    }

    return nullptr;
}

AuraApplication* Unit::GetAuraApplication(uint32 spellId, ObjectGuid casterGUID, ObjectGuid itemCasterGUID, uint8 reqEffMask, AuraApplication* except) const
{
    AuraApplicationMapBounds range = m_appliedAuras.equal_range(spellId);
    for (; range.first != range.second; ++range.first)
    {
        AuraApplication* app = range.first->second;
        Aura const* aura = app->GetBase();

        if (((aura->GetEffectMask() & reqEffMask) == reqEffMask)
                && (!casterGUID || aura->GetCasterGUID() == casterGUID)
                && (!itemCasterGUID || aura->GetCastItemGUID() == itemCasterGUID)
                && (!except || except != app))
        {
            return app;
        }
    }
    return nullptr;
}

Aura* Unit::GetAura(uint32 spellId, ObjectGuid casterGUID, ObjectGuid itemCasterGUID, uint8 reqEffMask) const
{
    AuraApplication* aurApp = GetAuraApplication(spellId, casterGUID, itemCasterGUID, reqEffMask);
    return aurApp ? aurApp->GetBase() : nullptr;
}

AuraApplication* Unit::GetAuraApplicationOfRankedSpell(uint32 spellId, ObjectGuid casterGUID, ObjectGuid itemCasterGUID, uint8 reqEffMask, AuraApplication* except) const
{
    uint32 rankSpell = sSpellMgr->GetFirstSpellInChain(spellId);
    while (rankSpell)
    {
        if (AuraApplication* aurApp = GetAuraApplication(rankSpell, casterGUID, itemCasterGUID, reqEffMask, except))
            return aurApp;
        rankSpell = sSpellMgr->GetNextSpellInChain(rankSpell);
    }
    return nullptr;
}

Aura* Unit::GetAuraOfRankedSpell(uint32 spellId, ObjectGuid casterGUID, ObjectGuid itemCasterGUID, uint8 reqEffMask) const
{
    AuraApplication* aurApp = GetAuraApplicationOfRankedSpell(spellId, casterGUID, itemCasterGUID, reqEffMask);
    return aurApp ? aurApp->GetBase() : nullptr;
}

void Unit::GetDispellableAuraList(Unit* caster, uint32 dispelMask, DispelChargesList& dispelList, SpellInfo const* dispelSpell)
{
    // we should not be able to dispel diseases if the target is affected by unholy blight
    if (dispelMask & (1 << DISPEL_DISEASE) && HasAura(50536))
        dispelMask &= ~(1 << DISPEL_DISEASE);

    ReputationRank rank = GetReactionTo(caster, IsCharmed());
    bool positive = rank >= REP_FRIENDLY;

    // Neutral unit not at war with caster should be treated as a friendly unit
    if (rank == REP_NEUTRAL)
    {
        if (Player* casterPlayer = caster->GetAffectingPlayer())
        {
            if (FactionTemplateEntry const* factionTemplateEntry = GetFactionTemplateEntry())
            {
                if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionTemplateEntry->faction))
                {
                    if (factionEntry->CanBeSetAtWar())
                    {
                        positive = !casterPlayer->GetReputationMgr().IsAtWar(factionEntry);
                    }
                }
            }
        }
    }

    Unit::VisibleAuraMap const* visibleAuras = GetVisibleAuras();
    for (Unit::VisibleAuraMap::const_iterator itr = visibleAuras->begin(); itr != visibleAuras->end(); ++itr)
    {
        Aura* aura = itr->second->GetBase();

        // don't try to remove passive auras
        if (aura->IsPassive())
            continue;

        if (aura->GetSpellInfo()->GetDispelMask() & dispelMask)
        {
            if (aura->GetSpellInfo()->Dispel == DISPEL_MAGIC)
            {
                // do not remove positive auras if friendly target
                //               negative auras if non-friendly target
                if (itr->second->IsPositive() == positive)
                    continue;
            }

            // Banish should only be dispelled by Mass Dispel
            if (aura->GetSpellInfo()->Mechanic == MECHANIC_BANISH && !dispelSpell->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES))
            {
                continue;
            }

            // The charges / stack amounts don't count towards the total number of auras that can be dispelled.
            // Ie: A dispel on a target with 5 stacks of Winters Chill and a Polymorph has 1 / (1 + 1) -> 50% chance to dispell
            // Polymorph instead of 1 / (5 + 1) -> 16%.
            bool dispel_charges = aura->GetSpellInfo()->HasAttribute(SPELL_ATTR7_DISPEL_REMOVES_CHARGES);
            uint8 charges = dispel_charges ? aura->GetCharges() : aura->GetStackAmount();
            if (charges > 0)
                dispelList.push_back(std::make_pair(aura, charges));
        }
    }
}

bool Unit::HasAuraEffect(uint32 spellId, uint8 effIndex, ObjectGuid caster) const
{
    AuraApplicationMapBounds range = m_appliedAuras.equal_range(spellId);
    for (AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
    {
        if (itr->second->HasEffect(effIndex)
                && (!caster || itr->second->GetBase()->GetCasterGUID() == caster))
        {
            return true;
        }
    }
    return false;
}

uint32 Unit::GetAuraCount(uint32 spellId) const
{
    uint32 count = 0;
    AuraApplicationMapBounds range = m_appliedAuras.equal_range(spellId);

    for (AuraApplicationMap::const_iterator itr = range.first; itr != range.second; ++itr)
    {
        if (itr->second->GetBase()->GetStackAmount() == 0)
            ++count;
        else
            count += (uint32)itr->second->GetBase()->GetStackAmount();
    }

    return count;
}

bool Unit::HasAura(uint32 spellId, ObjectGuid casterGUID, ObjectGuid itemCasterGUID, uint8 reqEffMask) const
{
    if (GetAuraApplication(spellId, casterGUID, itemCasterGUID, reqEffMask))
        return true;
    return false;
}

bool Unit::HasAuraType(AuraType auraType) const
{
    return (!m_modAuras[auraType].empty());
}

bool Unit::HasAuraTypeWithCaster(AuraType auratype, ObjectGuid caster) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if (caster == (*i)->GetCasterGUID())
            return true;
    return false;
}

bool Unit::HasVisibleAuraType(AuraType auraType) const
{
    AuraEffectList const& mAuraList = GetAuraEffectsByType(auraType);
    for (AuraEffectList::const_iterator i = mAuraList.begin(); i != mAuraList.end(); ++i)
        if( (*i)->GetBase()->CanBeSentToClient() )
            return true;

    return false;
}

bool Unit::HasAuraTypeWithMiscvalue(AuraType auratype, int32 miscvalue) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if (miscvalue == (*i)->GetMiscValue())
            return true;
    return false;
}

bool Unit::HasAuraTypeWithAffectMask(AuraType auratype, SpellInfo const* affectedSpell) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if ((*i)->IsAffectedOnSpell(affectedSpell))
            return true;
    return false;
}

bool Unit::HasAuraTypeWithValue(AuraType auratype, int32 value) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if (value == (*i)->GetAmount())
            return true;
    return false;
}

bool Unit::HasAuraTypeWithTriggerSpell(AuraType auratype, uint32 triggerSpell) const
{
    for (AuraEffect const* aura : GetAuraEffectsByType(auratype))
    {
        if (aura->GetSpellInfo()->Effects[aura->GetEffIndex()].TriggerSpell == triggerSpell)
        {
            return true;
        }
    }

    return false;
}

bool Unit::HasNegativeAuraWithInterruptFlag(uint32 flag, ObjectGuid guid)
{
    if (!(m_interruptMask & flag))
        return false;
    for (AuraApplicationList::iterator iter = m_interruptableAuras.begin(); iter != m_interruptableAuras.end(); ++iter)
    {
        if (!(*iter)->IsPositive() && (*iter)->GetBase()->GetSpellInfo()->AuraInterruptFlags & flag && (!guid || (*iter)->GetBase()->GetCasterGUID() == guid))
            return true;
    }
    return false;
}

bool Unit::HasNegativeAuraWithAttribute(uint32 flag, ObjectGuid guid)
{
    for (AuraApplicationMap::const_iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end(); ++iter)
    {
        Aura const* aura = iter->second->GetBase();
        if (!iter->second->IsPositive() && aura->GetSpellInfo()->Attributes & flag && (!guid || aura->GetCasterGUID() == guid))
            return true;
    }
    return false;
}

bool Unit::HasAuraWithMechanic(uint32 mechanicMask) const
{
    for (AuraApplicationMap::const_iterator iter = m_appliedAuras.begin(); iter != m_appliedAuras.end(); ++iter)
    {
        SpellInfo const* spellInfo  = iter->second->GetBase()->GetSpellInfo();
        if (spellInfo->Mechanic && (mechanicMask & (1 << spellInfo->Mechanic)))
            return true;

        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            if (iter->second->HasEffect(i) && spellInfo->Effects[i].Effect && spellInfo->Effects[i].Mechanic)
                if (mechanicMask & (1 << spellInfo->Effects[i].Mechanic))
                    return true;
    }

    return false;
}

AuraEffect* Unit::IsScriptOverriden(SpellInfo const* spell, int32 script) const
{
    AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    for (AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
    {
        if ((*i)->GetMiscValue() == script)
            if ((*i)->IsAffectedOnSpell(spell))
                return (*i);
    }
    return nullptr;
}

uint32 Unit::GetDiseasesByCaster(ObjectGuid casterGUID, uint8 mode)
{
    static const AuraType diseaseAuraTypes[] =
    {
        SPELL_AURA_PERIODIC_DAMAGE, // Frost Fever and Blood Plague
        SPELL_AURA_LINKED,          // Crypt Fever and Ebon Plague
        SPELL_AURA_NONE
    };

    ObjectGuid drwGUID;

    if (Player* playerCaster = ObjectAccessor::GetPlayer(*this, casterGUID))
        drwGUID = playerCaster->getRuneWeaponGUID();

    uint32 diseases = 0;
    for (uint8 index = 0; diseaseAuraTypes[index] != SPELL_AURA_NONE; ++index)
    {
        for (AuraEffectList::iterator i = m_modAuras[diseaseAuraTypes[index]].begin(); i != m_modAuras[diseaseAuraTypes[index]].end();)
        {
            // Get auras with disease dispel type by caster
            if ((*i)->GetSpellInfo()->Dispel == DISPEL_DISEASE
                    && ((*i)->GetCasterGUID() == casterGUID || (*i)->GetCasterGUID() == drwGUID)) // if its caster or his dancing rune weapon
            {
                ++diseases;

                if (mode == 1)
                {
                    RemoveAura((*i)->GetId(), (*i)->GetCasterGUID());
                    i = m_modAuras[diseaseAuraTypes[index]].begin();
                    continue;
                }
                // used for glyph of scourge strike
                else if (mode == 2)
                {
                    Aura* aura = (*i)->GetBase();
                    if (aura && !aura->IsRemoved() && aura->GetDuration() > 0)
                        if ((aura->GetApplyTime() + aura->GetMaxDuration() / 1000 + 8) > (GameTime::GetGameTime().count() + aura->GetDuration() / 1000))
                            aura->SetDuration(aura->GetDuration() + 3000);
                }
            }
            ++i;
        }
    }
    return diseases;
}

uint32 Unit::GetDoTsByCaster(ObjectGuid casterGUID) const
{
    static const AuraType diseaseAuraTypes[] =
    {
        SPELL_AURA_PERIODIC_DAMAGE,
        SPELL_AURA_PERIODIC_DAMAGE_PERCENT,
        SPELL_AURA_NONE
    };

    uint32 dots = 0;
    for (AuraType const* itr = &diseaseAuraTypes[0]; itr && itr[0] != SPELL_AURA_NONE; ++itr)
    {
        Unit::AuraEffectList const& auras = GetAuraEffectsByType(*itr);
        for (AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
        {
            // Get auras by caster
            if ((*i)->GetCasterGUID() == casterGUID)
                ++dots;
        }
    }
    return dots;
}

int32 Unit::GetTotalAuraModifierAreaExclusive(AuraType auratype) const
{
    int32 modifier = 0;
    int32 areaModifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->GetSpellInfo()->HasAreaAuraEffect())
        {
            if (areaModifier < (*i)->GetAmount())
                areaModifier = (*i)->GetAmount();
        }
        else
            modifier += (*i)->GetAmount();
    }

    return modifier + areaModifier;
}

int32 Unit::GetTotalAuraModifier(AuraType auratype) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    if (mTotalAuraList.empty())
        return 0;

    int32 modifier = 0;

    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        modifier += (*i)->GetAmount();

    return modifier;
}

float Unit::GetTotalAuraMultiplier(AuraType auratype) const
{
    float multiplier = 1.0f;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        AddPct(multiplier, (*i)->GetAmount());

    return multiplier;
}

int32 Unit::GetMaxPositiveAuraModifier(AuraType auratype)
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->GetAmount() > modifier)
            modifier = (*i)->GetAmount();
    }

    return modifier;
}

int32 Unit::GetMaxNegativeAuraModifier(AuraType auratype) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if ((*i)->GetAmount() < modifier)
            modifier = (*i)->GetAmount();

    return modifier;
}

int32 Unit::GetTotalAuraModifierByMiscMask(AuraType auratype, uint32 misc_mask) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->GetMiscValue()& misc_mask)
            modifier += (*i)->GetAmount();
    }
    return modifier;
}

float Unit::GetTotalAuraMultiplierByMiscMask(AuraType auratype, uint32 misc_mask) const
{
    float multiplier = 1.0f;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if (((*i)->GetMiscValue() & misc_mask))
            AddPct(multiplier, (*i)->GetAmount());

    return multiplier;
}

int32 Unit::GetMaxPositiveAuraModifierByMiscMask(AuraType auratype, uint32 misc_mask, const AuraEffect* except) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if (except != (*i) && (*i)->GetMiscValue()& misc_mask && (*i)->GetAmount() > modifier)
            modifier = (*i)->GetAmount();
    }

    return modifier;
}

int32 Unit::GetMaxNegativeAuraModifierByMiscMask(AuraType auratype, uint32 misc_mask) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->GetMiscValue()& misc_mask && (*i)->GetAmount() < modifier)
            modifier = (*i)->GetAmount();
    }

    return modifier;
}

int32 Unit::GetTotalAuraModifierByMiscValue(AuraType auratype, int32 misc_value) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if ((*i)->GetMiscValue() == misc_value)
            modifier += (*i)->GetAmount();

    return modifier;
}

float Unit::GetTotalAuraMultiplierByMiscValue(AuraType auratype, int32 misc_value) const
{
    float multiplier = 1.0f;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if ((*i)->GetMiscValue() == misc_value)
            AddPct(multiplier, (*i)->GetAmount());

    return multiplier;
}

int32 Unit::GetMaxPositiveAuraModifierByMiscValue(AuraType auratype, int32 misc_value) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->GetMiscValue() == misc_value && (*i)->GetAmount() > modifier)
            modifier = (*i)->GetAmount();
    }

    return modifier;
}

int32 Unit::GetMaxNegativeAuraModifierByMiscValue(AuraType auratype, int32 misc_value) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->GetMiscValue() == misc_value && (*i)->GetAmount() < modifier)
            modifier = (*i)->GetAmount();
    }

    return modifier;
}

int32 Unit::GetTotalAuraModifierByAffectMask(AuraType auratype, SpellInfo const* affectedSpell) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if ((*i)->IsAffectedOnSpell(affectedSpell))
            modifier += (*i)->GetAmount();

    return modifier;
}

float Unit::GetTotalAuraMultiplierByAffectMask(AuraType auratype, SpellInfo const* affectedSpell) const
{
    float multiplier = 1.0f;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if ((*i)->IsAffectedOnSpell(affectedSpell))
            AddPct(multiplier, (*i)->GetAmount());

    return multiplier;
}

int32 Unit::GetMaxPositiveAuraModifierByAffectMask(AuraType auratype, SpellInfo const* affectedSpell) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->IsAffectedOnSpell(affectedSpell) && (*i)->GetAmount() > modifier)
            modifier = (*i)->GetAmount();
    }

    return modifier;
}

int32 Unit::GetMaxNegativeAuraModifierByAffectMask(AuraType auratype, SpellInfo const* affectedSpell) const
{
    int32 modifier = 0;

    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auratype);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
    {
        if ((*i)->IsAffectedOnSpell(affectedSpell) && (*i)->GetAmount() < modifier)
            modifier = (*i)->GetAmount();
    }

    return modifier;
}

void Unit::_RegisterDynObject(DynamicObject* dynObj)
{
    m_dynObj.push_back(dynObj);
}

void Unit::_UnregisterDynObject(DynamicObject* dynObj)
{
    m_dynObj.remove(dynObj);
}

DynamicObject* Unit::GetDynObject(uint32 spellId)
{
    if (m_dynObj.empty())
        return nullptr;
    for (DynObjectList::const_iterator i = m_dynObj.begin(); i != m_dynObj.end(); ++i)
    {
        DynamicObject* dynObj = *i;
        if (dynObj->GetSpellId() == spellId)
            return dynObj;
    }
    return nullptr;
}

bool Unit::RemoveDynObject(uint32 spellId)
{
    if (m_dynObj.empty())
        return false;

    bool result = false;
    for (DynObjectList::iterator i = m_dynObj.begin(); i != m_dynObj.end();)
    {
        DynamicObject* dynObj = *i;
        if (dynObj->GetSpellId() == spellId)
        {
            dynObj->Remove();
            i = m_dynObj.begin();
            result = true;
        }
        else
            ++i;
    }

    return result;
}

void Unit::RemoveAllDynObjects()
{
    while (!m_dynObj.empty())
        m_dynObj.front()->Remove();
}

GameObject* Unit::GetGameObject(uint32 spellId) const
{
    for (GameObjectList::const_iterator itr = m_gameObj.begin(); itr != m_gameObj.end(); ++itr)
        if (GameObject* go = ObjectAccessor::GetGameObject(*this, *itr))
            if (go->GetSpellId() == spellId)
                return go;

    return nullptr;
}

void Unit::AddGameObject(GameObject* gameObj)
{
    if (!gameObj || gameObj->GetOwnerGUID())
        return;

    m_gameObj.push_back(gameObj->GetGUID());
    gameObj->SetOwnerGUID(GetGUID());

    if (GetTypeId() == TYPEID_PLAYER && gameObj->GetSpellId())
    {
        SpellInfo const* createBySpell = sSpellMgr->GetSpellInfo(gameObj->GetSpellId());
        // Need disable spell use for owner
        if (createBySpell && createBySpell->IsCooldownStartedOnEvent())
            // note: item based cooldowns and cooldown spell mods with charges ignored (unknown existing cases)
            ToPlayer()->AddSpellAndCategoryCooldowns(createBySpell, 0, nullptr, true);
    }
}

void Unit::RemoveGameObject(GameObject* gameObj, bool del)
{
    if (!gameObj || gameObj->GetOwnerGUID() != GetGUID())
        return;

    gameObj->SetOwnerGUID(ObjectGuid::Empty);

    for (uint8 i = 0; i < MAX_GAMEOBJECT_SLOT; ++i)
    {
        if (m_ObjectSlot[i] == gameObj->GetGUID())
        {
            m_ObjectSlot[i].Clear();
            break;
        }
    }

    // GO created by some spell
    if (uint32 spellid = gameObj->GetSpellId())
    {
        RemoveAurasDueToSpell(spellid);

        if (GetTypeId() == TYPEID_PLAYER)
        {
            SpellInfo const* createBySpell = sSpellMgr->GetSpellInfo(spellid);
            // Need activate spell use for owner
            if (createBySpell && createBySpell->IsCooldownStartedOnEvent())
                // note: item based cooldowns and cooldown spell mods with charges ignored (unknown existing cases)
                ToPlayer()->SendCooldownEvent(createBySpell);
        }
    }

    m_gameObj.remove(gameObj->GetGUID());

    if (del)
    {
        gameObj->SetRespawnTime(0);
        gameObj->Delete();
    }
}

void Unit::RemoveGameObject(uint32 spellid, bool del)
{
    if (m_gameObj.empty())
        return;

    for (GameObjectList::iterator itr = m_gameObj.begin(); itr != m_gameObj.end();)
    {
        if (GameObject* go = ObjectAccessor::GetGameObject(*this, *itr))
        {
            if (spellid > 0 && go->GetSpellId() != spellid)
            {
                ++itr;
                continue;
            }

            go->SetOwnerGUID(ObjectGuid::Empty);
            if(del)
            {
                go->SetRespawnTime(0);
                go->Delete();
            }
        }
        m_gameObj.erase(itr++);
    }
}

void Unit::RemoveAllGameObjects()
{
    while(!m_gameObj.empty())
    {
        GameObject* go = ObjectAccessor::GetGameObject(*this, *m_gameObj.begin());
        if(go)
        {
            go->SetOwnerGUID(ObjectGuid::Empty);
            go->SetRespawnTime(0);
            go->Delete();
        }
        m_gameObj.erase(m_gameObj.begin());
    }
}

void Unit::SendSpellNonMeleeReflectLog(SpellNonMeleeDamage* log, Unit* attacker)
{
    // Xinef: function for players only, placed in unit because of cosmetics
    if (GetTypeId() != TYPEID_PLAYER)
        return;

    WorldPacket data(SMSG_SPELLNONMELEEDAMAGELOG, (16 + 4 + 4 + 4 + 1 + 4 + 4 + 1 + 1 + 4 + 4 + 1)); // we guess size
    //IF we are in cheat mode we swap absorb with damage and set damage to 0, this way we can still debug damage but our hp bar will not drop
    uint32 damage = log->damage;
    uint32 absorb = log->absorb;
    if (log->target->GetTypeId() == TYPEID_PLAYER && log->target->ToPlayer()->GetCommandStatus(CHEAT_GOD))
    {
        absorb = damage;
        damage = 0;
    }
    data << log->target->GetPackGUID();
    data << attacker->GetPackGUID();
    data << uint32(log->spellInfo->Id);
    data << uint32(damage);                                 // damage amount
    int32 overkill = damage - log->target->GetHealth();
    data << uint32(overkill > 0 ? overkill : 0);            // overkill
    data << uint8 (log->schoolMask);                        // damage school
    data << uint32(absorb);                                 // AbsorbedDamage
    data << uint32(log->resist);                            // resist
    data << uint8 (log->physicalLog);                       // if 1, then client show spell name (example: %s's ranged shot hit %s for %u school or %s suffers %u school damage from %s's spell_name
    data << uint8 (log->unused);                            // unused
    data << uint32(log->blocked);                           // blocked
    data << uint32(log->HitInfo);
    data << uint8 (0);                                      // flag to use extend data
    ToPlayer()->SendDirectMessage(&data);
}

void Unit::SendSpellNonMeleeDamageLog(SpellNonMeleeDamage* log)
{
    WorldPacket data(SMSG_SPELLNONMELEEDAMAGELOG, (16 + 4 + 4 + 4 + 1 + 4 + 4 + 1 + 1 + 4 + 4 + 1)); // we guess size
    //IF we are in cheat mode we swap absorb with damage and set damage to 0, this way we can still debug damage but our hp bar will not drop
    uint32 damage = log->damage;
    uint32 absorb = log->absorb;
    if (log->target->GetTypeId() == TYPEID_PLAYER && log->target->ToPlayer()->GetCommandStatus(CHEAT_GOD))
    {
        absorb = damage;
        damage = 0;
    }
    data << log->target->GetPackGUID();
    data << log->attacker->GetPackGUID();
    data << uint32(log->spellInfo->Id);
    data << uint32(damage);                                 // damage amount
    int32 overkill = damage - log->target->GetHealth();
    data << uint32(overkill > 0 ? overkill : 0);            // overkill
    data << uint8 (log->schoolMask);                        // damage school
    data << uint32(absorb);                                 // AbsorbedDamage
    data << uint32(log->resist);                            // resist
    data << uint8 (log->physicalLog);                       // if 1, then client show spell name (example: %s's ranged shot hit %s for %u school or %s suffers %u school damage from %s's spell_name
    data << uint8 (log->unused);                            // unused
    data << uint32(log->blocked);                           // blocked
    data << uint32(log->HitInfo);
    data << uint32(log->HitInfo);
    data << uint8(log->HitInfo & (SPELL_HIT_TYPE_CRIT_DEBUG | SPELL_HIT_TYPE_HIT_DEBUG | SPELL_HIT_TYPE_ATTACK_TABLE_DEBUG));
    //if (log->HitInfo & SPELL_HIT_TYPE_CRIT_DEBUG)
    //{
    //    data << float(log->CritRoll);
    //    data << float(log->CritNeeded);
    //}
    //if (log->HitInfo & SPELL_HIT_TYPE_HIT_DEBUG)
    //{
    //    data << float(log->HitRoll);
    //    data << float(log->HitNeeded);
    //}
    //if (log->HitInfo & SPELL_HIT_TYPE_ATTACK_TABLE_DEBUG)
    //{
    //    data << float(log->MissChance);
    //    data << float(log->DodgeChance);
    //    data << float(log->ParryChance);
    //    data << float(log->BlockChance);
    //    data << float(log->GlanceChance);
    //    data << float(log->CrushChance);
    //}
    SendMessageToSet(&data, true);
}

void Unit::SendSpellNonMeleeDamageLog(Unit* target, SpellInfo const* spellInfo, uint32 Damage, SpellSchoolMask damageSchoolMask, uint32 AbsorbedDamage, uint32 Resist, bool PhysicalDamage, uint32 Blocked, bool CriticalHit /*= false*/, bool Split /*= false*/)
{
    SpellNonMeleeDamage log(this, target, spellInfo, damageSchoolMask);
    log.damage = Damage;
    log.absorb = AbsorbedDamage;
    log.resist = Resist;
    log.physicalLog = PhysicalDamage;
    log.blocked = Blocked;
    log.HitInfo = 0;
    if (CriticalHit)
    {
        log.HitInfo |= SPELL_HIT_TYPE_CRIT;
    }
    if (Split)
    {
        log.HitInfo |= SPELL_HIT_TYPE_SPLIT;
    }
    SendSpellNonMeleeDamageLog(&log);
}

void Unit::ProcDamageAndSpell(Unit* actor, Unit* victim, uint32 procAttacker, uint32 procVictim, uint32 procExtra, uint32 amount, WeaponAttackType attType, SpellInfo const* procSpellInfo, SpellInfo const* procAura, int8 procAuraEffectIndex, Spell const* procSpell, DamageInfo* damageInfo, HealInfo* healInfo, uint32 procPhase)
{
    // Not much to do if no flags are set.
    if (procAttacker && actor)
        actor->ProcDamageAndSpellFor(false, victim, procAttacker, procExtra, attType, procSpellInfo, amount, procAura, procAuraEffectIndex, procSpell, damageInfo, healInfo, procPhase);
    // Now go on with a victim's events'n'auras
    // Not much to do if no flags are set or there is no victim
    if (victim && victim->IsAlive() && procVictim)
        victim->ProcDamageAndSpellFor(true, actor, procVictim, procExtra, attType, procSpellInfo, amount, procAura, procAuraEffectIndex, procSpell, damageInfo, healInfo, procPhase);
}

void Unit::SendPeriodicAuraLog(SpellPeriodicAuraLogInfo* pInfo)
{
    AuraEffect const* aura = pInfo->auraEff;
    WorldPacket data(SMSG_PERIODICAURALOG, 30);
    data << GetPackGUID();
    data << aura->GetCasterGUID().WriteAsPacked();
    data << uint32(aura->GetId());                          // spellId
    data << uint32(1);                                      // count
    data << uint32(aura->GetAuraType());                    // auraId
    switch (aura->GetAuraType())
    {
        case SPELL_AURA_PERIODIC_DAMAGE:
        case SPELL_AURA_PERIODIC_DAMAGE_PERCENT:
            {
                //IF we are in cheat mode we swap absorb with damage and set damage to 0, this way we can still debug damage but our hp bar will not drop
                uint32 damage = pInfo->damage;
                uint32 absorb = pInfo->absorb;
                if (GetTypeId() == TYPEID_PLAYER && ToPlayer()->GetCommandStatus(CHEAT_GOD))
                {
                    absorb = damage;
                    damage = 0;
                }

                data << uint32(damage);                         // damage
                data << uint32(pInfo->overDamage);              // overkill?
                data << uint32(aura->GetSpellInfo()->GetSchoolMask());
                data << uint32(absorb);                         // absorb
                data << uint32(pInfo->resist);                  // resist
                data << uint8(pInfo->critical);                 // new 3.1.2 critical tick
            }
            break;
        case SPELL_AURA_PERIODIC_HEAL:
        case SPELL_AURA_OBS_MOD_HEALTH:
            data << uint32(pInfo->damage);                  // damage
            data << uint32(pInfo->overDamage);              // overheal
            data << uint32(pInfo->absorb);                  // absorb
            data << uint8(pInfo->critical);                 // new 3.1.2 critical tick
            break;
        case SPELL_AURA_OBS_MOD_POWER:
        case SPELL_AURA_PERIODIC_ENERGIZE:
            data << uint32(aura->GetMiscValue());           // power type
            data << uint32(pInfo->damage);                  // damage
            break;
        case SPELL_AURA_PERIODIC_MANA_LEECH:
            data << uint32(aura->GetMiscValue());           // power type
            data << uint32(pInfo->damage);                  // amount
            data << float(pInfo->multiplier);               // gain multiplier
            break;
        default:
            LOG_ERROR("entities.unit", "Unit::SendPeriodicAuraLog: unknown aura {}", uint32(aura->GetAuraType()));
            return;
    }

    SendMessageToSet(&data, true);
}

void Unit::SendSpellMiss(Unit* target, uint32 spellID, SpellMissInfo missInfo)
{
    WorldPacket data(SMSG_SPELLLOGMISS, (4 + 8 + 1 + 4 + 8 + 1));
    data << uint32(spellID);
    data << GetGUID();
    data << uint8(0);                                       // can be 0 or 1
    data << uint32(1);                                      // target count
    // for (i = 0; i < target count; ++i)
    data << target->GetGUID();                              // target GUID
    data << uint8(missInfo);
    // end loop
    SendMessageToSet(&data, true);
}

void Unit::SendSpellDamageResist(Unit* target, uint32 spellId)
{
    WorldPacket data(SMSG_PROCRESIST, 8 + 8 + 4 + 1);
    data << GetGUID();
    data << target->GetGUID();
    data << uint32(spellId);
    data << uint8(0); // bool - log format: 0-default, 1-debug
    SendMessageToSet(&data, true);
}

void Unit::SendSpellDamageImmune(Unit* target, uint32 spellId)
{
    WorldPacket data(SMSG_SPELLORDAMAGE_IMMUNE, 8 + 8 + 4 + 1);
    data << GetGUID();
    data << target->GetGUID();
    data << uint32(spellId);
    data << uint8(0); // bool - log format: 0-default, 1-debug
    SendMessageToSet(&data, true);
}

void Unit::SendAttackStateUpdate(CalcDamageInfo* damageInfo)
{
    LOG_DEBUG("entities.unit", "WORLD: Sending SMSG_ATTACKERSTATEUPDATE");

    uint32 tmpDamage[MAX_ITEM_PROTO_DAMAGES] = { };
    uint32 tmpAbsorb[MAX_ITEM_PROTO_DAMAGES] = { };
    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        //IF we are in cheat mode we swap absorb with damage and set damage to 0, this way we can still debug damage but our hp bar will not drop
        tmpDamage[i] = damageInfo->damages[i].damage;
        tmpAbsorb[i] = damageInfo->damages[i].absorb;
        if (damageInfo->target->GetTypeId() == TYPEID_PLAYER && damageInfo->target->ToPlayer()->GetCommandStatus(CHEAT_GOD))
        {
            tmpAbsorb[i] = tmpDamage[i];
            tmpDamage[i] = 0;
        }
    }

    uint32 count = 1;
    if (tmpDamage[1] || tmpAbsorb[1] || damageInfo->damages[1].resist)
    {
        ++count;
    }

    size_t const maxsize = 4 + 5 + 5 + 4 + 4 + 1 + count * (4 + 4 + 4 + 4 + 4) + 1 + 4 + 4 + 4 + 4 + 4 * 12;
    WorldPacket data(SMSG_ATTACKERSTATEUPDATE, maxsize);            // we guess size
    data << uint32(damageInfo->HitInfo);
    data << damageInfo->attacker->GetPackGUID();
    data << damageInfo->target->GetPackGUID();
    data << uint32(tmpDamage[0] + tmpDamage[1]);                    // Full damage
    int32 overkill = tmpDamage[0] + tmpDamage[1] - damageInfo->target->GetHealth();
    data << uint32(overkill < 0 ? 0 : overkill);                    // Overkill
    data << uint8(count);                                           // Sub damage count

    for (uint32 i = 0; i < count; ++i)
    {
        data << uint32(damageInfo->damages[i].damageSchoolMask);    // School of sub damage
        data << float(tmpDamage[i]);                                // sub damage
        data << uint32(tmpDamage[i]);                               // Sub Damage
    }

    if (damageInfo->HitInfo & (HITINFO_FULL_ABSORB | HITINFO_PARTIAL_ABSORB))
    {
        for (uint32 i = 0; i < count; ++i)
        {
            data << uint32(tmpAbsorb[i]);                           // Absorb
        }
    }

    if (damageInfo->HitInfo & (HITINFO_FULL_RESIST | HITINFO_PARTIAL_RESIST))
    {
        for (uint32 i = 0; i < count; ++i)
        {
            data << uint32(damageInfo->damages[i].resist);          // Resist
        }
    }

    data << uint8(damageInfo->TargetState);
    data << uint32(0);  // Unknown attackerstate
    data << uint32(0);  // Melee spellid

    if (damageInfo->HitInfo & HITINFO_BLOCK)
        data << uint32(damageInfo->blocked_amount);

    if (damageInfo->HitInfo & HITINFO_RAGE_GAIN)
        data << uint32(0);

    //! Probably used for debugging purposes, as it is not known to appear on retail servers
    if (damageInfo->HitInfo & HITINFO_UNK1)
    {
        data << uint32(0);
        data << float(0);
        data << float(0);
        data << float(0);
        data << float(0);
        data << float(0);
        data << float(0);
        data << float(0);
        data << float(0);
        data << float(0);       // Found in a loop with 1 iteration
        data << float(0);       // ditto ^
        data << uint32(0);
    }

    SendMessageToSet(&data, true);
}

void Unit::SendAttackStateUpdate(uint32 HitInfo, Unit* target, uint8 /*SwingType*/, SpellSchoolMask damageSchoolMask, uint32 Damage, uint32 AbsorbDamage, uint32 Resist, VictimState TargetState, uint32 BlockedAmount)
{
    CalcDamageInfo dmgInfo;
    dmgInfo.HitInfo = HitInfo;
    dmgInfo.attacker = this;
    dmgInfo.target = target;

    dmgInfo.damages[0].damage = Damage - AbsorbDamage - Resist - BlockedAmount;
    dmgInfo.damages[0].damageSchoolMask = damageSchoolMask;
    dmgInfo.damages[0].absorb = AbsorbDamage;
    dmgInfo.damages[0].resist = Resist;

    dmgInfo.damages[1].damage = 0;
    dmgInfo.damages[1].damageSchoolMask = 0;
    dmgInfo.damages[1].absorb = 0;
    dmgInfo.damages[1].resist = 0;

    dmgInfo.TargetState = TargetState;
    dmgInfo.blocked_amount = BlockedAmount;
    SendAttackStateUpdate(&dmgInfo);
}

//victim may be nullptr
bool Unit::HandleDummyAuraProc(Unit* victim, uint32 damage, AuraEffect* triggeredByAura, SpellInfo const* procSpell, uint32 procFlag, uint32 procEx, uint32 cooldown, ProcEventInfo const& eventInfo)
{
    SpellInfo const* dummySpell = triggeredByAura->GetSpellInfo();
    uint32 effIndex = triggeredByAura->GetEffIndex();
    int32  triggerAmount = triggeredByAura->GetAmount();
    Spell const* spellProc = eventInfo.GetProcSpell();

    Item* castItem = triggeredByAura->GetBase()->GetCastItemGUID() && GetTypeId() == TYPEID_PLAYER
                     ? ToPlayer()->GetItemByGuid(triggeredByAura->GetBase()->GetCastItemGUID()) : nullptr;

    uint32 triggered_spell_id = 0;
    uint32 cooldown_spell_id = 0; // for random trigger, will be one of the triggered spell to avoid repeatable triggers
    // otherwise, it's the triggered_spell_id by default
    Unit* target = victim;
    int32 basepoints0 = 0;
    ObjectGuid originalCaster;

    switch (dummySpell->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            {
                switch (dummySpell->Id)
                {
                    // Overkill
                    case 58426:
                        {
                            triggered_spell_id = 58427;
                            break;
                        }
                    // Unstable Power
                    case 24658:
                        {
                            if (!procSpell || procSpell->Id == 24659)
                                return false;
                            // Need remove one 24659 aura
                            RemoveAuraFromStack(24659);
                            return true;
                        }
                    // Restless Strength
                    case 24661:
                        {
                            // Need remove one 24662 aura
                            RemoveAuraFromStack(24662);
                            return true;
                        }
                    // Mark of Malice
                    case 33493:
                        {
                            if (triggeredByAura->GetBase()->GetCharges() > 1)
                                return true;

                            target = this;
                            triggered_spell_id = 33494;
                            break;
                        }
                    // Twisted Reflection (boss spell)
                    case 21063:
                        triggered_spell_id = 21064;
                        break;
                    // Vampiric Aura (boss spell)
                    case 38196:
                        {
                            basepoints0 = 3 * damage;               // 300%
                            if (basepoints0 < 0)
                                return false;

                            triggered_spell_id = 31285;
                            target = this;
                            break;
                        }
                    // Aura of Madness (Darkmoon Card: Madness trinket)
                    //=====================================================
                    // 39511 Sociopath: +35 strength (Paladin, Rogue, Druid, Warrior)
                    // 40997 Delusional: +70 attack power (Rogue, Hunter, Paladin, Warrior, Druid)
                    // 40998 Kleptomania: +35 agility (Warrior, Rogue, Paladin, Hunter, Druid)
                    // 40999 Megalomania: +41 damage/healing (Druid, Shaman, Priest, Warlock, Mage, Paladin)
                    // 41002 Paranoia: +35 spell/melee/ranged crit strike rating (All classes)
                    // 41005 Manic: +35 haste (spell, melee and ranged) (All classes)
                    // 41009 Narcissism: +35 intellect (Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter)
                    // 41011 Martyr Complex: +35 stamina (All classes)
                    // 41406 Dementia: Every 5 seconds either gives you +5% damage/healing. (Druid, Shaman, Priest, Warlock, Mage, Paladin)
                    // 41409 Dementia: Every 5 seconds either gives you -5% damage/healing. (Druid, Shaman, Priest, Warlock, Mage, Paladin)
                    case 39446:
                        {
                            if (GetTypeId() != TYPEID_PLAYER || !IsAlive())
                                return false;

                            // Select class defined buff
                            switch (getClass())
                            {
                                case CLASS_PALADIN:                 // 39511, 40997, 40998, 40999, 41002, 41005, 41009, 41011, 41409
                                case CLASS_DRUID:                   // 39511, 40997, 40998, 40999, 41002, 41005, 41009, 41011, 41409
                                    triggered_spell_id = RAND(39511, 40997, 40998, 40999, 41002, 41005, 41009, 41011, 41409);
                                    cooldown_spell_id = 39511;
                                    break;
                                case CLASS_ROGUE:                   // 39511, 40997, 40998, 41002, 41005, 41011
                                case CLASS_WARRIOR:                 // 39511, 40997, 40998, 41002, 41005, 41011
                                case CLASS_DEATH_KNIGHT:
                                    triggered_spell_id = RAND(39511, 40997, 40998, 41002, 41005, 41011);
                                    cooldown_spell_id = 39511;
                                    break;
                                case CLASS_PRIEST:                  // 40999, 41002, 41005, 41009, 41011, 41406, 41409
                                case CLASS_SHAMAN:                  // 40999, 41002, 41005, 41009, 41011, 41406, 41409
                                case CLASS_MAGE:                    // 40999, 41002, 41005, 41009, 41011, 41406, 41409
                                case CLASS_WARLOCK:                 // 40999, 41002, 41005, 41009, 41011, 41406, 41409
                                    triggered_spell_id = RAND(40999, 41002, 41005, 41009, 41011, 41406, 41409);
                                    cooldown_spell_id = 40999;
                                    break;
                                case CLASS_HUNTER:                  // 40997, 40999, 41002, 41005, 41009, 41011, 41406, 41409
                                    triggered_spell_id = RAND(40997, 40999, 41002, 41005, 41009, 41011, 41406, 41409);
                                    cooldown_spell_id = 40997;
                                    break;
                                default:
                                    return false;
                            }

                            target = this;
                            if (roll_chance_i(10))
                                ToPlayer()->Say("This is Madness!", LANG_UNIVERSAL); /// @todo: It should be moved to database, shouldn't it?
                            break;
                        }
                    // Sunwell Exalted Caster Neck (??? neck)
                    // cast ??? Light's Wrath if Exalted by Aldor
                    // cast ??? Arcane Bolt if Exalted by Scryers
                    case 46569:
                        return false;                           // old unused version
                    // Sunwell Exalted Caster Neck (Shattered Sun Pendant of Acumen neck)
                    // cast 45479 Light's Wrath if Exalted by Aldor
                    // cast 45429 Arcane Bolt if Exalted by Scryers
                    case 45481:
                        {
                            Player* player = ToPlayer();
                            if (!player)
                                return false;

                            // Get Aldor reputation rank
                            if (player->GetReputationRank(932) == REP_EXALTED)
                            {
                                target = this;
                                triggered_spell_id = 45479;
                                break;
                            }
                            // Get Scryers reputation rank
                            if (player->GetReputationRank(934) == REP_EXALTED)
                            {
                                // triggered at positive/self casts also, current attack target used then
                                if (target && IsFriendlyTo(target))
                                {
                                    target = GetVictim();
                                    if (!target)
                                    {
                                        target = player->GetSelectedUnit();
                                        if (!target)
                                            return false;
                                    }
                                    if (IsFriendlyTo(target))
                                        return false;
                                }

                                triggered_spell_id = 45429;
                                break;
                            }
                            return false;
                        }
                    // Sunwell Exalted Melee Neck (Shattered Sun Pendant of Might neck)
                    // cast 45480 Light's Strength if Exalted by Aldor
                    // cast 45428 Arcane Strike if Exalted by Scryers
                    case 45482:
                        {
                            if (GetTypeId() != TYPEID_PLAYER)
                                return false;

                            // Get Aldor reputation rank
                            if (ToPlayer()->GetReputationRank(932) == REP_EXALTED)
                            {
                                target = this;
                                triggered_spell_id = 45480;
                                break;
                            }
                            // Get Scryers reputation rank
                            if (ToPlayer()->GetReputationRank(934) == REP_EXALTED)
                            {
                                triggered_spell_id = 45428;
                                break;
                            }
                            return false;
                        }
                    // Sunwell Exalted Tank Neck (Shattered Sun Pendant of Resolve neck)
                    // cast 45431 Arcane Insight if Exalted by Aldor
                    // cast 45432 Light's Ward if Exalted by Scryers
                    case 45483:
                        {
                            if (GetTypeId() != TYPEID_PLAYER)
                                return false;

                            // Get Aldor reputation rank
                            if (ToPlayer()->GetReputationRank(932) == REP_EXALTED)
                            {
                                target = this;
                                triggered_spell_id = 45432;
                                break;
                            }
                            // Get Scryers reputation rank
                            if (ToPlayer()->GetReputationRank(934) == REP_EXALTED)
                            {
                                target = this;
                                triggered_spell_id = 45431;
                                break;
                            }
                            return false;
                        }
                    // Sunwell Exalted Healer Neck (Shattered Sun Pendant of Restoration neck)
                    // cast 45478 Light's Salvation if Exalted by Aldor
                    // cast 45430 Arcane Surge if Exalted by Scryers
                    case 45484:
                        {
                            if (GetTypeId() != TYPEID_PLAYER)
                                return false;

                            // Get Aldor reputation rank
                            if (ToPlayer()->GetReputationRank(932) == REP_EXALTED)
                            {
                                target = this;
                                triggered_spell_id = 45478;
                                break;
                            }
                            // Get Scryers reputation rank
                            if (ToPlayer()->GetReputationRank(934) == REP_EXALTED)
                            {
                                triggered_spell_id = 45430;
                                break;
                            }
                            return false;
                        }
                    // Kill command
                    case 58914:
                        {
                            // Remove aura stack from pet
                            RemoveAuraFromStack(58914);
                            Unit* owner = GetOwner();
                            if (!owner)
                                return true;
                            // reduce the owner's aura stack
                            owner->RemoveAuraFromStack(34027);
                            return true;
                        }
                    // Vampiric Touch (generic, used by some boss)
                    case 52723:
                    case 60501:
                        {
                            triggered_spell_id = 52724;
                            basepoints0 = damage / 2;
                            target = this;
                            break;
                        }
                    // Divine purpose
                    case 31871:
                    case 31872:
                        {
                            // Roll chane
                            if (!victim || !victim->IsAlive() || !roll_chance_i(triggerAmount))
                                return false;

                            // Remove any stun effect on target
                            victim->RemoveAurasWithMechanic(1 << MECHANIC_STUN, AURA_REMOVE_BY_ENEMY_SPELL);
                            return true;
                        }
                    // Glyph of Life Tap
                    case 63320:
                        {
                            triggered_spell_id = 63321; // Life Tap
                            break;
                        }
                    case 71519: // Deathbringer's Will Normal
                        {
                            if (GetTypeId() != TYPEID_PLAYER || HasSpellCooldown(71484))
                                return false;

                            AddSpellCooldown(71484, 0, cooldown);

                            std::vector<uint32> RandomSpells;
                            switch (getClass())
                            {
                                case CLASS_WARRIOR:
                                case CLASS_PALADIN:
                                case CLASS_DEATH_KNIGHT:
                                    RandomSpells.push_back(71484);
                                    RandomSpells.push_back(71491);
                                    RandomSpells.push_back(71492);
                                    break;
                                case CLASS_SHAMAN:
                                case CLASS_ROGUE:
                                    RandomSpells.push_back(71486);
                                    RandomSpells.push_back(71485);
                                    RandomSpells.push_back(71492);
                                    break;
                                case CLASS_DRUID:
                                    RandomSpells.push_back(71484);
                                    RandomSpells.push_back(71485);
                                    RandomSpells.push_back(71492);
                                    break;
                                case CLASS_HUNTER:
                                    RandomSpells.push_back(71486);
                                    RandomSpells.push_back(71491);
                                    RandomSpells.push_back(71485);
                                    break;
                                default:
                                    return false;
                            }
                            if (RandomSpells.empty()) // shouldn't happen
                                return false;

                            uint8 rand_spell = irand(0, (RandomSpells.size() - 1));
                            CastSpell(target, RandomSpells[rand_spell], true, castItem, triggeredByAura, originalCaster);
                            break;
                        }
                    case 71562: // Deathbringer's Will Heroic
                        {
                            if (GetTypeId() != TYPEID_PLAYER || HasSpellCooldown(71561))
                                return false;

                            AddSpellCooldown(71561, 0, cooldown);

                            std::vector<uint32> RandomSpells;
                            switch (getClass())
                            {
                                case CLASS_WARRIOR:
                                case CLASS_PALADIN:
                                case CLASS_DEATH_KNIGHT:
                                    RandomSpells.push_back(71561);
                                    RandomSpells.push_back(71559);
                                    RandomSpells.push_back(71560);
                                    break;
                                case CLASS_SHAMAN:
                                case CLASS_ROGUE:
                                    RandomSpells.push_back(71558);
                                    RandomSpells.push_back(71556);
                                    RandomSpells.push_back(71560);
                                    break;
                                case CLASS_DRUID:
                                    RandomSpells.push_back(71561);
                                    RandomSpells.push_back(71556);
                                    RandomSpells.push_back(71560);
                                    break;
                                case CLASS_HUNTER:
                                    RandomSpells.push_back(71558);
                                    RandomSpells.push_back(71559);
                                    RandomSpells.push_back(71556);
                                    break;
                                default:
                                    return false;
                            }
                            if (RandomSpells.empty()) // shouldn't happen
                                return false;

                            uint8 rand_spell = irand(0, (RandomSpells.size() - 1));
                            CastSpell(target, RandomSpells[rand_spell], true, castItem, triggeredByAura, originalCaster);
                            break;
                        }
                    // Freya, Petrified Bark
                    case 62933:
                    case 62337:
                        {
                            if (!victim)
                                return false;

                            int32 dmg = damage;
                            victim->CastCustomSpell(this, 62379, &dmg, 0, 0, true);
                            return true;
                        }
                    // Trial of the Champion, Earth Shield
                    case 67534:
                        {
                            const int32 dmg = (int32)damage;
                            CastCustomSpell(this, 67535, &dmg, nullptr, nullptr, true, 0, triggeredByAura, triggeredByAura->GetCasterGUID());
                            return true;
                        }
                    // Trial of the Crusader, Faction Champions, Retaliation
                    case 65932:
                        {
                            // check attack comes not from behind
                            if (!victim || !HasInArc(M_PI, victim))
                                return false;

                            triggered_spell_id = 65934;
                            break;
                        }
                    // Pit of Saron, Tyrannus, Overlord's Brand
                    case 69172: // everything except for DoTs
                        {
                            if (!target)
                                return false;
                            if (Unit* caster = triggeredByAura->GetCaster())
                            {
                                if (procFlag & (PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS | PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS))
                                {
                                    int32 dmg = 5.5f * damage;
                                    target->CastCustomSpell(caster, 69190, &dmg, 0, 0, true);
                                }
                                else
                                {
                                    if (caster->GetVictim())
                                    {
                                        int32 dmg = damage;
                                        target->CastCustomSpell(caster->GetVictim(), 69189, &dmg, 0, 0, true);
                                    }
                                }
                            }
                            return true;
                        }
                    // Pit of Saron, Tyrannus, Overlord's Brand
                    case 69173: // only DoTs
                        {
                            if (!target)
                                return false;
                            if (Unit* caster = triggeredByAura->GetCaster())
                            {
                                if (procEx & PROC_EX_INTERNAL_HOT)
                                {
                                    int32 dmg = 5.5f * damage;
                                    target->CastCustomSpell(caster, 69190, &dmg, 0, 0, true);
                                }
                                else
                                {
                                    if (caster->GetVictim())
                                    {
                                        int32 dmg = damage;
                                        target->CastCustomSpell(caster->GetVictim(), 69189, &dmg, 0, 0, true);
                                    }
                                }
                            }
                            return true;
                        }
                    // Icecrown Citadel, Lady Deathwhisper, Vampiric Might
                    case 70674:
                        {
                            if (Unit* caster = triggeredByAura->GetCaster())
                            {
                                int32 dmg = 3 * damage;
                                caster->CastCustomSpell(caster, 70677, &dmg, 0, 0, true);
                            }
                            return true;
                        }
                    // Item: Purified Shard of the Gods
                    case 69755:
                        {
                            triggered_spell_id = ((procFlag & PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS) ? 69733 : 69729);
                            break;
                        }
                    // Item: Shiny Shard of the Gods
                    case 69739:
                        {
                            triggered_spell_id = ((procFlag & PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS) ? 69734 : 69730);
                            break;
                        }
                    // VoA: Meteor Fists koralon
                    case 66725:
                    case 68161:
                        {
                            triggered_spell_id = 66765; // handled by spell_difficulty
                            break;
                        }
                }
                break;
            }
        case SPELLFAMILY_MAGE:
            {
                // Magic Absorption
                if (dummySpell->SpellIconID == 459)             // only this spell has SpellIconID == 459 and dummy aura
                {
                    if (!HasActivePowerType(POWER_MANA))
                        return false;

                    // mana reward
                    basepoints0 = CalculatePct(int32(GetMaxPower(POWER_MANA)), triggerAmount);
                    target = this;
                    triggered_spell_id = 29442;
                    break;
                }
                // Hot Streak
                if (dummySpell->SpellIconID == 2999)
                {
                    if (effIndex != 0)
                        return false;
                    AuraEffect* counter = triggeredByAura->GetBase()->GetEffect(EFFECT_1);
                    if (!counter)
                        return true;

                    // Count spell criticals in a row in second aura
                    if (procEx & PROC_EX_CRITICAL_HIT)
                    {
                        counter->SetAmount(counter->GetAmount() * 2);
                        if (counter->GetAmount() < 100) // not enough
                            return true;
                        // Crititcal counted -> roll chance
                        if (roll_chance_i(triggerAmount))
                            CastSpell(this, 48108, true, castItem, triggeredByAura);
                    }
                    counter->SetAmount(25);
                    return true;
                }
                // Incanter's Regalia set (add trigger chance to Mana Shield)
                if (dummySpell->SpellFamilyFlags[0] & 0x8000)
                {
                    if (GetTypeId() != TYPEID_PLAYER)
                        return false;

                    target = this;
                    triggered_spell_id = 37436;
                    break;
                }
                switch (dummySpell->Id)
                {
                    // Glyph of Polymorph
                    case 56375:
                        {
                            if (!target)
                                return false;
                            target->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE, ObjectGuid::Empty, target->GetAura(32409)); // SW:D shall not be removed.
                            target->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
                            target->RemoveAurasByType(SPELL_AURA_PERIODIC_LEECH);
                            return true;
                        }
                    // Glyph of Icy Veins
                    case 56374:
                        {
                            RemoveAurasByType(SPELL_AURA_HASTE_SPELLS, ObjectGuid::Empty, 0, true, false);
                            RemoveAurasByType(SPELL_AURA_MOD_DECREASE_SPEED);
                            return true;
                        }
                    // Glyph of Ice Block
                    case 56372:
                        {
                            Player* player = ToPlayer();
                            if (!player)
                                return false;

                            SpellCooldowns const cooldowns = player->GetSpellCooldowns();
                            // remove cooldowns on all ranks of Frost Nova
                            for (SpellCooldowns::const_iterator itr = cooldowns.begin(); itr != cooldowns.end(); ++itr)
                            {
                                SpellInfo const* cdSpell = sSpellMgr->GetSpellInfo(itr->first);
                                // Frost Nova
                                if (cdSpell && cdSpell->SpellFamilyName == SPELLFAMILY_MAGE
                                        && cdSpell->SpellFamilyFlags[0] & 0x00000040)
                                    player->RemoveSpellCooldown(cdSpell->Id, true);
                            }
                            break;
                        }
                }
                break;
            }
        case SPELLFAMILY_WARRIOR:
            {
                switch (dummySpell->Id)
                {
                    // Victorious
                    case 32216:
                        {
                            RemoveAura(dummySpell->Id);
                            return false;
                        }
                }

                // Second Wind
                if (dummySpell->SpellIconID == 1697)
                {
                    // only for spells and hit/crit (trigger start always) and not start from self casted spells (5530 Mace Stun Effect for example)
                    if (procSpell == 0 || !(procEx & (PROC_EX_NORMAL_HIT | PROC_EX_CRITICAL_HIT)) || this == victim)
                        return false;
                    // Need stun or root mechanic
                    if (!(procSpell->GetAllEffectsMechanicMask() & ((1 << MECHANIC_ROOT) | (1 << MECHANIC_STUN))))
                        return false;

                    switch (dummySpell->Id)
                    {
                        case 29838:
                            triggered_spell_id = 29842;
                            break;
                        case 29834:
                            triggered_spell_id = 29841;
                            break;
                        case 42770:
                            triggered_spell_id = 42771;
                            break;
                        default:
                            LOG_ERROR("entities.unit", "Unit::HandleDummyAuraProc: non handled spell id: {} (SW)", dummySpell->Id);
                            return false;
                    }

                    target = this;
                    break;
                }
                break;
            }
        case SPELLFAMILY_WARLOCK:
            {
                switch (dummySpell->Id)
                {
                    // Nightfall
                    case 18094:
                    case 18095:
                    // Glyph of corruption
                    case 56218:
                        {
                            target = this;
                            triggered_spell_id = 17941;
                            break;
                        }
                    // Soul Leech
                    case 30293:
                    case 30295:
                    case 30296:
                        {
                            // Improved Soul Leech
                            AuraEffectList const& SoulLeechAuras = GetAuraEffectsByType(SPELL_AURA_DUMMY);
                            for (Unit::AuraEffectList::const_iterator i = SoulLeechAuras.begin(); i != SoulLeechAuras.end(); ++i)
                            {
                                if ((*i)->GetId() == 54117 || (*i)->GetId() == 54118)
                                {
                                    if ((*i)->GetEffIndex() != 0)
                                        continue;
                                    basepoints0 = int32((*i)->GetAmount());
                                    target = GetGuardianPet();
                                    if (target)
                                    {
                                        // regen mana for pet
                                        CastCustomSpell(target, 54607, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura);
                                    }
                                    // regen mana for caster
                                    CastCustomSpell(this, 59117, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura);
                                    // Get second aura of spell for replenishment effect on party
                                    if (AuraEffect const* aurEff = (*i)->GetBase()->GetEffect(EFFECT_1))
                                    {
                                        // Replenishment - roll chance
                                        if (roll_chance_i(aurEff->GetAmount()))
                                        {
                                            CastSpell(this, 57669, true, castItem, triggeredByAura);
                                        }
                                    }
                                    break;
                                }
                            }
                            // health
                            basepoints0 = CalculatePct(int32(damage), triggerAmount);
                            target = this;
                            triggered_spell_id = 30294;
                            break;
                        }
                    // Shadowflame (Voidheart Raiment set bonus)
                    case 37377:
                        {
                            triggered_spell_id = 37379;
                            break;
                        }
                    // Pet Healing (Corruptor Raiment or Rift Stalker Armor)
                    case 37381:
                        {
                            target = GetGuardianPet();
                            if (!target)
                                return false;

                            // heal amount
                            basepoints0 = CalculatePct(int32(damage), triggerAmount);
                            triggered_spell_id = 37382;
                            break;
                        }
                    // Shadowflame Hellfire (Voidheart Raiment set bonus)
                    case 39437:
                        {
                            triggered_spell_id = 37378;
                            break;
                        }
                }
                break;
            }
        case SPELLFAMILY_PRIEST:
            {
                // Body and Soul
                if (dummySpell->SpellIconID == 2218)
                {
                    // Proc only from Abolish desease on self cast
                    if (procSpell->Id != 552 || victim != this || !roll_chance_i(triggerAmount))
                        return false;
                    triggered_spell_id = 64136;
                    target = this;
                    break;
                }
                switch (dummySpell->Id)
                {
                    // Vampiric Embrace
                    case 15286:
                        {
                            if (!victim || !victim->IsAlive() || procSpell->SpellFamilyFlags[1] & 0x80000)
                                return false;

                            // heal amount
                            int32 total = CalculatePct(int32(damage), triggerAmount);
                            int32 team = total / 5;
                            int32 self = total - team;
                            CastCustomSpell(this, 15290, &team, &self, nullptr, true, castItem, triggeredByAura);
                            return true;                                // no hidden cooldown
                        }
                    // Priest Tier 6 Trinket (Ashtongue Talisman of Acumen)
                    case 40438:
                        {
                            // Shadow Word: Pain
                            if (procSpell->SpellFamilyFlags[0] & 0x8000)
                                triggered_spell_id = 40441;
                            // Renew
                            else if (procSpell->SpellFamilyFlags[0] & 0x40)
                                triggered_spell_id = 40440;
                            else
                                return false;

                            target = this;
                            break;
                        }
                    // Improved Shadowform
                    case 47570:
                    case 47569:
                        {
                            if (!roll_chance_i(triggerAmount))
                                return false;

                            RemoveMovementImpairingAuras(true);
                            break;
                        }
                    // Glyph of Dispel Magic
                    case 55677:
                        {
                            // Dispel Magic shares spellfamilyflag with abolish disease
                            if (procSpell->SpellIconID != 74)
                                return false;
                            if (!target || !target->IsFriendlyTo(this))
                                return false;

                            basepoints0 = int32(target->CountPctFromMaxHealth(triggerAmount));
                            triggered_spell_id = 56131;
                            break;
                        }
                    // Oracle Healing Bonus ("Garments of the Oracle" set)
                    case 26169:
                        {
                            // heal amount
                            basepoints0 = int32(CalculatePct(damage, 10));
                            target = this;
                            triggered_spell_id = 26170;
                            break;
                        }
                    // Frozen Shadoweave (Shadow's Embrace set) warning! its not only priest set
                    case 39372:
                        {
                            if (!procSpell || (procSpell->GetSchoolMask() & (SPELL_SCHOOL_MASK_FROST | SPELL_SCHOOL_MASK_SHADOW)) == 0)
                                return false;

                            // heal amount
                            basepoints0 = CalculatePct(int32(damage), triggerAmount);
                            target = this;
                            triggered_spell_id = 39373;
                            break;
                        }
                    // Greater Heal (Vestments of Faith (Priest Tier 3) - 4 pieces bonus)
                    case 28809:
                        {
                            triggered_spell_id = 28810;
                            break;
                        }
                    // Priest T10 Healer 2P Bonus
                    case 70770:
                        // Flash Heal
                        if (procSpell->SpellFamilyFlags[0] & 0x800)
                        {
                            triggered_spell_id = 70772;
                            SpellInfo const* blessHealing = sSpellMgr->GetSpellInfo(triggered_spell_id);
                            if (!blessHealing || !victim)
                                return false;
                            basepoints0 = int32(CalculatePct(damage, triggerAmount) / (blessHealing->GetMaxDuration() / blessHealing->Effects[0].Amplitude));
                            victim->CastDelayedSpellWithPeriodicAmount(this, triggered_spell_id, SPELL_AURA_PERIODIC_HEAL, basepoints0);
                            return true;
                        }
                        break;
                }
                break;
            }
        case SPELLFAMILY_DRUID:
            {
                switch (dummySpell->Id)
                {
                    // Glyph of Innervate
                    case 54832:
                        {
                            if (procSpell->SpellIconID != 62)
                                return false;

                            int32 mana_perc = triggeredByAura->GetSpellInfo()->Effects[triggeredByAura->GetEffIndex()].CalcValue();
                            basepoints0 = int32(CalculatePct(GetCreatePowers(POWER_MANA), mana_perc) / 10);
                            triggered_spell_id = 54833;
                            target = this;
                            break;
                        }
                    // Glyph of Starfire
                    case 54845:
                        {
                            triggered_spell_id = 54846;
                            break;
                        }
                    // Glyph of Shred
                    case 54815:
                        {
                            if (!target)
                                return false;

                            // try to find spell Rip on the target
                            if (AuraEffect const* AurEff = target->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_DRUID, 0x00800000, 0x0, 0x0, GetGUID()))
                            {
                                // Rip's max duration, note: spells which modifies Rip's duration also counted like Glyph of Rip
                                uint32 CountMin = AurEff->GetBase()->GetMaxDuration();

                                // just Rip's max duration without other spells
                                uint32 CountMax = AurEff->GetSpellInfo()->GetMaxDuration();

                                // add possible auras' and Glyph of Shred's max duration
                                CountMax += 3 * triggerAmount * IN_MILLISECONDS;      // Glyph of Shred               -> +6 seconds
                                CountMax += HasAura(54818) ? 4 * IN_MILLISECONDS : 0; // Glyph of Rip                 -> +4 seconds
                                CountMax += HasAura(60141) ? 4 * IN_MILLISECONDS : 0; // Rip Duration/Lacerate Damage -> +4 seconds

                                // if min < max -> that means caster didn't cast 3 shred yet
                                // so set Rip's duration and max duration
                                if (CountMin < CountMax)
                                {
                                    AurEff->GetBase()->SetDuration(AurEff->GetBase()->GetDuration() + triggerAmount * IN_MILLISECONDS);
                                    AurEff->GetBase()->SetMaxDuration(CountMin + triggerAmount * IN_MILLISECONDS);
                                    return true;
                                }
                            }
                            // if not found Rip
                            return false;
                        }
                    // Glyph of Rake
                    case 54821:
                        {
                            if (procSpell->SpellVisual[0] == 750 && procSpell->Effects[1].ApplyAuraName == 3)
                            {
                                if (target && target->GetTypeId() == TYPEID_UNIT)
                                {
                                    triggered_spell_id = 54820;
                                    break;
                                }
                            }
                            return false;
                        }
                    // Leader of the Pack
                    case 24932:
                        {
                            if (triggerAmount <= 0)
                                return false;
                            basepoints0 = int32(CountPctFromMaxHealth(triggerAmount));
                            target = this;
                            triggered_spell_id = 34299;
                            if (triggeredByAura->GetCasterGUID() != GetGUID())
                                break;
                            int32 basepoints1 = CalculatePct(GetMaxPower(Powers(POWER_MANA)), triggerAmount * 2);
                            // Improved Leader of the Pack
                            // Check cooldown of heal spell cooldown
                            if (GetTypeId() == TYPEID_PLAYER && !ToPlayer()->HasSpellCooldown(34299))
                                CastCustomSpell(this, 68285, &basepoints1, 0, 0, true, 0, triggeredByAura);
                            break;
                        }
                    // Healing Touch (Dreamwalker Raiment set)
                    case 28719:
                        {
                            // mana back
                            basepoints0 = int32(CalculatePct(spellProc->GetPowerCost(), 30));
                            target = this;
                            triggered_spell_id = 28742;
                            break;
                        }
                    // Glyph of Rejuvenation
                    case 54754:
                        {
                            if (!victim || !victim->HealthBelowPct(uint32(triggerAmount)))
                                return false;
                            basepoints0 = CalculatePct(int32(damage), triggerAmount);
                            triggered_spell_id = 54755;
                            break;
                        }
                    // Healing Touch Refund (Idol of Longevity trinket)
                    case 28847:
                        {
                            target = this;
                            triggered_spell_id = 28848;
                            break;
                        }
                    // Mana Restore (Malorne Raiment set / Malorne Regalia set)
                    case 37288:
                    case 37295:
                        {
                            target = this;
                            triggered_spell_id = 37238;
                            break;
                        }
                    // Druid Tier 6 Trinket
                    case 40442:
                        {
                            float  chance;

                            // Starfire
                            if (procSpell->SpellFamilyFlags[0] & 0x4)
                            {
                                triggered_spell_id = 40445;
                                chance = 25.0f;
                            }
                            // Rejuvenation
                            else if (procSpell->SpellFamilyFlags[0] & 0x10)
                            {
                                triggered_spell_id = 40446;
                                chance = 25.0f;
                            }
                            // Mangle (Bear) and Mangle (Cat)
                            else if (procSpell->SpellFamilyFlags[1] & 0x00000440)
                            {
                                triggered_spell_id = 40452;
                                chance = 40.0f;
                            }
                            else
                                return false;

                            if (!roll_chance_f(chance))
                                return false;

                            target = this;
                            break;
                        }
                    // Maim Interrupt
                    case 44835:
                        {
                            // Deadly Interrupt Effect
                            triggered_spell_id = 32747;
                            break;
                        }
                    // Item - Druid T10 Restoration 4P Bonus (Rejuvenation)
                    case 70664:
                        {
                            // xinef: proc only from normal Rejuvenation, and proc rejuvenation
                            if (!victim || !procSpell || procSpell->SpellIconID != 64)
                                return false;

                            Player* caster = ToPlayer();
                            if (!caster)
                                return false;
                            if (!caster->GetGroup() && victim == this)
                                return false;

                            CastCustomSpell(70691, SPELLVALUE_BASE_POINT0, damage, victim, true);
                            return true;
                        }
                }
                // Eclipse
                if (dummySpell->SpellIconID == 2856 && GetTypeId() == TYPEID_PLAYER)
                {
                    if (!procSpell || effIndex != 0)
                        return false;

                    bool isWrathSpell = (procSpell->SpellFamilyFlags[0] & 1);

                    if (!roll_chance_f(dummySpell->ProcChance * (isWrathSpell ? 0.6f : 1.0f)))
                        return false;

                    target = this;
                    if (target->HasAura(isWrathSpell ? 48517 : 48518))
                        return false;

                    triggered_spell_id = isWrathSpell ? 48518 : 48517;
                    break;
                }
                [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
            }
        case SPELLFAMILY_ROGUE:
            {
                switch(dummySpell->Id)
                {
                    // Glyph of Backstab
                    case 56800:
                        {
                            if (victim)
                                if (AuraEffect* aurEff = victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_ROGUE, 0x100000, 0, 0, GetGUID()))
                                    if (Aura* aur = aurEff->GetBase())
                                        if (!aur->IsRemoved() && aur->GetDuration() > 0)
                                            if ((aur->GetApplyTime() + aur->GetMaxDuration() / 1000 + 5) > (GameTime::GetGameTime().count() + aur->GetDuration() / 1000) )
                                            {
                                                aur->SetDuration(aur->GetDuration() + 2000);
                                                return true;
                                            }
                            return false;
                        }
                    // Deadly Throw Interrupt
                    case 32748:
                        {
                            // Prevent cast Deadly Throw Interrupt on self from last effect (apply dummy) of Deadly Throw
                            if (this == victim)
                                return false;

                            triggered_spell_id = 32747;
                            break;
                        }
                }
                // Master of subtlety
                if( dummySpell->SpellIconID == 2114 )
                {
                    triggered_spell_id = 31665;
                    basepoints0 = triggerAmount;
                    break;
                }
                // Cut to the Chase
                if (dummySpell->SpellIconID == 2909)
                {
                    // "refresh your Slice and Dice duration to its 5 combo point maximum"
                    // lookup Slice and Dice
                    if (AuraEffect const* aur = GetAuraEffect(SPELL_AURA_MOD_MELEE_HASTE, SPELLFAMILY_ROGUE, 0x40000, 0, 0))
                    {
                        aur->GetBase()->SetDuration(aur->GetSpellInfo()->GetMaxDuration(), true);
                        return true;
                    }
                    return false;
                }
                // Deadly Brew
                else if (dummySpell->SpellIconID == 2963)
                {
                    triggered_spell_id = 3409;
                    break;
                }
                // Quick Recovery
                else if (dummySpell->SpellIconID == 2116)
                {
                    if (!procSpell)
                        return false;

                    // energy cost save
                    basepoints0 = CalculatePct(int32(procSpell->ManaCost), triggerAmount);
                    if (basepoints0 <= 0)
                        return false;

                    target = this;
                    triggered_spell_id = 31663;
                    break;
                }
                break;
            }
        case SPELLFAMILY_HUNTER:
            {
                switch (dummySpell->SpellIconID)
                {
                    case 2236: // Thrill of the Hunt
                        {
                            if (!procSpell)
                                return false;

                            Spell* spell = ToPlayer()->m_spellModTakingSpell;

                            // Disable charge drop because of Lock and Load
                            if (spell)
                                ToPlayer()->SetSpellModTakingSpell(spell, false);

                            // Explosive Shot
                            if (procSpell->SpellFamilyFlags[2] & 0x200)
                            {
                                if (!victim)
                                    return false;
                                if (AuraEffect const* pEff = victim->GetAuraEffect(SPELL_AURA_PERIODIC_DUMMY, SPELLFAMILY_HUNTER, 0x0, 0x80000000, 0x0, GetGUID()))
                                    basepoints0 = pEff->GetSpellInfo()->CalcPowerCost(this, SpellSchoolMask(pEff->GetSpellInfo()->SchoolMask)) * 4 / 10 / 3;
                            }
                            else
                                basepoints0 = procSpell->CalcPowerCost(this, SpellSchoolMask(procSpell->SchoolMask)) * 4 / 10;

                            if (spell)
                                ToPlayer()->SetSpellModTakingSpell(spell, true);

                            if (basepoints0 <= 0)
                                return false;

                            target = this;
                            triggered_spell_id = 34720;
                            break;
                        }
                    case 3406: // Hunting Party
                        {
                            triggered_spell_id = 57669;
                            target = this;
                            break;
                        }
                    case 3560: // Rapid Recuperation
                        {
                            // This effect only from Rapid Killing (mana regen)
                            if (!(procSpell->SpellFamilyFlags[1] & 0x01000000))
                                return false;

                            target = this;

                            switch (dummySpell->Id)
                            {
                                case 53228:                             // Rank 1
                                    triggered_spell_id = 56654;
                                    break;
                                case 53232:                             // Rank 2
                                    triggered_spell_id = 58882;
                                    break;
                            }
                            break;
                        }
                }

                switch (dummySpell->Id)
                {
                    case 57870: // Glyph of Mend Pet
                        {
                            if (!victim)
                                return false;

                            victim->CastSpell(victim, 57894, true, nullptr, nullptr, GetGUID());
                            return true;
                        }
                }
                break;
            }
        case SPELLFAMILY_PALADIN:
            {
                // Light's Beacon - Beacon of Light
                if (dummySpell->Id == 53651)
                {
                    if (!victim)
                        return false;

                    // Do not proc from Glyph of Holy Light and Judgement of Light
                    if (procSpell->Id == 20267 || procSpell->Id == 54968)
                    {
                        return false;
                    }

                    Unit* beaconTarget = triggeredByAura->GetBase()->GetCaster();
                    if (!beaconTarget || beaconTarget == this || !beaconTarget->GetAura(53563, victim->GetGUID()))
                        return false;

                    basepoints0 = int32(damage);
                    triggered_spell_id = procSpell->IsRankOf(sSpellMgr->GetSpellInfo(635)) ? 53652 : 53654;

                    victim->CastCustomSpell(beaconTarget, triggered_spell_id, &basepoints0, nullptr, nullptr, true, 0, triggeredByAura, victim->GetGUID());
                    return true;
                }
                // Judgements of the Wise
                if (dummySpell->SpellIconID == 3017)
                {
                    target = this;
                    triggered_spell_id = 31930;
                    // replenishment
                    CastSpell(this, 57669, true, castItem, triggeredByAura);
                    break;
                }
                // Righteous Vengeance
                if (dummySpell->SpellIconID == 3025)
                {
                    if (!victim)
                        return false;

                    // 4 damage tick
                    basepoints0 = triggerAmount * damage / 400;
                    triggered_spell_id = 61840;
                    // Add remaining ticks to damage done
                    victim->CastDelayedSpellWithPeriodicAmount(this, triggered_spell_id, SPELL_AURA_PERIODIC_DAMAGE, basepoints0);
                    return true;
                }
                // Sheath of Light
                if (dummySpell->SpellIconID == 3030)
                {
                    // 4 healing tick
                    basepoints0 = triggerAmount * damage / 400;
                    triggered_spell_id = 54203;
                    break;
                }
                switch (dummySpell->Id)
                {
                    // Judgement of Light
                    case 20185:
                        {
                            if (!victim || !victim->IsAlive() || victim->HasSpellCooldown(20267))
                                return false;
                            // 2% of base mana
                            basepoints0 = int32(victim->CountPctFromMaxHealth(2));
                            victim->CastCustomSpell(victim, 20267, &basepoints0, 0, 0, true, 0, triggeredByAura);
                            victim->AddSpellCooldown(20267, 0, 4 * IN_MILLISECONDS);
                            return true;
                        }
                    // Judgement of Wisdom
                    case 20186:
                        {
                            if (!victim || !victim->IsAlive() || !victim->HasActivePowerType(POWER_MANA) || victim->HasSpellCooldown(20268))
                                return false;

                            // 2% of base mana
                            basepoints0 = int32(CalculatePct(victim->GetCreateMana(), 2));
                            victim->CastCustomSpell(victim, 20268, &basepoints0, nullptr, nullptr, true, 0, triggeredByAura);
                            victim->AddSpellCooldown(20268, 0, 4 * IN_MILLISECONDS);
                            return true;
                        }
                    // Holy Power (Redemption Armor set)
                    case 28789:
                        {
                            if (!victim)
                                return false;

                            // Set class defined buff
                            switch (victim->getClass())
                            {
                                case CLASS_PALADIN:
                                case CLASS_PRIEST:
                                case CLASS_SHAMAN:
                                case CLASS_DRUID:
                                    triggered_spell_id = 28795;     // Increases the friendly target's mana regeneration by $s1 per 5 sec. for $d.
                                    break;
                                case CLASS_MAGE:
                                case CLASS_WARLOCK:
                                    triggered_spell_id = 28793;     // Increases the friendly target's spell damage and healing by up to $s1 for $d.
                                    break;
                                case CLASS_HUNTER:
                                case CLASS_ROGUE:
                                    triggered_spell_id = 28791;     // Increases the friendly target's attack power by $s1 for $d.
                                    break;
                                case CLASS_WARRIOR:
                                    triggered_spell_id = 28790;     // Increases the friendly target's armor
                                    break;
                                default:
                                    return false;
                            }
                            break;
                        }
                    // Seal of Vengeance (damage calc on apply aura)
                    case 31801:
                        {
                            if (effIndex != 0 || !victim)                       // effect 1, 2 used by seal unleashing code
                                return false;

                            // At melee attack or Hammer of the Righteous spell damage considered as melee attack
                            bool stacker = !procSpell || procSpell->Id == 53595;
                            // spells with SPELL_DAMAGE_CLASS_MELEE excluding Judgements
                            bool damager = procSpell && (procSpell->EquippedItemClass != -1 || (procSpell->SpellIconID == 243 && procSpell->SpellVisual[0] == 39));

                            if (!stacker && !damager)
                                return false;

                            triggered_spell_id = 31803;

                            if (Aura* aur = victim->GetAura(triggered_spell_id, GetGUID()))
                            {
                                if (aur->GetStackAmount() == 5)
                                {
                                    if (stacker)
                                        aur->RefreshDuration();
                                }
                            }

                            CastSpell(victim, 42463, true, castItem, triggeredByAura); // Seal of Vengeance

                            if (!stacker)
                                return false;
                            break;
                        }
                    // Seal of Corruption
                    case 53736:
                        {
                            if (effIndex != 0 || !victim)                       // effect 1, 2 used by seal unleashing code
                                return false;

                            // At melee attack or Hammer of the Righteous spell damage considered as melee attack
                            bool stacker = !procSpell || procSpell->Id == 53595;
                            // spells with SPELL_DAMAGE_CLASS_MELEE excluding Judgements
                            bool damager = procSpell && (procSpell->EquippedItemClass != -1 || (procSpell->SpellIconID == 243 && procSpell->SpellVisual[0] == 39));

                            if (!stacker && !damager)
                                return false;

                            triggered_spell_id = 53742;

                            if (Aura* aur = victim->GetAura(triggered_spell_id, GetGUID()))
                            {
                                if (aur->GetStackAmount() == 5)
                                {
                                    if (stacker)
                                        aur->RefreshDuration();
                                }
                            }

                            CastSpell(victim, 53739, true, castItem, triggeredByAura); // Seal of Corruption

                            if (!stacker)
                                return false;
                            break;
                        }
                    // Spiritual Attunement
                    case 31785:
                    case 33776:
                        {
                            // if healed by another unit (victim)
                            if (this == victim)
                                return false;

                            // dont allow non-positive dots to proc
                            if (!procSpell || !procSpell->IsPositive())
                                return false;

                            HealInfo const* healInfo = eventInfo.GetHealInfo();
                            if (!healInfo)
                            {
                                return false;
                            }

                            uint32 effectiveHeal = healInfo->GetEffectiveHeal();
                            if (effectiveHeal)
                            {
                                // heal amount
                                basepoints0 = int32(CalculatePct(effectiveHeal, triggerAmount));
                                target = this;

                                if (basepoints0)
                                    triggered_spell_id = 31786;
                            }
                            break;
                        }
                    // Paladin Tier 6 Trinket (Ashtongue Talisman of Zeal)
                    case 40470:
                        {
                            if (!procSpell)
                                return false;

                            float chance = 0.0f;

                            // Flash of light/Holy light
                            if (procSpell->SpellFamilyFlags[0] & 0xC0000000)
                            {
                                triggered_spell_id = 40471;
                                chance = 15.0f;
                            }
                            // Judgement (any)
                            else if (procSpell->SpellFamilyFlags[0] & 0x800000)
                            {
                                triggered_spell_id = 40472;
                                chance = 50.0f;
                            }
                            else
                                return false;

                            if (!roll_chance_f(chance))
                                return false;

                            break;
                        }
                    // Glyph of Holy Light
                    case 54937:
                        {
                            triggered_spell_id = 54968;
                            basepoints0 = CalculatePct(int32(damage), triggerAmount);
                            break;
                        }
                    // Item - Paladin T8 Holy 2P Bonus
                    case 64890:
                        {
                            triggered_spell_id = 64891;
                            basepoints0 = triggerAmount * damage / 300;
                            break;
                        }
                    case 71406: // Tiny Abomination in a Jar
                    case 71545: // Tiny Abomination in a Jar (Heroic)
                        {
                            if (!victim || !victim->IsAlive())
                                return false;

                            CastSpell(this, 71432, true, nullptr, triggeredByAura);

                            Aura const* dummy = GetAura(71432);
                            if (!dummy || dummy->GetStackAmount() < (dummySpell->Id == 71406 ? 8 : 7))
                                return false;

                            RemoveAurasDueToSpell(71432);
                            triggered_spell_id = 71433;  // default main hand attack
                            // roll if offhand
                            if (Player const* player = ToPlayer())
                                if (player->GetWeaponForAttack(OFF_ATTACK, true) && urand(0, 1))
                                    triggered_spell_id = 71434;
                            target = victim;
                            break;
                        }
                    // Item - Icecrown 25 Normal Dagger Proc
                    case 71880:
                        {
                            switch (getPowerType())
                            {
                                case POWER_MANA:
                                    triggered_spell_id = 71881;
                                    break;
                                case POWER_RAGE:
                                    triggered_spell_id = 71883;
                                    break;
                                case POWER_ENERGY:
                                    triggered_spell_id = 71882;
                                    break;
                                case POWER_RUNIC_POWER:
                                    triggered_spell_id = 71884;
                                    break;
                                default:
                                    return false;
                            }
                            break;
                        }
                    // Item - Icecrown 25 Heroic Dagger Proc
                    case 71892:
                        {
                            switch (getPowerType())
                            {
                                case POWER_MANA:
                                    triggered_spell_id = 71888;
                                    break;
                                case POWER_RAGE:
                                    triggered_spell_id = 71886;
                                    break;
                                case POWER_ENERGY:
                                    triggered_spell_id = 71887;
                                    break;
                                case POWER_RUNIC_POWER:
                                    triggered_spell_id = 71885;
                                    break;
                                default:
                                    return false;
                            }
                            break;
                        }
                }
                break;
            }
        case SPELLFAMILY_SHAMAN:
            {
                switch (dummySpell->Id)
                {
                    // Tidal Force
                    case 55198:
                        {
                            // Remove aura stack from  caster
                            RemoveAuraFromStack(55166);
                            // drop charges
                            return false;
                        }
                    // Totemic Power (The Earthshatterer set)
                    case 28823:
                        {
                            if (!victim)
                                return false;

                            // Set class defined buff
                            switch (victim->getClass())
                            {
                                case CLASS_PALADIN:
                                case CLASS_PRIEST:
                                case CLASS_SHAMAN:
                                case CLASS_DRUID:
                                    triggered_spell_id = 28824;     // Increases the friendly target's mana regeneration by $s1 per 5 sec. for $d.
                                    break;
                                case CLASS_MAGE:
                                case CLASS_WARLOCK:
                                    triggered_spell_id = 28825;     // Increases the friendly target's spell damage and healing by up to $s1 for $d.
                                    break;
                                case CLASS_HUNTER:
                                case CLASS_ROGUE:
                                    triggered_spell_id = 28826;     // Increases the friendly target's attack power by $s1 for $d.
                                    break;
                                case CLASS_WARRIOR:
                                    triggered_spell_id = 28827;     // Increases the friendly target's armor
                                    break;
                                default:
                                    return false;
                            }
                            break;
                        }
                    // Lesser Healing Wave (Totem of Flowing Water Relic)
                    case 28849:
                        {
                            target = this;
                            triggered_spell_id = 28850;
                            break;
                        }
                    // Windfury Weapon (Passive) 1-8 Ranks
                    case 33757:
                        {
                            Player* player = ToPlayer();
                            if (!player || !castItem || !castItem->IsEquipped() || !victim || !victim->IsAlive())
                                return false;

                            if (triggeredByAura->GetBase() && castItem->GetGUID() != triggeredByAura->GetBase()->GetCastItemGUID())
                                return false;

                            WeaponAttackType attType = WeaponAttackType(player->GetAttackBySlot(castItem->GetSlot()));
                            if ((attType != BASE_ATTACK && attType != OFF_ATTACK)
                                    || (attType == BASE_ATTACK && procFlag & PROC_FLAG_DONE_OFFHAND_ATTACK)
                                    || (attType == OFF_ATTACK && procFlag & PROC_FLAG_DONE_MAINHAND_ATTACK))
                                return false;

                            // Now amount of extra power stored in 1 effect of Enchant spell
                            // Get it by item enchant id
                            uint32 spellId;
                            switch (castItem->GetEnchantmentId(EnchantmentSlot(TEMP_ENCHANTMENT_SLOT)))
                            {
                                case 283:
                                    spellId =  8232;
                                    break;   // 1 Rank
                                case 284:
                                    spellId =  8235;
                                    break;   // 2 Rank
                                case 525:
                                    spellId = 10486;
                                    break;   // 3 Rank
                                case 1669:
                                    spellId = 16362;
                                    break;   // 4 Rank
                                case 2636:
                                    spellId = 25505;
                                    break;   // 5 Rank
                                case 3785:
                                    spellId = 58801;
                                    break;   // 6 Rank
                                case 3786:
                                    spellId = 58803;
                                    break;   // 7 Rank
                                case 3787:
                                    spellId = 58804;
                                    break;   // 8 Rank
                                default:
                                    {
                                        LOG_ERROR("entities.unit", "Unit::HandleDummyAuraProc: non handled item enchantment (rank?) {} for spell id: {} (Windfury)",
                                                       castItem->GetEnchantmentId(EnchantmentSlot(TEMP_ENCHANTMENT_SLOT)), dummySpell->Id);
                                        return false;
                                    }
                            }

                            SpellInfo const* windfurySpellInfo = sSpellMgr->GetSpellInfo(spellId);
                            if (!windfurySpellInfo)
                            {
                                LOG_ERROR("entities.unit", "Unit::HandleDummyAuraProc: non-existing spell id: {} (Windfury)", spellId);
                                return false;
                            }

                            int32 extra_attack_power = CalculateSpellDamage(victim, windfurySpellInfo, 1);

                            // Value gained from additional AP
                            basepoints0 = int32(extra_attack_power / 14.0f * GetAttackTime(attType) / 1000);

                            if (procFlag & PROC_FLAG_DONE_MAINHAND_ATTACK)
                                triggered_spell_id = 25504;

                            if (procFlag & PROC_FLAG_DONE_OFFHAND_ATTACK)
                                triggered_spell_id = 33750;

                            // custom cooldown processing case
                            if (player->HasSpellCooldown(dummySpell->Id))
                                return false;

                            // apply cooldown before cast to prevent processing itself
                            player->AddSpellCooldown(dummySpell->Id, 0, 3 * IN_MILLISECONDS);

                            // Attack Twice
                            for (uint32 i = 0; i < 2; ++i)
                                CastCustomSpell(victim, triggered_spell_id, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura);

                            return true;
                        }
                    // Shaman Tier 6 Trinket
                    case 40463:
                        {
                            if (!procSpell)
                                return false;

                            float chance;
                            if (procSpell->SpellFamilyFlags[0] & 0x1)
                            {
                                triggered_spell_id = 40465;         // Lightning Bolt
                                chance = 15.0f;
                            }
                            else if (procSpell->SpellFamilyFlags[0] & 0x80)
                            {
                                triggered_spell_id = 40465;         // Lesser Healing Wave
                                chance = 10.0f;
                            }
                            else if (procSpell->SpellFamilyFlags[1] & 0x00000010)
                            {
                                triggered_spell_id = 40466;         // Stormstrike
                                chance = 50.0f;
                            }
                            else
                                return false;

                            if (!roll_chance_f(chance))
                                return false;

                            target = this;
                            break;
                        }
                    // Glyph of Healing Wave
                    case 55440:
                        {
                            // Not proc from self heals
                            if (this == victim)
                                return false;
                            basepoints0 = CalculatePct(int32(damage), triggerAmount);
                            target = this;
                            triggered_spell_id = 55533;
                            break;
                        }
                    // Spirit Hunt
                    case 58877:
                        {
                            // Cast on owner
                            target = GetOwner();
                            if (!target)
                                return false;
                            basepoints0 = CalculatePct(int32(damage), triggerAmount);
                            triggered_spell_id = 58879;
                            // Heal wolf
                            CastCustomSpell(this, triggered_spell_id, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura, originalCaster);
                            break;
                        }
                    // Shaman T9 Elemental 4P Bonus
                    case 67228:
                        {
                            // Lava Burst
                            if (procSpell->SpellFamilyFlags[1] & 0x1000)
                            {
                                triggered_spell_id = 71824;
                                SpellInfo const* triggeredSpell = sSpellMgr->GetSpellInfo(triggered_spell_id);
                                if (!triggeredSpell)
                                    return false;
                                basepoints0 = CalculatePct(int32(damage), triggerAmount) / (triggeredSpell->GetMaxDuration() / triggeredSpell->Effects[0].Amplitude);
                            }
                            break;
                        }
                    // Item - Shaman T10 Elemental 4P Bonus
                    case 70817:
                        {
                            if (!target)
                                return false;
                            // try to find spell Flame Shock on the target
                            if (AuraEffect const* aurEff = target->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_SHAMAN, 0x10000000, 0x0, 0x0, GetGUID()))
                            {
                                Aura* flameShock  = aurEff->GetBase();
                                int32 extraTime = 2 * aurEff->GetAmplitude();
                                flameShock->SetMaxDuration(flameShock->GetMaxDuration() + extraTime);
                                flameShock->SetDuration(flameShock->GetDuration() + extraTime);

                                return true;
                            }
                            // if not found Flame Shock
                            return false;
                        }
                        break;
                }
                // Frozen Power
                if (dummySpell->SpellIconID == 3780)
                {
                    if (!target)
                        return false;
                    if (GetDistance(target) < 15.0f)
                        return false;
                    float chance = (float)triggerAmount;
                    if (!roll_chance_f(chance))
                        return false;

                    triggered_spell_id = 63685;
                    break;
                }
                // Ancestral Awakening
                if (dummySpell->SpellIconID == 3065)
                {
                    triggered_spell_id = 52759;
                    basepoints0 = CalculatePct(int32(damage), triggerAmount);
                    target = this;
                    break;
                }
                // Flametongue Weapon (Passive)
                if (dummySpell->SpellFamilyFlags[0] & 0x200000)
                {
                    if (GetTypeId() != TYPEID_PLAYER  || !victim || !victim->IsAlive() || !castItem || !castItem->IsEquipped())
                        return false;

                    WeaponAttackType attType = WeaponAttackType(Player::GetAttackBySlot(castItem->GetSlot()));
                    if ((attType != BASE_ATTACK && attType != OFF_ATTACK)
                            || (attType == BASE_ATTACK && procFlag & PROC_FLAG_DONE_OFFHAND_ATTACK)
                            || (attType == OFF_ATTACK && procFlag & PROC_FLAG_DONE_MAINHAND_ATTACK))
                        return false;

                    float fire_onhit = float(CalculatePct(dummySpell->Effects[EFFECT_0]. CalcValue(), 1.0f));

                    float add_spellpower = (float)(SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_FIRE)
                                                   + victim->SpellBaseDamageBonusTaken(SPELL_SCHOOL_MASK_FIRE));

                    // 1.3speed = 5%, 2.6speed = 10%, 4.0 speed = 15%, so, 1.0speed = 3.84%
                    ApplyPct(add_spellpower, 3.84f);

                    // Enchant on Off-Hand and ready?
                    if (castItem->GetSlot() == EQUIPMENT_SLOT_OFFHAND && procFlag & PROC_FLAG_DONE_OFFHAND_ATTACK)
                    {
                        float BaseWeaponSpeed = GetAttackTime(OFF_ATTACK) / 1000.0f;

                        // Value1: add the tooltip damage by swingspeed + Value2: add spelldmg by swingspeed
                        basepoints0 = int32((fire_onhit * BaseWeaponSpeed) + (add_spellpower * BaseWeaponSpeed));
                        triggered_spell_id = 10444;
                    }

                    // Enchant on Main-Hand and ready?
                    else if (castItem->GetSlot() == EQUIPMENT_SLOT_MAINHAND && procFlag & PROC_FLAG_DONE_MAINHAND_ATTACK)
                    {
                        float BaseWeaponSpeed = GetAttackTime(BASE_ATTACK) / 1000.0f;

                        // Value1: add the tooltip damage by swingspeed +  Value2: add spelldmg by swingspeed
                        basepoints0 = int32((fire_onhit * BaseWeaponSpeed) + (add_spellpower * BaseWeaponSpeed));
                        triggered_spell_id = 10444;
                    }

                    // If not ready, we should  return, shouldn't we?!
                    else
                        return false;

                    CastCustomSpell(victim, triggered_spell_id, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura);
                    return true;
                }
                // Improved Water Shield
                if (dummySpell->SpellIconID == 2287)
                {
                    if (!procSpell)
                        return false;

                    // Default chance for Healing Wave and Riptide
                    float chance = (float)triggeredByAura->GetAmount();

                    if (procSpell->SpellFamilyFlags[0] & 0x80)
                        // Lesser Healing Wave - 0.6 of default
                        chance *= 0.6f;
                    else if (procSpell->SpellFamilyFlags[0] & 0x100)
                        // Chain heal - 0.3 of default
                        chance *= 0.3f;

                    if (!roll_chance_f(chance))
                        return false;

                    // Water Shield
                    if (AuraEffect const* aurEff = GetAuraEffect(SPELL_AURA_PROC_TRIGGER_SPELL, SPELLFAMILY_SHAMAN, 0, 0x00000020, 0))
                    {
                        uint32 spell = aurEff->GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell;
                        CastSpell(this, spell, true, castItem, triggeredByAura);
                        return true;
                    }
                    return false;
                }
                // Lightning Overload
                if (dummySpell->SpellIconID == 2018)            // only this spell have SpellFamily Shaman SpellIconID == 2018 and dummy aura
                {
                    if(!procSpell || GetTypeId() != TYPEID_PLAYER || !victim)
                        return false;

                    if (procEx & PROC_EX_CRITICAL_HIT)
                        damage /= 2;

                    // do not proc off from itself
                    if (procSpell->Id == 45297 || procSpell->Id == 45284)
                    {
                        return false;
                    }

                    do
                    {
                        uint32 spell = 0;

                        if (procSpell->SpellFamilyFlags[0] & 0x2)
                        {
                            // 1/3 of 33% if 11%
                            if (!roll_chance_i(33))
                                return false;

                            spell = 45297;
                        }
                        else
                            spell = 45284;

                        // do not reduce damage-spells have correct basepoints
                        damage /= 2;
                        int32 dmg = damage;

                        // Cast
                        CastCustomSpell(victim, spell, &dmg, 0, 0, true, castItem, triggeredByAura);
                    } while (roll_chance_i(33));
                    return true;
                }
                // Static Shock
                if (dummySpell->SpellIconID == 3059)
                {
                    // Lightning Shield
                    if (AuraEffect const* aurEff = GetAuraEffect(SPELL_AURA_PROC_TRIGGER_SPELL, SPELLFAMILY_SHAMAN, 0x400, 0, 0))
                    {
                        uint32 spell = sSpellMgr->GetSpellWithRank(26364, aurEff->GetSpellInfo()->GetRank());
                        CastSpell(target, spell, true, castItem, triggeredByAura);
                        aurEff->GetBase()->DropCharge();
                        return true;
                    }
                    return false;
                }
                break;
            }
        case SPELLFAMILY_DEATHKNIGHT:
            {
                // Improved Blood Presence
                if (dummySpell->SpellIconID == 2636)
                {
                    if (GetTypeId() != TYPEID_PLAYER)
                        return false;
                    basepoints0 = CalculatePct(int32(damage), triggerAmount);
                    break;
                }
                // Butchery
                if (dummySpell->SpellIconID == 2664)
                {
                    basepoints0 = triggerAmount;
                    triggered_spell_id = 50163;
                    target = this;
                    break;
                }
                // Mark of Blood
                if (dummySpell->Id == 49005)
                {
                    /// @todo: need more info (cooldowns/PPM)
                    triggered_spell_id = 61607;
                    break;
                }
                // Unholy Blight
                if (dummySpell->Id == 49194)
                {
                    triggered_spell_id = 50536;
                    SpellInfo const* unholyBlight = sSpellMgr->GetSpellInfo(triggered_spell_id);
                    if (!unholyBlight || !victim)
                        return false;

                    basepoints0 = CalculatePct(int32(damage), triggerAmount);

                    //Glyph of Unholy Blight
                    if (AuraEffect* glyph = GetAuraEffect(63332, 0))
                        AddPct(basepoints0, glyph->GetAmount());

                    basepoints0 = basepoints0 / (unholyBlight->GetMaxDuration() / unholyBlight->Effects[0].Amplitude);
                    victim->CastDelayedSpellWithPeriodicAmount(this, triggered_spell_id, SPELL_AURA_PERIODIC_DAMAGE, basepoints0);
                    return true;
                }
                // Vendetta
                if (dummySpell->SpellFamilyFlags[0] & 0x10000)
                {
                    basepoints0 = int32(CountPctFromMaxHealth(triggerAmount));
                    triggered_spell_id = 50181;
                    target = this;
                    break;
                }
                // Necrosis
                if (dummySpell->SpellIconID == 2709)
                {
                    basepoints0 = CalculatePct(int32(damage), triggerAmount);
                    triggered_spell_id = 51460;
                    break;
                }
                // Threat of Thassarian
                if (dummySpell->SpellIconID == 2023)
                {
                    // Must Dual Wield
                    if (!procSpell || !haveOffhandWeapon())
                        return false;
                    // Chance as basepoints for dummy aura
                    if (!roll_chance_i(triggerAmount))
                        return false;

                    switch (procSpell->Id)
                    {
                        // Obliterate
                        case 49020:
                            triggered_spell_id = 66198;
                            break;                            // Rank 1
                        case 51423:
                            triggered_spell_id = 66972;
                            break;                            // Rank 2
                        case 51424:
                            triggered_spell_id = 66973;
                            break;                            // Rank 3
                        case 51425:
                            triggered_spell_id = 66974;
                            break;                            // Rank 4

                        // Frost Strike
                        case 49143:
                            triggered_spell_id = 66196;
                            break;                            // Rank 1
                        case 51416:
                            triggered_spell_id = 66958;
                            break;                            // Rank 2
                        case 51417:
                            triggered_spell_id = 66959;
                            break;                            // Rank 3
                        case 51418:
                            triggered_spell_id = 66960;
                            break;                            // Rank 4
                        case 51419:
                            triggered_spell_id = 66961;
                            break;                            // Rank 5
                        case 55268:
                            triggered_spell_id = 66962;
                            break;                            // Rank 6

                        // Plague Strike
                        case 45462:
                            triggered_spell_id = 66216;
                            break;                            // Rank 1
                        case 49917:
                            triggered_spell_id = 66988;
                            break;                            // Rank 2
                        case 49918:
                            triggered_spell_id = 66989;
                            break;                            // Rank 3
                        case 49919:
                            triggered_spell_id = 66990;
                            break;                            // Rank 4
                        case 49920:
                            triggered_spell_id = 66991;
                            break;                            // Rank 5
                        case 49921:
                            triggered_spell_id = 66992;
                            break;                            // Rank 6

                        // Death Strike
                        case 49998:
                            triggered_spell_id = 66188;
                            break;                            // Rank 1
                        case 49999:
                            triggered_spell_id = 66950;
                            break;                            // Rank 2
                        case 45463:
                            triggered_spell_id = 66951;
                            break;                            // Rank 3
                        case 49923:
                            triggered_spell_id = 66952;
                            break;                            // Rank 4
                        case 49924:
                            triggered_spell_id = 66953;
                            break;                            // Rank 5

                        // Rune Strike
                        case 56815:
                            triggered_spell_id = 66217;
                            break;                            // Rank 1

                        // Blood Strike
                        case 45902:
                            triggered_spell_id = 66215;
                            break;                            // Rank 1
                        case 49926:
                            triggered_spell_id = 66975;
                            break;                            // Rank 2
                        case 49927:
                            triggered_spell_id = 66976;
                            break;                            // Rank 3
                        case 49928:
                            triggered_spell_id = 66977;
                            break;                            // Rank 4
                        case 49929:
                            triggered_spell_id = 66978;
                            break;                            // Rank 5
                        case 49930:
                            triggered_spell_id = 66979;
                            break;                            // Rank 6
                        default:
                            return false;
                    }

                    // This should do, restore spell mod so next attack can also use this!
                    // crit chance for first strike is already computed
                    ToPlayer()->RestoreSpellMods(m_currentSpells[CURRENT_GENERIC_SPELL], 51124, nullptr); // Killing Machine
                    ToPlayer()->RestoreSpellMods(m_currentSpells[CURRENT_GENERIC_SPELL], 49796, nullptr); // Deathchill

                    // Xinef: Somehow basepoints are divided by 2 which is later divided by 2 (offhand multiplier)
                    SpellInfo const* triggerEntry = sSpellMgr->GetSpellInfo(triggered_spell_id);
                    if (triggerEntry->SchoolMask & SPELL_SCHOOL_MASK_NORMAL)
                        basepoints0 = triggerEntry->Effects[EFFECT_0].BasePoints * 2;

                    SetCantProc(true);
                    if(basepoints0)
                        CastCustomSpell(target, triggered_spell_id, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura, originalCaster);
                    else
                        CastSpell(target, triggered_spell_id, true, castItem, triggeredByAura, originalCaster);
                    SetCantProc(false);
                    return true;
                }
                // Runic Power Back on Snare/Root
                if (dummySpell->Id == 61257)
                {
                    // only for spells and hit/crit (trigger start always) and not start from self casted spells
                    if (procSpell == 0 || !(procEx & (PROC_EX_NORMAL_HIT | PROC_EX_CRITICAL_HIT)) || this == victim)
                        return false;
                    // Need snare or root mechanic
                    if (!(procSpell->GetAllEffectsMechanicMask() & ((1 << MECHANIC_ROOT) | (1 << MECHANIC_SNARE))))
                        return false;
                    triggered_spell_id = 61258;
                    target = this;
                    break;
                }
                // Sudden Doom
                if (dummySpell->SpellIconID == 1939 && GetTypeId() == TYPEID_PLAYER)
                {
                    SpellChainNode const* chain = nullptr;
                    // get highest rank of the Death Coil spell
                    PlayerSpellMap const& sp_list = ToPlayer()->GetSpellMap();
                    for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
                    {
                        // check if shown in spell book
                        if (!itr->second->Active || !itr->second->IsInSpec(ToPlayer()->GetActiveSpec()) || itr->second->State == PLAYERSPELL_REMOVED)
                            continue;

                        SpellInfo const* spellProto = sSpellMgr->GetSpellInfo(itr->first);
                        if (!spellProto)
                            continue;

                        if (spellProto->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT
                                && spellProto->SpellFamilyFlags[0] & 0x2000)
                        {
                            SpellChainNode const* newChain = sSpellMgr->GetSpellChainNode(itr->first);

                            // No chain entry or entry lower than found entry
                            if (!chain || !newChain || (chain->rank < newChain->rank))
                            {
                                triggered_spell_id = itr->first;
                                chain = newChain;
                            }
                            else
                                continue;
                            // Found spell is last in chain - do not need to look more
                            // Optimisation for most common case
                            if (chain && chain->last->Id == itr->first)
                                break;
                        }
                    }
                }
                break;
            }
        case SPELLFAMILY_POTION:
            {
                // alchemist's stone
                if (dummySpell->Id == 17619)
                {
                    if (procSpell->SpellFamilyName == SPELLFAMILY_POTION)
                    {
                        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; i++)
                        {
                            if (procSpell->Effects[i].Effect == SPELL_EFFECT_HEAL)
                            {
                                triggered_spell_id = 21399;
                            }
                            else if (procSpell->Effects[i].Effect == SPELL_EFFECT_ENERGIZE)
                            {
                                triggered_spell_id = 21400;
                            }
                            else
                                continue;

                            basepoints0 = int32(CalculateSpellDamage(this, procSpell, i) * 0.4f);
                            CastCustomSpell(this, triggered_spell_id, &basepoints0, nullptr, nullptr, true, nullptr, triggeredByAura);
                        }
                        return true;
                    }
                }
                break;
            }
        case SPELLFAMILY_PET:
            {
                switch (dummySpell->SpellIconID)
                {
                    // Guard Dog
                    case 201:
                        {
                            if (!victim)
                                return false;

                            triggered_spell_id = 54445;
                            target = this;
                            float addThreat = float(CalculatePct(procSpell->Effects[0].CalcValue(this), triggerAmount));
                            victim->AddThreat(this, addThreat);
                            break;
                        }
                    // Silverback
                    case 1582:
                        triggered_spell_id = dummySpell->Id == 62765 ? 62801 : 62800;
                        target = this;
                        break;
                }
                break;
            }
        default:
            break;
    }

    // if not handled by custom case, get triggered spell from dummySpell proto
    if (!triggered_spell_id)
        triggered_spell_id = dummySpell->Effects[triggeredByAura->GetEffIndex()].TriggerSpell;

    // processed charge only counting case
    if (!triggered_spell_id)
        return true;

    SpellInfo const* triggerEntry = sSpellMgr->GetSpellInfo(triggered_spell_id);
    if (!triggerEntry)
    {
        LOG_ERROR("entities.unit", "Unit::HandleDummyAuraProc: Spell {} has non-existing triggered spell {}", dummySpell->Id, triggered_spell_id);
        return false;
    }

    if (cooldown_spell_id == 0)
        cooldown_spell_id = triggered_spell_id;

    if (cooldown)
    {
        if (HasSpellCooldown(cooldown_spell_id))
            return false;

        AddSpellCooldown(cooldown_spell_id, 0, cooldown);
    }

    if(basepoints0)
        CastCustomSpell(target, triggered_spell_id, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura, originalCaster);
    else
        CastSpell(target, triggered_spell_id, true, castItem, triggeredByAura, originalCaster);

    return true;
}

// Used in case when access to whole aura is needed
// All procs should be handled like this...
bool Unit::HandleAuraProc(Unit* victim, uint32 damage, Aura* triggeredByAura, SpellInfo const*  /*procSpell*/, uint32 /*procFlag*/, uint32 procEx, uint32 cooldown, bool* handled)
{
    SpellInfo const* dummySpell = triggeredByAura->GetSpellInfo();

    switch (dummySpell->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            switch (dummySpell->Id)
            {
                // Nevermelting Ice Crystal
                case 71564:
                    RemoveAuraFromStack(71564);
                    *handled = true;
                    break;
                // Gaseous Bloat
                case 70672:
                case 72455:
                case 72832:
                case 72833:
                    {
                        if (Unit* caster = triggeredByAura->GetCaster())
                            if (victim && caster->GetGUID() == victim->GetGUID())
                            {
                                *handled = true;
                                uint32 stack = triggeredByAura->GetStackAmount();
                                int32 const mod = (GetMap()->GetSpawnMode() & 1) ? 1500 : 1250;
                                int32 dmg = 0;
                                for (uint8 i = 1; i <= stack; ++i)
                                    dmg += mod * i;
                                caster->CastCustomSpell(70701, SPELLVALUE_BASE_POINT0, dmg);
                            }
                        break;
                    }
                // Ball of Flames Proc
                case 71756:
                case 72782:
                case 72783:
                case 72784:
                    RemoveAuraFromStack(dummySpell->Id);
                    *handled = true;
                    break;
                // Discerning Eye of the Beast
                case 59915:
                    {
                        CastSpell(this, 59914, true);   // 59914 already has correct basepoints in DBC, no need for custom bp
                        *handled = true;
                        break;
                    }
                // Swift Hand of Justice
                case 59906:
                    {
                        int32 bp0 = CalculatePct(GetMaxHealth(), dummySpell->Effects[EFFECT_0]. CalcValue());
                        CastCustomSpell(this, 59913, &bp0, nullptr, nullptr, true);
                        *handled = true;
                        break;
                    }
            }

            break;
        case SPELLFAMILY_MAGE:
            {
                // Combustion
                switch (dummySpell->Id)
                {
                    case 11129:
                        {
                            *handled = true;
                            Unit* caster = triggeredByAura->GetCaster();
                            if (!caster || !damage)
                                return false;

                            // last charge and crit
                            if (triggeredByAura->GetCharges() <= 1 && (procEx & PROC_EX_CRITICAL_HIT))
                                return true;                        // charge counting (will removed)

                            CastSpell(this, 28682, true);

                            return procEx & PROC_EX_CRITICAL_HIT;
                        }
                    // Empowered Fire
                    case 31656:
                    case 31657:
                    case 31658:
                        {
                            *handled = true;

                            SpellInfo const* spInfo = sSpellMgr->GetSpellInfo(67545);
                            if (!spInfo)
                                return false;

                            int32 bp0 = int32(CalculatePct(GetMaxPower(POWER_MANA), spInfo->Effects[0].CalcValue()));
                            CastCustomSpell(this, 67545, &bp0, nullptr, nullptr, true, nullptr, triggeredByAura->GetEffect(EFFECT_0), GetGUID());
                            return true;
                        }
                }
                break;
            }
        case SPELLFAMILY_DEATHKNIGHT:
            {
                // Blood of the North
                // Reaping
                // Death Rune Mastery
                // xinef: Icon 22 is used for item bonus, skip
                if (dummySpell->SpellIconID == 3041 || (dummySpell->SpellIconID == 22 && dummySpell->Id != 62459) || dummySpell->SpellIconID == 2622)
                {
                    *handled = true;
                    // Convert recently used Blood Rune to Death Rune
                    if (Player* player = ToPlayer())
                    {
                        if (!player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
                            return false;

                        // xinef: not true
                        //RuneType rune = ToPlayer()->GetLastUsedRune();
                        // can't proc from death rune use
                        //if (rune == RUNE_DEATH)
                        //    return false;
                        AuraEffect* aurEff = triggeredByAura->GetEffect(EFFECT_0);
                        if (!aurEff)
                            return false;

                        // Reset amplitude - set death rune remove timer to 30s
                        aurEff->ResetPeriodic(true);
                        uint32 runesLeft;

                        if (dummySpell->SpellIconID == 2622)
                            runesLeft = 2;
                        else
                            runesLeft = 1;

                        for (uint8 i = 0; i < MAX_RUNES && runesLeft; ++i)
                        {
                            if (dummySpell->SpellIconID == 2622)
                            {
                                if (player->GetCurrentRune(i) == RUNE_DEATH ||
                                        player->GetBaseRune(i) == RUNE_BLOOD)
                                    continue;
                            }
                            else
                            {
                                if (player->GetCurrentRune(i) == RUNE_DEATH ||
                                        player->GetBaseRune(i) != RUNE_BLOOD)
                                    continue;
                            }
                            if (player->GetRuneCooldown(i) != player->GetRuneBaseCooldown(i, false))
                                continue;

                            --runesLeft;
                            // Mark aura as used
                            player->AddRuneByAuraEffect(i, RUNE_DEATH, aurEff);
                        }
                        return true;
                    }
                    return false;
                }
                break;
            }
        case SPELLFAMILY_WARRIOR:
            {
                switch (dummySpell->Id)
                {
                    // Item - Warrior T10 Protection 4P Bonus
                    case 70844:
                        {
                            int32 basepoints0 = CalculatePct(GetMaxHealth(), dummySpell->Effects[EFFECT_1]. CalcValue());
                            CastCustomSpell(this, 70845, &basepoints0, nullptr, nullptr, true);
                            break;
                        }
                    default:
                        break;
                }
                break;
            }
        case SPELLFAMILY_SHAMAN:
        {
            // Flurry
            if ((dummySpell->SpellFamilyFlags[1] & 0x00000200) != 0)
            {
                if (cooldown)
                {
                    if (HasSpellCooldown(dummySpell->Id))
                    {
                        *handled = true;
                        break;
                    }

                    AddSpellCooldown(dummySpell->Id, 0, cooldown);
                }
            }
            break;
        }
    }
    return false;
}

bool Unit::HandleProcTriggerSpell(Unit* victim, uint32 damage, AuraEffect* triggeredByAura, SpellInfo const* procSpell, uint32 procFlags, uint32 procEx, uint32 cooldown, uint32 procPhase, ProcEventInfo& eventInfo)
{
    // Get triggered aura spell info
    SpellInfo const* auraSpellInfo = triggeredByAura->GetSpellInfo();

    // Basepoints of trigger aura
    int32 triggerAmount = triggeredByAura->GetAmount();

    // Set trigger spell id, target, custom basepoints
    uint32 trigger_spell_id = auraSpellInfo->Effects[triggeredByAura->GetEffIndex()].TriggerSpell;

    Unit*  target = nullptr;
    int32  basepoints0 = 0;

    if (triggeredByAura->GetAuraType() == SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE)
        basepoints0 = triggerAmount;

    Item* castItem = triggeredByAura->GetBase()->GetCastItemGUID() && GetTypeId() == TYPEID_PLAYER
                     ? ToPlayer()->GetItemByGuid(triggeredByAura->GetBase()->GetCastItemGUID()) : nullptr;

    // Try handle unknown trigger spells
    //if (sSpellMgr->GetSpellInfo(trigger_spell_id) == nullptr)
    {
        switch (auraSpellInfo->SpellFamilyName)
        {
            case SPELLFAMILY_GENERIC:
                switch (auraSpellInfo->Id)
                {
                    case 43820:             // Charm of the Witch Doctor (Amani Charm of the Witch Doctor trinket)
                        // Pct value stored in dummy
                        if (!victim)
                            return false;
                        basepoints0 = victim->GetCreateHealth() * auraSpellInfo->Effects[1].CalcValue() / 100;
                        target = victim;
                        break;
                    case 57345:             // Darkmoon Card: Greatness
                        {
                            float stat = 0.0f;
                            // strength
                            if (GetStat(STAT_STRENGTH) > stat) { trigger_spell_id = 60229; stat = GetStat(STAT_STRENGTH); }
                            // agility
                            if (GetStat(STAT_AGILITY)  > stat) { trigger_spell_id = 60233; stat = GetStat(STAT_AGILITY);  }
                            // intellect
                            if (GetStat(STAT_INTELLECT) > stat) { trigger_spell_id = 60234; stat = GetStat(STAT_INTELLECT);}
                            // spirit
                            if (GetStat(STAT_SPIRIT)   > stat) { trigger_spell_id = 60235;                               }
                            break;
                        }
                    case 67702:             // Death's Choice, Item - Coliseum 25 Normal Melee Trinket
                        {
                            if (!damage)
                                return false;
                            float stat = 0.0f;
                            // strength
                            if (GetStat(STAT_STRENGTH) > stat) { trigger_spell_id = 67708; stat = GetStat(STAT_STRENGTH); }
                            // agility
                            if (GetStat(STAT_AGILITY)  > stat) { trigger_spell_id = 67703;                               }
                            break;
                        }
                    case 67771:             // Death's Choice (heroic), Item - Coliseum 25 Heroic Melee Trinket
                        {
                            if (!damage)
                                return false;
                            float stat = 0.0f;
                            // strength
                            if (GetStat(STAT_STRENGTH) > stat) { trigger_spell_id = 67773; stat = GetStat(STAT_STRENGTH); }
                            // agility
                            if (GetStat(STAT_AGILITY)  > stat) { trigger_spell_id = 67772;                               }
                            break;
                        }
                    // Mana Drain Trigger
                    case 27522:
                    case 40336:
                        {
                            // On successful melee or ranged attack gain $29471s1 mana and if possible drain $27526s1 mana from the target.
                            if (IsAlive())
                                CastSpell(this, 29471, true, castItem, triggeredByAura);
                            if (victim && victim->IsAlive())
                                CastSpell(victim, 27526, true, castItem, triggeredByAura);
                            return true;
                        }
                    // Forge of Souls, Devourer of Souls, Mirrored Soul
                    case 69023:
                        {
                            int32 dmg = damage * 0.45f;
                            if (dmg > 0)
                                if (Aura* a = GetAura(69023))
                                    if (Unit* c = a->GetCaster())
                                        CastCustomSpell(c, 69034, &dmg, 0, 0, true);
                            return true;
                        }
                    // Soul-Trader Beacon proc aura
                    case 50051:
                        {
                            if (!victim)
                                return false;

                            if (Creature* cr = ObjectAccessor::GetCreature(*this, m_SummonSlot[SUMMON_SLOT_MINIPET]))
                                cr->CastSpell(victim, 50101, true);

                            return false;
                        }
                }
                break;
            case SPELLFAMILY_MAGE:
                if (auraSpellInfo->SpellIconID == 2127)     // Blazing Speed
                {
                    switch (auraSpellInfo->Id)
                    {
                        case 31641:  // Rank 1
                        case 31642:  // Rank 2
                            trigger_spell_id = 31643;
                            break;
                        default:
                            LOG_ERROR("entities.unit", "Unit::HandleProcTriggerSpell: Spell {} miss posibly Blazing Speed", auraSpellInfo->Id);
                            return false;
                    }
                }
                else if (auraSpellInfo->Id == 71761) // Deep Freeze Immunity State (only permanent)
                {
                    Creature* creature = victim->ToCreature();
                    if (!creature || !creature->HasMechanicTemplateImmunity(1 << (MECHANIC_STUN - 1)))
                        return false;
                }
                break;
            case SPELLFAMILY_WARLOCK:
                {
                    // Nether Protection
                    if (auraSpellInfo->SpellIconID == 1985)
                    {
                        if (!procSpell)
                            return false;
                        switch (GetFirstSchoolInMask(procSpell->GetSchoolMask()))
                        {
                            case SPELL_SCHOOL_NORMAL:
                                return false;                   // ignore
                            case SPELL_SCHOOL_HOLY:
                                trigger_spell_id = 54370;
                                break;
                            case SPELL_SCHOOL_FIRE:
                                trigger_spell_id = 54371;
                                break;
                            case SPELL_SCHOOL_NATURE:
                                trigger_spell_id = 54375;
                                break;
                            case SPELL_SCHOOL_FROST:
                                trigger_spell_id = 54372;
                                break;
                            case SPELL_SCHOOL_SHADOW:
                                trigger_spell_id = 54374;
                                break;
                            case SPELL_SCHOOL_ARCANE:
                                trigger_spell_id = 54373;
                                break;
                            default:
                                return false;
                        }
                    }
                    break;
                }
            case SPELLFAMILY_PRIEST:
                {
                    // Blessed Recovery
                    if (auraSpellInfo->SpellIconID == 1875)
                    {
                        switch (auraSpellInfo->Id)
                        {
                            case 27811:
                                trigger_spell_id = 27813;
                                break;
                            case 27815:
                                trigger_spell_id = 27817;
                                break;
                            case 27816:
                                trigger_spell_id = 27818;
                                break;
                            default:
                                LOG_ERROR("entities.unit", "Unit::HandleProcTriggerSpell: Spell {} not handled in BR", auraSpellInfo->Id);
                                return false;
                        }
                        basepoints0 = CalculatePct(int32(damage), triggerAmount) / 3;
                        target = this;
                        // Add remaining ticks to healing done
                        CastDelayedSpellWithPeriodicAmount(this, trigger_spell_id, SPELL_AURA_PERIODIC_HEAL, basepoints0);
                        return true;
                    }
                    break;
                }
            case SPELLFAMILY_DRUID:
                {
                    switch (auraSpellInfo->Id)
                    {
                        // Druid Forms Trinket
                        case 37336:
                            {
                                switch (GetShapeshiftForm())
                                {
                                    case FORM_NONE:
                                        trigger_spell_id = 37344;
                                        break;
                                    case FORM_CAT:
                                        trigger_spell_id = 37341;
                                        break;
                                    case FORM_BEAR:
                                    case FORM_DIREBEAR:
                                        trigger_spell_id = 37340;
                                        break;
                                    case FORM_TREE:
                                        trigger_spell_id = 37342;
                                        break;
                                    case FORM_MOONKIN:
                                        trigger_spell_id = 37343;
                                        break;
                                    default:
                                        return false;
                                }
                                break;
                            }
                        // Druid T9 Feral Relic (Lacerate, Swipe, Mangle, and Shred)
                        case 67353:
                            {
                                switch (GetShapeshiftForm())
                                {
                                    case FORM_CAT:
                                        trigger_spell_id = 67355;
                                        break;
                                    case FORM_BEAR:
                                    case FORM_DIREBEAR:
                                        trigger_spell_id = 67354;
                                        break;
                                    default:
                                        return false;
                                }
                                break;
                            }
                        default:
                            break;
                    }
                    break;
                }
            case SPELLFAMILY_HUNTER:
                {
                    if (auraSpellInfo->SpellIconID == 3247)     // Piercing Shots
                    {
                        if (!victim)
                            return false;

                        switch (auraSpellInfo->Id)
                        {
                            case 53234:  // Rank 1
                            case 53237:  // Rank 2
                            case 53238:  // Rank 3
                                trigger_spell_id = 63468;
                                break;
                            default:
                                LOG_ERROR("entities.unit", "Unit::HandleProcTriggerSpell: Spell {} miss posibly Piercing Shots", auraSpellInfo->Id);
                                return false;
                        }
                        SpellInfo const* TriggerPS = sSpellMgr->GetSpellInfo(trigger_spell_id);
                        if (!TriggerPS)
                            return false;

                        basepoints0 = CalculatePct(int32(damage), triggerAmount) / (TriggerPS->GetMaxDuration() / TriggerPS->Effects[0].Amplitude);
                        victim->CastDelayedSpellWithPeriodicAmount(this, trigger_spell_id, SPELL_AURA_PERIODIC_DAMAGE, basepoints0);
                        return true;
                    }
                    // Item - Hunter T9 4P Bonus (Steady Shot)
                    else if (auraSpellInfo->Id == 67151)
                    {
                        if (GetTypeId() != TYPEID_PLAYER || !ToPlayer()->GetPet())
                            return false;

                        target = ToPlayer()->GetPet();
                        trigger_spell_id = 68130;
                        break;
                    }
                    break;
                }
            case SPELLFAMILY_PALADIN:
                {
                    switch (auraSpellInfo->Id)
                    {
                        // Soul Preserver
                        case 60510:
                            {
                                switch (getClass())
                                {
                                    case CLASS_DRUID:
                                        trigger_spell_id = 60512;
                                        break;
                                    case CLASS_PALADIN:
                                        trigger_spell_id = 60513;
                                        break;
                                    case CLASS_PRIEST:
                                        trigger_spell_id = 60514;
                                        break;
                                    case CLASS_SHAMAN:
                                        trigger_spell_id = 60515;
                                        break;
                                }

                                target = this;
                                break;
                            }
                        case 37657: // Lightning Capacitor
                        case 54841: // Thunder Capacitor
                        case 67712: // Item - Coliseum 25 Normal Caster Trinket
                        case 67758: // Item - Coliseum 25 Heroic Caster Trinket
                            {
                                if (!victim || !victim->IsAlive() || GetTypeId() != TYPEID_PLAYER)
                                    return false;

                                uint32 stack_spell_id = 0;
                                switch (auraSpellInfo->Id)
                                {
                                    case 37657:
                                        stack_spell_id = 37658;
                                        trigger_spell_id = 37661;
                                        break;
                                    case 54841:
                                        stack_spell_id = 54842;
                                        trigger_spell_id = 54843;
                                        break;
                                    case 67712:
                                        stack_spell_id = 67713;
                                        trigger_spell_id = 67714;
                                        break;
                                    case 67758:
                                        stack_spell_id = 67759;
                                        trigger_spell_id = 67760;
                                        break;
                                }

                                if (cooldown && ToPlayer()->HasSpellCooldown(stack_spell_id))
                                {
                                    return false;
                                }

                                CastSpell(this, stack_spell_id, true, nullptr, triggeredByAura);

                                Aura* dummy = GetAura(stack_spell_id);
                                if (!dummy || dummy->GetStackAmount() < triggerAmount)
                                {
                                    return false;
                                }

                                if (cooldown)
                                {
                                    ToPlayer()->AddSpellCooldown(stack_spell_id, 0, cooldown);
                                }
                                RemoveAurasDueToSpell(stack_spell_id);
                                CastSpell(victim, trigger_spell_id, true, nullptr, triggeredByAura);
                                return true;
                            }
                        default:
                            // Illumination
                            if (auraSpellInfo->SpellIconID == 241)
                            {
                                if (!procSpell)
                                    return false;
                                // procspell is triggered spell but we need mana cost of original casted spell
                                uint32 originalSpellId = procSpell->Id;
                                // Holy Shock heal
                                if (procSpell->SpellFamilyFlags[1] & 0x00010000)
                                {
                                    switch (procSpell->Id)
                                    {
                                        case 25914:
                                            originalSpellId = 20473;
                                            break;
                                        case 25913:
                                            originalSpellId = 20929;
                                            break;
                                        case 25903:
                                            originalSpellId = 20930;
                                            break;
                                        case 27175:
                                            originalSpellId = 27174;
                                            break;
                                        case 33074:
                                            originalSpellId = 33072;
                                            break;
                                        case 48820:
                                            originalSpellId = 48824;
                                            break;
                                        case 48821:
                                            originalSpellId = 48825;
                                            break;
                                        default:
                                            LOG_ERROR("entities.unit", "Unit::HandleProcTriggerSpell: Spell {} not handled in HShock", procSpell->Id);
                                            return false;
                                    }
                                }
                                SpellInfo const* originalSpell = sSpellMgr->GetSpellInfo(originalSpellId);
                                if (!originalSpell)
                                {
                                    LOG_ERROR("entities.unit", "Unit::HandleProcTriggerSpell: Spell {} unknown but selected as original in Illu", originalSpellId);
                                    return false;
                                }
                                // percent stored in effect 1 (class scripts) base points
                                int32 cost = int32(originalSpell->ManaCost + CalculatePct(GetCreateMana(), originalSpell->ManaCostPercentage));
                                basepoints0 = CalculatePct(cost, auraSpellInfo->Effects[1].CalcValue());
                                trigger_spell_id = 20272;
                                target = this;
                            }
                            break;
                    }
                    break;
                }
            case SPELLFAMILY_SHAMAN:
                {
                    // Lightning Shield (overwrite non existing triggered spell call in spell.dbc
                    if (auraSpellInfo->SpellFamilyFlags[0] & 0x400 && auraSpellInfo->HasAttribute(SPELL_ATTR1_NO_THREAT))
                    {
                        // Do not proc off from self-casted items
                        if (Spell const* spell = eventInfo.GetProcSpell())
                        {
                            if (spell->m_castItemGUID && victim->GetGUID() == GetGUID())
                            {
                                return false;
                            }
                        }

                        trigger_spell_id = sSpellMgr->GetSpellWithRank(26364, auraSpellInfo->GetRank());
                    }
                    // Nature's Guardian
                    else if (auraSpellInfo->SpellIconID == 2013)
                    {
                        // Check health condition - should drop to less 30% (damage deal after this!)
                        if (!HealthBelowPctDamaged(30, damage))
                            return false;

                        if (victim && victim->IsAlive())
                            victim->GetThreatMgr().ModifyThreatByPercent(this, -10);

                        basepoints0 = int32(CountPctFromMaxHealth(triggerAmount));
                        trigger_spell_id = 31616;
                        target = this;
                    }
                    break;
                }
            case SPELLFAMILY_DEATHKNIGHT:
                {
                    // Acclimation
                    if (auraSpellInfo->SpellIconID == 1930)
                    {
                        if (!procSpell)
                            return false;
                        switch (GetFirstSchoolInMask(procSpell->GetSchoolMask()))
                        {
                            case SPELL_SCHOOL_NORMAL:
                                return false;                   // ignore
                            case SPELL_SCHOOL_HOLY:
                                trigger_spell_id = 50490;
                                break;
                            case SPELL_SCHOOL_FIRE:
                                trigger_spell_id = 50362;
                                break;
                            case SPELL_SCHOOL_NATURE:
                                trigger_spell_id = 50488;
                                break;
                            case SPELL_SCHOOL_FROST:
                                trigger_spell_id = 50485;
                                break;
                            case SPELL_SCHOOL_SHADOW:
                                trigger_spell_id = 50489;
                                break;
                            case SPELL_SCHOOL_ARCANE:
                                trigger_spell_id = 50486;
                                break;
                            default:
                                return false;
                        }
                    }
                    // Blood Presence (Improved)
                    else if (auraSpellInfo->Id == 63611)
                    {
                        if (GetTypeId() != TYPEID_PLAYER)
                            return false;

                        trigger_spell_id = 50475;
                        basepoints0 = CalculatePct(int32(damage), triggerAmount);
                    }
                    break;
                }
        }
    }

    // All ok. Check current trigger spell
    SpellInfo const* triggerEntry = sSpellMgr->GetSpellInfo(trigger_spell_id);
    if (!triggerEntry)
    {
        // Don't cast unknown spell
        LOG_ERROR("entities.unit", "Unit::HandleProcTriggerSpell: Spell {} (effIndex: {}) has unknown TriggerSpell {}. Unhandled custom case?", auraSpellInfo->Id, triggeredByAura->GetEffIndex(), trigger_spell_id);
        return false;
    }

    // not allow proc extra attack spell at extra attack
    if (triggerEntry->HasEffect(SPELL_EFFECT_ADD_EXTRA_ATTACKS))
    {
        uint32 lastExtraAttackSpell = eventInfo.GetActor()->GetLastExtraAttackSpell();

        // Patch 1.12.0(?) extra attack abilities can no longer chain proc themselves
        if (lastExtraAttackSpell == trigger_spell_id)
        {
            return false;
        }

        // Patch 2.2.0 Sword Specialization (Warrior, Rogue) extra attack can no longer proc additional extra attacks
        // 3.3.5 Sword Specialization (Warrior), Hack and Slash (Rogue)
        if (lastExtraAttackSpell == SPELL_SWORD_SPECIALIZATION || lastExtraAttackSpell == SPELL_HACK_AND_SLASH)
        {
            return false;
        }
    }

    // Custom requirements (not listed in procEx) Warning! damage dealing after this
    // Custom triggered spells
    switch (auraSpellInfo->Id)
    {
        // Deep Wounds
        case 12834:
        case 12849:
        case 12867:
            {
                if (GetTypeId() != TYPEID_PLAYER)
                    return false;

                if (procFlags & PROC_FLAG_DONE_OFFHAND_ATTACK)
                    basepoints0 = int32((GetFloatValue(UNIT_FIELD_MAXOFFHANDDAMAGE) + GetFloatValue(UNIT_FIELD_MINOFFHANDDAMAGE)) / 2.0f);
                else
                    basepoints0 = int32((GetFloatValue(UNIT_FIELD_MAXDAMAGE) + GetFloatValue(UNIT_FIELD_MINDAMAGE)) / 2.0f);
                break;
            }
        // Persistent Shield (Scarab Brooch trinket)
        // This spell originally trigger 13567 - Dummy Trigger (vs dummy efect)
        case 26467:
            {
                basepoints0 = int32(CalculatePct(damage, 15));
                target = victim;
                trigger_spell_id = 26470;
                break;
            }
        // Unyielding Knights (item exploit 29108\29109)
        case 38164:
            {
                if (!victim || victim->GetEntry() != 19457)  // Proc only if your target is Grillok
                    return false;
                break;
            }
        // Deflection
        case 52420:
            {
                if (!HealthBelowPct(35))
                    return false;
                break;
            }

        // Cheat Death
        case 28845:
            {
                // When your health drops below 20%
                if (HealthBelowPctDamaged(20, damage) || HealthBelowPct(20))
                    return false;
                break;
            }
        // Deadly Swiftness (Rank 1)
        case 31255:
            {
                // whenever you deal damage to a target who is below 20% health.
                if (!victim || !victim->IsAlive() || victim->HealthAbovePct(20))
                    return false;

                target = this;
                trigger_spell_id = 22588;
                [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
            }
        // Bonus Healing (Crystal Spire of Karabor mace)
        case 40971:
            {
                // If your target is below $s1% health
                if (!victim || !victim->IsAlive() || victim->HealthAbovePct(triggerAmount))
                    return false;
                break;
            }
        // Rapid Recuperation
        case 53228:
        case 53232:
            {
                // This effect only from Rapid Fire (ability cast)
                if (!procSpell || !(procSpell->SpellFamilyFlags[0] & 0x20))
                    return false;
                break;
            }
        // Decimation
        case 63156:
        case 63158:
            // Can proc only if target has hp below 35%
            if (!victim || !victim->HasAuraState(AURA_STATE_HEALTHLESS_35_PERCENT, procSpell, this))
                return false;
            break;
        // Ulduar, Hodir, Toasty Fire
        case 62821:
            if (this->GetTypeId() != TYPEID_PLAYER) // spell has Attribute, but persistent area auras ignore it
                return false;
            break;
        case 15337: // Improved Spirit Tap (Rank 1)
        case 15338: // Improved Spirit Tap (Rank 2)
            {
                if (!procSpell)
                    return false;

                if (procSpell->SpellFamilyFlags[0] & 0x800000)
                    if ((procSpell->Id != 58381) || !roll_chance_i(50))
                        return false;

                target = victim;
                break;
            }
        // Professor Putricide - Ooze Spell Tank Protection
        case 71770:
            if (victim)
                victim->CastSpell(victim, trigger_spell_id, true);    // EffectImplicitTarget is self
            return true;
        case 45057: // Evasive Maneuvers (Commendation of Kael`thas trinket)
        case 71634: // Item - Icecrown 25 Normal Tank Trinket 1
        case 71640: // Item - Icecrown 25 Heroic Tank Trinket 1
        case 75475: // Item - Chamber of Aspects 25 Normal Tank Trinket
        case 75481: // Item - Chamber of Aspects 25 Heroic Tank Trinket
            {
                // Procs only if damage takes health below $s1%
                if (!HealthBelowPctDamaged(triggerAmount, damage))
                    return false;
                break;
            }
        default:
            break;
    }

    if (auraSpellInfo->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT)
    {
        // Xinef: keep this order, Aura 70656 has SpellIconID 85!
        // Item - Death Knight T10 Melee 4P Bonus
        if (auraSpellInfo->Id == 70656)
        {
            if (GetTypeId() != TYPEID_PLAYER || !IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
                return false;

            for (uint8 i = 0; i < MAX_RUNES; ++i)
                if (ToPlayer()->GetRuneCooldown(i) == 0)
                    return false;
        }
        // Blade Barrier
        else if (auraSpellInfo->SpellIconID == 85)
        {
            Player* plr = ToPlayer();
            if (!plr || !plr->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY) || !procSpell)
                return false;

            if (!plr->IsBaseRuneSlotsOnCooldown(RUNE_BLOOD))
                return false;
        }
        // Rime
        else if (auraSpellInfo->SpellIconID == 56)
        {
            if (GetTypeId() != TYPEID_PLAYER)
                return false;

            // Howling Blast
            ToPlayer()->RemoveCategoryCooldown(1248);
        }
    }

    // Custom basepoints/target for exist spell
    // dummy basepoints or other customs
    switch (trigger_spell_id)
    {
        // Auras which should proc on area aura source (caster in this case):
        // Turn the Tables
        case 52914:
        case 52915:
        case 52910:
        // Honor Among Thieves
        case 51699:
            {
                target = triggeredByAura->GetBase()->GetCaster();
                if (!target)
                    return false;

                if (Player* pTarget = target->ToPlayer())
                {
                    if (cooldown)
                    {
                        if (pTarget->HasSpellCooldown(trigger_spell_id) )
                            return false;
                        pTarget->AddSpellCooldown(trigger_spell_id, 0, cooldown);
                    }

                    Unit* cptarget = nullptr;
                    if (trigger_spell_id == 51699)
                    {
                        cptarget = pTarget->GetComboTarget();
                        if (!cptarget)
                        {
                            cptarget = pTarget->GetSelectedUnit();
                        }
                    }
                    else
                        cptarget = target;

                    if (cptarget)
                    {
                        target->CastSpell(cptarget, trigger_spell_id, true);
                        return true;
                    }
                }
                return false;
            }
        // Cast positive spell on enemy target
        case 7099:  // Curse of Mending
        case 39703: // Curse of Mending
        case 20233: // Improved Lay on Hands (cast on target)
            {
                target = victim;
                break;
            }
        // Ruby Drake, Evasive Aura
        case 50241:
            {
                if( GetAura(50240) )
                    return false;

                break;
            }
        // Combo points add triggers (need add combopoint only for main target, and after possible combopoints reset)
        case 15250: // Rogue Setup
            {
                // applied only for main target
                if (!victim || (GetTypeId() == TYPEID_PLAYER && victim != ToPlayer()->GetSelectedUnit()))
                    return false;
                break;                                   // continue normal case
            }
        // Finish movies that add combo
        case 14189: // Seal Fate (Netherblade set)
        case 14157: // Ruthlessness
            {
                victim = nullptr;
                // Need add combopoint AFTER finish movie (or they dropped in finish phase)
                break;
            }
        // Item - Druid T10 Balance 2P Bonus
        case 16870:
            {
                if (HasAura(70718))
                    CastSpell(this, 70721, true);
                RemoveAurasDueToSpell(trigger_spell_id);
                break;
            }
        // Shamanistic Rage triggered spell
        case 30824:
            {
                basepoints0 = int32(CalculatePct(GetTotalAttackPowerValue(BASE_ATTACK), triggerAmount));
                break;
            }
        // Enlightenment (trigger only from mana cost spells)
        case 35095:
            {
                if (!procSpell || procSpell->PowerType != POWER_MANA || (procSpell->ManaCost == 0 && procSpell->ManaCostPercentage == 0 && procSpell->ManaCostPerlevel == 0))
                    return false;
                break;
            }
        case 46916:  // Slam! (Bloodsurge proc)
        case 52437:  // Sudden Death
            {
                // Item - Warrior T10 Melee 4P Bonus
                if (AuraEffect const* aurEff = GetAuraEffect(70847, 0))
                {
                    if (!roll_chance_i(aurEff->GetAmount()))
                    {
                        // Xinef: dont allow normal proc to override set one
                        if (GetAura((trigger_spell_id == 46916) ? 71072 : 71069))
                            return false;
                        // Xinef: just to be sure
                        RemoveAurasDueToSpell(70849);
                        break;
                    }

                    // Xinef: fully remove all auras and reapply once more
                    RemoveAurasDueToSpell(70849);
                    RemoveAurasDueToSpell(71072);
                    RemoveAurasDueToSpell(71069);

                    CastSpell(this, 70849, true, castItem, triggeredByAura); // Extra Charge!
                    if (trigger_spell_id == 46916)
                        CastSpell(this, 71072, true, castItem, triggeredByAura); // Slam GCD Reduced
                    else
                        CastSpell(this, 71069, true, castItem, triggeredByAura); // Execute GCD Reduced
                }
                break;
            }
        // Sword and Board
        case 50227:
            {
                // Remove cooldown on Shield Slam
                if (GetTypeId() == TYPEID_PLAYER)
                    ToPlayer()->RemoveCategoryCooldown(1209);
                break;
            }
        // Maelstrom Weapon
        case 53817:
            {
                // have rank dependent proc chance, ignore too often cases
                // PPM = 2.5 * (rank of talent),
                uint32 rank = auraSpellInfo->GetRank();
                // 5 rank -> 100% 4 rank -> 80% and etc from full rate
                if (!roll_chance_i(20 * rank))
                    return false;

                // Item - Shaman T10 Enhancement 4P Bonus
                if (AuraEffect const* aurEff = GetAuraEffect(70832, 0))
                    if (Aura const* maelstrom = GetAura(53817))
                        // xinef: we have 4 charges and all proc conditions are met - aura reaches 5 charges
                        if ((maelstrom->GetStackAmount() == 4) && roll_chance_i(aurEff->GetAmount()))
                            CastSpell(this, 70831, true, castItem, triggeredByAura);

                break;
            }
        // Astral Shift
        case 52179:
            {
                if (!procSpell || !(procEx & (PROC_EX_NORMAL_HIT | PROC_EX_CRITICAL_HIT)) || this == victim)
                    return false;

                // Need stun, fear or silence mechanic
                if (!(procSpell->GetAllEffectsMechanicMask() & ((1 << MECHANIC_SILENCE) | (1 << MECHANIC_STUN) | (1 << MECHANIC_FEAR))))
                    return false;
                break;
            }
        // Glyph of Death's Embrace
        case 58679:
            {
                // Proc only from healing part of Death Coil. Check is essential as all Death Coil spells have 0x2000 mask in SpellFamilyFlags
                if (!procSpell || !(procSpell->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT && procSpell->SpellFamilyFlags[0] == 0x80002000))
                    return false;
                break;
            }
        // Glyph of Death Grip
        case 58628:
            {
                // remove cooldown of Death Grip
                if (GetTypeId() == TYPEID_PLAYER)
                    ToPlayer()->RemoveSpellCooldown(49576, true);
                return true;
            }
        // Savage Defense
        case 62606:
            {
                basepoints0 = CalculatePct(triggerAmount, GetTotalAttackPowerValue(BASE_ATTACK));
                break;
            }
        // Body and Soul
        case 64128:
        case 65081:
            {
                // Proc only from PW:S cast
                if (!procSpell || !(procSpell->SpellFamilyFlags[0] & 0x00000001))
                    return false;
                break;
            }
        // Culling the Herd
        case 70893:
            {
                if (!procSpell)
                {
                    return false;
                }
                // check if we're doing a critical hit
                if (!(procSpell->SpellFamilyFlags[1] & 0x10000000) && (procEx != PROC_EX_CRITICAL_HIT))
                    return false;
                // check if we're procced by Claw, Bite or Smack (need to use the spell icon ID to detect it)
                if (!(procSpell->SpellIconID == 262 || procSpell->SpellIconID == 1680 || procSpell->SpellIconID == 473))
                    return false;
                break;
            }
        // Fingers of Frost, synchronise with Frostbite
        case 44544:
            {
                if (procPhase == PROC_SPELL_PHASE_HIT)
                {
                    // Find Frostbite
                    if (AuraEffect* aurEff = this->GetAuraEffect(SPELL_AURA_ADD_TARGET_TRIGGER, SPELLFAMILY_MAGE, 119, EFFECT_0))
                    {
                        if (!victim)
                            return false;

                        uint8 fofRank = sSpellMgr->GetSpellRank(triggeredByAura->GetId());
                        uint8 fbRank  = sSpellMgr->GetSpellRank(aurEff->GetId());
                        uint8 chance  = uint8(std::ceil(fofRank * fbRank * 16.6f));

                        if (roll_chance_i(chance))
                            CastSpell(victim, aurEff->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true);
                    }
                }
                break;
            }
    }

    // try detect target manually if not set
    if (!target)
        target = !(procFlags & (PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS | PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS)) && triggerEntry->IsPositive() ? this : victim;

    if (cooldown)
    {
        if (HasSpellCooldown(triggerEntry->Id))
            return false;

        AddSpellCooldown(triggerEntry->Id, 0, cooldown);
    }

    if(basepoints0)
        CastCustomSpell(target, triggerEntry->Id, &basepoints0, nullptr, nullptr, true, castItem, triggeredByAura);
    else
        CastSpell(target, triggerEntry->Id, true, castItem, triggeredByAura);

    return true;
}

bool Unit::HandleOverrideClassScriptAuraProc(Unit* victim, uint32 /*damage*/, AuraEffect* triggeredByAura, SpellInfo const* procSpell, uint32 cooldown)
{
    int32 scriptId = triggeredByAura->GetMiscValue();

    if (!victim || !victim->IsAlive())
        return false;

    Item* castItem = triggeredByAura->GetBase()->GetCastItemGUID() && GetTypeId() == TYPEID_PLAYER
                     ? ToPlayer()->GetItemByGuid(triggeredByAura->GetBase()->GetCastItemGUID()) : nullptr;

    uint32 triggered_spell_id = 0;

    switch (scriptId)
    {
        case 836:                                           // Improved Blizzard (Rank 1)
            {
                if (!procSpell || procSpell->SpellVisual[0] != 9487)
                    return false;
                triggered_spell_id = 12484;
                break;
            }
        case 988:                                           // Improved Blizzard (Rank 2)
            {
                if (!procSpell || procSpell->SpellVisual[0] != 9487)
                    return false;
                triggered_spell_id = 12485;
                break;
            }
        case 989:                                           // Improved Blizzard (Rank 3)
            {
                if (!procSpell || procSpell->SpellVisual[0] != 9487)
                    return false;
                triggered_spell_id = 12486;
                break;
            }
        case 4533:                                          // Dreamwalker Raiment 2 pieces bonus
            {
                // Chance 50%
                if (!roll_chance_i(50))
                    return false;

                switch (victim->getPowerType())
                {
                    case POWER_MANA:
                        triggered_spell_id = 28722;
                        break;
                    case POWER_RAGE:
                        triggered_spell_id = 28723;
                        break;
                    case POWER_ENERGY:
                        triggered_spell_id = 28724;
                        break;
                    default:
                        return false;
                }
                break;
            }
        case 4537:                                          // Dreamwalker Raiment 6 pieces bonus
            triggered_spell_id = 28750;                     // Blessing of the Claw
            break;
        case 5497:                                          // Improved Mana Gems
            triggered_spell_id = 37445;                     // Mana Surge
            break;
        case 7010:  // Revitalize - can proc on full hp target
        case 7011:
        case 7012:
            {
                if (!roll_chance_i(triggeredByAura->GetAmount()))
                    return false;
                switch (victim->getPowerType())
                {
                    case POWER_MANA:
                        triggered_spell_id = 48542;
                        break;
                    case POWER_RAGE:
                        triggered_spell_id = 48541;
                        break;
                    case POWER_ENERGY:
                        triggered_spell_id = 48540;
                        break;
                    case POWER_RUNIC_POWER:
                        triggered_spell_id = 48543;
                        break;
                    default:
                        break;
                }
                break;
            }
        default:
            break;
    }

    // not processed
    if (!triggered_spell_id)
        return false;

    // standard non-dummy case
    SpellInfo const* triggerEntry = sSpellMgr->GetSpellInfo(triggered_spell_id);

    if (!triggerEntry)
    {
        LOG_ERROR("entities.unit", "Unit::HandleOverrideClassScriptAuraProc: Spell {} triggering for class script id {}", triggered_spell_id, scriptId);
        return false;
    }

    if (cooldown)
    {
        if (HasSpellCooldown(triggered_spell_id))
            return false;

        AddSpellCooldown(triggered_spell_id, 0, cooldown);
    }

    CastSpell(victim, triggered_spell_id, true, castItem, triggeredByAura);

    return true;
}

void Unit::setPowerType(Powers new_powertype)
{
    SetByteValue(UNIT_FIELD_BYTES_0, 3, new_powertype);

    if (GetTypeId() == TYPEID_PLAYER)
    {
        if (ToPlayer()->GetGroup())
            ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_POWER_TYPE);
    }
    else if (Pet* pet = ToCreature()->ToPet())
    {
        if (pet->isControlled())
        {
            Unit* owner = GetOwner();
            if (owner && (owner->GetTypeId() == TYPEID_PLAYER) && owner->ToPlayer()->GetGroup())
                owner->ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_POWER_TYPE);
        }
    }

    float powerMultiplier = 1.0f;
    if (!IsPet())
        if (Creature* creature = ToCreature())
            powerMultiplier = creature->GetCreatureTemplate()->ModMana;

    switch (new_powertype)
    {
        default:
        case POWER_MANA:
            break;
        case POWER_RAGE:
            SetMaxPower(POWER_RAGE, uint32(std::ceil(GetCreatePowers(POWER_RAGE) * powerMultiplier)));
            SetPower(POWER_RAGE, 0);
            break;
        case POWER_FOCUS:
            SetMaxPower(POWER_FOCUS, uint32(std::ceil(GetCreatePowers(POWER_FOCUS) * powerMultiplier)));
            SetPower(POWER_FOCUS, uint32(std::ceil(GetCreatePowers(POWER_FOCUS) * powerMultiplier)));
            break;
        case POWER_ENERGY:
            SetMaxPower(POWER_ENERGY, uint32(std::ceil(GetCreatePowers(POWER_ENERGY) * powerMultiplier)));
            break;
        case POWER_HAPPINESS:
            SetMaxPower(POWER_HAPPINESS, uint32(std::ceil(GetCreatePowers(POWER_HAPPINESS) * powerMultiplier)));
            SetPower(POWER_HAPPINESS, uint32(std::ceil(GetCreatePowers(POWER_HAPPINESS) * powerMultiplier)));
            break;
    }

    if (Player const* player = ToPlayer())
        if (player->NeedSendSpectatorData())
        {
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "PWT", new_powertype);
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "MPW", new_powertype == POWER_RAGE || new_powertype == POWER_RUNIC_POWER ? GetMaxPower(new_powertype) / 10 : GetMaxPower(new_powertype));
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "CPW", new_powertype == POWER_RAGE || new_powertype == POWER_RUNIC_POWER ? GetPower(new_powertype) / 10 : GetPower(new_powertype));
        }
}

FactionTemplateEntry const* Unit::GetFactionTemplateEntry() const
{
    FactionTemplateEntry const* entry = sFactionTemplateStore.LookupEntry(GetFaction());
    if (!entry)
    {
        static ObjectGuid guid;                             // prevent repeating spam same faction problem

        if (GetGUID() != guid)
        {
            if (Player const* player = ToPlayer())
                LOG_ERROR("entities.unit", "Player {} has invalid faction (faction template id) #{}", player->GetName(), GetFaction());
            else if (Creature const* creature = ToCreature())
                LOG_ERROR("entities.unit", "Creature (template id: {}) has invalid faction (faction template id) #{}", creature->GetCreatureTemplate()->Entry, GetFaction());
            else
                LOG_ERROR("entities.unit", "Unit (name={}, type={}) has invalid faction (faction template id) #{}", GetName(), uint32(GetTypeId()), GetFaction());

            guid = GetGUID();
        }
    }
    return entry;
}

void Unit::SetFaction(uint32 faction)
{
    SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, faction);
    if (GetTypeId() == TYPEID_UNIT)
        ToCreature()->UpdateMoveInLineOfSightState();
}

// function based on function Unit::UnitReaction from 13850 client
ReputationRank Unit::GetReactionTo(Unit const* target, bool checkOriginalFaction /*= false*/) const
{
    // always friendly to self
    if (this == target)
        return REP_FRIENDLY;

    // always friendly to charmer or owner
    if (GetCharmerOrOwnerOrSelf() == target->GetCharmerOrOwnerOrSelf())
        return REP_FRIENDLY;

    Player const* selfPlayerOwner = GetAffectingPlayer();
    Player const* targetPlayerOwner = target->GetAffectingPlayer();

    // check forced reputation to support SPELL_AURA_FORCE_REACTION
    if (selfPlayerOwner)
    {
        if (FactionTemplateEntry const* targetFactionTemplateEntry = target->GetFactionTemplateEntry())
            if (ReputationRank const* repRank = selfPlayerOwner->GetReputationMgr().GetForcedRankIfAny(targetFactionTemplateEntry))
                return *repRank;
    }
    else if (targetPlayerOwner)
    {
        if (FactionTemplateEntry const* selfFactionTemplateEntry = GetFactionTemplateEntry())
            if (ReputationRank const* repRank = targetPlayerOwner->GetReputationMgr().GetForcedRankIfAny(selfFactionTemplateEntry))
                return *repRank;
    }

    if (HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
    {
        if (target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
        {
            if (selfPlayerOwner && targetPlayerOwner)
            {
                // always friendly to other unit controlled by player, or to the player himself
                if (selfPlayerOwner == targetPlayerOwner)
                    return REP_FRIENDLY;

                // duel - always hostile to opponent
                if (selfPlayerOwner->duel && selfPlayerOwner->duel->Opponent == targetPlayerOwner && selfPlayerOwner->duel->State == DUEL_STATE_IN_PROGRESS)
                    return REP_HOSTILE;

                // same group - checks dependant only on our faction - skip FFA_PVP for example
                if (selfPlayerOwner->IsInRaidWith(targetPlayerOwner))
                    return REP_FRIENDLY; // return true to allow config option AllowTwoSide.Interaction.Group to work
                // however client seems to allow mixed group parties, because in 13850 client it works like:
                // return GetFactionReactionTo(GetFactionTemplateEntry(), target);
            }

            // check FFA_PVP
            if (IsFFAPvP() && target->IsFFAPvP())
                return REP_HOSTILE;

            if (selfPlayerOwner)
            {
                if (FactionTemplateEntry const* targetFactionTemplateEntry = target->GetFactionTemplateEntry())
                {
                    if (ReputationRank const* repRank = selfPlayerOwner->GetReputationMgr().GetForcedRankIfAny(targetFactionTemplateEntry))
                        return *repRank;
                    if (!selfPlayerOwner->HasUnitFlag2(UNIT_FLAG2_IGNORE_REPUTATION))
                    {
                        if (FactionEntry const* targetFactionEntry = sFactionStore.LookupEntry(targetFactionTemplateEntry->faction))
                        {
                            if (targetFactionEntry->CanHaveReputation())
                            {
                                // check contested flags
                                if (targetFactionTemplateEntry->factionFlags & FACTION_TEMPLATE_FLAG_ATTACK_PVP_ACTIVE_PLAYERS
                                        && selfPlayerOwner->HasPlayerFlag(PLAYER_FLAGS_CONTESTED_PVP))
                                    return REP_HOSTILE;

                                // if faction has reputation, hostile state depends only from AtWar state
                                if (selfPlayerOwner->GetReputationMgr().IsAtWar(targetFactionEntry))
                                    return REP_HOSTILE;
                                return REP_FRIENDLY;
                            }
                        }
                    }
                }
            }
        }
    }

    ReputationRank repRank = REP_HATED;
    if (!sScriptMgr->IfNormalReaction(this, target, repRank))
    {
        return ReputationRank(repRank);
    }

    FactionTemplateEntry const* factionTemplateEntry = nullptr;
    if (checkOriginalFaction)
    {
        if (GetTypeId() == TYPEID_PLAYER)
        {
            if (ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(getRace()))
            {
                factionTemplateEntry = sFactionTemplateStore.LookupEntry(rEntry->FactionID);
            }
        }
        else
        {
            Unit* owner = GetOwner();
            if (HasUnitTypeMask(UNIT_MASK_MINION) && owner)
            {
                factionTemplateEntry = sFactionTemplateStore.LookupEntry(owner->GetFaction());
            }
            else if (CreatureTemplate const* cinfo = ToCreature()->GetCreatureTemplate())
            {
                factionTemplateEntry = sFactionTemplateStore.LookupEntry(cinfo->faction);
            }
        }
    }

    if (!factionTemplateEntry)
    {
        factionTemplateEntry = GetFactionTemplateEntry();
    }

    // do checks dependant only on our faction
    return GetFactionReactionTo(factionTemplateEntry, target);
}

ReputationRank Unit::GetFactionReactionTo(FactionTemplateEntry const* factionTemplateEntry, Unit const* target) const
{
    // always neutral when no template entry found
    if (!factionTemplateEntry)
        return REP_NEUTRAL;

    FactionTemplateEntry const* targetFactionTemplateEntry = target->GetFactionTemplateEntry();
    if (!targetFactionTemplateEntry)
        return REP_NEUTRAL;

    // xinef: check forced reputation for self also
    if (Player const* selfPlayerOwner = GetAffectingPlayer())
        if (ReputationRank const* repRank = selfPlayerOwner->GetReputationMgr().GetForcedRankIfAny(target->GetFactionTemplateEntry()))
            return *repRank;

    if (Player const* targetPlayerOwner = target->GetAffectingPlayer())
    {
        // check contested flags
        if (factionTemplateEntry->factionFlags & FACTION_TEMPLATE_FLAG_ATTACK_PVP_ACTIVE_PLAYERS
                && targetPlayerOwner->HasPlayerFlag(PLAYER_FLAGS_CONTESTED_PVP))
            return REP_HOSTILE;
        if (ReputationRank const* repRank = targetPlayerOwner->GetReputationMgr().GetForcedRankIfAny(factionTemplateEntry))
            return *repRank;
        if (!target->HasUnitFlag2(UNIT_FLAG2_IGNORE_REPUTATION))
        {
            if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionTemplateEntry->faction))
            {
                if (factionEntry->CanHaveReputation())
                {
                    // CvP case - check reputation, don't allow state higher than neutral when at war
                    ReputationRank repRank = targetPlayerOwner->GetReputationMgr().GetRank(factionEntry);
                    if (targetPlayerOwner->GetReputationMgr().IsAtWar(factionEntry))
                        repRank = std::min(REP_NEUTRAL, repRank);
                    return repRank;
                }
            }
        }
    }

    // common faction based check
    if (factionTemplateEntry->IsHostileTo(*targetFactionTemplateEntry))
        return REP_HOSTILE;
    if (factionTemplateEntry->IsFriendlyTo(*targetFactionTemplateEntry))
        return REP_FRIENDLY;
    if (targetFactionTemplateEntry->IsFriendlyTo(*factionTemplateEntry))
        return REP_FRIENDLY;
    if (factionTemplateEntry->factionFlags & FACTION_TEMPLATE_FLAG_HATES_ALL_EXCEPT_FRIENDS)
        return REP_HOSTILE;
    // neutral by default
    return REP_NEUTRAL;
}

bool Unit::IsHostileTo(Unit const* unit) const
{
    return GetReactionTo(unit) <= REP_HOSTILE;
}

bool Unit::IsFriendlyTo(Unit const* unit) const
{
    return GetReactionTo(unit) >= REP_FRIENDLY;
}

bool Unit::IsHostileToPlayers() const
{
    FactionTemplateEntry const* my_faction = GetFactionTemplateEntry();
    if (!my_faction || !my_faction->faction)
        return false;

    FactionEntry const* raw_faction = sFactionStore.LookupEntry(my_faction->faction);
    if (raw_faction && raw_faction->reputationListID >= 0)
        return false;

    return my_faction->IsHostileToPlayers();
}

bool Unit::IsNeutralToAll() const
{
    FactionTemplateEntry const* my_faction = GetFactionTemplateEntry();
    if (!my_faction || !my_faction->faction)
        return true;

    FactionEntry const* raw_faction = sFactionStore.LookupEntry(my_faction->faction);
    if (raw_faction && raw_faction->reputationListID >= 0)
        return false;

    return my_faction->IsNeutralToAll();
}

bool Unit::Attack(Unit* victim, bool meleeAttack)
{
    if (!victim || victim == this)
        return false;

    // dead units can neither attack nor be attacked
    if (!IsAlive() || !victim->IsAlive())
        return false;

    // pussywizard: check map, world, phase >_> multithreading crash fix
    if (!IsInMap(victim) || !InSamePhase(victim))
        return false;

    // player cannot attack in mount state
    if (GetTypeId() == TYPEID_PLAYER && IsMounted())
        return false;

    // creatures cannot attack while evading
    Creature* creature = ToCreature();
    if (creature && creature->IsInEvadeMode())
    {
        return false;
    }

    // creatures should not try to attack the player during polymorph
    if (creature && creature->IsPolymorphed())
    {
        return false;
    }

    //if (HasUnitFlag(UNIT_FLAG_PACIFIED)) // pussywizard: why having this flag prevents from entering combat? it should just prevent melee attack
    //    return false;

    // nobody can attack GM in GM-mode
    if (victim->GetTypeId() == TYPEID_PLAYER)
    {
        if (victim->ToPlayer()->IsGameMaster())
            return false;
    }
    else
    {
        if (victim->ToCreature()->IsEvadingAttacks())
            return false;
    }

    // Unit with SPELL_AURA_SPIRIT_OF_REDEMPTION can not attack
    if (HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
        return false;

    // remove SPELL_AURA_MOD_UNATTACKABLE at attack (in case non-interruptible spells stun aura applied also that not let attack)
    if (HasAuraType(SPELL_AURA_MOD_UNATTACKABLE))
        RemoveAurasByType(SPELL_AURA_MOD_UNATTACKABLE);

    if (m_attacking)
    {
        if (m_attacking == victim)
        {
            // switch to melee attack from ranged/magic
            if (meleeAttack)
            {
                if (!HasUnitState(UNIT_STATE_MELEE_ATTACKING))
                {
                    AddUnitState(UNIT_STATE_MELEE_ATTACKING);
                    SendMeleeAttackStart(victim);
                    return true;
                }
            }
            else if (HasUnitState(UNIT_STATE_MELEE_ATTACKING))
            {
                ClearUnitState(UNIT_STATE_MELEE_ATTACKING);
                SendMeleeAttackStop(victim);
                return true;
            }
            return false;
        }

        // switch target
        InterruptSpell(CURRENT_MELEE_SPELL, true, true, true);
        if (!meleeAttack)
            ClearUnitState(UNIT_STATE_MELEE_ATTACKING);
    }

    if (m_attacking)
        m_attacking->_removeAttacker(this);

    m_attacking = victim;
    m_attacking->_addAttacker(this);

    // Set our target
    SetTarget(victim->GetGUID());

    if (meleeAttack)
        AddUnitState(UNIT_STATE_MELEE_ATTACKING);

    // set position before any AI calls/assistance
    //if (GetTypeId() == TYPEID_UNIT)
    //    ToCreature()->SetCombatStartPosition(GetPositionX(), GetPositionY(), GetPositionZ());
    if (creature && !(IsControllableGuardian() && IsControlledByPlayer()))
    {
        // should not let player enter combat by right clicking target - doesn't helps
        SetInCombatWith(victim);
        if (victim->GetTypeId() == TYPEID_PLAYER)
            victim->SetInCombatWith(this);
        AddThreat(victim, 0.0f);

        creature->SendAIReaction(AI_REACTION_HOSTILE);

        /// @todo: Implement aggro range, detection range and assistance range templates
        if (!(creature->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_DONT_CALL_ASSISTANCE))
        {
            creature->CallAssistance();
        }
        creature->SetAssistanceTimer(sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_PERIOD));

        SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
    }

    // delay offhand weapon attack to next attack time
    if (haveOffhandWeapon() && isAttackReady(OFF_ATTACK))
        setAttackTimer(OFF_ATTACK, ATTACK_DISPLAY_DELAY);

    if (meleeAttack)
        SendMeleeAttackStart(victim);

    return true;
}

bool Unit::AttackStop()
{
    if (!m_attacking)
        return false;

    Unit* victim = m_attacking;

    m_attacking->_removeAttacker(this);
    m_attacking = nullptr;

    // Clear our target
    SetTarget(ObjectGuid::Empty);

    ClearUnitState(UNIT_STATE_MELEE_ATTACKING);

    InterruptSpell(CURRENT_MELEE_SPELL);

    // reset only at real combat stop
    if (Creature* creature = ToCreature())
    {
        creature->SetNoCallAssistance(false);

        if (creature->HasSearchedAssistance())
        {
            creature->SetNoSearchAssistance(false);
        }
    }

    SendMeleeAttackStop(victim);

    return true;
}

void Unit::CombatStop(bool includingCast)
{
    if (includingCast && IsNonMeleeSpellCast(false))
        InterruptNonMeleeSpells(false);

    AttackStop();
    RemoveAllAttackers();
    if (GetTypeId() == TYPEID_PLAYER)
        ToPlayer()->SendAttackSwingCancelAttack();     // melee and ranged forced attack cancel
    ClearInCombat();

    // xinef: just in case
    if (IsPetInCombat() && GetTypeId() != TYPEID_PLAYER)
        ClearInPetCombat();
}

void Unit::CombatStopWithPets(bool includingCast)
{
    CombatStop(includingCast);

    for (ControlSet::const_iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
        (*itr)->CombatStop(includingCast);
}

bool Unit::isAttackingPlayer() const
{
    if (HasUnitState(UNIT_STATE_ATTACK_PLAYER))
        return true;

    if (!m_Controlled.empty())
        for (ControlSet::const_iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
            if ((*itr)->isAttackingPlayer())
                return true;

    for (uint8 i = 0; i < MAX_SUMMON_SLOT; ++i)
        if (m_SummonSlot[i])
            if (Creature* summon = GetMap()->GetCreature(m_SummonSlot[i]))
                if (summon->isAttackingPlayer())
                    return true;

    return false;
}

void Unit::RemoveAllAttackers()
{
    while (!m_attackers.empty())
    {
        AttackerSet::iterator iter = m_attackers.begin();
        if (!(*iter)->AttackStop())
        {
            LOG_ERROR("entities.unit", "WORLD: Unit has an attacker that isn't attacking it!");
            m_attackers.erase(iter);
        }
    }
}

void Unit::ModifyAuraState(AuraStateType flag, bool apply)
{
    if (apply)
    {
        if (!HasFlag(UNIT_FIELD_AURASTATE, 1 << (flag - 1)))
        {
            SetFlag(UNIT_FIELD_AURASTATE, 1 << (flag - 1));
            Unit::AuraMap& tAuras = GetOwnedAuras();
            for (Unit::AuraMap::iterator itr = tAuras.begin(); itr != tAuras.end(); ++itr)
            {
                if( (*itr).second->IsRemoved() )
                    continue;

                if( (*itr).second->GetSpellInfo()->CasterAuraState == flag )
                    if( AuraApplication* aurApp = (*itr).second->GetApplicationOfTarget(GetGUID()) )
                        (*itr).second->HandleAllEffects(aurApp, AURA_EFFECT_HANDLE_REAL, true);
            }
        }
    }
    else
    {
        if (HasFlag(UNIT_FIELD_AURASTATE, 1 << (flag - 1)))
        {
            RemoveFlag(UNIT_FIELD_AURASTATE, 1 << (flag - 1));

            if (flag != AURA_STATE_ENRAGE)                  // enrage aura state triggering continues auras
            {
                Unit::AuraMap& tAuras = GetOwnedAuras();
                for (Unit::AuraMap::iterator itr = tAuras.begin(); itr != tAuras.end(); ++itr)
                {
                    if( (*itr).second->GetSpellInfo()->CasterAuraState == flag )
                        if( AuraApplication* aurApp = (*itr).second->GetApplicationOfTarget(GetGUID()) )
                            (*itr).second->HandleAllEffects(aurApp, AURA_EFFECT_HANDLE_REAL, false);
                }
            }
        }
    }
}

uint32 Unit::BuildAuraStateUpdateForTarget(Unit* target) const
{
    uint32 auraStates = GetUInt32Value(UNIT_FIELD_AURASTATE) & ~(PER_CASTER_AURA_STATE_MASK);
    for (AuraStateAurasMap::const_iterator itr = m_auraStateAuras.begin(); itr != m_auraStateAuras.end(); ++itr)
        if ((1 << (itr->first - 1)) & PER_CASTER_AURA_STATE_MASK)
            if (itr->second->GetBase()->GetCasterGUID() == target->GetGUID())
                auraStates |= (1 << (itr->first - 1));

    return auraStates;
}

bool Unit::HasAuraState(AuraStateType flag, SpellInfo const* spellProto, Unit const* Caster) const
{
    if (Caster)
    {
        if (spellProto)
        {
            AuraEffectList const& stateAuras = Caster->GetAuraEffectsByType(SPELL_AURA_ABILITY_IGNORE_AURASTATE);
            for (AuraEffectList::const_iterator j = stateAuras.begin(); j != stateAuras.end(); ++j)
                if ((*j)->IsAffectedOnSpell(spellProto))
                    return true;
        }
        // Check per caster aura state
        // If aura with aurastate by caster not found return false
        if ((1 << (flag - 1)) & PER_CASTER_AURA_STATE_MASK)
        {
            AuraStateAurasMapBounds range = m_auraStateAuras.equal_range(flag);
            for (AuraStateAurasMap::const_iterator itr = range.first; itr != range.second; ++itr)
                if (itr->second->GetBase()->GetCasterGUID() == Caster->GetGUID())
                    return true;
            return false;
        }
    }

    return HasFlag(UNIT_FIELD_AURASTATE, 1 << (flag - 1));
}

void Unit::SetOwnerGUID(ObjectGuid owner)
{
    if (GetOwnerGUID() == owner)
        return;

    SetGuidValue(UNIT_FIELD_SUMMONEDBY, owner);
    if (!owner)
        return;

    m_applyResilience = !IsVehicle() && owner.IsPlayer();

    // Update owner dependent fields
    Player* player = ObjectAccessor::GetPlayer(*this, owner);
    if (!player || !player->HaveAtClient(this)) // if player cannot see this unit yet, he will receive needed data with create object
        return;

    SetFieldNotifyFlag(UF_FLAG_OWNER);

    UpdateData udata;
    WorldPacket packet;
    BuildValuesUpdateBlockForPlayer(&udata, player);
    udata.BuildPacket(packet);
    player->SendDirectMessage(&packet);

    RemoveFieldNotifyFlag(UF_FLAG_OWNER);
}

Unit* Unit::GetOwner() const
{
    if (ObjectGuid ownerGUID = GetOwnerGUID())
        return ObjectAccessor::GetUnit(*this, ownerGUID);

    return nullptr;
}

Unit* Unit::GetCharmer() const
{
    if (ObjectGuid charmerGUID = GetCharmerGUID())
        return ObjectAccessor::GetUnit(*this, charmerGUID);

    return nullptr;
}

Player* Unit::GetCharmerOrOwnerPlayerOrPlayerItself() const
{
    ObjectGuid guid = GetCharmerOrOwnerGUID();
    if (guid.IsPlayer())
        return ObjectAccessor::GetPlayer(*this, guid);

    return const_cast<Unit*>(this)->ToPlayer();
}

Player* Unit::GetAffectingPlayer() const
{
    if (!GetCharmerOrOwnerGUID())
        return const_cast<Unit*>(this)->ToPlayer();

    if (Unit* owner = GetCharmerOrOwner())
        return owner->GetCharmerOrOwnerPlayerOrPlayerItself();

    return nullptr;
}

Minion* Unit::GetFirstMinion() const
{
    if (ObjectGuid pet_guid = GetMinionGUID())
    {
        if (Creature* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, pet_guid))
            if (pet->HasUnitTypeMask(UNIT_MASK_MINION))
                return (Minion*)pet;

        LOG_ERROR("entities.unit", "Unit::GetFirstMinion: Minion {} not exist.", pet_guid.ToString());
        const_cast<Unit*>(this)->SetMinionGUID(ObjectGuid::Empty);
    }

    return nullptr;
}

Guardian* Unit::GetGuardianPet() const
{
    if (ObjectGuid pet_guid = GetPetGUID())
    {
        if (Creature* pet = ObjectAccessor::GetCreatureOrPetOrVehicle(*this, pet_guid))
            if (pet->HasUnitTypeMask(UNIT_MASK_GUARDIAN))
                return (Guardian*)pet;

        LOG_FATAL("entities.unit", "Unit::GetGuardianPet: Guardian {} not exist.", pet_guid.ToString());
        const_cast<Unit*>(this)->SetPetGUID(ObjectGuid::Empty);
    }

    return nullptr;
}

Unit* Unit::GetCharm() const
{
    if (ObjectGuid charm_guid = GetCharmGUID())
    {
        if (Unit* pet = ObjectAccessor::GetUnit(*this, charm_guid))
            return pet;

        LOG_ERROR("entities.unit", "Unit::GetCharm: Charmed creature {} not exist.", charm_guid.ToString());
        const_cast<Unit*>(this)->SetGuidValue(UNIT_FIELD_CHARM, ObjectGuid::Empty);
    }

    return nullptr;
}

void Unit::SetMinion(Minion* minion, bool apply)
{
    LOG_DEBUG("entities.unit", "SetMinion {} for {}, apply {}", minion->GetEntry(), GetEntry(), apply);

    if (apply)
    {
        if (minion->GetOwnerGUID())
        {
            LOG_FATAL("entities.unit", "SetMinion: Minion {} is not the minion of owner {}", minion->GetEntry(), GetEntry());
            return;
        }

        minion->SetOwnerGUID(GetGUID());

        m_Controlled.insert(minion);

        if (GetTypeId() == TYPEID_PLAYER)
        {
            minion->m_ControlledByPlayer = true;
            minion->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
        }

        // Can only have one pet. If a new one is summoned, dismiss the old one.
        if (minion->IsGuardianPet())
        {
            if (Guardian* oldPet = GetGuardianPet())
            {
                if (oldPet != minion && (oldPet->IsPet() || minion->IsPet() || oldPet->GetEntry() != minion->GetEntry()))
                {
                    // remove existing minion pet
                    if (Pet* oldPetAsPet = oldPet->ToPet())
                    {
                        oldPetAsPet->Remove(PET_SAVE_NOT_IN_SLOT);
                    }
                    else
                    {
                        oldPet->UnSummon();
                    }

                    SetPetGUID(minion->GetGUID());
                    SetMinionGUID(ObjectGuid::Empty);
                }
            }
            else
            {
                SetPetGUID(minion->GetGUID());
                SetMinionGUID(ObjectGuid::Empty);
            }
        }

        if (minion->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN))
        {
            AddGuidValue(UNIT_FIELD_SUMMON, minion->GetGUID());
        }

        if (minion->m_Properties && minion->m_Properties->Type == SUMMON_TYPE_MINIPET)
        {
            SetCritterGUID(minion->GetGUID());
        }

        // PvP, FFAPvP
        minion->SetByteValue(UNIT_FIELD_BYTES_2, 1, GetByteValue(UNIT_FIELD_BYTES_2, 1));

        // Ghoul pets have energy instead of mana (is anywhere better place for this code?)
        if (minion->IsPetGhoul() || minion->GetEntry() == 24207 /*ENTRY_ARMY_OF_THE_DEAD*/)
            minion->setPowerType(POWER_ENERGY);

        if (GetTypeId() == TYPEID_PLAYER)
        {
            // Send infinity cooldown - client does that automatically but after relog cooldown needs to be set again
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(minion->GetUInt32Value(UNIT_CREATED_BY_SPELL));

            if (spellInfo && spellInfo->IsCooldownStartedOnEvent())
                ToPlayer()->AddSpellAndCategoryCooldowns(spellInfo, 0, nullptr, true);
        }
    }
    else
    {
        if (minion->GetOwnerGUID() != GetGUID())
        {
            LOG_FATAL("entities.unit", "SetMinion: Minion {} is not the minion of owner {}", minion->GetEntry(), GetEntry());
            return;
        }

        m_Controlled.erase(minion);

        if (minion->m_Properties && minion->m_Properties->Type == SUMMON_TYPE_MINIPET)
        {
            if (GetCritterGUID() == minion->GetGUID())
                SetCritterGUID(ObjectGuid::Empty);
        }

        if (minion->IsGuardianPet())
        {
            if (GetPetGUID() == minion->GetGUID())
                SetPetGUID(ObjectGuid::Empty);
        }
        else if (minion->IsTotem())
        {
            // All summoned by totem minions must disappear when it is removed.
            if (SpellInfo const* spInfo = sSpellMgr->GetSpellInfo(minion->ToTotem()->GetSpell()))
            {
                for (int i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (spInfo->Effects[i].Effect != SPELL_EFFECT_SUMMON)
                        continue;

                    RemoveAllMinionsByEntry(spInfo->Effects[i].MiscValue);
                }
            }
        }

        if (GetTypeId() == TYPEID_PLAYER)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(minion->GetUInt32Value(UNIT_CREATED_BY_SPELL));
            // Remove infinity cooldown
            if (spellInfo && spellInfo->IsCooldownStartedOnEvent())
                ToPlayer()->SendCooldownEvent(spellInfo);

            // xinef: clear spell book
            if (m_Controlled.empty())
                ToPlayer()->SendRemoveControlBar();
        }

        //if (minion->HasUnitTypeMask(UNIT_MASK_GUARDIAN))
        {
            if (RemoveGuidValue(UNIT_FIELD_SUMMON, minion->GetGUID()))
            {
                // Check if there is another minion
                for (ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
                {
                    // do not use this check, creature do not have charm guid
                    //if (GetCharmGUID() == (*itr)->GetGUID())
                    if (GetGUID() == (*itr)->GetCharmerGUID())
                        continue;

                    //ASSERT((*itr)->GetOwnerGUID() == GetGUID());
                    if ((*itr)->GetOwnerGUID() != GetGUID())
                    {
                        OutDebugInfo();
                        (*itr)->OutDebugInfo();
                        ABORT();
                    }
                    ASSERT((*itr)->GetTypeId() == TYPEID_UNIT);

                    if (!(*itr)->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN))
                        continue;

                    if (AddGuidValue(UNIT_FIELD_SUMMON, (*itr)->GetGUID()))
                    {
                        // show another pet bar if there is no charm bar
                        if (GetTypeId() == TYPEID_PLAYER && !GetCharmGUID())
                        {
                            if ((*itr)->IsPet())
                                ToPlayer()->PetSpellInitialize();
                            else
                                ToPlayer()->CharmSpellInitialize();
                        }
                    }
                    break;
                }
            }
        }
    }
}

void Unit::GetAllMinionsByEntry(std::list<Creature*>& Minions, uint32 entry)
{
    for (Unit::ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end();)
    {
        Unit* unit = *itr;
        ++itr;
        if (unit->GetEntry() == entry && unit->GetTypeId() == TYPEID_UNIT
                && unit->ToCreature()->IsSummon()) // minion, actually
            Minions.push_back(unit->ToCreature());
    }
}

void Unit::RemoveAllMinionsByEntry(uint32 entry)
{
    for (Unit::ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end();)
    {
        Unit* unit = *itr;
        ++itr;
        if (unit->GetEntry() == entry && unit->GetTypeId() == TYPEID_UNIT
                && unit->ToCreature()->IsSummon()) // minion, actually
            unit->ToTempSummon()->UnSummon();
        // i think this is safe because i have never heard that a despawned minion will trigger a same minion
    }
}

void Unit::SetCharm(Unit* charm, bool apply)
{
    if (apply)
    {
        if (GetTypeId() == TYPEID_PLAYER)
        {
            if (!AddGuidValue(UNIT_FIELD_CHARM, charm->GetGUID()))
                LOG_FATAL("entities.unit", "Player {} is trying to charm unit {}, but it already has a charmed unit {}", GetName(), charm->GetEntry(), GetCharmGUID().ToString());

            charm->m_ControlledByPlayer = true;
            /// @todo: maybe we can use this flag to check if controlled by player
            charm->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
        }
        else
            charm->m_ControlledByPlayer = false;

        // PvP, FFAPvP
        charm->SetByteValue(UNIT_FIELD_BYTES_2, 1, GetByteValue(UNIT_FIELD_BYTES_2, 1));

        if (!charm->AddGuidValue(UNIT_FIELD_CHARMEDBY, GetGUID()))
            LOG_FATAL("entities.unit", "Unit {} is being charmed, but it already has a charmer {}", charm->GetEntry(), charm->GetCharmerGUID().ToString());

        _isWalkingBeforeCharm = charm->IsWalking();
        if (_isWalkingBeforeCharm)
        {
            charm->SetWalk(false);
            charm->SendMovementFlagUpdate();
        }

        m_Controlled.insert(charm);
    }
    else
    {
        if (GetTypeId() == TYPEID_PLAYER)
        {
            if (!RemoveGuidValue(UNIT_FIELD_CHARM, charm->GetGUID()))
                LOG_FATAL("entities.unit", "Player {} is trying to uncharm unit {}, but it has another charmed unit {}", GetName(), charm->GetEntry(), GetCharmGUID().ToString());
        }

        if (!charm->RemoveGuidValue(UNIT_FIELD_CHARMEDBY, GetGUID()))
            LOG_FATAL("entities.unit", "Unit {} is being uncharmed, but it has another charmer {}", charm->GetEntry(), charm->GetCharmerGUID().ToString());

        if (charm->GetTypeId() == TYPEID_PLAYER)
        {
            charm->m_ControlledByPlayer = true;
            charm->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
            charm->ToPlayer()->UpdatePvPState();
        }
        else if (Player* player = charm->GetCharmerOrOwnerPlayerOrPlayerItself())
        {
            charm->m_ControlledByPlayer = true;
            charm->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
            charm->SetByteValue(UNIT_FIELD_BYTES_2, 1, player->GetByteValue(UNIT_FIELD_BYTES_2, 1));

            // Xinef: skip controlled erase if charmed unit is owned by charmer
            if (charm->IsInWorld() && !charm->IsDuringRemoveFromWorld() && player->GetGUID() == this->GetGUID() && (charm->IsPet() || charm->HasUnitTypeMask(UNIT_MASK_MINION)))
                return;
        }
        else
        {
            charm->m_ControlledByPlayer = false;
            charm->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
            charm->SetByteValue(UNIT_FIELD_BYTES_2, 1, 0);
        }

        if (charm->IsWalking() != _isWalkingBeforeCharm)
        {
            charm->SetWalk(_isWalkingBeforeCharm);
            charm->SendMovementFlagUpdate(true); // send packet to self, to update movement state on player.
        }

        m_Controlled.erase(charm);
    }
}

int32 Unit::DealHeal(Unit* healer, Unit* victim, uint32 addhealth)
{
    int32 gain = 0;

    if (healer)
    {
        if (victim->IsAIEnabled)
            victim->GetAI()->HealReceived(healer, addhealth);

        if (healer->IsAIEnabled)
            healer->GetAI()->HealDone(victim, addhealth);
    }

    if (addhealth)
        gain = victim->ModifyHealth(int32(addhealth));

    // Hook for OnHeal Event
    sScriptMgr->OnHeal(healer, victim, (uint32&)gain);

    Unit* unit = healer;

    if (healer && healer->GetTypeId() == TYPEID_UNIT && healer->ToCreature()->IsTotem())
        unit = healer->GetOwner();

    if (!unit)
        return gain;

    if (Player* player = unit->ToPlayer())
    {
        if (Battleground* bg = player->GetBattleground())
            bg->UpdatePlayerScore(player, SCORE_HEALING_DONE, gain);

        // use the actual gain, as the overheal shall not be counted, skip gain 0 (it ignored anyway in to criteria)
        if (gain && player->InBattleground()) // pussywizard: InBattleground() optimization
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HEALING_DONE, gain, 0, victim);

        //player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HEAL_CASTED, addhealth); // pussywizard: optimization
    }

    /*if (Player* player = victim->ToPlayer())
    {
        //player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_TOTAL_HEALING_RECEIVED, gain); // pussywizard: optimization
        //player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_HEALING_RECEIVED, addhealth); // pussywizard: optimization
    }*/

    return gain;
}

bool RedirectSpellEvent::Execute(uint64  /*e_time*/, uint32  /*p_time*/)
{
    if (Unit* auraOwner = ObjectAccessor::GetUnit(_self, _auraOwnerGUID))
    {
        // Xinef: already removed
        if (!auraOwner->HasAuraType(SPELL_AURA_SPELL_MAGNET))
            return true;

        Unit::AuraEffectList const& magnetAuras = auraOwner->GetAuraEffectsByType(SPELL_AURA_SPELL_MAGNET);
        for (Unit::AuraEffectList::const_iterator itr = magnetAuras.begin(); itr != magnetAuras.end(); ++itr)
            if (*itr == _auraEffect)
            {
                (*itr)->GetBase()->DropCharge(AURA_REMOVE_BY_DEFAULT);
                return true;
            }
    }

    return true;
}

Unit* Unit::GetMagicHitRedirectTarget(Unit* victim, SpellInfo const* spellInfo)
{
    // Patch 1.2 notes: Spell Reflection no longer reflects abilities
    if (spellInfo->HasAttribute(SPELL_ATTR0_IS_ABILITY) || spellInfo->HasAttribute(SPELL_ATTR1_NO_REDIRECTION) || spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES))
        return victim;

    Unit::AuraEffectList const& magnetAuras = victim->GetAuraEffectsByType(SPELL_AURA_SPELL_MAGNET);
    for (Unit::AuraEffectList::const_iterator itr = magnetAuras.begin(); itr != magnetAuras.end(); ++itr)
    {
        if (Unit* magnet = (*itr)->GetBase()->GetUnitOwner())
            if (spellInfo->CheckExplicitTarget(this, magnet) == SPELL_CAST_OK
                    //&& spellInfo->CheckTarget(this, magnet, false) == SPELL_CAST_OK
                    && _IsValidAttackTarget(magnet, spellInfo)
                    /*&& IsWithinLOSInMap(magnet)*/)
            {
                // Xinef: We should choose minimum between flight time and queue time as in reflect, however we dont know flight time at this point, use arbitrary small number
                magnet->m_Events.AddEvent(new RedirectSpellEvent(*magnet, victim->GetGUID(), *itr), magnet->m_Events.CalculateQueueTime(100));

                if (magnet->IsTotem())
                {
                    uint64 queueTime = magnet->m_Events.CalculateQueueTime(100);
                    if (spellInfo->Speed > 0.0f)
                    {
                        float dist = GetDistance(magnet->GetPositionX(), magnet->GetPositionY(), magnet->GetPositionZ());
                        if (dist < 5.0f)
                            dist = 5.0f;
                        queueTime = magnet->m_Events.CalculateTime((uint64)floor(dist / spellInfo->Speed * 1000.0f));
                    }

                    magnet->m_Events.AddEvent(new KillMagnetEvent(*magnet), queueTime);
                }

                return magnet;
            }
    }
    return victim;
}

Unit* Unit::GetMeleeHitRedirectTarget(Unit* victim, SpellInfo const* spellInfo)
{
    AuraEffectList const& hitTriggerAuras = victim->GetAuraEffectsByType(SPELL_AURA_ADD_CASTER_HIT_TRIGGER);
    for (AuraEffectList::const_iterator i = hitTriggerAuras.begin(); i != hitTriggerAuras.end(); ++i)
    {
        if (Unit* magnet = (*i)->GetBase()->GetCaster())
            if (_IsValidAttackTarget(magnet, spellInfo) && magnet->IsWithinLOSInMap(this)
                    && (!spellInfo || (spellInfo->CheckExplicitTarget(this, magnet) == SPELL_CAST_OK
                                       && spellInfo->CheckTarget(this, magnet, false) == SPELL_CAST_OK)))
                if (roll_chance_i((*i)->GetAmount()))
                {
                    (*i)->GetBase()->DropCharge(AURA_REMOVE_BY_EXPIRE);
                    return magnet;
                }
    }
    return victim;
}

Unit* Unit::GetFirstControlled() const
{
    // Sequence: charmed, pet, other guardians
    Unit* unit = GetCharm();
    if (!unit)
        if (ObjectGuid guid = GetMinionGUID())
            unit = ObjectAccessor::GetUnit(*this, guid);

    return unit;
}

void Unit::RemoveAllControlled(bool onDeath /*= false*/)
{
    // possessed pet and vehicle
    if (GetTypeId() == TYPEID_PLAYER)
        ToPlayer()->StopCastingCharm();

    while (!m_Controlled.empty())
    {
        Unit* target = *m_Controlled.begin();
        m_Controlled.erase(m_Controlled.begin());
        if (target->GetCharmerGUID() == GetGUID())
        {
            target->RemoveCharmAuras();
        }
        else if (target->GetOwnerGUID() == GetGUID() && target->IsSummon())
        {
            if (!(onDeath && !IsPlayer() && target->IsGuardian()))
            {
                target->ToTempSummon()->UnSummon();
            }
        }
        else
        {
            LOG_ERROR("entities.unit", "Unit {} is trying to release unit {} which is neither charmed nor owned by it", GetEntry(), target->GetEntry());
        }
    }
}

Unit* Unit::GetNextRandomRaidMemberOrPet(float radius)
{
    Player* player = nullptr;
    if (GetTypeId() == TYPEID_PLAYER)
        player = ToPlayer();
    // Should we enable this also for charmed units?
    else if (GetTypeId() == TYPEID_UNIT && IsPet())
        player = GetOwner()->ToPlayer();

    if (!player)
        return nullptr;
    Group* group = player->GetGroup();
    // When there is no group check pet presence
    if (!group)
    {
        // We are pet now, return owner
        if (player != this)
            return IsWithinDistInMap(player, radius) ? player : nullptr;
        Unit* pet = GetGuardianPet();
        // No pet, no group, nothing to return
        if (!pet)
            return nullptr;
        // We are owner now, return pet
        return IsWithinDistInMap(pet, radius) ? pet : nullptr;
    }

    std::vector<Unit*> nearMembers;
    // reserve place for players and pets because resizing vector every unit push is unefficient (vector is reallocated then)
    nearMembers.reserve(group->GetMembersCount() * 2);

    for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        if (Player* Target = itr->GetSource())
        {
            if (Target != this && !IsWithinDistInMap(Target, radius))
                continue;

            // IsHostileTo check duel and controlled by enemy
            if (Target != this && Target->IsAlive() && !IsHostileTo(Target))
                nearMembers.push_back(Target);

            // Push player's pet to vector
            if (Unit* pet = Target->GetGuardianPet())
                if (pet != this && pet->IsAlive() && IsWithinDistInMap(pet, radius) && !IsHostileTo(pet))
                    nearMembers.push_back(pet);
        }

    if (nearMembers.empty())
        return nullptr;

    uint32 randTarget = urand(0, nearMembers.size() - 1);
    return nearMembers[randTarget];
}

// only called in Player::SetSeer
// so move it to Player?
void Unit::AddPlayerToVision(Player* player)
{
    if (m_sharedVision.empty())
    {
        setActive(true);
        SetWorldObject(true);
    }
    m_sharedVision.push_back(player);
    player->m_isInSharedVisionOf.insert(this);
}

// only called in Player::SetSeer
void Unit::RemovePlayerFromVision(Player* player)
{
    m_sharedVision.remove(player);
    player->m_isInSharedVisionOf.erase(this);
    if (m_sharedVision.empty())
    {
        setActive(false);
        SetWorldObject(false);
    }
}

void Unit::RemoveBindSightAuras()
{
    RemoveAurasByType(SPELL_AURA_BIND_SIGHT);
}

void Unit::RemoveCharmAuras()
{
    RemoveAurasByType(SPELL_AURA_MOD_CHARM);
    RemoveAurasByType(SPELL_AURA_MOD_POSSESS_PET);
    RemoveAurasByType(SPELL_AURA_MOD_POSSESS);
    RemoveAurasByType(SPELL_AURA_AOE_CHARM);
}

void Unit::UnsummonAllTotems(bool onDeath /*= false*/)
{
    for (uint8 i = 0; i < MAX_SUMMON_SLOT; ++i)
    {
        if (!m_SummonSlot[i])
        {
            continue;
        }

        if (Creature* OldTotem = GetMap()->GetCreature(m_SummonSlot[i]))
        {
            if (OldTotem->IsSummon())
            {
                if (!(onDeath && !IsPlayer() && OldTotem->IsGuardian()))
                {
                    OldTotem->ToTempSummon()->UnSummon();
                }
            }
        }
    }
}

void Unit::SendHealSpellLog(HealInfo const& healInfo, bool critical)
{
    uint32 overheal = healInfo.GetHeal() - healInfo.GetEffectiveHeal();

    // we guess size
    WorldPacket data(SMSG_SPELLHEALLOG, (8 + 8 + 4 + 4 + 4 + 4 + 1 + 1));
    data << healInfo.GetTarget()->GetPackGUID();
    data << GetPackGUID();
    data << uint32(healInfo.GetSpellInfo()->Id);
    data << uint32(healInfo.GetHeal());
    data << uint32(overheal);
    data << uint32(healInfo.GetAbsorb()); // Absorb amount
    data << uint8(critical ? 1 : 0);
    data << uint8(0); // unused
    SendMessageToSet(&data, true);
}

int32 Unit::HealBySpell(HealInfo& healInfo, bool critical)
{
    uint32 heal = healInfo.GetHeal();
    sScriptMgr->ModifyHealReceived(this, healInfo.GetTarget(), heal, healInfo.GetSpellInfo());
    healInfo.SetHeal(heal);

    // calculate heal absorb and reduce healing
    CalcHealAbsorb(healInfo);

    int32 gain = Unit::DealHeal(healInfo.GetHealer(), healInfo.GetTarget(), healInfo.GetHeal());
    healInfo.SetEffectiveHeal(gain);

    SendHealSpellLog(healInfo, critical);
    return gain;
}

void Unit::SendEnergizeSpellLog(Unit* victim, uint32 spellID, uint32 damage, Powers powerType)
{
    WorldPacket data(SMSG_SPELLENERGIZELOG, (8 + 8 + 4 + 4 + 4 + 1));
    data << victim->GetPackGUID();
    data << GetPackGUID();
    data << uint32(spellID);
    data << uint32(powerType);
    data << uint32(damage);
    SendMessageToSet(&data, true);
}

void Unit::EnergizeBySpell(Unit* victim, uint32 spellID, uint32 damage, Powers powerType)
{
    int32 gainedPower = victim->ModifyPower(powerType, damage, false);

    if (powerType != POWER_HAPPINESS && gainedPower)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellID);
        victim->getHostileRefMgr().threatAssist(this, float(gainedPower) * 0.5f, spellInfo);
    }

    SendEnergizeSpellLog(victim, spellID, damage, powerType);
}

float Unit::SpellPctDamageModsDone(Unit* victim, SpellInfo const* spellProto, DamageEffectType damagetype)
{
    if (!spellProto || !victim || damagetype == DIRECT_DAMAGE)
        return 1.0f;

    // Some spells don't benefit from done mods
    if (spellProto->HasAttribute(SPELL_ATTR3_IGNORE_CASTER_MODIFIERS))
        return 1.0f;

    // For totems get damage bonus from owner
    if (GetTypeId() == TYPEID_UNIT)
    {
        if (IsTotem())
        {
            if (Unit* owner = GetOwner())
                return owner->SpellPctDamageModsDone(victim, spellProto, damagetype);
        }
        // Dancing Rune Weapon...
        else if (GetEntry() == 27893)
        {
            if (Unit* owner = GetOwner())
                return owner->SpellPctDamageModsDone(victim, spellProto, damagetype);
        }
    }

    // Done total percent damage auras
    float DoneTotalMod = 1.0f;

    AuraEffectList const& mModDamagePercentDone = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    for (AuraEffectList::const_iterator i = mModDamagePercentDone.begin(); i != mModDamagePercentDone.end(); ++i)
    {
        // prevent apply mods from weapon specific case to non weapon specific spells (Example: thunder clap and two-handed weapon specialization)
        if (spellProto->EquippedItemClass == -1 && (*i)->GetSpellInfo()->EquippedItemClass != -1 &&
            !(*i)->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPED_ITEM) && (*i)->GetMiscValue() == SPELL_SCHOOL_MASK_NORMAL)
        {
            continue;
        }

        if (!spellProto->ValidateAttribute6SpellDamageMods(this, *i, damagetype == DOT))
            continue;

        if (!sScriptMgr->IsNeedModSpellDamagePercent(this, *i, DoneTotalMod, spellProto))
            continue;

        if ((*i)->GetMiscValue() & spellProto->GetSchoolMask())
        {
            if ((*i)->GetSpellInfo()->EquippedItemClass == -1)
                AddPct(DoneTotalMod, (*i)->GetAmount());
            else if (!(*i)->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPED_ITEM) && ((*i)->GetSpellInfo()->EquippedItemSubClassMask == 0))
                AddPct(DoneTotalMod, (*i)->GetAmount());
            else if (ToPlayer() && ToPlayer()->HasItemFitToSpellRequirements((*i)->GetSpellInfo()))
                AddPct(DoneTotalMod, (*i)->GetAmount());
        }
    }

    uint32 creatureTypeMask = victim->GetCreatureTypeMask();
    AuraEffectList const& mDamageDoneVersus = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS);
    for (AuraEffectList::const_iterator i = mDamageDoneVersus.begin(); i != mDamageDoneVersus.end(); ++i)
        if ((creatureTypeMask & uint32((*i)->GetMiscValue())) && spellProto->ValidateAttribute6SpellDamageMods(this, *i, damagetype == DOT))
            AddPct(DoneTotalMod, (*i)->GetAmount());

    // bonus against aurastate
    AuraEffectList const& mDamageDoneVersusAurastate = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS_AURASTATE);
    for (AuraEffectList::const_iterator i = mDamageDoneVersusAurastate.begin(); i != mDamageDoneVersusAurastate.end(); ++i)
        if (victim->HasAuraState(AuraStateType((*i)->GetMiscValue())) && spellProto->ValidateAttribute6SpellDamageMods(this, *i, damagetype == DOT))
            AddPct(DoneTotalMod, (*i)->GetAmount());

    // done scripted mod (take it from owner)
    Unit* owner = GetOwner() ? GetOwner() : this;
    AuraEffectList const& mOverrideClassScript = owner->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    for (AuraEffectList::const_iterator i = mOverrideClassScript.begin(); i != mOverrideClassScript.end(); ++i)
    {
        // Xinef: self cast is ommited (because of Rage of Rivendare)
        if (!spellProto->ValidateAttribute6SpellDamageMods(this, *i, damagetype == DOT))
            continue;

        // xinef: Molten Fury should work on all spells
        switch ((*i)->GetMiscValue())
        {
            case 4920: // Molten Fury
            case 4919:
                if (victim->HasAuraState(AURA_STATE_HEALTHLESS_35_PERCENT, spellProto, this))
                    AddPct(DoneTotalMod, (*i)->GetAmount());
                break;
        }

        if (!(*i)->IsAffectedOnSpell(spellProto))
            continue;

        switch ((*i)->GetMiscValue())
        {
            case 6917: // Death's Embrace
            case 6926:
            case 6928:
                {
                    if (victim->HasAuraState(AURA_STATE_HEALTHLESS_35_PERCENT, spellProto, this))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    break;
                }
            // Soul Siphon
            case 4992:
            case 4993:
                {
                    // effect 1 m_amount
                    int32 maxPercent = (*i)->GetAmount();
                    // effect 0 m_amount
                    int32 stepPercent = CalculateSpellDamage(this, (*i)->GetSpellInfo(), 0);
                    // count affliction effects and calc additional damage in percentage
                    int32 modPercent = 0;
                    AuraApplicationMap const& victimAuras = victim->GetAppliedAuras();
                    for (AuraApplicationMap::const_iterator itr = victimAuras.begin(); itr != victimAuras.end(); ++itr)
                    {
                        Aura const* aura = itr->second->GetBase();
                        SpellInfo const* m_spell = aura->GetSpellInfo();
                        if (m_spell->SpellFamilyName != SPELLFAMILY_WARLOCK || !(m_spell->SpellFamilyFlags[1] & 0x0004071B || m_spell->SpellFamilyFlags[0] & 0x8044C402))
                            continue;
                        modPercent += stepPercent * aura->GetStackAmount();
                        if (modPercent >= maxPercent)
                        {
                            modPercent = maxPercent;
                            break;
                        }
                    }
                    AddPct(DoneTotalMod, modPercent);
                    break;
                }
            case 6916: // Death's Embrace
            case 6925:
            case 6927:
                if (HasAuraState(AURA_STATE_HEALTHLESS_20_PERCENT, spellProto, this))
                    AddPct(DoneTotalMod, (*i)->GetAmount());
                break;
            case 5481: // Starfire Bonus
                {
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_DRUID, 0x200002, 0, 0))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    break;
                }
            // Tundra Stalker
            // Merciless Combat
            case 7277:
                {
                    // Merciless Combat
                    if ((*i)->GetSpellInfo()->SpellIconID == 2656)
                    {
                        if( (spellProto && spellProto->SpellFamilyFlags[0] & 0x2) || spellProto->SpellFamilyFlags[1] & 0x2 )
                            if (!victim->HealthAbovePct(35))
                                AddPct(DoneTotalMod, (*i)->GetAmount());
                    }
                    // Tundra Stalker
                    else
                    {
                        // Frost Fever (target debuff)
                        if (victim->HasAura(55095))
                            AddPct(DoneTotalMod, (*i)->GetAmount());
                        break;
                    }
                    break;
                }
            // Rage of Rivendare
            case 7293:
                {
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_DEATHKNIGHT, 0, 0x02000000, 0))
                        AddPct(DoneTotalMod, (*i)->GetSpellInfo()->GetRank() * 2.0f);
                    break;
                }
            // Twisted Faith
            case 7377:
                {
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_PRIEST, 0x8000, 0, 0, GetGUID()))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    break;
                }
            // Marked for Death
            case 7598:
            case 7599:
            case 7600:
            case 7601:
            case 7602:
                {
                    if (victim->GetAuraEffect(SPELL_AURA_MOD_STALKED, SPELLFAMILY_HUNTER, 0x400, 0, 0))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    break;
                }
            // Dirty Deeds
            case 6427:
            case 6428:
            case 6579:
            case 6580:
                {
                    if (victim->HasAuraState(AURA_STATE_HEALTHLESS_35_PERCENT, spellProto, this))
                    {
                        // effect 0 has expected value but in negative state
                        int32 bonus = -(*i)->GetBase()->GetEffect(0)->GetAmount();
                        AddPct(DoneTotalMod, bonus);
                    }
                    break;
                }
        }
    }

    // Custom scripted damage
    switch (spellProto->SpellFamilyName)
    {
        case SPELLFAMILY_MAGE:
            // Ice Lance
            if (spellProto->SpellIconID == 186)
            {
                if (victim->HasAuraState(AURA_STATE_FROZEN, spellProto, this))
                {
                    // Glyph of Ice Lance
                    if (owner->HasAura(56377) && victim->GetLevel() > owner->GetLevel())
                        DoneTotalMod *= 4.0f;
                    else
                        DoneTotalMod *= 3.0f;
                }
            }

            // Torment the weak
            if (spellProto->SpellFamilyFlags[0] & 0x20600021 || spellProto->SpellFamilyFlags[1] & 0x9000)
                if (victim->HasAuraWithMechanic((1 << MECHANIC_SNARE) | (1 << MECHANIC_SLOW_ATTACK)))
                    if (AuraEffect* aurEff = GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_GENERIC, 3263, EFFECT_0))
                        AddPct(DoneTotalMod, aurEff->GetAmount());
            break;
        case SPELLFAMILY_PRIEST:
            // Mind Flay
            if (spellProto->SpellFamilyFlags[0] & 0x800000)
            {
                // Glyph of Shadow Word: Pain
                if (AuraEffect* aurEff = GetAuraEffect(55687, 0))
                    // Increase Mind Flay damage if Shadow Word: Pain present on target
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_PRIEST, 0x8000, 0, 0, GetGUID()))
                        AddPct(DoneTotalMod, aurEff->GetAmount());

                // Twisted Faith - Mind Flay part
                if (AuraEffect* aurEff = GetAuraEffect(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS, SPELLFAMILY_PRIEST, 2848, 1))
                    // Increase Mind Flay damage if Shadow Word: Pain present on target
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_PRIEST, 0x8000, 0, 0, GetGUID()))
                        AddPct(DoneTotalMod, aurEff->GetAmount());
            }
            // Smite
            else if (spellProto->SpellFamilyFlags[0] & 0x80)
            {
                // Glyph of Smite
                if (AuraEffect* aurEff = GetAuraEffect(55692, 0))
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_PRIEST, 0x100000, 0, 0, GetGUID()))
                        AddPct(DoneTotalMod, aurEff->GetAmount());
            }
            // Shadow Word: Death
            else if (spellProto->SpellFamilyFlags[1] & 0x2)
            {
                // Glyph of Shadow Word: Death
                if (AuraEffect* aurEff = GetAuraEffect(55682, 1))
                    if (victim->HasAuraState(AURA_STATE_HEALTHLESS_35_PERCENT))
                        AddPct(DoneTotalMod, aurEff->GetAmount());
            }

            break;
        case SPELLFAMILY_PALADIN:
            // Judgement of Vengeance/Judgement of Corruption
            if ((spellProto->SpellFamilyFlags[1] & 0x400000) && spellProto->SpellIconID == 2292)
            {
                // Get stack of Holy Vengeance/Blood Corruption on the target added by caster
                uint32 stacks = 0;
                Unit::AuraEffectList const& auras = victim->GetAuraEffectsByType(SPELL_AURA_PERIODIC_DAMAGE);
                for (Unit::AuraEffectList::const_iterator itr = auras.begin(); itr != auras.end(); ++itr)
                    if (((*itr)->GetId() == 31803 || (*itr)->GetId() == 53742) && (*itr)->GetCasterGUID() == GetGUID())
                    {
                        stacks = (*itr)->GetBase()->GetStackAmount();
                        break;
                    }
                // + 10% for each application of Holy Vengeance/Blood Corruption on the target
                if (stacks)
                    AddPct(DoneTotalMod, 10 * stacks);
            }
            break;
        case SPELLFAMILY_DRUID:
            // Thorns
            if (spellProto->SpellFamilyFlags[0] & 0x100)
            {
                // Brambles
                if (AuraEffect* aurEff = GetAuraEffectOfRankedSpell(16836, 0))
                    AddPct(DoneTotalMod, aurEff->GetAmount());
            }
            break;
        case SPELLFAMILY_WARLOCK:
            // Fire and Brimstone
            if (spellProto->SpellFamilyFlags[1] & 0x00020040)
                if (victim->HasAuraState(AURA_STATE_CONFLAGRATE))
                {
                    AuraEffectList const& mDumyAuras = GetAuraEffectsByType(SPELL_AURA_DUMMY);
                    for (AuraEffectList::const_iterator i = mDumyAuras.begin(); i != mDumyAuras.end(); ++i)
                        if ((*i)->GetSpellInfo()->SpellIconID == 3173)
                        {
                            AddPct(DoneTotalMod, (*i)->GetAmount());
                            break;
                        }
                }
            // Drain Soul - increased damage for targets under 25 % HP
            if (spellProto->SpellFamilyFlags[0] & 0x00004000)
                if (!victim->HealthAbovePct(25))
                    DoneTotalMod *= 4;
            // Shadow Bite (15% increase from each dot)
            if (spellProto->SpellFamilyFlags[1] & 0x00400000 && IsPet())
                if (uint8 count = victim->GetDoTsByCaster(GetOwnerGUID()))
                    AddPct(DoneTotalMod, 15 * count);
            break;
        case SPELLFAMILY_HUNTER:
            // Steady Shot
            if (spellProto->SpellFamilyFlags[1] & 0x1)
                if (AuraEffect* aurEff = GetAuraEffect(56826, 0))  // Glyph of Steady Shot
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_HUNTER, 0x00004000, 0, 0, GetGUID()))
                        AddPct(DoneTotalMod, aurEff->GetAmount());
            break;
        case SPELLFAMILY_DEATHKNIGHT:
            // Improved Icy Touch
            if (spellProto->SpellFamilyFlags[0] & 0x2)
                if (AuraEffect* aurEff = GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 2721, 0))
                    AddPct(DoneTotalMod, aurEff->GetAmount());

            // Glacier Rot
            if (spellProto->SpellFamilyFlags[0] & 0x2 || spellProto->SpellFamilyFlags[1] & 0x6)
                if (AuraEffect* aurEff = GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 196, 0))
                    if (victim->GetDiseasesByCaster(owner->GetGUID()) > 0)
                        AddPct(DoneTotalMod, aurEff->GetAmount());
            break;
    }

    return DoneTotalMod;
}

uint32 Unit::SpellDamageBonusDone(Unit* victim, SpellInfo const* spellProto, uint32 pdamage, DamageEffectType damagetype, uint8 effIndex, float TotalMod, uint32 stack)
{
    if (!spellProto || !victim || damagetype == DIRECT_DAMAGE)
        return pdamage;

    // Some spells don't benefit from done mods
    if (spellProto->HasAttribute(SPELL_ATTR3_IGNORE_CASTER_MODIFIERS))
        return pdamage;

    // For totems get damage bonus from owner
    if (GetTypeId() == TYPEID_UNIT)
    {
        if (IsTotem())
        {
            if (Unit* owner = GetOwner())
                return owner->SpellDamageBonusDone(victim, spellProto, pdamage, damagetype, effIndex, TotalMod, stack);
        }
        // Dancing Rune Weapon...
        else if (GetEntry() == 27893)
        {
            if (Unit* owner = GetOwner())
                return owner->SpellDamageBonusDone(victim, spellProto, pdamage, damagetype, TotalMod, stack) / 2;
        }
    }

    // Done total percent damage auras
    float ApCoeffMod = 1.0f;
    int32 DoneTotal = 0;
    float DoneTotalMod = TotalMod ? TotalMod : SpellPctDamageModsDone(victim, spellProto, damagetype);

    // Config : RATE_CREATURE_X_SPELLDAMAGE & Do Not Modify Pet/Guardian/Mind Controled Damage
    if (GetTypeId() == TYPEID_UNIT && (!ToCreature()->IsPet() || !ToCreature()->IsGuardian() || !ToCreature()->IsControlledByPlayer()))
        DoneTotalMod *= ToCreature()->GetSpellDamageMod(ToCreature()->GetCreatureTemplate()->rank);

    // Some spells don't benefit from pct done mods
    if (!spellProto->HasAttribute(SPELL_ATTR6_IGNORE_CASTER_DAMAGE_MODIFIERS))
    {
        uint32 creatureTypeMask = victim->GetCreatureTypeMask();
        // Add flat bonus from spell damage versus
        DoneTotal += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_FLAT_SPELL_DAMAGE_VERSUS, creatureTypeMask);
    }

    // done scripted mod (take it from owner)
    Unit* owner = GetOwner() ? GetOwner() : this;
    int32 DoneAdvertisedBenefit = 0;
    AuraEffectList const& mOverrideClassScript = owner->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    for (AuraEffectList::const_iterator i = mOverrideClassScript.begin(); i != mOverrideClassScript.end(); ++i)
    {
        if (!(*i)->IsAffectedOnSpell(spellProto))
            continue;

        switch ((*i)->GetMiscValue())
        {
            case 4418: // Increased Shock Damage
            case 4554: // Increased Lightning Damage
            case 4555: // Improved Moonfire
            case 5142: // Increased Lightning Damage
            case 5147: // Improved Consecration / Libram of Resurgence
            case 5148: // Idol of the Shooting Star
            case 6008: // Increased Lightning Damage
            case 8627: // Totem of Hex
            {
                DoneAdvertisedBenefit += (*i)->GetAmount();
                break;
            }
        }
    }

    // Custom scripted damage
    switch (spellProto->SpellFamilyName)
    {
        case SPELLFAMILY_DRUID:
        {
            // Insect Swarm vs Item - Druid T8 Balance Relic
            if (spellProto->SpellFamilyFlags[0] & 0x00200000)
            {
                if (AuraEffect const* relicAurEff = GetAuraEffect(64950, EFFECT_0))
                {
                    DoneAdvertisedBenefit += relicAurEff->GetAmount();
                }
            }

            // Nourish vs Idol of the Flourishing Life
            if (spellProto->SpellFamilyFlags[1] & 0x02000000)
            {
                if (AuraEffect const* relicAurEff = GetAuraEffect(64949, EFFECT_0))
                {
                    DoneAdvertisedBenefit += relicAurEff->GetAmount();
                }
            }
            break;
        }
        case SPELLFAMILY_DEATHKNIGHT:
        {
            // Sigil of the Vengeful Heart
            if (spellProto->SpellFamilyFlags[0] & 0x2000)
            {
                if (AuraEffect* aurEff = GetAuraEffect(64962, EFFECT_1))
                {
                    AddPct(DoneTotal, aurEff->GetAmount());
                }
            }

            // Impurity
            if (AuraEffect* aurEff = GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 1986, 0))
            {
                AddPct(ApCoeffMod, aurEff->GetAmount());
            }

            // Blood Boil - bonus for diseased targets
            if ((spellProto->SpellFamilyFlags[0] & 0x00040000) && victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_DEATHKNIGHT, 0, 0, 0x00000002, GetGUID()))
            {
                DoneTotal += 95;
                ApCoeffMod = 1.5835f;
            }
            break;
        }
        default:
            break;
    }

    // Done fixed damage bonus auras
    DoneAdvertisedBenefit += SpellBaseDamageBonusDone(spellProto->GetSchoolMask());

    // Check for table values
    float coeff = spellProto->Effects[effIndex].BonusMultiplier;
    SpellBonusEntry const* bonus = sSpellMgr->GetSpellBonusData(spellProto->Id);
    if (bonus)
    {
        if (damagetype == DOT)
        {
            coeff = bonus->dot_damage;
            if (bonus->ap_dot_bonus > 0)
            {
                WeaponAttackType attType = (spellProto->IsRangedWeaponSpell() && spellProto->DmgClass != SPELL_DAMAGE_CLASS_MELEE) ? RANGED_ATTACK : BASE_ATTACK;
                float APbonus = float(victim->GetTotalAuraModifier(attType == BASE_ATTACK ? SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS : SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS));
                APbonus += GetTotalAttackPowerValue(attType);
                DoneTotal += int32(bonus->ap_dot_bonus * stack * ApCoeffMod * APbonus);
            }
        }
        else
        {
            coeff = bonus->direct_damage;
            if (bonus->ap_bonus > 0)
            {
                WeaponAttackType attType = (spellProto->IsRangedWeaponSpell() && spellProto->DmgClass != SPELL_DAMAGE_CLASS_MELEE) ? RANGED_ATTACK : BASE_ATTACK;
                float APbonus = float(victim->GetTotalAuraModifier(attType == BASE_ATTACK ? SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS : SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS));
                APbonus += GetTotalAttackPowerValue(attType);
                DoneTotal += int32(bonus->ap_bonus * stack * ApCoeffMod * APbonus);
            }
        }
    }

    // Default calculation
    if (coeff && DoneAdvertisedBenefit)
    {
        float factorMod = CalculateLevelPenalty(spellProto) * stack;

        if (Player* modOwner = GetSpellModOwner())
        {
            coeff *= 100.0f;
            modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_BONUS_MULTIPLIER, coeff);
            coeff /= 100.0f;
        }

        DoneTotal += int32(DoneAdvertisedBenefit * coeff * factorMod);
    }

    float tmpDamage = (float(pdamage) + DoneTotal) * DoneTotalMod;
    // apply spellmod to Done damage (flat and pct)
    if (Player* modOwner = GetSpellModOwner())
        modOwner->ApplySpellMod(spellProto->Id, damagetype == DOT ? SPELLMOD_DOT : SPELLMOD_DAMAGE, tmpDamage);

    return uint32(std::max(tmpDamage, 0.0f));
}

uint32 Unit::SpellDamageBonusTaken(Unit* caster, SpellInfo const* spellProto, uint32 pdamage, DamageEffectType damagetype, uint32 stack)
{
    if (!spellProto || damagetype == DIRECT_DAMAGE)
        return pdamage;

    int32 TakenTotal = 0;
    float TakenTotalMod = 1.0f;

    // from positive and negative SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN
    // multiplicative bonus, for example Dispersion + Shadowform (0.10*0.85=0.085)
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN);
    for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        if (((*i)->GetMiscValue() & spellProto->GetSchoolMask()))
            if (spellProto->ValidateAttribute6SpellDamageMods(caster, *i, damagetype == DOT))
                AddPct(TakenTotalMod, (*i)->GetAmount());

    TakenTotalMod = processDummyAuras(TakenTotalMod);

    // From caster spells
    if (caster)
    {
        AuraEffectList const& mOwnerTaken = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_FROM_CASTER);
        for (AuraEffectList::const_iterator i = mOwnerTaken.begin(); i != mOwnerTaken.end(); ++i)
            if ((*i)->GetCasterGUID() == caster->GetGUID() && (*i)->IsAffectedOnSpell(spellProto))
                if (spellProto->ValidateAttribute6SpellDamageMods(caster, *i, damagetype == DOT))
                    AddPct(TakenTotalMod, (*i)->GetAmount());
    }

    if (uint32 mechanicMask = spellProto->GetAllEffectsMechanicMask())
    {
        int32 modifierMax = 0;
        int32 modifierMin = 0;
        AuraEffectList const& auraEffectList = GetAuraEffectsByType(SPELL_AURA_MOD_MECHANIC_DAMAGE_TAKEN_PERCENT);
        for (AuraEffectList::const_iterator i = auraEffectList.begin(); i != auraEffectList.end(); ++i)
        {
            if (!spellProto->ValidateAttribute6SpellDamageMods(caster, *i, damagetype == DOT))
                continue;

            // Only death knight spell with this aura
            if ((*i)->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT)
                if (!caster || caster->GetGUID() != (*i)->GetCasterGUID())
                    continue;

            if (mechanicMask & uint32(1 << (*i)->GetMiscValue()))
            {
                if ((*i)->GetAmount() > 0)
                {
                    if ((*i)->GetAmount() > modifierMax)
                        modifierMax = (*i)->GetAmount();
                }
                else if ((*i)->GetAmount() < modifierMin)
                    modifierMin = (*i)->GetAmount();
            }
        }

        AddPct(TakenTotalMod, modifierMax);
        AddPct(TakenTotalMod, modifierMin);
    }

    int32 TakenAdvertisedBenefit = SpellBaseDamageBonusTaken(spellProto->GetSchoolMask(), damagetype == DOT);

    // Check for table values
    float coeff = 0;
    SpellBonusEntry const* bonus = sSpellMgr->GetSpellBonusData(spellProto->Id);
    if (bonus)
        coeff = (damagetype == DOT) ? bonus->dot_damage : bonus->direct_damage;

    // Default calculation
    if (TakenAdvertisedBenefit)
    {
        if (coeff <= 0.0f)
        {
            if (caster)
                coeff = caster->CalculateDefaultCoefficient(spellProto, damagetype) * int32(stack);
            else
                coeff = CalculateDefaultCoefficient(spellProto, damagetype) * int32(stack);
        }

        float factorMod = CalculateLevelPenalty(spellProto) * stack;
        TakenTotal += int32(TakenAdvertisedBenefit * coeff * factorMod);
    }

    // No positive taken bonus, custom attr
    if (spellProto->HasAttribute(SPELL_ATTR0_CU_NO_POSITIVE_TAKEN_BONUS) && TakenTotalMod > 1.0f)
    {
        TakenTotal = 0;
        TakenTotalMod = 1.0f;
    }

    // xinef: sanctified wrath talent
    if (caster && TakenTotalMod < 1.0f && caster->HasAuraType(SPELL_AURA_MOD_IGNORE_TARGET_RESIST))
    {
        float ignoreModifier = 1.0f - TakenTotalMod;
        bool addModifier = false;
        AuraEffectList const& ResIgnoreAuras = caster->GetAuraEffectsByType(SPELL_AURA_MOD_IGNORE_TARGET_RESIST);
        for (AuraEffectList::const_iterator j = ResIgnoreAuras.begin(); j != ResIgnoreAuras.end(); ++j)
            if ((*j)->GetMiscValue() & spellProto->SchoolMask)
            {
                ApplyPct(ignoreModifier, (*j)->GetAmount());
                addModifier = true;
            }

        if (addModifier)
            TakenTotalMod += ignoreModifier;
    }

    float tmpDamage = (float(pdamage) + TakenTotal) * TakenTotalMod;

    return uint32(std::max(tmpDamage, 0.0f));
}

float Unit::processDummyAuras(float TakenTotalMod) const
{
    // note: old code coming from TC, just extracted here to remove the code duplication + solve potential crash
    // see: https://github.com/TrinityCore/TrinityCore/commit/c85710e148d75450baedf6632b9ca6fd40b4148e

    // .. taken pct: dummy auras
    auto const& mDummyAuras = GetAuraEffectsByType(SPELL_AURA_DUMMY);
    for (auto i = mDummyAuras.begin(); i != mDummyAuras.end(); ++i)
    {
        if (!(*i) || !(*i)->GetSpellInfo())
        {
            continue;
        }

        if (auto spellIconId = (*i)->GetSpellInfo()->SpellIconID)
        {
            switch (spellIconId)
            {
                // Cheat Death
                case 2109:
                    if ((*i)->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL)
                    {
                        // Patch 2.4.3: The resilience required to reach the 90% damage reduction cap
                        //  is 22.5% critical strike damage reduction, or 444 resilience.
                        // To calculate for 90%, we multiply the 100% by 4 (22.5% * 4 = 90%)
                        float mod = -1.0f * GetMeleeCritDamageReduction(400);
                        AddPct(TakenTotalMod, std::max(mod, float((*i)->GetAmount())));
                    }
                    break;
            }
        }
    }
    return TakenTotalMod;
}

int32 Unit::SpellBaseDamageBonusDone(SpellSchoolMask schoolMask)
{
    int32 DoneAdvertisedBenefit = 0;

    AuraEffectList const& mDamageDone = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE);
    for (AuraEffectList::const_iterator i = mDamageDone.begin(); i != mDamageDone.end(); ++i)
        if (((*i)->GetMiscValue() & schoolMask) != 0 &&
                (*i)->GetSpellInfo()->EquippedItemClass == -1 &&
                // -1 == any item class (not wand then)
                (*i)->GetSpellInfo()->EquippedItemInventoryTypeMask == 0)
            // 0 == any inventory type (not wand then)
            DoneAdvertisedBenefit += (*i)->GetAmount();

    if (GetTypeId() == TYPEID_PLAYER)
    {
        // Base value
        DoneAdvertisedBenefit += ToPlayer()->GetBaseSpellPowerBonus();

        // Damage bonus from stats
        AuraEffectList const& mDamageDoneOfStatPercent = GetAuraEffectsByType(SPELL_AURA_MOD_SPELL_DAMAGE_OF_STAT_PERCENT);
        for (AuraEffectList::const_iterator i = mDamageDoneOfStatPercent.begin(); i != mDamageDoneOfStatPercent.end(); ++i)
        {
            if ((*i)->GetMiscValue() & schoolMask)
            {
                // stat used stored in miscValueB for this aura
                Stats usedStat = Stats((*i)->GetMiscValueB());
                DoneAdvertisedBenefit += int32(CalculatePct(GetStat(usedStat), (*i)->GetAmount()));
            }
        }
        // ... and attack power
        AuraEffectList const& mDamageDonebyAP = GetAuraEffectsByType(SPELL_AURA_MOD_SPELL_DAMAGE_OF_ATTACK_POWER);
        for (AuraEffectList::const_iterator i = mDamageDonebyAP.begin(); i != mDamageDonebyAP.end(); ++i)
            if ((*i)->GetMiscValue() & schoolMask)
                DoneAdvertisedBenefit += int32(CalculatePct(GetTotalAttackPowerValue(BASE_ATTACK), (*i)->GetAmount()));
    }
    return DoneAdvertisedBenefit;
}

int32 Unit::SpellBaseDamageBonusTaken(SpellSchoolMask schoolMask, bool isDoT)
{
    int32 TakenAdvertisedBenefit = 0;

    AuraEffectList const& mDamageTaken = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_TAKEN);
    for (AuraEffectList::const_iterator i = mDamageTaken.begin(); i != mDamageTaken.end(); ++i)
        if (((*i)->GetMiscValue() & schoolMask) != 0)
        {
            // Xinef: if we have DoT damage type and aura has charges, check if it affects DoTs
            // Xinef: required for hemorrhage & rupture / garrote
            if (isDoT && (*i)->GetBase()->IsUsingCharges() && !((*i)->GetSpellInfo()->ProcFlags & PROC_FLAG_TAKEN_PERIODIC))
                continue;

            TakenAdvertisedBenefit += (*i)->GetAmount();
        }

    return TakenAdvertisedBenefit;
}

float Unit::SpellDoneCritChance(Unit const* /*victim*/, SpellInfo const* spellProto, SpellSchoolMask schoolMask, WeaponAttackType attackType, bool skipEffectCheck) const
{
    // Mobs can't crit with spells.
    if (GetTypeId() == TYPEID_UNIT && !GetSpellModOwner())
        return -100.0f;

    // not critting spell
    if (spellProto->HasAttribute(SPELL_ATTR2_CANT_CRIT))
        return 0.0f;

    // Xinef: check if spell is capable of critting, auras requires special aura to crit so they can be skipped
    if (!skipEffectCheck && !spellProto->IsCritCapable())
        return 0.0f;

    float crit_chance = 0.0f;
    switch (spellProto->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_MAGIC:
            {
                if (schoolMask & SPELL_SCHOOL_MASK_NORMAL)
                    crit_chance = 0.0f;
                // For other schools
                else if (GetTypeId() == TYPEID_PLAYER)
                    crit_chance = GetFloatValue(static_cast<uint16>(PLAYER_SPELL_CRIT_PERCENTAGE1) + GetFirstSchoolInMask(schoolMask));
                else
                {
                    crit_chance = (float)m_baseSpellCritChance;
                    crit_chance += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_SPELL_CRIT_CHANCE_SCHOOL, schoolMask);
                }
                break;
            }
        case SPELL_DAMAGE_CLASS_MELEE:
        case SPELL_DAMAGE_CLASS_RANGED:
            {
                if (GetTypeId() == TYPEID_PLAYER)
                {
                    switch (attackType)
                    {
                        case BASE_ATTACK:
                            crit_chance = GetFloatValue(PLAYER_CRIT_PERCENTAGE);
                            break;
                        case OFF_ATTACK:
                            crit_chance = GetFloatValue(PLAYER_OFFHAND_CRIT_PERCENTAGE);
                            break;
                        case RANGED_ATTACK:
                            crit_chance = GetFloatValue(PLAYER_RANGED_CRIT_PERCENTAGE);
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    crit_chance = 5.0f;
                    crit_chance += GetTotalAuraModifier(SPELL_AURA_MOD_WEAPON_CRIT_PERCENT);
                    crit_chance += GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_PCT);
                }
                crit_chance += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_SPELL_CRIT_CHANCE_SCHOOL, schoolMask);
                break;
            }
        // values overridden in spellmgr for lifebloom and earth shield
        case SPELL_DAMAGE_CLASS_NONE:
        default:
            return 0.0f;
    }

    // percent done
    // only players use intelligence for critical chance computations
    if (Player* modOwner = GetSpellModOwner())
        modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_CRITICAL_CHANCE, crit_chance);

    // xinef: can be negative!
    return crit_chance;
}

float Unit::SpellTakenCritChance(Unit const* caster, SpellInfo const* spellProto, SpellSchoolMask schoolMask, float doneChance, WeaponAttackType attackType, bool skipEffectCheck) const
{
    // not critting spell
    if (spellProto->HasAttribute(SPELL_ATTR2_CANT_CRIT))
        return 0.0f;

    // Xinef: check if spell is capable of critting, auras requires special aura to crit so they can be skipped
    if (!skipEffectCheck && !spellProto->IsCritCapable())
        return 0.0f;

    float crit_chance = doneChance;
    switch (spellProto->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_MAGIC:
            {
                if (!spellProto->IsPositive())
                {
                    // Modify critical chance by victim SPELL_AURA_MOD_ATTACKER_SPELL_CRIT_CHANCE
                    // xinef: apply max and min only
                    if (HasAuraType(SPELL_AURA_MOD_ATTACKER_SPELL_CRIT_CHANCE))
                    {
                        crit_chance += GetMaxNegativeAuraModifierByMiscMask(SPELL_AURA_MOD_ATTACKER_SPELL_CRIT_CHANCE, schoolMask);
                        crit_chance += GetMaxPositiveAuraModifierByMiscMask(SPELL_AURA_MOD_ATTACKER_SPELL_CRIT_CHANCE, schoolMask);
                    }

                    Unit::ApplyResilience(this, &crit_chance, nullptr, false, CR_CRIT_TAKEN_SPELL);
                }
                // scripted (increase crit chance ... against ... target by x%
                if (caster)
                {
                    AuraEffectList const& mOverrideClassScript = caster->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
                    for (AuraEffectList::const_iterator i = mOverrideClassScript.begin(); i != mOverrideClassScript.end(); ++i)
                    {
                        if (!((*i)->IsAffectedOnSpell(spellProto)))
                            continue;
                        int32 modChance = 0;
                        switch ((*i)->GetMiscValue())
                        {
                            // Shatter
                            case 911:
                                modChance += 16;
                                [[fallthrough]];
                            case 910:
                                modChance += 17;
                                [[fallthrough]];
                            case 849:
                                modChance += 17;
                                if (!HasAuraState(AURA_STATE_FROZEN, spellProto, caster))
                                    break;
                                crit_chance += modChance;
                                break;
                            case 7917: // Glyph of Shadowburn
                                if (HasAuraState(AURA_STATE_HEALTHLESS_35_PERCENT, spellProto, caster))
                                    crit_chance += (*i)->GetAmount();
                                break;
                            case 7997: // Renewed Hope
                            case 7998:
                                if (HasAura(6788))
                                    crit_chance += (*i)->GetAmount();
                                break;
                            default:
                                break;
                        }
                    }
                    // Custom crit by class
                    switch (spellProto->SpellFamilyName)
                    {
                        case SPELLFAMILY_MAGE:
                            // Glyph of Fire Blast
                            if (spellProto->SpellFamilyFlags[0] == 0x2 && spellProto->SpellIconID == 12)
                                if (HasAuraWithMechanic((1 << MECHANIC_STUN) | (1 << MECHANIC_KNOCKOUT)))
                                    if (AuraEffect const* aurEff = caster->GetAuraEffect(56369, EFFECT_0))
                                        crit_chance += aurEff->GetAmount();
                            break;
                        case SPELLFAMILY_DRUID:
                            // Improved Faerie Fire
                            if (HasAuraState(AURA_STATE_FAERIE_FIRE))
                                if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_DRUID, 109, 0))
                                    crit_chance += aurEff->GetAmount();

                            // cumulative effect - don't break

                            // Starfire
                            if (spellProto->SpellFamilyFlags[0] & 0x4 && spellProto->SpellIconID == 1485)
                            {
                                // Improved Insect Swarm
                                if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_DRUID, 1771, 0))
                                    if (GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_DRUID, 0x00000002, 0, 0))
                                        crit_chance += aurEff->GetAmount();
                                break;
                            }
                            break;
                        case SPELLFAMILY_ROGUE:
                            // Shiv-applied poisons can't crit
                            if (caster->FindCurrentSpellBySpellId(5938))
                                crit_chance = 0.0f;
                            break;
                        case SPELLFAMILY_PALADIN:
                            // Flash of light
                            if (spellProto->SpellFamilyFlags[0] & 0x40000000)
                            {
                                // Sacred Shield
                                if (AuraEffect const* aura = GetAuraEffect(58597, 1, GetGUID()))
                                    crit_chance += aura->GetAmount();
                                break;
                            }
                            // Exorcism
                            else if (spellProto->GetCategory() == 19)
                            {
                                if (GetCreatureTypeMask() & CREATURE_TYPEMASK_DEMON_OR_UNDEAD)
                                    return 100.0f;
                                break;
                            }
                            break;
                        case SPELLFAMILY_SHAMAN:
                            // Lava Burst
                            if (spellProto->SpellFamilyFlags[1] & 0x00001000)
                            {
                                if (GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_SHAMAN, 0x10000000, 0, 0, caster->GetGUID()))
                                    if (GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE) > -100)
                                        return 100.0f;
                                break;
                            }
                            break;
                    }
                }
                break;
            }
        case SPELL_DAMAGE_CLASS_MELEE:
            // Custom crit by class
            if (caster)
            {
                switch (spellProto->SpellFamilyName)
                {
                case SPELLFAMILY_DRUID:
                    // Rend and Tear - bonus crit chance for Ferocious Bite on bleeding targets
                    if (spellProto->SpellFamilyFlags[0] & 0x00800000 && spellProto->SpellIconID == 1680 && HasAuraState(AURA_STATE_BLEEDING))
                    {
                        if (AuraEffect const* rendAndTear = caster->GetDummyAuraEffect(SPELLFAMILY_DRUID, 2859, 1))
                            crit_chance += rendAndTear->GetAmount();
                        break;
                    }
                    break;
                case SPELLFAMILY_WARRIOR:
                    // Victory Rush
                    if (spellProto->SpellFamilyFlags[1] & 0x100)
                    {
                        // Glyph of Victory Rush
                        if (AuraEffect const* aurEff = caster->GetAuraEffect(58382, 0))
                            crit_chance += aurEff->GetAmount();
                        break;
                    }
                    break;
                }
            }

            // 100% critical chance against sitting target
            if (GetTypeId() == TYPEID_PLAYER && (IsSitState() || getStandState() == UNIT_STAND_STATE_SLEEP))
            {
                return 100.0f;
            }
            [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
        case SPELL_DAMAGE_CLASS_RANGED:
            {
                // flat aura mods
                if (attackType == RANGED_ATTACK)
                    crit_chance += GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_CHANCE);
                else
                    crit_chance += GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE);

                // reduce crit chance from Rating for players
                if (attackType != RANGED_ATTACK)
                {
                    // xinef: little hack, crit chance dont require caster to calculate, pass victim
                    Unit::ApplyResilience(this, &crit_chance, nullptr, false, CR_CRIT_TAKEN_MELEE);
                }
                else
                    Unit::ApplyResilience(this, &crit_chance, nullptr, false, CR_CRIT_TAKEN_RANGED);

                // Apply crit chance from defence skill
                if (caster)
                    crit_chance += (int32(caster->GetMaxSkillValueForLevel(this)) - int32(GetDefenseSkillValue(caster))) * 0.04f;

                break;
            }
        // values overridden in spellmgr for lifebloom and earth shield
        case SPELL_DAMAGE_CLASS_NONE:
        default:
            return 0.0f;
    }

    if (caster)
    {
        AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(SPELL_AURA_MOD_CRIT_CHANCE_FOR_CASTER);
        for (AuraEffectList::const_iterator i = mTotalAuraList.begin(); i != mTotalAuraList.end(); ++i)
        {
            if (caster->GetGUID() != (*i)->GetCasterGUID())
                continue;

            crit_chance += (*i)->GetAmount();
        }
    }

    // Modify critical chance by victim SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE
    // xinef: should be calculated at the end
    if (!spellProto->IsPositive())
        crit_chance += GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_SPELL_AND_WEAPON_CRIT_CHANCE);

    // xinef: can be negative!
    return crit_chance;
}

uint32 Unit::SpellCriticalDamageBonus(Unit const* caster, SpellInfo const* spellProto, uint32 damage, Unit const* victim)
{
    // Calculate critical bonus
    int32 crit_bonus = damage;
    float crit_mod = 0.0f;

    switch (spellProto->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_MELEE:                      // for melee based spells is 100%
        case SPELL_DAMAGE_CLASS_RANGED:
            /// @todo: write here full calculation for melee/ranged spells
            crit_bonus += damage;
            break;
        default:
            crit_bonus += damage / 2;                       // for spells is 50%
            break;
    }

    if (caster)
    {
        crit_mod += caster->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_CRIT_DAMAGE_BONUS, spellProto->GetSchoolMask());

        if (victim)
            crit_mod += caster->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_CRIT_PERCENT_VERSUS, victim->GetCreatureTypeMask());

        if (crit_bonus != 0 && crit_mod != 0.0f)
            AddPct(crit_bonus, crit_mod);

        crit_bonus -= damage;

        // adds additional damage to critBonus (from talents)
        if (Player* modOwner = caster->GetSpellModOwner())
            modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_CRIT_DAMAGE_BONUS, crit_bonus);

        crit_bonus += damage;
    }

    return crit_bonus;
}

uint32 Unit::SpellCriticalHealingBonus(Unit const* caster, SpellInfo const* spellProto, uint32 damage, Unit const* victim)
{
    // Calculate critical bonus
    int32 crit_bonus;
    switch (spellProto->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_MELEE:                      // for melee based spells is 100%
        case SPELL_DAMAGE_CLASS_RANGED:
            /// @todo: write here full calculation for melee/ranged spells
            crit_bonus = damage;
            break;
        default:
            crit_bonus = damage / 2;                        // for spells is 50%
            break;
    }

    if (caster)
    {
        if (victim)
        {
            uint32 creatureTypeMask = victim->GetCreatureTypeMask();
            crit_bonus = int32(crit_bonus * caster->GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_CRIT_PERCENT_VERSUS, creatureTypeMask));
        }

        // adds additional damage to critBonus (from talents)
        // xinef: used for death knight death coil
        if (Player* modOwner = caster->GetSpellModOwner())
            modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_CRIT_DAMAGE_BONUS, crit_bonus);
    }

    if (crit_bonus > 0)
        damage += crit_bonus;

    if (caster)
        damage = int32(float(damage) * caster->GetTotalAuraMultiplier(SPELL_AURA_MOD_CRITICAL_HEALING_AMOUNT));

    return damage;
}

float Unit::SpellPctHealingModsDone(Unit* victim, SpellInfo const* spellProto, DamageEffectType damagetype)
{
    // For totems get healing bonus from owner (statue isn't totem in fact)
    if (GetTypeId() == TYPEID_UNIT && IsTotem())
        if (Unit* owner = GetOwner())
            return owner->SpellPctHealingModsDone(victim, spellProto, damagetype);

    // Some spells don't benefit from done mods
    if (spellProto->HasAttribute(SPELL_ATTR3_IGNORE_CASTER_MODIFIERS))
        return 1.0f;

    // xinef: Some spells don't benefit from done mods
    if (spellProto->HasAttribute(SPELL_ATTR6_IGNORE_HEALTH_MODIFIERS))
        return 1.0f;

    // No bonus healing for potion spells
    if (spellProto->SpellFamilyName == SPELLFAMILY_POTION)
        return 1.0f;

    float DoneTotalMod = 1.0f;

    // Healing done percent
    AuraEffectList const& mHealingDonePct = GetAuraEffectsByType(SPELL_AURA_MOD_HEALING_DONE_PERCENT);
    for (auto const& auraEff : mHealingDonePct)
    {
        if (!sScriptMgr->IsNeedModHealPercent(this, auraEff, DoneTotalMod, spellProto))
            continue;

        AddPct(DoneTotalMod, auraEff->GetAmount());
    }

    // done scripted mod (take it from owner)
    Unit* owner = GetOwner() ? GetOwner() : this;
    AuraEffectList const& mOverrideClassScript = owner->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    for (AuraEffectList::const_iterator i = mOverrideClassScript.begin(); i != mOverrideClassScript.end(); ++i)
    {
        if (!(*i)->IsAffectedOnSpell(spellProto))
            continue;

        switch ((*i)->GetMiscValue())
        {
            case   21: // Test of Faith
            case 6935:
            case 6918:
                if (victim->HealthBelowPct(50))
                    AddPct(DoneTotalMod, (*i)->GetAmount());
                break;
            case 7798: // Glyph of Regrowth
                {
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_HEAL, SPELLFAMILY_DRUID, 0x40, 0, 0))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    break;
                }

            case 7871: // Glyph of Lesser Healing Wave
                {
                    // xinef: affected by any earth shield
                    if (victim->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_SHAMAN, 0, 0x00000400, 0))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    break;
                }
            default:
                break;
        }
    }

    switch (spellProto->SpellFamilyName)
    {
        case SPELLFAMILY_GENERIC:
            // Talents and glyphs for healing stream totem
            if (spellProto->Id == 52042)
            {
                // Glyph of Healing Stream Totem
                if (AuraEffect* dummy = owner->GetAuraEffect(55456, EFFECT_0))
                    AddPct(DoneTotalMod, dummy->GetAmount());

                // Healing Stream totem - Restorative Totems
                if (AuraEffect* aurEff = GetDummyAuraEffect(SPELLFAMILY_SHAMAN, 338, 1))
                    AddPct(DoneTotalMod, aurEff->GetAmount());
            }
            break;
        case SPELLFAMILY_PRIEST:
            // T9 HEALING 4P, empowered renew instant heal
            if (spellProto->Id == 63544)
                if (AuraEffect* aurEff = GetAuraEffect(67202, EFFECT_0))
                    AddPct(DoneTotalMod, aurEff->GetAmount());
            break;
    }

    return DoneTotalMod;
}

uint32 Unit::SpellHealingBonusDone(Unit* victim, SpellInfo const* spellProto, uint32 healamount, DamageEffectType damagetype, uint8 effIndex, float TotalMod, uint32 stack)
{
    // For totems get healing bonus from owner (statue isn't totem in fact)
    if (GetTypeId() == TYPEID_UNIT && IsTotem())
        if (Unit* owner = GetOwner())
            return owner->SpellHealingBonusDone(victim, spellProto, healamount, damagetype, effIndex, TotalMod, stack);

    // No bonus healing for potion spells
    if (spellProto->SpellFamilyName == SPELLFAMILY_POTION)
        return healamount;

    float ApCoeffMod = 1.0f;
    float DoneTotalMod = TotalMod ? TotalMod : SpellPctHealingModsDone(victim, spellProto, damagetype);
    int32 DoneTotal = 0;

    // done scripted mod (take it from owner)
    Unit* owner = GetOwner() ? GetOwner() : this;
    int32 DoneAdvertisedBenefit = 0;
    AuraEffectList const& mOverrideClassScript = owner->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    for (AuraEffectList::const_iterator i = mOverrideClassScript.begin(); i != mOverrideClassScript.end(); ++i)
    {
        if (!(*i)->IsAffectedOnSpell(spellProto))
            continue;

        switch ((*i)->GetMiscValue())
        {
            case 4415: // Increased Rejuvenation Healing
            case 4953:
                DoneAdvertisedBenefit += (*i)->GetAmount();
                break;
            case 3736: // Hateful Totem of the Third Wind / Increased Lesser Healing Wave / LK Arena (4/5/6) Totem of the Third Wind / Savage Totem of the Third Wind
                DoneAdvertisedBenefit += (*i)->GetAmount();
                break;
        }
    }

    switch (spellProto->SpellFamilyName)
    {
        case SPELLFAMILY_DEATHKNIGHT:
        {
            // Impurity
            if (AuraEffect* aurEff = GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 1986, 0))
            {
                AddPct(ApCoeffMod, aurEff->GetAmount());
            }
            break;
        }
        default:
            break;
    }

    // Done fixed damage bonus auras
    DoneAdvertisedBenefit += SpellBaseHealingBonusDone(spellProto->GetSchoolMask());
    float coeff = spellProto->Effects[effIndex].BonusMultiplier;

    // Check for table values
    SpellBonusEntry const* bonus = sSpellMgr->GetSpellBonusData(spellProto->Id);
    if(bonus)
    {
        if (damagetype == DOT)
        {
            coeff = bonus->dot_damage;
            if (bonus->ap_dot_bonus > 0)
                DoneTotal += int32(bonus->ap_dot_bonus * ApCoeffMod * stack * GetTotalAttackPowerValue(
                                       (spellProto->IsRangedWeaponSpell() && spellProto->DmgClass != SPELL_DAMAGE_CLASS_MELEE) ? RANGED_ATTACK : BASE_ATTACK));
        }
        else
        {
            coeff = bonus->direct_damage;
            if (bonus->ap_bonus > 0)
                DoneTotal += int32(bonus->ap_bonus * ApCoeffMod * stack * GetTotalAttackPowerValue(
                                       (spellProto->IsRangedWeaponSpell() && spellProto->DmgClass != SPELL_DAMAGE_CLASS_MELEE) ? RANGED_ATTACK : BASE_ATTACK));
        }
    }
    else
    {
        // No bonus healing for SPELL_DAMAGE_CLASS_NONE class spells by default
        if (spellProto->DmgClass == SPELL_DAMAGE_CLASS_NONE)
            return healamount;
    }

    // Default calculation
    if (DoneAdvertisedBenefit)
    {
        float factorMod = CalculateLevelPenalty(spellProto) * stack;
        if (Player* modOwner = GetSpellModOwner())
        {
            coeff *= 100.0f;
            modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_BONUS_MULTIPLIER, coeff);
            coeff /= 100.0f;
        }
        DoneTotal += int32(DoneAdvertisedBenefit * coeff * factorMod);
    }

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        switch (spellProto->Effects[i].ApplyAuraName)
        {
            // Bonus healing does not apply to these spells
            case SPELL_AURA_PERIODIC_LEECH:
            case SPELL_AURA_PERIODIC_HEALTH_FUNNEL:
                DoneTotal = 0;
                break;
        }
        if (spellProto->Effects[i].Effect == SPELL_EFFECT_HEALTH_LEECH)
            DoneTotal = 0;
    }

    // use float as more appropriate for negative values and percent applying
    float heal = float(int32(healamount) + DoneTotal) * DoneTotalMod;
    // apply spellmod to Done amount

    if (Player* modOwner = GetSpellModOwner())
        modOwner->ApplySpellMod(spellProto->Id, damagetype == DOT ? SPELLMOD_DOT : SPELLMOD_DAMAGE, heal);

    return uint32(std::max(heal, 0.0f));
}

uint32 Unit::SpellHealingBonusTaken(Unit* caster, SpellInfo const* spellProto, uint32 healamount, DamageEffectType damagetype, uint32 stack)
{
    float TakenTotalMod = 1.0f;
    float minval = 0.0f;

    // Healing taken percent
    if (!sScriptMgr->OnSpellHealingBonusTakenNegativeModifiers(this, caster, spellProto, minval))
    {
        minval = float(GetMaxNegativeAuraModifier(SPELL_AURA_MOD_HEALING_PCT));
    }

    if (minval)
        AddPct(TakenTotalMod, minval);

    float maxval = float(GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HEALING_PCT));
    if (maxval)
        AddPct(TakenTotalMod, maxval);

    // Tenacity increase healing % taken
    if (AuraEffect const* Tenacity = GetAuraEffect(58549, 0))
        AddPct(TakenTotalMod, Tenacity->GetAmount());

    // Healing Done
    int32 TakenTotal = 0;

    // Taken fixed damage bonus auras
    int32 TakenAdvertisedBenefit = SpellBaseHealingBonusTaken(spellProto->GetSchoolMask());

    // Nourish cast, glyph of nourish
    if (spellProto->SpellFamilyName == SPELLFAMILY_DRUID && spellProto->SpellFamilyFlags[1] & 0x2000000 && caster)
    {
        bool any = false;
        bool hasglyph = caster->GetAuraEffectDummy(62971);
        AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_PERIODIC_HEAL);
        for (AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
        {
            if (((*i)->GetCasterGUID() == caster->GetGUID()))
            {
                SpellInfo const* spell = (*i)->GetSpellInfo();
                // Rejuvenation, Regrowth, Lifebloom, or Wild Growth
                if (!any && spell->SpellFamilyFlags.HasFlag(0x50, 0x4000010, 0))
                {
                    TakenTotalMod *= 1.2f;
                    any = true;
                }

                if (hasglyph)
                    TakenTotalMod += 0.06f;
            }
        }
    }

    if (damagetype == DOT)
    {
        // Healing over time taken percent
        float minval_hot = float(GetMaxNegativeAuraModifier(SPELL_AURA_MOD_HOT_PCT));
        if (minval_hot)
            AddPct(TakenTotalMod, minval_hot);

        float maxval_hot = float(GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HOT_PCT));
        if (maxval_hot)
            AddPct(TakenTotalMod, maxval_hot);
    }

    // Check for table values
    SpellBonusEntry const* bonus = sSpellMgr->GetSpellBonusData(spellProto->Id);
    float coeff = 0;
    float factorMod = 1.0f;
    if (bonus)
        coeff = (damagetype == DOT) ? bonus->dot_damage : bonus->direct_damage;
    else
    {
        // No bonus healing for SPELL_DAMAGE_CLASS_NONE class spells by default
        if (spellProto->DmgClass == SPELL_DAMAGE_CLASS_NONE)
        {
            healamount = uint32(std::max((float(healamount) * TakenTotalMod), 0.0f));
            return healamount;
        }
    }

    // Default calculation
    if (TakenAdvertisedBenefit)
    {
        float TakenCoeff = 0.0f;
        if (coeff <= 0)
            coeff = CalculateDefaultCoefficient(spellProto, damagetype) * int32(stack) * 1.88f;  // As wowwiki says: C = (Cast Time / 3.5) * 1.88 (for healing spells)

        factorMod *= CalculateLevelPenalty(spellProto) * int32(stack);
        if (Player* modOwner = GetSpellModOwner())
        {
            coeff *= 100.0f;
            modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_BONUS_MULTIPLIER, coeff);
            coeff /= 100.0f;
        }

        TakenTotal += int32(TakenAdvertisedBenefit * (coeff > 0 ? coeff : TakenCoeff) * factorMod);
    }

    if (caster)
    {
        AuraEffectList const& mHealingGet = GetAuraEffectsByType(SPELL_AURA_MOD_HEALING_RECEIVED);
        for (AuraEffectList::const_iterator i = mHealingGet.begin(); i != mHealingGet.end(); ++i)
            if (caster->GetGUID() == (*i)->GetCasterGUID() && (*i)->IsAffectedOnSpell(spellProto))
                AddPct(TakenTotalMod, (*i)->GetAmount());
    }

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        switch (spellProto->Effects[i].ApplyAuraName)
        {
            // Bonus healing does not apply to these spells
            case SPELL_AURA_PERIODIC_LEECH:
            case SPELL_AURA_PERIODIC_HEALTH_FUNNEL:
                TakenTotal = 0;
                break;
        }
        if (spellProto->Effects[i].Effect == SPELL_EFFECT_HEALTH_LEECH)
            TakenTotal = 0;
    }

    // No positive taken bonus, custom attr
    if ((spellProto->HasAttribute(SPELL_ATTR6_IGNORE_HEALTH_MODIFIERS) || spellProto->HasAttribute(SPELL_ATTR0_CU_NO_POSITIVE_TAKEN_BONUS)) && TakenTotalMod > 1.0f)
    {
        TakenTotal = 0;
        TakenTotalMod = 1.0f;
    }

    float heal = float(int32(healamount) + TakenTotal) * TakenTotalMod;

    return uint32(std::max(heal, 0.0f));
}

int32 Unit::SpellBaseHealingBonusDone(SpellSchoolMask schoolMask)
{
    int32 AdvertisedBenefit = 0;

    AuraEffectList const& mHealingDone = GetAuraEffectsByType(SPELL_AURA_MOD_HEALING_DONE);
    for (AuraEffectList::const_iterator i = mHealingDone.begin(); i != mHealingDone.end(); ++i)
        if (!(*i)->GetMiscValue() || ((*i)->GetMiscValue() & schoolMask) != 0)
            AdvertisedBenefit += (*i)->GetAmount();

    // Healing bonus of spirit, intellect and strength
    if (GetTypeId() == TYPEID_PLAYER)
    {
        // Base value
        AdvertisedBenefit += ToPlayer()->GetBaseSpellPowerBonus();

        // Healing bonus from stats
        AuraEffectList const& mHealingDoneOfStatPercent = GetAuraEffectsByType(SPELL_AURA_MOD_SPELL_HEALING_OF_STAT_PERCENT);
        for (AuraEffectList::const_iterator i = mHealingDoneOfStatPercent.begin(); i != mHealingDoneOfStatPercent.end(); ++i)
        {
            // stat used dependent from misc value (stat index)
            Stats usedStat = Stats((*i)->GetSpellInfo()->Effects[(*i)->GetEffIndex()].MiscValue);
            AdvertisedBenefit += int32(CalculatePct(GetStat(usedStat), (*i)->GetAmount()));
        }

        // ... and attack power
        AuraEffectList const& mHealingDonebyAP = GetAuraEffectsByType(SPELL_AURA_MOD_SPELL_HEALING_OF_ATTACK_POWER);
        for (AuraEffectList::const_iterator i = mHealingDonebyAP.begin(); i != mHealingDonebyAP.end(); ++i)
            if ((*i)->GetMiscValue() & schoolMask)
                AdvertisedBenefit += int32(CalculatePct(GetTotalAttackPowerValue(BASE_ATTACK), (*i)->GetAmount()));
    }
    return AdvertisedBenefit;
}

int32 Unit::SpellBaseHealingBonusTaken(SpellSchoolMask schoolMask)
{
    int32 AdvertisedBenefit = 0;

    AuraEffectList const& mDamageTaken = GetAuraEffectsByType(SPELL_AURA_MOD_HEALING);
    for (AuraEffectList::const_iterator i = mDamageTaken.begin(); i != mDamageTaken.end(); ++i)
        if (((*i)->GetMiscValue() & schoolMask) != 0)
            AdvertisedBenefit += (*i)->GetAmount();

    return AdvertisedBenefit;
}

bool Unit::IsImmunedToDamage(SpellSchoolMask meleeSchoolMask) const
{
    if (meleeSchoolMask == SPELL_SCHOOL_MASK_NONE)
    {
        return false;
    }

    // If m_immuneToDamage type contain magic, IMMUNE damage.
    SpellImmuneList const& damageList = m_spellImmune[IMMUNITY_DAMAGE];
    for (SpellImmuneList::const_iterator itr = damageList.begin(); itr != damageList.end(); ++itr)
        if((itr->type & meleeSchoolMask) == meleeSchoolMask)
            return true;

    return false;
}

bool Unit::IsImmunedToDamage(SpellInfo const* spellInfo) const
{
    if (!spellInfo)
    {
        return false;
    }

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
    {
        return false;
    }

    if (spellInfo->HasAttribute(SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS) || spellInfo->HasAttribute(SPELL_ATTR2_NO_SCHOOL_IMMUNITIES))
    {
        return false;
    }

    uint32 schoolMask = spellInfo->GetSchoolMask();
    if (schoolMask == SPELL_SCHOOL_MASK_NONE)
    {
        return false;
    }

    // If m_immuneToDamage type contain magic, IMMUNE damage.
    SpellImmuneList const& damageList = m_spellImmune[IMMUNITY_DAMAGE];
    for (SpellImmuneList::const_iterator itr = damageList.begin(); itr != damageList.end(); ++itr)
        if((itr->type & schoolMask) == schoolMask)
            return true;

    return false;
}

bool Unit::IsImmunedToDamage(Spell const* spell) const
{
    SpellInfo const* spellInfo = spell->GetSpellInfo();
    if (!spellInfo)
    {
        return false;
    }

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
    {
        return false;
    }

    if (spellInfo->HasAttribute(SPELL_ATTR1_IMMUNITY_TO_HOSTILE_AND_FRIENDLY_EFFECTS) || spellInfo->HasAttribute(SPELL_ATTR2_NO_SCHOOL_IMMUNITIES))
    {
        return false;
    }

    uint32 schoolMask = spell->GetSpellSchoolMask();
    if (schoolMask == SPELL_SCHOOL_MASK_NONE)
    {
        return false;
    }

    // If m_immuneToDamage type contain magic, IMMUNE damage.
    SpellImmuneList const& damageList = m_spellImmune[IMMUNITY_DAMAGE];
    for (SpellImmuneList::const_iterator itr = damageList.begin(); itr != damageList.end(); ++itr)
    {
        if ((itr->type & schoolMask) == schoolMask)
        {
            return true;
        }
    }

    return false;
}

bool Unit::IsImmunedToSchool(SpellSchoolMask meleeSchoolMask) const
{
    if (meleeSchoolMask == SPELL_SCHOOL_MASK_NONE)
    {
        return false;
    }

    // If m_immuneToSchool type contain this school type, IMMUNE damage.
    SpellImmuneList const& schoolList = m_spellImmune[IMMUNITY_SCHOOL];
    for (SpellImmuneList::const_iterator itr = schoolList.begin(); itr != schoolList.end(); ++itr)
        if((itr->type & meleeSchoolMask) == meleeSchoolMask)
            return true;

    return false;
}

bool Unit::IsImmunedToSchool(SpellInfo const* spellInfo) const
{
    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
        return false;

    uint32 schoolMask = spellInfo->GetSchoolMask();
    if (schoolMask == SPELL_SCHOOL_MASK_NONE)
    {
        return false;
    }

    if (spellInfo->Id != 42292 && spellInfo->Id != 59752 && spellInfo->Id != 19574 && spellInfo->Id != 34471)
    {
        // If m_immuneToSchool type contain this school type, IMMUNE damage.
        SpellImmuneList const& schoolList = m_spellImmune[IMMUNITY_SCHOOL];
        for (SpellImmuneList::const_iterator itr = schoolList.begin(); itr != schoolList.end(); ++itr)
            if((itr->type & schoolMask) == schoolMask && !spellInfo->CanPierceImmuneAura(sSpellMgr->GetSpellInfo(itr->spellId)))
                return true;
    }

    return false;
}

bool Unit::IsImmunedToSchool(Spell const* spell) const
{
    SpellInfo const* spellInfo = spell->GetSpellInfo();
    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
    {
        return false;
    }

    uint32 schoolMask = spell->GetSpellSchoolMask();
    if (schoolMask == SPELL_SCHOOL_MASK_NONE)
    {
        return false;
    }

    if (spellInfo->Id != 42292 && spellInfo->Id != 59752 && spellInfo->Id != 19574 && spellInfo->Id != 34471)
    {
        // If m_immuneToSchool type contain this school type, IMMUNE damage.
        SpellImmuneList const& schoolList = m_spellImmune[IMMUNITY_SCHOOL];
        for (SpellImmuneList::const_iterator itr = schoolList.begin(); itr != schoolList.end(); ++itr)
        {
            if ((itr->type & schoolMask) == schoolMask && !spellInfo->CanPierceImmuneAura(sSpellMgr->GetSpellInfo(itr->spellId)))
            {
                return true;
            }
        }
    }

    return false;
}

bool Unit::IsImmunedToDamageOrSchool(SpellSchoolMask meleeSchoolMask) const
{
    if (meleeSchoolMask == SPELL_SCHOOL_MASK_NONE)
    {
        return false;
    }

    return IsImmunedToDamage(meleeSchoolMask) || IsImmunedToSchool(meleeSchoolMask);
}

bool Unit::IsImmunedToDamageOrSchool(SpellInfo const* spellInfo) const
{
    return IsImmunedToDamage(spellInfo) || IsImmunedToSchool(spellInfo);
}

bool Unit::IsImmunedToSpell(SpellInfo const* spellInfo, Spell const* spell)
{
    if (!spellInfo)
        return false;

    // Single spell immunity.
    SpellImmuneList const& idList = m_spellImmune[IMMUNITY_ID];
    for (SpellImmuneList::const_iterator itr = idList.begin(); itr != idList.end(); ++itr)
        if (itr->type == spellInfo->Id)
            return true;

    // xinef: my special immunity, if spellid is not on this list it means npc is immune
    SpellImmuneList const& allowIdList = m_spellImmune[IMMUNITY_ALLOW_ID];
    if (!allowIdList.empty())
    {
        for (SpellImmuneList::const_iterator itr = allowIdList.begin(); itr != allowIdList.end(); ++itr)
            if (itr->type == spellInfo->Id)
                return false;
        return true;
    }

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
        return false;

    if (spellInfo->Dispel)
    {
        SpellImmuneList const& dispelList = m_spellImmune[IMMUNITY_DISPEL];
        for (SpellImmuneList::const_iterator itr = dispelList.begin(); itr != dispelList.end(); ++itr)
            if (itr->type == spellInfo->Dispel)
                return true;
    }

    // Spells that don't have effectMechanics.
    if (spellInfo->Mechanic)
    {
        SpellImmuneList const& mechanicList = m_spellImmune[IMMUNITY_MECHANIC];
        for (SpellImmuneList::const_iterator itr = mechanicList.begin(); itr != mechanicList.end(); ++itr)
            if (itr->type == spellInfo->Mechanic)
                return true;
    }

    bool immuneToAllEffects = true;
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // State/effect immunities applied by aura expect full spell immunity
        // Ignore effects with mechanic, they are supposed to be checked separately
        if (!spellInfo->Effects[i].IsEffect())
            continue;

        // Xinef: if target is immune to one effect, and the spell has transform aura - it is immune to whole spell
        if (IsImmunedToSpellEffect(spellInfo, i))
        {
            if (spellInfo->HasAura(SPELL_AURA_TRANSFORM))
                return true;
            continue;
        }

        immuneToAllEffects = false;
        break;
    }
    if (immuneToAllEffects) //Return immune only if the target is immune to all spell effects.
        return true;

    if (spellInfo->Id != 42292 && spellInfo->Id != 59752 && spellInfo->Id != 19574 && spellInfo->Id != 34471)
    {
        SpellSchoolMask spellSchoolMask = spellInfo->GetSchoolMask();
        if (spell)
        {
            spellSchoolMask = spell->GetSpellSchoolMask();
        }

        if (spellSchoolMask != SPELL_SCHOOL_MASK_NONE)
        {
            SpellImmuneList const& schoolList = m_spellImmune[IMMUNITY_SCHOOL];
            for (SpellImmuneList::const_iterator itr = schoolList.begin(); itr != schoolList.end(); ++itr)
            {
                SpellInfo const* immuneSpellInfo = sSpellMgr->GetSpellInfo(itr->spellId);
                if (((itr->type & spellSchoolMask) == spellSchoolMask)
                    && (!immuneSpellInfo || immuneSpellInfo->IsPositive()) && !spellInfo->IsPositive()
                    && !spellInfo->CanPierceImmuneAura(immuneSpellInfo))
                {
                    return true;
                }
            }
        }
    }

    return false;
}

bool Unit::IsImmunedToSpellEffect(SpellInfo const* spellInfo, uint32 index) const
{
    if (!spellInfo || !spellInfo->Effects[index].IsEffect())
        return false;

    // xinef: pet scaling auras
    if (spellInfo->HasAttribute(SPELL_ATTR4_OWNER_POWER_SCALING))
        return false;

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION))
        return false;

    //If m_immuneToEffect type contain this effect type, IMMUNE effect.
    uint32 effect = spellInfo->Effects[index].Effect;
    SpellImmuneList const& effectList = m_spellImmune[IMMUNITY_EFFECT];
    for (SpellImmuneList::const_iterator itr = effectList.begin(); itr != effectList.end(); ++itr)
    {
        if (itr->type == effect && (itr->spellId != 62692 || (spellInfo->Effects[index].MiscValue == POWER_MANA && !CanRestoreMana(spellInfo))))
        {
            return true;
        }
    }

    if (uint32 mechanic = spellInfo->Effects[index].Mechanic)
    {
        SpellImmuneList const& mechanicList = m_spellImmune[IMMUNITY_MECHANIC];
        for (SpellImmuneList::const_iterator itr = mechanicList.begin(); itr != mechanicList.end(); ++itr)
            if (itr->type == mechanic)
                return true;
    }

    if (uint32 aura = spellInfo->Effects[index].ApplyAuraName)
    {
        SpellImmuneList const& list = m_spellImmune[IMMUNITY_STATE];
        for (SpellImmuneList::const_iterator itr = list.begin(); itr != list.end(); ++itr)
        {
            if (itr->type == aura && (itr->spellId != 64848 || (spellInfo->Effects[index].MiscValue == POWER_MANA && !CanRestoreMana(spellInfo))))
            {
                if (!spellInfo->HasAttribute(SPELL_ATTR3_ALWAYS_HIT))
                {
                    if (itr->blockType == SPELL_BLOCK_TYPE_ALL || spellInfo->IsPositive()) // xinef: added for pet scaling
                    {
                        return true;
                    }
                }
            }
        }

        if (!spellInfo->HasAttribute(SPELL_ATTR2_NO_SCHOOL_IMMUNITIES))
        {
            // Check for immune to application of harmful magical effects
            AuraEffectList const& immuneAuraApply = GetAuraEffectsByType(SPELL_AURA_MOD_IMMUNE_AURA_APPLY_SCHOOL);
            for (AuraEffectList::const_iterator iter = immuneAuraApply.begin(); iter != immuneAuraApply.end(); ++iter)
            {
                if (/*(spellInfo->Dispel == DISPEL_MAGIC || spellInfo->Dispel == DISPEL_CURSE || spellInfo->Dispel == DISPEL_DISEASE) &&*/ // Magic debuff, xinef: all kinds?
                    ((*iter)->GetMiscValue() & spellInfo->GetSchoolMask()) &&  // Check school
                    !spellInfo->IsPositiveEffect(index) &&                                  // Harmful
                    spellInfo->Effects[index].Effect != SPELL_EFFECT_PERSISTENT_AREA_AURA)  // Not Persistent area auras
                {
                    return true;
                }
            }
        }
    }

    return false;
}

uint32 Unit::MeleeDamageBonusDone(Unit* victim, uint32 pdamage, WeaponAttackType attType, SpellInfo const* spellProto, SpellSchoolMask damageSchoolMask /*= SPELL_SCHOOL_MASK_NORMAL*/)
{
    if (!victim || pdamage == 0)
        return 0;

    if (GetTypeId() == TYPEID_UNIT)
    {
        // Dancing Rune Weapon...
        if (GetEntry() == 27893)
        {
            if (Unit* owner = GetOwner())
                return owner->MeleeDamageBonusDone(victim, pdamage, attType, spellProto, damageSchoolMask) / 2;
        }
    }

    uint32 creatureTypeMask = victim->GetCreatureTypeMask();

    // Done fixed damage bonus auras
    int32 DoneFlatBenefit = 0;

    // ..done
    AuraEffectList const& mDamageDoneCreature = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE_CREATURE);
    for (AuraEffectList::const_iterator i = mDamageDoneCreature.begin(); i != mDamageDoneCreature.end(); ++i)
        if (creatureTypeMask & uint32((*i)->GetMiscValue()))
            DoneFlatBenefit += (*i)->GetAmount();

    // ..done
    // SPELL_AURA_MOD_DAMAGE_DONE included in weapon damage

    // ..done (base at attack power for marked target and base at attack power for creature type)
    int32 APbonus = 0;

    if (attType == RANGED_ATTACK)
    {
        APbonus += victim->GetTotalAuraModifier(SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS);

        // ..done (base at attack power and creature type)
        AuraEffectList const& mCreatureAttackPower = GetAuraEffectsByType(SPELL_AURA_MOD_RANGED_ATTACK_POWER_VERSUS);
        for (AuraEffectList::const_iterator i = mCreatureAttackPower.begin(); i != mCreatureAttackPower.end(); ++i)
            if (creatureTypeMask & uint32((*i)->GetMiscValue()))
                APbonus += (*i)->GetAmount();
    }
    else
    {
        APbonus += victim->GetTotalAuraModifier(SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS);

        // ..done (base at attack power and creature type)
        AuraEffectList const& mCreatureAttackPower = GetAuraEffectsByType(SPELL_AURA_MOD_MELEE_ATTACK_POWER_VERSUS);
        for (AuraEffectList::const_iterator i = mCreatureAttackPower.begin(); i != mCreatureAttackPower.end(); ++i)
            if (creatureTypeMask & uint32((*i)->GetMiscValue()))
                APbonus += (*i)->GetAmount();
    }

    if (APbonus != 0)                                       // Can be negative
    {
        bool normalized = false;
        if (spellProto)
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                if (spellProto->Effects[i].Effect == SPELL_EFFECT_NORMALIZED_WEAPON_DMG)
                {
                    normalized = true;
                    break;
                }
        DoneFlatBenefit += int32(APbonus / 14.0f * GetAPMultiplier(attType, normalized));
    }

    // Done total percent damage auras
    float DoneTotalMod = 1.0f;

    // mods for SPELL_SCHOOL_MASK_NORMAL are already factored in base melee damage calculation
    if (!(damageSchoolMask & SPELL_SCHOOL_MASK_NORMAL))
    {
        // Some spells don't benefit from pct done mods
        AuraEffectList const& mModDamagePercentDone = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
        for (AuraEffectList::const_iterator i = mModDamagePercentDone.begin(); i != mModDamagePercentDone.end(); ++i)
        {
            if (!spellProto || (spellProto->ValidateAttribute6SpellDamageMods(this, *i, false) &&
                sScriptMgr->IsNeedModMeleeDamagePercent(this, *i, DoneTotalMod, spellProto)))
            {
                if (((*i)->GetMiscValue() & damageSchoolMask))
                {
                    if ((*i)->GetSpellInfo()->EquippedItemClass == -1)
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    else if (!(*i)->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPED_ITEM) && ((*i)->GetSpellInfo()->EquippedItemSubClassMask == 0))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    else if (ToPlayer() && ToPlayer()->HasItemFitToSpellRequirements((*i)->GetSpellInfo()))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                }
            }
        }
    }

    AuraEffectList const& mDamageDoneVersus = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS);
    for (AuraEffectList::const_iterator i = mDamageDoneVersus.begin(); i != mDamageDoneVersus.end(); ++i)
        if (creatureTypeMask & uint32((*i)->GetMiscValue()))
            if (!spellProto || spellProto->ValidateAttribute6SpellDamageMods(this, *i, false))
                AddPct(DoneTotalMod, (*i)->GetAmount());

    // bonus against aurastate
    AuraEffectList const& mDamageDoneVersusAurastate = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS_AURASTATE);
    for (AuraEffectList::const_iterator i = mDamageDoneVersusAurastate.begin(); i != mDamageDoneVersusAurastate.end(); ++i)
        if (victim->HasAuraState(AuraStateType((*i)->GetMiscValue())))
            if (!spellProto || spellProto->ValidateAttribute6SpellDamageMods(this, *i, false))
                AddPct(DoneTotalMod, (*i)->GetAmount());

    // done scripted mod (take it from owner)
    Unit* owner = GetOwner() ? GetOwner() : this;
    AuraEffectList const& mOverrideClassScript = owner->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    for (AuraEffectList::const_iterator i = mOverrideClassScript.begin(); i != mOverrideClassScript.end(); ++i)
    {
        if (spellProto && !spellProto->ValidateAttribute6SpellDamageMods(this, *i, false))
            continue;

        if (!(*i)->IsAffectedOnSpell(spellProto))
            continue;

        switch ((*i)->GetMiscValue())
        {
            // Tundra Stalker
            // Merciless Combat
            case 7277:
                {
                    // Merciless Combat
                    if ((*i)->GetSpellInfo()->SpellIconID == 2656)
                    {
                        if (!victim->HealthAbovePct(35))
                            AddPct(DoneTotalMod, (*i)->GetAmount());
                    }
                    // Tundra Stalker
                    else
                    {
                        // Frost Fever (target debuff)
                        if (victim->HasAura(55095))
                            AddPct(DoneTotalMod, (*i)->GetAmount());
                    }
                    break;
                }
            // Rage of Rivendare
            case 7293:
                {
                    if (victim->GetAuraEffect(SPELL_AURA_PERIODIC_DAMAGE, SPELLFAMILY_DEATHKNIGHT, 0, 0x02000000, 0))
                        AddPct(DoneTotalMod, (*i)->GetSpellInfo()->GetRank() * 2.0f);
                    break;
                }
            // Marked for Death
            case 7598:
            case 7599:
            case 7600:
            case 7601:
            case 7602:
                {
                    if (victim->GetAuraEffect(SPELL_AURA_MOD_STALKED, SPELLFAMILY_HUNTER, 0x400, 0, 0))
                        AddPct(DoneTotalMod, (*i)->GetAmount());
                    break;
                }
            // Dirty Deeds
            case 6427:
            case 6428:
                {
                    if (victim->HasAuraState(AURA_STATE_HEALTHLESS_35_PERCENT, spellProto, this))
                    {
                        // effect 0 has expected value but in negative state
                        int32 bonus = -(*i)->GetBase()->GetEffect(0)->GetAmount();
                        AddPct(DoneTotalMod, bonus);
                    }
                    break;
                }
        }
    }

    // Custom scripted damage
    if (spellProto)
        switch (spellProto->SpellFamilyName)
        {
            case SPELLFAMILY_DEATHKNIGHT:
                // Glacier Rot
                if (spellProto->SpellFamilyFlags[0] & 0x2 || spellProto->SpellFamilyFlags[1] & 0x6)
                    if (AuraEffect* aurEff = GetDummyAuraEffect(SPELLFAMILY_DEATHKNIGHT, 196, 0))
                        if (victim->GetDiseasesByCaster(owner->GetGUID()) > 0)
                            AddPct(DoneTotalMod, aurEff->GetAmount());
                break;
        }

    // Some spells don't benefit from done mods
    if (spellProto)
        if (spellProto->HasAttribute(SPELL_ATTR3_IGNORE_CASTER_MODIFIERS))
        {
            DoneFlatBenefit = 0;
            DoneTotalMod = 1.0f;
        }

    float tmpDamage = float(int32(pdamage) + DoneFlatBenefit) * DoneTotalMod;

    // apply spellmod to Done damage
    if (spellProto)
        if (Player* modOwner = GetSpellModOwner())
            modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_DAMAGE, tmpDamage);

    // bonus result can be negative
    return uint32(std::max(tmpDamage, 0.0f));
}

uint32 Unit::MeleeDamageBonusTaken(Unit* attacker, uint32 pdamage, WeaponAttackType attType, SpellInfo const* spellProto/*= nullptr*/, SpellSchoolMask damageSchoolMask /*= SPELL_SCHOOL_MASK_NORMAL*/)
{
    if (pdamage == 0)
        return 0;

    int32 TakenFlatBenefit = 0;

    // ..taken
    AuraEffectList const& mDamageTaken = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_TAKEN);
    for (AuraEffectList::const_iterator i = mDamageTaken.begin(); i != mDamageTaken.end(); ++i)
        if ((*i)->GetMiscValue() & damageSchoolMask)
            TakenFlatBenefit += (*i)->GetAmount();

    if (attType != RANGED_ATTACK)
        TakenFlatBenefit += GetTotalAuraModifier(SPELL_AURA_MOD_MELEE_DAMAGE_TAKEN);
    else
        TakenFlatBenefit += GetTotalAuraModifier(SPELL_AURA_MOD_RANGED_DAMAGE_TAKEN);

    // Taken total percent damage auras
    float TakenTotalMod = 1.0f;

    TakenTotalMod *= GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, damageSchoolMask);

    // .. taken pct (special attacks)
    if (spellProto)
    {
        // From caster spells
        AuraEffectList const& mOwnerTaken = GetAuraEffectsByType(SPELL_AURA_MOD_DAMAGE_FROM_CASTER);
        for (AuraEffectList::const_iterator i = mOwnerTaken.begin(); i != mOwnerTaken.end(); ++i)
            if ((*i)->GetCasterGUID() == attacker->GetGUID() && (*i)->IsAffectedOnSpell(spellProto))
                AddPct(TakenTotalMod, (*i)->GetAmount());

        // Mod damage from spell mechanic
        uint32 mechanicMask = spellProto->GetAllEffectsMechanicMask();

        // Shred, Maul - "Effects which increase Bleed damage also increase Shred damage"
        if (spellProto->SpellFamilyName == SPELLFAMILY_DRUID && spellProto->SpellFamilyFlags[0] & 0x00008800)
            mechanicMask |= (1 << MECHANIC_BLEED);

        if (mechanicMask)
        {
            AuraEffectList const& mDamageDoneMechanic = GetAuraEffectsByType(SPELL_AURA_MOD_MECHANIC_DAMAGE_TAKEN_PERCENT);
            for (AuraEffectList::const_iterator i = mDamageDoneMechanic.begin(); i != mDamageDoneMechanic.end(); ++i)
                if (mechanicMask & uint32(1 << ((*i)->GetMiscValue())))
                    AddPct(TakenTotalMod, (*i)->GetAmount());
        }
    }

    TakenTotalMod = processDummyAuras(TakenTotalMod);

    // .. taken pct: class scripts
    /*AuraEffectList const& mclassScritAuras = GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
    for (AuraEffectList::const_iterator i = mclassScritAuras.begin(); i != mclassScritAuras.end(); ++i)
    {
        switch ((*i)->GetMiscValue())
        {
        }
    }*/

    if (attType != RANGED_ATTACK)
    {
        AuraEffectList const& mModMeleeDamageTakenPercent = GetAuraEffectsByType(SPELL_AURA_MOD_MELEE_DAMAGE_TAKEN_PCT);
        for (AuraEffectList::const_iterator i = mModMeleeDamageTakenPercent.begin(); i != mModMeleeDamageTakenPercent.end(); ++i)
            AddPct(TakenTotalMod, (*i)->GetAmount());
    }
    else
    {
        AuraEffectList const& mModRangedDamageTakenPercent = GetAuraEffectsByType(SPELL_AURA_MOD_RANGED_DAMAGE_TAKEN_PCT);
        for (AuraEffectList::const_iterator i = mModRangedDamageTakenPercent.begin(); i != mModRangedDamageTakenPercent.end(); ++i)
            AddPct(TakenTotalMod, (*i)->GetAmount());
    }

    // No positive taken bonus, custom attr
    if (spellProto)
        if (spellProto->HasAttribute(SPELL_ATTR0_CU_NO_POSITIVE_TAKEN_BONUS) && TakenTotalMod > 1.0f)
        {
            TakenFlatBenefit = 0;
            TakenTotalMod = 1.0f;
        }

    // xinef: sanctified wrath talent
    if (TakenTotalMod < 1.0f && attacker->HasAuraType(SPELL_AURA_MOD_IGNORE_TARGET_RESIST))
    {
        float ignoreModifier = 1.0f - TakenTotalMod;
        bool addModifier = false;
        AuraEffectList const& ResIgnoreAuras = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_IGNORE_TARGET_RESIST);
        for (AuraEffectList::const_iterator j = ResIgnoreAuras.begin(); j != ResIgnoreAuras.end(); ++j)
            if ((*j)->GetMiscValue() & damageSchoolMask)
            {
                ApplyPct(ignoreModifier, (*j)->GetAmount());
                addModifier = true;
            }

        if (addModifier)
            TakenTotalMod += ignoreModifier;
    }

    float tmpDamage = (float(pdamage) + TakenFlatBenefit) * TakenTotalMod;

    // bonus result can be negative
    return uint32(std::max(tmpDamage, 0.0f));
}

class spellIdImmunityPredicate
{
public:
    spellIdImmunityPredicate(uint32 type) : _type(type) {}
    bool operator()(SpellImmune const& spellImmune) { return spellImmune.spellId == 0 && spellImmune.type == _type; }

private:
    uint32 _type;
};

void Unit::ApplySpellImmune(uint32 spellId, uint32 op, uint32 type, bool apply, SpellImmuneBlockType blockType)
{
    if (apply)
    {
        // xinef: immunities with spellId 0 are intended to be applied only once (script purposes mosty)
        if (spellId == 0 && std::find_if(m_spellImmune[op].begin(), m_spellImmune[op].end(), spellIdImmunityPredicate(type)) != m_spellImmune[op].end())
            return;

        SpellImmune immune;
        immune.spellId = spellId;
        immune.type = type;
        immune.blockType = blockType;
        m_spellImmune[op].push_back(std::move(immune));
    }
    else
    {
        for (SpellImmuneList::iterator itr = m_spellImmune[op].begin(); itr != m_spellImmune[op].end(); ++itr)
        {
            if (itr->spellId == spellId && itr->type == type)
            {
                m_spellImmune[op].erase(itr);
                break;
            }
        }
    }
}

void Unit::ApplySpellDispelImmunity(SpellInfo const* spellProto, DispelType type, bool apply)
{
    ApplySpellImmune(spellProto->Id, IMMUNITY_DISPEL, type, apply);

    if (apply && spellProto->HasAttribute(SPELL_ATTR1_IMMUNITY_PURGES_EFFECT))
    {
        // Create dispel mask by dispel type
        uint32 dispelMask = SpellInfo::GetDispelMask(type);
        // Dispel all existing auras vs current dispel type
        AuraApplicationMap& auras = GetAppliedAuras();
        for (AuraApplicationMap::iterator itr = auras.begin(); itr != auras.end();)
        {
            SpellInfo const* spell = itr->second->GetBase()->GetSpellInfo();
            if (spell->GetDispelMask() & dispelMask)
            {
                // Dispel aura
                RemoveAura(itr);
            }
            else
                ++itr;
        }
    }
}

float Unit::GetWeaponProcChance() const
{
    // normalized proc chance for weapon attack speed
    // (odd formula...)
    if (isAttackReady(BASE_ATTACK))
        return (GetAttackTime(BASE_ATTACK) * 1.8f / 1000.0f);
    else if (haveOffhandWeapon() && isAttackReady(OFF_ATTACK))
        return (GetAttackTime(OFF_ATTACK) * 1.6f / 1000.0f);
    return 0;
}

float Unit::GetPPMProcChance(uint32 WeaponSpeed, float PPM, SpellInfo const* spellProto) const
{
    // proc per minute chance calculation
    if (PPM <= 0)
        return 0.0f;

    // Apply chance modifer aura
    if (spellProto)
        if (Player* modOwner = GetSpellModOwner())
            modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_PROC_PER_MINUTE, PPM);

    return floor((WeaponSpeed * PPM) / 600.0f);   // result is chance in percents (probability = Speed_in_sec * (PPM / 60))
}

void Unit::Mount(uint32 mount, uint32 VehicleId, uint32 creatureEntry)
{
    if (mount)
        SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, mount);

    SetUnitFlag(UNIT_FLAG_MOUNT);

    if (Player* player = ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(player);

        // mount as a vehicle
        if (VehicleId)
        {
            if (CreateVehicleKit(VehicleId, creatureEntry))
            {
                GetVehicleKit()->Reset();

                // Send others that we now have a vehicle
                WorldPacket data(SMSG_PLAYER_VEHICLE_DATA, GetPackGUID().size() + 4);
                data << GetPackGUID();
                data << uint32(VehicleId);
                SendMessageToSet(&data, true);

                data.Initialize(SMSG_ON_CANCEL_EXPECTED_RIDE_VEHICLE_AURA, 0);
                player->GetSession()->SendPacket(&data);

                // mounts can also have accessories
                GetVehicleKit()->InstallAllAccessories(false);
            }
        }

        // unsummon pet
        Pet* pet = player->GetPet();
        if (pet)
        {
            Battleground* bg = ToPlayer()->GetBattleground();
            // don't unsummon pet in arena but SetFlag UNIT_FLAG_STUNNED to disable pet's interface
            if (bg && bg->isArena())
                pet->SetUnitFlag(UNIT_FLAG_STUNNED);
            else
                player->UnsummonPetTemporaryIfAny();
        }

        // xinef: if we have charmed npc, stun him also
        if (Unit* charm = player->GetCharm())
            if (charm->GetTypeId() == TYPEID_UNIT)
                charm->SetUnitFlag(UNIT_FLAG_STUNNED);

        WorldPacket data(SMSG_MOVE_SET_COLLISION_HGT, GetPackGUID().size() + 4 + 4);
        data << GetPackGUID();
        data << uint32(GameTime::GetGameTime().count());   // Packet counter
        data << player->GetCollisionHeight();
        player->GetSession()->SendPacket(&data);
    }

    RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_MOUNT);
}

void Unit::Dismount()
{
    if (!IsMounted())
        return;

    SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
    RemoveUnitFlag(UNIT_FLAG_MOUNT);

    if (Player* thisPlayer = ToPlayer())
    {
        WorldPacket data(SMSG_MOVE_SET_COLLISION_HGT, GetPackGUID().size() + 4 + 4);
        data << GetPackGUID();
        data << uint32(GameTime::GetGameTime().count());   // Packet counter
        data << thisPlayer->GetCollisionHeight();
        thisPlayer->GetSession()->SendPacket(&data);
    }

    WorldPacket data(SMSG_DISMOUNT, 8);
    data << GetPackGUID();
    SendMessageToSet(&data, true);

    // dismount as a vehicle
    if (GetTypeId() == TYPEID_PLAYER && GetVehicleKit())
    {
        // Send other players that we are no longer a vehicle
        data.Initialize(SMSG_PLAYER_VEHICLE_DATA, 8 + 4);
        data << GetPackGUID();
        data << uint32(0);
        ToPlayer()->SendMessageToSet(&data, true);
        // Remove vehicle from player
        RemoveVehicleKit();
    }

    RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_NOT_MOUNTED);

    // only resummon old pet if the player is already added to a map
    // this prevents adding a pet to a not created map which would otherwise cause a crash
    // (it could probably happen when logging in after a previous crash)
    if (Player* player = ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(player);

        if (Pet* pPet = player->GetPet())
        {
            if (pPet->HasUnitFlag(UNIT_FLAG_STUNNED) && !pPet->HasUnitState(UNIT_STATE_STUNNED))
                pPet->RemoveUnitFlag(UNIT_FLAG_STUNNED);
        }
        else
            player->ResummonPetTemporaryUnSummonedIfAny();

        // xinef: if we have charmed npc, remove stun also
        if (Unit* charm = player->GetCharm())
            if (charm->GetTypeId() == TYPEID_UNIT && !charm->HasUnitState(UNIT_STATE_STUNNED))
                charm->RemoveUnitFlag(UNIT_FLAG_STUNNED);
    }
}

void Unit::SetInCombatWith(Unit* enemy, uint32 duration)
{
    // Xinef: Dont allow to start combat with triggers
    if (enemy->GetTypeId() == TYPEID_UNIT && enemy->ToCreature()->IsTrigger())
        return;

    Unit* eOwner = enemy->GetCharmerOrOwnerOrSelf();
    if (eOwner->IsPvP() || eOwner->IsFFAPvP())
    {
        SetInCombatState(true, enemy, duration);
        return;
    }

    // check for duel
    if (eOwner->GetTypeId() == TYPEID_PLAYER && eOwner->ToPlayer()->duel)
    {
        Unit const* myOwner = GetCharmerOrOwnerOrSelf();
        if (((Player const*)eOwner)->duel->Opponent == myOwner)
        {
            SetInCombatState(true, enemy, duration);
            return;
        }
    }
    SetInCombatState(false, enemy, duration);
}

void Unit::SetImmuneToPC(bool apply, bool keepCombat)
{
    (void)keepCombat;
    if (apply)
        SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
    else
        RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC);
}

void Unit::SetImmuneToNPC(bool apply, bool keepCombat)
{
    (void)keepCombat;
    if (apply)
        SetUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
    else
        RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_NPC);
}

void Unit::CombatStart(Unit* victim, bool initialAggro)
{
    // Xinef: Dont allow to start combat with triggers
    if (victim->GetTypeId() == TYPEID_UNIT && victim->ToCreature()->IsTrigger())
        return;

    if (initialAggro)
    {
        // Make player victim stand up automatically
        if (victim->getStandState() && victim->IsPlayer())
        {
            victim->SetStandState(UNIT_STAND_STATE_STAND);
        }

        if (!victim->IsInCombat() && victim->GetTypeId() != TYPEID_PLAYER && !victim->ToCreature()->HasReactState(REACT_PASSIVE) && victim->ToCreature()->IsAIEnabled)
        {
            if (victim->IsPet())
                victim->ToCreature()->AI()->AttackedBy(this); // PetAI has special handler before AttackStart()
            else
            {
                victim->ToCreature()->AI()->AttackStart(this);
                // if the target is an NPC with a pet or minion, pet should react.
                if (Unit* victimControlledUnit = victim->GetFirstControlled())
                {
                    victimControlledUnit->SetInCombatWith(this);
                    SetInCombatWith(victimControlledUnit);
                    victimControlledUnit->AddThreat(this, 0.0f);
                }
            }

            // if unit has an owner, put owner in combat.
            if (Unit* victimOwner = victim->GetOwner())
            {
                if (!(victimOwner->IsInCombatWith(this)))
                {
                    /* warding off to not take over aggro for no reason
                    Using only AddThreat causes delay in attack */
                    if (!victimOwner->IsInCombat() && victimOwner->IsAIEnabled)
                    {
                        victimOwner->ToCreature()->AI()->AttackStart(this);
                    }
                    victimOwner->SetInCombatWith(this);
                    SetInCombatWith(victimOwner);
                    victimOwner->AddThreat(this, 0.0f);
                }
            }
        }

        bool alreadyInCombat = IsInCombat();

        SetInCombatWith(victim);
        victim->SetInCombatWith(this);

        // Xinef: If pet started combat - put owner in combat
        if (!alreadyInCombat && IsInCombat())
        {
            if (Unit* owner = GetOwner())
            {
                owner->SetInCombatWith(victim);
                victim->SetInCombatWith(owner);
            }
        }
    }

    Unit* who = victim->GetCharmerOrOwnerOrSelf();
    if (who->GetTypeId() == TYPEID_PLAYER)
        SetContestedPvP(who->ToPlayer());

    Player* player = GetCharmerOrOwnerPlayerOrPlayerItself();
    if (player && who->IsPvP() && (who->GetTypeId() != TYPEID_PLAYER || !player->duel || player->duel->Opponent != who))
    {
        player->UpdatePvP(true);
        player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);
    }
}

void Unit::CombatStartOnCast(Unit* target, bool initialAggro, uint32 duration)
{
    // Xinef: Dont allow to start combat with triggers
    if (target->GetTypeId() == TYPEID_UNIT && target->ToCreature()->IsTrigger())
        return;

    if (initialAggro)
    {
        SetInCombatWith(target, duration);

        // Xinef: If pet started combat - put owner in combat
        if (Unit* owner = GetOwner())
            owner->SetInCombatWith(target, duration);
    }

    Unit* who = target->GetCharmerOrOwnerOrSelf();
    if (who->GetTypeId() == TYPEID_PLAYER)
        SetContestedPvP(who->ToPlayer());

    Player* player = GetCharmerOrOwnerPlayerOrPlayerItself();
    if (player && who->IsPvP() && (who->GetTypeId() != TYPEID_PLAYER || !player->duel || player->duel->Opponent != who))
    {
        player->UpdatePvP(true);
        player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);
    }
}

void Unit::SetInCombatState(bool PvP, Unit* enemy, uint32 duration)
{
    // only alive units can be in combat
    if (!IsAlive())
        return;

    if (PvP)
        m_CombatTimer = std::max<uint32>(GetCombatTimer(), std::max<uint32>(5500, duration));
    else if (duration)
        m_CombatTimer = std::max<uint32>(GetCombatTimer(), duration);

    if (HasUnitState(UNIT_STATE_EVADE) || GetCreatureType() == CREATURE_TYPE_NON_COMBAT_PET)
        return;

    // xinef: if we somehow engage in combat (scripts, dunno) with player, remove this flag so he can fight back
    if (GetTypeId() == TYPEID_UNIT && enemy && IsImmuneToPC() && enemy->GetCharmerOrOwnerPlayerOrPlayerItself())
        SetImmuneToPC(false); // unit has engaged in combat, remove immunity so players can fight back

    if (IsInCombat())
        return;

    SetUnitFlag(UNIT_FLAG_IN_COMBAT);

    if (Creature* creature = ToCreature())
    {
        // Set home position at place of engaging combat for escorted creatures
        if ((IsAIEnabled && creature->AI()->IsEscorted()) ||
                GetMotionMaster()->GetCurrentMovementGeneratorType() == WAYPOINT_MOTION_TYPE ||
                GetMotionMaster()->GetCurrentMovementGeneratorType() == ESCORT_MOTION_TYPE)
            creature->SetHomePosition(GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation());

        if (enemy)
        {
            if (IsAIEnabled)
                creature->AI()->JustEngagedWith(enemy);

            if (creature->GetFormation())
                creature->GetFormation()->MemberEngagingTarget(creature, enemy);

            sScriptMgr->OnUnitEnterCombat(creature, enemy);
        }

        creature->RefreshSwimmingFlag();

        if (IsPet())
        {
            UpdateSpeed(MOVE_RUN, true);
            UpdateSpeed(MOVE_SWIM, true);
            UpdateSpeed(MOVE_FLIGHT, true);
        }

        if (!(creature->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_ALLOW_MOUNTED_COMBAT))
            Dismount();
        if (!IsStandState()) // pussywizard: already done in CombatStart(target, initialAggro) for the target, but when aggro'ing from MoveInLOS CombatStart is not called!
            SetStandState(UNIT_STAND_STATE_STAND);
    }

    for (Unit::ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end();)
    {
        Unit* controlled = *itr;
        ++itr;

        // Xinef: Dont set combat for passive units, they will evade in next update...
        if (controlled->GetTypeId() == TYPEID_UNIT && controlled->ToCreature()->HasReactState(REACT_PASSIVE))
            continue;

        controlled->SetInCombatState(PvP, enemy, duration);
    }

    if (Player* player = this->ToPlayer())
    {
        sScriptMgr->OnPlayerEnterCombat(player, enemy);
    }
}

void Unit::ClearInCombat()
{
    m_CombatTimer = 0;
    RemoveUnitFlag(UNIT_FLAG_IN_COMBAT);

    // Player's state will be cleared in Player::UpdateContestedPvP
    if (Creature* creature = ToCreature())
    {
        if (creature->GetCreatureTemplate() && creature->GetCreatureTemplate()->unit_flags & UNIT_FLAG_IMMUNE_TO_PC)
            SetImmuneToPC(true); // set immunity state to the one from db on evade

        ClearUnitState(UNIT_STATE_ATTACK_PLAYER);
        if (HasDynamicFlag(UNIT_DYNFLAG_TAPPED))
            ReplaceAllDynamicFlags(creature->GetCreatureTemplate()->dynamicflags);

        creature->SetAssistanceTimer(0);

        // Xinef: will be recalculated at follow movement generator initialization
        if (!IsPet() && !IsCharmed())
            return;
    }
    else if (Player* player = ToPlayer())
    {
        player->UpdatePotionCooldown();
        if (player->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
            for (uint8 i = 0; i < MAX_RUNES; ++i)
                player->SetGracePeriod(i, 0);
    }

    if (Player* player = this->ToPlayer())
    {
        sScriptMgr->OnPlayerLeaveCombat(player);
    }
}

void Unit::ClearInPetCombat()
{
    RemoveUnitFlag(UNIT_FLAG_PET_IN_COMBAT);
    RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_LEAVE_COMBAT);
    if (Unit* owner = GetOwner())
    {
        owner->RemoveUnitFlag(UNIT_FLAG_PET_IN_COMBAT);
    }
}

bool Unit::isTargetableForAttack(bool checkFakeDeath, Unit const* byWho) const
{
    if (!IsAlive())
        return false;

    if (HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE))
        return false;

    if (IsImmuneToPC() && byWho && byWho->GetCharmerOrOwnerPlayerOrPlayerItself())
        return false;

    if (GetTypeId() == TYPEID_PLAYER && ToPlayer()->IsGameMaster())
        return false;

    return !HasUnitState(UNIT_STATE_UNATTACKABLE) && (!checkFakeDeath || !HasUnitState(UNIT_STATE_DIED));
}

bool Unit::IsValidAttackTarget(Unit const* target, SpellInfo const* bySpell) const
{
    return _IsValidAttackTarget(target, bySpell);
}

// function based on function Unit::CanAttack from 13850 client
bool Unit::_IsValidAttackTarget(Unit const* target, SpellInfo const* bySpell, WorldObject const* obj) const
{
    ASSERT(target);

    // can't attack self
    if (this == target)
        return false;

    // can't attack unattackable units or GMs
    if (target->HasUnitState(UNIT_STATE_UNATTACKABLE)
            || (target->GetTypeId() == TYPEID_PLAYER && target->ToPlayer()->IsGameMaster()))
        return false;

    // can't attack own vehicle or passenger
    if (m_vehicle)
        if (IsOnVehicle(target) || m_vehicle->GetBase()->IsOnVehicle(target))
            if (!IsHostileTo(target)) // pussywizard: actually can attack own vehicle or passenger if it's hostile to us - needed for snobold in Gormok encounter
                return false;

    // can't attack invisible (ignore stealth for aoe spells) also if the area being looked at is from a spell use the dynamic object created instead of the casting unit.
    //Ignore stealth if target is player and unit in combat with same player
    if ((!bySpell || !bySpell->HasAttribute(SPELL_ATTR6_IGNORE_PHASE_SHIFT)) && (obj ? !obj->CanSeeOrDetect(target, bySpell && bySpell->IsAffectingArea()) : !CanSeeOrDetect(target, (bySpell && bySpell->IsAffectingArea()) || (target->GetTypeId() == TYPEID_PLAYER && target->HasStealthAura() && target->IsInCombat() && IsInCombatWith(target)))))
        return false;

    // can't attack dead
    if ((!bySpell || !bySpell->IsAllowingDeadTarget()) && !target->IsAlive())
        return false;

    // can't attack untargetable
    if ((!bySpell || !bySpell->HasAttribute(SPELL_ATTR6_CAN_TARGET_UNTARGETABLE))
            && target->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
        return false;

    if (Player const* playerAttacker = ToPlayer())
    {
        if (playerAttacker->HasPlayerFlag(PLAYER_FLAGS_UBER) || playerAttacker->IsSpectator())
            return false;
    }
    // check flags
    if (target->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_TAXI_FLIGHT | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_NON_ATTACKABLE_2)
            || (!HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) && target->IsImmuneToNPC())
            || (!target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) && IsImmuneToNPC())
            || (HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) && target->IsImmuneToPC())
            // check if this is a world trigger cast - GOs are using world triggers to cast their spells, so we need to ignore their immunity flag here, this is a temp workaround, needs removal when go cast is implemented properly
            || ((GetEntry() != WORLD_TRIGGER && (!obj || !obj->isType(TYPEMASK_GAMEOBJECT | TYPEMASK_DYNAMICOBJECT))) && target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) && IsImmuneToPC()))
        return false;

    // CvC case - can attack each other only when one of them is hostile
    if (!HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) && !target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
        return GetReactionTo(target) <= REP_HOSTILE || target->GetReactionTo(this) <= REP_HOSTILE;

    // PvP, PvC, CvP case
    // can't attack friendly targets
    ReputationRank repThisToTarget = GetReactionTo(target);
    ReputationRank repTargetToThis;

    if (repThisToTarget > REP_NEUTRAL
            || (repTargetToThis = target->GetReactionTo(this)) > REP_NEUTRAL)
        return false;

    // Not all neutral creatures can be attacked (even some unfriendly faction does not react aggresive to you, like Sporaggar)
    if (repThisToTarget == REP_NEUTRAL &&
            repTargetToThis <= REP_NEUTRAL)
    {
        Player* owner = GetAffectingPlayer();
        Unit const* const thisUnit = owner ? owner : this;
        if  (!(target->GetTypeId() == TYPEID_PLAYER && thisUnit->GetTypeId() == TYPEID_PLAYER) &&
                !(target->GetTypeId() == TYPEID_UNIT && thisUnit->GetTypeId() == TYPEID_UNIT))
        {
            Player const* player = target->GetTypeId() == TYPEID_PLAYER ? target->ToPlayer() : thisUnit->ToPlayer();
            Unit const* creature = target->GetTypeId() == TYPEID_UNIT ? target : thisUnit;

            if (FactionTemplateEntry const* factionTemplate = creature->GetFactionTemplateEntry())
            {
                if (!(player->GetReputationMgr().GetForcedRankIfAny(factionTemplate)))
                    if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionTemplate->faction))
                        if (FactionState const* repState = player->GetReputationMgr().GetState(factionEntry))
                            if (!(repState->Flags & FACTION_FLAG_AT_WAR))
                                return false;
            }
        }
    }

    Creature const* creatureAttacker = ToCreature();
    if (creatureAttacker && creatureAttacker->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT)
        return false;

    Player const* playerAffectingAttacker = HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) ? GetAffectingPlayer() : nullptr;
    Player const* playerAffectingTarget = target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) ? target->GetAffectingPlayer() : nullptr;

    // check duel - before sanctuary checks
    if (playerAffectingAttacker && playerAffectingTarget)
        if (playerAffectingAttacker->duel && playerAffectingAttacker->duel->Opponent == playerAffectingTarget && playerAffectingAttacker->duel->State == DUEL_STATE_IN_PROGRESS)
            return true;

    // PvP case - can't attack when attacker or target are in sanctuary
    // however, 13850 client doesn't allow to attack when one of the unit's has sanctuary flag and is pvp
    if (target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) && HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) && (target->IsInSanctuary() || IsInSanctuary()))
        return false;

    // additional checks - only PvP case
    if (playerAffectingAttacker && playerAffectingTarget)
    {
        if (!IsPvP() && bySpell && bySpell->IsAffectingArea() && !bySpell->HasAttribute(SPELL_ATTR5_IGNORE_AREA_EFFECT_PVP_CHECK))
            return false;

        if (target->IsPvP())
            return true;

        if (IsFFAPvP() && target->IsFFAPvP())
            return true;

        return HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_UNK1) || target->HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_UNK1);
    }
    return true;
}

bool Unit::IsValidAssistTarget(Unit const* target) const
{
    return _IsValidAssistTarget(target, nullptr);
}

// function based on function Unit::CanAssist from 13850 client
bool Unit::_IsValidAssistTarget(Unit const* target, SpellInfo const* bySpell) const
{
    ASSERT(target);

    // can assist to self
    if (this == target)
        return true;

    // can't assist unattackable units or GMs
    if (target->HasUnitState(UNIT_STATE_UNATTACKABLE)
            || (target->GetTypeId() == TYPEID_PLAYER && target->ToPlayer()->IsGameMaster()))
        return false;

    // can't assist own vehicle or passenger
    if (m_vehicle)
        if (IsOnVehicle(target) || m_vehicle->GetBase()->IsOnVehicle(target))
            return false;

    // can't assist invisible
    if ((!bySpell || !bySpell->HasAttribute(SPELL_ATTR6_IGNORE_PHASE_SHIFT)) && !CanSeeOrDetect(target, bySpell && bySpell->IsAffectingArea()))
        return false;

    // can't assist dead
    if ((!bySpell || !bySpell->IsAllowingDeadTarget()) && !target->IsAlive())
        return false;

    // can't assist untargetable
    if ((!bySpell || !bySpell->HasAttribute(SPELL_ATTR6_CAN_TARGET_UNTARGETABLE))
            && target->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
        return false;

    if (!bySpell || !bySpell->HasAttribute(SPELL_ATTR6_CAN_ASSIST_IMMUNE_PC))
    {
        // xinef: do not allow to assist non attackable units
        if (target->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
            return false;

        if (HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
        {
            if (target->IsImmuneToPC())
                return false;
        }
        else
        {
            if (target->IsImmuneToNPC())
                return false;
        }
    }

    // can't assist non-friendly targets
    if (GetReactionTo(target) < REP_NEUTRAL
            && target->GetReactionTo(this) < REP_NEUTRAL
            && (!ToCreature() || !(ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT)))
        return false;

    // PvP case
    if (target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
    {
        Player const* targetPlayerOwner = target->GetAffectingPlayer();
        if (HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
        {
            Player const* selfPlayerOwner = GetAffectingPlayer();
            if (selfPlayerOwner && targetPlayerOwner)
            {
                // can't assist player which is dueling someone
                if (selfPlayerOwner != targetPlayerOwner
                        && targetPlayerOwner->duel)
                    return false;
            }
            // can't assist player in ffa_pvp zone from outside
            if (target->IsFFAPvP() && !IsFFAPvP())
                return false;

            // can't assist player out of sanctuary from sanctuary if has pvp enabled
            if (target->IsPvP())
                if (IsInSanctuary() && !target->IsInSanctuary())
                    return false;
        }
    }
    // PvC case - player can assist creature only if has specific type flags
    // !target->HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED) &&
    else if (HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED)
             && (!bySpell || !bySpell->HasAttribute(SPELL_ATTR6_CAN_ASSIST_IMMUNE_PC))
             && !target->IsPvP())
    {
        if (Creature const* creatureTarget = target->ToCreature())
            return creatureTarget->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT || creatureTarget->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_CAN_ASSIST;
    }
    return true;
}

int32 Unit::ModifyHealth(int32 dVal)
{
    int32 gain = 0;

    if (dVal == 0)
        return 0;

    int32 curHealth = (int32)GetHealth();

    int32 val = dVal + curHealth;
    if (val <= 0)
    {
        SetHealth(0);
        return -curHealth;
    }

    int32 maxHealth = (int32)GetMaxHealth();

    if (val < maxHealth)
    {
        SetHealth(val);
        gain = val - curHealth;
    }
    else if (curHealth != maxHealth)
    {
        SetHealth(maxHealth);
        gain = maxHealth - curHealth;
    }

    return gain;
}

int32 Unit::GetHealthGain(int32 dVal)
{
    int32 gain = 0;

    if (dVal == 0)
        return 0;

    int32 curHealth = (int32)GetHealth();

    int32 val = dVal + curHealth;
    if (val <= 0)
    {
        return -curHealth;
    }

    int32 maxHealth = (int32)GetMaxHealth();

    if (val < maxHealth)
        gain = dVal;
    else if (curHealth != maxHealth)
        gain = maxHealth - curHealth;

    return gain;
}

// returns negative amount on power reduction
int32 Unit::ModifyPower(Powers power, int32 dVal, bool withPowerUpdate /*= true*/)
{
    if (dVal == 0)
        return 0;

    int32 gain = 0;

    int32 curPower = (int32)GetPower(power);

    int32 val = dVal + curPower;
    if (val <= 0)
    {
        SetPower(power, 0, withPowerUpdate);
        return -curPower;
    }

    int32 maxPower = (int32)GetMaxPower(power);

    if (val < maxPower)
    {
        SetPower(power, val, withPowerUpdate);
        gain = val - curPower;
    }
    else if (curPower != maxPower)
    {
        SetPower(power, maxPower, withPowerUpdate);
        gain = maxPower - curPower;
    }

    if (GetAI())
    {
        GetAI()->OnPowerUpdate(power, gain, dVal, curPower);
    }

    return gain;
}

// returns negative amount on power reduction
int32 Unit::ModifyPowerPct(Powers power, float pct, bool apply)
{
    float amount = (float)GetMaxPower(power);
    ApplyPercentModFloatVar(amount, pct, apply);

    return ModifyPower(power, (int32)amount - (int32)GetMaxPower(power));
}

bool Unit::IsAlwaysVisibleFor(WorldObject const* seer) const
{
    if (WorldObject::IsAlwaysVisibleFor(seer))
        return true;

    // Always seen by owner
    if (ObjectGuid guid = GetCharmerOrOwnerGUID())
        if (seer->GetGUID() == guid)
            return true;

    if (Player const* seerPlayer = seer->ToPlayer())
        if (Unit* owner =  GetOwner())
            if (Player* ownerPlayer = owner->ToPlayer())
                if (ownerPlayer->IsGroupVisibleFor(seerPlayer))
                    return true;

    return false;
}

bool Unit::IsAlwaysDetectableFor(WorldObject const* seer) const
{
    if (WorldObject::IsAlwaysDetectableFor(seer))
        return true;

    if (HasAuraTypeWithCaster(SPELL_AURA_MOD_STALKED, seer->GetGUID()))
        return true;

    if (Player* ownerPlayer = GetSpellModOwner())
        if (Player const* seerPlayer = seer->ToPlayer())
        {
            if (ownerPlayer->IsGroupVisibleFor(seerPlayer))
                return true;
        }

    return false;
}

void Unit::SetVisible(bool x)
{
    if (!x)
        m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, SEC_GAMEMASTER);
    else
        m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, SEC_PLAYER);

    UpdateObjectVisibility();
}

void Unit::SetModelVisible(bool on)
{
    if (on)
        RemoveAurasDueToSpell(24401);
    else
        CastSpell(this, 24401, true);
}

void Unit::UpdateSpeed(UnitMoveType mtype, bool forced)
{
    int32 main_speed_mod  = 0;
    float stack_bonus     = 1.0f;
    float non_stack_bonus = 1.0f;

    switch (mtype)
    {
        // Only apply debuffs
        case MOVE_FLIGHT_BACK:
        case MOVE_RUN_BACK:
        case MOVE_SWIM_BACK:
        case MOVE_WALK:
            break;
        case MOVE_RUN:
            {
                if (IsMounted()) // Use on mount auras
                {
                    main_speed_mod  = GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED);
                    stack_bonus     = GetTotalAuraMultiplier(SPELL_AURA_MOD_MOUNTED_SPEED_ALWAYS);
                    non_stack_bonus += GetMaxPositiveAuraModifier(SPELL_AURA_MOD_MOUNTED_SPEED_NOT_STACK) / 100.0f;
                }
                else
                {
                    main_speed_mod  = GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_SPEED);
                    stack_bonus     = GetTotalAuraMultiplier(SPELL_AURA_MOD_SPEED_ALWAYS);
                    non_stack_bonus += GetMaxPositiveAuraModifier(SPELL_AURA_MOD_SPEED_NOT_STACK) / 100.0f;
                }
                break;
            }
        case MOVE_SWIM:
            {
                // xinef: check for forced_speed_mod of sea turtle
                Unit::AuraEffectList const& swimAuras = GetAuraEffectsByType(SPELL_AURA_MOD_INCREASE_SWIM_SPEED);
                for (Unit::AuraEffectList::const_iterator itr = swimAuras.begin(); itr != swimAuras.end(); ++itr)
                {
                    // xinef: sea turtle only, it is not affected by any increasing / decreasing effects
                    if ((*itr)->GetId() == 64731 /*SPELL_SEA_TURTLE*/)
                    {
                        SetSpeed(mtype, AddPct(non_stack_bonus, (*itr)->GetAmount()), forced);
                        return;
                    }
                    else if (
                        // case: increase speed
                        ((*itr)->GetAmount() > 0 && (*itr)->GetAmount() > main_speed_mod) ||
                        // case: decrease speed
                        ((*itr)->GetAmount() < 0 && (*itr)->GetAmount() < main_speed_mod)
                     )
                    {
                        main_speed_mod = (*itr)->GetAmount();
                    }
                }
                break;
            }
        case MOVE_FLIGHT:
            {
                if (GetTypeId() == TYPEID_UNIT && IsControlledByPlayer()) // not sure if good for pet
                {
                    main_speed_mod  = GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_VEHICLE_FLIGHT_SPEED);
                    stack_bonus     = GetTotalAuraMultiplier(SPELL_AURA_MOD_VEHICLE_SPEED_ALWAYS);

                    // for some spells this mod is applied on vehicle owner
                    int32 owner_speed_mod = 0;

                    if (Unit* owner = GetCharmer())
                        owner_speed_mod = owner->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_VEHICLE_FLIGHT_SPEED);

                    main_speed_mod = std::max(main_speed_mod, owner_speed_mod);
                }
                else if (IsMounted())
                {
                    main_speed_mod  = GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED);
                    stack_bonus     = GetTotalAuraMultiplier(SPELL_AURA_MOD_MOUNTED_FLIGHT_SPEED_ALWAYS);
                }
                else             // Use not mount (shapeshift for example) auras (should stack)
                    main_speed_mod  = GetTotalAuraModifier(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED) + GetTotalAuraModifier(SPELL_AURA_MOD_INCREASE_VEHICLE_FLIGHT_SPEED);

                non_stack_bonus += GetMaxPositiveAuraModifier(SPELL_AURA_MOD_FLIGHT_SPEED_NOT_STACK) / 100.0f;

                // Update speed for vehicle if available
                if (GetTypeId() == TYPEID_PLAYER && GetVehicle())
                    GetVehicleBase()->UpdateSpeed(MOVE_FLIGHT, true);
                break;
            }
        default:
            LOG_ERROR("entities.unit", "Unit::UpdateSpeed: Unsupported move type ({})", mtype);
            return;
    }

    // now we ready for speed calculation
    float speed = std::max(non_stack_bonus, stack_bonus);
    if (main_speed_mod)
        AddPct(speed, main_speed_mod);

    switch (mtype)
    {
        case MOVE_RUN:
        case MOVE_SWIM:
        case MOVE_FLIGHT:
        {
            // Set creature speed rate
            if (GetTypeId() == TYPEID_UNIT)
            {
                if (IsPet() && ToPet()->isControlled() && IsControlledByPlayer())
                {
                    // contant value for player pets
                    speed *= 1.15f;
                }
                else
                {
                    speed *= ToCreature()->GetCreatureTemplate()->speed_run; // at this point, MOVE_WALK is never reached
                }
            }

            // Normalize speed by 191 aura SPELL_AURA_USE_NORMAL_MOVEMENT_SPEED if need
            /// @todo possible affect only on MOVE_RUN
            if (int32 normalization = GetMaxPositiveAuraModifier(SPELL_AURA_USE_NORMAL_MOVEMENT_SPEED))
            {
                if (Creature* creature = ToCreature())
                {
                    uint32 immuneMask = creature->GetCreatureTemplate()->MechanicImmuneMask;
                    if (immuneMask & (1 << (MECHANIC_SNARE - 1)) || immuneMask & (1 << (MECHANIC_DAZE - 1)))
                        break;
                }

                // Use speed from aura
                float max_speed = normalization / (IsControlledByPlayer() ? playerBaseMoveSpeed[mtype] : baseMoveSpeed[mtype]);
                if (speed > max_speed)
                    speed = max_speed;
            }
            break;
        }
        default:
            break;
    }

    int32 slowFromHealth = 0;
    Creature* creature = ToCreature();
    // ignore pets, player owned vehicles, and mobs immune to snare
    if (creature
        && !IsPet()
        && !(IsControlledByPlayer() && IsVehicle())
        && !(creature->HasMechanicTemplateImmunity(MECHANIC_SNARE))
        && !(creature->IsDungeonBoss()))
    {
        // 1.6% for each % under 30.
        // use min(0, health-30) so that we don't boost mobs above 30.
        slowFromHealth = (int32) std::min(0.0f, (1.66f * (GetHealthPct() - 30.0f)));
    }

    if (slowFromHealth)
    {
        AddPct(speed, slowFromHealth);
    }

    // Apply strongest slow aura mod to speed
    int32 slow = GetMaxNegativeAuraModifier(SPELL_AURA_MOD_DECREASE_SPEED);
    if (slow)
        AddPct(speed, slow);

    if (float minSpeedMod = (float)GetMaxPositiveAuraModifier(SPELL_AURA_MOD_MINIMUM_SPEED))
    {
        float base_speed = (GetTypeId() == TYPEID_UNIT ? ToCreature()->GetCreatureTemplate()->speed_run : 1.0f);
        float min_speed = base_speed * (minSpeedMod / 100.0f);
        if (speed < min_speed)
            speed = min_speed;
    }

    SetSpeed(mtype, speed, forced);
}

float Unit::GetSpeed(UnitMoveType mtype) const
{
    return m_speed_rate[mtype] * (IsControlledByPlayer() ? playerBaseMoveSpeed[mtype] : baseMoveSpeed[mtype]);
}

void Unit::SetSpeed(UnitMoveType mtype, float rate, bool forced)
{
    if (rate < 0)
        rate = 0.0f;

    // Update speed only on change
    if (m_speed_rate[mtype] == rate)
        return;

    m_speed_rate[mtype] = rate;

    propagateSpeedChange();

    WorldPacket data;
    if (!forced)
    {
        switch (mtype)
        {
            case MOVE_WALK:
                data.Initialize(MSG_MOVE_SET_WALK_SPEED, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_RUN:
                data.Initialize(MSG_MOVE_SET_RUN_SPEED, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_RUN_BACK:
                data.Initialize(MSG_MOVE_SET_RUN_BACK_SPEED, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_SWIM:
                data.Initialize(MSG_MOVE_SET_SWIM_SPEED, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_SWIM_BACK:
                data.Initialize(MSG_MOVE_SET_SWIM_BACK_SPEED, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_TURN_RATE:
                data.Initialize(MSG_MOVE_SET_TURN_RATE, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_FLIGHT:
                data.Initialize(MSG_MOVE_SET_FLIGHT_SPEED, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_FLIGHT_BACK:
                data.Initialize(MSG_MOVE_SET_FLIGHT_BACK_SPEED, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            case MOVE_PITCH_RATE:
                data.Initialize(MSG_MOVE_SET_PITCH_RATE, 8 + 4 + 2 + 4 + 4 + 4 + 4 + 4 + 4 + 4);
                break;
            default:
                LOG_ERROR("entities.unit", "Unit::SetSpeed: Unsupported move type ({}), data not sent to client.", mtype);
                return;
        }

        data << GetPackGUID();
        BuildMovementPacket(&data);
        data << float(GetSpeed(mtype));
        SendMessageToSet(&data, true);
    }
    else
    {
        if (GetTypeId() == TYPEID_PLAYER)
        {
            // register forced speed changes for WorldSession::HandleForceSpeedChangeAck
            // and do it only for real sent packets and use run for run/mounted as client expected
            ++ToPlayer()->m_forced_speed_changes[mtype];

            // Xinef: update speed of pet also
            if (!IsInCombat())
            {
                Unit* pet = ToPlayer()->GetPet();
                if (!pet)
                    pet = GetCharm();

                // xinef: do not affect vehicles and possesed pets
                if (pet && (pet->HasUnitFlag(UNIT_FLAG_POSSESSED) || pet->IsVehicle()))
                    pet = nullptr;

                if (pet && pet->GetTypeId() == TYPEID_UNIT && !pet->IsInCombat() && pet->GetMotionMaster()->GetCurrentMovementGeneratorType() == FOLLOW_MOTION_TYPE)
                    pet->UpdateSpeed(mtype, forced);
                if (Unit* critter = ObjectAccessor::GetUnit(*this, GetCritterGUID()))
                    critter->UpdateSpeed(mtype, forced);
            }
            ToPlayer()->SetCanTeleport(true);
        }

        switch (mtype)
        {
            case MOVE_WALK:
                data.Initialize(SMSG_FORCE_WALK_SPEED_CHANGE, 16);
                break;
            case MOVE_RUN:
                data.Initialize(SMSG_FORCE_RUN_SPEED_CHANGE, 17);
                break;
            case MOVE_RUN_BACK:
                data.Initialize(SMSG_FORCE_RUN_BACK_SPEED_CHANGE, 16);
                break;
            case MOVE_SWIM:
                data.Initialize(SMSG_FORCE_SWIM_SPEED_CHANGE, 16);
                break;
            case MOVE_SWIM_BACK:
                data.Initialize(SMSG_FORCE_SWIM_BACK_SPEED_CHANGE, 16);
                break;
            case MOVE_TURN_RATE:
                data.Initialize(SMSG_FORCE_TURN_RATE_CHANGE, 16);
                break;
            case MOVE_FLIGHT:
                data.Initialize(SMSG_FORCE_FLIGHT_SPEED_CHANGE, 16);
                break;
            case MOVE_FLIGHT_BACK:
                data.Initialize(SMSG_FORCE_FLIGHT_BACK_SPEED_CHANGE, 16);
                break;
            case MOVE_PITCH_RATE:
                data.Initialize(SMSG_FORCE_PITCH_RATE_CHANGE, 16);
                break;
            default:
                LOG_ERROR("entities.unit", "Unit::SetSpeed: Unsupported move type ({}), data not sent to client.", mtype);
                return;
        }
        data << GetPackGUID();
        data << (uint32)0;                                  // moveEvent, NUM_PMOVE_EVTS = 0x39
        if (mtype == MOVE_RUN)
            data << uint8(0);                               // new 2.1.0
        data << float(GetSpeed(mtype));
        SendMessageToSet(&data, true);
    }
}

void Unit::setDeathState(DeathState s, bool despawn)
{
    // death state needs to be updated before RemoveAllAurasOnDeath() calls HandleChannelDeathItem(..) so that
    // it can be used to check creation of death items (such as soul shards).

    if (s != DeathState::Alive && s != DeathState::JustRespawned)
    {
        CombatStop();
        GetThreatMgr().ClearAllThreat();
        getHostileRefMgr().deleteReferences();
        ClearComboPointHolders();                           // any combo points pointed to unit lost at it death

        if (IsNonMeleeSpellCast(false))
            InterruptNonMeleeSpells(false);

        UnsummonAllTotems(true);
        RemoveAllControlled(true);
        RemoveAllAurasOnDeath();
    }

    if (s == DeathState::JustDied)
    {
        // remove aurastates allowing special moves
        ClearAllReactives();
        ClearDiminishings();

        GetMotionMaster()->Clear(false);
        GetMotionMaster()->MoveIdle();

        // Xinef: Remove Hover so the corpse can fall to the ground
        SetHover(false);

        if (despawn)
            DisableSpline();
        else
            StopMoving();

        // without this when removing IncreaseMaxHealth aura player may stuck with 1 hp
        // do not why since in IncreaseMaxHealth currenthealth is checked
        SetHealth(0);
        SetPower(getPowerType(), 0);

        // Stop emote on death
        SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);

        // players in instance don't have ZoneScript, but they have InstanceScript
        if (ZoneScript* zoneScript = GetZoneScript() ? GetZoneScript() : (ZoneScript*)GetInstanceScript())
            zoneScript->OnUnitDeath(this);
    }
    else if (s == DeathState::JustRespawned)
    {
        RemoveFlag (UNIT_FIELD_FLAGS, UNIT_FLAG_SKINNABLE); // clear skinnable for creature and player (at battleground)
    }

    m_deathState = s;
}

/*########################################
########                          ########
########       AGGRO SYSTEM       ########
########                          ########
########################################*/
bool Unit::CanHaveThreatList() const
{
    // only creatures can have threat list
    if (GetTypeId() != TYPEID_UNIT)
        return false;

    // only alive units can have threat list
    if (!IsAlive() || isDying())
        return false;

    // totems can not have threat list
    if (ToCreature()->IsTotem())
        return false;

    // vehicles can not have threat list
    if (ToCreature()->IsVehicle() && GetMap()->IsBattlegroundOrArena())
        return false;

    // summons can not have a threat list, unless they are controlled by a creature
    if (HasUnitTypeMask(UNIT_MASK_MINION | UNIT_MASK_GUARDIAN | UNIT_MASK_CONTROLABLE_GUARDIAN) && ((Pet*)this)->GetOwnerGUID().IsPlayer())
        return false;

    return true;
}

//======================================================================

float Unit::ApplyTotalThreatModifier(float fThreat, SpellSchoolMask schoolMask)
{
    if (!HasAuraType(SPELL_AURA_MOD_THREAT) || fThreat < 0)
        return fThreat;

    SpellSchools school = GetFirstSchoolInMask(schoolMask);

    return fThreat * m_threatModifier[school];
}

//======================================================================

void Unit::AddThreat(Unit* victim, float fThreat, SpellSchoolMask schoolMask, SpellInfo const* threatSpell)
{
    // Only mobs can manage threat lists
    if (CanHaveThreatList() && !HasUnitState(UNIT_STATE_EVADE))
    {
        m_ThreatMgr.AddThreat(victim, fThreat, schoolMask, threatSpell);
    }
}

//======================================================================

void Unit::TauntApply(Unit* taunter)
{
    ASSERT(GetTypeId() == TYPEID_UNIT);

    if (!taunter || (taunter->GetTypeId() == TYPEID_PLAYER && taunter->ToPlayer()->IsGameMaster()))
        return;

    if (!CanHaveThreatList())
        return;

    Creature* creature = ToCreature();

    if (creature->HasReactState(REACT_PASSIVE))
        return;

    Unit* target = GetVictim();
    if (target && target == taunter)
        return;

    SetInFront(taunter);
    SetGuidValue(UNIT_FIELD_TARGET, taunter->GetGUID());

    if (creature->IsAIEnabled)
        creature->AI()->AttackStart(taunter);

    //m_ThreatMgr.tauntApply(taunter);
}

//======================================================================

void Unit::TauntFadeOut(Unit* taunter)
{
    ASSERT(GetTypeId() == TYPEID_UNIT);

    if (!taunter || (taunter->GetTypeId() == TYPEID_PLAYER && taunter->ToPlayer()->IsGameMaster()))
        return;

    if (!CanHaveThreatList())
        return;

    Creature* creature = ToCreature();

    if (creature->HasReactState(REACT_PASSIVE))
        return;

    Unit* target = GetVictim();
    if (!target || target != taunter)
        return;

    if (m_ThreatMgr.isThreatListEmpty())
    {
        if (creature->IsAIEnabled)
            creature->AI()->EnterEvadeMode(CreatureAI::EVADE_REASON_NO_HOSTILES);
        return;
    }

    target = creature->SelectVictim();  // might have more taunt auras remaining

    if (target && target != taunter)
    {
        SetGuidValue(UNIT_FIELD_TARGET, target->GetGUID());
        SetInFront(target);
        if (creature->IsAIEnabled)
            creature->AI()->AttackStart(target);
    }
}

//======================================================================

Unit* Creature::SelectVictim()
{
    // function provides main threat functionality
    // next-victim-selection algorithm and evade mode are called
    // threat list sorting etc.

    Unit* target = nullptr;

    // First checking if we have some taunt on us
    AuraEffectList const& tauntAuras = GetAuraEffectsByType(SPELL_AURA_MOD_TAUNT);
    if (!tauntAuras.empty())
        for (Unit::AuraEffectList::const_reverse_iterator itr = tauntAuras.rbegin(); itr != tauntAuras.rend(); ++itr)
            if (Unit* caster = (*itr)->GetCaster())
                if (CanCreatureAttack(caster) && !caster->HasAuraTypeWithCaster(SPELL_AURA_IGNORED, GetGUID()))
                {
                    target = caster;
                    break;
                }

    if (CanHaveThreatList())
    {
        if (!target && !m_ThreatMgr.isThreatListEmpty())
            target = m_ThreatMgr.getHostileTarget();
    }
    else if (!HasReactState(REACT_PASSIVE))
    {
        // we have player pet probably
        target = getAttackerForHelper();
        if (!target && IsSummon())
            if (Unit* owner = ToTempSummon()->GetOwner())
            {
                if (owner->IsInCombat())
                    target = owner->getAttackerForHelper();
                if (!target)
                    for (ControlSet::const_iterator itr = owner->m_Controlled.begin(); itr != owner->m_Controlled.end(); ++itr)
                        if ((*itr)->IsInCombat())
                        {
                            target = (*itr)->getAttackerForHelper();
                            if (target)
                                break;
                        }
            }
    }
    else
        return nullptr;

    if (target && CanCreatureAttack(target))
    {
        SetInFront(target);
        return target;
    }

    // last case when creature must not go to evade mode:
    // it in combat but attacker not make any damage and not enter to aggro radius to have record in threat list
    // Note: creature does not have targeted movement generator but has attacker in this case
    for (AttackerSet::const_iterator itr = m_attackers.begin(); itr != m_attackers.end(); ++itr)
        if ((*itr) && CanCreatureAttack(*itr) && (*itr)->GetTypeId() != TYPEID_PLAYER && !(*itr)->ToCreature()->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN))
            return nullptr;

    if (GetVehicle())
        return nullptr;

    // pussywizard: not sure why it's here
    // pussywizard: can't evade when having invisibility aura with duration? o_O
    Unit::AuraEffectList const& iAuras = GetAuraEffectsByType(SPELL_AURA_MOD_INVISIBILITY);
    if (!iAuras.empty())
    {
        for (Unit::AuraEffectList::const_iterator itr = iAuras.begin(); itr != iAuras.end(); ++itr)
            if ((*itr)->GetBase()->IsPermanent())
            {
                AI()->EnterEvadeMode(CreatureAI::EVADE_REASON_NO_HOSTILES);
                break;
            }
        return nullptr;
    }

    // Last chance: creature group
    if (CreatureGroup* group = GetFormation())
    {
        if (Unit* groupTarget = group->GetNewTargetForMember(this))
        {
            SetInFront(groupTarget);
            return groupTarget;
        }
    }

    // enter in evade mode in other case
    AI()->EnterEvadeMode();

    return nullptr;
}

//======================================================================
//======================================================================
//======================================================================

float Unit::ApplyEffectModifiers(SpellInfo const* spellProto, uint8 effect_index, float value) const
{
    if (Player* modOwner = GetSpellModOwner())
    {
        modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_ALL_EFFECTS, value);
        switch (effect_index)
        {
            case 0:
                modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_EFFECT1, value);
                break;
            case 1:
                modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_EFFECT2, value);
                break;
            case 2:
                modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_EFFECT3, value);
                break;
        }
    }
    return value;
}

// function uses real base points (typically value - 1)
int32 Unit::CalculateSpellDamage(Unit const* target, SpellInfo const* spellProto, uint8 effect_index, int32 const* basePoints) const
{
    return spellProto->Effects[effect_index].CalcValue(this, basePoints, target);
}

int32 Unit::CalcSpellDuration(SpellInfo const* spellProto)
{
    uint8 comboPoints = GetComboPoints();

    int32 minduration = spellProto->GetDuration();
    int32 maxduration = spellProto->GetMaxDuration();

    int32 duration;

    if (comboPoints && minduration != -1 && minduration != maxduration)
        duration = minduration + int32((maxduration - minduration) * comboPoints / 5);
    else
        duration = minduration;

    return duration;
}

int32 Unit::ModSpellDuration(SpellInfo const* spellProto, Unit const* target, int32 duration, bool positive, uint32 effectMask)
{
    // don't mod permanent auras duration
    if (duration < 0)
        return duration;

    // some auras are not affected by duration modifiers
    if (spellProto->HasAttribute(SPELL_ATTR7_NO_TARGET_DURATION_MOD))
        return duration;

    // cut duration only of negative effects
    // xinef: also calculate self casts, spell can be reflected for example
    if (!positive)
    {
        int32 mechanic = spellProto->GetSpellMechanicMaskByEffectMask(effectMask);

        int32 durationMod;
        int32 durationMod_always = 0;
        int32 durationMod_not_stack = 0;

        for (uint8 i = 1; i <= MECHANIC_ENRAGED; ++i)
        {
            if (!(mechanic & 1 << i))
                continue;

            // Xinef: spells affecting movement imparing effects should not reduce duration if disoriented mechanic is present
            if (i == MECHANIC_SNARE && (mechanic & (1 << MECHANIC_DISORIENTED)))
                continue;

            // Find total mod value (negative bonus)
            int32 new_durationMod_always = target->GetTotalAuraModifierByMiscValue(SPELL_AURA_MECHANIC_DURATION_MOD, i);
            // Find max mod (negative bonus)
            int32 new_durationMod_not_stack = target->GetMaxNegativeAuraModifierByMiscValue(SPELL_AURA_MECHANIC_DURATION_MOD_NOT_STACK, i);
            // Check if mods applied before were weaker
            if (new_durationMod_always < durationMod_always)
                durationMod_always = new_durationMod_always;
            if (new_durationMod_not_stack < durationMod_not_stack)
                durationMod_not_stack = new_durationMod_not_stack;
        }

        // Select strongest negative mod
        if (durationMod_always > durationMod_not_stack)
            durationMod = durationMod_not_stack;
        else
            durationMod = durationMod_always;

        if (durationMod != 0)
            AddPct(duration, durationMod);

        // there are only negative mods currently
        durationMod_always = target->GetTotalAuraModifierByMiscValue(SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL, spellProto->Dispel);
        durationMod_not_stack = target->GetMaxNegativeAuraModifierByMiscValue(SPELL_AURA_MOD_AURA_DURATION_BY_DISPEL_NOT_STACK, spellProto->Dispel);

        durationMod = 0;
        if (durationMod_always > durationMod_not_stack)
            durationMod += durationMod_not_stack;
        else
            durationMod += durationMod_always;

        if (durationMod != 0)
            AddPct(duration, durationMod);
    }
    else
    {
        // else positive mods here, there are no currently
        // when there will be, change GetTotalAuraModifierByMiscValue to GetTotalPositiveAuraModifierByMiscValue
    }

    // Glyphs which increase duration of selfcasted buffs
    if (target == this)
    {
        switch (spellProto->SpellFamilyName)
        {
            case SPELLFAMILY_DRUID:
                if (spellProto->SpellFamilyFlags[0] & 0x100)
                {
                    // Glyph of Thorns
                    if (AuraEffect* aurEff = GetAuraEffect(57862, 0))
                        duration += aurEff->GetAmount() * MINUTE * IN_MILLISECONDS;
                }
                break;
            case SPELLFAMILY_PALADIN:
                if ((spellProto->SpellFamilyFlags[0] & 0x00000002) && spellProto->SpellIconID == 298)
                {
                    // Glyph of Blessing of Might
                    if (AuraEffect* aurEff = GetAuraEffect(57958, 0))
                        duration += aurEff->GetAmount() * MINUTE * IN_MILLISECONDS;
                }
                else if ((spellProto->SpellFamilyFlags[0] & 0x00010000) && spellProto->SpellIconID == 306)
                {
                    // Glyph of Blessing of Wisdom
                    if (AuraEffect* aurEff = GetAuraEffect(57979, 0))
                        duration += aurEff->GetAmount() * MINUTE * IN_MILLISECONDS;
                }
                break;
        }
    }
    return std::max(duration, 0);
}

void Unit::ModSpellCastTime(SpellInfo const* spellInfo, int32& castTime, Spell* spell)
{
    if (!spellInfo || castTime < 0)
        return;

    if (spellInfo->IsChanneled() && spellInfo->HasAura(SPELL_AURA_MOUNTED))
        return;

    // called from caster
    if (Player* modOwner = GetSpellModOwner())
        /// @todo:(MadAgos) Eventually check and delete the bool argument
        modOwner->ApplySpellMod(spellInfo->Id, SPELLMOD_CASTING_TIME, castTime, spell, bool(modOwner != this && !IsPet()));

    switch (spellInfo->DmgClass)
    {
        case SPELL_DAMAGE_CLASS_NONE:
            if (spellInfo->AttributesEx5 & SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC) // required double check
                castTime = int32(float(castTime) * GetFloatValue(UNIT_MOD_CAST_SPEED));
            else if (spellInfo->SpellVisual[0] == 3881 && HasAura(67556)) // cooking with Chef Hat.
                castTime = 500;
            break;
        case SPELL_DAMAGE_CLASS_MELEE:
            break; // no known cases
        case SPELL_DAMAGE_CLASS_MAGIC:
            castTime = CanInstantCast() ? 0 : int32(float(castTime) * GetFloatValue(UNIT_MOD_CAST_SPEED));
            break;
        case SPELL_DAMAGE_CLASS_RANGED:
            castTime = int32(float(castTime) * m_modAttackSpeedPct[RANGED_ATTACK]);
            break;
        default:
            break;
    }
}

DiminishingLevels Unit::GetDiminishing(DiminishingGroup group)
{
    for (Diminishing::iterator i = m_Diminishing.begin(); i != m_Diminishing.end(); ++i)
    {
        if (i->DRGroup != group)
            continue;

        if (!i->hitCount)
            return DIMINISHING_LEVEL_1;

        if (!i->hitTime)
            return DIMINISHING_LEVEL_1;

        // If last spell was casted more than 15 seconds ago - reset the count.
        if (i->stack == 0 && getMSTimeDiff(i->hitTime, GameTime::GetGameTimeMS().count()) > 15000)
        {
            i->hitCount = DIMINISHING_LEVEL_1;
            return DIMINISHING_LEVEL_1;
        }
        // or else increase the count.
        else
            return DiminishingLevels(i->hitCount);
    }
    return DIMINISHING_LEVEL_1;
}

void Unit::IncrDiminishing(DiminishingGroup group)
{
    // Checking for existing in the table
    for (Diminishing::iterator i = m_Diminishing.begin(); i != m_Diminishing.end(); ++i)
    {
        if (i->DRGroup != group)
            continue;
        if (int32(i->hitCount) < GetDiminishingReturnsMaxLevel(group))
            i->hitCount += 1;
        return;
    }
    m_Diminishing.push_back(DiminishingReturn(group, GameTime::GetGameTimeMS().count(), DIMINISHING_LEVEL_2));
}

float Unit::ApplyDiminishingToDuration(DiminishingGroup group, int32& duration, Unit* caster, DiminishingLevels Level, int32 limitduration)
{
    // xinef: dont apply diminish to self casts
    if (duration == -1 || group == DIMINISHING_NONE)
        return 1.0f;

    // test pet/charm masters instead pets/charmeds
    Unit const* targetOwner = GetOwner();
    Unit const* casterOwner = caster->GetOwner();

    // Duration of crowd control abilities on pvp target is limited by 10 sec. (2.2.0)
    if (limitduration > 0 && duration > limitduration)
    {
        Unit const* target = targetOwner ? targetOwner : this;
        Unit const* source = casterOwner ? casterOwner : caster;

        if ((target->GetTypeId() == TYPEID_PLAYER
                || target->ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_ALL_DIMINISH)
                && source->GetTypeId() == TYPEID_PLAYER)
            duration = limitduration;
    }

    float mod = 1.0f;

    if (group == DIMINISHING_TAUNT)
    {
        if (GetTypeId() == TYPEID_UNIT && (ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_OBEYS_TAUNT_DIMINISHING_RETURNS))
        {
            DiminishingLevels diminish = Level;
            switch (diminish)
            {
                case DIMINISHING_LEVEL_1:
                    break;
                case DIMINISHING_LEVEL_2:
                    mod = 0.65f;
                    break;
                case DIMINISHING_LEVEL_3:
                    mod = 0.4225f;
                    break;
                case DIMINISHING_LEVEL_4:
                    mod = 0.274625f;
                    break;
                case DIMINISHING_LEVEL_TAUNT_IMMUNE:
                    mod = 0.0f;
                    break;
                default:
                    break;
            }
        }
    }
    // Some diminishings applies to mobs too (for example, Stun)
    else if ((GetDiminishingReturnsGroupType(group) == DRTYPE_PLAYER
              && ((targetOwner ? (targetOwner->GetTypeId() == TYPEID_PLAYER) : (GetTypeId() == TYPEID_PLAYER))
                  || (GetTypeId() == TYPEID_UNIT && ToCreature()->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_ALL_DIMINISH)))
             || GetDiminishingReturnsGroupType(group) == DRTYPE_ALL)
    {
        DiminishingLevels diminish = Level;
        switch (diminish)
        {
            case DIMINISHING_LEVEL_1:
                break;
            case DIMINISHING_LEVEL_2:
                mod = 0.5f;
                break;
            case DIMINISHING_LEVEL_3:
                mod = 0.25f;
                break;
            case DIMINISHING_LEVEL_IMMUNE:
                mod = 0.0f;
                break;
            default:
                break;
        }
    }

    duration = int32(duration * mod);
    return mod;
}

void Unit::ApplyDiminishingAura(DiminishingGroup group, bool apply)
{
    // Checking for existing in the table
    for (Diminishing::iterator i = m_Diminishing.begin(); i != m_Diminishing.end(); ++i)
    {
        if (i->DRGroup != group)
            continue;

        if (apply)
            i->stack += 1;
        else if (i->stack)
        {
            i->stack -= 1;
            // Remember time after last aura from group removed
            if (i->stack == 0)
                i->hitTime = GameTime::GetGameTimeMS().count();
        }
        break;
    }
}

float Unit::GetSpellMaxRangeForTarget(Unit const* target, SpellInfo const* spellInfo) const
{
    if (!spellInfo->RangeEntry)
    {
        return 0;
    }

    if (spellInfo->RangeEntry->RangeMax[1] == spellInfo->RangeEntry->RangeMax[0])
    {
        return spellInfo->GetMaxRange();
    }

    if (!target)
    {
        return spellInfo->GetMaxRange(true);
    }

    return spellInfo->GetMaxRange(!IsHostileTo(target));
}

float Unit::GetSpellMinRangeForTarget(Unit const* target, SpellInfo const* spellInfo) const
{
    if (!spellInfo->RangeEntry)
    {
        return 0;
    }

    if (spellInfo->RangeEntry->RangeMin[1] == spellInfo->RangeEntry->RangeMin[0])
    {
        return spellInfo->GetMinRange();
    }

    return spellInfo->GetMinRange(!IsHostileTo(target));
}

uint32 Unit::GetCreatureType() const
{
    if (GetTypeId() == TYPEID_PLAYER)
    {
        ShapeshiftForm form = GetShapeshiftForm();
        SpellShapeshiftFormEntry const* ssEntry = sSpellShapeshiftFormStore.LookupEntry(form);
        if (ssEntry && ssEntry->creatureType > 0)
            return ssEntry->creatureType;
        else
            return CREATURE_TYPE_HUMANOID;
    }
    else
        return ToCreature()->GetCreatureTemplate()->type;
}

/*#######################################
########                         ########
########       STAT SYSTEM       ########
########                         ########
#######################################*/

bool Unit::HandleStatModifier(UnitMods unitMod, UnitModifierType modifierType, float amount, bool apply)
{
    if (unitMod >= UNIT_MOD_END || modifierType >= MODIFIER_TYPE_END)
    {
        LOG_ERROR("entities.unit", "ERROR in HandleStatModifier(): non-existing UnitMods or wrong UnitModifierType!");
        return false;
    }

    switch (modifierType)
    {
        case BASE_VALUE:
        case TOTAL_VALUE:
            m_auraModifiersGroup[unitMod][modifierType] += apply ? amount : -amount;
            break;
        case BASE_PCT:
        case TOTAL_PCT:
            ApplyPercentModFloatVar(m_auraModifiersGroup[unitMod][modifierType], amount, apply);
            break;
        default:
            break;
    }

    if (!CanModifyStats())
        return false;

    switch (unitMod)
    {
        case UNIT_MOD_STAT_STRENGTH:
        case UNIT_MOD_STAT_AGILITY:
        case UNIT_MOD_STAT_STAMINA:
        case UNIT_MOD_STAT_INTELLECT:
        case UNIT_MOD_STAT_SPIRIT:
            UpdateStats(GetStatByAuraGroup(unitMod));
            break;

        case UNIT_MOD_ARMOR:
            UpdateArmor();
            break;
        case UNIT_MOD_HEALTH:
            UpdateMaxHealth();
            break;

        case UNIT_MOD_MANA:
        case UNIT_MOD_RAGE:
        case UNIT_MOD_FOCUS:
        case UNIT_MOD_ENERGY:
        case UNIT_MOD_HAPPINESS:
        case UNIT_MOD_RUNE:
        case UNIT_MOD_RUNIC_POWER:
            UpdateMaxPower(GetPowerTypeByAuraGroup(unitMod));
            break;

        case UNIT_MOD_RESISTANCE_HOLY:
        case UNIT_MOD_RESISTANCE_FIRE:
        case UNIT_MOD_RESISTANCE_NATURE:
        case UNIT_MOD_RESISTANCE_FROST:
        case UNIT_MOD_RESISTANCE_SHADOW:
        case UNIT_MOD_RESISTANCE_ARCANE:
            UpdateResistances(GetSpellSchoolByAuraGroup(unitMod));
            break;

        case UNIT_MOD_ATTACK_POWER:
            UpdateAttackPowerAndDamage();
            break;
        case UNIT_MOD_ATTACK_POWER_RANGED:
            UpdateAttackPowerAndDamage(true);
            break;

        case UNIT_MOD_DAMAGE_MAINHAND:
            UpdateDamagePhysical(BASE_ATTACK);
            break;
        case UNIT_MOD_DAMAGE_OFFHAND:
            UpdateDamagePhysical(OFF_ATTACK);
            break;
        case UNIT_MOD_DAMAGE_RANGED:
            UpdateDamagePhysical(RANGED_ATTACK);
            break;

        default:
            break;
    }

    return true;
}

float Unit::GetModifierValue(UnitMods unitMod, UnitModifierType modifierType) const
{
    if (unitMod >= UNIT_MOD_END || modifierType >= MODIFIER_TYPE_END)
    {
        LOG_ERROR("entities.unit", "attempt to access non-existing modifier value from UnitMods!");
        return 0.0f;
    }

    if (modifierType == TOTAL_PCT && m_auraModifiersGroup[unitMod][modifierType] <= 0.0f)
        return 0.0f;

    return m_auraModifiersGroup[unitMod][modifierType];
}

float Unit::GetTotalStatValue(Stats stat, float additionalValue) const
{
    UnitMods unitMod = UnitMods(static_cast<uint16>(UNIT_MOD_STAT_START) + stat);

    if (m_auraModifiersGroup[unitMod][TOTAL_PCT] <= 0.0f)
        return 0.0f;

    // value = ((base_value * base_pct) + total_value) * total_pct
    float value  = m_auraModifiersGroup[unitMod][BASE_VALUE] + GetCreateStat(stat);
    value *= m_auraModifiersGroup[unitMod][BASE_PCT];
    value += m_auraModifiersGroup[unitMod][TOTAL_VALUE] + additionalValue;
    value *= m_auraModifiersGroup[unitMod][TOTAL_PCT];

    return value;
}

float Unit::GetTotalAuraModValue(UnitMods unitMod) const
{
    if (unitMod >= UNIT_MOD_END)
    {
        LOG_ERROR("entities.unit", "attempt to access non-existing UnitMods in GetTotalAuraModValue()!");
        return 0.0f;
    }

    if (m_auraModifiersGroup[unitMod][TOTAL_PCT] <= 0.0f)
        return 0.0f;

    float value = m_auraModifiersGroup[unitMod][BASE_VALUE];
    value *= m_auraModifiersGroup[unitMod][BASE_PCT];
    value += m_auraModifiersGroup[unitMod][TOTAL_VALUE];
    value *= m_auraModifiersGroup[unitMod][TOTAL_PCT];

    return value;
}

void Unit::ApplyStatPercentBuffMod(Stats stat, float val, bool apply)
{
    if (val == -100.0f)     // prevent set var to zero
        val = -99.99f;
    float var = GetStat(stat) * val / 100.0f;
    ApplyModSignedFloatValue((var > 0 ? static_cast<uint16>(UNIT_FIELD_POSSTAT0) + stat : static_cast<uint16>(UNIT_FIELD_NEGSTAT0) + stat), var, apply);
}

SpellSchools Unit::GetSpellSchoolByAuraGroup(UnitMods unitMod) const
{
    SpellSchools school = SPELL_SCHOOL_NORMAL;

    switch (unitMod)
    {
        case UNIT_MOD_RESISTANCE_HOLY:
            school = SPELL_SCHOOL_HOLY;
            break;
        case UNIT_MOD_RESISTANCE_FIRE:
            school = SPELL_SCHOOL_FIRE;
            break;
        case UNIT_MOD_RESISTANCE_NATURE:
            school = SPELL_SCHOOL_NATURE;
            break;
        case UNIT_MOD_RESISTANCE_FROST:
            school = SPELL_SCHOOL_FROST;
            break;
        case UNIT_MOD_RESISTANCE_SHADOW:
            school = SPELL_SCHOOL_SHADOW;
            break;
        case UNIT_MOD_RESISTANCE_ARCANE:
            school = SPELL_SCHOOL_ARCANE;
            break;

        default:
            break;
    }

    return school;
}

Stats Unit::GetStatByAuraGroup(UnitMods unitMod) const
{
    Stats stat = STAT_STRENGTH;

    switch (unitMod)
    {
        case UNIT_MOD_STAT_STRENGTH:
            stat = STAT_STRENGTH;
            break;
        case UNIT_MOD_STAT_AGILITY:
            stat = STAT_AGILITY;
            break;
        case UNIT_MOD_STAT_STAMINA:
            stat = STAT_STAMINA;
            break;
        case UNIT_MOD_STAT_INTELLECT:
            stat = STAT_INTELLECT;
            break;
        case UNIT_MOD_STAT_SPIRIT:
            stat = STAT_SPIRIT;
            break;

        default:
            break;
    }

    return stat;
}

Powers Unit::GetPowerTypeByAuraGroup(UnitMods unitMod) const
{
    switch (unitMod)
    {
        case UNIT_MOD_RAGE:
            return POWER_RAGE;
        case UNIT_MOD_FOCUS:
            return POWER_FOCUS;
        case UNIT_MOD_ENERGY:
            return POWER_ENERGY;
        case UNIT_MOD_HAPPINESS:
            return POWER_HAPPINESS;
        case UNIT_MOD_RUNE:
            return POWER_RUNE;
        case UNIT_MOD_RUNIC_POWER:
            return POWER_RUNIC_POWER;
        default:
        case UNIT_MOD_MANA:
            return POWER_MANA;
    }
}

float Unit::GetTotalAttackPowerValue(WeaponAttackType attType, Unit* victim) const
{
    if (attType == RANGED_ATTACK)
    {
        int32 ap = GetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER) + GetInt32Value(UNIT_FIELD_RANGED_ATTACK_POWER_MODS);
        if( victim )
            ap += victim->GetTotalAuraModifier(SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS);

        if (ap < 0)
            return 0.0f;
        return ap * (1.0f + GetFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER));
    }
    else
    {
        int32 ap = GetInt32Value(UNIT_FIELD_ATTACK_POWER) + GetInt32Value(UNIT_FIELD_ATTACK_POWER_MODS);
        if( victim )
            ap += victim->GetTotalAuraModifier(SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS);

        if (ap < 0)
            return 0.0f;
        return ap * (1.0f + GetFloatValue(UNIT_FIELD_ATTACK_POWER_MULTIPLIER));
    }
}

float Unit::GetWeaponDamageRange(WeaponAttackType attType, WeaponDamageRange type, uint8 damageIndex /*= 0*/) const
{
    if (attType == OFF_ATTACK && !haveOffhandWeapon())
        return 0.0f;

    return m_weaponDamage[attType][type][damageIndex];
}

void Unit::SetLevel(uint8 lvl, bool showLevelChange)
{
    SetUInt32Value(UNIT_FIELD_LEVEL, lvl);

    // Xinef: unmark field bit update
    if (!showLevelChange)
        _changesMask.UnsetBit(UNIT_FIELD_LEVEL);

    // group update
    if (GetTypeId() == TYPEID_PLAYER && ToPlayer()->GetGroup())
        ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_LEVEL);

    if (GetTypeId() == TYPEID_PLAYER)
    {
        sCharacterCache->UpdateCharacterLevel(GetGUID(), lvl);
    }
}

void Unit::SetHealth(uint32 val)
{
    if (getDeathState() == DeathState::JustDied)
        val = 0;
    else if (GetTypeId() == TYPEID_PLAYER && getDeathState() == DeathState::Dead)
        val = 1;
    else
    {
        uint32 maxHealth = GetMaxHealth();
        if (maxHealth < val)
            val = maxHealth;
    }

    float prevHealthPct = GetHealthPct();

    SetUInt32Value(UNIT_FIELD_HEALTH, val);

    // mobs that are now or were below 30% need to update their speed
    if (GetTypeId() == TYPEID_UNIT && !(IsPet() && ToPet()->isControlled() && IsControlledByPlayer()) && (prevHealthPct < 30.0 || HealthBelowPct(30)))
    {
        UpdateSpeed(MOVE_RUN, false);
    }

    // group update
    if (GetTypeId() == TYPEID_PLAYER)
    {
        Player* player = ToPlayer();
        if (player->NeedSendSpectatorData())
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "CHP", val);

        if (player->GetGroup())
            player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_CUR_HP);
    }
    else if (Pet* pet = ToCreature()->ToPet())
    {
        if (pet->isControlled())
        {
            if (Unit* owner = GetOwner())
                if (Player* player = owner->ToPlayer())
                {
                    if (player->NeedSendSpectatorData() && pet->GetCreatureTemplate()->family)
                        ArenaSpectator::SendCommand_UInt32Value(player->FindMap(), player->GetGUID(), "PHP", (uint32)pet->GetHealthPct());

                    if (player->GetGroup())
                        player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_CUR_HP);
                }
        }
    }
}

void Unit::SetMaxHealth(uint32 val)
{
    if (!val)
        val = 1;

    uint32 health = GetHealth();
    SetUInt32Value(UNIT_FIELD_MAXHEALTH, val);

    // group update
    if (GetTypeId() == TYPEID_PLAYER)
    {
        Player* player = ToPlayer();
        if (player->NeedSendSpectatorData())
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "MHP", val);

        if (player->GetGroup())
            player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_MAX_HP);
    }
    else if (Pet* pet = ToCreature()->ToPet())
    {
        if (pet->isControlled())
        {
            if (Unit* owner = GetOwner())
                if (Player* player = owner->ToPlayer())
                {
                    if (player->NeedSendSpectatorData() && pet->GetCreatureTemplate()->family)
                        ArenaSpectator::SendCommand_UInt32Value(player->FindMap(), player->GetGUID(), "PHP", (uint32)pet->GetHealthPct());

                    if (player->GetGroup())
                        player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_MAX_HP);
                }
        }
    }

    if (val < health)
        SetHealth(val);
}

void Unit::SetPower(Powers power, uint32 val, bool withPowerUpdate /*= true*/, bool fromRegenerate /* = false */)
{
    if (!fromRegenerate && GetPower(power) == val)
    {
        return;
    }

    uint32 maxPower = GetMaxPower(power);
    if (maxPower < val)
    {
        val = maxPower;
    }

    if (fromRegenerate)
    {
        UpdateUInt32Value(static_cast<uint16>(UNIT_FIELD_POWER1) + power, val);
        AddToObjectUpdateIfNeeded();
    }
    else
    {
        SetStatInt32Value(static_cast<uint16>(UNIT_FIELD_POWER1) + power, val);
    }

    if (withPowerUpdate)
    {
        WorldPacket data(SMSG_POWER_UPDATE);
        data << GetPackGUID();
        data << uint8(power);
        data << uint32(val);
        SendMessageToSet(&data, GetTypeId() == TYPEID_PLAYER);
    }

    // group update
    if (GetTypeId() == TYPEID_PLAYER)
    {
        Player* player = ToPlayer();
        if (getPowerType() == power && player->NeedSendSpectatorData())
        {
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "CPW", power == POWER_RAGE || power == POWER_RUNIC_POWER ? val / 10 : val);
        }

        if (player->GetGroup())
        {
            player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_CUR_POWER);
        }
    }
    else if (Pet* pet = ToCreature()->ToPet())
    {
        if (pet->isControlled())
        {
            Unit* owner = GetOwner();
            if (owner && (owner->GetTypeId() == TYPEID_PLAYER) && owner->ToPlayer()->GetGroup())
            {
                owner->ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_CUR_POWER);
            }
        }

        // Update the pet's character sheet with happiness damage bonus
        if (pet->getPetType() == HUNTER_PET && power == POWER_HAPPINESS)
        {
            pet->UpdateDamagePhysical(BASE_ATTACK);
        }
    }
}

void Unit::SetMaxPower(Powers power, uint32 val)
{
    uint32 cur_power = GetPower(power);
    SetStatInt32Value(static_cast<uint16>(UNIT_FIELD_MAXPOWER1) + power, val);

    // group update
    if (GetTypeId() == TYPEID_PLAYER)
    {
        Player* player = ToPlayer();
        if (getPowerType() == power && player->NeedSendSpectatorData())
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "MPW", power == POWER_RAGE || power == POWER_RUNIC_POWER ? val / 10 : val);

        if (player->GetGroup())
            player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_MAX_POWER);
    }
    else if (Pet* pet = ToCreature()->ToPet())
    {
        if (pet->isControlled())
        {
            Unit* owner = GetOwner();
            if (owner && (owner->GetTypeId() == TYPEID_PLAYER) && owner->ToPlayer()->GetGroup())
                owner->ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_MAX_POWER);
        }
    }

    if (val < cur_power)
        SetPower(power, val);
}

uint32 Unit::GetCreatePowers(Powers power) const
{
    // Only hunter pets have POWER_FOCUS and POWER_HAPPINESS
    switch (power)
    {
        case POWER_MANA:
            return GetCreateMana();
        case POWER_RAGE:
            return 1000;
        case POWER_FOCUS:
            return (GetTypeId() == TYPEID_PLAYER || !((Creature const*)this)->IsPet() || ((Pet const*)this)->getPetType() != HUNTER_PET ? 0 : 100);
        case POWER_ENERGY:
            return 100;
        case POWER_HAPPINESS:
            return (GetTypeId() == TYPEID_PLAYER || !((Creature const*)this)->IsPet() || ((Pet const*)this)->getPetType() != HUNTER_PET ? 0 : 1050000);
        case POWER_RUNIC_POWER:
            return 1000;
        case POWER_RUNE:
            return 0;
        case POWER_HEALTH:
            return 0;
        default:
            break;
    }

    return 0;
}

void Unit::AddToWorld()
{
    if (!IsInWorld())
    {
        WorldObject::AddToWorld();
    }
}

void Unit::RemoveFromWorld()
{
    // cleanup
    ASSERT(GetGUID());

    if (IsInWorld())
    {
        m_duringRemoveFromWorld = true;
        if (IsVehicle())
            RemoveVehicleKit();

        RemoveCharmAuras();
        RemoveBindSightAuras();
        RemoveNotOwnSingleTargetAuras();

        RemoveAllGameObjects();
        RemoveAllDynObjects();

        ExitVehicle();  // Remove applied auras with SPELL_AURA_CONTROL_VEHICLE
        UnsummonAllTotems();
        RemoveAllControlled();

        RemoveAreaAurasDueToLeaveWorld();

        if (GetCharmerGUID())
        {
            LOG_FATAL("entities.unit", "Unit {} has charmer guid when removed from world", GetEntry());
            ABORT();
        }

        if (Unit* owner = GetOwner())
        {
            if (owner->m_Controlled.find(this) != owner->m_Controlled.end())
            {
                if (HasUnitTypeMask(UNIT_MASK_MINION | UNIT_MASK_GUARDIAN))
                    owner->SetMinion((Minion*)this, false);
                LOG_INFO("entities.unit", "Unit {} is in controlled list of {} when removed from world", GetEntry(), owner->GetEntry());
                //ABORT();
            }
        }

        WorldObject::RemoveFromWorld();
        m_duringRemoveFromWorld = false;
    }
}

void Unit::CleanupBeforeRemoveFromMap(bool finalCleanup)
{
    if (IsDuringRemoveFromWorld())
        return;

    // This needs to be before RemoveFromWorld to make GetCaster() return a valid pointer on aura removal
    InterruptNonMeleeSpells(true);

    if (IsInWorld()) // not in world and not being removed atm
        RemoveFromWorld();

    ASSERT(GetGUID());

    // A unit may be in removelist and not in world, but it is still in grid
    // and may have some references during delete
    RemoveAllAuras();
    RemoveAllGameObjects();

    if (finalCleanup)
        m_cleanupDone = true;

    m_Events.KillAllEvents(false);                      // non-delatable (currently casted spells) will not deleted now but it will deleted at call in Map::RemoveAllObjectsInRemoveList
    CombatStop();
    ClearComboPoints();
    ClearComboPointHolders();
    GetThreatMgr().ClearAllThreat();
    getHostileRefMgr().deleteReferences();
    GetMotionMaster()->Clear(false);                    // remove different non-standard movement generators.
}

void Unit::CleanupsBeforeDelete(bool finalCleanup)
{
    if (GetTransport())
    {
        GetTransport()->RemovePassenger(this);
        SetTransport(nullptr);
        m_movementInfo.transport.Reset();
        m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ONTRANSPORT);
    }

    CleanupBeforeRemoveFromMap(finalCleanup);
}

void Unit::UpdateCharmAI()
{
    if (GetTypeId() == TYPEID_PLAYER)
        return;

    if (i_disabledAI) // disabled AI must be primary AI
    {
        if (!IsCharmed())
        {
            delete i_AI;
            i_AI = i_disabledAI;
            i_disabledAI = nullptr;
        }
    }
    else
    {
        if (IsCharmed())
        {
            i_disabledAI = i_AI;
            if (isPossessed() || IsVehicle())
                i_AI = new PossessedAI(ToCreature());
            else
                i_AI = new PetAI(ToCreature());
        }
    }
}

CharmInfo* Unit::InitCharmInfo()
{
    if (!m_charmInfo)
        m_charmInfo = new CharmInfo(this);

    return m_charmInfo;
}

void Unit::DeleteCharmInfo()
{
    if (!m_charmInfo)
        return;

    m_charmInfo->RestoreState();
    delete m_charmInfo;
    m_charmInfo = nullptr;
}

CharmInfo::CharmInfo(Unit* unit)
    : _unit(unit), _CommandState(COMMAND_FOLLOW), _petnumber(0), _oldReactState(REACT_PASSIVE),
      _isCommandAttack(false), _isCommandFollow(false), _isAtStay(false), _isFollowing(false), _isReturning(false),
      _forcedSpellId(0), _stayX(0.0f), _stayY(0.0f), _stayZ(0.0f)
{
    for (uint8 i = 0; i < MAX_SPELL_CHARM; ++i)
        _charmspells[i].SetActionAndType(0, ACT_DISABLED);

    if (_unit->GetTypeId() == TYPEID_UNIT)
    {
        _oldReactState = _unit->ToCreature()->GetReactState();
        _unit->ToCreature()->SetReactState(REACT_PASSIVE);
    }
}

CharmInfo::~CharmInfo()
{
}

void CharmInfo::RestoreState()
{
    if (Creature* creature = _unit->ToCreature())
        creature->SetReactState(_oldReactState);
}

void CharmInfo::InitPetActionBar()
{
    // the first 3 SpellOrActions are attack, follow and stay
    for (uint32 i = 0; i < ACTION_BAR_INDEX_PET_SPELL_START - ACTION_BAR_INDEX_START; ++i)
        SetActionBar(ACTION_BAR_INDEX_START + i, COMMAND_ATTACK - i, ACT_COMMAND);

    // middle 4 SpellOrActions are spells/special attacks/abilities
    for (uint32 i = 0; i < ACTION_BAR_INDEX_PET_SPELL_END - ACTION_BAR_INDEX_PET_SPELL_START; ++i)
        SetActionBar(ACTION_BAR_INDEX_PET_SPELL_START + i, 0, ACT_PASSIVE);

    // last 3 SpellOrActions are reactions
    for (uint32 i = 0; i < ACTION_BAR_INDEX_END - ACTION_BAR_INDEX_PET_SPELL_END; ++i)
        SetActionBar(ACTION_BAR_INDEX_PET_SPELL_END + i, COMMAND_ATTACK - i, ACT_REACTION);
}

void CharmInfo::InitEmptyActionBar(bool withAttack)
{
    if (withAttack)
        SetActionBar(ACTION_BAR_INDEX_START, COMMAND_ATTACK, ACT_COMMAND);
    else
        SetActionBar(ACTION_BAR_INDEX_START, 0, ACT_PASSIVE);
    for (uint32 x = ACTION_BAR_INDEX_START + 1; x < ACTION_BAR_INDEX_END; ++x)
        SetActionBar(x, 0, ACT_PASSIVE);
}

void CharmInfo::InitPossessCreateSpells()
{
    if (_unit->GetTypeId() == TYPEID_UNIT)
    {
        // Adding switch until better way is found. Malcrom
        // Adding entrys to this switch will prevent COMMAND_ATTACK being added to pet bar.
        switch (_unit->GetEntry())
        {
            case 23575: // Mindless Abomination
            case 24783: // Trained Rock Falcon
            case 27664: // Crashin' Thrashin' Racer
            case 40281: // Crashin' Thrashin' Racer
            case 23109: // Vengeful Spirit
                break;
            default:
                InitEmptyActionBar();
                break;
        }

        for (uint32 i = 0; i < MAX_CREATURE_SPELLS; ++i)
        {
            uint32 spellId = _unit->ToCreature()->m_spells[i];
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
            if (spellInfo)
            {
                if (spellInfo->IsPassive())
                    _unit->CastSpell(_unit, spellInfo, true);
                else
                    AddSpellToActionBar(spellInfo, ACT_PASSIVE);
            }
        }
    }
    else
        InitEmptyActionBar();
}

void CharmInfo::InitCharmCreateSpells()
{
    InitPetActionBar();

    if (_unit->GetTypeId() == TYPEID_PLAYER)                // charmed players don't have spells
    {
        //InitEmptyActionBar();
        return;
    }

    //InitPetActionBar();

    for (uint32 x = 0; x < MAX_SPELL_CHARM; ++x)
    {
        uint32 spellId = _unit->ToCreature()->m_spells[x];
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);

        if (!spellInfo)
        {
            _charmspells[x].SetActionAndType(spellId, ACT_DISABLED);
            continue;
        }

        if (spellInfo->IsPassive())
        {
            _unit->CastSpell(_unit, spellInfo, true);
            _charmspells[x].SetActionAndType(spellId, ACT_PASSIVE);
        }
        else
        {
            _charmspells[x].SetActionAndType(spellId, ACT_DISABLED);

            ActiveStates newstate = ACT_PASSIVE;

            if (!spellInfo->IsAutocastable())
                newstate = ACT_PASSIVE;
            else
            {
                if (spellInfo->NeedsExplicitUnitTarget())
                {
                    newstate = ACT_ENABLED;
                    ToggleCreatureAutocast(spellInfo, true);
                }
                else
                    newstate = ACT_DISABLED;
            }

            AddSpellToActionBar(spellInfo, newstate);
        }
    }
}

bool CharmInfo::AddSpellToActionBar(SpellInfo const* spellInfo, ActiveStates newstate)
{
    uint32 spell_id = spellInfo->Id;
    uint32 first_id = spellInfo->GetFirstRankSpell()->Id;

    // new spell rank can be already listed
    for (uint8 i = 0; i < MAX_UNIT_ACTION_BAR_INDEX; ++i)
    {
        if (uint32 action = PetActionBar[i].GetAction())
        {
            if (PetActionBar[i].IsActionBarForSpell() && sSpellMgr->GetFirstSpellInChain(action) == first_id)
            {
                PetActionBar[i].SetAction(spell_id);
                return true;
            }
        }
    }

    // or use empty slot in other case
    for (uint8 i = 0; i < MAX_UNIT_ACTION_BAR_INDEX; ++i)
    {
        if (!PetActionBar[i].GetAction() && PetActionBar[i].IsActionBarForSpell())
        {
            SetActionBar(i, spell_id, newstate == ACT_DECIDE ? spellInfo->IsAutocastable() ? ACT_DISABLED : ACT_PASSIVE : newstate);

            if (_unit->GetCharmer() && _unit->GetCharmer()->IsPlayer())
            {
                if (Creature* creature = _unit->ToCreature())
                {
                    // Processing this packet needs to be delayed
                    _unit->m_Events.AddEventAtOffset([creature, spell_id]()
                    {
                        if (uint32 cooldown = creature->GetSpellCooldown(spell_id))
                        {
                            WorldPacket data;
                            creature->BuildCooldownPacket(data, SPELL_COOLDOWN_FLAG_NONE, spell_id, cooldown);
                            if (creature->GetCharmer() && creature->GetCharmer()->IsPlayer())
                            {
                                creature->GetCharmer()->ToPlayer()->SendDirectMessage(&data);
                            }
                        }
                    }, 500ms);
                }
            }

            return true;
        }
    }
    return false;
}

bool CharmInfo::RemoveSpellFromActionBar(uint32 spell_id)
{
    uint32 first_id = sSpellMgr->GetFirstSpellInChain(spell_id);

    for (uint8 i = 0; i < MAX_UNIT_ACTION_BAR_INDEX; ++i)
    {
        if (uint32 action = PetActionBar[i].GetAction())
        {
            if (PetActionBar[i].IsActionBarForSpell() && sSpellMgr->GetFirstSpellInChain(action) == first_id)
            {
                SetActionBar(i, 0, ACT_PASSIVE);
                return true;
            }
        }
    }

    return false;
}

void CharmInfo::ToggleCreatureAutocast(SpellInfo const* spellInfo, bool apply)
{
    if (spellInfo->IsPassive())
        return;

    for (uint32 x = 0; x < MAX_SPELL_CHARM; ++x)
        if (spellInfo->Id == _charmspells[x].GetAction())
            _charmspells[x].SetType(apply ? ACT_ENABLED : ACT_DISABLED);
}

void CharmInfo::SetPetNumber(uint32 petnumber, bool statwindow)
{
    _petnumber = petnumber;
    if (statwindow)
        _unit->SetUInt32Value(UNIT_FIELD_PETNUMBER, _petnumber);
    else
        _unit->SetUInt32Value(UNIT_FIELD_PETNUMBER, 0);
}

void CharmInfo::LoadPetActionBar(const std::string& data)
{
    std::vector<std::string_view> tokens = Acore::Tokenize(data, ' ', false);

    if (tokens.size() != (ACTION_BAR_INDEX_END - ACTION_BAR_INDEX_START) * 2)
        return;                                             // non critical, will reset to default

    auto iter = tokens.begin();
    for (uint8 index = ACTION_BAR_INDEX_START; index < ACTION_BAR_INDEX_END; ++index)
    {
        Optional<uint8> type = Acore::StringTo<uint8>(*(iter++));
        Optional<uint32> action = Acore::StringTo<uint32>(*(iter++));

        if (!type || !action)
        {
            continue;
        }

        PetActionBar[index].SetActionAndType(*action, static_cast<ActiveStates>(*type));

        // check correctness
        if (PetActionBar[index].IsActionBarForSpell())
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(PetActionBar[index].GetAction());
            if (!spellInfo)
            {
                SetActionBar(index, 0, ACT_PASSIVE);
            }
            else if (!spellInfo->IsAutocastable())
            {
                SetActionBar(index, PetActionBar[index].GetAction(), ACT_PASSIVE);
            }
        }
    }
}

void CharmInfo::BuildActionBar(WorldPacket* data)
{
    for (uint32 i = 0; i < MAX_UNIT_ACTION_BAR_INDEX; ++i)
        *data << uint32(PetActionBar[i].packedData);
}

void CharmInfo::SetSpellAutocast(SpellInfo const* spellInfo, bool state)
{
    for (uint8 i = 0; i < MAX_UNIT_ACTION_BAR_INDEX; ++i)
    {
        if (spellInfo->Id == PetActionBar[i].GetAction() && PetActionBar[i].IsActionBarForSpell())
        {
            PetActionBar[i].SetType(state ? ACT_ENABLED : ACT_DISABLED);
            break;
        }
    }
}

bool Unit::isFrozen() const
{
    return HasAuraState(AURA_STATE_FROZEN);
}

struct ProcTriggeredData
{
    ProcTriggeredData(Aura* _aura) : aura(_aura)
    {
        effMask = 0;
        spellProcEvent = nullptr;
        triggerSpelId.fill(0);
    }

    SpellProcEventEntry const* spellProcEvent;
    Aura* aura;
    uint32 effMask;
    std::array<uint32, EFFECT_ALL> triggerSpelId;

    bool operator==(const uint32 spellId) const
    {
        return aura->GetId() == spellId;
    }
};

typedef std::list< ProcTriggeredData > ProcTriggeredList;

// List of auras that CAN be trigger but may not exist in spell_proc_event
// in most case need for drop charges
// in some types of aura need do additional check
// for example SPELL_AURA_MECHANIC_IMMUNITY - need check for mechanic
bool InitTriggerAuraData()
{
    for (uint16 i = 0; i < TOTAL_AURAS; ++i)
    {
        isTriggerAura[i] = false;
        isNonTriggerAura[i] = false;
        isAlwaysTriggeredAura[i] = false;
    }
    isTriggerAura[SPELL_AURA_DUMMY] = true;
    isTriggerAura[SPELL_AURA_MOD_CONFUSE] = true;
    isTriggerAura[SPELL_AURA_MOD_THREAT] = true;
    isTriggerAura[SPELL_AURA_MOD_STUN] = true; // Aura does not have charges but needs to be removed on trigger
    isTriggerAura[SPELL_AURA_MOD_DAMAGE_DONE] = true;
    isTriggerAura[SPELL_AURA_MOD_DAMAGE_TAKEN] = true;
    isTriggerAura[SPELL_AURA_MOD_RESISTANCE] = true;
    isTriggerAura[SPELL_AURA_MOD_STEALTH] = true;
    isTriggerAura[SPELL_AURA_MOD_FEAR] = true; // Aura does not have charges but needs to be removed on trigger
    isTriggerAura[SPELL_AURA_MOD_ROOT] = true;
    isTriggerAura[SPELL_AURA_TRANSFORM] = true;
    isTriggerAura[SPELL_AURA_REFLECT_SPELLS] = true;
    isTriggerAura[SPELL_AURA_DAMAGE_IMMUNITY] = true;
    isTriggerAura[SPELL_AURA_PROC_TRIGGER_SPELL] = true;
    isTriggerAura[SPELL_AURA_PROC_TRIGGER_DAMAGE] = true;
    isTriggerAura[SPELL_AURA_MOD_CASTING_SPEED_NOT_STACK] = true;
    isTriggerAura[SPELL_AURA_SCHOOL_ABSORB] = true; // Savage Defense untested
    isTriggerAura[SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT] = true;
    isTriggerAura[SPELL_AURA_MOD_POWER_COST_SCHOOL] = true;
    isTriggerAura[SPELL_AURA_REFLECT_SPELLS_SCHOOL] = true;
    isTriggerAura[SPELL_AURA_MECHANIC_IMMUNITY] = true;
    isTriggerAura[SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN] = true;
    isTriggerAura[SPELL_AURA_SPELL_MAGNET] = true;
    isTriggerAura[SPELL_AURA_MOD_ATTACK_POWER] = true;
    isTriggerAura[SPELL_AURA_ADD_CASTER_HIT_TRIGGER] = true;
    isTriggerAura[SPELL_AURA_OVERRIDE_CLASS_SCRIPTS] = true;
    isTriggerAura[SPELL_AURA_MOD_MECHANIC_RESISTANCE] = true;
    isTriggerAura[SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS] = true;
    isTriggerAura[SPELL_AURA_MOD_MELEE_HASTE] = true;
    isTriggerAura[SPELL_AURA_MOD_ATTACKER_MELEE_HIT_CHANCE] = true;
    isTriggerAura[SPELL_AURA_RAID_PROC_FROM_CHARGE] = true;
    isTriggerAura[SPELL_AURA_RAID_PROC_FROM_CHARGE_WITH_VALUE] = true;
    isTriggerAura[SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE] = true;
    isTriggerAura[SPELL_AURA_MOD_DAMAGE_FROM_CASTER] = true;
    isTriggerAura[SPELL_AURA_MOD_SPELL_CRIT_CHANCE] = true;
    isTriggerAura[SPELL_AURA_ABILITY_IGNORE_AURASTATE] = true;

    isNonTriggerAura[SPELL_AURA_MOD_POWER_REGEN] = true;
    isNonTriggerAura[SPELL_AURA_REDUCE_PUSHBACK] = true;

    isAlwaysTriggeredAura[SPELL_AURA_OVERRIDE_CLASS_SCRIPTS] = true;
    isAlwaysTriggeredAura[SPELL_AURA_MOD_FEAR] = true;
    isAlwaysTriggeredAura[SPELL_AURA_MOD_ROOT] = true;
    isAlwaysTriggeredAura[SPELL_AURA_MOD_STUN] = true;
    isAlwaysTriggeredAura[SPELL_AURA_TRANSFORM] = true;
    isAlwaysTriggeredAura[SPELL_AURA_SPELL_MAGNET] = true;
    isAlwaysTriggeredAura[SPELL_AURA_SCHOOL_ABSORB] = true;
    isAlwaysTriggeredAura[SPELL_AURA_MOD_STEALTH] = true;

    return true;
}

void createProcFlags(SpellInfo const* spellInfo, WeaponAttackType attackType, bool positive, uint32& procAttacker, uint32& procVictim)
{
    if (spellInfo)
    {
        switch (spellInfo->DmgClass)
        {
            case SPELL_DAMAGE_CLASS_MAGIC:
                if (positive)
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_POS;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_POS;
                }
                else
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_MAGIC_DMG_CLASS_NEG;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG;
                }
                break;
            case SPELL_DAMAGE_CLASS_NONE:
                if (positive)
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_POS;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_POS;
                }
                else
                {
                    procAttacker |= PROC_FLAG_DONE_SPELL_NONE_DMG_CLASS_NEG;
                    procVictim   |= PROC_FLAG_TAKEN_SPELL_NONE_DMG_CLASS_NEG;
                }
                break;
            case SPELL_DAMAGE_CLASS_MELEE:
                procAttacker = PROC_FLAG_DONE_SPELL_MELEE_DMG_CLASS;
                if (attackType == OFF_ATTACK)
                    procAttacker |= PROC_FLAG_DONE_OFFHAND_ATTACK;
                else
                    procAttacker |= PROC_FLAG_DONE_MAINHAND_ATTACK;
                procVictim = PROC_FLAG_TAKEN_SPELL_MELEE_DMG_CLASS;
                break;
            case SPELL_DAMAGE_CLASS_RANGED:
                // Auto attack
                if (spellInfo->HasAttribute(SPELL_ATTR2_AUTO_REPEAT))
                {
                    procAttacker = PROC_FLAG_DONE_RANGED_AUTO_ATTACK;
                    procVictim   = PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK;
                }
                else // Ranged spell attack
                {
                    procAttacker = PROC_FLAG_DONE_SPELL_RANGED_DMG_CLASS;
                    procVictim   = PROC_FLAG_TAKEN_SPELL_RANGED_DMG_CLASS;
                }
                break;
            default:
                if (spellInfo->EquippedItemClass == ITEM_CLASS_WEAPON &&
                        spellInfo->EquippedItemSubClassMask & (1 << ITEM_SUBCLASS_WEAPON_WAND)
                        && spellInfo->HasAttribute(SPELL_ATTR2_AUTO_REPEAT)) // Wands auto attack
                {
                    procAttacker = PROC_FLAG_DONE_RANGED_AUTO_ATTACK;
                    procVictim   = PROC_FLAG_TAKEN_RANGED_AUTO_ATTACK;
                }
                break;
        }
    }
    else if (attackType == BASE_ATTACK)
    {
        procAttacker = PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_DONE_MAINHAND_ATTACK;
        procVictim   = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    }
    else if (attackType == OFF_ATTACK)
    {
        procAttacker = PROC_FLAG_DONE_MELEE_AUTO_ATTACK | PROC_FLAG_DONE_OFFHAND_ATTACK;
        procVictim   = PROC_FLAG_TAKEN_MELEE_AUTO_ATTACK;
    }
}

uint32 createProcExtendMask(SpellNonMeleeDamage* damageInfo, SpellMissInfo missCondition)
{
    uint32 procEx = PROC_EX_NONE;
    // Check victim state
    if (missCondition != SPELL_MISS_NONE)
        switch (missCondition)
        {
            case SPELL_MISS_MISS:
                procEx |= PROC_EX_MISS;
                break;
            case SPELL_MISS_RESIST:
                procEx |= PROC_EX_RESIST;
                break;
            case SPELL_MISS_DODGE:
                procEx |= PROC_EX_DODGE;
                break;
            case SPELL_MISS_PARRY:
                procEx |= PROC_EX_PARRY;
                break;
            case SPELL_MISS_BLOCK:
                procEx |= PROC_EX_BLOCK;
                break;
            case SPELL_MISS_EVADE:
                procEx |= PROC_EX_EVADE;
                break;
            case SPELL_MISS_IMMUNE:
                procEx |= PROC_EX_IMMUNE;
                break;
            case SPELL_MISS_IMMUNE2:
                procEx |= PROC_EX_IMMUNE;
                break;
            case SPELL_MISS_DEFLECT:
                procEx |= PROC_EX_DEFLECT;
                break;
            case SPELL_MISS_ABSORB:
                procEx |= PROC_EX_ABSORB;
                break;
            case SPELL_MISS_REFLECT:
                procEx |= PROC_EX_REFLECT;
                break;
            default:
                break;
        }
    else
    {
        // On block
        if (damageInfo->blocked)
            procEx |= PROC_EX_BLOCK;
        // On absorb
        if (damageInfo->absorb)
            procEx |= PROC_EX_ABSORB;
        // On crit
        if (damageInfo->HitInfo & SPELL_HIT_TYPE_CRIT)
            procEx |= PROC_EX_CRITICAL_HIT;
        else
            procEx |= PROC_EX_NORMAL_HIT;
    }
    return procEx;
}

void Unit::ProcDamageAndSpellFor(bool isVictim, Unit* target, uint32 procFlag, uint32 procExtra, WeaponAttackType attType, SpellInfo const* procSpellInfo, uint32 damage, SpellInfo const* procAura, int8 procAuraEffectIndex, Spell const* procSpell, DamageInfo* damageInfo, HealInfo* healInfo, uint32 procPhase)
{
    // Player is loaded now - do not allow passive spell casts to proc
    if (GetTypeId() == TYPEID_PLAYER && ToPlayer()->GetSession()->PlayerLoading())
        return;
    // For melee/ranged based attack need update skills and set some Aura states if victim present
    if (procFlag & MELEE_BASED_TRIGGER_MASK && target && procPhase == PROC_SPELL_PHASE_HIT)
    {
        // Xinef: Shaman in ghost wolf form cant proc anything melee based
        if (!isVictim && GetShapeshiftForm() == FORM_GHOSTWOLF)
            return;

        // Update skills here for players
        // only when you are not fighting other players or their pets/totems (pvp)
        if (IsPlayer() && !target->IsCharmedOwnedByPlayerOrPlayer())
        {
            // On melee based hit/miss/resist/parry/dodge need to update skill (for victim and attacker)
            if (procExtra & (PROC_EX_NORMAL_HIT | PROC_EX_MISS | PROC_EX_RESIST | PROC_EX_PARRY | PROC_EX_DODGE))
            {
                ToPlayer()->UpdateCombatSkills(target, attType, isVictim, procSpell ? procSpell->m_weaponItem : nullptr);
            }
            // Update defence if player is victim and we block - TODO: confirm that blocked attacks only have a chance to increase defence skill
            else if (isVictim && procExtra & (PROC_EX_BLOCK))
            {
                ToPlayer()->UpdateCombatSkills(target, attType, true);
            }
        }
        // If exist crit/parry/dodge/block need update aura state (for victim and attacker)
        if (procExtra & (PROC_EX_CRITICAL_HIT | PROC_EX_PARRY | PROC_EX_DODGE | PROC_EX_BLOCK))
        {
            // for victim
            if (isVictim)
            {
                // if victim and dodge attack
                if (procExtra & PROC_EX_DODGE)
                {
                    // Update AURA_STATE on dodge
                    if (!IsClass(CLASS_ROGUE, CLASS_CONTEXT_ABILITY_REACTIVE)) // skip Rogue Riposte
                    {
                        ModifyAuraState(AURA_STATE_DEFENSE, true);
                        StartReactiveTimer(REACTIVE_DEFENSE);
                    }
                }
                // if victim and parry attack
                if (procExtra & PROC_EX_PARRY)
                {
                    // For Hunters only Counterattack (skip Mongoose bite)
                    if (IsClass(CLASS_HUNTER, CLASS_CONTEXT_ABILITY_REACTIVE))
                    {
                        ModifyAuraState(AURA_STATE_HUNTER_PARRY, true);
                        StartReactiveTimer(REACTIVE_HUNTER_PARRY);
                    }
                    else
                    {
                        ModifyAuraState(AURA_STATE_DEFENSE, true);
                        StartReactiveTimer(REACTIVE_DEFENSE);
                    }
                }
                // if and victim block attack
                if (procExtra & PROC_EX_BLOCK)
                {
                    ModifyAuraState(AURA_STATE_DEFENSE, true);
                    StartReactiveTimer(REACTIVE_DEFENSE);
                }
            }
            else // For attacker
            {
                // Overpower on victim dodge
                if (procExtra & PROC_EX_DODGE)
                {
                    if (IsClass(CLASS_WARRIOR, CLASS_CONTEXT_ABILITY_REACTIVE))
                    {
                        AddComboPoints(target, 1);
                        StartReactiveTimer(REACTIVE_OVERPOWER);
                    }
                }

                // Wolverine Bite
                if ((procExtra & PROC_HIT_CRITICAL) && IsHunterPet())
                {
                    AddComboPoints(target, 1);
                    StartReactiveTimer(REACTIVE_WOLVERINE_BITE);
                }
            }
        }
    }

    Unit* actor = isVictim ? target : this;
    Unit* actionTarget = !isVictim ? target : this;

    ProcEventInfo eventInfo = ProcEventInfo(actor, actionTarget, target, procFlag, 0, procPhase, procExtra, procSpell, damageInfo, healInfo, procAura, procAuraEffectIndex);

    ProcTriggeredList procTriggered;
    // Fill procTriggered list
    for (AuraApplicationMap::const_iterator itr = GetAppliedAuras().begin(); itr != GetAppliedAuras().end(); ++itr)
    {
        // Do not allow auras to proc from effect triggered by itself
        if (procAura && procAura->Id == itr->first)
            continue;

        // Xinef: Generic Item Equipment cooldown, -1 is a special marker
        if (itr->second->GetBase()->GetCastItemGUID() && HasSpellItemCooldown(itr->first, uint32(-1)))
            continue;

        ProcTriggeredData triggerData(itr->second->GetBase());
        // Defensive procs are active on absorbs (so absorption effects are not a hindrance)
        bool active = damage || (procExtra & PROC_EX_BLOCK && isVictim);
        if (isVictim)
            procExtra &= ~PROC_EX_INTERNAL_REQ_FAMILY;

        SpellInfo const* spellProto = itr->second->GetBase()->GetSpellInfo();

        // only auras that have trigger spell should proc from fully absorbed damage
        if (procExtra & PROC_EX_ABSORB && isVictim)
            if (damage || spellProto->Effects[EFFECT_0].TriggerSpell || spellProto->Effects[EFFECT_1].TriggerSpell || spellProto->Effects[EFFECT_2].TriggerSpell)
                active = true;

        // xinef: fix spell procing from damaging / healing casts if spell has DoT / HoT effect only
        // only player spells are taken into account
        if (!active && !isVictim && !(procFlag & PROC_FLAG_DONE_PERIODIC) && procSpellInfo && procSpellInfo->SpellFamilyName && (procSpellInfo->HasAura(SPELL_AURA_PERIODIC_DAMAGE) || procSpellInfo->HasAura(SPELL_AURA_PERIODIC_HEAL)))
            active = true;

        // AuraScript Hook
        if (!triggerData.aura->CallScriptCheckProcHandlers(itr->second, eventInfo))
        {
            continue;
        }

        bool isTriggeredAtSpellProcEvent = IsTriggeredAtSpellProcEvent(target, triggerData.aura, attType, isVictim, active, triggerData.spellProcEvent, eventInfo);

        // AuraScript Hook
        if (!triggerData.aura->CallScriptAfterCheckProcHandlers(itr->second, eventInfo, isTriggeredAtSpellProcEvent))
        {
            continue;
        }

        // do checks using conditions table
        ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_SPELL_PROC, spellProto->Id);
        ConditionSourceInfo condInfo = ConditionSourceInfo(eventInfo.GetActor(), eventInfo.GetActionTarget());
        if (!sConditionMgr->IsObjectMeetToConditions(condInfo, conditions))
        {
            continue;
        }

        // Triggered spells not triggering additional spells
        //bool triggered = !spellProto->HasAttribute(SPELL_ATTR3_CAN_PROC_FROM_PROCS) ?
        //    (procExtra & PROC_EX_INTERNAL_TRIGGERED && !(procFlag & PROC_FLAG_DONE_TRAP_ACTIVATION)) : false;

        bool hasTriggeredProc = false;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (itr->second->HasEffect(i))
            {
                AuraEffect* aurEff = itr->second->GetBase()->GetEffect(i);

                // Skip this auras
                if (isNonTriggerAura[aurEff->GetAuraType()])
                    continue;

                // If not trigger by default and spellProcEvent == nullptr - skip
                if (!isTriggerAura[aurEff->GetAuraType()] && !triggerData.spellProcEvent)
                    continue;

                switch (aurEff->GetAuraType())
                {
                    case SPELL_AURA_PROC_TRIGGER_SPELL:
                    case SPELL_AURA_MANA_SHIELD:
                    case SPELL_AURA_DUMMY:
                    case SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE:
                        if (uint32 triggerSpellId = aurEff->GetSpellInfo()->Effects[i].TriggerSpell)
                        {
                            triggerData.triggerSpelId[i] = triggerSpellId;
                            hasTriggeredProc = true;
                        }
                        break;
                    default:
                        break;
                }

                // Some spells must always trigger
                //if (isAlwaysTriggeredAura[aurEff->GetAuraType()])
                triggerData.effMask |= 1 << i;
            }
        }

        if (triggerData.effMask)
        {
            // If there is aura that triggers another proc aura, make sure that the triggered one is going to be proccessed on top of it
            if (hasTriggeredProc)
            {
                bool proccessed = false;
                for (uint8 i = 0; i < EFFECT_ALL; ++i)
                {
                    if (uint32 triggeredSpellId = triggerData.triggerSpelId[i])
                    {
                        auto iter = std::find(procTriggered.begin(), procTriggered.end(), triggeredSpellId);
                        if (iter != procTriggered.end())
                        {
                            std::advance(iter, 1);
                            procTriggered.insert(iter, triggerData);
                            proccessed = true;
                            break;
                        }
                    }
                }

                if (!proccessed)
                {
                    procTriggered.push_front(triggerData);
                }
            }
            else
            {
                procTriggered.push_front(triggerData);
            }
        }
    }

    // Nothing found
    if (procTriggered.empty())
        return;

    // Note: must SetCantProc(false) before return
    if (procExtra & (PROC_EX_INTERNAL_TRIGGERED | PROC_EX_INTERNAL_CANT_PROC))
        SetCantProc(true);

    // Handle effects proceed this time
    for (ProcTriggeredList::const_iterator i = procTriggered.begin(); i != procTriggered.end(); ++i)
    {
        // look for aura in auras list, it may be removed while proc event processing
        if (i->aura->IsRemoved())
            continue;

        bool useCharges  = i->aura->IsUsingCharges();
        // no more charges to use, prevent proc
        if (useCharges && !i->aura->GetCharges())
            continue;

        bool takeCharges = false;
        SpellInfo const* spellInfo = i->aura->GetSpellInfo();

        AuraApplication* aurApp = i->aura->GetApplicationOfTarget(GetGUID());

        bool prepare = i->aura->CallScriptPrepareProcHandlers(aurApp, eventInfo);

        // For players set spell cooldown if need
        uint32 cooldown = 0;
        if (prepare && i->spellProcEvent && i->spellProcEvent->cooldown)
            cooldown = i->spellProcEvent->cooldown;

        // Xinef: set cooldown for actual proc
        eventInfo.SetProcCooldown(cooldown);

        // Note: must SetCantProc(false) before return
        if (spellInfo->HasAttribute(SPELL_ATTR3_INSTANT_TARGET_PROCS))
            SetCantProc(true);

        bool handled = i->aura->CallScriptProcHandlers(aurApp, eventInfo);

        // "handled" is needed as long as proc can be handled in multiple places
        if (!handled && HandleAuraProc(target, damage, i->aura, procSpellInfo, procFlag, procExtra, cooldown, &handled))
        {
            uint32 Id = i->aura->GetId();
            LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting spell {} (triggered with value by {} aura of spell {})", spellInfo->Id, (isVictim ? "a victim's" : "an attacker's"), Id);
            takeCharges = true;
        }

        if (!handled)
            for (uint8 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
            {
                if (!(i->effMask & (1 << effIndex)))
                    continue;

                AuraEffect* triggeredByAura = i->aura->GetEffect(effIndex);
                ASSERT(triggeredByAura);

                bool prevented = i->aura->CallScriptEffectProcHandlers(triggeredByAura, aurApp, eventInfo);
                if (prevented)
                {
                    takeCharges = true;
                    continue;
                }

                switch (triggeredByAura->GetAuraType())
                {
                    case SPELL_AURA_PROC_TRIGGER_SPELL:
                        {
                            LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting spell {} (triggered by {} aura of spell {})", spellInfo->Id, (isVictim ? "a victim's" : "an attacker's"), triggeredByAura->GetId());
                            // Don`t drop charge or add cooldown for not started trigger
                            if (HandleProcTriggerSpell(target, damage, triggeredByAura, procSpellInfo, procFlag, procExtra, cooldown, procPhase, eventInfo))
                                takeCharges = true;
                            break;
                        }
                    case SPELL_AURA_PROC_TRIGGER_DAMAGE:
                        {
                            // target has to be valid
                            if (!eventInfo.GetProcTarget())
                                break;

                            triggeredByAura->HandleProcTriggerDamageAuraProc(aurApp, eventInfo); // this function is part of the new proc system
                            takeCharges = true;
                            break;
                        }
                    case SPELL_AURA_MANA_SHIELD:
                    case SPELL_AURA_DUMMY:
                        {
                            LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting spell id {} (triggered by {} dummy aura of spell {})", spellInfo->Id, (isVictim ? "a victim's" : "an attacker's"), triggeredByAura->GetId());
                            if (HandleDummyAuraProc(target, damage, triggeredByAura, procSpellInfo, procFlag, procExtra, cooldown, eventInfo))
                                takeCharges = true;
                            break;
                        }
                    case SPELL_AURA_OBS_MOD_POWER:
                    case SPELL_AURA_MOD_SPELL_CRIT_CHANCE:
                    case SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN:
                    case SPELL_AURA_MOD_MELEE_HASTE:
                        LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting spell id {} (triggered by {} aura of spell {})", spellInfo->Id, isVictim ? "a victim's" : "an attacker's", triggeredByAura->GetId());
                        takeCharges = true;
                        break;
                    case SPELL_AURA_OVERRIDE_CLASS_SCRIPTS:
                        {
                            LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting spell id {} (triggered by {} aura of spell {})", spellInfo->Id, (isVictim ? "a victim's" : "an attacker's"), triggeredByAura->GetId());
                            if (HandleOverrideClassScriptAuraProc(target, damage, triggeredByAura, procSpellInfo, cooldown))
                                takeCharges = true;
                            break;
                        }
                    case SPELL_AURA_RAID_PROC_FROM_CHARGE_WITH_VALUE:
                        {
                            LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting mending (triggered by {} dummy aura of spell {})",
                                           (isVictim ? "a victim's" : "an attacker's"), triggeredByAura->GetId());
                            if (damage > 0)
                            {
                                HandleAuraRaidProcFromChargeWithValue(triggeredByAura);
                                takeCharges = true;
                            }
                            break;
                        }
                    case SPELL_AURA_RAID_PROC_FROM_CHARGE:
                        {
                            LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting mending (triggered by {} dummy aura of spell {})",
                                           (isVictim ? "a victim's" : "an attacker's"), triggeredByAura->GetId());
                            HandleAuraRaidProcFromCharge(triggeredByAura);
                            takeCharges = true;
                            break;
                        }
                    case SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE:
                        {
                            LOG_DEBUG("spells.aura", "ProcDamageAndSpell: casting spell {} (triggered with value by {} aura of spell {})", spellInfo->Id, (isVictim ? "a victim's" : "an attacker's"), triggeredByAura->GetId());

                            if (HandleProcTriggerSpell(target, damage, triggeredByAura, procSpellInfo, procFlag, procExtra, cooldown, procPhase, eventInfo))
                                takeCharges = true;
                            break;
                        }
                    case SPELL_AURA_MOD_CASTING_SPEED_NOT_STACK:
                        // Skip melee hits or instant cast spells
                        // xinef: check channeled spells which are affected by haste also
                        if (procSpellInfo && (procSpellInfo->SpellFamilyName || GetTypeId() != TYPEID_PLAYER) &&
                                (procSpellInfo->CalcCastTime() > 0 /*||
                        (procSpell->IsChanneled() && procSpell->GetDuration() > 0 && (HasAuraTypeWithAffectMask(SPELL_AURA_PERIODIC_HASTE, procSpell) || procSpell->HasAttribute(SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC)))*/))
                            takeCharges = true;
                        break;
                    case SPELL_AURA_REFLECT_SPELLS_SCHOOL:
                        // Skip Melee hits and spells ws wrong school
                        if (procSpellInfo && (triggeredByAura->GetMiscValue() & procSpellInfo->SchoolMask)) // School check
                            takeCharges = true;
                        break;
                    case SPELL_AURA_SPELL_MAGNET:
                        // Skip Melee hits and targets with magnet aura
                        if (procSpellInfo && (triggeredByAura->GetBase()->GetUnitOwner()->ToUnit() == ToUnit())) // Magnet
                            takeCharges = true;
                        break;
                    case SPELL_AURA_MOD_POWER_COST_SCHOOL_PCT:
                    case SPELL_AURA_MOD_POWER_COST_SCHOOL:
                        // Skip melee hits and spells ws wrong school or zero cost
                        if (procSpellInfo &&
                                (procSpellInfo->ManaCost != 0 || procSpellInfo->ManaCostPercentage != 0 || (procSpellInfo->SpellFamilyFlags[1] & 0x2)) && // Cost check, mutilate include
                                (triggeredByAura->GetMiscValue() & procSpellInfo->SchoolMask))          // School check
                            takeCharges = true;
                        break;
                    case SPELL_AURA_MECHANIC_IMMUNITY:
                    case SPELL_AURA_MOD_MECHANIC_RESISTANCE:
                        // Compare mechanic
                        if (procSpellInfo && procSpellInfo->Mechanic == uint32(triggeredByAura->GetMiscValue()))
                            takeCharges = true;
                        break;
                    case SPELL_AURA_MOD_DAMAGE_FROM_CASTER:
                        // Compare casters
                        if (target && triggeredByAura->GetCasterGUID() == target->GetGUID())
                            takeCharges = true;
                        break;
                    // CC Auras which use their amount amount to drop
                    // Are there any more auras which need this?
                    case SPELL_AURA_MOD_CONFUSE:
                    case SPELL_AURA_MOD_FEAR:
                    case SPELL_AURA_MOD_STUN:
                    case SPELL_AURA_MOD_ROOT:
                    case SPELL_AURA_TRANSFORM:
                        {
                            // Spell own direct damage at apply wont break the CC
                            // Xinef: Or when the aura is at full duration (assume that such auras should be added at the end, skipping all damage procs etc.)
                            if (procSpellInfo)
                                if ((!i->aura->IsPermanent() && i->aura->GetDuration() == i->aura->GetMaxDuration()) || procSpellInfo->Id == triggeredByAura->GetId() ||
                                    procSpellInfo->HasAttribute(SPELL_ATTR4_REACTIVE_DAMAGE_PROC))
                                    break;

                            // chargeable mods are breaking on hit
                            if (useCharges)
                                takeCharges = true;
                            else if (triggeredByAura->GetAmount()) // aura must have amount
                            {
                                int32 damageLeft = triggeredByAura->GetAmount();
                                // No damage left
                                if (damageLeft < int32(damage))
                                    i->aura->Remove();
                                else
                                    triggeredByAura->SetAmount(damageLeft - damage);
                            }
                            break;
                        }
                    case SPELL_AURA_ABILITY_IGNORE_AURASTATE:
                        if (procSpellInfo && procSpellInfo->Id == 20647) // hack for warriors execute, both dummy and damage spell are affected by ignore aurastate aura
                            break;
                        takeCharges = true;
                        break;
                    case SPELL_AURA_ADD_FLAT_MODIFIER:
                    case SPELL_AURA_ADD_PCT_MODIFIER:
                    {
                        if (triggeredByAura->GetSpellModifier())
                        {
                            // Do proc if mod is consumed by spell
                            if (!procSpell || procSpell->m_appliedMods.find(i->aura) != procSpell->m_appliedMods.end())
                            {
                                takeCharges = true;
                            }
                        }
                        break;
                    }
                    default:
                        takeCharges = true;
                        break;
                }
                i->aura->CallScriptAfterEffectProcHandlers(triggeredByAura, aurApp, eventInfo);
            }
        // Remove charge (aura can be removed by triggers)
        // xinef: take into account attribute6 of proc spell
        if (prepare && useCharges && takeCharges)
            if (!procSpellInfo || isVictim || !procSpellInfo->HasAttribute(SPELL_ATTR6_DO_NOT_CONSUME_RESOURCES))
                i->aura->DropCharge();

        i->aura->CallScriptAfterProcHandlers(aurApp, eventInfo);

        if (spellInfo->HasAttribute(SPELL_ATTR3_INSTANT_TARGET_PROCS))
            SetCantProc(false);
    }

    // Cleanup proc requirements
    if (procExtra & (PROC_EX_INTERNAL_TRIGGERED | PROC_EX_INTERNAL_CANT_PROC))
        SetCantProc(false);
}

void Unit::GetProcAurasTriggeredOnEvent(std::list<AuraApplication*>& aurasTriggeringProc, std::list<AuraApplication*>* procAuras, ProcEventInfo eventInfo)
{
    // use provided list of auras which can proc
    if (procAuras)
    {
        for (std::list<AuraApplication*>::iterator itr = procAuras->begin(); itr != procAuras->end(); ++itr)
        {
            ASSERT((*itr)->GetTarget() == this);
            if (!(*itr)->GetRemoveMode())
                if ((*itr)->GetBase()->IsProcTriggeredOnEvent(*itr, eventInfo))
                {
                    (*itr)->GetBase()->PrepareProcToTrigger(*itr, eventInfo);
                    aurasTriggeringProc.push_back(*itr);
                }
        }
    }
    // or generate one on our own
    else
    {
        for (AuraApplicationMap::iterator itr = GetAppliedAuras().begin(); itr != GetAppliedAuras().end(); ++itr)
        {
            if (itr->second->GetBase()->IsProcTriggeredOnEvent(itr->second, eventInfo))
            {
                itr->second->GetBase()->PrepareProcToTrigger(itr->second, eventInfo);
                aurasTriggeringProc.push_back(itr->second);
            }
        }
    }
}

void Unit::TriggerAurasProcOnEvent(CalcDamageInfo& damageInfo)
{
    DamageInfo dmgInfo = DamageInfo(damageInfo);
    TriggerAurasProcOnEvent(nullptr, nullptr, damageInfo.target, damageInfo.procAttacker, damageInfo.procVictim, 0, 0, damageInfo.procEx, nullptr, &dmgInfo, nullptr);
}

void Unit::TriggerAurasProcOnEvent(std::list<AuraApplication*>* myProcAuras, std::list<AuraApplication*>* targetProcAuras, Unit* actionTarget, uint32 typeMaskActor, uint32 typeMaskActionTarget, uint32 spellTypeMask, uint32 spellPhaseMask, uint32 hitMask, Spell* spell, DamageInfo* damageInfo, HealInfo* healInfo)
{
    // prepare data for self trigger
    ProcEventInfo myProcEventInfo = ProcEventInfo(this, actionTarget, actionTarget, typeMaskActor, spellTypeMask, spellPhaseMask, hitMask, spell, damageInfo, healInfo);
    std::list<AuraApplication*> myAurasTriggeringProc;
    GetProcAurasTriggeredOnEvent(myAurasTriggeringProc, myProcAuras, myProcEventInfo);

    // prepare data for target trigger
    ProcEventInfo targetProcEventInfo = ProcEventInfo(this, actionTarget, this, typeMaskActionTarget, spellTypeMask, spellPhaseMask, hitMask, spell, damageInfo, healInfo);
    std::list<AuraApplication*> targetAurasTriggeringProc;
    if (typeMaskActionTarget)
        GetProcAurasTriggeredOnEvent(targetAurasTriggeringProc, targetProcAuras, targetProcEventInfo);

    TriggerAurasProcOnEvent(myProcEventInfo, myAurasTriggeringProc);

    if (typeMaskActionTarget)
        TriggerAurasProcOnEvent(targetProcEventInfo, targetAurasTriggeringProc);
}

void Unit::TriggerAurasProcOnEvent(ProcEventInfo& eventInfo, std::list<AuraApplication*>& aurasTriggeringProc)
{
    for (std::list<AuraApplication*>::iterator itr = aurasTriggeringProc.begin(); itr != aurasTriggeringProc.end(); ++itr)
    {
        if (!(*itr)->GetRemoveMode())
            (*itr)->GetBase()->TriggerProcOnEvent(*itr, eventInfo);
    }
}

Player* Unit::GetSpellModOwner() const
{
    if (Player* player = const_cast<Unit*>(this)->ToPlayer())
    {
        return player;
    }

    if (Unit* owner = GetOwner())
    {
        if (Player* player = owner->ToPlayer())
        {
            return player;
        }
    }

    // Special handling for Eye of Kilrogg
    if (GetEntry() == NPC_EYE_OF_KILROGG)
    {
        if (TempSummon const* tempSummon = ToTempSummon())
        {
            if (Unit* summoner = tempSummon->GetSummonerUnit())
            {
                return summoner->ToPlayer();
            }
        }
    }

    return nullptr;
}

///----------Pet responses methods-----------------
void Unit::SendPetActionFeedback(uint8 msg)
{
    Unit* owner = GetOwner();
    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return;

    WorldPacket data(SMSG_PET_ACTION_FEEDBACK, 1);
    data << uint8(msg);
    owner->ToPlayer()->GetSession()->SendPacket(&data);
}

void Unit::SendPetTalk(uint32 pettalk)
{
    Unit* owner = GetOwner();
    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return;

    WorldPacket data(SMSG_PET_ACTION_SOUND, 8 + 4);
    data << GetGUID();
    data << uint32(pettalk);
    owner->ToPlayer()->GetSession()->SendPacket(&data);
}

void Unit::SendPetAIReaction(ObjectGuid guid)
{
    Unit* owner = GetOwner();
    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return;

    WorldPacket data(SMSG_AI_REACTION, 8 + 4);
    data << guid;
    data << uint32(AI_REACTION_HOSTILE);
    owner->ToPlayer()->GetSession()->SendPacket(&data);
}

///----------End of Pet responses methods----------

MovementGeneratorType Unit::GetDefaultMovementType() const
{
    return IDLE_MOTION_TYPE;
}

void Unit::StopMoving()
{
    ClearUnitState(UNIT_STATE_MOVING);

    // not need send any packets if not in world or not moving
    if (!IsInWorld())
        return;

    if (movespline->Finalized())
        return;

    // Update position now since Stop does not start a new movement that can be updated later
    if (movespline->HasStarted())
        UpdateSplinePosition();

    Movement::MoveSplineInit init(this);
    init.Stop();
}

void Unit::PauseMovement(uint32 timer /* = 0*/, uint8 slot /* = 0*/)
{
    if (slot >= MAX_MOTION_SLOT)
        return;

    if (MovementGenerator* movementGenerator = GetMotionMaster()->GetMotionSlot(slot))
        movementGenerator->Pause(timer);

    StopMoving();
}

void Unit::ResumeMovement(uint32 timer /* = 0*/, uint8 slot /* = 0*/)
{
    if (slot >= MAX_MOTION_SLOT)
        return;

    if (MovementGenerator* movementGenerator = GetMotionMaster()->GetMotionSlot(slot))
        movementGenerator->Resume(timer);
}

void Unit::StopMovingOnCurrentPos() // pussywizard
{
    ClearUnitState(UNIT_STATE_MOVING);

    // not need send any packets if not in world
    if (!IsInWorld())
        return;

    DisableSpline(); // pussywizard: required so Launch() won't recalculate position from previous spline
    Movement::MoveSplineInit init(this);
    init.MoveTo(GetPositionX(), GetPositionY(), GetPositionZ());
    init.SetFacing(GetOrientation());
    init.Launch();
}

void Unit::SendMovementFlagUpdate(bool self /* = false */)
{
    WorldPacket data;
    BuildHeartBeatMsg(&data);
    SendMessageToSet(&data, self);
}

bool Unit::IsSitState() const
{
    uint8 s = getStandState();
    return
        s == UNIT_STAND_STATE_SIT_CHAIR        || s == UNIT_STAND_STATE_SIT_LOW_CHAIR  ||
        s == UNIT_STAND_STATE_SIT_MEDIUM_CHAIR || s == UNIT_STAND_STATE_SIT_HIGH_CHAIR ||
        s == UNIT_STAND_STATE_SIT;
}

bool Unit::IsStandState() const
{
    uint8 s = getStandState();
    return !IsSitState() && s != UNIT_STAND_STATE_SLEEP && s != UNIT_STAND_STATE_KNEEL;
}

void Unit::SetStandState(uint8 state)
{
    SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_STAND_STATE, state);

    if (IsStandState())
        RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_NOT_SEATED);

    if (GetTypeId() == TYPEID_PLAYER)
    {
        WorldPacket data(SMSG_STANDSTATE_UPDATE, 1);
        data << (uint8)state;
        ToPlayer()->GetSession()->SendPacket(&data);
    }
}

bool Unit::IsPolymorphed() const
{
    uint32 transformId = getTransForm();
    if (!transformId)
        return false;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(transformId);
    if (!spellInfo)
        return false;

    return spellInfo->GetSpellSpecific() == SPELL_SPECIFIC_MAGE_POLYMORPH;
}

void Unit::RecalculateObjectScale()
{
    int32 scaleAuras = GetTotalAuraModifier(SPELL_AURA_MOD_SCALE) + GetTotalAuraModifier(SPELL_AURA_MOD_SCALE_2);
    float scale = GetNativeObjectScale() + CalculatePct(1.0f, scaleAuras);
    float scaleMin = GetTypeId() == TYPEID_PLAYER ? 0.1f : 0.01f;
    SetObjectScale(std::max(scale, scaleMin));
}

void Unit::SetDisplayId(uint32 modelId, float displayScale /*=1.f*/)
{
    SetUInt32Value(UNIT_FIELD_DISPLAYID, modelId);

    // Set Gender by modelId
    if (CreatureModelInfo const* minfo = sObjectMgr->GetCreatureModelInfo(modelId))
        SetByteValue(UNIT_FIELD_BYTES_0, 2, minfo->gender);

    SetObjectScale(displayScale);

    sScriptMgr->OnDisplayIdChange(this, modelId);
}

void Unit::RestoreDisplayId()
{
    AuraEffect* handledAura = nullptr;
    AuraEffect* handledAuraForced = nullptr;
    // try to receive model from transform auras
    AuraEffectList const& transforms = GetAuraEffectsByType(SPELL_AURA_TRANSFORM);
    if (!transforms.empty())
    {
        // iterate over already applied transform auras - from newest to oldest
        for (auto i = transforms.rbegin(); i != transforms.rend(); ++i)
        {
            if (AuraApplication const* aurApp = (*i)->GetBase()->GetApplicationOfTarget(GetGUID()))
            {
                if (!handledAura)
                    handledAura = (*i);
                // xinef: prefer negative/forced auras
                if ((*i)->GetSpellInfo()->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) || !aurApp->IsPositive())
                {
                    handledAuraForced = (*i);
                    break;
                }
            }
        }
    }

    // Xinef: include clone auras (eg mirror images)
    if (!handledAuraForced && !handledAura)
    {
        Unit::AuraEffectList const& cloneAuras = GetAuraEffectsByType(SPELL_AURA_CLONE_CASTER);
        if (!cloneAuras.empty())
            for (Unit::AuraEffectList::const_iterator i = cloneAuras.begin(); i != cloneAuras.end(); ++i)
                handledAura = *i;
    }

    AuraEffectList const& shapeshiftAura = GetAuraEffectsByType(SPELL_AURA_MOD_SHAPESHIFT);

    // xinef: order of execution is important!
    // first forced transform auras, then shapeshifts, then normal transform
    // transform aura was found
    if (handledAuraForced)
    {
        handledAuraForced->HandleEffect(this, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT, true);
        return;
    }
    else if (!shapeshiftAura.empty()) // we've found shapeshift
    {
        // only one such aura possible at a time
        if (uint32 modelId = GetModelForForm(GetShapeshiftForm(), shapeshiftAura.front()->GetId()))
        {
            SetDisplayId(modelId);
            return;
        }
    }
    else if (handledAura)
    {
        handledAura->HandleEffect(this, AURA_EFFECT_HANDLE_SEND_FOR_CLIENT, true);
        return;
    }

    // no auras found - set modelid to default
    SetDisplayId(GetNativeDisplayId());
}

void Unit::AddComboPoints(Unit* target, int8 count)
{
    if (!count)
    {
        return;
    }

    if (target && target != m_comboTarget)
    {
        if (m_comboTarget)
        {
            m_comboTarget->RemoveComboPointHolder(this);
        }

        m_comboTarget = target;
        m_comboPoints = count;
        target->AddComboPointHolder(this);
    }
    else
    {
        m_comboPoints = std::max<int8>(std::min<int8>(m_comboPoints + count, 5), 0);
    }

    SendComboPoints();
}

void Unit::ClearComboPoints()
{
    if (!m_comboTarget)
    {
        return;
    }

    // remove Premed-like effects
    // (NB: this Aura retains the CP while it's active - now that CP have reset, it shouldn't be there anymore)
    RemoveAurasByType(SPELL_AURA_RETAIN_COMBO_POINTS);

    m_comboPoints = 0;
    SendComboPoints();
    m_comboTarget->RemoveComboPointHolder(this);
    m_comboTarget = nullptr;
}

void Unit::SendComboPoints()
{
    if (m_cleanupDone)
    {
        return;
    }

    PackedGuid const packGUID = m_comboTarget ? m_comboTarget->GetPackGUID() : PackedGuid();
    if (Player* playerMe = ToPlayer())
    {
        WorldPacket data(SMSG_UPDATE_COMBO_POINTS, packGUID.size() + 1);
        data << packGUID;
        data << uint8(m_comboPoints);
        playerMe->SendDirectMessage(&data);
    }

    ObjectGuid ownerGuid = GetCharmerOrOwnerGUID();
    Player* owner = nullptr;
    if (ownerGuid.IsPlayer())
    {
        owner = ObjectAccessor::GetPlayer(*this, ownerGuid);
    }

    if (m_movedByPlayer || owner)
    {
        WorldPacket data(SMSG_PET_UPDATE_COMBO_POINTS, GetPackGUID().size() + packGUID.size() + 1);
        data << GetPackGUID();
        data << packGUID;
        data << uint8(m_comboPoints);

        if (m_movedByPlayer)
            m_movedByPlayer->ToPlayer()->SendDirectMessage(&data);

        if (owner && owner != m_movedByPlayer)
            owner->SendDirectMessage(&data);
    }
}

void Unit::ClearComboPointHolders()
{
    while (!m_ComboPointHolders.empty())
    {
        (*m_ComboPointHolders.begin())->ClearComboPoints(); // this also removes it from m_comboPointHolders
    }
}

void Unit::ClearAllReactives()
{
    for (uint8 i = 0; i < MAX_REACTIVE; ++i)
        m_reactiveTimer[i] = 0;

    if (HasAuraState(AURA_STATE_DEFENSE))
        ModifyAuraState(AURA_STATE_DEFENSE, false);
    if (IsClass(CLASS_HUNTER, CLASS_CONTEXT_ABILITY_REACTIVE) && HasAuraState(AURA_STATE_HUNTER_PARRY))
        ModifyAuraState(AURA_STATE_HUNTER_PARRY, false);
    if (IsClass(CLASS_WARRIOR, CLASS_CONTEXT_ABILITY_REACTIVE) && GetTypeId() == TYPEID_PLAYER)
        ClearComboPoints();
}

void Unit::UpdateReactives(uint32 p_time)
{
    for (uint8 i = 0; i < MAX_REACTIVE; ++i)
    {
        ReactiveType reactive = ReactiveType(i);

        if (!m_reactiveTimer[reactive])
            continue;

        if (m_reactiveTimer[reactive] <= p_time)
        {
            m_reactiveTimer[reactive] = 0;

            switch (reactive)
            {
                case REACTIVE_DEFENSE:
                    if (HasAuraState(AURA_STATE_DEFENSE))
                        ModifyAuraState(AURA_STATE_DEFENSE, false);
                    break;
                case REACTIVE_HUNTER_PARRY:
                    if (IsClass(CLASS_HUNTER, CLASS_CONTEXT_ABILITY_REACTIVE) && HasAuraState(AURA_STATE_HUNTER_PARRY))
                        ModifyAuraState(AURA_STATE_HUNTER_PARRY, false);
                    break;
                case REACTIVE_OVERPOWER:
                    if (IsClass(CLASS_WARRIOR, CLASS_CONTEXT_ABILITY_REACTIVE))
                    {
                        ClearComboPoints();
                    }
                    break;
                case REACTIVE_WOLVERINE_BITE:
                    if (IsHunterPet())
                        ClearComboPoints();
                    break;
                default:
                    break;
            }
        }
        else
        {
            m_reactiveTimer[reactive] -= p_time;
        }
    }
}

Unit* Unit::SelectNearbyTarget(Unit* exclude, float dist) const
{
    std::list<Unit*> targets;
    Acore::AnyUnfriendlyUnitInObjectRangeCheck u_check(this, this, dist);
    Acore::UnitListSearcher<Acore::AnyUnfriendlyUnitInObjectRangeCheck> searcher(this, targets, u_check);
    Cell::VisitAllObjects(this, searcher, dist);

    // remove current target
    if (GetVictim())
        targets.remove(GetVictim());

    if (exclude)
        targets.remove(exclude);

    // remove not LoS targets
    for (std::list<Unit*>::iterator tIter = targets.begin(); tIter != targets.end();)
    {
        if (!IsWithinLOSInMap(*tIter) || !IsValidAttackTarget(*tIter))
        {
            std::list<Unit*>::iterator tIter2 = tIter;
            ++tIter;
            targets.erase(tIter2);
        }
        else
            ++tIter;
    }

    // no appropriate targets
    if (targets.empty())
        return nullptr;

    // select random
    return Acore::Containers::SelectRandomContainerElement(targets);
}

Unit* Unit::SelectNearbyNoTotemTarget(Unit* exclude, float dist) const
{
    std::list<Unit*> targets;
    Acore::AnyUnfriendlyNoTotemUnitInObjectRangeCheck u_check(this, this, dist);
    Acore::UnitListSearcher<Acore::AnyUnfriendlyNoTotemUnitInObjectRangeCheck> searcher(this, targets, u_check);
    Cell::VisitAllObjects(this, searcher, dist);

    // remove current target
    if (GetVictim())
        targets.remove(GetVictim());

    if (exclude)
        targets.remove(exclude);

    // remove not LoS targets
    for (std::list<Unit*>::iterator tIter = targets.begin(); tIter != targets.end();)
    {
        if (!IsWithinLOSInMap(*tIter) || !IsValidAttackTarget(*tIter))
        {
            std::list<Unit*>::iterator tIter2 = tIter;
            ++tIter;
            targets.erase(tIter2);
        }
        else
            ++tIter;
    }

    // no appropriate targets
    if (targets.empty())
        return nullptr;

    // select random
    return Acore::Containers::SelectRandomContainerElement(targets);
}

void Unit::ApplyAttackTimePercentMod(WeaponAttackType att, float val, bool apply)
{
    float remainingTimePct = std::max((float)m_attackTimer[att], 0.0f) / (GetAttackTime(att) * m_modAttackSpeedPct[att]);
    if (val > 0)
    {
        ApplyPercentModFloatVar(m_modAttackSpeedPct[att], val, !apply);
        ApplyPercentModFloatValue(static_cast<uint16>(UNIT_FIELD_BASEATTACKTIME) + att, val, !apply);
    }
    else
    {
        ApplyPercentModFloatVar(m_modAttackSpeedPct[att], -val, apply);
        ApplyPercentModFloatValue(static_cast<uint16>(UNIT_FIELD_BASEATTACKTIME) + att, -val, apply);
    }
    m_attackTimer[att] = uint32(GetAttackTime(att) * m_modAttackSpeedPct[att] * remainingTimePct);
}

void Unit::ApplyCastTimePercentMod(float val, bool apply)
{
    if (val > 0)
        ApplyPercentModFloatValue(UNIT_MOD_CAST_SPEED, val, !apply);
    else
        ApplyPercentModFloatValue(UNIT_MOD_CAST_SPEED, -val, apply);
}

uint32 Unit::GetCastingTimeForBonus(SpellInfo const* spellProto, DamageEffectType damagetype, uint32 CastingTime) const
{
    // Not apply this to creature casted spells with casttime == 0
    if (CastingTime == 0 && GetTypeId() == TYPEID_UNIT && !IsPet())
        return 3500;

    if (CastingTime > 7000) CastingTime = 7000;
    if (CastingTime < 1500) CastingTime = 1500;

    if (damagetype == DOT && !spellProto->IsChanneled())
        CastingTime = 3500;

    int32 overTime    = 0;
    uint8 effects     = 0;
    bool DirectDamage = false;
    bool AreaEffect   = false;

    for (uint32 i = 0; i < MAX_SPELL_EFFECTS; i++)
    {
        switch (spellProto->Effects[i].Effect)
        {
            case SPELL_EFFECT_SCHOOL_DAMAGE:
            case SPELL_EFFECT_POWER_DRAIN:
            case SPELL_EFFECT_HEALTH_LEECH:
            case SPELL_EFFECT_ENVIRONMENTAL_DAMAGE:
            case SPELL_EFFECT_POWER_BURN:
            case SPELL_EFFECT_HEAL:
                DirectDamage = true;
                break;
            case SPELL_EFFECT_APPLY_AURA:
                switch (spellProto->Effects[i].ApplyAuraName)
                {
                    case SPELL_AURA_PERIODIC_DAMAGE:
                    case SPELL_AURA_PERIODIC_HEAL:
                    case SPELL_AURA_PERIODIC_LEECH:
                        if (spellProto->GetDuration())
                            overTime = spellProto->GetDuration();
                        break;
                    default:
                        // -5% per additional effect
                        ++effects;
                        break;
                }
            default:
                break;
        }

        if (spellProto->Effects[i].IsTargetingArea())
            AreaEffect = true;
    }

    // Combined Spells with Both Over Time and Direct Damage
    if (overTime > 0 && DirectDamage)
    {
        // mainly for DoTs which are 3500 here otherwise
        uint32 OriginalCastTime = spellProto->CalcCastTime();
        if (OriginalCastTime > 7000) OriginalCastTime = 7000;
        if (OriginalCastTime < 1500) OriginalCastTime = 1500;
        // Portion to Over Time
        float PtOT = (overTime / 15000.0f) / ((overTime / 15000.0f) + (OriginalCastTime / 3500.0f));

        if (damagetype == DOT)
            CastingTime = uint32(CastingTime * PtOT);
        else if (PtOT < 1.0f)
            CastingTime  = uint32(CastingTime * (1 - PtOT));
        else
            CastingTime = 0;
    }

    // Area Effect Spells receive only half of bonus
    if (AreaEffect)
        CastingTime /= 2;

    // 50% for damage and healing spells for leech spells from damage bonus and 0% from healing
    for (uint8 j = 0; j < MAX_SPELL_EFFECTS; ++j)
    {
        if (spellProto->Effects[j].Effect == SPELL_EFFECT_HEALTH_LEECH ||
                (spellProto->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA && spellProto->Effects[j].ApplyAuraName == SPELL_AURA_PERIODIC_LEECH))
        {
            CastingTime /= 2;
            break;
        }
    }

    // -5% of total per any additional effect
    for (uint8 i = 0; i < effects; ++i)
        CastingTime *= 0.95f;

    return CastingTime;
}

void Unit::UpdateAuraForGroup(uint8 slot)
{
    if (slot >= MAX_AURAS)                        // slot not found, return
        return;
    if (Player* player = ToPlayer())
    {
        if (player->GetGroup())
        {
            player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_AURAS);
            player->SetAuraUpdateMaskForRaid(slot);
        }
    }
    else if (GetTypeId() == TYPEID_UNIT && IsPet())
    {
        Pet* pet = ((Pet*)this);
        if (pet->isControlled())
        {
            Unit* owner = GetOwner();
            if (owner && (owner->GetTypeId() == TYPEID_PLAYER) && owner->ToPlayer()->GetGroup())
            {
                owner->ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_AURAS);
                pet->SetAuraUpdateMaskForRaid(slot);
            }
        }
    }
}

float Unit::CalculateDefaultCoefficient(SpellInfo const* spellInfo, DamageEffectType damagetype) const
{
    // Damage over Time spells bonus calculation
    float DotFactor = 1.0f;
    if (damagetype == DOT)
    {
        int32 DotDuration = spellInfo->GetDuration();
        if (!spellInfo->IsChanneled() && DotDuration > 0)
            DotFactor = DotDuration / 15000.0f;

        if (uint32 DotTicks = spellInfo->GetMaxTicks())
            DotFactor /= DotTicks;
    }

    int32 CastingTime = spellInfo->IsChanneled() ? spellInfo->GetDuration() : spellInfo->CalcCastTime();
    // Distribute Damage over multiple effects, reduce by AoE
    CastingTime = GetCastingTimeForBonus(spellInfo, damagetype, CastingTime);

    // As wowwiki says: C = (Cast Time / 3.5)
    return (CastingTime / 3500.0f) * DotFactor;
}

float Unit::GetAPMultiplier(WeaponAttackType attType, bool normalized)
{
    if (!normalized || GetTypeId() != TYPEID_PLAYER)
        return float(GetAttackTime(attType)) / 1000.0f;

    Item* Weapon = ToPlayer()->GetWeaponForAttack(attType, true);
    if (!Weapon)
        return 2.4f;                                         // fist attack

    switch (Weapon->GetTemplate()->InventoryType)
    {
        case INVTYPE_2HWEAPON:
            return 3.3f;
        case INVTYPE_RANGED:
        case INVTYPE_RANGEDRIGHT:
        case INVTYPE_THROWN:
            return 2.8f;
        case INVTYPE_WEAPON:
        case INVTYPE_WEAPONMAINHAND:
        case INVTYPE_WEAPONOFFHAND:
        default:
            return Weapon->GetTemplate()->SubClass == ITEM_SUBCLASS_WEAPON_DAGGER ? 1.7f : 2.4f;
    }
}

bool Unit::IsUnderLastManaUseEffect() const
{
    return  getMSTimeDiff(m_lastManaUse, GameTime::GetGameTimeMS().count()) < 5000;
}

void Unit::SetContestedPvP(Player* attackedPlayer, bool lookForNearContestedGuards)
{
    Player* player = GetCharmerOrOwnerPlayerOrPlayerItself();

    if (!player || ((attackedPlayer && (attackedPlayer == player || (player->duel && player->duel->Opponent == attackedPlayer))) || player->InBattleground()))
        return;

    // check if there any guards that should care about the contested flag on player
    if (lookForNearContestedGuards)
    {
        std::list<Unit*> targets;
        Acore::NearestVisibleDetectableContestedGuardUnitCheck u_check(this);
        Acore::UnitListSearcher<Acore::NearestVisibleDetectableContestedGuardUnitCheck> searcher(this, targets, u_check);
        Cell::VisitAllObjects(this, searcher, MAX_AGGRO_RADIUS);

        // return if there are no contested guards found
        if (!targets.size())
        {
            return;
        }
    }

    player->SetContestedPvPTimer(30000);
    if (!player->HasUnitState(UNIT_STATE_ATTACK_PLAYER))
    {
        player->AddUnitState(UNIT_STATE_ATTACK_PLAYER);
        player->SetPlayerFlag(PLAYER_FLAGS_CONTESTED_PVP);
        // call MoveInLineOfSight for nearby contested guards
        AddToNotify(NOTIFY_AI_RELOCATION);
    }
    if (!HasUnitState(UNIT_STATE_ATTACK_PLAYER))
    {
        AddUnitState(UNIT_STATE_ATTACK_PLAYER);
        // call MoveInLineOfSight for nearby contested guards
        AddToNotify(NOTIFY_AI_RELOCATION);
    }
}

void Unit::AddPetAura(PetAura const* petSpell)
{
    if (GetTypeId() != TYPEID_PLAYER)
        return;

    m_petAuras.insert(petSpell);
    if (Pet* pet = ToPlayer()->GetPet())
        pet->CastPetAura(petSpell);
    else if (Unit* charm = GetCharm())
        charm->CastPetAura(petSpell);
}

void Unit::RemovePetAura(PetAura const* petSpell)
{
    if (GetTypeId() != TYPEID_PLAYER)
        return;

    m_petAuras.erase(petSpell);
    if (Pet* pet = ToPlayer()->GetPet())
        pet->RemoveAurasDueToSpell(petSpell->GetAura(pet->GetEntry()));
    if (Unit* charm = GetCharm())
        charm->RemoveAurasDueToSpell(petSpell->GetAura(charm->GetEntry()));
}

void Unit::CastPetAura(PetAura const* aura)
{
    uint32 auraId = aura->GetAura(GetEntry());
    if (!auraId)
        return;

    if (auraId == 35696)                                      // Demonic Knowledge
    {
        int32 basePoints = aura->GetDamage();
        CastCustomSpell(this, auraId, &basePoints, nullptr, nullptr, true);
    }
    else
        CastSpell(this, auraId, true);
}

bool Unit::IsPetAura(Aura const* aura)
{
    Unit* owner = GetOwner();

    if (!owner || owner->GetTypeId() != TYPEID_PLAYER)
        return false;

    // if the owner has that pet aura, return true
    for (PetAura const* petAura : owner->m_petAuras)
        if (petAura->GetAura(GetEntry()) == aura->GetId())
            return true;

    return false;
}

Pet* Unit::CreateTamedPetFrom(Creature* creatureTarget, uint32 spell_id)
{
    if (GetTypeId() != TYPEID_PLAYER)
        return nullptr;

    Pet* pet = new Pet(ToPlayer(), HUNTER_PET);

    if (!pet->CreateBaseAtCreature(creatureTarget))
    {
        delete pet;
        return nullptr;
    }

    uint8 level = creatureTarget->GetLevel() + 5 < GetLevel() ? (GetLevel() - 5) : creatureTarget->GetLevel();

    if (!InitTamedPet(pet, level, spell_id))
    {
        delete pet;
        return nullptr;
    }

    return pet;
}

Pet* Unit::CreateTamedPetFrom(uint32 creatureEntry, uint32 spell_id)
{
    if (GetTypeId() != TYPEID_PLAYER)
        return nullptr;

    CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creatureEntry);
    if (!creatureInfo)
        return nullptr;

    Pet* pet = new Pet(ToPlayer(), HUNTER_PET);

    if (!pet->CreateBaseAtCreatureInfo(creatureInfo, this) || !InitTamedPet(pet, GetLevel(), spell_id))
    {
        delete pet;
        return nullptr;
    }

    return pet;
}

bool Unit::InitTamedPet(Pet* pet, uint8 level, uint32 spell_id)
{
    Player* player = ToPlayer();
    PetStable& petStable = player->GetOrInitPetStable();
    if (petStable.CurrentPet || petStable.GetUnslottedHunterPet())
        return false;

    pet->SetCreatorGUID(GetGUID());
    pet->SetFaction(GetFaction());
    pet->SetUInt32Value(UNIT_CREATED_BY_SPELL, spell_id);

    if (GetTypeId() == TYPEID_PLAYER)
        pet->ReplaceAllUnitFlags(UNIT_FLAG_PLAYER_CONTROLLED);

    if (!pet->InitStatsForLevel(level))
    {
        LOG_ERROR("entities.unit", "Pet::InitStatsForLevel() failed for creature (Entry: {})!", pet->GetEntry());
        return false;
    }

    pet->GetCharmInfo()->SetPetNumber(sObjectMgr->GeneratePetNumber(), true);
    // this enables pet details window (Shift+P)
    pet->InitPetCreateSpells();
    pet->SetFullHealth();
    pet->FillPetInfo(&petStable.CurrentPet.emplace());
    return true;
}

bool Unit::IsTriggeredAtSpellProcEvent(Unit* victim, Aura* aura, WeaponAttackType attType, bool isVictim, bool active, SpellProcEventEntry const*& spellProcEvent, ProcEventInfo const& eventInfo)
{
    SpellInfo const* spellProto = aura->GetSpellInfo();
    SpellInfo const* procSpell = eventInfo.GetSpellInfo();

    // let the aura be handled by new proc system if it has new entry
    if (sSpellMgr->GetSpellProcEntry(spellProto->Id))
        return false;

    // Get proc Event Entry
    spellProcEvent = sSpellMgr->GetSpellProcEvent(spellProto->Id);

    // Get EventProcFlag
    uint32 EventProcFlag;
    if (spellProcEvent && spellProcEvent->procFlags) // if exist get custom spellProcEvent->procFlags
        EventProcFlag = spellProcEvent->procFlags;
    else
        EventProcFlag = spellProto->ProcFlags;       // else get from spell proto
    // Continue if no trigger exist
    if (!EventProcFlag)
        return false;

    // Additional checks for triggered spells (ignore trap casts)
    //if (procExtra & PROC_EX_INTERNAL_TRIGGERED && !(procFlag & PROC_FLAG_DONE_TRAP_ACTIVATION))
    //{
    //    if (!spellProto->HasAttribute(SPELL_ATTR3_CAN_PROC_TRIGGERED))
    //        return false;
    //}

    // Xinef: additional check for player auras - only player spells can trigger player proc auras
    // Xinef: skip victim auras
    // Excluded player shoot spells
    // Excluded player item spells
    if (!isVictim && IsPlayer() && !(EventProcFlag & (PROC_FLAG_KILL | PROC_FLAG_DEATH)))
    {
        if (procSpell && procSpell->SpellFamilyName == SPELLFAMILY_GENERIC && procSpell->GetCategory() != 76 &&
            (!eventInfo.GetProcSpell() || !eventInfo.GetProcSpell()->m_CastItem) &&
            (!eventInfo.GetTriggerAuraSpell() || eventInfo.GetTriggerAuraSpell()->SpellFamilyName == SPELLFAMILY_GENERIC))
        {
            return false;
        }
    }

    // Check spellProcEvent data requirements
    if (!sSpellMgr->IsSpellProcEventCanTriggeredBy(spellProto, spellProcEvent, EventProcFlag, eventInfo, active))
        return false;
    // In most cases req get honor or XP from kill
    if (EventProcFlag & PROC_FLAG_KILL && GetTypeId() == TYPEID_PLAYER)
    {
        bool allow = false;

        if (victim)
            allow = ToPlayer()->isHonorOrXPTarget(victim);

        // Shadow Word: Death - can trigger from every kill
        if (aura->GetId() == 32409 || aura->GetId() == 18372 || aura->GetId() == 18213)
            allow = true;
        if (!allow)
            return false;
    }
    // Aura added by spell can`t trigger from self (prevent drop charges/do triggers)
    // But except periodic and kill triggers (can triggered from self)
    if (procSpell && procSpell->Id == spellProto->Id
            && !(spellProto->ProcFlags & (PROC_FLAG_TAKEN_PERIODIC | PROC_FLAG_KILL)))
        return false;

    // Check if current equipment allows aura to proc
    if (!isVictim && GetTypeId() == TYPEID_PLAYER && !spellProto->HasAttribute(SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT))
    {
        Player* player = ToPlayer();
        if (spellProto->EquippedItemClass == ITEM_CLASS_WEAPON)
        {
            Item* item = nullptr;
            if (attType == BASE_ATTACK)
                item = player->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
            else if (attType == OFF_ATTACK)
                item = player->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
            else
                item = player->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED);

            if (player->IsInFeralForm())
                return false;

            if (!item || item->IsBroken() || item->GetTemplate()->Class != ITEM_CLASS_WEAPON || !((1 << item->GetTemplate()->SubClass) & spellProto->EquippedItemSubClassMask))
                return false;
        }
        else if (spellProto->EquippedItemClass == ITEM_CLASS_ARMOR)
        {
            // Check if player is wearing shield
            Item* item = player->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
            if (!item || item->IsBroken() || item->GetTemplate()->Class != ITEM_CLASS_ARMOR || !((1 << item->GetTemplate()->SubClass) & spellProto->EquippedItemSubClassMask))
                return false;
        }
    }
    // Get chance from spell
    float chance = float(spellProto->ProcChance);
    // If in spellProcEvent exist custom chance, chance = spellProcEvent->customChance;
    if (spellProcEvent && spellProcEvent->customChance)
        chance = spellProcEvent->customChance;
    // If PPM exist calculate chance from PPM
    if (spellProcEvent && spellProcEvent->ppmRate != 0)
    {
        if (!isVictim)
        {
            uint32 WeaponSpeed = GetAttackTime(attType);
            chance = GetPPMProcChance(WeaponSpeed, spellProcEvent->ppmRate, spellProto);
        }
        else if (victim)
        {
            uint32 WeaponSpeed = victim->GetAttackTime(attType);
            chance = victim->GetPPMProcChance(WeaponSpeed, spellProcEvent->ppmRate, spellProto);
        }
    }

    // Custom chances
    switch (spellProto->SpellFamilyName)
    {
        case SPELLFAMILY_WARRIOR:
            {
                // Recklessness, allow to proc only once for whirlwind
                if (spellProto->Id == 1719 && procSpell && procSpell->Id == 44949)
                    return false;
            }
    }

    if (eventInfo.GetProcChance())
    {
        chance = *eventInfo.GetProcChance();
    }

    // Apply chance modifer aura
    if (Player* modOwner = GetSpellModOwner())
    {
        modOwner->ApplySpellMod(spellProto->Id, SPELLMOD_CHANCE_OF_SUCCESS, chance);
    }

    return roll_chance_f(chance);
}

bool Unit::HandleAuraRaidProcFromChargeWithValue(AuraEffect* triggeredByAura)
{
    // aura can be deleted at casts
    SpellInfo const* spellProto = triggeredByAura->GetSpellInfo();
    int32 heal = triggeredByAura->GetAmount();
    ObjectGuid caster_guid = triggeredByAura->GetCasterGUID();

    // Currently only Prayer of Mending
    if (!(spellProto->SpellFamilyName == SPELLFAMILY_PRIEST && spellProto->SpellFamilyFlags[1] & 0x20))
    {
        LOG_DEBUG("spells.aura", "Unit::HandleAuraRaidProcFromChargeWithValue, received not handled spell: {}", spellProto->Id);
        return false;
    }

    // jumps
    int32 jumps = triggeredByAura->GetBase()->GetCharges() - 1;

    // current aura expire
    triggeredByAura->GetBase()->SetCharges(1);             // will removed at next charges decrease

    // next target selection
    if (jumps > 0)
    {
        if (Unit* caster = triggeredByAura->GetCaster())
        {
            // smart healing
            float radius = triggeredByAura->GetSpellInfo()->Effects[triggeredByAura->GetEffIndex()].CalcRadius(caster);
            std::list<Unit*> nearMembers;

            Player* player = nullptr;
            if (GetTypeId() == TYPEID_PLAYER)
                player = ToPlayer();
            else if (GetOwner())
                player = GetOwner()->ToPlayer();

            if (player)
            {
                Group* group = player->GetGroup();
                if (!group)
                {
                    if (player != this)
                    {
                        if (IsWithinDistInMap(player, radius))
                            nearMembers.push_back(player);
                    }
                    else if (Unit* pet = GetGuardianPet())
                    {
                        if (IsWithinDistInMap(pet, radius))
                            nearMembers.push_back(pet);
                    }
                }
                else
                {
                    for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                        if (Player* Target = itr->GetSource())
                        {
                            if (Target != this && !IsWithinDistInMap(Target, radius))
                                continue;

                            // IsHostileTo check duel and controlled by enemy
                            if (Target != this && Target->IsAlive() && !IsHostileTo(Target))
                                nearMembers.push_back(Target);

                            // Push player's pet to vector
                            if (Unit* pet = Target->GetGuardianPet())
                                if (pet != this && pet->IsAlive() && IsWithinDistInMap(pet, radius) && !IsHostileTo(pet))
                                    nearMembers.push_back(pet);
                        }
                }

                if (!nearMembers.empty())
                {
                    nearMembers.sort(Acore::HealthPctOrderPred());
                    if (Unit* target = nearMembers.front())
                    {
                        CastSpell(target, 41637 /*Dummy visual effect triggered by main spell cast*/, true);
                        CastCustomSpell(target, spellProto->Id, &heal, nullptr, nullptr, true, nullptr, triggeredByAura, caster_guid);
                        if (Aura* aura = target->GetAura(spellProto->Id, caster->GetGUID()))
                            aura->SetCharges(jumps);
                    }
                }
            }
        }
    }

    // heal
    CastCustomSpell(this, 33110, &heal, nullptr, nullptr, true, nullptr, nullptr, caster_guid);
    return true;
}
bool Unit::HandleAuraRaidProcFromCharge(AuraEffect* triggeredByAura)
{
    // aura can be deleted at casts
    SpellInfo const* spellProto = triggeredByAura->GetSpellInfo();

    uint32 damageSpellId;
    switch (spellProto->Id)
    {
        case 57949:            // shiver
            damageSpellId = 57952;
            //animationSpellId = 57951; dummy effects for jump spell have unknown use (see also 41637)
            break;
        case 59978:            // shiver
            damageSpellId = 59979;
            break;
        case 43593:            // Cold Stare
            damageSpellId = 43594;
            break;
        default:
            LOG_ERROR("entities.unit", "Unit::HandleAuraRaidProcFromCharge, received unhandled spell: {}", spellProto->Id);
            return false;
    }

    ObjectGuid caster_guid = triggeredByAura->GetCasterGUID();

    // jumps
    int32 jumps = triggeredByAura->GetBase()->GetCharges() - 1;

    // current aura expire
    triggeredByAura->GetBase()->SetCharges(1);             // will removed at next charges decrease

    // next target selection
    if (jumps > 0)
    {
        if (Unit* caster = triggeredByAura->GetCaster())
        {
            float radius = triggeredByAura->GetSpellInfo()->Effects[triggeredByAura->GetEffIndex()].CalcRadius(caster);
            if (Unit* target = GetNextRandomRaidMemberOrPet(radius))
            {
                CastSpell(target, spellProto, true, nullptr, triggeredByAura, caster_guid);
                if (Aura* aura = target->GetAura(spellProto->Id, caster->GetGUID()))
                    aura->SetCharges(jumps);
            }
        }
    }

    CastSpell(this, damageSpellId, true, nullptr, triggeredByAura, caster_guid);

    return true;
}

void Unit::Kill(Unit* killer, Unit* victim, bool durabilityLoss, WeaponAttackType attackType, SpellInfo const* spellProto, Spell const* spell /*= nullptr*/)
{
    // Prevent killing unit twice (and giving reward from kill twice)
    if (!victim->GetHealth())
        return;

    if (killer && !killer->IsInMap(victim))
        killer = nullptr;

    // find player: owner of controlled `this` or `this` itself maybe
    Player* player = killer ? killer->GetCharmerOrOwnerPlayerOrPlayerItself() : nullptr;
    Creature* creature = victim->ToCreature();

    bool isRewardAllowed = true;
    if (creature)
    {
        isRewardAllowed = creature->IsDamageEnoughForLootingAndReward();
        if (!isRewardAllowed)
            creature->SetLootRecipient(nullptr);
    }

    // pussywizard: remade this if section (player is on the same map
    if (isRewardAllowed && creature)
    {
        Player* lr = creature->GetLootRecipient();
        if (lr && lr->IsInMap(creature))
            player = creature->GetLootRecipient();
        else if (Group* lrg = creature->GetLootRecipientGroup())
            for (GroupReference* itr = lrg->GetFirstMember(); itr != nullptr; itr = itr->next())
                if (Player* member = itr->GetSource())
                    if (member->IsAtLootRewardDistance(creature))
                    {
                        player = member;
                        break;
                    }
    }

    // Exploit fix
    if (creature && creature->IsPet() && creature->GetOwnerGUID().IsPlayer())
        isRewardAllowed = false;

    // Reward player, his pets, and group/raid members
    // call kill spell proc event (before real die and combat stop to triggering auras removed at death/combat stop)
    if (isRewardAllowed && player && player != victim)
    {
        WorldPacket data(SMSG_PARTYKILLLOG, (8 + 8)); // send event PARTY_KILL
        data << player->GetGUID(); // player with killing blow
        data << victim->GetGUID(); // victim

        Player* looter = player;
        Group* group = player->GetGroup();
        bool hasLooterGuid = false;

        if (group)
        {
            group->BroadcastPacket(&data, group->GetMemberGroup(player->GetGUID()));

            if (creature)
            {
                group->UpdateLooterGuid(creature, true);
                if (group->GetLooterGuid() && group->GetLootMethod() != FREE_FOR_ALL)
                {
                    looter = ObjectAccessor::FindPlayer(group->GetLooterGuid());
                    if (looter)
                    {
                        hasLooterGuid = true;
                        creature->SetLootRecipient(looter);   // update creature loot recipient to the allowed looter.
                    }
                }
            }
        }
        else
        {
            player->SendDirectMessage(&data);

            if (creature)
            {
                WorldPacket data2(SMSG_LOOT_LIST, 8 + 1 + 1);
                data2 << creature->GetGUID();
                data2 << uint8(0); // unk1
                data2 << uint8(0); // no group looter
                player->SendMessageToSet(&data2, true);
            }
        }

        // Generate loot before updating looter
        if (creature)
        {
            Loot* loot = &creature->loot;
            loot->clear();

            if (uint32 lootid = creature->GetCreatureTemplate()->lootid)
                loot->FillLoot(lootid, LootTemplates_Creature, looter, false, false, creature->GetLootMode(), creature);

            if (creature->GetLootMode())
                loot->generateMoneyLoot(creature->GetCreatureTemplate()->mingold, creature->GetCreatureTemplate()->maxgold);

            if (group)
            {
                if (hasLooterGuid)
                    group->SendLooter(creature, looter);
                else
                    group->SendLooter(creature, nullptr);

                // Update round robin looter only if the creature had loot
                if (!creature->loot.empty())
                    group->UpdateLooterGuid(creature);
            }
        }

        player->RewardPlayerAndGroupAtKill(victim, false);
    }

    // Do KILL and KILLED procs. KILL proc is called only for the unit who landed the killing blow (and its owner - for pets and totems) regardless of who tapped the victim
    if (killer && (killer->IsPet() || killer->IsTotem()))
        if (Unit* owner = killer->GetOwner())
        {
            Unit::ProcDamageAndSpell(owner, victim, PROC_FLAG_KILL, PROC_FLAG_NONE, PROC_EX_NONE, 0, attackType, spellProto, nullptr, -1, spell);
            sScriptMgr->OnCreatureKilledByPet( killer->GetCharmerOrOwnerPlayerOrPlayerItself(), victim->ToCreature());
        }

    if (killer != victim)
    {
        Unit::ProcDamageAndSpell(killer, victim, killer ? PROC_FLAG_KILL : 0, PROC_FLAG_KILLED, PROC_EX_NONE, 0, attackType, spellProto, nullptr, -1, spell);
    }

    // Proc auras on death - must be before aura/combat remove
    Unit::ProcDamageAndSpell(victim, nullptr, PROC_FLAG_DEATH, PROC_FLAG_NONE, PROC_EX_NONE, 0, attackType, spellProto, nullptr, -1, spell);

    // update get killing blow achievements, must be done before setDeathState to be able to require auras on target
    // and before Spirit of Redemption as it also removes auras
    if (killer)
        if (Player* killerPlayer = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
            killerPlayer->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, victim);

    // Spirit of Redemption
    // if talent known but not triggered (check priest class for speedup check)
    bool spiritOfRedemption = false;
    if (victim->GetTypeId() == TYPEID_PLAYER && victim->IsClass(CLASS_PRIEST, CLASS_CONTEXT_ABILITY) && !victim->ToPlayer()->HasPlayerFlag(PLAYER_FLAGS_IS_OUT_OF_BOUNDS))
    {
        if (AuraEffect* aurEff = victim->GetAuraEffectDummy(20711))
        {
            // Xinef: aura_spirit_of_redemption is triggered by 27827 shapeshift
            if (victim->HasAuraType(SPELL_AURA_SPIRIT_OF_REDEMPTION) || victim->HasAura(27827))
            {
                /*LOG_INFO("misc", "Player ({}) died with spirit of redemption. Killer (Entry: {}, Name: {}), Map: {}, x: {}, y: {}, z: {}",
                    victim->GetGUID().ToString(), killer ? killer->GetEntry() : 1, killer ? killer->GetName() : "", victim->GetMapId(), victim->GetPositionX(),
                    victim->GetPositionY(), victim->GetPositionZ());

                ACE_Stack_Trace trace(0, 50);
                LOG_INFO("misc", "TRACE: {}\n\n", trace);*/
            }
            else
            {
                // save value before aura remove
                uint32 ressSpellId = victim->GetUInt32Value(PLAYER_SELF_RES_SPELL);
                if (!ressSpellId)
                    ressSpellId = victim->ToPlayer()->GetResurrectionSpellId();

                //Remove all expected to remove at death auras (most important negative case like DoT or periodic triggers)
                victim->RemoveAllAurasOnDeath();

                // Stop attacks
                victim->CombatStop();
                victim->getHostileRefMgr().deleteReferences();

                // restore for use at real death
                victim->SetUInt32Value(PLAYER_SELF_RES_SPELL, ressSpellId);

                // FORM_SPIRITOFREDEMPTION and related auras
                victim->CastSpell(victim, 27827, true, nullptr, aurEff);
                spiritOfRedemption = true;
            }
        }
    }

    if (!spiritOfRedemption)
    {
        LOG_DEBUG("entities.unit", "SET DeathState::JustDied");
        victim->setDeathState(DeathState::JustDied);
    }

    // Inform pets (if any) when player kills target)
    // MUST come after victim->setDeathState(DeathState::JustDied); or pet next target
    // selection will get stuck on same target and break pet react state
    if (player)
    {
        Pet* pet = player->GetPet();
        if (pet && pet->IsAlive() && pet->isControlled())
            pet->AI()->KilledUnit(victim);
    }

    // 10% durability loss on death
    // clean InHateListOf
    if (Player* plrVictim = victim->ToPlayer())
    {
        // remember victim PvP death for corpse type and corpse reclaim delay
        // at original death (not at SpiritOfRedemtionTalent timeout)
        plrVictim->SetPvPDeath(player != nullptr);

        // only if not player and not controlled by player pet. And not at BG
        if ((durabilityLoss && !player && !plrVictim->InBattleground()) || (player && sWorld->getBoolConfig(CONFIG_DURABILITY_LOSS_IN_PVP)))
        {
            LOG_DEBUG("entities.unit", "We are dead, losing {} percent durability", sWorld->getRate(RATE_DURABILITY_LOSS_ON_DEATH));
            plrVictim->DurabilityLossAll(sWorld->getRate(RATE_DURABILITY_LOSS_ON_DEATH), false);
            // durability lost message
            plrVictim->SendDurabilityLoss();
        }
        // Call KilledUnit for creatures
        if (killer && killer->GetTypeId() == TYPEID_UNIT && killer->IsAIEnabled)
            killer->ToCreature()->AI()->KilledUnit(victim);

        // last damage from non duel opponent or opponent controlled creature
        if (plrVictim->duel)
        {
            plrVictim->duel->Opponent->CombatStopWithPets(true);
            plrVictim->CombatStopWithPets(true);
            plrVictim->DuelComplete(DUEL_INTERRUPTED);
        }
    }
    else                                                // creature died
    {
        LOG_DEBUG("entities.unit", "DealDamageNotPlayer");

        if (!creature->IsPet() && creature->GetLootMode() > 0)
        {
            creature->GetThreatMgr().ClearAllThreat();

            // must be after setDeathState which resets dynamic flags
            if (!creature->loot.isLooted())
            {
                creature->SetDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
            }
            else
            {
                creature->AllLootRemovedFromCorpse();
            }
        }

        // Call KilledUnit for creatures, this needs to be called after the lootable flag is set
        if (killer && killer->GetTypeId() == TYPEID_UNIT && killer->IsAIEnabled)
            killer->ToCreature()->AI()->KilledUnit(victim);

        // Call creature just died function
        if (CreatureAI* ai = creature->AI())
        {
            ai->JustDied(killer);
        }

        if (TempSummon* summon = creature->ToTempSummon())
        {
            if (WorldObject* summoner = summon->GetSummoner())
            {
                if (summoner->ToCreature() && summoner->ToCreature()->IsAIEnabled)
                {
                    summoner->ToCreature()->AI()->SummonedCreatureDies(creature, killer);
                }
                else if (summoner->ToGameObject() && summoner->ToGameObject()->AI())
                {
                    summoner->ToGameObject()->AI()->SummonedCreatureDies(creature, killer);
                }
            }
        }

        // Dungeon specific stuff, only applies to players killing creatures
        if (creature->GetInstanceId())
        {
            Map* instanceMap = creature->GetMap();
            //Player* creditedPlayer = GetCharmerOrOwnerPlayerOrPlayerItself();
            /// @todo: do instance binding anyway if the charmer/owner is offline

            if (instanceMap->IsDungeon() && player)
                if (instanceMap->IsRaidOrHeroicDungeon())
                    if (creature->GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_INSTANCE_BIND)
                        instanceMap->ToInstanceMap()->PermBindAllPlayers();
        }
    }

    // outdoor pvp things, do these after setting the death state, else the player activity notify won't work... doh...
    // handle player kill only if not suicide (spirit of redemption for example)
    if (player && killer != victim)
    {
        if (OutdoorPvP* pvp = player->GetOutdoorPvP())
            pvp->HandleKill(player, victim);

        if (Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(player->GetZoneId()))
            bf->HandleKill(player, victim);
    }

    //if (victim->GetTypeId() == TYPEID_PLAYER)
    //    if (OutdoorPvP* pvp = victim->ToPlayer()->GetOutdoorPvP())
    //        pvp->HandlePlayerActivityChangedpVictim->ToPlayer();

    // battleground things (do this at the end, so the death state flag will be properly set to handle in the bg->handlekill)
    if (player)
        if (Battleground* bg = player->GetBattleground())
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                bg->HandleKillPlayer(victim->ToPlayer(), player);
            else
                bg->HandleKillUnit(victim->ToCreature(), player);
        }

    // achievement stuff
    if (killer && victim->GetTypeId() == TYPEID_PLAYER)
    {
        if (killer->GetTypeId() == TYPEID_UNIT)
            victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_CREATURE, killer->GetEntry());
        else if (victim != killer && killer->GetTypeId() == TYPEID_PLAYER)
            victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_PLAYER, 1, killer->ToPlayer()->GetTeamId());
    }

    // Hook for OnPVPKill Event
    if (killer)
    {
        if (Player* killerPlr = killer->ToPlayer())
        {
            if (Player* killedPlr = victim->ToPlayer())
                sScriptMgr->OnPVPKill(killerPlr, killedPlr);
            else if (Creature* killedCre = victim->ToCreature())
                sScriptMgr->OnCreatureKill(killerPlr, killedCre);
        }
        else if (Creature* killerCre = killer->ToCreature())
        {
            if (Player* killed = victim->ToPlayer())
                sScriptMgr->OnPlayerKilledByCreature(killerCre, killed);
        }
    }

    sScriptMgr->OnUnitDeath(victim, killer);
}

void Unit::SetControlled(bool apply, UnitState state, Unit* source /*= nullptr*/, bool isFear /*= false*/)
{
    if (apply)
    {
        if (HasUnitState(state))
            return;

        AddUnitState(state);
        switch (state)
        {
            case UNIT_STATE_STUNNED:
                SetStunned(true);
                break;
            case UNIT_STATE_ROOT:
                if (!HasUnitState(UNIT_STATE_STUNNED))
                    SetRooted(true);
                break;
            case UNIT_STATE_CONFUSED:
                if (!HasUnitState(UNIT_STATE_STUNNED))
                {
                    ClearUnitState(UNIT_STATE_MELEE_ATTACKING);
                    SendMeleeAttackStop();
                    // SendAutoRepeatCancel ?
                    SetConfused(true);
                    CastStop(0, false);
                }
                break;
            case UNIT_STATE_FLEEING:
                if (!HasUnitState(UNIT_STATE_STUNNED | UNIT_STATE_CONFUSED))
                {
                    ClearUnitState(UNIT_STATE_MELEE_ATTACKING);
                    SendMeleeAttackStop();
                    // SendAutoRepeatCancel ?
                    SetFeared(true, source, isFear);
                    CastStop(0, false);
                }
                break;
            default:
                break;
        }

        if (GetTypeId() == TYPEID_PLAYER)
        {
            sScriptMgr->AnticheatSetRootACKUpd(ToPlayer());
        }
    }
    else
    {
        // xinef: moved from below, checked all SetX functions, no calls to currently modified state
        // xinef: added to each case because of return
        //ClearUnitState(state);

        switch (state)
        {
            case UNIT_STATE_STUNNED:
                if (HasAuraType(SPELL_AURA_MOD_STUN))
                    return;
                ClearUnitState(state);
                SetStunned(false);
                break;
            case UNIT_STATE_ROOT:
                // Prevent creature_template_movement rooted flag from being removed on aura expiration.
                if (GetTypeId() == TYPEID_UNIT)
                {
                    if (ToCreature()->GetCreatureTemplate()->Movement.Rooted)
                    {
                        return;
                    }
                }

                if (HasAuraType(SPELL_AURA_MOD_ROOT) || GetVehicle())
                    return;
                ClearUnitState(state);
                SetRooted(false);
                break;
            case UNIT_STATE_CONFUSED:
                if (HasAuraType(SPELL_AURA_MOD_CONFUSE))
                    return;
                ClearUnitState(state);
                SetConfused(false);
                break;
            case UNIT_STATE_FLEEING:
                if (HasAuraType(SPELL_AURA_MOD_FEAR))
                    return;
                ClearUnitState(state);
                SetFeared(false);
                break;
            default:
                return;
        }

        //ClearUnitState(state);

        if (HasUnitState(UNIT_STATE_STUNNED) || HasAuraType(SPELL_AURA_MOD_STUN))
            SetStunned(true);
        else
        {
            if (HasUnitState(UNIT_STATE_ROOT) || HasAuraType(SPELL_AURA_MOD_ROOT))
                SetRooted(true);

            if (HasUnitState(UNIT_STATE_CONFUSED) || HasAuraType(SPELL_AURA_MOD_CONFUSE))
                SetConfused(true);
            else if (HasUnitState(UNIT_STATE_FLEEING) || HasAuraType(SPELL_AURA_MOD_FEAR))
            {
                bool isFear = false;
                if (HasAuraType(SPELL_AURA_MOD_FEAR))
                {
                    isFear = true;
                    source = ObjectAccessor::GetUnit(*this, GetAuraEffectsByType(SPELL_AURA_MOD_FEAR).front()->GetCasterGUID());
                }

                if (!source)
                {
                    source = getAttackerForHelper();
                }

                SetFeared(true, source, isFear);
            }
        }
    }
}

void Unit::SetStunned(bool apply)
{
    if (HasUnitState(UNIT_STATE_IN_FLIGHT))
    {
        return;
    }

    if (apply)
    {
        SetTarget();
        SetUnitFlag(UNIT_FLAG_STUNNED);

        if (GetTypeId() == TYPEID_PLAYER)
        {
            SetStandState(UNIT_STAND_STATE_STAND);
        }

        SetRooted(true, true);

        CastStop();
    }
    else
    {
        if (IsAlive() && GetVictim())
            SetTarget(GetVictim()->GetGUID());

        if (GetTypeId() == TYPEID_UNIT)
        {
            // don't remove UNIT_FLAG_STUNNED for pet when owner is mounted (disabled pet's interface)
            Unit* owner = GetOwner();
            if (!owner || owner->GetTypeId() != TYPEID_PLAYER || !owner->ToPlayer()->IsMounted())
                RemoveUnitFlag(UNIT_FLAG_STUNNED);

            // Xinef: same for charmed npcs
            owner = GetCharmer();
            if (!owner || owner->GetTypeId() != TYPEID_PLAYER || !owner->ToPlayer()->IsMounted())
                RemoveUnitFlag(UNIT_FLAG_STUNNED);
        }
        else
            RemoveUnitFlag(UNIT_FLAG_STUNNED);

        if (!HasUnitState(UNIT_STATE_ROOT))         // prevent moving if it also has root effect
        {
            SetRooted(false, true);
        }
    }
}

void Unit::SetRooted(bool apply, bool isStun)
{
    if (apply)
    {
        if (m_rootTimes > 0) // blizzard internal check?
            m_rootTimes++;

        // MOVEMENTFLAG_ROOT cannot be used in conjunction with MOVEMENTFLAG_MASK_MOVING (tested 3.3.5a)
        // this will freeze clients. That's why we remove MOVEMENTFLAG_MASK_MOVING before
        // setting MOVEMENTFLAG_ROOT
        RemoveUnitMovementFlag(MOVEMENTFLAG_MASK_MOVING);

        if (IsFalling())
        {
            AddUnitMovementFlag(MOVEMENTFLAG_PENDING_ROOT);
        }
        else
        {
            AddUnitMovementFlag(MOVEMENTFLAG_ROOT);
        }

         // Creature specific
        if (GetTypeId() != TYPEID_PLAYER)
        {
            if (isStun && movespline->Finalized())
            {
                StopMovingOnCurrentPos();
            }
            else
            {
                StopMoving();
            }
        }

        if (m_movedByPlayer)
        {
            WorldPacket data(SMSG_FORCE_MOVE_ROOT, GetPackGUID().size() + 4);
            data << GetPackGUID();
            data << m_rootTimes;
            m_movedByPlayer->ToPlayer()->SendDirectMessage(&data);
        }
        else
        {
            WorldPacket data(SMSG_SPLINE_MOVE_ROOT, GetPackGUID().size());
            data << GetPackGUID();
            SendMessageToSet(&data, true);
        }
    }
    else
    {
        RemoveUnitMovementFlag(MOVEMENTFLAG_ROOT | MOVEMENTFLAG_PENDING_ROOT);

        if (!HasUnitState(UNIT_STATE_STUNNED))      // prevent moving if it also has stun effect
        {
            if (m_movedByPlayer)
            {
                WorldPacket data(SMSG_FORCE_MOVE_UNROOT, GetPackGUID().size() + 4);
                data << GetPackGUID();
                data << m_rootTimes;
                m_movedByPlayer->ToPlayer()->SendDirectMessage(&data);
            }
            else
            {
                WorldPacket data(SMSG_SPLINE_MOVE_UNROOT, GetPackGUID().size());
                data << GetPackGUID();
                SendMessageToSet(&data, true);
            }
        }
    }
}

void Unit::DisableRotate(bool apply)
{
    if (GetTypeId() != TYPEID_UNIT)
        return;

    if (apply)
        SetUnitFlag(UNIT_FLAG_POSSESSED);
    else if (!HasUnitState(UNIT_STATE_POSSESSED))
        RemoveUnitFlag(UNIT_FLAG_POSSESSED);
}

void Unit::SetFeared(bool apply, Unit* fearedBy /*= nullptr*/, bool isFear /*= false*/)
{
    if (apply)
    {
        SetTarget();
        GetMotionMaster()->MoveFleeing(fearedBy, isFear ? 0 : sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_FLEE_DELAY));
    }
    else
    {
        if (IsAlive())
        {
            if (GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == FLEEING_MOTION_TYPE)
            {
                GetMotionMaster()->MovementExpired();
                StopMoving();
            }

            if (GetVictim())
                SetTarget(GetVictim()->GetGUID());
        }
    }

    // xinef: block / allow control to real mover (eg. charmer)
    if (GetTypeId() == TYPEID_PLAYER)
    {
        if (m_movedByPlayer)
            m_movedByPlayer->ToPlayer()->SetClientControl(this, !apply); // verified
        //else
        //  ToPlayer()->SetClientControl(this, !apply);
    }
}

void Unit::SetConfused(bool apply)
{
    if (apply)
    {
        SetTarget();
        GetMotionMaster()->MoveConfused();
    }
    else
    {
        if (IsAlive())
        {
            if (GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == CONFUSED_MOTION_TYPE)
            {
                GetMotionMaster()->MovementExpired();
                StopMoving();
            }

            if (GetVictim())
                SetTarget(GetVictim()->GetGUID());
        }
    }

    // xinef: block / allow control to real mover (eg. charmer)
    if (GetTypeId() == TYPEID_PLAYER)
    {
        if (m_movedByPlayer)
            m_movedByPlayer->ToPlayer()->SetClientControl(this, !apply); // verified
        //else
        //  ToPlayer()->SetClientControl(this, !apply);
    }
}

bool Unit::SetCharmedBy(Unit* charmer, CharmType type, AuraApplication const* aurApp)
{
    if (!charmer)
        return false;

    if (!charmer->IsInWorld() || charmer->IsDuringRemoveFromWorld())
    {
        return false;
    }

    // dismount players when charmed
    if (GetTypeId() == TYPEID_PLAYER)
        RemoveAurasByType(SPELL_AURA_MOUNTED);

    if (charmer->GetTypeId() == TYPEID_PLAYER)
        charmer->RemoveAurasByType(SPELL_AURA_MOUNTED);

    ASSERT(type != CHARM_TYPE_POSSESS || charmer->GetTypeId() == TYPEID_PLAYER);
    if (type == CHARM_TYPE_VEHICLE && !IsVehicle()) // pussywizard
        throw 1;
    ASSERT((type == CHARM_TYPE_VEHICLE) == IsVehicle());

    LOG_DEBUG("entities.unit", "SetCharmedBy: charmer {} ({}), charmed {} ({}), type {}.",
        charmer->GetEntry(), charmer->GetGUID().ToString(), GetEntry(), GetGUID().ToString(), uint32(type));

    if (this == charmer)
    {
        LOG_FATAL("entities.unit", "Unit::SetCharmedBy: Unit {} ({}) is trying to charm itself!", GetEntry(), GetGUID().ToString());
        return false;
    }

    //if (HasUnitState(UNIT_STATE_UNATTACKABLE))
    //    return false;

    if (GetTypeId() == TYPEID_PLAYER && ToPlayer()->GetTransport())
    {
        LOG_FATAL("entities.unit", "Unit::SetCharmedBy: Player on transport is trying to charm {} ({})", GetEntry(), GetGUID().ToString());
        return false;
    }

    // Already charmed
    if (GetCharmerGUID())
    {
        LOG_FATAL("entities.unit", "Unit::SetCharmedBy: {} ({}) has already been charmed but {} ({}) is trying to charm it!",
            GetEntry(), GetGUID().ToString(), charmer->GetEntry(), charmer->GetGUID().ToString());
        return false;
    }

    CastStop();
    AttackStop();

    // Xinef: dont reset threat and combat, put them on offline list, moved down after faction changes
    //  CombatStop(); /// @todo: CombatStop(true) may cause crash (interrupt spells)
    //  DeleteThreatList();

    Player* playerCharmer = charmer->ToPlayer();

    // Charmer stop charming
    if (playerCharmer)
    {
        playerCharmer->StopCastingCharm(aurApp ? aurApp->GetBase() : nullptr);
        playerCharmer->StopCastingBindSight(aurApp ? aurApp->GetBase() : nullptr);
    }

    // Charmed stop charming
    if (GetTypeId() == TYPEID_PLAYER)
    {
        ToPlayer()->StopCastingCharm(aurApp ? aurApp->GetBase() : nullptr);
        ToPlayer()->StopCastingBindSight(aurApp ? aurApp->GetBase() : nullptr);
    }

    // StopCastingCharm may remove a possessed pet?
    if (!IsInWorld())
    {
        LOG_FATAL("entities.unit", "Unit::SetCharmedBy: {} ({}) is not in world but {} ({}) is trying to charm it!",
            GetEntry(), GetGUID().ToString(), charmer->GetEntry(), charmer->GetGUID().ToString());
        return false;
    }

    // charm is set by aura, and aura effect remove handler was called during apply handler execution
    // prevent undefined behaviour
    if (aurApp && aurApp->GetRemoveMode())
        return false;

    _oldFactionId = GetFaction();
    SetFaction(charmer->GetFaction());

    // Set charmed
    charmer->SetCharm(this, true);

    StopAttackingInvalidTarget();

    if (GetTypeId() == TYPEID_UNIT)
    {
        GetMotionMaster()->Clear(false);
        GetMotionMaster()->MoveIdle();
        StopMoving();

        if (charmer->GetTypeId() == TYPEID_PLAYER && charmer->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET_CHARM) && ToCreature()->GetCreatureTemplate()->type == CREATURE_TYPE_DEMON)
        {
            // Disable CreatureAI/SmartAI and switch to CharmAI when charmed by warlock
            Creature* charmed = ToCreature();
            charmed->NeedChangeAI = true;
            charmed->IsAIEnabled = false;
        }
        else
        {
            ToCreature()->AI()->OnCharmed(true);
        }

        // Xinef: If creature can fly, add normal player flying flag (fixes speed)
        if (charmer->GetTypeId() == TYPEID_PLAYER && ToCreature()->CanFly())
            AddUnitMovementFlag(MOVEMENTFLAG_FLYING);
    }
    else
    {
        Player* player = ToPlayer();
        if (player->isAFK())
            player->ToggleAFK();

        player->SetClientControl(this, false); // verified
    }

    // charm is set by aura, and aura effect remove handler was called during apply handler execution
    // prevent undefined behaviour
    if (aurApp && aurApp->GetRemoveMode())
        return false;

    // Pets already have a properly initialized CharmInfo, don't overwrite it.
    // Xinef: I need charmInfo for vehicle
    if (/*type != CHARM_TYPE_VEHICLE &&*/ !GetCharmInfo())
    {
        InitCharmInfo();
        if (type == CHARM_TYPE_POSSESS)
            GetCharmInfo()->InitPossessCreateSpells();
        else if (type != CHARM_TYPE_VEHICLE)
        {
            GetCharmInfo()->InitCharmCreateSpells();

            // Xinef: convert charm npcs dont have pet bar so initialize them as defensive helpers
            if (type == CHARM_TYPE_CONVERT && GetTypeId() == TYPEID_UNIT)
                ToCreature()->SetReactState(REACT_DEFENSIVE);
        }
    }

    if (playerCharmer)
    {
        switch (type)
        {
            case CHARM_TYPE_VEHICLE:
                SetUnitFlag(UNIT_FLAG_POSSESSED);
                AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                playerCharmer->SetClientControl(this, true); // verified
                playerCharmer->VehicleSpellInitialize();
                break;
            case CHARM_TYPE_POSSESS:
                AddUnitState(UNIT_STATE_POSSESSED);
                AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                SetUnitFlag(UNIT_FLAG_POSSESSED);
                charmer->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                playerCharmer->SetClientControl(this, true); // verified
                playerCharmer->PossessSpellInitialize();
                break;
            case CHARM_TYPE_CHARM:
                if (GetTypeId() == TYPEID_UNIT && charmer->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET_CHARM))
                {
                    CreatureTemplate const* cinfo = ToCreature()->GetCreatureTemplate();
                    if (cinfo && cinfo->type == CREATURE_TYPE_DEMON)
                    {
                        // to prevent client crash
                        SetByteValue(UNIT_FIELD_BYTES_0, 1, (uint8)CLASS_MAGE);

                        // just to enable stat window
                        if (GetCharmInfo())
                            GetCharmInfo()->SetPetNumber(sObjectMgr->GeneratePetNumber(), true);

                        // if charmed two demons the same session, the 2nd gets the 1st one's name
                        SetUInt32Value(UNIT_FIELD_PET_NAME_TIMESTAMP, uint32(GameTime::GetGameTime().count())); // cast can't be helped
                    }
                }
                if (playerCharmer->m_seer != this)
                {
                    GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST, GetFollowAngle());
                    playerCharmer->CharmSpellInitialize();
                }
                break;
            default:
                break;
        }
    }
    else if (GetTypeId() == TYPEID_PLAYER)
        RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

    if (Creature* creature = ToCreature())
        creature->RefreshSwimmingFlag();

    if (GetTypeId() == TYPEID_PLAYER)
        sScriptMgr->OnPlayerBeingCharmed(ToPlayer(), charmer, _oldFactionId, charmer->GetFaction());

    return true;
}

void Unit::RemoveCharmedBy(Unit* charmer)
{
    if (!IsCharmed())
        return;

    if (!charmer)
        charmer = GetCharmer();
    if (charmer != GetCharmer()) // one aura overrides another?
    {
        //        LOG_FATAL("entities.unit", "Unit::RemoveCharmedBy: this: {} true charmer: {} false charmer: {}",
        //            GetGUID().ToString(), GetCharmerGUID().ToString(), charmer->GetGUID().ToString());
        //        ABORT();
        return;
    }

    CharmType type;
    if (HasUnitState(UNIT_STATE_POSSESSED))
        type = CHARM_TYPE_POSSESS;
    else if (charmer && charmer->IsOnVehicle(this))
        type = CHARM_TYPE_VEHICLE;
    else
        type = CHARM_TYPE_CHARM;

    if (_oldFactionId)
    {
        SetFaction(_oldFactionId);
        _oldFactionId = 0;
    }
    else
        RestoreFaction();

    CastStop();
    AttackStop();

    // xinef: update speed after charming
    UpdateSpeed(MOVE_RUN, false);

    // xinef: do not break any controlled motion slot
    if (GetMotionMaster()->GetMotionSlotType(MOTION_SLOT_CONTROLLED) == NULL_MOTION_TYPE)
    {
        StopMoving();
        GetMotionMaster()->MovementExpired();
    }
    // xinef: if we have any controlled movement, clear active and idle only
    else
        GetMotionMaster()->MovementExpiredOnSlot(MOTION_SLOT_ACTIVE, false);

    GetMotionMaster()->InitDefault();

    // xinef: remove stunned flag if owner was mounted
    if (GetTypeId() == TYPEID_UNIT && !HasUnitState(UNIT_STATE_STUNNED))
        RemoveUnitFlag(UNIT_FLAG_STUNNED);

    // If charmer still exists
    if (!charmer)
        return;

    ASSERT(type != CHARM_TYPE_POSSESS || charmer->GetTypeId() == TYPEID_PLAYER);
    ASSERT(type != CHARM_TYPE_VEHICLE || (GetTypeId() == TYPEID_UNIT && IsVehicle()));

    charmer->SetCharm(this, false);

    StopAttackingInvalidTarget();

    Player* playerCharmer = charmer->ToPlayer();
    if (playerCharmer)
    {
        switch (type)
        {
            case CHARM_TYPE_VEHICLE:
                playerCharmer->SetClientControl(this, false);
                playerCharmer->SetClientControl(charmer, true); // verified
                RemoveUnitFlag(UNIT_FLAG_POSSESSED);
                ClearUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                break;
            case CHARM_TYPE_POSSESS:
                playerCharmer->SetClientControl(this, false);
                playerCharmer->SetClientControl(charmer, true); // verified
                charmer->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                RemoveUnitFlag(UNIT_FLAG_POSSESSED);
                ClearUnitState(UNIT_STATE_POSSESSED);
                ClearUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                break;
            case CHARM_TYPE_CHARM:
                if (GetTypeId() == TYPEID_UNIT && charmer->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET_CHARM))
                {
                    CreatureTemplate const* cinfo = ToCreature()->GetCreatureTemplate();
                    if (cinfo && cinfo->type == CREATURE_TYPE_DEMON)
                    {
                        SetByteValue(UNIT_FIELD_BYTES_0, 1, uint8(cinfo->unit_class));
                        if (GetCharmInfo())
                            GetCharmInfo()->SetPetNumber(0, true);
                        else
                            LOG_ERROR("entities.unit", "Aura::HandleModCharm: target={} has a charm aura but no charm info!", GetGUID().ToString());
                    }
                }
                break;
            default:
                break;
        }
    }

    if (Player* player = ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(player);
    }

    // xinef: restore threat
    for (CharmThreatMap::const_iterator itr = _charmThreatInfo.begin(); itr != _charmThreatInfo.end(); ++itr)
    {
        if (Unit* target = ObjectAccessor::GetUnit(*this, itr->first))
            if (!IsFriendlyTo(target))
                AddThreat(target, itr->second);
    }

    _charmThreatInfo.clear();

    if (Creature* creature = ToCreature())
    {
        // Vehicle should not attack its passenger after he exists the seat
        if (type != CHARM_TYPE_VEHICLE && charmer->IsAlive() && !charmer->IsFriendlyTo(creature))
            if (Attack(charmer, true))
                GetMotionMaster()->MoveChase(charmer);

        // Creature will restore its old AI on next update
        if (creature->AI())
            creature->AI()->OnCharmed(false);

        // Xinef: Remove movement flag flying
        RemoveUnitMovementFlag(MOVEMENTFLAG_FLYING);
    }
    else
        ToPlayer()->SetClientControl(this, true); // verified

    // a guardian should always have charminfo
    if (playerCharmer && this != charmer->GetFirstControlled())
        playerCharmer->SendRemoveControlBar();

    // xinef: Always delete charm info (restores react state)
    if (GetTypeId() == TYPEID_PLAYER || (GetTypeId() == TYPEID_UNIT && !ToCreature()->IsGuardian()))
        DeleteCharmInfo();
}

void Unit::RestoreFaction()
{
    if (GetTypeId() == TYPEID_PLAYER)
        ToPlayer()->SetFactionForRace(getRace());
    else
    {
        if (HasUnitTypeMask(UNIT_MASK_MINION))
        {
            if (Unit* owner = GetOwner())
            {
                SetFaction(owner->GetFaction());
                return;
            }
        }

        if (CreatureTemplate const* cinfo = ToCreature()->GetCreatureTemplate())  // normal creature
            SetFaction(cinfo->faction);
    }
}

bool Unit::CreateVehicleKit(uint32 id, uint32 creatureEntry)
{
    VehicleEntry const* vehInfo = sVehicleStore.LookupEntry(id);
    if (!vehInfo)
        return false;

    m_vehicleKit = new Vehicle(this, vehInfo, creatureEntry);
    m_updateFlag |= UPDATEFLAG_VEHICLE;
    m_unitTypeMask |= UNIT_MASK_VEHICLE;
    return true;
}

void Unit::RemoveVehicleKit()
{
    if (!m_vehicleKit)
        return;

    m_vehicleKit->Uninstall();
    delete m_vehicleKit;

    m_vehicleKit = nullptr;

    m_updateFlag &= ~UPDATEFLAG_VEHICLE;
    m_unitTypeMask &= ~UNIT_MASK_VEHICLE;
    RemoveNpcFlag(UNIT_NPC_FLAG_SPELLCLICK | UNIT_NPC_FLAG_PLAYER_VEHICLE);
}

Unit* Unit::GetVehicleBase() const
{
    return m_vehicle ? m_vehicle->GetBase() : nullptr;
}

Creature* Unit::GetVehicleCreatureBase() const
{
    if (Unit* veh = GetVehicleBase())
        if (Creature* c = veh->ToCreature())
            return c;

    return nullptr;
}

ObjectGuid Unit::GetTransGUID() const
{
    if (GetVehicle())
        return GetVehicleBase()->GetGUID();

    if (GetTransport())
        return GetTransport()->GetGUID();

    return ObjectGuid::Empty;
}

TransportBase* Unit::GetDirectTransport() const
{
    if (Vehicle* veh = GetVehicle())
        return veh;
    return GetTransport();
}

bool Unit::IsInPartyWith(Unit const* unit) const
{
    if (this == unit)
        return true;

    Unit const* u1 = GetCharmerOrOwnerOrSelf();
    Unit const* u2 = unit->GetCharmerOrOwnerOrSelf();
    if (u1 == u2)
        return true;

    if (u1->GetTypeId() == TYPEID_PLAYER && u2->GetTypeId() == TYPEID_PLAYER)
        return u1->ToPlayer()->IsInSameGroupWith(u2->ToPlayer());
    // Xinef: we assume that npcs with the same faction are in party
    else if (u1->GetTypeId() == TYPEID_UNIT && u2->GetTypeId() == TYPEID_UNIT && !u1->IsControlledByPlayer() && !u2->IsControlledByPlayer())
        return u1->GetFaction() == u2->GetFaction();
    // Xinef: creature type_flag should work for party check only if player group is not a raid
    else if ((u2->GetTypeId() == TYPEID_PLAYER && u1->GetTypeId() == TYPEID_UNIT && (u1->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT) && u2->ToPlayer()->GetGroup() && !u2->ToPlayer()->GetGroup()->isRaidGroup()) ||
             (u1->GetTypeId() == TYPEID_PLAYER && u2->GetTypeId() == TYPEID_UNIT && (u2->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT) && u1->ToPlayer()->GetGroup() && !u1->ToPlayer()->GetGroup()->isRaidGroup()))
        return true;
    else
        return false;
}

bool Unit::IsInRaidWith(Unit const* unit) const
{
    if (this == unit)
        return true;

    Unit const* u1 = GetCharmerOrOwnerOrSelf();
    Unit const* u2 = unit->GetCharmerOrOwnerOrSelf();
    if (u1 == u2)
        return true;

    if (u1->GetTypeId() == TYPEID_PLAYER && u2->GetTypeId() == TYPEID_PLAYER)
        return u1->ToPlayer()->IsInSameRaidWith(u2->ToPlayer());
    // Xinef: we assume that npcs with the same faction are in party
    else if (u1->GetTypeId() == TYPEID_UNIT && u2->GetTypeId() == TYPEID_UNIT && !u1->IsControlledByPlayer() && !u2->IsControlledByPlayer())
        return u1->GetFaction() == u2->GetFaction();
    else if ((u2->GetTypeId() == TYPEID_PLAYER && u1->GetTypeId() == TYPEID_UNIT && u1->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT) ||
             (u1->GetTypeId() == TYPEID_PLAYER && u2->GetTypeId() == TYPEID_UNIT && u2->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT))
        return true;
    else
        return false;
}

void Unit::GetPartyMembers(std::list<Unit*>& TagUnitMap)
{
    Unit* owner = GetCharmerOrOwnerOrSelf();
    Group* group = nullptr;
    if (owner->GetTypeId() == TYPEID_PLAYER)
        group = owner->ToPlayer()->GetGroup();

    if (group)
    {
        uint8 subgroup = owner->ToPlayer()->GetSubGroup();

        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* Target = itr->GetSource();

            // IsHostileTo check duel and controlled by enemy
            if (Target && Target->IsInMap(owner) && Target->GetSubGroup() == subgroup && !IsHostileTo(Target))
            {
                if (Target->IsAlive())
                    TagUnitMap.push_back(Target);

                for (Unit::ControlSet::iterator iterator = Target->m_Controlled.begin(); iterator != Target->m_Controlled.end(); ++iterator)
                {
                    if (Unit* pet = *iterator)
                        if (pet->IsGuardian() && pet->IsAlive())
                            TagUnitMap.push_back(pet);
                }
            }
        }
    }
    else
    {
        if (owner->IsAlive())
            TagUnitMap.push_back(owner);

        for (Unit::ControlSet::iterator itr = owner->m_Controlled.begin(); itr != owner->m_Controlled.end(); ++itr)
        {
            if (Unit* pet = *itr)
                if (pet->IsGuardian() && pet->IsAlive())
                    TagUnitMap.push_back(pet);
        }
    }
}

Aura* Unit::AddAura(uint32 spellId, Unit* target)
{
    if (!target)
        return nullptr;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    if (!spellInfo)
        return nullptr;

    if (!target->IsAlive() && !spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE) && !spellInfo->HasAttribute(SPELL_ATTR2_ALLOW_DEAD_TARGET))
        return nullptr;

    return AddAura(spellInfo, MAX_EFFECT_MASK, target);
}

Aura* Unit::AddAura(SpellInfo const* spellInfo, uint8 effMask, Unit* target)
{
    if (!spellInfo)
        return nullptr;

    if (target->IsImmunedToSpell(spellInfo))
        return nullptr;

    for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (!(effMask & (1 << i)))
            continue;
        if (target->IsImmunedToSpellEffect(spellInfo, i))
            effMask &= ~(1 << i);
    }

    if (Aura* aura = Aura::TryRefreshStackOrCreate(spellInfo, effMask, target, this))
    {
        aura->ApplyForTargets();
        return aura;
    }
    return nullptr;
}

void Unit::SetAuraStack(uint32 spellId, Unit* target, uint32 stack)
{
    Aura* aura = target->GetAura(spellId, GetGUID());
    if (!aura)
        aura = AddAura(spellId, target);
    if (aura && stack)
        aura->SetStackAmount(stack);
}

void Unit::SendPlaySpellVisual(uint32 id)
{
    WorldPacket data(SMSG_PLAY_SPELL_VISUAL, 8 + 4);
    data << GetGUID();
    data << uint32(id); // SpellVisualKit.dbc index
    SendMessageToSet(&data, true);
}

void Unit::SendPlaySpellImpact(ObjectGuid guid, uint32 id)
{
    WorldPacket data(SMSG_PLAY_SPELL_IMPACT, 8 + 4);
    data << guid;       // target
    data << uint32(id); // SpellVisualKit.dbc index
    SendMessageToSet(&data, true);
}

void Unit::ApplyResilience(Unit const* victim, float* crit, int32* damage, bool isCrit, CombatRating type)
{
    // player mounted on multi-passenger mount is also classified as vehicle
    if (victim->IsVehicle() && victim->GetTypeId() != TYPEID_PLAYER)
        return;

    Unit const* target = nullptr;
    if (victim->GetTypeId() == TYPEID_PLAYER)
        target = victim;
    else if (victim->GetTypeId() == TYPEID_UNIT)
    {
        if (Unit* owner = victim->GetOwner())
            if (owner->GetTypeId() == TYPEID_PLAYER)
                target = owner;
    }

    if (!target)
        return;

    switch (type)
    {
        case CR_CRIT_TAKEN_MELEE:
            // Crit chance reduction works against nonpets
            if (crit)
                *crit -= target->GetMeleeCritChanceReduction();
            if (damage)
            {
                if (isCrit)
                    *damage -= target->GetMeleeCritDamageReduction(*damage);
                *damage -= target->GetMeleeDamageReduction(*damage);
            }
            break;
        case CR_CRIT_TAKEN_RANGED:
            // Crit chance reduction works against nonpets
            if (crit)
                *crit -= target->GetRangedCritChanceReduction();
            if (damage)
            {
                if (isCrit)
                    *damage -= target->GetRangedCritDamageReduction(*damage);
                *damage -= target->GetRangedDamageReduction(*damage);
            }
            break;
        case CR_CRIT_TAKEN_SPELL:
            // Crit chance reduction works against nonpets
            if (crit)
                *crit -= target->GetSpellCritChanceReduction();
            if (damage)
            {
                if (isCrit)
                    *damage -= target->GetSpellCritDamageReduction(*damage);
                *damage -= target->GetSpellDamageReduction(*damage);
            }
            break;
        default:
            break;
    }
}

// Melee based spells can be miss, parry or dodge on this step
// Crit or block - determined on damage calculation phase! (and can be both in some time)
float Unit::MeleeSpellMissChance(Unit const* victim, WeaponAttackType attType, int32 skillDiff, uint32 spellId) const
{
    SpellInfo const* spellInfo = spellId ? sSpellMgr->GetSpellInfo(spellId) : nullptr;
    if (spellInfo && spellInfo->HasAttribute(SPELL_ATTR7_NO_ATTACK_MISS))
    {
        return 0.0f;
    }

    //calculate miss chance
    float missChance = victim->GetUnitMissChance(attType);

    // Check if dual wielding, add additional miss penalty - when mainhand has on next swing spell, offhand doesnt suffer penalty
    if (!spellId && (attType != RANGED_ATTACK) && haveOffhandWeapon() && (!m_currentSpells[CURRENT_MELEE_SPELL] || !m_currentSpells[CURRENT_MELEE_SPELL]->IsNextMeleeSwingSpell()))
    {
        missChance += 19;
    }

    // bonus from skills is 0.04%
    //miss_chance -= skillDiff * 0.04f;
    int32 diff = -skillDiff;
    if (victim->GetTypeId() == TYPEID_PLAYER)
        missChance += diff > 0 ? diff * 0.04f : diff * 0.02f;
    else
        missChance += diff > 10 ? 1 + (diff - 10) * 0.4f : diff * 0.1f;

    // Calculate hit chance
    float hitChance = 100.0f;

    // Spellmod from SPELLMOD_RESIST_MISS_CHANCE
    if (spellId)
    {
        if (Player* modOwner = GetSpellModOwner())
            modOwner->ApplySpellMod(spellId, SPELLMOD_RESIST_MISS_CHANCE, hitChance);
    }

    missChance -= hitChance - 100.0f;

    if (attType == RANGED_ATTACK)
        missChance -= m_modRangedHitChance;
    else
        missChance -= m_modMeleeHitChance;

    // Limit miss chance from 0 to 60%
    if (missChance < 0.0f)
        return 0.0f;
    if (missChance > 60.0f)
        return 60.0f;
    return missChance;
}

uint32 Unit::GetPhaseByAuras() const
{
    uint32 currentPhase = 0;
    AuraEffectList const& phases = GetAuraEffectsByType(SPELL_AURA_PHASE);
    if (!phases.empty())
        for (AuraEffectList::const_iterator itr = phases.begin(); itr != phases.end(); ++itr)
            currentPhase |= (*itr)->GetMiscValue();

    return currentPhase;
}

void Unit::SetPhaseMask(uint32 newPhaseMask, bool update)
{
    if (newPhaseMask == GetPhaseMask())
        return;

    if (IsInWorld())
    {
        // xinef: to comment, bellow line should be removed
        // pussywizard: goign to other phase (valithria, algalon) should not remove such auras
        //RemoveNotOwnSingleTargetAuras(newPhaseMask, true);            // we can lost access to caster or target

        if (!sScriptMgr->CanSetPhaseMask(this, newPhaseMask, update))
            return;

        // modify hostile references for new phasemask, some special cases deal with hostile references themselves
        if (GetTypeId() == TYPEID_UNIT || (!ToPlayer()->IsGameMaster() && !ToPlayer()->GetSession()->PlayerLogout()))
        {
            HostileRefMgr& refMgr = getHostileRefMgr();
            HostileReference* ref = refMgr.getFirst();

            while (ref)
            {
                if (Unit* unit = ref->GetSource()->GetOwner())
                    if (Creature* creature = unit->ToCreature())
                        refMgr.setOnlineOfflineState(creature, creature->InSamePhase(newPhaseMask));

                ref = ref->next();
            }

            // modify threat lists for new phasemask
            if (GetTypeId() != TYPEID_PLAYER)
            {
                ThreatContainer::StorageType threatList = GetThreatMgr().GetThreatList();
                ThreatContainer::StorageType offlineThreatList = GetThreatMgr().GetOfflineThreatList();

                // merge expects sorted lists
                threatList.sort();
                offlineThreatList.sort();
                threatList.merge(offlineThreatList);

                for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
                    if (Unit* unit = (*itr)->getTarget())
                        unit->getHostileRefMgr().setOnlineOfflineState(ToCreature(), unit->InSamePhase(newPhaseMask));
            }
        }
    }

    WorldObject::SetPhaseMask(newPhaseMask, false);

    if (!IsInWorld())
    {
        return;
    }

    for (ControlSet::const_iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); )
    {
        Unit* controlled = *itr;
        ++itr;
        if (controlled->GetTypeId() == TYPEID_UNIT)
        {
            controlled->SetPhaseMask(newPhaseMask, true);
        }
    }

    for (uint8 i = 0; i < MAX_SUMMON_SLOT; ++i)
    {
        if (m_SummonSlot[i])
        {
            if (Creature* summon = GetMap()->GetCreature(m_SummonSlot[i]))
            {
                summon->SetPhaseMask(newPhaseMask, true);
            }
        }
    }

    if (update)
    {
        UpdateObjectVisibility();
    }
}

void Unit::UpdateObjectVisibility(bool forced, bool /*fromUpdate*/)
{
    if (!forced)
        AddToNotify(NOTIFY_VISIBILITY_CHANGED);
    else
    {
        WorldObject::UpdateObjectVisibility(true);
        Acore::AIRelocationNotifier notifier(*this);
        float radius = 60.0f;
        Cell::VisitAllObjects(this, notifier, radius);
    }
}

void Unit::KnockbackFrom(float x, float y, float speedXY, float speedZ)
{
    Player* player = ToPlayer();
    if (!player)
    {
        if (Unit* charmer = GetCharmer())
        {
            player = charmer->ToPlayer();
            if (player && player->m_mover != this)
                player = nullptr;
        }
    }

    if (!player)
    {
        GetMotionMaster()->MoveKnockbackFrom(x, y, speedXY, speedZ);
    }
    else
    {
        float vcos, vsin;
        GetSinCos(x, y, vsin, vcos);

        WorldPacket data(SMSG_MOVE_KNOCK_BACK, (8 + 4 + 4 + 4 + 4 + 4));
        data << GetPackGUID();
        data << uint32(0);                                      // counter
        data << float(vcos);                                    // x direction
        data << float(vsin);                                    // y direction
        data << float(speedXY);                                 // Horizontal speed
        data << float(-speedZ);                                 // Z Movement speed (vertical)

        player->GetSession()->SendPacket(&data);

        if (player->HasAuraType(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED) || player->HasAuraType(SPELL_AURA_FLY))
            player->SetCanFly(true, true);

        player->SetCanKnockback(true);
    }
}

float Unit::GetCombatRatingReduction(CombatRating cr) const
{
    if (Player const* player = ToPlayer())
        return player->GetRatingBonusValue(cr);
    // Player's pet get resilience from owner
    else if (IsPet() && GetOwner())
        if (Player* owner = GetOwner()->ToPlayer())
            return owner->GetRatingBonusValue(cr);

    return 0.0f;
}

uint32 Unit::GetCombatRatingDamageReduction(CombatRating cr, float rate, float cap, uint32 damage) const
{
    float percent = std::min(GetCombatRatingReduction(cr) * rate, cap);
    return CalculatePct(damage, percent);
}

uint32 Unit::GetModelForForm(ShapeshiftForm form, uint32 spellId) const
{
    // Hardcoded cases
    switch (spellId)
    {
        case 7090: // Bear form
            return 29414;
        case 35200: // Roc form
            return 4877;
        default:
            break;
    }

    if (GetTypeId() == TYPEID_PLAYER)
    {
        switch (form)
        {
            case FORM_CAT:
                // Based on Hair color
                if (getRace() == RACE_NIGHTELF)
                {
                    uint8 hairColor = GetByteValue(PLAYER_BYTES, 3);
                    switch (hairColor)
                    {
                        case 7: // Violet
                        case 8:
                            return 29405;
                        case 3: // Light Blue
                            return 29406;
                        case 0: // Green
                        case 1: // Light Green
                        case 2: // Dark Green
                            return 29407;
                        case 4: // White
                            return 29408;
                        default: // original - Dark Blue
                            return 892;
                    }
                }
                // Based on Skin color
                else if (getRace() == RACE_TAUREN)
                {
                    uint8 skinColor = GetByteValue(PLAYER_BYTES, 0);
                    // Male
                    if (getGender() == GENDER_MALE)
                    {
                        switch (skinColor)
                        {
                            case 12: // White
                            case 13:
                            case 14:
                            case 18: // Completly White
                                return 29409;
                            case 9: // Light Brown
                            case 10:
                            case 11:
                                return 29410;
                            case 6: // Brown
                            case 7:
                            case 8:
                                return 29411;
                            case 0: // Dark
                            case 1:
                            case 2:
                            case 3: // Dark Grey
                            case 4:
                            case 5:
                                return 29412;
                            default: // original - Grey
                                return 8571;
                        }
                    }
                    // Female
                    else switch (skinColor)
                        {
                            case 10: // White
                                return 29409;
                            case 6: // Light Brown
                            case 7:
                                return 29410;
                            case 4: // Brown
                            case 5:
                                return 29411;
                            case 0: // Dark
                            case 1:
                            case 2:
                            case 3:
                                return 29412;
                            default: // original - Grey
                                return 8571;
                        }
                }
                else if (Player::TeamIdForRace(getRace()) == TEAM_ALLIANCE)
                    return 892;
                else
                    return 8571;
            case FORM_DIREBEAR:
            case FORM_BEAR:
                // Based on Hair color
                if (getRace() == RACE_NIGHTELF)
                {
                    uint8 hairColor = GetByteValue(PLAYER_BYTES, 3);
                    switch (hairColor)
                    {
                        case 0: // Green
                        case 1: // Light Green
                        case 2: // Dark Green
                            return 29413; // 29415?
                        case 6: // Dark Blue
                            return 29414;
                        case 4: // White
                            return 29416;
                        case 3: // Light Blue
                            return 29417;
                        default: // original - Violet
                            return 2281;
                    }
                }
                // Based on Skin color
                else if (getRace() == RACE_TAUREN)
                {
                    uint8 skinColor = GetByteValue(PLAYER_BYTES, 0);
                    // Male
                    if (getGender() == GENDER_MALE)
                    {
                        switch (skinColor)
                        {
                            case 0: // Dark (Black)
                            case 1:
                            case 2:
                                return 29418;
                            case 3: // White
                            case 4:
                            case 5:
                            case 12:
                            case 13:
                            case 14:
                                return 29419;
                            case 9: // Light Brown/Grey
                            case 10:
                            case 11:
                            case 15:
                            case 16:
                            case 17:
                                return 29420;
                            case 18: // Completly White
                                return 29421;
                            default: // original - Brown
                                return 2289;
                        }
                    }
                    // Female
                    else switch (skinColor)
                        {
                            case 0: // Dark (Black)
                            case 1:
                                return 29418;
                            case 2: // White
                            case 3:
                                return 29419;
                            case 6: // Light Brown/Grey
                            case 7:
                            case 8:
                            case 9:
                                return 29420;
                            case 10: // Completly White
                                return 29421;
                            default: // original - Brown
                                return 2289;
                        }
                }
                else if (Player::TeamIdForRace(getRace()) == TEAM_ALLIANCE)
                    return 2281;
                else
                    return 2289;
            case FORM_FLIGHT:
                if (Player::TeamIdForRace(getRace()) == TEAM_ALLIANCE)
                    return 20857;
                return 20872;
            case FORM_FLIGHT_EPIC:
                if (Player::TeamIdForRace(getRace()) == TEAM_ALLIANCE)
                    return 21243;
                return 21244;
            default:
                break;
        }
    }

    uint32 modelid = 0;
    SpellShapeshiftFormEntry const* formEntry = sSpellShapeshiftFormStore.LookupEntry(form);
    if (formEntry && formEntry->modelID_A)
    {
        // Take the alliance modelid as default
        if (GetTypeId() != TYPEID_PLAYER)
            return formEntry->modelID_A;
        else
        {
            if (Player::TeamIdForRace(getRace()) == TEAM_ALLIANCE)
                modelid = formEntry->modelID_A;
            else
                modelid = formEntry->modelID_H;

            // If the player is horde but there are no values for the horde modelid - take the alliance modelid
            if (!modelid && Player::TeamIdForRace(getRace()) == TEAM_HORDE)
                modelid = formEntry->modelID_A;
        }
    }

    return modelid;
}

uint32 Unit::GetModelForTotem(PlayerTotemType totemType)
{
    switch (getRace())
    {
        case RACE_ORC:
            {
                switch (totemType)
                {
                    case SUMMON_TYPE_TOTEM_FIRE:    // fire
                        return 30758;
                    case SUMMON_TYPE_TOTEM_EARTH:   // earth
                        return 30757;
                    case SUMMON_TYPE_TOTEM_WATER:   // water
                        return 30759;
                    case SUMMON_TYPE_TOTEM_AIR:     // air
                        return 30756;
                }
                break;
            }
        case RACE_DWARF:
            {
                switch (totemType)
                {
                    case SUMMON_TYPE_TOTEM_FIRE:    // fire
                        return 30754;
                    case SUMMON_TYPE_TOTEM_EARTH:   // earth
                        return 30753;
                    case SUMMON_TYPE_TOTEM_WATER:   // water
                        return 30755;
                    case SUMMON_TYPE_TOTEM_AIR:     // air
                        return 30736;
                }
                break;
            }
        case RACE_TROLL:
            {
                switch (totemType)
                {
                    case SUMMON_TYPE_TOTEM_FIRE:    // fire
                        return 30762;
                    case SUMMON_TYPE_TOTEM_EARTH:   // earth
                        return 30761;
                    case SUMMON_TYPE_TOTEM_WATER:   // water
                        return 30763;
                    case SUMMON_TYPE_TOTEM_AIR:     // air
                        return 30760;
                }
                break;
            }
        case RACE_TAUREN:
            {
                switch (totemType)
                {
                    case SUMMON_TYPE_TOTEM_FIRE:    // fire
                        return 4589;
                    case SUMMON_TYPE_TOTEM_EARTH:   // earth
                        return 4588;
                    case SUMMON_TYPE_TOTEM_WATER:   // water
                        return 4587;
                    case SUMMON_TYPE_TOTEM_AIR:     // air
                        return 4590;
                }
                break;
            }
        case RACE_DRAENEI:
            {
                switch (totemType)
                {
                    case SUMMON_TYPE_TOTEM_FIRE:    // fire
                        return 19074;
                    case SUMMON_TYPE_TOTEM_EARTH:   // earth
                        return 19073;
                    case SUMMON_TYPE_TOTEM_WATER:   // water
                        return 19075;
                    case SUMMON_TYPE_TOTEM_AIR:     // air
                        return 19071;
                }
                break;
            }
        default: // One standard for other races.
            {
                switch (totemType)
                {
                    case SUMMON_TYPE_TOTEM_FIRE:    // fire
                        return 4589;
                    case SUMMON_TYPE_TOTEM_EARTH:   // earth
                        return 4588;
                    case SUMMON_TYPE_TOTEM_WATER:   // water
                        return 4587;
                    case SUMMON_TYPE_TOTEM_AIR:     // air
                        return 4590;
                }
                break;
            }
    }
    return 0;
}

Unit* Unit::GetRedirectThreatTarget() const
{
    return _redirectThreatInfo.GetTargetGUID() ? ObjectAccessor::GetUnit(*this, _redirectThreatInfo.GetTargetGUID()) : nullptr;
}

void Unit::JumpTo(float speedXY, float speedZ, bool forward)
{
    float angle = forward ? 0 : M_PI;
    if (GetTypeId() == TYPEID_UNIT)
        GetMotionMaster()->MoveJumpTo(angle, speedXY, speedZ);
    else
    {
        float vcos = cos(angle + GetOrientation());
        float vsin = std::sin(angle + GetOrientation());

        WorldPacket data(SMSG_MOVE_KNOCK_BACK, (8 + 4 + 4 + 4 + 4 + 4));
        data << GetPackGUID();
        data << uint32(0);                                      // Sequence
        data << float(vcos);                                    // x direction
        data << float(vsin);                                    // y direction
        data << float(speedXY);                                 // Horizontal speed
        data << float(-speedZ);                                 // Z Movement speed (vertical)

        ToPlayer()->GetSession()->SendPacket(&data);
    }
}

void Unit::JumpTo(WorldObject* obj, float speedZ)
{
    float x, y, z;
    obj->GetContactPoint(this, x, y, z);
    float speedXY = GetExactDist2d(x, y) * 10.0f / speedZ;
    GetMotionMaster()->MoveJump(x, y, z, speedXY, speedZ);
}

bool Unit::HandleSpellClick(Unit* clicker, int8 seatId)
{
    Creature* creature = ToCreature();
    if (creature && creature->IsAIEnabled)
    {
        if (!creature->AI()->BeforeSpellClick(clicker))
        {
            return false;
        }
    }

    bool result = false;
    uint32 spellClickEntry = GetVehicleKit() ? GetVehicleKit()->GetCreatureEntry() : GetEntry();
    SpellClickInfoMapBounds clickPair = sObjectMgr->GetSpellClickInfoMapBounds(spellClickEntry);
    for (SpellClickInfoContainer::const_iterator itr = clickPair.first; itr != clickPair.second; ++itr)
    {
        //! First check simple relations from clicker to clickee
        if (!itr->second.IsFitToRequirements(clicker, this))
            continue;

        //! Check database conditions
        ConditionList conds = sConditionMgr->GetConditionsForSpellClickEvent(spellClickEntry, itr->second.spellId);
        ConditionSourceInfo info = ConditionSourceInfo(clicker, this);
        if (!sConditionMgr->IsObjectMeetToConditions(info, conds))
            continue;

        Unit* caster = (itr->second.castFlags & NPC_CLICK_CAST_CASTER_CLICKER) ? clicker : this;
        Unit* target = (itr->second.castFlags & NPC_CLICK_CAST_TARGET_CLICKER) ? clicker : this;
        ObjectGuid origCasterGUID = (itr->second.castFlags & NPC_CLICK_CAST_ORIG_CASTER_OWNER) ? GetOwnerGUID() : clicker->GetGUID();

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itr->second.spellId);

        // xinef: dont allow players to enter vehicles on arena
        if (spellInfo->HasAura(SPELL_AURA_CONTROL_VEHICLE) && caster->GetTypeId() == TYPEID_PLAYER && caster->FindMap() && caster->FindMap()->IsBattleArena())
            continue;

        if (seatId > -1)
        {
            uint8 i = 0;
            bool valid = false;
            while (i < MAX_SPELL_EFFECTS)
            {
                if (spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_CONTROL_VEHICLE)
                {
                    valid = true;
                    break;
                }
                ++i;
            }

            if (!valid)
            {
                LOG_ERROR("sql.sql", "Spell {} specified in npc_spellclick_spells is not a valid vehicle enter aura!", itr->second.spellId);
                continue;
            }

            if (IsInMap(caster))
                caster->CastCustomSpell(itr->second.spellId, SpellValueMod(SPELLVALUE_BASE_POINT0 + i), seatId + 1, target, GetVehicleKit() ? TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE : TRIGGERED_NONE, nullptr, nullptr, origCasterGUID);
            else    // This can happen during Player::_LoadAuras
            {
                int32 bp0[MAX_SPELL_EFFECTS];
                for (uint32 j = 0; j < MAX_SPELL_EFFECTS; ++j)
                    bp0[j] = spellInfo->Effects[j].BasePoints;

                bp0[i] = seatId;
                Aura::TryRefreshStackOrCreate(spellInfo, MAX_EFFECT_MASK, this, clicker, bp0, nullptr, origCasterGUID);
            }
        }
        else
        {
            if (IsInMap(caster))
                caster->CastSpell(target, spellInfo, GetVehicleKit() ? TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE : TRIGGERED_NONE, nullptr, nullptr, origCasterGUID);
            else
                Aura::TryRefreshStackOrCreate(spellInfo, MAX_EFFECT_MASK, this, clicker, nullptr, nullptr, origCasterGUID);
        }

        result = true;
    }

    if (creature && creature->IsAIEnabled)
        creature->AI()->OnSpellClick(clicker, result);

    return result;
}

void Unit::EnterVehicle(Unit* base, int8 seatId)
{
    CastCustomSpell(VEHICLE_SPELL_RIDE_HARDCODED, SPELLVALUE_BASE_POINT0, seatId + 1, base, TRIGGERED_IGNORE_CASTER_MOUNTED_OR_ON_VEHICLE);

    if (Player* player = ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(player);
    }
}

void Unit::EnterVehicleUnattackable(Unit* base, int8 seatId)
{
    CastCustomSpell(67830, SPELLVALUE_BASE_POINT0, seatId + 1, base, true);
}

void Unit::_EnterVehicle(Vehicle* vehicle, int8 seatId, AuraApplication const* aurApp)
{
    // Must be called only from aura handler
    if (!IsAlive() || GetVehicleKit() == vehicle || vehicle->GetBase()->IsOnVehicle(this))
        return;

    if (m_vehicle)
    {
        if (m_vehicle == vehicle)
        {
            if (seatId >= 0 && seatId != GetTransSeat())
            {
                LOG_DEBUG("vehicles", "EnterVehicle: {} leave vehicle {} seat {} and enter {}.", GetEntry(), m_vehicle->GetBase()->GetEntry(), GetTransSeat(), seatId);
                ChangeSeat(seatId);
            }

            return;
        }
        else
        {
            LOG_DEBUG("vehicles", "EnterVehicle: {} exit {} and enter {}.", GetEntry(), m_vehicle->GetBase()->GetEntry(), vehicle->GetBase()->GetEntry());
            ExitVehicle();
        }
    }

    if (!aurApp || aurApp->GetRemoveMode())
        return;

    if (Player* player = ToPlayer())
    {
        if (vehicle->GetBase()->GetTypeId() == TYPEID_PLAYER && player->IsInCombat())
            return;

        sScriptMgr->AnticheatSetUnderACKmount(player);

        InterruptNonMeleeSpells(false);
        player->StopCastingCharm();
        player->StopCastingBindSight();
        Dismount();
        RemoveAurasByType(SPELL_AURA_MOUNTED);

        // drop flag at invisible in bg
        if (Battleground* bg = player->GetBattleground())
            bg->EventPlayerDroppedFlag(player);

        WorldPacket data(SMSG_ON_CANCEL_EXPECTED_RIDE_VEHICLE_AURA, 0);
        player->GetSession()->SendPacket(&data);
    }

    ASSERT(!m_vehicle);
    m_vehicle = vehicle;

    if (!m_vehicle->AddPassenger(this, seatId))
    {
        m_vehicle = nullptr;
        return;
    }

    // Xinef: remove movement auras when entering vehicle (food buffs etc)
    RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TURNING | AURA_INTERRUPT_FLAG_MOVE);
}

void Unit::ChangeSeat(int8 seatId, bool next)
{
    if (!m_vehicle)
        return;

    if (seatId < 0)
    {
        seatId = m_vehicle->GetNextEmptySeat(GetTransSeat(), next);
        if (seatId < 0)
            return;
    }
    else if (seatId == GetTransSeat() || !m_vehicle->HasEmptySeat(seatId))
        return;

    m_vehicle->RemovePassenger(this);
    if (!m_vehicle->AddPassenger(this, seatId))
        ABORT();
}

void Unit::ExitVehicle(Position const* /*exitPosition*/)
{
    //! This function can be called at upper level code to initialize an exit from the passenger's side.
    if (!m_vehicle)
        return;

    GetVehicleBase()->RemoveAurasByType(SPELL_AURA_CONTROL_VEHICLE, GetGUID());
    if (Player* player = ToPlayer())
    {
        player->SetCanTeleport(true);
    }
    //! The following call would not even be executed successfully as the
    //! SPELL_AURA_CONTROL_VEHICLE unapply handler already calls _ExitVehicle without
    //! specifying an exitposition. The subsequent call below would return on if (!m_vehicle).
    /*_ExitVehicle(exitPosition);*/
    //! To do:
    //! We need to allow SPELL_AURA_CONTROL_VEHICLE unapply handlers in spellscripts
    //! to specify exit coordinates and either store those per passenger, or we need to
    //! init spline movement based on those coordinates in unapply handlers, and
    //! relocate exiting passengers based on Unit::moveSpline data. Either way,
    //! Coming Soon(TM)

    if (Player* player = ToPlayer())
    {
        sScriptMgr->AnticheatSetUnderACKmount(player);
    }
}

bool VehicleDespawnEvent::Execute(uint64  /*e_time*/, uint32  /*p_time*/)
{
    Position pos = _self;
    _self.MovePositionToFirstCollision(pos, 20.0f, M_PI);
    _self.GetMotionMaster()->MovePoint(0, pos);
    _self.ToCreature()->DespawnOrUnsummon(_duration);
    return true;
}

void Unit::_ExitVehicle(Position const* exitPosition)
{
    if (!m_vehicle)
        return;

    m_vehicle->RemovePassenger(this);

    Player* player = ToPlayer();

    // If player is on mouted duel and exits the mount should immediatly lose the duel
    if (player && player->duel && player->duel->IsMounted)
        player->DuelComplete(DUEL_FLED);

    // This should be done before dismiss, because there may be some aura removal
    Vehicle* vehicle = m_vehicle;
    Unit* vehicleBase = m_vehicle->GetBase();
    m_vehicle = nullptr;

    if (!vehicleBase)
        return;

    SetControlled(false, UNIT_STATE_ROOT);      // SMSG_MOVE_FORCE_UNROOT, ~MOVEMENTFLAG_ROOT

    Position pos;
    if (!exitPosition)                          // Exit position not specified
        pos = vehicleBase->GetPosition();  // This should use passenger's current position, leaving it as it is now
    // because we calculate positions incorrect (sometimes under map)
    else
        pos = *exitPosition;

    // HACK
    VehicleEntry const* vehicleInfo = vehicle->GetVehicleInfo();
    if (vehicleInfo)
    {
        if (vehicleInfo->m_ID == 380) // Kologarn right arm
        {
            pos.Relocate(1776.0f, -24.0f, 448.75f, 0.0f);
        }
        else if (vehicleInfo->m_ID == 91) // Helsman's Ship
        {
            pos.Relocate(2802.18f, 7054.91f, -0.6f, 4.67f);
        }
        else if (vehicleInfo->m_ID == 349) // AT Mounts, dismount to the right
        {
            float x = pos.GetPositionX() + 2.0f * cos(pos.GetOrientation() - M_PI / 2.0f);
            float y = pos.GetPositionY() + 2.0f * std::sin(pos.GetOrientation() - M_PI / 2.0f);
            float z = GetMapHeight(x, y, pos.GetPositionZ());
            if (z > INVALID_HEIGHT)
            {
                pos.Relocate(x, y, z);
            }
        }
    }

    AddUnitState(UNIT_STATE_MOVE);

    if (player)
    {
        player->SetFallInformation(GameTime::GetGameTime().count(), GetPositionZ());

        sScriptMgr->AnticheatSetUnderACKmount(player);
    }
    else if (HasUnitMovementFlag(MOVEMENTFLAG_ROOT))
    {
        WorldPacket data(SMSG_SPLINE_MOVE_UNROOT, 8);
        data << GetPackGUID();
        SendMessageToSet(&data, false);
    }

    // xinef: hack for flameleviathan seat vehicle
    if (!vehicleInfo || vehicleInfo->m_ID != 341)
    {
        Movement::MoveSplineInit init(this);
        init.MoveTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ());
        init.SetFacing(GetOrientation());
        init.SetTransportExit();
        init.Launch();
    }
    else
    {
        float o = pos.GetAngle(this);
        Movement::MoveSplineInit init(this);
        init.MoveTo(pos.GetPositionX() + 8 * cos(o), pos.GetPositionY() + 8 * std::sin(o), pos.GetPositionZ() + 16.0f);
        init.SetFacing(GetOrientation());
        init.SetTransportExit();
        init.Launch();
        DisableSpline();
        KnockbackFrom(pos.GetPositionX(), pos.GetPositionY(), 10.0f, 20.0f);
        CastSpell(this, VEHICLE_SPELL_PARACHUTE, true);
    }

    // xinef: move fall, should we support all creatures that exited vehicle in air? Currently Quest Drag and Drop only, Air Assault quest
    if (GetTypeId() == TYPEID_UNIT && !CanFly() && vehicleInfo && (vehicleInfo->m_ID == 113 || vehicleInfo->m_ID == 8 || vehicleInfo->m_ID == 290 || vehicleInfo->m_ID == 298))
    {
        GetMotionMaster()->MoveFall();
    }

    if ((!player || !(player->GetDelayedOperations() & DELAYED_VEHICLE_TELEPORT)) && vehicle->GetBase()->HasUnitTypeMask(UNIT_MASK_MINION))
        if (((Minion*)vehicleBase)->GetOwner() == this)
        {
            if (!vehicleInfo || vehicleInfo->m_ID != 349)
            {
                vehicle->Dismiss();
            }
            else if (vehicleBase->GetTypeId() == TYPEID_UNIT)
            {
                vehicle->Uninstall();
                vehicleBase->m_Events.AddEvent(new VehicleDespawnEvent(*vehicleBase, 2000), vehicleBase->m_Events.CalculateTime(2000));
            }

            // xinef: ugly hack, no appripriate hook later to cast spell
            if (player)
            {
                if (vehicleBase->GetEntry() == NPC_EIDOLON_WATCHER)
                    player->CastSpell(player, VEHICLE_SPELL_SHADE_CONTROL_END, true);
                else if (vehicleBase->GetEntry() == NPC_LITHE_STALKER)
                    player->CastSpell(player, VEHICLE_SPELL_GEIST_CONTROL_END, true);
            }
        }

    if (HasUnitTypeMask(UNIT_MASK_ACCESSORY))
    {
        // Vehicle just died, we die too
        if (vehicleBase->getDeathState() == DeathState::JustDied)
            setDeathState(DeathState::JustDied);
        // If for other reason we as minion are exiting the vehicle (ejected, master dismounted) - unsummon
        else
        {
            SetVisible(false);
            ToTempSummon()->UnSummon(2000); // Approximation
        }
    }

    if (player)
    {
        player->ResummonPetTemporaryUnSummonedIfAny();
        player->SetCanTeleport(true);
    }
}

void Unit::BuildMovementPacket(ByteBuffer* data) const
{
    *data << uint32(GetUnitMovementFlags());            // movement flags
    *data << uint16(GetExtraUnitMovementFlags());       // 2.3.0
    *data << uint32(GameTime::GetGameTimeMS().count());                       // time / counter
    *data << GetPositionX();
    *data << GetPositionY();
    *data << GetPositionZ();
    *data << GetOrientation();

    // 0x00000200
    if (GetUnitMovementFlags() & MOVEMENTFLAG_ONTRANSPORT)
    {
        if (m_vehicle)
            *data << m_vehicle->GetBase()->GetPackGUID();
        else if (GetTransport())
            *data << GetTransport()->GetPackGUID();
        else
            *data << (uint8)0;

        *data << float (GetTransOffsetX());
        *data << float (GetTransOffsetY());
        *data << float (GetTransOffsetZ());
        *data << float (GetTransOffsetO());
        *data << uint32(GetTransTime());
        *data << uint8 (GetTransSeat());

        if (GetExtraUnitMovementFlags() & MOVEMENTFLAG2_INTERPOLATED_MOVEMENT)
            *data << uint32(m_movementInfo.transport.time2);
    }

    // 0x02200000
    if ((GetUnitMovementFlags() & (MOVEMENTFLAG_SWIMMING | MOVEMENTFLAG_FLYING))
            || (m_movementInfo.flags2 & MOVEMENTFLAG2_ALWAYS_ALLOW_PITCHING))
        *data << (float)m_movementInfo.pitch;

    *data << (uint32)m_movementInfo.fallTime;

    // 0x00001000
    if (GetUnitMovementFlags() & MOVEMENTFLAG_FALLING)
    {
        *data << (float)m_movementInfo.jump.zspeed;
        *data << (float)m_movementInfo.jump.sinAngle;
        *data << (float)m_movementInfo.jump.cosAngle;
        *data << (float)m_movementInfo.jump.xyspeed;
    }

    // 0x04000000
    if (GetUnitMovementFlags() & MOVEMENTFLAG_SPLINE_ELEVATION)
        *data << (float)m_movementInfo.splineElevation;
}

bool Unit::IsFalling() const
{
    return m_movementInfo.HasMovementFlag(MOVEMENTFLAG_FALLING | MOVEMENTFLAG_FALLING_FAR) ||
        (!movespline->Finalized() && movespline->Initialized() && movespline->isFalling());
}

/**
 * @brief this method checks the current flag of a unit
 *
 * These flags can be set within the database or dynamically changed at runtime
 * UNIT_FLAG_SWIMMING must be updated when a unit enters a swimmable area
 *
 */
bool Unit::CanSwim() const
{
    // Mirror client behavior, if this method returns false then client will not use swimming animation and for players will apply gravity as if there was no water
    if (HasUnitFlag(UNIT_FLAG_CANNOT_SWIM))
        return false;
    if (HasUnitFlag(UNIT_FLAG_POSSESSED) || HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED)) // is player
        return true;
    if (HasUnitFlag2(UNIT_FLAG2_UNUSED_6))
        return false;
    if (HasUnitFlag(UNIT_FLAG_PET_IN_COMBAT))
        return true;
    return HasUnitFlag(UNIT_FLAG_RENAME | UNIT_FLAG_SWIMMING);
}

void Unit::NearTeleportTo(Position& pos, bool casting /*= false*/, bool vehicleTeleport /*= false*/, bool withPet /*= false*/, bool removeTransport /*= false*/)
{
    NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), casting, vehicleTeleport, withPet, removeTransport);
}

void Unit::NearTeleportTo(float x, float y, float z, float orientation, bool casting /*= false*/, bool vehicleTeleport /*= false*/, bool withPet /*= false*/, bool removeTransport /*= false*/)
{
    DisableSpline();
    if (GetTypeId() == TYPEID_PLAYER)
        ToPlayer()->TeleportTo(GetMapId(), x, y, z, orientation, TELE_TO_NOT_LEAVE_COMBAT | (removeTransport ? 0 : TELE_TO_NOT_LEAVE_TRANSPORT) | TELE_TO_NOT_UNSUMMON_PET | (casting ? TELE_TO_SPELL : 0) | (vehicleTeleport ? TELE_TO_NOT_LEAVE_VEHICLE : 0) | (withPet ? TELE_TO_WITH_PET : 0));
    else
    {
        Position pos = {x, y, z, orientation};
        SendTeleportPacket(pos);
        UpdatePosition(x, y, z, orientation, true);
        UpdateObjectVisibility();
        GetMotionMaster()->ReinitializeMovement();
    }
}

void Unit::SendTameFailure(uint8 result)
{
    WorldPacket data(SMSG_PET_TAME_FAILURE, 1);
    data << uint8(result);
    ToPlayer()->SendDirectMessage(&data);
}

void Unit::SendTeleportPacket(Position& pos)
{
    Position oldPos = { GetPositionX(), GetPositionY(), GetPositionZ(), GetOrientation() };
    if (GetTypeId() == TYPEID_UNIT)
        Relocate(&pos);
    if (GetTypeId() == TYPEID_PLAYER)
    {
        ToPlayer()->SetCanTeleport(true);
    }
    WorldPacket data2(MSG_MOVE_TELEPORT, 38);
    data2 << GetPackGUID();
    BuildMovementPacket(&data2);
    if (GetTypeId() == TYPEID_UNIT)
        Relocate(&oldPos);
    if (GetTypeId() == TYPEID_PLAYER)
        Relocate(&pos);
    SendMessageToSet(&data2, false);
}

bool Unit::UpdatePosition(float x, float y, float z, float orientation, bool teleport)
{
    if (!Acore::IsValidMapCoord(x, y, z, orientation))
        return false;

    float old_orientation = GetOrientation();
    float current_z = GetPositionZ();
    bool turn = (old_orientation != orientation);
    bool relocated = (teleport || GetPositionX() != x || GetPositionY() != y || current_z != z);

    if (!GetVehicle())
    {
        uint32 mask = 0;
        if (turn) mask |= AURA_INTERRUPT_FLAG_TURNING;
        if (relocated) mask |= AURA_INTERRUPT_FLAG_MOVE;
        if (mask)
            RemoveAurasWithInterruptFlags(mask);
    }

    if (relocated)
    {
        if (GetTypeId() == TYPEID_PLAYER)
            GetMap()->PlayerRelocation(ToPlayer(), x, y, z, orientation);
        else
            GetMap()->CreatureRelocation(ToCreature(), x, y, z, orientation);
    }
    else if (turn)
    {
        UpdateOrientation(orientation);

        if (GetTypeId() == TYPEID_PLAYER && ToPlayer()->GetFarSightDistance())
            UpdateObjectVisibility(false);
    }

    return (relocated || turn);
}

//! Only server-side orientation update, does not broadcast to client
void Unit::UpdateOrientation(float orientation)
{
    SetOrientation(orientation);
    if (IsVehicle())
        GetVehicleKit()->RelocatePassengers();
}

//! Only server-side height update, does not broadcast to client
void Unit::UpdateHeight(float newZ)
{
    Relocate(GetPositionX(), GetPositionY(), newZ);
    if (IsVehicle())
        GetVehicleKit()->RelocatePassengers();
}

void Unit::SendThreatListUpdate()
{
    if (!GetThreatMgr().isThreatListEmpty())
    {
        uint32 count = GetThreatMgr().GetThreatList().size();

        //LOG_DEBUG("entities.unit", "WORLD: Send SMSG_THREAT_UPDATE Message");
        WorldPacket data(SMSG_THREAT_UPDATE, 8 + count * 8);
        data << GetPackGUID();
        data << uint32(count);
        ThreatContainer::StorageType const& tlist = GetThreatMgr().GetThreatList();
        for (ThreatContainer::StorageType::const_iterator itr = tlist.begin(); itr != tlist.end(); ++itr)
        {
            data << (*itr)->getUnitGuid().WriteAsPacked();
            data << uint32((*itr)->GetThreat() * 100);
        }
        SendMessageToSet(&data, false);
    }
}

void Unit::SendChangeCurrentVictimOpcode(HostileReference* pHostileReference)
{
    if (!GetThreatMgr().isThreatListEmpty())
    {
        uint32 count = GetThreatMgr().GetThreatList().size();

        LOG_DEBUG("entities.unit", "WORLD: Send SMSG_HIGHEST_THREAT_UPDATE Message");
        WorldPacket data(SMSG_HIGHEST_THREAT_UPDATE, 8 + 8 + count * 8);
        data << GetPackGUID();
        data << pHostileReference->getUnitGuid().WriteAsPacked();
        data << uint32(count);
        ThreatContainer::StorageType const& tlist = GetThreatMgr().GetThreatList();
        for (ThreatContainer::StorageType::const_iterator itr = tlist.begin(); itr != tlist.end(); ++itr)
        {
            data << (*itr)->getUnitGuid().WriteAsPacked();
            data << uint32((*itr)->GetThreat() * 100);
        }
        SendMessageToSet(&data, false);
    }
}

void Unit::SendClearThreatListOpcode()
{
    LOG_DEBUG("entities.unit", "WORLD: Send SMSG_THREAT_CLEAR Message");
    WorldPacket data(SMSG_THREAT_CLEAR, 8);
    data << GetPackGUID();
    SendMessageToSet(&data, false);
}

void Unit::SendRemoveFromThreatListOpcode(HostileReference* pHostileReference)
{
    LOG_DEBUG("entities.unit", "WORLD: Send SMSG_THREAT_REMOVE Message");
    WorldPacket data(SMSG_THREAT_REMOVE, 8 + 8);
    data << GetPackGUID();
    data << pHostileReference->getUnitGuid().WriteAsPacked();
    SendMessageToSet(&data, false);
}

void Unit::RewardRage(uint32 damage, uint32 weaponSpeedHitFactor, bool attacker)
{
    float addRage;

    float rageconversion = ((0.0091107836f * GetLevel() * GetLevel()) + 3.225598133f * GetLevel()) + 4.2652911f;

    // Unknown if correct, but lineary adjust rage conversion above level 70
    if (GetLevel() > 70)
        rageconversion += 13.27f * (GetLevel() - 70);

    if (attacker)
    {
        addRage = (damage / rageconversion * 7.5f + weaponSpeedHitFactor) / 2;

        // talent who gave more rage on attack
        AddPct(addRage, GetTotalAuraModifier(SPELL_AURA_MOD_RAGE_FROM_DAMAGE_DEALT));
    }
    else
    {
        addRage = damage / rageconversion * 2.5f;

        // Berserker Rage effect
        if (HasAura(18499))
            addRage *= 3.0f;
    }

    addRage *= sWorld->getRate(RATE_POWER_RAGE_INCOME);

    ModifyPower(POWER_RAGE, uint32(addRage * 10));
}

void Unit::StopAttackFaction(uint32 faction_id)
{
    if (Unit* victim = GetVictim())
    {
        if (victim->GetFactionTemplateEntry()->faction == faction_id)
        {
            AttackStop();
            if (IsNonMeleeSpellCast(false))
                InterruptNonMeleeSpells(false);

            // melee and ranged forced attack cancel
            if (GetTypeId() == TYPEID_PLAYER)
                ToPlayer()->SendAttackSwingCancelAttack();
        }
    }

    AttackerSet const& attackers = getAttackers();
    for (AttackerSet::const_iterator itr = attackers.begin(); itr != attackers.end();)
    {
        if ((*itr)->GetFactionTemplateEntry()->faction == faction_id)
        {
            (*itr)->AttackStop();
            itr = attackers.begin();
        }
        else
            ++itr;
    }

    getHostileRefMgr().deleteReferencesForFaction(faction_id);

    for (ControlSet::const_iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
        (*itr)->StopAttackFaction(faction_id);
}

void Unit::StopAttackingInvalidTarget()
{
    AttackerSet const& attackers = getAttackers();
    for (AttackerSet::const_iterator itr = attackers.begin(); itr != attackers.end();)
    {
        Unit* attacker = (*itr);
        if (!attacker->IsValidAttackTarget(this))
        {
            attacker->AttackStop();
            if (attacker->GetTypeId() == TYPEID_PLAYER)
            {
                attacker->ToPlayer()->SendAttackSwingCancelAttack();
            }

            for (Unit* controled : attacker->m_Controlled)
            {
                if (controled->GetVictim() == this && !controled->IsValidAttackTarget(this))
                {
                    controled->AttackStop();
                }
            }

            itr = attackers.begin();
        }
        else
        {
            ++itr;
        }
    }
}

void Unit::OutDebugInfo() const
{
    LOG_ERROR("entities.unit", "Unit::OutDebugInfo");
    LOG_INFO("entities.unit", "GUID {}, name {}", GetGUID().ToString(), GetName());
    LOG_INFO("entities.unit", "OwnerGUID {}, MinionGUID {}, CharmerGUID {}, CharmedGUID {}",
        GetOwnerGUID().ToString(), GetMinionGUID().ToString(), GetCharmerGUID().ToString(), GetCharmGUID().ToString());
    LOG_INFO("entities.unit", "In world {}, unit type mask {}", (uint32)(IsInWorld() ? 1 : 0), m_unitTypeMask);
    if (IsInWorld())
        LOG_INFO("entities.unit", "Mapid {}", GetMapId());

    LOG_INFO("entities.unit", "Summon Slot: ");
    for (uint32 i = 0; i < MAX_SUMMON_SLOT; ++i)
        LOG_INFO("entities.unit", "{}, ", m_SummonSlot[i].ToString());
    LOG_INFO("server.loading", " ");

    LOG_INFO("entities.unit", "Controlled List: ");
    for (ControlSet::const_iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
        LOG_INFO("entities.unit", "{}, ", (*itr)->GetGUID().ToString());
    LOG_INFO("server.loading", " ");

    LOG_INFO("entities.unit", "Aura List: ");
    for (AuraApplicationMap::const_iterator itr = m_appliedAuras.begin(); itr != m_appliedAuras.end(); ++itr)
        LOG_INFO("entities.unit", "{}, ", itr->first);
    LOG_INFO("server.loading", " ");

    if (IsVehicle())
    {
        LOG_INFO("entities.unit", "Passenger List: ");
        for (SeatMap::iterator itr = GetVehicleKit()->Seats.begin(); itr != GetVehicleKit()->Seats.end(); ++itr)
            if (Unit* passenger = ObjectAccessor::GetUnit(*GetVehicleBase(), itr->second.Passenger.Guid))
                LOG_INFO("entities.unit", "{}, ", passenger->GetGUID().ToString());
        LOG_INFO("server.loading", " ");
    }

    if (GetVehicle())
        LOG_INFO("entities.unit", "On vehicle {}.", GetVehicleBase()->GetEntry());
}

class AuraMunchingQueue : public BasicEvent
{
public:
    AuraMunchingQueue(Unit& owner, ObjectGuid targetGUID, int32 basePoints, uint32 spellId) : _owner(owner), _targetGUID(targetGUID), _basePoints(basePoints), _spellId(spellId) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        if (_owner.IsInWorld() && _owner.FindMap())
            if (Unit* target = ObjectAccessor::GetUnit(_owner, _targetGUID))
                _owner.CastCustomSpell(_spellId, SPELLVALUE_BASE_POINT0, _basePoints, target, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_NO_PERIODIC_RESET), nullptr, nullptr, _owner.GetGUID());

        return true;
    }

private:
    Unit& _owner;
    ObjectGuid _targetGUID;
    int32 _basePoints;
    uint32 _spellId;
};

void Unit::CastDelayedSpellWithPeriodicAmount(Unit* caster, uint32 spellId, AuraType auraType, int32 addAmount, uint8 effectIndex)
{
    for (AuraEffectList::iterator i = m_modAuras[auraType].begin(); i != m_modAuras[auraType].end(); ++i)
    {
        AuraEffect* aurEff = *i;
        if (aurEff->GetCasterGUID() != caster->GetGUID() || aurEff->GetId() != spellId || aurEff->GetEffIndex() != effectIndex || !aurEff->GetTotalTicks())
            continue;

        addAmount += ((aurEff->GetOldAmount() * std::max<int32>(aurEff->GetTotalTicks() - int32(aurEff->GetTickNumber()), 0)) / aurEff->GetTotalTicks());
        break;
    }

    // xinef: delay only for casting on different unit
    if (this == caster || !sWorld->getBoolConfig(CONFIG_MUNCHING_BLIZZLIKE))
        caster->CastCustomSpell(spellId, SPELLVALUE_BASE_POINT0, addAmount, this, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_NO_PERIODIC_RESET), nullptr, nullptr, caster->GetGUID());
    else
        caster->m_Events.AddEvent(new AuraMunchingQueue(*caster, GetGUID(), addAmount, spellId), caster->m_Events.CalculateQueueTime(400));
}

void Unit::SendClearTarget()
{
    WorldPacket data(SMSG_BREAK_TARGET, GetPackGUID().size());
    data << GetPackGUID();
    SendMessageToSet(&data, false);
}

uint32 Unit::GetResistance(SpellSchoolMask mask) const
{
    int32 resist = -1;
    for (int i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
        if (mask & (1 << i) && (resist < 0 || resist > int32(GetResistance(SpellSchools(i)))))
            resist = int32(GetResistance(SpellSchools(i)));

    // resist value will never be negative here
    return uint32(resist);
}

void CharmInfo::SetIsCommandAttack(bool val)
{
    _isCommandAttack = val;
}

bool CharmInfo::IsCommandAttack()
{
    return _isCommandAttack;
}

void CharmInfo::SetIsCommandFollow(bool val)
{
    _isCommandFollow = val;
}

bool CharmInfo::IsCommandFollow()
{
    return _isCommandFollow;
}

void CharmInfo::SaveStayPosition(bool atCurrentPos)
{
    //! At this point a new spline destination is enabled because of Unit::StopMoving()
    G3D::Vector3 stayPos = G3D::Vector3();

    if (atCurrentPos)
    {
        float z = INVALID_HEIGHT;
        _unit->UpdateAllowedPositionZ(_unit->GetPositionX(), _unit->GetPositionY(), z);
        stayPos = G3D::Vector3(_unit->GetPositionX(), _unit->GetPositionY(), z != INVALID_HEIGHT ? z : _unit->GetPositionZ());
    }
    else
        stayPos = _unit->movespline->FinalDestination();

    if (_unit->movespline->onTransport)
        if (TransportBase* transport = _unit->GetDirectTransport())
            transport->CalculatePassengerPosition(stayPos.x, stayPos.y, stayPos.z);

    _stayX = stayPos.x;
    _stayY = stayPos.y;
    _stayZ = stayPos.z;
}

void CharmInfo::GetStayPosition(float& x, float& y, float& z)
{
    x = _stayX;
    y = _stayY;
    z = _stayZ;
}

void CharmInfo::RemoveStayPosition()
{
    _stayX = 0.0f;
    _stayY = 0.0f;
    _stayZ = 0.0f;
}

bool CharmInfo::HasStayPosition()
{
    return _stayX && _stayY && _stayZ;
}

void CharmInfo::SetIsAtStay(bool val)
{
    _isAtStay = val;
}

bool CharmInfo::IsAtStay()
{
    return _isAtStay;
}

void CharmInfo::SetIsFollowing(bool val)
{
    _isFollowing = val;
}

bool CharmInfo::IsFollowing()
{
    return _isFollowing;
}

void CharmInfo::SetIsReturning(bool val)
{
    _isReturning = val;
}

bool CharmInfo::IsReturning()
{
    return _isReturning;
}

void Unit::PetSpellFail(SpellInfo const* spellInfo, Unit* target, uint32 result)
{
    CharmInfo* charmInfo = GetCharmInfo();
    if (!charmInfo || GetTypeId() != TYPEID_UNIT)
        return;

    if ((DisableMgr::IsPathfindingEnabled(GetMap()) || result != SPELL_FAILED_LINE_OF_SIGHT) && target)
    {
        if ((result == SPELL_FAILED_LINE_OF_SIGHT || result == SPELL_FAILED_OUT_OF_RANGE) || !ToCreature()->HasReactState(REACT_PASSIVE))
            if (Unit* owner = GetOwner())
            {
                if (spellInfo->IsPositive() && IsFriendlyTo(target))
                {
                    AttackStop();
                    charmInfo->SetIsAtStay(false);
                    charmInfo->SetIsCommandAttack(true);
                    charmInfo->SetIsReturning(false);
                    charmInfo->SetIsFollowing(false);

                    GetMotionMaster()->MoveFollow(target, PET_FOLLOW_DIST, rand_norm() * 2 * M_PI);
                }
                else if (owner->IsValidAttackTarget(target))
                {
                    AttackStop();
                    charmInfo->SetIsAtStay(false);
                    charmInfo->SetIsCommandAttack(true);
                    charmInfo->SetIsReturning(false);
                    charmInfo->SetIsFollowing(false);

                    if (!ToCreature()->HasReactState(REACT_PASSIVE))
                        ToCreature()->AI()->AttackStart(target);
                    else
                        GetMotionMaster()->MoveChase(target);
                }
            }

        // can be extended in future
        if (result == SPELL_FAILED_LINE_OF_SIGHT || result == SPELL_FAILED_OUT_OF_RANGE)
        {
            charmInfo->SetForcedSpell(spellInfo->IsPositive() ? -int32(spellInfo->Id) : spellInfo->Id);
            charmInfo->SetForcedTargetGUID(target->GetGUID());
        }
        else
        {
            charmInfo->SetForcedSpell(0);
            charmInfo->SetForcedTargetGUID(ObjectGuid::Empty);
        }
    }
}

int32 Unit::CalculateAOEDamageReduction(int32 damage, uint32 schoolMask, Unit* caster) const
{
    damage = int32(float(damage) * GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_AOE_DAMAGE_AVOIDANCE, schoolMask));
    if (caster && caster->GetTypeId() == TYPEID_UNIT)
        damage = int32(float(damage) * GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_CREATURE_AOE_DAMAGE_AVOIDANCE, schoolMask));

    return damage;
}

void Unit::ExecuteDelayedUnitRelocationEvent()
{
    this->RemoveFromNotify(NOTIFY_VISIBILITY_CHANGED);
    if (!this->IsInWorld() || this->IsDuringRemoveFromWorld())
        return;

    if (this->HasSharedVision())
        for (SharedVisionList::const_iterator itr = this->GetSharedVisionList().begin(); itr != this->GetSharedVisionList().end(); ++itr)
            if (Player* player = (*itr))
            {
                if (player->IsOnVehicle(this) || !player->IsInWorld() || player->IsDuringRemoveFromWorld()) // players on vehicles have their own event executed (due to passenger relocation)
                    continue;
                WorldObject* viewPoint = player;
                if (player->m_seer && player->m_seer->IsInWorld())
                    viewPoint = player->m_seer;
                if (!viewPoint->IsPositionValid() || !player->IsPositionValid())
                    continue;

                if (Unit* active = viewPoint->ToUnit())
                {
                    //if (active->IsVehicle()) // always check original unit here, last notify position is not relocated
                    //  active = player;

                    float dx = active->m_last_notify_position.GetPositionX() - active->GetPositionX();
                    float dy = active->m_last_notify_position.GetPositionY() - active->GetPositionY();
                    float dz = active->m_last_notify_position.GetPositionZ() - active->GetPositionZ();
                    float distsq = dx * dx + dy * dy + dz * dz;
                    float mindistsq = DynamicVisibilityMgr::GetReqMoveDistSq(active->FindMap()->GetEntry()->map_type);
                    if (distsq < mindistsq)
                        continue;

                    // this will be relocated below sharedvision!
                    //active->m_last_notify_position.Relocate(active->GetPositionX(), active->GetPositionY(), active->GetPositionZ());
                }

                Acore::PlayerRelocationNotifier relocateNoLarge(*player, false); // visit only objects which are not large; default distance
                Cell::VisitAllObjects(viewPoint, relocateNoLarge, player->GetSightRange() + VISIBILITY_INC_FOR_GOBJECTS);
                relocateNoLarge.SendToSelf();
                Acore::PlayerRelocationNotifier relocateLarge(*player, true);    // visit only large objects; maximum distance
                Cell::VisitAllObjects(viewPoint, relocateLarge, MAX_VISIBILITY_DISTANCE);
                relocateLarge.SendToSelf();
            }

    if (Player* player = this->ToPlayer())
    {
        WorldObject* viewPoint = player;
        if (player->m_seer && player->m_seer->IsInWorld())
            viewPoint = player->m_seer;

        if (viewPoint->GetMapId() != player->GetMapId() || !viewPoint->IsPositionValid() || !player->IsPositionValid())
            return;

        if (Unit* active = viewPoint->ToUnit())
        {
            if (active->IsVehicle())
                active = player;

            if (!player->GetFarSightDistance())
            {
                float dx     = active->m_last_notify_position.GetPositionX() - active->GetPositionX();
                float dy     = active->m_last_notify_position.GetPositionY() - active->GetPositionY();
                float dz     = active->m_last_notify_position.GetPositionZ() - active->GetPositionZ();
                float distsq = dx * dx + dy * dy + dz * dz;

                float mindistsq = DynamicVisibilityMgr::GetReqMoveDistSq(active->FindMap()->GetEntry()->map_type);
                if (distsq < mindistsq)
                    return;

                active->m_last_notify_position.Relocate(active->GetPositionX(), active->GetPositionY(), active->GetPositionZ());
            }
        }

        Acore::PlayerRelocationNotifier relocateNoLarge(*player, false); // visit only objects which are not large; default distance
        Cell::VisitAllObjects(viewPoint, relocateNoLarge, player->GetSightRange() + VISIBILITY_INC_FOR_GOBJECTS);
        relocateNoLarge.SendToSelf();

        if (!player->GetFarSightDistance())
        {
            Acore::PlayerRelocationNotifier relocateLarge(*player, true); // visit only large objects; maximum distance
            Cell::VisitAllObjects(viewPoint, relocateLarge, MAX_VISIBILITY_DISTANCE);
            relocateLarge.SendToSelf();
        }

        this->AddToNotify(NOTIFY_AI_RELOCATION);
    }
    else if (Creature* unit = this->ToCreature())
    {
        if (!unit->IsPositionValid())
            return;

        float dx = unit->m_last_notify_position.GetPositionX() - unit->GetPositionX();
        float dy = unit->m_last_notify_position.GetPositionY() - unit->GetPositionY();
        float dz = unit->m_last_notify_position.GetPositionZ() - unit->GetPositionZ();
        float distsq = dx * dx + dy * dy + dz * dz;
        float mindistsq = DynamicVisibilityMgr::GetReqMoveDistSq(unit->FindMap()->GetEntry()->map_type);
        if (distsq < mindistsq)
            return;

        unit->m_last_notify_position.Relocate(unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ());

        Acore::CreatureRelocationNotifier relocate(*unit);
        Cell::VisitAllObjects(unit, relocate, unit->GetVisibilityRange() + VISIBILITY_COMPENSATION);

        this->AddToNotify(NOTIFY_AI_RELOCATION);
    }
}

void Unit::ExecuteDelayedUnitAINotifyEvent()
{
    this->RemoveFromNotify(NOTIFY_AI_RELOCATION);
    if (!this->IsInWorld() || this->IsDuringRemoveFromWorld())
        return;

    Acore::AIRelocationNotifier notifier(*this);
    float radius = 60.0f;
    Cell::VisitAllObjects(this, notifier, radius);
}

void Unit::SetInFront(WorldObject const* target)
{
    if (!HasUnitState(UNIT_STATE_CANNOT_TURN))
        SetOrientation(GetAngle(target));
}

void Unit::SetFacingTo(float ori)
{
    Movement::MoveSplineInit init(this);
    init.MoveTo(GetPositionX(), GetPositionY(), GetPositionZ(), false);
    if (HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && GetTransGUID())
        init.DisableTransportPathTransformations(); // It makes no sense to target global orientation
    init.SetFacing(ori);
    init.Launch();
}

void Unit::SetFacingToObject(WorldObject* object)
{
    // never face when already moving
    if (!IsStopped())
        return;

    /// @todo figure out under what conditions creature will move towards object instead of facing it where it currently is.
    Movement::MoveSplineInit init(this);
    init.MoveTo(GetPositionX(), GetPositionY(), GetPositionZ());
    init.SetFacing(GetAngle(object));   // when on transport, GetAngle will still return global coordinates (and angle) that needs transforming
    init.Launch();
}

bool Unit::SetWalk(bool enable)
{
    if (enable == IsWalking())
        return false;

    if (enable)
        AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
    else
        RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);

    propagateSpeedChange();
    return true;
}

bool Unit::SetDisableGravity(bool disable, bool /*packetOnly = false*/, bool /*updateAnimationTier = true*/)
{
    if (disable == IsLevitating())
        return false;

    if (disable)
    {
        AddUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY);
        RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);
    }
    else
    {
        RemoveUnitMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY);
    }

    return true;
}

bool Unit::SetSwim(bool enable)
{
    if (enable == HasUnitMovementFlag(MOVEMENTFLAG_SWIMMING))
        return false;

    if (enable)
    {
        AddUnitMovementFlag(MOVEMENTFLAG_SWIMMING);
        SetUnitFlag(UNIT_FLAG_SWIMMING);
    }
    else
    {
        RemoveUnitMovementFlag(MOVEMENTFLAG_SWIMMING);
        RemoveUnitFlag(UNIT_FLAG_SWIMMING);
    }

    return true;
}

bool Unit::SetCanFly(bool enable, bool /*packetOnly = false */)
{
    if (enable == HasUnitMovementFlag(MOVEMENTFLAG_CAN_FLY))
        return false;

    if (enable)
    {
        AddUnitMovementFlag(MOVEMENTFLAG_CAN_FLY);
        RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);
    }
    else
    {
        RemoveUnitMovementFlag(MOVEMENTFLAG_CAN_FLY | MOVEMENTFLAG_MASK_MOVING_FLY);
    }

    return true;
}

bool Unit::SetWaterWalking(bool enable, bool /*packetOnly = false*/)
{
    if (enable == HasUnitMovementFlag(MOVEMENTFLAG_WATERWALKING))
        return false;

    if (enable)
        AddUnitMovementFlag(MOVEMENTFLAG_WATERWALKING);
    else
        RemoveUnitMovementFlag(MOVEMENTFLAG_WATERWALKING);

    return true;
}

void Unit::SendMovementWaterWalking(Player* sendTo)
{
    if (!movespline->Initialized())
        return;
    WorldPacket data(SMSG_SPLINE_MOVE_WATER_WALK, 9);
    data << GetPackGUID();
    sendTo->SendDirectMessage(&data);
}

bool Unit::SetFeatherFall(bool enable, bool /*packetOnly = false*/)
{
    if (enable == HasUnitMovementFlag(MOVEMENTFLAG_FALLING_SLOW))
        return false;

    if (enable)
        AddUnitMovementFlag(MOVEMENTFLAG_FALLING_SLOW);
    else
        RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING_SLOW);

    return true;
}

void Unit::SendMovementFeatherFall(Player* sendTo)
{
    if (!movespline->Initialized())
        return;
    WorldPacket data(SMSG_SPLINE_MOVE_FEATHER_FALL, 9);
    data << GetPackGUID();
    sendTo->SendDirectMessage(&data);
}

bool Unit::SetHover(bool enable, bool /*packetOnly = false*/, bool /*updateAnimationTier = true*/)
{
    if (enable == HasUnitMovementFlag(MOVEMENTFLAG_HOVER))
        return false;

    float hoverHeight = GetFloatValue(UNIT_FIELD_HOVERHEIGHT);

    if (enable)
    {
        AddUnitMovementFlag(MOVEMENTFLAG_HOVER);
        if (hoverHeight && GetPositionZ() - GetFloorZ() < hoverHeight)
            UpdateHeight(GetPositionZ() + hoverHeight);
    }
    else
    {
        RemoveUnitMovementFlag(MOVEMENTFLAG_HOVER);
        if (hoverHeight && (!isDying() || GetTypeId() != TYPEID_UNIT))
        {
            float newZ = std::max<float>(GetFloorZ(), GetPositionZ() - hoverHeight);
            UpdateAllowedPositionZ(GetPositionX(), GetPositionY(), newZ);
            UpdateHeight(newZ);
        }
        SendMovementFlagUpdate(); // pussywizard: needed for falling after death (instead of falling onto air at hover height)
    }

    return true;
}

void Unit::SendMovementHover(Player* sendTo)
{
    if (!movespline->Initialized())
        return;
    WorldPacket data(SMSG_SPLINE_MOVE_SET_HOVER, 9);
    data << GetPackGUID();
    sendTo->SendDirectMessage(&data);
}

void Unit::BuildValuesUpdate(uint8 updateType, ByteBuffer* data, Player* target)
{
    if (!target)
        return;

    uint32* flags = UnitUpdateFieldFlags;
    uint32 visibleFlag = UF_FLAG_PUBLIC;

    if (target == this)
        visibleFlag |= UF_FLAG_PRIVATE;

    Player* plr = GetCharmerOrOwnerPlayerOrPlayerItself();
    if (GetOwnerGUID() == target->GetGUID())
        visibleFlag |= UF_FLAG_OWNER;

    if (HasDynamicFlag(UNIT_DYNFLAG_SPECIALINFO))
        if (HasAuraTypeWithCaster(SPELL_AURA_EMPATHY, target->GetGUID()))
            visibleFlag |= UF_FLAG_SPECIAL_INFO;

    if (plr && plr->IsInSameRaidWith(target))
        visibleFlag |= UF_FLAG_PARTY_MEMBER;

    uint64 cacheKey = static_cast<uint64>(visibleFlag) << 8 | updateType;

    auto cacheIt = _valuesUpdateCache.find(cacheKey);
    if (cacheIt != _valuesUpdateCache.end())
    {
        int32 cachePos = static_cast<int32>(data->wpos());
        data->append(cacheIt->second.buffer);

        BuildValuesCachePosPointers dataAdjustedPos = cacheIt->second.posPointers;
        if (cachePos)
            dataAdjustedPos.ApplyOffset(cachePos);

        PatchValuesUpdate(*data, dataAdjustedPos, target);

        return;
    }

    BuildValuesCachedBuffer cacheValue(500);

    ByteBuffer fieldBuffer(400);

    UpdateMask updateMask;
    updateMask.SetCount(m_valuesCount);

    for (uint16 index = 0; index < m_valuesCount; ++index)
    {
        if (_fieldNotifyFlags & flags[index] ||
                ((flags[index] & visibleFlag) & UF_FLAG_SPECIAL_INFO) ||
                ((updateType == UPDATETYPE_VALUES ? _changesMask.GetBit(index) : m_uint32Values[index]) && (flags[index] & visibleFlag)) ||
                (index == UNIT_FIELD_AURASTATE && HasFlag(UNIT_FIELD_AURASTATE, PER_CASTER_AURA_STATE_MASK)))
        {
            updateMask.SetBit(index);

            if (index == UNIT_NPC_FLAGS)
            {
                cacheValue.posPointers.UnitNPCFlagsPos = int32(fieldBuffer.wpos());
                fieldBuffer << m_uint32Values[UNIT_NPC_FLAGS];
            }
            else if (index == UNIT_FIELD_AURASTATE)
            {
                cacheValue.posPointers.UnitFieldAuraStatePos = int32(fieldBuffer.wpos());
                fieldBuffer << uint32(0); // Fill in later.
            }
            // FIXME: Some values at server stored in float format but must be sent to client in uint32 format
            else if (index >= UNIT_FIELD_BASEATTACKTIME && index <= UNIT_FIELD_RANGEDATTACKTIME)
            {
                // convert from float to uint32 and send
                fieldBuffer << uint32(m_floatValues[index] < 0 ? 0 : m_floatValues[index]);
            }
            // there are some float values which may be negative or can't get negative due to other checks
            else if ((index >= UNIT_FIELD_NEGSTAT0   && index <= UNIT_FIELD_NEGSTAT4) ||
                     (index >= UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE  && index <= (UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 6)) ||
                     (index >= UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE  && index <= (UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 6)) ||
                     (index >= UNIT_FIELD_POSSTAT0   && index <= UNIT_FIELD_POSSTAT4))
            {
                fieldBuffer << uint32(m_floatValues[index]);
            }
            // Gamemasters should be always able to select units - remove not selectable flag
            else if (index == UNIT_FIELD_FLAGS)
            {
                cacheValue.posPointers.UnitFieldFlagsPos = int32(fieldBuffer.wpos());
                fieldBuffer << m_uint32Values[UNIT_FIELD_FLAGS];
            }
            // use modelid_a if not gm, _h if gm for CREATURE_FLAG_EXTRA_TRIGGER creatures
            else if (index == UNIT_FIELD_DISPLAYID)
            {
                cacheValue.posPointers.UnitFieldDisplayPos = int32(fieldBuffer.wpos());
                fieldBuffer << m_uint32Values[UNIT_FIELD_DISPLAYID];
            }
            else if (index == UNIT_DYNAMIC_FLAGS)
            {
                cacheValue.posPointers.UnitDynamicFlagsPos = int32(fieldBuffer.wpos());
                uint32 dynamicFlags = m_uint32Values[UNIT_DYNAMIC_FLAGS] & ~(UNIT_DYNFLAG_TAPPED | UNIT_DYNFLAG_TAPPED_BY_PLAYER);
                fieldBuffer << dynamicFlags;
            }
            else if (index == UNIT_FIELD_BYTES_2)
            {
                cacheValue.posPointers.UnitFieldBytes2Pos = int32(fieldBuffer.wpos());
                fieldBuffer << m_uint32Values[index];
            }
            else if (index == UNIT_FIELD_FACTIONTEMPLATE)
            {
                cacheValue.posPointers.UnitFieldFactionTemplatePos = int32(fieldBuffer.wpos());
                fieldBuffer << m_uint32Values[index];
            }
            else
            {
                if (sScriptMgr->ShouldTrackValuesUpdatePosByIndex(this, updateType, index))
                    cacheValue.posPointers.other[index] = static_cast<uint32>(fieldBuffer.wpos());

                // send in current format (float as float, uint32 as uint32)
                fieldBuffer << m_uint32Values[index];
            }
        }
    }

    cacheValue.buffer << uint8(updateMask.GetBlockCount());
    updateMask.AppendToPacket(&cacheValue.buffer);
    int32 fieldBufferPos = static_cast<int32>(cacheValue.buffer.wpos());
    cacheValue.buffer.append(fieldBuffer);
    cacheValue.posPointers.ApplyOffset(fieldBufferPos);

    int32 cachePos = static_cast<int32>(data->wpos());
    data->append(cacheValue.buffer);

    BuildValuesCachePosPointers dataAdjustedPos = cacheValue.posPointers;
    if (cachePos)
        dataAdjustedPos.ApplyOffset(cachePos);

    PatchValuesUpdate(*data, dataAdjustedPos, target);

    _valuesUpdateCache.insert(std::pair<uint64, BuildValuesCachedBuffer>(cacheKey, std::move(cacheValue)));
}

void Unit::PatchValuesUpdate(ByteBuffer& valuesUpdateBuf, BuildValuesCachePosPointers& posPointers, Player* target)
{
    Creature const* creature = ToCreature();

    // UNIT_NPC_FLAGS
    if (creature && posPointers.UnitNPCFlagsPos >= 0)
    {
        uint32 appendValue = m_uint32Values[UNIT_NPC_FLAGS];

        if (sWorld->getIntConfig(CONFIG_INSTANT_TAXI) == 2 && appendValue & UNIT_NPC_FLAG_FLIGHTMASTER)
            appendValue |= UNIT_NPC_FLAG_GOSSIP; // flight masters need NPC gossip flag to show instant flight toggle option

        if (!target->CanSeeSpellClickOn(creature))
            appendValue &= ~UNIT_NPC_FLAG_SPELLCLICK;

        if (!target->CanSeeVendor(creature))
            appendValue &= ~UNIT_NPC_FLAG_VENDOR_MASK;

        if (!creature->IsValidTrainerForPlayer(target, &appendValue))
            appendValue &= ~UNIT_NPC_FLAG_TRAINER;

        valuesUpdateBuf.put(posPointers.UnitNPCFlagsPos, appendValue);
    }

    // UNIT_FIELD_AURASTATE
    if (posPointers.UnitFieldAuraStatePos >= 0)
        valuesUpdateBuf.put(posPointers.UnitFieldAuraStatePos, uint32(BuildAuraStateUpdateForTarget(target)));

    // UNIT_FIELD_FLAGS
    if (posPointers.UnitFieldFlagsPos >= 0)
    {
        uint32 appendValue = m_uint32Values[UNIT_FIELD_FLAGS];
        if (target->IsGameMaster() && target->GetSession()->IsGMAccount())
            appendValue &= ~UNIT_FLAG_NOT_SELECTABLE;

        valuesUpdateBuf.put(posPointers.UnitFieldFlagsPos, appendValue);
    }

    // UNIT_FIELD_DISPLAYID
    // Use modelid_a if not gm, _h if gm for CREATURE_FLAG_EXTRA_TRIGGER creatures.
    if (posPointers.UnitFieldDisplayPos >= 0)
    {
        uint32 displayId = m_uint32Values[UNIT_FIELD_DISPLAYID];
        if (creature)
        {
            CreatureTemplate const* cinfo = creature->GetCreatureTemplate();

            // this also applies for transform auras
            if (SpellInfo const* transform = sSpellMgr->GetSpellInfo(getTransForm()))
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    if (transform->Effects[i].IsAura(SPELL_AURA_TRANSFORM))
                        if (CreatureTemplate const* transformInfo = sObjectMgr->GetCreatureTemplate(transform->Effects[i].MiscValue))
                        {
                            cinfo = transformInfo;
                            break;
                        }

            if (cinfo->flags_extra & CREATURE_FLAG_EXTRA_TRIGGER)
            {
                if (target->IsGameMaster() && target->GetSession()->IsGMAccount())
                {
                    displayId = cinfo->GetFirstVisibleModel()->CreatureDisplayID;
                }
                else
                {
                    displayId = cinfo->GetFirstInvisibleModel()->CreatureDisplayID;
                }
            }
        }

        valuesUpdateBuf.put(posPointers.UnitFieldDisplayPos, uint32(displayId));
    }

    // UNIT_DYNAMIC_FLAGS
    // Hide lootable animation for unallowed players.
    if (posPointers.UnitDynamicFlagsPos >= 0)
    {
        uint32 dynamicFlags = m_uint32Values[UNIT_DYNAMIC_FLAGS] & ~(UNIT_DYNFLAG_TAPPED | UNIT_DYNFLAG_TAPPED_BY_PLAYER);

        if (creature)
        {
            if (creature->hasLootRecipient())
            {
                dynamicFlags |= UNIT_DYNFLAG_TAPPED;
                if (creature->isTappedBy(target))
                    dynamicFlags |= UNIT_DYNFLAG_TAPPED_BY_PLAYER;
            }

            if (!target->isAllowedToLoot(creature))
                dynamicFlags &= ~UNIT_DYNFLAG_LOOTABLE;
        }

        // unit UNIT_DYNFLAG_TRACK_UNIT should only be sent to caster of SPELL_AURA_MOD_STALKED auras
        if (dynamicFlags & UNIT_DYNFLAG_TRACK_UNIT)
            if (!HasAuraTypeWithCaster(SPELL_AURA_MOD_STALKED, target->GetGUID()))
                dynamicFlags &= ~UNIT_DYNFLAG_TRACK_UNIT;

        valuesUpdateBuf.put(posPointers.UnitDynamicFlagsPos, dynamicFlags);
    }

    // UNIT_FIELD_BYTES_2
    if (posPointers.UnitFieldBytes2Pos >= 0)
    {
        if (IsControlledByPlayer() && target != this && sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP) && IsInRaidWith(target))
        {
            FactionTemplateEntry const* ft1 = GetFactionTemplateEntry();
            FactionTemplateEntry const* ft2 = target->GetFactionTemplateEntry();
            if (ft1 && ft2 && !ft1->IsFriendlyTo(*ft2))
                // Allow targetting opposite faction in party when enabled in config
                valuesUpdateBuf.put(posPointers.UnitFieldBytes2Pos, (m_uint32Values[UNIT_FIELD_BYTES_2] & ((UNIT_BYTE2_FLAG_SANCTUARY /*| UNIT_BYTE2_FLAG_AURAS | UNIT_BYTE2_FLAG_UNK5*/) << 8))); // this flag is at uint8 offset 1 !!
        }// pussywizard / Callmephil
        else if (target->IsSpectator() && target->FindMap() && target->FindMap()->IsBattleArena() &&
                    (this->GetTypeId() == TYPEID_PLAYER || this->GetTypeId() == TYPEID_UNIT || this->GetTypeId() == TYPEID_DYNAMICOBJECT))
        {
                valuesUpdateBuf.put(posPointers.UnitFieldBytes2Pos, (m_uint32Values[UNIT_FIELD_BYTES_2] & 0xFFFFF2FF)); // clear UNIT_BYTE2_FLAG_PVP, UNIT_BYTE2_FLAG_FFA_PVP, UNIT_BYTE2_FLAG_SANCTUARY
        }
    }

    // UNIT_FIELD_FACTIONTEMPLATE
    if (posPointers.UnitFieldFactionTemplatePos >= 0)
    {
        if (IsControlledByPlayer() && target != this && sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_INTERACTION_GROUP) && IsInRaidWith(target))
        {
            FactionTemplateEntry const* ft1 = GetFactionTemplateEntry();
            FactionTemplateEntry const* ft2 = target->GetFactionTemplateEntry();
            if (ft1 && ft2 && !ft1->IsFriendlyTo(*ft2))
                // pretend that all other HOSTILE players have own faction, to allow follow, heal, rezz (trade wont work)
                valuesUpdateBuf.put(posPointers.UnitFieldFactionTemplatePos, uint32(target->GetFaction()));
        }// pussywizard / Callmephil
        else if (target->IsSpectator() && target->FindMap() && target->FindMap()->IsBattleArena() &&
                    (this->GetTypeId() == TYPEID_PLAYER || this->GetTypeId() == TYPEID_UNIT || this->GetTypeId() == TYPEID_DYNAMICOBJECT))
        {
            valuesUpdateBuf.put(posPointers.UnitFieldFactionTemplatePos, uint32(target->GetFaction()));
        }
    }

    sScriptMgr->OnPatchValuesUpdate(this, valuesUpdateBuf, posPointers, target);
}

void Unit::BuildCooldownPacket(WorldPacket& data, uint8 flags, uint32 spellId, uint32 cooldown)
{
    data.Initialize(SMSG_SPELL_COOLDOWN, 8 + 1 + 4 + 4);
    data << GetGUID();
    data << uint8(flags);
    data << uint32(spellId);
    data << uint32(cooldown);
}

void Unit::BuildCooldownPacket(WorldPacket& data, uint8 flags, PacketCooldowns const& cooldowns)
{
    data.Initialize(SMSG_SPELL_COOLDOWN, 8 + 1 + (4 + 4) * cooldowns.size());
    data << GetGUID();
    data << uint8(flags);
    for (std::unordered_map<uint32, uint32>::const_iterator itr = cooldowns.begin(); itr != cooldowns.end(); ++itr)
    {
        data << uint32(itr->first);
        data << uint32(itr->second);
    }
}

uint8 Unit::getRace(bool original) const
{
    if (GetTypeId() == TYPEID_PLAYER)
    {
        if (original)
            return m_realRace;
        else
            return m_race;
    }

    return GetByteValue(UNIT_FIELD_BYTES_0, 0);
}

void Unit::setRace(uint8 race)
{
    if (GetTypeId() == TYPEID_PLAYER)
        m_race = race;
}

DisplayRace Unit::GetDisplayRaceFromModelId(uint32 modelId) const
{
    if (CreatureDisplayInfoEntry const* display = sCreatureDisplayInfoStore.LookupEntry(modelId))
    {
        if (CreatureDisplayInfoExtraEntry const* displayExtra = sCreatureDisplayInfoExtraStore.LookupEntry(display->ExtendedDisplayInfoID))
        {
            return DisplayRace(displayExtra->DisplayRaceID);
        }
    }
    return DisplayRace::None;
}

// Check if unit in combat with specific unit
bool Unit::IsInCombatWith(Unit const* who) const
{
    // Check target exists
    if (!who)
        return false;
    // Search in threat list
    ObjectGuid guid = who->GetGUID();
    for (ThreatContainer::StorageType::const_iterator i = m_ThreatMgr.GetThreatList().begin(); i != m_ThreatMgr.GetThreatList().end(); ++i)
    {
        HostileReference* ref = (*i);
        // Return true if the unit matches
        if (ref && ref->getUnitGuid() == guid)
            return true;
    }
    // Nothing found, false.
    return false;
}

/**
 * @brief this method gets the diameter of a Unit by DB if any value is defined, otherwise it gets the value by the DBC
 *
 * If the player is mounted the diameter also takes in consideration the mount size
 *
 * @return float The diameter of a unit
 */
float Unit::GetCollisionWidth() const
{
    if (GetTypeId() == TYPEID_PLAYER)
        return GetObjectSize();

    float scaleMod = GetObjectScale(); // 99% sure about this
    float objectSize = GetObjectSize();
    float defaultSize = DEFAULT_WORLD_OBJECT_SIZE * scaleMod;

    //! Dismounting case - use basic default model data
    CreatureDisplayInfoEntry const* displayInfo = sCreatureDisplayInfoStore.AssertEntry(GetNativeDisplayId());
    CreatureModelDataEntry const* modelData = sCreatureModelDataStore.AssertEntry(displayInfo->ModelId);

    if (IsMounted())
    {
        if (CreatureDisplayInfoEntry const* mountDisplayInfo = sCreatureDisplayInfoStore.LookupEntry(GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID)))
        {
            if (CreatureModelDataEntry const* mountModelData = sCreatureModelDataStore.LookupEntry(mountDisplayInfo->ModelId))
            {
                if (G3D::fuzzyGt(mountModelData->CollisionWidth, modelData->CollisionWidth))
                    modelData = mountModelData;
            }
        }
    }

    float collisionWidth = scaleMod * modelData->CollisionWidth * modelData->Scale * displayInfo->scale * 2;
    // if the objectSize is the default value or the creature is mounted and we have a DBC value, then we can retrieve DBC value instead
    return G3D::fuzzyGt(collisionWidth, 0.0f) && (G3D::fuzzyEq(objectSize,defaultSize) || IsMounted())  ? collisionWidth : objectSize;
}

/**
 * @brief this method gets the radius of a Unit by DB if any value is defined, otherwise it gets the value by the DBC
 *
 * If the player is mounted the radius also takes in consideration the mount size
 *
 * @return float The radius of a unit
 */
float Unit::GetCollisionRadius() const
{
    return GetCollisionWidth() / 2;
}

//! Return collision height sent to client
float Unit::GetCollisionHeight() const
{
    float scaleMod = GetObjectScale(); // 99% sure about this
    float defaultHeight = DEFAULT_COLLISION_HEIGHT * scaleMod;

    CreatureDisplayInfoEntry const* displayInfo = sCreatureDisplayInfoStore.AssertEntry(GetNativeDisplayId());
    CreatureModelDataEntry const* modelData = sCreatureModelDataStore.AssertEntry(displayInfo->ModelId);
    float collisionHeight = 0.0f;

    if (IsMounted())
    {
        if (CreatureDisplayInfoEntry const* mountDisplayInfo = sCreatureDisplayInfoStore.LookupEntry(GetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID)))
        {
            if (CreatureModelDataEntry const* mountModelData = sCreatureModelDataStore.LookupEntry(mountDisplayInfo->ModelId))
            {
                collisionHeight = scaleMod * (mountModelData->MountHeight + modelData->CollisionHeight * modelData->Scale * displayInfo->scale * 0.5f);
            }
        }
    }
    else
        collisionHeight = scaleMod * modelData->CollisionHeight * modelData->Scale * displayInfo->scale;

    return collisionHeight == 0.0f ? defaultHeight : collisionHeight;
}

void Unit::Talk(std::string_view text, ChatMsg msgType, Language language, float textRange, WorldObject const* target)
{
    Acore::CustomChatTextBuilder builder(this, msgType, text, language, target);
    Acore::LocalizedPacketDo<Acore::CustomChatTextBuilder> localizer(builder);
    Acore::PlayerDistWorker<Acore::LocalizedPacketDo<Acore::CustomChatTextBuilder> > worker(this, textRange, localizer);
    Cell::VisitWorldObjects(this, worker, textRange);
}

void Unit::Say(std::string_view text, Language language, WorldObject const* target /*= nullptr*/)
{
    Talk(text, CHAT_MSG_MONSTER_SAY, language, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), target);
}

void Unit::Yell(std::string_view text, Language language, WorldObject const* target /*= nullptr*/)
{
    Talk(text, CHAT_MSG_MONSTER_YELL, language, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_YELL), target);
}

void Unit::TextEmote(std::string_view text, WorldObject const* target /*= nullptr*/, bool isBossEmote /*= false*/)
{
    Talk(text, isBossEmote ? CHAT_MSG_RAID_BOSS_EMOTE : CHAT_MSG_MONSTER_EMOTE, LANG_UNIVERSAL, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), target);
}

void Unit::Whisper(std::string_view text, Language language, Player* target, bool isBossWhisper /*= false*/)
{
    if (!target)
    {
        return;
    }

    LocaleConstant locale = target->GetSession()->GetSessionDbLocaleIndex();
    WorldPacket data;
    ChatHandler::BuildChatPacket(data, isBossWhisper ? CHAT_MSG_RAID_BOSS_WHISPER : CHAT_MSG_MONSTER_WHISPER, language, this, target, text, 0, "", locale);
    target->SendDirectMessage(&data);
}

void Unit::Talk(uint32 textId, ChatMsg msgType, float textRange, WorldObject const* target)
{
    if (!sObjectMgr->GetBroadcastText(textId))
    {
        LOG_ERROR("entities.unit", "Unit::Talk: `broadcast_text` (ID: {}) was not found", textId);
        return;
    }

    Acore::BroadcastTextBuilder builder(this, msgType, textId, getGender(), target);
    Acore::LocalizedPacketDo<Acore::BroadcastTextBuilder> localizer(builder);
    Acore::PlayerDistWorker<Acore::LocalizedPacketDo<Acore::BroadcastTextBuilder> > worker(this, textRange, localizer);
    Cell::VisitWorldObjects(this, worker, textRange);
}

void Unit::Say(uint32 textId, WorldObject const* target /*= nullptr*/)
{
    Talk(textId, CHAT_MSG_MONSTER_SAY, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), target);
}

void Unit::Yell(uint32 textId, WorldObject const* target /*= nullptr*/)
{
    Talk(textId, CHAT_MSG_MONSTER_YELL, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_YELL), target);
}

void Unit::TextEmote(uint32 textId, WorldObject const* target /*= nullptr*/, bool isBossEmote /*= false*/)
{
    Talk(textId, isBossEmote ? CHAT_MSG_RAID_BOSS_EMOTE : CHAT_MSG_MONSTER_EMOTE, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_TEXTEMOTE), target);
}

void Unit::Whisper(uint32 textId, Player* target, bool isBossWhisper /*= false*/)
{
    if (!target)
    {
        return;
    }

    BroadcastText const* bct = sObjectMgr->GetBroadcastText(textId);
    if (!bct)
    {
        LOG_ERROR("entities.unit", "Unit::Whisper: `broadcast_text` was not {} found", textId);
        return;
    }

    LocaleConstant locale = target->GetSession()->GetSessionDbLocaleIndex();
    WorldPacket data;
    ChatHandler::BuildChatPacket(data, isBossWhisper ? CHAT_MSG_RAID_BOSS_WHISPER : CHAT_MSG_MONSTER_WHISPER, LANG_UNIVERSAL, this, target, bct->GetText(locale, getGender()), 0, "", locale);
    target->SendDirectMessage(&data);
}

bool Unit::CanRestoreMana(SpellInfo const* spellInfo) const
{
    // Aura of Despair exceptions
    switch (spellInfo->Id)
    {
        case 16666: // Demonic Rune
        case 27869: // Dark Rune
        case 30824: // Shamanistic Rage
        case 31786: // Spiritual Attunement
        case 31930: // Judgements of the Wise
        case 34075: // Aspect of the Viper
        case 34720: // Thrill of the hunt
        case 47755: // Rapture
        case 54425: // Improved Felhunter
        case 57319: // Blessing of Sanctuary
        case 63337: // Saronite Vapors (regenerate mana)
        case 63375: // Improved stormstrike
        case 64372: // Lifebloom
        case 68285: // Improved Leader of the Pack
            return true;
        case 54428: // Divine Plea - only with talent Guarded by the Light
            return HasSpell(53583);
        default:
            break;
    }

    return false;
}

bool Unit::IsInDisallowedMountForm() const
{
    if (SpellInfo const* transformSpellInfo = sSpellMgr->GetSpellInfo(getTransForm()))
    {
        if (transformSpellInfo->HasAttribute(SPELL_ATTR0_ALLOW_WHILE_MOUNTED))
        {
            return false;
        }
    }

    if (ShapeshiftForm form = GetShapeshiftForm())
    {
        SpellShapeshiftFormEntry const* shapeshift = sSpellShapeshiftFormStore.LookupEntry(form);
        if (!shapeshift)
        {
            return true;
        }

        if (!(shapeshift->flags1 & 0x1))
        {
            return true;
        }
    }

    if (GetDisplayId() == GetNativeDisplayId())
    {
        return false;
    }

    CreatureDisplayInfoEntry const* display = sCreatureDisplayInfoStore.LookupEntry(GetDisplayId());
    if (!display)
    {
        return true;
    }

    CreatureDisplayInfoExtraEntry const* displayExtra = sCreatureDisplayInfoExtraStore.LookupEntry(display->ExtendedDisplayInfoID);
    if (!displayExtra)
    {
        return true;
    }

    CreatureModelDataEntry const* model = sCreatureModelDataStore.LookupEntry(display->ModelId);
    ChrRacesEntry const* race = sChrRacesStore.LookupEntry(displayExtra->DisplayRaceID);

    if (model && !(model->HasFlag(CREATURE_MODEL_DATA_FLAGS_CAN_MOUNT)))
    {
        if (race && !(race->HasFlag(CHRRACES_FLAGS_CAN_MOUNT)))
        {
            return true;
        }
    }

    return false;
}

void Unit::SetUInt32Value(uint16 index, uint32 value)
{
    Object::SetUInt32Value(index, value);

    switch (index)
    {
        // Invalidating the cache on health change should fix an issue where the client sees dead NPCs when they are not.
        // We might also need to invalidate the cache for some other fields as well.
        case UNIT_FIELD_HEALTH:
            InvalidateValuesUpdateCache();
            break;
    }
}

std::string Unit::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << WorldObject::GetDebugInfo() << "\n"
        << std::boolalpha
        << "AliveState: " << IsAlive()
        << " UnitMovementFlags: " << GetUnitMovementFlags() << " ExtraUnitMovementFlags: " << GetExtraUnitMovementFlags()
        << " Class: " << std::to_string(getClass());
    return sstr.str();
}
