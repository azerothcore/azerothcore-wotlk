/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "Gamemode.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "TopicRouter.h"
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>

class WS_Gamemode : public WorldScript
{
public:
    WS_Gamemode() : WorldScript("WS_Gamemode") { }

    void OnAfterConfigLoad(bool reload) override
    {
        Gamemode::PreloadAllModesPlayers();
    }
};

class PS_Gamemode : public PlayerScript
{
public:

    PS_Gamemode() : PlayerScript("PS_Gamemode")
    {
       
    }

    void OnLogin(Player* player) {
        auto ids = Gamemode::GetGameMode(player);
        if (ids.size() != 0)
            for(auto id : ids)
                player->AddAura((uint32)id, player);
    }

    bool CanSendMail(Player* player, ObjectGuid receiverGuid, ObjectGuid mailbox, std::string& subject, std::string& body, uint32 money, uint32 COD, Item* item)
    {
        if (!Gamemode::CanSendMail(receiverGuid.GetCounter())) {
            ChatHandler(player->GetSession()).PSendSysMessage("Your receveir can't receive mail while in his game mode.");
            return false;
        }

        if (!Gamemode::CanSendMail(player)) {
            ChatHandler(player->GetSession()).PSendSysMessage("You can't send mail while in your your game mode.");
            return false;
        }

        return true;
    }


    bool OnBeforeQuestComplete(Player* player, uint32 /*quest_id*/) override
    {
        if (!Gamemode::CanAddQuest(player)) {
            ChatHandler(player->GetSession()).PSendSysMessage("You can't complete quest while in your game mode.");
            return false;
        }
        return true;
    }


    void OnLevelChanged(Player* player, uint8 oldLevel) override
    {
        Gamemode::OnLevelUp(player);
    }

    void OnEquip(Player* player, Item* it, uint8 bag, uint8 slot, bool /*update*/) override
    {
        if (!it)
            return;

        if (Gamemode::HasGameMode(player, GameModeType::IRON_MAN) && it->GetTemplate()->Quality >= 1 && it->GetTemplate()->Class != ItemClass::ITEM_CLASS_CONTAINER)
        {
            ItemPosCountVec dest;
            uint8 msg = player->CanStoreItem(NULL_BAG, NULL_SLOT, dest, it, false);
            player->RemoveItem(bag, slot, true);

            if (msg != EQUIP_ERR_OK) {

                MailSender sender(MAIL_CREATURE, 34337 /* The Postmaster */);
                MailDraft* draft = new MailDraft("Forge Game Mode", "There was not enough bag space to store this item.");

                CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
                draft->AddItem(it);
                draft->SendMailTo(trans, MailReceiver(player), sender);

                CharacterDatabase.CommitTransaction(trans);
            }
        }
    }

    void OnPlayerKilledByCreature(Creature* killer, Player* killed) override
    {
        Gamemode::OnDeath(killed, killer);
    }

    bool CanJoinLfg(Player* player, uint8 roles, lfg::LfgDungeonSet& dungeons, const std::string& comment) override
    {
        if (!Gamemode::CanJoinRDF(player)) {
            ChatHandler(player->GetSession()).PSendSysMessage("You can't accept while in your game mode.");
            return false;
        }
        return true;
    }

    bool CanGroupAccept(Player* player, Group* group) override
    {
        if (!Gamemode::CanAddGroupPlayer(player, group->GetLeader())) {
            ChatHandler(player->GetSession()).PSendSysMessage("You can't accept while in your game mode.");
            return false;
        }
        return true;
    }

    bool CanInitTrade(Player* player, Player* target) override
    {
        if (!Gamemode::CanTrade(player)) {
            ChatHandler(player->GetSession()).PSendSysMessage("You can't trade while in your game mode.");
            return false;
        }

        if (!Gamemode::CanTrade(target)) {
            ChatHandler(player->GetSession()).PSendSysMessage("You can't trade with this players.");
            return false;
        }
        return true;
    }

    bool CanEnterMap(Player* player, MapEntry const* entry, InstanceTemplate const* instance, MapDifficulty const* mapDiff, bool loginCheck) override
    {
        if (entry->IsDungeon() && !Gamemode::CanJoinRDF(player)) {
            ChatHandler(player->GetSession()).PSendSysMessage("You can't enter in dungeon while in your game mode.");
            return false;
        }
        return true;
    }

private:
    TopicRouter* Router;
};


class GetGameModesHandler : public ForgeTopicHandler
{
public:
    GetGameModesHandler() : ForgeTopicHandler(ForgeTopic::GET_GAME_MODES)
    {
       
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        std::string msg = "";

        for (auto gm : Gamemode::GameModeTypes)
        {
            std::string delim = ";";

            if (msg == "")
                delim = "";

            msg += delim + std::to_string((uint32)gm);

            auto rewardsItt = Gamemode::Rewards.find(gm);
            int i = 0;

            if (rewardsItt != Gamemode::Rewards.end())
            {
                for (auto* reward : rewardsItt->second)
                {
                    delim = "*";

                    if (i == 0)
                    {
                        msg += "^";
                        delim = "";
                    }

                    msg += delim + std::to_string((uint32)reward->RewardType) + "&" + std::to_string(reward->Entry);

                    i++;
                }
            }
        }

        if (msg != "")
            iam.player->SendForgeUIMsg(ForgeTopic::GET_GAME_MODES, msg);
    }

};

class SetGameModesHandler : public ForgeTopicHandler
{
public:
    SetGameModesHandler() : ForgeTopicHandler(ForgeTopic::SET_GAME_MODES)
    {

    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.player->getLevel() != 1)
        {
            iam.player->SendForgeUIMsg(ForgeTopic::SET_GAME_MODES_ERROR, "Can onlp pick a game mode at level 1");
            return;
        }

        std::vector<std::string> results;
        boost::algorithm::split(results, iam.message, boost::is_any_of(";"));
        std::vector<GameModeType> modes;

        for (auto m : results)
        {
            auto mode = static_cast<uint32>(std::stoul(m));
            bool valid = false;

            for (auto gm : Gamemode::GameModeTypes)
                if (mode == (uint32)gm)
                    valid = true;

            if (valid)
                modes.push_back((GameModeType)mode);
        }

        if (modes.size() > 0)
            Gamemode::SetGameMode(iam.player, modes);
    }

};

class EndGameModesHandler : public ForgeTopicHandler
{
public:
    EndGameModesHandler() : ForgeTopicHandler(ForgeTopic::END_GAME_MODES)
    {

    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        Gamemode::RemoveGamemode(iam.player, iam.player->getLevel() == 1);
    }

};

class spell_insanity : public AuraScript
{
    PrepareAuraScript(spell_insanity);

    std::vector<uint32> curses = {
        1910005,
        1910006,
        1910007,
        1910008,
        1910009,
        1910010
    };

    void ChangeCurse(AuraEffect const* effect)
    {
        if (Unit* caster = GetCaster())
        {
            Player* player;
            if (caster->IsPlayer())
                player = caster->ToPlayer();
            else
                return;

            for (auto c : curses)
                player->RemoveAura(c);

            player->AddAura(curses[irand(0, 5)], player);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_insanity::ChangeCurse, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
    }
};


void AddSC_Gamemode()
{
    sTopicRouter->AddHandler(new GetGameModesHandler());
    sTopicRouter->AddHandler(new SetGameModesHandler());
    sTopicRouter->AddHandler(new EndGameModesHandler());

    RegisterSpellScript(spell_insanity);
    new PS_Gamemode();
    new WS_Gamemode();
}
