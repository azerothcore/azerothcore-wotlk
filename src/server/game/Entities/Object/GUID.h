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

#ifndef _GUID_H_
#define _GUID_H_

#include "ByteBuffer.h"
#include "Define.h"
#include <deque>
#include <functional>
#include <list>
#include <set>
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
    TYPEMASK_CONTAINER      = 0x0006,             // TYPEMASK_ITEM | 0x0004
    TYPEMASK_UNIT           = 0x0008,             // creature
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

class WOWGUID;
class SmartGUID;

struct PackedGuidReader
{
    explicit PackedGuidReader(WOWGUID& guid) : Guid(guid) { }
    WOWGUID& Guid;
};

class WOWGUID
{
    public:
        static WOWGUID const Empty;

        typedef uint32 LowType;

        template<HighGuid type>
        static typename std::enable_if<ObjectGuidTraits<type>::Global, WOWGUID>::type Create(LowType counter) { return Global(type, counter); }

        template<HighGuid type>
        static typename std::enable_if<ObjectGuidTraits<type>::MapSpecific, WOWGUID>::type Create(uint32 entry, LowType counter) { return MapSpecific(type, entry, counter); }

        WOWGUID()  = default;
        explicit WOWGUID(uint64 guid) : _guid(guid) { }
        WOWGUID(HighGuid hi, uint32 entry, LowType counter) : _guid(counter ? uint64(counter) | (uint64(entry) << 24) | (uint64(hi) << 48) : 0) { }
        WOWGUID(HighGuid hi, LowType counter) : _guid(counter ? uint64(counter) | (uint64(hi) << 48) : 0) { }

        PackedGuidReader ReadAsPacked() { return PackedGuidReader(*this); }

        void Set(uint64 guid) { _guid = guid; }
        void Clear() { _guid = 0; }

        [[nodiscard]] SmartGUID WriteAsPacked() const;

        [[nodiscard]] uint64   GetRawValue() const { return _guid; }
        [[nodiscard]] HighGuid GetHigh() const { return HighGuid((_guid >> 48) & 0x0000FFFF); }
        [[nodiscard]] uint32   GetEntry() const { return HasEntry() ? uint32((_guid >> 24) & UI64LIT(0x0000000000FFFFFF)) : 0; }
        [[nodiscard]] LowType  GetCounter()  const
        {
            return HasEntry()
                   ? LowType(_guid & UI64LIT(0x0000000000FFFFFF))
                   : LowType(_guid & UI64LIT(0x00000000FFFFFFFF));
        }

        static LowType GetMaxCounter(HighGuid high)
        {
            return HasEntry(high)
                   ? LowType(0x00FFFFFF)
                   : LowType(0xFFFFFFFF);
        }

        [[nodiscard]] WOWGUID::LowType GetMaxCounter() const { return GetMaxCounter(GetHigh()); }

        [[nodiscard]] bool IsEmpty()             const { return _guid == 0; }
        [[nodiscard]] bool IsCreature()          const { return GetHigh() == HighGuid::Unit; }
        [[nodiscard]] bool IsPet()               const { return GetHigh() == HighGuid::Pet; }
        [[nodiscard]] bool IsVehicle()           const { return GetHigh() == HighGuid::Vehicle; }
        [[nodiscard]] bool IsCreatureOrPet()     const { return IsCreature() || IsPet(); }
        [[nodiscard]] bool IsCreatureOrVehicle() const { return IsCreature() || IsVehicle(); }
        [[nodiscard]] bool IsAnyTypeCreature()   const { return IsCreature() || IsPet() || IsVehicle(); }
        [[nodiscard]] bool IsPlayer()            const { return !IsEmpty() && GetHigh() == HighGuid::Player; }
        [[nodiscard]] bool IsUnit()              const { return IsAnyTypeCreature() || IsPlayer(); }
        [[nodiscard]] bool IsItem()              const { return GetHigh() == HighGuid::Item; }
        [[nodiscard]] bool IsGameObject()        const { return GetHigh() == HighGuid::GameObject; }
        [[nodiscard]] bool IsDynamicObject()     const { return GetHigh() == HighGuid::DynamicObject; }
        [[nodiscard]] bool IsCorpse()            const { return GetHigh() == HighGuid::Corpse; }
        [[nodiscard]] bool IsTransport()         const { return GetHigh() == HighGuid::Transport; }
        [[nodiscard]] bool IsMOTransport()       const { return GetHigh() == HighGuid::Mo_Transport; }
        [[nodiscard]] bool IsAnyTypeGameObject() const { return IsGameObject() || IsTransport() || IsMOTransport(); }
        [[nodiscard]] bool IsInstance()          const { return GetHigh() == HighGuid::Instance; }
        [[nodiscard]] bool IsGroup()             const { return GetHigh() == HighGuid::Group; }

        static TypeID GetTypeId(HighGuid high)
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

