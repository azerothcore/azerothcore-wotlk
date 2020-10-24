/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Chat.h"
#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "ArenaTeamMgr.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "GuildMgr.h"
#include "InstanceSaveMgr.h"
#include "Language.h"
#include "MovementGenerator.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "SpellAuras.h"
#include "TargetedMovementGenerator.h"
#include "WeatherMgr.h"
#include "ace/INET_Addr.h"
#include "Player.h"
#include "Pet.h"
#include "LFG.h"
#include "GroupMgr.h"
#include "BattlegroundMgr.h"
#include "MapManager.h"
#include "GameGraveyard.h"

class misc_commandscript : public CommandScript
{
public:
    misc_commandscript() : CommandScript("misc_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> groupCommandTable =
        {
            { "leader",         SEC_GAMEMASTER,             false,  &HandleGroupLeaderCommand,          "" },
            { "disband",        SEC_GAMEMASTER,             false,  &HandleGroupDisbandCommand,         "" },
            { "remove",         SEC_GAMEMASTER,             false,  &HandleGroupRemoveCommand,          "" },
            { "join",           SEC_GAMEMASTER,             false,  &HandleGroupJoinCommand,            "" },
            { "list",           SEC_GAMEMASTER,             false,  &HandleGroupListCommand,            "" }
        };
        static std::vector<ChatCommand> petCommandTable =
        {
            { "create",             SEC_GAMEMASTER,         false, &HandleCreatePetCommand,             "" },
            { "learn",              SEC_GAMEMASTER,         false, &HandlePetLearnCommand,              "" },
            { "unlearn",            SEC_GAMEMASTER,         false, &HandlePetUnlearnCommand,            "" }
        };
        static std::vector<ChatCommand> sendCommandTable =
        {
            { "items",              SEC_GAMEMASTER,         true,  &HandleSendItemsCommand,             "" },
            { "mail",               SEC_GAMEMASTER,         true,  &HandleSendMailCommand,              "" },
            { "message",            SEC_ADMINISTRATOR,      true,  &HandleSendMessageCommand,           "" },
            { "money",              SEC_GAMEMASTER,         true,  &HandleSendMoneyCommand,             "" }
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "dev",                SEC_ADMINISTRATOR,      false, &HandleDevCommand,                   "" },
            { "gps",                SEC_MODERATOR,          false, &HandleGPSCommand,                   "" },
            { "aura",               SEC_GAMEMASTER,         false, &HandleAuraCommand,                  "" },
            { "unaura",             SEC_GAMEMASTER,         false, &HandleUnAuraCommand,                "" },
            { "appear",             SEC_MODERATOR,          false, &HandleAppearCommand,                "" },
            { "summon",             SEC_GAMEMASTER,         false, &HandleSummonCommand,                "" },
            { "groupsummon",        SEC_GAMEMASTER,         false, &HandleGroupSummonCommand,           "" },
            { "commands",           SEC_PLAYER,             true,  &HandleCommandsCommand,              "" },
            { "die",                SEC_GAMEMASTER,         false, &HandleDieCommand,                   "" },
            { "revive",             SEC_GAMEMASTER,         true,  &HandleReviveCommand,                "" },
            { "dismount",           SEC_PLAYER,             false, &HandleDismountCommand,              "" },
            { "guid",               SEC_GAMEMASTER,         false, &HandleGUIDCommand,                  "" },
            { "help",               SEC_PLAYER,             true,  &HandleHelpCommand,                  "" },
            { "itemmove",           SEC_GAMEMASTER,         false, &HandleItemMoveCommand,              "" },
            { "cooldown",           SEC_GAMEMASTER,         false, &HandleCooldownCommand,              "" },
            { "distance",           SEC_ADMINISTRATOR,      false, &HandleGetDistanceCommand,           "" },
            { "recall",             SEC_GAMEMASTER,         false, &HandleRecallCommand,                "" },
            { "save",               SEC_PLAYER,             false, &HandleSaveCommand,                  "" },
            { "saveall",            SEC_GAMEMASTER,         true,  &HandleSaveAllCommand,               "" },
            { "kick",               SEC_GAMEMASTER,         true,  &HandleKickPlayerCommand,            "" },
            { "unstuck",            SEC_GAMEMASTER,         true,  &HandleUnstuckCommand,               "" },
            { "linkgrave",          SEC_ADMINISTRATOR,      false, &HandleLinkGraveCommand,             "" },
            { "neargrave",          SEC_GAMEMASTER,         false, &HandleNearGraveCommand,             "" },
            { "showarea",           SEC_GAMEMASTER,         false, &HandleShowAreaCommand,              "" },
            { "hidearea",           SEC_ADMINISTRATOR,      false, &HandleHideAreaCommand,              "" },
            { "additem",            SEC_GAMEMASTER,         false, &HandleAddItemCommand,               "" },
            { "additemset",         SEC_GAMEMASTER,         false, &HandleAddItemSetCommand,            "" },
            { "wchange",            SEC_ADMINISTRATOR,      false, &HandleChangeWeather,                "" },
            { "maxskill",           SEC_GAMEMASTER,         false, &HandleMaxSkillCommand,              "" },
            { "setskill",           SEC_GAMEMASTER,         false, &HandleSetSkillCommand,              "" },
            { "pinfo",              SEC_GAMEMASTER,         true,  &HandlePInfoCommand,                 "" },
            { "respawn",            SEC_GAMEMASTER,         false, &HandleRespawnCommand,               "" },
            { "send",               SEC_GAMEMASTER,         true,  nullptr,                             "", sendCommandTable },
            { "pet",                SEC_GAMEMASTER,         false, nullptr,                             "", petCommandTable },
            { "mute",               SEC_GAMEMASTER,         true,  &HandleMuteCommand,                  "" },
            { "mutehistory",        SEC_GAMEMASTER,         true,  &HandleMuteInfoCommand,              "" },
            { "unmute",             SEC_GAMEMASTER,         true,  &HandleUnmuteCommand,                "" },
            { "movegens",           SEC_ADMINISTRATOR,      false, &HandleMovegensCommand,              "" },
            { "cometome",           SEC_ADMINISTRATOR,      false, &HandleComeToMeCommand,              "" },
            { "damage",             SEC_GAMEMASTER,         false, &HandleDamageCommand,                "" },
            { "combatstop",         SEC_GAMEMASTER,         true,  &HandleCombatStopCommand,            "" },
            { "flusharenapoints",   SEC_ADMINISTRATOR,      false, &HandleFlushArenaPointsCommand,      "" },
            { "repairitems",        SEC_GAMEMASTER,         true,  &HandleRepairitemsCommand,           "" },
            { "freeze",             SEC_GAMEMASTER,         false, &HandleFreezeCommand,                "" },
            { "unfreeze",           SEC_GAMEMASTER,         false, &HandleUnFreezeCommand,              "" },
            { "group",              SEC_GAMEMASTER,         false, nullptr,                             "", groupCommandTable },
            { "possess",            SEC_GAMEMASTER,         false, HandlePossessCommand,                "" },
            { "unpossess",          SEC_GAMEMASTER,         false, HandleUnPossessCommand,              "" },
            { "bindsight",          SEC_ADMINISTRATOR,      false, HandleBindSightCommand,              "" },
            { "unbindsight",        SEC_ADMINISTRATOR,      false, HandleUnbindSightCommand,            "" },
            { "playall",            SEC_GAMEMASTER,         false, HandlePlayAllCommand,                "" },
            { "skirmish",           SEC_ADMINISTRATOR,      false, HandleSkirmishCommand,               "" },
            { "mailbox",            SEC_MODERATOR,          false, &HandleMailBoxCommand,               "" }
        };
        return commandTable;
    }

    static bool HandleSkirmishCommand(ChatHandler* handler, char const* args)
    {
        Tokenizer tokens(args, ' ');

        if (!*args || !tokens.size())
        {
            handler->PSendSysMessage("Usage: .skirmish [arena] [XvX] [Nick1] [Nick2] ... [NickN]");
            handler->PSendSysMessage("[arena] can be \"all\" or comma-separated list of possible arenas (NA,BE,RL,DS,RV).");
            handler->PSendSysMessage("[XvX] can be 1v1, 2v2, 3v3, 5v5. After [XvX] specify enough nicknames for that mode.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Tokenizer::const_iterator i = tokens.begin();

        std::set<BattlegroundTypeId> allowedArenas;
        std::string arenasStr = *(i++);
        std::string tmpStr;
        Tokenizer arenaTokens(arenasStr, ',');
        for (Tokenizer::const_iterator itr = arenaTokens.begin(); itr != arenaTokens.end(); ++itr)
        {
            tmpStr = std::string(*itr);
            if (tmpStr == "all")
            {
                if (arenaTokens.size() > 1)
                {
                    handler->PSendSysMessage("Invalid [arena] specified.");
                    handler->SetSentErrorMessage(true);
                    return false;
                }
                allowedArenas.insert(BATTLEGROUND_NA);
                allowedArenas.insert(BATTLEGROUND_BE);
                allowedArenas.insert(BATTLEGROUND_RL);
                allowedArenas.insert(BATTLEGROUND_DS);
                allowedArenas.insert(BATTLEGROUND_RV);
            }
            else if (tmpStr == "NA")
                allowedArenas.insert(BATTLEGROUND_NA);
            else if (tmpStr == "BE")
                allowedArenas.insert(BATTLEGROUND_BE);
            else if (tmpStr == "RL")
                allowedArenas.insert(BATTLEGROUND_RL);
            else if (tmpStr == "DS")
                allowedArenas.insert(BATTLEGROUND_DS);
            else if (tmpStr == "RV")
                allowedArenas.insert(BATTLEGROUND_RV);
            else
            {
                handler->PSendSysMessage("Invalid [arena] specified.");
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        ASSERT(!allowedArenas.empty());
        BattlegroundTypeId randomizedArenaBgTypeId = acore::Containers::SelectRandomContainerElement(allowedArenas);

        uint8 count = 0;
        if (i != tokens.end())
        {
            std::string mode = *(i++);
            if (mode == "1v1") count = 2;
            else if (mode == "2v2") count = 4;
            else if (mode == "3v3") count = 6;
            else if (mode == "5v5") count = 10;
        }

        if (!count)
        {
            handler->PSendSysMessage("Invalid bracket. Can be 1v1, 2v2, 3v3, 5v5");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (tokens.size() != uint16(count + 2))
        {
            handler->PSendSysMessage("Invalid number of nicknames for this bracket.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint8 hcnt = count / 2;
        uint8 error = 0;
        std::string last_name;
        Player* plr = nullptr;
        Player* players[10] = {nullptr};
        uint8 cnt = 0;
        for (; i != tokens.end(); ++i)
        {
            last_name = std::string(*i);
            plr = ObjectAccessor::FindPlayerByName(last_name, false);
            if (!plr) { error = 1; break; }
            if (!plr->IsInWorld() || !plr->FindMap() || plr->IsBeingTeleported()) { error = 2; break; }
            if (plr->GetMap()->GetEntry()->Instanceable()) { error = 3; break; }
            if (plr->isUsingLfg()) { error = 4; break; }
            if (plr->InBattlegroundQueue()) { error = 5; break; }
            if (plr->IsInFlight()) { error = 10; break; }
            if (!plr->IsAlive()) { error = 11; break; }
            const Group* g = plr->GetGroup();
            if (hcnt > 1)
            {
                if (!g) { error = 6; break; }
                if (g->isRaidGroup() || g->isBGGroup() || g->isBFGroup() || g->isLFGGroup()) { error = 7; break; }
                if (g->GetMembersCount() != hcnt) { error = 8; break; }

                uint8 sti = (cnt < hcnt ? 0 : hcnt);
                if (sti != cnt)
                    if (players[sti]->GetGroup() != plr->GetGroup()) { error = 9; last_name += " and " + players[sti]->GetName(); break; }
            }
            else // 1v1
            {
                if (g) { error = 12; break; }
            }
            players[cnt++] = plr;
        }

        for (uint8 i = 0; i < cnt && !error; ++i)
            for (uint8 j = i + 1; j < cnt; ++j)
                if (players[i]->GetGUID() == players[j]->GetGUID())
                {
                    last_name = players[i]->GetName();
                    error = 13;
                    break;
                }

        switch (error)
        {
            case 1:
                handler->PSendSysMessage("Player %s not found.", last_name.c_str());
                break;
            case 2:
                handler->PSendSysMessage("Player %s is being teleported.", last_name.c_str());
                break;
            case 3:
                handler->PSendSysMessage("Player %s is in instance/battleground/arena.", last_name.c_str());
                break;
            case 4:
                handler->PSendSysMessage("Player %s is in LFG system.", last_name.c_str());
                break;
            case 5:
                handler->PSendSysMessage("Player %s is queued for battleground/arena.", last_name.c_str());
                break;
            case 6:
                handler->PSendSysMessage("Player %s is not in group.", last_name.c_str());
                break;
            case 7:
                handler->PSendSysMessage("Player %s is not in normal group.", last_name.c_str());
                break;
            case 8:
                handler->PSendSysMessage("Group of player %s has invalid member count.", last_name.c_str());
                break;
            case 9:
                handler->PSendSysMessage("Players %s are not in the same group.", last_name.c_str());
                break;
            case 10:
                handler->PSendSysMessage("Player %s is in flight.", last_name.c_str());
                break;
            case 11:
                handler->PSendSysMessage("Player %s is dead.", last_name.c_str());
                break;
            case 12:
                handler->PSendSysMessage("Player %s is in a group.", last_name.c_str());
                break;
            case 13:
                handler->PSendSysMessage("Player %s occurs more than once.", last_name.c_str());
                break;
        }

        if (error)
        {
            handler->SetSentErrorMessage(true);
            return false;
        }

        Battleground* bgt = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
        if (!bgt)
        {
            handler->PSendSysMessage("Couldn't create arena map!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        Battleground* bg = sBattlegroundMgr->CreateNewBattleground(randomizedArenaBgTypeId, 80, 80, ArenaType(hcnt >= 2 ? hcnt : 2), false);
        if (!bg)
        {
            handler->PSendSysMessage("Couldn't create arena map!");
            handler->SetSentErrorMessage(true);
            return false;
        }

        bg->StartBattleground();

        BattlegroundTypeId bgTypeId = bg->GetBgTypeID();

        TeamId teamId1 = Player::TeamIdForRace(players[0]->getRace());
        TeamId teamId2 = (teamId1 == TEAM_ALLIANCE ? TEAM_HORDE : TEAM_ALLIANCE);
        for (uint8 i = 0; i < cnt; ++i)
        {
            Player* player = players[i];

            TeamId teamId = (i < hcnt ? teamId1 : teamId2);
            player->SetEntryPoint();

            uint32 queueSlot = 0;
            WorldPacket data;
            sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_IN_PROGRESS, 0, bg->GetStartTime(), bg->GetArenaType(), teamId);
            player->GetSession()->SendPacket(&data);

            player->SetBattlegroundId(bg->GetInstanceID(), bgTypeId, queueSlot, true, false, teamId);
            sBattlegroundMgr->SendToBattleground(player, bg->GetInstanceID(), bgTypeId);
        }

        handler->PSendSysMessage("Success! Players are now being teleported to the arena.");
        return true;
    }

    static bool HandleDevCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            if (handler->GetSession()->GetPlayer()->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER))
                handler->GetSession()->SendNotification(LANG_DEV_ON);
            else
                handler->GetSession()->SendNotification(LANG_DEV_OFF);
            return true;
        }

        std::string argstr = (char*)args;

        if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER);
            handler->GetSession()->SendNotification(LANG_DEV_ON);
            return true;
        }

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_DEVELOPER);
            handler->GetSession()->SendNotification(LANG_DEV_OFF);
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleGPSCommand(ChatHandler* handler, char const* args)
    {
        WorldObject* object = nullptr;
        if (*args)
        {
            uint64 guid = handler->extractGuidFromLink((char*)args);
            if (guid)
                object = (WorldObject*)ObjectAccessor::GetObjectByTypeMask(*handler->GetSession()->GetPlayer(), guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);

            if (!object)
            {
                handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        else
        {
            object = handler->getSelectedUnit();

            if (!object)
            {
                handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        CellCoord cellCoord = acore::ComputeCellCoord(object->GetPositionX(), object->GetPositionY());
        Cell cell(cellCoord);

        uint32 zoneId, areaId;
        object->GetZoneAndAreaId(zoneId, areaId);

        MapEntry const* mapEntry = sMapStore.LookupEntry(object->GetMapId());
        AreaTableEntry const* zoneEntry = sAreaTableStore.LookupEntry(zoneId);
        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(areaId);

        float zoneX = object->GetPositionX();
        float zoneY = object->GetPositionY();

        Map2ZoneCoordinates(zoneX, zoneY, zoneId);

        Map const* map = object->GetMap();
        float groundZ = map->GetHeight(object->GetPhaseMask(), object->GetPositionX(), object->GetPositionY(), MAX_HEIGHT);
        float floorZ = map->GetHeight(object->GetPhaseMask(), object->GetPositionX(), object->GetPositionY(), object->GetPositionZ());

        GridCoord gridCoord = acore::ComputeGridCoord(object->GetPositionX(), object->GetPositionY());

        // 63? WHY?
        int gridX = 63 - gridCoord.x_coord;
        int gridY = 63 - gridCoord.y_coord;

        uint32 haveMap = Map::ExistMap(object->GetMapId(), gridX, gridY) ? 1 : 0;
        uint32 haveVMap = Map::ExistVMap(object->GetMapId(), gridX, gridY) ? 1 : 0;

        if (haveVMap)
        {
            if (map->IsOutdoors(object->GetPositionX(), object->GetPositionY(), object->GetPositionZ()))
                handler->PSendSysMessage("You are outdoors");
            else
                handler->PSendSysMessage("You are indoors");
        }
        else
            handler->PSendSysMessage("no VMAP available for area info");

        handler->PSendSysMessage(LANG_MAP_POSITION,
                                 object->GetMapId(), (mapEntry ? mapEntry->name[handler->GetSessionDbcLocale()] : "<unknown>"),
                                 zoneId, (zoneEntry ? zoneEntry->area_name[handler->GetSessionDbcLocale()] : "<unknown>"),
                                 areaId, (areaEntry ? areaEntry->area_name[handler->GetSessionDbcLocale()] : "<unknown>"),
                                 object->GetPhaseMask(),
                                 object->GetPositionX(), object->GetPositionY(), object->GetPositionZ(), object->GetOrientation(),
                                 cell.GridX(), cell.GridY(), cell.CellX(), cell.CellY(), object->GetInstanceId(),
                                 zoneX, zoneY, groundZ, floorZ, haveMap, haveVMap);

        LiquidData liquidStatus;
        ZLiquidStatus status = map->getLiquidStatus(object->GetPositionX(), object->GetPositionY(), object->GetPositionZ(), MAP_ALL_LIQUIDS, &liquidStatus);

        if (status)
            handler->PSendSysMessage(LANG_LIQUID_STATUS, liquidStatus.level, liquidStatus.depth_level, liquidStatus.entry, liquidStatus.type_flags, status);
        if (object->GetTransport())
            handler->PSendSysMessage("Transport offset: %.2f, %.2f, %.2f, %.2f", object->m_movementInfo.transport.pos.GetPositionX(), object->m_movementInfo.transport.pos.GetPositionY(), object->m_movementInfo.transport.pos.GetPositionZ(), object->m_movementInfo.transport.pos.GetOrientation());

        return true;
    }

    static bool HandleAuraCommand(ChatHandler* handler, char const* args)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // number or [name] Shift-click form |color|Hspell:spell_id|h[name]|h|r or Htalent form
        uint32 spellId = handler->extractSpellIdFromLink((char*)args);
        if (!spellId)
            return false;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (!spellInfo)
        {
            handler->PSendSysMessage(LANG_COMMAND_NOSPELLFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!SpellMgr::IsSpellValid(spellInfo))
        {
            handler->PSendSysMessage(LANG_COMMAND_SPELL_BROKEN, spellId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Aura::TryRefreshStackOrCreate(spellInfo, MAX_EFFECT_MASK, target, target);

        return true;
    }

    static bool HandleUnAuraCommand(ChatHandler* handler, char const* args)
    {
        Unit* target = handler->getSelectedUnit();
        if (!target)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string argstr = args;
        if (argstr == "all")
        {
            target->RemoveAllAuras();
            return true;
        }

        // number or [name] Shift-click form |color|Hspell:spell_id|h[name]|h|r or Htalent form
        uint32 spellId = handler->extractSpellIdFromLink((char*)args);
        if (!spellId)
            return false;

        target->RemoveAurasDueToSpell(spellId);

        return true;
    }
    // Teleport to Player
    static bool HandleAppearCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        Player* _player = handler->GetSession()->GetPlayer();
        if (target == _player || targetGuid == _player->GetGUID())
        {
            handler->SendSysMessage(LANG_CANT_TELEPORT_SELF);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (target)
        {
            // check online security
            if (handler->HasLowerSecurity(target, 0))
                return false;

            std::string chrNameLink = handler->playerLink(targetName);

            Map* map = target->GetMap();
            if (map->IsBattlegroundOrArena())
            {
                // only allow if gm mode is on
                if (!_player->IsGameMaster())
                {
                    handler->PSendSysMessage(LANG_CANNOT_GO_TO_BG_GM, chrNameLink.c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }

                if (!_player->GetMap()->IsBattlegroundOrArena())
                    _player->SetEntryPoint();

                _player->SetBattlegroundId(target->GetBattlegroundId(), target->GetBattlegroundTypeId(), PLAYER_MAX_BATTLEGROUND_QUEUES, false, false, TEAM_NEUTRAL);
            }
            else if (map->IsDungeon())
            {
                // we have to go to instance, and can go to player only if:
                //   1) we are in his group (either as leader or as member)
                //   2) we are not bound to any group and have GM mode on
                if (_player->GetGroup())
                {
                    // we are in group, we can go only if we are in the player group
                    if (_player->GetGroup() != target->GetGroup())
                    {
                        handler->PSendSysMessage(LANG_CANNOT_GO_TO_INST_PARTY, chrNameLink.c_str());
                        handler->SetSentErrorMessage(true);
                        return false;
                    }
                }
                else
                {
                    // we are not in group, let's verify our GM mode
                    if (!_player->IsGameMaster())
                    {
                        handler->PSendSysMessage(LANG_CANNOT_GO_TO_INST_GM, chrNameLink.c_str());
                        handler->SetSentErrorMessage(true);
                        return false;
                    }
                }

                // if the GM is bound to another instance, he will not be bound to another one
                InstancePlayerBind* bind = sInstanceSaveMgr->PlayerGetBoundInstance(_player->GetGUIDLow(), target->GetMapId(), target->GetDifficulty(map->IsRaid()));
                if (!bind)
                    if (InstanceSave* save = sInstanceSaveMgr->GetInstanceSave(target->GetInstanceId()))
                        sInstanceSaveMgr->PlayerBindToInstance(_player->GetGUIDLow(), save, !save->CanReset(), _player);

                if (map->IsRaid())
                    _player->SetRaidDifficulty(target->GetRaidDifficulty());
                else
                    _player->SetDungeonDifficulty(target->GetDungeonDifficulty());
            }

            handler->PSendSysMessage(LANG_APPEARING_AT, chrNameLink.c_str());

            // stop flight if need
            if (_player->IsInFlight())
            {
                _player->GetMotionMaster()->MovementExpired();
                _player->CleanupAfterTaxiFlight();
            }
            // save only in non-flight case
            else
                _player->SaveRecallPosition();

            if (_player->TeleportTo(target->GetMapId(), target->GetPositionX(), target->GetPositionY(), target->GetPositionZ() + 0.25f, _player->GetOrientation(), TELE_TO_GM_MODE, target))
                _player->SetPhaseMask(target->GetPhaseMask() | 1, false);
        }
        else
        {
            // check offline security
            if (handler->HasLowerSecurity(nullptr, targetGuid))
                return false;

            std::string nameLink = handler->playerLink(targetName);

            handler->PSendSysMessage(LANG_APPEARING_AT, nameLink.c_str());

            // to point where player stay (if loaded)
            float x, y, z, o;
            uint32 map;
            bool in_flight;
            if (!Player::LoadPositionFromDB(map, x, y, z, o, in_flight, targetGuid))
                return false;

            // stop flight if need
            if (_player->IsInFlight())
            {
                _player->GetMotionMaster()->MovementExpired();
                _player->CleanupAfterTaxiFlight();
            }
            // save only in non-flight case
            else
                _player->SaveRecallPosition();

            _player->TeleportTo(map, x, y, z, _player->GetOrientation());
        }

        return true;
    }
    // Summon Player
    static bool HandleSummonCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        Player* _player = handler->GetSession()->GetPlayer();
        if (target == _player || targetGuid == _player->GetGUID())
        {
            handler->PSendSysMessage(LANG_CANT_TELEPORT_SELF);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (target)
        {
            std::string nameLink = handler->playerLink(targetName);
            // check online security
            if (handler->HasLowerSecurity(target, 0))
                return false;

            if (target->IsBeingTeleported())
            {
                handler->PSendSysMessage(LANG_IS_TELEPORTED, nameLink.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }

            Map* map = handler->GetSession()->GetPlayer()->GetMap();

            if (map->IsBattlegroundOrArena())
            {
                handler->PSendSysMessage("Can't summon to a battleground!");
                handler->SetSentErrorMessage(true);
                return false;
            }
            else if (map->IsDungeon())
            {
                // Allow GM to summon players or only other GM accounts inside instances.
                if (!sWorld->getBoolConfig(CONFIG_INSTANCE_GMSUMMON_PLAYER))
                {
                    // pussywizard: prevent unbinding normal player's perm bind by just summoning him >_>
                    if (!target->GetSession()->GetSecurity())
                    {
                        handler->PSendSysMessage("Only GMs can be summoned to an instance!");
                        handler->SetSentErrorMessage(true);
                        return false;
                    }
                }

                Map* destMap = target->GetMap();

                if (destMap->Instanceable() && destMap->GetInstanceId() != map->GetInstanceId())
                    sInstanceSaveMgr->PlayerUnbindInstance(target->GetGUIDLow(), map->GetInstanceId(), target->GetDungeonDifficulty(), true, target);

                // we are in an instance, and can only summon players in our group with us as leader
                if (!handler->GetSession()->GetPlayer()->GetGroup() || !target->GetGroup() ||
                        (target->GetGroup()->GetLeaderGUID() != handler->GetSession()->GetPlayer()->GetGUID()) ||
                        (handler->GetSession()->GetPlayer()->GetGroup()->GetLeaderGUID() != handler->GetSession()->GetPlayer()->GetGUID()))
                    // the last check is a bit excessive, but let it be, just in case
                {
                    handler->PSendSysMessage(LANG_CANNOT_SUMMON_TO_INST, nameLink.c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }
            }

            handler->PSendSysMessage(LANG_SUMMONING, nameLink.c_str(), "");
            if (handler->needReportToTarget(target))
                ChatHandler(target->GetSession()).PSendSysMessage(LANG_SUMMONED_BY, handler->playerLink(_player->GetName()).c_str());

            // stop flight if need
            if (target->IsInFlight())
            {
                target->GetMotionMaster()->MovementExpired();
                target->CleanupAfterTaxiFlight();
            }
            // save only in non-flight case
            else
                target->SaveRecallPosition();

            // before GM
            float x, y, z;
            handler->GetSession()->GetPlayer()->GetClosePoint(x, y, z, target->GetObjectSize());
            if (target->TeleportTo(handler->GetSession()->GetPlayer()->GetMapId(), x, y, z, target->GetOrientation(), 0, handler->GetSession()->GetPlayer()))
                target->SetPhaseMask(handler->GetSession()->GetPlayer()->GetPhaseMask(), false);
        }
        else
        {
            // check offline security
            if (handler->HasLowerSecurity(nullptr, targetGuid))
                return false;

            std::string nameLink = handler->playerLink(targetName);

            handler->PSendSysMessage(LANG_SUMMONING, nameLink.c_str(), handler->GetAcoreString(LANG_OFFLINE));

            // in point where GM stay
            Player::SavePositionInDB(handler->GetSession()->GetPlayer()->GetMapId(),
                                     handler->GetSession()->GetPlayer()->GetPositionX(),
                                     handler->GetSession()->GetPlayer()->GetPositionY(),
                                     handler->GetSession()->GetPlayer()->GetPositionZ(),
                                     handler->GetSession()->GetPlayer()->GetOrientation(),
                                     handler->GetSession()->GetPlayer()->GetZoneId(),
                                     targetGuid);
        }

        return true;
    }
    // Summon group of player
    static bool HandleGroupSummonCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        Group* group = target->GetGroup();

        std::string nameLink = handler->GetNameLink(target);

        if (!group)
        {
            handler->PSendSysMessage(LANG_NOT_IN_GROUP, nameLink.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        Map* gmMap = handler->GetSession()->GetPlayer()->GetMap();
        bool toInstance = gmMap->Instanceable();

        // we are in instance, and can summon only player in our group with us as lead
        if (toInstance && (
                    !handler->GetSession()->GetPlayer()->GetGroup() || (group->GetLeaderGUID() != handler->GetSession()->GetPlayer()->GetGUID()) ||
                    (handler->GetSession()->GetPlayer()->GetGroup()->GetLeaderGUID() != handler->GetSession()->GetPlayer()->GetGUID())))
            // the last check is a bit excessive, but let it be, just in case
        {
            handler->SendSysMessage(LANG_CANNOT_SUMMON_TO_INST);
            handler->SetSentErrorMessage(true);
            return false;
        }

        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* player = itr->GetSource();

            if (!player || player == handler->GetSession()->GetPlayer() || !player->GetSession())
                continue;

            // check online security
            if (handler->HasLowerSecurity(player, 0))
                return false;

            std::string plNameLink = handler->GetNameLink(player);

            if (player->IsBeingTeleported() == true)
            {
                handler->PSendSysMessage(LANG_IS_TELEPORTED, plNameLink.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }

            if (toInstance)
            {
                Map* playerMap = player->GetMap();

                if (playerMap->Instanceable() && playerMap->GetInstanceId() != gmMap->GetInstanceId())
                {
                    // cannot summon from instance to instance
                    handler->PSendSysMessage(LANG_CANNOT_SUMMON_TO_INST, plNameLink.c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }
            }

            handler->PSendSysMessage(LANG_SUMMONING, plNameLink.c_str(), "");
            if (handler->needReportToTarget(player))
                ChatHandler(player->GetSession()).PSendSysMessage(LANG_SUMMONED_BY, handler->GetNameLink().c_str());

            // stop flight if need
            if (player->IsInFlight())
            {
                player->GetMotionMaster()->MovementExpired();
                player->CleanupAfterTaxiFlight();
            }
            // save only in non-flight case
            else
                player->SaveRecallPosition();

            // before GM
            float x, y, z;
            handler->GetSession()->GetPlayer()->GetClosePoint(x, y, z, player->GetObjectSize());
            player->TeleportTo(handler->GetSession()->GetPlayer()->GetMapId(), x, y, z, player->GetOrientation(), 0, handler->GetSession()->GetPlayer());
        }

        return true;
    }

    static bool HandleCommandsCommand(ChatHandler* handler, char const* /*args*/)
    {
        handler->ShowHelpForCommand(handler->getCommandTable(), "");
        return true;
    }

    static bool HandleDieCommand(ChatHandler* handler, char const* /*args*/)
    {
        Unit* target = handler->getSelectedUnit();

        if (!target || !handler->GetSession()->GetPlayer()->GetTarget())
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (target->GetTypeId() == TYPEID_PLAYER)
        {
            if (handler->HasLowerSecurity(target->ToPlayer(), 0, false))
                return false;
        }

        if (target->IsAlive())
        {
            if (sWorld->getBoolConfig(CONFIG_DIE_COMMAND_MODE))
            {
                if (target->GetTypeId() == TYPEID_UNIT && handler->GetSession()->GetSecurity() == SEC_CONSOLE) // pussywizard
                    target->ToCreature()->LowerPlayerDamageReq(target->GetMaxHealth());
                Unit::Kill(handler->GetSession()->GetPlayer(), target);
            }
            else
                Unit::DealDamage(handler->GetSession()->GetPlayer(), target, target->GetHealth(), nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false, true);
        }

        return true;
    }

    static bool HandleReviveCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid))
            return false;

        if (target)
        {
            target->ResurrectPlayer(!AccountMgr::IsPlayerAccount(target->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
            target->SpawnCorpseBones();
            target->SaveToDB(false, false);
        }
        else
            // will resurrected at login without corpse
            sObjectAccessor->ConvertCorpseForPlayer(targetGuid);

        return true;
    }

    static bool HandleDismountCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        // If player is not mounted, so go out :)
        if (!player->IsMounted())
        {
            handler->SendSysMessage(LANG_CHAR_NON_MOUNTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (player->IsInFlight())
        {
            handler->SendSysMessage(LANG_YOU_IN_FLIGHT);
            handler->SetSentErrorMessage(true);
            return false;
        }

        player->Dismount();
        player->RemoveAurasByType(SPELL_AURA_MOUNTED);
        return true;
    }

    static bool HandleGUIDCommand(ChatHandler* handler, char const* /*args*/)
    {
        uint64 guid = handler->GetSession()->GetPlayer()->GetTarget();

        if (guid == 0)
        {
            handler->SendSysMessage(LANG_NO_SELECTION);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_OBJECT_GUID, GUID_LOPART(guid), GUID_HIPART(guid));
        return true;
    }

    static bool HandleHelpCommand(ChatHandler* handler, char const* args)
    {
        char const* cmd = strtok((char*)args, " ");
        if (!cmd)
        {
            handler->ShowHelpForCommand(handler->getCommandTable(), "help");
            handler->ShowHelpForCommand(handler->getCommandTable(), "");
        }
        else
        {
            if (!handler->ShowHelpForCommand(handler->getCommandTable(), cmd))
                handler->SendSysMessage(LANG_NO_HELP_CMD);
        }

        return true;
    }
    // move item to other slot
    static bool HandleItemMoveCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char const* param1 = strtok((char*)args, " ");
        if (!param1)
            return false;

        char const* param2 = strtok(nullptr, " ");
        if (!param2)
            return false;

        uint8 srcSlot = uint8(atoi(param1));
        uint8 dstSlot = uint8(atoi(param2));

        if (srcSlot == dstSlot)
            return true;

        if (!handler->GetSession()->GetPlayer()->IsValidPos(INVENTORY_SLOT_BAG_0, srcSlot, true))
            return false;

        if (!handler->GetSession()->GetPlayer()->IsValidPos(INVENTORY_SLOT_BAG_0, dstSlot, false))
            return false;

        uint16 src = ((INVENTORY_SLOT_BAG_0 << 8) | srcSlot);
        uint16 dst = ((INVENTORY_SLOT_BAG_0 << 8) | dstSlot);

        handler->GetSession()->GetPlayer()->SwapItem(src, dst);

        return true;
    }

    static bool HandleCooldownCommand(ChatHandler* handler, char const* args)
    {
        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string nameLink = handler->GetNameLink(target);

        if (!*args)
        {
            target->RemoveAllSpellCooldown();
            handler->PSendSysMessage(LANG_REMOVEALL_COOLDOWN, nameLink.c_str());
        }
        else
        {
            // number or [name] Shift-click form |color|Hspell:spell_id|h[name]|h|r or Htalent form
            uint32 spellIid = handler->extractSpellIdFromLink((char*)args);
            if (!spellIid)
                return false;

            if (!sSpellMgr->GetSpellInfo(spellIid))
            {
                handler->PSendSysMessage(LANG_UNKNOWN_SPELL, target == handler->GetSession()->GetPlayer() ? handler->GetAcoreString(LANG_YOU) : nameLink.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }

            target->RemoveSpellCooldown(spellIid, true);
            handler->PSendSysMessage(LANG_REMOVE_COOLDOWN, spellIid, target == handler->GetSession()->GetPlayer() ? handler->GetAcoreString(LANG_YOU) : nameLink.c_str());
        }
        return true;
    }

    static bool HandleGetDistanceCommand(ChatHandler* handler, char const* args)
    {
        WorldObject* obj = nullptr;

        if (*args)
        {
            uint64 guid = handler->extractGuidFromLink((char*)args);
            if (guid)
                obj = (WorldObject*)ObjectAccessor::GetObjectByTypeMask(*handler->GetSession()->GetPlayer(), guid, TYPEMASK_UNIT | TYPEMASK_GAMEOBJECT);

            if (!obj)
            {
                handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        else
        {
            obj = handler->getSelectedUnit();

            if (!obj)
            {
                handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        handler->PSendSysMessage(LANG_DISTANCE, handler->GetSession()->GetPlayer()->GetDistance(obj), handler->GetSession()->GetPlayer()->GetDistance2d(obj), handler->GetSession()->GetPlayer()->GetExactDist(obj), handler->GetSession()->GetPlayer()->GetExactDist2d(obj));
        return true;
    }
    // Teleport player to last position
    static bool HandleRecallCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        if (target->IsBeingTeleported())
        {
            handler->PSendSysMessage(LANG_IS_TELEPORTED, handler->GetNameLink(target).c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (target->IsInFlight())
        {
            target->GetMotionMaster()->MovementExpired();
            target->CleanupAfterTaxiFlight();
        }

        target->TeleportTo(target->m_recallMap, target->m_recallX, target->m_recallY, target->m_recallZ, target->m_recallO);
        return true;
    }

    static bool HandleSaveCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        // save GM account without delay and output message
        if (handler->GetSession()->GetSecurity() >= SEC_GAMEMASTER)
        {
            if (Player* target = handler->getSelectedPlayer())
            {
                target->SaveToDB(true, false);
            }
            else
            {
                player->SaveToDB(true, false);
            }
            handler->SendSysMessage(LANG_PLAYER_SAVED);
            return true;
        }

        // save if the player has last been saved over 20 seconds ago
        uint32 saveInterval = sWorld->getIntConfig(CONFIG_INTERVAL_SAVE);
        if (saveInterval == 0 || (saveInterval > 20 * IN_MILLISECONDS && player->GetSaveTimer() <= saveInterval - 20 * IN_MILLISECONDS))
        {
            player->SaveToDB(true, false);
        }

        return true;
    }

    // Save all players in the world
    static bool HandleSaveAllCommand(ChatHandler* handler, char const* /*args*/)
    {
        sObjectAccessor->SaveAllPlayers();
        handler->SendSysMessage(LANG_PLAYERS_SAVED);
        return true;
    }

    // kick player
    static bool HandleKickPlayerCommand(ChatHandler* handler, char const* args)
    {
        Player* target = nullptr;
        std::string playerName;
        if (!handler->extractPlayerTarget((char*)args, &target, nullptr, &playerName))
            return false;

        if (handler->GetSession() && target == handler->GetSession()->GetPlayer())
        {
            handler->SendSysMessage(LANG_COMMAND_KICKSELF);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        std::string kickReasonStr = handler->GetAcoreString(LANG_NO_REASON);
        if (*args != '\0')
        {
            char const* kickReason = strtok(nullptr, "\r");
            if (kickReason != nullptr)
                kickReasonStr = kickReason;
        }

        if (sWorld->getBoolConfig(CONFIG_SHOW_KICK_IN_WORLD))
            sWorld->SendWorldText(LANG_COMMAND_KICKMESSAGE_WORLD, (handler->GetSession() ? handler->GetSession()->GetPlayerName().c_str() : "Server"), playerName.c_str(), kickReasonStr.c_str());
        else
            handler->PSendSysMessage(LANG_COMMAND_KICKMESSAGE, playerName.c_str());

        target->GetSession()->KickPlayer("HandleKickPlayerCommand");

        return true;
    }

    static bool HandleUnstuckCommand(ChatHandler* handler, char const* args)
    {
        //No args required for players
        if (handler->GetSession() && AccountMgr::IsPlayerAccount(handler->GetSession()->GetSecurity()))
        {
            // 7355: "Stuck"
            if (Player* player = handler->GetSession()->GetPlayer())
                player->CastSpell(player, 7355, false);
            return true;
        }

        if (!*args)
            return false;

        char* player_str = strtok((char*)args, " ");
        if (!player_str)
            return false;

        std::string location_str = "inn";
        if (char const* loc = strtok(nullptr, " "))
            location_str = loc;

        Player* player = nullptr;
        if (!handler->extractPlayerTarget(player_str, &player))
            return false;

        if (player->IsInFlight() || player->IsInCombat())
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(7355);
            if (!spellInfo)
                return false;

            if (Player* caster = handler->GetSession()->GetPlayer())
                Spell::SendCastResult(caster, spellInfo, 0, SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW);

            return false;
        }

        if (location_str == "inn")
        {
            player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->GetOrientation());
            return true;
        }

        if (location_str == "graveyard")
        {
            player->RepopAtGraveyard();
            return true;
        }

        if (location_str == "startzone")
        {
            player->TeleportTo(player->GetStartPosition());
            return true;
        }

        //Not a supported argument
        return false;

    }

    static bool HandleLinkGraveCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* px = strtok((char*)args, " ");
        if (!px)
            return false;

        uint32 graveyardId = uint32(atoi(px));

        TeamId teamId;

        char* px2 = strtok(nullptr, " ");

        if (!px2)
            teamId = TEAM_NEUTRAL;
        else if (strncmp(px2, "horde", 6) == 0)
            teamId = TEAM_HORDE;
        else if (strncmp(px2, "alliance", 9) == 0)
            teamId = TEAM_ALLIANCE;
        else
            return false;

        GraveyardStruct const* graveyard = sGraveyard->GetGraveyard(graveyardId);

        if (!graveyard)
        {
            handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDNOEXIST, graveyardId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        uint32 zoneId = player->GetZoneId();

        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(zoneId);
        if (!areaEntry || areaEntry->zone != 0)
        {
            handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDWRONGZONE, graveyardId, zoneId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (sGraveyard->AddGraveyardLink(graveyardId, zoneId, teamId))
            handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDLINKED, graveyardId, zoneId);
        else
            handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDALRLINKED, graveyardId, zoneId);

        return true;
    }

    static bool HandleNearGraveCommand(ChatHandler* handler, char const* args)
    {
        TeamId teamId;

        size_t argStr = strlen(args);

        if (!*args)
            teamId = TEAM_NEUTRAL;
        else if (strncmp((char*)args, "horde", argStr) == 0)
            teamId = TEAM_HORDE;
        else if (strncmp((char*)args, "alliance", argStr) == 0)
            teamId = TEAM_ALLIANCE;
        else
            return false;

        Player* player = handler->GetSession()->GetPlayer();
        uint32 zone_id = player->GetZoneId();

        GraveyardStruct const* graveyard = sGraveyard->GetClosestGraveyard(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), player->GetMapId(), teamId);

        if (graveyard)
        {
            uint32 graveyardId = graveyard->ID;

            GraveyardData const* data = sGraveyard->FindGraveyardData(graveyardId, zone_id);
            if (!data)
            {
                handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDERROR, graveyardId);
                handler->SetSentErrorMessage(true);
                return false;
            }

            std::string team_name = handler->GetAcoreString(LANG_COMMAND_GRAVEYARD_NOTEAM);

            if (data->teamId == TEAM_NEUTRAL)
                team_name = handler->GetAcoreString(LANG_COMMAND_GRAVEYARD_ANY);
            else if (data->teamId == TEAM_HORDE)
                team_name = handler->GetAcoreString(LANG_COMMAND_GRAVEYARD_HORDE);
            else if (data->teamId == TEAM_ALLIANCE)
                team_name = handler->GetAcoreString(LANG_COMMAND_GRAVEYARD_ALLIANCE);

            handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDNEAREST, graveyardId, team_name.c_str(), zone_id);
        }
        else
        {
            std::string team_name;

            if (teamId == TEAM_NEUTRAL)
                team_name = handler->GetAcoreString(LANG_COMMAND_GRAVEYARD_ANY);
            else if (teamId == TEAM_HORDE)
                team_name = handler->GetAcoreString(LANG_COMMAND_GRAVEYARD_HORDE);
            else if (teamId == TEAM_ALLIANCE)
                team_name = handler->GetAcoreString(LANG_COMMAND_GRAVEYARD_ALLIANCE);

            //if (team == ~uint32(0))
            //    handler->PSendSysMessage(LANG_COMMAND_ZONENOGRAVEYARDS, zone_id);
            //else
            handler->PSendSysMessage(LANG_COMMAND_ZONENOGRAFACTION, zone_id, team_name.c_str());
        }

        return true;
    }

    static bool HandleShowAreaCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* playerTarget = handler->getSelectedPlayer();
        if (!playerTarget)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AreaTableEntry const* area = sAreaTableStore.LookupEntry(atoi(args));
        if (!area)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        int32 offset = area->exploreFlag / 32;
        if (offset >= PLAYER_EXPLORED_ZONES_SIZE)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 val = uint32((1 << (area->exploreFlag % 32)));
        uint32 currFields = playerTarget->GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset);
        playerTarget->SetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset, uint32((currFields | val)));

        handler->SendSysMessage(LANG_EXPLORE_AREA);
        return true;
    }

    static bool HandleHideAreaCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* playerTarget = handler->getSelectedPlayer();
        if (!playerTarget)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        AreaTableEntry const* area = sAreaTableStore.LookupEntry(atoi(args));
        if (!area)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        int32 offset = area->exploreFlag / 32;
        if (offset >= PLAYER_EXPLORED_ZONES_SIZE)
        {
            handler->SendSysMessage(LANG_BAD_VALUE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 val = uint32((1 << (area->exploreFlag % 32)));
        uint32 currFields = playerTarget->GetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset);
        playerTarget->SetUInt32Value(PLAYER_EXPLORED_ZONES_1 + offset, uint32((currFields ^ val)));

        handler->SendSysMessage(LANG_UNEXPLORE_AREA);
        return true;
    }

    static bool HandleAddItemCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 itemId = 0;

        if (args[0] == '[')                                        // [name] manual form
        {
            char const* itemNameStr = strtok((char*)args, "]");

            if (itemNameStr && itemNameStr[0])
            {
                std::string itemName = itemNameStr + 1;
                WorldDatabase.EscapeString(itemName);

                PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_ITEM_TEMPLATE_BY_NAME);
                stmt->setString(0, itemName);
                PreparedQueryResult result = WorldDatabase.Query(stmt);

                if (!result)
                {
                    handler->PSendSysMessage(LANG_COMMAND_COULDNOTFIND, itemNameStr + 1);
                    handler->SetSentErrorMessage(true);
                    return false;
                }
                itemId = result->Fetch()->GetUInt32();
            }
            else
                return false;
        }
        else                                                    // item_id or [name] Shift-click form |color|Hitem:item_id:0:0:0|h[name]|h|r
        {
            char const* id = handler->extractKeyFromLink((char*)args, "Hitem");
            if (!id)
                return false;
            itemId = uint32(atol(id));
        }

        char const* ccount = strtok(nullptr, " ");

        int32 count = 1;

        if (ccount)
            count = strtol(ccount, nullptr, 10);

        if (count == 0)
            count = 1;

        Player* player = handler->GetSession()->GetPlayer();
        Player* playerTarget = handler->getSelectedPlayer();
        if (!playerTarget)
            playerTarget = player;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail(handler->GetAcoreString(LANG_ADDITEM), itemId, count);
#endif

        ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);
        if (!itemTemplate)
        {
            handler->PSendSysMessage(LANG_COMMAND_ITEMIDINVALID, itemId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Subtract
        if (count < 0)
        {
            if (!playerTarget->HasItemCount(itemId, 0))
            {
                // output that player don't have any items to destroy
                handler->PSendSysMessage(LANG_REMOVEITEM_FAILURE, handler->GetNameLink(playerTarget).c_str(), itemId);
            }
            else if (!playerTarget->HasItemCount(itemId, -count))
            {
                // output that player don't have as many items that you want to destroy
                handler->PSendSysMessage(LANG_REMOVEITEM_ERROR, handler->GetNameLink(playerTarget).c_str(), itemId);
            }
            else
            {
                // output successful amount of destroyed items
                playerTarget->DestroyItemCount(itemId, -count, true, false);
                handler->PSendSysMessage(LANG_REMOVEITEM, itemId, -count, handler->GetNameLink(playerTarget).c_str());
            }

            return true;
        }

        /* [AC] Sunwell hack
        if (handler->GetSession()->GetSecurity() < SEC_ADMINISTRATOR)
               {
                   handler->PSendSysMessage("You may only remove items. Adding items is available for higher GMLevel.");
                   return false;
               }
               */

        // Adding items
        uint32 noSpaceForCount = 0;

        // check space and find places
        ItemPosCountVec dest;
        InventoryResult msg = playerTarget->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, count, &noSpaceForCount);
        if (msg != EQUIP_ERR_OK)                               // convert to possible store amount
            count -= noSpaceForCount;

        if (count == 0 || dest.empty())                         // can't add any
        {
            handler->PSendSysMessage(LANG_ITEM_CANNOT_CREATE, itemId, noSpaceForCount);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Item* item = playerTarget->StoreNewItem(dest, itemId, true);

        // remove binding (let GM give it to another player later)
        if (player == playerTarget)
            for (ItemPosCountVec::const_iterator itr = dest.begin(); itr != dest.end(); ++itr)
                if (Item* item1 = player->GetItemByPos(itr->pos))
                    item1->SetBinding(false);

        if (count > 0 && item)
        {
            player->SendNewItem(item, count, false, true);
            if (player != playerTarget)
                playerTarget->SendNewItem(item, count, true, false);
        }

        if (noSpaceForCount > 0)
            handler->PSendSysMessage(LANG_ITEM_CANNOT_CREATE, itemId, noSpaceForCount);

        return true;
    }

    static bool HandleAddItemSetCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char const* id = handler->extractKeyFromLink((char*)args, "Hitemset"); // number or [name] Shift-click form |color|Hitemset:itemset_id|h[name]|h|r
        if (!id)
            return false;

        uint32 itemSetId = atol(id);

        // prevent generation all items with itemset field value '0'
        if (itemSetId == 0)
        {
            handler->PSendSysMessage(LANG_NO_ITEMS_FROM_ITEMSET_FOUND, itemSetId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();
        Player* playerTarget = handler->getSelectedPlayer();
        if (!playerTarget)
            playerTarget = player;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDetail(handler->GetAcoreString(LANG_ADDITEMSET), itemSetId);
#endif

        bool found = false;
        ItemTemplateContainer const* its = sObjectMgr->GetItemTemplateStore();
        for (ItemTemplateContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
        {
            if (itr->second.ItemSet == itemSetId)
            {
                found = true;
                ItemPosCountVec dest;
                InventoryResult msg = playerTarget->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itr->second.ItemId, 1);
                if (msg == EQUIP_ERR_OK)
                {
                    Item* item = playerTarget->StoreNewItem(dest, itr->second.ItemId, true);

                    // remove binding (let GM give it to another player later)
                    if (player == playerTarget)
                        item->SetBinding(false);

                    player->SendNewItem(item, 1, false, true);
                    if (player != playerTarget)
                        playerTarget->SendNewItem(item, 1, true, false);
                }
                else
                {
                    player->SendEquipError(msg, nullptr, nullptr, itr->second.ItemId);
                    handler->PSendSysMessage(LANG_ITEM_CANNOT_CREATE, itr->second.ItemId, 1);
                }
            }
        }

        if (!found)
        {
            handler->PSendSysMessage(LANG_NO_ITEMS_FROM_ITEMSET_FOUND, itemSetId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        return true;
    }

    static bool HandleChangeWeather(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        // Weather is OFF
        if (!sWorld->getBoolConfig(CONFIG_WEATHER))
        {
            handler->SendSysMessage(LANG_WEATHER_DISABLED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // *Change the weather of a cell
        char const* px = strtok((char*)args, " ");
        char const* py = strtok(nullptr, " ");

        if (!px || !py)
            return false;

        uint32 type = uint32(atoi(px));                         //0 to 3, 0: fine, 1: rain, 2: snow, 3: sand
        float grade = float(atof(py));                          //0 to 1, sending -1 is instand good weather

        Player* player = handler->GetSession()->GetPlayer();
        uint32 zoneid = player->GetZoneId();

        Weather* weather = WeatherMgr::FindWeather(zoneid);

        if (!weather)
            weather = WeatherMgr::AddWeather(zoneid);
        if (!weather)
        {
            handler->SendSysMessage(LANG_NO_WEATHER);
            handler->SetSentErrorMessage(true);
            return false;
        }

        weather->SetWeather(WeatherType(type), grade);

        return true;
    }


    static bool HandleMaxSkillCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* SelectedPlayer = handler->getSelectedPlayer();
        if (!SelectedPlayer)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // each skills that have max skill value dependent from level seted to current level max skill value
        SelectedPlayer->UpdateSkillsToMaxSkillsForLevel();
        return true;
    }

    static bool HandleSetSkillCommand(ChatHandler* handler, char const* args)
    {
        // number or [name] Shift-click form |color|Hskill:skill_id|h[name]|h|r
        char const* skillStr = handler->extractKeyFromLink((char*)args, "Hskill");
        if (!skillStr)
            return false;

        char const* levelStr = strtok(nullptr, " ");
        if (!levelStr)
            return false;

        char const* maxPureSkill = strtok(nullptr, " ");

        int32 skill = atoi(skillStr);
        if (skill <= 0)
        {
            handler->PSendSysMessage(LANG_INVALID_SKILL_ID, skill);
            handler->SetSentErrorMessage(true);
            return false;
        }

        int32 level = uint32(atol(levelStr));

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            handler->SetSentErrorMessage(true);
            return false;
        }

        SkillLineEntry const* skillLine = sSkillLineStore.LookupEntry(skill);
        if (!skillLine)
        {
            handler->PSendSysMessage(LANG_INVALID_SKILL_ID, skill);
            handler->SetSentErrorMessage(true);
            return false;
        }

        bool targetHasSkill = target->GetSkillValue(skill);

        // If our target does not yet have the skill they are trying to add to them, the chosen level also becomes
        // the max level of the new profession.
        uint16 max = maxPureSkill ? atol (maxPureSkill) : targetHasSkill ? target->GetPureMaxSkillValue(skill) : uint16(level);

        if (level <= 0 || level > max || max <= 0)
            return false;

        // If the player has the skill, we get the current skill step. If they don't have the skill, we
        // add the skill to the player's book with step 1 (which is the first rank, in most cases something
        // like 'Apprentice <skill>'.
        target->SetSkill(skill, targetHasSkill ? target->GetSkillStep(skill) : 1, level, max);
        handler->PSendSysMessage(LANG_SET_SKILL, skill, skillLine->name[handler->GetSessionDbcLocale()], handler->GetNameLink(target).c_str(), level, max);
        return true;
    }

    // show info of player
    static bool HandlePInfoCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        PreparedStatement* stmt = nullptr;

        uint32 parseGUID = MAKE_NEW_GUID(atol((char*)args), 0, HIGHGUID_PLAYER);

        if (sObjectMgr->GetPlayerNameByGUID(parseGUID, targetName))
        {
            target = ObjectAccessor::FindPlayerInOrOutOfWorld(MAKE_NEW_GUID(parseGUID, 0, HIGHGUID_PLAYER));
            targetGuid = parseGUID;
        }
        else if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        // Account data print variables
        std::string userName          = handler->GetAcoreString(LANG_ERROR);
        uint32 lowguid                = GUID_LOPART(targetGuid);
        uint32 accId                  = 0;
        std::string eMail             = handler->GetAcoreString(LANG_ERROR);
        std::string regMail           = handler->GetAcoreString(LANG_ERROR);
        uint32 security               = 0;
        std::string lastIp            = handler->GetAcoreString(LANG_ERROR);
        uint8 locked                  = 0;
        std::string lastLogin         = handler->GetAcoreString(LANG_ERROR);
        uint32 failedLogins           = 0;
        uint32 latency                = 0;
        std::string OS                = handler->GetAcoreString(LANG_UNKNOWN);

        // Mute data print variables
        int64 muteTime                = -1;
        std::string muteReason        = handler->GetAcoreString(LANG_NO_REASON);
        std::string muteBy            = handler->GetAcoreString(LANG_UNKNOWN);

        // Ban data print variables
        int64 banTime                 = -1;
        std::string banType           = handler->GetAcoreString(LANG_UNKNOWN);
        std::string banReason         = handler->GetAcoreString(LANG_NO_REASON);
        std::string bannedBy          = handler->GetAcoreString(LANG_UNKNOWN);

        // Character data print variables
        uint8 raceid, classid           = 0; //RACE_NONE, CLASS_NONE
        std::string raceStr, classStr   = handler->GetAcoreString(LANG_UNKNOWN);
        uint8 gender                    = 0;
        int8 locale                     = handler->GetSessionDbcLocale();
        uint32 totalPlayerTime          = 0;
        uint8 level                     = 0;
        std::string alive               = handler->GetAcoreString(LANG_ERROR);
        uint32 money                    = 0;
        uint32 xp                       = 0;
        uint32 xptotal                  = 0;

        // Position data print
        uint32 mapId;
        uint32 areaId;
        uint32 phase            = 0;
        char const* areaName    = nullptr;
        char const* zoneName    = nullptr;

        // Guild data print variables defined so that they exist, but are not necessarily used
        uint32 guildId           = 0;
        uint8 guildRankId        = 0;
        std::string guildName;
        std::string guildRank;
        std::string note;
        std::string officeNote;

        // get additional information from Player object
        if (target)
        {
            // check online security
            if (handler->HasLowerSecurity(target, 0))
                return false;

            accId             = target->GetSession()->GetAccountId();
            money             = target->GetMoney();
            totalPlayerTime   = target->GetTotalPlayedTime();
            level             = target->getLevel();
            latency           = target->GetSession()->GetLatency();
            raceid            = target->getRace();
            classid           = target->getClass();
            muteTime          = target->GetSession()->m_muteTime;
            mapId             = target->GetMapId();
            areaId            = target->GetAreaId();
            alive             = target->IsAlive() ? handler->GetAcoreString(LANG_YES) : handler->GetAcoreString(LANG_NO);
            gender            = target->getGender();
            phase             = target->GetPhaseMask();
        }
        // get additional information from DB
        else
        {
            // check offline security
            if (handler->HasLowerSecurity(nullptr, targetGuid))
                return false;

            // Query informations from the DB
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PINFO);
            stmt->setUInt32(0, GUID_LOPART(targetGuid));
            PreparedQueryResult charInfoResult = CharacterDatabase.Query(stmt);

            if (!charInfoResult)
                return false;

            Field* fields      = charInfoResult->Fetch();
            totalPlayerTime    = fields[0].GetUInt32();
            level              = fields[1].GetUInt8();
            money              = fields[2].GetUInt32();
            accId              = fields[3].GetUInt32();
            raceid             = fields[4].GetUInt8();
            classid            = fields[5].GetUInt8();
            mapId              = fields[6].GetUInt16();
            areaId             = fields[7].GetUInt16();
            gender             = fields[8].GetUInt8();
            uint32 health      = fields[9].GetUInt32();
            uint32 playerFlags = fields[10].GetUInt32();

            if (!health || playerFlags & PLAYER_FLAGS_GHOST)
                alive = handler->GetAcoreString(LANG_NO);
            else
                alive = handler->GetAcoreString(LANG_YES);
        }

        // Query the prepared statement for login data
        stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_PINFO);
        stmt->setInt32(0, int32(realmID));
        stmt->setUInt32(1, accId);
        PreparedQueryResult accInfoResult = LoginDatabase.Query(stmt);

        if (accInfoResult)
        {
            Field* fields = accInfoResult->Fetch();
            userName      = fields[0].GetString();
            security      = fields[1].GetUInt8();

            // Only fetch these fields if commander has sufficient rights)
            if (!handler->GetSession() || handler->GetSession()->GetSecurity() >= AccountTypes(security))
            {
                eMail     = fields[2].GetString();
                regMail   = fields[3].GetString();
                lastIp    = fields[4].GetString();
                lastLogin = fields[5].GetString();

                /** if (IpLocationRecord const* location = sIPLocation->GetLocationRecord(lastIp))
                {
                    lastIp.append(" (");
                    lastIp.append(location->CountryName);
                    lastIp.append(")");
                } **/

                uint32 ip = inet_addr(lastIp.c_str());
#if ACORE_ENDIAN == BIGENDIAN
                EndianConvertReverse(ip);
#endif
                stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_IP2NATION_COUNTRY);

                stmt->setUInt32(0, ip);

                PreparedQueryResult result2 = LoginDatabase.Query(stmt);

                if (result2)
                {
                    Field* fields2 = result2->Fetch();
                    lastIp.append(" (");
                    lastIp.append(fields2[0].GetString());
                    lastIp.append(")");
                }
            }
            else
            {
                eMail     = handler->GetAcoreString(LANG_UNAUTHORIZED);
                regMail   = handler->GetAcoreString(LANG_UNAUTHORIZED);
                lastIp    = handler->GetAcoreString(LANG_UNAUTHORIZED);
                lastLogin = handler->GetAcoreString(LANG_UNAUTHORIZED);
            }
            muteTime      = fields[6].GetUInt64();
            muteReason    = fields[7].GetString();
            muteBy        = fields[8].GetString();
            failedLogins  = fields[9].GetUInt32();
            locked        = fields[10].GetUInt8();
            OS            = fields[11].GetString();
        }

        // Creates a chat link to the character. Returns nameLink
        std::string nameLink = handler->playerLink(targetName);

        // Returns banType, banTime, bannedBy, banreason
        PreparedStatement* banQuery = LoginDatabase.GetPreparedStatement(LOGIN_SEL_PINFO_BANS);
        banQuery->setUInt32(0, accId);
        PreparedQueryResult accBannedResult = LoginDatabase.Query(banQuery);
        if (!accBannedResult)
        {
            banType = handler->GetAcoreString(LANG_CHARACTER);
            stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PINFO_BANS);
            stmt->setUInt32(0, GUID_LOPART(targetGuid));
            accBannedResult = CharacterDatabase.Query(stmt);
        }

        if (accBannedResult)
        {
            Field* fields = accBannedResult->Fetch();
            banTime       = int64(fields[1].GetUInt64() ? 0 : fields[0].GetUInt32());
            bannedBy      = fields[2].GetString();
            banReason     = fields[3].GetString();
        }

        // Can be used to query data from World database
        PreparedStatement* xpQuery = WorldDatabase.GetPreparedStatement(WORLD_SEL_REQ_XP);
        xpQuery->setUInt8(0, level);
        PreparedQueryResult xpResult = WorldDatabase.Query(xpQuery);

        if (xpResult)
        {
            Field* fields = xpResult->Fetch();
            xptotal       = fields[0].GetUInt32();
        }

        // Can be used to query data from Characters database
        PreparedStatement* charXpQuery = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PINFO_XP);
        charXpQuery->setUInt32(0, lowguid);
        PreparedQueryResult charXpResult = CharacterDatabase.Query(charXpQuery);

        if (charXpResult)
        {
            Field* fields = charXpResult->Fetch();
            xp            = fields[0].GetUInt32();
            uint32 gguid  = fields[1].GetUInt32();

            if (gguid != 0)
            {
                PreparedStatement* guildQuery = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GUILD_MEMBER_EXTENDED);
                guildQuery->setUInt32(0, lowguid);
                PreparedQueryResult guildInfoResult = CharacterDatabase.Query(guildQuery);
                if (guildInfoResult)
                {
                    Field* fields  = guildInfoResult->Fetch();
                    guildId        = fields[0].GetUInt32();
                    guildName      = fields[1].GetString();
                    guildRank      = fields[2].GetString();
                    note           = fields[3].GetString();
                    officeNote     = fields[4].GetString();
                }
            }
        }

        // Initiate output
        // Output I. LANG_PINFO_PLAYER
        handler->PSendSysMessage(LANG_PINFO_PLAYER, target ? "" : handler->GetAcoreString(LANG_OFFLINE), nameLink.c_str(), GUID_LOPART(targetGuid));

        // Output II. LANG_PINFO_GM_ACTIVE if character is gamemaster
        if (target && target->IsGameMaster())
            handler->PSendSysMessage(LANG_PINFO_GM_ACTIVE);

        // Output III. LANG_PINFO_BANNED if ban exists and is applied
        if (banTime >= 0)
            handler->PSendSysMessage(LANG_PINFO_BANNED, banType.c_str(), banReason.c_str(), banTime > 0 ? secsToTimeString(banTime - time(nullptr), true).c_str() : handler->GetAcoreString(LANG_PERMANENTLY), bannedBy.c_str());

        // Output IV. LANG_PINFO_MUTED if mute is applied
        if (muteTime > 0)
            handler->PSendSysMessage(LANG_PINFO_MUTED, muteReason.c_str(), secsToTimeString(muteTime - time(nullptr), true).c_str(), muteBy.c_str());

        // Output V. LANG_PINFO_ACC_ACCOUNT
        handler->PSendSysMessage(LANG_PINFO_ACC_ACCOUNT, userName.c_str(), accId, security);

        // Output VI. LANG_PINFO_ACC_LASTLOGIN
        handler->PSendSysMessage(LANG_PINFO_ACC_LASTLOGIN, lastLogin.c_str(), failedLogins);

        // Output VII. LANG_PINFO_ACC_OS
        handler->PSendSysMessage(LANG_PINFO_ACC_OS, OS.c_str(), latency);

        // Output VIII. LANG_PINFO_ACC_REGMAILS
        handler->PSendSysMessage(LANG_PINFO_ACC_REGMAILS, regMail.c_str(), eMail.c_str());

        // Output IX. LANG_PINFO_ACC_IP
        handler->PSendSysMessage(LANG_PINFO_ACC_IP, lastIp.c_str(), locked ? handler->GetAcoreString(LANG_YES) : handler->GetAcoreString(LANG_NO));

        // Output X. LANG_PINFO_CHR_LEVEL
        if (level != sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            handler->PSendSysMessage(LANG_PINFO_CHR_LEVEL_LOW, level, xp, xptotal, (xptotal - xp));
        else
            handler->PSendSysMessage(LANG_PINFO_CHR_LEVEL_HIGH, level);

        // Output XI. LANG_PINFO_CHR_RACE
        switch (raceid)
        {
            case RACE_HUMAN:
                raceStr = "Human";
                break;
            case RACE_ORC:
                raceStr = "Orc";
                break;
            case RACE_DWARF:
                raceStr = "Dwarf";
                break;
            case RACE_NIGHTELF:
                raceStr = "Night Elf";
                break;
            case RACE_UNDEAD_PLAYER:
                raceStr = "Undead";
                break;
            case RACE_TAUREN:
                raceStr = "Tauren";
                break;
            case RACE_GNOME:
                raceStr = "Gnome";
                break;
            case RACE_TROLL:
                raceStr = "Troll";
                break;
            case RACE_BLOODELF:
                raceStr = "Blood Elf";
                break;
            case RACE_DRAENEI:
                raceStr = "Draenei";
                break;
        }

        switch (classid)
        {
            case CLASS_WARRIOR:
                classStr = "Warrior";
                break;
            case CLASS_PALADIN:
                classStr = "Paladin";
                break;
            case CLASS_HUNTER:
                classStr = "Hunter";
                break;
            case CLASS_ROGUE:
                classStr = "Rogue";
                break;
            case CLASS_PRIEST:
                classStr = "Priest";
                break;
            case CLASS_DEATH_KNIGHT:
                classStr = "Death Knight";
                break;
            case CLASS_SHAMAN:
                classStr = "Shaman";
                break;
            case CLASS_MAGE:
                classStr = "Mage";
                break;
            case CLASS_WARLOCK:
                classStr = "Warlock";
                break;
            case CLASS_DRUID:
                classStr = "Druid";
                break;
        }


        handler->PSendSysMessage(LANG_PINFO_CHR_RACE, (gender == 0 ? handler->GetAcoreString(LANG_CHARACTER_GENDER_MALE) : handler->GetAcoreString(LANG_CHARACTER_GENDER_FEMALE)), raceStr.c_str(), classStr.c_str());

        // Output XII. LANG_PINFO_CHR_ALIVE
        handler->PSendSysMessage(LANG_PINFO_CHR_ALIVE, alive.c_str());

        // Output XIII. LANG_PINFO_CHR_PHASE if player is not in GM mode (GM is in every phase)
        if (target && !target->IsGameMaster())                            // IsInWorld() returns false on loadingscreen, so it's more
            handler->PSendSysMessage(LANG_PINFO_CHR_PHASE, phase);        // precise than just target (safer ?).
        // However, as we usually just require a target here, we use target instead.
        // Output XIV. LANG_PINFO_CHR_MONEY
        uint32 gold                   = money / GOLD;
        uint32 silv                   = (money % GOLD) / SILVER;
        uint32 copp                   = (money % GOLD) % SILVER;
        handler->PSendSysMessage(LANG_PINFO_CHR_MONEY, gold, silv, copp);

        // Position data
        MapEntry const* map = sMapStore.LookupEntry(mapId);
        AreaTableEntry const* area = sAreaTableStore.LookupEntry(areaId);
        if (area)
        {
            zoneName = area->area_name[locale];

            AreaTableEntry const* zone = sAreaTableStore.LookupEntry(area->zone);
            if (zone)
            {
                areaName = zoneName;
                zoneName = zone->area_name[locale];
            }
        }

        if (!zoneName)
            zoneName = handler->GetAcoreString(LANG_UNKNOWN);

        if (areaName)
            handler->PSendSysMessage(LANG_PINFO_CHR_MAP_WITH_AREA, map->name[locale], zoneName, areaName);
        else
            handler->PSendSysMessage(LANG_PINFO_CHR_MAP, map->name[locale], zoneName);

        // Output XVII. - XVIX. if they are not empty
        if (!guildName.empty())
        {
            handler->PSendSysMessage(LANG_PINFO_CHR_GUILD, guildName.c_str(), guildId);
            handler->PSendSysMessage(LANG_PINFO_CHR_GUILD_RANK, guildRank.c_str(), uint32(guildRankId));
            if (!note.empty())
                handler->PSendSysMessage(LANG_PINFO_CHR_GUILD_NOTE, note.c_str());
            if (!officeNote.empty())
                handler->PSendSysMessage(LANG_PINFO_CHR_GUILD_ONOTE, officeNote.c_str());
        }

        // Output XX. LANG_PINFO_CHR_PLAYEDTIME
        handler->PSendSysMessage(LANG_PINFO_CHR_PLAYEDTIME, (secsToTimeString(totalPlayerTime, true)).c_str());

        // Mail Data - an own query, because it may or may not be useful.
        // SQL: "SELECT SUM(CASE WHEN (checked & 1) THEN 1 ELSE 0 END) AS 'readmail', COUNT(*) AS 'totalmail' FROM mail WHERE `receiver` = ?"
        PreparedStatement* mailQuery = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PINFO_MAILS);
        mailQuery->setUInt32(0, GUID_LOPART(targetGuid));
        PreparedQueryResult mailInfoResult = CharacterDatabase.Query(mailQuery);
        if (mailInfoResult)
        {
            Field* fields         = mailInfoResult->Fetch();
            uint32 readmail       = uint32(fields[0].GetDouble());
            uint32 totalmail      = uint32(fields[1].GetUInt64());

            // Output XXI. LANG_INFO_CHR_MAILS if at least one mail is given
            if (totalmail >= 1)
                handler->PSendSysMessage(LANG_PINFO_CHR_MAILS, readmail, totalmail);
        }

        return true;
    }

    static bool HandleRespawnCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        // accept only explicitly selected target (not implicitly self targeting case)
        Unit* target = handler->getSelectedUnit();
        if (player->GetTarget() && target)
        {
            if (target->GetTypeId() != TYPEID_UNIT || target->IsPet())
            {
                handler->SendSysMessage(LANG_SELECT_CREATURE);
                handler->SetSentErrorMessage(true);
                return false;
            }

            if (target->isDead())
                target->ToCreature()->Respawn();
            return true;
        }

        CellCoord p(acore::ComputeCellCoord(player->GetPositionX(), player->GetPositionY()));
        Cell cell(p);
        cell.SetNoCreate();

        acore::RespawnDo u_do;
        acore::WorldObjectWorker<acore::RespawnDo> worker(player, u_do);

        TypeContainerVisitor<acore::WorldObjectWorker<acore::RespawnDo>, GridTypeMapContainer > obj_worker(worker);
        cell.Visit(p, obj_worker, *player->GetMap(), *player, player->GetGridActivationRange());

        return true;
    }
    // mute player for some times
    static bool HandleMuteCommand(ChatHandler* handler, char const* args)
    {
        char* nameStr;
        char* delayStr;
        handler->extractOptFirstArg((char*)args, &nameStr, &delayStr);
        if (!delayStr)
            return false;

        char const* muteReason = strtok(nullptr, "\r");
        std::string muteReasonStr = handler->GetAcoreString(LANG_NO_REASON);
        if (muteReason != nullptr)
            muteReasonStr = muteReason;

        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget(nameStr, &target, &targetGuid, &targetName))
            return false;

        uint32 accountId = target ? target->GetSession()->GetAccountId() : sObjectMgr->GetPlayerAccountIdByGUID(targetGuid);

        // find only player from same account if any
        if (!target)
            if (WorldSession* session = sWorld->FindSession(accountId))
                target = session->GetPlayer();

        uint32 notSpeakTime = uint32(atoi(delayStr));

        // must have strong lesser security level
        if (handler->HasLowerSecurity (target, targetGuid, true))
            return false;

        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_MUTE_TIME);
        std::string muteBy = "";
        if (handler->GetSession())
            muteBy = handler->GetSession()->GetPlayerName();
        else
            muteBy = handler->GetAcoreString(LANG_CONSOLE);

        if (target)
        {
            // Target is online, mute will be in effect right away.
            int64 muteTime = time(nullptr) + notSpeakTime * MINUTE;
            target->GetSession()->m_muteTime = muteTime;
            stmt->setInt64(0, muteTime);
            std::string nameLink = handler->playerLink(targetName);

            if (sWorld->getBoolConfig(CONFIG_SHOW_MUTE_IN_WORLD))
                sWorld->SendWorldText(LANG_COMMAND_MUTEMESSAGE_WORLD, muteBy.c_str(), nameLink.c_str(), notSpeakTime, muteReasonStr.c_str());

            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOUR_CHAT_DISABLED, notSpeakTime, muteBy.c_str(), muteReasonStr.c_str());
        }
        else
        {
            // Target is offline, mute will be in effect starting from the next login.
            int32 muteTime = -int32(notSpeakTime * MINUTE);
            stmt->setInt64(0, muteTime);
        }

        stmt->setString(1, muteReasonStr);
        stmt->setString(2, muteBy);
        stmt->setUInt32(3, accountId);
        LoginDatabase.Execute(stmt);
        stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_ACCOUNT_MUTE);
        stmt->setUInt32(0, accountId);
        stmt->setUInt32(1, notSpeakTime);
        stmt->setString(2, muteBy);
        stmt->setString(3, muteReasonStr);
        LoginDatabase.Execute(stmt);
        std::string nameLink = handler->playerLink(targetName);

        if (sWorld->getBoolConfig(CONFIG_SHOW_MUTE_IN_WORLD) && !target)
            sWorld->SendWorldText(LANG_COMMAND_MUTEMESSAGE_WORLD, muteBy.c_str(), nameLink.c_str(), notSpeakTime, muteReasonStr.c_str());
        else
        {
            // pussywizard: notify all online GMs
            ACORE_READ_GUARD(HashMapHolder<Player>::LockType, *HashMapHolder<Player>::GetLock());
            HashMapHolder<Player>::MapType const& m = sObjectAccessor->GetPlayers();
            for (HashMapHolder<Player>::MapType::const_iterator itr = m.begin(); itr != m.end(); ++itr)
                if (itr->second->GetSession()->GetSecurity())
                    ChatHandler(itr->second->GetSession()).PSendSysMessage(target ? LANG_YOU_DISABLE_CHAT : LANG_COMMAND_DISABLE_CHAT_DELAYED, (handler->GetSession() ? handler->GetSession()->GetPlayerName().c_str() : handler->GetAcoreString(LANG_CONSOLE)), nameLink.c_str(), notSpeakTime, muteReasonStr.c_str());
        }

        return true;
    }

    // unmute player
    static bool HandleUnmuteCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        uint32 accountId = target ? target->GetSession()->GetAccountId() : sObjectMgr->GetPlayerAccountIdByGUID(targetGuid);

        // find only player from same account if any
        if (!target)
            if (WorldSession* session = sWorld->FindSession(accountId))
                target = session->GetPlayer();

        // must have strong lesser security level
        if (handler->HasLowerSecurity (target, targetGuid, true))
            return false;

        if (target)
        {
            if (target->CanSpeak())
            {
                handler->SendSysMessage(LANG_CHAT_ALREADY_ENABLED);
                handler->SetSentErrorMessage(true);
                return false;
            }

            target->GetSession()->m_muteTime = 0;
        }

        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_UPD_MUTE_TIME);
        stmt->setInt64(0, 0);
        stmt->setString(1, "");
        stmt->setString(2, "");
        stmt->setUInt32(3, accountId);
        LoginDatabase.Execute(stmt);

        if (target)
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOUR_CHAT_ENABLED);

        std::string nameLink = handler->playerLink(targetName);

        handler->PSendSysMessage(LANG_YOU_ENABLE_CHAT, nameLink.c_str());

        return true;
    }

    // mutehistory command
    static bool HandleMuteInfoCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* nameStr = strtok((char*)args, "");
        if (!nameStr)
            return false;

        std::string accountName = nameStr;
        if (!Utf8ToUpperOnlyLatin(accountName))
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 accountId = AccountMgr::GetId(accountName);
        if (!accountId)
        {
            handler->PSendSysMessage(LANG_ACCOUNT_NOT_EXIST, accountName.c_str());
            return false;
        }

        return HandleMuteInfoHelper(accountId, accountName.c_str(), handler);
    }

    // helper for mutehistory
    static bool HandleMuteInfoHelper(uint32 accountId, char const* accountName, ChatHandler* handler)
    {
        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_ACCOUNT_MUTE_INFO);
        stmt->setUInt16(0, accountId);
        PreparedQueryResult result = LoginDatabase.Query(stmt);

        if (!result)
        {
            handler->PSendSysMessage(LANG_COMMAND_MUTEHISTORY_EMPTY, accountName);
            return true;
        }

        handler->PSendSysMessage(LANG_COMMAND_MUTEHISTORY, accountName);
        do
        {
            Field* fields = result->Fetch();

            // we have to manually set the string for mutedate
            time_t sqlTime = fields[0].GetUInt32();
            tm timeInfo;
            char buffer[80];

            // set it to string
            localtime_r(&sqlTime, &timeInfo);
            strftime(buffer, sizeof(buffer), "%Y-%m-%d %I:%M%p", &timeInfo);

            handler->PSendSysMessage(LANG_COMMAND_MUTEHISTORY_OUTPUT, buffer, fields[1].GetUInt32(), fields[2].GetCString(), fields[3].GetCString());
        } while (result->NextRow());
        return true;
    }

    static bool HandleMovegensCommand(ChatHandler* handler, char const* /*args*/)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        handler->PSendSysMessage(LANG_MOVEGENS_LIST, (unit->GetTypeId() == TYPEID_PLAYER ? "Player" : "Creature"), unit->GetGUIDLow());

        MotionMaster* motionMaster = unit->GetMotionMaster();
        float x, y, z;
        motionMaster->GetDestination(x, y, z);

        for (uint8 i = 0; i < MAX_MOTION_SLOT; ++i)
        {
            MovementGenerator* movementGenerator = motionMaster->GetMotionSlot(i);
            if (!movementGenerator)
            {
                handler->SendSysMessage("Empty");
                continue;
            }

            switch (movementGenerator->GetMovementGeneratorType())
            {
                case IDLE_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_IDLE);
                    break;
                case RANDOM_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_RANDOM);
                    break;
                case WAYPOINT_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_WAYPOINT);
                    break;
                case ANIMAL_RANDOM_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_ANIMAL_RANDOM);
                    break;
                case CONFUSED_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_CONFUSED);
                    break;
                case CHASE_MOTION_TYPE:
                    {
                        Unit* target = nullptr;
                        if (unit->GetTypeId() == TYPEID_PLAYER)
                            target = static_cast<ChaseMovementGenerator<Player> const*>(movementGenerator)->GetTarget();
                        else
                            target = static_cast<ChaseMovementGenerator<Creature> const*>(movementGenerator)->GetTarget();

                        if (!target)
                            handler->SendSysMessage(LANG_MOVEGENS_CHASE_NULL);
                        else if (target->GetTypeId() == TYPEID_PLAYER)
                            handler->PSendSysMessage(LANG_MOVEGENS_CHASE_PLAYER, target->GetName().c_str(), target->GetGUIDLow());
                        else
                            handler->PSendSysMessage(LANG_MOVEGENS_CHASE_CREATURE, target->GetName().c_str(), target->GetGUIDLow());
                        break;
                    }
                case FOLLOW_MOTION_TYPE:
                    {
                        Unit* target = nullptr;
                        if (unit->GetTypeId() == TYPEID_PLAYER)
                            target = static_cast<FollowMovementGenerator<Player> const*>(movementGenerator)->GetTarget();
                        else
                            target = static_cast<FollowMovementGenerator<Creature> const*>(movementGenerator)->GetTarget();

                        if (!target)
                            handler->SendSysMessage(LANG_MOVEGENS_FOLLOW_NULL);
                        else if (target->GetTypeId() == TYPEID_PLAYER)
                            handler->PSendSysMessage(LANG_MOVEGENS_FOLLOW_PLAYER, target->GetName().c_str(), target->GetGUIDLow());
                        else
                            handler->PSendSysMessage(LANG_MOVEGENS_FOLLOW_CREATURE, target->GetName().c_str(), target->GetGUIDLow());
                        break;
                    }
                case HOME_MOTION_TYPE:
                    {
                        if (unit->GetTypeId() == TYPEID_UNIT)
                            handler->PSendSysMessage(LANG_MOVEGENS_HOME_CREATURE, x, y, z);
                        else
                            handler->SendSysMessage(LANG_MOVEGENS_HOME_PLAYER);
                        break;
                    }
                case FLIGHT_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_FLIGHT);
                    break;
                case POINT_MOTION_TYPE:
                    {
                        handler->PSendSysMessage(LANG_MOVEGENS_POINT, x, y, z);
                        break;
                    }
                case FLEEING_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_FEAR);
                    break;
                case DISTRACT_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_DISTRACT);
                    break;
                case EFFECT_MOTION_TYPE:
                    handler->SendSysMessage(LANG_MOVEGENS_EFFECT);
                    break;
                default:
                    handler->PSendSysMessage(LANG_MOVEGENS_UNKNOWN, movementGenerator->GetMovementGeneratorType());
                    break;
            }
        }
        return true;
    }
    /*
    ComeToMe command REQUIRED for 3rd party scripting library to have access to PointMovementGenerator
    Without this function 3rd party scripting library will get linking errors (unresolved external)
    when attempting to use the PointMovementGenerator
    */
    static bool HandleComeToMeCommand(ChatHandler* handler, char const* args)
    {
        char const* newFlagStr = strtok((char*)args, " ");
        if (!newFlagStr)
            return false;

        Creature* caster = handler->getSelectedCreature();
        if (!caster)
        {
            handler->SendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* player = handler->GetSession()->GetPlayer();

        caster->GetMotionMaster()->MovePoint(0, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ());

        return true;
    }

    static bool HandleDamageCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Unit* target = handler->getSelectedUnit();
        if (!target || !handler->GetSession()->GetPlayer()->GetTarget())
        {
            handler->SendSysMessage(LANG_SELECT_CHAR_OR_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (target->GetTypeId() == TYPEID_PLAYER)
        {
            if (handler->HasLowerSecurity(target->ToPlayer(), 0, false))
                return false;
        }

        if (!target->IsAlive())
            return true;

        int32 damage_int = atoi(args);
        if (damage_int <= 0)
            return true;

        uint32 damage = damage_int;

        if (target->GetTypeId() == TYPEID_UNIT && handler->GetSession()->GetSecurity() == SEC_CONSOLE) // pussywizard
            target->ToCreature()->LowerPlayerDamageReq(target->GetMaxHealth());
        Unit::DealDamage(handler->GetSession()->GetPlayer(), target, damage, nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false, true);
        if (target != handler->GetSession()->GetPlayer())
            handler->GetSession()->GetPlayer()->SendAttackStateUpdate (HITINFO_AFFECTS_VICTIM, target, 1, SPELL_SCHOOL_MASK_NORMAL, damage, 0, 0, VICTIMSTATE_HIT, 0);
        return true;
    }

    static bool HandleCombatStopCommand(ChatHandler* handler, char const* args)
    {
        Player* target = nullptr;

        if (args && strlen(args) > 0)
        {
            target = ObjectAccessor::FindPlayerByName(args);
            if (!target)
            {
                handler->SendSysMessage(LANG_PLAYER_NOT_FOUND);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        if (!target)
        {
            if (!handler->extractPlayerTarget((char*)args, &target))
                return false;
        }

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        target->CombatStop();
        target->getHostileRefManager().deleteReferences();
        return true;
    }

    static bool HandleFlushArenaPointsCommand(ChatHandler* /*handler*/, char const* /*args*/)
    {
        sArenaTeamMgr->DistributeArenaPoints();
        return true;
    }

    static bool HandleRepairitemsCommand(ChatHandler* handler, char const* args)
    {
        Player* target;
        if (!handler->extractPlayerTarget((char*)args, &target))
            return false;

        // check online security
        if (handler->HasLowerSecurity(target, 0))
            return false;

        // Repair items
        target->DurabilityRepairAll(false, 0, false);

        handler->PSendSysMessage(LANG_YOU_REPAIR_ITEMS, handler->GetNameLink(target).c_str());
        if (handler->needReportToTarget(target))
            ChatHandler(target->GetSession()).PSendSysMessage(LANG_YOUR_ITEMS_REPAIRED, handler->GetNameLink().c_str());

        return true;
    }

    // Send mail by command
    static bool HandleSendMailCommand(ChatHandler* handler, char const* args)
    {
        // format: name "subject text" "mail text"
        Player* target;
        uint64 targetGuid;
        std::string targetName;
        if (!handler->extractPlayerTarget((char*)args, &target, &targetGuid, &targetName))
            return false;

        char* tail1 = strtok(nullptr, "");
        if (!tail1)
            return false;

        char const* msgSubject = handler->extractQuotedArg(tail1);
        if (!msgSubject)
            return false;

        char* tail2 = strtok(nullptr, "");
        if (!tail2)
            return false;

        char const* msgText = handler->extractQuotedArg(tail2);
        if (!msgText)
            return false;

        // msgSubject, msgText isn't NUL after prev. check
        std::string subject = msgSubject;
        std::string text    = msgText;

        // from console show not existed sender
        MailSender sender(MAIL_NORMAL, handler->GetSession() ? handler->GetSession()->GetPlayer()->GetGUIDLow() : 0, MAIL_STATIONERY_GM);

        //- TODO: Fix poor design
        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        MailDraft(subject, text)
        .SendMailTo(trans, MailReceiver(target, GUID_LOPART(targetGuid)), sender);

        CharacterDatabase.CommitTransaction(trans);

        std::string nameLink = handler->playerLink(targetName);
        handler->PSendSysMessage(LANG_MAIL_SENT, nameLink.c_str());
        return true;
    }
    // Send items by mail
    static bool HandleSendItemsCommand(ChatHandler* handler, char const* args)
    {
        // format: name "subject text" "mail text" item1[:count1] item2[:count2] ... item12[:count12]
        Player* receiver;
        uint64 receiverGuid;
        std::string receiverName;
        if (!handler->extractPlayerTarget((char*)args, &receiver, &receiverGuid, &receiverName))
            return false;

        char* tail1 = strtok(nullptr, "");
        if (!tail1)
            return false;

        char const* msgSubject = handler->extractQuotedArg(tail1);
        if (!msgSubject)
            return false;

        char* tail2 = strtok(nullptr, "");
        if (!tail2)
            return false;

        char const* msgText = handler->extractQuotedArg(tail2);
        if (!msgText)
            return false;

        // msgSubject, msgText isn't NUL after prev. check
        std::string subject = msgSubject;
        std::string text    = msgText;

        // extract items
        typedef std::pair<uint32, uint32> ItemPair;
        typedef std::list< ItemPair > ItemPairs;
        ItemPairs items;

        // get all tail string
        char* tail = strtok(nullptr, "");

        // get from tail next item str
        while (char* itemStr = strtok(tail, " "))
        {
            // and get new tail
            tail = strtok(nullptr, "");

            // parse item str
            char const* itemIdStr = strtok(itemStr, ":");
            char const* itemCountStr = strtok(nullptr, " ");

            uint32 itemId = atoi(itemIdStr);
            if (!itemId)
                return false;

            ItemTemplate const* item_proto = sObjectMgr->GetItemTemplate(itemId);
            if (!item_proto)
            {
                handler->PSendSysMessage(LANG_COMMAND_ITEMIDINVALID, itemId);
                handler->SetSentErrorMessage(true);
                return false;
            }

            uint32 itemCount = itemCountStr ? atoi(itemCountStr) : 1;
            if (itemCount < 1 || (item_proto->MaxCount > 0 && itemCount > uint32(item_proto->MaxCount)))
            {
                handler->PSendSysMessage(LANG_COMMAND_INVALID_ITEM_COUNT, itemCount, itemId);
                handler->SetSentErrorMessage(true);
                return false;
            }

            while (itemCount > item_proto->GetMaxStackSize())
            {
                items.push_back(ItemPair(itemId, item_proto->GetMaxStackSize()));
                itemCount -= item_proto->GetMaxStackSize();
            }

            items.push_back(ItemPair(itemId, itemCount));

            if (items.size() > MAX_MAIL_ITEMS)
            {
                handler->PSendSysMessage(LANG_COMMAND_MAIL_ITEMS_LIMIT, MAX_MAIL_ITEMS);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }

        // from console show not existed sender
        MailSender sender(MAIL_NORMAL, handler->GetSession() ? handler->GetSession()->GetPlayer()->GetGUIDLow() : 0, MAIL_STATIONERY_GM);

        // fill mail
        MailDraft draft(subject, text);

        SQLTransaction trans = CharacterDatabase.BeginTransaction();

        for (ItemPairs::const_iterator itr = items.begin(); itr != items.end(); ++itr)
        {
            if (Item* item = Item::CreateItem(itr->first, itr->second, handler->GetSession() ? handler->GetSession()->GetPlayer() : 0))
            {
                item->SaveToDB(trans);                               // save for prevent lost at next mail load, if send fail then item will deleted
                draft.AddItem(item);
            }
        }

        draft.SendMailTo(trans, MailReceiver(receiver, GUID_LOPART(receiverGuid)), sender);
        CharacterDatabase.CommitTransaction(trans);

        std::string nameLink = handler->playerLink(receiverName);
        handler->PSendSysMessage(LANG_MAIL_SENT, nameLink.c_str());
        return true;
    }
    /// Send money by mail
    static bool HandleSendMoneyCommand(ChatHandler* handler, char const* args)
    {
        /// format: name "subject text" "mail text" money

        Player* receiver;
        uint64 receiverGuid;
        std::string receiverName;
        if (!handler->extractPlayerTarget((char*)args, &receiver, &receiverGuid, &receiverName))
            return false;

        char* tail1 = strtok(nullptr, "");
        if (!tail1)
            return false;

        char* msgSubject = handler->extractQuotedArg(tail1);
        if (!msgSubject)
            return false;

        char* tail2 = strtok(nullptr, "");
        if (!tail2)
            return false;

        char* msgText = handler->extractQuotedArg(tail2);
        if (!msgText)
            return false;

        char* moneyStr = strtok(nullptr, "");
        int32 money = moneyStr ? atoi(moneyStr) : 0;
        if (money <= 0)
            return false;

        // msgSubject, msgText isn't NUL after prev. check
        std::string subject = msgSubject;
        std::string text    = msgText;

        // from console show not existed sender
        MailSender sender(MAIL_NORMAL, handler->GetSession() ? handler->GetSession()->GetPlayer()->GetGUIDLow() : 0, MAIL_STATIONERY_GM);

        SQLTransaction trans = CharacterDatabase.BeginTransaction();

        MailDraft(subject, text)
        .AddMoney(money)
        .SendMailTo(trans, MailReceiver(receiver, GUID_LOPART(receiverGuid)), sender);

        CharacterDatabase.CommitTransaction(trans);

        std::string nameLink = handler->playerLink(receiverName);
        handler->PSendSysMessage(LANG_MAIL_SENT, nameLink.c_str());
        return true;
    }
    /// Send a message to a player in game
    static bool HandleSendMessageCommand(ChatHandler* handler, char const* args)
    {
        /// - Find the player
        Player* player = nullptr;
        if (!handler->extractPlayerTarget((char*)args, &player))
            return false;

        if (!player)
            return false;

        char* msgStr = strtok(nullptr, "");
        if (!msgStr)
            return false;

        /// - Send the message
        // Use SendAreaTriggerMessage for fastest delivery.
        player->GetSession()->SendAreaTriggerMessage("%s", msgStr);
        player->GetSession()->SendAreaTriggerMessage("|cffff0000[Message from administrator]:|r");

        // Confirmation message
        std::string nameLink = handler->GetNameLink(player);
        handler->PSendSysMessage(LANG_SENDMESSAGE, nameLink.c_str(), msgStr);

        return true;
    }

    static bool HandleCreatePetCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();
        Creature* creatureTarget = handler->getSelectedCreature();

        if (!creatureTarget || creatureTarget->IsPet() || creatureTarget->GetTypeId() == TYPEID_PLAYER)
        {
            handler->PSendSysMessage(LANG_SELECT_CREATURE);
            handler->SetSentErrorMessage(true);
            return false;
        }

        CreatureTemplate const* creatrueTemplate = sObjectMgr->GetCreatureTemplate(creatureTarget->GetEntry());
        // Creatures with family 0 crashes the server
        if (!creatrueTemplate->family)
        {
            handler->PSendSysMessage("This creature cannot be tamed. (family id: 0).");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (player->GetPetGUID())
        {
            handler->PSendSysMessage("You already have a pet");
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Everything looks OK, create new pet
        Pet* pet = new Pet(player, HUNTER_PET);
        if (!pet->CreateBaseAtCreature(creatureTarget))
        {
            delete pet;
            handler->PSendSysMessage("Error 1");
            return false;
        }

        creatureTarget->setDeathState(JUST_DIED);
        creatureTarget->RemoveCorpse();
        creatureTarget->SetHealth(0); // just for nice GM-mode view

        pet->SetUInt64Value(UNIT_FIELD_CREATEDBY, player->GetGUID());
        pet->SetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE, player->getFaction());

        if (!pet->InitStatsForLevel(creatureTarget->getLevel()))
        {
            sLog->outError("InitStatsForLevel() in EffectTameCreature failed! Pet deleted.");
            handler->PSendSysMessage("Error 2");
            delete pet;
            return false;
        }

        // prepare visual effect for levelup
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, creatureTarget->getLevel() - 1);

        pet->GetCharmInfo()->SetPetNumber(sObjectMgr->GeneratePetNumber(), true);
        // this enables pet details window (Shift+P)
        pet->InitPetCreateSpells();
        pet->SetFullHealth();

        pet->GetMap()->AddToMap(pet->ToCreature());

        // visual effect for levelup
        pet->SetUInt32Value(UNIT_FIELD_LEVEL, creatureTarget->getLevel());

        player->SetMinion(pet, true);
        pet->SavePetToDB(PET_SAVE_AS_CURRENT, false);
        player->PetSpellInitialize();

        return true;
    }

    static bool HandlePetLearnCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* player = handler->GetSession()->GetPlayer();
        Pet* pet = player->GetPet();

        if (!pet)
        {
            handler->PSendSysMessage("You have no pet");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 spellId = handler->extractSpellIdFromLink((char*)args);
        if (!spellId)
            return false;

        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (!spellInfo)
        {
            handler->PSendSysMessage(LANG_COMMAND_NOSPELLFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!SpellMgr::IsSpellValid(spellInfo))
        {
            handler->PSendSysMessage(LANG_COMMAND_SPELL_BROKEN, spellId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        SpellScriptsBounds bounds = sObjectMgr->GetSpellScriptsBounds(spellId);
        uint32 spellDifficultyId = sSpellMgr->GetSpellDifficultyId(spellId);
        if (bounds.first != bounds.second || spellDifficultyId)
        {
            handler->PSendSysMessage("Spell %u cannot be learnt using a command!", spellId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // Check if pet already has it
        if (pet->HasSpell(spellId))
        {
            handler->PSendSysMessage("Pet already has spell: %u", spellId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        pet->learnSpell(spellId);

        handler->PSendSysMessage("Pet has learned spell %u", spellId);
        return true;
    }

    static bool HandlePetUnlearnCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* player = handler->GetSession()->GetPlayer();
        Pet* pet = player->GetPet();
        if (!pet)
        {
            handler->PSendSysMessage("You have no pet");
            handler->SetSentErrorMessage(true);
            return false;
        }

        uint32 spellId = handler->extractSpellIdFromLink((char*)args);

        if (pet->HasSpell(spellId))
            pet->removeSpell(spellId, false);
        else
            handler->PSendSysMessage("Pet doesn't have that spell");

        return true;
    }

    static bool HandleFreezeCommand(ChatHandler* handler, char const* args)
    {
        std::string name;
        Player* player;
        char const* TargetName = strtok((char*)args, " "); // get entered name
        if (!TargetName) // if no name entered use target
        {
            player = handler->getSelectedPlayer();
            if (player) //prevent crash with creature as target
            {
                name = player->GetName();
                normalizePlayerName(name);
            }
        }
        else // if name entered
        {
            name = TargetName;
            normalizePlayerName(name);
            player = ObjectAccessor::FindPlayerByName(name);
        }

        if (!player)
        {
            handler->SendSysMessage(LANG_COMMAND_FREEZE_WRONG);
            return true;
        }

        if (player == handler->GetSession()->GetPlayer())
        {
            handler->SendSysMessage(LANG_COMMAND_FREEZE_ERROR);
            return true;
        }

        if (player && (player != handler->GetSession()->GetPlayer()))
        {
            handler->PSendSysMessage(LANG_COMMAND_FREEZE, name.c_str());
            if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(9454))
                Aura::TryRefreshStackOrCreate(spellInfo, MAX_EFFECT_MASK, player, player);
        }

        return true;
    }

    static bool HandleUnFreezeCommand(ChatHandler* handler, char const* args)
    {
        std::string name;
        Player* player;
        char* targetName = strtok((char*)args, " "); // Get entered name

        if (targetName)
        {
            name = targetName;
            normalizePlayerName(name);
            player = ObjectAccessor::FindPlayerByName(name);
        }
        else // If no name was entered - use target
        {
            player = handler->getSelectedPlayer();
            if (player)
                name = player->GetName();
        }

        if (player)
        {
            handler->PSendSysMessage(LANG_COMMAND_UNFREEZE, name.c_str());
            player->RemoveAurasDueToSpell(9454);
            return true;
        }
        else if (targetName)
        {
            if (uint64 playerGUID = sWorld->GetGlobalPlayerGUID(name))
            {
                PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_CHAR_AURA_FROZEN);
                stmt->setUInt32(0, GUID_LOPART(playerGUID));
                CharacterDatabase.Execute(stmt);
                handler->PSendSysMessage(LANG_COMMAND_UNFREEZE, name.c_str());
                return true;
            }
        }

        handler->SendSysMessage(LANG_COMMAND_FREEZE_WRONG);
        return true;
    }

    static bool HandleGroupLeaderCommand(ChatHandler* handler, char const* args)
    {
        Player* player = nullptr;
        Group* group = nullptr;
        uint64 guid = 0;
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
        uint64 guid = 0;
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
        uint64 guid = 0;
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
        uint64 guidSource = 0;
        uint64 guidTarget = 0;
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
        uint64 guidTarget = 0;
        std::string nameTarget;

        uint32 parseGUID = MAKE_NEW_GUID(atol((char*)args), 0, HIGHGUID_PLAYER);

        if (sObjectMgr->GetPlayerNameByGUID(parseGUID, nameTarget))
        {
            playerTarget = ObjectAccessor::FindPlayerInOrOutOfWorld(MAKE_NEW_GUID(parseGUID, 0, HIGHGUID_PLAYER));
            guidTarget = parseGUID;
        }
        else if (!handler->extractPlayerTarget((char*)args, &playerTarget, &guidTarget, &nameTarget))
            return false;

        Group* groupTarget = nullptr;
        if (playerTarget)
            groupTarget = playerTarget->GetGroup();

        if (!groupTarget && guidTarget)
            if (uint32 groupId = Player::GetGroupIdFromStorage(GUID_LOPART(guidTarget)))
                groupTarget = sGroupMgr->GetGroupByGUID(groupId);

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

                /*Player* p = ObjectAccessor::FindPlayerInOrOutOfWorld((*itr).guid);
                const char* onlineState = p ? "online" : "offline";

                handler->PSendSysMessage(LANG_GROUP_PLAYER_NAME_GUID, slot.name.c_str(), onlineState,
                    GUID_LOPART(slot.guid), flags.c_str(), lfg::GetRolesString(slot.roles).c_str());*/
            }
        }
        else
            handler->PSendSysMessage(LANG_GROUP_NOT_IN_GROUP, nameTarget.c_str());

        return true;
    }

    static bool HandlePlayAllCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        uint32 soundId = atoi((char*)args);

        if (!sSoundEntriesStore.LookupEntry(soundId))
        {
            handler->PSendSysMessage(LANG_SOUND_NOT_EXIST, soundId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        WorldPacket data(SMSG_PLAY_SOUND, 4);
        data << uint32(soundId) << handler->GetSession()->GetPlayer()->GetGUID();
        sWorld->SendGlobalMessage(&data);

        handler->PSendSysMessage(LANG_COMMAND_PLAYED_TO_ALL, soundId);
        return true;
    }

    static bool HandlePossessCommand(ChatHandler* handler, char const* /*args*/)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
            return false;

        handler->GetSession()->GetPlayer()->CastSpell(unit, 530, true);
        return true;
    }

    static bool HandleUnPossessCommand(ChatHandler* handler, char const* /*args*/)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
            unit = handler->GetSession()->GetPlayer();

        unit->RemoveCharmAuras();

        return true;
    }

    static bool HandleBindSightCommand(ChatHandler* handler, char const* /*args*/)
    {
        Unit* unit = handler->getSelectedUnit();
        if (!unit)
            return false;

        handler->GetSession()->GetPlayer()->CastSpell(unit, 6277, true);
        return true;
    }

    static bool HandleUnbindSightCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (player->isPossessing())
            return false;

        player->StopCastingBindSight();
        return true;
    }

    static bool HandleMailBoxCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();

        handler->GetSession()->SendShowMailBox(player->GetGUID());
        return true;
    }
};

void AddSC_misc_commandscript()
{
    new misc_commandscript();
}
