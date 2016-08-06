
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "WorldSession.h"
#include "azth_custom_new_vendor.cpp"
#include "WorldPacket.h"
#include "Chat.h"
#include "Spell.h"
#include "Define.h"
#include "GossipDef.h"
#include "Item.h"
#include <string>

#define GOSSIP_ITEM_GIVE_PVE_QUEST      "Vorrei ricevere la mia missione PVE giornaliera."
#define GOSSIP_ITEM_GIVE_PVP_QUEST      "Vorrei ricevere la mia missione PVP giornaliera."
#define GOSSIP_ITEM_GIVE_EXTRA_QUEST    "Vorrei una missione extra!"
#define GOSSIP_ITEM_CHANGE_QUEST		"Vorrei cambiare la mia missione." // unused

int BITMASK_PVE = 1;
int BITMASK_PVP = 2;
int BITMASK_EXTRA = 4;


int PVE_LOWER_RANGE = 100000;
int PVE_UPPER_RANGE = 100080;
int PVE_QUEST_NUMBER = 1;
int MAX_PVE_QUEST_NUMBER = 3;

int PVE_RANGE = PVE_UPPER_RANGE - PVE_LOWER_RANGE;
/*
int WHISPER_CHANCE = 50; 

std::vector<std::string> whispersList = 
{
	"Uccidere --NAME--, non sarà facile... buona fortuna!",
	"Povero --NAME--... la sua fine è segnata!",
	"--NAME--? Sarà un gioco da ragazzi ucciderlo.",
	"Buona fortuna!",
	"--NAME-- deve morire!"
};*/

class npc_han_al : public CreatureScript
{
public:
	npc_han_al() : CreatureScript("npc_han_al") { }
	/*
	void whisperPlayer(std::string creatureName, Player * player, Creature * creature)
	{
		double random = rand_chance();
		if (random <= WHISPER_CHANCE)
		{
			int index = rand() % whispersList.size() - 1;
			std::string whisperText = whispersList[index];
			replaceAll(whisperText, "--NAME--", creatureName);
			creature->Whisper(whisperText, LANG_UNIVERSAL, player, false);
		}
	}

	void replaceAll(std::string& str, const std::string& from, const std::string& to) {
		if (from.empty())
			return;
		size_t start_pos = 0;
		while ((start_pos = str.find(from, start_pos)) != std::string::npos) {
			str.replace(start_pos, from.length(), to);
			start_pos += to.length();
		}
	}
	*/
	bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
	{
		time_t t = time(NULL);
		tm *lt = localtime(&t);
		int seed = lt->tm_mday + lt->tm_mon + 1 + lt->tm_year + 1900;
		srand(seed);
		//int id = rand() % PVE_RANGE;
		int id = PVE_LOWER_RANGE + (rand() % PVE_RANGE);
		Quest const * questPve = sObjectMgr->GetQuestTemplate(id);
		player->PlayerTalkClass->ClearMenus();
		switch (action)
		{
		case GOSSIP_ACTION_INFO_DEF:
			// uint16 id = (player->GetGUID().GetEntry() * id) % PVE_RANGE;

			if (!questPve)
				return false;

			if (player->CanAddQuest(questPve, false) && player->CanTakeQuest(questPve, false))
			{
				player->AddQuest(questPve, NULL);
				//CreatureTemplate const * objective = sObjectMgr->GetCreatureTemplate(questPve->RequiredNpcOrGo[0]);
				//whisperPlayer(objective->Name, player, creature);

				// simply close gossip or send something else?
				player->PlayerTalkClass->SendCloseGossip();
			}
			break;
		case GOSSIP_ACTION_INFO_DEF + 1:

			break;
		case GOSSIP_ACTION_INFO_DEF + 2:

			break;
		}
		return true;
	}

	bool OnGossipHello(Player* player, Creature* creature) override
	{
		unsigned char bitmask = 0;
		int gossip = 100000;

		time_t t = time(NULL);
		tm *lt = localtime(&t);
		int seed = lt->tm_mday + lt->tm_mon + 1 + lt->tm_year + 1900;
		srand(seed);
		//int id = rand() % PVE_RANGE;
		int idPve = PVE_LOWER_RANGE + (rand() % PVE_RANGE);
		Quest const * questPve = sObjectMgr->GetQuestTemplate(idPve);
		int PveMaxCheck = 0;
		int i = PVE_LOWER_RANGE;
		while (i <= PVE_UPPER_RANGE && PveMaxCheck <= MAX_PVE_QUEST_NUMBER)
		{ 
			if (player->GetQuestStatus(i) != QUEST_STATUS_NONE)
			{
				PveMaxCheck = PveMaxCheck + 1;
			}
			i = i + 1;
		}
		if (player->CanAddQuest(questPve, false) && player->CanTakeQuest(questPve, false) && PveMaxCheck < MAX_PVE_QUEST_NUMBER)
		{
			bitmask = bitmask | BITMASK_PVE;
		}

		if ((bitmask & BITMASK_PVE) == BITMASK_PVE)
		{
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_GIVE_PVE_QUEST, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
		}
		if ((bitmask & BITMASK_PVP) == BITMASK_PVP)
		{
			// player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_GIVE_PVP_QUEST, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
		}
		if ((bitmask & BITMASK_EXTRA) == BITMASK_EXTRA)
		{
			// player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_GIVE_EXTRA_QUEST, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
		}
		if (bitmask == 0)
		{
			if (player->hasQuest(idPve)) // and id pvp and id extra
				gossip = 100001;
			else { gossip = 100002; }
		}
		if (PveMaxCheck >= MAX_PVE_QUEST_NUMBER)
			gossip = 100003;

		player->SEND_GOSSIP_MENU(gossip, creature->GetGUID());
		return true;
	}

