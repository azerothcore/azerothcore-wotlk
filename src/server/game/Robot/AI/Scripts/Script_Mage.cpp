#include "Script_Mage.h"
#include "Group.h"
#include "SpellMgr.h"
#include "RobotManager.h"
#include "MotionMaster.h"

Script_Mage::Script_Mage(Player* pmMe) :Script_Base(pmMe)
{

}

bool Script_Mage::Heal(Unit* pmTarget)
{
    return false;
}

bool Script_Mage::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    return false;
}

bool Script_Mage::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 30)
    {
        UseManaPotion();
    }
     uint32 characterTalentTab = me->GetMaxTalentCountTab();
    switch (characterTalentTab)
    {
    case 0:
    {
        return DPS_Arcane(pmTarget, pmChase);
    }
    case 1:
    {
        return DPS_Fire(pmTarget, pmChase);
    }
    case 2:
    {
        return DPS_Frost(pmTarget, pmChase);
    }
    default:
    {
        break;
    }
    }
    return false;
}

bool Script_Mage::Assist()
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (rti >= 0 && rti < TARGETICONCOUNT)
    {
        if (Group* myGroup = me->GetGroup())
        {
            if (Unit* assistTarget = ObjectAccessor::GetUnit(*me, myGroup->GetOGByTargetIcon(rti)))
            {
                if (assistTarget->IsAlive())
                {
                    if (me->IsValidAttackTarget(assistTarget))
                    {
                        if (assistTarget->GetCreatureType() == CreatureType::CREATURE_TYPE_HUMANOID)
                        {
                            uint32 duration = sRobotManager->GetAuraDuration(assistTarget, "Polymorph");
                            if (duration < 3000)
                            {
                                if (me->GetDistance(assistTarget) < MAGE_RANGE_DISTANCE)
                                {
                                    CastSpell(assistTarget, "Polymorph", MAGE_RANGE_DISTANCE);
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return false;
}

bool Script_Mage::DPS_Common(Unit* pmTarget, bool pmChase)
{
    return DPS_Frost(pmTarget, pmChase);
}

bool Script_Mage::DPS_Arcane(Unit* pmTarget, bool pmChase)
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
    else if (!me->IsValidAttackTarget(pmTarget))
    {
        return false;
    }
    float targetDistance = me->GetDistance(pmTarget);
    if (pmChase)
    {
        if (targetDistance > ATTACK_RANGE_LIMIT)
        {
            return false;
        }
        if (!Chase(pmTarget, FOLLOW_FAR_DISTANCE))
        {
            return false;
        }
    }
    else
    {
        if (targetDistance > RANGED_MAX_DISTANCE)
        {
            return false;
        }
        if (!me->isInFront(pmTarget, M_PI / 16))
        {
            me->SetFacingToObject(pmTarget);
        }
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 20)
    {
        if (CastSpell(me, "Evocation", MAGE_RANGE_DISTANCE))
        {
            return true;
        }
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 10)
    {
        if (!me->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
        {
            if (CastSpell(pmTarget, "Shoot", MAGE_RANGE_DISTANCE))
            {
                return true;
            }
        }
    }
    if (CastSpell(pmTarget, "Arcane Missiles", MAGE_RANGE_DISTANCE))
    {
        return true;
    }

    return true;
}

bool Script_Mage::DPS_Fire(Unit* pmTarget, bool pmChase)
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
    else if (!me->IsValidAttackTarget(pmTarget))
    {
        return false;
    }
    float targetDistance = me->GetDistance(pmTarget);
    if (pmChase)
    {
        if (targetDistance > ATTACK_RANGE_LIMIT)
        {
            return false;
        }
        if (!Chase(pmTarget, FOLLOW_FAR_DISTANCE))
        {
            return false;
        }
    }
    else
    {
        if (targetDistance > RANGED_MAX_DISTANCE)
        {
            return false;
        }
        if (!me->isInFront(pmTarget, M_PI / 16))
        {
            me->SetFacingToObject(pmTarget);
        }
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 20)
    {
        if (CastSpell(me, "Evocation", MAGE_RANGE_DISTANCE))
        {
            return true;
        }
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 10)
    {
        if (!me->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
        {
            if (CastSpell(pmTarget, "Shoot", MAGE_RANGE_DISTANCE))
            {
                return true;
            }
        }
    }
    if (CastSpell(pmTarget, "Fireball", MAGE_RANGE_DISTANCE))
    {
        return true;
    }

    return true;
}

bool Script_Mage::DPS_Frost(Unit* pmTarget, bool pmChase)
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
    else if (!me->IsValidAttackTarget(pmTarget))
    {
        return false;
    }
    float targetDistance = me->GetDistance(pmTarget);
    if (targetDistance > ATTACK_RANGE_LIMIT)
    {
        return false;
    }
    if (pmChase)
    {
        if (!Chase(pmTarget, FOLLOW_FAR_DISTANCE))
        {
            return false;
        }
    }
    else
    {
        if (targetDistance > RANGED_MAX_DISTANCE)
        {
            return false;
        }
        if (!me->isInFront(pmTarget, M_PI / 16))
        {
            me->SetFacingToObject(pmTarget);
        }
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 20)
    {
        if (CastSpell(me, "Evocation", MAGE_RANGE_DISTANCE))
        {
            return true;
        }
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 10)
    {
        if (!me->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
        {
            if (CastSpell(pmTarget, "Shoot", MAGE_RANGE_DISTANCE))
            {
                return true;
            }
        }
    }
    if (CastSpell(pmTarget, "Frostbolt", MAGE_RANGE_DISTANCE))
    {
        return true;
    }

    return true;
}

bool Script_Mage::Buff(Unit* pmTarget, bool pmCure)
{
    if (!pmTarget)
    {
        return false;
    }
    if (!pmTarget->IsAlive())
    {
        return false;
    }
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (me->GetDistance(pmTarget) < MAGE_RANGE_DISTANCE)
    {
        if (!sRobotManager->HasAura(pmTarget, "Arcane Intellect"))
        {
            if (CastSpell(pmTarget, "Arcane Intellect", MAGE_RANGE_DISTANCE, true))
            {
                return true;
            }
        }
    }

    return false;
}
