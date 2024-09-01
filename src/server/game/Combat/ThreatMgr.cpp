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

#include "ThreatMgr.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Unit.h"
#include "UnitEvents.h"

//==============================================================
//================= ThreatCalcHelper ===========================
//==============================================================

// The hatingUnit is not used yet
float ThreatCalcHelper::calcThreat(Unit* hatedUnit, float threat, SpellSchoolMask schoolMask, SpellInfo const* threatSpell)
{
    if (threatSpell)
    {
        if (SpellThreatEntry const* threatEntry = sSpellMgr->GetSpellThreatEntry(threatSpell->Id))
            if (threatEntry->pctMod != 1.0f)
                threat *= threatEntry->pctMod;

        // Energize is not affected by Mods
        for (uint8 i = 0; i < MAX_SPELL_EFFECTS; i++)
            if (threatSpell->Effects[i].Effect == SPELL_EFFECT_ENERGIZE || threatSpell->Effects[i].ApplyAuraName == SPELL_AURA_PERIODIC_ENERGIZE)
                return threat;

        if (Player* modOwner = hatedUnit->GetSpellModOwner())
            modOwner->ApplySpellMod(threatSpell->Id, SPELLMOD_THREAT, threat);
    }

    return hatedUnit->ApplyTotalThreatModifier(threat, schoolMask);
}

bool ThreatCalcHelper::isValidProcess(Unit* hatedUnit, Unit* hatingUnit, SpellInfo const* threatSpell)
{
    //function deals with adding threat and adding players and pets into ThreatList
    //mobs, NPCs, guards have ThreatList and HateOfflineList
    //players and pets have only InHateListOf
    //HateOfflineList is used co contain unattackable victims (in-flight, in-water, GM etc.)

    if (!hatedUnit || !hatingUnit)
        return false;

    // not to self
    if (hatedUnit == hatingUnit)
        return false;

    // not to GM
    if (hatedUnit->IsPlayer() && hatedUnit->ToPlayer()->IsGameMaster())
        return false;

    // not to dead and not for dead
    if (!hatedUnit->IsAlive() || !hatingUnit->IsAlive())
        return false;

    // not in same map or phase
    if (!hatedUnit->IsInMap(hatingUnit) || !hatedUnit->InSamePhase(hatingUnit))
        return false;

    // spell not causing threat
    if (threatSpell && threatSpell->HasAttribute(SPELL_ATTR1_NO_THREAT))
        return false;

    ASSERT(hatingUnit->IsCreature());

    return true;
}

//============================================================
//================= HostileReference ==========================
//============================================================

HostileReference::HostileReference(Unit* refUnit, ThreatMgr* threatMgr, float threat)
{
    iThreat = threat;
    iTempThreatModifier = 0.0f;
    link(refUnit, threatMgr);
    iUnitGuid = refUnit->GetGUID();
    iOnline = true;
}

//============================================================
// Tell our refTo (target) object that we have a link
void HostileReference::targetObjectBuildLink()
{
    getTarget()->addHatedBy(this);
}

//============================================================
// Tell our refTo (taget) object, that the link is cut
void HostileReference::targetObjectDestroyLink()
{
    getTarget()->removeHatedBy(this);
}

//============================================================
// Tell our refFrom (source) object, that the link is cut (Target destroyed)

void HostileReference::sourceObjectDestroyLink()
{
    setOnlineOfflineState(false);
}

//============================================================
// Inform the source, that the status of the reference changed

void HostileReference::fireStatusChanged(ThreatRefStatusChangeEvent& threatRefStatusChangeEvent)
{
    if (GetSource())
        GetSource()->processThreatEvent(&threatRefStatusChangeEvent);
}

// -- compatibility layer for combat rewrite
Unit* HostileReference::GetOwner() const { return GetSource()->GetOwner(); }

//============================================================

