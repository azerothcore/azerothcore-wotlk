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

#ifndef _OBJECT_H
#define _OBJECT_H

#include "Common.h"
#include "DataMap.h"
#include "G3D/Vector3.h"
#include "GridDefines.h"
#include "GridReference.h"
#include "Map.h"
#include "ModelIgnoreFlags.h"
#include "ObjectDefines.h"
#include "ObjectGuid.h"
#include "Optional.h"
#include "Position.h"
#include "UpdateData.h"
#include "UpdateMask.h"
#include <set>
#include <sstream>
#include <string>

class ElunaEventProcessor;

enum TempSummonType
{
    TEMPSUMMON_TIMED_OR_DEAD_DESPAWN       = 1,             // despawns after a specified time OR when the creature disappears
    TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN     = 2,             // despawns after a specified time OR when the creature dies
    TEMPSUMMON_TIMED_DESPAWN               = 3,             // despawns after a specified time
    TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT = 4,             // despawns after a specified time after the creature is out of combat
    TEMPSUMMON_CORPSE_DESPAWN              = 5,             // despawns instantly after death
    TEMPSUMMON_CORPSE_TIMED_DESPAWN        = 6,             // despawns after a specified time after death
    TEMPSUMMON_DEAD_DESPAWN                = 7,             // despawns when the creature disappears
    TEMPSUMMON_MANUAL_DESPAWN              = 8,             // despawns when UnSummon() is called
    TEMPSUMMON_DESPAWNED                   = 9,             // xinef: DONT USE, INTERNAL USE ONLY
    TEMPSUMMON_TIMED_DESPAWN_OOC_ALIVE     = 10,            // despawns after a specified time after the creature is out of combat and alive
};

enum PhaseMasks
{
    PHASEMASK_NORMAL   = 0x00000001,
    PHASEMASK_ANYWHERE = 0xFFFFFFFF
};

enum NotifyFlags
{
    NOTIFY_NONE                     = 0x00,
    NOTIFY_AI_RELOCATION            = 0x01,
    NOTIFY_VISIBILITY_CHANGED       = 0x02,
    NOTIFY_ALL                      = 0xFF
};

enum GOSummonType
{
    GO_SUMMON_TIMED_OR_CORPSE_DESPAWN = 0,      // despawns after a specified time OR when the summoner dies
    GO_SUMMON_TIMED_DESPAWN = 1                 // despawns after a specified time
};

class WorldPacket;
class UpdateData;
class ByteBuffer;
class WorldSession;
class Creature;
class Player;
class InstanceScript;
class GameObject;
class TempSummon;
class Vehicle;
class CreatureAI;
class ZoneScript;
class Unit;
class Transport;
class StaticTransport;
class MotionTransport;

struct PositionFullTerrainStatus;

typedef std::unordered_map<Player*, UpdateData> UpdateDataMapType;
typedef GuidUnorderedSet UpdatePlayerSet;

class Object
{
public:
    virtual ~Object();

    [[nodiscard]] bool IsInWorld() const { return m_inWorld; }

    virtual void AddToWorld();
    virtual void RemoveFromWorld();

    [[nodiscard]] static ObjectGuid GetGUID(Object const* o) { return o ? o->GetGUID() : ObjectGuid::Empty; }
    [[nodiscard]] ObjectGuid GetGUID() const { return GetGuidValue(OBJECT_FIELD_GUID); }
    [[nodiscard]] PackedGuid const& GetPackGUID() const { return m_PackGUID; }
    [[nodiscard]] uint32 GetEntry() const { return GetUInt32Value(OBJECT_FIELD_ENTRY); }
    void SetEntry(uint32 entry) { SetUInt32Value(OBJECT_FIELD_ENTRY, entry); }

    [[nodiscard]] float GetObjectScale() const { return GetFloatValue(OBJECT_FIELD_SCALE_X); }
    virtual void SetObjectScale(float scale) { SetFloatValue(OBJECT_FIELD_SCALE_X, scale); }

    virtual uint32 GetDynamicFlags() const { return 0; }
    bool HasDynamicFlag(uint32 flag) const { return (GetDynamicFlags() & flag) != 0; }
    virtual void SetDynamicFlag(uint32 flag) { ReplaceAllDynamicFlags(GetDynamicFlags() | flag); }
    virtual void RemoveDynamicFlag(uint32 flag) { ReplaceAllDynamicFlags(GetDynamicFlags() & ~flag); }
    virtual void ReplaceAllDynamicFlags([[maybe_unused]] uint32 flag) { }

    [[nodiscard]] TypeID GetTypeId() const { return m_objectTypeId; }
    [[nodiscard]] bool isType(uint16 mask) const { return (mask & m_objectType); }

