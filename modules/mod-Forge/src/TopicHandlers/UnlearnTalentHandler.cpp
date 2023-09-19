#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include "Pet.h"
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

        if (iam.player->isDead())
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
                    if (pointType == CharacterPointType::PET_TALENT) {
                        Pet* pet = iam.player->GetPet();
                        pet->unlearnSpell(spellId, false);
                    }
                    else {
                        for (auto rank : tab->Talents[spellId]->Ranks)
                            if (auto spellInfo = sSpellMgr->GetSpellInfo(rank.second)) {
                                if (spellInfo->HasEffect(SPELL_EFFECT_LEARN_SPELL))
                                    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i) {
                                        iam.player->removeSpell(spellInfo->Effects[i].TriggerSpell, SPEC_MASK_ALL, false);
                                        iam.player->RemoveSpell(spellInfo->Effects[i].TriggerSpell);
                                    }
                                iam.player->removeSpell(rank.second, SPEC_MASK_ALL, false);
                                iam.player->RemoveSpell(rank.second);
                                iam.player->RemoveAura(rank.second);
                            }
                    }
                    spellItt->second->CurrentRank = 0;

                    iam.player->UpdateAllStats();
                    fc->UpdateCharPoints(iam.player, sfp);
                    fc->UpdateCharacterSpec(iam.player, spec);

                    talItt->second.erase(spellId);
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
                    if (pt == CharacterPointType::TALENT_TREE || pt == CharacterPointType::PET_TALENT)
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

                        if (spec->PointsSpent[tab.first] > 0)
                            spec->PointsSpent[tab.first] = 0;
                    }
                    else {
                        continue;
                    }
                }
            }

            ForgeCharacterPoint* sfp = fc->GetSpecPoints(player, TALENT_TREE, spec->Id);
            sfp->Sum = std::max(player->GetLevel() - 9, 0);
            sfp->Max = sfp->Sum;

            if (player->getClass() == CLASS_HUNTER) {
                if (PetStable* petStable = player->GetPetStable()) {
                    if (petStable->CurrentPet) {
                        CharacterDatabase.Execute("Delete from pet_spell where guid = {}", petStable->CurrentPet->PetNumber);
                        player->RemovePet(nullptr, PET_SAVE_NOT_IN_SLOT, true);
                    }
                }
            }
            fc->UpdateCharPoints(player, sfp);

            cm->SendActiveSpecInfo(player);
            cm->SendSpecInfo(player);
            cm->SendTalents(player);
        }
    }

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
