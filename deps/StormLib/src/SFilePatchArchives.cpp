/*****************************************************************************/
/* SFilePatchArchives.cpp                 Copyright (c) Ladislav Zezula 2010 */
/*---------------------------------------------------------------------------*/
/* Description:                                                              */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 18.08.10  1.00  Lad  The first version of SFilePatchArchives.cpp          */
/*****************************************************************************/

#define __STORMLIB_SELF__
#include "StormLib.h"
#include "StormCommon.h"

//-----------------------------------------------------------------------------
// Local structures

#define MAX_SC2_PATCH_PREFIX   0x80

#define PATCH_SIGNATURE_HEADER 0x48435450
#define PATCH_SIGNATURE_MD5    0x5f35444d
#define PATCH_SIGNATURE_XFRM   0x4d524658

#define SIZE_OF_XFRM_HEADER  0x0C

// Header for incremental patch files
typedef struct _MPQ_PATCH_HEADER
{
    //-- PATCH header -----------------------------------
    DWORD dwSignature;                          // 'PTCH'
    DWORD dwSizeOfPatchData;                    // Size of the entire patch (decompressed)
    DWORD dwSizeBeforePatch;                    // Size of the file before patch
    DWORD dwSizeAfterPatch;                     // Size of file after patch

    //-- MD5 block --------------------------------------
    DWORD dwMD5;                                // 'MD5_'
    DWORD dwMd5BlockSize;                       // Size of the MD5 block, including the signature and size itself
    BYTE md5_before_patch[0x10];                // MD5 of the original (unpached) file
    BYTE md5_after_patch[0x10];                 // MD5 of the patched file

    //-- XFRM block -------------------------------------
    DWORD dwXFRM;                               // 'XFRM'
    DWORD dwXfrmBlockSize;                      // Size of the XFRM block, includes XFRM header and patch data
    DWORD dwPatchType;                          // Type of patch ('BSD0' or 'COPY')

    // Followed by the patch data
} MPQ_PATCH_HEADER, *PMPQ_PATCH_HEADER;

typedef struct _BLIZZARD_BSDIFF40_FILE
{
    ULONGLONG Signature;
    ULONGLONG CtrlBlockSize;
    ULONGLONG DataBlockSize;
    ULONGLONG NewFileSize;
} BLIZZARD_BSDIFF40_FILE, *PBLIZZARD_BSDIFF40_FILE;

typedef struct _BSDIFF_CTRL_BLOCK
{
    DWORD dwAddDataLength;
    DWORD dwMovDataLength;
    DWORD dwOldMoveLength;

} BSDIFF_CTRL_BLOCK, *PBSDIFF_CTRL_BLOCK;

typedef struct _LOCALIZED_MPQ_INFO
{
    const char * szNameTemplate;            // Name template
    size_t nLangOffset;                     // Offset of the language
    size_t nLength;                         // Length of the name template
} LOCALIZED_MPQ_INFO, *PLOCALIZED_MPQ_INFO;

//-----------------------------------------------------------------------------
// Local variables

// 4-byte groups for all languages
static const char * LanguageList = "baseteenenUSenGBenCNenTWdeDEesESesMXfrFRitITkoKRptBRptPTruRUzhCNzhTW";

// List of localized MPQs for World of Warcraft
static LOCALIZED_MPQ_INFO LocaleMpqs_WoW[] =
{
    {"expansion1-locale-####", 18, 22},
    {"expansion1-speech-####", 18, 22},
    {"expansion2-locale-####", 18, 22},
    {"expansion2-speech-####", 18, 22},
    {"expansion3-locale-####", 18, 22},
    {"expansion3-speech-####", 18, 22},
    {"locale-####",             7, 11},
    {"speech-####",             7, 11},
    {NULL, 0, 0}
};

//-----------------------------------------------------------------------------
// Local functions

static inline bool IsPatchMetadataFile(TFileEntry * pFileEntry)
{
    // The file must ave a name
    if(pFileEntry->szFileName != NULL && (pFileEntry->dwFlags & MPQ_FILE_PATCH_FILE) == 0)
    {
        // The file must be small
        if(0 < pFileEntry->dwFileSize && pFileEntry->dwFileSize < 0x40)
        {
            // Compare the plain name
            return (_stricmp(GetPlainFileName(pFileEntry->szFileName), PATCH_METADATA_NAME) == 0);
        }
    }

    // Not a patch_metadata
    return false;
}

static void Decompress_RLE(LPBYTE pbDecompressed, DWORD cbDecompressed, LPBYTE pbCompressed, DWORD cbCompressed)
{
    LPBYTE pbDecompressedEnd = pbDecompressed + cbDecompressed;
    LPBYTE pbCompressedEnd = pbCompressed + cbCompressed;
    BYTE RepeatCount;
    BYTE OneByte;

    // Cut the initial DWORD from the compressed chunk
    pbCompressed += sizeof(DWORD);

    // Pre-fill decompressed buffer with zeros
    memset(pbDecompressed, 0, cbDecompressed);

    // Unpack
    while(pbCompressed < pbCompressedEnd && pbDecompressed < pbDecompressedEnd)
    {
        OneByte = *pbCompressed++;

        // Is it a repetition byte ?
        if(OneByte & 0x80)
        {
            RepeatCount = (OneByte & 0x7F) + 1;
            for(BYTE i = 0; i < RepeatCount; i++)
            {
                if(pbDecompressed == pbDecompressedEnd || pbCompressed == pbCompressedEnd)
                    break;

                *pbDecompressed++ = *pbCompressed++;
            }
        }
        else
        {
            pbDecompressed += (OneByte + 1);
        }
    }
}

static DWORD LoadFilePatch_COPY(TMPQFile * hf, PMPQ_PATCH_HEADER pFullPatch)
{
    DWORD cbBytesToRead = pFullPatch->dwSizeOfPatchData - sizeof(MPQ_PATCH_HEADER);
    DWORD cbBytesRead = 0;

    // Simply load the rest of the patch
    SFileReadFile((HANDLE)hf, (pFullPatch + 1), cbBytesToRead, &cbBytesRead, NULL);
    return (cbBytesRead == cbBytesToRead) ? ERROR_SUCCESS : ERROR_FILE_CORRUPT;
}

