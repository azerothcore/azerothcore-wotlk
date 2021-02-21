#include "Script_Base.h"
#include "RobotConfig.h"
#include "AI_Base.h"
#include "MapManager.h"
#include "Pet.h"
#include "PetAI.h"
#include "Bag.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "MotionMaster.h"
#include "GridNotifiers.h"
#include "Group.h"
#include "SpellAuraEffects.h"

RobotMovement::RobotMovement(Player* pmMe)
{
    me = pmMe;
    chaseTarget = NULL;
    activeMovementType = RobotMovementType::RobotMovementType_None;
    chaseDistanceMin = CONTACT_DISTANCE;
    chaseDistanceMax = DEFAULT_VISIBILITY_DISTANCE;
}

void RobotMovement::ResetMovement()
{
    chaseTarget = NULL;
    activeMovementType = RobotMovementType::RobotMovementType_None;
    chaseDistanceMin = CONTACT_DISTANCE;
    chaseDistanceMax = DEFAULT_VISIBILITY_DISTANCE;
    if (me)
    {
        me->GetMotionMaster()->Clear();
        me->StopMoving();
    }
}

bool RobotMovement::Chase(Unit* pmChaseTarget, float pmChaseDistanceMax, float pmChaseDistanceMin, uint32 pmLimitDelay)
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (me->HasAuraType(SPELL_AURA_MOD_PACIFY))
    {
        return false;
    }
    if (me->HasUnitState(UnitState::UNIT_STATE_NOT_MOVE))
    {
        return false;
    }
    if (me->IsNonMeleeSpellCast(false))
    {
        return false;
    }
    if (!pmChaseTarget)
    {
        return false;
    }
    if (me->GetMapId() != pmChaseTarget->GetMapId())
    {
        return false;
    }
    float unitTargetDistance = me->GetDistance(pmChaseTarget);
    if (unitTargetDistance > DEFAULT_VISIBILITY_DISTANCE)
    {
        return false;
    }
    if (pmChaseTarget->GetTypeId() == TypeID::TYPEID_PLAYER)
    {
        if (Player* targetPlayer = pmChaseTarget->ToPlayer())
        {
            if (targetPlayer->IsBeingTeleported())
            {
                return false;
            }
        }
    }
    chaseDistanceMax = pmChaseDistanceMax;
    chaseDistanceMin = pmChaseDistanceMin;
    if (activeMovementType == RobotMovementType::RobotMovementType_Chase)
    {
        if (chaseTarget)
        {
            if (chaseTarget->GetGUID() == pmChaseTarget->GetGUID())
            {
                return true;
            }
        }
    }
    if (me->isMoving())
    {
        me->StopMoving();
        me->GetMotionMaster()->Clear();
    }
    chaseTarget = pmChaseTarget;
    activeMovementType = RobotMovementType::RobotMovementType_Chase;

    if (me->getStandState() != UnitStandStateType::UNIT_STAND_STATE_STAND)
    {
        me->SetStandState(UnitStandStateType::UNIT_STAND_STATE_STAND);
    }
    if (unitTargetDistance >= chaseDistanceMin && unitTargetDistance <= chaseDistanceMax + MIN_DISTANCE_GAP)
    {
        if (me->IsWithinLOSInMap(chaseTarget))
        {
            if (!me->isInFront(chaseTarget, M_PI / 4))
            {
                me->SetFacingToObject(chaseTarget);
            }
        }
    }
    else
    {
        float distanceInRange = frand(chaseDistanceMin, chaseDistanceMax);
        float nearX = 0, nearY = 0, nearZ = 0;
        chaseTarget->GetNearPoint(me, nearX, nearY, nearZ, MIN_DISTANCE_GAP, distanceInRange, chaseTarget->GetAbsoluteAngle(me->GetPosition()));
        me->GetMotionMaster()->MovePoint(0, nearX, nearY, nearZ, true, me->GetAbsoluteAngle(chaseTarget->GetPosition()));
    }
    return true;
}

