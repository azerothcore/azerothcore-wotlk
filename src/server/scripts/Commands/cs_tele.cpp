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

/* ScriptData
Name: tele_commandscript
%Complete: 100
Comment: All tele related commands
Category: commandscripts
EndScriptData */

#include "Chat.h"
#include "CommandScript.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Group.h"
#include "MapMgr.h"
#include "ObjectMgr.h"
#include "Player.h"

using namespace Acore::ChatCommands;

class tele_commandscript : public CommandScript
{
public:
    tele_commandscript() : CommandScript("tele_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable teleNameNpcCommandTable =
        {
            { "id",     HandleTeleNameNpcIdCommand,      SEC_GAMEMASTER,    Console::Yes },
            { "guid",   HandleTeleNameNpcSpawnIdCommand, SEC_GAMEMASTER,    Console::Yes },
            { "name",   HandleTeleNameNpcNameCommand,    SEC_GAMEMASTER,    Console::Yes },
        };
        static ChatCommandTable teleNameCommandTable =
        {
            { "npc",    teleNameNpcCommandTable },
            { "",       HandleTeleNameCommand,           SEC_GAMEMASTER,    Console::Yes },
        };
        static ChatCommandTable teleCommandTable =
        {
            { "add",    HandleTeleAddCommand,            SEC_ADMINISTRATOR, Console::No },
            { "del",    HandleTeleDelCommand,            SEC_ADMINISTRATOR, Console::Yes },
            { "name",   teleNameCommandTable },
            { "group",  HandleTeleGroupCommand,          SEC_GAMEMASTER,    Console::No },
            { "",       HandleTeleCommand,               SEC_GAMEMASTER,    Console::No }
        };
        static ChatCommandTable commandTable =
        {
            { "teleport", teleCommandTable }
        };
        return commandTable;
    }

    static bool HandleTeleAddCommand(ChatHandler* handler, std::string const& name)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        if (sObjectMgr->GetGameTele(name))
        {
            handler->SendErrorMessage(LANG_COMMAND_TP_ALREADYEXIST);
            return false;
        }

        GameTele tele;
        tele.position_x  = player->GetPositionX();
        tele.position_y  = player->GetPositionY();
        tele.position_z  = player->GetPositionZ();
        tele.orientation = player->GetOrientation();
        tele.mapId       = player->GetMapId();
        tele.name        = name;

        if (sObjectMgr->AddGameTele(tele))
        {
            handler->SendSysMessage(LANG_COMMAND_TP_ADDED);
        }
        else
        {
            handler->SendErrorMessage(LANG_COMMAND_TP_ADDEDERR);
            return false;
        }