    virtual void BuildCreateUpdateBlockForPlayer(UpdateData* data, Player* target);
    void SendUpdateToPlayer(Player* player);

    void BuildValuesUpdateBlockForPlayer(UpdateData* data, Player* target);
    void BuildOutOfRangeUpdateBlock(UpdateData* data) const;
    void BuildMovementUpdateBlock(UpdateData* data, uint32 flags = 0) const;

    virtual void DestroyForPlayer(Player* target, bool onDeath = false) const;

    [[nodiscard]] int32 GetInt32Value(uint16 index) const;
    [[nodiscard]] uint32 GetUInt32Value(uint16 index) const;
    [[nodiscard]] uint64 GetUInt64Value(uint16 index) const;
    [[nodiscard]] float GetFloatValue(uint16 index) const;
    [[nodiscard]] uint8 GetByteValue(uint16 index, uint8 offset) const;
    [[nodiscard]] uint16 GetUInt16Value(uint16 index, uint8 offset) const;
    [[nodiscard]] ObjectGuid GetGuidValue(uint16 index) const;

    void SetInt32Value(uint16 index, int32 value);
    void SetUInt32Value(uint16 index, uint32 value);
    void UpdateUInt32Value(uint16 index, uint32 value);
    void SetUInt64Value(uint16 index, uint64 value);
    void SetFloatValue(uint16 index, float value);
    void SetByteValue(uint16 index, uint8 offset, uint8 value);
    void SetUInt16Value(uint16 index, uint8 offset, uint16 value);
    void SetInt16Value(uint16 index, uint8 offset, int16 value) { SetUInt16Value(index, offset, (uint16)value); }
    void SetGuidValue(uint16 index, ObjectGuid value);
    void SetStatFloatValue(uint16 index, float value);
    void SetStatInt32Value(uint16 index, int32 value);

    bool AddGuidValue(uint16 index, ObjectGuid value);
    bool RemoveGuidValue(uint16 index, ObjectGuid value);

    void ApplyModUInt32Value(uint16 index, int32 val, bool apply);
    void ApplyModInt32Value(uint16 index, int32 val, bool apply);
    void ApplyModUInt64Value(uint16 index, int32 val, bool apply);
    void ApplyModPositiveFloatValue(uint16 index, float val, bool apply);
    void ApplyModSignedFloatValue(uint16 index, float val, bool apply);
    void ApplyPercentModFloatValue(uint16 index, float val, bool apply);

    void SetFlag(uint16 index, uint32 newFlag);
    void RemoveFlag(uint16 index, uint32 oldFlag);
    void ToggleFlag(uint16 index, uint32 flag);
    [[nodiscard]] bool HasFlag(uint16 index, uint32 flag) const;
    void ApplyModFlag(uint16 index, uint32 flag, bool apply);

    void SetByteFlag(uint16 index, uint8 offset, uint8 newFlag);
    void RemoveByteFlag(uint16 index, uint8 offset, uint8 newFlag);
    [[nodiscard]] bool HasByteFlag(uint16 index, uint8 offset, uint8 flag) const;

    void SetFlag64(uint16 index, uint64 newFlag);
    void RemoveFlag64(uint16 index, uint64 oldFlag);
    void ToggleFlag64(uint16 index, uint64 flag);
    [[nodiscard]] bool HasFlag64(uint16 index, uint64 flag) const;
    void ApplyModFlag64(uint16 index, uint64 flag, bool apply);

    void ClearUpdateMask(bool remove);

    [[nodiscard]] uint16 GetValuesCount() const { return m_valuesCount; }

    [[nodiscard]] virtual bool hasQuest(uint32 /* quest_id */) const { return false; }
    [[nodiscard]] virtual bool hasInvolvedQuest(uint32 /* quest_id */) const { return false; }
    virtual void BuildUpdate(UpdateDataMapType&, UpdatePlayerSet&) {}
    void BuildFieldsUpdate(Player*, UpdateDataMapType&);

    void SetFieldNotifyFlag(uint16 flag) { _fieldNotifyFlags |= flag; }
    void RemoveFieldNotifyFlag(uint16 flag) { _fieldNotifyFlags &= ~flag; }

    // FG: some hacky helpers
    void ForceValuesUpdateAtIndex(uint32);

    //npcbot
    virtual bool IsNPCBot() const { return false; }
    virtual bool IsNPCBotPet() const { return false; }
    virtual bool IsNPCBotOrPet() const { return false; }
    //end npcbot

