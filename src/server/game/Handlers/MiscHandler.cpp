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

#include "AccountMgr.h"
#include "BattlefieldMgr.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "CharacterPackets.h"
#include "Chat.h"
#include "Common.h"
#include "DBCEnums.h"
#include "DatabaseEnv.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GossipDef.h"
#include "Group.h"
#include "GuildMgr.h"
#include "InstanceScript.h"
#include "Language.h"
#include "Log.h"
#include "LootMgr.h"
#include "MapMgr.h"
#include "MiscPackets.h"
#include "Object.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "OutdoorPvP.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "UpdateData.h"
#include "Vehicle.h"
#include "WhoListCacheMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "User.h"
#include <zlib.h>

void User::HandleRepopRequestOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_REPOP_REQUEST Message");

    recv_data.read_skip<uint8>();

    if (GetPlayer()->IsAlive() || GetPlayer()->HasPlayerFlag(PLAYER_FLAGS_GHOST))
        return;

    if (GetPlayer()->HasAuraType(SPELL_AURA_PREVENT_RESURRECTION))
        return; // silently return, client should display the error by itself

    // the world update order is sessions, players, creatures
    // the netcode runs in parallel with all of these
    // creatures can kill players
    // so if the server is lagging enough the player can
    // release spirit after he's killed but before he is updated
    if (GetPlayer()->getDeathState() == DeathState::JustDied)
    {
        LOG_DEBUG("network", "HandleRepopRequestOpcode: got request after player {} ({}) was killed and before he was updated",
            GetPlayer()->GetName(), GetPlayer()->GetGUID().ToString());
        GetPlayer()->KillPlayer();
    }

    //this is spirit release confirm?
    GetPlayer()->RemovePet(nullptr, PET_SAVE_NOT_IN_SLOT, true);
    GetPlayer()->BuildPlayerRepop();
    GetPlayer()->RepopAtGraveyard();
}

void User::HandleGossipSelectOptionOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "WORLD: CMSG_GOSSIP_SELECT_OPTION");

    uint32 gossipListId;
    uint32 menuId;
    ObjectGuid guid;
    std::string code = "";

    recv_data >> guid >> menuId >> gossipListId;

    if (m_player->PlayerTalkClass->IsGossipOptionCoded(gossipListId))
        recv_data >> code;

    // Prevent cheating on C++ scripted menus
    if (m_player->PlayerTalkClass->GetGossipMenu().GetSenderGUID() != guid)
    {
        return;
    }

    Creature* unit = nullptr;
    GameObject* go = nullptr;
    Item* item = nullptr;
    if (guid.IsCreatureOrVehicle())
    {
        unit = GetPlayer()->GetNPCIfCanInteractWith(guid, UNIT_NPC_FLAG_NONE);
        if (!unit)
        {
            LOG_DEBUG("network", "WORLD: HandleGossipSelectOptionOpcode - Unit ({}) not found or you can't interact with him.", guid.ToString());
            return;
        }
    }
    else if (guid.IsGameObject())
    {
        go = m_player->GetMap()->GetGameObject(guid);
        if (!go)
        {
            LOG_DEBUG("network", "WORLD: HandleGossipSelectOptionOpcode - GameObject ({}) not found.", guid.ToString());
            return;
        }
    }
    else if (guid.IsItem())
    {
        item = m_player->GetItemByGuid(guid);
        if (!item || m_player->IsBankPos(item->GetPos()))
        {
            //LOG_DEBUG("network", "WORLD: HandleGossipSelectOptionOpcode - {} not found.", guid.ToString());
            return;
        }
    }
    else if (guid.IsPlayer())
    {
        if (guid != m_player->GetGUID() || menuId != m_player->PlayerTalkClass->GetGossipMenu().GetMenuId())
        {
            //LOG_DEBUG("network", "WORLD: HandleGossipSelectOptionOpcode - {} not found.", guid.ToString());
            return;
        }
    }
    else
    {
        LOG_DEBUG("network", "WORLD: HandleGossipSelectOptionOpcode - unsupported GUID type for {}.", guid.ToString());
        return;
    }

    // remove fake death
    if (GetPlayer()->HasUnitState(UNIT_STATE_DIED))
        GetPlayer()->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

    if ((unit && unit->GetScriptId() != unit->LastUsedScriptID) || (go && go->GetScriptId() != go->LastUsedScriptID))
    {
        LOG_DEBUG("network", "WORLD: HandleGossipSelectOptionOpcode - Script reloaded while in use, ignoring and set new scipt id");
        if (unit)
            unit->LastUsedScriptID = unit->GetScriptId();
        if (go)
            go->LastUsedScriptID = go->GetScriptId();
        m_player->PlayerTalkClass->SendCloseGossip();
        return;
    }
    if (!code.empty())
    {
        if (unit)
        {
            unit->AI()->sGossipSelectCode(m_player, menuId, gossipListId, code.c_str());
            if (!sScriptMgr->OnGossipSelectCode(m_player, unit, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId), code.c_str()))
                m_player->OnGossipSelect(unit, gossipListId, menuId);
        }
        else if (go)
        {
            go->AI()->GossipSelectCode(m_player, menuId, gossipListId, code.c_str());
            sScriptMgr->OnGossipSelectCode(m_player, go, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId), code.c_str());
        }
        else if (item)
        {
            sScriptMgr->OnGossipSelectCode(m_player, item, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId), code.c_str());
        }
        else
        {
            sScriptMgr->OnGossipSelectCode(m_player, menuId, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId), code.c_str());
        }
    }
    else
    {
        if (unit)
        {
            unit->AI()->sGossipSelect(m_player, menuId, gossipListId);
            if (!sScriptMgr->OnGossipSelect(m_player, unit, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId)))
                m_player->OnGossipSelect(unit, gossipListId, menuId);
        }
        else if (go)
        {
            go->AI()->GossipSelect(m_player, menuId, gossipListId);
            if (!sScriptMgr->OnGossipSelect(m_player, go, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId)))
                m_player->OnGossipSelect(go, gossipListId, menuId);
        }
        else if (item)
        {
            sScriptMgr->OnGossipSelect(m_player, item, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId));
        }
        else
        {
            sScriptMgr->OnGossipSelect(m_player, menuId, m_player->PlayerTalkClass->GetGossipOptionSender(gossipListId), m_player->PlayerTalkClass->GetGossipOptionAction(gossipListId));
        }
    }
}

