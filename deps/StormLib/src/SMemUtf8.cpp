/*****************************************************************************/
/* SFileVerify.cpp                        Copyright (c) Ladislav Zezula 2010 */
/*---------------------------------------------------------------------------*/
/* Support for conversion of UTF-8 <-> File name                             */
/*                                                                           */
/* File names in the MPQs are assumed to be UTF-8. However, bad sequences    */
/* or filename unsafe characters are allowed in the list files, but won't    */
/* work in unpacking files from MPQ to a local file.                         */
/*                                                                           */
/* This module contains cross-platform comparable conversion between UTF-8   */
/* and file names that will produce identical file names across platforms.   */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 31.10.24  1.00  Lad  Created                                              */
/*****************************************************************************/

#define __STORMLIB_SELF__
#include "StormLib.h"
#include "StormCommon.h"

//-----------------------------------------------------------------------------
// Local defines

#define MAX_INVALID_CHARS               128         // Maximum number of invalid characters in a row

//-----------------------------------------------------------------------------
// Conversion tables

const unsigned char SMemCharToByte[0x80] =
{
    //   00    01    02    03    04    05    06    07    08    09    0A    0B    0C    0D    0E    0F
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // 0xFF
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // 0x10
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // 0x20
        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // 0x30
        0xFF, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // 0x40
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // 0x50
        0xFF, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, // 0x60
        0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF  // 0x70
};

static TCHAR szInvalidCharPrefix[] = _T("%u[");

//-----------------------------------------------------------------------------
// Local functions

// Bit mask of characters that are file name safe. We will maintain
// the same charset even on non-Windows in order to keep the file names equal
static unsigned int FileNameSafeChars[4] =
{
    0x00000000, 0x2BFF7BFB, 0xFFFFFFFF, 0xEFFFFFFF      // Windows: [0x20-0x7F], except 0x22, 0x2A, 0x2F, 0x3A, 0x3C, 0x3E, 0x3F, 0x7C
//  0xfffffffe, 0xffff7fff, 0xffffffff, 0xffffffff      // Linux:   [0x01-0x7F], except 0x2F
};

static bool UTF8_IsBadFileNameCharacter(DWORD ch)
{
    // It is guaranteed that the character is in range of 0x00 - 0x7F
    assert(ch < 0x80);

    // Use the bit from the table
    return (FileNameSafeChars[ch / 32] & (1 << (ch % 32))) ? false : true;
}

static DWORD UTF8_DecodeSequence(const BYTE * pbString, BYTE BitsMask, size_t ccFollowBytes, DWORD dwMinValue, DWORD dwMaxValue, DWORD & dwCodePoint, size_t & ccBytesEaten)
{
    const BYTE * pbSaveString = pbString;
    DWORD dwAccumulator;

    // Extract the low bits from the leading byte
    dwAccumulator = pbString[0] & BitsMask;
    ccBytesEaten = 1;
    pbString++;

    // Process the follow-up bytes
    for(size_t i = 0; i < ccFollowBytes; i++)
    {
        // Every follow-up byte in the UTF-8 sequence must start with 10xxxxxx
        if((pbString[0] & 0xC0) != 0x80)
            return ERROR_NO_UNICODE_TRANSLATION;

        // Add 6 bits to the accumulator
        dwAccumulator = (dwAccumulator << 6) | (*pbString++ & 0x3F);
    }

    // Check whether the code point is in the given range
    if(!(dwMinValue <= dwAccumulator && dwAccumulator <= dwMaxValue))
        return ERROR_INVALID_DATA;

    // Give the number of bytes eaten and the decoded code point
    ccBytesEaten = (pbString - pbSaveString);
    dwCodePoint = dwAccumulator;
    return ERROR_SUCCESS;
}

