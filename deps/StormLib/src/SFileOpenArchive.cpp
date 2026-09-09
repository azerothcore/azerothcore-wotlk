/*****************************************************************************/
/* SFileOpenArchive.cpp                       Copyright Ladislav Zezula 1999 */
/*                                                                           */
/* Author : Ladislav Zezula                                                  */
/* E-mail : ladik@zezula.net                                                 */
/* WWW    : www.zezula.net                                                   */
/*---------------------------------------------------------------------------*/
/* Implementation of archive functions                                       */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* xx.xx.xx  1.00  Lad  Created                                              */
/* 19.11.03  1.01  Dan  Big endian handling                                  */
/*****************************************************************************/

#define __STORMLIB_SELF__
#include "StormLib.h"
#include "StormCommon.h"

#define HEADER_SEARCH_BUFFER_SIZE   0x1000

//-----------------------------------------------------------------------------
// Local functions

#ifndef IMAGE_DOS_SIGNATURE

#define IMAGE_DOS_SIGNATURE                 0x5A4D      // MZ
#define IMAGE_FILE_DLL                      0x2000  // File is a DLL.

typedef struct _IMAGE_DOS_HEADER
{
    USHORT e_magic;
    USHORT dummy[0x1D];
    DWORD  e_lfanew;
} IMAGE_DOS_HEADER, *PIMAGE_DOS_HEADER;

typedef struct _IMAGE_FILE_HEADER
{
    USHORT  Machine;
    USHORT  NumberOfSections;
    DWORD   TimeDateStamp;
    DWORD   PointerToSymbolTable;
    DWORD   NumberOfSymbols;
    USHORT  SizeOfOptionalHeader;
    USHORT  Characteristics;
} IMAGE_FILE_HEADER, *PIMAGE_FILE_HEADER;
#endif


static MTYPE CheckMapType(LPCTSTR szFileName, LPBYTE pbHeaderBuffer, size_t cbHeaderBuffer)
{
    LPDWORD HeaderInt32 = (LPDWORD)pbHeaderBuffer;
    LPCTSTR szExtension;
    MTYPE TypeByExtension = MapTypeNotRecognized;

    // Don't do any checks if there is not at least 16 bytes
    if(cbHeaderBuffer > 0x10)
    {
        DWORD DwordValue0 = BSWAP_INT32_UNSIGNED(HeaderInt32[0]);
        DWORD DwordValue1 = BSWAP_INT32_UNSIGNED(HeaderInt32[1]);
        DWORD DwordValue2 = BSWAP_INT32_UNSIGNED(HeaderInt32[2]);
        DWORD DwordValue3 = BSWAP_INT32_UNSIGNED(HeaderInt32[3]);

        // Check maps by extension (Starcraft, Starcraft II). We must do this before
        // checking actual data, because the "NP_Protect" protector places
        // fake Warcraft III header into the Starcraft II maps
        if((szExtension = _tcsrchr(szFileName, _T('.'))) != NULL)
        {
            // Check for Starcraft I maps by extension
            if(!_tcsicmp(szExtension, _T(".scm")) || !_tcsicmp(szExtension, _T(".scx")))
            {
                return MapTypeStarcraft;
            }

            // Check for Starcraft II maps by extension
            if(!_tcsicmp(szExtension, _T(".s2ma")) || !_tcsicmp(szExtension, _T(".SC2Map")) || !_tcsicmp(szExtension, _T(".SC2Mod")))
            {
                return MapTypeStarcraft2;
            }

            // Check for Warcraft III maps by extension
            if(!_tcsicmp(szExtension, _T(".w3m")) || !_tcsicmp(szExtension, _T(".w3x")))
            {
                TypeByExtension = MapTypeWarcraft3;
            }
        }

        // Test for AVI files (Warcraft III cinematics) - 'RIFF', 'AVI ' or 'LIST'
        if(DwordValue0 == 0x46464952 && DwordValue2 == 0x20495641 && DwordValue3 == 0x5453494C)
            return MapTypeAviFile;

        // Check for Warcraft III maps
        if(DwordValue0 == 0x57334D48 && DwordValue1 == 0x00000000)
            return MapTypeWarcraft3;
    }

    // MIX files are DLL files that contain MPQ in overlay.
    // Only Warcraft III is able to load them, so we consider them Warcraft III maps
    // Do not include EXE files, because they may be World of Warcraft patches
    if(cbHeaderBuffer > sizeof(IMAGE_DOS_HEADER))
    {
        PIMAGE_FILE_HEADER pFileHeader;
        PIMAGE_DOS_HEADER pDosHeader = (PIMAGE_DOS_HEADER)(pbHeaderBuffer);
        size_t dwMaxAllowedSize = cbHeaderBuffer - sizeof(DWORD) - sizeof(IMAGE_FILE_HEADER);

        // Verify the header of EXE/DLL files
        if((pDosHeader->e_magic == IMAGE_DOS_SIGNATURE) && (0 < pDosHeader->e_lfanew && pDosHeader->e_lfanew < 0x10000))
        {
            // Is the file an EXE?
            if((size_t)pDosHeader->e_lfanew <= dwMaxAllowedSize)
            {
                pFileHeader = (PIMAGE_FILE_HEADER)(pbHeaderBuffer + pDosHeader->e_lfanew + sizeof(DWORD));
                if(pFileHeader->Characteristics & IMAGE_FILE_DLL)
                {
                    return MapTypeWarcraft3;
                }
            }
        }
    }

    // No special map type recognized
    return TypeByExtension;
}

