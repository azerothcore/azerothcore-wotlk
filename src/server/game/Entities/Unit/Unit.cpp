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

#include "Unit.h"
#include "AreaDefines.h"
#include "ArenaSpectator.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "CellImpl.h"
#include "CharacterCache.h"
#include "CharmInfo.h"
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
#include "Errors.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GridNotifiersImpl.h"
#include "Group.h"
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
#include "PetPackets.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Spell.h"
#include "SpellAuraDefines.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "Totem.h"
#include "TotemAI.h"
#include "Transport.h"
#include "UpdateFieldFlags.h"
#include "UpdateFields.h"
#include "Util.h"
#include "Vehicle.h"
#include "World.h"
#include "WorldPacket.h"
#include <cmath>

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

DamageInfo::DamageInfo(Unit* _attacker, Unit* _victim, uint32 _damage, SpellInfo const* _spellInfo, SpellSchoolMask _schoolMask, DamageEffectType _damageType, uint32 cleanDamage)
    : m_attacker(_attacker), m_victim(_victim), m_damage(_damage), m_spellInfo(_spellInfo), m_schoolMask(_schoolMask),
      m_damageType(_damageType), m_attackType(BASE_ATTACK), m_cleanDamage(cleanDamage), m_hitMask(0)
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
    m_cleanDamage(dmg1.m_cleanDamage + dmg1.m_cleanDamage), m_hitMask(dmg1.m_hitMask | dmg2.m_hitMask)
{
}

DamageInfo::DamageInfo(CalcDamageInfo const& dmgInfo, uint8 damageIndex)
    : m_attacker(dmgInfo.attacker), m_victim(dmgInfo.target), m_damage(dmgInfo.damages[damageIndex].damage), m_spellInfo(nullptr), m_schoolMask(SpellSchoolMask(dmgInfo.damages[damageIndex].damageSchoolMask)),
      m_damageType(DIRECT_DAMAGE), m_attackType(dmgInfo.attackType), m_absorb(dmgInfo.damages[damageIndex].absorb), m_resist(dmgInfo.damages[damageIndex].resist), m_block(dmgInfo.blocked_amount),
      m_cleanDamage(dmgInfo.cleanDamage), m_hitMask(0)
{
    switch (dmgInfo.hitOutCome)
    {
        case MELEE_HIT_MISS:
            m_hitMask |= PROC_HIT_MISS;
            break;
        case MELEE_HIT_DODGE:
            m_hitMask |= PROC_HIT_DODGE;
            break;
        case MELEE_HIT_PARRY:
            m_hitMask |= PROC_HIT_PARRY;
            break;
        case MELEE_HIT_EVADE:
            m_hitMask |= PROC_HIT_EVADE;
            break;
        case MELEE_HIT_BLOCK:
            m_hitMask |= PROC_HIT_BLOCK;
            [[fallthrough]];
        case MELEE_HIT_CRUSHING:
        case MELEE_HIT_GLANCING:
        case MELEE_HIT_NORMAL:
            m_hitMask |= PROC_HIT_NORMAL;
            break;
        case MELEE_HIT_CRIT:
            m_hitMask |= PROC_HIT_CRITICAL;
            break;
        default:
            break;
    }

    if (dmgInfo.damages[damageIndex].absorb)
        m_hitMask |= PROC_HIT_ABSORB;

    if (dmgInfo.blocked_amount)
        m_hitMask |= (dmgInfo.damages[damageIndex].damage == dmgInfo.blocked_amount) ? PROC_HIT_FULL_BLOCK : PROC_HIT_BLOCK;
}

DamageInfo::DamageInfo(SpellNonMeleeDamage const& spellNonMeleeDamage, DamageEffectType damageType, WeaponAttackType attackType, uint32 hitMask)
    : m_attacker(spellNonMeleeDamage.attacker), m_victim(spellNonMeleeDamage.target), m_damage(spellNonMeleeDamage.damage),
      m_spellInfo(spellNonMeleeDamage.spellInfo), m_schoolMask(SpellSchoolMask(spellNonMeleeDamage.schoolMask)), m_damageType(damageType),
      m_attackType(attackType), m_absorb(spellNonMeleeDamage.absorb), m_resist(spellNonMeleeDamage.resist), m_block(spellNonMeleeDamage.blocked),
      m_cleanDamage(spellNonMeleeDamage.cleanDamage), m_hitMask(hitMask)
{
    if (spellNonMeleeDamage.blocked)
        m_hitMask |= PROC_HIT_BLOCK;
    if (spellNonMeleeDamage.absorb)
        m_hitMask |= PROC_HIT_ABSORB;
}

DamageInfo::DamageInfo(SpellNonMeleeDamage const& spellNonMeleeDamage, DamageEffectType damageType, WeaponAttackType attackType, SpellMissInfo missInfo)
    : m_attacker(spellNonMeleeDamage.attacker), m_victim(spellNonMeleeDamage.target), m_damage(spellNonMeleeDamage.damage),
      m_spellInfo(spellNonMeleeDamage.spellInfo), m_schoolMask(SpellSchoolMask(spellNonMeleeDamage.schoolMask)), m_damageType(damageType),
      m_attackType(attackType), m_absorb(spellNonMeleeDamage.absorb), m_resist(spellNonMeleeDamage.resist), m_block(spellNonMeleeDamage.blocked),
      m_cleanDamage(spellNonMeleeDamage.cleanDamage), m_hitMask(PROC_HIT_NONE)
{
    // Compute hitMask from SpellMissInfo
    if (missInfo != SPELL_MISS_NONE)
    {
        switch (missInfo)
        {
            case SPELL_MISS_MISS:
                m_hitMask |= PROC_HIT_MISS;
                break;
            case SPELL_MISS_RESIST:
                m_hitMask |= PROC_HIT_FULL_RESIST;
                break;
            case SPELL_MISS_DODGE:
                m_hitMask |= PROC_HIT_DODGE;
                break;
            case SPELL_MISS_PARRY:
                m_hitMask |= PROC_HIT_PARRY;
                break;
            case SPELL_MISS_BLOCK:
                m_hitMask |= PROC_HIT_BLOCK;
                break;
            case SPELL_MISS_EVADE:
                m_hitMask |= PROC_HIT_EVADE;
                break;
            case SPELL_MISS_IMMUNE:
            case SPELL_MISS_IMMUNE2:
                m_hitMask |= PROC_HIT_IMMUNE;
                break;
            case SPELL_MISS_DEFLECT:
                m_hitMask |= PROC_HIT_DEFLECT;
                break;
            case SPELL_MISS_ABSORB:
                m_hitMask |= PROC_HIT_ABSORB;
                break;
            case SPELL_MISS_REFLECT:
                m_hitMask |= PROC_HIT_REFLECT;
                break;
            default:
                break;
        }
    }
    else
    {
        // On block
        if (spellNonMeleeDamage.blocked)
            m_hitMask |= PROC_HIT_BLOCK;
        // On absorb
        if (spellNonMeleeDamage.absorb)
            m_hitMask |= PROC_HIT_ABSORB;
        // On crit
        if (spellNonMeleeDamage.HitInfo & SPELL_HIT_TYPE_CRIT)
            m_hitMask |= PROC_HIT_CRITICAL;
        else
            m_hitMask |= PROC_HIT_NORMAL;
    }
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

uint32 DamageInfo::GetHitMask() const
{
    return m_hitMask;
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

SpellSchoolMask ProcEventInfo::GetSchoolMask() const
{
    if (_spell)
        return _spell->GetSpellInfo()->GetSchoolMask();

    if (_damageInfo)
        return _damageInfo->GetSchoolMask();

    if (_healInfo)
        return _healInfo->GetSchoolMask();

    return SPELL_SCHOOL_MASK_NONE;
}

// we can disable this warning for this since it only
// causes undefined behavior when passed to the base class constructor
#ifdef _MSC_VER
#pragma warning(disable:4355)
#endif
Unit::Unit() : WorldObject(),
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

    _dualWieldMode = DualWieldMode::AUTO;

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
        m_auraFlatModifiersGroup[i][BASE_VALUE] = 0.0f;
        m_auraFlatModifiersGroup[i][TOTAL_VALUE] = 0.0f;
        m_auraPctModifiersGroup[i][BASE_PCT] = 1.0f;
        m_auraPctModifiersGroup[i][TOTAL_PCT] = 1.0f;
    }
    // implement 50% base damage from offhand
    m_auraPctModifiersGroup[UNIT_MOD_DAMAGE_OFFHAND][TOTAL_PCT] = 0.5f;

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
    WorldObject::Update(p_time);

    if (!IsInWorld())
        return;

    // pussywizard:
    if (!IsPlayer() || (!ToPlayer()->IsBeingTeleported() && !bRequestForcedVisibilityUpdate))
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
    if (IsInCombat() && (IsPlayer() || ((IsPet() || HasUnitTypeMask(UNIT_MASK_CONTROLLABLE_GUARDIAN)) && IsControlledByPlayer())))
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
                _unit->IsCreature() && _unit->GetMotionMaster()->GetCurrentMovementGeneratorType() == ESCORT_MOTION_TYPE &&
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

        if (movespline->HasAnimation() && IsCreature() && IsAlive())
            SetAnimTier(AnimTier(movespline->GetAnimationType()));
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

    if (IsPlayer() || IsPet())
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

    if ((IsPlayer() || obj->IsPlayer()) && HasLeewayMovement() && obj->HasLeewayMovement())
        maxdist += LEEWAY_BONUS_RANGE;

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

bool Unit::IsWithinBoundaryRadius(const Unit* obj) const
{
    if (!obj || !IsInMap(obj) || !InSamePhase(obj))
        return false;

    float objBoundaryRadius = std::max(obj->GetBoundaryRadius(), MIN_MELEE_REACH);

    return IsInDist(obj, objBoundaryRadius);
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

Unit* Unit::getAttackerForHelper() const
{
    if (GetVictim() != nullptr)
        return GetVictim();

    if (!IsEngaged())
        return nullptr;

    if (!m_attackers.empty())
        return *(m_attackers.begin());

    return nullptr;
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
    if (!victim || !victim->IsAlive() || victim->IsInFlight() || (victim->IsCreature() && victim->ToCreature()->IsEvadingAttacks()))
    {
        if (absorb)
            *absorb += damage;
        damage = 0;
    }
}

uint32 Unit::DealDamage(Unit* attacker, Unit* victim, uint32 damage, CleanDamage const* cleanDamage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask, SpellInfo const* spellProto, bool durabilityLoss, bool /*allowGM*/, Spell const* damageSpell /*= nullptr*/)
{
    damage = sScriptMgr->DealDamage(attacker, victim, damage, damagetype);
    // Xinef: initialize damage done for rage calculations
    // Xinef: its rare to modify damage in hooks, however training dummy's sets damage to 0
    uint32 rage_damage = damage + ((cleanDamage != nullptr) ? cleanDamage->absorbed_damage : 0);

    //if (attacker)
    {
        if (victim->IsAIEnabled)
            victim->GetAI()->DamageTaken(attacker, damage, damagetype, damageSchoolMask);

        if (attacker && attacker->IsAIEnabled)
            attacker->GetAI()->DamageDealt(victim, damage, damagetype, damageSchoolMask);
    }

    // Hook for OnDamage Event
    sScriptMgr->OnDamage(attacker, victim, damage);

    if (victim->IsPlayer() && attacker != victim)
    {
        // Signal to pets that their owner was attacked
        Pet* pet = victim->ToPlayer()->GetPet();

        if (pet && pet->IsAlive())
            pet->AI()->OwnerAttackedBy(attacker);
    }

    //Dont deal damage to unit if .cheat god is enable.
    if (victim->IsPlayer())
    {
        if (victim->ToPlayer()->GetCommandStatus(CHEAT_GOD))
        {
            return 0;
        }
    }

    // Signal the pet it was attacked so the AI can respond if needed
    if (victim->IsCreature() && attacker != victim && victim->IsPet() && victim->IsAlive())
        victim->ToPet()->AI()->AttackedBy(attacker);

    if (damagetype != NODAMAGE)
    {
        // interrupting auras with AURA_INTERRUPT_FLAG_DAMAGE before checking !damage (absorbed damage breaks that type of auras)
        if (spellProto)
        {
            if (attacker && damagetype != DOT && spellProto->DmgClass == SPELL_DAMAGE_CLASS_MELEE && !(spellProto->GetSchoolMask() & SPELL_SCHOOL_MASK_HOLY))
                attacker->DealDamageShieldDamage(victim);

            if (!spellProto->HasAttribute(SPELL_ATTR4_REACTIVE_DAMAGE_PROC))
                victim->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TAKE_DAMAGE, spellProto->Id);
        }
        else
            victim->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_TAKE_DAMAGE, 0);

        // interrupt spells with SPELL_INTERRUPT_FLAG_ABORT_ON_DMG on absorbed damage (no dots)
        if (!damage && damagetype != DOT && cleanDamage && cleanDamage->absorbed_damage)
        {
            if (victim != attacker && victim->IsPlayer())
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

            if (attacker && shareDamageTarget->IsPlayer())
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
    if (victim->IsPlayer() && victim->ToPlayer()->duel && damage >= (health - 1))
    {
        // xinef: situation not possible earlier, just return silently.
        if (!attacker)
            return 0;

        // prevent kill only if killed in duel and killed by opponent or opponent controlled creature
        if (victim->ToPlayer()->duel->Opponent == attacker || victim->ToPlayer()->duel->Opponent->GetGUID() == attacker->GetOwnerGUID())
            damage = health - 1;

        duel_hasEnded = true;
    }
    else if (victim->IsVehicle() && damage >= (health - 1) && victim->GetCharmer() && victim->GetCharmer()->IsPlayer())
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

    if (victim->IsPlayer())
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

    // Sparring
    if (victim->CanSparringWith(attacker))
    {
        if (damage >= victim->GetHealth())
            damage = 0;

        uint32 sparringHealth = victim->GetHealth() * (victim->ToCreature()->GetSparringPct() / 100);
        if (victim->GetHealth() - damage <= sparringHealth)
            damage = 0;
    }

    if (health <= damage)
    {
        LOG_DEBUG("entities.unit", "DealDamage: victim just died");

        //if (attacker && victim->IsPlayer() && victim != attacker)
        //victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_TOTAL_DAMAGE_RECEIVED, health); // pussywizard: optimization
        Unit::Kill(attacker, victim, durabilityLoss, cleanDamage ? cleanDamage->attackType : BASE_ATTACK, spellProto, damageSpell);
    }
    else
    {
        LOG_DEBUG("entities.unit", "DealDamageAlive");

        //if (victim->IsPlayer())
        //    victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_TOTAL_DAMAGE_RECEIVED, damage); // pussywizard: optimization

        victim->ModifyHealth(- (int32)damage);

        if (damagetype == DIRECT_DAMAGE || damagetype == SPELL_DIRECT_DAMAGE)
            victim->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_DIRECT_DAMAGE, spellProto ? spellProto->Id : 0);

        if (!victim->IsPlayer())
        {
            /// @fix: Hack to avoid premature leashing
            if (damagetype != DOT && damage > 0 && !victim->GetOwnerGUID().IsPlayer() && (!spellProto || !spellProto->HasAura(SPELL_AURA_DAMAGE_SHIELD)))
                victim->ToCreature()->UpdateLeashExtensionTime();

            if (attacker && attacker != victim)
            {
                if (spellProto && victim->CanHaveThreatList() && !victim->HasUnitState(UNIT_STATE_EVADE) && !victim->IsInCombatWith(attacker))
                    victim->CombatStart(attacker, !(spellProto->AttributesEx3 & SPELL_ATTR3_SUPPRESS_TARGET_PROCS));

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

        if (attacker && attacker->IsPlayer())
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
            if (victim != attacker && victim->IsPlayer()) // does not support creature push_back
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

 /**
  * @brief Interrupt the unit cast for all the current spells
  */
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

    return CastCustomSpell(spellInfo, value, victim, triggerFlags, castItem, triggeredByAura, originalCaster);
}

SpellCastResult Unit::CastCustomSpell(SpellInfo const* spellInfo, CustomSpellValues const& value, Unit* victim, TriggerCastFlags triggerFlags, Item* castItem, AuraEffect const* triggeredByAura, ObjectGuid originalCaster)
{
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
    if (!spellInfo->HasAttribute(SPELL_ATTR4_IGNORE_DAMAGE_TAKEN_MODIFIERS) && Unit::IsDamageReducedByArmor(damageSchoolMask, spellInfo))
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
        DamageInfo dmgInfo(*damageInfo, SPELL_DIRECT_DAMAGE, BASE_ATTACK, 0);
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

    if (!victim->IsAlive() || victim->IsInFlight() || (victim->IsCreature() && victim->ToCreature()->IsEvadingAttacks()))
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
            return;
        }
    }

    for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
    {
        // only players have secondary weapon damage
        if (i > 0 && !IsPlayer())
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
        uint8 itemDamagesMask = (IsPlayer()) ? (1 << i) : 0;

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

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->damages[i].damage = 0;
            }

            damageInfo->cleanDamage = 0;
            return;
        case MELEE_HIT_MISS:
            damageInfo->HitInfo        |= HITINFO_MISS;
            damageInfo->TargetState     = VICTIMSTATE_INTACT;

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->damages[i].damage = 0;
            }
            damageInfo->cleanDamage     = 0;
            break;
        case MELEE_HIT_NORMAL:
            damageInfo->TargetState     = VICTIMSTATE_HIT;
            break;
        case MELEE_HIT_CRIT:
            {
                damageInfo->HitInfo        |= HITINFO_CRITICALHIT;
                damageInfo->TargetState     = VICTIMSTATE_HIT;
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
            damageInfo->cleanDamage = 0;

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                damageInfo->cleanDamage += damageInfo->damages[i].damage;
                damageInfo->damages[i].damage = 0;
            }
            break;
        case MELEE_HIT_DODGE:
            damageInfo->TargetState  = VICTIMSTATE_DODGE;
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
                damageInfo->blocked_amount -= remainingBlock;
            }
            break;
        }
        case MELEE_HIT_GLANCING:
        {
            damageInfo->HitInfo     |= HITINFO_GLANCING;
            damageInfo->TargetState  = VICTIMSTATE_HIT;
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

}

