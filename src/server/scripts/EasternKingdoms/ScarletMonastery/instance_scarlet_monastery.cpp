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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SmartAI.h"
#include "scarletmonastery.h"

enum AshbringerEventMisc
{
    ABE_ffect_000 = 28441,
    AURA_OF_ASHBRINGER = 28282,

    NPC_SCARLET_MYRIDON = 4295,
    NPC_SCARLET_DEFENDER = 4298,
    NPC_SCARLET_CENTURION = 4301,
    NPC_SCARLET_SORCERER = 4294,
    NPC_SCARLET_WIZARD = 4300,
    NPC_SCARLET_ABBOT = 4303,
    NPC_SCARLET_MONK = 4540,
    NPC_SCARLET_CHAMPION = 4302,
    NPC_SCARLET_CHAPLAIN = 4299,
    NPC_FAIRBANKS = 4542,

    NPC_COMMANDER_MOGRAINE = 3976,
    NPC_INQUISITOR_WHITEMANE = 3977,
    DOOR_CHAPEL = 104591,
    DOOR_HIGH_INQUISITOR_ID = 104600,
    TALK_MOGRAINE_ASHBRBINGER_INTRO = 6,
};

enum DataTypes
{
    TYPE_MOGRAINE_AND_WHITE_EVENT   =   1,

    DATA_MOGRAINE                   =   2,
    DATA_WHITEMANE                  =   3,
    DATA_DOOR_WHITEMANE             =   4,

    DATA_HORSEMAN_EVENT             =   5,
    GAMEOBJECT_PUMPKIN_SHRINE       =   6,

    DATA_VORREL                     =   7,
    DATA_ARCANIST_DOAN              =   8
};

class instance_scarlet_monastery : public InstanceMapScript
{
public:
    instance_scarlet_monastery() : InstanceMapScript("instance_scarlet_monastery", 189) { }

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
                //case ENTRY_PUMPKIN_SHRINE: PumpkinShrineGUID = go->GetGUID(); break;
                case DOOR_HIGH_INQUISITOR_ID:
                    DoorHighInquisitorGUID = go->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_COMMANDER_MOGRAINE:
                    MograineGUID = creature->GetGUID();
                    break;
                case NPC_INQUISITOR_WHITEMANE:
                    WhitemaneGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch(type)
            {
                case TYPE_MOGRAINE_AND_WHITE_EVENT:
                    if (data == IN_PROGRESS)
                    {
                        DoUseDoorOrButton(DoorHighInquisitorGUID);
                        encounter = IN_PROGRESS;
                    }
                    if (data == FAIL)
                    {
                        DoUseDoorOrButton(DoorHighInquisitorGUID);
                        encounter = FAIL;
                    }
                    if (data == SPECIAL)
                        encounter = SPECIAL;
                    break;
                case DATA_HORSEMAN_EVENT:
                    encounter = data;
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
                    return MograineGUID;
                case DATA_WHITEMANE:
                    return WhitemaneGUID;
                case DATA_DOOR_WHITEMANE:
                    return DoorHighInquisitorGUID;
                default:
                    return ObjectGuid::Empty;
                    break;
            }
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_MOGRAINE_AND_WHITE_EVENT)
                return encounter;
            else if (type == DATA_HORSEMAN_EVENT)
                return encounter;
            return 0;
        }
    private:
        ObjectGuid DoorHighInquisitorGUID;
        ObjectGuid MograineGUID;
        ObjectGuid WhitemaneGUID;
        uint32 encounter;
    };
};




class at_scarlet_monastery_cathedral_entrance : public OnlyOnceAreaTriggerScript
{
public:
    at_scarlet_monastery_cathedral_entrance() : OnlyOnceAreaTriggerScript("at_scarlet_monastery_cathedral_entrance") {}

