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

void AddSC_arathi_highlands()
{
    new npc_professor_phizzlethorpe();
}
