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

    [[nodiscard]] bool isVendorWithIconSpeak() const;

    bool Create(ObjectGuid::LowType guidlow, Map* map, uint32 phaseMask, uint32 Entry, uint32 vehId, float x, float y, float z, float ang, const CreatureData* data = nullptr);
    bool LoadCreaturesAddon(bool reload = false);
    void SelectLevel(bool changelevel = true);
    void LoadEquipment(int8 id = 1, bool force = false);

    [[nodiscard]] ObjectGuid::LowType GetSpawnId() const { return m_spawnId; }

    void Update(uint32 time) override;                         // overwrited Unit::Update
    void GetRespawnPosition(float& x, float& y, float& z, float* ori = nullptr, float* dist = nullptr) const;

    void SetCorpseDelay(uint32 delay) { m_corpseDelay = delay; }
    void SetCorpseRemoveTime(uint32 delay);
    [[nodiscard]] uint32 GetCorpseDelay() const { return m_corpseDelay; }
    [[nodiscard]] bool IsRacialLeader() const { return GetCreatureTemplate()->RacialLeader; }
    [[nodiscard]] bool IsCivilian() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_CIVILIAN; }
    [[nodiscard]] bool IsTrigger() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_TRIGGER; }
    [[nodiscard]] bool IsGuard() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_GUARD; }
    CreatureMovementData const& GetMovementTemplate() const;
    [[nodiscard]] bool CanWalk() const { return GetMovementTemplate().IsGroundAllowed(); }
    [[nodiscard]] bool CanSwim() const override;
    [[nodiscard]] bool CanEnterWater() const override;
    [[nodiscard]] bool CanFly()  const override { return GetMovementTemplate().IsFlightAllowed() || IsFlying(); }
    [[nodiscard]] bool CanHover() const { return GetMovementTemplate().Ground == CreatureGroundMovementType::Hover || IsHovering(); }

    MovementGeneratorType GetDefaultMovementType() const override { return m_defaultMovementType; }
    void SetDefaultMovementType(MovementGeneratorType mgt) { m_defaultMovementType = mgt; }

    void SetReactState(ReactStates st) { m_reactState = st; }
    [[nodiscard]] ReactStates GetReactState() const { return m_reactState; }
    [[nodiscard]] bool HasReactState(ReactStates state) const { return (m_reactState == state); }
    void InitializeReactState();

    ///// TODO RENAME THIS!!!!!
    bool isCanInteractWithBattleMaster(Player* player, bool msg) const;
    bool isCanTrainingAndResetTalentsOf(Player* player) const;
    [[nodiscard]] bool IsValidTrainerForPlayer(Player* player, uint32* npcFlags = nullptr) const;
    bool CanCreatureAttack(Unit const* victim, bool skipDistCheck = false) const;
    void LoadSpellTemplateImmunity();
    bool IsImmunedToSpell(SpellInfo const* spellInfo, Spell const* spell = nullptr) override;

    [[nodiscard]] bool HasMechanicTemplateImmunity(uint32 mask) const;
    // redefine Unit::IsImmunedToSpell
    bool IsImmunedToSpellEffect(SpellInfo const* spellInfo, uint32 index) const override;
    // redefine Unit::IsImmunedToSpellEffect
    [[nodiscard]] bool isElite() const
    {
        if (IsPet())
            return false;

        uint32 rank = GetCreatureTemplate()->rank;
        return rank != CREATURE_ELITE_NORMAL && rank != CREATURE_ELITE_RARE;
    }

    [[nodiscard]] bool isWorldBoss() const
    {
        if (IsPet())
            return false;

        return GetCreatureTemplate()->type_flags & CREATURE_TYPE_FLAG_BOSS_MOB;
    }

    [[nodiscard]] bool IsDungeonBoss() const;
    [[nodiscard]] bool IsImmuneToKnockback() const;
    [[nodiscard]] bool IsAvoidingAOE() const { return GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_AVOID_AOE; }

    uint8 getLevelForTarget(WorldObject const* target) const override; // overwrite Unit::getLevelForTarget for boss level support

    [[nodiscard]] bool IsInEvadeMode() const { return HasUnitState(UNIT_STATE_EVADE); }
    [[nodiscard]] bool IsEvadingAttacks() const { return IsInEvadeMode() || CanNotReachTarget(); }

    bool AIM_Initialize(CreatureAI* ai = nullptr);
    void Motion_Initialize();

    [[nodiscard]] CreatureAI* AI() const { return (CreatureAI*)i_AI; }

    bool SetWalk(bool enable) override;
    bool SetDisableGravity(bool disable, bool packetOnly = false, bool updateAnimationTier = true) override;
    bool SetSwim(bool enable) override;
    bool SetCanFly(bool enable, bool packetOnly = false) override;
    bool SetWaterWalking(bool enable, bool packetOnly = false) override;
    bool SetFeatherFall(bool enable, bool packetOnly = false) override;
    bool SetHover(bool enable, bool packetOnly = false, bool updateAnimationTier = true) override;
    bool HasSpellFocus(Spell const* focusSpell = nullptr) const;

    struct
    {
        ::Spell const* Spell = nullptr;
        uint32 Delay = 0;         // ms until the creature's target should snap back (0 = no snapback scheduled)
        ObjectGuid Target;        // the creature's "real" target while casting
        float Orientation = 0.0f; // the creature's "real" orientation while casting
    } _spellFocusInfo;

    [[nodiscard]] uint32 GetShieldBlockValue() const override
    {
        return (getLevel() / 2 + uint32(GetStat(STAT_STRENGTH) / 20));
    }

    [[nodiscard]] SpellSchoolMask GetMeleeDamageSchoolMask(WeaponAttackType /*attackType*/ = BASE_ATTACK, uint8 /*damageIndex*/ = 0) const override { return m_meleeDamageSchoolMask; }
    void SetMeleeDamageSchool(SpellSchools school) { m_meleeDamageSchoolMask = SpellSchoolMask(1 << school); }

    void _AddCreatureSpellCooldown(uint32 spell_id, uint16 categoryId, uint32 end_time);
    void AddSpellCooldown(uint32 spell_id, uint32 /*itemid*/, uint32 end_time, bool needSendToClient = false, bool forceSendToSpectator = false) override;
    [[nodiscard]] bool HasSpellCooldown(uint32 spell_id) const override;
    [[nodiscard]] uint32 GetSpellCooldown(uint32 spell_id) const;
    void ProhibitSpellSchool(SpellSchoolMask idSchoolMask, uint32 unTimeMs) override;
    [[nodiscard]] bool IsSpellProhibited(SpellSchoolMask idSchoolMask) const;

    [[nodiscard]] bool HasSpell(uint32 spellID) const override;

    void UpdateMovementFlags();
    uint32 GetRandomId(uint32 id1, uint32 id2, uint32 id3);
    bool UpdateEntry(uint32 entry, const CreatureData* data = nullptr, bool changelevel = true, bool updateAI = false);
    bool UpdateEntry(uint32 entry, bool updateAI) { return UpdateEntry(entry, nullptr, true, updateAI); }
    bool UpdateStats(Stats stat) override;
    bool UpdateAllStats() override;
    void UpdateResistances(uint32 school) override;
    void UpdateArmor() override;
    void UpdateMaxHealth() override;
    void UpdateMaxPower(Powers power) override;
    void UpdateAttackPowerAndDamage(bool ranged = false) override;
    void CalculateMinMaxDamage(WeaponAttackType attType, bool normalized, bool addTotalPct, float& minDamage, float& maxDamage, uint8 damageIndex) override;

    void SetCanDualWield(bool value) override;
    [[nodiscard]] int8 GetOriginalEquipmentId() const { return m_originalEquipmentId; }
    uint8 GetCurrentEquipmentId() { return m_equipmentId; }
    void SetCurrentEquipmentId(uint8 id) { m_equipmentId = id; }

    float GetSpellDamageMod(int32 Rank);

    [[nodiscard]] VendorItemData const* GetVendorItems() const;
    uint32 GetVendorItemCurrentCount(VendorItem const* vItem);
    uint32 UpdateVendorItemCurrentCount(VendorItem const* vItem, uint32 used_count);

    [[nodiscard]] TrainerSpellData const* GetTrainerSpells() const;

    [[nodiscard]] CreatureTemplate const* GetCreatureTemplate() const { return m_creatureInfo; }
    [[nodiscard]] CreatureData const* GetCreatureData() const { return m_creatureData; }
    void SetDetectionDistance(float dist){ m_detectionDistance = dist; }
    [[nodiscard]] CreatureAddon const* GetCreatureAddon() const;

    [[nodiscard]] std::string const& GetAIName() const;
    [[nodiscard]] std::string GetScriptName() const;
    [[nodiscard]] uint32 GetScriptId() const;

    // override WorldObject function for proper name localization
    [[nodiscard]] std::string const& GetNameForLocaleIdx(LocaleConstant locale_idx) const override;

    void setDeathState(DeathState s, bool despawn = false) override;                   // override virtual Unit::setDeathState

    bool LoadFromDB(ObjectGuid::LowType guid, Map* map, bool allowDuplicate = false) { return LoadCreatureFromDB(guid, map, false, true, allowDuplicate); }
    bool LoadCreatureFromDB(ObjectGuid::LowType guid, Map* map, bool addToMap = true, bool gridLoad = false, bool allowDuplicate = false);
    void SaveToDB();
    // overriden in Pet
    virtual void SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask);
    virtual void DeleteFromDB();                        // overriden in Pet

    Loot loot;
    [[nodiscard]] ObjectGuid GetLootRecipientGUID() const { return m_lootRecipient; }
    [[nodiscard]] Player* GetLootRecipient() const;
    [[nodiscard]] ObjectGuid::LowType GetLootRecipientGroupGUID() const { return m_lootRecipientGroup; }
    [[nodiscard]] Group* GetLootRecipientGroup() const;
    [[nodiscard]] bool hasLootRecipient() const { return m_lootRecipient || m_lootRecipientGroup; }
    bool isTappedBy(Player const* player) const;                          // return true if the creature is tapped by the player or a member of his party.
    [[nodiscard]] bool CanGeneratePickPocketLoot() const;
    void SetPickPocketLootTime();
    void ResetPickPocketLootTime() { lootPickPocketRestoreTime = 0; }

    void SetLootRecipient (Unit* unit, bool withGroup = true);
    void AllLootRemovedFromCorpse();

    [[nodiscard]] uint16 GetLootMode() const { return m_LootMode; }
    [[nodiscard]] bool HasLootMode(uint16 lootMode) const { return m_LootMode & lootMode; }
    void SetLootMode(uint16 lootMode) { m_LootMode = lootMode; }
    void AddLootMode(uint16 lootMode) { m_LootMode |= lootMode; }
    void RemoveLootMode(uint16 lootMode) { m_LootMode &= ~lootMode; }
    void ResetLootMode() { m_LootMode = LOOT_MODE_DEFAULT; }

    SpellInfo const* reachWithSpellAttack(Unit* victim);
    SpellInfo const* reachWithSpellCure(Unit* victim);

    uint32 m_spells[MAX_CREATURE_SPELLS];
    CreatureSpellCooldowns m_CreatureSpellCooldowns;
    uint32 m_ProhibitSchoolTime[7];

    bool CanStartAttack(Unit const* u) const;
    float GetAggroRange(Unit const* target) const;
    float GetAttackDistance(Unit const* player) const;
    [[nodiscard]] float GetDetectionRange() const { return m_detectionDistance; }

    void SendAIReaction(AiReaction reactionType);

    [[nodiscard]] Unit* SelectNearestTarget(float dist = 0, bool playerOnly = false) const;
    [[nodiscard]] Unit* SelectNearestTargetInAttackDistance(float dist) const;

    void DoFleeToGetAssistance();
    void CallForHelp(float fRadius, Unit* target = nullptr);
    void CallAssistance(Unit* target = nullptr);
    void SetNoCallAssistance(bool val) { m_AlreadyCallAssistance = val; }
    void SetNoSearchAssistance(bool val) { m_AlreadySearchedAssistance = val; }
    bool HasSearchedAssistance() { return m_AlreadySearchedAssistance; }
    bool CanAssistTo(Unit const* u, Unit const* enemy, bool checkfaction = true) const;
    bool _IsTargetAcceptable(Unit const* target) const;
    [[nodiscard]] bool CanIgnoreFeignDeath() const { return (GetCreatureTemplate()->flags_extra & CREATURE_FLAG_EXTRA_IGNORE_FEIGN_DEATH) != 0; }

    // pussywizard: updated at faction change, disable move in line of sight if actual faction is not hostile to anyone
    void UpdateMoveInLineOfSightState();
    bool IsMoveInLineOfSightDisabled() { return m_moveInLineOfSightDisabled; }
    bool IsMoveInLineOfSightStrictlyDisabled() { return m_moveInLineOfSightStrictlyDisabled; }

    void RemoveCorpse(bool setSpawnTime = true, bool skipVisibility = false);

    void DespawnOrUnsummon(Milliseconds msTimeToDespawn, Seconds forcedRespawnTimer);
    void DespawnOrUnsummon(uint32 msTimeToDespawn = 0) { DespawnOrUnsummon(Milliseconds(msTimeToDespawn), 0s); };
    void DespawnOnEvade();
    void RespawnOnEvade();

    [[nodiscard]] time_t const& GetRespawnTime() const { return m_respawnTime; }
    [[nodiscard]] time_t GetRespawnTimeEx() const;
    void SetRespawnTime(uint32 respawn);
    void Respawn(bool force = false);
    void SaveRespawnTime() override;

    [[nodiscard]] uint32 GetRespawnDelay() const { return m_respawnDelay; }
    void SetRespawnDelay(uint32 delay) { m_respawnDelay = delay; }

    [[nodiscard]] float GetWanderDistance() const { return m_wanderDistance; }
    void SetWanderDistance(float dist) { m_wanderDistance = dist; }

    void DoImmediateBoundaryCheck() { m_boundaryCheckTime = 0; }

    uint32 m_groupLootTimer;                            // (msecs)timer used for group loot
    uint32 lootingGroupLowGUID;                         // used to find group which is looting corpse

    void SendZoneUnderAttackMessage(Player* attacker);

    void SetInCombatWithZone();

    [[nodiscard]] bool hasQuest(uint32 quest_id) const override;
    [[nodiscard]] bool hasInvolvedQuest(uint32 quest_id)  const override;

    bool isRegeneratingHealth() { return m_regenHealth; }
    void SetRegeneratingHealth(bool c) { m_regenHealth = c; }
    void SetRegeneratingPower(bool c) { m_regenPower = c; }
    [[nodiscard]] virtual uint8 GetPetAutoSpellSize() const { return MAX_SPELL_CHARM; }
    [[nodiscard]] virtual uint32 GetPetAutoSpellOnPos(uint8 pos) const
    {
        if (pos >= MAX_SPELL_CHARM || m_charmInfo->GetCharmSpell(pos)->GetType() != ACT_ENABLED)
            return 0;
        else
            return m_charmInfo->GetCharmSpell(pos)->GetAction();
    }

    void SetCannotReachTarget(ObjectGuid const& target = ObjectGuid::Empty);
    [[nodiscard]] bool CanNotReachTarget() const;
    [[nodiscard]] bool IsNotReachableAndNeedRegen() const;

    void SetPosition(float x, float y, float z, float o);
    void SetPosition(const Position& pos) { SetPosition(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation()); }

    void SetHomePosition(float x, float y, float z, float o) { m_homePosition.Relocate(x, y, z, o); }
    void SetHomePosition(const Position& pos) { m_homePosition.Relocate(pos); }
    void GetHomePosition(float& x, float& y, float& z, float& ori) const { m_homePosition.GetPosition(x, y, z, ori); }
    [[nodiscard]] Position const& GetHomePosition() const { return m_homePosition; }

    void SetTransportHomePosition(float x, float y, float z, float o) { m_transportHomePosition.Relocate(x, y, z, o); }
    void SetTransportHomePosition(const Position& pos) { m_transportHomePosition.Relocate(pos); }
    void GetTransportHomePosition(float& x, float& y, float& z, float& ori) const { m_transportHomePosition.GetPosition(x, y, z, ori); }
    [[nodiscard]] Position const& GetTransportHomePosition() const { return m_transportHomePosition; }

    [[nodiscard]] uint32 GetWaypointPath() const { return m_path_id; }
    void LoadPath(uint32 pathid) { m_path_id = pathid; }

    [[nodiscard]] uint32 GetCurrentWaypointID() const { return m_waypointID; }
    void UpdateWaypointID(uint32 wpID) { m_waypointID = wpID; }

    void SearchFormation();
    [[nodiscard]] CreatureGroup const* GetFormation() const { return m_formation; }
    [[nodiscard]] CreatureGroup* GetFormation() { return m_formation; }
    void SetFormation(CreatureGroup* formation) { m_formation = formation; }

    Unit* SelectVictim();

    void SetDisableReputationGain(bool disable) { DisableReputationGain = disable; }
    [[nodiscard]] bool IsReputationGainDisabled() const { return DisableReputationGain; }
    [[nodiscard]] bool IsDamageEnoughForLootingAndReward() const;
    void LowerPlayerDamageReq(uint32 unDamage, bool damagedByPlayer = true);
    void ResetPlayerDamageReq();
    [[nodiscard]] uint32 GetPlayerDamageReq() const;

    [[nodiscard]] uint32 GetOriginalEntry() const { return m_originalEntry; }
    void SetOriginalEntry(uint32 entry) { m_originalEntry = entry; }

    static float _GetDamageMod(int32 Rank);

    float m_SightDistance, m_CombatDistance;

    bool m_isTempWorldObject; //true when possessed

    // Handling caster facing during spellcast
    void SetTarget(ObjectGuid guid = ObjectGuid::Empty) override;
    void FocusTarget(Spell const* focusSpell, WorldObject const* target);
    void ReleaseFocus(Spell const* focusSpell);
    [[nodiscard]] bool IsMovementPreventedByCasting() const override;

    // Part of Evade mechanics
    [[nodiscard]] time_t GetLastDamagedTime() const;
    [[nodiscard]] std::shared_ptr<time_t> const& GetLastDamagedTimePtr() const;
    void SetLastDamagedTime(time_t val);
    void SetLastDamagedTimePtr(std::shared_ptr<time_t> const& val);

    bool IsFreeToMove();
    static constexpr uint32 MOVE_CIRCLE_CHECK_INTERVAL = 3000;
    static constexpr uint32 MOVE_BACKWARDS_CHECK_INTERVAL = 2000;
    uint32 m_moveCircleMovementTime = MOVE_CIRCLE_CHECK_INTERVAL;
    uint32 m_moveBackwardsMovementTime = MOVE_BACKWARDS_CHECK_INTERVAL;

    [[nodiscard]] bool HasSwimmingFlagOutOfCombat() const
    {
        return !_isMissingSwimmingFlagOutOfCombat;
    }
    void RefreshSwimmingFlag(bool recheck = false);

    void SetAssistanceTimer(uint32 value) { m_assistanceTimer = value; }

    void ModifyThreatPercentTemp(Unit* victim, int32 percent, Milliseconds duration);

    std::string GetDebugInfo() const override;

