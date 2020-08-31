/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3

REWRITTEN BY XINEF
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SmartAI.h"
#include "ScriptedGossip.h"

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
    FACTION_FRIENDLY_TO_ALL         =   35,
    DOOR_HIGH_INQUISITOR_ID         =   104600,
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
        instance_scarlet_monastery_InstanceMapScript(Map* map) : InstanceScript(map) {}

        void OnPlayerEnter(Player* player) override
        {
            if (player->HasAura(AURA_OF_ASHBRINGER))
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
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_COMMANDER_MOGRAINE, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_FAIRBANKS, 4000.0f);
                if (!ScarletList.empty())
                    for (std::list<Creature*>::iterator itr = ScarletList.begin(); itr != ScarletList.end(); itr++)
                        (*itr)->setFaction(FACTION_FRIENDLY_TO_ALL);
            }
        }

        void OnPlayerAreaUpdate(Player* player, uint32 /*oldArea*/, uint32 /*newArea*/) override
        {
            if (player->HasAura(AURA_OF_ASHBRINGER))
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
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_COMMANDER_MOGRAINE, 4000.0f);
                player->GetCreatureListWithEntryInGrid(ScarletList, NPC_FAIRBANKS, 4000.0f);
                if (!ScarletList.empty())
                    for (std::list<Creature*>::iterator itr = ScarletList.begin(); itr != ScarletList.end(); itr++)
                        (*itr)->setFaction(FACTION_FRIENDLY_TO_ALL);
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                //case ENTRY_PUMPKIN_SHRINE: PumpkinShrineGUID = go->GetGUID(); break;
                case DOOR_HIGH_INQUISITOR_ID: DoorHighInquisitorGUID = go->GetGUID(); break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_COMMANDER_MOGRAINE: MograineGUID = creature->GetGUID(); break;
                case NPC_INQUISITOR_WHITEMANE: WhitemaneGUID = creature->GetGUID(); break;
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
            }
        }

        uint64 GetData64(uint32 type) const override
        {
            switch (type)
            {
                case DATA_MOGRAINE:             return MograineGUID;
                case DATA_WHITEMANE:            return WhitemaneGUID;
                case DATA_DOOR_WHITEMANE:       return DoorHighInquisitorGUID;
            }
            return 0;
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == TYPE_MOGRAINE_AND_WHITE_EVENT)
                return encounter;
            return 0;
        }
    private:
        uint64 DoorHighInquisitorGUID;
        uint64 MograineGUID;
        uint64 WhitemaneGUID;
        uint32 encounter;
    };
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
                        Talk(SAY_WELCOME);
                        me->setFaction(FACTION_FRIENDLY_TO_ALL);
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->SetFacingToObject(player);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->AddAura(SPELL_AURA_MOD_ROOT, me);
                        me->CastSpell(me, SPELL_AURA_MOD_ROOT, true);
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
        return new npc_scarlet_guardAI(creature);
    }
};

