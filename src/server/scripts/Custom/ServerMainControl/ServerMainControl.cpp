#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "Chat.h"
#include "Define.h"
#include "GossipDef.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "ServerMenuMgr.h"
#include "Translate.h"

using namespace Acore::ChatCommands;

class ServerMenuPlayerGossip : public PlayerScript
{
public:
    ServerMenuPlayerGossip() : PlayerScript("ServerMenuPlayerGossip") { }

    void GossipHello(Player* player)
    {
        ClearGossipMenuFor(player);
        return OnGossipHello(player);
    }

    void OnGossipHello(Player* player) {
        if (!sServerMenuMgr->CanOpenMenu(player)) /* проверка на разрешение открыть спелл */
            sServerMenuMgr->BodyMenu(player, GossipHelloMenu);
        return;
    }

    void OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
    {
        ClearGossipMenuFor(player);
        switch (menu_id) {
            case GossipHelloMenu: {
                switch (sender) {
                    case GOSSIP_SENDER_MAIN: {
                        switch (action) {
                            case GossipHelloMenu: OnGossipHello(player); break; /* открытие главное меню */
                            case GossipHelloMenu + 1: sServerMenuMgr->TeleportListMain(player); break; /* меню телепортации */
                            // case GossipHelloMenu + 2: player->GetSession()->SendListInventory(player->GetGUID(), 44065); break; /* пвп ранги */
                            // case GossipHelloMenu + 3: break; /* магазин */
                            // case GossipHelloMenu + 4: OnGossipSelect(player, GossipHelloMenu, player->GetSession()->IsPremium() ? GOSSIP_SENDER_MAIN + 3 : GOSSIP_SENDER_MAIN + 4, 0); break;
                            // case GossipHelloMenu + 5: OnGossipSelect(player, GossipHelloMenu, GOSSIP_SENDER_MAIN + 5, 0); break; /* Управление персонажем */
                            // case GossipHelloMenu + 6: break; /* Управление аккаунтом */
                            // case GossipHelloMenu + 7: sScriptMgr->OnGossipSelect(player, GossipHelloMenu + 1, GOSSIP_SENDER_MAIN, 0); break; /* арена */
                        }
                    } break;
                    case GOSSIP_SENDER_MAIN + 1: {
                        /* пересылаем на окно телепортации по пунктам в меню */
                        sServerMenuMgr->GetTeleportListAfter(player, action, player->GetTeamId() == TEAM_HORDE ? 1 : 2);
                    } break;
                    case GOSSIP_SENDER_MAIN + 2: {
                        /* портуем игрока в нужную ему точку */
                        sServerMenuMgr->TeleportFunction(player, action);
                    } break;
                    /* управление персонажем */
                    case GOSSIP_SENDER_MAIN + 5: {
                        switch (action) {
                            case 0: sServerMenuMgr->CharControlMenu(player); break;                /* меню персонажа */
                            case GossipHelloMenu: sServerMenuMgr->OpenBankSlot(player); break;     /* банк */
                            case GossipHelloMenu + 1: sServerMenuMgr->OpenMailSlot(player); break; /* почта */
                            case GossipHelloMenu + 2: sScriptMgr->OnGossipSelect(player, GossipHelloMenu + 2, GOSSIP_SENDER_MAIN, 0); break;
                            case GossipHelloMenu + 3: sServerMenuMgr->ChangeRFN(player, GossipHelloMenu); break;      /* смена фракции */
                            case GossipHelloMenu + 4: sServerMenuMgr->ChangeRFN(player, GossipHelloMenu + 1); break;  /* смена расы */
                            case GossipHelloMenu + 5: sServerMenuMgr->ChangeRFN(player, GossipHelloMenu + 2); break;  /* смена ника */
                        }
                    } break;

                    default: break;
                }
            } break;

            /* ################################ КОНЕЦ МОДУЛЯ АРЕНЫ ################################ */

            /* ################################ КОНЕЦ МОДУЛЯ  ################################ */

            /* ################################ Модуль быстрого старта ################################ */

            /* ################################ Конец модуля быстрого старта ################################ */

            default: { /* если нету такого меню ид */
                ChatHandler(player->GetSession()).PSendSysMessage(GetText(player,RU_NOT_FOUND_MENU, EN_NOT_FOUND_MENU), menu_id);
                player->PlayerTalkClass->SendCloseGossip();
            } break;
        }
    }

