/*
** Written by MtgCore
** Rewritten by Poszer & Talamortis https://github.com/poszer/ & https://github.com/talamortis/
** AzerothCore 2019 http://www.azerothcore.org/
** Cleaned and made into a module by Micrah https://github.com/milestorme/
*/

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"

class Npc_Services : public CreatureScript
{
public:
	Npc_Services() : CreatureScript("Npc_Services") {}

	bool OnGossipHello(Player *player, Creature *creature)
	{
		player->ADD_GOSSIP_ITEM(10, "|TInterface\\icons\\Spell_Nature_Regenerate:40:40:-18|t Restore HP and MP", GOSSIP_SENDER_MAIN, 1);  // Restore Health and Mana
		player->ADD_GOSSIP_ITEM(10, "|TInterface\\icons\\SPELL_HOLY_BORROWEDTIME:40:40:-18|t Reset Cooldowns", GOSSIP_SENDER_MAIN, 3);	  // Reset Cooldowns
		player->ADD_GOSSIP_ITEM(10, "|TInterface\\icons\\Achievement_BG_AB_defendflags:40:40:-18|t Reset Combat", GOSSIP_SENDER_MAIN, 4); // Leave Combat
		player->ADD_GOSSIP_ITEM(10, "|TInterface\\icons\\Spell_Shadow_DeathScream:40:40:-18|t Remove Sickness", GOSSIP_SENDER_MAIN, 5);	  // Remove Sickness
		player->ADD_GOSSIP_ITEM(10, "|TInterface\\icons\\Achievement_WorldEvent_Lunar:40:40:-18|t Reset Talents", GOSSIP_SENDER_MAIN, 7); // Reset Talents
		player->ADD_GOSSIP_ITEM(10, "|TInterface/Icons/INV_Misc_Bag_07:40:40:-18|t Bank", GOSSIP_SENDER_MAIN, 8);						  // Open Bank
		player->ADD_GOSSIP_ITEM(10, "|TInterface/Icons/INV_Letter_11:40:40:-18|t Mail", GOSSIP_SENDER_MAIN, 9);							  // Open Mailbox
		player->SEND_GOSSIP_MENU(1, creature->GetGUID());
		return true;
	}
	bool OnGossipSelect(Player *player, Creature * /*creature*/, uint32 /*sender*/, uint32 action)
	{
		player->PlayerTalkClass->ClearMenus();

		switch (action)
		{
		case 1: // Restore HP and MP
		 	if (player->getPowerType() == POWER_MANA)
				player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));

			player->SetHealth(player->GetMaxHealth());
			player->GetSession()->SendNotification("|cffFFFFFFHP & MP succesfully restored!");
			player->CastSpell(player, 31726);
			break;
		case 3: // Reset Cooldowns
			player->RemoveAllSpellCooldown();
			player->GetSession()->SendNotification("|cffFFFFFFCooldowns succesfully reseted!");
			player->CastSpell(player, 31726);
			break;

		case 4: // Leave Combat
			player->CombatStop();
			player->GetSession()->SendNotification("|cffFFFFFFCombat succesfully removed!");
			player->CastSpell(player, 31726);
			break;

		case 5: // Remove Sickness
			if (player->HasAura(15007))
				player->RemoveAura(15007);
			player->GetSession()->SendNotification("|cffFFFFFFSickness succesfully removed!");
			player->CastSpell(player, 31726);
			break;

		case 7: // Reset Talents
			player->resetTalents(true);
			player->SendTalentsInfoData(false);
			player->GetSession()->SendNotification("|cffFFFFFFTalents reseted succesfully!");
			player->CastSpell(player, 31726);
			break;

		case 8: // BANK
			player->GetSession()->SendShowBank(player->GetGUID());
			break;

		case 9: // MAIL
			player->GetSession()->SendShowMailBox(player->GetGUID());
			break;
		}

		player->PlayerTalkClass->SendCloseGossip();

		return true;
	}
};

void AddSC_Npc_Services()
{
	new Npc_Services();
}
