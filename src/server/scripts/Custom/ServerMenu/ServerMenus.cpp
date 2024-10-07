#include "ServerMenuMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "../Profession/NpcProfessionMgr.h"
#include "../CustomTeleport/CustomTeleport.h"

class ServerMenuPlayerGossip : public PlayerScript
{
public:
    ServerMenuPlayerGossip() : PlayerScript("ServerMenuPlayerGossip") { }

    void OnGossipSelect(Player* player, uint32 /*menu_id*/, uint32 sender, uint32 action)
    {    
        if (!player)
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
                    case 3: sServerMenuMgr->CommingSoon(player);break;
                    // Премиум
                    case 4: sServerMenuMgr->CommingSoon(player); break;
                    // Управление персонажем - ок
                    case 5: sServerMenuMgr->CharControlMenu(player); break;
                    // Управление акков
                    case 6: sServerMenuMgr->CommingSoon(player); break;
                    // Арена
                    case 7: sServerMenuMgr->CommingSoon(player); break;
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

            default: break;
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

void AddSC_ServerMenuPlayerGossip()
{
    new ServerMenuPlayerGossip();
    new SpServerMenuPlayerGossip();
}