// https://en.wikipedia.org/wiki/UTF-8
DWORD UTF8_DecodeCodePoint(const BYTE * pbString, const BYTE * pbStringEnd, DWORD & dwCodePoint, size_t & ccBytesEaten, DWORD dwFlags)
{
    // Reset the number of bytes eaten
    dwCodePoint = SFILE_UTF8_INVALID_CHARACTER;
    ccBytesEaten = 0;

    if(pbString < pbStringEnd)
    {
        // At least one byte will be eaten
        ccBytesEaten = 1;

        // 1st code point (0x00 - 0x7F, 1 byte)
        if(pbString[0] <= 0x7F)
        {
            // This is the perfect spot to check for filename-unsafe characters
            if((dwFlags & SFILE_UTF8_KEEP_INVALID_FCH) == 0 && UTF8_IsBadFileNameCharacter(pbString[0]))
                return ERROR_NO_UNICODE_TRANSLATION;

            // Decode the 1-byte sequence
            dwCodePoint = pbString[0];
            return ERROR_SUCCESS;
        }

        // 2nd code point (0x80 - 0x7FF, 2 bytes)
        if((pbString[0] & 0xE0) == 0xC0 && (pbString + 2) <= pbStringEnd)
        {
            // Decode the 2-byte sequence
            return UTF8_DecodeSequence(pbString, 0x1F, 1, 0x80, 0x7FF, dwCodePoint, ccBytesEaten);
        }

        // 3rd code point (0x800 - 0xFFFF, 3 bytes)
        // Note: MultiByteToWideChar will not decode 0xE0 0xBF 0xBF (--> 0x0FFF),
        if((pbString[0] & 0xF0) == 0xE0 && (pbString + 3) <= pbStringEnd)
        {
            // Decode the 3-byte sequence
            return UTF8_DecodeSequence(pbString, 0x0F, 2, 0x800, 0xFFFF, dwCodePoint, ccBytesEaten);
        }

        // 4th code point (0x10000 - 0x10FFFF, 4 bytes)
        if((pbString[0] & 0xF8) == 0xF0 && (pbString + 4) <= pbStringEnd)
        {
            // Try to decode 4-byte sequence
            return UTF8_DecodeSequence(pbString, 0x07, 3, 0x10000, SFILE_UNICODE_MAX, dwCodePoint, ccBytesEaten);
        }

        // An invalid UTF-8 sequence encountered
        return ERROR_NO_UNICODE_TRANSLATION;
    }

    // No bytes available. Should never happen
    assert(false);
    return ERROR_BUFFER_OVERFLOW;
}

static size_t UTF8_EncodeSequence(DWORD dwCodePoint, BYTE LeadingByte, DWORD dwFollowByteCount, LPBYTE Utf8Buffer)
{
    DWORD dwByteShift = dwFollowByteCount * 6;

    // Encode the highest byte
    Utf8Buffer[0] = (BYTE)(LeadingByte | (dwCodePoint >> dwByteShift));
    dwByteShift -= 6;

    // Encode the follow bytes
    for(DWORD i = 0; i < dwFollowByteCount; i++)
    {
        // The follow byte must be 10xxxxxx
        Utf8Buffer[i + 1] = (BYTE)(0x80 | ((dwCodePoint >> dwByteShift) & 0x3F));
        dwByteShift -= 6;
    }

    return dwFollowByteCount + 1;
}

size_t UTF8_EncodeCodePoint(DWORD dwCodePoint, LPBYTE Utf8Buffer)
{
    // 0x00 - 0x7F, 1 byte
    if(dwCodePoint < 0x80)
        return UTF8_EncodeSequence(dwCodePoint, 0x00, 0, Utf8Buffer);

    // 0x80 - 0x7FF
    if(dwCodePoint < 0x800)
        return UTF8_EncodeSequence(dwCodePoint, 0xC0, 1, Utf8Buffer);

    // 0x800 - 0xFFFF
    if(dwCodePoint < 0x10000)
        return UTF8_EncodeSequence(dwCodePoint, 0xE0, 2, Utf8Buffer);

    // 0x800 - 0xFFFF
    if(dwCodePoint < 0x110000)
        return UTF8_EncodeSequence(dwCodePoint, 0xF0, 3, Utf8Buffer);

    // Should never happen
    assert(false);
    return 0;
}

static size_t UTF8_FlushInvalidChars(LPTSTR szBuffer, size_t ccBuffer, size_t nOutLength, LPBYTE InvalidChars, size_t nInvalidChars)
{
    // Case 0: No invalid char -> do nothing
    if(nInvalidChars == 0)
    {
        return nOutLength;
    }

    // Case 1: One invalid char -> %xx (compatible with previous versions of MPQ Editor)
    if(nInvalidChars == 1)
    {
        // Space for 3 characters needed
        if(szBuffer != NULL && (nOutLength + 3) <= ccBuffer)
        {
            szBuffer[nOutLength] = '%';
            SMemBinToStr(szBuffer + nOutLength + 1, ccBuffer - 1, InvalidChars, 1);
        }
        return nOutLength + 3;
    }

    // Case 1: More than one invalid char -> %u[xxyyzz]
    else
    {
        // Enough space for %u[xxyyzz]
        size_t nLengthNeeded = nInvalidChars * 2 + 4;

        // Space for 4 characters needed
        if(szBuffer != NULL && (nOutLength + nLengthNeeded) <= ccBuffer)
        {
            memcpy(szBuffer + nOutLength, szInvalidCharPrefix, sizeof(szInvalidCharPrefix) - sizeof(TCHAR));

            SMemBinToStr(szBuffer + nOutLength + 3, ccBuffer - 3, InvalidChars, nInvalidChars);

            szBuffer[nOutLength + nLengthNeeded - 1] = ']';
            szBuffer[nOutLength + nLengthNeeded] = 0;
        }
        return nOutLength + nLengthNeeded;
    }
}

