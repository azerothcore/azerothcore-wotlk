#include "Script_Priest.h"
#include "SpellMgr.h"
#include "RobotManager.h"
#include "Group.h"
#include "SpellInfo.h"
#include "SpellAuraEffects.h"

Script_Priest::Script_Priest(Player* pmMe) :Script_Base(pmMe)
{

}

bool Script_Priest::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
{
    return false;
}

bool Script_Priest::SubHeal(Unit* pmTarget)
{
    if (!pmTarget)
    {
        return false;
    }
    else if (!pmTarget->IsAlive())
    {
        return false;
    }
    if (pmTarget->HasAura(27827))
    {
        return false;
    }
    if (!me)
    {
        return false;
    }
    if (me->GetDistance(pmTarget) > PRIEST_HEAL_DISTANCE)
    {
        return false;
    }
    float healthPCT = pmTarget->GetHealthPct();
    if (healthPCT < 90.0f)
    {
        if (CastSpell(pmTarget, "Renew", PRIEST_HEAL_DISTANCE, true, true))
        {
            return true;
        }
    }
    if (healthPCT < 30.0f)
    {
        if (CastSpell(pmTarget, "Flash Heal", PRIEST_HEAL_DISTANCE))
        {
            return true;
        }
    }
}

bool Script_Priest::Heal(Unit* pmTarget)
{
    if (!me)
    {
        return false;
    }
    if (!me->IsAlive())
    {
        return false;
    }
    if (pmTarget->HasAura(27827))
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
        return Heal_Holy(pmTarget);
    }
    case 1:
    {
        return Heal_Holy(pmTarget);
    }
    case 2:
    {
        return Heal_Holy(pmTarget);
    }
    default:
        return Heal_Holy(pmTarget);
    }

    return false;
}

bool Script_Priest::Heal_Holy(Unit* pmTarget)
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
    if (me->GetDistance(pmTarget) > PRIEST_HEAL_DISTANCE)
    {
        return false;
    }
    // EJ debug
    //if (CastSpell(pmTarget, "Greater Heal", PRIEST_HEAL_DISTANCE))
    //{
    //    return true;
    //}

    float healthPCT = pmTarget->GetHealthPct();
    if (healthPCT > 50.0f && healthPCT < 90.0f)
    {
        if (CastSpell(pmTarget, "Renew", PRIEST_HEAL_DISTANCE, true, true))
        {
            return true;
        }
    }
    if (healthPCT < 40.0f)
    {
        if (CastSpell(pmTarget, "Desperate Prayer", PRIEST_HEAL_DISTANCE))
        {
            return true;
        }
        if (!sRobotManager->HasAura(pmTarget, "Weakened Soul"))
        {
            if (pmTarget->IsInCombat())
            {
                if (CastSpell(pmTarget, "Power Word: Shield", PRIEST_HEAL_DISTANCE))
                {
                    return true;
                }
            }
        }
    }
    if (healthPCT < 50.0f)
    {
        if (CastSpell(pmTarget, "Flash Heal", PRIEST_HEAL_DISTANCE))
        {
            return true;
        }
    }
    if (healthPCT < 80.0f)
    {
        if (CastSpell(pmTarget, "Greater Heal", PRIEST_HEAL_DISTANCE))
        {
            return true;
        }
        if (CastSpell(pmTarget, "Heal", PRIEST_HEAL_DISTANCE))
        {
            return true;
        }
    }

    return false;
}

bool Script_Priest::Cure(Unit* pmTarget)
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
    if (me->GetDistance(pmTarget) > PRIEST_HEAL_DISTANCE)
    {
        return false;
    }
    for (uint32 type = SPELL_AURA_NONE; type < TOTAL_AURAS; ++type)
    {
        std::list<AuraEffect*> auraList = pmTarget->GetAuraEffectsByType((AuraType)type);
        for (auto auraIT = auraList.begin(), end = auraList.end(); auraIT != end; ++auraIT)
        {
            const SpellInfo* pST = (*auraIT)->GetSpellInfo();
            if (!pST->IsPositive())
            {
                if (pST->Dispel == DispelType::DISPEL_DISEASE)
                {
                    if (CastSpell(pmTarget, "Cure Disease", PRIEST_HEAL_DISTANCE))
                    {
                        return true;
                    }
                }
                if (pST->Dispel == DispelType::DISPEL_MAGIC)
                {
                    if (CastSpell(pmTarget, "Dispel Magic", PRIEST_HEAL_DISTANCE))
                    {
                        return true;
                    }
                }
            }
        }
    }

    return false;
}

