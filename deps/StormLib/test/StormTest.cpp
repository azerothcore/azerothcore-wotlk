/*****************************************************************************/
/* StormTest.cpp                          Copyright (c) Ladislav Zezula 2003 */
/*---------------------------------------------------------------------------*/
/* Test module for StormLib                                                  */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 25.03.03  1.00  Lad  The first version of StormTest.cpp                   */
/*****************************************************************************/

#define _CRT_NON_CONFORMING_SWPRINTFS
#define _CRT_SECURE_NO_DEPRECATE
#define __INCLUDE_CRYPTOGRAPHY__
#define __STORMLIB_SELF__                   // Don't use StormLib.lib
#include <stdio.h>
#include <vector>

#ifdef _MSC_VER
#include <crtdbg.h>
#endif

#include "../src/StormLib.h"
#include "../src/StormCommon.h"

#include "TLogHelper.cpp"                   // Helper class for showing test results

#ifdef _MSC_VER
#pragma warning(disable: 4505)              // 'XXX' : unreferenced local function has been removed
#include <crtdbg.h>
#pragma comment(lib, "winmm.lib")
#endif

#ifndef STORMLIB_WINDOWS
#include <dirent.h>
#include <alsa/asoundlib.h>                 // sudo apt-get install libasound2-dev
#endif

//------------------------------------------------------------------------------
// Local structures

#define ID_XHSC             0x58485343      // 'XHSC'

// Artificial error code for situations where we don't know the result
#define ERROR_UNDETERMINED_RESULT 0xC000FFFF

// Artificial flag for not reporting open failure
#define MPQ_OPEN_DONT_REPORT_FAILURE    0x80000000

// Size of SHA256, in bytes
#define SHA256_DIGEST_SIZE              0x20

typedef DWORD (*FS_SEARCH_CALLBACK)(LPCTSTR szFullPath, void * lpContext);

typedef enum _EXTRA_TYPE
{
    NoExtraType = 0,
    ListFile,
    Utf8File,
    TwoFiles,
    PatchList,
    HashValues,
} EXTRA_TYPE, *PEXTRA_TYPE;

typedef struct _FILE_DATA
{
    DWORD dwBlockIndex;
    DWORD dwFileSize;
    DWORD dwFlags;
    DWORD dwCrc32;
    BYTE FileData[1];
} FILE_DATA, *PFILE_DATA;

typedef struct _TEST_EXTRA_ONEFILE
{
    EXTRA_TYPE Type;                        // Must be ListFile
    LPCTSTR szFile;                         // The name of the (list)file
} TEST_EXTRA_ONEFILE, *PTEST_EXTRA_ONEFILE;

typedef struct _TEST_EXTRA_UTF8
{
    EXTRA_TYPE Type;                        // Must be Utf8File
    const BYTE * szMpqFile;                 // (UTF-8) The name of the MPQ file
    const BYTE * szListFile;                // (UTF-8) The name of the listfile
} TEST_EXTRA_UTF8, *PTEST_EXTRA_UTF8;

typedef struct _TEST_EXTRA_TWOFILES
{
    EXTRA_TYPE Type;                        // Must be TwoFiles
    LPCSTR  szFile1;                        // The first referenced file name
    LPCSTR  szFile2;                        // The second referenced file name
} TEST_EXTRA_TWOFILES, *PTEST_EXTRA_TWOFILES;

typedef struct _TEST_EXTRA_PATCHES
{
    EXTRA_TYPE Type;                        // Must be PatchList
    LPCTSTR szPatchList;                    // Multi-SZ list of patches
    LPCSTR szFileName;                      // Example of patched file
    DWORD dwPatchCount;                     // Number of patches
} TEST_EXTRA_PATCHES, *PTEST_EXTRA_PATCHES;

typedef struct _TEST_EXTRA_HASHVAL
{
    DWORD dwHash1;                          // Hash A of the file name
    DWORD dwHash2;                          // Hash B of the file name
    LPCSTR szFileName;                      // File name
} TEST_EXTRA_HASHVAL, *PTEST_EXTRA_HASHVAL;

typedef struct _TEST_EXTRA_HASHVALS
{
    EXTRA_TYPE Type;                        // Must be HashValues
    TEST_EXTRA_HASHVAL Items[2];
} TEST_EXTRA_HASHVALS, *PTEST_EXTRA_HASHVALS;

typedef struct _TEST_INFO1
{
    LPCTSTR szName1;                        // MPQ name
    LPCTSTR szName2;                        // ListFile name or NULL if none
    LPCSTR szDataHash;                      // Compound name+data hash
    DWORD  dwFlags;                         // Flags for testing the file. Low 16 bits contains number of files
    const void * pExtra;
} TEST_INFO1, *PTEST_INFO1;

typedef struct _TEST_INFO2
{
    LPCSTR szName1;                         // (UTF-8) MPQ name
    LPCSTR szName2;                         // (UTF-8) Added file name or NULL if none
    LPCSTR szDataHash;                      // Compound name+data hash
    DWORD  dwFlags;                         // Flags for testing the file. Low 16 bits contains number of files
    const void * pExtra;
} TEST_INFO2, *PTEST_INFO2;

typedef struct _LINE_INFO
{
    LONG  nLinePos;
    DWORD nLineLen;
    const char * szLine;
} LINE_INFO, *PLINE_INFO;

#define ID_WAVE_MAGIC1      0x46464952      // 'RIFF'
#define ID_WAVE_MAGIC2      0x45564157      // 'WAVE'
#define ID_WAVE_CHUNK_FMT   0x20746d66      // 'fmt '
#define ID_WAVE_CHUNK_DATA  0x61746164      // 'data'

typedef struct _WAVE_FILE_HEADER
{
    DWORD dwRiffSignature;                  // ID_WAVE_MAGIC1 ('RIFF')
    DWORD dwFileSize;
    DWORD dwTypeSignature;                  // ID_WAVE_MAGIC2 ('WAVE')
    DWORD dwChunkMarker;                    // ID_WAVE_CHUNK_FMT ('fmt\0')
    DWORD dwLength;                         // Length of the format chunk (16 bytes)
    USHORT wFormat;                         // 1 = PCM
    USHORT wChannels;                       // Number of channels
    DWORD dwSamplesPerSec;                  // Bitrate
    DWORD dwAvgSamplesPerSec;
    USHORT wBlockAlign;
    USHORT wBitsPerSample;
    DWORD dwDataSignature;                  // ID_WAVE_CHUNK_DATA ('data')
    DWORD dwDataSize;                       // Size of the data chunk
} WAVE_FILE_HEADER, *PWAVE_FILE_HEADER;

//------------------------------------------------------------------------------
// Local variables

#ifndef WORK_PATH_ROOT
  #ifdef STORMLIB_WINDOWS
  #define WORK_PATH_ROOT _T("\\Multimedia\\MPQs")
  #endif

  #ifdef STORMLIB_LINUX
  #define WORK_PATH_ROOT "/media/ladik/MPQs"
  #endif

  #ifdef STORMLIB_HAIKU
  #define WORK_PATH_ROOT "~/StormLib/test"
  #endif
#endif

// Definition of the path separator
#ifdef STORMLIB_WINDOWS
static LPCTSTR g_szPathSeparator = _T("\\");
static const TCHAR PATH_SEPARATOR = _T('\\');       // Path separator for Windows platforms
#else
static LPCSTR g_szPathSeparator = "/";
static const TCHAR PATH_SEPARATOR = '/';            // Path separator for Non-Windows platforms
#endif

// Global for the work MPQ
static LPCTSTR szMpqSubDir   = _T("1995 - Test MPQs");
static TCHAR szDataFileDir[MAX_PATH] = {0};
static TCHAR szListFileDir[MAX_PATH] = {0};
static TCHAR szMpqPatchDir[MAX_PATH] = {0};

//-----------------------------------------------------------------------------
// Testing data

// Flags for TestOpenArchive
#define TFLG_VALUE_MASK         0x000FFFFF              // Mask for file count
#define TFLG_READ_ONLY          0x00100000              // Open the archive read-only
#define TFLG_SIGCHECK_BEFORE    0x00200000              // Verify signature before modification
#define TFLG_MODIFY             0x00400000              // Modify the archive
#define TFLG_SIGN_ARCHIVE       0x00800000              // Sign an archive that is not signed
#define TFLG_SIGCHECK_AFTER     0x01000000              // Verify signature after modification
#define TFLG_GET_FILE_INFO      0x02000000              // Test the GetFileInfo function
#define TFLG_ADD_USER_DATA      0x04000000              // Add user data during MPQ copying
#define TFLG_HAS_LISTFILE       0x08000000              // The MPQ must have (listfile)
#define TFLG_HAS_ATTRIBUTES     0x10000000              // The MPQ must have (attributes)
#define TFLG_BIGFILE            0x20000000              // Add a big file to the MPQ
#define TFLG_COMPACT            0x40000000              // Perform archive compacting between two opens
#define TFLG_WILL_FAIL          0x80000000              // The process is expected to fail

// Flags for TestCreateArchive
#define CFLG_V2                 0x00010000              // Create archive version 2
#define CFLG_V4                 0x00020000              // Create archive version 4
#define CFLG_EMPTY              0x00040000              // The archive will be empty
#define CFLG_NONSTD_NAMES       0x00080000              // Create archive containing non-standard names
#define CFLG_MPQEDITOR          0x00100000              // Create archive like MPQEditor would do

// Flags for TestOpenArchive_SignatureTest
#define SFLAG_VERIFY_BEFORE     0x00000001              // Verify signature before modification
#define SFLAG_CREATE_ARCHIVE    0x00000002              // Create new archive
#define SFLAG_MODIFY_ARCHIVE    0x00000004              // Modify the archive before signing
#define SFLAG_SIGN_AT_CREATE    0x00000008              // Sign the archive at the creation
#define SFLAG_SIGN_ARCHIVE      0x00000010              // Sign the archive
#define SFLAG_VERIFY_AFTER      0x00000020              // Verify the signature after modification

static DWORD AddFlags[] =
{
//  Compression          Encryption             Fixed key           Single Unit            Sector CRC
    0                 |  0                   |  0                 | 0                    | 0,
    0                 |  MPQ_FILE_ENCRYPTED  |  0                 | 0                    | 0,
    0                 |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | 0                    | 0,
    0                 |  0                   |  0                 | MPQ_FILE_SINGLE_UNIT | 0,
    0                 |  MPQ_FILE_ENCRYPTED  |  0                 | MPQ_FILE_SINGLE_UNIT | 0,
    0                 |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | MPQ_FILE_SINGLE_UNIT | 0,
    MPQ_FILE_IMPLODE  |  0                   |  0                 | 0                    | 0,
    MPQ_FILE_IMPLODE  |  MPQ_FILE_ENCRYPTED  |  0                 | 0                    | 0,
    MPQ_FILE_IMPLODE  |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | 0                    | 0,
    MPQ_FILE_IMPLODE  |  0                   |  0                 | MPQ_FILE_SINGLE_UNIT | 0,
    MPQ_FILE_IMPLODE  |  MPQ_FILE_ENCRYPTED  |  0                 | MPQ_FILE_SINGLE_UNIT | 0,
    MPQ_FILE_IMPLODE  |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | MPQ_FILE_SINGLE_UNIT | 0,
    MPQ_FILE_IMPLODE  |  0                   |  0                 | 0                    | MPQ_FILE_SECTOR_CRC,
    MPQ_FILE_IMPLODE  |  MPQ_FILE_ENCRYPTED  |  0                 | 0                    | MPQ_FILE_SECTOR_CRC,
    MPQ_FILE_IMPLODE  |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | 0                    | MPQ_FILE_SECTOR_CRC,
    MPQ_FILE_COMPRESS |  0                   |  0                 | 0                    | 0,
    MPQ_FILE_COMPRESS |  MPQ_FILE_ENCRYPTED  |  0                 | 0                    | 0,
    MPQ_FILE_COMPRESS |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | 0                    | 0,
    MPQ_FILE_COMPRESS |  0                   |  0                 | MPQ_FILE_SINGLE_UNIT | 0,
    MPQ_FILE_COMPRESS |  MPQ_FILE_ENCRYPTED  |  0                 | MPQ_FILE_SINGLE_UNIT | 0,
    MPQ_FILE_COMPRESS |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | MPQ_FILE_SINGLE_UNIT | 0,
    MPQ_FILE_COMPRESS |  0                   |  0                 | 0                    | MPQ_FILE_SECTOR_CRC,
    MPQ_FILE_COMPRESS |  MPQ_FILE_ENCRYPTED  |  0                 | 0                    | MPQ_FILE_SECTOR_CRC,
    MPQ_FILE_COMPRESS |  MPQ_FILE_ENCRYPTED  |  MPQ_FILE_KEY_V2   | 0                    | MPQ_FILE_SECTOR_CRC,
    0xFFFFFFFF
};

static DWORD WaveCompressions[] =
{
    MPQ_COMPRESSION_ADPCM_MONO | MPQ_COMPRESSION_HUFFMANN,
    MPQ_COMPRESSION_ADPCM_STEREO | MPQ_COMPRESSION_HUFFMANN,
    MPQ_COMPRESSION_PKWARE,
    MPQ_COMPRESSION_ZLIB,
    MPQ_COMPRESSION_BZIP2
};

static const BYTE szPlainName_CZE[] = {                                                      0xc4, 0x8c, 0x65, 0x73, 0x6b, 0xc3, 0xbd, 0x2e, 0x6d, 0x70, 0x71, 0x00};   // (UTF-8) Czech
static const BYTE szPlainName_RUS[] = {            0xd0, 0xa0, 0xd1, 0x83, 0xd1, 0x81, 0xd1, 0x81, 0xd0, 0xba, 0xd0, 0xb8, 0xd0, 0xb9, 0x2e, 0x6d, 0x70, 0x71, 0x00};   // (UTF-8) Russian
static const BYTE szPlainName_GRC[] = {0xce, 0xb5, 0xce, 0xbb, 0xce, 0xbb, 0xce, 0xb7, 0xce, 0xbd, 0xce, 0xb9, 0xce, 0xba, 0xce, 0xac, 0x2e, 0x6d, 0x70, 0x71, 0x00};   // (UTF-8) Greek
static const BYTE szPlainName_CHN[] = {                                          0xe6, 0x97, 0xa5, 0xe6, 0x9c, 0xac, 0xe8, 0xaa, 0x9e, 0x2e, 0x6d, 0x70, 0x71, 0x00};   // (UTF-8) Chinese
static const BYTE szPlainName_JPN[] = {                        0xe7, 0xae, 0x80, 0xe4, 0xbd, 0x93, 0xe4, 0xb8, 0xad, 0xe6, 0x96, 0x87, 0x2e, 0x6d, 0x70, 0x71, 0x00};   // (UTF-8) Japanese
static const BYTE szPlainName_SAU[] = {0xd8, 0xa7, 0xd9, 0x84, 0xd8, 0xb9, 0xd8, 0xb9, 0xd8, 0xb1, 0xd8, 0xa8, 0xd9, 0x8a, 0xd8, 0xa9, 0x2e, 0x6d, 0x70, 0x71, 0x00};   // (UTF-8) Arabic

static SFILE_MARKERS MpqMarkers[] =
{
    {sizeof(SFILE_MARKERS), ID_MPQ,  "(hash table)", "(block table)"},
    {sizeof(SFILE_MARKERS), ID_XHSC, "(cash table)", "(clock table)"}
};

//-----------------------------------------------------------------------------
// Local file functions

// This must be the directory where our test MPQs are stored.
// We also expect a subdirectory named
static TCHAR szMpqDirectory[MAX_PATH+1];
size_t cchMpqDirectory = 0;

inline bool AssertTrue(bool bCondition)
{
    if(!bCondition)
    {
#ifdef STORMLIB_WINDOWS
        __debugbreak();
#else
        assert(false);
#endif        
    }
    return bCondition;
}

#define ASSERT_TRUE(condition)      { if(!AssertTrue(condition)) { return false; } }

static EXTRA_TYPE GetExtraType(const void * pExtra)
{
    if(pExtra != NULL)
    {
        return *(PEXTRA_TYPE)(pExtra);
    }
    else
    {
        return NoExtraType;
    }
}

LPCTSTR SwapMpqName(LPTSTR szBuffer, size_t ccBuffer, LPCTSTR szMpqName, PTEST_EXTRA_UTF8 pExtra)
{
    if((pExtra != NULL) && (pExtra->Type == Utf8File))
    {
        StringCopy(szBuffer, ccBuffer, (LPCSTR)(pExtra->szMpqFile));
        return szBuffer;
    }
    else
    {
        return szMpqName;
    }
}

template <typename XCHAR>
static bool IsFullPath(const XCHAR * szFileName)
{
#ifdef STORMLIB_WINDOWS
    if(('A' <= szFileName[0] && szFileName[0] <= 'Z') || ('a' <= szFileName[0] && szFileName[0] <= 'z'))
    {
        return (szFileName[1] == ':' && szFileName[2] == PATH_SEPARATOR);
    }
#endif

    szFileName = szFileName;
    return false;
}

LPCTSTR GetRelativePath(LPCTSTR szFullPath)
{
    LPCTSTR szRelativePath;

    if(szFullPath && szFullPath[0])
    {
        if((szRelativePath = _tcsstr(szFullPath, szMpqSubDir)) != NULL)
        {
            return szRelativePath;
        }
    }
    return _T("");
}

const char * GetFileText(PFILE_DATA pFileData)
{
    const char * szFileText = (const char *)(pFileData->FileData);

    // Skip UTF-8 marker
    if(pFileData->dwFileSize > 3 && !memcmp(szFileText, "\xEF\xBB\xBF", 3))
        szFileText += 3;
    return szFileText;
}

#ifdef STORMLIB_LINUX
static void alsa_silent_error_handler(const char * file, int line, const char * function, int err, const char * fmt, ...)
{
    // Suppress ALSA error output, so do nothing
}
#endif

