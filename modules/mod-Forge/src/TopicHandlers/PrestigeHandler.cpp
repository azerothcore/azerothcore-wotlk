#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "WorldPacket.h"
#include "TopicRouter.h"
#include "ForgeCommonMessage.h"
#include "PetDefines.h"
#include "Pet.h"
#include <ForgeCache.cpp>

class PrestigeHandler : public ForgeTopicHandler
{
public:
    PrestigeHandler(ForgeCache* cache, ForgeCommonMessage* cmh) : ForgeTopicHandler(ForgeTopic::PRESTIGE)
    {
        fc = cache;
        cm = cmh;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        if (HasItemEquiped(iam.player))
        {
            iam.player->SendForgeUIMsg(ForgeTopic::PRESTIGE_ERROR, "Must remove all equiptment before prestiging");
            return;
        }

        if (iam.player->getLevel() != 80)
        {
            iam.player->SendForgeUIMsg(ForgeTopic::PRESTIGE_ERROR, "Must be max level before prestiging");
            return;
        }

 
        iam.player->SetPhaseMask(1, false);
        iam.player->ClearQuestStatus();
        iam.player->resetSpells();


        // add forge spells back
        ForgeCharacterSpec* spec;
        if (fc->TryGetCharacterActiveSpec(iam.player, spec))
        {
            for (auto& tab : spec->Talents)
            {
                CharacterPointType cpt;

                if (fc->TryGetTabPointType(tab.first, cpt))

                switch (cpt)
                {
                case CharacterPointType::TALENT_TREE:
                    ForgeTalentTab* ftt;

                    if (fc->TryGetTalentTab(iam.player, tab.first, ftt))
                    {
                        spec->PointsSpent[ftt->Id] = 0;
                        for (auto t : tab.second)
                        {
                            iam.player->removeSpell(ftt->Talents[t.second->SpellId]->Ranks[t.second->CurrentRank], SPEC_MASK_ALL, false); // Remove all spells.
                            t.second->CurrentRank = 0; // only remove talents here.
                        }
                    }
                    break;

                case CharacterPointType::FORGE_SKILL_TREE:
                    ForgeTalentTab* fftt;

                    if (fc->TryGetTalentTab(iam.player, tab.first, fftt))
                        for (auto t : tab.second)
                        {
                            iam.player->removeSpell(fftt->Talents[t.second->SpellId]->Ranks[t.second->CurrentRank], SPEC_MASK_ALL, false); // Remove all spells.
                        }
                    break;
                default:
                    break;
                }
            }

            cm->ApplyKnownForgeSpells(iam.player);

            ForgeCharacterPoint* fcp = fc->GetSpecPoints(iam.player, CharacterPointType::TALENT_TREE, spec->Id);
            ForgeCharacterPoint* baseFcp = fc->GetCommonCharacterPoint(iam.player, CharacterPointType::TALENT_TREE);
            ForgeCharacterPoint* prisCp = fc->GetCommonCharacterPoint(iam.player, CharacterPointType::PRESTIGE_COUNT);

            baseFcp->Sum = 0;
            fcp->Sum = baseFcp->Sum;
            prisCp->Sum++;

            fc->UpdateCharPoints(iam.player, fcp);
            fc->UpdateCharPoints(iam.player, prisCp);
            fc->UpdateCharacterSpec(iam.player, spec);
        }

        iam.player->SetUInt32Value(PLAYER_XP, 0);
        iam.player->SetLevel(1);
        iam.player->RemoveAllAuras();
        iam.player->UpdateSkillsForLevel();
        iam.player->UpdateAllStats();
        iam.player->SetFullHealth();

        iam.player->SetPower(POWER_MANA, iam.player->GetMaxPower(POWER_MANA));
        iam.player->SetPower(POWER_ENERGY, iam.player->GetMaxPower(POWER_ENERGY));
        if (iam.player->GetPower(POWER_RAGE) > iam.player->GetMaxPower(POWER_RAGE))
            iam.player->SetPower(POWER_RAGE, iam.player->GetMaxPower(POWER_RAGE));
        iam.player->SetPower(POWER_FOCUS, 0);
        iam.player->SetPower(POWER_HAPPINESS, 0);

        PlayerInfo const* info = sObjectMgr->GetPlayerInfo(iam.player->getRace(), iam.player->getClass());
        iam.player->TeleportTo(info->mapId, info->positionX, info->positionY, info->positionZ, info->orientation);
        iam.player->GetSession()->SetLogoutStartTime(20);
    }


    bool HasItemEquiped(Player* player)
    {
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++) {
            if (Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i)) {
                return true;
            }
        }
        return false;
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
