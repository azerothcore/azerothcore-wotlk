/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ArenaSpectator.h"
#include "CellImpl.h"
#include "Common.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Unit.h"
#include "Util.h"
#include "Vehicle.h"
#include "WorldPacket.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

// update aura target map every 500 ms instead of every update - reduce amount of grid searcher calls
static constexpr int32 UPDATE_TARGET_MAP_INTERVAL = 500;

AuraApplication::AuraApplication(Unit* target, Unit* caster, Aura* aura, uint8 effMask):
    _target(target), _base(aura), _removeMode(AURA_REMOVE_NONE), _slot(MAX_AURAS),
    _flags(AFLAG_NONE), _effectsToApply(effMask), _needClientUpdate(false), _disableMask(0)
{
    ASSERT(GetTarget() && GetBase());

    if (GetBase()->CanBeSentToClient())
    {
        // Try find slot for aura
        uint8 slot = MAX_AURAS;
        // Lookup for auras already applied from spell
        if (AuraApplication* foundAura = GetTarget()->GetAuraApplication(GetBase()->GetId(), GetBase()->GetCasterGUID(), GetBase()->GetCastItemGUID()))
        {
            // allow use single slot only by auras from same caster
            slot = foundAura->GetSlot();
        }
        else
        {
            Unit::VisibleAuraMap const* visibleAuras = GetTarget()->GetVisibleAuras();
            // lookup for free slots in units visibleAuras
            Unit::VisibleAuraMap::const_iterator itr = visibleAuras->find(0);
            for (uint32 freeSlot = 0; freeSlot < MAX_AURAS; ++itr, ++freeSlot)
            {
                if (itr == visibleAuras->end() || itr->first != freeSlot)
                {
                    slot = freeSlot;
                    break;
                }
            }
        }

        // Register Visible Aura
        if (slot < MAX_AURAS)
        {
            _slot = slot;
            GetTarget()->SetVisibleAura(slot, this);
            SetNeedClientUpdate();
            LOG_DEBUG("spells.aura", "Aura: {} Effect: {} put to unit visible auras slot: {}", GetBase()->GetId(), GetEffectMask(), slot);
        }
        else
        {
            LOG_ERROR("spells.aura", "Aura: {} Effect: {} could not find empty unit visible slot", GetBase()->GetId(), GetEffectMask());
        }
    }
    _InitFlags(caster, effMask);
}

void AuraApplication::_Remove()
{
    uint8 slot = GetSlot();

    if (slot >= MAX_AURAS)
        return;

    if (AuraApplication* foundAura = _target->GetAuraApplication(GetBase()->GetId(), GetBase()->GetCasterGUID(), GetBase()->GetCastItemGUID()))
    {
        // Reuse visible aura slot by aura which is still applied - prevent storing dead pointers
        if (slot == foundAura->GetSlot())
        {
            if (GetTarget()->GetVisibleAura(slot) == this)
            {
                GetTarget()->SetVisibleAura(slot, foundAura);
                foundAura->SetNeedClientUpdate();
            }
            // set not valid slot for aura - prevent removing other visible aura
            slot = MAX_AURAS;
        }
    }

    // update for out of range group members
    if (slot < MAX_AURAS)
    {
        GetTarget()->RemoveVisibleAura(slot);
        ClientUpdate(true);
    }
}

void AuraApplication::_InitFlags(Unit* caster, uint8 effMask)
{
    // mark as selfcasted if needed
    _flags |= (GetBase()->GetCasterGUID() == GetTarget()->GetGUID()) ? AFLAG_CASTER : AFLAG_NONE;

    // aura is casted by self or an enemy
    // one negative effect and we know aura is negative
    if (IsSelfcasted() || !caster || !caster->IsFriendlyTo(GetTarget()))
    {
        bool negativeFound = false;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (((1 << i) & effMask) && !GetBase()->GetSpellInfo()->IsPositiveEffect(i))
            {
                negativeFound = true;
                break;
            }
        }
        _flags |= negativeFound ? AFLAG_NEGATIVE : AFLAG_POSITIVE;
    }
    // aura is casted by friend
    // one positive effect and we know aura is positive
    else
    {
        bool positiveFound = false;
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (((1 << i) & effMask) && GetBase()->GetSpellInfo()->IsPositiveEffect(i))
            {
                positiveFound = true;
                break;
            }
        }
        _flags |= positiveFound ? AFLAG_POSITIVE : AFLAG_NEGATIVE;
    }
}

void AuraApplication::_HandleEffect(uint8 effIndex, bool apply)
{
    AuraEffect* aurEff = GetBase()->GetEffect(effIndex);
    ASSERT(aurEff);
    ASSERT(HasEffect(effIndex) == (!apply));
    ASSERT((1 << effIndex) & _effectsToApply);
    LOG_DEBUG("spells.aura", "AuraApplication::_HandleEffect: {}, apply: {}: amount: {}", aurEff->GetAuraType(), apply, aurEff->GetAmount());

    if (apply)
    {
        ASSERT(!(_flags & (1 << effIndex)));
        _flags |= 1 << effIndex;
        aurEff->HandleEffect(this, AURA_EFFECT_HANDLE_REAL, true);
    }
    else
    {
        ASSERT(_flags & (1 << effIndex));
        _flags &= ~(1 << effIndex);
        aurEff->HandleEffect(this, AURA_EFFECT_HANDLE_REAL, false);

        // Remove all triggered by aura spells vs unlimited duration
        aurEff->CleanupTriggeredSpells(GetTarget());
    }
    SetNeedClientUpdate();
}

void AuraApplication::BuildUpdatePacket(ByteBuffer& data, bool remove) const
{
    data << uint8(_slot);

    if (remove)
    {
        ASSERT(!_target->GetVisibleAura(_slot));
        data << uint32(0);
        return;
    }
    ASSERT(_target->GetVisibleAura(_slot));

    Aura const* aura = GetBase();
    data << uint32(aura->GetId());
    uint32 flags = _flags;
    if (aura->GetMaxDuration() > 0 && !aura->GetSpellInfo()->HasAttribute(SPELL_ATTR5_DO_NOT_DISPLAY_DURATION))
        flags |= AFLAG_DURATION;
    data << uint8(flags);
    data << uint8(aura->GetCasterLevel());
    // send stack amount for aura which could be stacked (never 0 - causes incorrect display) or charges
    // stack amount has priority over charges (checked on retail with spell 50262)
    data << uint8(aura->GetSpellInfo()->StackAmount ? aura->GetStackAmount() : aura->GetCharges());

    if (!(flags & AFLAG_CASTER))
        data << aura->GetCasterGUID().WriteAsPacked();

    if (flags & AFLAG_DURATION)
    {
        data << uint32(aura->GetMaxDuration());
        data << uint32(aura->GetDuration());
    }
}

void AuraApplication::ClientUpdate(bool remove)
{
    _needClientUpdate = false;

    WorldPacket data(SMSG_AURA_UPDATE);
    data << GetTarget()->GetPackGUID();
    BuildUpdatePacket(data, remove);

    if (GetSlot() < MAX_AURAS)
        if (Player const* plr = GetTarget()->ToPlayer())
            if (Aura* aura = GetBase())
                if (plr->NeedSendSpectatorData() && ArenaSpectator::ShouldSendAura(aura, GetEffectMask(), GetTarget()->GetGUID(), remove))
                    ArenaSpectator::SendCommand_Aura(plr->FindMap(), plr->GetGUID(), "AUR", aura->GetCasterGUID(), aura->GetSpellInfo()->Id, aura->GetSpellInfo()->IsPositive(), aura->GetSpellInfo()->Dispel, aura->GetDuration(), aura->GetMaxDuration(), (aura->GetCharges() > 1 ? aura->GetCharges() : aura->GetStackAmount()), remove);

    _target->SendMessageToSet(&data, true);
}

uint8 Aura::BuildEffectMaskForOwner(SpellInfo const* spellProto, uint8 avalibleEffectMask, WorldObject* owner)
{
    ASSERT_NODEBUGINFO(spellProto);
    ASSERT_NODEBUGINFO(owner);
    uint8 effMask = 0;
    switch (owner->GetTypeId())
    {
        case TYPEID_UNIT:
        case TYPEID_PLAYER:
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            {
                if (spellProto->Effects[i].IsUnitOwnedAuraEffect())
                    effMask |= 1 << i;
            }
            break;
        case TYPEID_DYNAMICOBJECT:
            for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
            {
                if (spellProto->Effects[i].Effect == SPELL_EFFECT_PERSISTENT_AREA_AURA)
                    effMask |= 1 << i;
            }
            break;
        default:
            break;
    }
    return effMask & avalibleEffectMask;
}

Aura* Aura::TryRefreshStackOrCreate(SpellInfo const* spellproto, uint8 tryEffMask, WorldObject* owner, Unit* caster, int32* baseAmount /*= nullptr*/, Item* castItem /*= nullptr*/, ObjectGuid casterGUID /*= ObjectGuid::Empty*/, bool* refresh /*= nullptr*/, bool periodicReset /*= false*/)
{
    ASSERT_NODEBUGINFO(spellproto);
    ASSERT_NODEBUGINFO(owner);
    ASSERT_NODEBUGINFO(caster || casterGUID);
    ASSERT_NODEBUGINFO(tryEffMask <= MAX_EFFECT_MASK);
    if (refresh)
        *refresh = false;
    uint8 effMask = Aura::BuildEffectMaskForOwner(spellproto, tryEffMask, owner);
    if (!effMask)
        return nullptr;
    if (Aura* foundAura = owner->ToUnit()->_TryStackingOrRefreshingExistingAura(spellproto, effMask, caster, baseAmount, castItem, casterGUID, periodicReset))
    {
        // we've here aura, which script triggered removal after modding stack amount
        // check the state here, so we won't create new Aura object
        if (foundAura->IsRemoved())
            return nullptr;

        if (refresh)
            *refresh = true;
        return foundAura;
    }
    else
        return Create(spellproto, effMask, owner, caster, baseAmount, castItem, casterGUID);
}

Aura* Aura::TryCreate(SpellInfo const* spellproto, uint8 tryEffMask, WorldObject* owner, Unit* caster, int32* baseAmount /*= nullptr*/, Item* castItem /*= nullptr*/, ObjectGuid casterGUID /*= ObjectGuid::Empty*/, ObjectGuid itemGUID /*= ObjectGuid::Empty*/)
{
    ASSERT_NODEBUGINFO(spellproto);
    ASSERT_NODEBUGINFO(owner);
    ASSERT_NODEBUGINFO(caster || casterGUID);
    ASSERT_NODEBUGINFO(tryEffMask <= MAX_EFFECT_MASK);
    uint8 effMask = Aura::BuildEffectMaskForOwner(spellproto, tryEffMask, owner);
    if (!effMask)
        return nullptr;
    return Create(spellproto, effMask, owner, caster, baseAmount, castItem, casterGUID, itemGUID);
}

Aura* Aura::Create(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID /*= ObjectGuid::Empty*/)
{
    ASSERT_NODEBUGINFO(effMask);
    ASSERT_NODEBUGINFO(spellproto);
    ASSERT_NODEBUGINFO(owner);
    ASSERT_NODEBUGINFO(caster || casterGUID);
    ASSERT_NODEBUGINFO(effMask <= MAX_EFFECT_MASK);
    // try to get caster of aura
    if (casterGUID)
    {
        if (owner->GetGUID() == casterGUID)
            caster = owner->ToUnit();
        else
            caster = ObjectAccessor::GetUnit(*owner, casterGUID);
    }
    else
        casterGUID = caster->GetGUID();

    // check if aura can be owned by owner
    if (owner->IsUnit())
        if (!owner->IsInWorld() || ((Unit*)owner)->IsDuringRemoveFromWorld())
            // owner not in world so don't allow to own not self casted single target auras
            if (casterGUID != owner->GetGUID() && spellproto->IsSingleTarget())
                return nullptr;

    Aura* aura = nullptr;
    switch (owner->GetTypeId())
    {
        case TYPEID_UNIT:
        case TYPEID_PLAYER:
            aura = new UnitAura(spellproto, effMask, owner, caster, baseAmount, castItem, casterGUID, itemGUID);
            break;
        case TYPEID_DYNAMICOBJECT:
            aura = new DynObjAura(spellproto, effMask, owner, caster, baseAmount, castItem, casterGUID, itemGUID);
            break;
        default:
            ABORT();
            return nullptr;
    }
    // aura can be removed in Unit::_AddAura call
    if (aura->IsRemoved())
        return nullptr;
    return aura;
}

Aura::Aura(SpellInfo const* spellproto, WorldObject* owner, Unit* caster, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID /*= ObjectGuid::Empty*/) :
    m_spellInfo(spellproto), m_casterGuid(casterGUID ? casterGUID : caster->GetGUID()),
    m_castItemGuid(itemGUID ? itemGUID : castItem ? castItem->GetGUID() : ObjectGuid::Empty), m_castItemEntry(castItem ? castItem->GetEntry() : 0), m_applyTime(GameTime::GetGameTime().count()),
    m_owner(owner), m_timeCla(0), m_updateTargetMapInterval(0),
    m_casterLevel(caster ? caster->GetLevel() : m_spellInfo->SpellLevel), m_procCharges(0), m_stackAmount(1),
    m_isRemoved(false), m_isSingleTarget(false), m_isUsingCharges(false), m_triggeredByAuraSpellInfo(nullptr)
{
    if ((m_spellInfo->ManaPerSecond || m_spellInfo->ManaPerSecondPerLevel) && !m_spellInfo->HasAttribute(SPELL_ATTR2_NO_TARGET_PER_SECOND_COST))
        m_timeCla = 1 * IN_MILLISECONDS;

    m_maxDuration = CalcMaxDuration(caster);
    m_duration = m_maxDuration;
    m_procCharges = CalcMaxCharges(caster);
    m_isUsingCharges = m_procCharges != 0;
    memset(m_effects, 0, sizeof(m_effects));
    // m_casterLevel = cast item level/caster level, caster level should be saved to db, confirmed with sniffs
}

