#include "RobotManager.h"
#include "AI_Base.h"
#include "Log.h"
#include "AccountMgr.h"
#include "Player.h"
#include "Chat.h"
#include "Pet.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "MotionMaster.h"
#include "MapManager.h"
#include "Group.h"
#include "Item.h"
#include "World.h"
#include "SpellAuras.h"
#include "SpellMgr.h"
#include "RobotConfig.h"
#include "CreatureAI.h"
#include "GridNotifiers.h"
#include "Script_Paladin.h"
#include "Script_Hunter.h"
#include "Script_Shaman.h"
#include "RobotConfig.h"

RobotManager::RobotManager()
{
    nameIndex = 0;
    robotEntityMap.clear();
    deleteRobotAccountSet.clear();
    onlinePlayerIDMap.clear();
    tamableBeastEntryMap.clear();
    spellRewardClassQuestIDSet.clear();
    spellNameEntryMap.clear();
}

void RobotManager::InitializeManager()
{
    if (sRobotConfig->Enable == 0)
    {
        return;
    }

    sLog->outBasic("Initialize robot manager");

    QueryResult robotNamesQR = WorldDatabase.Query("SELECT name FROM robot_names order by rand()");
    if (!robotNamesQR)
    {
        sLog->outError("Found zero robot names");
        sRobotConfig->Enable = false;
        return;
    }
    do
    {
        Field* fields = robotNamesQR->Fetch();
        std::string eachName = fields[0].GetString();
        robotNameMap[robotNameMap.size()] = eachName;
    } while (robotNamesQR->NextRow());

    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = RACE_HUMAN;
    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = RACE_NIGHTELF;
    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = RACE_GNOME;
    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = RACE_DWARF;
    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = RACE_ORC;
    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = Races::RACE_UNDEAD_PLAYER;
    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = RACE_TAUREN;
    availableRaces[CLASS_WARRIOR][availableRaces[CLASS_WARRIOR].size()] = RACE_TROLL;

    availableRaces[CLASS_PALADIN][availableRaces[CLASS_PALADIN].size()] = RACE_HUMAN;
    availableRaces[CLASS_PALADIN][availableRaces[CLASS_PALADIN].size()] = RACE_DWARF;
    availableRaces[CLASS_PALADIN][availableRaces[CLASS_PALADIN].size()] = Races::RACE_DRAENEI;
    availableRaces[CLASS_PALADIN][availableRaces[CLASS_PALADIN].size()] = Races::RACE_BLOODELF;

    availableRaces[CLASS_ROGUE][availableRaces[CLASS_ROGUE].size()] = RACE_HUMAN;
    availableRaces[CLASS_ROGUE][availableRaces[CLASS_ROGUE].size()] = RACE_DWARF;
    availableRaces[CLASS_ROGUE][availableRaces[CLASS_ROGUE].size()] = RACE_NIGHTELF;
    availableRaces[CLASS_ROGUE][availableRaces[CLASS_ROGUE].size()] = RACE_GNOME;
    availableRaces[CLASS_ROGUE][availableRaces[CLASS_ROGUE].size()] = RACE_ORC;
    availableRaces[CLASS_ROGUE][availableRaces[CLASS_ROGUE].size()] = RACE_TROLL;
    availableRaces[CLASS_ROGUE][availableRaces[CLASS_ROGUE].size()] = Races::RACE_UNDEAD_PLAYER;

    availableRaces[CLASS_PRIEST][availableRaces[CLASS_PRIEST].size()] = RACE_HUMAN;
    availableRaces[CLASS_PRIEST][availableRaces[CLASS_PRIEST].size()] = RACE_DWARF;
    availableRaces[CLASS_PRIEST][availableRaces[CLASS_PRIEST].size()] = RACE_NIGHTELF;
    availableRaces[CLASS_PRIEST][availableRaces[CLASS_PRIEST].size()] = RACE_TROLL;
    availableRaces[CLASS_PRIEST][availableRaces[CLASS_PRIEST].size()] = Races::RACE_UNDEAD_PLAYER;

    availableRaces[CLASS_MAGE][availableRaces[CLASS_MAGE].size()] = RACE_HUMAN;
    availableRaces[CLASS_MAGE][availableRaces[CLASS_MAGE].size()] = RACE_GNOME;
    availableRaces[CLASS_MAGE][availableRaces[CLASS_MAGE].size()] = RACE_UNDEAD_PLAYER;
    availableRaces[CLASS_MAGE][availableRaces[CLASS_MAGE].size()] = RACE_TROLL;

    availableRaces[CLASS_WARLOCK][availableRaces[CLASS_WARLOCK].size()] = RACE_HUMAN;
    availableRaces[CLASS_WARLOCK][availableRaces[CLASS_WARLOCK].size()] = RACE_GNOME;
    availableRaces[CLASS_WARLOCK][availableRaces[CLASS_WARLOCK].size()] = RACE_UNDEAD_PLAYER;
    availableRaces[CLASS_WARLOCK][availableRaces[CLASS_WARLOCK].size()] = RACE_ORC;
    availableRaces[CLASS_WARLOCK][availableRaces[CLASS_WARLOCK].size()] = Races::RACE_DRAENEI;

    availableRaces[CLASS_SHAMAN][availableRaces[CLASS_SHAMAN].size()] = RACE_ORC;
    availableRaces[CLASS_SHAMAN][availableRaces[CLASS_SHAMAN].size()] = RACE_TAUREN;
    availableRaces[CLASS_SHAMAN][availableRaces[CLASS_SHAMAN].size()] = RACE_TROLL;

    availableRaces[CLASS_HUNTER][availableRaces[CLASS_HUNTER].size()] = RACE_DWARF;
    availableRaces[CLASS_HUNTER][availableRaces[CLASS_HUNTER].size()] = RACE_NIGHTELF;
    availableRaces[CLASS_HUNTER][availableRaces[CLASS_HUNTER].size()] = RACE_ORC;
    availableRaces[CLASS_HUNTER][availableRaces[CLASS_HUNTER].size()] = RACE_TAUREN;
    availableRaces[CLASS_HUNTER][availableRaces[CLASS_HUNTER].size()] = RACE_TROLL;

    availableRaces[CLASS_DRUID][availableRaces[CLASS_DRUID].size()] = RACE_NIGHTELF;
    availableRaces[CLASS_DRUID][availableRaces[CLASS_DRUID].size()] = RACE_TAUREN;

    allianceRaces[CLASS_WARRIOR][allianceRaces[CLASS_WARRIOR].size()] = RACE_HUMAN;
    allianceRaces[CLASS_WARRIOR][allianceRaces[CLASS_WARRIOR].size()] = RACE_NIGHTELF;
    allianceRaces[CLASS_WARRIOR][allianceRaces[CLASS_WARRIOR].size()] = RACE_GNOME;
    allianceRaces[CLASS_WARRIOR][allianceRaces[CLASS_WARRIOR].size()] = RACE_DWARF;

    allianceRaces[CLASS_PALADIN][allianceRaces[CLASS_PALADIN].size()] = RACE_HUMAN;
    allianceRaces[CLASS_PALADIN][allianceRaces[CLASS_PALADIN].size()] = RACE_DWARF;
    allianceRaces[CLASS_PALADIN][allianceRaces[CLASS_PALADIN].size()] = Races::RACE_DRAENEI;

    allianceRaces[Classes::CLASS_SHAMAN][allianceRaces[Classes::CLASS_SHAMAN].size()] = Races::RACE_DRAENEI;

    allianceRaces[CLASS_ROGUE][allianceRaces[CLASS_ROGUE].size()] = RACE_HUMAN;
    allianceRaces[CLASS_ROGUE][allianceRaces[CLASS_ROGUE].size()] = RACE_DWARF;
    allianceRaces[CLASS_ROGUE][allianceRaces[CLASS_ROGUE].size()] = RACE_NIGHTELF;
    allianceRaces[CLASS_ROGUE][allianceRaces[CLASS_ROGUE].size()] = RACE_GNOME;

    allianceRaces[CLASS_PRIEST][allianceRaces[CLASS_PRIEST].size()] = RACE_HUMAN;
    allianceRaces[CLASS_PRIEST][allianceRaces[CLASS_PRIEST].size()] = RACE_DWARF;
    allianceRaces[CLASS_PRIEST][allianceRaces[CLASS_PRIEST].size()] = RACE_NIGHTELF;

    allianceRaces[CLASS_MAGE][allianceRaces[CLASS_MAGE].size()] = RACE_HUMAN;
    allianceRaces[CLASS_MAGE][allianceRaces[CLASS_MAGE].size()] = RACE_GNOME;

    allianceRaces[CLASS_WARLOCK][allianceRaces[CLASS_WARLOCK].size()] = RACE_HUMAN;
    allianceRaces[CLASS_WARLOCK][allianceRaces[CLASS_WARLOCK].size()] = RACE_GNOME;

    allianceRaces[CLASS_HUNTER][allianceRaces[CLASS_HUNTER].size()] = RACE_DWARF;
    allianceRaces[CLASS_HUNTER][allianceRaces[CLASS_HUNTER].size()] = RACE_NIGHTELF;

    allianceRaces[CLASS_DRUID][allianceRaces[CLASS_DRUID].size()] = RACE_NIGHTELF;

    hordeRaces[CLASS_WARRIOR][hordeRaces[CLASS_WARRIOR].size()] = RACE_ORC;
    hordeRaces[CLASS_WARRIOR][hordeRaces[CLASS_WARRIOR].size()] = Races::RACE_UNDEAD_PLAYER;
    hordeRaces[CLASS_WARRIOR][hordeRaces[CLASS_WARRIOR].size()] = RACE_TAUREN;
    hordeRaces[CLASS_WARRIOR][hordeRaces[CLASS_WARRIOR].size()] = RACE_TROLL;

    hordeRaces[CLASS_ROGUE][hordeRaces[CLASS_ROGUE].size()] = RACE_ORC;
    hordeRaces[CLASS_ROGUE][hordeRaces[CLASS_ROGUE].size()] = RACE_TROLL;
    hordeRaces[CLASS_ROGUE][hordeRaces[CLASS_ROGUE].size()] = Races::RACE_UNDEAD_PLAYER;

    hordeRaces[CLASS_PRIEST][hordeRaces[CLASS_PRIEST].size()] = RACE_TROLL;
    hordeRaces[CLASS_PRIEST][hordeRaces[CLASS_PRIEST].size()] = Races::RACE_UNDEAD_PLAYER;

    hordeRaces[CLASS_MAGE][hordeRaces[CLASS_MAGE].size()] = RACE_UNDEAD_PLAYER;
    hordeRaces[CLASS_MAGE][hordeRaces[CLASS_MAGE].size()] = RACE_TROLL;

    hordeRaces[CLASS_WARLOCK][hordeRaces[CLASS_WARLOCK].size()] = RACE_UNDEAD_PLAYER;
    hordeRaces[CLASS_WARLOCK][hordeRaces[CLASS_WARLOCK].size()] = RACE_ORC;

    hordeRaces[CLASS_SHAMAN][hordeRaces[CLASS_SHAMAN].size()] = RACE_ORC;
    hordeRaces[CLASS_SHAMAN][hordeRaces[CLASS_SHAMAN].size()] = RACE_TAUREN;
    hordeRaces[CLASS_SHAMAN][hordeRaces[CLASS_SHAMAN].size()] = RACE_TROLL;

    hordeRaces[Classes::CLASS_PALADIN][hordeRaces[Classes::CLASS_PALADIN].size()] = Races::RACE_BLOODELF;

    hordeRaces[CLASS_HUNTER][hordeRaces[CLASS_HUNTER].size()] = RACE_ORC;
    hordeRaces[CLASS_HUNTER][hordeRaces[CLASS_HUNTER].size()] = RACE_TAUREN;
    hordeRaces[CLASS_HUNTER][hordeRaces[CLASS_HUNTER].size()] = RACE_TROLL;

    hordeRaces[CLASS_DRUID][hordeRaces[CLASS_DRUID].size()] = RACE_TAUREN;

    characterTalentTabNameMap.clear();
    characterTalentTabNameMap[Classes::CLASS_WARRIOR][0] = "Arms";
    characterTalentTabNameMap[Classes::CLASS_WARRIOR][1] = "Fury";
    characterTalentTabNameMap[Classes::CLASS_WARRIOR][2] = "Protection";

    characterTalentTabNameMap[Classes::CLASS_HUNTER][0] = "Beast Mastery";
    characterTalentTabNameMap[Classes::CLASS_HUNTER][1] = "Marksmanship";
    characterTalentTabNameMap[Classes::CLASS_HUNTER][2] = "Survival";

    characterTalentTabNameMap[Classes::CLASS_SHAMAN][0] = "Elemental";
    characterTalentTabNameMap[Classes::CLASS_SHAMAN][1] = "Enhancement";
    characterTalentTabNameMap[Classes::CLASS_SHAMAN][2] = "Restoration";

    characterTalentTabNameMap[Classes::CLASS_PALADIN][0] = "Holy";
    characterTalentTabNameMap[Classes::CLASS_PALADIN][1] = "Protection";
    characterTalentTabNameMap[Classes::CLASS_PALADIN][2] = "Retribution";

    characterTalentTabNameMap[Classes::CLASS_WARLOCK][0] = "Affliction";
    characterTalentTabNameMap[Classes::CLASS_WARLOCK][1] = "Demonology";
    characterTalentTabNameMap[Classes::CLASS_WARLOCK][2] = "Destruction";

    characterTalentTabNameMap[Classes::CLASS_PRIEST][0] = "Descipline";
    characterTalentTabNameMap[Classes::CLASS_PRIEST][1] = "Holy";
    characterTalentTabNameMap[Classes::CLASS_PRIEST][2] = "Shadow";

    characterTalentTabNameMap[Classes::CLASS_ROGUE][0] = "Assassination";
    characterTalentTabNameMap[Classes::CLASS_ROGUE][1] = "Combat";
    characterTalentTabNameMap[Classes::CLASS_ROGUE][2] = "subtlety";

    characterTalentTabNameMap[Classes::CLASS_MAGE][0] = "Arcane";
    characterTalentTabNameMap[Classes::CLASS_MAGE][1] = "Fire";
    characterTalentTabNameMap[Classes::CLASS_MAGE][2] = "Frost";

    characterTalentTabNameMap[Classes::CLASS_DRUID][0] = "Balance";
    characterTalentTabNameMap[Classes::CLASS_DRUID][1] = "Feral";
    characterTalentTabNameMap[Classes::CLASS_DRUID][2] = "Restoration";

    spellRewardClassQuestIDSet.clear();
    std::unordered_map<uint32, Quest*>  qTemplates = sObjectMgr->GetQuestTemplates();
    for (const auto& itr : qTemplates)
    {
        const auto& qinfo = itr.second;
        if (qinfo->GetRequiredClasses() > 0)
        {
            if (qinfo->GetRewSpellCast() > 0)
            {
                spellRewardClassQuestIDSet.insert(itr.first);
            }
        }
    }
    const std::unordered_map<uint32, CreatureTemplate>* creatureTemplateMap = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = creatureTemplateMap->begin(); itr != creatureTemplateMap->end(); ++itr)
    {
        CreatureTemplate cInfo = itr->second;
        if (cInfo.IsTameable(false))
        {
            tamableBeastEntryMap[tamableBeastEntryMap.size()] = cInfo.Entry;
        }
    }
    for (uint32 i = 0; i < sSpellMgr->GetSpellInfoStoreSize(); i++)
    {
        SpellInfo const* pS = sSpellMgr->GetSpellInfo(i);
        if (!pS)
        {
            continue;
        }
        spellNameEntryMap[pS->SpellName[0]].insert(pS->Id);
    }

    QueryResult worldRobotQR = CharacterDatabase.Query("SELECT robot_id, account_name, character_id, target_level, robot_type FROM robot order by rand()");
    if (worldRobotQR)
    {
        do
        {
            Field* fields = worldRobotQR->Fetch();
            uint32 robot_id = fields[0].GetUInt32();
            std::string account_name = fields[1].GetString();
            uint32 character_id = fields[2].GetUInt32();
            uint32 target_level = fields[3].GetUInt32();
            uint32 robot_type = fields[4].GetUInt32();
            RobotEntity* re = new RobotEntity(robot_id);
            re->account_name = account_name;
            re->character_id = character_id;
            re->target_level = target_level;
            re->robot_type = robot_type;
            robotEntityMap[account_name] = re;
        } while (worldRobotQR->NextRow());
    }

    sLog->outBasic("Robot system ready");
}

