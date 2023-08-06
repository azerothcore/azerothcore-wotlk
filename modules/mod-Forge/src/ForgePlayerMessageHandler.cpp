/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "Spell.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "Gamemode.h"
#include <ActivateSpecHandler.cpp>
#include <GetTalentTreeHandler.cpp>
#include <GetCharacterSpecsHandler.cpp>
#include <LearnTalentHandler.cpp>
#include "ForgeCommonMessage.h"
#include <RespecTalentsHandler.cpp>
#include <UnlearnTalentHandler.cpp>
#include <UpdateSpecHandler.cpp>
#include <GetTalentsHandler.cpp>
#include <GetPerksHandler.cpp>
#include <LearnPerkHandler.cpp>
//#include <UnlearnPerkHandler.cpp>
#include <PrestigeHandler.cpp>
#include <UseSkillbook.cpp>
#include <ForgeCache.cpp>
#include <ForgeCacheCommands.cpp>
#include <ActivateClassSpecHandler.cpp>
#include <unordered_map>
#include <boost/lexical_cast.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>

// Add player scripts
class ForgePlayerMessageHandler : public PlayerScript
{
public:
    ForgePlayerMessageHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : PlayerScript("ForgePlayerMessageHandler")
    {
        fc = cache;
        cm = cmh;
    }

    void OnCreate(Player* player) override
    {
        // setup DB
        player->SetSpecsCount(0);
        fc->AddCharacterSpecSlot(player);
        fc->UpdateCharacters(player->GetSession()->GetAccountId(), player);
    }

    void OnLogin(Player* player) override
    {
        if (!player)
            return;

        uint32 count = 1;

        for (auto const& [accID, session] : sWorld->GetAllSessions())
        {
            Player* _player = session->GetPlayer();
            if (!_player || _player == player)
            {
                continue;
            }

            // If Remote Address matches, remove the player from the world
            if (player->GetSession()->GetRemoteAddress() == _player->GetSession()->GetRemoteAddress() && ++count > 1)
            {
                player->GetSession()->KickPlayer();
            }
        }

        fc->ApplyAccountBoundTalents(player);
        cm->SendWithstandingSelect(player);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId) override
    {
        fc->DeleteCharacter(guid, accountId);
        fc->UpdateCharacters(accountId, nullptr);
    }

    // receive message from client
    // since we sent the messag to ourselves the server will not route it back to the player.
    void OnBeforeSendChatMessage(Player* player, uint32& type, uint32& lang, std::string& msg) override
    {
        sTopicRouter->Route(player, type, lang, msg);
    }

    void OnLevelChanged(Player* player, uint8 oldlevel) override
    {
        player->SetFreeTalentPoints(0);

        ForgeCharacterSpec* spec;
        if (fc->TryGetCharacterActiveSpec(player, spec))
        {
            uint8 currentLevel = player->getLevel();
            uint32 levelMod = fc->GetConfig("levelMod", 2);
            uint8 levelDiff = currentLevel - oldlevel;

            if (currentLevel == fc->GetConfig("MaxLevel", 80))
            {
                fc->AddCharacterPointsToAllSpecs(player, CharacterPointType::PRESTIGE_TREE, fc->GetConfig("PrestigePointsAtMaxLevel", 5));
            }

            if (currentLevel >= 10)
            {
                uint8 amount = levelDiff;
                if (oldlevel < 10 && levelDiff > 1)
                    amount = 1;
                /*
                if (levelDiff < levelMod && currentLevel % levelMod == 0)
                {
                    uint32 scrapEarned = fc->GetConfig("scrapsPerLevelMod", 1);
                    player->AddItem(FORGE_SCRAP, scrapEarned);
                }
                else if (levelDiff > 1 && levelDiff >= levelMod) // someone added levels, protect div by zero, dont allow 1 as its been evaluated. check if its enough levels
                {
                    uint32 pointsMultiplier = levelDiff / levelMod;
                    uint32 scrapEarned = fc->GetConfig("scrapsPerLevelMod", 1) * pointsMultiplier;
                    player->AddItem(FORGE_SCRAP, scrapEarned);
                }*/

                fc->AddCharacterPointsToAllSpecs(player, CharacterPointType::TALENT_TREE, amount);

                cm->SendActiveSpecInfo(player);
                cm->SendTalentTreeLayout(player);
                cm->SendTalents(player);
            }

            if (currentLevel == 80)
            {
                for (auto charTabType : fc->TALENT_POINT_TYPES)
                {
                    if (ACCOUNT_WIDE_TYPE != charTabType)
                        continue;

                    std::list<ForgeTalentTab*> tabs;
                    if (fc->TryGetForgeTalentTabs(player, charTabType, tabs))
                        for (auto* tab : tabs)
                        {
                            auto talItt = spec->Talents.find(tab->Id);

                            for (auto spell : tab->Talents)
                            {
                                for (auto rank : spell.second->Ranks)
                                    player->removeSpell(rank.second, SPEC_MASK_ALL, false);
                            }
                        }
                }

                cm->SendTalents(player);
            }

            auto missing = fc->FindMissingPerks(player);
            while (missing > 0)
            {
                InsertNewPerksForLevelUp(player);
                missing--;
            }
            cm->SendWithstandingSelect(player);
        }
    }