AuraScript* Aura::GetScriptByName(std::string const& scriptName) const
{
    for (std::list<AuraScript*>::const_iterator itr = m_loadedScripts.begin(); itr != m_loadedScripts.end(); ++itr)
        if ((*itr)->_GetScriptName()->compare(scriptName) == 0)
            return *itr;
    return nullptr;
}

void Aura::_InitEffects(uint8 effMask, Unit* caster, int32* baseAmount)
{
    // shouldn't be in constructor - functions in AuraEffect::AuraEffect use polymorphism
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (effMask & (uint8(1) << i))
            m_effects[i] = new AuraEffect(this, i, baseAmount ? baseAmount + i : nullptr, caster);
        else
            m_effects[i] = nullptr;
    }
}

Aura::~Aura()
{
    // unload scripts
    while (!m_loadedScripts.empty())
    {
        std::list<AuraScript*>::iterator itr = m_loadedScripts.begin();
        (*itr)->_Unload();
        delete (*itr);
        m_loadedScripts.erase(itr);
    }

    // free effects memory
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        delete m_effects[i];

    ASSERT(m_applications.empty());
    _DeleteRemovedApplications();
}

uint32 Aura::GetId() const
{
    return GetSpellInfo()->Id;
}

Unit* Aura::GetCaster() const
{
    if (GetOwner()->GetGUID() == GetCasterGUID())
        return GetUnitOwner();
    if (AuraApplication const* aurApp = GetApplicationOfTarget(GetCasterGUID()))
        return aurApp->GetTarget();

    return ObjectAccessor::GetUnit(*GetOwner(), GetCasterGUID());
}

AuraObjectType Aura::GetType() const
{
    if (!m_owner)
    {
        LOG_ERROR("spells", "Aura::GetType m_owner is null!");
        return UNIT_AURA_TYPE;
    }

    return (m_owner->IsDynamicObject()) ? DYNOBJ_AURA_TYPE : UNIT_AURA_TYPE;
}

void Aura::_ApplyForTarget(Unit* target, Unit* caster, AuraApplication* auraApp)
{
    ASSERT(target);
    ASSERT(auraApp);
    // aura mustn't be already applied on target
    ASSERT (!IsAppliedOnTarget(target->GetGUID()) && "Aura::_ApplyForTarget: aura musn't be already applied on target");

    m_applications[target->GetGUID()] = auraApp;

    // set infinity cooldown state for spells
    if (m_spellInfo->IsCooldownStartedOnEvent() && !m_castItemGuid && caster)
    {
        if (caster->IsPlayer())
        {
            caster->ToPlayer()->AddSpellAndCategoryCooldowns(m_spellInfo, 0, nullptr, true);
        }
        else
        {
            caster->ToCreature()->AddSpellCooldown(m_spellInfo->Id, 0, infinityCooldownDelay);
        }
    }
}

void Aura::_UnapplyForTarget(Unit* target, Unit* caster, AuraApplication* auraApp)
{
    ASSERT(target);
    ASSERT(auraApp->GetRemoveMode());
    ASSERT(auraApp);

    ApplicationMap::iterator itr = m_applications.find(target->GetGUID());

    /// @todo: Figure out why this happens
    if (itr == m_applications.end())
    {
        LOG_ERROR("spells.aura", "Aura::_UnapplyForTarget, target:{}, caster:{}, spell:{} was not found in owners application map!",
                       target->GetGUID().ToString(), caster ? caster->GetGUID().ToString() : "", auraApp->GetBase()->GetSpellInfo()->Id);
        ABORT();
    }

    // aura has to be already applied
    ASSERT(itr->second == auraApp);
    m_applications.erase(itr);

    m_removedApplications.push_back(auraApp);

    // reset cooldown state for spells
    if (m_spellInfo->IsCooldownStartedOnEvent() && !m_castItemGuid && caster)
    {
        if (caster->IsPlayer())
        {
            // note: item based cooldowns and cooldown spell mods with charges ignored (unknown existed cases)
            caster->ToPlayer()->SendCooldownEvent(GetSpellInfo());
        }
        else
        {
            caster->ToCreature()->AddSpellCooldown(m_spellInfo->Id, 0, 0);

            if (Unit* owner = caster->GetCharmerOrOwner())
            {
                if (Player* playerOwner = owner->ToPlayer())
                {
                    WorldPacket data(SMSG_COOLDOWN_EVENT, 4 + 8);
                    data << uint32(m_spellInfo->Id);
                    data << caster->GetGUID();
                    playerOwner->SendDirectMessage(&data);
                }
            }
        }
    }

    if (caster && caster->IsPlayer())
    {
        if (GetSpellInfo()->IsCooldownStartedOnEvent() && !m_castItemGuid)
        {
            // note: item based cooldowns and cooldown spell mods with charges ignored (unknown existed cases)
            caster->ToPlayer()->SendCooldownEvent(GetSpellInfo());
        }
    }
}

// removes aura from all targets
// and marks aura as removed
void Aura::_Remove(AuraRemoveMode removeMode)
{
    ASSERT (!m_isRemoved);
    m_isRemoved = true;
    ApplicationMap::iterator appItr = m_applications.begin();
    for (appItr = m_applications.begin(); appItr != m_applications.end();)
    {
        AuraApplication* aurApp = appItr->second;
        Unit* target = aurApp->GetTarget();
        target->_UnapplyAura(aurApp, removeMode);
        appItr = m_applications.begin();
    }
}

