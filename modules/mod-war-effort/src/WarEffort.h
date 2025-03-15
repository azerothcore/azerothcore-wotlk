#ifndef DEF_WAREFFORT_H
#define DEF_WAREFFORT_H

#include "Config.h"
#include "GameEventMgr.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include <unordered_map>
#include <vector>

struct WarEffortData
{
    uint8 Material;
    uint32 QuestId;
    uint8 MaterialCategory;
    uint32 Goal;
    uint8 Multiplier;
};

struct WarEffortGameobject
{
    uint32 Id;
    uint8 MaterialCategory;
    Position SpawnPosition;
};

enum MaterialCategory
{
    MATERIAL_CAT_BANDAGES,
    MATERIAL_CAT_FOOD,
    MATERIAL_CAT_HERBS,
    MATERIAL_CAT_METAL,
    MATERIAL_CAT_LEATHER,
    MAX_MATERIAL_CATS
};

enum MaterialsAlliance
{
    MATERIAL_LINEN,
    MATERIAL_SILK,
    MATERIAL_RUNECLOTH_A,

    MATERIAL_ALBACORE,
    MATERIAL_RAPTOR,
    MATERIAL_YELLOWTAIL_A,

    MATERIAL_STRANGLEKELP,
    MATERIAL_ARTHAS_TEARS,
    MATERIAL_PURPLE_LOTUS_A,

    MATERIAL_IRON,
    MATERIAL_THORIUM,
    MATERIAL_COOPER_A,

    MATERIAL_LIGHT_LEATHER,
    MATERIAL_MEDIUM_LEATHER,
    MATERIAL_THICK_LEATHER_A,

    MAX_WAREFFORT_MATERIALS
};

enum MaterialsHorde
{
    MATERIAL_WOOL,
    MATERIAL_MAGEWEAVE,
    MATERIAL_RUNECLOTH_B,

    MATERIAL_WOLF,
    MATERIAL_SALMON,
    MATERIAL_YELLOWTAIL_H,

    MATERIAL_PEACEBLOOM,
    MATERIAL_FIREBLOOM,
    MATERIAL_PURPLE_LOTUS_H,

    MATERIAL_TIN,
    MATERIAL_MITHRIL,
    MATERIAL_COOPER_H,

    MATERIAL_HEAVY_LEATHER,
    MATERIAL_RUGGER_LEATHER,
    MATERIAL_THICK_LEATHER_B
};

enum WarEffortQuests
{
    QUEST_LINEN_BANDAGES       = 8517,
    QUEST_SILK_BANDAGES        = 8520,
    QUEST_WOOL_BANDAGES        = 8604,
    QUEST_MAGEWEAVE_BANDAGES   = 8607,
    QUEST_RUNECLOTH_BANDAGES_A = 8522,
    QUEST_RUNECLOTH_BANDAGES_H = 8609,

    QUEST_ALBACORE             = 8524,
    QUEST_RAPTOR               = 8526,
    QUEST_WOLF_STEAKS          = 8611,
    QUEST_SALMON               = 8615,
    QUEST_YELLOWTAIL_A         = 8528,
    QUEST_YELLOWTAIL_H         = 8613,

    QUEST_STRANGLEKELP         = 8503,
    QUEST_ARTHAS_TEARS         = 8509,
    QUEST_PEACEBLOOM           = 8549,
    QUEST_FIREBLOOM            = 8580,
    QUEST_PURPLE_LOTUS_A       = 8505,
    QUEST_PURPLE_LOTUS_H       = 8582,

    QUEST_IRON                 = 8494,
    QUEST_THORIUM              = 8499,
    QUEST_TIN                  = 8542,
    QUEST_MITHRIL              = 8545,
    QUEST_COOPER_A             = 8492,
    QUEST_COOPER_H             = 8532,

    QUEST_LIGHT_LEATHER        = 8511,
    QUEST_MEDIUM_LEATHER       = 8513,
    QUEST_HEAVY_LEATHER        = 8588,
    QUEST_RUGGED_LEATHER       = 8600,
    QUEST_THICK_LEATHER_A      = 8515,
    QUEST_THICK_LEATHER_H      = 8590,

    QUEST_BANG_GONG            = 8743
};