    [[nodiscard]] inline bool IsPlayer() const { return GetTypeId() == TYPEID_PLAYER; }
    Player* ToPlayer() { if (GetTypeId() == TYPEID_PLAYER) return reinterpret_cast<Player*>(this); else return nullptr; }
    [[nodiscard]] Player const* ToPlayer() const { if (GetTypeId() == TYPEID_PLAYER) return (Player const*)((Player*)this); else return nullptr; }
    Creature* ToCreature() { if (GetTypeId() == TYPEID_UNIT) return reinterpret_cast<Creature*>(this); else return nullptr; }
    [[nodiscard]] Creature const* ToCreature() const { if (GetTypeId() == TYPEID_UNIT) return (Creature const*)((Creature*)this); else return nullptr; }

    Unit* ToUnit() { if (GetTypeId() == TYPEID_UNIT || GetTypeId() == TYPEID_PLAYER) return reinterpret_cast<Unit*>(this); else return nullptr; }
    [[nodiscard]] Unit const* ToUnit() const { if (GetTypeId() == TYPEID_UNIT || GetTypeId() == TYPEID_PLAYER) return (Unit const*)((Unit*)this); else return nullptr; }
    GameObject* ToGameObject() { if (GetTypeId() == TYPEID_GAMEOBJECT) return reinterpret_cast<GameObject*>(this); else return nullptr; }
    [[nodiscard]] GameObject const* ToGameObject() const { if (GetTypeId() == TYPEID_GAMEOBJECT) return (GameObject const*)((GameObject*)this); else return nullptr; }

    Corpse* ToCorpse() { if (GetTypeId() == TYPEID_CORPSE) return reinterpret_cast<Corpse*>(this); else return nullptr; }
    [[nodiscard]] Corpse const* ToCorpse() const { if (GetTypeId() == TYPEID_CORPSE) return (const Corpse*)((Corpse*)this); else return nullptr; }

    DynamicObject* ToDynObject() { if (GetTypeId() == TYPEID_DYNAMICOBJECT) return reinterpret_cast<DynamicObject*>(this); else return nullptr; }
    [[nodiscard]] DynamicObject const* ToDynObject() const { if (GetTypeId() == TYPEID_DYNAMICOBJECT) return reinterpret_cast<DynamicObject const*>(this); else return nullptr; }

    virtual std::string GetDebugInfo() const;

    DataMap CustomData;

protected:
    Object();

    void _InitValues();
    void _Create(ObjectGuid::LowType guidlow, uint32 entry, HighGuid guidhigh);
    [[nodiscard]] std::string _ConcatFields(uint16 startIndex, uint16 size) const;
    bool _LoadIntoDataField(std::string const& data, uint32 startOffset, uint32 count);

    uint32 GetUpdateFieldData(Player const* target, uint32*& flags) const;

    void BuildMovementUpdate(ByteBuffer* data, uint16 flags) const;
    virtual void BuildValuesUpdate(uint8 updateType, ByteBuffer* data, Player* target);

    uint16 m_objectType;

    TypeID m_objectTypeId;
    uint16 m_updateFlag;

    union
    {
        int32*  m_int32Values;
        uint32* m_uint32Values;
        float*  m_floatValues;
    };

    UpdateMask _changesMask;

    uint16 m_valuesCount;

    uint16 _fieldNotifyFlags;

    virtual void AddToObjectUpdate() = 0;
    virtual void RemoveFromObjectUpdate() = 0;
    void AddToObjectUpdateIfNeeded();

    bool m_objectUpdated;

private:
    bool m_inWorld;

    PackedGuid m_PackGUID;

    // for output helpfull error messages from asserts
    [[nodiscard]] bool PrintIndexError(uint32 index, bool set) const;
    Object(const Object&);                              // prevent generation copy constructor
    Object& operator=(Object const&);                   // prevent generation assigment operator
};

struct MovementInfo
{
    // common
    ObjectGuid guid;
    uint32 flags{0};
    uint16 flags2{0};
    Position pos;
    uint32 time{0};

    // transport
    struct TransportInfo
    {
        void Reset()
        {
            guid.Clear();
            pos.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
            seat = -1;
            time = 0;
            time2 = 0;
        }

        ObjectGuid guid;
        Position pos;
        int8 seat;
        uint32 time;
        uint32 time2;
    } transport;

    // swimming/flying
    float pitch{0.0f};

    // falling
    uint32 fallTime{0};

    // jumping
    struct JumpInfo
    {
        void Reset()
        {
            zspeed = sinAngle = cosAngle = xyspeed = 0.0f;
        }

        float zspeed, sinAngle, cosAngle, xyspeed;
    } jump;

    // spline
    float splineElevation{0.0f};

    MovementInfo()
    {
        pos.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
        transport.Reset();
        jump.Reset();
    }

