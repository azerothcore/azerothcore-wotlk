/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "halls_of_reflection.h"
#include "MotionMaster.h"

enum Events
{
    EVENT_NONE,

    EVENT_PRE_INTRO_1,
    EVENT_PRE_INTRO_2,
    EVENT_PRE_INTRO_3,

    EVENT_START_INTRO,
    EVENT_SKIP_INTRO,

    EVENT_INTRO_A2_1,
    EVENT_INTRO_A2_2,
    EVENT_INTRO_A2_3,
    EVENT_INTRO_A2_4,
    EVENT_INTRO_A2_5,
    EVENT_INTRO_A2_6,
    EVENT_INTRO_A2_7,
    EVENT_INTRO_A2_8,
    EVENT_INTRO_A2_9,
    EVENT_INTRO_A2_10,
    EVENT_INTRO_A2_11,
    EVENT_INTRO_A2_12,
    EVENT_INTRO_A2_13,
    EVENT_INTRO_A2_14,
    EVENT_INTRO_A2_15,
    EVENT_INTRO_A2_16,
    EVENT_INTRO_A2_17,
    EVENT_INTRO_A2_18,
    EVENT_INTRO_A2_19,

    EVENT_INTRO_H2_1,
    EVENT_INTRO_H2_2,
    EVENT_INTRO_H2_3,
    EVENT_INTRO_H2_4,
    EVENT_INTRO_H2_5,
    EVENT_INTRO_H2_6,
    EVENT_INTRO_H2_7,
    EVENT_INTRO_H2_8,
    EVENT_INTRO_H2_9,
    EVENT_INTRO_H2_10,
    EVENT_INTRO_H2_11,
    EVENT_INTRO_H2_12,
    EVENT_INTRO_H2_13,
    EVENT_INTRO_H2_14,
    EVENT_INTRO_H2_15,

    EVENT_INTRO_LK_1,
    EVENT_INTRO_LK_1_2,
    EVENT_INTRO_LK_1_3,
    EVENT_INTRO_LK_2,
    EVENT_INTRO_LK_3,
    EVENT_INTRO_LK_4,
    EVENT_INTRO_LK_4_2,
    EVENT_INTRO_LK_4_3,
    EVENT_INTRO_LK_5,
    EVENT_INTRO_LK_5_2,
    EVENT_INTRO_LK_6,
    EVENT_INTRO_LK_7,
    EVENT_INTRO_LK_8,
    EVENT_INTRO_LK_9,

    EVENT_INTRO_END,
    EVENT_INTRO_END_SET,
};

class npc_hor_leader : public CreatureScript
{
public:
    npc_hor_leader() : CreatureScript("npc_hor_leader") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
            return true;

        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        bool canStart = true;
        if (InstanceScript* instance = creature->GetInstanceScript())
            if (uint32 bhd = instance->GetData(DATA_BATTERED_HILT))
                if ((bhd & BHSF_FINISHED) == 0)
                    canStart = false;

