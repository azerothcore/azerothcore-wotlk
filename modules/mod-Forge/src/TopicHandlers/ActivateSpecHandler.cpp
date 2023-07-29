#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>

class ActivateSpecHandler : public ForgeTopicHandler
{
public:
    ActivateSpecHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::ACTIVATE_SPEC)
    {
        fc = cache;
        cm = cmh;
    }
    //Player::ActivateSpec
    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message == "" || !fc->isNumber(iam.message))
            return;

        uint32 id = static_cast<uint32>(std::stoul(iam.message));
        ForgeCharacterSpec* spec;
        ForgeCharacterSpec* currentSpec;

        if (fc->TryGetCharacterSpec(iam.player, id, spec) && fc->TryGetCharacterActiveSpec(iam.player, currentSpec))
        {
            if (spec->Id == currentSpec->Id)
            {
                iam.player->SendForgeUIMsg(ForgeTopic::ACTIVATE_SPEC_ERROR, "Spec already active");
                return;
            }

            for (auto& talTab : currentSpec->Talents)
            {
                ForgeTalentTab* ftt;
                if (fc->TryGetTalentTab(iam.player, talTab.first, ftt))
                {
                    for (auto& talSp : talTab.second)
                        iam.player->removeSpell(ftt->Talents[talSp.second->SpellId]->Ranks[talSp.second->CurrentRank], SPEC_MASK_ALL, false);
                }
            }


            spec->Active = true;
            fc->UpdateCharacterSpecDetailsOnly(iam.player, spec);


            for (auto& talTab : spec->Talents)
            {
                ForgeTalentTab* ftt;

                if (fc->TryGetTalentTab(iam.player, talTab.first, ftt))
                {
                    for (auto& talSp : talTab.second)
                        iam.player->learnSpell(ftt->Talents[talSp.second->SpellId]->Ranks[talSp.second->CurrentRank], false);
                }
            }


            cm->SendSpecInfo(iam.player);
            cm->SendTalents(iam.player);
            iam.player->ActivateSpec(id);
            iam.player->SendInitialSpells();
            iam.player->SendPlaySpellVisual(179); // 53 SpellCastDirected
            iam.player->SendPlaySpellImpact(iam.player->GetGUID(), 362); // 113 EmoteSalute
        }
        else
            iam.player->SendForgeUIMsg(ForgeTopic::ACTIVATE_SPEC_ERROR, "Unknown Spec");
    }

private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