void Unit::DealMeleeDamage(CalcDamageInfo* damageInfo, bool durabilityLoss)
{
    Unit* victim = damageInfo->target;

    auto canTakeMeleeDamage = [&]()
    {
        return victim->IsAlive() && !victim->IsInFlight() && (!victim->IsCreature() || !victim->ToCreature()->IsEvadingAttacks());
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

    // Parry haste is enabled if it's not a creature or if the creature doesn't have the NO_PARRY_HASTEN flag.
    bool isParryHasteEnabled = !victim->IsCreature() ||
        !victim->ToCreature()->GetCreatureTemplate()->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_PARRY_HASTEN);
    if (damageInfo->TargetState == VICTIMSTATE_PARRY && isParryHasteEnabled)
    {
        // Get attack timers
        float offtime  = float(victim->getAttackTimer(OFF_ATTACK));
        float basetime = float(victim->getAttackTimer(BASE_ATTACK));
        // Reduce attack time
        if (victim->HasOffhandWeaponForAttack() && offtime < basetime)
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

    // gain rage if attack is fully blocked, dodged or parried
    if (HasActivePowerType(POWER_RAGE) && (damageInfo->TargetState == VICTIMSTATE_BLOCKS || damageInfo->TargetState == VICTIMSTATE_DODGE || damageInfo->TargetState == VICTIMSTATE_PARRY))
    {
        switch (damageInfo->attackType)
        {
            case BASE_ATTACK:
            case OFF_ATTACK:
            {
                uint32 weaponSpeedHitFactor = uint32(GetAttackTime(damageInfo->attackType) / 1000.0f * (damageInfo->attackType == BASE_ATTACK ? 3.5f : 1.75f));
                RewardRage(damageInfo->cleanDamage, weaponSpeedHitFactor, true);
                break;
            }
            default:
                break;
        }
    }

    // If this is a creature and it attacks from behind it has a probability to daze it's victim
    if ((damageInfo->damages[0].damage + damageInfo->damages[1].damage) && ((damageInfo->hitOutCome == MELEE_HIT_CRIT || damageInfo->hitOutCome == MELEE_HIT_CRUSHING || damageInfo->hitOutCome == MELEE_HIT_NORMAL || damageInfo->hitOutCome == MELEE_HIT_GLANCING) &&
                               !IsPlayer() && !ToCreature()->IsControlledByPlayer() && !victim->HasInArc(M_PI, this)
                               && (victim->IsPlayer() || !victim->ToCreature()->isWorldBoss()) && !victim->IsVehicle()))
    {
        // -probability is between 0% and 40%
        // 20% base chance
        float Probability = 20.0f;

        // there is a newbie protection, at level 10 just 7% base chance; assuming linear function
        if (victim->GetLevel() < 30)
            Probability = 0.65f * victim->GetLevel() + 0.5f;

        uint32 VictimDefense = victim->GetDefenseSkillValue();
        uint32 VictimAuraDefense = -victim->GetTotalAuraModifier(SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_CHANCE) * 25;
        uint32 AttackerMeleeSkill = GetUnitMeleeSkill();

        // xinef: fix daze mechanics
        Probability -= ((float)VictimDefense + (float)VictimAuraDefense - AttackerMeleeSkill) * 0.1428f;

        if (Probability > 40.0f)
            Probability = 40.0f;

        // Daze application
        if (sWorld->getBoolConfig(CONFIG_ENABLE_DAZE))
            if (roll_chance_f(std::max(0.0f, Probability)))
                CastSpell(victim, 1604, true);
    }

    if (IsPlayer())
    {
        DamageInfo dmgInfo(*damageInfo);
        ToPlayer()->CastItemCombatSpell(victim, damageInfo->attackType, damageInfo->procVictim, dmgInfo.GetHitMask());
    }

    // Do effect if any damage done to target
    if (damageInfo->damages[0].damage + damageInfo->damages[1].damage)
        DealDamageShieldDamage(victim);
}

void Unit::DealDamageShieldDamage(Unit* victim)
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
                armor = std::floor(AddPct(armor, -(*j)->GetAmount()));
        }

        AuraEffectList const& ResIgnoreAuras = attacker->GetAuraEffectsByType(SPELL_AURA_MOD_IGNORE_TARGET_RESIST);
        for (AuraEffectList::const_iterator j = ResIgnoreAuras.begin(); j != ResIgnoreAuras.end(); ++j)
        {
            if ((*j)->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL)
                armor = std::floor(AddPct(armor, -(*j)->GetAmount()));
        }

        // Apply Player CR_ARMOR_PENETRATION rating and buffs from stances\specializations etc.
        if (attacker->IsPlayer())
        {
            float bonusPct = 0;
            bonusPct += attacker->GetTotalAuraModifier(SPELL_AURA_MOD_ARMOR_PENETRATION_PCT, [spellInfo,attacker](AuraEffect const* aurEff)
            {
                if (aurEff->GetSpellInfo()->EquippedItemClass == -1)
                {
                    if (!spellInfo || aurEff->IsAffectedOnSpell(spellInfo) || aurEff->GetMiscValue() & spellInfo->GetSchoolMask())
                        return true;
                    else if (!aurEff->GetMiscValue() && !aurEff->HasSpellClassMask())
                        return true;
                }
                else
                {
                    if (attacker->ToPlayer()->HasItemFitToSpellRequirements(aurEff->GetSpellInfo()))
                        return true;
                }
                return false;
            });

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
    float victimResistance = static_cast<float>(victim->GetResistance(schoolMask));
    if (owner)
    {
        // Xinef: pets inherit 100% of masters penetration
        // Xinef: excluding traps
        Player const* player = owner->GetSpellModOwner();
        if (player && owner->GetEntry() != WORLD_TRIGGER)
        {
            victimResistance += static_cast<float>(player->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_TARGET_RESISTANCE, schoolMask));
            victimResistance -= static_cast<float>(player->GetSpellPenetrationItemMod());
        }
        else
            victimResistance += static_cast<float>(owner->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_TARGET_RESISTANCE, schoolMask));
    }

    victimResistance = std::max(victimResistance, 0.0f);
    if (owner)
        victimResistance += std::max(static_cast<float>(victim->GetLevel() - owner->GetLevel()) * 5.0f, 0.0f);

    float level = static_cast<float>(victim->GetLevel());
    float resistanceConstant = 0.0f;

    if (level > 60.0f)
        resistanceConstant = 150.0f + (level - 60.0f) * (level - 67.5f);
    else if (level > 20.0f)
        resistanceConstant = 50.0f + (level - 20.0f) * 2.5f;
    else
        resistanceConstant = 50.0f;

    return std::min(victimResistance / (victimResistance + resistanceConstant), 0.75f);
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
    if (!(schoolMask & SPELL_SCHOOL_MASK_NORMAL) && (!(schoolMask & SPELL_SCHOOL_MASK_HOLY) || victim->IsCreature()) && (!spellInfo || (!spellInfo->HasAttribute(SPELL_ATTR0_CU_BINARY_SPELL) && !spellInfo->HasAttribute(SPELL_ATTR4_NO_CAST_LOG))))
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
                float mult = attacker->GetTotalAuraMultiplier(SPELL_AURA_MOD_ABILITY_IGNORE_TARGET_RESIST, [schoolMask, spellInfo](AuraEffect const* aurEff)
                {
                    if (!(aurEff->GetMiscValue() & schoolMask))
                        return false;

                    if (!aurEff->IsAffectedOnSpell(spellInfo))
                        return false;

                    return true;
                });
                damageResisted -= damageResisted * (mult - 1.0f);
                mult = attacker->GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_IGNORE_TARGET_RESIST, schoolMask);
                damageResisted -= damageResisted * (mult - 1.0f);
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
        auraAbsorbMod = attacker->GetMaxPositiveAuraModifierByMiscMask(SPELL_AURA_MOD_TARGET_ABSORB_SCHOOL, schoolMask);
        auraAbsorbMod = std::max(auraAbsorbMod, float(attacker->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_TARGET_ABILITY_ABSORB_SCHOOL, [spellInfo, schoolMask](AuraEffect const* aurEff)
        {
            if (!(aurEff->GetMiscValue() & schoolMask))
                return false;

            if (!aurEff->IsAffectedOnSpell(spellInfo))
                return false;

            return true;
        })));
        RoundToInterval(auraAbsorbMod, 0.0f, 100.0f);
    }

    // We're going to call functions which can modify content of the list during iteration over it's elements
    // Let's copy the list so we can prevent iterator invalidation
    AuraEffectList vSchoolAbsorbCopy(victim->GetAuraEffectsByType(SPELL_AURA_SCHOOL_ABSORB));
    std::sort(vSchoolAbsorbCopy.begin(), vSchoolAbsorbCopy.end(), Acore::AbsorbAuraOrderPred());

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

            int32 splitDamage = (*itr)->GetAmount();

            // absorb must be smaller than the damage itself
            splitDamage = RoundToInterval(splitDamage, 0, int32(dmgInfo.GetDamage()));

            dmgInfo.AbsorbDamage(splitDamage);

            uint32 splitted = splitDamage;
            uint32 splitted_absorb = 0;
            uint32 splitted_resist = 0;

            uint32 procAttacker = 0, procVictim = 0;
            DamageInfo splittedDmgInfo(attacker, caster, splitted, spellInfo, schoolMask, dmgInfo.GetDamageType());
            splittedDmgInfo.AddHitMask(PROC_HIT_NORMAL);
            if (caster->IsImmunedToDamageOrSchool(schoolMask))
            {
                splittedDmgInfo.AddHitMask(PROC_HIT_IMMUNE);
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

            // Add absorb to hitMask if damage was absorbed
            if (splittedDmgInfo.GetAbsorb())
                splittedDmgInfo.AddHitMask(PROC_HIT_ABSORB);

            // create procs
            createProcFlags(spellInfo, BASE_ATTACK, false, procAttacker, procVictim);
            caster->ProcSkillsAndReactives(true, attacker, procVictim, splittedDmgInfo.GetHitMask(), BASE_ATTACK, spellInfo, splitted, nullptr, -1, nullptr, &splittedDmgInfo);

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
        for (AuraEffectList::iterator itr = vSplitDamagePctCopy.begin(); (itr != vSplitDamagePctCopy.end()) && (dmgInfo.GetDamage() > 0); ++itr)
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

            SpellInfo const* splitSpellInfo = (*itr)->GetSpellInfo();
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

            uint32 procAttacker = 0, procVictim = 0;
            DamageInfo splittedDmgInfo(attacker, caster, splitted, spellInfo, splitSchoolMask, dmgInfo.GetDamageType());
            splittedDmgInfo.AddHitMask(PROC_HIT_NORMAL);
            if (caster->IsImmunedToDamageOrSchool(schoolMask))
            {
                splittedDmgInfo.AddHitMask(PROC_HIT_IMMUNE);
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

            // Add absorb to hitMask if damage was absorbed
            if (splittedDmgInfo.GetAbsorb())
                splittedDmgInfo.AddHitMask(PROC_HIT_ABSORB);

            // create procs
            createProcFlags(spellInfo, BASE_ATTACK, false, procAttacker, procVictim);
            caster->ProcSkillsAndReactives(true, attacker, procVictim, splittedDmgInfo.GetHitMask(), BASE_ATTACK, spellInfo, splitted);

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
                if (healInfo.GetTarget()->m_removedAurasCount > removedAuras)
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
    const bool sittingVictim = victim->IsPlayer() && (victim->IsSitState() || victim->getStandState() == UNIT_STAND_STATE_SLEEP);

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

        // Related to sparring system. Allow attack animations even if there are no damages
        if (victim->CanSparringWith(damageInfo.attacker))
            damageInfo.HitInfo |= HITINFO_FAKE_DAMAGE;

        SendAttackStateUpdate(&damageInfo);

        _lastDamagedTargetGuid = victim->GetGUID();

        DealMeleeDamage(&damageInfo, true);

        DamageInfo dmgInfo(damageInfo);
        Unit::ProcSkillsAndAuras(damageInfo.attacker, damageInfo.target, damageInfo.procAttacker, damageInfo.procVictim, dmgInfo.GetHitMask(), dmgInfo.GetDamage(),
            damageInfo.attackType, nullptr, nullptr, -1, nullptr, &dmgInfo);

        if (IsPlayer())
            LOG_DEBUG("entities.unit", "AttackerStateUpdate: (Player) {} attacked {} for {} dmg, absorbed {}, blocked {}, resisted {}.",
                                 GetGUID().ToString(), victim->GetGUID().ToString(), dmgInfo.GetDamage(), dmgInfo.GetAbsorb(), dmgInfo.GetBlock(), dmgInfo.GetResist());
        else
            LOG_DEBUG("entities.unit", "AttackerStateUpdate: (NPC) {} attacked {} for {} dmg, absorbed {}, blocked {}, resisted {}.",
                                 GetGUID().ToString(), victim->GetGUID().ToString(), dmgInfo.GetDamage(), dmgInfo.GetAbsorb(), dmgInfo.GetBlock(), dmgInfo.GetResist());

        // Let the pet know we've started attacking someting. Handles melee attacks only
        // Spells such as auto-shot and others handled in WorldSession::HandleCastSpellOpcode
        if (IsPlayer() && !m_Controlled.empty())
            for (Unit::ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
                if (Unit* pet = *itr)
                    if (pet->IsAlive() && pet->IsCreature())
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

    for (auto const& otherAttacker: attackers)
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
    if (crit_chance < 0)
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
    if (victim->IsCreature() && victim->ToCreature()->IsEvadingAttacks())
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
    if (victim->IsPlayer() && !victim->HasInArc(M_PI, this) && !victim->HasIgnoreHitDirectionAura())
    {
        //LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: attack came from behind and victim was a player.");
    }
    // Xinef: do not allow to dodge with CREATURE_FLAG_EXTRA_NO_DODGE flag
    else if (victim->IsPlayer() || !(victim->ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_DODGE)))
    {
        // Reduce dodge chance by attacker expertise rating
        if (IsPlayer())
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
    if (!victim->HasInArc(M_PI, this) && !victim->HasIgnoreHitDirectionAura())
    {
        LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: attack came from behind.");
    }
    else
    {
        // Reduce parry chance by attacker expertise rating
        if (IsPlayer())
            parry_chance -= int32(ToPlayer()->GetExpertiseDodgeOrParryReduction(attType) * 100);
        else
            parry_chance -= GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE) * 25;

        if (victim->IsPlayer() || !(victim->ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_PARRY)))
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

        if (victim->IsPlayer() || !(victim->ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_BLOCK)))
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
            (IsPlayer() || IsPet()) &&
            !victim->IsPlayer() && !victim->IsPet() &&
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
            !(IsCreature() && ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_CRUSHING_BLOWS)))
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
        if (IsCreature() && (ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_CRIT)))
            LOG_DEBUG("entities.unit", "RollMeleeOutcomeAgainst: CRIT DISABLED)");
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
    if (!IsPlayer())
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

/**
 * @brief Send to the client SMSG_ATTACKSTOP but doesn't clear UNIT_STATE_MELEE_ATTACKING on server side
 * or interrupt spells. Unless you know exactly what you're doing, use AttackStop() or RemoveAllAttackers() instead
 */
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
        LOG_DEBUG("entities.unit", "{} {} stopped attacking {} {}", (IsPlayer() ? "Player" : "Creature"), GetGUID().ToString(), (victim->IsPlayer() ? "player" : "creature"), victim->GetGUID().ToString());
    else
        LOG_DEBUG("entities.unit", "{} {} stopped attacking", (IsPlayer() ? "Player" : "Creature"), GetGUID().ToString());
}