void User::HandleWhoOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: Recvd CMSG_WHO Message");

    uint32 matchCount = 0;

    uint32 levelMin, levelMax, racemask, classmask, zonesCount, strCount;
    std::array<uint32, 10> zoneids = {};                    // 10 is client limit
    std::string packetPlayerName, packetGuildName;

    recvData >> levelMin;                                   // maximal player level, default 0
    recvData >> levelMax;                                   // minimal player level, default 100 (MAX_LEVEL)
    recvData >> packetPlayerName;                           // player name, case sensitive...

    recvData >> packetGuildName;                            // guild name, case sensitive...

    recvData >> racemask;                                   // race mask
    recvData >> classmask;                                  // class mask
    recvData >> zonesCount;                                 // zones count, client limit = 10 (2.0.10)

    if (zonesCount > 10)
        return;                                             // can't be received from real client or broken packet

    for (uint32 i = 0; i < zonesCount; ++i)
    {
        uint32 temp;
        recvData >> temp;                                   // zone id, 0 if zone is unknown...
        zoneids[i] = temp;
        LOG_DEBUG("network.who", "Zone {}: {}", i, zoneids[i]);
    }

    recvData >> strCount;                                   // user entered strings count, client limit=4 (checked on 2.0.10)

    if (strCount > 4)
        return;                                             // can't be received from real client or broken packet

    LOG_DEBUG("network.who", "Minlvl {}, maxlvl {}, name {}, guild {}, racemask {}, classmask {}, zones {}, strings {}",
        levelMin, levelMax, packetPlayerName, packetGuildName, racemask, classmask, zonesCount, strCount);

    std::wstring str[4];                                    // 4 is client limit
    for (uint32 i = 0; i < strCount; ++i)
    {
        std::string temp;
        recvData >> temp;                                   // user entered string, it used as universal search pattern(guild+player name)?

        if (!Utf8toWStr(temp, str[i]))
            continue;

        wstrToLower(str[i]);

        LOG_DEBUG("network.who", "String {}: {}", i, temp);
    }

    std::wstring wpacketPlayerName;
    std::wstring wpacketGuildName;
    if (!(Utf8toWStr(packetPlayerName, wpacketPlayerName) && Utf8toWStr(packetGuildName, wpacketGuildName)))
        return;

    wstrToLower(wpacketPlayerName);
    wstrToLower(wpacketGuildName);;

    // client send in case not set max level value 100 but Acore supports 255 max level,
    // update it to show GMs with characters after 100 level
    if (levelMax >= MAX_LEVEL)
        levelMax = STRONG_MAX_LEVEL;

    uint32 team = m_player->GetTeamId();
    uint32 security = GetSecurity();
    bool allowTwoSideWhoList = sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_WHO_LIST);
    uint32 gmLevelInWhoList = sWorld->getIntConfig(CONFIG_GM_LEVEL_IN_WHO_LIST);
    uint32 displaycount = 0;

    WorldPacket data(SMSG_WHO, 50);     // guess size
    data << uint32(matchCount);         // placeholder, count of players matching criteria
    data << uint32(displaycount);       // placeholder, count of players displayed

    for (auto const& target : sWhoListCacheMgr->GetWhoList())
    {
        if (AccountMgr::IsPlayerAccount(security))
        {
            // player can see member of other team only if CONFIG_ALLOW_TWO_SIDE_WHO_LIST
            if (target.GetTeamId() != team && !allowTwoSideWhoList)
            {
                continue;
            }

            // player can see MODERATOR, GAME MASTER, ADMINISTRATOR only if CONFIG_GM_IN_WHO_LIST
            if (target.GetSecurity() > AccountTypes(gmLevelInWhoList))
            {
                continue;
            }
        }

        // check if target is globally visible for player
        if ((m_player->GetGUID() != target.GetGuid() && !target.IsVisible()) &&
            (AccountMgr::IsPlayerAccount(m_player->User()->GetSecurity()) || target.GetSecurity() > m_player->User()->GetSecurity()))
        {
            continue;
        }

        // check if target's level is in level range
        uint8 lvl = target.GetLevel();
        if (lvl < levelMin || lvl > levelMax)
        {
            continue;
        }

        // check if class matches classmask
        uint8 class_ = target.GetClass();
        if (!(classmask & (1 << class_)))
        {
            continue;
        }

        // check if race matches racemask
        uint32 race = target.GetRace();
        if (!(racemask & (1 << race)))
        {
            continue;
        }

        uint32 playerZoneId = target.GetZoneId();
        uint8 gender = target.GetGender();

        bool showZones = true;
        for (uint32 i = 0; i < zonesCount; ++i)
        {
            if (zoneids[i] == playerZoneId)
            {
                showZones = true;
                break;
            }

            showZones = false;
        }

        if (!showZones)
        {
            continue;
        }

        std::wstring const& wideplayername = target.GetWidePlayerName();
        if (!(wpacketPlayerName.empty() || wideplayername.find(wpacketPlayerName) != std::wstring::npos))
        {
            continue;
        }

        std::wstring const& wideguildname = target.GetWideGuildName();
        if (!(wpacketGuildName.empty() || wideguildname.find(wpacketGuildName) != std::wstring::npos))
        {
            continue;
        }

        std::string aname;
        if (AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(playerZoneId))
        {
            aname = areaEntry->area_name[GetSessionDbcLocale()];
        }

        bool s_show = true;
        for (uint32 i = 0; i < strCount; ++i)
        {
            if (!str[i].empty())
            {
                if (wideguildname.find(str[i]) != std::wstring::npos ||
                    wideplayername.find(str[i]) != std::wstring::npos ||
                    Utf8FitTo(aname, str[i]))
                {
                    s_show = true;
                    break;
                }

                s_show = false;
            }
        }

        if (!s_show)
        {
            continue;
        }

        // 49 is maximum player count sent to client - can be overridden
        // through config, but is unstable
        if ((matchCount++) >= sWorld->getIntConfig(CONFIG_MAX_WHO_LIST_RETURN))
        {
            continue;
        }

        data << target.GetPlayerName();                   // player name
        data << target.GetGuildName();                    // guild name
        data << uint32(lvl);                              // player level
        data << uint32(class_);                           // player class
        data << uint32(race);                             // player race
        data << uint8(gender);                            // player gender
        data << uint32(playerZoneId);                     // player zone id

        ++displaycount;
    }

    data.put(0, displaycount);                            // insert right count, count displayed
    data.put(4, matchCount);                              // insert right count, count of matches

    Send(&data);
    LOG_DEBUG("network", "WORLD: Send SMSG_WHO Message");
}

//===========================================================================
void User::HandlePlayerLogout(WorldPacket &msg)
{
    if (!IsGMAccount()) {
        SendNotification(LANG_PERMISSION_DENIED);
        return;
    }
    CharacterRemoveFromGame(true);
}

void User::HandleTogglePvP(WorldPacket& recv_data)
{
    // this opcode can be used in two ways: Either set explicit new status or toggle old status
    if (recv_data.size() == 1)
    {
        bool newPvPStatus;
        recv_data >> newPvPStatus;
        GetPlayer()->ApplyModFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP, newPvPStatus);
    }
    else
        GetPlayer()->ToggleFlag(PLAYER_FLAGS, PLAYER_FLAGS_IN_PVP);

    if (GetPlayer()->HasPlayerFlag(PLAYER_FLAGS_IN_PVP))
        GetPlayer()->UpdatePvP(true, true);
    else if (!GetPlayer()->pvpInfo.IsHostile && GetPlayer()->IsPvP()) // pussywizard: in pvp mode, but doesn't want to be and not in hostile territory, so start timer
        GetPlayer()->UpdatePvP(true, false);

    //if (OutdoorPvP* pvp = m_player->GetOutdoorPvP())
    //    pvp->HandlePlayerActivityChanged(m_player);
}

