/*****************************************************************************/
/* TLogHelper.cpp                         Copyright (c) Ladislav Zezula 2013 */
/*---------------------------------------------------------------------------*/
/* Helper class for reporting StormLib tests                                 */
/* This file should be included directly from StormTest.cpp using #include   */
/*---------------------------------------------------------------------------*/
/*   Date    Ver   Who  Comment                                              */
/* --------  ----  ---  -------                                              */
/* 26.11.13  1.00  Lad  Created                                              */
/*****************************************************************************/

//-----------------------------------------------------------------------------
// String replacements for format strings

#if defined(STORMLIB_WINDOWS) || defined(CASCLIB_PLATFORM_WINDOWS)
#define TEST_PLATFORM_WINDOWS
#endif

#ifdef _MSC_VER
#define fmt_I64u_w L"%I64u"
#define fmt_I64u_t _T("%I64u")
#define fmt_I64u_a "%I64u"
#define fmt_I64X_t _T("%I64X")
#define fmt_I64X_a "%I64X"
#else
#define fmt_I64u_t _T("%llu")
#define fmt_I64u_a "%llu"
#define fmt_I64X_t _T("%llX")
#define fmt_I64X_a "%llX"
#endif

#define fmt_X_of_Y_a  "(" fmt_I64u_a " of " fmt_I64u_a ")"
#define fmt_X_of_Y_t  _T(fmt_X_of_Y_a)

#ifdef __CASCLIB_SELF__
#define TEST_MIN CASCLIB_MIN
#define TEST_PRINT_PREFIX   false
#else
#define TEST_MIN STORMLIB_MIN
#define TEST_PRINT_PREFIX   true
#endif

//-----------------------------------------------------------------------------
// Local functions

template <typename XCHAR>
XCHAR * StringEnd(XCHAR * sz)
{
    while(sz[0] != 0)
        sz++;
    return sz;
}

// ANSI version of the function - expects UTF-8 encoding
size_t ConsoleLength(const char * ptr, const char * end)
{
    size_t ccBytesEaten;
    size_t nLength = 0;
    DWORD dwErrCode;

    while(ptr < end)
    {
        DWORD dwCodePoint = 0;

        // Decode a single UTF-8 character
        dwErrCode = UTF8_DecodeCodePoint((BYTE *)(ptr), (BYTE *)(end), dwCodePoint, ccBytesEaten);
        if(dwErrCode != ERROR_SUCCESS && dwErrCode != ERROR_NO_UNICODE_TRANSLATION)
            break;

        // Chinese chars occupy 1 extra char slot on console
        if(0x5000 <= ptr[0] && ptr[0] <= 0xA000)
            nLength++;
        ptr += ccBytesEaten;
        nLength++;
    }
    return nLength;
}

#ifdef TEST_PLATFORM_WINDOWS
size_t ConsoleLength(const wchar_t * ptr, const wchar_t * end)
{
    size_t nLength = 0;

    while(ptr < end)
    {
        DWORD dwCodePoint = ptr[0];

        // Chinese chars occupy more space
        if(0x5000 <= dwCodePoint && dwCodePoint <= 0xA000)
            nLength++;
        ptr += 1;
        nLength++;
    }
    return nLength;
}
#endif

inline DWORD TestInterlockedIncrement(DWORD * PtrValue)
{
#ifdef TEST_PLATFORM_WINDOWS
    return (DWORD)InterlockedIncrement((LONG *)(PtrValue));
#elif defined(__GNUC__)
    return __sync_add_and_fetch(PtrValue, 1);
#else
    return ++(*PtrValue);
#endif
}

inline DWORD Test_GetLastError()
{
    return SErrGetLastError();
}

#ifdef TEST_PLATFORM_WINDOWS
wchar_t * CopyFormatCharacter(wchar_t * szBuffer, const wchar_t *& szFormat)
{
    static const wchar_t * szStringFormat = L"%s";
    static const wchar_t * szUint64Format = fmt_I64u_w;

    // String format
    if(szFormat[0] == '%')
    {
        if(szFormat[1] == 's')
        {
            wcscpy(szBuffer, szStringFormat);
            szFormat += 2;
            return szBuffer + wcslen(szStringFormat);
        }

        // Replace %I64u with the proper platform-dependent suffix
        if(szFormat[1] == 'I' && szFormat[2] == '6' && szFormat[3] == '4' && szFormat[4] == 'u')
        {
            wcscpy(szBuffer, szUint64Format);
            szFormat += 5;
            return szBuffer + wcslen(szUint64Format);
        }
    }

    // Copy the character as-is
    *szBuffer++ = *szFormat++;
    return szBuffer;
}
#endif  // TEST_PLATFORM_WINDOWS