    bool _OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (player->HasAura(AURA_OF_ASHBRINGER))
            {
                Creature* commanderMograine = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_MOGRAINE));
                if (commanderMograine)
                {
                    std::list<Creature*> ScarletList;
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_MYRIDON, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_DEFENDER, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CENTURION, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_SORCERER, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_WIZARD, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_ABBOT, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_MONK, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CHAMPION, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_SCARLET_CHAPLAIN, 4000.0f);
                    player->GetCreatureListWithEntryInGrid(ScarletList, NPC_FAIRBANKS, 4000.0f);


                    ScarletList.push_back(commanderMograine);

                    if (!ScarletList.empty())
                    {
                        for (Creature* itr : ScarletList)
                        {
                            itr->SetFaction(FACTION_FRIENDLY);
                        }
                    }
                    if (commanderMograine->IsAlive())
                        commanderMograine->AI()->Talk(TALK_MOGRAINE_ASHBRBINGER_INTRO);

                    if (GameObject* chapelDoor = player->FindNearestGameObject(DOOR_CHAPEL, 4000.0f))
                    {
                    
                        //instance->DoUseDoorOrButton(chapelDoor->GetGUID());//Received //https://github.com/azerothcore/azerothcore-wotlk/commit/2779833768bbe9967006d6d16888dace05b4bcb6 Impact The door cannot be opened                       
                        chapelDoor->SetGoState(GO_STATE_ACTIVE);
                        chapelDoor->SetLootState(GO_ACTIVATED);
                        chapelDoor->SetGameObjectFlag(GO_FLAG_IN_USE);
                    }
                    return true;
                }
            }
        }
        return false;
    }
};

enum ScarletMonasteryTrashMisc
{
    SAY_WELCOME = 0,
    AURA_ASHBRINGER = 28282,
    NPC_HIGHLORD_MOGRAINE = 16062,
    NPC_HIGHLORD_MOGRAINE_MOD = 16180,
    SPELL_COSMETIC_CHAIN = 45537,
    SPELL_COSMETIC_EXPLODE = 45935,
    SPELL_FORGIVENESS = 28697,
};

enum AshbringerEvent
{
    EVENT_MOGRAINE_FACING_PLAYER = 1,
    EVENT_MOGRAINE_KNEEL,
    EVENT_MOGRAINE_EMOTE_TALK3,
    EVENT_SUMMONED_HIGHLORD_MOGRAINE,
    EVENT_HIGHLORD_MOGRAINE_MOVE_STOP,
    EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE,
    EVENT_MOGRAINE_UNIT_STAND_STATE_STAND,
    EVENT_MOGRAINE_EMOTE_TALK4,
    EVENT_HIGHLORD_MOGRAINE_EMOTE_TALK,
    EVENT_HIGHLORD_MOGRAINE_EMOTE1,
    EVENT_HIGHLORD_MOGRAINE_EMOTE2,
    EVENT_HIGHLORD_MOGRAINE_EMOTE3,
    EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE2,
    EVENT_MOGRAINE_EMOTE_TALK5,
    EVENT_HIGHLORD_MOGRAINE_CASTSPELL,
    EVENT_MOGRAINE_CASTSPELL,
    EVENT_HIGHLORD_MOGRAINE_KILL_MOGRAINE,
    EVENT_ASHBRINGER_OVER
};

enum MograineEvents
{
    EVENT_SPELL_CRUSADER_STRIKE     =   1,
    EVENT_SPELL_HAMMER_OF_JUSTICE   =   2,
    EVENT_PULL_CATHEDRAL            =   3
};

enum WhitemaneEvents
{
    EVENT_SPELL_HOLY_SMITE          =   1,
    EVENT_SPELL_POWER_WORLD_SHIELD  =   2,
    EVENT_SPELL_HEAL                =   3
};

enum Spells
{
    //Mograine Spells
    SPELL_CRUSADER_STRIKE           =   14518,
    SPELL_HAMMER_OF_JUSTICE         =   5589,
    SPELL_LAY_ON_HANDS              =   9257,
    SPELL_RETRIBUTION_AURA          =   8990,
    SPELL_PERMANENT_FEIGN_DEATH     =   29266,

    //Whitemanes Spells
    SPELL_SCARLET_RESURRECTION      =   9232,
    SPELL_DEEP_SLEEP                =   9256,
    SPELL_DOMINATE_MIND             =   14515,
    SPELL_HOLY_SMITE                =   9481,
    SPELL_HEAL                      =   12039,
    SPELL_POWER_WORD_SHIELD         =   22187,

    // Highlord Mograine Spells
    SPELL_MOGRAINE_COMETH_DND = 28688,

    // SPELL_TRANSFORM_GHOST
    SPELL_TRANSFORM_GHOST = 28443
};

enum Says
{
    //Mograine says
    SAY_MO_AGGRO                    =   0,
    SAY_MO_KILL                     =   1,
    SAY_MO_RESURRECTED              =   2,

    //Whitemane says
    SAY_WH_INTRO                    =   0,
    SAY_WH_KILL                     =   1,
    SAY_WH_RESURRECT                =   2,
};

float const CATHEDRAL_PULL_RANGE    = 80.0f; // Distance from the Cathedral doors to where Mograine is standing

class npc_mograine : public CreatureScript
{
public:
    npc_mograine() : CreatureScript("npc_scarlet_commander_mograine") { }