        if (canStart)
        {
            QuestStatus status = player->GetQuestStatus(creature->GetEntry() == NPC_SYLVANAS_PART1 ? QUEST_DELIVRANCE_FROM_THE_PIT_H2 : QUEST_DELIVRANCE_FROM_THE_PIT_A2);
            if (status == QUEST_STATUS_COMPLETE || status == QUEST_STATUS_REWARDED)
                AddGossipItemFor(player, 0, "Can you remove the sword?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

            // once last quest is completed, she offers this shortcut of the starting event
            status = player->GetQuestStatus(creature->GetEntry() == NPC_SYLVANAS_PART1 ? QUEST_WRATH_OF_THE_LICH_KING_H2 : QUEST_WRATH_OF_THE_LICH_KING_A2);
            if (status == QUEST_STATUS_COMPLETE || status == QUEST_STATUS_REWARDED)
            {
                if (creature->GetEntry() == NPC_SYLVANAS_PART1)
                    AddGossipItemFor(player, 0, "Dark Lady, I think I hear Arthas coming. Whatever you're going to do, do it quickly.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                else
                    AddGossipItemFor(player, 0, "My Lady, I think I hear Arthas coming. Whatever you're going to do, do it quickly.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            }
        }

        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        if (!creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
            return true;

        InstanceScript* instance = creature->GetInstanceScript();
        if (!instance)
            return true;

        if (uint32 bhd = instance->GetData(DATA_BATTERED_HILT))
            if ((bhd & BHSF_FINISHED) == 0)
                return true;

        instance->SetData(DATA_BATTERED_HILT, 1);

        ClearGossipMenuFor(player);
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                CloseGossipMenuFor(player);
                if (creature->AI())
                    creature->AI()->DoAction(ACTION_START_INTRO);
                creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                CloseGossipMenuFor(player);
                if (creature->AI())
                    creature->AI()->DoAction(ACTION_SKIP_INTRO);
                creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                break;
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_hor_leaderAI(creature);
    }

    struct npc_hor_leaderAI : public NullCreatureAI
    {
        npc_hor_leaderAI(Creature* creature) : NullCreatureAI(creature)
        {
            pInstance = me->GetInstanceScript();
            if (!pInstance)
                me->IsAIEnabled = false;
            first = (pInstance && !pInstance->GetData(DATA_INTRO));
        }

        InstanceScript* pInstance;
        EventMap events;
        bool first;
        bool shortver;

        void Reset() override
        {
            shortver = false;
            events.Reset();
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            if (first)
            {
                first = false;
                events.ScheduleEvent(EVENT_PRE_INTRO_1, 10000);
                events.ScheduleEvent(EVENT_PRE_INTRO_2, 11000);
                events.ScheduleEvent(EVENT_PRE_INTRO_3, 17000);
            }
        }

        void DoAction(int32 actionId) override
        {
            switch(actionId)
            {
                case ACTION_START_INTRO:
                    events.ScheduleEvent(EVENT_START_INTRO, 0);
                    break;
                case ACTION_SKIP_INTRO:
                    events.ScheduleEvent(EVENT_SKIP_INTRO, 0);
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch(events.ExecuteEvent())
            {
                case EVENT_PRE_INTRO_1:
                    if (pInstance)
                    {
                        me->SetVisible(true);
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_DARK_RANGER_LORALEN)))
                            c->SetVisible(true);
                    }
                    break;
                case EVENT_PRE_INTRO_2:
                    if (me->GetEntry() == NPC_JAINA_PART1)
                        Talk(SAY_JAINA_INTRO_1);
                    me->GetMotionMaster()->MovePoint(0, SpawnPos);
                    break;
                case EVENT_PRE_INTRO_3:
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                    Talk(me->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_INTRO_2 : SAY_SYLVANAS_INTRO_1);
                    me->SetFacingTo(0.89f);
                    break;

                case EVENT_START_INTRO:
                    shortver = false;
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                    me->GetMotionMaster()->MovePoint(0, MoveThronePos);
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_DARK_RANGER_LORALEN)))
                        c->GetMotionMaster()->MovePoint(0, LoralenFollowPos);
                    // Begining of intro is differents between factions as the speech sequence and timers are differents.
                    if (me->GetEntry() == NPC_JAINA_PART1)
                        events.ScheduleEvent(EVENT_INTRO_A2_1, 10000);
                    else
                        events.ScheduleEvent(EVENT_INTRO_H2_2, 10000);
                    break;
                case EVENT_SKIP_INTRO:
                    shortver = true;
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, (me->GetEntry() == NPC_JAINA_PART1 ? EMOTE_STATE_READY2H : EMOTE_STATE_READY1H));
                    me->GetMotionMaster()->MovePoint(0, MoveThronePos);
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_DARK_RANGER_LORALEN)))
                        c->GetMotionMaster()->MovePoint(0, LoralenFollowPos);
                    events.ScheduleEvent(EVENT_INTRO_LK_1, 0);
                    break;

            // A2 Intro Events
                case EVENT_INTRO_A2_1:
                    Talk(SAY_JAINA_INTRO_3);
                    events.ScheduleEvent(EVENT_INTRO_A2_2, 5000);
                    break;
                case EVENT_INTRO_A2_2:
                    Talk(SAY_JAINA_INTRO_4);
                    events.ScheduleEvent(EVENT_INTRO_A2_3, 10000);
                    break;
                case EVENT_INTRO_A2_3:
                    pInstance->HandleGameObject(pInstance->GetData64(GO_FROSTMOURNE), true);
                    me->CastSpell(me, SPELL_FROSTMOURNE_SPAWN_SOUND, true);
                    me->CastSpell(me, SPELL_ARCANE_CAST_VISUAL, false);
                    events.ScheduleEvent(EVENT_INTRO_A2_4, 10000);
                    break;
                case EVENT_INTRO_A2_4:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                    {
                        pUther->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        pUther->SetVisible(true);
                        if (Aura* a = pUther->AddAura(SPELL_SHADOWMOURNE_VISUAL, pUther))
                            a->SetDuration(8000);
                    }
                    events.ScheduleEvent(EVENT_INTRO_A2_5, 2000);
                    break;
                case EVENT_INTRO_A2_5:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_1);
                    events.ScheduleEvent(EVENT_INTRO_A2_6, 3000);
                    break;
                case EVENT_INTRO_A2_6:
                    Talk(SAY_JAINA_INTRO_5);
                    events.ScheduleEvent(EVENT_INTRO_A2_7, 6000);
                    break;
                case EVENT_INTRO_A2_7:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_2);
                    events.ScheduleEvent(EVENT_INTRO_A2_8, 6500);
                    break;
                case EVENT_INTRO_A2_8:
                    Talk(SAY_JAINA_INTRO_6);
                    events.ScheduleEvent(EVENT_INTRO_A2_9, 2000);
                    break;
                case EVENT_INTRO_A2_9:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_3);
                    events.ScheduleEvent(EVENT_INTRO_A2_10, 9000);
                    break;
                case EVENT_INTRO_A2_10:
                    Talk(SAY_JAINA_INTRO_7);
                    events.ScheduleEvent(EVENT_INTRO_A2_11, 5000);
                    break;
                case EVENT_INTRO_A2_11:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_4);
                    events.ScheduleEvent(EVENT_INTRO_A2_12, 11000);
                    break;
                case EVENT_INTRO_A2_12:
                    Talk(SAY_JAINA_INTRO_8);
                    events.ScheduleEvent(EVENT_INTRO_A2_13, 4000);
                    break;
                case EVENT_INTRO_A2_13:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_5);
                    events.ScheduleEvent(EVENT_INTRO_A2_14, 12500);
                    break;
                case EVENT_INTRO_A2_14:
                    Talk(SAY_JAINA_INTRO_9);
                    events.ScheduleEvent(EVENT_INTRO_A2_15, 10000);
                    break;
                case EVENT_INTRO_A2_15:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_6);
                    events.ScheduleEvent(EVENT_INTRO_A2_16, 24000);
                    break;
                case EVENT_INTRO_A2_16:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_7);
                    events.ScheduleEvent(EVENT_INTRO_A2_17, 4000);
                    break;
                case EVENT_INTRO_A2_17:
                    Talk(SAY_JAINA_INTRO_10);
                    events.ScheduleEvent(EVENT_INTRO_A2_18, 2000);
                    break;
                case EVENT_INTRO_A2_18:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                    {
                        pUther->HandleEmoteCommand(EMOTE_ONESHOT_NO);
                        pUther->AI()->Talk(SAY_UTHER_INTRO_A2_8);
                    }
                    events.ScheduleEvent(EVENT_INTRO_A2_19, 11000);
                    break;
                case EVENT_INTRO_A2_19:
                    Talk(SAY_JAINA_INTRO_11);
                    events.ScheduleEvent(EVENT_INTRO_LK_1, 2000);
                    break;

            // H2 Intro Events
                case EVENT_INTRO_H2_2:
                    Talk(SAY_SYLVANAS_INTRO_2);
                    events.ScheduleEvent(EVENT_INTRO_H2_3, 6000);
                    break;
                case EVENT_INTRO_H2_3:
                    Talk(SAY_SYLVANAS_INTRO_3);
                    pInstance->HandleGameObject(pInstance->GetData64(GO_FROSTMOURNE), true);
                    me->CastSpell(me, SPELL_FROSTMOURNE_SPAWN_SOUND, true);
                    me->CastSpell(me, SPELL_ARCANE_CAST_VISUAL, false);
                    events.ScheduleEvent(EVENT_INTRO_H2_4, 6000);
                    break;
                case EVENT_INTRO_H2_4:
                    if (Creature* pUther = pInstance->instance->GetCreature(pInstance->GetData64(NPC_UTHER)))
                    {
                        pUther->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        pUther->SetVisible(true);
                        if (Aura* a = pUther->AddAura(SPELL_SHADOWMOURNE_VISUAL, pUther))
                            a->SetDuration(8000);
                    }
                    events.ScheduleEvent(EVENT_INTRO_H2_5, 2000);
                    break;
                case EVENT_INTRO_H2_5:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_H2_1);
                    events.ScheduleEvent(EVENT_INTRO_H2_6, 11000);
                    break;
                case EVENT_INTRO_H2_6:
                    Talk(SAY_SYLVANAS_INTRO_4);
                    events.ScheduleEvent(EVENT_INTRO_H2_7, 3000);
                    break;
                case EVENT_INTRO_H2_7:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_H2_2);
                    events.ScheduleEvent(EVENT_INTRO_H2_8, 6000);
                    break;
                case EVENT_INTRO_H2_8:
                    Talk(SAY_SYLVANAS_INTRO_5);
                    events.ScheduleEvent(EVENT_INTRO_H2_9, 5000);
                    break;
                case EVENT_INTRO_H2_9:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_H2_3);
                    events.ScheduleEvent(EVENT_INTRO_H2_10, 19000);
                    break;
                case EVENT_INTRO_H2_10:
                    Talk(SAY_SYLVANAS_INTRO_6);
                    events.ScheduleEvent(EVENT_INTRO_H2_11, 1500);
                    break;
                case EVENT_INTRO_H2_11:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_H2_4);
                    events.ScheduleEvent(EVENT_INTRO_H2_12, 19500);
                    break;
                case EVENT_INTRO_H2_12:
                    Talk(SAY_SYLVANAS_INTRO_7);
                    events.ScheduleEvent(EVENT_INTRO_H2_13, 2000);
                    break;
                case EVENT_INTRO_H2_13:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                    {
                        pUther->HandleEmoteCommand(EMOTE_ONESHOT_NO);
                        pUther->AI()->Talk(SAY_UTHER_INTRO_H2_5);
                    }
                    events.ScheduleEvent(EVENT_INTRO_H2_14, 12000);
                    break;
                case EVENT_INTRO_H2_14:
                    if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        pUther->AI()->Talk(SAY_UTHER_INTRO_H2_6);
                    events.ScheduleEvent(EVENT_INTRO_H2_15, 8000);
                    break;
                case EVENT_INTRO_H2_15:
                    Talk(SAY_SYLVANAS_INTRO_8);
                    events.ScheduleEvent(EVENT_INTRO_LK_1, 2000);
                    break;

            // Remaining Intro Events common for both faction
                case EVENT_INTRO_LK_1:
                    if (Creature* pLichKing = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_EVENT)))
                    {
                        pInstance->HandleGameObject(pInstance->GetData64(GO_ARTHAS_DOOR), true);
                        pLichKing->SetVisible(true);
                        pLichKing->GetMotionMaster()->MovePoint(0, LichKingMoveThronePos, false);
                    }

                    if (!shortver)
                        if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                        {
                            if (me->GetEntry() == NPC_JAINA_PART1)
                                pUther->AI()->Talk(SAY_UTHER_INTRO_A2_9);
                            else
                                pUther->AI()->Talk(SAY_UTHER_INTRO_H2_7);
                        }

                    events.ScheduleEvent(EVENT_INTRO_LK_1_2, 2000);
                    events.ScheduleEvent(EVENT_INTRO_LK_1_3, 4000);
                    events.ScheduleEvent(EVENT_INTRO_LK_2, 11000);
                    break;

                case EVENT_INTRO_LK_1_2:
                    if (!shortver)
                        if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                            pUther->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_COWER);
                    break;

                case EVENT_INTRO_LK_1_3:
                    pInstance->HandleGameObject(pInstance->GetData64(GO_ARTHAS_DOOR), false);
                    break;

                case EVENT_INTRO_LK_2:
                    if (!shortver)
                        if (Creature* pLichKing = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_LICH_KING_EVENT)))
                            pLichKing->AI()->Talk(SAY_LK_INTRO_1);
                    events.ScheduleEvent(EVENT_INTRO_LK_3, 2000);
                    break;

                case EVENT_INTRO_LK_3:
                    if (!shortver)
                        if (Creature* pUther = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_UTHER)))
                            pUther->SetVisible(false);
                    events.ScheduleEvent(EVENT_INTRO_LK_4, 4000);
                    break;

                case EVENT_INTRO_LK_4:
                    if (Creature* pLichKing = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_LICH_KING_EVENT)))
                        pLichKing->AI()->Talk(SAY_LK_INTRO_2);
                    events.ScheduleEvent(EVENT_INTRO_LK_4_2, 10000);
                    break;

                case EVENT_INTRO_LK_4_2:
                    if (Creature* pLichKing = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_LICH_KING_EVENT)))
                    {
                        pLichKing->LoadEquipment(1, true);
                        pLichKing->SendMovementFlagUpdate();
                        pLichKing->CastSpell(pLichKing, SPELL_FROSTMOURNE_EQUIP, false);
                        pInstance->HandleGameObject(pInstance->GetData64(GO_FROSTMOURNE), false);
                        events.ScheduleEvent(EVENT_INTRO_LK_4_3, 1750);
                    }
                    events.ScheduleEvent(EVENT_INTRO_LK_5, 6000);
                    break;

                case EVENT_INTRO_LK_4_3:
                    if (GameObject* go = pInstance->instance->GetGameObject(pInstance->GetData64(GO_FROSTMOURNE)))
                        go->SetPhaseMask(2, true);
                    break;
                case EVENT_INTRO_LK_5:
                    if (Creature* pFalric = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_FALRIC)))
                    {
                        pFalric->UpdatePosition(5274.9f, 2039.2f, 709.319f, 5.4619f, true);
                        pFalric->StopMovingOnCurrentPos();
                        pFalric->SetVisible(true);
                        if (pFalric->IsAlive())
                        {
                            pFalric->GetMotionMaster()->MovePoint(0, FalricMovePos);
                            if (Aura* a = pFalric->AddAura(SPELL_SHADOWMOURNE_VISUAL, pFalric))
                                a->SetDuration(8000);
                        }
                    }
                    if (Creature* pMarwyn = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_MARWYN)))
                    {
                        pMarwyn->UpdatePosition(5343.77f, 1973.86f, 709.319f, 2.35173f, true);
                        pMarwyn->StopMovingOnCurrentPos();
                        pMarwyn->SetVisible(true);
                        if (pMarwyn->IsAlive())
                        {
                            pMarwyn->GetMotionMaster()->MovePoint(0, MarwynMovePos);
                            if (Aura* a = pMarwyn->AddAura(SPELL_SHADOWMOURNE_VISUAL, pMarwyn))
                                a->SetDuration(8000);
                        }
                    }

                    if (Creature* pLichKing = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_LICH_KING_EVENT)))
                        pLichKing->AI()->Talk(SAY_LK_INTRO_3);

                    events.ScheduleEvent(EVENT_INTRO_LK_5_2, 5000);
                    events.ScheduleEvent(EVENT_INTRO_LK_6, 8000);
                    break;

                case EVENT_INTRO_LK_5_2:
                    if (Creature* pLichKing = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_LICH_KING_EVENT)))
                        pLichKing->GetMotionMaster()->MovePoint(0, LichKingMoveAwayPos, false);
                    break;

                case EVENT_INTRO_LK_6:
                    if (Creature* pFalric = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_FALRIC)))
                        pFalric->AI()->Talk(SAY_FALRIC_INTRO_1);

                    events.ScheduleEvent(EVENT_INTRO_LK_7, 2000);
                    break;

                case EVENT_INTRO_LK_7:
                    if (Creature* pMarwyn = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_MARWYN)))
                        pMarwyn->AI()->Talk(SAY_MARWYN_INTRO_1);

                    events.ScheduleEvent(EVENT_INTRO_LK_8, 2000);
                    break;

                case EVENT_INTRO_LK_8:
                    if (Creature* pFalric = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_FALRIC)))
                        pFalric->AI()->Talk(SAY_FALRIC_INTRO_2);
                    pInstance->SetData(ACTION_SHOW_TRASH, 1);

                    pInstance->HandleGameObject(pInstance->GetData64(GO_ARTHAS_DOOR), true);

                    events.ScheduleEvent(EVENT_INTRO_LK_9, 5000);
                    break;

                case EVENT_INTRO_LK_9:
                    if (me->GetEntry() == NPC_JAINA_PART1)
                        Talk(SAY_JAINA_INTRO_END);
                    else
                        Talk(SAY_SYLVANAS_INTRO_END);

                    me->GetMotionMaster()->MovePoint(0, LichKingMoveAwayPos, false);
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_DARK_RANGER_LORALEN)))
                        c->GetMotionMaster()->MovePoint(0, LichKingMoveAwayPos, false);
                    events.ScheduleEvent(EVENT_INTRO_END, 14000);
                    break;

                case EVENT_INTRO_END:
                    pInstance->HandleGameObject(pInstance->GetData64(GO_ARTHAS_DOOR), false);
                    pInstance->HandleGameObject(pInstance->GetData64(GO_FRONT_DOOR), false);
                    events.ScheduleEvent(EVENT_INTRO_END_SET, 10000);
                    break;
                case EVENT_INTRO_END_SET:
                    if (Creature* pLichKing = ObjectAccessor::GetCreature(*me, pInstance->GetData64(NPC_LICH_KING_EVENT)))
                        pLichKing->SetVisible(false);
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_DARK_RANGER_LORALEN)))
                        c->SetVisible(false);
                    me->SetVisible(false);
                    pInstance->SetData(DATA_INTRO, DONE);
                    break;
            }
        }
    };
};