        [[nodiscard]] TypeID GetTypeId() const { return GetTypeId(GetHigh()); }

        operator bool() const { return !IsEmpty(); }
        bool operator!() const { return !(bool(*this)); }
        bool operator==(WOWGUID const& guid) const { return GetRawValue() == guid.GetRawValue(); }
        bool operator!=(WOWGUID const& guid) const { return GetRawValue() != guid.GetRawValue(); }
        bool operator< (WOWGUID const& guid) const { return GetRawValue() < guid.GetRawValue(); }
        bool operator<= (WOWGUID const& guid) const { return GetRawValue() <= guid.GetRawValue(); }

        static char const* GetTypeName(HighGuid high);
        [[nodiscard]] char const* GetTypeName() const { return !IsEmpty() ? GetTypeName(GetHigh()) : "None"; }
        [[nodiscard]] std::string ToString() const;

    private:
        static bool HasEntry(HighGuid high)
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

        [[nodiscard]] bool HasEntry() const { return HasEntry(GetHigh()); }

        static WOWGUID Global(HighGuid type, LowType counter);
        static WOWGUID MapSpecific(HighGuid type, uint32 entry, LowType counter);

        explicit WOWGUID(uint32 const&) = delete;                // no implementation, used to catch wrong type assignment
        WOWGUID(HighGuid, uint32, uint64 counter) = delete;      // no implementation, used to catch wrong type assignment
        WOWGUID(HighGuid, uint64 counter) = delete;              // no implementation, used to catch wrong type assignment

        // used to catch wrong type assignment
        operator int64() const = delete;

        uint64 _guid{0};
};

// Some Shared defines
typedef std::set<WOWGUID> GuidSet;
typedef std::list<WOWGUID> GuidList;
typedef std::deque<WOWGUID> GuidDeque;
typedef std::vector<WOWGUID> GuidVector;
typedef std::unordered_set<WOWGUID> GuidUnorderedSet;

// minimum buffer size for packed guid is 9 bytes
#define PACKED_GUID_MIN_BUFFER_SIZE 9

class SmartGUID
{
    friend ByteBuffer& operator<<(ByteBuffer& buf, SmartGUID const& guid);

    public:
        explicit SmartGUID() : m_packedGUID(PACKED_GUID_MIN_BUFFER_SIZE) { m_packedGUID.appendPackGUID(0); }
        explicit SmartGUID(uint64 guid) : m_packedGUID(PACKED_GUID_MIN_BUFFER_SIZE) { m_packedGUID.appendPackGUID(guid); }
        explicit SmartGUID(WOWGUID guid) : m_packedGUID(PACKED_GUID_MIN_BUFFER_SIZE) { m_packedGUID.appendPackGUID(guid.GetRawValue()); }

        void Pack(uint64 guid) { m_packedGUID.wpos(0); m_packedGUID.appendPackGUID(guid); }
        void Pack(WOWGUID guid) { m_packedGUID.wpos(0); m_packedGUID.appendPackGUID(guid.GetRawValue()); }

        [[nodiscard]] std::size_t size() const { return m_packedGUID.size(); }

    private:
        ByteBuffer m_packedGUID;
};

class ObjectGuidGeneratorBase
{
public:
    ObjectGuidGeneratorBase(WOWGUID::LowType start = 1) : _nextGuid(start) { }

    virtual void Set(WOWGUID::LowType val) { _nextGuid = val; }
    virtual WOWGUID::LowType Generate() = 0;
    [[nodiscard]] WOWGUID::LowType GetNextAfterMaxUsed() const { return _nextGuid; }
    virtual ~ObjectGuidGeneratorBase() = default;

protected:
    static void HandleCounterOverflow(HighGuid high);
    WOWGUID::LowType _nextGuid;
};

template<HighGuid high>
class ObjectGuidGenerator : public ObjectGuidGeneratorBase
{
public:
    explicit ObjectGuidGenerator(WOWGUID::LowType start = 1) : ObjectGuidGeneratorBase(start) { }

    WOWGUID::LowType Generate() override
    {
        if (_nextGuid >= WOWGUID::GetMaxCounter(high) - 1)
            HandleCounterOverflow(high);

        return _nextGuid++;
    }
};

ByteBuffer& operator<<(ByteBuffer& buf, WOWGUID const& guid);
ByteBuffer& operator>>(ByteBuffer& buf, WOWGUID&       guid);

ByteBuffer& operator<<(ByteBuffer& buf, SmartGUID const& guid);
ByteBuffer& operator>>(ByteBuffer& buf, PackedGuidReader const& guid);

inline SmartGUID WOWGUID::WriteAsPacked() const { return SmartGUID(*this); }

namespace std
{
    template<>
    struct hash<WOWGUID>
    {
        public:
            std::size_t operator()(WOWGUID const& key) const
            {
                return std::hash<uint64>()(key.GetRawValue());
            }
    };
}

#endif // _GUID_H_
