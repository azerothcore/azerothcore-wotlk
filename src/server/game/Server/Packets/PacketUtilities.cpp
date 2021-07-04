/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "PacketUtilities.h"
//#include "Hyperlinks.h"
#include "Errors.h"
#include <utf8.h>
#include <sstream>

WorldPackets::InvalidStringValueException::InvalidStringValueException(std::string const& value) :
    ByteBufferInvalidValueException("string", value.c_str()) { }

WorldPackets::InvalidUtf8ValueException::InvalidUtf8ValueException(std::string const& value) :
    InvalidStringValueException(value) { }

WorldPackets::InvalidHyperlinkException::InvalidHyperlinkException(std::string const& value) :
    InvalidStringValueException(value) { }

WorldPackets::IllegalHyperlinkException::IllegalHyperlinkException(std::string const& value) :
    InvalidStringValueException(value) { }

bool WorldPackets::Strings::Utf8::Validate(std::string const& value)
{
    if (!utf8::is_valid(value.begin(), value.end()))
        throw InvalidUtf8ValueException(value);

    return true;
}

//bool WorldPackets::Strings::Hyperlinks::Validate(std::string const& value)
//{
//    if (!Warhead::Hyperlinks::CheckAllLinks(value))
//        throw InvalidHyperlinkException(value);
//
//    return true;
//}

bool WorldPackets::Strings::NoHyperlinks::Validate(std::string const& value)
{
    if (value.find('|') != std::string::npos)
        throw IllegalHyperlinkException(value);

    return true;
}

WorldPackets::PacketArrayMaxCapacityException::PacketArrayMaxCapacityException(std::size_t requestedSize, std::size_t sizeLimit)
{
    std::ostringstream builder;
    builder << "Attempted to read more array elements from packet " << requestedSize << " than allowed " << sizeLimit;
    message().assign(builder.str());
}

void WorldPackets::CheckCompactArrayMaskOverflow(std::size_t index, std::size_t limit)
{
    ASSERT(index < limit, "Attempted to insert " SZFMTD " values into CompactArray but it can only hold " SZFMTD, index, limit);
}
