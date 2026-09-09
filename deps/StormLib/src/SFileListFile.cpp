/*****************************************************************************/
/* SListFile.cpp                          Copyright (c) Ladislav Zezula 2004 */
/*---------------------------------------------------------------------------*/
/* Description:                                                              */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 12.06.04  1.00  Lad  The first version of SListFile.cpp                   */
/*****************************************************************************/

#define __STORMLIB_SELF__
#include "StormLib.h"
#include "StormCommon.h"
#include <assert.h>

//-----------------------------------------------------------------------------
// Listfile entry structure

#define CACHE_BUFFER_SIZE  0x1000       // Size of the cache buffer
#define MAX_LISTFILE_SIZE  0xC000000    // Maximum accepted listfile size is 192 MB

union TListFileHandle
{
    TFileStream * pStream;              // Opened local file
    HANDLE hFile;                       // Opened MPQ file
};

struct TListFileCache
{
    char * szWildCard;                  // Self-relative pointer to file mask
    LPBYTE pBegin;                      // The begin of the listfile cache
    LPBYTE pPos;                        // Current position in the cache
    LPBYTE pEnd;                        // The last character in the file cache
    DWORD dwFlags;                      // Flags from TMPQArchive

//  char szWildCard[wildcard_length];   // Followed by the name mask (if any)
//  char szListFile[listfile_length];   // Followed by the listfile (if any)
};

typedef bool (*LOAD_LISTFILE)(TListFileHandle * pHandle, void * pvBuffer, DWORD cbBuffer, LPDWORD pdwBytesRead);

//-----------------------------------------------------------------------------
// Local functions (cache)

// In SFileFindFile.cll
bool SFileCheckWildCard(const char * szString, const char * szWildCard);

static char * CopyListLine(char * szListLine, const char * szFileName)
{
    // Copy the string
    while(szFileName[0] != 0)
        *szListLine++ = *szFileName++;

    // Append the end-of-line
    *szListLine++ = 0x0D;
    *szListLine++ = 0x0A;
    return szListLine;
}

static bool LoadListFile_Stream(TListFileHandle * pHandle, void * pvBuffer, DWORD cbBuffer, LPDWORD pdwBytesRead)
{
    ULONGLONG ByteOffset = 0;
    bool bResult;

    bResult = FileStream_Read(pHandle->pStream, &ByteOffset, pvBuffer, cbBuffer);
    if(bResult)
        *pdwBytesRead = cbBuffer;
    return bResult;
}

static bool LoadListFile_MPQ(TListFileHandle * pHandle, void * pvBuffer, DWORD cbBuffer, LPDWORD pdwBytesRead)
{
    return SFileReadFile(pHandle->hFile, pvBuffer, cbBuffer, pdwBytesRead, NULL);
}

static bool FreeListFileCache(TListFileCache * pCache)
{
    // Valid parameter check
    if(pCache != NULL)
        STORM_FREE(pCache);
    return true;
}

