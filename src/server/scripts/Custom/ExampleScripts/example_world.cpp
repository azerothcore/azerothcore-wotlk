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
#include "ScriptPCH.h"   

class world_example : public WorldScript
{
public:
    world_example() : WorldScript("world_example")
    {
        timeToBark = 3000;
    }

    // Called when the open state is changed
    void OnOpenStateChange(bool open)
    {
        if (open)
            sWorld->SendWorldText(LANG_UNIVERSAL,"The world is now open for connections!");
        else
            sWorld->SendWorldText(LANG_UNIVERSAL, "The world is now closed for connections!");
    }

    // These two methods are called before/after the world config is loaded at startup, or on config reload
    void OnBeforeConfigLoad(bool reload) {}

    void OnAfterConfigLoad(bool reload) {}

    // Called when the MOTD is changed
    void OnMotdChange(std::string& newMotd)
    {
        sWorld->SendWorldText(LANG_UNIVERSAL, "MOTD was changed to: %s", newMotd.c_str());
    }

    // Called when the server is going down
    // ShutdownExitCode = SHUTDOWN, ERROR or RESTART
    // ShutdownMask = RESTART and IDLE
    void OnShutdownInitiate(ShutdownExitCode code, ShutdownMask mask)
    {
        if (code == SHUTDOWN_EXIT_CODE || code == ERROR_EXIT_CODE)
            sWorld->SendWorldText(LANG_UNIVERSAL, "The server is going down!");
        else if (code == RESTART_EXIT_CODE)
            sWorld->SendWorldText(LANG_UNIVERSAL, "The server is restarting!");
    }

    // Called when the shutdown is cancelled
    void OnShutdownCancel()
    {
        sWorld->SendWorldText(LANG_UNIVERSAL, "The shutdown was cancelled!");
    }

    // Called in the update cycle, after all other events have been processed
    void OnWorldUpdate(uint32 diff)
    {
        if (diff > timeToBark)
        {
            sWorld->SendWorldText(LANG_UNIVERSAL, "Wof wof!");
            timeToBark = 3000;
        }
        else
        {
            timeToBark -= diff;
        }
    }

    // Called after the databases and world config have been loaded, and before the server starts serving
    void OnStartup()
    {
        sWorld->SendWorldText(LANG_UNIVERSAL, "Our wonderful server is now running!");
    }

    // Called on shutdown, before kicking all the players and closing the server
    void OnShutdown()
    {
        sWorld->SendWorldText(LANG_UNIVERSAL, "See you soon!");
    }

private:
    uint32 timeToBark; // for example purposes, see OnWorldUpdate()
};

void AddSC_world_example()
{
    new world_example();
}
