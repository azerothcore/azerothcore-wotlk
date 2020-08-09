/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _UNITEVENTS
#define _UNITEVENTS

#include "Common.h"

class ThreatContainer;
class ThreatManager;
class HostileReference;

//==============================================================
//==============================================================

enum UNIT_EVENT_TYPE
{
    // Player/Pet changed on/offline status
    UEV_THREAT_REF_ONLINE_STATUS        = 1<<0,

    // Threat for Player/Pet changed
    UEV_THREAT_REF_THREAT_CHANGE        = 1<<1,

    // Player/Pet will be removed from list (dead) [for internal use]
    UEV_THREAT_REF_REMOVE_FROM_LIST     = 1<<2,

    // Player/Pet entered/left  water or some other place where it is/was not accessible for the creature
    UEV_THREAT_REF_ASSECCIBLE_STATUS    = 1<<3,

    // Threat list is going to be sorted (if dirty flag is set)
    UEV_THREAT_SORT_LIST                = 1<<4,

    // New target should be fetched, could tbe the current target as well
    UEV_THREAT_SET_NEXT_TARGET          = 1<<5,

    // A new victim (target) was set. Could be NULL
    UEV_THREAT_VICTIM_CHANGED           = 1<<6,

    // Future use
    //UEV_UNIT_KILLED                   = 1<<7,

    //Future use
    //UEV_UNIT_HEALTH_CHANGE            = 1<<8,
};

#define UEV_THREAT_REF_EVENT_MASK (UEV_THREAT_REF_ONLINE_STATUS | UEV_THREAT_REF_THREAT_CHANGE | UEV_THREAT_REF_REMOVE_FROM_LIST | UEV_THREAT_REF_ASSECCIBLE_STATUS)
#define UEV_THREAT_MANAGER_EVENT_MASK (UEV_THREAT_SORT_LIST | UEV_THREAT_SET_NEXT_TARGET | UEV_THREAT_VICTIM_CHANGED)
#define UEV_ALL_EVENT_MASK (0xffffffff)

// Future use
//#define UEV_UNIT_EVENT_MASK (UEV_UNIT_KILLED | UEV_UNIT_HEALTH_CHANGE)

//==============================================================

class UnitBaseEvent
{
    private:
        uint32 iType;
    public:
        UnitBaseEvent(uint32 pType) { iType = pType; }
        uint32 getType() const { return iType; }
        bool matchesTypeMask(uint32 pMask) const { return iType & pMask; }

        void setType(uint32 pType) { iType = pType; }

};

//==============================================================

class ThreatRefStatusChangeEvent : public UnitBaseEvent
{
    private:
        HostileReference* iHostileReference;
        union
        {
            float iFValue;
            int32 iIValue;
            bool iBValue;
        };
        ThreatManager* iThreatManager;
    public:
        ThreatRefStatusChangeEvent(uint32 pType) : UnitBaseEvent(pType), iThreatManager(nullptr) { iHostileReference = nullptr; }

        ThreatRefStatusChangeEvent(uint32 pType, HostileReference* pHostileReference) : UnitBaseEvent(pType), iThreatManager(nullptr) { iHostileReference = pHostileReference; }

        ThreatRefStatusChangeEvent(uint32 pType, HostileReference* pHostileReference, float pValue) : UnitBaseEvent(pType), iThreatManager(nullptr) { iHostileReference = pHostileReference; iFValue = pValue; }

        ThreatRefStatusChangeEvent(uint32 pType, HostileReference* pHostileReference, bool pValue) : UnitBaseEvent(pType), iThreatManager(nullptr) { iHostileReference = pHostileReference; iBValue = pValue; }

        int32 getIValue() const { return iIValue; }

        float getFValue() const { return iFValue; }

        bool getBValue() const { return iBValue; }

        void setBValue(bool pValue) { iBValue = pValue; }

        HostileReference* getReference() const { return iHostileReference; }

        void setThreatManager(ThreatManager* pThreatManager) { iThreatManager = pThreatManager; }

        ThreatManager* getThreatManager() const { return iThreatManager; }
};

//==============================================================

class ThreatManagerEvent : public ThreatRefStatusChangeEvent
{
    private:
        ThreatContainer* iThreatContainer;
    public:
        ThreatManagerEvent(uint32 pType) : ThreatRefStatusChangeEvent(pType), iThreatContainer(nullptr) {}
        ThreatManagerEvent(uint32 pType, HostileReference* pHostileReference) : ThreatRefStatusChangeEvent(pType, pHostileReference), iThreatContainer(nullptr) {}

        void setThreatContainer(ThreatContainer* pThreatContainer) { iThreatContainer = pThreatContainer; }

        ThreatContainer* getThreatContainer() const { return iThreatContainer; }
};

//==============================================================
#endif

