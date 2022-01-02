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

#ifndef AZEROTHCORE_CREATURE_H
#define AZEROTHCORE_CREATURE_H

#include "Cell.h"
#include "Common.h"
#include "CreatureData.h"
#include "DatabaseEnv.h"
#include "ItemTemplate.h"
#include "LootMgr.h"
#include "Unit.h"
#include "UpdateMask.h"
#include "World.h"
#include <list>

class SpellInfo;

class CreatureAI;
class Quest;
class Player;
class WorldSession;
class CreatureGroup;

// max different by z coordinate for creature aggro reaction
#define CREATURE_Z_ATTACK_RANGE 3

#define MAX_VENDOR_ITEMS 150                                // Limitation in 3.x.x item count in SMSG_LIST_INVENTORY

class Creature : public Unit, public GridObject<Creature>, public MovableMapObject
{
public:
    explicit Creature(bool isWorldObject = false);
    ~Creature() override;

    void AddToWorld() override;
    void RemoveFromWorld() override;

    void SetObjectScale(float scale) override;
    void SetDisplayId(uint32 modelId) override;

    void DisappearAndDie();

    [[nodiscard]] auto isVendorWithIconSpeak() const -> bool;

    auto Create(ObjectGuid::LowType guidlow, Map* map, uint32 phaseMask, uint32 Entry, uint32 vehId, float x, float y, float z, float ang, const CreatureData* data = nullptr) -> bool;
    auto LoadCreaturesAddon(bool reload = false) -> bool;
    void SelectLevel(bool changelevel = true);
    void LoadEquipment(int8 id = 1, bool force = false);

    [[nodiscard]] auto GetSpawnId() const -> ObjectGuid::LowType { return m_spawnId; }

    void Update(uint32 time) override;                         // overwrited Unit::Update
    void GetRespawnPosition(float& x, float& y, float& z, float* ori = nullptr, float* dist = nullptr) const;

    void SetCorpseDelay(uint32 delay) { m_corpseDelay = delay; }
    [[nodiscard]] auto GetCorpseDelay() const -> uint32 { return m_corpseDelay; }
    [[nodiscard]] auto IsRacialLeader() const -> bool { return GetCreatureTemplate()->RacialLeader; }
    [[nodiscard]] auto IsCivilian() const -> bool { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_CIVILIAN; }
    [[nodiscard]] auto IsTrigger() const -> bool { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_TRIGGER; }
    [[nodiscard]] auto IsGuard() const -> bool { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_GUARD; }
    [[nodiscard]] auto CanWalk() const -> bool { return GetCreatureTemplate()->InhabitType & INHABIT_GROUND; }
    [[nodiscard]] auto CanSwim() const -> bool override;
    [[nodiscard]] auto CanEnterWater() const -> bool override;
    [[nodiscard]] auto CanFly()  const -> bool override;
    [[nodiscard]] auto CanHover() const -> bool { return m_originalAnimTier & UNIT_BYTE1_FLAG_HOVER || IsHovering(); }

    void SetReactState(ReactStates st) { m_reactState = st; }
    [[nodiscard]] auto GetReactState() const -> ReactStates { return m_reactState; }
    [[nodiscard]] auto HasReactState(ReactStates state) const -> bool { return (m_reactState == state); }
    void InitializeReactState();

    ///// TODO RENAME THIS!!!!!
    auto isCanInteractWithBattleMaster(Player* player, bool msg) const -> bool;
    auto isCanTrainingAndResetTalentsOf(Player* player) const -> bool;
    [[nodiscard]] auto IsValidTrainerForPlayer(Player* player, uint32* npcFlags = nullptr) const -> bool;
    auto CanCreatureAttack(Unit const* victim, bool skipDistCheck = false) const -> bool;
    void LoadSpellTemplateImmunity();
    auto IsImmunedToSpell(SpellInfo const* spellInfo) -> bool override;

    [[nodiscard]] auto HasMechanicTemplateImmunity(uint32 mask) const -> bool;
    // redefine Unit::IsImmunedToSpell
    auto IsImmunedToSpellEffect(SpellInfo const* spellInfo, uint32 index) const -> bool override;
    // redefine Unit::IsImmunedToSpellEffect
    [[nodiscard]] auto isElite() const -> bool
    {
        if (IsPet())
            return false;

        uint32 rank = GetCreatureTemplate()->rank;
        return rank != CREATURE_ELITE_NORMAL && rank != CREATURE_ELITE_RARE;
    }

