// Made By Sinistah/ToxicDev

enum config
{
	TOKEN = 90004, // Entry Id Of The Item Defined Here
	AMMOUNT = 1,    // Ammount Of The TOKEN's Given
	AREAIDONE = 172, // Area Id For Location One
	AREAIDTWO = 232 // Area Id For Location Two
};

class pvp_token_rew : public PlayerScript
{
public:
	pvp_token_rew() : PlayerScript("pvp_token_rew") { }

	void OnPVPKill(Player * killer, Player * victim)
	{
		if ((killer->GetMap()->IsBattlegroundOrArena() || killer->GetAreaId() == 2177) && killer->GetGUID() != victim->GetGUID())
		{
			if (killer->GetSession()->GetRemoteAddress() == victim->GetSession()->GetRemoteAddress())
				ChatHandler(killer->GetSession()).PSendSysMessage("[PvP System] У вашей жертвы такой же IP-адрес, как и у вас! Награды не будет!");
			else if (victim->HasAura(2479))
				ChatHandler(killer->GetSession()).PSendSysMessage("[PvP System] У вашей жертвы была аура беззащитной цели! Награды не будет!");
			else
			{
				ChatHandler(killer->GetSession()).PSendSysMessage("[PvP System] Вы были вознаграждены за убийство %s!", victim->GetName());
				killer->AddItem(TOKEN, AMMOUNT);
			}
		}
	}
};

void AddSC_pvp_token_rew()
{
	new pvp_token_rew;
}
