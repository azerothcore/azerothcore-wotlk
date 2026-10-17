#include "events-servers-registry.h"

// MapsReassignedHook
OnMapsReassignedHook mapsReassignedHook;
void SetOnMapsReassignedHook(OnMapsReassignedHook h) {
    mapsReassignedHook = h;
}

int CallOnMapsReassignedHook(uint32_t* maps_added, int maps_added_size, uint32_t* maps_removed, int maps_removed_size) {
    if (mapsReassignedHook == 0) {
        return ServersRegistryHookStatusNoHook;
    }
    mapsReassignedHook(maps_added, maps_added_size, maps_removed, maps_removed_size);
    return ServersRegistryHookStatusOK;
}
