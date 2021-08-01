/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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
