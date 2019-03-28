 /*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "old_hillsbrad.h"
#include "Player.h"

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
    SPELL_MEMORY_WIPE_RESUME    = 33337
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
    EVENT_KILL_ARMORER          = 10,
    EVENT_TALK_KILL_ARMORER     = 11,

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
    EVENT_LOOK_3                = 43,
    EVENT_SUMMON_GUARDS         = 44,
    EVENT_SUMMON_TALK1          = 45,
    EVENT_SUMMON_TALK2          = 46,

    EVENT_LOOK_4                = 50,
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
    EVENT_TARETHA_TALK_2        = 92

};

class npc_thrall_old_hillsbrad : public CreatureScript
{
public:
    npc_thrall_old_hillsbrad() : CreatureScript("npc_thrall_old_hillsbrad") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_thrall_old_hillsbradAI>(creature);
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
        creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP|UNIT_NPC_FLAG_QUESTGIVER);
        return true;
    }

    struct npc_thrall_old_hillsbradAI : public npc_escortAI
    {
        npc_thrall_old_hillsbradAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        void DoAction(int32 param) override
        {
            switch (param)
            {
                case ENCOUNTER_PROGRESS_DRAKE_KILLED:
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
                    events.ScheduleEvent(EVENT_THRALL_TALK_3, 14000);
                    events.ScheduleEvent(EVENT_THRALL_MOVE_DOWN, 17000);
                    break;
                case NPC_TARETHA:
                    events.ScheduleEvent(EVENT_THRALL_FACE_TARETHA, 0);
                    events.ScheduleEvent(EVENT_THRALL_TALK_4, 4000);
                    events.ScheduleEvent(EVENT_TARETHA_TALK_1, 13000);
                    events.ScheduleEvent(EVENT_THRALL_TALK_5, 17000);
                    events.ScheduleEvent(EVENT_SUMMON_EROZION, 17500);
                    events.ScheduleEvent(EVENT_EROZION_TALK_1, 18000);
                    events.ScheduleEvent(EVENT_EROZION_ACTION_1, 26000);
                    events.ScheduleEvent(EVENT_EROZION_TALK_2, 29000);
                    events.ScheduleEvent(EVENT_EROZION_TALK_3, 42000);
                    events.ScheduleEvent(EVENT_EROZION_ACTION_2, 47000);
                    events.ScheduleEvent(EVENT_THRALL_TALK_6, 48000);
                    events.ScheduleEvent(EVENT_THRALL_RUN_AWAY, 51000);
                    events.ScheduleEvent(EVENT_TARETHA_TALK_2, 53000);
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
                    break;
                case 9:
                    SetRun(false);
                    events.ScheduleEvent(EVENT_KILL_ARMORER, 500);
                    events.ScheduleEvent(EVENT_TALK_KILL_ARMORER, 4000);
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
                case 13:
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2200.28f, 137.37f, 87.93f, 5.07f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2197.44f, 131.83f, 87.93f, 0.78f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2203.62f, 135.40f, 87.93f, 3.70f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2200.75f, 130.13f, 87.93f, 1.48f, TEMPSUMMON_MANUAL_DESPAWN);
                    break;
                case 16:
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2147.43f, 122.194f, 76.422f, 0.67f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2146.27f, 126.13f, 76.241f, 0.60f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2142.62f, 120.38f, 75.862f, 0.48f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2141.74f, 123.95f, 75.732f, 0.24f, TEMPSUMMON_MANUAL_DESPAWN);
                    break;
                case 18:
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2138.37f, 167.98f, 66.23f, 2.59f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_WARDEN, 2142.76f, 173.62f, 66.23f, 2.59f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2140.96f, 168.64f, 66.23f, 2.59f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2142.53f, 171.03f, 66.23f, 2.59f, TEMPSUMMON_MANUAL_DESPAWN);
                    break;
                case 22:
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2108.73f, 190.43f, 66.23f, 5.56f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2109.74f, 195.29f, 66.23f, 5.56f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_MAGE, 2107.74f, 192.59f, 66.23f, 5.56f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_DURNHOLDE_SENTRY, 2112.26f, 195.13f, 66.23f, 5.56f, TEMPSUMMON_MANUAL_DESPAWN);
                    break;
                case 27:
                    instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_AMBUSHES_1);
                    break;
                case 28:
                    me->SummonCreature(NPC_CAPTAIN_SKARLOC, 1995.78f, 277.46f, 66.64f, 0.74f, TEMPSUMMON_MANUAL_DESPAWN);
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
                    me->SummonCreature(NPC_SKARLOC_MOUNT, 2488.64f, 625.77f, 58.26f, 4.71f, TEMPSUMMON_TIMED_DESPAWN, 7000);
                    UnMountSelf();
                    _mounted = false;
                    SetRun(false);
                    break;
                case 60:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    if (Creature* horse = me->FindNearestCreature(NPC_SKARLOC_MOUNT, 10.0f))
                        horse->GetMotionMaster()->MovePoint(0, 2501.15f, 572.14f, 54.13f);

                    SetEscortPaused(true);
                    SetRun(true);
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    break;
                case 64:
                    SetRun(false);
                    break;
                case 67:
                    events.ScheduleEvent(EVENT_LOOK_1, 500);
                    events.ScheduleEvent(EVENT_MOVE_AROUND, 3500);
                    events.ScheduleEvent(EVENT_LOOK_2, 5000);
                    events.ScheduleEvent(EVENT_LOOK_3, 6700);
                    events.ScheduleEvent(EVENT_SUMMON_GUARDS, 6000);
                    events.ScheduleEvent(EVENT_SUMMON_TALK1, 6500);
                    events.ScheduleEvent(EVENT_SUMMON_TALK2, 12000);
                    break;
                case 82:
                    events.ScheduleEvent(EVENT_LOOK_4, 500);
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
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_TARETHA_GUID)))
                        Taretha->AI()->Talk(SAY_TARETHA_ESCAPED);
                    events.ScheduleEvent(EVENT_THRALL_TALK, 2000);
                    break;
                case 101:
                    SetEscortPaused(true);
                    events.ScheduleEvent(EVENT_EPOCH_INTRO, 500);
                    events.ScheduleEvent(EVENT_SUMMON_INFINITES, 1500);
                    events.ScheduleEvent(EVENT_TRANSFORM, 8000);
                    events.ScheduleEvent(EVENT_START_WAVE_1, 25000);
                    break;
                case 103:
                    if (Creature* erozion = summons.GetCreatureWithEntry(NPC_EROZION))
                        erozion->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
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

        void EnterCombat(Unit*) override
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

            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP|UNIT_NPC_FLAG_QUESTGIVER);
            instance->SetData(DATA_THRALL_REPOSITION, 1);

            uint32 data = instance->GetData(DATA_ESCORT_PROGRESS);
            if (data >= ENCOUNTER_PROGRESS_THRALL_ARMORED)
                ReorderInstance(data);
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
            if (killer == me)
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
                    break;
                case EVENT_START_WP:
                    Start(true, true);
                    SetDespawnAtEnd(false);
                    break;
                case EVENT_SET_FACING:
                    if (Creature* armorer = me->FindNearestCreature(NPC_DURNHOLDE_ARMORER, 30.0f))
                    {
                        armorer->AI()->Talk(SAY_ARMORER_THRALL);
                        armorer->SetFacingToObject(me);
                        me->SetFacingToObject(armorer);
                    }
                    break;
                case EVENT_KILL_ARMORER:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    if (Creature* armorer = me->FindNearestCreature(NPC_DURNHOLDE_ARMORER, 30.0f))
                        armorer->SetStandState(UNIT_STAND_STATE_DEAD);
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
                    me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID+1, THRALL_SHIELD_ITEM);
                    break;
                case EVENT_DRESSING_TALK:
                    instance->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_THRALL_ARMORED);
                    Talk(SAY_GO_ARMORED);
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
                    me->SetFacingTo(5.058f);
                    break;
                case EVENT_MOVE_AROUND:
                    me->GetMotionMaster()->MovePoint(0, 2477.146f, 695.041f, 55.801f);
                    break;
                case EVENT_LOOK_2:
                    me->SetFacingTo(2.297f);
                    break;
                case EVENT_LOOK_3:
                    me->SetFacingTo(0.64f);
                    break;
                case EVENT_SUMMON_GUARDS:
                    SetRun(true);
                    me->SummonCreature(NPC_TM_PROTECTOR, 2501.34f, 700.80f, 55.573f, 3.92f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_LOOKOUT, 2503.02f, 699.11f, 55.57f, 3.92f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2503.04f, 702.495f, 50.63f, 3.92f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2504.72f, 700.806f, 55.62f, 3.92f, TEMPSUMMON_MANUAL_DESPAWN);
                    summons.DoAction(ACTION_SET_IMMUNE_FLAG);
                    break;
                case EVENT_SUMMON_TALK1:
                    if (Creature* summon = summons.GetCreatureWithEntry(NPC_TM_LOOKOUT))
                        summon->AI()->Talk(SAY_LOOKOUT_SAW);
                    break;
                case EVENT_SUMMON_TALK2:
                    if (Creature* summon = summons.GetCreatureWithEntry(NPC_TM_LOOKOUT))
                        summon->AI()->Talk(SAY_LOOKOUT_GO);
                    summons.DoAction(ACTION_REMOVE_IMMUNE_FLAG);
                    break;
                case EVENT_LOOK_4:
                    me->SetFacingTo(0.41f);
                    Talk(SAY_ENTER_CHURCH);
                    break;
                case EVENT_SUMMON_GUARDS_2:
                    me->SummonCreature(NPC_TM_PROTECTOR, 2630.75f, 664.80f, 54.28f, 4.37f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_LOOKOUT, 2632.20f, 661.98f, 54.30f, 4.37f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2630.02f, 662.75f, 54.28f, 4.37f, TEMPSUMMON_MANUAL_DESPAWN);
                    me->SummonCreature(NPC_TM_GUARDSMAN, 2632.86f, 664.05f, 54.31f, 4.37f, TEMPSUMMON_MANUAL_DESPAWN);
                    break;
                case EVENT_SUMMON_TALK3:
                    if (Creature* summon = summons.GetCreatureWithEntry(NPC_TM_LOOKOUT))
                        summon->AI()->Talk(SAY_LOOKOUT_CHURCH);
                    break;
                case EVENT_THRALL_TALK:
                    Talk(SAY_MEET_TARETHA);
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    break;
                case EVENT_SUMMON_CHRONO:
                    if (Creature* epoch = me->SummonCreature(NPC_EPOCH_HUNTER, 2640.49f, 696.15f, 64.31f, 4.51f, TEMPSUMMON_MANUAL_DESPAWN))
                    {
                        epoch->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                        epoch->AI()->Talk(SAY_EPOCH_ENTER1);
                    }
                    break;
                case EVENT_THRALL_TALK_2:
                    me->SetFacingTo(2.67f);
                    Talk(SAY_EPOCH_WONDER);
                    break;
                case EVENT_TARETHA_FALL:
                    if (Creature* epoch = summons.GetCreatureWithEntry(NPC_EPOCH_HUNTER))
                        epoch->AI()->Talk(SAY_EPOCH_ENTER2);
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_TARETHA_GUID)))
                    {
                        Taretha->CastSpell(Taretha, SPELL_SHADOW_SPIKE);
                        Taretha->SetStandState(UNIT_STAND_STATE_DEAD);
                    }
                    break;
                case EVENT_THRALL_TALK_3:
                    me->SetFacingTo(5.78f);
                    Talk(SAY_EPOCH_KILL_TARETHA);
                    break;
                case EVENT_THRALL_MOVE_DOWN:
                    SetEscortPaused(false);
                    break;
                case EVENT_EPOCH_INTRO:
                    me->SetFacingTo(1.33f);
                    if (Creature* epoch = summons.GetCreatureWithEntry(NPC_EPOCH_HUNTER))
                        epoch->AI()->Talk(SAY_EPOCH_ENTER3);
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
                        epoch->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                        epoch->GetMotionMaster()->MovePoint(0, *me, false, true);
                    }
                    break;
                case EVENT_THRALL_FACE_TARETHA:
                {
                    Map::PlayerList const& players = me->GetMap()->GetPlayers();
                    if (!players.isEmpty())
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                            if (Player* player = itr->GetSource())
                                player->KilledMonsterCredit(20156, 0);

                    me->SetFacingTo(5.76f);
                    break;
                }
                case EVENT_THRALL_TALK_4:
                    Talk(SAY_GREET_TARETHA);
                    break;
                case EVENT_TARETHA_TALK_1:
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_TARETHA_GUID)))
                        Taretha->AI()->Talk(SAY_TARETHA_TALK1);
                    break;
                case EVENT_THRALL_TALK_5:
                    Talk(SAY_CHAT_TARETHA1);
                    break;
                case EVENT_SUMMON_EROZION:
                    if (Creature* erozion = me->SummonCreature(NPC_EROZION, 2646.31f, 680.01f, 55.36f, 3.76f, TEMPSUMMON_MANUAL_DESPAWN))
                        erozion->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
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
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetReactState(REACT_PASSIVE);
                    SetEscortPaused(false);
                    break;
                case EVENT_TARETHA_TALK_2:
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_TARETHA_GUID)))
                    {
                        Taretha->SetFacingTo(4.233f);
                        Taretha->AI()->Talk(SAY_TARETHA_TALK2);
                    }
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

            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP|UNIT_NPC_FLAG_QUESTGIVER);

            if (data < ENCOUNTER_PROGRESS_THRALL_ARMORED)
            {
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, 0);
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID+1, 0);
                me->SetDisplayId(THRALL_MODEL_UNEQUIPPED);
            }
            else
            {
                me->SetDisplayId(THRALL_MODEL_EQUIPPED);
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, THRALL_WEAPON_ITEM);
                me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID+1, THRALL_SHIELD_ITEM);
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
                    me->SummonCreature(NPC_SKARLOC_MOUNT, 2049.12f, 252.31f, 62.855f, me->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN);
                    SetNextWaypoint(30, false);
                    break;
                case ENCOUNTER_PROGRESS_TARREN_MILL:
                    SetNextWaypoint(61, false);
                    break;
                case ENCOUNTER_PROGRESS_TARETHA_MEET:
                    SetNextWaypoint(95, false);
                    if (Creature* Taretha = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_TARETHA_GUID)))
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
    };
};

class npc_taretha : public CreatureScript
{
public:
    npc_taretha() : CreatureScript("npc_taretha") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetInstanceAI<npc_tarethaAI>(creature);
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
                if (Creature* thrall = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_THRALL_GUID)))
                    thrall->AI()->DoAction(me->GetEntry());
            }
            else if (waypointId == 9)
                me->SetVisible(false);
        }

        void Reset() override
        {
            me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_NONE);
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