    [[nodiscard]] uint32 GetMovementFlags() const { return flags; }
    void SetMovementFlags(uint32 flag) { flags = flag; }
    void AddMovementFlag(uint32 flag) { flags |= flag; }
    void RemoveMovementFlag(uint32 flag) { flags &= ~flag; }
    [[nodiscard]] bool HasMovementFlag(uint32 flag) const { return flags & flag; }

    [[nodiscard]] uint16 GetExtraMovementFlags() const { return flags2; }
    void AddExtraMovementFlag(uint16 flag) { flags2 |= flag; }
    [[nodiscard]] bool HasExtraMovementFlag(uint16 flag) const { return flags2 & flag; }

    void SetFallTime(uint32 newFallTime) { fallTime = newFallTime; }

    void OutDebug();
};

template<class T>
class GridObject
{
public:
    [[nodiscard]] bool IsInGrid() const { return _gridRef.isValid(); }
    void AddToGrid(GridRefMgr<T>& m) { ASSERT(!IsInGrid()); _gridRef.link(&m, (T*)this); }
    void RemoveFromGrid() { ASSERT(IsInGrid()); _gridRef.unlink(); }
private:
    GridReference<T> _gridRef;
};

template <class T_VALUES, class T_FLAGS, class FLAG_TYPE, uint8 ARRAY_SIZE>
class FlaggedValuesArray32
{
public:
    FlaggedValuesArray32()
    {
        memset(&m_values, 0x00, sizeof(T_VALUES) * ARRAY_SIZE);
        m_flags = 0;
    }

    [[nodiscard]] T_FLAGS GetFlags() const { return m_flags; }
    [[nodiscard]] bool HasFlag(FLAG_TYPE flag) const { return m_flags & (1 << flag); }
    void AddFlag(FLAG_TYPE flag) { m_flags |= (1 << flag); }
    void DelFlag(FLAG_TYPE flag) { m_flags &= ~(1 << flag); }

    [[nodiscard]] T_VALUES GetValue(FLAG_TYPE flag) const { return m_values[flag]; }
    void SetValue(FLAG_TYPE flag, T_VALUES value) { m_values[flag] = value; }
    void AddValue(FLAG_TYPE flag, T_VALUES value) { m_values[flag] += value; }

private:
    T_VALUES m_values[ARRAY_SIZE];
    T_FLAGS m_flags;
};

enum MapObjectCellMoveState
{
    MAP_OBJECT_CELL_MOVE_NONE, //not in move list
    MAP_OBJECT_CELL_MOVE_ACTIVE, //in move list
    MAP_OBJECT_CELL_MOVE_INACTIVE, //in move list but should not move
};

class MovableMapObject
{
    friend class Map; //map for moving creatures
    friend class ObjectGridLoader; //grid loader for loading creatures
    template<class T> friend class RandomMovementGenerator;

protected:
    MovableMapObject()  = default;

private:
    [[nodiscard]] Cell const& GetCurrentCell() const { return _currentCell; }
    void SetCurrentCell(Cell const& cell) { _currentCell = cell; }

    Cell _currentCell;
    MapObjectCellMoveState _moveState{MAP_OBJECT_CELL_MOVE_NONE};
};

class WorldObject : public Object, public WorldLocation
{
protected:
    explicit WorldObject(bool isWorldObject); //note: here it means if it is in grid object list or world object list
public:
    ~WorldObject() override;

    virtual void Update(uint32 /*time_diff*/);

    void _Create(ObjectGuid::LowType guidlow, HighGuid guidhigh, uint32 phaseMask);

    void AddToWorld() override;
    void RemoveFromWorld() override;

    void GetNearPoint2D(WorldObject const* searcher, float& x, float& y, float distance, float absAngle, Position const* startPos = nullptr) const;
    void GetNearPoint2D(float& x, float& y, float distance, float absAngle, Position const* startPos = nullptr) const;
    void GetNearPoint(WorldObject const* searcher, float& x, float& y, float& z, float searcher_size, float distance2d, float absAngle, float controlZ = 0, Position const* startPos = nullptr) const;
    void GetVoidClosePoint(float& x, float& y, float& z, float size, float distance2d = 0, float relAngle = 0, float controlZ = 0) const;
    bool GetClosePoint(float& x, float& y, float& z, float size, float distance2d = 0, float angle = 0, WorldObject const* forWho = nullptr, bool force = false) const;
    void MovePosition(Position& pos, float dist, float angle);
    Position GetNearPosition(float dist, float angle);
    void MovePositionToFirstCollision(Position& pos, float dist, float angle) const;
    Position GetFirstCollisionPosition(float startX, float startY, float startZ, float destX, float destY);
    Position GetFirstCollisionPosition(float destX, float destY, float destZ);
    Position GetFirstCollisionPosition(float dist, float angle) const;
    Position GetRandomNearPosition(float radius);

