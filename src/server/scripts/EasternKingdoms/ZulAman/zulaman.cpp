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

/* ScriptData
SDName: Zulaman
SD%Complete: 90
SDComment: Forest Frog will turn into different NPC's. Workaround to prevent new entry from running this script
SDCategory: Zul'Aman
EndScriptData */

/* ContentData
npc_forest_frog
EndContentData */

#include "zulaman.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellScript.h"

/*######
## npc_forest_frog
######*/

enum ForestFrog
{
    // Spells
    SPELL_REMOVE_AMANI_CURSE          = 43732,
    SPELL_PUSH_MOJO                   = 43923,
    SPELL_SUMMON_AMANI_CHARM_CHEST_1  = 43835, // Amani Treasure Box (186744)
    SPELL_SUMMON_AMANI_CHARM_CHEST_2  = 43756, // Amani Charm Box (186734)
    SPELL_SUMMON_MONEY_BAG            = 43774, // Money Bag (186736)
    SPELL_STEALTH_                    = 34189,

    // Creatures
    NPC_FOREST_FROG                   = 24396,
    NPC_MANNUTH                       = 24397,
    NPC_DEEZ                          = 24403,
    NPC_GALATHRYN                     = 24404,
    NPC_ADARRAH                       = 24405,
    NPC_FUDGERICK                     = 24406,
    NPC_DARWEN                        = 24407,
    NPC_GUNTER                        = 24408,
    NPC_KYREN                         = 24409,
    NPC_MITZI                         = 24445,
    NPC_CHRISTIAN                     = 24448,
    NPC_BRENNAN                       = 24453,
    NPC_HOLLEE                        = 24455,

    // Says
    SAY_MANNUTH_0                     = 0,
    SAY_MANNUTH_1                     = 1,
    SAY_MANNUTH_2                     = 2,
    SAY_MANNUTH_3                     = 3,

    SAY_DEEZ_0                        = 0,
    SAY_DEEZ_1                        = 1,
    SAY_DEEZ_2                        = 2,
    SAY_DEEZ_3                        = 3,

    SAY_GALATHRYN_0                   = 0,
    SAY_GALATHRYN_1                   = 1,
    SAY_GALATHRYN_2                   = 2,
    SAY_GALATHRYN_3                   = 3,

    SAY_ADARRAH_1                     = 1,
    SAY_ADARRAH_2                     = 2,
    SAY_ADARRAH_3                     = 3,
    SAY_ADARRAH_4                     = 4,

    SAY_DARWEN_0                      = 0,
    SAY_DARWEN_1                      = 1,
    SAY_DARWEN_2                      = 2,
    SAY_DARWEN_3                      = 3,

    SAY_FUDGERICK_0                   = 0,
    SAY_FUDGERICK_1                   = 1,
    SAY_FUDGERICK_2                   = 2,
    SAY_FUDGERICK_3                   = 3,

    SAY_GUNTER_0                      = 0,
    SAY_GUNTER_1                      = 1,
    SAY_GUNTER_2                      = 2,

    SAY_KYREN_0                       = 0,
    SAY_KYREN_1                       = 1,
    SAY_KYREN_2                       = 2,

    SAY_MITZI_0                       = 0,
    SAY_MITZI_1                       = 1,
    SAY_MITZI_2                       = 2,
    SAY_MITZI_3                       = 3,

    SAY_CHRISTIAN_0                   = 0,
    SAY_CHRISTIAN_1                   = 1,
    SAY_CHRISTIAN_2                   = 2,
    SAY_CHRISTIAN_3                   = 3,

    SAY_BRENNAN_0                     = 0,
    SAY_BRENNAN_1                     = 1,
    SAY_BRENNAN_2                     = 2,
    SAY_BRENNAN_3                     = 3,

    SAY_HOLLEE_0                      = 0,
    SAY_HOLLEE_1                      = 1,
    SAY_HOLLEE_2                      = 2,
    SAY_HOLLEE_3                      = 3,

    POINT_DESPAWN                     = 1
};

