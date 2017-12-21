#ifndef __DYNAMICVISIBILITY_H
#define __DYNAMICVISIBILITY_H

#include "Common.h"

struct VisibilitySettingData
{
    uint32 visibilityNotifyDelay;
    uint32 aiNotifyDelay;
    float requiredMoveDistanceSq;
};

// pussywizard: dynamic visibility settings
// 7 player intervals: 0-499, 500-999, 1000-1499, 1500-1999, 2000-2499, 2500-2999, 3000+
// 5 map types: common, instance, raid, bg, arena
// feel free to add more intervals, change existing ones or move to conf file :P
#define VISIBILITY_SETTINGS_PLAYER_INTERVAL 500
#define VISIBILITY_SETTINGS_MAX_INTERVAL_NUM 7
const VisibilitySettingData VisibilitySettings[VISIBILITY_SETTINGS_MAX_INTERVAL_NUM][5] =
{
    { {300, 150, 1.0f}, {300, 150, 1.0f}, {300, 150, 1.0f}, {300, 150, 1.0f}, {300, 150, 1.0f} }, // 0-499
    { {400, 200, 2.25f}, {400, 200, 2.25f}, {400, 200, 2.25f}, {300, 150, 1.0f}, {300, 150, 1.0f} }, // 500-999
    { {500, 250, 4.0f}, {500, 250, 4.0f}, {500, 250, 4.0f}, {400, 200, 2.25f}, {300, 150, 1.0f} }, // 1000-1499
    { {700, 350, 6.25f}, {700, 350, 6.25f}, {700, 350, 6.25f}, {600, 300, 6.25f}, {300, 200, 1.0f} }, // 1500-1999
    { {1000, 500, 16.0f}, {1000, 500, 16.0f}, {1000, 500, 16.0f}, {1000, 500, 16.0f}, {300, 250, 1.0f} }, // 2000-2499
    { {1000, 500, 16.0f}, {1000, 500, 16.0f}, {1000, 500, 16.0f}, {1000, 500, 16.0f}, {300, 350, 1.0f} }, // 2500-2999
    { {1200, 550, 20.0f}, {1200, 550, 25.0f}, {1200, 550, 25.0f}, {1100, 550, 16.0f}, {300, 350, 1.0f} } // 3000+
};

class DynamicVisibilityMgr
{
public:
    static void Update(uint32 sessionCount);
    static uint32 GetVisibilityNotifyDelay(uint32 map_type) { return VisibilitySettings[visibilitySettingsIndex][map_type].visibilityNotifyDelay; }
    static uint32 GetAINotifyDelay(uint32 map_type) { return VisibilitySettings[visibilitySettingsIndex][map_type].aiNotifyDelay; }
    static float GetReqMoveDistSq(uint32 map_type) { return VisibilitySettings[visibilitySettingsIndex][map_type].requiredMoveDistanceSq; }
protected:
    static uint8 visibilitySettingsIndex;
};

#endif
