/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Interaction between core and LFGScripts
 */

#include "GroupScript.h"
#include "ObjectGuid.h"
#include "PlayerScript.h"

class Player;
class Group;

namespace lfg
{
    class LFGPlayerScript : public PlayerScript
    {
    public:
        LFGPlayerScript();

        // Player Hooks
        void OnPlayerLevelChanged(Player* player, uint8 oldLevel) override;
        void OnPlayerLogout(Player* player) override;
        void OnPlayerLogin(Player* player) override;
        void OnPlayerBindToInstance(Player* player, Difficulty difficulty, uint32 mapId, bool permanent) override;
        void OnPlayerMapChanged(Player* player) override;
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

    void AddSC_LFGScripts();

} // namespace lfg
