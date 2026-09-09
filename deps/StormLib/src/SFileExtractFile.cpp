/*****************************************************************************/
/* SFileExtractFile.cpp                   Copyright (c) Ladislav Zezula 2003 */
/*---------------------------------------------------------------------------*/
/* Simple extracting utility                                                 */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 20.06.03  1.00  Lad  The first version of SFileExtractFile.cpp            */
/*****************************************************************************/

#define __STORMLIB_SELF__
#include "StormLib.h"
#include "StormCommon.h"

bool WINAPI SFileExtractFile(HANDLE hMpq, const char * szToExtract, const TCHAR * szExtracted, DWORD dwSearchScope)
{
    TFileStream * pLocalFile = NULL;
    HANDLE hMpqFile = NULL;
    DWORD dwErrCode = ERROR_SUCCESS;

    // Open the MPQ file
    if(dwErrCode == ERROR_SUCCESS)
    {
        if(!SFileOpenFileEx(hMpq, szToExtract, dwSearchScope, &hMpqFile))
            dwErrCode = SErrGetLastError();
    }

    // Create the local file
    if(dwErrCode == ERROR_SUCCESS)
    {
        pLocalFile = FileStream_CreateFile(szExtracted, 0);
        if(pLocalFile == NULL)
            dwErrCode = SErrGetLastError();
    }

    // Copy the file's content
    while(dwErrCode == ERROR_SUCCESS)
    {
        char  szBuffer[0x1000];
        DWORD dwTransferred = 0;

        // dwTransferred is only set to nonzero if something has been read.
        // dwErrCode can be ERROR_SUCCESS or ERROR_HANDLE_EOF
        if(!SFileReadFile(hMpqFile, szBuffer, sizeof(szBuffer), &dwTransferred, NULL))
            dwErrCode = SErrGetLastError();
        if(dwErrCode == ERROR_HANDLE_EOF)
            dwErrCode = ERROR_SUCCESS;
        if(dwTransferred == 0)
            break;

        // If something has been actually read, write it
        if(!FileStream_Write(pLocalFile, NULL, szBuffer, dwTransferred))
            dwErrCode = SErrGetLastError();
    }

    // Close the files
    if(hMpqFile != NULL)
        SFileCloseFile(hMpqFile);
    if(pLocalFile != NULL)
        FileStream_Close(pLocalFile);
    if(dwErrCode != ERROR_SUCCESS)
        SErrSetLastError(dwErrCode);
    return (dwErrCode == ERROR_SUCCESS);
}
