/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_HOMEMOVEMENTGENERATOR_H
#define ACORE_HOMEMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

class Creature;

template < class T >
class HomeMovementGenerator;

template <>
class HomeMovementGenerator<Creature> : public MovementGeneratorMedium< Creature, HomeMovementGenerator<Creature> >
{
public:
    HomeMovementGenerator() : arrived(false), i_recalculateTravel(false) {}
    ~HomeMovementGenerator() {}

    void DoInitialize(Creature*);
    void DoFinalize(Creature*);
    void DoReset(Creature*);
    bool DoUpdate(Creature*, const uint32);
    MovementGeneratorType GetMovementGeneratorType() { return HOME_MOTION_TYPE; }
    void unitSpeedChanged() { i_recalculateTravel = true; }

private:
    void _setTargetLocation(Creature*);
    bool arrived : 1;
    bool i_recalculateTravel : 1;
};
#endif
