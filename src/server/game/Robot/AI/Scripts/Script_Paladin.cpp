#include "Script_Paladin.h"
#include "SpellMgr.h"
#include "RobotManager.h"
#include "Group.h"
#include "AI_Base.h"
#include "SpellInfo.h"
#include "SpellAuraEffects.h"

Script_Paladin::Script_Paladin(Player* pmMe) :Script_Base(pmMe)
{
    blessingType = PaladinBlessingType::PaladinBlessingType_Kings;
    auraType = PaladinAuraType::PaladinAuraType_Retribution;
    judgementType = PaladinJudgementType::PaladinJudgementType_Justice;
    sealType = PaladinSealType::PaladinSealType_Righteousness;

    judgementDelay = 0;
    consecrationDelay = 0;
    hammerOfWrathDelay = 0;
    righteousFuryDelay = 0;
    hammerOfJusticeDelay = 0;
    sealDelay = 0;
}

void Script_Paladin::Update(uint32 pmDiff)
{
    Script_Base::Update(pmDiff);
    if (judgementDelay < 300000)
    {
        judgementDelay += pmDiff;
    }
    if (consecrationDelay < 300000)
    {
        consecrationDelay += pmDiff;
    }
    if (hammerOfWrathDelay < 300000)
    {
        hammerOfWrathDelay += pmDiff;
    }
    if (righteousFuryDelay < 300000)
    {
        righteousFuryDelay += pmDiff;
    }
    if (hammerOfJusticeDelay < 300000)
    {
        hammerOfJusticeDelay += pmDiff;
    }
    if (sealDelay < 300000)
    {
        sealDelay += pmDiff;
    }
}

void Script_Paladin::Reset()
{
    judgementType = PaladinJudgementType::PaladinJudgementType_Justice;
    sealType = PaladinSealType::PaladinSealType_Righteousness;
    uint32 characterTalentTab = me->GetMaxTalentCountTab();
    switch (characterTalentTab)
    {
    case 0:
    {
        auraType = PaladinAuraType::PaladinAuraType_Concentration;
        break;
    }
    case 1:
    {
        auraType = PaladinAuraType::PaladinAuraType_Devotion;
        break;
    }
    case 2:
    {
        auraType = PaladinAuraType::PaladinAuraType_Retribution;
        break;
    }
    default:
    {
        auraType = PaladinAuraType::PaladinAuraType_Devotion;
        break;
    }
    }
    Script_Base::Reset();
}

bool Script_Paladin::Heal(Unit* pmTarget)
{
    if (!me)
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

bool Script_Paladin::Heal_Holy(Unit* pmTarget)
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
    if (me->GetDistance(pmTarget) > PALADIN_HEAL_DISTANCE)
    {
        return false;
    }
    float healthPCT = pmTarget->GetHealthPct();
    if (healthPCT < 20.0f)
    {
        if (!sRobotManager->HasAura(pmTarget, "Forbearance"))
        {
            if (pmTarget->IsInCombat())
            {
                if (CastSpell(pmTarget, "Lay on Hands", PALADIN_HEAL_DISTANCE))
                {
                    return true;
                }
                if (CastSpell(pmTarget, "Blessing of Protection", PALADIN_RANGE_DISTANCE))
                {
                    return true;
                }
            }
        }
    }
    if (healthPCT < 60.0f)
    {
        if (CastSpell(pmTarget, "Holy Light", PALADIN_HEAL_DISTANCE))
        {
            return true;
        }
    }
    if (healthPCT < 80.0f)
    {
        if (CastSpell(pmTarget, "Flash of Light", PALADIN_HEAL_DISTANCE))
        {
            return true;
        }
    }

    return false;
}

bool Script_Paladin::Cure(Unit* pmTarget)
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
    if (me->GetDistance(pmTarget) > PALADIN_HEAL_DISTANCE)
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
                if (pST->Dispel == DispelType::DISPEL_POISON || pST->Dispel == DispelType::DISPEL_DISEASE)
                {
                    if (CastSpell(pmTarget, "Purify"))
                    {
                        return true;
                    }
                }
            }
        }
    }

    return false;
}

