#include "ObjectGuid.h"
#include "World.h"
#include "ObjectMgr.h"
#include <sstream>
#include <iomanip>

ObjectGuid const ObjectGuid::Empty = ObjectGuid();

char const* ObjectGuid::GetTypeName(HighGuid high)
{
    switch (high)
    {
        case HIGHGUID_ITEM:         return "Item";
        case HIGHGUID_PLAYER:       return "Player";
        case HIGHGUID_GAMEOBJECT:   return "Gameobject";
        case HIGHGUID_TRANSPORT:    return "Transport";
        case HIGHGUID_UNIT:         return "Creature";
        case HIGHGUID_PET:          return "Pet";
        case HIGHGUID_VEHICLE:      return "Vehicle";
        case HIGHGUID_DYNAMICOBJECT: return "DynObject";
        case HIGHGUID_CORPSE:       return "Corpse";
        case HIGHGUID_MO_TRANSPORT: return "MoTransport";
        case HIGHGUID_INSTANCE:     return "InstanceID";
        case HIGHGUID_GROUP:        return "Group";
        default:
            return "<unknown>";
    }
}

std::string ObjectGuid::ToString() const
{
    std::ostringstream str;
    str << GetTypeName();

    str << "GUID Full: 0x" << std::hex << std::setw(16) << std::setfill('0') << m_guid;
    str << " Type: " << GetTypeName();
    if (HasEntry())
        str << (IsPet() ? " Pet number: " : " Entry: ") << GetEntry() << " ";

    str << " Low: " << GetCounter();
    return str.str();
}

template<HighGuid high>
uint32 ObjectGuidGenerator<high>::Generate()
{
    if (m_nextGuid >= ObjectGuid::GetMaxCounter(high) - 1)
    {
        sLog->outError("%s guid overflow!! Can't continue, shutting down server. ", ObjectGuid::GetTypeName(high));
        World::StopNow(ERROR_EXIT_CODE);
    }
    return m_nextGuid++;
}

ByteBuffer& operator<<(ByteBuffer& buf, ObjectGuid const& guid)
{
    buf << uint64(guid.GetRawValue());
    return buf;
}

ByteBuffer& operator>>(ByteBuffer& buf, ObjectGuid& guid)
{
    guid.Set(buf.read<uint64>());
    return buf;
}

ByteBuffer& operator<<(ByteBuffer& buf, PackedGuid const& guid)
{
    buf.append(guid.m_packedGuid);
    return buf;
}

ByteBuffer& operator>>(ByteBuffer& buf, PackedGuidReader const& guid)
{
    buf.readPackGUID(*reinterpret_cast<uint64*>(guid.m_guidPtr));
    return buf;
}

template uint32 ObjectGuidGenerator<HIGHGUID_ITEM>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_PLAYER>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_GAMEOBJECT>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_TRANSPORT>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_UNIT>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_PET>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_VEHICLE>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_DYNAMICOBJECT>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_CORPSE>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_INSTANCE>::Generate();
template uint32 ObjectGuidGenerator<HIGHGUID_GROUP>::Generate();
