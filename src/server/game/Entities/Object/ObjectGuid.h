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

#ifndef ObjectGuid_h__
#define ObjectGuid_h__

#include "ByteBuffer.h"
#include "Define.h"
#include <deque>
#include <functional>
#include <list>
#include <memory>
#include <set>
#include <type_traits>
#include <unordered_set>
#include <vector>

enum TypeID
{
    TYPEID_OBJECT        = 0,
    TYPEID_ITEM          = 1,
    TYPEID_CONTAINER     = 2,
    TYPEID_UNIT          = 3,
    TYPEID_PLAYER        = 4,
    TYPEID_GAMEOBJECT    = 5,
    TYPEID_DYNAMICOBJECT = 6,
    TYPEID_CORPSE        = 7
};

#define NUM_CLIENT_OBJECT_TYPES             8

enum TypeMask
{
    TYPEMASK_OBJECT         = 0x0001,
    TYPEMASK_ITEM           = 0x0002,
    TYPEMASK_CONTAINER      = 0x0006,                       // TYPEMASK_ITEM | 0x0004
    TYPEMASK_UNIT           = 0x0008,                       // creature
    TYPEMASK_PLAYER         = 0x0010,
    TYPEMASK_GAMEOBJECT     = 0x0020,
    TYPEMASK_DYNAMICOBJECT  = 0x0040,
    TYPEMASK_CORPSE         = 0x0080,
    TYPEMASK_SEER           = TYPEMASK_PLAYER | TYPEMASK_UNIT | TYPEMASK_DYNAMICOBJECT
};

enum class HighGuid
{
    Item           = 0x4000,                      // blizz 4000
    Container      = 0x4000,                      // blizz 4000
    Player         = 0x0000,                      // blizz 0000
    GameObject     = 0xF110,                      // blizz F110
    Transport      = 0xF120,                      // blizz F120 (for GAMEOBJECT_TYPE_TRANSPORT)
    Unit           = 0xF130,                      // blizz F130
    Pet            = 0xF140,                      // blizz F140
    Vehicle        = 0xF150,                      // blizz F550
    DynamicObject  = 0xF100,                      // blizz F100
    Corpse         = 0xF101,                      // blizz F100
    Mo_Transport   = 0x1FC0,                      // blizz 1FC0 (for GAMEOBJECT_TYPE_MO_TRANSPORT)
    Instance       = 0x1F40,                      // blizz 1F40
    Group          = 0x1F50,
};

template<HighGuid high>
struct ObjectGuidTraits
{
    static bool const Global = false;
    static bool const MapSpecific = false;
};

#define GUID_TRAIT_GLOBAL(highguid) \
    template<> struct ObjectGuidTraits<highguid> \
    { \
        static bool const Global = true; \
        static bool const MapSpecific = false; \
    };

#define GUID_TRAIT_MAP_SPECIFIC(highguid) \
    template<> struct ObjectGuidTraits<highguid> \
    { \
        static bool const Global = false; \
        static bool const MapSpecific = true; \
    };

GUID_TRAIT_GLOBAL(HighGuid::Player)
GUID_TRAIT_GLOBAL(HighGuid::Item)
GUID_TRAIT_GLOBAL(HighGuid::Mo_Transport)
GUID_TRAIT_GLOBAL(HighGuid::Group)
GUID_TRAIT_GLOBAL(HighGuid::Instance)
GUID_TRAIT_MAP_SPECIFIC(HighGuid::Transport)
GUID_TRAIT_MAP_SPECIFIC(HighGuid::Unit)
GUID_TRAIT_MAP_SPECIFIC(HighGuid::Vehicle)
GUID_TRAIT_MAP_SPECIFIC(HighGuid::Pet)
GUID_TRAIT_MAP_SPECIFIC(HighGuid::GameObject)
GUID_TRAIT_MAP_SPECIFIC(HighGuid::DynamicObject)
GUID_TRAIT_MAP_SPECIFIC(HighGuid::Corpse)

class ObjectGuid;
class PackedGuid;

struct PackedGuidReader
{
    explicit PackedGuidReader(ObjectGuid& guid) : Guid(guid) { }
    ObjectGuid& Guid;
};

class ObjectGuid
{
    public:
        static ObjectGuid const Empty;

        typedef uint32 LowType;

        template<HighGuid type>
        static auto Create(LowType counter) -> typename std::enable_if<ObjectGuidTraits<type>::Global, ObjectGuid>::type { return Global(type, counter); }

        template<HighGuid type>
        static auto Create(uint32 entry, LowType counter) -> typename std::enable_if<ObjectGuidTraits<type>::MapSpecific, ObjectGuid>::type { return MapSpecific(type, entry, counter); }

        ObjectGuid()  = default;
        explicit ObjectGuid(uint64 guid) : _guid(guid) { }
        ObjectGuid(HighGuid hi, uint32 entry, LowType counter) : _guid(counter ? uint64(counter) | (uint64(entry) << 24) | (uint64(hi) << 48) : 0) { }
        ObjectGuid(HighGuid hi, LowType counter) : _guid(counter ? uint64(counter) | (uint64(hi) << 48) : 0) { }

