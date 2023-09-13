#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include <ForgeCache.cpp>
#include <boost/algorithm/string.hpp>
#include "ForgeCommonMessage.h"

class LearnPerkHandler : public ForgeTopicHandler
{
public:
    LearnPerkHandler(ForgeCache* cache, ForgeCommonMessage*  common) : ForgeTopicHandler(ForgeTopic::LEARN_PERK)
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

        if (specId != iam.player->GetActiveSpec()) {
            iam.player->SendForgeUIMsg(ForgeTopic::LEARN_PERK_ERROR, "You are attempting to add a perk to a spec that is not active. Abuse of game systems will result in a ban. Id "
                + std::to_string(specId) + " given when " + std::to_string(iam.player->GetActiveSpec()) + " expected.");
            return;
        }

        if (fc->TryGetCharacterActiveSpec(iam.player, spec))
        {
            for (int i = 0; i < CharacterPerkType::MAX; i++) {
                auto type = CharacterPerkType(i);
                if (fc->PerkInQueue(spec, spellId, type))
                {
                    auto perkMap = spec->perks[type];
                    auto perk = perkMap.find(spellId);

                    CharacterSpecPerk* csp = new CharacterSpecPerk();
                    Perk* spell = fc->GetPerk(iam.player->getClass(), spellId, type);
                    if (perk == perkMap.end()) {
                        csp->rank = 0;
                        csp->uuid = spec->perkQueue[type].begin()->first;
                        csp->spell = spell;
                        perkMap[spellId] = csp;
                    }
                    else
                        csp = perk->second;

                    if (csp->spell->ranks.size() == csp->rank)
                    {
                        iam.player->SendForgeUIMsg(ForgeTopic::LEARN_PERK_ERROR, "This perk cannot be upgraded any further.");
                        return;
                    }

                    auto rankIt = spell->ranks.find(csp->rank);
                    if (rankIt != spell->ranks.end())
                        iam.player->removeSpell(rankIt->second, SPEC_MASK_ALL, false);

                    csp->rank++;

                    rankIt = spell->ranks.find(csp->rank);
                    if (rankIt != spell->ranks.end())
                        iam.player->learnSpell(rankIt->second, true);
                    else
                        return;


                    spec->perks[type][spellId] = csp;
                    fc->LearnCharacterPerkInternal(iam.player, spec, csp, type);
                    spec->perkQueue[type].clear();
                    CharacterDatabase.DirectExecute("DELETE FROM character_perk_selection_queue where `guid` = {} and `specId` = {} and `type` = {}", iam.player->GetGUID().GetCounter(), spec->Id, type);

                    cm->SendPerks(iam.player, specId);

                    iam.player->SendPlaySpellVisual(179); // 53 SpellCastDirected
                    iam.player->SendPlaySpellImpact(iam.player->GetGUID(), 362); // 113 EmoteSalute
                }
            }
        }
        else
            iam.player->SendForgeUIMsg(ForgeTopic::LEARN_PERK_ERROR, "The perk you attempted to learn was not offered.");
    }

private:
    ForgeCommonMessage* cm;
    ForgeCache* fc;
};
