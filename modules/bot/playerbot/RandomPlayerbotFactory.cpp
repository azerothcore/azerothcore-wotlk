#include "../pchdef.h"
#include "playerbot.h"
#include "PlayerbotAIConfig.h"
#include "PlayerbotFactory.h"
#include "DatabaseEnv.h"
#include "PlayerbotAI.h"
#include "Player.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "RandomPlayerbotFactory.h"

map<uint8, vector<uint8> > RandomPlayerbotFactory::availableRaces;

RandomPlayerbotFactory::RandomPlayerbotFactory(uint32 accountId) : accountId(accountId)
{
	availableRaces[CLASS_WARRIOR].push_back(RACE_HUMAN);
	availableRaces[CLASS_WARRIOR].push_back(RACE_NIGHTELF);
	availableRaces[CLASS_WARRIOR].push_back(RACE_GNOME);
	availableRaces[CLASS_WARRIOR].push_back(RACE_DWARF);
	availableRaces[CLASS_WARRIOR].push_back(RACE_ORC);
	availableRaces[CLASS_WARRIOR].push_back(RACE_UNDEAD_PLAYER);
	availableRaces[CLASS_WARRIOR].push_back(RACE_TAUREN);
	availableRaces[CLASS_WARRIOR].push_back(RACE_TROLL);
	availableRaces[CLASS_WARRIOR].push_back(RACE_DRAENEI);
    if (sPlayerbotAIConfig.aracgen) //thesawolf - ARAC enabled
    {
        availableRaces[CLASS_WARRIOR].push_back(RACE_BLOODELF);
    }

	availableRaces[CLASS_PALADIN].push_back(RACE_HUMAN);
	availableRaces[CLASS_PALADIN].push_back(RACE_DWARF);
	availableRaces[CLASS_PALADIN].push_back(RACE_DRAENEI);
	availableRaces[CLASS_PALADIN].push_back(RACE_BLOODELF);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_PALADIN].push_back(RACE_NIGHTELF);
        availableRaces[CLASS_PALADIN].push_back(RACE_GNOME);
        availableRaces[CLASS_PALADIN].push_back(RACE_ORC);
        availableRaces[CLASS_PALADIN].push_back(RACE_UNDEAD_PLAYER);
        availableRaces[CLASS_PALADIN].push_back(RACE_TAUREN);
        availableRaces[CLASS_PALADIN].push_back(RACE_TROLL);
    }

	availableRaces[CLASS_ROGUE].push_back(RACE_HUMAN);
	availableRaces[CLASS_ROGUE].push_back(RACE_DWARF);
	availableRaces[CLASS_ROGUE].push_back(RACE_NIGHTELF);
	availableRaces[CLASS_ROGUE].push_back(RACE_GNOME);
	availableRaces[CLASS_ROGUE].push_back(RACE_ORC);
	availableRaces[CLASS_ROGUE].push_back(RACE_TROLL);
	availableRaces[CLASS_ROGUE].push_back(RACE_BLOODELF);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_ROGUE].push_back(RACE_TAUREN);
        availableRaces[CLASS_ROGUE].push_back(RACE_UNDEAD_PLAYER);
        availableRaces[CLASS_ROGUE].push_back(RACE_DRAENEI);
    }

	availableRaces[CLASS_PRIEST].push_back(RACE_HUMAN);
	availableRaces[CLASS_PRIEST].push_back(RACE_DWARF);
	availableRaces[CLASS_PRIEST].push_back(RACE_NIGHTELF);
	availableRaces[CLASS_PRIEST].push_back(RACE_DRAENEI);
	availableRaces[CLASS_PRIEST].push_back(RACE_TROLL);
	availableRaces[CLASS_PRIEST].push_back(RACE_UNDEAD_PLAYER);
	availableRaces[CLASS_PRIEST].push_back(RACE_BLOODELF);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_PRIEST].push_back(RACE_ORC);
        availableRaces[CLASS_PRIEST].push_back(RACE_TAUREN);
        availableRaces[CLASS_PRIEST].push_back(RACE_GNOME);
    }

	availableRaces[CLASS_MAGE].push_back(RACE_HUMAN);
	availableRaces[CLASS_MAGE].push_back(RACE_GNOME);
	availableRaces[CLASS_MAGE].push_back(RACE_DRAENEI);
	availableRaces[CLASS_MAGE].push_back(RACE_UNDEAD_PLAYER);
	availableRaces[CLASS_MAGE].push_back(RACE_TROLL);
	availableRaces[CLASS_MAGE].push_back(RACE_BLOODELF);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_MAGE].push_back(RACE_TAUREN);
        availableRaces[CLASS_MAGE].push_back(RACE_ORC);
        availableRaces[CLASS_MAGE].push_back(RACE_DWARF);
        availableRaces[CLASS_MAGE].push_back(RACE_NIGHTELF);
    }

	availableRaces[CLASS_WARLOCK].push_back(RACE_HUMAN);
	availableRaces[CLASS_WARLOCK].push_back(RACE_GNOME);
	availableRaces[CLASS_WARLOCK].push_back(RACE_UNDEAD_PLAYER);
	availableRaces[CLASS_WARLOCK].push_back(RACE_ORC);
	availableRaces[CLASS_WARLOCK].push_back(RACE_BLOODELF);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_WARLOCK].push_back(RACE_TAUREN);
        availableRaces[CLASS_WARLOCK].push_back(RACE_DWARF);
        availableRaces[CLASS_WARLOCK].push_back(RACE_DRAENEI);
        availableRaces[CLASS_WARLOCK].push_back(RACE_TROLL);
        availableRaces[CLASS_WARLOCK].push_back(RACE_NIGHTELF);
    }

	availableRaces[CLASS_SHAMAN].push_back(RACE_DRAENEI);
	availableRaces[CLASS_SHAMAN].push_back(RACE_ORC);
	availableRaces[CLASS_SHAMAN].push_back(RACE_TAUREN);
	availableRaces[CLASS_SHAMAN].push_back(RACE_TROLL);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_SHAMAN].push_back(RACE_HUMAN);
        availableRaces[CLASS_SHAMAN].push_back(RACE_DWARF);
        availableRaces[CLASS_SHAMAN].push_back(RACE_NIGHTELF);
        availableRaces[CLASS_SHAMAN].push_back(RACE_UNDEAD_PLAYER);
        availableRaces[CLASS_SHAMAN].push_back(RACE_BLOODELF);
        availableRaces[CLASS_SHAMAN].push_back(RACE_GNOME);
    }

	availableRaces[CLASS_HUNTER].push_back(RACE_DWARF);
	availableRaces[CLASS_HUNTER].push_back(RACE_NIGHTELF);
	availableRaces[CLASS_HUNTER].push_back(RACE_DRAENEI);
	availableRaces[CLASS_HUNTER].push_back(RACE_ORC);
	availableRaces[CLASS_HUNTER].push_back(RACE_TAUREN);
	availableRaces[CLASS_HUNTER].push_back(RACE_TROLL);
	availableRaces[CLASS_HUNTER].push_back(RACE_BLOODELF);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_HUNTER].push_back(RACE_UNDEAD_PLAYER);
        availableRaces[CLASS_HUNTER].push_back(RACE_HUMAN);
        availableRaces[CLASS_HUNTER].push_back(RACE_GNOME);
    }

	availableRaces[CLASS_DRUID].push_back(RACE_NIGHTELF);
	availableRaces[CLASS_DRUID].push_back(RACE_TAUREN);
    if (sPlayerbotAIConfig.aracgen) // thesawolf - ARAC enabled
    {
        availableRaces[CLASS_DRUID].push_back(RACE_HUMAN);    
        availableRaces[CLASS_DRUID].push_back(RACE_ORC);
        availableRaces[CLASS_DRUID].push_back(RACE_UNDEAD_PLAYER);
        availableRaces[CLASS_DRUID].push_back(RACE_TROLL);
        availableRaces[CLASS_DRUID].push_back(RACE_BLOODELF);
        availableRaces[CLASS_DRUID].push_back(RACE_DRAENEI);
        availableRaces[CLASS_DRUID].push_back(RACE_GNOME);
        availableRaces[CLASS_DRUID].push_back(RACE_DWARF);
    }

	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_NIGHTELF);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_TAUREN);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_HUMAN);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_ORC);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_UNDEAD_PLAYER);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_TROLL);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_BLOODELF);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_DRAENEI);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_GNOME);
	availableRaces[CLASS_DEATH_KNIGHT].push_back(RACE_DWARF);


}