    void OnGossipSelectCode(Player* player, uint32 /*menu_id*/, uint32 sender, uint32 action, const char* code)
    {
        ClearGossipMenuFor(player);
        switch (sender) {
            // case GOSSIP_SENDER_MAIN + 4: { /* VIP */
            //     switch (action) {
            //         case GossipHelloMenu: sServerMenuMgr->BuyVip(player, atoi(code)); break; /* покупка VIP code <- кол дней */
            //     }
            // }
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
				if (Player* player = GetCaster()->ToPlayer())
                	sScriptMgr->OnGossipSelect(player, GossipHelloMenu, GOSSIP_SENDER_MAIN, GossipHelloMenu);
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

class ServerMenu_World : public WorldScript
{
public:
    ServerMenu_World() : WorldScript("ServerMenu_World") { }

    void OnStartup() override
    {
        // создаем базу если не создано
        CharacterDatabase.DirectExecute(sServerMenuMgr->sql_buffs);
        CharacterDatabase.DirectExecute(sServerMenuMgr->sql_titles);
        CharacterDatabase.DirectExecute(sServerMenuMgr->sql_teleportlist);

        // прогрузка баффов
        LOG_INFO("server.LoadMenu", ">> ServerMenu: Loading ServerMenu buffs ...");
        sServerMenuMgr->LoadBuffsContainer();

        // Прогрузка званий
        LOG_INFO("server.LoadMenu", ">> ServerMenu: Loading ServerMenu titles ...");
        sServerMenuMgr->LoadTitlesContainer();

        // прогрузка телепорт мест
        LOG_INFO("server.LoadMenu", ">> ServerMenu: Loading ServerMenu teleport lists ...");
        sServerMenuMgr->LoadTeleportListContainer();
    }
};

class ServerMenu_command : public CommandScript
{
public:
    ServerMenu_command() : CommandScript("ServerMenu_command") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable ServerMenuTable =
        {
            { "all",      SEC_ADMINISTRATOR, false, &HandleReloadServerMenuCommand, "" }
        };

        static ChatCommandTable JoinOloCommand =
        {
            { "olo",      SEC_PLAYER, false, &HandleJoinOloCommand, "" }
        };

        // static ChatCommandTable DeathmatchTable =
        // {
        //     { "join", SEC_PLAYER, false, &HandleJoinDmCommand, "" },
        //     { "exit", SEC_PLAYER, false, &HandleExitDmCommand, "" }
        // };

        static ChatCommandTable commandTable =
        {
            { "servermenureload", SEC_ADMINISTRATOR, true, nullptr, "", ServerMenuTable },
            { "join", SEC_PLAYER, true, nullptr, "", JoinOloCommand },
            // { "dm", SEC_PLAYER, true, nullptr, "", DeathmatchTable }
        };
        return commandTable;
    }

    // static bool HandleJoinDmCommand(ChatHandler* handler, char const* /*args*/)
    // {
    //     Player* targetPlayer = handler->GetSession()->GetPlayer();
    //     if(!targetPlayer)
    //         return true;

    //     DeathMatchMgr->AddPlayer(targetPlayer);
    //     return true;
    // }

    // static bool HandleExitDmCommand(ChatHandler* handler, char const* /*args*/)
    // {
    //     Player* targetPlayer = handler->GetSession()->GetPlayer();
    //     if(!targetPlayer)
    //         return true;

    //     if (targetPlayer->IsDeathMatch())
    //         DeathMatchMgr->RemovePlayer(targetPlayer);
    //     return true;
    // }

    static bool HandleJoinOloCommand(ChatHandler* handler, char const* /*args*/)
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

    static bool HandleReloadServerMenuCommand(ChatHandler* handler, const char* /*args*/)
    {
        LOG_INFO("server.LoadMenu", "Reloading ServerMenu Table...");
        sServerMenuMgr->LoadBuffsContainer();
        sServerMenuMgr->LoadTitlesContainer();
        sServerMenuMgr->LoadTeleportListContainer();
        handler->SendGlobalGMSysMessage("DB table `server_menu_teleportlist`reloaded.\nDB table `server_menu_buffs`reloaded.\nDB table `server_menu_titles`reloaded.");
        return true;
    }
};

class TeleportMaster : public CreatureScript
{
public:
    TeleportMaster() : CreatureScript("TeleportMaster") {}

    bool OnGossipHello(Player* player, Creature* /*creature*/)
    {
        sScriptMgr->OnGossipSelect(player, GossipHelloMenu, GOSSIP_SENDER_MAIN, GossipHelloMenu + 1);
        return true;
    }
};

void AddSC_ServerMenuPlayerGossip()
{
    new ServerMenuPlayerGossip();
    new SpServerMenuPlayerGossip();
    new ServerMenu_World();
    new ServerMenu_command();
    new TeleportMaster();
}