enum TrashSpells
{
    // Ghostly Priest
    SPELL_SHADOW_WORD_PAIN                        = 72318,
    SPELL_CIRCLE_OF_DESTRUCTION                   = 72320,
    SPELL_COWER_IN_FEAR                           = 72321,
    SPELL_DARK_MENDING                            = 72322,

    // Phantom Mage
    SPELL_FIREBALL                                = 72163,
    SPELL_FLAMESTRIKE                             = 72169,
    SPELL_FROSTBOLT                               = 72166,
    SPELL_CHAINS_OF_ICE                           = 72120,
    SPELL_HALLUCINATION                           = 72342,

    // Phantom Hallucination (same as phantom mage + HALLUCINATION_2 when dies)
    SPELL_HALLUCINATION_2                         = 72344,

    // Shadowy Mercenary
    SPELL_SHADOW_STEP                             = 72326,
    SPELL_DEADLY_POISON                           = 72329,
    SPELL_ENVENOMED_DAGGER_THROW                  = 72333,
    SPELL_KIDNEY_SHOT                             = 72335,

    // Spectral Footman
    SPELL_SPECTRAL_STRIKE                         = 72198,
    SPELL_SHIELD_BASH                             = 72194,
    SPELL_TORTURED_ENRAGE                         = 72203,

    // Tortured Rifleman
    SPELL_SHOOT                                   = 72208,
    SPELL_CURSED_ARROW                            = 72222,
    SPELL_FROST_TRAP                              = 72215,
    SPELL_ICE_SHOT                                = 72268,
};

enum TrashEvents
{
    EVENT_TRASH_NONE,

    // Ghostly Priest
    EVENT_SHADOW_WORD_PAIN,
    EVENT_CIRCLE_OF_DESTRUCTION,
    EVENT_COWER_IN_FEAR,
    EVENT_DARK_MENDING,

    // Phantom Mage
    EVENT_FIREBALL,
    EVENT_FLAMESTRIKE,
    EVENT_FROSTBOLT,
    EVENT_CHAINS_OF_ICE,
    EVENT_HALLUCINATION,

