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

#ifndef AZEROTHCORE_GAMEOBJECT_H
#define AZEROTHCORE_GAMEOBJECT_H

#include "Common.h"
#include "DatabaseEnv.h"
#include "G3D/Quat.h"
#include "GameObjectData.h"
#include "LootMgr.h"
#include "Object.h"
#include "SharedDefines.h"
#include "Unit.h"

class GameObjectAI;
class Transport;
class StaticTransport;
class MotionTransport;
class OPvPCapturePoint;
class Unit;
class GameObjectModel;

struct TransportAnimation;

typedef void(*goEventFlag)(Player*, GameObject*, Battleground*);

// Benchmarked: Faster than std::map (insert/find)
typedef std::unordered_map<uint32, GameObjectTemplate> GameObjectTemplateContainer;
typedef std::unordered_map<uint32, GameObjectTemplateAddon> GameObjectTemplateAddonContainer;

typedef std::unordered_map<uint32, GameObjectAddon> GameObjectAddonContainer;
typedef std::vector<uint32> GameObjectQuestItemList;
typedef std::unordered_map<uint32, GameObjectQuestItemList> GameObjectQuestItemMap;

union GameObjectValue
{
    //11 GAMEOBJECT_TYPE_TRANSPORT
    struct
    {
        uint32 PathProgress;
        TransportAnimation const* AnimationInfo;
    } Transport;
    //25 GAMEOBJECT_TYPE_FISHINGHOLE
    struct
    {
        uint32 MaxOpens;
    } FishingHole;
    //29 GAMEOBJECT_TYPE_CAPTURE_POINT
    struct
    {
        OPvPCapturePoint* OPvPObj;
    } CapturePoint;
    //33 GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING
    struct
    {
        uint32 Health;
        uint32 MaxHealth;
    } Building;
};

enum class GameObjectActions : uint32
{
    // Name from client executable      // Comments
    None,                           // -NONE-
    AnimateCustom0,                 // Animate Custom0
    AnimateCustom1,                 // Animate Custom1
    AnimateCustom2,                 // Animate Custom2
    AnimateCustom3,                 // Animate Custom3
    Disturb,                        // Disturb                          // Triggers trap
    Unlock,                         // Unlock                           // Resets GO_FLAG_LOCKED
    Lock,                           // Lock                             // Sets GO_FLAG_LOCKED
    Open,                           // Open                             // Sets GO_STATE_ACTIVE
    OpenAndUnlock,                  // Open + Unlock                    // Sets GO_STATE_ACTIVE and resets GO_FLAG_LOCKED
    Close,                          // Close                            // Sets GO_STATE_READY
    ToggleOpen,                     // Toggle Open
    Destroy,                        // Destroy                          // Sets GO_STATE_DESTROYED
    Rebuild,                        // Rebuild                          // Resets from GO_STATE_DESTROYED
    Creation,                       // Creation
    Despawn,                        // Despawn
    MakeInert,                      // Make Inert                       // Disables interactions
    MakeActive,                     // Make Active                      // Enables interactions
    CloseAndLock,                   // Close + Lock                     // Sets GO_STATE_READY and sets GO_FLAG_LOCKED
    UseArtKit0,                     // Use ArtKit0                      // 46904: 121
    UseArtKit1,                     // Use ArtKit1                      // 36639: 81, 46903: 122
    UseArtKit2,                     // Use ArtKit2
    UseArtKit3,                     // Use ArtKit3
    SetTapList,                     // Set Tap List
};

// For containers:  [GO_NOT_READY]->GO_READY (close)->GO_ACTIVATED (open) ->GO_JUST_DEACTIVATED->GO_READY        -> ...
// For bobber:      GO_NOT_READY  ->GO_READY (close)->GO_ACTIVATED (open) ->GO_JUST_DEACTIVATED-><deleted>
// For door(closed):[GO_NOT_READY]->GO_READY (close)->GO_ACTIVATED (open) ->GO_JUST_DEACTIVATED->GO_READY(close) -> ...
// For door(open):  [GO_NOT_READY]->GO_READY (open) ->GO_ACTIVATED (close)->GO_JUST_DEACTIVATED->GO_READY(open)  -> ...
enum LootState
{
    GO_NOT_READY,
    GO_READY,                                               // can be ready but despawned, and then not possible activate until spawn
    GO_ACTIVATED,
    GO_JUST_DEACTIVATED
};

// 5 sec for bobber catch
#define FISHING_BOBBER_READY_TIME 5

class GameObject : public WorldObject, public GridObject<GameObject>, public MovableMapObject
{
public:
    explicit GameObject();
    ~GameObject() override;

