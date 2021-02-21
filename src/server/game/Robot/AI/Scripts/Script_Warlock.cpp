#include "Script_Warlock.h"
#include "Pet.h"
#include "PetAI.h"
#include "Group.h"
#include "RobotManager.h"

Script_Warlock::Script_Warlock(Player* pmMe) :Script_Base(pmMe)
{

}

bool Script_Warlock::Heal(Unit* pmTarget)
{
	return false;
}

bool Script_Warlock::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
{
	return false;
}

bool Script_Warlock::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
{
	bool meResult = false;
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
	if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 20)
	{
		if (me->GetHealthPct() > 50)
		{
			if (CastSpell(me, "Life Tap"))
			{
				return true;
			}
		}
	}
	 uint32 characterTalentTab = me->GetMaxTalentCountTab();
	switch (characterTalentTab)
	{
	case 0:
	{
		meResult = DPS_Affliction(pmTarget, pmChase);
		break;
	}
	case 1:
	{
		meResult = DPS_Demonology(pmTarget, pmChase);
		break;
	}
	case 2:
	{
		meResult = DPS_Destruction(pmTarget, pmChase);
		break;
	}
	default:
	{
		meResult = DPS_Common(pmTarget, pmChase);
		break;
	}
	}
	if (meResult)
	{
		PetAttack(pmTarget);
	}
	else
	{
		PetStop();
	}

	return meResult;
}

bool Script_Warlock::DPS_Common(Unit* pmTarget, bool pmChase)
{
	return DPS_Destruction(pmTarget, pmChase);
}

bool Script_Warlock::DPS_Affliction(Unit* pmTarget, bool pmChase)
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
	if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 10)
	{
		if (!me->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
		{
			if (CastSpell(pmTarget, "Shoot", WARLOCK_RANGE_DISTANCE))
			{
				return true;
			}
		}
	}
	if (CastSpell(pmTarget, "Shadow Bolt", WARLOCK_RANGE_DISTANCE))
	{
		return true;
	}

	return true;
}

bool Script_Warlock::DPS_Demonology(Unit* pmTarget, bool pmChase)
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
	if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 10)
	{
		if (!me->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
		{
			if (CastSpell(pmTarget, "Shoot", WARLOCK_RANGE_DISTANCE))
			{
				return true;
			}
		}
	}
	if (CastSpell(pmTarget, "Shadow Bolt", WARLOCK_RANGE_DISTANCE))
	{
		return true;
	}

	return true;
}

bool Script_Warlock::DPS_Destruction(Unit* pmTarget, bool pmChase)
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
	if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 10)
	{
		if (!me->GetCurrentSpell(CURRENT_AUTOREPEAT_SPELL))
		{
			if (CastSpell(pmTarget, "Shoot", WARLOCK_RANGE_DISTANCE))
			{
				return true;
			}
		}
	}
	// when facing boss 
	if (pmTarget->GetMaxHealth() / me->GetMaxHealth() > 10.0f)
	{
		if (CastSpell(pmTarget, "Curse of the Elements", WARLOCK_RANGE_DISTANCE, true))
		{
			return true;
		}
	}
	if (CastSpell(pmTarget, "Immolate", WARLOCK_RANGE_DISTANCE, true, true))
	{
		return true;
	}
	if (CastSpell(pmTarget, "Conflagrate", WARLOCK_RANGE_DISTANCE))
	{
		return true;
	}
	if (CastSpell(pmTarget, "Chaos Bolt", WARLOCK_RANGE_DISTANCE))
	{
		return true;
	}
	if (CastSpell(pmTarget, "Incinerate", WARLOCK_RANGE_DISTANCE))
	{
		return true;
	}

	if (CastSpell(pmTarget, "Shadow Bolt", WARLOCK_RANGE_DISTANCE))
	{
		return true;
	}

	return true;
}

bool Script_Warlock::Buff(Unit* pmTarget, bool pmCure)
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
        if (FindSpellID("Fel Armor") > 0)
        {
            if (CastSpell(me, "Fel Armor", WARLOCK_RANGE_DISTANCE, true))
            {
                return true;
            }
        }
        else
        {
            if (CastSpell(me, "Demon Armor", WARLOCK_RANGE_DISTANCE, true))
            {
                return true;
            }
        }
        if (petting)
        {
            Pet* myPet = me->GetPet();
            if (!myPet)
            {
                if (CastSpell(me, "Summon Imp"))
                {
                    return true;
                }
            }
        }
        else
        {
            if (Pet* myPet = me->GetPet())
            {
                myPet->DespawnOrUnsummon(500);
            }
        }
    }

    return false;
}
