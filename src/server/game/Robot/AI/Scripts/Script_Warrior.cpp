#include "Script_Warrior.h"
#include "Group.h"
#include "RobotManager.h"

Script_Warrior::Script_Warrior(Player* pmMe) :Script_Base(pmMe)
{

}

bool Script_Warrior::Heal(Unit* pmTarget)
{
    return false;
}

bool Script_Warrior::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (!me->IsValidAttackTarget(pmTarget))
    {
        return false;
    }
    if (!pmTarget)
    {
        return false;
    }
    if (!pmTarget->IsAlive())
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
        if (!Chase(pmTarget))
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
    if (targetDistance < WARRIOR_CHARGE_DISTANCE)
    {
        if (CastSpell(me, "Bloodrage"))
        {
            return true;
        }
    }
    if (me->GetHealthPct() < 40.0f)
    {
        if (CastSpell(me, "Shield Wall"))
        {
            return true;
        }
    }
    me->Attack(pmTarget, true);
    uint32 rage = me->GetPower(Powers::POWER_RAGE);
    if (rage > 100)
    {
        if (CastSpell(me, "Battle Shout", MELEE_MAX_DISTANCE, true))
        {
            return true;
        }
        if (CastSpell(pmTarget, "Demoralizing Shout", MELEE_MAX_DISTANCE, true))
        {
            return true;
        }
    }
    if (rage > 100)
    {
        uint32 meleeOTCount = 0;
        if (Group* myGroup = me->GetGroup())
        {
            std::unordered_set<Unit*> myAttackerSet = me->getAttackers();
            for (std::unordered_set<Unit*>::iterator maIT = myAttackerSet.begin(); maIT != myAttackerSet.end(); maIT++)
            {
                if (Unit* eachAttacker = *maIT)
                {
                    if (me->GetDistance(eachAttacker) < MELEE_MAX_DISTANCE)
                    {
                        if (eachAttacker->GetTarget() != me->GetGUID())
                        {
                            meleeOTCount++;
                        }
                    }
                }
            }
        }
        if (meleeOTCount > 2)
        {
            if (CastSpell(pmTarget, "Challenging Shout", MELEE_MAX_DISTANCE, true, true))
            {
                return true;
            }
        }
        if (CastSpell(pmTarget, "Rend", MELEE_MAX_DISTANCE, true, true))
        {
            return true;
        }
        if (CastSpell(pmTarget, "Revenge"))
        {
            return true;
        }
    }
    if (rage > 200)
    {
        if (sRobotManager->GetAuraStack(pmTarget, "Sunder Armor") < 5)
        {
            if (CastSpell(pmTarget, "Sunder Armor"))
            {
                return true;
            }
        }
        if (CastSpell(pmTarget, "Heroic Strike"))
        {
            return true;
        }
    }

    return true;
}

bool Script_Warrior::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (me->GetHealthPct() < 20.0f)
    {
        UseHealingPotion();
    }
    uint32 characterTalentTab = me->GetMaxTalentCountTab();
    switch (characterTalentTab)
    {
    case 0:
    {
        return DPS_Arms(pmTarget, pmChase);
    }
    case 1:
    {
        return DPS_Fury(pmTarget, pmChase);
    }
    case 2:
    {
        return DPS_Common(pmTarget, pmChase);
    }
    default:
    {
        return DPS_Common(pmTarget, pmChase);
    }
    }
}

bool Script_Warrior::DPS_Common(Unit* pmTarget, bool pmChase)
{
    return DPS_Arms(pmTarget, pmChase);
}

bool Script_Warrior::DPS_Arms(Unit* pmTarget, bool pmChase)
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
        if (!Chase(pmTarget))
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
    if (targetDistance < WARRIOR_CHARGE_DISTANCE)
    {
        if (CastSpell(me, "Bloodrage"))
        {
            return true;
        }
    }
    me->Attack(pmTarget, true);
    uint32 rage = me->GetPower(Powers::POWER_RAGE);
    if (rage > 300)
    {
        CastSpell(pmTarget, "Heroic Strike");
        if (CastSpell(pmTarget, "Mortal Strike", MELEE_MAX_DISTANCE, true))
        {
            return true;
        }
    }
    if (rage > 100)
    {
        if (CastSpell(me, "Battle Shout", MELEE_MAX_DISTANCE, true))
        {
            return true;
        }
        //if (CastSpell(pmTarget, "Demoralizing Shout", MELEE_MAX_DISTANCE, true))
        //{
        //	return true;
        //}
        if (CastSpell(pmTarget, "Rend", MELEE_MAX_DISTANCE, true, true))
        {
            return true;
        }
        if (CastSpell(pmTarget, "Overpower"))
        {
            return true;
        }
        if (pmTarget->GetHealthPct() < 30.0f)
        {
            if (CastSpell(pmTarget, "Hamstring", MELEE_MAX_DISTANCE, true))
            {
                return true;
            }
        }
    }
    CastSpell(pmTarget, "Heroic Strike");

    return true;
}

bool Script_Warrior::DPS_Fury(Unit* pmTarget, bool pmChase)
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
        if (!Chase(pmTarget))
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
    if (targetDistance < WARRIOR_CHARGE_DISTANCE)
    {
        if (CastSpell(me, "Bloodrage"))
        {
            return true;
        }
        if (CastSpell(me, "Recklessness"))
        {
            return true;
        }
    }
    me->Attack(pmTarget, true);
    uint32 rage = me->GetPower(Powers::POWER_RAGE);
    if (rage > 100)
    {
        if (pmTarget->IsNonMeleeSpellCast(false))
        {
            if (CastSpell(pmTarget, "Pummel"))
            {
                return true;
            }
        }
        if (CastSpell(me, "Battle Shout", MELEE_MAX_DISTANCE, true))
        {
            return true;
        }
        if (pmTarget->GetHealthPct() < 30.0f)
        {
            if (CastSpell(pmTarget, "Hamstring", MELEE_MAX_DISTANCE, true))
            {
                return true;
            }
        }
    }
    if (rage > 250)
    {
        if (CastSpell(pmTarget, "Bloodthirst"))
        {
            return true;
        }
        if (CastSpell(pmTarget, "Whirlwind"))
        {
            return true;
        }
        if (CastSpell(pmTarget, "Cleave"))
        {
            return true;
        }
    }

    return true;
}

bool Script_Warrior::Buff(Unit* pmTarget, bool pmCure)
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
    if (me->GetGUID() == pmTarget->GetGUID())
    {
        uint32 characterTalentTab = me->GetMaxTalentCountTab();
        switch (characterTalentTab)
        {
        case 0:
        {
            if (CastSpell(me, "Battle Stance", MELEE_MAX_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        case 1:
        {
            if (me->getLevel() >= 20)
            {
                if (CastSpell(me, "Berserker Stance", MELEE_MAX_DISTANCE, true))
                {
                    return true;
                }
            }
            else
            {
                if (CastSpell(me, "Battle Stance", MELEE_MAX_DISTANCE, true))
                {
                    return true;
                }
            }
            break;
        }
        case 2:
        {
            if (me->getLevel() >= 10)
            {
                if (CastSpell(me, "Defensive Stance", MELEE_MAX_DISTANCE, true))
                {
                    return true;
                }
            }
            else
            {
                if (CastSpell(me, "Battle Stance", MELEE_MAX_DISTANCE, true))
                {
                    return true;
                }
            }
            break;
        }
        default:
        {
            if (CastSpell(me, "Battle Stance", MELEE_MAX_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        }
    }

    return false;
}
