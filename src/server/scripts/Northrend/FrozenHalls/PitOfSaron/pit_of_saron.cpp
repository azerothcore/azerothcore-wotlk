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

#include "pit_of_saron.h"
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum Spells
{
    SPELL_RAISE_DEAD                    = 69350,
    SPELL_EMPOWERED_BLIZZARD_AURA       = 70132,
    SPELL_EMPOWERED_BLIZZARD            = 70131,
    SPELL_SHRIEK_OF_THE_HIGHBORNE       = 59514,
    SPELL_MULTI_SHOT                    = 70513,
    SPELL_ICE_LANCE_VOLLEY              = 70464,
    SPELL_NECROLYTE_SHADOW_BOLT         = 69577,
    SPELL_CONVERSION_BEAM               = 69578,
    SPELL_SUMMON_UNDEAD                 = 69516,
    SPELL_ICICLE                        = 69426,
    SPELL_ICICLE_DUMMY                  = 69428,
    SPELL_ICE_SHARDS                    = 69425,
    SPELL_ICE_SHARDS_H                  = 70827,
    SPELL_BLIGHT                        = 69604,
};

enum Texts
{
    SAY_SLAVE_FREED                     = 0,
};

enum Models
{
    MODEL_INVISIBLE                     = 11686,
};

enum Actions
{
    ACTION_SUMMON_SINDRAGOSA            = 1,    // npc_pos_leader_second
    ACTION_REMOVE_INVINCIBILITY         = 1337, // npc_pos_deathwhisper_necrolyte
};

enum Events
{
    // npc_pos_leader
    EVENT_INTRO_SUMMON_CHAMPIONS = 1,
    EVENT_INTRO_TYRANNUS_1,
    EVENT_INTRO_TYRANNUS_2,
    EVENT_INTRO_CHAMPIONS_ATTACK,
    EVENT_INTRO_LEADER_1,
    EVENT_INTRO_TYRANNUS_3,
    EVENT_INTRO_STRANGULATE,
    EVENT_INTRO_NECROMANTIC_POWER,
    EVENT_INTRO_KILL_CHAMPIONS,
    EVENT_INTRO_LEADER_2,
    EVENT_INTRO_RAISE_DEAD,
    EVENT_INTRO_CORRUPT_CHAMPIONS,
    EVENT_INTRO_CORRUPTED_ATTACK,
    EVENT_INTRO_LEADER_SPELL,
    EVENT_INTRO_TYRANNUS_LEAVE,
    EVENT_INTRO_LEADER_3,
    EVENT_INTRO_LEADER_4,

    // npc_pos_deathwhisper_necrolyte
    EVENT_NECROLYTE_SHADOW_BOLT,
    EVENT_NECROLYTE_CONVERSION_BEAM,

    // npc_pos_after_first_boss
    EVENT_FBS_SUMMON_SLAVES,
    EVENT_FBS_TYRANNUS,
    EVENT_FBS_GENERAL,

    // npc_pos_tyrannus_events
    EVENT_TYRANNUS_MOVE_WAIT_1,
    EVENT_TYRANNUS_FACE_WAIT_1,
    EVENT_TYRANNUS_MOVE_WAIT_2,
    EVENT_TYRANNUS_FACE_WAIT_2,
    EVENT_TYRANNUS_TAKEOFF,
    EVENT_TYRANNUS_MOVE_WAIT_3,
    EVENT_AMBUSH_1_SUMMON_DEATHBRINGERS,
    EVENT_AMBUSH_1_DEATHBRINGER_1_ARRIVED,
    EVENT_AMBUSH_1_DEATHBRINGER_2_ARRIVED,
    EVENT_AMBUSH_1_SUMMON_WAVE_1,
    EVENT_AMBUSH_1_SUMMON_WAVE_2,
    EVENT_AMBUSH_1_ACTIVATE_DEATHBRINGER_1,
    EVENT_AMBUSH_1_ACTIVATE_DEATHBRINGER_2,
    EVENT_AMBUSH_2_SUMMON,

    // npc_pos_martin_or_gorkun_second
    EVENT_GENERAL_SUMMON_SLAVES,
    EVENT_GENERAL_TRASH_TALK,
    EVENT_GENERAL_TYRANNUS_INTRO,
    EVENT_GENERAL_START_FIGHT,
    EVENT_GENERAL_OUTRO,
    EVENT_GENERAL_SUMMON_FALLEN_WARRIOR,

    // npc_pos_leader_second
    EVENT_LEADER_OUTRO_SUMMON_SINDRAGOSA,
    EVENT_LEADER_OUTRO_GENERAL_2,
    EVENT_LEADER_OUTRO_LEADER_1,
    EVENT_LEADER_OUTRO_TELEPORT,
    EVENT_LEADER_OUTRO_FROST_BOMB,
    EVENT_LEADER_OUTRO_SINDRAGOSA_LEAVE,
    EVENT_LEADER_OUTRO_SINDRAGOSA_HIDE,
    EVENT_LEADER_OUTRO_LEADER_MOVE,
    EVENT_LEADER_OUTRO_FROST_BOMB_KILL,
};

enum MovePoints
{
    POINT_NECROLYTE_POSITION            = 1,
    POINT_FBS_GARFROST                  = 1,
    POINT_GENERAL_CENTER                = 2,

    // Waypoint ids of the PATH_JAINA_OUTRO and PATH_SYLVANAS_OUTRO paths
    POINT_LEADER_OUTRO_2                = 1,
    POINT_JAINA_OUTRO_3                 = 2,
    POINT_OPEN_PORTCULLIS               = 7,
};

// SetData types and values sent to npc_pos_tyrannus_events by areatrigger and trash smart_scripts
enum TyrannusEventDataTypes
{
    DATA_AREATRIGGER                    = 1,
    DATA_TRASH_KILLED                   = 2,
};

enum TyrannusEventDataValues
{
    AREATRIGGER_AMBUSH_1                = 1,
    AREATRIGGER_AMBUSH_2                = 2,
    AREATRIGGER_TUNNEL                  = 3,

    TRASH_KILLED                        = 1,
};

class npc_pos_leader : public CreatureScript
{
public:
    npc_pos_leader() : CreatureScript("npc_pos_leader") { }

    struct npc_pos_leaderAI : public NullCreatureAI
    {
        npc_pos_leaderAI(Creature* creature) : NullCreatureAI(creature), _summons(me)
        {
            _instance = me->GetInstanceScript();
        }