    [[nodiscard]] auto isWorldBoss() const -> bool
    {
        if (IsPet())
            return false;

        return GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_BOSS_MOB;
    }

    [[nodiscard]] auto IsDungeonBoss() const -> bool;
    [[nodiscard]] auto IsImmuneToKnockback() const -> bool;
    [[nodiscard]] auto IsAvoidingAOE() const -> bool { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_AVOID_AOE; }

    auto getLevelForTarget(WorldObject const* target) const -> uint8 override; // overwrite Unit::getLevelForTarget for boss level support

    [[nodiscard]] auto IsInEvadeMode() const -> bool { return HasUnitState(UNIT_STATE_EVADE); }
    [[nodiscard]] auto IsEvadingAttacks() const -> bool { return IsInEvadeMode() || CanNotReachTarget(); }

    auto AIM_Initialize(CreatureAI* ai = nullptr) -> bool;
    void Motion_Initialize();

    [[nodiscard]] auto AI() const -> CreatureAI* { return (CreatureAI*)i_AI; }

    auto SetWalk(bool enable) -> bool override;
    auto SetDisableGravity(bool disable, bool packetOnly = false) -> bool override;
    auto SetSwim(bool enable) -> bool override;
    auto SetCanFly(bool enable, bool packetOnly = false) -> bool override;
    auto SetWaterWalking(bool enable, bool packetOnly = false) -> bool override;
    auto SetFeatherFall(bool enable, bool packetOnly = false) -> bool override;
    auto SetHover(bool enable, bool packetOnly = false) -> bool override;
    auto HasSpellFocus(Spell const* focusSpell = nullptr) const -> bool;

    struct
    {
        ::Spell const* Spell = nullptr;
        uint32 Delay = 0;         // ms until the creature's target should snap back (0 = no snapback scheduled)
        ObjectGuid Target;        // the creature's "real" target while casting
        float Orientation = 0.0f; // the creature's "real" orientation while casting
    } _spellFocusInfo;

    [[nodiscard]] auto GetShieldBlockValue() const -> uint32 override
    {
        return (getLevel() / 2 + uint32(GetStat(STAT_STRENGTH) / 20));
    }

    [[nodiscard]] auto GetMeleeDamageSchoolMask() const -> SpellSchoolMask override { return m_meleeDamageSchoolMask; }
    void SetMeleeDamageSchool(SpellSchools school) { m_meleeDamageSchoolMask = SpellSchoolMask(1 << school); }

