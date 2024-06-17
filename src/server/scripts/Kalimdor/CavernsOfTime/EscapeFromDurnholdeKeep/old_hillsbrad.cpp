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

#include "old_hillsbrad.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"

/*enum Erozion
{
    QUEST_ENTRY_HILLSBRAD   = 10282,
    QUEST_ENTRY_DIVERSION   = 10283,
    QUEST_ENTRY_ESCAPE      = 10284,
    QUEST_ENTRY_RETURN      = 10285,
    ITEM_ENTRY_BOMBS        = 25853
};
*/
enum Says
{
    SAY_START_EVENT_PART1           = 0,
    SAY_ARMORY                      = 1,
    SAY_SKARLOC_MEET                = 2,
    SAY_SKARLOC_TAUNT               = 3,
    SAY_START_EVENT_PART2           = 4,
    SAY_MOUNTS_UP                   = 5,
    SAY_CHURCH_END                  = 6,
    SAY_MEET_TARETHA                = 7,
    SAY_EPOCH_WONDER                = 8,
    SAY_EPOCH_KILL_TARETHA          = 9,
    SAY_EVENT_COMPLETE              = 10,
    SAY_RANDOM_LOW_HP               = 11,
    SAY_RANDOM_DIE                  = 12,
    SAY_RANDOM_AGGRO                = 13,
    SAY_RANDOM_KILL                 = 14,
    SAY_LEAVE_COMBAT                = 15,
    SAY_KILL_ARMORER                = 16,
    SAY_GO_ARMORED                  = 17,
    SAY_ENTER_CHURCH                = 18,
    SAY_GREET_TARETHA               = 19,
    SAY_CHAT_TARETHA1               = 20,
    SAY_EMOTE_HORSE                 = 21,
    SAY_EMOTE_HORSE_2               = 22,
    SAY_LEAD                        = 23,

    SAY_TARETHA_FREE                = 0,
    SAY_TARETHA_ESCAPED             = 1,
    SAY_TARETHA_TALK1               = 2,
    SAY_TARETHA_TALK2               = 3,

    SAY_ARMORER_THRALL              = 0,

    SAY_LOOKOUT_SAW                 = 0,
    SAY_LOOKOUT_GO                  = 1,
    SAY_LOOKOUT_CHURCH              = 2,
    SAY_LOOKOUT_INN                 = 3,

    SAY_EPOCH_ENTER1                = 0,
    SAY_EPOCH_ENTER2                = 1,
    SAY_EPOCH_ENTER3                = 2,

    SAY_EROZION_1                   = 0,
    SAY_EROZION_2                   = 1,
    SAY_EROZION_3                   = 2,
};

enum Spells
{
    SPELL_STRIKE                = 14516,
    SPELL_SHIELD_BLOCK          = 12169,
    SPELL_SUMMON_EROZION_IMAGE  = 33954,

    SPELL_SHADOW_PRISON         = 33071,
    SPELL_SHADOW_SPIKE          = 33125,

    SPELL_TELEPORT              = 34776,
    SPELL_MEMORY_WIPE           = 33336,
    SPELL_MEMORY_WIPE_RESUME    = 33337,
    SPELL_KNOCKOUT_ARMORER      = 32890,
    SPELL_SALVATION             = 33790,
    SPELL_DUMMY_AURA            = 22805
};

enum Npcs
{
    NPC_TM_GUARDSMAN            = 18092,
    NPC_TM_PROTECTOR            = 18093,
    NPC_TM_LOOKOUT              = 18094,

    NPC_EPOCH_GUARDSMAN         = 23175,
    NPC_EPOCH_PROTECTOR         = 23179,
    NPC_EPOCH_LOOKOUT           = 23177,

    NPC_INFINITE_DEFILER        = 18171,
    NPC_INFINITE_SABOTEUR       = 18172,
    NPC_INFINITE_SLAYER         = 18170
};

enum Misc
{
    THRALL_WEAPON_ITEM          = 927,
    THRALL_SHIELD_ITEM          = 2129,
    THRALL_MODEL_UNEQUIPPED     = 17292,
    THRALL_MODEL_EQUIPPED       = 18165,

    ACTION_SET_IMMUNE_FLAG      = 1,
    ACTION_REMOVE_IMMUNE_FLAG   = 2,
    ACTION_TRANSFORM            = 3,
    ACTION_MOVE                 = 4,
    ACTION_START_COMBAT         = 5
};

#define SPEED_RUNNING           1.0f
#define SPEED_MOUNTED           1.6f

enum Events
{
    // Combat
    EVENT_CHECK_HEALTH          = 1,
    EVENT_SPELL_STRIKE          = 2,
    EVENT_SPELL_SHIELD_BLOCK    = 3,

    EVENT_OPEN_DOORS            = 6,
    EVENT_START_WP              = 7,

    EVENT_SET_FACING            = 9,
    EVENT_ARMORER_SAY           = 10,
    EVENT_THRALL_EMOTE          = 11,
    EVENT_KILL_ARMORER          = 12,
    EVENT_TALK_KILL_ARMORER     = 13,