static TListFileCache * CreateListFileCache(
    LOAD_LISTFILE PfnLoadFile,
    TListFileHandle * pHandle,
    const char * szWildCard,
    DWORD dwFileSize,
    DWORD dwMaxSize,
    DWORD dwFlags)
{
    TListFileCache * pCache = NULL;
    size_t cchWildCardAligned = 0;
    size_t cchWildCard = 0;
    DWORD dwBytesRead = 0;

    // Get the amount of bytes that need to be allocated
    if(dwFileSize == 0 || dwFileSize > dwMaxSize)
        return NULL;

    // Append buffer for name mask, if any
    if(szWildCard != NULL)
    {
        cchWildCard = strlen(szWildCard) + 1;
        cchWildCardAligned = (cchWildCard + 3) & 0xFFFFFFFC;
    }

    // Allocate cache for one file block
    pCache = (TListFileCache *)STORM_ALLOC(BYTE, sizeof(TListFileCache) + cchWildCardAligned + dwFileSize + 1);
    if(pCache != NULL)
    {
        // Clear the entire structure
        memset(pCache, 0, sizeof(TListFileCache) + cchWildCard);
        pCache->dwFlags = dwFlags;

        // Shall we copy the mask?
        if(cchWildCard != 0)
        {
            pCache->szWildCard = (char *)(pCache + 1);
            memcpy(pCache->szWildCard, szWildCard, cchWildCard);
        }

        // Fill-in the rest of the cache pointers
        pCache->pBegin = (LPBYTE)(pCache + 1) + cchWildCardAligned;

        // Load the entire listfile to the cache
        PfnLoadFile(pHandle, pCache->pBegin, dwFileSize, &dwBytesRead);
        if(dwBytesRead != 0)
        {
            // Allocate pointers
            pCache->pPos = pCache->pBegin;
            pCache->pEnd = pCache->pBegin + dwBytesRead;
        }
        else
        {
            FreeListFileCache(pCache);
            pCache = NULL;
        }
    }

    // Return the cache
    return pCache;
}

static TListFileCache * CreateListFileCache(
    HANDLE hMpq,
    const TCHAR * szListFile,
    const char * szWildCard,
    DWORD dwMaxSize,
    DWORD dwFlags)
{
    TListFileCache * pCache = NULL;
    TListFileHandle ListHandle = {NULL};

    // Put default value to dwMaxSize
    if(dwMaxSize == 0)
        dwMaxSize = MAX_LISTFILE_SIZE;

    // Internal listfile: hMPQ must be non NULL and szListFile must be NULL.
    // We load the MPQ::(listfile) file
    if(hMpq != NULL && szListFile == NULL)
    {
        DWORD dwFileSize = 0;

        // Open the file from the MPQ
        if(SFileOpenFileEx(hMpq, LISTFILE_NAME, 0, &ListHandle.hFile))
        {
            // Get the file size and create the listfile cache
            dwFileSize = SFileGetFileSize(ListHandle.hFile, NULL);
            pCache = CreateListFileCache(LoadListFile_MPQ, &ListHandle, szWildCard, dwFileSize, dwMaxSize, dwFlags);

            // Close the MPQ file
            SFileCloseFile(ListHandle.hFile);
        }

        // Return the loaded cache
        return pCache;
    }

    // External listfile: hMpq must be NULL and szListFile must be non-NULL.
    // We load the file using TFileStream
    if(hMpq == NULL && szListFile != NULL)
    {
        ULONGLONG FileSize = 0;

        // Open the local file
        ListHandle.pStream = FileStream_OpenFile(szListFile, STREAM_FLAG_READ_ONLY);
        if(ListHandle.pStream != NULL)
        {
            // Verify the file size
            FileStream_GetSize(ListHandle.pStream, &FileSize);
            if(0 < FileSize && FileSize < dwMaxSize)
            {
                pCache = CreateListFileCache(LoadListFile_Stream, &ListHandle, szWildCard, (DWORD)FileSize, dwMaxSize, dwFlags);
            }

            // Close the stream
            FileStream_Close(ListHandle.pStream);
        }

        // Return the loaded cache
        return pCache;
    }

    // This combination should never happen
    SErrSetLastError(ERROR_INVALID_PARAMETER);
    assert(false);
    return NULL;
}

