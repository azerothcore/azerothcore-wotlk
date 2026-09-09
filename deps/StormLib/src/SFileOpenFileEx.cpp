/*****************************************************************************/
/* SFileOpenFileEx.cpp                    Copyright (c) Ladislav Zezula 2003 */
/*---------------------------------------------------------------------------*/
/* Description :                                                             */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* xx.xx.99  1.00  Lad  Created                                              */
/*****************************************************************************/

#define __STORMLIB_SELF__
#include "StormLib.h"
#include "StormCommon.h"

/*****************************************************************************/
/* Local functions                                                           */
/*****************************************************************************/

// Finds hash index of the entry that was open by pseudo-name
static DWORD FindHashIndex(TMPQArchive * ha, DWORD dwFileIndex)
{
    TMPQHash * pHashTableEnd;
    TMPQHash * pHash;
    DWORD dwHashIndex = HASH_ENTRY_FREE;
    DWORD dwCount = 0;

    // Should only be called if the archive has hash table
    assert(ha->pHashTable != NULL);

    // Multiple hash table entries can point to the file table entry.
    // We need to search all of them
    pHashTableEnd = ha->pHashTable + ha->pHeader->dwHashTableSize;
    for(pHash = ha->pHashTable; pHash < pHashTableEnd; pHash++)
    {
        if(MPQ_BLOCK_INDEX(pHash) == dwFileIndex)
        {
            // Example: MPQ_2023_v1_Lusin2Rpg1.28.w3x, file index 24483
            // ReplaceableTextures\CommandButtons\BTNHaboss79.blp
            // Hash Table Index #1 = 18
            // Hash Table Index #2 = 8446
            if(dwCount++ > 0)
                return HASH_ENTRY_FREE;
            dwHashIndex = (DWORD)(pHash - ha->pHashTable);
        }
    }

    // Return the found hash index, if there are no duplicities
    return dwHashIndex;
}

static const char * GetPatchFileName(TMPQArchive * ha, const char * szFileName, char * szBuffer)
{
    TMPQNamePrefix * pPrefix;

    // Are there patches in the current MPQ?
    if(ha->dwFlags & MPQ_FLAG_PATCH)
    {
        // The patch prefix must be already known here
        assert(ha->pPatchPrefix != NULL);
        pPrefix = ha->pPatchPrefix;

        // The patch name for "OldWorld\\XXX\\YYY" is "Base\\XXX\YYY"
        // We need to remove the "OldWorld\\" prefix
        if(!_strnicmp(szFileName, "OldWorld\\", 9))
            szFileName += 9;

        // Create the file name from the known patch entry
        memcpy(szBuffer, pPrefix->szPatchPrefix, pPrefix->nLength);
        strcpy(szBuffer + pPrefix->nLength, szFileName);
        szFileName = szBuffer;
    }

    return szFileName;
}

static bool OpenLocalFile(const char * szFileName, HANDLE * PtrFile)
{
    TFileStream * pStream;
    TMPQFile * hf = NULL;
    TCHAR szFileNameT[MAX_PATH];

    // Convert the file name to UNICODE (if needed)
    StringCopy(szFileNameT, _countof(szFileNameT), szFileName);

    // Open the file and create the TMPQFile structure
    pStream = FileStream_OpenFile(szFileNameT, STREAM_FLAG_READ_ONLY);
    if(pStream != NULL)
    {
        // Allocate and initialize file handle
        hf = CreateFileHandle(NULL, NULL);
        if(hf != NULL)
        {
            hf->pStream = pStream;
            *PtrFile = hf;
            return true;
        }
        else
        {
            FileStream_Close(pStream);
            SErrSetLastError(ERROR_NOT_ENOUGH_MEMORY);
        }
    }
    *PtrFile = NULL;
    return false;
}

