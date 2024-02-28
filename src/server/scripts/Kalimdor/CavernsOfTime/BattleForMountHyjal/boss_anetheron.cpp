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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "hyjal.h"

enum Spells
{
    SPELL_CARRION_SWARM     = 31306,
    SPELL_SLEEP             = 31298,
    SPELL_VAMPIRIC_AURA     = 38196,
    SPELL_INFERNO           = 31299,
    SPELL_IMMOLATION        = 31303,
    SPELL_INFERNO_EFFECT    = 31302,
};

enum Texts
{
    SAY_ONDEATH         = 0,
    SAY_ONSLAY          = 1,
    SAY_SWARM           = 2,
    SAY_SLEEP           = 3,
    SAY_INFERNO         = 4,
    SAY_ONAGGRO         = 5,
};

enum Misc
{
    PATH_ANETHERON      = 178080,
    POINT_COMBAT_START  = 7
};

struct boss_anetheron : public BossAI
{
public:
    boss_anetheron(Creature* creature) : BossAI(creature, DATA_ANETHERON) { }

};

void AddSC_boss_anetheron()
{
    RegisterHyjalAI(boss_anetheron);
}
