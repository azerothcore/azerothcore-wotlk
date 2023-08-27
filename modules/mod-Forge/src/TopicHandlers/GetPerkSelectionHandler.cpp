#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class GetPerkSelectionHandler : public ForgeTopicHandler
{
public:
    GetPerkSelectionHandler(ForgeCache* cache, ForgeCommonMessage* common) : ForgeTopicHandler(ForgeTopic::OFFER_SELECTION)
    {
        fc = cache;
        cm = common;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;

        if (!fc->isNumber(iam.message))
            return;

        uint32 specId = static_cast<uint32>(std::stoul(iam.message));
        ForgeCharacterSpec* spec;
        if (fc->TryGetCharacterActiveSpec(iam.player, spec)) {
            uint8 max = iam.player->GetLevel() / 2;
            uint8 present = fc->CountPerks(iam.player);
            if ((max - present) < 1) {
                spec->perkQueue.clear();
                spec->prestigePerks.clear();
                CharacterDatabase.DirectExecute("delete from character_perk_selection_queue where `guid` = {} and `specId` = {}", iam.player->GetGUID().GetCounter(), spec->Id);
                CharacterDatabase.DirectExecute("delete from character_prestige_perk_carryover where `guid` = {} and `specId` = {}", iam.player->GetGUID().GetCounter(), spec->Id);
                return;
            }

            if (specId != iam.player->GetActiveSpec()) {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_PERK_ERROR, "Incorrect spec for selection request: Id "
                    + std::to_string(specId) + " given when " + std::to_string(iam.player->GetActiveSpec()) + " expected.");
                return;
            }

            if (spec->perkQueue.empty())
                fc->InsertNewPerksForLevelUp(iam.player, spec);
            else
                return;

            std::string out = "";
            std::string delim = "*";
            for (CharacterSpecPerk* perk : spec->perkQueue.begin()->second)
                out = out + std::to_string(perk->spell->spellId) + "^"
                + std::to_string(perk->carryover) + delim;

            cm->SendPerkSelection(iam.player, out);
        }
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
