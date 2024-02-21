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
SDName: Western_Plaguelands
SD%Complete: 90
SDComment: Quest support: 5097, 5098, 5216, 5219, 5222, 5225, 5229, 5231, 5233, 5235. To obtain Vitreous Focuser (could use more spesifics about gossip items)
SDCategory: Western Plaguelands
EndScriptData */

/* ContentData
npc_the_scourge_cauldron
npc_andorhal_tower
EndContentData */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"

/*######
## npc_the_scourge_cauldron
######*/

enum CreatureIds
{
    NPC_CAULDRON_LORD_BILEMAW     = 11075,
    NPC_CAULDRON_LORD_RAZARCH     = 11076,
    NPC_CAULDRON_LORD_MALVINIOUS  = 11077,
    NPC_CAULDRON_LORD_SOULWRATH   = 11078
};

enum AreaIds
{
    AREA_FELSTONE_FIELD           = 199,
    AREA_DALSON_TEARS             = 200,
    AREA_GAHRRON_WITHER           = 201,
    AREA_WRITH_HAUNT              = 202
};

class npc_the_scourge_cauldron : public CreatureScript
{
public:
    npc_the_scourge_cauldron() : CreatureScript("npc_the_scourge_cauldron") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_the_scourge_cauldronAI(creature);
    }

    struct npc_the_scourge_cauldronAI : public ScriptedAI
    {
        npc_the_scourge_cauldronAI(Creature* creature) : ScriptedAI(creature) {}

        ObjectGuid bilemawGUID;
        ObjectGuid malvinousGUID;
        ObjectGuid soulwrathGUID;
        ObjectGuid razrchGUID;

        
        void Reset() override {}

        void JustEngagedWith(Unit* /*who*/) override {}
        
        void DoDie()
        {
            //summoner dies here
            Unit::DealDamage(me, me, me->GetHealth(), nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);
            //override any database `spawntimesecs` to prevent duplicated summons
            uint32 rTime = me->GetRespawnDelay();
            if (rTime < 600)
                me->SetRespawnDelay(600);
        }

        void SummonedCreatureDies(Creature* /*summon*/, Unit* /*killer*/) override
        {
            DoDie();
        }        

        void MoveInLineOfSight(Unit* who) override
        {
            if (!who||!who->IsPlayer())
                return;

            Player* player = who->ToPlayer();
            if (!player)
                return;

            switch (me->GetAreaId())
            {
                case AREA_FELSTONE_FIELD:                                   //felstone
                    if (player->GetQuestStatus(5216) != QUEST_STATUS_INCOMPLETE &&
                        player->GetQuestStatus(5229) != QUEST_STATUS_INCOMPLETE)
                        break;

                        //A creature is summoned if not already present
                    if (ObjectAccessor::GetCreature(*me, bilemawGUID))
                        break;

                    if (Creature* bilemaw = me->SummonCreature(NPC_CAULDRON_LORD_BILEMAW, 1728.6443f, -1174.7982f, 59.05936f, 2.356194496154785156f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000))
                    {
                        bilemawGUID = bilemaw->GetGUID();                        
                    }

                    break;
                case AREA_DALSON_TEARS:                                   //dalson
                    if (player->GetQuestStatus(5219) != QUEST_STATUS_INCOMPLETE &&
                        player->GetQuestStatus(5231) != QUEST_STATUS_INCOMPLETE)
                        break;

                        //A creature is summoned if not already present
                    if (ObjectAccessor::GetCreature(*me, malvinousGUID))
                        break;

                    if (Creature* malvinous = me->SummonCreature(NPC_CAULDRON_LORD_MALVINIOUS, 1865.0482f, -1569.235f, 58.944912f, 3.176499128341674804f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000))
                    {
                        malvinousGUID = malvinous->GetGUID();
                    }

                    break;
                case AREA_GAHRRON_WITHER:                                   //gahrron
                    if (player->GetQuestStatus(5225) != QUEST_STATUS_INCOMPLETE &&
                        player->GetQuestStatus(5235) != QUEST_STATUS_INCOMPLETE)
                        break;

                        //A creature is summoned if not already present
                    if (ObjectAccessor::GetCreature(*me, soulwrathGUID))
                        break;

                    if (Creature* soulwrath = me->SummonCreature(NPC_CAULDRON_LORD_SOULWRATH, 1678.6357f, -2278.093f, 58.927708f, 3.543018341064453125f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000))
                    {
                        soulwrathGUID = soulwrath->GetGUID();
                    }

                    break;
                case AREA_WRITH_HAUNT:                                   //writhing
                    if (player->GetQuestStatus(5222) != QUEST_STATUS_INCOMPLETE &&
                        player->GetQuestStatus(5233) != QUEST_STATUS_INCOMPLETE)
                        break;

                        //A creature is summoned if not already present
                    if (ObjectAccessor::GetCreature(*me, razrchGUID))
                        break;

                    if (Creature* razrch = me->SummonCreature(NPC_CAULDRON_LORD_RAZARCH, 1473.2244f, -1863.1766f, 58.43403f, 1.821926474571228027f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 600000))
                    {
                        razrchGUID = razrch->GetGUID();
                    }

                    break;
                default:
                    break;
            }
        }
    };
};

/*######
##    npcs_andorhal_tower
######*/

enum AndorhalTower
{
    GO_BEACON_TORCH                             = 176093
};

class npc_andorhal_tower : public CreatureScript
{
public:
    npc_andorhal_tower() : CreatureScript("npc_andorhal_tower") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_andorhal_towerAI(creature);
    }

    struct npc_andorhal_towerAI : public ScriptedAI
    {
        npc_andorhal_towerAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
        }

        void MoveInLineOfSight(Unit* who) override

        {
            if (!who || who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (me->FindNearestGameObject(GO_BEACON_TORCH, 10.0f))
                if (Player* player = who->ToPlayer())
                    player->KilledMonsterCredit(me->GetEntry(), me->GetGUID());
        }
    };
};

/*######
##
######*/

void AddSC_western_plaguelands()
{
    new npc_the_scourge_cauldron();
    new npc_andorhal_tower();
}