        void Reset() override
        {
            _counter = 0;
            events.Reset();
            _summons.DespawnAll();
            me->SetVisible(true);

            if (_instance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_NONE)
                me->SetVisible(false);
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            if (type == DATA_START_INTRO && _instance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_NONE && _counter == 0 && !me->IsVisible())
            {
                me->setActive(true);
                events.RescheduleEvent(EVENT_INTRO_SUMMON_CHAMPIONS, 0ms);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_INTRO_SUMMON_CHAMPIONS:
                    {
                        if (_counter == 0)
                        {
                            me->SetVisible(true);
                            me->GetMotionMaster()->MovePoint(1, LeaderIntroPos);
                        }

                        uint8 idx = _instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE ? 0 : 1;
                        if (IntroPositions[_counter].Entry[idx] != 0)
                        {
                            if (Creature* summon = me->SummonCreature(IntroPositions[_counter].Entry[idx], PortalPos))
                            {
                                summon->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                summon->SetSpeed(MOVE_RUN, 0.8f);
                                summon->GetMotionMaster()->MovePoint(1, IntroPositions[_counter].EndPosition);
                                summon->SetEmoteState(EMOTE_STATE_READY1H);
                            }

                            ++_counter;
                            events.Repeat(150ms);
                        }
                        else
                            events.RescheduleEvent(EVENT_INTRO_TYRANNUS_1, 2500ms);
                    }
                    break;
                case EVENT_INTRO_TYRANNUS_1:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                    {
                        tyrannus->setActive(true);
                        tyrannus->AI()->Talk(SAY_TYRANNUS_INTRO_1);
                    }

                    events.RescheduleEvent(EVENT_INTRO_TYRANNUS_2, 7s);
                    break;
                case EVENT_INTRO_TYRANNUS_2:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->AI()->Talk(SAY_TYRANNUS_INTRO_2);

                    events.RescheduleEvent(EVENT_INTRO_CHAMPIONS_ATTACK, 14s);
                    break;
                case EVENT_INTRO_CHAMPIONS_ATTACK:
                    {
                        Creature* necrolyte1 = _instance->instance->GetCreature(_instance->GetGuidData(DATA_NECROLYTE_1_GUID));
                        Creature* necrolyte2 = _instance->instance->GetCreature(_instance->GetGuidData(DATA_NECROLYTE_2_GUID));
                        if (necrolyte1 && necrolyte2)
                        {
                            if (!necrolyte1->IsInCombat() && necrolyte1->IsAlive())
                            {
                                necrolyte1->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                necrolyte1->GetMotionMaster()->MovePoint(POINT_NECROLYTE_POSITION, NecrolytePos1);
                                necrolyte1->SetEmoteState(EMOTE_STATE_READY1H);
                            }
                            if (!necrolyte2->IsInCombat() && necrolyte2->IsAlive())
                            {
                                necrolyte2->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                necrolyte2->GetMotionMaster()->MovePoint(POINT_NECROLYTE_POSITION, NecrolytePos2);
                                necrolyte2->SetEmoteState(EMOTE_STATE_READY1H);
                            }
                            necrolyte1->RemoveAura(SPELL_NECROLYTE_CHANNELING);
                            necrolyte2->RemoveAura(SPELL_NECROLYTE_CHANNELING);

                            for (ObjectGuid const& guid : _summons)
                                if (Creature* champion = _instance->instance->GetCreature(guid))
                                {
                                    if (champion->GetPositionX() < 440.0f)
                                        continue;
                                    if (champion->GetPositionY() > 215.0f)
                                        champion->GetMotionMaster()->MoveChase(necrolyte2, 0.0f, rand_norm() * 2 * M_PI);
                                    else
                                        champion->GetMotionMaster()->MoveChase(necrolyte1, 0.0f, rand_norm() * 2 * M_PI);
                                }
                        }
                    }

                    events.RescheduleEvent(EVENT_INTRO_LEADER_1, 1ms);
                    break;
                case EVENT_INTRO_LEADER_1:
                    Talk(me->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_INTRO_1 : SAY_SYLVANAS_INTRO_1);

                    events.RescheduleEvent(EVENT_INTRO_TYRANNUS_3, 1s);
                    break;
                case EVENT_INTRO_TYRANNUS_3:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->AI()->Talk(SAY_TYRANNUS_INTRO_3);

                    events.RescheduleEvent(EVENT_INTRO_STRANGULATE, 5s);
                    break;
                case EVENT_INTRO_STRANGULATE: /// @todo: (Initial RP, when zoning in the instance) is not complete.
                    if (Creature* necrolyte1 = _instance->instance->GetCreature(_instance->GetGuidData(DATA_NECROLYTE_1_GUID)))
                        necrolyte1->AI()->DoAction(ACTION_REMOVE_INVINCIBILITY);
                    if (Creature* necrolyte2 = _instance->instance->GetCreature(_instance->GetGuidData(DATA_NECROLYTE_2_GUID)))
                        necrolyte2->AI()->DoAction(ACTION_REMOVE_INVINCIBILITY);

                    for (ObjectGuid const& guid : _summons)
                        if (Creature* champion = _instance->instance->GetCreature(guid))
                        {
                            if (champion->GetPositionX() < 450.0f)
                                continue;
                            champion->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                            champion->GetMotionMaster()->Clear(false);
                            champion->GetMotionMaster()->MoveIdle();
                            champion->StopMoving();
                            champion->CastSpell(champion, SPELL_STRANGULATING, true);
                            champion->SetCanFly(true);
                            champion->SetDisableGravity(true);
                            champion->SendMovementFlagUpdate();
                            float dist = rand_norm() * 2.0f;
                            float angle = rand_norm() * 2 * M_PI;
                            champion->GetMotionMaster()->MoveTakeoff(0, champion->GetPositionX() + dist * std::cos(angle), champion->GetPositionY() + dist * std::sin(angle), champion->GetPositionZ() + 6.0f + (float)urand(0, 4), 1.5f + frand(0.0f, 1.5f));
                        }

                    events.RescheduleEvent(EVENT_INTRO_NECROMANTIC_POWER, 7s);
                    break;
                case EVENT_INTRO_NECROMANTIC_POWER:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->CastSpell(tyrannus, SPELL_NECROMANTIC_POWER, false);

                    events.RescheduleEvent(EVENT_INTRO_KILL_CHAMPIONS, 400ms);
                    break;
                case EVENT_INTRO_KILL_CHAMPIONS:
                    for (ObjectGuid const& guid : _summons)
                        if (Creature* champion = _instance->instance->GetCreature(guid))
                        {
                            if (champion->GetPositionX() < 450.0f)
                                continue;
                            Unit::Kill(champion, champion);
                            champion->RemoveAllAuras();
                            champion->GetMotionMaster()->MoveFall(0, true);
                        }

                    events.RescheduleEvent(EVENT_INTRO_LEADER_2, 1s);
                    break;
                case EVENT_INTRO_LEADER_2:
                    Talk(me->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_INTRO_2 : SAY_SYLVANAS_INTRO_2);

                    events.RescheduleEvent(EVENT_INTRO_RAISE_DEAD, 1s);
                    break;
                case EVENT_INTRO_RAISE_DEAD:
                    for (ObjectGuid const& guid : _summons)
                        if (Creature* champion = _instance->instance->GetCreature(guid))
                        {
                            if (champion->GetPositionX() < 450.0f)
                                continue;
                            champion->SetCanFly(false);
                            champion->SetDisableGravity(false);
                            champion->SendMovementFlagUpdate();
                            champion->CastSpell(champion, SPELL_RAISE_DEAD, true);
                        }

                    events.RescheduleEvent(EVENT_INTRO_CORRUPT_CHAMPIONS, 2s);
                    break;
                case EVENT_INTRO_CORRUPT_CHAMPIONS:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->AI()->Talk(SAY_TYRANNUS_INTRO_4);

                    for (ObjectGuid const& guid : _summons)
                        if (Creature* champion = _instance->instance->GetCreature(guid))
                        {
                            if (champion->GetPositionX() < 450.0f)
                                continue;
                            champion->SetHomePosition(champion->GetPositionX(), champion->GetPositionY(), champion->GetPositionZ(), champion->GetOrientation());
                            champion->Respawn(true);
                            champion->UpdateEntry(NPC_CORRUPTED_CHAMPION, 0, false);
                            champion->SetFacingTo(M_PI);
                            champion->SetReactState(REACT_PASSIVE);
                        }

                    events.RescheduleEvent(EVENT_INTRO_CORRUPTED_ATTACK, 3s);
                    break;
                case EVENT_INTRO_CORRUPTED_ATTACK:
                    for (ObjectGuid const& guid : _summons)
                        if (Creature* champion = _instance->instance->GetCreature(guid))
                        {
                            if (champion->GetPositionX() < 450.0f)
                                continue;
                            champion->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                            float dist = rand_norm();
                            float angle = rand_norm() * 2 * M_PI;
                            champion->SetSpeed(MOVE_RUN, 0.8f);
                            champion->SetInCombatWithZone();
                            champion->GetMotionMaster()->MoveChase(me, dist, angle);
                            champion->SetHomePosition(me->GetPositionX() + dist * std::cos(angle), me->GetPositionY() + dist * std::sin(angle), me->GetPositionZ(), 0.0f);
                        }

                    events.RescheduleEvent(EVENT_INTRO_LEADER_SPELL, 2s);
                    break;
                case EVENT_INTRO_LEADER_SPELL:
                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        Talk(SAY_JAINA_INTRO_3);
                        me->CastSpell(me, SPELL_EMPOWERED_BLIZZARD_AURA, false);
                    }
                    else
                    {
                        me->CastSpell(me, SPELL_SHRIEK_OF_THE_HIGHBORNE, false);
                        for (uint8 i = 0; i < 2; ++i)
                            if (Creature* guard = _instance->instance->GetCreature(_instance->GetGuidData(DATA_GUARD_1_GUID + i)))
                                guard->CastSpell(guard, SPELL_MULTI_SHOT, false);
                    }

                    events.RescheduleEvent(EVENT_INTRO_TYRANNUS_LEAVE, 2s);
                    break;
                case EVENT_INTRO_TYRANNUS_LEAVE:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_EVENT_GUID)))
                        tyrannus->GetMotionMaster()->MovePoint(POINT_TYRANNUS_INTRO_END, SBSTyrannusStartPos);

                    if (me->GetEntry() == NPC_JAINA_PART1)
                    {
                        for (uint8 i = 0; i < 2; ++i)
                            if (Creature* guard = _instance->instance->GetCreature(_instance->GetGuidData(DATA_GUARD_1_GUID + i)))
                                guard->CastSpell(guard, SPELL_ICE_LANCE_VOLLEY, false);
                    }

                    events.RescheduleEvent(EVENT_INTRO_LEADER_3, 3s);
                    break;
                case EVENT_INTRO_LEADER_3:
                    Talk(me->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_INTRO_4 : SAY_SYLVANAS_INTRO_3);

                    for (uint8 i = 0; i < 2; ++i)
                        if (Creature* guard = _instance->instance->GetCreature(_instance->GetGuidData(DATA_GUARD_1_GUID + i)))
                            guard->ClearEmoteState();

                    for (ObjectGuid const& guid : _summons)
                        if (Creature* summon = _instance->instance->GetCreature(guid))
                        {
                            if (summon->IsAlive())
                            {
                                if (summon->GetEntry() == NPC_KALIRA || summon->GetEntry() == NPC_ELANDRA || summon->GetEntry() == NPC_LORALEN || summon->GetEntry() == NPC_KORELN)
                                    continue;

                                Unit::Kill(summon, summon, false);
                            }
                            summon->DespawnOrUnsummon(10s);
                        }
                    _instance->SetData(DATA_INSTANCE_PROGRESS, INSTANCE_PROGRESS_FINISHED_INTRO);

                    events.RescheduleEvent(EVENT_INTRO_LEADER_4, 5s);
                    break;
                case EVENT_INTRO_LEADER_4:
                    me->setActive(false);
                    Talk(me->GetEntry() == NPC_JAINA_PART1 ? SAY_JAINA_INTRO_5 : SAY_SYLVANAS_INTRO_4);

                    break;
                default:
                    break;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

        void JustSummoned(Creature* summon) override
        {
            _summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            _summons.Despawn(summon);
        }

        void AttackStart(Unit* /*who*/) override {}
        void MoveInLineOfSight(Unit* /*who*/) override {}

    private:
        SummonList _summons;
        InstanceScript* _instance;
        uint8 _counter;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_leaderAI>(creature);
    }
};