void Aura::UpdateTargetMap(Unit* caster, bool apply)
{
    if (IsRemoved())
        return;

    m_updateTargetMapInterval = UPDATE_TARGET_MAP_INTERVAL;

    // fill up to date target list
    //       target, effMask
    std::map<Unit*, uint8> targets;

    FillTargetMap(targets, caster);

    UnitList targetsToRemove;

    // mark all auras as ready to remove
    for (ApplicationMap::iterator appIter = m_applications.begin(); appIter != m_applications.end(); ++appIter)
    {
        std::map<Unit*, uint8>::iterator existing = targets.find(appIter->second->GetTarget());
        // not found in current area - remove the aura
        if (existing == targets.end())
            targetsToRemove.push_back(appIter->second->GetTarget());
        else
        {
            // xinef: check immunities here, so aura wont get removed on every tick and then reapplied
            if (IsArea())
                for (uint8 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
                {
                    if ((existing->second & (1 << effIndex)) && existing->first->IsImmunedToSpellEffect(GetSpellInfo(), effIndex))
                        existing->second &= ~(1 << effIndex);
                }

            // needs readding - remove now, will be applied in next update cycle
            // (dbcs do not have auras which apply on same type of targets but have different radius, so this is not really needed)
            if (appIter->second->GetEffectMask() != existing->second || !CanBeAppliedOn(existing->first))
                targetsToRemove.push_back(appIter->second->GetTarget());
            // nothing todo - aura already applied
            // remove from auras to register list
            targets.erase(existing);
        }
    }

    // register auras for units
    for (std::map<Unit*, uint8>::iterator itr = targets.begin(); itr != targets.end();)
    {
        // aura mustn't be already applied on target
        if (AuraApplication* aurApp = GetApplicationOfTarget(itr->first->GetGUID()))
        {
            // the core created 2 different units with same guid
            // this is a major failue, which i can't fix right now
            // let's remove one unit from aura list
            // this may cause area aura "bouncing" between 2 units after each update
            // but because we know the reason of a crash we can remove the assertion for now
            if (aurApp->GetTarget() != itr->first)
            {
                // remove from auras to register list
                targets.erase(itr++);
                continue;
            }
            else
            {
                // ok, we have one unit twice in target map (impossible, but...)
                ABORT();
            }
        }

        bool addUnit = true;
        // check target immunities
        for (uint8 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
        {
            if ((itr->second & (1 << effIndex)) && itr->first->IsImmunedToSpellEffect(GetSpellInfo(), effIndex))
                itr->second &= ~(1 << effIndex);
        }
        if (!itr->second || itr->first->IsImmunedToSpell(GetSpellInfo()) || !CanBeAppliedOn(itr->first))
            addUnit = false;

        if (addUnit && !itr->first->IsHighestExclusiveAura(this, true))
            addUnit = false;

        if (addUnit)
        {
            // persistent area aura does not hit flying targets
            if (GetType() == DYNOBJ_AURA_TYPE)
            {
                if (itr->first->IsInFlight())
                    addUnit = false;

            // Allow only 1 persistent area aura to affect our targets if a custom flag is set.
            if (itr->first->HasAura(GetId()) && GetSpellInfo()->HasAttribute(SPELL_ATTR0_CU_ONLY_ONE_AREA_AURA))
                addUnit = false;
            }
            // unit auras can not stack with each other
            else // (GetType() == UNIT_AURA_TYPE)
            {
                // Allow to remove by stack when aura is going to be applied on owner
                if (itr->first != GetOwner())
                {
                    // check if not stacking aura already on target
                    // this one prevents unwanted usefull buff loss because of stacking and prevents overriding auras periodicaly by 2 near area aura owners
                    for (Unit::AuraApplicationMap::iterator iter = itr->first->GetAppliedAuras().begin(); iter != itr->first->GetAppliedAuras().end(); ++iter)
                    {
                        Aura const* aura = iter->second->GetBase();
                        if (!CanStackWith(aura))
                        {
                            addUnit = false;
                            break;
                        }
                    }
                }
            }
        }
        if (!addUnit)
            targets.erase(itr++);
        else
        {
            // owner has to be in world, or effect has to be applied to self
            if (!GetOwner()->IsSelfOrInSameMap(itr->first))
            {
                //TODO: There is a crash caused by shadowfiend load addon
                LOG_FATAL("spells.aura", "Aura {}: Owner {} (map {}) is not in the same map as target {} (map {}).", GetSpellInfo()->Id,
                               GetOwner()->GetName(), GetOwner()->IsInWorld() ? GetOwner()->GetMap()->GetId() : uint32(-1),
                               itr->first->GetName(), itr->first->IsInWorld() ? itr->first->GetMap()->GetId() : uint32(-1));
                ABORT();
            }
            itr->first->_CreateAuraApplication(this, itr->second);
            ++itr;
        }
    }

    // remove auras from units no longer needing them
    for (UnitList::iterator itr = targetsToRemove.begin(); itr != targetsToRemove.end(); ++itr)
        if (AuraApplication* aurApp = GetApplicationOfTarget((*itr)->GetGUID()))
            (*itr)->_UnapplyAura(aurApp, AURA_REMOVE_BY_DEFAULT);

    if (!apply)
        return;

    // apply aura effects for units
    for (std::map<Unit*, uint8>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
    {
        if (AuraApplication* aurApp = GetApplicationOfTarget(itr->first->GetGUID()))
        {
            // owner has to be in world, or effect has to be applied to self
            ASSERT((!GetOwner()->IsInWorld() && GetOwner() == itr->first) || GetOwner()->IsInMap(itr->first));
            itr->first->_ApplyAura(aurApp, itr->second);
        }
    }
}

// targets have to be registered and not have effect applied yet to use this function
void Aura::_ApplyEffectForTargets(uint8 effIndex)
{
    // prepare list of aura targets
    UnitList targetList;
    for (ApplicationMap::iterator appIter = m_applications.begin(); appIter != m_applications.end(); ++appIter)
    {
        if ((appIter->second->GetEffectsToApply() & (1 << effIndex)) && !appIter->second->HasEffect(effIndex))
            targetList.push_back(appIter->second->GetTarget());
    }

    // apply effect to targets
    for (UnitList::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
    {
        if (GetApplicationOfTarget((*itr)->GetGUID()))
        {
            // owner has to be in world, or effect has to be applied to self
            ASSERT((!GetOwner()->IsInWorld() && GetOwner() == *itr) || GetOwner()->IsInMap(*itr));
            (*itr)->_ApplyAuraEffect(this, effIndex);
        }
    }
}
void Aura::UpdateOwner(uint32 diff, WorldObject* owner)
{
    if (owner != m_owner)
    {
        ABORT();
    }

    Unit* caster = GetCaster();
    // Apply spellmods for channeled auras
    // used for example when triggered spell of spell:10 is modded
    Spell* modSpell = nullptr;
    Player* modOwner = nullptr;
    if (caster)
    {
        modOwner = caster->GetSpellModOwner();
        if (modOwner)
        {
            modSpell = modOwner->FindCurrentSpellBySpellId(GetId());
            if (modSpell)
                modOwner->SetSpellModTakingSpell(modSpell, true);
        }
    }

    Update(diff, caster);

    if (m_updateTargetMapInterval <= int32(diff))
        UpdateTargetMap(caster);
    else
        m_updateTargetMapInterval -= diff;

    // update aura effects
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (m_effects[i])
            m_effects[i]->Update(diff, caster);

    // remove spellmods after effects update
    if (modSpell)
        modOwner->SetSpellModTakingSpell(modSpell, false);

    _DeleteRemovedApplications();
}

void Aura::Update(uint32 diff, Unit* caster)
{
    if (m_duration > 0)
    {
        m_duration -= diff;
        if (m_duration < 0)
            m_duration = 0;

        // handle ManaPerSecond/ManaPerSecondPerLevel
        if (m_timeCla)
        {
            if (m_timeCla > int32(diff))
                m_timeCla -= diff;
            else if (caster)
            {
                if (int32 ManaPerSecond = m_spellInfo->ManaPerSecond + m_spellInfo->ManaPerSecondPerLevel * caster->GetLevel())
                {
                    m_timeCla += 1000 - diff;

                    Powers powertype = Powers(m_spellInfo->PowerType);
                    if (powertype == POWER_HEALTH)
                    {
                        if (int32(caster->GetHealth()) > ManaPerSecond)
                            caster->ModifyHealth(-ManaPerSecond);
                        else
                        {
                            Remove();
                            return;
                        }
                    }
                    else
                    {
                        if (int32(caster->GetPower(powertype)) >= ManaPerSecond)
                            caster->ModifyPower(powertype, -ManaPerSecond);
                        else
                        {
                            Remove();
                            return;
                        }
                    }
                }
            }
        }
    }
}

int32 Aura::CalcMaxDuration(Unit* caster) const
{
    Player* modOwner = nullptr;
    int32 maxDuration;

    if (caster)
    {
        modOwner = caster->GetSpellModOwner();
        maxDuration = caster->CalcSpellDuration(m_spellInfo);
    }
    else
        maxDuration = m_spellInfo->GetDuration();

    if (IsPassive() && !m_spellInfo->DurationEntry)
        maxDuration = -1;

    sScriptMgr->OnCalcMaxDuration(this, maxDuration);

    // IsPermanent() checks max duration (which we are supposed to calculate here)
    if (maxDuration != -1 && modOwner)
        modOwner->ApplySpellMod(GetId(), SPELLMOD_DURATION, maxDuration);
    return maxDuration;
}

void Aura::SetDuration(int32 duration, bool withMods)
{
    if (withMods)
    {
        if (Unit* caster = GetCaster())
            if (Player* modOwner = caster->GetSpellModOwner())
                modOwner->ApplySpellMod(GetId(), SPELLMOD_DURATION, duration);
    }
    m_duration = duration;
    SetNeedClientUpdateForTargets();
}

void Aura::RefreshDuration(bool withMods)
{
    Unit* caster = GetCaster();

    if (!caster)
        return;

    if (withMods && caster)
    {
        int32 duration = m_spellInfo->GetMaxDuration();
        // Calculate duration of periodics affected by haste.
        if (caster->HasAuraTypeWithAffectMask(SPELL_AURA_PERIODIC_HASTE, m_spellInfo) || m_spellInfo->HasAttribute(SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC))
            duration = int32(duration * caster->GetFloatValue(UNIT_MOD_CAST_SPEED));
        SetMaxDuration(duration);

        SetDuration(duration);
    }
    else
        SetDuration(GetMaxDuration());

    if ((m_spellInfo->ManaPerSecond || m_spellInfo->ManaPerSecondPerLevel) && !m_spellInfo->HasAttribute(SPELL_ATTR2_NO_TARGET_PER_SECOND_COST))
        m_timeCla = 1 * IN_MILLISECONDS;

    // also reset periodic counters
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (AuraEffect* aurEff = m_effects[i])
            aurEff->ResetTicks();
}

void Aura::RefreshTimers(bool periodicReset /*= false*/)
{
    m_maxDuration = CalcMaxDuration();
    RefreshDuration();
    Unit* caster = GetCaster();

    if (!caster)
    {
        return;
    }

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (AuraEffect* aurEff = m_effects[i])
        {
            aurEff->CalculatePeriodic(caster, periodicReset, false);
            aurEff->CalculatePeriodicData();
        }
    }
}

// xinef: dot's rolling function
void Aura::RefreshTimersWithMods()
{
    Unit* caster = GetCaster();
    m_maxDuration = CalcMaxDuration();
    if ((caster && caster->HasAuraTypeWithAffectMask(SPELL_AURA_PERIODIC_HASTE, m_spellInfo)) || m_spellInfo->HasAttribute(SPELL_ATTR5_SPELL_HASTE_AFFECTS_PERIODIC))
    {
        m_maxDuration = int32(m_maxDuration * caster->GetFloatValue(UNIT_MOD_CAST_SPEED));
    }

    // xinef: we should take ModSpellDuration into account, but none of the spells using this function is affected by contents of ModSpellDuration
    RefreshDuration();

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (AuraEffect* aurEff = m_effects[i])
        {
            aurEff->CalculatePeriodic(caster, false, false);
        }
    }
}

void Aura::SetCharges(uint8 charges)
{
    if (m_procCharges == charges)
        return;
    m_procCharges = charges;
    m_isUsingCharges = m_procCharges != 0;
    SetNeedClientUpdateForTargets();
}

uint8 Aura::CalcMaxCharges(Unit* caster) const
{
    uint32 maxProcCharges = m_spellInfo->ProcCharges;
    if (SpellProcEntry const* procEntry = sSpellMgr->GetSpellProcEntry(GetId()))
        maxProcCharges = procEntry->Charges;

    if (caster)
        if (Player* modOwner = caster->GetSpellModOwner())
            modOwner->ApplySpellMod(GetId(), SPELLMOD_CHARGES, maxProcCharges);
    return maxProcCharges;
}

bool Aura::ModCharges(int32 num, AuraRemoveMode removeMode)
{
    if (IsUsingCharges())
    {
        int32 charges = m_procCharges + num;
        int32 maxCharges = CalcMaxCharges();

        // limit charges (only on charges increase, charges may be changed manually)
        if ((num > 0) && (charges > int32(maxCharges)))
            charges = maxCharges;
        // we're out of charges, remove
        else if (charges <= 0)
        {
            Remove(removeMode);
            return true;
        }

        SetCharges(charges);
    }
    return false;
}

void Aura::SetStackAmount(uint8 stackAmount)
{
    m_stackAmount = stackAmount;
    Unit* caster = GetCaster();

    if (!caster)
        return;

    std::list<AuraApplication*> applications;
    GetApplicationList(applications);

    for (std::list<AuraApplication*>::const_iterator apptItr = applications.begin(); apptItr != applications.end(); ++apptItr)
        if (!(*apptItr)->GetRemoveMode())
            HandleAuraSpecificMods(*apptItr, caster, false, true);

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (HasEffect(i))
            m_effects[i]->ChangeAmount(m_effects[i]->CalculateAmount(caster), false, true);

    for (std::list<AuraApplication*>::const_iterator apptItr = applications.begin(); apptItr != applications.end(); ++apptItr)
        if (!(*apptItr)->GetRemoveMode())
            HandleAuraSpecificMods(*apptItr, caster, true, true);

    SetNeedClientUpdateForTargets();
}

bool Aura::ModStackAmount(int32 num, AuraRemoveMode removeMode, bool periodicReset /*= false*/)
{
    int32 stackAmount = m_stackAmount + num;

    // limit the stack amount (only on stack increase, stack amount may be changed manually)
    if ((num > 0) && (stackAmount > int32(m_spellInfo->StackAmount)))
    {
        // not stackable aura - set stack amount to 1
        if (!m_spellInfo->StackAmount)
            stackAmount = 1;
        else
            stackAmount = m_spellInfo->StackAmount;
    }
    // we're out of stacks, remove
    else if (stackAmount <= 0)
    {
        Remove(removeMode);
        return true;
    }

    bool refresh = stackAmount >= GetStackAmount() && (m_spellInfo->StackAmount || !m_spellInfo->HasAttribute(SPELL_ATTR1_AURA_UNIQUE));

    // Update stack amount
    if (refresh)
    {
        RefreshSpellMods();
        RefreshTimers(periodicReset);

        // reset charges
        SetCharges(CalcMaxCharges());
    }

    SetStackAmount(stackAmount);

    SetNeedClientUpdateForTargets();
    return false;
}

void Aura::RefreshSpellMods()
{
    for (Aura::ApplicationMap::const_iterator appIter = m_applications.begin(); appIter != m_applications.end(); ++appIter)
        if (Player* player = appIter->second->GetTarget()->ToPlayer())
            player->RestoreAllSpellMods(0, this);
}

bool Aura::HasMoreThanOneEffectForType(AuraType auraType) const
{
    uint32 count = 0;
    for (SpellEffectInfo const& spellEffectInfo : GetSpellInfo()->GetEffects())
        if (HasEffect(spellEffectInfo.EffectIndex) && spellEffectInfo.ApplyAuraName == auraType)
            ++count;

    return count > 1;
}

bool Aura::IsArea() const
{
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (HasEffect(i) && GetSpellInfo()->Effects[i].IsAreaAuraEffect())
            return true;
    }
    return false;
}

bool Aura::IsPassive() const
{
    return GetSpellInfo()->IsPassive();
}

bool Aura::IsDeathPersistent() const
{
    return GetSpellInfo()->IsDeathPersistent();
}

bool Aura::IsRemovedOnShapeLost(Unit* target) const
{
    return (GetCasterGUID() == target->GetGUID() && m_spellInfo->Stances && !m_spellInfo->HasAttribute(SPELL_ATTR2_ALLOW_WHILE_NOT_SHAPESHIFTED) && !m_spellInfo->HasAttribute(SPELL_ATTR0_NOT_SHAPESHIFTED));
}

bool Aura::CanBeSaved() const
{
    SpellInfo const* spellInfo = GetSpellInfo();

    if (spellInfo->HasAttribute(SPELL_ATTR0_CU_FORCE_AURA_SAVING))
    {
        return true;
    }

    if (spellInfo->HasAttribute(SPELL_ATTR0_CU_AURA_CANNOT_BE_SAVED))
    {
        return false;
    }

    if (IsPassive() || (spellInfo->HasAttribute(SPELL_ATTR0_DO_NOT_DISPLAY) && spellInfo->Stances))
    {
        return false;
    }

    // Xinef: do not save channel auras
    if (GetSpellInfo()->IsChanneled())
    {
        return false;
    }

    // Xinef: Check if aura is single target, not only spell info
    if (GetCasterGUID() != GetOwner()->GetGUID() && (GetSpellInfo()->IsSingleTarget() || IsSingleTarget()))
    {
        return false;
    }

    // don't save auras removed by proc system
    if (IsUsingCharges() && !GetCharges())
    {
        return false;
    }

    return true;
}

bool Aura::CanBeSentToClient() const
{
    return !IsPassive() || GetSpellInfo()->HasAreaAuraEffect() || HasEffectType(SPELL_AURA_ABILITY_IGNORE_AURASTATE);
}

bool Aura::IsSingleTargetWith(Aura const* aura) const
{
    // Same spell?
    if (GetSpellInfo()->IsRankOf(aura->GetSpellInfo()))
        return true;

    SpellSpecificType spec = GetSpellInfo()->GetSpellSpecific();
    // spell with single target specific types
    switch (spec)
    {
        case SPELL_SPECIFIC_JUDGEMENT:
        case SPELL_SPECIFIC_MAGE_POLYMORPH:
            if (aura->GetSpellInfo()->GetSpellSpecific() == spec)
                return true;
            break;
        default:
            break;
    }

    if (HasEffectType(SPELL_AURA_CONTROL_VEHICLE) && aura->HasEffectType(SPELL_AURA_CONTROL_VEHICLE))
        return true;

    return false;
}

void Aura::UnregisterSingleTarget()
{
    ASSERT(m_isSingleTarget);
    Unit* caster = GetCaster();
    if (!caster)
    {
        LOG_INFO("spells", "Aura::UnregisterSingleTarget: (A1) - {}, {}, {}, {}", GetId(), GetOwner()->GetTypeId(), GetOwner()->GetEntry(), GetOwner()->GetName());
        LOG_ERROR("spells", "Aura::UnregisterSingleTarget: No caster was found."); //ASSERT(caster);
    }
    else
        caster->GetSingleCastAuras().remove(this);

    SetIsSingleTarget(false);
}

int32 Aura::CalcDispelChance(Unit* auraTarget, bool offensive) const
{
    // we assume that aura dispel chance is 100% on start
    // need formula for level difference based chance
    int32 resistChance = 0;

    // Apply dispel mod from aura caster
    if (Unit* caster = GetCaster())
        if (Player* modOwner = caster->GetSpellModOwner())
            modOwner->ApplySpellMod(GetId(), SPELLMOD_RESIST_DISPEL_CHANCE, resistChance);

    // Dispel resistance from target SPELL_AURA_MOD_DISPEL_RESIST
    // Only affects offensive dispels
    if (offensive && auraTarget)
        resistChance += auraTarget->GetTotalAuraModifier(SPELL_AURA_MOD_DISPEL_RESIST);

    resistChance = resistChance < 0 ? 0 : resistChance;
    resistChance = resistChance > 100 ? 100 : resistChance;
    return 100 - resistChance;
}

void Aura::SetLoadedState(int32 maxduration, int32 duration, int32 charges, uint8 stackamount, uint8 recalculateMask, int32* amount)
{
    m_maxDuration = maxduration;
    m_duration = duration;
    m_procCharges = charges;
    m_isUsingCharges = m_procCharges != 0;
    m_stackAmount = stackamount;
    Unit* caster = GetCaster();
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (m_effects[i])
        {
            m_effects[i]->SetAmount(amount[i]);
            m_effects[i]->SetCanBeRecalculated(recalculateMask & (1 << i));
            m_effects[i]->CalculatePeriodic(caster, false, true);
            m_effects[i]->CalculateSpellMod();
            m_effects[i]->RecalculateAmount(caster);
        }
}

bool Aura::HasEffectType(AuraType type) const
{
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (HasEffect(i) && m_effects[i]->GetAuraType() == type)
            return true;
    }
    return false;
}