enum MograineEvents
{
    EVENT_SPELL_CRUSADER_STRIKE     =   1,
    EVENT_SPELL_HAMMER_OF_JUSTICE   =   2
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
                me->GetMotionMaster()->MovePoint(0, 1152.039795f, 1398.405518f, 32.527878f);
                return 2 * IN_MILLISECONDS;
            case 2:
                me->SetSheath(SHEATH_STATE_UNARMED);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                return 2 * IN_MILLISECONDS;
            case 3:
                Talk(3);
                return 10 * IN_MILLISECONDS;
            case 4:
                me->SummonCreature(NPC_HIGHLORD_MOGRAINE, 1065.130737f, 1399.350586f, 30.763723f, 6.282961f, TEMPSUMMON_TIMED_DESPAWN, 400000)->SetName("Highlord Mograine");
                me->FindNearestCreature(NPC_HIGHLORD_MOGRAINE, 200.0f)->setFaction(FACTION_FRIENDLY_TO_ALL);
                return 30 * IN_MILLISECONDS;
            case 5:
                mograine->StopMovingOnCurrentPos();
                mograine->AI()->Talk(0);
                mograine->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                return 4 * IN_MILLISECONDS;
            case 6:
                me->SetStandState(UNIT_STAND_STATE_STAND);
                return 2 * IN_MILLISECONDS;
            case 7:
                Talk(4);
                return 4 * IN_MILLISECONDS;
            case 8:
                mograine->AI()->Talk(1);
                return 11 * IN_MILLISECONDS;
            case 9:
                mograine->HandleEmoteCommand(EMOTE_ONESHOT_BATTLE_ROAR);
                return 4 * IN_MILLISECONDS;
            case 10:
                me->SetSheath(SHEATH_STATE_UNARMED);
                me->SetStandState(UNIT_STAND_STATE_KNEEL);
                Talk(5);
                return 2 * IN_MILLISECONDS;
            case 11:
                mograine->CastSpell(me, SPELL_FORGIVENESS, false);
                return 1 * IN_MILLISECONDS;
            case 12:
                mograine->CastSpell(me, SPELL_COSMETIC_CHAIN, true);
                return 0.5 * IN_MILLISECONDS;
            case 13:
                mograine->AI()->Talk(2);
                mograine->DespawnOrUnsummon(3 * IN_MILLISECONDS);
                mograine->Kill(me, me, true);
                return 0;
            default:
                if(mograine)
                    mograine->DespawnOrUnsummon(0);
                return 0;
            }
        }

        void Reset() override
        {
            //Incase wipe during phase that mograine fake death
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
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
            if (who && who->GetDistance2d(me) < 15.0f)
                if (Player* player = who->ToPlayer())
                    if (player->HasAura(AURA_ASHBRINGER) && !SayAshbringer)
                    {
                        me->setFaction(FACTION_FRIENDLY_TO_ALL);
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        me->SetFacingToObject(player);
                        me->MonsterYell(12389, LANG_UNIVERSAL, player);
                        SayAshbringer = true;
                    }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_MO_AGGRO);
            me->CallForHelp(150.0f);
            me->CastSpell(me, SPELL_RETRIBUTION_AURA, true);
            events.ScheduleEvent(EVENT_SPELL_CRUSADER_STRIKE, urand(1000, 5000));
            events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, urand(6000, 11000));
        }

        void DamageTaken(Unit* /*doneBy*/, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage < me->GetHealth() || hasDied || fakeDeath)
                return;

            //On first death, fake death and open door, as well as initiate whitemane if exist
            if (Unit* Whitemane = ObjectAccessor::GetUnit(*me, instance->GetData64(DATA_WHITEMANE)))
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
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->CastSpell(me, SPELL_PERMANENT_FEIGN_DEATH, true);

                hasDied = true;
                fakeDeath = true;
                damage = 0;
                ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_WHITEMANE))->SetInCombatWithZone();
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_MO_KILL);
        }

        void SpellHit(Unit* /*who*/, const SpellInfo* spell) override
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
            if (SayAshbringer && step < 15)
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
                if (Unit* Whitemane = ObjectAccessor::GetUnit(*me, instance->GetData64(DATA_WHITEMANE)))
                {
                    //Incase wipe during phase that mograine fake death
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    me->RemoveAurasDueToSpell(SPELL_PERMANENT_FEIGN_DEATH);
                    me->CastSpell(me, SPELL_RETRIBUTION_AURA, true);
                    me->CastSpell(Whitemane, SPELL_LAY_ON_HANDS, true);
                    events.ScheduleEvent(EVENT_SPELL_CRUSADER_STRIKE, urand(1000, 5000));
                    events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, urand(6000, 11000));
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
                        events.ScheduleEvent(EVENT_SPELL_CRUSADER_STRIKE, 10000);
                        break;
                    case EVENT_SPELL_HAMMER_OF_JUSTICE:
                        me->CastSpell(me->GetVictim(), SPELL_HAMMER_OF_JUSTICE, true);
                        events.ScheduleEvent(EVENT_SPELL_HAMMER_OF_JUSTICE, 60000);
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
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_mograineAI(creature);
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

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_WH_INTRO);
            events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, urand(1000, 3000));
            events.ScheduleEvent(EVENT_SPELL_POWER_WORLD_SHIELD, 6000);
            events.ScheduleEvent(EVENT_SPELL_HEAL, 9000);
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
                    if (ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_MOGRAINE)))
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

                if (Creature* mograine = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_MOGRAINE)))
                {
                    // checking canResurrectCheck prevents her healing Mograine while he is "faking death"
                    if (canResurrectCheck && mograine->IsAlive() && !mograine->HealthAbovePct(75))
                        target = mograine;
                }

                if (target)
                    me->CastSpell(target, SPELL_HEAL, true);

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
                        me->CastSpell(me, SPELL_POWER_WORD_SHIELD, true);
                        events.ScheduleEvent(EVENT_SPELL_POWER_WORLD_SHIELD, 15000);
                        break;
                    case EVENT_SPELL_HOLY_SMITE:
                        me->CastSpell(me->GetVictim(), SPELL_HOLY_SMITE, true);
                        events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, 6000);
                        break;
                    case EVENT_SPELL_HEAL:
                        me->CastSpell(me, SPELL_HEAL, true);
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
        return new boss_high_inquisitor_whitemaneAI(creature);
    }
};

