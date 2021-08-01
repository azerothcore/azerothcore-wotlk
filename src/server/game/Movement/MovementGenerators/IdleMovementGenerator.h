/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_IDLEMOVEMENTGENERATOR_H
#define ACORE_IDLEMOVEMENTGENERATOR_H

#include "MovementGenerator.h"

class IdleMovementGenerator : public MovementGenerator
{
public:
    void Initialize(Unit*) override;
    void Finalize(Unit*) override {  }
    void Reset(Unit*) override;
    bool Update(Unit*, uint32) override { return true; }
    MovementGeneratorType GetMovementGeneratorType() override { return IDLE_MOTION_TYPE; }
};

extern IdleMovementGenerator si_idleMovement;

class RotateMovementGenerator : public MovementGenerator
{
public:
    explicit RotateMovementGenerator(uint32 time, RotateDirection direction) : m_duration(time), m_maxDuration(time), m_direction(direction) {}

    void Initialize(Unit*) override;
    void Finalize(Unit*) override;
    void Reset(Unit* owner) override { Initialize(owner); }
    bool Update(Unit*, uint32) override;
    MovementGeneratorType GetMovementGeneratorType() override { return ROTATE_MOTION_TYPE; }

private:
    uint32 m_duration, m_maxDuration;
    RotateDirection m_direction;
};

class DistractMovementGenerator : public MovementGenerator
{
public:
    explicit DistractMovementGenerator(uint32 timer) : m_timer(timer) {}

    void Initialize(Unit*) override;
    void Finalize(Unit*) override;
    void Reset(Unit* owner) override { Initialize(owner); }
    bool Update(Unit*, uint32) override;
    MovementGeneratorType GetMovementGeneratorType() override { return DISTRACT_MOTION_TYPE; }

private:
    uint32 m_timer;
};

class AssistanceDistractMovementGenerator : public DistractMovementGenerator
{
public:
    AssistanceDistractMovementGenerator(uint32 timer) :
        DistractMovementGenerator(timer) {}

    MovementGeneratorType GetMovementGeneratorType() override { return ASSISTANCE_DISTRACT_MOTION_TYPE; }
    void Finalize(Unit*) override;
};

#endif