void RobotMovement::MovePosition(Position pmTargetPosition, uint32 pmLimitDelay)
{
    MovePosition(pmTargetPosition.m_positionX, pmTargetPosition.m_positionY, pmTargetPosition.m_positionZ, pmLimitDelay);
}

void RobotMovement::MovePosition(float pmX, float pmY, float pmZ, uint32 pmLimitDelay)
{
    if (!me)
    {
        return;
    }
    if (!me->IsAlive())
    {
        return;
    }
    if (me->HasAuraType(SPELL_AURA_MOD_PACIFY))
    {
        return;
    }
    if (me->HasUnitState(UnitState::UNIT_STATE_NOT_MOVE))
    {
        return;
    }
    if (me->IsNonMeleeSpellCast(false))
    {
        return;
    }
    if (me->IsBeingTeleported())
    {
        ResetMovement();
        return;
    }
    if (activeMovementType == RobotMovementType::RobotMovementType_Point)
    {
        float dx = pointTarget.m_positionX - pmX;
        float dy = pointTarget.m_positionY - pmY;
        float dz = pointTarget.m_positionZ - pmZ;
        float gap = sqrt((dx * dx) + (dy * dy) + (dz * dz));
        if (gap < CONTACT_DISTANCE)
        {
            return;
        }
    }
    float distance = me->GetDistance(pmX, pmY, pmZ);
    if (distance >= 0.0f && distance <= DEFAULT_VISIBILITY_DISTANCE)
    {
        pointTarget.m_positionX = pmX;
        pointTarget.m_positionY = pmY;
        pointTarget.m_positionZ = pmZ;
        activeMovementType = RobotMovementType::RobotMovementType_Point;
        MovePoint(pointTarget.m_positionX, pointTarget.m_positionY, pointTarget.m_positionZ);
    }
}

void RobotMovement::MovePoint(float pmX, float pmY, float pmZ)
{
    if (me)
    {
        if (me->getStandState() != UnitStandStateType::UNIT_STAND_STATE_STAND)
        {
            me->SetStandState(UnitStandStateType::UNIT_STAND_STATE_STAND);
        }
        me->GetMotionMaster()->MovePoint(0, pmX, pmY, pmZ);
    }
}

