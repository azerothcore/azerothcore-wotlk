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

enum ZeppelinEvent
{
    EVENT_UC_FROM_GROMGOL_ARRIVAL = 15312,
    EVENT_GROMGOL_FROM_UC_ARRIVAL = 15314,
    EVENT_OG_FROM_UC_ARRIVAL      = 15318,
    EVENT_UC_FROM_OG_ARRIVAL      = 15320,
    EVENT_OG_FROM_GROMGOL_ARRIVAL = 15322,
    EVENT_GROMGOL_FROM_OG_ARRIVAL = 15324,
    EVENT_WK_ARRIVAL              = 15431,
    EVENT_VL_FROM_UC_ARRIVAL      = 19126,
    EVENT_UC_FROM_VL_ARRIVAL      = 19127,
    EVENT_OG_FROM_BT_ARRIVAL      = 19137,
    EVENT_BT_FROM_OG_ARRIVAL      = 19139,
    EVENT_OG_FROM_TB_ARRIVAL      = 21868,
    EVENT_TB_FROM_OG_ARRIVAL      = 21870,
    EVENT_OG_TO_GROMGOL_DEPARTURE = 15323,
    EVENT_GROMGOL_TO_OG_DEPARTURE = 15325,
    EVENT_OG_TO_UC_DEPARTURE      = 15319,
    EVENT_UC_TO_OG_DEPARTURE      = 15321,
    EVENT_UC_TO_GROMGOL_DEPARTURE = 15313,
    EVENT_GROMGOL_TO_UC_DEPARTURE = 15315,
};

enum ZeppelinMaster
{
    NPC_NEZRAZ             = 3149,
    NPC_HINDENBURG         = 3150,
    NPC_FREZZA             = 9564,
    NPC_ZAPETTA            = 9566,
    NPC_SNURK_BUCKSQUICK   = 12136,
    NPC_SQUIBBY_OVERSPECK  = 12137,
    NPC_HARROWMEISER       = 23823,
    NPC_GREEB_RAMROCKET    = 26537,
    NPC_NARGO_SCREWBORE    = 26538,
    NPC_MEEFI_FARTHROTTLE  = 26539,
    NPC_DRENK_SPANNERSPARK = 26540,
    NPC_ZELLI_HOTNOZZLE    = 34765,
    NPC_KRENDLE_BIGPOCKETS = 34766,
};

const float SEARCH_RANGE_ZEPPELIN_MASTER = 32.0f;

enum ZeppelinPassenger
{
    // The Thundercaller
    NPC_SKY_CAPTAIN_CLOUDKICKER = 25077,
    NPC_CHIEF_OFFICER_COPPERNUT = 25070,
    // The Purple Princess
    NPC_SKY_CAPTAIN_CABLELAMP   = 25105,
    NPC_WATCHER_UMJIN           = 25107,
};
