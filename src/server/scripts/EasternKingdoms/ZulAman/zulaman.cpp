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

#include "zulaman.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

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

    // Adarrah is spawned elsewhere.
    // So her text 0 isn't used in this instance.
    SAY_THANKS_FREED                  = 0,
    SAY_CHEST_SPAWN                   = 1,
    SAY_CHEST_TALK                    = 2,
    SAY_GOODBYE                       = 3,

    POINT_DESPAWN                     = 1,
};

struct npc_forest_frog : public ScriptedAI
{
    npc_forest_frog(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

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

                if (me->GetEntry() == NPC_ADARRAH)
                    Talk(SAY_THANKS_FREED + 1, player);
                else
                    Talk(SAY_THANKS_FREED, player);

                eventTimer = 2;
                events.ScheduleEvent(eventTimer, urand(4000, 5000));
                break;
            case 2:
                if (me->GetEntry() != NPC_GUNTER && me->GetEntry() != NPC_KYREN) // vendors don't kneel?
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);

                switch (me->GetEntry())
                {
                case NPC_MANNUTH:
                case NPC_DEEZ:
                case NPC_GALATHRYN:
                    DoCastSelf(SPELL_SUMMON_AMANI_CHARM_CHEST_2, true);
                    Talk(SAY_CHEST_SPAWN, player);
                    break;
                case NPC_ADARRAH:
                    DoCastSelf(SPELL_SUMMON_AMANI_CHARM_CHEST_2, true);
                    Talk(SAY_CHEST_SPAWN + 1, player);
                    break;
                case NPC_DARWEN:
                case NPC_FUDGERICK:
                    DoCastSelf(SPELL_SUMMON_MONEY_BAG, true);
                    me->LoadEquipment(0, true);
                    Talk(SAY_CHEST_SPAWN, player);
                    break;
                case NPC_KYREN:
                case NPC_GUNTER:
                    Talk(SAY_CHEST_SPAWN, player);
                    break;
                case NPC_MITZI:
                case NPC_CHRISTIAN:
                case NPC_BRENNAN:
                case NPC_HOLLEE:
                    DoCastSelf(SPELL_SUMMON_AMANI_CHARM_CHEST_1, true);
                    Talk(SAY_CHEST_SPAWN, player);
                    break;
                }
                eventTimer = 3;
                events.ScheduleEvent(eventTimer, urand(6000, 7000));
                break;
            case 3:
                me->SetStandState(EMOTE_ONESHOT_NONE);

                if (me->GetEntry() == NPC_ADARRAH)
                    Talk(SAY_CHEST_TALK + 1, player);
                else
                    Talk(SAY_CHEST_TALK);

                eventTimer = 4;
                if (me->GetEntry() == NPC_GUNTER || me->GetEntry() == NPC_KYREN)
                    events.ScheduleEvent(eventTimer, 5 * MINUTE * IN_MILLISECONDS); // vendors wait for 5 minutes before running away and despawning
                else
                    events.ScheduleEvent(eventTimer, 6000);
                break;
            case 4:
                me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);

                if (me->GetEntry() == NPC_ADARRAH)
                    Talk(SAY_GOODBYE + 1, player);
                else
                    Talk(SAY_GOODBYE);

                eventTimer = 5;
                events.ScheduleEvent(eventTimer, 2000);
                break;
            case 5:

                if (me->GetEntry() == NPC_ADARRAH)
                    DoCastSelf(SPELL_STEALTH_, true);

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
        auto const& entries =
        {
            NPC_MANNUTH, NPC_DEEZ, NPC_GALATHRYN, NPC_ADARRAH, NPC_FUDGERICK, NPC_DARWEN, NPC_MITZI,
            NPC_CHRISTIAN, NPC_BRENNAN, NPC_HOLLEE
        };

        uint32 cEntry = Acore::Containers::SelectRandomContainerElement(entries);

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
                me->GetMotionMaster()->MovePoint(POINT_DESPAWN, caster->GetPosition());
            }
            else
                DoSpawnRandom();
        }
    }

    private:
        InstanceScript* instance;
        EventMap events;
        uint8 eventTimer;
        ObjectGuid PlayerGUID;
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

