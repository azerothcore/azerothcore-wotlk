/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __STRING_FORMAT_H__
#define __STRING_FORMAT_H__

#include "fmt/printf.h"
#include <algorithm> 
#include <functional> 
#include <cctype>
#include <locale>

namespace acore
{
	// This class contains enumerations and static
	// utility functions for dealing with ASCII characters
	// and their properties.
	//
	// The classification functions will also work if
	// non-ASCII character codes are passed to them,
	// but classification will only check for
	// ASCII characters.
	//
	// This allows the classification methods to be used
	// on the single bytes of a UTF-8 string, without
	// causing assertions or inconsistent results (depending
	// upon the current locale) on bytes outside the ASCII range,
	// as may be produced by Ascii::isSpace(), etc.
    class  Ascii
    {
        public:
            enum CharacterProperties
		    // ASCII character properties.
            {
                ACP_CONTROL  = 0x0001,
                ACP_SPACE    = 0x0002,
                ACP_PUNCT    = 0x0004,
                ACP_DIGIT    = 0x0008,
                ACP_HEXDIGIT = 0x0010,
                ACP_ALPHA    = 0x0020,
                ACP_LOWER    = 0x0040,
                ACP_UPPER    = 0x0080,
                ACP_GRAPH    = 0x0100,
                ACP_PRINT    = 0x0200
		    };
	
		    static int properties(int ch);
		    // Return the ASCII character properties for the
		    // character with the given ASCII value.
		    //
		    // If the character is outside the ASCII range
		    // (0 .. 127), 0 is returned.

		    static bool hasSomeProperties(int ch, int properties);
		    // Returns true if the given character is
		    // within the ASCII range and has at least one of 
		    // the given properties.

		    static bool hasProperties(int ch, int properties);
		    // Returns true if the given character is
		    // within the ASCII range and has all of 
		    // the given properties.

		    static bool isAscii(int ch);
		    // Returns true iff the given character code is within
		    // the ASCII range (0 .. 127).
		
		    static bool isSpace(int ch);
		    // Returns true iff the given character is a whitespace.
		
		    static bool isDigit(int ch);
		    // Returns true iff the given character is a digit.

		    static bool isHexDigit(int ch);
		    // Returns true iff the given character is a hexadecimal digit.
		
		    static bool isPunct(int ch);
		    // Returns true iff the given character is a punctuation character.
		
		    static bool isAlpha(int ch);
		    // Returns true iff the given character is an alphabetic character.	

		    static bool isAlphaNumeric(int ch);
		    // Returns true iff the given character is an alphabetic character.	
		
		    static bool isLower(int ch);
		    // Returns true iff the given character is a lowercase alphabetic
		    // character.
		
		    static bool isUpper(int ch);
		    // Returns true iff the given character is an uppercase alphabetic
		    // character.
		
		    static int toLower(int ch);
		    // If the given character is an uppercase character,
		    // return its lowercase counterpart, otherwise return
		    // the character.

		    static int toUpper(int ch);
		    // If the given character is a lowercase character,
		    // return its uppercase counterpart, otherwise return
		    // the character.
		
        private:
            static const int CHARACTER_PROPERTIES[128];
    };

    // inlines
    inline int Ascii::properties(int ch)
    {
        if (isAscii(ch)) 
            return CHARACTER_PROPERTIES[ch];
        else
            return 0;
    }

    inline bool Ascii::isAscii(int ch)
    {
        return (static_cast<uint32>(ch) & 0xFFFFFF80) == 0;
    }


    inline bool Ascii::hasProperties(int ch, int props)
    {
        return (properties(ch) & props) == props;
    }


    inline bool Ascii::hasSomeProperties(int ch, int props)
    {
        return (properties(ch) & props) != 0;
    }

    inline bool Ascii::isSpace(int ch)
    {
	    return hasProperties(ch, ACP_SPACE);
    }

    inline bool Ascii::isDigit(int ch)
    {
	    return hasProperties(ch, ACP_DIGIT);
    }

