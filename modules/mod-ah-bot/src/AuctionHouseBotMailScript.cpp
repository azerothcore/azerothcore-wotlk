/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#include "AuctionHouseBot.h"
#include "AuctionHouseBotCommon.h"
#include "AuctionHouseBotMailScript.h"

AHBot_MailScript::AHBot_MailScript() : MailScript("AHBot_MailScript")
{

}

void AHBot_MailScript::OnBeforeMailDraftSendMailTo(
    MailDraft*,                  /* mailDraft */
    MailReceiver const& receiver,
    MailSender const& sender,
    MailCheckMask&,              /* checked */
    uint32&,                     /* deliver_delay */
    uint32&,                     /* custom_expiration */
    bool& deleteMailItemsFromDB,
    bool& sendMail)
{
    //
    // If the mail is for the bot, then remove it and delete the items bought
    //

    if (gBotsId.find(receiver.GetPlayerGUIDLow()) != gBotsId.end())
    {
        if (sender.GetMailMessageType() == MAIL_AUCTION)
        {
            deleteMailItemsFromDB = true;
        }

        sendMail = false;
    }
}