class npc_forest_frog : public CreatureScript
{
public:
    npc_forest_frog() : CreatureScript("npc_forest_frog") { }

    struct npc_forest_frogAI : public ScriptedAI
    {
        npc_forest_frogAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;
        uint8 eventTimer;
        ObjectGuid PlayerGUID;

        void Reset() override { }

        void JustEngagedWith(Unit* /*who*/) override { }

        void MovementInform(uint32 type, uint32 data) override
        {
            if (type == POINT_MOTION_TYPE && data == POINT_DESPAWN)
                me->DespawnOrUnsummon(1000);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            if (eventTimer)
            {
                Player* player = ObjectAccessor::GetPlayer(me->GetMap(), PlayerGUID);
                switch (events.ExecuteEvent())
                {
                    case 1:
                        switch (me->GetEntry())
                        {
                            case NPC_MANNUTH:
                                Talk(SAY_MANNUTH_0, player);
                                break;
                            case NPC_DEEZ:
                                Talk(SAY_DEEZ_0, player);
                                break;
                            case NPC_GALATHRYN:
                                Talk(SAY_GALATHRYN_0, player);
                                break;
                            case NPC_ADARRAH:
                                Talk(SAY_ADARRAH_1, player);
                                break;
                            case NPC_DARWEN:
                                Talk(SAY_DARWEN_0, player);
                                break;
                            case NPC_FUDGERICK:
                                Talk(SAY_FUDGERICK_0, player);
                                break;
                            case NPC_GUNTER:
                                Talk(SAY_GUNTER_0, player);
                                break;
                            case NPC_KYREN:
                                Talk(SAY_KYREN_0, player);
                                break;
                            case NPC_MITZI:
                                Talk(SAY_MITZI_0, player);
                                break;
                            case NPC_CHRISTIAN:
                                Talk(SAY_CHRISTIAN_0, player);
                                break;
                            case NPC_BRENNAN:
                                Talk(SAY_BRENNAN_0, player);
                                break;
                            case NPC_HOLLEE:
                                Talk(SAY_HOLLEE_0, player);
                                break;
                        }
                        eventTimer = 2;
                        events.ScheduleEvent(eventTimer, urand(4000, 5000));
                        break;
                    case 2:
                        if (me->GetEntry() != NPC_GUNTER && me->GetEntry() != NPC_KYREN) // vendors don't kneel?
                            me->SetStandState(UNIT_STAND_STATE_KNEEL);

                        switch (me->GetEntry())
                        {
                            case NPC_MANNUTH:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_2, true);
                                Talk(SAY_MANNUTH_1, player);
                                break;
                            case NPC_DEEZ:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_2, true);
                                Talk(SAY_DEEZ_1, player);
                                break;
                            case NPC_GALATHRYN:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_2, true);
                                Talk(SAY_GALATHRYN_1, player);
                                break;
                            case NPC_ADARRAH:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_2, true);
                                Talk(SAY_ADARRAH_2, player);
                                break;
                            case NPC_DARWEN:
                                DoCast(me, SPELL_SUMMON_MONEY_BAG, true);
                                me->LoadEquipment(0, true);
                                Talk(SAY_DARWEN_1, player);
                                break;
                            case NPC_FUDGERICK:
                                DoCast(me, SPELL_SUMMON_MONEY_BAG, true);
                                me->LoadEquipment(0, true);
                                Talk(SAY_FUDGERICK_1, player);
                                break;
                            case NPC_GUNTER:
                                Talk(SAY_GUNTER_1, player);
                                break;
                            case NPC_KYREN:
                                Talk(SAY_KYREN_1, player);
                                break;
                            case NPC_MITZI:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_1, true);
                                Talk(SAY_MITZI_1, player);
                                break;
                            case NPC_CHRISTIAN:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_1, true);
                                Talk(SAY_CHRISTIAN_1, player);
                                break;
                            case NPC_BRENNAN:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_1, true);
                                Talk(SAY_BRENNAN_1, player);
                                break;
                            case NPC_HOLLEE:
                                DoCast(me, SPELL_SUMMON_AMANI_CHARM_CHEST_1, true);
                                Talk(SAY_HOLLEE_1, player);
                                break;
                        }
                        eventTimer = 3;
                        events.ScheduleEvent(eventTimer, urand(6000, 7000));
                        break;
                    case 3:
                        me->SetStandState(EMOTE_ONESHOT_NONE);
                        switch (me->GetEntry())
                        {
                            case NPC_MANNUTH:
                                Talk(SAY_MANNUTH_2, player);
                                break;
                            case NPC_DEEZ:
                                Talk(SAY_DEEZ_2, player);
                                break;
                            case NPC_GALATHRYN:
                                Talk(SAY_GALATHRYN_2, player);
                                break;
                            case NPC_ADARRAH:
                                Talk(SAY_ADARRAH_3, player);
                                break;
                            case NPC_DARWEN:
                                Talk(SAY_DARWEN_2, player);
                                break;
                            case NPC_FUDGERICK:
                                Talk(SAY_FUDGERICK_2, player);
                                break;
                            case NPC_GUNTER:
                                Talk(SAY_GUNTER_2, player);
                                break;
                            case NPC_KYREN:
                                Talk(SAY_KYREN_2, player);
                                break;
                            case NPC_MITZI:
                                Talk(SAY_MITZI_2, player);
                                break;
                            case NPC_CHRISTIAN:
                                Talk(SAY_CHRISTIAN_2, player);
                                break;
                            case NPC_BRENNAN:
                                Talk(SAY_BRENNAN_2, player);
                                break;
                            case NPC_HOLLEE:
                                Talk(SAY_HOLLEE_2, player);
                                break;
                        }
                        eventTimer = 4;
                        if (me->GetEntry() == NPC_GUNTER || me->GetEntry() == NPC_KYREN)
                            events.ScheduleEvent(eventTimer, 5 * MINUTE * IN_MILLISECONDS); // vendors wait for 5 minutes before running away and despawning
                        else
                            events.ScheduleEvent(eventTimer, 6000);
                        break;
                    case 4:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
                        switch (me->GetEntry())
                        {
                            case NPC_MANNUTH:
                                Talk(SAY_MANNUTH_3, player);
                                break;
                            case NPC_DEEZ:
                                Talk(SAY_DEEZ_3, player);
                                break;
                            case NPC_GALATHRYN:
                                Talk(SAY_GALATHRYN_3, player);
                                break;
                            case NPC_ADARRAH:
                                Talk(SAY_ADARRAH_4, player);
                                break;
                            case NPC_DARWEN:
                                Talk(SAY_DARWEN_3, player);
                                break;
                            case NPC_FUDGERICK:
                                Talk(SAY_FUDGERICK_3, player);
                                break;
                            case NPC_MITZI:
                                Talk(SAY_MITZI_3, player);
                                break;
                            case NPC_CHRISTIAN:
                                Talk(SAY_CHRISTIAN_3, player);
                                break;
                            case NPC_BRENNAN:
                                Talk(SAY_BRENNAN_3, player);
                                break;
                            case NPC_HOLLEE:
                                Talk(SAY_HOLLEE_3, player);
                                break;
                        }
                        eventTimer = 5;
                        events.ScheduleEvent(eventTimer, 2000);
                        break;
                    case 5:
                        switch (me->GetEntry())
                        {
                            case NPC_ADARRAH:
                                DoCast(me, SPELL_STEALTH_, true);
                                break;
                        }
                        if (me->GetPositionY() > 1290.0f)
                            me->GetMotionMaster()->MovePoint(POINT_DESPAWN, 118.2742f, 1400.657f, -9.118711f);
                        else
                            me->GetMotionMaster()->MovePoint(POINT_DESPAWN, 114.3155f, 1244.244f, -20.97606f);
                        eventTimer = 0;
                        break;
                }
            }
        }

        void DoSpawnRandom()
        {
            if (instance)
            {
                uint32 cEntry = NPC_MANNUTH;
                switch (urand(0, 9))
                {
                    case 1:
                        cEntry = NPC_DEEZ;
                        break;
                    case 2:
                        cEntry = NPC_GALATHRYN;
                        break;
                    case 3:
                        cEntry = NPC_ADARRAH;
                        break;
                    case 4:
                        cEntry = NPC_FUDGERICK;
                        break;
                    case 5:
                        cEntry = NPC_DARWEN;
                        break;
                    case 6:
                        cEntry = NPC_MITZI;
                        break;
                    case 7:
                        cEntry = NPC_CHRISTIAN;
                        break;
                    case 8:
                        cEntry = NPC_BRENNAN;
                        break;
                    case 9:
                        cEntry = NPC_HOLLEE;
                        break;
                }

                if (!instance->GetData(TYPE_RAND_VENDOR_1) && roll_chance_i(10))
                {
                    cEntry = NPC_GUNTER;
                    instance->SetData(TYPE_RAND_VENDOR_1, DONE);
                }
                else if (!instance->GetData(TYPE_RAND_VENDOR_2) && roll_chance_i(10))
                {
                    cEntry = NPC_KYREN;
                    instance->SetData(TYPE_RAND_VENDOR_2, DONE);
                }

                // start generic rp
                eventTimer = 1;
                events.ScheduleEvent(eventTimer, 3000);

                me->UpdateEntry(cEntry);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_REMOVE_AMANI_CURSE && caster->IsPlayer() && me->GetEntry() == NPC_FOREST_FROG)
            {
                me->GetMotionMaster()->MoveIdle();
                me->SetFacingToObject(caster);
                PlayerGUID = caster->GetGUID();

                if (roll_chance_i(2))
                {
                    DoCast(caster, SPELL_PUSH_MOJO, true);
                    me->GetMotionMaster()->MovePoint(POINT_DESPAWN, caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ());
                }
                else
                    DoSpawnRandom();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulAmanAI<npc_forest_frogAI>(creature);
    }
};