void HostileReference::AddThreat(float modThreat)
{
    iThreat += modThreat;
    // the threat is changed. Source and target unit have to be available
    // if the link was cut before relink it again
    if (!IsOnline())
        updateOnlineStatus();
    if (modThreat != 0.0f)
    {
        ThreatRefStatusChangeEvent event(UEV_THREAT_REF_THREAT_CHANGE, this, modThreat);
        fireStatusChanged(event);
    }

    if (isValid() && modThreat >= 0.0f)
    {
        Unit* target = getTarget();
        if (target->GetEntry() != NPC_EYE_OF_KILROGG) // Excluded Eye of Kilrogg
        {
            Unit* victimOwner = target->GetCharmerOrOwner();
            if (victimOwner && victimOwner->IsAlive())
            {
                GetSource()->AddThreat(victimOwner, 0.0f); // create a threat to the owner of a pet, if the pet attacks
            }
        }
    }
}

void HostileReference::addThreatPercent(int32 percent)
{
    // Xinef: Do not allow to modify threat by percent if threat is negative (forced to big value < 0 by spells adding temporary threat)
    // Xinef: When the temporary effect ends, temporary threat is added back which results in huge additional amount of threat
    if (iThreat <= 0)
        return;

    float tmpThreat = iThreat;
    AddPct(tmpThreat, percent);
    AddThreat(tmpThreat - iThreat);
}

//============================================================
// check, if source can reach target and set the status

void HostileReference::updateOnlineStatus()
{
    bool online = false;

    if (!isValid())
        if (Unit* target = ObjectAccessor::GetUnit(*GetSourceUnit(), getUnitGuid()))
            link(target, GetSource());

    // only check for online status if
    // ref is valid
    // target is no player or not gamemaster
    // target is not in flight
    if (isValid()
            && (!getTarget()->IsPlayer() || !getTarget()->ToPlayer()->IsGameMaster())
            && !getTarget()->IsInFlight()
            && getTarget()->IsInMap(GetSourceUnit())
            && getTarget()->InSamePhase(GetSourceUnit())
       )
    {
        Creature* creature = GetSourceUnit()->ToCreature();
        online = getTarget()->isInAccessiblePlaceFor(creature);
        if (!online)
        {
            if (creature->IsWithinCombatRange(getTarget(), creature->m_CombatDistance))
                online = true;                              // not accessible but stays online
        }
    }

    setOnlineOfflineState(online);
}

//============================================================
// set the status and fire the event on status change

void HostileReference::setOnlineOfflineState(bool isOnline)
{
    if (iOnline != isOnline)
    {
        iOnline = isOnline;

        ThreatRefStatusChangeEvent event(UEV_THREAT_REF_ONLINE_STATUS, this);
        fireStatusChanged(event);
    }
}

//============================================================
// prepare the reference for deleting
// this is called be the target

void HostileReference::removeReference()
{
    invalidate();

    ThreatRefStatusChangeEvent event(UEV_THREAT_REF_REMOVE_FROM_LIST, this);
    fireStatusChanged(event);
}

//============================================================

Unit* HostileReference::GetSourceUnit()
{
    return (GetSource()->GetOwner());
}

//============================================================
//================ ThreatContainer ===========================
//============================================================

void ThreatContainer::clearReferences()
{
    for (ThreatContainer::StorageType::const_iterator i = iThreatList.begin(); i != iThreatList.end(); ++i)
    {
        (*i)->unlink();
        delete (*i);
    }

    iThreatList.clear();
}

//============================================================
// Return the HostileReference of nullptr, if not found
HostileReference* ThreatContainer::getReferenceByTarget(Unit const* victim) const
{
    if (!victim)
        return nullptr;

    return getReferenceByTarget(victim->GetGUID());
}

HostileReference* ThreatContainer::getReferenceByTarget(ObjectGuid const& guid) const
{
    for (ThreatContainer::StorageType::const_iterator i = iThreatList.begin(); i != iThreatList.end(); ++i)
    {
        HostileReference* ref = (*i);
        if (ref && ref->getUnitGuid() == guid)
        {
            return ref;
        }
    }

    return nullptr;
}

//============================================================
// Add the threat, if we find the reference

HostileReference* ThreatContainer::AddThreat(Unit* victim, float threat)
{
    HostileReference* ref = getReferenceByTarget(victim);
    if (ref)
        ref->AddThreat(threat);
    return ref;
}

//============================================================

void ThreatContainer::ModifyThreatByPercent(Unit* victim, int32 percent)
{
    if (HostileReference* ref = getReferenceByTarget(victim))
        ref->addThreatPercent(percent);
}

//============================================================
// Check if the list is dirty and sort if necessary

