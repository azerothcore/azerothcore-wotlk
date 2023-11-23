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

#ifndef DEF_VIOLET_HOLD_H
#define DEF_VIOLET_HOLD_H

#define MAX_ENCOUNTER 3

#include "CreatureAIImpl.h"

#define DataHeader "VIO"

#define VioletHoldScriptName "instance_violet_hold"

enum Creatures
{
    NPC_TELEPORTATION_PORTAL        = 31011,
    NPC_DEFENSE_SYSTEM              = 30837,
    NPC_PRISON_DOOR_SEAL            = 30896,
    NPC_DEFENSE_DUMMY_TARGET        = 30857,

    NPC_SINCLARI                    = 30658,
    NPC_VIOLET_HOLD_GUARD           = 30659,
    NPC_SABOTEOUR                   = 31079,

    NPC_XEVOZZ                      = 29266,
    NPC_LAVANTHOR                   = 29312,
    NPC_ICHORON                     = 29313,
    NPC_ZURAMAT                     = 29314,
    NPC_EREKEM                      = 29315,
    NPC_EREKEM_GUARD                = 29395,
    NPC_MORAGG                      = 29316,
    NPC_CYANIGOSA                   = 31134,

    NPC_PORTAL_GUARDIAN             = 30660,
    NPC_PORTAL_KEEPER               = 30695,
    NPC_AZURE_INVADER_1             = 30661,
    NPC_AZURE_INVADER_2             = 30961,
    NPC_AZURE_SPELLBREAKER_1        = 30662,
    NPC_AZURE_SPELLBREAKER_2        = 30962,
    NPC_AZURE_BINDER_1              = 30663,
    NPC_AZURE_BINDER_2              = 30918,
    NPC_AZURE_MAGE_SLAYER_1         = 30664,
    NPC_AZURE_MAGE_SLAYER_2         = 30963,
    NPC_AZURE_CAPTAIN               = 30666,
    NPC_AZURE_SORCEROR              = 30667,
    NPC_AZURE_RAIDER                = 30668,
    NPC_AZURE_STALKER               = 32191,
};

enum GameObjects
{
    GO_MAIN_DOOR                    = 191723,
    GO_XEVOZZ_DOOR                  = 191556,
    GO_LAVANTHOR_DOOR               = 191566,
    GO_ICHORON_DOOR                 = 191722,
    GO_ZURAMAT_DOOR                 = 191565,
    GO_EREKEM_DOOR                  = 191564,
    GO_EREKEM_GUARD_1_DOOR          = 191563,
    GO_EREKEM_GUARD_2_DOOR          = 191562,
    GO_MORAGG_DOOR                  = 191606,
    GO_INTRO_ACTIVATION_CRYSTAL     = 193615,
    GO_ACTIVATION_CRYSTAL           = 193611,
};

enum Bosses
{
    BOSS_NONE,
    BOSS_MORAGG,
    BOSS_EREKEM,
    BOSS_ICHORON,
    BOSS_LAVANTHOR,
    BOSS_XEVOZZ,
    BOSS_ZURAMAT,
    BOSS_CYANIGOSA
};

enum VHWorldStates
{
    WORLD_STATE_VH_SHOW             = 3816,
    WORLD_STATE_VH_PRISON_STATE     = 3815,
    WORLD_STATE_VH_WAVE_COUNT       = 3810,
};

enum Spells
{
    SPELL_CONTROL_CRYSTAL_ACTIVATION   = 57804,
    SPELL_DEFENSE_SYSTEM_SPAWN_EFFECT  = 57886,
    SPELL_DEFENSE_SYSTEM_VISUAL        = 57887,
    SPELL_ARCANE_LIGHTNING             = 57912,
    SPELL_ARCANE_LIGHTNING_VISUAL      = 57930,
    SPELL_ARCANE_LIGHTNING_INSTAKILL   = 58152,
    SPELL_PORTAL_CHANNEL               = 58012,
    SPELL_DESTROY_DOOR_SEAL            = 58040,
    SPELL_CYANIGOSA_TRANSFORM          = 58668,
    SPELL_CYANIGOSA_BLUE_AURA          = 45870
};

