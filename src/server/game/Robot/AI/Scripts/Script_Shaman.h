#ifndef ROBOT_STRATEGIES_SCRIPT_SHAMAN_H
#define ROBOT_STRATEGIES_SCRIPT_SHAMAN_H

#ifndef SHAMAN_RANGE_DISTANCE
# define SHAMAN_RANGE_DISTANCE 20
#endif

#ifndef SHAMAN_HEAL_DISTANCE
# define SHAMAN_HEAL_DISTANCE 30
#endif

#include "Script_Base.h"

enum ShamanEarthTotemType :uint32
{
    ShamanEarthTotemType_EarthbindTotem = 0,
    ShamanEarthTotemType_StoneskinTotem,
    ShamanEarthTotemType_StoneclawTotem,
    ShamanEarthTotemType_StrengthOfEarthTotem
};

class Script_Shaman :public Script_Base
{
public:
    Script_Shaman(Player* pmMe);    
    bool DPS(Unit* pmTarget, bool pmChase = true, bool pmAOE = false);
    bool Tank(Unit* pmTarget, bool pmChase, bool pmAOE = false);
    bool Heal(Unit* pmTarget);    
    bool Buff(Unit* pmTarget, bool pmCure = true);
    bool Assist();

    bool DPS_Enhancement(Unit* pmTarget, bool pmChase);
    bool DPS_Common(Unit* pmTarget, bool pmChase);    

    void Update(uint32 pmDiff);
    uint32 earthTotemType;
    int earthTotemCastDelay;
    int fireTotemCastDelay;
};
#endif
