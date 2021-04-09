/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 */

#include "Banner.h"
#include "GitRevision.h"
#include "StringFormat.h"

void acore::Banner::Show(char const* applicationName, void(*log)(char const* text), void(*logExtraInfo)())
{
    sLog->outString(acore::StringFormat("%s (%s)", GitRevision::GetFullVersion(), applicationName).c_str());
    sLog->outString("<Ctrl-C> to stop.\n");

    sLog->outString("   █████╗ ███████╗███████╗██████╗  ██████╗ ████████╗██╗  ██╗");
    sLog->outString("  ██╔══██╗╚══███╔╝██╔════╝██╔══██╗██╔═══██╗╚══██╔══╝██║  ██║");
    sLog->outString("  ███████║  ███╔╝ █████╗  ██████╔╝██║   ██║   ██║   ███████║");
    sLog->outString("  ██╔══██║ ███╔╝  ██╔══╝  ██╔══██╗██║   ██║   ██║   ██╔══██║");
    sLog->outString("  ██║  ██║███████╗███████╗██║  ██║╚██████╔╝   ██║   ██║  ██║");
    sLog->outString("  ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝");
    sLog->outString("                                ██████╗ ██████╗ ██████╗ ███████╗");
    sLog->outString("                                ██╔════╝██╔═══██╗██╔══██╗██╔═══╝");
    sLog->outString("                                ██║     ██║   ██║██████╔╝█████╗");
    sLog->outString("                                ██║     ██║   ██║██╔══██╗██╔══╝");
    sLog->outString("                                ╚██████╗╚██████╔╝██║  ██║███████╗");
    sLog->outString("                                 ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝\n");

    sLog->outString("     AzerothCore 3.3.5a  -  www.azerothcore.org\n");

    if (logExtraInfo)
    {
        logExtraInfo();
    }
}
