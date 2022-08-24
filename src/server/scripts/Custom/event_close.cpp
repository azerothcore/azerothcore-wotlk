#include "ScriptPCH.h"

class CloseZone : public PlayerScript
{

public:
	CloseZone() : PlayerScript("CloseZone") {}

	/* запрет входа на событие */
	void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea)
	{
		if ((newArea == 4179 || newArea == 4254 || newArea == 4987))
		{
			if (sGameEventMgr->IsActiveEvent(120) && player->getLevel() == 200)
				ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Событие]:|r Добро пожаловать на Событие [Изумрудка]|r");
			else
			{
				if (player->GetTeamId() == TEAM_HORDE)
					player->TeleportTo(571, 6236.229980f, 5768.240234f, -5.373631f, 0.736042f);
				else
					player->TeleportTo(571, 6236.229980f, 5768.240234f, -5.373631f, 0.736042f);
				ChatHandler(player->GetSession()).PSendSysMessage("|cffff6060[Доступ Запрещен]:|r Событие не активно или ваш уровень менее 200|r");
			}
		}
	}
};

void AddSC_CloseZone()
{
	new CloseZone();
}