    void GetContactPoint(WorldObject const* obj, float& x, float& y, float& z, float distance2d = CONTACT_DISTANCE) const;
    void GetChargeContactPoint(WorldObject const* obj, float& x, float& y, float& z, float distance2d = CONTACT_DISTANCE) const;

    [[nodiscard]] float GetObjectSize() const;

    [[nodiscard]] virtual float GetCombatReach() const { return 0.0f; } // overridden (only) in Unit
    void UpdateGroundPositionZ(float x, float y, float& z) const;
    void UpdateAllowedPositionZ(float x, float y, float& z, float* groundZ = nullptr) const;

    void GetRandomPoint(const Position& srcPos, float distance, float& rand_x, float& rand_y, float& rand_z) const;
    [[nodiscard]] Position GetRandomPoint(const Position& srcPos, float distance) const;

    [[nodiscard]] uint32 GetInstanceId() const { return m_InstanceId; }

    virtual void SetPhaseMask(uint32 newPhaseMask, bool update);
    [[nodiscard]] uint32 GetPhaseMask() const { return m_phaseMask; }
    bool InSamePhase(WorldObject const* obj) const { return InSamePhase(obj->GetPhaseMask()); }
    [[nodiscard]] bool InSamePhase(uint32 phasemask) const { return m_useCombinedPhases ? GetPhaseMask() & phasemask : GetPhaseMask() == phasemask; }

    [[nodiscard]] uint32 GetZoneId() const;
    [[nodiscard]] uint32 GetAreaId() const;
    void GetZoneAndAreaId(uint32& zoneid, uint32& areaid) const;
    [[nodiscard]] bool IsOutdoors() const;
    [[nodiscard]] LiquidData const& GetLiquidData() const;

    [[nodiscard]] InstanceScript* GetInstanceScript() const;

    [[nodiscard]] std::string const& GetName() const { return m_name; }
    void SetName(std::string const& newname) { m_name = newname; }

    [[nodiscard]] virtual std::string const& GetNameForLocaleIdx(LocaleConstant /*locale_idx*/) const { return m_name; }

    float GetDistance(WorldObject const* obj) const;
    [[nodiscard]] float GetDistance(const Position& pos) const;
    [[nodiscard]] float GetDistance(float x, float y, float z) const;
    float GetDistance2d(WorldObject const* obj) const;
    [[nodiscard]] float GetDistance2d(float x, float y) const;
    float GetDistanceZ(WorldObject const* obj) const;

    bool IsSelfOrInSameMap(WorldObject const* obj) const;
    bool IsInMap(WorldObject const* obj) const;
    [[nodiscard]] bool IsWithinDist3d(float x, float y, float z, float dist) const;
    bool IsWithinDist3d(const Position* pos, float dist) const;
    [[nodiscard]] bool IsWithinDist2d(float x, float y, float dist) const;
    bool IsWithinDist2d(const Position* pos, float dist) const;
    // use only if you will sure about placing both object at same map
    bool IsWithinDist(WorldObject const* obj, float dist2compare, bool is3D = true, bool useBoundingRadius = true) const;
    bool IsWithinDistInMap(WorldObject const* obj, float dist2compare, bool is3D = true, bool useBoundingRadius = true) const;
    [[nodiscard]] bool IsWithinLOS(float x, float y, float z, VMAP::ModelIgnoreFlags ignoreFlags = VMAP::ModelIgnoreFlags::Nothing, LineOfSightChecks checks = LINEOFSIGHT_ALL_CHECKS) const;
    [[nodiscard]] bool IsWithinLOSInMap(WorldObject const* obj, VMAP::ModelIgnoreFlags ignoreFlags = VMAP::ModelIgnoreFlags::Nothing, LineOfSightChecks checks = LINEOFSIGHT_ALL_CHECKS, Optional<float> collisionHeight = { }, Optional<float> combatReach = { }) const;
    [[nodiscard]] Position GetHitSpherePointFor(Position const& dest, Optional<float> collisionHeight = { }, Optional<float> combatReach = { }) const;
    void GetHitSpherePointFor(Position const& dest, float& x, float& y, float& z, Optional<float> collisionHeight = { }, Optional<float> combatReach = { }) const;
    bool GetDistanceOrder(WorldObject const* obj1, WorldObject const* obj2, bool is3D = true) const;
    bool IsInRange(WorldObject const* obj, float minRange, float maxRange, bool is3D = true) const;
    [[nodiscard]] bool IsInRange2d(float x, float y, float minRange, float maxRange) const;
    [[nodiscard]] bool IsInRange3d(float x, float y, float z, float minRange, float maxRange) const;
    bool isInFront(WorldObject const* target, float arc = M_PI) const;
    bool isInBack(WorldObject const* target, float arc = M_PI) const;