#ifdef _DEBUG
/*
TMPQNameCache * CreateNameCache(HANDLE hListFile, const char * szSearchMask)
{
    TMPQNameCache * pNameCache;
    char * szCachePointer;
    size_t cbToAllocate;
    size_t nMaskLength = 1;
    DWORD dwBytesRead = 0;
    DWORD dwFileSize;

    // Get the size of the listfile. Ignore zero or too long ones
    dwFileSize = SFileGetFileSize(hListFile, NULL);
    if(dwFileSize == 0 || dwFileSize > MAX_LISTFILE_SIZE)
        return NULL;

    // Get the length of the search mask
    if(szSearchMask == NULL)
        szSearchMask = "*";
    nMaskLength = strlen(szSearchMask) + 1;

    // Allocate the name cache
    cbToAllocate = sizeof(TMPQNameCache) + nMaskLength + dwFileSize + 1;
    pNameCache = (TMPQNameCache *)STORM_ALLOC(BYTE, cbToAllocate);
    if(pNameCache != NULL)
    {
        // Initialize the name cache
        memset(pNameCache, 0, sizeof(TMPQNameCache));
        pNameCache->TotalCacheSize = (DWORD)(nMaskLength + dwFileSize + 1);
        szCachePointer = (char *)(pNameCache + 1);

        // Copy the search mask, if any
        memcpy(szCachePointer, szSearchMask, nMaskLength);
        pNameCache->FirstNameOffset = (DWORD)nMaskLength;
        pNameCache->FreeSpaceOffset = (DWORD)nMaskLength;

        // Read the listfile itself
        SFileSetFilePointer(hListFile, 0, NULL, FILE_BEGIN);
        SFileReadFile(hListFile, szCachePointer + nMaskLength, dwFileSize, &dwBytesRead, NULL);

        // If nothing has been read from the listfile, clear the cache
        if(dwBytesRead == 0)
        {
            STORM_FREE(pNameCache);
            return NULL;
        }

        // Move the free space offset
        pNameCache->FreeSpaceOffset = pNameCache->FirstNameOffset + dwBytesRead + 1;
        szCachePointer[nMaskLength + dwBytesRead] = 0;
    }

    return pNameCache;
}

static void FreeNameCache(TMPQNameCache * pNameCache)
{
    if(pNameCache != NULL)
        STORM_FREE(pNameCache);
    pNameCache = NULL;
}
*/
#endif  // _DEBUG

static char * ReadListFileLine(TListFileCache * pCache, size_t * PtrLength)
{
    LPBYTE pbLineBegin;
    LPBYTE pbLineEnd;

    // Skip newlines. Keep spaces and tabs, as they can be a legal part of the file name
    while(pCache->pPos < pCache->pEnd && (pCache->pPos[0] == 0x0A || pCache->pPos[0] == 0x0D))
        pCache->pPos++;

    // Set the line begin and end
    if(pCache->pPos >= pCache->pEnd)
        return NULL;
    pbLineBegin = pbLineEnd = pCache->pPos;

    // Find the end of the line
    while(pCache->pPos < pCache->pEnd && pCache->pPos[0] != 0x0A && pCache->pPos[0] != 0x0D)
        pCache->pPos++;

    // Remember the end of the line
    pbLineEnd = pCache->pPos++;
    pbLineEnd[0] = 0;

    // Give the line to the caller
    if(PtrLength != NULL)
        PtrLength[0] = (size_t)(pbLineEnd - pbLineBegin);
    return (char *)pbLineBegin;
}

static int STORMLIB_CDECL CompareFileNodes(const void * p1, const void * p2)
{
    char * szFileName1 = *(char **)p1;
    char * szFileName2 = *(char **)p2;

    return _stricmp(szFileName1, szFileName2);
}

