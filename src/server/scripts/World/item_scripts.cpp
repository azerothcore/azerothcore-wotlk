/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ItemScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "Translate.h"
#include "WorldSession.h"
#include "../Custom/ServerMenu/ServerMenuMgr.h"


#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

/*#####
# item_only_for_flight
#####*/

enum OnlyForFlight
{
    SPELL_ARCANE_CHARGES    = 45072
};

class item_only_for_flight : public ItemScript
{
public:
    item_only_for_flight() : ItemScript("item_only_for_flight") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        uint32 itemId = item->GetEntry();
        bool disabled = false;

        //for special scripts
        switch (itemId)
        {
            case 24538:
                if (player->GetAreaId() != 3628)
                    disabled = true;
                break;
            case 34489:
                if (player->GetZoneId() != 4080)
                    disabled = true;
                break;
            case 34475:
                if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_ARCANE_CHARGES))
                    Spell::SendCastResult(player, spellInfo, 1, SPELL_FAILED_NOT_ON_GROUND);
                break;
        }

        // allow use in flight only
        if (player->IsInFlight() && !disabled)
            return false;

        // error
        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, nullptr);
        return true;
    }
};

/*#####
# item_incendiary_explosives
#####*/

class item_incendiary_explosives : public ItemScript
{
public:
    item_incendiary_explosives() : ItemScript("item_incendiary_explosives") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        if (player->FindNearestCreature(26248, 15) || player->FindNearestCreature(26249, 15))
            return false;
        else
        {
            player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, nullptr);
            return true;
        }
    }
};

/*#####
# item_mysterious_egg
#####*/

class item_mysterious_egg : public ItemScript
{
public:
    item_mysterious_egg() : ItemScript("item_mysterious_egg") { }

    bool OnExpire(Player* player, ItemTemplate const* /*pItemProto*/) override
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 39883, 1); // Cracked Egg
        if (msg == EQUIP_ERR_OK)
            player->StoreNewItem(dest, 39883, true);

        return true;
    }
};

/*#####
# item_disgusting_jar
#####*/

class item_disgusting_jar : public ItemScript
{
public:
    item_disgusting_jar() : ItemScript("item_disgusting_jar") { }

    bool OnExpire(Player* player, ItemTemplate const* /*pItemProto*/) override
    {
        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 44718, 1); // Ripe Disgusting Jar
        if (msg == EQUIP_ERR_OK)
            player->StoreNewItem(dest, 44718, true);

        return true;
    }
};

/*#####
# item_petrov_cluster_bombs
#####*/

enum PetrovClusterBombs
{
    SPELL_PETROV_BOMB           = 42406,
    AREA_ID_SHATTERED_STRAITS   = 4064,
    ZONE_ID_HOWLING             = 495
};

class item_petrov_cluster_bombs : public ItemScript
{
public:
    item_petrov_cluster_bombs() : ItemScript("item_petrov_cluster_bombs") { }

    bool OnUse(Player* player, Item* item, const SpellCastTargets& /*targets*/) override
    {
        if (player->GetZoneId() != ZONE_ID_HOWLING)
            return false;

        if (!player->GetTransport() || player->GetAreaId() != AREA_ID_SHATTERED_STRAITS)
        {
            player->SendEquipError(EQUIP_ERR_NONE, item, nullptr);

            if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_PETROV_BOMB))
                Spell::SendCastResult(player, spellInfo, 1, SPELL_FAILED_NOT_HERE);

            return true;
        }

        return false;
    }
};

enum CapturedFrog
{
    QUEST_THE_PERFECT_SPIES      = 25444,
    NPC_VANIRAS_SENTRY_TOTEM     = 40187
};

class item_captured_frog : public ItemScript
{
public:
    item_captured_frog() : ItemScript("item_captured_frog") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        if (player->GetQuestStatus(QUEST_THE_PERFECT_SPIES) == QUEST_STATUS_INCOMPLETE)
        {
            if (player->FindNearestCreature(NPC_VANIRAS_SENTRY_TOTEM, 10.0f))
                return false;
            else
                player->SendEquipError(EQUIP_ERR_OUT_OF_RANGE, item, nullptr);
        }
        else
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, nullptr);
        return true;
    }
};

// Only used currently for
// 19169: Nightfall
class item_generic_limit_chance_above_60 : public ItemScript
{
public:
    item_generic_limit_chance_above_60() : ItemScript("item_generic_limit_chance_above_60") { }

    bool OnCastItemCombatSpell(Player* /*player*/, Unit* victim, SpellInfo const* /*spellInfo*/, Item* /*item*/) override
    {
        // spell proc chance gets severely reduced on victims > 60 (formula unknown)
        if (victim->GetLevel() > 60)
        {
            // gives ~0.1% proc chance at lvl 70
            float const lvlPenaltyFactor = 9.93f;
            float const failureChance = (victim->GetLevel() - 60) * lvlPenaltyFactor;

            // base ppm chance was already rolled, only roll success chance
            return !roll_chance_f(failureChance);
        }

        return true;
    }
};

