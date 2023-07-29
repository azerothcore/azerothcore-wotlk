#pragma once
#include "ScriptMgr.h"
#include "Chat.h"
#include "DBCStores.h"
#include "Language.h"
#include "Player.h"
#include "WorldSession.h"
#include "DatabaseEnv.h"
#include "ReputationMgr.h"
#include <unordered_map>

class Accountwide {

public:
    void AddAWMount(Player* player, uint32 spellId);
    void applyAW(Player* player);
    void Load();

    std::vector<uint32> GetTitles(uint32 accountId);
    std::unordered_map<uint32, std::unordered_map<uint32, uint32>> GetReputations(uint32 accountId);
    std::unordered_map<uint32, std::vector<uint32>> GetTaxisNodes(uint32 accountId);
    std::vector<uint32> GetMounts(uint32 accountId);

    void ApplyTitles(Player* player);
    void ApplyReputations(Player* player);
    void ApplyTaxiNodes(Player* player);
    void ApplyMounts(Player* player);

    std::unordered_map<uint32, std::vector<uint32>> m_playerTitles;
    std::unordered_map<uint32, std::unordered_map<uint32, std::unordered_map<uint32, uint32>>> m_rep;
    std::unordered_map<uint32, std::unordered_map<uint32, std::vector<uint32>>> m_taxi;
    std::unordered_map<uint32, std::vector<uint32>> m_mounts;

};