bool Unit::isSpellBlocked(Unit* victim, SpellInfo const* spellProto, WeaponAttackType attackType)
{
    // These spells can't be blocked
    if (spellProto && spellProto->HasAttribute(SPELL_ATTR0_NO_ACTIVE_DEFENSE))
        return false;

    if (victim->HasIgnoreHitDirectionAura() || victim->HasInArc(M_PI, this))
    {
        // Check creatures flags_extra for disable block
        if (victim->IsCreature() &&
                victim->ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_NO_BLOCK))
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
        if (!victim->HasUnitState(UNIT_STATE_STUNNED) && (victim->HasInArc(M_PI, this) || victim->HasIgnoreHitDirectionAura()))
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
        if (!victim->HasIgnoreHitDirectionAura() || spellInfo->HasAttribute(SPELL_ATTR0_CU_REQ_CASTER_BEHIND_TARGET))
        {
            // Can`t dodge from behind in PvP (but its possible in PvE)
            if (victim->IsPlayer())
            {
                canDodge = false;
            }

            // Can`t parry or block
            canParry = false;
            canBlock = false;
        }
    }

    // Check creatures flags_extra for disable parry
    if (victim->IsCreature())
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
        if (IsPlayer())
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
        if (IsPlayer())
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
    if (!victim->IsAlive() && !victim->IsPlayer())
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
    if (IsCreature() && ToCreature()->IsTrigger())
        thisLevel = std::max<int32>(thisLevel, spellInfo->SpellLevel);
    int32 levelDiff = int32(victim->getLevelForTarget(this)) - thisLevel;

    int32 MISS_CHANCE_MULTIPLIER;
    if (sWorld->getBoolConfig(CONFIG_MISS_CHANCE_MULTIPLIER_ONLY_FOR_PLAYERS) && !IsPlayer()) // keep it as it was originally (7 and 11)
    {
        MISS_CHANCE_MULTIPLIER = victim->IsPlayer() ? 7 : 11;
    }
    else
    {
        MISS_CHANCE_MULTIPLIER = sWorld->getRate(
            victim->IsPlayer()
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
        if (victim->IsPlayer())
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
    if (!victim->HasUnitState(UNIT_STATE_STUNNED) && (victim->HasInArc(M_PI, this) || victim->HasIgnoreHitDirectionAura()))
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
    if (victim->IsCreature() && victim->ToCreature()->IsEvadingAttacks() && !spell->HasAura(SPELL_AURA_CONTROL_VEHICLE)
        && !spell->HasAttribute(SPELL_ATTR0_CU_IGNORE_EVADE) && !spell->HasAttribute(SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT))
        return SPELL_MISS_EVADE;

    // Try victim reflect spell
    if (CanReflect)
    {
        int32 reflectchance = victim->GetTotalAuraModifier(SPELL_AURA_REFLECT_SPELLS);
        reflectchance += victim->GetTotalAuraModifierByMiscMask(SPELL_AURA_REFLECT_SPELLS_SCHOOL, spell->GetSchoolMask());

        if (reflectchance > 0 && roll_chance_i(reflectchance))
        {
            // Start triggers for remove charges if need (trigger only for victim, and mark as active spell)
            //ProcSkillsAndAuras(victim, PROC_FLAG_NONE, PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG, PROC_EX_REFLECT, 1, BASE_ATTACK, spell);
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
    if (victim->IsCreature() && victim->ToCreature()->IsEvadingAttacks() && !spellInfo->HasAura(SPELL_AURA_CONTROL_VEHICLE) &&
        !spellInfo->HasAttribute(SPELL_ATTR0_CU_IGNORE_EVADE) && !spellInfo->HasAttribute(SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT))
    {
        return SPELL_MISS_EVADE;
    }

    // Try victim reflect spell
    if (CanReflect)
    {
        int32 reflectchance = victim->GetTotalAuraModifier(SPELL_AURA_REFLECT_SPELLS);
        reflectchance += victim->GetTotalAuraModifierByMiscMask(SPELL_AURA_REFLECT_SPELLS_SCHOOL, spellInfo->GetSchoolMask());

        if (reflectchance > 0 && roll_chance_i(reflectchance))
        {
            // Start triggers for remove charges if need (trigger only for victim, and mark as active spell)
            //ProcSkillsAndAuras(victim, PROC_FLAG_NONE, PROC_FLAG_TAKEN_SPELL_MAGIC_DMG_CLASS_NEG, PROC_EX_REFLECT, 1, BASE_ATTACK, spell);
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
    if (IsPlayer())
    {
        // in PvP use full skill instead current skill value
        uint32 value = (target && target->IsPlayer())
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
    if (IsPlayer())
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
    else if (IsCreature())
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

    if (IsPlayer())
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

    crit += victim->GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_CHANCE_FOR_CASTER, [this](AuraEffect const* aurEff)
    {
       return GetGUID() == aurEff->GetCasterGUID();
    });

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
    if ((IsPlayer() && ToPlayer()->isMoving() && spellProto->Id != HUNTER_AUTOSHOOT) || IsNonMeleeSpellCast(false, false, true, spellProto->Id == HUNTER_AUTOSHOOT))
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

        // Blizzlike: Reset melee swing timers when performing ranged attack
        resetAttackTimer(BASE_ATTACK);
        resetAttackTimer(OFF_ATTACK);
    }
}

bool Unit::CanSparringWith(Unit const* attacker) const
{
    if (!IsCreature() || IsCharmedOwnedByPlayerOrPlayer())
        return false;

    if (!attacker)
        return false;

    if (!attacker->IsCreature() || attacker->IsCharmedOwnedByPlayerOrPlayer())
        return false;

    if (Creature const* creature = ToCreature())
        if (!creature->GetSparringPct())
            return false;

    return true;
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
            if (IsPlayer())
                ToPlayer()->SendAutoRepeatCancel(this);

        if (spell->getState() != SPELL_STATE_FINISHED)
            spell->cancel(bySelf);
        else
        {
            m_currentSpells[spellType] = nullptr;
            spell->SetReferencedFromCurrent(false);
        }

        if (IsCreature() && IsAIEnabled)
            ToCreature()->AI()->OnSpellCastFinished(spell->GetSpellInfo(), SPELL_FINISHED_CANCELED);
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

Spell* Unit::GetFirstCurrentCastingSpell() const
{
    for (uint32 i = 0; i < CURRENT_MAX_SPELL; i++)
        if (m_currentSpells[i] && m_currentSpells[i]->GetCastTimeRemaining() > 0)
            return m_currentSpells[i];

    return nullptr;
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
    if (c->GetMapId() == MAP_THE_RING_OF_VALOR)
    {
        // skip transport check, check for being below floor level
        if (this->GetPositionZ() < 28.0f)
            return false;
        if (BattlegroundMap* bgMap = c->GetMap()->ToBattlegroundMap())
            if (Battleground* bg = bgMap->GetBG())
                if (bg->GetStartTime() < 80133) // 60000ms preparation time + 20133ms elevator rise time
                    return false;
    }
    else if (c->GetMapId() == MAP_ICECROWN_CITADEL)
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
    if (IsCreature())
        ToCreature()->UpdateMovementFlags();

    if (IsFlying() || (!IsControlledByPlayer()))
        return;

    LiquidData const& liquidData = GetLiquidData();

    // remove appropriate auras if we are swimming/not swimming respectively - exact mirror of client logic
    if (liquidData.Status & MAP_LIQUID_STATUS_SWIMMING && (liquidData.Level - GetPositionZ()) > GetCollisionHeight() * 0.75f) // Shallow water at ~75% of collision height)
        RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_NOT_ABOVEWATER);
    else
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

int32 Unit::GetHighestExclusiveSameEffectSpellGroupValue(AuraEffect const* aurEff, AuraType auraType, bool checkMiscValue /*= false*/, int32 miscValue /*= 0*/) const
{
    int32 val = 0;
    SpellSpellGroupMapBounds spellGroup = sSpellMgr->GetSpellSpellGroupMapBounds(aurEff->GetSpellInfo()->GetFirstRankSpell()->Id);
    for (SpellSpellGroupMap::const_iterator itr = spellGroup.first; itr != spellGroup.second ; ++itr)
    {
        if (sSpellMgr->GetSpellGroupStackRule(itr->second) == SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT)
        {
            AuraEffectList const& auraEffList = GetAuraEffectsByType(auraType);
            for (AuraEffectList::const_iterator auraItr = auraEffList.begin(); auraItr != auraEffList.end(); ++auraItr)
            {
                if (aurEff != (*auraItr) && (!checkMiscValue || (*auraItr)->GetMiscValue() == miscValue) &&
                    sSpellMgr->IsSpellMemberOfSpellGroup((*auraItr)->GetSpellInfo()->Id, itr->second))
                {
                    // absolute value only
                    if (abs(val) < abs((*auraItr)->GetAmount()))
                        val = (*auraItr)->GetAmount();
                }
            }
        }
    }
    return val;
}

bool Unit::IsHighestExclusiveAura(Aura const* aura, bool removeOtherAuraApplications /*= false*/)
{
    for (uint32 i = 0 ; i < MAX_SPELL_EFFECTS; ++i)
        if (AuraEffect const* aurEff = aura->GetEffect(i))
            if (!IsHighestExclusiveAuraEffect(aura->GetSpellInfo(), aurEff->GetAuraType(), aurEff->GetAmount(), aura->GetEffectMask(), removeOtherAuraApplications))
                return false;

    return true;
}

bool Unit::IsHighestExclusiveAuraEffect(SpellInfo const* spellInfo, AuraType auraType, int32 effectAmount, uint8 auraEffectMask, bool removeOtherAuraApplications /*= false*/)
{
    AuraEffectList const& auras = GetAuraEffectsByType(auraType);
    for (Unit::AuraEffectList::const_iterator itr = auras.begin(); itr != auras.end();)
    {
        AuraEffect const* existingAurEff = (*itr);
        ++itr;

        if (sSpellMgr->CheckSpellGroupStackRules(spellInfo, existingAurEff->GetSpellInfo()) == SPELL_GROUP_STACK_RULE_EXCLUSIVE_HIGHEST)
        {
            int32 diff = abs(effectAmount) - abs(existingAurEff->GetAmount());
            if (!diff)
                for (int32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    diff += int32((auraEffectMask & (1 << i)) >> i) - int32((existingAurEff->GetBase()->GetEffectMask() & (1 << i)) >> i);

            if (diff > 0)
            {
                Aura const* base = existingAurEff->GetBase();
                // no removing of area auras from the original owner, as that completely cancels them
                if (removeOtherAuraApplications && (!base->IsArea() || base->GetOwner() != this))
                {
                    if (AuraApplication* aurApp = existingAurEff->GetBase()->GetApplicationOfTarget(GetGUID()))
                    {
                        bool hasMoreThanOneEffect = base->HasMoreThanOneEffectForType(auraType);
                        uint32 removedAuras = m_removedAurasCount;
                        RemoveAura(aurApp);
                        if (hasMoreThanOneEffect || m_removedAurasCount > removedAuras)
                            itr = auras.begin();
                    }
                }
            }
            else if (diff < 0)
                return false;
        }
    }

    return true;
}

Aura* Unit::_TryStackingOrRefreshingExistingAura(SpellInfo const* newAura, uint8 effMask, Unit* caster, int32* baseAmount /*= nullptr*/, Item* castItem /*= nullptr*/, ObjectGuid casterGUID /*= ObjectGuid::Empty*/, bool periodicReset /*= false*/)
{
    ASSERT(casterGUID || caster);
    if (!casterGUID)
        casterGUID = caster->GetGUID();

    // passive and Incanter's Absorption and auras with different type can stack with themselves any number of times
    if (!newAura->IsMultiSlotAura())
    {
        // check if cast item changed
        ObjectGuid castItemGUID;
        if (castItem)
            castItemGUID = castItem->GetGUID();

        // find current aura from spell and change it's stackamount, or refresh it's duration
        // Use castItemGUID for passive auras (weapon imbues) and enchant procs so they can stack from dual-wield
        bool useItemGuid = newAura->IsPassive() || newAura->HasAttribute(SPELL_ATTR0_CU_ENCHANT_PROC);
        ObjectGuid itemGuidForLookup = (useItemGuid && castItemGUID) ? castItemGUID : ObjectGuid::Empty;
        if (Aura* foundAura = GetOwnedAura(newAura->Id, newAura->HasAttribute(SPELL_ATTR0_CU_SINGLE_AURA_STACK) ? ObjectGuid::Empty : casterGUID, itemGuidForLookup, 0))
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

    _RemoveNoStackAurasDueToAura(aura, true);

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
    if (!IsAlive() && !aurSpellInfo->IsDeathPersistent() && !aurSpellInfo->IsAllowingDeadTarget() && (!IsPlayer() || !ToPlayer()->GetSession()->PlayerLoading()))
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

    _RemoveNoStackAurasDueToAura(aura, false);

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

    if (this->ToCreature() && this->ToCreature()->IsAIEnabled)
        this->ToCreature()->AI()->OnAuraRemove(aurApp, removeMode);
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

void Unit::_RemoveNoStackAurasDueToAura(Aura* aura, bool owned)
{
    //SpellInfo const* spellProto = aura->GetSpellInfo();

    // passive spell special case (only non stackable with ranks)

    // xinef: this check makes caster to have 2 area auras thanks to spec switch
    // if (spellProto->IsPassiveStackableWithRanks())
    //    return;

    ASSERT(aura);
    if (!IsHighestExclusiveAura(aura))
    {
        aura->Remove();
        return;
    }

    if (owned)
        RemoveOwnedAuras([aura](Aura const* ownedAura) { return !aura->CanStackWith(ownedAura); });
    else
        RemoveAppliedAuras([aura](AuraApplication const* appliedAura) { return !aura->CanStackWith(appliedAura->GetBase()); });
}

void Unit::_RegisterAuraEffect(AuraEffect* aurEff, bool apply)
{
    if (apply)
        m_modAuras[aurEff->GetAuraType()].push_back(aurEff);
    else
        m_modAuras[aurEff->GetAuraType()].erase(std::remove(m_modAuras[aurEff->GetAuraType()].begin(), m_modAuras[aurEff->GetAuraType()].end(), aurEff), m_modAuras[aurEff->GetAuraType()].end());
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
                                        if (aura->GetUnitOwner())
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
                    if (Aura* newAura = Aura::TryRefreshStackOrCreate(aura->GetSpellInfo(), effMask, stealer, nullptr, &baseDamage[0], nullptr, stealer->GetGUID()))
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

                        // Reset periodic timers so stolen HoTs tick properly
                        // For stolen auras we need fresh tick counters since no ticks have occurred yet
                        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                            if (AuraEffect* aurEff = newAura->GetEffect(i))
                                aurEff->ResetPeriodic(true);

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

    for (AuraMap::iterator iter = m_ownedAuras.lower_bound(spellId); iter != m_ownedAuras.upper_bound(spellId);)
    {
        if (iter->second->GetCastItemGUID() == castItemGuid)
        {
            RemoveOwnedAura(iter, AURA_REMOVE_BY_DEFAULT);
            iter = m_ownedAuras.lower_bound(spellId);
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
            if (m_removedAurasCount > removedAuras)
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
        if (aura->GetSpellInfo()->Mechanic == MECHANIC_SNARE || aura->GetSpellInfo()->HasEffectMechanic(MECHANIC_SNARE))
        {
            RemoveAura(iter);
            continue;
        }

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

bool Unit::HasAuras(SearchMethod sm, std::vector<uint32>& spellIds) const
{
    if (sm == SearchMethod::MatchAll)
    {
        for (auto const& spellId : spellIds)
            if (!HasAura(spellId))
                return false;
        return true;
    }
    else if (sm == SearchMethod::MatchAny)
    {
        for (auto const& spellId : spellIds)
            if (HasAura(spellId))
                return true;
        return false;
    }
    else
    {
        LOG_ERROR("entities.unit", "Unit::HasAuras using non-supported SearchMethod {}", sm);
        return false;
    }
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
        if ((*i)->GetBase()->CanBeSentToClient())
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
                    uint32 countMin = aura->GetMaxDuration();
                    uint32 countMax = aura->GetSpellInfo()->GetMaxDuration() + 9000;

                    if (AuraEffect const* epidemic = (*i)->GetCaster()->GetAuraEffectOfRankedSpell(49036, EFFECT_0))
                        countMax += epidemic->GetAmount();

                    if (countMin < countMax)
                    {
                        aura->SetDuration(uint32(aura->GetDuration() + 3000));
                        aura->SetMaxDuration(countMin + 3000);
                    }
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

int32 Unit::GetTotalAuraModifier(AuraType auraType, std::function<bool(AuraEffect const*)> const& predicate) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auraType);
    if (mTotalAuraList.empty())
        return 0;

    std::map<SpellGroup, int32> sameEffectSpellGroup;
    int32 modifier = 0;

    for (AuraEffect const* aurEff : mTotalAuraList)
    {
        if (predicate(aurEff))
        {
            // Check if the Aura Effect has a the Same Effect Stack Rule and if so, use the highest amount of that SpellGroup
            // If the Aura Effect does not have this Stack Rule, it returns false so we can add to the multiplier as usual
            if (!sSpellMgr->AddSameEffectStackRuleSpellGroups(aurEff->GetSpellInfo(), static_cast<uint32>(auraType), aurEff->GetAmount(), sameEffectSpellGroup))
                modifier += aurEff->GetAmount();
        }
    }

    // Add the highest of the Same Effect Stack Rule SpellGroups to the accumulator
    for (auto const& [_, amount] : sameEffectSpellGroup)
        modifier += amount;

    return modifier;
}

float Unit::GetTotalAuraMultiplier(AuraType auraType, std::function<bool(AuraEffect const*)> const& predicate) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auraType);
    if (mTotalAuraList.empty())
        return 1.0f;

    std::map<SpellGroup, int32> sameEffectSpellGroup;
    float multiplier = 1.0f;

    for (AuraEffect const* aurEff : mTotalAuraList)
    {
        if (predicate(aurEff))
        {
            // Check if the Aura Effect has a the Same Effect Stack Rule and if so, use the highest amount of that SpellGroup
            // If the Aura Effect does not have this Stack Rule, it returns false so we can add to the multiplier as usual
            if (!sSpellMgr->AddSameEffectStackRuleSpellGroups(aurEff->GetSpellInfo(), static_cast<uint32>(auraType), aurEff->GetAmount(), sameEffectSpellGroup))
                AddPct(multiplier, aurEff->GetAmount());
        }
    }

    // Add the highest of the Same Effect Stack Rule SpellGroups to the multiplier
    for (auto itr = sameEffectSpellGroup.begin(); itr != sameEffectSpellGroup.end(); ++itr)
        AddPct(multiplier, itr->second);

    return multiplier;
}

int32 Unit::GetMaxPositiveAuraModifier(AuraType auraType, std::function<bool(AuraEffect const*)> const& predicate) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auraType);
    if (mTotalAuraList.empty())
        return 0;

    int32 modifier = 0;
    for (AuraEffect const* aurEff : mTotalAuraList)
    {
        if (predicate(aurEff))
            modifier = std::max(modifier, aurEff->GetAmount());
    }

    return modifier;
}

int32 Unit::GetMaxNegativeAuraModifier(AuraType auraType, std::function<bool(AuraEffect const*)> const& predicate) const
{
    AuraEffectList const& mTotalAuraList = GetAuraEffectsByType(auraType);
    if (mTotalAuraList.empty())
        return 0;

    int32 modifier = 0;
    for (AuraEffect const* aurEff : mTotalAuraList)
    {
        if (predicate(aurEff))
            modifier = std::min(modifier, aurEff->GetAmount());
    }

    return modifier;
}

int32 Unit::GetTotalAuraModifier(AuraType auraType) const
{
    return GetTotalAuraModifier(auraType, [](AuraEffect const* /*aurEff*/) { return true; });
}

float Unit::GetTotalAuraMultiplier(AuraType auraType) const
{
    return GetTotalAuraMultiplier(auraType, [](AuraEffect const* /*aurEff*/) { return true; });
}

int32 Unit::GetMaxPositiveAuraModifier(AuraType auraType) const
{
    return GetMaxPositiveAuraModifier(auraType, [](AuraEffect const* /*aurEff*/) { return true; });
}

int32 Unit::GetMaxNegativeAuraModifier(AuraType auraType) const
{
    return GetMaxNegativeAuraModifier(auraType, [](AuraEffect const* /*aurEff*/) { return true; });
}

int32 Unit::GetTotalAuraModifierByMiscMask(AuraType auraType, uint32 miscMask) const
{
    return GetTotalAuraModifier(auraType, [miscMask](AuraEffect const* aurEff) -> bool
    {
        if ((aurEff->GetMiscValue() & miscMask) != 0)
            return true;
        return false;
    });
}

float Unit::GetTotalAuraMultiplierByMiscMask(AuraType auraType, uint32 miscMask) const
{
    return GetTotalAuraMultiplier(auraType, [miscMask](AuraEffect const* aurEff) -> bool
    {
        if ((aurEff->GetMiscValue() & miscMask) != 0)
            return true;
        return false;
    });
}

int32 Unit::GetMaxPositiveAuraModifierByMiscMask(AuraType auraType, uint32 miscMask, AuraEffect const* except /*= nullptr*/) const
{
    return GetMaxPositiveAuraModifier(auraType, [miscMask, except](AuraEffect const* aurEff) -> bool
    {
        if (except != aurEff && (aurEff->GetMiscValue() & miscMask) != 0)
            return true;
        return false;
    });
}

int32 Unit::GetMaxNegativeAuraModifierByMiscMask(AuraType auraType, uint32 miscMask) const
{
    return GetMaxNegativeAuraModifier(auraType, [miscMask](AuraEffect const* aurEff) -> bool
    {
        if ((aurEff->GetMiscValue() & miscMask) != 0)
            return true;
        return false;
    });
}

int32 Unit::GetTotalAuraModifierByMiscValue(AuraType auraType, int32 miscValue) const
{
    return GetTotalAuraModifier(auraType, [miscValue](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->GetMiscValue() == miscValue)
            return true;
        return false;
    });
}

float Unit::GetTotalAuraMultiplierByMiscValue(AuraType auraType, int32 miscValue) const
{
    return GetTotalAuraMultiplier(auraType, [miscValue](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->GetMiscValue() == miscValue)
            return true;
        return false;
    });
}

int32 Unit::GetMaxPositiveAuraModifierByMiscValue(AuraType auraType, int32 miscValue) const
{
    return GetMaxPositiveAuraModifier(auraType, [miscValue](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->GetMiscValue() == miscValue)
            return true;
        return false;
    });
}

int32 Unit::GetMaxNegativeAuraModifierByMiscValue(AuraType auraType, int32 miscValue) const
{
    return GetMaxNegativeAuraModifier(auraType, [miscValue](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->GetMiscValue() == miscValue)
            return true;
        return false;
    });
}

int32 Unit::GetTotalAuraModifierByAffectMask(AuraType auraType, SpellInfo const* affectedSpell) const
{
    return GetTotalAuraModifier(auraType, [affectedSpell](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->IsAffectedOnSpell(affectedSpell))
            return true;
        return false;
    });
}

float Unit::GetTotalAuraMultiplierByAffectMask(AuraType auraType, SpellInfo const* affectedSpell) const
{
    return GetTotalAuraMultiplier(auraType, [affectedSpell](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->IsAffectedOnSpell(affectedSpell))
            return true;
        return false;
    });
}

int32 Unit::GetMaxPositiveAuraModifierByAffectMask(AuraType auraType, SpellInfo const* affectedSpell) const
{
    return GetMaxPositiveAuraModifier(auraType, [affectedSpell](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->IsAffectedOnSpell(affectedSpell))
            return true;
        return false;
    });
}

int32 Unit::GetMaxNegativeAuraModifierByAffectMask(AuraType auraType, SpellInfo const* affectedSpell) const
{
    return GetMaxNegativeAuraModifier(auraType, [affectedSpell](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->IsAffectedOnSpell(affectedSpell))
            return true;
        return false;
    });
}

void Unit::UpdateResistanceBuffModsMod(SpellSchools school)
{
    float modPos = 0.0f;
    float modNeg = 0.0f;

    // these auras are always positive
    modPos = GetMaxPositiveAuraModifierByMiscMask(SPELL_AURA_MOD_RESISTANCE_EXCLUSIVE, 1 << school);
    modPos += GetTotalAuraModifier(SPELL_AURA_MOD_RESISTANCE, [school](AuraEffect const* aurEff) -> bool
    {
        if ((aurEff->GetMiscValue() & (1 << school)) && aurEff->GetAmount() > 0)
            return true;
        return false;
    });

    modNeg = GetTotalAuraModifier(SPELL_AURA_MOD_RESISTANCE, [school](AuraEffect const* aurEff) -> bool
    {
        if ((aurEff->GetMiscValue() & (1 << school)) && aurEff->GetAmount() < 0)
            return true;
        return false;
    });

    float factor = GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_RESISTANCE_PCT, 1 << school);
    modPos *= factor;
    modNeg *= factor;

    SetFloatValue(UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + AsUnderlyingType(school), modPos);
    SetFloatValue(UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + AsUnderlyingType(school), modNeg);
}

