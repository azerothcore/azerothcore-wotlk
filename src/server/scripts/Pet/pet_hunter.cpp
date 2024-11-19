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
 * Scriptnames of files in this file should be prefixed with "npc_pet_hun_".
 */

#include "CreatureScript.h"
#include "PetDefines.h"
#include "ScriptedCreature.h"

enum HunterSpells
{
    SPELL_HUNTER_CRIPPLING_POISON       = 30981, // Viper
    SPELL_HUNTER_DEADLY_POISON_PASSIVE  = 34657, // Venomous Snake
    SPELL_HUNTER_MIND_NUMBING_POISON    = 25810, // Viper
    SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP    = 56849,
    SPELL_HUNTER_PET_SCALING            = 62915
};

struct npc_pet_hunter_snake_trap : public ScriptedAI
{
    npc_pet_hunter_snake_trap(Creature* creature) : ScriptedAI(creature) { _init = false; }

    void Reset() override
    {
        _spellTimer = urand(1500, 3000);

        // Start attacking attacker of owner on first ai update after spawn - move in line of sight may choose better target
        if (!me->GetVictim())
            if (Unit* tgt = me->SelectNearestTarget(10.0f))
            {
                me->AddThreat(tgt, 100000.0f);
                AttackStart(tgt);
            }
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        // _EnterEvadeMode();
        me->GetThreatMgr().ClearAllThreat();
        me->CombatStop(true);
        me->LoadCreaturesAddon(true);
        me->SetLootRecipient(nullptr);
        me->ResetPlayerDamageReq();
        me->ClearLastLeashExtensionTimePtr();

        me->AddUnitState(UNIT_STATE_EVADE);
        me->GetMotionMaster()->MoveTargetedHome();

        Reset();
    }

    //Redefined for random target selection:
    void MoveInLineOfSight(Unit* who) override
    {
        if (!me->GetVictim() && who->isTargetableForAttack() && (me->IsHostileTo(who)) && who->isInAccessiblePlaceFor(me))
        {
            if (me->GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
                return;

            if (me->IsWithinDistInMap(who, 10.0f))
            {
                me->AddThreat(who, 100000.0f);
                AttackStart(who);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (me->GetVictim()->HasBreakableByDamageCrowdControlAura(me))
        {
            me->InterruptNonMeleeSpells(false);
            return;
        }

        if (!_init)
        {
            _init = true;

            uint32 health = uint32(107 * (me->GetLevel() - 40) * 0.025f);
            me->SetCreateHealth(health);
            me->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)health);
            me->SetMaxHealth(health);

            //Add delta to make them not all hit the same time
            uint32 delta = urand(0, 700);
            me->SetAttackTime(BASE_ATTACK, me->GetAttackTime(BASE_ATTACK) + delta);

            if (me->GetEntry() == NPC_VENOMOUS_SNAKE)
                DoCastSelf(SPELL_HUNTER_DEADLY_POISON_PASSIVE, true);

            // Glyph of Snake Trap
            if (Unit* owner = me->GetOwner())
                if (owner->GetAuraEffectDummy(SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP))
                    me->CastSpell(me, SPELL_HUNTER_PET_SCALING, true);
        }

        _spellTimer += diff;
        if (_spellTimer >= 3000)
        {
            if (urand(0, 2) == 0) // 33% chance to cast
                DoCastVictim(RAND(SPELL_HUNTER_MIND_NUMBING_POISON, SPELL_HUNTER_CRIPPLING_POISON));

            _spellTimer = 0;
        }

        DoMeleeAttackIfReady();
    }

private:
    bool _init;
    uint32 _spellTimer;
};

void AddSC_hunter_pet_scripts()
{
    RegisterCreatureAI(npc_pet_hunter_snake_trap);
}
