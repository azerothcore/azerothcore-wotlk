#include "ScriptMgr.h"
#include "Config.h"
#include "Player.h"
#include "Pet.h"

class duel_reset : public PlayerScript
{
    public:
        duel_reset() : PlayerScript("duel_reset") {}

    void Reset_coold_pet(Pet* pet)
    {
        if (!pet)
            return;

        //pet->RemoveArenaAuras();
        pet->SetHealth(pet->GetMaxHealth());
        pet->SetPower(pet->getPowerType(), pet->GetMaxPower(pet->getPowerType()));
    }

    void rage_runis(Player* player)
    {
        if (!player)
            return;
		switch (player->getPowerType())
        {
            case POWER_RAGE:
                player->SetPower(POWER_RAGE, 0);
            break;
            case POWER_RUNIC_POWER:
                player->SetPower(POWER_RUNIC_POWER, 0);
            break;
            default:
            break;
        }
    }

    void Reset_stat(Player* player)
    {
        if (!player)
            return;

        player->SetHealth(player->GetMaxHealth());
        player->CombatStop();
        if (player->getPowerType() == POWER_MANA)
            player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
    }

    void Reset_coold(Player* player)
    {
        if (!player)
            return;

        if (player->HasAura(25771))
            player->RemoveAura(25771);
        if (player->HasAura(57724))
            player->RemoveAura(57724);
        if (player->HasAura(57723))
            player->RemoveAura(57723);
        player->RemoveAllSpellCooldown();
        player->RemoveAurasByType(SPELL_AURA_PERIODIC_DAMAGE);
    }

    void DruidForm(Player * player)
    {
        if (!player)
            return;

        if (player->getClass() == CLASS_DRUID)
            player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
    }

    void OnDuelStart(Player* player1, Player* player2)
    {
        if (!player1 || !player2)
            return;

        Pet* pet = player1->GetPet();
        Pet* pets = player2->GetPet();

        if(pets)
            Reset_coold_pet(pets);
        if(pet)
            Reset_coold_pet(pet);

        /* первый игрок */
        Reset_coold(player1);
        Reset_stat(player1);
        rage_runis(player1);
        DruidForm(player1);

        /* второй игрок */
        Reset_coold(player2);
        Reset_stat(player2);
        rage_runis(player2);
        DruidForm(player2);
    }

    void OnDuelEnd(Player* pWinner, Player* pLoser, DuelCompleteType /*type*/)
    {
        if (!pWinner || !pLoser)
            return;

        Reset_stat(pWinner);
        Reset_stat(pLoser);
    }
};

class Arena_Scripts : public PlayerScript
{
public:
	Arena_Scripts() : PlayerScript("Arena_Scripts") {  }

	void OnUpdateZone(Player* player, uint32 zone, uint32 /*area*/)
	{
		float x = player->GetPositionX();
		float y = player->GetPositionY();
		float z = player->GetPositionZ();
		float ang = player->GetOrientation();
		float rot2 = std::sin(ang/1);
		float rot3 = std::cos(ang/1);

		bool IsArena = false;

		//   Nagrand Arena || Blade's Edge Arena || Dalaran Arena || Ruins of Lordaeron || Ring of Valor
		if (zone == 3698 || zone == 3702 || zone == 4378 || zone == 3968 || zone == 4406)
			IsArena = true;

		if(!player->IsSpectator())
		{
			if (IsArena && player->HasAura(SPELL_ARENA_PREPARATION))
			{
				if (player->getClass() == CLASS_MAGE)
					player->SummonGameObject(193061, x+2, y+2, z, ang, 0, 0, rot2, rot3, 30);
				if (player->getClass() == CLASS_WARLOCK)
					player->SummonGameObject(193169, x-2, y-2, z, ang, 0, 0, rot2, rot3, 30);
			}
		}
	}
};

class channel_factions : public PlayerScript
{
public:
    channel_factions() : PlayerScript("channel_factions") { }

    void OnChat(Player* player, uint32 /*type*/, uint32 /*lang*/, std::string& msg, Channel* channel)
    {
        if (!player || !channel)
            return;

        uint32 KILL = player->GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS);
        constexpr static uint32 list[16] = { 0, 10, 50, 100, 200, 400, 800, 1600, 3200, 6400, 12800, 15000, 20000, 25000, 30000, 50000 };
        std::ostringstream ssMsg, icon_h, icon_a, y, icon_hh, icon_aa, size;
        icon_hh << " |TInterface\\icons\\Achievement_pvp_h_";
        icon_aa << " |TInterface\\icons\\Achievement_pvp_a_";
        size << ":13:13:-5:-2|t ";

		uint8 max = 16;
		bool yes = false;
		uint32 i = 1;

		while ((yes == false) && i < max)
		{
			if (list[i-1] <= KILL && list[i] > KILL)
			{
				y << i;
				if (i < 10)
				{
					icon_h << icon_hh.str() << "0" << y.str().c_str() << size.str();
					icon_a << icon_aa.str() << "0" << y.str().c_str() << size.str();
				}

				else if (i >= 10)
				{
					icon_h << icon_hh.str() << y.str().c_str() << size.str();
					icon_a << icon_aa.str() << y.str().c_str() << size.str();
				}

				yes = true;
				ssMsg << ((player->GetTeamId() == TEAM_HORDE) ? icon_h.str() : icon_a.str()) << msg;
			}
			i++;
		}
		msg = ssMsg.str();
     }
};

void AddSC_DuelReset()
{
    new duel_reset;
    new Arena_Scripts;
    new channel_factions();
}