RobotManager* RobotManager::instance()
{
    static RobotManager instance;
    return &instance;
}

void RobotManager::UpdateRobotManager(uint32 pmDiff)
{
    if (sRobotConfig->Enable == 0)
    {
        return;
    }

    for (std::unordered_map<std::string, RobotEntity*>::iterator reIT = robotEntityMap.begin(); reIT != robotEntityMap.end(); reIT++)
    {
        if (RobotEntity* eachRE = reIT->second)
        {
            eachRE->Update(pmDiff);
        }
    }
}

bool RobotManager::DeleteRobots()
{
    CharacterDatabase.DirectExecute("delete from robot");

    std::ostringstream sqlStream;
    sqlStream << "SELECT id, username FROM account where username like '" << sRobotConfig->AccountNamePrefix << "%'";
    std::string sql = sqlStream.str();
    QueryResult accountQR = LoginDatabase.Query(sql.c_str());

    if (accountQR)
    {
        do
        {
            Field* fields = accountQR->Fetch();
            uint32 id = fields[0].GetUInt32();
            std::string userName = fields[1].GetString();
            deleteRobotAccountSet.insert(id);
            AccountMgr::DeleteAccount(id);
            sLog->outBasic("Delete robot account %d - %s", id, userName.c_str());
        } while (accountQR->NextRow());
    }
    robotEntityMap.clear();

    return true;
}

bool RobotManager::RobotsDeleted()
{
    for (std::set<uint32>::iterator it = deleteRobotAccountSet.begin(); it != deleteRobotAccountSet.end(); it++)
    {
        QueryResult accountQR = LoginDatabase.PQuery("SELECT id FROM account where id = '%d'", (*it));
        if (accountQR)
        {
            sLog->outBasic("Account %d is under deleting", (*it));
            return false;
        }
        QueryResult characterQR = CharacterDatabase.PQuery("SELECT count(*) FROM characters where account = '%d'", (*it));
        if (characterQR)
        {
            Field* fields = characterQR->Fetch();
            uint32 count = fields[0].GetUInt32();
            if (count > 0)
            {
                sLog->outBasic("Characters for account %d are under deleting", (*it));
                return false;
            }
        }
    }

    sLog->outBasic("Robot accounts are deleted");
    return true;
}

uint32 RobotManager::CheckRobotAccount(std::string pmAccountName)
{
    uint32 accountID = 0;

    QueryResult accountQR = LoginDatabase.PQuery("SELECT id FROM account where username = '%s'", pmAccountName.c_str());
    if (accountQR)
    {
        Field* idFields = accountQR->Fetch();
        accountID = idFields[0].GetUInt32();
    }
    return accountID;
}

bool RobotManager::CreateRobotAccount(std::string pmAccountName)
{
    bool result = false;

    AccountOpResult aor = AccountMgr::CreateAccount(pmAccountName, ROBOT_PASSWORD);
    if (aor == AccountOpResult::AOR_NAME_ALREDY_EXIST)
    {
        result = true;
    }
    else if (aor == AccountOpResult::AOR_OK)
    {
        result = true;
    }

    return result;
}

uint32 RobotManager::CheckAccountCharacter(uint32 pmAccountID)
{
    uint32 result = 0;

    QueryResult characterQR = CharacterDatabase.PQuery("SELECT guid FROM characters where account = '%d'", pmAccountID);
    if (characterQR)
    {
        Field* characterFields = characterQR->Fetch();
        result = characterFields[0].GetUInt32();
    }
    return result;
}

uint32 RobotManager::GetCharacterRace(uint32 pmCharacterID)
{
    uint32 result = 0;

    QueryResult characterQR = CharacterDatabase.PQuery("SELECT race FROM characters where guid = '%d'", pmCharacterID);
    if (characterQR)
    {
        Field* characterFields = characterQR->Fetch();
        result = characterFields[0].GetUInt32();
    }
    return result;
}

uint32 RobotManager::CreateRobotCharacter(uint32 pmAccountID, uint16 pmCampType)
{
    uint32  targetClass = Classes::CLASS_PALADIN;
    uint32 raceIndex = 0;
    uint32 targetRace = 0;
    if (pmCampType == RobotCampType::RobotCampType_Alliance)
    {
        raceIndex = urand(0, allianceRaces[targetClass].size() - 1);
        targetRace = allianceRaces[targetClass][raceIndex];
    }
    else if (pmCampType == RobotCampType::RobotCampType_Horde)
    {
        raceIndex = urand(0, hordeRaces[targetClass].size() - 1);
        targetRace = hordeRaces[targetClass][raceIndex];
    }
    else
    {
        raceIndex = urand(0, availableRaces[targetClass].size() - 1);
        targetRace = availableRaces[targetClass][raceIndex];
    }

    return CreateRobotCharacter(pmAccountID, targetClass, targetRace);
}

uint32 RobotManager::CreateRobotCharacter(uint32 pmAccountID, uint32 pmCharacterClass, uint32 pmCharacterRace)
{
    uint32 result = 0;

    std::string currentName = "";
    bool nameValid = false;
    while (nameIndex < robotNameMap.size())
    {
        currentName = robotNameMap[nameIndex];
        QueryResult checkNameQR = CharacterDatabase.PQuery("SELECT count(*) FROM characters where name = '%s'", currentName.c_str());

        if (!checkNameQR)
        {
            sLog->outBasic("Name %s is available", currentName.c_str());
            nameValid = true;
        }
        else
        {
            Field* nameCountFields = checkNameQR->Fetch();
            uint32 nameCount = nameCountFields[0].GetUInt32();
            if (nameCount == 0)
            {
                nameValid = true;
            }
        }
        nameIndex++;
        if (nameValid)
        {
            break;
        }
    }
    if (!nameValid)
    {
        sLog->outError("No available names");
        return false;
    }

    uint8 gender = 0, skin = 0, face = 0, hairStyle = 0, hairColor = 0, facialHair = 0;
    while (true)
    {
        gender = urand(0, 100);
        if (gender < 50)
        {
            gender = 0;
        }
        else
        {
            gender = 1;
        }
        face = urand(0, 5);
        hairStyle = urand(0, 5);
        hairColor = urand(0, 5);
        facialHair = urand(0, 5);
        WorldPacket wp;
        CharacterCreateInfo* cci = new CharacterCreateInfo(currentName, pmCharacterRace, pmCharacterClass, gender, skin, face, hairStyle, hairColor, facialHair, 0, wp);
        WorldSession* eachSession = new WorldSession(pmAccountID, NULL, SEC_PLAYER, 2, 0, LOCALE_enUS, 0, false, true, 0);
        Player* newPlayer = new Player(eachSession);
        if (!newPlayer->Create(sObjectMgr->GenerateLowGuid(HIGHGUID_PLAYER), cci))
        {
            newPlayer->CleanupsBeforeDelete();
            delete eachSession;
            delete newPlayer;
            sLog->outError("Character create failed, %s %d %d", currentName.c_str(), pmCharacterRace, pmCharacterClass);
            sLog->outBasic("Try again");
            continue;
        }
        newPlayer->GetMotionMaster()->Initialize();
        newPlayer->setCinematic(2);
        newPlayer->SetAtLoginFlag(AT_LOGIN_NONE);
        newPlayer->SaveToDB(true, false);
        result = newPlayer->GetGUIDLow();
        eachSession->isRobotSession = true;
        sWorld->AddSession(eachSession);
        sLog->outBasic("Create character %d - %s for account %d", newPlayer->GetGUIDLow(), currentName.c_str(), pmAccountID);
        break;
    }

    return result;
}

Player* RobotManager::CheckLogin(uint32 pmAccountID, uint32 pmCharacterID)
{
    uint64 guid = MAKE_NEW_GUID(pmCharacterID, 0, HIGHGUID_PLAYER);
    Player* currentPlayer = ObjectAccessor::FindPlayer(guid);
    if (currentPlayer)
    {
        return currentPlayer;
    }
    return NULL;
}

bool RobotManager::LoginRobot(uint32 pmAccountID, uint32 pmCharacterID)
{
    uint64 playerGuid = MAKE_NEW_GUID(pmCharacterID, 0, HIGHGUID_PLAYER);
    if (Player* currentPlayer = ObjectAccessor::FindPlayer(playerGuid))
    {
        sLog->outBasic("Robot %d %s is already in world", pmCharacterID, currentPlayer->GetName().c_str());
        return false;
    }
    WorldSession* loginSession = sWorld->FindSession(pmAccountID);
    if (!loginSession)
    {
        loginSession = new WorldSession(pmAccountID, NULL, SEC_PLAYER, 2, 0, LOCALE_enUS, 0, false, true, 0);
        sWorld->AddSession(loginSession);
    }
    loginSession->isRobotSession = true;
    WorldPacket p;
    p << playerGuid;
    loginSession->HandlePlayerLoginOpcode(p);
    sLog->outBasic("Log in character %d %d", pmAccountID, pmCharacterID);

    return true;
}

void RobotManager::LogoutRobot(uint32 pmCharacterID)
{
    uint64 guid = MAKE_NEW_GUID(pmCharacterID, 0, HIGHGUID_PLAYER);
    Player* checkP = ObjectAccessor::FindPlayer(guid);
    if (checkP)
    {
        sLog->outBasic("Log out robot %s", checkP->GetName().c_str());
        std::ostringstream msgStream;
        msgStream << checkP->GetName() << " logged out";
        sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, msgStream.str().c_str());
        if (WorldSession* checkWS = checkP->GetSession())
        {
            checkWS->LogoutPlayer(true);
        }
    }
}

void RobotManager::LogoutRobots(bool pmWait, uint32 pmWaitMin, uint32 pmWaitMax)
{
    for (std::unordered_map<std::string, RobotEntity*>::iterator reIT = robotEntityMap.begin(); reIT != robotEntityMap.end(); reIT++)
    {
        RobotEntity* eachRE = reIT->second;
        eachRE->entityState = RobotEntityState::RobotEntityState_DoLogoff;
        uint32 offlineWaiting = 5;
        if (pmWait)
        {
            offlineWaiting = urand(pmWaitMin, pmWaitMax);
        }
        eachRE->checkDelay = offlineWaiting * TimeConstants::IN_MILLISECONDS;
    }
}

bool RobotManager::PrepareRobot(Player* pmRobot)
{
    if (!pmRobot)
    {
        return false;
    }

    InitializeEquipments(pmRobot, false);

    pmRobot->DurabilityRepairAll(false, 0, false);
    if (pmRobot->getClass() == Classes::CLASS_HUNTER)
    {
        uint32 ammoEntry = 0;
        Item* weapon = pmRobot->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED);
        if (weapon)
        {
            if (const ItemTemplate* it = weapon->GetTemplate())
            {
                uint32 subClass = it->SubClass;
                uint8 playerLevel = pmRobot->getLevel();
                if (subClass == ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_BOW || subClass == ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_CROSSBOW)
                {
                    if (playerLevel >= 40)
                    {
                        ammoEntry = 11285;
                    }
                    else if (playerLevel >= 25)
                    {
                        ammoEntry = 3030;
                    }
                    else
                    {
                        ammoEntry = 2515;
                    }
                }
                else if (subClass == ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_GUN)
                {
                    if (playerLevel >= 40)
                    {
                        ammoEntry = 11284;
                    }
                    else if (playerLevel >= 25)
                    {
                        ammoEntry = 3033;
                    }
                    else
                    {
                        ammoEntry = 2519;
                    }
                }
                if (ammoEntry > 0)
                {
                    if (!pmRobot->HasItemCount(ammoEntry, 100))
                    {
                        pmRobot->StoreNewItemInBestSlots(ammoEntry, 1000);
                        pmRobot->SetAmmo(ammoEntry);
                    }
                }
            }
        }
    }
    else if (pmRobot->getClass() == Classes::CLASS_SHAMAN)
    {
        if (!pmRobot->HasItemCount(5175))
        {
            pmRobot->StoreNewItemInBestSlots(5175, 1);
        }
        if (!pmRobot->HasItemCount(5176))
        {
            pmRobot->StoreNewItemInBestSlots(5176, 1);
        }
    }
    Pet* checkPet = pmRobot->GetPet();
    if (checkPet)
    {
        checkPet->SetReactState(REACT_DEFENSIVE);
        if (checkPet->getPetType() == PetType::HUNTER_PET)
        {
            checkPet->SetPower(POWER_HAPPINESS, HAPPINESS_LEVEL_SIZE * 3);
        }
        std::unordered_map<uint32, PetSpell> petSpellMap = checkPet->m_spells;
        for (std::unordered_map<uint32, PetSpell>::iterator it = petSpellMap.begin(); it != petSpellMap.end(); it++)
        {
            if (it->second.active == ACT_DISABLED || it->second.active == ACT_ENABLED)
            {
                const SpellInfo* pS = sSpellMgr->GetSpellInfo(it->first);
                if (pS)
                {
                    std::string checkNameStr = std::string(pS->SpellName[0]);
                    if (checkNameStr == "Prowl")
                    {
                        checkPet->ToggleAutocast(pS, false);
                    }
                    else if (checkNameStr == "Phase Shift")
                    {
                        checkPet->ToggleAutocast(pS, false);
                    }
                    else if (checkNameStr == "Cower")
                    {
                        checkPet->ToggleAutocast(pS, false);
                    }
                    else if (checkNameStr == "Growl")
                    {
                        if (pmRobot->GetGroup())
                        {
                            checkPet->ToggleAutocast(pS, false);
                        }
                        else
                        {
                            checkPet->ToggleAutocast(pS, true);
                        }
                    }
                    else
                    {
                        checkPet->ToggleAutocast(pS, true);
                    }
                }
            }
        }
    }

    if (!pmRobot->GetGroup())
    {
        for (uint8 i = 0; i < MAX_DIFFICULTY; ++i)
        {
            BoundInstancesMap const& m_boundInstances = sInstanceSaveMgr->PlayerGetBoundInstances(pmRobot->GetGUIDLow(), Difficulty(i));
            for (BoundInstancesMap::const_iterator itr = m_boundInstances.begin(); itr != m_boundInstances.end();)
            {
                InstanceSave* save = itr->second.save;
                sInstanceSaveMgr->PlayerUnbindInstance(pmRobot->GetGUIDLow(), itr->first, Difficulty(i), true, pmRobot);
                itr = m_boundInstances.begin();
                ++itr;
            }
        }
    }
    pmRobot->Say("Ready", Language::LANG_UNIVERSAL);
}