    // Shadowy Mercenary
    EVENT_SHADOW_STEP,
    EVENT_DEADLY_POISON,
    EVENT_ENVENOMED_DAGGER_THROW,
    EVENT_KIDNEY_SHOT,

    // Spectral Footman
    EVENT_SPECTRAL_STRIKE,
    EVENT_SHIELD_BASH,
    EVENT_TORTURED_ENRAGE,

    // Tortured Rifleman
    EVENT_SHOOT,
    EVENT_CURSED_ARROW,
    EVENT_FROST_TRAP,
    EVENT_ICE_SHOT,
};

class npc_ghostly_priest : public CreatureScript
{
public:
    npc_ghostly_priest() : CreatureScript("npc_ghostly_priest") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ghostly_priestAI(creature);
    }

    struct npc_ghostly_priestAI: public ScriptedAI
    {
        npc_ghostly_priestAI(Creature* c) : ScriptedAI(c) {}

        EventMap events;

        void DoAction(int32 a)
        {
            if (a == 1)
            {
                me->SetInCombatWithZone();
                if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0.0f, true))
                    AttackStart(target);
            }
        }

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 5000);
            events.ScheduleEvent(EVENT_CIRCLE_OF_DESTRUCTION, 8000);
            events.ScheduleEvent(EVENT_COWER_IN_FEAR, 10000);
            events.ScheduleEvent(EVENT_DARK_MENDING, 8000);
        }

        void AttackStart(Unit* who)
        {
            if (!me->IsVisible() || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;
            ScriptedAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SHADOW_WORD_PAIN:
                    if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                        me->CastSpell(target, SPELL_SHADOW_WORD_PAIN, false);
                    events.ScheduleEvent(EVENT_SHADOW_WORD_PAIN, 5000);
                    break;
                case EVENT_CIRCLE_OF_DESTRUCTION:
                    if (Unit* target = SelectTargetFromPlayerList(10.0f, 0, true))
                        me->CastSpell(target, SPELL_CIRCLE_OF_DESTRUCTION, false);
                    events.ScheduleEvent(EVENT_CIRCLE_OF_DESTRUCTION, 12000);
                    break;
                case EVENT_COWER_IN_FEAR:
                    if (Unit* target = SelectTargetFromPlayerList(20.0f, 0, true))
                        me->CastSpell(target, SPELL_COWER_IN_FEAR, false);
                    events.ScheduleEvent(EVENT_COWER_IN_FEAR, 10000);
                    break;
                case EVENT_DARK_MENDING:
                    if (Unit* target = DoSelectLowestHpFriendly(35.0f, DUNGEON_MODE(20000, 35000)))
                    {
                        me->CastSpell(target, SPELL_DARK_MENDING, false);
                        events.ScheduleEvent(EVENT_DARK_MENDING, 6000);
                    }
                    else
                        events.ScheduleEvent(EVENT_DARK_MENDING, 3000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            if (me->GetInstanceScript()->GetData(DATA_WAVE_NUMBER))
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE);
        }
    };
};

class npc_phantom_mage : public CreatureScript
{
public:
    npc_phantom_mage() : CreatureScript("npc_phantom_mage") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_phantom_mageAI(creature);
    }

    struct npc_phantom_mageAI: public ScriptedAI
    {
        npc_phantom_mageAI(Creature* c) : ScriptedAI(c) {}

        EventMap events;

        void DoAction(int32 a)
        {
            if (a == 1)
            {
                me->SetInCombatWithZone();
                if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0.0f, true))
                    AttackStart(target);
            }
        }

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_FIREBALL, 3000);
            events.ScheduleEvent(EVENT_FLAMESTRIKE, 6000);
            events.ScheduleEvent(EVENT_FROSTBOLT, 9000);
            events.ScheduleEvent(EVENT_CHAINS_OF_ICE, 12000);
            events.ScheduleEvent(EVENT_HALLUCINATION, 40000);
        }

        void AttackStart(Unit* who)
        {
            if (!me->IsVisible() || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;
            ScriptedAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_FIREBALL:
                    me->CastSpell(me->GetVictim(), SPELL_FIREBALL, false);
                    events.ScheduleEvent(EVENT_FIREBALL, 6000);
                    break;
                case EVENT_FLAMESTRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_FLAMESTRIKE, false);
                    events.ScheduleEvent(EVENT_FLAMESTRIKE, 15000);
                    break;
                case EVENT_FROSTBOLT:
                    if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                        me->CastSpell(target, SPELL_FROSTBOLT, false);
                    events.ScheduleEvent(EVENT_FROSTBOLT, 9000);
                    break;
                case EVENT_CHAINS_OF_ICE:
                    if (Unit* target = SelectTargetFromPlayerList(100.0f, 0, true))
                        me->CastSpell(target, SPELL_CHAINS_OF_ICE, false);
                    events.ScheduleEvent(EVENT_CHAINS_OF_ICE, 12000);
                    break;
                case EVENT_HALLUCINATION:
                    //me->CastSpell(me, SPELL_HALLUCINATION, false);
                    me->SummonCreature(NPC_PHANTOM_HALLUCINATION, *me, TEMPSUMMON_TIMED_DESPAWN, 30000);
                    me->CastSpell(me, SPELL_HALLUCINATION+1, true);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            if (me->GetInstanceScript()->GetData(DATA_WAVE_NUMBER))
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE);
        }
    };
};

class npc_phantom_hallucination : public CreatureScript
{
public:
    npc_phantom_hallucination() : CreatureScript("npc_phantom_hallucination") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_phantom_hallucinationAI(creature);
    }

    struct npc_phantom_hallucinationAI : public npc_phantom_mage::npc_phantom_mageAI
    {
        npc_phantom_hallucinationAI(Creature* c) : npc_phantom_mage::npc_phantom_mageAI(c)
        {
            numOfUpd = 2;
        }

        uint8 numOfUpd;

        void JustDied(Unit* /*who*/)
        {
            me->CastSpell((Unit*)NULL, SPELL_HALLUCINATION_2, false);
        }

        void UpdateAI(uint32 diff)
        {
            if (numOfUpd)
            {
                if (--numOfUpd == 0)
                    me->SetInCombatWithZone();
                return;
            }

            npc_phantom_mageAI::UpdateAI(diff);
        }

        void EnterEvadeMode()
        {
            if (numOfUpd)
                return;

            ScriptedAI::EnterEvadeMode();
            if (me->IsSummon())
                me->ToTempSummon()->DespawnOrUnsummon(1);
        }
    };

};

class npc_shadowy_mercenary : public CreatureScript
{
public:
    npc_shadowy_mercenary() : CreatureScript("npc_shadowy_mercenary") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_shadowy_mercenaryAI(creature);
    }

    struct npc_shadowy_mercenaryAI: public ScriptedAI
    {
        npc_shadowy_mercenaryAI(Creature* c) : ScriptedAI(c) {}

        EventMap events;

        void DoAction(int32 a)
        {
            if (a == 1)
            {
                me->SetInCombatWithZone();
                if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0.0f, true))
                    AttackStart(target);
            }
        }

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_SHADOW_STEP, 4000);
            events.ScheduleEvent(EVENT_DEADLY_POISON, 6000);
            events.ScheduleEvent(EVENT_ENVENOMED_DAGGER_THROW, 10000);
            events.ScheduleEvent(EVENT_KIDNEY_SHOT, 5000);
        }

        void AttackStart(Unit* who)
        {
            if (!me->IsVisible() || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;
            ScriptedAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SHADOW_STEP:
                    if (Unit* target = SelectTargetFromPlayerList(100.0f, 0, true))
                    {
                        DoResetThreat();
                        me->AddThreat(target, 5000.0f);
                        AttackStart(target);
                        me->CastSpell(target, SPELL_SHADOW_STEP, false);
                    }
                    events.ScheduleEvent(EVENT_SHADOW_STEP, 20000);
                    break;
                case EVENT_DEADLY_POISON:
                    me->CastSpell(me->GetVictim(), SPELL_DEADLY_POISON, false);
                    events.ScheduleEvent(EVENT_DEADLY_POISON, 4000);
                    break;
                case EVENT_ENVENOMED_DAGGER_THROW:
                    if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                        me->CastSpell(target, SPELL_ENVENOMED_DAGGER_THROW, false);
                    events.ScheduleEvent(EVENT_ENVENOMED_DAGGER_THROW, 10000);
                    break;
                case EVENT_KIDNEY_SHOT:
                    me->CastSpell(me->GetVictim(), SPELL_KIDNEY_SHOT, false);
                    events.ScheduleEvent(EVENT_KIDNEY_SHOT, 10000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            if (me->GetInstanceScript()->GetData(DATA_WAVE_NUMBER))
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE);
        }
    };
};