    void BuildValuesUpdate(uint8 updateType, ByteBuffer* data, Player* target) override;

    void AddToWorld() override;
    void RemoveFromWorld() override;
    void CleanupsBeforeDelete(bool finalCleanup = true) override;

    uint32 GetDynamicFlags() const override { return GetUInt32Value(GAMEOBJECT_DYNAMIC); }
    void ReplaceAllDynamicFlags(uint32 flag) override { SetUInt32Value(GAMEOBJECT_DYNAMIC, flag); }

    virtual bool Create(ObjectGuid::LowType guidlow, uint32 name_id, Map* map, uint32 phaseMask, float x, float y, float z, float ang, G3D::Quat const& rotation, uint32 animprogress, GOState go_state, uint32 artKit = 0);
    void Update(uint32 p_time) override;
    [[nodiscard]] GameObjectTemplate const* GetGOInfo() const { return m_goInfo; }
    [[nodiscard]] GameObjectTemplateAddon const* GetTemplateAddon() const;
    [[nodiscard]] GameObjectData const* GetGameObjectData() const { return m_goData; }
    [[nodiscard]] GameObjectValue const* GetGOValue() const { return &m_goValue; }

    [[nodiscard]] bool IsTransport() const;
    [[nodiscard]] bool IsDestructibleBuilding() const;

    [[nodiscard]] ObjectGuid::LowType GetSpawnId() const { return m_spawnId; }

    // z_rot, y_rot, x_rot - rotation angles around z, y and x axes
    void SetLocalRotationAngles(float z_rot, float y_rot, float x_rot);
    void SetLocalRotation(G3D::Quat const& rot);
    void SetTransportPathRotation(float qx, float qy, float qz, float qw);
    [[nodiscard]] G3D::Quat const& GetLocalRotation() const { return m_localRotation; }
    [[nodiscard]] int64 GetPackedLocalRotation() const { return m_packedRotation; }
    [[nodiscard]] G3D::Quat GetWorldRotation() const;

    // overwrite WorldObject function for proper name localization
    [[nodiscard]] std::string const& GetNameForLocaleIdx(LocaleConstant locale_idx) const override;

    void SaveToDB(bool saveAddon = false);
    void SaveToDB(uint32 mapid, uint8 spawnMask, uint32 phaseMask, bool saveAddon = false);
    bool LoadFromDB(ObjectGuid::LowType guid, Map* map) { return LoadGameObjectFromDB(guid, map, false); }
    bool LoadGameObjectFromDB(ObjectGuid::LowType guid, Map* map, bool addToMap = true);
    void DeleteFromDB();

    void SetOwnerGUID(ObjectGuid owner)
    {
        // Owner already found and different than expected owner - remove object from old owner
        if (owner && GetOwnerGUID() && GetOwnerGUID() != owner)
        {
            ABORT();
        }
        m_spawnedByDefault = false;                     // all object with owner is despawned after delay
        SetGuidValue(OBJECT_FIELD_CREATED_BY, owner);
    }
    [[nodiscard]] ObjectGuid GetOwnerGUID() const { return GetGuidValue(OBJECT_FIELD_CREATED_BY); }
    [[nodiscard]] Unit* GetOwner() const;

    void SetSpellId(uint32 id)
    {
        m_spawnedByDefault = false;                     // all summoned object is despawned after delay
        m_spellId = id;
    }
    [[nodiscard]] uint32 GetSpellId() const { return m_spellId;}

    [[nodiscard]] time_t GetRespawnTime() const { return m_respawnTime; }
    [[nodiscard]] time_t GetRespawnTimeEx() const;