static DWORD LoadFilePatch_BSD0(TMPQFile * hf, PMPQ_PATCH_HEADER pFullPatch)
{
    LPBYTE pbDecompressed = (LPBYTE)(pFullPatch + 1);
    LPBYTE pbCompressed = NULL;
    DWORD cbDecompressed = 0;
    DWORD cbCompressed = 0;
    DWORD dwBytesRead = 0;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Calculate the size of compressed data
    cbDecompressed = pFullPatch->dwSizeOfPatchData - sizeof(MPQ_PATCH_HEADER);
    cbCompressed = pFullPatch->dwXfrmBlockSize - SIZE_OF_XFRM_HEADER;

    // Is that file compressed?
    if(cbCompressed < cbDecompressed)
    {
        pbCompressed = STORM_ALLOC(BYTE, cbCompressed);
        if(pbCompressed == NULL)
            dwErrCode = ERROR_NOT_ENOUGH_MEMORY;

        // Read the compressed patch data
        if(dwErrCode == ERROR_SUCCESS)
        {
            SFileReadFile((HANDLE)hf, pbCompressed, cbCompressed, &dwBytesRead, NULL);
            if(dwBytesRead != cbCompressed)
                dwErrCode = ERROR_FILE_CORRUPT;
        }

        // Decompress the data
        if(dwErrCode == ERROR_SUCCESS)
            Decompress_RLE(pbDecompressed, cbDecompressed, pbCompressed, cbCompressed);

        if(pbCompressed != NULL)
            STORM_FREE(pbCompressed);
    }
    else
    {
        SFileReadFile((HANDLE)hf, pbDecompressed, cbDecompressed, &dwBytesRead, NULL);
        if(dwBytesRead != cbDecompressed)
            dwErrCode = ERROR_FILE_CORRUPT;
    }

    return dwErrCode;
}

static DWORD ApplyFilePatch_COPY(
    TMPQPatcher * pPatcher,
    PMPQ_PATCH_HEADER pFullPatch,
    LPBYTE pbTarget,
    LPBYTE pbSource)
{
    // Sanity checks
    assert(pPatcher->cbMaxFileData >= pPatcher->cbFileData);
    pFullPatch = pFullPatch;

    // Copy the patch data as-is
    memcpy(pbTarget, pbSource, pPatcher->cbFileData);
    return ERROR_SUCCESS;
}

static DWORD ApplyFilePatch_BSD0(
    TMPQPatcher * pPatcher,
    PMPQ_PATCH_HEADER pFullPatch,
    LPBYTE pbTarget,
    LPBYTE pbSource)
{
    PBLIZZARD_BSDIFF40_FILE pBsdiff;
    PBSDIFF_CTRL_BLOCK pCtrlBlock;
    LPBYTE pbPatchData = (LPBYTE)(pFullPatch + 1);
    LPBYTE pDataBlock;
    LPBYTE pExtraBlock;
    LPBYTE pbOldData = pbSource;
    LPBYTE pbNewData = pbTarget;
    DWORD dwCombineSize;
    DWORD dwNewOffset = 0;                          // Current position to patch
    DWORD dwOldOffset = 0;                          // Current source position
    DWORD dwNewSize;                                // Patched file size
    DWORD dwOldSize = pPatcher->cbFileData;         // File size before patch

    // Get pointer to the patch header
    // Format of BSDIFF header corresponds to original BSDIFF, which is:
    // 0000   8 bytes   signature "BSDIFF40"
    // 0008   8 bytes   size of the control block
    // 0010   8 bytes   size of the data block
    // 0018   8 bytes   new size of the patched file
    pBsdiff = (PBLIZZARD_BSDIFF40_FILE)pbPatchData;
    pbPatchData += sizeof(BLIZZARD_BSDIFF40_FILE);

    // Get pointer to the 32-bit BSDIFF control block
    // The control block follows immediately after the BSDIFF header
    // and consists of three 32-bit integers
    // 0000   4 bytes   Length to copy from the BSDIFF data block the new file
    // 0004   4 bytes   Length to copy from the BSDIFF extra block
    // 0008   4 bytes   Size to increment source file offset
    pCtrlBlock = (PBSDIFF_CTRL_BLOCK)pbPatchData;
    pbPatchData += (size_t)BSWAP_INT64_UNSIGNED(pBsdiff->CtrlBlockSize);

    // Get the pointer to the data block
    pDataBlock = (LPBYTE)pbPatchData;
    pbPatchData += (size_t)BSWAP_INT64_UNSIGNED(pBsdiff->DataBlockSize);

    // Get the pointer to the extra block
    pExtraBlock = (LPBYTE)pbPatchData;
    dwNewSize = (DWORD)BSWAP_INT64_UNSIGNED(pBsdiff->NewFileSize);

    // Now patch the file
    while(dwNewOffset < dwNewSize)
    {
        DWORD dwAddDataLength = BSWAP_INT32_UNSIGNED(pCtrlBlock->dwAddDataLength);
        DWORD dwMovDataLength = BSWAP_INT32_UNSIGNED(pCtrlBlock->dwMovDataLength);
        DWORD dwOldMoveLength = BSWAP_INT32_UNSIGNED(pCtrlBlock->dwOldMoveLength);
        DWORD i;

        // Sanity check
        if((dwNewOffset + dwAddDataLength) > dwNewSize)
            return ERROR_FILE_CORRUPT;

        // Read the diff string to the target buffer
        memcpy(pbNewData + dwNewOffset, pDataBlock, dwAddDataLength);
        pDataBlock += dwAddDataLength;

        // Get the longest block that we can combine
        dwCombineSize = ((dwOldOffset + dwAddDataLength) >= dwOldSize) ? (dwOldSize - dwOldOffset) : dwAddDataLength;
        if((dwNewOffset + dwCombineSize) > dwNewSize || (dwNewOffset + dwCombineSize) < dwNewOffset)
            return ERROR_FILE_CORRUPT;

        // Now combine the patch data with the original file
        for(i = 0; i < dwCombineSize; i++)
            pbNewData[dwNewOffset + i] = pbNewData[dwNewOffset + i] + pbOldData[dwOldOffset + i];

        // Move the offsets
        dwNewOffset += dwAddDataLength;
        dwOldOffset += dwAddDataLength;

        // Sanity check
        if((dwNewOffset + dwMovDataLength) > dwNewSize)
            return ERROR_FILE_CORRUPT;

        // Copy the data from the extra block in BSDIFF patch
        memcpy(pbNewData + dwNewOffset, pExtraBlock, dwMovDataLength);
        pExtraBlock += dwMovDataLength;
        dwNewOffset += dwMovDataLength;

        // Move the old offset
        if(dwOldMoveLength & 0x80000000)
            dwOldMoveLength = 0x80000000 - dwOldMoveLength;
        dwOldOffset += dwOldMoveLength;
        pCtrlBlock++;
    }

    // The size after patch must match
    if(dwNewOffset != pFullPatch->dwSizeAfterPatch)
        return ERROR_FILE_CORRUPT;

    // Update the new data size
    pPatcher->cbFileData = dwNewOffset;
    return ERROR_SUCCESS;
}

