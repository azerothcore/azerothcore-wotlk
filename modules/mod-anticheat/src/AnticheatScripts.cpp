#include "Configuration/Config.h"
#include "AnticheatMgr.h"
#include "Object.h"
#include "AccountMgr.h"

int64 resetTime = 0;
int64 lastIterationPlayer = sWorld->GetUptime() + 30;//TODO: change 30 secs static to a configurable option
class AnticheatPlayerScript : public PlayerScript
{
public:
	AnticheatPlayerScript()
		: PlayerScript("AnticheatPlayerScript")
	{
	}

	void OnLogout(Player* player) override
	{
		sAnticheatMgr->HandlePlayerLogout(player);
	}

	void OnLogin(Player* player) override
	{
		sAnticheatMgr->HandlePlayerLogin(player);
		if(sConfigMgr->GetBoolDefault("Anticheat.LoginMessage", true))
			ChatHandler(player->GetSession()).PSendSysMessage("This server is running the |cff4CFF00AntiCheat |rmodule.");
	}
};
class AnticheatWorldScript : public WorldScript
{
public:
	AnticheatWorldScript()
		: WorldScript("AnticheatWorldScript")
	{
	}
	void OnUpdate(uint32 diff) override
	{
		if (sWorld->GetGameTime() > resetTime)
		{
			sLog->outString( "Anticheat: Resetting daily report states.");
			sAnticheatMgr->ResetDailyReportStates();
			UpdateReportResetTime();
			sLog->outString( "Anticheat: Next daily report reset: %u", resetTime);
		}
		if (sWorld->GetUptime() > lastIterationPlayer)
		{
			lastIterationPlayer = sWorld->GetUptime() + 30;//TODO: change 30 secs static to a configurable option
			sLog->outString( "Saving reports for %u players.", sWorld->GetPlayerCount());
			for (SessionMap::const_iterator itr = sWorld->GetAllSessions().begin(); itr != sWorld->GetAllSessions().end(); ++itr)
				if (Player* plr = itr->second->GetPlayer())
					sAnticheatMgr->SavePlayerData(plr);
		}
	}
	void OnBeforeConfigLoad(bool reload) override
	{
		/* from skeleton module */
		if (!reload) {
			std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/mod_anticheat.conf";
			#ifdef WIN32
				cfg_file = "Settings/modules/mod_anticheat.conf";
			#endif // WIN32
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());
		}
		/* end from skeleton module */
	}
	void OnAfterConfigLoad(bool reload) override
	{
		sLog->outString("AnticheatModule Loaded.");
	}
	void UpdateReportResetTime()
	{
		resetTime = sWorld->GetNextTimeWithDayAndHour(-1, 6);
	}
};
class AnticheatMovementHandlerScript : public MovementHandlerScript
{
	public:
	AnticheatMovementHandlerScript()
		: MovementHandlerScript("AnticheatMovementHandlerScript")
	{
	}
    void OnPlayerMove(Player* player, MovementInfo mi, uint32 opcode) override
    {
		if (!AccountMgr::IsGMAccount(player->GetSession()->GetSecurity()) || sConfigMgr->GetBoolDefault("Anticheat.EnabledOnGmAccounts", false))
			sAnticheatMgr->StartHackDetection(player, mi, opcode);
    }
};
void startAnticheatScripts()
{
	new AnticheatWorldScript();
	new AnticheatPlayerScript();
	new AnticheatMovementHandlerScript();
}