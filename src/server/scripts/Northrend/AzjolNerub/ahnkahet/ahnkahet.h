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

#ifndef DEF_AHNKAHET_H
#define DEF_AHNKAHET_H

#define DataHeader "AK"
#define AhnKahetScriptName "instance_ahnkahet"
constexpr uint32 MAX_ENCOUNTER = 5;
enum AhnkahetData
{
    // Main encounters
    DATA_ELDER_NADOX            = 0,
    DATA_PRINCE_TALDARAM        = 1,
    DATA_JEDOGA_SHADOWSEEKER    = 2,
    DATA_HERALD_VOLAZJ          = 3,
    DATA_AMANITAR               = 4,

    // Other data
    // Teldram encounter related
    DATA_PRINCE_TALDARAM_PLATFORM,
};

enum AhnKahetCreatures
{
    NPC_ELDER_NADOX                 = 29309,
    NPC_PRINCE_TALDARAM             = 29308,
    NPC_JEDOGA_SHADOWSEEKER         = 29310,
    NPC_HERALD_VOLAZJ               = 29311,
    NPC_AMANITAR                    = 30258,
    // Teldaram and Jedoga encounter related
    NPC_JEDOGA_CONTROLLER           = 30181,
};

enum AhnkahetSpells
{
    SPELL_SHADOW_SICKLE             = 56701, // Shadow Sickle Normal
};

enum AhnkahetObjects
{
    GO_TELDARAM_DOOR                = 192236,
    GO_TELDARAM_SPHERE1             = 193093,
    GO_TELDARAM_SPHERE2             = 193094,
    GO_TELDARAM_PLATFORM            = 193564,
};

enum AhnKahetActions
{
    ACTION_REMOVE_PRISON            = -1
};

enum AhnKahetTexts
{
    SAY_SPHERE_ACTIVATED            = 0
};

enum AhnKahetPersistentData
{
    DATA_TELDRAM_SPHERE1,
    DATA_TELDRAM_SPHERE2,
    MAX_PERSISTENT_DATA
};

template <class AI, class T>
inline AI* GetAhnKahetAI(T* obj)
{
    return GetInstanceAI<AI>(obj, AhnKahetScriptName);
}

#define RegisterAhnKahetCreatureAI(ai_name) RegisterCreatureAIWithFactory(ai_name, GetAhnKahetAI)
#define RegisterAhnKahetGameObjectAI(ai_name) RegisterGameObjectAIWithFactory(ai_name, GetAhnKahetAI)

#endif // DEF_AHNKAHET_H
