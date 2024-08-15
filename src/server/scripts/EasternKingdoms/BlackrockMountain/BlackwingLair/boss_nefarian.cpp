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

#include "CreatureScript.h"
#include "GameObject.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "MotionMaster.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "TaskScheduler.h"
#include "TemporarySummon.h"
#include "blackwing_lair.h"

enum Events
{
    // Victor Nefarius
    EVENT_SPAWN_ADDS = 1,
    EVENT_CHECK_PHASE_2,
    EVENT_START_EVENT,
    EVENT_SHADOW_BOLT,
    EVENT_SHADOW_BOLT_VOLLEY,
    EVENT_FEAR,
    EVENT_SILENCE,
    EVENT_MIND_CONTROL,
    EVENT_SHADOWBLINK,
    // Nefarian
    EVENT_SHADOWFLAME,
    EVENT_VEILOFSHADOW,
    EVENT_CLEAVE,
    EVENT_TAILLASH,
    EVENT_CLASSCALL,
    // UBRS
    EVENT_CHAOS_1,
    EVENT_CHAOS_2,
    EVENT_PATH_2,
    EVENT_PATH_3,
    EVENT_SUCCESS_1,
    EVENT_SUCCESS_2,
    EVENT_SUCCESS_3,
    // Drakonid Spawner
    EVENT_SPAWN_CHROMATIC_DRAKONID,
    // EVENT_SPAWN_ADDS, // placeholder, already defined above.

    ACTION_RESET = 0,
    ACTION_KILLED = 1,
    ACTION_ADD_KILLED = 2,
    ACTION_SPAWNER_STOP = 3
};

enum Says
{
    // Nefarius
    // UBRS
    SAY_CHAOS_SPELL            = 9,
    SAY_SUCCESS                = 10,
    SAY_FAILURE                = 11,
    // BWL
    SAY_GAMESBEGIN_1           = 12,
    SAY_GAMESBEGIN_2           = 13,

    // Nefarian
    SAY_INTRO                  = 0,
    SAY_RAISE_SKELETONS        = 1,
    SAY_SLAY                   = 2,
    SAY_DEATH                  = 3,
    SAY_XHEALTH                = 14,
    SAY_SHADOWFLAME            = 15,

    SAY_MAGE                   = 4,
    SAY_WARRIOR                = 5,
    SAY_DRUID                  = 6,
    SAY_PRIEST                 = 7,
    SAY_PALADIN                = 8,
    SAY_SHAMAN                 = 9,
    SAY_WARLOCK                = 10,
    SAY_HUNTER                 = 11,
    SAY_ROGUE                  = 12,
    SAY_DEATH_KNIGHT           = 13
};

enum Gossip
{
    GOSSIP_ID                   = 21332,
    GOSSIP_OPTION_ID            = 0
};

enum Paths
{
    NEFARIUS_PATH_2            = 1379671,
    NEFARIUS_PATH_3            = 1379672,
    NEFARIAN_PATH              = 11583
};

enum GameObjects
{
    GO_DRAKONID_BONES          = 179804,
    GO_PORTCULLIS_ACTIVE       = 164726,
    GO_PORTCULLIS_TOBOSSROOMS  = 175186
};

enum Creatures
{
    NPC_TOTEM_C_FIRE_NOVA      = 14662,
    NPC_TOTEM_C_STONESKIN      = 14663,
    NPC_TOTEM_C_HEALING        = 14664,
    NPC_TOTEM_C_WINDFURY       = 14666,
    // UBRS
    NPC_GYTH                   = 10339
};

enum Spells
{
    // Victor Nefarius
    // UBRS Spells
    SPELL_CHROMATIC_CHAOS           = 16337, // Self Cast hits 10339
    SPELL_VAELASTRASZZ_SPAWN        = 16354, // Self Cast Depawn one sec after
    // BWL Spells
    SPELL_SHADOWBOLT                = 22677,
    SPELL_SHADOWBOLT_VOLLEY         = 22665,
    SPELL_SILENCE                   = 22666,
    SPELL_SHADOW_COMMAND            = 22667,
    SPELL_FEAR                      = 22678,
    SPELL_SHADOWBLINK               = 22664,
    SPELL_RAISE_DRAKONID            = 23362,
    SPELL_SUMMON_DRAKONID_CORPSE    = 23363,

    SPELL_NEFARIANS_BARRIER         = 22663,

    // Drakonid Spawner
    SPELL_SPAWN_BLACK_DRAKONID      = 22654,
    SPELL_SPAWN_RED_DRAKONID        = 22655,
    SPELL_SPAWN_GREEN_DRAKONID      = 22656,
    SPELL_SPAWN_BRONZE_DRAKONID     = 22657,
    SPELL_SPAWN_BLUE_DRAKONID       = 22658,
    SPELL_SPAWN_CHROMATIC_DRAKONID  = 22680,
    SPELL_SPAWN_DRAKONID_GEN        = 22653,