	bool OnQuestComplete(Player* pPlayer, Creature* pCreature, Quest const* pQuest)
	{
		return true;
	}
};

int AZTH_REPUTATION_ID				= 948;
#define GOSSIP_ITEM_SHOW_ACCESS     "Vorrei vedere la tua merce, per favore."

class npc_azth_vendor : public CreatureScript
{
public:
	npc_azth_vendor() : CreatureScript("npc_azth_vendor") { }

	bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
	{
		player->PlayerTalkClass->ClearMenus();

		if (action == GOSSIP_ACTION_TRADE)
			AzthSendListInventory(creature->GetGUID(), player->GetSession(), 100000);

		return true;
	}

	bool OnGossipHello(Player* player, Creature* creature)
	{
		uint16 gossip;
		gossip = 32001;
		if (creature->GetResistance(SPELL_SCHOOL_HOLY) != 0)
			gossip = creature->GetResistance(SPELL_SCHOOL_HOLY);

		uint32 rep = player->GetReputation(AZTH_REPUTATION_ID);
		if (creature->IsVendor() && rep >= creature->GetResistance(SPELL_SCHOOL_FIRE) && (player->GetReputationRank(AZTH_REPUTATION_ID) >= 3))
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, GOSSIP_ITEM_SHOW_ACCESS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

		if (player->GetReputation(AZTH_REPUTATION_ID) < creature->GetResistance(SPELL_SCHOOL_FIRE))
			player->SEND_GOSSIP_MENU(32002, creature->GetGUID());
		else
			player->SEND_GOSSIP_MENU(gossip, creature->GetGUID());

		return true;
	}
};

std::vector<int> items[8]; // <---- THIS

void getItems()
{
	items[0].clear();
	items[1].clear();
	items[2].clear();
	items[3].clear();
	items[4].clear();
	items[5].clear();
	items[6].clear();
	items[7].clear();
	QueryResult result = WorldDatabase.Query("SELECT entry, quality FROM item_template WHERE entry >= 100017 LIMIT 0, 200000");
	do
	{
		Field* fields = result->Fetch();
		uint32 entry = fields[0].GetUInt32();
		uint32 quality = fields[1].GetUInt32();

		items[quality].push_back(entry);
	} while (result->NextRow());
}

float CHANCES[8] = { 10.f, 30.f, 20.f, 15.f, 5.f, 1.f, 0.5f, 1.f };
int QUALITY_TO_FILL_PERCENTAGE = 1;
int ONLY_COMMON = 2;
int NOT_COMMON = 1;
int EVERYTHING = 2;
int TIME_TO_RECEIVE_MAIL = 0;

int getQuality()
{
	double c = rand_chance();
	float chance = (float) c;
	float i = CHANCES[0];
	int quality = 0;

	while (i < c)
	{
		quality = quality + 1;
		i = i + CHANCES[quality];
	}
	if (quality > 7)
		quality = QUALITY_TO_FILL_PERCENTAGE;
	return quality;
}


class item_azth_hearthstone_loot_sack : public ItemScript
{
	public:
		item_azth_hearthstone_loot_sack() : ItemScript("item_azth_hearthstone_loot_sack") {}
		
		bool OnUse(Player* player, Item* item, SpellCastTargets const& /*target*/)
		{
			getItems();
				SQLTransaction trans = CharacterDatabase.BeginTransaction();
				int16 deliverDelay = TIME_TO_RECEIVE_MAIL;
				MailDraft* draft = new MailDraft("Sacca Hearthstone", "");
				int i = 1;
				time_t t = time(NULL);
				tm *lt = localtime(&t);
				int seed = lt->tm_mday + lt->tm_mon + 1 + lt->tm_year + 1900 + lt->tm_sec + player->GetGUID() + player->GetItemCount(item->GetEntry(), true, 0);
				
				while (i <= EVERYTHING)
				{
					//srand(seed);
					int quality = 0;
					quality = getQuality();
					uint32 id = 0;
					id = rand() % items[quality].size();
					if (Item* item = Item::CreateItem(items[quality][id], 1, 0))
					{
						item->SaveToDB(trans);       
						draft->AddItem(item);
					}

					i = i + 1;
					seed = seed + i;
				}
				i = 1;
				while (i <= ONLY_COMMON)
				{
					//srand(seed + 3);
					int quality = 1;
					if (rand_chance() > 80)
					{
						quality = 0;
					}
					uint32 id;
					id = rand() % items[quality].size();

					if (Item* item = Item::CreateItem(items[quality][id], 1, 0))
					{
						item->SaveToDB(trans);
						draft->AddItem(item);
					}

					i = i + 1;
					seed = seed + i;
				}
				i = 1;
				while (i <= NOT_COMMON)
				{
					//srand(seed + 4);
					int quality = 0;
					quality = getQuality();
					while (quality < 3)
					{
						quality = getQuality();
					}
					uint32 id;
					id = rand() % items[quality].size();
					if (Item* item = Item::CreateItem(items[quality][id], 1, 0))
					{
						item->SaveToDB(trans);
						draft->AddItem(item);
					}

					i = i + 1;
					seed = seed + i;
				}
			
			draft->SendMailTo(trans, MailReceiver(player), MailSender(player), MAIL_CHECK_MASK_RETURNED, deliverDelay);
			CharacterDatabase.CommitTransaction(trans);

			// devi controllare se le quest danno rep pure
			// player->TextEmote("controlla la tua mail!");


			ChatHandler(player->GetSession()).SendSysMessage("Controlla la tua mail!");

			player->DestroyItem(item->GetBagSlot(), item->GetSlot(), true);
			return true;
		}
};

void AddSC_hearthstone()
{
	new npc_han_al();
	new npc_azth_vendor();
	new item_azth_hearthstone_loot_sack();
}