static void PlayWaveSound(PFILE_DATA pFileData)
{
#ifdef STORMLIB_WINDOWS
    PlaySound((LPCTSTR)pFileData->FileData, NULL, SND_MEMORY);
#endif    

#ifdef STORMLIB_LINUX
    PWAVE_FILE_HEADER pWaveHeader = (PWAVE_FILE_HEADER)pFileData->FileData;
    snd_pcm_hw_params_t *params;
    snd_pcm_t *pcm_handle;

    // Suppress ALSA error printing
    snd_lib_error_set_handler(alsa_silent_error_handler);

    // Validate the WAVE file header
    if(pFileData->dwFileSize >= sizeof(WAVE_FILE_HEADER) && pWaveHeader->dwRiffSignature == ID_WAVE_MAGIC1 && pWaveHeader->dwTypeSignature == ID_WAVE_MAGIC2)
    {
        // Require a standard 16-byte PCM fmt chunk followed by a data chunk
        if(pWaveHeader->dwChunkMarker == ID_WAVE_CHUNK_FMT && pWaveHeader->dwLength == 16 &&
           pWaveHeader->wFormat == 1 && pWaveHeader->dwDataSignature == ID_WAVE_CHUNK_DATA)
        {
            // Guard against a bogus dwDataSize that would read past the buffer
            if(pWaveHeader->wBlockAlign != 0 && (DWORD)(sizeof(WAVE_FILE_HEADER) + pWaveHeader->dwDataSize) <= pFileData->dwFileSize)
            {
                // Open the default sound device and play the sound
                if(snd_pcm_open(&pcm_handle, "default", SND_PCM_STREAM_PLAYBACK, 0) >= 0)
                {
                    // WAV 8-bit samples are unsigned (0-255); 16-bit samples are signed little-endian
                    snd_pcm_format_t format = (pWaveHeader->wBitsPerSample == 16) ? SND_PCM_FORMAT_S16_LE : SND_PCM_FORMAT_U8;
                    unsigned int rate = pWaveHeader->dwSamplesPerSec;
                    snd_pcm_sframes_t nWritten;

                    snd_pcm_hw_params_alloca(&params);
                    snd_pcm_hw_params_any(pcm_handle, params);
                    snd_pcm_hw_params_set_access(pcm_handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
                    snd_pcm_hw_params_set_format(pcm_handle, params, format);
                    snd_pcm_hw_params_set_channels(pcm_handle, params, pWaveHeader->wChannels);
                    snd_pcm_hw_params_set_rate_near(pcm_handle, params, &rate, 0);
                    snd_pcm_hw_params(pcm_handle, params);

                    snd_pcm_uframes_t nFrames = pWaveHeader->dwDataSize / pWaveHeader->wBlockAlign;
                    nWritten = snd_pcm_writei(pcm_handle, (pWaveHeader + 1), nFrames);
                    if(nWritten == -EPIPE)
                    {
                        snd_pcm_recover(pcm_handle, (int)nWritten, 1);
                        snd_pcm_writei(pcm_handle, (pWaveHeader + 1), nFrames);
                    }
                    snd_pcm_drain(pcm_handle);
                    snd_pcm_close(pcm_handle);
                }
            }
        }
    }
#endif
}

static bool CompareBlocks(LPBYTE pbBlock1, LPBYTE pbBlock2, DWORD dwLength, DWORD * pdwDifference)
{
    for(DWORD i = 0; i < dwLength; i++)
    {
        if(pbBlock1[i] != pbBlock2[i])
        {
            pdwDifference[0] = i;
            return false;
        }
    }

    return true;
}

static DWORD CompareTwoFiles(TLogHelper & Logger, PFILE_DATA pFileData1, PFILE_DATA pFileData2)
{
    DWORD dwDifference = 0;

    // Compare the file sizes
    if(pFileData1->dwFileSize != pFileData2->dwFileSize)
    {
        Logger.PrintMessage("File size mismatch: %u vs %u", pFileData1->dwFileSize, pFileData2->dwFileSize);
        return ERROR_FILE_CORRUPT;
    }

    // Compare the file data
    if(memcmp(pFileData1->FileData, pFileData2->FileData, pFileData1->dwFileSize))
    {
        CompareBlocks(pFileData1->FileData, pFileData2->FileData, pFileData1->dwFileSize, &dwDifference);
        Logger.PrintMessage("File data mismatch at offset %08x", dwDifference);
        return ERROR_FILE_CORRUPT;
    }

    return ERROR_SUCCESS;
}

template <typename XCHAR>
static const XCHAR * FindNextPathPart(const XCHAR * szPath, size_t nPartCount)
{
    const XCHAR * szPathPart = szPath;

    while(szPath[0] != 0 && nPartCount > 0)
    {
        // Is there path separator?
        if(szPath[0] == '\\' || szPath[0] == '/')
        {
            szPathPart = szPath + 1;
            nPartCount--;
        }

        // Move to the next letter
        szPath++;
    }

    return szPathPart;
}

template <typename XCHAR>
size_t StringLength(const XCHAR * szString)
{
    size_t nLength;

    for(nLength = 0; szString[nLength] != 0; nLength++);

    return nLength;
}

template <typename XCHAR>
static const XCHAR * GetShortPlainName(const XCHAR * szFileName)
{
    const XCHAR * szPlainName = FindNextPathPart(szFileName, 1000);
    const XCHAR * szPlainEnd = szFileName + StringLength(szFileName);

    // If the name is still too long, cut it
    if((szPlainEnd - szPlainName) > 50)
        szPlainName = szPlainEnd - 50;

    return szPlainName;
}

static size_t ConvertSha256ToText(const unsigned char * sha_digest, LPTSTR szBuffer)
{
    LPCSTR szTable = "0123456789abcdef";

    for(size_t i = 0; i < SHA256_DIGEST_SIZE; i++)
    {
        *szBuffer++ = szTable[(sha_digest[0] >> 0x04)];
        *szBuffer++ = szTable[(sha_digest[0] & 0x0F)];
        sha_digest++;
    }

    *szBuffer = 0;
    return (SHA256_DIGEST_SIZE * 2);
}

static void CreateFullPathName(TCHAR * szBuffer, size_t cchBuffer, LPCTSTR szSubDir, LPCTSTR szNamePart1, LPCTSTR szNamePart2 = NULL)
{
    TCHAR * szSaveBuffer = szBuffer;
    size_t nPrefixLength = 0;
    size_t nLength;
    DWORD dwProvider = 0;
    bool bIsFullPath = false;
    char chSeparator = PATH_SEPARATOR;

    // Pre-initialize the buffer
    szBuffer[0] = 0;

    // Determine the path prefix
    if(szNamePart1 != NULL)
    {
        nPrefixLength = FileStream_Prefix(szNamePart1, &dwProvider);
        if((dwProvider & BASE_PROVIDER_MASK) == BASE_PROVIDER_HTTP)
        {
            bIsFullPath = true;
            chSeparator = '/';
        }
        else
            bIsFullPath = IsFullPath(szNamePart1 + nPrefixLength);
    }

    // Copy the MPQ prefix, if any
    if(nPrefixLength > 0)
    {
        StringCat(szBuffer, cchBuffer, szNamePart1);
        szBuffer[nPrefixLength] = 0;
        szSaveBuffer += nPrefixLength;
        szNamePart1 += nPrefixLength;
    }

    // If the given name is not a full path, copy the MPQ directory
    if(bIsFullPath == false)
    {
        // Copy the master MPQ directory
        StringCat(szBuffer, cchBuffer, szMpqDirectory);

        // Append the subdirectory, if any
        if(szSubDir != NULL && (nLength = _tcslen(szSubDir)) != 0)
        {
            // No leading or trailing separator are allowed
            assert(szSubDir[0] != '/' && szSubDir[0] != '\\');
            assert(szSubDir[nLength - 1] != '/' && szSubDir[nLength - 1] != '\\');

            // Append the subdirectory
            StringCat(szBuffer, cchBuffer, g_szPathSeparator);
            StringCat(szBuffer, cchBuffer, szSubDir);
        }
    }

    // Copy the file name, if any
    if(szNamePart1 != NULL && (nLength = _tcslen(szNamePart1)) != 0)
    {
        // Path separators are not allowed in the name part
        assert(szNamePart1[0] != '\\' && szNamePart1[0] != '/');
        assert(szNamePart1[nLength - 1] != '/' && szNamePart1[nLength - 1] != '\\');

        // Append file path separator and the name part
        if(bIsFullPath == false)
            StringCat(szBuffer, cchBuffer, g_szPathSeparator);
        StringCat(szBuffer, cchBuffer, szNamePart1);
    }

    // Append the second part of the name
    if(szNamePart2 != NULL && (nLength = _tcslen(szNamePart2)) != 0)
    {
        // Copy the file name
        StringCat(szBuffer, cchBuffer, szNamePart2);
    }

    // Normalize the path separators
    for(; szSaveBuffer[0] != 0; szSaveBuffer++)
    {
        szSaveBuffer[0] = (szSaveBuffer[0] != '/' && szSaveBuffer[0] != '\\') ? szSaveBuffer[0] : chSeparator;
    }
}

#ifdef _UNICODE
static void CreateFullPathName(char * szBuffer, size_t cchBuffer, LPCTSTR szSubDir, LPCTSTR szNamePart1, LPCTSTR szNamePart2 = NULL)
{
    TCHAR szFullPathT[MAX_PATH];

    CreateFullPathName(szFullPathT, _countof(szFullPathT), szSubDir, szNamePart1, szNamePart2);
    StringCopy(szBuffer, cchBuffer, szFullPathT);
}
#endif

static DWORD CalculateFileHash(TLogHelper * pLogger, LPCTSTR szFullPath, LPTSTR szFileHash)
{
    TFileStream * pStream;
    hash_state sha256_ctx;
    ULONGLONG ByteOffset = 0;
    ULONGLONG FileSize = 0;
    LPCTSTR szShortPlainName = GetShortPlainName(szFullPath);
    LPCTSTR szHashingFormat = _T("Hashing %s ") fmt_X_of_Y_t;
    LPBYTE pbFileBlock;
    DWORD cbBytesToRead;
    DWORD cbFileBlock = 0x100000;
    DWORD dwErrCode = ERROR_SUCCESS;
    BYTE file_hash[SHA256_DIGEST_SIZE];

    // Notify the user
    pLogger->PrintProgress(_T("Hashing %s ..."), szShortPlainName);
    szFileHash[0] = 0;

    // Open the file to be verified
    pStream = FileStream_OpenFile(szFullPath, STREAM_FLAG_READ_ONLY);
    if(pStream != NULL)
    {
        // Retrieve the size of the file
        FileStream_GetSize(pStream, &FileSize);

        // Allocate the buffer for loading file parts
        pbFileBlock = STORM_ALLOC(BYTE, cbFileBlock);
        if(pbFileBlock != NULL)
        {
            // Initialize SHA256 calculation
            sha256_init(&sha256_ctx);

            // Calculate the SHA256 of the file
            while(ByteOffset < FileSize)
            {
                // Notify the user
                pLogger->PrintProgress(szHashingFormat, szShortPlainName, ByteOffset, FileSize);

                // Load the file block
                cbBytesToRead = ((FileSize - ByteOffset) > cbFileBlock) ? cbFileBlock : (DWORD)(FileSize - ByteOffset);
                if(!FileStream_Read(pStream, &ByteOffset, pbFileBlock, cbBytesToRead))
                {
                    dwErrCode = SErrGetLastError();
                    break;
                }

                // Add to SHA256
                sha256_process(&sha256_ctx, pbFileBlock, cbBytesToRead);
                ByteOffset += cbBytesToRead;
            }

            // Notify the user
            pLogger->PrintProgress(szHashingFormat, szShortPlainName, ByteOffset, FileSize);

            // Finalize SHA256
            sha256_done(&sha256_ctx, file_hash);

            // Convert the SHA256 to ANSI text
            ConvertSha256ToText(file_hash, szFileHash);
            STORM_FREE(pbFileBlock);
        }

        FileStream_Close(pStream);
    }

    // If we calculated something, return OK
    if(dwErrCode == ERROR_SUCCESS && szFileHash[0] == 0)
        dwErrCode = ERROR_CAN_NOT_COMPLETE;
    return dwErrCode;
}

//-----------------------------------------------------------------------------
// Directory search

static HANDLE InitDirectorySearch(LPCTSTR szDirectory)
{
#ifdef STORMLIB_WINDOWS

    WIN32_FIND_DATA wf;
    HANDLE hFind;
    TCHAR szSearchMask[MAX_PATH];

    // Construct the directory mask
    _stprintf(szSearchMask, _T("%s\\*"), szDirectory);

    // Perform the search
    hFind = FindFirstFile(szSearchMask, &wf);
    return (hFind != INVALID_HANDLE_VALUE) ? hFind : NULL;

#endif

#if defined(STORMLIB_LINUX) || defined(STORMLIB_MAC)

    // Open the directory
    return (HANDLE)opendir(szDirectory);

#endif
}

static bool SearchDirectory(HANDLE hFind, LPTSTR szDirEntry, size_t cchDirEntry, bool & IsDirectory)
{
#ifdef STORMLIB_WINDOWS

    WIN32_FIND_DATA wf;

    // Search for the hnext entry.
    if(FindNextFile(hFind, &wf))
    {
        IsDirectory = (wf.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) ? true : false;
        StringCopy(szDirEntry, cchDirEntry, wf.cFileName);
        return true;
    }

    return false;

#endif

#if defined(STORMLIB_LINUX) || defined(STORMLIB_MAC)

    struct dirent * directory_entry;

    directory_entry = readdir((DIR *)hFind);
    if(directory_entry != NULL)
    {
        IsDirectory = (directory_entry->d_type == DT_DIR) ? true : false;
        strcpy(szDirEntry, directory_entry->d_name);
        return true;
    }

    return false;

#endif
}

static void FreeDirectorySearch(HANDLE hFind)
{
#ifdef STORMLIB_WINDOWS
    FindClose(hFind);
#endif

#if defined(STORMLIB_LINUX) || defined(STORMLIB_MAC)
    closedir((DIR *)hFind);
#endif
}

static PFILE_DATA LoadLocalFile(TLogHelper * pLogger, LPCTSTR szFileName, bool bMustSucceed)
{
    TFileStream * pStream;
    PFILE_DATA pFileData = NULL;
    ULONGLONG FileSize = 0;
    size_t nAllocateBytes;

    // Notify the user
    if(pLogger != NULL)
        pLogger->PrintProgress(_T("Loading %s ..."), GetPlainFileName(szFileName));

    // Attempt to open the file
    if((pStream = FileStream_OpenFile(szFileName, STREAM_FLAG_READ_ONLY)) != NULL)
    {
        // Get the file size
        FileStream_GetSize(pStream, &FileSize);

        // Check for too big files
        if((FileSize >> 0x20) == 0)
        {
            // Allocate space for the file
            nAllocateBytes = sizeof(FILE_DATA) + (size_t)FileSize;
            pFileData = (PFILE_DATA)STORM_ALLOC(BYTE, nAllocateBytes);
            if(pFileData != NULL)
            {
                // Make sure it;s properly zeroed
                memset(pFileData, 0, nAllocateBytes);
                pFileData->dwFileSize = (DWORD)FileSize;

                // Load to memory
                if(!FileStream_Read(pStream, NULL, pFileData->FileData, pFileData->dwFileSize))
                {
                    STORM_FREE(pFileData);
                    pFileData = NULL;
                }
            }
        }

        // Close the stream
        FileStream_Close(pStream);
    }
    else
    {
        if(pLogger != NULL && bMustSucceed == true)
            pLogger->PrintError(_T("Open failed: %s"), szFileName);
    }
    
    // Return the loaded file data or NULL
    return pFileData;
}

static DWORD FindFilesInternal(FS_SEARCH_CALLBACK PfnFolderCallback, FS_SEARCH_CALLBACK PfnFileCallback, LPTSTR szDirectory, void * lpContext = NULL)
{
    LPTSTR szPlainName;
    HANDLE hFind;
    size_t nLength;
    TCHAR szDirEntry[MAX_PATH];
    bool IsDirectory = false;
    DWORD dwErrCode = ERROR_SUCCESS;

    if(szDirectory != NULL)
    {
        // Initiate directory search
        hFind = InitDirectorySearch(szDirectory);
        if(hFind != NULL)
        {
            // Append slash at the end of the directory name
            nLength = _tcslen(szDirectory);
            szDirectory[nLength++] = PATH_SEPARATOR;
            szPlainName = szDirectory + nLength;

            // Skip the first entry, since it's always "." or ".."
            while(SearchDirectory(hFind, szDirEntry, _countof(szDirEntry), IsDirectory) && dwErrCode == ERROR_SUCCESS)
            {
                // Copy the directory entry name to both names
                _tcscpy(szPlainName, szDirEntry);

                // Found a directory?
                if(IsDirectory)
                {
                    if(szDirEntry[0] != '.')
                    {
                        if(PfnFolderCallback != NULL)
                            PfnFolderCallback(szDirectory, lpContext);
                        dwErrCode = FindFilesInternal(PfnFolderCallback, PfnFileCallback, szDirectory, lpContext);
                    }
                }
                else
                {
                    if(PfnFileCallback != NULL)
                    {
                        dwErrCode = PfnFileCallback(szDirectory, lpContext);
                    }
                }
            }

            FreeDirectorySearch(hFind);
        }
    }

    // Free the path buffer, if any
    return dwErrCode;
}

static DWORD ForEachFile_VerifyFileHash(LPCTSTR szFullPath, void * lpContext)
{
    TLogHelper * pLogger = (TLogHelper *)(lpContext);
    PFILE_DATA pFileData;
    LPCTSTR szHashExtension = _T(".sha256");
    LPTSTR szExtension;
    TCHAR szShaFileName[MAX_PATH + 1];
    TCHAR szHashText[0x80];
    char szHashTextA[0x80];
    DWORD dwErrCode = ERROR_SUCCESS;

    // Try to load the file with the SHA extension
    StringCopy(szShaFileName, _countof(szShaFileName), szFullPath);
    szExtension = _tcsrchr(szShaFileName, '.');
    if(szExtension == NULL)
        return ERROR_SUCCESS;

    // Skip .sha and .sha256 files
    if(!_tcsicmp(szExtension, _T(".txt")) || !_tcsicmp(szExtension, _T(".sha")) || !_tcsicmp(szExtension, szHashExtension))
        return ERROR_SUCCESS;

    // Load the local file to memory
    _tcscpy(szExtension, szHashExtension);
    pFileData = LoadLocalFile(pLogger, szShaFileName, false);
    if(pFileData != NULL)
    {
        // Calculate SHA256 of the entire file
        dwErrCode = CalculateFileHash(pLogger, szFullPath, szHashText);
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Compare with what we loaded from the file
            if(pFileData->dwFileSize >= (SHA256_DIGEST_SIZE * 2))
            {
                // Compare the SHA256
                StringCopy(szHashTextA, _countof(szHashTextA), szHashText);
                if(_strnicmp(szHashTextA, GetFileText(pFileData), (SHA256_DIGEST_SIZE * 2)))
                {
                    SErrSetLastError(dwErrCode = ERROR_FILE_CORRUPT);
                    pLogger->PrintError(_T("File hash check failed: %s"), szFullPath);
                }
            }
        }

        // Clear the line
        if(dwErrCode == ERROR_SUCCESS)
            pLogger->PrintProgress("OK");
        STORM_FREE(pFileData);
    }
    return dwErrCode;
}

// Verify SHA256 of each MPQ that we have in the collection
static DWORD VerifyFileHashes(LPCTSTR szSubDirectory)
{
    TLogHelper Logger("TestVerifyHash");
    TCHAR szWorkBuff[MAX_PATH];

    // Construct the full directory name
    CreateFullPathName(szWorkBuff, _countof(szWorkBuff), szSubDirectory, NULL);

    // Find each file and check its hash
    return FindFilesInternal(NULL, ForEachFile_VerifyFileHash, szWorkBuff, &Logger);
}

static DWORD FindListFileFolder(LPCTSTR szFullPath, void * /* lpContext */)
{
    LPCTSTR szPlainName = GetPlainFileName(szFullPath);

    // Check data file dir
    if(szDataFileDir[0] == 0)
    {
        if(!_tcsnicmp(szPlainName, _T("addfiles-"), 9))
        {
            StringCopy(szDataFileDir, _countof(szDataFileDir), GetRelativePath(szFullPath));
            return ERROR_SUCCESS;
        }
    }

    // Check listfile directory
    if(szListFileDir[0] == 0)
    {
        if(!_tcsnicmp(szPlainName, _T("listfiles-"), 10))
        {
            StringCopy(szListFileDir, _countof(szListFileDir), GetRelativePath(szFullPath));
            return ERROR_SUCCESS;
        }
    }

    if(szMpqPatchDir[0] == 0)
    {
        if(!_tcsnicmp(szPlainName, _T("patches-"), 8))
        {
            StringCopy(szMpqPatchDir, _countof(szMpqPatchDir), GetRelativePath(szFullPath));
            return ERROR_SUCCESS;
        }
    }

    // Check patch directory
    return ERROR_SUCCESS;
}

static DWORD InitializeMpqDirectory(TCHAR * argv[], int argc)
{
    TLogHelper Logger("InitWorkFolder");
    TFileStream * pStream;
    TCHAR szFullPath[MAX_PATH] = {0};
    LPCTSTR szWhereFrom = _T("default");
    LPCTSTR szDirName = WORK_PATH_ROOT;

    // Make sure SHA256 works in test program
    register_hash(&sha256_desc);

    // Retrieve the first argument
    if(argc > 1 && argv[1] != NULL)
    {
        // Check if it's a directory
        pStream = FileStream_OpenFile(argv[1], STREAM_FLAG_READ_ONLY);
        if(pStream == NULL)
        {
            szWhereFrom = _T("command line");
            szDirName = argv[1];
        }
        else
        {
            FileStream_Close(pStream);
        }
    }

    // Copy the name of the MPQ directory.
    StringCopy(szMpqDirectory, _countof(szMpqDirectory), szDirName);
    cchMpqDirectory = _tcslen(szMpqDirectory);

    // Cut trailing slashes and/or backslashes
    while((cchMpqDirectory > 0) && (szMpqDirectory[cchMpqDirectory - 1] == '/' || szMpqDirectory[cchMpqDirectory - 1] == '\\'))
        cchMpqDirectory--;
    szMpqDirectory[cchMpqDirectory] = 0;

    // Print the work directory info
    Logger.PrintMessage(_T("Work directory %s (%s)"), szMpqDirectory, szWhereFrom);

    // Find the listfile directory within the MPQ directory
    CreateFullPathName(szFullPath, _countof(szFullPath), NULL, szMpqSubDir);
    FindFilesInternal(FindListFileFolder, NULL, szFullPath, NULL);
    if(szDataFileDir[0] == 0)
        return Logger.PrintError(_T("Data files folder was not found in the MPQ directory"));
    if(szListFileDir[0] == 0)
        return Logger.PrintError(_T("Listfile folder was not found in the MPQ directory"));
    if(szMpqPatchDir[0] == 0)
        return Logger.PrintError(_T("Patches folder was not found in the MPQ directory"));

    // Verify if the work MPQ directory is writable
    CreateFullPathName(szFullPath, _countof(szFullPath), szMpqSubDir, _T("new-file.bin"));
    pStream = FileStream_CreateFile(szFullPath, 0);
    if(pStream == NULL)
        return Logger.PrintError(_T("MPQ subdirectory doesn't exist or is not writable"));

    // Close the stream
    FileStream_Close(pStream);
    _tremove(szFullPath);

    // Verify if the working directory exists and if there is a subdirectory with the file name
    CreateFullPathName(szFullPath, _countof(szFullPath), szListFileDir, _T("ListFile_Blizzard.txt"));
    pStream = FileStream_OpenFile(szFullPath, STREAM_FLAG_READ_ONLY);
    if(pStream == NULL)
        return Logger.PrintError(_T("The main listfile (%s) was not found. Check your paths"), GetShortPlainName(szFullPath));

    // Close the stream
    FileStream_Close(pStream);
    return ERROR_SUCCESS;
}

static DWORD GetFilePatchCount(TLogHelper * pLogger, HANDLE hMpq, LPCSTR szFileName)
{
    TCHAR * szPatchName;
    HANDLE hFile;
    TCHAR szPatchChain[0x400];
    DWORD dwErrCode = ERROR_SUCCESS;
    int nPatchCount = 0;

    // Open the MPQ file
    if(SFileOpenFileEx(hMpq, szFileName, 0, &hFile))
    {
        // Notify the user
        pLogger->PrintProgress("Verifying patch chain for %s ...", GetShortPlainName(szFileName));

        // Query the patch chain
        if(!SFileGetFileInfo(hFile, SFileInfoPatchChain, szPatchChain, sizeof(szPatchChain), NULL))
            dwErrCode = pLogger->PrintError("Failed to retrieve the patch chain on %s", szFileName);

        // Is there anything at all in the patch chain?
        if(dwErrCode == ERROR_SUCCESS && szPatchChain[0] == 0)
        {
            pLogger->PrintError("The patch chain for %s is empty", szFileName);
            dwErrCode = ERROR_FILE_CORRUPT;
        }

        // Now calculate the number of patches
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Get the pointer to the patch
            szPatchName = szPatchChain;

            // Skip the base name
            for(;;)
            {
                // Skip the current name
                szPatchName = szPatchName + _tcslen(szPatchName) + 1;
                if(szPatchName[0] == 0)
                    break;

                // Increment number of patches
                nPatchCount++;
            }
        }

        SFileCloseFile(hFile);
    }
    else
    {
        if(SErrGetLastError() != ERROR_FILE_DELETED)
        {
            pLogger->PrintError("Open failed: %s", szFileName);
        }
    }

    return nPatchCount;
}

static DWORD SetLocaleForFileOperations(HANDLE hMpq, LPCSTR szFileName, LCID lcLocale)
{
    HANDLE hFile = NULL;
    DWORD dwErrCode = ERROR_SUCCESS;

    if(SFileOpenFileEx(hMpq, szFileName, 0, &hFile))
    {
        if(!SFileSetFileLocale(hFile, lcLocale))
            dwErrCode = SErrGetLastError();
        SFileSetLocale(lcLocale);
        SFileCloseFile(hFile);
    }
    else
    {
        dwErrCode = SErrGetLastError();
    }
    return dwErrCode;
}

static DWORD VerifyFilePatchCount(TLogHelper * pLogger, HANDLE hMpq, LPCSTR szFileName, DWORD dwExpectedPatchCount)
{
    DWORD dwPatchCount = 0;

    // Retrieve the patch count
    pLogger->PrintProgress("Verifying patch count for %s ...", szFileName);
    dwPatchCount = GetFilePatchCount(pLogger, hMpq, szFileName);

    // Check if there are any patches at all
    if(dwExpectedPatchCount != 0 && dwPatchCount == 0)
    {
        pLogger->PrintMessage("There are no patches for %s", szFileName);
        return ERROR_FILE_CORRUPT;
    }

    // Check if the number of patches fits
    if(dwPatchCount != dwExpectedPatchCount)
    {
        pLogger->PrintMessage("Unexpected number of patches for %s", szFileName);
        return ERROR_FILE_CORRUPT;
    }

    return ERROR_SUCCESS;
}

static DWORD CreateEmptyFile(TLogHelper * pLogger, LPCTSTR szPlainName, ULONGLONG FileSize, TCHAR * szBuffer)
{
    TFileStream * pStream;
    TCHAR szFullPath[MAX_PATH];

    // Notify the user
    pLogger->PrintProgress(_T("Creating empty file %s ..."), szPlainName);

    // Construct the full path and crete the file
    CreateFullPathName(szFullPath, _countof(szFullPath), NULL, szPlainName);
    pStream = FileStream_CreateFile(szFullPath, STREAM_PROVIDER_FLAT | BASE_PROVIDER_FILE);
    if(pStream == NULL)
        return pLogger->PrintError(_T("Failed to create file %s"), szBuffer);

    // Write the required size
    FileStream_SetSize(pStream, FileSize);
    FileStream_Close(pStream);

    // Give the caller the full file name
    if(szBuffer != NULL)
        _tcscpy(szBuffer, szFullPath);
    return ERROR_SUCCESS;
}

static DWORD VerifyFilePosition(
    TLogHelper * pLogger,
    TFileStream * pStream,
    ULONGLONG ExpectedPosition)
{
    ULONGLONG ByteOffset = 0;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Retrieve the file position
    if(FileStream_GetPos(pStream, &ByteOffset))
    {
        if(ByteOffset != ExpectedPosition)
        {
            pLogger->PrintMessage(_T("The file position is different than expected (expected: ") fmt_I64u_t _T(", current: ") fmt_I64u_t, ExpectedPosition, ByteOffset);
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }
    else
    {
        dwErrCode = pLogger->PrintError(_T("Failed to retrieve the file offset"));
    }

    return dwErrCode;
}

static DWORD VerifyFileMpqHeader(TLogHelper * pLogger, TFileStream * pStream, ULONGLONG * pByteOffset)
{
    TMPQHeader Header;
    DWORD dwErrCode = ERROR_SUCCESS;

    memset(&Header, 0xFE, sizeof(TMPQHeader));
    if(FileStream_Read(pStream, pByteOffset, &Header, sizeof(TMPQHeader)))
    {
        if(Header.dwID != g_dwMpqSignature)
        {
            pLogger->PrintMessage(_T("Read error - the data is not a MPQ header"));
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }
    else
    {
        dwErrCode = pLogger->PrintError(_T("Failed to read the MPQ header"));
    }

    return dwErrCode;
}

static DWORD WriteMpqUserDataHeader(
    TLogHelper * pLogger,
    TFileStream * pStream,
    ULONGLONG ByteOffset,
    DWORD dwByteCount)
{
    TMPQUserData UserData;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Notify the user
    pLogger->PrintProgress("Writing user data header...");

    // Fill the user data header
    UserData.dwID = ID_MPQ_USERDATA;
    UserData.cbUserDataSize = dwByteCount;
    UserData.dwHeaderOffs = (dwByteCount + sizeof(TMPQUserData));
    UserData.cbUserDataHeader = dwByteCount / 2;
    if(!FileStream_Write(pStream, &ByteOffset, &UserData, sizeof(TMPQUserData)))
        dwErrCode = SErrGetLastError();
    return dwErrCode;
}

static DWORD WriteFileData(
    TLogHelper * pLogger,
    TFileStream * pStream,
    ULONGLONG ByteOffset,
    ULONGLONG ByteCount)
{
    ULONGLONG SaveByteCount = ByteCount;
    ULONGLONG BytesWritten = 0;
    LPBYTE pbDataBuffer;
    DWORD cbDataBuffer = 0x10000;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Write some data
    pbDataBuffer = new BYTE[cbDataBuffer];
    if(pbDataBuffer != NULL)
    {
        memset(pbDataBuffer, 0, cbDataBuffer);
        strcpy((char *)pbDataBuffer, "This is a test data written to a file.");

        // Perform the write
        while(ByteCount > 0)
        {
            DWORD cbToWrite = (ByteCount > cbDataBuffer) ? cbDataBuffer : (DWORD)ByteCount;

            // Notify the user
            pLogger->PrintProgress("Writing file data " fmt_X_of_Y_a " ...", BytesWritten, SaveByteCount);

            // Write the data
            if(!FileStream_Write(pStream, &ByteOffset, pbDataBuffer, cbToWrite))
            {
                dwErrCode = SErrGetLastError();
                break;
            }

            BytesWritten += cbToWrite;
            ByteOffset += cbToWrite;
            ByteCount -= cbToWrite;
        }

        delete [] pbDataBuffer;
    }
    return dwErrCode;
}

static DWORD CopyFileData(
    TLogHelper * pLogger,
    TFileStream * pStream1,
    TFileStream * pStream2,
    ULONGLONG ByteOffset,
    ULONGLONG ByteCount)
{
    ULONGLONG BytesCopied = 0;
    ULONGLONG EndOffset = ByteOffset + ByteCount;
    LPBYTE pbCopyBuffer;
    DWORD BytesToRead;
    DWORD BlockLength = 0x100000;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Allocate copy buffer
    pbCopyBuffer = STORM_ALLOC(BYTE, BlockLength);
    if(pbCopyBuffer != NULL)
    {
        while(ByteOffset < EndOffset)
        {
            // Read source
            BytesToRead = ((EndOffset - ByteOffset) > BlockLength) ? BlockLength : (DWORD)(EndOffset - ByteOffset);
            if(!FileStream_Read(pStream1, &ByteOffset, pbCopyBuffer, BytesToRead))
            {
                dwErrCode = SErrGetLastError();
                break;
            }

            // Write to the destination file
            if(!FileStream_Write(pStream2, NULL, pbCopyBuffer, BytesToRead))
            {
                dwErrCode = SErrGetLastError();
                break;
            }

            // Increment the byte counts
            BytesCopied += BytesToRead;
            ByteOffset += BytesToRead;

            // Notify the user
            pLogger->PrintProgress("Copying " fmt_X_of_Y_a " ...", BytesCopied, ByteCount);
        }

        STORM_FREE(pbCopyBuffer);
    }

    return dwErrCode;
}

// Support function for copying file
static DWORD CreateFileCopy(
    TLogHelper * pLogger,
    LPCTSTR szPlainName,
    LPCTSTR szFileCopy,
    TCHAR * szBuffer = NULL,
    size_t cchBuffer = 0,
    ULONGLONG PreMpqDataSize = 0,
    ULONGLONG UserDataSize = 0)
{
    TFileStream * pStream1;             // Source file
    TFileStream * pStream2;             // Target file
    ULONGLONG ByteOffset = 0;
    ULONGLONG FileSize = 0;
    TCHAR szFileName1[MAX_PATH];
    TCHAR szFileName2[MAX_PATH];
    DWORD dwErrCode = ERROR_SUCCESS;

    // Notify the user
    szPlainName += FileStream_Prefix(szPlainName, NULL);
    pLogger->PrintProgress(_T("Creating copy of %s ..."), szPlainName);

    // Construct both file names. Check if they are not the same
    CreateFullPathName(szFileName1, _countof(szFileName1), szMpqSubDir, szPlainName);
    CreateFullPathName(szFileName2, _countof(szFileName2), NULL, szFileCopy + FileStream_Prefix(szFileCopy, NULL));
    if(!_tcsicmp(szFileName1, szFileName2))
    {
        pLogger->PrintError("Failed to create copy of MPQ (the copy name is the same like the original name)");
        return ERROR_CAN_NOT_COMPLETE;
    }

    // Open the source file
    pStream1 = FileStream_OpenFile(szFileName1, STREAM_FLAG_READ_ONLY);
    if(pStream1 == NULL)
    {
        pLogger->PrintError(_T("Failed to open the source file %s"), szFileName1);
        return ERROR_CAN_NOT_COMPLETE;
    }

    // Create the destination file
    pStream2 = FileStream_CreateFile(szFileName2, 0);
    if(pStream2 != NULL)
    {
        // If we should write some pre-MPQ data to the target file, do it
        if(PreMpqDataSize != 0)
        {
            dwErrCode = WriteFileData(pLogger, pStream2, ByteOffset, PreMpqDataSize);
            ByteOffset += PreMpqDataSize;
        }

        // If we should write some MPQ user data, write the header first
        if(UserDataSize != 0)
        {
            dwErrCode = WriteMpqUserDataHeader(pLogger, pStream2, ByteOffset, (DWORD)UserDataSize);
            ByteOffset += sizeof(TMPQUserData);

            dwErrCode = WriteFileData(pLogger, pStream2, ByteOffset, UserDataSize);
            ByteOffset += UserDataSize;
        }

        // Copy the file data from the source file to the destination file
        FileStream_GetSize(pStream1, &FileSize);
        if(FileSize != 0)
        {
            dwErrCode = CopyFileData(pLogger, pStream1, pStream2, 0, FileSize);
            ByteOffset += FileSize;
        }
        FileStream_Close(pStream2);
    }

    // Close the source file
    FileStream_Close(pStream1);

    // Create the full file name of the target file, including prefix
    if(szBuffer && cchBuffer)
        CreateFullPathName(szBuffer, cchBuffer, NULL, szFileCopy);

    // Report error, if any
    if(dwErrCode != ERROR_SUCCESS)
        pLogger->PrintError("Failed to create copy of MPQ");
    return dwErrCode;
}

static DWORD CreateMasterAndMirrorPaths(
    TLogHelper * pLogger,
    TCHAR * szMirrorPath,
    TCHAR * szMasterPath,
    LPCTSTR szMirrorName,
    LPCTSTR szMasterName,
    bool bCopyMirrorFile)
{
    TCHAR szCopyPath[MAX_PATH];
    DWORD dwErrCode = ERROR_SUCCESS;

    // Always delete the mirror file
    CreateFullPathName(szMasterPath, MAX_PATH, szMpqSubDir, szMasterName);
    CreateFullPathName(szCopyPath, _countof(szCopyPath), NULL, szMirrorName);
    _tremove(szCopyPath + FileStream_Prefix(szCopyPath, NULL));

    // Copy the mirrored file from the source to the work directory
    if(bCopyMirrorFile)
        dwErrCode = CreateFileCopy(pLogger, szMirrorName, szMirrorName);

    // Create the mirror*master path
    if(dwErrCode == ERROR_SUCCESS)
        _stprintf(szMirrorPath, _T("%s*%s"), szCopyPath, szMasterPath);

    return dwErrCode;
}

static void WINAPI AddFileCallback(void * pvUserData, DWORD dwBytesWritten, DWORD dwTotalBytes, bool bFinalCall)
{
    TLogHelper * pLogger = (TLogHelper *)pvUserData;

    // Keep compilers happy
    STORMLIB_UNUSED(bFinalCall);

    pLogger->PrintProgress("Adding file (%s) (%u of %u) (%u of %u) ...", pLogger->UserString,
                                                                         pLogger->UserCount,
                                                                         pLogger->UserTotal,
                                                                         dwBytesWritten,
                                                                         dwTotalBytes);
}

//-----------------------------------------------------------------------------
// MPQ file utilities

#define SEARCH_FLAG_LOAD_FILES      0x00000001      // Test function should load all files in the MPQ
#define SEARCH_FLAG_HASH_FILES      0x00000002      // Test function should load all files in the MPQ
#define SEARCH_FLAG_PLAY_WAVES      0x00000004      // Play extracted WAVE files
#define SEARCH_FLAG_IGNORE_ERRORS   0x00000008      // Ignore files that failed to open

static bool CheckIfFileIsPresent(TLogHelper * pLogger, HANDLE hMpq, LPCSTR szFileName, DWORD bShouldExist)
{
    HANDLE hFile = NULL;

    if(SFileOpenFileEx(hMpq, szFileName, 0, &hFile))
    {
        if(!bShouldExist)
            pLogger->PrintMessage("The file \"%s\" is present, but it should not be", szFileName);
        SFileCloseFile(hFile);
        return true;
    }
    else
    {
        if(bShouldExist)
            pLogger->PrintMessage("The file \"%s\" is not present, but it should be", szFileName);
        return false;
    }
}

static DWORD LoadLocalFileMD5(TLogHelper * pLogger, LPCTSTR szFileFullName, LPBYTE md5_file_local)
{
    PFILE_DATA pFileData;

    // Load the local file to memory
    if((pFileData = LoadLocalFile(pLogger, szFileFullName, true)) == NULL)
    {
        return pLogger->PrintError(_T("The file \"%s\" could not be loaded"), szFileFullName);
    }

    // Calculate the hash
    CalculateDataBlockHash(pFileData->FileData, pFileData->dwFileSize, md5_file_local);
    STORM_FREE(pFileData);
    return ERROR_SUCCESS;
}

static DWORD LoadMpqFile(TLogHelper & Logger, HANDLE hMpq, LPCSTR szFileName, LCID lcFileLocale, DWORD dwSearchFlags, PFILE_DATA * ppFileData)
{
    PFILE_DATA pFileData = NULL;
    HANDLE hFile;
    DWORD dwFileSizeHi = 0xCCCCCCCC;
    DWORD dwFileSizeLo = 0;
    DWORD dwBytesRead;
    DWORD dwCrc32 = 0;
    DWORD dwErrCode = ERROR_SUCCESS;
    TCHAR szSafeName[1024];

    // Print the file name to the console.
    // Prevent bad UTF-8 sequences to go through
    SMemUTF8ToFileName(szSafeName, _countof(szSafeName), szFileName, NULL, 0, NULL);
    Logger.PrintProgress(_T("Loading file %s ..."), GetShortPlainName(szSafeName));

#if defined(_MSC_VER) && defined(_DEBUG)
    //if(!_stricmp(szFileName, "(signature)"))
    //    __debugbreak();
#endif

    // Make sure that we open the proper locale file
    SFileSetLocale(lcFileLocale);
    *ppFileData = NULL;

    // Open the file from MPQ
    if(SFileOpenFileEx(hMpq, szFileName, 0, &hFile))
    {
        // Get the CRC32 of the file
        SFileGetFileInfo(hFile, SFileInfoCRC32, &dwCrc32, sizeof(dwCrc32), NULL);

        // Get the size of the file
        if(dwErrCode == ERROR_SUCCESS)
        {
            dwFileSizeLo = SFileGetFileSize(hFile, &dwFileSizeHi);
            if(dwFileSizeLo == SFILE_INVALID_SIZE || dwFileSizeHi != 0)
                dwErrCode = Logger.PrintError("Failed to query the file size");
        }

        // Spazzler protector: Creates fake files with size of 0x7FFFE7CA
        if(dwErrCode == ERROR_SUCCESS && dwFileSizeLo > 0x1FFFFFFF)
        {
            dwErrCode = ERROR_FILE_CORRUPT;
        }

        // Allocate buffer for the file content
        if(dwErrCode == ERROR_SUCCESS)
        {
            pFileData = (PFILE_DATA)STORM_ALLOC(BYTE, sizeof(FILE_DATA) + dwFileSizeLo);
            if(pFileData == NULL)
            {
                Logger.PrintError("Failed to allocate buffer for the file content");
                dwErrCode = ERROR_NOT_ENOUGH_MEMORY;
            }
        }

        // Get the file index of the MPQ file
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Store the file size
            memset(pFileData, 0, sizeof(FILE_DATA) + dwFileSizeLo);
            pFileData->dwFileSize = dwFileSizeLo;
            pFileData->dwCrc32 = dwCrc32;

            // Retrieve the block index and file flags
            if(!SFileGetFileInfo(hFile, SFileInfoFileIndex, &pFileData->dwBlockIndex, sizeof(DWORD), NULL))
                dwErrCode = Logger.PrintError("Failed retrieve the file index of %s", szFileName);
            if(!SFileGetFileInfo(hFile, SFileInfoFlags, &pFileData->dwFlags, sizeof(DWORD), NULL))
                dwErrCode = Logger.PrintError("Failed retrieve the file flags of %s", szFileName);
        }

        // Load the entire file
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Read the file data
            SFileReadFile(hFile, pFileData->FileData, dwFileSizeLo, &dwBytesRead, NULL);
            if(dwBytesRead != dwFileSizeLo)
                dwErrCode = ERROR_FILE_CORRUPT;
        }

        // If succeeded, check the CRC
        if(dwErrCode == ERROR_SUCCESS && dwCrc32 != 0 && (dwSearchFlags & SEARCH_FLAG_IGNORE_ERRORS) == 0)
        {
            dwCrc32 = crc32(0, (Bytef *)pFileData->FileData, (uInt)pFileData->dwFileSize);
            if(dwCrc32 != pFileData->dwCrc32)
                Logger.PrintMessage("Warning: CRC32 error on %s", szFileName);
        }

        SFileCloseFile(hFile);
    }
    else
    {
        if((dwSearchFlags & SEARCH_FLAG_IGNORE_ERRORS) == 0 && SErrGetLastError() != ERROR_FILE_DELETED)
        {
            dwErrCode = Logger.PrintError("Open failed: %s", szFileName);
        }
    }

    // If something failed, free the file data
    if((dwErrCode != ERROR_SUCCESS) && (pFileData != NULL))
    {
        STORM_FREE(pFileData);
        pFileData = NULL;
    }

    // Return what we got
    if(ppFileData != NULL)
        ppFileData[0] = pFileData;
    return dwErrCode;
}