enum WarEffortGameobjectIds
{
    GO_BANDAGES_HORDE_INITIAL = 180826,
    GO_BANDAGES_HORDE_TIER_1  = 180827,
    GO_BANDAGES_HORDE_TIER_2  = 180828,
    GO_BANDAGES_HORDE_TIER_3  = 180829,
    GO_BANDAGES_HORDE_TIER_4  = 180830,
    GO_BANDAGES_HORDE_TIER_5  = 180831,

    GO_HERBS_HORDE_INITIAL    = 180818,
    GO_HERBS_HORDE_TIER_1     = 180819,
    GO_HERBS_HORDE_TIER_2     = 180820,
    GO_HERBS_HORDE_TIER_3     = 180821,
    GO_HERBS_HORDE_TIER_4     = 180822,
    GO_HERBS_HORDE_TIER_5     = 180823,

    GO_FOOD_HORDE_INITIAL     = 180832,
    GO_FOOD_HORDE_TIER_1      = 180833,
    GO_FOOD_HORDE_TIER_2      = 180834,
    GO_FOOD_HORDE_TIER_3      = 180835,
    GO_FOOD_HORDE_TIER_4      = 180836,
    GO_FOOD_HORDE_TIER_5      = 180837,

    GO_METAL_HORDE_INITIAL    = 180838,
    GO_METAL_HORDE_TIER_1     = 180839,
    GO_METAL_HORDE_TIER_2     = 180840,
    GO_METAL_HORDE_TIER_3     = 180841,
    GO_METAL_HORDE_TIER_4     = 180842,
    GO_METAL_HORDE_TIER_5     = 180843,

    GO_LEATHER_HORDE_INITIAL  = 180812,
    GO_LEATHER_HORDE_TIER_1   = 180813,
    GO_LEATHER_HORDE_TIER_2   = 180814,
    GO_LEATHER_HORDE_TIER_3   = 180815,
    GO_LEATHER_HORDE_TIER_4   = 180816,
    GO_LEATHER_HORDE_TIER_5   = 180817,

    // Alliance
    // GO_INITIAL_*s are already spawned
    GO_HERBS_ALLIANCE_TIER_1  = 180801,
    GO_HERBS_ALLIANCE_TIER_2  = 180802,
    GO_HERBS_ALLIANCE_TIER_3  = 180803,
    GO_HERBS_ALLIANCE_TIER_4  = 180804,
    GO_HERBS_ALLIANCE_TIER_5  = 180805,

    GO_BANDAGES_ALLIANCE_TIER_1 = 180674,
    GO_BANDAGES_ALLIANCE_TIER_2 = 180675,
    GO_BANDAGES_ALLIANCE_TIER_3 = 180676,
    GO_BANDAGES_ALLIANCE_TIER_4 = 180677,
    GO_BANDAGES_ALLIANCE_TIER_5 = 180678,

    GO_FOOD_ALLIANCE_TIER_1   = 180800,
    GO_FOOD_ALLIANCE_TIER_2   = 180801,
    GO_FOOD_ALLIANCE_TIER_3   = 180802,
    GO_FOOD_ALLIANCE_TIER_4   = 180803,
    GO_FOOD_ALLIANCE_TIER_5   = 180804,

    GO_LEATHER_ALLIANCE_TIER_1  = 180692,
    GO_LEATHER_ALLIANCE_TIER_2  = 180693,
    GO_LEATHER_ALLIANCE_TIER_3  = 180694,
    GO_LEATHER_ALLIANCE_TIER_4  = 180695,
    GO_LEATHER_ALLIANCE_TIER_5  = 180696,

    GO_METAL_ALLIANCE_TIER_1  = 180780,
    GO_METAL_ALLIANCE_TIER_2  = 180781,
    GO_METAL_ALLIANCE_TIER_3  = 180782,
    GO_METAL_ALLIANCE_TIER_4  = 180783,
    GO_METAL_ALLIANCE_TIER_5  = 180784
};

enum WarEffortNpcs
{
    NPC_JONATHAN              = 15693
};

// Not blizzlike, not sniffed, not researched
// Custom objects added to make the progression gobs look less scuffed,
// As they require exact spawn positions to look good and we dont have them
enum GoAccessories
{
    GO_TABLE = 181075
};