void RobotMovement::Update(uint32 pmDiff)
{
    if (!me)
    {
        return;
    }
    if (!me->IsAlive())
    {
        return;
    }
    if (me->HasAuraType(SPELL_AURA_MOD_PACIFY))
    {
        return;
    }
    if (me->HasUnitState(UnitState::UNIT_STATE_NOT_MOVE))
    {
        return;
    }
    if (me->IsNonMeleeSpellCast(false))
    {
        return;
    }
    if (me->IsBeingTeleported())
    {
        ResetMovement();
        return;
    }
    switch (activeMovementType)
    {
    case RobotMovementType::RobotMovementType_None:
    {
        break;
    }
    case RobotMovementType::RobotMovementType_Point:
    {
        float distance = me->GetDistance(pointTarget);
        if (distance > DEFAULT_VISIBILITY_DISTANCE || distance < CONTACT_DISTANCE)
        {
            ResetMovement();
        }
        else
        {
            if (!me->isMoving())
            {
                MovePoint(pointTarget.m_positionX, pointTarget.m_positionY, pointTarget.m_positionZ);
            }
        }
        break;
    }
    case RobotMovementType::RobotMovementType_Chase:
    {
        if (!chaseTarget)
        {
            ResetMovement();
            break;
        }
        if (me->GetMapId() != chaseTarget->GetMapId())
        {
            ResetMovement();
            break;
        }
        if (chaseTarget->GetTypeId() == TypeID::TYPEID_PLAYER)
        {
            if (Player* targetPlayer = chaseTarget->ToPlayer())
            {
                if (!targetPlayer->IsInWorld())
                {
                    ResetMovement();
                    break;
                }
                else if (targetPlayer->IsBeingTeleported())
                {
                    ResetMovement();
                    break;
                }
            }
        }
        float unitTargetDistance = me->GetDistance(chaseTarget);
        if (unitTargetDistance > DEFAULT_VISIBILITY_DISTANCE)
        {
            ResetMovement();
            break;
        }
        bool ok = false;
        if (unitTargetDistance >= chaseDistanceMin && unitTargetDistance <= chaseDistanceMax + MIN_DISTANCE_GAP)
        {
            if (me->IsWithinLOSInMap(chaseTarget))
            {
                if (me->isMoving())
                {
                    me->StopMoving();
                }
                if (!me->isInFront(chaseTarget, M_PI / 4))
                {
                    me->SetFacingToObject(chaseTarget);
                }
                ok = true;
            }
        }
        if (!ok)
        {
            if (me->isMoving())
            {
                ok = true;
            }
        }
        if (!ok)
        {
            if (me->getStandState() != UnitStandStateType::UNIT_STAND_STATE_STAND)
            {
                me->SetStandState(UnitStandStateType::UNIT_STAND_STATE_STAND);
            }
            float distanceInRange = frand(chaseDistanceMin, chaseDistanceMax);
            float nearX = 0, nearY = 0, nearZ = 0;
            chaseTarget->GetNearPoint(me, nearX, nearY, nearZ, MIN_DISTANCE_GAP, distanceInRange, chaseTarget->GetAbsoluteAngle(me->GetPosition()));
            me->GetMotionMaster()->MovePoint(0, nearX, nearY, nearZ, true, me->GetAbsoluteAngle(chaseTarget->GetPosition()));
        }
        break;
    }
    default:
    {
        break;
    }
    }
}

Script_Base::Script_Base(Player* pmMe)
{
    me = pmMe;
    rm = new RobotMovement(me);
    spellIDMap.clear();
    spellLevelMap.clear();
    characterType = 0;
    petting = true;

    chaseDistanceMin = MELEE_MIN_DISTANCE;
    chaseDistanceMax = MELEE_MAX_DISTANCE;

    rti = -1;
}

void Script_Base::Initialize()
{
    spellLevelMap.clear();
    for (PlayerSpellMap::iterator it = me->GetSpellMap().begin(); it != me->GetSpellMap().end(); it++)
    {
        const SpellInfo* pS = sSpellMgr->GetSpellInfo(it->first);
        if (pS)
        {
            std::string checkNameStr = std::string(pS->SpellName[0]);
            if (spellLevelMap.find(checkNameStr) == spellLevelMap.end())
            {
                spellLevelMap[checkNameStr] = pS->BaseLevel;
                spellIDMap[checkNameStr] = it->first;
            }
            else
            {
                if (pS->BaseLevel > spellLevelMap[checkNameStr])
                {
                    spellLevelMap[checkNameStr] = pS->BaseLevel;
                    spellIDMap[checkNameStr] = it->first;
                }
            }
        }
    }
}

void Script_Base::Reset()
{
    rti = -1;
    rm->ResetMovement();
    ClearTarget();
}

void Script_Base::Update(uint32 pmDiff)
{
    rm->Update(pmDiff);
    return;
}

bool Script_Base::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    return false;
}

bool Script_Base::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    return false;
}

bool Script_Base::Pull(Unit* pmTarget)
{
    return false;
}

bool Script_Base::SubTank(Unit* pmTarget, bool pmChase)
{
    if (!pmTarget)
    {
        return false;
    }
    else if (!pmTarget->IsAlive())
    {
        return false;
    }
    if (!me)
    {
        return false;
    }
    if (!me->IsValidAttackTarget(pmTarget))
    {
        return false;
    }
    if (me->GetDistance(pmTarget) > ATTACK_RANGE_LIMIT)
    {
        return false;
    }
    if (pmChase)
    {
        if (!Chase(pmTarget))
        {
            return false;
        }
    }
    else
    {
        if (!me->isInFront(pmTarget, M_PI / 16))
        {
            me->SetFacingToObject(pmTarget);
        }
    }
    if (me->GetHealthPct() < 20.0f)
    {
        UseHealingPotion();
    }
    me->Attack(pmTarget, true);
    return true;
}

