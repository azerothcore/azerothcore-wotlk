#include "ScriptPCH.h"

class BuffInst : public PlayerScript
{

public:
    BuffInst() : PlayerScript("BuffInst") {}

    /* бафф инст*/
    void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea)
    {
        // Проверка в ТМ
        if (!player->GetGroup() && (player->GetMapId() == 585 || player->GetMapId() == 601 || player->GetMapId() == 533))
        {
            player->CastSpell(player, 90005);
            ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Buff-Solo]:|rВы получили бафф увеличения характеристик.");
        }

        if (player->GetMapId() == 1 || player->GetMapId() == 0 || player->GetMapId() == 571 || player->GetMapId() == 530 || player->GetGroup())
            player->RemoveAurasDueToSpell(90005);
    }
};

void AddSC_BuffInst()
{
    new BuffInst();
}
