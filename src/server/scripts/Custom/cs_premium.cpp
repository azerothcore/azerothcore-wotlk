#include "Language.h"
#include "Chat.h"
#include "Player.h"
#include "ScriptMgr.h"
//#include "AuctionHouseMgr.h"

#define EMOTE_NO_VIP "Доступно только VIP игрокам. Приобретается в ЛК."
#define EMOTE_ZONE_VIP "На текущий момент команда недоступна! Попробуйте позже."
using namespace Acore::ChatCommands;

class premium_commandscript : public CommandScript
{
public:
    premium_commandscript() : CommandScript("premium_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable premiumCommandTable =
        {
            { "bank", HandlePremiumBankCommand, SEC_PLAYER, Console::No},
            { "mail", HandlePremiumMailCommand, SEC_PLAYER, Console::No },
        };

        static ChatCommandTable commandTable =
        {
            { "vip", SEC_PLAYER, false, NULL, "", premiumCommandTable },
        };

        return commandTable;
    }

    static bool HandlePremiumBankCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player *player = handler->GetSession()->GetPlayer();
        if (player->GetSession()->IsPremium() && sWorld->getBoolConfig(COMMAND_BANK_PREMIUM))
        {
            //Different Checks
            if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || player->HasStealthAura() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead())
            {
                handler->SendSysMessage(EMOTE_ZONE_VIP);
                handler->SetSentErrorMessage(true);
                return false;
            }

            handler->GetSession()->SendShowBank(handler->GetSession()->GetPlayer()->GetGUID());
        }
        else
            handler->SendSysMessage(EMOTE_NO_VIP);
            handler->SetSentErrorMessage(true);
        return true;
    }

    static bool HandlePremiumMailCommand(ChatHandler* handler, char const* /*args*/)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (player->GetSession()->IsPremium() && sWorld->getBoolConfig(COMMAND_MAIL_PREMIUM))
        {
            //Different Checks
            if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || player->HasStealthAura() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead())
            {
                handler->SendSysMessage(EMOTE_ZONE_VIP);
                handler->SetSentErrorMessage(true);
                return false;
            }

            handler->GetSession()->SendShowMailBox(player->GetGUID());
        }
        else
            handler->SendSysMessage(EMOTE_NO_VIP);
            handler->SetSentErrorMessage(true);
        return true;
    }

    //static bool HandlePremiumAuctionCommand(ChatHandler* handler, char const* /*args*/)
    //{
        //Player* player = handler->GetSession()->GetPlayer();
        //if(player->GetSession()->IsPremium())
        //{
            //Different Checks
            //if(player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || player->HasStealthAura() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead())
            //{
            //    handler->SendSysMessage(LANG_PREMIUM_CANT_DO);
            //    handler->SetSentErrorMessage(true);
            //    return false;
            //}

            //handler->GetSession()->SendAuctionHello(player->GetGUID());
            //handler->GetSession()->SendAuctionHello(player->getFaction());

        //}
        //return true;
    //}

};

void AddSC_premium_commandscript()
{
    new premium_commandscript();
}