static bool IsStarcraftBetaArchive(TMPQHeader * pHeader)
{
    // The archive must be version 1, with a standard header size
    if(pHeader->dwID == ID_MPQ && pHeader->dwHeaderSize == MPQ_HEADER_SIZE_V1)
    {
        // Check for known archive sizes
        return (pHeader->dwArchiveSize == 0x00028FB3 ||     // patch_rt.mpq
                pHeader->dwArchiveSize == 0x0351853D ||     // StarDat.mpq
                pHeader->dwArchiveSize == 0x0AEC8960);      // INSTALL.exe

    }
    return false;
}

static TMPQUserData * IsValidMpqUserData(ULONGLONG ByteOffset, ULONGLONG FileSize, void * pvUserData)
{
    TMPQUserData * pUserData;

    // BSWAP the source data and copy them to our buffer
    BSWAP_ARRAY32_UNSIGNED(pvUserData, sizeof(TMPQUserData));
    pUserData = (TMPQUserData *)pvUserData;

    // Check the sizes
    if(pUserData->cbUserDataHeader <= pUserData->cbUserDataSize && pUserData->cbUserDataSize <= pUserData->dwHeaderOffs)
    {
        // Move to the position given by the userdata
        ByteOffset += pUserData->dwHeaderOffs;

        // The MPQ header should be within range of the file size
        if((ByteOffset + MPQ_HEADER_SIZE_V1) < FileSize)
        {
            // Note: We should verify if there is the MPQ header.
            // However, the header could be at any position below that
            // that is multiplier of 0x200
            return (TMPQUserData *)pvUserData;
        }
    }

    return NULL;
}

// This function gets the right positions of the hash table and the block table.
static DWORD VerifyMpqTablePositions(TMPQArchive * ha, ULONGLONG FileSize)
{
    TMPQHeader * pHeader = ha->pHeader;
    ULONGLONG ByteOffset;
    //bool bMalformed = (ha->dwFlags & MPQ_FLAG_MALFORMED) ? true : false;

    // Check the begin of HET table
    if(pHeader->HetTablePos64)
    {
        ByteOffset = ha->MpqPos + pHeader->HetTablePos64;
        if(ByteOffset > FileSize)
            return ERROR_BAD_FORMAT;
    }

    // Check the begin of BET table
    if(pHeader->BetTablePos64)
    {
        ByteOffset = ha->MpqPos + pHeader->BetTablePos64;
        if(ByteOffset > FileSize)
            return ERROR_BAD_FORMAT;
    }

    // Check the begin of hash table
    if(pHeader->wHashTablePosHi || pHeader->dwHashTablePos)
    {
        ByteOffset = FileOffsetFromMpqOffset(ha, MAKE_OFFSET64(pHeader->wHashTablePosHi, pHeader->dwHashTablePos));
        if(ByteOffset > FileSize)
            return ERROR_BAD_FORMAT;
    }

    // Check the begin of block table
    if(pHeader->wBlockTablePosHi || pHeader->dwBlockTablePos)
    {
        ByteOffset = FileOffsetFromMpqOffset(ha, MAKE_OFFSET64(pHeader->wBlockTablePosHi, pHeader->dwBlockTablePos));
        if(ByteOffset > FileSize)
            return ERROR_BAD_FORMAT;
    }

    // Check the begin of hi-block table
    //if(pHeader->HiBlockTablePos64 != 0)
    //{
    //    ByteOffset = ha->MpqPos + pHeader->HiBlockTablePos64;
    //    if(ByteOffset > FileSize)
    //        return ERROR_BAD_FORMAT;
    //}

    // All OK.
    return ERROR_SUCCESS;
}

