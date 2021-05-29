/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/// \addtogroup Trinityd
/// @{
/// \file

#ifndef _ACORE_RARUNNABLE_H_
#define _ACORE_RARUNNABLE_H_

#include "Common.h"
#include "Threading.h"
#include <ace/Reactor.h>

class RARunnable : public acore::Runnable
{
public:
    RARunnable();
    ~RARunnable() override;
    void run() override;

private:
    ACE_Reactor* m_Reactor;
};

#endif /* _ACORE_RARUNNABLE_H_ */

/// @}
