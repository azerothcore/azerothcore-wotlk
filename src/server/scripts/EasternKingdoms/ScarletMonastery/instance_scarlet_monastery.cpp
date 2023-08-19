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
    AURA_OF_ASHBRINGER              =   28282,
    NPC_SCARLET_MYRIDON             =   4295,
    NPC_SCARLET_DEFENDER            =   4298,
    NPC_SCARLET_CENTURION           =   4301,
    NPC_SCARLET_SORCERER            =   4294,
    NPC_SCARLET_WIZARD              =   4300,
    NPC_SCARLET_ABBOT               =   4303,
    NPC_SCARLET_MONK                =   4540,
    NPC_SCARLET_CHAMPION            =   4302,
    NPC_SCARLET_CHAPLAIN            =   4299,
    NPC_FAIRBANKS                   =   4542,
    NPC_COMMANDER_MOGRAINE          =   3976,
    NPC_INQUISITOR_WHITEMANE        =   3977,
    DELAY_MS_KNEEL_MIN              =   1000,
    DELAY_MS_KNEEL_MAX              =   3000,
    DELAY_MS_TALK_MIN               =   1000,
    DELAY_MS_TALK_MAX               =   2000,
    DOOR_CHAPEL                     =   104591,
    DOOR_HIGH_INQUISITOR_ID         =   104600,
    TALK_MOGRAINE_ASHBRBINGER_INTRO =   6,

    GOSSIP_ITEM_FAIRBANKS_1         =   5873,
    GOSSIP_ITEM_FAIRBANKS_2         =   5874,
    GOSSIP_ITEM_FAIRBANKS_3         =   5875,
    GOSSIP_ITEM_FAIRBANKS_4         =   5876,
    GOSSIP_ITEM_FAIRBANKS_5         =   5877,
    GOSSIP_ITEM_FAIRBANKS_6         =   5878,
    GOSSIP_ITEM_FAIRBANKS_7         =   5879,
    GOSSIP_ITEM_FAIRBANKS_8         =   5880,
    GOSSIP_ITEM_FAIRBANKS_9         =   5881,
    GOSSIP_ITEM_FAIRBANKS_10        =   5882,
    GOSSIP_ITEM_FAIRBANKS_11        =   5883,
    GOSSIP_ITEM_FAIRBANKS_12        =   5884,
    GOSSIP_ITEM_FAIRBANKS_13        =   5885,
    GOSSIP_ITEM_FAIRBANKS_14        =   5886,
    GOSSIP_ITEM_FAIRBANKS_15        =   5887,
    GOSSIP_ITEM_FAIRBANKS_16        =   5888,
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
            }

            return ObjectGuid::Empty;
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
                        for (std::list<Creature*>::iterator itr = ScarletList.begin(); itr != ScarletList.end(); itr++)
                        {
                            (*itr)->SetFaction(FACTION_FRIENDLY);
                        }
                    }

                    commanderMograine->AI()->Talk(TALK_MOGRAINE_ASHBRBINGER_INTRO);
                    if (GameObject* chapelDoor = player->FindNearestGameObject(DOOR_CHAPEL, 4000.0f)) {
                        instance->DoUseDoorOrButton(chapelDoor->GetGUID());
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
    //FACTION_FRIENDLY_TO_ALL = 35,
    NPC_HIGHLORD_MOGRAINE = 16440,
    SPELL_COSMETIC_CHAIN = 45537,
    SPELL_COSMETIC_EXPLODE = 45935,
    SPELL_FORGIVENESS = 28697,
};

class npc_scarlet_guard : public CreatureScript
{
public:
    npc_scarlet_guard() : CreatureScript("npc_scarlet_guard") { }

    struct npc_scarlet_guardAI : public SmartAI
    {
        npc_scarlet_guardAI(Creature* creature) : SmartAI(creature) { }