static DWORD LoadMpqFileMD5(TLogHelper & Logger, HANDLE hMpq, LPCSTR szArchivedName, LPBYTE md5_file_in_mpq1)
{
    PFILE_DATA pFileData = NULL;
    DWORD dwErrCode;

    // Load the MPQ to memory
    dwErrCode = LoadMpqFile(Logger, hMpq, szArchivedName, 0, 0, &pFileData);
    if(dwErrCode == ERROR_SUCCESS && pFileData != NULL)
    {
        CalculateDataBlockHash(pFileData->FileData, pFileData->dwFileSize, md5_file_in_mpq1);
        STORM_FREE(pFileData);
        return ERROR_SUCCESS;
    }

    Logger.PrintError("The file \"%s\" is not in the archive", szArchivedName);
    return dwErrCode;
}

static DWORD CompareTwoLocalFilesRR(
    TLogHelper * pLogger,
    TFileStream * pStream1,                         // Master file
    TFileStream * pStream2,                         // Mirror file
    int nIterations)                                // Number of iterations
{
    ULONGLONG RandomNumber = 0x12345678;            // We need pseudo-random number that will repeat each run of the program
    ULONGLONG RandomSeed;
    ULONGLONG ByteOffset;
    ULONGLONG FileSize1 = 1;
    ULONGLONG FileSize2 = 2;
    DWORD BytesToRead;
    DWORD Difference;
    LPBYTE pbBuffer1;
    LPBYTE pbBuffer2;
    DWORD cbBuffer = 0x100000;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Compare file sizes
    FileStream_GetSize(pStream1, &FileSize1);
    FileStream_GetSize(pStream2, &FileSize2);
    if(FileSize1 != FileSize2)
    {
        pLogger->PrintMessage("The files have different size");
        return ERROR_CAN_NOT_COMPLETE;
    }

    // Allocate both buffers
    pbBuffer1 = STORM_ALLOC(BYTE, cbBuffer);
    pbBuffer2 = STORM_ALLOC(BYTE, cbBuffer);
    if(pbBuffer1 && pbBuffer2)
    {
        // Perform many random reads
        for(int i = 0; i < nIterations; i++)
        {
            // Generate psudo-random offsrt and data size
            ByteOffset = (RandomNumber % FileSize1);
            BytesToRead = (DWORD)(RandomNumber % cbBuffer);

            // Show the progress message
            pLogger->PrintProgress("Comparing file: Offset: " fmt_I64u_a ", Length: %u", ByteOffset, BytesToRead);

            // Only perform read if the byte offset is below
            if(ByteOffset < FileSize1)
            {
                if((ByteOffset + BytesToRead) > FileSize1)
                    BytesToRead = (DWORD)(FileSize1 - ByteOffset);

                memset(pbBuffer1, 0xEE, cbBuffer);
                memset(pbBuffer2, 0xAA, cbBuffer);

                FileStream_Read(pStream1, &ByteOffset, pbBuffer1, BytesToRead);
                FileStream_Read(pStream2, &ByteOffset, pbBuffer2, BytesToRead);

                if(!CompareBlocks(pbBuffer1, pbBuffer2, BytesToRead, &Difference))
                {
                    pLogger->PrintMessage("Difference at %u (Offset " fmt_I64X_a ", Length %X)", Difference, ByteOffset, BytesToRead);
                    dwErrCode = ERROR_FILE_CORRUPT;
                    break;
                }

                // Shuffle the random number
                memcpy(&RandomSeed, pbBuffer1, sizeof(RandomSeed));
                RandomNumber = ((RandomNumber >> 0x11) | (RandomNumber << 0x29)) ^ (RandomNumber + RandomSeed);
            }
        }
    }

    // Free both buffers
    if(pbBuffer2 != NULL)
        STORM_FREE(pbBuffer2);
    if(pbBuffer1 != NULL)
        STORM_FREE(pbBuffer1);
    return dwErrCode;
}

static DWORD SearchArchive(
    TLogHelper * pLogger,
    HANDLE hMpq,
    DWORD dwSearchFlags = 0,
    DWORD * pdwFileCount = NULL,
    LPBYTE pbFileHash = NULL)
{
    SFILE_FIND_DATA sf;
    PFILE_DATA pFileData;
    HANDLE hFind;
    FILE * fp = NULL;
    DWORD dwFileCount = 0;
    hash_state md5state;
    TCHAR szListFile[MAX_PATH] = _T("");
    DWORD dwErrCode = ERROR_SUCCESS;
    bool bFound = true;

    // Construct the full name of the listfile
    CreateFullPathName(szListFile, _countof(szListFile), szListFileDir, _T("ListFile_Blizzard.txt"));

    // Create the log file with file sizes and CRCs
    //fp = fopen("C:\\mpq-listing.txt", "wt");

    // Prepare hashing
    md5_init(&md5state);

    // Initiate the MPQ search
    pLogger->PrintProgress("Searching the archive (initializing) ...");
    hFind = SFileFindFirstFile(hMpq, "*", &sf, szListFile);
    if(hFind == NULL)
    {
        dwErrCode = SErrGetLastError();
        dwErrCode = (dwErrCode == ERROR_NO_MORE_FILES) ? ERROR_SUCCESS : dwErrCode;
        return dwErrCode;
    }

    // Perform the search
    pLogger->PrintProgress("Searching the archive ...");
    while(bFound == true)
    {
        // Increment number of files
        dwFileCount++;

        // Load the file to memory, if required
        if(dwSearchFlags & SEARCH_FLAG_LOAD_FILES)
        {
            // Load the entire file to the MPQ
            if(LoadMpqFile(*pLogger, hMpq, sf.cFileName, sf.lcLocale, dwSearchFlags, &pFileData) == ERROR_SUCCESS && pFileData != NULL)
            {
                // Hash the file data, if needed
                if((dwSearchFlags & SEARCH_FLAG_HASH_FILES) && !IsInternalMpqFileName(sf.cFileName))
                    md5_process(&md5state, pFileData->FileData, pFileData->dwFileSize);

                // Play sound files, if required
                if((dwSearchFlags & SEARCH_FLAG_PLAY_WAVES) && strstr(sf.cFileName, ".wav") != NULL)
                {
                    pLogger->PrintProgress("Playing sound %s", sf.cFileName);
                    PlayWaveSound(pFileData);
                }

                // Debug: Show CRC32 of each file in order to debug differences
                if(fp != NULL)
                {
                    pFileData->dwCrc32 = crc32(0, pFileData->FileData, pFileData->dwFileSize);
                    fprintf(fp, "%08x:%08x: %s                   \n", pFileData->dwFileSize, pFileData->dwCrc32, sf.cFileName);
                }

                // Also write the content of the file to the test directory
                //if(fp != NULL)
                //{
                //    FILE * fp2;
                //    char szFullPath[MAX_PATH] = "C:\\test\\";

                //    strcat(szFullPath, sf.cFileName);
                //    if((fp2 = fopen(szFullPath, "wb")) != NULL)
                //    {
                //        fwrite(pFileData->FileData, 1, pFileData->dwFileSize, fp2);
                //        fclose(fp2);
                //    }
                //}

                // Free the loaded file data
                STORM_FREE(pFileData);
            }
        }

        // The last file that was OK
        bFound = SFileFindNextFile(hFind, &sf);
    }
    SFileFindClose(hFind);

    // Give the file count, if required
    if(pdwFileCount != NULL)
        pdwFileCount[0] = dwFileCount;

    // Give the hash, if required
    if(pbFileHash != NULL && (dwSearchFlags & SEARCH_FLAG_HASH_FILES))
        md5_done(&md5state, pbFileHash);

    // Close the log file, if any
    if(fp != NULL)
        fclose(fp);
    return dwErrCode;
}

static DWORD VerifyFileCountAndHash(TLogHelper & Logger, const void * NameHash, LPCSTR szExpectedHash, DWORD dwFileCount, DWORD dwExpectedFileCount)
{
    char szNameHash[0x40];

    if((dwExpectedFileCount != 0) && (dwExpectedFileCount != dwFileCount))
    {
        Logger.PrintMessage("File count mismatch(expected: %u, found: %u)", dwExpectedFileCount, dwFileCount);
        return ERROR_CAN_NOT_COMPLETE;
    }

    // Check the MD5 hash, if given
    SMemBinToStr(szNameHash, _countof(szNameHash), NameHash, MD5_DIGEST_SIZE);
    if(_stricmp(szNameHash, szExpectedHash))
    {
        Logger.PrintMessage("Extracted files MD5 mismatch (expected: %s, obtained: %s)", szExpectedHash, szNameHash);
        return ERROR_CAN_NOT_COMPLETE;
    }
    return ERROR_SUCCESS;
}

static DWORD VerifyDataChecksum(TLogHelper & Logger, HANDLE hMpq, DWORD dwSearchFlags, LPCSTR szExpectedHash, DWORD dwExpectedFileCount)
{
    DWORD dwErrCode = ERROR_SUCCESS;
    DWORD dwFileCount = 0;
    BYTE NameHash[MD5_DIGEST_SIZE] = {0};

    // Do nothing if no name hash and no known file count
    if(IS_VALID_STRING(szExpectedHash) || (dwExpectedFileCount != 0))
    {
        // Search the archive, obtain file count and name hash
        if((dwErrCode = SearchArchive(&Logger, hMpq, dwSearchFlags, &dwFileCount, NameHash)) != ERROR_SUCCESS)
        {
            Logger.PrintMessage("Failed to search the archive");
            return dwErrCode;
        }

        // Check the file count and hash
        dwErrCode = VerifyFileCountAndHash(Logger, NameHash, szExpectedHash, dwFileCount, dwExpectedFileCount);
    }
    return dwErrCode;
}

static DWORD CreateNewArchive(TLogHelper * pLogger, LPCTSTR szPlainName, DWORD dwCreateFlags, DWORD dwMaxFileCount, HANDLE * phMpq)
{
    HANDLE hMpq = NULL;
    TCHAR szMpqName[MAX_PATH];
    TCHAR szFullPath[MAX_PATH];

    // Make sure that the MPQ is deleted
    CreateFullPathName(szFullPath, _countof(szFullPath), NULL, szPlainName);
    _tremove(szFullPath);

    // Create the new MPQ
    StringCopy(szMpqName, _countof(szMpqName), szFullPath);
    if(!SFileCreateArchive(szMpqName, dwCreateFlags, dwMaxFileCount, &hMpq))
        return pLogger->PrintError(_T("Failed to create archive %s"), szMpqName);

    // Shall we close it right away?
    if(phMpq == NULL)
        SFileCloseArchive(hMpq);
    else
        *phMpq = hMpq;

    return ERROR_SUCCESS;
}

static DWORD CreateNewArchive_V2(TLogHelper * pLogger, LPCTSTR szPlainName, DWORD dwCreateFlags, DWORD dwMaxFileCount, HANDLE * phMpq)
{
    SFILE_CREATE_MPQ CreateInfo;
    HANDLE hMpq = NULL;
    TCHAR szMpqName[MAX_PATH];
    TCHAR szFullPath[MAX_PATH];

    // Make sure that the MPQ is deleted
    CreateFullPathName(szFullPath, _countof(szFullPath), NULL, szPlainName);
    StringCopy(szMpqName, _countof(szMpqName), szFullPath);
    _tremove(szFullPath);

    // Fill the create structure
    memset(&CreateInfo, 0, sizeof(SFILE_CREATE_MPQ));
    CreateInfo.cbSize         = sizeof(SFILE_CREATE_MPQ);
    CreateInfo.dwMpqVersion   = (dwCreateFlags & MPQ_CREATE_ARCHIVE_VMASK) >> FLAGS_TO_FORMAT_SHIFT;
    CreateInfo.dwStreamFlags  = STREAM_PROVIDER_FLAT | BASE_PROVIDER_FILE;
//  CreateInfo.dwFileFlags1   = (dwCreateFlags & MPQ_CREATE_LISTFILE)   ? MPQ_FILE_EXISTS : 0;
//  CreateInfo.dwFileFlags2   = (dwCreateFlags & MPQ_CREATE_ATTRIBUTES) ? MPQ_FILE_EXISTS : 0;
    CreateInfo.dwFileFlags1   = (dwCreateFlags & MPQ_CREATE_LISTFILE)   ? MPQ_FILE_DEFAULT_INTERNAL : 0;
    CreateInfo.dwFileFlags2   = (dwCreateFlags & MPQ_CREATE_ATTRIBUTES) ? MPQ_FILE_DEFAULT_INTERNAL : 0;
    CreateInfo.dwFileFlags3   = (dwCreateFlags & MPQ_CREATE_SIGNATURE)  ? MPQ_FILE_DEFAULT_INTERNAL : 0;
    CreateInfo.dwAttrFlags    = (dwCreateFlags & MPQ_CREATE_ATTRIBUTES) ? (MPQ_ATTRIBUTE_CRC32 | MPQ_ATTRIBUTE_FILETIME | MPQ_ATTRIBUTE_MD5) : 0;
    CreateInfo.dwSectorSize   = (CreateInfo.dwMpqVersion >= MPQ_FORMAT_VERSION_3) ? 0x4000 : 0x1000;
    CreateInfo.dwRawChunkSize = (CreateInfo.dwMpqVersion >= MPQ_FORMAT_VERSION_4) ? 0x4000 : 0;
    CreateInfo.dwMaxFileCount = dwMaxFileCount;

    // Create the new MPQ
    if(!SFileCreateArchive2(szMpqName, &CreateInfo, &hMpq))
        return pLogger->PrintError(_T("Failed to create archive %s"), szMpqName);

    // Shall we close it right away?
    if(phMpq == NULL)
        SFileCloseArchive(hMpq);
    else
        *phMpq = hMpq;

    return ERROR_SUCCESS;
}

static DWORD OpenExistingArchive(TLogHelper * pLogger, LPCTSTR szFullPath, DWORD dwOpenFlags, HANDLE * phMpq)
{
    HANDLE hMpq = NULL;
    size_t nMarkerIndex;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Get the stream provider from the MPQ prefix or MPQ name
    if(_tcsnicmp(szFullPath, _T("flat-file://"), 11))
    {
        if(_tcsstr(szFullPath, _T(".MPQE")) != NULL)
            dwOpenFlags |= STREAM_PROVIDER_MPQE;
        if(_tcsstr(szFullPath, _T(".MPQ.part")) != NULL)
            dwOpenFlags |= STREAM_PROVIDER_PARTIAL;
        if(_tcsstr(szFullPath, _T(".mpq.part")) != NULL)
            dwOpenFlags |= STREAM_PROVIDER_PARTIAL;
        if(_tcsstr(szFullPath, _T(".MPQ.0")) != NULL)
            dwOpenFlags |= STREAM_PROVIDER_BLOCK4;
    }

    // Handle ASI files properly
    nMarkerIndex = (_tcsstr(szFullPath, _T(".asi")) != NULL) ? 1 : 0;
    SFileSetArchiveMarkers(&MpqMarkers[nMarkerIndex]);

    // Open the copied archive
    pLogger->PrintProgress(_T("Opening archive %s ..."), GetShortPlainName(szFullPath));
    if(!SFileOpenArchive(szFullPath, 0, dwOpenFlags, &hMpq))
    {
        switch(dwErrCode = SErrGetLastError())
        {
//          case ERROR_BAD_FORMAT:  // If the error is ERROR_BAD_FORMAT, try to open with MPQ_OPEN_FORCE_MPQ_V1
//              bReopenResult = SFileOpenArchive(szMpqName, 0, dwFlags | MPQ_OPEN_FORCE_MPQ_V1, &hMpq);
//              dwErrCode = (bReopenResult == false) ? SErrGetLastError() : ERROR_SUCCESS;
//              break;

            case ERROR_AVI_FILE:        // Ignore the error if it's an AVI file or if the file is incomplete
            case ERROR_FILE_INCOMPLETE:
                return dwErrCode;
        }

        // Show the open error to the user
        if((dwOpenFlags & MPQ_OPEN_DONT_REPORT_FAILURE) == 0)
            dwErrCode = pLogger->PrintError(_T("Failed to open archive %s"), szFullPath);
        return dwErrCode;
    }

    // Store the archive handle or close the archive
    if(phMpq == NULL)
        SFileCloseArchive(hMpq);
    else
        *phMpq = hMpq;
    return dwErrCode;
}

static DWORD OpenExistingArchiveWithCopy(TLogHelper * pLogger, LPCTSTR szFileName, LPCTSTR szCopyName, HANDLE * phMpq, DWORD dwOpenFlags = 0)
{
    DWORD dwErrCode = ERROR_SUCCESS;
    TCHAR szFullPath[MAX_PATH];

    // We expect MPQ directory to be already prepared by InitializeMpqDirectory
    assert(szMpqDirectory[0] != 0);

    // At least one name must be entered
    assert(szFileName != NULL || szCopyName != NULL);

    // If both names entered, create a copy
    if(szFileName != NULL && szCopyName != NULL)
    {
        dwErrCode = CreateFileCopy(pLogger, szFileName, szCopyName, szFullPath, _countof(szFullPath));
        if(dwErrCode != ERROR_SUCCESS)
            return dwErrCode;
    }

    // If only source name entered, open it for read-only access
    else if(szFileName != NULL && szCopyName == NULL)
    {
        CreateFullPathName(szFullPath, _countof(szFullPath), szMpqSubDir, szFileName);
        dwOpenFlags |= MPQ_OPEN_READ_ONLY;
    }

    // If only target name entered, open it directly
    else if(szFileName == NULL && szCopyName != NULL)
    {
        CreateFullPathName(szFullPath, _countof(szFullPath), NULL, szCopyName);
    }

    // Open the archive
    return OpenExistingArchive(pLogger, szFullPath, dwOpenFlags, phMpq);
}

static DWORD AddFileToMpq(
    TLogHelper * pLogger,
    HANDLE hMpq,
    LPCSTR szFileName,
    LPCSTR szFileData,
    DWORD dwFlags = 0,
    DWORD dwCompression = 0,
    DWORD dwExpectedError = ERROR_SUCCESS)
{
    HANDLE hFile = NULL;
    DWORD dwFileSize = (DWORD)strlen(szFileData);
    DWORD dwErrCode = ERROR_SUCCESS;

    // Notify the user
    pLogger->PrintProgress("Adding file %s ...", szFileName);

    // Get the default flags
    if(dwFlags == 0)
        dwFlags = MPQ_FILE_COMPRESS | MPQ_FILE_ENCRYPTED;
    if(dwCompression == 0)
        dwCompression = MPQ_COMPRESSION_ZLIB;

    // Create the file within the MPQ
    if(SFileCreateFile(hMpq, szFileName, 0, dwFileSize, 0, dwFlags, &hFile))
    {
        // Write the file
        if(!SFileWriteFile(hFile, szFileData, dwFileSize, dwCompression))
            dwErrCode = pLogger->PrintError("Failed to write data to the MPQ");
        SFileCloseFile(hFile);
    }
    else
    {
        dwErrCode = SErrGetLastError();
    }

    // Check the expected error code
    if(dwExpectedError != ERROR_UNDETERMINED_RESULT)
    {
        if(dwErrCode != dwExpectedError)
        {
            pLogger->PrintError("Unexpected result from SFileCreateFile(%s)", szFileName);
            dwErrCode = ERROR_CAN_NOT_COMPLETE;
        }
    }
    return dwErrCode;
}