void User::HandleZoneUpdateOpcode(WorldPacket& recv_data)
{
    uint32 newZone;
    recv_data >> newZone;

    LOG_DEBUG("network", "WORLD: Recvd ZONE_UPDATE: {}", newZone);

    // use server side data, but only after update the player position. See Player::UpdatePosition().
    GetPlayer()->SetNeedZoneUpdate(true);

    //GetPlayer()->SendInitWorldStates(true, newZone);
}

void User::HandleSetSelectionOpcode(WorldPacket& recv_data)
{
    ObjectGuid guid;
    recv_data >> guid;

    m_player->SetSelection(guid);

    // Change target of current autoshoot spell
    if (guid)
    {
        if (Spell* autoReapeatSpell = m_player->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
        {
            if (autoReapeatSpell->m_targets.GetUnitTargetGUID() != guid)
            {
                if (Unit* unit = ObjectAccessor::GetUnit(*m_player, guid))
                {
                    if (unit->IsAlive() && !m_player->IsFriendlyTo(unit) && unit->isTargetableForAttack(true, m_player))
                    {
                        autoReapeatSpell->m_targets.SetUnitTarget(unit);
                    }
                }
            }
        }
    }
}

void User::HandleStandStateChangeOpcode(WorldPacket& recv_data)
{
    uint32 animstate;
    recv_data >> animstate;

    switch (animstate)
    {
        case UNIT_STANDING:
        case UNIT_SITTING:
        case UNIT_SLEEPING:
        case UNIT_KNEEL:
            break;
        default:
            return;
    }

    m_player->SetStandState(animstate);
}

void User::HandleLoadActionsSwitchSpec(PreparedQueryResult result)
{
    if (!GetPlayer())
        return;

    if (result)
        GetPlayer()->_LoadActions(result);

    GetPlayer()->SendActionButtons(1);
}

void User::HandleCharacterAuraFrozen(PreparedQueryResult result)
{
    if (!GetPlayer())
        return;

    ChatHandler handler = ChatHandler(this);

    // Select
    if (!result)
    {
        handler.SendSysMessage(LANG_COMMAND_NO_FROZEN_PLAYERS);
        return;
    }

    // Header of the names
    handler.PSendSysMessage(LANG_COMMAND_LIST_FREEZE);

    // Output of the results
    do
    {
        Field* fields = result->Fetch();
        std::string player = fields[0].Get<std::string>();
        handler.PSendSysMessage(LANG_COMMAND_FROZEN_PLAYERS, player.c_str());
    } while (result->NextRow());
}

void User::HandleBugOpcode(WorldPacket& recv_data)
{
    uint32 suggestion, contentlen, typelen;
    std::string content, type;

    recv_data >> suggestion >> contentlen >> content;

    recv_data >> typelen >> type;

    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_BUG_REPORT);

    stmt->SetData(0, type);
    stmt->SetData(1, content);

    CharacterDatabase.Execute(stmt);
}

void User::HandleReclaimCorpseOpcode(WorldPacket& recv_data)
{
    ObjectGuid corpseGUID;
    recv_data >> corpseGUID;

    if (m_player->IsAlive())
        return;

    // do not allow corpse reclaim in arena
    if (m_player->InArena())
        return;

    // body not released yet
    if (!m_player->HasPlayerFlag(PLAYER_FLAGS_GHOST))
        return;

    Corpse* corpse = m_player->GetCorpse();
    if (!corpse)
        return;

    // prevent resurrect before 30-sec delay after body release not finished
    if (time_t(corpse->GetGhostTime() + m_player->GetCorpseReclaimDelay(corpse->GetType() == CORPSE_RESURRECTABLE_PVP)) > time_t(GameTime::GetGameTime().count()))
        return;

    if (!corpse->IsWithinDistInMap(m_player, CORPSE_RECLAIM_RADIUS, true))
        return;

    // resurrect
    m_player->Resurrect(m_player->InBattleground() ? 1.0f : 0.5f);

    // spawn bones
    m_player->SpawnCorpseBones();
}

void User::HandleResurrectResponseOpcode(WorldPacket& recv_data)
{
    ObjectGuid resurrectOfferer;
    bool accept;
    recv_data >> resurrectOfferer;
    recv_data >> accept;

    // Xinef: Prevent resurrect with prevent resurrection aura
    if (GetPlayer()->IsAlive() || GetPlayer()->HasAuraType(SPELL_AURA_PREVENT_RESURRECTION))
        return;

    if (accept == 0)
    {
        GetPlayer()->clearResurrectRequestData();           // reject
        return;
    }

    if (!GetPlayer()->isResurrectRequestedBy(resurrectOfferer))
        return;

    GetPlayer()->ResurectUsingRequestData();
}

void User::SendAreaTriggerMessage(const char* Text, ...)
{
    va_list ap;
    char szStr [1024];
    szStr[0] = '\0';

    va_start(ap, Text);
    vsnprintf(szStr, 1024, Text, ap);
    va_end(ap);

    uint32 length = strlen(szStr) + 1;
    WorldPacket data(SMSG_AREA_TRIGGER_MESSAGE, 4 + length);
    data << length;
    data << szStr;
    Send(&data);
}

void User::SendAreaTriggerMessage(uint32 entry, ...)
{
    char const* format = GetAcoreString(entry);
    if (format)
    {
        va_list ap;
        char szStr[1024];
        szStr[0] = '\0';

        va_start(ap, entry);
        vsnprintf(szStr, 1024, format, ap);
        va_end(ap);

        uint32 length = strlen(szStr) + 1;
        WorldPacket data(SMSG_AREA_TRIGGER_MESSAGE, 4 + length);
        data << length;
        data << szStr;
        Send(&data);
    }
}

