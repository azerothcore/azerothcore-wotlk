/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v3 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

#include "Banner.h"
#include "GitRevision.h"
#include "StringFormat.h"

void acore::Banner::Show(char const* applicationName, void(*log)(char const* text), void(*logExtraInfo)())
{
    log(acore::StringFormat("%s (%s)", GitRevision::GetFullVersion(), applicationName).c_str());
    log("<Ctrl-C> to stop.\n");
    log("   █████╗ ███████╗███████╗██████╗  ██████╗ ████████╗██╗  ██╗");
    log("  ██╔══██╗╚══███╔╝██╔════╝██╔══██╗██╔═══██╗╚══██╔══╝██║  ██║");
    log("  ███████║  ███╔╝ █████╗  ██████╔╝██║   ██║   ██║   ███████║");
    log("  ██╔══██║ ███╔╝  ██╔══╝  ██╔══██╗██║   ██║   ██║   ██╔══██║");
    log("  ██║  ██║███████╗███████╗██║  ██║╚██████╔╝   ██║   ██║  ██║");
    log("  ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝");
    log("                                 ██████╗ ██████╗ ██████╗ ███████╗");
    log("                                ██╔════╝██╔═══██╗██╔══██╗██╔════╝");
    log("                                ██║     ██║   ██║██████╔╝█████╗");
    log("                                ██║     ██║   ██║██╔══██╗██╔══╝");
    log("                                ╚██████╗╚██████╔╝██║  ██║███████╗");
    log("                                 ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝\n");
    log("     AzerothCore 3.3.5a  -  www.azerothcore.org\n");

    if (logExtraInfo)
    {
        logExtraInfo();
    }
}