void Unit::UpdateStatBuffMod(Stats stat)
{
    float modPos = 0.0f;
    float modNeg = 0.0f;
    float factor = 0.0f;

    UnitMods const unitMod = static_cast<UnitMods>(UNIT_MOD_STAT_START + AsUnderlyingType(stat));

    // includes value from items and enchantments
    float modValue = GetFlatModifierValue(unitMod, BASE_VALUE);
    if (modValue > 0.f)
        modPos += modValue;
    else
        modNeg += modValue;

    modPos += GetTotalAuraModifier(SPELL_AURA_MOD_STAT, [stat](AuraEffect const* aurEff) -> bool
    {
        if ((aurEff->GetMiscValue() < 0 || aurEff->GetMiscValue() == stat) && aurEff->GetAmount() > 0)
            return true;
        return false;
    });

    modNeg += GetTotalAuraModifier(SPELL_AURA_MOD_STAT, [stat](AuraEffect const* aurEff) -> bool
    {
        if ((aurEff->GetMiscValue() < 0 || aurEff->GetMiscValue() == stat) && aurEff->GetAmount() < 0)
            return true;
        return false;
    });

    factor = GetTotalAuraMultiplier(SPELL_AURA_MOD_PERCENT_STAT, [stat](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->GetMiscValue() == -1 || aurEff->GetMiscValue() == stat)
            return true;
        return false;
    });

    factor *= GetTotalAuraMultiplier(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, [stat](AuraEffect const* aurEff) -> bool
    {
        if (aurEff->GetMiscValue() == -1 || aurEff->GetMiscValue() == stat)
            return true;
        return false;
    });

    modPos *= factor;
    modNeg *= factor;

    SetFloatValue(UNIT_FIELD_POSSTAT0 + AsUnderlyingType(stat), modPos);
    SetFloatValue(UNIT_FIELD_NEGSTAT0 + AsUnderlyingType(stat), modNeg);
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

    if (IsPlayer() && gameObj->GetSpellId())
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

        if (IsPlayer())
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
            if (del)
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
        if (go)
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
    if (!IsPlayer())
        return;

    WorldPacket data(SMSG_SPELLNONMELEEDAMAGELOG, (16 + 4 + 4 + 4 + 1 + 4 + 4 + 1 + 1 + 4 + 4 + 1)); // we guess size
    // If we are in cheat mode we swap absorb with damage and set damage to 0, this way we can still debug damage but our HP bar will not drop
    uint32 damage = log->damage;
    uint32 absorb = log->absorb;
    if (log->target->IsPlayer() && log->target->ToPlayer()->GetCommandStatus(CHEAT_GOD))
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
    if (log->target->IsPlayer() && log->target->ToPlayer()->GetCommandStatus(CHEAT_GOD))
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

void Unit::ProcSkillsAndAuras(Unit* actor, Unit* victim, uint32 procAttacker, uint32 procVictim, uint32 procExtra, uint32 amount, WeaponAttackType attType, SpellInfo const* procSpellInfo, SpellInfo const* procAura, int8 procAuraEffectIndex, Spell const* procSpell, DamageInfo* damageInfo, HealInfo* healInfo, uint32 procPhase)
{
    // Handle skills and reactives for actor
    if (procAttacker && actor)
        actor->ProcSkillsAndReactives(false, victim, procAttacker, procExtra, attType, procSpellInfo, amount, procAura, procAuraEffectIndex, procSpell, damageInfo, healInfo, procPhase);

    // Handle skills and reactives for victim
    if (victim && victim->IsAlive() && procVictim)
        victim->ProcSkillsAndReactives(true, actor, procVictim, procExtra, attType, procSpellInfo, amount, procAura, procAuraEffectIndex, procSpell, damageInfo, healInfo, procPhase);

    // Handle aura procs via new proc system (TriggerAurasProcOnEvent)
    if (actor)
    {
        // Calculate spellTypeMask based on phase and actual damage/heal info
        uint32 spellTypeMask = 0;
        if (procPhase == PROC_SPELL_PHASE_CAST || procPhase == PROC_SPELL_PHASE_FINISH)
        {
            // At CAST phase, no damage/heal has occurred yet - use MASK_ALL to allow
            // procs that check for damage/heal type based on spell info (like Backlash)
            // At FINISH phase, damageInfo may be null but spell did do damage - use MASK_ALL
            // to match TrinityCore behavior (see TC Spell.cpp PROC_SPELL_PHASE_FINISH call)
            spellTypeMask = PROC_SPELL_TYPE_MASK_ALL;
        }
        else if (healInfo && healInfo->GetHeal())
            spellTypeMask = PROC_SPELL_TYPE_HEAL;
        else if (damageInfo && damageInfo->GetDamage())
            spellTypeMask = PROC_SPELL_TYPE_DAMAGE;
        else if (procSpellInfo)
            spellTypeMask = PROC_SPELL_TYPE_NO_DMG_HEAL;

        actor->TriggerAurasProcOnEvent(nullptr, nullptr, victim, procAttacker, procVictim, spellTypeMask, procPhase, procExtra, const_cast<Spell*>(procSpell), damageInfo, healInfo);
    }
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
                if (IsPlayer() && ToPlayer()->GetCommandStatus(CHEAT_GOD))
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
        if (damageInfo->target->IsPlayer() && damageInfo->target->ToPlayer()->GetCommandStatus(CHEAT_GOD))
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

    std::size_t const maxsize = 4 + 5 + 5 + 4 + 4 + 1 + count * (4 + 4 + 4 + 4 + 4) + 1 + 4 + 4 + 4 + 4 + 4 * 12;
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

void Unit::setPowerType(Powers new_powertype)
{
    SetByteValue(UNIT_FIELD_BYTES_0, 3, new_powertype);

    if (IsPlayer())
    {
        if (ToPlayer()->GetGroup())
            ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_POWER_TYPE);
    }
    else if (Pet* pet = ToCreature()->ToPet())
    {
        if (pet->isControlled())
        {
            Unit* owner = GetOwner();
            if (owner && (owner->IsPlayer()) && owner->ToPlayer()->GetGroup())
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
    if (IsCreature())
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
        if (IsPlayer())
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
    if (IsPlayer() && IsMounted())
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
    if (victim->IsPlayer())
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
    if (HasSpiritOfRedemptionAura())
        return false;

    // remove SPELL_AURA_MOD_UNATTACKABLE at attack (in case non-interruptible spells stun aura applied also that not let attack)
    if (HasUnattackableAura())
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

    Unit* owner = GetCharmerOrOwner();
    Creature* ownerCreature = owner ? owner->ToCreature() : nullptr;
    Creature* controlledCreatureWithSameVictim = nullptr;
    if (creature && !m_Controlled.empty())
    {
        for (ControlSet::iterator itr = m_Controlled.begin(); itr != m_Controlled.end(); ++itr)
        {
            if ((*itr)->ToCreature() && (*itr)->GetVictim() == victim)
            {
                controlledCreatureWithSameVictim = (*itr)->ToCreature();
                break;
            }
        }
    }

    // Share leash timer with controlled unit
    if (controlledCreatureWithSameVictim)
        creature->SetLastLeashExtensionTimePtr(controlledCreatureWithSameVictim->GetLastLeashExtensionTimePtr());
    // Share leash timer with owner
    else if (creature && ownerCreature && ownerCreature->GetVictim() == victim)
        creature->SetLastLeashExtensionTimePtr(ownerCreature->GetLastLeashExtensionTimePtr());
    // Update leash timer when attacking creatures
    else if (victim->IsCreature())
        victim->ToCreature()->UpdateLeashExtensionTime();

    // set position before any AI calls/assistance
    //if (IsCreature())
    //    ToCreature()->SetCombatStartPosition(GetPositionX(), GetPositionY(), GetPositionZ());
    if (creature && !(IsControllableGuardian() && IsControlledByPlayer()))
    {
        // should not let player enter combat by right clicking target - doesn't helps
        SetInCombatWith(victim);
        if (victim->IsPlayer())
            victim->SetInCombatWith(this);

        AddThreat(victim, 0.0f);

        creature->SendAIReaction(AI_REACTION_HOSTILE);

        /// @todo: Implement aggro range, detection range and assistance range templates
        if (!(creature->HasFlagsExtra(CREATURE_FLAG_EXTRA_DONT_CALL_ASSISTANCE)))
            creature->CallAssistance();

        creature->SetAssistanceTimer(sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_PERIOD));

        SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
    }

    // delay offhand weapon attack by 50% of the base attack time
    if (HasOffhandWeaponForAttack() && isAttackReady(OFF_ATTACK))
        setAttackTimer(OFF_ATTACK, std::max(getAttackTimer(OFF_ATTACK), getAttackTimer(BASE_ATTACK) + int32(CalculatePct(GetFloatValue(UNIT_FIELD_BASEATTACKTIME), 50))));

    if (meleeAttack)
        SendMeleeAttackStart(victim);

    return true;
}

/**
 * @brief Force the unit to stop attacking. This will clear UNIT_STATE_MELEE_ATTACKING,
 * Interrupt current spell, AI assistance, and call SendMeleeAttackStop() to the client
 */
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
    if (IsPlayer())
        ToPlayer()->SendAttackSwingCancelAttack();     // melee and ranged forced attack cancel
    if (Creature* pCreature = ToCreature())
        pCreature->ClearLastLeashExtensionTimePtr();
    ClearInCombat();

    // xinef: just in case
    if (IsPetInCombat() && !IsPlayer())
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

/**
 * @brief Remove all units in m_attackers list and send them AttackStop()
 */
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
                if ((*itr).second->IsRemoved())
                    continue;

                if ((*itr).second->GetSpellInfo()->CasterAuraState == flag )
                    if (AuraApplication* aurApp = (*itr).second->GetApplicationOfTarget(GetGUID()))
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
                    if ((*itr).second->GetSpellInfo()->CasterAuraState == flag )
                        if (AuraApplication* aurApp = (*itr).second->GetApplicationOfTarget(GetGUID()))
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

Creature* Unit::GetCompanionPet() const
{
    return ObjectAccessor::GetCreature(*this, m_SummonSlot[SUMMON_SLOT_MINIPET]);
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

        if (IsPlayer())
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

        if (minion->HasUnitTypeMask(UNIT_MASK_CONTROLLABLE_GUARDIAN))
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

        if (IsPlayer())
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

        if (IsPlayer())
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
                    ASSERT((*itr)->IsCreature());

                    if (!(*itr)->HasUnitTypeMask(UNIT_MASK_CONTROLLABLE_GUARDIAN))
                        continue;

                    if (AddGuidValue(UNIT_FIELD_SUMMON, (*itr)->GetGUID()))
                    {
                        // show another pet bar if there is no charm bar
                        if (IsPlayer() && !GetCharmGUID())
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
        if (unit->GetEntry() == entry && unit->IsCreature()
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
        if (unit->GetEntry() == entry && unit->IsCreature()
                && unit->ToCreature()->IsSummon()) // minion, actually
            unit->ToTempSummon()->UnSummon();
        // i think this is safe because i have never heard that a despawned minion will trigger a same minion
    }
}

void Unit::SetCharm(Unit* charm, bool apply)
{
    if (apply)
    {
        if (IsPlayer())
        {
            if (!AddGuidValue(UNIT_FIELD_CHARM, charm->GetGUID()))
                LOG_FATAL("entities.unit", "Player {} is trying to charm unit {}, but it already has a charmed unit {}", GetName(), charm->GetEntry(), GetCharmGUID().ToString());

            charm->m_ControlledByPlayer = true;
            /// @todo: maybe we can use this flag to check if controlled by player
            charm->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
        }
        else
        {
            charm->m_ControlledByPlayer = false;
            if (!HasUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED))
                charm->RemoveUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
        }

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
        charm->ClearUnitState(UNIT_STATE_CHARMED);

        if (IsPlayer())
        {
            if (!RemoveGuidValue(UNIT_FIELD_CHARM, charm->GetGUID()))
                LOG_FATAL("entities.unit", "Player {} is trying to uncharm unit {}, but it has another charmed unit {}", GetName(), charm->GetEntry(), GetCharmGUID().ToString());
        }

        if (!charm->RemoveGuidValue(UNIT_FIELD_CHARMEDBY, GetGUID()))
            LOG_FATAL("entities.unit", "Unit {} is being uncharmed, but it has another charmer {}", charm->GetEntry(), charm->GetCharmerGUID().ToString());

        if (charm->IsPlayer())
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

    if (healer && healer->IsCreature() && healer->ToCreature()->IsTotem())
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

bool RedirectSpellEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
{
    if (Unit* auraOwner = ObjectAccessor::GetUnit(_self, _auraOwnerGUID))
    {
        // Xinef: already removed
        if (!auraOwner->HasSpellMagnetAura())
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
                        queueTime = magnet->m_Events.CalculateTime((uint64)std::floor(dist / spellInfo->Speed * 1000.0f));
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
    if (IsPlayer())
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
    if (IsPlayer())
        player = ToPlayer();
    // Should we enable this also for charmed units?
    else if (IsCreature() && IsPet())
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
        setActive(true);

    m_sharedVision.push_back(player);
    player->m_isInSharedVisionOf.insert(this);
}

// only called in Player::SetSeer
void Unit::RemovePlayerFromVision(Player* player)
{
    m_sharedVision.remove(player);
    player->m_isInSharedVisionOf.erase(this);

    /// @todo: This isn't right, if a previously active object was set to active with e.g. Mind Vision this will make them no longer active
    if (m_sharedVision.empty())
        setActive(false);
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
    if (IsCreature())
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

    DoneTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, [spellProto, this, damagetype](AuraEffect const* aurEff)
    {
        // prevent apply mods from weapon specific case to non weapon specific spells (Example: thunder clap and two-handed weapon specialization)
        if (spellProto->EquippedItemClass == -1 && aurEff->GetSpellInfo()->EquippedItemClass != -1 &&
            !aurEff->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPPED_ITEM) && aurEff->GetMiscValue() == SPELL_SCHOOL_MASK_NORMAL)
        {
            return false;
    }

        if (!spellProto->ValidateAttribute6SpellDamageMods(this, aurEff, damagetype == DOT))
            return false;

        if (aurEff->GetMiscValue() & spellProto->GetSchoolMask())
        {
            if (aurEff->GetSpellInfo()->EquippedItemClass == -1)
                return true;
            else if (!aurEff->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPPED_ITEM) && (aurEff->GetSpellInfo()->EquippedItemSubClassMask == 0))
                return true;
            else if (ToPlayer() && ToPlayer()->HasItemFitToSpellRequirements(aurEff->GetSpellInfo()))
                return true;
        }
        return false;
    });

    uint32 creatureTypeMask = victim->GetCreatureTypeMask();
    DoneTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS, [creatureTypeMask, spellProto, damagetype, this](AuraEffect const* aurEff)
    {
        return creatureTypeMask & aurEff->GetMiscValue() && spellProto->ValidateAttribute6SpellDamageMods(this, aurEff, damagetype == DOT);
    });

    // bonus against aurastate
    DoneTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS_AURASTATE, [victim, spellProto, damagetype, this](AuraEffect const* aurEff)
    {
        return victim->HasAuraState(AuraStateType(aurEff->GetMiscValue())) && spellProto->ValidateAttribute6SpellDamageMods(this, aurEff, damagetype == DOT);
    });

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
                        if ((spellProto && spellProto->SpellFamilyFlags[0] & 0x2) || spellProto->SpellFamilyFlags[1] & 0x2 )
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
    if (IsCreature())
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

    // Config : RATE_CREATURE_X_SPELLDAMAGE & Do Not Modify Pet/Guardian/Mind Controlled Damage
    if (IsCreature() && (!ToCreature()->IsPet() || !ToCreature()->IsGuardian() || !ToCreature()->IsControlledByPlayer()))
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
    DoneAdvertisedBenefit += owner->GetTotalAuraModifier(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS, [spellProto](AuraEffect const* aurEff)
    {
        if (!aurEff->IsAffectedOnSpell(spellProto))
            return false;

        switch (aurEff->GetMiscValue())
        {
            case 4418: // Increased Shock Damage
            case 4554: // Increased Lightning Damage
            case 4555: // Improved Moonfire
            case 5142: // Increased Lightning Damage
            case 5147: // Improved Consecration / Libram of Resurgence
            case 5148: // Idol of the Shooting Star
            case 6008: // Increased Lightning Damage
            case 8627: // Totem of Hex
                return true;
                break;
            default:
                break;
        }

        return false;
    });

    // Custom scripted damage
    switch (spellProto->SpellFamilyName)
    {
        case SPELLFAMILY_DRUID:
        {
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
    TakenTotalMod *= GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, spellProto->GetSchoolMask());

    TakenTotalMod = processDummyAuras(TakenTotalMod);

    // From caster spells
    if (caster)
    {
        TakenTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_FROM_CASTER, [caster, spellProto](AuraEffect const* aurEff) -> bool
        {
            if (aurEff->GetCasterGUID() == caster->GetGUID() && aurEff->IsAffectedOnSpell(spellProto))
                return true;
            return false;
        });
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
    if (caster && TakenTotalMod < 1.0f && caster->HasIgnoreTargetResistAura())
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
    int32 DoneAdvertisedBenefit = GetTotalAuraModifier(SPELL_AURA_MOD_DAMAGE_DONE, [schoolMask](AuraEffect const* aurEff)
    {
       return aurEff->GetMiscValue() & schoolMask &&
                // -1 == any item class (not wand then)
                aurEff->GetSpellInfo()->EquippedItemClass == -1 &&
                // 0 == any inventory type (not wand then)
                aurEff->GetSpellInfo()->EquippedItemInventoryTypeMask == 0;
    });

    if (IsPlayer())
    {
        // Base value
        DoneAdvertisedBenefit += ToPlayer()->GetBaseSpellPowerBonus();
        DoneAdvertisedBenefit += ToPlayer()->GetBaseSpellDamageBonus();

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
        DoneAdvertisedBenefit += int32(CalculatePct(GetTotalAttackPowerValue(BASE_ATTACK), GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_SPELL_DAMAGE_OF_ATTACK_POWER, schoolMask)));
    }
    return DoneAdvertisedBenefit;
}

int32 Unit::SpellBaseDamageBonusTaken(SpellSchoolMask schoolMask, bool isDoT)
{
    return GetTotalAuraModifier(SPELL_AURA_MOD_DAMAGE_TAKEN, [schoolMask, isDoT](AuraEffect const* aurEff)
    {
        return (aurEff->GetMiscValue() & schoolMask) != 0
            // Xinef: if we have DoT damage type and aura has charges, check if it affects DoTs
            // Xinef: required for hemorrhage & rupture / garrote
            && !(isDoT && aurEff->GetBase()->IsUsingCharges() && aurEff->GetSpellInfo()->ProcFlags & PROC_FLAG_TAKEN_PERIODIC);
    });
}

