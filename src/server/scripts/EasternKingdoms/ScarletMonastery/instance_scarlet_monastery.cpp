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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "scarletmonastery.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"

enum AshbringerEventMisc
{
    AB_EFFECT_000                  = 28441,
    AURA_OF_ASHBRINGER             = 28282,

    NPC_COMMANDER_MOGRAINE         = 3976,
    NPC_INQUISITOR_WHITEMANE       = 3977,
    NPC_SCARLET_SORCERER           = 4294,
    NPC_SCARLET_MYRIDON            = 4295,
    NPC_SCARLET_DEFENDER           = 4298,
    NPC_SCARLET_CHAPLAIN           = 4299,
    NPC_SCARLET_WIZARD             = 4300,
    NPC_SCARLET_CENTURION          = 4301,
    NPC_SCARLET_CHAMPION           = 4302,
    NPC_SCARLET_ABBOT              = 4303,
    NPC_SCARLET_MONK               = 4540,
    NPC_FAIRBANKS                  = 4542,
    NPC_HIGHLORD_MOGRAINE          = 16062,

    DOOR_CHAPEL                    = 104591,
    DOOR_HIGH_INQUISITOR_ID        = 104600,

    MODEL_HIGHLORD_MOGRAINE        = 16180,
    MODEL_FAIRBANKS                = 16179,

    SAY_MOGRAINE_ASHBRBINGER_INTRO = 6
};

enum DataTypes
{
    TYPE_MOGRAINE_AND_WHITE_EVENT = 1,
    TYPE_ASHBRINGER_EVENT         = 2,

    DATA_MOGRAINE                 = 3,
    DATA_WHITEMANE                = 4,
    DATA_DOOR_WHITEMANE           = 5,
    DATA_HORSEMAN_EVENT           = 6,
    DATA_VORREL                   = 7,
    DATA_ARCANIST_DOAN            = 8,
    DATA_DOOR_CHAPEL              = 9,

    GAMEOBJECT_PUMPKIN_SHRINE     = 10
};

