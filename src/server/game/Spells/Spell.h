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

#ifndef __SPELL_H
#define __SPELL_H

#include "ConditionMgr.h"
#include "GridDefines.h"
#include "LootMgr.h"
#include "PathGenerator.h"
#include "SharedDefines.h"
#include "SpellInfo.h"
#include "Unit.h"

class Unit;
class Player;
class GameObject;
class DynamicObject;
class WorldObject;
class Aura;
class AuraEffect;
class SpellScript;
class SpellEvent;
class ByteBuffer;
class BasicEvent;

#define SPELL_CHANNEL_UPDATE_INTERVAL (1 * IN_MILLISECONDS)

enum SpellCastFlags
{
    CAST_FLAG_NONE               = 0x00000000,
    CAST_FLAG_PENDING            = 0x00000001,              // aoe combat log?
    CAST_FLAG_HAS_TRAJECTORY     = 0x00000002,
    CAST_FLAG_UNKNOWN_3          = 0x00000004,
    CAST_FLAG_UNKNOWN_4          = 0x00000008,              // ignore AOE visual
    CAST_FLAG_UNKNOWN_5          = 0x00000010,
    CAST_FLAG_PROJECTILE         = 0x00000020,              // Projectiles visual
    CAST_FLAG_UNKNOWN_7          = 0x00000040,
    CAST_FLAG_UNKNOWN_8          = 0x00000080,
    CAST_FLAG_UNKNOWN_9          = 0x00000100,
    CAST_FLAG_UNKNOWN_10         = 0x00000200,
    CAST_FLAG_UNKNOWN_11         = 0x00000400,
    CAST_FLAG_POWER_LEFT_SELF    = 0x00000800,
    CAST_FLAG_UNKNOWN_13         = 0x00001000,
    CAST_FLAG_UNKNOWN_14         = 0x00002000,
    CAST_FLAG_UNKNOWN_15         = 0x00004000,
    CAST_FLAG_UNKNOWN_16         = 0x00008000,
    CAST_FLAG_UNKNOWN_17         = 0x00010000,
    CAST_FLAG_ADJUST_MISSILE     = 0x00020000,
    CAST_FLAG_NO_GCD             = 0x00040000,              // no GCD for spell casts from charm/summon (vehicle spells is an example)
    CAST_FLAG_VISUAL_CHAIN       = 0x00080000,
    CAST_FLAG_UNKNOWN_21         = 0x00100000,
    CAST_FLAG_RUNE_LIST          = 0x00200000,
    CAST_FLAG_UNKNOWN_23         = 0x00400000,
    CAST_FLAG_UNKNOWN_24         = 0x00800000,
    CAST_FLAG_UNKNOWN_25         = 0x01000000,
    CAST_FLAG_UNKNOWN_26         = 0x02000000,
    CAST_FLAG_IMMUNITY           = 0x04000000,
    CAST_FLAG_UNKNOWN_28         = 0x08000000,
    CAST_FLAG_UNKNOWN_29         = 0x10000000,
    CAST_FLAG_UNKNOWN_30         = 0x20000000,
    CAST_FLAG_HEAL_PREDICTION    = 0x40000000,              //@todo: Unused on TC 3.3.5a. Defined from TC Master.
    CAST_FLAG_UNKNOWN_32         = 0x80000000
};

//Spells casted on self should not be diminished.
enum SpellFlags
{
    SPELL_FLAG_NORMAL = 0x00,
    SPELL_FLAG_REFLECTED = 0x01,        // reflected spell
    SPELL_FLAG_REDIRECTED = 0x02        // redirected spell
};

enum SpellRangeFlag
{
    SPELL_RANGE_DEFAULT             = 0,
    SPELL_RANGE_MELEE               = 1,     //melee
    SPELL_RANGE_RANGED              = 2,     //hunter range and ranged weapon
};

struct SpellDestination
{
    SpellDestination();
    SpellDestination(float x, float y, float z, float orientation = 0.0f, uint32 mapId = MAPID_INVALID);
    SpellDestination(Position const& pos);
    SpellDestination(WorldObject const& wObj);

    void Relocate(Position const& pos);
    void RelocateOffset(Position const& offset);

    WorldLocation _position;
    ObjectGuid _transportGUID;
    Position _transportOffset;
};

class SpellCastTargets
{
public:
    SpellCastTargets();
    ~SpellCastTargets();

    void Read(ByteBuffer& data, Unit* caster);
    void Write(ByteBuffer& data);

    uint32 GetTargetMask() const { return m_targetMask; }
    void SetTargetMask(uint32 newMask) { m_targetMask = newMask; }

    void SetTargetFlag(SpellCastTargetFlags flag) { m_targetMask |= flag; }

    ObjectGuid GetUnitTargetGUID() const;
    Unit* GetUnitTarget() const;
    void SetUnitTarget(Unit* target);

