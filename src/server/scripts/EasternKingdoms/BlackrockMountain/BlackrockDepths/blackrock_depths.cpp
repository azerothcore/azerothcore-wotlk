/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "blackrock_depths.h"
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"

enum IronhandData
{
    IRONHAND_N_GROUPS          = 3,
    SPELL_GOUT_OF_FLAMES       = 15529
};

constexpr Milliseconds IRONHAND_FLAMES_TIMER = 16s;
constexpr Milliseconds IRONHAND_FLAMES_TIMER_RAND = 3s;

struct go_shadowforge_brazier : public GameObjectAI
{
    go_shadowforge_brazier(GameObject* go) : GameObjectAI(go) {}

    bool GossipHello(Player* /*player*/, bool reportUse) override
    {
        if (reportUse)
            return false;

        if (InstanceScript* instance = me->GetInstanceScript())
        {
            GameObject* northBrazier = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(DATA_SF_BRAZIER_N));
            GameObject* southBrazier = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(DATA_SF_BRAZIER_S));

            if (!northBrazier || !southBrazier)
                return false;

            // should only happen on first brazier
            if (instance->GetData(TYPE_LYCEUM) == NOT_STARTED)
                instance->SetData(TYPE_LYCEUM, IN_PROGRESS);

            // Check if the opposite brazier is lit - if it is, open the gates.
            if ((me->GetGUID() == northBrazier->GetGUID() && southBrazier->GetGoState() == GO_STATE_ACTIVE) || (me->GetGUID() == southBrazier->GetGUID() && northBrazier->GetGoState() == GO_STATE_ACTIVE))
            {
                instance->SetData(TYPE_LYCEUM, DONE);
            }
            return false;
        }
        return false;
    }
};

struct brd_ironhand_guardian : public CreatureAI
{
    brd_ironhand_guardian(Creature* creature) : CreatureAI(creature) {}

    void SetData(uint32 id, uint32 value) override
    {
        if (id  == 0)
            if (value == 0 || value == 1)
            {
                _flamesEnabled = (bool) (value);
                events.ScheduleEvent(SPELL_GOUT_OF_FLAMES, urand(1, IRONHAND_N_GROUPS) * IRONHAND_FLAMES_TIMER / IRONHAND_N_GROUPS);
            }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (_flamesEnabled)
        {
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case SPELL_GOUT_OF_FLAMES:
                        DoCast(SPELL_GOUT_OF_FLAMES);
                        events.RescheduleEvent(SPELL_GOUT_OF_FLAMES, IRONHAND_FLAMES_TIMER - IRONHAND_FLAMES_TIMER_RAND, IRONHAND_FLAMES_TIMER + IRONHAND_FLAMES_TIMER_RAND);
                        break;
                    default:
                        break;
                }
            }
        }
    }

private:
    bool _flamesEnabled = false;
    EventMap events;
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
                return false;

            if (now - instance->GetData(DATA_TIME_RING_FAIL) < 2 * 60) // in case of wipe, so people can rez.
                return false;

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

struct npc_grimstone : public npc_escortAI
{
    npc_grimstone(Creature* creature) : npc_escortAI(creature), summons(me)
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