        return true;
    }

    static bool HandleTeleDelCommand(ChatHandler* handler, GameTele const* tele)
    {
        if (!tele)
        {
            handler->SendErrorMessage(LANG_COMMAND_TELE_NOTFOUND);
            return false;
        }
        std::string name = tele->name;
        sObjectMgr->DeleteGameTele(name);
        handler->SendSysMessage(LANG_COMMAND_TP_DELETED);
        return true;
    }

    static bool DoNameTeleport(ChatHandler* handler, PlayerIdentifier player, uint32 mapId, Position const& pos, std::string const& locationName)
    {
        if (!MapMgr::IsValidMapCoord(mapId, pos) || sObjectMgr->IsTransportMap(mapId))
        {
            handler->SendErrorMessage(LANG_INVALID_TARGET_COORD, pos.GetPositionX(), pos.GetPositionY(), mapId);
            return false;
        }

        if (Player* target = player.GetConnectedPlayer())
        {
            // check online security
            if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
                return false;

            std::string chrNameLink = handler->playerLink(target->GetName());

            if (target->IsBeingTeleported())
            {
                handler->SendErrorMessage(LANG_IS_TELEPORTED, chrNameLink.c_str());
                return false;
            }

            handler->PSendSysMessage(LANG_TELEPORTING_TO, chrNameLink.c_str(), "", locationName.c_str());
            if (handler->needReportToTarget(target))
                ChatHandler(target->GetSession()).PSendSysMessage(LANG_TELEPORTED_TO_BY, handler->GetNameLink().c_str());

            // stop flight if need
            if (target->IsInFlight())
            {
                target->GetMotionMaster()->MovementExpired();
                target->CleanupAfterTaxiFlight();
            }
            else // save only in non-flight case
                target->SaveRecallPosition();

            target->TeleportTo({ mapId, pos });
        }
        else
        {
            // check offline security
            if (handler->HasLowerSecurity(nullptr, player.GetGUID()))
                return false;

            std::string nameLink = handler->playerLink(player.GetName());

            handler->PSendSysMessage(LANG_TELEPORTING_TO, nameLink.c_str(), handler->GetAcoreString(LANG_OFFLINE), locationName.c_str());

            Player::SavePositionInDB({ mapId, pos }, sMapMgr->GetZoneId(PHASEMASK_NORMAL, { mapId, pos }), player.GetGUID(), nullptr);
        }

        return true;
    }

    // teleport player to given game_tele.entry
    static bool HandleTeleNameCommand(ChatHandler* handler, Optional<PlayerIdentifier> player, Variant<GameTele const*, EXACT_SEQUENCE("$home")> where)
    {
        if (!player)
            player = PlayerIdentifier::FromTargetOrSelf(handler);
        if (!player)
            return false;

        if (where.index() == 1)    // References target's homebind
        {
            if (Player* target = player->GetConnectedPlayer())
                target->TeleportTo(target->m_homebindMapId, target->m_homebindX, target->m_homebindY, target->m_homebindZ, target->GetOrientation());
            else
            {
                CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_HOMEBIND);
                stmt->SetData(0, player->GetGUID().GetCounter());
                PreparedQueryResult resultDB = CharacterDatabase.Query(stmt);

                if (resultDB)
                {
                    Field* fieldsDB = resultDB->Fetch();
                    WorldLocation loc(fieldsDB[0].Get<uint16>(), fieldsDB[2].Get<float>(), fieldsDB[3].Get<float>(), fieldsDB[4].Get<float>(), 0.0f);
                    uint32 zoneId = fieldsDB[1].Get<uint16>();

                    Player::SavePositionInDB(loc, zoneId, player->GetGUID(), nullptr);
                }
            }

            return true;
        }

        // id, or string, or [name] Shift-click form |color|Htele:id|h[name]|h|r
        GameTele const* tele = where.get<GameTele const*>();
        return DoNameTeleport(handler, *player, tele->mapId, { tele->position_x, tele->position_y, tele->position_z, tele->orientation }, tele->name);
    }

    //Teleport group to given game_tele.entry
    static bool HandleTeleGroupCommand(ChatHandler* handler, GameTele const* tele)
    {
        if (!tele)
        {
            handler->SendErrorMessage(LANG_COMMAND_TELE_NOTFOUND);
            return false;
        }

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendErrorMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, ObjectGuid::Empty))
            return false;

        MapEntry const* map = sMapStore.LookupEntry(tele->mapId);
        if (!map || map->IsBattlegroundOrArena())
        {
            handler->SendErrorMessage(LANG_CANNOT_TELE_TO_BG);
            return false;
        }

        std::string nameLink = handler->GetNameLink(target);

        Group* grp = target->GetGroup();
        if (!grp)
        {
            handler->SendErrorMessage(LANG_NOT_IN_GROUP, nameLink.c_str());
            return false;
        }

        for (GroupReference* itr = grp->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* player = itr->GetSource();

            if (!player || !player->GetSession())
                continue;

            // check online security
            if (handler->HasLowerSecurity(player, ObjectGuid::Empty))
                return false;

            std::string plNameLink = handler->GetNameLink(player);

            if (player->IsBeingTeleported())
            {
                handler->PSendSysMessage(LANG_IS_TELEPORTED, plNameLink.c_str());
                continue;
            }

            handler->PSendSysMessage(LANG_TELEPORTING_TO, plNameLink.c_str(), "", tele->name.c_str());
            if (handler->needReportToTarget(player))
                ChatHandler(player->GetSession()).PSendSysMessage(LANG_TELEPORTED_TO_BY, nameLink.c_str());

            // stop flight if need
            if (target->IsInFlight())
            {
                target->GetMotionMaster()->MovementExpired();
                target->CleanupAfterTaxiFlight();
            }
            else // save only in non-flight case
                target->SaveRecallPosition();

            player->TeleportTo(tele->mapId, tele->position_x, tele->position_y, tele->position_z, tele->orientation);
        }

        return true;
    }

    static bool HandleTeleCommand(ChatHandler* handler, GameTele const* tele)
    {
        if (!tele)
        {
            handler->SendErrorMessage(LANG_COMMAND_TELE_NOTFOUND);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();
        if (player->IsInCombat())
        {
            handler->SendErrorMessage(LANG_YOU_IN_COMBAT);
            return false;
        }

        MapEntry const* map = sMapStore.LookupEntry(tele->mapId);
        if (!map || (map->IsBattlegroundOrArena() && (player->GetMapId() != tele->mapId || !player->IsGameMaster())))
        {
            handler->SendErrorMessage(LANG_CANNOT_TELE_TO_BG);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        else // save only in non-flight case
            player->SaveRecallPosition();

        player->TeleportTo(tele->mapId, tele->position_x, tele->position_y, tele->position_z, tele->orientation);
        return true;
    }

    static bool HandleTeleNameNpcIdCommand(ChatHandler* handler, PlayerIdentifier player, Variant<Hyperlink<creature_entry>, uint32> creatureId)
    {
        CreatureData const* spawnpoint = nullptr;
        for (auto const& pair : sObjectMgr->GetAllCreatureData())
        {
            if (pair.second.id1 != *creatureId)
                continue;

            if (!spawnpoint)
                spawnpoint = &pair.second;
            else
            {
                handler->SendSysMessage(LANG_COMMAND_GOCREATMULTIPLE);
                break;
            }
        }

        if (!spawnpoint)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
            return false;
        }

        CreatureTemplate const* creatureTemplate = ASSERT_NOTNULL(sObjectMgr->GetCreatureTemplate(*creatureId));

        return DoNameTeleport(handler, player, spawnpoint->mapid, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, creatureTemplate->Name);
    }

    static bool HandleTeleNameNpcSpawnIdCommand(ChatHandler* handler, PlayerIdentifier player, Variant<Hyperlink<creature>, ObjectGuid::LowType> spawnId)
    {
        CreatureData const* spawnpoint = sObjectMgr->GetCreatureData(spawnId);
        if (!spawnpoint)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
            return false;
        }

        CreatureTemplate const* creatureTemplate = ASSERT_NOTNULL(sObjectMgr->GetCreatureTemplate(spawnpoint->id1));

        return DoNameTeleport(handler, player, spawnpoint->mapid, { spawnpoint->posX, spawnpoint->posY, spawnpoint->posZ }, creatureTemplate->Name);
    }

    static bool HandleTeleNameNpcNameCommand(ChatHandler* handler, PlayerIdentifier player, Tail name)
    {
        std::string normalizedName(name);
        WorldDatabase.EscapeString(normalizedName);

        // May need work //PussyWizardEliteMalcrom
        QueryResult result = WorldDatabase.Query("SELECT c.position_x, c.position_y, c.position_z, c.orientation, c.map, ct.name FROM creature c INNER JOIN creature_template ct ON c.id1 = ct.entry WHERE ct.name LIKE '{}'", normalizedName);
        if (!result)
        {
            handler->SendErrorMessage(LANG_COMMAND_GOCREATNOTFOUND);
            return false;
        }

        if (result->GetRowCount() > 1)
            handler->SendSysMessage(LANG_COMMAND_GOCREATMULTIPLE);

        Field* fields = result->Fetch();
        return DoNameTeleport(handler, player, fields[4].Get<uint16>(), { fields[0].Get<float>(), fields[1].Get<float>(), fields[2].Get<float>(), fields[3].Get<float>() }, fields[5].Get<std::string>());
    }
};

void AddSC_tele_commandscript()
{
    new tele_commandscript();
}