bool OpenPatchedFile(HANDLE hMpq, const char * szFileName, HANDLE * PtrFile)
{
    TMPQArchive * haBase = NULL;
    TMPQArchive * ha = (TMPQArchive *)hMpq;
    TFileEntry * pFileEntry;
    TMPQFile * hfPatch;                     // Pointer to patch file
    TMPQFile * hfBase = NULL;               // Pointer to base open file
    TMPQFile * hf = NULL;
    HANDLE hPatchFile;
    char szNameBuffer[MAX_PATH];

    // First of all, find the latest archive where the file is in base version
    // (i.e. where the original, unpatched version of the file exists)
    while(ha != NULL)
    {
        // If the file is there, then we remember the archive
        pFileEntry = GetFileEntryExact(ha, GetPatchFileName(ha, szFileName, szNameBuffer), 0, NULL);
        if(pFileEntry != NULL && (pFileEntry->dwFlags & MPQ_FILE_PATCH_FILE) == 0)
            haBase = ha;

        // Move to the patch archive
        ha = ha->haPatch;
    }

    // If we couldn't find the base file in any of the patches, it doesn't exist
    if((ha = haBase) != NULL)
    {
        // Now open the base file
        if(SFileOpenFileEx((HANDLE)ha, GetPatchFileName(ha, szFileName, szNameBuffer), SFILE_OPEN_BASE_FILE, (HANDLE *)&hfBase))
        {
            // The file must be a base file, i.e. without MPQ_FILE_PATCH_FILE
            assert((hfBase->pFileEntry->dwFlags & MPQ_FILE_PATCH_FILE) == 0);
            hf = hfBase;

            // Now open all patches and attach them on top of the base file
            for(ha = ha->haPatch; ha != NULL; ha = ha->haPatch)
            {
                // Prepare the file name with a correct prefix
                if(SFileOpenFileEx((HANDLE)ha, GetPatchFileName(ha, szFileName, szNameBuffer), SFILE_OPEN_BASE_FILE, &hPatchFile))
                {
                    // Remember the new version
                    hfPatch = (TMPQFile *)hPatchFile;

                    // We should not find patch file
                    assert((hfPatch->pFileEntry->dwFlags & MPQ_FILE_PATCH_FILE) != 0);

                    // Attach the patch to the base file
                    hf->hfPatch = hfPatch;
                    hf = hfPatch;
                }
            }

            // If the opened file has the delete marker, we don't open the file
            if(hfBase && hf && hf->pFileEntry->dwFlags & MPQ_FILE_DELETE_MARKER)
            {
                SFileCloseFile((HANDLE)(hfBase));
                SErrSetLastError(ERROR_FILE_DELETED);
                hfBase = NULL;
            }
        }
    }
    else
    {
        SErrSetLastError(ERROR_FILE_NOT_FOUND);
    }

    // Give the updated base MPQ
    if(PtrFile != NULL)
        *PtrFile = (HANDLE)hfBase;
    return (hfBase != NULL);
}

/*****************************************************************************/
/* Public functions                                                          */
/*****************************************************************************/

//-----------------------------------------------------------------------------
// SFileEnumLocales enums all locale versions within MPQ.
// Functions fills all available language identifiers on a file into the buffer
// pointed by PtrFileLocales. There must be enough entries to copy the localed,
// otherwise the function returns ERROR_INSUFFICIENT_BUFFER.

DWORD WINAPI SFileEnumLocales(
    HANDLE hMpq,
    const char * szFileName,
    LCID * PtrFileLocales,
    LPDWORD PtrMaxLocales,
    DWORD dwSearchScope)
{
    TMPQArchive * ha = (TMPQArchive *)hMpq;
    TMPQHash * pFirstHash;
    TMPQHash * pHash;
    DWORD dwFileIndex = 0;
    DWORD dwMaxLocales;
    DWORD dwLocales = 0;

    // Test the parameters
    if(!IsValidMpqHandle(hMpq))
        return ERROR_INVALID_HANDLE;
    if(szFileName == NULL || *szFileName == 0)
        return ERROR_INVALID_PARAMETER;
    if(ha->pHashTable == NULL)
        return ERROR_NOT_SUPPORTED;
    if(PtrMaxLocales == NULL)
        return ERROR_INVALID_PARAMETER;
    if(IsPseudoFileName(szFileName, &dwFileIndex))
        return ERROR_INVALID_PARAMETER;

    // Keep compilers happy
    dwMaxLocales = PtrMaxLocales[0];
    STORMLIB_UNUSED(dwSearchScope);

    // Parse all files with that name
    pFirstHash = pHash = GetFirstHashEntry(ha, szFileName);
    while(pHash != NULL)
    {
        // Put the locales to the buffer
        if(PtrFileLocales != NULL && dwLocales < dwMaxLocales)
            *PtrFileLocales++ = SFILE_MAKE_LCID(pHash->Locale, pHash->Platform);
        dwLocales++;

        // Get the next locale
        pHash = GetNextHashEntry(ha, pFirstHash, pHash);
    }

    // Give the caller the number of locales and return
    PtrMaxLocales[0] = dwLocales;
    return (dwLocales <= dwMaxLocales) ? ERROR_SUCCESS : ERROR_INSUFFICIENT_BUFFER;
}