class RandomMorphItem : public ItemScript
{
public:
    RandomMorphItem() : ItemScript("RandomMorphItem") { }

    static constexpr uint32 tab[3] = {29001, 29002, 29003};

    bool OnUse(Player* player, Item* /*item*/, SpellCastTargets const& /*targets*/) override
    {
        player->CastSpell(player, urand(tab[0], tab[2]), true);
        return false;
    }
};

class BonusGetOnAccountItem : public ItemScript
{
public:
    BonusGetOnAccountItem() : ItemScript("BonusGetOnAccountItem") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override
    {
        /* ид предмета */
        uint32 entry = item->GetEntry();
        /* выводим количество предметов */
        uint32 count = player->GetItemCount(entry, true);
        /* выводим бонусы игрока */
        uint32 bonuses = player->GetSession()->GetBonuses();
        /* удаляем предметы */
        player->DestroyItemCount(entry, count, true);
        /* выдаем бонусы */
        player->GetSession()->SetBonuses(bonuses + count);
        /* анонс игроку */
        ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, RU_GET_BONUS_USE_ITEM, EN_GET_BONUS_USE_ITEM), count);
        return true;
    }
};

class ItemUse_Glory_Exp : public ItemScript
{
public:
    ItemUse_Glory_Exp() : ItemScript("ItemUse_Glory_Exp") { }

    bool OnUse(Player* pPlayer, Item* pItem, const SpellCastTargets& /*pTargets*/) override
    {
        if (!pPlayer || !pItem)
            return true;

        if (pPlayer->GetAuraCount(71201) >= 100)
            return true;            

        uint32 entry = pItem->GetEntry();
        uint32 rate = 0;

        if (pPlayer->GetAuraCount(71201) < 100) {
            switch (entry) {
                case 1042:
                    rate = 50;
                    break;
                case 1043:
                    rate = 100;
                    break;
                case 1044:
                    rate = 250;
                    break;
                case 35778:
                    rate = 1000;
                    break;
                case 842:
                    rate = 5000;
                    break;
                default:
                    break;
            }
        }

        if (rate != 0)
        {
            pPlayer->DestroyItemCount(entry,1,true);
            pPlayer->RewardRankPoints(rate, 4);
        }
        else
            ChatHandler(pPlayer->GetSession()).PSendSysMessage(GetText(pPlayer,"Вам нужен более высокий ранг для использование данного предмета.","You need a higher rank to use this item."));
        return true;
    }
};

class PremiumItemGetter : public ItemScript
{
public:
    PremiumItemGetter() : ItemScript("PremiumItemGetter") { }

    bool OnUse(Player* pPlayer, Item* pItem, const SpellCastTargets& /*pTargets*/) override
    {
        if (!pPlayer || !pItem)
            return true;

        if (pPlayer->GetSession()->IsPremium()) {
            ChatHandler(pPlayer->GetSession()).PSendSysMessage(GetText(pPlayer, 
            "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Премиум Аккаунт]: Дождитеcь окончание премиума перед использованием.", 
            "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Premium Account]: Wait until the end of the premium before using"));
            return true;
        }    

        uint32 entry = pItem->GetEntry();
        uint32 days = 1;

        switch (entry) {
            // 1 день
            case 34631: days = 1; break;
            // 7 дней    
            case 34632: days = 7; break;
            // 31 дня
            case 34633: days = 31; break;
            default: break;
        }

        pPlayer->DestroyItemCount(entry, 1, true);
        sServerMenuMgr->GetVipStatus(pPlayer, days);
        return true;
    }
};

class LotoRollItem : public ItemScript
{
public:
    LotoRollItem() : ItemScript("LotoRollItem") { }

