#ifndef MODULE_DUNGEONRESPAWN_H
#define MODULE_DUNGEONRESPAWN_H

#include "ScriptMgr.h"
#include "LFGMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include <vector>

struct DungeonData
{
    int32 map;
    float x;
    float y;
    float z;
    float o;
};

struct PlayerRespawnData
{
    ObjectGuid guid;
    DungeonData dungeon;
    bool isTeleportingNewMap;
    bool inDungeon;
};

std::vector<PlayerRespawnData> respawnData;

bool drEnabled;
float respawnHpPct;

class DSPlayerScript : public PlayerScript
{
public:
    DSPlayerScript() : PlayerScript("DSPlayerScript") { }

private:
    std::vector<ObjectGuid> playersToTeleport;
    bool IsInsideDungeonRaid(Player* /*player*/);
    void ResurrectPlayer(Player* /*player*/);
    PlayerRespawnData* GetOrCreateRespawnData(Player* /*player*/);
    void CreateRespawnData(Player* /*player*/);
    void OnPlayerReleasedGhost(Player* /*player*/) override;
    bool OnBeforeTeleport(Player* /*player*/, uint32 /*mapid*/, float /*x*/, float /*y*/, float /*z*/, float /*orientation*/, uint32 /*options*/, Unit* /*target*/) override;
    void OnMapChanged(Player* /*player*/) override;
    void OnLogin(Player* /*player*/) override;
    void OnLogout(Player* /*player*/) override;
};

class DSWorldScript : public WorldScript
{
public:
    DSWorldScript() : WorldScript("DSWorldScript") { }

private:
    void OnAfterConfigLoad(bool /*reload*/) override;
    void OnShutdown() override;
    void SaveRespawnData();
};

#endif //MODULE_DUNGEONRESPAWN_H
