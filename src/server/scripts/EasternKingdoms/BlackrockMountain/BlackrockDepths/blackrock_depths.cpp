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

#include "blackrock_depths.h"
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"

enum IronhandData
{
    IRONHAND_FLAMES_TIMER      = 16000,
    IRONHAND_FLAMES_TIMER_RAND = 3000,
    IRONHAND_N_GROUPS          = 3,
    SPELL_GOUT_OF_FLAMES       = 15529
};

class go_shadowforge_brazier : public GameObjectScript
{
public:
    go_shadowforge_brazier() : GameObjectScript("go_shadowforge_brazier") {}

    bool OnGossipHello(Player* /*player*/, GameObject* go) override
    {
        if (InstanceScript* instance = go->GetInstanceScript())
        {
            GameObject* northBrazier = ObjectAccessor::GetGameObject(*go, instance->GetGuidData(DATA_SF_BRAZIER_N));
            GameObject* southBrazier = ObjectAccessor::GetGameObject(*go, instance->GetGuidData(DATA_SF_BRAZIER_S));

            if (!northBrazier || !southBrazier)
            {
                return false;
            }

            // should only happen on first brazier
            if (instance->GetData(TYPE_LYCEUM) == NOT_STARTED)
            {
                instance->SetData(TYPE_LYCEUM, IN_PROGRESS);
            }

            // Check if the opposite brazier is lit - if it is, open the gates.
            if ((go->GetGUID() == northBrazier->GetGUID() && southBrazier->GetGoState() == GO_STATE_ACTIVE) || (go->GetGUID() == southBrazier->GetGUID() && northBrazier->GetGoState() == GO_STATE_ACTIVE))
            {
                instance->SetData(TYPE_LYCEUM, DONE);
            }
            return false;
        }
        return false;
    };
};

class ironhand_guardian : public CreatureScript
{
public:
    ironhand_guardian() : CreatureScript("brd_ironhand_guardian") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<ironhand_guardianAI>(creature);
    }

   struct ironhand_guardianAI : public CreatureAI
    {
        ironhand_guardianAI(Creature* creature) : CreatureAI(creature) {}
        bool flames_enabled = false;

        void SetData(uint32 id, uint32 value) override
        {
            if (id  == 0)
            {
                if (value == 0 || value == 1)
                {
                    flames_enabled = (bool) (value);
                    events.ScheduleEvent(SPELL_GOUT_OF_FLAMES, urand(1, IRONHAND_N_GROUPS) * IRONHAND_FLAMES_TIMER / IRONHAND_N_GROUPS);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (flames_enabled)
            {
                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case SPELL_GOUT_OF_FLAMES:
                            DoCast(SPELL_GOUT_OF_FLAMES);
                            events.RescheduleEvent(SPELL_GOUT_OF_FLAMES, urand(IRONHAND_FLAMES_TIMER - IRONHAND_FLAMES_TIMER_RAND, IRONHAND_FLAMES_TIMER + IRONHAND_FLAMES_TIMER_RAND));
                            break;
                        default:
                            break;
                    }
                }
            }
        }
        EventMap events;
    };
};

struct WaveCreature
{
    uint32 entry;
    uint32 amount;
};

static WaveCreature RingMobs[] = // different amounts based on the type
{
    {NPC_DREDGE_WORM, 3},
    {NPC_DEEP_STINGER, 3},
    {NPC_DARK_SCREECHER, 3},
    {NPC_THUNDERSNOUT, 2},
    {NPC_CAVE_CREEPER, 3},
    {NPC_BORER_BEETLE, 6}};

uint32 RingBoss[] =
{
    NPC_GOROSH,
    NPC_GRIZZLE,
    NPC_EVISCERATOR,
    NPC_OKTHOR,
    NPC_ANUBSHIAH,
    NPC_HEDRUM
};

class at_ring_of_law : public AreaTriggerScript
{
public:
    at_ring_of_law() : AreaTriggerScript("at_ring_of_law") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            time_t now = GameTime::GetGameTime().count();
            if (instance->GetData(TYPE_RING_OF_LAW) == IN_PROGRESS || instance->GetData(TYPE_RING_OF_LAW) == DONE)
            {
                return false;
            }
            if (now - instance->GetData(DATA_TIME_RING_FAIL) < 2 * 60) // in case of wipe, so people can rez.
            {
                return false;
            }

