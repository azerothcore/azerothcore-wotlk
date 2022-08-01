#include "ScriptPCH.h"

class worldboss_killanons : public PlayerScript
{
public:
	worldboss_killanons() : PlayerScript("worldboss_killanons") {}

	void OnCreatureKill(Player * killer, Creature* killed)
	{
		if (killed->GetEntry() == 50023)
		{
			char msg[250];
			snprintf(msg, 250, "|CFF7BBEF7[World-Boss]|r: Игрок|cffff0000 %s|r и его группа, уничтожили Мирового Босса [Темный Эфириал], следующий респавн боссов через: 4 часа.", killer->GetName());
			sWorld->SendServerMessage(SERVER_MSG_STRING, msg);
		}
		if (killed->GetEntry() == 50024)
		{
			char msg[250];
			snprintf(msg, 250, "|CFF7BBEF7[World-Boss]|r: Игрок|cffff0000 %s|r и его группа, уничтожили Мирового Босса [Инквизитор], следующий респавн босса через: 3 часа.", killer->GetName());
			sWorld->SendServerMessage(SERVER_MSG_STRING, msg);
		}
		if (killed->GetEntry() == 50028)
		{
			char msg[250];
			snprintf(msg, 250, "|CFF7BBEF7[World-Boss]|r: Игрок|cffff0000 %s|r и его группа, уничтожили Мирового Босса [Лорд Ребрад], следующий респавн босса через: 2 часа.", killer->GetName());
			sWorld->SendServerMessage(SERVER_MSG_STRING, msg);
		}
		if (killed->GetEntry() == 50026)
		{
			char msg[250];
			snprintf(msg, 250, "|CFF7BBEF7[World-Boss]|r: Игрок|cffff0000 %s|r и его группа, уничтожили Мирового Босса [Владыка Иллидан], следующий респавн босса через: 5 часов.", killer->GetName());
			sWorld->SendServerMessage(SERVER_MSG_STRING, msg);
		}
		if (killed->GetEntry() == 50025)
		{
			char msg[250];
			snprintf(msg, 250, "|CFF7BBEF7[World-Boss]|r: Игрок|cffff0000 %s|r и его группа, уничтожили Мирового Босса [Оскверненная Изера], следующий респавн босса через: 3 часа.", killer->GetName());
			sWorld->SendServerMessage(SERVER_MSG_STRING, msg);
		}

		if (killed->GetEntry() == 50027)
		{
			char msg[250];
			snprintf(msg, 250, "|CFF7BBEF7[World-Boss]|r: Игрок|cffff0000 %s|r и его группа, уничтожили Мирового Босса [Кил'джеден], следующий респавн босса через: 6 часов.", killer->GetName());
			sWorld->SendServerMessage(SERVER_MSG_STRING, msg);
		}
	}

};

void AddSC_worldboss_killanons()
{
	new worldboss_killanons();
}
