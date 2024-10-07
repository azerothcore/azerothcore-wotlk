#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Chat.h"
#include "Define.h"
#include "GossipDef.h"
#include "Language.h"
#include "Player.h"
#include "Translate.h"
#include "ScriptedGossip.h"
#include "CustomTeleport.h"
#include "ScriptMgr.h"

#define GossipHelloMenuID 0
using namespace Acore::ChatCommands;

/* ################  загрузка таблиц ################ */
void sCustomTeleport::LoadTeleportListContainer() {
    for (sCustomTeleport::TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr)
        delete *itr;

    m_TeleportList_Container.clear();

    QueryResult result = CharacterDatabase.Query("SELECT id, gossip_menu, faction, cost, name_RU, name_EN, map, position_x, position_y, position_z, orientation FROM server_menu_teleportlist ORDER BY id;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("Custom.TeleportMaster", ">> TeleportMaster: Loaded 0 'teleportlist. DB table `server_menu_teleportlist` is empty!.");
        return;
    }

    do
    {
        Field* fields            = result->Fetch();
        TeleportListSTR* pTele   = new TeleportListSTR;
        pTele->id                = fields[0].Get<uint32>();
        pTele->gossip_menu       = fields[1].Get<uint8>();
        pTele->faction           = fields[2].Get<uint8>();
        pTele->cost              = fields[3].Get<uint32>();
        pTele->name_RU           = fields[4].Get<std::string>();
        pTele->name_EN           = fields[5].Get<std::string>();
        pTele->map               = fields[6].Get<uint16>();
        pTele->position_x        = fields[7].Get<float>();
        pTele->position_y        = fields[8].Get<float>();
        pTele->position_z        = fields[9].Get<float>();
        pTele->orientation       = fields[10].Get<float>();

        m_TeleportList_Container.push_back(pTele);
        ++count;
    } while (result->NextRow());

    LOG_INFO("Custom.TeleportMaster", ">> TeleportMaster: Loaded {} teleportlist in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sCustomTeleport::TeleportListMain(Player* player, Creature* creature) {
    ClearGossipMenuFor(player);
    for (sCustomTeleport::TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr)
        if((*itr)->gossip_menu == 0)
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, (*itr)->name_RU, (*itr)->name_EN), GOSSIP_SENDER_MAIN + 1, (*itr)->id);
    AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, GetText(player, RU_HOME_MENU_NO_ICON, EN_HOME_MENU_NO_ICON), GOSSIP_SENDER_MAIN, GossipHelloMenuID);
    player->PlayerTalkClass->SendGossipMenu(HeadMenu(player), creature->GetGUID());
}

void sCustomTeleport::GetTeleportListAfter(Player* player, Creature* creature, uint32 action, uint8 faction) {
    ClearGossipMenuFor(player);
    for (sCustomTeleport::TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr) {
        if((*itr)->gossip_menu != 0 && (*itr)->gossip_menu == action && ((*itr)->faction == faction || (*itr)->faction == 3)) {
            AddGossipItemFor(player, GOSSIP_ICON_TAXI, GetText(player, (*itr)->name_RU + ConverterMoneyToGold(player, CalculRequiredMoney(player, (*itr)->cost)), (*itr)->name_EN +
            ConverterMoneyToGold(player, CalculRequiredMoney(player, (*itr)->cost))),
            GOSSIP_SENDER_MAIN + 2, (*itr)->id, ConfirmMoneyTeleport(player, GetText(player, (*itr)->name_RU, (*itr)->name_EN)),
            CalculRequiredMoney(player, (*itr)->cost), false);
        }
    }
    AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetText(player, RU_HOME_MENU_NO_ICON, EN_HOME_MENU_NO_ICON), GOSSIP_SENDER_MAIN, GossipHelloMenuID + 1);
    player->PlayerTalkClass->SendGossipMenu(HeadMenu(player), creature->GetGUID());
}

void sCustomTeleport::TeleportFunction(Player* player, uint32 i) {
    for (sCustomTeleport::TeleportList_Container::const_iterator itr = m_TeleportList_Container.begin(); itr != m_TeleportList_Container.end(); ++itr) {
        if((*itr)->id == i) {
            player->TeleportTo((*itr)->map, (*itr)->position_x, (*itr)->position_y, (*itr)->position_z, (*itr)->orientation);
            player->ModifyMoney(-CalculRequiredMoney(player, (*itr)->cost));
            ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, RU_SUCCESS_TELEPORT, EN_SUCCESS_TELEPORT), GetText(player, (*itr)->name_RU.c_str(), (*itr)->name_EN.c_str()));
            player->PlayerTalkClass->SendCloseGossip();
            break;
        }
    }
}

std::string sCustomTeleport::HeadMenu(Player* player) {
    std::stringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU) {
        ss << "Телепортация по всему миру:\nТелепорт платный по миру, все собранные ресурсы пойдут на благополучный фонд бездомных собак.\n\n";
        ss << "|cffff0000Важно!|r Чем выше ваш ранг тем дешевле будет стоить телепортация.";
    }
    else {
        ss << "Teleportation around the world:\nTeleport paid worldwide, all collected resources will go to a safe foundation of stray dogs.\n\n";
        ss << "|cffff0000Important!|r The higher your rank, the cheaper it will be to teleport.";
    }
    return ss.str();
}

uint32 sCustomTeleport::CalculRequiredMoney(Player* player, uint32 money) {
    /* количество рангов (1 ранг = 2% скидка) */
    uint8 count = player->GetAuraCount(71201);
    return ((money/100) * (100 - (count*2)));
}