void User::HandleAreaTriggerOpcode(WorldPacket& recv_data)
{
    uint32 triggerId;
    recv_data >> triggerId;

    LOG_DEBUG("network", "CMSG_AREATRIGGER. Trigger ID: {}", triggerId);

    Player* player = GetPlayer();
    if (player->IsOnTaxi())
    {
        LOG_DEBUG("network", "HandleAreaTriggerOpcode: Player '{}' ({}) in flight, ignore Area Trigger ID:{}",
                       player->GetName(), player->GetGUID().ToString(), triggerId);
        return;
    }

    AreaTrigger const* atEntry = sObjectMgr->GetAreaTrigger(triggerId);
    if (!atEntry)
    {
        LOG_DEBUG("network", "HandleAreaTriggerOpcode: Player '{}' ({}) send unknown (by DBC) Area Trigger ID:{}",
                       player->GetName(), player->GetGUID().ToString(), triggerId);
        return;
    }

    uint32 teamFaction = player->GetTeamId(true) == TEAM_ALLIANCE ? FACTION_MASK_ALLIANCE : FACTION_MASK_HORDE;
    bool isTavernAreatrigger = sObjectMgr->IsTavernAreaTrigger(triggerId, teamFaction);
    if (!player->IsInAreaTriggerRadius(atEntry, isTavernAreatrigger ? 5.f : 0.f))
    {
        LOG_DEBUG("network", "HandleAreaTriggerOpcode: Player {} ({}) too far (trigger map: {} player map: {}), ignore Area Trigger ID: {}",
                       player->GetName(), player->GetGUID().ToString(), atEntry->map, player->GetMapId(), triggerId);
        return;
    }

    if (player->isDebugAreaTriggers)
        ChatHandler(this).PSendSysMessage(LANG_DEBUG_AREATRIGGER_REACHED, triggerId);

    if (sScriptMgr->OnAreaTrigger(player, atEntry))
        return;

    if (player->IsAlive())
        if (uint32 questId = sObjectMgr->GetQuestForAreaTrigger(triggerId))
            if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
                player->AreaExploredOrEventHappens(questId);

    if (isTavernAreatrigger)
    {
        // set resting flag we are in the inn
        player->SetRestFlag(REST_FLAG_IN_TAVERN, atEntry->entry);

        if (sWorld->IsFFAPvPRealm())
        {
            if (player->HasByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP))
            {
                player->RemoveByteFlag(UNIT_FIELD_BYTES_2, 1, UNIT_BYTE2_FLAG_FFA_PVP);
                sScriptMgr->OnFfaPvpStateUpdate(player, false);

            }
        }
        return;
    }

    if (Battleground* bg = player->GetBattleground())
        if (bg->GetStatus() == STATUS_IN_PROGRESS)
        {
            bg->HandleAreaTrigger(player, triggerId);
            return;
        }

    if (OutdoorPvP* pvp = player->GetOutdoorPvP())
        if (pvp->HandleAreaTrigger(m_player, triggerId))
            return;

    AreaTriggerTeleport const* at = sObjectMgr->GetAreaTriggerTeleport(triggerId);
    if (!at)
        return;

    bool teleported = false;
    if (player->GetMapId() != at->target_mapId)
    {
       if (Map::EnterState denyReason = sMapMgr->PlayerCannotEnter(at->target_mapId, player, false))
        {
            bool reviveAtTrigger = false; // should we revive the player if he is trying to enter the correct instance?
            switch (denyReason)
            {
                case Map::CANNOT_ENTER_NOT_IN_RAID:
                case Map::CANNOT_ENTER_INSTANCE_BIND_MISMATCH:
                case Map::CANNOT_ENTER_TOO_MANY_INSTANCES:
                case Map::CANNOT_ENTER_MAX_PLAYERS:
                case Map::CANNOT_ENTER_ZONE_IN_COMBAT:
                    reviveAtTrigger = true;
                    break;
                default:
                    break;
            }

            if (reviveAtTrigger) // check if the player is touching the areatrigger leading to the map his corpse is on
            {
                if (!player->IsAlive() && player->HasCorpse())
                {
                    if (player->GetCorpseLocation().GetMapId() == at->target_mapId)
                    {
                        player->Resurrect(0.5f);
                        player->SpawnCorpseBones();
                    }
                }
            }

            return;
        }

        if (Group* group = player->GetGroup())
            if (group->isLFGGroup() && player->GetMap()->IsDungeon())
                teleported = player->TeleportToEntryPoint();
    }

    if (!teleported)
        player->Teleport(at->target_mapId, at->target_X, at->target_Y, at->target_Z, at->target_Orientation, TELE_TO_NOT_LEAVE_TRANSPORT);
}

void User::HandleUpdateAccountData(WorldPacket& recv_data)
{
    uint32 type, timestamp, decompressedSize;
    recv_data >> type >> timestamp >> decompressedSize;

    LOG_DEBUG("network", "UAD: type {}, time {}, decompressedSize {}", type, timestamp, decompressedSize);

    if (type >= NUM_ACCOUNT_DATA_TYPES)
        return;

    if (decompressedSize == 0)                               // erase
    {
        SetAccountData(AccountDataType(type), 0, "");

        WorldPacket data(SMSG_UPDATE_ACCOUNT_DATA_COMPLETE, 4 + 4);
        data << uint32(type);
        data << uint32(0);
        Send(&data);

        return;
    }

    if (decompressedSize > 0xFFFF)
    {
        recv_data.rfinish();                   // unnneded warning spam in this case
        LOG_ERROR("network.opcode", "UAD: Account data packet too big, size {}", decompressedSize);
        return;
    }

    ByteBuffer dest;
    dest.resize(decompressedSize);

    uLongf realSize = decompressedSize;
    if (uncompress(dest.contents(), &realSize, recv_data.contents() + recv_data.rpos(), recv_data.size() - recv_data.rpos()) != Z_OK)
    {
        recv_data.rfinish();                   // unnneded warning spam in this case
        LOG_ERROR("network.opcode", "UAD: Failed to decompress account data");
        return;
    }

    recv_data.rfinish();                       // uncompress read (recv_data.size() - recv_data.rpos())

    std::string adata;
    dest >> adata;

    SetAccountData(AccountDataType(type), timestamp, adata);

    WorldPacket data(SMSG_UPDATE_ACCOUNT_DATA_COMPLETE, 4 + 4);
    data << uint32(type);
    data << uint32(0);
    Send(&data);
}

void User::HandleRequestAccountData(WorldPacket& recv_data)
{
    uint32 type;
    recv_data >> type;

    LOG_DEBUG("network", "RAD: type {}", type);

    if (type >= NUM_ACCOUNT_DATA_TYPES)
        return;

    AccountData* adata = GetAccountData(AccountDataType(type));

    uint32 size = adata->Data.size();

    uLongf destSize = compressBound(size);

    ByteBuffer dest;
    dest.resize(destSize);

    if (size && compress(dest.contents(), &destSize, (uint8 const*)adata->Data.c_str(), size) != Z_OK)
    {
        LOG_DEBUG("network", "RAD: Failed to compress account data");
        return;
    }

    dest.resize(destSize);

    WorldPacket data(SMSG_UPDATE_ACCOUNT_DATA, 8 + 4 + 4 + 4 + destSize);
    data << (m_player ? m_player->GetGUID() : ObjectGuid::Empty); // player guid
    data << uint32(type);                                       // type (0-7)
    data << uint32(adata->Time);                                // unix time
    data << uint32(size);                                       // decompressed length
    data.append(dest);                                          // compressed data
    Send(&data);
}

void User::HandleSetActionButtonOpcode(WorldPacket& recv_data)
{
    uint8 button;
    uint32 packetData;
    recv_data >> button >> packetData;

    uint32 action = ACTION_BUTTON_ACTION(packetData);
    uint8  type   = ACTION_BUTTON_TYPE(packetData);

    LOG_DEBUG("network.opcode", "BUTTON: {} ACTION: {} TYPE: {}", button, action, type);
    if (!packetData)
    {
        LOG_DEBUG("network.opcode", "MISC: Remove action from button {}", button);
        GetPlayer()->removeActionButton(button);
    }
    else
    {
        switch (type)
        {
            case ACTION_BUTTON_MACRO:
            case ACTION_BUTTON_CMACRO:
                LOG_DEBUG("network.opcode", "MISC: Added Macro {} into button {}", action, button);
                break;
            case ACTION_BUTTON_EQSET:
                LOG_DEBUG("network.opcode", "MISC: Added EquipmentSet {} into button {}", action, button);
                break;
            case ACTION_BUTTON_SPELL:
                LOG_DEBUG("network.opcode", "MISC: Added Spell {} into button {}", action, button);
                break;
            case ACTION_BUTTON_ITEM:
                LOG_DEBUG("network.opcode", "MISC: Added Item {} into button {}", action, button);
                break;
            default:
                LOG_ERROR("network.opcode", "MISC: Unknown action button type {} for action {} into button {} for player {} ({})",
                    type, action, button, m_player->GetName(), m_player->GetGUID().ToString());
                return;
        }
        GetPlayer()->addActionButton(button, action, type);
    }
}

