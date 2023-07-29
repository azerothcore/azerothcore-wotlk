#pragma once
#include "Player.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "Chat.h"
#include "Group.h"
#include "Config.h"


struct PossibleLoot {
    uint32 ItemId;
    uint32 Quantity;
};

struct Completion {
    uint64 guid;
    uint32 bossId;
};

struct Modifier {
    float spellMultiplier;
    float meleeMultiplier;
    float healthMultiplier;
    float healthCofficient;
};


class ForgedInstanceManager {
public:

    struct ForgedInstance {
        Map* map;
        uint64 groupGuid;
        Player* leader;
        bool isRaid;
        std::vector<uint64> creatureGuids;
        uint8 level;
    };
    static void CreateLoot(uint32 bossId, Creature* boss);
    static void CreateLoot(uint32 bossId, GameObject* go);
    static void StartForgedInstance(Player* player, uint8 level);
    static void AddKillCreditBoss(Player* player, uint32 bossId);
    static void RemoveGuidCalculated(Creature* creature);
    static bool IsInForgedInstance(uint32 instanceId);
    static bool IsInForgedInstance(Player* player);
    static bool creatureAlreadyCalculated(uint32 instanceId, uint64 guid);
    static Modifier GetModifier(uint32 creatureId);
    static void PreloadAllLoot();
    static void PreloadAllCompletions();
    static void PreloadAllRequierements();
    static void PreloadAllCreaturesIds();
    static ForgedInstance GetForgedInstanceEncounter(uint32 instanceId);
    static void ResetForgedInstance(Group* group, bool remove);
    static void AddCreatureCalculated(Map* map, uint64 guid);

private:

    static void RewardEmblemsPlayers(Map::PlayerList const& playerList, bool isRaid);
    static std::map<uint32 /* bossId */, std::vector<PossibleLoot> /* possibleLoot*/> loots;
    static std::vector<Completion> completions;
    static std::map<uint32 /* mapId */, uint32 /* bossId */> requierements;
    static std::map<uint32 /* creatureId */, Modifier /* Modifier */> creaturesModifiers;
    static std::map<uint32 /* instance Id */, ForgedInstance> encounters;

    static bool CanDoForgedInstance(Player* player, uint32 mapId);
    static std::vector<LootStoreItem> GenerateForgedInstanceLoot(uint32 bossId, uint8 lootMode);

};
