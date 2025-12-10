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
#include "ObjectAccessor.h"
#include "ScriptedCreature.h"
#include "molten_core.h"

enum Texts
{
    EMOTE_LOWHP                 = 0,
};

enum Spells
{
    // Golemagg
    SPELL_PYROBLAST             = 20228,
    SPELL_EARTHQUAKE            = 19798,
    SPELL_ATTRACK_RAGER         = 20544,
    SPELL_MAGMASPLASH           = 13879,
    SPELL_GOLEMAGG_TRUST_AURA   = 20556,
    SPELL_DOUBLE_ATTACK         = 18943,

    // Core Rager
    SPELL_MANGLE                = 19820,
    SPELL_FULL_HEAL             = 17683,
};

class boss_golemagg : public CreatureScript
{
public:
    boss_golemagg() : CreatureScript("boss_golemagg") { }

    struct boss_golemaggAI : public BossAI
    {
        boss_golemaggAI(Creature* creature) : BossAI(creature, DATA_GOLEMAGG),
            earthquakeTimer(0),
            pyroblastTimer(0),
            enraged(false)
        {}

        void Reset() override
        {
            _Reset();
            earthquakeTimer = 0;
            pyroblastTimer = urand(3000, 7000);
            enraged = false;
            DoCastSelf(SPELL_MAGMASPLASH);
            DoCastSelf(SPELL_GOLEMAGG_TRUST_AURA);
            DoCastSelf(SPELL_DOUBLE_ATTACK);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!enraged && me->HealthBelowPctDamaged(10, damage))
            {
                DoCastSelf(SPELL_ATTRACK_RAGER, true);
                DoCastAOE(SPELL_EARTHQUAKE, true);
                earthquakeTimer = 5000;
                enraged = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            // Should not get impact by cast state (cast should always happen)
            if (earthquakeTimer)
            {
                if (earthquakeTimer <= diff)
                {
                    DoCastSelf(SPELL_EARTHQUAKE, true);
                    earthquakeTimer = 5000;
                }
                else
                {
                    earthquakeTimer -= diff;
                }
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            if (pyroblastTimer <= diff)
            {
                DoCastRandomTarget(SPELL_PYROBLAST);

                pyroblastTimer = 7000;
            }
            else
            {
                pyroblastTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint32 earthquakeTimer;
        uint32 pyroblastTimer;
        bool enraged;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<boss_golemaggAI>(creature);
    }
};

class npc_core_rager : public CreatureScript
{
public:
    npc_core_rager() : CreatureScript("npc_core_rager") { }

    struct npc_core_ragerAI : public ScriptedAI
    {
        npc_core_ragerAI(Creature* creature) : ScriptedAI(creature),
            instance(creature->GetInstanceScript()),
            mangleTimer(7000),
            rangeCheckTimer(1000)
        {
        }

        void Reset() override
        {
            mangleTimer = 7000;               // These times are probably wrong
            rangeCheckTimer = 1000;

            if (instance->GetBossState(DATA_GOLEMAGG) == DONE)
            {
                DoCastSelf(SPELL_CORE_RAGER_QUIET_SUICIDE, true);
            }
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
        {
            // Just in case if something will go bad, let players to kill this creature
            if (instance->GetBossState(DATA_GOLEMAGG) == DONE)
            {
                return;
            }

            if (me->HealthBelowPctDamaged(50, damage))
            {
                damage = 0;
                DoCastSelf(SPELL_FULL_HEAL, true);
                Talk(EMOTE_LOWHP);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            // Should have no impact from unit state
            if (rangeCheckTimer <= diff)
            {
                Creature const* golemagg = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_GOLEMAGG));
                if (golemagg && me->GetDistance(golemagg) > 100.0f)
                {
                    instance->DoAction(ACTION_RESET_GOLEMAGG_ENCOUNTER);
                    return;
                }

                rangeCheckTimer = 1000;
            }
            else
            {
                rangeCheckTimer -= diff;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            // Mangle
            if (mangleTimer <= diff)
            {
                DoCastVictim(SPELL_MANGLE);
                mangleTimer = 10000;
            }
            else
            {
                mangleTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* instance;
        uint32 mangleTimer;
        uint32 rangeCheckTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetMoltenCoreAI<npc_core_ragerAI>(creature);
    }
};

void AddSC_boss_golemagg()
{
    new boss_golemagg();
    new npc_core_rager();
}