bool Script_Base::Taunt(Unit* pmTarget)
{
    return false;
}

bool Script_Base::InterruptCasting(Unit* pmTarget)
{
    return false;
}

bool Script_Base::Heal(Unit* pmTarget)
{
    return false;
}

bool Script_Base::Cure(Unit* pmTarget)
{
    return false;
}

bool Script_Base::SubHeal(Unit* pmTarget)
{
    return false;
}

bool Script_Base::GroupHeal(float pmMaxHealthPercent)
{
    return false;
}

bool Script_Base::Buff(Unit* pmTarget, bool pmCure)
{
    return false;
}

bool Script_Base::Assist()
{
    return false;
}

Item* Script_Base::GetItemInInventory(uint32 pmEntry)
{
    if (!me)
    {
        return NULL;
    }
    for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item* pItem = me->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (pItem)
        {
            if (pItem->GetEntry() == pmEntry)
            {
                return pItem;
            }
        }
    }

    for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        if (Bag* pBag = (Bag*)me->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            for (uint32 j = 0; j < pBag->GetBagSize(); j++)
            {
                Item* pItem = me->GetItemByPos(i, j);
                if (pItem)
                {
                    if (pItem->GetEntry() == pmEntry)
                    {
                        return pItem;
                    }
                }
            }
        }
    }

    return NULL;
}

bool Script_Base::UseItem(Item* pmItem, Unit* pmTarget)
{
    if (!me)
    {
        return false;
    }
    if (me->CanUseItem(pmItem) != EQUIP_ERR_OK)
    {
        return false;
    }

    if (me->IsNonMeleeSpellCast(true))
    {
        return false;
    }

    if (const ItemTemplate* proto = pmItem->GetTemplate())
    {
        SpellCastTargets targets;
        targets.Update(pmTarget);
        me->CastItemUseSpell(pmItem, targets, 1, 0);
        return true;
    }

    return false;
}

bool Script_Base::Follow(Unit* pmTarget, float pmDistance)
{
    if (!me)
    {
        return false;
    }
    if (me->HasAuraType(SPELL_AURA_MOD_PACIFY))
    {
        return false;
    }
    if (me->HasUnitState(UnitState::UNIT_STATE_NOT_MOVE))
    {
        return false;
    }
    if (me->IsNonMeleeSpellCast(false))
    {
        return false;
    }
    return rm->Chase(pmTarget, pmDistance, 0.0f);
}

bool Script_Base::Chase(Unit* pmTarget, float pmMaxDistance, float pmMinDistance)
{
    if (!me)
    {
        return false;
    }
    if (rm->Chase(pmTarget, pmMaxDistance, pmMinDistance))
    {
        ChooseTarget(pmTarget);
        return true;
    }
    return false;
}

uint32 Script_Base::FindSpellID(std::string pmSpellName)
{
    if (spellIDMap.find(pmSpellName) != spellIDMap.end())
    {
        return spellIDMap[pmSpellName];
    }

    return 0;
}

bool Script_Base::SpellValid(uint32 pmSpellID)
{
    if (pmSpellID == 0)
    {
        return false;
    }
    if (!me)
    {
        return false;
    }
    if (me->HasSpellCooldown(pmSpellID))
    {
        return false;
    }
    return true;
}