class npc_spectral_footman : public CreatureScript
{
public:
    npc_spectral_footman() : CreatureScript("npc_spectral_footman") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_spectral_footmanAI(creature);
    }

    struct npc_spectral_footmanAI: public ScriptedAI
    {
        npc_spectral_footmanAI(Creature* c) : ScriptedAI(c) {}

        EventMap events;

        void DoAction(int32 a)
        {
            if (a == 1)
            {
                me->SetInCombatWithZone();
                if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0.0f, true))
                    AttackStart(target);
            }
        }

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_SPECTRAL_STRIKE, 5000);
            events.ScheduleEvent(EVENT_SHIELD_BASH, 6000);
            events.ScheduleEvent(EVENT_TORTURED_ENRAGE, 15000);
        }

        void AttackStart(Unit* who)
        {
            if (!me->IsVisible() || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;
            ScriptedAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPECTRAL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_SPECTRAL_STRIKE, false);
                    events.ScheduleEvent(EVENT_SPECTRAL_STRIKE, 5000);
                    break;
                case EVENT_SHIELD_BASH:
                    me->CastSpell(me->GetVictim(), SPELL_SHIELD_BASH, false);
                    events.ScheduleEvent(EVENT_SHIELD_BASH, 6000);
                    break;
                case EVENT_TORTURED_ENRAGE:
                    me->CastSpell(me, SPELL_TORTURED_ENRAGE, false);
                    events.ScheduleEvent(EVENT_TORTURED_ENRAGE, 15000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            if (me->GetInstanceScript()->GetData(DATA_WAVE_NUMBER))
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE);
        }
    };
};

class npc_tortured_rifleman : public CreatureScript
{
public:
    npc_tortured_rifleman() : CreatureScript("npc_tortured_rifleman") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_tortured_riflemanAI(creature);
    }

    struct npc_tortured_riflemanAI  : public ScriptedAI
    {
        npc_tortured_riflemanAI(Creature* c) : ScriptedAI(c) {}

        EventMap events;

        void DoAction(int32 a)
        {
            if (a == 1)
            {
                me->SetInCombatWithZone();
                if (Unit* target = SelectTarget(SELECT_TARGET_NEAREST, 0, 0.0f, true))
                    AttackStart(target);
            }
        }

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_CURSED_ARROW, 10000);
            events.ScheduleEvent(EVENT_FROST_TRAP, 15000);
            events.ScheduleEvent(EVENT_ICE_SHOT, 15000);
        }

        void AttackStart(Unit* who)
        {
            if (!me->IsVisible() || me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                return;
            ScriptedAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_CURSED_ARROW:
                    me->CastSpell(me->GetVictim(), SPELL_CURSED_ARROW, false);
                    events.ScheduleEvent(EVENT_CURSED_ARROW, 10000);
                    break;
                case EVENT_FROST_TRAP:
                    me->CastSpell((Unit*)NULL, SPELL_FROST_TRAP, false);
                    events.ScheduleEvent(EVENT_FROST_TRAP, 30000);
                    break;
                case EVENT_ICE_SHOT:
                    if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                        me->CastSpell(target, SPELL_ICE_SHOT, false);
                    events.ScheduleEvent(EVENT_ICE_SHOT, 8000);
                    break;
            }

            DoSpellAttackIfReady(SPELL_SHOOT);
        }

        void EnterEvadeMode()
        {
            ScriptedAI::EnterEvadeMode();
            if (me->GetInstanceScript()->GetData(DATA_WAVE_NUMBER))
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE);
        }
    };
};

class boss_frostsworn_general : public CreatureScript
{
public:
    boss_frostsworn_general() : CreatureScript("boss_frostsworn_general") { }

    struct boss_frostsworn_generalAI : public ScriptedAI
    {
        boss_frostsworn_generalAI(Creature* creature) : ScriptedAI(creature)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_FROSTSWORN_GENERAL_AGGRO);
            events.ScheduleEvent(EVENT_ACTIVATE_REFLECTIONS, 8000);
            events.ScheduleEvent(EVENT_THROW_SHIELD, 6000);
            pInstance->SetData(ACTION_SPIRITUAL_REFLECTIONS_COPY, 1);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            Position p = me->GetHomePosition();
            if (me->GetExactDist(&p) > 30.0f)
            {
                EnterEvadeMode();
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ACTIVATE_REFLECTIONS:
                    me->CastSpell((Unit*)NULL, SPELL_SUMMON_REFLECTIONS_DUMMY, false);
                    pInstance->SetData(ACTION_SPIRITUAL_REFLECTIONS_ACTIVATE, 1);
                    break;
                case EVENT_THROW_SHIELD:
                    if (Unit* target = SelectTargetFromPlayerList(40.0f, 0, true))
                        me->CastSpell(target, SPELL_THROW_SHIELD, false);
                    events.ScheduleEvent(EVENT_THROW_SHIELD, 10000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_FROSTSWORN_GENERAL_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_FROSTSWORN_GENERAL, DONE);
        }

        void EnterEvadeMode()
        {
            pInstance->SetData(ACTION_SPIRITUAL_REFLECTIONS_HIDE, 1);
            ScriptedAI::EnterEvadeMode();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_frostsworn_generalAI(creature);
    }
};

class npc_hor_spiritual_reflection : public CreatureScript
{
public:
    npc_hor_spiritual_reflection() : CreatureScript("npc_hor_spiritual_reflection") { }

    struct npc_hor_spiritual_reflectionAI : public ScriptedAI
    {
        npc_hor_spiritual_reflectionAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(EVENT_BALEFUL_STRIKE, urand(4000, 7000));
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BALEFUL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_BALEFUL_STRIKE, false);
                    events.ScheduleEvent(EVENT_BALEFUL_STRIKE, urand(4000,7000));
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            me->CastSpell((Unit*)NULL, SPELL_SPIRIT_BURST, false);
        }

        void EnterEvadeMode()
        {
            me->UpdatePosition(me->GetHomePosition(), true);
            ScriptedAI::EnterEvadeMode();
            me->SetVisible(false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hor_spiritual_reflectionAI(creature);
    }
};

class at_hor_shadow_throne : public AreaTriggerScript
{
    public:
        at_hor_shadow_throne() : AreaTriggerScript("at_hor_shadow_throne") { }

        bool OnTrigger(Player* player, const AreaTrigger* /*at*/)
        {
            if (player->IsGameMaster())
                return false;

            InstanceScript* inst = player->GetInstanceScript();
            if (!inst)
                return false;

            if (inst->GetData(DATA_FROSTSWORN_GENERAL) && !inst->GetData(DATA_LK_INTRO))
                inst->SetData(DATA_LK_INTRO, DONE);

            return false;
        }
};

enum eFightEvents
{
    EVENT_EMPTY = 0,
    EVENT_LK_SAY_AGGRO,
    EVENT_JAINA_IMMOBILIZE_LK,
    EVENT_SYLVANAS_IMMOBILIZE_JUMP,
    EVENT_SYLVANAS_DARK_BINDING,
    EVENT_SAY_LEAVE,
    EVENT_ADD_GOSSIP,
    EVENT_START_RUN,
    EVENT_LK_START_FOLLOWING,
    EVENT_SAY_LEADER_STOP_TEXT,
    EVENT_LK_REMORSELESS_WINTER,
    EVENT_LK_CHECK_COMBAT,
    EVENT_LK_KILL_LEADER,
    EVENT_LK_SUMMON,
    EVENT_LK_SUMMON_GHOULS,
    EVENT_LK_SUMMON_RWD,
    EVENT_LK_SUMMON_LA,
    EVENT_LK_SUMMON_NEXT_ICE_WALL,
    EVENT_SAY_OPENING,
    EVENT_DECREASE_REQ_COUNT_BY_100,
};