static bool OpenArchiveFromStream(TFileStream * pStream, HANDLE hParentMpq, DWORD dwPriority, DWORD dwFlags, HANDLE * phMpq)
{
    TMPQUserData * pUserData = NULL;
    TMPQArchive * ha = NULL;            // Archive handle
    TFileEntry * pFileEntry;
    ULONGLONG FileSize = 0;             // Size of the file
    LPBYTE pbHeaderBuffer = NULL;       // Buffer for searching MPQ header
    MTYPE MapType = MapTypeNotChecked;
    DWORD dwErrCode = ERROR_SUCCESS;

    // One time initialization of MPQ cryptography
    InitializeMpqCryptography();
    if(pStream == NULL)
        return false;

    // Check the file size. There must be at least 0x20 bytes
    if(dwErrCode == ERROR_SUCCESS)
    {
        FileStream_GetSize(pStream, &FileSize);
        if(FileSize < MPQ_HEADER_SIZE_V1)
            dwErrCode = ERROR_BAD_FORMAT;
    }

    // Allocate the MPQhandle
    if(dwErrCode == ERROR_SUCCESS)
    {
        if((ha = STORM_ALLOC(TMPQArchive, 1)) != NULL)
            memset(ha, 0, sizeof(TMPQArchive));
        else
            dwErrCode = ERROR_NOT_ENOUGH_MEMORY;
    }

    // Allocate buffer for searching MPQ header
    if(dwErrCode == ERROR_SUCCESS)
    {
        pbHeaderBuffer = STORM_ALLOC(BYTE, HEADER_SEARCH_BUFFER_SIZE);
        if(pbHeaderBuffer == NULL)
            dwErrCode = ERROR_NOT_ENOUGH_MEMORY;
    }

    // Find the position of MPQ header
    if(dwErrCode == ERROR_SUCCESS)
    {
        ULONGLONG ByteOffset = 0;
        ULONGLONG EndOfSearch = FileSize;
        DWORD dwStrmFlags = 0;
        DWORD dwHeaderSize;
        DWORD dwHeaderID;
        bool bSearchComplete = false;

        ha->dwValidFileFlags = MPQ_FILE_VALID_FLAGS;
        ha->pfnHashString = HashStringSlash;
        ha->pStream = pStream;
        pStream = NULL;

        // Set the archive read only if the stream is read-only
        FileStream_GetFlags(ha->pStream, &dwStrmFlags);
        ha->dwFlags |= (dwStrmFlags & STREAM_FLAG_READ_ONLY) ? MPQ_FLAG_READ_ONLY : 0;

        // Also remember if we shall check sector CRCs when reading file
        ha->dwFlags |= (dwFlags & MPQ_OPEN_CHECK_SECTOR_CRC) ? MPQ_FLAG_CHECK_SECTOR_CRC : 0;

        // Also remember if this MPQ is a patch
        ha->dwFlags |= (dwFlags & MPQ_OPEN_PATCH) ? MPQ_FLAG_PATCH : 0;

        // Set the reference count to 1
        ha->dwRefCount = 1;

        // Limit the header searching to about 130 MB of data
        if(EndOfSearch > 0x08000000)
            EndOfSearch = 0x08000000;
        if(FileSize < HEADER_SEARCH_BUFFER_SIZE)
            memset(pbHeaderBuffer, 0, HEADER_SEARCH_BUFFER_SIZE);

        // Find the offset of MPQ header within the file
        while(bSearchComplete == false && ByteOffset < EndOfSearch)
        {
            // Always read at least 0x1000 bytes for performance.
            // This is what Storm.dll (2002) does.
            DWORD dwBytesAvailable = HEADER_SEARCH_BUFFER_SIZE;

            // Cut the bytes available, if needed
            if((FileSize - ByteOffset) < HEADER_SEARCH_BUFFER_SIZE)
                dwBytesAvailable = (DWORD)(FileSize - ByteOffset);

            // Read the eventual MPQ header
            if(!FileStream_Read(ha->pStream, &ByteOffset, pbHeaderBuffer, dwBytesAvailable))
            {
                dwErrCode = SErrGetLastError();
                break;
            }

            // Check whether the file is AVI file or a Warcraft III/Starcraft II map
            if(MapType == MapTypeNotChecked)
            {
                LPCTSTR szFileName = FileStream_GetFileName(ha->pStream);

                // Do nothing if the file is an AVI file
                if((MapType = CheckMapType(szFileName, pbHeaderBuffer, dwBytesAvailable)) == MapTypeAviFile)
                {
                    dwErrCode = ERROR_AVI_FILE;
                    break;
                }
            }

            // Search the header buffer
            for(DWORD dwInBufferOffset = 0; dwInBufferOffset < dwBytesAvailable; dwInBufferOffset += 0x200)
            {
                // Copy the data from the potential header buffer to the MPQ header
                memcpy(ha->HeaderData, pbHeaderBuffer + dwInBufferOffset, sizeof(ha->HeaderData));

                // If there is the MPQ user data, process it
                // Note that Warcraft III does not check for user data, which is abused by many map protectors
                dwHeaderID = BSWAP_INT32_UNSIGNED(ha->HeaderData[0]);
                if(MapType != MapTypeWarcraft3 && (dwFlags & MPQ_OPEN_FORCE_MPQ_V1) == 0)
                {
                    if(ha->pUserData == NULL && dwHeaderID == ID_MPQ_USERDATA)
                    {
                        // Copy the eventual user data to the separate buffer
                        memcpy(&ha->UserData, ha->HeaderData, sizeof(TMPQUserData));

                        // Verify if this looks like a valid user data
                        pUserData = IsValidMpqUserData(ByteOffset, FileSize, &ha->UserData);
                        if(pUserData != NULL)
                        {
                            // Set the byte offset to the loaded user data
                            ULONGLONG TempByteOffset = ByteOffset + pUserData->dwHeaderOffs;

                            // Read the eventual MPQ header from the position where the user data points
                            if(!FileStream_Read(ha->pStream, &TempByteOffset, ha->HeaderData, sizeof(ha->HeaderData)))
                            {
                                dwErrCode = SErrGetLastError();
                                break;
                            }

                            // Re-initialize the header ID
                            dwHeaderID = BSWAP_INT32_UNSIGNED(ha->HeaderData[0]);
                        }
                    }
                }

                // There must be MPQ header signature. Note that STORM.dll from Warcraft III actually
                // tests the MPQ header size. It must be at least 0x20 bytes in order to load it
                // Abused by Spazzler Map protector. Note that the size check is not present
                // in Storm.dll v 1.00, so Diablo I code would load the MPQ anyway.
                dwHeaderSize = BSWAP_INT32_UNSIGNED(ha->HeaderData[1]);
                if(dwHeaderID == g_dwMpqSignature && dwHeaderSize >= MPQ_HEADER_SIZE_V1)
                {
                    // Now convert the header to version 4
                    dwErrCode = ConvertMpqHeaderToFormat4(ha, ByteOffset, FileSize, dwFlags, MapType);
                    if(dwErrCode != ERROR_FAKE_MPQ_HEADER)
                    {
                        bSearchComplete = true;
                        break;
                    }
                }

                // Check for MPK archives (Longwu Online - MPQ fork)
                if(MapType == MapTypeNotRecognized && (dwFlags & MPQ_OPEN_FORCE_MPQ_V1) == 0 && dwHeaderID == ID_MPK)
                {
                    // Now convert the MPK header to MPQ Header version 4
                    dwErrCode = ConvertMpkHeaderToFormat4(ha, FileSize, dwFlags);
                    bSearchComplete = true;
                    break;
                }

                // If searching for the MPQ header is disabled, return an error
                if(dwFlags & MPQ_OPEN_NO_HEADER_SEARCH)
                {
                    dwErrCode = ERROR_NOT_SUPPORTED;
                    bSearchComplete = true;
                    break;
                }

                // Move the pointers
                ByteOffset += 0x200;
                pUserData = NULL;
            }
        }

        // Did we identify one of the supported headers?
        if(dwErrCode == ERROR_SUCCESS)
        {
            // If we retrieved the offset from the user data offset, initialize the user data
            if(pUserData != NULL)
            {
                // Fill the user data header
                ha->pUserData = &ha->UserData;
                ha->UserDataPos = ByteOffset;

                // Set the real byte offset
                ByteOffset = ByteOffset + pUserData->dwHeaderOffs;
            }

            // Set the user data position to the MPQ header, if none
            if(ha->pUserData == NULL)
                ha->UserDataPos = ByteOffset;

            // Set the position of the MPQ header
            ha->pHeader = (TMPQHeader *)ha->HeaderData;
            ha->MpqPos = ByteOffset;
            ha->FileSize = FileSize;

            // Sector size must be nonzero.
            if(ByteOffset >= FileSize || ha->pHeader->wSectorSize == 0)
                dwErrCode = ERROR_BAD_FORMAT;
        }
    }

    // Fix table positions according to format
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Dump the header
//      DumpMpqHeader(ha->pHeader);

        // W3x Map Protectors use the fact that War3's Storm.dll ignores the MPQ user data,
        // and ignores the MPQ format version as well. The trick is to
        // fake MPQ format 2, with an improper hi-word position of hash table and block table
        // We can overcome such protectors by forcing opening the archive as MPQ v 1.0
        if(dwFlags & MPQ_OPEN_FORCE_MPQ_V1)
        {
            ha->pHeader->wFormatVersion = MPQ_FORMAT_VERSION_1;
            ha->pHeader->dwHeaderSize = MPQ_HEADER_SIZE_V1;
            ha->dwFlags |= MPQ_FLAG_READ_ONLY;
            ha->pUserData = NULL;
        }

        // Anti-overflow. If the hash table size in the header is
        // higher than 0x10000000, it would overflow in 32-bit version
        // Observed in the malformed Warcraft III maps
        // Example map: MPQ_2016_v1_ProtectedMap_TableSizeOverflow.w3x
        ha->pHeader->dwBlockTableSize = (ha->pHeader->dwBlockTableSize & BLOCK_INDEX_MASK);
        ha->pHeader->dwHashTableSize = (ha->pHeader->dwHashTableSize & BLOCK_INDEX_MASK);

        // Remember the archive priority
        ha->dwPriority = dwPriority;

        // Both MPQ_OPEN_NO_LISTFILE or MPQ_OPEN_NO_ATTRIBUTES trigger read only mode
        if(dwFlags & (MPQ_OPEN_NO_LISTFILE | MPQ_OPEN_NO_ATTRIBUTES))
            ha->dwFlags |= MPQ_FLAG_READ_ONLY;

        // Check if the caller wants to force adding listfile
        if(dwFlags & MPQ_OPEN_FORCE_LISTFILE)
            ha->dwFlags |= MPQ_FLAG_LISTFILE_FORCE;

        // StarDat.mpq from Starcraft I BETA: Enable special compression types
        if(IsStarcraftBetaArchive(ha->pHeader))
            ha->dwFlags |= MPQ_FLAG_STARCRAFT_BETA;

        // Set the mask for the file offset. In MPQs version 1,
        // all offsets are 32-bit and overflow is allowed.
        // For MPQs v2+, file offset if 64-bit.
        ha->FileOffsetMask = GetFileOffsetMask(ha);

        // Maps from StarCraft and Warcraft III need special treatment
        switch(MapType)
        {
            case MapTypeStarcraft:
                ha->dwValidFileFlags = MPQ_FILE_VALID_FLAGS_SCX;
                ha->dwFlags |= MPQ_FLAG_STARCRAFT;
                break;

            case MapTypeWarcraft3:
                ha->dwValidFileFlags = MPQ_FILE_VALID_FLAGS_W3X;
                ha->dwFlags |= MPQ_FLAG_WAR3_MAP;
                break;
            case MapTypeNotChecked:
            case MapTypeNotRecognized:
            case MapTypeAviFile:
            case MapTypeStarcraft2:
                // silence -Wswitch-enum
                break;
        }

        // Set the size of file sector. Be sure to check for integer overflow
        if((ha->dwSectorSize = (0x200 << ha->pHeader->wSectorSize)) == 0)
            dwErrCode = ERROR_FILE_CORRUPT;
    }

    // Verify if any of the tables doesn't start beyond the end of the file
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = VerifyMpqTablePositions(ha, FileSize);
    }

    // Read the hash table. Ignore the result, as hash table is no longer required
    // Read HET table. Ignore the result, as HET table is no longer required
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = LoadAnyHashTable(ha);
    }

    // Now, build the file table. It will be built by combining
    // the block table, BET table, hi-block table, (attributes) and (listfile).
    if(dwErrCode == ERROR_SUCCESS)
    {
        dwErrCode = BuildFileTable(ha);
    }

    // Load the internal listfile and include it to the file table
    if(dwErrCode == ERROR_SUCCESS && (dwFlags & MPQ_OPEN_NO_LISTFILE) == 0)
    {
        // Quick check for (listfile)
        pFileEntry = GetFileEntryLocale(ha, LISTFILE_NAME, LANG_NEUTRAL);
        if(pFileEntry != NULL)
        {
            // Ignore result of the operation. (listfile) is optional.
            SFileAddListFile((HANDLE)ha, NULL);
            ha->dwFileFlags1 = pFileEntry->dwFlags;
        }
    }

    // Load the "(attributes)" file and merge it to the file table
    if(dwErrCode == ERROR_SUCCESS && (dwFlags & MPQ_OPEN_NO_ATTRIBUTES) == 0 && (ha->dwFlags & MPQ_FLAG_BLOCK_TABLE_CUT) == 0)
    {
        // Quick check for (attributes)
        pFileEntry = GetFileEntryLocale(ha, ATTRIBUTES_NAME, LANG_NEUTRAL);
        if(pFileEntry != NULL)
        {
            // Ignore result of the operation. (attributes) is optional.
            SAttrLoadAttributes(ha);
            ha->dwFileFlags2 = pFileEntry->dwFlags;
        }
    }

    // Remember whether the archive has weak signature. Only for MPQs format 1.0.
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Quick check for (signature)
        pFileEntry = GetFileEntryLocale(ha, SIGNATURE_NAME, LANG_NEUTRAL);
        if(pFileEntry != NULL)
        {
            // Just remember that the archive is weak-signed
            assert((pFileEntry->dwFlags & MPQ_FILE_EXISTS) != 0);
            ha->dwFileFlags3 = pFileEntry->dwFlags;
        }

        // Finally, set the MPQ_FLAG_READ_ONLY if the MPQ was found malformed
        ha->dwFlags |= (ha->dwFlags & MPQ_FLAG_MALFORMED) ? MPQ_FLAG_READ_ONLY : 0;
    }

    // Finally, we need to reference the parent archive, if any
    if(dwErrCode == ERROR_SUCCESS && hParentMpq != NULL)
    {
        TMPQArchive * haParent = IsValidMpqHandle(hParentMpq);

        // Assign the parent archive
        ha->haParent = haParent;

        // Reference all parent archives
        while(haParent != NULL)
        {
            haParent->dwRefCount++;
            haParent = haParent->haParent;
        }
    }

    // Cleanup and exit
    if(dwErrCode != ERROR_SUCCESS)
    {
        FileStream_Close(pStream);
        DereferenceArchive(ha);
        SErrSetLastError(dwErrCode);
        ha = NULL;
    }

    // Free the header buffer
    if(pbHeaderBuffer != NULL)
        STORM_FREE(pbHeaderBuffer);
    if(phMpq != NULL)
        *phMpq = ha;
    return (dwErrCode == ERROR_SUCCESS);
}

