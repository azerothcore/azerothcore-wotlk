#ifndef AI_BASE_H
#define AI_BASE_H

#include "Script_Base.h"

class Script_Base;

enum GroupRole :uint32
{
    GroupRole_DPS = 0,
    GroupRole_Tank = 1,
    GroupRole_Healer = 2,
};

class AI_Base
{
public:
    AI_Base(Player* pmMe);
    void Reset();
    bool GroupInCombat();

    virtual void Update(uint32 pmDiff);
    virtual bool Engage(Unit* pmTarget);
    virtual bool DPS();
    virtual bool Tank();
    virtual bool Tank(Unit* pmTarget);
    virtual bool Rest();
    virtual bool Heal();
    virtual bool Buff();
    virtual bool Follow();
    virtual bool Stay(std::string pmTargetGroupRole);
    virtual bool Hold(std::string pmTargetGroupRole);
    virtual bool Chasing();
    virtual std::string GetGroupRoleName();
    virtual void SetGroupRole(std::string pmRoleName);    

public:
    Player* me;
    Script_Base* sb;
    uint32 groupRole;

    Unit* engageTarget;

    int eatDelay;
    int drinkDelay;
	
    int combatTime;    
    int teleportAssembleDelay;    
    int dpsDelay;
    int engageDelay;
    int pullDelay;
    int readyCheckDelay;
    float followDistance;
    bool staying;
    bool holding;
    bool following;
    bool cure;
    bool aoe;
    uint32 paladinAura;
    bool marked;
    Position markPos;
    Position basePos;
    int moveDelay;
    uint32 actionType;
    int actionDelay;
    int assistDelay;
};
#endif