/*######
## npc_zulaman_hostage
######*/

#define GOSSIP_HOSTAGE1        "I am glad to help you."

static uint32 HostageEntry[] = {23790, 23999, 24024, 24001};
static uint32 ChestEntry[] = {186648, 187021, 186667, 186672};

class npc_zulaman_hostage : public CreatureScript
{
public:
    npc_zulaman_hostage() : CreatureScript("npc_zulaman_hostage") { }

    struct npc_zulaman_hostageAI : public ScriptedAI
    {
        npc_zulaman_hostageAI(Creature* creature) : ScriptedAI(creature)
        {
            IsLoot = false;
        }

        bool IsLoot;
        ObjectGuid PlayerGUID;

        void Reset() override { }

        void JustEngagedWith(Unit* /*who*/) override { }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID))
                player->SendLoot(me->GetGUID(), LOOT_CORPSE);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (IsLoot)
                DoCast(me, 7, false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulAmanAI<npc_zulaman_hostageAI>(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_HOSTAGE1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        if (action == GOSSIP_ACTION_INFO_DEF + 1)
            CloseGossipMenuFor(player);

        if (!creature->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
            return true;

        creature->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);

        InstanceScript* instance = creature->GetInstanceScript();
        if (instance)
        {
            //uint8 progress = instance->GetData(DATA_CHESTLOOTED);
            instance->SetData(DATA_CHESTLOOTED, 0);
            float x, y, z;
            creature->GetPosition(x, y, z);
            uint32 entry = creature->GetEntry();
            for (uint8 i = 0; i < 4; ++i)
            {
                if (HostageEntry[i] == entry)
                {
                    creature->SummonGameObject(ChestEntry[i], x - 2, y, z, 0, 0, 0, 0, 0, 0);
                    break;
                }
            }
        }

        return true;
    }
};