static DWORD AddLocalFileToMpq(
    TLogHelper * pLogger,
    HANDLE hMpq,
    LPCSTR szArchivedName,
    LPCTSTR szFileFullName,
    DWORD dwFlags = 0,
    DWORD dwCompression = 0,
    bool bMustSucceed = false)
{
    TCHAR szFileName[MAX_PATH];
    DWORD dwVerifyResult;

    // Notify the user
    pLogger->PrintProgress("Adding file %s (%u of %u)...", GetShortPlainName(szFileFullName), pLogger->UserCount, pLogger->UserTotal);
    pLogger->UserString = szArchivedName;

    // Get the default flags
    if(dwFlags == 0)
        dwFlags = MPQ_FILE_COMPRESS | MPQ_FILE_ENCRYPTED;
    if(dwCompression == 0)
        dwCompression = MPQ_COMPRESSION_ZLIB;

    // Set the notification callback
    SFileSetAddFileCallback(hMpq, AddFileCallback, pLogger);

    // Add the file to the MPQ
    StringCopy(szFileName, _countof(szFileName), szFileFullName);
    if(!SFileAddFileEx(hMpq, szFileName, szArchivedName, dwFlags, dwCompression, MPQ_COMPRESSION_NEXT_SAME))
    {
        if(bMustSucceed)
            return pLogger->PrintError("Failed to add the file %s", szArchivedName);
        return SErrGetLastError();
    }

    // Verify the file unless it was lossy compression
    if((dwCompression & (MPQ_COMPRESSION_ADPCM_MONO | MPQ_COMPRESSION_ADPCM_STEREO)) == 0)
    {
        // Notify the user
        pLogger->PrintProgress("Verifying file %s (%u of %u) ...", szArchivedName, pLogger->UserCount, pLogger->UserTotal);

        // Perform the verification
        dwVerifyResult = SFileVerifyFile(hMpq, szArchivedName, MPQ_ATTRIBUTE_CRC32 | MPQ_ATTRIBUTE_MD5);
        if(dwVerifyResult & (VERIFY_OPEN_ERROR | VERIFY_READ_ERROR | VERIFY_FILE_SECTOR_CRC_ERROR | VERIFY_FILE_CHECKSUM_ERROR | VERIFY_FILE_MD5_ERROR))
            return pLogger->PrintError("CRC error on %s", szArchivedName);
    }

    return ERROR_SUCCESS;
}

static DWORD RemoveMpqFile(TLogHelper * pLogger, HANDLE hMpq, LPCSTR szFileName, DWORD dwExpectedError)
{
    DWORD dwErrCode = ERROR_SUCCESS;

    // Notify the user
    pLogger->PrintProgress("Removing file %s ...", szFileName);

    // Perform the deletion
    if(!SFileRemoveFile(hMpq, szFileName, 0))
        dwErrCode = SErrGetLastError();

    if(dwErrCode != dwExpectedError)
        return pLogger->PrintError("Unexpected result from SFileRemoveFile(%s)", szFileName);
    return ERROR_SUCCESS;
}

//-----------------------------------------------------------------------------
// Tests

static void TestGetFileInfo(
    TLogHelper * pLogger,
    HANDLE hMpqOrFile,
    SFileInfoClass InfoClass,
    void * pvFileInfo,
    DWORD cbFileInfo,
    DWORD * pcbLengthNeeded,
    bool bExpectedResult,
    DWORD dwExpectedErrCode)
{
    DWORD dwErrCode = ERROR_SUCCESS;
    bool bResult;

    // Call the get file info
    bResult = SFileGetFileInfo(hMpqOrFile, InfoClass, pvFileInfo, cbFileInfo, pcbLengthNeeded);
    if(!bResult)
        dwErrCode = SErrGetLastError();

    // Check the expected results
    if(bResult != bExpectedResult)
        pLogger->PrintMessage("Different result of SFileGetFileInfo.");
    if(dwErrCode != dwExpectedErrCode)
        pLogger->PrintMessage("Different error from SFileGetFileInfo (expected %u, returned %u)", dwExpectedErrCode, dwErrCode);
}

// StormLib is able to open local files (as well as the original Storm.dll)
// I want to keep this for occasional use

static LINE_INFO Lines[] =
{
    {0x000, 18, "accountbilling.url"},
    {0x013, 45, "alternate/character/goblin/male/goblinmale.m2"},
    {0x9ab, 54, "alternate/character/goblin/male/goblinmale0186-00.anim"}
};

static DWORD TestOnLocalListFile_Read(TLogHelper & Logger, HANDLE hFile)
{
    for(size_t i = 0; i < _countof(Lines); i++)
    {
        DWORD dwBytesRead = 0;
        char szFileLine[0x100] = {0};

        SFileSetFilePointer(hFile, Lines[i].nLinePos, NULL, FILE_BEGIN);
        SFileReadFile(hFile, szFileLine, Lines[i].nLineLen, &dwBytesRead, NULL);

        if(dwBytesRead != Lines[i].nLineLen)
        {
            Logger.PrintMessage("Line %u length mismatch", i);
            return false;
        }

        if(strcmp(szFileLine, Lines[i].szLine))
        {
            Logger.PrintMessage("Line %u content mismatch", i);
            return false;
        }
    }

    return true;
}

static DWORD TestOnLocalListFile(LPCTSTR szPlainName)
{
    TLogHelper Logger("TestLiFiSearch", szPlainName);
    SFILE_FIND_DATA sf;
    HANDLE hFile;
    HANDLE hFind;
    DWORD dwFileSizeHi = 0;
    DWORD dwFileSizeLo = 0;
    TCHAR szFullPath[MAX_PATH];
    char szFileName1[MAX_PATH];
    char szFileName2[MAX_PATH];
    int nFileCount = 0;

    // Get the full name of the local file
    CreateFullPathName(szFileName1, _countof(szFileName1), szDataFileDir, szPlainName);

    // Test opening the local file
    if(SFileOpenFileEx(NULL, szFileName1, SFILE_OPEN_LOCAL_FILE, &hFile))
    {
        // Retrieve the file name. It must match the name under which the file was open
        if(FileStream_Prefix(szPlainName, NULL) == 0)
        {
            SFileGetFileName(hFile, szFileName2);
            if(strcmp(szFileName2, szFileName1))
                Logger.PrintMessage("The retrieved name does not match the open name");
        }

        // Retrieve the file size
        dwFileSizeLo = SFileGetFileSize(hFile, &dwFileSizeHi);
        if(dwFileSizeHi != 0 || dwFileSizeLo != 0x04385a4e)
            Logger.PrintMessage("Local file size mismatch");

        // Read few lines, check their content
        TestOnLocalListFile_Read(Logger, hFile);
        SFileCloseFile(hFile);
    }
    else
        return Logger.PrintError("Failed to open local listfile");

    // We need unicode listfile name
    StringCopy(szFullPath, _countof(szFullPath), szFileName1);

    // Start searching in the listfile
    hFind = SListFileFindFirstFile(NULL, szFullPath, "*", &sf);
    if(hFind != NULL)
    {
        for(;;)
        {
            Logger.PrintProgress("Found file (%04u): %s", nFileCount++, GetShortPlainName(sf.cFileName));
            if(!SListFileFindNextFile(hFind, &sf))
                break;
        }

        SListFileFindClose(hFind);
    }
    else
        return Logger.PrintError("Failed to search local listfile");

    return ERROR_SUCCESS;
}

static void WINAPI TestReadFile_DownloadCallback(
    void * UserData,
    ULONGLONG ByteOffset,
    DWORD DataLength)
{
    TLogHelper * pLogger = (TLogHelper *)UserData;

    if(ByteOffset != 0 && DataLength != 0)
        pLogger->PrintProgress("Downloading data (offset: " fmt_I64X_a ", length: %X)", ByteOffset, DataLength);
    else
        pLogger->PrintProgress("Download complete.");
}

// Open a file stream with mirroring a master file
static DWORD TestReadFile_MasterMirror(LPCTSTR szMirrorName, LPCTSTR szMasterName, bool bCopyMirrorFile)
{
    TFileStream * pStream1;                     // Master file
    TFileStream * pStream2;                     // Mirror file
    TLogHelper Logger("TestFileMirror", szMirrorName);
    TCHAR szMirrorPath[MAX_PATH + MAX_PATH];
    TCHAR szMasterPath[MAX_PATH];
    DWORD dwProvider = 0;
    int nIterations = 0x10000;
    DWORD dwErrCode;

    // Retrieve the provider
    FileStream_Prefix(szMasterName, &dwProvider);

#ifndef STORMLIB_WINDOWS
    if((dwProvider & BASE_PROVIDER_MASK) == BASE_PROVIDER_HTTP)
        return ERROR_SUCCESS;
#endif

    // Create copy of the file to serve as mirror, keep master there
    dwErrCode = CreateMasterAndMirrorPaths(&Logger, szMirrorPath, szMasterPath, szMirrorName, szMasterName, bCopyMirrorFile);
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Open both master and mirror file
        pStream1 = FileStream_OpenFile(szMasterPath, STREAM_FLAG_READ_ONLY);
        pStream2 = FileStream_OpenFile(szMirrorPath, STREAM_FLAG_READ_ONLY | STREAM_FLAG_USE_BITMAP);
        if(pStream1 && pStream2)
        {
            // For internet based files, we limit the number of operations
            if((dwProvider & BASE_PROVIDER_MASK) == BASE_PROVIDER_HTTP)
                nIterations = 0x80;

            FileStream_SetCallback(pStream2, TestReadFile_DownloadCallback, &Logger);
            dwErrCode = CompareTwoLocalFilesRR(&Logger, pStream1, pStream2, nIterations);
        }

        if(pStream2 != NULL)
            FileStream_Close(pStream2);
        if(pStream1 != NULL)
            FileStream_Close(pStream1);
    }

    return dwErrCode;
}

