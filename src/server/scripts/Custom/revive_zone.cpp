#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "AccountMgr.h"

class revive_zone : public PlayerScript
{
public:
    revive_zone() : PlayerScript("revive_zone") {}

  /*  void OnPVPKill(Player* killer, Player* killed)
    {
        if (killed->GetMapId() == 1 && killed->GetAreaId() == 987)
        {
            killed->TeleportTo(1, -10139.369f, -3726.513f, 2.127f, 4.24542f);
			killed->ResurrectPlayer(!AccountMgr::IsPlayerAccount(killed->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
        }
		if (killed->GetMapId() == 530 && killed->GetAreaId() == 3631)
		{
			killed->TeleportTo(530, -2902.587f, 8416.758f, 414.671f, 4.86652f);
			killed->ResurrectPlayer(!AccountMgr::IsPlayerAccount(killed->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
		}
		if (killed->GetMapId() == 1 && killed->GetAreaId() == 2317)
		{
			killed->TeleportTo(1, -11870.1982f, -4845.904f, 16.922f, 4.52068f);
			killed->ResurrectPlayer(!AccountMgr::IsPlayerAccount(killed->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
		}
	} */
	void OnPlayerKilledByCreature(Creature* killer, Player* killed)
	{
		if (killed->GetMapId() == 230 && killed->GetAreaId() == 1584)
		{
			killed->TeleportTo(230, 683.93067f, 161.39568f, -71.028f, 4.10004f);
			killed->ResurrectPlayer(!AccountMgr::IsPlayerAccount(killed->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
		}

        if (killed->GetMapId() == 37 && killed->GetAreaId() == 268)
        {
            killed->TeleportTo(37, 1014.68768f, 286.599f, 331.207f, 3.5570f);
            killed->ResurrectPlayer(!AccountMgr::IsPlayerAccount(killed->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
        }

        if (killed->GetMapId() == 580)
        {
            killed->TeleportTo(580, 1759.909668f, 857.656494f, 15.100327f, 2.8901f);
            killed->ResurrectPlayer(!AccountMgr::IsPlayerAccount(killed->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
        }

        if (killed->GetMapId() == 624 && killed->GetAreaId() == 4603)
        {
            killed->TeleportTo(624, -132.3560f, -103.3600f, 104.4015f, 4.74262f);
            killed->ResurrectPlayer(!AccountMgr::IsPlayerAccount(killed->GetSession()->GetSecurity()) ? 1.0f : 0.5f);
        }
	}

};

void AddSC_revive_zone()
{
    new revive_zone();
}