void Aura::RecalculateAmountOfEffects()
{
    ASSERT (!IsRemoved());
    Unit* caster = GetCaster();
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (HasEffect(i))
            m_effects[i]->RecalculateAmount(caster);
}

void Aura::HandleAllEffects(AuraApplication* aurApp, uint8 mode, bool apply)
{
    ASSERT (!IsRemoved());
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        if (m_effects[i] && !IsRemoved())
            m_effects[i]->HandleEffect(aurApp, mode, apply);
}

void Aura::GetApplicationList(std::list<AuraApplication*>& applicationList) const
{
    for (Aura::ApplicationMap::const_iterator appIter = m_applications.begin(); appIter != m_applications.end(); ++appIter)
    {
        if (appIter->second->GetEffectMask())
            applicationList.push_back(appIter->second);
    }
}

void Aura::SetNeedClientUpdateForTargets() const
{
    for (ApplicationMap::const_iterator appIter = m_applications.begin(); appIter != m_applications.end(); ++appIter)
        appIter->second->SetNeedClientUpdate();
}

// trigger effects on real aura apply/remove
void Aura::HandleAuraSpecificMods(AuraApplication const* aurApp, Unit* caster, bool apply, bool onReapply)
{
    Unit* target = aurApp->GetTarget();
    AuraRemoveMode removeMode = aurApp->GetRemoveMode();
    // handle spell_area table
    SpellAreaForAreaMapBounds saBounds = sSpellMgr->GetSpellAreaForAuraMapBounds(GetId());
    if (saBounds.first != saBounds.second)
    {
        uint32 zone, area;
        target->GetZoneAndAreaId(zone, area);

        for (SpellAreaForAreaMap::const_iterator itr = saBounds.first; itr != saBounds.second; ++itr)
        {
            // some auras remove at aura remove
            if (!itr->second->IsFitToRequirements(target->ToPlayer(), zone, area) && !apply)
                target->RemoveAurasDueToSpell(itr->second->spellId);
            // some auras applied at aura apply
            else if (itr->second->autocast)
            {
                if (!target->HasAura(itr->second->spellId))
                    target->CastSpell(target, itr->second->spellId, true);
            }
        }
    }

    // handle spell_linked_spell table
    if (!onReapply)
    {
        // apply linked auras
        if (apply)
        {
            if (std::vector<int32> const* spellTriggered = sSpellMgr->GetSpellLinked(GetId() + SPELL_LINK_AURA))
            {
                for (std::vector<int32>::const_iterator itr = spellTriggered->begin(); itr != spellTriggered->end(); ++itr)
                {
                    if (*itr < 0)
                        target->ApplySpellImmune(GetId(), IMMUNITY_ID, -(*itr), true);
                    else if (caster)
                        caster->AddAura(*itr, target);
                }
            }
        }
        else
        {
            // remove linked auras
            if (std::vector<int32> const* spellTriggered = sSpellMgr->GetSpellLinked(-(int32)GetId()))
            {
                for (std::vector<int32>::const_iterator itr = spellTriggered->begin(); itr != spellTriggered->end(); ++itr)
                {
                    if (*itr < 0)
                        target->RemoveAurasDueToSpell(-(*itr));
                    else if (removeMode != AURA_REMOVE_BY_DEATH)
                        target->CastSpell(target, *itr, true, nullptr, nullptr, GetCasterGUID());
                }
            }
            if (std::vector<int32> const* spellTriggered = sSpellMgr->GetSpellLinked(GetId() + SPELL_LINK_AURA))
            {
                for (std::vector<int32>::const_iterator itr = spellTriggered->begin(); itr != spellTriggered->end(); ++itr)
                {
                    if (*itr < 0)
                        target->ApplySpellImmune(GetId(), IMMUNITY_ID, -(*itr), false);
                    else
                        target->RemoveAura(*itr, GetCasterGUID(), 0, removeMode);
                }
            }
        }
    }
    else if (apply)
    {
        // modify stack amount of linked auras
        if (std::vector<int32> const* spellTriggered = sSpellMgr->GetSpellLinked(GetId() + SPELL_LINK_AURA))
        {
            for (std::vector<int32>::const_iterator itr = spellTriggered->begin(); itr != spellTriggered->end(); ++itr)
                if (*itr > 0)
                    if (Aura* triggeredAura = target->GetAura(*itr, GetCasterGUID()))
                        triggeredAura->ModStackAmount(GetStackAmount() - triggeredAura->GetStackAmount());
        }
    }

    // mods at aura apply
    if (apply)
    {
        switch (GetSpellInfo()->SpellFamilyName)
        {
            case SPELLFAMILY_GENERIC:
                switch (GetId())
                {
                    case 32474: // Buffeting Winds of Susurrus
                        if (target->IsPlayer())
                            target->ToPlayer()->ActivateTaxiPathTo(506, GetId());
                        break;
                    case 33572: // Gronn Lord's Grasp, becomes stoned
                        if (GetStackAmount() >= 5 && !target->HasAura(33652))
                            target->CastSpell(target, 33652, true);
                        break;
                    case 50836: //Petrifying Grip, becomes stoned
                        if (GetStackAmount() >= 5 && !target->HasAura(50812))
                            target->CastSpell(target, 50812, true);
                        break;
                    case 60970: // Heroic Fury (remove Intercept cooldown)
                        if (target->IsPlayer())
                            target->ToPlayer()->RemoveSpellCooldown(20252, true);
                        break;
                }
                break;
            case SPELLFAMILY_MAGE:
                if (!caster)
                    break;
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x00000001 && GetSpellInfo()->SpellFamilyFlags[2] & 0x00000008)
                {
                    // Glyph of Fireball
                    if (caster->HasAura(56368))
                        SetDuration(0);
                }
                else if (GetSpellInfo()->SpellFamilyFlags[0] & 0x00000020 && GetSpellInfo()->SpellVisual[0] == 13)
                {
                    // Glyph of Frostbolt
                    if (caster->HasAura(56370))
                        SetDuration(0);
                }
                /// @todo: This should be moved to similar function in spell::hit
                else if (GetSpellInfo()->SpellFamilyFlags[0] & 0x01000000)
                {
                    // Polymorph Sound - Sheep && Penguin
                    if (GetSpellInfo()->SpellIconID == 82 && GetSpellInfo()->SpellVisual[0] == 12978)
                    {
                        // Glyph of the Penguin
                        if (caster->HasAura(52648))
                            caster->CastSpell(target, 61635, true);
                        else
                            caster->CastSpell(target, 61634, true);
                    }

                    if (Creature* creatureTarget = target->ToCreature())
                    {
                        creatureTarget->CallAssistance(caster);
                    }
                }
                switch (GetId())
                {
                    case 12536: // Clearcasting
                    case 12043: // Presence of Mind
                        // Arcane Potency
                        if (AuraEffect const* aurEff = caster->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_MAGE, 2120, 0))
                        {
                            uint32 spellId = 0;

                            switch (aurEff->GetId())
                            {
                                case 31571:
                                    spellId = 57529;
                                    break;
                                case 31572:
                                    spellId = 57531;
                                    break;
                                default:
                                    LOG_ERROR("spells.aura", "Aura::HandleAuraSpecificMods: Unknown rank of Arcane Potency ({}) found", aurEff->GetId());
                            }
                            if (spellId)
                                caster->CastSpell(caster, spellId, true);
                        }
                        break;
                    case 44544: // Fingers of Frost
                        {
                            // See if we already have the indicator aura. If not, create one.
                            if (Aura* aur = target->GetAura(74396))
                            {
                                // Aura already there. Refresh duration and set original charges
                                aur->SetCharges(2);
                                aur->RefreshDuration();
                            }
                            else
                                target->AddAura(74396, target);
                        }
                        break;
                    case 12494: // Frostbite, synchronise with Fingers of Frost
                    {
                        // Find Fingers of Frost
                        if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_AURA_PROC_TRIGGER_SPELL, SPELLFAMILY_MAGE, 2947, EFFECT_0))
                        {
                            if (SpellInfo const* triggeringSpellInfo = GetTriggeredByAuraSpellInfo())
                            {
                                uint8 fbRank = sSpellMgr->GetSpellRank(triggeringSpellInfo->Id);
                                uint8 fofRank = sSpellMgr->GetSpellRank(aurEff->GetId());
                                uint8 chance = uint8(std::ceil(fofRank * fbRank * 16.6f));

                                if (roll_chance_i(chance))
                                {
                                    caster->CastSpell(caster, aurEff->GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, true);
                                }
                            }
                        }
                        break;
                    }
                    default:
                        break;
                }
                break;
            case SPELLFAMILY_DRUID:
                if (!caster)
                    break;
                // Rejuvenation
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x10 && GetEffect(0))
                {
                    // Druid T8 Restoration 4P Bonus
                    if (caster->GetAuraEffectDummy(64760))
                    {
                        uint32 damage = GetEffect(0)->GetAmount();
                        damage = target->SpellHealingBonusTaken(caster, GetSpellInfo(), damage, DOT);

                        int32 basepoints0 = damage;
                        caster->CastCustomSpell(target, 64801, &basepoints0, nullptr, nullptr, true, nullptr, GetEffect(0));
                    }
                }
                break;
            case SPELLFAMILY_PRIEST:
                if (!caster)
                    break;
                // Devouring Plague
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x02000000 && GetEffect(0))
                {
                    // Improved Devouring Plague
                    if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_PRIEST, 3790, 1))
                    {
                        uint32 damage = GetEffect(0)->GetAmount();
                        damage = target->SpellDamageBonusTaken(caster, GetSpellInfo(), damage, DOT);
                        int32 basepoints0 = aurEff->GetAmount() * GetEffect(0)->GetTotalTicks() * int32(damage) / 100;
                        int32 heal = int32(CalculatePct(basepoints0, 15));

                        caster->CastCustomSpell(target, 63675, &basepoints0, nullptr, nullptr, true, nullptr, GetEffect(0));
                        caster->CastCustomSpell(caster, 75999, &heal, nullptr, nullptr, true, nullptr, GetEffect(0));
                    }
                }
                // Power Word: Shield
                else if (m_spellInfo->SpellFamilyFlags[0] & 0x1 && m_spellInfo->SpellFamilyFlags[2] & 0x400 && GetEffect(0))
                {
                    // Glyph of Power Word: Shield
                    if (AuraEffect* glyph = caster->GetAuraEffect(55672, 0))
                    {
                        // instantly heal m_amount% of the absorb-value
                        int32 heal = glyph->GetAmount() * GetEffect(0)->GetAmount() / 100;
                        caster->CastCustomSpell(GetUnitOwner(), 56160, &heal, nullptr, nullptr, true, 0, GetEffect(0));
                    }
                }
                break;
            case SPELLFAMILY_ROGUE:
                // Sprint (skip non player casted spells by category)
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x40 && GetSpellInfo()->GetCategory() == 44)
                    // in official maybe there is only one icon?
                    if (target->HasAura(58039)) // Glyph of Blurred Speed
                        target->CastSpell(target, 61922, true); // Sprint (waterwalk)
                break;
            case SPELLFAMILY_SHAMAN:
            {
                // Ghost Wolf Speed (PvP 58 lvl set)
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x00000800 && target->HasAura(22801) && target->GetLevel() <= 60)
                {
                    int32 bp0 = 15;
                    target->CastCustomSpell(target, 47017, &bp0, 0, 0, true);
                }
                break;
            }
            case SPELLFAMILY_DEATHKNIGHT:
                if (!caster)
                    break;
                // Frost Fever and Blood Plague
                if (GetSpellInfo()->SpellFamilyFlags[2] & 0x2)
                {
                    // Can't proc on self
                    if (GetCasterGUID() == target->GetGUID())
                        break;

                    AuraEffect* aurEff = nullptr;
                    // Ebon Plaguebringer / Crypt Fever
                    Unit::AuraEffectList const& TalentAuras = caster->GetAuraEffectsByType(SPELL_AURA_OVERRIDE_CLASS_SCRIPTS);
                    for (Unit::AuraEffectList::const_iterator itr = TalentAuras.begin(); itr != TalentAuras.end(); ++itr)
                    {
                        if ((*itr)->GetMiscValue() == 7282)
                        {
                            aurEff = *itr;
                            // Ebon Plaguebringer - end search if found
                            if ((*itr)->GetSpellInfo()->SpellIconID == 1766)
                                break;
                        }
                    }
                    if (aurEff)
                    {
                        uint32 spellId = 0;
                        switch (aurEff->GetId())
                        {
                            // Ebon Plague
                            case 51161:
                                spellId = 51735;
                                break;
                            case 51160:
                                spellId = 51734;
                                break;
                            case 51099:
                                spellId = 51726;
                                break;
                            // Crypt Fever
                            case 49632:
                                spellId = 50510;
                                break;
                            case 49631:
                                spellId = 50509;
                                break;
                            case 49032:
                                spellId = 50508;
                                break;
                            default:
                                LOG_ERROR("spells.aura", "Aura::HandleAuraSpecificMods: Unknown rank of Crypt Fever/Ebon Plague ({}) found", aurEff->GetId());
                        }
                        caster->CastSpell(target, spellId, true, 0, GetEffect(0));
                    }
                }
                // Unholy blight
                if (GetId() == 50536)
                {
                    if (caster->IsFriendlyTo(target))
                        SetDuration(0);
                }
                break;
            case SPELLFAMILY_POTION:
                // Alchemy: Mixology
                if (caster && caster->HasAura(53042) && caster->IsPlayer() && !caster->ToPlayer()->GetSession()->PlayerLoading())
                {
                    if (sSpellMgr->IsSpellMemberOfSpellGroup(GetId(), SPELL_GROUP_ELIXIR_BATTLE) || sSpellMgr->IsSpellMemberOfSpellGroup(GetId(), SPELL_GROUP_ELIXIR_GUARDIAN))
                    {
                        if (caster->HasSpell(GetSpellInfo()->Effects[EFFECT_0].TriggerSpell))
                        {
                            for (int i = 0; i < MAX_SPELL_EFFECTS; ++i)
                                if (GetEffect(i))
                                    GetEffect(i)->SetAmount(CalculatePct(GetEffect(i)->GetAmount(), 100 + sSpellMgr->GetSpellMixologyBonus(GetId())));

                            SetMaxDuration(caster->CalcSpellDuration(GetSpellInfo()) * 2);
                            SetDuration(GetMaxDuration());
                        }
                    }
                }
                break;
        }
    }
    // mods at aura remove
    else
    {
        switch (GetSpellInfo()->SpellFamilyName)
        {
            case SPELLFAMILY_GENERIC:
                if (!caster)
                    break;
                switch (GetId())
                {
                    case 61987: // Avenging Wrath
                        // Remove the immunity shield marker on Avenging Wrath removal if Forbearance is not present
                        if (target->HasAura(61988) && !target->HasAura(25771))
                            target->RemoveAura(61988);
                        break;
                    case 72368: // Shared Suffering
                    case 72369:
                        if (AuraEffect* aurEff = GetEffect(0))
                        {
                            int32 remainingDamage = aurEff->GetAmount() * (aurEff->GetTotalTicks() - aurEff->GetTickNumber());
                            if (remainingDamage > 0)
                                caster->CastCustomSpell(caster, 72373, nullptr, &remainingDamage, nullptr, true);
                        }
                        break;
                }
                break;
            case SPELLFAMILY_MAGE:
            {
                // Polymorph
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x01000000)
                {
                    if (Creature* creatureTarget = target->ToCreature())
                    {
                        creatureTarget->SetNoCallAssistance(false);
                    }
                }
                switch (GetId())
                {
                    case 66: // Invisibility
                        if (removeMode != AURA_REMOVE_BY_EXPIRE)
                            break;
                        target->CastSpell(target, 32612, true, nullptr, GetEffect(1));
                        target->CombatStop();
                        break;
                    case 74396: // Fingers of Frost
                        // Remove the IGNORE_AURASTATE aura
                        target->RemoveAurasDueToSpell(44544);
                        break;
                    case 44401: // Missile Barrage
                    case 48108: // Hot Streak
                    case 57761: // Fireball!
                        if (removeMode != AURA_REMOVE_BY_EXPIRE || aurApp->GetBase()->IsExpired())
                            break;
                        if (target->HasAura(70752)) // Item - Mage T10 2P Bonus
                            target->CastSpell(target, 70753, true); // Pushing the Limit
                        break;
                    default:
                        break;
                }
                if (!caster)
                    break;
                // Ice barrier - dispel/absorb remove
                if (removeMode == AURA_REMOVE_BY_ENEMY_SPELL && GetSpellInfo()->SpellFamilyFlags[1] & 0x1)
                {
                    // Shattered Barrier
                    if (AuraEffect* absorb = GetEffect(EFFECT_0))
                        if (absorb->GetAmount() <= 0) // removed by damage, not dispel
                            if (AuraEffect* dummy = caster->GetDummyAuraEffect(SPELLFAMILY_MAGE, 2945, 0))
                                if (roll_chance_i(dummy->GetSpellInfo()->ProcChance))
                                    caster->CastSpell(target, 55080, true, nullptr, GetEffect(0));
                }
                break;
            }
            case SPELLFAMILY_WARRIOR:
                if (!caster)
                    break;
                [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
            case SPELLFAMILY_WARLOCK:
                if (!caster)
                    break;
                if (GetSpellInfo()->SpellFamilyFlags[1] & 0x00000400)
                {
                    if (AuraEffect* aurEff = caster->GetAuraEffect(SPELL_AURA_DUMMY, SPELLFAMILY_WARLOCK, 98, 0))
                    {
                        uint32 spellId = 0;
                        switch (aurEff->GetId())
                        {
                            case 53759:
                                spellId = 60947;
                                break;
                            case 53754:
                                spellId = 60946;
                                break;
                            default:
                                LOG_ERROR("spells.aura", "Aura::HandleAuraSpecificMods: Unknown rank of Improved Fear ({}) found", aurEff->GetId());
                        }
                        if (spellId)
                            caster->CastSpell(target, spellId, true);
                    }
                }
                break;
            case SPELLFAMILY_PRIEST:
                if (!caster)
                    break;
                // Shadow word: Pain // Vampiric Touch
                if (removeMode == AURA_REMOVE_BY_ENEMY_SPELL && (GetSpellInfo()->SpellFamilyFlags[0] & 0x00008000 || GetSpellInfo()->SpellFamilyFlags[1] & 0x00000400))
                {
                    // Shadow Affinity
                    if (AuraEffect const* aurEff = caster->GetDummyAuraEffect(SPELLFAMILY_PRIEST, 178, 1))
                    {
                        int32 basepoints0 = aurEff->GetAmount() * caster->GetCreateMana() / 100;
                        caster->CastCustomSpell(caster, 64103, &basepoints0, nullptr, nullptr, true, nullptr, GetEffect(0));
                    }
                }
                // Power word: shield
                else if (removeMode == AURA_REMOVE_BY_ENEMY_SPELL && GetSpellInfo()->SpellFamilyFlags[0] & 0x00000001)
                {
                    // Rapture
                    if (Aura const* aura = caster->GetAuraOfRankedSpell(47535))
                    {
                        // check cooldown
                        if (caster->IsPlayer())
                        {
                            if (caster->ToPlayer()->HasSpellCooldown(aura->GetId()))
                            {
                                // This additional check is needed to add a minimal delay before cooldown in in effect
                                // to allow all bubbles broken by a single damage source proc mana return
                                if (caster->ToPlayer()->GetSpellCooldownDelay(aura->GetId()) <= 11500)
                                    break;
                            }
                            else    // and add if needed
                                caster->ToPlayer()->AddSpellCooldown(aura->GetId(), 0, 12 * IN_MILLISECONDS);
                        }

                        // effect on caster
                        if (AuraEffect const* aurEff = aura->GetEffect(0))
                        {
                            float multiplier = (float)aurEff->GetAmount();
                            if (aurEff->GetId() == 47535)
                                multiplier -= 0.5f;
                            else if (aurEff->GetId() == 47537)
                                multiplier += 0.5f;

                            int32 basepoints0 = int32(CalculatePct(caster->GetMaxPower(POWER_MANA), multiplier));
                            caster->CastCustomSpell(caster, 47755, &basepoints0, nullptr, nullptr, true);
                        }
                        // effect on aura target
                        if (AuraEffect const* aurEff = aura->GetEffect(1))
                        {
                            if (!roll_chance_i(aurEff->GetAmount()))
                                break;

                            int32 triggeredSpellId = 0;
                            switch (target->getPowerType())
                            {
                                case POWER_MANA:
                                    {
                                        int32 basepoints0 = int32(CalculatePct(target->GetMaxPower(POWER_MANA), 2));
                                        caster->CastCustomSpell(target, 63654, &basepoints0, nullptr, nullptr, true);
                                        break;
                                    }
                                case POWER_RAGE:
                                    triggeredSpellId = 63653;
                                    break;
                                case POWER_ENERGY:
                                    triggeredSpellId = (!target->HasAura(70405) ? 63655 : 0);
                                    break;
                                case POWER_RUNIC_POWER:
                                    triggeredSpellId = 63652;
                                    break;
                                default:
                                    break;
                            }
                            if (triggeredSpellId)
                                caster->CastSpell(target, triggeredSpellId, true);
                        }
                    }
                }
                switch (GetId())
                {
                    case 47788: // Guardian Spirit
                    {
                        if (removeMode != AURA_REMOVE_BY_EXPIRE)
                            break;
                        if (!caster->IsPlayer())
                            break;

                        Player* player = caster->ToPlayer();
                        // Glyph of Guardian Spirit
                        if (AuraEffect* aurEff = player->GetAuraEffect(63231, 0))
                        {
                            if (!player->HasSpellCooldown(47788))
                                break;

                            player->AddSpellCooldown(GetSpellInfo()->Id, 0, aurEff->GetAmount()*IN_MILLISECONDS);

                            WorldPacket data(SMSG_MODIFY_COOLDOWN, 4 + 8 + 4);
                            data << uint32(GetId());                  // Spell ID
                            data << player->GetGUID();                // Player GUID
                            data << int32(-110000);                   // Cooldown mod in milliseconds
                            player->SendDirectMessage(&data);
                        }
                        break;
                    }
                    case 47585: // Dispersion (fixed bug invisible as a Shadow Priest)
                    {
                        if (target->IsMounted())
                        {
                            target->CastSpell(target, 53444, true);
                        }
                        break;
                    }
                }
                break;
            case SPELLFAMILY_ROGUE:
                // Remove Vanish on stealth remove
                if (GetId() == 1784)
                {
                    target->RemoveAurasWithFamily(SPELLFAMILY_ROGUE, 0x800, 0, 0, ObjectGuid::Empty);
                    target->RemoveAurasDueToSpell(18461);
                }
                break;
            case SPELLFAMILY_SHAMAN:
            {
                // Ghost Wolf Speed (PvP 58 lvl set)
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x00000800)
                {
                    target->RemoveAurasDueToSpell(47017);
                }
                // Lightning Shield vs The Earthshatterer 8/9 set bonus
                if (GetSpellInfo()->SpellFamilyFlags[0] & 0x00000400)
                {
                    target->RemoveAurasDueToSpell(28820);
                }
                break;
            }
            case SPELLFAMILY_DEATHKNIGHT:
                // Blood of the North
                // Reaping
                // Death Rune Mastery
                if (GetSpellInfo()->SpellIconID == 3041 || GetSpellInfo()->SpellIconID == 22 || GetSpellInfo()->SpellIconID == 2622)
                {
                    if (!GetEffect(0) || GetEffect(0)->GetAuraType() != SPELL_AURA_PERIODIC_DUMMY)
                        break;
                    if (!target->IsPlayer())
                        break;
                    if (!target->ToPlayer()->IsClass(CLASS_DEATH_KNIGHT, CLASS_CONTEXT_ABILITY))
                        break;

                    // aura removed - remove death runes
                    target->ToPlayer()->RemoveRunesByAuraEffect(GetEffect(0));
                }
                break;
            case SPELLFAMILY_PALADIN:
                // Remove the immunity shield marker on Forbearance removal if AW marker is not present
                if (GetId() == 25771 && target->HasAura(61988) && !target->HasAura(61987))
                    target->RemoveAura(61988);
                break;
            case SPELLFAMILY_HUNTER:
                // Glyph of Freezing Trap
                if ((GetSpellInfo()->SpellFamilyFlags[0] & 0x00000008) && caster && caster->HasAura(56845))
                {
                    target->CastSpell(target, 61394, true);
                }
                break;
        }
    }

    // mods at aura apply or remove
    switch (GetSpellInfo()->SpellFamilyName)
    {
        case SPELLFAMILY_ROGUE:
            // Stealth
            if (GetSpellInfo()->SpellFamilyFlags[0] & 0x00400000)
            {
                // Master of Subtlety
                if (AuraEffect const* aurEff = target->GetAuraEffectOfRankedSpell(31221, 0))
                {
                    if (!apply)
                        target->CastSpell(target, 31666, true);
                    else
                    {
                        // Remove counter aura
                        target->RemoveAurasDueToSpell(31666);

                        int32 amount = aurEff->GetAmount();
                        target->CastCustomSpell(target, 31665, &amount, nullptr, nullptr, true);
                    }
                }
                // Overkill
                if (target->HasAura(58426))
                {
                    if (!apply)
                        target->CastSpell(target, 58428, true);
                    else
                    {
                        // Remove counter aura
                        target->RemoveAurasDueToSpell(58428);

                        target->CastSpell(target, 58427, true);
                    }
                }
            }
            break;
        case SPELLFAMILY_HUNTER:
            switch (GetId())
            {
                case 19574: // Bestial Wrath
                    // The Beast Within cast on owner if talent present
                    if (Unit* owner = target->GetOwner())
                    {
                        // Search talent
                        if (owner->HasAura(34692))
                        {
                            if (apply)
                                owner->CastSpell(owner, 34471, true, 0, GetEffect(0));
                            else
                                owner->RemoveAurasDueToSpell(34471);
                        }
                    }
                    break;
                case 34026: // Kill Command
                    // Dungeon Set 3
                    if (caster->HasAura(37483))
                    {
                        if (apply)
                        {
                            caster->CastSpell(caster, 37482, true);
                        }
                    }
                    break;
            }
            break;
        case SPELLFAMILY_PALADIN:
            switch (GetId())
            {
                case 31842: // Divine Illumination
                    // Item - Paladin T10 Holy 2P Bonus
                    if (caster && caster->HasAura(70755))
                    {
                        if (apply)
                            target->CastSpell(target, 71166, true);
                        else
                            target->RemoveAurasDueToSpell(71166);
                    }
                    break;
            }
            break;
    }
}

