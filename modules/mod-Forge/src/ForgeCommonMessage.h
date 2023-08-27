#pragma once

#include <string>
#include "Player.h"
#include <ForgeCache.cpp>

class ForgeCommonMessage
{
public:


    static ForgeCommonMessage* get_instance()
    {
        static ForgeCommonMessage* cache;

        if (cache == nullptr)
            cache = new ForgeCommonMessage(ForgeCache::get_instance());

        return cache;
    }

    ForgeCommonMessage(ForgeCache*);
    ForgeCache* fc;

    void SendTalents(Player*, uint32);
    void SendTalents(Player*);
    void SendPerks(Player*, uint8);
    void SendAllPerks(Player*);
    void SendPerkSelection(Player*, std::string);
    void SendTalentTreeLayout(Player*);
    void SendTalentTreeLayout(Player*, uint32);
    void SendSpecInfo(Player*);
    void SendActiveSpecInfo(Player* player);
    std::string BuildTree(Player*, CharacterPointType pointType, std::list<ForgeTalentTab*> tabs);
    void ApplyKnownForgeSpells(Player*);
    bool CanLearnTalent(Player*, uint32, uint32);
    std::string DoBuildPerks(std::vector<CharacterSpecPerk*> spec, Player* player);
private:

    std::string DoBuildRanks(std::unordered_map<uint32, ForgeCharacterTalent*>& spec, Player* player, std::string clientMsg, uint32 tabId);
    std::string DoBuildPerkCatalogue(std::vector<Perk*> perks);
};
