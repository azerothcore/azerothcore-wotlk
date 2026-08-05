#ifndef __LIBSIDECAR_H__
#define __LIBSIDECAR_H__

#include <stdint.h>
#include <stdbool.h>

/* Export/import decoration for Windows DLL */
#ifdef _WIN32
    #ifdef TC9_BUILDING_DLL
        #define TC9_API __declspec(dllexport)
    #else
        #define TC9_API __declspec(dllimport)
    #endif
#else
    #ifdef TC9_BUILDING_DLL
        #define TC9_API __attribute__((visibility("default")))
    #else
        #define TC9_API
    #endif
#endif

/* Include all API headers */
#include "battleground-api.h"
#include "events-group.h"
#include "events-guild.h"
#include "events-servers-registry.h"
#include "monitoring.h"
#include "player-interactions-api.h"
#include "player-items-api.h"
#include "player-money-api.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Main library functions */
TC9_API void TC9InitLib(uint16_t port, uint32_t realmID, uint8_t isCrossRealm, char* availableMaps, uint32_t** assignedMaps, int* assignedMapsSize);
TC9_API void TC9GracefulShutdown();
TC9_API void TC9ProcessGRPCOrHTTPRequests();
TC9_API void TC9ProcessEventsHooks();

/* GUID generation */
TC9_API uint64_t TC9GetNextAvailableCharacterGuid(int realmID);
TC9_API uint64_t TC9GetNextAvailableItemGuid(int realmID);
TC9_API uint64_t TC9GetNextAvailableInstanceGuid(int realmID);

/* Map loading notification */
TC9_API void TC9ReadyToAcceptPlayersFromMaps(uint32_t* maps, int mapsLen);

/* Generic NATS pub/sub. Payloads are opaque bytes, subjects are arbitrary.
 * Subscription callbacks run on the thread draining TC9ProcessEventsHooks
 * (the world update thread), not on the NATS delivery thread. Both return
 * 0 on success, -1 on failure.
 *
 * Example — a mod broadcasting and consuming its own events:
 *
 *   // Publish (any thread):
 *   const char msg[] = "{\"zone\":1519,\"boss\":466}";
 *   TC9NatsPublish("mymod.boss.spawned", msg, sizeof(msg) - 1);
 *
 *   // Subscribe once at startup; the handler runs on the world update
 *   // thread, so it is safe to touch game state from it:
 *   void OnBossSpawned(const char* subject, const char* payload, int payloadLen)
 *   {
 *       std::string data(payload, payloadLen);  // payload is not NUL-terminated
 *       // ... react to the event ...
 *   }
 *   TC9NatsSubscribe("mymod.boss.spawned", &OnBossSpawned);
 */
typedef void (*TC9NatsMessageHandler)(const char* subject, const char* payload, int payloadLen);
TC9_API int TC9NatsPublish(const char* subject, const char* payload, int payloadLen);
TC9_API int TC9NatsSubscribe(const char* subject, TC9NatsMessageHandler handler);

/* Matchmaking notifications */
TC9_API void TC9PlayerLeftBattleground(uint64_t playerGUID, uint32_t realmID, uint32_t instanceID);
TC9_API void TC9BattlegroundStatusChanged(uint32_t instanceID, uint8_t status);

/* Event hooks registration */
TC9_API void TC9SetOnGroupCreatedHook(OnGroupCreatedHook h);
TC9_API void TC9SetOnGroupMemberAddedHook(OnGroupMemberAddedHook h);
TC9_API void TC9SetOnGroupMemberRemovedHook(OnGroupMemberRemovedHook h);
TC9_API void TC9SetOnGroupDisbandedHook(OnGroupDisbandedHook h);
TC9_API void TC9SetOnGroupLootTypeChangedHook(OnGroupLootTypeChangedHook h);
TC9_API void TC9SetOnGroupDungeonDifficultyChangedHook(OnGroupDungeonDifficultyChangedHook h);
TC9_API void TC9SetOnGroupRaidDifficultyChangedHook(OnGroupRaidDifficultyChangedHook h);
TC9_API void TC9SetOnGroupConvertedToRaidHook(OnGroupConvertedToRaidHook h);

TC9_API void TC9SetOnGuildMemberAddedHook(OnGuildMemberAddedHook h);
TC9_API void TC9SetOnGuildMemberRemovedHook(OnGuildMemberRemovedHook h);
TC9_API void TC9SetOnGuildMemberLeftHook(OnGuildMemberLeftHook h);

TC9_API void TC9SetOnMapsReassignedHook(OnMapsReassignedHook h);

/* Handler registration for gRPC requests */
TC9_API void TC9SetBattlegroundStartHandler(BattlegroundStartHandler h);
TC9_API void TC9SetBattlegroundAddPlayersHandler(BattlegroundAddPlayersHandler h);
TC9_API void TC9SetCanPlayerJoinBattlegroundQueueHandler(CanPlayerJoinBattlegroundQueueHandler h);
TC9_API void TC9SetCanPlayerTeleportToBattlegroundHandler(CanPlayerTeleportToBattlegroundHandler h);

TC9_API void TC9SetMonitoringDataCollectorHandler(MonitoringDataCollectorHandler h);

TC9_API void TC9SetCanPlayerInteractWithNPCAndFlagsHandler(CanPlayerInteractWithNPCAndFlagsHandler h);
TC9_API void TC9SetCanPlayerInteractWithGOAndTypeHandler(CanPlayerInteractWithGOAndTypeHandler h);

TC9_API void TC9SetGetPlayerItemsByGuidsHandler(GetPlayerItemsByGuidsHandler h);
TC9_API void TC9SetRemoveItemsWithGuidsFromPlayerHandler(RemoveItemsWithGuidsFromPlayerHandler h);
TC9_API void TC9SetAddExistingItemToPlayerHandler(AddExistingItemToPlayerHandler h);

TC9_API void TC9SetGetMoneyForPlayerHandler(GetMoneyForPlayerHandler h);
TC9_API void TC9SetModifyMoneyForPlayerHandler(ModifyMoneyForPlayerHandler h);

#ifdef __cplusplus
}
#endif

#endif /* __LIBSIDECAR_H__ */