    // Nefarian
    SPELL_SHADOWFLAME_INITIAL       = 22992,
    SPELL_SHADOWFLAME               = 22539,
    SPELL_BELLOWINGROAR             = 22686,
    SPELL_VEILOFSHADOW              = 22687,
    SPELL_CLEAVE                    = 20691,
    SPELL_TAILLASH                  = 23364,

    SPELL_MAGE                      = 23410,     // wild magic
    SPELL_WARRIOR                   = 23397,     // beserk
    SPELL_DRUID                     = 23398,     // cat form
    SPELL_PRIEST                    = 23401,     // corrupted healing
    SPELL_PALADIN                   = 23418,     // siphon blessing
    SPELL_SHAMAN                    = 23425,     // totems
    SPELL_WARLOCK                   = 23427,     // infernals
    SPELL_HUNTER                    = 23436,     // bow broke
    SPELL_ROGUE                     = 23414,     // Paralise
    SPELL_DEATH_KNIGHT              = 49576,     // Death Grip
    SPELL_ROOT_SELF                 = 17507,

    // Class Call effects
    SPELL_POLYMORPH                 = 23603,
    SPELL_BLESSING_PROTECTION       = 23415,
    SPELL_SUMMON_INFERNALS          = 23426,
    SPELL_WARRIOR_BERSERK           = 2458,
    SPELL_CORRUPTED_FIRE_NOVA_TOTEM = 23419,
    SPELL_CORRUPTED_STONESKIN_TOTEM = 23420,
    SPELL_CORRUPTED_HEALING_TOTEM   = 23422,
    SPELL_CORRUPTED_WINDFURY_TOTEM  = 23423
};

enum Misc
{
    MAX_DRAKONID_KILLED = 42
};

Position const spawnerPositions[2] = // drakonid
{
    {-7599.32f, -1191.72f, 475.545f, 3.05f},
    {-7526.27f, -1135.04f, 473.445f, 5.76f}
};

Position const NefarianSpawn = { -7348.849f, -1495.134f, 552.5152f, 1.798f };

std::unordered_map<uint32, uint32> spawnerSpells =
{
    { NPC_BLACK_SPAWNER,  SPELL_SPAWN_BLACK_DRAKONID },
    { NPC_BLUE_SPAWNER,   SPELL_SPAWN_BLUE_DRAKONID },
    { NPC_BRONZE_SPAWNER, SPELL_SPAWN_BRONZE_DRAKONID },
    { NPC_GREEN_SPAWNER,  SPELL_SPAWN_GREEN_DRAKONID },
    { NPC_RED_SPAWNER,    SPELL_SPAWN_RED_DRAKONID }
};

struct ClassCallSelector : public Acore::unary_function<Unit*, bool>
{
    ClassCallSelector(Unit const* unit, uint8 targetClass) : _me(unit), _targetClass(targetClass) { }

    bool operator()(Unit const* target) const
    {
        if (!_me || !target || target->GetTypeId() != TYPEID_PLAYER)
        {
            return false;
        }

        if (target->getClass() != _targetClass)
        {
            return false;
        }

        return true;
    }

private:
    Unit const* _me;
    uint8 _targetClass;
};

class boss_victor_nefarius : public CreatureScript
{
public:
    boss_victor_nefarius() : CreatureScript("boss_victor_nefarius") { }

    struct boss_victor_nefariusAI : public BossAI
    {
        boss_victor_nefariusAI(Creature* creature) : BossAI(creature, DATA_NEFARIAN)
        {
            Initialize();

            _nefarianLeftTunnel = instance->GetData(DATA_NEFARIAN_LEFT_TUNNEL);
            _nefarianRightTunnel = instance->GetData(DATA_NEFARIAN_RIGHT_TUNNEL);

            if (!_nefarianLeftTunnel || !_nefarianRightTunnel)
            {
                // Victor Nefarius weekly mechanic drakonid spawn
                // Pick 2 drakonids and keep them for the whole save duration (the drakonids can't be repeated).
                std::vector<uint32> nefarianDrakonidSpawners = { NPC_BLACK_SPAWNER, NPC_BLUE_SPAWNER, NPC_BRONZE_SPAWNER, NPC_GREEN_SPAWNER, NPC_RED_SPAWNER };
                Acore::Containers::RandomResize(nefarianDrakonidSpawners, 2);

                _nefarianRightTunnel = nefarianDrakonidSpawners[0];
                _nefarianLeftTunnel = nefarianDrakonidSpawners[1];

                // save it to instance
                instance->SetData(DATA_NEFARIAN_LEFT_TUNNEL, _nefarianLeftTunnel);
                instance->SetData(DATA_NEFARIAN_RIGHT_TUNNEL, _nefarianRightTunnel);
            }
        }

        void Initialize()
        {
            KilledAdds = 0;
        }