static PMPQ_PATCH_HEADER LoadFullFilePatch(TMPQFile * hf, MPQ_PATCH_HEADER & PatchHeader)
{
    PMPQ_PATCH_HEADER pFullPatch;
    DWORD dwErrCode = ERROR_SUCCESS;

    // BSWAP the entire header, if needed
    BSWAP_ARRAY32_UNSIGNED(&PatchHeader, sizeof(DWORD) * 6);
    BSWAP_ARRAY32_UNSIGNED(&PatchHeader.dwXFRM, sizeof(DWORD) * 3);

    // Verify the signatures in the patch header
    if(PatchHeader.dwSignature != PATCH_SIGNATURE_HEADER || PatchHeader.dwMD5 != PATCH_SIGNATURE_MD5 || PatchHeader.dwXFRM != PATCH_SIGNATURE_XFRM)
        return NULL;

    // Allocate space for patch header and compressed data
    pFullPatch = (PMPQ_PATCH_HEADER)STORM_ALLOC(BYTE, PatchHeader.dwSizeOfPatchData);
    if(pFullPatch != NULL)
    {
        // Copy the patch header
        memcpy(pFullPatch, &PatchHeader, sizeof(MPQ_PATCH_HEADER));

        // Read the patch, depending on patch type
        if(dwErrCode == ERROR_SUCCESS)
        {
            switch(PatchHeader.dwPatchType)
            {
                case 0x59504f43:    // 'COPY'
                    dwErrCode = LoadFilePatch_COPY(hf, pFullPatch);
                    break;

                case 0x30445342:    // 'BSD0'
                    dwErrCode = LoadFilePatch_BSD0(hf, pFullPatch);
                    break;

                default:
                    dwErrCode = ERROR_FILE_CORRUPT;
                    break;
            }
        }

        // If something failed, free the patch buffer
        if(dwErrCode != ERROR_SUCCESS)
        {
            STORM_FREE(pFullPatch);
            pFullPatch = NULL;
        }
    }

    // Give the result to the caller
    return pFullPatch;
}

static DWORD ApplyFilePatch(
    TMPQPatcher * pPatcher,
    PMPQ_PATCH_HEADER pFullPatch)
{
    LPBYTE pbSource = (pPatcher->nCounter & 0x1) ? pPatcher->pbFileData2 : pPatcher->pbFileData1;
    LPBYTE pbTarget = (pPatcher->nCounter & 0x1) ? pPatcher->pbFileData1 : pPatcher->pbFileData2;
    DWORD dwErrCode;

    // Sanity checks
    assert(pFullPatch->dwSizeAfterPatch <= pPatcher->cbMaxFileData);

    // Apply the patch according to the type
    switch(pFullPatch->dwPatchType)
    {
        case 0x59504f43:    // 'COPY'
            dwErrCode = ApplyFilePatch_COPY(pPatcher, pFullPatch, pbTarget, pbSource);
            break;

        case 0x30445342:    // 'BSD0'
            dwErrCode = ApplyFilePatch_BSD0(pPatcher, pFullPatch, pbTarget, pbSource);
            break;

        default:
            dwErrCode = ERROR_FILE_CORRUPT;
            break;
    }

    // Verify MD5 after patch
    if(dwErrCode == ERROR_SUCCESS && pFullPatch->dwSizeAfterPatch != 0)
    {
        // Verify the patched file
        if(!VerifyDataBlockHash(pbTarget, pFullPatch->dwSizeAfterPatch, pFullPatch->md5_after_patch))
            dwErrCode = ERROR_FILE_CORRUPT;

        // Copy the MD5 of the new block
        memcpy(pPatcher->this_md5, pFullPatch->md5_after_patch, MD5_DIGEST_SIZE);
    }

    return dwErrCode;
}

//-----------------------------------------------------------------------------
// Local functions (patch prefix matching)

static bool CreatePatchPrefix(TMPQArchive * ha, const char * szFileName, size_t nLength)
{
    TMPQNamePrefix * pNewPrefix;

    // If the length of the patch prefix was not entered, find it
    // Not that the patch prefix must always begin with backslash
    if(szFileName != NULL && nLength == 0)
        nLength = strlen(szFileName);

    // Create the patch prefix
    pNewPrefix = (TMPQNamePrefix *)STORM_ALLOC(BYTE, sizeof(TMPQNamePrefix) + nLength + 1);
    if(pNewPrefix != NULL)
    {
        // Fill the name prefix. Also add the backslash
        if(szFileName && nLength)
        {
            memcpy(pNewPrefix->szPatchPrefix, szFileName, nLength);
            if(pNewPrefix->szPatchPrefix[nLength - 1] != '\\')
                pNewPrefix->szPatchPrefix[nLength++] = '\\';
        }

        // Terminate the string and fill the length
        pNewPrefix->szPatchPrefix[nLength] = 0;
        pNewPrefix->nLength = nLength;
    }

    ha->pPatchPrefix = pNewPrefix;
    return (pNewPrefix != NULL);
}