typedef std::multimap<uint32, CharSectionsEntry const*> CharSectionsMap;
extern CharSectionsMap sCharSectionMap;
CharSectionsEntry const* GetRandomCharSection(uint8 race, CharSectionType genType, uint8 gender, uint8 color = 255)
{
	vector<CharSectionsEntry const*> charSections;
	std::pair<CharSectionsMap::const_iterator, CharSectionsMap::const_iterator> eqr = sCharSectionMap.equal_range(uint32(genType) | uint32(gender << 8) | uint32(race << 16));
	for (CharSectionsMap::const_iterator itr = eqr.first; itr != eqr.second; ++itr)
	{
		CharSectionsEntry const* charSection = itr->second;
		if ((charSection->Flags & SECTION_FLAG_PLAYER) && !(charSection->Flags & SECTION_FLAG_DEATH_KNIGHT)
			&& (charSection->Color == color || color == 255))
		{
			charSections.push_back(itr->second);
		}
	}
	if (charSections.empty())
	{
		sLog->outBasic("No match for race=%u gender=%u color=%u type=%u",
			race, gender, color, genType);
		return NULL;
	}

	uint32 charSectionIndex = urand(0, charSections.size() - 1);
	return charSections[charSectionIndex];
}

//thesawolf - not so random chargen
//NOTE: originally I had this if..else merged into CreateRandomBot but it was coughing up errors
bool RandomPlayerbotFactory::CreateNotRandomBot(uint32 nid)
{
    QueryResult result = CharacterDatabase.PQuery("SELECT * from ai_playerbot_names WHERE name_id = '%d'", nid);
    
    if (!result)
    {
        sLog->outBasic("No more names left for random bots");
        return false;
    }

    Field *fields = result->Fetch();
    string name = fields[1].GetString();
    uint8 gender = fields[2].GetUInt8();
    if (gender == 255)//(gender == "0xFF") //random fallback
    {
        uint8 gender = rand() % 2? GENDER_MALE : GENDER_FEMALE;
    }
    uint8 cls = fields[4].GetUInt8();
    if (!cls)//(cls == "0xFFFF") //random fallback
    {
        //TODO: put in random minus DK(6) and Monk(10)
    }        
    uint8 race = fields[3].GetUInt8();
    if (race == 65535)//(race == "0xFFFF") //random fallback
    {
        uint8 race = availableRaces[cls][urand(0, availableRaces[cls].size() - 1)];
    }

    //thesawolf - lets update in_use SQL flag for a name to avoid dupes
    //TODO: toggle in_use back to 0 if deleting characters/accounts
    
    CharacterDatabase.PExecute("UPDATE ai_playerbot_names SET in_use = 1 WHERE name_id = '%u'", nid);
    
    CharSectionsEntry const* skin = GetRandomCharSection(race, SECTION_TYPE_SKIN, gender);
    CharSectionsEntry const* face = GetRandomCharSection(race, SECTION_TYPE_FACE, gender, skin->Color);
    CharSectionsEntry const* hair = GetRandomCharSection(race, SECTION_TYPE_HAIR, gender);
    CharSectionsEntry const* facialHair = GetRandomCharSection(race, SECTION_TYPE_FACIAL_HAIR, gender, hair->Color);
    uint8 outfitId = 0;

	WorldSession* session = new WorldSession(accountId, NULL, SEC_PLAYER, 2, 0, LOCALE_enUS, 0, false, true);
    if (!session)
    {
        sLog->outBasic("Couldn't create session for random bot account %d", accountId);
        delete session;
        return false;
    }

    Player *player = new Player(session);

	BotCharacterCreateInfo cci;
    cci.Name = name;
    cci.Race = race;
    cci.Class = cls;
    cci.Gender = gender;
    cci.Skin = skin->Color;
    cci.Face = face->Type;
    cci.HairStyle = hair->Type;
    cci.HairColor = hair->Color;
    cci.FacialHair = facialHair ? facialHair->Type : 0;
    cci.OutfitId = outfitId;

	if (!player->CreateBot(sObjectMgr->GenerateLowGuid(HIGHGUID_PLAYER), &cci))
    {
        player->DeleteFromDB(player->GetGUID(), accountId, true, true);
        delete session;
        delete player;
        sLog->outBasic("Unable to create random bot for account %d - name: \"%s\"; race: %u; class: %u",
                accountId, name.c_str(), race, cls);
        return false;
    }

    player->setCinematic(2);
    player->SetAtLoginFlag(AT_LOGIN_NONE);
    player->SaveToDB(false, true);

    sLog->outBasic("Preset bot created for account %d - name: \"%s\"; race: %u; class: %u",
            accountId, name.c_str(), race, cls);

    return true;
}

