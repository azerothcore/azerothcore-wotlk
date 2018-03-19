/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* Script Data Start
SDName: Redridge Mountains
SD%Complete: 100%
SDComment: Support for quest 219.
Script Data End */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"

enum CorporalKeeshan
{
    QUEST_MISSING_IN_ACTION = 219,
    SAY_CORPORAL_1          = 0,
    SAY_CORPORAL_2          = 1,
    SAY_CORPORAL_3          = 2,
    SAY_CORPORAL_4          = 3,
    SAY_CORPORAL_5          = 4,
    SPELL_MOCKING_BLOW      = 21008,
    SPELL_SHIELD_BASH       = 11972
};

class npc_corporal_keeshan : public CreatureScript
{
public:
    npc_corporal_keeshan() : CreatureScript("npc_corporal_keeshan") { }

    struct npc_corporal_keeshanAI : public npc_escortAI
    {
        npc_corporal_keeshanAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset()
        {
            timer = 0;
            phase = 0;
            mockingBlowTimer = 5000;
            shieldBashTimer  = 8000;
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
        }

        void sQuestAccept(Player* player, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_MISSING_IN_ACTION)
            {
                Talk(SAY_CORPORAL_1, player);
                npc_escortAI::Start(true, false, player->GetGUID(), quest);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                me->setFaction(250);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            if (waypointId >= 65)
                me->SetWalk(false);

            switch (waypointId)
            {
                case 39:
                    SetEscortPaused(true);
                    timer = 2000;
                    phase = 1;
                    break;
                case 65:
                    me->SetWalk(false);
                    break;
                case 115:
                    player->GroupEventHappens(QUEST_MISSING_IN_ACTION, me);
                    timer = 2000;
                    phase = 4;
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (HasEscortState(STATE_ESCORT_NONE))
                return;

            npc_escortAI::UpdateAI(diff);

            if (phase)
            {
                if (timer <= diff)
                {
                    switch (phase)
                    {
                        case 1:
                            me->SetStandState(UNIT_STAND_STATE_SIT);
                            timer = 1000;
                            phase = 2;
                            break;
                        case 2:
                            Talk(SAY_CORPORAL_2);
                            timer = 15000;
                            phase = 3;
                            break;
                        case 3:
                            Talk(SAY_CORPORAL_3);
                            me->SetStandState(UNIT_STAND_STATE_STAND);
                            SetEscortPaused(false);
                            timer = 0;
                            phase = 0;
                            break;
                        case 4:
                            Talk(SAY_CORPORAL_4);
                            timer = 2500;
                            phase = 5;
                            break;
                        case 5:
                            Talk(SAY_CORPORAL_5);
                            timer = 0;
                            phase = 0;
                            break;
                    }
                } else timer -= diff;
            }

            if (!UpdateVictim())
                return;

            if (mockingBlowTimer <= diff)
            {
                DoCastVictim(SPELL_MOCKING_BLOW);
                mockingBlowTimer = 5000;
            } else mockingBlowTimer -= diff;

            if (shieldBashTimer <= diff)
            {
                DoCastVictim(SPELL_MOCKING_BLOW);
                shieldBashTimer = 8000;
            } else shieldBashTimer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 phase;
        uint32 timer;
        uint32 mockingBlowTimer;
        uint32 shieldBashTimer;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_corporal_keeshanAI(creature);
    }
};

void AddSC_redridge_mountains()
{
    new npc_corporal_keeshan();
}
