
#include "ScriptPCH.h"
#include "Chat.h"
#include <cstring>
#include "ScriptMgr.h"
#include "Chat.h"
#include "Player.h"
#include "WorldSession.h"

using namespace Acore::ChatCommands;

class boss_commandscript : public CommandScript
{
public:
	boss_commandscript() : CommandScript("boss_commandscript") { }

    ChatCommandTable GetCommands() const override
	{
        static ChatCommandTable BossCommandTable =
		{
            { "all", HandleAllCommand, SEC_PLAYER, Console::No},
		};
        static ChatCommandTable commandTable =
		{
            { "mir", SEC_PLAYER, false, NULL, "", BossCommandTable },
		};
		return commandTable;
	}

// ALLBOSS
static bool HandleAllCommand(ChatHandler* handler, char const* /*args*/)
{
	if (!handler)
		return false;

	time_t current_time = time(0);
	int time_stamp = int(current_time);

	Player* pPlayer = handler->GetSession()->GetPlayer();
	std::string RespawnReg1 = "";
	std::string RespawnReg2 = "";
	std::string RespawnReg3 = "";
	std::string RespawnReg4 = "";
	std::string RespawnReg5 = "";
	std::string RespawnReg6 = "";
	
   // Лорж
	QueryResult queryResult1 = CharacterDatabase.Query("SELECT respawnTime FROM creature_respawn WHERE guid = 4360017");
	if (queryResult1)
	{
		uint32 respawnUnix = queryResult1->Fetch()[0].Get<uint32>();
		RespawnReg1 = secsToTimeString(respawnUnix - time_stamp);
	}
	else
	{
		RespawnReg1 = "Лорд жив. Вперед, убейте его!";
	}

	//Илидан
	QueryResult queryResult2 = CharacterDatabase.Query("SELECT respawnTime FROM creature_respawn WHERE guid = 4660737");
	if (queryResult2)
	{
		uint32 respawnUnix = queryResult2->Fetch()[0].Get<uint32>();
		RespawnReg2 = secsToTimeString(respawnUnix - time_stamp);
	}
	else
	{
		RespawnReg2 = "Иллидан жив. Вперед, убейте его!";
	}

	//Эфириал
	QueryResult queryResult3 = CharacterDatabase.Query("SELECT respawnTime FROM creature_respawn WHERE guid = 3932621");
	if (queryResult3)
	{
		uint32 respawnUnix = queryResult3->Fetch()[0].Get<uint32>();
		RespawnReg3 = secsToTimeString(respawnUnix - time_stamp);
	}
	else
	{
		RespawnReg3 = "Эфириал жив. Вперед, убейте его!";
	}

	//Инквизитор
	QueryResult queryResult4 = CharacterDatabase.Query("SELECT respawnTime FROM creature_respawn WHERE guid = 2376962");
	if (queryResult4)
	{
		uint32 respawnUnix = queryResult4->Fetch()[0].Get<uint32>();
		RespawnReg4 = secsToTimeString(respawnUnix - time_stamp);
	}
	else
	{
		RespawnReg4 = "Инквизитор жив. Вперед, убейте его!";
	}

	//Изера
	QueryResult queryResult5 = CharacterDatabase.Query("SELECT respawnTime FROM creature_respawn WHERE guid = 4352959");
	if (queryResult5)
	{
		uint32 respawnUnix = queryResult5->Fetch()[0].Get<uint32>();
		RespawnReg5 = secsToTimeString(respawnUnix - time_stamp);
	}
	else
	{
		RespawnReg5 = "Изера жива. Вперед, убейте его!";
	}

	//КилДжедан
	QueryResult queryResult6 = CharacterDatabase.Query("SELECT respawnTime FROM creature_respawn WHERE guid = 3993244");
	if (queryResult6)
	{
		uint32 respawnUnix = queryResult6->Fetch()[0].Get<uint32>();
		RespawnReg6 = secsToTimeString(respawnUnix - time_stamp);
	}
	else
	{
		RespawnReg6 = "Кил'Джеден жив. Вперед, убейте ее!";
	}

	ChatHandler(pPlayer->GetSession()).PSendSysMessage("|CFFFE8A0E[Таймер Мировых Боссов]");
	ChatHandler(pPlayer->GetSession()).PSendSysMessage("|CFFFE8A0EВозрождение [Лорд]:|r |CFFE55BB0 %s", RespawnReg1.c_str());
	ChatHandler(pPlayer->GetSession()).PSendSysMessage("|CFFFE8A0EВозрождение [Иллидан]:|r |CFFE55BB0 %s", RespawnReg2.c_str());
	ChatHandler(pPlayer->GetSession()).PSendSysMessage("|CFFFE8A0EВозрождение [Эфириал]:|r |CFFE55BB0 %s", RespawnReg3.c_str());
	ChatHandler(pPlayer->GetSession()).PSendSysMessage("|CFFFE8A0EВозрождение [Инквизитор]:|r |CFFE55BB0 %s", RespawnReg4.c_str());
	ChatHandler(pPlayer->GetSession()).PSendSysMessage("|CFFFE8A0EВозрождение [Изера]:|r |CFFE55BB0 %s", RespawnReg5.c_str());
	ChatHandler(pPlayer->GetSession()).PSendSysMessage("|CFFFE8A0EВозрождение [Кил'Джеден]:|r |CFFE55BB0 %s", RespawnReg6.c_str());
	return true;
}


};
void AddSC_boss_commandscript()
{
	new boss_commandscript();
}
