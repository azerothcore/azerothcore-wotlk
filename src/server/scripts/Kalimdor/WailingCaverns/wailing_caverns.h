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

#ifndef DEF_WAILING_CAVERNS_H
#define DEF_WAILING_CAVERNS_H

#define DataHeader "WC"

enum DataTypes
{
    TYPE_LORD_COBRAHN           = 0,
    TYPE_LORD_PYTHAS            = 1,
    TYPE_LADY_ANACONDRA         = 2,
    TYPE_LORD_SERPENTIS         = 3,
    TYPE_MUTANUS                = 4,
    MAX_ENCOUNTERS              = 5,

    NPC_DISCIPLE_OF_NARALEX     = 3678,
    NPC_LORD_SERPENTIS          = 3673,

    SAY_DISCIPLE                = 0,
    SAY_SERPENTIS               = 0,
};

#endif
