/*****************************************************************************/
/* SBaseDumpData.cpp                      Copyright (c) Ladislav Zezula 2011 */
/*---------------------------------------------------------------------------*/
/* Description :                                                             */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 26.01.11  1.00  Lad  The first version of SBaseDumpData.cpp               */
/*****************************************************************************/

#define __STORMLIB_SELF__
#include "StormLib.h"
#include "StormCommon.h"

#ifdef __STORMLIB_DUMP_DATA__

void DumpMpqHeader(TMPQHeader * pHeader)
{
    printf("== MPQ Header =================================\n");
    printf("DWORD dwID                   = %08X\n",    pHeader->dwID);
    printf("DWORD dwHeaderSize           = %08X\n",    pHeader->dwHeaderSize);
    printf("DWORD dwArchiveSize          = %08X\n",    pHeader->dwArchiveSize);
    printf("USHORT wFormatVersion        = %04X\n",    pHeader->wFormatVersion);
    printf("USHORT wSectorSize           = %04X\n",    pHeader->wSectorSize);
    printf("DWORD dwHashTablePos         = %08X\n",    pHeader->dwHashTablePos);
    printf("DWORD dwBlockTablePos        = %08X\n",    pHeader->dwBlockTablePos);
    printf("DWORD dwHashTableSize        = %08X\n",    pHeader->dwHashTableSize);
    printf("DWORD dwBlockTableSize       = %08X\n",    pHeader->dwBlockTableSize);
    printf("ULONGLONG HiBlockTablePos64  = %016llX\n", pHeader->HiBlockTablePos64);
    printf("USHORT wHashTablePosHi       = %04X\n",    pHeader->wHashTablePosHi);
    printf("USHORT wBlockTablePosHi      = %04X\n",    pHeader->wBlockTablePosHi);
    printf("ULONGLONG ArchiveSize64      = %016llX\n", pHeader->ArchiveSize64);
    printf("ULONGLONG BetTablePos64      = %016llX\n", pHeader->BetTablePos64);
    printf("ULONGLONG HetTablePos64      = %016llX\n", pHeader->HetTablePos64);
    printf("ULONGLONG HashTableSize64    = %016llX\n", pHeader->HashTableSize64);
    printf("ULONGLONG BlockTableSize64   = %016llX\n", pHeader->BlockTableSize64);
    printf("ULONGLONG HiBlockTableSize64 = %016llX\n", pHeader->HiBlockTableSize64);
    printf("ULONGLONG HetTableSize64     = %016llX\n", pHeader->HetTableSize64);
    printf("ULONGLONG BetTableSize64     = %016llX\n", pHeader->BetTableSize64);
    printf("DWORD dwRawChunkSize         = %08X\n",     pHeader->dwRawChunkSize);
    printf("-----------------------------------------------\n\n");
}

void DumpHashTable(TMPQHash * pHashTable, DWORD dwHashTableSize)
{
    DWORD i;

    if(pHashTable == NULL || dwHashTableSize == 0)
        return;

    printf("== Hash Table =================================\n");
    for(i = 0; i < dwHashTableSize; i++)
    {
        printf("[%08x] %08X %08X %04X %02X %08X\n", i,
                                                    pHashTable[i].dwHashCheck1,
                                                    pHashTable[i].dwHashCheck2,
                                                    pHashTable[i].Locale,
                                                    pHashTable[i].Platform,
                                                    pHashTable[i].dwBlockIndex);
    }
    printf("-----------------------------------------------\n\n");
}