bool Script_Base::CastSpell(Unit* pmTarget, std::string pmSpellName, float pmDistance, bool pmCheckAura, bool pmOnlyMyAura, bool pmClearShapeShift)
{
    if (!me)
    {
        return false;
    }
    if (me->IsNonMeleeSpellCast(true, false, true))
    {
        return true;
    }
    if (!pmTarget)
    {
        return false;
    }
    if (pmTarget->GetGUID() != me->GetGUID())
    {
        float actualDistance = me->GetDistance(pmTarget);
        if (actualDistance > pmDistance)
        {
            return false;
        }
    }
    if (!me->IsWithinLOSInMap(pmTarget))
    {
        return false;
    }
    if (pmClearShapeShift)
    {
        ClearShapeshift();
    }
    uint32 spellID = FindSpellID(pmSpellName);
    if (!SpellValid(spellID))
    {
        return false;
    }
    const SpellInfo* pS = sSpellMgr->GetSpellInfo(spellID);
    if (!pS)
    {
        return false;
    }
    if (pmTarget->IsImmunedToSpell(pS))
    {
        return false;
    }
    for (size_t i = 0; i < MAX_SPELL_REAGENTS; i++)
    {
        if (pS->Reagent[i] > 0)
        {
            if (!me->HasItemCount(pS->Reagent[i], pS->ReagentCount[i]))
            {
                me->StoreNewItemInBestSlots(pS->Reagent[i], pS->ReagentCount[i] * 10);
            }
        }
    }
    if (me->getStandState() != UnitStandStateType::UNIT_STAND_STATE_STAND)
    {
        me->SetStandState(UNIT_STAND_STATE_STAND);
    }
    if (pmCheckAura)
    {
        if (pmOnlyMyAura)
        {
            if (sRobotManager->HasAura(pmTarget, pmSpellName, me))
            {
                return false;
            }
        }
        else
        {
            if (sRobotManager->HasAura(pmTarget, pmSpellName))
            {
                return false;
            }
        }
    }
    if (!me->isInFront(pmTarget, pmDistance))
    {
        me->SetFacingToObject(pmTarget);
    }
    if (me->GetTarget() != pmTarget->GetGUID())
    {
        ChooseTarget(pmTarget);
    }
    SpellCastResult scr = me->CastSpell(pmTarget, pS->Id);
    if (scr == SpellCastResult::SPELL_CAST_OK)
    {
        return true;
    }
    else
    {
        //std::ostringstream scrStream;
        //scrStream << enum_to_string(scr);
        //me->Say(scrStream.str(), Language::LANG_UNIVERSAL);
    }

    return false;
}

void Script_Base::ClearShapeshift()
{
    if (!me)
    {
        return;
    }
    uint32 spellID = 0;
    switch (me->GetShapeshiftForm())
    {
    case ShapeshiftForm::FORM_NONE:
    {
        break;
    }
    case ShapeshiftForm::FORM_CAT:
    {
        spellID = FindSpellID("Cat Form");
        break;
    }
    case ShapeshiftForm::FORM_DIREBEAR:
    {
        spellID = FindSpellID("Dire Bear Form");
        break;
    }
    case ShapeshiftForm::FORM_BEAR:
    {
        spellID = FindSpellID("Bear Form");
        break;
    }
    case ShapeshiftForm::FORM_MOONKIN:
    {
        spellID = FindSpellID("Moonkin Form");
        break;
    }
    default:
    {
        break;
    }
    }
    CancelAura(spellID);
}

bool Script_Base::CancelAura(std::string pmSpellName)
{
    if (!me)
    {
        return false;
    }
    std::set<uint32> spellIDSet = sRobotManager->spellNameEntryMap[pmSpellName];
    for (std::set<uint32>::iterator it = spellIDSet.begin(); it != spellIDSet.end(); it++)
    {
        if (me->HasAura((*it)))
        {
            CancelAura((*it));
            return true;
        }
    }

    return false;
}