char * CopyFormatCharacter(char * szBuffer, const char *& szFormat)
{
    static const char * szStringFormat = "\"%s\"";
    static const char * szUint64Format = fmt_I64u_a;

    // String format
    if(szFormat[0] == '%')
    {
        if(szFormat[1] == 's')
        {
            StringCopy(szBuffer, 32, szStringFormat);
            szFormat += 2;
            return szBuffer + strlen(szStringFormat);
        }

        // Replace %I64u with the proper platform-dependent suffix
        if(szFormat[1] == 'I' && szFormat[2] == '6' && szFormat[3] == '4' && szFormat[4] == 'u')
        {
            StringCopy(szBuffer, 32, szUint64Format);
            szFormat += 5;
            return szBuffer + strlen(szUint64Format);
        }
    }

    // Copy the character as-is
    *szBuffer++ = *szFormat++;
    return szBuffer;
}

size_t TestStrPrintfV(char * buffer, size_t nCount, const char * format, va_list argList)
{
    return vsnprintf(buffer, nCount, format, argList);
}

size_t TestStrPrintf(char * buffer, size_t nCount, const char * format, ...)
{
    va_list argList;
    size_t length;

    // Start the argument list
    va_start(argList, format);
    length = TestStrPrintfV(buffer, nCount, format, argList);
    va_end(argList);

    return length;
}

size_t TestStrPrintfV(wchar_t * buffer, size_t nCount, const wchar_t * format, va_list argList)
{
#ifdef TEST_PLATFORM_WINDOWS
    return _vsnwprintf(buffer, nCount, format, argList);
#else
    return vswprintf(buffer, nCount, format, argList);
#endif
}

size_t TestStrPrintf(wchar_t * buffer, size_t nCount, const wchar_t * format, ...)
{
    va_list argList;
    size_t length;

    // Start the argument list
    va_start(argList, format);
    length = TestStrPrintfV(buffer, nCount, format, argList);
    va_end(argList);

    return length;
}

//-----------------------------------------------------------------------------
// Definition of the TLogHelper class

class TLogHelper
{
    public:

    //
    //  Constructor and destructor
    //

    TLogHelper(const char * szNewMainTitle = NULL, const TCHAR * szNewSubTitle1 = NULL, const TCHAR * szNewSubTitle2 = NULL)
    {
        // Fill the variables
        memset(this, 0, sizeof(TLogHelper));
        UserString = "";
        TotalFiles = 1;
        UserCount = 1;
        UserTotal = 1;

#ifdef TEST_PLATFORM_WINDOWS
        InitializeCriticalSection(&Locker);
        TickCount = GetTickCount();

        SetConsoleOutputCP(CP_UTF8);    // Set the UTF-8 code page to handle national-specific names
        SetConsoleCP(CP_UTF8);
#endif

        // Remember the startup time
        SetStartTime();

        // Save all three titles
        szMainTitle = szNewMainTitle;
        szSubTitle1 = szNewSubTitle1;
        szSubTitle2 = szNewSubTitle2;

        // Print the initial information
        if(szNewMainTitle != NULL)
        {
#ifdef __CASCLIB_SELF__
            char szMainTitleT[0x100] = {0};
            size_t nLength;

            nLength = TestStrPrintf(szMainTitleT, _countof(szMainTitleT), "-- \"%s\" --", szNewMainTitle);
            while(nLength < 90)
                szMainTitleT[nLength++] = '-';
            if(nLength < sizeof(szMainTitleT))
                szMainTitleT[nLength++] = 0;

            printf_console("%s\n", szMainTitleT);
#endif

#ifdef __STORMLIB_SELF__
            TCHAR szMainTitleT[0x100] = {0};

            // Copy the UNICODE main title
            StringCopy(szMainTitleT, _countof(szMainTitleT), szMainTitle);

            if(szSubTitle1 != NULL && szSubTitle2 != NULL)
                nPrevPrinted = printf_console(_T("\rRunning %s (%s+%s) ..."), szMainTitleT, szSubTitle1, szSubTitle2);
            else if(szSubTitle1 != NULL)
                nPrevPrinted = printf_console(_T("\rRunning %s (%s) ..."), szMainTitleT, szSubTitle1);
            else
                nPrevPrinted = printf_console(_T("\rRunning %s ..."), szMainTitleT);
#endif
        }
    }