// Test of the TFileStream object
static DWORD TestFileStreamOperations(LPCTSTR szPlainName, DWORD dwStreamFlags)
{
    TFileStream * pStream = NULL;
    TLogHelper Logger("TestFileStream", szPlainName);
    ULONGLONG ByteOffset;
    ULONGLONG FileSize = 0;
    TCHAR szFullPath[MAX_PATH];
    DWORD dwRequiredFlags = 0;
    BYTE Buffer[0x10];
    DWORD dwErrCode = ERROR_SUCCESS;

    // Copy the file so we won't screw up
    if((dwStreamFlags & STREAM_PROVIDER_MASK) == STREAM_PROVIDER_BLOCK4)
        CreateFullPathName(szFullPath, _countof(szFullPath), szMpqSubDir, szPlainName);
    else
        dwErrCode = CreateFileCopy(&Logger, szPlainName, szPlainName, szFullPath, _countof(szFullPath));

    // Open the file stream
    if(dwErrCode == ERROR_SUCCESS)
    {
        pStream = FileStream_OpenFile(szFullPath, dwStreamFlags);
        if(pStream == NULL)
            return Logger.PrintError(_T("Open failed: %s"), szFullPath);
    }

    // Get the size of the file stream
    if(dwErrCode == ERROR_SUCCESS)
    {
        if(!FileStream_GetFlags(pStream, &dwStreamFlags))
            dwErrCode = Logger.PrintError("Failed to retrieve the stream flags");

        if(!FileStream_GetSize(pStream, &FileSize))
            dwErrCode = Logger.PrintError("Failed to retrieve the file size");

        // Any other stream except STREAM_PROVIDER_FLAT | BASE_PROVIDER_FILE should be read-only
        if((dwStreamFlags & STREAM_PROVIDERS_MASK) != (STREAM_PROVIDER_FLAT | BASE_PROVIDER_FILE))
            dwRequiredFlags |= STREAM_FLAG_READ_ONLY;
//      if(pStream->BlockPresent)
//          dwRequiredFlags |= STREAM_FLAG_READ_ONLY;

        // Check the flags there
        if((dwStreamFlags & dwRequiredFlags) != dwRequiredFlags)
        {
            Logger.PrintMessage("The stream should be read-only but it isn't");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    // After successful open, the stream position must be zero
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = VerifyFilePosition(&Logger, pStream, 0);

    // Read the MPQ header from the current file offset.
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = VerifyFileMpqHeader(&Logger, pStream, NULL);

    // After successful open, the stream position must sizeof(TMPQHeader)
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = VerifyFilePosition(&Logger, pStream, sizeof(TMPQHeader));

    // Now try to read the MPQ header from the offset 0
    if(dwErrCode == ERROR_SUCCESS)
    {
        ByteOffset = 0;
        dwErrCode = VerifyFileMpqHeader(&Logger, pStream, &ByteOffset);
    }

    // After successful open, the stream position must sizeof(TMPQHeader)
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = VerifyFilePosition(&Logger, pStream, sizeof(TMPQHeader));

    // Try a write operation
    if(dwErrCode == ERROR_SUCCESS)
    {
        bool bExpectedResult = (dwStreamFlags & STREAM_FLAG_READ_ONLY) ? false : true;
        bool bResult;

        // Attempt to write to the file
        ByteOffset = 0;
        bResult = FileStream_Write(pStream, &ByteOffset, Buffer, sizeof(Buffer));

        // If the result is not expected
        if(bResult != bExpectedResult)
        {
            Logger.PrintMessage("FileStream_Write result is different than expected");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    // Move the position 9 bytes from the end and try to read 10 bytes.
    // This must fail, because stream reading functions are "all or nothing"
    if(dwErrCode == ERROR_SUCCESS)
    {
        ByteOffset = FileSize - 9;
        if(FileStream_Read(pStream, &ByteOffset, Buffer, 10))
        {
            Logger.PrintMessage("FileStream_Read succeeded, but it shouldn't");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    // Try again with 9 bytes. This must succeed, unless the file block is not available
    if(dwErrCode == ERROR_SUCCESS)
    {
        ByteOffset = FileSize - 9;
        if(!FileStream_Read(pStream, &ByteOffset, Buffer, 9))
        {
            Logger.PrintMessage("FileStream_Read from the end of the file failed");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    // Verify file position - it must be at the end of the file
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = VerifyFilePosition(&Logger, pStream, FileSize);

    // Close the stream
    if(pStream != NULL)
        FileStream_Close(pStream);
    return dwErrCode;
}

static DWORD TestArchive_LoadFiles(TLogHelper * pLogger, HANDLE hMpq, DWORD bIgnoreOpenErrors, ...)
{
    PFILE_DATA pFileData;
    const char * szFileName;
    va_list argList;
    DWORD dwSearchFlags = (bIgnoreOpenErrors) ? SEARCH_FLAG_IGNORE_ERRORS : 0;
    DWORD dwErrCode = ERROR_SUCCESS;

    va_start(argList, bIgnoreOpenErrors);
    while((szFileName = va_arg(argList, const char *)) != NULL)
    {
        if(SFileHasFile(hMpq, szFileName))
        {
            dwErrCode = LoadMpqFile(*pLogger, hMpq, szFileName, 0, dwSearchFlags, &pFileData);
            if(dwErrCode != ERROR_SUCCESS && bIgnoreOpenErrors == 0)
            {
                pLogger->PrintError("Error loading the file %s", szFileName);
                break;
            }
            else
            {
                dwErrCode = ERROR_SUCCESS;
                STORM_FREE(pFileData);
                pFileData = NULL;
            }
        }
    }
    va_end(argList);

    return dwErrCode;
}

//-----------------------------------------------------------------------------
// Testing opening an embedded archives

typedef std::vector<HANDLE> HANDLE_LIST;

static DWORD TestOpenArchive_SearchEmbedded(TLogHelper & Logger, HANDLE_LIST & Mpqs, hash_state & md5_ctx, HANDLE hParentMPQ, LPCTSTR szListFile)
{
    SFILE_FIND_DATA sf;
    HANDLE hChildMPQ;
    HANDLE hFind;
    size_t nLength;
    LPSTR szExtension;
    DWORD dwErrCode = ERROR_SUCCESS;
    bool bFound = true;

    // Hash names of all files within the archive. Go recursively.
    if((hFind = SFileFindFirstFile(hParentMPQ, "*", &sf, szListFile)) != NULL)
    {
        while(bFound)
        {
            // Add the file name to the MPQ hash
            nLength = strlen(sf.cFileName);
            md5_process(&md5_ctx, (unsigned char *)(sf.cFileName), (unsigned long)(nLength));
            Logger.FileCount++;

            // If the found file is a MPQ, then we open it as embedded MPQ
            if((szExtension = strrchr(sf.cFileName, '.')) != NULL)
            {
                if(!_stricmp(szExtension, ".mpq"))
                {
                    // Attempt to open the embedded archive
                    if(!SFileOpenFileArchive(hParentMPQ, sf.cFileName, 0, 0, &hChildMPQ))
                    {
                        Logger.PrintError("Failed to open embedded MPQ: %s", sf.cFileName);
                        break;
                    }

                    // Insert the archive handle to the list of MPQs
                    Mpqs.push_back(hChildMPQ);

                    // Recursively search the MPQ
                    dwErrCode = TestOpenArchive_SearchEmbedded(Logger, Mpqs, md5_ctx, hChildMPQ, szListFile);
                    if(dwErrCode != ERROR_SUCCESS)
                        break;
                }
            }

            bFound = SFileFindNextFile(hFind, &sf);
        }
        SFileFindClose(hFind);
    }
    else
    {
        Logger.PrintError("Failed to search the archive");
        dwErrCode = SErrGetLastError();
    }
    return dwErrCode;
}

static DWORD TestOpenArchive_Embedded(const TEST_INFO1 & MpqInfo)
{
    TLogHelper Logger("TestEmbeddedMpq", MpqInfo.szName1);
    hash_state md5_ctx;
    HANDLE_LIST Mpqs;
    HANDLE hParentMPQ = NULL;
    DWORD dwErrCode = ERROR_SUCCESS;
    TCHAR szListFile[MAX_PATH] = {0};
    BYTE md5_hash[MD5_DIGEST_SIZE];

    // Get the listfile
    if(GetExtraType(MpqInfo.pExtra) == ListFile)
        CreateFullPathName(szListFile, _countof(szListFile), szListFileDir, ((PTEST_EXTRA_ONEFILE)(MpqInfo.pExtra))->szFile);

    // Copy the archive so we won't fuck up the original one
    dwErrCode = OpenExistingArchiveWithCopy(&Logger, MpqInfo.szName1, MpqInfo.szName1, &hParentMPQ, 0);
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Search the archive for embedded MPQs
        md5_init(&md5_ctx);
        dwErrCode = TestOpenArchive_SearchEmbedded(Logger, Mpqs, md5_ctx, hParentMPQ, szListFile);
        md5_done(&md5_ctx, md5_hash);

        // Close the master MPQ first.
        // The reference counting should take care of proper memory deallocation
        SFileCloseArchive(hParentMPQ);
        hParentMPQ = NULL;

        // Now close each of the child MPQs
        for(size_t i = 0; i < Mpqs.size(); i++)
            SFileCloseArchive(Mpqs[i]);
    }

    // Verify the file count
    return VerifyFileCountAndHash(Logger, md5_hash, MpqInfo.szDataHash, MpqInfo.dwFlags, Logger.FileCount);
}

//-----------------------------------------------------------------------------
// Testing opening a single archive

static DWORD TestOpenArchive_VerifySignature(TLogHelper & Logger, HANDLE hMpq, DWORD dwDoItIfNonZero)
{
    DWORD dwSignatures = 0;
    DWORD dwVerifyError;

    // Only do it if we asked to
    if(dwDoItIfNonZero)
    {
        // Query the signature types
        Logger.PrintProgress("Retrieving signatures ...");
        TestGetFileInfo(&Logger, hMpq, SFileMpqSignatures, &dwSignatures, sizeof(DWORD), NULL, true, ERROR_SUCCESS);

        // Are there some signatures at all?
        if(dwSignatures == 0)
        {
            Logger.PrintMessage("No signatures present in the file");
            return ERROR_FILE_CORRUPT;
        }

        // Verify any of the present signatures
        Logger.PrintProgress("Verifying archive signature ...");
        dwVerifyError = SFileVerifyArchive(hMpq);

        // Verify the result
        if((dwSignatures & SIGNATURE_TYPE_STRONG) && (dwVerifyError != ERROR_STRONG_SIGNATURE_OK))
        {
            Logger.PrintMessage("Strong signature verification error");
            return ERROR_FILE_CORRUPT;
        }

        // Verify the result
        if((dwSignatures & SIGNATURE_TYPE_WEAK) && (dwVerifyError != ERROR_WEAK_SIGNATURE_OK))
        {
            Logger.PrintMessage("Weak signature verification error");
            return ERROR_FILE_CORRUPT;
        }
    }
    return ERROR_SUCCESS;
}

static DWORD TestOpenArchive_Extra_ListFile(TLogHelper & Logger, HANDLE hMpq, PTEST_EXTRA_ONEFILE pExtra)
{
    DWORD dwErrCode = ERROR_SUCCESS;
    TCHAR szFullName[MAX_PATH];

    if(IS_VALID_STRING(pExtra->szFile))
    {
        Logger.PrintProgress(_T("Adding listfile %s ..."), pExtra->szFile);
        CreateFullPathName(szFullName, _countof(szFullName), szListFileDir, pExtra->szFile);
        if((dwErrCode = SFileAddListFile(hMpq, szFullName)) != ERROR_SUCCESS)
            Logger.PrintMessage("Failed to add the listfile to the MPQ");
    }
    return dwErrCode;
}

static DWORD TestOpenArchive_Extra_Utf8File(TLogHelper & Logger, HANDLE hMpq, PTEST_EXTRA_UTF8 pExtra)
{
    DWORD dwErrCode = ERROR_SUCCESS;
    TCHAR szFullName[MAX_PATH];
    TCHAR szListName[MAX_PATH];

    if(IS_VALID_STRING(pExtra->szListFile))
    {
        StringCopy(szListName, _countof(szListName), (const char *)pExtra->szListFile);
        Logger.PrintProgress(_T("Adding listfile %s ..."), szListName);
        CreateFullPathName(szFullName, _countof(szFullName), szListFileDir, szListName);
        if((dwErrCode = SFileAddListFile(hMpq, szFullName)) != ERROR_SUCCESS)
            Logger.PrintMessage("Failed to add the listfile to the MPQ");
    }
    return dwErrCode;
}

static DWORD TestOpenArchive_Extra_TwoFiles(TLogHelper & Logger, HANDLE hMpq, DWORD dwSearchFlags, PTEST_EXTRA_TWOFILES pExtra)
{
    PFILE_DATA pFileData1 = NULL;
    PFILE_DATA pFileData2 = NULL;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Perform actions
    for(;;)
    {
        // Load and verify the first file, if any
        if(IS_VALID_STRING(pExtra->szFile1))
        {
            if((dwErrCode = LoadMpqFile(Logger, hMpq, pExtra->szFile1, 0, dwSearchFlags, &pFileData1)) != ERROR_SUCCESS)
                break;
        }

        // Load and verify the second file, if any
        if(IS_VALID_STRING(pExtra->szFile2))
        {
            if((dwErrCode = LoadMpqFile(Logger, hMpq, pExtra->szFile2, 0, dwSearchFlags, &pFileData2)) != ERROR_SUCCESS)
                break;
        }

        // If two files were given, they must be equal
        if(pFileData1 && pFileData2)
        {
            dwErrCode = CompareTwoFiles(Logger, pFileData1, pFileData2);
        }
        break;
    }

    // Free buffers and exit
    if(pFileData2 != NULL)
        STORM_FREE(pFileData2);
    if(pFileData1 != NULL)
        STORM_FREE(pFileData1);
    return dwErrCode;
}

static DWORD TestOpenArchive_Extra_Patches(TLogHelper & Logger, HANDLE hMpq, PTEST_EXTRA_PATCHES pExtra)
{
    LPCTSTR szPatch;
    TCHAR szFullPath[MAX_PATH];
    DWORD dwErrCode = ERROR_SUCCESS;

    // Open all patches that are in the multi-SZ list
    if(IS_VALID_STRING(pExtra->szPatchList))
    {
        for(szPatch = pExtra->szPatchList; szPatch[0] != 0; szPatch = szPatch + _tcslen(szPatch) + 1)
        {
            Logger.PrintProgress(_T("Adding patch %s ..."), GetShortPlainName(szPatch));
            CreateFullPathName(szFullPath, _countof(szFullPath), szMpqPatchDir, szPatch);
            if(!SFileOpenPatchArchive(hMpq, szFullPath, NULL, 0))
                return Logger.PrintError(_T("Failed to add patch %s ..."), szFullPath);
        }
    }

    // Verify the patch count of the given file
    if(IS_VALID_STRING(pExtra->szFileName))
        dwErrCode = VerifyFilePatchCount(&Logger, hMpq, pExtra->szFileName, pExtra->dwPatchCount);
    return dwErrCode;
}

static DWORD TestOpenArchive_Extra_HashValues(TLogHelper & Logger, HANDLE hMpq, PTEST_EXTRA_HASHVALS pExtra)
{
    HANDLE hFile = NULL;
    DWORD dwErrCode = ERROR_SUCCESS;
    DWORD dwHash1 = 0;
    DWORD dwHash2 = 0;
    DWORD cbHash = 0;

    for(size_t i = 0; i < _countof(pExtra->Items); i++)
    {
        PTEST_EXTRA_HASHVAL pItem = &pExtra->Items[i];

        if(SFileOpenFileEx(hMpq, pItem->szFileName, 0, &hFile))
        {
            if(SFileGetFileInfo(hFile, SFileInfoNameHash1, &dwHash1, sizeof(dwHash1), &cbHash))
            {
                assert(cbHash == sizeof(DWORD));
            }

            if(SFileGetFileInfo(hFile, SFileInfoNameHash2, &dwHash2, sizeof(dwHash2), &cbHash))
            {
                assert(cbHash == sizeof(DWORD));
            }

            if(dwHash1 != pItem->dwHash1 || dwHash2 != pItem->dwHash2)
            {
                dwErrCode = Logger.PrintError("Name hash values mismatch on %s", pItem->szFileName);
            }

            SFileCloseFile(hFile);
        }
    }
    return dwErrCode;
}

static DWORD TestOpenArchive_ExtraType(TLogHelper & Logger, HANDLE hMpq, DWORD dwSearchFlags, const void * pExtra)
{
    switch(GetExtraType(pExtra))
    {
        case ListFile:
            return TestOpenArchive_Extra_ListFile(Logger, hMpq, (PTEST_EXTRA_ONEFILE)(pExtra));

        case Utf8File:
            return TestOpenArchive_Extra_Utf8File(Logger, hMpq, (PTEST_EXTRA_UTF8)(pExtra));

        case TwoFiles:
            return TestOpenArchive_Extra_TwoFiles(Logger, hMpq, dwSearchFlags, (PTEST_EXTRA_TWOFILES)(pExtra));

        case PatchList:
            return TestOpenArchive_Extra_Patches(Logger, hMpq, (PTEST_EXTRA_PATCHES)(pExtra));

        case HashValues:
            return TestOpenArchive_Extra_HashValues(Logger, hMpq, (PTEST_EXTRA_HASHVALS)(pExtra));

        default:
            return ERROR_SUCCESS;
    }
}

static DWORD TestOpenArchive_ModifyArchive(TLogHelper & Logger, HANDLE hMpq, DWORD dwFlags)
{
    DWORD dwExpectedError;
    DWORD dwErrCode = ERROR_SUCCESS;
    TCHAR szFullPath[MAX_PATH];

    // Modify the archive, if required
    if(dwFlags & TFLG_MODIFY)
    {
        Logger.PrintProgress("Modifying archive ...");

        if(dwFlags & TFLG_BIGFILE)
        {
            dwExpectedError = (dwFlags & TFLG_WILL_FAIL) ? ERROR_DISK_FULL : ERROR_SUCCESS;

            CreateFullPathName(szFullPath, _countof(szFullPath), szDataFileDir, _T("new-file-big.mp4"));
            dwErrCode = AddLocalFileToMpq(&Logger, hMpq, "added-extra-file.mp4", szFullPath);
            dwErrCode = (dwErrCode == dwExpectedError) ? ERROR_SUCCESS : ERROR_FILE_CORRUPT;
        }
        else
        {
            dwExpectedError = (dwFlags & TFLG_READ_ONLY) ? ERROR_ACCESS_DENIED : ERROR_SUCCESS;
            dwErrCode = AddFileToMpq(&Logger, hMpq, "AddedFile01.txt", "This is a file added to signed MPQ", MPQ_FILE_COMPRESS, 0, dwExpectedError);
        }
    }
    return dwErrCode;
}

static DWORD TestOpenArchive_SignArchive(TLogHelper & Logger, HANDLE hMpq, DWORD dwDoItIfNonZero)
{
    // Sign the MPQ archive, if required
    if(dwDoItIfNonZero)
    {
        Logger.PrintProgress("Signing the MPQ ...");
        if(!SFileSignArchive(hMpq, SIGNATURE_TYPE_WEAK))
        {
            Logger.PrintMessage("Failed to create archive signature");
            return ERROR_FILE_CORRUPT;
        }
    }
    return ERROR_SUCCESS;
}

static DWORD TestOpenArchive_GetFileInfo(TLogHelper & Logger, HANDLE hMpq, DWORD dwFlags)
{
    if(dwFlags & TFLG_GET_FILE_INFO)
    {
        TMPQHeader Header = {0};
        HANDLE hFile = NULL;
        DWORD dwExpectedError;
        DWORD cbLength;
        BYTE DataBuff[0x400];

        // Retrieve the version of the MPQ
        Logger.PrintProgress("Checking SFileGetFileInfo");
        SFileGetFileInfo(hMpq, SFileMpqHeader, &Header, sizeof(TMPQHeader), NULL);

        // Test on invalid archive/file handle
        TestGetFileInfo(&Logger, NULL, SFileMpqBetHeader,  NULL, 0, NULL, false, ERROR_INVALID_HANDLE);
        TestGetFileInfo(&Logger, NULL, SFileInfoInvalid,   NULL, 0, NULL, false, ERROR_INVALID_HANDLE);
        TestGetFileInfo(&Logger, NULL, SFileInfoNameHash1, NULL, 0, NULL, false, ERROR_INVALID_HANDLE);

        // Valid handle but all parameters NULL
        dwExpectedError = (Header.wFormatVersion == MPQ_FORMAT_VERSION_4) ? ERROR_INSUFFICIENT_BUFFER : ERROR_FILE_NOT_FOUND;
        TestGetFileInfo(&Logger, hMpq, SFileMpqBetHeader, NULL, 0, NULL, false, dwExpectedError);
        TestGetFileInfo(&Logger, hMpq, SFileMpqBetHeader, NULL, 0, &cbLength, false, dwExpectedError);

        // When we call SFileInfo with buffer = NULL and nonzero buffer size, it is ignored
        TestGetFileInfo(&Logger, hMpq, SFileMpqBetHeader, NULL, 3, &cbLength, false, dwExpectedError);

        // When we call SFileInfo with buffer != NULL and nonzero buffer size, it should return error
        TestGetFileInfo(&Logger, hMpq, SFileMpqBetHeader, DataBuff, 3, &cbLength, false, dwExpectedError);

        // Request for bet table header should also succeed if we want header only
        dwExpectedError = (Header.wFormatVersion == MPQ_FORMAT_VERSION_4) ? ERROR_SUCCESS : ERROR_FILE_NOT_FOUND;
        TestGetFileInfo(&Logger, hMpq, SFileMpqBetHeader, DataBuff, sizeof(TMPQBetHeader), &cbLength, (dwExpectedError == ERROR_SUCCESS), dwExpectedError);
        TestGetFileInfo(&Logger, hMpq, SFileMpqBetHeader, DataBuff, sizeof(DataBuff), &cbLength, (dwExpectedError == ERROR_SUCCESS), dwExpectedError);

        // Try to retrieve strong signature from the MPQ
        dwExpectedError = (Header.wFormatVersion == MPQ_FORMAT_VERSION_4) ? ERROR_FILE_NOT_FOUND : ERROR_INSUFFICIENT_BUFFER;
        TestGetFileInfo(&Logger, hMpq, SFileMpqStrongSignature, NULL, 0, NULL, false, dwExpectedError);
        TestGetFileInfo(&Logger, hMpq, SFileMpqStrongSignature, NULL, 0, &cbLength, false, dwExpectedError);
        if(Header.wFormatVersion == MPQ_FORMAT_VERSION_1)
            assert(cbLength == MPQ_STRONG_SIGNATURE_SIZE + 4);

        // Retrieve the signature
        dwExpectedError = (Header.wFormatVersion == MPQ_FORMAT_VERSION_4) ? ERROR_FILE_NOT_FOUND : ERROR_SUCCESS;
        TestGetFileInfo(&Logger, hMpq, SFileMpqStrongSignature, DataBuff, sizeof(DataBuff), &cbLength, (dwExpectedError == ERROR_SUCCESS), dwExpectedError);
        if(Header.wFormatVersion == MPQ_FORMAT_VERSION_1)
            assert(memcmp(DataBuff, "NGIS", 4) == 0);

        // Check SFileGetFileInfo on a listfile
        if(SFileOpenFileEx(hMpq, LISTFILE_NAME, 0, &hFile))
        {
            TestGetFileInfo(&Logger, hMpq, SFileInfoFileTime, DataBuff, sizeof(DataBuff), &cbLength, false, ERROR_INVALID_HANDLE);
            TestGetFileInfo(&Logger, hFile, SFileInfoFileTime, DataBuff, sizeof(DataBuff), &cbLength, true, ERROR_SUCCESS);
            SFileCloseFile(hFile);
        }
    }
    return ERROR_SUCCESS;
}

static DWORD TestOpenArchive(
    LPCTSTR szMpqName1,                             // (UTF-8) Name of the MPQ
    LPCTSTR szMpqName2,                             // (UTF-8) Name of the MPQ (original name or name of a copy)
    LPCSTR szExpectedHash,                          // Expected name+data hash
    DWORD dwFlags,                                  // Test flags. Lower bits contains the number of files
    const void * pExtra)                            // Extra parameter
{
    TLogHelper Logger("TestReadingMpq", szMpqName1);
    HANDLE hMpq = NULL;
    DWORD dwExpectedFileCount = 0;
    DWORD dwSearchFlags = 0;
    DWORD dwOpenFlags = 0;
    DWORD dwMpqFlags = 0;
    DWORD dwErrCode;
    TCHAR szMpqNameBuff[MAX_PATH];

    // Propagate the open MPQ flags from the input
    dwOpenFlags |= (dwFlags & TFLG_WILL_FAIL) ? MPQ_OPEN_DONT_REPORT_FAILURE : 0;
    dwOpenFlags |= (dwFlags & TFLG_READ_ONLY) ? STREAM_FLAG_READ_ONLY : 0;

    // Shall we switch the name of the MPQ?
    szMpqName1 = SwapMpqName(szMpqNameBuff, _countof(szMpqNameBuff), szMpqName1, (PTEST_EXTRA_UTF8)(pExtra));

    // If the file is a partial MPQ, don't load all files
    if(_tcsstr(szMpqName1, _T(".MPQ.part")) == NULL)
        dwSearchFlags |= SEARCH_FLAG_LOAD_FILES;

    // If we shall hash the files, do it
    if(IS_VALID_STRING(szExpectedHash))
    {
        dwExpectedFileCount = (dwFlags & TFLG_VALUE_MASK);
        dwSearchFlags |= SEARCH_FLAG_HASH_FILES;
    }

    // Copy the archive so we won't fuck up the original one
    dwErrCode = OpenExistingArchiveWithCopy(&Logger, szMpqName1, szMpqName2, &hMpq, dwOpenFlags);
    while(dwErrCode == ERROR_SUCCESS)
    {
        // Check for malformed MPQs
        SFileGetFileInfo(hMpq, SFileMpqFlags, &dwMpqFlags, sizeof(dwMpqFlags), NULL);
        dwSearchFlags |= (dwMpqFlags & MPQ_FLAG_MALFORMED) ? SEARCH_FLAG_IGNORE_ERRORS : 0;
        dwSearchFlags |= (GetExtraType(pExtra) == PatchList) ? SEARCH_FLAG_IGNORE_ERRORS : 0;

        // Verify signature before any changes
        if((dwErrCode = TestOpenArchive_VerifySignature(Logger, hMpq, (dwFlags & TFLG_SIGCHECK_BEFORE))) != ERROR_SUCCESS)
            break;

        // Perform extra action, dependent on the data passed
        if((dwErrCode = TestOpenArchive_ExtraType(Logger, hMpq, dwSearchFlags, pExtra)) != ERROR_SUCCESS)
            break;

        // Modify the archive, if required
        if((dwErrCode = TestOpenArchive_ModifyArchive(Logger, hMpq, dwFlags)) != ERROR_SUCCESS)
            break;

        // Sign the archive, if needed
        if((dwErrCode = TestOpenArchive_SignArchive(Logger, hMpq, (dwFlags & TFLG_SIGN_ARCHIVE))) != ERROR_SUCCESS)
            break;

        // Test the SFileGetFileInfo, if required
        if((dwErrCode = TestOpenArchive_GetFileInfo(Logger, hMpq, dwFlags)) != ERROR_SUCCESS)
            break;

        // Verify signature after any changes
        if((dwErrCode = TestOpenArchive_VerifySignature(Logger, hMpq, (dwFlags & TFLG_SIGCHECK_AFTER))) != ERROR_SUCCESS)
            break;

        // Attempt to open the (listfile), (attributes), (signature)
        if((TestArchive_LoadFiles(&Logger, hMpq, (dwMpqFlags & MPQ_FLAG_MALFORMED), LISTFILE_NAME, ATTRIBUTES_NAME, SIGNATURE_NAME, NULL)) != ERROR_SUCCESS)
            break;

        // If required, we search the archive and compare file cound and name hash
        if((dwErrCode = VerifyDataChecksum(Logger, hMpq, dwSearchFlags, szExpectedHash, dwExpectedFileCount)) != ERROR_SUCCESS)
            break;

        break;
    }

    // Reset error code, if the failure is expected
    if((dwErrCode != ERROR_SUCCESS || hMpq == NULL) && (dwFlags & TFLG_WILL_FAIL))
        SErrSetLastError(dwErrCode = ERROR_SUCCESS);

    // Cleanup and exit
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    return Logger.PrintVerdict(dwErrCode);
}

static DWORD TestOpenArchive(const TEST_INFO1 & TestInfo)
{
    return TestOpenArchive(TestInfo.szName1,            // Name of the MPQ
                           TestInfo.szName2,            // Name of the listfile or NULL
                           TestInfo.szDataHash,         // Compound name+data hash
                           TestInfo.dwFlags,            // Test flags
                           TestInfo.pExtra);            // Extra parameter
}

//-----------------------------------------------------------------------------
// Reopening archives

static void WINAPI CompactCallback(void * pvUserData, DWORD dwWork, ULONGLONG BytesDone, ULONGLONG TotalBytes)
{
    TLogHelper * pLogger = (TLogHelper *)pvUserData;
    LPCSTR szWork = NULL;

    switch(dwWork)
    {
        case CCB_CHECKING_FILES:
            szWork = "Checking files in archive";
            break;

        case CCB_CHECKING_HASH_TABLE:
            szWork = "Checking hash table";
            break;

        case CCB_COPYING_NON_MPQ_DATA:
            szWork = "Copying non-MPQ data";
            break;

        case CCB_COMPACTING_FILES:
            szWork = "Compacting files";
            break;

        case CCB_CLOSING_ARCHIVE:
            szWork = "Closing archive";
            break;
    }

    if(szWork != NULL)
    {
        if(pLogger != NULL)
            pLogger->PrintProgress("%s " fmt_X_of_Y_a " ...", szWork, BytesDone, TotalBytes);
        else
            printf("%s " fmt_X_of_Y_a " ...     \r", szWork, BytesDone, TotalBytes);
    }
}

static DWORD TestReopenArchive_CompactArchive(TLogHelper & Logger, HANDLE hMpq, DWORD dwFlags)
{
    if(dwFlags & TFLG_COMPACT)
    {
        // Set the compact callback
        Logger.PrintProgress("Compacting archive ...");
        if(!SFileSetCompactCallback(hMpq, CompactCallback, &Logger))
            return Logger.PrintError("Failed to set the compact callback");

        // Compact the archive
        if(!SFileCompactArchive(hMpq, NULL, false))
            return Logger.PrintError("Failed to compact archive");
    }
    return ERROR_SUCCESS;
}

static DWORD TestReopenArchive(
    LPCTSTR szMpqName1,                             // Name of the MPQ
    LPCSTR szExpectedHash,                          // Expected name+data hash
    DWORD dwFlags)                                  // Test flags. Lower bits contains the number of files
{
    TLogHelper Logger("Test_ReopenMpq", szMpqName1);
    ULONGLONG PreMpqDataSize = (dwFlags & TFLG_ADD_USER_DATA) ? 0x400 : 0;
    ULONGLONG UserDataSize = (dwFlags & TFLG_ADD_USER_DATA) ? 0x531 : 0;
    LPCTSTR szCopyName = _T("StormLibTest_Reopened.mpq");
    HANDLE hMpq;
    DWORD dwExpectedFileCount = 0;
    DWORD dwSearchFlags = SEARCH_FLAG_LOAD_FILES;
    TCHAR szFullPath[MAX_PATH];
    DWORD dwErrCode;

    // If we shall hash the files, do it
    if(IS_VALID_STRING(szExpectedHash))
    {
        dwExpectedFileCount = (dwFlags & TFLG_VALUE_MASK);
        dwSearchFlags |= SEARCH_FLAG_HASH_FILES;
    }

    // Create copy of the archive, with interleaving some user data
    dwErrCode = CreateFileCopy(&Logger, szMpqName1, szCopyName, szFullPath, _countof(szFullPath), PreMpqDataSize, UserDataSize);

    // Open the archive and read the hash of the files
    if(dwErrCode == ERROR_SUCCESS)
    {
        if((dwErrCode = OpenExistingArchive(&Logger, szFullPath, 0, &hMpq)) == ERROR_SUCCESS)
        {
            // Verify presence of (listfile) and (attributes)
            CheckIfFileIsPresent(&Logger, hMpq, LISTFILE_NAME, (dwFlags & TFLG_HAS_LISTFILE));
            CheckIfFileIsPresent(&Logger, hMpq, ATTRIBUTES_NAME, (dwFlags & TFLG_HAS_ATTRIBUTES));

            // If required, we search the archive and compare file cound and name hash
            dwErrCode = VerifyDataChecksum(Logger, hMpq, dwSearchFlags, szExpectedHash, dwExpectedFileCount);
            SFileCloseArchive(hMpq);
        }
    }

    // Try to modify and/or compact the MPQ
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Open the archive again
        if((dwErrCode = OpenExistingArchive(&Logger, szFullPath, 0, &hMpq)) == ERROR_SUCCESS)
        {
            // Modify the archive, if required
            if((dwErrCode = TestOpenArchive_ModifyArchive(Logger, hMpq, dwFlags)) == ERROR_SUCCESS)
            {
                dwErrCode = TestReopenArchive_CompactArchive(Logger, hMpq, dwFlags);
            }
            SFileCloseArchive(hMpq);
        }
    }

    // Open the archive and load some files
    if((dwErrCode == ERROR_SUCCESS) && STORMLIB_TEST_FLAGS(dwFlags, TFLG_COMPACT | TFLG_MODIFY | TFLG_BIGFILE, TFLG_COMPACT))
    {
        // Open the archive
        if((dwErrCode = OpenExistingArchive(&Logger, szFullPath, 0, &hMpq)) == ERROR_SUCCESS)
        {
            // Verify presence of (listfile) and (attributes)
            CheckIfFileIsPresent(&Logger, hMpq, LISTFILE_NAME, (dwFlags & TFLG_HAS_LISTFILE));
            CheckIfFileIsPresent(&Logger, hMpq, ATTRIBUTES_NAME, (dwFlags & TFLG_HAS_ATTRIBUTES));

            // Search the archive and load every file
            dwErrCode = VerifyDataChecksum(Logger, hMpq, dwSearchFlags, szExpectedHash, dwExpectedFileCount);
        }
        SFileCloseArchive(hMpq);
    }
    return dwErrCode;
}

static DWORD TestOpenArchive_SignatureTest(LPCTSTR szPlainName, LPCTSTR szOriginalName, DWORD dwFlags)
{
    TLogHelper Logger("Test_Signature", szPlainName);
    HANDLE hMpq;
    DWORD dwCreateFlags = MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES | MPQ_FORMAT_VERSION_1;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Create a new archive or copy existing
    if(dwFlags & SFLAG_CREATE_ARCHIVE)
    {
        dwCreateFlags |= (dwFlags & SFLAG_SIGN_AT_CREATE) ? MPQ_CREATE_SIGNATURE : 0;
        dwErrCode = CreateNewArchive_V2(&Logger, szPlainName, dwCreateFlags, 4000, &hMpq);
    }
    else
    {
        szOriginalName = (szOriginalName) ? szOriginalName : szPlainName;
        dwErrCode = OpenExistingArchiveWithCopy(&Logger, szPlainName, szOriginalName, &hMpq);
    }

    // Continue with archive signature tests
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Shall we check the signatures before modifications?
        if(dwErrCode == ERROR_SUCCESS)
        {
            dwErrCode = TestOpenArchive_VerifySignature(Logger, hMpq, (dwFlags & SFLAG_VERIFY_BEFORE));
        }

        // Shall we modify the archive?
        if(dwErrCode == ERROR_SUCCESS)
        {
            dwErrCode = TestOpenArchive_ModifyArchive(Logger, hMpq, (dwFlags & SFLAG_MODIFY_ARCHIVE));
        }

        // Shall we sign the archive?
        if(dwErrCode == ERROR_SUCCESS)
        {
            dwErrCode = TestOpenArchive_SignArchive(Logger, hMpq, (dwFlags & SFLAG_SIGN_ARCHIVE));
        }

        // Shall we check the signatures after modifications?
        if(dwErrCode == ERROR_SUCCESS)
        {
            dwErrCode = TestOpenArchive_VerifySignature(Logger, hMpq, (dwFlags & SFLAG_VERIFY_AFTER));
        }

        SFileCloseArchive(hMpq);
    }
    return dwErrCode;
}

static DWORD TestCreateArchive(LPCTSTR szPlainName, LPCSTR szFileName, DWORD dwFlags)
{
    TLogHelper Logger("CreateNewMpq", szPlainName);
    HANDLE hMpq = NULL;
    DWORD dwMaxFileCount = dwFlags & 0x0000FFFF;
    DWORD dwCreateFlags = 0;
    DWORD dwFileCount = 0;
    DWORD dwErrCode;

    // Fixup the MPQ format
    dwCreateFlags |= (dwFlags & CFLG_EMPTY) ? 0 : MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES;
    dwCreateFlags |= (dwFlags & CFLG_V2) ? MPQ_CREATE_ARCHIVE_V2 : 0;
    dwCreateFlags |= (dwFlags & CFLG_V4) ? MPQ_CREATE_ARCHIVE_V4 : 0;

    // Create the full path name
    dwErrCode = CreateNewArchive(&Logger, szPlainName, dwCreateFlags, dwMaxFileCount, &hMpq);
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Add non-standard names, if needed
        if(dwFlags & CFLG_NONSTD_NAMES)
        {
            // Add few files and close the archive
            AddFileToMpq(&Logger, hMpq, "AddedFile000.txt", "This is the file data 000.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\\/\\/\\/\\AddedFile001.txt", "This is the file data 001.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\\\\\\\\\\\\\\\\", "This is the file data 002.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "////////////////", "This is the file data 003.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "//\\//\\//\\//\\", "This is the file data 004.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "................", "This is the file data 005.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "//****//****//****//****.***", "This is the file data 006.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "//*??*//*??*//*??*//?**?.?*?", "This is the file data 007.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\\/\\/File.txt", "This is the file data 008.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\\/\\/File.txt..", "This is the file data 009.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "Dir1\\Dir2\\Dir3\\File.txt..", "This is the file data 010.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\\Dir1\\Dir2\\Dir3\\File.txt..", "This is the file data 011.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\\\\Dir1\\\\Dir2\\\\Dir3\\\\File.txt..", "This is the file data 012.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "/Dir1/Dir2/Dir3/File.txt..", "This is the file data 013.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "////Dir1////Dir2////Dir3////File.txt..", "This is the file data 014.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\\//\\Dir1\\//\\Dir2\\//\\File.txt..", "This is the file data 015.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\x10\x11\x12\x13\\\x14\x15\x16\x17\\\x18\x19\x1a\x1b\\\x1c\x1D\x1E\x1F.txt", "This is the file data 016.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\x09\x20\x09\x20\\\x20\x09\x20\x09\\\x09\x20\x09\x20\\\x20\x09\x20\x09.txt", "This is the file data 017.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "\x80\x91\xA2\xB3\\\xC4\xD5\xE6\xF7\\\x80\x91\xA2\xB3.txt", "This is the file data 018.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "Dir1\x20\x09\x20\\Dir2\x20\x09\x20\\File.txt\x09\x09\x20\x2e", "This is the file data 019.", MPQ_FILE_COMPRESS);
            AddFileToMpq(&Logger, hMpq, "Dir1\x20\x09\x20\\Dir2\x20\x09\x20\\\x09\x20\x2e\x09\x20\x2e", "This is the file data 020.", MPQ_FILE_COMPRESS);
        }

        // Like MPQEditor: Flush archive, add one file, flush again
        if(dwFlags & CFLG_MPQEDITOR)
        {
            SFileFlushArchive(hMpq);
            dwErrCode = AddFileToMpq(&Logger, hMpq, szFileName, "This is the file data.", MPQ_FILE_COMPRESS);
            SFileFlushArchive(hMpq);
        }

        // Search the archive
        SearchArchive(&Logger, hMpq);
        SFileCloseArchive(hMpq);
    }

    // Reopen the empty MPQ
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = OpenExistingArchiveWithCopy(&Logger, NULL, szPlainName, &hMpq);
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Retrieve the number of files
            SFileGetFileInfo(hMpq, SFileMpqNumberOfFiles, &dwFileCount, sizeof(dwFileCount), NULL);

            // Special check for empty MPQs
            if(dwFlags & CFLG_EMPTY)
            {
                if(dwFileCount != 0)
                    dwErrCode = ERROR_FILE_CORRUPT;
                CheckIfFileIsPresent(&Logger, hMpq, "File00000000.xxx", false);
                CheckIfFileIsPresent(&Logger, hMpq, LISTFILE_NAME, false);
                SearchArchive(&Logger, hMpq);
            }
            else
            {
                if(dwFileCount == 0)
                    dwErrCode = ERROR_FILE_CORRUPT;
            }

            // Close the MPQ
            SFileCloseArchive(hMpq);
        }
    }

    return dwErrCode;
}

static DWORD TestCreateArchive(const TEST_INFO2 & TestInfo)
{
    TCHAR szPlainNameT[MAX_PATH];

    // Always prefix the archive name with "StormLibTest_"
    StringCopy(szPlainNameT, _countof(szPlainNameT), "StormLibTest_");
    StringCat(szPlainNameT, _countof(szPlainNameT), TestInfo.szName1);

    // Perform creation of the archive
    return TestCreateArchive(szPlainNameT, TestInfo.szName2, TestInfo.dwFlags);
}

static DWORD TestRenameFile(LPCTSTR szPlainName)
{
    TLogHelper Logger("TestRenameFile", szPlainName);
    LPCSTR szSourceFile = "war3map.mmp";
    LPCSTR szTargetFile = "war3map.wts";
    HANDLE hMpq = NULL;
    DWORD dwErrCode;
    DWORD dwFailed = 0;
    LCID LCID_RURU = 0x0419;
    LCID LCID_ESES = 0x040A;

    // Create copy of the archive and open it
    dwErrCode = OpenExistingArchiveWithCopy(&Logger, szPlainName, szPlainName, &hMpq);
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Try to rename an existing file to "war3map.wts".
        // This must fail because the file already exists.
        if(SFileRenameFile(hMpq, szSourceFile, szTargetFile))
            dwFailed++;

        // Now change locale of an existing file to Russian
        if(SetLocaleForFileOperations(hMpq, szSourceFile, LCID_RURU) != ERROR_SUCCESS)
            dwFailed++;

        // The rename should work now
        if(!SFileRenameFile(hMpq, szSourceFile, szTargetFile))
            dwFailed++;

        // Changing the file locale to Neutral should fail now,
        // because such file already exists
        if(SetLocaleForFileOperations(hMpq, szTargetFile, 0) != ERROR_ALREADY_EXISTS)
            dwFailed++;

        // Pick another source file
        szSourceFile = "war3map.shd";

        // Change the file locale to Spain
        if(SetLocaleForFileOperations(hMpq, szSourceFile, LCID_ESES) != ERROR_SUCCESS)
            dwFailed++;

        // This rename should also work, because there is no target file with Spanish locale
        if(!SFileRenameFile(hMpq, szSourceFile, szTargetFile))
            dwFailed++;

        // Evaluate the result
        if(dwFailed != 0)
            dwErrCode = ERROR_CAN_NOT_COMPLETE;
        SFileCloseArchive(hMpq);
    }

    // Restore the original file locale
    SFileSetLocale(LANG_NEUTRAL);
    return dwErrCode;
}

static DWORD TestCreateArchive_TestGaps(LPCTSTR szPlainName)
{
    TLogHelper Logger("TestCreateGaps", szPlainName);
    ULONGLONG ByteOffset1 = 0xFFFFFFFF;
    ULONGLONG ByteOffset2 = 0xEEEEEEEE;
    HANDLE hMpq = NULL;
    HANDLE hFile = NULL;
    TCHAR szFullPath[MAX_PATH];
    DWORD dwErrCode = ERROR_SUCCESS;

    // Create new MPQ
    dwErrCode = CreateNewArchive_V2(&Logger, szPlainName, MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES | MPQ_FORMAT_VERSION_4, 4000, &hMpq);
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Add one file and flush the archive
        dwErrCode = AddFileToMpq(&Logger, hMpq, "AddedFile01.txt", "This is the file data.", MPQ_FILE_COMPRESS);
        SFileCloseArchive(hMpq);
        hMpq = NULL;
    }

    // Reopen the MPQ and add another file.
    // The new file must be added to the position of the (listfile)
    if(dwErrCode == ERROR_SUCCESS)
    {
        CreateFullPathName(szFullPath, _countof(szFullPath), NULL, szPlainName);
        dwErrCode = OpenExistingArchive(&Logger, szFullPath, 0, &hMpq);
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Retrieve the position of the (listfile)
            if(SFileOpenFileEx(hMpq, LISTFILE_NAME, 0, &hFile))
            {
                SFileGetFileInfo(hFile, SFileInfoByteOffset, &ByteOffset1, sizeof(ULONGLONG), NULL);
                SFileCloseFile(hFile);
            }
            else
                dwErrCode = SErrGetLastError();
        }
    }

    // Add another file and check its position. It must be at the position of the former listfile
    if(dwErrCode == ERROR_SUCCESS)
    {
        LPCSTR szAddedFile = "AddedFile02.txt";

        // Add another file
        dwErrCode = AddFileToMpq(&Logger, hMpq, szAddedFile, "This is the second added file.", MPQ_FILE_COMPRESS);

        // Retrieve the position of the (listfile)
        if(SFileOpenFileEx(hMpq, szAddedFile, 0, &hFile))
        {
            SFileGetFileInfo(hFile, SFileInfoByteOffset, &ByteOffset2, sizeof(ULONGLONG), NULL);
            SFileCloseFile(hFile);
        }
        else
            dwErrCode = SErrGetLastError();
    }

    // Now check the positions
    if(dwErrCode == ERROR_SUCCESS)
    {
        if(ByteOffset1 != ByteOffset2)
        {
            Logger.PrintError("The added file was not written to the position of (listfile)");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    // Close the archive if needed
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    return dwErrCode;
}

static DWORD TestCreateArchive_FillArchive(LPCTSTR szPlainName, DWORD dwCreateFlags)
{
    TLogHelper Logger("TestCreateFull", szPlainName);
    LPCSTR szFileData = "TestCreateArchive_FillArchive: Testing file data";
    char szFileName[MAX_PATH];
    HANDLE hMpq = NULL;
    DWORD dwMaxFileCount = 6;
    DWORD dwCompression = MPQ_COMPRESSION_ZLIB;
    DWORD dwFlags = MPQ_FILE_ENCRYPTED | MPQ_FILE_COMPRESS;
    DWORD dwErrCode;

    //
    // Note that StormLib will round the maxfile count
    // up to hash table size (nearest power of two)
    //
    if((dwCreateFlags & MPQ_CREATE_LISTFILE) == 0)
        dwMaxFileCount++;
    if((dwCreateFlags & MPQ_CREATE_ATTRIBUTES) == 0)
        dwMaxFileCount++;

    // Create the new MPQ archive
    dwErrCode = CreateNewArchive_V2(&Logger, szPlainName, dwCreateFlags, dwMaxFileCount, &hMpq);
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Flush the archive first
        SFileFlushArchive(hMpq);

        // Add all files
        for(unsigned int i = 0; i < dwMaxFileCount; i++)
        {
            sprintf(szFileName, "AddedFile%03u.txt", i);
            dwErrCode = AddFileToMpq(&Logger, hMpq, szFileName, szFileData, dwFlags, dwCompression);
            if(dwErrCode != ERROR_SUCCESS)
                break;
        }

        // Flush the archive again
        SFileFlushArchive(hMpq);
    }

    // Now the MPQ should be full. It must not be possible to add another file
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = AddFileToMpq(&Logger, hMpq, "ShouldNotBeHere.txt", szFileData, MPQ_FILE_COMPRESS, MPQ_COMPRESSION_ZLIB, ERROR_DISK_FULL);
        assert(dwErrCode != ERROR_SUCCESS);
        dwErrCode = ERROR_SUCCESS;
    }

    // Close the archive to enforce saving all tables
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    hMpq = NULL;

    // Reopen the archive again
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = OpenExistingArchiveWithCopy(&Logger, NULL, szPlainName, &hMpq);

    // The archive should still be full
    if(dwErrCode == ERROR_SUCCESS)
    {
        CheckIfFileIsPresent(&Logger, hMpq, LISTFILE_NAME, (dwCreateFlags & MPQ_CREATE_LISTFILE) ? true : false);
        CheckIfFileIsPresent(&Logger, hMpq, ATTRIBUTES_NAME, (dwCreateFlags & MPQ_CREATE_ATTRIBUTES) ? true : false);
        dwErrCode = AddFileToMpq(&Logger, hMpq, "ShouldNotBeHere.txt", szFileData, MPQ_FILE_COMPRESS, MPQ_COMPRESSION_ZLIB, ERROR_DISK_FULL);
        assert(dwErrCode != ERROR_SUCCESS);
        dwErrCode = ERROR_SUCCESS;
    }

    // The (listfile) and (attributes) must be present
    if(dwErrCode == ERROR_SUCCESS)
    {
        CheckIfFileIsPresent(&Logger, hMpq, LISTFILE_NAME, (dwCreateFlags & MPQ_CREATE_LISTFILE) ? true : false);
        CheckIfFileIsPresent(&Logger, hMpq, ATTRIBUTES_NAME, (dwCreateFlags & MPQ_CREATE_ATTRIBUTES) ? true : false);
        dwErrCode = RemoveMpqFile(&Logger, hMpq, szFileName, ERROR_SUCCESS);
    }

    // Now add the file again. This time, it should be possible OK
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = AddFileToMpq(&Logger, hMpq, szFileName, szFileData, dwFlags, dwCompression, ERROR_SUCCESS);
        assert(dwErrCode == ERROR_SUCCESS);
    }

    // Now add the file again. This time, it should fail
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = AddFileToMpq(&Logger, hMpq, szFileName, szFileData, dwFlags, dwCompression, ERROR_ALREADY_EXISTS);
        assert(dwErrCode != ERROR_SUCCESS);
        dwErrCode = ERROR_SUCCESS;
    }

    // Now add the file again. This time, it should fail
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = AddFileToMpq(&Logger, hMpq, "ShouldNotBeHere.txt", szFileData, dwFlags, dwCompression, ERROR_DISK_FULL);
        assert(dwErrCode != ERROR_SUCCESS);
        dwErrCode = ERROR_SUCCESS;
    }

    // Close the archive and return
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    hMpq = NULL;

    // Reopen the archive for the third time to verify that both internal files are there
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = OpenExistingArchiveWithCopy(&Logger, NULL, szPlainName, &hMpq);
        if(dwErrCode == ERROR_SUCCESS)
        {
            CheckIfFileIsPresent(&Logger, hMpq, LISTFILE_NAME, (dwCreateFlags & MPQ_CREATE_LISTFILE) ? true : false);
            CheckIfFileIsPresent(&Logger, hMpq, ATTRIBUTES_NAME, (dwCreateFlags & MPQ_CREATE_ATTRIBUTES) ? true : false);
            SFileCloseArchive(hMpq);
        }
    }

    return dwErrCode;
}

