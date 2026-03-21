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

#ifndef CinematicMgr_h__
#define CinematicMgr_h__

#include "Define.h"
#include "Position.h"
#include "Timer.h"
#include <vector>

constexpr auto CINEMATIC_UPDATEDIFF = 500;
constexpr auto CINEMATIC_LOOKAHEAD  = 2000;

class Player;
struct FlyByCamera;

class AC_GAME_API CinematicMgr
{
public:
    explicit CinematicMgr(Player& player);
    ~CinematicMgr() = default;

    // Cinematic camera data and remote sight functions
    void StartCinematic(uint32 const cinematicSequenceId);
    uint32 GetActiveCinematicCamera() const { return _activeCinematicCameraId; }
    void SetActiveCinematicCamera(uint32 cinematicCameraId = 0) { _activeCinematicCameraId = cinematicCameraId; }
    bool IsOnCinematic() const { return (_cinematicCamera != nullptr); }
    void StartCinematicCamera();
    void EndCinematic();
    void UpdateCinematic(uint32 const diff);
    Position const& GetRemoteSightPosition() const { return _remoteSightPosition; }

private:
    Player&         _player;
    uint32          _cinematicDiff;
    uint32          _activeCinematicCameraId;
    std::vector<FlyByCamera> const* _cinematicCamera;
    Position        _remoteSightPosition;
    IntervalTimer   _cinematicUpdateTimer;
};

#endif