float Unit::SpellDoneCritChance(Unit const* /*victim*/, SpellInfo const* spellProto, SpellSchoolMask schoolMask, WeaponAttackType attackType, bool skipEffectCheck) const
{
    // Mobs can't crit with spells.
    if (IsCreature() && !GetSpellModOwner())
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
                else if (IsPlayer())
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
                if (IsPlayer())
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
                    if (HasAttackerSpellCritChanceAura())
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
            if (IsPlayer() && (IsSitState() || getStandState() == UNIT_STAND_STATE_SLEEP))
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
        crit_chance += GetTotalAuraModifier(SPELL_AURA_MOD_CRIT_CHANCE_FOR_CASTER, [caster](AuraEffect const* aurEff)
        {
            return caster->GetGUID() == aurEff->GetCasterGUID();
        });
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
    if (IsCreature() && IsTotem())
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
    DoneTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_HEALING_DONE_PERCENT);

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
    if (IsCreature() && IsTotem())
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
    if (bonus)
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
            default:
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
    int32 TakenAdvertisedBenefit = GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_HEALING, spellProto->GetSchoolMask());

    // Nourish cast - 20% bonus if target has Rejuvenation, Regrowth, Lifebloom, or Wild Growth from caster
    // Glyph of Nourish is handled by spell_dru_nourish script
    if (spellProto->SpellFamilyName == SPELLFAMILY_DRUID && spellProto->SpellFamilyFlags[1] & 0x2000000 && caster)
    {
        AuraEffectList const& auras = GetAuraEffectsByType(SPELL_AURA_PERIODIC_HEAL);
        for (AuraEffectList::const_iterator i = auras.begin(); i != auras.end(); ++i)
        {
            if ((*i)->GetCasterGUID() == caster->GetGUID())
            {
                SpellInfo const* spell = (*i)->GetSpellInfo();
                // Rejuvenation, Regrowth, Lifebloom, or Wild Growth
                if (spell->SpellFamilyFlags.HasFlag(0x50, 0x4000010, 0))
                {
                    TakenTotalMod *= 1.2f;
                    break;
                }
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
        TakenTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_HEALING_RECEIVED, [caster, spellProto](AuraEffect const* aurEff)
        {
           return caster->GetGUID() == aurEff->GetCasterGUID() && aurEff->IsAffectedOnSpell(spellProto);
        });
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
            default:
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

    AdvertisedBenefit += GetTotalAuraModifier(SPELL_AURA_MOD_HEALING_DONE, [schoolMask](AuraEffect const* aurEff)
    {
        return !aurEff->GetMiscValue() || (aurEff->GetMiscValue() & schoolMask) != 0;
    });

    // Healing bonus of spirit, intellect and strength
    if (IsPlayer())
    {
        // Base value
        AdvertisedBenefit += ToPlayer()->GetBaseSpellPowerBonus();
        AdvertisedBenefit += ToPlayer()->GetBaseSpellHealingBonus();

        // Healing bonus from stats
        AuraEffectList const& mHealingDoneOfStatPercent = GetAuraEffectsByType(SPELL_AURA_MOD_SPELL_HEALING_OF_STAT_PERCENT);
        for (AuraEffectList::const_iterator i = mHealingDoneOfStatPercent.begin(); i != mHealingDoneOfStatPercent.end(); ++i)
        {
            // stat used dependent from misc value (stat index)
            Stats usedStat = Stats((*i)->GetSpellInfo()->Effects[(*i)->GetEffIndex()].MiscValue);
            AdvertisedBenefit += int32(CalculatePct(GetStat(usedStat), (*i)->GetAmount()));
        }

        // ... and attack power
        AdvertisedBenefit += int32(CalculatePct(GetTotalAttackPowerValue(BASE_ATTACK), GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_SPELL_HEALING_OF_ATTACK_POWER, schoolMask)));
    }
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
        if ((itr->type & meleeSchoolMask) == meleeSchoolMask)
            return true;

    return false;
}

bool Unit::IsImmunedToDamage(SpellInfo const* spellInfo) const
{
    if (!spellInfo)
    {
        return false;
    }

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasSpiritOfRedemptionAura())
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
        if ((itr->type & schoolMask) == schoolMask)
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

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasSpiritOfRedemptionAura())
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
        if ((itr->type & meleeSchoolMask) == meleeSchoolMask)
            return true;

    return false;
}

bool Unit::IsImmunedToSchool(SpellInfo const* spellInfo) const
{
    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasSpiritOfRedemptionAura())
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
            if ((itr->type & schoolMask) == schoolMask && !spellInfo->CanPierceImmuneAura(sSpellMgr->GetSpellInfo(itr->spellId)))
                return true;
    }

    return false;
}

bool Unit::IsImmunedToSchool(Spell const* spell) const
{
    SpellInfo const* spellInfo = spell->GetSpellInfo();
    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasSpiritOfRedemptionAura())
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

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasSpiritOfRedemptionAura())
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

    if (spellInfo->HasAttribute(SPELL_ATTR0_NO_IMMUNITIES) && !HasSpiritOfRedemptionAura())
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

    if (IsCreature())
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
    DoneFlatBenefit += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_DAMAGE_DONE_CREATURE, creatureTypeMask);

    // ..done
    // SPELL_AURA_MOD_DAMAGE_DONE included in weapon damage

    // ..done (base at attack power for marked target and base at attack power for creature type)
    int32 APbonus = 0;

    if (attType == RANGED_ATTACK)
    {
        APbonus += victim->GetTotalAuraModifier(SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS);

        // ..done (base at attack power and creature type)
        APbonus += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_RANGED_ATTACK_POWER_VERSUS, creatureTypeMask);
    }
    else
    {
        APbonus += victim->GetTotalAuraModifier(SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS);

        // ..done (base at attack power and creature type)
        APbonus += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_MELEE_ATTACK_POWER_VERSUS, creatureTypeMask);
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
        DoneTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, [spellProto, this, damageSchoolMask](AuraEffect const* aurEff)
            {
            if (!spellProto || (spellProto->ValidateAttribute6SpellDamageMods(this, aurEff, false)))
            {
                if ((aurEff->GetMiscValue() & damageSchoolMask))
                {
                    if (aurEff->GetSpellInfo()->EquippedItemClass == -1)
                        return true;
                    else if (!aurEff->GetSpellInfo()->HasAttribute(SPELL_ATTR5_AURA_AFFECTS_NOT_JUST_REQ_EQUIPPED_ITEM) && (aurEff->GetSpellInfo()->EquippedItemSubClassMask == 0))
                        return true;
                    else if (ToPlayer() && ToPlayer()->HasItemFitToSpellRequirements(aurEff->GetSpellInfo()))
                        return true;
                }
            }
            return false;
        });
    }

    DoneTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS, [creatureTypeMask, spellProto, this](AuraEffect const* aurEff)
    {
        return (creatureTypeMask & aurEff->GetMiscValue() && (!spellProto || spellProto->ValidateAttribute6SpellDamageMods(this, aurEff, false)));
    });

    // bonus against aurastate
    DoneTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_DONE_VERSUS_AURASTATE, [victim, spellProto, this](AuraEffect const* aurEff)
    {
        return (victim->HasAuraState(AuraStateType(aurEff->GetMiscValue())) && (!spellProto || spellProto->ValidateAttribute6SpellDamageMods(this, aurEff, false)));
    });

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
    TakenFlatBenefit += GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_DAMAGE_TAKEN, damageSchoolMask);

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
        TakenTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_FROM_CASTER, [attacker, spellProto](AuraEffect const* aurEff)
        {
            return attacker->GetGUID() == aurEff->GetCasterGUID() && aurEff->IsAffectedOnSpell(spellProto);
        });

        // Mod damage from spell mechanic
        uint32 mechanicMask = spellProto->GetAllEffectsMechanicMask();

        // Shred, Maul - "Effects which increase Bleed damage also increase Shred damage"
        if (spellProto->SpellFamilyName == SPELLFAMILY_DRUID && spellProto->SpellFamilyFlags[0] & 0x00008800)
            mechanicMask |= (1 << MECHANIC_BLEED);

        if (mechanicMask)
        {
            TakenTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_MECHANIC_DAMAGE_TAKEN_PERCENT, [mechanicMask](AuraEffect const* aurEff) -> bool
            {
                if (mechanicMask & uint32(1 << (aurEff->GetMiscValue())))
                    return true;
                return false;
            });
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
        TakenTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_MELEE_DAMAGE_TAKEN_PCT);
    }
    else
    {
        TakenTotalMod *= GetTotalAuraMultiplier(SPELL_AURA_MOD_RANGED_DAMAGE_TAKEN_PCT);
    }

    // No positive taken bonus, custom attr
    if (spellProto)
        if (spellProto->HasAttribute(SPELL_ATTR0_CU_NO_POSITIVE_TAKEN_BONUS) && TakenTotalMod > 1.0f)
        {
            TakenFlatBenefit = 0;
            TakenTotalMod = 1.0f;
        }

    // xinef: sanctified wrath talent
    if (TakenTotalMod < 1.0f && attacker->HasIgnoreTargetResistAura())
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
    else if (HasOffhandWeaponForAttack() && isAttackReady(OFF_ATTACK))
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

    return (WeaponSpeed * PPM) / 600.0f;   // result is chance in percents (probability = Speed_in_sec * (PPM / 60))
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
                player->SendDirectMessage(&data);

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
            if (charm->IsCreature())
                charm->SetUnitFlag(UNIT_FLAG_STUNNED);

        WorldPacket data(SMSG_MOVE_SET_COLLISION_HGT, GetPackGUID().size() + 4 + 4);
        data << GetPackGUID();
        data << player->GetSession()->GetOrderCounter(); // movement counter
        data << player->GetCollisionHeight();
        player->SendDirectMessage(&data);
        player->GetSession()->IncrementOrderCounter();
    }

    RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_MOUNT);
}

void Unit::Dismount()
{
    if (!IsMounted())
        return;

    SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID, 0);
    RemoveUnitFlag(UNIT_FLAG_MOUNT);

    if (Player* player = ToPlayer())
    {
        WorldPacket data(SMSG_MOVE_SET_COLLISION_HGT, GetPackGUID().size() + 4 + 4);
        data << GetPackGUID();
        data << player->GetSession()->GetOrderCounter(); // movement counter
        data << player->GetCollisionHeight();
        player->SendDirectMessage(&data);
        player->GetSession()->IncrementOrderCounter();
    }

    WorldPacket data(SMSG_DISMOUNT, 8);
    data << GetPackGUID();
    SendMessageToSet(&data, true);

    // dismount as a vehicle
    if (IsPlayer() && GetVehicleKit())
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
            if (charm->IsCreature() && !charm->HasUnitState(UNIT_STATE_STUNNED))
                charm->RemoveUnitFlag(UNIT_FLAG_STUNNED);
    }
}

void Unit::SetInCombatWith(Unit* enemy, uint32 duration)
{
    // Xinef: Dont allow to start combat with triggers
    if (enemy->IsCreature() && enemy->ToCreature()->IsTrigger())
        return;

    Unit* eOwner = enemy->GetCharmerOrOwnerOrSelf();
    if (eOwner->IsPvP() || eOwner->IsFFAPvP())
    {
        SetInCombatState(true, enemy, duration);
        return;
    }

    // check for duel
    if (eOwner->IsPlayer() && eOwner->ToPlayer()->duel)
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
    if (victim->IsCreature() && victim->ToCreature()->IsTrigger())
        return;

    if (initialAggro)
    {
        // Make player victim stand up automatically
        if (victim->getStandState() && victim->IsPlayer())
        {
            victim->SetStandState(UNIT_STAND_STATE_STAND);
        }

        if (!victim->IsInCombat() && !victim->IsPlayer() && !victim->ToCreature()->HasReactState(REACT_PASSIVE) && victim->ToCreature()->IsAIEnabled)
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

        // Update leash timer when attacking creatures
        if (victim->IsCreature() && this != victim)
            victim->ToCreature()->UpdateLeashExtensionTime();

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
    if (who->IsPlayer())
        SetContestedPvP(who->ToPlayer());

    Player* player = GetCharmerOrOwnerPlayerOrPlayerItself();
    if (player && who->IsPvP() && (!who->IsPlayer() || !player->duel || player->duel->Opponent != who))
    {
        player->UpdatePvP(true);
        player->RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_ENTER_PVP_COMBAT);
    }
}

void Unit::CombatStartOnCast(Unit* target, bool initialAggro, uint32 duration)
{
    // Xinef: Dont allow to start combat with triggers
    if (target->IsCreature() && target->ToCreature()->IsTrigger())
        return;

    if (initialAggro)
    {
        SetInCombatWith(target, duration);

        // Xinef: If pet started combat - put owner in combat
        if (Unit* owner = GetOwner())
            owner->SetInCombatWith(target, duration);

        // Update leash timer when attacking creatures
        if (target->IsCreature())
            target->ToCreature()->UpdateLeashExtensionTime();
        else if (ToCreature()) // Reset leash if it is a spell caster, else it may evade inbetween casts
            ToCreature()->UpdateLeashExtensionTime();
    }

    Unit* who = target->GetCharmerOrOwnerOrSelf();
    if (who->IsPlayer())
        SetContestedPvP(who->ToPlayer());

    Player* player = GetCharmerOrOwnerPlayerOrPlayerItself();
    if (player && who->IsPvP() && (!who->IsPlayer() || !player->duel || player->duel->Opponent != who))
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
    if (IsCreature() && enemy && IsImmuneToPC() && enemy->GetCharmerOrOwnerPlayerOrPlayerItself())
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
            creature->UpdateLeashExtensionTime();

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
        if (controlled->IsCreature() && controlled->ToCreature()->HasReactState(REACT_PASSIVE))
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

    if (IsPlayer() && ToPlayer()->IsGameMaster())
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
            || (target->IsPlayer() && target->ToPlayer()->IsGameMaster()))
        return false;

    // can't attack own vehicle or passenger
    if (m_vehicle)
        if (IsOnVehicle(target) || m_vehicle->GetBase()->IsOnVehicle(target))
            if (!IsHostileTo(target)) // pussywizard: actually can attack own vehicle or passenger if it's hostile to us - needed for snobold in Gormok encounter
                return false;

    // can't attack invisible (ignore stealth for aoe spells) also if the area being looked at is from a spell use the dynamic object created instead of the casting unit.
    //Ignore stealth if target is player and unit in combat with same player
    if ((!bySpell || !bySpell->HasAttribute(SPELL_ATTR6_IGNORE_PHASE_SHIFT)) && (obj ? !obj->CanSeeOrDetect(target, bySpell && bySpell->IsAffectingArea()) : !CanSeeOrDetect(target, (bySpell && bySpell->IsAffectingArea()) || (target->IsPlayer() && target->HasStealthAura() && target->IsInCombat() && IsInCombatWith(target)))))
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
    {
        // contested guards can attack contested PvP players even though players may be friendly
        if (!target->IsControlledByPlayer())
            return false;

        bool isContestedGuard = false;
        if (FactionTemplateEntry const* entry = GetFactionTemplateEntry())
            isContestedGuard = entry->factionFlags & FACTION_TEMPLATE_FLAG_ATTACK_PVP_ACTIVE_PLAYERS;

        bool isContestedPvp = false;
        if (Player const* player = target->GetCharmerOrOwnerPlayerOrPlayerItself())
            isContestedPvp = player->HasPlayerFlag(PLAYER_FLAGS_CONTESTED_PVP);

        if (!isContestedGuard && !isContestedPvp)
            return false;
    }

    // Not all neutral creatures can be attacked (even some unfriendly faction does not react aggresive to you, like Sporaggar)
    if (repThisToTarget == REP_NEUTRAL &&
            repTargetToThis <= REP_NEUTRAL)
    {
        Player* owner = GetAffectingPlayer();
        Unit const* const thisUnit = owner ? owner : this;
        if (!(target->IsPlayer() && thisUnit->IsPlayer()) &&
                !(target->IsCreature() && thisUnit->IsCreature()))
        {
            Player const* player = target->IsPlayer() ? target->ToPlayer() : thisUnit->ToPlayer();
            Unit const* creature = target->IsCreature() ? target : thisUnit;

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
            || (target->IsPlayer() && target->ToPlayer()->IsGameMaster()))
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
                if (IsCreature() && IsControlledByPlayer()) // not sure if good for pet
                {
                    main_speed_mod  = GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED);
                    stack_bonus     = GetTotalAuraMultiplier(SPELL_AURA_MOD_FLIGHT_SPEED_NOT_STACKING);

                    // for some spells this mod is applied on vehicle owner
                    int32 owner_speed_mod = 0;

                    if (Unit* owner = GetCharmer())
                        owner_speed_mod = owner->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED);

                    main_speed_mod = std::max(main_speed_mod, owner_speed_mod);
                }
                else if (IsMounted())
                {
                    main_speed_mod  = GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED);
                    stack_bonus     = GetTotalAuraMultiplier(SPELL_AURA_MOD_MOUNTED_FLIGHT_SPEED_ALWAYS);
                    non_stack_bonus += GetMaxPositiveAuraModifier(SPELL_AURA_MOD_FLIGHT_SPEED_MOUNTED_NOT_STACKING) / 100.0f;
                }
                else             // Use not mount (shapeshift for example) auras (should stack)
                {
                    main_speed_mod  = GetMaxPositiveAuraModifier(SPELL_AURA_MOD_INCREASE_FLIGHT_SPEED);
                    stack_bonus     = GetTotalAuraModifier(SPELL_AURA_MOD_FLIGHT_SPEED_ALWAYS);
                    non_stack_bonus += GetMaxPositiveAuraModifier(SPELL_AURA_MOD_FLIGHT_SPEED_NOT_STACKING) / 100.0f;
                }

                // Update speed for vehicle if available
                if (IsPlayer() && GetVehicle())
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
            if (IsCreature())
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
        float base_speed = (IsCreature() ? ToCreature()->GetCreatureTemplate()->speed_run : 1.0f);
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

    SpeedOpcodePair const& speedOpcodes = SetSpeed2Opc_table[mtype];

    if (forced && IsClientControlled())
    {
        Player* player = const_cast<Player*>(GetClientControlling());
        uint32 const counter = player->GetSession()->GetOrderCounter();

        // register forced speed changes for WorldSession::HandleForceSpeedChangeAck
        // and do it only for real sent packets and use run for run/mounted as client expected
        ++player->m_forced_speed_changes[mtype];

        WorldPacket data(speedOpcodes[static_cast<size_t>(SpeedOpcodeIndex::PC)], 18);
        data << GetPackGUID();
        data << counter;
        if (mtype == MOVE_RUN)
            data << uint8(0);                           // new 2.1.0

        data << GetSpeed(mtype);
        player->GetSession()->SendPacket(&data);
        player->GetSession()->IncrementOrderCounter();
    }
    else if (forced)
    {
        WorldPacket data(speedOpcodes[static_cast<size_t>(SpeedOpcodeIndex::NPC)], 12);
        data << GetPackGUID();
        data << float(GetSpeed(mtype));
        SendMessageToSet(&data, true);
    }

    if (IsPlayer())
    {
        // Xinef: update speed of pet also
        if (!IsInCombat())
        {
            Unit* pet = ToPlayer()->GetPet();
            if (!pet)
                pet = GetCharm();

            // xinef: do not affect vehicles and possesed pets
            if (pet && (pet->HasUnitFlag(UNIT_FLAG_POSSESSED) || pet->IsVehicle()))
                pet = nullptr;

            if (pet && pet->IsCreature() && !pet->IsInCombat() && pet->GetMotionMaster()->GetCurrentMovementGeneratorType() == FOLLOW_MOTION_TYPE)
                pet->UpdateSpeed(mtype, forced);

            if (Unit* critter = ObjectAccessor::GetUnit(*this, GetCritterGUID()))
                critter->UpdateSpeed(mtype, forced);
        }
        ToPlayer()->SetCanTeleport(true);
    }
}

void Unit::setDeathState(DeathState s, bool despawn)
{
    // death state needs to be updated before RemoveAllAurasOnDeath() calls HandleChannelDeathItem(..) so that
    // it can be used to check creation of death items (such as soul shards).
    m_deathState = s;

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
}

/*########################################
########                          ########
########       AGGRO SYSTEM       ########
########                          ########
########################################*/
bool Unit::CanHaveThreatList(bool skipAliveCheck) const
{
    // only creatures can have threat list
    if (!IsCreature())
        return false;

    // only alive units can have threat list
    if (!skipAliveCheck && !IsAlive())
        return false;

    // totems can not have threat list
    if (ToCreature()->IsTotem())
        return false;

    // vehicles can not have threat list
    if (ToCreature()->IsVehicle() && GetMap()->IsBattlegroundOrArena())
        return false;

    // summons can not have a threat list, unless they are controlled by a creature
    if (HasUnitTypeMask(UNIT_MASK_MINION | UNIT_MASK_GUARDIAN | UNIT_MASK_CONTROLLABLE_GUARDIAN) && ((Pet*)this)->GetOwnerGUID().IsPlayer())
        return false;

    return true;
}

//======================================================================

