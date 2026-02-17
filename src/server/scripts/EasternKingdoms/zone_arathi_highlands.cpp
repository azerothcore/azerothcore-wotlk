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
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"

/*######
## npc_professor_phizzlethorpe
######*/

enum ProfessorPhizzlethorpe
{
    // Yells
    SAY_PROGRESS_1          = 0,
    SAY_PROGRESS_2          = 1,
    SAY_PROGRESS_3          = 2,
    EMOTE_PROGRESS_4        = 3,
    SAY_AGGRO               = 4,
    SAY_PROGRESS_5          = 5,
    SAY_PROGRESS_6          = 6,
    SAY_PROGRESS_7          = 7,
    EMOTE_PROGRESS_8        = 8,
    SAY_PROGRESS_9          = 9,
    // Quests
    QUEST_SUNKEN_TREASURE   = 665,
    // Creatures
    NPC_VENGEFUL_SURGE      = 2776
};

class npc_professor_phizzlethorpe : public CreatureScript
{
public:
    npc_professor_phizzlethorpe() : CreatureScript("npc_professor_phizzlethorpe") { }

    struct npc_professor_phizzlethorpeAI : public npc_escortAI
    {
        npc_professor_phizzlethorpeAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 4:
                    Talk(SAY_PROGRESS_2, player);
                    break;
                case 5:
                    Talk(SAY_PROGRESS_3, player);
                    break;
                case 8:
                    Talk(EMOTE_PROGRESS_4);
                    break;
                case 9:
                    me->SummonCreature(NPC_VENGEFUL_SURGE, -2052.96f, -2142.49f, 20.15f, 1.0f, TEMPSUMMON_CORPSE_DESPAWN, 0);
                    me->SummonCreature(NPC_VENGEFUL_SURGE, -2052.96f, -2142.49f, 20.15f, 1.0f, TEMPSUMMON_CORPSE_DESPAWN, 0);
                    break;
                case 10:
                    Talk(SAY_PROGRESS_5, player);
                    break;
                case 11:
                    Talk(SAY_PROGRESS_6, player);
                    me->SetWalk(false);
                    break;
                case 19:
                    Talk(SAY_PROGRESS_7, player);
                    break;
                case 20:
                    Talk(EMOTE_PROGRESS_8);
                    Talk(SAY_PROGRESS_9, player);
                    player->GroupEventHappens(QUEST_SUNKEN_TREASURE, me);
                    break;
            }
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->AI()->AttackStart(me);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
        }

        void sQuestAccept(Player* player, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_SUNKEN_TREASURE)
            {
                Talk(SAY_PROGRESS_1, player);
                me->SetWalk(true);
                Start(false, player->GetGUID(), quest);
                me->SetFaction(FACTION_ESCORTEE_N_NEUTRAL_PASSIVE);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_professor_phizzlethorpeAI(creature);
    }
};

enum Spells
{
    SPELL_FIREBALL = 34083,
    SPELL_FROSTNOVA = 38033,
    SPELL_LIGHTNING_SHIELD = 12550,
    SPELL_VISUAL_TRANSFORMATION = 24085
};

// Fire, Air, Water, earth model displayId (same as the elemental in the zone)
uint32_t elements_display[] = {2172, 5490, 5561, 9587};
class npc_prismatic_exile : public CreatureScript
{
public:
    npc_prismatic_exile() : CreatureScript("npc_prismatic_exile") {}

    struct npc_prismatic_exileAI : public ScriptedAI
    {
        uint32 changeElementTimer;
        uint32 currentElement;
        uint32 frostNovaTimer;
        bool hasLightningShield;

        npc_prismatic_exileAI(Creature* creature) : ScriptedAI(creature) {
            currentElement = 3;
            hasLightningShield = false;
            frostNovaTimer = urand(1400, 7300); // Got those values from smart_script of 2761
            changeElementTimer = urand(6 * IN_MILLISECONDS, 10 * IN_MILLISECONDS);
        }

        void InitializeAI() override
        {
            ScriptedAI::InitializeAI();

            // Get the target from Myzrael
            Unit* owner = me->GetOwner();
            if (!owner)
                return;

            Unit* target = owner->GetVictim();
            if (target)
                SetGazeOn(target);
        }

        void UpdateAI(uint32 diff) override
        {
            // Change Element
            if (changeElementTimer <= diff)
            {
                uint32 _rand = urand(1, 3);
                me->CastStop();
                me->CastSpell(me, SPELL_VISUAL_TRANSFORMATION, true);
                currentElement = (currentElement + _rand) % 4; // Change to a new element different from actual one
                me->SetDisplayId(elements_display[currentElement]);
                changeElementTimer = urand(6 * IN_MILLISECONDS, 10 * IN_MILLISECONDS);
            }
            else changeElementTimer -= diff;

            if (!me->HasUnitState(UNIT_STATE_CASTING))
            {
                // Cast spell depending on the current element
                switch (currentElement) {
                case 0: // FIRE
                    // Always cast fire ball
                    me->CastSpell(me->GetVictim(), SPELL_FIREBALL, false);
                    return;
                case 1: // AIR
                    // Can only cast lightning shield once
                    if (!hasLightningShield)
                    {
                        me->CastSpell(me, SPELL_LIGHTNING_SHIELD, false);
                        hasLightningShield = true;
                    }
                    break;
                case 2: // WATER
                    // Can only case frostnova if is in range and timer is done
                    Unit * target = me->GetVictim();
                    if (target && me->IsInRange(target, 0.0f, 10.0f) && frostNovaTimer <= diff)
                    {
                        me->CastSpell((Unit*)nullptr, SPELL_FROSTNOVA, false);
                        frostNovaTimer = urand(1400, 7300);
                    }
                    else frostNovaTimer -= diff;
                    break;
                }

                // By default, melee attack
                DoMeleeAttackIfReady();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_prismatic_exileAI(creature);
    }
};

void AddSC_arathi_highlands()
{
    new npc_prismatic_exile();
    new npc_professor_phizzlethorpe();
}