            instance->SetData(TYPE_RING_OF_LAW, IN_PROGRESS);
            return true;
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
        return GetBlackrockDepthsAI<npc_grimstoneAI>(creature);
    }

    struct npc_grimstoneAI : public npc_escortAI
    {
        npc_grimstoneAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
            MobSpawnId    = instance ? instance->GetData(DATA_ARENA_MOBS) : urand(0, 5);
            BossSpawnId   = instance ? instance->GetData(DATA_ARENA_BOSS) : urand(0, 5);
            eventPhase = 0;
            eventTimer = 1000;
            resetTimer = 0;
            theldrenEvent = false;
            summons.DespawnAll();
        }

        InstanceScript* instance;
        SummonList summons;

        uint8 eventPhase;
        uint32 eventTimer;
        uint32 resetTimer;
        uint8 MobSpawnId;
        uint8  BossSpawnId;
        bool theldrenEvent;

        void Reset() override
        {
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
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
            {
                resetTimer = 0;
                eventTimer = 5000;
            }
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
            instance->HandleGameObject(instance->GetGuidData(id), open);
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
                me->SummonCreature(RingBoss[BossSpawnId], 644.300f, -175.989f, -53.739f, 3.418f, TEMPSUMMON_DEAD_DESPAWN, 0);
            resetTimer = 30000;
        }

        bool updateReset(uint32 diff)
        {
            // as long as the summoned creatures have someone to attack, we reset the timer.
            // once they don't find anyone, the timer will count down until it is smaller than diff and reset.
            bool doReset = false;
            if (resetTimer > 0)
            {
                for (auto const& sum : summons)
                {
                    if (Creature* creature = ObjectAccessor::GetCreature(*me, sum))
                    {
                        if (creature->IsAlive() && creature->GetVictim())
                        {
                            resetTimer = 30000;
                            break; // only need to find one.
                        }
                    }
                }

                resetTimer -= diff;
                if (resetTimer <= diff)
                {
                    doReset = true;
                }
            }
            return doReset;
        }

        void SpawnWave(uint32 mobId)
        {
            for (uint32 i = 0; i < RingMobs[mobId].amount; i++)
            {
                me->SummonCreature(RingMobs[mobId].entry, 608.960f + 0.4f * i, -235.322f, -53.907f, 1.857f, TEMPSUMMON_DEAD_DESPAWN, 0);
            }
            resetTimer = 30000;
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (!instance)
                return;

            // reset if our mobs don't have a target.
            if (updateReset(diff))
            {
                summons.DespawnAll();
                HandleGameObject(DATA_ARENA4, true);
                HandleGameObject(DATA_ARENA3, false);
                HandleGameObject(DATA_ARENA2, false);
                HandleGameObject(DATA_ARENA1, false);
                instance->SetData(TYPE_RING_OF_LAW, FAIL);
            }

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
                            SpawnWave(MobSpawnId); // wave 1
                            eventTimer = 15000;
                            break;
                        case 5:
                            SpawnWave(MobSpawnId); // wave 2
                            eventTimer = 0; // will be set from SummonedCreatureDies
                            break;
                        case 6:
                            me->SetVisible(true);
                            HandleGameObject(DATA_ARENA1, false);
                            Talk(SAY_TEXT6);
                            SetEscortPaused(false);
                            eventTimer = 0;
                            break;
                        case 7:
                            HandleGameObject(DATA_ARENA2, true);
                            eventTimer = 5000;
                            break;
                        case 8:
                            me->SetVisible(false);
                            SummonBoss();
                            eventTimer = 0;
                            break;
                        case 9:
                            if (theldrenEvent)
                            {
                                // All objects are removed from world once tempsummons despawn, so have a player spawn it instead.
                                Player* player = me->SelectNearestPlayer(100.0f);
                                if (GameObject* go = player->SummonGameObject(GO_ARENA_SPOILS, 596.48f, -187.91f, -54.14f, 4.9f, 0.0f, 0.0f, 0.0f, 0.0f, 300))
                                {
                                    go->SetOwnerGUID(ObjectGuid::Empty);
                                }

                                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                    itr->GetSource()->KilledMonsterCredit(16166);
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
        return GetBlackrockDepthsAI<npc_phalanxAI>(creature);
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
        return GetBlackrockDepthsAI<npc_rocknotAI>(creature);
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
            if (GameObject* go = instance->instance->GetGameObject(instance->GetGuidData(id)))
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

                    if (Unit* tmp = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_PHALANX)))
                        tmp->SetFaction(FACTION_MONSTER);

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
    new ironhand_guardian();
}