size_t UTF8_FlushBinBuffer(LPBYTE pbBuffer, size_t ccBuffer, size_t nOutLength, LPBYTE BinBuffer, size_t nByteCount)
{
    if(pbBuffer != NULL && (nOutLength + nByteCount) < ccBuffer)
        memcpy(pbBuffer + nOutLength, BinBuffer, nByteCount);
    return nOutLength + nByteCount;
}

#ifdef STORMLIB_WIDE_CHAR
static size_t UTF16_EncodeCodePoint(DWORD dwCodePoint, unsigned short * Utf16Buffer)
{
    // https://en.wikipedia.org/wiki/UTF-16
    if(dwCodePoint <= 0xFFFF)
    {
        Utf16Buffer[0] = (unsigned short)(dwCodePoint);
        return 1;
    }

    if(dwCodePoint <= SFILE_UNICODE_MAX)
    {
        // Fix the code point
        dwCodePoint -= 0x10000;

        // Split the code point to two 10-bit values
        Utf16Buffer[0] = (unsigned short)(0xD800 + (dwCodePoint >> 10));    // High 6 bytes
        Utf16Buffer[1] = (unsigned short)(0xDC00 + (dwCodePoint & 0x3FF));  // Low 10 bytes
        return 2;
    }

    // Should never happen
    assert(false);
    return 0;
}

static DWORD UTF16_DecodeCodePoint(LPCTSTR szString, LPCTSTR szStringEnd, DWORD & dwCodePoint, size_t & ccCharsEaten)
{
    // Reset the number of bytes eaten
    dwCodePoint = SFILE_UTF8_INVALID_CHARACTER;
    ccCharsEaten = 0;

    if(szString < szStringEnd)
    {
        // At least one char will be eaten
        ccCharsEaten = 1;

        // Check for an invalid surrogate pair
        if(0xDC00 <= szString[0] && szString[0] <= 0xDFFF)
        {
            dwCodePoint = SFILE_UTF8_INVALID_CHARACTER;
            return ERROR_NO_UNICODE_TRANSLATION;
        }

        // Check for a valid surrogate pair
        if(0xD800 <= szString[0] && szString[0] <= 0xDBFF && (szString + 1) < szStringEnd)
        {
            dwCodePoint = ((szString[0] - 0xD800) << 10) | (szString[1] - 0xDC00) + 0x10000;
            ccCharsEaten = 2;
            return ERROR_SUCCESS;
        }

        // Direct encoding
        dwCodePoint = szString[0];
        ccCharsEaten = 1;
        return ERROR_SUCCESS;
    }

    // No bytes available. Should never happen
    assert(false);
    return ERROR_BUFFER_OVERFLOW;
}
#endif

size_t UTF16_IsEncodedCharSequence(LPCTSTR szString, LPCTSTR szStringEnd, LPBYTE BinBuffer)
{
    size_t nEncodedChars = 0;

    if((szString + 1) < szStringEnd && *szString++ == '%')
    {
        if((szString + 1) < szStringEnd && *szString++ == 'u')
        {
            if((szString + 1) < szStringEnd && *szString++ == '[')
            {
                // Keep going as long as we can convert
                for(size_t i = 0; i < MAX_INVALID_CHARS; i++)
                {
                    if(szString + (i * 2) >= szStringEnd)
                        break;
                    if(szString[i * 2] == ']')
                        break;
                    nEncodedChars++;
                }

                // Did we encounter the end of the string?
                if(szString + (nEncodedChars * 2) + 1 <= szStringEnd && szString[nEncodedChars * 2] == ']')
                {
                    TCHAR HexaString[MAX_INVALID_CHARS * 2 + 1];

                    // Copy the hexadecimal string
                    memcpy(HexaString, szString, (nEncodedChars * 2) * sizeof(TCHAR));
                    HexaString[nEncodedChars * 2] = 0;

                    // Try to decode the hexa string
                    if(SMemStrToBin(HexaString, BinBuffer, nEncodedChars) == ERROR_SUCCESS)
                    {
                        return nEncodedChars;
                    }
                }
            }
        }
    }
    return 0;
}