        void Reset() override
        {
            Initialize();

            if (me->GetMapId() == 469)
            {
                if (Creature* nefarian = me->FindNearestCreature(NPC_NEFARIAN, 1000.0f, true))
                {
                    // Nefarian is spawned and he didn't finish his intro path yet, despawn it manually.
                    if (nefarian->GetMotionMaster()->GetCurrentMovementGeneratorType() == MovementGeneratorType::WAYPOINT_MOTION_TYPE)
                    {
                        nefarian->DespawnOrUnsummon();
                    }
                    std::list<GameObject*> drakonidBones;
                    me->GetGameObjectListWithEntryInGrid(drakonidBones, GO_DRAKONID_BONES, DEFAULT_VISIBILITY_INSTANCE);
                    for (auto const& bones : drakonidBones)
                    {
                        bones->DespawnOrUnsummon();
                    }
                }
                else
                {
                    _Reset();
                }

                me->SetVisible(true);
                me->SetPhaseMask(1, true);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->SetFaction(FACTION_FRIENDLY);
                me->SetStandState(UNIT_STAND_STATE_SIT_HIGH_CHAIR);
                me->RemoveAura(SPELL_NEFARIANS_BARRIER);
                me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            }
        }

        void JustReachedHome() override
        {
            Reset();
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() != NPC_NEFARIAN)
            {
                BossAI::JustSummoned(summon);
            }
        }

        void SummonedCreatureDies(Creature* summon, Unit* /*unit*/) override
        {
            if (summon->GetEntry() == NPC_NEFARIAN)
            {
                summons.DespawnEntry(_nefarianLeftTunnel);
                summons.DespawnEntry(_nefarianRightTunnel);
                me->KillSelf();
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_RESET)
            {
                me->RemoveAura(SPELL_ROOT_SELF);
                summons.DespawnAll();
            }

            if (action == ACTION_ADD_KILLED)
            {
                KilledAdds++;

                if (KilledAdds == MAX_DRAKONID_KILLED)
                {
                    if (Creature* nefarian = me->SummonCreature(NPC_NEFARIAN, NefarianSpawn))
                    {
                        nefarian->setActive(true);
                        nefarian->SetCanFly(true);
                        nefarian->SetDisableGravity(true);
                        nefarian->GetMotionMaster()->MovePath(NEFARIAN_PATH, false);
                    }

                    events.Reset();
                    DoCastSelf(SPELL_ROOT_SELF, true);
                    me->SetVisible(false);
                    // Stop spawning adds
                    EntryCheckPredicate pred(_nefarianRightTunnel);
                    summons.DoAction(ACTION_SPAWNER_STOP, pred);
                    EntryCheckPredicate pred2(_nefarianLeftTunnel);
                    summons.DoAction(ACTION_SPAWNER_STOP, pred2);
                }
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetBossState(DATA_NEFARIAN, DONE);
            instance->SaveToDB();
        }

        void BeginEvent()
        {
            _JustEngagedWith();

            Talk(SAY_GAMESBEGIN_2);

            DoCast(me, SPELL_NEFARIANS_BARRIER);
            me->SetCombatMovement(false);
            me->SetImmuneToPC(false);
            AttackStart(SelectTarget(SelectTargetMethod::Random, 0, 200.f, true));
            events.ScheduleEvent(EVENT_SHADOWBLINK, 500ms);
            events.ScheduleEvent(EVENT_SHADOW_BOLT, 3s);
            events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 13s, 15s);
            events.ScheduleEvent(EVENT_FEAR, 10s, 20s);
            events.ScheduleEvent(EVENT_SILENCE, 20s, 25s);
            events.ScheduleEvent(EVENT_MIND_CONTROL, 30s, 35s);
            events.ScheduleEvent(EVENT_SPAWN_ADDS, 10s);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == 1 && data == 1)
            {
                me->StopMoving();
                events.ScheduleEvent(EVENT_PATH_2, 9s);
            }

