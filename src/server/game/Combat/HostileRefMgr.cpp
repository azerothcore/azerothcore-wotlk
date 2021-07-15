/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "HostileRefMgr.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "ThreatMgr.h"
#include "Unit.h"

HostileRefMgr::~HostileRefMgr()
{
    deleteReferences();
}

//=================================================
// send threat to all my hateres for the victim
// The victim is hated than by them as well
// use for buffs and healing threat functionality

void HostileRefMgr::threatAssist(Unit* victim, float baseThreat, SpellInfo const* threatSpell)
{
    if (getSize() == 0)
        return;

    HostileReference* ref = getFirst();
    float threat = ThreatCalcHelper::calcThreat(victim, iOwner, baseThreat, (threatSpell ? threatSpell->GetSchoolMask() : SPELL_SCHOOL_MASK_NORMAL), threatSpell);
    threat /= getSize();
    while (ref)
    {
        if (ThreatCalcHelper::isValidProcess(victim, ref->GetSource()->GetOwner(), threatSpell))
            ref->GetSource()->doAddThreat(victim, threat);

        ref = ref->next();
    }
}

//=================================================

void HostileRefMgr::addTempThreat(float threat, bool apply)
{
    HostileReference* ref = getFirst();

    while (ref)
    {
        if (apply)
        {
            if (ref->getTempThreatModifier() == 0.0f)
                ref->addTempThreat(threat);
        }
        else
            ref->resetTempThreat();

        ref = ref->next();
    }
}

//=================================================

void HostileRefMgr::addThreatPercent(int32 percent)
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        ref->addThreatPercent(percent);
        ref = ref->next();
    }
}

//=================================================
// The online / offline status is given to the method. The calculation has to be done before

void HostileRefMgr::setOnlineOfflineState(bool isOnline)
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        ref->setOnlineOfflineState(isOnline);
        ref = ref->next();
    }
}

//=================================================
// The online / offline status is calculated and set

void HostileRefMgr::updateThreatTables()
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        ref->updateOnlineStatus();
        ref = ref->next();
    }
}

//=================================================
// The references are not needed anymore
// tell the source to remove them from the list and free the mem

void HostileRefMgr::deleteReferences()
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        HostileReference* nextRef = ref->next();
        ref->removeReference();
        delete ref;
        ref = nextRef;
    }
}

//=================================================
// delete one reference, defined by faction

void HostileRefMgr::deleteReferencesForFaction(uint32 faction)
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        HostileReference* nextRef = ref->next();
        if (ref->GetSource()->GetOwner()->GetFactionTemplateEntry()->faction == faction)
        {
            ref->removeReference();
            delete ref;
        }
        ref = nextRef;
    }
}

//=================================================
// delete one reference, defined by Unit

void HostileRefMgr::deleteReference(Unit* creature)
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        HostileReference* nextRef = ref->next();
        if (ref->GetSource()->GetOwner() == creature)
        {
            ref->removeReference();
            delete ref;
            break;
        }
        ref = nextRef;
    }
}

//=================================================
// delete all references out of specified range

void HostileRefMgr::deleteReferencesOutOfRange(float range)
{
    HostileReference* ref = getFirst();
    range = range * range;
    while (ref)
    {
        HostileReference* nextRef = ref->next();
        Unit* owner = ref->GetSource()->GetOwner();
        if (!owner->isActiveObject() && owner->GetExactDist2dSq(GetOwner()) > range)
        {
            ref->removeReference();
            delete ref;
        }
        ref = nextRef;
    }
}

//=================================================
// set state for one reference, defined by Unit

void HostileRefMgr::setOnlineOfflineState(Unit* creature, bool isOnline)
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        HostileReference* nextRef = ref->next();
        if (ref->GetSource()->GetOwner() == creature)
        {
            ref->setOnlineOfflineState(isOnline);
            break;
        }
        ref = nextRef;
    }
}

//=================================================

void HostileRefMgr::UpdateVisibility(bool checkThreat)
{
    HostileReference* ref = getFirst();
    while (ref)
    {
        HostileReference* nextRef = ref->next();
        if ((!checkThreat || ref->GetSource()->getThreatList().size() <= 1) &&
                !ref->GetSource()->GetOwner()->CanSeeOrDetect(GetOwner()))
        {
            nextRef = ref->next();
            ref->removeReference();
            delete ref;
        }
        ref = nextRef;
    }
}