static DWORD TestCreateArchive_IncMaxFileCount(LPCTSTR szPlainName)
{
    TLogHelper Logger("IncMaxFileCount", szPlainName);
    LPCSTR szFileData = "TestCreateArchive_IncMaxFileCount: Testing file data";
    char szFileName[MAX_PATH];
    HANDLE hMpq = NULL;
    DWORD dwMaxFileCount = 1;
    DWORD dwErrCode;

    // Create the new MPQ
    dwErrCode = CreateNewArchive(&Logger, szPlainName, MPQ_CREATE_ARCHIVE_V4 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES, dwMaxFileCount, &hMpq);

    // Now add exactly one file
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = AddFileToMpq(&Logger, hMpq, "AddFile_base.txt", szFileData);
        SFileFlushArchive(hMpq);
        SFileCloseArchive(hMpq);
    }

    // Now add 10 files. Each time we cannot add the file due to archive being full,
    // we increment the max file count
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(unsigned int i = 0; i < 10; i++)
        {
            // Open the archive again
            dwErrCode = OpenExistingArchiveWithCopy(&Logger, NULL, szPlainName, &hMpq);
            if(dwErrCode != ERROR_SUCCESS)
                break;

            // Add one file
            sprintf(szFileName, "AddFile_%04u.txt", i);
            dwErrCode = AddFileToMpq(&Logger, hMpq, szFileName, szFileData, 0, 0, ERROR_UNDETERMINED_RESULT);
            if(dwErrCode != ERROR_SUCCESS)
            {
                // Increment the max file count by one
                dwMaxFileCount = SFileGetMaxFileCount(hMpq) + 1;
                Logger.PrintProgress("Increasing max file count to %u ...", dwMaxFileCount);
                SFileSetMaxFileCount(hMpq, dwMaxFileCount);

                // Attempt to create the file again
                dwErrCode = AddFileToMpq(&Logger, hMpq, szFileName, szFileData, 0, 0, ERROR_SUCCESS);
            }

            // Compact the archive and close it
            SFileSetCompactCallback(hMpq, CompactCallback, &Logger);
            SFileCompactArchive(hMpq, NULL, false);
            SFileCloseArchive(hMpq);
            if(dwErrCode != ERROR_SUCCESS)
                break;
        }
    }

    return dwErrCode;
}

static DWORD TestCreateArchive_FileFlagTest(LPCTSTR szPlainName)
{
    TLogHelper Logger("TestFileFlag", szPlainName);
    HANDLE hMpq = NULL;                 // Handle of created archive
    TCHAR szFileName1[MAX_PATH];
    TCHAR szFileName2[MAX_PATH];
    TCHAR szFullPath[MAX_PATH];
    LPCSTR szMiddleFile = "FileTest_10.exe";
    LCID LocaleIDs[] = {0x000, 0x405, 0x406, 0x407};
    char szArchivedName[MAX_PATH];
    DWORD dwMaxFileCount = 0;
    DWORD dwFileCount = 0;
    DWORD dwErrCode;

    // Create paths for local file to be added
    CreateFullPathName(szFileName1, _countof(szFileName1), szDataFileDir, _T("new-file.exe"));
    CreateFullPathName(szFileName2, _countof(szFileName2), szDataFileDir, _T("new-file.bin"));
    SFileSetLocale(LANG_NEUTRAL);

    // Create an empty file that will serve as holder for the MPQ
    dwErrCode = CreateEmptyFile(&Logger, szPlainName, 0x100000, szFullPath);

    // Create new MPQ archive over that file
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = CreateNewArchive(&Logger, szPlainName, MPQ_CREATE_ARCHIVE_V1 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES, 17, &hMpq);

    // Add the same file multiple times
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwMaxFileCount = SFileGetMaxFileCount(hMpq);
        for(size_t i = 0; AddFlags[i] != 0xFFFFFFFF; i++)
        {
            sprintf(szArchivedName, "FileTest_%02u.exe", (unsigned int)i);
            dwErrCode = AddLocalFileToMpq(&Logger, hMpq, szArchivedName, szFileName1, AddFlags[i], 0);
            if(dwErrCode != ERROR_SUCCESS)
                break;

            dwFileCount++;
        }
    }

    // Delete a file in the middle of the file table
    if(dwErrCode == ERROR_SUCCESS)
    {
        Logger.PrintProgress("Removing file %s ...", szMiddleFile);
        dwErrCode = RemoveMpqFile(&Logger, hMpq, szMiddleFile, ERROR_SUCCESS);
        dwFileCount--;
    }

    // Add one more file
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = AddLocalFileToMpq(&Logger, hMpq, "FileTest_xx.exe", szFileName1);
        dwFileCount++;
    }

    // Try to decrement max file count. This must succeed
    if(dwErrCode == ERROR_SUCCESS)
    {
        Logger.PrintProgress("Attempting to decrement max file count ...");
        if(SFileSetMaxFileCount(hMpq, 5))
            dwErrCode = Logger.PrintError("Max file count decremented, even if it should fail");
    }

    // Add ZeroSize.txt several times under a different locale
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(LocaleIDs); i++)
        {
            bool bMustSucceed = ((dwFileCount + 2) < dwMaxFileCount);

            SFileSetLocale(LocaleIDs[i]);
            dwErrCode = AddLocalFileToMpq(&Logger, hMpq, "ZeroSize_1.txt", szFileName2);
            if(dwErrCode != ERROR_SUCCESS)
            {
                if(bMustSucceed == false)
                    dwErrCode = ERROR_SUCCESS;
                break;
            }

            dwFileCount++;
        }
    }

    // Add ZeroSize.txt again several times under a different locale
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; LocaleIDs[i] != 0xFFFF; i++)
        {
            bool bMustSucceed = ((dwFileCount + 2) < dwMaxFileCount);

            SFileSetLocale(LocaleIDs[i]);
            dwErrCode = AddLocalFileToMpq(&Logger, hMpq, "ZeroSize_2.txt", szFileName2, 0, 0, bMustSucceed);
            if(dwErrCode != ERROR_SUCCESS)
            {
                if(bMustSucceed == false)
                    dwErrCode = ERROR_SUCCESS;
                break;
            }

            dwFileCount++;
        }
    }

    // Verify how many files did we add to the MPQ
    if(dwErrCode == ERROR_SUCCESS)
    {
        if(dwFileCount + 2 != dwMaxFileCount)
        {
            Logger.PrintErrorVa("Number of files added to MPQ was unexpected (expected %u, added %u)", dwFileCount, dwMaxFileCount - 2);
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    // Test rename function
    if(dwErrCode == ERROR_SUCCESS)
    {
        Logger.PrintProgress("Testing rename files ...");
        SFileSetLocale(LANG_NEUTRAL);
        if(!SFileRenameFile(hMpq, "FileTest_08.exe", "FileTest_08a.exe"))
            dwErrCode = Logger.PrintError("Failed to rename the file");
    }

    if(dwErrCode == ERROR_SUCCESS)
    {
        if(!SFileRenameFile(hMpq, "FileTest_08a.exe", "FileTest_08.exe"))
            dwErrCode = Logger.PrintError("Failed to rename the file");
    }

    if(dwErrCode == ERROR_SUCCESS)
    {
        if(SFileRenameFile(hMpq, "FileTest_10.exe", "FileTest_10a.exe"))
        {
            Logger.PrintError("Rename test succeeded even if it shouldn't");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    if(dwErrCode == ERROR_SUCCESS)
    {
        if(SFileRenameFile(hMpq, "FileTest_10a.exe", "FileTest_10.exe"))
        {
            Logger.PrintError("Rename test succeeded even if it shouldn't");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    // Close the archive
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    hMpq = NULL;

    // Try to reopen the archive
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = OpenExistingArchive(&Logger, szFullPath, 0, NULL);
    return dwErrCode;
}

static DWORD TestCreateArchive_WaveCompressionsTest(LPCTSTR szPlainName, LPCTSTR szWaveFile)
{
    TLogHelper Logger("TestCompressions", szPlainName);
    HANDLE hMpq = NULL;                 // Handle of created archive
    TCHAR szFileName[MAX_PATH];         // Source file to be added
    char szArchivedName[MAX_PATH];
    DWORD dwCmprCount = sizeof(WaveCompressions) / sizeof(DWORD);
    DWORD dwAddedFiles = 0;
    DWORD dwFoundFiles = 0;
    DWORD dwErrCode;

    // Create paths for local file to be added
    CreateFullPathName(szFileName, _countof(szFileName), szDataFileDir, szWaveFile);

    // Create new archive
    dwErrCode = CreateNewArchive(&Logger, szPlainName, MPQ_CREATE_ARCHIVE_V1 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES, 0x40, &hMpq);

    // Add the same file multiple times
    if(dwErrCode == ERROR_SUCCESS)
    {
        Logger.UserTotal = dwCmprCount;
        for(unsigned int i = 0; i < dwCmprCount; i++)
        {
            sprintf(szArchivedName, "WaveFile_%02u.wav", i + 1);
            dwErrCode = AddLocalFileToMpq(&Logger, hMpq, szArchivedName, szFileName, MPQ_FILE_COMPRESS | MPQ_FILE_ENCRYPTED | MPQ_FILE_SECTOR_CRC, WaveCompressions[i]);
            if(dwErrCode != ERROR_SUCCESS)
                break;

            Logger.UserCount++;
            dwAddedFiles++;
        }

        SFileCloseArchive(hMpq);
    }

    // Reopen the archive extract each WAVE file and try to play it
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = OpenExistingArchiveWithCopy(&Logger, NULL, szPlainName, &hMpq);
        if(dwErrCode == ERROR_SUCCESS)
        {
            SearchArchive(&Logger, hMpq, SEARCH_FLAG_LOAD_FILES | SEARCH_FLAG_PLAY_WAVES, &dwFoundFiles, NULL);
            SFileCloseArchive(hMpq);
        }

        // Check if the number of found files is the same like the number of added files
        // DOn;t forget that there will be (listfile) and (attributes)
        if(dwFoundFiles != (dwAddedFiles + 2))
        {
            Logger.PrintError("Number of found files does not match number of added files.");
            dwErrCode = ERROR_FILE_CORRUPT;
        }
    }

    return dwErrCode;
}

static DWORD TestCreateArchive_ListFilePos(LPCTSTR szPlainName)
{
    PFILE_DATA pFileData;
    LPCSTR szReaddedFile = "AddedFile_##.txt";
    LPCSTR szFileMask = "AddedFile_%02u.txt";
    TLogHelper Logger("ListFilePos", szPlainName);
    HANDLE hMpq = NULL;                 // Handle of created archive
    char szArchivedName[MAX_PATH];
    DWORD dwMaxFileCount = 0x0E;
    DWORD dwFileCount = 0;
    size_t i;
    DWORD dwErrCode;

    // Create a new archive with the limit of 0x20 files
    dwErrCode = CreateNewArchive(&Logger, szPlainName, MPQ_CREATE_ARCHIVE_V4 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES, dwMaxFileCount, &hMpq);

    // Add maximum files files
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(i = 0; i < dwMaxFileCount; i++)
        {
            sprintf(szArchivedName, szFileMask, i);
            dwErrCode = AddFileToMpq(&Logger, hMpq, szArchivedName, "This is a text data.", 0, 0, ERROR_SUCCESS);
            if(dwErrCode != ERROR_SUCCESS)
                break;

            dwFileCount++;
        }
    }

    // Delete few middle files
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(i = 0; i < (dwMaxFileCount / 2); i++)
        {
            sprintf(szArchivedName, szFileMask, i);
            dwErrCode = RemoveMpqFile(&Logger, hMpq, szArchivedName, ERROR_SUCCESS);
            if(dwErrCode != ERROR_SUCCESS)
                break;

            dwFileCount--;
        }
    }

    // Close the archive
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    hMpq = NULL;

    // Reopen the archive to catch any asserts
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = OpenExistingArchiveWithCopy(&Logger, NULL, szPlainName, &hMpq);

    // Check that (listfile) is at the end
    if(dwErrCode == ERROR_SUCCESS)
    {
        if(LoadMpqFile(Logger, hMpq, LISTFILE_NAME, 0, 0, &pFileData) == ERROR_SUCCESS)
        {
            if(pFileData->dwBlockIndex < dwFileCount)
                Logger.PrintMessage("Unexpected file index of %s", LISTFILE_NAME);
            STORM_FREE(pFileData);
        }

        if(LoadMpqFile(Logger, hMpq, ATTRIBUTES_NAME, 0, 0, &pFileData) == ERROR_SUCCESS)
        {
            if(pFileData->dwBlockIndex <= dwFileCount)
                Logger.PrintMessage("Unexpected file index of %s", ATTRIBUTES_NAME);
            STORM_FREE(pFileData);
        }

        // Add new file to the archive. It should be added to the last position
        dwErrCode = AddFileToMpq(&Logger, hMpq, szReaddedFile, "This is a re-added file.", 0, 0, ERROR_SUCCESS);
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Force update of the tables
            SFileFlushArchive(hMpq);

            // Load the file
            if(LoadMpqFile(Logger, hMpq, szReaddedFile, 0, 0, &pFileData) == ERROR_SUCCESS)
            {
                if(pFileData->dwBlockIndex != dwFileCount)
                    Logger.PrintMessage("Unexpected file index of %s", szReaddedFile);
                STORM_FREE(pFileData);
            }
        }

        SFileCloseArchive(hMpq);
    }

    return dwErrCode;
}

static DWORD TestCreateArchive_BigArchive(LPCTSTR szPlainName)
{
    TLogHelper Logger("TestBigArchive", szPlainName);
    HANDLE hMpq = NULL;                 // Handle of created archive
    TCHAR szLocalFileName[MAX_PATH];
    char szArchivedName[MAX_PATH];
    DWORD dwMaxFileCount = 0x20;
    DWORD dwAddedCount = 0;
    size_t i;
    DWORD dwErrCode;

    // Create a new archive with the limit of 0x20 files
    dwErrCode = CreateNewArchive(&Logger, szPlainName, MPQ_CREATE_ARCHIVE_V3 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES, dwMaxFileCount, &hMpq);
    if(dwErrCode == ERROR_SUCCESS)
    {
        LPCSTR szFileMask = "AddedFile_%02u.txt";

        // Now add few really big files
        CreateFullPathName(szLocalFileName, _countof(szLocalFileName), szMpqSubDir, _T("MPQ_1997_v1_Diablo1_DIABDAT.MPQ"));
        Logger.UserTotal = (dwMaxFileCount / 2);

        for(i = 0; i < dwMaxFileCount / 2; i++)
        {
            sprintf(szArchivedName, szFileMask, i + 1);
            dwErrCode = AddLocalFileToMpq(&Logger, hMpq, szArchivedName, szLocalFileName, 0, 0, true);
            if(dwErrCode != ERROR_SUCCESS)
                break;

            Logger.UserCount++;
            dwAddedCount++;
        }
    }

    // Close the archive
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    hMpq = NULL;

    // Reopen the archive to catch any asserts
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = OpenExistingArchiveWithCopy(&Logger, NULL, szPlainName, &hMpq);

    // Check that (listfile) is at the end
    if(dwErrCode == ERROR_SUCCESS)
    {
        CheckIfFileIsPresent(&Logger, hMpq, LISTFILE_NAME, true);
        CheckIfFileIsPresent(&Logger, hMpq, ATTRIBUTES_NAME, true);

        SFileCloseArchive(hMpq);
    }

    return dwErrCode;
}

// Test replacing a file in an archive
static DWORD TestReplaceFile(LPCTSTR szMpqPlainName, LPCTSTR szFilePlainName, LPCSTR szFileFlags, DWORD dwCompression)
{
    TLogHelper Logger("TestModifyMpq", szMpqPlainName);
    HANDLE hMpq = NULL;
    TCHAR szFileFullName[MAX_PATH];
    TCHAR szMpqFullName[MAX_PATH];
    char szArchivedName[MAX_PATH];
    DWORD dwErrCode;
    DWORD dwFileFlags = (DWORD)(DWORD_PTR)(szFileFlags);        // szFileFlags is a file flags cast to LPCSTR
    BYTE md5_file_in_mpq1[MD5_DIGEST_SIZE];
    BYTE md5_file_in_mpq2[MD5_DIGEST_SIZE];
    BYTE md5_file_in_mpq3[MD5_DIGEST_SIZE];
    BYTE md5_file_local[MD5_DIGEST_SIZE];

    // Get the name of archived file as plain text. If the file shall be in a subfolder,
    // its name must contain a hashtag, e.g. "staredit#scenario.chk"
    StringCopy(szArchivedName, _countof(szArchivedName), szFilePlainName);
    for(size_t i = 0; szArchivedName[i] != 0; i++)
        szArchivedName[i] = (szArchivedName[i] == '#') ? '\\' : szArchivedName[i];

    // Get the full path of the archive and local file
    CreateFullPathName(szFileFullName, _countof(szFileFullName), szDataFileDir, szFilePlainName);
    CreateFullPathName(szMpqFullName, _countof(szMpqFullName), NULL, szMpqPlainName);
    dwFileFlags |= MPQ_FILE_REPLACEEXISTING | MPQ_FILE_COMPRESS;

    // Open an existing archive
    dwErrCode = OpenExistingArchiveWithCopy(&Logger, szMpqPlainName, szMpqPlainName, &hMpq);

    // Open the file, load to memory, calculate hash
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = LoadMpqFileMD5(Logger, hMpq, szArchivedName, md5_file_in_mpq1);
    }

    // Open the local file, calculate hash
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = LoadLocalFileMD5(&Logger, szFileFullName, md5_file_local);
    }

    // Add the given file
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Add the file to MPQ
        dwErrCode = AddLocalFileToMpq(&Logger, hMpq,
                                               szArchivedName,
                                               szFileFullName,
                                               dwFileFlags,
                                               dwCompression,
                                               true);
    }

    // Load the file from the MPQ again and compare both MD5's
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Load the file from the MPQ again
        dwErrCode = LoadMpqFileMD5(Logger, hMpq, szArchivedName, md5_file_in_mpq2);
        if(dwErrCode == ERROR_SUCCESS)
        {
            // New MPQ file must be different from the old one
            if(!memcmp(md5_file_in_mpq2, md5_file_in_mpq1, MD5_DIGEST_SIZE))
            {
                Logger.PrintError("Data mismatch after adding the file \"%s\"", szArchivedName);
                dwErrCode = ERROR_CHECKSUM_ERROR;
            }

            // New MPQ file must be identical to the local one
            if(memcmp(md5_file_in_mpq2, md5_file_local, MD5_DIGEST_SIZE))
            {
                Logger.PrintError("Data mismatch after adding the file \"%s\"", szArchivedName);
                dwErrCode = ERROR_CHECKSUM_ERROR;
            }
        }
    }

    // Compact the MPQ
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Compact the archive
        Logger.PrintProgress("Compacting archive %s ...", szMpqPlainName);
        if(!SFileSetCompactCallback(hMpq, CompactCallback, &Logger))
            dwErrCode = Logger.PrintError(_T("Failed to compact archive %s"), szMpqPlainName);

        // Some test archives (like MPQ_2022_v1_v4.329.w3x) can't be compacted.
        // For that reason, we ignore the result of SFileCompactArchive().
        SFileCompactArchive(hMpq, NULL, 0);
        SFileCloseArchive(hMpq);
        hMpq = NULL;
    }

    // Try to open the archive again. Ignore the previous errors
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = OpenExistingArchive(&Logger, szMpqFullName, 0, &hMpq);
        if(dwErrCode == ERROR_SUCCESS)
        {
            // Load the file from the MPQ again
            dwErrCode = LoadMpqFileMD5(Logger, hMpq, szArchivedName, md5_file_in_mpq3);
            if(dwErrCode == ERROR_SUCCESS)
            {
                // New MPQ file must be the same like the local one
                if(memcmp(md5_file_in_mpq3, md5_file_local, MD5_DIGEST_SIZE))
                {
                    Logger.PrintError("Data mismatch after adding the file \"%s\"", szArchivedName);
                    dwErrCode = ERROR_CHECKSUM_ERROR;
                }
            }

            SFileCloseArchive(hMpq);
            hMpq = NULL;
        }
    }

    // Finally, close the archive
    if(hMpq != NULL)
        SFileCloseArchive(hMpq);
    return dwErrCode;
}

static bool TestUtfConversion(const void * lpString)
{
    LPTSTR szBuffer;
    LPBYTE pbBuffer;
    size_t nLength1 = 0;
    size_t nLength2 = 0;
    DWORD dwErrCode1;
    DWORD dwErrCode2;
    TCHAR szWideBuffer[1];
    BYTE szByteBuffer[1];
    int nResult;

    // Get the number of bytes of the buffer while the output buffer is 0
    dwErrCode1 = SMemUTF8ToFileName(NULL, 0, lpString, NULL, 0, &nLength1);

    // Check the number of bytes when the buffer is non-NULL, but buffer length is insufficient
    dwErrCode2 = SMemUTF8ToFileName(szWideBuffer, _countof(szWideBuffer), lpString, NULL, 0, &nLength2);
    ASSERT_TRUE(dwErrCode2 == dwErrCode1);
    ASSERT_TRUE(nLength2 == nLength1);

    // Check the number of bytes when the buffer is non-NULL, and buffer length is sufficient
    if((szBuffer = STORM_ALLOC(TCHAR, nLength1)) != NULL)
    {
        dwErrCode2 = SMemUTF8ToFileName(szBuffer, nLength1, lpString, NULL, 0, &nLength2);
        ASSERT_TRUE(dwErrCode2 == dwErrCode1);
        ASSERT_TRUE(nLength2 == nLength1);

        // Get the number of bytes of the buffer while the output buffer is 0
        dwErrCode1 = SMemFileNameToUTF8(NULL, 0, szBuffer, NULL, 0, &nLength1);

        // Check the number of bytes when the buffer is non-NULL, but buffer length is insufficient
        dwErrCode2 = SMemFileNameToUTF8(szByteBuffer, _countof(szByteBuffer), szBuffer, NULL, 0, &nLength2);
        ASSERT_TRUE(dwErrCode2 == dwErrCode1);
        ASSERT_TRUE(nLength2 == nLength1);

        // Check the conversion into a buffer large enough
        if((pbBuffer = STORM_ALLOC(BYTE, nLength1)) != NULL)
        {
            dwErrCode2 = SMemFileNameToUTF8(pbBuffer, nLength1, szBuffer, NULL, 0, &nLength2);
            ASSERT_TRUE(dwErrCode2 == dwErrCode1);
            ASSERT_TRUE(nLength2 == nLength1);

            nResult = memcmp(pbBuffer, lpString, nLength1);
            ASSERT_TRUE(nResult == 0);

            STORM_FREE(pbBuffer);
        }

        STORM_FREE(szBuffer);
    }
    return true;
}