            if (type == 1 && data == 2)
                events.ScheduleEvent(EVENT_SUCCESS_1, 5s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_PATH_2:
                            me->GetMotionMaster()->MovePath(NEFARIUS_PATH_2, false);
                            events.ScheduleEvent(EVENT_CHAOS_1, 7s);
                            break;
                        case EVENT_CHAOS_1:
                            if (Creature* gyth = me->FindNearestCreature(NPC_GYTH, 75.0f, true))
                            {
                                me->SetFacingToObject(gyth);
                                Talk(SAY_CHAOS_SPELL);
                            }
                            events.ScheduleEvent(EVENT_CHAOS_2, 2s);
                            break;
                        case EVENT_CHAOS_2:
                            DoCast(SPELL_CHROMATIC_CHAOS);
                            me->SetFacingTo(1.570796f);
                            break;
                        case EVENT_SUCCESS_1:
                            if (Unit* player = me->SelectNearestPlayer(60.0f))
                            {
                                me->SetFacingToObject(player);
                                Talk(SAY_SUCCESS);
                                if (GameObject* portcullis1 = me->FindNearestGameObject(GO_PORTCULLIS_ACTIVE, 65.0f))
                                    portcullis1->SetGoState(GO_STATE_ACTIVE);
                                if (GameObject* portcullis2 = me->FindNearestGameObject(GO_PORTCULLIS_TOBOSSROOMS, 80.0f))
                                    portcullis2->SetGoState(GO_STATE_ACTIVE);
                            }
                            events.ScheduleEvent(EVENT_SUCCESS_2, 4s);
                            break;
                        case EVENT_SUCCESS_2:
                            DoCast(me, SPELL_VAELASTRASZZ_SPAWN);
                            me->DespawnOrUnsummon(1000);
                            break;
                        case EVENT_PATH_3:
                            me->GetMotionMaster()->MovePath(NEFARIUS_PATH_3, false);
                            break;
                        case EVENT_START_EVENT:
                            BeginEvent();
                            break;
                        default:
                            break;
                    }
                }
                return;
            }

            // Only do this if we haven't spawned nefarian yet
            if (UpdateVictim() && KilledAdds <= MAX_DRAKONID_KILLED)
            {
                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SHADOW_BOLT:
                            DoCastRandomTarget(SPELL_SHADOWBOLT, 0, 150.f);
                            events.ScheduleEvent(EVENT_SHADOW_BOLT, 2s, 4s);
                            break;
                        case EVENT_SHADOW_BOLT_VOLLEY:
                            DoCastAOE(SPELL_SHADOWBOLT_VOLLEY);
                            events.ScheduleEvent(EVENT_SHADOW_BOLT_VOLLEY, 19s, 25s);
                            break;
                        case EVENT_FEAR:
                            DoCastRandomTarget(SPELL_FEAR, 0, 40.0f);
                            events.ScheduleEvent(EVENT_FEAR, 10s, 20s);
                            break;
                        case EVENT_SILENCE:
                            DoCastRandomTarget(SPELL_SILENCE, 0, 150.f);
                            events.ScheduleEvent(EVENT_SILENCE, 14s,23s);
                            break;
                        case EVENT_MIND_CONTROL:
                            DoCastRandomTarget(SPELL_SHADOW_COMMAND, 0, 40.0f);
                            events.ScheduleEvent(EVENT_MIND_CONTROL, 24s, 30s);
                            break;
                        case EVENT_SHADOWBLINK:
                            DoCastSelf(SPELL_SHADOWBLINK);
                            events.ScheduleEvent(EVENT_SHADOWBLINK, 30s, 40s);
                            break;
                        case EVENT_SPAWN_ADDS:
                            // Spawn the spawners.
                            me->SummonCreature(_nefarianLeftTunnel, spawnerPositions[0]);
                            me->SummonCreature(_nefarianRightTunnel, spawnerPositions[1]);
                            break;
                    }

                    if (me->HasUnitState(UNIT_STATE_CASTING))
                        return;
                }
            }
        }

        void sGossipSelect(Player* player, uint32 sender, uint32 action) override
        {
            if (sender == GOSSIP_ID && action == GOSSIP_OPTION_ID)
            {
                // pussywizard:
                InstanceScript* instance = player->GetInstanceScript();
                if (!instance || instance->GetBossState(DATA_NEFARIAN) == DONE)
                    return;

                CloseGossipMenuFor(player);
                Talk(SAY_GAMESBEGIN_1);
                events.ScheduleEvent(EVENT_START_EVENT, 4s);
                me->SetFaction(FACTION_DRAGONFLIGHT_BLACK);
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->SetStandState(UNIT_STAND_STATE_STAND);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->SetImmuneToPC(true);
            }
        }

        private:
            uint32 KilledAdds;
            uint32 _nefarianRightTunnel;
            uint32 _nefarianLeftTunnel;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackwingLairAI<boss_victor_nefariusAI>(creature);
    }
};

struct boss_nefarian : public BossAI
{
    boss_nefarian(Creature* creature) : BossAI(creature, DATA_NEFARIAN), _introDone(false) { }

    void Reset() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetCanFly(true);
        me->SetDisableGravity(true);
        if (_introDone) // already in combat, reset properly.
        {
            _Reset();
            if (Creature* victor = me->FindNearestCreature(NPC_VICTOR_NEFARIUS, 200.f, true))
            {
                if (victor->AI())
                {
                    victor->AI()->DoAction(ACTION_RESET);
                }
            }
            me->DespawnOrUnsummon();
        }

        classesPresent.clear();

