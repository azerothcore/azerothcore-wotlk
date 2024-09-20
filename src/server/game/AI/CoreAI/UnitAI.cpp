/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "UnitAI.h"
#include "Creature.h"
#include "CreatureAIImpl.h"
#include "Player.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

void UnitAI::AttackStart(Unit* victim)
{
    if (victim && me->Attack(victim, true))
        me->GetMotionMaster()->MoveChase(victim);
}

void UnitAI::AttackStartCaster(Unit* victim, float dist)
{
    if (victim && me->Attack(victim, false))
        me->GetMotionMaster()->MoveChase(victim, dist);
}

void UnitAI::DoMeleeAttackIfReady()
{
    if (me->HasUnitState(UNIT_STATE_CASTING))
        return;

    Unit* victim = me->GetVictim();
    if (!victim || !victim->IsInWorld())
        return;

    if (!me->IsWithinMeleeRange(victim))
        return;

    //Make sure our attack is ready and we aren't currently casting before checking distance
    if (me->isAttackReady())
    {
        // xinef: prevent base and off attack in same time, delay attack at 0.2 sec
        if (me->haveOffhandWeapon())
            if (me->getAttackTimer(OFF_ATTACK) < ATTACK_DISPLAY_DELAY)
                me->setAttackTimer(OFF_ATTACK, ATTACK_DISPLAY_DELAY);

        me->AttackerStateUpdate(victim);
        me->resetAttackTimer();
    }

    if (me->haveOffhandWeapon() && me->isAttackReady(OFF_ATTACK))
    {
        // xinef: delay main hand attack if both will hit at the same time (players code)
        if (me->getAttackTimer(BASE_ATTACK) < ATTACK_DISPLAY_DELAY)
            me->setAttackTimer(BASE_ATTACK, ATTACK_DISPLAY_DELAY);

        me->AttackerStateUpdate(victim, OFF_ATTACK);
        me->resetAttackTimer(OFF_ATTACK);
    }
}

bool UnitAI::DoSpellAttackIfReady(uint32 spell)
{
    if (me->HasUnitState(UNIT_STATE_CASTING) || !me->isAttackReady())
        return true;

    if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell))
    {
        if (me->IsWithinCombatRange(me->GetVictim(), spellInfo->GetMaxRange(false)))
        {
            me->CastSpell(me->GetVictim(), spell, false);
            me->resetAttackTimer();
            return true;
        }
    }

    return false;
}

void UnitAI::DoSpellAttackToRandomTargetIfReady(uint32 spell, uint32 threatTablePosition /*= 0*/, float dist /*= 0.f*/, bool playerOnly /*= true*/)
{
    if (me->HasUnitState(UNIT_STATE_CASTING) || !me->isAttackReady())
        return;

    if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spell))
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, threatTablePosition, dist, playerOnly))
        {
            if (me->IsWithinCombatRange(target, spellInfo->GetMaxRange(false)))
            {
                me->CastSpell(target, spell, false);
                me->resetAttackTimer();
            }
        }
    }
}

Unit* UnitAI::SelectTarget(SelectTargetMethod targetType, uint32 position, float dist, bool playerOnly, bool withTank, int32 aura)
{
    return SelectTarget(targetType, position, DefaultTargetSelector(me, dist, playerOnly, withTank, aura));
}

void UnitAI::SelectTargetList(std::list<Unit*>& targetList, uint32 num, SelectTargetMethod targetType, uint32 position, float dist, bool playerOnly, bool withTank, int32 aura)
{
    SelectTargetList(targetList, num, targetType, position, DefaultTargetSelector(me, dist, playerOnly, withTank, aura));
}

float UnitAI::DoGetSpellMaxRange(uint32 spellId, bool positive)
{
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
    return spellInfo ? spellInfo->GetMaxRange(positive) : 0;
}

std::string UnitAI::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << std::boolalpha
        << "Me: " << (me ? me->GetDebugInfo() : "NULL");
    return sstr.str();
}

SpellCastResult UnitAI::DoAddAuraToAllHostilePlayers(uint32 spellid)
{
    if (me->IsInCombat())
    {
        ThreatContainer::StorageType threatlist = me->GetThreatMgr().GetThreatList();
        for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
        {
            if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
            {
                if (unit->IsPlayer())
                {
                    me->AddAura(spellid, unit);
                    return SPELL_CAST_OK;
                }
            }
            else
                return SPELL_FAILED_BAD_TARGETS;
        }
    }

    return SPELL_FAILED_CUSTOM_ERROR;
}

SpellCastResult UnitAI::DoCastToAllHostilePlayers(uint32 spellid, bool triggered)
{
    if (me->IsInCombat())
    {
        ThreatContainer::StorageType threatlist = me->GetThreatMgr().GetThreatList();
        for (ThreatContainer::StorageType::const_iterator itr = threatlist.begin(); itr != threatlist.end(); ++itr)
        {
            if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
            {
                if (unit->IsPlayer())
                    return me->CastSpell(unit, spellid, triggered);
            }
            else
                return SPELL_FAILED_BAD_TARGETS;
        }
    }

    return SPELL_FAILED_CUSTOM_ERROR;
}

