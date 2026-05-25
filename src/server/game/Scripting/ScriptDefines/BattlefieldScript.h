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

#ifndef SCRIPT_OBJECT_BATTLEFIELD_SCRIPT_H_
#define SCRIPT_OBJECT_BATTLEFIELD_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum BattlefieldHook
{
    BATTLEFIELDHOOK_ON_PLAYER_ENTER_ZONE,          // 0 - fires at start of HandlePlayerEnterZone, before team assignment
    BATTLEFIELDHOOK_ON_PLAYER_LEAVE_ZONE,          // 1 - fires at end of HandlePlayerLeaveZone, after all cleanup
    BATTLEFIELDHOOK_ON_PLAYER_JOIN_WAR,            // 2 - fires after player is added to the active war
    BATTLEFIELDHOOK_ON_PLAYER_LEAVE_WAR,           // 3 - fires after player is removed from the active war
    BATTLEFIELDHOOK_BEFORE_INVITE_PLAYER_TO_WAR,   // 4 - fires in InvitePlayerToWar before InvitedPlayers insert
    BATTLEFIELDHOOK_ON_WAR_END,                    // 5 - fires in EndBattle after OnBattleEnd(), before timer reset
    BATTLEFIELDHOOK_ON_PLAYER_KILL,                // 6 - fires in HandleKill for every player-kills-player event
    BATTLEFIELDHOOK_END
};

class Battlefield;
class Player;

class BattlefieldScript : public ScriptObject
{
protected:
    BattlefieldScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    [[nodiscard]] bool IsDatabaseBound() const override { return false; }

    /**
     * @brief Called when a player enters the battlefield zone, before team-based data assignment.
     * This is the ideal place to reassign a player's team for cross-faction purposes.
     *
     * @param bf   The Battlefield instance
     * @param player The player entering the zone
     */
    virtual void OnBattlefieldPlayerEnterZone(Battlefield* /*bf*/, Player* /*player*/) { }

    /**
     * @brief Called when a player leaves the battlefield zone, after all cleanup.
     * This is the ideal place to restore a player's original team/faction.
     *
     * @param bf   The Battlefield instance
     * @param player The player leaving the zone
     */
    virtual void OnBattlefieldPlayerLeaveZone(Battlefield* /*bf*/, Player* /*player*/) { }

    /**
     * @brief Called after a player has been added to the active war (accepted the invitation).
     *
     * @param bf   The Battlefield instance
     * @param player The player joining the war
     */
    virtual void OnBattlefieldPlayerJoinWar(Battlefield* /*bf*/, Player* /*player*/) { }

    /**
     * @brief Called after a player has been removed from the active war.
     *
     * @param bf   The Battlefield instance
     * @param player The player leaving the war
     */
    virtual void OnBattlefieldPlayerLeaveWar(Battlefield* /*bf*/, Player* /*player*/) { }

    /**
     * @brief Called inside InvitePlayerToWar after the WillBeKick entry is erased
     * (using the player's current team) and before the player is inserted into
     * m_InvitedPlayers. This is the correct place to reassign a player's effective
     * team for pre-war zone players: the invite bucket write that follows will use
     * the newly assigned team, keeping all subsequent core operations consistent.
     *
     * @param bf   The Battlefield instance
     * @param player The player being invited to war
     */
    virtual void OnBattlefieldBeforeInvitePlayerToWar(Battlefield* /*bf*/, Player* /*player*/) { }

    /**
     * @brief Called in EndBattle() after OnBattleEnd() completes, before the timer is reset.
     * All core PlayersInWar/InvitedPlayers structures have already been cleared.
     * Modules that maintain their own per-war player tracking should use this hook
     * to perform end-of-war cleanup (e.g. restoring cross-faction disguises).
     *
     * @param bf         The Battlefield instance
     * @param endByTimer True if the war ended by the countdown timer expiring
     */
    virtual void OnBattlefieldWarEnd(Battlefield* /*bf*/, bool /*endByTimer*/) { }

    /**
     * @brief Called inside BattlefieldWG::HandleKill for every player-kills-player event,
     * regardless of the victim's WG rank. Fired before the core's own lieutenant-gated
     * quest-credit loop so modules may grant credit for non-lieutenant kills.
     *
     * @param bf     The Battlefield instance
     * @param killer The player who landed the killing blow
     * @param victim The player who was killed
     */
    virtual void OnBattlefieldPlayerKill(Battlefield* /*bf*/, Player* /*killer*/, Player* /*victim*/) { }
};

#endif // SCRIPT_OBJECT_BATTLEFIELD_SCRIPT_H_