static bool CheckAndCreatePatchPrefix(TMPQArchive * ha, const char * szPatchPrefix, size_t nLength)
{
    char szTempName[MAX_SC2_PATCH_PREFIX + 0x41];
    bool bResult = false;

    // Prepare the patch file name
    if(nLength > MAX_SC2_PATCH_PREFIX)
        return false;

    // Prepare the patched file name
    memcpy(szTempName, szPatchPrefix, nLength);
    memcpy(&szTempName[nLength], "\\(patch_metadata)", 18);

    // Verifywhether that file exists
    if(GetFileEntryLocale(ha, szTempName, 0) != NULL)
        bResult = CreatePatchPrefix(ha, szPatchPrefix, nLength);

    return bResult;
}

static bool IsMatchingPatchFile(
    TMPQArchive * ha,
    const char * szFileName,
    LPBYTE pbBaseFileMd5)
{
    MPQ_PATCH_HEADER PatchHeader = {0};
    HANDLE hFile = NULL;
    DWORD dwTransferred = 0;
    DWORD dwFlags = 0;
    bool bResult = false;

    // Open the file and load the patch header
    if(SFileOpenFileEx((HANDLE)ha, szFileName, SFILE_OPEN_BASE_FILE, &hFile))
    {
        // Retrieve the flags. We need to know whether the file is a patch or not
        SFileGetFileInfo(hFile, SFileInfoFlags, &dwFlags, sizeof(DWORD), &dwTransferred);
        if(dwFlags & MPQ_FILE_PATCH_FILE)
        {
            // Load the patch header
            SFileReadFile(hFile, &PatchHeader, sizeof(MPQ_PATCH_HEADER), &dwTransferred, NULL);
            BSWAP_ARRAY32_UNSIGNED(&PatchHeader, sizeof(DWORD) * 6);

            // If the file contains an incremental patch,
            // compare the "MD5 before patching" with the base file MD5
            if(dwTransferred == sizeof(MPQ_PATCH_HEADER) && PatchHeader.dwSignature == PATCH_SIGNATURE_HEADER)
                bResult = (!memcmp(PatchHeader.md5_before_patch, pbBaseFileMd5, MD5_DIGEST_SIZE));
        }
        else
        {
            // TODO: How to match it if it's not an incremental patch?
            // Example: StarCraft II\Updates\enGB\s2-update-enGB-23258.MPQ:
            //          Mods\Core.SC2Mod\enGB.SC2Assets\StreamingBuckets.txt"
            bResult = false;
        }

        // Close the file
        SFileCloseFile(hFile);
    }

    return bResult;
}

static const char * FindArchiveLanguage(TMPQArchive * ha, PLOCALIZED_MPQ_INFO pMpqInfo)
{
    TFileEntry * pFileEntry;
    const char * szLanguage = LanguageList;
    char szFileName[0x40];

    // Iterate through all localized languages
    while(pMpqInfo->szNameTemplate != NULL)
    {
        // Iterate through all languages
        for(szLanguage = LanguageList; szLanguage[0] != 0; szLanguage += 4)
        {
            // Construct the file name
            memcpy(szFileName, pMpqInfo->szNameTemplate, pMpqInfo->nLength);
            szFileName[pMpqInfo->nLangOffset + 0] = szLanguage[0];
            szFileName[pMpqInfo->nLangOffset + 1] = szLanguage[1];
            szFileName[pMpqInfo->nLangOffset + 2] = szLanguage[2];
            szFileName[pMpqInfo->nLangOffset + 3] = szLanguage[3];

            // Append the suffix
            memcpy(szFileName + pMpqInfo->nLength, "-md5.lst", 9);

            // Check whether the name exists
            pFileEntry = GetFileEntryLocale(ha, szFileName, 0);
            if(pFileEntry != NULL)
                return szLanguage;
        }

        // Move to the next language name
        pMpqInfo++;
    }

    // Not found
    return NULL;
}

//-----------------------------------------------------------------------------
// Finding ratch prefix for an temporary build of WoW (Pre-Cataclysm)

static bool FindPatchPrefix_WoW_13164_13623(TMPQArchive * haBase, TMPQArchive * haPatch)
{
    const char * szPatchPrefix;
    char szNamePrefix[0x08];

    // Try to find the language of the MPQ archive
    szPatchPrefix = FindArchiveLanguage(haBase, LocaleMpqs_WoW);
    if(szPatchPrefix == NULL)
        szPatchPrefix = "Base";

    // Format the patch prefix
    szNamePrefix[0] = szPatchPrefix[0];
    szNamePrefix[1] = szPatchPrefix[1];
    szNamePrefix[2] = szPatchPrefix[2];
    szNamePrefix[3] = szPatchPrefix[3];
    szNamePrefix[4] = '\\';
    szNamePrefix[5] = 0;
    return CreatePatchPrefix(haPatch, szNamePrefix, 5);
}

//-----------------------------------------------------------------------------
// Finding patch prefix for Starcraft II (Pre-Legacy of the Void)

//
// This method tries to match the patch by placement of the archive (in the game subdirectory)
//
// Archive Path: %GAME_DIR%\Mods\SwarmMulti.SC2Mod\Base.SC2Data
// Patch Prefix: Mods\SwarmMulti.SC2Mod\Base.SC2Data
//
// Archive Path: %ANY_DIR%\MPQ_2013_v4_Mods#Liberty.SC2Mod#enGB.SC2Data
// Patch Prefix: Mods\Liberty.SC2Mod\enGB.SC2Data
//

