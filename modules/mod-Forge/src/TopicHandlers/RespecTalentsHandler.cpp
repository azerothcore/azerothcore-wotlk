#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include <ForgeCache.cpp>
#include <unordered_map>

class RespecTalentsHandler : public ForgeTopicHandler
{
public:
    std::unordered_map <CharacterPointType, uint32> RESPEC_POINT_TYPE;

    RespecTalentsHandler(ForgeCache* cache, ForgeCommonMessage* fcm) : ForgeTopicHandler(ForgeTopic::RESPEC_TALENTS)
    {
        fc = cache;
        cm = fcm;
        RESPEC_POINT_TYPE[CharacterPointType::FORGE_SKILL_TREE] = 90002;
        RESPEC_POINT_TYPE[CharacterPointType::PRESTIGE_TREE] = 90002;
        RESPEC_POINT_TYPE[CharacterPointType::RACIAL_TREE] = 90002;
        RESPEC_POINT_TYPE[CharacterPointType::LEVEL_10_TAB] = 999999999;
        RESPEC_POINT_TYPE[CharacterPointType::PRESTIGE_COUNT] = 999999999;
        RESPEC_POINT_TYPE[CharacterPointType::SKILL_PAGE] = 999999999;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (iam.message.empty() || !fc->isNumber(iam.message))
            return;

        CharacterPointType pointT = (CharacterPointType)std::stoi(iam.message);

        auto pointItt = RESPEC_POINT_TYPE.find(pointT);

        if (pointItt != RESPEC_POINT_TYPE.end())
        {

            if (!iam.player->HasItemCount(pointItt->second))
            {
                iam.player->SendForgeUIMsg(ForgeTopic::RESPEC_TALENTS_ERROR, "Not enough respec points available");
                return;
            }

            iam.player->AddItem(pointItt->second, -1);
        }

        ForgeCharacterSpec* spec;

        if (fc->TryGetCharacterActiveSpec(iam.player, spec))
        {
            for (auto& tabKvp : spec->Talents)
            {
                uint32 skillId;
                ForgeTalentTab* tab;

                if (fc->TryGetTalentTab(iam.player, tabKvp.first, tab))
                {
                    spec->PointsSpent[tab->Id] = 0;

                    for (auto& tKvp : tabKvp.second)
                    {
                        iam.player->removeSpell(tab->Talents[skillId]->Ranks[tKvp.second->CurrentRank], SPEC_MASK_ALL, false);
                        tKvp.second->CurrentRank = 0;
                    }
                }
            }

            ForgeCharacterPoint* fcp = fc->GetSpecPoints(iam.player, pointT, spec->Id);
            ForgeCharacterPoint* baseFcp = fc->GetCommonCharacterPoint(iam.player, pointT);

            fcp->Sum = baseFcp->Sum;

            
            fc->UpdateCharPoints(iam.player, fcp);
            fc->UpdateCharacterSpec(iam.player, spec);
            cm->SendTalents(iam.player);
        }
        else
            iam.player->SendForgeUIMsg(ForgeTopic::RESPEC_TALENTS_ERROR, "Unknown Spec");
    }

private:
    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
