#include "Script_Shaman.h"

Script_Shaman::Script_Shaman(Player* pmMe) :Script_Base(pmMe)
{
    earthTotemType = ShamanEarthTotemType::ShamanEarthTotemType_StoneskinTotem;
    earthTotemCastDelay = 0;
    fireTotemCastDelay = 0;
}

bool Script_Shaman::Assist()
{
    return false;
}

bool Script_Shaman::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    return false;
}

bool Script_Shaman::Heal(Unit* pmTarget)
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
    if (!me->IsAlive())
    {
        return false;
    }
    if (me->GetDistance(pmTarget) > SHAMAN_HEAL_DISTANCE)
    {
        return false;
    }
    float healthPCT = pmTarget->GetHealthPct();
    if (healthPCT < 80.0f)
    {
        if (CastSpell(pmTarget, "Healing Wave", SHAMAN_HEAL_DISTANCE))
        {
            return true;
        }
    }
    return false;
}

bool Script_Shaman::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
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
        return DPS_Common(pmTarget, pmChase);
    }
    case 1:
    {
        return DPS_Enhancement(pmTarget, pmChase);
    }
    case 2:
    {
        return DPS_Common(pmTarget, pmChase);
    }
    default:
        return DPS_Common(pmTarget, pmChase);
    }

    return true;
}

bool Script_Shaman::DPS_Enhancement(Unit* pmTarget, bool pmChase)
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
        if (!Chase(pmTarget))
        {
            return false;
        }
    }
    me->Attack(pmTarget, true);
    if (targetDistance < INTERACTION_DISTANCE)
    {
        if (CastSpell(pmTarget, "Flame Shock", SHAMAN_RANGE_DISTANCE, true, true))
        {
            return true;
        }
        if (CastSpell(me, "Berserking", SHAMAN_RANGE_DISTANCE))
        {
            return true;
        }
        if (CastSpell(me, "Lightning Shield", SHAMAN_RANGE_DISTANCE, true))
        {
            return true;
        }
    }
    //if (CastSpell(me, "Fire Nova Totem", SHAMAN_RANGE_DISTANCE))
    //{
    //    return true;
    //}
    return true;
}

bool Script_Shaman::DPS_Common(Unit* pmTarget, bool pmChase)
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
    if (CastSpell(pmTarget, "Lightning Bolt", SHAMAN_RANGE_DISTANCE))
    {
        return true;
    }

    return true;
}

bool Script_Shaman::Buff(Unit* pmTarget, bool pmCure)
{
    if (!pmTarget)
    {
        return false;
    }
    if (pmTarget->GetGUID() == me->GetGUID())
    {
        if (CastSpell(me, "Lightning Shield", SHAMAN_RANGE_DISTANCE, true))
        {
            return true;
        }
    }
    return false;
}

void Script_Shaman::Update(uint32 pmDiff)
{
    if (earthTotemCastDelay > 0)
    {
        earthTotemCastDelay -= pmDiff;
    }
    if (fireTotemCastDelay > 0)
    {
        fireTotemCastDelay -= pmDiff;
    }
    Script_Base::Update(pmDiff);
}