    ObjectGuid GetGOTargetGUID() const;
    GameObject* GetGOTarget() const;
    void SetGOTarget(GameObject* target);

    ObjectGuid GetCorpseTargetGUID() const;
    Corpse* GetCorpseTarget() const;
    void SetCorpseTarget(Corpse* target);

    WorldObject* GetObjectTarget() const;
    ObjectGuid GetObjectTargetGUID() const;
    void RemoveObjectTarget();

    ObjectGuid GetItemTargetGUID() const { return m_itemTargetGUID; }
    Item* GetItemTarget() const { return m_itemTarget; }
    uint32 GetItemTargetEntry() const { return m_itemTargetEntry; }
    void SetItemTarget(Item* item);
    void SetTradeItemTarget(Player* caster);
    void UpdateTradeSlotItem();

    SpellDestination const* GetSrc() const;
    Position const* GetSrcPos() const;
    void SetSrc(float x, float y, float z);
    void SetSrc(Position const& pos);
    void SetSrc(WorldObject const& wObj);
    void ModSrc(Position const& pos);
    void RemoveSrc();

    SpellDestination const* GetDst() const;
    WorldLocation const* GetDstPos() const;
    void SetDst(float x, float y, float z, float orientation, uint32 mapId = MAPID_INVALID);
    void SetDst(Position const& pos);
    void SetDst(WorldObject const& wObj);
    void SetDst(SpellDestination const& spellDest);
    void SetDst(SpellCastTargets const& spellTargets);
    void ModDst(Position const& pos);
    void ModDst(SpellDestination const& spellDest);
    void RemoveDst();

    bool HasSrc() const { return GetTargetMask() & TARGET_FLAG_SOURCE_LOCATION; }
    bool HasDst() const { return GetTargetMask() & TARGET_FLAG_DEST_LOCATION; }
    bool HasTraj() const { return m_speed != 0; }

    float GetElevation() const { return m_elevation; }
    void SetElevation(float elevation) { m_elevation = elevation; }
    float GetSpeed() const { return m_speed; }
    void SetSpeed(float speed) { m_speed = speed; }

    float GetDist2d() const { return m_src._position.GetExactDist2d(&m_dst._position); }
    float GetSpeedXY() const { return m_speed * cos(m_elevation); }
    float GetSpeedZ() const { return m_speed * std::sin(m_elevation); }

    void Update(Unit* caster);
    void OutDebug() const;

    // Xinef: Channel data
    void SetObjectTargetChannel(ObjectGuid targetGUID);
    void SetDstChannel(SpellDestination const& spellDest);
    WorldObject* GetObjectTargetChannel(Unit* caster) const;
    bool HasDstChannel() const;
    SpellDestination const* GetDstChannel() const;

private:
    uint32 m_targetMask;

    // objects (can be used at spell creating and after Update at casting)
    WorldObject* m_objectTarget;
    Item* m_itemTarget;

    // object GUID/etc, can be used always
    ObjectGuid m_objectTargetGUID;
    ObjectGuid m_itemTargetGUID;
    uint32 m_itemTargetEntry;

    SpellDestination m_src;
    SpellDestination m_dst;

    float m_elevation, m_speed;
    std::string m_strTarget;

    // Xinef: Save channel data
    SpellDestination m_dstChannel;
    ObjectGuid m_objectTargetGUIDChannel;
};

struct SpellValue
{
    explicit  SpellValue(SpellInfo const* proto);
    int32     EffectBasePoints[MAX_SPELL_EFFECTS];
    uint32    MaxAffectedTargets;
    float     RadiusMod;
    uint8     AuraStackAmount;
    int32     AuraDuration;
    bool      ForcedCritResult;
    uint32    MiscVal[MAX_SPELL_EFFECTS];
};

enum SpellState
{
    SPELL_STATE_NULL      = 0,
    SPELL_STATE_PREPARING = 1,
    SPELL_STATE_CASTING   = 2,
    SPELL_STATE_FINISHED  = 3,
    SPELL_STATE_IDLE      = 4,
    SPELL_STATE_DELAYED   = 5
};

enum SpellEffectHandleMode
{
    SPELL_EFFECT_HANDLE_LAUNCH,
    SPELL_EFFECT_HANDLE_LAUNCH_TARGET,
    SPELL_EFFECT_HANDLE_HIT,
    SPELL_EFFECT_HANDLE_HIT_TARGET,
};

// Xinef: special structure containing data for channel target spells
struct ChannelTargetData
{
    ChannelTargetData(ObjectGuid cguid, const SpellDestination* dst) : channelGUID(cguid)
    {
        if (dst)
            spellDst = *dst;
    }

    ObjectGuid channelGUID;
    SpellDestination spellDst;
};

 // Targets store structures and data
