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

            if (specId != iam.player->GetActiveSpec()) {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_PERK_ERROR, "Incorrect spec for selection request: Id "
                    + std::to_string(specId) + " given when " + std::to_string(iam.player->GetActiveSpec()) + " expected.");
                return;
            }

            for (int i = CharacterPerkType::ARCHETYPE; i < CharacterPerkType::MAX; i++) {
                auto max = i == 0 ? 1 : iam.player->GetLevel() / 2;
                auto  present = fc->CountPerksByType(iam.player, CharacterPerkType(i));

                if ((max - present) < 1)
                    continue;

                if (iam.player->GetLevel() < 2 && i > CharacterPerkType::ARCHETYPE)
                    continue;

                auto perkType = CharacterPerkType(i);
                if (spec->perkQueue[perkType].empty())
                    fc->InsertNewPerksForLevelUp(iam.player, spec, perkType);

                if (!spec->perkQueue[perkType].empty()) {
                    SendSelection(iam.player, spec->perkQueue[perkType].begin()->second);
                    return;
                }
            }
        }
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;

    void SendSelection(Player* player, std::vector<CharacterSpecPerk*> options) {
        std::string out = "";
        std::string delim = "*";

        for (CharacterSpecPerk* perk : options)
            out = out + std::to_string(perk->spell->spellId) + "^"
            + std::to_string(perk->carryover) + delim;

        cm->SendPerkSelection(player, out);
    }
};
