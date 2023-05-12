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

#include "IWorld.h"

class Unit;
class IWorld;

void IWorld::AddDelayedDamage(Unit* attacker, Unit* victim, uint32 damage, CleanDamage const* cleanDamage, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask, SpellInfo const* spellProto, bool durabilityLoss)
{
    DelayedDamage delayedDamage;
    delayedDamage.attacker = attacker;
    delayedDamage.victim = victim;
    delayedDamage.damage = damage;
    delayedDamage.cleanDamage = cleanDamage;
    delayedDamage.damagetype = damagetype;
    delayedDamage.damageSchoolMask = damageSchoolMask;
    delayedDamage.spellProto = spellProto;
    delayedDamage.durabilityLoss = durabilityLoss;
    _delayedDamages.push_back(delayedDamage);
}
