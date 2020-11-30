/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __SIGNAL_HANDLER_H__
#define __SIGNAL_HANDLER_H__

#include <csignal>
#include <unordered_set>
#include <mutex>

namespace acore
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

#endif /* __SIGNAL_HANDLER_H__ */
