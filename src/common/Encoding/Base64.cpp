/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#include "Base64.h"
#include "BaseEncoding.h"
#include "Errors.h"

struct B64Impl
{
    static constexpr std::size_t BITS_PER_CHAR = 6;

    static constexpr char PADDING = '=';
    static constexpr char Encode(uint8 v)
    {
        ASSERT(v < 0x40);
        if (v < 26) { return 'A' + v; }
        if (v < 52) { return 'a' + (v - 26); }
        if (v < 62) { return '0' + (v - 52); }
        if (v == 62) { return '+'; }
        else { return '/'; }
    }

    static constexpr uint8 DECODE_ERROR = 0xff;
    static constexpr uint8 Decode(uint8 v)
    {
        if (('A' <= v) && (v <= 'Z')) { return (v - 'A'); }
        if (('a' <= v) && (v <= 'z')) { return (v - 'a') + 26; }
        if (('0' <= v) && (v <= '9')) { return (v - '0') + 52; }
        if (v == '+') { return 62; }
        if (v == '/') { return 63; }
        return DECODE_ERROR;
    }
};

/*static*/ std::string Acore::Encoding::Base64::Encode(std::vector<uint8> const& data)
{
    return Acore::Impl::GenericBaseEncoding<B64Impl>::Encode(data);
}

/*static*/ Optional<std::vector<uint8>> Acore::Encoding::Base64::Decode(std::string const& data)
{
    return Acore::Impl::GenericBaseEncoding<B64Impl>::Decode(data);
}