    void SetRespawnTime(int32 respawn);
    void SetRespawnDelay(int32 respawn);
    void Respawn();
    [[nodiscard]] bool isSpawned() const
    {
        return m_respawnDelayTime == 0 ||
               (m_respawnTime > 0 && !m_spawnedByDefault) ||
               (m_respawnTime == 0 && m_spawnedByDefault);
    }
    [[nodiscard]] bool isSpawnedByDefault() const { return m_spawnedByDefault; }
    void SetSpawnedByDefault(bool b) { m_spawnedByDefault = b; }
    [[nodiscard]] uint32 GetRespawnDelay() const { return m_respawnDelayTime; }
    void Refresh();
    void DespawnOrUnsummon(Milliseconds delay = 0ms, Seconds forcedRespawnTime = 0s);
    void Delete();
    void GetFishLoot(Loot* loot, Player* loot_owner);
    void GetFishLootJunk(Loot* loot, Player* loot_owner);
    [[nodiscard]] GameobjectTypes GetGoType() const { return GameobjectTypes(GetByteValue(GAMEOBJECT_BYTES_1, 1)); }
    void SetGoType(GameobjectTypes type) { SetByteValue(GAMEOBJECT_BYTES_1, 1, type); }
    [[nodiscard]] GOState GetGoState() const { return GOState(GetByteValue(GAMEOBJECT_BYTES_1, 0)); }
    void SetGoState(GOState state);
    [[nodiscard]] uint8 GetGoArtKit() const { return GetByteValue(GAMEOBJECT_BYTES_1, 2); }
    void SetGoArtKit(uint8 artkit);
    [[nodiscard]] uint8 GetGoAnimProgress() const { return GetByteValue(GAMEOBJECT_BYTES_1, 3); }
    void SetGoAnimProgress(uint8 animprogress) { SetByteValue(GAMEOBJECT_BYTES_1, 3, animprogress); }
    static void SetGoArtKit(uint8 artkit, GameObject* go, ObjectGuid::LowType lowguid = 0);

    void SetPhaseMask(uint32 newPhaseMask, bool update) override;
    void EnableCollision(bool enable);

    GameObjectFlags GetGameObjectFlags() const { return GameObjectFlags(GetUInt32Value(GAMEOBJECT_FLAGS)); }
    bool HasGameObjectFlag(GameObjectFlags flags) const { return HasFlag(GAMEOBJECT_FLAGS, flags) != 0; }
    void SetGameObjectFlag(GameObjectFlags flags) { SetFlag(GAMEOBJECT_FLAGS, flags); }
    void RemoveGameObjectFlag(GameObjectFlags flags) { RemoveFlag(GAMEOBJECT_FLAGS, flags); }
    void ReplaceAllGameObjectFlags(GameObjectFlags flags) { SetUInt32Value(GAMEOBJECT_FLAGS, flags); }

    void Use(Unit* user);

    [[nodiscard]] LootState getLootState() const { return m_lootState; }
    // Note: unit is only used when s = GO_ACTIVATED
    void SetLootState(LootState s, Unit* unit = nullptr);

    [[nodiscard]] uint16 GetLootMode() const { return m_LootMode; }
    [[nodiscard]] bool HasLootMode(uint16 lootMode) const { return m_LootMode & lootMode; }
    void SetLootMode(uint16 lootMode) { m_LootMode = lootMode; }
    void AddLootMode(uint16 lootMode) { m_LootMode |= lootMode; }
    void RemoveLootMode(uint16 lootMode) { m_LootMode &= ~lootMode; }
    void ResetLootMode() { m_LootMode = LOOT_MODE_DEFAULT; }

    void AddToSkillupList(ObjectGuid playerGuid);
    [[nodiscard]] bool IsInSkillupList(ObjectGuid playerGuid) const;

    void AddUniqueUse(Player* player);
    void AddUse() { ++m_usetimes; }

    [[nodiscard]] uint32 GetUseCount() const { return m_usetimes; }
    [[nodiscard]] uint32 GetUniqueUseCount() const { return m_unique_users.size(); }

    void SaveRespawnTime() override { SaveRespawnTime(0); }
    void SaveRespawnTime(uint32 forceDelay);

    Loot        loot;

    [[nodiscard]] Player* GetLootRecipient() const;
    [[nodiscard]] Group* GetLootRecipientGroup() const;
    void SetLootRecipient(Creature* creature);
    void SetLootRecipient(Map* map);
    bool IsLootAllowedFor(Player const* player) const;
    [[nodiscard]] bool HasLootRecipient() const { return m_lootRecipient || m_lootRecipientGroup; }
    uint32 m_groupLootTimer;                            // (msecs)timer used for group loot
    uint32 lootingGroupLowGUID;                         // used to find group which is looting
    void SetLootGenerationTime();
    [[nodiscard]] uint32 GetLootGenerationTime() const { return m_lootGenerationTime; }

    [[nodiscard]] GameObject* GetLinkedTrap();
    void SetLinkedTrap(GameObject* linkedTrap) { m_linkedTrap = linkedTrap->GetGUID(); }

    [[nodiscard]] bool hasQuest(uint32 quest_id) const override;
    [[nodiscard]] bool hasInvolvedQuest(uint32 quest_id) const override;
    bool ActivateToQuest(Player* target) const;
    void UseDoorOrButton(uint32 time_to_restore = 0, bool alternative = false, Unit* user = nullptr);
    // 0 = use `gameobject`.`spawntimesecs`
    void ResetDoorOrButton();

