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
 Name: worldstate_commandscript
 %Complete: 100
 Comment: All worldstate related commands
 Category: commandscripts
 EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "Common.h"
#include "WorldState.h"

using namespace Acore::ChatCommands;

class worldstate_commandscript : public CommandScript
{
public:
    worldstate_commandscript() : CommandScript("worldstate_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable sunsreachCommandTable =
        {
            { "phase",    HandleSunsReachReclamationPhaseCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "subphase", HandleSunsReachReclamationSubPhaseCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "counter",  HandleSunsReachReclamationCounterCommand,  SEC_ADMINISTRATOR, Console::Yes },
        };
        static ChatCommandTable worldStateCommandTable =
        {
            { "sunsreach", sunsreachCommandTable }
        };
        static ChatCommandTable commandTable =
        {
            { "worldstate", worldStateCommandTable }
        };
        return commandTable;
    }

    static bool HandleSunsReachReclamationPhaseCommand(ChatHandler* handler, Optional<uint32> param)
    {
        if (!param)
        {
            handler->PSendSysMessage("{}", sWorldState->GetSunsReachPrintout().data());
            return true;
        }
        sWorldState->HandleSunsReachPhaseTransition(param.value());
        return true;
    }

    static bool HandleSunsReachReclamationSubPhaseCommand(ChatHandler* handler, Optional<uint32> param)
    {
        if (!param)
        {
            handler->PSendSysMessage("{}", sWorldState->GetSunsReachPrintout().data());
            return true;
        }
        sWorldState->HandleSunsReachSubPhaseTransition(param.value());
        return true;
    }

    static bool HandleSunsReachReclamationCounterCommand(ChatHandler* handler, uint32 index, uint32 value)
    {
        if (index >= COUNTERS_MAX)
        {
            handler->PSendSysMessage("Invalid counter, see \".worldstate sunsreach counter\" for usage");
            return true;
        }
        sWorldState->SetSunsReachCounter(SunsReachCounters(index), value);
        handler->PSendSysMessage("{}", sWorldState->GetSunsReachPrintout().data());
        return true;
    }
};

void AddSC_worldstate_commandscript()
{
    new worldstate_commandscript();
}