    bool OnUse(Player* pPlayer, Item* pItem, const SpellCastTargets& /*pTargets*/) override
    {
        if (!pPlayer || !pItem)
            return true;

        // генерация рандом номера
        uint8 randomNumber = urand(1, 100);
        if (!randomNumber)
            return true;

        uint32 entry = pItem->GetEntry();
        if (!entry)
            return true;    

        std::ostringstream rus;
        std::ostringstream eng;

        rus << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Русская рулетка]: ";
        eng << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Russian roulette]: ";

        switch(randomNumber) {
            case 1:                                     // 1% - 2500 очков арены
                pPlayer->ModifyArenaPoints(2500);
                rus << "Вы получили |cffffff4d2500|cffff9933 очков арены.";
                eng << "You got |cffffff4d2500|cffff9933 arena points.";
                break;              
            case 2 ... 5:                                // 4% - 250к очков чести
                pPlayer->ModifyHonorPoints(250000);
                rus << "Вы получили |cffffff4d250 000|cffff9933 очков чести.";
                eng << "You got |cffffff4d250 000|cffff9933 honor points.";        
                break;      
            case 6 ... 10:                               // 5% - 10 бонусов 
                pPlayer->AddItem(38570, 10);
                rus << "Вы получили |cffffff4d10|cffff9933 бонусов.";
                eng << "You got |cffffff4d10|cffff9933 bonuses."; 
                break;   
            case 11 ... 20:                              // 10% - забирает 50к очков чести
                pPlayer->ModifyHonorPoints(-50000);
                rus << "Вы проеб@ли |cffffff4d50 000|cffff9933 очков чести.";
                eng << "You fucked up |cffffff4d50 000|cffff9933 honor points.";
                break;     
            case 21 ... 30:                              // 10% - 100 Осколоков каменного хранителя
                pPlayer->AddItem(43228, 100);
                rus << "Вы получили |cffffff4d100|cffff9933 осколоков каменного хранителя.";
                eng << "You got |cffffff4d100|cffff9933 stone keeper's shard.";   
                break;           
            case 31 ... 50:                              // 20% - Просто убивает вас (русская рулетка же)
                pPlayer->CastSpell(pPlayer, 74090, false); 
                rus << "Вы получили |cffffff4dп#зды|cffff9933.";
                eng << "You got |cffffff4dcunts|cffff9933.";
                break;              
            case 51 ... 52:                              // 2% - 3 жетона русской рулетки
                pPlayer->AddItem(52361, 3);
                rus << "Вы получили |cffffff4d3|cffff9933 жетона русской рулетки.";
                eng << "You got |cffffff4d3|cffff9933 russian roulette tokens.";    
                break;             
            case 53 ... 60:                              // 9% - забирает 50 очков арены
                pPlayer->ModifyArenaPoints(-50);
                rus << "Вы потеряли |cffffff4d50|cffff9933 очков арены.";
                eng << "You lost |cffffff4d50|cffff9933 arena points."; 
                break;         
            case 61 ... 90:                              // 30% - 2 слитка по 250 опыта для ранга
                pPlayer->AddItem(1044, 2); 
                rus << "Вы получили |cffffff4d2|cffff9933 слитка по 250 опыта для ранга.";
                eng << "You got |cffffff4d2|cffff9933 250 xp ingot per rank."; 
                break;
            case 91 ... 95:                              // 5% - Премиум аккаунт на 1 день
                pPlayer->AddItem(34631, 1);
                rus << "Вы получили |cffffff4d1|cffff9933 премиум аккаунт на 1 день.";
                eng << "You got |cffffff4d1|cffff9933 premium account for 1 day.";
                break;
            case 96 ... 99:                              // 4% - 10 слитков по 1к опыта для ранга
                pPlayer->AddItem(35778, 10); 
                rus << "Вы получили |cffffff4d10|cffff9933 слитка по 1 000 опыта для ранга.";
                eng << "You got |cffffff4d10|cffff9933 1000 xp ingot per rank.";
                break;            
            case 100:                                   // 1% - 10 слитков по 5к опыта для ранга
                pPlayer->AddItem(842, 10);
                rus << "Вы получили |cffffff4d10|cffff9933 слитка по 5 000 опыта для ранга.";
                eng << "You got |cffffff4d10|cffff9933 5 000 xp ingot per rank.";
                break;                   
            default: 
                rus << "Ошибка";
                eng << "Error";
                break;
        }

        pPlayer->DestroyItemCount(entry, 1, true);
        ChatHandler(pPlayer->GetSession()).PSendSysMessage(GetText(pPlayer, rus.str().c_str(), eng.str().c_str()));
        return true;
    }
};

class EventItemReward : public ItemScript
{
public:
    EventItemReward() : ItemScript("EventItemReward") { }

    bool OnUse(Player* pPlayer, Item* pItem, const SpellCastTargets& /*pTargets*/) override
    {
        if (!pPlayer || !pItem)
            return true;

        uint32 entry = pItem->GetEntry();

        if (!entry)
            return true;

        uint32 prize = 3;
        bool bigEvent = false;

        // назначаем ID приза за ивент
        sServerMenuMgr->SetItemRewardID(entry);                       

        switch (entry) {
            case 34634: bigEvent = true; prize = 1; break;
            case 34635: bigEvent = true; prize = 2; break;
            case 34636: bigEvent = true; prize = 3; break;
            case 34628: bigEvent = false; prize = 1; break;
            case 34629: bigEvent = false; prize = 2; break;
            case 20486: /* авто ивент осада столиц */
            case 34630: bigEvent = false; prize = 3; break;
            default: break;
        }

        sServerMenuMgr->GossipMenuEventReward(pPlayer, entry, bigEvent, prize);
        return true;
    }
};

void AddSC_item_scripts()
{
    new item_only_for_flight();
    new item_incendiary_explosives();
    new item_mysterious_egg();
    new item_disgusting_jar();
    new item_petrov_cluster_bombs();
    new item_captured_frog();
    new item_generic_limit_chance_above_60();
    new BonusGetOnAccountItem();
    new RandomMorphItem();
    new ItemUse_Glory_Exp();
    new PremiumItemGetter();
    new LotoRollItem();
    new EventItemReward();
}