class instance_scarlet_monastery : public InstanceMapScript
{
public:
    instance_scarlet_monastery() : InstanceMapScript("instance_scarlet_monastery", 189) {}

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_scarlet_monastery_InstanceMapScript(map);
    }

    struct instance_scarlet_monastery_InstanceMapScript : public InstanceScript
    {
        instance_scarlet_monastery_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                // case ENTRY_PUMPKIN_SHRINE: PumpkinShrineGUID = go->GetGUID(); break;
                case DOOR_HIGH_INQUISITOR_ID:
                    _doorHighInquisitorGUID = go->GetGUID();
                    break;
                case DOOR_CHAPEL:
                    _doorChapelGUID = go->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SCARLET_MYRIDON:
                case NPC_SCARLET_DEFENDER:
                case NPC_SCARLET_CENTURION:
                case NPC_SCARLET_SORCERER:
                case NPC_SCARLET_WIZARD:
                case NPC_SCARLET_ABBOT:
                case NPC_SCARLET_MONK:
                case NPC_SCARLET_CHAMPION:
                case NPC_SCARLET_CHAPLAIN:
                case NPC_FAIRBANKS:
                    _ashbringerNpcGUID.emplace(creature->GetGUID());
                    break;
                case NPC_COMMANDER_MOGRAINE:
                    _mograineGUID = creature->GetGUID();
                    _ashbringerNpcGUID.emplace(creature->GetGUID());
                    break;
                case NPC_INQUISITOR_WHITEMANE:
                   _whitemaneGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_MOGRAINE_AND_WHITE_EVENT:
                    if (data == IN_PROGRESS)
                    {
                        DoUseDoorOrButton(_doorHighInquisitorGUID);
                        _encounter = IN_PROGRESS;
                    }
                    if (data == FAIL)
                    {
                        Creature* Whitemane = instance->GetCreature(_whitemaneGUID);
                        if (!Whitemane)
                            return;

                        Creature* Mograine = instance->GetCreature(_mograineGUID);
                        if (!Mograine)
                            return;

                        if (Whitemane->IsAlive() && Mograine->IsAlive())
                        {
                            // When Whitemane emerges from the main gate, Whitemane will stand next to Mograine's corpse and will not reset Whitemane
                            if (Whitemane->IsInCombat())
                                Whitemane->DespawnOnEvade(30s);

                            Mograine->DespawnOnEvade(30s);
                            _encounter = NOT_STARTED;
                            return;
                        }

                        // Whitemane will not be able to fight Mograine again when he dies
                        if (!Whitemane->IsAlive())
                        {
                            Mograine->DespawnOrUnsummon();
                            _encounter = data;
                            return;
                        }

                        if (Whitemane->IsAlive() && !Mograine->IsAlive())
                        {
                            Whitemane->DespawnOnEvade(30s);
                            _encounter = data;
                            return;
                        }

                        _encounter = data;
                    }
                    if (data == SPECIAL)
                        _encounter = SPECIAL;
                    break;
                case TYPE_ASHBRINGER_EVENT:
                    if (data == IN_PROGRESS)
                    {
                        // the ashbringer incident did not sniff out any data from whitemane
                        if (Creature* whitemane = instance->GetCreature(_whitemaneGUID))
                            if (whitemane->IsAlive() && !whitemane->IsInCombat())
                                whitemane->DespawnOrUnsummon();

                        if (GameObject* go = instance->GetGameObject(_doorChapelGUID))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                            go->SetLootState(GO_ACTIVATED);
                            go->SetGameObjectFlag(GO_FLAG_IN_USE);
                        }

                        for (auto const& scarletCathedralNpcGuid : _ashbringerNpcGUID)
                            if (Creature* scarletNpc = instance->GetCreature(scarletCathedralNpcGuid))
                                if (scarletNpc->IsAlive() && !scarletNpc->IsInCombat())
                                    scarletNpc->SetFaction(FACTION_FRIENDLY);
                    }
                    _ashencounter = data;
                    break;
                case DATA_HORSEMAN_EVENT:
                    _encounter = data;
                    break;
                default:
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_MOGRAINE:
                    return _mograineGUID;
                case DATA_WHITEMANE:
                    return _whitemaneGUID;
                case DATA_DOOR_WHITEMANE:
                    return _doorHighInquisitorGUID;
                case DATA_DOOR_CHAPEL:
                    return _doorChapelGUID;
                default:
                    return ObjectGuid::Empty;
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case TYPE_MOGRAINE_AND_WHITE_EVENT:
                    return _encounter;
                    break;
                case DATA_HORSEMAN_EVENT:
                    return _encounter;
                    break;
                case TYPE_ASHBRINGER_EVENT:
                    return _ashencounter;
                    break;
                default:
                    return 0;
                    break;
            }
        }
    private:
        ObjectGuid _doorHighInquisitorGUID;
        ObjectGuid _doorChapelGUID;
        ObjectGuid _mograineGUID;
        ObjectGuid _whitemaneGUID;
        uint32 _encounter{};
        uint32 _ashencounter{};
        GuidSet _ashbringerNpcGUID;
    };
};

class at_scarlet_monastery_cathedral_entrance : public AreaTriggerScript
{
public:
    at_scarlet_monastery_cathedral_entrance() : AreaTriggerScript("at_scarlet_monastery_cathedral_entrance") {}

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (!player->HasAura(AURA_OF_ASHBRINGER))
            return false;

        InstanceScript* instance = player->GetInstanceScript();
        if (!instance || instance->GetData(TYPE_ASHBRINGER_EVENT) != NOT_STARTED)
            return false;

        if (Creature* Mograine = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_MOGRAINE)))
            if (Mograine->IsAlive() && !Mograine->IsInCombat())
                Mograine->AI()->Talk(SAY_MOGRAINE_ASHBRBINGER_INTRO, player);

        instance->SetData(TYPE_ASHBRINGER_EVENT, IN_PROGRESS);
        return true;
    }
};

enum Misc
{
    POINT_MOGRAINE_TO_WHITEMANE = 0,
    POINT_WHITEMANE_TO_MOGRAINE = 0,
    POINT_WHITEMANE_RESURRECTED = 1
};