static LPBYTE CreateListFile(TMPQArchive * ha, DWORD * pcbListFile)
{
    TFileEntry * pFileTableEnd = ha->pFileTable + ha->dwFileTableSize;
    TFileEntry * pFileEntry;
    char ** SortTable = NULL;
    char * szListFile = NULL;
    char * szListLine;
    size_t nFileNodes = 0;
    size_t cbListFile = 0;
    size_t nIndex0;
    size_t nIndex1;

    // Allocate the table for sorting listfile
    SortTable = STORM_ALLOC(char*, ha->dwFileTableSize);
    if(SortTable == NULL)
        return NULL;

    // Construct the sort table
    // Note: in MPQs with multiple locale versions of the same file,
    // this code causes adding multiple listfile entries.
    // They will get removed after the listfile sorting
    for(pFileEntry = ha->pFileTable; pFileEntry < pFileTableEnd; pFileEntry++)
    {
        // Only take existing items
        if((pFileEntry->dwFlags & MPQ_FILE_EXISTS) && pFileEntry->szFileName != NULL)
        {
            // Ignore pseudo-names and internal names
            if(!IsPseudoFileName(pFileEntry->szFileName, NULL) && !IsInternalMpqFileName(pFileEntry->szFileName))
            {
                SortTable[nFileNodes++] = pFileEntry->szFileName;
            }
        }
    }

    // Remove duplicities
    if(nFileNodes > 0)
    {
        // Sort the table
        qsort(SortTable, nFileNodes, sizeof(char *), CompareFileNodes);

        // Count the 0-th item
        cbListFile += strlen(SortTable[0]) + 2;

        // Walk through the items and only use the ones that are not duplicated
        for(nIndex0 = 0, nIndex1 = 1; nIndex1 < nFileNodes; nIndex1++)
        {
            // If the next file node is different, we will include it to the result listfile
            if(_stricmp(SortTable[nIndex1], SortTable[nIndex0]) != 0)
            {
                cbListFile += strlen(SortTable[nIndex1]) + 2;
                nIndex0 = nIndex1;
            }
        }

        // Now allocate buffer for the entire listfile
        szListFile = szListLine = STORM_ALLOC(char, cbListFile + 1);
        if(szListFile != NULL)
        {
            // Copy the 0-th item
            szListLine = CopyListLine(szListLine, SortTable[0]);

            // Walk through the items and only use the ones that are not duplicated
            for(nIndex0 = 0, nIndex1 = 1; nIndex1 < nFileNodes; nIndex1++)
            {
                // If the next file node is different, we will include it to the result listfile
                if(_stricmp(SortTable[nIndex1], SortTable[nIndex0]) != 0)
                {
                    // Copy the listfile line
                    szListLine = CopyListLine(szListLine, SortTable[nIndex1]);
                    nIndex0 = nIndex1;
                }
            }

            // Sanity check - does the size match?
            assert((size_t)(szListLine - szListFile) == cbListFile);
        }
    }
    else
    {
        szListFile = STORM_ALLOC(char, 1);
        cbListFile = 0;
    }

    // Free the sort table
    STORM_FREE(SortTable);

    // Give away the listfile
    if(pcbListFile != NULL)
        *pcbListFile = (DWORD)cbListFile;
    return (LPBYTE)szListFile;
}

//-----------------------------------------------------------------------------
// Local functions (listfile nodes)

