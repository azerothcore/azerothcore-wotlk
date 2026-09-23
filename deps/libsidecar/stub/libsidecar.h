#ifndef __LIBSIDECAR_H__
#define __LIBSIDECAR_H__

#include <stdint.h>
#include <stdbool.h>

/* Compile-time version macros (vendored with real headers under include/) */
#include "tc9_version.h"

/* Include all API headers */
#include "battleground-api.h"
#include "events-group.h"
#include "events-guild.h"
#include "events-servers-registry.h"
#include "monitoring.h"
#include "player-interactions-api.h"
#include "player-items-api.h"
#include "player-money-api.h"
#include "player-guild-api.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Version APIs (implemented by stub without panic; real lib reports its build) */
void TC9GetVersion(int* major, int* minor, int* patch);
const char* TC9GetVersionString(void);
int TC9CheckAbiCompatible(int required_major, int required_minor);

/* Main library functions */
void TC9InitLib(uint16_t port, uint32_t realmID, uint8_t isCrossRealm, char* availableMaps, uint32_t** assignedMaps, int* assignedMapsSize);
void TC9GracefulShutdown();
void TC9ProcessGRPCOrHTTPRequests();
void TC9ProcessEventsHooks();

/* GUID generation */
uint64_t TC9GetNextAvailableCharacterGuid(int realmID);
uint64_t TC9GetNextAvailableItemGuid(int realmID);
uint64_t TC9GetNextAvailableInstanceGuid(int realmID);

/* Map loading notification */
void TC9ReadyToAcceptPlayersFromMaps(uint32_t* maps, int mapsLen);

/* Generic NATS pub/sub for in-process extensions. Subscribe callbacks run
 * on the thread that calls TC9ProcessEventsHooks. Call after TC9InitLib.
 * Both return 0 on success, -1 on error. */
typedef void (*TC9NatsMessageHandler)(const char* subject, const char* payload, int payloadLen);
int TC9NatsPublish(const char* subject, const char* payload, int payloadLen);
int TC9NatsSubscribe(const char* subject, TC9NatsMessageHandler handler);

/* Matchmaking notifications */
void TC9PlayerLeftBattleground(uint64_t playerGUID, uint32_t realmID, uint32_t instanceID);
void TC9BattlegroundStatusChanged(uint32_t instanceID, uint8_t status);

/* Event hooks registration */
void TC9SetOnGroupCreatedHook(OnGroupCreatedHook h);
void TC9SetOnGroupMemberAddedHook(OnGroupMemberAddedHook h);
void TC9SetOnGroupMemberRemovedHook(OnGroupMemberRemovedHook h);
void TC9SetOnGroupDisbandedHook(OnGroupDisbandedHook h);
void TC9SetOnGroupLootTypeChangedHook(OnGroupLootTypeChangedHook h);
void TC9SetOnGroupDungeonDifficultyChangedHook(OnGroupDungeonDifficultyChangedHook h);
void TC9SetOnGroupRaidDifficultyChangedHook(OnGroupRaidDifficultyChangedHook h);
void TC9SetOnGroupConvertedToRaidHook(OnGroupConvertedToRaidHook h);

void TC9SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h);
void TC9SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h);
void TC9SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h);
void TC9SetOnGuildCreatedHook(OnGuildCreatedHook h);

void TC9SetOnMapsReassignedHook(OnMapsReassignedHook h);

/* Handler registration for gRPC requests */
void TC9SetBattlegroundStartHandler(BattlegroundStartHandler h);
void TC9SetBattlegroundAddPlayersHandler(BattlegroundAddPlayersHandler h);
void TC9SetCanPlayerJoinBattlegroundQueueHandler(CanPlayerJoinBattlegroundQueueHandler h);
void TC9SetCanPlayerTeleportToBattlegroundHandler(CanPlayerTeleportToBattlegroundHandler h);

void TC9SetMonitoringDataCollectorHandler(MonitoringDataCollectorHandler h);

void TC9SetCanPlayerInteractWithNPCAndFlagsHandler(CanPlayerInteractWithNPCAndFlagsHandler h);
void TC9SetCanPlayerInteractWithGOAndTypeHandler(CanPlayerInteractWithGOAndTypeHandler h);

void TC9SetGetPlayerItemsByGuidsHandler(GetPlayerItemsByGuidsHandler h);
void TC9SetGetPlayerItemByPosHandler(GetPlayerItemByPosHandler h);
void TC9SetRemoveItemsWithGuidsFromPlayerHandler(RemoveItemsWithGuidsFromPlayerHandler h);
void TC9SetDestroyItemsWithGuidsFromPlayerHandler(DestroyItemsWithGuidsFromPlayerHandler h);
void TC9SetAddExistingItemToPlayerHandler(AddExistingItemToPlayerHandler h);
void TC9SetStoreNewItemHandler(StoreNewItemHandler h);
void TC9SetSetItemPermanentEnchantmentHandler(SetItemPermanentEnchantmentHandler h);

void TC9SetGetMoneyForPlayerHandler(GetMoneyForPlayerHandler h);
void TC9SetModifyMoneyForPlayerHandler(ModifyMoneyForPlayerHandler h);

void TC9SetSetPlayerGuildFieldsHandler(SetPlayerGuildFieldsHandler h);

#ifdef __cplusplus
}
#endif

#endif /* __LIBSIDECAR_H__ */
