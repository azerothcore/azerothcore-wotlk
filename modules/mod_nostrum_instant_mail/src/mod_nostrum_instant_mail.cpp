/*
 * mod_nostrum_instant_mail
 *
 * Removes the mail delivery delay when a player mails items or gold to another
 * character on the same account.  All other mail (different account, Auction
 * House, system/GM, COD) keeps its default AzerothCore behaviour.
 *
 * Implementation note:
 *   AzerothCore exposes OnBeforeMailDraftSendMailTo (MailScript) which fires
 *   for every outgoing mail and receives deliver_delay by reference.  This lets
 *   the module zero-out the delay for eligible same-account mail without any
 *   core patch.
 */

#include "CharacterCache.h"
#include "Config.h"
#include "Mail.h"
#include "MailScript.h"
#include "ObjectGuid.h"
#include "Log.h"
#include "WorldScript.h"

// ---------------------------------------------------------------------------
// Config
// ---------------------------------------------------------------------------

namespace
{

struct InstantMailConfig
{
    bool enabled                    = true;
    bool preserveDifferentDelay     = true;
    bool debug                      = false;
};

InstantMailConfig gCfg;

void LoadConfig()
{
    gCfg.enabled                = sConfigMgr->GetOption<bool>("NostrumInstantOwnMail.Enable",                        true);
    gCfg.preserveDifferentDelay = sConfigMgr->GetOption<bool>("NostrumInstantOwnMail.PreserveDifferentAccountDelay", true);
    gCfg.debug                  = sConfigMgr->GetOption<bool>("NostrumInstantOwnMail.Debug",                         false);

    LOG_INFO("module", ">> NostrumInstantOwnMail: loaded. enabled={} debug={}",
        gCfg.enabled, gCfg.debug);
}

} // anonymous namespace

// ---------------------------------------------------------------------------
// WorldScript — config
// ---------------------------------------------------------------------------

class NostrumInstantMailWorldScript : public WorldScript
{
public:
    NostrumInstantMailWorldScript() : WorldScript("NostrumInstantMailWorldScript",
        { WORLDHOOK_ON_AFTER_CONFIG_LOAD })
    {
    }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        LoadConfig();
    }
};

// ---------------------------------------------------------------------------
// MailScript — delivery delay override
// ---------------------------------------------------------------------------

class NostrumInstantMailScript : public MailScript
{
public:
    NostrumInstantMailScript() : MailScript("NostrumInstantMailScript",
        { MAILHOOK_ON_BEFORE_MAIL_DRAFT_SEND_MAIL_TO })
    {
    }

    void OnBeforeMailDraftSendMailTo(
        MailDraft* mailDraft,
        MailReceiver const& receiver,
        MailSender const& sender,
        MailCheckMask& /*checked*/,
        uint32& deliver_delay,
        uint32& /*custom_expiration*/,
        bool&   /*deleteMailItemsFromDB*/,
        bool&   /*sendMail*/) override
    {
        if (!gCfg.enabled)
            return;

        // Only intercept player-to-player mail (MAIL_NORMAL = 0).
        // AH mail, GM mail, system mail, and all other non-player mail keep the
        // default delay set before this hook fires.
        if (sender.GetMailMessageType() != MAIL_NORMAL)
        {
            if (gCfg.debug)
                LOG_INFO("module", "[NostrumInstantOwnMail] Skipping non-player mail (type={}).",
                    static_cast<uint32>(sender.GetMailMessageType()));
            return;
        }

        // Skip COD mail to avoid any edge cases with payment logic.
        if (mailDraft->GetCOD() != 0)
        {
            if (gCfg.debug)
                LOG_INFO("module", "[NostrumInstantOwnMail] Skipping COD mail — keeping default delay.");
            return;
        }

        uint32 senderGuidLow   = sender.GetSenderId();
        uint32 receiverGuidLow = receiver.GetPlayerGUIDLow();

        ObjectGuid senderGuid   = ObjectGuid::Create<HighGuid::Player>(senderGuidLow);
        ObjectGuid receiverGuid = ObjectGuid::Create<HighGuid::Player>(receiverGuidLow);

        uint32 senderAccount   = sCharacterCache->GetCharacterAccountIdByGuid(senderGuid);
        uint32 receiverAccount = sCharacterCache->GetCharacterAccountIdByGuid(receiverGuid);

        if (senderAccount == 0 || receiverAccount == 0)
        {
            LOG_WARN("module",
                "[NostrumInstantOwnMail] Could not resolve account for sender guid={} (acct={}) or "
                "receiver guid={} (acct={}) — keeping default delay.",
                senderGuidLow, senderAccount, receiverGuidLow, receiverAccount);
            return;
        }

        if (senderAccount != receiverAccount)
        {
            if (gCfg.debug)
                LOG_INFO("module",
                    "[NostrumInstantOwnMail] Different accounts (sender={} receiver={}) — keeping delay={}s.",
                    senderAccount, receiverAccount, deliver_delay);
            return;
        }

        // Same account: make the mail instant.
        if (gCfg.debug)
            LOG_INFO("module",
                "[NostrumInstantOwnMail] Same account {} — setting deliver_delay 0 (was {}s).",
                senderAccount, deliver_delay);

        deliver_delay = 0;
    }
};

// ---------------------------------------------------------------------------
// Registration
// ---------------------------------------------------------------------------

void Addmod_nostrum_instant_mailScripts()
{
    new NostrumInstantMailWorldScript();
    new NostrumInstantMailScript();
}