        ScheduleHealthCheckEvent(20, [&]
        {
            DoCastSelf(SPELL_RAISE_DRAKONID, true);
            Talk(SAY_RAISE_SKELETONS);
        });
        ScheduleHealthCheckEvent(5, [&]
        {
            Talk(SAY_XHEALTH);
        });
    }

    void JustEngagedWith(Unit* /*who*/) override {}

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }

    void KilledUnit(Unit* victim) override
    {
        if (rand32() % 5)
        {
            return;
        }

        Talk(SAY_SLAY, victim);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != WAYPOINT_MOTION_TYPE)
        {
            return;
        }

        if (id == 3)
        {
            Talk(SAY_INTRO);
        }

        if (id == 5)
        {
            DoCastAOE(SPELL_SHADOWFLAME_INITIAL);
            Talk(SAY_SHADOWFLAME);
        }
    }

    void PathEndReached(uint32 /*pathId*/) override
    {
        me->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
        me->SetCanFly(false);
        me->SetDisableGravity(false);
        Position land = me->GetPosition();
        me->GetMotionMaster()->MoveLand(0, land, 8.5f);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->GetMotionMaster()->MoveIdle();

        me->SetReactState(REACT_AGGRESSIVE);
        DoZoneInCombat();
        if (me->GetVictim())
        {
            AttackStart(me->GetVictim());
        }

        events.ScheduleEvent(EVENT_SHADOWFLAME, 12s);
        events.ScheduleEvent(EVENT_FEAR, 25s, 35s);
        events.ScheduleEvent(EVENT_VEILOFSHADOW, 25s, 35s);
        events.ScheduleEvent(EVENT_CLEAVE, 7s);
        events.ScheduleEvent(EVENT_TAILLASH, 10s);
        events.ScheduleEvent(EVENT_CLASSCALL, 30s, 35s);
        _introDone = true;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SHADOWFLAME:
                    DoCastVictim(SPELL_SHADOWFLAME);
                    events.ScheduleEvent(EVENT_SHADOWFLAME, 12s);
                    break;
                case EVENT_FEAR:
                    DoCastVictim(SPELL_BELLOWINGROAR);
                    events.ScheduleEvent(EVENT_FEAR, 25s, 35s);
                    break;
                case EVENT_VEILOFSHADOW:
                    DoCastVictim(SPELL_VEILOFSHADOW);
                    events.ScheduleEvent(EVENT_VEILOFSHADOW, 25s, 35s);
                    break;
                case EVENT_CLEAVE:
                    DoCastVictim(SPELL_CLEAVE);
                    events.ScheduleEvent(EVENT_CLEAVE, 7s);
                    break;
                case EVENT_TAILLASH:
                    // Cast NYI since we need a better check for behind target
                    DoCastAOE(SPELL_TAILLASH);
                    events.ScheduleEvent(EVENT_TAILLASH, 10s);
                    break;
                case EVENT_CLASSCALL:
                    if (classesPresent.empty())
                    {
                        for (auto& ref : me->GetThreatMgr().GetThreatList())
                        {
                            if (ref->getTarget() && ref->getTarget()->GetTypeId() == TYPEID_PLAYER)
                            {
                                classesPresent.insert(ref->getTarget()->getClass());
                            }
                        }
                    }

                    uint8 targetClass = Acore::Containers::SelectRandomContainerElement(classesPresent);

                    classesPresent.erase(targetClass);

                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, ClassCallSelector(me, targetClass)))
                    {
                        switch (target->getClass())
                        {
                            case CLASS_MAGE:
                                Talk(SAY_MAGE);
                                DoCast(me, SPELL_MAGE);
                                break;
                            case CLASS_WARRIOR:
                                Talk(SAY_WARRIOR);
                                DoCast(me, SPELL_WARRIOR);
                                break;
                            case CLASS_DRUID:
                                Talk(SAY_DRUID);
                                DoCast(target, SPELL_DRUID);
                                break;
                            case CLASS_PRIEST:
                                Talk(SAY_PRIEST);
                                DoCast(me, SPELL_PRIEST);
                                break;
                            case CLASS_PALADIN:
                                Talk(SAY_PALADIN);
                                DoCast(me, SPELL_PALADIN);
                                break;
                            case CLASS_SHAMAN:
                                Talk(SAY_SHAMAN);
                                DoCast(me, SPELL_SHAMAN);
                                break;
                            case CLASS_WARLOCK:
                                Talk(SAY_WARLOCK);
                                DoCast(me, SPELL_WARLOCK);
                                break;
                            case CLASS_HUNTER:
                                Talk(SAY_HUNTER);
                                DoCast(me, SPELL_HUNTER);
                                break;
                            case CLASS_ROGUE:
                                Talk(SAY_ROGUE);
                                DoCast(me, SPELL_ROGUE);
                                break;
                            case CLASS_DEATH_KNIGHT:
                                Talk(SAY_DEATH_KNIGHT);
                                me->GetMap()->DoForAllPlayers([&](Player* p)
                                {
                                    if (!p->IsGameMaster())
                                    {
                                        me->CastSpell(p, SPELL_DEATH_KNIGHT, true);
                                    }
                                });
                                break;
                            default:
                                break;
                        }
                    }
                    events.ScheduleEvent(EVENT_CLASSCALL, 30s, 35s);
                    break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }
        }

        DoMeleeAttackIfReady();
    }

