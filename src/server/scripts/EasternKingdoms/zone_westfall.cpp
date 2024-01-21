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
SDName: Westfall
SD%Complete: 90
SDComment: Quest support: 155
SDCategory: Westfall
EndScriptData */

/* ContentData
npc_daphne_stilwell
EndContentData */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"

/*######
## npc_daphne_stilwell
######*/

enum DaphneStilwell
{
    // Yells
    SAY_DS_START        = 0,
    SAY_DS_DOWN_1       = 1,
    SAY_DS_DOWN_2       = 2,
    SAY_DS_DOWN_3       = 3,
    SAY_DS_PROLOGUE     = 4,

    // Spells
    SPELL_SHOOT         = 6660,

    // Quests
    QUEST_TOME_VALOR    = 1651,

    // Creatures
    NPC_DEFIAS_RAIDER   = 6180,

    // Equips
    EQUIP_ID_RIFLE      = 2511
};

class npc_daphne_stilwell : public CreatureScript
{
public:
    npc_daphne_stilwell() : CreatureScript("npc_daphne_stilwell") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_TOME_VALOR)
        {
            creature->AI()->Talk(SAY_DS_START);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_daphne_stilwell::npc_daphne_stilwellAI, creature->AI()))
                pEscortAI->Start(true, true, player->GetGUID());
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_daphne_stilwellAI(creature);
    }

    struct npc_daphne_stilwellAI : public npc_escortAI
    {
        npc_daphne_stilwellAI(Creature* creature) : npc_escortAI(creature), summons(me) { }

        SummonList summons;
        uint8 textCounter;

        void Reset() override
        {
            summons.DespawnAll();
            textCounter = SAY_DS_DOWN_1;
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();

            if (!player)
                return;

            switch (waypointId)
            {
                case 4:
                    SetEquipmentSlots(false, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE, EQUIP_ID_RIFLE);
                    me->SetSheath(SHEATH_STATE_RANGED);
                    me->HandleEmoteCommand(EMOTE_STATE_USE_STANDING_NO_SHEATHE);
                    break;
                case 7:
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11435.52f, 1601.26f, 68.06f, 4.1f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11440.96f, 1599.69f, 66.35f, 4.09f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11433.44f, 1594.24f, 66.99f, 4.05f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    break;
                case 8:
                    me->SetSheath(SHEATH_STATE_RANGED);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11435.52f, 1601.26f, 68.06f, 4.1f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11440.96f, 1599.69f, 66.35f, 4.09f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11433.44f, 1594.24f, 66.99f, 4.05f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11428.29f, 1598.37f, 70.90f, 3.9f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    break;
                case 9:
                    me->SetSheath(SHEATH_STATE_RANGED);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11435.52f, 1601.26f, 68.06f, 4.1f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11440.96f, 1599.69f, 66.35f, 4.09f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11433.44f, 1594.24f, 66.99f, 4.05f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11428.29f, 1598.37f, 70.90f, 3.9f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->SummonCreature(NPC_DEFIAS_RAIDER, -11438.14f, 1607.6f, 70.94f, 4.38f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    break;
                case 10:
                    SetRun(false);
                    break;
                case 11:
                    Talk(SAY_DS_PROLOGUE);
                    break;
                case 13:
                    SetEquipmentSlots(true);
                    me->SetSheath(SHEATH_STATE_UNARMED);
                    me->HandleEmoteCommand(EMOTE_STATE_USE_STANDING_NO_SHEATHE);
                    break;
                case 17:
                    SetEscortPaused(true);
                    player->GroupEventHappens(QUEST_TOME_VALOR, me);
                    me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                    me->DespawnOrUnsummon(1s, 1s);
                    break;
            }
        }

        void AttackStart(Unit* who) override
        {
            if (me->Attack(who, false))
            {
                me->SetInCombatWith(who);
                who->SetInCombatWith(me);
            }
        }

        void JustSummoned(Creature* creature) override
        {
            creature->SetHomePosition(me->GetHomePosition());
            creature->GetMotionMaster()->MoveChase(me);
            creature->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            creature->AI()->AttackStart(me);
            creature->AddThreat(me, 0.0f);
            summons.Summon(creature);
        }

        void SummonedCreatureDies(Creature* creature, Unit*) override
        {
            summons.Despawn(creature);
            if (summons.empty())
                Talk(textCounter++, GetPlayerForEscort());
        }

        void Update(const uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            if (me->isAttackReady(BASE_ATTACK))
            {
                if (!me->IsWithinDist(me->GetVictim(), ATTACK_DISTANCE))
                    DoCastVictim(SPELL_SHOOT, true);
                else
                {
                    me->SetSheath(SHEATH_STATE_MELEE);
                    me->AttackerStateUpdate(me->GetVictim());
                }

                me->resetAttackTimer();
            }
        }
    };
};

void AddSC_westfall()
{
    new npc_daphne_stilwell();
}
