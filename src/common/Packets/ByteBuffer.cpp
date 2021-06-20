/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ByteBuffer.h"
#include "Common.h"
#include "Log.h"

#include <ace/Stack_Trace.h>
#include <sstream>

ByteBufferPositionException::ByteBufferPositionException(bool add, size_t pos,
                                                         size_t size, size_t valueSize)
{
    std::ostringstream ss;

    ss << "Attempted to " << (add ? "put" : "get") << " value with size: "
       << valueSize << " in ByteBuffer (pos: " << pos << " size: " << size
       << ")";

    message().assign(ss.str());
}

ByteBufferSourceException::ByteBufferSourceException(size_t pos, size_t size,
                                                     size_t valueSize)
{
    std::ostringstream ss;

    ss << "Attempted to put a "
       << (valueSize > 0 ? "NULL-pointer" : "zero-sized value")
       << " in ByteBuffer (pos: " << pos << " size: " << size << ")";

    message().assign(ss.str());
}

void ByteBuffer::hexlike(bool outString) const
{
    if (!outString)
        return;

    uint32 j = 1, k = 1;

    std::ostringstream o;
    o << "STORAGE_SIZE: " << size() << "\nCONTENTS:\n";

    for (uint32 i = 0; i < size(); ++i)
    {
        char buf[3];
        snprintf(buf, 3, "%02X", read<uint8>(i));
        if ((i == (j * 8)) && ((i != (k * 16))))
        {
            o << "| ";
            ++j;
        }
        else if (i == (k * 16))
        {
            o << "\n";
            ++k;
            ++j;
        }

        o << buf << " ";
    }
    o << " ";

    sLog->outString("%s", o.str().c_str());
}
