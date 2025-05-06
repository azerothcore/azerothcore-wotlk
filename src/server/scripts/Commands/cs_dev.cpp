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

#include "Chat.h"
#include "CommandScript.h"
#include "Creature.h"
#include "Language.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

using namespace Acore::ChatCommands;

class dev_commandscript : public CommandScript
{
public:
    dev_commandscript() : CommandScript("dev_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable commandTable =
        {
            { "formation",   HandleFormationCommand,  SEC_GAMEMASTER, Console::No }
        };

        return commandTable;
    }

    static bool HandleFormationCommand(ChatHandler* handler, uint32 leaderGUID, uint32 groupAI)
    {
        if (!leaderGUID)
        {
            handler->SendErrorMessage(LANG_COMMAND_DEV_FORMATION_ERROR);
            return false;
        }

        if (!groupAI)
        {
            handler->SendErrorMessage(LANG_COMMAND_DEV_FORMATION_ERROR);
            return false;
        }

        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendErrorMessage(LANG_COMMAND_DEV_FORMATION_ERROR);
            return false;
        }

        if (target->IsPlayer())
        {
            handler->SendErrorMessage(LANG_COMMAND_DEV_FORMATION_ERROR);
            return false;
        }

        if (target->IsPet())
        {
            handler->SendErrorMessage(LANG_COMMAND_DEV_FORMATION_ERROR);
            return false;
        }

        if (!target->ToCreature())
        {
            handler->SendErrorMessage(LANG_COMMAND_DEV_FORMATION_ERROR);
            return false;
        }

        // creature_formations - leaderGUID, memberGUIDdist, angle, groupAI, point_1, point_2
        LOG_INFO("sql.dev", "({}, {}, 0, 0, {}, 0, 0),", leaderGUID, target->ToCreature()->GetSpawnId(), groupAI);
        handler->SendErrorMessage(LANG_COMMAND_DEV_FORMATION);
        return true;
    }
};

void AddSC_dev_commandscript()
{
    new dev_commandscript();
}
