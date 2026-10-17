#ifndef __EVENT_SERVERS_REGISTRY__
#define __EVENT_SERVERS_REGISTRY__

#include <stdint.h>

enum ServersRegistryStatus {
    ServersRegistryHookStatusOK = 0,
    ServersRegistryHookStatusNoHook = 1
};

typedef void (*OnMapsReassignedHook) (uint32_t* /*maps_added*/, int /*maps_added_size*/, uint32_t* /*maps_removed*/, int /*maps_removed_size*/);
void SetOnMapsReassignedHook(OnMapsReassignedHook h);
int CallOnMapsReassignedHook(uint32_t* maps_added, int maps_added_size, uint32_t* maps_removed, int maps_removed_size);

#endif
