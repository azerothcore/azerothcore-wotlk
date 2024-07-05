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

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_sha_".
 */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"

enum ShamanSpells
{
    SPELL_SHAMAN_ANGEREDEARTH   = 36213,
    SPELL_SHAMAN_FIREBLAST      = 57984,
    SPELL_SHAMAN_FIRENOVA       = 12470,
    SPELL_SHAMAN_FIRESHIELD     = 13377
};

enum ShamanEvents
{
    // Earth Elemental
    EVENT_SHAMAN_ANGEREDEARTH   = 1,
    // Fire Elemental
    EVENT_SHAMAN_FIRENOVA       = 1,
    EVENT_SHAMAN_FIRESHIELD     = 2,
    EVENT_SHAMAN_FIREBLAST      = 3
};

struct npc_pet_shaman_earth_elemental : public ScriptedAI
{
    npc_pet_shaman_earth_elemental(Creature* creature) : ScriptedAI(creature), _initAttack(true) { }

    void JustEngagedWith(Unit*) override
    {
        _events.Reset();
        _events.ScheduleEvent(EVENT_SHAMAN_ANGEREDEARTH, 0);
    }

    void InitializeAI() override { }

    void UpdateAI(uint32 diff) override
    {
        if (_initAttack)
        {
            if (!me->IsInCombat())
                if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                    if (Unit* target = owner->GetSelectedUnit())
                        if (me->CanCreatureAttack(target))
                            AttackStart(target);
            _initAttack = false;
        }

        if (!UpdateVictim())
            return;

        _events.Update(diff);

        if (_events.ExecuteEvent() == EVENT_SHAMAN_ANGEREDEARTH)
        {
            DoCastVictim(SPELL_SHAMAN_ANGEREDEARTH);
            _events.ScheduleEvent(EVENT_SHAMAN_ANGEREDEARTH, urand(5000, 20000));
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    bool _initAttack;
};

struct npc_pet_shaman_fire_elemental : public ScriptedAI
{
    npc_pet_shaman_fire_elemental(Creature* creature) : ScriptedAI(creature), _initAttack(true) { }

    void InitializeAI() override { }

    void JustEngagedWith(Unit*) override
    {
        _events.Reset();
        _events.ScheduleEvent(EVENT_SHAMAN_FIRENOVA, urand(5000, 20000));
        _events.ScheduleEvent(EVENT_SHAMAN_FIREBLAST, urand(5000, 20000));
        //_events.ScheduleEvent(EVENT_SHAMAN_FIRESHIELD, 0);

        me->RemoveAurasDueToSpell(SPELL_SHAMAN_FIRESHIELD);
        me->CastSpell(me, SPELL_SHAMAN_FIRESHIELD, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (_initAttack)
        {
            if (!me->IsInCombat())
                if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                    if (Unit* target = owner->GetSelectedUnit())
                        if (me->CanCreatureAttack(target))
                            AttackStart(target);
            _initAttack = false;
        }

        if (!UpdateVictim())
            return;

        _events.Update(diff);
        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SHAMAN_FIRENOVA:
                    me->CastSpell(me, SPELL_SHAMAN_FIRENOVA, false);
                    _events.ScheduleEvent(EVENT_SHAMAN_FIRENOVA, urand(8000, 15000));
                    break;
                case EVENT_SHAMAN_FIREBLAST:
                    me->CastSpell(me->GetVictim(), SPELL_SHAMAN_FIREBLAST, false);
                    _events.ScheduleEvent(EVENT_SHAMAN_FIREBLAST, urand(4000, 8000));
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    bool _initAttack;
};

void AddSC_shaman_pet_scripts()
{
    RegisterCreatureAI(npc_pet_shaman_earth_elemental);
    RegisterCreatureAI(npc_pet_shaman_fire_elemental);
}