bool Aura::CanBeAppliedOn(Unit* target)
{
    // unit not in world or during remove from world
    if (!target->IsInWorld() || target->IsDuringRemoveFromWorld())
    {
        // area auras mustn't be applied
        if (GetOwner() != target)
            return false;
        // not selfcasted single target auras mustn't be applied
        if (GetCasterGUID() != GetOwner()->GetGUID() && GetSpellInfo()->IsSingleTarget())
            return false;
        return true;
    }
    else
        return CheckAreaTarget(target);
}

bool Aura::CheckAreaTarget(Unit* target)
{
    return CallScriptCheckAreaTargetHandlers(target);
}

bool Aura::IsAuraStronger(Aura const* newAura) const
{
    for (uint8 i = EFFECT_0; i < MAX_SPELL_EFFECTS; ++i)
    {
        AuraEffect* thisEffect = GetEffect(i);
        if (!thisEffect)
            continue;

        AuraEffect* newEffect = nullptr;
        for (uint8 j = EFFECT_0; j < MAX_SPELL_EFFECTS; ++j)
        {
            newEffect = newAura->GetEffect(j);
            if (!newEffect || thisEffect->GetAuraType() != newEffect->GetAuraType() || thisEffect->GetMiscValue() != newEffect->GetMiscValue())
                continue;

            // xinef: assume that all spells are either positive or negative, otherwise they should not be in one group
            int32 curValue = std::abs(thisEffect->GetAmount());
            if (curValue < std::abs(newEffect->GetAmount()))
                return true;

            if (curValue == std::abs(newEffect->GetAmount()))
                if (!IsPassive() && !IsPermanent() && GetDuration() < newAura->GetDuration())
                    return true;
        }
    }

    return false;
}

