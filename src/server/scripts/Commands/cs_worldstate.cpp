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
            { "status",      HandleSunsReachReclamationStatusCommand,   SEC_ADMINISTRATOR, Console::Yes },
            { "phase",       HandleSunsReachReclamationPhaseCommand,    SEC_ADMINISTRATOR, Console::Yes },
            { "subphase",    HandleSunsReachReclamationSubPhaseCommand, SEC_ADMINISTRATOR, Console::Yes },
            { "counter",     HandleSunsReachReclamationCounterCommand,  SEC_ADMINISTRATOR, Console::Yes },
            { "gate",        HandleSunwellGateCommand,                  SEC_ADMINISTRATOR, Console::Yes },
            { "gatecounter", HandleSunwellGateCounterCommand,           SEC_ADMINISTRATOR, Console::Yes },
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

    static bool HandleSunsReachReclamationStatusCommand(ChatHandler* handler )
    {
        handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
        return true;
    }

    static bool HandleSunsReachReclamationPhaseCommand(ChatHandler* handler, uint32 phase)
    {
        if (phase > SUNS_REACH_PHASE_4_HARBOR)
        {
            handler->PSendSysMessage("Invalid phase, see \".worldstate sunsreach phase\" for usage");
            return false;
        }
        sWorldState->HandleSunsReachPhaseTransition(phase);
        handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
        return true;
    }

    static bool HandleSunsReachReclamationSubPhaseCommand(ChatHandler* handler, uint32 subphase)
    {
        if (subphase > SUBPHASE_ALL)
        {
            handler->PSendSysMessage("Invalid subphase, see \".worldstate sunsreach subphase\" for usage");
            return false;
        }
        sWorldState->HandleSunsReachSubPhaseTransition(subphase);
        handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
        return true;
    }

    static bool HandleSunsReachReclamationCounterCommand(ChatHandler* handler, Optional<uint32> index, Optional<uint32> value)
    {
        if (!index || !value || index.value() >= COUNTERS_MAX)
        {
            handler->PSendSysMessage("Syntax: .worldstate sunsreach counter <index> <value>.");
            handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
            return true;
        }
        sWorldState->SetSunsReachCounter(SunsReachCounters(index.value()), value.value());
        handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
        return true;
    }

    static bool HandleSunwellGateCommand(ChatHandler* handler, uint32 newGate)
    {
        if (newGate > SUNWELL_ARCHONISUS_GATE3_OPEN)
        {
            handler->PSendSysMessage("Invalid phase, see \".worldstate sunsreach gate\" for usage");
            return false;
        }
        sWorldState->HandleSunwellGateTransition(newGate);
        handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
        return true;
    }

    static bool HandleSunwellGateCounterCommand(ChatHandler* handler, Optional<uint32> index, Optional<uint32> value)
    {
        if (!index || !value || index.value() >= COUNTERS_MAX_GATES)
        {
            handler->PSendSysMessage("Syntax: .worldstate sunsreach gatecounter <index> <value>.");
            handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
            return true;
        }
        sWorldState->SetSunwellGateCounter(SunwellGateCounters(index.value()), value.value());
        handler->PSendSysMessage(sWorldState->GetSunsReachPrintout());
        return true;
    }
};

void AddSC_worldstate_commandscript()
{
    new worldstate_commandscript();
}
