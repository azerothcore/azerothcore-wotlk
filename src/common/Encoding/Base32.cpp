/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU GPL v2 or later license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#include "Base32.h"
#include "BaseEncoding.h"
#include "Errors.h"

struct B32Impl
{
    static constexpr std::size_t BITS_PER_CHAR = 5;

    static constexpr char PADDING = '=';
    static constexpr char Encode(uint8 v)
    {
        ASSERT(v < 0x20);
        if (v < 26) { return 'A' + v; }
        else { return '2' + (v - 26); }
    }

    static constexpr uint8 DECODE_ERROR = 0xff;
    static constexpr uint8 Decode(uint8 v)
    {
        if (v == '0') { return Decode('O'); }
        if (v == '1') { return Decode('l'); }
        if (v == '8') { return Decode('B'); }
        if (('A' <= v) && (v <= 'Z')) { return (v - 'A'); }
        if (('a' <= v) && (v <= 'z')) { return (v - 'a'); }
        if (('2' <= v) && (v <= '7')) { return (v - '2') + 26; }
        return DECODE_ERROR;
    }
};

/*static*/ std::string Acore::Encoding::Base32::Encode(std::vector<uint8> const& data)
{
    return Acore::Impl::GenericBaseEncoding<B32Impl>::Encode(data);
}

/*static*/ Optional<std::vector<uint8>> Acore::Encoding::Base32::Decode(std::string const& data)
{
    return Acore::Impl::GenericBaseEncoding<B32Impl>::Decode(data);
}
