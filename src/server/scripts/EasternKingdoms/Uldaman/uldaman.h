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

#ifndef DEF_ULDAMAN_H
#define DEF_ULDAMAN_H

#define DataHeader "UD"

enum DataTypes
{
    DATA_IRONAYA_DOORS                  = 0,
    DATA_STONE_KEEPERS                  = 1,
    DATA_ARCHAEDAS                      = 2,
    MAX_ENCOUNTERS                      = 3
};

enum GameObjectIds
{
    GO_ARCHAEDAS_TEMPLE_DOOR            = 141869,
    GO_TEMPLE_DOOR                      = 124367,
    GO_ANCIENT_VAULT_DOOR               = 124369,
    GO_IRONAYA_SEAL_DOOR                = 124372,
    GO_KEYSTONE                         = 124371,
};

enum NpcIds
{
    NPC_STONE_KEEPER                    = 4857,
    NPC_ARCHAEDAS                       = 2748
};

#endif