enum Events
{
    EVENT_CHECK_PLAYERS = 1,
    EVENT_GUARDS_FALL_BACK,
    EVENT_GUARDS_DISAPPEAR,
    EVENT_SINCLARI_FALL_BACK,
    EVENT_START_ENCOUNTER,
    EVENT_SUMMON_PORTAL,
    EVENT_CYANIGOSSA_TRANSFORM,
    EVENT_CYANIGOSA_ATTACK,

    // Event defense system
    EVENT_ARCANE_LIGHTNING,
    EVENT_ARCANE_LIGHTNING_INSTAKILL
};

enum Data
{
    DATA_ACTIVATE_DEFENSE_SYSTEM = 1,
    DATA_ENCOUNTER_STATUS,
    DATA_START_INSTANCE,
    DATA_ADD_TRASH_MOB,
    DATA_DELETE_TRASH_MOB,
    DATA_PORTAL_DEFEATED,
    DATA_WAVE_COUNT,
    DATA_PORTAL_LOCATION,
    DATA_TELEPORTATION_PORTAL_GUID,
    DATA_DOOR_SEAL_GUID,
    DATA_FIRST_BOSS_NUMBER,
    DATA_SECOND_BOSS_NUMBER,
    DATA_RELEASE_BOSS,
    DATA_DECRASE_DOOR_HEALTH,
    DATA_BOSS_DIED,
    DATA_FAILED,
    DATA_EREKEM_GUID,
    DATA_EREKEM_GUARD_1_GUID,
    DATA_EREKEM_GUARD_2_GUID,
    DATA_ICHORON_GUID,
    DATA_ACHIEV,
};

enum AchievCriteria
{
    CRITERIA_DEFENSELESS            = 6803,
    CRITERIA_A_VOID_DANCE           = 7587,
    CRITERIA_DEHYDRATION            = 7320,
};

/**************
** POSITIONS AND WAYPOINTS:
**************/

const Position guardMovePosition = {1806.955566f, 803.851807f, 44.363323f, 0.0f};
const Position playerTeleportPosition = {1830.531006f, 803.939758f, 44.340508f, 6.281611f};
const Position sinclariOutsidePosition = {1817.315674f, 804.060608f, 44.363998f, 0.0f};
const Position MiddleRoomPortalSaboLocation = {1896.622925f, 804.854126f, 38.504772f, 3.139621f};

const Position BossStartMove1  = {1894.684448f, 739.390503f, 47.668003f, 0.0f};
const Position BossStartMove2  = {1875.173950f, 860.832703f, 43.333565f, 0.0f};
const Position BossStartMove21 = {1858.854614f, 855.071411f, 43.333565f, 0.0f};
const Position BossStartMove22 = {1891.926636f, 863.388977f, 43.333565f, 0.0f};
const Position BossStartMove3  = {1916.138062f, 778.152222f, 35.772308f, 0.0f};
const Position BossStartMove4  = {1853.618286f, 758.557617f, 38.657505f, 0.0f};
const Position BossStartMove5  = {1906.683960f, 842.348022f, 38.637459f, 0.0f};
const Position BossStartMove6  = {1928.207031f, 852.864441f, 47.200813f, 0.0f};

const Position CyanigosasSpawnLocation = {1930.281250f, 804.407715f, 52.410946f, 3.139621f};
const Position MiddleRoomLocation = {1892.291260f, 805.696838f, 38.438862f, 3.139621f};

const uint8 PLocWPCount[6] = {6, 9, 8, 9, 6, 4};

const Position PortalLocations[] =
{
    {1877.51f, 850.104f, 44.6599f, 4.78220f},
    {1918.37f, 853.437f, 47.1624f, 4.12294f},
    {1936.07f, 803.198f, 53.3749f, 3.12414f},
    {1927.61f, 758.436f, 51.4533f, 2.20891f},
    {1890.64f, 753.471f, 48.7224f, 1.71042f},
    {1908.31f, 809.657f, 38.7037f, 3.08701f},
};

const float FirstPortalTrashWPs [6][3] =
{
    {1877.670288f, 842.280273f, 43.333591f},
    {1877.338867f, 834.615356f, 38.762287f},
    {1872.161011f, 823.854309f, 38.645401f},
    {1864.860474f, 815.787170f, 38.784843f},
    {1858.953735f, 810.048950f, 44.008759f},
    {1843.707153f, 805.807739f, 44.135197f},
};