/*######
## npc_harrison_jones
######*/

enum Says
{
    SAY_HARRISON_0                    = 0,
    SAY_HARRISON_1                    = 1,
    SAY_HARRISON_2                    = 0,
    SAY_HARRISON_3                    = 1
};

enum Spells
{
    SPELL_BANGING_THE_GONG            = 45225,
    SPELL_STEALTH                     = 34189,
    SPELL_COSMETIC_SPEAR_THROW        = 43647
};

enum Events
{
    GONG_EVENT_1                      = 1,
    GONG_EVENT_2                      = 2,
    GONG_EVENT_3                      = 3,
    GONG_EVENT_4                      = 4,
    GONG_EVENT_5                      = 5,
    GONG_EVENT_6                      = 6,
    GONG_EVENT_7                      = 7,
    GONG_EVENT_8                      = 8,
    GONG_EVENT_9                      = 9,
    GONG_EVENT_10                     = 10,
    GONG_EVENT_11                     = 11
};

enum Waypoints
{
    HARRISON_MOVE_1                   = 860440,
    HARRISON_MOVE_2                   = 860441,
    HARRISON_MOVE_3                   = 860442
};

enum DisplayIds
{
    MODEL_HARRISON_JONES_0              = 22340,
    MODEL_HARRISON_JONES_1              = 22354,
    MODEL_HARRISON_JONES_2              = 22347
};