enum AshbringerEvent
{
    EVENT_MOGRAINE_FACING_PLAYER             = 1,
    EVENT_MOGRAINE_KNEEL                     = 2,
    EVENT_MOGRAINE_EMOTE_TALK3               = 3,
    EVENT_SUMMONED_HIGHLORD_MOGRAINE         = 4,
    EVENT_HIGHLORD_MOGRAINE_MOVE_STOP        = 5,
    EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE  = 6,
    EVENT_MOGRAINE_UNIT_STAND_STATE_STAND    = 7,
    EVENT_MOGRAINE_EMOTE_TALK4               = 8,
    EVENT_HIGHLORD_MOGRAINE_EMOTE_TALK       = 9,
    EVENT_HIGHLORD_MOGRAINE_EMOTE1           = 10,
    EVENT_HIGHLORD_MOGRAINE_EMOTE2           = 11,
    EVENT_HIGHLORD_MOGRAINE_EMOTE3           = 12,
    EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE2 = 13,
    EVENT_MOGRAINE_EMOTE_TALK5               = 14,
    EVENT_HIGHLORD_MOGRAINE_CASTSPELL        = 15,
    EVENT_MOGRAINE_CASTSPELL                 = 16,
    EVENT_HIGHLORD_MOGRAINE_KILL_MOGRAINE    = 17,
    EVENT_ASHBRINGER_OVER                    = 18
};

enum MograineEvents
{
    EVENT_RESURRECTED                       = 1,
    EVENT_SPELL_LAY_ON_HANDS                = 2,
    EVENT_MOGRAINE_SAY                      = 3,
    EVENT_MOVE                              = 4
};

enum WhitemaneEvents
{
    EVENT_SPELL_HOLY_SMITE                  = 1,
    EVENT_SPELL_POWER_WORLD_SHIELD          = 2,
    EVENT_SPELL_HEAL                        = 3,
    EVENT_SPELL_DOMINATE_MIND               = 4,
    EVENT_SLEEP                             = 5,
    EVENT_RESURRECT                         = 6,
    EVENT_SAY                               = 7,
    EVENT_WHITEMANE_EMOTE                   = 8,
    EVENT_DEALY_ATTACK                      = 9
};

enum Spells
{
    //Mograine Spells
    SPELL_CRUSADER_STRIKE           = 14518,
    SPELL_HAMMER_OF_JUSTICE         = 5589,
    SPELL_LAY_ON_HANDS              = 9257,
    SPELL_RETRIBUTION_AURA          = 8990,

    //Whitemanes Spells
    SPELL_SCARLET_RESURRECTION      = 9232,
    SPELL_DEEP_SLEEP                = 9256,
    SPELL_DOMINATE_MIND             = 14515,
    SPELL_HOLY_SMITE                = 9481,
    SPELL_HEAL                      = 12039,
    SPELL_POWER_WORD_SHIELD         = 22187,

    //Highlord Mograine Spells
    SPELL_MOGRAINE_COMETH_DND       = 28688,
    SPELL_FORGIVENESS               = 28697,

    //SPELL_TRANSFORM_GHOST
    SPELL_TRANSFORM_GHOST           = 28443
};

enum Says
{
    //Mograine says
    SAY_MO_AGGRO                    = 0,
    SAY_MO_KILL                     = 1,
    SAY_MO_RESURRECTED              = 2,
    SOUND_DEAD                      = 1326,

    //Mograine Ashbringer Event says
    SAY_MO_AB_TALK3                 = 3,
    SAY_MO_AB_TALK4                 = 4,
    SAY_MO_AB_TALK5                 = 5,

    //Highlord Mograine Ashbringer Event Says
    SAY_HM_AB_TALK0                 = 0,
    SAY_HM_AB_TALK1                 = 1,
    SAY_HM_AB_TALK2                 = 2,

    //Whitemane says
    SAY_WH_INTRO                    = 0,
    SAY_WH_KILL                     = 1,
    SAY_WH_RESURRECT                = 2
};

float const CATHEDRAL_PULL_RANGE = 80.0f; // Distance from the Cathedral doors to where Mograine is standing
Position const SummonedMograinePos = { 1033.4642f, 1399.1022f, 27.337427f, 6.257956981658935546f };

class npc_mograine : public CreatureScript
{
public:
    npc_mograine() : CreatureScript("npc_scarlet_commander_mograine") {}

    struct npc_mograineAI : public ScriptedAI
    {
        npc_mograineAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void AshbringerEvent(uint32 eventId)
        {
            Creature* summonedMograine = me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 100.0f);

