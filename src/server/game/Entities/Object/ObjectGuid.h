/*
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ObjectGuid_h__
#define ObjectGuid_h__

#include "Common.h"
#include "ByteBuffer.h"
#include <type_traits>
#include <functional>

class ObjectGuid;

class ObjectGuid
{
    public:
        static ObjectGuid const Empty;

        typedef uint32 LowType;

        ObjectGuid() : _guid(0) { }
        explicit ObjectGuid(uint64 guid) : _guid(guid) { }

        operator uint64() const { return _guid; }

        void Set(uint64 guid) { _guid = guid; }
        void Clear() { _guid = 0; }

        uint64   GetRawValue() const { return _guid; }
        HighGuid GetHigh() const { return HighGuid((_guid >> 48) & 0x0000FFFF); }
        uint32   GetEntry() const { return HasEntry() ? uint32((_guid >> 24) & UI64LIT(0x0000000000FFFFFF)) : 0; }
        LowType  GetCounter()  const
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

        ObjectGuid::LowType GetMaxCounter() const { return GetMaxCounter(GetHigh()); }
		
        bool operator== (ObjectGuid const& guid) const { return GetRawValue() == guid.GetRawValue(); }
        bool operator!= (ObjectGuid const& guid) const { return GetRawValue() != guid.GetRawValue(); }
        bool operator< (ObjectGuid const& guid) const { return GetRawValue() < guid.GetRawValue(); }

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
			case  HIGHGUID_VEHICLE:
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