protected:
    bool CreateFromProto(ObjectGuid::LowType guidlow, uint32 Entry, uint32 vehId, const CreatureData* data = nullptr);
    bool InitEntry(uint32 entry, const CreatureData* data = nullptr);

    // vendor items
    VendorItemCounts m_vendorItemCounts;

    static float _GetHealthMod(int32 Rank);

    ObjectGuid m_lootRecipient;
    ObjectGuid::LowType m_lootRecipientGroup;

    /// Timers
    time_t m_corpseRemoveTime;                          // (secs) timer for death or corpse disappearance
    time_t m_respawnTime;                               // (secs) time of next respawn
    time_t m_respawnedTime;                             // (secs) time when creature respawned
    uint32 m_respawnDelay;                              // (secs) delay between corpse disappearance and respawning
    uint32 m_corpseDelay;                               // (secs) delay between death and corpse disappearance
    float m_wanderDistance;
    uint32 m_boundaryCheckTime;                         // (msecs) remaining time for next evade boundary check
    uint16 m_transportCheckTimer;
    uint32 lootPickPocketRestoreTime;

    ReactStates m_reactState;                           // for AI, not charmInfo
    void RegenerateHealth();
    void Regenerate(Powers power);
    MovementGeneratorType m_defaultMovementType;
    ObjectGuid::LowType m_spawnId;                      ///< For new or temporary creatures is 0 for saved it is lowguid
    uint8 m_equipmentId;
    int8 m_originalEquipmentId; // can be -1

    bool m_AlreadyCallAssistance;
    bool m_AlreadySearchedAssistance;
    bool m_regenHealth;
    bool m_regenPower;
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

    [[nodiscard]] bool IsInvisibleDueToDespawn() const override;
    bool CanAlwaysSee(WorldObject const* obj) const override;
    bool IsAlwaysDetectableFor(WorldObject const* seer) const override;

