/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "blackrock_depths.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "WorldSession.h"

uint32 braziersUsed = 0;

//go_shadowforge_brazier
class go_shadowforge_brazier : public GameObjectScript
{
public:
    go_shadowforge_brazier() : GameObjectScript("go_shadowforge_brazier") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            if (instance->GetData(TYPE_LYCEUM) == IN_PROGRESS)
                instance->SetData(TYPE_LYCEUM, DONE);
            else
                instance->SetData(TYPE_LYCEUM, IN_PROGRESS);
            // If used brazier open linked doors (North or South)
            if (go->GetGUID() == instance->GetData64(DATA_SF_BRAZIER_N))
            {
                if (braziersUsed == 0)
                {
                    braziersUsed = 1;
                }
                else if(braziersUsed == 2)
                {
                    instance->HandleGameObject(instance->GetData64(DATA_GOLEM_DOOR_N), true);
                    instance->HandleGameObject(instance->GetData64(DATA_GOLEM_DOOR_S), true);
                    braziersUsed = 0;
                }
            }
            else if (go->GetGUID() == instance->GetData64(DATA_SF_BRAZIER_S))
            {
                if (braziersUsed == 0)
                {
                    braziersUsed = 2;
                }
                else if (braziersUsed == 1)
                {
                    instance->HandleGameObject(instance->GetData64(DATA_GOLEM_DOOR_N), true);
                    instance->HandleGameObject(instance->GetData64(DATA_GOLEM_DOOR_S), true);
                    braziersUsed = 0;
                }
            }
        }
        return false;
    }
};

enum eChallenge
{
    QUEST_THE_CHALLENGE                 = 9015,
    GO_BANNER_OF_PROVOCATION            = 181058,
    GO_ARENA_SPOILS                     = 181074,

    NPC_GRIMSTONE                       = 10096,
    NPC_THELDREN                        = 16059,
};

uint32 theldrenTeam[] =
{
    16053, 16055, 16050, 16051, 16049, 16052, 16054, 16058
};

uint32 RingMob[] =
{
    8925,                                                   // Dredge Worm
    8926,                                                   // Deep Stinger
    8927,                                                   // Dark Screecher
    8928,                                                   // Burrowing Thundersnout
    8933,                                                   // Cave Creeper
    8932,                                                   // Borer Beetle
};

uint32 RingBoss[] =
{
    9027,                                                   // Gorosh
    9028,                                                   // Grizzle
    9029,                                                   // Eviscerator
    9030,                                                   // Ok'thor
    9031,                                                   // Anub'shiah
    9032,                                                   // Hedrum
};

class at_ring_of_law : public AreaTriggerScript
{
public:
    at_ring_of_law() : AreaTriggerScript("at_ring_of_law") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (instance->GetData(TYPE_RING_OF_LAW) == IN_PROGRESS || instance->GetData(TYPE_RING_OF_LAW) == DONE)
                return false;

            instance->SetData(TYPE_RING_OF_LAW, IN_PROGRESS);
            player->SummonCreature(NPC_GRIMSTONE, 625.559f, -205.618f, -52.735f, 2.609f, TEMPSUMMON_DEAD_DESPAWN, 0);

            return false;
        }
        return false;
    }
};

// npc_grimstone
enum GrimstoneTexts
{
    SAY_TEXT1          = 0,
    SAY_TEXT2          = 1,
    SAY_TEXT3          = 2,
    SAY_TEXT4          = 3,
    SAY_TEXT5          = 4,
    SAY_TEXT6          = 5
};