        auto ReadAsPacked() -> PackedGuidReader { return PackedGuidReader(*this); }

        void Set(uint64 guid) { _guid = guid; }
        void Clear() { _guid = 0; }

        [[nodiscard]] auto WriteAsPacked() const -> PackedGuid;

        [[nodiscard]] auto   GetRawValue() const -> uint64 { return _guid; }
        [[nodiscard]] auto GetHigh() const -> HighGuid { return HighGuid((_guid >> 48) & 0x0000FFFF); }
        [[nodiscard]] auto   GetEntry() const -> uint32 { return HasEntry() ? uint32((_guid >> 24) & UI64LIT(0x0000000000FFFFFF)) : 0; }
        [[nodiscard]] auto  GetCounter()  const -> LowType
        {
            return HasEntry()
                   ? LowType(_guid & UI64LIT(0x0000000000FFFFFF))
                   : LowType(_guid & UI64LIT(0x00000000FFFFFFFF));
        }

        static auto GetMaxCounter(HighGuid high) -> LowType
        {
            return HasEntry(high)
                   ? LowType(0x00FFFFFF)
                   : LowType(0xFFFFFFFF);
        }

        [[nodiscard]] auto GetMaxCounter() const -> ObjectGuid::LowType { return GetMaxCounter(GetHigh()); }

        [[nodiscard]] auto IsEmpty()             const -> bool { return _guid == 0; }
        [[nodiscard]] auto IsCreature()          const -> bool { return GetHigh() == HighGuid::Unit; }
        [[nodiscard]] auto IsPet()               const -> bool { return GetHigh() == HighGuid::Pet; }
        [[nodiscard]] auto IsVehicle()           const -> bool { return GetHigh() == HighGuid::Vehicle; }
        [[nodiscard]] auto IsCreatureOrPet()     const -> bool { return IsCreature() || IsPet(); }
        [[nodiscard]] auto IsCreatureOrVehicle() const -> bool { return IsCreature() || IsVehicle(); }
        [[nodiscard]] auto IsAnyTypeCreature()   const -> bool { return IsCreature() || IsPet() || IsVehicle(); }
        [[nodiscard]] auto IsPlayer()            const -> bool { return !IsEmpty() && GetHigh() == HighGuid::Player; }
        [[nodiscard]] auto IsUnit()              const -> bool { return IsAnyTypeCreature() || IsPlayer(); }
        [[nodiscard]] auto IsItem()              const -> bool { return GetHigh() == HighGuid::Item; }
        [[nodiscard]] auto IsGameObject()        const -> bool { return GetHigh() == HighGuid::GameObject; }
        [[nodiscard]] auto IsDynamicObject()     const -> bool { return GetHigh() == HighGuid::DynamicObject; }
        [[nodiscard]] auto IsCorpse()            const -> bool { return GetHigh() == HighGuid::Corpse; }
        [[nodiscard]] auto IsTransport()         const -> bool { return GetHigh() == HighGuid::Transport; }
        [[nodiscard]] auto IsMOTransport()       const -> bool { return GetHigh() == HighGuid::Mo_Transport; }
        [[nodiscard]] auto IsAnyTypeGameObject() const -> bool { return IsGameObject() || IsTransport() || IsMOTransport(); }
        [[nodiscard]] auto IsInstance()          const -> bool { return GetHigh() == HighGuid::Instance; }
        [[nodiscard]] auto IsGroup()             const -> bool { return GetHigh() == HighGuid::Group; }

        static auto GetTypeId(HighGuid high) -> TypeID
        {
            switch (high)
            {
                case HighGuid::Item:         return TYPEID_ITEM;
                //case HighGuid::Container:    return TYPEID_CONTAINER; HighGuid::Container == HighGuid::Item currently
                case HighGuid::Unit:         return TYPEID_UNIT;
                case HighGuid::Pet:          return TYPEID_UNIT;
                case HighGuid::Player:       return TYPEID_PLAYER;
                case HighGuid::GameObject:   return TYPEID_GAMEOBJECT;
                case HighGuid::DynamicObject: return TYPEID_DYNAMICOBJECT;
                case HighGuid::Corpse:       return TYPEID_CORPSE;
                case HighGuid::Mo_Transport: return TYPEID_GAMEOBJECT;
                case HighGuid::Vehicle:      return TYPEID_UNIT;
                // unknown
                case HighGuid::Instance:
                case HighGuid::Group:
                default:                    return TYPEID_OBJECT;
            }
        }

        [[nodiscard]] auto GetTypeId() const -> TypeID { return GetTypeId(GetHigh()); }

        operator bool() const { return !IsEmpty(); }
        auto operator!() const -> bool { return !(bool(*this)); }
        auto operator==(ObjectGuid const& guid) const -> bool { return GetRawValue() == guid.GetRawValue(); }
        auto operator!=(ObjectGuid const& guid) const -> bool { return GetRawValue() != guid.GetRawValue(); }
        auto operator< (ObjectGuid const& guid) const -> bool { return GetRawValue() < guid.GetRawValue(); }
        auto operator<= (ObjectGuid const& guid) const -> bool { return GetRawValue() <= guid.GetRawValue(); }

