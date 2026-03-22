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
    SPELL_SHADOWWORDPAIN                                   = 10894,
    SPELL_MANABURN                                         = 10876,
    SPELL_PSYCHICSCREAM                                    = 8122,
    SPELL_SHADOWSHIELD                                     = 22417
};

struct boss_high_interrogator_gerstahn : public ScriptedAI
{
    boss_high_interrogator_gerstahn(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _shadowWordPainTimer = 4000;
        _manaBurnTimer = 14000;
        _psychicScreamTimer = 32000;
        _shadowShieldTimer = 8000;
    }

    void JustEngagedWith(Unit* /*who*/) override { }

    void UpdateAI(uint32 diff) override
    {
        //Return since we have no target
        if (!UpdateVictim())
            return;

        if (_shadowWordPainTimer <= diff)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                DoCast(target, SPELL_SHADOWWORDPAIN);
            _shadowWordPainTimer = 7000;
        }
        else _shadowWordPainTimer -= diff;

        if (_manaBurnTimer <= diff)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100, true))
                DoCast(target, SPELL_MANABURN);
            _manaBurnTimer = 10000;
        }
        else _manaBurnTimer -= diff;

        if (_psychicScreamTimer <= diff)
        {
            DoCastVictim(SPELL_PSYCHICSCREAM);
            _psychicScreamTimer = 30000;
        }
        else _psychicScreamTimer -= diff;

        if (_shadowShieldTimer <= diff)
        {
            DoCast(me, SPELL_SHADOWSHIELD);
            _shadowShieldTimer = 25000;
        }
        else _shadowShieldTimer -= diff;

        DoMeleeAttackIfReady();
    }

private:
    uint32 _shadowWordPainTimer;
    uint32 _manaBurnTimer;
    uint32 _psychicScreamTimer;
    uint32 _shadowShieldTimer;
};

void AddSC_boss_high_interrogator_gerstahn()
{
    RegisterBlackrockDepthsCreatureAI(boss_high_interrogator_gerstahn);
}