class npc_hor_lich_king : public CreatureScript
{
public:
    npc_hor_lich_king() : CreatureScript("npc_hor_lich_king") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hor_lich_kingAI(creature);
    }

    struct npc_hor_lich_kingAI : public NullCreatureAI
    {
        npc_hor_lich_kingAI(Creature* creature) : NullCreatureAI(creature), summons(me)
        {
            pInstance = me->GetInstanceScript();
            if (!pInstance)
                me->IsAIEnabled = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        uint8 currentWall;
        uint8 reqKillCount;
        uint8 div2;

        void Reset()
        {
            currentWall = 0;
            reqKillCount = 0;
            events.Reset();
            events.RescheduleEvent(EVENT_LK_CHECK_COMBAT, 1000);
        }

        void DoAction(int32 a)
        {
            if (a == ACTION_START_LK_FIGHT_REAL)
                events.ScheduleEvent(EVENT_LK_START_FOLLOWING, 1500);
            else if ((a == ACTION_INFORM_TRASH_DIED && reqKillCount) || a == ACTION_CHECK_TRASH_DIED)
            {
                if ((a == ACTION_CHECK_TRASH_DIED && reqKillCount == 0) || (a == ACTION_INFORM_TRASH_DIED && (--reqKillCount) == 0))
                {
                    events.CancelEvent(EVENT_DECREASE_REQ_COUNT_BY_100); // just in case, magic happens sometimes
                    ++currentWall;
                    pInstance->SetData(ACTION_DELETE_ICE_WALL, 1);
                    if (currentWall <= 3)
                    {
                        events.ScheduleEvent(EVENT_LK_SUMMON_NEXT_ICE_WALL, 1000);
                        events.ScheduleEvent(EVENT_LK_SUMMON, currentWall == 3 ? 11000 : 7500);
                    }
                    else
                        me->RemoveAura(SPELL_REMORSELESS_WINTER);

                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_SYLVANAS_PART2)))
                        c->AI()->DoAction(ACTION_INFORM_WALL_DESTROYED);
                }
            }
        }

        void MovementInform(uint32 type, uint32  /*id*/)
        {
            // Xinef: dont use 0, it is no longer the last point
            // Xinef: if type is escort and spline is finalized, it means that we reached last point from the path
            if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized())
            {
                if (currentWall == 0)
                {
                    Talk(SAY_LK_IW_1);
                    me->SetOrientation(4.15f);
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_ICE_WALL_TARGET)))
                    {
                        me->CastSpell(c, SPELL_SUMMON_ICE_WALL, false);
                        events.ScheduleEvent(EVENT_LK_REMORSELESS_WINTER, 4000);
                    }
                }
                else if (currentWall == 4)
                {
                    Talk(SAY_LK_NOWHERE_TO_RUN);
                    pInstance->SetData(DATA_LICH_KING, DONE);
                }
            }
        }

        void JustSummoned(Creature* s)
        {
            ++reqKillCount;
            if (events.GetNextEventTime(EVENT_DECREASE_REQ_COUNT_BY_100))
                events.RescheduleEvent(EVENT_DECREASE_REQ_COUNT_BY_100, 10000);
            summons.Summon(s);
            s->SetHomePosition(PathWaypoints[WP_STOP[currentWall+1]]);
            s->GetMotionMaster()->MovePoint(0, PathWaypoints[WP_STOP[currentWall+1]]);
            s->SetInCombatWithZone();
            if (Unit* target = s->SelectNearestPlayer(350.0f))
            {
                s->AddThreat(target, 1000.0f);
                s->AI()->AttackStart(target);
            }
            s->SetHomePosition(PathWaypoints[WP_STOP[currentWall+1]]);
        }

        void SummonedCreatureDespawn(Creature* s)
        {
            summons.Despawn(s);
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spell)
        {
            if (target && target->IsAlive() && spell->Id == SPELL_LICH_KING_ZAP_PLAYER)
                Unit::DealDamage(me, target, 10000);
        }

        void UpdateAI(uint32 diff)
        {
            if (me->HealthBelowPct(70))
                me->SetHealth(me->GetMaxHealth()*3/4);

            events.Update(diff);

            if (me->IsNonMeleeSpellCast(false, true, true))
                return;

            switch(events.ExecuteEvent())
            {
                case EVENT_LK_CHECK_COMBAT:
                    if (me->isActiveObject()) // during fight
                    {
                        if (Creature* leader = pInstance->instance->GetCreature(pInstance->GetData64(NPC_SYLVANAS_PART2)))
                            if (leader->IsAlive() && leader->GetPositionX() < 5575.0f && me->GetExactDist2d(leader) <= 12.5f && !leader->HasAura(SPELL_HARVEST_SOUL) && me->HasAura(SPELL_REMORSELESS_WINTER))
                            {
                                me->GetMotionMaster()->MovementExpired();
                                me->StopMoving();
                                reqKillCount = 255;
                                leader->InterruptNonMeleeSpells(true);
                                me->CastSpell(leader, SPELL_HARVEST_SOUL, false);
                                events.ScheduleEvent(EVENT_LK_KILL_LEADER, 3000);
                                events.ScheduleEvent(EVENT_LK_CHECK_COMBAT, 1000);
                                break;
                            }
                        if (pInstance->instance->HavePlayers())
                        {
                            me->SetInCombatWithZone();
                            ++div2;
                            if (div2 > 1)
                            {
                                div2 = 0;
                                if (me->HasAura(SPELL_REMORSELESS_WINTER)) // prevent going behind him during fight
                                {
                                    Map::PlayerList const& pl = pInstance->instance->GetPlayers();
                                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                        if (Player* p = itr->GetSource())
                                            if (!p->IsGameMaster() && p->IsAlive() && (p->GetPositionX() - me->GetPositionX() + p->GetPositionY() - me->GetPositionY()) > 20.0f)
                                                me->CastSpell(p, SPELL_LICH_KING_ZAP_PLAYER, true);
                                }
                            }
                        }
                        else
                        {
                            summons.DespawnAll();
                            pInstance->SetData(ACTION_STOP_LK_FIGHT, 1);
                        }
                    }
                    events.ScheduleEvent(EVENT_LK_CHECK_COMBAT, 1000);
                    break;
                case EVENT_LK_KILL_LEADER:
                    if (Creature* leader = pInstance->instance->GetCreature(pInstance->GetData64(NPC_SYLVANAS_PART2)))
                    {
                        leader->CastSpell(leader, SPELL_HOR_SUICIDE, true);
                        Unit::Kill(me, leader);
                        me->InterruptNonMeleeSpells(true);
                        me->CastSpell((Unit*)NULL, SPELL_FURY_OF_FROSTMOURNE, false);
                    }
                    break;
                case EVENT_LK_START_FOLLOWING:
                    {
                        me->SetSpeed(MOVE_RUN, 9.0f/7.0f);
                        Movement::PointsArray path;
                        path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                        for (uint8 i=0; i<=2; ++i)
                            path.push_back(G3D::Vector3(PathWaypoints[i].GetPositionX(), PathWaypoints[i].GetPositionY(), PathWaypoints[i].GetPositionZ()));
                        me->GetMotionMaster()->MoveSplinePath(&path);
                    }
                    break;
                case EVENT_LK_REMORSELESS_WINTER:
                    {
                        me->SetSpeed(MOVE_RUN, me->GetCreatureTemplate()->speed_run);
                        Talk(SAY_LK_IW_1_SUMMON);
                        me->CastSpell(me, SPELL_REMORSELESS_WINTER, true);
                        Movement::PointsArray path;
                        path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                        for (uint8 i=3; i<PATH_WP_COUNT-1; ++i)
                            path.push_back(G3D::Vector3(PathWaypoints[i].GetPositionX(), PathWaypoints[i].GetPositionY(), PathWaypoints[i].GetPositionZ()));
                        me->GetMotionMaster()->MoveSplinePath(&path);
                        me->GetMotionMaster()->propagateSpeedChange();
                        events.ScheduleEvent(EVENT_LK_SUMMON, 1000);
                    }
                    break;
                case EVENT_LK_SUMMON:
                    switch (currentWall)
                    {
                        case 0:
                            events.ScheduleEvent(EVENT_LK_SUMMON_GHOULS, 0);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 4000);
                            break;
                        case 1:
                            events.ScheduleEvent(EVENT_LK_SUMMON_LA, 0);
                            events.ScheduleEvent(EVENT_LK_SUMMON_GHOULS, 100);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 4000);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 5100);
                            break;
                        case 2:
                            events.ScheduleEvent(EVENT_LK_SUMMON_LA, 0);
                            events.ScheduleEvent(EVENT_LK_SUMMON_GHOULS, 100);
                            events.ScheduleEvent(EVENT_LK_SUMMON_LA, 4000);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 4100);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 5200);
                            break;
                        case 3:
                            events.ScheduleEvent(EVENT_LK_SUMMON_LA, 0);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 100);
                            events.ScheduleEvent(EVENT_LK_SUMMON_GHOULS, 1200);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 5300);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 6400);
                            events.ScheduleEvent(EVENT_LK_SUMMON_GHOULS, 12500);
                            events.ScheduleEvent(EVENT_LK_SUMMON_LA, 16500);
                            events.ScheduleEvent(EVENT_LK_SUMMON_RWD, 16600);
                            events.ScheduleEvent(EVENT_LK_SUMMON_LA, 17700);
                            break;
                    }
                    if (currentWall <= 3)
                    {
                        reqKillCount = 100;
                        events.RescheduleEvent(EVENT_DECREASE_REQ_COUNT_BY_100, 10000);
                    }
                    break;
                case EVENT_DECREASE_REQ_COUNT_BY_100:
                    reqKillCount = (reqKillCount <= 100 ? 0 : reqKillCount-100);
                    DoAction(ACTION_CHECK_TRASH_DIED);
                    break;
                case EVENT_LK_SUMMON_GHOULS:
                    me->CastSpell((Unit*)NULL, SPELL_SUMMON_RAGING_GHOULS, false);
                    break;
                case EVENT_LK_SUMMON_RWD:
                    me->CastSpell((Unit*)NULL, SPELL_SUMMON_RISEN_WITCH_DOCTOR, false);
                    break;
                case EVENT_LK_SUMMON_LA:
                    me->CastSpell((Unit*)NULL, SPELL_SUMMON_LUMBERING_ABOMINATION, false);
                    break;
                case EVENT_LK_SUMMON_NEXT_ICE_WALL:
                    Talk(SAY_LK_IW_1+currentWall);
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_ICE_WALL_TARGET+currentWall)))
                        me->CastSpell(c, SPELL_SUMMON_ICE_WALL, false);
                    break;
            }
        }
    };
};

