/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Sholazar_Basin
SD%Complete: 100
SDComment: Quest support: 11253, 11241.
SDCategory: howling_fjord
EndScriptData */

/* ContentData
npc_plaguehound_tracker
npc_apothecary_hanes
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "PassiveAI.h"
#include "Player.h"
#include "SpellInfo.h"

// Ours
class npc_attracted_reef_bull : public CreatureScript
{
public:
    npc_attracted_reef_bull() : CreatureScript("npc_attracted_reef_bull") { }

    struct npc_attracted_reef_bullAI : public NullCreatureAI
    {
        npc_attracted_reef_bullAI(Creature* creature) : NullCreatureAI(creature)
        {
            me->SetDisableGravity(true);
            if (me->IsSummon())
                if (Unit* owner = me->ToTempSummon()->GetSummoner())
                    me->GetMotionMaster()->MovePoint(0, *owner);
        }

        void MovementInform(uint32  /*type*/, uint32  /*id*/)
        {
            if (Creature* cow = me->FindNearestCreature(24797, 5.0f, true))
            {
                me->CastSpell(me, 44460, true);
                me->DespawnOrUnsummon(10000);
                cow->CastSpell(cow, 44460, true);
                cow->DespawnOrUnsummon(10000);
                if (me->IsSummon())
                    if (Unit* owner = me->ToTempSummon()->GetSummoner())
                        owner->CastSpell(owner, 44463, true);
            }
        }

        void SpellHit(Unit* caster, const SpellInfo* spellInfo)
        {
            if (caster && spellInfo->Id == 44454)
                me->GetMotionMaster()->MovePoint(0, *caster);
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_attracted_reef_bullAI(creature);
    }
};

class npc_your_inner_turmoil : public CreatureScript
{
public:
    npc_your_inner_turmoil() : CreatureScript("npc_your_inner_turmoil") { }

    struct npc_your_inner_turmoilAI : public ScriptedAI
    {
        npc_your_inner_turmoilAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 timer;
        short phase;

        void Reset()
        {
            timer = 0;
            phase = 0;
        }

        void UpdateAI(uint32 diff)
        {
            if (timer >= 6000 && phase < 4)
            {
                phase++;
                setphase(phase);
                timer = 0;
            }

            timer += diff;

            DoMeleeAttackIfReady();
        }

        void setphase(short phase)
        {
            Unit* summoner = me->ToTempSummon() ? me->ToTempSummon()->GetSummoner() : nullptr;
            if (!summoner || summoner->GetTypeId() != TYPEID_PLAYER)
                return;

            switch (phase)
            {
                case 1:
                    me->MonsterWhisper("You think that you can get rid of me through meditation?", summoner->ToPlayer());
                    return;
                case 2:
                    me->MonsterWhisper("Fool! I will destroy you and finally become that which has been building inside of you all these years!", summoner->ToPlayer());
                    return;
                case 3:
                    me->MonsterWhisper("You cannot defeat me. I'm an inseparable part of you!", summoner->ToPlayer());
                    return;
                case 4:
                    me->MonsterWhisper("NOOOOOOOoooooooooo!", summoner->ToPlayer());
                    me->SetLevel(summoner->getLevel());
                    me->setFaction(14);
                    if (me->GetExactDist(summoner) < 50.0f)
                    {
                        me->UpdatePosition(summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ(), 0.0f, true);
                        summoner->CastSpell(me, 50218, true); // clone caster
                        AttackStart(summoner);
                    }
            }
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_your_inner_turmoilAI(creature);
    }
};


// Theirs
/*######
## npc_apothecary_hanes
######*/
enum Entries
{
    NPC_APOTHECARY_HANES         = 23784,
    FACTION_ESCORTEE_A           = 774,
    FACTION_ESCORTEE_H           = 775,
    NPC_HANES_FIRE_TRIGGER       = 23968,
    QUEST_TRAIL_OF_FIRE          = 11241,
    SPELL_COSMETIC_LOW_POLY_FIRE = 56274,
    SPELL_HEALING_POTION         = 17534
};

class npc_apothecary_hanes : public CreatureScript
{
public:
    npc_apothecary_hanes() : CreatureScript("npc_apothecary_hanes") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_TRAIL_OF_FIRE)
        {
            creature->setFaction(player->GetTeamId() == TEAM_ALLIANCE ? FACTION_ESCORTEE_A : FACTION_ESCORTEE_H);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
        }
        return true;
    }

    struct npc_Apothecary_HanesAI : public npc_escortAI
    {
        npc_Apothecary_HanesAI(Creature* creature) : npc_escortAI(creature){ }
        uint32 PotTimer;

        void Reset()
        {
            SetDespawnAtFar(false);
            PotTimer = 10000; //10 sec cooldown on potion
        }

        void JustDied(Unit* /*killer*/)
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_TRAIL_OF_FIRE);
        }

        void UpdateEscortAI(uint32 diff)
        {
            if (HealthBelowPct(75))
            {
                if (PotTimer <= diff)
                {
                    DoCast(me, SPELL_HEALING_POTION, true);
                    PotTimer = 10000;
                } else PotTimer -= diff;
            }
            if (GetAttack() && UpdateVictim())
                DoMeleeAttackIfReady();
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    me->SetReactState(REACT_AGGRESSIVE);
                    SetRun(true);
                    break;
                case 23:
                    player->GroupEventHappens(QUEST_TRAIL_OF_FIRE, me);
                    me->DespawnOrUnsummon();
                    break;
                case 5:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(false);
                    break;
                case 6:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(true);
                    break;
                case 8:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(false);
                    break;
                case 9:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    break;
                case 10:
                    SetRun(true);
                    break;
                case 13:
                    SetRun(false);
                    break;
                case 14:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(true);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_Apothecary_HanesAI(creature);
    }
};

