/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_MOVEMENTGENERATOR_IMPL_H
#define ACORE_MOVEMENTGENERATOR_IMPL_H

#include "MovementGenerator.h"

template<class MOVEMENT_GEN>
inline MovementGenerator*
MovementGeneratorFactory<MOVEMENT_GEN>::Create(void * /*data*/) const
{
    return (new MOVEMENT_GEN());
}
#endif
