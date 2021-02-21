#ifndef ROBOT_STRATEGIES_SCRIPT_BASE_H
#define ROBOT_STRATEGIES_SCRIPT_BASE_H

#ifndef DEFAULT_MOVEMENT_LIMIT_DELAY
# define DEFAULT_MOVEMENT_LIMIT_DELAY 5000
#endif

#include "Unit.h"
#include "Item.h"
#include "Player.h"
#include "RobotManager.h"

enum RobotMovementType :uint32
{
    RobotMovementType_None = 0,
    RobotMovementType_Point,
    RobotMovementType_Chase,
};

class RobotMovement
{
public:
    RobotMovement(Player* pmMe);
    void ResetMovement();
    void Update(uint32 pmDiff);

    bool Chase(Unit* pmChaseTarget, float pmChaseDistanceMax, float pmChaseDistanceMin, uint32 pmLimitDelay = DEFAULT_MOVEMENT_LIMIT_DELAY);
    void MovePosition(Position pmTargetPosition, uint32 pmLimitDelay = DEFAULT_MOVEMENT_LIMIT_DELAY);
    void MovePosition(float pmX, float pmY, float pmZ, uint32 pmLimitDelay = DEFAULT_MOVEMENT_LIMIT_DELAY);
    void MovePoint(float pmX, float pmY, float pmZ);

public:
    Player* me;
    Unit* chaseTarget;
    Position pointTarget;
    uint32 activeMovementType;
    float chaseDistanceMin;
    float chaseDistanceMax;
};

class Script_Base
{
public:
    Script_Base(Player* pmMe);
    void Initialize();
    virtual void Reset();
    virtual bool DPS(Unit* pmTarget, bool pmChase = true, bool pmAOE = false);
    virtual bool Tank(Unit* pmTarget, bool pmChase, bool pmAOE = false);
    virtual bool SubTank(Unit* pmTarget, bool pmChase);
    virtual bool Pull(Unit* pmTarget);
    virtual bool Taunt(Unit* pmTarget);
    virtual bool InterruptCasting(Unit* pmTarget);
    virtual bool Heal(Unit* pmTarget);
    virtual bool Cure(Unit* pmTarget);
    virtual bool SubHeal(Unit* pmTarget);
    virtual bool GroupHeal(float pmMaxHealthPercent = 60.0f);
    virtual bool Buff(Unit* pmTarget, bool pmCure = true);
    virtual bool Assist();
    virtual void Update(uint32 pmDiff);

    void PetAttack(Unit* pmTarget);
    void PetStop();

    Item* GetItemInInventory(uint32 pmEntry);
    bool UseItem(Item* pmItem, Unit* pmTarget);
    bool UseHealingPotion();
    bool UseManaPotion();
    uint32 FindSpellID(std::string pmSpellName);
    bool SpellValid(uint32 pmSpellID);
    bool CastSpell(Unit* pmTarget, std::string pmSpellName, float pmDistance = DEFAULT_VISIBILITY_DISTANCE, bool pmCheckAura = false, bool pmOnlyMyAura = false, bool pmClearShapeShift = false);
    void ClearShapeshift();
    void CancelAura(uint32 pmSpellID);
    bool CancelAura(std::string pmSpellName);
    bool Eat();
    bool Drink();
    bool Chase(Unit* pmTarget, float pmMaxDistance = MELEE_MAX_DISTANCE, float pmMinDistance = MELEE_MIN_DISTANCE);
    bool Follow(Unit* pmTarget, float pmDistance = FOLLOW_MIN_DISTANCE);
    void ChooseTarget(Unit* pmTarget);
    void ClearTarget();

    Player* me;
    RobotMovement* rm;
    std::unordered_map<std::string, uint32> spellIDMap;
    std::unordered_map<std::string, uint8> spellLevelMap;

    // 0 dps, 1 tank, 2 healer
    uint32 characterType;
    bool petting;
    float chaseDistanceMin;
    float chaseDistanceMax;
    int rti;
};
#endif
