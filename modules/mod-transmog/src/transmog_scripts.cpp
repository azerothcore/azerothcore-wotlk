/*
5.0
Transmogrification 3.3.5a - Gossip menu
By Rochet2

ScriptName for NPC:
Creature_Transmogrify

TODO:
Make DB saving even better (Deleting)? What about coding?

Fix the cost formula
-- Too much data handling, use default costs

Are the qualities right?
Blizzard might have changed the quality requirements.
(TC handles it with stat checks)

Cant transmogrify rediculus items // Foereaper: would be fun to stab people with a fish
-- Cant think of any good way to handle this easily, could rip flagged items from cata DB
*/
#include <unordered_map>
#include "Transmogrification.h"
#include "Chat.h"
#include "ScriptedCreature.h"
#include "ItemTemplate.h"
#include "DatabaseEnv.h"
#include "WorldPacket.h"
#include "Opcodes.h"

#define sT  sTransmogrification
#define GTS session->GetAcoreString // dropped translation support, no one using?

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_HOWWORKS = {
    {LOCALE_enUS, "How does transmogrification work?"},
    {LOCALE_koKR, "형상변환은 어떻게 작동합니까?"},
    {LOCALE_frFR, "Comment fonctionne la transmogrification ?"},
    {LOCALE_deDE, "Wie funktioniert Transmogrifizierung?"},
    {LOCALE_zhCN, "变形术是如何运作的？"},
    {LOCALE_zhTW, "幻化是如何運作的？"},
    {LOCALE_esES, "¿Cómo funciona la transfiguración?"},
    {LOCALE_esMX, "¿Cómo funciona la transfiguración?"},
    {LOCALE_ruRU, "Как работает трансмогрификация?"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_MANAGESETS = {
    {LOCALE_enUS, "Manage sets"},
    {LOCALE_koKR, "세트 관리"},
    {LOCALE_frFR, "Gérer les ensembles"},
    {LOCALE_deDE, "Sets verwalten"},
    {LOCALE_zhCN, "管理套装"},
    {LOCALE_zhTW, "管理套裝"},
    {LOCALE_esES, "Administrar conjuntos"},
    {LOCALE_esMX, "Administrar conjuntos"},
    {LOCALE_ruRU, "Управление комплектами"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_REMOVETRANSMOG = {
    {LOCALE_enUS, "Remove all transmogrifications"},
    {LOCALE_koKR, "모든 변형 제거"},
    {LOCALE_frFR, "Supprimer toutes les transmogrifications"},
    {LOCALE_deDE, "Alle Transmogrifikationen entfernen"},
    {LOCALE_zhCN, "移除所有幻化"},
    {LOCALE_zhTW, "移除所有幻化"},
    {LOCALE_esES, "Eliminar todas las transfiguraciones"},
    {LOCALE_esMX, "Eliminar todas las transfiguraciones"},
    {LOCALE_ruRU, "Удалить все трансмогрификации"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_REMOVETRANSMOG_ASK = {
    {LOCALE_enUS, "Remove transmogrifications from all equipped items?"},
    {LOCALE_koKR, "장착한 모든 아이템의 변형을 제거합니까?"},
    {LOCALE_frFR, "Supprimer les transmogrifications de tous les objets équipés ?"},
    {LOCALE_deDE, "Transmogrifikationen von allen ausgerüsteten Gegenständen entfernen?"},
    {LOCALE_zhCN, "是否要从所有已装备的物品中移除幻化？"},
    {LOCALE_zhTW, "從所有已裝備物品中移除幻化？"},
    {LOCALE_esES, "¿Eliminar las transfiguraciones de todos los objetos equipados?"},
    {LOCALE_esMX, "¿Eliminar las transfiguraciones de todos los objetos equipados?"},
    {LOCALE_ruRU, "Удалить трансмогрификации со всех экипированных предметов?"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_UPDATEMENU = {
    {LOCALE_enUS, "Update menu"},
    {LOCALE_koKR, "메뉴 업데이트"},
    {LOCALE_frFR, "Mettre à jour le menu"},
    {LOCALE_deDE, "Menü aktualisieren"},
    {LOCALE_zhCN, "更新菜单"},
    {LOCALE_zhTW, "更新選單"},
    {LOCALE_esES, "Actualizar menú"},
    {LOCALE_esMX, "Actualizar menú"},
    {LOCALE_ruRU, "Обновить меню"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_HOWSETSWORK = {
    {LOCALE_enUS, "How do sets work?"},
    {LOCALE_koKR, "세트는 어떻게 작동합니까?"},
    {LOCALE_frFR, "Comment fonctionnent les ensembles ?"},
    {LOCALE_deDE, "Wie funktionieren Sets?"},
    {LOCALE_zhCN, "套装是如何运作的？"},
    {LOCALE_zhTW, "套裝如何運作？"},
    {LOCALE_esES, "¿Cómo funcionan los conjuntos?"},
    {LOCALE_esMX, "¿Cómo funcionan los conjuntos?"},
    {LOCALE_ruRU, "Как работают комплекты?"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_SAVESET = {
    {LOCALE_enUS, "Save set"},
    {LOCALE_koKR, "세트 저장"},
    {LOCALE_frFR, "Sauvegarder l'ensemble"},
    {LOCALE_deDE, "Set speichern"},
    {LOCALE_zhCN, "保存套装"},
    {LOCALE_zhTW, "儲存套裝"},
    {LOCALE_esES, "Guardar conjunto"},
    {LOCALE_esMX, "Guardar conjunto"},
    {LOCALE_ruRU, "Сохранить комплект"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_BACK = {
    {LOCALE_enUS, "Back..."},
    {LOCALE_koKR, "뒤로..."},
    {LOCALE_frFR, "Retour..."},
    {LOCALE_deDE, "Zurück..."},
    {LOCALE_zhCN, "返回..."},
    {LOCALE_zhTW, "返回..."},
    {LOCALE_esES, "Atrás..."},
    {LOCALE_esMX, "Atrás..."},
    {LOCALE_ruRU, "Назад..."}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_USESET = {
    {LOCALE_enUS, "Use this set"},
    {LOCALE_koKR, "이 세트를 사용"},
    {LOCALE_frFR, "Utiliser cet ensemble"},
    {LOCALE_deDE, "Dieses Set verwenden"},
    {LOCALE_zhCN, "使用此套装"},
    {LOCALE_zhTW, "使用此套裝"},
    {LOCALE_esES, "Usar este conjunto"},
    {LOCALE_esMX, "Usar este conjunto"},
    {LOCALE_ruRU, "Использовать этот комплект"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_CONFIRM_USESET = {
    {LOCALE_enUS, "Using this set for transmogrify will bind transmogrified items to you and make them non-refundable and non-tradeable.\nDo you wish to continue?\n\n"},
    {LOCALE_koKR, "이 세트를 변형에 사용하면 변형된 아이템이 계정에 제한되어 환불 및 거래가 불가능합니다.\n계속하시겠습니까?\n\n"},
    {LOCALE_frFR, "En utilisant cet ensemble pour la transmogrification, les objets transmogrifiés seront liés à votre personnage et deviendront non remboursables et non échangeables.\nVoulez-vous continuer ?\n\n"},
    {LOCALE_deDE, "Wenn du dieses Set für die Transmogrifikation verwendest, werden die transmogrifizierten Gegenstände an dich gebunden und können nicht erstattet oder gehandelt werden.\nMöchtest du fortfahren?\n\n"},
    {LOCALE_zhCN, "将此套装用于幻化将使幻化后的物品与您绑定，并使其不可退还和不可交易。\n您是否要继续？\n\n"},
    {LOCALE_zhTW, "使用此套裝進行幻化將使幻化後的物品與您綁定，並使其無法退款和無法交易。\n您是否希望繼續？\n\n"},
    {LOCALE_esES, "Usar este conjunto para transfigurar vinculará los objetos transfigurados a ti y los volverá no reembolsables y no intercambiables.\n¿Deseas continuar?\n\n"},
    {LOCALE_esMX, "Usar este conjunto para transfigurar vinculará los objetos transfigurados a ti y los volverá no reembolsables y no intercambiables.\n¿Deseas continuar?\n\n"},
    {LOCALE_ruRU, "Использование этого комплекта для трансмогрификации привяжет трансмогрифицированные предметы к вам и сделает их неподлежащими возврату и обмену.\nЖелаете продолжить?\n\n"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_DELETESET = {
    {LOCALE_enUS, "Delete set"},
    {LOCALE_koKR, "세트 삭제"},
    {LOCALE_frFR, "Supprimer l'ensemble"},
    {LOCALE_deDE, "Set löschen"},
    {LOCALE_zhCN, "删除套装"},
    {LOCALE_zhTW, "刪除套裝"},
    {LOCALE_esES, "Eliminar conjunto"},
    {LOCALE_esMX, "Eliminar conjunto"},
    {LOCALE_ruRU, "Удалить комплект"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_CONFIRM_DELETESET = {
    {LOCALE_enUS, "Are you sure you want to delete "},
    {LOCALE_koKR, "을(를) 삭제하시겠습니까 "},
    {LOCALE_frFR, "Êtes-vous sûr de vouloir supprimer "},
    {LOCALE_deDE, "Möchten Sie wirklich löschen "},
    {LOCALE_zhCN, "您确定要删除吗 "},
    {LOCALE_zhTW, "您確定要刪除 "},
    {LOCALE_esES, "¿Estás seguro de que quieres eliminar "},
    {LOCALE_esMX, "¿Estás seguro de que quieres eliminar "},
    {LOCALE_ruRU, "Вы уверены, что хотите удалить "}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_INSERTSETNAME = {
    {LOCALE_enUS, "Insert set name"},
    {LOCALE_koKR, "세트 이름 입력"},
    {LOCALE_frFR, "Insérer le nom de l'ensemble"},
    {LOCALE_deDE, "Set-Namen einfügen"},
    {LOCALE_zhCN, "插入套装名称"},
    {LOCALE_zhTW, "輸入套裝名稱"},
    {LOCALE_esES, "Insertar nombre del conjunto"},
    {LOCALE_esMX, "Insertar nombre del conjunto"},
    {LOCALE_ruRU, "Введите имя комплекта"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_SEARCH = {
    {LOCALE_enUS, "Search..."},
    {LOCALE_koKR, "검색..."},
    {LOCALE_frFR, "Rechercher..."},
    {LOCALE_deDE, "Suche..."},
    {LOCALE_zhCN, "搜索..."},
    {LOCALE_zhTW, "搜索..."},
    {LOCALE_esES, "Buscar..."},
    {LOCALE_esMX, "Buscar..."},
    {LOCALE_ruRU, "Поиск..."}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_SEARCHING_FOR = {
    {LOCALE_enUS, "Searching for: "},
    {LOCALE_koKR, "검색 중: "},
    {LOCALE_frFR, "Recherche en cours: "},
    {LOCALE_deDE, "Suche nach: "},
    {LOCALE_zhCN, "正在搜索： "},
    {LOCALE_zhTW, "正在搜尋："},
    {LOCALE_esES, "Buscando:" },
    {LOCALE_esMX, "Buscando: "},
    {LOCALE_ruRU, "Поиск: "}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_SEARCH_FOR_ITEM = {
    {LOCALE_enUS, "Search for what item?"},
    {LOCALE_koKR, "어떤 아이템을 찾으시겠습니까?"},
    {LOCALE_frFR, "Rechercher quel objet ?"},
    {LOCALE_deDE, "Nach welchem Gegenstand suchen?"},
    {LOCALE_zhCN, "搜索哪个物品？"},
    {LOCALE_zhTW, "搜索哪個物品？"},
    {LOCALE_esES, "¿Buscar un objeto?"},
    {LOCALE_esMX, "¿Buscar un objeto?"},
    {LOCALE_ruRU, "Поиск предмета:"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_CONFIRM_HIDE_ITEM = {
    {LOCALE_enUS, "You are hiding the item in this slot.\nDo you wish to continue?\n\n"},
    {LOCALE_koKR, "이 슬롯에 아이템을 감추고 있습니다.\n계속하시겠습니까?\n\n"},
    {LOCALE_frFR, "Vous masquez l'objet dans cet emplacement.\nVoulez-vous continuer ?\n\n"},
    {LOCALE_deDE, "Du versteckst das Item in diesem Slot.\nMöchtest du fortfahren?\n\n"},
    {LOCALE_zhCN, "您正在隐藏此槽中的物品。\n您是否要继续？\n\n"},
    {LOCALE_zhTW, "您正在隱藏此槽中的物品。\n您是否希望繼續？\n\n"},
    {LOCALE_esES, "Estás ocultando el objeto en esta ranura.\n¿Deseas continuar?\n\n"},
    {LOCALE_esMX, "Estás ocultando el objeto en esta ranura.\n¿Deseas continuar?\n\n"},
    {LOCALE_ruRU, "Вы скрываете предмет в этом слоте.\nЖелаете продолжить?\n\n"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_HIDESLOT = {
    {LOCALE_enUS, "Hide Slot"},
    {LOCALE_koKR, "슬롯 숨기기"},
    {LOCALE_frFR, "Cacher l'emplacement"},
    {LOCALE_deDE, "Slot verbergen"},
    {LOCALE_zhCN, "隐藏槽位"},
    {LOCALE_zhTW, "隱藏槽位"},
    {LOCALE_esES, "Ocultar ranura"},
    {LOCALE_esMX, "Ocultar ranura"},
    {LOCALE_ruRU, "Скрыть слот"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_REMOVETRANSMOG_SLOT = {
    {LOCALE_enUS, "Remove transmogrification from the slot?"},
    {LOCALE_koKR, "해당 슬롯의 형상변환을 제거합니까?"},
    {LOCALE_frFR, "Supprimer la transmogrification de l'emplacement ?"},
    {LOCALE_deDE, "Transmogrifikation aus dem Slot entfernen?"},
    {LOCALE_zhCN, "是否要从该槽位中移除幻化？"},
    {LOCALE_zhTW, "從該槽位移除幻化？"},
    {LOCALE_esES, "¿Eliminar la transfiguración del espacio?"},
    {LOCALE_esMX, "¿Eliminar la transfiguración del espacio?"},
    {LOCALE_ruRU, "Удалить трансмогрификацию из ячейки?"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_CONFIRM_USEITEM = {
    {LOCALE_enUS, "Using this item for transmogrify will bind it to you and make it non-refundable and non-tradeable.\nDo you wish to continue?\n\n"},
    {LOCALE_koKR, "이 아이템을 변형에 사용하면 계정에 제한되어 환불 및 거래가 불가능하게 됩니다.\n계속하시겠습니까?\n\n"},
    {LOCALE_frFR, "En utilisant cet objet pour la transmogrification, il sera lié à votre personnage et deviendra non remboursable et non échangeable.\nVoulez-vous continuer ?\n\n"},
    {LOCALE_deDE, "Wenn du diesen Gegenstand für die Transmogrifikation verwendest, wird er an dich gebunden und kann nicht erstattet oder gehandelt werden.\nMöchtest du fortfahren?\n\n"},
    {LOCALE_zhCN, "将此物品用于幻化将使其与您绑定，并使其不可退还和不可交易。\n您是否要继续？\n\n"},
    {LOCALE_zhTW, "使用此物品進行幻化將使其與您綁定，並使其無法退款和無法交易。\n您是否希望繼續？\n\n"},
    {LOCALE_esES, "Usar este objeto para transfigurar lo vinculará a ti y lo volverá no reembolsable y no intercambiable.\n¿Deseas continuar?\n\n"},
    {LOCALE_esMX, "Usar este objeto para transfigurar lo vinculará a ti y lo volverá no reembolsable y no intercambiable.\n¿Deseas continuar?\n\n"},
    {LOCALE_ruRU, "Использование этого предмета для трансмогрификации привяжет его к вам и сделает его неподлежащим возврату и обмену.\nЖелаете продолжить?\n\n"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_PREVIOUS_PAGE = {
    {LOCALE_enUS, "Previous Page"},
    {LOCALE_koKR, "이전 페이지"},
    {LOCALE_frFR, "Page précédente"},
    {LOCALE_deDE, "Vorherige Seite"},
    {LOCALE_zhCN, "上一页"},
    {LOCALE_zhTW, "上一頁"},
    {LOCALE_esES, "Página anterior"},
    {LOCALE_esMX, "Página anterior"},
    {LOCALE_ruRU, "Предыдущая страница"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_NEXT_PAGE = {
    {LOCALE_enUS, "Next Page"},
    {LOCALE_koKR, "다음 페이지"},
    {LOCALE_frFR, "Page suivante"},
    {LOCALE_deDE, "Nächste Seite"},
    {LOCALE_zhCN, "下一页"},
    {LOCALE_zhTW, "下一頁"},
    {LOCALE_esES, "Página siguiente"},
    {LOCALE_esMX, "Página siguiente"},
    {LOCALE_ruRU, "Следующая страница"}
};

const std::unordered_map<LocaleConstant, std::string> TRANSMOG_TEXT_ADDED_APPEARANCE = {
    {LOCALE_enUS, "has been added to your appearance collection."},
    {LOCALE_koKR, "이(가) 외형 컬렉션에 추가되었습니다."},
    {LOCALE_frFR, "a été ajouté(e) à votre collection d'apparences."},
    {LOCALE_deDE, "wurde deiner Transmog-Sammlung hinzugefügt."},
    {LOCALE_zhCN, "已添加到外观收藏中。"},
    {LOCALE_zhTW, "已加入您的外觀收藏。"},
    {LOCALE_esES, "se ha añadido a tu colección de apariencias."},
    {LOCALE_esMX, "se ha agregado a tu colección de apariencias."},
    {LOCALE_ruRU, "был добавлен в вашу коллекцию обликов."}
};

std::unordered_map<std::string, const std::unordered_map<LocaleConstant, std::string>*> textMaps = {
    {"how_works", &TRANSMOG_TEXT_HOWWORKS},
    {"manage_sets", &TRANSMOG_TEXT_MANAGESETS},
    {"remove_transmog", &TRANSMOG_TEXT_REMOVETRANSMOG},
    {"remove_transmog_ask", &TRANSMOG_TEXT_REMOVETRANSMOG_ASK},
    {"update_menu", &TRANSMOG_TEXT_UPDATEMENU},
    {"how_sets_work", &TRANSMOG_TEXT_HOWSETSWORK},
    {"save_set", &TRANSMOG_TEXT_SAVESET},
    {"back", &TRANSMOG_TEXT_BACK},
    {"use_set", &TRANSMOG_TEXT_USESET},
    {"confirm_use_set", &TRANSMOG_TEXT_CONFIRM_USESET},
    {"delete_set", &TRANSMOG_TEXT_DELETESET},
    {"confirm_delete_set", &TRANSMOG_TEXT_CONFIRM_DELETESET},
    {"insert_set_name", &TRANSMOG_TEXT_INSERTSETNAME},
    {"search", &TRANSMOG_TEXT_SEARCH},
    {"searching_for", &TRANSMOG_TEXT_SEARCHING_FOR},
    {"search_for_item", &TRANSMOG_TEXT_SEARCH_FOR_ITEM},
    {"confirm_hide_item", &TRANSMOG_TEXT_CONFIRM_HIDE_ITEM},
    {"hide_slot", &TRANSMOG_TEXT_HIDESLOT},
    {"remove_transmog_slot", &TRANSMOG_TEXT_REMOVETRANSMOG_SLOT},
    {"confirm_use_item", &TRANSMOG_TEXT_CONFIRM_USEITEM},
    {"previous_page", &TRANSMOG_TEXT_PREVIOUS_PAGE},
    {"next_page", &TRANSMOG_TEXT_NEXT_PAGE},
    {"added_appearance", &TRANSMOG_TEXT_ADDED_APPEARANCE}
};

const uint32 FALLBACK_HIDE_ITEM_VENDOR_ID   = 9172; //Invisibility potion
const uint32 FALLBACK_REMOVE_TMOG_VENDOR_ID = 1049; //Tablet of Purge
const uint32 CUSTOM_HIDE_ITEM_VENDOR_ID     = 57575;//Custom Hide Item item
const uint32 CUSTOM_REMOVE_TMOG_VENDOR_ID   = 57576;//Custom Remove Transmog item

std::string GetLocaleText(LocaleConstant locale, const std::string& titleType) {
    auto textMapIt = textMaps.find(titleType);
    if (textMapIt != textMaps.end()) {
        const std::unordered_map<LocaleConstant, std::string>* textMap = textMapIt->second;
        auto it = textMap->find(locale);
        if (it != textMap->end()) {
            return it->second;
        }
    }

    return "";
}

uint32 GetTransmogPrice (ItemTemplate const* targetItem)
{
    uint32 price = sT->GetSpecialPrice(targetItem);
    price *= sT->GetScaledCostModifier();
    price += sT->GetCopperCost();
    return price;
}

bool ValidForTransmog (Player* player, Item* target, Item* source, bool hasSearch, std::string searchTerm)
{
    if (!target || !source || !player) return false;
    ItemTemplate const* targetTemplate = target->GetTemplate();
    ItemTemplate const* sourceTemplate = source->GetTemplate();

    if (!sT->CanTransmogrifyItemWithItem(player, targetTemplate, sourceTemplate))
        return false;
    if (sT->GetFakeEntry(target->GetGUID()) == source->GetEntry())
        return false;
    if (hasSearch && sourceTemplate->Name1.find(searchTerm) == std::string::npos)
        return false;
    return true;
}

bool CmpTmog (Item* i1, Item* i2)
{
    const ItemTemplate* i1t = i1->GetTemplate();
    const ItemTemplate* i2t = i2->GetTemplate();
    const int q1 = 7-i1t->Quality;
    const int q2 = 7-i2t->Quality;
    return std::tie(q1, i1t->Name1) < std::tie(q2, i2t->Name1);
}

std::vector<Item*> GetValidTransmogs (Player* player, Item* target, bool hasSearch, std::string searchTerm)
{
    std::vector<Item*> allowedItems;
    if (!target) return allowedItems;

    if (sT->GetUseCollectionSystem())
    {
        uint32 accountId = player->GetSession()->GetAccountId();
        if (sT->collectionCache.find(accountId) == sT->collectionCache.end())
            return allowedItems;

        for (uint32 itemId : sT->collectionCache[accountId])
        {
            if (!sObjectMgr->GetItemTemplate(itemId))
                continue;
            Item* srcItem = Item::CreateItem(itemId, 1, 0);
            if (ValidForTransmog(player, target, srcItem, hasSearch, searchTerm))
                allowedItems.push_back(srcItem);
        }
    }
    else
    {
        for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
        {
            Item* srcItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (ValidForTransmog(player, target, srcItem, hasSearch, searchTerm))
                allowedItems.push_back(srcItem);
        }
        for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
        {
            Bag* bag = player->GetBagByPos(i);
            if (!bag)
                continue;
            for (uint32 j = 0; j < bag->GetBagSize(); ++j)
            {
                Item* srcItem = player->GetItemByPos(i, j);
                if (ValidForTransmog(player, target, srcItem, hasSearch, searchTerm))
                    allowedItems.push_back(srcItem);
            }
        }
    }

    if (sConfigMgr->GetOption<bool>("Transmogrification.EnableSortByQualityAndName", true)) {
        sort(allowedItems.begin(), allowedItems.end(), CmpTmog);
    }

    return allowedItems;
}

void PerformTransmogrification (Player* player, uint32 itemEntry, uint32 cost)
{
    uint8 slot = sT->selectionCache[player->GetGUID()];
    WorldSession* session = player->GetSession();
    if (!player->HasEnoughMoney(cost))
    {
        ChatHandler(session).SendNotification(LANG_ERR_TRANSMOG_NOT_ENOUGH_MONEY);
        return;
    }
    TransmogAcoreStrings res = sT->Transmogrify(player, itemEntry, slot);
    if (res == LANG_ERR_TRANSMOG_OK)
        session->SendAreaTriggerMessage("%s",GTS(LANG_ERR_TRANSMOG_OK));
    else
        ChatHandler(session).SendNotification(res);
}

void RemoveTransmogrification (Player* player)
{
    uint8 slot = sT->selectionCache[player->GetGUID()];
    WorldSession* session = player->GetSession();
    if (Item* newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
    {
        if (sT->GetFakeEntry(newItem->GetGUID()))
        {
            sT->DeleteFakeEntry(player, slot, newItem);
            session->SendAreaTriggerMessage("%s", GTS(LANG_ERR_UNTRANSMOG_OK));
        }
        else
            ChatHandler(session).SendNotification(LANG_ERR_UNTRANSMOG_NO_TRANSMOGS);
    }
}

class npc_transmogrifier : public CreatureScript
{
public:
    npc_transmogrifier() : CreatureScript("npc_transmogrifier") { }

    struct npc_transmogrifierAI : ScriptedAI
    {
        npc_transmogrifierAI(Creature* creature) : ScriptedAI(creature) { };

        bool CanBeSeen(Player const* player) override
        {
            Player* target = ObjectAccessor::FindConnectedPlayer(player->GetGUID());

            if (sT->IsPortableNPCEnabled)
            {
                if (TempSummon* summon = me->ToTempSummon())
                {
                    return summon->GetOwner() == player;
                }
            }

            return sTransmogrification->IsEnabled() && (target && !target->GetPlayerSetting("mod-transmog", SETTING_HIDE_TRANSMOG).value);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_transmogrifierAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        WorldSession* session = player->GetSession();
        LocaleConstant locale = session->GetSessionDbLocaleIndex();

        // Clear the search string for the player
        sT->searchStringByPlayer.erase(player->GetGUID().GetCounter());

        if (sT->GetEnableTransmogInfo())
            AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|t" + GetLocaleText(locale, "how_works"), EQUIPMENT_SLOT_END + 9, 0);
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
        {
            if (const char* slotName = sT->GetSlotName(slot, session))
            {
                Item* newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
                uint32 entry = newItem ? sT->GetFakeEntry(newItem->GetGUID()) : 0;
                std::string icon = entry ? sT->GetItemIcon(entry, 30, 30, -18, 0) : sT->GetSlotIcon(slot, 30, 30, -18, 0);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, icon + std::string(slotName), EQUIPMENT_SLOT_END, slot);
            }
        }
#ifdef PRESETS
        if (sT->GetEnableSets())
            AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/RAIDFRAME/UI-RAIDFRAME-MAINASSIST:30:30:-18:0|t" + GetLocaleText(locale, "manage_sets"), EQUIPMENT_SLOT_END + 4, 0);
#endif
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|t" + GetLocaleText(locale, "remove_transmog"), EQUIPMENT_SLOT_END + 2, 0, GetLocaleText(locale, "remove_transmog_ask"), 0, false);
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:30:30:-18:0|t" + GetLocaleText(locale, "update_menu"), EQUIPMENT_SLOT_END + 1, 0);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        player->PlayerTalkClass->ClearMenus();
        WorldSession* session = player->GetSession();
        LocaleConstant locale = session->GetSessionDbLocaleIndex();
        // Next page
        if (sender > EQUIPMENT_SLOT_END + 10)
        {
            ShowTransmogItemsInGossipMenu(player, creature, action, sender);
            return true;
        }
        switch (sender)
        {
            case EQUIPMENT_SLOT_END: // Show items you can use
                sT->selectionCache[player->GetGUID()] = action;

                if (sT->GetUseVendorInterface())
                    ShowTransmogItemsInFakeVendor(player, creature, action);
                else
                    ShowTransmogItemsInGossipMenu(player, creature, action, sender);
                break;
            case EQUIPMENT_SLOT_END + 1: // Main menu
                OnGossipHello(player, creature);
                break;
            case EQUIPMENT_SLOT_END + 2: // Remove Transmogrifications
            {
                bool removed = false;
                auto trans = CharacterDatabase.BeginTransaction();
                for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
                {
                    if (Item* newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                    {
                        if (!sT->GetFakeEntry(newItem->GetGUID()))
                            continue;
                        sT->DeleteFakeEntry(player, slot, newItem, &trans);
                        removed = true;
                    }
                }
                if (removed)
                {
                    session->SendAreaTriggerMessage("%s", GTS(LANG_ERR_UNTRANSMOG_OK));
                    CharacterDatabase.CommitTransaction(trans);
                }
                else
                    ChatHandler(session).SendNotification(LANG_ERR_UNTRANSMOG_NO_TRANSMOGS);
                OnGossipHello(player, creature);
            } break;
            case EQUIPMENT_SLOT_END + 3: // Remove Transmogrification from single item
            {
                RemoveTransmogrification(player);
                OnGossipSelect(player, creature, EQUIPMENT_SLOT_END, action);
            } break;
    #ifdef PRESETS
            case EQUIPMENT_SLOT_END + 4: // Presets menu
            {
                if (!sT->GetEnableSets())
                {
                    OnGossipHello(player, creature);
                    return true;
                }
                if (sT->GetEnableSetInfo())
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/INV_Misc_Book_11:30:30:-18:0|t" + GetLocaleText(locale, "how_sets_work"), EQUIPMENT_SLOT_END + 10, 0);
                for (Transmogrification::presetIdMap::const_iterator it = sT->presetByName[player->GetGUID()].begin(); it != sT->presetByName[player->GetGUID()].end(); ++it)
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/INV_Misc_Statue_02:30:30:-18:0|t" + it->second, EQUIPMENT_SLOT_END + 6, it->first);

                if (sT->presetByName[player->GetGUID()].size() < sT->GetMaxSets())
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/GuildBankFrame/UI-GuildBankFrame-NewTab:30:30:-18:0|t" + GetLocaleText(locale, "save_set"), EQUIPMENT_SLOT_END + 8, 0);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:30:30:-18:0|t" + GetLocaleText(locale, "back"), EQUIPMENT_SLOT_END + 1, 0);
                SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
            } break;
            case EQUIPMENT_SLOT_END + 5: // Use preset
            {
                if (!sT->GetEnableSets())
                {
                    OnGossipHello(player, creature);
                    return true;
                }
                // action = presetID
                for (Transmogrification::slotMap::const_iterator it = sT->presetById[player->GetGUID()][action].begin(); it != sT->presetById[player->GetGUID()][action].end(); ++it)
                {
                    if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, it->first))
                        sT->PresetTransmog(player, item, it->second, it->first);
                }
                OnGossipSelect(player, creature, EQUIPMENT_SLOT_END + 6, action);
            } break;
            case EQUIPMENT_SLOT_END + 6: // view preset
            {
                if (!sT->GetEnableSets())
                {
                    OnGossipHello(player, creature);
                    return true;
                }
                // action = presetID
                for (Transmogrification::slotMap::const_iterator it = sT->presetById[player->GetGUID()][action].begin(); it != sT->presetById[player->GetGUID()][action].end(); ++it)
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, sT->GetItemIcon(it->second, 30, 30, -18, 0) + sT->GetItemLink(it->second, session), sender, action);

                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/INV_Misc_Statue_02:30:30:-18:0|t" + GetLocaleText(locale, "use_set"), EQUIPMENT_SLOT_END + 5, action, GetLocaleText(locale, "confirm_use_set") + sT->presetByName[player->GetGUID()][action], 0, false);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/PaperDollInfoFrame/UI-GearManager-LeaveItem-Opaque:30:30:-18:0|t" + GetLocaleText(locale, "delete_set"), EQUIPMENT_SLOT_END + 7, action, GetLocaleText(locale, "confirm_delete_set") + sT->presetByName[player->GetGUID()][action] + "?", 0, false);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:30:30:-18:0|t" + GetLocaleText(locale, "back"), EQUIPMENT_SLOT_END + 4, 0);
                SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
            } break;
            case EQUIPMENT_SLOT_END + 7: // Delete preset
            {
                if (!sT->GetEnableSets())
                {
                    OnGossipHello(player, creature);
                    return true;
                }
                // action = presetID
                CharacterDatabase.Execute("DELETE FROM `custom_transmogrification_sets` WHERE Owner = {} AND PresetID = {}", player->GetGUID().GetCounter(), action);
                sT->presetById[player->GetGUID()][action].clear();
                sT->presetById[player->GetGUID()].erase(action);
                sT->presetByName[player->GetGUID()].erase(action);

                OnGossipSelect(player, creature, EQUIPMENT_SLOT_END + 4, 0);
            } break;
            case EQUIPMENT_SLOT_END + 8: // Save preset
            {
                if (!sT->GetEnableSets() || sT->presetByName[player->GetGUID()].size() >= sT->GetMaxSets())
                {
                    OnGossipHello(player, creature);
                    return true;
                }
                uint32 cost = 0;
                bool canSave = false;
                for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
                {
                    if (!sT->GetSlotName(slot, session))
                        continue;
                    if (Item* newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                    {
                        uint32 entry = sT->GetFakeEntry(newItem->GetGUID());
                        if (!entry)
                            continue;
                        const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
                        if (!temp)
                            continue;
                        if (!sT->SuitableForTransmogrification(player, temp)) // no need to check?
                            continue;
                        cost += sT->GetSpecialPrice(temp);
                        canSave = true;
                        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, sT->GetItemIcon(entry, 30, 30, -18, 0) + sT->GetItemLink(entry, session), EQUIPMENT_SLOT_END + 8, 0);
                    }
                }
                if (canSave)
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/GuildBankFrame/UI-GuildBankFrame-NewTab:30:30:-18:0|t" + GetLocaleText(locale, "save_set"), 0, 0, GetLocaleText(locale, "insert_set_name"), cost*sT->GetSetCostModifier() + sT->GetSetCopperCost(), true);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:30:30:-18:0|t" + GetLocaleText(locale, "update_menu"), sender, action);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:30:30:-18:0|t" + GetLocaleText(locale, "back"), EQUIPMENT_SLOT_END + 4, 0);
                SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
            } break;
            case EQUIPMENT_SLOT_END + 10: // Set info
            {
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:30:30:-18:0|t" + GetLocaleText(locale, "back"), EQUIPMENT_SLOT_END + 4, 0);
                SendGossipMenuFor(player, sT->GetSetNpcText(), creature->GetGUID());
            } break;
    #endif
            case EQUIPMENT_SLOT_END + 9: // Transmog info
            {
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:30:30:-18:0|t" + GetLocaleText(locale, "back"), EQUIPMENT_SLOT_END + 1, 0);
                SendGossipMenuFor(player, sT->GetTransmogNpcText(), creature->GetGUID());
            } break;
            default: // Transmogrify
            {
                if (!sender && !action)
                {
                    OnGossipHello(player, creature);
                    return true;
                }
                PerformTransmogrification(player, action, sender);
                CloseGossipMenuFor(player); // Wait for SetMoney to get fixed, issue #10053
            } break;
        }
        return true;
    }

#ifdef PRESETS
    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code) override
    {
        player->PlayerTalkClass->ClearMenus();
        if (sender)
        {
            // "sender" is an equipment slot for a search - execute the search
            std::string searchString(code);
            if (searchString.length() > MAX_SEARCH_STRING_LENGTH)
                searchString = searchString.substr(0, MAX_SEARCH_STRING_LENGTH);
            sT->searchStringByPlayer.erase(player->GetGUID().GetCounter());
            sT->searchStringByPlayer.insert({player->GetGUID().GetCounter(), searchString});
            OnGossipSelect(player, creature, EQUIPMENT_SLOT_END, sender - 1);
            return true;
        }
        if (action)
            return true; // should never happen
        if (!sT->GetEnableSets())
        {
            OnGossipHello(player, creature);
            return true;
        }
        std::string name(code);
        if (name.find('"') != std::string::npos || name.find('\\') != std::string::npos)
            ChatHandler(player->GetSession()).SendNotification(LANG_PRESET_ERR_INVALID_NAME);
        else
        {
            for (uint8 presetID = 0; presetID < sT->GetMaxSets(); ++presetID) // should never reach over max
            {
                if (sT->presetByName[player->GetGUID()].find(presetID) != sT->presetByName[player->GetGUID()].end())
                    continue; // Just remember never to use presetByName[pGUID][presetID] when finding etc!

                int32 cost = 0;
                std::map<uint8, uint32> items;
                for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
                {
                    if (!sT->GetSlotName(slot, player->GetSession()))
                        continue;
                    if (Item* newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                    {
                        uint32 entry = sT->GetFakeEntry(newItem->GetGUID());
                        if (!entry)
                            continue;
                        if (entry != HIDDEN_ITEM_ID)
                        {
                            const ItemTemplate* temp = sObjectMgr->GetItemTemplate(entry);
                            if (!temp)
                                continue;
                            if (!sT->SuitableForTransmogrification(player, temp))
                                continue;
                            cost += sT->GetSpecialPrice(temp);
                        }
                        items[slot] = entry;
                    }
                }
                if (items.empty())
                    break; // no transmogrified items were found to be saved
                cost *= sT->GetSetCostModifier();
                cost += sT->GetSetCopperCost();
                if (!player->HasEnoughMoney(cost))
                {
                    ChatHandler(player->GetSession()).SendNotification(LANG_ERR_TRANSMOG_NOT_ENOUGH_MONEY);
                    break;
                }

                std::ostringstream ss;
                for (std::map<uint8, uint32>::iterator it = items.begin(); it != items.end(); ++it)
                {
                    ss << uint32(it->first) << ' ' << it->second << ' ';
                    sT->presetById[player->GetGUID()][presetID][it->first] = it->second;
                }
                sT->presetByName[player->GetGUID()][presetID] = name; // Make sure code doesnt mess up SQL!
                CharacterDatabase.Execute("REPLACE INTO `custom_transmogrification_sets` (`Owner`, `PresetID`, `SetName`, `SetData`) VALUES ({}, {}, \"{}\", \"{}\")", player->GetGUID().GetCounter(), uint32(presetID), name, ss.str());
                if (cost)
                    player->ModifyMoney(-cost);
                break;
            }
        }
        //OnGossipSelect(player, creature, EQUIPMENT_SLOT_END+4, 0);
        CloseGossipMenuFor(player); // Wait for SetMoney to get fixed, issue #10053
        return true;
    }
#endif

    void ShowTransmogItemsInGossipMenu(Player* player, Creature* creature, uint8 slot, uint16 gossipPageNumber) // Only checks bags while can use an item from anywhere in inventory
    {
        WorldSession* session = player->GetSession();
        LocaleConstant locale = session->GetSessionDbLocaleIndex();
        Item* oldItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        bool hasSearchString;

        uint16 pageNumber = 0;
        uint32 startValue = 0;
        uint32 endValue = MAX_OPTIONS - 4;
        bool lastPage = true;
        if (gossipPageNumber > EQUIPMENT_SLOT_END + 10)
        {
            pageNumber = gossipPageNumber - EQUIPMENT_SLOT_END - 10;
            startValue = (pageNumber * (MAX_OPTIONS - 2));
            endValue = (pageNumber + 1) * (MAX_OPTIONS - 2) - 1;
        }

        if (oldItem)
        {
            uint32 price = GetTransmogPrice(oldItem->GetTemplate());
            std::ostringstream ss;
            ss << std::endl;
            if (sT->GetRequireToken())
                ss << std::endl << std::endl << sT->GetTokenAmount() << " x " << sT->GetItemLink(sT->GetTokenEntry(), session);
            std::string lineEnd = ss.str();

            std::unordered_map<uint32, std::string>::iterator searchStringIterator = sT->searchStringByPlayer.find(player->GetGUID().GetCounter());
            hasSearchString = !(searchStringIterator == sT->searchStringByPlayer.end());
            std::string searchDisplayValue(hasSearchString ? searchStringIterator->second : GetLocaleText(locale, "search"));
            std::vector<Item*> allowedItems = GetValidTransmogs(player, oldItem, hasSearchString, searchDisplayValue);

            if (allowedItems.size() > 0)
            {
                lastPage = false;
                // Offset values to add Search gossip item
                if (pageNumber == 0)
                {
                    if (hasSearchString)
                    {
                        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, sT->GetItemIcon(30620, 30, 30, -18, 0) + GetLocaleText(locale, "searching_for") + searchDisplayValue, slot + 1, 0, GetLocaleText(locale, "search_for_item"), 0, true);
                    }
                    else
                    {
                        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, sT->GetItemIcon(30620, 30, 30, -18, 0) + GetLocaleText(locale, "search"), slot + 1, 0, GetLocaleText(locale, "search_for_item"), 0, true);
                    }
                }
                else
                {
                    startValue--;
                }
                if (sT->GetAllowHiddenTransmog())
                {
                    // Offset the start and end values to make space for invisible item entry
                    endValue--;
                    if (pageNumber != 0)
                    {
                        startValue--;
                    }
                    else
                    {
                        // Add invisible item entry
                        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/inv_misc_enggizmos_27:30:30:-18:0|t" + GetLocaleText(locale, "hide_slot"), slot, UINT_MAX, GetLocaleText(locale, "confirm_hide_item") + lineEnd, 0, false);
                    }
                }
                for (uint32 i = startValue; i <= endValue; i++)
                {
                    if (allowedItems.empty() || i > allowedItems.size() - 1)
                    {
                        lastPage = true;
                        break;
                    }
                    Item* newItem = allowedItems.at(i);
                    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, sT->GetItemIcon(newItem->GetEntry(), 30, 30, -18, 0) + sT->GetItemLink(newItem, session), slot, newItem->GetEntry(), GetLocaleText(locale, "confirm_use_item") + sT->GetItemIcon(newItem->GetEntry(), 40, 40, -15, -10) + sT->GetItemLink(newItem, session) + lineEnd, price, false);
                }
            }
            if (gossipPageNumber == EQUIPMENT_SLOT_END + 11)
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetLocaleText(locale, "previous_page"), EQUIPMENT_SLOT_END, slot);
                if (!lastPage)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetLocaleText(locale, "next_page"), gossipPageNumber + 1, slot);
                }
            }
            else if (gossipPageNumber > EQUIPMENT_SLOT_END + 11)
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetLocaleText(locale, "previous_page"), gossipPageNumber - 1, slot);
                if (!lastPage)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetLocaleText(locale, "next_page"), gossipPageNumber + 1, slot);
                }
            }
            else if (!lastPage)
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Next Page", EQUIPMENT_SLOT_END + 11, slot);
            }

            AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/INV_Enchant_Disenchant:30:30:-18:0|t" + GetLocaleText(locale, "remove_transmog"), EQUIPMENT_SLOT_END + 3, slot, GetLocaleText(locale, "remove_transmog_slot"), 0, false);
            AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:30:30:-18:0|t" + GetLocaleText(locale, "update_menu"), EQUIPMENT_SLOT_END, slot);
        }
        AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:30:30:-18:0|t" + GetLocaleText(locale, "back"), EQUIPMENT_SLOT_END + 1, 0);
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
    }

    static std::vector<ItemTemplate const*> GetSpoofedVendorItems (Item* target)
    {
        std::vector<ItemTemplate const*> spoofedItems;
        uint32 existingTransmog = sT->GetFakeEntry(target->GetGUID());
        if (sT->AllowHiddenTransmog && !existingTransmog)
        {
            ItemTemplate const* _hideSlotButton = sObjectMgr->GetItemTemplate(CUSTOM_HIDE_ITEM_VENDOR_ID);
            if (_hideSlotButton)
                spoofedItems.push_back(_hideSlotButton);
            else
            {
                _hideSlotButton = sObjectMgr->GetItemTemplate(FALLBACK_HIDE_ITEM_VENDOR_ID);
                spoofedItems.push_back(_hideSlotButton);
            }
        }
        if (existingTransmog)
        {
            ItemTemplate const* _removeTransmogButton = sObjectMgr->GetItemTemplate(CUSTOM_REMOVE_TMOG_VENDOR_ID);
            if (_removeTransmogButton)
                spoofedItems.push_back(_removeTransmogButton);
            else
            {
                _removeTransmogButton = sObjectMgr->GetItemTemplate(FALLBACK_REMOVE_TMOG_VENDOR_ID);
                spoofedItems.push_back(_removeTransmogButton);
            }
        }
        return spoofedItems;
    }

    static uint32 GetSpoofedItemPrice (uint32 itemId, ItemTemplate const* target)
    {
        switch (itemId)
        {
            case CUSTOM_HIDE_ITEM_VENDOR_ID:
            case FALLBACK_HIDE_ITEM_VENDOR_ID:
                return sT->HiddenTransmogIsFree ? 0 : sT->GetSpecialPrice(target);
            default:
                return 0;
        }
    }

    static void EncodeItemToPacket (WorldPacket& data, ItemTemplate const* proto, uint8& slot, uint32 price)
    {
        data << uint32(slot + 1);
        data << uint32(proto->ItemId);
        data << uint32(proto->DisplayInfoID);
        data << int32 (-1); //Infinite Stock
        data << uint32(price);
        data << uint32(proto->MaxDurability);
        data << uint32(1);  //Buy Count of 1
        data << uint32(0);
        slot++;
    }

    //The actual vendor options are handled in the player script below, OnBeforeBuyItemFromVendor
    static void ShowTransmogItemsInFakeVendor (Player* player, Creature* creature, uint8 slot)
    {
        Item* targetItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
        if (!targetItem)
        {
            ChatHandler(player->GetSession()).SendNotification(LANG_ERR_TRANSMOG_MISSING_DEST_ITEM);
            CloseGossipMenuFor(player);
            return;
        }
        ItemTemplate const* targetTemplate = targetItem->GetTemplate();

        std::vector<Item*> itemList = GetValidTransmogs(player, targetItem, false, "");
        std::vector<ItemTemplate const*> spoofedItems = GetSpoofedVendorItems(targetItem);

        uint32 itemCount = itemList.size();
        uint32 spoofCount = spoofedItems.size();
        uint32 totalItems = itemCount + spoofCount;
        uint32 price = GetTransmogPrice(targetItem->GetTemplate());

        WorldPacket data(SMSG_LIST_INVENTORY, 8 + 1 + totalItems * 8 * 4);
        data << uint64(creature->GetGUID().GetRawValue());

        uint8 count = 0;
        size_t count_pos = data.wpos();
        data << uint8(count);

        for (uint32 i = 0; i < spoofCount && count < MAX_VENDOR_ITEMS; ++i)
        {
            EncodeItemToPacket (
                data, spoofedItems[i], count,
                GetSpoofedItemPrice(spoofedItems[i]->ItemId, targetTemplate)
            );
        }
        for (uint32 i = 0; i < itemCount && count < MAX_VENDOR_ITEMS; ++i)
        {
            ItemTemplate const* _proto = itemList[i]->GetTemplate();
            if (_proto) EncodeItemToPacket(data, _proto, count, price);
        }

        data.put(count_pos, count);
        player->GetSession()->SendPacket(&data);
    }
};

class PS_Transmogrification : public PlayerScript
{
private:
    void AddToDatabase(Player* player, Item* item)
    {
        if (item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_BOP_TRADEABLE) && !sTransmogrification->GetAllowTradeable())
            return;
        if (item->HasFlag(ITEM_FIELD_FLAGS, ITEM_FIELD_FLAG_REFUNDABLE))
            return;
        ItemTemplate const* itemTemplate = item->GetTemplate();
        AddToDatabase(player, itemTemplate);
    }

    void AddToDatabase(Player* player, ItemTemplate const* itemTemplate)
    {
        LocaleConstant locale = player->GetSession()->GetSessionDbLocaleIndex();
        if (!sT->GetTrackUnusableItems() && !sT->SuitableForTransmogrification(player, itemTemplate))
            return;
        if (itemTemplate->Class != ITEM_CLASS_ARMOR && itemTemplate->Class != ITEM_CLASS_WEAPON)
            return;
        uint32 itemId = itemTemplate->ItemId;
        uint32 accountId = player->GetSession()->GetAccountId();
        std::string itemName = itemTemplate -> Name1;

        // get locale item name
        int loc_idex = player->GetSession()->GetSessionDbLocaleIndex();
        if (ItemLocale const* il = sObjectMgr->GetItemLocale(itemId))
            ObjectMgr::GetLocaleString(il->Name, loc_idex, itemName);

        std::stringstream tempStream;
        tempStream << std::hex << ItemQualityColors[itemTemplate->Quality];
        std::string itemQuality = tempStream.str();
        bool showChatMessage = !(player->GetPlayerSetting("mod-transmog", SETTING_HIDE_TRANSMOG).value) && !sT->CanNeverTransmog(itemTemplate);
        if (sT->AddCollectedAppearance(accountId, itemId))
        {
            if (showChatMessage)
                ChatHandler(player->GetSession()).PSendSysMessage( R"(|c{}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r {})", itemQuality, itemId, itemName, GetLocaleText(locale, "added_appearance"));

            CharacterDatabase.Execute( "INSERT INTO custom_unlocked_appearances (account_id, item_template_id) VALUES ({}, {})", accountId, itemId);
        }
    }

    void CheckRetroActiveQuestAppearances(Player* player)
    {
        const RewardedQuestSet& rewQuests = player->getRewardedQuests();
        for (RewardedQuestSet::const_iterator itr = rewQuests.begin(); itr != rewQuests.end(); ++itr)
        {
            Quest const* quest = sObjectMgr->GetQuestTemplate(*itr);
            OnPlayerCompleteQuest(player, quest);
        }
        player->UpdatePlayerSetting("mod-transmog", SETTING_RETROACTIVE_CHECK, 1);
    }
public:
    PS_Transmogrification() : PlayerScript("Player_Transmogrify") { }

    void OnEquip(Player* player, Item* it, uint8 /*bag*/, uint8 /*slot*/, bool /*update*/) override
    {
        if (!sT->GetUseCollectionSystem())
            return;
        AddToDatabase(player, it);
    }

    void OnLootItem(Player* player, Item* item, uint32 /*count*/, ObjectGuid /*lootguid*/) override
    {
        if (!sT->GetUseCollectionSystem() || !item || typeid(*item) != typeid(Item))
            return;
        if (item->GetTemplate()->Bonding == ItemBondingType::BIND_WHEN_PICKED_UP || item->IsSoulBound())
        {
            AddToDatabase(player, item);
        }
    }

    void OnCreateItem(Player* player, Item* item, uint32 /*count*/) override
    {
        if (!sT->GetUseCollectionSystem())
            return;
        if (item->GetTemplate()->Bonding == ItemBondingType::BIND_WHEN_PICKED_UP || item->IsSoulBound())
        {
            AddToDatabase(player, item);
        }
    }

    void OnAfterStoreOrEquipNewItem(Player* player, uint32 /*vendorslot*/, Item* item, uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/, ItemTemplate const* /*pProto*/, Creature* /*pVendor*/, VendorItem const* /*crItem*/, bool /*bStore*/) override
    {
        if (!sT->GetUseCollectionSystem())
            return;
        if (item->GetTemplate()->Bonding == ItemBondingType::BIND_WHEN_PICKED_UP || item->IsSoulBound())
        {
            AddToDatabase(player, item);
        }
    }

    void OnPlayerCompleteQuest(Player* player, Quest const* quest) override
    {
        if (!sT->GetUseCollectionSystem() || !quest)
            return;
        for (uint8 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
        {
            uint32 itemId = uint32(quest->RewardChoiceItemId[i]);
            if (!itemId)
                continue;
            ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);
            AddToDatabase(player, itemTemplate);
        }

        for (uint8 i = 0; i < QUEST_REWARDS_COUNT; ++i)
        {
            uint32 itemId = uint32(quest->RewardItemId[i]);
            if (!itemId)
                continue;
            ItemTemplate const* itemTemplate = sObjectMgr->GetItemTemplate(itemId);
            AddToDatabase(player, itemTemplate);
        }
    }

    void OnAfterSetVisibleItemSlot(Player* player, uint8 slot, Item *item) override
    {
        if (!item)
            return;

        if (uint32 entry = sT->GetFakeEntry(item->GetGUID()))
        {
            player->SetUInt32Value(PLAYER_VISIBLE_ITEM_1_ENTRYID + (slot * 2), entry);
        }
    }

    void OnAfterMoveItemFromInventory(Player* /*player*/, Item* it, uint8 /*bag*/, uint8 /*slot*/, bool /*update*/) override
    {
        sT->DeleteFakeFromDB(it->GetGUID().GetCounter());
    }

    void OnLogin(Player* player) override
    {
        if (sT->EnableResetRetroActiveAppearances())
            player->UpdatePlayerSetting("mod-transmog", SETTING_RETROACTIVE_CHECK, 0);

        if (sT->EnableRetroActiveAppearances() && !(player->GetPlayerSetting("mod-transmog", SETTING_RETROACTIVE_CHECK).value))
            CheckRetroActiveQuestAppearances(player);

        ObjectGuid playerGUID = player->GetGUID();
        sT->entryMap.erase(playerGUID);
        QueryResult result = CharacterDatabase.Query("SELECT GUID, FakeEntry FROM custom_transmogrification WHERE Owner = {}", player->GetGUID().GetCounter());
        if (result)
        {
            do
            {
                ObjectGuid itemGUID = ObjectGuid::Create<HighGuid::Item>((*result)[0].Get<uint32>());
                uint32 fakeEntry = (*result)[1].Get<uint32>();
                if (fakeEntry == HIDDEN_ITEM_ID || sObjectMgr->GetItemTemplate(fakeEntry))
                {
                    sT->dataMap[itemGUID] = playerGUID;
                    sT->entryMap[playerGUID][itemGUID] = fakeEntry;
                }
            } while (result->NextRow());

            for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
            {
                if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                    player->SetVisibleItemSlot(slot, item);
            }
        }

        if (sConfigMgr->GetOption<bool>("Transmogrification.EnablePlus", false))
        {
            uint32 accountId = 0;

            if (player->GetSession())
                accountId = player->GetSession()->GetAccountId();

            QueryResult resultAcc = LoginDatabase.Query("SELECT `membership_level`  FROM `acore_cms_subscriptions` WHERE `account_name` COLLATE utf8mb4_general_ci = (SELECT `username` FROM `account` WHERE `id` = {})", accountId);

            if (resultAcc)
                player->UpdatePlayerSetting("acore_cms_subscriptions", SETTING_TRANSMOG_MEMBERSHIP_LEVEL, (*resultAcc)[0].Get<uint32>());
        }

#ifdef PRESETS
        if (sT->GetEnableSets())
            sT->LoadPlayerSets(playerGUID);
#endif
    }

    void OnLogout(Player* player) override
    {
        ObjectGuid pGUID = player->GetGUID();
        for (Transmogrification::transmog2Data::const_iterator it = sT->entryMap[pGUID].begin(); it != sT->entryMap[pGUID].end(); ++it)
            sT->dataMap.erase(it->first);
        sT->entryMap.erase(pGUID);
        sT->selectionCache.erase(pGUID);

#ifdef PRESETS
        if (sT->GetEnableSets())
            sT->UnloadPlayerSets(pGUID);
#endif
    }

    void OnBeforeBuyItemFromVendor(Player* player, ObjectGuid vendorguid, uint32 /*vendorslot*/, uint32& itemEntry, uint8 /*count*/, uint8 /*bag*/, uint8 /*slot*/) override
    {
        Creature* vendor = player->GetMap()->GetCreature(vendorguid);
        if (!vendor)
            return;

        if (!sT->IsTransmogVendor(vendor->GetEntry()))
            return;

        uint8 slot = sT->selectionCache[player->GetGUID()];

        if (itemEntry == CUSTOM_HIDE_ITEM_VENDOR_ID || itemEntry == FALLBACK_HIDE_ITEM_VENDOR_ID)
        {
            PerformTransmogrification(player, UINT_MAX, 0);
        }
        else if (itemEntry == CUSTOM_REMOVE_TMOG_VENDOR_ID || itemEntry == FALLBACK_REMOVE_TMOG_VENDOR_ID)
        {
            RemoveTransmogrification(player);
        }
        else
        {
            PerformTransmogrification(player, itemEntry, 0);
        }
        npc_transmogrifier::ShowTransmogItemsInFakeVendor(player, vendor, slot); //Refresh menu
        itemEntry = 0; //Prevents the handler from proceeding to core vendor handling
    }
};

class WS_Transmogrification : public WorldScript
{
public:
    WS_Transmogrification() : WorldScript("WS_Transmogrification") { }

    void OnAfterConfigLoad(bool reload) override
    {
        sT->LoadConfig(reload);
        if (sT->GetUseCollectionSystem())
        {
            LOG_INFO("module", "Loading transmog appearance collection cache....");
            uint32 collectedAppearanceCount = 0;
            QueryResult result = CharacterDatabase.Query("SELECT account_id, item_template_id FROM custom_unlocked_appearances");
            if (result)
            {
                do
                {
                    uint32 accountId = (*result)[0].Get<uint32>();
                    uint32 itemId = (*result)[1].Get<uint32>();
                    if (sT->AddCollectedAppearance(accountId, itemId))
                    {
                        collectedAppearanceCount++;
                    }
                } while (result->NextRow());
            }
            LOG_INFO("module", "Loaded {} collected appearances into cache", collectedAppearanceCount);
        }
    }

    void OnStartup() override
    {
        sT->LoadConfig(false);
        //sLog->outInfo(LOG_FILTER_SERVER_LOADING, "Deleting non-existing transmogrification entries...");
        CharacterDatabase.Execute("DELETE FROM custom_transmogrification WHERE NOT EXISTS (SELECT 1 FROM item_instance WHERE item_instance.guid = custom_transmogrification.GUID)");

#ifdef PRESETS
        // Clean even if disabled
        // Dont delete even if player has more presets than should
        CharacterDatabase.Execute("DELETE FROM `custom_transmogrification_sets` WHERE NOT EXISTS(SELECT 1 FROM characters WHERE characters.guid = custom_transmogrification_sets.Owner)");
#endif
    }
};

class global_transmog_script : public GlobalScript
{
public:
    global_transmog_script() : GlobalScript("global_transmog_script") { }

    void OnItemDelFromDB(CharacterDatabaseTransaction trans, ObjectGuid::LowType itemGuid) override
    {
        sT->DeleteFakeFromDB(itemGuid, &trans);
    }

    void OnMirrorImageDisplayItem(const Item *item, uint32 &display) override
    {
        if (uint32 entry = sTransmogrification->GetFakeEntry(item->GetGUID()))
        {
            if (entry == HIDDEN_ITEM_ID)
            {
                display = 0;
            }
            else
            {
                display=uint32(sObjectMgr->GetItemTemplate(entry)->DisplayInfoID);
            }
        }
    }
};

class unit_transmog_script : public UnitScript
{
public:
    unit_transmog_script() : UnitScript("unit_transmog_script") { }

    bool ShouldTrackValuesUpdatePosByIndex(Unit const* unit, uint8 /*updateType*/, uint16 index) override
    {
        return unit->IsPlayer() && index >= PLAYER_VISIBLE_ITEM_1_ENTRYID && index <= PLAYER_VISIBLE_ITEM_19_ENTRYID && (index & 1);
    }

    void OnPatchValuesUpdate(Unit const* unit, ByteBuffer& valuesUpdateBuf, BuildValuesCachePosPointers& posPointers, Player* target) override
    {
        if (!unit->IsPlayer())
            return;

        for (auto it = posPointers.other.begin(); it != posPointers.other.end(); ++it)
        {
            uint16 index = it->first;
            if (index >= PLAYER_VISIBLE_ITEM_1_ENTRYID && index <= PLAYER_VISIBLE_ITEM_19_ENTRYID && (index & 1))
                if (Item* item = unit->ToPlayer()->GetItemByPos(INVENTORY_SLOT_BAG_0, ((index - PLAYER_VISIBLE_ITEM_1_ENTRYID) / 2U)))
                    if (!sTransmogrification->IsEnabled() || target->GetPlayerSetting("mod-transmog", SETTING_HIDE_TRANSMOG).value)
                        valuesUpdateBuf.put(it->second, item->GetEntry());
        }
    }
};

void AddSC_Transmog()
{
    new global_transmog_script();
    new unit_transmog_script();
    new npc_transmogrifier();
    new PS_Transmogrification();
    new WS_Transmogrification();
}
