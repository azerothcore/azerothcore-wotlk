#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>
#include <boost/algorithm/string.hpp>

class RerollPerkHandler : public ForgeTopicHandler
{
public:
    RerollPerkHandler(ForgeCache* cache, ForgeCommonMessage* common) : ForgeTopicHandler(ForgeTopic::REROLL_PERK)
    {
        fc = cache;
        cm = common;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;

        std::vector<std::string> results;
        boost::algorithm::split(results, iam.message, boost::is_any_of(";"));

        if (results.empty() || results.size() != 2 || !fc->isNumber(results[0]) || !fc->isNumber(results[1]))
            return;

        uint32 specId = static_cast<uint32>(std::stoul(results[0]));
        uint32 spellId = static_cast<uint32>(std::stoul(results[1]));

        ForgeCharacterSpec* spec;
        CharacterPerkType perkType;

        if (fc->TryGetCharacterActiveSpec(iam.player, spec)) {

            if (specId != iam.player->GetActiveSpec()) {
                iam.player->SendForgeUIMsg(ForgeTopic::LEARN_PERK_ERROR, "Incorrect spec for reroll request: Id "
                    + std::to_string(specId) + " given when " + std::to_string(iam.player->GetActiveSpec()) + " expected.");
                return;
            }

            if (iam.player->HasItemCount(REROLL_TOKEN)) {
                iam.player->DestroyItemCount(REROLL_TOKEN,1,true);

                auto csp = spec->perks.find(spellId);
                if (csp != spec->perks.end()) {
                    auto rank = csp->second->rank;
                    auto spell = csp->second->spell;

                    auto rankIt = spell->ranks.find(rank);
                    if (rankIt != spell->ranks.end())
                        if (spell->isAura)
                            iam.player->RemoveAura(rankIt->second);
                        else
                            iam.player->removeSpell(rankIt->second, SPEC_MASK_ALL, false);
                    rank--;

                    if (rank) {
                        rankIt = spell->ranks.find(rank);
                        if (rankIt != spell->ranks.end())
                            if (spell->isAura)
                                iam.player->AddAura(rankIt->second, iam.player);
                            else
                                iam.player->learnSpell(rankIt->second, true);

                        csp->second->rank = rank;
                    }
                    else {
                        spec->perks.erase(spellId);
                    }

                    fc->InsertNewPerksForLevelUp(iam.player, spec);
                    cm->SendPerks(iam.player, spec->Id);
                    cm->SendWithstandingSelect(iam.player, "");
                }
            }
            else {
                iam.player->SendForgeUIMsg(ForgeTopic::REROLL_PERK_ERROR, "You lack the required item.");
                return;
            }
        }
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;

    uint32 REROLL_TOKEN = 1000000;
};