            switch (eventId)
            {
                case EVENT_MOGRAINE_FACING_PLAYER:
                    me->SetFacingToObject(_playerWhoStartedAshbringer);
                    _events.ScheduleEvent(EVENT_MOGRAINE_KNEEL, 1s, 3s);
                    break;
                case EVENT_MOGRAINE_KNEEL:
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    _events.ScheduleEvent(EVENT_MOGRAINE_EMOTE_TALK3, 1s, 2s);
                    break;
                case EVENT_MOGRAINE_EMOTE_TALK3:
                    me->AI()->Talk(SAY_MO_AB_TALK3, _playerWhoStartedAshbringer);
                    break;
                case EVENT_SUMMONED_HIGHLORD_MOGRAINE:
                    if (Creature* summonedMograine = me->SummonCreature(NPC_HIGHLORD_MOGRAINE, SummonedMograinePos, TEMPSUMMON_TIMED_DESPAWN, 120000))
                    {
                        summonedMograine->SetFaction(FACTION_FRIENDLY);
                        summonedMograine->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, EQUIP_UNEQUIP);
                        summonedMograine->SetDisplayId(MODEL_HIGHLORD_MOGRAINE);
                        // Sniffing data shows the use of this spell transformation, but the dispersion effect of this spell is not seen in the video
                        summonedMograine->CastSpell(summonedMograine, SPELL_MOGRAINE_COMETH_DND);
                    }
                    _events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_MOVE_STOP, 48500ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_MOVE_STOP:
                    summonedMograine->StopMovingOnCurrentPos();
                    summonedMograine->AI()->Talk(SAY_HM_AB_TALK0, 200ms);
                    _events.ScheduleEvent(EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE, 3000ms);
                    break;
                case EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE:
                    me->SetFacingToObject(summonedMograine);
                    _events.ScheduleEvent(EVENT_MOGRAINE_UNIT_STAND_STATE_STAND, 400ms);
                    break;
                case EVENT_MOGRAINE_UNIT_STAND_STATE_STAND:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    _events.ScheduleEvent(EVENT_MOGRAINE_EMOTE_TALK4, 1200ms);
                    break;
                case EVENT_MOGRAINE_EMOTE_TALK4:
                    me->AI()->Talk(SAY_MO_AB_TALK4);
                    _events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE_TALK, 4600ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE_TALK:
                    summonedMograine->AI()->Talk(SAY_HM_AB_TALK1);
                    _events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE1, 3400ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE1:
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                    _events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE2, 3200ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE2:
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    _events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE3, 3200ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE3:
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                    _events.ScheduleEvent(EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE2, 3200ms);
                    break;
                case EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE2:
                    me->SetFacingToObject(summonedMograine);
                    _events.ScheduleEvent(EVENT_MOGRAINE_EMOTE_TALK5, 1200ms);
                    break;
                case EVENT_MOGRAINE_EMOTE_TALK5:
                    me->AI()->Talk(SAY_MO_AB_TALK5);
                    _events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_CASTSPELL, 3000ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_CASTSPELL:
                    // In Blizzard's servers, after "HIGHLORD_MOGRAINE" uses this spell, "MOGRAINE" will have a visual effect of lightning hits, and the visual effect after the hit is missing here and needs to be fixed
                    summonedMograine->CastSpell(me, SPELL_FORGIVENESS);
                    _events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_KILL_MOGRAINE, 1000ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_KILL_MOGRAINE:
                    me->KillSelf();
                    summonedMograine->AI()->Talk(SAY_HM_AB_TALK2, 2700ms);
                    summonedMograine->DespawnOrUnsummon(6100);
                    break;
                default:
                    break;
            }
        }

        void PullCathedral() // CallForHelp will ignore any npcs without LOS
        {
            std::list<Creature*> creatureList;
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_SCARLET_MONK, CATHEDRAL_PULL_RANGE);
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_SCARLET_ABBOT, CATHEDRAL_PULL_RANGE);
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_SCARLET_CHAMPION, CATHEDRAL_PULL_RANGE);
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_SCARLET_CENTURION, CATHEDRAL_PULL_RANGE);
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_SCARLET_WIZARD, CATHEDRAL_PULL_RANGE);
            GetCreatureListWithEntryInGrid(creatureList, me, NPC_SCARLET_CHAPLAIN, CATHEDRAL_PULL_RANGE);
            for (std::list<Creature*>::iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
            {
                if (Creature* creature = *itr)
                    creature->AI()->AttackStart(me->GetVictim());
            }
        }

        void ScheduleGround()
        {
            _scheduler.Schedule(1s, 5s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_CRUSADER_STRIKE);
                context.Repeat(10s);
            })
                .Schedule(6s, 11s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_HAMMER_OF_JUSTICE);
                context.Repeat(60s);
            });
        }

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            _events.Reset();
            _fakeDeath = false;
            _scheduler.CancelAll();
            if (Creature* summonedMograine = me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 100.0f))
            {
                summonedMograine->DespawnOrUnsummon();
            }
            _sayAshbringer = false;
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (_instance)
                _instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, FAIL);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == POINT_MOGRAINE_TO_WHITEMANE)
            {
                me->SetReactState(REACT_AGGRESSIVE);
                DoCastSelf(SPELL_RETRIBUTION_AURA);
                ScheduleGround();
                if (me->GetVictim())
                    AttackStart(me->GetVictim());
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_MO_AGGRO);
            DoCastSelf(SPELL_RETRIBUTION_AURA);
            _scheduler.Schedule(1s, [this](TaskContext)
            {
                PullCathedral();
            });
            ScheduleGround();
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage > me->GetHealth() && _instance->GetData(TYPE_MOGRAINE_AND_WHITE_EVENT) != SPECIAL && _fakeDeath)
                damage = 0;

            // On first death, fake death and open door, as well as initiate whitemane if exist
            if (damage > me->GetHealth() && !_fakeDeath)
            {
                // On first death, fake death and open door, as well as initiate whitemane if exist
                if (Creature* Whitemane = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_WHITEMANE)))
                {
                    _instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, IN_PROGRESS);
                    Whitemane->AI()->Talk(SAY_WH_INTRO, me);
                    float fx, fy, fz;
                    me->GetContactPoint(Whitemane, fx, fy, fz, 5.0f);
                    Whitemane->GetMotionMaster()->MovePoint(POINT_WHITEMANE_TO_MOGRAINE, fx, fy, fz);
                    Whitemane->SetReactState(REACT_AGGRESSIVE);
                }
                me->GetMotionMaster()->MovementExpired();
                me->GetMotionMaster()->MoveIdle();
                me->SetHealth(0);
                me->PlayDirectSound(SOUND_DEAD);
                // Remove all beneficial auras
                me->RemoveAura(SPELL_RETRIBUTION_AURA);
                me->AttackStop();
                me->SetStandState(UNIT_STAND_STATE_DEAD);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->ClearAllReactives();
                me->SetReactState(REACT_PASSIVE);
                _scheduler.CancelAll();
                _fakeDeath = true;
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer() && !_sayAshbringer)
                Talk(SAY_MO_KILL);
        }

        void SpellHit(Unit* who, SpellInfo const* spell) override
        {
            if (!_instance)
                return;

                // When hit with resurrection say text
            if (spell->Id == SPELL_SCARLET_RESURRECTION)
            {
                _instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, SPECIAL);
                _events.ScheduleEvent(EVENT_RESURRECTED, 3500ms);
            }

            if (who && spell->Id == AB_EFFECT_000 && !_sayAshbringer)// Ashbringer Event
            {
                me->SetFaction(FACTION_FRIENDLY);
                me->GetMotionMaster()->MoveIdle();
                _playerWhoStartedAshbringer = who->ToPlayer();
                // Standing delay inside the cathedral
                _sayAshbringer = true;
                _events.ScheduleEvent(EVENT_MOGRAINE_FACING_PLAYER, 0ms);
                _events.ScheduleEvent(EVENT_SUMMONED_HIGHLORD_MOGRAINE, 20ms);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_sayAshbringer)
            {
                _events.Update(diff);
                while (uint32 eventId = _events.ExecuteEvent())
                {
                    AshbringerEvent(eventId);
                }
            }

            if (!UpdateVictim() || _sayAshbringer)
                return;

            _scheduler.Update(diff);

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_RESURRECTED:
                        me->SetReactState(REACT_PASSIVE);
                        me->AttackStop();
                        me->InterruptNonMeleeSpells(false);
                        // How do I get rid of the animation from UNIT_STAND_STATE_DEAD to UNIT_STAND_STATE_STAND?
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        _events.ScheduleEvent(EVENT_SPELL_LAY_ON_HANDS, 0s);
                        break;
                    case EVENT_SPELL_LAY_ON_HANDS:
                        if (Unit* Whitemane = ObjectAccessor::GetUnit(*me, _instance->GetGuidData(DATA_WHITEMANE)))
                        {
                            if (Whitemane->IsAlive())
                                me->CastSpell(Whitemane, SPELL_LAY_ON_HANDS);
                        }
                        _events.ScheduleEvent(EVENT_MOGRAINE_SAY, 200ms);
                        break;
                    case EVENT_MOGRAINE_SAY:
                        if (Unit* Whitemane = ObjectAccessor::GetUnit(*me, _instance->GetGuidData(DATA_WHITEMANE)))
                        {
                            Talk(SAY_MO_RESURRECTED, Whitemane);
                        }
                        _events.ScheduleEvent(EVENT_MOVE, 3000ms);
                        break;
                    case EVENT_MOVE:
                        if (Unit* Whitemane = ObjectAccessor::GetUnit(*me, _instance->GetGuidData(DATA_WHITEMANE)))
                        {
                            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                            float fx, fy, fz;
                            Whitemane->GetContactPoint(me, fx, fy, fz, 0.0f);
                            me->GetMotionMaster()->MovePoint(POINT_MOGRAINE_TO_WHITEMANE, fx, fy, fz);
                        }
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        bool _sayAshbringer = false;
        bool _fakeDeath = false;
        EventMap _events;
        InstanceScript* _instance;
        TaskScheduler _scheduler;
        Player* _playerWhoStartedAshbringer = nullptr;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_mograineAI>(creature);
    }
};

