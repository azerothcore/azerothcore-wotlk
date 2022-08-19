//Created By Philippovitch
//AC-Web 
//Script Complete 100 %

using namespace std;	
		
	/*Basic Menu*/
#define Menu_Whisp "Black-WoW TOP 5"
#define Notification "Wähle eine Klasse"
#define M_Whisper "Wähle eine Klasse"
#define leave "Tschüss"
    /*Class E_Menu*/
#define E_Warrior "TOP 5 der Krieger"
#define E_Paladin "TOP 5 der Palas"
#define E_Hunter "TOP 5 der Jäger"
#define E_Rogue "TOP 5 der Schurken"
#define E_Priest "TOP 5 der Priester"
#define E_Shaman "TOP 5 der Schamanen"
#define E_Mage "TOP 5 der Magier"
#define E_Warlock "TOP 5 der Hexenmeister"
#define E_Druid "TOP 5 der Druiden"
#define E_Death_knight "TOP 5 der Todesritter"
 /*Top 5 Message*/
#define M_Warrior "Hier sind die TOP5 Krieger"
#define M_Paladin "Hier sind die TOP5 Palas"
#define M_Hunter "Hier sind die TOP5 Jäger"
#define M_Rogue "Hier sind die TOP5 Schurken"
#define M_Priest "Hier sind die TOP5 Priester"
#define M_Shaman "Hier sind die TOP5 Schamenen"
#define M_Mage "Hier sind die TOP5 Magier"
#define M_Warlock "Hier sind die TOP5 Hexenmeister"
#define M_Druid "Hier sind die TOP5 Druiden"
#define M_Death_knight "Hier sind die TOP5 Todesritter"

class Top5_Killers : public CreatureScript
{
public:
        Top5_Killers() : CreatureScript("Top5_Killers") { }

        bool OnGossipHello(Player* player, Creature* creature)
		{
		AddGossipItemFor(player,0, Menu_Whisp, GOSSIP_SENDER_MAIN, 0);
		AddGossipItemFor(player,1, E_Warrior, GOSSIP_SENDER_MAIN, 1);
		AddGossipItemFor(player,1, E_Paladin, GOSSIP_SENDER_MAIN, 2);
		AddGossipItemFor(player,1, E_Hunter, GOSSIP_SENDER_MAIN, 3);
		AddGossipItemFor(player,1, E_Rogue, GOSSIP_SENDER_MAIN, 4);
		AddGossipItemFor(player,1, E_Priest, GOSSIP_SENDER_MAIN, 5);
		AddGossipItemFor(player,1, E_Shaman, GOSSIP_SENDER_MAIN, 6);
		AddGossipItemFor(player,1, E_Mage, GOSSIP_SENDER_MAIN, 7);
		AddGossipItemFor(player,1, E_Warlock, GOSSIP_SENDER_MAIN, 8);
		AddGossipItemFor(player,1, E_Druid, GOSSIP_SENDER_MAIN, 9);
		AddGossipItemFor(player,1, E_Death_knight, GOSSIP_SENDER_MAIN, 10);
		AddGossipItemFor(player,1, leave, GOSSIP_SENDER_MAIN, 11);
		SendGossipMenuFor(player,1, creature->GetGUID());
		return true;
		}

		bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
	{
        if (sender == GOSSIP_SENDER_MAIN)
        {
			player->PlayerTalkClass->ClearMenus();
			switch(action)
			{
			case 12:
			AddGossipItemFor(player,0, Menu_Whisp, GOSSIP_SENDER_MAIN, 0);
			AddGossipItemFor(player,1, E_Warrior, GOSSIP_SENDER_MAIN, 1);
			AddGossipItemFor(player,1, E_Paladin, GOSSIP_SENDER_MAIN, 2);
			AddGossipItemFor(player,1, E_Hunter, GOSSIP_SENDER_MAIN, 3);
			AddGossipItemFor(player,1, E_Rogue, GOSSIP_SENDER_MAIN, 4);
			AddGossipItemFor(player,1, E_Priest, GOSSIP_SENDER_MAIN, 5);
			AddGossipItemFor(player,1, E_Shaman, GOSSIP_SENDER_MAIN, 6);
			AddGossipItemFor(player,1, E_Mage, GOSSIP_SENDER_MAIN, 7);
			AddGossipItemFor(player,1, E_Warlock, GOSSIP_SENDER_MAIN, 8);
			AddGossipItemFor(player,1, E_Druid, GOSSIP_SENDER_MAIN, 9);
			AddGossipItemFor(player,1, E_Death_knight, GOSSIP_SENDER_MAIN, 10);
			AddGossipItemFor(player,1, leave, GOSSIP_SENDER_MAIN, 11);
			SendGossipMenuFor(player,1, creature->GetGUID());
			break;
			
			case 11:
			player->PlayerTalkClass->SendCloseGossip();
			break; 
			
			case 0:
			player->GetSession()->SendNotification(Notification);
			ChatHandler(player->GetSession()).PSendSysMessage(M_Whisper);
			player->PlayerTalkClass->SendGossipMenu(12, creature->GetGUID());
			break;
			
			case 1: //Warrior
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='1' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Warrior);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 2: //Paladin
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='2' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Paladin);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 3: //Hunter
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='3' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Hunter);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 4: //Rogue
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='4' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Rogue);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 5: //Priest
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='5' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Priest);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 6: //Shaman
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='7' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Shaman);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 7: //Mage
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='8' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Mage);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 8: //warlock 
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='9' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Warlock);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 9: //Druid 
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='11' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Druid);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			
			case 10: //Death knight 
			{
			QueryResult result = CharacterDatabase.Query("SELECT name,totalKills FROM characters WHERE class='6' ORDER BY totalKills DESC LIMIT 5");
		    if(!result)
			  return false;

			Field * fields = NULL;
			ChatHandler(player->GetSession()).PSendSysMessage(M_Death_knight);
			do
			{
			fields = result->Fetch();
			string name = fields[0].GetString();
			uint32 totalKills = fields[1].GetUInt32();
			char msg[250];
			snprintf(msg, 250, "Name: %s - - - Kills: %u", name.c_str(), totalKills);
			ChatHandler(player->GetSession()).PSendSysMessage(msg);
			} 
			while(result->NextRow());
			player->SaveToDB();
			player->PlayerTalkClass->SendCloseGossip();
			}
			break;
			}
		}
	    return true;
	  }
	};


void AddSC_Top5_Killers()
{
    new Top5_Killers();
}