class npc_grimstone : public CreatureScript
{
public:
    npc_grimstone() : CreatureScript("npc_grimstone") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_grimstoneAI>(creature);
    }

    struct npc_grimstoneAI : public npc_escortAI
    {
        npc_grimstoneAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
            MobSpawnId = rand() % 6;
            eventPhase = 0;
            eventTimer = 1000;
            theldrenEvent = false;
            summons.DespawnAll();
        }

        InstanceScript* instance;
        SummonList summons;

        uint8 eventPhase;
        uint32 eventTimer;
        uint8 MobSpawnId;
        bool theldrenEvent;

        void Reset() override
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            if (Unit* target = SelectTargetFromPlayerList(100.0f))
                summon->AI()->AttackStart(target);
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            summons.Despawn(summon);
            // All Summons killed, next phase
            if (summons.empty())
                eventTimer = 5000;
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 0:
                    Talk(SAY_TEXT1);
                    SetEscortPaused(true);
                    eventTimer = 5000;
                    break;
                case 1:
                    Talk(SAY_TEXT2);
                    SetEscortPaused(true);
                    eventTimer = 5000;
                    break;
                case 2:
                    SetEscortPaused(true);
                    break;
                case 3:
                    Talk(SAY_TEXT3);
                    break;
                case 4:
                    Talk(SAY_TEXT4);
                    SetEscortPaused(true);
                    eventTimer = 5000;
                    break;
                case 5:
                    if (instance)
                    {
                        me->GetMap()->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, NPC_GRIMSTONE, me);
                        instance->SetData(TYPE_RING_OF_LAW, DONE);
                    }
                    break;
            }
        }

        void HandleGameObject(uint32 id, bool open)
        {
            instance->HandleGameObject(instance->GetData64(id), open);
        }

        void SummonBoss()
        {
            if (me->FindNearestGameObject(GO_BANNER_OF_PROVOCATION, 100.0f))
            {
                theldrenEvent = true;
                me->SummonCreature(NPC_THELDREN, 644.300f, -175.989f, -53.739f, 3.418f, TEMPSUMMON_DEAD_DESPAWN, 0);
                uint8 rand = urand(0, 4);
                for (uint8 i = rand; i < rand + 4; ++i)
                    me->SummonCreature(theldrenTeam[i], 644.300f, -175.989f, -53.739f, 3.418f, TEMPSUMMON_DEAD_DESPAWN, 0);
            }
            else
                me->SummonCreature(RingBoss[rand() % 6], 644.300f, -175.989f, -53.739f, 3.418f, TEMPSUMMON_DEAD_DESPAWN, 0);
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (!instance)
                return;

            if (eventTimer)
            {
                if (eventTimer <= diff)
                {
                    switch (eventPhase)
                    {
                        case 0:
                            Talk(SAY_TEXT5);
                            HandleGameObject(DATA_ARENA4, false);
                            Start(false, false);
                            eventTimer = 0;
                            break;
                        case 1:
                            SetEscortPaused(false);
                            eventTimer = 0;
                            break;
                        case 2:
                            eventTimer = 2000;
                            break;
                        case 3:
                            HandleGameObject(DATA_ARENA1, true);
                            eventTimer = 3000;
                            break;
                        case 4:
                            SetEscortPaused(false);
                            me->SetVisible(false);
                            me->SummonCreature(RingMob[MobSpawnId], 608.960f, -235.322f, -53.907f, 1.857f, TEMPSUMMON_DEAD_DESPAWN, 0);
                            eventTimer = 8000;
                            break;
                        case 5:
                            me->SummonCreature(RingMob[MobSpawnId], 608.960f, -235.322f, -53.907f, 1.857f, TEMPSUMMON_DEAD_DESPAWN, 0);
                            me->SummonCreature(RingMob[MobSpawnId], 608.960f, -235.322f, -53.907f, 1.857f, TEMPSUMMON_DEAD_DESPAWN, 0);
                            eventTimer = 8000;
                            break;
                        case 6:
                            me->SummonCreature(RingMob[MobSpawnId], 608.960f, -235.322f, -53.907f, 1.857f, TEMPSUMMON_DEAD_DESPAWN, 0);
                            eventTimer = 0;
                            break;
                        case 7:
                            me->SetVisible(true);
                            HandleGameObject(DATA_ARENA1, false);
                            Talk(SAY_TEXT6);
                            SetEscortPaused(false);
                            eventTimer = 0;
                            break;
                        case 8:
                            HandleGameObject(DATA_ARENA2, true);
                            eventTimer = 5000;
                            break;
                        case 9:
                            me->SetVisible(false);
                            SummonBoss();
                            eventTimer = 0;
                            break;
                        case 10:
                            if (theldrenEvent)
                            {
                                if (GameObject* go = me->SummonGameObject(GO_ARENA_SPOILS, 596.48f, -187.91f, -54.14f, 4.9f, 0.0f, 0.0f, 0.0f, 0.0f, 300))
                                    go->SetOwnerGUID(0);

                                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                    itr->GetSource()->KilledMonsterCredit(16166, 0);
                            }

                            HandleGameObject(DATA_ARENA2, false);
                            HandleGameObject(DATA_ARENA3, true);
                            HandleGameObject(DATA_ARENA4, true);
                            SetEscortPaused(false);
                            break;
                    }
                    ++eventPhase;
                }
                else
                    eventTimer -= diff;
            }
        }
    };
};

