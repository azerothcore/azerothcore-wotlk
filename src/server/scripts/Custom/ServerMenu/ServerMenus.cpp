#include "ServerMenuMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"

class ServerMenuPlayerGossip : public PlayerScript
{
public:
    ServerMenuPlayerGossip() : PlayerScript("ServerMenuPlayerGossip") { }

    void OnGossipSelect(Player* player, uint32 menu_id, uint32 sender, uint32 action)
    {    
        if (!player)
            return;

        ClearGossipMenuFor(player);

        if (sServerMenuMgr->CanOpenMenu(player))
            return;

        switch (sender) {
            // Глобальные функции
            case GOSSIP_SENDER_MAIN: {
                switch (action) {
                    // Старт меню
                    case 0: sServerMenuMgr->GossipHelloMenu(player); break;
                    // Телепорт
                    case 1: sServerMenuMgr->CommingSoon(player); break;
                    // Ранг система
                    case 2: sServerMenuMgr->CommingSoon(player);break;
                    // Магазин
                    case 3: sServerMenuMgr->CommingSoon(player);break;
                    // Премиум
                    case 4: sServerMenuMgr->CommingSoon(player); break;
                    // Управление персонажем
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
                }
            }
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
				if (Player* player = GetCaster()->ToPlayer())
                	sServerMenuMgr->GossipHelloMenu(player);
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