    ~TLogHelper()
    {
        // Print a verdict, if no verdict was printed yet
        if(bMessagePrinted == false)
        {
            PrintVerdict(ERROR_SUCCESS);
        }

#ifdef TEST_PLATFORM_WINDOWS
        DeleteCriticalSection(&Locker);
#endif

#ifdef __CASCLIB_SELF__
        printf_console("\n");
#endif
    }

    //
    // Measurement of elapsed time
    //

    bool TimeElapsed(DWORD Milliseconds)
    {
        bool bTimeElapsed = false;

#ifdef TEST_PLATFORM_WINDOWS
        if(GetTickCount() > (TickCount + Milliseconds))
        {
            TickCount = GetTickCount();
            if(TestInterlockedIncrement(&TimeTrigger) == 1)
            {
                bTimeElapsed = true;
            }
        }

#endif
        return bTimeElapsed;
    }

    //
    //  Printing functions
    //

    int printf_console(const char * format, ...)
    {
        va_list argList;
        va_start(argList, format);
        int nLength = 0;

#ifdef TEST_PLATFORM_WINDOWS
        char * szBuffer;
        int ccBuffer = 0x1000;

        if((szBuffer = new char[ccBuffer]) != NULL)
        {
            // Prepare the string
            TestStrPrintfV(szBuffer, ccBuffer, format, argList);
            nLength = (int)strlen(szBuffer);

            // Unlike wprintf, WriteConsole supports UTF-8 much better
            WriteConsoleA(GetStdHandle(STD_OUTPUT_HANDLE), szBuffer, nLength, NULL, NULL);
            delete[] szBuffer;
        }
#else
        nLength = vprintf(format, argList);
#endif

        return nLength;
    }

#ifdef TEST_PLATFORM_WINDOWS
    int printf_console(const wchar_t * format, ...)
    {
        va_list argList;
        va_start(argList, format);
        int nLength = 0;

        wchar_t * szBuffer;
        int ccBuffer = 0x1000;

        if((szBuffer = new wchar_t[ccBuffer]) != NULL)
        {
            // Prepare the string
            TestStrPrintfV(szBuffer, ccBuffer, format, argList);
            nLength = (int)wcslen(szBuffer);

            // Unlike wprintf, WriteConsole supports UTF-8 much better
            WriteConsoleW(GetStdHandle(STD_OUTPUT_HANDLE), szBuffer, nLength, NULL, NULL);
            delete[] szBuffer;
        }
        return nLength;
    }
#endif

