#include "DungeonRespawn.h"

bool DSPlayerScript::IsInsideDungeonRaid(Player* player)
{
    if (!player)
    {
        return false;
    }

    Map* map = player->GetMap();
    if (!map)
    {
        return false;
    }

    if (!map->IsDungeon() && !map->IsRaid())
    {
        return false;
    }

    return true;
}
void DSPlayerScript::OnPlayerReleasedGhost(Player* player)
{
    if (!drEnabled)
    {
        return;
    }

    if (!IsInsideDungeonRaid(player))
    {
        return;
    }

    playersToTeleport.push_back(player->GetGUID());
}

void DSPlayerScript::ResurrectPlayer(Player* player)
{
    player->ResurrectPlayer(respawnHpPct / 100.0f, false);
    player->SpawnCorpseBones();
}

bool DSPlayerScript::OnBeforeTeleport(Player* player, uint32 mapid, float /*x*/, float /*y*/, float /*z*/, float /*orientation*/, uint32 /*options*/, Unit* /*target*/)
{
    if (!drEnabled)
    {
        return true;
    }

    if (!player)
    {
        return true;
    }

    if (player->GetMapId() != mapid)
    {
        auto prData = GetOrCreateRespawnData(player);
        prData->isTeleportingNewMap = true;
    }

    if (!IsInsideDungeonRaid(player))
    {
        return true;
    }

    if (!player->isDead())
    {
        return true;
    }

    GuidVector::iterator itToRemove;
    bool canRestore = false;

    for (auto it = playersToTeleport.begin(); it != playersToTeleport.end(); ++it)
    {
        if (*it == player->GetGUID())
        {
            itToRemove = it;
            canRestore = true;
            break;
        }
    }

    if (!canRestore)
    {
        return true;
    }

    playersToTeleport.erase(itToRemove);

    auto prData = GetOrCreateRespawnData(player);
    if (prData)
    {
        //Invalid Player Restore data, use default behaviour.
        if (prData->dungeon.map == -1)
        {
            return true;
        }

        if (prData->dungeon.map != int32(player->GetMapId()))
        {
            return true;
        }

        player->TeleportTo(prData->dungeon.map, prData->dungeon.x, prData->dungeon.y, prData->dungeon.z, prData->dungeon.o);
        ResurrectPlayer(player);
        return false;
    }

    return true;
}

void DSWorldScript::OnAfterConfigLoad(bool reload)
{
    if (reload)
    {
        SaveRespawnData();
        respawnData.clear();
    }

    drEnabled = sConfigMgr->GetOption<bool>("DungeonRespawn.Enable", false);
    respawnHpPct = sConfigMgr->GetOption<float>("DungeonRespawn.RespawnHealthPct", 50.0f);

    QueryResult qResult = CharacterDatabase.Query("SELECT `guid`, `map`, `x`, `y`, `z`, `o` FROM `dungeonrespawn_playerinfo`");

    if (qResult)
    {
        uint32 dataCount = 0;

        do
        {
            Field* fields = qResult->Fetch();

            PlayerRespawnData prData;
            DungeonData dData;
            prData.guid = ObjectGuid(fields[0].Get<uint64>());
            dData.map = fields[1].Get<int32>();
            dData.x = fields[2].Get<float>();
            dData.y = fields[3].Get<float>();
            dData.z = fields[4].Get<float>();
            dData.o = fields[5].Get<float>();
            prData.dungeon = dData;
            prData.isTeleportingNewMap = false;
            prData.inDungeon = false;

            respawnData.push_back(prData);

            dataCount++;
        } while (qResult->NextRow());

        LOG_INFO("module", "Loaded '{}' rows from 'dungeonrespawn_playerinfo' table.", dataCount);
    }
    else
    {
        LOG_INFO("module", "Loaded '0' rows from 'dungeonrespawn_playerinfo' table.");
        return;
    }
}

void DSWorldScript::OnShutdown()
{
    SaveRespawnData();
}

void DSWorldScript::SaveRespawnData()
{
    for (const auto& prData : respawnData)
    {
        if (prData.inDungeon)
        {
            CharacterDatabase.Execute("INSERT INTO `dungeonrespawn_playerinfo` (guid, map, x, y, z, o) VALUES ({}, {}, {}, {}, {}, {}) ON DUPLICATE KEY UPDATE map={}, x={}, y={}, z={}, o={}",
                prData.guid.GetRawValue(),
                prData.dungeon.map,
                prData.dungeon.x,
                prData.dungeon.y,
                prData.dungeon.z,
                prData.dungeon.o,
                prData.dungeon.map,
                prData.dungeon.x,
                prData.dungeon.y,
                prData.dungeon.z,
                prData.dungeon.o);
        }
        else
        {
            CharacterDatabase.Execute("DELETE FROM `dungeonrespawn_playerinfo` WHERE guid = {}", prData.guid.GetRawValue());
        }
    }
}

PlayerRespawnData* DSPlayerScript::GetOrCreateRespawnData(Player* player)
{
    for (auto it = respawnData.begin(); it != respawnData.end(); ++it)
    {
        if (it != respawnData.end())
        {
            if (player->GetGUID() == it->guid)
            {
                return &(*it);
            }
        }
    }

    CreateRespawnData(player);

    return GetOrCreateRespawnData(player);
}

void DSPlayerScript::OnMapChanged(Player* player)
{
    if (!player)
    {
        return;
    }

    auto prData = GetOrCreateRespawnData(player);

    if (!prData)
    {
        return;
    }

    bool inDungeon = IsInsideDungeonRaid(player);
    prData->inDungeon = inDungeon;

    if (!inDungeon)
    {
        return;
    }

    if (!prData->isTeleportingNewMap)
    {
        return;
    }

    prData->dungeon.map = player->GetMapId();
    prData->dungeon.x = player->GetPositionX();
    prData->dungeon.y = player->GetPositionY();
    prData->dungeon.z = player->GetPositionZ();
    prData->dungeon.o = player->GetOrientation();

    prData->isTeleportingNewMap = false;
}

void DSPlayerScript::CreateRespawnData(Player* player)
{
    DungeonData newDData;
    newDData.map = -1;
    newDData.x = 0;
    newDData.y = 0;
    newDData.z = 0;
    newDData.o = 0;

    PlayerRespawnData newPrData;
    newPrData.dungeon = newDData;
    newPrData.guid = player->GetGUID();
    newPrData.isTeleportingNewMap = false;
    newPrData.inDungeon = false;
    
    respawnData.push_back(newPrData);
}

void DSPlayerScript::OnLogin(Player* player)
{
    if (!player)
    {
        return;
    }

    GetOrCreateRespawnData(player);
}

void DSPlayerScript::OnLogout(Player* player)
{
    if (!player)
    {
        return;
    }

    for (auto it = playersToTeleport.begin(); it < playersToTeleport.end(); ++it)
    {
        if (player->GetGUID() == (*it))
        {
            playersToTeleport.erase(it);
        }
    }
}

void SC_AddDungeonRespawnScripts()
{
    new DSWorldScript();
    new DSPlayerScript();
}
