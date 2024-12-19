/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE
 */

#ifndef AUCTION_HOUSE_BOT_MAIL_SCRIPT_H
#define AUCTION_HOUSE_BOT_MAIL_SCRIPT_H

#include "ScriptMgr.h"
#include "Mail.h"

// =============================================================================
// Interaction with the mailing systems
// =============================================================================

class AHBot_MailScript : public MailScript
{
public:
    AHBot_MailScript();

    void OnBeforeMailDraftSendMailTo(MailDraft* mailDraft, MailReceiver const& receiver, MailSender const& sender, MailCheckMask& checked, uint32& deliver_delay, uint32& custom_expiration, bool& deleteMailItemsFromDB, bool& sendMail) override;
};

#endif /* AUCTION_HOUSE_BOT_MAIL_SCRIPT_H */
