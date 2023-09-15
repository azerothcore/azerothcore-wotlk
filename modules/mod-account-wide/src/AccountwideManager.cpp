#include "AccountwideManager.h"
#include "ReputationMgr.h"


void Accountwide::AddAWMount(Player* player, uint32 spellId)
{
    uint32 accountId = player->GetSession()->GetAccountId();

    auto& v = m_mounts[accountId];

    if (std::find(v.begin(), v.end(), spellId) == v.end())
    {
        v.push_back(spellId);
        CharacterDatabase.Query("INSERT IGNORE INTO character_accountwide_mount (accountId, spellId) VALUES ({}, {})", accountId, spellId);
    }
}

void Accountwide::applyAW(Player* player)
{
    Accountwide::ApplyTitles(player);
    Accountwide::ApplyMounts(player);
    Accountwide::ApplyReputations(player);
    Accountwide::ApplyTaxiNodes(player);
}

void Accountwide::Load()
{
    QueryResult result = CharacterDatabase.Query("SELECT * FROM character_accountwide_title");

    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 accountId = fields[0].Get<uint32>();
            uint32 titleId = fields[1].Get<uint32>();

            m_playerTitles[accountId].push_back(titleId);
        } while (result->NextRow());
    }

    result = CharacterDatabase.Query("SELECT * FROM character_accountwide_reputation");
    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 accountId = fields[0].Get<uint32>();
            uint32 factionGroup = fields[1].Get<uint32>();
            uint32 factionId = fields[2].Get<uint32>();
            uint32 value = fields[3].Get<uint32>();
            m_rep[accountId][factionGroup][factionId] = value;
        } while (result->NextRow());
    }

    result = CharacterDatabase.Query("SELECT * FROM character_accountwide_taxi");
    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 accountId = fields[0].Get<uint32>();
            uint32 faction = fields[1].Get<uint32>();
            uint32 node = fields[2].Get<uint32>();
            m_taxi[accountId][faction].push_back(node);
        } while (result->NextRow());
    }

    result = CharacterDatabase.Query("SELECT * FROM character_accountwide_mount");
    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 accountId = fields[0].Get<uint32>();
            uint32 spellId = fields[1].Get<uint32>();
            m_mounts[accountId].push_back(spellId);
        } while (result->NextRow());
    }

}

std::vector<uint32> Accountwide::GetTitles(uint32 accountId)
{
    auto f = m_playerTitles.find(accountId);

    if (f != m_playerTitles.end())
        return f->second;

    std::vector<uint32> titles;

    return titles;
}

std::unordered_map<uint32, std::unordered_map<uint32, uint32>> Accountwide::GetReputations(uint32 accountId)
{
    auto f = m_rep.find(accountId);

    if (f != m_rep.end())
        return f->second;

    std::unordered_map<uint32, std::unordered_map<uint32, uint32>> reputations;

    return reputations;
}

std::unordered_map<uint32, std::vector<uint32>> Accountwide::GetTaxisNodes(uint32 accountId)
{
    auto f = m_taxi.find(accountId);

    if (f != m_taxi.end())
        return f->second;

    std::unordered_map<uint32, std::vector<uint32>> nodes;
  
    return nodes;
}

std::vector<uint32> Accountwide::GetMounts(uint32 accountId)
{
    auto f = m_mounts.find(accountId);

    if (f != m_mounts.end())
        return f->second;

    std::vector<uint32> mounts;

    return mounts;
}

void Accountwide::ApplyTitles(Player* player)
{
    if (!player)
        return;

    uint32 accountId = player->GetSession()->GetAccountId();
    std::vector<uint32> titles = Accountwide::GetTitles(accountId);

    if (titles.size() == 0)
        return;

    for (const auto& titleId : titles)
    {
        CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(titleId);
        player->SetTitle(titleInfo);
    }
}

void Accountwide::ApplyReputations(Player* player)
{
    if (!player)
        return;

    uint32 accountId = player->GetSession()->GetAccountId();
    std::unordered_map<uint32, std::unordered_map<uint32, uint32>> reputations = Accountwide::GetReputations(accountId);

    if (reputations.size() == 0)
        return;

    auto trans = CharacterDatabase.BeginTransaction();

    for (const auto& ft : reputations)
    {
        if (ft.first == player->TeamIdForRace(player->getRace()))
        {
            for (auto& it : ft.second)
            {
                uint32 value = it.second;
                    uint32 factionId = it.first;
                    FactionEntry const* factionEntry = sFactionStore.LookupEntry(factionId);

                    if (factionEntry) {
                       auto rank = player->GetReputationMgr().GetReputation(factionEntry);
      
                       if (value > rank)
                            player->GetReputationMgr().SetOneFactionReputation(factionEntry, value, false);
                       else if (value != rank)// new character could have higher faction.
                       {
                           // trans->Append("INSERT INTO character_accountwide_reputation(`accountId`,`factionGroup`,`factionId`,`rep`) VALUES({}, {}, {}, {}) ON DUPLICATE KEY UPDATE rep = {}",
                           //     player->GetSession()->GetAccountId(), player->TeamIdForRace(player->getRace()), factionId, rank, rank);
                       }
                    }
            }
        }
    }

    if (trans->GetSize() > 0)
        CharacterDatabase.CommitTransaction(trans);

    player->GetReputationMgr().SendStates();
}

void Accountwide::ApplyTaxiNodes(Player* player)
{
    if (!player)
        return;

    uint32 accountId = player->GetSession()->GetAccountId();
    std::unordered_map<uint32, std::vector<uint32>> nodes = Accountwide::GetTaxisNodes(accountId);

    if (nodes.size() == 0)
        return;

    for (const auto& node : nodes)
    {
        if (node.first == player->TeamIdForRace(player->getRace()))
            for (const auto& s : node.second)
                player->m_taxi.SetTaximaskNode(s);
    }
}

void Accountwide::ApplyMounts(Player* player)
{
    if (!player)
        return;

    uint32 accountId = player->GetSession()->GetAccountId();
    std::vector<uint32> mounts = Accountwide::GetMounts(accountId);

    if (mounts.size() == 0)
        return;

    int count = 0;

    for (const auto& spellId : mounts)
        if (!player->HasSpell(spellId)) {
             player->learnSpell(spellId, false, false);
             count++;
        }

    if (count > 0)
        player->SendInitialSpells();
}