    void _AddCreatureSpellCooldown(uint32 spell_id, uint16 categoryId, uint32 end_time);
    void AddSpellCooldown(uint32 spell_id, uint32 /*itemid*/, uint32 end_time, bool needSendToClient = false, bool forceSendToSpectator = false) override;
    [[nodiscard]] auto HasSpellCooldown(uint32 spell_id) const -> bool override;
    [[nodiscard]] auto GetSpellCooldown(uint32 spell_id) const -> uint32;
    void ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs) override;
    [[nodiscard]] auto IsSpellProhibited(SpellSchoolMask idSchoolMask) const -> bool;

    [[nodiscard]] auto HasSpell(uint32 spellID) const -> bool override;

    void UpdateMovementFlags();

    auto UpdateEntry(uint32 entry, const CreatureData* data = nullptr, bool changelevel = true ) -> bool;
    auto UpdateStats(Stats stat) -> bool override;
    auto UpdateAllStats() -> bool override;
    void UpdateResistances(uint32 school) override;
    void UpdateArmor() override;
    void UpdateMaxHealth() override;
    void UpdateMaxPower(Powers power) override;
    void UpdateAttackPowerAndDamage(bool ranged = false) override;
    void CalculateMinMaxDamage(WeaponAttackType attType, bool normalized, bool addTotalPct, float& minDamage, float& maxDamage) override;

    void SetCanDualWield(bool value) override;
    [[nodiscard]] auto GetOriginalEquipmentId() const -> int8 { return m_originalEquipmentId; }
    auto GetCurrentEquipmentId() -> uint8 { return m_equipmentId; }
    void SetCurrentEquipmentId(uint8 id) { m_equipmentId = id; }

    auto GetSpellDamageMod(int32 Rank) -> float;

    [[nodiscard]] auto GetVendorItems() const -> VendorItemData const*;
    auto GetVendorItemCurrentCount(VendorItem const* vItem) -> uint32;
    auto UpdateVendorItemCurrentCount(VendorItem const* vItem, uint32 used_count) -> uint32;

    [[nodiscard]] auto GetTrainerSpells() const -> TrainerSpellData const*;

    [[nodiscard]] auto GetCreatureTemplate() const -> CreatureTemplate const* { return m_creatureInfo; }
    [[nodiscard]] auto GetCreatureData() const -> CreatureData const* { return m_creatureData; }
    void SetDetectionDistance(float dist){ m_detectionDistance = dist; }
    [[nodiscard]] auto GetCreatureAddon() const -> CreatureAddon const*;

    [[nodiscard]] auto GetAIName() const -> std::string;
    [[nodiscard]] auto GetScriptName() const -> std::string;
    [[nodiscard]] auto GetScriptId() const -> uint32;

    // override WorldObject function for proper name localization
    [[nodiscard]] auto GetNameForLocaleIdx(LocaleConstant locale_idx) const -> std::string const& override;

    void setDeathState(DeathState s, bool despawn = false) override;                   // override virtual Unit::setDeathState

    auto LoadFromDB(ObjectGuid::LowType guid, Map* map, bool allowDuplicate = false) -> bool { return LoadCreatureFromDB(guid, map, false, true, allowDuplicate); }
    auto LoadCreatureFromDB(ObjectGuid::LowType guid, Map* map, bool addToMap = true, bool gridLoad = false, bool allowDuplicate = false) -> bool;
    void SaveToDB();
    // overriden in Pet
    virtual void SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask);
    virtual void DeleteFromDB();                        // overriden in Pet

    Loot loot;
    [[nodiscard]] auto GetLootRecipientGUID() const -> ObjectGuid { return m_lootRecipient; }
    [[nodiscard]] auto GetLootRecipient() const -> Player*;
    [[nodiscard]] auto GetLootRecipientGroupGUID() const -> ObjectGuid::LowType { return m_lootRecipientGroup; }
    [[nodiscard]] auto GetLootRecipientGroup() const -> Group*;
    [[nodiscard]] auto hasLootRecipient() const -> bool { return m_lootRecipient || m_lootRecipientGroup; }
    auto isTappedBy(Player const* player) const -> bool;                          // return true if the creature is tapped by the player or a member of his party.
    [[nodiscard]] auto CanGeneratePickPocketLoot() const -> bool { return lootPickPocketRestoreTime == 0 || lootPickPocketRestoreTime < time(nullptr); }
    void SetPickPocketLootTime() { lootPickPocketRestoreTime = time(nullptr) + MINUTE + GetCorpseDelay() + GetRespawnTime(); }
    void ResetPickPocketLootTime() { lootPickPocketRestoreTime = 0; }

    void SetLootRecipient (Unit* unit, bool withGroup = true);
    void AllLootRemovedFromCorpse();

    [[nodiscard]] auto GetLootMode() const -> uint16 { return m_LootMode; }
    [[nodiscard]] auto HasLootMode(uint16 lootMode) const -> bool { return m_LootMode & lootMode; }
    void SetLootMode(uint16 lootMode) { m_LootMode = lootMode; }
    void AddLootMode(uint16 lootMode) { m_LootMode |= lootMode; }
    void RemoveLootMode(uint16 lootMode) { m_LootMode &= ~lootMode; }
    void ResetLootMode() { m_LootMode = LOOT_MODE_DEFAULT; }

    auto reachWithSpellAttack(Unit* victim) -> SpellInfo const*;
    auto reachWithSpellCure(Unit* victim) -> SpellInfo const*;

    uint32 m_spells[MAX_CREATURE_SPELLS];
    CreatureSpellCooldowns m_CreatureSpellCooldowns;
    uint32 m_ProhibitSchoolTime[7];

    auto CanStartAttack(Unit const* u) const -> bool;
    auto GetAggroRange(Unit const* target) const -> float;
    auto GetAttackDistance(Unit const* player) const -> float;
    [[nodiscard]] auto GetDetectionRange() const -> float { return m_detectionDistance; }

    void SendAIReaction(AiReaction reactionType);

    [[nodiscard]] auto SelectNearestTarget(float dist = 0, bool playerOnly = false) const -> Unit*;
    [[nodiscard]] auto SelectNearestTargetInAttackDistance(float dist) const -> Unit*;

    void DoFleeToGetAssistance();
    void CallForHelp(float fRadius, Unit* target = nullptr);
    void CallAssistance(Unit* target = nullptr);
    void SetNoCallAssistance(bool val) { m_AlreadyCallAssistance = val; }
    void SetNoSearchAssistance(bool val) { m_AlreadySearchedAssistance = val; }
    auto HasSearchedAssistance() -> bool { return m_AlreadySearchedAssistance; }
    auto CanAssistTo(const Unit* u, const Unit* enemy, bool checkfaction = true) const -> bool;
    auto _IsTargetAcceptable(const Unit* target) const -> bool;
    [[nodiscard]] auto CanIgnoreFeignDeath() const -> bool { return (GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_IGNORE_FEIGN_DEATH) != 0; }

    // pussywizard: updated at faction change, disable move in line of sight if actual faction is not hostile to anyone
    void UpdateMoveInLineOfSightState();
    auto IsMoveInLineOfSightDisabled() -> bool { return m_moveInLineOfSightDisabled; }
    auto IsMoveInLineOfSightStrictlyDisabled() -> bool { return m_moveInLineOfSightStrictlyDisabled; }

    [[nodiscard]] auto GetDefaultMovementType() const -> MovementGeneratorType { return m_defaultMovementType; }
    void SetDefaultMovementType(MovementGeneratorType mgt) { m_defaultMovementType = mgt; }

    void RemoveCorpse(bool setSpawnTime = true, bool skipVisibility = false);

    void DespawnOrUnsummon(Milliseconds msTimeToDespawn, Seconds forcedRespawnTimer);
    void DespawnOrUnsummon(uint32 msTimeToDespawn = 0) { DespawnOrUnsummon(Milliseconds(msTimeToDespawn), 0s); };
    void DespawnOnEvade();
    void RespawnOnEvade();

    [[nodiscard]] auto GetRespawnTime() const -> time_t const& { return m_respawnTime; }
    [[nodiscard]] auto GetRespawnTimeEx() const -> time_t;
    void SetRespawnTime(uint32 respawn) { m_respawnTime = respawn ? time(nullptr) + respawn : 0; }
    void Respawn(bool force = false);
    void SaveRespawnTime() override;

    [[nodiscard]] auto GetRespawnDelay() const -> uint32 { return m_respawnDelay; }
    void SetRespawnDelay(uint32 delay) { m_respawnDelay = delay; }

    [[nodiscard]] auto GetWanderDistance() const -> float { return m_wanderDistance; }
    void SetWanderDistance(float dist) { m_wanderDistance = dist; }

    uint32 m_groupLootTimer;                            // (msecs)timer used for group loot
    uint32 lootingGroupLowGUID;                         // used to find group which is looting corpse

    void SendZoneUnderAttackMessage(Player* attacker);

    void SetInCombatWithZone();

    [[nodiscard]] auto hasQuest(uint32 quest_id) const -> bool override;
    [[nodiscard]] auto hasInvolvedQuest(uint32 quest_id)  const -> bool override;

    auto isRegeneratingHealth() -> bool { return m_regenHealth; }
    void SetRegeneratingHealth(bool c) { m_regenHealth = c; }
    [[nodiscard]] virtual auto GetPetAutoSpellSize() const -> uint8 { return MAX_SPELL_CHARM; }
    [[nodiscard]] virtual auto GetPetAutoSpellOnPos(uint8 pos) const -> uint32
    {
        if (pos >= MAX_SPELL_CHARM || m_charmInfo->GetCharmSpell(pos)->GetType() != ACT_ENABLED)
            return 0;
        else
            return m_charmInfo->GetCharmSpell(pos)->GetAction();
    }

    void SetCannotReachTarget(bool cannotReach);
    [[nodiscard]] auto CanNotReachTarget() const -> bool { return m_cannotReachTarget; }
    [[nodiscard]] auto IsNotReachable() const -> bool { return (m_cannotReachTimer >= (sWorld->getIntConfig(CONFIG_NPC_EVADE_IF_NOT_REACHABLE) * IN_MILLISECONDS)) && m_cannotReachTarget; }
    [[nodiscard]] auto IsNotReachableAndNeedRegen() const -> bool { return (m_cannotReachTimer >= (sWorld->getIntConfig(CONFIG_NPC_REGEN_TIME_IF_NOT_REACHABLE_IN_RAID) * IN_MILLISECONDS)) && m_cannotReachTarget; }

    void SetPosition(float x, float y, float z, float o);
    void SetPosition(const Position& pos) { SetPosition(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation()); }

    void SetHomePosition(float x, float y, float z, float o) { m_homePosition.Relocate(x, y, z, o); }
    void SetHomePosition(const Position& pos) { m_homePosition.Relocate(pos); }
    void GetHomePosition(float& x, float& y, float& z, float& ori) const { m_homePosition.GetPosition(x, y, z, ori); }
    [[nodiscard]] auto GetHomePosition() const -> Position const& { return m_homePosition; }

    void SetTransportHomePosition(float x, float y, float z, float o) { m_transportHomePosition.Relocate(x, y, z, o); }
    void SetTransportHomePosition(const Position& pos) { m_transportHomePosition.Relocate(pos); }
    void GetTransportHomePosition(float& x, float& y, float& z, float& ori) const { m_transportHomePosition.GetPosition(x, y, z, ori); }
    [[nodiscard]] auto GetTransportHomePosition() const -> Position const& { return m_transportHomePosition; }

    [[nodiscard]] auto GetWaypointPath() const -> uint32 { return m_path_id; }
    void LoadPath(uint32 pathid) { m_path_id = pathid; }

    [[nodiscard]] auto GetCurrentWaypointID() const -> uint32 { return m_waypointID; }
    void UpdateWaypointID(uint32 wpID) { m_waypointID = wpID; }

    void SearchFormation();
    [[nodiscard]] auto GetFormation() const -> CreatureGroup const* { return m_formation; }
    [[nodiscard]] auto GetFormation() -> CreatureGroup* { return m_formation; }
    void SetFormation(CreatureGroup* formation) { m_formation = formation; }

    auto SelectVictim() -> Unit*;

    void SetDisableReputationGain(bool disable) { DisableReputationGain = disable; }
    [[nodiscard]] auto IsReputationGainDisabled() const -> bool { return DisableReputationGain; }
    [[nodiscard]] auto IsDamageEnoughForLootingAndReward() const -> bool { return (m_creatureInfo->flags_extra & CREATURE_FLAG_EXTRA_NO_PLAYER_DAMAGE_REQ) || (m_PlayerDamageReq == 0); }
    void LowerPlayerDamageReq(uint32 unDamage)
    {
        if (m_PlayerDamageReq)
            m_PlayerDamageReq > unDamage ? m_PlayerDamageReq -= unDamage : m_PlayerDamageReq = 0;
    }
    void ResetPlayerDamageReq() { m_PlayerDamageReq = GetHealth() / 2; }
    uint32 m_PlayerDamageReq;

    [[nodiscard]] auto GetOriginalEntry() const -> uint32 { return m_originalEntry; }
    void SetOriginalEntry(uint32 entry) { m_originalEntry = entry; }

    static auto _GetDamageMod(int32 Rank) -> float;

    float m_SightDistance, m_CombatDistance;

    bool m_isTempWorldObject; //true when possessed

    // Handling caster facing during spellcast
    void SetTarget(ObjectGuid guid = ObjectGuid::Empty) override;
    void FocusTarget(Spell const* focusSpell, WorldObject const* target);
    void ReleaseFocus(Spell const* focusSpell);
    [[nodiscard]] auto IsMovementPreventedByCasting() const -> bool override;

    // Part of Evade mechanics
    [[nodiscard]] auto GetLastDamagedTime() const -> time_t;
    [[nodiscard]] auto GetLastDamagedTimePtr() const -> std::shared_ptr<time_t> const&;
    void SetLastDamagedTime(time_t val);
    void SetLastDamagedTimePtr(std::shared_ptr<time_t> const& val);

    auto IsFreeToMove() -> bool;
    static constexpr uint32 MOVE_CIRCLE_CHECK_INTERVAL = 3000;
    static constexpr uint32 MOVE_BACKWARDS_CHECK_INTERVAL = 2000;
    uint32 m_moveCircleMovementTime = MOVE_CIRCLE_CHECK_INTERVAL;
    uint32 m_moveBackwardsMovementTime = MOVE_BACKWARDS_CHECK_INTERVAL;

    [[nodiscard]] auto HasSwimmingFlagOutOfCombat() const -> bool
    {
        return !_isMissingSwimmingFlagOutOfCombat;
    }
    void RefreshSwimmingFlag(bool recheck = false);

    void SetAssistanceTimer(uint32 value) { m_assistanceTimer = value; }