class npc_pos_deathwhisper_necrolyte : public CreatureScript
{
public:
    npc_pos_deathwhisper_necrolyte() : CreatureScript("npc_pos_deathwhisper_necrolyte") { }

    struct npc_pos_deathwhisper_necrolyteAI : public ScriptedAI
    {
        npc_pos_deathwhisper_necrolyteAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = me->GetInstanceScript();
            _isInvincible = false;
        }

        void Reset() override
        {
            events.Reset();
        }

        void InitializeAI() override
        {
            if (_instance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_NONE)
            {
                if ((me->GetPositionX() > 490.0f && me->GetPositionX() < 504.0f && me->GetPositionY() > 192.0f && me->GetPositionY() < 206.0f) ||
                        (me->GetPositionX() > 490.0f && me->GetPositionX() < 504.0f && me->GetPositionY() > 240.0f && me->GetPositionY() < 254.0f))
                {
                    _isInvincible = true;

                    me->CastSpell(me, SPELL_NECROLYTE_CHANNELING, false);

                    if (me->GetPositionY() < 206.0f)
                        _instance->SetGuidData(DATA_NECROLYTE_1_GUID, me->GetGUID());
                    else
                        _instance->SetGuidData(DATA_NECROLYTE_2_GUID, me->GetGUID());
                }
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_NECROLYTE_POSITION)
                me->SetFacingTo(M_PI);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            me->RemoveAura(SPELL_NECROLYTE_CHANNELING);
            events.Reset();
            events.RescheduleEvent(EVENT_NECROLYTE_SHADOW_BOLT, 0ms);
            events.RescheduleEvent(EVENT_NECROLYTE_CONVERSION_BEAM, 5s, 9s);

            if (Creature* leader = _instance->instance->GetCreature(_instance->GetGuidData(DATA_LEADER_FIRST_GUID)))
                leader->AI()->SetData(DATA_START_INTRO, 0);
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_isInvincible && damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_REMOVE_INVINCIBILITY)
                _isInvincible = false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_NECROLYTE_SHADOW_BOLT:
                    DoCastVictim(SPELL_NECROLYTE_SHADOW_BOLT);
                    events.Repeat(4s);
                    break;
                case EVENT_NECROLYTE_CONVERSION_BEAM:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                        DoCast(target, SPELL_CONVERSION_BEAM);
                    events.Repeat(20s, 25s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

    private:
        InstanceScript* _instance;
        bool _isInvincible;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_deathwhisper_necrolyteAI>(creature);
    }
};

class npc_pos_after_first_boss : public CreatureScript
{
public:
    npc_pos_after_first_boss() : CreatureScript("npc_pos_after_first_boss") { }

    struct npc_pos_after_first_bossAI : public NullCreatureAI
    {
        npc_pos_after_first_bossAI(Creature* creature) : NullCreatureAI(creature)
        {
            _instance = me->GetInstanceScript();
            me->GetMotionMaster()->MovePoint(POINT_FBS_GARFROST, 695.03f, -149.86f, 527.89f);
        }

        void Reset() override
        {
            events.Reset();
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_FBS_GARFROST)
                events.RescheduleEvent(EVENT_FBS_SUMMON_SLAVES, 0ms);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_FBS_SUMMON_SLAVES:
                    {
                        if (Creature* garfrost = _instance->instance->GetCreature(_instance->GetGuidData(DATA_GARFROST_GUID)))
                        {
                            float angle = garfrost->GetAngle(me);
                            float x = garfrost->GetPositionX() + std::cos(angle) * 12.0f;
                            float y = garfrost->GetPositionY() + std::sin(angle) * 12.0f;
                            me->GetMotionMaster()->MovePoint(2, x, y, garfrost->GetPositionZ());
                        }

                        uint8 i = 0;
                        while (FBSData[i].Entry)
                        {
                            if (Creature* slave = me->SummonCreature(FBSData[i].Entry, 688.69f + i * 1.8f, FBSSpawnPos.GetPositionY() + (float)irand(-2, 2), FBSSpawnPos.GetPositionZ(), 3 * M_PI / 2))
                                slave->GetMotionMaster()->MoveWaypoint(FBSData[i].PathId, false);
                            ++i;
                        }
                        events.RescheduleEvent(EVENT_FBS_TYRANNUS, 3s);
                        break;
                    }
                case EVENT_FBS_TYRANNUS:
                    if (Creature* voice = me->SummonCreature(NPC_TYRANNUS_VOICE, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() - 10.0f, me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 1))
                        voice->AI()->Talk(SAY_TYRANNUS_GARFROST);

