/*
    MIT License

    Copyright (c) 2018 José González

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
 */

#include "ScriptMgr.h"
#include "ScriptPCH.h"   //<- You could use the Precompiled Headers too!

//    "something" + _commandscript
class example_commandscript : public CommandScript
{
public:
    example_commandscript() : CommandScript("example_commandscript") { }

    // GetCommands() method override should be the first thing in your script
    std::vector<ChatCommand> GetCommands() const override
    {
        // Level 2 sub command
        static std::vector<ChatCommand> setCommandTable =
        {
            { "name",      SEC_GAMEMASTER,    true,   &HandleSetNameCommand,   "" },
            { "money",     SEC_ADMINISTRATOR, true,   &HandleSetMoneyCommand,  "" }
        };

        // Level 1 sub command
        static std::vector<ChatCommand> exampleCommandTable =
        {
            // This command does something
            { "ping",      SEC_MODERATOR,     false,  &HandlePingCommand,      "" },

            // This commands has sub commands
            { "set",       SEC_GAMEMASTER,    true,   nullptr,                 "", setCommandTable },

            // This is the handler for the root command, if no sub command is invoked
            { "",          SEC_PLAYER,        false,  &HandleExampleCommand,   "" }
        };

        // Root command
        static std::vector<ChatCommand> commandTable =
        {
            //  name       permission   allow console?   handler method      help      child commands table 
            { "example",   SEC_PLAYER,      true,            nullptr,         "",      exampleCommandTable }
        };

        return commandTable; // Return the root command table
    }

    //          Handle + "Something" + Command
    static bool HandleExampleCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage("No Enter!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        // ChatHandler could be Console or Player session
        handler->PSendSysMessage("Hello there! This is an example command");
        return true;
    }

    //          Handle + "Something" + Command
    static bool HandleSetMoneyCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage("No Enter!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        // ChatHandler could be Console or Player session
        handler->PSendSysMessage("Hello there! This is an example command");
        return true;
    }

    //          Handle + "Something" + Command
    static bool HandleSetNameCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage("No Enter!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        auto enter = atol(args);

        auto step = handler->getSelectedPlayerOrSelf()->GetSkillStep(enter);

        // ChatHandler could be Console or Player session
        handler->PSendSysMessage("Step is %d for skill %d", step, enter);
        return true;
    }

    //          Handle + "Something" + Command
    static bool HandlePingCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->SendSysMessage("No Enter!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        // ChatHandler could be Console or Player session
        handler->PSendSysMessage("Hello there! This is an example command");
        return true;
    }
};

void AddSC_example_commandscript()
{
    new example_commandscript();
}
