#include "ServerMenuMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "../Profession/NpcProfessionMgr.h"
#include "../CustomTeleport/CustomTeleport.h"
#include "../DonatSysteme/DonatMgr.h"
#include "ArenaOnevsOne.h"

class ServerMenuPlayerGossip : public PlayerScript
{
public:
    ServerMenuPlayerGossip() : PlayerScript("ServerMenuPlayerGossip") { }

    void OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
    {    
        if (!player)
            return;

        if (menu_id != UNIQUE_MENU_ID)
            return; 

        ClearGossipMenuFor(player);

        switch (sender) {
            // Глобальные функции
            case GOSSIP_SENDER_MAIN: {
                switch (action) {
                    // Старт меню
                    case 0: sServerMenuMgr->GossipHelloMenu(player); break;
                    // Телепорт
                    case 1: sCustomTeleportMgr->TeleportListMain(player); break;
                    // Ранг система - ок
                    case 2: sServerMenuMgr->RankInfo(player); break;
                    // Магазин
                    case 3: DonationSystemeMgr->DonationSystemeListMain(player); break;
                    // Премиум
                    case 4: player->GetSession()->IsPremium() ? sServerMenuMgr->GetVipMenu(player) : sServerMenuMgr->GetVipMenuForBuy(player); break;
                    // Управление персонажем - ок
                    case 5: sServerMenuMgr->CharControlMenu(player); break;
                    // Управление акков
                    case 6: sServerMenuMgr->CommingSoon(player); break;
                    // Арена
                    case 7: ArenaOneMgr->ArenaMainMenu(player); break;
                    default: break;
                }
            } break;

            // Управление персонажем
            case GOSSIP_SENDER_MAIN + 1: {
                switch (action) {
                    // Банк
                    case 0: sServerMenuMgr->OpenBankSlot(player); break;
                    // Почта
                    case 1: sServerMenuMgr->OpenMailSlot(player); break;
                    // Смена фракции
                    case 2: sServerMenuMgr->ChangeRFN(player, 0); break;
                    // Смена рассы
                    case 3: sServerMenuMgr->ChangeRFN(player, 1); break;
                    // Смена ника
                    case 4: sServerMenuMgr->ChangeRFN(player, 2); break;
                    // Проффер
                    case 5: sProfessionMgr->MainMenu(player); break;
                    // Передача очков чести
                    case 6: sServerMenuMgr->OpenTradeHonor(player); break;
                    // Обменик очков чести
                    case 7: sServerMenuMgr->GossipMenuExchangeHonor(player); break;
                    // Сброс кд инстов
                    case 8: sServerMenuMgr->InstanceResetCooldown(player); break;
                    // Обменник эмблем
                    case 9: sServerMenuMgr->ExchangerToken(player); break;
                    // Ремонт предметов
                    case 10: sServerMenuMgr->RepairItems(player); break;
                    // Обмен очков чести на очки арены
                    case 11: sServerMenuMgr->GossipMenuExchangeArena(player); break;
                }
            } break;

            // меню профессий первый выбор
            case GOSSIP_SENDER_MAIN + 2: {
                switch (action) {
                    case 1: sProfessionMgr->PrimaryMenu(player); break; /* меню основных проф */
                    case 2: sProfessionMgr->SecondMenu(player);  break; /* меню вторичных проф */
                    default: break;
                }
            } break;

            // Обучение профессий
            case GOSSIP_SENDER_MAIN + 3: {
                if (!player->HasSkill(action))
                    sProfessionMgr->CompleteLearnProfession(player, action);
            } break;

            // Телепорт меню (первое)
            case GOSSIP_SENDER_MAIN + 4: {
                /* пересылаем на окно телепортации по пунктам в меню */
                sCustomTeleportMgr->GetTeleportListAfter(player, action, player->GetTeamId() == TEAM_HORDE ? 1 : 2);
            } break;

            // Окончательное меню телепорта
            case GOSSIP_SENDER_MAIN + 5: {
                /* портуем игрока в нужную ему точку */
                sCustomTeleportMgr->TeleportFunction(player, action);
            } break;

            // Раздел арены
            case GOSSIP_SENDER_MAIN + 6: {
                switch (action) {
                    case 1: ArenaOneMgr->CreateArenateam(player); break;
                    case 2: ArenaOneMgr->JoinQueue(player); break;
                    case 3: ArenaOneMgr->LeaveQueue(player); break;
                    case 4: sServerMenuMgr->GossipHelloMenu(player); break;
                }
            } break;

            // Раздел обменника очков чести
            case GOSSIP_SENDER_MAIN + 7: {
                sServerMenuMgr->ConfirmExchangeHonorForExp(player, action*150, action, action);
            } break;

            // Раздел обменника эмблем
            case GOSSIP_SENDER_MAIN + 8: {
                sServerMenuMgr->ExchangerConfirm(player, action == 1 ? true : false);
            } break;

            // Раздел VIP
            case GOSSIP_SENDER_MAIN + 9: {
                switch (action ) {
                    case 1: sServerMenuMgr->RemoveAuraForVip(player, false); break; /* слабость */
                    case 2: sServerMenuMgr->RemoveAuraForVip(player, true); break; /* дизертир */
                    case 3: sServerMenuMgr->VipSetBuff(player); break; /* баффы */
                    case 4: sServerMenuMgr->BuyVip(player, 7); break; /* купить вип на 7 дней */
                }
            } break;
            // Награда за ивенты (очки чести)
            case GOSSIP_SENDER_MAIN + 10: {
                sServerMenuMgr->RewardEvent(player, 1, action);
            } break;
            // Награда за ивенты (очки арены)
            case GOSSIP_SENDER_MAIN + 11: {
                sServerMenuMgr->RewardEvent(player, 2, action);
            } break;
            // Награда за ивенты (очки опыта)
            case GOSSIP_SENDER_MAIN + 12: {
                sServerMenuMgr->RewardEvent(player, 3, action);
            } break;

            // Магазин выбраная категория
            case GOSSIP_SENDER_MAIN + 13: {
                DonationSystemeMgr->GetDonationSystemeAfter(player, action, player->getClass());
            } break;

            // Магазин пред покупка предмета
            case GOSSIP_SENDER_MAIN + 14: {
                DonationSystemeMgr->DonatPayementFuction(player, action);
            } break;

            // Магазин покупка предмета
            case GOSSIP_SENDER_MAIN + 15: {
                DonationSystemeMgr->DonationFunction(player, action);
            } break;

            // Опции для доната (смена ника, итд)
            case GOSSIP_SENDER_MAIN + 16: {
                DonationSystemeMgr->DonatOption(player);
            } break; 

            case GOSSIP_SENDER_MAIN + 17: {
                sServerMenuMgr->ConfirmExchangeHonorForArena(player, action);
            } break; 
  
            default: break;
        } 
    }

