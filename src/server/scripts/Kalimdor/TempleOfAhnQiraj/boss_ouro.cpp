/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Boss_Ouro
SD%Complete: 85
SDComment: No model for submerging. Currently just invisible.
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_SWEEP                 = 26103,
    SPELL_SANDBLAST             = 26102,
    SPELL_GROUND_RUPTURE        = 26100,
    SPELL_BIRTH                 = 26262, // The Birth Animation
    SPELL_DIRTMOUND_PASSIVE     = 26092,
    SPELL_SUMMON_OURO           = 26061
};

class npc_ouro_spawner : public CreatureScript
{
public:
    npc_ouro_spawner() : CreatureScript("npc_ouro_spawner") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ouro_spawnerAI(creature);
    }

    struct npc_ouro_spawnerAI : public ScriptedAI
    {
        npc_ouro_spawnerAI(Creature* creature) : ScriptedAI(creature)
        {
            Reset();
        }

        bool hasSummoned;

        void Reset() override
        {
            hasSummoned = false;
            DoCast(me, SPELL_DIRTMOUND_PASSIVE);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            // Spawn Ouro on LoS check
            if (!hasSummoned && who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 40.0f))
            {
                DoCast(me, SPELL_SUMMON_OURO);
                hasSummoned = true;
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustSummoned(Creature* creature) override
        {
            // Despawn when Ouro is spawned
            if (creature->GetEntry() == NPC_OURO)
            {
                creature->SetInCombatWithZone();
                creature->CastSpell(creature, SPELL_BIRTH, false);
                me->DespawnOrUnsummon();
            }
        }

    };
};

class boss_ouro : public CreatureScript
{
public:
    boss_ouro() : CreatureScript("boss_ouro") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTempleOfAhnQirajAI<boss_ouroAI>(creature);
    }

    struct boss_ouroAI : public ScriptedAI
    {
        boss_ouroAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 Sweep_Timer;
        uint32 SandBlast_Timer;
        uint32 Submerge_Timer;
        uint32 Back_Timer;
        uint32 ChangeTarget_Timer;
        uint32 Spawn_Timer;

        bool Enrage;
        bool Submerged;

        void Reset() override
        {
            Sweep_Timer = urand(5000, 10000);
            SandBlast_Timer = urand(20000, 35000);
            Submerge_Timer = urand(90000, 150000);
            Back_Timer = urand(30000, 45000);
            ChangeTarget_Timer = urand(5000, 8000);
            Spawn_Timer = urand(10000, 20000);

            Enrage = false;
            Submerged = false;
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoCastVictim(SPELL_BIRTH);
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //Sweep_Timer
            if (!Submerged && Sweep_Timer <= diff)
            {
                DoCastVictim(SPELL_SWEEP);
                Sweep_Timer = urand(15000, 30000);
            }
            else Sweep_Timer -= diff;

            //SandBlast_Timer
            if (!Submerged && SandBlast_Timer <= diff)
            {
                DoCastVictim(SPELL_SANDBLAST);
                SandBlast_Timer = urand(20000, 35000);
            }
            else SandBlast_Timer -= diff;

            //Submerge_Timer
            if (!Submerged && Submerge_Timer <= diff)
            {
                //Cast
                me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetFaction(FACTION_FRIENDLY);
                DoCast(me, SPELL_DIRTMOUND_PASSIVE);

                Submerged = true;
                Back_Timer = urand(30000, 45000);
            }
            else Submerge_Timer -= diff;

            //ChangeTarget_Timer
            if (Submerged && ChangeTarget_Timer <= diff)
            {
                Unit* target = SelectTarget(SelectTargetMethod::Random, 0);

                if (target)
                    me->NearTeleportTo(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), me->GetOrientation());

                ChangeTarget_Timer = urand(10000, 20000);
            }
            else ChangeTarget_Timer -= diff;

            //Back_Timer
            if (Submerged && Back_Timer <= diff)
            {
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetFaction(FACTION_MONSTER);

                DoCastVictim(SPELL_GROUND_RUPTURE);

                Submerged = false;
                Submerge_Timer = urand(60000, 120000);
            }
            else Back_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_ouro()
{
    new npc_ouro_spawner();
    new boss_ouro();
}