private:
    bool _introDone;
    std::set<uint8> classesPresent;
};

enum TotemSpells
{
    AURA_AVOIDANCE = 23198,

    SPELL_STONESKIN_EFFECT = 10405,
    SPELL_HEALING_EFFECT   = 10461,
    SPELL_WINDFURY_EFFECT  = 8515,
    SPELL_FIRE_NOVA_EFFECT = 11307
};

struct npc_corrupted_totem : public ScriptedAI
{
    npc_corrupted_totem(Creature* creature) : ScriptedAI(creature)
    {
        uint32 hp = urand(200, 2000);
        me->SetMaxHealth(hp);
        me->SetHealth(hp);
        _auraAdded = false;
        Reset();
    }

    void Reset() override
    {
        me->AddUnitState(UNIT_STATE_ROOT);
        if (!me->HasAura(SPELL_ROOT_SELF))
        {
            me->AddAura(SPELL_ROOT_SELF, me);
        }

        me->AddAura(AURA_AVOIDANCE, me);
        scheduler.CancelAll();
    }

    void SetAura(bool apply) const
    {
        uint32 spellId = 0;

        switch (me->GetEntry())
        {
            case NPC_TOTEM_C_STONESKIN:
                spellId = SPELL_STONESKIN_EFFECT;
                break;
            case NPC_TOTEM_C_HEALING:
                spellId = SPELL_HEALING_EFFECT;
                break;
            case NPC_TOTEM_C_WINDFURY:
                spellId = SPELL_WINDFURY_EFFECT;
                break;
        }

        if (!spellId)
        {
            return;
        }

        std::vector<uint32> mobsEntries =
        {
            NPC_NEFARIAN,
            NPC_BONE_CONSTRUCT,
            NPC_BRONZE_DRAKONID,
            NPC_BLUE_DRAKONID,
            NPC_RED_DRAKONID,
            NPC_GREEN_DRAKONID,
            NPC_BLACK_DRAKONID,
            NPC_CHROMATIC_DRAKONID
        };

        for (auto const& entry : mobsEntries)
        {
            std::list<Creature*> tmpMobList;
            GetCreatureListWithEntryInGrid(tmpMobList, me, entry, 100.f);
            while (!tmpMobList.empty())
            {
                Creature* curr = tmpMobList.front();
                tmpMobList.pop_front();

                if (!curr->IsAlive())
                {
                    continue;
                }

                if (apply && me->IsAlive())
                {
                    if (me->IsWithinDistInMap(curr, 40.f))
                    {
                        if (!curr->HasAura(spellId))
                        {
                            curr->AddAura(spellId, curr);
                        }
                    }
                    else
                    {
                        if (curr->HasAura(spellId))
                        {
                            curr->RemoveAurasDueToSpell(spellId);
                        }
                    }
                }
                else
                {
                    curr->RemoveAurasDueToSpell(spellId);
                }
            }
        }
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        me->SetInCombatWithZone();

        scheduler.Schedule(1ms, [this](TaskContext context)
            {
                if (me->GetEntry() == NPC_TOTEM_C_FIRE_NOVA)
                {
                    if (!_auraAdded)
                    {
                        context.Schedule(4s, [this](TaskContext /*context*/)
                            {
                                if (me->IsAlive())
                                {
                                    DoCastAOE(SPELL_FIRE_NOVA_EFFECT, true);
                                }
                            });
                        _auraAdded = true;
                        return;
                    }
                }

                SetAura(true);
                context.Repeat(1s);
            })
            .Schedule(me->GetEntry() == NPC_TOTEM_C_WINDFURY ? 89s : 59s, [this](TaskContext /*context*/)
            {
                SetAura(false);
                me->DespawnOrUnsummon();
            });
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (me->GetEntry() != NPC_TOTEM_C_FIRE_NOVA)
        {
            SetAura(false);
        }

        scheduler.CancelAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        scheduler.Update(diff);
    }

    protected:
        bool _auraAdded;
};

struct npc_drakonid_spawner : public ScriptedAI
{
    npc_drakonid_spawner(Creature* creature) : ScriptedAI(creature) { }

    void DoAction(int32 action) override
    {
        if (action == ACTION_SPAWNER_STOP)
        {
            me->RemoveAurasDueToSpell(SPELL_SPAWN_DRAKONID_GEN);
            scheduler.CancelAll();
        }
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        DoCastSelf(SPELL_SPAWN_DRAKONID_GEN);
        scheduler.Schedule(10s, 60s, [this](TaskContext /*context*/)
        {
            DoCastSelf(SPELL_SPAWN_CHROMATIC_DRAKONID);
        });

        _owner = summoner->GetGUID();
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*unit*/) override
    {
        if (Creature* victor = ObjectAccessor::GetCreature(*me, _owner))
        {
            victor->AI()->DoAction(ACTION_NEFARIUS_ADD_KILLED);
        }

        ObjectGuid summonGuid = summon->GetGUID();

        scheduler.Schedule(1s, [this, summonGuid](TaskContext /*context*/)
        {
            if (Creature* construct = ObjectAccessor::GetCreature(*me, summonGuid))
            {
                construct->SetVisible(false);
                construct->CastSpell(construct, SPELL_SUMMON_DRAKONID_CORPSE, true);
            }
        });
    }

protected:
    ObjectGuid _owner;
};