bool Aura::CanStackWith(Aura const* existingAura) const
{
    // Can stack with self
    if (this == existingAura)
        return true;

    SpellInfo const* existingSpellInfo = existingAura->GetSpellInfo();
    bool sameCaster = GetCasterGUID() == existingAura->GetCasterGUID();

    // Dynobj auras always stack
    // xinef: dont allow different ranks (or the same rank) of same spell to stack (many flamestrikes for example)
    if (existingAura->GetType() == DYNOBJ_AURA_TYPE)
    {
        // xinef: desecration lag fix - bound this condition to periodics
        if (sameCaster && GetSpellInfo()->Id == existingSpellInfo->Id && GetSpellInfo()->HasAura(SPELL_AURA_PERIODIC_DAMAGE))
            return false;
        return true;
    }

    // passive auras don't stack with another rank of the spell cast by same caster
    // Exception: item-sourced auras from different items can stack (e.g., weapon imbues on MH/OH)
    if (IsPassive() && sameCaster && (m_spellInfo->IsDifferentRankOf(existingSpellInfo) || (m_spellInfo->Id == existingSpellInfo->Id && m_castItemGuid.IsEmpty())))
    {
        // Allow stacking if both auras are from different items
        if (!(GetCastItemGUID() && existingAura->GetCastItemGUID() && GetCastItemGUID() != existingAura->GetCastItemGUID()))
            return false;
    }

    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        // prevent remove triggering aura by triggered aura
        if (existingSpellInfo->Effects[i].TriggerSpell == GetId()
                // prevent remove triggered aura by triggering aura refresh
                || m_spellInfo->Effects[i].TriggerSpell == existingAura->GetId())
            return true;
    }

    // check spell specific stack rules
    if (m_spellInfo->IsAuraExclusiveBySpecificWith(existingSpellInfo)
            || (sameCaster && m_spellInfo->IsAuraExclusiveBySpecificPerCasterWith(existingSpellInfo)))
        return false;

    // check spell group stack rules
    switch (sSpellMgr->CheckSpellGroupStackRules(m_spellInfo, existingSpellInfo))
    {
        case SPELL_GROUP_STACK_RULE_EXCLUSIVE:
        case SPELL_GROUP_STACK_RULE_EXCLUSIVE_HIGHEST: // if it reaches this point, existing aura is lower/equal
            return false;
        case SPELL_GROUP_STACK_RULE_EXCLUSIVE_FROM_SAME_CASTER:
            if (sameCaster)
                return false;
            break;
        case SPELL_GROUP_STACK_RULE_DEFAULT:
        case SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT:
        default:
            break;
    }

    if (m_spellInfo->SpellFamilyName != existingSpellInfo->SpellFamilyName)
        return true;

    if (!sameCaster)
    {
        // Channeled auras can stack if not forbidden by db or aura type
        if (existingAura->GetSpellInfo()->IsChanneled())
            return true;

        if (m_spellInfo->HasAttribute(SPELL_ATTR3_DOT_STACKING_RULE))
            return true;

        // check same periodic auras
        for (uint32 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            switch (m_spellInfo->Effects[i].ApplyAuraName)
            {
                // DOT or HOT from different casters will stack
                case SPELL_AURA_PERIODIC_DAMAGE:
                case SPELL_AURA_PERIODIC_DUMMY:
                case SPELL_AURA_PERIODIC_HEAL:
                case SPELL_AURA_PERIODIC_TRIGGER_SPELL:
                case SPELL_AURA_PERIODIC_ENERGIZE:
                case SPELL_AURA_PERIODIC_MANA_LEECH:
                case SPELL_AURA_PERIODIC_LEECH:
                case SPELL_AURA_POWER_BURN:
                case SPELL_AURA_OBS_MOD_POWER:
                case SPELL_AURA_OBS_MOD_HEALTH:
                case SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE:
                    // periodic auras which target areas are not allowed to stack this way (replenishment for example)
                    if (m_spellInfo->Effects[i].IsTargetingArea() || existingSpellInfo->Effects[i].IsTargetingArea())
                        break;
                    return true;
                default:
                    break;
            }
        }
    }

    uint8 VehicleAura1 = 0;
    uint8 VehicleAura2 = 0;
    uint8 i = 0;
    while (i < MAX_SPELL_EFFECTS && !(VehicleAura1 && VehicleAura2))
    {
        if (m_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_CONTROL_VEHICLE)
            VehicleAura1 = i + 1;
        if (existingSpellInfo->Effects[i].ApplyAuraName == SPELL_AURA_CONTROL_VEHICLE)
            VehicleAura2 = i + 1;

        ++i;
    }

    if (VehicleAura1 && VehicleAura2)
    {
        Vehicle* veh = nullptr;
        if (GetOwner()->ToUnit())
            veh = GetOwner()->ToUnit()->GetVehicleKit();

        if (!veh)           // We should probably just let it stack. Vehicle system will prevent undefined behaviour later
            return true;

        // xinef: allow direct auras to stack if there is no passenger in this slot
        if (AuraEffect* aurEff = GetEffect(VehicleAura1 - 1))
            if (aurEff->GetAmount() > 0)
                if (!veh->GetPassenger(aurEff->GetAmount() - 1))
                    return true;

        if (!veh->GetAvailableSeatCount())
            return false;   // No empty seat available

        return true;        // Empty seat available (skip rest)
    }

    // spell of same spell rank chain
    if (m_spellInfo->IsRankOf(existingSpellInfo) && !(m_spellInfo->SpellFamilyName == SPELLFAMILY_HUNTER && m_spellInfo->SpellFamilyFlags[1] & 0x80000000))
    {
        // don't allow passive area auras to stack
        if (m_spellInfo->IsMultiSlotAura() && !IsArea())
            return true;

        // Allow item-sourced auras from different items to stack (e.g., weapon imbues on MH/OH, enchant procs)
        if ((IsPassive() || m_spellInfo->HasAttribute(SPELL_ATTR0_CU_ENCHANT_PROC)) && GetCastItemGUID() && existingAura->GetCastItemGUID() && GetCastItemGUID() != existingAura->GetCastItemGUID())
            return true;

        // same spell with same caster should not stack
        return false;
    }

    return true;
}

bool Aura::IsProcOnCooldown(TimePoint now) const
{
    if (GetType() == UNIT_AURA_TYPE)
        if (Player* player = GetUnitOwner()->ToPlayer())
            if (player->GetCommandStatus(CHEAT_COOLDOWN))
                return false;

    return m_procCooldown > now;
}

void Aura::AddProcCooldown(TimePoint cooldownEnd)
{
    m_procCooldown = cooldownEnd;
}

void Aura::AddProcCooldown(SpellProcEntry const* procEntry, TimePoint now)
{
    AddProcCooldown(now + procEntry->Cooldown);
}

void Aura::ResetProcCooldown()
{
    m_procCooldown = std::chrono::steady_clock::now();
}

void Aura::PrepareProcToTrigger(AuraApplication* aurApp, ProcEventInfo& eventInfo, TimePoint now)
{
    bool prepare = CallScriptPrepareProcHandlers(aurApp, eventInfo);
    if (!prepare)
        return;

    // take one charge, aura expiration will be handled in Aura::TriggerProcOnEvent (if needed)
    if (IsUsingCharges() && (!eventInfo.GetSpellInfo() || !eventInfo.GetSpellInfo()->HasAttribute(SPELL_ATTR6_DO_NOT_CONSUME_RESOURCES)))
    {
        --m_procCharges;
        SetNeedClientUpdateForTargets();
    }

    SpellProcEntry const* procEntry = sSpellMgr->GetSpellProcEntry(GetId());

    ASSERT(procEntry);

    // cooldowns should be added to the whole aura (see 51698 area aura)
    AddProcCooldown(now + procEntry->Cooldown);
}

uint8 Aura::GetProcEffectMask(AuraApplication* aurApp, ProcEventInfo& eventInfo, TimePoint now) const
{
    SpellProcEntry const* procEntry = sSpellMgr->GetSpellProcEntry(GetId());

    // only auras with spell proc entry can trigger proc
    if (!procEntry)
        return 0;

    // check spell triggering us
    if (Spell const* spell = eventInfo.GetProcSpell())
    {
        // Do not allow auras to proc from effect triggered from itself
        if (spell->GetTriggeredByAuraSpellInfo() == m_spellInfo)
            return 0;

        // check if aura can proc when spell is triggered (exception for hunter auto shot & wands)
        // Kill/killed/death events should not be blocked by the triggered-spell check -
        // the kill itself is the proc trigger, not the spell that dealt the killing blow
        if (!GetSpellInfo()->HasAttribute(SPELL_ATTR3_CAN_PROC_FROM_PROCS) &&
            !(procEntry->AttributesMask & PROC_ATTR_TRIGGERED_CAN_PROC) &&
            !(eventInfo.GetTypeMask() & AUTO_ATTACK_PROC_FLAG_MASK) &&
            !(eventInfo.GetTypeMask() & (PROC_FLAG_KILL | PROC_FLAG_KILLED | PROC_FLAG_DEATH)))
        {
            if (spell->IsTriggered() && !spell->GetSpellInfo()->HasAttribute(SPELL_ATTR3_NOT_A_PROC))
                return 0;
        }

        // do not allow aura proc if proc is caused by a spell cast by item
        if (spell->m_CastItem && (procEntry->AttributesMask & PROC_ATTR_CANT_PROC_FROM_ITEM_CAST))
            return 0;
    }

    // Don't consume stealth charges from friendly spells
    if (m_spellInfo->HasAura(SPELL_AURA_MOD_STEALTH))
    {
        if (SpellInfo const* spellInfo = eventInfo.GetSpellInfo())
            if (spellInfo->IsPositive() || !eventInfo.GetActor()->IsHostileTo(aurApp->GetTarget()) || spellInfo->HasAttribute(SPELL_ATTR0_CU_DONT_BREAK_STEALTH))
                return 0;
    }

    // check if we have charges to proc with
    if (IsUsingCharges() && !GetCharges())
        return 0;

    // check proc cooldown
    if (IsProcOnCooldown(now))
        return 0;

    // do checks against db data
    if (!sSpellMgr->CanSpellTriggerProcOnEvent(*procEntry, eventInfo))
        return 0;

    // check if spell was affected by this aura's spellmod (used by Arcane Potency and similar effects)
    // only applies when consuming charges or stacks
    if ((procEntry->AttributesMask & PROC_ATTR_REQ_SPELLMOD) && (IsUsingCharges() || (procEntry->AttributesMask & PROC_ATTR_USE_STACKS_FOR_CHARGES)))
    {
        Spell const* procSpell = eventInfo.GetProcSpell();
        if (!procSpell || procSpell->m_appliedMods.find(const_cast<Aura*>(this)) == procSpell->m_appliedMods.end())
            return 0;
    }

    // do checks using conditions table
    ConditionList conditions = sConditionMgr->GetConditionsForNotGroupedEntry(CONDITION_SOURCE_TYPE_SPELL_PROC, GetId());
    ConditionSourceInfo condInfo = ConditionSourceInfo(eventInfo.GetActor(), eventInfo.GetActionTarget());
    if (!sConditionMgr->IsObjectMeetToConditions(condInfo, conditions))
        return 0;

    // AuraScript Hook
    if (!const_cast<Aura*>(this)->CallScriptCheckProcHandlers(aurApp, eventInfo))
        return 0;

    // At least one effect has to pass checks to proc aura
    uint8 procEffectMask = aurApp->GetEffectMask();
    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
    {
        if (AuraEffect* aurEff = GetEffect(i))
        {
            if (procEffectMask & (1 << i))
            {
                if ((procEntry->DisableEffectsMask & (1u << i)) || !aurEff->CheckEffectProc(aurApp, eventInfo))
                    procEffectMask &= ~(1 << i);
            }
        }
    }

    if (!procEffectMask)
        return 0;

    // Check if current equipment meets aura requirements
    // do that only for passive spells
    Unit* target = aurApp->GetTarget();
    if (IsPassive() && target->IsPlayer() && GetSpellInfo()->EquippedItemClass != -1)
    {
        if (!GetSpellInfo()->HasAttribute(SPELL_ATTR3_NO_PROC_EQUIP_REQUIREMENT))
        {
            Item* item = nullptr;
            if (GetSpellInfo()->EquippedItemClass == ITEM_CLASS_WEAPON)
            {
                if (target->ToPlayer()->IsInFeralForm())
                    return 0;

                if (DamageInfo const* damageInfo = eventInfo.GetDamageInfo())
                {
                    switch (damageInfo->GetAttackType())
                    {
                        case BASE_ATTACK:
                            item = target->ToPlayer()->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
                            break;
                        case OFF_ATTACK:
                            item = target->ToPlayer()->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
                            break;
                        default:
                            item = target->ToPlayer()->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED);
                            break;
                    }
                }
            }
            else if (GetSpellInfo()->EquippedItemClass == ITEM_CLASS_ARMOR)
            {
                // Check if player is wearing shield
                item = target->ToPlayer()->GetUseableItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
            }

            if (!item || item->IsBroken() || !item->IsFitToSpellRequirements(GetSpellInfo()))
                return 0;
        }
    }

    float procChance = CalcProcChance(*procEntry, eventInfo);

    if (roll_chance_f(procChance))
        return procEffectMask;

    return 0;
}

