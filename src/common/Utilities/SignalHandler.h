/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef __SIGNAL_HANDLER_H__
#define __SIGNAL_HANDLER_H__

#include <ace/Event_Handler.h>

namespace acore
{

    /// Handle termination signals
    class SignalHandler : public ACE_Event_Handler
    {
    public:
        int handle_signal(int SigNum, siginfo_t* = nullptr, ucontext_t* = nullptr) override
        {
            HandleSignal(SigNum);
            return 0;
        }
        virtual void HandleSignal(int /*SigNum*/) { };
    };

}

#endif /* __SIGNAL_HANDLER_H__ */