std::unordered_map<uint32, uint8> const classCallSpells =
{
    { SPELL_MAGE, CLASS_MAGE },
    { SPELL_WARRIOR, CLASS_WARRIOR },
    { SPELL_DRUID, CLASS_DRUID },
    { SPELL_PRIEST, CLASS_PRIEST },
    { SPELL_PALADIN, CLASS_PALADIN },
    { SPELL_SHAMAN, CLASS_SHAMAN },
    { SPELL_WARLOCK, CLASS_WARLOCK },
    { SPELL_HUNTER, CLASS_HUNTER },
    { SPELL_ROGUE, CLASS_ROGUE }
};

class spell_class_call_handler : public SpellScript
{
    PrepareSpellScript(spell_class_call_handler);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_INFERNALS });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (SpellInfo const* spellInfo = GetSpellInfo())
        {
            targets.remove_if([spellInfo](WorldObject const* target) -> bool
            {
                Player const* player = target->ToPlayer();
                if (!player || player->IsClass(CLASS_DEATH_KNIGHT)) // ignore all death knights from whatever spell, for some reason the condition below is not working x.x
                {
                    return true;
                }

                auto it = classCallSpells.find(spellInfo->Id);
                if (it != classCallSpells.end()) // should never happen but only to be sure.
                {
                    return target->ToPlayer()->getClass() != it->second;
                }

                return false;
            });
        }
    }

    void HandleOnHitRogue(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!caster || !target)
        {
            return;
        }

        Position tp = caster->GetFirstCollisionPosition(5.f, 0.f);
        target->NearTeleportTo(tp.GetPositionX(), tp.GetPositionY(), tp.GetPositionZ(), tp.GetOrientation());
    }

    void HandleOnHitWarlock()
    {
        if (Unit* target = GetHitUnit())
        {
            target->CastSpell(target, SPELL_SUMMON_INFERNALS, true);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_class_call_handler::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);

        if (m_scriptSpellId == SPELL_ROGUE)
        {
            OnEffectLaunchTarget += SpellEffectFn(spell_class_call_handler::HandleOnHitRogue, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        }
        else if (m_scriptSpellId == SPELL_WARLOCK)
        {
            OnHit += SpellHitFn(spell_class_call_handler::HandleOnHitWarlock);
        }
    }
};

class aura_class_call_wild_magic : public AuraScript
{
    PrepareAuraScript(aura_class_call_wild_magic);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_POLYMORPH });
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        if (!GetTarget())
        {
            return;
        }

        GetTarget()->CastSpell(GetTarget(), SPELL_POLYMORPH, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_class_call_wild_magic::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class aura_class_call_siphon_blessing : public AuraScript
{
    PrepareAuraScript(aura_class_call_siphon_blessing);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLESSING_PROTECTION });
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();

        if (Unit* target = GetTarget())
        {
            if (Unit* nefarian = target->FindNearestCreature(NPC_NEFARIAN, 100.f))
            {
                target->CastSpell(nefarian, SPELL_BLESSING_PROTECTION, true);
            }
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(aura_class_call_siphon_blessing::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_class_call_polymorph : public SpellScript
{
    PrepareSpellScript(spell_class_call_polymorph);

    std::list<WorldObject*> targetList;

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([&](WorldObject const* target) -> bool
            {
                return target->GetTypeId() != TYPEID_PLAYER || target->ToPlayer()->IsGameMaster() || target->ToPlayer()->HasAura(SPELL_POLYMORPH);
            });

        if (!targets.empty())
        {
            Acore::Containers::RandomResize(targets, 1);
            targetList.clear();
            targetList = targets;
        }
    }

    void FilterTargetsEff(std::list<WorldObject*>& targets)
    {
        targets.clear();
        targets = targetList;
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_class_call_polymorph::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ALLY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_class_call_polymorph::FilterTargetsEff, EFFECT_1, TARGET_UNIT_SRC_AREA_ALLY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_class_call_polymorph::FilterTargetsEff, EFFECT_2, TARGET_UNIT_SRC_AREA_ALLY);
    }
};

