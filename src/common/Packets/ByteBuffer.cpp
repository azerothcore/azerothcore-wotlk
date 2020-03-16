/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ByteBuffer.h"
#include "Errors.h"
#include "MessageBuffer.h"
#include "Common.h"
#include "Log.h"
#include "Util.h"
#include <utf8.h>
#include <sstream>
#include <ctime>

ByteBuffer::ByteBuffer(MessageBuffer&& buffer) : _rpos(0), _wpos(0), _storage(buffer.Move())
{
}

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

ByteBufferInvalidValueException::ByteBufferInvalidValueException(char const* type, size_t pos)
{
    message().assign(acore::StringFormat("Invalid %s value found in ByteBuffer at pos " SZFMTD, type, pos));
}

ByteBuffer& ByteBuffer::operator>>(float& value)
{
    value = read<float>();
    if (!std::isfinite(value))
        throw ByteBufferInvalidValueException("float", _rpos - sizeof(float));
    return *this;
}

ByteBuffer& ByteBuffer::operator>>(double& value)
{
    value = read<double>();
    if (!std::isfinite(value))
        throw ByteBufferInvalidValueException("double", _rpos - sizeof(double));
    return *this;
}

std::string ByteBuffer::ReadCString(bool requireValidUtf8 /*= true*/)
{
    std::string value;
    while (rpos() < size())                         // prevent crash at wrong string format in packet
    {
        char c = read<char>();
        if (c == 0)
            break;
        value += c;
    }
    if (requireValidUtf8 && !utf8::is_valid(value.begin(), value.end()))
        throw ByteBufferInvalidValueException("string", _rpos - value.length() - 1);
    return value;
}

uint32 ByteBuffer::ReadPackedTime()
{
    uint32 packedDate = read<uint32>();
    tm lt = tm();

    lt.tm_min = packedDate & 0x3F;
    lt.tm_hour = (packedDate >> 6) & 0x1F;
    //lt.tm_wday = (packedDate >> 11) & 7;
    lt.tm_mday = ((packedDate >> 14) & 0x3F) + 1;
    lt.tm_mon = (packedDate >> 20) & 0xF;
    lt.tm_year = ((packedDate >> 24) & 0x1F) + 100;

    return uint32(mktime(&lt));
}

void ByteBuffer::append(uint8 const* src, size_t cnt)
{
    ASSERT(src, "Attempted to put a NULL-pointer in ByteBuffer (pos: " SZFMTD " size: " SZFMTD ")", _wpos, size());
    ASSERT(cnt, "Attempted to put a zero-sized value in ByteBuffer (pos: " SZFMTD " size: " SZFMTD ")", _wpos, size());
    ASSERT(size() < 10000000);

    size_t const newSize = _wpos + cnt;
    if (_storage.capacity() < newSize) // custom memory allocation rules
    {
        if (newSize < 100)
            _storage.reserve(300);
        else if (newSize < 750)
            _storage.reserve(2500);
        else if (newSize < 6000)
            _storage.reserve(10000);
        else
            _storage.reserve(400000);
    }

    if (_storage.size() < newSize)
        _storage.resize(newSize);
    std::memcpy(&_storage[_wpos], src, cnt);
    _wpos = newSize;
}

void ByteBuffer::AppendPackedTime(time_t time)
{
    tm lt;
    localtime_r(&time, &lt);
    append<uint32>((lt.tm_year - 100) << 24 | lt.tm_mon << 20 | (lt.tm_mday - 1) << 14 | lt.tm_wday << 11 | lt.tm_hour << 6 | lt.tm_min);
}

void ByteBuffer::put(size_t pos, const uint8 *src, size_t cnt)
{
    if (pos + cnt > size())
        throw ByteBufferPositionException(true, pos, cnt, size());

    if (!src)
        throw ByteBufferSourceException(_wpos, size(), cnt);

    std::memcpy(&_storage[pos], src, cnt);
}

void ByteBuffer::print_storage(bool outString) const
{
    if (!outString)
        return;

    std::ostringstream o;
    o << "STORAGE_SIZE: " << size();
    for (uint32 i = 0; i < size(); ++i)
        o << read<uint8>(i) << " - ";
    o << " ";

    sLog->outString("%s", o.str().c_str());
}

void ByteBuffer::textlike(bool outString) const
{
    if (!outString)
        return;

    std::ostringstream o;
    o << "STORAGE_SIZE: " << size();
    for (uint32 i = 0; i < size(); ++i)
    {
        char buf[2];
        snprintf(buf, 2, "%c", read<uint8>(i));
        o << buf;
    }
    o << " ";

    sLog->outString("%s", o.str().c_str());
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