enum Actions
{
    ACTION_COMPLETE_EVENT_3           = 0,
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

struct npc_harrison_jones : public ScriptedAI
{
    npc_harrison_jones(Creature* creature) : ScriptedAI(creature)
    {
        _instance = creature->GetInstanceScript();
    }

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
            _instance->StorePersistentData(DATA_TIMED_RUN, 21);
            _instance->DoAction(ACTION_START_TIMED_RUN);
            me->DespawnOrUnsummon(3min+30s, 0s);
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_COMPLETE_EVENT_3)
        {
            me->GetMap()->ToInstanceMap()->PermBindAllPlayers();
            _gongEvent = GONG_EVENT_4;
            _gongTimer = 0;
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
                    DoCastSelf(SPELL_BANGING_THE_GONG);
                    me->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_MACE));
                    me->SetSheath(SHEATH_STATE_MELEE);
                    _gongEvent = GONG_EVENT_3;
                    _gongTimer = 4000;
                    break;
                case GONG_EVENT_3:
                    if (GameObject* gong = _instance->GetGameObject(DATA_STRANGE_GONG))
                        gong->RemoveGameObjectFlag(GO_FLAG_NOT_SELECTABLE);
                    break;
                case GONG_EVENT_4:
                    me->RemoveAura(SPELL_BANGING_THE_GONG);
                    if (GameObject* gong = _instance->GetGameObject(DATA_STRANGE_GONG))
                        gong->SetGameObjectFlag(GO_FLAG_NOT_SELECTABLE);

                    // Players are Now Saved to instance at SPECIAL (Player should be notified?)
                    me->GetMotionMaster()->MovePath(HARRISON_MOVE_2, false);
                    _gongEvent = GONG_EVENT_5;
                    _gongTimer = 5000;
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
                            for (auto const& creature : targetList)
                            {
                                if (creature)
                                {
                                    creature->SetImmuneToPC(true);
                                    creature->SetReactState(REACT_PASSIVE);

                                    if (creature->GetPositionX() > 120)
                                    {
                                        creature->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, uint32(WEAPON_SPEAR));
                                        creature->AI()->SetData(0, 1);
                                    }
                                    else
                                        creature->AI()->SetData(0, 2);
                                }
                            }
                        }
                    }

                    if (GameObject* gate = _instance->GetGameObject(DATA_MASSIVE_GATE))
                    {
                        gate->AllowSaveToDB(true);
                        gate->SetGoState(GO_STATE_ACTIVE);
                    }
                    _gongTimer = 2000;
                    _gongEvent = GONG_EVENT_8;
                    break;
                case GONG_EVENT_8:
                    DoCastSelf(SPELL_STEALTH);
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
                    _gongEvent = 0;
                    _gongTimer = 1000;
                    break;
                }
            }
            else
                _gongTimer -= diff;
        }
    }

    private:
        InstanceScript* _instance;
        uint8 _gongEvent;
        uint32 _gongTimer;
        ObjectGuid uiTargetGUID;
};

class spell_ritual_of_power : public SpellScript
{
    PrepareSpellScript(spell_ritual_of_power);

    void OnEffect(SpellEffIndex /*effIndex*/)
    {
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
            if (Creature* creature = instance->GetCreature(DATA_HARRISON_JONES))
                creature->AI()->DoAction(ACTION_COMPLETE_EVENT_3);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_ritual_of_power::OnEffect, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

void AddSC_zulaman()
{
    RegisterZulAmanCreatureAI(npc_forest_frog);
    RegisterZulAmanCreatureAI(npc_harrison_jones);
    RegisterSpellScript(spell_ritual_of_power);
}
