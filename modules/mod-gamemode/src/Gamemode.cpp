#include "Gamemode.h"
#include <ForgeCache.cpp>

std::unordered_map<uint32 /*guid*/, std::vector<GameModeType> /*level*/> Gamemode::PlayersMode = {};
std::unordered_map<GameModeType, std::vector<GameModeReward*>> Gamemode::Rewards = {};
std::vector<GameModeType> Gamemode::GameModeTypes = {
    GameModeType::BLOOD_THIRSTY,
    GameModeType::CLASSIC,
    GameModeType::HARDCORE,
    GameModeType::INSANE,
    GameModeType::IRON_MAN
};

void Gamemode::PreloadAllModesPlayers()
{
    QueryResult result = CharacterDatabase.Query("SELECT * FROM character_modes WHERE done = 0");
    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 guid = fields[0].Get<uint32>();
            uint32 id = fields[1].Get<uint32>();
            Gamemode::PlayersMode[guid].push_back((GameModeType)id);
        } while (result->NextRow());
    }

    result = WorldDatabase.Query("SELECT * FROM character_modes_rewards");
    if (result) {
        do
        {
            Field* fields = result->Fetch();
            uint32 mode = fields[0].Get<uint32>();
            uint32 rewardType = fields[1].Get<uint32>();
            uint32 id = fields[2].Get<uint32>();
            auto* gm = new GameModeReward();
            gm->Entry = id;
            gm->RewardType = (GameModeRewardType)rewardType;
            Gamemode::Rewards[(GameModeType)mode].push_back(gm);
        } while (result->NextRow());
    }

    LOG_INFO("server.loading", "Loaded {} gamemode...", Gamemode::PlayersMode.size());
}

void Gamemode::SetGameMode(Player* player, std::vector<GameModeType> gamemodeIds)
{
    if (player->getLevel() > 1)
        return;

    auto transc = CharacterDatabase.BeginTransaction();

    for (auto gamemodeId : gamemodeIds)
    {
        PlayersMode[player->GetGUID().GetCounter()].push_back(gamemodeId);
        transc->Append("INSERT INTO character_modes VALUES  ({}, {}, {})", player->GetGUID().GetCounter(), (uint32)gamemodeId, 0);
        player->AddAura((uint32)gamemodeId, player);
    }

    CharacterDatabase.CommitTransaction(transc);


    if (Group* group = player->GetGroup())
        group->RemoveMember(player->GetGUID());

    sForgeCache->ApplyAccountBoundTalents(player);
}

void Gamemode::OnDeath(Player* player, Creature* killer)
{
    if (!player)
        return;

    if (HasGameMode(player, GameModeType::HARDCORE)) {
        const char* variants[4] = { "annihilated", "assassinated", "blow away", "destroyed" };
        std::string level = std::to_string(player->getLevel());
        auto modeIds = GetGameMode(player);
        std::string mode = "";

        if (modeIds.size() != 5)
        {
            for (auto modeId : modeIds)
                AddModeName(modeId, mode);
        }
        else
        {
            mode = "all challange modes";
        }

        sWorld->SendWorldText(1910002, player->GetName().c_str(), variants[urand(0, 3)], killer->GetName().c_str(), level.c_str(), mode.c_str()); // %s has been %s by %s at level %s attempting to complete the challenge(s) %s!
    }
}

void Gamemode::RemoveGamemode(Player* player, bool remove)
{
    auto id = player->GetGUID().GetCounter();
    auto it = PlayersMode.find(id);
    if (it != PlayersMode.end()) {
        auto transc = CharacterDatabase.BeginTransaction();

        for (auto m : it->second)
        {
            if (remove) {
                transc->Append("DELETE FROM character_modes WHERE guid = {} AND mode = {}", id, (uint32)it->first);
            }
            else {
                transc->Append("UPDATE character_modes SET done = 1 WHERE guid = {} AND mode = {}", id, (uint32)it->first);
            }

            player->RemoveAura((uint32)m);
        }

        PlayersMode.erase(it);
        CharacterDatabase.CommitTransaction(transc);
    }
}

bool Gamemode::CanAddGroupPlayer(Player* player, Player* invitingPlayer)
{
    if (!player)
        return false;

    if (!invitingPlayer)
        return false;

    if (HasGameMode(player, GameModeType::IRON_MAN))
        return false;

    if (HasGameMode(invitingPlayer, GameModeType::IRON_MAN))
         return false;

    if ((HasGameMode(player, GameModeType::HARDCORE) && !HasGameMode(invitingPlayer, GameModeType::HARDCORE)) || (!HasGameMode(player, GameModeType::HARDCORE) && HasGameMode(invitingPlayer, GameModeType::HARDCORE)))
        return false;

    return true;
}

