/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Interaction between core and LFGScripts
 */

#include "Common.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"

class Player;
class Group;

namespace lfg
{

    class LFGPlayerScript : public PlayerScript
    {
    public:
        LFGPlayerScript();

        // Player Hooks
        void OnLevelChanged(Player* player, uint8 oldLevel) override;
        void OnLogout(Player* player) override;
        void OnLogin(Player* player) override;
        void OnBindToInstance(Player* player, Difficulty difficulty, uint32 mapId, bool permanent) override;
        void OnMapChanged(Player* player) override;
    };

    class LFGGroupScript : public GroupScript
    {
    public:
        LFGGroupScript();

        // Group Hooks
        void OnAddMember(Group* group, ObjectGuid guid) override;
        void OnRemoveMember(Group* group, ObjectGuid guid, RemoveMethod method, ObjectGuid kicker, char const* reason) override;
        void OnDisband(Group* group) override;
        void OnChangeLeader(Group* group, ObjectGuid newLeaderGuid, ObjectGuid oldLeaderGuid) override;
        void OnInviteMember(Group* group, ObjectGuid guid) override;
    };

} // namespace lfg