std::unordered_set<uint32> RobotManager::GetUsableEquipSlot(const ItemTemplate* pmIT)
{
    std::unordered_set<uint32> resultSet;

    switch (pmIT->InventoryType)
    {
    case INVTYPE_HEAD:
    {
        resultSet.insert(EQUIPMENT_SLOT_HEAD);
        break;
    }
    case INVTYPE_NECK:
    {
        resultSet.insert(EQUIPMENT_SLOT_NECK);
        break;
    }
    case INVTYPE_SHOULDERS:
    {
        resultSet.insert(EQUIPMENT_SLOT_SHOULDERS);
        break;
    }
    case INVTYPE_BODY:
    {
        resultSet.insert(EQUIPMENT_SLOT_BODY);
        break;
    }
    case INVTYPE_CHEST:
    {
        resultSet.insert(EQUIPMENT_SLOT_CHEST);
        break;
    }
    case INVTYPE_ROBE:
    {
        resultSet.insert(EQUIPMENT_SLOT_CHEST);
        break;
    }
    case INVTYPE_WAIST:
    {
        resultSet.insert(EQUIPMENT_SLOT_WAIST);
        break;
    }
    case INVTYPE_LEGS:
    {
        resultSet.insert(EQUIPMENT_SLOT_LEGS);
        break;
    }
    case INVTYPE_FEET:
    {
        resultSet.insert(EQUIPMENT_SLOT_FEET);
        break;
    }
    case INVTYPE_WRISTS:
    {
        resultSet.insert(EQUIPMENT_SLOT_WRISTS);
        break;
    }
    case INVTYPE_HANDS:
    {
        resultSet.insert(EQUIPMENT_SLOT_HANDS);
        break;
    }
    case INVTYPE_FINGER:
    {
        resultSet.insert(EQUIPMENT_SLOT_FINGER1);
        resultSet.insert(EQUIPMENT_SLOT_FINGER2);
        break;
    }
    case INVTYPE_TRINKET:
    {
        resultSet.insert(EQUIPMENT_SLOT_TRINKET1);
        resultSet.insert(EQUIPMENT_SLOT_TRINKET2);
        break;
    }
    case INVTYPE_CLOAK:
    {
        resultSet.insert(EQUIPMENT_SLOT_BACK);
        break;
    }
    case INVTYPE_WEAPON:
    {
        resultSet.insert(EQUIPMENT_SLOT_MAINHAND);
        resultSet.insert(EQUIPMENT_SLOT_OFFHAND);
        break;
    }
    case INVTYPE_SHIELD:
    {
        resultSet.insert(EQUIPMENT_SLOT_OFFHAND);
        break;
    }
    case INVTYPE_RANGED:
    {
        resultSet.insert(EQUIPMENT_SLOT_RANGED);
        break;
    }
    case INVTYPE_2HWEAPON:
    {
        resultSet.insert(EQUIPMENT_SLOT_MAINHAND);
        break;
    }
    case INVTYPE_TABARD:
    {
        resultSet.insert(EQUIPMENT_SLOT_TABARD);
        break;
    }
    case INVTYPE_WEAPONMAINHAND:
    {
        resultSet.insert(EQUIPMENT_SLOT_MAINHAND);
        break;
    }
    case INVTYPE_WEAPONOFFHAND:
    {
        resultSet.insert(EQUIPMENT_SLOT_OFFHAND);
        break;
    }
    case INVTYPE_HOLDABLE:
    {
        resultSet.insert(EQUIPMENT_SLOT_OFFHAND);
        break;
    }
    case INVTYPE_THROWN:
    {
        resultSet.insert(EQUIPMENT_SLOT_RANGED);
        break;
    }
    case INVTYPE_RANGEDRIGHT:
    {
        resultSet.insert(EQUIPMENT_SLOT_RANGED);
        break;
    }
    case INVTYPE_BAG:
    {
        resultSet.insert(INVENTORY_SLOT_BAG_START);
        break;
    }
    case INVTYPE_RELIC:
    {
        break;
    }
    default:
    {
        break;
    }
    }

    return resultSet;
}