std::string sCustomTeleport::ConverterMoneyToGold(Player* player, uint32 money) {
    uint32 gold = money / GOLD;
    uint32 silv = (money % GOLD) / SILVER;
    uint32 copp = (money % GOLD) % SILVER;

    std::stringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        ss << "\nНужно заплатить: ";
    else
        ss << "\nNeed to pay: ";

    if (money == 0)
        ss << "0|TInterface\\moneyframe\\ui-coppericon:11:11:2:0|t";
    else {
        if(gold > 0)
            ss << gold <<"|TInterface\\moneyframe\\ui-goldicon:11:11:2:0|t ";
        if(silv > 0)
        ss << silv << "|TInterface\\moneyframe\\ui-silvericon:11:11:2:0|t ";
        if(copp > 0)
        ss << copp << "|TInterface\\moneyframe\\ui-coppericon:11:11:2:0|t";
    }
    return ss.str();
}

std::string sCustomTeleport::ConfirmMoneyTeleport(Player* player, std::string telename) {
    std::stringstream ss;
    if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        ss << "Вы уверены что хотите попасть в зону\n    <" << telename << ">\nза указанную сумму ниже ?\n";
    else
        ss << "Are you sure you want to get into the zone\n    <" << telename << ">\nfor the indicated amount below ?\n";
    return ss.str();
}

class TeleportMaster : public CreatureScript
{
public:
    TeleportMaster() : CreatureScript("TeleportMaster") { }

    bool OnGossipHello(Player* player, Creature* creature) {
        /* проверка на разрешение открыть спелл */
        if (!CanOpenMenu(player))
            sCustomTeleportMgr->TeleportListMain(player, creature);
        return true;    
    }

    bool CanOpenMenu(Player* player) {
        if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena()
            || player->HasStealthAura() || player->isDead() || (player->getClass() == CLASS_DEATH_KNIGHT && player->GetMapId() == 609 && !player->IsGameMaster() && !player->HasSpell(50977))) {
            ChatHandler(player->GetSession()).PSendSysMessage(GetText(player, "Сейчас это невозможно.", "Now it is impossible"));
            return true;
        }
        return false;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        if (!player || !creature)
            return false;

        player->PlayerTalkClass->ClearMenus();

        switch (sender) {
            case GOSSIP_SENDER_MAIN: { /* обычные функции */
                switch (action) {
                    case GossipHelloMenuID: { /* закрыть меню */
                        player->PlayerTalkClass->ClearMenus();
                        break;
                    }
                    case GossipHelloMenuID + 1: { /* меню телепортации - главная */
                        OnGossipHello(player, creature);
                        break;
                    }    
                }
                break;
            }
            case GOSSIP_SENDER_MAIN + 1: { /* листинг точек для тп */
                /* пересылаем на окно телепортации по пунктам в меню */
                sCustomTeleportMgr->GetTeleportListAfter(player, creature, action, player->GetTeamId() == TEAM_HORDE ? 1 : 2);
                break;
            }

            case GOSSIP_SENDER_MAIN + 2: { /* листинг уже готовых тп точек */
                /* портуем игрока в нужную ему точку */
                sCustomTeleportMgr->TeleportFunction(player, action);
                break;
            }    
        }
        return true;
    }
};


class CustomTeleport_World : public WorldScript
{
public:
    CustomTeleport_World() : WorldScript("CustomTeleport_World") { }

    void OnStartup() override
    {
        // создаем базу если не создано
        CharacterDatabase.DirectExecute(sCustomTeleportMgr->sql_teleportlist);

        // прогрузка телепорт мест
        LOG_INFO("Custom.TeleportMaster", ">> TeleportMaster: Loading teleport lists ...");
        sCustomTeleportMgr->LoadTeleportListContainer();
    }
};

class CustomTeleport_command : public CommandScript
{
public:
    CustomTeleport_command() : CommandScript("CustomTeleport_command") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable ServerMenuTable =
        {
            {"reload", HandleReloadServerMenuCommand, SEC_ADMINISTRATOR, Console::No},
        };

        static ChatCommandTable JoinOloCommand =
        {
            {"olo", HandleJoinOloCommand, SEC_PLAYER, Console::No},
        };

        static ChatCommandTable commandTable =
        {
            { "tpmaster", ServerMenuTable },
            { "join", JoinOloCommand },
        };
        return commandTable;
    }

    static bool HandleJoinOloCommand(ChatHandler* handler)
    {
        Player* targetPlayer = handler->GetSession()->GetPlayer();
        if(!targetPlayer)
            return true;

        if (targetPlayer->getLevel() < sWorld->getIntConfig(CONFIG_WINTERGRASP_PLR_MIN_LVL))
            return true;

        if(targetPlayer->IsInFlight() || targetPlayer->GetMap()->IsBattlegroundOrArena())
            return true;

        Battlefield* wintergrasp = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
        if(wintergrasp->IsWarTime()) /* приглашаем на оло если началось уже */
            wintergrasp->InvitePlayerToWar(targetPlayer);
        else /* приглашаем в очередь */
            wintergrasp->InvitePlayerToQueue(targetPlayer);
        return true;
    }

    static bool HandleReloadServerMenuCommand(ChatHandler* handler)
    {
        LOG_INFO("Custom.TeleportMaster", ">> Reloading `server_menu_teleportlist` table.");
        sCustomTeleportMgr->LoadTeleportListContainer();
        handler->SendGlobalGMSysMessage("DB table `server_menu_teleportlist` reloaded.");
        return true;
    }
};

void AddSC_CustomTeleportOrCommand()
{
    new TeleportMaster();
    new CustomTeleport_World();
    new CustomTeleport_command();
}