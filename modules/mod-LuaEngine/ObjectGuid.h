#ifndef ObjectGuid_h__
#define ObjectGuid_h__

#include "ObjectDefines.h"

class ObjectGuid
{
public:
	ObjectGuid() : _guid(0) { }

	ObjectGuid(uint64 guid) : _guid(guid) { }

	operator uint64() const { return _guid; }

	void Set(uint64 guid) { _guid = guid; }
	void Clear() { _guid = 0; }

	HighGuid GetHigh() const { return HighGuid((_guid >> 48) & 0x0000FFFF); }
	uint32   GetEntry() const { return HasEntry() ? uint32((_guid >> 24) & UI64LIT(0x0000000000FFFFFF)) : 0; }
	uint32   GetCounter()  const
	{
		return HasEntry()
			? uint32(_guid & UI64LIT(0x0000000000FFFFFF))
			: uint32(_guid & UI64LIT(0x00000000FFFFFFFF));
	}

	static uint32 GetMaxCounter(HighGuid high)
	{
		return HasEntry(high)
			? uint32(0x00FFFFFF)
			: uint32(0xFFFFFFFF);
	}

	uint32 GetMaxCounter() const { return GetMaxCounter(GetHigh()); }

	bool IsEmpty()             const { return _guid == 0; }
	bool IsCreature()          const { return GetHigh() == HIGHGUID_UNIT; }
	bool IsPet()               const { return GetHigh() == HIGHGUID_PET; }
	bool IsVehicle()           const { return GetHigh() == HIGHGUID_VEHICLE; }
	bool IsCreatureOrPet()     const { return IsCreature() || IsPet(); }
	bool IsCreatureOrVehicle() const { return IsCreature() || IsVehicle(); }
	bool IsAnyTypeCreature()   const { return IsCreature() || IsPet() || IsVehicle(); }
	bool IsPlayer()            const { return !IsEmpty() && GetHigh() == HIGHGUID_PLAYER; }
	bool IsUnit()              const { return IsAnyTypeCreature() || IsPlayer(); }
	bool IsItem()              const { return GetHigh() == HIGHGUID_ITEM; }
	bool IsGameObject()        const { return GetHigh() == HIGHGUID_GAMEOBJECT; }
	bool IsDynamicObject()     const { return GetHigh() == HIGHGUID_DYNAMICOBJECT; }
	bool IsCorpse()            const { return GetHigh() == HIGHGUID_CORPSE; }
	bool IsTransport()         const { return GetHigh() == HIGHGUID_TRANSPORT; }
	bool IsMOTransport()       const { return GetHigh() == HIGHGUID_MO_TRANSPORT; }
	bool IsAnyTypeGameObject() const { return IsGameObject() || IsTransport() || IsMOTransport(); }
	bool IsInstance()          const { return GetHigh() == HIGHGUID_INSTANCE; }
	bool IsGroup()             const { return GetHigh() == HIGHGUID_GROUP; }

	bool operator!() const { return IsEmpty(); }

	char const* GetTypeName() { return GetLogNameForGuid(_guid); }
	char const* GetTypeName() const { return !IsEmpty() ? GetTypeName() : "None"; }

private:
	static bool HasEntry(HighGuid high)
	{
		switch (high)
		{
		case HIGHGUID_ITEM:
		case HIGHGUID_PLAYER:
		case HIGHGUID_DYNAMICOBJECT:
		case HIGHGUID_CORPSE:
		case HIGHGUID_MO_TRANSPORT:
		case HIGHGUID_INSTANCE:
		case HIGHGUID_GROUP:
			return false;
		case HIGHGUID_GAMEOBJECT:
		case HIGHGUID_TRANSPORT:
		case HIGHGUID_UNIT:
		case HIGHGUID_PET:
		case HIGHGUID_VEHICLE:
		default:
			return true;
		}
	}

	bool HasEntry() const { return HasEntry(GetHigh()); }

	explicit ObjectGuid(uint32 const&) = delete;                 // no implementation, used to catch wrong type assignment
	ObjectGuid(HighGuid, uint32, uint64 counter) = delete;       // no implementation, used to catch wrong type assignment
	ObjectGuid(HighGuid, uint64 counter) = delete;               // no implementation, used to catch wrong type assignment

	uint64 _guid;
};

#endif // ObjectGuid_h__