float Aura::CalcProcChance(SpellProcEntry const& procEntry, ProcEventInfo& eventInfo) const
{
    float chance = procEntry.Chance;
    // calculate chances depending on unit with caster's data
    // so talents modifying chances and judgements will have properly calculated proc chance
    if (Unit* caster = GetCaster())
    {
        // If PPM exists calculate chance from PPM
        if ((eventInfo.GetDamageInfo() || eventInfo.GetHealInfo()) && procEntry.ProcsPerMinute != 0)
        {
            SpellInfo const* procSpell = eventInfo.GetSpellInfo();
            uint32 attackSpeed = 0;
            if (!procSpell || procSpell->DmgClass == SPELL_DAMAGE_CLASS_MELEE || procSpell->IsRangedWeaponSpell())
            {
                attackSpeed = caster->GetAttackTime(eventInfo.GetDamageInfo()->GetAttackType());
            }
            else // spells use their cast time for PPM calculations
            {
                if (procSpell->CastTimeEntry)
                    attackSpeed = procSpell->CastTimeEntry->CastTime;

                // instants and fast spells use 1.5s cast speed
                if (attackSpeed < 1500)
                    attackSpeed = 1500;
            }
            chance = caster->GetPPMProcChance(attackSpeed, procEntry.ProcsPerMinute, GetSpellInfo());
        }
        // apply chance modifer aura, applies also to ppm chance (see improved judgement of light spell)
        if (Player* modOwner = caster->GetSpellModOwner())
            modOwner->ApplySpellMod(GetId(), SPELLMOD_CHANCE_OF_SUCCESS, chance);
    }

    // proc chance is reduced by an additional 3.333% per level past 60
    if ((procEntry.AttributesMask & PROC_ATTR_REDUCE_PROC_60) && eventInfo.GetActor()->GetLevel() > 60)
        chance = std::max(0.f, (1.f - ((eventInfo.GetActor()->GetLevel() - 60) * 1.f / 30.f)) * chance);

    return chance;
}

void Aura::TriggerProcOnEvent(uint8 procEffectMask, AuraApplication* aurApp, ProcEventInfo& eventInfo)
{
    bool prevented = CallScriptProcHandlers(aurApp, eventInfo);
    if (!prevented)
    {
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
        {
            if (!(procEffectMask & (1 << i)))
                continue;

            // OnEffectProc / AfterEffectProc hooks handled in AuraEffect::HandleProc()
            if (aurApp->HasEffect(i))
                GetEffect(i)->HandleProc(aurApp, eventInfo);
        }

        CallScriptAfterProcHandlers(aurApp, eventInfo);
    }

    ConsumeProcCharges(sSpellMgr->GetSpellProcEntry(GetId()));
}

void Aura::ConsumeProcCharges(SpellProcEntry const* procEntry)
{
    // Remove aura if we've used last charge to proc
    if (procEntry->AttributesMask & PROC_ATTR_USE_STACKS_FOR_CHARGES)
    {
        ModStackAmount(-1);
    }
    else if (IsUsingCharges())
    {
        if (!GetCharges())
        {
            // Defer removal while spell mods are being consumed,
            // cleaned up in Spell::_cast() after handle_immediate()
            if (GetType() == UNIT_AURA_TYPE
                && (HasEffectType(SPELL_AURA_ADD_FLAT_MODIFIER)
                    || HasEffectType(SPELL_AURA_ADD_PCT_MODIFIER)))
            {
                if (Player* player = GetUnitOwner()->ToPlayer())
                    if (player->m_spellModTakingSpell)
                        return;
            }

            Remove();
        }
    }
}

void Aura::_DeleteRemovedApplications()
{
    while (!m_removedApplications.empty())
    {
        delete m_removedApplications.front();
        m_removedApplications.pop_front();
    }
}

void Aura::LoadScripts()
{
    sScriptMgr->CreateAuraScripts(m_spellInfo->Id, m_loadedScripts);
    for (std::list<AuraScript*>::iterator itr = m_loadedScripts.begin(); itr != m_loadedScripts.end();)
    {
        if (!(*itr)->_Load(this))
        {
            std::list<AuraScript*>::iterator bitr = itr;
            ++itr;
            delete (*bitr);
            m_loadedScripts.erase(bitr);
            continue;
        }
        LOG_DEBUG("spells.aura", "Aura::LoadScripts: Script `{}` for aura `{}` is loaded now", (*itr)->_GetScriptName()->c_str(), m_spellInfo->Id);
        (*itr)->Register();
        ++itr;
    }
}

bool Aura::CallScriptCheckAreaTargetHandlers(Unit* target)
{
    bool result = true;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_CHECK_AREA_TARGET);
        std::list<AuraScript::CheckAreaTargetHandler>::iterator hookItrEnd = (*scritr)->DoCheckAreaTarget.end(), hookItr = (*scritr)->DoCheckAreaTarget.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            result &= hookItr->Call(*scritr, target);

        (*scritr)->_FinishScriptCall();
    }
    return result;
}

void Aura::CallScriptDispel(DispelInfo* dispelInfo)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_DISPEL);
        std::list<AuraScript::AuraDispelHandler>::iterator hookItrEnd = (*scritr)->OnDispel.end(), hookItr = (*scritr)->OnDispel.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            hookItr->Call(*scritr, dispelInfo);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptAfterDispel(DispelInfo* dispelInfo)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_AFTER_DISPEL);
        std::list<AuraScript::AuraDispelHandler>::iterator hookItrEnd = (*scritr)->AfterDispel.end(), hookItr = (*scritr)->AfterDispel.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            hookItr->Call(*scritr, dispelInfo);

        (*scritr)->_FinishScriptCall();
    }
}

bool Aura::CallScriptEffectApplyHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode)
{
    bool preventDefault = false;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_APPLY, aurApp);
        std::list<AuraScript::EffectApplyHandler>::iterator effEndItr = (*scritr)->OnEffectApply.end(), effItr = (*scritr)->OnEffectApply.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, mode);

        if (!preventDefault)
            preventDefault = (*scritr)->_IsDefaultActionPrevented();

        (*scritr)->_FinishScriptCall();
    }

    return preventDefault;
}

bool Aura::CallScriptEffectRemoveHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode)
{
    bool preventDefault = false;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_REMOVE, aurApp);
        std::list<AuraScript::EffectApplyHandler>::iterator effEndItr = (*scritr)->OnEffectRemove.end(), effItr = (*scritr)->OnEffectRemove.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, mode);

        if (!preventDefault)
            preventDefault = (*scritr)->_IsDefaultActionPrevented();

        (*scritr)->_FinishScriptCall();
    }
    return preventDefault;
}

void Aura::CallScriptAfterEffectApplyHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_AFTER_APPLY, aurApp);
        std::list<AuraScript::EffectApplyHandler>::iterator effEndItr = (*scritr)->AfterEffectApply.end(), effItr = (*scritr)->AfterEffectApply.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, mode);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptAfterEffectRemoveHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, AuraEffectHandleModes mode)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_AFTER_REMOVE, aurApp);
        std::list<AuraScript::EffectApplyHandler>::iterator effEndItr = (*scritr)->AfterEffectRemove.end(), effItr = (*scritr)->AfterEffectRemove.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, mode);

        (*scritr)->_FinishScriptCall();
    }
}

bool Aura::CallScriptEffectPeriodicHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp)
{
    bool preventDefault = false;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_PERIODIC, aurApp);
        std::list<AuraScript::EffectPeriodicHandler>::iterator effEndItr = (*scritr)->OnEffectPeriodic.end(), effItr = (*scritr)->OnEffectPeriodic.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff);

        if (!preventDefault)
            preventDefault = (*scritr)->_IsDefaultActionPrevented();

        (*scritr)->_FinishScriptCall();
    }

    return preventDefault;
}

void Aura::CallScriptEffectUpdatePeriodicHandlers(AuraEffect* aurEff)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_UPDATE_PERIODIC);
        std::list<AuraScript::EffectUpdatePeriodicHandler>::iterator effEndItr = (*scritr)->OnEffectUpdatePeriodic.end(), effItr = (*scritr)->OnEffectUpdatePeriodic.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectCalcAmountHandlers(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_CALC_AMOUNT);
        std::list<AuraScript::EffectCalcAmountHandler>::iterator effEndItr = (*scritr)->DoEffectCalcAmount.end(), effItr = (*scritr)->DoEffectCalcAmount.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, amount, canBeRecalculated);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectCalcPeriodicHandlers(AuraEffect const* aurEff, bool& isPeriodic, int32& amplitude)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_CALC_PERIODIC);
        std::list<AuraScript::EffectCalcPeriodicHandler>::iterator effEndItr = (*scritr)->DoEffectCalcPeriodic.end(), effItr = (*scritr)->DoEffectCalcPeriodic.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, isPeriodic, amplitude);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectCalcSpellModHandlers(AuraEffect const* aurEff, SpellModifier*& spellMod)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_CALC_SPELLMOD);
        std::list<AuraScript::EffectCalcSpellModHandler>::iterator effEndItr = (*scritr)->DoEffectCalcSpellMod.end(), effItr = (*scritr)->DoEffectCalcSpellMod.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, spellMod);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectAbsorbHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount, bool& defaultPrevented)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_ABSORB, aurApp);
        std::list<AuraScript::EffectAbsorbHandler>::iterator effEndItr = (*scritr)->OnEffectAbsorb.end(), effItr = (*scritr)->OnEffectAbsorb.begin();
        for (; effItr != effEndItr; ++effItr)

            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, dmgInfo, absorbAmount);

        if (!defaultPrevented)
            defaultPrevented = (*scritr)->_IsDefaultActionPrevented();

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectAfterAbsorbHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_AFTER_ABSORB, aurApp);
        std::list<AuraScript::EffectAbsorbHandler>::iterator effEndItr = (*scritr)->AfterEffectAbsorb.end(), effItr = (*scritr)->AfterEffectAbsorb.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, dmgInfo, absorbAmount);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectManaShieldHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount, bool& /*defaultPrevented*/)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_MANASHIELD, aurApp);
        std::list<AuraScript::EffectManaShieldHandler>::iterator effEndItr = (*scritr)->OnEffectManaShield.end(), effItr = (*scritr)->OnEffectManaShield.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, dmgInfo, absorbAmount);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectAfterManaShieldHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& absorbAmount)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_AFTER_MANASHIELD, aurApp);
        std::list<AuraScript::EffectManaShieldHandler>::iterator effEndItr = (*scritr)->AfterEffectManaShield.end(), effItr = (*scritr)->AfterEffectManaShield.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, dmgInfo, absorbAmount);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::CallScriptEffectSplitHandlers(AuraEffect* aurEff, AuraApplication const* aurApp, DamageInfo& dmgInfo, uint32& splitAmount)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_SPLIT, aurApp);
        std::list<AuraScript::EffectSplitHandler>::iterator effEndItr = (*scritr)->OnEffectSplit.end(), effItr = (*scritr)->OnEffectSplit.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, dmgInfo, splitAmount);

        (*scritr)->_FinishScriptCall();
    }
}

bool Aura::CallScriptCheckProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo)
{
    bool result = true;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_CHECK_PROC, aurApp);
        std::list<AuraScript::CheckProcHandler>::iterator hookItrEnd = (*scritr)->DoCheckProc.end(), hookItr = (*scritr)->DoCheckProc.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            result &= hookItr->Call(*scritr, eventInfo);

        (*scritr)->_FinishScriptCall();
    }

    return result;
}

bool Aura::CallScriptCheckEffectProcHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, ProcEventInfo& eventInfo)
{
    bool result = true;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_CHECK_EFFECT_PROC, aurApp);
        std::list<AuraScript::CheckEffectProcHandler>::iterator effEndItr = (*scritr)->DoCheckEffectProc.end(), effItr = (*scritr)->DoCheckEffectProc.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                result &= effItr->Call(*scritr, aurEff, eventInfo);

        (*scritr)->_FinishScriptCall();
    }

    return result;
}

bool Aura::CallScriptAfterCheckProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo, bool isTriggeredAtSpellProcEvent)
{
    bool result = isTriggeredAtSpellProcEvent;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_AFTER_CHECK_PROC, aurApp);
        std::list<AuraScript::AfterCheckProcHandler>::iterator hookItrEnd = (*scritr)->DoAfterCheckProc.end(), hookItr = (*scritr)->DoAfterCheckProc.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            result &= hookItr->Call(*scritr, eventInfo, isTriggeredAtSpellProcEvent);

        (*scritr)->_FinishScriptCall();
    }

    return result;
}

bool Aura::CallScriptPrepareProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo)
{
    bool prepare = true;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_PREPARE_PROC, aurApp);
        std::list<AuraScript::AuraProcHandler>::iterator effEndItr = (*scritr)->DoPrepareProc.end(), effItr = (*scritr)->DoPrepareProc.begin();
        for (; effItr != effEndItr; ++effItr)
            effItr->Call(*scritr, eventInfo);

        if (prepare)
            prepare = !(*scritr)->_IsDefaultActionPrevented();

        (*scritr)->_FinishScriptCall();
    }

    return prepare;
}

bool Aura::CallScriptProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo)
{
    bool handled = false;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_PROC, aurApp);
        std::list<AuraScript::AuraProcHandler>::iterator hookItrEnd = (*scritr)->OnProc.end(), hookItr = (*scritr)->OnProc.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            hookItr->Call(*scritr, eventInfo);

        handled |= (*scritr)->_IsDefaultActionPrevented();
        (*scritr)->_FinishScriptCall();
    }

    return handled;
}

void Aura::CallScriptAfterProcHandlers(AuraApplication const* aurApp, ProcEventInfo& eventInfo)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_AFTER_PROC, aurApp);
        std::list<AuraScript::AuraProcHandler>::iterator hookItrEnd = (*scritr)->AfterProc.end(), hookItr = (*scritr)->AfterProc.begin();
        for (; hookItr != hookItrEnd; ++hookItr)
            hookItr->Call(*scritr, eventInfo);

        (*scritr)->_FinishScriptCall();
    }
}

bool Aura::CallScriptEffectProcHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, ProcEventInfo& eventInfo)
{
    bool preventDefault = false;
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_PROC, aurApp);
        std::list<AuraScript::EffectProcHandler>::iterator effEndItr = (*scritr)->OnEffectProc.end(), effItr = (*scritr)->OnEffectProc.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, eventInfo);

        if (!preventDefault)
            preventDefault = (*scritr)->_IsDefaultActionPrevented();

        (*scritr)->_FinishScriptCall();
    }
    return preventDefault;
}

void Aura::CallScriptAfterEffectProcHandlers(AuraEffect const* aurEff, AuraApplication const* aurApp, ProcEventInfo& eventInfo)
{
    for (std::list<AuraScript*>::iterator scritr = m_loadedScripts.begin(); scritr != m_loadedScripts.end(); ++scritr)
    {
        (*scritr)->_PrepareScriptCall(AURA_SCRIPT_HOOK_EFFECT_AFTER_PROC, aurApp);
        std::list<AuraScript::EffectProcHandler>::iterator effEndItr = (*scritr)->AfterEffectProc.end(), effItr = (*scritr)->AfterEffectProc.begin();
        for (; effItr != effEndItr; ++effItr)
            if (effItr->IsEffectAffected(m_spellInfo, aurEff->GetEffIndex()))
                effItr->Call(*scritr, aurEff, eventInfo);

        (*scritr)->_FinishScriptCall();
    }
}

void Aura::SetTriggeredByAuraSpellInfo(SpellInfo const* triggeredByAuraSpellInfo)
{
    m_triggeredByAuraSpellInfo = triggeredByAuraSpellInfo;
}

std::string Aura::GetDebugInfo() const
{
    std::stringstream sstr;
    sstr << std::boolalpha
        << "Id: " << GetId() << " Caster: " << GetCasterGUID().ToString()
        << "\nOwner: " << (GetOwner() ? GetOwner()->GetDebugInfo() : "NULL");
    return sstr.str();
}

SpellInfo const* Aura::GetTriggeredByAuraSpellInfo() const
{
    return m_triggeredByAuraSpellInfo;
}

UnitAura::UnitAura(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID /*= ObjectGuid::Empty*/)
    : Aura(spellproto, owner, caster, castItem, casterGUID, itemGUID)
{
    m_AuraDRGroup = DIMINISHING_NONE;
    LoadScripts();
    _InitEffects(effMask, caster, baseAmount);
    GetUnitOwner()->_AddAura(this, caster);
}

void UnitAura::_ApplyForTarget(Unit* target, Unit* caster, AuraApplication* aurApp)
{
    Aura::_ApplyForTarget(target, caster, aurApp);

    // register aura diminishing on apply
    if (DiminishingGroup group = GetDiminishGroup())
        target->ApplyDiminishingAura(group, true);
}

void UnitAura::_UnapplyForTarget(Unit* target, Unit* caster, AuraApplication* aurApp)
{
    Aura::_UnapplyForTarget(target, caster, aurApp);

    // unregister aura diminishing (and store last time)
    if (DiminishingGroup group = GetDiminishGroup())
        target->ApplyDiminishingAura(group, false);
}

void UnitAura::Remove(AuraRemoveMode removeMode)
{
    if (IsRemoved())
        return;
    GetUnitOwner()->RemoveOwnedAura(this, removeMode);
}

void UnitAura::FillTargetMap(std::map<Unit*, uint8>& targets, Unit* caster)
{
    for (uint8 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
    {
        if (!HasEffect(effIndex))
            continue;
        UnitList targetList;
        // non-area aura
        if (GetSpellInfo()->Effects[effIndex].Effect == SPELL_EFFECT_APPLY_AURA)
        {
            targetList.push_back(GetUnitOwner());
        }
        else
        {
            float radius = GetSpellInfo()->Effects[effIndex].CalcRadius(caster);

            if (!GetUnitOwner()->HasUnitState(UNIT_STATE_ISOLATED))
            {
                switch (GetSpellInfo()->Effects[effIndex].Effect)
                {
                    case SPELL_EFFECT_APPLY_AREA_AURA_PARTY:
                    case SPELL_EFFECT_APPLY_AREA_AURA_RAID:
                        {
                            targetList.push_back(GetUnitOwner());
                            Acore::AnyGroupedUnitInObjectRangeCheck u_check(GetUnitOwner(), GetUnitOwner(), radius, GetSpellInfo()->Effects[effIndex].Effect == SPELL_EFFECT_APPLY_AREA_AURA_RAID);
                            Acore::UnitListSearcher<Acore::AnyGroupedUnitInObjectRangeCheck> searcher(GetUnitOwner(), targetList, u_check);
                            Cell::VisitObjects(GetUnitOwner(), searcher, radius);
                            break;
                        }
                    case SPELL_EFFECT_APPLY_AREA_AURA_FRIEND:
                        {
                            targetList.push_back(GetUnitOwner());
                            Acore::AnyFriendlyUnitInObjectRangeCheck u_check(GetUnitOwner(), GetUnitOwner(), radius);
                            Acore::UnitListSearcher<Acore::AnyFriendlyUnitInObjectRangeCheck> searcher(GetUnitOwner(), targetList, u_check);
                            Cell::VisitObjects(GetUnitOwner(), searcher, radius);
                            break;
                        }
                    case SPELL_EFFECT_APPLY_AREA_AURA_ENEMY:
                        {
                            Acore::AnyAoETargetUnitInObjectRangeCheck u_check(GetUnitOwner(), GetUnitOwner(), radius); // No GetCharmer in searcher
                            Acore::UnitListSearcher<Acore::AnyAoETargetUnitInObjectRangeCheck> searcher(GetUnitOwner(), targetList, u_check);
                            Cell::VisitObjects(GetUnitOwner(), searcher, radius);
                            break;
                        }
                    case SPELL_EFFECT_APPLY_AREA_AURA_PET:
                        targetList.push_back(GetUnitOwner());
                        [[fallthrough]]; /// @todo: Not sure whether the fallthrough was a mistake (forgetting a break) or intended. This should be double-checked.
                    case SPELL_EFFECT_APPLY_AREA_AURA_OWNER:
                        {
                            if (Unit* owner = GetUnitOwner()->GetCharmerOrOwner())
                                if (GetUnitOwner()->IsWithinDistInMap(owner, radius))
                                    targetList.push_back(owner);
                            break;
                        }
                }
            }
        }

        for (UnitList::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
        {
            std::map<Unit*, uint8>::iterator existing = targets.find(*itr);
            if (existing != targets.end())
                existing->second |= 1 << effIndex;
            else
                targets[*itr] = 1 << effIndex;
        }
    }
}

DynObjAura::DynObjAura(SpellInfo const* spellproto, uint8 effMask, WorldObject* owner, Unit* caster, int32* baseAmount, Item* castItem, ObjectGuid casterGUID, ObjectGuid itemGUID /*= ObjectGuid::Empty*/)
    : Aura(spellproto, owner, caster, castItem, casterGUID, itemGUID)
{
    LoadScripts();
    ASSERT(GetDynobjOwner());
    ASSERT(GetDynobjOwner()->IsInWorld());
    ASSERT(GetDynobjOwner()->GetMap() == caster->GetMap());
    _InitEffects(effMask, caster, baseAmount);
    GetDynobjOwner()->SetAura(this);
}

void DynObjAura::Remove(AuraRemoveMode removeMode)
{
    if (IsRemoved())
        return;
    _Remove(removeMode);
}

void DynObjAura::FillTargetMap(std::map<Unit*, uint8>& targets, Unit* /*caster*/)
{
    Unit* dynObjOwnerCaster = GetDynobjOwner()->GetCaster();
    float radius = GetDynobjOwner()->GetRadius();

    for (uint8 effIndex = 0; effIndex < MAX_SPELL_EFFECTS; ++effIndex)
    {
        if (!HasEffect(effIndex))
            continue;

        SpellInfo const* spellInfo = GetSpellInfo();
        UnitList targetList;
        if (spellInfo->Effects[effIndex].TargetB.GetTarget() == TARGET_DEST_DYNOBJ_ALLY || spellInfo->Effects[effIndex].TargetB.GetTarget() == TARGET_UNIT_DEST_AREA_ALLY)
        {
            Acore::AnyFriendlyUnitInObjectRangeCheck u_check(GetDynobjOwner(), dynObjOwnerCaster, radius);
            Acore::UnitListSearcher<Acore::AnyFriendlyUnitInObjectRangeCheck> searcher(GetDynobjOwner(), targetList, u_check);
            Cell::VisitObjects(GetDynobjOwner(), searcher, radius);
        }
        // pussywizard: TARGET_DEST_DYNOBJ_NONE is supposed to search for both friendly and unfriendly targets, so for any unit
        // what about EffectImplicitTargetA?
        else if (spellInfo->Effects[effIndex].TargetB.GetTarget() == TARGET_DEST_DYNOBJ_NONE)
        {
            Acore::AnyAttackableUnitExceptForOriginalCasterInObjectRangeCheck u_check(GetDynobjOwner(), dynObjOwnerCaster, radius);
            Acore::UnitListSearcher<Acore::AnyAttackableUnitExceptForOriginalCasterInObjectRangeCheck> searcher(GetDynobjOwner(), targetList, u_check);
            Cell::VisitObjects(GetDynobjOwner(), searcher, radius);
        }
        else
        {
            Acore::AnyAoETargetUnitInObjectRangeCheck u_check(GetDynobjOwner(), dynObjOwnerCaster, radius);
            Acore::UnitListSearcher<Acore::AnyAoETargetUnitInObjectRangeCheck> searcher(GetDynobjOwner(), targetList, u_check);
            Cell::VisitObjects(GetDynobjOwner(), searcher, radius);
        }

        for (UnitList::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
        {
            Unit* target = *itr;

            Optional<float> collisionHeight = { };
            Optional<float> combatReach = { };
            if (Unit* dynObjCaster = GetDynobjOwner()->GetCaster())
            {
                collisionHeight = dynObjCaster->GetCollisionHeight();
                combatReach = dynObjCaster->GetCombatReach();
            }

            if (!spellInfo->HasAttribute(SPELL_ATTR2_IGNORE_LINE_OF_SIGHT) && !spellInfo->HasAttribute(SPELL_ATTR5_ALWAYS_AOE_LINE_OF_SIGHT) &&
                !GetDynobjOwner()->IsWithinLOSInMap(target, VMAP::ModelIgnoreFlags::Nothing, LINEOFSIGHT_ALL_CHECKS, collisionHeight, combatReach))
            {
                continue;
            }

            std::map<Unit*, uint8>::iterator existing = targets.find(*itr);
            if (existing != targets.end())
                existing->second |= 1 << effIndex;
            else
                targets[*itr] = 1 << effIndex;
        }
    }
}
