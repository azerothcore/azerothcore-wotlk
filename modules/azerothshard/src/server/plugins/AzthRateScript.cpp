 #include "ScriptMgr.h"
 #include "Chat.h"
 #include "Language.h"
 #include "CustomRates.h"
#include "Player.h"

 class AzthXPRatePlayerScripts : public PlayerScript {
 public:

     AzthXPRatePlayerScripts() : PlayerScript("AzthXPRatePlayerScripts") {
     }

     void OnDelete(uint64 guid) {
         CustomRates::DeleteRateFromDB(guid, CHAR_DEL_INDIVIDUAL_XP_RATE);
     }

     void OnLogin(Player* player) {
         float rate = CustomRates::GetXpRateFromDB(player);

         // player has custom xp rate set. Load it from DB. Otherwise use default set in AzthPlayer::AzthPlayer
         if (rate != -1) {
             player->azthPlayer->SetPlayerQuestRate(rate);

             if (sWorld->getBoolConfig(CONFIG_PLAYER_INDIVIDUAL_XP_RATE_SHOW_ON_LOGIN)) {
                 if (rate == 0)
                     ChatHandler(player->GetSession()).SendSysMessage("|CFF7BBEF7[Custom Rates]|r: Your quest XP rate was set to 0. You won't gain any XP from quest completation.");
                 else
                     ChatHandler(player->GetSession()).PSendSysMessage("|CFF7BBEF7[Custom Rates]|r: Your quest XP rate was set to %.2f.", rate);
             }
         }
     }
 };

 void AddSC_Custom_Rates() {
     new AzthXPRatePlayerScripts();
 }