    void TriggeringLinkedGameObject(uint32 trapEntry, Unit* target);

    [[nodiscard]] bool IsNeverVisible() const override;
    bool IsAlwaysVisibleFor(WorldObject const* seer) const override;
    [[nodiscard]] bool IsInvisibleDueToDespawn() const override;

    uint8 getLevelForTarget(WorldObject const* target) const override
    {
        if (Unit* owner = GetOwner())
            return owner->getLevelForTarget(target);

        return 1;
    }

    GameObject* LookupFishingHoleAround(float range);

    void CastSpell(Unit* target, uint32 spell);
    void SendCustomAnim(uint32 anim);
    [[nodiscard]] bool IsInRange(float x, float y, float z, float radius) const;

    void ModifyHealth(int32 change, Unit* attackerOrHealer = nullptr, uint32 spellId = 0);
    void SetDestructibleBuildingModifyState(bool allow) { m_allowModifyDestructibleBuilding = allow; }
    // sets GameObject type 33 destruction flags and optionally default health for that state
    void SetDestructibleState(GameObjectDestructibleState state, Player* eventInvoker = nullptr, bool setHealth = false);
    [[nodiscard]] GameObjectDestructibleState GetDestructibleState() const
    {
        if (HasGameObjectFlag(GO_FLAG_DESTROYED))
            return GO_DESTRUCTIBLE_DESTROYED;
        if (HasGameObjectFlag(GO_FLAG_DAMAGED))
            return GO_DESTRUCTIBLE_DAMAGED;
        return GO_DESTRUCTIBLE_INTACT;
    }

    void EventInform(uint32 eventId);

    [[nodiscard]] virtual uint32 GetScriptId() const;
    [[nodiscard]] GameObjectAI* AI() const { return m_AI; }

    [[nodiscard]] std::string const& GetAIName() const;
    void SetDisplayId(uint32 displayid);
    [[nodiscard]] uint32 GetDisplayId() const { return GetUInt32Value(GAMEOBJECT_DISPLAYID); }

    GameObjectModel* m_model;
    void GetRespawnPosition(float& x, float& y, float& z, float* ori = nullptr) const;

    void SetPosition(float x, float y, float z, float o);
    void SetPosition(const Position& pos) { SetPosition(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation()); }

    [[nodiscard]] bool IsStaticTransport() const { return GetGOInfo()->type == GAMEOBJECT_TYPE_TRANSPORT; }
    [[nodiscard]] bool IsMotionTransport() const { return GetGOInfo()->type == GAMEOBJECT_TYPE_MO_TRANSPORT; }

    Transport* ToTransport() { if (GetGOInfo()->type == GAMEOBJECT_TYPE_MO_TRANSPORT || GetGOInfo()->type == GAMEOBJECT_TYPE_TRANSPORT) return reinterpret_cast<Transport*>(this); else return nullptr; }
    [[nodiscard]] Transport const* ToTransport() const { if (GetGOInfo()->type == GAMEOBJECT_TYPE_MO_TRANSPORT || GetGOInfo()->type == GAMEOBJECT_TYPE_TRANSPORT) return reinterpret_cast<Transport const*>(this); else return nullptr; }

    StaticTransport* ToStaticTransport() { if (GetGOInfo()->type == GAMEOBJECT_TYPE_TRANSPORT) return reinterpret_cast<StaticTransport*>(this); else return nullptr; }
    [[nodiscard]] StaticTransport const* ToStaticTransport() const { if (GetGOInfo()->type == GAMEOBJECT_TYPE_TRANSPORT) return reinterpret_cast<StaticTransport const*>(this); else return nullptr; }

    MotionTransport* ToMotionTransport() { if (GetGOInfo()->type == GAMEOBJECT_TYPE_MO_TRANSPORT) return reinterpret_cast<MotionTransport*>(this); else return nullptr; }
    [[nodiscard]] MotionTransport const* ToMotionTransport() const { if (GetGOInfo()->type == GAMEOBJECT_TYPE_MO_TRANSPORT) return reinterpret_cast<MotionTransport const*>(this); else return nullptr; }