protected:
    auto CreateFromProto(ObjectGuid::LowType guidlow, uint32 Entry, uint32 vehId, const CreatureData* data = nullptr) -> bool;
    auto InitEntry(uint32 entry, const CreatureData* data = nullptr) -> bool;

    // vendor items
    VendorItemCounts m_vendorItemCounts;

    static auto _GetHealthMod(int32 Rank) -> float;

    ObjectGuid m_lootRecipient;
    ObjectGuid::LowType m_lootRecipientGroup;

    /// Timers
    time_t m_corpseRemoveTime;                          // (msecs)timer for death or corpse disappearance
    time_t m_respawnTime;                               // (secs) time of next respawn
    time_t m_respawnedTime;                             // (secs) time when creature respawned
    uint32 m_respawnDelay;                              // (secs) delay between corpse disappearance and respawning
    uint32 m_corpseDelay;                               // (secs) delay between death and corpse disappearance
    float m_wanderDistance;
    uint16 m_transportCheckTimer;
    uint32 lootPickPocketRestoreTime;

    ReactStates m_reactState;                           // for AI, not charmInfo
    void RegenerateHealth();
    void Regenerate(Powers power);
    MovementGeneratorType m_defaultMovementType;
    ObjectGuid::LowType m_spawnId;                      ///< For new or temporary creatures is 0 for saved it is lowguid
    uint8 m_equipmentId;
    int8 m_originalEquipmentId; // can be -1

    uint8 m_originalAnimTier;

    bool m_AlreadyCallAssistance;
    bool m_AlreadySearchedAssistance;
    bool m_regenHealth;
    bool m_AI_locked;

    SpellSchoolMask m_meleeDamageSchoolMask;
    uint32 m_originalEntry;

    bool m_moveInLineOfSightDisabled;
    bool m_moveInLineOfSightStrictlyDisabled;

    Position m_homePosition;
    Position m_transportHomePosition;

    bool DisableReputationGain;

    CreatureTemplate const* m_creatureInfo;                 // in difficulty mode > 0 can different from sObjectMgr->GetCreatureTemplate(GetEntry())
    CreatureData const* m_creatureData;

    float m_detectionDistance;
    uint16 m_LootMode;                                  // bitmask, default LOOT_MODE_DEFAULT, determines what loot will be lootable

    [[nodiscard]] auto IsInvisibleDueToDespawn() const -> bool override;
    auto CanAlwaysSee(WorldObject const* obj) const -> bool override;

