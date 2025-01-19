/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

 /* ScriptData
 Name: sunsreach_commandscript
 %Complete: 100
 Comment: All sunsreach related commands
 Category: commandscripts
 EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "Common.h"
#include "GameEventMgr.h"
#include "GameTime.h"
#include "Language.h"
#include "Timer.h"
#include "WorldState.h"

using namespace Acore::ChatCommands;

using EventEntry = Variant<Hyperlink<gameevent>, uint16>;

class sunsreach_commandscript : public CommandScript
{
public:
    sunsreach_commandscript() : CommandScript("sunsreach_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable sunsreachCommandTable =
        {
            { "phase",    HandlePhaseCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "subphase", HandleSubPhaseCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "counter",  HandleCounterCommand,  SEC_ADMINISTRATOR, Console::Yes },
            // { "gate",       HandleSunwellGateCommand,       SEC_ADMINISTRATOR, Console::Yes }
            // { "gatecounter",       HandleSunwellGateCounterCommand,       SEC_ADMINISTRATOR, Console::Yes }
        };
        static ChatCommandTable commandTable =
        {
            { "sunsreach", sunsreachCommandTable }
        };
        return commandTable;
    }

    static bool HandlePhaseCommand(ChatHandler* handler, Optional<uint32> param)
    {
        if (!param)
        {
            PSendSysMessage("%s", sWorldState->GetSunsReachPrintout().data());
            return true;
        }
        sWorldState->HandleSunsReachPhaseTransition(param);
        return true;
    }

    static bool HandleSubPhaseCommand(ChatHandler* handler, Optional<uint32> param)
    {
        if (!param)
        {
            PSendSysMessage("%s", sWorldState->GetSunsReachPrintout().data());
            return true;
        }
        sWorldState->HandleSunsReachSubPhaseTransition(param);
        return true;
    }

    static bool HandleCounterCommand(ChatHandler* handler, uint32 index, uint32 value)
    {
        if (index >= COUNTERS_MAX)
        {
            PSendSysMessage("Enter valid index for counter.");
            return true;
        }
        sWorldState->SetSunsReachCounter(SunsReachCounters(index), value);
        return true;
    }

    // static bool HandleSunwellGateCommand(ChatHandler* handler, EventEntry const eventId)
    // static bool HandleSunwellGateCounterCommand(ChatHandler* handler, EventEntry const eventId)
    // {
    //     return true;
    // }
};


void AddSC_sunsreach_commandscript()
{
    new sunsreach_commandscript();
}