static bool CheckPatchPrefix_SC2_ArchiveName(
    TMPQArchive * haPatch,
    const TCHAR * szPathPtr,
    const TCHAR * szSeparator,
    const TCHAR * szPathEnd,
    const TCHAR * szExpectedString,
    size_t cchExpectedString)
{
    char szPatchPrefix[MAX_SC2_PATCH_PREFIX+0x41];
    size_t nLength = 0;
    bool bResult = false;

    // Check whether the length is equal to the length of the expected string
    if((size_t)(szSeparator - szPathPtr) == cchExpectedString)
    {
        // Now check the string itself
        if(!_tcsnicmp(szPathPtr, szExpectedString, szSeparator - szPathPtr))
        {
            // Copy the name string
            for(; szPathPtr < szPathEnd; szPathPtr++)
            {
                if(szPathPtr[0] != _T('/') && szPathPtr[0] != _T('#'))
                    szPatchPrefix[nLength++] = (char)szPathPtr[0];
                else
                    szPatchPrefix[nLength++] = '\\';
            }

            // Check and create the patch prefix
            bResult = CheckAndCreatePatchPrefix(haPatch, szPatchPrefix, nLength);
        }
    }

    return bResult;
}

static bool FindPatchPrefix_SC2_ArchiveName(TMPQArchive * haBase, TMPQArchive * haPatch)
{
    const TCHAR * szPathBegin = FileStream_GetFileName(haBase->pStream);
    const TCHAR * szSeparator = NULL;
    const TCHAR * szPathEnd = szPathBegin + _tcslen(szPathBegin);
    const TCHAR * szPathPtr;
    int nSlashCount = 0;
    int nDotCount = 0;

    // Skip the part where the patch prefix would be too long
    if((szPathEnd - szPathBegin) > MAX_SC2_PATCH_PREFIX)
        szPathBegin = szPathEnd - MAX_SC2_PATCH_PREFIX;

    // Search for the file extension
    for(szPathPtr = szPathEnd; szPathPtr > szPathBegin; szPathPtr--)
    {
        if(szPathPtr[0] == _T('.'))
        {
            nDotCount++;
            break;
        }
    }

    // Search for the possible begin of the prefix name
    for(/* NOTHING */; szPathPtr > szPathBegin; szPathPtr--)
    {
        // Check the slashes, backslashes and hashes
        if(szPathPtr[0] == _T('\\') || szPathPtr[0] == _T('/') || szPathPtr[0] == _T('#'))
        {
            if(nDotCount == 0)
                return false;
            szSeparator = szPathPtr;
            nSlashCount++;
        }

        // Check the path parts
        if(szSeparator != NULL && nSlashCount >= nDotCount)
        {
            if(CheckPatchPrefix_SC2_ArchiveName(haPatch, szPathPtr, szSeparator, szPathEnd, _T("Battle.net"), 10))
                return true;
            if(CheckPatchPrefix_SC2_ArchiveName(haPatch, szPathPtr, szSeparator, szPathEnd, _T("Campaigns"), 9))
                return true;
            if(CheckPatchPrefix_SC2_ArchiveName(haPatch, szPathPtr, szSeparator, szPathEnd, _T("Mods"), 4))
                return true;
        }
    }

    // Not matched, sorry
    return false;
}

//
// This method tries to read the patch prefix from a helper file
//
// Example
// =========================================================
// MPQ File Name: MPQ_2013_v4_Base1.SC2Data
// Helper File  : MPQ_2013_v4_Base1.SC2Data-PATCH
// File Contains: PatchPrefix=Mods\Core.SC2Mod\Base.SC2Data
// Patch Prefix : Mods\Core.SC2Mod\Base.SC2Data
//

static bool ExtractPatchPrefixFromFile(const TCHAR * szHelperFile, char * szPatchPrefix, size_t nMaxChars, size_t * PtrLength)
{
    TFileStream * pStream;
    ULONGLONG FileSize = 0;
    size_t nLength;
    char szFileData[MAX_PATH+1];
    bool bResult = false;

    pStream = FileStream_OpenFile(szHelperFile, STREAM_FLAG_READ_ONLY);
    if(pStream != NULL)
    {
        // Retrieve and check the file size
        FileStream_GetSize(pStream, &FileSize);
        if(12 <= FileSize && FileSize < MAX_PATH)
        {
            // Read the entire file to memory
            if(FileStream_Read(pStream, NULL, szFileData, (DWORD)FileSize))
            {
                // Terminate the buffer with zero
                szFileData[(DWORD)FileSize] = 0;

                // The file data must begin with the "PatchPrefix" variable
                if(!_strnicmp(szFileData, "PatchPrefix", 11))
                {
                    char * szLinePtr = szFileData + 11;
                    char * szLineEnd;

                    // Skip spaces or '='
                    while(szLinePtr[0] == ' ' || szLinePtr[0] == '=')
                        szLinePtr++;
                    szLineEnd = szLinePtr;

                    // Find the end
                    while(szLineEnd[0] != 0 && szLineEnd[0] != 0x0A && szLineEnd[0] != 0x0D)
                        szLineEnd++;
                    nLength = (size_t)(szLineEnd - szLinePtr);

                    // Copy the variable
                    if(szLineEnd > szLinePtr && nLength <= nMaxChars)
                    {
                        memcpy(szPatchPrefix, szLinePtr, nLength);
                        szPatchPrefix[nLength] = 0;
                        PtrLength[0] = nLength;
                        bResult = true;
                    }
                }
            }
        }

        // Close the stream
        FileStream_Close(pStream);
    }

    return bResult;
}


static bool FindPatchPrefix_SC2_HelperFile(TMPQArchive * haBase, TMPQArchive * haPatch)
{
    TCHAR szHelperFile[MAX_PATH+1];
    char szPatchPrefix[MAX_SC2_PATCH_PREFIX+0x41];
    size_t nLength = 0;
    bool bResult = false;

    // Create the name of the patch helper file
    _tcscpy(szHelperFile, FileStream_GetFileName(haBase->pStream));
    if(_tcslen(szHelperFile) + 6 > MAX_PATH)
        return false;
    _tcscat(szHelperFile, _T("-PATCH"));

    // Open the patch helper file and read the line
    if(ExtractPatchPrefixFromFile(szHelperFile, szPatchPrefix, MAX_SC2_PATCH_PREFIX, &nLength))
        bResult = CheckAndCreatePatchPrefix(haPatch, szPatchPrefix, nLength);

    return bResult;
}

