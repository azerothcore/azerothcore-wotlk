
class npc_worldteleporter : public CreatureScript
{
public:
    npc_worldteleporter() : CreatureScript("npc_worldteleporter") { }

	bool OnGossipHello(Player *player, Creature *pCreature)
	{
		if ( player->GetTeam() == ALLIANCE ) // Allianz
		{
			AddGossipItemFor(player,5, "Sturmwind"                    , GOSSIP_SENDER_MAIN, 1206);
			AddGossipItemFor(player,5, "Eisenschmiede"                , GOSSIP_SENDER_MAIN, 1224);
			AddGossipItemFor(player,5, "Darnassus"                    , GOSSIP_SENDER_MAIN, 1203);
			AddGossipItemFor(player,5, "Exodar"                       , GOSSIP_SENDER_MAIN, 1216);
			AddGossipItemFor(player,5, "Shattrath"                    , GOSSIP_SENDER_MAIN, 4014);
			AddGossipItemFor(player,5, "Dalaran"                      , GOSSIP_SENDER_MAIN, 5585);
			AddGossipItemFor(player,5, "Argentum Turnier", GOSSIP_SENDER_MAIN, 5586);
			AddGossipItemFor(player,7, "[Instanzen Lvl 1-60] ->"      , GOSSIP_SENDER_MAIN, 5550);
			AddGossipItemFor(player,7, "[Instanzen Lvl 60+ ] ->"      , GOSSIP_SENDER_MAIN, 5560);
			AddGossipItemFor(player,7, "[Instanzen TBC ] ->"      , GOSSIP_SENDER_MAIN, 5570);
			AddGossipItemFor(player,7, "[Instanzen WOTLK ] ->"      , GOSSIP_SENDER_MAIN, 5571);
			AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "[Playertreff]"    , GOSSIP_SENDER_MAIN, 1234);
			//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Hinterland Schlachtfeld]"    , GOSSIP_SENDER_MAIN, 12360);
			//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Pet-Area]"    , GOSSIP_SENDER_MAIN, 12362);
			//AddGossipItemFor(player,7, "Battlegrounds and Arenas"   , GOSSIP_SENDER_MAIN, 5575);
			//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Schwarzfelsabstieg]", GOSSIP_SENDER_MAIN, 2002);	
		}
		else // Horde
		{
			AddGossipItemFor(player,5, "Orgrimmar"                    , GOSSIP_SENDER_MAIN, 1215);
			AddGossipItemFor(player,5, "Donnerfels"                   , GOSSIP_SENDER_MAIN, 1225);
			AddGossipItemFor(player,5, "Unterstadt"                   , GOSSIP_SENDER_MAIN, 1213);
			AddGossipItemFor(player,5, "Silbermond"                   , GOSSIP_SENDER_MAIN, 1217);
			AddGossipItemFor(player,5, "Shattrath"                    , GOSSIP_SENDER_MAIN, 4014);
			AddGossipItemFor(player,5, "Dalaran"                      , GOSSIP_SENDER_MAIN, 5585);
			AddGossipItemFor(player, 5, "Argentum Turnier", GOSSIP_SENDER_MAIN, 5586);
			AddGossipItemFor(player,7, "[Instanzen Lvl 1-60] ->"      , GOSSIP_SENDER_MAIN, 5550);
			AddGossipItemFor(player,7, "[Instanzen Lvl 60+ ] ->"      , GOSSIP_SENDER_MAIN, 5560);
			AddGossipItemFor(player,7, "[Instanzen Lvl 70+ ] ->"      , GOSSIP_SENDER_MAIN, 5570);
			AddGossipItemFor(player,7, "[Instanzen WOTLK ] ->"      , GOSSIP_SENDER_MAIN, 5571);
			AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "[Playertreff]"    , GOSSIP_SENDER_MAIN, 1235);
			//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Hinterland Schlachtfeld]"    , GOSSIP_SENDER_MAIN, 12361);
			//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Pet-Area]"    , GOSSIP_SENDER_MAIN, 12363);
			//AddGossipItemFor(player,7, "Battlegrounds and Arenen"   , GOSSIP_SENDER_MAIN, 5575);
			//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Schwarzfelsabstieg]", GOSSIP_SENDER_MAIN, 2002);	
		}		
		AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "[Gurubashi Arena]"      , GOSSIP_SENDER_MAIN, 4015);
		//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Baradinfestung]", GOSSIP_SENDER_MAIN, 8100);
		//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Bastion des Zwielichts]", GOSSIP_SENDER_MAIN, 4324);		
		//AddGossipItemFor(player,7, "[Markenbox]"      , GOSSIP_SENDER_MAIN, 8015);
		SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
		return true;
	}


	void SendDefaultMenu(Player *player, Creature *pCreature, uint32 action )
	{
		// Nicht im Kampf
		if(!player->getAttackers().empty())
		{
			CloseGossipMenuFor(player);
			pCreature->Say("Du bist in einen Kampf verwickelt!", LANG_UNIVERSAL, NULL);
			return;
		}

		switch(action)
		{
			case 5550: //Instanzen 1-60
			  AddGossipItemFor(player,5, "Hoehlen des Wehklagens"        , GOSSIP_SENDER_MAIN, 1249);
			  AddGossipItemFor(player,5, "Todesminen"                    , GOSSIP_SENDER_MAIN, 1250);
			  AddGossipItemFor(player,5, "Burg Schattenfang"             , GOSSIP_SENDER_MAIN, 1251);
			  AddGossipItemFor(player,5, "Schwarzfelstiefen"             , GOSSIP_SENDER_MAIN, 1252);
			  AddGossipItemFor(player,5, "Kral der Klingenhauer"         , GOSSIP_SENDER_MAIN, 1254);
			  AddGossipItemFor(player,5, "Huegel der Klingenhauer"       , GOSSIP_SENDER_MAIN, 1256);
			  AddGossipItemFor(player,5, "Scharlachrotes Kloster"        , GOSSIP_SENDER_MAIN, 1257);
			  AddGossipItemFor(player,7, "[mehr 1-60 Instanzen] ->"      , GOSSIP_SENDER_MAIN, 5551);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"               , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;


			case 5560: // Instanzen 60+
			  AddGossipItemFor(player,5, "Zul'Gurub"               , GOSSIP_SENDER_MAIN, 4000);
			  AddGossipItemFor(player,5, "Der geschmolzene Kern"   , GOSSIP_SENDER_MAIN, 4002);
			  AddGossipItemFor(player,5, "Pechschwingenhort"       , GOSSIP_SENDER_MAIN, 4003);
			  AddGossipItemFor(player,5, "Ruinen von Ahn'Qiraj"    , GOSSIP_SENDER_MAIN, 4004);
			  AddGossipItemFor(player,5, "Tempel von Ahn'Qiraj"    , GOSSIP_SENDER_MAIN, 4005);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"         , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;

			case 5570: // Instanzen 70+
			  AddGossipItemFor(player,5, "Karazhan"                 , GOSSIP_SENDER_MAIN, 4007);
			  AddGossipItemFor(player,5, "Gruul's Unterschlupf"     , GOSSIP_SENDER_MAIN, 4008);
			  AddGossipItemFor(player,5, "HoellenfeuerZitadelle"   , GOSSIP_SENDER_MAIN, 4009);
			  AddGossipItemFor(player,5, "Echsenkessel"             , GOSSIP_SENDER_MAIN, 4010);
			  AddGossipItemFor(player,5, "Festung der Stuerme"      , GOSSIP_SENDER_MAIN, 4011);
			  AddGossipItemFor(player,5, "Hoehlen der Zeit"         , GOSSIP_SENDER_MAIN, 4012);
			  AddGossipItemFor(player,5, "Zul'Aman"                 , GOSSIP_SENDER_MAIN, 4016);
			  AddGossipItemFor(player,5, "Der Schwarze Tempel"      , GOSSIP_SENDER_MAIN, 4013);
			  AddGossipItemFor(player,5, "Auchinodoun"      		  , GOSSIP_SENDER_MAIN, 4084);
			  AddGossipItemFor(player,5, "Sonnenbrunnenplateau"     , GOSSIP_SENDER_MAIN, 4085);
			  AddGossipItemFor(player,5, "Terasse der Magister"     , GOSSIP_SENDER_MAIN, 4086);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"          , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;

			case 5571: // Instanzen 80+
			  AddGossipItemFor(player,5, "Ausmerzen von Stratholme" , GOSSIP_SENDER_MAIN, 4019);
			  AddGossipItemFor(player,5, "Das Oculus"               , GOSSIP_SENDER_MAIN, 4020);
			  AddGossipItemFor(player,5, "Hallen des Lichts"        , GOSSIP_SENDER_MAIN, 4021);
			  AddGossipItemFor(player,5, "Turm Utgarde"             , GOSSIP_SENDER_MAIN, 4022);
			  AddGossipItemFor(player,5, "Hallen des Steins"        , GOSSIP_SENDER_MAIN, 4023);
			  AddGossipItemFor(player,5, "Gun'Drak"                 , GOSSIP_SENDER_MAIN, 4024);
			  AddGossipItemFor(player,5, "Violette Festung"         , GOSSIP_SENDER_MAIN, 4025);
			  AddGossipItemFor(player,5, "Feste Drak'Tharon"        , GOSSIP_SENDER_MAIN, 4026);
			  AddGossipItemFor(player,5, "Ahn'Kahet"                , GOSSIP_SENDER_MAIN, 4027);
			  AddGossipItemFor(player,5, "Azjol Nerub"              , GOSSIP_SENDER_MAIN, 4028);
			  AddGossipItemFor(player,5, "Nexus"                    , GOSSIP_SENDER_MAIN, 4029);
			  AddGossipItemFor(player,5, "Burg Utgarde"             , GOSSIP_SENDER_MAIN, 4030);
			  AddGossipItemFor(player,7, "[Schlachtzuege] ->"       , GOSSIP_SENDER_MAIN, 5553);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"          , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;

			case 5551: //2. Seite Instancen 1-60
			  AddGossipItemFor(player,5, "Uldaman"                   , GOSSIP_SENDER_MAIN, 1258);
			  AddGossipItemFor(player,5, "Zul'Farrak"                , GOSSIP_SENDER_MAIN, 1259);
			  AddGossipItemFor(player,5, "Maraudon"                  , GOSSIP_SENDER_MAIN, 1260);
			  AddGossipItemFor(player,5, "Versunkener Tempel"        , GOSSIP_SENDER_MAIN, 1261);
			  AddGossipItemFor(player,5, "Schwarzfelstiefen"         , GOSSIP_SENDER_MAIN, 1262);
			  AddGossipItemFor(player,5, "Duesterbruch"              , GOSSIP_SENDER_MAIN, 1263);
			  AddGossipItemFor(player,5, "Schwarzfelsspitze"         , GOSSIP_SENDER_MAIN, 1264);
			  AddGossipItemFor(player,5, "Stratholme"                , GOSSIP_SENDER_MAIN, 1265);
			  AddGossipItemFor(player,5, "Scholomance"               , GOSSIP_SENDER_MAIN, 1266);
			  AddGossipItemFor(player,7, "<- [Zurueck]"              , GOSSIP_SENDER_MAIN, 5550);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"           , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;

			case 5553: //Raids 80+
			  AddGossipItemFor(player,5, "Naxxramas"                , GOSSIP_SENDER_MAIN, 4006);
			  AddGossipItemFor(player,5, "Auge der Ewigkeit"         , GOSSIP_SENDER_MAIN, 4031);
			  AddGossipItemFor(player,5, "ObsidiansSanktum"          , GOSSIP_SENDER_MAIN, 4032);
			  AddGossipItemFor(player,5, "Archavon's Kammer"         , GOSSIP_SENDER_MAIN, 4033);
			  AddGossipItemFor(player,5, "Ulduar"                    , GOSSIP_SENDER_MAIN, 4034);
			  AddGossipItemFor(player,5, "Eiskronenzitadelle"        , GOSSIP_SENDER_MAIN, 4035);
			  AddGossipItemFor(player,5, "Onyxia's Hort"             , GOSSIP_SENDER_MAIN, 4001);
			  AddGossipItemFor(player,7, "<- [Zurueck]"                 , GOSSIP_SENDER_MAIN, 5550);
			  AddGossipItemFor(player,7, "<- [Main Menu]"            , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;

			case 5552: //Zurueck zum Hauptmenue
				if ( player->GetTeam() == ALLIANCE ) // Allianz
				{
					AddGossipItemFor(player,5, "Sturmwind"                    , GOSSIP_SENDER_MAIN, 1206);
					AddGossipItemFor(player,5, "Eisenschmiede"                , GOSSIP_SENDER_MAIN, 1224);
					AddGossipItemFor(player,5, "Darnassus"                    , GOSSIP_SENDER_MAIN, 1203);
					AddGossipItemFor(player,5, "Exodar"                       , GOSSIP_SENDER_MAIN, 1216);
					AddGossipItemFor(player,5, "Shattrath"                    , GOSSIP_SENDER_MAIN, 4014);
					AddGossipItemFor(player,5, "Dalaran"                      , GOSSIP_SENDER_MAIN, 5585);
					AddGossipItemFor(player,5, "Argentum Turnier", GOSSIP_SENDER_MAIN, 5586);
					AddGossipItemFor(player,7, "[Instanzen Lvl 1-60] ->"      , GOSSIP_SENDER_MAIN, 5550);
					AddGossipItemFor(player,7, "[Instanzen Lvl 60+ ] ->"      , GOSSIP_SENDER_MAIN, 5560);
					AddGossipItemFor(player,7, "[Instanzen TBC ] ->"      , GOSSIP_SENDER_MAIN, 5570);
					AddGossipItemFor(player,7, "[Instanzen WOTLK ] ->"      , GOSSIP_SENDER_MAIN, 5571);
					AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "[Playertreff]"    , GOSSIP_SENDER_MAIN, 1234);
					//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Hinterland Schlachtfeld]"    , GOSSIP_SENDER_MAIN, 12360);
					//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Pet-Area]"    , GOSSIP_SENDER_MAIN, 12362);
					//AddGossipItemFor(player,7, "Battlegrounds and Arenas"     , GOSSIP_SENDER_MAIN, 5575);
					//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Schwarzfelsabstieg]", GOSSIP_SENDER_MAIN, 2002);	
				}
				else // Horde
				{
					AddGossipItemFor(player,5, "Orgrimmar"                    , GOSSIP_SENDER_MAIN, 1215);
					AddGossipItemFor(player,5, "Donnerfels"                   , GOSSIP_SENDER_MAIN, 1225);
					AddGossipItemFor(player,5, "Unterstadt"                   , GOSSIP_SENDER_MAIN, 1213);
					AddGossipItemFor(player,5, "Silbermond"                   , GOSSIP_SENDER_MAIN, 1217);
					AddGossipItemFor(player,5, "Shattrath"                    , GOSSIP_SENDER_MAIN, 4014);
					AddGossipItemFor(player,5, "Dalaran"                      , GOSSIP_SENDER_MAIN, 5585);
					AddGossipItemFor(player,5, "Argentum Turnier", GOSSIP_SENDER_MAIN, 5586);
					AddGossipItemFor(player,7, "[Instanzen Lvl 1-60] ->"      , GOSSIP_SENDER_MAIN, 5550);
					AddGossipItemFor(player,7, "[Instanzen Lvl 60+ ] ->"      , GOSSIP_SENDER_MAIN, 5560);
					AddGossipItemFor(player,7, "[Instanzen TBC ] ->"      , GOSSIP_SENDER_MAIN, 5570);
					AddGossipItemFor(player,7, "[Instanzen WOTLK ] ->"      , GOSSIP_SENDER_MAIN, 5571);
					AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "[Playertreff]"    , GOSSIP_SENDER_MAIN, 1235);
					//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Hinterland Schlachtfeld]"    , GOSSIP_SENDER_MAIN, 12361);
					//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Pet-Area]"    , GOSSIP_SENDER_MAIN, 12363);
					//AddGossipItemFor(player,7, "Battlegrounds and Arenen"     , GOSSIP_SENDER_MAIN, 5575);
					//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Schwarzfelsabstieg]", GOSSIP_SENDER_MAIN, 3002);	
					}				
				AddGossipItemFor(player,GOSSIP_ICON_BATTLE, "[Gurubashi Arena]"      , GOSSIP_SENDER_MAIN, 4015);
				//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Baradinfestung]", GOSSIP_SENDER_MAIN, 8100);
				//player->ADD_GOSSIP_ITEM(GOSSIP_ICON_BATTLE, "[Bastion des Zwielichts]", GOSSIP_SENDER_MAIN, 4324);		
				//AddGossipItemFor(player,7, "[Markenbox]"      , GOSSIP_SENDER_MAIN, 8015);
				SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());

			break;

			case 5575: // BG's und Arenen
			  AddGossipItemFor(player,5, "Warsong Gulch"                 , GOSSIP_SENDER_MAIN, 5576);
			  AddGossipItemFor(player,5, "Arathi Basin"                  , GOSSIP_SENDER_MAIN, 5577);
			  AddGossipItemFor(player,5, "Alterac Valley"                , GOSSIP_SENDER_MAIN, 5578);
			  AddGossipItemFor(player,5, "Eye of the Storm"              , GOSSIP_SENDER_MAIN, 5579);
			  AddGossipItemFor(player,5, "Gurubashi Arena"               , GOSSIP_SENDER_MAIN, 4015);
			  AddGossipItemFor(player,5, "Circle of Blood Arena"         , GOSSIP_SENDER_MAIN, 5581);
			  AddGossipItemFor(player,5, "Ring of Trials"                , GOSSIP_SENDER_MAIN, 5582);
			  AddGossipItemFor(player,5, "The Maul"                      , GOSSIP_SENDER_MAIN, 5583);
			  AddGossipItemFor(player,5, "Wintergrasp"                   , GOSSIP_SENDER_MAIN, 5584);
			  AddGossipItemFor(player,5, "Argent Tournament"             , GOSSIP_SENDER_MAIN, 5586);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"               , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;			
			
			case 1234: //Playertreff Allianz
			  AddGossipItemFor(player,5, "Playertreff"                , GOSSIP_SENDER_MAIN, 12340);
			   AddGossipItemFor(player,5, "Lehrer"                , GOSSIP_SENDER_MAIN, 12341);
			  //AddGossipItemFor(player,5, "Berufe"                , GOSSIP_SENDER_MAIN, 12342);
			  //AddGossipItemFor(player,5, "Gems + Enhancements"                , GOSSIP_SENDER_MAIN, 12343);
			  AddGossipItemFor(player,5, "Ausruestung" , GOSSIP_SENDER_MAIN, 12344);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"            , GOSSIP_SENDER_MAIN, 5552);

			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;

			case 1235: //Playertreff Horde
			  AddGossipItemFor(player,5, "Playertreff"                , GOSSIP_SENDER_MAIN, 12350);
			  AddGossipItemFor(player,5, "Lehrer"                , GOSSIP_SENDER_MAIN, 12351);
			  //AddGossipItemFor(player,5, "Berufe"                , GOSSIP_SENDER_MAIN, 12352);
			  //AddGossipItemFor(player,5, "Gems"                , GOSSIP_SENDER_MAIN, 12353);
			  AddGossipItemFor(player,5, "Ausruestung" , GOSSIP_SENDER_MAIN, 12354);
			  AddGossipItemFor(player,7, "<- [Hauptmenu]"            , GOSSIP_SENDER_MAIN, 5552);
			  
			  SendGossipMenuFor(player,DEFAULT_GOSSIP_MESSAGE,pCreature->GetGUID());
			break;

			case 8100: // Baradinfestung
			  CloseGossipMenuFor(player);
			  player->TeleportTo(732, -1260.481812f, 1049.593872f, 106.995003f, 3.159191f);
			break;
			
			case 8101: // Steinerner Kern
			  CloseGossipMenuFor(player);
			  player->TeleportTo(646, 1028.265381f, 626.221436f, 156.673004f, 4.986439f);
			break;
			
			case 1203: // Darnassus
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, 9947.52f, 2482.73f, 1316.21f, 0.0f);
			break;

			// Sturmwind
			case 1206:
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -8960.14f, 516.266f, 96.3568f, 0.0f);
			break;

			// Unterstadt
			case 1213:
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, 1819.71f, 238.79f, 60.5321f, 0.0f);
			break;

			// Orgrimmar
			case 1215:
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, 1517.972778f, -4412.097168f, 21.659658f, 0.257997f);
			break;

			// Exodar
			case 1216:
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, -4073.03f, -12020.4f, -1.47f, 0.0f);
			break;

			// Silbermond
			case 1217:
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, 9338.74f, -7277.27f, 13.7895f, 0.0f);
			break;

			// Eisenschmiede
			case 1224:
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -4924.07f, -951.95f, 501.55f, 5.40f);
			break;

			// Donerfels
			case 1225:
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -1290.0f, 147.033997f, 129.682007f, 4.919000f);
			break;

			case 4000:// Zul'Gurub
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -11916.7f, -1212.82f, 92.2868f, 4.6095f);
			break;

			case 4001:// Onyxia's Hort
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -4707.44f, -3726.82f, 54.6723f, 3.8f);
			break;

			case 4002:// Molten Core
			  CloseGossipMenuFor(player);
			  player->TeleportTo(230, 1121.451172f, -454.316772f, -101.329536f, 3.5f);
			break;

			case 4003:// Pechschwingenhort
			  CloseGossipMenuFor(player);
			  player->TeleportTo(469, -7665.55f, -1102.49f, 400.679f, 0.0f);
			break;

			case 4004:// Ruinen von Ahn'Qiraj
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -8409.032227f, 1498.830933f, 27.361542f, 2.497567f);
			break;

			case 4005:// Temple vom Ahn'Qiraj
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -8245.837891f, 1983.736206f, 129.071686f, 0.936195f);
			break;

			case 4006:// Naxxramas
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 3668.711182f, -1262.581665f, 243.519424f, 4.785000f);
			break;

			case 4007:// Karazhan
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -11118.8f, -2010.84f, 47.0807f, 0.0f);
			break;

			case 4008:// Gruul's Unterschlupf
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, 3539.007568f, 5082.357910f, 1.691071f, 0.0f);
			break;

			case 4009:// Hoellenfeuerzitadelle
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, -305.816223f, 3056.401611f, -2.473183f, 2.01f);
			break;

			case 4010:// Echsenkessel
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, 517.288025f, 6976.279785f, 32.007198f, 0.0f);
			break;

			case 4011:// Festung der Stuerme
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, 3089.579346f, 1399.046509f, 187.653458f, 4.794070f);
			break;

			case 4012:// Hoehlen der Zeit
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -8173.66f, -4746.36f, 33.8423f, 4.93989f);
			break;

			case 4016:// Zul'Aman
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, 6846.95f, -7954.5f, 170.028f, 4.61501f);
			break;

			case 4013:// Black Temple
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, -3610.719482f, 324.987579f, 37.400028f, 3.282981f);
			break;

			case 4084:// Auchidoun
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, -3332.999512f, 4923.144531f, -101.360608f, 2.326011f);
			break;
			
			case 4085:// Sonnenbrunnenplateau
			  CloseGossipMenuFor(player);
			  player->TeleportTo(580, -1790.650024f, 925.669983f, 15.150000f, 3.10000f);
			break;
			
			case 4086:// Terassse der MAgister
			  CloseGossipMenuFor(player);
			  player->TeleportTo(585, 7.09000f, -0.45000f, -2.80000f, 0.05000f);
			break;
			
			case 4014:// Shattrath
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, -1850.209961f, 5435.821777f, -10.961435f, 3.403913f);
			break;

			case 4015:// Gurubashi
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -13246.277344f, 195.137848f, 30.991524f, 4.253313f);
			break;

			case 4017:// Razor Hill
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, 315.721f, -4743.4f, 10.4867f, 0.0f);
			break;

			case 4018:// Goldshire
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -9464.0f, 62.0f, 56.0f, 0.0f);
			break;

			case 4019:// Ausmerzen von Stratholme
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -8648.95f,-4387.76f,-207.95f,3.5049f);
			break;

			case 4020:// Das Oculus
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 3780.6f,6955.63f,104.89f,0.3676f);
			break;

			case 4021:// Hallen des Lichts
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 9105.72f,-1319.86f,1058.39f,5.6502f);
			break;

			case 4022:// Utgarde Turm
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 1256.96f,-4852.94f,215.55f,3.447f);
			break;

			case 4023:// Hallen des Steins
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 8922.45f,-1012.96f,1039.59f,1.563f);
			break;

			case 4024:// Gundrak
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 6936.08f,-4436.54f,450.51f,0.7698f);
			break;

			case 4025:// Violette Festung
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 5705.19f,517.96f,649.78f,4.0307f);
			break;

			case 4026:// DrakTharon
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 4774.32f,-2036.68f,229.38f,1.567f);
			break;

			case 4027:// Ahn'Kahet
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 3700.87f,2152.58f,36.044f,3.5956f);
			break;

			case 4028:// Azjol Nerub
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 3700.87f,2152.58f,36.044f,3.5956f);
			break;

			case 4029:// Nexus
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 3780.6f,6955.63f,104.89f,0.3676f);
			break;

			case 4030:// Utgarde Burg
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 1206.94f,-4868.05f,41.249f,0.2804f);
			break;

			case 4031:// Auge der Ewigkeit (Malygos)
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 3860.62f,6989.15f,152.042f,5.74598f);
			break;

			case 4032:// Obsidian Sanctum
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 3483.54f,265.605f,-120.144f,3.23879f);
			break;

			case 4033://Archavons Kammer
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 5406.72f,2816.98f,418.675f,1.06982f);
			break;

			case 4034:// Ulduar
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 9019.79f,-1111.28f,1165.28f,6.26597f);
			break;

			case 4035:// Eiskronenzitadelle
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 5796.23475f,2074.461182f,636.065002f,3.577486f);
			break;
			
			case 1249://  Wailing Caverns
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -722.53f,-2226.30f,16.94f,2.71f);
			break;

			case 1250://  Todesminen
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -11212.04f,1658.58f,25.67f,1.45f);
			break;

			case 1251://  Burg Shattenfang
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -254.47f,1524.68f,76.89f,1.56f);
			break;

			case 1252://  Schwarzfelstiefen
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, 4254.58f,664.74f,-29.04f,1.97f);
			break;

			case 1254://  Kral der KH
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -4484.04f,-1739.40f,86.47f,1.23f);
			break;

			case 1256://  Huegel der KH
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -4645.08f,-2470.85f,85.53f,4.39f);
			break;

			case 1257://  Kloster
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, 2843.89f,-693.74f,139.32f,5.11f);
			break;

			case 1258://  Uldaman
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -6119.70f,-2957.30f,204.11f,0.03f);
			break;

			case 1259://  Zul'Farrak
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -6839.39f,-2911.03f,8.87f,0.41f);
			break;


			case 1260://  Maraudon
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -1433.33f,2955.34f,96.21f,4.82f);
			break;

			case 1261://  Versunkener tempel
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -10346.92f,-3851.90f,-43.41f,6.09f);
			break;

			case 1262://  Schwarzfelstiefen
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -7301.03f,-913.19f,165.37f,0.08f);
			break;

			case 1263://  Duesterbruch
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -3982.47f,1127.79f,161.02f,0.05f);
			break;

			case 1264://  Schwarzfelsspitze
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, -7535.43f,-1212.04f,285.45f,5.29f);
			break;

			case 1265://  Stratholme
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, 3263.54f,-3379.46f,143.59f,0.00f);
			break;

			case 1266://  Scholomance
			  CloseGossipMenuFor(player);
			  player->TeleportTo(0, 1219.01f,-2604.66f,85.61f,0.50f);
			break;

			case 5576://  Warsong
			  CloseGossipMenuFor(player);
				if ( player->GetTeam() == ALLIANCE )
				player->TeleportTo(489, 1525.95f,1481.66f,352.001f,3.20756f);
			  else // horde
				player->TeleportTo(489, 930.851f,1431.57f,345.537f,0.015704f);
			break;

			case 5577://  Arathi
			  CloseGossipMenuFor(player);
				if ( player->GetTeam() == ALLIANCE )
				player->TeleportTo(529, 1308.681f,1306.03f,-9.0107f,3.91285f);
			  else // horde
				player->TeleportTo(529, 686.053f,683.165f,-12.9149f,0.18f);
			break;

			case 5578://  Alterac
			  CloseGossipMenuFor(player);
				if ( player->GetTeam() == ALLIANCE )
				player->TeleportTo(30, 883.187f,-489.375f,96.7618f,3.06932f);
			  else // horde
				player->TeleportTo(30, -818.155f,-623.043f,54.0884f,2.1f);
			break;

			case 5579://  Auge des Sturms
			  CloseGossipMenuFor(player);
				if ( player->GetTeam() == ALLIANCE )
				player->TeleportTo(566, 2487.72f,1609.12f,1224.64f,3.35671f);
			  else // horde
				player->TeleportTo(566, 1843.73f,1529.77f,1224.43f,0.297579f);
			break;

			case 5581://  Zirkel des Blutes
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, 2839.44f,5930.17f,11.1002f,3.16284f);
			break;

			case 5582://  Ring of Trials
			  CloseGossipMenuFor(player);
			  player->TeleportTo(530, -1999.94f,6581.71f,11.32f,2.3f);
			break;

			case 5583://  The Maul
			  CloseGossipMenuFor(player);
			  player->TeleportTo(1, -3761.49f,1133.43f,132.083f,4.57259f);
			break;

			case 5584://  Wintergrasp
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 4984.89f,2864.16f,386.797f,2.56767f);
			break;

			case 5585://  Dalaran
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 5804.585f,624.726f,647.780f,1.820647f);
			break;

			case 5586://  Argent Tournament
			  CloseGossipMenuFor(player);
			  player->TeleportTo(571, 8385.92f,793.193f,547.293f,1.820647f);
			break;

			case 12340: //Playertreff Allianz
				CloseGossipMenuFor(player);
				player->TeleportTo(530, -2521.158936f, 7254.254395f, 16.314550f, 2.481632f); 		
			break;
			
			case 12341: //Playertreff Lehrer
				CloseGossipMenuFor(player);
				player->TeleportTo(530, -2493.694092f, 7230.601563f, 16.237745f, 5.469097f);
			break;

			case 12342: //Playertreff Berufe
				CloseGossipMenuFor(player);
				player->TeleportTo(609, 1609.904907f, -5285.368164f, 75.888069f, 2.719078f); 		
			break;

			case 12343: //Playertreff Enhancements und Gems
				CloseGossipMenuFor(player);
				player->TeleportTo(609, 1575.703369f, -5319.713379f, 75.887054f, 5.875592f); 		
			break;

			case 12344: //Playertreff Ausrüstung
				CloseGossipMenuFor(player);
				player->TeleportTo(530, -2516.954590f, 7251.874512f, 16.315691f, 5.681151f);
			break;

			case 12350: //Playertreff Horde
				CloseGossipMenuFor(player);
				player->TeleportTo(530, -1258.343872f, 7180.012207f, 57.263748f, 2.560174f);	
			break;
			
			case 12351: //Playertreff Lehrer
				CloseGossipMenuFor(player);
				player->TeleportTo(530, -2979.800293f, 6450.040039f, 85.325584f, 3.233858f);
			break;

			case 12352: //Playertreff Berufe
				CloseGossipMenuFor(player);
				player->TeleportTo(1, 7335.000000f, -1515.269165f, 157.065735f, 2.228988f);	
			break;

			case 12353: //Playertreff Gems
				CloseGossipMenuFor(player);
				player->TeleportTo(1, 7480.581543f, -1589.996948f, 198.481644f, 1.266879f);	
			break;

			case 12354: //Playertreff Ausrüstung
				CloseGossipMenuFor(player);
				player->TeleportTo(530, -2950.574219f, 6468.407715f, 84.328728f, 1.843698f);
			break;

			case 8015: //Markenbox
				CloseGossipMenuFor(player);
				player->TeleportTo(1, 16231.0f, 16398.1f, -64.3804f, 4.43115f); 		
			break;
			
			case 12360: //Hinterland Allianz
				CloseGossipMenuFor(player);
				player->TeleportTo(0, -108.529266f, -4650.508789f, 8.412029f, 1.589045f); 		
			break;

			case 12361: //Hinterland Horde
				CloseGossipMenuFor(player);
				player->TeleportTo(0, -644.549683f, -4714.461914f, 5.682992f, 1.081678f); 		
			break;

			case 12362: //Petarea Alli
				CloseGossipMenuFor(player);
				player->TeleportTo(0, -8911.500000f, -140.819000f, 82.213600f, 2.151060f); 		
			break;

			case 12363: //Petarea Horde
				CloseGossipMenuFor(player);
				player->TeleportTo(1, 1258.458618f, -4212.971191f, 26.518471f, 5.197730f); 		
			break;

			case 4322: //Chillplatz
				CloseGossipMenuFor(player);
				player->TeleportTo(1, 7414.729980f, -1512.300049f, 164.917007f, 1.754410f);
			break;
			
			case 2002: //Schwarzfelsabstieg
				CloseGossipMenuFor(player);
				player->TeleportTo(0,-7517.398926f, -1275.121460f, 477.735168f,0.600567f);
			break;
			
			case 4324: //Bastion des Zwiellichts
				CloseGossipMenuFor(player);
				player->TeleportTo(0, -4884.373535f, -4248.829102f, 827.763123f, 2.293001f);
			break;			
		}
	}

	bool OnGossipSelect(Player *player, Creature *pCreature, uint32 sender, uint32 action)
	{
	  // Hauptmenue
	  if (sender == GOSSIP_SENDER_MAIN)
	  {
		player->PlayerTalkClass->ClearMenus();
		SendDefaultMenu( player, pCreature, action );
	  }		 
	  return true;
	}
};

void AddSC_worldteleporter()
{
    new npc_worldteleporter();
}

