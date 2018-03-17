/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Hinterlands
SD%Complete: 100
SDComment: Quest support: 863, 2742
SDCategory: The Hinterlands
EndScriptData */

/* ContentData
npc_oox09hl
npc_rinji
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

/*######
## npc_oox09hl
######*/

enum OOX
{
    SAY_OOX_START           = 0,
    SAY_OOX_AGGRO           = 1,
    SAY_OOX_AMBUSH          = 2,
    SAY_OOX_AMBUSH_REPLY    = 3,
    SAY_OOX_END             = 4,
    QUEST_RESQUE_OOX_09     = 836,
    NPC_MARAUDING_OWL       = 7808,
    NPC_VILE_AMBUSHER       = 7809,
    FACTION_ESCORTEE_A      = 774,
    FACTION_ESCORTEE_H      = 775
};

class npc_oox09hl : public CreatureScript
{
public:
    npc_oox09hl() : CreatureScript("npc_oox09hl") { }

    struct npc_oox09hlAI : public npc_escortAI
    {
        npc_oox09hlAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() { }

        void EnterCombat(Unit* who)
        {
            if (who->GetEntry() == NPC_MARAUDING_OWL || who->GetEntry() == NPC_VILE_AMBUSHER)
                return;

            Talk(SAY_OOX_AGGRO);
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
        }

        void sQuestAccept(Player* player, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_RESQUE_OOX_09)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->setFaction(player->GetTeamId() == TEAM_ALLIANCE ? FACTION_ESCORTEE_A : FACTION_ESCORTEE_H);
                Talk(SAY_OOX_START, player);
                npc_escortAI::Start(false, false, player->GetGUID(), quest);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 26:
                    Talk(SAY_OOX_AMBUSH);
                    break;
                case 43:
                    Talk(SAY_OOX_AMBUSH);
                    break;
                case 64:
                    Talk(SAY_OOX_END);
                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_RESQUE_OOX_09, me);
                    break;
            }
        }

        void WaypointStart(uint32 pointId)
        {
            switch (pointId)
            {
                case 27:
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        const Position src = {147.927444f, -3851.513428f, 130.893f, 0};
                        Position dst;
                        me->GetRandomPoint(src, 7.0f, dst);
                        DoSummon(NPC_MARAUDING_OWL, dst, 25000, TEMPSUMMON_CORPSE_TIMED_DESPAWN);
                    }
                    break;
                case 44:
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        const Position src = {-141.151581f, -4291.213867f, 120.130f, 0};
                        Position dst;
                        me->GetRandomPoint(src, 7.0f, dst);
                        me->SummonCreature(NPC_VILE_AMBUSHER, dst, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 25000);
                    }
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_oox09hlAI(creature);
    }
};

/*######
## npc_rinji
######*/

enum Rinji
{
    SAY_RIN_BY_OUTRUNNER    = 0,
    SAY_RIN_FREE            = 0, // from here
    SAY_RIN_HELP            = 1,
    SAY_RIN_COMPLETE        = 2,
    SAY_RIN_PROGRESS_1      = 3,
    SAY_RIN_PROGRESS_2      = 4,
    QUEST_RINJI_TRAPPED     = 2742,
    NPC_RANGER              = 2694,
    NPC_OUTRUNNER           = 2691,
    GO_RINJI_CAGE           = 142036
};

struct Location
{
    float posX, posY, posZ;
};

Location AmbushSpawn[] =
{
    { 191.296204f, -2839.329346f, 107.388f },
    { 70.972466f,  -2848.674805f, 109.459f }
};

Location AmbushMoveTo[] =
{
    { 166.630386f, -2824.780273f, 108.153f },
    { 70.886589f,  -2874.335449f, 116.675f }
};

class npc_rinji : public CreatureScript
{
public:
    npc_rinji() : CreatureScript("npc_rinji") { }

    struct npc_rinjiAI : public npc_escortAI
    {
        npc_rinjiAI(Creature* creature) : npc_escortAI(creature)
        {
            _IsByOutrunner = false;
            spawnId = 0;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
        }

        void Reset()
        {
            postEventCount = 0;
            postEventTimer = 3000;
        }

        void JustRespawned()
        {
            _IsByOutrunner = false;
            spawnId = 0;

            npc_escortAI::JustRespawned();
        }

        void EnterCombat(Unit* who)
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (who->GetEntry() == NPC_OUTRUNNER && !_IsByOutrunner)
                {
                    if (Creature* talker = who->ToCreature())
                        talker->AI()->Talk(SAY_RIN_BY_OUTRUNNER);
                    _IsByOutrunner = true;
                }

                if (rand()%4)
                    return;

                //only if attacked and escorter is not in combat?
                Talk(SAY_RIN_HELP);
            }
        }

        void DoSpawnAmbush(bool _first)
        {
            if (!_first)
                spawnId = 1;

            me->SummonCreature(NPC_RANGER, AmbushSpawn[spawnId].posX, AmbushSpawn[spawnId].posY, AmbushSpawn[spawnId].posZ, 0.0f,
                TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);

            for (int i = 0; i < 2; ++i)
            {
                me->SummonCreature(NPC_OUTRUNNER, AmbushSpawn[spawnId].posX, AmbushSpawn[spawnId].posY, AmbushSpawn[spawnId].posZ, 0.0f,
                    TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);
            }
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->SetWalk(false);
            summoned->GetMotionMaster()->MovePoint(0, AmbushMoveTo[spawnId].posX, AmbushMoveTo[spawnId].posY, AmbushMoveTo[spawnId].posZ);
        }

        void sQuestAccept(Player* player, Quest const* quest)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            if (quest->GetQuestId() == QUEST_RINJI_TRAPPED)
            {
                if (GameObject* go = me->FindNearestGameObject(GO_RINJI_CAGE, INTERACTION_DISTANCE))
                    go->UseDoorOrButton();

                npc_escortAI::Start(false, false, player->GetGUID(), quest);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    Talk(SAY_RIN_FREE, player);
                    break;
                case 7:
                    DoSpawnAmbush(true);
                    break;
                case 13:
                    DoSpawnAmbush(false);
                    break;
                case 17:
                    Talk(SAY_RIN_COMPLETE, player);
                    player->GroupEventHappens(QUEST_RINJI_TRAPPED, me);
                    SetRun();
                    postEventCount = 1;
                    break;
            }
        }

        void UpdateEscortAI(uint32 diff)
        {
            //Check if we have a current target
            if (!UpdateVictim())
            {
                if (HasEscortState(STATE_ESCORT_ESCORTING) && postEventCount)
                {
                    if (postEventTimer <= diff)
                    {
                        postEventTimer = 3000;

                        if (Player* player = GetPlayerForEscort())
                        {
                            switch (postEventCount)
                            {
                                case 1:
                                    Talk(SAY_RIN_PROGRESS_1, player);
                                    ++postEventCount;
                                    break;
                                case 2:
                                    Talk(SAY_RIN_PROGRESS_2, player);
                                    postEventCount = 0;
                                    break;
                            }
                        }
                        else
                        {
                            me->DespawnOrUnsummon();
                            return;
                        }
                    }
                    else
                        postEventTimer -= diff;
                }
                return;
            }
            DoMeleeAttackIfReady();
        }

    private:
        uint32 postEventCount;
        uint32 postEventTimer;
        int    spawnId;
        bool   _IsByOutrunner;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_rinjiAI(creature);
    }
};

void AddSC_hinterlands()
{
    new npc_oox09hl();
    new npc_rinji();
}
