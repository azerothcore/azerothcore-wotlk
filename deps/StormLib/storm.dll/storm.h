/*****************************************************************************/
/* Storm.h                           Copyright Justin Olbrantz(Quantam) 2000 */
/*---------------------------------------------------------------------------*/
/* Storm Interface Library v1.0 for Windows                                  */
/*                                                                           */
/* Author : Justin Olbrantz(Quantam)                                         */
/* E-mail : omega@dragonfire.net                                             */
/* WWW    : www.campaigncreations.com/starcraft/mpq2k/inside_mopaq/          */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* xx.xx.00  1.00  Qua  The first version of Storm.h                         */
/* 11.04.03  1.00  Lad  Added some functions                                 */
/*****************************************************************************/

#ifndef __STORM_H__
#define __STORM_H__

// We need the Windows data types for the Storm prototypes
#include <windows.h>

// Sometimes is necessary to change the function names so they
// will not conflict with other MPQ tools.
#ifdef STORM_ALTERNATE_NAMES
  #define SERR(Name)  Storm##Name
  #define SFILE(Name) Storm##Name
  #define SMEM(Name)  Storm##Name
  #define SCOMP(Name) Storm##Name
#else
  #define SERR(Name)  SErr##Name
  #define SFILE(Name) SFile##Name
  #define SMEM(Name)  SMem##Name
  #define SCOMP(Name) SComp##Name
#endif

// Make sure the functions are exported as C functions
#ifdef __cplusplus
extern "C" {
#endif

// Storm file function prototypes
BOOL  WINAPI SFILE(OpenArchive)(LPCSTR lpFileName, DWORD dwPriority, DWORD dwFlags, HANDLE *hMPQ);
BOOL  WINAPI SFILE(CloseArchive)(HANDLE hMPQ);
BOOL  WINAPI SFILE(GetArchiveName)(HANDLE hMPQ, LPCSTR lpBuffer, DWORD dwBufferLength);
BOOL  WINAPI SFILE(OpenFile)(LPCSTR lpFileName, HANDLE *hFile);
BOOL  WINAPI SFILE(OpenFileEx)(HANDLE hMPQ, LPCSTR lpFileName, DWORD dwSearchScope, HANDLE *hFile);
BOOL  WINAPI SFILE(CloseFile)(HANDLE hFile);
BOOL  WINAPI SFILE(GetFileArchive)(HANDLE hFile, HANDLE *hMPQ);
DWORD WINAPI SFILE(GetFileSize)(HANDLE hFile, LPDWORD lpFileSizeHigh);
BOOL  WINAPI SFILE(GetFileName)(HANDLE hFile, LPCSTR lpBuffer, DWORD dwBufferLength);
DWORD WINAPI SFILE(SetFilePointer)(HANDLE hFile, long lDistanceToMove, PLONG lplDistanceToMoveHigh, DWORD dwMoveMethod);
BOOL  WINAPI SFILE(ReadFile)(HANDLE hFile, LPVOID lpBuffer, DWORD nNumberOfBytesToRead, LPDWORD lpNumberOfBytesRead, LPOVERLAPPED lpOverlapped);
LCID  WINAPI SFILE(SetLocale)(LCID nNewLocale);
BOOL  WINAPI SFILE(GetBasePath)(LPCSTR lpBuffer, DWORD dwBufferLength);
BOOL  WINAPI SFILE(SetBasePath)(LPCSTR lpNewBasePath);

// File name safe functions
BOOL  WINAPI SMEM(UTF8ToFileName)(LPTSTR szBuffer, size_t ccBuffer, const void * lpString, const void * lpStringEnd, DWORD dwFlags, size_t * pOutLength);
BOOL  WINAPI SMEM(FileNameToUTF8)(void * lpBuffer, size_t ccBuffer, const TCHAR * szString, const TCHAR * szStringEnd, DWORD dwFlags, size_t * pOutLength);

// SetLastError
DWORD WINAPI SERR(SetLastError)(DWORD dwErrCode);

// Storm (de)compression functions
BOOL  WINAPI SCOMP(Compress)  (char * pbOutBuffer, int * pdwOutLength, char * pbInBuffer, int dwInLength, int uCmp, int uCmpType, int nCmpLevel);
BOOL  WINAPI SCOMP(Decompress)(char * pbOutBuffer, int * pdwOutLength, char * pbInBuffer, int dwInLength);

#ifdef __cplusplus
}
#endif

#if defined(_MSC_VER) && !defined(BUILDING_STORM_CPP)
#pragma comment(lib, "Storm.lib")    // Force linking Storm.lib and thus Storm.dll
#endif

#endif // __STORM_H__