private:
    void ForcedDespawn(uint32 timeMSToDespawn = 0, Seconds forcedRespawnTimer = 0s);

    [[nodiscard]] auto CanPeriodicallyCallForAssistance() const -> bool;

    //WaypointMovementGenerator vars
    uint32 m_waypointID;
    uint32 m_path_id;

    //Formation var
    CreatureGroup* m_formation;
    bool TriggerJustRespawned;

    mutable std::shared_ptr<time_t> _lastDamagedTime; // Part of Evade mechanics

    bool m_cannotReachTarget;
    uint32 m_cannotReachTimer;

    Spell const* _focusSpell;   ///> Locks the target during spell cast for proper facing

    bool _isMissingSwimmingFlagOutOfCombat;

    uint32 m_assistanceTimer;

    void applyInhabitFlags();
};

class AssistDelayEvent : public BasicEvent
{
public:
    AssistDelayEvent(ObjectGuid victim, Creature* owner) : BasicEvent(), m_victim(victim), m_owner(owner) { }

    auto Execute(uint64 e_time, uint32 p_time) -> bool override;
    void AddAssistant(ObjectGuid guid) { m_assistants.push_back(guid); }

private:
    AssistDelayEvent();

    ObjectGuid        m_victim;
    GuidList          m_assistants;
    Creature*         m_owner;
};

class ForcedDespawnDelayEvent : public BasicEvent
{
public:
    ForcedDespawnDelayEvent(Creature& owner, Seconds respawnTimer) : BasicEvent(), m_owner(owner), m_respawnTimer(respawnTimer) { }
    auto Execute(uint64 e_time, uint32 p_time) -> bool override;

private:
    Creature& m_owner;
    Seconds const m_respawnTimer;
};

#endif