float Unit::ApplyTotalThreatModifier(float fThreat, SpellSchoolMask schoolMask)
{
    if (!HasThreatAura() || fThreat < 0)
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
    ASSERT(IsCreature());

    if (!taunter || (taunter->IsPlayer() && taunter->ToPlayer()->IsGameMaster()))
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
    ASSERT(IsCreature());

    if (!taunter || (taunter->IsPlayer() && taunter->ToPlayer()->IsGameMaster()))
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
        if ((*itr) && CanCreatureAttack(*itr) && !(*itr)->IsPlayer() && !(*itr)->ToCreature()->HasUnitTypeMask(UNIT_MASK_CONTROLLABLE_GUARDIAN))
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

        if ((target->IsPlayer()
                || target->ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_ALL_DIMINISH))
                && source->IsPlayer())
            duration = limitduration;
    }

    float mod = 1.0f;

    if (group == DIMINISHING_TAUNT)
    {
        if (IsCreature() && (ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_OBEYS_TAUNT_DIMINISHING_RETURNS)))
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
              && ((targetOwner ? (targetOwner->IsPlayer()) : (IsPlayer()))
                  || (IsCreature() && ToCreature()->HasFlagsExtra(CREATURE_FLAG_EXTRA_ALL_DIMINISH))))
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

void Unit::SetAnimTier(AnimTier animTier)
{
    SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER, uint8(animTier));
}

uint32 Unit::GetCreatureType() const
{
    if (IsPlayer())
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

bool Unit::HandleStatFlatModifier(UnitMods unitMod, UnitModifierFlatType modifierType, float amount, bool apply)
{
    if (unitMod >= UNIT_MOD_END || modifierType >= MODIFIER_TYPE_FLAT_END)
    {
        LOG_ERROR("entities.unit", "ERROR in HandleStatModifier(): non-existing UnitMods or wrong UnitModifierType!");
        return false;
    }

    if (!amount)
        return false;

    switch (modifierType)
    {
        case BASE_VALUE:
        case TOTAL_VALUE:
            m_auraFlatModifiersGroup[unitMod][modifierType] += apply ? amount : -amount;
            break;
        default:
            break;
    }

    UpdateUnitMod(unitMod);
    return true;
}

// Usage outside of AuraEffect Handlers is discouraged as the value will be lost when auras change. Use an Aura instead.
void Unit::ApplyStatPctModifier(UnitMods unitMod, UnitModifierPctType modifierType, float pct)
{
    if (unitMod >= UNIT_MOD_END || modifierType >= MODIFIER_TYPE_PCT_END)
    {
        LOG_ERROR("entities.unit", "ERROR in ApplyStatPctModifier(): non-existing UnitMods or wrong UnitModifierType!");
        return;
    }

    if (!pct)
        return;

    switch (modifierType)
    {
        case BASE_PCT:
        case TOTAL_PCT:
            AddPct(m_auraPctModifiersGroup[unitMod][modifierType], pct);
            break;
        default:
            break;
    }

    UpdateUnitMod(unitMod);
}

void Unit::SetStatFlatModifier(UnitMods unitMod, UnitModifierFlatType modifierType, float val)
{
    if (m_auraFlatModifiersGroup[unitMod][modifierType] == val)
        return;

    m_auraFlatModifiersGroup[unitMod][modifierType] = val;
    UpdateUnitMod(unitMod);
}

void Unit::SetStatPctModifier(UnitMods unitMod, UnitModifierPctType modifierType, float val)
{
    if (m_auraPctModifiersGroup[unitMod][modifierType] == val)
        return;

    m_auraPctModifiersGroup[unitMod][modifierType] = val;
    UpdateUnitMod(unitMod);
}

float Unit::GetFlatModifierValue(UnitMods unitMod, UnitModifierFlatType modifierType) const
{
    if (unitMod >= UNIT_MOD_END || modifierType >= MODIFIER_TYPE_FLAT_END)
    {
        LOG_ERROR("entities.unit", "attempt to access non-existing modifier value from UnitMods!");
        return 0.0f;
    }

    return m_auraFlatModifiersGroup[unitMod][modifierType];
}

float Unit::GetPctModifierValue(UnitMods unitMod, UnitModifierPctType modifierType) const
{
    if (unitMod >= UNIT_MOD_END || modifierType >= MODIFIER_TYPE_PCT_END)
    {
        LOG_ERROR("entities.unit", "attempt to access non-existing modifier value from UnitMods!");
        return 0.0f;
    }

    return m_auraPctModifiersGroup[unitMod][modifierType];
}

void Unit::UpdateUnitMod(UnitMods unitMod)
{
        if (!CanModifyStats())
        return;

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
}

void Unit::UpdateDamageDoneMods(WeaponAttackType attackType, int32 /*skipEnchantSlot = -1*/)
{
    UnitMods unitMod;
    switch (attackType)
    {
        case BASE_ATTACK:
            unitMod = UNIT_MOD_DAMAGE_MAINHAND;
            break;
        case OFF_ATTACK:
            unitMod = UNIT_MOD_DAMAGE_OFFHAND;
            break;
        case RANGED_ATTACK:
            unitMod = UNIT_MOD_DAMAGE_RANGED;
            break;
        default:
            ABORT();
            break;
    }

    float amount = GetTotalAuraModifier(SPELL_AURA_MOD_DAMAGE_DONE, [&](AuraEffect const* aurEff) -> bool
    {
        if (!(aurEff->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL))
            return false;

        return CheckAttackFitToAuraRequirement(attackType, aurEff);
    });

    SetStatFlatModifier(unitMod, TOTAL_VALUE, amount);
}

void Unit::UpdateAllDamageDoneMods()
{
    for (uint8 i = BASE_ATTACK; i < MAX_ATTACK; ++i)
        UpdateDamageDoneMods(WeaponAttackType(i));
}

void Unit::UpdateDamagePctDoneMods(WeaponAttackType attackType)
{
    float factor;
    UnitMods unitMod;
    switch (attackType)
    {
        case BASE_ATTACK:
            factor = 1.0f;
            unitMod = UNIT_MOD_DAMAGE_MAINHAND;
            break;
        case OFF_ATTACK:
            // off hand has 50% penalty
            factor = 0.5f;
            unitMod = UNIT_MOD_DAMAGE_OFFHAND;
            break;
        case RANGED_ATTACK:
            factor = 1.0f;
            unitMod = UNIT_MOD_DAMAGE_RANGED;
            break;
        default:
            ABORT();
            break;
    }

    factor *= GetTotalAuraMultiplier(SPELL_AURA_MOD_DAMAGE_PERCENT_DONE, [attackType, this](AuraEffect const* aurEff) -> bool
    {
        if (!(aurEff->GetMiscValue() & SPELL_SCHOOL_MASK_NORMAL))
            return false;

        return CheckAttackFitToAuraRequirement(attackType, aurEff);
    });

    if (attackType == OFF_ATTACK)
        factor *= GetTotalAuraMultiplier(SPELL_AURA_MOD_OFFHAND_DAMAGE_PCT, std::bind(&Unit::CheckAttackFitToAuraRequirement, this, attackType, std::placeholders::_1));

    SetStatPctModifier(unitMod, TOTAL_PCT, factor);
}

void Unit::UpdateAllDamagePctDoneMods()
{
    for (uint8 i = BASE_ATTACK; i < MAX_ATTACK; ++i)
        UpdateDamagePctDoneMods(WeaponAttackType(i));
}

float Unit::GetTotalStatValue(Stats stat, float additionalValue) const
{
    UnitMods unitMod = UnitMods(static_cast<uint16>(UNIT_MOD_STAT_START) + stat);

    if (GetPctModifierValue(unitMod, TOTAL_PCT) <= 0.0f)
        return 0.0f;

    // value = ((base_value * base_pct) + total_value) * total_pct
    float value  = GetFlatModifierValue(unitMod, BASE_VALUE) + GetCreateStat(stat);
    value *= GetPctModifierValue(unitMod, BASE_PCT);
    value += GetFlatModifierValue(unitMod, TOTAL_VALUE) + additionalValue;
    value *= GetPctModifierValue(unitMod, TOTAL_PCT);

    return value;
}

float Unit::GetTotalAuraModValue(UnitMods unitMod) const
{
    if (unitMod >= UNIT_MOD_END)
    {
        LOG_ERROR("entities.unit", "attempt to access non-existing UnitMods in GetTotalAuraModValue()!");
        return 0.0f;
    }

    if (GetPctModifierValue(unitMod, TOTAL_PCT) <= 0.0f)
        return 0.0f;

    float value = GetFlatModifierValue(unitMod, BASE_VALUE);
    value *= GetPctModifierValue(unitMod, BASE_PCT);
    value += GetFlatModifierValue(unitMod, TOTAL_VALUE);
    value *= GetPctModifierValue(unitMod, TOTAL_PCT);
    return value;
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
        if (victim)
            ap += victim->GetTotalAuraModifier(SPELL_AURA_RANGED_ATTACK_POWER_ATTACKER_BONUS);

        if (ap < 0)
            return 0.0f;
        return ap * (1.0f + GetFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER_MULTIPLIER));
    }
    else
    {
        int32 ap = GetInt32Value(UNIT_FIELD_ATTACK_POWER) + GetInt32Value(UNIT_FIELD_ATTACK_POWER_MODS);
        if (victim)
            ap += victim->GetTotalAuraModifier(SPELL_AURA_MELEE_ATTACK_POWER_ATTACKER_BONUS);

        if (ap < 0)
            return 0.0f;
        return ap * (1.0f + GetFloatValue(UNIT_FIELD_ATTACK_POWER_MULTIPLIER));
    }
}

float Unit::GetWeaponDamageRange(WeaponAttackType attType, WeaponDamageRange type, uint8 damageIndex /*= 0*/) const
{
    if (attType == OFF_ATTACK && !HasOffhandWeaponForAttack())
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
    if (IsPlayer() && ToPlayer()->GetGroup())
        ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_LEVEL);

    if (IsPlayer())
    {
        sCharacterCache->UpdateCharacterLevel(GetGUID(), lvl);
    }
}

void Unit::SetHealth(uint32 val)
{
    if (getDeathState() == DeathState::JustDied)
        val = 0;
    else if (IsPlayer() && getDeathState() == DeathState::Dead)
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
    if (IsCreature() && !(IsPet() && ToPet()->isControlled() && IsControlledByPlayer()) && (prevHealthPct < 30.0 || HealthBelowPct(30)))
    {
        UpdateSpeed(MOVE_RUN, false);
    }

    // group update
    if (IsPlayer())
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
    if (IsPlayer())
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
        return;

    uint32 maxPower = GetMaxPower(power);
    if (maxPower < val)
        val = maxPower;

    if (fromRegenerate)
    {
        UpdateUInt32Value(UNIT_FIELD_POWER1 + AsUnderlyingType(power), val);
        AddToObjectUpdateIfNeeded();
    }
    else
        SetStatInt32Value(UNIT_FIELD_POWER1 + AsUnderlyingType(power), val);

    if (withPowerUpdate)
    {
        WorldPacket data(SMSG_POWER_UPDATE, 8 + 1 + 4);
        data << GetPackGUID();
        data << uint8(power);
        data << uint32(val);
        SendMessageToSet(&data, IsPlayer());
    }

    // group update
    if (IsPlayer())
    {
        Player* player = ToPlayer();
        if (getPowerType() == power && player->NeedSendSpectatorData())
            ArenaSpectator::SendCommand_UInt32Value(FindMap(), GetGUID(), "CPW", power == POWER_RAGE || power == POWER_RUNIC_POWER ? val / 10 : val);

        if (player->GetGroup())
            player->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_CUR_POWER);
    }
    else if (Pet* pet = ToCreature()->ToPet())
    {
        if (pet->isControlled())
        {
            Unit* owner = GetOwner();
            if (owner && (owner->IsPlayer()) && owner->ToPlayer()->GetGroup())
                owner->ToPlayer()->SetGroupUpdateFlag(GROUP_UPDATE_FLAG_PET_CUR_POWER);
        }

        // Update the pet's character sheet with happiness damage bonus
        if (pet->getPetType() == HUNTER_PET && power == POWER_HAPPINESS)
            pet->UpdateDamagePhysical(BASE_ATTACK);
    }
}

