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
#include <GetPerksInspectHandler.cpp>
#include <LearnPerkHandler.cpp>
#include <GetPerkSelectionHandler.cpp>
#include <RerollPerkHandler.cpp>
#include <PrestigeHandler.cpp>
#include <UseSkillbook.cpp>
#include <ForgeCache.cpp>
#include <ForgeCacheCommands.cpp>
#include <ActivateClassSpecHandler.cpp>
#include <unordered_map>


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

        fc->AddCharacterPointsToAllSpecs(player, CharacterPointType::RACIAL_TREE, fc->GetConfig("InitialPoints", 17));
    }

    void OnLogin(Player* player) override
    {
        if (!player)
            return;

        if (fc->IsFlaggedReset(player->GetGUID().GetCounter())) {
            ForgeCharacterSpec* spec;
            if (fc->TryGetCharacterActiveSpec(player, spec))
            {
                ForgeAddonMessage msg;
                msg.topic = "2";
                msg.player = player;
                std::string message = "-1;"+std::to_string(spec->Id);
                msg.message = message;
                sTopicRouter->Route(msg, message);

                fc->ClearResetFlag(player->GetGUID().GetCounter());
            }
        }
        else {
            fc->ApplyTalents(player);
        }
        fc->ApplyActivePerks(player);
        LearnSpellsForLevel(player, player->GetLevel());
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
            uint8 levelDiff = currentLevel - oldlevel;

            if (currentLevel >= 10)
            {
                uint8 amount = (oldlevel < 9) ? levelDiff - (9 - oldlevel) : levelDiff;

                fc->AddCharacterPointsToAllSpecs(player, CharacterPointType::TALENT_TREE, amount);

                cm->SendActiveSpecInfo(player);
                cm->SendTalents(player);
            }

            LearnSpellsForLevel(player, player->GetLevel());
            fc->UpdateCharacterSpec(player, spec);
        }
    }

    void OnLearnSpell(Player* player, uint32 spellID) 
    {
        //// check if its forged.
        //if (auto* fs = fc->GetTalent(player, spellID))
        //{
        //    if (fs->CurrentRank != 0)
        //    {
        //        auto* tab = fc->TalentTabs[fs->TabId];
        //        auto* spell = tab->Talents[fs->SpellId];
        //        auto fsId = spell->Ranks[fs->CurrentRank];

        //        for (auto s : spell->UnlearnSpells)
        //            player->removeSpell(s, SPEC_MASK_ALL, false);

        //        if (!player->HasSpell(fsId))
        //            player->learnSpell(fsId);
        //    }
        //}
    }

    /*
    void OnLootItem(Player* player, Item* item, uint32 count, ObjectGuid lootguid) override
    {
        OnAddItem(player, item->GetTemplate()->ItemId, count);
    }

    //called after player.additem is called. DO NOT CREATE LOOPS WITH THIS.
    void OnAddItem(Player* player, uint32 item, uint32 count)
    {
        
    }
    */

    void OnCreateItem(Player* player, Item* item, uint32 count) override
    {
        OnAddItem(player, item->GetTemplate()->ItemId, count);
    }

    void OnQuestRewardItem(Player* player, Item* item, uint32 count) override
    {
        OnAddItem(player, item->GetTemplate()->ItemId, count);
    }

    void OnCreatureKill(Player* player, Creature* victim) {
        if (player->IsOutdoors() && player->HasAura(230236)) {
            auto pl_level = player->GetLevel();
            auto level = pl_level - 9;;
            if (pl_level <= 5)
                level = 0;
            else if (pl_level <= 39)
                level = pl_level - 5 - pl_level / 10;
            else if (pl_level <= 59)
                level = pl_level - 1 - pl_level / 5;

            if (victim->GetLevel() > level)
                player->CastSpell(player, 230234, true);
        }
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* victim, uint8 source) override
    {
        if (Gamemode::HasGameMode(player, GameModeType::CLASSIC))
            return;

        if (player->getLevel() <= 9)
            amount *= fc->GetConfig("Dynamic.XP.Rate.1-9", 5);

        else if (player->getLevel() <= 19)
            amount *= fc->GetConfig("Dynamic.XP.Rate.10-19", 5);

        else if (player->getLevel() <= 29)
            amount *= fc->GetConfig("Dynamic.XP.Rate.20-29", 6);

        else if (player->getLevel() <= 39)
            amount *= fc->GetConfig("Dynamic.XP.Rate.30-39", 6);

        else if (player->getLevel() <= 49)
            amount *= fc->GetConfig("Dynamic.XP.Rate.40-49", 7);

        else if (player->getLevel() <= 59)
            amount *= fc->GetConfig("Dynamic.XP.Rate.50-59", 7);

        else if (player->getLevel() <= 69)
            amount *= fc->GetConfig("Dynamic.XP.Rate.60-69", 8);

        else if (player->getLevel() <= 79)
            amount *= fc->GetConfig("Dynamic.XP.Rate.70-79", 9);

        if (auto prestiges = GetPrestigeStatus(player)) {
            auto bonus = (50 * std::log(prestiges + 1)) / 100;
            amount *= 1 + bonus;
        }
    }

private:
    TopicRouter* Router;
    ForgeCache* fc;
    ForgeCommonMessage* cm;
    uint32 FORGE_SCRAP = 90000;

    uint8 GetPrestigeStatus(Player* player)
    {
        ForgeCharacterPoint* presCp = fc->GetCommonCharacterPoint(player, CharacterPointType::PRESTIGE_COUNT);
        return presCp->Sum;
    }

    void LearnSpellsForLevel(Player* player, uint8 newlevel) {

        // remove fake death
        if (player->HasUnitState(UNIT_STATE_DIED))
            player->RemoveAurasByType(SPELL_AURA_FEIGN_DEATH);

        auto spells = sObjectMgr->getTrainerSpellsForClass();
        if (!spells.empty()) {
            LearnSpellsForClass(player, CLASS_DRUID+3, newlevel, spells);
            LearnSpellsForClass(player, player->getClass(), newlevel, spells);
        }
    }

    void LearnSpellsForClass(Player* player, uint8 search, uint8 newLevel, CacheTrainerSpellByClassContainer pool) {
        auto classSpells = pool.find(search);
        if (classSpells != pool.end()) {
            for (auto spell : classSpells->second)
            {
                TrainerSpell const* tSpell = &spell.second;

                if (player->HasSpell(tSpell->spell))
                    continue;

                bool valid = true;
                for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                {
                    if (!tSpell->learnedSpell[i])
                        continue;
                    if (!player->IsSpellFitByClassAndRace(tSpell->learnedSpell[i]))
                    {
                        valid = false;
                        break;
                    }
                }

                if (newLevel < tSpell->reqLevel)
                    continue;

                if (!valid)
                    continue;

                if (tSpell->reqSpell && !player->HasSpell(tSpell->reqSpell))
                {
                    continue;
                }

                if (player->GetTrainerSpellState(tSpell) != TRAINER_SPELL_GREEN)
                    continue;

                // learn explicitly or cast explicitly
                if (tSpell->IsCastable())
                    player->CastSpell(player, tSpell->spell, true);
                else
                    player->learnSpell(tSpell->spell);
            }
        }
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
    sTopicRouter->AddHandler(new GetPerkSelectionHandler(cache, cm));
    sTopicRouter->AddHandler(new RerollPerkHandler(cache, cm));
    sTopicRouter->AddHandler(new GetPerksInspectHandler(cache, cm));

    new UseSkillBook();
    new ForgeCacheCommands();
}