bool RandomPlayerbotFactory::CreateRandomBot(uint8 cls)
{
	sLog->outBasic("Creating new random bot for class %d", cls);

	uint8 gender = rand() % 2 ? GENDER_MALE : GENDER_FEMALE;

	uint8 race = availableRaces[cls][urand(0, availableRaces[cls].size() - 1)];
	string name = CreateRandomBotName();
	if (name.empty())
		return false;

	CharSectionsEntry const* skin = GetRandomCharSection(race, SECTION_TYPE_SKIN, gender);
	CharSectionsEntry const* face = GetRandomCharSection(race, SECTION_TYPE_FACE, gender, skin->Color);
	CharSectionsEntry const* hair = GetRandomCharSection(race, SECTION_TYPE_HAIR, gender);
	CharSectionsEntry const* facialHair = GetRandomCharSection(race, SECTION_TYPE_FACIAL_HAIR, gender, hair->Color);
	uint8 outfitId = 0;

	WorldSession* session = new WorldSession(accountId, NULL, SEC_PLAYER, 2, 0, LOCALE_enUS, 0, false, true);
	if (!session)
	{
		sLog->outError("Couldn't create session for random bot account %d", accountId);
		delete session;
		return false;
	}

	Player *player = new Player(session);

	BotCharacterCreateInfo cci;
	cci.Name = name;
	cci.Race = race;
	cci.Class = cls;
	cci.Gender = gender;
	cci.Skin = skin->Color;
	cci.Face = face->Type;
	cci.HairStyle = hair->Type;
	cci.HairColor = hair->Color;
	cci.FacialHair = facialHair ? facialHair->Type : 0;
	cci.OutfitId = outfitId;

	if (!player->CreateBot(sObjectMgr->GenerateLowGuid(HIGHGUID_PLAYER), &cci))
	{
		player->DeleteFromDB(player->GetGUID(), accountId, true, true);
		delete session;
		delete player;
		sLog->outError("Unable to create random bot for account %d - name: \"%s\"; race: %u; class: %u",
			accountId, name.c_str(), race, cls);
		return false;
	}

	player->setCinematic(2);
	player->SetAtLoginFlag(AT_LOGIN_NONE);
	player->SaveToDB(true, true);

	sLog->outBasic("Random bot created for account %d - name: \"%s\"; race: %u; class: %u",
		accountId, name.c_str(), race, cls);

	return true;
}