                    events.RescheduleEvent(EVENT_FBS_GENERAL, 4s);
                    break;
                case EVENT_FBS_GENERAL:
                    Talk(SAY_GENERAL_GARFROST);

                    break;
                default:
                    break;
            }
        }

    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_after_first_bossAI>(creature);
    }
};

class npc_pos_tyrannus_events : public CreatureScript
{
public:
    npc_pos_tyrannus_events() : CreatureScript("npc_pos_tyrannus_events") { }

    struct npc_pos_tyrannus_eventsAI : public NullCreatureAI
    {
        npc_pos_tyrannus_eventsAI(Creature* creature) : NullCreatureAI(creature)
        {
            _instance = me->GetInstanceScript();
            _killsLeft = 0;
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE)
            {
                switch (id)
                {
                    case POINT_TYRANNUS_INTRO_END:
                        me->setActive(false);
                        break;
                    case POINT_TYRANNUS_KRICK_OUTRO_END:
                        events.ScheduleEvent(EVENT_TYRANNUS_MOVE_WAIT_1, 0ms);
                        break;
                    case POINT_TYRANNUS_WAIT_1:
                        events.ScheduleEvent(EVENT_TYRANNUS_FACE_WAIT_1, 0ms);
                        break;
                    case POINT_TYRANNUS_WAIT_2:
                        events.ScheduleEvent(EVENT_TYRANNUS_FACE_WAIT_2, 0ms);
                        break;
                    default:
                        break;
                }
            }
            else if (type == EFFECT_MOTION_TYPE && id == POINT_TYRANNUS_TAKEOFF)
                events.ScheduleEvent(EVENT_TYRANNUS_MOVE_WAIT_3, 0ms);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (!me->IsAlive() || _instance->GetData(DATA_GARFROST) != DONE || _instance->GetData(DATA_ICK) != DONE)
                return;
            if (type == DATA_TRASH_KILLED)
            {
                if (data == TRASH_KILLED && _killsLeft)
                    --_killsLeft;
                return;
            }
            if (type != DATA_AREATRIGGER)
                return;
            switch (data)
            {
                case AREATRIGGER_AMBUSH_1:
                    if (_instance->GetData(DATA_INSTANCE_PROGRESS) != INSTANCE_PROGRESS_FINISHED_KRICK_SCENE)
                        return;
                    if (me->GetExactDist(&PTSTyrannusWaitPos1) > 3.0f)
                        return;
                    _instance->SetData(DATA_INSTANCE_PROGRESS, INSTANCE_PROGRESS_AFTER_WARN_1);
                    Talk(SAY_TYRANNUS_AMBUSH_1);
                    _killsLeft = 10;
                    events.ScheduleEvent(EVENT_AMBUSH_1_SUMMON_DEATHBRINGERS, 0ms);
                    events.ScheduleEvent(EVENT_TYRANNUS_MOVE_WAIT_2, 25s);
                    break;
                case AREATRIGGER_AMBUSH_2:
                    if (_instance->GetData(DATA_INSTANCE_PROGRESS) != INSTANCE_PROGRESS_AFTER_WARN_1)
                        return;
                    if (_killsLeft != 0)
                        return;
                    _instance->SetData(DATA_INSTANCE_PROGRESS, INSTANCE_PROGRESS_AFTER_WARN_2);
                    Talk(SAY_TYRANNUS_AMBUSH_2);
                    _killsLeft = me->GetMap()->IsHeroic() ? 12 : 6;
                    events.ScheduleEvent(EVENT_AMBUSH_2_SUMMON, 0ms);
                    events.ScheduleEvent(EVENT_TYRANNUS_TAKEOFF, 20s);
                    break;
                case AREATRIGGER_TUNNEL:
                    if (_instance->GetData(DATA_INSTANCE_PROGRESS) != INSTANCE_PROGRESS_AFTER_WARN_2)
                        return;
                    if (_killsLeft != 0)
                        return;
                    _instance->SetData(DATA_INSTANCE_PROGRESS, INSTANCE_PROGRESS_AFTER_TUNNEL_WARN);
                    if (Creature* voice = me->SummonCreature(NPC_TYRANNUS_VOICE, 950.16f, -102.17f, 594.90f - 10.0f, 5.43f, TEMPSUMMON_TIMED_DESPAWN, 1))
                        voice->AI()->Talk(SAY_TYRANNUS_TRAP_TUNNEL);
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_TYRANNUS_MOVE_WAIT_1:
                    me->GetMotionMaster()->MovePoint(POINT_TYRANNUS_WAIT_1, PTSTyrannusWaitPos1, FORCED_MOVEMENT_NONE, 0.f, false);
                    break;
                case EVENT_TYRANNUS_FACE_WAIT_1:
                    me->SetFacingTo(PTSTyrannusWaitPos1.GetOrientation());
                    me->setActive(false);
                    break;
                case EVENT_TYRANNUS_MOVE_WAIT_2:
                    me->GetMotionMaster()->MovePoint(POINT_TYRANNUS_WAIT_2, PTSTyrannusWaitPos2, FORCED_MOVEMENT_NONE, 0.f, false);
                    break;
                case EVENT_TYRANNUS_FACE_WAIT_2:
                    me->SetFacingTo(PTSTyrannusWaitPos2.GetOrientation());
                    break;
                case EVENT_TYRANNUS_TAKEOFF:
                    me->GetMotionMaster()->MoveTakeoff(POINT_TYRANNUS_TAKEOFF, me->GetPositionX() + 2.0f * std::cos(me->GetOrientation()), me->GetPositionY() + 2.0f * std::sin(me->GetOrientation()), me->GetPositionZ() + 30.0f, 7.0f);
                    break;
                case EVENT_TYRANNUS_MOVE_WAIT_3:
                    me->GetMotionMaster()->MovePoint(POINT_TYRANNUS_WAIT_3, PTSTyrannusWaitPos3, FORCED_MOVEMENT_NONE, 0.f, false);
                    break;
                case EVENT_AMBUSH_1_SUMMON_DEATHBRINGERS:
                    {
                        Movement::PointsArray path;
                        path.push_back(G3D::Vector3(950.61f, 50.91f, 567.85f));
                        path.push_back(G3D::Vector3(946.48f, 73.25f, 565.89f));
                        path.push_back(G3D::Vector3(934.87f, 78.56f, 563.97f));
                        path.push_back(G3D::Vector3(915.10f, 75.31f, 553.81f));
                        if (Creature* deathbringer = me->SummonCreature(NPC_YMIRJAR_DEATHBRINGER, 950.61f, 50.91f, 567.85f, 1.82f))
                        {
                            _deathbringerGUID[0] = deathbringer->GetGUID();
                            deathbringer->SetReactState(REACT_PASSIVE);
                            deathbringer->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            deathbringer->SetHomePosition(915.10f, 75.31f, 553.81f, 3.75f);
                            deathbringer->SetWalk(false);
                            deathbringer->GetMotionMaster()->MoveSplinePath(&path);
                        }
                        if (Creature* deathbringer = me->SummonCreature(NPC_YMIRJAR_DEATHBRINGER, 949.05f, 61.18f, 566.60f, 1.73f))
                        {
                            _deathbringerGUID[1] = deathbringer->GetGUID();
                            deathbringer->SetReactState(REACT_PASSIVE);
                            deathbringer->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            deathbringer->SetHomePosition(883.15f, 54.6254f, 528.5f, 3.75f);
                            deathbringer->SetWalk(false);
                            path.push_back(G3D::Vector3(883.15f, 54.6254f, 528.5f));
                            deathbringer->GetMotionMaster()->MoveSplinePath(&path);
                        }
                        events.ScheduleEvent(EVENT_AMBUSH_1_DEATHBRINGER_1_ARRIVED, 500ms);
                        events.ScheduleEvent(EVENT_AMBUSH_1_DEATHBRINGER_2_ARRIVED, 500ms);
                    }
                    break;
                case EVENT_AMBUSH_1_DEATHBRINGER_1_ARRIVED:
                    if (Creature* deathbringer = _instance->instance->GetCreature(_deathbringerGUID[0]))
                        if (deathbringer->GetMotionMaster()->GetCurrentMovementGeneratorType() != ESCORT_MOTION_TYPE)
                        {
                            deathbringer->CastSpell(deathbringer, SPELL_SUMMON_UNDEAD, false);
                            events.ScheduleEvent(EVENT_AMBUSH_1_SUMMON_WAVE_1, 3s);
                            break;
                        }
                    events.ScheduleEvent(EVENT_AMBUSH_1_DEATHBRINGER_1_ARRIVED, 500ms);
                    break;
                case EVENT_AMBUSH_1_DEATHBRINGER_2_ARRIVED:
                    if (Creature* deathbringer = _instance->instance->GetCreature(_deathbringerGUID[1]))
                        if (deathbringer->GetMotionMaster()->GetCurrentMovementGeneratorType() != ESCORT_MOTION_TYPE)
                        {
                            deathbringer->CastSpell(deathbringer, SPELL_SUMMON_UNDEAD, false);
                            events.ScheduleEvent(EVENT_AMBUSH_1_SUMMON_WAVE_2, 3s);
                            break;
                        }
                    events.ScheduleEvent(EVENT_AMBUSH_1_DEATHBRINGER_2_ARRIVED, 500ms);
                    break;
                case EVENT_AMBUSH_1_SUMMON_WAVE_1:
                    me->SummonCreature(NPC_YMIRJAR_WRATHBRINGER, 919.733f, 89.0972f, 558.959f, 3.85718f);
                    me->SummonCreature(NPC_YMIRJAR_WRATHBRINGER, 911.936f, 63.3542f, 547.698f, 3.735f);
                    me->SummonCreature(NPC_YMIRJAR_FLAMEBEARER, 909.356f, 83.1684f, 551.717f, 3.57792f);
                    me->SummonCreature(NPC_YMIRJAR_FLAMEBEARER, 920.946f, 69.1667f, 557.594f, 3.1765f);
                    events.ScheduleEvent(EVENT_AMBUSH_1_ACTIVATE_DEATHBRINGER_1, 3500ms);
                    break;
                case EVENT_AMBUSH_1_SUMMON_WAVE_2:
                    me->SummonCreature(NPC_YMIRJAR_WRATHBRINGER, 879.464f, 41.1997f, 521.394f, 3.735f);
                    me->SummonCreature(NPC_YMIRJAR_WRATHBRINGER, 885.715f, 65.5156f, 533.631f, 3.85718f);
                    me->SummonCreature(NPC_YMIRJAR_FLAMEBEARER, 876.884f, 61.0139f, 527.715f, 3.57792f);
                    me->SummonCreature(NPC_YMIRJAR_FLAMEBEARER, 889.49f, 45.2865f, 527.233f, 3.97935f);
                    events.ScheduleEvent(EVENT_AMBUSH_1_ACTIVATE_DEATHBRINGER_2, 3500ms);
                    break;
                case EVENT_AMBUSH_1_ACTIVATE_DEATHBRINGER_1:
                    if (Creature* deathbringer = _instance->instance->GetCreature(_deathbringerGUID[0]))
                    {
                        deathbringer->SetReactState(REACT_AGGRESSIVE);
                        deathbringer->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                    break;
                case EVENT_AMBUSH_1_ACTIVATE_DEATHBRINGER_2:
                    if (Creature* deathbringer = _instance->instance->GetCreature(_deathbringerGUID[1]))
                    {
                        deathbringer->SetReactState(REACT_AGGRESSIVE);
                        deathbringer->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                    break;
                case EVENT_AMBUSH_2_SUMMON:
                    {
                        Position const startPos[6] = { {927.11f, -72.60f, 592.2f, 1.52f}, {922.92f, -72.64f, 592.3f, 1.52f}, {930.46f, -72.57f, 592.1f, 1.52f}, {934.52f, -72.52f, 592.1f, 1.52f}, {934.57f, -77.66f, 592.20f, 1.52f}, {927.15f, -77.07f, 592.20f, 1.52f} };
                        Position const endPos = {926.10f, -46.63f, 591.2f, 1.52f};
                        for (uint8 i = 0; i < 6; ++i)
                            if (Creature* summon = me->SummonCreature(i < 4 ? NPC_FALLEN_WARRIOR : NPC_WRATHBONE_COLDWRAITH, startPos[i]))
                            {
                                summon->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                Position finalPos = endPos;
                                summon->MovePosition(finalPos, startPos[i].GetExactDist(&startPos[0]), Position::NormalizeOrientation(startPos[i].GetAngle(&startPos[0]) + 1.52f));

                                Movement::PointsArray path;
                                path.push_back(G3D::Vector3(summon->GetPositionX(), summon->GetPositionY(), summon->GetPositionZ()));
                                path.push_back(G3D::Vector3(finalPos.GetPositionX(), finalPos.GetPositionY(), finalPos.GetPositionZ()));

                                summon->SetHomePosition(finalPos);
                                summon->GetMotionMaster()->MoveSplinePath(&path);
                            }

                        if (me->GetMap()->IsHeroic())
                        {
                            Position const heroicStartPos[6] = { {925.485f, -65.67f, 592.5f, 1.4f}, {921.77f, -65.10f, 592.5f, 1.4f}, {929.19f, -66.24f, 592.5f, 1.4f}, {932.46f, -66.74f, 592.5f, 1.4f}, {924.66f, -71.03f, 592.5f, 1.4f}, {928.81f, -71.66f, 592.5f, 1.4f} };
                            Position const heroicMiddlePos = {928.43f, -29.31f, 589.0f, 1.4f};
                            Position const heroicEndPos = {937.8f, 21.20f, 574.6f, 1.4f};
                            for (uint8 i = 0; i < 6; ++i)
                                if (Creature* summon = me->SummonCreature(i < 4 ? NPC_FALLEN_WARRIOR : NPC_WRATHBONE_COLDWRAITH, heroicStartPos[i]))
                                {
                                    summon->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                    Position midPos = heroicMiddlePos;
                                    Position finalPos = heroicEndPos;
                                    summon->MovePosition(midPos, heroicStartPos[i].GetExactDist(&heroicStartPos[0]), Position::NormalizeOrientation(heroicStartPos[i].GetAngle(&heroicStartPos[0]) + 1.4f));
                                    summon->MovePosition(finalPos, heroicStartPos[i].GetExactDist(&heroicStartPos[0]), Position::NormalizeOrientation(heroicStartPos[i].GetAngle(&heroicStartPos[0]) + 1.4f));

                                    Movement::PointsArray path;
                                    path.push_back(G3D::Vector3(summon->GetPositionX(), summon->GetPositionY(), summon->GetPositionZ()));
                                    path.push_back(G3D::Vector3(midPos.GetPositionX(), midPos.GetPositionY(), midPos.GetPositionZ()));
                                    path.push_back(G3D::Vector3(finalPos.GetPositionX(), finalPos.GetPositionY(), finalPos.GetPositionZ()));

                                    summon->SetHomePosition(finalPos);
                                    summon->GetMotionMaster()->MoveSplinePath(&path);
                                }
                        }
                    }
                    break;
                default:
                    break;
            }
        }

    private:
        InstanceScript* _instance;
        uint32 _killsLeft;
        ObjectGuid _deathbringerGUID[2];
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_tyrannus_eventsAI>(creature);
    }
};

class npc_pos_icicle_trigger : public CreatureScript
{
public:
    npc_pos_icicle_trigger() : CreatureScript("npc_pos_icicle_trigger") { }