//-----------------------------------------------------------------------------
// Public (exported) functions

// Conversion of MPQ file name to file-name-safe string
DWORD WINAPI SMemUTF8ToFileName(
    LPTSTR szBuffer,                // Pointer to the output buffer. If NULL, the function will calculate the needed length
    size_t ccBuffer,                // Length of the output buffer (must include EOS)
    const void * lpString,          // Pointer to the begin of the string
    const void * lpStringEnd,       // Pointer to the end of string. If NULL, it's assumed to be zero-terminated
    DWORD dwFlags,                  // Additional flags
    size_t * pOutLength = NULL)     // Pointer to a variable that receives the needed length (optional)
{
    const BYTE * pbStringEnd = (const BYTE *)lpStringEnd;
    const BYTE * pbString = (const BYTE *)lpString;
    DWORD dwErrCode = ERROR_SUCCESS;
    size_t nInvalidChars = 0;
    size_t nOutLength = 0;
    BYTE InvalidChars[MAX_INVALID_CHARS];

    // Set the end of the input if not specified
    if(pbStringEnd == NULL)
        pbStringEnd = pbString + strlen((char *)pbString);

    // Keep conversion as long
    while(pbString < pbStringEnd)
    {
        size_t ccBytesEaten = 0;
        size_t nCharLength;
        DWORD dwCodePoint = 0;

        // Decode the single UTF-8 char
        if((dwErrCode = UTF8_DecodeCodePoint(pbString, pbStringEnd, dwCodePoint, ccBytesEaten, dwFlags)) != ERROR_SUCCESS)
        {
            // Exactly one byte should be eaten on error
            assert(ccBytesEaten == 1);

            // If invalid chars are allowed, we replace the result with 0xFFFD
            if(dwFlags & SFILE_UTF8_REPLACE_INVALID)
            {
                // Replace the code point with invalid marker and continue on the next character
                dwCodePoint = SFILE_UTF8_INVALID_CHARACTER;
                dwErrCode = ERROR_SUCCESS;
            }

            // If the invalid chars are not allowed, we put the invalid char to the stack
            else
            {
                // Flush the invalid characters, if full
                if(nInvalidChars >= _countof(InvalidChars))
                {
                    nOutLength = UTF8_FlushInvalidChars(szBuffer, ccBuffer, nOutLength, InvalidChars, nInvalidChars);
                    nInvalidChars = 0;
                }

                // Put the invalid char to the stack
                InvalidChars[nInvalidChars++] = pbString[0];
                pbString++;
                continue;
            }
        }

        // Check whether the unicode char is not out of range
        assert(dwCodePoint <= SFILE_UNICODE_MAX);

        // Move the source pointer by the number of bytes eaten
        pbString = pbString + ccBytesEaten;

        // Flush the invalid characters, if any
        nOutLength = UTF8_FlushInvalidChars(szBuffer, ccBuffer, nOutLength, InvalidChars, nInvalidChars);
        nInvalidChars = 0;

#ifdef STORMLIB_WIDE_CHAR
        {
            unsigned short Utf16Buffer[2];

            // Encode the code point into UTF-16
            nCharLength = UTF16_EncodeCodePoint(dwCodePoint, Utf16Buffer);

            // Write the encoded UTF-16 to the output buffer, if present
            if(szBuffer != NULL && (nOutLength + nCharLength) < ccBuffer)
            {
                memcpy(szBuffer + nOutLength, Utf16Buffer, nCharLength * sizeof(unsigned short));
            }
        }
#else
        {
            BYTE Utf8Buffer[4];

            // Encode the code point into UTF-8
            nCharLength = UTF8_EncodeCodePoint(dwCodePoint, Utf8Buffer);

            // Write the encoded UTF-16 to the output buffer, if present
            if(szBuffer != NULL && (nOutLength + nCharLength) < ccBuffer)
            {
                memcpy(szBuffer + nOutLength, Utf8Buffer, nCharLength);
            }
        }
#endif

        // Increment the output length
        nOutLength = nOutLength + nCharLength;
    }

    // Flush the invalid characters, if any
    nOutLength = UTF8_FlushInvalidChars(szBuffer, ccBuffer, nOutLength, InvalidChars, nInvalidChars);
    nInvalidChars = 0;

    // Terminate the string with zero, if we still have space
    if(szBuffer != NULL && nOutLength < ccBuffer)
        szBuffer[nOutLength] = 0;
    nOutLength++;

    // Give the output length, if required
    if(pOutLength != NULL)
        pOutLength[0] = nOutLength;
    return dwErrCode;
}

