#ifndef __EVENT_GROUP__
#define __EVENT_GROUP__

#include <stdint.h>
#include <stdlib.h>

enum GroupStatus {
    GroupHookStatusOK = 0,
    GroupHookStatusNoHook = 1
};

typedef struct {
    uint32_t guid;
    uint64_t leader;
    uint8_t lootMethod;
    uint64_t looterGuid;
    uint8_t lootThreshold;
    uint8_t groupType;
    uint8_t difficulty;
    uint8_t raidDifficulty;
    uint64_t masterLooterGuid;
    uint64_t *members;
    uint8_t membersSize;
} EventObjectGroup;

typedef void (*OnGroupCreatedHook) (EventObjectGroup *group);
void SetOnGroupCreatedHook(OnGroupCreatedHook h);
int CallOnGroupCreatedHook(EventObjectGroup *group);

typedef void (*OnGroupMemberAddedHook) (uint32_t guid, uint64_t newMemberGuid);
void SetOnGroupMemberAddedHook(OnGroupMemberAddedHook h);
int CallOnGroupMemberAddedHook(uint32_t guid, uint64_t newMemberGuid);

typedef void (*OnGroupMemberRemovedHook) (uint32_t guid, uint64_t removedMemberGuid, uint64_t newLeaderGuid);
void SetOnGroupMemberRemovedHook(OnGroupMemberRemovedHook h);
int CallOnGroupMemberRemovedHook(uint32_t guid, uint64_t removedMemberGuid, uint64_t newLeaderGuid);

typedef void (*OnGroupDisbandedHook) (uint32_t guid);
void SetOnGroupDisbandedHook(OnGroupDisbandedHook h);
int CallOnGroupDisbandedHook(uint32_t guid);

typedef void (*OnGroupLootTypeChangedHook) (uint32_t guid, uint8_t lootMethod, uint64_t looter, uint8_t lootThreshold);
void SetOnGroupLootTypeChangedHook(OnGroupLootTypeChangedHook h);
int CallOnGroupLootTypeChangedHook(uint32_t guid, uint8_t lootMethod, uint64_t looter, uint8_t lootThreshold);

typedef void (*OnGroupDungeonDifficultyChangedHook) (uint32_t guid, uint8_t difficulty);
void SetOnGroupDungeonDifficultyChangedHook(OnGroupDungeonDifficultyChangedHook h);
int CallOnGroupDungeonDifficultyChangedHook(uint32_t guid, uint8_t difficulty);

typedef void (*OnGroupRaidDifficultyChangedHook) (uint32_t guid, uint8_t difficulty);
void SetOnGroupRaidDifficultyChangedHook(OnGroupRaidDifficultyChangedHook h);
int CallOnGroupRaidDifficultyChangedHook(uint32_t guid, uint8_t difficulty);

typedef void (*OnGroupConvertedToRaidHook) (uint32_t guid);
void SetOnGroupConvertedToRaidHook(OnGroupConvertedToRaidHook h);
int CallOnGroupConvertedToRaidHook(uint32_t guid);

#endif