    struct npc_mograineAI : public ScriptedAI
    {
        npc_mograineAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        void AshbringerEvent(uint32 eventId)
        {
            Creature* summonedMograine = me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 100.0f);

            switch (eventId)
            {
                case  EVENT_MOGRAINE_FACING_PLAYER:
                me->SetFacingToObject(playerWhoStartedAshbringer);
                events.ScheduleEvent(EVENT_MOGRAINE_KNEEL, 1s, 3s);
                break;
                case EVENT_MOGRAINE_KNEEL:
                    me->SetSheath(SHEATH_STATE_UNARMED);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    events.ScheduleEvent(EVENT_MOGRAINE_EMOTE_TALK3, 1s, 2s);
                    break;
                case EVENT_MOGRAINE_EMOTE_TALK3:
                    Talk(3, playerWhoStartedAshbringer);
                    break;
                case EVENT_SUMMONED_HIGHLORD_MOGRAINE:
                    // 03/29/2023 00:13:49.658 Number: 6862
                    if (Creature* summonedMograine = me->SummonCreature(NPC_HIGHLORD_MOGRAINE, 1033.4642f, 1399.1022f, 27.337427f, 6.257956981658935546f, TEMPSUMMON_TIMED_DESPAWN, 120000))
                    {
                        // 03/29/2023 00:13:49.658
                        summonedMograine->SetFaction(FACTION_FRIENDLY);
                        summonedMograine->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID + 0, EQUIP_UNEQUIP);
                        summonedMograine->SetSpeed(MOVE_WALK, 1.0f);
                        summonedMograine->SetDisplayId(NPC_HIGHLORD_MOGRAINE_MOD);//
                        summonedMograine->setActive(true);
                        summonedMograine->CastSpell(summonedMograine, SPELL_MOGRAINE_COMETH_DND, false); // Sniffing data shows the use of this spell transformation, but the dispersion effect of this spell is not seen in the video
                    }
                    events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_MOVE_STOP, 48546ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_MOVE_STOP:
                    summonedMograine->StopMovingOnCurrentPos();
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    summonedMograine->AI()->Talk(0, 214ms);
                    events.ScheduleEvent(EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE, 3024ms);
                    break;
                case EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE:
                    me->SetFacingToObject(summonedMograine);
                    events.ScheduleEvent(EVENT_MOGRAINE_UNIT_STAND_STATE_STAND, 403ms);
                    break;
                case EVENT_MOGRAINE_UNIT_STAND_STATE_STAND:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->SetSheath(SHEATH_STATE_MELEE);
                    events.ScheduleEvent(EVENT_MOGRAINE_EMOTE_TALK4, 809ms);
                    break;
                case EVENT_MOGRAINE_EMOTE_TALK4:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                    me->AI()->Talk(4, 209ms);
                    events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE_TALK, 4636ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE_TALK:
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                    summonedMograine->AI()->Talk(1, me, 10ms);
                    events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE1, 3429ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE1: 
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                    events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE2, 3236ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE2:
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_EMOTE3, 3243ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_EMOTE3: 
                    summonedMograine->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                    events.ScheduleEvent(EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE2, 3232ms);
                    break;
                case EVENT_MOGRAINE_FACING_HIGHLORD_MOGRAINE2: 
                    me->SetFacingToObject(summonedMograine);
                    events.ScheduleEvent(EVENT_MOGRAINE_EMOTE_TALK5, 1210ms);
                    break;
                case EVENT_MOGRAINE_EMOTE_TALK5:
                    me->SetSheath(SHEATH_STATE_UNARMED);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_BEG);
                    me->AI()->Talk(5, 214ms);
                    events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_CASTSPELL, 3022ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_CASTSPELL:
                    summonedMograine->CastSpell(me, SPELL_FORGIVENESS, false);
                    //events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_KILL_MOGRAINE, 1010ms);
                    events.ScheduleEvent(EVENT_MOGRAINE_CASTSPELL, 1000ms); // case 14 hack fix time
                    break;
                case EVENT_MOGRAINE_CASTSPELL:
                    // Hack fix The lightning effect of mograine being hit by a spell
                    me->CastSpell(me, SPELL_COSMETIC_EXPLODE, false);
                    events.ScheduleEvent(EVENT_HIGHLORD_MOGRAINE_KILL_MOGRAINE, 100ms);
                    break;
                case EVENT_HIGHLORD_MOGRAINE_KILL_MOGRAINE:
                    Unit::Kill(me, me, true);
                    summonedMograine->AI()->Talk(2, 2764ms);
                    instance->SetData(DATA_MOGRAINE, DONE);
                    summonedMograine->DespawnOrUnsummon(6190);
                    me->setActive(false);
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

