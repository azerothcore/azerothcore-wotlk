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

using namespace Acore::ChatCommands;

class group_commandscript : public CommandScript
{
public:
    group_commandscript() : CommandScript("group_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable groupCommandTable =
        {
            { "list",    HandleGroupListCommand,    SEC_GAMEMASTER, Console::No },
            { "join",    HandleGroupJoinCommand,    SEC_GAMEMASTER, Console::No },
            { "remove",  HandleGroupRemoveCommand,  SEC_GAMEMASTER, Console::No },
            { "disband", HandleGroupDisbandCommand, SEC_GAMEMASTER, Console::No },
            { "leader",  HandleGroupLeaderCommand,  SEC_GAMEMASTER, Console::No }
        };

        static ChatCommandTable commandTable =
        {
            { "group",  groupCommandTable }
        };

        return commandTable;
    }

    static bool HandleGroupLeaderCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        Player* player = nullptr;
        Group* group = nullptr;
        ObjectGuid guid;

        if (handler->GetPlayerGroupAndGUIDByName(target->GetName().c_str(), player, group, guid))
        {
            if (group && group->GetLeaderGUID() != guid)
            {
                group->ChangeLeader(guid);
                group->SendUpdate();
            }
        }

        return true;
    }

    static bool HandleGroupDisbandCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target || !target->IsConnected())
        {
            return false;
        }

        Player* player = nullptr;
        Group* group = nullptr;
        ObjectGuid guid;

        if (handler->GetPlayerGroupAndGUIDByName(target->GetName().c_str(), player, group, guid))
        {
            if (group)
            {
                group->Disband();
            }
        }

        return true;
    }

    static bool HandleGroupRemoveCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target || !target->IsConnected())
        {
            return false;
        }

        Player* player = nullptr;
        Group* group = nullptr;
        ObjectGuid guid;

        if (handler->GetPlayerGroupAndGUIDByName(target->GetName().c_str(), player, group, guid, true))
        {
            if (group)
            {
                group->RemoveMember(guid);
            }
        }

        return true;
    }

    static bool HandleGroupJoinCommand(ChatHandler* handler, std::string const& playerInGroup, std::string const& playerName)
    {
        if (playerInGroup.empty() || playerName.empty())
        {
            return false;
        }

        Player* playerSource = nullptr;
        Group* groupSource = nullptr;
        ObjectGuid guidSource;
        ObjectGuid guidTarget;

        if (handler->GetPlayerGroupAndGUIDByName(playerInGroup.c_str(), playerSource, groupSource, guidSource, true))
        {
            if (groupSource)
            {
                Group* groupTarget = nullptr;
                Player* playerTarget = nullptr;

                if (handler->GetPlayerGroupAndGUIDByName(playerName.c_str(), playerTarget, groupTarget, guidTarget, true))
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

    static bool HandleGroupListCommand(ChatHandler* handler, Optional<PlayerIdentifier> target)
    {
        if (!target)
        {
            target = PlayerIdentifier::FromTargetOrSelf(handler);
        }

        if (!target)
        {
            return false;
        }

        Group* groupTarget = nullptr;

        if (target->IsConnected())
        {
            groupTarget = target->GetConnectedPlayer()->GetGroup();
        }

        if (!groupTarget)
        {
            if (ObjectGuid groupGUID = sCharacterCache->GetCharacterGroupGuidByGuid(target->GetGUID()))
            {
                groupTarget = sGroupMgr->GetGroupByGUID(groupGUID.GetCounter());
            }
        }

        if (!groupTarget)
        {
            handler->PSendSysMessage(LANG_GROUP_NOT_IN_GROUP, target->GetName().c_str());
            return true;
        }

        handler->PSendSysMessage(LANG_GROUP_TYPE, (groupTarget->isRaidGroup() ? "raid" : "party"));

        for (auto const& slot : groupTarget->GetMemberSlots())
        {
            std::string flags;

            if (slot.flags & MEMBER_FLAG_ASSISTANT)
            {
                flags = "Assistant";
            }

            if (slot.flags & MEMBER_FLAG_MAINTANK)
            {
                if (!flags.empty())
                {
                    flags.append(", ");
                }

                flags.append("MainTank");
            }

            if (slot.flags & MEMBER_FLAG_MAINASSIST)
            {
                if (!flags.empty())
                {
                    flags.append(", ");
                }

                flags.append("MainAssist");
            }

            if (flags.empty())
            {
                flags = "None";
            }
        }

        return true;
    }
};

void AddSC_group_commandscript()
{
    new group_commandscript();
}