//-----------------------------------------------------------------------------
// SFileOpenFileEx
//
//   hMpq          - Handle of opened MPQ archive
//   szFileName    - Name of file to open
//   dwSearchScope - Where to search
//   PtrFile       - Pointer to store opened file handle

bool WINAPI SFileOpenFileEx(HANDLE hMpq, const char * szFileName, DWORD dwSearchScope, HANDLE * PtrFile)
{
    TMPQArchive * ha = IsValidMpqHandle(hMpq);
    TFileEntry  * pFileEntry = NULL;
    TMPQFile    * hf = NULL;
    DWORD dwHashIndex = HASH_ENTRY_FREE;
    DWORD dwFileIndex = 0;
    DWORD dwErrCode = ERROR_SUCCESS;
    bool bOpenByIndex = false;

    // Don't accept NULL pointer to file handle
    if(szFileName == NULL || *szFileName == 0)
        dwErrCode = ERROR_INVALID_PARAMETER;

    // When opening a file from MPQ, the handle must be valid
    if(dwSearchScope != SFILE_OPEN_LOCAL_FILE && ha == NULL)
        dwErrCode = ERROR_INVALID_HANDLE;

    // When not checking for existence, the pointer to file handle must be valid
    if(dwSearchScope != SFILE_OPEN_CHECK_EXISTS && PtrFile == NULL)
        dwErrCode = ERROR_INVALID_PARAMETER;

    // Prepare the file opening
    if(dwErrCode == ERROR_SUCCESS)
    {
        switch(dwSearchScope)
        {
            case SFILE_OPEN_FROM_MPQ:
            case SFILE_OPEN_BASE_FILE:
            case SFILE_OPEN_CHECK_EXISTS:

                // If this MPQ has no patches, open the file from this MPQ directly
                if(ha->haPatch == NULL || dwSearchScope == SFILE_OPEN_BASE_FILE)
                {
                    pFileEntry = GetFileEntryLocale(ha, szFileName, g_lcFileLocale, &dwHashIndex);
                }

                // If this MPQ is a patched archive, open the file as patched
                else
                {
                    return OpenPatchedFile(hMpq, szFileName, PtrFile);
                }
                break;

            case SFILE_OPEN_ANY_LOCALE:

                // This open option is reserved for opening MPQ internal listfile.
                // No argument validation. Tries to open file with neutral locale first,
                // then any other available.
                pFileEntry = GetFileEntryLocale(ha, szFileName, 0, &dwHashIndex);
                break;

            case SFILE_OPEN_LOCAL_FILE:

                // Open a local file
                return OpenLocalFile(szFileName, PtrFile);

            default:

                // Don't accept any other value
                dwErrCode = ERROR_INVALID_PARAMETER;
                break;
        }
    }

    // Check whether the file really exists in the MPQ
    if(dwErrCode == ERROR_SUCCESS)
    {
        // If we didn't find the file, try to open it using pseudo file name ("File
        if(pFileEntry == NULL || (pFileEntry->dwFlags & MPQ_FILE_EXISTS) == 0)
        {
            // Check the pseudo-file name ("File00000001.ext")
            if((bOpenByIndex = IsPseudoFileName(szFileName, &dwFileIndex)) == true)
            {
                // Get the file entry for the file
                if(dwFileIndex < ha->dwFileTableSize)
                {
                    pFileEntry = ha->pFileTable + dwFileIndex;
                }
            }

            // Still not found?
            if(pFileEntry == NULL || (pFileEntry->dwFlags & MPQ_FILE_EXISTS) == 0)
            {
                dwErrCode = ERROR_FILE_NOT_FOUND;
            }
        }

        // Perform some checks of invalid files
        if(pFileEntry != NULL)
        {
            // MPQ protectors use insanely amount of fake files, often with very high size.
            // We won't open any files whose compressed size is bigger than archive size
            // If the file is not compressed, its size cannot be bigger than archive size
            if((pFileEntry->dwFlags & MPQ_FILE_COMPRESS_MASK) == 0 && (pFileEntry->dwFileSize > ha->FileSize))
            {
                dwErrCode = ERROR_FILE_CORRUPT;
                pFileEntry = NULL;
            }

            // Ignore unknown loading flags (example: MPQ_2016_v1_WME4_4.w3x)
//          if(pFileEntry->dwFlags & ~MPQ_FILE_VALID_FLAGS)
//          {
//              dwErrCode = ERROR_NOT_SUPPORTED;
//              pFileEntry = NULL;
//          }
        }
    }

    // Did the caller just wanted to know if the file exists?
    if(dwErrCode == ERROR_SUCCESS && dwSearchScope != SFILE_OPEN_CHECK_EXISTS)
    {
        // Allocate file handle
        hf = CreateFileHandle(ha, pFileEntry);
        if(hf != NULL)
        {
            // Get the hash index for the file
            if(ha->pHashTable != NULL && dwHashIndex == HASH_ENTRY_FREE)
                dwHashIndex = FindHashIndex(ha, dwFileIndex);
            if(dwHashIndex != HASH_ENTRY_FREE)
                hf->pHashEntry = ha->pHashTable + dwHashIndex;
            hf->dwHashIndex = dwHashIndex;

            // If the MPQ has sector CRC enabled, enable if for the file
            if(ha->dwFlags & MPQ_FLAG_CHECK_SECTOR_CRC)
                hf->bCheckSectorCRCs = true;

            // If we know the real file name, copy it to the file entry
            if(bOpenByIndex == false)
            {
                // If there is no file name yet, allocate it
                AllocateFileName(ha, pFileEntry, szFileName);

                // If the file is encrypted, we should detect the file key
                if(pFileEntry->dwFlags & MPQ_FILE_ENCRYPTED)
                {
                    hf->dwFileKey = DecryptFileKey(szFileName,
                                                   pFileEntry->ByteOffset,
                                                   pFileEntry->dwFileSize,
                                                   pFileEntry->dwFlags);
                }
            }
        }
        else
        {
            dwErrCode = ERROR_NOT_ENOUGH_MEMORY;
        }
    }

    // Give the file entry
    if(PtrFile != NULL)
        PtrFile[0] = hf;

    // Return error code
    if(dwErrCode != ERROR_SUCCESS)
        SErrSetLastError(dwErrCode);
    return (dwErrCode == ERROR_SUCCESS);
}

//-----------------------------------------------------------------------------
// SFileHasFile
//
//   hMpq          - Handle of opened MPQ archive
//   szFileName    - Name of file to look for

bool WINAPI SFileHasFile(HANDLE hMpq, const char * szFileName)
{
    return SFileOpenFileEx(hMpq, szFileName, SFILE_OPEN_CHECK_EXISTS, NULL);
}

//-----------------------------------------------------------------------------
// bool WINAPI SFileCloseFile(HANDLE hFile);

bool WINAPI SFileCloseFile(HANDLE hFile)
{
    TMPQFile * hf = (TMPQFile *)hFile;

    if(!IsValidFileHandle(hFile))
    {
        SErrSetLastError(ERROR_INVALID_HANDLE);
        return false;
    }

    // Free the structure
    FreeFileHandle(hf);
    return true;
}