void RobotManager::HandlePlayerSay(Player* pmPlayer, std::string pmContent)
{
    if (!pmPlayer)
    {
        return;
    }
    std::vector<std::string> commandVector = SplitString(pmContent, " ", true);
    std::string commandName = commandVector.at(0);
    if (commandName == "role")
    {
        if (AI_Base* playerAI = pmPlayer->robotAI)
        {
            if (commandVector.size() > 1)
            {
                std::string newRole = commandVector.at(1);
                playerAI->SetGroupRole(newRole);
            }
            std::ostringstream replyStream;
            replyStream << "Your group role is ";
            replyStream << playerAI->GetGroupRoleName();
            sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
        }
    }
    else if (commandName == "arrangement")
    {
        std::ostringstream replyStream;
        if (Group* myGroup = pmPlayer->GetGroup())
        {
            if (myGroup->GetLeaderGUID() == pmPlayer->GetGUID())
            {
                bool paladinJudgement_Justice = false;
                bool paladinJudgement_Light = false;
                bool paladinJudgement_Wisdom = false;

                bool paladinAura_concentration = false;
                bool paladinAura_devotion = false;
                bool paladinAura_retribution = false;
                bool paladinAura_fire = false;
                bool paladinAura_frost = false;
                bool paladinAura_shadow = false;

                bool paladinBlessing_kings = false;
                bool paladinBlessing_might = false;
                bool paladinBlessing_wisdom = false;

                bool paladinSeal_Righteousness = false;
                bool paladinSeal_Justice = false;

                int rtiIndex = 0;

                bool hunterAspect_wild = false;
                for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                {
                    Player* member = groupRef->GetSource();
                    if (member)
                    {
                        if (AI_Base* memberAI = member->robotAI)
                        {
                            memberAI->groupRole = GroupRole::GroupRole_DPS;
                            // lfm talent to group role
                            uint32 characterTalentTab = member->GetMaxTalentCountTab();
                            switch (member->getClass())
                            {
                            case Classes::CLASS_WARRIOR:
                            {
                                if (characterTalentTab == 2)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Tank;
                                }
                                break;
                            }
                            case Classes::CLASS_SHAMAN:
                            {
                                if (characterTalentTab == 2)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Healer;
                                }
                                break;
                            }
                            case Classes::CLASS_PALADIN:
                            {
                                if (characterTalentTab == 0)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Healer;
                                }
                                else if (characterTalentTab == 1)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Tank;
                                }
                                break;
                            }
                            case Classes::CLASS_PRIEST:
                            {
                                if (characterTalentTab == 0)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Healer;
                                }
                                else if (characterTalentTab == 1)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Healer;
                                }
                                break;
                            }
                            case Classes::CLASS_DRUID:
                            {
                                if (characterTalentTab == 1)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Tank;
                                }
                                else  if (characterTalentTab == 2)
                                {
                                    memberAI->groupRole = GroupRole::GroupRole_Healer;
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                            }
                            memberAI->Reset();
                            if (member->getClass() == Classes::CLASS_PALADIN)
                            {
                                if (Script_Paladin* sp = (Script_Paladin*)memberAI->sb)
                                {
                                    if (memberAI->groupRole != GroupRole::GroupRole_Healer)
                                    {
                                        if (!paladinJudgement_Justice)
                                        {
                                            sp->judgementType = PaladinJudgementType::PaladinJudgementType_Justice;
                                            paladinJudgement_Justice = true;
                                        }
                                        else if (!paladinJudgement_Light)
                                        {
                                            sp->judgementType = PaladinJudgementType::PaladinJudgementType_Light;
                                            paladinJudgement_Light = true;
                                        }
                                        else if (!paladinJudgement_Wisdom)
                                        {
                                            sp->judgementType = PaladinJudgementType::PaladinJudgementType_Wisdom;
                                            paladinJudgement_Wisdom = true;
                                        }
                                        else
                                        {
                                            sp->judgementType = PaladinJudgementType::PaladinJudgementType_Justice;
                                            paladinJudgement_Justice = true;
                                        }
                                        if (!paladinSeal_Justice)
                                        {
                                            sp->sealType = PaladinSealType::PaladinSealType_Justice;
                                            paladinSeal_Justice = true;
                                        }
                                        else if (!paladinSeal_Righteousness)
                                        {
                                            sp->sealType = PaladinSealType::PaladinSealType_Righteousness;
                                            paladinSeal_Righteousness = true;
                                        }
                                        else
                                        {
                                            sp->sealType = PaladinSealType::PaladinSealType_Justice;
                                            paladinSeal_Justice = true;
                                        }
                                    }
                                    switch (sp->blessingType)
                                    {
                                    case PaladinBlessingType::PaladinBlessingType_Kings:
                                    {
                                        if (paladinBlessing_kings)
                                        {
                                            if (!paladinBlessing_might)
                                            {
                                                sp->blessingType = PaladinBlessingType::PaladinBlessingType_Might;
                                                paladinBlessing_might = true;
                                            }
                                            else if (!paladinBlessing_wisdom)
                                            {
                                                sp->blessingType = PaladinBlessingType::PaladinBlessingType_Wisdom;
                                                paladinBlessing_wisdom = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinBlessing_kings = true;
                                        }
                                        break;
                                    }
                                    case PaladinBlessingType::PaladinBlessingType_Might:
                                    {
                                        if (paladinBlessing_might)
                                        {
                                            if (!paladinBlessing_kings)
                                            {
                                                sp->blessingType = PaladinBlessingType::PaladinBlessingType_Kings;
                                                paladinBlessing_kings = true;
                                            }
                                            else if (!paladinBlessing_wisdom)
                                            {
                                                sp->blessingType = PaladinBlessingType::PaladinBlessingType_Wisdom;
                                                paladinBlessing_wisdom = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinBlessing_might = true;
                                        }
                                        break;
                                    }
                                    case PaladinBlessingType::PaladinBlessingType_Wisdom:
                                    {
                                        if (paladinBlessing_wisdom)
                                        {
                                            if (!paladinBlessing_kings)
                                            {
                                                sp->blessingType = PaladinBlessingType::PaladinBlessingType_Kings;
                                                paladinBlessing_kings = true;
                                            }
                                            else if (!paladinBlessing_might)
                                            {
                                                sp->blessingType = PaladinBlessingType::PaladinBlessingType_Might;
                                                paladinBlessing_might = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinBlessing_wisdom = true;
                                        }
                                        break;
                                    }
                                    default:
                                    {
                                        break;
                                    }
                                    }
                                    switch (sp->auraType)
                                    {
                                    case PaladinAuraType::PaladinAuraType_Concentration:
                                    {
                                        if (paladinAura_concentration)
                                        {
                                            if (!paladinAura_devotion)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Devotion;
                                                paladinAura_devotion = true;
                                            }
                                            else if (!paladinAura_retribution)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Retribution;
                                                paladinAura_retribution = true;
                                            }
                                            else if (!paladinAura_fire)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FireResistant;
                                                paladinAura_fire = true;
                                            }
                                            else if (!paladinAura_frost)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FrostResistant;
                                                paladinAura_frost = true;
                                            }
                                            else if (!paladinAura_shadow)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_ShadowResistant;
                                                paladinAura_shadow = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinAura_concentration = true;
                                        }
                                        break;
                                    }
                                    case PaladinAuraType::PaladinAuraType_Devotion:
                                    {
                                        if (paladinAura_devotion)
                                        {
                                            if (!paladinAura_concentration)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Concentration;
                                                paladinAura_concentration = true;
                                            }
                                            else if (!paladinAura_retribution)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Retribution;
                                                paladinAura_retribution = true;
                                            }
                                            else if (!paladinAura_fire)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FireResistant;
                                                paladinAura_fire = true;
                                            }
                                            else if (!paladinAura_frost)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FrostResistant;
                                                paladinAura_frost = true;
                                            }
                                            else if (!paladinAura_shadow)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_ShadowResistant;
                                                paladinAura_shadow = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinAura_devotion = true;
                                        }
                                        break;
                                    }
                                    case PaladinAuraType::PaladinAuraType_Retribution:
                                    {
                                        if (paladinAura_retribution)
                                        {
                                            if (!paladinAura_concentration)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Concentration;
                                                paladinAura_concentration = true;
                                            }
                                            else if (!paladinAura_devotion)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Devotion;
                                                paladinAura_devotion = true;
                                            }
                                            else if (!paladinAura_fire)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FireResistant;
                                                paladinAura_fire = true;
                                            }
                                            else if (!paladinAura_frost)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FrostResistant;
                                                paladinAura_frost = true;
                                            }
                                            else if (!paladinAura_shadow)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_ShadowResistant;
                                                paladinAura_shadow = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinAura_retribution = true;
                                        }
                                        break;
                                    }
                                    case PaladinAuraType::PaladinAuraType_FireResistant:
                                    {
                                        if (paladinAura_fire)
                                        {
                                            if (!paladinAura_concentration)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Concentration;
                                                paladinAura_concentration = true;
                                            }
                                            else if (!paladinAura_devotion)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Devotion;
                                                paladinAura_devotion = true;
                                            }
                                            else if (!paladinAura_retribution)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Retribution;
                                                paladinAura_retribution = true;
                                            }
                                            else if (!paladinAura_frost)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FrostResistant;
                                                paladinAura_frost = true;
                                            }
                                            else if (!paladinAura_shadow)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_ShadowResistant;
                                                paladinAura_shadow = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinAura_fire = true;
                                        }
                                        break;
                                    }
                                    case PaladinAuraType::PaladinAuraType_FrostResistant:
                                    {
                                        if (paladinAura_frost)
                                        {
                                            if (!paladinAura_concentration)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Concentration;
                                                paladinAura_concentration = true;
                                            }
                                            else if (!paladinAura_devotion)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Devotion;
                                                paladinAura_devotion = true;
                                            }
                                            else if (!paladinAura_retribution)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Retribution;
                                                paladinAura_retribution = true;
                                            }
                                            else if (!paladinAura_fire)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FireResistant;
                                                paladinAura_fire = true;
                                            }
                                            else if (!paladinAura_shadow)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_ShadowResistant;
                                                paladinAura_shadow = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinAura_frost = true;
                                        }
                                        break;
                                    }
                                    case PaladinAuraType::PaladinAuraType_ShadowResistant:
                                    {
                                        if (paladinAura_shadow)
                                        {
                                            if (!paladinAura_concentration)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Concentration;
                                                paladinAura_concentration = true;
                                            }
                                            else if (!paladinAura_devotion)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Devotion;
                                                paladinAura_devotion = true;
                                            }
                                            else if (!paladinAura_retribution)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_Retribution;
                                                paladinAura_retribution = true;
                                            }
                                            else if (!paladinAura_fire)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FireResistant;
                                                paladinAura_fire = true;
                                            }
                                            else if (!paladinAura_frost)
                                            {
                                                sp->auraType = PaladinAuraType::PaladinAuraType_FrostResistant;
                                                paladinAura_frost = true;
                                            }
                                        }
                                        else
                                        {
                                            paladinAura_shadow = true;
                                        }
                                        break;
                                    }
                                    default:
                                    {
                                        break;
                                    }
                                    }
                                }
                            }
                            if (member->getClass() == Classes::CLASS_MAGE)
                            {
                                if (rtiIndex >= 0 && rtiIndex < TARGETICONCOUNT)
                                {
                                    memberAI->sb->rti = rtiIndex;
                                    rtiIndex++;
                                }
                            }
                            if (member->getClass() == Classes::CLASS_HUNTER)
                            {
                                if (Script_Hunter* sh = (Script_Hunter*)memberAI->sb)
                                {
                                    if (hunterAspect_wild)
                                    {
                                        sh->aspectType = HunterAspectType::HunterAspectType_Hawk;
                                    }
                                    else
                                    {
                                        sh->aspectType = HunterAspectType::HunterAspectType_Wild;
                                        hunterAspect_wild = true;
                                    }
                                }
                            }
                        }
                    }
                }
                replyStream << "Arranged";
            }
            else
            {
                replyStream << "You are not leader";
            }
        }
        else
        {
            replyStream << "Not in a group";
        }
        sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
    }
    else if (commandName == "join")
    {
        std::ostringstream replyStream;
        Group* myGroup = pmPlayer->GetGroup();
        if (myGroup)
        {
            if (uint64 targetGUID = pmPlayer->GetTarget())
            {
                bool validTarget = false;
                for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                {
                    Player* member = groupRef->GetSource();
                    if (member)
                    {
                        if (member->GetGUID() != pmPlayer->GetGUID())
                        {
                            if (member->GetGUID() == targetGUID)
                            {
                                validTarget = true;
                                replyStream << "Joining " << member->GetName();
                                pmPlayer->TeleportTo(member->GetMapId(), member->GetPositionX(), member->GetPositionY(), member->GetPositionZ(), member->GetOrientation());
                            }
                        }
                    }
                }
                if (!validTarget)
                {
                    replyStream << "Target is no group member";
                }
            }
            else
            {
                replyStream << "You have no target";
            }
        }
        else
        {
            replyStream << "You are not in a group";
        }
        sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
    }
    else if (commandName == "leader")
    {
        if (Group* myGroup = pmPlayer->GetGroup())
        {
            if (myGroup->GetLeaderGUID() != pmPlayer->GetGUID())
            {
                bool change = true;
                if (Player* leader = ObjectAccessor::FindPlayer(myGroup->GetLeaderGUID()))
                {
                    if (WorldSession* leaderSession = leader->GetSession())
                    {
                        if (!leaderSession->isRobotSession)
                        {
                            change = false;
                        }
                    }
                }
                if (change)
                {
                    myGroup->ChangeLeader(pmPlayer->GetGUID());
                }
                else
                {
                    sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, "Leader is valid", pmPlayer);
                }
            }
            else
            {
                sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, "You are the leader", pmPlayer);
            }
        }
        else
        {
            sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, "You are not in a group", pmPlayer);
        }
    }
    else if (commandName == "robot")
    {
        if (commandVector.size() > 1)
        {
            std::string robotAction = commandVector.at(1);
            if (robotAction == "delete")
            {
                std::ostringstream replyStream;
                bool allOffline = true;
                for (std::unordered_map<std::string, RobotEntity*>::iterator reIT = robotEntityMap.begin(); reIT != robotEntityMap.end(); reIT++)
                {
                    RobotEntity* eachRE = reIT->second;
                    if (eachRE->entityState != RobotEntityState::RobotEntityState_None && eachRE->entityState != RobotEntityState::RobotEntityState_OffLine)
                    {
                        allOffline = false;
                        replyStream << "Not all robots are offline. Going offline first";
                        LogoutRobots();
                        break;
                    }
                }
                if (allOffline)
                {
                    replyStream << "All robots are offline. Ready to delete";
                    DeleteRobots();
                }
                sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
            }
            else if (robotAction == "offline")
            {
                std::ostringstream replyStream;
                replyStream << "All robots are going offline";
                LogoutRobots(true, 2, 10);
                sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
            }
            else if (robotAction == "online")
            {
                uint32 playerLevel = pmPlayer->getLevel();
                if (playerLevel < 10)
                {
                    std::ostringstream replyStream;
                    replyStream << "You level is too low";
                    sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
                }
                else
                {
                    int robotCount = 10;
                    if (commandVector.size() > 2)
                    {
                        robotCount = atoi(commandVector.at(2).c_str());
                    }
                    std::ostringstream replyTitleStream;
                    replyTitleStream << "Robot count to go online : " << robotCount;
                    sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyTitleStream.str().c_str(), pmPlayer);
                    // current count 
                    uint32 currentCount = 0;
                    QueryResult levelRobotQR = CharacterDatabase.PQuery("SELECT count(*) FROM robot where target_level = %d", playerLevel);
                    if (levelRobotQR)
                    {
                        Field* fields = levelRobotQR->Fetch();
                        currentCount = fields[0].GetUInt32();
                    }
                    if (currentCount < robotCount)
                    {
                        int toAdd = robotCount - currentCount;
                        uint32 checkNumber = 0;
                        while (toAdd > 0)
                        {
                            std::string checkAccountName = "";
                            while (true)
                            {
                                std::ostringstream accountNameStream;
                                accountNameStream << "ROBOTL" << playerLevel << "N" << checkNumber;
                                checkAccountName = accountNameStream.str();
                                std::ostringstream querySQLStream;
                                querySQLStream << "SELECT * FROM account where username ='" << checkAccountName << "'";
                                std::string querySQL = querySQLStream.str();
                                QueryResult accountNameQR = LoginDatabase.Query(querySQL.c_str());
                                if (!accountNameQR)
                                {
                                    break;
                                }
                                sLog->outBasic("Account %s exists, try again", checkAccountName.c_str());
                                checkNumber++;
                            }
                            uint32 robotID = playerLevel * 10000 + checkNumber;
                            std::ostringstream sqlStream;
                            sqlStream << "INSERT INTO robot (robot_id, account_name, character_id, target_level, robot_type) VALUES (" << robotID << ", '" << checkAccountName << "', 0, " << playerLevel << ", 0)";
                            std::string sql = sqlStream.str();
                            CharacterDatabase.DirectExecute(sql.c_str());
                            std::ostringstream replyStream;
                            replyStream << "Robot " << checkAccountName << " created";
                            sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
                            checkNumber++;
                            toAdd--;
                        }
                    }
                    QueryResult toOnLineQR = CharacterDatabase.PQuery("SELECT robot_id, account_name, character_id FROM robot where target_level = %d", playerLevel);
                    if (toOnLineQR)
                    {
                        do
                        {
                            Field* fields = toOnLineQR->Fetch();
                            uint32 robot_id = fields[0].GetUInt32();
                            std::string account_name = fields[1].GetString();
                            uint32 character_id = fields[2].GetUInt32();
                            if (robotEntityMap.find(account_name) != robotEntityMap.end())
                            {
                                if (robotEntityMap[account_name]->entityState == RobotEntityState::RobotEntityState_OffLine)
                                {
                                    robotEntityMap[account_name]->entityState = RobotEntityState::RobotEntityState_Enter;
                                    uint32 onlineWaiting = urand(5, 20);
                                    robotEntityMap[account_name]->checkDelay = onlineWaiting * TimeConstants::IN_MILLISECONDS;
                                    std::ostringstream replyStream;
                                    replyStream << "Robot " << account_name << " ready to go online";
                                    sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
                                }
                            }
                            else
                            {
                                RobotEntity* re = new RobotEntity(robot_id);
                                re->account_id = 0;
                                re->account_name = account_name;
                                re->character_id = character_id;
                                re->target_level = playerLevel;
                                re->robot_type = 0;
                                re->entityState = RobotEntityState::RobotEntityState_Enter;
                                re->checkDelay = 5 * TimeConstants::IN_MILLISECONDS;
                                robotEntityMap[account_name] = re;
                                std::ostringstream replyStream;
                                replyStream << "Robot " << account_name << " entity created, ready to go online";
                                sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, replyStream.str().c_str(), pmPlayer);
                            }
                        } while (toOnLineQR->NextRow());
                    }
                }
            }
        }
    }
}

bool RobotManager::StringEndWith(const std::string& str, const std::string& tail)
{
    return str.compare(str.size() - tail.size(), tail.size(), tail) == 0;
}

bool RobotManager::StringStartWith(const std::string& str, const std::string& head)
{
    return str.compare(0, head.size(), head) == 0;
}

std::vector<std::string> RobotManager::SplitString(std::string srcStr, std::string delimStr, bool repeatedCharIgnored)
{
    std::vector<std::string> resultStringVector;
    std::replace_if(srcStr.begin(), srcStr.end(), [&](const char& c) {if (delimStr.find(c) != std::string::npos) { return true; } else { return false; }}/*pred*/, delimStr.at(0));
    size_t pos = srcStr.find(delimStr.at(0));
    std::string addedString = "";
    while (pos != std::string::npos) {
        addedString = srcStr.substr(0, pos);
        if (!addedString.empty() || !repeatedCharIgnored) {
            resultStringVector.push_back(addedString);
        }
        srcStr.erase(srcStr.begin(), srcStr.begin() + pos + 1);
        pos = srcStr.find(delimStr.at(0));
    }
    addedString = srcStr;
    if (!addedString.empty() || !repeatedCharIgnored) {
        resultStringVector.push_back(addedString);
    }
    return resultStringVector;
}

std::string RobotManager::TrimString(std::string srcStr)
{
    std::string result = srcStr;
    if (!result.empty())
    {
        result.erase(0, result.find_first_not_of(" "));
        result.erase(result.find_last_not_of(" ") + 1);
    }

    return result;
}

void RobotManager::HandlePacket(WorldSession* pmSession, WorldPacket pmPacket)
{
    if (pmSession)
    {
        if (!pmSession->isRobotSession)
        {
            return;
        }
        if (Player* me = pmSession->GetPlayer())
        {
            if (AI_Base* robotAI = me->robotAI)
            {
                switch (pmPacket.GetOpcode())
                {
                case SMSG_SPELL_FAILURE:
                {
                    break;
                }
                case SMSG_SPELL_DELAYED:
                {
                    break;
                }
                case SMSG_GROUP_INVITE:
                {
                    Group* grp = me->GetGroupInvite();
                    if (!grp)
                    {
                        break;
                    }
                    Player* inviter = ObjectAccessor::FindPlayer(grp->GetLeaderGUID());
                    if (!inviter)
                    {
                        break;
                    }
                    WorldPacket p;
                    uint32 roles_mask = 0;
                    p << roles_mask;
                    me->GetSession()->HandleGroupAcceptOpcode(p);
                    std::ostringstream replyStream_Talent;
                    uint32 characterTalentTab = me->GetMaxTalentCountTab();
                    replyStream_Talent << "My talent category is " << characterTalentTabNameMap[me->getClass()][characterTalentTab];
                    WhisperTo(inviter, replyStream_Talent.str(), Language::LANG_UNIVERSAL, me);
                    break;
                }
                case BUY_ERR_NOT_ENOUGHT_MONEY:
                {
                    break;
                }
                case BUY_ERR_REPUTATION_REQUIRE:
                {
                    break;
                }
                case MSG_RAID_READY_CHECK:
                {
                    robotAI->readyCheckDelay = urand(2000, 6000);
                    break;
                }
                case SMSG_GROUP_SET_LEADER:
                {
                    //std::string leaderName = "";
                    //pmPacket >> leaderName;
                    //Player* newLeader = ObjectAccessor::FindPlayerByName(leaderName);
                    //if (newLeader)
                    //{
                    //    if (newLeader->GetGUID() == me->GetGUID())
                    //    {
                    //        WorldPacket data(CMSG_GROUP_SET_LEADER, 8);
                    //        data << master->GetGUID().WriteAsPacked();
                    //        me->GetSession()->HandleGroupSetLeaderOpcode(data);
                    //    }
                    //    else
                    //    {
                    //        if (!newLeader->isRobot)
                    //        {
                    //            master = newLeader;
                    //        }
                    //    }
                    //}
                    break;
                }
                case SMSG_FORCE_RUN_SPEED_CHANGE:
                {
                    break;
                }
                case SMSG_RESURRECT_REQUEST:
                {
                    if (me->isResurrectRequested())
                    {
                        me->ResurectUsingRequestData();
                        robotAI->sb->rm->ResetMovement();
                        robotAI->sb->ClearTarget();
                    }
                    break;
                }
                case SMSG_INVENTORY_CHANGE_FAILURE:
                {
                    break;
                }
                case SMSG_TRADE_STATUS:
                {
                    break;
                }
                case SMSG_LOOT_RESPONSE:
                {
                    break;
                }
                case SMSG_QUESTUPDATE_ADD_KILL:
                {
                    break;
                }
                case SMSG_ITEM_PUSH_RESULT:
                {
                    break;
                }
                case SMSG_PARTY_COMMAND_RESULT:
                {
                    break;
                }
                case SMSG_DUEL_REQUESTED:
                {
                    if (!me->duel)
                    {
                        break;
                    }
                    me->DuelComplete(DuelCompleteType::DUEL_INTERRUPTED);
                    WhisperTo(me->duel->opponent, "Not interested", Language::LANG_UNIVERSAL, me);
                    break;
                }
                default:
                {
                    break;
                }
                }
            }
        }
    }
}