class boss_high_inquisitor_whitemane : public CreatureScript
{
public:
    boss_high_inquisitor_whitemane() : CreatureScript("boss_high_inquisitor_whitemane") {}

    struct boss_high_inquisitor_whitemaneAI : public ScriptedAI
    {
        boss_high_inquisitor_whitemaneAI(Creature* creature) : ScriptedAI(creature)
        {
            _instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
            _victimbuff = nullptr;
            _events.Reset();
            _phase = 0;
        }

        void JustRespawned() override
        {
            if (_instance)
                _instance->DoUseDoorOrButton(_instance->GetGuidData(DATA_DOOR_WHITEMANE));

            ScriptedAI::JustRespawned();
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (_instance)
                _instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, FAIL);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, 10ms);
            _events.ScheduleEvent(EVENT_SPELL_POWER_WORLD_SHIELD, 22s, 45s);
            // This spell was not used during the single-player test on the Blizzard server,
            // it should take 2 people, and the chance of using it should be low
            _events.ScheduleEvent(EVENT_SPELL_DOMINATE_MIND, 5s, 10s);
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            // The player cannot kill her until she is releashed. Retain at least 1 life
            if (_phase != 2 && damage >= me->GetHealth())
            {
                damage = 0;
                me->SetHealth(1);
            }
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == POINT_WHITEMANE_RESURRECTED)
            {
                // This determines whether the target buff exists
                // Use don't know why use me->GetVictim() Unable to get the target
                if (_victimbuff && _victimbuff->HasAura(SPELL_DEEP_SLEEP))
                    // Wait 5 seconds to revive while the debuff is still present on the player
                    _events.ScheduleEvent(EVENT_RESURRECT, 5s);
                else
                    _events.ScheduleEvent(EVENT_RESURRECT, 1s);
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer())
                Talk(SAY_WH_KILL);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (_phase == 0 && me->HealthBelowPct(50))
            {
                _events.Reset();
                _phase = 1;
                _events.ScheduleEvent(EVENT_SLEEP, 0ms);
            }

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SPELL_HOLY_SMITE:
                        if (Unit* target = me->GetVictim())
                        {
                            me->GetMotionMaster()->MoveChase(target, 30.0f);

                            if (DoCast(target, SPELL_HOLY_SMITE) != SPELL_CAST_OK)
                            {
                                me->GetMotionMaster()->MoveChase(target);
                                _events.Repeat(1200ms);
                                break;
                            }

                            if (me->GetExactDist2d(target) < 5.0f)
                            {
                                _events.Repeat(4500ms, 5s);
                                break;
                            }
                        }
                        _events.Repeat(2600ms, 3000ms);
                        break;
                    case EVENT_SPELL_POWER_WORLD_SHIELD:
                        // Since mograine has 0 HP, the DoSelectLowestHpFriendly function will always try to use it on him, not on himself
                        if (_phase != 2)
                        {
                            DoCast(me, SPELL_POWER_WORD_SHIELD);
                            _events.Repeat(22s, 35s);
                            break;
                        }

                        if (Unit* target = DoSelectLowestHpFriendly(40.0f))
                        {
                            if (DoCast(target, SPELL_POWER_WORD_SHIELD) == SPELL_CAST_OK)
                            {
                                _events.Repeat(22s, 35s);
                                break;
                            }
                        }
                       _events.Repeat(1s);
                        break;
                    case EVENT_SPELL_HEAL:
                        if (Unit* target = DoSelectLowestHpFriendly(40.0f))
                        {
                            if (target->HealthBelowPct(75))
                            {
                                DoCast(target, SPELL_HEAL);
                                _events.Repeat(17500ms, 20s);
                                break;
                            }
                        }
                        _events.Repeat(5s);
                        break;
                    case EVENT_SPELL_DOMINATE_MIND:
                        // The list of hates is greater than 1
                        if (me->GetThreatMgr().GetThreatList().size() > 1)
                        {
                            if (!urand(0, 20))// 1/20 Used for testing urand(0, 20)
                            {
                                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                                {
                                    DoCast(target, SPELL_DOMINATE_MIND);
                                    _events.Repeat(20s, 30s);
                                    break;
                                }
                            }
                        }
                        _events.Repeat(10s);
                        break;
                    case EVENT_SLEEP:
                        // This saves the target's "SLEEP" buff after the move is complete
                        _victimbuff = me->GetVictim();
                        me->SetReactState(REACT_PASSIVE);
                        DoCast(SPELL_DEEP_SLEEP);
                        me->AttackStop();

                        if (Creature* mograine = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_MOGRAINE)))
                        {
                            if (me->GetDistance(mograine) > 0.5f)
                            {
                                float fx, fy, fz;
                                mograine->GetContactPoint(me, fx, fy, fz, 0.5f);
                                me->GetMotionMaster()->MovePoint(POINT_WHITEMANE_RESURRECTED, fx, fy, fz);
                                break;
                            }
                        }
                        _events.ScheduleEvent(EVENT_RESURRECT, 3200ms);
                        break;
                    case EVENT_RESURRECT:
                        if (Creature* mograine = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_MOGRAINE)))
                        {
                            DoCast(mograine, SPELL_SCARLET_RESURRECTION);
                        }
                        _events.ScheduleEvent(EVENT_SAY,1900ms);
                        break;
                    case  EVENT_SAY:
                        Talk(SAY_WH_RESURRECT);
                        _events.ScheduleEvent(EVENT_WHITEMANE_EMOTE, 1400ms);
                        break;
                    case EVENT_WHITEMANE_EMOTE:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                        _phase = 2;
                        _events.ScheduleEvent(EVENT_DEALY_ATTACK, 1400ms);
                        break;
                    case EVENT_DEALY_ATTACK:
                        me->SetReactState(REACT_AGGRESSIVE);
                        _events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, 10ms);
                        _events.ScheduleEvent(EVENT_SPELL_HEAL, 15s);
                        _events.ScheduleEvent(EVENT_SPELL_POWER_WORLD_SHIELD, 10s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* _instance;
        Unit* _victimbuff = nullptr;
        EventMap _events;
        uint8 _phase{};
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<boss_high_inquisitor_whitemaneAI>(creature);
    }
};

