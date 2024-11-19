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

/* ScriptData
SDName: Ashenvale
SD%Complete: 70
SDComment: Quest support: 6544, 6482
SDCategory: Ashenvale Forest
EndScriptData */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"

enum Muglash
{
    SAY_MUG_START1          = 0,
    SAY_MUG_START2          = 1,
    SAY_MUG_BRAZIER         = 2,
    SAY_MUG_BRAZIER_WAIT    = 3,
    SAY_MUG_ON_GUARD        = 4,
    SAY_MUG_REST            = 5,
    SAY_MUG_DONE            = 6,
    SAY_MUG_GRATITUDE       = 7,
    SAY_MUG_PATROL          = 8,
    SAY_MUG_RETURN          = 9,

    QUEST_VORSHA            = 6641,

    GO_NAGA_BRAZIER         = 178247,

    NPC_WRATH_RIDER         = 3713,
    NPC_WRATH_SORCERESS     = 3717,
    NPC_WRATH_RAZORTAIL     = 3712,

    NPC_WRATH_PRIESTESS     = 3944,
    NPC_WRATH_MYRMIDON      = 3711,
    NPC_WRATH_SEAWITCH      = 3715,

    NPC_VORSHA              = 12940,
    NPC_MUGLASH             = 12717,

    ACTION_EXTINGUISH_BLAZIER = 0
};

Position const FirstNagaCoord[3] =
{
    { 3603.504150f, 1122.631104f,  1.635f, 0.0f },        // rider
    { 3589.293945f, 1148.664063f,  5.565f, 0.0f },        // sorceress
    { 3609.925537f, 1168.759521f, -1.168f, 0.0f }         // razortail
};

Position const SecondNagaCoord[3] =
{
    { 3609.925537f, 1168.759521f, -1.168f, 0.0f },        // witch
    { 3645.652100f, 1139.425415f, 1.322f,  0.0f },        // priest
    { 3583.602051f, 1128.405762f, 2.347f,  0.0f }         // myrmidon
};

Position const VorshaCoord = {3633.056885f, 1172.924072f, -5.388f, 0.0f};

class npc_muglash : public CreatureScript
{
public:
    npc_muglash() : CreatureScript("npc_muglash") { }

    struct npc_muglashAI : public npc_escortAI
    {
        npc_muglashAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override
        {
            eventTimer = 10000;
            waveId = 0;
            _isBrazierExtinguished = false;
        }

        void DoAction(int32 actionId) override
        {
            if (actionId == ACTION_EXTINGUISH_BLAZIER)
            {
                Talk(SAY_MUG_BRAZIER_WAIT);
                _isBrazierExtinguished = true;
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (Player* player = GetPlayerForEscort())
                if (HasEscortState(STATE_ESCORT_PAUSED))
                {
                    if (urand(0, 1))
                        Talk(SAY_MUG_ON_GUARD, player);
                    return;
                }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
                if (Player* player = GetPlayerForEscort())
                    player->FailQuest(QUEST_VORSHA);
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->AI()->AttackStart(me);
        }

        void sQuestAccept(Player* player, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_VORSHA)
            {
                Talk(SAY_MUG_START1);
                me->SetFaction(FACTION_ESCORTEE_N_NEUTRAL_PASSIVE);
                npc_escortAI::Start(true, false, player->GetGUID());
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (Player* player = GetPlayerForEscort())
            {
                switch (waypointId)
                {
                    case 0:
                        Talk(SAY_MUG_START2, player);
                        break;
                    case 24:
                        Talk(SAY_MUG_BRAZIER, player);

                        if (GameObject* go = GetClosestGameObjectWithEntry(me, GO_NAGA_BRAZIER, INTERACTION_DISTANCE * 2))
                        {
                            go->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                            SetEscortPaused(true);
                        }
                        break;
                    case 25:
                        Talk(SAY_MUG_GRATITUDE);
                        player->GroupEventHappens(QUEST_VORSHA, me);
                        break;
                    case 26:
                        Talk(SAY_MUG_PATROL);
                        break;
                    case 27:
                        Talk(SAY_MUG_RETURN);
                        break;
                }
            }
        }

        void DoWaveSummon()
        {
            switch (waveId)
            {
                case 1:
                    me->SummonCreature(NPC_WRATH_RIDER,     FirstNagaCoord[0], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_WRATH_SORCERESS, FirstNagaCoord[1], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_WRATH_RAZORTAIL, FirstNagaCoord[2], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    break;
                case 2:
                    me->SummonCreature(NPC_WRATH_PRIESTESS, SecondNagaCoord[0], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_WRATH_MYRMIDON,  SecondNagaCoord[1], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_WRATH_SEAWITCH,  SecondNagaCoord[2], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    break;
                case 3:
                    me->SummonCreature(NPC_VORSHA, VorshaCoord, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    break;
                case 4:
                    SetEscortPaused(false);
                    Talk(SAY_MUG_DONE);
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (!me->GetVictim())
            {
                if (HasEscortState(STATE_ESCORT_PAUSED) && _isBrazierExtinguished)
                {
                    if (eventTimer < diff)
                    {
                        ++waveId;
                        DoWaveSummon();
                        eventTimer = 10000;
                    }
                    else
                        eventTimer -= diff;
                }
                return;
            }
            DoMeleeAttackIfReady();
        }

    private:
        uint32 eventTimer;
        uint8  waveId;
        bool   _isBrazierExtinguished;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_muglashAI(creature);
    }
};

void AddSC_ashenvale()
{
    new npc_muglash();
}
