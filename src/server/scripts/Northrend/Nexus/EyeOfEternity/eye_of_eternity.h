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

#ifndef DEF_EYE_OF_ETERNITY_H
#define DEF_EYE_OF_ETERNITY_H

#include "Chat.h"
#include "CreatureAIImpl.h"

#define DataHeader "EOE"
#define EyeOfEternityScriptName "instance_eye_of_eternity"

uint32 const EncounterCount = 1;

enum Objects
{
    GO_NEXUS_PLATFORM           = 193070,
    GO_IRIS_N                   = 193958,
    GO_IRIS_H                   = 193960,
    GO_EXIT_PORTAL              = 193908,
};
#define ALEXSTRASZA_GIFT        DUNGEON_MODE(193905, 193967)
#define HEART_OF_MAGIC          DUNGEON_MODE(194158, 194159)

enum NPCs
{
    NPC_MALYGOS                 = 28859,
    NPC_PORTAL                  = 30118,
    NPC_WORLD_TRIGGER_LAOI      = 22517,
    NPC_POWER_SPARK             = 30084,
    NPC_VORTEX                  = 30090,
    NPC_NEXUS_LORD              = 30245,
    NPC_SCION_OF_ETERNITY       = 30249,
    NPC_HOVER_DISK              = 30248,
    NPC_ARCANE_OVERLOAD         = 30282,
    NPC_SURGE_OF_POWER          = 30334,
    NPC_STATIC_FIELD            = 30592,
    NPC_ALEXSTRASZA             = 32295,
};

enum Data
{
    DATA_MALYGOS                = 0,
    DATA_IRIS_ACTIVATED,
    DATA_SET_IRIS_INACTIVE,
    DATA_HIDE_IRIS_AND_PORTAL,
    DATA_MALYGOS_GUID,
};

enum eSpells
{
    SPELL_PORTAL_BEAM                   = 56046,
    SPELL_IRIS_ACTIVATED                = 61012,
    SPELL_POWER_SPARK_VISUAL            = 55845,
    SPELL_POWER_SPARK_GROUND_BUFF       = 55852,
    SPELL_POWER_SPARK_MALYGOS_BUFF      = 56152,

    SPELL_TELEPORT_VISUAL               = 52096,

    SPELL_SCION_ARCANE_BARRAGE          = 56397,
    SPELL_ARCANE_SHOCK                  = 57058,
    SPELL_HASTE                         = 57060,

    SPELL_ALEXSTRASZA_GIFT              = 61028,
    SPELL_SUMMON_RED_DRAGON_BUDDY       = 56070,
    SPELL_RIDE_RED_DRAGON               = 56072
};

enum eAchiev
{
    ACHIEV_CRITERIA_DENYIN_THE_SCION_10     = 7573,
    ACHIEV_CRITERIA_DENYIN_THE_SCION_25     = 7574,
    ACHIEV_CRITERIA_A_POKE_IN_THE_EYE_10    = 7174,
    ACHIEV_CRITERIA_A_POKE_IN_THE_EYE_25    = 7175,
    ACHIEV_YOU_DONT_HAVE_AN_ENTERNITY_EVENT = 20387,
};

enum EoEMisc : uint32
{
    EVENT_IRIS_ACTIVATED                    = 20158
};

/*** POSITIONS/WAYPOINTS BELOW ***/

#define INTRO_MOVEMENT_INTERVAL 25000

const Position CenterPos = {754.395f, 1301.27f, 266.10f, 0.0f};

const Position FourSidesPos[] =
{
    {686.417f, 1235.52f, 288.17f, M_PI / 4},
    {828.182f, 1379.05f, 288.17f, 5 * M_PI / 4},
    {681.278f, 1375.796f, 288.17f, 7 * M_PI / 4},
    {821.182f, 1235.42f, 288.17f, 3 * M_PI / 4},
};

const Position Phase2NorthPos = {837.22f, 1301.676f, 296.10f, M_PI};

const uint32 MalygosIntroIntervals[] = {18000, 19000, 21000, 18000, 15000};

template <class AI, class T>
inline AI* GetEyeOfEternityAI(T* obj)
{
    return GetInstanceAI<AI>(obj, EyeOfEternityScriptName);
}
#define RegisterEoECreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetEyeOfEternityAI)

#endif