        static auto GetTypeName(HighGuid high) -> char const*;
        [[nodiscard]] auto GetTypeName() const -> char const* { return !IsEmpty() ? GetTypeName(GetHigh()) : "None"; }
        [[nodiscard]] auto ToString() const -> std::string;

    private:
        static auto HasEntry(HighGuid high) -> bool
        {
            switch (high)
            {
                case HighGuid::Item:
                case HighGuid::Player:
                case HighGuid::DynamicObject:
                case HighGuid::Corpse:
                case HighGuid::Mo_Transport:
                case HighGuid::Instance:
                case HighGuid::Group:
                    return false;
                case HighGuid::GameObject:
                case HighGuid::Transport:
                case HighGuid::Unit:
                case HighGuid::Pet:
                case HighGuid::Vehicle:
                default:
                    return true;
            }
        }

        [[nodiscard]] auto HasEntry() const -> bool { return HasEntry(GetHigh()); }

        static auto Global(HighGuid type, LowType counter) -> ObjectGuid;
        static auto MapSpecific(HighGuid type, uint32 entry, LowType counter) -> ObjectGuid;

        explicit ObjectGuid(uint32 const&) = delete;                // no implementation, used to catch wrong type assignment
        ObjectGuid(HighGuid, uint32, uint64 counter) = delete;      // no implementation, used to catch wrong type assignment
        ObjectGuid(HighGuid, uint64 counter) = delete;              // no implementation, used to catch wrong type assignment

        // used to catch wrong type assignment
        operator int64() const = delete;

        uint64 _guid{0};
};

// Some Shared defines
typedef std::set<ObjectGuid> GuidSet;
typedef std::list<ObjectGuid> GuidList;
typedef std::deque<ObjectGuid> GuidDeque;
typedef std::vector<ObjectGuid> GuidVector;
typedef std::unordered_set<ObjectGuid> GuidUnorderedSet;

// minimum buffer size for packed guid is 9 bytes
#define PACKED_GUID_MIN_BUFFER_SIZE 9

class PackedGuid
{
    friend auto operator<<(ByteBuffer& buf, PackedGuid const& guid) -> ByteBuffer&;

    public:
        explicit PackedGuid() : _packedGuid(PACKED_GUID_MIN_BUFFER_SIZE) { _packedGuid.appendPackGUID(0); }
        explicit PackedGuid(uint64 guid) : _packedGuid(PACKED_GUID_MIN_BUFFER_SIZE) { _packedGuid.appendPackGUID(guid); }
        explicit PackedGuid(ObjectGuid guid) : _packedGuid(PACKED_GUID_MIN_BUFFER_SIZE) { _packedGuid.appendPackGUID(guid.GetRawValue()); }

        void Set(uint64 guid) { _packedGuid.wpos(0); _packedGuid.appendPackGUID(guid); }
        void Set(ObjectGuid guid) { _packedGuid.wpos(0); _packedGuid.appendPackGUID(guid.GetRawValue()); }

        [[nodiscard]] auto size() const -> std::size_t { return _packedGuid.size(); }

    private:
        ByteBuffer _packedGuid;
};

class ObjectGuidGeneratorBase
{
public:
    ObjectGuidGeneratorBase(ObjectGuid::LowType start = 1) : _nextGuid(start) { }

    virtual void Set(ObjectGuid::LowType val) { _nextGuid = val; }
    virtual auto Generate() -> ObjectGuid::LowType = 0;
    [[nodiscard]] auto GetNextAfterMaxUsed() const -> ObjectGuid::LowType { return _nextGuid; }
    virtual ~ObjectGuidGeneratorBase() = default;

protected:
    static void HandleCounterOverflow(HighGuid high);
    ObjectGuid::LowType _nextGuid;
};

template<HighGuid high>
class ObjectGuidGenerator : public ObjectGuidGeneratorBase
{
public:
    explicit ObjectGuidGenerator(ObjectGuid::LowType start = 1) : ObjectGuidGeneratorBase(start) { }

    auto Generate() -> ObjectGuid::LowType override
    {
        if (_nextGuid >= ObjectGuid::GetMaxCounter(high) - 1)
            HandleCounterOverflow(high);

        return _nextGuid++;
    }
};

auto operator<<(ByteBuffer& buf, ObjectGuid const& guid) -> ByteBuffer&;
auto operator>>(ByteBuffer& buf, ObjectGuid&       guid) -> ByteBuffer&;

auto operator<<(ByteBuffer& buf, PackedGuid const& guid) -> ByteBuffer&;
auto operator>>(ByteBuffer& buf, PackedGuidReader const& guid) -> ByteBuffer&;

inline auto ObjectGuid::WriteAsPacked() const -> PackedGuid { return PackedGuid(*this); }

namespace std
{
    template<>
    struct hash<ObjectGuid>
    {
        public:
            auto operator()(ObjectGuid const& key) const -> size_t
            {
                return std::hash<uint64>()(key.GetRawValue());
            }
    };
}

#endif // ObjectGuid_h__