void RobotManager::WhisperTo(Player* pmTarget, std::string pmContent, Language pmLanguage, Player* pmSender)
{
    if (pmSender && pmTarget)
    {
        pmSender->Whisper(pmContent, pmLanguage, pmTarget->GetGUID());
    }
}

void RobotManager::HandleChatCommand(Player* pmSender, std::string pmCMD, Player* pmReceiver)
{
    if (!pmSender)
    {
        return;
    }
    std::vector<std::string> commandVector = SplitString(pmCMD, " ", true);
    std::string commandName = commandVector.at(0);
    if (pmReceiver)
    {
        if (WorldSession* receiverSession = pmReceiver->GetSession())
        {
            if (receiverSession->isRobotSession)
            {
                if (AI_Base* receiverAI = pmReceiver->robotAI)
                {
#pragma region command handling
                    if (commandName == "role")
                    {
                        std::ostringstream replyStream;
                        if (commandVector.size() > 1)
                        {
                            std::string newRole = commandVector.at(1);
                            receiverAI->SetGroupRole(newRole);
                        }
                        replyStream << "My group role is ";
                        replyStream << receiverAI->GetGroupRoleName();
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "engage")
                    {
                        receiverAI->staying = false;
                        if (Unit* target = pmSender->GetSelectedUnit())
                        {
                            if (receiverAI->Engage(target))
                            {
                                if (Group* myGroup = pmReceiver->GetGroup())
                                {
                                    if (myGroup->GetTargetIconByOG(target->GetGUID()) == -1)
                                    {
                                        myGroup->SetTargetIcon(7, pmReceiver->GetGUID(), target->GetGUID());
                                    }
                                }
                                receiverAI->engageTarget = target;
                                int engageDelay = 5000;
                                if (commandVector.size() > 1)
                                {
                                    std::string checkStr = commandVector.at(1);
                                    engageDelay = atoi(checkStr.c_str());
                                }
                                receiverAI->engageDelay = engageDelay;
                                std::ostringstream replyStream;
                                replyStream << "Try to engage " << target->GetName();
                                WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                            }
                        }
                    }
                    else if (commandName == "tank")
                    {
                        if (Unit* target = pmSender->GetSelectedUnit())
                        {
                            if (receiverAI->groupRole == GroupRole::GroupRole_Tank)
                            {
                                if (receiverAI->Tank(target))
                                {
                                    if (Group* myGroup = pmReceiver->GetGroup())
                                    {
                                        if (myGroup->GetTargetIconByOG(target->GetGUID()) == -1)
                                        {
                                            myGroup->SetTargetIcon(7, pmReceiver->GetGUID(), target->GetGUID());
                                        }
                                    }
                                    receiverAI->staying = false;
                                    receiverAI->engageTarget = target;
                                    int engageDelay = 5000;
                                    if (commandVector.size() > 1)
                                    {
                                        std::string checkStr = commandVector.at(1);
                                        engageDelay = atoi(checkStr.c_str());
                                    }
                                    receiverAI->engageDelay = engageDelay;
                                    std::ostringstream replyStream;
                                    replyStream << "Try to tank " << target->GetName();
                                    WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                                }
                            }
                            else
                            {
                                receiverAI->staying = false;
                            }
                        }
                    }
                    else if (commandName == "revive")
                    {
                        if (pmReceiver->IsAlive())
                        {
                            std::unordered_map<uint32, Player*> deadMap;
                            std::unordered_map<uint32, Player*> targetingMap;
                            if (Group* myGroup = pmReceiver->GetGroup())
                            {
                                for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                                {
                                    if (Player* member = groupRef->GetSource())
                                    {
                                        if (!member->IsAlive())
                                        {
                                            deadMap[member->GetGUIDLow()] = member;
                                        }
                                        else
                                        {
                                            if (member->IsNonMeleeSpellCast(false))
                                            {
                                                if (Player* targetPlayer = member->GetSelectedPlayer())
                                                {
                                                    targetingMap[targetPlayer->GetGUIDLow()] = targetPlayer;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if (deadMap.size() > 0)
                            {
                                for (std::unordered_map<uint32, Player*>::iterator dIT = deadMap.begin(); dIT != deadMap.end(); dIT++)
                                {
                                    if (Player* eachDead = dIT->second)
                                    {
                                        if (targetingMap.find(eachDead->GetGUIDLow()) == targetingMap.end())
                                        {
                                            std::ostringstream reviveSpellName;
                                            if (pmReceiver->getClass() == Classes::CLASS_DRUID || pmReceiver->getClass() == Classes::CLASS_PRIEST || pmReceiver->getClass() == Classes::CLASS_PALADIN || pmReceiver->getClass() == Classes::CLASS_SHAMAN)
                                            {
                                                if (pmReceiver->getClass() == Classes::CLASS_PRIEST)
                                                {
                                                    reviveSpellName << "Resurrection";
                                                }
                                                else if (pmReceiver->getClass() == Classes::CLASS_PALADIN)
                                                {
                                                    reviveSpellName << "Redemption";
                                                }
                                                else if (pmReceiver->getClass() == Classes::CLASS_SHAMAN)
                                                {
                                                    reviveSpellName << "Ancestral Spirit";
                                                }
                                                if (receiverAI->sb->CastSpell(eachDead, reviveSpellName.str(), RANGED_MAX_DISTANCE, false, false, true))
                                                {
                                                    std::ostringstream replyStream;
                                                    replyStream << "Reviving " << eachDead->GetName();
                                                    WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                                                }
                                                else
                                                {
                                                    WhisperTo(pmSender, "Can not do reviving", Language::LANG_UNIVERSAL, pmReceiver);
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else if (commandName == "follow")
                    {
                        std::ostringstream replyStream;
                        bool takeAction = true;
                        if (commandVector.size() > 1)
                        {
                            std::string cmdDistanceStr = commandVector.at(1);
                            float cmdDistance = atof(cmdDistanceStr.c_str());
                            if (cmdDistance == 0.0f)
                            {
                                receiverAI->following = false;
                                replyStream << "Stop following";
                                takeAction = false;
                            }
                            else if (cmdDistance >= FOLLOW_MIN_DISTANCE && cmdDistance <= FOLLOW_MAX_DISTANCE)
                            {
                                receiverAI->followDistance = cmdDistance;
                                replyStream << "Distance updated";
                            }
                            else
                            {
                                replyStream << "Distance is not valid";
                                takeAction = false;
                            }
                        }
                        if (takeAction)
                        {
                            receiverAI->eatDelay = 0;
                            receiverAI->drinkDelay = 0;
                            receiverAI->staying = false;
                            receiverAI->holding = false;
                            receiverAI->following = true;
                            if (receiverAI->Follow())
                            {
                                replyStream << "Following " << receiverAI->followDistance;
                            }
                            else
                            {
                                replyStream << "can not follow";
                            }
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "stay")
                    {
                        std::string targetGroupRole = "";
                        if (commandVector.size() > 1)
                        {
                            targetGroupRole = commandVector.at(1);
                        }
                        if (receiverAI->Stay(targetGroupRole))
                        {
                            WhisperTo(pmSender, "Staying", Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
                    else if (commandName == "hold")
                    {
                        std::string targetGroupRole = "";
                        if (commandVector.size() > 1)
                        {
                            targetGroupRole = commandVector.at(1);
                        }
                        if (receiverAI->Hold(targetGroupRole))
                        {
                            WhisperTo(pmReceiver, "Holding", Language::LANG_UNIVERSAL, pmSender);
                        }
                    }
                    else if (commandName == "rest")
                    {
                        std::ostringstream replyStream;
                        if (receiverAI->sb->Eat())
                        {
                            receiverAI->eatDelay = DEFAULT_REST_DELAY;
                            receiverAI->drinkDelay = 1000;
                            replyStream << "Resting";
                        }
                        else
                        {
                            replyStream << "Can not rest";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "who")
                    {
                        int whoTab = pmReceiver->GetMaxTalentCountTab();
                        WhisperTo(pmSender, characterTalentTabNameMap[pmReceiver->getClass()][whoTab], Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "assemble")
                    {
                        std::ostringstream replyStream;
                        if (receiverAI->moveDelay > 0 || receiverAI->teleportAssembleDelay > 0)
                        {
                            replyStream << "I am on the way";
                        }
                        else
                        {
                            if (pmReceiver->IsAlive())
                            {
                                if (pmReceiver->GetDistance(pmSender) < ATTACK_RANGE_LIMIT)
                                {
                                    pmReceiver->GetMotionMaster()->Clear();
                                    pmReceiver->StopMoving();
                                    receiverAI->eatDelay = 0;
                                    receiverAI->drinkDelay = 0;
                                    receiverAI->sb->rm->MovePosition(pmSender->GetPosition());
                                    replyStream << "We are close, I will move to you";
                                    receiverAI->moveDelay = 3000;
                                }
                                else
                                {
                                    receiverAI->teleportAssembleDelay = urand(30 * TimeConstants::IN_MILLISECONDS, 1 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS);
                                    replyStream << "I will join you in " << receiverAI->teleportAssembleDelay << " ms";
                                }
                            }
                            else
                            {
                                receiverAI->teleportAssembleDelay = urand(1 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS, 2 * TimeConstants::MINUTE * TimeConstants::IN_MILLISECONDS);
                                replyStream << "I will revive and join you in " << receiverAI->teleportAssembleDelay << " ms";
                            }
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "cast")
                    {
                        std::ostringstream replyStream;
                        if (pmReceiver->IsAlive())
                        {
                            if (commandVector.size() > 1)
                            {
                                std::ostringstream targetStream;
                                uint8 arrayCount = 0;
                                for (std::vector<std::string>::iterator it = commandVector.begin(); it != commandVector.end(); it++)
                                {
                                    if (arrayCount > 0)
                                    {
                                        targetStream << (*it) << " ";
                                    }
                                    arrayCount++;
                                }
                                std::string spellName = TrimString(targetStream.str());
                                Unit* senderTarget = pmSender->GetSelectedUnit();
                                if (!senderTarget)
                                {
                                    senderTarget = pmReceiver;
                                }
                                if (receiverAI->sb->CastSpell(senderTarget, spellName, DEFAULT_VISIBILITY_DISTANCE))
                                {
                                    replyStream << "Cast spell " << spellName << " on " << senderTarget->GetName();
                                }
                                else
                                {
                                    replyStream << "Can not cast spell " << spellName << " on " << senderTarget->GetName();
                                }
                            }
                        }
                        else
                        {
                            replyStream << "I am dead";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "cancel")
                    {
                        std::ostringstream replyStream;
                        if (pmReceiver->IsAlive())
                        {
                            if (commandVector.size() > 1)
                            {
                                std::ostringstream targetStream;
                                uint8 arrayCount = 0;
                                for (std::vector<std::string>::iterator it = commandVector.begin(); it != commandVector.end(); it++)
                                {
                                    if (arrayCount > 0)
                                    {
                                        targetStream << (*it) << " ";
                                    }
                                    arrayCount++;
                                }
                                std::string spellName = TrimString(targetStream.str());
                                if (receiverAI->sb->CancelAura(spellName))
                                {
                                    replyStream << "Aura canceled " << spellName;
                                }
                                else
                                {
                                    replyStream << "Can not cancel aura " << spellName;
                                }
                            }
                        }
                        else
                        {
                            replyStream << "I am dead";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "use")
                    {
                        std::ostringstream replyStream;
                        if (pmReceiver->IsAlive())
                        {
                            if (commandVector.size() > 1)
                            {
                                std::string useType = commandVector.at(1);
                                if (useType == "go")
                                {
                                    if (commandVector.size() > 2)
                                    {
                                        std::ostringstream goNameStream;
                                        uint32 checkPos = 2;
                                        while (checkPos < commandVector.size())
                                        {
                                            goNameStream << commandVector.at(checkPos) << " ";
                                            checkPos++;
                                        }
                                        std::string goName = TrimString(goNameStream.str());
                                        bool validToUse = false;
                                        std::list<GameObject*> nearGOList;
                                        pmReceiver->GetGameObjectListWithEntryInGrid(nearGOList, 0, MELEE_MAX_DISTANCE);
                                        for (std::list<GameObject*>::iterator it = nearGOList.begin(); it != nearGOList.end(); it++)
                                        {
                                            if ((*it)->GetName() == goName)
                                            {
                                                pmReceiver->SetFacingToObject((*it));
                                                pmReceiver->StopMoving();
                                                pmReceiver->GetMotionMaster()->Clear();
                                                (*it)->Use(pmReceiver);
                                                replyStream << "Use game object : " << goName;
                                                validToUse = true;
                                                break;
                                            }
                                        }
                                        if (!validToUse)
                                        {
                                            replyStream << "No go with name " << goName << " nearby";
                                        }
                                    }
                                    else
                                    {
                                        replyStream << "No go name";
                                    }
                                }
                                else if (useType == "item")
                                {

                                }
                                else
                                {
                                    replyStream << "Unknown type";
                                }
                            }
                            else
                            {
                                replyStream << "Use what?";
                            }
                        }
                        else
                        {
                            replyStream << "I am dead";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "stop")
                    {
                        std::ostringstream replyStream;
                        if (pmReceiver->IsAlive())
                        {
                            pmReceiver->StopMoving();
                            pmReceiver->InterruptSpell(CurrentSpellTypes::CURRENT_AUTOREPEAT_SPELL);
                            pmReceiver->InterruptSpell(CurrentSpellTypes::CURRENT_CHANNELED_SPELL);
                            pmReceiver->InterruptSpell(CurrentSpellTypes::CURRENT_GENERIC_SPELL);
                            pmReceiver->InterruptSpell(CurrentSpellTypes::CURRENT_MELEE_SPELL);
                            replyStream << "Stopped";
                        }
                        else
                        {
                            replyStream << "I am dead";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "delay")
                    {
                        std::ostringstream replyStream;
                        if (commandVector.size() > 1)
                        {
                            int delayMS = std::stoi(commandVector.at(1));
                            receiverAI->dpsDelay = delayMS;
                            replyStream << "DPS delay set to : " << delayMS;
                        }
                        else
                        {
                            replyStream << "DPS delay is : " << receiverAI->dpsDelay;
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "threat")
                    {
                        std::ostringstream replyStream;
                        if (pmReceiver->IsAlive())
                        {
                            replyStream << "Threat list : ";
                            ThreatContainer::StorageType threatlist = pmReceiver->getThreatManager().getThreatList();
                            for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
                            {
                                if (HostileReference* eachReference = *itr)
                                {
                                    if (ThreatManager* eachTM = eachReference->GetSource())
                                    {
                                        if (Unit* eachOwner = eachTM->GetOwner())
                                        {
                                            replyStream << eachOwner->GetName() << ", ";
                                        }
                                    }
                                }
                            }
                        }
                        else
                        {
                            replyStream << "I am dead";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "cure")
                    {
                        std::ostringstream replyStream;
                        if (commandVector.size() > 1)
                        {
                            std::string cureCMD = commandVector.at(1);
                            if (cureCMD == "on")
                            {
                                receiverAI->cure = true;
                            }
                            else if (cureCMD == "off")
                            {
                                receiverAI->cure = false;
                            }
                            else
                            {
                                replyStream << "Unknown state";
                            }
                        }
                        if (receiverAI->cure)
                        {
                            replyStream << "Auto cure is on";
                        }
                        else
                        {
                            replyStream << "Auto cure is off";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "aoe")
                    {
                        std::ostringstream replyStream;
                        if (commandVector.size() > 1)
                        {
                            std::string on = commandVector.at(1);
                            if (on == "on")
                            {
                                receiverAI->aoe = true;
                            }
                            else if (on == "off")
                            {
                                receiverAI->aoe = false;
                            }
                        }
                        if (receiverAI->aoe)
                        {
                            replyStream << "AOE is on";
                        }
                        else
                        {
                            replyStream << "AOE is off";
                        }
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "emote")
                    {
                        if (pmReceiver->IsAlive())
                        {
                            if (commandVector.size() > 1)
                            {
                                int emoteCMD = std::stoi(commandVector.at(1));
                                pmReceiver->HandleEmoteCommand((Emote)emoteCMD);
                            }
                            else
                            {
                                pmReceiver->AttackStop();
                                pmReceiver->CombatStop();
                            }
                        }
                        else
                        {
                            WhisperTo(pmSender, "I am dead", Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
                    else if (commandName == "pa")
                    {
                        if (pmReceiver->getClass() == Classes::CLASS_PALADIN)
                        {
                            std::ostringstream replyStream;
                            if (Script_Paladin* sp = (Script_Paladin*)receiverAI->sb)
                            {
                                if (commandVector.size() > 1)
                                {
                                    std::string auratypeName = commandVector.at(1);
                                    if (auratypeName == "concentration")
                                    {
                                        sp->auraType = PaladinAuraType::PaladinAuraType_Concentration;
                                    }
                                    else if (auratypeName == "devotion")
                                    {
                                        sp->auraType = PaladinAuraType::PaladinAuraType_Devotion;
                                    }
                                    else if (auratypeName == "retribution")
                                    {
                                        sp->auraType = PaladinAuraType::PaladinAuraType_Retribution;
                                    }
                                    else if (auratypeName == "fire")
                                    {
                                        sp->auraType = PaladinAuraType::PaladinAuraType_FireResistant;
                                    }
                                    else if (auratypeName == "frost")
                                    {
                                        sp->auraType = PaladinAuraType::PaladinAuraType_FrostResistant;
                                    }
                                    else if (auratypeName == "shadow")
                                    {
                                        sp->auraType = PaladinAuraType::PaladinAuraType_ShadowResistant;
                                    }
                                    else
                                    {
                                        replyStream << "Unknown type";
                                    }
                                }
                                switch (sp->auraType)
                                {
                                case PaladinAuraType::PaladinAuraType_Concentration:
                                {
                                    replyStream << "concentration";
                                    break;
                                }
                                case PaladinAuraType::PaladinAuraType_Devotion:
                                {
                                    replyStream << "devotion";
                                    break;
                                }
                                case PaladinAuraType::PaladinAuraType_Retribution:
                                {
                                    replyStream << "retribution";
                                    break;
                                }
                                case PaladinAuraType::PaladinAuraType_FireResistant:
                                {
                                    replyStream << "fire";
                                    break;
                                }
                                case PaladinAuraType::PaladinAuraType_FrostResistant:
                                {
                                    replyStream << "frost";
                                    break;
                                }
                                case PaladinAuraType::PaladinAuraType_ShadowResistant:
                                {
                                    replyStream << "shadow";
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                                }
                            }
                            WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
                    else if (commandName == "pj")
                    {
                        if (pmReceiver->getClass() == Classes::CLASS_PALADIN)
                        {
                            std::ostringstream replyStream;
                            if (Script_Paladin* sp = (Script_Paladin*)receiverAI->sb)
                            {
                                if (commandVector.size() > 1)
                                {
                                    std::string auratypeName = commandVector.at(1);
                                    if (auratypeName == "justice")
                                    {
                                        sp->judgementType = PaladinJudgementType::PaladinJudgementType_Justice;
                                    }
                                    else if (auratypeName == "wisdom")
                                    {
                                        sp->judgementType = PaladinJudgementType::PaladinJudgementType_Wisdom;
                                    }
                                    else if (auratypeName == "light")
                                    {
                                        sp->judgementType = PaladinJudgementType::PaladinJudgementType_Light;
                                    }
                                    else
                                    {
                                        replyStream << "Unknown type";
                                    }
                                }
                                switch (sp->judgementType)
                                {
                                case PaladinJudgementType::PaladinJudgementType_Justice:
                                {
                                    replyStream << "justice";
                                    break;
                                }
                                case PaladinJudgementType::PaladinJudgementType_Wisdom:
                                {
                                    replyStream << "wisdom";
                                    break;
                                }
                                case PaladinJudgementType::PaladinJudgementType_Light:
                                {
                                    replyStream << "light";
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                                }
                            }
                            WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
                    else if (commandName == "pb")
                    {
                        if (pmReceiver->getClass() == Classes::CLASS_PALADIN)
                        {
                            std::ostringstream replyStream;
                            if (Script_Paladin* sp = (Script_Paladin*)receiverAI->sb)
                            {
                                if (commandVector.size() > 1)
                                {
                                    std::string blessingTypeName = commandVector.at(1);
                                    if (blessingTypeName == "kings")
                                    {
                                        sp->blessingType = PaladinBlessingType::PaladinBlessingType_Kings;
                                    }
                                    else if (blessingTypeName == "might")
                                    {
                                        sp->blessingType = PaladinBlessingType::PaladinBlessingType_Might;
                                    }
                                    else if (blessingTypeName == "wisdom")
                                    {
                                        sp->blessingType = PaladinBlessingType::PaladinBlessingType_Wisdom;
                                    }
                                    else
                                    {
                                        replyStream << "Unknown type";
                                    }
                                }
                                switch (sp->blessingType)
                                {
                                case PaladinBlessingType::PaladinBlessingType_Kings:
                                {
                                    replyStream << "kings";
                                    break;
                                }
                                case PaladinBlessingType::PaladinBlessingType_Might:
                                {
                                    replyStream << "might";
                                    break;
                                }
                                case PaladinBlessingType::PaladinBlessingType_Wisdom:
                                {
                                    replyStream << "wisdom";
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                                }
                            }
                            WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
                    else if (commandName == "ps")
                    {
                        if (pmReceiver->getClass() == Classes::CLASS_PALADIN)
                        {
                            std::ostringstream replyStream;
                            if (Script_Paladin* sp = (Script_Paladin*)receiverAI->sb)
                            {
                                if (commandVector.size() > 1)
                                {
                                    std::string sealTypeName = commandVector.at(1);
                                    if (sealTypeName == "righteousness")
                                    {
                                        sp->sealType = PaladinSealType::PaladinSealType_Righteousness;
                                    }
                                    else if (sealTypeName == "justice")
                                    {
                                        sp->sealType = PaladinSealType::PaladinSealType_Justice;
                                    }
                                    else
                                    {
                                        replyStream << "Unknown type";
                                    }
                                }
                                switch (sp->sealType)
                                {
                                case PaladinSealType::PaladinSealType_Righteousness:
                                {
                                    replyStream << "righteousness";
                                    break;
                                }
                                case PaladinSealType::PaladinSealType_Justice:
                                {
                                    replyStream << "justice";
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                                }
                            }
                            WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
                    else if (commandName == "ha")
                    {
                        if (pmReceiver->getClass() == Classes::CLASS_HUNTER)
                        {
                            std::ostringstream replyStream;
                            if (Script_Hunter* sh = (Script_Hunter*)receiverAI->sb)
                            {
                                if (commandVector.size() > 1)
                                {
                                    std::string aspectName = commandVector.at(1);
                                    if (aspectName == "hawk")
                                    {
                                        sh->aspectType = HunterAspectType::HunterAspectType_Hawk;
                                    }
                                    else if (aspectName == "monkey")
                                    {
                                        sh->aspectType = HunterAspectType::HunterAspectType_Monkey;
                                    }
                                    else if (aspectName == "wild")
                                    {
                                        sh->aspectType = HunterAspectType::HunterAspectType_Wild;
                                    }
                                    else if (aspectName == "pack")
                                    {
                                        sh->aspectType = HunterAspectType::HunterAspectType_Pack;
                                    }
                                    else
                                    {
                                        replyStream << "Unknown type";
                                    }
                                }
                                switch (sh->aspectType)
                                {
                                case HunterAspectType::HunterAspectType_Hawk:
                                {
                                    replyStream << "hawk";
                                    break;
                                }
                                case HunterAspectType::HunterAspectType_Monkey:
                                {
                                    replyStream << "monkey";
                                    break;
                                }
                                case HunterAspectType::HunterAspectType_Wild:
                                {
                                    replyStream << "wild";
                                    break;
                                }
                                case HunterAspectType::HunterAspectType_Pack:
                                {
                                    replyStream << "pack";
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                                }
                            }
                            WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
                    else if (commandName == "equip")
                    {
                        if (commandVector.size() > 1)
                        {
                            std::string equipType = commandVector.at(1);
                            if (equipType == "molten core")
                            {
                                if (pmReceiver->getClass() == Classes::CLASS_DRUID)
                                {
                                    for (uint32 checkEquipSlot = EquipmentSlots::EQUIPMENT_SLOT_HEAD; checkEquipSlot < EquipmentSlots::EQUIPMENT_SLOT_TABARD; checkEquipSlot++)
                                    {
                                        if (Item* currentEquip = pmReceiver->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
                                        {
                                            pmReceiver->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
                                        }
                                    }
                                    EquipNewItem(pmReceiver, 16983, EquipmentSlots::EQUIPMENT_SLOT_HEAD);
                                    EquipNewItem(pmReceiver, 19139, EquipmentSlots::EQUIPMENT_SLOT_SHOULDERS);
                                    EquipNewItem(pmReceiver, 16833, EquipmentSlots::EQUIPMENT_SLOT_CHEST);
                                    EquipNewItem(pmReceiver, 11764, EquipmentSlots::EQUIPMENT_SLOT_WRISTS);
                                    EquipNewItem(pmReceiver, 16831, EquipmentSlots::EQUIPMENT_SLOT_HANDS);
                                    EquipNewItem(pmReceiver, 19149, EquipmentSlots::EQUIPMENT_SLOT_WAIST);
                                    EquipNewItem(pmReceiver, 15054, EquipmentSlots::EQUIPMENT_SLOT_LEGS);
                                    EquipNewItem(pmReceiver, 16982, EquipmentSlots::EQUIPMENT_SLOT_FEET);
                                    EquipNewItem(pmReceiver, 18803, EquipmentSlots::EQUIPMENT_SLOT_MAINHAND);
                                    EquipNewItem(pmReceiver, 2802, EquipmentSlots::EQUIPMENT_SLOT_TRINKET1);
                                    EquipNewItem(pmReceiver, 18406, EquipmentSlots::EQUIPMENT_SLOT_TRINKET2);
                                    EquipNewItem(pmReceiver, 18398, EquipmentSlots::EQUIPMENT_SLOT_FINGER1);
                                    EquipNewItem(pmReceiver, 18813, EquipmentSlots::EQUIPMENT_SLOT_FINGER2);
                                    EquipNewItem(pmReceiver, 18811, EquipmentSlots::EQUIPMENT_SLOT_BACK);
                                    EquipNewItem(pmReceiver, 16309, EquipmentSlots::EQUIPMENT_SLOT_NECK);
                                    std::ostringstream replyStream;
                                    replyStream << "Equip all fire resistance gears.";
                                    WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                                }
                            }
                            else if (equipType == "reset")
                            {
                                InitializeEquipments(pmReceiver, true);
                                std::ostringstream replyStream;
                                replyStream << "All my equipments are reset.";
                                WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                            }
                        }
                    }
                    else if (commandName == "rti")
                    {
                        int targetIcon = -1;
                        if (commandVector.size() > 1)
                        {
                            std::string iconIndex = commandVector.at(1);
                            targetIcon = atoi(iconIndex.c_str());
                        }
                        if (targetIcon >= 0 && targetIcon < TARGETICONCOUNT)
                        {
                            receiverAI->sb->rti = targetIcon;
                        }
                        std::ostringstream replyStream;
                        replyStream << "RTI is " << receiverAI->sb->rti;
                        WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                    }
                    else if (commandName == "assist")
                    {
                        if (receiverAI->sb->Assist())
                        {
                            receiverAI->assistDelay = 5000;
                            std::ostringstream replyStream;
                            replyStream << "Try to pin down my RTI : " << receiverAI->sb->rti;
                            WhisperTo(pmSender, replyStream.str(), Language::LANG_UNIVERSAL, pmReceiver);
                        }
                    }
#pragma endregion
                }
            }
        }
    }
    else
    {
        if (Group* myGroup = pmSender->GetGroup())
        {
            for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
            {
                if (Player* member = groupRef->GetSource())
                {
                    HandleChatCommand(pmSender, pmCMD, member);
                }
            }
        }
    }
}

void RobotManager::LearnPlayerTalents(Player* pmTargetPlayer)
{
    if (!pmTargetPlayer)
    {
        return;
    }
    int freePoints = pmTargetPlayer->GetFreeTalentPoints();
    if (freePoints > 0)
    {
        pmTargetPlayer->resetTalents(true);
        uint8 specialty = urand(0, 2);
        // EJ fixed specialty
        if (pmTargetPlayer->getClass() == Classes::CLASS_MAGE)
        {
            specialty = 2;
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_ROGUE)
        {
            specialty = 1;
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_WARRIOR)
        {
            specialty = 2;
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_SHAMAN)
        {
            uint8 healer = urand(0, 4);
            if (healer == 0)
            {
                specialty = 2;
            }
            else
            {
                specialty = 1;
            }
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_PRIEST)
        {
            specialty = 1;
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_WARLOCK)
        {
            specialty = 2;
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_PALADIN)
        {
            specialty = urand(0, 100);
            if (specialty < 35)
            {
                specialty = 0;
            }
            else
            {
                specialty = 2;
            }
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_DRUID)
        {
            specialty = 1;
        }
        else if (pmTargetPlayer->getClass() == Classes::CLASS_HUNTER)
        {
            specialty = 1;
        }
        uint32 classMask = pmTargetPlayer->getClassMask();
        std::map<uint32, std::vector<TalentEntry const*> > talentsMap;
        for (uint32 i = 0; i < sTalentStore.GetNumRows(); ++i)
        {
            TalentEntry const* talentInfo = sTalentStore.LookupEntry(i);
            if (!talentInfo)
                continue;

            if (TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab))
            {
                if (talentTabInfo->tabpage != specialty)
                {
                    continue;
                }
                if ((classMask & talentTabInfo->ClassMask) == 0)
                {
                    continue;
                }
                talentsMap[talentInfo->Row].push_back(talentInfo);
            }
        }
        for (std::map<uint32, std::vector<TalentEntry const*> >::iterator i = talentsMap.begin(); i != talentsMap.end(); ++i)
        {
            std::vector<TalentEntry const*> eachRowTalents = i->second;
            if (eachRowTalents.empty())
            {
                sLog->outError("%s: No spells for talent row %d", pmTargetPlayer->GetName().c_str(), i->first);
                continue;
            }
            for (std::vector<TalentEntry const*>::iterator it = eachRowTalents.begin(); it != eachRowTalents.end(); it++)
            {
                freePoints = pmTargetPlayer->GetFreeTalentPoints();
                if (freePoints > 0)
                {
                    if (const TalentEntry* eachTE = *it)
                    {
                        uint8 maxRank = 4;
                        if (eachTE->RankID[4] > 0)
                        {
                            maxRank = 4;
                        }
                        else if (eachTE->RankID[3] > 0)
                        {
                            maxRank = 3;
                        }
                        else if (eachTE->RankID[2] > 0)
                        {
                            maxRank = 2;
                        }
                        else if (eachTE->RankID[1] > 0)
                        {
                            maxRank = 1;
                        }
                        else
                        {
                            maxRank = 0;
                        }
                        if (maxRank > freePoints - 1)
                        {
                            maxRank = freePoints - 1;
                        }
                        pmTargetPlayer->LearnTalent(eachTE->TalentID, maxRank);
                    }
                }
                else
                {
                    break;
                }
            }
        }
        pmTargetPlayer->SaveToDB(false, false);
    }
}

bool RobotManager::InitializeCharacter(Player* pmTargetPlayer, uint32 pmTargetLevel)
{
    if (!pmTargetPlayer)
    {
        return false;
    }
    pmTargetPlayer->ClearInCombat();
    bool isNew = false;
    if (pmTargetPlayer->getLevel() != pmTargetLevel)
    {
        isNew = true;
        pmTargetPlayer->GiveLevel(pmTargetLevel);
        pmTargetPlayer->learnDefaultSpells();
        switch (pmTargetPlayer->getClass())
        {
        case Classes::CLASS_WARRIOR:
        {
            pmTargetPlayer->learnSpell(201);
            //pmTargetPlayer->SetSkill(43, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // sword 
            break;
        }
        case Classes::CLASS_HUNTER:
        {
            pmTargetPlayer->learnSpell(5011);
            pmTargetPlayer->learnSpell(266);
            pmTargetPlayer->learnSpell(264);
            //pmTargetPlayer->SetSkill(45, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // bow 
            //pmTargetPlayer->SetSkill(46, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // gun 
            //pmTargetPlayer->SetSkill(226, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // crossbow 
            break;
        }
        case Classes::CLASS_SHAMAN:
        {
            pmTargetPlayer->learnSpell(198);
            pmTargetPlayer->learnSpell(227);
            //pmTargetPlayer->SetSkill(136, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // stave 
            break;
        }
        case Classes::CLASS_PALADIN:
        {
            pmTargetPlayer->learnSpell(198);
            pmTargetPlayer->learnSpell(199);
            pmTargetPlayer->learnSpell(55);
            pmTargetPlayer->learnSpell(201);
            //pmTargetPlayer->SetSkill(160, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // mace 2 
            break;
        }
        case Classes::CLASS_WARLOCK:
        {
            pmTargetPlayer->learnSpell(227);
            //pmTargetPlayer->SetSkill(136, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // stave 
            break;
        }
        case Classes::CLASS_PRIEST:
        {
            pmTargetPlayer->learnSpell(227);
            //pmTargetPlayer->SetSkill(136, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // stave 
            break;
        }
        case Classes::CLASS_ROGUE:
        {
            break;
        }
        case Classes::CLASS_MAGE:
        {
            pmTargetPlayer->learnSpell(227);
            //pmTargetPlayer->SetSkill(136, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // stave 
            break;
        }
        case Classes::CLASS_DRUID:
        {
            pmTargetPlayer->learnSpell(227);
            //pmTargetPlayer->SetSkill(136, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // stave 
            //pmTargetPlayer->SetSkill(160, pmTargetPlayer->getLevel() * 5, pmTargetPlayer->getLevel() * 5); // mace 2 
            break;
        }
        default:
        {
            break;
        }
        }
        for (uint8 i = EQUIPMENT_SLOT_START; i < INVENTORY_SLOT_ITEM_END; i++)
        {
            if (Item* pItem = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, i, true);
            }
        }
    }
    LearnPlayerTalents(pmTargetPlayer);
    for (std::unordered_set<uint32>::iterator questIT = spellRewardClassQuestIDSet.begin(); questIT != spellRewardClassQuestIDSet.end(); questIT++)
    {
        const Quest* eachQuest = sObjectMgr->GetQuestTemplate((*questIT));
        if (pmTargetPlayer->SatisfyQuestLevel(eachQuest, false) && pmTargetPlayer->SatisfyQuestClass(eachQuest, false) && pmTargetPlayer->SatisfyQuestRace(eachQuest, false))
        {
            const SpellInfo* pSCast = sSpellMgr->GetSpellInfo(eachQuest->GetRewSpellCast());
            if (pSCast)
            {
                std::set<uint32> spellToLearnIDSet;
                spellToLearnIDSet.clear();
                for (size_t effectCount = 0; effectCount < MAX_SPELL_EFFECTS; effectCount++)
                {
                    if (pSCast->Effects[effectCount].Effect == SpellEffects::SPELL_EFFECT_LEARN_SPELL)
                    {
                        spellToLearnIDSet.insert(pSCast->Effects[effectCount].TriggerSpell);
                    }
                }
                if (spellToLearnIDSet.size() == 0)
                {
                    spellToLearnIDSet.insert(pSCast->Id);
                }
                for (std::set<uint32>::iterator toLearnIT = spellToLearnIDSet.begin(); toLearnIT != spellToLearnIDSet.end(); toLearnIT++)
                {
                    uint32 spellID = *toLearnIT;
                    pmTargetPlayer->learnSpell(spellID);
                }
            }
            const SpellInfo* pS = sSpellMgr->GetSpellInfo(eachQuest->GetRewSpell());
            if (pS)
            {
                std::set<uint32> spellToLearnIDSet;
                spellToLearnIDSet.clear();
                for (size_t effectCount = 0; effectCount < MAX_SPELL_EFFECTS; effectCount++)
                {
                    if (pS->Effects[effectCount].Effect == SpellEffects::SPELL_EFFECT_LEARN_SPELL)
                    {
                        spellToLearnIDSet.insert(pS->Effects[effectCount].TriggerSpell);
                    }
                }
                if (spellToLearnIDSet.size() == 0)
                {
                    spellToLearnIDSet.insert(pS->Id);
                }
                for (std::set<uint32>::iterator toLearnIT = spellToLearnIDSet.begin(); toLearnIT != spellToLearnIDSet.end(); toLearnIT++)
                {
                    uint32 spellID = *toLearnIT;
                    pmTargetPlayer->learnSpell(spellID);
                }
            }
        }
    }
    const std::unordered_map<uint32, CreatureTemplate>* creatureTemplateMap = sObjectMgr->GetCreatureTemplates();
    for (CreatureTemplateContainer::const_iterator itr = creatureTemplateMap->begin(); itr != creatureTemplateMap->end(); ++itr)
    {
        CreatureTemplate cInfo = itr->second;
        if (cInfo.trainer_type == TrainerType::TRAINER_TYPE_CLASS)
        {
            if (cInfo.trainer_class == pmTargetPlayer->getClass())
            {
                const TrainerSpellData* tsd = sObjectMgr->GetNpcTrainerSpells(cInfo.Entry);
                std::unordered_map<uint32 /*spellid*/, TrainerSpell> tsMap = tsd->spellList;
                bool hadNew = false;
                do
                {
                    hadNew = false;
                    for (TrainerSpellMap::const_iterator itr = tsMap.begin(); itr != tsMap.end(); ++itr)
                    {
                        if (TrainerSpell const* tSpell = &itr->second)
                        {
                            TrainerSpellState tsState = pmTargetPlayer->GetTrainerSpellState(tSpell);
                            if (tsState == TrainerSpellState::TRAINER_SPELL_GREEN)
                            {
                                if (const SpellInfo* pS = sSpellMgr->GetSpellInfo(tSpell->spell))
                                {
                                    if (pS->Effects[0].Effect == SpellEffects::SPELL_EFFECT_LEARN_SPELL)
                                    {
                                        pmTargetPlayer->CastSpell(pmTargetPlayer, pS);
                                    }
                                    else
                                    {
                                        pmTargetPlayer->learnSpell(tSpell->spell);
                                    }
                                }
                                hadNew = true;
                            }
                        }
                    }
                } while (hadNew);
            }
        }
    }
    pmTargetPlayer->UpdateSkillsToMaxSkillsForLevel();
    bool resetEquipments = false;
    if (isNew)
    {
        resetEquipments = true;
    }
    InitializeEquipments(pmTargetPlayer, resetEquipments);

    std::ostringstream msgStream;
    msgStream << pmTargetPlayer->GetName() << " initialized";
    sWorld->SendServerMessage(ServerMessageType::SERVER_MSG_STRING, msgStream.str().c_str());

    return isNew;
}

void RobotManager::InitializeEquipments(Player* pmTargetPlayer, bool pmReset)
{
    if (pmReset)
    {
        for (uint8 slot = INVENTORY_SLOT_ITEM_START; slot < INVENTORY_SLOT_ITEM_END; ++slot)
        {
            if (Item* inventoryItem = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
            {
                pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
            }
        }
        for (uint32 checkEquipSlot = EquipmentSlots::EQUIPMENT_SLOT_HEAD; checkEquipSlot < EquipmentSlots::EQUIPMENT_SLOT_TABARD; checkEquipSlot++)
        {
            if (Item* currentEquip = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
            {
                pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
            }
        }
    }
    uint32 minQuality = ItemQualities::ITEM_QUALITY_UNCOMMON;
    if (pmTargetPlayer->getLevel() < 20)
    {
        minQuality = ItemQualities::ITEM_QUALITY_POOR;
    }
    for (uint32 checkEquipSlot = EquipmentSlots::EQUIPMENT_SLOT_HEAD; checkEquipSlot < EquipmentSlots::EQUIPMENT_SLOT_TABARD; checkEquipSlot++)
    {
        if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_HEAD || checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_SHOULDERS || checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_CHEST || checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_WAIST || checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_LEGS || checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_FEET || checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_WRISTS || checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_HANDS)
        {
            if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_HEAD)
            {
                if (pmTargetPlayer->getLevel() < 30)
                {
                    continue;
                }
            }
            else if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_SHOULDERS)
            {
                if (pmTargetPlayer->getLevel() < 20)
                {
                    continue;
                }
            }
            if (Item* currentEquip = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
            {
                if (const ItemTemplate* checkIT = currentEquip->GetTemplate())
                {
                    if (checkIT->Quality >= minQuality)
                    {
                        continue;
                    }
                    else
                    {
                        pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
                    }
                }
            }
            std::unordered_set<uint32> usableItemClass;
            std::unordered_set<uint32> usableItemSubClass;
            usableItemClass.insert(ItemClass::ITEM_CLASS_ARMOR);
            usableItemSubClass.insert(GetUsableArmorSubClass(pmTargetPlayer));
            TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, checkEquipSlot);
        }
        else if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_MAINHAND)
        {
            if (Item* currentEquip = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
            {
                if (const ItemTemplate* checkIT = currentEquip->GetTemplate())
                {
                    if (checkIT->Quality >= minQuality)
                    {
                        continue;
                    }
                    else
                    {
                        pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
                    }
                }
            }
            int weaponSubClass_mh = -1;
            int weaponSubClass_oh = -1;
            int weaponSubClass_r = -1;
            switch (pmTargetPlayer->getClass())
            {
            case Classes::CLASS_WARRIOR:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_SWORD;
                weaponSubClass_oh = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_SHIELD;
                break;
            }
            case Classes::CLASS_PALADIN:
            {
                bool dps = true;
                if (pmTargetPlayer->GetMaxTalentCountTab() == 0)
                {
                    dps = false;
                }
                if (dps)
                {
                    weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_SWORD2;
                    uint32 weaponType = urand(0, 100);
                    if (weaponType < 50)
                    {
                        weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_MACE2;
                    }
                }
                else
                {
                    weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_MACE;
                    uint32 weaponType = urand(0, 100);
                    if (weaponType < 50)
                    {
                        weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_SWORD;
                    }
                    weaponSubClass_oh = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_SHIELD;
                }
                break;
            }
            case Classes::CLASS_HUNTER:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_AXE2;
                uint32 rType = urand(0, 2);
                if (rType == 0)
                {
                    weaponSubClass_r = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_BOW;
                }
                else if (rType == 1)
                {
                    weaponSubClass_r = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_CROSSBOW;
                }
                else
                {
                    weaponSubClass_r = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_GUN;
                }
                break;
            }
            case Classes::CLASS_ROGUE:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_DAGGER;
                weaponSubClass_oh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_DAGGER;
                break;
            }
            case Classes::CLASS_PRIEST:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_STAFF;
                break;
            }
            case Classes::CLASS_SHAMAN:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_MACE;
                weaponSubClass_oh = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_SHIELD;
                break;
            }
            case Classes::CLASS_MAGE:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_STAFF;
                break;
            }
            case Classes::CLASS_WARLOCK:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_STAFF;
                break;
            }
            case Classes::CLASS_DRUID:
            {
                weaponSubClass_mh = ItemSubclassWeapon::ITEM_SUBCLASS_WEAPON_STAFF;
                break;
            }
            default:
            {
                continue;
            }
            }
            if (weaponSubClass_mh >= 0)
            {
                std::unordered_set<uint32> usableItemClass;
                std::unordered_set<uint32> usableItemSubClass;
                usableItemClass.insert(ItemClass::ITEM_CLASS_WEAPON);
                usableItemSubClass.insert(weaponSubClass_mh);
                TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, checkEquipSlot);
            }
            if (weaponSubClass_oh >= 0)
            {
                std::unordered_set<uint32> usableItemClass;
                std::unordered_set<uint32> usableItemSubClass;
                usableItemClass.insert(ItemClass::ITEM_CLASS_WEAPON);
                usableItemClass.insert(ItemClass::ITEM_CLASS_ARMOR);
                usableItemSubClass.insert(weaponSubClass_oh);
                TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, EquipmentSlots::EQUIPMENT_SLOT_OFFHAND);
            }
            if (weaponSubClass_r >= 0)
            {
                std::unordered_set<uint32> usableItemClass;
                std::unordered_set<uint32> usableItemSubClass;
                usableItemClass.insert(ItemClass::ITEM_CLASS_WEAPON);
                usableItemSubClass.insert(weaponSubClass_r);
                TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, EquipmentSlots::EQUIPMENT_SLOT_RANGED);
            }
        }
        else if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_BACK)
        {
            if (Item* currentEquip = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
            {
                if (const ItemTemplate* checkIT = currentEquip->GetTemplate())
                {
                    if (checkIT->Quality >= minQuality)
                    {
                        continue;
                    }
                    else
                    {
                        pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
                    }
                }
            }
            std::unordered_set<uint32> usableItemClass;
            std::unordered_set<uint32> usableItemSubClass;
            usableItemClass.insert(ItemClass::ITEM_CLASS_ARMOR);
            usableItemSubClass.insert(ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_CLOTH);
            TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, checkEquipSlot);
        }
        else if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_FINGER1)
        {
            if (pmTargetPlayer->getLevel() < 20)
            {
                continue;
            }
            if (Item* currentEquip = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
            {
                if (const ItemTemplate* checkIT = currentEquip->GetTemplate())
                {
                    if (checkIT->Quality >= minQuality)
                    {
                        continue;
                    }
                    else
                    {
                        pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
                    }
                }
            }
            std::unordered_set<uint32> usableItemClass;
            std::unordered_set<uint32> usableItemSubClass;
            usableItemClass.insert(ItemClass::ITEM_CLASS_ARMOR);
            usableItemSubClass.insert(ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_MISC);
            TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, checkEquipSlot);
        }
        else if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_FINGER2)
        {
            if (pmTargetPlayer->getLevel() < 20)
            {
                continue;
            }
            if (Item* currentEquip = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
            {
                if (const ItemTemplate* checkIT = currentEquip->GetTemplate())
                {
                    if (checkIT->Quality >= minQuality)
                    {
                        continue;
                    }
                    else
                    {
                        pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
                    }
                }
            }
            std::unordered_set<uint32> usableItemClass;
            std::unordered_set<uint32> usableItemSubClass;
            usableItemClass.insert(ItemClass::ITEM_CLASS_ARMOR);
            usableItemSubClass.insert(ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_MISC);
            TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, checkEquipSlot);
        }
        else if (checkEquipSlot == EquipmentSlots::EQUIPMENT_SLOT_NECK)
        {
            if (pmTargetPlayer->getLevel() < 30)
            {
                continue;
            }
            if (Item* currentEquip = pmTargetPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, checkEquipSlot))
            {
                if (const ItemTemplate* checkIT = currentEquip->GetTemplate())
                {
                    if (checkIT->Quality >= minQuality)
                    {
                        continue;
                    }
                    else
                    {
                        pmTargetPlayer->DestroyItem(INVENTORY_SLOT_BAG_0, checkEquipSlot, true);
                    }
                }
            }
            std::unordered_set<uint32> usableItemClass;
            std::unordered_set<uint32> usableItemSubClass;
            usableItemClass.insert(ItemClass::ITEM_CLASS_ARMOR);
            usableItemSubClass.insert(ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_MISC);
            TryEquip(pmTargetPlayer, usableItemClass, usableItemSubClass, checkEquipSlot);
        }
    }
}

uint32 RobotManager::GetUsableArmorSubClass(Player* pmTargetPlayer)
{
    if (!pmTargetPlayer)
    {
        return false;
    }
    uint32 resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_CLOTH;
    switch (pmTargetPlayer->getClass())
    {
    case Classes::CLASS_WARRIOR:
    {
        if (pmTargetPlayer->getLevel() < 40)
        {
            // use mail armor
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_MAIL;
        }
        else
        {
            // use plate armor
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_PLATE;
        }
        break;
    }
    case Classes::CLASS_PALADIN:
    {
        if (pmTargetPlayer->getLevel() < 40)
        {
            // use mail armor
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_MAIL;
        }
        else
        {
            // use plate armor
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_PLATE;
        }
        break;
    }
    case Classes::CLASS_HUNTER:
    {
        if (pmTargetPlayer->getLevel() < 40)
        {
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_LEATHER;
        }
        else
        {
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_MAIL;
        }
        break;
    }
    case Classes::CLASS_ROGUE:
    {
        resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_LEATHER;
        break;
    }
    case Classes::CLASS_PRIEST:
    {
        resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_CLOTH;
        break;
    }
    case Classes::CLASS_SHAMAN:
    {
        if (pmTargetPlayer->getLevel() < 40)
        {
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_LEATHER;
        }
        else
        {
            resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_MAIL;
        }
        break;
    }
    case Classes::CLASS_MAGE:
    {
        resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_CLOTH;
        break;
    }
    case Classes::CLASS_WARLOCK:
    {
        resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_CLOTH;
        break;
    }
    case Classes::CLASS_DRUID:
    {
        resultArmorSubClass = ItemSubclassArmor::ITEM_SUBCLASS_ARMOR_LEATHER;
        break;
    }
    default:
    {
        break;
    }
    }

    return resultArmorSubClass;
}

bool RobotManager::EquipNewItem(Player* pmTargetPlayer, uint32 pmItemEntry, uint8 pmEquipSlot)
{
    if (!pmTargetPlayer)
    {
        return false;
    }
    uint16 eDest;
    InventoryResult tryEquipResult = pmTargetPlayer->CanEquipNewItem(pmEquipSlot, eDest, pmItemEntry, false);
    if (tryEquipResult == EQUIP_ERR_OK)
    {
        if (Item* pNewItem = pmTargetPlayer->EquipNewItem(eDest, pmItemEntry, true))
        {
            pmTargetPlayer->AutoUnequipOffhandIfNeed();
            return true;
        }
    }

    return false;
}

void RobotManager::TryEquip(Player* pmTargetPlayer, std::unordered_set<uint32> pmClassSet, std::unordered_set<uint32> pmSubClassSet, uint32 pmTargetSlot)
{
    if (!pmTargetPlayer)
    {
        return;
    }
    uint32 minQuality = ItemQualities::ITEM_QUALITY_UNCOMMON;
    if (pmTargetPlayer->getLevel() < 20)
    {
        minQuality = ItemQualities::ITEM_QUALITY_POOR;
    }
    std::unordered_map<uint32, uint32> validEquipSet;
    ItemTemplateContainer const* its = sObjectMgr->GetItemTemplateStore();
    for (ItemTemplateContainer::const_iterator itr = its->begin(); itr != its->end(); ++itr)
    {
        const ItemTemplate proto = itr->second;
        if (pmClassSet.find(proto.Class) == pmClassSet.end())
        {
            continue;
        }
        if (pmSubClassSet.find(proto.SubClass) == pmSubClassSet.end())
        {
            continue;
        }
        if (proto.Quality < minQuality || proto.Quality > ItemQualities::ITEM_QUALITY_EPIC)
        {
            continue;
        }
        // test items
        if (proto.ItemId == 19879)
        {
            continue;
        }
        std::unordered_set<uint32> usableSlotSet = GetUsableEquipSlot(&proto);
        if (usableSlotSet.find(pmTargetSlot) != usableSlotSet.end())
        {
            uint32 checkMinRequiredLevel = pmTargetPlayer->getLevel();
            if (checkMinRequiredLevel > 10)
            {
                checkMinRequiredLevel = checkMinRequiredLevel - 5;
            }
            else
            {
                checkMinRequiredLevel = 5;
            }
            if (proto.RequiredLevel <= pmTargetPlayer->getLevel() && proto.RequiredLevel >= checkMinRequiredLevel)
            {
                validEquipSet[validEquipSet.size()] = proto.ItemId;
            }
        }
    }
    if (validEquipSet.size() > 0)
    {
        int tryTimes = 5;
        while (tryTimes > 0)
        {
            uint32 equipEntry = urand(0, validEquipSet.size() - 1);
            equipEntry = validEquipSet[equipEntry];
            if (EquipNewItem(pmTargetPlayer, equipEntry, pmTargetSlot))
            {
                break;
            }
            tryTimes--;
        }
    }
    //if (WorldSession* playerSession = pmTargetPlayer->GetSession())
    //{
    //    if (AI_Base* robotAI = playerSession->robotAI)
    //    {
    //   }
    //}
}

void RobotManager::RandomTeleport(Player* pmTargetPlayer)
{
    if (!pmTargetPlayer)
    {
        return;
    }
    if (pmTargetPlayer->IsBeingTeleported())
    {
        return;
    }
    if (!pmTargetPlayer->IsAlive())
    {
        pmTargetPlayer->ResurrectPlayer(1.0f);
        pmTargetPlayer->SpawnCorpseBones();
    }
    pmTargetPlayer->getThreatManager().clearReferences();
    pmTargetPlayer->ClearInCombat();
    pmTargetPlayer->StopMoving();
    pmTargetPlayer->GetMotionMaster()->Clear();
    if (AI_Base* robotAI = pmTargetPlayer->robotAI)
    {
        robotAI->Reset();
    }
    pmTargetPlayer->TeleportTo(pmTargetPlayer->m_homebindMapId, pmTargetPlayer->m_homebindX, pmTargetPlayer->m_homebindY, pmTargetPlayer->m_homebindZ, 0.0f);
    sLog->outBasic("Teleport robot %s (level %d)", pmTargetPlayer->GetName().c_str(), pmTargetPlayer->getLevel());
}

bool RobotManager::TankThreatOK(Player* pmTankPlayer, Unit* pmVictim)
{
    if (pmTankPlayer && pmVictim)
    {
        if (pmTankPlayer->IsAlive() && pmVictim->IsAlive())
        {
            switch (pmTankPlayer->getClass())
            {
            case Classes::CLASS_WARRIOR:
            {
                if (HasAura(pmVictim, "Sunder Armor"))
                {
                    return true;
                }
                //if (GetAuraStack(pmVictim, "Sunder Armor", pmTankPlayer) > 2)
                //{
                //	return true;
                //}
                break;
            }
            case Classes::CLASS_PALADIN:
            {
                if (HasAura(pmVictim, "Judgement of the Crusader"))
                {
                    return true;
                }
                break;
            }
            case Classes::CLASS_DRUID:
            {
                return true;
            }
            default:
            {
                break;
            }
            }
        }
    }
    return false;
}

bool RobotManager::HasAura(Unit* pmTarget, std::string pmSpellName, Unit* pmCaster)
{
    if (!pmTarget)
    {
        return false;
    }
    std::set<uint32> spellIDSet = spellNameEntryMap[pmSpellName];
    for (std::set<uint32>::iterator it = spellIDSet.begin(); it != spellIDSet.end(); it++)
    {
        uint32 spellID = *it;
        if (pmCaster)
        {
            if (pmTarget->HasAura(spellID, pmCaster->GetGUID()))
            {
                return true;
            }
        }
        else
        {
            if (pmTarget->HasAura(spellID))
            {
                return true;
            }
        }
    }

    return false;
}

uint32 RobotManager::GetAuraDuration(Unit* pmTarget, std::string pmSpellName, Unit* pmCaster)
{
    if (!pmTarget)
    {
        return false;
    }
    uint32 duration = 0;
    std::set<uint32> spellIDSet = spellNameEntryMap[pmSpellName];
    for (std::set<uint32>::iterator it = spellIDSet.begin(); it != spellIDSet.end(); it++)
    {
        uint32 spellID = *it;
        if (pmCaster)
        {
            if (Aura* destAura = pmTarget->GetAura(spellID, pmCaster->GetGUID()))
            {
                duration = destAura->GetDuration();
            }
        }
        else
        {
            if (Aura* destAura = pmTarget->GetAura(spellID))
            {
                duration = destAura->GetDuration();
            }
        }
        if (duration > 0)
        {
            break;
        }
    }

    return duration;
}

uint32 RobotManager::GetAuraStack(Unit* pmTarget, std::string pmSpellName, Unit* pmCaster)
{
    uint32 auraStack = 0;
    if (!pmTarget)
    {
        return false;
    }
    std::set<uint32> spellIDSet = spellNameEntryMap[pmSpellName];
    for (std::set<uint32>::iterator it = spellIDSet.begin(); it != spellIDSet.end(); it++)
    {
        uint32 spellID = *it;
        if (pmCaster)
        {
            if (Aura* destAura = pmTarget->GetAura(spellID, pmCaster->GetGUID()))
            {
                auraStack = destAura->GetStackAmount();
            }
        }
        else
        {
            if (Aura* destAura = pmTarget->GetAura(spellID))
            {
                auraStack = destAura->GetStackAmount();
            }
        }
        if (auraStack > 0)
        {
            break;
        }
    }

    return auraStack;
}