    struct npc_pos_icicle_triggerAI : public NullCreatureAI
    {
        npc_pos_icicle_triggerAI(Creature* creature) : NullCreatureAI(creature)
        {
            _instance = me->GetInstanceScript();

            scheduler.Schedule(0ms, 16s, [this](TaskContext context)
            {
                if (_instance->GetData(DATA_INSTANCE_PROGRESS) == INSTANCE_PROGRESS_AFTER_TUNNEL_WARN)
                    me->CastSpell(me, SPELL_TUNNEL_ICICLE, false);
                context.Repeat(16s, 24s);
            });
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);
        }

    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_icicle_triggerAI>(creature);
    }
};

class npc_pos_collapsing_icicle : public CreatureScript
{
public:
    npc_pos_collapsing_icicle() : CreatureScript("npc_pos_collapsing_icicle") { }

    struct npc_pos_collapsing_icicleAI : public NullCreatureAI
    {
        npc_pos_collapsing_icicleAI(Creature* creature) : NullCreatureAI(creature)
        {
            _instance = me->GetInstanceScript();

            scheduler.Schedule(2500ms, [this](TaskContext context)
            {
                DoCastSelf(SPELL_ICICLE_DUMMY);
                DoCastSelf(SPELL_ICICLE, true);
                context.Repeat(60s);
            }).Schedule(7s, [this](TaskContext context)
            {
                me->SetDisplayId(MODEL_INVISIBLE);
                context.Repeat(60s);
            });
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (target && spell && target->IsPlayer() && spell->Id == SPELL_ICE_SHARDS_H)
                _instance->SetData(DATA_ACHIEV_DONT_LOOK_UP, 0);
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);
        }

    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_collapsing_icicleAI>(creature);
    }
};