void DumpHetAndBetTable(TMPQHetTable * pHetTable, TMPQBetTable * pBetTable)
{
    DWORD i;

    if(pHetTable == NULL || pBetTable == NULL)
        return;

    printf("== HET Header =================================\n");
    printf("ULONGLONG  AndMask64         = %016llX\n",  pHetTable->AndMask64);
    printf("ULONGLONG  OrMask64          = %016llX\n",  pHetTable->OrMask64);
    printf("DWORD      dwEntryCount      = %08X\n",     pHetTable->dwEntryCount);
    printf("DWORD      dwTotalCount      = %08X\n",     pHetTable->dwTotalCount);
    printf("DWORD      dwNameHashBitSize = %08X\n",     pHetTable->dwNameHashBitSize);
    printf("DWORD      dwIndexSizeTotal  = %08X\n",     pHetTable->dwIndexSizeTotal);
    printf("DWORD      dwIndexSizeExtra  = %08X\n",     pHetTable->dwIndexSizeExtra);
    printf("DWORD      dwIndexSize       = %08X\n",     pHetTable->dwIndexSize);
    printf("-----------------------------------------------\n\n");

    printf("== BET Header =================================\n");
    printf("DWORD dwTableEntrySize       = %08X\n",     pBetTable->dwTableEntrySize);
    printf("DWORD dwBitIndex_FilePos     = %08X\n",     pBetTable->dwBitIndex_FilePos);
    printf("DWORD dwBitIndex_FileSize    = %08X\n",     pBetTable->dwBitIndex_FileSize);
    printf("DWORD dwBitIndex_CmpSize     = %08X\n",     pBetTable->dwBitIndex_CmpSize);
    printf("DWORD dwBitIndex_FlagIndex   = %08X\n",     pBetTable->dwBitIndex_FlagIndex);
    printf("DWORD dwBitIndex_Unknown     = %08X\n",     pBetTable->dwBitIndex_Unknown);
    printf("DWORD dwBitCount_FilePos     = %08X\n",     pBetTable->dwBitCount_FilePos);
    printf("DWORD dwBitCount_FileSize    = %08X\n",     pBetTable->dwBitCount_FileSize);
    printf("DWORD dwBitCount_CmpSize     = %08X\n",     pBetTable->dwBitCount_CmpSize);
    printf("DWORD dwBitCount_FlagIndex   = %08X\n",     pBetTable->dwBitCount_FlagIndex);
    printf("DWORD dwBitCount_Unknown     = %08X\n",     pBetTable->dwBitCount_Unknown);
    printf("DWORD dwBitTotal_NameHash2   = %08X\n",     pBetTable->dwBitTotal_NameHash2);
    printf("DWORD dwBitExtra_NameHash2   = %08X\n",     pBetTable->dwBitExtra_NameHash2);
    printf("DWORD dwBitCount_NameHash2   = %08X\n",     pBetTable->dwBitCount_NameHash2);
    printf("DWORD dwEntryCount           = %08X\n",     pBetTable->dwEntryCount);
    printf("DWORD dwFlagCount            = %08X\n",     pBetTable->dwFlagCount);
    printf("-----------------------------------------------\n\n");

    printf("== HET & Bet Table ======================================================================\n\n");
    printf("HetIdx HetHash BetIdx BetHash          ByteOffset       FileSize CmpSize  FlgIdx Flags   \n");
    printf("------ ------- ------ ---------------- ---------------- -------- -------- ------ --------\n");
    for(i = 0; i < pHetTable->dwTotalCount; i++)
    {
        ULONGLONG ByteOffset = 0;
        ULONGLONG BetHash = 0;
        DWORD dwFileSize = 0;
        DWORD dwCmpSize = 0;
        DWORD dwFlagIndex = 0;
        DWORD dwFlags = 0;
        DWORD dwBetIndex = 0;

        GetMPQBits(pHetTable->pBetIndexes, i * pHetTable->dwIndexSizeTotal,
                                           pHetTable->dwIndexSize,
                                          &dwBetIndex, 4);

        if(dwBetIndex < pHetTable->dwTotalCount)
        {
            DWORD dwEntryIndex = pBetTable->dwTableEntrySize * dwBetIndex;

            GetMPQBits(pBetTable->pNameHashes, dwBetIndex * pBetTable->dwBitTotal_NameHash2,
                                               pBetTable->dwBitCount_NameHash2,
                                              &BetHash, 8);

            GetMPQBits(pBetTable->pFileTable, dwEntryIndex + pBetTable->dwBitIndex_FilePos,
                                              pBetTable->dwBitCount_FilePos,
                                             &ByteOffset, 8);

            GetMPQBits(pBetTable->pFileTable, dwEntryIndex + pBetTable->dwBitIndex_FileSize,
                                              pBetTable->dwBitCount_FileSize,
                                             &dwFileSize, 4);

            GetMPQBits(pBetTable->pFileTable, dwEntryIndex + pBetTable->dwBitIndex_CmpSize,
                                              pBetTable->dwBitCount_CmpSize,
                                             &dwCmpSize, 4);

            GetMPQBits(pBetTable->pFileTable, dwEntryIndex + pBetTable->dwBitIndex_FlagIndex,
                                              pBetTable->dwBitCount_FlagIndex,
                                             &dwFlagIndex, 4);

            dwFlags = pBetTable->pFileFlags[dwFlagIndex];
        }

        printf(" %04X    %02lX     %04X  %016llX %016llX %08X %08X  %04X  %08X\n", i,
                                                         pHetTable->pNameHashes[i],
                                                         dwBetIndex,
                                                         BetHash,
                                                         ByteOffset,
                                                         dwFileSize,
                                                         dwCmpSize,
                                                         dwFlagIndex,
                                                         dwFlags);
    }
    printf("-----------------------------------------------------------------------------------------\n");
}

void DumpFileTable(TFileEntry * pFileTable, DWORD dwFileTableSize)
{
    DWORD i;

    if(pFileTable == NULL || dwFileTableSize == 0)
        return;

    printf("== File Table =================================\n");
    for(i = 0; i < dwFileTableSize; i++, pFileTable++)
    {
        printf("[%04u] %08X-%08X %08X-%08X %08X-%08X 0x%08X 0x%08X 0x%08X %s\n", i,
                        (DWORD)(pFileTable->FileNameHash >> 0x20),
                        (DWORD)(pFileTable->FileNameHash & 0xFFFFFFFF),
                        (DWORD)(pFileTable->ByteOffset >> 0x20),
                        (DWORD)(pFileTable->ByteOffset & 0xFFFFFFFF),
                        (DWORD)(pFileTable->FileTime >> 0x20),
                        (DWORD)(pFileTable->FileTime & 0xFFFFFFFF),
                                pFileTable->dwFileSize,
                                pFileTable->dwCmpSize,
                                pFileTable->dwFlags,
                                pFileTable->szFileName != NULL ? pFileTable->szFileName : "");
    }
    printf("-----------------------------------------------\n\n");
}

#endif  // __STORMLIB_DUMP_DATA__