class npc_hor_leader_second : public CreatureScript
{
public:
    npc_hor_leader_second() : CreatureScript("npc_hor_leader_second") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32  /*uiAction*/) override
    {
        if (!creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP))
            return true;

        ClearGossipMenuFor(player);

        if (InstanceScript* pInstance = creature->GetInstanceScript())
            if (!pInstance->GetData(DATA_LICH_KING))
            {
                creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                creature->AI()->DoAction(ACTION_START_LK_FIGHT_REAL);
                return true;
            }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_hor_leader_secondAI(creature);
    }

    struct npc_hor_leader_secondAI : public NullCreatureAI
    {
        npc_hor_leader_secondAI(Creature* creature) : NullCreatureAI(creature)
        {
            pInstance = me->GetInstanceScript();
            if (!pInstance)
                me->IsAIEnabled = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 currentStopPoint;

        void Reset() override
        {
            currentStopPoint = 0;
            events.Reset();
        }

        void DoAction(int32 actionId) override
        {
            switch(actionId)
            {
                case ACTION_START_INTRO:
                    events.ScheduleEvent(EVENT_LK_SAY_AGGRO, 0);
                    break;
                case ACTION_START_LK_FIGHT_REAL:
                    events.ScheduleEvent(EVENT_START_RUN, 0);
                    break;
                case ACTION_INFORM_WALL_DESTROYED:
                    MoveToNextStopPoint();
                    if (currentStopPoint == 5)
                        events.ScheduleEvent(EVENT_SAY_OPENING, 3000);
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& dmg, DamageEffectType, SpellSchoolMask) override
        {
            if (dmg >= me->GetHealth())
                dmg = me->GetHealth()-1;
        }

        void MoveToNextStopPoint()
        {
            me->InterruptNonMeleeSpells(true);
            ++currentStopPoint;
            Movement::PointsArray path;
            path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
            for (uint8 i=WP_STOP[currentStopPoint-1]+(currentStopPoint == 1 ? 0 : 1); i<=WP_STOP[currentStopPoint]; ++i)
                path.push_back(G3D::Vector3(PathWaypoints[i].GetPositionX(), PathWaypoints[i].GetPositionY(), PathWaypoints[i].GetPositionZ()));
            me->GetMotionMaster()->MoveSplinePath(&path);
        }

        void MovementInform(uint32 type, uint32 /*id*/) override
        {
            if (type == ESCORT_MOTION_TYPE && me->movespline->Finalized())
                events.ScheduleEvent(EVENT_SAY_LEADER_STOP_TEXT, 1000);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch(events.ExecuteEvent())
            {
                case EVENT_LK_SAY_AGGRO:
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                        c->AI()->Talk(me->GetEntry() == NPC_JAINA_PART2 ? SAY_LK_AGGRO_ALLY : SAY_LK_AGGRO_HORDE);
                    events.ScheduleEvent(me->GetEntry() == NPC_JAINA_PART2 ? EVENT_JAINA_IMMOBILIZE_LK : EVENT_SYLVANAS_IMMOBILIZE_JUMP, 12000);
                    break;
                case EVENT_JAINA_IMMOBILIZE_LK:
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                    {
                        c->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        me->CastSpell(c, SPELL_JAINA_ICE_PRISON, false);
                        events.ScheduleEvent(EVENT_SAY_LEAVE, 5000);
                    }
                    break;
                case EVENT_SYLVANAS_IMMOBILIZE_JUMP:
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                    {
                        c->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        me->KnockbackFrom(c->GetPositionX(), c->GetPositionY(), 10.0f, 3.0f);
                        events.ScheduleEvent(EVENT_SYLVANAS_DARK_BINDING, 1500);
                    }
                    break;
                case EVENT_SYLVANAS_DARK_BINDING:
                    if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                        me->CastSpell(c, SPELL_SYLVANAS_DARK_BINDING, false);
                    events.ScheduleEvent(EVENT_SAY_LEAVE, 3500);
                    break;
                case EVENT_SAY_LEAVE:
                    {
                        Map::PlayerList const& pl = pInstance->instance->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            if (Player* p = itr->GetSource())
                                p->KilledMonsterCredit(me->GetEntry(), 0); // for quest

                        Talk(me->GetEntry() == NPC_JAINA_PART2 ? SAY_JAINA_LEAVE : SAY_SYLVANAS_LEAVE);
                        me->GetMotionMaster()->MovePoint(0, LeaderEscapePos);
                        events.ScheduleEvent(EVENT_ADD_GOSSIP, 8000);
                    }
                    break;
                case EVENT_ADD_GOSSIP:
                    me->RemoveAura(me->GetEntry() == NPC_JAINA_PART2 ? SPELL_JAINA_ICE_BARRIER : SPELL_SYLVANAS_CLOAK_OF_DARKNESS);
                    me->SetFacingTo(LeaderEscapePos.GetOrientation());
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    break;
                case EVENT_START_RUN:
                    {
                        pInstance->SetData(ACTION_START_LK_FIGHT, 1);
                        me->setActive(true);
                        MoveToNextStopPoint();
                        if (Creature* c = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                        {
                            c->setActive(true);
                            c->SetInCombatWithZone();
                            c->RemoveAura(me->GetEntry() == NPC_JAINA_PART2 ? SPELL_JAINA_ICE_PRISON : SPELL_SYLVANAS_DARK_BINDING);
                            c->AI()->DoAction(ACTION_START_LK_FIGHT_REAL);
                        }
                    }
                    break;
                case EVENT_SAY_LEADER_STOP_TEXT:
                    {
                        int32 textId = 0;
                        switch (currentStopPoint)
                        {
                            case 1: textId = SAY_SYLVANAS_IW_1; break;
                            case 2: textId = SAY_SYLVANAS_IW_2; break;
                            case 3: textId = SAY_SYLVANAS_IW_3; break;
                            case 4: textId = SAY_SYLVANAS_IW_4; break;
                            case 5: textId = SAY_SYLVANAS_END; break;
                        }
                        if (me->GetEntry() == NPC_JAINA_PART2)
                            textId += 10;
                        Talk(textId);
                        if (currentStopPoint <= 4)
                            me->CastSpell((Unit*)NULL, (me->GetEntry() == NPC_JAINA_PART2 ? SPELL_DESTROY_WALL_JAINA : SPELL_DESTROY_WALL_SYLVANAS), false);
                        else
                        {
                            me->SetFacingTo(PathWaypoints[PATH_WP_COUNT-1].GetOrientation());
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_READY1H);
                        }
                    }
                    break;
                case EVENT_SAY_OPENING:
                    Talk(me->GetEntry() == NPC_JAINA_PART2 ? SAY_JAINA_OPENING : SAY_SYLVANAS_OPENING);
                    break;
            }
        }
    };
};

class npc_hor_raging_ghoul : public CreatureScript
{
public:
    npc_hor_raging_ghoul() : CreatureScript("npc_hor_raging_ghoul") { }

    struct npc_hor_raging_ghoulAI : public ScriptedAI
    {
        npc_hor_raging_ghoulAI(Creature* creature) : ScriptedAI(creature) {}

        bool leaped;

        void Reset()
        {
            leaped = false;
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            if (!leaped)
                if (Unit* target = me->SelectNearestPlayer(30.0f))
                {
                    AttackStart(target);
                    me->CastSpell(target, 70150, false);
                    leaped = true;
                }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            me->SetCorpseDelay(10);
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (Creature* lk = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                    lk->AI()->DoAction(ACTION_INFORM_TRASH_DIED);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hor_raging_ghoulAI(creature);
    }
};

class npc_hor_risen_witch_doctor : public CreatureScript
{
public:
    npc_hor_risen_witch_doctor() : CreatureScript("npc_hor_risen_witch_doctor") { }

    struct npc_hor_risen_witch_doctorAI : public ScriptedAI
    {
        npc_hor_risen_witch_doctorAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(1, 10000);
            events.ScheduleEvent(2, 4500);
            events.ScheduleEvent(3, 9000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            switch (events.ExecuteEvent())
            {
                case 1:
                    if (Unit* target = SelectTargetFromPlayerList(30.0f, 0, true))
                        me->CastSpell(target, 70144, false);
                    events.ScheduleEvent(1, 12000);
                    break;
                case 2:
                    me->CastSpell(me->GetVictim(), 70080, false);
                    events.ScheduleEvent(2, 4500);
                    break;
                case 3:
                    if (SelectTargetFromPlayerList(30.0f, 0, true))
                        me->CastSpell(me->GetVictim(), 70145, false);
                    events.ScheduleEvent(3, 9000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            me->SetCorpseDelay(10);
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (Creature* lk = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                    lk->AI()->DoAction(ACTION_INFORM_TRASH_DIED);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hor_risen_witch_doctorAI(creature);
    }
};

class npc_hor_lumbering_abomination : public CreatureScript
{
public:
    npc_hor_lumbering_abomination() : CreatureScript("npc_hor_lumbering_abomination") { }

    struct npc_hor_lumbering_abominationAI : public ScriptedAI
    {
        npc_hor_lumbering_abominationAI(Creature* creature) : ScriptedAI(creature) {}

        EventMap events;

        void Reset()
        {
            events.Reset();
        }

        void EnterCombat(Unit* /*who*/)
        {
            events.ScheduleEvent(1, 5000);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING) || me->isFeared() || me->IsCharmed() || me->isFrozen() || me->HasUnitState(UNIT_STATE_STUNNED) || me->HasUnitState(UNIT_STATE_CONFUSED))
                return;

            switch (events.ExecuteEvent())
            {
                case 1:
                    if (me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->CastSpell(me->GetVictim(), 70176, false);
                        events.ScheduleEvent(1, 18000);
                    }
                    else
                        events.ScheduleEvent(1, 3000);
                    break;
            }

            if (me->GetVictim() && me->isAttackReady() && me->IsWithinMeleeRange(me->GetVictim()) && !me->HasUnitState(UNIT_STATE_CASTING))
                me->CastSpell(me->GetVictim(), 40505, false);

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            me->SetCorpseDelay(10);
            if (InstanceScript* pInstance = me->GetInstanceScript())
                if (Creature* lk = pInstance->instance->GetCreature(pInstance->GetData64(NPC_LICH_KING_BOSS)))
                    lk->AI()->DoAction(ACTION_INFORM_TRASH_DIED);
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_hor_lumbering_abominationAI(creature);
    }
};

class spell_hor_gunship_cannon_fire : public SpellScriptLoader
{
public:
    spell_hor_gunship_cannon_fire() : SpellScriptLoader("spell_hor_gunship_cannon_fire") { }

    class spell_hor_gunship_cannon_fireAuraScript : public AuraScript
    {
        PrepareAuraScript(spell_hor_gunship_cannon_fireAuraScript)

        void HandleEffectPeriodic(AuraEffect const *  /*aurEff*/)
        {
            PreventDefaultAction();
            if (Unit* caster = GetCaster())
                if (Creature* c = caster->SummonCreature(WORLD_TRIGGER, CannonFirePos[caster->GetEntry() == NPC_JAINA_PART2 ? 0 : 1][urand(0,2)], TEMPSUMMON_TIMED_DESPAWN, 1))
                    c->CastSpell((Unit*)NULL, 70021, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_hor_gunship_cannon_fireAuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript *GetAuraScript() const
    {
        return new spell_hor_gunship_cannon_fireAuraScript();
    }
};

/* BATTERED HILT BELOW */

class at_hor_battered_hilt_start : public AreaTriggerScript
{
    public:
        at_hor_battered_hilt_start() : AreaTriggerScript("at_hor_battered_hilt_start") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (player->HasAura(70013))
                if (InstanceScript* instance = player->GetInstanceScript())
                    instance->SetData(DATA_BATTERED_HILT, 2);
            return true;
        }
};

class at_hor_battered_hilt_throw : public AreaTriggerScript
{
    public:
        at_hor_battered_hilt_throw() : AreaTriggerScript("at_hor_battered_hilt_throw") { }

        bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/)
        {
            if (player->HasAura(70013))
                if (InstanceScript* instance = player->GetInstanceScript())
                {
                    uint32 bhd = instance->GetData(DATA_BATTERED_HILT);
                    if (bhd != BHSF_STARTED)
                        return true;
                    player->CastSpell(player, 70698, true);
                    player->DestroyItemCount(49766, 1, true);
                    instance->SetData(DATA_BATTERED_HILT, 3);
                }
            return true;
        }
};

void AddSC_halls_of_reflection()
{
    new npc_hor_leader();

    new npc_ghostly_priest();
    new npc_phantom_mage();
    new npc_phantom_hallucination();
    new npc_shadowy_mercenary();
    new npc_spectral_footman();
    new npc_tortured_rifleman();

    new boss_frostsworn_general();
    new npc_hor_spiritual_reflection();

    new at_hor_shadow_throne();
    new npc_hor_lich_king();
    new npc_hor_leader_second();
    new npc_hor_raging_ghoul();
    new npc_hor_risen_witch_doctor();
    new npc_hor_lumbering_abomination();
    new spell_hor_gunship_cannon_fire();

    new at_hor_battered_hilt_start();
    new at_hor_battered_hilt_throw();
}