bool Script_Paladin::Tank(Unit* pmTarget, bool pmChase, bool pmAOE)
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
    else if (!pmTarget->IsAlive())
    {
        return false;
    }
    if (me->GetHealthPct() < 20.0f)
    {
        UseHealingPotion();
    }
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 30)
    {
        UseManaPotion();
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
        if (targetDistance > PALADIN_RANGE_DISTANCE)
        {
            return false;
        }
        if (!me->isInFront(pmTarget, M_PI / 16))
        {
            me->SetFacingToObject(pmTarget);
        }
    }
    me->Attack(pmTarget, true);
    if (righteousFuryDelay > 10000)
    {
        if (CastSpell(me, "Righteous Fury", PALADIN_RANGE_DISTANCE, true))
        {
            righteousFuryDelay = 0;
            return true;
        }
    }
    if (hammerOfWrathDelay > 7000)
    {
        if (pmTarget->GetHealthPct() < 20.0f)
        {
            if (CastSpell(pmTarget, "Hammer of Wrath", MELEE_MAX_DISTANCE))
            {
                hammerOfWrathDelay = 0;
                return true;
            }
        }
    }
    if (hammerOfJusticeDelay > 61000)
    {
        if (pmTarget->IsNonMeleeSpellCast(false))
        {
            if (CastSpell(pmTarget, "Hammer of Justice", MELEE_MAX_DISTANCE))
            {
                hammerOfJusticeDelay = 0;
                return true;
            }
        }
    }
    if (consecrationDelay > 9000)
    {
        if (pmAOE)
        {
            uint32 meleeCount = 0;
            if (Group* myGroup = me->GetGroup())
            {
                std::unordered_set<Unit*> myAttackerSet = me->getAttackers();
                for (std::unordered_set<Unit*>::iterator maIT = myAttackerSet.begin(); maIT != myAttackerSet.end(); maIT++)
                {
                    if (Unit* eachAttacker = *maIT)
                    {
                        if (eachAttacker->GetTarget() != me->GetGUID())
                        {
                            if (me->GetDistance(eachAttacker) < AOE_TARGETS_RANGE)
                            {
                                meleeCount++;
                            }
                        }
                    }
                }
            }
            if (meleeCount > 1)
            {
                if (CastSpell(me, "Consecration"))
                {
                    consecrationDelay = 0;
                    return true;
                }
            }
        }
    }
    if (sealDelay > 5000)
    {
        switch (sealType)
        {
        case PaladinSealType::PaladinSealType_Justice:
        {
            if (CastSpell(me, "Seal of Justice", MELEE_MAX_DISTANCE, true))
            {
                sealDelay = 0;
                return true;
            }
            break;
        }
        case PaladinSealType::PaladinSealType_Righteousness:
        {
            if (CastSpell(me, "Seal of Righteousness", MELEE_MAX_DISTANCE, true))
            {
                sealDelay = 0;
                return true;
            }
            break;
        }
        default:
        {
            break;
        }
        }
    }
    if (judgementDelay > 11000)
    {
        switch (judgementType)
        {
        case PaladinJudgementType::PaladinJudgementType_Justice:
        {
            if (CastSpell(pmTarget, "Judgement of Justice"))
            {
                judgementDelay = 0;
                return true;
            }
            break;
        }
        case PaladinJudgementType::PaladinJudgementType_Light:
        {
            if (CastSpell(pmTarget, "Judgement of Light"))
            {
                judgementDelay = 0;
                return true;
            }
            break;
        }
        case PaladinJudgementType::PaladinJudgementType_Wisdom:
        {
            if (CastSpell(pmTarget, "Judgement of Wisdom"))
            {
                judgementDelay = 0;
                return true;
            }
            break;
        }
        default:
        {
            break;
        }
        }
        if (CastSpell(pmTarget, "Judgement of Light"))
        {
            judgementDelay = 0;
            return true;
        }
        if (CastSpell(pmTarget, "Judgement of Wisdom"))
        {
            judgementDelay = 0;
            return true;
        }
    }

    return true;
}

