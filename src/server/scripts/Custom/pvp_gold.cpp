/*
_____                        ____
|  ___| __ ___ _______ _ __  / ___|___  _ __ ___
| |_ | '__/ _ \_  / _ \ '_ \| |   / _ \| '__/ _ \
|  _|| | | (_) / /  __/ | | | |__| (_) | | |  __/
|_|  |_|  \___/___\___|_| |_|\____\___/|_|  \___|
Lightning speed and strength
conjured directly from the depths of logic!
Infusion-WoW 2011 - 2012 (C)
<--------------------------------------------------------------------------->
- Developer(s): Jamma
- Complete: 100%
- ScriptName: 'Gold System'
- Comment: This is the basic Gold per Kill System
<--------------------------------------------------------------------------->
*/
#include "ScriptPCH.h"
#define FFA_ENTER_MSG "|cffff6060[WARZONE]:|r Это|cFFFF4500[Зона Боя]|r, помните, вы получите |cFFFF4500100 золота|r за каждое убийство!"
#define KILL_MSG "|cff00ff00|TInterface\\PvPRankBadges/PvPRank06:24|t|rОтлично, Вы получили 100 золота за это |cFFFF4500Убийство|r!"
#define KILL_MSG1 "|cff00ff00|TInterface\\PvPRankBadges/PvPRank06:24|t|rОтлично, Вы получили PvP-Токен за это |cFFFF4500Убийство|r!"
#define KILL_FFA_MSG "|cffff6060[WARZONE]:|r Отлично, Вы получили 100 золота за это |cFFFF4500Убийство|r!"
#define LOST_GOLD_MSG "|cffff6060[WARZONE]:|r Очень жаль, но вы |cFFFF4500потеряли|r 50 золота."
#define ERR_TOO_MUCH_MONEY "|cffff6060[PvP]: You exceeded the max amount of gold!|r"

enum Rewards
{
	NORMAL_REWARD = 1000000,
	FFA_REWARD = 1000000,
	FFA_LOST = 500000
};

class GoldOnKill : public PlayerScript
{
public:
	GoldOnKill() : PlayerScript("GoldOnKill") {}

	void OnUpdateZone(Player* player, uint32 zone, uint32 area)
	{
		if (player->GetMap()->IsBattleground()) //gets updated by UpdatePvPState
		{
			ChatHandler handler(player->GetSession());
			
		}
	}
	void OnPVPKill(Player* killer, Player* victim)
	{
		ChatHandler kHandler(killer->GetSession());
		ChatHandler vHandler(victim->GetSession());

		if (killer->GetGUID() == victim->GetGUID())
		{
			return;
		}
		else
		{
			if (killer->GetMap()->IsBattleground() && victim->GetMap()->IsBattleground()) //gets updated by UpdatePvPState
			{
				if (killer->GetMoney() + FFA_REWARD < MAX_MONEY_AMOUNT)
				{
					killer->SetMoney(killer->GetMoney() + FFA_REWARD);
					kHandler.PSendSysMessage(KILL_MSG);
				}
				else
					kHandler.PSendSysMessage(ERR_TOO_MUCH_MONEY);
			}
		}
	}
};

void AddSC_GoldOnKill()
{
	new GoldOnKill();
}