struct TargetInfo
{
    ObjectGuid targetGUID;
    uint64 timeDelay;
    SpellMissInfo missCondition:8;
    SpellMissInfo reflectResult:8;
    uint8  effectMask:8;
    bool   processed:1;
    bool   alive:1;
    bool   crit:1;
    bool   scaleAura:1;
    int32  damage;
};

static const uint32 SPELL_INTERRUPT_NONPLAYER = 32747;

struct TriggeredByAuraSpellData
{
    TriggeredByAuraSpellData() : spellInfo(nullptr), effectIndex(-1), tickNumber(0) {}

    void Init(AuraEffect const* aurEff);

    operator bool() const { return spellInfo != nullptr; }
    bool operator!() const { return !(bool(*this)); }

    SpellInfo const* spellInfo;
    int8 effectIndex;
    uint32 tickNumber;
};

class Spell
{
    friend void Unit::SetCurrentCastedSpell(Spell* pSpell);
    friend class SpellScript;
public:
    Spell(Unit* caster, SpellInfo const* info, TriggerCastFlags triggerFlags, ObjectGuid originalCasterGUID = ObjectGuid::Empty, bool skipCheck = false);
    ~Spell();

    void EffectNULL(SpellEffIndex effIndex);
    void EffectUnused(SpellEffIndex effIndex);
    void EffectDistract(SpellEffIndex effIndex);
    void EffectPull(SpellEffIndex effIndex);
    void EffectSchoolDMG(SpellEffIndex effIndex);
    void EffectEnvironmentalDMG(SpellEffIndex effIndex);
    void EffectInstaKill(SpellEffIndex effIndex);
    void EffectDummy(SpellEffIndex effIndex);
    void EffectTeleportUnits(SpellEffIndex effIndex);
    void EffectApplyAura(SpellEffIndex effIndex);
    void EffectSendEvent(SpellEffIndex effIndex);
    void EffectPowerBurn(SpellEffIndex effIndex);
    void EffectPowerDrain(SpellEffIndex effIndex);
    void EffectHeal(SpellEffIndex effIndex);
    void EffectBind(SpellEffIndex effIndex);
    void EffectHealthLeech(SpellEffIndex effIndex);
    void EffectQuestComplete(SpellEffIndex effIndex);
    void EffectCreateItem(SpellEffIndex effIndex);
    void EffectCreateItem2(SpellEffIndex effIndex);
    void EffectCreateRandomItem(SpellEffIndex effIndex);
    void EffectPersistentAA(SpellEffIndex effIndex);
    void EffectEnergize(SpellEffIndex effIndex);
    void EffectOpenLock(SpellEffIndex effIndex);
    void EffectSummonChangeItem(SpellEffIndex effIndex);
    void EffectProficiency(SpellEffIndex effIndex);
    void EffectApplyAreaAura(SpellEffIndex effIndex);
    void EffectSummonType(SpellEffIndex effIndex);
    void EffectLearnSpell(SpellEffIndex effIndex);
    void EffectDispel(SpellEffIndex effIndex);
    void EffectDualWield(SpellEffIndex effIndex);
    void EffectPickPocket(SpellEffIndex effIndex);
    void EffectAddFarsight(SpellEffIndex effIndex);
    void EffectUntrainTalents(SpellEffIndex effIndex);
    void EffectHealMechanical(SpellEffIndex effIndex);
    void EffectJump(SpellEffIndex effIndex);
    void EffectJumpDest(SpellEffIndex effIndex);
    void EffectLeapBack(SpellEffIndex effIndex);
    void EffectQuestClear(SpellEffIndex effIndex);
    void EffectTeleUnitsFaceCaster(SpellEffIndex effIndex);
    void EffectLearnSkill(SpellEffIndex effIndex);
    void EffectAddHonor(SpellEffIndex effIndex);
    void EffectTradeSkill(SpellEffIndex effIndex);
    void EffectEnchantItemPerm(SpellEffIndex effIndex);
    void EffectEnchantItemTmp(SpellEffIndex effIndex);
    void EffectTameCreature(SpellEffIndex effIndex);
    void EffectSummonPet(SpellEffIndex effIndex);
    void EffectLearnPetSpell(SpellEffIndex effIndex);
    void EffectWeaponDmg(SpellEffIndex effIndex);
    void EffectForceCast(SpellEffIndex effIndex);
    void EffectTriggerSpell(SpellEffIndex effIndex);
    void EffectTriggerMissileSpell(SpellEffIndex effIndex);
    void EffectThreat(SpellEffIndex effIndex);
    void EffectHealMaxHealth(SpellEffIndex effIndex);
    void EffectInterruptCast(SpellEffIndex effIndex);
    void EffectSummonObjectWild(SpellEffIndex effIndex);
    void EffectScriptEffect(SpellEffIndex effIndex);
    void EffectSanctuary(SpellEffIndex effIndex);
    void EffectAddComboPoints(SpellEffIndex effIndex);
    void EffectDuel(SpellEffIndex effIndex);
    void EffectStuck(SpellEffIndex effIndex);
    void EffectSummonPlayer(SpellEffIndex effIndex);
    void EffectActivateObject(SpellEffIndex effIndex);
    void EffectApplyGlyph(SpellEffIndex effIndex);
    void EffectEnchantHeldItem(SpellEffIndex effIndex);
    void EffectSummonObject(SpellEffIndex effIndex);
    void EffectResurrect(SpellEffIndex effIndex);
    void EffectParry(SpellEffIndex effIndex);
    void EffectBlock(SpellEffIndex effIndex);
    void EffectLeap(SpellEffIndex effIndex);
    void EffectTransmitted(SpellEffIndex effIndex);
    void EffectDisEnchant(SpellEffIndex effIndex);
    void EffectInebriate(SpellEffIndex effIndex);
    void EffectFeedPet(SpellEffIndex effIndex);
    void EffectDismissPet(SpellEffIndex effIndex);
    void EffectReputation(SpellEffIndex effIndex);
    void EffectForceDeselect(SpellEffIndex effIndex);
    void EffectSelfResurrect(SpellEffIndex effIndex);
    void EffectSkinning(SpellEffIndex effIndex);
    void EffectCharge(SpellEffIndex effIndex);
    void EffectChargeDest(SpellEffIndex effIndex);
    void EffectProspecting(SpellEffIndex effIndex);
    void EffectMilling(SpellEffIndex effIndex);
    void EffectRenamePet(SpellEffIndex effIndex);
    void EffectSendTaxi(SpellEffIndex effIndex);
    void EffectSummonCritter(SpellEffIndex effIndex);
    void EffectKnockBack(SpellEffIndex effIndex);
    void EffectPullTowards(SpellEffIndex effIndex);
    void EffectDispelMechanic(SpellEffIndex effIndex);
    void EffectResurrectPet(SpellEffIndex effIndex);
    void EffectDestroyAllTotems(SpellEffIndex effIndex);
    void EffectDurabilityDamage(SpellEffIndex effIndex);
    void EffectSkill(SpellEffIndex effIndex);
    void EffectTaunt(SpellEffIndex effIndex);
    void EffectDurabilityDamagePCT(SpellEffIndex effIndex);
    void EffectModifyThreatPercent(SpellEffIndex effIndex);
    void EffectResurrectNew(SpellEffIndex effIndex);
    void EffectAddExtraAttacks(SpellEffIndex effIndex);
    void EffectSpiritHeal(SpellEffIndex effIndex);
    void EffectSkinPlayerCorpse(SpellEffIndex effIndex);
    void EffectStealBeneficialBuff(SpellEffIndex effIndex);
    void EffectUnlearnSpecialization(SpellEffIndex effIndex);
    void EffectHealPct(SpellEffIndex effIndex);
    void EffectEnergizePct(SpellEffIndex effIndex);
    void EffectTriggerRitualOfSummoning(SpellEffIndex effIndex);
    void EffectSummonRaFFriend(SpellEffIndex effIndex);
    void EffectKillCreditPersonal(SpellEffIndex effIndex);
    void EffectKillCredit(SpellEffIndex effIndex);
    void EffectQuestFail(SpellEffIndex effIndex);
    void EffectQuestStart(SpellEffIndex effIndex);
    void EffectRedirectThreat(SpellEffIndex effIndex);
    void EffectGameObjectDamage(SpellEffIndex effIndex);
    void EffectGameObjectRepair(SpellEffIndex effIndex);
    void EffectGameObjectSetDestructionState(SpellEffIndex effIndex);
    void EffectActivateRune(SpellEffIndex effIndex);
    void EffectCreateTamedPet(SpellEffIndex effIndex);
    void EffectDiscoverTaxi(SpellEffIndex effIndex);
    void EffectTitanGrip(SpellEffIndex effIndex);
    void EffectEnchantItemPrismatic(SpellEffIndex effIndex);
    void EffectPlayMusic(SpellEffIndex effIndex);
    void EffectSpecCount(SpellEffIndex effIndex);
    void EffectActivateSpec(SpellEffIndex effIndex);
    void EffectPlaySound(SpellEffIndex effIndex);
    void EffectRemoveAura(SpellEffIndex effIndex);
    void EffectCastButtons(SpellEffIndex effIndex);
    void EffectRechargeManaGem(SpellEffIndex effIndex);