    bool IsInBetween(WorldObject const* obj1, WorldObject const* obj2, float size = 0) const;

    virtual void CleanupsBeforeDelete(bool finalCleanup = true);  // used in destructor or explicitly before mass creature delete to remove cross-references to already deleted units

    virtual void SendMessageToSet(WorldPacket const* data, bool self) const { if (IsInWorld()) SendMessageToSetInRange(data, GetVisibilityRange(), self, true); } // pussywizard!
    virtual void SendMessageToSetInRange(WorldPacket const* data, float dist, bool /*self*/, bool includeMargin = false, Player const* skipped_rcvr = nullptr) const; // pussywizard!
    virtual void SendMessageToSet(WorldPacket const* data, Player const* skipped_rcvr) const { if (IsInWorld()) SendMessageToSetInRange(data, GetVisibilityRange(), false, true, skipped_rcvr); } // pussywizard!

    virtual uint8 getLevelForTarget(WorldObject const* /*target*/) const { return 1; }

    void PlayDistanceSound(uint32 sound_id, Player* target = nullptr);
    void PlayDirectSound(uint32 sound_id, Player* target = nullptr);
    void PlayRadiusSound(uint32 sound_id, float radius);
    void PlayDirectMusic(uint32 music_id, Player* target = nullptr);
    void PlayRadiusMusic(uint32 music_id, float radius);

    void SendObjectDeSpawnAnim(ObjectGuid guid);

    virtual void SaveRespawnTime() {}
    void AddObjectToRemoveList();

    [[nodiscard]] float GetGridActivationRange() const;
    [[nodiscard]] float GetVisibilityRange() const;
    virtual float GetSightRange(WorldObject const* target = nullptr) const;
    //bool CanSeeOrDetect(WorldObject const* obj, bool ignoreStealth = false, bool distanceCheck = false) const;
    bool CanSeeOrDetect(WorldObject const* obj, bool ignoreStealth = false, bool distanceCheck = false, bool checkAlert = false) const;

    FlaggedValuesArray32<int32, uint32, StealthType, TOTAL_STEALTH_TYPES> m_stealth;
    FlaggedValuesArray32<int32, uint32, StealthType, TOTAL_STEALTH_TYPES> m_stealthDetect;

    FlaggedValuesArray32<int32, uint32, InvisibilityType, TOTAL_INVISIBILITY_TYPES> m_invisibility;
    FlaggedValuesArray32<int32, uint32, InvisibilityType, TOTAL_INVISIBILITY_TYPES> m_invisibilityDetect;

    FlaggedValuesArray32<int32, uint32, ServerSideVisibilityType, TOTAL_SERVERSIDE_VISIBILITY_TYPES> m_serverSideVisibility;
    FlaggedValuesArray32<int32, uint32, ServerSideVisibilityType, TOTAL_SERVERSIDE_VISIBILITY_TYPES> m_serverSideVisibilityDetect;

    // Low Level Packets
    void SendPlayMusic(uint32 Music, bool OnlySelf);

    virtual void SetMap(Map* map);
    virtual void ResetMap();
    [[nodiscard]] Map* GetMap() const { ASSERT(m_currMap); return m_currMap; }
    [[nodiscard]] Map* FindMap() const { return m_currMap; }
    //used to check all object's GetMap() calls when object is not in world!

    void SetZoneScript();
    void ClearZoneScript();
    [[nodiscard]] ZoneScript* GetZoneScript() const { return m_zoneScript; }

    TempSummon* SummonCreature(uint32 id, const Position& pos, TempSummonType spwtype = TEMPSUMMON_MANUAL_DESPAWN, uint32 despwtime = 0, uint32 vehId = 0, SummonPropertiesEntry const* properties = nullptr, bool visibleBySummonerOnly = false) const;
    TempSummon* SummonCreature(uint32 id, float x, float y, float z, float ang = 0, TempSummonType spwtype = TEMPSUMMON_MANUAL_DESPAWN, uint32 despwtime = 0, SummonPropertiesEntry const* properties = nullptr, bool visibleBySummonerOnly = false);
    GameObject* SummonGameObject(uint32 entry, float x, float y, float z, float ang, float rotation0, float rotation1, float rotation2, float rotation3, uint32 respawnTime, bool checkTransport = true, GOSummonType summonType = GO_SUMMON_TIMED_OR_CORPSE_DESPAWN);
    Creature*   SummonTrigger(float x, float y, float z, float ang, uint32 dur, bool setLevel = false, CreatureAI * (*GetAI)(Creature*) = nullptr);
    void SummonCreatureGroup(uint8 group, std::list<TempSummon*>* list = nullptr);