string RandomPlayerbotFactory::CreateRandomBotName()
{
	QueryResult result = CharacterDatabase.Query("SELECT MAX(name_id) FROM ai_playerbot_names");
	if (!result)
	{
		sLog->outError("No more names left for random guilds");
		return "";
	}

	Field *fields = result->Fetch();
	uint32 maxId = fields[0].GetUInt32();

	uint32 id = urand(0, maxId);
	result = CharacterDatabase.PQuery("SELECT n.name FROM ai_playerbot_names n "
		"LEFT OUTER JOIN characters e ON e.name = n.name "
		"WHERE e.guid IS NULL AND n.name_id >= '%u' LIMIT 1", id);
	if (!result)
	{
		sLog->outError("No more names left for random bots");
		return "";
	}

	fields = result->Fetch();
	return fields[0].GetString();
}


void RandomPlayerbotFactory::CreateRandomBots()
{
	if (sPlayerbotAIConfig.deleteRandomBotAccounts)
	{
		sLog->outBasic("Deleting random bot accounts...");
		QueryResult results = LoginDatabase.PQuery("SELECT id FROM account where username like '%s%%'", sPlayerbotAIConfig.randomBotAccountPrefix.c_str());
		if (results)
		{
			do
			{
				Field* fields = results->Fetch();
				uint32 accountID = fields[0].GetUInt32();
				AccountOpResult result = AccountMgr::DeleteAccount(accountID);
				switch (result)
				{
				case AOR_OK:
					sLog->outBasic("Account ID %d deleted", accountID);
					break;
				case AOR_NAME_NOT_EXIST:
					sLog->outBasic("Account ID %d not exist", accountID);
					break;
				case AOR_DB_INTERNAL_ERROR:
					sLog->outBasic("Account ID %d deleting error occured", accountID);
					break;
				default:
					sLog->outBasic("Account ID %d delete result unknown", accountID);
					break;
				}

				QueryResultFuture checkDeleteResult = LoginDatabase.AsyncPQuery("SELECT id FROM account where id = '%d'", accountID);
				while (!checkDeleteResult.ready())
				{
					sLog->outBasic("Account ID %d is deleting", accountID);
					this_thread::sleep_for(std::chrono::milliseconds(100));
				}
			} while (results->NextRow());
		}

		CharacterDatabase.DirectExecute("DELETE FROM ai_playerbot_random_bots");
		sLog->outBasic("Random bot accounts deleted");
	}
	int maxBotAccountCount = sPlayerbotAIConfig.randomBotAccountCount;
	for (int accountNumber = 0; accountNumber < maxBotAccountCount; ++accountNumber)
	{
		ostringstream out; out << sPlayerbotAIConfig.randomBotAccountPrefix << accountNumber;
		string accountName = out.str();
		const char* name_cstr = accountName.c_str();
		QueryResult results = LoginDatabase.PQuery("SELECT id FROM account where username = '%s'", name_cstr);		
		if (results)
		{
			continue;
		}

		string password = "";
		for (int i = 0; i < 10; i++)
		{
			password += (char)urand('!', 'z');
		}
		AccountOpResult result = AccountMgr::CreateAccount(accountName, password);
		switch (result)
		{
		case AOR_OK:
			sLog->outBasic("Account %s created", name_cstr);
			break;
		case AOR_NAME_TOO_LONG:
			sLog->outBasic("Account %s creation failed", name_cstr);
			break;
		case AOR_NAME_ALREDY_EXIST:
			sLog->outBasic("Account %s creation failed, account name already exists", name_cstr);
			break;
		case AOR_DB_INTERNAL_ERROR:
			sLog->outBasic("Account %s creation failed", name_cstr);
			break;
		default:
			sLog->outBasic("Account %s creation failed", name_cstr);
			break;
		}

		sLog->outBasic("Account %s created for random bots", name_cstr);
	}

	LoginDatabase.DirectPExecute("UPDATE account SET expansion = '%u' where username like '%s%%'", 2, sPlayerbotAIConfig.randomBotAccountPrefix.c_str());

	int totalRandomBotChars = 0;

	//thesawolf - kludgy fix for notrandom and name overlaps - FIXME
	uint32 nid = 0;

	for (int accountNumber = 0; accountNumber < maxBotAccountCount; ++accountNumber)
	{
		ostringstream out; out << sPlayerbotAIConfig.randomBotAccountPrefix << accountNumber;
		string accountName = out.str();
		const char* name_cstr = accountName.c_str();
		QueryResult results = LoginDatabase.PQuery("SELECT id FROM account where username = '%s'", name_cstr);
		if (!results)
		{
			sLog->outError("Account %d not created", accountNumber);
			continue;
		}

		Field* fields = results->Fetch();
		uint32 accountId = fields[0].GetUInt32();

		sPlayerbotAIConfig.randomBotAccounts.push_back(accountId);

		int count = AccountMgr::GetCharactersCount(accountId);
		sLog->outError("%d Characters for account %d ", count, accountId);
		totalRandomBotChars += count;
		if (count > 0)
		{
			continue;
		}

		RandomPlayerbotFactory factory(accountId);
		for (uint8 cls = CLASS_WARRIOR; cls < MAX_CLASSES; ++cls)
		{
			if (cls != 10)
           {
                //thesawolf - NotSoRandom chargen
                if (sPlayerbotAIConfig.notrandom)
                {
                    QueryResult qresult = CharacterDatabase.Query("SELECT COUNT(in_use) FROM ai_playerbot_names WHERE in_use = 0");
                    Field *fields = qresult->Fetch();
                    uint32 bstop = fields[0].GetUInt32();

                    if (bstop == 0)
                    {
                        cls = MAX_CLASSES;
						continue;
                    } 
                    else 
                    {
                        ++nid;
                        //factory.CreateNotRandomBot(cls);
                        factory.CreateNotRandomBot(nid);
                    }
                }
                else
                {
                    factory.CreateRandomBot(cls);
                }
            }
		}

		totalRandomBotChars += AccountMgr::GetCharactersCount(accountId);
	}

	sLog->outBasic("%d random bot accounts with %d characters available", sPlayerbotAIConfig.randomBotAccounts.size(), totalRandomBotChars);
}


