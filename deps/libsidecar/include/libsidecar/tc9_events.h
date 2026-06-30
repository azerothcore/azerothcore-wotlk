#ifndef TC9_EVENTS_H
#define TC9_EVENTS_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Event Structures for NATS Events
 */

/* Group Events */

typedef struct {
    uint32_t groupGuid;
    uint64_t leaderGuid;
    uint8_t lootMethod;
    uint64_t looterGuid;
    uint64_t* memberGuids;
    int memberCount;
} TC9EventGroupCreated;

typedef struct {
    uint32_t groupGuid;
    uint64_t memberGuid;
} TC9EventGroupMemberAdded;

typedef struct {
    uint32_t groupGuid;
    uint64_t memberGuid;
} TC9EventGroupMemberRemoved;

typedef struct {
    uint32_t groupGuid;
} TC9EventGroupDisbanded;

typedef struct {
    uint32_t groupGuid;
    uint8_t lootMethod;
    uint64_t looterGuid;
} TC9EventGroupLootTypeChanged;

typedef struct {
    uint32_t groupGuid;
    uint8_t difficulty;
} TC9EventGroupDungeonDifficultyChanged;

typedef struct {
    uint32_t groupGuid;
    uint8_t difficulty;
} TC9EventGroupRaidDifficultyChanged;

typedef struct {
    uint32_t groupGuid;
} TC9EventGroupConvertedToRaid;

/* Guild Events */

typedef struct {
    uint64_t guildGuid;
    uint64_t memberGuid;
} TC9EventGuildMemberAdded;

typedef struct {
    uint64_t guildGuid;
    uint64_t memberGuid;
} TC9EventGuildMemberLeft;

typedef struct {
    uint64_t guildGuid;
    uint64_t memberGuid;
} TC9EventGuildMemberRemoved;

/* Registry Events */

typedef struct {
    uint32_t* assignedMaps;
    int assignedMapsCount;
} TC9EventMapsReassigned;

/*
 * Event Hook Callback Types
 */

/* Group event hooks */
typedef void (*TC9OnGroupCreatedHook)(TC9EventGroupCreated event);
typedef void (*TC9OnGroupMemberAddedHook)(TC9EventGroupMemberAdded event);
typedef void (*TC9OnGroupMemberRemovedHook)(TC9EventGroupMemberRemoved event);
typedef void (*TC9OnGroupDisbandedHook)(TC9EventGroupDisbanded event);
typedef void (*TC9OnGroupLootTypeChangedHook)(TC9EventGroupLootTypeChanged event);
typedef void (*TC9OnGroupDungeonDifficultyChangedHook)(TC9EventGroupDungeonDifficultyChanged event);
typedef void (*TC9OnGroupRaidDifficultyChangedHook)(TC9EventGroupRaidDifficultyChanged event);
typedef void (*TC9OnGroupConvertedToRaidHook)(TC9EventGroupConvertedToRaid event);

/* Guild event hooks */
typedef void (*TC9OnGuildMemberAddedHook)(TC9EventGuildMemberAdded event);
typedef void (*TC9OnGuildMemberLeftHook)(TC9EventGuildMemberLeft event);
typedef void (*TC9OnGuildMemberRemovedHook)(TC9EventGuildMemberRemoved event);

/* Registry event hooks */
typedef void (*TC9OnMapsReassignedHook)(TC9EventMapsReassigned event);

#ifdef __cplusplus
}
#endif

#endif  // TC9_EVENTS_H