    EVENT_DRESSING_KNEEL        = 20,
    EVENT_DRESSING_ARMOR        = 21,
    EVENT_DRESSING_STAND        = 22,
    EVENT_DRESSING_AXE          = 23,
    EVENT_DRESSING_SHIELD       = 24,
    EVENT_DRESSING_TALK         = 25,

    EVENT_ENTER_MOUNT           = 30,
    EVENT_TALK_START_RIDE       = 31,

    EVENT_LOOK_1                = 40,
    EVENT_MOVE_AROUND           = 41,
    EVENT_LOOK_2                = 42,
    EVENT_SUMMON_GUARDS         = 43,
    EVENT_LOOK_3                = 44,
    EVENT_SUMMON_TALK1          = 45,
    EVENT_LOOK_4                = 46,
    EVENT_SUMMON_TALK2          = 47,
    EVENT_GUARDS_MOVING         = 48,

    EVENT_LOOK_5                = 50,
    EVENT_SUMMON_GUARDS_2       = 51,
    EVENT_SUMMON_TALK3          = 52,

    EVENT_THRALL_TALK           = 60,
    EVENT_SUMMON_CHRONO         = 61,
    EVENT_THRALL_TALK_2         = 62,
    EVENT_TARETHA_FALL          = 63,
    EVENT_THRALL_TALK_3         = 64,
    EVENT_THRALL_MOVE_DOWN      = 65,

    EVENT_EPOCH_INTRO           = 70,
    EVENT_SUMMON_INFINITES      = 71,
    EVENT_TRANSFORM             = 72,
    EVENT_START_WAVE_1          = 73,
    EVENT_CHECK_WAVE_1          = 74,
    EVENT_CHECK_WAVE_2          = 75,
    EVENT_CHECK_WAVE_3          = 76,
    EVENT_CALL_EPOCH            = 77,

    EVENT_THRALL_FACE_TARETHA   = 80,
    EVENT_THRALL_TALK_4         = 81,
    EVENT_TARETHA_TALK_1        = 82,
    EVENT_THRALL_TALK_5         = 83,
    EVENT_SUMMON_EROZION        = 84,
    EVENT_EROZION_TALK_1        = 85,
    EVENT_EROZION_ACTION_1      = 86,
    EVENT_EROZION_TALK_2        = 87,
    EVENT_EROZION_ACTION_2      = 88,
    EVENT_EROZION_TALK_3        = 89,
    EVENT_THRALL_TALK_6         = 90,
    EVENT_THRALL_RUN_AWAY       = 91,
    EVENT_TARETHA_TALK_2        = 92,
    EVENT_EROZION_FLAGS         = 93
};

class npc_thrall_old_hillsbrad : public CreatureScript
{
public:
    npc_thrall_old_hillsbrad() : CreatureScript("npc_thrall_old_hillsbrad") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetOldHillsbradAI<npc_thrall_old_hillsbradAI>(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        InstanceScript* instance = creature->GetInstanceScript();
        if (!instance)
            return true;

        uint32 menuId = creature->GetCreatureTemplate()->GossipMenuId;
        if (instance->GetData(DATA_ESCORT_PROGRESS) == ENCOUNTER_PROGRESS_SKARLOC_KILLED)
            menuId = 7830;
        else if (instance->GetData(DATA_ESCORT_PROGRESS) == ENCOUNTER_PROGRESS_TARREN_MILL)
            menuId = 7840;
        else if (instance->GetData(DATA_ESCORT_PROGRESS) == ENCOUNTER_PROGRESS_TARETHA_MEET)
            menuId = 7853;

        player->PrepareGossipMenu(creature, menuId, true);
        player->SendPreparedGossip(creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*sender*/, uint32  /*action*/) override
    {
        GossipMenuItemData const* gossipMenuItemData = player->PlayerTalkClass->GetGossipMenu().GetItemData(0);
        InstanceScript* instance = creature->GetInstanceScript();
        if (!instance || (gossipMenuItemData && gossipMenuItemData->GossipActionMenuId != 0))
            return false;

        ClearGossipMenuFor(player);
        CloseGossipMenuFor(player);

        creature->AI()->DoAction(instance->GetData(DATA_ESCORT_PROGRESS));
        creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        return true;
    }

    struct npc_thrall_old_hillsbradAI : public npc_escortAI
    {
        npc_thrall_old_hillsbradAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
            _barnWave = false;
            _churchWave = false;
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case ENCOUNTER_PROGRESS_BARRELS:
                    events.ScheduleEvent(EVENT_OPEN_DOORS, 0);
                    events.ScheduleEvent(EVENT_START_WP, 3000);
                    break;
                case ENCOUNTER_PROGRESS_THRALL_ARMORED:
                case ENCOUNTER_PROGRESS_AMBUSHES_1:
                case ENCOUNTER_PROGRESS_SKARLOC_KILLED:
                case ENCOUNTER_PROGRESS_TARREN_MILL:
                    SetEscortPaused(false);
                    break;
                case ENCOUNTER_PROGRESS_TARETHA_MEET:
                    events.ScheduleEvent(EVENT_SUMMON_CHRONO, 0);
                    events.ScheduleEvent(EVENT_THRALL_TALK_2, 6000);
                    events.ScheduleEvent(EVENT_TARETHA_FALL, 11000);
                    events.ScheduleEvent(EVENT_THRALL_TALK_3, 15000);
                    events.ScheduleEvent(EVENT_THRALL_MOVE_DOWN, 17000);
                    break;
                case NPC_TARETHA:
                    events.ScheduleEvent(EVENT_THRALL_FACE_TARETHA, 0);
                    events.ScheduleEvent(EVENT_THRALL_TALK_4, 4000);
                    events.ScheduleEvent(EVENT_TARETHA_TALK_1, 13000);
                    events.ScheduleEvent(EVENT_THRALL_TALK_5, 17000);
                    events.ScheduleEvent(EVENT_SUMMON_EROZION, 17500);
                    events.ScheduleEvent(EVENT_EROZION_TALK_1, 18000);
                    events.ScheduleEvent(EVENT_EROZION_ACTION_1, 24000);
                    events.ScheduleEvent(EVENT_EROZION_TALK_2, 29000);
                    events.ScheduleEvent(EVENT_EROZION_TALK_3, 40000);
                    events.ScheduleEvent(EVENT_EROZION_ACTION_2, 46000);
                    events.ScheduleEvent(EVENT_THRALL_TALK_6, 48000);
                    events.ScheduleEvent(EVENT_THRALL_RUN_AWAY, 51000);
                    events.ScheduleEvent(EVENT_TARETHA_TALK_2, 53000);
                    events.ScheduleEvent(EVENT_EROZION_FLAGS, 56000);
                    break;
            }
        }