//
// Find match in Starcraft II patch MPQs
// Match a LST file in the root directory if the MPQ with any of the file in subdirectories
//
// The problem:
// File in the base MPQ:  enGB-md5.lst
// File in the patch MPQ: Campaigns\Liberty.SC2Campaign\enGB.SC2Assets\enGB-md5.lst
//                        Campaigns\Liberty.SC2Campaign\enGB.SC2Data\enGB-md5.lst
//                        Campaigns\LibertyStory.SC2Campaign\enGB.SC2Data\enGB-md5.lst
//                        Campaigns\LibertyStory.SC2Campaign\enGB.SC2Data\enGB-md5.lst Mods\Core.SC2Mod\enGB.SC2Assets\enGB-md5.lst
//                        Mods\Core.SC2Mod\enGB.SC2Data\enGB-md5.lst
//                        Mods\Liberty.SC2Mod\enGB.SC2Assets\enGB-md5.lst
//                        Mods\Liberty.SC2Mod\enGB.SC2Data\enGB-md5.lst
//                        Mods\LibertyMulti.SC2Mod\enGB.SC2Data\enGB-md5.lst
//
// Solution:
// We need to match the file by its MD5
//

static bool FindPatchPrefix_SC2_MatchFiles(TMPQArchive * haBase, TMPQArchive * haPatch, TFileEntry * pBaseEntry)
{
    TMPQNamePrefix * pPatchPrefix;
    char * szPatchFileName;
    char * szPlainName;
    size_t cchWorkBuffer = 0x400;
    bool bResult = false;

    // First-level patches: Find the same file within the patch archive
    // and verify by MD5-before-patch
    if(haBase->haPatch == NULL)
    {
        TFileEntry * pFileTableEnd = haPatch->pFileTable + haPatch->dwFileTableSize;
        TFileEntry * pFileEntry;

        // Allocate working buffer for merging LST file
        szPatchFileName = STORM_ALLOC(char, cchWorkBuffer);
        if(szPatchFileName != NULL)
        {
            // Parse the entire file table
            for(pFileEntry = haPatch->pFileTable; pFileEntry < pFileTableEnd; pFileEntry++)
            {
                // Look for "patch_metadata" file
                if(IsPatchMetadataFile(pFileEntry))
                {
                    // Construct the name of the MD5 file
                    strcpy(szPatchFileName, pFileEntry->szFileName);
                    szPlainName = (char *)GetPlainFileName(szPatchFileName);
                    strcpy(szPlainName, pBaseEntry->szFileName);

                    // Check for matching MD5 file
                    if(IsMatchingPatchFile(haPatch, szPatchFileName, pBaseEntry->md5))
                    {
                        bResult = CreatePatchPrefix(haPatch, szPatchFileName, (size_t)(szPlainName - szPatchFileName));
                        break;
                    }
                }
            }

            // Delete the merge buffer
            STORM_FREE(szPatchFileName);
        }
    }

    // For second-level patches, just take the patch prefix from the lower level patch
    else
    {
        // There must be at least two patches in the chain
        assert(haBase->haPatch->pPatchPrefix != NULL);
        pPatchPrefix = haBase->haPatch->pPatchPrefix;

        // Copy the patch prefix
        bResult = CreatePatchPrefix(haPatch,
                                    pPatchPrefix->szPatchPrefix,
                                    pPatchPrefix->nLength);
    }

    return bResult;
}

// Note: pBaseEntry is the file entry of the base version of "StreamingBuckets.txt"
static bool FindPatchPrefix_SC2(TMPQArchive * haBase, TMPQArchive * haPatch, TFileEntry * pBaseEntry)
{
    // Method 1: Try it by the placement of the archive.
    // Works when someone is opening an archive in the game (sub)directory
    if(FindPatchPrefix_SC2_ArchiveName(haBase, haPatch))
        return true;

    // Method 2: Try to locate the Name.Ext-PATCH file and read the patch prefix from it
    if(FindPatchPrefix_SC2_HelperFile(haBase, haPatch))
        return true;

    // Method 3: Try to pair any version of "StreamingBuckets.txt" from the patch MPQ
    // with the "StreamingBuckets.txt" in the base MPQ. Does not always work
    if(FindPatchPrefix_SC2_MatchFiles(haBase, haPatch, pBaseEntry))
        return true;

    return false;
}

//
// Patch prefix is the path subdirectory where the patched files are within MPQ.
//
// Example 1:
// Main MPQ:  locale-enGB.MPQ
// Patch MPQ: wow-update-12694.MPQ
// File in main MPQ: DBFilesClient\Achievement.dbc
// File in patch MPQ: enGB\DBFilesClient\Achievement.dbc
// Path prefix: enGB
//
// Example 2:
// Main MPQ:  expansion1.MPQ
// Patch MPQ: wow-update-12694.MPQ
// File in main MPQ: DBFilesClient\Achievement.dbc
// File in patch MPQ: Base\DBFilesClient\Achievement.dbc
// Path prefix: Base
//
// Example 3:
// Main MPQ:  %GAME%\Battle.net\Battle.net.MPQ
// Patch MPQ: s2-update-base-26147.MPQ
// File in main MPQ: Battle.net\i18n\deDE\String\CLIENT_ACHIEVEMENTS.xml
// File in patch MPQ: Battle.net\Battle.net.MPQ\Battle.net\i18n\deDE\String\CLIENT_ACHIEVEMENTS.xml
// Path prefix: Battle.net\Battle.net.MPQ
//
// Example 4:
// Main MPQ:  %GAME%\Campaigns\Liberty.SC2Campaign\enGB.SC2Data
//   *OR*     %ANY_DIR%\%ANY_NAME%Campaigns#Liberty.SC2Campaign#enGB.SC2Data
// Patch MPQ: s2-update-enGB-23258.MPQ
// File in main MPQ: LocalizedData\GameHotkeys.txt
// File in patch MPQ: Campaigns\Liberty.SC2Campaign\enGB.SC2Data\LocalizedData\GameHotkeys.txt
// Patch Prefix: Campaigns\Liberty.SC2Campaign\enGB.SC2Data
//

