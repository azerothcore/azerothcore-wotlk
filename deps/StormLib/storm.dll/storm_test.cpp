/*****************************************************************************/
/* Storm_test.cpp                         Copyright (c) Ladislav Zezula 2014 */
/*---------------------------------------------------------------------------*/
/* Test module for storm.dll (original Blizzard MPQ dynalic library          */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 24.08.14  1.00  Lad  The first version of Storm_test.cpp                  */
/*****************************************************************************/

#define _CRT_NON_CONFORMING_SWPRINTFS
#define _CRT_SECURE_NO_DEPRECATE
#include <tchar.h>
#include <stdio.h>
#include <windows.h>

#ifdef _MSC_VER
#include <crtdbg.h>
#endif

#define STORM_ALTERNATE_NAMES               // Use Storm* prefix for functions
#include "storm.h"                          // Header file for Storm.dll

#pragma comment(lib, "storm.lib")

//-----------------------------------------------------------------------------
// List of files

const char * IntToHexChar = "0123456789ABCDEF";

LPCSTR DefFilesToOpen[] = 
{
    "music\\tdefeat.wav",
    "setupdat\\inst.vis",
    "setupdat\\audio\\mouseover.wav",
    "files\\font\\font12.fnt",
    "music\\zvict.wav",
    "files\\readme.txt",
    "music\\zerg2.wav",
    "music\\zerg1.wav",
    "setupdat\\inst_regs.ins",
    "files\\font\\font50.fnt",
    "files\\msv2all.vxp",
    "setupdat\\scr_options.vis",
    "setupdat\\font\\font16x.fnt",
    "setupdat\\setup.vis",
    "maps\\128x128_wasteland4.scm",
    "setupdat\\scr_main.vis",
    "music\\pvict.wav",
    "music\\zdefeat.wav",
};

//-----------------------------------------------------------------------------
// Main

static void CalculateMD5(LPBYTE md5_digest, LPBYTE pbData, DWORD cbData)
{
    HCRYPTPROV hCryptProv = NULL;
    HCRYPTHASH hCryptHash = NULL;

    if(CryptAcquireContext(&hCryptProv, NULL, NULL, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT))
    {
        if(CryptCreateHash(hCryptProv, CALG_MD5, NULL, 0, &hCryptHash))
        {
            DWORD dwHashLen = 0x10;

            CryptHashData(hCryptHash, pbData, cbData, 0);
            CryptGetHashParam(hCryptHash, HP_HASHVAL, md5_digest, &dwHashLen, 0);
            CryptDestroyHash(hCryptHash);
        }

        CryptReleaseContext(hCryptProv, 0);
    }
}

template <typename XCHAR>
DWORD BinaryToString(XCHAR * szBuffer, size_t cchBuffer, LPCVOID pvBinary, size_t cbBinary)
{
    LPCBYTE pbBinary = (LPCBYTE)pvBinary;

    // The size of the string must be enough to hold the binary + EOS
    if(cchBuffer < ((cbBinary * 2) + 1))
        return ERROR_INSUFFICIENT_BUFFER;

    // Convert the string to the array of MD5
    // Copy the blob data as text
    for(size_t i = 0; i < cbBinary; i++)
    {
        *szBuffer++ = IntToHexChar[pbBinary[0] >> 0x04];
        *szBuffer++ = IntToHexChar[pbBinary[0] & 0x0F];
        pbBinary++;
    }

    // Terminate the string
    *szBuffer = 0;
    return ERROR_SUCCESS;
}

int main(int argc, char * argv[])
{
    LPCSTR szArchiveName;
    LPCSTR szFormat;
    HANDLE hMpq = NULL;
    HANDLE hFile = NULL;
    LPBYTE pbBuffer = NULL;
    DWORD dwBytesRead = 0;
    DWORD dwFileSize = 0;
    BOOL bResult;
    BYTE md5_digest[0x10];
    char md5_string[0x40];

    // Check parameters
    if(argc == 1)
    {
        printf("Error: Missing MPQ name\nUsage: storm_test.exe MpqName [FileName [FileName]]\n");
        return 3;
    }

    // Get both arguments
    SetLastError(ERROR_SUCCESS);
    szArchiveName = argv[1];

    // Break for kernel debugger
    //__debugbreak();

    // Put Storm.dll to the current folder before running this
    //printf("[*] Opening archive '%s' ...\n", szArchiveName);
    __debugbreak();
    if(StormOpenArchive(szArchiveName, 0, 0, &hMpq))
    {
        LPCSTR * FilesToOpen = DefFilesToOpen;
        size_t nFilesToOpen = _countof(DefFilesToOpen);

        // Set the list of files
        if(argc > 2)
        {
            FilesToOpen = (LPCSTR *)(&argv[2]);
            nFilesToOpen = argc - 2;
        }

        // Attempt to open all files
        for(size_t i = 0; i < nFilesToOpen; i++)
        {
            //printf("[*] Opening file '%s' ...\n", FilesToOpen[i]);
            if(StormOpenFileEx(hMpq, FilesToOpen[i], 0, &hFile))
            {
                //printf("[*] Retrieving file size ... ");
                dwFileSize = StormGetFileSize(hFile, NULL);
                szFormat = (dwFileSize == INVALID_FILE_SIZE) ? ("(invalid)\n") : ("(%u bytes)\n");
                //printf(szFormat, dwFileSize);

                // Allocate the buffer for the entire file
                //printf("[*] Allocating buffer ...\n");
                if((pbBuffer = new BYTE[dwFileSize]) != NULL)
                {
                    //printf("[*] Moving to begin of the file ...\n");
                    StormSetFilePointer(hFile, 0, NULL, FILE_BEGIN);

                    //printf("[*] Reading file ... ");
                    bResult = StormReadFile(hFile, pbBuffer, dwFileSize, &dwBytesRead, NULL);
                    szFormat = (bResult != FALSE && dwBytesRead == dwFileSize) ? ("(OK)\n") : ("(error %u)\n");
                    //printf(szFormat, GetLastError());

                    //printf("[*] Calculating MD5 ... ");
                    CalculateMD5(md5_digest, pbBuffer, dwFileSize);
                    BinaryToString(md5_string, _countof(md5_string), md5_digest, sizeof(md5_digest));
                    printf("%s *%s\n", md5_string, FilesToOpen[i]);

                    delete[] pbBuffer;
                }

                //printf("[*] Closing file ...\n");
                StormCloseFile(hFile);
            }
        }

        //printf("[*] Closing archive ...\n");
        StormCloseArchive(hMpq);
    }

    //printf("Done.\n\n");
    return 0;
}