// npc_phalanx
enum PhalanxSpells
{
    SPELL_THUNDERCLAP                   = 8732,
    SPELL_FIREBALLVOLLEY                = 22425,
    SPELL_MIGHTYBLOW                    = 14099
};

class npc_phalanx : public CreatureScript
{
public:
    npc_phalanx() : CreatureScript("npc_phalanx") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_phalanxAI(creature);
    }

    struct npc_phalanxAI : public ScriptedAI
    {
        npc_phalanxAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 ThunderClap_Timer;
        uint32 FireballVolley_Timer;
        uint32 MightyBlow_Timer;

        void Reset() override
        {
            ThunderClap_Timer = 12000;
            FireballVolley_Timer = 0;
            MightyBlow_Timer = 15000;
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //ThunderClap_Timer
            if (ThunderClap_Timer <= diff)
            {
                DoCastVictim(SPELL_THUNDERCLAP);
                ThunderClap_Timer = 10000;
            }
            else ThunderClap_Timer -= diff;

            //FireballVolley_Timer
            if (HealthBelowPct(51))
            {
                if (FireballVolley_Timer <= diff)
                {
                    DoCastVictim(SPELL_FIREBALLVOLLEY);
                    FireballVolley_Timer = 15000;
                }
                else FireballVolley_Timer -= diff;
            }

            //MightyBlow_Timer
            if (MightyBlow_Timer <= diff)
            {
                DoCastVictim(SPELL_MIGHTYBLOW);
                MightyBlow_Timer = 10000;
            }
            else MightyBlow_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

// npc_lokhtos_darkbargainer
enum LokhtosItems
{
    ITEM_THRORIUM_BROTHERHOOD_CONTRACT                     = 18628,
    ITEM_SULFURON_INGOT                                    = 17203
};

enum LokhtosQuests
{
    QUEST_A_BINDING_CONTRACT                               = 7604
};

enum LokhtosSpells
{
    SPELL_CREATE_THORIUM_BROTHERHOOD_CONTRACT_DND          = 23059
};

class npc_lokhtos_darkbargainer : public CreatureScript
{
public:
    npc_lokhtos_darkbargainer() : CreatureScript("npc_lokhtos_darkbargainer") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            CloseGossipMenuFor(player);
            player->CastSpell(player, SPELL_CREATE_THORIUM_BROTHERHOOD_CONTRACT_DND, false);
        }
        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->IsVendor() && player->GetReputationRank(59) >= REP_FRIENDLY)
            AddGossipItemFor(player, 4781, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        if (player->GetQuestRewardStatus(QUEST_A_BINDING_CONTRACT) != 1 &&
                !player->HasItemCount(ITEM_THRORIUM_BROTHERHOOD_CONTRACT, 1, true) &&
                player->HasItemCount(ITEM_SULFURON_INGOT))
        {
            AddGossipItemFor(player, 4781, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        if (player->GetReputationRank(59) < REP_FRIENDLY)
            SendGossipMenuFor(player, 3673, creature->GetGUID());
        else
            SendGossipMenuFor(player, 3677, creature->GetGUID());

        return true;
    }
};

// npc_rocknot
enum RocknotSays
{
    SAY_GOT_BEER                       = 0
};

enum RocknotSpells
{
    SPELL_DRUNKEN_RAGE                 = 14872
};

enum RocknotQuests
{
    QUEST_ALE                          = 4295
};

class npc_rocknot : public CreatureScript
{
public:
    npc_rocknot() : CreatureScript("npc_rocknot") { }

    bool OnQuestReward(Player* /*player*/, Creature* creature, Quest const* quest, uint32 /*item*/) override
    {
        InstanceScript* instance = creature->GetInstanceScript();
        if (!instance)
            return true;

        if (instance->GetData(TYPE_BAR) == DONE || instance->GetData(TYPE_BAR) == SPECIAL)
            return true;

        if (quest->GetQuestId() == QUEST_ALE)
        {
            if (instance->GetData(TYPE_BAR) != IN_PROGRESS)
                instance->SetData(TYPE_BAR, IN_PROGRESS);

            instance->SetData(TYPE_BAR, SPECIAL);

            //keep track of amount in instance script, returns SPECIAL if amount ok and event in progress
            if (instance->GetData(TYPE_BAR) == SPECIAL)
            {
                creature->AI()->Talk(SAY_GOT_BEER);
                creature->CastSpell(creature, SPELL_DRUNKEN_RAGE, false);

                if (npc_escortAI* escortAI = CAST_AI(npc_rocknot::npc_rocknotAI, creature->AI()))
                    escortAI->Start(false, false);
            }
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_rocknotAI>(creature);
    }

    struct npc_rocknotAI : public npc_escortAI
    {
        npc_rocknotAI(Creature* creature) : npc_escortAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        uint32 BreakKeg_Timer;
        uint32 BreakDoor_Timer;

        void Reset() override
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
                return;

            BreakKeg_Timer = 0;
            BreakDoor_Timer = 0;
        }

        void DoGo(uint32 id, uint32 state)
        {
            if (GameObject* go = instance->instance->GetGameObject(instance->GetData64(id)))
                go->SetGoState((GOState)state);
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 1:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
                    break;
                case 2:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    break;
                case 3:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    break;
                case 4:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
                    break;
                case 5:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
                    BreakKeg_Timer = 2000;
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (BreakKeg_Timer)
            {
                if (BreakKeg_Timer <= diff)
                {
                    DoGo(DATA_GO_BAR_KEG, 0);
                    BreakKeg_Timer = 0;
                    BreakDoor_Timer = 1000;
                }
                else BreakKeg_Timer -= diff;
            }

            if (BreakDoor_Timer)
            {
                if (BreakDoor_Timer <= diff)
                {
                    DoGo(DATA_GO_BAR_DOOR, 2);
                    DoGo(DATA_GO_BAR_KEG_TRAP, 0);               //doesn't work very well, leaving code here for future
                    //spell by trap has effect61, this indicate the bar go hostile

                    if (Unit* tmp = ObjectAccessor::GetUnit(*me, instance->GetData64(DATA_PHALANX)))
                        tmp->setFaction(14);

                    //for later, this event(s) has alot more to it.
                    //optionally, DONE can trigger bar to go hostile.
                    instance->SetData(TYPE_BAR, DONE);

                    BreakDoor_Timer = 0;
                }
                else BreakDoor_Timer -= diff;
            }

            npc_escortAI::UpdateAI(diff);
        }
    };
};

void AddSC_blackrock_depths()
{
    new go_shadowforge_brazier();
    new at_ring_of_law();
    new npc_grimstone();
    new npc_phalanx();
    new npc_lokhtos_darkbargainer();
    new npc_rocknot();
}