void ThreatContainer::update()
{
    if (iDirty && iThreatList.size() > 1)
        iThreatList.sort(Acore::ThreatOrderPred());

    iDirty = false;
}

//============================================================
// return the next best victim
// could be the current victim

HostileReference* ThreatContainer::SelectNextVictim(Creature* attacker, HostileReference* currentVictim) const
{
    // pussywizard: pretty much remade this whole function

    HostileReference* currentRef = nullptr;
    bool found = false;
    bool noPriorityTargetFound = false;

    // pussywizard: currentVictim is needed to compare if threat was exceeded by 10%/30% for melee/range targets (only then switching current target)
    if (currentVictim)
    {
        Unit* cvUnit = currentVictim->getTarget();
        if (!attacker->CanCreatureAttack(cvUnit)) // pussywizard: if currentVictim is not valid => don't compare the threat with it, just take the highest threat valid target
            currentVictim = nullptr;
        else if (cvUnit->IsImmunedToDamageOrSchool(attacker->GetMeleeDamageSchoolMask()) || cvUnit->HasNegativeAuraWithInterruptFlag(AURA_INTERRUPT_FLAG_TAKE_DAMAGE)) // pussywizard: no 10%/30% if currentVictim is immune to damage or has auras breakable by damage
            currentVictim = nullptr;
    }

    ThreatContainer::StorageType::const_iterator lastRef = iThreatList.end();
    --lastRef;

    // pussywizard: iterate from highest to lowest threat
    for (ThreatContainer::StorageType::const_iterator iter = iThreatList.begin(); iter != iThreatList.end() && !found;)
    {
        currentRef = (*iter);

        Unit* target = currentRef->getTarget();
        ASSERT(target); // if the ref has status online the target must be there !

        // pussywizard: don't go to threat comparison if this ref is immune to damage or has aura breakable on damage (second choice target)
        // pussywizard: if this is the last entry on the threat list, then all targets are second choice, set bool to true and loop threat list again, ignoring this section
        if (!noPriorityTargetFound && (target->IsImmunedToDamageOrSchool(attacker->GetMeleeDamageSchoolMask()) || target->HasNegativeAuraWithInterruptFlag(AURA_INTERRUPT_FLAG_TAKE_DAMAGE) || target->HasAuraTypeWithCaster(SPELL_AURA_IGNORED, attacker->GetGUID())))
        {
            if (iter != lastRef)
            {
                ++iter;
                continue;
            }
            else
            {
                noPriorityTargetFound = true;
                iter = iThreatList.begin();
                continue;
            }
        }

        // pussywizard: skip not valid targets
        if (attacker->CanCreatureAttack(target))
        {
            if (currentVictim) // pussywizard: if not nullptr then target must have 10%/30% more threat
            {
                if (currentVictim == currentRef) // pussywizard: nothing found previously was good and enough, currentRef passed all necessary tests, so end now
                {
                    found = true;
                    break;
                }

                // pussywizard: implement 110% threat rule for targets in melee range and 130% rule for targets in ranged distances
                if (currentRef->GetThreat() > 1.3f * currentVictim->GetThreat()) // pussywizard: enough in all cases, end
                {
                    found = true;
                    break;
                }
                else if (currentRef->GetThreat() > 1.1f * currentVictim->GetThreat()) // pussywizard: enought only if target in melee range
                {
                    if (attacker->IsWithinMeleeRange(target))
                    {
                        found = true;
                        break;
                    }
                }
                else // pussywizard: nothing found previously was good and enough, this and next entries on the list have less than 110% threat, and currentVictim is present and valid as checked before the loop (otherwise it's nullptr), so end now
                {
                    currentRef = currentVictim;
                    found = true;
                    break;
                }
            }
            else // pussywizard: no currentVictim, first passing all checks is chosen (highest threat, list is sorted)
            {
                found = true;
                break;
            }
        }
        ++iter;
    }
    if (!found)
        currentRef = nullptr;

    return currentRef;
}

//============================================================
//=================== ThreatMgr ==========================
//============================================================

ThreatMgr::ThreatMgr(Unit* owner) : iCurrentVictim(nullptr), iOwner(owner), iUpdateTimer(THREAT_UPDATE_INTERVAL)
{
}