std::map<uint32, Position> WarEffortGameobjectPositions =
{
    { GO_BANDAGES_HORDE_INITIAL, Position(1582.97f, -4112.28f, 34.0149f, 3.38216f) },
    { GO_HERBS_HORDE_INITIAL, Position(1633.08f, -4140.41f, 34.3886f, 3.79286f) },
    { GO_FOOD_HORDE_INITIAL, Position(1623.2f, -4094.17f, 35.3933f, 3.9846f) },
    { GO_FOOD_HORDE_TIER_1, Position(1630.44f, -4073.68f, 36.0707f, 2.77926f) },
    { GO_FOOD_HORDE_TIER_2, Position(1626.65f, -4086.06f, 32.1115f, 3.51757f) },
    { GO_FOOD_HORDE_TIER_3, Position(1632.56f, -4074.87f, 36.1896f, 2.96728f) },
    { GO_FOOD_HORDE_TIER_4, Position(1629.21f, -4080.47f, 32.6781f, 3.49859f) },
    { GO_FOOD_HORDE_TIER_5, Position(1626.37f, -4085.38f, 30.0f, 3.9f) },
    { GO_LEATHER_HORDE_INITIAL, Position(1588.53f, -4173.9f, 39.2266f, 3.90826f) },
    { GO_METAL_HORDE_INITIAL, Position(1682.33f, -4136.71f, 40.8444f, 3.4547f) },
    { GO_HERBS_ALLIANCE_TIER_1, Position(-4962.77f, -1261.97f, 501.672f, 1.10063f) },
    { GO_FOOD_ALLIANCE_TIER_1, Position(-4931.66f, -1258.2f, 501.661f, 5.24509f) },
    { GO_LEATHER_ALLIANCE_TIER_1, Position(-4970.71f, -1176.37f, 501.641f) },
    { GO_METAL_ALLIANCE_TIER_1, Position(-4916.41f, -1236.17f, 501.658f) },
    { GO_BANDAGES_ALLIANCE_TIER_1, Position(-4985.06f, -1140.51f, 501.659f, 4.10423f) }
};


class WarEffort
{
public:

    WarEffortData const WarEffortMaterialsAlliance[MAX_WAREFFORT_MATERIALS] =
    {
        { MATERIAL_LINEN,           QUEST_LINEN_BANDAGES,       MATERIAL_CAT_BANDAGES, sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Bandages.01", 30000), 20 },
        { MATERIAL_SILK,            QUEST_SILK_BANDAGES,        MATERIAL_CAT_BANDAGES, sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Bandages.02", 30000), 20 },
        { MATERIAL_RUNECLOTH_A,     QUEST_RUNECLOTH_BANDAGES_A, MATERIAL_CAT_BANDAGES, sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Bandages.03", 30000), 20 },
        { MATERIAL_ALBACORE,        QUEST_ALBACORE,             MATERIAL_CAT_FOOD,     sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Food.01", 30000), 20 },
        { MATERIAL_RAPTOR,          QUEST_RAPTOR,               MATERIAL_CAT_FOOD,     sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Food.02", 30000), 20 },
        { MATERIAL_YELLOWTAIL_A,    QUEST_YELLOWTAIL_A,         MATERIAL_CAT_FOOD,     sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Food.03", 30000), 20 },
        { MATERIAL_STRANGLEKELP,    QUEST_STRANGLEKELP,         MATERIAL_CAT_HERBS,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Herbs.01", 30000), 20 },
        { MATERIAL_ARTHAS_TEARS,    QUEST_ARTHAS_TEARS,         MATERIAL_CAT_HERBS,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Herbs.02", 30000), 20 },
        { MATERIAL_PURPLE_LOTUS_A,  QUEST_PURPLE_LOTUS_A,       MATERIAL_CAT_HERBS,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Herbs.03", 30000), 20 },
        { MATERIAL_IRON,            QUEST_IRON,                 MATERIAL_CAT_METAL,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Metal.01", 30000), 20 },
        { MATERIAL_THORIUM,         QUEST_THORIUM,              MATERIAL_CAT_METAL,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Metal.02", 30000), 20 },
        { MATERIAL_COOPER_A,        QUEST_COOPER_A,             MATERIAL_CAT_METAL,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Metal.03", 30000), 20 },
        { MATERIAL_LIGHT_LEATHER,   QUEST_LIGHT_LEATHER,        MATERIAL_CAT_LEATHER,  sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Leather.01", 30000), 10 },
        { MATERIAL_MEDIUM_LEATHER,  QUEST_MEDIUM_LEATHER,       MATERIAL_CAT_LEATHER,  sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Leather.02", 30000), 10 },
        { MATERIAL_THICK_LEATHER_A, QUEST_THICK_LEATHER_A,      MATERIAL_CAT_LEATHER,  sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Alliance.Leather.03", 30000), 10 },
    };

    WarEffortData const WarEffortMaterialsHorde[MAX_WAREFFORT_MATERIALS] =
    {
        { MATERIAL_WOOL,            QUEST_WOOL_BANDAGES,        MATERIAL_CAT_BANDAGES, sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Bandages.01", 30000), 20  },
        { MATERIAL_MAGEWEAVE,       QUEST_MAGEWEAVE_BANDAGES,   MATERIAL_CAT_BANDAGES, sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Bandages.02", 30000), 20  },
        { MATERIAL_RUNECLOTH_B,     QUEST_RUNECLOTH_BANDAGES_H, MATERIAL_CAT_BANDAGES, sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Bandages.03", 30000), 20  },
        { MATERIAL_WOLF,            QUEST_WOLF_STEAKS,          MATERIAL_CAT_FOOD,     sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Food.01", 30000), 20  },
        { MATERIAL_SALMON,          QUEST_SALMON,               MATERIAL_CAT_FOOD,     sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Food.02", 30000), 20  },
        { MATERIAL_YELLOWTAIL_H,    QUEST_YELLOWTAIL_H,         MATERIAL_CAT_FOOD,     sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Food.03", 30000), 20  },
        { MATERIAL_PEACEBLOOM,      QUEST_PEACEBLOOM,           MATERIAL_CAT_FOOD,     sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Herbs.01", 30000), 20  },
        { MATERIAL_FIREBLOOM,       QUEST_FIREBLOOM,            MATERIAL_CAT_HERBS,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Herbs.02", 30000), 20  },
        { MATERIAL_PURPLE_LOTUS_H,  QUEST_PURPLE_LOTUS_H,       MATERIAL_CAT_HERBS,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Herbs.03", 30000), 20  },
        { MATERIAL_TIN,             QUEST_TIN,                  MATERIAL_CAT_METAL,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Metal.01", 30000), 20  },
        { MATERIAL_MITHRIL,         QUEST_MITHRIL,              MATERIAL_CAT_METAL,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Metal.02", 30000), 20  },
        { MATERIAL_COOPER_H,        QUEST_COOPER_H,             MATERIAL_CAT_METAL,    sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Metal.03", 30000), 20  },
        { MATERIAL_HEAVY_LEATHER,   QUEST_HEAVY_LEATHER,        MATERIAL_CAT_LEATHER,  sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Leather.01", 30000), 10  },
        { MATERIAL_RUGGER_LEATHER,  QUEST_RUGGED_LEATHER,       MATERIAL_CAT_LEATHER,  sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Leather.02", 30000), 10  },
        { MATERIAL_THICK_LEATHER_B, QUEST_THICK_LEATHER_H,      MATERIAL_CAT_LEATHER,  sConfigMgr->GetOption<uint32>("ModWarEffort.Goal.Horde.Leather.03", 30000), 10  }
    };

    static WarEffort* instance();

    bool saveNeeded{ false };
    bool isComplete{ false };
    bool gongBanged{ false };

    std::string PrintOutMaterialCount(uint8 team);

    uint32 materialsAlliance[MAX_WAREFFORT_MATERIALS];
    uint32 materialsHorde[MAX_WAREFFORT_MATERIALS];

    uint32 lastSave{0};

    [[nodiscard]] bool IsSaveNeeded() { return saveNeeded; }
    void SetSaveStatus(bool needed) { saveNeeded = needed; }
    [[nodiscard]] bool IsEnabled() { return sConfigMgr->GetOption<bool>("ModWarEffort.Enable", false);  }
    [[nodiscard]] uint32 GetActiveEventId() { return sConfigMgr->GetOption<uint32>("ModWarEffort.Id", 1); }
    void CheckGoal(Unit* unit, uint8 material, uint8 team);
    [[nodiscard]] uint32 GetAccumulatedMaterials(uint8 material, uint8 team);
    [[nodiscard]] bool IsBellowPercentGathered(uint8 material, uint8 team, float pct);
    [[nodiscard]] bool IsWarEffortComplete(uint8 team);
    void RemoveNearbyObject(uint32 entry, Unit* unit);

    void SaveData();
    void LoadData();

};
#define sWarEffort WarEffort::instance()

#endif
