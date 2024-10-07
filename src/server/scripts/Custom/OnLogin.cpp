#include "ScriptMgr.h"
#include "DatabaseEnv.h"
#include "SpellInfo.h"
#include "ObjectMgr.h"
#include "Item.h"
#include "ReputationMgr.h"

class Login_script : public PlayerScript
{
public:
    Login_script() : PlayerScript("Login_script") {}

    void DeleteItem_OnLogin(Player* player)
    {
        /* Удаление шмоток при старте */
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
            if (Item* haveItemEquipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                if (haveItemEquipped)
                {
                    player->DestroyItemCount(haveItemEquipped->GetEntry(), 1, true, true);

                    if (haveItemEquipped->IsInWorld())
                    {
                        haveItemEquipped->RemoveFromWorld();
                        haveItemEquipped->DestroyForPlayer(player);
                    }

                    haveItemEquipped->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
                    haveItemEquipped->SetSlot(NULL_SLOT);
                    haveItemEquipped->SetState(ITEM_REMOVED, player);
                }
            }
        }

        switch (player->getClass())
        {
            case CLASS_DEATH_KNIGHT:
            {
                player->DestroyItemCount(38145, 4, true); // сумки
                player->DestroyItemCount(41751, 10, true); // черный гриб
                player->AddItem(6948, 1); // камень возврашения
                player->removeSpell(3273, SPEC_MASK_ALL, false); // первая помощь
            }
            break;

            case CLASS_HUNTER:
            {
                player->DestroyItemCount(2512, 200, true); // стреллы
                player->DestroyItemCount(2516, 200, true); // стреллы номер 2
                player->DestroyItemCount(2101, 4, true); // сумка для стрел
                player->DestroyItemCount(2102, 1, true); // сумка для стрел номер 2
                player->AddItem(52021, 100000); // пули
            }
            break;
        }
    }

    void OnFirstLogin(Player* player)
    {
        player->GetReputationMgr().ModifyReputation(sFactionStore.LookupEntry(1156), 42999);
        DeleteItem_OnLogin(player);
        if (!player->HasSpell(33388))
            player->learnSpell(33388);
        if (!player->HasSpell(33391))
            player->learnSpell(33391);
        if (!player->HasSpell(34090))
            player->learnSpell(34090);
        if (!player->HasSpell(34091))
            player->learnSpell(34091);
        if (!player->HasSpell(54197))
            player->learnSpell(54197);
    }

    void OnLogin(Player* player)
    {
        player->RankControlOnLogin();
        player->LoadPvPRank();
    }
};

void AddSC_Login_script()
{
    new Login_script();
}