static DWORD TestUtf8Conversions(const BYTE * szTestString, const TCHAR * szListFile)
{
    SFILE_FIND_DATA sf;
    HANDLE hFind;
    TCHAR szFullPath[MAX_PATH];

    // Check conversion of the invalid UTF8 string
    TestUtfConversion(szTestString);

    // Create full path of the listfile
    CreateFullPathName(szFullPath, _countof(szFullPath), szListFileDir, szListFile);

    // Test all file names in the Chinese listfile
    if(szListFile && szListFile[0])
    {
        hFind = SListFileFindFirstFile(NULL, szFullPath, "*", &sf);
        if(hFind != NULL)
        {
            while(SListFileFindNextFile(hFind, &sf))
            {
                if(!TestUtfConversion(sf.cFileName))
                {
                    return ERROR_INVALID_DATA;
                }
            }
            SListFileFindClose(hFind);
        }
    }
    return ERROR_SUCCESS;
}

static DWORD TestUseAfterFree(LPCTSTR szPlainName)
{
    TLogHelper Logger("TestUseAfterFree", szPlainName);
    HANDLE hMpq;
    HANDLE hFile;
    DWORD dwErrCode;

    // Create new archive
    dwErrCode = CreateNewArchive(&Logger, szPlainName, MPQ_CREATE_ARCHIVE_V1 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES, 32, &hMpq);
    if(dwErrCode == ERROR_SUCCESS)
    {
        SFileCreateFile(hMpq, "foo", 0ULL, 8, 0, 0, &hFile);
        SFileCloseArchive(hMpq);
        SFileCloseFile(hFile);
    }

    dwErrCode = CreateNewArchive(&Logger, szPlainName, MPQ_CREATE_ARCHIVE_V1 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES, 32, &hMpq);
    if(dwErrCode == ERROR_SUCCESS)
    {
        if(SFileCreateFile(hMpq, "foo", 0ULL, 8, 0, 0, &hFile))
        {
            char nameBuf[260];

            SFileSetMaxFileCount(hMpq, 64);
            SFileGetFileName(hFile, nameBuf);
            SFileCloseFile(hFile);
        }
        SFileCloseArchive(hMpq);
    }
    return dwErrCode;
}

//-----------------------------------------------------------------------------
// Tables

static LPCTSTR szSigned1 = _T("STANDARD.SNP");
static LPCTSTR szSigned2 = _T("StarDat.mpq");
static LPCTSTR szSigned3 = _T("War2Patch_202.exe");
static LPCTSTR szSigned4 = _T("(10)DustwallowKeys.w3m");
static LPCTSTR szSigned5 = _T("WoW-1.2.3.4211-enUS-patch.exe");
static LPCTSTR szSigned6 = _T("WoW-1.11.2.5464-to-1.12.0.5595-enUS-patch.exe");
static LPCTSTR szSigned7 = _T("WoW-3.0.1.8337-to-3.0.1.8392-enGB-patch.exe");
static LPCTSTR szSigned8 = _T("wow-final.MPQ");

static LPCTSTR szDiabdatMPQ = _T("MPQ_1997_v1_Diablo1_DIABDAT.MPQ");

static const TEST_EXTRA_ONEFILE  LfBliz = {ListFile, _T("ListFile_Blizzard.txt")};
static const TEST_EXTRA_ONEFILE  LfWotI = {ListFile, _T("ListFile_WarOfTheImmortals.txt")};
static const TEST_EXTRA_ONEFILE  LfBad1 = {ListFile, _T("ListFile_UTF8_Bad.txt")};

static const BYTE szMpqFileNameUTF8[] = {0x4D, 0x50, 0x51, 0x5F, 0x32, 0x30, 0x32, 0x34, 0x5F, 0x76, 0x31, 0x5F, 0xE6, 0x9D, 0x82, 0xE9, 0xB1, 0xBC, 0xE5, 0x9C, 0xB0, 0xE7, 0x89, 0xA2, 0x5F, 0x30, 0x2E, 0x30, 0x38, 0x34, 0x62, 0x65, 0x74, 0x61, 0x34, 0x36, 0x2E, 0x77, 0x33, 0x78, 0x00};
static const BYTE szLstFileNameUTF8[] = {0x4C, 0x69, 0x73, 0x74, 0x46, 0x69, 0x6C, 0x65, 0x5F, 0xE6, 0x9D, 0x82, 0xE9, 0xB1, 0xBC, 0xE5, 0x9C, 0xB0, 0xE7, 0x89, 0xA2, 0x5F, 0x30, 0x2E, 0x30, 0x38, 0x34, 0x62, 0x65, 0x74, 0x61, 0x34, 0x36, 0x2E, 0x74, 0x78, 0x74, 0x00};

static const BYTE FileNameInvalidUTF8[] =
{
//  Hexadecimal                    Binary                                   UTF-16      String
//  ----                           ---------------------------------        ------      ------
    0x7c,                   // --> 01111100                             --> 0x007c      %u[7cb7]
    0xb7,                   // --> 10110111(bad)                        --> 0xfffd
    0xc9, 0xb7,             // --> 11001001 10110111                    --> 0x0277      \x0277
    0xc9, /* ca */          // --> 11001001 11001010(bad)               --> 0xfffd      %u[c9cac0bde7]
    0xca, /* c0 */          // --> 11001010 11000000(bad)               --> 0xfffd
    0xc0, /* bd */          // --> 11000000 10111101(bad)               --> 0x003d(bad)
    0xbd,                   // --> 10111101(bad)                        --> 0xfffd
    0xe7, /* c4 */          // --> 11100111 11000100(bad)               --> 0xfffd
    0xc4, 0xa7,             // --> 11000100 10100111                    --> 0x0127      \x0127
    0xca, /* de */          // --> 11001010 11011110(bad)               --> 0xfffd      %ca
    0xde, 0xbb,             // --> 11011110 10111011                    --> 0x07bb      \x07bb
    0xb6,                   // --> 10110110(bad)                        --> 0xfffd      %b6
    0xd3, 0xad,             // --> 11010011 10101101                    --> 0x04ed      \x04ed
    0xc4, /* fa */          // --> 11000100 11111010(bad)               --> 0xfffd      %u[c4fa]
    0xfa, /* 5f */          // --> 11111010 01011111(bad)               --> 0xfffd
    0x5f,                   // --> 01011111                             --> 0x005f      _
    0xa1,                   // --> 10100001(bad)                        --> 0xfffd      %u[a1eea1f0a1ef]
    0xee, /* a1 f0 */       // --> 11101110 10100001 11110000(bad)      --> 0xfffd
    0xa1,                   // --> 10100001(bad)                        --> 0xfffd
    0xf0, /* a1 ef */       // --> 11110000 10100001 11101111(bad)      --> 0xfffd
    0xa1,                   // --> 10100001(bad)                        --> 0xfffd
    0xef, /* 5f */          // --> 11101111 01011111(bad)               --> 0xfffd
    0x5f,                   // --> 01011111                             --> 0x005f      _
    0xf0, /* 80 80 80 */    // --> 11110000 10000000 10000000 10000000  --> 0x0000(bad) %u[f0808080]
    0x80,                   // --> 10000000(bad)                        --> 0xfffd
    0x80,                   // --> 10000000(bad)                        --> 0xfffd
    0x80,                   // --> 10000000(bad)                        --> 0xfffd
    0xe9, 0xa3, 0x9e,       // --> 11101001 10100011 10011110           --> 0x98de      \x98de
    0xe4, 0xb8, 0x96,       // --> 11100100 10111000 10010110           --> 0x4e16      \x4e16
    0xe7, 0x95, 0x8c,       // --> 11100111 10010101 10001100           --> 0x754c      \x754c
    0xe9, 0xad, 0x94,       // --> 11101001 10101101 10010100           --> 0x9b54      \x9b54
    0xe5, 0x85, 0xbd,       // --> 11100101 10000101 10111101           --> 0x517d      \x517d
    0xe6, 0xac, 0xa2,       // --> 11100110 10101100 10100010           --> 0x6b22      \x6b22
    0xe8, 0xbf, 0x8e,       // --> 11101000 10111111 10001110           --> 0x8fce      \x8fce
    0xe6, 0x82, 0xa8,       // --> 11100110 10000010 10101000           --> 0x60a8      \x60a8
    0x2e,                   // --> 00101110                             --> 0x002e      \x002e
    0x6d, 0x64, 0x78,       // --> 01101101 01100100 01111000           --> ".mdx"
    0x00                    // --> 00000000                             --> EOS
};

static const BYTE FileNameInvalidChar[] = "units/Orc/HealingWard/Rune2.blp";

static const TEST_EXTRA_UTF8 MpqUtf8 = {Utf8File, szMpqFileNameUTF8, szLstFileNameUTF8};

static const TEST_EXTRA_TWOFILES TwoFilesD1  = {TwoFiles, "music\\dintro.wav", "File00000023.xxx"};
static const TEST_EXTRA_TWOFILES TwoFilesD2  = {TwoFiles, "waitingroombkgd.dc6"};
static const TEST_EXTRA_TWOFILES TwoFilesW3M = {TwoFiles, "file00000002.blp"};
static const TEST_EXTRA_TWOFILES TwoFilesW3X = {TwoFiles, "BlueCrystal.mdx"};

static const TEST_EXTRA_HASHVALS HashVals =
{
    HashValues,
    {
        {0x00000000, 0x00000000, "File00024483.blp"},
        {0x8bd6929a, 0xfd55129b, "ReplaceableTextures\\CommandButtons\\BTNHaboss79.blp"}
    }
};

static const TEST_EXTRA_PATCHES PatchSC1 =
{
    PatchList,
    _T("s1-1998-BroodWar.mpq\0"),
    "music\\terran1.wav",
    0
};

static const TEST_EXTRA_PATCHES PatchBETA =
{
    PatchList,
    _T("wow-08-beta-patch.mpq\0"),
    "Creature\\GnomeSpidertank\\FlameLickSmallBlue.blp",
    0
};


static const TEST_EXTRA_PATCHES Patch13286 =
{
    PatchList,
    _T("wow-update-oldworld-13154.MPQ\0")
    _T("wow-update-oldworld-13286.MPQ\0"),
    "OldWorld\\World\\Model.blob",
    2
};

static const TEST_EXTRA_PATCHES Patch15050 =
{
    PatchList,
    _T("wow-update-13164.MPQ\0")
    _T("wow-update-13205.MPQ\0")
    _T("wow-update-13287.MPQ\0")
    _T("wow-update-13329.MPQ\0")
    _T("wow-update-13596.MPQ\0")
    _T("wow-update-13623.MPQ\0")
    _T("wow-update-base-13914.MPQ\0")
    _T("wow-update-base-14007.MPQ\0")
    _T("wow-update-base-14333.MPQ\0")
    _T("wow-update-base-14480.MPQ\0")
    _T("wow-update-base-14545.MPQ\0")
    _T("wow-update-base-14946.MPQ\0")
    _T("wow-update-base-15005.MPQ\0")
    _T("wow-update-base-15050.MPQ\0"),
    "World\\Model.blob",
    8
};

static const TEST_EXTRA_PATCHES Patch16965 =
{
    PatchList,
    _T("wow-update-enGB-16016.MPQ\0")
    _T("wow-update-enGB-16048.MPQ\0")
    _T("wow-update-enGB-16057.MPQ\0")
    _T("wow-update-enGB-16309.MPQ\0")
    _T("wow-update-enGB-16357.MPQ\0")
    _T("wow-update-enGB-16516.MPQ\0")
    _T("wow-update-enGB-16650.MPQ\0")
    _T("wow-update-enGB-16844.MPQ\0")
    _T("wow-update-enGB-16965.MPQ\0"),
    "DBFilesClient\\BattlePetNPCTeamMember.db2",
    0
};

static const TEST_EXTRA_PATCHES Patch32283 =
{
    PatchList,
    _T("s2-update-base-23258.MPQ\0")
    _T("s2-update-base-24540.MPQ\0")
    _T("s2-update-base-26147.MPQ\0")
    _T("s2-update-base-28522.MPQ\0")
    _T("s2-update-base-30508.MPQ\0")
    _T("s2-update-base-32283.MPQ\0"),
    "TriggerLibs\\natives.galaxy",
    6
};

static const TEST_EXTRA_PATCHES Patch32283a =
{
    PatchList,
    _T("s2-update-enGB-23258.MPQ\0")
    _T("s2-update-enGB-24540.MPQ\0")
    _T("s2-update-enGB-26147.MPQ\0")
    _T("s2-update-enGB-28522.MPQ\0")
    _T("s2-update-enGB-30508.MPQ\0")
    _T("s2-update-enGB-32283.MPQ\0"),
    "Assets\\Textures\\startupimage.dds",
    0
};

static const TEST_EXTRA_PATCHES Patch34644 =
{
    PatchList,
    _T("s2-update-base-23258.MPQ\0")
    _T("s2-update-base-24540.MPQ\0")
    _T("s2-update-base-26147.MPQ\0")
    _T("s2-update-base-28522.MPQ\0")
    _T("s2-update-base-32384.MPQ\0")
    _T("s2-update-base-34644.MPQ\0"),
    "TriggerLibs\\GameData\\GameData.galaxy",
    2
};

static const TEST_EXTRA_PATCHES Patch34644m =
{
    PatchList,
    _T("s2-update-base-23258.MPQ\0")
    _T("s2-update-base-24540.MPQ\0")
    _T("s2-update-base-26147.MPQ\0")
    _T("s2-update-base-28522.MPQ\0")
    _T("s2-update-base-32384.MPQ\0")
    _T("s2-update-base-34644.MPQ\0"),
    "Maps\\Campaign\\THorner03.SC2Map\\BankList.xml",
    3
};

static const TEST_EXTRA_PATCHES Patch36281 =
{
    PatchList,
    _T("s2-update-enGB-23258.MPQ\0")
    _T("s2-update-enGB-24540.MPQ\0")
    _T("s2-update-enGB-26147.MPQ\0")
    _T("s2-update-enGB-28522.MPQ\0")
    _T("s2-update-enGB-32384.MPQ\0")
    _T("s2-update-enGB-34644.MPQ\0")
    _T("s2-update-enGB-36281.MPQ\0"),
    "LocalizedData\\GameHotkeys.txt",
    6
};

static const TEST_EXTRA_PATCHES PatchH3604 =
{
    PatchList,
    _T("hs-0-3604-Win-final.MPQ\0"),
    "Hearthstone.exe",
    1
};

static const TEST_EXTRA_PATCHES PatchH6898 =
{
    PatchList,
    _T("hs-0-5314-Win-final.MPQ\0")
    _T("hs-5314-5435-Win-final.MPQ\0")
    _T("hs-5435-5506-Win-final.MPQ\0")
    _T("hs-5506-5834-Win-final.MPQ\0")
    _T("hs-5834-6024-Win-final.MPQ\0")
    _T("hs-6024-6141-Win-final.MPQ\0")
    _T("hs-6141-6187-Win-final.MPQ\0")
    _T("hs-6187-6284-Win-final.MPQ\0")
    _T("hs-6284-6485-Win-final.MPQ\0")
    _T("hs-6485-6898-Win-final.MPQ\0"),
    "Hearthstone_Data\\Managed\\Assembly-Csharp.dll",
    10
};

static const TEST_INFO1 TestList_StreamOps[] =
{
    {_T("MPQ_2013_v4_alternate-original.MPQ"),                  NULL, NULL, 0},
    {_T("MPQ_2013_v4_alternate-original.MPQ"),                  NULL, NULL, STREAM_FLAG_READ_ONLY},
    {_T("MPQ_2013_v4_alternate-complete.MPQ"),                  NULL, NULL, STREAM_FLAG_USE_BITMAP},
    {_T("part-file://MPQ_2009_v2_WoW_patch.MPQ.part"),          NULL, NULL, 0},
    {_T("blk4-file://streaming/model.MPQ.0"),                   NULL, NULL, STREAM_PROVIDER_BLOCK4},
    {_T("mpqe-file://MPQ_2011_v2_EncryptedMpq.MPQE"),           NULL, NULL, STREAM_PROVIDER_MPQE}
};

static const TEST_INFO1 TestList_MasterMirror[] =
{
    {_T("part-file://MPQ_2009_v1_patch-created.MPQ.part"),      _T("MPQ_2009_v1_patch-original.MPQ"),       NULL, 0},
    {_T("part-file://MPQ_2009_v1_patch-partial.MPQ.part"),      _T("MPQ_2009_v1_patch-original.MPQ"),       NULL, 1},
    {_T("part-file://MPQ_2009_v1_patch-complete.MPQ.part"),     _T("MPQ_2009_v1_patch-original.MPQ"),       NULL, 1},
    {_T("MPQ_2013_v4_alternate-created.MPQ"),                   _T("MPQ_2013_v4_alternate-original.MPQ"),   NULL, 0},
    {_T("MPQ_2013_v4_alternate-incomplete.MPQ"),                _T("MPQ_2013_v4_alternate-incomplete.MPQ"), NULL, 1},
    {_T("MPQ_2013_v4_alternate-complete.MPQ"),                  _T("MPQ_2013_v4_alternate-original.MPQ"),   NULL, 1},

    // Takes hell a lot of time!!!
//  {_T("MPQ_2013_v4_alternate-downloaded.MPQ"),                _T("http://www.zezula.net\\mpqs\\alternate.zip"), NULL, 0}
};

static const TEST_INFO1 TestList_EmbeddedMpqs[] =
{
    {_T("MPQ_1997_v1_Diablo1_DIABDAT.MPQ"),                     NULL, "9110e9b7e27e81eae9eed0dcd45b9013",  3942, &LfBliz},
    {_T("MPQ_2001_v1_War3.mpq"),                                NULL, "264d7397baf89ea14fd0a673a251e297", 11390}
};

