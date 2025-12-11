/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef ACORE_POINTMOVEMENTGENERATOR_H
#define ACORE_POINTMOVEMENTGENERATOR_H

#include "Creature.h"
#include "MovementGenerator.h"
#include "MoveSplineInit.h"
#include <optional>

template<class T>
class PointMovementGenerator : public MovementGeneratorMedium< T, PointMovementGenerator<T> >
{
public:
    PointMovementGenerator(uint32 _id, float _x, float _y, float _z, ForcedMovement forcedMovement, float _speed = 0.0f, float orientation = 0.0f, const Movement::PointsArray* _path = nullptr,
        bool generatePath = false, bool forceDestination = false, std::optional<AnimTier> animTier = std::nullopt, ObjectGuid chargeTargetGUID = ObjectGuid::Empty, bool reverseOrientation = false, ObjectGuid facingTargetGuid = ObjectGuid())
        : id(_id), i_x(_x), i_y(_y), i_z(_z), speed(_speed), i_orientation(orientation), _generatePath(generatePath), _forceDestination(forceDestination), _reverseOrientation(reverseOrientation),
        _chargeTargetGUID(chargeTargetGUID), _forcedMovement(forcedMovement), _facingTargetGuid(facingTargetGuid), _animTier(animTier)
    {
        if (_path)
            m_precomputedPath = *_path;
    }

    void DoInitialize(T*);
    void DoFinalize(T*);
    void DoReset(T*);
    bool DoUpdate(T*, uint32);

    void MovementInform(T*);

    void unitSpeedChanged() { i_recalculateSpeed = true; }

    MovementGeneratorType GetMovementGeneratorType() { return POINT_MOTION_TYPE; }

    bool GetDestination(float& x, float& y, float& z) const { x = i_x; y = i_y; z = i_z; return true; }
private:
    uint32 id;
    float i_x, i_y, i_z;
    float speed;
    float i_orientation;
    bool i_recalculateSpeed;
    Movement::PointsArray m_precomputedPath;
    bool _generatePath;
    bool _forceDestination;
    bool _reverseOrientation;
    ObjectGuid _chargeTargetGUID;
    ForcedMovement _forcedMovement;
    ObjectGuid _facingTargetGuid;
    std::optional<AnimTier> _animTier;
};

class AssistanceMovementGenerator : public PointMovementGenerator<Creature>
{
public:
    AssistanceMovementGenerator(float _x, float _y, float _z) :
        PointMovementGenerator<Creature>(0, _x, _y, _z, FORCED_MOVEMENT_NONE) {}

    MovementGeneratorType GetMovementGeneratorType() { return ASSISTANCE_MOTION_TYPE; }
    void Finalize(Unit*);
};

// Does almost nothing - just doesn't allows previous movegen interrupt current effect.
class EffectMovementGenerator : public MovementGenerator
{
public:
    explicit EffectMovementGenerator(Movement::MoveSplineInit& spline, uint32 Id) : m_Id(Id), i_spline(spline) {}
    void Initialize(Unit*) override;
    void Finalize(Unit*) override;
    void Reset(Unit*) override {}
    bool Update(Unit*, uint32) override;
    MovementGeneratorType GetMovementGeneratorType() override { return EFFECT_MOTION_TYPE; }
private:
    uint32 m_Id;
    Movement::MoveSplineInit i_spline;
};

#endif
