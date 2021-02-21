#include "Script_Rogue.h"

Script_Rogue::Script_Rogue(Player* pmMe) :Script_Base(pmMe)
{

}

bool Script_Rogue::Heal(Unit* pmTarget)
{
	return false;
}

bool Script_Rogue::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
{
	return false;
}

bool Script_Rogue::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
{
	if (!me)
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
		return DPS_Common(pmTarget, pmChase);
	}
	case 1:
	{
		return DPS_Combat(pmTarget, pmChase);
	}
	case 2:
	{
		return DPS_Common(pmTarget, pmChase);
	}
	default:
		return DPS_Common(pmTarget, pmChase);
	}
}

bool Script_Rogue::DPS_Combat(Unit* pmTarget, bool pmChase)
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
	me->Attack(pmTarget, true);
	uint32 energy = me->GetPower(Powers::POWER_ENERGY);
	if (energy > 25)
	{
		if (pmTarget->IsNonMeleeSpellCast(false))
		{
			if (CastSpell(pmTarget, "Kick", MELEE_MAX_DISTANCE))
			{
				return true;
			}
		}
	}
	// when facing boss 
	if (pmTarget->GetMaxHealth() / me->GetMaxHealth() > 5.0f)
	{
		if (CastSpell(pmTarget, "Adrenaline Rush", MELEE_MAX_DISTANCE))
		{
			me->Yell("ADRENALINE RUSH !", Language::LANG_UNIVERSAL);
			return true;
		}
		if (energy > 25)
		{
			if (CastSpell(me, "Blade Flurry", MELEE_MAX_DISTANCE))
			{
				return true;
			}
		}
	}

	if (energy > 10)
	{
		if (CastSpell(pmTarget, "Riposte", MELEE_MAX_DISTANCE))
		{
			return true;
		}
	}
	if (energy > 50)
	{
		uint8 comboPoints = me->GetComboPoints();
		if (urand(1, 5) <= comboPoints)
		{
			CastSpell(pmTarget, "Eviscerate", MELEE_MAX_DISTANCE);
			return true;
		}
		if (CastSpell(pmTarget, "Sinister Strike", MELEE_MAX_DISTANCE))
		{
			return true;
		}
	}

	return true;
}

bool Script_Rogue::DPS_Common(Unit* pmTarget, bool pmChase)
{
	return DPS_Combat(pmTarget, pmChase);
}

bool Script_Rogue::Buff(Unit* pmTarget, bool pmCure)
{
	return false;
}

bool Script_Rogue::InterruptCasting(Unit* pmTarget)
{
	if (me)
	{
		uint32 energy = me->GetPower(Powers::POWER_ENERGY);
		if (energy > 25)
		{
			if (pmTarget->IsNonMeleeSpellCast(false))
			{
				if (CastSpell(pmTarget, "Kick", MELEE_MAX_DISTANCE))
				{
					return true;
				}
			}
		}
	}
	return false;
}