    void OnLearnSpell(Player* player, uint32 spellID) 
    {
        // check if its forged.
        if (auto* fs = fc->GetTalent(player, spellID))
        {
            if (fs->CurrentRank != 0)
            {
                auto* tab = fc->TalentTabs[fs->TabId];
                auto* spell = tab->Talents[fs->SpellId];
                auto fsId = spell->Ranks[fs->CurrentRank];

                for (auto s : spell->UnlearnSpells)
                    player->removeSpell(s, SPEC_MASK_ALL, false);

                if (!player->HasSpell(fsId))
                    player->learnSpell(fsId);
            }
        }
    }

    void OnLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid) override
    {
        OnAddItem(player, item->GetTemplate()->ItemId, count);
    }

    //called after player.additem is called. DO NOT CREATE LOOPS WITH THIS.
    void OnAddItem(Player* player, uint32 item, uint32 count)
    {
        
    }

    void OnCreateItem(Player* player, Item* item, uint32 count) override
    {
        OnAddItem(player, item->GetTemplate()->ItemId, count);
    }

    void OnQuestRewardItem(Player* player, Item* item, uint32 count) override
    {
        OnAddItem(player, item->GetTemplate()->ItemId, count);
    }

    /*void OnGiveXP(Player* player, uint32& amount, Unit* victim) override
    {
        if (Gamemode::HasGameMode(player, GameModeType::CLASSIC))
            return;

        if (player->getLevel() <= 9)
            amount *= fc->GetConfig("Dynamic.XP.Rate.1-9", 2);

        else if (player->getLevel() <= 19)
            amount *= fc->GetConfig("Dynamic.XP.Rate.10-19", 2);

        else if (player->getLevel() <= 29)
            amount *= fc->GetConfig("Dynamic.XP.Rate.20-29", 3);

        else if (player->getLevel() <= 39)
            amount *= fc->GetConfig("Dynamic.XP.Rate.30-39", 3);

        else if (player->getLevel() <= 49)
            amount *= fc->GetConfig("Dynamic.XP.Rate.40-49", 3);

        else if (player->getLevel() <= 59)
            amount *= fc->GetConfig("Dynamic.XP.Rate.50-59", 3);

        else if (player->getLevel() <= 69)
            amount *= fc->GetConfig("Dynamic.XP.Rate.60-69", 4);

        else if (player->getLevel() <= 79)
            amount *= fc->GetConfig("Dynamic.XP.Rate.70-79", 4);
    }*/

private:
    TopicRouter* Router;
    ForgeCache* fc;
    ForgeCommonMessage* cm;
    uint32 FORGE_SCRAP = 90000;

    bool GetPrestigeStatus(Player* player)
    {
        return false;
    }

    std::string InsertNewPerksForLevelUp(Player* player)
    {
        std::string out = "";
        std::string delim = "*";

        ForgeCharacterPoint* pp = fc->GetCommonCharacterPoint(player, CharacterPointType::PRESTIGE_COUNT);
        bool prestiged = pp->Sum > 0;
        uint8 maxPerks = prestiged ? 2 : 3;
        uint8 totalPerks = 0;

        auto roll = boost::uuids::random_generator()();
        auto rollKey = boost::lexical_cast<std::string>(roll);
        auto guid = player->GetGUID().GetCounter();

        if (prestiged) {
            CharacterSpecPerk* perk = fc->GetPrestigePerk(player);
            if (perk != nullptr) {
                fc->InsertPerkSelection(player, perk->uuid, perk->spell, rollKey);
                out = out + std::to_string(perk->spell->spellId) + delim;
            }
        }

        if (out == "") // No prestige carryover
            maxPerks = 3;

        do {
            Perk* possibility = fc->GetRandomPerk(player);

            uint32 count = fc->CountCharacterSpecPerkOccurences(player, player->GetActiveSpec(), possibility);
            if((count != -1) && ((count < 3 && !possibility->isUnique) || (count == 0 && possibility->isUnique))
                && (out.find(std::to_string(possibility->spellId)) == std::string::npos))
            {
                fc->InsertPerkSelection(player, rollKey, possibility, rollKey);
                totalPerks++;
                out = out + std::to_string(possibility->spellId) + delim;
            }
        } while (totalPerks < maxPerks);
        return out;
    }
};

// Add all scripts in one
void AddForgePlayerMessageHandler()
{
    ForgeCache* cache = ForgeCache::get_instance();
    ForgeCommonMessage* cm = new ForgeCommonMessage(cache);

    new ForgePlayerMessageHandler(cache, cm);
    sTopicRouter->AddHandler(new ActivateSpecHandler(cache, cm));
    sTopicRouter->AddHandler(new GetTalentsHandler(cache, cm));
    sTopicRouter->AddHandler(new GetCharacterSpecsHandler(cache, cm));
    sTopicRouter->AddHandler(new GetTalentTreeHandler(cache, cm));
    sTopicRouter->AddHandler(new LearnTalentHandler(cache, cm));
    sTopicRouter->AddHandler(new UnlearnTalentHandler(cache, cm));
    sTopicRouter->AddHandler(new RespecTalentsHandler(cache, cm));
    sTopicRouter->AddHandler(new UpdateSpecHandler(cache));
    sTopicRouter->AddHandler(new PrestigeHandler(cache, cm));
    sTopicRouter->AddHandler(new ActivateClassSpecHandler(cache, cm));
    sTopicRouter->AddHandler(new GetPerksHandler(cache, cm));
    sTopicRouter->AddHandler(new LearnPerkHandler(cache, cm));
    //sTopicRouter->AddHandler(new UnlearnPerkHandler(cache, cm));

    new UseSkillBook();
    new ForgeCacheCommands();
}