void User::HandleCompleteCinematic(WorldPacket& /*recv_data*/)
{
    // If player has sight bound to visual waypoint NPC we should remove it
    GetPlayer()->GetCinematicMgr()->EndCinematic();
}

void User::HandleNextCinematicCamera(WorldPacket& /*recv_data*/)
{
    // Sent by client when cinematic actually begun. So we begin the server side process
    GetPlayer()->GetCinematicMgr()->BeginCinematic();
}

void User::HandleFeatherFallAck(WorldPacket& recv_data)
{
    // no used
    recv_data.rfinish();                       // prevent warnings spam
}

void User::HandleSetActionBarToggles(WorldPacket& recv_data)
{
    uint8 ActionBar;

    recv_data >> ActionBar;

    if (!GetPlayer())                                        // ignore until not logged (check needed because STATUS_AUTHED)
    {
        if (ActionBar != 0)
            LOG_ERROR("network.opcode", "User::HandleSetActionBarToggles in not logged state with value: {}, ignored", uint32(ActionBar));
        return;
    }

    GetPlayer()->SetByteValue(PLAYER_FIELD_BYTES, 2, ActionBar);
}

void User::HandlePlayedTime(WorldPackets::Character::PlayedTimeClient& packet)
{
    WorldPackets::Character::PlayedTime playedTime;
    playedTime.TotalTime = m_player->GetTotalPlayedTime();
    playedTime.LevelTime = m_player->GetLevelPlayedTime();
    playedTime.TriggerScriptEvent = packet.TriggerScriptEvent;  // 0-1 - will not show in chat frame
    Send(playedTime.Write());
}

void User::HandleInspectOpcode(WorldPacket& recv_data)
{
    ObjectGuid guid;
    recv_data >> guid;

    Player* player = ObjectAccessor::GetPlayer(*m_player, guid);
    if (!player)
    {
        LOG_DEBUG("network", "CMSG_INSPECT: No player found from {}", guid.ToString());
        return;
    }

    if (!GetPlayer()->IsWithinDistInMap(player, INSPECT_DISTANCE, false))
    {
        return;
    }

    if (GetPlayer()->IsValidAttackTarget(player))
    {
        return;
    }

    uint32 talent_points = 0x47;
    uint32 guid_size = player->GetPackGUID().size();
    WorldPacket data(SMSG_INSPECT_TALENT, guid_size + 4 + talent_points);
    data << player->GetPackGUID();

    if (sWorld->getBoolConfig(CONFIG_TALENTS_INSPECTING) || m_player->IsGameMaster())
    {
        player->BuildPlayerTalentsInfoData(&data);
    }
    else
    {
        data << uint32(0);                                  // unspentTalentPoints
        data << uint8(0);                                   // talentGroupCount
        data << uint8(0);                                   // talentGroupIndex
    }

    player->BuildEnchantmentsInfoData(&data);
    Send(&data);
}

void User::HandleInspectHonorStatsOpcode(WorldPacket& recv_data)
{
    ObjectGuid guid;
    recv_data >> guid;

    Player* player = ObjectAccessor::GetPlayer(*m_player, guid);
    if (!player)
    {
        LOG_DEBUG("network", "MSG_INSPECT_HONOR_STATS: No player found from {}", guid.ToString());
        return;
    }

    if (!GetPlayer()->IsWithinDistInMap(player, INSPECT_DISTANCE, false))
    {
        return;
    }

    if (GetPlayer()->IsValidAttackTarget(player))
    {
        return;
    }

    WorldPacket data(MSG_INSPECT_HONOR_STATS, 8 + 1 + 4 * 4);
    data << player->GetGUID();
    data << uint8(player->GetHonorPoints());
    data << uint32(player->GetUInt32Value(PLAYER_FIELD_KILLS));
    data << uint32(player->GetUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION));
    data << uint32(player->GetUInt32Value(PLAYER_FIELD_YESTERDAY_CONTRIBUTION));
    data << uint32(player->GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS));
    Send(&data);
}

void User::HandleComplainOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "WORLD: CMSG_COMPLAIN");

    uint8 spam_type;                                        // 0 - mail, 1 - chat
    ObjectGuid spammer_guid;
    uint32 unk1 = 0;
    uint32 unk2 = 0;
    uint32 unk3 = 0;
    uint32 unk4 = 0;
    std::string description = "";
    recv_data >> spam_type;                                 // unk 0x01 const, may be spam type (mail/chat)
    recv_data >> spammer_guid;                              // player guid
    switch (spam_type)
    {
        case 0:
            recv_data >> unk1;                              // const 0
            recv_data >> unk2;                              // probably mail id
            recv_data >> unk3;                              // const 0
            break;
        case 1:
            recv_data >> unk1;                              // probably language
            recv_data >> unk2;                              // message type?
            recv_data >> unk3;                              // probably channel id
            recv_data >> unk4;                              // unk random value
            recv_data >> description;                       // spam description string (messagetype, channel name, player name, message)
            break;
    }

    // NOTE: all chat messages from this spammer automatically ignored by spam reporter until logout in case chat spam.
    // if it's mail spam - ALL mails from this spammer automatically removed by client

    // Complaint Received message
    WorldPacket data(SMSG_COMPLAIN_RESULT, 1);
    data << uint8(0);
    Send(&data);

    LOG_DEBUG("network", "REPORT SPAM: type {}, {}, unk1 {}, unk2 {}, unk3 {}, unk4 {}, message {}",
        spam_type, spammer_guid.ToString(), unk1, unk2, unk3, unk4, description);
}

void User::HandleRealmSplitOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "CMSG_REALM_SPLIT");

    uint32 unk;
    std::string split_date = "01/01/01";
    recv_data >> unk;

    WorldPacket data(SMSG_REALM_SPLIT, 4 + 4 + split_date.size() + 1);
    data << unk;
    data << uint32(0x00000000);                             // realm split state
    // split states:
    // 0x0 realm normal
    // 0x1 realm split
    // 0x2 realm split pending
    data << split_date;
    Send(&data);
}