// Adds a name into the list of all names. For each locale in the MPQ,
// one entry will be created
// If the file name is already there, does nothing.
static DWORD SListFileCreateNodeForAllLocales(TMPQArchive * ha, const char * szFileName)
{
    TFileEntry * pFileEntry;
    TMPQHash * pHashEnd;
    TMPQHash * pHash;
    DWORD dwHashCheck1;
    DWORD dwHashCheck2;

    // If we have HET table, use that one
    if(ha->pHetTable != NULL)
    {
        pFileEntry = GetFileEntryLocale(ha, szFileName, 0);
        if(pFileEntry != NULL)
        {
            // Allocate file name for the file entry
            AllocateFileName(ha, pFileEntry, szFileName);
        }

        return ERROR_SUCCESS;
    }

    // If we have hash table, we use it
    if(ha->pHashTable != NULL)
    {
        // Get the end of the hash table and both names
        pHashEnd = ha->pHashTable + ha->pHeader->dwHashTableSize;
        dwHashCheck1 = ha->pfnHashString(szFileName, MPQ_HASH_NAME_A);
        dwHashCheck2 = ha->pfnHashString(szFileName, MPQ_HASH_NAME_B);

        // Some protectors set very high hash table size (0x00400000 items or more)
        // in order to make this process very slow. We will ignore items
        // in the hash table that would be beyond the end of the file.
        // Example MPQ: MPQ_2022_v1_Sniper.scx
        if(ha->dwFlags & MPQ_FLAG_HASH_TABLE_CUT)
            pHashEnd = ha->pHashTable + (ha->dwRealHashTableSize / sizeof(TMPQHash));

        // Go through the hash table and put the name in each item that has the same name pair
        for(pHash = ha->pHashTable; pHash < pHashEnd; pHash++)
        {
            if(pHash->dwHashCheck1 == dwHashCheck1 && pHash->dwHashCheck2 == dwHashCheck2 && MPQ_BLOCK_INDEX(pHash) < ha->dwFileTableSize)
            {
                // Allocate file name for the file entry
                AllocateFileName(ha, ha->pFileTable + MPQ_BLOCK_INDEX(pHash), szFileName);
            }
        }

        // Go while we found something
        //pFirstHash = pHash = GetFirstHashEntry(ha, szFileName);
        //while(pHash != NULL)
        //{
        //    // Allocate file name for the file entry
        //    AllocateFileName(ha, ha->pFileTable + MPQ_BLOCK_INDEX(pHash), szFileName);

        //    // Now find the next language version of the file
        //    pHash = GetNextHashEntry(ha, pFirstHash, pHash);
        //}

        return ERROR_SUCCESS;
    }

    return ERROR_CAN_NOT_COMPLETE;
}

// Saves the whole listfile to the MPQ
DWORD SListFileSaveToMpq(TMPQArchive * ha)
{
    TMPQFile * hf = NULL;
    LPBYTE pbListFile;
    DWORD cbListFile = 0;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Only save the listfile if we should do so
    if(ha->dwFileFlags1 != 0)
    {
        // At this point, we expect to have at least one reserved entry in the file table
        assert(ha->dwFlags & MPQ_FLAG_LISTFILE_NEW);
        assert(ha->dwReservedFiles > 0);

        // Create the raw data that is to be written to (listfile)
        // Note: Creating the raw data before the (listfile) has been created in the MPQ
        // causes that the name of the listfile will not be included in the listfile itself.
        // That is OK, because (listfile) in Blizzard MPQs does not contain it either.
        pbListFile = CreateListFile(ha, &cbListFile);
        if(pbListFile != NULL)
        {
            // Determine the real flags for (listfile)
            if(ha->dwFileFlags1 == MPQ_FILE_DEFAULT_INTERNAL)
                ha->dwFileFlags1 = GetDefaultSpecialFileFlags(cbListFile, ha->pHeader->wFormatVersion);

            // Create the listfile in the MPQ
            dwErrCode = SFileAddFile_Init(ha, LISTFILE_NAME,
                                           0,
                                           cbListFile,
                                           LANG_NEUTRAL,
                                           ha->dwFileFlags1 | MPQ_FILE_REPLACEEXISTING,
                                          &hf);

            // Write the listfile raw data to it
            if(dwErrCode == ERROR_SUCCESS)
            {
                // Write the content of the listfile to the MPQ
                dwErrCode = SFileAddFile_Write(hf, pbListFile, cbListFile, MPQ_COMPRESSION_ZLIB);
                SFileAddFile_Finish(hf);
            }

            // Clear the listfile flags
            ha->dwFlags &= ~(MPQ_FLAG_LISTFILE_NEW | MPQ_FLAG_LISTFILE_NONE);
            ha->dwReservedFiles--;

            // Free the listfile buffer
            STORM_FREE(pbListFile);
        }
        else
        {
            // If the (listfile) file would be empty, its OK
            dwErrCode = (cbListFile == 0) ? ERROR_SUCCESS : ERROR_NOT_ENOUGH_MEMORY;
        }
    }

    return dwErrCode;
}