//-----------------------------------------------------------------------------
// Support for alternate markers. Call before opening an archive

#define SFILE_MARKERS_MIN_SIZE   (sizeof(DWORD) + sizeof(DWORD) + sizeof(const char *) + sizeof(const char *))

bool WINAPI SFileSetArchiveMarkers(PSFILE_MARKERS pMarkers)
{
    // Check structure minimum size
    if(pMarkers == NULL || pMarkers->dwSize < SFILE_MARKERS_MIN_SIZE)
    {
        SErrSetLastError(ERROR_INVALID_PARAMETER);
        return false;
    }

    // Make sure that the MPQ cryptography is initialized at this time
    InitializeMpqCryptography();

    // Remember the marker for MPQ header
    if(pMarkers->dwSignature != 0)
        g_dwMpqSignature = pMarkers->dwSignature;

    // Remember the encryption key for hash table
    if(pMarkers->szHashTableKey != NULL)
        g_dwHashTableKey = HashString(pMarkers->szHashTableKey, MPQ_HASH_FILE_KEY);

    // Remember the encryption key for block table
    if(pMarkers->szBlockTableKey != NULL)
        g_dwBlockTableKey = HashString(pMarkers->szBlockTableKey, MPQ_HASH_FILE_KEY);

    // Succeeded
    return true;
}

