/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Arathi Highlands
SD%Complete: 100
SDComment: Quest support: 665
SDCategory: Arathi Highlands
EndScriptData */

/* ContentData
npc_professor_phizzlethorpe
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

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
    NPC_VENGEFUL_SURGE      = 2776,
    FACTION_SUNKEN_TREASURE = 113
};

class npc_professor_phizzlethorpe : public CreatureScript
{
    public:
        npc_professor_phizzlethorpe() : CreatureScript("npc_professor_phizzlethorpe") { }

        struct npc_professor_phizzlethorpeAI : public npc_escortAI
        {
            npc_professor_phizzlethorpeAI(Creature* creature) : npc_escortAI(creature) { }

            void WaypointReached(uint32 waypointId)
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
                        SetRun();
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

            void JustSummoned(Creature* summoned)
            {
                summoned->AI()->AttackStart(me);
            }

            void EnterCombat(Unit* /*who*/)
            {
                Talk(SAY_AGGRO);
            }

            void sQuestAccept(Player* player, Quest const* quest)
            {
                if (quest->GetQuestId() == QUEST_SUNKEN_TREASURE)
                {
                    Talk(SAY_PROGRESS_1, player);
                    npc_escortAI::Start(false, false, player->GetGUID(), quest);
                    me->setFaction(FACTION_SUNKEN_TREASURE);
                }
            }

            void UpdateAI(uint32 diff)
            {
                npc_escortAI::UpdateAI(diff);
            }
        };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_professor_phizzlethorpeAI(creature);
    }
};

void AddSC_arathi_highlands()
{
    new npc_professor_phizzlethorpe();
}
