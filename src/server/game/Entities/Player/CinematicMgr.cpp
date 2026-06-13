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

#include "CinematicMgr.h"
#include "M2Stores.h"
#include "Player.h"

CinematicMgr::CinematicMgr(Player& player) : _player(player)
{
    _cinematicDiff = 0;
    _activeCinematicCameraId = 0;
    _cinematicCamera = nullptr;
    _remoteSightPosition = Position(0.0f, 0.0f, 0.0f);
    _cinematicUpdateTimer.SetInterval(CINEMATIC_UPDATEDIFF);
}

void CinematicMgr::StartCinematic(uint32 const cinematicSequenceId)
{
    _player.SendCinematicStart(cinematicSequenceId);
    if (CinematicSequencesEntry const* sequence = sCinematicSequencesStore.LookupEntry(cinematicSequenceId))
        SetActiveCinematicCamera(sequence->cinematicCamera);
}

void CinematicMgr::StartCinematicCamera()
{
    // Sanity check for active camera set
    if (_activeCinematicCameraId == 0)
        return;

    if (std::vector<FlyByCamera> const* flyByCameras = GetFlyByCameras(_activeCinematicCameraId))
    {
        // Initialize diff, and set camera
        _cinematicDiff = 0;
        _cinematicUpdateTimer.Reset();
        _cinematicCamera = flyByCameras;

        auto camitr = _cinematicCamera->begin();
        if (camitr != _cinematicCamera->end())
        {
            Position const& pos = camitr->locations;
            if (!pos.IsPositionValid())
                return;

            _player.GetMap()->LoadGridsInRange(pos, MAX_VISIBILITY_DISTANCE);
            _remoteSightPosition.Relocate(pos);
            _player.UpdateVisibilityForPlayer();
        }
    }
}

void CinematicMgr::EndCinematic()
{
    if (_activeCinematicCameraId == 0)
        return;

    _cinematicDiff = 0;
    _cinematicUpdateTimer.Reset();
    _cinematicCamera = nullptr;
    _activeCinematicCameraId = 0;
    _player.UpdateVisibilityForPlayer();
}

void CinematicMgr::UpdateCinematic(uint32 const diff)
{
    if (_activeCinematicCameraId == 0 || !_cinematicCamera || _cinematicCamera->empty())
        return;

    _cinematicDiff += diff;
    _cinematicUpdateTimer.Update(diff);
    if (!_cinematicUpdateTimer.Passed())
        return;

    _cinematicUpdateTimer.Reset();

    Position lastPosition;
    uint32 lastTimestamp = 0;
    Position nextPosition;
    uint32 nextTimestamp = 0;

    // Obtain direction of travel
    for (FlyByCamera const& cam : *_cinematicCamera)
    {
        if (cam.timeStamp > _cinematicDiff)
        {
            nextPosition.Relocate(cam.locations);
            nextTimestamp = cam.timeStamp;
            break;
        }
        lastPosition.Relocate(cam.locations);
        lastTimestamp = cam.timeStamp;
    }
    float angle = lastPosition.GetAbsoluteAngle(&nextPosition);
    angle -= lastPosition.GetOrientation();
    angle = Position::NormalizeOrientation(angle);

    // Look for position around 2 second ahead of us.
    int32 workDiff = _cinematicDiff;

    // Modify result based on camera direction (Humans for example, have the camera point behind)
    workDiff += static_cast<int32>(float(CINEMATIC_LOOKAHEAD) * cos(angle));

    // Get an iterator to the last entry in the cameras, to make sure we don't go beyond the end
    auto endItr = _cinematicCamera->rbegin();
    if (endItr != _cinematicCamera->rend() && workDiff > static_cast<int32>(endItr->timeStamp))
        workDiff = endItr->timeStamp;

    // Never try to go back in time before the start of cinematic!
    if (workDiff < 0)
        workDiff = _cinematicDiff;

    // Obtain the previous and next waypoint based on timestamp
    for (FlyByCamera const& cam : *_cinematicCamera)
    {
        if (static_cast<int32>(cam.timeStamp) >= workDiff)
        {
            nextPosition.Relocate(cam.locations);
            nextTimestamp = cam.timeStamp;
            break;
        }
        lastPosition.Relocate(cam.locations);
        lastTimestamp = cam.timeStamp;
    }

    // Never try to go beyond the end of the cinematic
    if (workDiff > static_cast<int32>(nextTimestamp))
        workDiff = static_cast<int32>(nextTimestamp);

    // Interpolate the position for this moment in time (or the adjusted moment in time)
    uint32 timeDiff = nextTimestamp - lastTimestamp;
    uint32 interDiff = workDiff - lastTimestamp;
    float xDiff = nextPosition.m_positionX - lastPosition.m_positionX;
    float yDiff = nextPosition.m_positionY - lastPosition.m_positionY;
    float zDiff = nextPosition.m_positionZ - lastPosition.m_positionZ;
    Position interPosition(lastPosition.m_positionX + (xDiff * (float(interDiff) / float(timeDiff))), lastPosition.m_positionY +
        (yDiff * (float(interDiff) / float(timeDiff))), lastPosition.m_positionZ + (zDiff * (float(interDiff) / float(timeDiff))));

    // Advance _remoteSightPosition to new position
    if (interPosition.IsPositionValid())
    {
        _player.GetMap()->LoadGridsInRange(interPosition, MAX_VISIBILITY_DISTANCE);
        _remoteSightPosition.Relocate(interPosition);
        _player.UpdateVisibilityForPlayer();
    }

    // If we never received an end packet 10 seconds after the final timestamp then force an end
    if (_cinematicDiff > _cinematicCamera->back().timeStamp + 10 * IN_MILLISECONDS)
        EndCinematic();
}