    template <typename XCHAR>
    DWORD PrintWithClreol(const XCHAR * szFormat, va_list argList, bool bPrintLastError, bool bPrintEndOfLine)
    {
        XCHAR * szBufferPtr;
        XCHAR * szBufferEnd;
        size_t nLength = 0;
        DWORD dwErrCode = Test_GetLastError();
        XCHAR szPercentS[] = {'%', 's', 0};
        XCHAR szMessage[0x200] = {0};
        XCHAR szBuffer[0x200] = {0};
        bool bPrintPrefix = TEST_PRINT_PREFIX;

        // Always start the buffer with '\r'
        szBufferEnd = szBuffer + _countof(szBuffer);
        szBufferPtr = szBuffer + 1;
        szBuffer[0] = '\r';

        // Print the prefix, if needed
        if(szMainTitle != NULL && bPrintPrefix)
        {
            while(szMainTitle[nLength] != 0)
                *szBufferPtr++ = szMainTitle[nLength++];

            *szBufferPtr++ = ':';
            *szBufferPtr++ = ' ';
        }

        // Construct the message
        TestStrPrintfV(szMessage, _countof(szMessage), szFormat, argList);
        StringCopy(szBufferPtr, (szBufferEnd - szBufferPtr), szMessage);
        szBufferPtr = StringEnd(szBufferPtr);

        // Append the last error
        if(bPrintLastError)
        {
            XCHAR szErrMsg[] = {' ', '(', 'e', 'r', 'r', 'o', 'r', ' ', 'c', 'o', 'd', 'e', ':', ' ', '%', 'u', ')', 0, 0};
            nLength = TestStrPrintf(szBufferPtr, (szBufferEnd - szBufferPtr), szErrMsg, dwErrCode);
            szBufferPtr += nLength;
        }

        // Pad the string with zeros, if needed
        while(szBufferPtr < (szBuffer + nPrevPrinted))
            *szBufferPtr++ = ' ';

        // Remember how much did we print
        nPrevPrinted = ConsoleLength(szBuffer, szBufferPtr);

        // Always add one extra space *AFTER* calculating length
        if(szBufferPtr < szBufferEnd)
            *szBufferPtr++ = ' ';
        *szBufferPtr = 0;

        // Print the message to the console
        printf_console(szPercentS, szBuffer);
        nMessageCounter++;

        // If we shall print the newline, do it
        if(bPrintEndOfLine)
        {
            bMessagePrinted = true;
            nPrevPrinted = 0;
            printf("\n");
        }

        // Finally print the message
        return dwErrCode;
    }

    template <typename XCHAR>
    void PrintProgress(const XCHAR * szFormat, ...)
    {
        va_list argList;

        // Always reset the time trigger
        TimeTrigger = 0;

        // Only print progress when the cooldown is ready
        if(ProgressReady())
        {
            va_start(argList, szFormat);
            PrintWithClreol(szFormat, argList, false, false);
            va_end(argList);
        }
    }

    template <typename XCHAR>
    void PrintMessage(const XCHAR * szFormat, ...)
    {
        va_list argList;

        va_start(argList, szFormat);
        PrintWithClreol(szFormat, argList, false, true);
        va_end(argList);
    }

    void PrintTotalTime()
    {
        DWORD TotalTime = SetEndTime();

        if(TotalTime != 0)
            PrintMessage("TotalTime: %u.%u second(s)", (TotalTime / 1000), (TotalTime % 1000));
        PrintMessage("Work complete.");
    }

    template <typename XCHAR>
    int PrintErrorVa(const XCHAR * szFormat, ...)
    {
        va_list argList;
        int nResult;

        va_start(argList, szFormat);
        nResult = PrintWithClreol(szFormat, argList, true, true);
        va_end(argList);

        return nResult;
    }

    template <typename XCHAR>
    int PrintError(const XCHAR * szFormat, const XCHAR * szFileName = NULL)
    {
        return PrintErrorVa(szFormat, szFileName);
    }

    // Print final verdict
    DWORD PrintVerdict(DWORD dwErrCode = ERROR_SUCCESS)
    {
        LPCTSTR szSaveSubTitle1 = szSubTitle1;
        LPCTSTR szSaveSubTitle2 = szSubTitle2;
        TCHAR szSaveMainTitle[0x80];

        // Set both to NULL so they won't be printed
        StringCopy(szSaveMainTitle, _countof(szSaveMainTitle), szMainTitle);
        szMainTitle = NULL;
        szSubTitle1 = NULL;
        szSubTitle2 = NULL;

        // Print the final information
        if(szSaveMainTitle[0] != 0)
        {
            if(DontPrintResult == false)
            {
                const TCHAR * szVerdict = (dwErrCode == ERROR_SUCCESS) ? _T("succeeded") : _T("failed");

                if(szSaveSubTitle1 != NULL && szSaveSubTitle2 != NULL)
                    PrintMessage(_T("%s (%s+%s) %s."), szSaveMainTitle, szSaveSubTitle1, szSaveSubTitle2, szVerdict);
                else if(szSaveSubTitle1 != NULL)
                    PrintMessage(_T("%s (%s) %s."), szSaveMainTitle, szSaveSubTitle1, szVerdict);
                else
                    PrintMessage(_T("%s %s."), szSaveMainTitle, szVerdict);
            }
            else
            {
                PrintProgress(" ");
                printf_console("\r");
            }
        }

        // Return the error code so the caller can pass it fuhrter
        return dwErrCode;
    }

