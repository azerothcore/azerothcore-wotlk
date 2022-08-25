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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_HEAL_BROTHER            = 7393,
    SPELL_TWIN_TELEPORT           = 800,
    SPELL_TWIN_TELEPORT_VISUAL    = 26638,
    SPELL_EXPLODEBUG              = 804,
    SPELL_MUTATE_BUG              = 802,
    SPELL_BERSERK                 = 26662,
    SPELL_UPPERCUT                = 26007,
    SPELL_UNBALANCING_STRIKE      = 26613,
    SPELL_SHADOWBOLT              = 26006,
    SPELL_BLIZZARD                = 26607,
    SPELL_ARCANEBURST             = 568,
};

struct boss_twinemperorsAI : public BossAI
{
    boss_twinemperorsAI(Creature* creature): BossAI(creature, DATA_TWIN_EMPERORS) { }

};

struct boss_veknilash : public boss_twinemperorsAI
{
    boss_veknilash(Creature* creature) : boss_twinemperorsAI(creature) { }

};

struct boss_veklor : public boss_twinemperorsAI
{
    boss_veklor(Creature* creature) : boss_twinemperorsAI(creature) { }

};

void AddSC_boss_twinemperors()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_veknilash);
    RegisterTempleOfAhnQirajCreatureAI(boss_veklor);
}
