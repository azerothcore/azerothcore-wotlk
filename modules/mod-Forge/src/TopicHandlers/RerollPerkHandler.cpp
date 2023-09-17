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

            if (true/*iam.player->HasItemCount(REROLL_TOKEN)*/) {
                for (int i = CharacterPerkType::COMBAT; i < CharacterPerkType::MAX; i++) {
                    auto type = CharacterPerkType(i);
                    auto csp = spec->perks[type].find(spellId);
                    if (csp != spec->perks[type].end()) {
                        iam.player->DestroyItemCount(REROLL_TOKEN, 1, true);
                        auto perk = csp->second;
                        auto rank = perk->rank;
                        auto spell = perk->spell;

                        auto rankIt = spell->ranks.find(rank);
                        if (rankIt != spell->ranks.end()) {
                            iam.player->removeSpell(rankIt->second, SPEC_MASK_ALL, false);
                            iam.player->RemoveSpell(rankIt->second);
                        }
                        rank--;

                        if (rank) {
                            rankIt = spell->ranks.find(rank);
                            if (rankIt != spell->ranks.end())
                                iam.player->learnSpell(rankIt->second, true);

                            csp->second->rank = rank;
                        }
                        else {
                            csp->second->rank = rank;
                            fc->LearnCharacterPerkInternal(iam.player, spec, csp->second, CharacterPerkType(i));
                            spec->perks[type].erase(spellId);
                        }

                        cm->SendPerks(iam.player, spec->Id);
                        return;
                    }
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