static DWORD SFileAddArbitraryListFile(
    TMPQArchive * ha,
    HANDLE hMpq,
    const TCHAR * szListFile,
    DWORD dwMaxSize)
{
    TListFileCache * pCache = NULL;

    // Create the listfile cache for that file
    pCache = CreateListFileCache(hMpq, szListFile, NULL, dwMaxSize, ha->dwFlags);
    if(pCache != NULL)
    {
        char * szFileName;
        size_t nLength = 0;

        // Get the next line
        while((szFileName = ReadListFileLine(pCache, &nLength)) != NULL)
        {
            // Add the line to the MPQ
            if(nLength != 0)
                SListFileCreateNodeForAllLocales(ha, szFileName);
        }

        // Delete the cache
        FreeListFileCache(pCache);
    }

    return (pCache != NULL) ? ERROR_SUCCESS : ERROR_FILE_CORRUPT;
}

static DWORD SFileAddArbitraryListFile(
    TMPQArchive * ha,
    const char ** listFileEntries,
    DWORD dwEntryCount)
{
    if(listFileEntries != NULL && dwEntryCount > 0)
    {
        // Get the next line
        for(DWORD dwListFileNum = 0; dwListFileNum < dwEntryCount; dwListFileNum++)
        {
            const char * listFileEntry = listFileEntries[dwListFileNum];
            if(listFileEntry != NULL)
            {
                SListFileCreateNodeForAllLocales(ha, listFileEntry);
            }
        }
    }

    return (listFileEntries != NULL && dwEntryCount > 0) ? ERROR_SUCCESS : ERROR_INVALID_PARAMETER;
}

static DWORD SFileAddInternalListFile(
    TMPQArchive * ha,
    HANDLE hMpq)
{
    TMPQHash * pFirstHash;
    TMPQHash * pHash;
    LCID lcSaveLocale = g_lcFileLocale;
    DWORD dwMaxSize = MAX_LISTFILE_SIZE;
    DWORD dwErrCode = ERROR_SUCCESS;

    // If there is hash table, we need to support multiple listfiles
    // with different locales (BrooDat.mpq)
    if(ha->pHashTable != NULL)
    {
        // If the archive is a malformed map, ignore too large listfiles
        if(STORMLIB_TEST_FLAGS(ha->dwFlags, MPQ_FLAG_MALFORMED | MPQ_FLAG_PATCH, MPQ_FLAG_MALFORMED))
            dwMaxSize = 0x40000;

        pFirstHash = pHash = GetFirstHashEntry(ha, LISTFILE_NAME);
        while(dwErrCode == ERROR_SUCCESS && pHash != NULL)
        {
            // Set the prefered locale to that from list file
            SFileSetLocale(SFILE_MAKE_LCID(pHash->Locale, pHash->Platform));

            // Add that listfile
            dwErrCode = SFileAddArbitraryListFile(ha, hMpq, NULL, dwMaxSize);

            // Move to the next hash
            pHash = GetNextHashEntry(ha, pFirstHash, pHash);
        }

        // Restore the original locale
        SFileSetLocale(lcSaveLocale);
    }
    else
    {
        // Add the single listfile
        dwErrCode = SFileAddArbitraryListFile(ha, hMpq, NULL, dwMaxSize);
    }

    // Return the result of the operation
    return dwErrCode;
}

static bool DoListFileSearch(TListFileCache * pCache, SFILE_FIND_DATA * lpFindFileData)
{
    // Check for the valid search handle
    if(pCache != NULL)
    {
        char * szFileName;
        size_t nLength = 0;

        // Get the next line
        while((szFileName = ReadListFileLine(pCache, &nLength)) != NULL)
        {
            // Check search mask
            if(nLength != 0 && SFileCheckWildCard(szFileName, pCache->szWildCard))
            {
                if(nLength >= sizeof(lpFindFileData->cFileName))
                    nLength = sizeof(lpFindFileData->cFileName) - 1;

                memcpy(lpFindFileData->cFileName, szFileName, nLength);
                lpFindFileData->cFileName[nLength] = 0;
                return true;
            }
        }
    }

    // No more files
    memset(lpFindFileData, 0, sizeof(SFILE_FIND_DATA));
    SErrSetLastError(ERROR_NO_MORE_FILES);
    return false;
}

