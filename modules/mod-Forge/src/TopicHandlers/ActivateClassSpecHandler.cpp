#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class ActivateClassSpecHandler : public ForgeTopicHandler
{
public:
    ActivateClassSpecHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::ACTIVATE_CLASS_SPEC)
    {
        fc = cache;
        cm = cmh;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        uint32 id = static_cast<uint32>(std::stoul(iam.message));
        ForgeCharacterSpec* spec;

        if (fc->TryGetCharacterActiveSpec(iam.player, spec))
        {
            if (spec->CharacterSpecTabId == id)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::ACTIVATE_SPEC_ERROR, "Class specialization already active");
                return;
            }

            auto reqLevel = fc->GetConfig("ReqiredSpecializationLevel", 10);

            if (iam.player->getLevel() < reqLevel)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::ACTIVATE_SPEC_ERROR, "You must be level " + std::to_string(reqLevel) + " to pick a class specialization");
                return;
            }

            for (auto& tab : spec->Talents)
            {
                CharacterPointType cpt;
                ForgeTalentTab* ftt;

                if (fc->TryGetTabPointType(tab.first, cpt) && fc->TryGetTalentTab(iam.player, tab.first, ftt))
                {
                    for (auto t : tab.second)
                    {
                        switch (cpt)
                        {
                        case CharacterPointType::TALENT_TREE:

                            spec->PointsSpent[ftt->Id] = 0;

                            iam.player->removeSpell(ftt->Talents[t.second->SpellId]->Ranks[t.second->CurrentRank], SPEC_MASK_ALL, false); // Remove all spells.
                            t.second->CurrentRank = 0; // only remove talents here.

                            break;
                        case CharacterPointType::LEVEL_10_TAB:
                            if (spec->CharacterSpecTabId == tab.first)
                            {
                                iam.player->removeSpell(t.second->SpellId, SPEC_MASK_ALL, false);
                            }

                            for (auto& s : ftt->Talents)
                            {
                                if (s.second->ColumnIndex == id)
                                    iam.player->learnSpell(t.second->SpellId, false, false);
                            }
                            break;
                        default:
                            break;
                        }
                    }
                }
            }

            spec->CharacterSpecTabId = id;

            cm->ApplyKnownForgeSpells(iam.player);

            ForgeCharacterPoint* fcp = fc->GetSpecPoints(iam.player, CharacterPointType::TALENT_TREE, spec->Id);
            ForgeCharacterPoint* baseFcp = fc->GetCommonCharacterPoint(iam.player, CharacterPointType::TALENT_TREE);

            fcp->Sum = baseFcp->Sum;

            fc->UpdateCharPoints(iam.player, fcp);
            fc->UpdateCharacterSpec(iam.player, spec);

            cm->SendSpecInfo(iam.player);
            cm->SendTalents(iam.player);

            iam.player->SendPlaySpellVisual(179); // 53 SpellCastDirected
            iam.player->SendPlaySpellImpact(iam.player->GetGUID(), 362); // 113 EmoteSalute
        }
        else
            iam.player->SendForgeUIMsg(ForgeTopic::ACTIVATE_CLASS_SPEC_ERROR, "Unknown Spec");
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