const float SecondPortalTrashWPs1 [9][3] =
{
    {1902.561401f, 853.334656f, 47.106117f},
    {1895.486084f, 855.376404f, 44.334591f},
    {1882.805176f, 854.993286f, 43.333591f},
    {1877.670288f, 842.280273f, 43.333591f},
    {1877.338867f, 834.615356f, 38.762287f},
    {1872.161011f, 823.854309f, 38.645401f},
    {1864.860474f, 815.787170f, 38.784843f},
    {1858.953735f, 810.048950f, 44.008759f},
    {1843.707153f, 805.807739f, 44.135197f},
};

const float SecondPortalTrashWPs2 [8][3] =
{
    {1929.392212f, 837.614990f, 47.136166f},
    {1928.290649f, 824.750427f, 45.474411f},
    {1915.544922f, 826.919373f, 38.642811f},
    {1900.933960f, 818.855652f, 38.801647f},
    {1886.810547f, 813.536621f, 38.490490f},
    {1869.079712f, 808.701538f, 38.689003f},
    {1860.843384f, 806.645020f, 44.008789f},
    {1843.707153f, 805.807739f, 44.135197f},
};

const float ThirdPortalTrashWPs [8][3] =
{
    {1934.049438f, 815.778503f, 52.408699f},
    {1928.290649f, 824.750427f, 45.474411f},
    {1915.544922f, 826.919373f, 38.642811f},
    {1900.933960f, 818.855652f, 38.801647f},
    {1886.810547f, 813.536621f, 38.490490f},
    {1869.079712f, 808.701538f, 38.689003f},
    {1860.843384f, 806.645020f, 44.008789f},
    {1843.707153f, 805.807739f, 44.135197f},
};

const float FourthPortalTrashWPs [9][3] =
{
    {1921.658447f, 761.657043f, 50.866741f},
    {1910.559814f, 755.780457f, 47.701447f},
    {1896.664673f, 752.920898f, 47.667004f},
    {1887.398804f, 763.633240f, 47.666851f},
    {1879.020386f, 775.396973f, 38.705990f},
    {1872.439087f, 782.568604f, 38.808292f},
    {1863.573364f, 791.173584f, 38.743660f},
    {1857.811890f, 796.765564f, 43.950329f},
    {1845.577759f, 800.681152f, 44.104248f},
};

const float FifthPortalTrashWPs [6][3] =
{
    {1887.398804f, 763.633240f, 47.666851f},
    {1879.020386f, 775.396973f, 38.705990f},
    {1872.439087f, 782.568604f, 38.808292f},
    {1863.573364f, 791.173584f, 38.743660f},
    {1857.811890f, 796.765564f, 43.950329f},
    {1845.577759f, 800.681152f, 44.104248f},
};

const float SixthPoralTrashWPs [4][3] =
{
    {1888.861084f, 805.074768f, 38.375790f},
    {1869.793823f, 804.135804f, 38.647018f},
    {1861.541504f, 804.149780f, 43.968292f},
    {1843.567017f, 804.288208f, 44.139091f},
};

const float SaboteurFinalPos1[3][3] =
{
    {1892.502319f, 777.410767f, 38.630402f},
    {1891.165161f, 762.969421f, 47.666920f},
    {1893.168091f, 740.919189f, 47.666920f}
};

const float SaboteurFinalPos2[3][3] =
{
    {1882.242676f, 834.818726f, 38.646786f},
    {1879.220825f, 842.224854f, 43.333641f},
    {1873.842896f, 863.892456f, 43.333641f}
};

const float SaboteurFinalPos3[2][3] =
{
    {1904.298340f, 792.400391f, 38.646782f},
    {1935.716919f, 758.437073f, 30.627895f}
};

const float SaboteurFinalPos4[3] =
{
    1855.006104f, 760.641724f, 38.655266f
};

const float SaboteurFinalPos5[3] =
{
    1906.667358f, 841.705566f, 38.637894f
};

const float SaboteurFinalPos6[5][3] =
{
    {1911.437012f, 821.289246f, 38.684128f},
    {1920.734009f, 822.978027f, 41.525414f},
    {1928.262939f, 830.836609f, 44.668266f},
    {1929.338989f, 837.593933f, 47.137596f},
    {1931.063354f, 848.468445f, 47.190434f}
};

template <class AI, class T>
inline AI* GetVioletHoldAI(T* obj)
{
    return GetInstanceAI<AI>(obj, VioletHoldScriptName);
}

#endif
