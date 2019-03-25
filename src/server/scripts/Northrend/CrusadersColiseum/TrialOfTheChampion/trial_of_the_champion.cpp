/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "trial_of_the_champion.h"
#include "Player.h"

#define GOSSIP_START_EVENT1a "I am ready."
#define GOSSIP_START_EVENT1b "I am ready. However I'd like to skip the pageantry."
#define GOSSIP_START_EVENT2  "I'm ready for the next challenge."
#define GOSSIP_START_EVENT3  "I'm ready."

class npc_announcer_toc5 : public CreatureScript
{
public:
    npc_announcer_toc5() : CreatureScript("npc_announcer_toc5") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if (!pInstance)
            return true;

        uint32 gossipTextId = 0;
        switch (pInstance->GetData(DATA_INSTANCE_PROGRESS))
        {
        case INSTANCE_PROGRESS_INITIAL:
            if (!player->GetVehicle())
            {
                if (pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE)
                    gossipTextId = 15043; //Horde text
                else
                    gossipTextId = 14757; //Alliance text
            }
            else
            {
                gossipTextId = 14688;
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_START_EVENT1a, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1338);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_START_EVENT1b, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1341);
            }
            break;
        case INSTANCE_PROGRESS_CHAMPIONS_DEAD:
            gossipTextId = 14737;
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_START_EVENT2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1339);
            break;
        case INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED:
            gossipTextId = 14738;
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_START_EVENT3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1340);
            break;
        default:
            return true;
        }

        SendGossipMenuFor(player, gossipTextId, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        if(!creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* pInstance = creature->GetInstanceScript();
        if(!pInstance)
            return true;

        if(uiAction == GOSSIP_ACTION_INFO_DEF+1338 || uiAction == GOSSIP_ACTION_INFO_DEF+1341 || uiAction == GOSSIP_ACTION_INFO_DEF+1339 || uiAction == GOSSIP_ACTION_INFO_DEF+1340)
        {
            pInstance->SetData(DATA_ANNOUNCER_GOSSIP_SELECT, (uiAction == GOSSIP_ACTION_INFO_DEF+1341 ? 1 : 0));
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        CloseGossipMenuFor(player);
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_announcer_toc5AI(creature);
    }

    struct npc_announcer_toc5AI : public CreatureAI
    {
        npc_announcer_toc5AI(Creature *creature) : CreatureAI(creature) {}

        void Reset() override
        {
            InstanceScript* pInstance = me->GetInstanceScript();
            if( !pInstance )
                return;
            if( pInstance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE )
                me->UpdateEntry(NPC_ARELAS);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE); // removed during black knight scene
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth()) // for bk scene so strangulate doesn't kill him
                damage = me->GetHealth()-1;
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            if (type != EFFECT_MOTION_TYPE)
                return;
            InstanceScript* pInstance = me->GetInstanceScript();
            if( !pInstance )
                return;
            if (pInstance->GetData(DATA_INSTANCE_PROGRESS) < INSTANCE_PROGRESS_ARGENT_CHALLENGE_DIED)
                return;

            Unit::Kill(me, me); // for bk scene, die after knockback
        }

        void UpdateAI(uint32 /*diff*/) override { }
    };
};

void AddSC_trial_of_the_champion()
{
    new npc_announcer_toc5();
}