//-----------------------------------------------------------------------------
// SFileGetLocale and SFileSetLocale
// Set the locale for all newly opened files

LCID WINAPI SFileGetLocale()
{
    return g_lcFileLocale;
}

LCID WINAPI SFileSetLocale(LCID lcFileLocale)
{
    return (g_lcFileLocale = lcFileLocale);
}

//-----------------------------------------------------------------------------
// SFileOpenArchive
//
//   szFileName - MPQ archive file name to open
//   dwPriority - When SFileOpenFileEx called, this contains the search priority for searched archives
//   dwFlags    - See MPQ_OPEN_XXX in StormLib.h
//   phMpq      - Pointer to store open archive handle

bool WINAPI SFileOpenArchive(
    LPCTSTR szMpqName,
    DWORD dwPriority,
    DWORD dwFlags,
    HANDLE * phMpq)
{
    TFileStream * pStream;
    DWORD dwStreamFlags = (dwFlags & STREAM_FLAGS_MASK);
    bool bResult = false;

    // Verify the parameters
    if(szMpqName == NULL || *szMpqName == 0 || phMpq == NULL)
    {
        SErrSetLastError(ERROR_INVALID_PARAMETER);
        return false;
    }

    // If not forcing MPQ v 1.0, also use file bitmap
    dwStreamFlags |= (dwFlags & MPQ_OPEN_FORCE_MPQ_V1) ? 0 : STREAM_FLAG_USE_BITMAP;
    if((pStream = FileStream_OpenFile(szMpqName, dwStreamFlags)) != NULL)
        bResult = OpenArchiveFromStream(pStream, NULL, dwPriority, dwFlags, phMpq);
    return bResult;
}