void RandomPlayerbotFactory::CreateRandomGuilds()
{
	vector<uint32> randomBots;
	QueryResult results = LoginDatabase.PQuery("SELECT id FROM account where username like '%s%%'", sPlayerbotAIConfig.randomBotAccountPrefix.c_str());
	if (results)
	{
		do
		{
			Field* fields = results->Fetch();
			uint32 accountId = fields[0].GetUInt32();

			QueryResult results2 = CharacterDatabase.PQuery("SELECT guid FROM characters where account  = '%u'", accountId);
			if (results2)
			{
				do
				{
					Field* fields = results2->Fetch();
					uint32 guid = fields[0].GetUInt32();
					randomBots.push_back(guid);
				} while (results2->NextRow());
			}

		} while (results->NextRow());
	}

	if (sPlayerbotAIConfig.deleteRandomBotGuilds)
	{
		sLog->outBasic("Deleting random bot guilds...");
		for (vector<uint32>::iterator i = randomBots.begin(); i != randomBots.end(); ++i)
		{
			uint64 leader = MAKE_NEW_GUID(*i, 0, HIGHGUID_PLAYER);
			Guild* guild = sGuildMgr->GetGuildByLeader(leader);
			if (guild) guild->Disband();
		}
		sLog->outBasic("Random bot guilds deleted");
	}

	int guildNumber = 0;
	vector<uint64> availableLeaders;
	for (vector<uint32>::iterator i = randomBots.begin(); i != randomBots.end(); ++i)
	{
		uint64 leader = MAKE_NEW_GUID(*i, 0, HIGHGUID_PLAYER);
		Guild* guild = sGuildMgr->GetGuildByLeader(leader);
		if (guild)
		{
			++guildNumber;
			sPlayerbotAIConfig.randomBotGuilds.push_back(guild->GetId());
		}
		else
		{
			Player* player = ObjectAccessor::FindPlayer(leader);
			if (player)
				availableLeaders.push_back(leader);
		}
	}

	for (; guildNumber < sPlayerbotAIConfig.randomBotGuildCount; ++guildNumber)
	{
		string guildName = CreateRandomGuildName();
		if (guildName.empty())
			break;

		if (availableLeaders.empty())
		{
			sLog->outError("No leaders for random guilds available");
			break;
		}

		int index = urand(0, availableLeaders.size() - 1);
		uint64 leader = availableLeaders[index];
		Player* player = ObjectAccessor::FindPlayer(leader);
		if (!player)
		{
			sLog->outError("Cannot find player for leader %u", leader);
			break;
		}

		Guild* guild = new Guild();
		if (!guild->Create(player, guildName))
		{
			sLog->outError("Error creating guild %s", guildName.c_str());
			break;
		}

		sGuildMgr->AddGuild(guild);
		sPlayerbotAIConfig.randomBotGuilds.push_back(guild->GetId());
	}

	sLog->outBasic("%d random bot guilds available", guildNumber);
}

string RandomPlayerbotFactory::CreateRandomGuildName()
{
	QueryResult result = CharacterDatabase.Query("SELECT MAX(name_id) FROM ai_playerbot_guild_names");
	if (!result)
	{
		sLog->outError("No more names left for random guilds");
		return "";
	}

	Field *fields = result->Fetch();
	uint32 maxId = fields[0].GetUInt32();

	uint32 id = urand(0, maxId);
	result = CharacterDatabase.PQuery("SELECT n.name FROM ai_playerbot_guild_names n "
		"LEFT OUTER JOIN guild e ON e.name = n.name "
		"WHERE e.guildid IS NULL AND n.name_id >= '%u' LIMIT 1", id);
	if (!result)
	{
		sLog->outError("No more names left for random guilds");
		return "";
	}

	fields = result->Fetch();
	return fields[0].GetString();
}