SpellCastResult UnitAI::DoCast(uint32 spellId)
{
    Unit* target = nullptr;

    switch (AISpellInfo[spellId].target)
    {
        default:
        case AITARGET_SELF:
            target = me;
            break;
        case AITARGET_VICTIM:
            target = me->GetVictim();
            break;
        case AITARGET_ENEMY:
            {
                if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId))
                {
                    bool playerOnly = spellInfo->HasAttribute(SPELL_ATTR3_ONLY_ON_PLAYER);
                    target = SelectTarget(SelectTargetMethod::Random, 0, spellInfo->GetMaxRange(false), playerOnly);
                }
                break;
            }
        case AITARGET_ALLY:
            target = me;
            break;
        case AITARGET_BUFF:
            target = me;
            break;
        case AITARGET_DEBUFF:
            {
                if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId))
                {
                    bool playerOnly = spellInfo->HasAttribute(SPELL_ATTR3_ONLY_ON_PLAYER);
                    float range = spellInfo->GetMaxRange(false);

                    DefaultTargetSelector targetSelector(me, range, playerOnly, true, -(int32)spellId);
                    if (!(spellInfo->AuraInterruptFlags & AURA_INTERRUPT_FLAG_NOT_VICTIM)
                            && targetSelector(me->GetVictim()))
                        target = me->GetVictim();
                    else
                        target = SelectTarget(SelectTargetMethod::Random, 0, targetSelector);
                }
                break;
            }
    }

    if (target)
        me->CastSpell(target, spellId, false);

    return SPELL_FAILED_BAD_TARGETS;
}

SpellCastResult UnitAI::DoCast(Unit* victim, uint32 spellId, bool triggered)
{
    if (!victim)
        return SPELL_FAILED_BAD_TARGETS;

    if (me->HasUnitState(UNIT_STATE_CASTING) && !triggered)
        return SPELL_FAILED_SPELL_IN_PROGRESS;

    return me->CastSpell(victim, spellId, triggered);
}

SpellCastResult UnitAI::DoCastVictim(uint32 spellId, bool triggered)
{
    if (Unit* victim = me->GetVictim())
        return DoCast(victim, spellId, triggered);

    return SPELL_FAILED_BAD_TARGETS;
}

SpellCastResult UnitAI::DoCastAOE(uint32 spellId, bool triggered)
{
    if (!triggered && me->HasUnitState(UNIT_STATE_CASTING))
        return SPELL_FAILED_SPELL_IN_PROGRESS;

    return me->CastSpell((Unit*)nullptr, spellId, triggered);
}

/**
 * @brief Cast the spell on a random unit from the threat list
 */
SpellCastResult UnitAI::DoCastRandomTarget(uint32 spellId, uint32 threatTablePosition, float dist, bool playerOnly, bool triggered, bool withTank)
{
    if (Unit* target = SelectTarget(SelectTargetMethod::Random, threatTablePosition, dist, playerOnly, withTank))
    {
        return DoCast(target, spellId, triggered);
    }

    return SPELL_FAILED_BAD_TARGETS;
}

/**
 * @brief Cast spell on the max threat target, which may not always be the current victim.
 *
 * @param uint32 spellId Spell ID to cast.
 * @param uint32 Threat table position.
 * @param float dist Distance from caster to target.
 * @param bool playerOnly Select players only, excludes pets and other npcs.
 * @param bool triggered Triggered cast (full triggered mask).
 *
 * @return SpellCastResult
 */
SpellCastResult UnitAI::DoCastMaxThreat(uint32 spellId, uint32 threatTablePosition, float dist, bool playerOnly, bool triggered)
{
    if (Unit* target = SelectTarget(SelectTargetMethod::MaxThreat, threatTablePosition, dist, playerOnly))
    {
        return DoCast(target, spellId, triggered);
    }

    return SPELL_FAILED_BAD_TARGETS;
}

#define UPDATE_TARGET(a) {if (AIInfo->target<a) AIInfo->target=a;}