//-----------------------------------------------------------------------------
// SFileOpenFileArchive
//
//   hMpq       - Handle to the MPQ archive
//   szFileName - File name in the MPQ to be open as archive 
//   dwPriority - When SFileOpenFileEx called, this contains the search priority for searched archives
//   dwFlags    - See MPQ_OPEN_XXX in StormLib.h
//   phMpq      - Pointer to store open archive handle

bool WINAPI SFileOpenFileArchive(
    HANDLE hParentMpq,
    LPCSTR szFileName,
    DWORD dwPriority,
    DWORD dwFlags,
    HANDLE * phMpq)
{
    TFileStream * pStream;
    DWORD dwStreamFlags = dwFlags & (STREAM_OPTIONS_MASK | STREAM_PROVIDER_MASK);
    bool bResult = false;

    // Verify the parameters
    if(hParentMpq == NULL || szFileName == NULL || *szFileName == 0 || phMpq == NULL)
    {
        SErrSetLastError(ERROR_INVALID_PARAMETER);
        return false;
    }

    // If not forcing MPQ v 1.0, also use file bitmap
    dwStreamFlags |= (dwFlags & MPQ_OPEN_FORCE_MPQ_V1) ? 0 : STREAM_FLAG_USE_BITMAP;
    dwStreamFlags |= BASE_PROVIDER_MPQ;
    if((pStream = FileStream_OpenFileArchive(hParentMpq, szFileName)) != NULL)
        bResult = OpenArchiveFromStream(pStream, hParentMpq, dwPriority, dwFlags, phMpq);
    return bResult;
}

