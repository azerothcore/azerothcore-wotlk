/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Creature.h"
#include "CreatureAI.h"
#include "Errors.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "Player.h"
#include "PointMovementGenerator.h"
#include "World.h"

//----- Point Movement Generator
template<class T>
void PointMovementGenerator<T>::DoInitialize(T* unit)
{
    Creature* cOwner = unit->ToCreature();
    if (unit->HasUnitState(UNIT_STATE_NOT_MOVE) || cOwner && cOwner->IsMovementPreventedByCasting())
    {
        i_interrupted = true;
        unit->StopMoving();
        return;
    }

    if (!unit->IsStopped())
        unit->StopMoving();

    unit->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
    i_recalculateSpeed = false;
    Movement::MoveSplineInit init(unit);
    if (m_precomputedPath.size()) // pussywizard: for charge
        init.MovebyPath(m_precomputedPath);
    else
    {
        init.MoveTo(i_x, i_y, i_z, _generatePath);
    }

    if (speed > 0.0f)
        init.SetVelocity(speed);

    if (i_orientation > 0.0f)
    {
        init.SetFacing(i_orientation);
    }

    init.Launch();
}

template<class T>
bool PointMovementGenerator<T>::DoUpdate(T* unit, uint32 /*diff*/)
{
    if (!unit)
        return false;

    if (m_precomputedPath.size())
    {
        return !unit->movespline->Finalized();
    }

    Creature* cOwner = unit->ToCreature();

    if (unit->HasUnitState(UNIT_STATE_NOT_MOVE) || cOwner && cOwner->IsMovementPreventedByCasting())
    {
        unit->ClearUnitState(UNIT_STATE_ROAMING_MOVE);
        unit->StopMoving();
        i_interrupted = true;
        return true;
    }

    unit->AddUnitState(UNIT_STATE_ROAMING_MOVE);

    if ((i_interrupted && unit->movespline->Finalized()) || (i_recalculateSpeed && !unit->movespline->Finalized()))
    {
        i_recalculateSpeed = false;
        i_interrupted = false;
        Movement::MoveSplineInit init(unit);

        init.MoveTo(i_x, i_y, i_z, _generatePath);

        if (speed > 0.0f) // Default value for point motion type is 0.0, if 0.0 spline will use GetSpeed on unit
            init.SetVelocity(speed);

        if (i_orientation > 0.0f)
        {
            init.SetFacing(i_orientation);
        }

        init.Launch();
    }

    return !unit->movespline->Finalized();
}

template<class T>
void PointMovementGenerator<T>::DoFinalize(T* unit)
{
    unit->ClearUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);

    if (unit->movespline->Finalized())
        MovementInform(unit);
}

template<class T>
void PointMovementGenerator<T>::DoReset(T* unit)
{
    if (!unit->IsStopped())
        unit->StopMoving();

    unit->AddUnitState(UNIT_STATE_ROAMING | UNIT_STATE_ROAMING_MOVE);
}

template<class T>
void PointMovementGenerator<T>::MovementInform(T* /*unit*/)
{
}

template <> void PointMovementGenerator<Creature>::MovementInform(Creature* unit)
{
    if (unit->AI())
        unit->AI()->MovementInform(POINT_MOTION_TYPE, id);
}

template void PointMovementGenerator<Player>::DoInitialize(Player*);
template void PointMovementGenerator<Creature>::DoInitialize(Creature*);
template void PointMovementGenerator<Player>::DoFinalize(Player*);
template void PointMovementGenerator<Creature>::DoFinalize(Creature*);
template void PointMovementGenerator<Player>::DoReset(Player*);
template void PointMovementGenerator<Creature>::DoReset(Creature*);
template bool PointMovementGenerator<Player>::DoUpdate(Player*, uint32);
template bool PointMovementGenerator<Creature>::DoUpdate(Creature*, uint32);

void AssistanceMovementGenerator::Finalize(Unit* unit)
{
    unit->ToCreature()->SetNoCallAssistance(false);
    unit->ToCreature()->CallAssistance();
    if (unit->IsAlive())
        unit->GetMotionMaster()->MoveSeekAssistanceDistract(sWorld->getIntConfig(CONFIG_CREATURE_FAMILY_ASSISTANCE_DELAY));
}

bool EffectMovementGenerator::Update(Unit* unit, uint32)
{
    return !unit->movespline->Finalized();
}

void EffectMovementGenerator::Finalize(Unit* unit)
{
    if (unit->GetTypeId() != TYPEID_UNIT)
        return;

    if (unit->GetTypeId() == TYPEID_UNIT && unit->HasUnitMovementFlag(MOVEMENTFLAG_FALLING) && unit->movespline->isFalling()) // pussywizard
        unit->RemoveUnitMovementFlag(MOVEMENTFLAG_FALLING);

    // Need restore previous movement since we have no proper states system
    //if (unit->IsAlive() && !unit->HasUnitState(UNIT_STATE_CONFUSED | UNIT_STATE_FLEEING))
    //{
    //    if (Unit* victim = unit->GetVictim())
    //        unit->GetMotionMaster()->MoveChase(victim);
    //    else
    //        unit->GetMotionMaster()->Initialize();
    //}

    if (unit->ToCreature()->AI())
        unit->ToCreature()->AI()->MovementInform(EFFECT_MOTION_TYPE, m_Id);
}
