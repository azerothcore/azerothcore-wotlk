#ifndef ROBOT_STRATEGIES_SCRIPT_MAGE_H
#define ROBOT_STRATEGIES_SCRIPT_MAGE_H

#ifndef MAGE_RANGE_DISTANCE
# define MAGE_RANGE_DISTANCE 30
#endif

#include "Script_Base.h"

class Script_Mage :public Script_Base
{
public:    
    Script_Mage(Player* pmMe);
    bool DPS(Unit* pmTarget, bool pmChase = true, bool pmAOE = false);
    bool Tank(Unit* pmTarget, bool pmChase, bool pmAOE = false);
    bool Heal(Unit* pmTarget);
    bool Buff(Unit* pmTarget, bool pmCure = true);
    bool Assist();

    bool DPS_Common(Unit* pmTarget, bool pmChase);
    bool DPS_Frost(Unit* pmTarget, bool pmChase);
    bool DPS_Fire(Unit* pmTarget, bool pmChase);
    bool DPS_Arcane(Unit* pmTarget, bool pmChase);
};
#endif