private:
    void ForcedDespawn(uint32 timeMSToDespawn = 0, Seconds forcedRespawnTimer = 0s);

    [[nodiscard]] bool CanPeriodicallyCallForAssistance() const;

    //WaypointMovementGenerator vars
    uint32 m_waypointID;
    uint32 m_path_id;

    //Formation var
    CreatureGroup* m_formation;
    bool TriggerJustRespawned;

    mutable std::shared_ptr<time_t> _lastDamagedTime; // Part of Evade mechanics

    ObjectGuid m_cannotReachTarget;
    uint32 m_cannotReachTimer;

    Spell const* _focusSpell;   ///> Locks the target during spell cast for proper facing

    bool _isMissingSwimmingFlagOutOfCombat;

    uint32 m_assistanceTimer;

    uint32 _playerDamageReq;
    bool _damagedByPlayer;
};

class AssistDelayEvent : public BasicEvent
{
public:
    AssistDelayEvent(ObjectGuid victim, Creature* owner) : BasicEvent(), m_victim(victim), m_owner(owner) { }

    bool Execute(uint64 e_time, uint32 p_time) override;
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
    bool Execute(uint64 e_time, uint32 p_time) override;

private:
    Creature& m_owner;
    Seconds const m_respawnTimer;
};

class TemporaryThreatModifierEvent : public BasicEvent
{
public:
    TemporaryThreatModifierEvent(Creature& owner, ObjectGuid threatVictimGUID, float threatValue) : BasicEvent(), m_owner(owner), m_threatVictimGUID(threatVictimGUID), m_threatValue(threatValue) { }
    bool Execute(uint64 e_time, uint32 p_time) override;

private:
    Creature& m_owner;
    ObjectGuid m_threatVictimGUID;
    float m_threatValue;
};

#endif