void UnitAI::FillAISpellInfo()
{
    AISpellInfo = new AISpellInfoType[sSpellMgr->GetSpellInfoStoreSize()];

    AISpellInfoType* AIInfo = AISpellInfo;
    SpellInfo const* spellInfo;

    for (uint32 i = 0; i < sSpellMgr->GetSpellInfoStoreSize(); ++i, ++AIInfo)
    {
        spellInfo = sSpellMgr->GetSpellInfo(i);
        if (!spellInfo)
            continue;

        if (spellInfo->HasAttribute(SPELL_ATTR0_ALLOW_CAST_WHILE_DEAD))
            AIInfo->condition = AICOND_DIE;
        else if (spellInfo->IsPassive() || spellInfo->GetDuration() == -1)
            AIInfo->condition = AICOND_AGGRO;
        else
            AIInfo->condition = AICOND_COMBAT;

        if (AIInfo->cooldown < spellInfo->RecoveryTime)
            AIInfo->cooldown = spellInfo->RecoveryTime;

        if (!spellInfo->GetMaxRange(false))
            UPDATE_TARGET(AITARGET_SELF)
            else
            {
                for (uint32 j = 0; j < MAX_SPELL_EFFECTS; ++j)
                {
                    uint32 targetType = spellInfo->Effects[j].TargetA.GetTarget();

                    if (targetType == TARGET_UNIT_TARGET_ENEMY
                            || targetType == TARGET_DEST_TARGET_ENEMY)
                        UPDATE_TARGET(AITARGET_VICTIM)
                        else if (targetType == TARGET_UNIT_DEST_AREA_ENEMY)
                            UPDATE_TARGET(AITARGET_ENEMY)

                            if (spellInfo->Effects[j].Effect == SPELL_EFFECT_APPLY_AURA)
                            {
                                if (targetType == TARGET_UNIT_TARGET_ENEMY)
                                    UPDATE_TARGET(AITARGET_DEBUFF)
                                    else if (spellInfo->IsPositive())
                                        UPDATE_TARGET(AITARGET_BUFF)
                                    }
                }
            }
        AIInfo->realCooldown = spellInfo->RecoveryTime + spellInfo->StartRecoveryTime;
        AIInfo->maxRange = spellInfo->GetMaxRange(false) * 3 / 4;
    }
}

ThreatMgr& UnitAI::GetThreatMgr()
{
    return me->GetThreatMgr();
}

void UnitAI::SortByDistance(std::list<Unit*>& list, bool ascending)
{
    list.sort(Acore::ObjectDistanceOrderPred(me, ascending));
}

//Enable PlayerAI when charmed
void PlayerAI::OnCharmed(bool apply)
{
    me->IsAIEnabled = apply;
}

void SimpleCharmedAI::UpdateAI(uint32 /*diff*/)
{
    Creature* charmer = me->GetCharmer()->ToCreature();

    //kill self if charm aura has infinite duration
    if (charmer->IsInEvadeMode())
    {
        Unit::AuraEffectList const& auras = me->GetAuraEffectsByType(SPELL_AURA_MOD_CHARM);
        for (Unit::AuraEffectList::const_iterator iter = auras.begin(); iter != auras.end(); ++iter)
            if ((*iter)->GetCasterGUID() == charmer->GetGUID() && (*iter)->GetBase()->IsPermanent())
            {
                Unit::Kill(charmer, me);
                return;
            }
    }

    if (!charmer->IsInCombat())
        me->GetMotionMaster()->MoveFollow(charmer, PET_FOLLOW_DIST, me->GetFollowAngle());

    Unit* target = me->GetVictim();
    if (!target || !charmer->IsValidAttackTarget(target))
        AttackStart(charmer->SelectNearestTargetInAttackDistance(ATTACK_DISTANCE));
}

SpellTargetSelector::SpellTargetSelector(Unit* caster, uint32 spellId) :
    _caster(caster), _spellInfo(sSpellMgr->GetSpellForDifficultyFromSpell(sSpellMgr->GetSpellInfo(spellId), caster))
{
    ASSERT(_spellInfo);
}

bool SpellTargetSelector::operator()(Unit const* target) const
{
    if (!target)
        return false;

    if (_spellInfo->CheckTarget(_caster, target) != SPELL_CAST_OK)
        return false;

    // copypasta from Spell::CheckRange
    uint32 range_type = _spellInfo->RangeEntry ? _spellInfo->RangeEntry->Flags : 0;
    float max_range = _caster->GetSpellMaxRangeForTarget(target, _spellInfo);
    float min_range = _caster->GetSpellMinRangeForTarget(target, _spellInfo);

    if (target && target != _caster)
    {
        if (range_type == SPELL_RANGE_MELEE)
        {
            // Because of lag, we can not check too strictly here.
            if (!_caster->IsWithinMeleeRange(target, max_range))
                return false;
        }
        else if (!_caster->IsWithinCombatRange(target, max_range))
            return false;

        if (range_type == SPELL_RANGE_RANGED)
        {
            if (_caster->IsWithinMeleeRange(target))
                return false;
        }
        else if (min_range && _caster->IsWithinCombatRange(target, min_range)) // skip this check if min_range = 0
            return false;
    }

    return true;
}

bool NonTankTargetSelector::operator()(Unit const* target) const
{
    if (!target)
        return false;

    if (_playerOnly && !target->IsPlayer())
        return false;

    if (Unit* currentVictim = _source->GetThreatMgr().GetCurrentVictim())
        return target != currentVictim;

    return target != _source->GetVictim();
}