class npc_fairbanks : public CreatureScript
{
public:
    npc_fairbanks() : CreatureScript("npc_fairbanks") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        AddGossipItemFor(player, 0, "Curse? What's going on here, Fairbanks?", GOSSIP_SENDER_MAIN, 1);
        SendGossipMenuFor(player, 100100, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*Sender*/, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);

        switch (uiAction)
        {
        case 1:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "Mograine?", GOSSIP_SENDER_MAIN, 2);
            SendGossipMenuFor(player, 100101, creature->GetGUID());
            return true;
        case 2:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "What do you mean?", GOSSIP_SENDER_MAIN, 3);
            SendGossipMenuFor(player, 100102, creature->GetGUID());
            return true;
        case 3:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "I still do not fully understand.", GOSSIP_SENDER_MAIN, 4);
            SendGossipMenuFor(player, 100103, creature->GetGUID());
            return true;
        case 4:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "Incredible story. So how did he die?", GOSSIP_SENDER_MAIN, 5);
            SendGossipMenuFor(player, 100104, creature->GetGUID());
            return true;
        case 5:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "You mean...", GOSSIP_SENDER_MAIN, 6);
            SendGossipMenuFor(player, 100105, creature->GetGUID());
            return true;
        case 6:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "How do you know all of this?", GOSSIP_SENDER_MAIN, 7);
            SendGossipMenuFor(player, 100106, creature->GetGUID());
            return true;
        case 7:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "A thousand? For one man?", GOSSIP_SENDER_MAIN, 8);
            SendGossipMenuFor(player, 100107, creature->GetGUID());
            return true;
        case 8:
            creature->HandleEmoteCommand(5);
            AddGossipItemFor(player, 0, "Yet? Yet what?", GOSSIP_SENDER_MAIN, 9);
            SendGossipMenuFor(player, 100108, creature->GetGUID());
            return true;
        case 9:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "And did he?", GOSSIP_SENDER_MAIN, 10);
            SendGossipMenuFor(player, 100109, creature->GetGUID());
            return true;
        case 10:
            creature->HandleEmoteCommand(274);
            AddGossipItemFor(player, 0, "Continue please, Fairbanks.", GOSSIP_SENDER_MAIN, 11);
            SendGossipMenuFor(player, 100110, creature->GetGUID());
            return true;
        case 11:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "You mean...", GOSSIP_SENDER_MAIN, 12);
            SendGossipMenuFor(player, 100111, creature->GetGUID());
            return true;
        case 12:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "You were right, Fairbanks. That is tragic.", GOSSIP_SENDER_MAIN, 13);
            SendGossipMenuFor(player, 100112, creature->GetGUID());
            return true;
        case 13:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "And you did...", GOSSIP_SENDER_MAIN, 14);
            SendGossipMenuFor(player, 100113, creature->GetGUID());
            return true;
        case 14:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "You tell an incredible tale, Fairbanks. What of the blade? Is it beyond redemption?", GOSSIP_SENDER_MAIN, 15);
            SendGossipMenuFor(player, 100114, creature->GetGUID());
            return true;
        case 15:
            creature->HandleEmoteCommand(1);
            AddGossipItemFor(player, 0, "But his son is dead.", GOSSIP_SENDER_MAIN, 16);
            SendGossipMenuFor(player, 100115, creature->GetGUID());
            return true;
        case 16:
            SendGossipMenuFor(player, 100116, creature->GetGUID());
            // todo: we need to play these 3 emote in sequence, we play only the last one right now.
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
                        me->setFaction(FACTION_FRIENDLY_TO_ALL);
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
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
        return new npc_fairbanksAI(creature);
    }
};

void AddSC_instance_scarlet_monastery()
{
    new instance_scarlet_monastery();
    new npc_scarlet_guard();
    new npc_fairbanks();
    new npc_mograine();
    new boss_high_inquisitor_whitemane();
}