void User::HandleFarSightOpcode(WorldPacket& recvData)
{
    LOG_DEBUG("network", "WORLD: CMSG_FAR_SIGHT");

    bool apply;
    recvData >> apply;

    if (apply)
    {
        LOG_DEBUG("network", "Added FarSight {} to player {}", m_player->GetGuidValue(PLAYER_FARSIGHT).ToString(), m_player->GetGUID().ToString());
        if (WorldObject* target = m_player->GetViewpoint())
            m_player->SetSeer(target);
        else
            LOG_DEBUG("network.opcode", "Player {} requests non-existing seer {}", m_player->GetName(), m_player->GetGuidValue(PLAYER_FARSIGHT).ToString());
    }
    else
    {
        WorldObject* newFarsightobject = nullptr;
        if (WorldObject* viewpoint = m_player->GetViewpoint())
        {
            if (DynamicObject* viewpointDynamicObject = viewpoint->ToDynObject())
            {
                newFarsightobject = ObjectAccessor::GetUnit(*viewpointDynamicObject, viewpointDynamicObject->GetOldFarsightGUID());
            }
            else if (DynamicObject* viewpointDynamicObject = m_player->GetDynObject(m_player->GetUInt32Value(UNIT_CHANNEL_SPELL)))
            {
                if (viewpointDynamicObject->IsViewpoint() && viewpointDynamicObject->GetCasterGUID() == m_player->GetGUID())
                {
                    newFarsightobject = viewpointDynamicObject;
                }
            }
        }

        if (newFarsightobject)
        {
            LOG_DEBUG("network", "Player {} set vision to old farsight {}", m_player->GetGUID().ToString(), newFarsightobject->GetGUID().ToString());
            m_player->SetViewpoint(m_player->GetViewpoint(), false);
            m_player->SetViewpoint(newFarsightobject, true);
        }
        else
        {
            LOG_DEBUG("network", "Player {} set vision to self", m_player->GetGUID().ToString());
            m_player->SetSeer(m_player);
        }
    }

    GetPlayer()->UpdateVisibilityForPlayer();
}

void User::HandleSetTitleOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "CMSG_SET_TITLE");

    int32 title;
    recv_data >> title;

    // -1 at none
    if (title > 0 && title < MAX_TITLE_INDEX)
    {
        if (!GetPlayer()->HasTitle(title))
            return;
    }
    else
        title = 0;

    GetPlayer()->SetUInt32Value(PLAYER_CHOSEN_TITLE, title);
}

void User::HandleResetInstancesOpcode(WorldPacket& /*recv_data*/)
{
    LOG_DEBUG("network", "WORLD: CMSG_RESET_INSTANCES");

    if (Group* group = m_player->GetGroup())
    {
        if (group->IsLeader(m_player->GetGUID()))
            group->ResetInstances(INSTANCE_RESET_ALL, false, m_player);
    }
    else
        Player::ResetInstances(m_player->GetGUID(), INSTANCE_RESET_ALL, false);
}

void User::HandleSetDungeonDifficultyOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "MSG_SET_DUNGEON_DIFFICULTY");

    uint32 mode;
    recv_data >> mode;

    if (mode >= MAX_DUNGEON_DIFFICULTY)
        return;

    if (Difficulty(mode) == m_player->GetDungeonDifficulty())
        return;

    Group* group = m_player->GetGroup();
    if (group)
    {
        if (group->IsLeader(m_player->GetGUID()))
        {
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* groupGuy = itr->GetSource();
                if (!groupGuy)
                    continue;

                if (!groupGuy->IsInWorld())
                {
                    m_player->SendDungeonDifficulty(group != nullptr);
                    return;
                }

                if (groupGuy->GetGUID() == m_player->GetGUID() ? groupGuy->GetMap()->IsDungeon() : groupGuy->GetMap()->IsNonRaidDungeon())
                {
                    m_player->SendDungeonDifficulty(group != nullptr);
                    return;
                }
            }

            group->ResetInstances(INSTANCE_RESET_CHANGE_DIFFICULTY, false, m_player);
            group->SetDungeonDifficulty(Difficulty(mode));
        }
    }
    else
    {
        if (m_player->FindMap() && m_player->FindMap()->IsDungeon())
        {
            m_player->SendDungeonDifficulty(group != nullptr);
            return;
        }
        Player::ResetInstances(m_player->GetGUID(), INSTANCE_RESET_CHANGE_DIFFICULTY, false);
        m_player->SetDungeonDifficulty(Difficulty(mode));
    }
}

void User::HandleSetRaidDifficultyOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "MSG_SET_RAID_DIFFICULTY");

    uint32 mode;
    recv_data >> mode;

    if (mode >= MAX_RAID_DIFFICULTY)
        return;

    if (Difficulty(mode) == m_player->GetRaidDifficulty())
        return;

    Group* group = m_player->GetGroup();
    if (group)
    {
        if (group->IsLeader(m_player->GetGUID()))
        {
            std::set<uint32> foundMaps;
            std::set<Map*> foundMapsPtr;
            Map* currMap = nullptr;

            if (uint32 preventionTime = group->GetDifficultyChangePreventionTime())
            {
                switch (group->GetDifficultyChangePreventionReason())
                {
                    case DIFFICULTY_PREVENTION_CHANGE_BOSS_KILLED:
                        ChatHandler(this).PSendSysMessage("Raid was in combat recently and may not change difficulty again for %u sec.", preventionTime);
                        break;
                    case DIFFICULTY_PREVENTION_CHANGE_RECENTLY_CHANGED:
                    default:
                        ChatHandler(this).PSendSysMessage("Raid difficulty has changed recently, and may not change again for %u sec.", preventionTime);
                        break;
                }

                m_player->SendRaidDifficulty(group != nullptr);
                return;
            }

            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* groupGuy = itr->GetSource();
                if (!groupGuy)
                    continue;

                if (!groupGuy->IsInWorld())
                {
                    m_player->SendRaidDifficulty(group != nullptr);
                    return;
                }

                if (IsSharedDifficultyMap(groupGuy->GetMap()->GetId()) && (uint32(mode % 2) == uint32(m_player->GetRaidDifficulty() % 2)) && group->isRaidGroup())
                {
                    if (!currMap)
                        currMap = groupGuy->GetMap();
                    foundMaps.insert(groupGuy->GetMap()->GetId());
                    foundMapsPtr.insert(groupGuy->GetMap());
                    if (foundMaps.size() > 1 || foundMapsPtr.size() > 1)
                    {
                        m_player->SendRaidDifficulty(group != nullptr);
                        return;
                    }

                    if (!groupGuy->IsAlive() || groupGuy->IsInCombat() || groupGuy->GetVictim() || groupGuy->m_mover != groupGuy || groupGuy->IsNonMeleeSpellCast(true) || (!groupGuy->GetMotionMaster()->empty() && groupGuy->GetMotionMaster()->GetCurrentMovementGeneratorType() != IDLE_MOTION_TYPE)
                            || !groupGuy->movespline->Finalized() || !groupGuy->GetMap()->ToInstanceMap() || !groupGuy->GetMap()->ToInstanceMap()->GetInstanceScript() || groupGuy->GetMap()->ToInstanceMap()->GetInstanceScript()->IsEncounterInProgress()
                            || !groupGuy->Satisfy(sObjectMgr->GetAccessRequirement(groupGuy->GetMap()->GetId(), Difficulty(mode)), groupGuy->GetMap()->GetId(), false))
                    {
                        m_player->SendRaidDifficulty(group != nullptr);
                        return;
                    }
                }
                else if (groupGuy->GetGUID() == m_player->GetGUID() ? groupGuy->GetMap()->IsDungeon() : groupGuy->GetMap()->IsRaid())
                {
                    m_player->SendRaidDifficulty(group != nullptr);
                    return;
                }
            }

            Map* homeMap571 = sMapMgr->CreateMap(571, nullptr);
            Map* homeMap0 = sMapMgr->CreateMap(0, nullptr);
            ASSERT(homeMap0 && homeMap571);

            std::map<Player*, Position> playerTeleport;
            // handle here all players in the instance that are not in the group
            if (currMap)
                for (Map::PlayerList::const_iterator itr = currMap->GetPlayers().begin(); itr != currMap->GetPlayers().end(); ++itr)
                    if (Player* p = itr->GetSource())
                        if (p->GetGroup() != group)
                        {
                            if (!p->IsInWorld() || !p->IsAlive() || p->IsInCombat() || p->GetVictim() || p->m_mover != p || p->IsNonMeleeSpellCast(true) || (!p->GetMotionMaster()->empty() && p->GetMotionMaster()->GetCurrentMovementGeneratorType() != IDLE_MOTION_TYPE)
                                    || !p->movespline->Finalized() || !p->GetMap()->ToInstanceMap() || !p->GetMap()->ToInstanceMap()->GetInstanceScript() || p->GetMap()->ToInstanceMap()->GetInstanceScript()->IsEncounterInProgress())
                            {
                                m_player->SendRaidDifficulty(group != nullptr);
                                return;
                            }
                            playerTeleport[p];
                        }
            for (std::map<Player*, Position>::iterator itr = playerTeleport.begin(); itr != playerTeleport.end(); ++itr)
            {
                Player* p = itr->first;
                Map* oldMap = p->GetMap();
                oldMap->RemovePlayerFromMap(p, false);
                p->ResetMap();
                oldMap->AfterPlayerUnlinkFromMap();
                p->SetMap(homeMap0);
                p->Relocate(0.0f, 0.0f, 0.0f, 0.0f);
                if (!p->Teleport(571, 5790.20f, 2071.36f, 636.07f, 3.60f))
                    p->User()->KickPlayer("HandleSetRaidDifficultyOpcode 1");
            }

            bool anyoneInside = false;
            playerTeleport.clear();
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* groupGuy = itr->GetSource();
                if (!groupGuy)
                    continue;

                if (IsSharedDifficultyMap(groupGuy->GetMap()->GetId()))
                {
                    anyoneInside = true;

                    float x, y, z, o;
                    groupGuy->GetPosition(x, y, z, o);
                    Map* oldMap = groupGuy->GetMap();
                    oldMap->RemovePlayerFromMap(groupGuy, false);
                    groupGuy->ResetMap();
                    oldMap->AfterPlayerUnlinkFromMap();
                    groupGuy->SetMap(homeMap571);
                    groupGuy->Relocate(5790.20f, 2071.36f, 636.07f, 3.60f);
                    Position dest = {x, y, z + 0.1f, o};
                    playerTeleport[groupGuy] = dest;
                }
            }

            if (!anyoneInside) // pussywizard: don't reset if changing ICC/RS difficulty while inside
                group->ResetInstances(INSTANCE_RESET_CHANGE_DIFFICULTY, true, m_player);
            group->SetRaidDifficulty(Difficulty(mode));
            group->SetDifficultyChangePrevention(DIFFICULTY_PREVENTION_CHANGE_RECENTLY_CHANGED);

            for (std::map<Player*, Position>::iterator itr = playerTeleport.begin(); itr != playerTeleport.end(); ++itr)
            {
                itr->first->SetRaidDifficulty(Difficulty(mode)); // needed for teleport not to fail
                if (!itr->first->Teleport(*(foundMaps.begin()), itr->second.GetPositionX(), itr->second.GetPositionY(), itr->second.GetPositionZ(), itr->second.GetOrientation()))
                    itr->first->User()->KickPlayer("HandleSetRaidDifficultyOpcode 2");
            }
        }
    }
    else
    {
        if (m_player->FindMap() && m_player->FindMap()->IsDungeon())
        {
            m_player->SendRaidDifficulty(group != nullptr);
            return;
        }
        Player::ResetInstances(m_player->GetGUID(), INSTANCE_RESET_CHANGE_DIFFICULTY, true);
        m_player->SetRaidDifficulty(Difficulty(mode));
    }
}

void User::HandleCancelMountAuraOpcode(WorldPacket& /*recv_data*/)
{
    LOG_DEBUG("network", "WORLD: CMSG_CANCEL_MOUNT_AURA");

    //If player is not mounted, so go out :)
    if (!m_player->IsMounted())                              // not blizz like; no any messages on blizz
    {
        ChatHandler(this).SendSysMessage(LANG_CHAR_NON_MOUNTED);
        return;
    }

    if (m_player->IsOnTaxi())                               // not blizz like; no any messages on blizz
    {
        ChatHandler(this).SendSysMessage(LANG_YOU_IN_FLIGHT);
        return;
    }

    m_player->Dismount();
    m_player->RemoveAurasByType(SPELL_AURA_MOUNTED);
}

void User::HandleMoveSetCanFlyAckOpcode(WorldPacket& recv_data)
{
    // fly mode on/off
    LOG_DEBUG("network", "WORLD: CMSG_MOVE_SET_CAN_FLY_ACK");

    ObjectGuid guid;
    recv_data >> guid.ReadAsPacked();

    if (!m_player)
    {
        recv_data.rfinish(); // prevent warnings spam
        return;
    }

    recv_data.read_skip<uint32>();                          // unk

    CMovement movementInfo;
    movementInfo.guid = guid;
    ReadMovementInfo(recv_data, &movementInfo);

    recv_data.read_skip<float>();                           // unk2

    sScriptMgr->AnticheatSetCanFlybyServer(m_player, (movementInfo.m_moveFlags & MOVEFLAG_CAN_FLY) != 0);

    m_player->m_mover->m_movement.m_moveFlags = movementInfo.m_moveFlags;
}

void User::HandleRequestPetInfo(WorldPackets::Pet::RequestPetInfo& /*packet*/)
{
    /*
        LOG_DEBUG("network.opcode", "WORLD: CMSG_REQUEST_PET_INFO");
        recv_data.hexlike();
    */

    if (m_player->GetPet())
        m_player->PetSpellInitialize();
    else if (m_player->GetCharm())
        m_player->CharmSpellInitialize();
}

void User::HandleSetTaxiBenchmarkOpcode(WorldPacket& recv_data)
{
    uint8 mode;
    recv_data >> mode;

    mode ? m_player->SetPlayerFlag(PLAYER_FLAGS_TAXI_BENCHMARK) : m_player->RemovePlayerFlag(PLAYER_FLAGS_TAXI_BENCHMARK);

    LOG_DEBUG("network", "Client used \"/timetest {}\" command", mode);
}