void ThreatMgr::ClearAllThreat()
{
    if (iOwner->CanHaveThreatList() && !isThreatListEmpty())
        iOwner->SendClearThreatListOpcode();
    clearReferences();
}

//============================================================

void ThreatMgr::clearReferences()
{
    iThreatContainer.clearReferences();
    iThreatOfflineContainer.clearReferences();
    iCurrentVictim = nullptr;
    iUpdateTimer = THREAT_UPDATE_INTERVAL;
}

//============================================================

void ThreatMgr::AddThreat(Unit* victim, float threat, SpellSchoolMask schoolMask, SpellInfo const* threatSpell)
{
    if (!ThreatCalcHelper::isValidProcess(victim, iOwner, threatSpell))
        return;

    threat = ThreatCalcHelper::calcThreat(victim, threat, schoolMask, threatSpell);
    if (Creature* hatingCreature = iOwner->ToCreature())
    {
        if (hatingCreature->IsAIEnabled)
        {
            hatingCreature->AI()->CalculateThreat(victim, threat, threatSpell);
        }
    }

    DoAddThreat(victim, threat);
}

void ThreatMgr::DoAddThreat(Unit* victim, float threat)
{
    uint32 redirectThreadPct = victim->GetRedirectThreatPercent();
    Unit* redirectTarget = victim->GetRedirectThreatTarget();

    // Personal Spawns from same summoner can aggro each other
    if (TempSummon* tempSummonVictim = victim->ToTempSummon())
    {
        if (tempSummonVictim->IsVisibleBySummonerOnly())
        {
            if (!GetOwner()->ToTempSummon() ||
                !GetOwner()->ToTempSummon()->IsVisibleBySummonerOnly() ||
                tempSummonVictim->GetSummonerGUID() != GetOwner()->ToTempSummon()->GetSummonerGUID())
            {
                redirectThreadPct = 100;
                redirectTarget = tempSummonVictim->GetSummonerUnit();
            }
        }
    }

    // must check > 0.0f, otherwise dead loop
    if (threat > 0.0f && redirectThreadPct)
    {
        if (redirectTarget)
        {
            float redirectThreat = CalculatePct(threat, redirectThreadPct);
            threat -= redirectThreat;
            if (ThreatCalcHelper::isValidProcess(redirectTarget, GetOwner()))
                _addThreat(redirectTarget, redirectThreat);
        }
    }

    _addThreat(victim, threat);
}

void ThreatMgr::_addThreat(Unit* victim, float threat)
{
    HostileReference* ref = iThreatContainer.AddThreat(victim, threat);
    // Ref is not in the online refs, search the offline refs next
    if (!ref)
        ref = iThreatOfflineContainer.AddThreat(victim, threat);

    if (!ref) // there was no ref => create a new one
    {
        // threat has to be 0 here
        HostileReference* hostileRef = new HostileReference(victim, this, 0);
        iThreatContainer.addReference(hostileRef);
        hostileRef->AddThreat(threat); // now we add the real threat
        if (victim->IsPlayer() && victim->ToPlayer()->IsGameMaster())
            hostileRef->setOnlineOfflineState(false); // GM is always offline
    }
}

//============================================================

void ThreatMgr::ModifyThreatByPercent(Unit* victim, int32 percent)
{
    iThreatContainer.ModifyThreatByPercent(victim, percent);
}

//============================================================

Unit* ThreatMgr::getHostileTarget()
{
    iThreatContainer.update();
    HostileReference* nextVictim = iThreatContainer.SelectNextVictim(GetOwner()->ToCreature(), getCurrentVictim());
    setCurrentVictim(nextVictim);
    return getCurrentVictim() != nullptr ? getCurrentVictim()->getTarget() : nullptr;
}

//============================================================

float ThreatMgr::GetThreat(Unit* victim, bool alsoSearchOfflineList)
{
    float threat = 0.0f;
    HostileReference* ref = iThreatContainer.getReferenceByTarget(victim);
    if (!ref && alsoSearchOfflineList)
        ref = iThreatOfflineContainer.getReferenceByTarget(victim);
    if (ref)
        threat = ref->GetThreat();
    return threat;
}

//============================================================

