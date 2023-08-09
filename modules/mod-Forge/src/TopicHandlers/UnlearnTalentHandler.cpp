#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>
#include <boost/algorithm/string.hpp>

class UnlearnTalentHandler : public ForgeTopicHandler
{
public:
    std::unordered_map <CharacterPointType, uint32> UNLEARN_POINT_TYPE;

    UnlearnTalentHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::UNLEARN_TALENT)
    {
        fc = cache;
        cm = cmh;

        UNLEARN_POINT_TYPE[CharacterPointType::FORGE_SKILL_TREE] = 90001;
        UNLEARN_POINT_TYPE[CharacterPointType::PRESTIGE_TREE] = 90001;
        UNLEARN_POINT_TYPE[CharacterPointType::RACIAL_TREE] = 90001;
        UNLEARN_POINT_TYPE[CharacterPointType::LEVEL_10_TAB] = 999999999;
        UNLEARN_POINT_TYPE[CharacterPointType::PRESTIGE_COUNT] = 999999999;
        UNLEARN_POINT_TYPE[CharacterPointType::SKILL_PAGE] = 999999999;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty())
            return;

        std::vector<std::string> results;
        boost::algorithm::split(results, iam.message, boost::is_any_of(";"));

        if (results.empty() || results.size() != 2 || !fc->isNumber(results[1]))
            return;



        if (results[0] == "-1") {
            ResetAllTabsForSpec(iam.player, static_cast<uint32>(std::stoul(results[1])));
            return;
        }
        else if (!fc->isNumber(results[0]))
        {
            return;
        }
        else {
            uint32 tabId = static_cast<uint32>(std::stoul(results[0]));
            uint32 spellId = static_cast<uint32>(std::stoul(results[1]));
            CharacterPointType pointType;

            if (!fc->TryGetTabPointType(tabId, pointType))
            {
                iam.player->SendForgeUIMsg(ForgeTopic::UNLEARN_TALENT_ERROR, "Invalid point type");
                return;
            }

            auto pointItt = UNLEARN_POINT_TYPE.find(pointType);

            if (pointItt != UNLEARN_POINT_TYPE.end())
            {
                if (!iam.player->HasItemCount(pointItt->second))
                {
                    iam.player->SendForgeUIMsg(ForgeTopic::UNLEARN_TALENT_ERROR, "Not enough unlearn points available");
                    return;
                }

                iam.player->AddItem(pointItt->second, -1);
            }

            ForgeTalentTab* tab;
            ForgeCharacterSpec* spec;
            if (fc->TryGetCharacterActiveSpec(iam.player, spec)) {
                if (fc->TryGetTalentTab(iam.player, tabId, tab))
                {
                    ForgeCharacterPoint* sfp = fc->GetSpecPoints(iam.player, pointType, spec->Id);

                    auto talItt = spec->Talents.find(tabId);

                    if (talItt == spec->Talents.end())
                    {
                        iam.player->SendForgeUIMsg(ForgeTopic::UNLEARN_TALENT_ERROR, "Unknown talent tab");
                        return;
                    }

                    auto spellItt = talItt->second.find(spellId);

                    if (spellItt == talItt->second.end())
                    {
                        iam.player->SendForgeUIMsg(ForgeTopic::UNLEARN_TALENT_ERROR, "Unknown spell in talent tab");
                        return;
                    }

                    uint32 refund = spellItt->second->CurrentRank * tab->Talents[spellId]->RankCost;
                    spec->PointsSpent[tabId] -= refund;

                    sfp->Sum += refund;
                    sfp->Max -= refund;

                    auto spellInfo = sSpellMgr->GetSpellInfo(spellId);
                    if (spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE))
                        iam.player->RemoveOwnedAura(tab->Talents[spellId]->Ranks[spellItt->second->CurrentRank]);
                    else
                        iam.player->removeSpell(tab->Talents[spellId]->Ranks[spellItt->second->CurrentRank], SPEC_MASK_ALL, false);

                    iam.player->UpdateAllStats();
                    spellItt->second->CurrentRank = 0;

                    fc->UpdateCharPoints(iam.player, sfp);
                    fc->UpdateCharacterSpec(iam.player, spec);

                    iam.player->SendForgeUIMsg(ForgeTopic::UNLEARN_TALENT_ERROR, results[0] + ";" + results[1] + ";0");
                }
                else
                    iam.player->SendForgeUIMsg(ForgeTopic::UNLEARN_TALENT_ERROR, "Unknown spell or spec");
            }
        }
    }

private:

    void ResetAllTabsForSpec(Player* player, uint32 tabId)
    {
        ForgeCharacterSpec* spec;
        if (fc->TryGetCharacterActiveSpec(player, spec)) {
            for (auto tab : spec->Talents) {
                CharacterPointType pt;
                if (fc->TryGetTabPointType(tab.first, pt))
                {
                    if (pt == CharacterPointType::TALENT_TREE)
                    {
                        for (auto spell : tab.second)
                        {
                            if (spell.second->CurrentRank > 0)
                            {
                                ForgeAddonMessage* msg = new ForgeAddonMessage();
                                msg->topic = 2;
                                msg->player = player;
                                msg->message = std::to_string(tab.first) + ";" + std::to_string(spell.first);
                                HandleMessage(*msg);
                            }
                        }
                    }
                    else {
                        continue;
                    }
                }
            }
            cm->SendActiveSpecInfo(player);
            cm->SendSpecInfo(player);
            cm->SendTalents(player);
        }
    }

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
