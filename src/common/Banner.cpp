/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v3 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

#include "Banner.h"
#include "GitRevision.h"
#include "StringFormat.h"

void Acore::Banner::Show(std::string_view applicationName, void(*log)(std::string_view text), void(*logExtraInfo)())
{
    log(Acore::StringFormatFmt("{} ({})", GitRevision::GetFullVersion(), applicationName));
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

    log(" ");
}