    //
    // Locking functions (Windows only)
    //

    void Lock()
    {
#ifdef TEST_PLATFORM_WINDOWS
        EnterCriticalSection(&Locker);
#endif
    }

    void Unlock()
    {
#ifdef TEST_PLATFORM_WINDOWS
        LeaveCriticalSection(&Locker);
#endif
    }

    //
    //  Time functions
    //

    ULONGLONG GetCurrentThreadTime()
    {
#ifdef _WIN32
        ULONGLONG TempTime = 0;

        GetSystemTimeAsFileTime((LPFILETIME)(&TempTime));
        return ((TempTime) / 10 / 1000);

        //ULONGLONG KernelTime = 0;
        //ULONGLONG UserTime = 0;
        //ULONGLONG TempTime = 0;

        //GetThreadTimes(GetCurrentThread(), (LPFILETIME)&TempTime, (LPFILETIME)&TempTime, (LPFILETIME)&KernelTime, (LPFILETIME)&UserTime);
        //return ((KernelTime + UserTime) / 10 / 1000);
#else
        return time(NULL) * 1000;
#endif
    }

    bool ProgressReady()
    {
        time_t dwTickCount = time(NULL);
        bool bResult = false;

        if(dwTickCount > dwPrevTickCount)
        {
            dwPrevTickCount = dwTickCount;
            bResult = true;
        }

        return bResult;
    }

    ULONGLONG SetStartTime()
    {
        StartTime = GetCurrentThreadTime();
        return StartTime;
    }

    DWORD SetEndTime()
    {
        EndTime = GetCurrentThreadTime();
        return (DWORD)(EndTime - StartTime);
    }

    void IncrementTotalBytes(ULONGLONG IncrementValue)
    {
        // For some weird reason, this is measurably faster then InterlockedAdd64
        Lock();
        TotalBytes = TotalBytes + IncrementValue;
        Unlock();
    }

    void FormatTotalBytes(char * szBuffer, size_t ccBuffer)
    {
        ULONGLONG Bytes = TotalBytes;
        ULONGLONG Divider = 1000000000;
        char * szBufferEnd = szBuffer + ccBuffer;
        bool bDividingOn = false;

        while((szBuffer + 4) < szBufferEnd && Divider > 0)
        {
            // Are we already dividing?
            if(bDividingOn)
            {
                szBuffer += TestStrPrintf(szBuffer, ccBuffer, " %03u", (DWORD)(Bytes / Divider));
                Bytes = Bytes % Divider;
            }
            else if(Bytes > Divider)
            {
                szBuffer += TestStrPrintf(szBuffer, ccBuffer, "%u", (DWORD)(Bytes / Divider));
                Bytes = Bytes % Divider;
                bDividingOn = true;
            }
            Divider /= 1000;
        }
    }

#ifdef TEST_PLATFORM_WINDOWS
    CRITICAL_SECTION Locker;
#endif

    ULONGLONG TotalBytes;                           // For user's convenience: Total number of bytes
    ULONGLONG ByteCount;                            // For user's convenience: Current number of bytes
    ULONGLONG StartTime;                            // Start time of an operation, in milliseconds
    ULONGLONG EndTime;                              // End time of an operation, in milliseconds
    const char * UserString;
    DWORD UserCount;
    DWORD UserTotal;
    DWORD TickCount;
    DWORD TimeTrigger;                              // For triggering elapsed timers
    DWORD TotalFiles;                               // For user's convenience: Total number of files
    DWORD FileCount;                                // For user's convenience: Curernt number of files
    DWORD DontPrintResult:1;                        // If true, supress printing result from the destructor

    protected:

    const char  * szMainTitle;                      // Title of the text (usually name)
    const TCHAR * szSubTitle1;                      // Title of the text (can be name of the tested file)
    const TCHAR * szSubTitle2;                      // Title of the text (can be name of the tested file)
    size_t nMessageCounter;
    size_t nPrevPrinted;
    time_t dwPrevTickCount;
    bool bMessagePrinted;
};