//-----------------------------------------------------------------------------
// File functions

// Adds a listfile into the MPQ archive.
DWORD WINAPI SFileAddListFile(HANDLE hMpq, const TCHAR * szListFile)
{
    TMPQArchive * ha = (TMPQArchive *)hMpq;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Add the listfile for each MPQ in the patch chain
    while(ha != NULL)
    {
        if(szListFile != NULL)
            dwErrCode = SFileAddArbitraryListFile(ha, NULL, szListFile, MAX_LISTFILE_SIZE);
        else
            dwErrCode = SFileAddInternalListFile(ha, hMpq);

        // Also, add three special files to the listfile:
        // (listfile) itself, (attributes) and (signature)
        SListFileCreateNodeForAllLocales(ha, LISTFILE_NAME);
        SListFileCreateNodeForAllLocales(ha, SIGNATURE_NAME);
        SListFileCreateNodeForAllLocales(ha, ATTRIBUTES_NAME);

        // Move to the next archive in the chain
        ha = ha->haPatch;
    }

    return dwErrCode;
}

DWORD WINAPI SFileAddListFileEntries(HANDLE hMpq, const char ** listFileEntries, DWORD dwEntryCount)
{
    TMPQArchive * ha = (TMPQArchive *)hMpq;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Add the listfile for each MPQ in the patch chain
    while(ha != NULL)
    {
        if(listFileEntries != NULL && dwEntryCount > 0)
            dwErrCode = SFileAddArbitraryListFile(ha, listFileEntries, dwEntryCount);
        else
            dwErrCode = SFileAddInternalListFile(ha, hMpq);

        // Also, add three special files to the listfile:
        // (listfile) itself, (attributes) and (signature)
        SListFileCreateNodeForAllLocales(ha, LISTFILE_NAME);
        SListFileCreateNodeForAllLocales(ha, SIGNATURE_NAME);
        SListFileCreateNodeForAllLocales(ha, ATTRIBUTES_NAME);

        // Move to the next archive in the chain
        ha = ha->haPatch;
    }
    
    return dwErrCode;
}

//-----------------------------------------------------------------------------
// Enumerating files in listfile

HANDLE WINAPI SListFileFindFirstFile(HANDLE hMpq, const TCHAR * szListFile, const char * szMask, SFILE_FIND_DATA * lpFindFileData)
{
    TListFileCache * pCache = NULL;

    // Initialize the structure with zeros
    memset(lpFindFileData, 0, sizeof(SFILE_FIND_DATA));

    // Open the local/internal listfile
    pCache = CreateListFileCache(hMpq, szListFile, szMask, 0, 0);
    if(pCache != NULL)
    {
        if(!DoListFileSearch(pCache, lpFindFileData))
        {
            memset(lpFindFileData, 0, sizeof(SFILE_FIND_DATA));
            SErrSetLastError(ERROR_NO_MORE_FILES);
            FreeListFileCache(pCache);
            pCache = NULL;
        }
    }

    // Return the listfile cache as handle
    return (HANDLE)pCache;
}

bool WINAPI SListFileFindNextFile(HANDLE hFind, SFILE_FIND_DATA * lpFindFileData)
{
    return DoListFileSearch((TListFileCache *)hFind, lpFindFileData);
}

bool WINAPI SListFileFindClose(HANDLE hFind)
{
    TListFileCache * pCache = (TListFileCache *)hFind;

    return FreeListFileCache(pCache);
}

