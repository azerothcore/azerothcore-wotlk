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
        if (!TryStowEquipment(iam.player))
        {
            iam.player->SendForgeUIMsg(ForgeTopic::PRESTIGE_ERROR, "You must have enough bag space to store your equipment.");
            return;
        }

        if (!iam.player->GetFreeInventorySpace() > 1) {
            iam.player->SendForgeUIMsg(ForgeTopic::PRESTIGE_ERROR, "You must have enough bag space to store your prestige reward.");
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
                case CharacterPointType::RACIAL_TREE:
                case CharacterPointType::TALENT_TREE:
                    ForgeTalentTab* ftt;
                    if (fc->TryGetTalentTab(iam.player, tab.first, ftt))
                    {
                        spec->PointsSpent[ftt->Id] = 0;
                        for (auto t : tab.second) {
                        
                            if (auto spellInfo = sSpellMgr->GetSpellInfo(t.second->SpellId)) {
                                if (spellInfo->HasAttribute(SPELL_ATTR0_PASSIVE))
                                    iam.player->RemoveOwnedAura(ftt->Talents[t.second->SpellId]->Ranks[t.second->CurrentRank]);
                                else
                                    iam.player->removeSpell(ftt->Talents[t.second->SpellId]->Ranks[t.second->CurrentRank], SPEC_MASK_ALL, false); // Remove all spells.

                                t.second->CurrentRank = 0; // only remove talents here.
                            }
                        }
                    }
                    break;

                default:
                    break;
                }
            }

            if (iam.player->getLevel() == 80)
            {
                fc->PrestigePerks(iam.player);
                fc->AddCharacterPointsToAllSpecs(iam.player, CharacterPointType::PRESTIGE_TREE, 1);
                fc->AddCharacterPointsToAllSpecs(iam.player, CharacterPointType::PRESTIGE_COUNT, 1);

                iam.player->AddItem(1000002, 2);
            }
            else {
                auto trans = CharacterDatabase.BeginTransaction();
                trans->Append("delete from character_prestige_perk_carryover where `guid` = {} and specId = {}", iam.player->GetGUID().GetCounter(), spec->Id);
                trans->Append("delete from character_perk_selection_queue where `guid` = {} and specId = {}", iam.player->GetGUID().GetCounter(), spec->Id);
                trans->Append("DELETE FROM character_spec_perks WHERE `guid` = {} AND `specId` = {}", iam.player->GetGUID().GetCounter(), spec->Id);

                CharacterDatabase.CommitTransaction(trans);
                spec->perks.clear();
                spec->prestigePerks.clear();
                spec->perkQueue.clear();
            }

            ForgeCharacterPoint* fcp = fc->GetSpecPoints(iam.player, CharacterPointType::TALENT_TREE, spec->Id);
            ForgeCharacterPoint* baseFcp = fc->GetCommonCharacterPoint(iam.player, CharacterPointType::TALENT_TREE);
            ForgeCharacterPoint* rp = fc->GetSpecPoints(iam.player, RACIAL_TREE, spec->Id);

            baseFcp->Sum = 0;
            fcp->Sum = 0;
            rp->Sum = 17;

            fc->UpdateCharPoints(iam.player, baseFcp);
            fc->UpdateCharPoints(iam.player, fcp);
            fc->UpdateCharPoints(iam.player, rp);
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
        iam.player->GetSession()->SetLogoutStartTime(1500);
    }


    bool TryStowEquipment(Player* player)
    {
        auto equipment = 0;
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
            if (Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i)) {
                ItemPosCountVec off_dest;
                auto off_msg = player->CanStoreItem(NULL_BAG, NULL_BAG, off_dest, pItem, false);
                if (off_msg == EQUIP_ERR_OK) {
                    player->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
                    player->StoreItem(off_dest, pItem, true);
                }
                else {
                    return false;
                }
            }

        return true;
    }


private:

    ForgeCache* fc;
    ForgeCommonMessage* cm;
};