void Script_Base::CancelAura(uint32 pmSpellID)
{
    if (pmSpellID == 0)
    {
        return;
    }
    if (!me)
    {
        return;
    }
    const SpellInfo* pS = sSpellMgr->GetSpellInfo(pmSpellID);
    if (!pS)
    {
        return;
    }
    // not allow remove spells with attr SPELL_ATTR0_CANT_CANCEL
    if (pS->HasAttribute(SPELL_ATTR0_CANT_CANCEL))
        return;

    // channeled spell case (it currently cast then)
    if (pS->IsChanneled())
    {
        if (Spell* curSpell = me->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            if (curSpell->m_spellInfo->Id == pmSpellID)
                me->InterruptSpell(CURRENT_CHANNELED_SPELL);
        return;
    }

    // non channeled case:
    // don't allow remove non positive spells
    // don't allow cancelling passive auras (some of them are visible)
    if (!pS->IsPositive() || pS->IsPassive())
        return;

    // maybe should only remove one buff when there are multiple?
    me->RemoveOwnedAura(pmSpellID, 0, 0, AURA_REMOVE_BY_CANCEL);
}

bool Script_Base::Eat()
{
    bool result = false;

    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (me->IsInCombat())
    {
        return false;
    }
    uint32 foodEntry = 0;
    uint32 myLevel = me->getLevel();
    if (myLevel >= 80)
    {
        foodEntry = 35950;
    }
    else if (myLevel >= 75)
    {
        foodEntry = 35950;
    }
    else if (myLevel >= 65)
    {
        foodEntry = 33451;
    }
    else if (myLevel >= 55)
    {
        foodEntry = 27854;
    }
    else if (myLevel >= 45)
    {
        foodEntry = 8932;
    }
    else if (myLevel >= 35)
    {
        foodEntry = 3927;
    }
    else if (myLevel >= 25)
    {
        foodEntry = 1707;
    }
    else if (myLevel >= 15)
    {
        foodEntry = 422;
    }
    else
    {
        return false;
    }
    if (!me->HasItemCount(foodEntry, 1))
    {
        me->StoreNewItemInBestSlots(foodEntry, 20);
    }

    me->CombatStop(true);
    me->GetMotionMaster()->Clear();
    me->StopMoving();
    ClearTarget();

    Item* pFood = GetItemInInventory(foodEntry);
    if (pFood && !pFood->IsInTrade())
    {
        if (UseItem(pFood, me))
        {
            rm->ResetMovement();
            result = true;
        }
    }

    return result;
}

bool Script_Base::Drink()
{
    bool result = false;

    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (me->IsInCombat())
    {
        return false;
    }
    uint32 drinkEntry = 0;
    uint32 myLevel = me->getLevel();
    if (myLevel >= 80)
    {
        drinkEntry = 33445;
    }
    else if (myLevel >= 75)
    {
        drinkEntry = 33445;
    }
    else if (myLevel >= 70)
    {
        drinkEntry = 33444;
    }
    else if (myLevel >= 65)
    {
        drinkEntry = 35954;
    }
    else if (myLevel >= 60)
    {
        drinkEntry = 28399;
    }
    else if (myLevel >= 45)
    {
        drinkEntry = 8766;
    }
    else if (myLevel >= 45)
    {
        drinkEntry = 8766;
    }
    else if (myLevel >= 35)
    {
        drinkEntry = 1645;
    }
    else if (myLevel >= 25)
    {
        drinkEntry = 1708;
    }
    else if (myLevel >= 15)
    {
        drinkEntry = 1205;
    }

    if (!me->HasItemCount(drinkEntry, 1))
    {
        me->StoreNewItemInBestSlots(drinkEntry, 20);
    }
    me->CombatStop(true);
    me->GetMotionMaster()->Clear();
    me->StopMoving();
    ClearTarget();
    Item* pDrink = GetItemInInventory(drinkEntry);
    if (pDrink && !pDrink->IsInTrade())
    {
        if (UseItem(pDrink, me))
        {
            rm->ResetMovement();
            result = true;
        }
    }

    return result;
}

void Script_Base::PetAttack(Unit* pmTarget)
{
    if (me)
    {
        if (Pet* myPet = me->GetPet())
        {
            if (CharmInfo* pci = myPet->GetCharmInfo())
            {
                if (!pci->IsCommandAttack())
                {
                    pci->SetIsCommandAttack(true);
                    CreatureAI* AI = myPet->ToCreature()->AI();
                    if (PetAI* petAI = dynamic_cast<PetAI*>(AI))
                    {
                        petAI->AttackStart(pmTarget);
                    }
                    else
                    {
                        AI->AttackStart(pmTarget);
                    }
                }
            }
        }
    }
}

void Script_Base::PetStop()
{
    // EJ debug
    return;
    if (me)
    {
        if (Pet* myPet = me->GetPet())
        {
            myPet->AttackStop();
            if (CharmInfo* pci = myPet->GetCharmInfo())
            {
                if (pci->IsCommandAttack())
                {
                    pci->SetIsCommandAttack(false);
                }
                if (!pci->IsCommandFollow())
                {
                    pci->SetIsCommandFollow(true);
                }
            }
        }
    }
}

bool Script_Base::UseHealingPotion()
{
    bool result = false;

    if (!me)
    {
        return false;
    }
    if (!me->IsInCombat())
    {
        return false;
    }
    uint32 itemEntry = 0;
    uint32 myLevel = me->getLevel();
    if (myLevel >= 70)
    {
        itemEntry = 33447;
    }
    else if (myLevel >= 55)
    {
        itemEntry = 22829;
    }
    else if (myLevel >= 45)
    {
        itemEntry = 13446;
    }
    else if (myLevel >= 35)
    {
        itemEntry = 3928;
    }
    else if (myLevel >= 21)
    {
        itemEntry = 1710;
    }
    else if (myLevel >= 12)
    {
        itemEntry = 929;
    }
    else
    {
        itemEntry = 118;
    }
    if (!me->HasItemCount(itemEntry, 1))
    {
        me->StoreNewItemInBestSlots(itemEntry, 20);
    }
    Item* pItem = GetItemInInventory(itemEntry);
    if (pItem && !pItem->IsInTrade())
    {
        if (UseItem(pItem, me))
        {
            result = true;
        }
    }

    return result;
}

bool Script_Base::UseManaPotion()
{
    bool result = false;

    if (!me)
    {
        return false;
    }
    if (!me->IsInCombat())
    {
        return false;
    }
    uint32 itemEntry = 0;
    uint32 myLevel = me->getLevel();
    if (myLevel >= 70)
    {
        itemEntry = 33448;
    }
    else if (myLevel >= 55)
    {
        itemEntry = 22832;
    }
    else if (myLevel >= 49)
    {
        itemEntry = 13444;
    }
    else if (myLevel >= 41)
    {
        itemEntry = 13443;
    }
    else if (myLevel >= 31)
    {
        itemEntry = 6149;
    }
    else if (myLevel >= 22)
    {
        itemEntry = 3827;
    }
    else if (myLevel >= 14)
    {
        itemEntry = 3385;
    }
    else
    {
        itemEntry = 2455;
    }
    if (!me->HasItemCount(itemEntry, 1))
    {
        me->StoreNewItemInBestSlots(itemEntry, 20);
    }
    Item* pItem = GetItemInInventory(itemEntry);
    if (pItem && !pItem->IsInTrade())
    {
        if (UseItem(pItem, me))
        {
            result = true;
        }
    }

    return result;
}

void Script_Base::ChooseTarget(Unit* pmTarget)
{
    if (pmTarget)
    {
        if (me)
        {
            me->SetSelection(pmTarget->GetGUID());
            me->SetTarget(pmTarget->GetGUID());
        }
    }
}

void Script_Base::ClearTarget()
{
    if (me)
    {
        me->SetSelection(0);
        me->SetTarget(0);
    }
}