static const TEST_INFO1 TestList_OpenMpqs[] =
{

    // PoC's by Gabe Sherman, tinh0, Zao Yang
    {_T("pocs/MPQ_2024_01_HeapOverrun.mpq"),                    NULL, "7008f95dcbc4e5d840830c176dec6969",    14},
    {_T("pocs/MPQ_2024_02_StackOverflow.mpq"),                  NULL, "7093fcbcc9674b3e152e74e8e8a937bb",     4},
    {_T("pocs/MPQ_2024_03_TooBigAlloc.mpq"),                    NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2024_04_HeapOverflow.mpq"),                   NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2024_05_HeapOverflow.mpq"),                   NULL, "0539ae020719654a0ea6e2627a8195f8",    14},
    {_T("pocs/MPQ_2024_06_HeapOverflowReadFile.mpq"),           NULL, "d41d8cd98f00b204e9800998ecf8427e",     1},
    {_T("pocs/MPQ_2024_07_InvalidBitmapFooter.mpq"),            NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2024_08_InvalidSectorSize.mpq"),              NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2024_09_InvalidSectorSize.mpq"),              NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2024_10_HuffDecompressError.mpq"),            NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2024_10_SparseDecompressError.mpq"),          NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2024_11_HiBlockTablePosInvalid.mpq"),         NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2025_01_SectorTableBeyondEOF.mpq"),           NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2025_02_SectorOffsetSizeNotAligned.mpq"),     NULL, "0cc175b9c0f1b6a831c399e269772661",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2025_03_InvalidPatchInfo.mpq"),               NULL, "93b885adfe0da089cdf634904fd59f71",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2025_04_InvalidArchiveSize64.mpq"),           NULL, "--------------------------------",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2025_05_AddFileError.mpq"),                   NULL, "ce9b8afed4221a53663d391f10691ba6",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2025_06_BadHashTableSize.mpq"),               NULL, "00000000000000000000000000000000",     TFLG_WILL_FAIL},
    {_T("pocs/MPQ_2025_07_BadHetTableSize.mpq"),                NULL, "00000000000000000000000000000000",     TFLG_WILL_FAIL},

    // Correct or damaged archives
    {_T("MPQ_1997_v1_Diablo1_DIABDAT.MPQ"),                     NULL, "554b538541e42170ed41cb236483489e",  2910, &TwoFilesD1},  // Base MPQ from Diablo 1
    {_T("MPQ_1997_v1_patch_rt_SC1B.mpq"),                       NULL, "43fe7d362955be68a708486e399576a7",    10},               // From Starcraft 1 BETA
    {_T("MPQ_1997_v1_StarDat_SC1B.mpq"),                        NULL, "0094b23f28cfff7386071ef3bd19a577",  2468},               // From Starcraft 1 BETA
    {_T("MPQ_1997_v1_INSTALL_SC1B.EXE_"),                       NULL, "3248460c89bb6f8e3b8fc3e08de7ffbb",    79},               // From Starcraft 1 BETA
    {_T("MPQ_2016_v1_D2XP_IX86_1xx_114a.mpq"),                  NULL, "255d87a62f3c9518f72cf723a1818946",   221, &TwoFilesD2},  // Update MPQ from Diablo II (patch 2016)
    {_T("MPQ_2018_v1_icon_error.w3m"),                          NULL, "fcefa25fb50c391e8714f2562d1e10ff",    19, &TwoFilesW3M},
    {_T("MPQ_1997_v1_Diablo1_STANDARD.SNP"),                    NULL, "5ef18ef9a26b5704d8d46a344d976c89",     2, &LfBliz},      // File whose archive's (signature) file has flags = 0x90000000
    {_T("MPQ_2012_v2_EmptyMpq.MPQ"),                            NULL, "00000000000000000000000000000000",     0},               // Empty archive (found in WoW cache - it's just a header)
    {_T("MPQ_2013_v4_EmptyMpq.MPQ"),                            NULL, "00000000000000000000000000000000",     0},               // Empty archive (created artificially - it's just a header)
    {_T("MPQ_2013_v4_patch-base-16357.MPQ"),                    NULL, "d41d8cd98f00b204e9800998ecf8427e",     1},               // Empty archive (found in WoW cache - it's just a header)
    {_T("MPQ_2011_v4_InvalidHetEntryCount.MPQ"),                NULL, "be4b49ecc3942d1957249f9da0021659",     6},               // Empty archive (with invalid HET entry count)
    {_T("MPQ_2002_v1_BlockTableCut.MPQ"),                       NULL, "a9499ab74d939303d8cda7c397c36275",   287},               // Truncated archive
    {_T("MPQ_2010_v2_HasUserData.s2ma"),                        NULL, "feff9e2c86db716b6ff5ffc906181200",    52},               // MPQ that actually has user data
    {_T("MPQ_2014_v1_AttributesOneEntryLess.w3x"),              NULL, "90451b7052eb0f1d6f4bf69b2daff7f5",   116},               // Warcraft III map whose "(attributes)" file has (BlockTableSize-1) entries
    {_T("MPQ_2010_v3_expansion-locale-frFR.MPQ"),               NULL, "0c8fc921466f07421a281a05fad08b01",    53},               // MPQ archive v 3.0 (the only one I know)
    {_T("mpqe-file://MPQ_2011_v2_EncryptedMpq.MPQE"),           NULL, "10e4dcdbe95b7ad731c563ec6b71bc16",    82},               // Encrypted archive from Starcraft II installer
    {_T("part-file://MPQ_2010_v2_HashTableCompressed.MPQ.part"),NULL, "d41d8cd98f00b204e9800998ecf8427e", 14263},               // Partial MPQ with compressed hash table
    {_T("blk4-file://streaming/model.MPQ.0"),                   NULL, "e06b00efb2fc7e7469dd8b3b859ae15d", 39914},               // Archive that is merged with multiple files
    {_T("MPQ_2023_v2_MemoryCorruption.SC2Replay"),              NULL, "4cf5021aa272298e64712a378a50df44",    10},               // MPQ archive v 2.0, archive size is wrong
    {_T("MPQ_2023_v1_StarcraftMap.scm"),                        NULL, "7830c51700697dd3c175f086a3157b29",     4},               // StarCraft map from StarCraft: Brood War 1.16
    {_T("MPQ_2023_v1_BroodWarMap.scx"),                         NULL, "dd3afa3c2f5e562ce3ca91c0c605a71f",     3},               // Brood War map from StarCraft: Brood War 1.16
    {_T("MPQ_2023_v1_Volcanis.scm"),                            NULL, "522c89ca96d6736427b01f7c80dd626f",     3},               // Map modified with unusual file compression: ZLIB+Huffman
    {_T("MPQ_2023_v4_UTF8.s2ma"),                               NULL, "97b7a686650f3307d135e1d1b017a36a",    67},               // Map contaning files with Chinese names (UTF8-encoded)
    {_T("MPQ_2023_v1_GreenTD.w3x"),                             NULL, "a8d91fc4e52d7c21ff7feb498c74781a",  2004},               // Corrupt sector checksum table in file #A0

    {_T("MPQ_2023_v4_1F644C5A.SC2Replay"),                      NULL, "b225828ffbf5037553e6a1290187caab",    17},               // Corrupt patch info of the "(attributes)" file
    {_T("<Chinese MPQ name>"),                                  NULL, "67faeffd0c0aece205ac8b7282d8ad8e",  4697, &MpqUtf8},     // Chinese name of the MPQ
    {_T("MPQ_2024_v1_BadUtf8_5.0.2.w3x"),                       NULL, "be34f9862758f021a1c6c77df3cd4f05",  6393, &LfBad1},      // Bad UTF-8 sequences in file names

    // Protected archives
    {_T("MPQ_2002_v1_ProtectedMap_InvalidUserData.w3x"),        NULL, "b900364cc134a51ddeca21a13697c3ca",    79},
    {_T("MPQ_2002_v1_ProtectedMap_InvalidMpqFormat.w3x"),       NULL, "db67e894da9de618a1cdf86d02d315ff",   117},
    {_T("MPQ_2002_v1_ProtectedMap_Spazzler.w3x"),               NULL, "72d7963aa799a7fb4117c55b7beabaf9",   470},               // Warcraft III map locked by the Spazzler protector
    {_T("MPQ_2014_v1_ProtectedMap_Spazzler2.w3x"),              NULL, "72d7963aa799a7fb4117c55b7beabaf9",   470},               // Warcraft III map locked by the Spazzler protector
    {_T("MPQ_2014_v1_ProtectedMap_Spazzler3.w3x"),              NULL, "e55aad2dd33cf68b372ca8e30dcb78a7",   130},               // Warcraft III map locked by the Spazzler protector
    {_T("MPQ_2002_v1_ProtectedMap_BOBA.w3m"),                   NULL, "7b725d87e07a2173c42fe2314b95fa6c",    17},               // Warcraft III map locked by the BOBA protector
    {_T("MPQ_2015_v1_ProtectedMap_KangTooJee.w3x"),             NULL, "44111a3edf7645bc44bb1afd3a813576",  1715},
    {_T("MPQ_2015_v1_ProtectedMap_Somj2hM16.w3x"),              NULL, "b411f9a51a6e9a9a509150c8d66ba359",    92},
    {_T("MPQ_2015_v1_ProtectedMap_Spazy.w3x"),                  NULL, "6e491bd055511435dcb4d9c8baed0516",  4089},               // Warcraft III map locked by Spazy protector
    {_T("MPQ_2015_v1_MessListFile.mpq"),                        NULL, "15e25d5be124d8ad71519f967997efc2",     8},
    {_T("MPQ_2016_v1_ProtectedMap_TableSizeOverflow.w3x"),      NULL, "ad81b43cbd37bbfa27e4bed4c17e6a81",   176},
    {_T("MPQ_2016_v1_ProtectedMap_HashOffsIsZero.w3x"),         NULL, "d6e712c275a26dc51f16b3a02f6187df",   228},
    {_T("MPQ_2016_v1_ProtectedMap_Somj2.w3x"),                  NULL, "457cdbf97a9ca41cfe8ea130dafaa0bb",    21},               // Something like Somj 2.0
    {_T("MPQ_2016_v1_WME4_4.w3x"),                              NULL, "7ec2f4d0f3982d8b12d88bc08ef0c1fb",   640},               // Protector from China (2016-05-27)
    {_T("MPQ_2016_v1_SP_(4)Adrenaline.w3x"),                    NULL, "b6f6d56f4f8aaef04c2c4b1f08881a8b",    16},
    {_T("MPQ_2016_v1_ProtectedMap_1.4.w3x"),                    NULL, "3c7908b29d3feac9ec952282390a242d",  5027},
    {_T("MPQ_2016_v1_KoreanFile.w3m"),                          NULL, "805d1f75712472a81c6df27b2a71f946",    18},
    {_T("MPQ_2017_v1_Eden_RPG_S2_2.5J.w3x"),                    NULL, "cbe1fd7ed5ed2fc005fba9beafcefe40", 16334},               // Protected by PG1.11.973
    {_T("MPQ_2017_v1_BigDummyFiles.w3x"),                       NULL, "f4d2ee9d85d2c4107e0b2d00ff302dd7",  9086},
    {_T("MPQ_2017_v1_TildeInFileName.mpq"),                     NULL, "f203e3979247a4dbf7f3828695ac810c",     5},
    {_T("MPQ_2018_v1_EWIX_v8_7.w3x"),                           NULL, "12c0f4e15c7361b7c13acd37a181d83b",   857, &TwoFilesW3X},
    {_T("MPQ_2020_v4_FakeMpqHeaders.SC2Mod"),                   NULL, "f45392f6523250c943990a017c230b41",    24},               // Archive that has two fake headers before the real one
    {_T("MPQ_2020_v4_NP_Protect_1.s2ma"),                       NULL, "1a1ea40ac1165bcdb4f2e434edfc7636",    21},               // SC2 map that is protected by the NP_Protect
    {_T("MPQ_2020_v4_NP_Protect_2.s2ma"),                       NULL, "7d1a379da8bd966da1f4fa6e4646049b",    55},               // SC2 map that is protected by the NP_Protect
    {_T("MPQ_2015_v1_flem1.w3x"),                               NULL, "1c4c13e627658c473e84d94371e31f37",    20},
    {_T("MPQ_2002_v1_ProtectedMap_HashTable_FakeValid.w3x"),    NULL, "5250975ed917375fc6540d7be436d4de",   114},
    {_T("MPQ_2021_v1_CantExtractCHK.scx"),                      NULL, "055fd548a789c910d9dd37472ecc1e66",    28},
    {_T("MPQ_2022_v1_Sniper.scx"),                              NULL, "2e955271b70b79344ad85b698f6ce9d8",    64},               // Multiple items in hash table for staredit\scenario.chk (locale=0, platform=0)
    {_T("MPQ_2022_v1_OcOc_Bound_2.scx"),                        NULL, "25cad16a2fb4e883767a1f512fc1dce7",    16},
    {_T("MPQ_2023_v1_Lusin2Rpg1.28.w3x"),                       NULL, "9c21352f06cf763fcf05e8a2691e6194", 10305, &HashVals},
    {_T("MPQ_2024_v1_300TK2.09p.w3x"),                          NULL, "e442e3d2e7d457b9ba544544013b791f", 32588},               // Fake MPQ User data, fake MPQ header at offset 0x200
    {_T("MPQ_2025_v1_Legion_TD_11_2d-BETA_2_TeamOZE.w3x"),      NULL, "08efaaa11cafe5e8921a6f112b2fa458",   626},
    {_T("MPQ_2026_v1_The Art of Defense v4.11 G0A.w3x"),        NULL, "892ec8421b34e35899624fc63b451327",   952},               // Some files have slash characters in their names
    {_T("MPQ_2026_v1_BadTablesSize.scx"),                       NULL, "2dd05809bdcb466bbe35778086790caf",     3},               // Fake MPQ header at offset 0

    // ASI plugins
    {_T("mix-mpq/AHF04patch.mix"),                              NULL, "d3c6aac48bc12813ef5ce4ad113e58bf",  2891},               // MIX file
    {_T("mix-mpq/hs0.1.asi"),                                   NULL, "50cba7460a6e6d270804fb9776a7ec4f",  6022},
    {_T("mix-mpq/hs0.8.asi"),                                   NULL, "6a40f733428001805bfe6e107ca9aec1", 11352},               // Items in hash table have platform = 0xFF
    {_T("mix-mpq/MoeMoeMod.asi"),                               NULL, "89b923c7cde06de48815844a5bbb0ec4",  2578},

    // MPQ modifications from Chinese games
    {_T("MPx_2013_v1_LongwuOnline.mpk"),                        NULL, "548f7db88284097f7e94c95a08c5bc24",   469},               // MPK archive from Longwu online
    {_T("MPx_2013_v1_WarOfTheImmortals.sqp"),                   NULL, "a048f37f7c6162a96253d8081722b6d9",  9396, &LfWotI},      // SQP archive from War of the Immortals
    {_T("MPx_2022_v1_Music.mpk"),                               NULL, "fc369cff4ff4b573dd024de963e4cdd5",   650},               // MPK archive from Warriors of the Ghost Valley
    {_T("MPx_2022_v1_Scp.mpk"),                                 NULL, "9cb453dc159f2e667c14f48957fd9e77",   113},               // MPK archive from Warriors of the Ghost Valley
    {_T("MPx_2022_v1_UI.mpk"),                                  NULL, "677a36b458d528a3158ced3dfb711e49",  3086},               // MPK archive from Warriors of the Ghost Valley

    // Patched MPQs
    {_T("MPQ_1998_v1_StarCraft.mpq"),                           NULL, "5ecef2f41c5fd44c264e269416de9495",   1943, &PatchSC1},   // Patched MPQ from StarCraft I
    {_T("MPQ_2005_v1_texture.MPQ"),                             NULL, "f95f44bfd8e6dde30508bfec2d4cb842",  45533, &PatchBETA},  // WoW BETA:  Patched "texture.MPQ"
    {_T("MPQ_2012_v4_OldWorld.MPQ"),                            NULL, "07643ec62864b4dd4fc8f8a6a16ce006",  71439, &Patch13286}, // WoW 13286: Patched "OldWorld.MPQ"
    {_T("MPQ_2013_v4_world.MPQ"),                               NULL, "af9baeceab20139bbf94d03f99170ae0",  48930, &Patch15050}, // WoW 15050: Patched "world.MPQ"
    {_T("MPQ_2013_v4_locale-enGB.MPQ"),                         NULL, "d39e743aaf6dad51d643d65e6e564804",  14349, &Patch16965}, // WoW 16965: Patched "locale-enGB.MPQ"
    {_T("MPQ_2013_v4_Base1.SC2Data"),                           NULL, "28a0f3cff1f400feb268ddae0efb2985",   1459, &Patch32283}, // SC2 32283: Patched "Base1.SC2Data"
    {_T("MPQ_2013_v4_Mods#Core.SC2Mod#enGB.SC2Assets"),         NULL, "89df7ddac15700721b3f4c37d2673c1f",     11, &Patch32283a},// SC2 32283: Patched "Mods#Core.SC2Mod#enGB.SC2Assets"
    {_T("MPQ_2013_v4_Base1.SC2Data"),                           NULL, "7b65d0a3c3c0e67e4c61f53f277e5ae7",   1459, &Patch34644}, // SC2 34644: Patched "Base1.SC2Data"
    {_T("MPQ_2013_v4_Base3.SC2Maps"),                           NULL, "831ed96de221b4018d4bc9e09593c540",   2080, &Patch34644m},// SC2 34644: Patched "Base3.SC2Maps"
    {_T("MPQ_2013_v4_Mods#Liberty.SC2Mod#enGB.SC2Data"),        NULL, "fde3842552c1a9cd5ceee0e571227d18",     17, &Patch36281}, // SC2 36281: Patched "Mods#Liberty.SC2Mod#enGB.SC2Data"
    {_T("MPQ_2014_v4_base-Win.MPQ"),                            NULL, "337b609b2469a6732f2837eae8f730a4",    207, &PatchH3604}, // HSTN 3604: Patched "base-Win.MPQ"
    {_T("MPQ_2014_v4_base-Win.MPQ"),                            NULL, "28c3447bdc6b221b5cb346123ea03a94",    234, &PatchH6898}, // HSTN 6898: Patched "base-Win.MPQ"

    // Signed archives
    {_T("MPQ_1997_v1_Diablo1_STANDARD.SNP"),               szSigned1, "5ef18ef9a26b5704d8d46a344d976c89",      2 | TFLG_SIGCHECK_BEFORE},
    {_T("MPQ_1998_v1_StarDat.mpq"),                        szSigned2, "2530cb937565fd41b1dc0443697096a2",   2925 | TFLG_SIGN_ARCHIVE | TFLG_SIGCHECK_AFTER},
    {_T("MPQ_1999_v1_WeakSignature.exe"),                  szSigned3, "c1084033d0bd5f7e2b9b78b600c0bba8",     24 | TFLG_SIGCHECK_BEFORE},
    {_T("MPQ_1999_v1_WeakSignature.exe"),                  szSigned3, "807fe2e4d38eccf5ee6bc88f5ee5940d",     25 | TFLG_SIGCHECK_BEFORE | TFLG_MODIFY | TFLG_SIGCHECK_AFTER},
    {_T("MPQ_2002_v1_StrongSignature.w3m"),                szSigned4, "7b725d87e07a2173c42fe2314b95fa6c",     17 | TFLG_SIGCHECK_BEFORE},
    {_T("MPQ_2003_v1_WeakSignatureEmpty.exe"),             szSigned5, "1e24a80dafa5285a0aee9470263e5b7c",  12259 | TFLG_SIGCHECK_BEFORE},
    {_T("MPQ_2006_v1_WoW-1.11.2.5464-patch.exe_"),         szSigned6, "6d1ccbfc344b6a2bc4ddf14867e45fea",    952 | TFLG_SIGCHECK_BEFORE},
    {_T("MPQ_2007_v2_StrongSignature1.exe"),               szSigned7, "c553320a2f841ccb86c0643f58d8488a",     23 | TFLG_SIGCHECK_BEFORE},
    {_T("MPQ_2007_v2_StrongSignature2.MPQ"),               szSigned8, "53cedaf7ba8c67b2e2ca95d5eb2b9380",   1622 | TFLG_SIGCHECK_BEFORE},

    // Multi-file archive with wrong prefix to see how StormLib deals with it
    {_T("flat-file://streaming/model.MPQ.0"),              _T("flat-file://model.MPQ.0"),           NULL,      0 | TFLG_WILL_FAIL},

    // An archive that has been invalidated by extending an old valid MPQ
    {_T("MPQ_2013_vX_Battle.net.MPQ"),                      NULL,                                   NULL,      0 | TFLG_WILL_FAIL},

    // Check whether read-only archive fails with update
    {_T("MPQ_1997_v1_Diablo1_DIABDAT.MPQ"),                 NULL,     "554b538541e42170ed41cb236483489e",  2910 | TFLG_READ_ONLY | TFLG_MODIFY | TFLG_WILL_FAIL},
    {_T("MPQ_1997_v1_Diablo1_DIABDAT.MPQ"),         szDiabdatMPQ,     "84fcb4aefbd0deac5b5159ec11922dbf",  2911 | TFLG_MODIFY},

    // Check the GetFileInfo operations
    {_T("MPQ_2002_v1_StrongSignature.w3m"),                 NULL,     "7b725d87e07a2173c42fe2314b95fa6c",    17 | TFLG_GET_FILE_INFO},
    {_T("MPQ_2013_v4_SC2_EmptyMap.SC2Map"),                 NULL,     "88e1b9a88d56688c9c24037782b7bb68",    33 | TFLG_GET_FILE_INFO},

};

static const TEST_INFO1 TestList_ReopenMpqs[] =
{
    // Test the archive compacting feature
    {_T("MPQ_2010_v3_expansion-locale-frFR.MPQ"),           NULL,     "0c8fc921466f07421a281a05fad08b01",    53 | TFLG_COMPACT | TFLG_ADD_USER_DATA | TFLG_HAS_LISTFILE | TFLG_HAS_ATTRIBUTES},
    {_T("MPQ_2016_v1_00000.pak"),                           NULL,     "76c5c4dffee8a9e3568e22216b5f0b94",  2072 | TFLG_COMPACT | TFLG_HAS_LISTFILE},
    {_T("MPQ_2013_v4_SC2_EmptyMap.SC2Map"),                 NULL,     "88e1b9a88d56688c9c24037782b7bb68",    33 | TFLG_COMPACT | TFLG_ADD_USER_DATA | TFLG_HAS_LISTFILE | TFLG_HAS_ATTRIBUTES},
    {_T("MPQ_2013_v4_expansion1.MPQ"),                      NULL,     "c97d2b4e2561d3eb3a728d72a74d86c2", 15633 | TFLG_COMPACT | TFLG_ADD_USER_DATA | TFLG_HAS_LISTFILE | TFLG_HAS_ATTRIBUTES},
    
    // Adding a file to MPQ that had size of the file table equal
    // or greater than hash table, but has free entries
    {_T("MPQ_2014_v1_out1.w3x"),                            NULL,     "222e685bd76e1af6d267ea1e0c27371f",    39 | TFLG_MODIFY | TFLG_HAS_LISTFILE},
    {_T("MPQ_2014_v1_out2.w3x"),                            NULL,     "514ab40dc72fc29965cc30b2e0d63674",    34 | TFLG_MODIFY | TFLG_HAS_LISTFILE},

    // Adding a file to MPQ and testing that (listfile) and (attributes) has the same state like before
    {_T("MPQ_1997_v1_Diablo1_DIABDAT.MPQ"),                 NULL,     "554b538541e42170ed41cb236483489e",  2910 | TFLG_MODIFY},
    {_T("MPQ_2013_v4_SC2_EmptyMap.SC2Map"),                 NULL,     "88e1b9a88d56688c9c24037782b7bb68",    33 | TFLG_MODIFY | TFLG_HAS_LISTFILE | TFLG_HAS_ATTRIBUTES},

    // Adding a large file to archive version 1. This must fail
    {_T("MPQ_2002_v1_LargeMapFile.w3m"),                    NULL,     "2f302705280f0cf9da50ac10e3d71522",    22 | TFLG_MODIFY | TFLG_HAS_LISTFILE | TFLG_HAS_ATTRIBUTES | TFLG_BIGFILE | TFLG_WILL_FAIL}
};

// Tests for signature file
static const TEST_INFO1 TestList_Signature[] =
{
    {_T("MPQ_1999_v1_WeakSigned1.mpq"), NULL, NULL, SFLAG_CREATE_ARCHIVE | SFLAG_SIGN_AT_CREATE | SFLAG_MODIFY_ARCHIVE | SFLAG_SIGN_ARCHIVE | SFLAG_VERIFY_AFTER},
    {_T("MPQ_1999_v1_WeakSigned1.mpq"), NULL, NULL, SFLAG_CREATE_ARCHIVE | SFLAG_MODIFY_ARCHIVE | SFLAG_SIGN_ARCHIVE | SFLAG_VERIFY_AFTER},
};

static const TEST_INFO1 TestList_ReplaceFile[] =
{
    {_T("MPQ_2014_v4_Base.StormReplay"), _T("replay.message.events"), (LPCSTR)(MPQ_FILE_SINGLE_UNIT), MPQ_COMPRESSION_ZLIB},
    {_T("MPQ_2022_v1_v4.329.w3x"),       _T("war3map.j"),             (LPCSTR)(MPQ_FILE_SINGLE_UNIT), MPQ_COMPRESSION_ZLIB},
    {_T("MPQ_2023_v1_StarcraftMap.scm"), _T("staredit#scenario.chk"), NULL,                           MPQ_COMPRESSION_ZLIB | MPQ_COMPRESSION_HUFFMANN},
};

static const TEST_INFO2 TestList_CreateMpqs[] =
{
    // Create empty MPQs containing nothing
    {"EmptyMpq_v2.mpq",                 NULL, NULL, CFLG_V2 | CFLG_EMPTY},
    {"EmptyMpq_v4.mpq",                 NULL, NULL, CFLG_V4 | CFLG_EMPTY},

    // Create empty MPQs with localized names
    {(LPCSTR)szPlainName_CZE,           NULL, NULL, CFLG_V2 | 15},       // (UTF-8) Czech
    {(LPCSTR)szPlainName_RUS,           NULL, NULL, CFLG_V2 | 58},       // (UTF-8) Russian
    {(LPCSTR)szPlainName_GRC,           NULL, NULL, CFLG_V2 | 15874},    // (UTF-8) Greek
    {(LPCSTR)szPlainName_CHN,           NULL, NULL, CFLG_V4 | 87541},    // (UTF-8) Chinese
    {(LPCSTR)szPlainName_JPN,           NULL, NULL, CFLG_V4 | 87541},    // (UTF-8) Japanese
    {(LPCSTR)szPlainName_SAU,           NULL, NULL, CFLG_V4 | 87541},    // (UTF-8) Arabic

    // Create archive containing files with non-std names
    {"NonStdNames.mpq",                 NULL, NULL, CFLG_NONSTD_NAMES | 4000},

    // Test creating of an archive the same way like MPQ Editor does
    {"MpqEditorTest.mpq",    "AddedFile.exe", NULL, CFLG_V2 | CFLG_MPQEDITOR | 4000},
};

static const LPCSTR Test_CreateMpq_Localized[] =
{
    (LPCSTR)szPlainName_CZE,    // (UTF-8) Czech
    (LPCSTR)szPlainName_RUS,    // (UTF-8) Russian
    (LPCSTR)szPlainName_GRC,    // (UTF-8) Greek
    (LPCSTR)szPlainName_CHN,    // (UTF-8) Chinese
    (LPCSTR)szPlainName_JPN,    // (UTF-8) Japanese
    (LPCSTR)szPlainName_SAU     // (UTF-8) Arabic
};

static void Test_PlayingSpace()
{
    SFILE_FIND_DATA sf;
    HANDLE hMpq1 = NULL;
    HANDLE hMpq2 = NULL;
    HANDLE hFind;
    bool bFound = true;

    if(SFileOpenArchive(_T("e:\\War3x.mpq"), 0, 0, &hMpq1))
    {
        if(SFileOpenFileArchive(hMpq1, "A.mpq", 0, 0, &hMpq2))
        {
            hFind = SFileFindFirstFile(hMpq1, "*", &sf, NULL);
            if(hFind != NULL)
            {
                while(bFound)
                {
                    printf("[*] Found: %s\n", sf.cFileName);
                    bFound = SFileFindNextFile(hFind, &sf);
                }
                SFileFindClose(hFind);
            }
            SFileCloseArchive(hMpq2);
        }
        SFileCloseArchive(hMpq1);
    }
}

//-----------------------------------------------------------------------------
// Main

//#define TEST_COMMAND_LINE
#define TEST_LOCAL_LISTFILE
#define TEST_STREAM_OPERATIONS
#define TEST_MASTER_MIRROR
#define TEST_OPEN_EMBEDDED_ARCHIVES
#define TEST_OPEN_MPQ
#define TEST_REOPEN_MPQ
#define TEST_VERIFY_SIGNATURE
#define TEST_REPLACE_FILE
#define TEST_VERIFY_HASHES
#define TEST_CREATE_MPQS
#define TEST_MISC_MPQS

int _tmain(int argc, TCHAR * argv[])
{
    DWORD dwErrCode = ERROR_SUCCESS;

#if defined(_MSC_VER) && defined(_DEBUG)
    _CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
#endif  // defined(_MSC_VER) && defined(_DEBUG)

    // Initialize storage and mix the random number generator
    printf("==== Test Suite for StormLib version %s ====\n", STORMLIB_VERSION_STRING);
    dwErrCode = InitializeMpqDirectory(argv, argc);

    // Placeholder function for various testing purposes
    Test_PlayingSpace();

    // Test the UTF-8 conversions
    TestUtf8Conversions(FileNameInvalidUTF8, LfBad1.szFile);
    TestUtf8Conversions(FileNameInvalidChar, NULL);

#ifdef TEST_COMMAND_LINE
    // Test-open MPQs from the command line. They must be plain name
    // and must be placed in the Test-MPQs folder
    for(int i = 2; i < argc; i++)
    {
        TestOpenArchive(argv[i], NULL, NULL, 0, &LfBliz);
    }
#endif  // TEST_COMMAND_LINE

#ifdef TEST_LOCAL_LISTFILE              // Tests on a local listfile
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestOnLocalListFile(_T("FLAT-MAP:listfile-test.txt"));
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestOnLocalListFile(_T("listfile-test.txt"));
#endif  // TEST_LOCAL_LISTFILE

#ifdef TEST_STREAM_OPERATIONS           // Test file stream operations
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_StreamOps); i++)
        {
            dwErrCode = TestFileStreamOperations(TestList_StreamOps[i].szName1, TestList_StreamOps[i].dwFlags);
            if(dwErrCode != ERROR_SUCCESS)
                break;
        }
    }
#endif  // TEST_STREAM_OPERATIONS

#ifdef TEST_MASTER_MIRROR               // Test master-mirror reading operations
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_MasterMirror); i++)
        {
            dwErrCode = TestReadFile_MasterMirror(TestList_MasterMirror[i].szName1,
                                                  TestList_MasterMirror[i].szName2,
                                                  TestList_MasterMirror[i].dwFlags != 0);
            if(dwErrCode != ERROR_SUCCESS)
                break;
        }
    }
#endif  // TEST_MASTER_MIRROR

#ifdef TEST_OPEN_EMBEDDED_ARCHIVES      // Test opening of embedded archives
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_EmbeddedMpqs); i++)
        {
            dwErrCode = TestOpenArchive_Embedded(TestList_EmbeddedMpqs[i]);
            dwErrCode = ERROR_SUCCESS;
        }
    }
#endif // TEST_OPEN_EMBEDDED_ARCHIVES

#ifdef TEST_OPEN_MPQ                    // Test opening various archives - correct, damaged, protected
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_OpenMpqs); i++)
        {
            dwErrCode = TestOpenArchive(TestList_OpenMpqs[i]);
            dwErrCode = ERROR_SUCCESS;
        }
    }
#endif  // TEST_OPEN_MPQ

#ifdef TEST_REOPEN_MPQ                  // Test operations involving reopening the archive
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_ReopenMpqs); i++)
        {
            // Ignore the error code here; we want to see results of all opens
            dwErrCode = TestReopenArchive(TestList_ReopenMpqs[i].szName1,
                                          TestList_ReopenMpqs[i].szDataHash,
                                          TestList_ReopenMpqs[i].dwFlags);
            dwErrCode = ERROR_SUCCESS;
        }
    }
#endif

#ifdef TEST_VERIFY_SIGNATURE    // Verify digital signatures of the archives
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_Signature); i++)
        {
            // Ignore the error code here; we want to see results of all opens
            dwErrCode = TestOpenArchive_SignatureTest(TestList_Signature[i].szName1,
                                                      TestList_Signature[i].szName1,
                                                      TestList_Signature[i].dwFlags);
            if(dwErrCode != ERROR_SUCCESS)
                break;
        }
    }
#endif

#ifdef TEST_REPLACE_FILE        // Replace a file in archives
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_ReplaceFile); i++)
        {
            // Ignore the error code here; we want to see results of all opens
            dwErrCode = TestReplaceFile(TestList_ReplaceFile[i].szName1,
                                        TestList_ReplaceFile[i].szName2,
                                        TestList_ReplaceFile[i].szDataHash,
                                        TestList_ReplaceFile[i].dwFlags);
            if(dwErrCode != ERROR_SUCCESS)
                break;
        }
    }
#endif

#ifdef TEST_VERIFY_HASHES
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = VerifyFileHashes(szMpqSubDir);
#endif

#ifdef TEST_CREATE_MPQS
    if(dwErrCode == ERROR_SUCCESS)
    {
        for(size_t i = 0; i < _countof(TestList_CreateMpqs); i++)
        {
            // Ignore the error code here; we want to see results of all opens
            dwErrCode = TestCreateArchive(TestList_CreateMpqs[i]);
            if(dwErrCode != ERROR_SUCCESS)
                break;
        }
    }
#endif

#ifdef TEST_MISC_MPQS

    // Test creating of an archive the same way like MPQ Editor does
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestRenameFile(_T("MPQ_2002_v1_StrongSignature.w3m"));

    // Test creating of an archive the same way like MPQ Editor does
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_TestGaps(_T("StormLibTest_GapsTest.mpq"));

    // Create an archive and fill it with files up to the max file count
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_FillArchive(_T("StormLibTest_FileTableFull.mpq"), 0);

    // Create an archive and fill it with files up to the max file count
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_FillArchive(_T("StormLibTest_FileTableFull.mpq"), MPQ_CREATE_LISTFILE);

    // Create an archive and fill it with files up to the max file count
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_FillArchive(_T("StormLibTest_FileTableFull.mpq"), MPQ_CREATE_ATTRIBUTES);

    // Create an archive and fill it with files up to the max file count
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_FillArchive(_T("StormLibTest_FileTableFull.mpq"), MPQ_CREATE_ATTRIBUTES | MPQ_CREATE_LISTFILE);

    // Create an archive, and increment max file count several times
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_IncMaxFileCount(_T("StormLibTest_IncMaxFileCount.mpq"));

    // Create a MPQ file, add files with various flags
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_FileFlagTest(_T("StormLibTest_FileFlagTest.mpq"));

    // Create a MPQ file, add a mono-WAVE file with various compressions
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_WaveCompressionsTest(_T("StormLibTest_AddWaveMonoTest.mpq"), _T("wave-mono.wav"));

    // Create a MPQ file, add a mono-WAVE with 8 bits per sample file with various compressions
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_WaveCompressionsTest(_T("StormLibTest_AddWaveMonoBadTest.mpq"), _T("wave-mono-bad.wav"));

    // Create a MPQ file, add a stereo-WAVE file with various compressions
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_WaveCompressionsTest(_T("StormLibTest_AddWaveStereoTest.mpq"), _T("wave-stereo.wav"));

    // Check if the listfile is always created at the end of the file table in the archive
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_ListFilePos(_T("StormLibTest_ListFilePos.mpq"));

    // Open a MPQ (add custom user data to it)
    if(dwErrCode == ERROR_SUCCESS)
        dwErrCode = TestCreateArchive_BigArchive(_T("StormLibTest_BigArchive_v4.mpq"));
#endif  // TEST_MISC_MPQS

#ifdef _MSC_VER
    _CrtDumpMemoryLeaks();
#endif  // _MSC_VER

    return dwErrCode;
}