bool Gamemode::CanSendMail(Player* player)
{
    if (HasGameMode(player, GameModeType::IRON_MAN))
        return false;

    return true;
}

bool Gamemode::CanSendMail(uint32 player)
{
    if (HasGameMode(player, GameModeType::IRON_MAN))
        return false;

    return true;
}

void Gamemode::OnLevelUp(Player* player)
{
    if (!player)
        return;

    if (player->getLevel() < 80)
        return;

    auto modeIds= GetGameMode(player);
  
    if (modeIds.size() == 0)
        return;

    std::string mode = "";

    for (auto modeId : modeIds)
    {
        AddModeName(modeId, mode);
        IssueRewards(player, modeId);
    }

    QueryResult result = CharacterDatabase.Query("SELECT TIMESTAMPDIFF(SECOND, character_modes.createdAt, NOW()) as secondes FROM character_modes WHERE guid = {} LIMIT 1", player->GetGUID().GetCounter());

    if (!result)
        return;

    if (result)
    {
        Field* fields = result->Fetch();
        uint32 time = fields[0].Get<uint32>();
        time_t seconds(time);
        tm* p = gmtime(&seconds);
        std::ostringstream ss;
        ss << p->tm_yday << " days, " << p->tm_hour << " hours, " << p->tm_min << " minutes, " << p->tm_sec << " seconds."; // %s has completed challenge(s) %s in %s!
        sWorld->SendWorldText(1910000, player->GetName().c_str(), mode.c_str(), ss.str().c_str());
    }


    if (modeIds.size() == 5)
    {
        IssueRewards(player, GameModeType::ALL);
        sWorld->SendWorldText(1910001, player->GetName().c_str());
    }

    RemoveGamemode(player, false);
}

void Gamemode::IssueRewards(Player* player, GameModeType mode)
{
    auto endItt = Rewards.find(mode);

    if (endItt != Rewards.end())
    {
        for (auto* reward : endItt->second)
        {
            switch (reward->RewardType)
            {
            case GameModeRewardType::Title:
            {
                CharTitlesEntry const* titleInfo = sCharTitlesStore.LookupEntry(reward->Entry);
                player->SetTitle(titleInfo);
            }
                break;
            case GameModeRewardType::Mount:
            {
                player->learnSpell(reward->Entry);
            }
                break;
            case GameModeRewardType::Item:
            {
                MailSender sender(MAIL_CREATURE, 34337 /* The Postmaster */);
                std::string modeName = "Congrats on completing ";
                AddModeName(mode, modeName);
                modeName += " game mode!";
                MailDraft* draft = new MailDraft("Game Mode Complete!", modeName);

                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

                if (Item* item = Item::CreateItem(reward->Entry, 1, 0))
                    draft->AddItem(item);

                draft->SendMailTo(trans, MailReceiver(player), sender);

                CharacterDatabase.CommitTransaction(trans);
            }
                break;
            }
        }
    }
}

void Gamemode::AddModeName(const GameModeType& modeId, std::string& mode)
{
    switch (modeId)
    {
    case GameModeType::HARDCORE:
        mode += "Hardcore, ";
        break;
    case GameModeType::IRON_MAN:
        mode += "Iron Man, ";
        break;
    case GameModeType::BLOOD_THIRSTY:
        mode += "Bloodthirsty, ";
        break;
    case GameModeType::CLASSIC:
        mode += "Classic, ";
        break;
    case GameModeType::INSANE:
        mode += "Insane, ";
        break;
    }
}

bool Gamemode::CanJoinRDF(Player* player)
{
    if (HasGameMode(player, GameModeType::BLOOD_THIRSTY) || HasGameMode(player, GameModeType::IRON_MAN))
        return false;

    return true;
}

bool Gamemode::CanTrade(Player* player)
{
    if (HasGameMode(player, GameModeType::IRON_MAN))
        return false;

    return true;
}

bool Gamemode::CanAddQuest(Player* player)
{
    if (HasGameMode(player, GameModeType::BLOOD_THIRSTY))
        return false;

    return true;
}

bool Gamemode::HasGameMode(Player* player, GameModeType gamemodeId)
{
    return HasGameMode(player->GetGUID().GetCounter(), gamemodeId);
}

bool Gamemode::HasGameMode(uint32 player, GameModeType gamemodeId)
{
    auto it = PlayersMode.find(player);
    if (it != PlayersMode.end())
        return std::find(it->second.begin(), it->second.end(), gamemodeId) != it->second.end();

    return false;
}

std::vector<GameModeType> Gamemode::GetGameMode(Player* player)
{
    return GetGameMode(player->GetGUID().GetCounter());
}

std::vector<GameModeType> Gamemode::GetGameMode(uint32 player)
{
    auto it = PlayersMode.find(player);
    if (it != PlayersMode.end())
        return it->second;

    return std::vector<GameModeType>();
}