    [[nodiscard]] Creature*   FindNearestCreature(uint32 entry, float range, bool alive = true) const;
    [[nodiscard]] GameObject* FindNearestGameObject(uint32 entry, float range, bool onlySpawned = false) const;
    [[nodiscard]] GameObject* FindNearestGameObjectOfType(GameobjectTypes type, float range) const;

    [[nodiscard]] Player* SelectNearestPlayer(float distance = 0) const;
    void GetGameObjectListWithEntryInGrid(std::list<GameObject*>& lList, uint32 uiEntry, float fMaxSearchRange) const;
    void GetCreatureListWithEntryInGrid(std::list<Creature*>& lList, uint32 uiEntry, float fMaxSearchRange) const;
    void GetDeadCreatureListInGrid(std::list<Creature*>& lList, float maxSearchRange, bool alive = false) const;

    void DestroyForNearbyPlayers();
    virtual void UpdateObjectVisibility(bool forced = true, bool fromUpdate = false);
    void BuildUpdate(UpdateDataMapType& data_map, UpdatePlayerSet& player_set) override;
    void GetCreaturesWithEntryInRange(std::list<Creature*>& creatureList, float radius, uint32 entry);

    void SetPositionDataUpdate();
    void UpdatePositionData();

    void AddToObjectUpdate() override;
    void RemoveFromObjectUpdate() override;

    //relocation and visibility system functions
    void AddToNotify(uint16 f);
    void RemoveFromNotify(uint16 f) { m_notifyflags &= ~f; }
    [[nodiscard]] bool isNeedNotify(uint16 f) const { return m_notifyflags & f;}
    [[nodiscard]] uint16 GetNotifyFlags() const { return m_notifyflags; }
    [[nodiscard]] bool NotifyExecuted(uint16 f) const { return m_executed_notifies & f;}
    void SetNotified(uint16 f) { m_executed_notifies |= f;}
    void ResetAllNotifies() { m_notifyflags = 0; m_executed_notifies = 0; }

    [[nodiscard]] bool isActiveObject() const { return m_isActive; }
    void setActive(bool isActiveObject);
    [[nodiscard]] bool IsFarVisible() const { return m_isFarVisible; }
    [[nodiscard]] bool IsVisibilityOverridden() const { return m_visibilityDistanceOverride.has_value(); }
    void SetVisibilityDistanceOverride(VisibilityDistanceType type);
    void SetWorldObject(bool apply);
    [[nodiscard]] bool IsPermanentWorldObject() const { return m_isWorldObject; }
    [[nodiscard]] bool IsWorldObject() const;

    [[nodiscard]] bool IsInWintergrasp() const
    {
        return GetMapId() == 571 && GetPositionX() > 3733.33331f && GetPositionX() < 5866.66663f && GetPositionY() > 1599.99999f && GetPositionY() < 4799.99997f;
    }

#ifdef MAP_BASED_RAND_GEN
    int32 irand(int32 min, int32 max) const     { return int32 (GetMap()->mtRand.randInt(max - min)) + min; }
    uint32 urand(uint32 min, uint32 max) const  { return GetMap()->mtRand.randInt(max - min) + min;}
    int32 rand32() const                        { return GetMap()->mtRand.randInt();}
    double rand_norm() const                    { return GetMap()->mtRand.randExc();}
    double rand_chance() const                  { return GetMap()->mtRand.randExc(100.0);}
#endif

    uint32  LastUsedScriptID;

    // Transports
    [[nodiscard]] Transport* GetTransport() const { return m_transport; }
    [[nodiscard]] float GetTransOffsetX() const { return m_movementInfo.transport.pos.GetPositionX(); }
    [[nodiscard]] float GetTransOffsetY() const { return m_movementInfo.transport.pos.GetPositionY(); }
    [[nodiscard]] float GetTransOffsetZ() const { return m_movementInfo.transport.pos.GetPositionZ(); }
    [[nodiscard]] float GetTransOffsetO() const { return m_movementInfo.transport.pos.GetOrientation(); }
    //npcbot: TC method transfer
    [[nodiscard]] Position const& GetTransOffset() const { return m_movementInfo.transport.pos; }
    //end npcbot
    [[nodiscard]] uint32 GetTransTime()   const { return m_movementInfo.transport.time; }
    [[nodiscard]] int8 GetTransSeat()     const { return m_movementInfo.transport.seat; }
    [[nodiscard]] virtual ObjectGuid GetTransGUID()   const;
    void SetTransport(Transport* t) { m_transport = t; }

    MovementInfo m_movementInfo;

    [[nodiscard]] virtual float GetStationaryX() const { return GetPositionX(); }
    [[nodiscard]] virtual float GetStationaryY() const { return GetPositionY(); }
    [[nodiscard]] virtual float GetStationaryZ() const { return GetPositionZ(); }
    [[nodiscard]] virtual float GetStationaryO() const { return GetOrientation(); }