static bool FindPatchPrefix(TMPQArchive * haBase, TMPQArchive * haPatch, const char * szPatchPathPrefix)
{
    TFileEntry * pFileEntry;

    // If the patch prefix was explicitly entered, we use that one
    if(szPatchPathPrefix != NULL)
        return CreatePatchPrefix(haPatch, szPatchPathPrefix, 0);

    // Patches for World of Warcraft - they mostly do not use prefix.
    // All patches that use patch prefix have the "base\\(patch_metadata) file present
    if(GetFileEntryLocale(haPatch, "base\\" PATCH_METADATA_NAME, 0))
        return FindPatchPrefix_WoW_13164_13623(haBase, haPatch);

    // Updates for Starcraft II
    // Match: LocalizedData\GameHotkeys.txt <==> Campaigns\Liberty.SC2Campaign\enGB.SC2Data\LocalizedData\GameHotkeys.txt
    // All Starcraft II base archives seem to have the file "StreamingBuckets.txt" present
    pFileEntry = GetFileEntryLocale(haBase, "StreamingBuckets.txt", 0);
    if(pFileEntry != NULL)
        return FindPatchPrefix_SC2(haBase, haPatch, pFileEntry);

    // Diablo III patch MPQs don't use patch prefix
    // Hearthstone MPQs don't use patch prefix
    CreatePatchPrefix(haPatch, NULL, 0);
    return true;
}

//-----------------------------------------------------------------------------
// Public functions (StormLib internals)

bool IsIncrementalPatchFile(const void * pvData, DWORD cbData, LPDWORD pdwPatchedFileSize)
{
    PMPQ_PATCH_HEADER pPatchHeader = (PMPQ_PATCH_HEADER)pvData;
    BLIZZARD_BSDIFF40_FILE DiffFile;
    DWORD dwPatchType;

    if(cbData >= sizeof(MPQ_PATCH_HEADER) + sizeof(BLIZZARD_BSDIFF40_FILE))
    {
        dwPatchType = BSWAP_INT32_UNSIGNED(pPatchHeader->dwPatchType);
        if(dwPatchType == 0x30445342)
        {
            // Give the caller the patch file size
            if(pdwPatchedFileSize != NULL)
            {
                Decompress_RLE((LPBYTE)&DiffFile, sizeof(BLIZZARD_BSDIFF40_FILE), (LPBYTE)(pPatchHeader + 1), sizeof(BLIZZARD_BSDIFF40_FILE));
                DiffFile.NewFileSize = BSWAP_INT64_UNSIGNED(DiffFile.NewFileSize);
                *pdwPatchedFileSize = (DWORD)DiffFile.NewFileSize;
                return true;
            }
        }
    }

    return false;
}

DWORD Patch_InitPatcher(TMPQPatcher * pPatcher, TMPQFile * hf)
{
    DWORD cbMaxFileData = 0;

    // Overflow check
    if((cbMaxFileData + (DWORD)sizeof(MPQ_PATCH_HEADER)) < cbMaxFileData)
        return ERROR_NOT_ENOUGH_MEMORY;
    if(hf->hfPatch == NULL)
        return ERROR_INVALID_PARAMETER;

    // Initialize the entire structure with zeros
    memset(pPatcher, 0, sizeof(TMPQPatcher));

    // Copy the MD5 of the current file
    memcpy(pPatcher->this_md5, hf->pFileEntry->md5, MD5_DIGEST_SIZE);

    // Find out the biggest data size needed during the patching process
    while(hf != NULL)
    {
        if(hf->pFileEntry->dwFileSize > cbMaxFileData)
            cbMaxFileData = hf->pFileEntry->dwFileSize;
        hf = hf->hfPatch;
    }

    // Allocate primary and secondary buffer
    pPatcher->pbFileData1 = STORM_ALLOC(BYTE, cbMaxFileData);
    pPatcher->pbFileData2 = STORM_ALLOC(BYTE, cbMaxFileData);
    if(!pPatcher->pbFileData1 || !pPatcher->pbFileData2)
        return ERROR_NOT_ENOUGH_MEMORY;

    pPatcher->cbMaxFileData = cbMaxFileData;
    return ERROR_SUCCESS;
}

//
// Note: The patch may either be applied to the base file or to the previous version
// In Starcraft II, Mods\Core.SC2Mod\Base.SC2Data, file StreamingBuckets.txt:
//
// Base file MD5: 31376b0344b6df59ad009d4296125539
//
// s2-update-base-23258: from 31376b0344b6df59ad009d4296125539 to 941a82683452e54bf024a8d491501824
// s2-update-base-24540: from 31376b0344b6df59ad009d4296125539 to 941a82683452e54bf024a8d491501824
// s2-update-base-26147: from 31376b0344b6df59ad009d4296125539 to d5d5253c762fac6b9761240288a0771a
// s2-update-base-28522: from 31376b0344b6df59ad009d4296125539 to 5a76c4b356920aab7afd22e0e1913d7a
// s2-update-base-30508: from 31376b0344b6df59ad009d4296125539 to 8cb0d4799893fe801cc78ae4488a3671
// s2-update-base-32283: from 31376b0344b6df59ad009d4296125539 to 8cb0d4799893fe801cc78ae4488a3671
//
// We don't keep all intermediate versions in memory, as it would cause massive
// memory usage during patching process. A prime example is the file
// DBFilesClient\\Item-Sparse.db2 from locale-enGB.MPQ (WoW 16965), which has
// 9 patches in a row, each requiring 70 MB memory (35 MB patch data + 35 MB work buffer)
//

