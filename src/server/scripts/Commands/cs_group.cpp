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

#include "ScriptMgr.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "GroupMgr.h"
#include "Language.h"
#include "LFG.h"
#include "ObjectAccessor.h"
#include "Player.h"

#if AC_COMPILER == AC_COMPILER_GNU
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif

using namespace Acore::ChatCommands;

class group_commandscript : public CommandScript
{
public:
    group_commandscript() : CommandScript("group_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> groupCommandTable =
        {
            { "list",    HandleGroupListCommand,    SEC_GAMEMASTER, Console::No },
            { "join",    HandleGroupJoinCommand,    SEC_GAMEMASTER, Console::No },
            { "remove",  HandleGroupRemoveCommand,  SEC_GAMEMASTER, Console::No },
            { "disband", HandleGroupDisbandCommand, SEC_GAMEMASTER, Console::No },
            { "leader",  HandleGroupLeaderCommand,  SEC_GAMEMASTER, Console::No }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "group",  groupCommandTable }
        };
        return commandTable;
    }

    static bool HandleGroupLeaderCommand(ChatHandler* handler, char const* args)
    {
        Player* player = nullptr;
        Group* group = nullptr;
        ObjectGuid guid;
        char* nameStr = strtok((char*)args, " ");

        if (handler->GetPlayerGroupAndGUIDByName(nameStr, player, group, guid))
            if (group && group->GetLeaderGUID() != guid)
            {
                group->ChangeLeader(guid);
                group->SendUpdate();
            }

        return true;
    }

    static bool HandleGroupDisbandCommand(ChatHandler* handler, char const* args)
    {
        Player* player = nullptr;
        Group* group = nullptr;
        ObjectGuid guid;
        char* nameStr = strtok((char*)args, " ");

        if (handler->GetPlayerGroupAndGUIDByName(nameStr, player, group, guid))
            if (group)
                group->Disband();

        return true;
    }

    static bool HandleGroupRemoveCommand(ChatHandler* handler, char const* args)
    {
        Player* player = nullptr;
        Group* group = nullptr;
        ObjectGuid guid;
        char* nameStr = strtok((char*)args, " ");

        if (handler->GetPlayerGroupAndGUIDByName(nameStr, player, group, guid, true))
            if (group)
                group->RemoveMember(guid);

        return true;
    }

    static bool HandleGroupJoinCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* playerSource = nullptr;
        Group* groupSource = nullptr;
        ObjectGuid guidSource;
        ObjectGuid guidTarget;
        char* nameplgrStr = strtok((char*)args, " ");
        char* nameplStr = strtok(nullptr, " ");

        if (handler->GetPlayerGroupAndGUIDByName(nameplgrStr, playerSource, groupSource, guidSource, true))
        {
            if (groupSource)
            {
                Group* groupTarget = nullptr;
                Player* playerTarget = nullptr;
                if (handler->GetPlayerGroupAndGUIDByName(nameplStr, playerTarget, groupTarget, guidTarget, true))
                {
                    if (!groupTarget && playerTarget->GetGroup() != groupSource)
                    {
                        if (!groupSource->IsFull())
                        {
                            groupSource->AddMember(playerTarget);
                            groupSource->BroadcastGroupUpdate();
                            handler->PSendSysMessage(LANG_GROUP_PLAYER_JOINED, playerTarget->GetName().c_str(), playerSource->GetName().c_str());
                            return true;
                        }
                        else
                        {
                            // group is full
                            handler->PSendSysMessage(LANG_GROUP_FULL);
                            return true;
                        }
                    }
                    else
                    {
                        // group is full or target player already in a group
                        handler->PSendSysMessage(LANG_GROUP_ALREADY_IN_GROUP, playerTarget->GetName().c_str());
                        return true;
                    }
                }
            }
            else
            {
                // specified source player is not in a group
                handler->PSendSysMessage(LANG_GROUP_NOT_IN_GROUP, playerSource->GetName().c_str());
                return true;
            }
        }

        return true;
    }

    static bool HandleGroupListCommand(ChatHandler* handler, char const* args)
    {
        Player* playerTarget;
        ObjectGuid guidTarget;
        std::string nameTarget;

        ObjectGuid parseGUID = ObjectGuid::Create<HighGuid::Player>(atol((char*)args));

        if (sObjectMgr->GetPlayerNameByGUID(parseGUID.GetCounter(), nameTarget))
        {
            playerTarget = ObjectAccessor::FindConnectedPlayer(parseGUID);
            guidTarget = parseGUID;
        }
        else if (!handler->extractPlayerTarget((char*)args, &playerTarget, &guidTarget, &nameTarget))
            return false;

        Group* groupTarget = nullptr;
        if (playerTarget)
            groupTarget = playerTarget->GetGroup();

        if (!groupTarget && guidTarget)
            if (uint32 groupGUID = Player::GetGroupIdFromStorage(guidTarget.GetCounter()))
                groupTarget = sGroupMgr->GetGroupByGUID(groupGUID);

        if (groupTarget)
        {
            handler->PSendSysMessage(LANG_GROUP_TYPE, (groupTarget->isRaidGroup() ? "raid" : "party"));
            Group::MemberSlotList const& members = groupTarget->GetMemberSlots();
            for (Group::MemberSlotList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
            {
                Group::MemberSlot const& slot = *itr;

                std::string flags;
                if (slot.flags & MEMBER_FLAG_ASSISTANT)
                    flags = "Assistant";

                if (slot.flags & MEMBER_FLAG_MAINTANK)
                {
                    if (!flags.empty())
                        flags.append(", ");
                    flags.append("MainTank");
                }

                if (slot.flags & MEMBER_FLAG_MAINASSIST)
                {
                    if (!flags.empty())
                        flags.append(", ");
                    flags.append("MainAssist");
                }

                if (flags.empty())
                    flags = "None";

                /*Player* p = ObjectAccessor::FindConnectedPlayer((*itr).guid);
                const char* onlineState = p ? "online" : "offline";

                handler->PSendSysMessage(LANG_GROUP_PLAYER_NAME_GUID, slot.name.c_str(), onlineState,
                    slot.guid.GetCounter(), flags.c_str(), lfg::GetRolesString(slot.roles).c_str());*/
            }
        }
        else
            handler->PSendSysMessage(LANG_GROUP_NOT_IN_GROUP, nameTarget.c_str());

        return true;
    }
};

void AddSC_group_commandscript()
{
    new group_commandscript();
}