    void OnGossipSelectCode(Player* player, uint32 /*menu_id*/, uint32 sender, uint32 action, const char* code)
    {
        ClearGossipMenuFor(player);
        switch (sender) {
            // Передача очков чести
            case GOSSIP_SENDER_MAIN: {
                sServerMenuMgr->TradeHonorAccept(player, action, code);
            } break;

            // Обмен эмблем льда на осколки
            case GOSSIP_SENDER_MAIN + 1: {
                sServerMenuMgr->ExchangeEmblemToShard(player, atoi(code));
            } break;
        }
    }
};

class SpServerMenuPlayerGossip : public SpellScriptLoader {
    public:
        SpServerMenuPlayerGossip() : SpellScriptLoader("SpServerMenuPlayerGossip") { }

        class SpServerMenuPlayerGossip_SpellScript : public SpellScript
        {
            PrepareSpellScript(SpServerMenuPlayerGossip_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                if (Player* player = GetCaster()->ToPlayer()) {
                    if (!sServerMenuMgr->CanOpenMenu(player))
                        sServerMenuMgr->GossipHelloMenu(player);
                }
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(SpServerMenuPlayerGossip_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new SpServerMenuPlayerGossip_SpellScript();
        }
};

class ExchagerToken : public CreatureScript
{
public:
    ExchagerToken() : CreatureScript("ExchagerToken") { }

    bool OnGossipHello(Player* player, Creature* /* creature */) 
    {
        if (!player)
            return true;

        sServerMenuMgr->ExchangerToken(player);
        return true;    
    }
};

void AddSC_ServerMenuPlayerGossip()
{
    new ServerMenuPlayerGossip();
    new SpServerMenuPlayerGossip();
    new ExchagerToken();
}