DWORD Patch_Process(TMPQPatcher * pPatcher, TMPQFile * hf)
{
    PMPQ_PATCH_HEADER pFullPatch;
    MPQ_PATCH_HEADER PatchHeader1;
    MPQ_PATCH_HEADER PatchHeader2 = {0};
    TMPQFile * hfBase = hf;
    DWORD cbBytesRead = 0;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Move to the first patch
    assert(hfBase->pbFileData == NULL);
    assert(hfBase->cbFileData == 0);
    hf = hf->hfPatch;

    // Read the header of the current patch
    SFileReadFile((HANDLE)hf, &PatchHeader1, sizeof(MPQ_PATCH_HEADER), &cbBytesRead, NULL);
    if(cbBytesRead != sizeof(MPQ_PATCH_HEADER))
        return ERROR_FILE_CORRUPT;

    // Perform the patching process
    while(dwErrCode == ERROR_SUCCESS && hf != NULL)
    {
        // Try to read the next patch header. If the md5_before_patch
        // still matches we go directly to the next one and repeat
        while(hf->hfPatch != NULL)
        {
            // Attempt to read the patch header
            SFileReadFile((HANDLE)hf->hfPatch, &PatchHeader2, sizeof(MPQ_PATCH_HEADER), &cbBytesRead, NULL);
            if(cbBytesRead != sizeof(MPQ_PATCH_HEADER))
                return ERROR_FILE_CORRUPT;

            // Compare the md5_before_patch
            if(memcmp(PatchHeader2.md5_before_patch, pPatcher->this_md5, MD5_DIGEST_SIZE))
                break;

            // Move one patch fuhrter
            PatchHeader1 = PatchHeader2;
            hf = hf->hfPatch;
        }

        // Allocate memory for the patch data
        pFullPatch = LoadFullFilePatch(hf, PatchHeader1);
        if(pFullPatch != NULL)
        {
            // Apply the patch
            dwErrCode = ApplyFilePatch(pPatcher, pFullPatch);
            STORM_FREE(pFullPatch);
        }
        else
        {
            dwErrCode = ERROR_FILE_CORRUPT;
        }

        // Move to the next patch
        PatchHeader1 = PatchHeader2;
        pPatcher->nCounter++;
        hf = hf->hfPatch;
    }

    // Put the result data to the file structure
    if(dwErrCode == ERROR_SUCCESS)
    {
        // Swap the pointer to the file data structure
        if(pPatcher->nCounter & 0x01)
        {
            hfBase->pbFileData = pPatcher->pbFileData2;
            pPatcher->pbFileData2 = NULL;
        }
        else
        {
            hfBase->pbFileData = pPatcher->pbFileData1;
            pPatcher->pbFileData1 = NULL;
        }

        // Also supply the data size
        hfBase->cbFileData = pPatcher->cbFileData;
    }

    return ERROR_SUCCESS;
}

void Patch_Finalize(TMPQPatcher * pPatcher)
{
    if(pPatcher != NULL)
    {
        if(pPatcher->pbFileData1 != NULL)
            STORM_FREE(pPatcher->pbFileData1);
        if(pPatcher->pbFileData2 != NULL)
            STORM_FREE(pPatcher->pbFileData2);

        memset(pPatcher, 0, sizeof(TMPQPatcher));
    }
}

//-----------------------------------------------------------------------------
// Public functions

bool WINAPI SFileOpenPatchArchive(
    HANDLE hMpq,
    const TCHAR * szPatchMpqName,
    const char * szPatchPathPrefix,
    DWORD dwFlags)
{
    TMPQArchive * haPatch;
    TMPQArchive * ha = (TMPQArchive *)hMpq;
    HANDLE hPatchMpq = NULL;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Verify input parameters
    if(!IsValidMpqHandle(hMpq))
        dwErrCode = ERROR_INVALID_HANDLE;
    if(szPatchMpqName == NULL || *szPatchMpqName == 0)
        dwErrCode = ERROR_INVALID_PARAMETER;

    //
    // We don't allow adding patches to archives that have been open for write
    //
    // Error scenario:
    //
    // 1) Open archive for writing
    // 2) Modify or replace a file
    // 3) Add patch archive to the opened MPQ
    // 4) Read patched file
    // 5) Now what?
    //

    if(dwErrCode == ERROR_SUCCESS)
    {
        if(!(ha->dwFlags & MPQ_FLAG_READ_ONLY))
            dwErrCode = ERROR_ACCESS_DENIED;
    }

    // Open the archive like it is normal archive
    if(dwErrCode == ERROR_SUCCESS)
    {
        // These flags will be propagated to SFileOpenArchive
        dwFlags = (dwFlags & MPQ_OPEN_NO_LISTFILE) | MPQ_OPEN_READ_ONLY | MPQ_OPEN_PATCH;

        // Open the patch as MPQ
        if(SFileOpenArchive(szPatchMpqName, 0, dwFlags, &hPatchMpq))
        {
            // Cast the archive handle to structure pointer
            haPatch = (TMPQArchive *)hPatchMpq;

            // We need to remember the proper patch prefix to match names of patched files
            if(FindPatchPrefix(ha, (TMPQArchive *)hPatchMpq, szPatchPathPrefix))
            {
                // Now add the patch archive to the list of patches to the original MPQ
                while(ha != NULL)
                {
                    if(ha->haPatch == NULL)
                    {
                        haPatch->haBase = ha;
                        ha->haPatch = haPatch;
                        return true;
                    }

                    // Move to the next archive
                    ha = ha->haPatch;
                }
            }

            // Close the archive
            SFileCloseArchive(hPatchMpq);
            dwErrCode = ERROR_CANT_FIND_PATCH_PREFIX;
        }
        else
        {
            dwErrCode = SErrGetLastError();
        }
    }

    SErrSetLastError(dwErrCode);
    return false;
}

bool WINAPI SFileIsPatchedArchive(HANDLE hMpq)
{
    TMPQArchive * ha = (TMPQArchive *)hMpq;

    // Verify input parameters
    if(!IsValidMpqHandle(hMpq))
        return false;

    return (ha->haPatch != NULL);
}