float ThreatMgr::getThreatWithoutTemp(Unit* victim, bool alsoSearchOfflineList)
{
    float threat = 0.0f;
    HostileReference* ref = iThreatContainer.getReferenceByTarget(victim);
    if (!ref && alsoSearchOfflineList)
        ref = iThreatOfflineContainer.getReferenceByTarget(victim);
    if (ref)
        threat = ref->GetThreat() - ref->getTempThreatModifier();
    return threat;
}

//============================================================

void ThreatMgr::tauntApply(Unit* taunter)
{
    HostileReference* ref = iThreatContainer.getReferenceByTarget(taunter);
    if (getCurrentVictim() && ref && (ref->GetThreat() < getCurrentVictim()->GetThreat()))
    {
        if (ref->getTempThreatModifier() == 0.0f) // Ok, temp threat is unused
            ref->setTempThreat(getCurrentVictim()->GetThreat());
    }
}

//============================================================

void ThreatMgr::tauntFadeOut(Unit* taunter)
{
    HostileReference* ref = iThreatContainer.getReferenceByTarget(taunter);
    if (ref)
        ref->resetTempThreat();
}

//============================================================

void ThreatMgr::setCurrentVictim(HostileReference* pHostileReference)
{
    if (pHostileReference && pHostileReference != iCurrentVictim)
    {
        iOwner->SendChangeCurrentVictimOpcode(pHostileReference);
    }
    iCurrentVictim = pHostileReference;
}

//============================================================
// The hated unit is gone, dead or deleted
// return true, if the event is consumed

void ThreatMgr::processThreatEvent(ThreatRefStatusChangeEvent* threatRefStatusChangeEvent)
{
    threatRefStatusChangeEvent->setThreatMgr(this);     // now we can set the threat manager

    HostileReference* hostileRef = threatRefStatusChangeEvent->getReference();

    switch (threatRefStatusChangeEvent->getType())
    {
        case UEV_THREAT_REF_THREAT_CHANGE:
            if ((getCurrentVictim() == hostileRef && threatRefStatusChangeEvent->getFValue() < 0.0f) ||
                    (getCurrentVictim() != hostileRef && threatRefStatusChangeEvent->getFValue() > 0.0f))
                setDirty(true);                             // the order in the threat list might have changed
            break;
        case UEV_THREAT_REF_ONLINE_STATUS:
            if (!hostileRef->IsOnline())
            {
                if (hostileRef == getCurrentVictim())
                {
                    setCurrentVictim(nullptr);
                    setDirty(true);
                }
                if (GetOwner() && GetOwner()->IsInWorld())
                    if (Unit* target = ObjectAccessor::GetUnit(*GetOwner(), hostileRef->getUnitGuid()))
                        if (GetOwner()->IsInMap(target))
                            GetOwner()->SendRemoveFromThreatListOpcode(hostileRef);
                iThreatContainer.remove(hostileRef);
                iThreatOfflineContainer.addReference(hostileRef);
            }
            else
            {
                if (getCurrentVictim() && hostileRef->GetThreat() > (1.1f * getCurrentVictim()->GetThreat()))
                    setDirty(true);
                iThreatContainer.addReference(hostileRef);
                iThreatOfflineContainer.remove(hostileRef);
            }
            break;
        case UEV_THREAT_REF_REMOVE_FROM_LIST:
            if (hostileRef == getCurrentVictim())
            {
                setCurrentVictim(nullptr);
                setDirty(true);
            }
            iOwner->SendRemoveFromThreatListOpcode(hostileRef);
            if (hostileRef->IsOnline())
                iThreatContainer.remove(hostileRef);
            else
                iThreatOfflineContainer.remove(hostileRef);
            break;
    }
}

bool ThreatMgr::isNeedUpdateToClient(uint32 time)
{
    if (isThreatListEmpty())
        return false;

    if (time >= iUpdateTimer)
    {
        iUpdateTimer = THREAT_UPDATE_INTERVAL;
        return true;
    }
    iUpdateTimer -= time;
    return false;
}

// Reset all aggro without modifying the threatlist.
void ThreatMgr::ResetAllThreat()
{
    ThreatContainer::StorageType& threatList = iThreatContainer.iThreatList;
    if (threatList.empty())
        return;

    for (HostileReference* ref : threatList)
    {
        // Reset temp threat before setting threat back to 0.
        ref->resetTempThreat();
        ref->SetThreat(0.f);
    }

    setDirty(true);
}