void Unit::SetMaxPower(Powers power, uint32 val)
{
    uint32 cur_power = GetPower(power);
    SetStatInt32Value(static_cast<uint16>(UNIT_FIELD_MAXPOWER1) + power, val);

    // group update
    if (IsPlayer())
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
            if (owner && (owner->IsPlayer()) && owner->ToPlayer()->GetGroup())
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
            return (IsPlayer() || !((Creature const*)this)->IsPet() || ((Pet const*)this)->getPetType() != HUNTER_PET ? 0 : 100);
        case POWER_ENERGY:
            return 100;
        case POWER_HAPPINESS:
            return (IsPlayer() || !((Creature const*)this)->IsPet() || ((Pet const*)this)->getPetType() != HUNTER_PET ? 0 : 1050000);
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
    if (IsPlayer())
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

bool Unit::isFrozen() const
{
    return HasAuraState(AURA_STATE_FROZEN);
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

void Unit::ProcSkillsAndReactives(bool isVictim, Unit* target, uint32 procFlag, uint32 procExtra, WeaponAttackType attType, SpellInfo const* /*procSpellInfo*/, uint32 /*damage*/, SpellInfo const* /*procAura*/, int8 /*procAuraEffectIndex*/, Spell const* procSpell, DamageInfo* /*damageInfo*/, HealInfo* /*healInfo*/, uint32 procPhase)
{
    // Player is loaded now - do not allow passive spell casts to proc
    if (IsPlayer() && ToPlayer()->GetSession()->PlayerLoading())
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
    // Aura procs are now handled by TriggerAurasProcOnEvent called from ProcSkillsAndAuras
}

void Unit::GetProcAurasTriggeredOnEvent(AuraApplicationProcContainer& aurasTriggeringProc, std::list<AuraApplication*>* procAuras, ProcEventInfo eventInfo)
{
    TimePoint now = std::chrono::steady_clock::now();

    auto processAuraApplication = [&](AuraApplication* aurApp)
    {
        if (uint8 procEffectMask = aurApp->GetBase()->GetProcEffectMask(aurApp, eventInfo, now))
        {
            aurApp->GetBase()->PrepareProcToTrigger(aurApp, eventInfo, now);
            aurasTriggeringProc.emplace_back(procEffectMask, aurApp);
        }
        else
        {
            if (aurApp->GetBase()->GetSpellInfo()->HasAttribute(SPELL_ATTR2_PROC_COOLDOWN_ON_FAILURE))
                if (SpellProcEntry const* procEntry = sSpellMgr->GetSpellProcEntry(aurApp->GetBase()->GetId()))
                    aurApp->GetBase()->AddProcCooldown(procEntry, now);
        }
    };

    // use provided list of auras which can proc
    if (procAuras)
    {
        for (std::list<AuraApplication*>::iterator itr = procAuras->begin(); itr != procAuras->end(); ++itr)
        {
            ASSERT((*itr)->GetTarget() == this);
            if (!(*itr)->GetRemoveMode())
                processAuraApplication(*itr);
        }
    }
    // or generate one on our own
    else
    {
        for (AuraApplicationMap::iterator itr = GetAppliedAuras().begin(); itr != GetAppliedAuras().end(); ++itr)
            processAuraApplication(itr->second);
    }
}

void Unit::TriggerAurasProcOnEvent(CalcDamageInfo& damageInfo)
{
    DamageInfo dmgInfo = DamageInfo(damageInfo);
    TriggerAurasProcOnEvent(nullptr, nullptr, damageInfo.target, damageInfo.procAttacker, damageInfo.procVictim, 0, 0, dmgInfo.GetHitMask(), nullptr, &dmgInfo, nullptr);
}

void Unit::TriggerAurasProcOnEvent(std::list<AuraApplication*>* myProcAuras, std::list<AuraApplication*>* targetProcAuras, Unit* actionTarget, uint32 typeMaskActor, uint32 typeMaskActionTarget, uint32 spellTypeMask, uint32 spellPhaseMask, uint32 hitMask, Spell* spell, DamageInfo* damageInfo, HealInfo* healInfo)
{
    // prepare data for self trigger
    ProcEventInfo myProcEventInfo = ProcEventInfo(this, actionTarget, actionTarget, typeMaskActor, spellTypeMask, spellPhaseMask, hitMask, spell, damageInfo, healInfo);
    AuraApplicationProcContainer myAurasTriggeringProc;
    GetProcAurasTriggeredOnEvent(myAurasTriggeringProc, myProcAuras, myProcEventInfo);

    // needed for example for Cobra Strikes, pet does the attack, but aura is on owner
    if (Player* modOwner = GetSpellModOwner())
    {
        if (modOwner != this && spell)
        {
            std::list<AuraApplication*> modAuras;
            for (auto itr = modOwner->GetAppliedAuras().begin(); itr != modOwner->GetAppliedAuras().end(); ++itr)
            {
                if (spell->m_appliedMods.count(itr->second->GetBase()) != 0)
                    modAuras.push_back(itr->second);
            }

            if (!modAuras.empty())
                modOwner->GetProcAurasTriggeredOnEvent(myAurasTriggeringProc, &modAuras, myProcEventInfo);
        }
    }

    // prepare data for target trigger
    ProcEventInfo targetProcEventInfo = ProcEventInfo(this, actionTarget, this, typeMaskActionTarget, spellTypeMask, spellPhaseMask, hitMask, spell, damageInfo, healInfo);
    AuraApplicationProcContainer targetAurasTriggeringProc;
    if (typeMaskActionTarget && actionTarget)
        actionTarget->GetProcAurasTriggeredOnEvent(targetAurasTriggeringProc, targetProcAuras, targetProcEventInfo);

    TriggerAurasProcOnEvent(myProcEventInfo, myAurasTriggeringProc);

    if (typeMaskActionTarget && actionTarget)
        actionTarget->TriggerAurasProcOnEvent(targetProcEventInfo, targetAurasTriggeringProc);
}

void Unit::TriggerAurasProcOnEvent(ProcEventInfo& eventInfo, AuraApplicationProcContainer& aurasTriggeringProc)
{
    for (auto const& [procEffectMask, aurApp] : aurasTriggeringProc)
    {
        if (!aurApp->GetRemoveMode())
            aurApp->GetBase()->TriggerProcOnEvent(procEffectMask, aurApp, eventInfo);
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
void Unit::SendPetActionFeedback(uint8 msg) const
{
    Unit* owner = GetOwner();
    if (!owner || !owner->IsPlayer())
        return;

    WorldPacket data(SMSG_PET_ACTION_FEEDBACK, 1);
    data << uint8(msg);
    owner->ToPlayer()->SendDirectMessage(&data);
}

void Unit::SendPetActionSound(PetAction action) const
{
    SendMessageToSet(WorldPackets::Pet::PetActionSound(GetGUID(), static_cast<int32>(action)).Write(), false);
}

void Unit::SendPetDismissSound() const
{
    if (CreatureDisplayInfoEntry const* displayInfo = sCreatureDisplayInfoStore.LookupEntry(GetNativeDisplayId()))
        SendMessageToSet(WorldPackets::Pet::PetDismissSound(static_cast<int32>(displayInfo->ModelId), GetPosition()).Write(), false);
}

void Unit::SendPetAIReaction(ObjectGuid guid) const
{
    Unit* owner = GetOwner();
    if (!owner || !owner->IsPlayer())
        return;

    WorldPacket data(SMSG_AI_REACTION, 8 + 4);
    data << guid;
    data << uint32(AI_REACTION_HOSTILE);
    owner->ToPlayer()->SendDirectMessage(&data);
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

void Unit::StopMovingOnCurrentPos()
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
    if (IsRooted())
    {
        // each case where this occurs has to be examined and reported and dealt with.
        LOG_ERROR("Unit", "Attempted sending heartbeat with root flag for guid {}", GetGUID().ToString());
        return;
    }

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

bool Unit::IsStandUpOnMovementState() const
{
    uint8 s = getStandState();
    return
        s == UNIT_STAND_STATE_SIT_CHAIR || s == UNIT_STAND_STATE_SIT_LOW_CHAIR ||
        s == UNIT_STAND_STATE_SIT_MEDIUM_CHAIR || s == UNIT_STAND_STATE_SIT_HIGH_CHAIR ||
        s == UNIT_STAND_STATE_SIT || s == UNIT_STAND_STATE_SLEEP;
}

void Unit::SetStandState(uint8 state)
{
    SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_STAND_STATE, state);

    if (IsStandState())
        RemoveAurasWithInterruptFlags(AURA_INTERRUPT_FLAG_NOT_SEATED);

    if (IsPlayer())
    {
        WorldPacket data(SMSG_STANDSTATE_UPDATE, 1);
        data << (uint8)state;
        ToPlayer()->SendDirectMessage(&data);
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
    float scaleMin = IsPlayer() ? 0.1f : 0.01f;
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
    if (IsClass(CLASS_WARRIOR, CLASS_CONTEXT_ABILITY_REACTIVE) && IsPlayer())
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
    Cell::VisitObjects(this, searcher, dist);

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
    Cell::VisitObjects(this, searcher, dist);

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

void ApplyPercentModFloatVar(float& var, float val, bool apply)
{
    var *= (apply ? (100.0f + val) / 100.0f : 100.0f / (100.0f + val));
}

void Unit::ApplyAttackTimePercentMod(WeaponAttackType att, float val, bool apply)
{
    float amount = GetFloatValue(UNIT_FIELD_BASEATTACKTIME + AsUnderlyingType(att));

    float remainingTimePct = std::max((float)m_attackTimer[att], 0.0f) / (GetAttackTime(att) * m_modAttackSpeedPct[att]);
    if (val > 0.f)
    {
        ApplyPercentModFloatVar(m_modAttackSpeedPct[att], val, !apply);
        ApplyPercentModFloatVar(amount, val, !apply);
    }
    else
    {
        ApplyPercentModFloatVar(m_modAttackSpeedPct[att], -val, apply);
        ApplyPercentModFloatVar(amount, -val, apply);
    }
    SetFloatValue(UNIT_FIELD_BASEATTACKTIME + AsUnderlyingType(att), amount);
    m_attackTimer[att] = uint32(GetAttackTime(att) * m_modAttackSpeedPct[att] * remainingTimePct);
}

void Unit::ApplyCastTimePercentMod(float val, bool apply)
{
    float amount = GetFloatValue(UNIT_MOD_CAST_SPEED);

    if (val > 0.f)
        ApplyPercentModFloatVar(amount, val, !apply);
    else
        ApplyPercentModFloatVar(amount, -val, apply);

    SetFloatValue(UNIT_MOD_CAST_SPEED, amount);
}

uint32 Unit::GetCastingTimeForBonus(SpellInfo const* spellProto, DamageEffectType damagetype, uint32 CastingTime) const
{
    // Not apply this to creature casted spells with casttime == 0
    if (CastingTime == 0 && IsCreature() && !IsPet())
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
    else if (IsCreature() && IsPet())
    {
        Pet* pet = ((Pet*)this);
        if (pet->isControlled())
        {
            Unit* owner = GetOwner();
            if (owner && (owner->IsPlayer()) && owner->ToPlayer()->GetGroup())
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
    if (!normalized || !IsPlayer())
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
        Cell::VisitObjects(this, searcher, MAX_AGGRO_RADIUS);

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

void Unit::SetCantProc(bool apply)
{
    if (apply)
        ++m_procDeep;
    else
    {
        ASSERT(m_procDeep);
        --m_procDeep;
    }
}

void Unit::AddPetAura(PetAura const* petSpell)
{
    if (!IsPlayer())
        return;

    m_petAuras.insert(petSpell);
    if (Pet* pet = ToPlayer()->GetPet())
        pet->CastPetAura(petSpell);
    else if (Unit* charm = GetCharm())
        charm->CastPetAura(petSpell);
}

void Unit::RemovePetAura(PetAura const* petSpell)
{
    if (!IsPlayer())
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

    if (!owner || !owner->IsPlayer())
        return false;

    // if the owner has that pet aura, return true
    for (PetAura const* petAura : owner->m_petAuras)
        if (petAura->GetAura(GetEntry()) == aura->GetId())
            return true;

    return false;
}

Pet* Unit::CreateTamedPetFrom(Creature* creatureTarget, uint32 spell_id)
{
    if (!IsPlayer())
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
    if (!IsPlayer())
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

    if (IsPlayer())
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
            if (IsPlayer())
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
        isRewardAllowed = (creature->IsDamageEnoughForLootingAndReward() && !creature->IsLootRewardDisabled());
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
            Unit::ProcSkillsAndAuras(owner, victim, PROC_FLAG_KILL, PROC_FLAG_NONE, PROC_EX_NONE, 0, attackType, spellProto, nullptr, -1, spell);
            sScriptMgr->OnPlayerCreatureKilledByPet( killer->GetCharmerOrOwnerPlayerOrPlayerItself(), victim->ToCreature());
        }

    if (killer != victim)
    {
        Unit::ProcSkillsAndAuras(killer, victim, killer ? PROC_FLAG_KILL : 0, PROC_FLAG_KILLED, PROC_EX_NONE, 0, attackType, spellProto, nullptr, -1, spell);
    }

    // Proc auras on death - must be before aura/combat remove
    Unit::ProcSkillsAndAuras(victim, nullptr, PROC_FLAG_DEATH, PROC_FLAG_NONE, PROC_EX_NONE, 0, attackType, spellProto, nullptr, -1, spell);

    // update get killing blow achievements, must be done before setDeathState to be able to require auras on target
    // and before Spirit of Redemption as it also removes auras
    if (killer)
        if (Player* killerPlayer = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
            killerPlayer->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, victim);

    // Spirit of Redemption
    // if talent known but not triggered (check priest class for speedup check)
    bool spiritOfRedemption = false;
    if (victim->IsPlayer() && victim->IsClass(CLASS_PRIEST, CLASS_CONTEXT_ABILITY) && !victim->ToPlayer()->HasPlayerFlag(PLAYER_FLAGS_IS_OUT_OF_BOUNDS))
    {
        if (AuraEffect* aurEff = victim->GetAuraEffectDummy(20711))
        {
            // Xinef: aura_spirit_of_redemption is triggered by 27827 shapeshift
            if (victim->HasSpiritOfRedemptionAura() || victim->HasAura(27827))
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
            LOG_DEBUG("entities.unit", "We are dead, losing {} percent durability", sWorld->getRate(RATE_DURABILITY_LOSS_ON_DEATH) / 100.0f);
            plrVictim->DurabilityLossAll(sWorld->getRate(RATE_DURABILITY_LOSS_ON_DEATH) / 100.0f, false);
            // durability lost message
            plrVictim->SendDurabilityLoss();
        }
        // Call KilledUnit for creatures
        if (killer && killer->IsCreature() && killer->IsAIEnabled)
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
        if (killer && killer->IsCreature() && killer->IsAIEnabled)
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
                    if (creature->HasFlagsExtra(CREATURE_FLAG_EXTRA_INSTANCE_BIND))
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

    //if (victim->IsPlayer())
    //    if (OutdoorPvP* pvp = victim->ToPlayer()->GetOutdoorPvP())
    //        pvp->HandlePlayerActivityChangedpVictim->ToPlayer();

    // battleground things (do this at the end, so the death state flag will be properly set to handle in the bg->handlekill)
    if (player)
        if (Battleground* bg = player->GetBattleground())
        {
            if (victim->IsPlayer())
                bg->HandleKillPlayer(victim->ToPlayer(), player);
            else
                bg->HandleKillUnit(victim->ToCreature(), player);
        }

    // achievement stuff
    if (killer && victim->IsPlayer())
    {
        if (killer->IsCreature())
            victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_CREATURE, killer->GetEntry());
        else if (victim != killer && killer->IsPlayer())
            victim->ToPlayer()->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILLED_BY_PLAYER, 1, killer->ToPlayer()->GetTeamId());
    }

    // Hook for OnPVPKill Event
    if (killer)
    {
        if (Player* killerPlr = killer->ToPlayer())
        {
            if (Player* killedPlr = victim->ToPlayer())
                sScriptMgr->OnPlayerPVPKill(killerPlr, killedPlr);
            else if (Creature* killedCre = victim->ToCreature())
                sScriptMgr->OnPlayerCreatureKill(killerPlr, killedCre);
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

        if (IsPlayer())
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
                if (HasStunAura())
                    return;
                ClearUnitState(state);
                SetStunned(false);
                break;
            case UNIT_STATE_ROOT:
                // Prevent creature_template_movement rooted flag from being removed on aura expiration.
                if (IsCreature())
                {
                    if (ToCreature()->GetCreatureTemplate()->Movement.Rooted)
                    {
                        return;
                    }
                }

                if (HasRootAura() || GetVehicle())
                    return;
                ClearUnitState(state);
                SetRooted(false);
                break;
            case UNIT_STATE_CONFUSED:
                if (HasConfuseAura())
                    return;
                ClearUnitState(state);
                SetConfused(false);
                break;
            case UNIT_STATE_FLEEING:
                if (HasFearAura())
                    return;
                ClearUnitState(state);
                SetFeared(false);
                break;
            default:
                return;
        }

        //ClearUnitState(state);

        if (HasUnitState(UNIT_STATE_STUNNED) || HasStunAura())
            SetStunned(true);
        else
        {
            if (HasUnitState(UNIT_STATE_ROOT) || HasRootAura())
                SetRooted(true);

            if (HasUnitState(UNIT_STATE_CONFUSED) || HasConfuseAura())
                SetConfused(true);
            else if (HasUnitState(UNIT_STATE_FLEEING) || HasFearAura())
            {
                bool isFear = false;
                if (HasFearAura())
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
    if (IsInFlight())
        return;

    if (apply)
    {
        SetTarget();
        SetUnitFlag(UNIT_FLAG_STUNNED);

        if (IsPlayer())
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

        if (IsCreature())
        {
            // don't remove UNIT_FLAG_STUNNED for pet when owner is mounted (disabled pet's interface)
            Unit* owner = GetOwner();
            if (!owner || !owner->IsPlayer() || !owner->ToPlayer()->IsMounted())
                RemoveUnitFlag(UNIT_FLAG_STUNNED);

            // Xinef: same for charmed npcs
            owner = GetCharmer();
            if (!owner || !owner->IsPlayer() || !owner->ToPlayer()->IsMounted())
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

void Unit::SetRooted(bool apply, bool stun, bool logout)
{
    const uint32 state = (stun ? (logout ? UNIT_STATE_LOGOUT_TIMER : UNIT_STATE_STUNNED) : UNIT_STATE_ROOT);

    if (apply)
    {
        AddUnitState(state);

        SendMoveRoot(true);
    }
    else
    {
        ClearUnitState(state);

        // Prevent giving ability to move if more immobilizers are active
        if (!IsImmobilizedState())
            SendMoveRoot(false);
    }
}

void Unit::SendMoveRoot(bool apply)
{
    const Player* client = GetClientControlling();

    // Apply flags in-place when unit currently is not controlled by a player
    if (!client)
    {
        if (apply)
        {
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_MASK_MOVING_FLY);
            m_movementInfo.AddMovementFlag(MOVEMENTFLAG_ROOT);
            if (!client)
                StopMoving();
        }
        else
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_ROOT);
    }

    if (!IsInWorld())
        return;

    const PackedGuid& guid = GetPackGUID();
    // Wrath+ spline root: when unit is currently not controlled by a player
    if (!client)
    {
        WorldPacket data(apply ? SMSG_SPLINE_MOVE_ROOT : SMSG_SPLINE_MOVE_UNROOT, guid.size());
        data << guid;
        SendMessageToSet(&data, true);
    }
    // Wrath+ force root: when unit is controlled by a player
    else
    {
        uint32 const counter = client->GetSession()->GetOrderCounter();

        WorldPacket data(apply ? SMSG_FORCE_MOVE_ROOT : SMSG_FORCE_MOVE_UNROOT, guid.size() + 4);
        data << guid;
        data << counter;
        client->GetSession()->SendPacket(&data);
        client->GetSession()->IncrementOrderCounter();
    }
}

void Unit::DisableRotate(bool apply)
{
    if (!IsCreature())
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
    if (IsPlayer())
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
    if (IsPlayer())
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
    if (IsPlayer() && type != CHARM_TYPE_POSSESS)
        RemoveAurasByType(SPELL_AURA_MOUNTED);

    if (charmer->IsPlayer())
        charmer->RemoveAurasByType(SPELL_AURA_MOUNTED);

    ASSERT(type != CHARM_TYPE_POSSESS || charmer->IsPlayer());
    if (type == CHARM_TYPE_VEHICLE && !IsVehicle()) // pussywizard
        throw 1;
    ASSERT((type == CHARM_TYPE_VEHICLE) == (GetVehicleKit() && GetVehicleKit()->IsControllableVehicle()));

    LOG_DEBUG("entities.unit", "SetCharmedBy: charmer {} ({}), charmed {} ({}), type {}.",
        charmer->GetEntry(), charmer->GetGUID().ToString(), GetEntry(), GetGUID().ToString(), uint32(type));

    if (this == charmer)
    {
        LOG_FATAL("entities.unit", "Unit::SetCharmedBy: Unit {} ({}) is trying to charm itself!", GetEntry(), GetGUID().ToString());
        return false;
    }

    //if (HasUnitState(UNIT_STATE_UNATTACKABLE))
    //    return false;

    if (IsPlayer() && ToPlayer()->GetTransport())
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
    if (IsPlayer())
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

    if (IsCreature())
    {
        GetMotionMaster()->Clear(false);
        GetMotionMaster()->MoveIdle();
        StopMoving();

        if (charmer->IsPlayer() && charmer->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET_CHARM) && ToCreature()->GetCreatureTemplate()->type == CREATURE_TYPE_DEMON)
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
        if (charmer->IsPlayer() && ToCreature()->CanFly())
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
            if (type == CHARM_TYPE_CONVERT && IsCreature())
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
                if (IsCreature() && charmer->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET_CHARM))
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
    else if (IsPlayer())
        RemoveAurasByType(SPELL_AURA_MOD_SHAPESHIFT);

    AddUnitState(UNIT_STATE_CHARMED);

    if (Creature* creature = ToCreature())
        creature->RefreshSwimmingFlag();

    if (IsPlayer())
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
    if (IsCreature() && !HasUnitState(UNIT_STATE_STUNNED))
        RemoveUnitFlag(UNIT_FLAG_STUNNED);

    // If charmer still exists
    if (!charmer)
        return;

    ASSERT(type != CHARM_TYPE_POSSESS || charmer->IsPlayer());
    ASSERT(type != CHARM_TYPE_VEHICLE || (IsCreature() && IsVehicle()));

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
                if (IsCreature() && charmer->IsClass(CLASS_WARLOCK, CLASS_CONTEXT_PET_CHARM))
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
    if (IsPlayer() || (IsCreature() && !ToCreature()->IsGuardian()))
        DeleteCharmInfo();
}

void Unit::RestoreFaction()
{
    if (IsPlayer())
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

    if (u1->IsPlayer() && u2->IsPlayer())
        return u1->ToPlayer()->IsInSameGroupWith(u2->ToPlayer());
    // Xinef: we assume that npcs with the same faction are in party
    else if (u1->IsCreature() && u2->IsCreature() && !u1->IsControlledByPlayer() && !u2->IsControlledByPlayer())
        return u1->GetFaction() == u2->GetFaction();
    // Xinef: creature type_flag should work for party check only if player group is not a raid
    else if ((u2->IsPlayer() && u1->IsCreature() && (u1->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT) && u2->ToPlayer()->GetGroup() && !u2->ToPlayer()->GetGroup()->isRaidGroup()) ||
             (u1->IsPlayer() && u2->IsCreature() && (u2->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT) && u1->ToPlayer()->GetGroup() && !u1->ToPlayer()->GetGroup()->isRaidGroup()))
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

    if (u1->IsPlayer() && u2->IsPlayer())
        return u1->ToPlayer()->IsInSameRaidWith(u2->ToPlayer());
    // Xinef: we assume that npcs with the same faction are in party
    else if (u1->IsCreature() && u2->IsCreature() && !u1->IsControlledByPlayer() && !u2->IsControlledByPlayer())
        return u1->GetFaction() == u2->GetFaction();
    else if ((u2->IsPlayer() && u1->IsCreature() && u1->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT) ||
             (u1->IsPlayer() && u2->IsCreature() && u2->ToCreature()->GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_TREAT_AS_RAID_UNIT))
        return true;
    else
        return false;
}

void Unit::GetPartyMembers(std::list<Unit*>& TagUnitMap)
{
    Unit* owner = GetCharmerOrOwnerOrSelf();
    Group* group = nullptr;
    if (owner->IsPlayer())
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
    if (victim->IsVehicle() && !victim->IsPlayer())
        return;

    Unit const* target = nullptr;
    if (victim->IsPlayer())
        target = victim;
    else if (victim->IsCreature())
    {
        if (Unit* owner = victim->GetOwner())
            if (owner->IsPlayer())
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
    if (!spellId && (attType != RANGED_ATTACK) && HasOffhandWeaponForAttack() && (!m_currentSpells[CURRENT_MELEE_SPELL] || !m_currentSpells[CURRENT_MELEE_SPELL]->IsNextMeleeSwingSpell()))
    {
        missChance += 19;
    }

    // bonus from skills is 0.04%
    //miss_chance -= skillDiff * 0.04f;
    int32 diff = -skillDiff;
    if (victim->IsPlayer())
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
        if (IsCreature() || (!ToPlayer()->IsGameMaster() && !ToPlayer()->GetSession()->PlayerLogout()))
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
            if (!IsPlayer())
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
        if (controlled->IsCreature())
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
        Cell::VisitObjects(this, notifier, radius);
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
        data << player->GetSession()->GetOrderCounter();        // movement counter
        data << float(vcos);                                    // x direction
        data << float(vsin);                                    // y direction
        data << float(speedXY);                                 // Horizontal speed
        data << float(-speedZ);                                 // Z Movement speed (vertical)

        player->SendDirectMessage(&data);
        player->GetSession()->IncrementOrderCounter();

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

uint32 Unit::GetModelForForm(ShapeshiftForm form, uint32 spellId)
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

    if (IsPlayer())
    {
        if (uint32 ModelId = sObjectMgr->GetModelForShapeshift(form, ToPlayer()))
            return ModelId;
    }

    uint32 modelid = 0;
    SpellShapeshiftFormEntry const* formEntry = sSpellShapeshiftFormStore.LookupEntry(form);
    if (formEntry && formEntry->modelID_A)
    {
        // Take the alliance modelid as default
        if (!IsPlayer())
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

Unit* Unit::GetRedirectThreatTarget() const
{
    return _redirectThreatInfo.GetTargetGUID() ? ObjectAccessor::GetUnit(*this, _redirectThreatInfo.GetTargetGUID()) : nullptr;
}

bool Unit::IsAttackSpeedOverridenShapeShift() const
{
    // Mirroring clientside gameplay logic
    if (ShapeshiftForm form = GetShapeshiftForm())
        if (SpellShapeshiftFormEntry const* entry = sSpellShapeshiftFormStore.LookupEntry(form))
            return entry->attackSpeed > 0;

    return false;
}

void Unit::JumpTo(float speedXY, float speedZ, bool forward)
{
    float angle = forward ? 0 : M_PI;
    if (IsCreature())
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

        ToPlayer()->SendDirectMessage(&data);
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
        if (spellInfo->HasAura(SPELL_AURA_CONTROL_VEHICLE) && caster->IsPlayer() && caster->FindMap() && caster->FindMap()->IsBattleArena())
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
        if (vehicle->GetBase()->IsPlayer() && player->IsInCombat())
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
        player->SendDirectMessage(&data);
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

bool VehicleDespawnEvent::Execute(uint64 /*e_time*/, uint32 /*p_time*/)
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

    // This should be done before dismiss, because there may be some aura removal
    VehicleSeatAddon const* seatAddon = m_vehicle->GetSeatAddonForSeatOfPassenger(this);
    m_vehicle->RemovePassenger(this);

    Player* player = ToPlayer();

    // If player is on mouted duel and exits the mount should immediatly lose the duel
    if (player && player->duel && player->duel->IsMounted)
        player->DuelComplete(DUEL_FLED);

    Vehicle* vehicle = m_vehicle;
    Unit* vehicleBase = m_vehicle->GetBase();
    m_vehicle = nullptr;

    if (!vehicleBase)
        return;

    if (IsPlayer())
        ToPlayer()->SetExpectingChangeTransport(true);

    SetControlled(false, UNIT_STATE_ROOT);      // SMSG_MOVE_FORCE_UNROOT, ~MOVEMENTFLAG_ROOT

    Position pos;
    // If we ask for a specific exit position, use that one. Otherwise allow scripts to modify it
    if (exitPosition)
        pos = *exitPosition;
    else
    {
        // Set exit position to vehicle position and use the current orientation
        pos = vehicleBase->GetPosition();  // This should use passenger's current position, leaving it as it is now
        pos.SetOrientation(vehicleBase->GetOrientation());

        // Change exit position based on seat entry addon data
        if (seatAddon)
        {
            if (seatAddon->ExitParameter == VehicleExitParameters::VehicleExitParamOffset)
                pos.RelocateOffset({ seatAddon->ExitParameterX, seatAddon->ExitParameterY, seatAddon->ExitParameterZ, seatAddon->ExitParameterO });
            else if (seatAddon->ExitParameter == VehicleExitParameters::VehicleExitParamDest)
                pos.Relocate({ seatAddon->ExitParameterX, seatAddon->ExitParameterY, seatAddon->ExitParameterZ, seatAddon->ExitParameterO });
        }
    }

    AddUnitState(UNIT_STATE_MOVE);

    if (player)
    {
        player->SetFallInformation(GameTime::GetGameTime().count(), GetPositionZ());

        sScriptMgr->AnticheatSetUnderACKmount(player);
    }

    // xinef: hack for flameleviathan seat vehicle
    VehicleEntry const* vehicleInfo = vehicle->GetVehicleInfo();
    if (!vehicleInfo || vehicleInfo->m_ID != 341)
    {
        Movement::MoveSplineInit init(this);
        init.MoveTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ());
        init.SetFacing(vehicleBase->GetOrientation());
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
    if (IsCreature() && !CanFly() && vehicleInfo && (vehicleInfo->m_ID == 113 || vehicleInfo->m_ID == 8 || vehicleInfo->m_ID == 290 || vehicleInfo->m_ID == 298))
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
            else if (vehicleBase->IsCreature())
            {
                vehicle->Uninstall();
                vehicleBase->m_Events.AddEventAtOffset(new VehicleDespawnEvent(*vehicleBase, 2s), 2s);
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
            ToTempSummon()->UnSummon(2s); // Approximation
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
    if (IsPlayer())
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
    if (IsCreature())
        Relocate(&pos);
    if (IsPlayer())
    {
        ToPlayer()->SetCanTeleport(true);
    }
    WorldPacket data2(MSG_MOVE_TELEPORT, 38);
    data2 << GetPackGUID();
    BuildMovementPacket(&data2);
    if (IsCreature())
        Relocate(&oldPos);
    if (IsPlayer())
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
        if (IsPlayer())
            GetMap()->PlayerRelocation(ToPlayer(), x, y, z, orientation);
        else
            GetMap()->CreatureRelocation(ToCreature(), x, y, z, orientation);
    }
    else if (turn)
    {
        UpdateOrientation(orientation);

        if (IsPlayer() && ToPlayer()->GetFarSightDistance())
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
    // Rage formulae https://wowwiki-archive.fandom.com/wiki/Rage#Formulae
    float addRage;

    float rageconversion = ((0.0091107836f * GetLevel() * GetLevel()) + 3.225598133f * GetLevel()) + 4.2652911f;

    // Unknown if correct, but lineary adjust rage conversion above level 70
    if (GetLevel() > 70)
        rageconversion += 13.27f * (GetLevel() - 70);

    if (attacker)
    {
        // see Bornak's bluepost explanation (05/29/2009)
        float rageFromDamageDealt = damage / rageconversion * 7.5f;
        addRage = (rageFromDamageDealt + weaponSpeedHitFactor) / 2.0f;
        addRage = std::min(addRage, rageFromDamageDealt * 2.0f);
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
            if (IsPlayer())
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
            if (attacker->IsPlayer())
            {
                attacker->ToPlayer()->SendAttackSwingCancelAttack();
            }

            for (Unit* controlled : attacker->m_Controlled)
            {
                if (controlled->GetVictim() == this && !controlled->IsValidAttackTarget(this))
                {
                    controlled->AttackStop();
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
    AuraMunchingQueue(Unit& owner, ObjectGuid targetGUID, int32 basePoints, uint32 spellId, AuraEffect* aurEff, AuraType auraType) : _owner(owner), _targetGUID(targetGUID), _basePoints(basePoints), _spellId(spellId), _aurEff(aurEff), _auraType(auraType) { }

    bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) override
    {
        if (_owner.IsInWorld() && _owner.FindMap())
            if (Unit* target = ObjectAccessor::GetUnit(_owner, _targetGUID))
            {
                bool auraFound = false; // Used to ensure _aurEff exists to avoid wild pointer access/crash
                Unit::AuraEffectList const& auraEffects = target->GetAuraEffectsByType(_auraType);
                for (Unit::AuraEffectList::const_iterator j = auraEffects.begin(); j != auraEffects.end(); ++j)
                    if ((*j) == _aurEff)
                        auraFound = true;

                if (!auraFound)
                    _aurEff = nullptr;

                _owner.CastCustomSpell(_spellId, SPELLVALUE_BASE_POINT0, _basePoints, target, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_NO_PERIODIC_RESET), nullptr, _aurEff, _owner.GetGUID());
            }

        return true;
    }

private:
    Unit& _owner;
    ObjectGuid _targetGUID;
    int32 _basePoints;
    uint32 _spellId;
    AuraEffect* _aurEff;
    AuraType _auraType;
};

void Unit::CastDelayedSpellWithPeriodicAmount(Unit* caster, uint32 spellId, AuraType auraType, int32 addAmount, uint8 effectIndex)
{
    AuraEffect* aurEff = nullptr;
    for (AuraEffectList::iterator i = m_modAuras[auraType].begin(); i != m_modAuras[auraType].end(); ++i)
    {
        aurEff = *i;
        if (aurEff->GetCasterGUID() != caster->GetGUID() || aurEff->GetId() != spellId || aurEff->GetEffIndex() != effectIndex || !aurEff->GetTotalTicks())
            continue;

        addAmount += ((aurEff->GetOldAmount() * std::max<int32>(aurEff->GetTotalTicks() - int32(aurEff->GetTickNumber()), 0)) / aurEff->GetTotalTicks());
        break;
    }

    // xinef: delay only for casting on different unit
    if (this == caster || !sWorld->getBoolConfig(CONFIG_MUNCHING_BLIZZLIKE))
        caster->CastCustomSpell(spellId, SPELLVALUE_BASE_POINT0, addAmount, this, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_NO_PERIODIC_RESET), nullptr, aurEff, caster->GetGUID());
    else
        caster->m_Events.AddEvent(new AuraMunchingQueue(*caster, GetGUID(), addAmount, spellId, aurEff, auraType), caster->m_Events.CalculateQueueTime(400));
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

void Unit::PetSpellFail(SpellInfo const* spellInfo, Unit* target, uint32 result)
{
    CharmInfo* charmInfo = GetCharmInfo();
    if (!charmInfo || !IsCreature())
        return;

    if ((sDisableMgr->IsPathfindingEnabled(GetMap()) || result != SPELL_FAILED_LINE_OF_SIGHT) && target)
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

int32 Unit::CalculateAOEDamageReduction(int32 damage, uint32 schoolMask, bool npcCaster) const
{
    damage = int32(float(damage) * GetTotalAuraMultiplierByMiscMask(SPELL_AURA_MOD_AOE_DAMAGE_AVOIDANCE, schoolMask));
    if (npcCaster)
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

                Acore::PlayerRelocationNotifier notifier(*player);
                Cell::VisitObjects(viewPoint, notifier, player->GetSightRange());
                Cell::VisitFarVisibleObjects(viewPoint, notifier, VISIBILITY_DISTANCE_GIGANTIC);
                notifier.SendToSelf();
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

        GetMap()->LoadGridsInRange(*player, MAX_VISIBILITY_DISTANCE);

        Acore::PlayerRelocationNotifier notifier(*player);
        Cell::VisitObjects(viewPoint, notifier, player->GetSightRange());
        Cell::VisitFarVisibleObjects(viewPoint, notifier, VISIBILITY_DISTANCE_GIGANTIC);
        notifier.SendToSelf();

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
        Cell::VisitObjects(unit, relocate, unit->GetVisibilityRange());

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
    Cell::VisitObjects(this, notifier, radius);
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

void Unit::SetFacingToObject(WorldObject* object, Milliseconds timed /*= 0ms*/)
{
    // never face when already moving
    if (!IsStopped())
        return;

    /// @todo figure out under what conditions creature will move towards object instead of facing it where it currently is.
    Movement::MoveSplineInit init(this);
    init.MoveTo(GetPositionX(), GetPositionY(), GetPositionZ());
    init.SetFacing(GetAngle(object));   // when on transport, GetAngle will still return global coordinates (and angle) that needs transforming
    init.Launch();

    if (timed > 0ms)
    {
        if (Creature* c = ToCreature())
        {
            c->m_Events.AddEventAtOffset([c]()
            {
                if (c->IsInWorld() && c->FindMap() && c->IsAlive() && !c->IsInCombat())
                    c->SetFacingTo(c->GetHomePosition().GetOrientation());
            }, timed);
        }
        else
            LOG_ERROR("entities.unit", "Unit::SetFacingToObject called on non-creature unit {}. This should never happen.", GetEntry());
    }
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

void Unit::SetDisableGravity(bool enable)
{
    bool isClientControlled = IsClientControlled();

    if (!isClientControlled)
    {
        if (enable)
            m_movementInfo.AddMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY);
        else
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_DISABLE_GRAVITY);
    }

    if (!IsInWorld()) // is sent on add to map
        return;

    if (isClientControlled)
    {
        if (Player const* player = GetClientControlling())
        {
            uint32 const counter = player->GetSession()->GetOrderCounter();

            WorldPacket data(enable ? SMSG_MOVE_GRAVITY_DISABLE : SMSG_MOVE_GRAVITY_ENABLE, GetPackGUID().size() + 4);
            data << GetPackGUID();
            data << counter;
            player->GetSession()->SendPacket(&data);
            player->GetSession()->IncrementOrderCounter();
            return;
        }
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_GRAVITY_DISABLE : SMSG_SPLINE_MOVE_GRAVITY_ENABLE, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
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

/**
 * @brief Add the movement flag: MOVEMENTFLAGCAN_FLY. Generaly only use by players, allowing
 *  them to fly by pressing space for example. For creatures, please look for DisableGravity().
 *
 *  Doesn't inform the client.
 */
void Unit::SetCanFly(bool enable)
{
    bool isClientControlled = IsClientControlled();

    if (!isClientControlled)
    {
        if (enable)
            m_movementInfo.AddMovementFlag(MOVEMENTFLAG_CAN_FLY);
        else
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_CAN_FLY);
    }

    if (!IsInWorld()) // is sent on add to map
        return;

    if (isClientControlled)
    {
        if (Player const* player = GetClientControlling())
        {
            uint32 const counter = player->GetSession()->GetOrderCounter();
            const_cast<Player*>(player)->SetPendingFlightChange(counter);

            WorldPacket data(enable ? SMSG_MOVE_SET_CAN_FLY : SMSG_MOVE_UNSET_CAN_FLY, GetPackGUID().size() + 4);
            data << GetPackGUID();
            data << counter;
            player->SendDirectMessage(&data);
            player->GetSession()->IncrementOrderCounter();
            return;
        }
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_FLYING : SMSG_SPLINE_MOVE_UNSET_FLYING, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
}

void Unit::SetFeatherFall(bool enable)
{
    bool isClientControlled = IsClientControlled();

    if (!isClientControlled)
    {
        if (enable)
            m_movementInfo.AddMovementFlag(MOVEMENTFLAG_FALLING_SLOW);
        else
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_FALLING_SLOW);
    }

    if (!IsInWorld()) // is sent on add to map
        return;

    if (isClientControlled)
    {
        if (Player const* player = GetClientControlling())
        {
            uint32 const counter = player->GetSession()->GetOrderCounter();

            WorldPacket data(enable ? SMSG_MOVE_FEATHER_FALL : SMSG_MOVE_NORMAL_FALL, GetPackGUID().size() + 4);

            data << GetPackGUID();
            data << counter;
            player->SendDirectMessage(&data);
            player->GetSession()->IncrementOrderCounter();

            // start fall from current height
            if (!enable)
                const_cast<Player*>(player)->SetFallInformation(0, GetPositionZ());

            return;
        }
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_FEATHER_FALL : SMSG_SPLINE_MOVE_NORMAL_FALL);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
}

void Unit::SetHover(bool enable)
{
    bool isClientControlled = IsClientControlled();

    if (!isClientControlled)
    {
        if (enable)
            m_movementInfo.AddMovementFlag(MOVEMENTFLAG_HOVER);
        else
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_HOVER);
    }

    float hoverHeight = GetHoverHeight();

    if (enable)
    {
        if (hoverHeight && GetPositionZ() - GetMap()->GetHeight(GetPhaseMask(), GetPositionX(), GetPositionY(), GetPositionZ()) < hoverHeight)
            Relocate(GetPositionX(), GetPositionY(), GetPositionZ() + hoverHeight);
    }
    else
    {
        if (IsAlive() || !IsUnit())
        {
            float newZ = std::max<float>(GetMap()->GetHeight(GetPhaseMask(), GetPositionX(), GetPositionY(), GetPositionZ()), GetPositionZ() - hoverHeight);
            UpdateAllowedPositionZ(GetPositionX(), GetPositionY(), newZ);
            Relocate(GetPositionX(), GetPositionY(), newZ);
        }
    }

    if (!IsInWorld()) // is sent on add to map
        return;

    if (isClientControlled)
    {
        if (Player const* player = GetClientControlling())
        {
            WorldPacket data(enable ? SMSG_MOVE_SET_HOVER : SMSG_MOVE_UNSET_HOVER, GetPackGUID().size() + 4);

            uint32 const counter = player->GetSession()->GetOrderCounter();

            data << GetPackGUID();
            data << counter;
            player->SendDirectMessage(&data);
            player->GetSession()->IncrementOrderCounter();
            return;
        }
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_SET_HOVER : SMSG_SPLINE_MOVE_UNSET_HOVER, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
}

void Unit::SetWaterWalking(bool enable)
{
    bool isClientControlled = IsClientControlled();

    if (!isClientControlled)
    {
        if (enable)
            m_movementInfo.AddMovementFlag(MOVEMENTFLAG_WATERWALKING);
        else
            m_movementInfo.RemoveMovementFlag(MOVEMENTFLAG_WATERWALKING);
    }

    if (!IsInWorld()) // is sent on add to map
        return;

    if (isClientControlled)
    {
        if (Player const* player = GetClientControlling())
        {
            uint32 const counter = player->GetSession()->GetOrderCounter();

            WorldPacket data(enable ? SMSG_MOVE_WATER_WALK : SMSG_MOVE_LAND_WALK, GetPackGUID().size() + 4);
            data << GetPackGUID();
            data << counter;
            player->SendDirectMessage(&data);
            player->GetSession()->IncrementOrderCounter();
            return;
        }
    }

    WorldPacket data(enable ? SMSG_SPLINE_MOVE_WATER_WALK : SMSG_SPLINE_MOVE_LAND_WALK, 9);
    data << GetPackGUID();
    SendMessageToSet(&data, true);
}

void Unit::SendMovementWaterWalking(Player* sendTo)
{
    if (!movespline->Initialized())
        return;
    WorldPacket data(SMSG_SPLINE_MOVE_WATER_WALK, 9);
    data << GetPackGUID();
    sendTo->SendDirectMessage(&data);
}

void Unit::SendMovementFeatherFall(Player* sendTo)
{
    if (!movespline->Initialized())
        return;
    WorldPacket data(SMSG_SPLINE_MOVE_FEATHER_FALL, 9);
    data << GetPackGUID();
    sendTo->SendDirectMessage(&data);
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
        {
            appendValue &= ~UNIT_NPC_FLAG_REPAIR;
            appendValue &= ~UNIT_NPC_FLAG_VENDOR_MASK;
        }

        if (!target->CanSeeTrainer(creature))
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

            if (cinfo->HasFlagsExtra(CREATURE_FLAG_EXTRA_TRIGGER))
            {
                if (target->IsGameMaster() && target->GetSession()->IsGMAccount())
                    displayId = cinfo->GetFirstVisibleModel()->CreatureDisplayID;
                else
                    displayId = cinfo->GetFirstInvisibleModel()->CreatureDisplayID;
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
                    (this->IsPlayer() || this->IsCreature() || this->IsDynamicObject()))
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
                    (this->IsPlayer() || this->IsCreature() || this->IsDynamicObject()))
        {
            valuesUpdateBuf.put(posPointers.UnitFieldFactionTemplatePos, uint32(target->GetFaction()));
        }
        else if (target->IsGMSpectator() && IsControlledByPlayer())
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
    if (IsPlayer())
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
    if (IsPlayer())
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
    if (IsPlayer())
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
    Cell::VisitObjects(this, worker, textRange);
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

uint32 Unit::GetVirtualItemId(uint32 slot) const
{
    if (slot >= MAX_EQUIPMENT_ITEMS)
        return 0;

    return GetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + slot);
}

void Unit::SetVirtualItem(uint32 slot, uint32 itemId)
{
    if (slot >= MAX_EQUIPMENT_ITEMS)
        return;

    SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + slot, itemId);
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
    Cell::VisitObjects(this, worker, textRange);
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

void Unit::SetShapeshiftForm(ShapeshiftForm form)
{
    SetByteValue(UNIT_FIELD_BYTES_2, 3, form);
    sScriptMgr->OnUnitSetShapeshiftForm((Unit*)this, form);
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

        if (!(shapeshift->flags1 & SHAPESHIFT_FLAG_STANCE))
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

bool Unit::IsClientControlled(Player const* exactClient /*= nullptr*/) const
{
    // Severvide method to check if unit is client controlled (optionally check for specific client in control)

    // Applies only to player controlled units
    if (!HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PLAYER_CONTROLLED))
        return false;

    // These flags are meant to be used when server controls this unit, client control is taken away
    if (HasFlag(UNIT_FIELD_FLAGS, (UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_CONFUSED | UNIT_FLAG_FLEEING)))
        return false;

    // If unit is possessed, it has lost original control...
    if (ObjectGuid const& guid = GetCharmerGUID())
    {
        // ... but if it is a possessing charm, then we have to check if some other player controls it
        if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_POSSESSED) && guid.IsPlayer())
            return (exactClient ? (exactClient->GetGUID() == guid) : true);
        return false;
    }

    // By default: players have client control over themselves
    if (IsPlayer())
        return (exactClient ? (exactClient == this) : true);
    return false;
}

Player const* Unit::GetClientControlling() const
{
    // Serverside reverse "mover" deduction logic at controlled unit

    // Applies only to player controlled units
    if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PLAYER_CONTROLLED))
    {
        // Charm always removes control from original client...
        if (GetCharmerGUID())
        {
            // ... but if it is a possessing charm, some other client may have control
            if (HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_POSSESSED))
            {
                Unit const* charmer = GetCharmer();
                if (charmer && charmer->IsPlayer())
                    return static_cast<Player const*>(charmer);
            }
        }
        else if (IsPlayer())
        {
            // Check if anything prevents original client from controlling
            if (IsClientControlled(static_cast<Player const*>(this)))
                return static_cast<Player const*>(this);
        }
    }
    return nullptr;
}
