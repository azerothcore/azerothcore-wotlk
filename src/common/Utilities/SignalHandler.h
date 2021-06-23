/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _SIGNAL_HANDLER_H_
#define _SIGNAL_HANDLER_H_

#include <csignal>
#include <mutex>
#include <unordered_set>

namespace Acore
{
    /// Handle termination signals
    class SignalHandler
    {
    private:
        std::unordered_set<int> _handled;
        mutable std::mutex _mutex;

    public:
        bool handle_signal(int sig, void (*func)(int))
        {
            std::lock_guard lock(_mutex);

            if (_handled.find(sig) != _handled.end())
                return false;

            _handled.insert(sig);
            signal(sig, func);
            return true;
        }

        ~SignalHandler()
        {
            for (auto const& sig : _handled)
                signal(sig, nullptr);
        }
    };
}

#endif // _SIGNAL_HANDLER_H_