DWORD WINAPI SMemFileNameToUTF8(
    void * lpBuffer,                // Pointer to the output buffer. If NULL, the function will calculate the needed length
    size_t ccBuffer,                // Length of the output buffer (must include EOS)
    const TCHAR * szString,         // Pointer to the begin of the string
    const TCHAR * szStringEnd,      // Pointer to the end of string. If NULL, it's assumed to be zero-terminated
    DWORD /* dwFlags */,            // Additional flags
    size_t * pOutLength = NULL)     // Pointer to a variable that receives the needed length in bytes (optional)
{
    LPBYTE pbBuffer = (LPBYTE)lpBuffer;
    size_t nOutLength = 0;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Set the end of the input if not specified
    if(szStringEnd == NULL)
        szStringEnd = szString + _tcslen(szString);

    // Keep conversion as long
    while(szString < szStringEnd)
    {
        size_t ccCharsEaten = 0;
        size_t nUtf8Length;
        DWORD dwCodePoint = 0;
        BYTE Utf8Buffer[MAX_INVALID_CHARS];

        // Check for encoded sequence of bytes
        if(szString[0] == '%')
        {
            // If there is a single hexa number ("%c7"), decode that number
            if((szString + 3) <= szStringEnd)
            {
                TCHAR HexaString[3] = {0};

                HexaString[0] = szString[1];
                HexaString[1] = szString[2];
                if(SMemStrToBin(HexaString, Utf8Buffer, 1) == ERROR_SUCCESS)
                {
                    nOutLength = UTF8_FlushBinBuffer(pbBuffer, ccBuffer, nOutLength, Utf8Buffer, 1);
                    szString += 3;
                    continue;
                }
            }

            // If there is an escaped sequence ("%u[aabbcc]"), decode that sequence
            if((nUtf8Length = UTF16_IsEncodedCharSequence(szString, szStringEnd, Utf8Buffer)) != 0)
            {
                nOutLength = UTF8_FlushBinBuffer(pbBuffer, ccBuffer, nOutLength, Utf8Buffer, nUtf8Length);
                szString += (nUtf8Length * 2) + 4;
                continue;
            }
        }

#ifdef STORMLIB_WIDE_CHAR
        // Try to decode the code point from UTF-16
        if((dwErrCode = UTF16_DecodeCodePoint(szString, szStringEnd, dwCodePoint, ccCharsEaten)) != ERROR_SUCCESS)
            return dwErrCode;
#else
        // Try to decode the code point from UTF-16
        if((dwErrCode = UTF8_DecodeCodePoint((const BYTE *)szString, (const BYTE *)szStringEnd, dwCodePoint, ccCharsEaten)) != ERROR_SUCCESS)
            return dwErrCode;
#endif

        // Check whether the unicode char is not out of range
        assert(dwCodePoint <= SFILE_UNICODE_MAX);

        // Move the source pointer by the number of bytes eaten
        szString = szString + ccCharsEaten;

        // Encode the UNICODE char
        nUtf8Length = UTF8_EncodeCodePoint(dwCodePoint, Utf8Buffer);

        // Do we have enough space in the buffer?
        if(pbBuffer != NULL && (nOutLength + nUtf8Length) < ccBuffer)
        {
            // Write the encoded UTF-16 to the output
            memcpy(pbBuffer + nOutLength, Utf8Buffer, nUtf8Length);
        }

        // Increment the output length
        nOutLength = nOutLength + nUtf8Length;
    }

    // Terminate the string with zero, if we still have space
    if(pbBuffer != NULL && nOutLength < ccBuffer)
        pbBuffer[nOutLength] = 0;
    nOutLength++;

    // Give the output length, if required
    if(pOutLength != NULL)
        pOutLength[0] = nOutLength;
    return dwErrCode;
}

//-----------------------------------------------------------------------------
// (Set/Get)LastError wrapper

#ifndef STORMLIB_WINDOWS
#ifndef STORMLIB_WIIU
static thread_local DWORD dwLastError = ERROR_SUCCESS;
#else
static DWORD dwLastError = ERROR_SUCCESS;
#endif
#endif

void SErrSetLastError(DWORD dwErrCode)
{
#ifdef STORMLIB_WINDOWS
    SetLastError(dwErrCode);
#else
    dwLastError = dwErrCode;
#endif
}

DWORD SErrGetLastError()
{
#ifdef STORMLIB_WINDOWS
    return GetLastError();
#else
    return dwLastError;
#endif
}