    [[nodiscard]] float GetStationaryX() const override { if (GetGOInfo()->type != GAMEOBJECT_TYPE_MO_TRANSPORT) return m_stationaryPosition.GetPositionX(); return GetPositionX(); }
    [[nodiscard]] float GetStationaryY() const override { if (GetGOInfo()->type != GAMEOBJECT_TYPE_MO_TRANSPORT) return m_stationaryPosition.GetPositionY(); return GetPositionY(); }
    [[nodiscard]] float GetStationaryZ() const override { if (GetGOInfo()->type != GAMEOBJECT_TYPE_MO_TRANSPORT) return m_stationaryPosition.GetPositionZ(); return GetPositionZ(); }
    [[nodiscard]] float GetStationaryO() const override { if (GetGOInfo()->type != GAMEOBJECT_TYPE_MO_TRANSPORT) return m_stationaryPosition.GetOrientation(); return GetOrientation(); }

    [[nodiscard]] float GetInteractionDistance() const;

    void UpdateModelPosition();

    [[nodiscard]] bool IsAtInteractDistance(Position const& pos, float radius) const;
    [[nodiscard]] bool IsAtInteractDistance(Player const* player, SpellInfo const* spell = nullptr) const;

    [[nodiscard]] bool IsWithinDistInMap(Player const* player) const;
    using WorldObject::IsWithinDistInMap;

    [[nodiscard]] SpellInfo const* GetSpellForLock(Player const* player) const;

    static std::unordered_map<int, goEventFlag> gameObjectToEventFlag; // Gameobject -> event flag

    [[nodiscard]] bool ValidateGameobjectType() const;
    [[nodiscard]] bool IsInstanceGameobject() const;
    [[nodiscard]] uint8 GameobjectStateToInt(GOState* state) const;

    /* A check to verify if this object is available to be saved on the DB when
     * a state change occurs
     */
    [[nodiscard]] bool IsAllowedToSaveToDB() const { return m_saveStateOnDb; };

    /* Enable or Disable the ability to save on the database this gameobject's state
     * whenever it changes
     */
    void AllowSaveToDB(bool enable) { m_saveStateOnDb = enable; };

    void SaveStateToDB();

    std::string GetDebugInfo() const override;
protected:
    bool AIM_Initialize();
    GameObjectModel* CreateModel();
    void UpdateModel();                                 // updates model in case displayId were changed
    uint32      m_spellId;
    time_t      m_respawnTime;                          // (secs) time of next respawn (or despawn if GO have owner()),
    uint32      m_respawnDelayTime;                     // (secs) if 0 then current GO state no dependent from timer
    uint32      m_despawnDelay;
    Seconds     m_despawnRespawnTime;                   // override respawn time after delayed despawn
    Seconds     m_restockTime;
    LootState   m_lootState;
    bool        m_spawnedByDefault;
    uint32      m_cooldownTime;                         // used as internal reaction delay time store (not state change reaction).
    // For traps this: spell casting cooldown, for doors/buttons: reset time.
    std::unordered_map<ObjectGuid, int32> m_SkillupList;

    ObjectGuid m_ritualOwnerGUID;                       // used for GAMEOBJECT_TYPE_SUMMONING_RITUAL where GO is not summoned (no owner)
    GuidSet m_unique_users;
    uint32 m_usetimes;

    typedef std::map<uint32, ObjectGuid> ChairSlotAndUser;
    ChairSlotAndUser ChairListSlots;

    ObjectGuid::LowType m_spawnId;                            ///< For new or temporary gameobjects is 0 for saved it is lowguid
    GameObjectTemplate const* m_goInfo;
    GameObjectData const* m_goData;
    GameObjectValue m_goValue;
    bool m_allowModifyDestructibleBuilding;

    int64 m_packedRotation;
    G3D::Quat m_localRotation;
    Position m_stationaryPosition;

    ObjectGuid m_lootRecipient;
    ObjectGuid::LowType m_lootRecipientGroup;
    uint16 m_LootMode;                                  // bitmask, default LOOT_MODE_DEFAULT, determines what loot will be lootable
    uint32 m_lootGenerationTime;

    ObjectGuid m_linkedTrap;

    ObjectGuid _lootStateUnitGUID;

private:
    void CheckRitualList();
    void ClearRitualList();
    void RemoveFromOwner();
    void SwitchDoorOrButton(bool activate, bool alternative = false);
    void UpdatePackedRotation();

    //! Object distance/size - overridden from Object::_IsWithinDist. Needs to take in account proper GO size.
    bool _IsWithinDist(WorldObject const* obj, float dist2compare, bool /*is3D*/, bool /*useBoundingRadius = true*/) const override
    {
        //! Following check does check 3d distance
        dist2compare += obj->GetObjectSize();
        return IsInRange(obj->GetPositionX(), obj->GetPositionY(), obj->GetPositionZ(), dist2compare);
    }
    GameObjectAI* m_AI;

    bool m_saveStateOnDb = false;
};
#endif