        void Reset() override
        {
            SayAshbringer = false;
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who && who->GetDistance2d(me) < 12.0f)
            {
                if (Player* player = who->ToPlayer())
                {
                    if (player->HasAura(AURA_ASHBRINGER) && !SayAshbringer)
                    {
                        me->SetFaction(FACTION_FRIENDLY);
                        me->GetMotionMaster()->Clear(); // stop patrolling
                        me->GetMotionMaster()->MoveIdle();
                        me->StopMoving();
                        me->SetStandState(UNIT_STAND_STATE_STAND);
                        me->SetFacingToObject(player);
                        Milliseconds delayKneel(urand(DELAY_MS_KNEEL_MIN, DELAY_MS_KNEEL_MAX));

                        me->m_Events.AddEventAtOffset([this, player]()
                        {
                            me->SetSheath(SHEATH_STATE_UNARMED);
                            me->SetStandState(UNIT_STAND_STATE_KNEEL);

                            if (urand(0, 1)) {
                                Milliseconds delayTalk(urand(DELAY_MS_TALK_MIN, DELAY_MS_TALK_MAX));
                                Talk(SAY_WELCOME, player, delayTalk);
                            }
                        }, delayKneel);

                        SayAshbringer = true;
                    }
                }
            }

            SmartAI::MoveInLineOfSight(who);
        }
    private:
        bool SayAshbringer = false;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScarletMonasteryAI<npc_scarlet_guardAI>(creature);
    }
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
    SPELL_POWER_WORD_SHIELD         =   22187
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

        uint32 AshbringerEvent(uint32 uiSteps)
        {
            Creature* mograine = me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 200.0f);

            switch (uiSteps)
            {
                case 1:
                    me->SetFacingTo(3.13f);
                    return 2 * IN_MILLISECONDS;
                case 2:
                    me->SetSheath(SHEATH_STATE_UNARMED);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    return 2 * IN_MILLISECONDS;
                case 3:
                    Talk(3, playerWhoStartedAshbringer);
                    return 10 * IN_MILLISECONDS;
                case 4:
                    me->SummonCreature(NPC_HIGHLORD_MOGRAINE, 1065.130737f, 1399.350586f, 30.763723f, 6.282961f, TEMPSUMMON_TIMED_DESPAWN, 400000)->SetName("Highlord Mograine");
                    me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 200.0f)->SetFaction(FACTION_FRIENDLY);
                    return 35 * IN_MILLISECONDS;
                case 5:
                    mograine->StopMovingOnCurrentPos();
                    mograine->AI()->Talk(0);
                    return 4 * IN_MILLISECONDS;
                case 6:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->SetSheath(SHEATH_STATE_UNARMED);
                    Talk(4, 2s);
                    return 4 * IN_MILLISECONDS;
                case 7:
                    me->SetSheath(SHEATH_STATE_MELEE);
                    return 2 * IN_MILLISECONDS;
                case 8:
                    mograine->AI()->Talk(1);
                    return 3.7 * IN_MILLISECONDS;
                case 9:
                    mograine->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    return 3.7 * IN_MILLISECONDS;
                case 10:
                    mograine->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                    return 2.3 * IN_MILLISECONDS;
                case 11:
                    mograine->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                    return 5.6 * IN_MILLISECONDS;
                case 12:
                    Talk(5);
                    return 4 * IN_MILLISECONDS;
                case 13:
                    mograine->CastSpell(me, SPELL_FORGIVENESS, false);
                    return 1.2 * IN_MILLISECONDS;
                case 14:
                    mograine->CastSpell(me, SPELL_COSMETIC_CHAIN, true);
                    return 0;
                case 15:
                    mograine->AI()->Talk(2);
                    mograine->DespawnOrUnsummon(5 * IN_MILLISECONDS);
                    mograine->Kill(me, me, true);
                    return 10 * IN_MILLISECONDS;
                default:
                    if(mograine)
                        mograine->DespawnOrUnsummon(0);
                    return 0;
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
            events.Reset();
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who && who->GetDistance2d(me) < 3.0f)
                if (Player* player = who->ToPlayer())
                    if (player->HasAura(AURA_ASHBRINGER) && !SayAshbringer)
                    {
                        me->SetFaction(FACTION_FRIENDLY);
                        playerWhoStartedAshbringer = player;
                        SayAshbringer = true;
                    }

            ScriptedAI::MoveInLineOfSight(who);
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
            // Don't yell on death during Ashbringer event
            if (!SayAshbringer) {
                Talk(SAY_MO_KILL);
            }
        }

        void SpellHit(Unit* /*who*/, SpellInfo const* spell) override
        {
            //When hit with resurrection say text
            if (spell->Id == SPELL_SCARLET_RESURRECTION)
            {
                Talk(SAY_MO_RESURRECTED);
                fakeDeath = false;
                instance->SetData(TYPE_MOGRAINE_AND_WHITE_EVENT, SPECIAL);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            timer = timer - diff;
            if (SayAshbringer && step < 17)
            {
                if (timer <= 0)
                {
                    timer = AshbringerEvent(step);
                    step++;
                }
            }

            if (!UpdateVictim())
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
        bool hasDied;
        bool heal;
        bool fakeDeath;
        EventMap events;
        InstanceScript* instance;
        Player* playerWhoStartedAshbringer;
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

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_1, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        SendGossipMenuFor(player, 100100, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*Sender*/, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);

        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_2, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, 100101, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 1:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_3, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, 100102, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 2:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_4, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                SendGossipMenuFor(player, 100103, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 3:
                creature->HandleEmoteCommand(1);
                creature->m_Events.AddEventAtOffset([creature]()
                {
                    creature->HandleEmoteCommand(EMOTE_ONESHOT_YES);
                }, 2500ms);

                creature->m_Events.AddEventAtOffset([creature]()
                {
                    creature->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                }, 5000ms);

                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_5, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
                SendGossipMenuFor(player, 100104, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 4:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_6, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, 100105, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 5:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_7, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, 100106, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 6:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_8, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                SendGossipMenuFor(player, 100107, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 7:
                creature->HandleEmoteCommand(5);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_9, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
                SendGossipMenuFor(player, 100108, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 8:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_10, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
                SendGossipMenuFor(player, 100109, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 9:
                creature->HandleEmoteCommand(274);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_11, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
                SendGossipMenuFor(player, 100110, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 10:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_12, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                SendGossipMenuFor(player, 100111, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 11:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_13, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
                SendGossipMenuFor(player, 100112, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 12:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_14, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                SendGossipMenuFor(player, 100113, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 13:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_15, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                SendGossipMenuFor(player, 100114, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 14:
                creature->HandleEmoteCommand(1);
                AddGossipItemFor(player, GOSSIP_ITEM_FAIRBANKS_16, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
                SendGossipMenuFor(player, 100115, creature->GetGUID());
                return true;
            case GOSSIP_ACTION_INFO_DEF + 15:
                SendGossipMenuFor(player, 100116, creature->GetGUID());
                /// @todo: we need to play these 3 emote in sequence, we play only the last one right now.
                creature->HandleEmoteCommand(274);
                creature->HandleEmoteCommand(1);
                creature->HandleEmoteCommand(397);
                return true;
        }

        return true;
    }

    struct npc_fairbanksAI : public SmartAI
    {
        npc_fairbanksAI(Creature* creature) : SmartAI(creature) { }

        void Reset() override
        {
            SayAshbringer = false;
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who && who->GetDistance2d(me) < 2.0f)
                if (Player* player = who->ToPlayer())
                    if (player->HasAura(AURA_ASHBRINGER) && !SayAshbringer)
                    {
                        me->SetFaction(FACTION_FRIENDLY);
                        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->CastSpell(me, 57767, true);
                        me->SetDisplayId(16179);
                        me->SetFacingToObject(player);
                        SayAshbringer = true;
                    }

            SmartAI::MoveInLineOfSight(who);
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
    new npc_scarlet_guard();
    new npc_fairbanks();
    new npc_mograine();
    new boss_high_inquisitor_whitemane();
    new at_scarlet_monastery_cathedral_entrance();
}