class npc_pos_martin_or_gorkun_second : public CreatureScript
{
public:
    npc_pos_martin_or_gorkun_second() : CreatureScript("npc_pos_martin_or_gorkun_second") { }

    struct npc_pos_martin_or_gorkun_secondAI : public NullCreatureAI
    {
        npc_pos_martin_or_gorkun_secondAI(Creature* creature) : NullCreatureAI(creature), _summons(me)
        {
            _instance = me->GetInstanceScript();
            me->SetEmoteState(EMOTE_STATE_READY1H);
            _summonIndex = 0;
            events.Reset();
            events.RescheduleEvent(EVENT_GENERAL_SUMMON_SLAVES, 500ms);
            events.RescheduleEvent(EVENT_GENERAL_TRASH_TALK, 15s);

            if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_GUID)))
            {
                tyrannus->AI()->Talk(SAY_BOSS_TYRANNUS_INTRO_1);
                tyrannus->SetImmuneToPC(false);
                tyrannus->SetReactState(REACT_AGGRESSIVE);
                if (Player* player = tyrannus->SelectNearestPlayer(100.0f))
                {
                    tyrannus->AI()->AttackStart(player);
                    DoZoneInCombat(tyrannus);
                }
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_GENERAL_CENTER)
                events.RescheduleEvent(EVENT_GENERAL_OUTRO, 1s);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_DESPAWN_SUMMONS)
                _summons.DespawnAll();
            else if (action == ACTION_START_OUTRO)
            {
                events.Reset();
                _summons.DespawnEntry(NPC_FALLEN_WARRIOR);

                me->ClearEmoteState();
                me->GetMotionMaster()->MovePoint(POINT_GENERAL_CENTER, TSCenterPos);

                for (ObjectGuid const& guid : _summons)
                    if (Creature* slave = _instance->instance->GetCreature(guid))
                    {
                        slave->SetEmoteState(EMOTE_ONESHOT_CHEER);
                        float angle = frand(1.92f, 2.36f);
                        float dist = urand(50, 85);
                        slave->GetMotionMaster()->MovePoint(0, TSSpawnPos.GetPositionX() + std::cos(angle) * dist, TSSpawnPos.GetPositionY() + std::sin(angle) * dist, 628.2f);
                    }
            }
            else if (action == ACTION_FROST_BOMB_KILL)
            {
                if (Creature* sindragosa = _instance->instance->GetCreature(_instance->GetGuidData(DATA_SINDRAGOSA_GUID)))
                {
                    for (ObjectGuid const& guid : _summons)
                        if (Creature* summon = _instance->instance->GetCreature(guid))
                            if (summon->IsAlive())
                                Unit::Kill(sindragosa, summon);
                    if (me->IsAlive())
                        Unit::Kill(sindragosa, me);
                }
            }
        }

        void JustSummoned(Creature* summon) override
        {
            _summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) override
        {
            _summons.Despawn(summon);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_GENERAL_SUMMON_SLAVES:
                    if (TSData[_summonIndex].Entry)
                    {
                        if (Creature* slave = me->SummonCreature(TSData[_summonIndex].Entry, TSSpawnPos))
                        {
                            slave->SetEmoteState(EMOTE_STATE_READY1H);
                            slave->GetMotionMaster()->MovePoint(0, TSData[_summonIndex].X, TSData[_summonIndex].Y, TSHeight);
                        }
                        ++_summonIndex;
                        events.ScheduleEvent(EVENT_GENERAL_SUMMON_SLAVES, 150ms);
                    }
                    break;
                case EVENT_GENERAL_TRASH_TALK:
                    Talk(me->GetEntry() == NPC_MARTIN_VICTUS_2 ? SAY_GENERAL_ALLIANCE_TRASH : SAY_GENERAL_HORDE_TRASH);
                    events.RescheduleEvent(EVENT_GENERAL_TYRANNUS_INTRO, 8s);
                    break;
                case EVENT_GENERAL_TYRANNUS_INTRO:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_GUID)))
                        tyrannus->AI()->Talk(SAY_BOSS_TYRANNUS_INTRO_2);

                    me->SetFacingTo(5.26f);
                    me->SetOrientation(5.26f);
                    me->SetHomePosition(*me);
                    for (ObjectGuid const& guid : _summons)
                        if (Creature* slave = _instance->instance->GetCreature(guid))
                        {
                            slave->SetFacingTo(5.26f);
                            slave->SetOrientation(5.26f);
                            slave->SetHomePosition(*slave);
                        }
                    events.RescheduleEvent(EVENT_GENERAL_SUMMON_FALLEN_WARRIOR, 15s);

                    events.RescheduleEvent(EVENT_GENERAL_START_FIGHT, 15s);
                    break;
                case EVENT_GENERAL_START_FIGHT:
                    if (Creature* tyrannus = _instance->instance->GetCreature(_instance->GetGuidData(DATA_TYRANNUS_GUID)))
                        tyrannus->AI()->DoAction(ACTION_START_TYRANNUS_FIGHT);
                    break;
                case EVENT_GENERAL_OUTRO:
                    me->SetFacingTo(TSCenterPos.GetOrientation());
                    Talk(me->GetEntry() == NPC_MARTIN_VICTUS_2 ? SAY_GENERAL_ALLIANCE_OUTRO_1 : SAY_GENERAL_HORDE_OUTRO_1);
                    if (Creature* leader = _instance->instance->GetCreature(_instance->GetGuidData(DATA_LEADER_SECOND_GUID)))
                        leader->AI()->DoAction(ACTION_SUMMON_SINDRAGOSA);
                    break;
                case EVENT_GENERAL_SUMMON_FALLEN_WARRIOR:
                    if (_summons.GetEntryCount(NPC_FALLEN_WARRIOR) < 3)
                        if (Creature* warrior = me->SummonCreature(NPC_FALLEN_WARRIOR, 1060.95f, 102.79f, 630.2f, 2.01f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
                        {
                            float offset = frand(0.0f, 10.0f);
                            warrior->GetMotionMaster()->MovePoint(0, 1047.0f + offset, 118.0f + offset, 628.2f);
                            warrior->SetHomePosition(*me);
                            for (ObjectGuid const& guid : _summons)
                                if (Creature* summon = _instance->instance->GetCreature(guid))
                                {
                                    if (summon->GetEntry() == NPC_FALLEN_WARRIOR)
                                        continue;
                                    warrior->SetInCombatWith(summon);
                                    summon->SetInCombatWith(warrior);
                                    warrior->AddThreat(summon, 0.0f);
                                    summon->AddThreat(warrior, 0.0f);
                                }
                        }
                    events.RescheduleEvent(EVENT_GENERAL_SUMMON_FALLEN_WARRIOR, 3s);
                    break;
                default:
                    break;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* _instance;
        SummonList _summons;
        uint8 _summonIndex;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_martin_or_gorkun_secondAI>(creature);
    }
};