        void Reset() override
        {
            //Incase wipe during phase that mograine fake death
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
            SayAshbringer = false;
            timer = 0;
            step = 1;
            hasDied = false;
            heal = false;
            fakeDeath = false;
            me->setActive(false);
            if (Creature* summonedMograine = me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 100.0f))
            {
                summonedMograine->setActive(false);
                summonedMograine->DespawnOrUnsummon();
            }
            events.Reset();
        }       

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_MO_AGGRO);
            me->CastSpell(me, SPELL_RETRIBUTION_AURA, true);
            events.ScheduleEvent(EVENT_PULL_CATHEDRAL, 1s); // Has to be done via event, otherwise mob aggroing Mograine DOES NOT aggro the room
            events.ScheduleEvent(EVENT_SPELL_CRUSADER_STRIKE, 1s, 5s);
            events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 6s, 11s);
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage < me->GetHealth() || hasDied || fakeDeath)
                return;

            //On first death, fake death and open door, as well as initiate whitemane if exist
            if (Unit* Whitemane = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_WHITEMANE)))
            {
                instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, IN_PROGRESS);
                Whitemane->GetMotionMaster()->MovePoint(1, 1163.113370f, 1398.856812f, 32.527786f);
                me->GetMotionMaster()->MovementExpired();
                me->GetMotionMaster()->MoveIdle();
                me->SetHealth(0);
                if (me->IsNonMeleeSpellCast(false))
                    me->InterruptNonMeleeSpells(false);
                me->ClearComboPointHolders();
                me->RemoveAllAuras();
                me->ClearAllReactives();
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->CastSpell(me, SPELL_PERMANENT_FEIGN_DEATH, true);

                hasDied = true;
                fakeDeath = true;
                damage = 0;
                ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_WHITEMANE))->SetInCombatWithZone();
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_MO_KILL);
        }

        void SpellHit(Unit* who, SpellInfo const* spell) override
        {
            //When hit with resurrection say text
            if (spell->Id == SPELL_SCARLET_RESURRECTION)
            {
                Talk(SAY_MO_RESURRECTED);
                fakeDeath = false;
                instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, SPECIAL);
            }

            if (who && spell->Id == ABE_ffect_000 && !SayAshbringer)
            {
                me->SetFaction(FACTION_FRIENDLY);
                me->GetMotionMaster()->MoveIdle();
                playerWhoStartedAshbringer = who->ToPlayer();
                // Standing delay inside the cathedral
                SayAshbringer = true;
                me->setActive(true);
                events.ScheduleEvent(EVENT_MOGRAINE_FACING_PLAYER, 0ms);
                events.ScheduleEvent(EVENT_SUMMONED_HIGHLORD_MOGRAINE, 20ms);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (SayAshbringer)
            {
                events.Update(diff);
                while (uint32 eventId = events.ExecuteEvent())
                {
                    AshbringerEvent(eventId);
                }
            }

            if (!UpdateVictim() || SayAshbringer)
                return;

            if (hasDied && !heal && instance->GetData(TYPE_MOGRAINE_AND_WHITE_EVENT) == SPECIAL)
            {
                //On resurrection, stop fake death and heal whitemane and resume fight
                if (Unit* Whitemane = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_WHITEMANE)))
                {
                    //Incase wipe during phase that mograine fake death
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
                    me->CastSpell(me, SPELL_RETRIBUTION_AURA, true);
                    me->CastSpell(Whitemane, SPELL_LAY_ON_HANDS, true);
                    events.ScheduleEvent(EVENT_SPELL_CRUSADER_STRIKE, 1s, 5s);
                    events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 6s, 11s);
                    if (me->GetVictim())
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                    heal = true;
                }
            }

            //This if-check to make sure mograine does not attack while fake death
            if (fakeDeath)
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_SPELL_CRUSADER_STRIKE:
                        me->CastSpell(me->GetVictim(), SPELL_CRUSADER_STRIKE, true);
                        events.ScheduleEvent(EVENT_SPELL_CRUSADER_STRIKE, 10s);
                        break;
                    case EVENT_SPELL_HAMMER_OF_JUSTICE:
                        me->CastSpell(me->GetVictim(), SPELL_HAMMER_OF_JUSTICE, true);
                        events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 60s);
                        break;
                    case EVENT_PULL_CATHEDRAL:
                        PullCathedral();
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

    private:
        bool SayAshbringer = false;
        int timer = 0;
        int step = 1;
        bool hasDied=false;
        bool heal=false;
        bool fakeDeath=false;
        Player* playerWhoStartedAshbringer = nullptr;
        EventMap events;
        InstanceScript* instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_mograineAI>(creature);
    }
};