    inline bool Ascii::isHexDigit(int ch)
    {
        return hasProperties(ch, ACP_HEXDIGIT);
    }

    inline bool Ascii::isPunct(int ch)
    {
	    return hasProperties(ch, ACP_PUNCT);
    }

    inline bool Ascii::isAlpha(int ch)
    {
    	return hasProperties(ch, ACP_ALPHA);
    }

    inline bool Ascii::isAlphaNumeric(int ch)
    {
        return hasSomeProperties(ch, ACP_ALPHA | ACP_DIGIT);
    }

    inline bool Ascii::isLower(int ch)
    {
        return hasProperties(ch, ACP_LOWER);
    }

    inline bool Ascii::isUpper(int ch)
    {
        return hasProperties(ch, ACP_UPPER);
    }

    inline int Ascii::toLower(int ch)
    {
        if (isUpper(ch))
            return ch + 32;
        else
            return ch;
    }

    inline int Ascii::toUpper(int ch)
    {
        if (isLower(ch))
            return ch - 32;
        else
            return ch;
    }

    // Default AC string format function.
    template<typename Format, typename... Args>
    inline std::string StringFormat(Format&& fmt, Args&& ... args)
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

    // Returns true if the given char pointer is null.
    inline bool IsFormatEmptyOrNull(char const* fmt)
    {
        return fmt == nullptr;
    }

    // Returns true if the given std::string is empty.
    inline bool IsFormatEmptyOrNull(std::string const& fmt)
    {
        return fmt.empty();
    }

    // trim from start (in place)
    static inline void ltrim(std::string &s)
    {
        s.erase(s.begin(), std::find_if(s.begin(), s.end(),
            std::not1(std::ptr_fun<int, int>(std::isspace))));
    }

    // trim from end (in place)
    static inline void rtrim(std::string &s)
    {
        s.erase(std::find_if(s.rbegin(), s.rend(),
            std::not1(std::ptr_fun<int, int>(std::isspace))).base(), s.end());
    }

    // trim from both ends (in place)
    static inline void trim(std::string &s)
    {
        ltrim(s);
        rtrim(s);
    }

    // trim from start (copying)
    static inline std::string ltrim_copy(std::string s)
    {
        ltrim(s);
        return s;
    }

    // trim from end (copying)
    static inline std::string rtrim_copy(std::string s)
    {
        rtrim(s);
        return s;
    }

    // trim from both ends (copying)
    static inline std::string trim_copy(std::string s)
    {
        trim(s);
        return s;
    }

    template <class S>
    S toUpper(const S& str)
    // Returns a copy of str containing all upper-case characters.
    {
        typename S::const_iterator it  = str.begin();
        typename S::const_iterator end = str.end();

        S result;
        result.reserve(str.size());
        while (it != end) result += static_cast<typename S::value_type>(Ascii::toUpper(*it++));
        return result;
    }


    template <class S>
    S& toUpperInPlace(S& str)
    // Replaces all characters in str with their upper-case counterparts.
    {
        typename S::iterator it  = str.begin();
        typename S::iterator end = str.end();

        while (it != end) { *it = static_cast<typename S::value_type>(Ascii::toUpper(*it)); ++it; }
        return str;
    }


    template <class S>
    S toLower(const S& str)
    // Returns a copy of str containing all lower-case characters.
    {
        typename S::const_iterator it  = str.begin();
        typename S::const_iterator end = str.end();

        S result;
        result.reserve(str.size());
        while (it != end) result += static_cast<typename S::value_type>(Ascii::toLower(*it++));
        return result;
    }


    template <class S>
    S& toLowerInPlace(S& str)
	// Replaces all characters in str with their lower-case counterparts.
    {
        typename S::iterator it  = str.begin();
        typename S::iterator end = str.end();

        while (it != end) { *it = static_cast<typename S::value_type>(Ascii::toLower(*it)); ++it; }
        return str;
    }

}

#endif