    [[nodiscard]] float GetMapWaterOrGroundLevel(float x, float y, float z, float* ground = nullptr) const;
    [[nodiscard]] float GetMapHeight(float x, float y, float z, bool vmap = true, float distanceToSearch = 50.0f) const; // DEFAULT_HEIGHT_SEARCH in map.h

    [[nodiscard]] float GetFloorZ() const;
    [[nodiscard]] float GetMinHeightInWater() const;

    [[nodiscard]] virtual float GetCollisionHeight() const { return 0.0f; }
    [[nodiscard]] virtual float GetCollisionWidth() const { return GetObjectSize(); }
    [[nodiscard]] virtual float GetCollisionRadius() const { return GetObjectSize() / 2; }

    void AddAllowedLooter(ObjectGuid guid);
    void ResetAllowedLooters();
    void SetAllowedLooters(GuidUnorderedSet const looters);
    [[nodiscard]] bool HasAllowedLooter(ObjectGuid guid) const;
    [[nodiscard]] GuidUnorderedSet const& GetAllowedLooters() const;
    void RemoveAllowedLooter(ObjectGuid guid);

    std::string GetDebugInfo() const override;

    ElunaEventProcessor* elunaEvents;

protected:
    std::string m_name;
    bool m_isActive;
    bool m_isFarVisible;
    Optional<float> m_visibilityDistanceOverride;
    const bool m_isWorldObject;
    ZoneScript* m_zoneScript;

    virtual void ProcessPositionDataChanged(PositionFullTerrainStatus const& data);
    uint32 _zoneId;
    uint32 _areaId;
    float _floorZ;
    bool _outdoors;
    LiquidData _liquidData;
    bool _updatePositionData;

    // transports
    Transport* m_transport;

    //these functions are used mostly for Relocate() and Corpse/Player specific stuff...
    //use them ONLY in LoadFromDB()/Create() funcs and nowhere else!
    //mapId/instanceId should be set in SetMap() function!
    void SetLocationMapId(uint32 _mapId) { m_mapId = _mapId; }
    void SetLocationInstanceId(uint32 _instanceId) { m_InstanceId = _instanceId; }

    [[nodiscard]] virtual bool IsNeverVisible() const { return !IsInWorld(); }
    virtual bool IsAlwaysVisibleFor(WorldObject const* /*seer*/) const { return false; }
    [[nodiscard]] virtual bool IsInvisibleDueToDespawn() const { return false; }
    //difference from IsAlwaysVisibleFor: 1. after distance check; 2. use owner or charmer as seer
    virtual bool IsAlwaysDetectableFor(WorldObject const* /*seer*/) const { return false; }
private:
    Map* m_currMap;                                    //current object's Map location

    //uint32 m_mapId;                                     // object at map with map_id
    uint32 m_InstanceId;                                // in map copy with instance id
    uint32 m_phaseMask;                                 // in area phase state
    bool m_useCombinedPhases;                           // true (default): use phaseMask as bit mask combining up to 32 phases
    // false: use phaseMask to represent single phases only (up to 4294967295 phases)

    uint16 m_notifyflags;
    uint16 m_executed_notifies;

    virtual bool _IsWithinDist(WorldObject const* obj, float dist2compare, bool is3D, bool useBoundingRadius = true) const;

    bool CanNeverSee(WorldObject const* obj) const;
    virtual bool CanAlwaysSee(WorldObject const* /*obj*/) const { return false; }
    //bool CanDetect(WorldObject const* obj, bool ignoreStealth, bool checkClient) const;
    bool CanDetect(WorldObject const* obj, bool ignoreStealth, bool checkClient, bool checkAlert = false) const;
    bool CanDetectInvisibilityOf(WorldObject const* obj) const;
    //bool CanDetectStealthOf(WorldObject const* obj) const;
    bool CanDetectStealthOf(WorldObject const* obj, bool checkAlert = false) const;

    GuidUnorderedSet _allowedLooters;
};

namespace Acore
{
    // Binary predicate to sort WorldObjects based on the distance to a reference WorldObject
    class ObjectDistanceOrderPred
    {
    public:
        ObjectDistanceOrderPred(WorldObject const* pRefObj, bool ascending = true) : m_refObj(pRefObj), m_ascending(ascending) {}
        bool operator()(WorldObject const* pLeft, WorldObject const* pRight) const
        {
            return m_ascending ? m_refObj->GetDistanceOrder(pLeft, pRight) : !m_refObj->GetDistanceOrder(pLeft, pRight);
        }
    private:
        WorldObject const* m_refObj;
        const bool m_ascending;
    };
}

#endif