bool Script_Paladin::DPS(Unit* pmTarget, bool pmChase, bool pmAOE)
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
    if ((me->GetPower(Powers::POWER_MANA) * 100 / me->GetMaxPower(Powers::POWER_MANA)) < 30)
    {
        UseManaPotion();
    }
    uint32 characterTalentTab = me->GetMaxTalentCountTab();
    switch (characterTalentTab)
    {
    case 0:
    {
        return DPS_Common(pmTarget, pmChase, pmAOE);
    }
    case 1:
    {
        return DPS_Common(pmTarget, pmChase, pmAOE);
    }
    case 2:
    {
        return DPS_Common(pmTarget, pmChase, pmAOE);
    }
    default:
        return DPS_Common(pmTarget, pmChase, pmAOE);
    }
}

bool Script_Paladin::DPS_Retribution(Unit* pmTarget, bool pmChase)
{
    return false;
}

bool Script_Paladin::DPS_Common(Unit* pmTarget, bool pmChase, bool pmAOE)
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
        if (targetDistance > PALADIN_RANGE_DISTANCE)
        {
            return false;
        }
        if (!me->isInFront(pmTarget, M_PI / 16))
        {
            me->SetFacingToObject(pmTarget);
        }
    }
    me->Attack(pmTarget, true);
    if (hammerOfWrathDelay > 7000)
    {
        if (pmTarget->GetHealthPct() < 20.0f)
        {
            if (CastSpell(pmTarget, "Hammer of Wrath", MELEE_MAX_DISTANCE))
            {
                hammerOfWrathDelay = 0;
                return true;
            }
        }
    }
    if (hammerOfJusticeDelay > 61000)
    {
        if (pmTarget->IsNonMeleeSpellCast(false))
        {
            if (CastSpell(pmTarget, "Hammer of Justice", MELEE_MAX_DISTANCE))
            {
                hammerOfJusticeDelay = 0;
                return true;
            }
        }
    }
    if (consecrationDelay > 9000)
    {
        if (pmAOE)
        {
            if (Group* myGroup = me->GetGroup())
            {
                Player* mainTank = ObjectAccessor::GetPlayer(*me, myGroup->GetOGByTargetIcon(6));
                if (!mainTank)
                {
                    for (GroupReference* groupRef = myGroup->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                    {
                        if (Player* member = groupRef->GetSource())
                        {
                            if (member->IsAlive())
                            {
                                if (AI_Base* memberAI = member->robotAI)
                                {
                                    if (memberAI->groupRole == GroupRole::GroupRole_Tank)
                                    {
                                        mainTank = member;
                                    }
                                }
                            }
                        }
                    }
                }
                if (mainTank)
                {
                    float tankDistance = me->GetDistance(mainTank->GetPosition());
                    {
                        if (tankDistance < MELEE_MAX_DISTANCE)
                        {
                            uint32 meleeCount = 0;
                            std::unordered_set<Unit*> myAttackerSet = me->getAttackers();
                            for (std::unordered_set<Unit*>::iterator maIT = myAttackerSet.begin(); maIT != myAttackerSet.end(); maIT++)
                            {
                                if (Unit* eachAttacker = *maIT)
                                {
                                    if (mainTank->GetDistance(eachAttacker) < AOE_TARGETS_RANGE)
                                    {
                                        meleeCount++;
                                    }
                                }
                            }
                            if (meleeCount > 1)
                            {
                                if (CastSpell(me, "Consecration"))
                                {
                                    consecrationDelay = 0;
                                    return true;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (sealDelay > 5000)
    {
        switch (sealType)
        {
        case PaladinSealType::PaladinSealType_Justice:
        {
            if (CastSpell(me, "Seal of Justice", MELEE_MAX_DISTANCE, true))
            {
                sealDelay = 0;
                return true;
            }
            break;
        }
        case PaladinSealType::PaladinSealType_Righteousness:
        {
            if (CastSpell(me, "Seal of Righteousness", MELEE_MAX_DISTANCE, true))
            {
                sealDelay = 0;
                return true;
            }
            break;
        }
        default:
        {
            break;
        }
        }
    }
    if (judgementDelay > 11000)
    {
        switch (judgementType)
        {
        case PaladinJudgementType::PaladinJudgementType_Justice:
        {
            if (CastSpell(pmTarget, "Judgement of Justice"))
            {
                judgementDelay = 0;
                return true;
            }
            break;
        }
        case PaladinJudgementType::PaladinJudgementType_Light:
        {
            if (CastSpell(pmTarget, "Judgement of Light"))
            {
                judgementDelay = 0;
                return true;
            }
            break;
        }
        case PaladinJudgementType::PaladinJudgementType_Wisdom:
        {
            if (CastSpell(pmTarget, "Judgement of Wisdom"))
            {
                judgementDelay = 0;
                return true;
            }
            break;
        }
        default:
        {
            break;
        }
        }
        if (CastSpell(pmTarget, "Judgement of Light"))
        {
            judgementDelay = 0;
            return true;
        }
        if (CastSpell(pmTarget, "Judgement of Wisdom"))
        {
            judgementDelay = 0;
            return true;
        }
    }

    return true;
}

bool Script_Paladin::Buff(Unit* pmTarget, bool pmCure)
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
    if (pmTarget->GetGUID() == me->GetGUID())
    {
        switch (auraType)
        {
        case PaladinAuraType::PaladinAuraType_Concentration:
        {
            if (CastSpell(me, "Concentration Aura", PALADIN_RANGE_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        case PaladinAuraType::PaladinAuraType_Devotion:
        {
            if (CastSpell(me, "Devotion Aura", PALADIN_RANGE_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        case PaladinAuraType::PaladinAuraType_Retribution:
        {
            if (CastSpell(me, "Retribution Aura", PALADIN_RANGE_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        case PaladinAuraType::PaladinAuraType_FireResistant:
        {
            if (CastSpell(me, "Fire Resistance Aura", PALADIN_RANGE_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        case PaladinAuraType::PaladinAuraType_FrostResistant:
        {
            if (CastSpell(me, "Frost Resistance Aura", PALADIN_RANGE_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        case PaladinAuraType::PaladinAuraType_ShadowResistant:
        {
            if (CastSpell(me, "Shadow Resistance Aura", PALADIN_RANGE_DISTANCE, true))
            {
                return true;
            }
            break;
        }
        default:
        {
            break;
        }
        }
    }
    switch (blessingType)
    {
    case PaladinBlessingType::PaladinBlessingType_Kings:
    {
        if (!sRobotManager->HasAura(pmTarget, "Blessing of Kings") && !sRobotManager->HasAura(pmTarget, "Greater Blessing of Kings"))
        {
            if (FindSpellID("Greater Blessing of Kings"))
            {
                if (CastSpell(pmTarget, "Greater Blessing of Kings", PALADIN_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
            else
            {
                if (CastSpell(pmTarget, "Blessing of Kings", PALADIN_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
        }
        break;
    }
    case PaladinBlessingType::PaladinBlessingType_Might:
    {
        if (!sRobotManager->HasAura(pmTarget, "Blessing of Might") && !sRobotManager->HasAura(pmTarget, "Greater Blessing of Might"))
        {
            if (FindSpellID("Greater Blessing of Might"))
            {
                if (CastSpell(pmTarget, "Greater Blessing of Might", PALADIN_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
            else
            {
                if (CastSpell(pmTarget, "Blessing of Might", PALADIN_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
        }
        break;
    }
    case PaladinBlessingType::PaladinBlessingType_Wisdom:
    {
        if (!sRobotManager->HasAura(pmTarget, "Blessing of Wisdom") && !sRobotManager->HasAura(pmTarget, "Greater Blessing of Wisdom"))
        {
            if (FindSpellID("Greater Blessing of Wisdom"))
            {
                if (CastSpell(pmTarget, "Greater Blessing of Wisdom", PALADIN_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
            else
            {
                if (CastSpell(pmTarget, "Blessing of Wisdom", PALADIN_RANGE_DISTANCE, true))
                {
                    return true;
                }
            }
        }
        break;
    }
    default:
    {
        break;
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
                    if (pST->Dispel == DispelType::DISPEL_POISON || pST->Dispel == DispelType::DISPEL_DISEASE)
                    {
                        if (CastSpell(pmTarget, "Purify"))
                        {
                            return true;
                        }
                    }
                }
            }
        }
    }

    return false;
}
