#include "Config.h"
#include "LootBoxWorld.h"

bool LootBoxWorld::Enabled;

int LootBoxWorld::StackSize;

float LootBoxWorld::FiveStarRate;
float LootBoxWorld::FourStarRate;

int LootBoxWorld::PromotionalGuarantee;
int LootBoxWorld::FiveStarGuarantee;
int LootBoxWorld::FeaturedGuarantee;
int LootBoxWorld::FourStarGuarantee;

int LootBoxWorld::NPC;
int LootBoxWorld::Box;

std::vector<int> LootBoxWorld::Promotions;
std::vector<int> LootBoxWorld::Features;
std::vector<int> LootBoxWorld::FiveStars;
std::vector<int> LootBoxWorld::FourStars;
std::vector<int> LootBoxWorld::ThreeStars;

int LootBoxWorld::CustomCurrency;
int LootBoxWorld::DailyReward;
int LootBoxWorld::ResetTimeHour;
int LootBoxWorld::LevelReward;
int LootBoxWorld::KillReward;

void loadItems(std::vector<int> &items, std::string ids)
{
    std::stringstream ss(ids);

    for (int i; ss >> i;) {
        items.push_back(i);

        if (ss.peek() == ',')
            ss.ignore();
    }
}

void LootBoxWorld::SetInitialWorldSettings()
{
    Enabled = sConfigMgr->GetOption<bool>("LootBox.Enable", true);

    StackSize = sConfigMgr->GetOption<int>("LootBox.StackSize", 5);

    FiveStarRate = sConfigMgr->GetOption<float>("LootBox.FiveStarRate", 0.006);
    FourStarRate = sConfigMgr->GetOption<float>("LootBox.FourStarRate", 0.051);

    PromotionalGuarantee = sConfigMgr->GetOption<int>("LootBox.PromotionalGuarantee", 2);
    FiveStarGuarantee = sConfigMgr->GetOption<int>("LootBox.FiveStarGuarantee", 90);
    FeaturedGuarantee = sConfigMgr->GetOption<int>("LootBox.FeaturedGuarantee", 2);
    FourStarGuarantee = sConfigMgr->GetOption<int>("LootBox.FourStarGuarantee", 10);

    NPC = sConfigMgr->GetOption<int>("LootBox.NPC", 17249);
    Box = sConfigMgr->GetOption<int>("LootBox.Box", 5621798);

    loadItems(Promotions, sConfigMgr->GetOption<std::string>("LootBox.Promotions", ""));
    loadItems(Features, sConfigMgr->GetOption<std::string>("LootBox.Features", ""));
    loadItems(FiveStars, sConfigMgr->GetOption<std::string>("LootBox.FiveStars", ""));
    loadItems(FourStars, sConfigMgr->GetOption<std::string>("LootBox.FourStars", ""));
    loadItems(ThreeStars, sConfigMgr->GetOption<std::string>("LootBox.ThreeStars", ""));

    CustomCurrency = sConfigMgr->GetOption<int>("LootBox.CustomCurrency", 37711);
    DailyReward = sConfigMgr->GetOption<int>("LootBox.DailyReward", 90);
    ResetTimeHour = sConfigMgr->GetOption<int>("Instance.ResetTimeHour", 4);
    LevelReward = sConfigMgr->GetOption<int>("LootBox.LevelReward", 75);
    KillReward = sConfigMgr->GetOption<int>("LootBox.KillReward", 10);
}

void AddLootBoxWorldScripts()
{
    new LootBoxWorld();
}