bool Script_Priest::GroupHeal(float pmMaxHealthPercent)
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
        return GroupHeal_Holy(pmMaxHealthPercent);
    }
    case 1:
    {
        return GroupHeal_Holy(pmMaxHealthPercent);
    }
    case 2:
    {
        return GroupHeal_Holy(pmMaxHealthPercent);
    }
    default:
        return GroupHeal_Holy(pmMaxHealthPercent);
    }

    return false;
}

bool Script_Priest::GroupHeal_Holy(float pmMaxHealthPercent)
{
    if (!me)
    {
        return false;
    }
    if (CastSpell(me, "Circle of Healing", PRIEST_HEAL_DISTANCE))
    {
        return true;
    }
    if (Group* myGroup = me->GetGroup())
    {
        uint8 mySubGroup = me->GetSubGroup();
        for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
        {
            if (Player* member = groupRef->GetSource())
            {
                if (member->IsAlive())
                {
                    if (member->GetSubGroup() == mySubGroup)
                    {
                        if (member->GetHealthPct() < pmMaxHealthPercent)
                        {
                            if (me->GetDistance(member) < PRIEST_HEAL_DISTANCE)
                            {
                                if (CastSpell(me, "Prayer of Healing", PRIEST_HEAL_DISTANCE))
                                {
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

bool Script_Priest::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
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
        return DPS_Common(pmTarget, pmChase);
    }
    case 2:
    {
        return DPS_Common(pmTarget, pmChase);
    }
    default:
        return DPS_Common(pmTarget, pmChase);
    }

    return false;
}

bool Script_Priest::DPS_Common(Unit* pmTarget, bool pmChase)
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
            if (CastSpell(pmTarget, "Shoot", PRIEST_RANGE_DISTANCE))
            {
                return true;
            }
        }
    }
    if (CastSpell(pmTarget, "Shadow Word: Pain", PRIEST_RANGE_DISTANCE, true, true))
    {
        return true;
    }
    if (CastSpell(pmTarget, "Smite", PRIEST_RANGE_DISTANCE))
    {
        return true;
    }

    return true;
}

bool Script_Priest::Buff(Unit* pmTarget, bool pmCure)
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
    if (me->GetDistance(pmTarget) < PRIEST_RANGE_DISTANCE)
    {
        if (!sRobotManager->HasAura(pmTarget, "Power Word: Fortitude") && !sRobotManager->HasAura(pmTarget, "Prayer of Fortitude"))
        {
            if (FindSpellID("Prayer of Fortitude"))
            {
                if (CastSpell(pmTarget, "Prayer of Fortitude", PRIEST_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
            else
            {
                if (CastSpell(pmTarget, "Power Word: Fortitude", PRIEST_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
        }
        if (pmCure)
        {
            for (uint32 type = SPELL_AURA_NONE; type < TOTAL_AURAS; ++type)
            {
                std::list<AuraEffect*> auraList = pmTarget->GetAuraEffectsByType((AuraType)type);
                for (auto auraIT = auraList.begin(), end = auraList.end(); auraIT != end; ++auraIT)
                {
                    const SpellInfo* pST = (*auraIT)->GetSpellInfo();
                    if (!pST->IsPositive())
                    {
                        if (pST->Dispel == DispelType::DISPEL_DISEASE)
                        {
                            if (CastSpell(pmTarget, "Cure Disease", PRIEST_HEAL_DISTANCE))
                            {
                                return true;
                            }
                        }
                        if (pST->Dispel == DispelType::DISPEL_MAGIC)
                        {
                            if (CastSpell(pmTarget, "Dispel Magic", PRIEST_HEAL_DISTANCE))
                            {
                                return true;
                            }
                        }
                    }
                }
            }
        }
    }

    return false;
}
