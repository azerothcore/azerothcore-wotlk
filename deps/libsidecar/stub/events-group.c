#include "events-group.h"

// OnGroupCreatedHook
OnGroupCreatedHook groupCreatedHook;
void SetOnGroupCreatedHook(OnGroupCreatedHook h) {
    groupCreatedHook = h;
}

int CallOnGroupCreatedHook(EventObjectGroup *group) {
    if (groupCreatedHook == 0) {
        return GroupHookStatusNoHook;
    }
    groupCreatedHook(group);
    return GroupHookStatusOK;
}

// GroupMemberAdded
static OnGroupMemberAddedHook groupMemberAddedHook;
void SetOnGroupMemberAddedHook(OnGroupMemberAddedHook h) {
    groupMemberAddedHook = h;
}

int CallOnGroupMemberAddedHook(uint32_t guid, uint64_t newMemberGuid) {
    if (groupCreatedHook == 0) {
        return GroupHookStatusNoHook;
    }
    groupMemberAddedHook(guid, newMemberGuid);
    return GroupHookStatusOK;
}

// GroupMemberRemoved
static OnGroupMemberRemovedHook groupMemberRemovedHook;
void SetOnGroupMemberRemovedHook(OnGroupMemberRemovedHook h) {
    groupMemberRemovedHook = h;
}

int CallOnGroupMemberRemovedHook(uint32_t guid, uint64_t removedMemberGuid, uint64_t newLeaderGuid) {
    if (groupMemberRemovedHook == 0) {
        return GroupHookStatusNoHook;
    }
    groupMemberRemovedHook(guid, removedMemberGuid, newLeaderGuid);
    return GroupHookStatusOK;
}


typedef void (*OnGroupDisbandedHook) (uint32_t guid);
void SetOnGroupDisbandedHook(OnGroupDisbandedHook h);
int CallOnGroupDisbandedHook(uint32_t guid);

static OnGroupDisbandedHook groupDisbandedHook;
void SetOnGroupDisbandedHook(OnGroupDisbandedHook h) {
    groupDisbandedHook = h;
}

int CallOnGroupDisbandedHook(uint32_t guid) {
    if (groupDisbandedHook == 0) {
        return GroupHookStatusNoHook;
    }
    groupDisbandedHook(guid);
    return GroupHookStatusOK;
}

static OnGroupLootTypeChangedHook groupLootTypeChanged;
void SetOnGroupLootTypeChangedHook(OnGroupLootTypeChangedHook h) {
    groupLootTypeChanged = h;
}

int CallOnGroupLootTypeChangedHook(uint32_t guid, uint8_t lootMethod, uint64_t looter, uint8_t lootThreshold) {
    if (groupLootTypeChanged == 0) {
        return GroupHookStatusNoHook;
    }
    groupLootTypeChanged(guid, lootMethod, looter, lootThreshold);
    return GroupHookStatusOK;
}

static OnGroupDungeonDifficultyChangedHook groupDungeonDifficultyChanged;
void SetOnGroupDungeonDifficultyChangedHook(OnGroupDungeonDifficultyChangedHook h) {
    groupDungeonDifficultyChanged = h;
}

int CallOnGroupDungeonDifficultyChangedHook(uint32_t guid, uint8_t difficulty) {
    if (groupDungeonDifficultyChanged == 0) {
        return GroupHookStatusNoHook;
    }
    groupDungeonDifficultyChanged(guid, difficulty);
    return GroupHookStatusOK;
}

static OnGroupRaidDifficultyChangedHook groupRaidDifficultyChanged;
void SetOnGroupRaidDifficultyChangedHook(OnGroupRaidDifficultyChangedHook h) {
    groupRaidDifficultyChanged = h;
}

int CallOnGroupRaidDifficultyChangedHook(uint32_t guid, uint8_t difficulty) {
    if (groupRaidDifficultyChanged == 0) {
        return GroupHookStatusNoHook;
    }
    groupRaidDifficultyChanged(guid, difficulty);
    return GroupHookStatusOK;
}

typedef void (*OnGroupConvertedToRaidHook) (uint32_t guid);
void SetOnGroupConvertedToRaidHook(OnGroupConvertedToRaidHook h);
int CallOnGroupConvertedToRaidHook(uint32_t guid);

static OnGroupConvertedToRaidHook groupConvertedToRaid;
void SetOnGroupConvertedToRaidHook(OnGroupConvertedToRaidHook h) {
    groupConvertedToRaid = h;
}

int CallOnGroupConvertedToRaidHook(uint32_t guid) {
    if (groupConvertedToRaid == 0) {
        return GroupHookStatusNoHook;
    }
    groupConvertedToRaid(guid);
    return GroupHookStatusOK;
}
