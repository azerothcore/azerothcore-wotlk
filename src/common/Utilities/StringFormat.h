/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _STRING_FORMAT_H_
#define _STRING_FORMAT_H_

#include <fmt/core.h>
#include <fmt/printf.h>

namespace Acore
{
    /// Default AC string format function.
    template<typename Format, typename... Args>
    inline auto StringFormat(Format&& fmt, Args&& ... args) -> std::string
    {
        try
        {
            return fmt::sprintf(std::forward<Format>(fmt), std::forward<Args>(args)...);
        }
        catch (const fmt::format_error& formatError)
        {
            std::string error = "An error occurred formatting string \"" + std::string(fmt) + "\" : " + std::string(formatError.what());
            return error;
        }
    }

    // Default string format function.
    template<typename... Args>
    inline auto StringFormatFmt(std::string_view fmt, Args&&... args) -> std::string
    {
        try
        {
            return fmt::format(fmt, std::forward<Args>(args)...);
        }
        catch (const fmt::format_error& formatError)
        {
            return fmt::format("An error occurred formatting string \"{}\": {}", fmt, formatError.what());
        }
    }

    /// Returns true if the given char pointer is null.
    inline auto IsFormatEmptyOrNull(char const* fmt) -> bool
    {
        return fmt == nullptr;
    }

    /// Returns true if the given std::string is empty.
    inline auto IsFormatEmptyOrNull(std::string_view fmt) -> bool
    {
        return fmt.empty();
    }
}

namespace Acore::String
{
    template<class Str>
    auto Trim(const Str& s, const std::locale& loc = std::locale()) -> Str;
}

#endif