void User::HandleQueryInspectAchievements(WorldPacket& recv_data)
{
    ObjectGuid guid;
    recv_data >> guid.ReadAsPacked();

    Player* player = ObjectAccessor::GetPlayer(*m_player, guid);
    if (!player)
    {
        return;
    }

    if (!GetPlayer()->IsWithinDistInMap(player, INSPECT_DISTANCE, false))
    {
        return;
    }

    if (GetPlayer()->IsValidAttackTarget(player))
    {
        return;
    }

    player->SendRespondInspectAchievements(m_player);
}

void User::HandleWorldStateUITimerUpdate(WorldPacket& /*recv_data*/)
{
    // empty opcode
    LOG_DEBUG("network", "WORLD: CMSG_WORLD_STATE_UI_TIMER_UPDATE");

    WorldPackets::Misc::UITime response;
    response.Time = GameTime::GetGameTime().count();
    Send(response.Write());
}

void User::HandleReadyForAccountDataTimes(WorldPacket& /*recv_data*/)
{
    // empty opcode
    LOG_DEBUG("network", "WORLD: CMSG_READY_FOR_ACCOUNT_DATA_TIMES");

    SendAccountDataTimes(GLOBAL_CACHE_MASK);
}

void User::SendSetPhaseShift(uint32 PhaseShift)
{
    WorldPacket data(SMSG_SET_PHASE_SHIFT, 4);
    data << uint32(PhaseShift);
    Send(&data);
}

//Battlefield and Battleground
void User::HandleAreaSpiritHealerQueryOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "WORLD: CMSG_AREA_SPIRIT_HEALER_QUERY");

    Battleground* bg = m_player->GetBattleground();

    ObjectGuid guid;
    recv_data >> guid;

    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->IsSpiritService())                            // it's not spirit service
        return;

    if (bg)
        sBattlegroundMgr->SendAreaSpiritHealerQueryOpcode(m_player, bg, guid);

    if (Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(m_player->GetZoneId()))
        bf->SendAreaSpiritHealerQueryOpcode(m_player, guid);
}

void User::HandleAreaSpiritHealerQueueOpcode(WorldPacket& recv_data)
{
    LOG_DEBUG("network", "WORLD: CMSG_AREA_SPIRIT_HEALER_QUEUE");

    Battleground* bg = m_player->GetBattleground();

    ObjectGuid guid;
    recv_data >> guid;

    Creature* unit = GetPlayer()->GetMap()->GetCreature(guid);
    if (!unit)
        return;

    if (!unit->IsSpiritService())                            // it's not spirit service
        return;

    if (bg)
        bg->AddPlayerToResurrectQueue(guid, m_player->GetGUID());

    if (Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(m_player->GetZoneId()))
        bf->AddPlayerToResurrectQueue(guid, m_player->GetGUID());
}

void User::HandleHearthAndResurrect(WorldPacket& /*recv_data*/)
{
    if (m_player->IsOnTaxi())
        return;

    if(Battlefield* bf = sBattlefieldMgr->GetBattlefieldToZoneId(m_player->GetZoneId()))
    {
        bf->PlayerAskToLeave(m_player);
        return;
    }

    AreaTableEntry const* atEntry = sAreaTableStore.LookupEntry(m_player->GetAreaId());
    if (!atEntry || !(atEntry->flags & AREA_FLAG_WINTERGRASP_2))
        return;

    m_player->BuildPlayerRepop();
    m_player->Resurrect(1.0f);
    m_player->SpawnCorpseBones();
    m_player->Teleport(m_player->m_homebindMapId, m_player->m_homebindX, m_player->m_homebindY, m_player->m_homebindZ, m_player->GetOrientation());
}

void User::HandleInstanceLockResponse(WorldPacket& recvPacket)
{
    uint8 accept;
    recvPacket >> accept;

    if (!m_player->HasPendingBind() || m_player->GetPendingBind() != m_player->GetInstanceId() || (m_player->GetGroup() && m_player->GetGroup()->isLFGGroup() && m_player->GetGroup()->IsLfgRandomInstance()))
    {
        LOG_DEBUG("network.opcode", "InstanceLockResponse: Player {} ({}) tried to bind himself/teleport to graveyard without a pending bind!",
            m_player->GetName(), m_player->GetGUID().ToString());
        return;
    }

    if (accept)
        m_player->BindToInstance();
    else
        m_player->RepopAtGraveyard();

    m_player->SetPendingBind(0, 0);
}

void User::HandleUpdateMissileTrajectory(WorldPacket& recvPacket)
{
    LOG_DEBUG("network", "WORLD: CMSG_UPDATE_MISSILE_TRAJECTORY");

    ObjectGuid guid;
    uint32 spellId;
    float elevation, speed;
    float curX, curY, curZ;
    float targetX, targetY, targetZ;
    uint8 moveStop;

    recvPacket >> guid >> spellId >> elevation >> speed;
    recvPacket >> curX >> curY >> curZ;
    recvPacket >> targetX >> targetY >> targetZ;
    recvPacket >> moveStop;

    Unit* caster = ObjectAccessor::GetUnit(*m_player, guid);
    Spell* spell = caster ? caster->GetCurrentSpell(CURRENT_GENERIC_SPELL) : nullptr;
    if (!spell || spell->m_spellInfo->Id != spellId || !spell->m_targets.HasDst() || !spell->m_targets.HasSrc())
    {
        recvPacket.rfinish();
        return;
    }

    Position pos = *spell->m_targets.GetSrcPos();
    pos.Relocate(curX, curY, curZ);
    spell->m_targets.ModSrc(pos);

    pos = *spell->m_targets.GetDstPos();
    pos.Relocate(targetX, targetY, targetZ);
    spell->m_targets.ModDst(pos);

    spell->m_targets.SetElevation(elevation);
    spell->m_targets.SetSpeed(speed);

    if (moveStop)
    {
        uint32 opcode;
        recvPacket >> opcode;
        recvPacket.SetOpcode(opcode);
        HandleMovementOpcodes(recvPacket);
    }
}

//===========================================================================
void User::BootMeHandler(WorldPacket& msg)
{
    if (!IsGMAccount()) {
        SendNotification(LANG_PERMISSION_DENIED);
        return;
    }
    m_sock->Disconnect();
}

//===========================================================================
void User::GmResurrectHandler(WorldPacket& msg)
{
    if (!IsGMAccount()) {
        SendNotification(LANG_PERMISSION_DENIED);
        return;
    }

    // READ THE MESSAGE DATA
    char name[256];
    msg.GetString(name, -1);

    FormatCharacterName(name);

    // LOOK FOR A PLAYER OBJECT IN THE WORLD THAT MATCHES THE NAME
    Player* playerPtr = ObjectAccessor::FindPlayerByName(name);
    if (!playerPtr) {
        SendPlayerNotFoundFailure();
        return;
    }

    // RESURRECT THE PLAYER
    if (playerPtr->IsAlive()) {
        SendGmResurrectFailure();
    }
    else {
        playerPtr->Resurrect(100.0f);
        SendGmResurrectSuccess();
    }
}
