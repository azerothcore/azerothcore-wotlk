#include <algorithm>
#include <vector>
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "Common.h"
#include "DatabaseEnv.h"
#include "Item.h"

// Add player scripts
const std::string SUBJECT = "Level up reward";
const std::string BODY =
    "Congratulations on hitting a milestone level!\n\n"
    "Please take your reward and enjoy.\n\n"
    "- WinZig";

class LevelUpPlayer : public PlayerScript
{
public:
    LevelUpPlayer() : PlayerScript("LevelUp") { }

    void OnLogin(Player* player) override
    {
        if (sConfigMgr->GetOption<bool>("LevelUp.Enable", false)) {
            ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00Level Up |rmodule.");
        }
    }

    void OnLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        switch (player->getLevel()) {
            case 10:
                sendReward(player, 5621810);
                break;
            case 19:
                sendReward(player, 5621819);
                break;
            case 29:
                sendReward(player, 5621829);
                break;
            case 39:
                sendReward(player, 5621839);
                break;
            case 49:
                sendReward(player, 5621849);
                break;
            case 59:
                sendReward(player, 5621859);
                break;
            case 60:
                sendReward(player, 5621860);
                break;
            case 64:
                sendReward(player, 5621864);
                break;
            default:
                break;
        }
    }

private:
    void sendReward(Player *player, uint32 itemId)
    {
        ItemTemplate const *proto = sObjectMgr->GetItemTemplate(itemId);

        if (!proto) {
            sLog->outError("[LevelUp] Item ID is invalid: %u", itemId);
            return;
        }

        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

        Item *item = Item::CreateItem(itemId, 1);
        item->SaveToDB(trans);

        MailSender sender(5126979);
        MailDraft draft(SUBJECT, BODY);
        draft.AddItem(item);
        draft.SendMailTo(trans, MailReceiver(player), sender);

        CharacterDatabase.CommitTransaction(trans);
    }
};

void AddLevelUpPlayerScripts()
{
    new LevelUpPlayer();
}
