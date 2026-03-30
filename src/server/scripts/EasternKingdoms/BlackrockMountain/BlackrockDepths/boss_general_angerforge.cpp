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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "blackrock_depths.h"

enum Spells
{
    SPELL_MIGHTYBLOW                                       = 14099,
    SPELL_HAMSTRING                                        = 9080,
    SPELL_CLEAVE                                           = 20691
};

struct boss_general_angerforge : public ScriptedAI
{
    boss_general_angerforge(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _mightyBlowTimer = 8000;
        _hamStringTimer = 12000;
        _cleaveTimer = 16000;
        _addsTimer = 0;
        _medics = false;
    }

    void JustEngagedWith(Unit* /*who*/) override { }

    void SummonAdds(Unit* victim)
    {
        if (Creature* SummonedAdd = DoSpawnCreature(8901, float(irand(-14, 14)), float(irand(-14, 14)), 0, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 120000))
            SummonedAdd->AI()->AttackStart(victim);
    }

    void SummonMedics(Unit* victim)
    {
        if (Creature* SummonedMedic = DoSpawnCreature(8894, float(irand(-9, 9)), float(irand(-9, 9)), 0, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 120000))
            SummonedMedic->AI()->AttackStart(victim);
    }

    void UpdateAI(uint32 diff) override
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        if (_mightyBlowTimer <= diff)
        {
            DoCastVictim(SPELL_MIGHTYBLOW);
            _mightyBlowTimer = 18000;
        }
        else _mightyBlowTimer -= diff;

        if (_hamStringTimer <= diff)
        {
            DoCastVictim(SPELL_HAMSTRING);
            _hamStringTimer = 15000;
        }
        else _hamStringTimer -= diff;

        if (_cleaveTimer <= diff)
        {
            DoCastVictim(SPELL_CLEAVE);
            _cleaveTimer = 9000;
        }
        else _cleaveTimer -= diff;

        if (HealthBelowPct(21))
        {
            if (_addsTimer <= diff)
            {
                // summon 3 Adds every 25s
                SummonAdds(me->GetVictim());
                SummonAdds(me->GetVictim());
                SummonAdds(me->GetVictim());

                _addsTimer = 25000;
            }
            else _addsTimer -= diff;
        }

        //Summon Medics
        if (!_medics && HealthBelowPct(21))
        {
            SummonMedics(me->GetVictim());
            SummonMedics(me->GetVictim());
            _medics = true;
        }

        DoMeleeAttackIfReady();
    }

private:
    uint32 _mightyBlowTimer;
    uint32 _hamStringTimer;
    uint32 _cleaveTimer;
    uint32 _addsTimer;
    bool _medics;
};

void AddSC_boss_general_angerforge()
{
    RegisterBlackrockDepthsCreatureAI(boss_general_angerforge);
}
