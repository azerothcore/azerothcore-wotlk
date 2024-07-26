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

#ifndef DEF_AZJOL_NERUB_H
#define DEF_AZJOL_NERUB_H

#include "CreatureAIImpl.h"

#define DataHeader "AN"

#define AzjolNerubScriptName "instance_azjol_nerub"

enum ANData
{
    DATA_KRIKTHIR_THE_GATEWATCHER_EVENT = 0,
    DATA_HADRONOX_EVENT                 = 1,
    DATA_ANUBARAK_EVENT                 = 2,
    MAX_ENCOUNTERS                      = 3
};

enum ANIds
{
    NPC_SKITTERING_SWARMER              = 28735,
    NPC_SKITTERING_INFECTIOR            = 28736,
    NPC_KRIKTHIR_THE_GATEWATCHER        = 28684,
    NPC_HADRONOX                        = 28921,
    NPC_ANUB_AR_CHAMPION                = 29062,
    NPC_ANUB_AR_NECROMANCER             = 29063,
    NPC_ANUB_AR_CRYPTFIEND              = 29064,

    GO_KRIKTHIR_DOORS                   = 192395,
    GO_ANUBARAK_DOORS1                  = 192396,
    GO_ANUBARAK_DOORS2                  = 192397,
    GO_ANUBARAK_DOORS3                  = 192398,

    SPELL_WEB_WRAP_TRIGGER              = 52087
};

template <class AI, class T>
inline AI* GetAzjolNerubAI(T* obj)
{
    return GetInstanceAI<AI>(obj, AzjolNerubScriptName);
}

#endif