class boss_high_inquisitor_whitemane : public CreatureScript
{
public:
    boss_high_inquisitor_whitemane() : CreatureScript("boss_high_inquisitor_whitemane") { }

    struct boss_high_inquisitor_whitemaneAI : public ScriptedAI
    {
        boss_high_inquisitor_whitemaneAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        void Reset() override
        {
            canResurrectCheck = false;
            canResurrect = false;
            Wait_Timer = 7000;
            Heal_Timer = 10000;
        }

        void JustReachedHome() override
        {
            instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, FAIL);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_WH_INTRO);
            events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, 1s, 3s);
            events.ScheduleEvent(EVENT_SPELL_POWER_WORLD_SHIELD, 6s);
            events.ScheduleEvent(EVENT_SPELL_HEAL, 9s);
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!canResurrectCheck && damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_WH_KILL);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (canResurrect)
            {
                //When casting resuruction make sure to delay so on rez when reinstate battle deepsleep runs out
                if (Wait_Timer <= diff)
                {
                    if (ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_MOGRAINE)))
                    {
                        DoCast(SPELL_SCARLET_RESURRECTION);
                        Talk(SAY_WH_RESURRECT);
                        canResurrect = false;
                    }
                }
                else Wait_Timer -= diff;
            }

            //Cast Deep sleep when health is less than 50%
            if (!canResurrectCheck && !HealthAbovePct(50))
            {
                if (me->IsNonMeleeSpellCast(false))
                    me->InterruptNonMeleeSpells(false);

                me->CastSpell(me->GetVictim(), SPELL_DEEP_SLEEP, true);
                canResurrectCheck = true;
                canResurrect = true;
                return;
            }

            //while in "resurrect-mode", don't do anything
            if (canResurrect)
                return;

            //If we are <75% hp cast healing spells at self or Mograine
            if (Heal_Timer <= diff)
            {
                Creature* target = nullptr;

                if (!HealthAbovePct(75))
                    target = me;

                if (Creature* mograine = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_MOGRAINE)))
                {
                    // checking canResurrectCheck prevents her healing Mograine while he is "faking death"
                    if (canResurrectCheck && mograine->IsAlive() && !mograine->HealthAbovePct(75))
                        target = mograine;
                }

                if (target)
                    me->CastSpell(target, SPELL_HEAL, false);

                Heal_Timer = 13000;
            }
            else Heal_Timer -= diff;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SPELL_POWER_WORLD_SHIELD:
                        me->CastSpell(me, SPELL_POWER_WORD_SHIELD, false);
                        events.ScheduleEvent(EVENT_SPELL_POWER_WORLD_SHIELD, 15s);
                        break;
                    case EVENT_SPELL_HOLY_SMITE:
                        me->CastSpell(me->GetVictim(), SPELL_HOLY_SMITE, false);
                        events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, 6s);
                        break;
                    case EVENT_SPELL_HEAL:
                        me->CastSpell(me, SPELL_HEAL, false);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        InstanceScript* instance;
        uint32 Heal_Timer;
        uint32 Wait_Timer;
        bool canResurrectCheck;
        bool canResurrect;
        EventMap events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<boss_high_inquisitor_whitemaneAI>(creature);
    }
};

class npc_fairbanks : public CreatureScript
{
public:
    npc_fairbanks() : CreatureScript("npc_fairbanks") { }

    struct npc_fairbanksAI : public SmartAI
    {
        npc_fairbanksAI(Creature* creature) : SmartAI(creature) { }

        void Reset() override
        {
            SayAshbringer = false;
        }

        void SpellHit(Unit* who, SpellInfo const* spell) override
        {
            if (who && spell->Id == ABE_ffect_000 && !SayAshbringer)            {
                        
                        me->SetFaction(FACTION_FRIENDLY);
                        me->SetFacingToObject(who);
                        //There is a delay in sniffing 1615ms
                        me->CastSpell(me, SPELL_TRANSFORM_GHOST); //The sniffer uses this spell, but without the visual effect of the spell, using spell 57767 as a visual effect instead
                        me->CastSpell(me, 57767, true);//
                        //delay 10ms
                        me->SetDisplayId(16179);
                        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        SayAshbringer = true;
            }
        }
    private:
        bool SayAshbringer = false;
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