        void WaypointStart(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 30:
                    Talk(SAY_START_EVENT_PART2);
                    break;
            }
        }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                case 0:
                    Talk(SAY_START_EVENT_PART1);
                    break;
                case 8:
                    events.ScheduleEvent(EVENT_SET_FACING, 500);
                    events.ScheduleEvent(EVENT_ARMORER_SAY, 700);
                    events.ScheduleEvent(EVENT_THRALL_EMOTE, 1300);
                    break;
                case 9:
                    SetRun(false);
                    events.ScheduleEvent(EVENT_KILL_ARMORER, 500);
                    events.ScheduleEvent(EVENT_TALK_KILL_ARMORER, 3000);
                    break;
                case 10:
                    SetRun(true);
                    events.ScheduleEvent(EVENT_DRESSING_KNEEL, 500);
                    events.ScheduleEvent(EVENT_DRESSING_ARMOR, 3000);
                    events.ScheduleEvent(EVENT_DRESSING_STAND, 4000);
                    events.ScheduleEvent(EVENT_DRESSING_AXE, 7000);
                    events.ScheduleEvent(EVENT_DRESSING_SHIELD, 9000);
                    events.ScheduleEvent(EVENT_DRESSING_TALK, 12000);
                    break;
                case 18:
                    if (Creature* warden = me->SummonCreature(NPC_DURNHOLDE_WARDEN, 2149.4634f, 104.97559f, 73.632385f, 1.9065f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        warden->SetWalk(true);
                        warden->GetMotionMaster()->MovePoint(0, 2144.9893f, 117.81233f, 75.98518f);
                    }
                    if (Creature* veteran = me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2147.3281f, 106.72353f, 74.34447f, 1.6904f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        veteran->SetWalk(true);
                        veteran->GetMotionMaster()->MovePoint(0, 2145.2092f, 124.361f, 76.13655f);
                    }
                    if (Creature* veteran = me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2149.212f, 107.20052f, 74.15676f, 1.9887f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        veteran->SetWalk(true);
                        veteran->GetMotionMaster()->MovePoint(0, 2143.7898f, 119.41281f, 75.96626f);
                    }
                    if (Creature* mage = me->SummonCreature(NPC_DURNHOLDE_MAGE, 2147.624f, 104.61046f, 73.909294f, 1.6186f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        mage->SetWalk(true);
                        mage->GetMotionMaster()->MovePoint(0, 2146.975f, 118.05078f, 76.098465f);
                    }
                    break;
                case 27:
                    instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_AMBUSHES_1);
                    break;
                case 28:
                    me->SummonCreature(NPC_CAPTAIN_SKARLOC, 1995.78f, 277.46f, 66.64f, 0.74f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2 * MINUTE * IN_MILLISECONDS);
                    break;
                case 29:
                    SetEscortPaused(true);
                    Talk(SAY_SKARLOC_MEET);
                    break;
                case 30:
                    events.ScheduleEvent(EVENT_ENTER_MOUNT, 3000);
                    events.ScheduleEvent(EVENT_TALK_START_RIDE, 7000);
                    break;
                case 59:
                    instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_TARREN_MILL);
                    if (Creature* mount = me->SummonCreature(NPC_SKARLOC_MOUNT, 2488.64f, 625.77f, 58.26f, 4.71f, TEMPSUMMON_TIMED_DESPAWN, 7000))
                    {
                        mount->SetImmuneToNPC(true);
                        mount->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    }
                    UnMountSelf();
                    _mounted = false;
                    SetRun(false);
                    me->SetFacingTo(6.0388f);
                    break;
                case 60:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                    if (Creature* horse = me->FindNearestCreature(NPC_SKARLOC_MOUNT, 10.0f))
                    {
                        horse->GetMotionMaster()->MovePoint(0, 2501.15f, 572.14f, 54.13f);
                        horse->DespawnOrUnsummon(30 * IN_MILLISECONDS);
                    }
                    Talk(SAY_EMOTE_HORSE);
                    SetEscortPaused(true);
                    SetRun(true);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    me->SetFacingTo(4.1364f);
                    break;
                case 64:
                    SetRun(false);
                    break;
                case 67:
                    events.ScheduleEvent(EVENT_LOOK_1, 1200);
                    events.ScheduleEvent(EVENT_MOVE_AROUND, 3500);
                    events.ScheduleEvent(EVENT_LOOK_2, 5000);
                    events.ScheduleEvent(EVENT_SUMMON_GUARDS, 5100);
                    events.ScheduleEvent(EVENT_LOOK_3, 7000);
                    events.ScheduleEvent(EVENT_SUMMON_TALK1, 12000);
                    events.ScheduleEvent(EVENT_LOOK_4, 17000);
                    events.ScheduleEvent(EVENT_SUMMON_TALK2, 19000);
                    events.ScheduleEvent(EVENT_GUARDS_MOVING, 21000);
                    break;
                case 82:
                    events.ScheduleEvent(EVENT_LOOK_5, 500);
                    events.ScheduleEvent(EVENT_SUMMON_GUARDS_2, 1000);
                    events.ScheduleEvent(EVENT_SUMMON_TALK3, 1500);
                    break;
                case 91:
                    me->SummonCreature(NPC_TM_PROTECTOR, 2652.71f, 660.31f, 61.93f, 1.67f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_LOOKOUT, 2648.96f, 662.59f, 61.93f, 0.79f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2657.36f, 662.34f, 61.93f, 2.68f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2656.39f, 659.77f, 61.93f, 2.61f, TEMPSUMMON_MANUAL_DESPAWN);
                    if (Creature* summon = summons.GetCreatureWithEntry(NPC_TM_LOOKOUT))
                        summon->AI()->Talk(SAY_LOOKOUT_INN);
                    break;
                case 92:
                    SetRun(false);
                    break;
                case 94:
                    summons.DespawnAll();
                    SetEscortPaused(true);
                    SetRun(true);
                    instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_TARETHA_MEET);
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TARETHA_GUID)))
                    {
                        Taretha->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                        Taretha->AI()->Talk(SAY_TARETHA_ESCAPED);
                    }
                    events.ScheduleEvent(EVENT_THRALL_TALK, 4000);
                    break;
                case 101:
                    SetEscortPaused(true);
                    events.ScheduleEvent(EVENT_EPOCH_INTRO, 500);
                    events.ScheduleEvent(EVENT_SUMMON_INFINITES, 1500);
                    events.ScheduleEvent(EVENT_TRANSFORM, 8000);
                    events.ScheduleEvent(EVENT_START_WAVE_1, 25000);
                    break;
                case 103:
                    instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_FINISHED);
                    me->SetVisible(false);
                    break;
            }
        }

        void MountSelf()
        {
            me->Mount(SKARLOC_MOUNT_MODEL);
            me->SetSpeed(MOVE_RUN, SPEED_MOUNTED);
        }

        void UnMountSelf()
        {
            me->Dismount();
            me->SetSpeed(MOVE_RUN, SPEED_RUNNING);
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            npc_escortAI::MovementInform(type, point);
            if (type == POINT_MOTION_TYPE && point == 0xFFFFFF /*POINT_LAST_POINT*/)
            {
                if (roll_chance_i(30))
                    Talk(SAY_LEAVE_COMBAT);
                if (_mounted)
                    MountSelf();
            }
        }

        void JustEngagedWith(Unit*) override
        {
            combatEvents.Reset();
            combatEvents.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
            combatEvents.ScheduleEvent(EVENT_SPELL_SHIELD_BLOCK, 8000);
            combatEvents.ScheduleEvent(EVENT_SPELL_STRIKE, 2000);

            if (roll_chance_i(50))
                Talk(SAY_RANDOM_AGGRO);

            if (me->IsMounted())
            {
                _mounted = true;
                UnMountSelf();
            }
        }

        void Reset() override
        {
            _mounted = false;
            events.Reset();
            combatEvents.Reset();
            summons.DespawnAll();

            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            instance->SetData(DATA_THRALL_REPOSITION, 1);

            uint32 data = instance->GetData(DATA_ESCORT_PROGRESS);
            if (data >= ENCOUNTER_PROGRESS_THRALL_ARMORED)
                ReorderInstance(data);
        }

        void JustReachedHome() override
        {
            if (_barnWave)
            {
                _barnWave = false;
                Talk(SAY_LEAD);
            }
            else if (_churchWave)
            {
                _churchWave = false;
                Talk(SAY_CHURCH_END);
            }
        }

        void KilledUnit(Unit*) override
        {
            Talk(SAY_RANDOM_KILL);
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_INFINITE_SLAYER || summon->GetEntry() == NPC_INFINITE_SABOTEUR || summon->GetEntry() == NPC_INFINITE_DEFILER)
                summon->GetMotionMaster()->MovePoint(10, 2634.25f, 672.01f, 54.445f);

            summons.Summon(summon);
        }

        void SummonedCreatureDespawn(Creature* summon) override { summons.Despawn(summon); }
        void SummonedCreatureDies(Creature* summon, Unit*) override { summons.Despawn(summon); }

        void JustDied(Unit* killer) override
        {
            if (killer && killer == me)
                return;

            summons.DespawnAll();
            Talk(SAY_RANDOM_DIE);
            RemoveEscortState(STATE_ESCORT_ESCORTING);
            instance->SetData(DATA_THRALL_REPOSITION, 3);
            if (instance->GetData(DATA_ATTEMPTS_COUNT) < 20)
                me->CastSpell(me, SPELL_SUMMON_EROZION_IMAGE, true);
            else
                me->SetRespawnTime(DAY);
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_OPEN_DOORS:
                    if (GameObject* doors = me->FindNearestGameObject(GO_PRISON_DOOR, 10.0f))
                        doors->SetGoState(GO_STATE_ACTIVE);
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2142.372f, 174.2907f, 66.30494f, 2.5656f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2138.178f, 168.6046f, 66.30494f, 2.4783f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2140.1458f, 169.23643f, 66.30494f, 2.4958f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2107.9377f, 192.07530f, 66.30494f, 2.5481f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2142.3633f, 172.42600f, 66.30494f, 2.5481f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2109.8518f, 195.14030f, 66.30493f, 2.4260f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2108.4856f, 189.93457f, 66.30494f, 2.6878f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    break;
                case EVENT_START_WP:
                    Start(true, true);
                    SetDespawnAtEnd(false);
                    break;
                case EVENT_SET_FACING:
                    if (Creature* armorer = me->FindNearestCreature(NPC_DURNHOLDE_ARMORER, 30.0f))
                    {
                        armorer->GetMotionMaster()->Clear();
                        armorer->GetMotionMaster()->MoveIdle();
                        armorer->SetFacingToObject(me);
                        me->SetFacingToObject(armorer);
                    }
                    break;
                case EVENT_ARMORER_SAY:
                    if (Creature* armorer = me->FindNearestCreature(NPC_DURNHOLDE_ARMORER, 30.0f))
                    {
                        armorer->AI()->Talk(SAY_ARMORER_THRALL);
                    }
                    break;
                case EVENT_THRALL_EMOTE:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    break;
                case EVENT_KILL_ARMORER:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    if (Creature* armorer = me->FindNearestCreature(NPC_DURNHOLDE_ARMORER, 30.0f))
                    {
                        DoCast(armorer, SPELL_KNOCKOUT_ARMORER, true);
                        armorer->SetStandState(UNIT_STAND_STATE_DEAD);
                    }
                    break;
                case EVENT_TALK_KILL_ARMORER:
                    Talk(SAY_KILL_ARMORER);
                    break;
                case EVENT_DRESSING_KNEEL:
                    me->SetFacingTo(2.61f);
                    Talk(SAY_ARMORY);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    break;
                case EVENT_DRESSING_ARMOR:
                    me->SetDisplayId(THRALL_MODEL_EQUIPPED);
                    break;
                case EVENT_DRESSING_STAND:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    break;
                case EVENT_DRESSING_AXE:
                    me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, THRALL_WEAPON_ITEM);
                    break;
                case EVENT_DRESSING_SHIELD:
                    me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, THRALL_SHIELD_ITEM);
                    break;
                case EVENT_DRESSING_TALK:
                    instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_THRALL_ARMORED);
                    DoCastSelf(SPELL_SALVATION);
                    me->SetFacingTo(5.6897f);
                    Talk(SAY_GO_ARMORED);
                    if (Creature* sentry = me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2185.916f, 140.38835f, 88.299866f, 5.9238f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        sentry->SetWalk(true);
                        sentry->GetMotionMaster()->MovePoint(0, 2191.9712f, 138.11394f, 88.2125f);
                    }
                    if (Creature* warden = me->SummonCreature(NPC_DURNHOLDE_WARDEN, 2188.5586f, 138.88553f, 88.299866f, 1.6031f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        warden->SetWalk(true);
                        warden->GetMotionMaster()->MovePoint(0, 2188.5068f, 140.48346f, 88.21251f);
                    }
                    if (Creature* veteran = me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2186.9856f, 142.199f, 88.299866f, 5.9049f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        veteran->SetWalk(true);
                        veteran->GetMotionMaster()->MovePoint(0, 2190.48f, 140.81056f, 88.21251f);
                    }
                    if (Creature* mage = me->SummonCreature(NPC_DURNHOLDE_MAGE, 2189.7336f, 140.64551f, 88.299866f, 3.9532f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        mage->SetWalk(true);
                        mage->GetMotionMaster()->MovePoint(0, 2187.8035f, 138.61118f, 88.21251f);
                    }
                    break;
                case EVENT_ENTER_MOUNT:
                    MountSelf();
                    if (Creature* mount = me->FindNearestCreature(NPC_SKARLOC_MOUNT, 10.0f))
                    {
                        me->SetFacingTo(mount->GetOrientation());
                        mount->DespawnOrUnsummon();
                    }
                    break;
                case EVENT_TALK_START_RIDE:
                    Talk(SAY_MOUNTS_UP);
                    break;
                case EVENT_LOOK_1:
                    me->SetFacingTo(5.0090f);
                    me->SetImmuneToNPC(true);
                    break;
                case EVENT_MOVE_AROUND:
                    me->GetMotionMaster()->MovePoint(0, 2477.146f, 695.041f, 55.801f);
                    break;
                case EVENT_LOOK_2:
                    me->SetFacingTo(2.0071f);
                    break;
                case EVENT_SUMMON_GUARDS:
                    SetRun(true);
                    me->SummonCreature(NPC_TM_PROTECTOR, 2501.5708f, 699.38086f, 55.64138f, 3.8571f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_TM_LOOKOUT, 2500.7002f, 698.26746f, 55.618248f, 3.7350f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    if (Creature* guardsman = me->SummonCreature(NPC_TM_GUARDSMAN, 2500.0908f, 699.9389f, 55.629555f, 4.2935f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS))
                    {
                        guardsman->CastSpell(guardsman, SPELL_DUMMY_AURA, true);
                    }
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2499.0579f, 698.99725f, 55.611156f, 4.5727f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    summons.DoAction(ACTION_SET_IMMUNE_FLAG);
                    break;
                case EVENT_LOOK_3:
                    me->SetFacingTo(0.3490f);
                    break;
                case EVENT_SUMMON_TALK1:
                    if (Creature* summon = summons.GetCreatureWithEntry(NPC_TM_LOOKOUT))
                        summon->AI()->Talk(SAY_LOOKOUT_SAW);
                    me->SetFacingTo(0.4363f);
                    break;
                case EVENT_LOOK_4:
                    me->SetFacingTo(4.7510f);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_NO);
                    Talk(SAY_EMOTE_HORSE_2);
                    break;
                case EVENT_SUMMON_TALK2:
                    me->SetFacingTo(0.4363f);
                    if (Creature* summon = summons.GetCreatureWithEntry(NPC_TM_LOOKOUT))
                        summon->AI()->Talk(SAY_LOOKOUT_GO);
                    me->SetImmuneToNPC(true);
                    break;
                case EVENT_GUARDS_MOVING:
                    me->SetImmuneToNPC(false);
                    summons.DoAction(ACTION_REMOVE_IMMUNE_FLAG);
                    _barnWave = true;
                    break;
                case EVENT_LOOK_5:
                    me->SetFacingTo(0.4886f);
                    Talk(SAY_ENTER_CHURCH);
                    break;
                case EVENT_SUMMON_GUARDS_2:
                    me->SummonCreature(NPC_TM_PROTECTOR, 2630.75f, 664.80f, 54.28f, 4.37f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_TM_LOOKOUT, 2632.20f, 661.98f, 54.30f, 4.37f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2630.02f, 662.75f, 54.28f, 4.37f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2632.86f, 664.05f, 54.31f, 4.37f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 30 * IN_MILLISECONDS);
                    _churchWave = true;
                    break;
                case EVENT_SUMMON_TALK3:
                    if (Creature* summon = summons.GetCreatureWithEntry(NPC_TM_LOOKOUT))
                        summon->AI()->Talk(SAY_LOOKOUT_CHURCH);
                    break;
                case EVENT_THRALL_TALK:
                    Talk(SAY_MEET_TARETHA);
                    me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                    break;
                case EVENT_SUMMON_CHRONO:
                    if (Creature* epoch = me->SummonCreature(NPC_EPOCH_HUNTER, 2640.49f, 696.15f, 64.31f, 4.51f, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        epoch->SetImmuneToAll(true);
                        epoch->AI()->Talk(SAY_EPOCH_ENTER1);
                    }
                    break;
                case EVENT_THRALL_TALK_2:
                    me->SetFacingTo(2.60f);
                    Talk(SAY_EPOCH_WONDER);
                    break;
                case EVENT_TARETHA_FALL:
                    if (Creature* epoch = summons.GetCreatureWithEntry(NPC_EPOCH_HUNTER))
                        epoch->AI()->Talk(SAY_EPOCH_ENTER2);
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TARETHA_GUID)))
                    {
                        Taretha->CastSpell(Taretha, SPELL_SHADOW_SPIKE);
                        Taretha->SetStandState(UNIT_STAND_STATE_DEAD);
                    }
                    break;
                case EVENT_THRALL_TALK_3:
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TARETHA_GUID)))
                    {
                        me->SetFacingToObject(Taretha);
                    }
                    Talk(SAY_EPOCH_KILL_TARETHA);
                    break;
                case EVENT_THRALL_MOVE_DOWN:
                    SetEscortPaused(false);
                    break;
                case EVENT_EPOCH_INTRO:
                    if (Creature* epoch = summons.GetCreatureWithEntry(NPC_EPOCH_HUNTER))
                    {
                        me->SetFacingToObject(epoch);
                        epoch->SetFacingToObject(me);
                        epoch->AI()->Talk(SAY_EPOCH_ENTER3);
                    }
                    break;
                case EVENT_SUMMON_INFINITES:
                    me->SummonCreature(NPC_EPOCH_LOOKOUT, 2647.57f, 701.17f, 56.215f, 4.3f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_EPOCH_GUARDSMAN, 2629.46f, 704.76f, 56.286f, 4.98f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_EPOCH_PROTECTOR, 2640.14f, 709.44f, 56.135f, 4.70f, TEMPSUMMON_MANUAL_DESPAWN);
                    summons.DoAction(ACTION_SET_IMMUNE_FLAG);
                    summons.DoAction(ACTION_MOVE);
                    break;
                case EVENT_TRANSFORM:
                    summons.DoAction(ACTION_TRANSFORM);
                    summons.DoAction(ACTION_SET_IMMUNE_FLAG);
                    break;
                case EVENT_START_WAVE_1:
                    events.ScheduleEvent(EVENT_CHECK_WAVE_1, 500);
                    summons.DoAction(ACTION_REMOVE_IMMUNE_FLAG);
                    summons.DoAction(ACTION_START_COMBAT);
                    break;
                case EVENT_CHECK_WAVE_1:
                    if (summons.size() == 1)
                    {
                        me->SummonCreature(NPC_INFINITE_SABOTEUR, 2599.57f, 683.72f, 55.975f, 0.05f, TEMPSUMMON_MANUAL_DESPAWN);
                        me->SummonCreature(NPC_INFINITE_SLAYER, 2599.57f, 677.0f, 55.975f, 0.05f, TEMPSUMMON_MANUAL_DESPAWN);
                        me->SummonCreature(NPC_INFINITE_DEFILER, 2592.57f, 680.0f, 55.975f, 0.05f, TEMPSUMMON_MANUAL_DESPAWN);
                        summons.DoAction(ACTION_START_COMBAT);
                        events.ScheduleEvent(EVENT_CHECK_WAVE_2, 500);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_WAVE_1, 500);
                    break;
                case EVENT_CHECK_WAVE_2:
                    if (summons.size() == 1)
                    {
                        me->SummonCreature(NPC_INFINITE_SLAYER, 2642.62f, 701.43f, 55.965f, 4.46f, TEMPSUMMON_MANUAL_DESPAWN);
                        me->SummonCreature(NPC_INFINITE_SLAYER, 2638.62f, 701.43f, 55.965f, 4.46f, TEMPSUMMON_MANUAL_DESPAWN);
                        me->SummonCreature(NPC_INFINITE_SABOTEUR, 2638.62f, 705.43f, 55.965f, 4.46f, TEMPSUMMON_MANUAL_DESPAWN);
                        me->SummonCreature(NPC_INFINITE_DEFILER, 2642.62f, 705.43f, 55.965f, 4.46f, TEMPSUMMON_MANUAL_DESPAWN);
                        summons.DoAction(ACTION_START_COMBAT);
                        events.ScheduleEvent(EVENT_CHECK_WAVE_3, 500);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_WAVE_2, 500);
                    break;
                case EVENT_CHECK_WAVE_3:
                    if (summons.size() == 1)
                    {
                        me->SetHomePosition(2634.79f, 672.964f, 54.8577f, 1.33f);
                        me->GetMotionMaster()->MoveTargetedHome();
                        events.ScheduleEvent(EVENT_CALL_EPOCH, 8000);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_WAVE_3, 500);
                    break;
                case EVENT_CALL_EPOCH:
                    if (Creature* epoch = summons.GetCreatureWithEntry(NPC_EPOCH_HUNTER))
                    {
                        epoch->SetImmuneToAll(false);
                        epoch->GetMotionMaster()->MovePoint(0, *me, false, true);
                    }
                    break;
                case EVENT_THRALL_FACE_TARETHA:
                    {
                        Map::PlayerList const& players = me->GetMap()->GetPlayers();
                        if (!players.IsEmpty())
                            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                                if (Player* player = itr->GetSource())
                                    player->KilledMonsterCredit(20156);

                        if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TARETHA_GUID)))
                        {
                            me->SetFacingToObject(Taretha);
                        }
                        me->SetImmuneToNPC(true);
                        break;
                    }
                case EVENT_THRALL_TALK_4:
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_TALK);
                    Talk(SAY_GREET_TARETHA);
                    break;
                case EVENT_TARETHA_TALK_1:
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TARETHA_GUID)))
                    {
                        Taretha->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        Taretha->AI()->Talk(SAY_TARETHA_TALK1);
                    }
                    break;
                case EVENT_THRALL_TALK_5:
                    Talk(SAY_CHAT_TARETHA1);
                    break;
                case EVENT_SUMMON_EROZION:
                    if (Creature* erozion = me->SummonCreature(NPC_EROZION, 2646.31f, 680.01f, 55.36f, 3.76f, TEMPSUMMON_MANUAL_DESPAWN))
                        erozion->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    break;
                case EVENT_EROZION_TALK_1:
                    if (Creature* erozion = summons.GetCreatureWithEntry(NPC_EROZION))
                    {
                        erozion->CastSpell(erozion, SPELL_TELEPORT, true);
                        erozion->AI()->Talk(SAY_EROZION_1);
                    }
                    break;
                case EVENT_EROZION_ACTION_1:
                    if (Creature* erozion = summons.GetCreatureWithEntry(NPC_EROZION))
                        erozion->CastSpell(erozion, SPELL_MEMORY_WIPE, false);
                    break;
                case EVENT_EROZION_TALK_2:
                    if (Creature* erozion = summons.GetCreatureWithEntry(NPC_EROZION))
                        erozion->AI()->Talk(SAY_EROZION_2);
                    break;
                case EVENT_EROZION_TALK_3:
                    if (Creature* erozion = summons.GetCreatureWithEntry(NPC_EROZION))
                        erozion->AI()->Talk(SAY_EROZION_3);
                    break;
                case EVENT_EROZION_ACTION_2:
                    if (Creature* erozion = summons.GetCreatureWithEntry(NPC_EROZION))
                        erozion->CastSpell(erozion, SPELL_MEMORY_WIPE_RESUME, false);
                    break;
                case EVENT_THRALL_TALK_6:
                    Talk(SAY_EVENT_COMPLETE);
                    break;
                case EVENT_THRALL_RUN_AWAY:
                    me->SetImmuneToAll(true);
                    me->SetReactState(REACT_PASSIVE);
                    SetEscortPaused(false);
                    break;
                case EVENT_TARETHA_TALK_2:
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TARETHA_GUID)))
                    {
                        Taretha->SetFacingToObject(me);
                        Taretha->AI()->Talk(SAY_TARETHA_TALK2);
                    }
                    break;
                case EVENT_EROZION_FLAGS:
                    if (Creature* erozion = summons.GetCreatureWithEntry(NPC_EROZION))
                        erozion->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
                    break;
            }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            combatEvents.Update(diff);
            switch (combatEvents.ExecuteEvent())
            {
                case EVENT_CHECK_HEALTH:
                    if (me->HealthBelowPct(20))
                    {
                        Talk(SAY_RANDOM_LOW_HP);
                        break;
                    }
                    events.ScheduleEvent(EVENT_CHECK_HEALTH, 500);
                    break;
                case EVENT_SPELL_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_STRIKE, false);
                    events.ScheduleEvent(EVENT_SPELL_STRIKE, 6000);
                    break;
                case EVENT_SPELL_SHIELD_BLOCK:
                    me->CastSpell(me, SPELL_SHIELD_BLOCK, false);
                    events.ScheduleEvent(EVENT_SPELL_SHIELD_BLOCK, 6000);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void ReorderInstance(uint32 data)
        {
            Start(true, true);
            SetEscortPaused(true);
            SetDespawnAtEnd(false);

            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

            if (data < ENCOUNTER_PROGRESS_THRALL_ARMORED)
            {
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 0);
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, 0);
                me->SetDisplayId(THRALL_MODEL_UNEQUIPPED);
            }
            else
            {
                me->SetDisplayId(THRALL_MODEL_EQUIPPED);
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, THRALL_WEAPON_ITEM);
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 1, THRALL_SHIELD_ITEM);
            }

            switch (data)
            {
                case ENCOUNTER_PROGRESS_THRALL_ARMORED:
                    SetNextWaypoint(11, false);
                    break;
                case ENCOUNTER_PROGRESS_AMBUSHES_1:
                    SetNextWaypoint(27, false);
                    break;
                case ENCOUNTER_PROGRESS_SKARLOC_KILLED:
                    if (Creature* mount = me->SummonCreature(NPC_SKARLOC_MOUNT, 2049.12f, 252.31f, 62.855f, me->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        mount->SetImmuneToNPC(true);
                        mount->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    }
                    SetNextWaypoint(30, false);
                    break;
                case ENCOUNTER_PROGRESS_TARREN_MILL:
                    SetNextWaypoint(61, false);
                    break;
                case ENCOUNTER_PROGRESS_TARETHA_MEET:
                    SetNextWaypoint(95, false);
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_TARETHA_GUID)))
                        Taretha->SetStandState(UNIT_STAND_STATE_STAND);
                    break;
            }
        }

    private:
        InstanceScript* instance;
        EventMap events;
        EventMap combatEvents;
        SummonList summons;

        bool _mounted;
        bool _barnWave;
        bool _churchWave;
    };
};

class npc_taretha : public CreatureScript
{
public:
    npc_taretha() : CreatureScript("npc_taretha") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetOldHillsbradAI<npc_tarethaAI>(creature);
    }

    bool OnGossipHello(Player*  /*player*/, Creature*  /*creature*/) override
    {
        return true;
    }

    struct npc_tarethaAI : public npc_escortAI
    {
        npc_tarethaAI(Creature* creature) : npc_escortAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        void DoAction(int32 /*param*/) override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveAllAuras();
            Start(false, true);
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (waypointId == 7)
            {
                SetRun(false);
                Talk(SAY_TARETHA_FREE);
                me->HandleEmoteCommand(EMOTE_ONESHOT_CHEER);
                if (Creature* thrall = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_THRALL_GUID)))
                    thrall->AI()->DoAction(me->GetEntry());
            }
            else if (waypointId == 9)
                me->SetVisible(false);
        }

        void Reset() override
        {
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->CastSpell(me, SPELL_SHADOW_PRISON, true);
        }

        void AttackStart(Unit*) override { }
        void MoveInLineOfSight(Unit*) override { }
    };
};

void AddSC_old_hillsbrad()
{
    new npc_thrall_old_hillsbrad();
    new npc_taretha();
}