    typedef std::set<Aura*> UsedSpellMods;

    void InitExplicitTargets(SpellCastTargets const& targets);
    void SelectExplicitTargets();

    void SelectSpellTargets();
    void SelectEffectImplicitTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32& processedEffectMask);
    void SelectImplicitChannelTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void SelectImplicitNearbyTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32 effMask);
    void SelectImplicitConeTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32 effMask);
    void SelectImplicitAreaTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, uint32 effMask);
    void SelectImplicitCasterDestTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void SelectImplicitTargetDestTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void SelectImplicitDestDestTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void SelectImplicitCasterObjectTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void SelectImplicitTargetObjectTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void SelectImplicitChainTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType, WorldObject* target, uint32 effMask);
    void SelectImplicitTrajTargets(SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);

    void SelectEffectTypeImplicitTargets(uint8 effIndex);

    uint32 GetSearcherTypeMask(SpellTargetObjectTypes objType, ConditionList* condList);
    template<class SEARCHER> void SearchTargets(SEARCHER& searcher, uint32 containerMask, Unit* referer, Position const* pos, float radius);

    WorldObject* SearchNearbyTarget(float range, SpellTargetObjectTypes objectType, SpellTargetCheckTypes selectionType, ConditionList* condList = nullptr);
    void SearchAreaTargets(std::list<WorldObject*>& targets, float range, Position const* position, Unit* referer, SpellTargetObjectTypes objectType, SpellTargetCheckTypes selectionType, ConditionList* condList);
    void SearchChainTargets(std::list<WorldObject*>& targets, uint32 chainTargets, WorldObject* target, SpellTargetObjectTypes objectType, SpellTargetCheckTypes selectType, SpellTargetSelectionCategories selectCategory, ConditionList* condList, bool isChainHeal);

    SpellCastResult prepare(SpellCastTargets const* targets, AuraEffect const* triggeredByAura = nullptr);
    void cancel(bool bySelf = false);
    void update(uint32 difftime);
    void cast(bool skipCheck = false);
    void _cast(bool skipCheck);
    void finish(bool ok = true);
    void TakePower();
    void TakeAmmo();

    void TakeRunePower(bool didHit);
    void TakeReagents();
    void TakeCastItem();

    SpellCastResult CheckCast(bool strict);
    SpellCastResult CheckPetCast(Unit* target);

    // handlers
    void handle_immediate();
    uint64 handle_delayed(uint64 t_offset);
    // handler helpers
    void _handle_immediate_phase();
    void _handle_finish_phase();

    void OnSpellLaunch();

    SpellCastResult CheckItems();
    SpellCastResult CheckSpellFocus();
    SpellCastResult CheckRange(bool strict);
    SpellCastResult CheckPower();
    SpellCastResult CheckRuneCost(uint32 RuneCostID);
    SpellCastResult CheckCasterAuras(bool preventionOnly) const;

    int32 CalculateSpellDamage(uint8 i, Unit const* target) const { return m_caster->CalculateSpellDamage(target, m_spellInfo, i, &m_spellValue->EffectBasePoints[i]); }

    bool HaveTargetsForEffect(uint8 effect) const;
    void Delayed();
    void DelayedChannel();
    uint32 getState() const { return m_spellState; }
    void setState(uint32 state) { m_spellState = state; }

    void DoCreateItem(uint8 effIndex, uint32 itemId);
    void WriteSpellGoTargets(WorldPacket* data);
    void WriteAmmoToPacket(WorldPacket* data);

    bool CheckEffectTarget(Unit const* target, uint32 eff) const;
    bool CanAutoCast(Unit* target);
    void CheckSrc() { if (!m_targets.HasSrc()) m_targets.SetSrc(*m_caster); }
    void CheckDst() { if (!m_targets.HasDst()) m_targets.SetDst(*m_caster); }

    static void WriteCastResultInfo(WorldPacket& data, Player* caster, SpellInfo const* spellInfo, uint8 castCount, SpellCastResult result, SpellCustomErrors customError);
    static void SendCastResult(Player* caster, SpellInfo const* spellInfo, uint8 castCount, SpellCastResult result, SpellCustomErrors customError = SPELL_CUSTOM_ERROR_NONE);
    void SendCastResult(SpellCastResult result);
    void SendPetCastResult(SpellCastResult result);
    void SendSpellStart();
    void SendSpellGo();
    void SendSpellCooldown();
    void SendLogExecute();
    void ExecuteLogEffectTakeTargetPower(uint8 effIndex, Unit* target, uint32 PowerType, uint32 powerTaken, float gainMultiplier);
    void ExecuteLogEffectExtraAttacks(uint8 effIndex, Unit* victim, uint32 attCount);
    void ExecuteLogEffectInterruptCast(uint8 effIndex, Unit* victim, uint32 spellId);
    void ExecuteLogEffectDurabilityDamage(uint8 effIndex, Unit* victim, int32 itemId, int32 slot);
    void ExecuteLogEffectOpenLock(uint8 effIndex, Object* obj);
    void ExecuteLogEffectCreateItem(uint8 effIndex, uint32 entry);
    void ExecuteLogEffectDestroyItem(uint8 effIndex, uint32 entry);
    void ExecuteLogEffectSummonObject(uint8 effIndex, WorldObject* obj);
    void ExecuteLogEffectUnsummonObject(uint8 effIndex, WorldObject* obj);
    void ExecuteLogEffectResurrect(uint8 effIndex, Unit* target);
    void SendInterrupted(uint8 result);
    void SendChannelUpdate(uint32 time);
    void SendChannelStart(uint32 duration);
    void SendResurrectRequest(Player* target);

    void HandleEffects(Unit* pUnitTarget, Item* pItemTarget, GameObject* pGOTarget, uint32 i, SpellEffectHandleMode mode);
    void HandleThreatSpells();

    SpellInfo const* const m_spellInfo;
    Item* m_CastItem;
    Item* m_weaponItem;
    ObjectGuid m_castItemGUID;
    uint8 m_cast_count;
    uint32 m_glyphIndex;
    uint32 m_preCastSpell;
    SpellCastTargets m_targets;
    SpellCustomErrors m_customError;

    void AddComboPointGain(Unit* target, int8 amount)
    {
        if (target != m_comboTarget)
        {
            m_comboTarget = target;
            m_comboPointGain = amount;
        }
        else
        {
            m_comboPointGain += amount;
        }
    }
    Unit* m_comboTarget;
    int8 m_comboPointGain;

    UsedSpellMods m_appliedMods;

    int32 GetCastTime() const { return m_casttime; }
    bool IsAutoRepeat() const { return m_autoRepeat; }
    void SetAutoRepeat(bool rep) { m_autoRepeat = rep; }
    void ReSetTimer() { m_timer = m_casttime > 0 ? m_casttime : 0; }
    int32 GetCastTimeRemaining() { return m_timer;}
    bool IsNextMeleeSwingSpell() const;
    bool IsTriggered() const { return HasTriggeredCastFlag(TRIGGERED_FULL_MASK); };
    bool HasTriggeredCastFlag(TriggerCastFlags flag) const { return _triggeredCastFlags & flag; };
    bool IsChannelActive() const { return m_caster->GetUInt32Value(UNIT_CHANNEL_SPELL) != 0; }
    bool IsAutoActionResetSpell() const;
    bool IsIgnoringCooldowns() const;

    bool IsDeletable() const { return !m_referencedFromCurrentSpell && !m_executedCurrently; }
    void SetReferencedFromCurrent(bool yes) { m_referencedFromCurrentSpell = yes; }
    bool IsInterruptable() const { return !m_executedCurrently; }
    void SetExecutedCurrently(bool yes) {m_executedCurrently = yes;}
    uint64 GetDelayStart() const { return m_delayStart; }
    void SetDelayStart(uint64 m_time) { m_delayStart = m_time; }
    uint64 GetDelayMoment() const { return m_delayMoment; }
    uint64 GetDelayTrajectory() const { return m_delayTrajectory; }

    uint64 CalculateDelayMomentForDst() const;
    void RecalculateDelayMomentForDst();
    bool IsNeedSendToClient(bool go) const;

    CurrentSpellTypes GetCurrentContainer() const;

    Unit* GetCaster() const { return m_caster; }
    Unit* GetOriginalCaster() const { return m_originalCaster; }
    SpellInfo const* GetSpellInfo() const { return m_spellInfo; }
    int32 GetPowerCost() const { return m_powerCost; }

    bool UpdatePointers();                              // must be used at call Spell code after time delay (non triggered spell cast/update spell call/etc)

    void CleanupTargetList();

    void SetSpellValue(SpellValueMod mod, int32 value);
    SpellValue const* GetSpellValue() { return m_spellValue; }

    // xinef: moved to public
    void LoadScripts();
    std::list<TargetInfo>* GetUniqueTargetInfo() { return &m_UniqueTargetInfo; }

    [[nodiscard]] uint32 GetTriggeredByAuraTickNumber() const { return m_triggeredByAuraSpell.tickNumber; }

    [[nodiscard]] TriggerCastFlags GetTriggeredCastFlags() const { return _triggeredCastFlags; }

    [[nodiscard]] SpellSchoolMask GetSpellSchoolMask() const { return m_spellSchoolMask; }

 protected:
    bool HasGlobalCooldown() const;
    void TriggerGlobalCooldown();
    void CancelGlobalCooldown();

    void SendLoot(ObjectGuid guid, LootType loottype);

    Unit* const m_caster;

    SpellValue* const m_spellValue;

    ObjectGuid m_originalCasterGUID;                    // real source of cast (aura caster/etc), used for spell targets selection
    // e.g. damage around area spell trigered by victim aura and damage enemies of aura caster
    Unit* m_originalCaster;                             // cached pointer for m_originalCaster, updated at Spell::UpdatePointers()

    Spell** m_selfContainer;                            // pointer to our spell container (if applicable)

    std::string GetDebugInfo() const;

    //Spell data
    SpellSchoolMask m_spellSchoolMask;                  // Spell school (can be overwrite for some spells (wand shoot for example)
    WeaponAttackType m_attackType;                      // For weapon based attack
    int32 m_powerCost;                                  // Calculated spell cost     initialized only in Spell::prepare
    int32 m_casttime;                                   // Calculated spell cast time initialized only in Spell::prepare
    int32 m_channeledDuration;                          // Calculated channeled spell duration in order to calculate correct pushback.
    bool m_canReflect;                                  // can reflect this spell?

    uint8 m_spellFlags;                                 // for spells whose target was changed in cast i.e. due to reflect

    bool m_autoRepeat;
    uint8 m_runesState;

    uint8 m_delayAtDamageCount;
    bool isDelayableNoMore()
    {
        if (m_delayAtDamageCount >= 2)
            return true;

        m_delayAtDamageCount++;
        return false;
    }

    // Delayed spells system
    uint64 m_delayStart;                                // time of spell delay start, filled by event handler, zero = just started
    uint64 m_delayMoment;                               // moment of next delay call, used internally
    uint64 m_delayTrajectory;                           // Xinef: Trajectory delay
    bool m_immediateHandled;                            // were immediate actions handled? (used by delayed spells only)

    // These vars are used in both delayed spell system and modified immediate spell system
    bool m_referencedFromCurrentSpell;                  // mark as references to prevent deleted and access by dead pointers
    bool m_executedCurrently;                           // mark as executed to prevent deleted and access by dead pointers
    bool m_needComboPoints;
    uint8 m_applyMultiplierMask;
    float m_damageMultipliers[3];

    // Current targets, to be used in SpellEffects (MUST BE USED ONLY IN SPELL EFFECTS)
    Unit* unitTarget;
    Item* itemTarget;
    GameObject* gameObjTarget;
    WorldLocation* destTarget;
    int32 damage;
    SpellEffectHandleMode effectHandleMode;
    // used in effects handlers
    Aura* m_spellAura;

    // this is set in Spell Hit, but used in Apply Aura handler
    DiminishingLevels m_diminishLevel;
    DiminishingGroup m_diminishGroup;

    // -------------------------------------------
    GameObject* focusObject;

    // Damage and healing in effects need just calculate
    int32 m_damage;           // Damge   in effects count here
    int32 m_healing;          // Healing in effects count here

    // ******************************************
    // Spell trigger system
    // ******************************************
    uint32 m_procAttacker;                // Attacker trigger flags
    uint32 m_procVictim;                  // Victim   trigger flags
    uint32 m_procEx;
    void   prepareDataForTriggerSystem(AuraEffect const* triggeredByAura);

    // *****************************************
    // Spell target subsystem
    // *****************************************
    std::list<TargetInfo> m_UniqueTargetInfo;
    uint8 m_channelTargetEffectMask;                        // Mask req. alive targets

    struct GOTargetInfo
    {
        ObjectGuid targetGUID;
        uint64 timeDelay;
        uint8  effectMask: 8;
        bool   processed: 1;
    };
    std::list<GOTargetInfo> m_UniqueGOTargetInfo;

    struct ItemTargetInfo
    {
        Item*  item;
        uint8 effectMask;
    };
    std::list<ItemTargetInfo> m_UniqueItemInfo;

    SpellDestination m_destTargets[MAX_SPELL_EFFECTS];

    void AddUnitTarget(Unit* target, uint32 effectMask, bool checkIfValid = true, bool implicit = true);
    void AddGOTarget(GameObject* target, uint32 effectMask);
    void AddItemTarget(Item* item, uint32 effectMask);
    void AddDestTarget(SpellDestination const& dest, uint32 effIndex);

    void DoAllEffectOnTarget(TargetInfo* target);
    SpellMissInfo DoSpellHitOnUnit(Unit* unit, uint32 effectMask, bool scaleAura);
    void DoTriggersOnSpellHit(Unit* unit, uint8 effMask);
    void DoAllEffectOnTarget(GOTargetInfo* target);
    void DoAllEffectOnTarget(ItemTargetInfo* target);
    bool UpdateChanneledTargetList();
    bool IsValidDeadOrAliveTarget(Unit const* target) const;
    void HandleLaunchPhase();
    void DoAllEffectOnLaunchTarget(TargetInfo& targetInfo, float* multiplier);

    void PrepareTargetProcessing();
    void FinishTargetProcessing();

    // spell execution log
    void InitEffectExecuteData(uint8 effIndex);
    void CheckEffectExecuteData();

    // Scripting system
    bool _scriptsLoaded;
    //void LoadScripts();
    void CallScriptBeforeCastHandlers();
    void CallScriptOnCastHandlers();
    void CallScriptAfterCastHandlers();
    SpellCastResult CallScriptCheckCastHandlers();
    void PrepareScriptHitHandlers();
    bool CallScriptEffectHandlers(SpellEffIndex effIndex, SpellEffectHandleMode mode);
    void CallScriptBeforeHitHandlers(SpellMissInfo missInfo);
    void CallScriptOnHitHandlers();
    void CallScriptAfterHitHandlers();
    void CallScriptObjectAreaTargetSelectHandlers(std::list<WorldObject*>& targets, SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void CallScriptObjectTargetSelectHandlers(WorldObject*& target, SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    void CallScriptDestinationTargetSelectHandlers(SpellDestination& target, SpellEffIndex effIndex, SpellImplicitTargetInfo const& targetType);
    bool CheckScriptEffectImplicitTargets(uint32 effIndex, uint32 effIndexToCheck);
    std::list<SpellScript*> m_loadedScripts;

    struct HitTriggerSpell
    {
        SpellInfo const* triggeredSpell;
        SpellInfo const* triggeredByAura;
        uint8 triggeredByEffIdx;
        int32 chance;
    };

    bool CanExecuteTriggersOnHit(uint8 effMask, SpellInfo const* triggeredByAura = nullptr) const;
    void PrepareTriggersExecutedOnHit();
    typedef std::list<HitTriggerSpell> HitTriggerSpellList;
    HitTriggerSpellList m_hitTriggerSpells;

    // effect helpers
    void SummonGuardian(uint32 i, uint32 entry, SummonPropertiesEntry const* properties, uint32 numSummons, bool personalSpawn);
    void CalculateJumpSpeeds(uint8 i, float dist, float& speedxy, float& speedz);

    SpellCastResult CanOpenLock(uint32 effIndex, uint32 lockid, SkillType& skillid, int32& reqSkillValue, int32& skillValue);
    // -------------------------------------------

    uint32 m_spellState;
    int32 m_timer;

    SpellEvent* _spellEvent;
    TriggerCastFlags _triggeredCastFlags;

    // if need this can be replaced by Aura copy
    // we can't store original aura link to prevent access to deleted auras
    // and in same time need aura data and after aura deleting.
    TriggeredByAuraSpellData m_triggeredByAuraSpell;

    bool m_skipCheck;
    uint8 m_auraScaleMask;
    std::unique_ptr<PathGenerator> m_preGeneratedPath;

    // xinef:
    bool _spellTargetsSelected;

    ByteBuffer* m_effectExecuteData[MAX_SPELL_EFFECTS];
};

namespace Acore
{
    struct WorldObjectSpellTargetCheck
    {
        Unit* _caster;
        Unit* _referer;
        SpellInfo const* _spellInfo;
        SpellTargetCheckTypes _targetSelectionType;
        ConditionSourceInfo* _condSrcInfo;
        ConditionList* _condList;

        WorldObjectSpellTargetCheck(Unit* caster, Unit* referer, SpellInfo const* spellInfo,
                                    SpellTargetCheckTypes selectionType, ConditionList* condList);
        ~WorldObjectSpellTargetCheck();
        bool operator()(WorldObject* target);
    };

    struct WorldObjectSpellNearbyTargetCheck : public WorldObjectSpellTargetCheck
    {
        float _range;
        Position const* _position;
        WorldObjectSpellNearbyTargetCheck(float range, Unit* caster, SpellInfo const* spellInfo,
                                          SpellTargetCheckTypes selectionType, ConditionList* condList);
        bool operator()(WorldObject* target);
    };

    struct WorldObjectSpellAreaTargetCheck : public WorldObjectSpellTargetCheck
    {
        float _range;
        Position const* _position;
        WorldObjectSpellAreaTargetCheck(float range, Position const* position, Unit* caster,
                                        Unit* referer, SpellInfo const* spellInfo, SpellTargetCheckTypes selectionType, ConditionList* condList);
        bool operator()(WorldObject* target);
    };

    struct WorldObjectSpellConeTargetCheck : public WorldObjectSpellAreaTargetCheck
    {
        float _coneAngle;
        WorldObjectSpellConeTargetCheck(float coneAngle, float range, Unit* caster,
                                        SpellInfo const* spellInfo, SpellTargetCheckTypes selectionType, ConditionList* condList);
        bool operator()(WorldObject* target);
    };

    struct WorldObjectSpellTrajTargetCheck : public WorldObjectSpellAreaTargetCheck
    {
        WorldObjectSpellTrajTargetCheck(float range, Position const* position, Unit* caster,
                                        SpellInfo const* spellInfo, SpellTargetCheckTypes selectionType, ConditionList* condList);
        bool operator()(WorldObject* target);
    };
}

typedef void(Spell::*pEffect)(SpellEffIndex effIndex);

class ReflectEvent : public BasicEvent
{
    public:
        ReflectEvent(Unit* caster, ObjectGuid targetGUID, SpellInfo const* spellInfo) : _caster(caster), _targetGUID(targetGUID), _spellInfo(spellInfo) { }
        bool Execute(uint64 e_time, uint32 p_time) override;

    protected:
        Unit* _caster;
        ObjectGuid _targetGUID;
        SpellInfo const* _spellInfo;
};

#endif
