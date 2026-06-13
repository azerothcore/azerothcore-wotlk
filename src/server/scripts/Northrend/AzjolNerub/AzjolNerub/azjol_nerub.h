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

#ifndef DEF_AZJOL_NERUB_H
#define DEF_AZJOL_NERUB_H

#include "CreatureAIImpl.h"

#define DataHeader "AN"

#define AzjolNerubScriptName "instance_azjol_nerub"

enum ANData
{
    DATA_KRIKTHIR                       = 0,
    DATA_HADRONOX                       = 1,
    DATA_ANUBARAK                       = 2,
    MAX_ENCOUNTERS                      = 3,

    DATA_GASHRA                         = 4,
    DATA_NARJIL                         = 5,
    DATA_SILTHIK                        = 6
};

enum ANIds
{
    NPC_WATCHER_NARJIL                  = 28729,
    NPC_WATCHER_GASHRA                  = 28730,
    NPC_WATCHER_SILTHIK                 = 28731,
    NPC_ANUBAR_SKIRMISHER               = 28734,
    NPC_ANUBAR_SHADOWCASTER             = 28733,
    NPC_ANUBAR_WARRIOR                  = 28732,
    NPC_SKITTERING_SWARMER              = 28735,
    NPC_SKITTERING_INFECTIOR            = 28736,
    NPC_KRIKTHIR_THE_GATEWATCHER        = 28684,
    NPC_HADRONOX                        = 28921,
    NPC_ANUBARAK                        = 29120,

    NPC_WORLD_TRIGGER_LAOI              = 23472,
    NPC_ANUB_AR_CHAMPION                = 29062,
    NPC_ANUB_AR_NECROMANCER             = 29063,
    NPC_ANUB_AR_CRYPTFIEND              = 29064,

    GO_KRIKTHIR_DOORS                   = 192395,
    GO_ANUBARAK_DOORS1                  = 192396,
    GO_ANUBARAK_DOORS2                  = 192397,
    GO_ANUBARAK_DOORS3                  = 192398,

    SPELL_WEB_WRAP_TRIGGER              = 52087
};

enum ANActions
{
    ACTION_MINION_DIED                   = 2,
};

template <class AI, class T>
inline AI* GetAzjolNerubAI(T* obj)
{
    return GetInstanceAI<AI>(obj, AzjolNerubScriptName);
}

#define RegisterAzjolNerubCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetAzjolNerubAI)

#endif