enum EntryIds
{
    NPC_HARRISON_JONES_1                = 24375,
    NPC_HARRISON_JONES_2                = 24365,
    NPC_AMANISHI_GUARDIAN               = 23597,
};

enum Weapons
{
    WEAPON_MACE                         = 5301,
    WEAPON_SPEAR                        = 13631
};

class npc_harrison_jones : public CreatureScript
{
public:
    npc_harrison_jones() : CreatureScript("npc_harrison_jones")
    {
    }

    struct npc_harrison_jonesAI : public ScriptedAI
    {
        npc_harrison_jonesAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;

        uint8 _gongEvent;
        uint32 _gongTimer;
        ObjectGuid uiTargetGUID;

        void Reset() override
        {
            _gongEvent = 0;
            _gongTimer = 0;
            uiTargetGUID.Clear();
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void sGossipSelect(Player* player, uint32 sender, uint32 action) override
        {
            if (me->GetCreatureTemplate()->GossipMenuId == sender && !action)
            {
                CloseGossipMenuFor(player);
                me->SetFacingToObject(player);
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                Talk(SAY_HARRISON_0);
                _gongEvent = GONG_EVENT_1;
                _gongTimer = 4000;
            }
        }

        void SpellHit(Unit*, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_COSMETIC_SPEAR_THROW)
            {
                me->RemoveAllAuras();
                me->SetEntry(NPC_HARRISON_JONES_2);
                me->SetDisplayId(MODEL_HARRISON_JONES_2);
                me->SetTarget();
                me->SetByteValue(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_STAND_STATE, UNIT_STAND_STATE_DEAD);
                me->SetDynamicFlag(UNIT_DYNFLAG_DEAD);
                instance->SetData(DATA_GONGEVENT, DONE);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_gongEvent)
            {
                if (_gongTimer <= diff)
                {
                    switch (_gongEvent)
                    {
                        case GONG_EVENT_1:
                            me->GetMotionMaster()->MovePath(HARRISON_MOVE_1, false);
                            _gongEvent = GONG_EVENT_2;
                            _gongTimer = 12000;
                            break;
                        case GONG_EVENT_2:
                            me->SetFacingTo(6.235659f);
                            Talk(SAY_HARRISON_1);
                            DoCast(me, SPELL_BANGING_THE_GONG);
                            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_MACE));
                            me->SetSheath(SHEATH_STATE_MELEE);
                            _gongEvent = GONG_EVENT_3;
                            _gongTimer = 4000;
                            break;
                        case GONG_EVENT_3:
                            if (GameObject* gong = me->GetMap()->GetGameObject(instance->GetGuidData(GO_STRANGE_GONG)))
                                gong->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                            _gongEvent = GONG_EVENT_4;
                            _gongTimer = 105000;
                            break;
                        case GONG_EVENT_4:
                            me->RemoveAura(SPELL_BANGING_THE_GONG);
                            if (GameObject* gong = me->GetMap()->GetGameObject(instance->GetGuidData(GO_STRANGE_GONG)))
                                gong->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

                            // trigger or gong will need to be scripted to set IN_PROGRESS after enough hits.
                            // This is temp workaround.
                            instance->SetData(DATA_GONGEVENT, IN_PROGRESS); // to be removed.

                            if (instance->GetData(DATA_GONGEVENT) == IN_PROGRESS)
                            {
                                // Players are Now Saved to instance at SPECIAL (Player should be notified?)
                                me->GetMotionMaster()->MovePath(HARRISON_MOVE_2, false);
                                _gongEvent = GONG_EVENT_5;
                                _gongTimer = 5000;
                            }
                            else
                            {
                                _gongTimer = 1000;
                                _gongEvent = GONG_EVENT_9;
                            }
                            break;
                        case GONG_EVENT_5:
                            me->SetEntry(NPC_HARRISON_JONES_1);
                            me->SetDisplayId(MODEL_HARRISON_JONES_1);
                            Talk(SAY_HARRISON_2);
                            _gongTimer = 12000;
                            _gongEvent = GONG_EVENT_6;
                            break;
                        case GONG_EVENT_6:
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_USE_STANDING);
                            Talk(SAY_HARRISON_3);
                            _gongTimer = 7000;
                            _gongEvent = GONG_EVENT_7;
                            break;
                        case GONG_EVENT_7:
                            if (!uiTargetGUID)
                            {
                                std::list<Creature*> targetList;
                                GetCreatureListWithEntryInGrid(targetList, me, NPC_AMANISHI_GUARDIAN, 26.0f);
                                if (!targetList.empty())
                                {
                                    for (std::list<Creature*>::const_iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
                                    {
                                        if (Creature* ptarget = *itr)
                                        {
                                            if (ptarget->GetPositionX() > 120)
                                            {
                                                ptarget->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_SPEAR));
                                                ptarget->SetImmuneToPC(true);
                                                ptarget->SetReactState(REACT_PASSIVE);
                                                ptarget->AI()->SetData(0, 1);
                                            }
                                            else
                                            {
                                                ptarget->SetImmuneToPC(true);
                                                ptarget->SetReactState(REACT_PASSIVE);
                                                ptarget->AI()->SetData(0, 2);
                                            }
                                        }
                                    }
                                }
                            }