class npc_fairbanks : public CreatureScript
{
public:
    npc_fairbanks() : CreatureScript("npc_fairbanks") {}

    struct npc_fairbanksAI : public SmartAI
    {
        npc_fairbanksAI(Creature* creature) : SmartAI(creature) {}

        void Reset() override
        {
            _SayAshbringer = false;
        }

        // Ready to move to SmartAI
        void SpellHit(Unit* who, SpellInfo const* spell) override
        {
            if (who && spell->Id == AB_EFFECT_000 && !_SayAshbringer)
            {
                me->SetFaction(FACTION_FRIENDLY);
                me->SetFacingToObject(who);
                // There is a delay in sniffing 1615ms
                // The sniffer uses this spell, but without the visual effect of the spell.
                me->CastSpell(me, SPELL_TRANSFORM_GHOST);
                // delay 10ms
                me->SetDisplayId(MODEL_FAIRBANKS);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                _SayAshbringer = true;
            }
        }

    private:
        bool _SayAshbringer = false;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_fairbanksAI>(creature);
    }
};

void AddSC_instance_scarlet_monastery()
{
    new instance_scarlet_monastery();
    new npc_fairbanks();
    new npc_mograine();
    new boss_high_inquisitor_whitemane();
    new at_scarlet_monastery_cathedral_entrance();
}
