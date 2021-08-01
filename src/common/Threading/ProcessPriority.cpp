/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "ProcessPriority.h"
#include "Log.h"

#ifdef _WIN32 // Windows
#include <Windows.h>
#elif defined(__linux__)
#include <sched.h>
#include <sys/resource.h>
#define PROCESS_HIGH_PRIORITY -15 // [-20, 19], default is 0
#endif

void SetProcessPriority(std::string const& logChannel, uint32 affinity, bool highPriority)
{
    ///- Handle affinity for multiple processors and process priority
#ifdef _WIN32 // Windows

    HANDLE hProcess = GetCurrentProcess();
    if (affinity > 0)
    {
        ULONG_PTR appAff;
        ULONG_PTR sysAff;

        if (GetProcessAffinityMask(hProcess, &appAff, &sysAff))
        {
            // remove non accessible processors
            ULONG_PTR currentAffinity = affinity & appAff;

            if (!currentAffinity)
            {
                LOG_ERROR(logChannel, "Processors marked in UseProcessors bitmask (hex) %x are not accessible. Accessible processors bitmask (hex): %x", affinity, appAff);
            }
            else if (SetProcessAffinityMask(hProcess, currentAffinity))
            {
                LOG_INFO(logChannel, "Using processors (bitmask, hex): %x", currentAffinity);
            }
            else
            {
                LOG_ERROR(logChannel, "Can't set used processors (hex): %x", currentAffinity);
            }
        }
    }

    if (highPriority)
    {
        if (SetPriorityClass(hProcess, HIGH_PRIORITY_CLASS))
        {
            LOG_INFO(logChannel, "Process priority class set to HIGH");
        }
        else
        {
            LOG_ERROR(logChannel, "Can't set process priority class.");
        }
    }

#elif defined(__linux__) // Linux

    if (affinity > 0)
    {
        cpu_set_t mask;
        CPU_ZERO(&mask);

        for (unsigned int i = 0; i < sizeof(affinity) * 8; ++i)
            if (affinity & (1 << i))
            {
                CPU_SET(i, &mask);
            }

        if (sched_setaffinity(0, sizeof(mask), &mask))
        {
            LOG_ERROR(logChannel, "Can't set used processors (hex): %x, error: %s", affinity, strerror(errno));
        }
        else
        {
            CPU_ZERO(&mask);
            sched_getaffinity(0, sizeof(mask), &mask);
            LOG_INFO(logChannel, "Using processors (bitmask, hex): %lx", *(__cpu_mask*)(&mask));
        }
    }

    if (highPriority)
    {
        if (setpriority(PRIO_PROCESS, 0, PROCESS_HIGH_PRIORITY))
        {
            LOG_ERROR(logChannel, "Can't set process priority class, error: %s", strerror(errno));
        }
        else
        {
            LOG_INFO(logChannel, "Process priority class set to %i", getpriority(PRIO_PROCESS, 0));
        }
    }

#else
    // Suppresses unused argument warning for all other platforms
    (void)logChannel;
    (void)affinity;
    (void)highPriority;
#endif
}