                            if (GameObject* gate = me->GetMap()->GetGameObject(instance->GetGuidData(GO_MASSIVE_GATE)))
                                gate->SetGoState(GO_STATE_ACTIVE);
                            _gongTimer = 2000;
                            _gongEvent = GONG_EVENT_8;
                            break;
                        case GONG_EVENT_8:
                            DoCast(me, SPELL_STEALTH);
                            me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(0));
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                            me->GetMotionMaster()->MovePath(HARRISON_MOVE_3, false);
                            _gongTimer = 1000;
                            _gongEvent = 0;
                            break;
                        case GONG_EVENT_9:
                            me->GetMotionMaster()->MovePoint(0, 120.687f, 1674.0f, 42.0217f);
                            _gongTimer = 12000;
                            _gongEvent = GONG_EVENT_10;
                            break;
                        case GONG_EVENT_10:
                            me->SetFacingTo(1.59044f);
                            _gongEvent = 11;
                            _gongTimer = 6000;
                            break;
                        case GONG_EVENT_11:
                            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);

                            instance->SetData(DATA_GONGEVENT, NOT_STARTED);
                            _gongEvent = 0;
                            _gongTimer = 1000;
                            break;
                    }
                }
                else
                    _gongTimer -= diff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulAmanAI<npc_harrison_jonesAI>(creature);
    }
};

void AddSC_zulaman()
{
    new npc_forest_frog();
    new npc_zulaman_hostage();
    new npc_harrison_jones();
}