    using CreatureAI::WaypointReached;
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
                doReset = true;
        }
        return doReset;
    }

    void SpawnWave(uint32 mobId)
    {
        for (uint32 i = 0; i < RingMobs[mobId].amount; i++)
            me->SummonCreature(RingMobs[mobId].entry, 608.960f + 0.4f * i, -235.322f, -53.907f, 1.857f, TEMPSUMMON_DEAD_DESPAWN, 0);
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
                        me->SetWalk(true);
                        Start(false);
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
                                go->SetOwnerGUID(ObjectGuid::Empty);

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

// npc_phalanx
enum PhalanxSpells
{
    SPELL_THUNDERCLAP                   = 8732,
    SPELL_FIREBALLVOLLEY                = 22425,
    SPELL_MIGHTYBLOW                    = 14099
};

struct npc_phalanx : public ScriptedAI
{
    npc_phalanx(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _thunderClapTimer = 12000;
        _fireballVolleyTimer = 0;
        _mightyBlowTimer = 15000;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (_thunderClapTimer <= diff)
        {
            DoCastVictim(SPELL_THUNDERCLAP);
            _thunderClapTimer = 10000;
        }
        else _thunderClapTimer -= diff;

        if (HealthBelowPct(51))
        {
            if (_fireballVolleyTimer <= diff)
            {
                DoCastVictim(SPELL_FIREBALLVOLLEY);
                _fireballVolleyTimer = 15000;
            }
            else _fireballVolleyTimer -= diff;
        }

        if (_mightyBlowTimer <= diff)
        {
            DoCastVictim(SPELL_MIGHTYBLOW);
            _mightyBlowTimer = 10000;
        }
        else _mightyBlowTimer -= diff;

        DoMeleeAttackIfReady();
    }

private:
    uint32 _thunderClapTimer;
    uint32 _fireballVolleyTimer;
    uint32 _mightyBlowTimer;
};

// npc_mistress_nagmara
enum GrimGuzzlerNPCs
{
    NPC_PRIVATE_ROCKNOT  = 9503,
    NPC_MISTRESS_NAGMARA = 9500
};

enum NagmaraSpells
{
    SPELL_POTION_LOVE     = 14928,
    SPELL_NAGMARA_ROCKNOT = 15064
};

enum NagmaraTexts
{
    SAY_NAGMARA_1 = 0,
    SAY_NAGMARA_2 = 1,
    EMOTE_NAGMARA = 2
};

enum NagmaraQuests
{
    QUEST_POTION_LOVE = 4201
};

enum RocknotActions
{
    ACTION_LOVE_POTION = 1
};

struct npc_mistress_nagmara : public CreatureAI
{
    npc_mistress_nagmara(Creature* creature) : CreatureAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;
    uint8 phase;
    uint32 phaseTimer;
    ObjectGuid rocknotGuid;

    void Reset() override
    {
        phase = 0;
        phaseTimer = 0;
        rocknotGuid.Clear();
    }

    void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 /*gossipListId*/) override
    {
        if (player->GetQuestRewardStatus(QUEST_POTION_LOVE))
        {
            CloseGossipMenuFor(player);

            if (Creature* rocknot = me->FindNearestCreature(NPC_PRIVATE_ROCKNOT, 100.0f))
            {
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                rocknot->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

                rocknotGuid = rocknot->GetGUID();
                
                // Force walk and follow Rocknot
                me->SetWalk(true);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveFollow(rocknot, 2.0f, 0.0f);
                
                phase = 1;
                phaseTimer = 0;
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!phase)
            return;

        if (phaseTimer <= diff)
        {
            Creature* rocknot = ObjectAccessor::GetCreature(*me, rocknotGuid);
            if (!rocknot)
            {
                phase = 0;
                return;
            }

            switch (phase)
            {
                case 1:
                    if (me->IsWithinDistInMap(rocknot, 5.0f))
                    {
                        me->GetMotionMaster()->Clear();
                        me->SetFacingToObject(rocknot);
                        rocknot->SetFacingToObject(me);
                        Talk(SAY_NAGMARA_1);
                        phase = 2;
                        phaseTimer = 5000;
                    }
                    else
                    {
                        phaseTimer = 1000;
                    }
                    break;
                case 2:
                    Talk(SAY_NAGMARA_2);
                    phase = 3;
                    phaseTimer = 4000;
                    break;
                case 3:
                    DoCast(me, SPELL_POTION_LOVE);
                    if (rocknot->AI())
                        rocknot->AI()->DoAction(ACTION_LOVE_POTION);
                    
                    // Wait 2 seconds for Rocknot's delay timer to kick in before she follows
                    phase = 4;
                    phaseTimer = 2000; 
                    break;
                case 4:
                    // Ensure she continues to walk as she follows him to the door
                    me->SetWalk(true);
                    me->GetMotionMaster()->Clear();
                    me->GetMotionMaster()->MoveFollow(rocknot, 2.0f, 0.0f);
                    phase = 5;
                    phaseTimer = 0;
                    break;
                case 5:
                    // Action handled passively while moving
                    break;
            }
        }
        else
            phaseTimer -= diff;
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

struct npc_rocknot : public npc_escortAI
{
    npc_rocknot(Creature* creature) : npc_escortAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        if (HasEscortState(STATE_ESCORT_ESCORTING))
            return;

        _breakKegTimer = 0;
        _breakDoorTimer = 0;
        _walkToDoorTimer = 0;
        _openDoorTimer = 0;
        _lovePotionEvent = false;
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_LOVE_POTION)
        {
            _lovePotionEvent = true;
            
            // Strip interaction flags immediately so he can't be talked to
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

            // Give Nagmara 2 seconds to finish her spell cast visual before moving
            _walkToDoorTimer = 2000;
        }
    }

void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE)
        {
            if (id == 99 && _lovePotionEvent)
            {
                if (GameObject* door = instance->instance->GetGameObject(instance->GetGuidData(DATA_GO_BAR_DOOR)))
                    me->SetFacingToObject(door);
                
                _openDoorTimer = 1500; 
            }
            else if (id == 100 && _lovePotionEvent)
            {
                if (instance)
                    instance->SetData(TYPE_BAR, DONE);

                if (Creature* nagmara = me->FindNearestCreature(NPC_MISTRESS_NAGMARA, 20.0f))
                {
                    me->SetFacingToObject(nagmara);
                    nagmara->GetMotionMaster()->Clear(); 
                    
                    // Set her new home position so the server doesn't evade/reset her back to the bar
                    nagmara->SetHomePosition(*nagmara);
                    
                    nagmara->SetFacingToObject(me);
                    
                    me->CastSpell(me, SPELL_NAGMARA_ROCKNOT, true);
                    nagmara->CastSpell(nagmara, SPELL_NAGMARA_ROCKNOT, true);
                }
            }
        }
        npc_escortAI::MovementInform(type, id);
    }

    void sQuestReward(Player* /*player*/, Quest const* quest, uint32 /*opt*/) override
    {
        if (!instance)
            return;

        if (instance->GetData(TYPE_BAR) == DONE || instance->GetData(TYPE_BAR) == SPECIAL)
            return;

        if (quest->GetQuestId() == QUEST_ALE)
        {
            if (instance->GetData(TYPE_BAR) != IN_PROGRESS)
                instance->SetData(TYPE_BAR, IN_PROGRESS);

            instance->SetData(TYPE_BAR, SPECIAL);

            //keep track of amount in instance script, returns SPECIAL if amount ok and event in progress
            if (instance->GetData(TYPE_BAR) == SPECIAL)
            {
                Talk(SAY_GOT_BEER);
                me->CastSpell(me, SPELL_DRUNKEN_RAGE, false);
                me->SetWalk(true);
                Start(false);
            }
        }
    }

    void DoGo(uint32 id, uint32 state)
    {
        if (GameObject* go = instance->instance->GetGameObject(instance->GetGuidData(id)))
            go->SetGoState((GOState)state);
    }

    using CreatureAI::WaypointReached;
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
                _breakKegTimer = 2000;
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (_walkToDoorTimer)
        {
            if (_walkToDoorTimer <= diff)
            {
                if (GameObject* door = instance->instance->GetGameObject(instance->GetGuidData(DATA_GO_BAR_DOOR)))
                {
                    // Calculate a coordinate exactly 2.5 yards in front of the door
                    float angle = me->GetAngle(door);
                    float x = door->GetPositionX() - 2.5f * std::cos(angle);
                    float y = door->GetPositionY() - 2.5f * std::sin(angle);
                    float z = door->GetPositionZ();

                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(99, x, y, z);
                }
                
                _walkToDoorTimer = 0;
            }
            else _walkToDoorTimer -= diff;
        }

        if (_openDoorTimer)
        {
            if (_openDoorTimer <= diff)
            {
                // The dramatic pause is over. Open the door and walk through.
                DoGo(DATA_GO_BAR_DOOR, 0); 
                me->GetMotionMaster()->MovePoint(100, 878.1779f, -222.0662f, -49.96714f);
                
                _openDoorTimer = 0;
            }
            else _openDoorTimer -= diff;
        }

        // Standard Ale Event Timers
        if (_breakKegTimer)
        {
            if (_breakKegTimer <= diff)
            {
                DoGo(DATA_GO_BAR_KEG, 0);
                _breakKegTimer = 0;
                _breakDoorTimer = 1000;
            }
            else _breakKegTimer -= diff;
        }

        if (_breakDoorTimer)
        {
            if (_breakDoorTimer <= diff)
            {
                DoGo(DATA_GO_BAR_DOOR, 2);
                DoGo(DATA_GO_BAR_KEG_TRAP, 0);               //doesn't work very well, leaving code here for future
                //spell by trap has effect61, this indicate the bar go hostile

                if (Unit* tmp = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_PHALANX)))
                    tmp->SetFaction(FACTION_MONSTER);

                //for later, this event(s) has alot more to it.
                //optionally, DONE can trigger bar to go hostile.
                instance->SetData(TYPE_BAR, DONE);
                _breakDoorTimer = 0;
            }
            else _breakDoorTimer -= diff;
        }

        npc_escortAI::UpdateAI(diff);
    }

private:
    InstanceScript* instance;
    uint32 _breakKegTimer;
    uint32 _breakDoorTimer;
    uint32 _walkToDoorTimer;
    uint32 _openDoorTimer;
    bool _lovePotionEvent;
};

void AddSC_blackrock_depths()
{
    RegisterBlackrockDepthsGameObjectAI(go_shadowforge_brazier);
    new at_ring_of_law();
    RegisterBlackrockDepthsCreatureAI(npc_grimstone);
    RegisterBlackrockDepthsCreatureAI(npc_phalanx);
    RegisterBlackrockDepthsCreatureAI(npc_mistress_nagmara);
    RegisterBlackrockDepthsCreatureAI(npc_rocknot);
    RegisterBlackrockDepthsCreatureAI(brd_ironhand_guardian);
}