class npc_pos_freed_slave : public CreatureScript
{
public:
    npc_pos_freed_slave() : CreatureScript("npc_pos_freed_slave") { }

    struct npc_pos_freed_slaveAI : public SmartAI
    {
        npc_pos_freed_slaveAI(Creature* creature) : SmartAI(creature)
        {
            me->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);
            // immune to falling icicles
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_ICE_SHARDS, true);
            me->ApplySpellImmune(0, IMMUNITY_ID, SPELL_ICE_SHARDS_H, true);
        }

        bool CanAIAttack(Unit const* who) const override
        {
            return who->GetEntry() == NPC_FALLEN_WARRIOR;
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (!me->IsAlive() || me->IsInEvadeMode())
                return;

            me->RemoveEvadeAuras();
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->LoadCreaturesAddon(true);
            me->SetLootRecipient(nullptr);
            me->ResetPlayerDamageReq();
            me->ClearLastLeashExtensionTimePtr();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_freed_slaveAI>(creature);
    }
};

class npc_pos_leader_second : public CreatureScript
{
public:
    npc_pos_leader_second() : CreatureScript("npc_pos_leader_second") { }

    struct npc_pos_leader_secondAI : public NullCreatureAI
    {
        npc_pos_leader_secondAI(Creature* creature) : NullCreatureAI(creature)
        {
            _instance = me->GetInstanceScript();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);

            if (Creature* rimefang = _instance->instance->GetCreature(_instance->GetGuidData(DATA_RIMEFANG_GUID)))
            {
                rimefang->RemoveAllAuras();
                rimefang->GetMotionMaster()->Clear();
                rimefang->GetMotionMaster()->MoveIdle();
                rimefang->SetVisible(false);
            }
            if (Creature* general = _instance->instance->GetCreature(_instance->GetGuidData(DATA_MARTIN_OR_GORKUN_GUID)))
                general->AI()->DoAction(ACTION_START_OUTRO);
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_SUMMON_SINDRAGOSA)
            {
                events.RescheduleEvent(EVENT_LEADER_OUTRO_SUMMON_SINDRAGOSA, me->GetEntry() == NPC_JAINA_PART2 ? 15s + 500ms : 18s);
                events.RescheduleEvent(EVENT_LEADER_OUTRO_GENERAL_2, me->GetEntry() == NPC_JAINA_PART2 ? 16s + 500ms : 19s);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if ((spell->Id == SPELL_TELEPORT_JAINA || spell->Id == SPELL_TELEPORT_SYLVANAS) && target && target->IsPlayer())
            {
                float angle = rand_norm() * 2 * M_PI;
                float dist = urand(1, 4);
                target->ToPlayer()->NearTeleportTo(me->GetPositionX() + std::cos(angle) * dist, me->GetPositionY() + std::sin(angle) * dist, me->GetPositionZ(), me->GetOrientation());
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != WAYPOINT_MOTION_TYPE)
                return;

            switch (id)
            {
                case POINT_LEADER_OUTRO_2:
                    Talk(me->GetEntry() == NPC_JAINA_PART2 ? SAY_JAINA_OUTRO_2 : SAY_SYLVANAS_OUTRO_2);
                    break;
                case POINT_JAINA_OUTRO_3:
                    if (me->GetEntry() == NPC_JAINA_PART2)
                        Talk(SAY_JAINA_OUTRO_3);
                    break;
                case POINT_OPEN_PORTCULLIS:
                    me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                    if (GameObject* portcullis = me->FindNearestGameObject(GO_HOR_PORTCULLIS, 50.0f))
                        portcullis->SetGoState(GO_STATE_ACTIVE);
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_LEADER_OUTRO_SUMMON_SINDRAGOSA:
                    if (Creature* sindragosa = me->SummonCreature(NPC_SINDRAGOSA, TSSindragosaPos1))
                    {
                        sindragosa->SetCanFly(true);
                        sindragosa->SetDisableGravity(true);
                        sindragosa->GetMotionMaster()->MovePoint(0, TSSindragosaPos2);
                    }

                    break;
                case EVENT_LEADER_OUTRO_GENERAL_2:
                    if (Creature* general = _instance->instance->GetCreature(_instance->GetGuidData(DATA_MARTIN_OR_GORKUN_GUID)))
                        general->AI()->Talk(SAY_GENERAL_OUTRO_2);

                    events.RescheduleEvent(EVENT_LEADER_OUTRO_LEADER_1, me->GetEntry() == NPC_JAINA_PART2 ? 7s : 8s);
                    break;
                case EVENT_LEADER_OUTRO_LEADER_1:
                    Talk(me->GetEntry() == NPC_JAINA_PART2 ? SAY_JAINA_OUTRO_1 : SAY_SYLVANAS_OUTRO_1);
                    DoCastSelf(me->GetEntry() == NPC_JAINA_PART2 ? SPELL_TELEPORT_JAINA_VISUAL : SPELL_TELEPORT_SYLVANAS_VISUAL, true);

                    events.RescheduleEvent(EVENT_LEADER_OUTRO_TELEPORT, 2s);
                    break;
                case EVENT_LEADER_OUTRO_TELEPORT:
                    DoCastSelf(me->GetEntry() == NPC_JAINA_PART2 ? SPELL_TELEPORT_JAINA : SPELL_TELEPORT_SYLVANAS, true);
                    if (GameObject* barrier = me->SummonGameObject(GO_FIRE_FIELD, 1055.49f, 115.03f, 628.15f, 2.08f, 0.0f, 0.0f, 0.0f, 0.0f, 86400, false))
                        _barrierGUID = barrier->GetGUID();

                    events.RescheduleEvent(EVENT_LEADER_OUTRO_FROST_BOMB, 1500ms);
                    break;
                case EVENT_LEADER_OUTRO_FROST_BOMB:
                    if (Creature* general = _instance->instance->GetCreature(_instance->GetGuidData(DATA_MARTIN_OR_GORKUN_GUID)))
                    {
                        if (Creature* sindragosa = _instance->instance->GetCreature(_instance->GetGuidData(DATA_SINDRAGOSA_GUID)))
                            sindragosa->CastSpell(general->GetPositionX(), general->GetPositionY(), general->GetPositionZ(), SPELL_SINDRAGOSA_FROST_BOMB_POS, true);
                    }

                    events.RescheduleEvent(EVENT_LEADER_OUTRO_SINDRAGOSA_LEAVE, 5s);
                    events.RescheduleEvent(EVENT_LEADER_OUTRO_FROST_BOMB_KILL, 2s);
                    break;
                case EVENT_LEADER_OUTRO_SINDRAGOSA_LEAVE:
                    if (Creature* sindragosa = _instance->instance->GetCreature(_instance->GetGuidData(DATA_SINDRAGOSA_GUID)))
                        sindragosa->GetMotionMaster()->MovePoint(0, TSSindragosaPos1);

                    events.RescheduleEvent(EVENT_LEADER_OUTRO_SINDRAGOSA_HIDE, 4500ms);
                    break;
                case EVENT_LEADER_OUTRO_SINDRAGOSA_HIDE:
                    if (Creature* sindragosa = _instance->instance->GetCreature(_instance->GetGuidData(DATA_SINDRAGOSA_GUID)))
                        sindragosa->SetVisible(false);
                    if (GameObject* barrier = _instance->instance->GetGameObject(_barrierGUID))
                        barrier->Delete();
                    _barrierGUID.Clear();

                    events.RescheduleEvent(EVENT_LEADER_OUTRO_LEADER_MOVE, 2s);
                    break;
                case EVENT_LEADER_OUTRO_LEADER_MOVE:
                    me->GetMotionMaster()->MoveWaypoint(me->GetEntry() == NPC_JAINA_PART2 ? PATH_JAINA_OUTRO : PATH_SYLVANAS_OUTRO, false);
                    break;
                case EVENT_LEADER_OUTRO_FROST_BOMB_KILL:
                    if (Creature* general = _instance->instance->GetCreature(_instance->GetGuidData(DATA_MARTIN_OR_GORKUN_GUID)))
                        general->AI()->DoAction(ACTION_FROST_BOMB_KILL);

                    break;
                default:
                    break;
            }
        }