class spell_corrupted_totems : public SpellScript
{
    PrepareSpellScript(spell_corrupted_totems);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CORRUPTED_FIRE_NOVA_TOTEM, SPELL_CORRUPTED_HEALING_TOTEM, SPELL_CORRUPTED_STONESKIN_TOTEM, SPELL_CORRUPTED_WINDFURY_TOTEM });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (!GetCaster())
        {
            return;
        }

        std::list<uint32> spellList = { SPELL_CORRUPTED_FIRE_NOVA_TOTEM, SPELL_CORRUPTED_HEALING_TOTEM, SPELL_CORRUPTED_STONESKIN_TOTEM, SPELL_CORRUPTED_WINDFURY_TOTEM };
        uint32 spellId = Acore::Containers::SelectRandomContainerElement(spellList);
        GetCaster()->CastSpell(GetCaster(), spellId);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_corrupted_totems::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

enum ShadowblinkRandomSpells
{
    SPELL_SHADOWBLINK_TRIGGERED_1 = 22668,
    SPELL_SHADOWBLINK_TRIGGERED_2 = 22669,
    SPELL_SHADOWBLINK_TRIGGERED_3 = 22670,
    SPELL_SHADOWBLINK_TRIGGERED_4 = 22671,
    SPELL_SHADOWBLINK_TRIGGERED_5 = 22672,
    SPELL_SHADOWBLINK_TRIGGERED_6 = 22673,
    SPELL_SHADOWBLINK_TRIGGERED_7 = 22674,
    SPELL_SHADOWBLINK_TRIGGERED_8 = 22675,
    SPELL_SHADOWBLINK_TRIGGERED_9 = 22676,
};

std::unordered_map<uint32, const Position> const spellPos = {
    { SPELL_SHADOWBLINK_TRIGGERED_1, Position(-7581.11f, -1216.19f) },
    { SPELL_SHADOWBLINK_TRIGGERED_2, Position(-7561.54f, -1244.01f) },
    { SPELL_SHADOWBLINK_TRIGGERED_3, Position(-7542.47f, -1191.92f) },
    { SPELL_SHADOWBLINK_TRIGGERED_4, Position(-7538.63f, -1273.64f) },
    { SPELL_SHADOWBLINK_TRIGGERED_5, Position(-7524.36f, -1219.12f) },
    { SPELL_SHADOWBLINK_TRIGGERED_6, Position(-7506.58f, -1165.26f) },
    { SPELL_SHADOWBLINK_TRIGGERED_7, Position(-7500.70f, -1249.89f) },
    { SPELL_SHADOWBLINK_TRIGGERED_8, Position(-7486.36f, -1194.32f) },
    { SPELL_SHADOWBLINK_TRIGGERED_9, Position(-7469.93f, -1227.93f) },
};

class spell_shadowblink : public SpellScript
{
    PrepareSpellScript(spell_shadowblink);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOWBLINK_TRIGGERED_1, SPELL_SHADOWBLINK_TRIGGERED_2, SPELL_SHADOWBLINK_TRIGGERED_3, SPELL_SHADOWBLINK_TRIGGERED_4, SPELL_SHADOWBLINK_TRIGGERED_5, SPELL_SHADOWBLINK_TRIGGERED_6, SPELL_SHADOWBLINK_TRIGGERED_7, SPELL_SHADOWBLINK_TRIGGERED_8, SPELL_SHADOWBLINK_TRIGGERED_9 });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->ToCreature() || !caster->ToCreature()->AI())
        {
            return;
        }

        Unit* target = caster->ToCreature()->AI()->SelectTarget(SelectTargetMethod::Random, 0, 200.f, true);
        if (!target)
        {
            return;
        }

        for (auto& itr : spellPos)
        {
            float distTarget = target->GetDistance2d(itr.second.m_positionX, itr.second.m_positionY);
            if (distTarget <= 30.f)
            {
                caster->CastSpell(caster, itr.first, true);
                return;
            }
        }

        // Selected target is not near any known position, randomize
        auto spellId = Acore::Containers::SelectRandomContainerElement(spellPos);
        caster->CastSpell(caster, spellId.first, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_shadowblink::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 22659
class spell_spawn_drakonid : public SpellScript
{
    PrepareSpellScript(spell_spawn_drakonid);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SPAWN_BLACK_DRAKONID, SPELL_SPAWN_BLUE_DRAKONID, SPELL_SPAWN_BRONZE_DRAKONID, SPELL_SPAWN_GREEN_DRAKONID, SPELL_SPAWN_RED_DRAKONID });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
        {
            return;
        }

        caster->CastSpell(caster, spawnerSpells[caster->GetEntry()], true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_spawn_drakonid::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_boss_nefarian()
{
    new boss_victor_nefarius();
    RegisterCreatureAI(boss_nefarian);
    RegisterCreatureAI(npc_corrupted_totem);
    RegisterCreatureAI(npc_drakonid_spawner);
    RegisterSpellScript(spell_class_call_handler);
    RegisterSpellScript(aura_class_call_wild_magic);
    RegisterSpellScript(aura_class_call_siphon_blessing);
    RegisterSpellScript(spell_class_call_polymorph);
    RegisterSpellScript(spell_corrupted_totems);
    RegisterSpellScript(spell_shadowblink);
    RegisterSpellScript(spell_spawn_drakonid);
}

