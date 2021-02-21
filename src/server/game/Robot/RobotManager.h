#ifndef ROBOT_MANAGER_H
#define ROBOT_MANAGER_H

#define enum_to_string(x) #x

#ifndef ROBOT_PASSWORD
# define ROBOT_PASSWORD "robot"
#endif

#ifndef AOE_TARGETS_RANGE
# define AOE_TARGETS_RANGE 5.0f
#endif

#ifndef MID_RANGE
# define MID_RANGE 8.0f
#endif

#ifndef MIN_DISTANCE_GAP
# define MIN_DISTANCE_GAP 0.2f
#endif

#ifndef FOLLOW_MIN_DISTANCE
# define FOLLOW_MIN_DISTANCE 1.0f
#endif

#ifndef FOLLOW_NEAR_DISTANCE
# define FOLLOW_NEAR_DISTANCE 10.0f
#endif

#ifndef FOLLOW_NORMAL_DISTANCE
# define FOLLOW_NORMAL_DISTANCE 18.0f
#endif

#ifndef FOLLOW_FAR_DISTANCE
# define FOLLOW_FAR_DISTANCE 25.0f
#endif

#ifndef FOLLOW_MAX_DISTANCE
# define FOLLOW_MAX_DISTANCE 60.0f
#endif

#ifndef MELEE_MIN_DISTANCE
# define MELEE_MIN_DISTANCE 0.2f
#endif

#ifndef MELEE_MAX_DISTANCE
# define MELEE_MAX_DISTANCE 1.0f
#endif

#ifndef RANGED_NORMAL_DISTANCE
# define RANGED_NORMAL_DISTANCE 20.0f
#endif

#ifndef RANGED_FAR_DISTANCE
# define RANGED_FAR_DISTANCE 29.0f
#endif

#ifndef RANGED_MAX_DISTANCE
# define RANGED_MAX_DISTANCE 44.0f
#endif

#ifndef HEAL_MAX_DISTANCE
# define HEAL_MAX_DISTANCE 39.0f
#endif

#ifndef ATTACK_RANGE_LIMIT
# define ATTACK_RANGE_LIMIT 100.0f
#endif

#ifndef DEFAULT_REST_DELAY
# define DEFAULT_REST_DELAY 20000
#endif

#include "RobotEntity.h"
#include "Player.h"

#include <string>
#include <iostream>
#include <sstream>

enum RobotType :uint32
{
	RobotType_World = 0,
	RobotType_Raid = 1,
};

enum RobotCampType :uint16
{
	RobotCampType_All = 0,
	RobotCampType_Alliance = 1,
	RobotCampType_Horde = 2
};

class RobotManager
{
	RobotManager();
	RobotManager(RobotManager const&) = delete;
	RobotManager& operator=(RobotManager const&) = delete;
	~RobotManager() = default;

public:
	void InitializeManager();
	void UpdateRobotManager(uint32 pmDiff);
	bool DeleteRobots();
	bool RobotsDeleted();
	uint32 CheckRobotAccount(std::string pmAccountName);
	bool CreateRobotAccount(std::string pmAccountName);
	uint32 CheckAccountCharacter(uint32 pmAccountID);
	uint32 GetCharacterRace(uint32 pmCharacterID);
	uint32 CreateRobotCharacter(uint32 pmAccountID, uint16 pmCampType = RobotCampType::RobotCampType_All);
	uint32 CreateRobotCharacter(uint32 pmAccountID, uint32 pmCharacterClass, uint32 pmCharacterRace);
	bool PrepareRobot(Player* pmRobot);
	std::unordered_set<uint32> GetUsableEquipSlot(const ItemTemplate* pmIT);
	Player* CheckLogin(uint32 pmAccountID, uint32 pmCharacterID);
	bool LoginRobot(uint32 pmAccountID, uint32 pmCharacterID);
	void LogoutRobot(uint32 pmCharacterID);
	void LogoutRobots(bool pmWait = false, uint32 pmWaitMin = 5, uint32 pmWaitMax = 10);
	void HandlePlayerSay(Player* pmPlayer, std::string pmContent);
	void HandleChatCommand(Player* pmSender, std::string pmCMD, Player* pmReceiver = NULL);
	bool StringEndWith(const std::string& str, const std::string& tail);
	bool StringStartWith(const std::string& str, const std::string& head);
	std::vector<std::string> SplitString(std::string srcStr, std::string delimStr, bool repeatedCharIgnored);
	std::string TrimString(std::string srcStr);
	static RobotManager* instance();
	void HandlePacket(WorldSession* pmSession, WorldPacket pmPacket);
	void WhisperTo(Player* pmTarget, std::string pmContent, Language pmLanguage, Player* pmSender);

	bool InitializeCharacter(Player* pmTargetPlayer, uint32 pmTargetLevel);
    void LearnPlayerTalents(Player* pmTargetPlayer);
	void InitializeEquipments(Player* pmTargetPlayer, bool pmReset);
	uint32 GetUsableArmorSubClass(Player* pmTargetPlayer);
	void TryEquip(Player* pmTargetPlayer, std::unordered_set<uint32> pmClassSet, std::unordered_set<uint32> pmSubClassSet, uint32 pmTargetSlot);
	bool EquipNewItem(Player* pmTargetPlayer, uint32 pmItemEntry, uint8 pmEquipSlot);
	void RandomTeleport(Player* pmTargetPlayer);

	bool TankThreatOK(Player* pmTankPlayer, Unit* pmVictim);
	bool HasAura(Unit* pmTarget, std::string pmSpellName, Unit* pmCaster = NULL);
	uint32 GetAuraDuration(Unit* pmTarget, std::string pmSpellName, Unit* pmCaster = NULL);
	uint32 GetAuraStack(Unit* pmTarget, std::string pmSpellName, Unit* pmCaster = NULL);

public:
	std::unordered_map<uint32, std::unordered_map<uint32, uint32>> allianceRaces;
	std::unordered_map<uint32, std::unordered_map<uint32, uint32>> hordeRaces;
	std::unordered_map<uint32, std::unordered_map<uint32, uint32>> availableRaces;
	std::unordered_map<uint32, std::string> robotNameMap;

	std::unordered_map<uint8, std::unordered_map<uint8, std::string>> characterTalentTabNameMap;
	std::set<uint32> deleteRobotAccountSet;	
	std::unordered_map<std::string, RobotEntity*> robotEntityMap;

	uint32 nameIndex;

	std::unordered_set<uint32> spellRewardClassQuestIDSet;
	std::unordered_map<uint32, uint32> onlinePlayerIDMap;

	std::unordered_map<uint32, uint32> tamableBeastEntryMap;
	std::unordered_map<std::string, std::set<uint32>> spellNameEntryMap;
};

#define sRobotManager RobotManager::instance()

#endif