/*######
## npc_plaguehound_tracker
######*/

enum Plaguehound
{
    QUEST_SNIFF_OUT_ENEMY        = 11253
};

class npc_plaguehound_tracker : public CreatureScript
{
public:
    npc_plaguehound_tracker() : CreatureScript("npc_plaguehound_tracker") { }

    struct npc_plaguehound_trackerAI : public npc_escortAI
    {
        npc_plaguehound_trackerAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset()
        {
            uint64 summonerGUID = 0;

            if (me->IsSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    if (summoner->GetTypeId() == TYPEID_PLAYER)
                        summonerGUID = summoner->GetGUID();

            if (!summonerGUID)
                return;

            me->SetWalk(true);
            Start(false, false, summonerGUID);
        }

        void WaypointReached(uint32 waypointId)
        {
            if (waypointId != 26)
                return;

            me->DespawnOrUnsummon();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_plaguehound_trackerAI(creature);
    }
};

/*######
## npc_razael_and_lyana
######*/

#define GOSSIP_RAZAEL_REPORT "High Executor Anselm wants a report on the situation."
#define GOSSIP_LYANA_REPORT "High Executor Anselm requests your report."

enum Razael
{
    QUEST_REPORTS_FROM_THE_FIELD = 11221,
    NPC_RAZAEL = 23998,
    NPC_LYANA = 23778,
    GOSSIP_TEXTID_RAZAEL1 = 11562,
    GOSSIP_TEXTID_RAZAEL2 = 11564,
    GOSSIP_TEXTID_LYANA1 = 11586,
    GOSSIP_TEXTID_LYANA2 = 11588
};

class npc_razael_and_lyana : public CreatureScript
{
public:
    npc_razael_and_lyana() : CreatureScript("npc_razael_and_lyana") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_REPORTS_FROM_THE_FIELD) == QUEST_STATUS_INCOMPLETE)
            switch (creature->GetEntry())
            {
                case NPC_RAZAEL:
                    if (!player->GetReqKillOrCastCurrentCount(QUEST_REPORTS_FROM_THE_FIELD, NPC_RAZAEL))
                    {
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_RAZAEL_REPORT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                        SendGossipMenuFor(player, GOSSIP_TEXTID_RAZAEL1, creature->GetGUID());
                        return true;
                    }
                break;
                case NPC_LYANA:
                    if (!player->GetReqKillOrCastCurrentCount(QUEST_REPORTS_FROM_THE_FIELD, NPC_LYANA))
                    {
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LYANA_REPORT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                        SendGossipMenuFor(player, GOSSIP_TEXTID_LYANA1, creature->GetGUID());
                        return true;
                    }
                break;
            }
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                SendGossipMenuFor(player, GOSSIP_TEXTID_RAZAEL2, creature->GetGUID());
                player->TalkedToCreature(NPC_RAZAEL, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                SendGossipMenuFor(player, GOSSIP_TEXTID_LYANA2, creature->GetGUID());
                player->TalkedToCreature(NPC_LYANA, creature->GetGUID());
                break;
        }
        return true;
    }
};

void AddSC_howling_fjord()
{
    // Ours
    new npc_attracted_reef_bull();
    new npc_your_inner_turmoil();

    // Theirs
    new npc_apothecary_hanes();
    new npc_plaguehound_tracker();
    new npc_razael_and_lyana();
 }