//-----------------------------------------------------------------------------
// bool WINAPI SFileSetDownloadCallback(HANDLE, SFILE_DOWNLOAD_CALLBACK, void *);
//
// Sets a callback that is called when content is downloaded from the master MPQ
//

bool WINAPI SFileSetDownloadCallback(HANDLE hMpq, SFILE_DOWNLOAD_CALLBACK DownloadCB, void * pvUserData)
{
    TMPQArchive * ha = (TMPQArchive *)hMpq;

    // Do nothing if 'hMpq' is bad parameter
    if(!IsValidMpqHandle(hMpq))
    {
        SErrSetLastError(ERROR_INVALID_HANDLE);
        return false;
    }

    return FileStream_SetCallback(ha->pStream, DownloadCB, pvUserData);
}

//-----------------------------------------------------------------------------
// bool SFileFlushArchive(HANDLE hMpq)
//
// Saves all dirty data into MPQ archive.
// Has similar effect like SFileCloseArchive, but the archive is not closed.
// Use on clients who keep MPQ archive open even for write operations,
// and terminating without calling SFileCloseArchive might corrupt the archive.
//

bool WINAPI SFileFlushArchive(HANDLE hMpq)
{
    TMPQArchive * ha;
    DWORD dwResultError = ERROR_SUCCESS;
    DWORD dwErrCode;

    // Do nothing if 'hMpq' is bad parameter
    if((ha = IsValidMpqHandle(hMpq)) == NULL)
    {
        SErrSetLastError(ERROR_INVALID_HANDLE);
        return false;
    }

    // Only if the MPQ was changed
    if(ha->dwFlags & MPQ_FLAG_CHANGED)
    {
        // Indicate that we are saving MPQ internal structures
        ha->dwFlags |= MPQ_FLAG_SAVING_TABLES;

        // Defragment the file table. This will allow us to put the internal files to the end
        DefragmentFileTable(ha);

        //
        // Create each internal file
        // Note that the (signature) file is usually before (listfile) in the file table
        //

        // Up the number of references to prevent it from going away during archive cleanup
        ha->dwRefCount++;

        // Add the (signature) file
        if(ha->dwFlags & MPQ_FLAG_SIGNATURE_NEW)
        {
            dwErrCode = SSignFileCreate(ha);
            if(dwErrCode != ERROR_SUCCESS)
                dwResultError = dwErrCode;
        }

        // Add the (listfile) file
        if(ha->dwFlags & (MPQ_FLAG_LISTFILE_NEW | MPQ_FLAG_LISTFILE_FORCE))
        {
            dwErrCode = SListFileSaveToMpq(ha);
            if(dwErrCode != ERROR_SUCCESS)
                dwResultError = dwErrCode;
        }

        // Add the (attributes) file
        if(ha->dwFlags & MPQ_FLAG_ATTRIBUTES_NEW)
        {
            dwErrCode = SAttrFileSaveToMpq(ha);
            if(dwErrCode != ERROR_SUCCESS)
                dwResultError = dwErrCode;
        }

        // Save HET table, BET table, hash table, block table, hi-block table
        if(ha->dwFlags & MPQ_FLAG_CHANGED)
        {
            // Rebuild the HET table
            if(ha->pHetTable != NULL)
                RebuildHetTable(ha);

            // Save all MPQ tables first
            dwErrCode = SaveMPQTables(ha);
            if(dwErrCode != ERROR_SUCCESS)
                dwResultError = dwErrCode;

            // If the archive has weak signature, we need to finish it
            if(ha->dwFileFlags3 != 0)
            {
                dwErrCode = SSignFileFinish(ha);
                if(dwErrCode != ERROR_SUCCESS)
                    dwResultError = dwErrCode;
            }
        }

        // Drop the reference count. Do NOT call DereferenceHandle() to prevent recursion
        assert(ha->dwRefCount > 0);
        ha->dwRefCount--;

        // We are no longer saving internal MPQ structures
        ha->dwFlags &= ~MPQ_FLAG_SAVING_TABLES;
    }

    // Return the error
    if(dwResultError != ERROR_SUCCESS)
        SErrSetLastError(dwResultError);
    return (dwResultError == ERROR_SUCCESS);
}

//-----------------------------------------------------------------------------
// bool SFileCloseArchive(HANDLE hMpq);
//

bool WINAPI SFileCloseArchive(HANDLE hMpq)
{
    TMPQArchive * ha = IsValidMpqHandle(hMpq);

    // Only if the handle is valid
    if(ha == NULL)
    {
        SErrSetLastError(ERROR_INVALID_HANDLE);
        return false;
    }

    // Dereference the archive
    if(!DereferenceArchive(ha))
    {
        SErrSetLastError(ERROR_ACCESS_DENIED);
        return false;
    }
    return true;
}