    private:
        InstanceScript* _instance;
        ObjectGuid _barrierGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetPitOfSaronAI<npc_pos_leader_secondAI>(creature);
    }
};

class spell_pos_empowered_blizzard_aura : public AuraScript
{
    PrepareAuraScript(spell_pos_empowered_blizzard_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EMPOWERED_BLIZZARD });
    }

    void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            caster->CastSpell((float)urand(447, 480), (float)urand(200, 235), 528.71f, SPELL_EMPOWERED_BLIZZARD, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_pos_empowered_blizzard_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

Position const SlaveFreePos[4] =
{
    {699.82f, -82.68f, 512.6f, 0.0f},
    {643.51f, 79.20f, 511.57f, 0.0f},
    {800.09f, 78.66f, 510.2f, 0.0f},
    {528.26f, 187.04f, 528.75f, 0.0f}
};

class SlaveRunEvent : public BasicEvent
{
public:
    SlaveRunEvent(Creature& owner) : _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        uint32 pointId = 0;
        float minDist = _owner.GetExactDist2dSq(&SlaveFreePos[pointId]);
        for (uint32 i = 1; i < 4; ++i)
        {
            float dist = _owner.GetExactDist2dSq(&SlaveFreePos[i]);
            if (dist < minDist)
            {
                minDist = dist;
                pointId = i;
            }
        }
        if (minDist < 200.0f * 200.0f)
            _owner.GetMotionMaster()->MovePoint(0, SlaveFreePos[pointId], FORCED_MOVEMENT_NONE, 0.f, true, false);
        return true;
    }

private:
    Creature& _owner;
};

class spell_pos_slave_trigger_closest : public SpellScript
{
    PrepareSpellScript(spell_pos_slave_trigger_closest);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (target->GetUInt32Value(UNIT_NPC_EMOTESTATE)) // prevent using multiple times
            {
                if (Unit* caster = GetCaster())
                    if (Player* player = caster->ToPlayer())
                    {
                        player->RewardPlayerAndGroupAtEvent(NPC_ALLIANCE_SLAVE_1, caster);
                        player->RewardPlayerAndGroupAtEvent(NPC_HORDE_SLAVE_1, caster);

                        target->ClearEmoteState();
                        if (Creature* slave = target->ToCreature())
                        {
                            slave->DespawnOrUnsummon(7s);
                            slave->AI()->Talk(SAY_SLAVE_FREED, player);
                            slave->m_Events.AddEventAtOffset(new SlaveRunEvent(*slave), 3s);
                        }
                    }
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pos_slave_trigger_closest::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_pos_rimefang_frost_nova : public SpellScript
{
    PrepareSpellScript(spell_pos_rimefang_frost_nova);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (Unit* caster = GetCaster())
            {
                Unit::Kill(caster, target);
                if (target->IsCreature())
                    target->ToCreature()->DespawnOrUnsummon(30s);
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_pos_rimefang_frost_nova::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_pos_blight_aura : public AuraScript
{
    PrepareAuraScript(spell_pos_blight_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BLIGHT });
    }

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (aurEff->GetTotalTicks() >= 0 && aurEff->GetTickNumber() == uint32(aurEff->GetTotalTicks()))
            if (Unit* target = GetTarget())
                target->CastSpell(target, SPELL_BLIGHT, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_pos_blight_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_pos_glacial_strike_aura : public AuraScript
{
    PrepareAuraScript(spell_pos_glacial_strike_aura);

    void HandleEffectPeriodic(AuraEffect const* aurEff)
    {
        if (Unit* target = GetTarget())
            if (target->GetHealth() == target->GetMaxHealth())
            {
                PreventDefaultAction();
                aurEff->GetBase()->Remove(AURA_REMOVE_BY_EXPIRE);
                return;
            }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_pos_glacial_strike_aura::HandleEffectPeriodic, EFFECT_2, SPELL_AURA_PERIODIC_DAMAGE_PERCENT);
    }
};

class at_tyrannus_event_starter : public AreaTriggerScript
{
public:
    at_tyrannus_event_starter() : AreaTriggerScript("at_tyrannus_event_starter") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        InstanceScript* instance = player->GetInstanceScript();
        if (!instance)
            return false;

        if (instance->GetData(DATA_INSTANCE_PROGRESS) < INSTANCE_PROGRESS_AFTER_TUNNEL_WARN)
            return false;

        if (instance->GetData(DATA_GARFROST) == DONE && instance->GetData(DATA_ICK) == DONE && instance->GetData(DATA_TYRANNUS) != DONE && !instance->GetGuidData(DATA_MARTIN_OR_GORKUN_GUID))
        {
            if (Creature* general = instance->instance->SummonCreature(NPC_GORKUN_IRONSKULL_2, TSSpawnPos))
                general->GetMotionMaster()->MovePoint(0, TSMidPos);

            instance->SetData(DATA_INSTANCE_PROGRESS, INSTANCE_PROGRESS_TYRANNUS_INTRO);
        }

        return false;
    }
};

void AddSC_pit_of_saron()
{
    new npc_pos_leader();
    new npc_pos_deathwhisper_necrolyte();
    new npc_pos_after_first_boss();
    new npc_pos_tyrannus_events();
    new npc_pos_icicle_trigger();
    new npc_pos_collapsing_icicle();
    new npc_pos_martin_or_gorkun_second();
    new npc_pos_freed_slave();
    new npc_pos_leader_second();

    RegisterSpellScript(spell_pos_empowered_blizzard_aura);
    RegisterSpellScript(spell_pos_slave_trigger_closest);
    RegisterSpellScript(spell_pos_rimefang_frost_nova);
    RegisterSpellScript(spell_pos_blight_aura);
    RegisterSpellScript(spell_pos_glacial_strike_aura);

    new at_tyrannus_event_starter();
}
