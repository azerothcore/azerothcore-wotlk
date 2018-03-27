/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Netherstorm
SD%Complete: 80
SDComment: Quest support: 10337, 10438, 10652 (special flight paths), 10198, 10191
SDCategory: Netherstorm
EndScriptData */

/* ContentData
npc_commander_dawnforge
npc_bessy
npc_maxx_a_million
go_captain_tyralius_prison
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "GameObjectAI.h"

// Ours
enum saeed
{
    NPC_PROTECTORATE_AVENGER        = 21805,
    NPC_PROTECTORATE_DEFENDER       = 20984,
    NPC_DIMENSIUS                   = 19554,

    EVENT_START_WALK                = 1,
    EVENT_START_FIGHT1              = 2,
    EVENT_START_FIGHT2              = 3,

    DATA_START_ENCOUNTER            = 1,
    DATA_START_FIGHT                = 2,

    SAY_SAEED_0                     = 0,
    SAY_SAEED_1                     = 1,
    SAY_SAEED_2                     = 2,
    SAY_SAEED_3                     = 3,
    SAY_DIMENSISIUS_1               = 1,

    QUEST_DIMENSIUS_DEVOURING       = 10439,

    SPELL_DIMENSIUS_TRANSFORM       = 35939
};

class npc_captain_saeed : public CreatureScript
{
    public:
        npc_captain_saeed() : CreatureScript("npc_captain_saeed") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_captain_saeedAI(creature);
        }

        struct npc_captain_saeedAI : public npc_escortAI
        {
            npc_captain_saeedAI(Creature* creature) : npc_escortAI(creature), summons(me) {}

            SummonList summons;
            EventMap events;
            bool started, fight;

            void Reset()
            {
                if (!summons.empty())
                {
                    for (std::list<uint64>::iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, *itr))
                    {
                        float x, y, z, o;
                        cr->GetRespawnPosition(x, y, z, &o);
                        cr->SetHomePosition(x, y, z, o);
                    }
                }
                events.Reset();
                summons.clear();
                started = false;
                fight = false;
                me->RestoreFaction();
            }

            void MoveInLineOfSight(Unit* who)
            {
                if (Player* player = GetPlayerForEscort())
                    if (me->GetDistance(who) < 10.0f && !me->GetVictim())
                        if (player->IsValidAttackTarget(who))
                        {
                            AttackStart(who);
                            return;
                        }

                npc_escortAI::MoveInLineOfSight(who);
            }

            void SetGUID(uint64 playerGUID, int32 type)
            {
                if (type == DATA_START_ENCOUNTER)
                {
                    Start(true, true, playerGUID);
                    SetEscortPaused(true);
                    started = true;

                    std::list<Creature*> cl;
                    me->GetCreaturesWithEntryInRange(cl, 20.0f, NPC_PROTECTORATE_AVENGER);
                    for (std::list<Creature*>::iterator itr = cl.begin(); itr != cl.end(); ++itr)
                    {
                        summons.Summon(*itr);
                        (*itr)->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        (*itr)->setFaction(250);
                    }
                    cl.clear();
                    me->GetCreaturesWithEntryInRange(cl, 20.0f, NPC_PROTECTORATE_DEFENDER);
                    for (std::list<Creature*>::iterator itr = cl.begin(); itr != cl.end(); ++itr)
                    {
                        summons.Summon(*itr);
                        (*itr)->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        (*itr)->setFaction(250);
                    }

                    me->setFaction(250);
                    Talk(SAY_SAEED_0);
                    events.ScheduleEvent(EVENT_START_WALK, 3000);
                }
                else if (type == DATA_START_FIGHT)
                {
                    Talk(SAY_SAEED_2);
                    SetEscortPaused(false);
                    me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
                }
            }

            void EnterEvadeMode()
            {
                if (fight)
                    SetEscortPaused(false);

                SummonsAction(NULL);
                npc_escortAI::EnterEvadeMode();
            }

            void SummonsAction(Unit* who)
            {
                float i = 0;
                for (std::list<uint64>::iterator itr = summons.begin(); itr != summons.end(); ++itr, i += 1.0f)
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, *itr))
                    {
                        if (who == NULL)
                        {
                            cr->GetMotionMaster()->Clear(false);
                            cr->GetMotionMaster()->MoveFollow(me, 2.0f, M_PI/2.0f + (i / summons.size() * M_PI));
                        }
                        else
                        {
                            cr->SetHomePosition(cr->GetPositionX(), cr->GetPositionY(), cr->GetPositionZ(), cr->GetOrientation());
                            cr->AI()->AttackStart(who);
                        }
                    }
            }

            void WaypointReached(uint32 i)
            {
                Player* player = GetPlayerForEscort();
                if (!player)
                    return;

                switch (i)
                {
                    case 16:
                        Talk(SAY_SAEED_1);
                        me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        SetEscortPaused(true);
                        break;
                    case 18:
                        events.ScheduleEvent(EVENT_START_FIGHT1, 0);
                        SetEscortPaused(true);
                        break;
                    case 19:
                        summons.DespawnAll();
                        break;
                }
            }

            void EnterCombat(Unit* who)
            {
                SummonsAction(who);
            }

            void JustDied(Unit* /*killer*/)
            {
                Player* player = GetPlayerForEscort();
                if (player)
                    player->FailQuest(QUEST_DIMENSIUS_DEVOURING);

                summons.DespawnAll();
            }

            void CorpseRemoved(uint32&)
            {
                summons.DespawnAll();
            }

            uint32 GetData(uint32 data) const
            {
                if (data == 1)
                    return (uint32)started;

                return 0;
            }

            void UpdateAI(uint32 diff)
            {
                npc_escortAI::UpdateAI(diff);

                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_START_WALK:
                        SummonsAction(NULL);
                        SetEscortPaused(false);
                        break;
                    case EVENT_START_FIGHT1:
                        Talk(SAY_SAEED_3);
                        events.ScheduleEvent(EVENT_START_FIGHT2, 3000);
                        break;
                    case EVENT_START_FIGHT2:
                        if (Creature* dimensius = me->FindNearestCreature(NPC_DIMENSIUS, 50.0f))
                        {
                            dimensius->RemoveAurasDueToSpell(SPELL_DIMENSIUS_TRANSFORM);
                            dimensius->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                            AttackStart(dimensius);
                            fight = true;
                        }
                        break;
                }

                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }
        };


        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
        {
            player->PlayerTalkClass->ClearMenus();
            if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
            {
                creature->AI()->SetGUID(player->GetGUID(), DATA_START_ENCOUNTER);
                player->KilledMonsterCredit(creature->GetEntry(), 0);
            }
            else if (uiAction == GOSSIP_ACTION_INFO_DEF+2)
            {
                creature->AI()->SetGUID(player->GetGUID(), DATA_START_FIGHT);
            }

            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (player->GetQuestStatus(QUEST_DIMENSIUS_DEVOURING) == QUEST_STATUS_INCOMPLETE)
            {
                if (!creature->AI()->GetData(1))
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Let's move out.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                else
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Let's start the battle.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            }

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

            return true;
        }
};


// Theirs
/*######
## npc_commander_dawnforge
######*/

// The Speech of Dawnforge, Ardonis & Pathaleon
enum CommanderDawnforgeData
{
    SAY_COMMANDER_DAWNFORGE_1       = 0,
    SAY_COMMANDER_DAWNFORGE_2       = 1,
    SAY_COMMANDER_DAWNFORGE_3       = 2,
    SAY_COMMANDER_DAWNFORGE_4       = 3,
    SAY_COMMANDER_DAWNFORGE_5       = 4,

    SAY_ARCANIST_ARDONIS_1          = 0,
    SAY_ARCANIST_ARDONIS_2          = 1,

    SAY_PATHALEON_CULATOR_IMAGE_1   = 0,
    SAY_PATHALEON_CULATOR_IMAGE_2   = 1,
    SAY_PATHALEON_CULATOR_IMAGE_2_1 = 2,
    SAY_PATHALEON_CULATOR_IMAGE_2_2 = 3,

    QUEST_INFO_GATHERING            = 10198,
    SPELL_SUNFURY_DISGUISE          = 34603,
};

// Entries of Arcanist Ardonis, Commander Dawnforge, Pathaleon the Curators Image
const uint32 CreatureEntry[3] =
{
    19830,                                                // Ardonis
    19831,                                                // Dawnforge
    21504                                                 // Pathaleon
};

class npc_commander_dawnforge : public CreatureScript
{
public:
    npc_commander_dawnforge() : CreatureScript("npc_commander_dawnforge") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_commander_dawnforgeAI(creature);
    }

    struct npc_commander_dawnforgeAI : public ScriptedAI
    {
        npc_commander_dawnforgeAI(Creature* creature) : ScriptedAI(creature) { }

        uint64 PlayerGUID;
        uint64 ardonisGUID;
        uint64 pathaleonGUID;

        uint32 Phase;
        uint32 PhaseSubphase;
        uint32 Phase_Timer;
        bool isEvent;

        void Reset()
        {
            PlayerGUID = 0;
            ardonisGUID = 0;
            pathaleonGUID = 0;

            Phase = 1;
            PhaseSubphase = 0;
            Phase_Timer = 4000;
            isEvent = false;
        }

        void EnterCombat(Unit* /*who*/) { }

        void JustSummoned(Creature* summoned)
        {
            pathaleonGUID = summoned->GetGUID();
        }

        // Emote Ardonis and Pathaleon
        void Turn_to_Pathaleons_Image()
        {
            Creature* ardonis = ObjectAccessor::GetCreature(*me, ardonisGUID);
            Creature* pathaleon = ObjectAccessor::GetCreature(*me, pathaleonGUID);

            if (!ardonis || !pathaleon)
                return;

            // Turn Dawnforge
            me->SetFacingToObject(pathaleon);

            // Turn Ardonis
            ardonis->SetFacingToObject(pathaleon);

            //Set them to kneel
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            ardonis->SetStandState(UNIT_STAND_STATE_KNEEL);
        }

        //Set them back to each other
        void Turn_to_eachother()
        {
            if (Unit* ardonis = ObjectAccessor::GetUnit(*me, ardonisGUID))
            {
                // Turn Dawnforge
                me->SetFacingToObject(ardonis);

                // Turn Ardonis
                ardonis->SetFacingToObject(me);

                //Set state
                me->SetStandState(UNIT_STAND_STATE_STAND);
                ardonis->SetStandState(UNIT_STAND_STATE_STAND);
            }
        }

        bool CanStartEvent(Player* player)
        {
            if (!isEvent)
            {
                Creature* ardonis = me->FindNearestCreature(CreatureEntry[0], 10.0f);
                if (!ardonis)
                    return false;

                ardonisGUID = ardonis->GetGUID();
                PlayerGUID = player->GetGUID();

                isEvent = true;

                Turn_to_eachother();
                return true;
            }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_TSCR, "TSCR: npc_commander_dawnforge event already in progress, need to wait.");
#endif
            return false;
        }

        void UpdateAI(uint32 diff)
        {
            //Is event even running?
            if (!isEvent)
                return;

            //Phase timing
            if (Phase_Timer >= diff)
            {
                Phase_Timer -= diff;
                return;
            }

            Creature* ardonis = ObjectAccessor::GetCreature(*me, ardonisGUID);
            Creature* pathaleon = ObjectAccessor::GetCreature(*me, pathaleonGUID);
            Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);

            if (!ardonis || !player)
            {
                Reset();
                return;
            }

            if (Phase > 4 && !pathaleon)
            {
                Reset();
                return;
            }

            //Phase 1 Dawnforge say
            switch (Phase)
            {
            case 1:
                Talk(SAY_COMMANDER_DAWNFORGE_1);
                ++Phase;
                Phase_Timer = 16000;
                break;
                //Phase 2 Ardonis say
            case 2:
                ardonis->AI()->Talk(SAY_ARCANIST_ARDONIS_1);
                ++Phase;
                Phase_Timer = 16000;
                break;
                //Phase 3 Dawnforge say
            case 3:
                Talk(SAY_COMMANDER_DAWNFORGE_2);
                ++Phase;
                Phase_Timer = 16000;
                break;
                //Phase 4 Pathaleon spawns up to phase 9
            case 4:
                //spawn pathaleon's image
                me->SummonCreature(CreatureEntry[2], 2325.851563f, 2799.534668f, 133.084229f, 6.038996f, TEMPSUMMON_TIMED_DESPAWN, 90000);
                ++Phase;
                Phase_Timer = 500;
                break;
                //Phase 5 Pathaleon say
            case 5:
                pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_1);
                ++Phase;
                Phase_Timer = 6000;
                break;
                //Phase 6
            case 6:
                switch (PhaseSubphase)
                {
                    //Subphase 1: Turn Dawnforge and Ardonis
                case 0:
                    Turn_to_Pathaleons_Image();
                    ++PhaseSubphase;
                    Phase_Timer = 8000;
                    break;
                    //Subphase 2 Dawnforge say
                case 1:
                    Talk(SAY_COMMANDER_DAWNFORGE_3);
                    PhaseSubphase = 0;
                    ++Phase;
                    Phase_Timer = 8000;
                    break;
                }
                break;
                //Phase 7 Pathaleons say 3 Sentence, every sentence need a subphase
            case 7:
                switch (PhaseSubphase)
                {
                    //Subphase 1
                case 0:
                    pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_2);
                    ++PhaseSubphase;
                    Phase_Timer = 12000;
                    break;
                    //Subphase 2
                case 1:
                    pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_2_1);
                    ++PhaseSubphase;
                    Phase_Timer = 16000;
                    break;
                    //Subphase 3
                case 2:
                    pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_2_2);
                    PhaseSubphase = 0;
                    ++Phase;
                    Phase_Timer = 10000;
                    break;
                }
                break;
                //Phase 8 Dawnforge & Ardonis say
            case 8:
                Talk(SAY_COMMANDER_DAWNFORGE_4);
                ardonis->AI()->Talk(SAY_ARCANIST_ARDONIS_2);
                ++Phase;
                Phase_Timer = 4000;
                break;
                //Phase 9 Pathaleons Despawn, Reset Dawnforge & Ardonis angle
            case 9:
                Turn_to_eachother();
                //hide pathaleon, unit will despawn shortly
                pathaleon->SetVisible(false);
                PhaseSubphase = 0;
                ++Phase;
                Phase_Timer = 3000;
                break;
                //Phase 10 Dawnforge say
            case 10:
                Talk(SAY_COMMANDER_DAWNFORGE_5);
                player->AreaExploredOrEventHappens(QUEST_INFO_GATHERING);
                Reset();
                break;
            }
         }
    };
};

class at_commander_dawnforge : public AreaTriggerScript
{
public:
    at_commander_dawnforge() : AreaTriggerScript("at_commander_dawnforge") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/)
    {
        //if player lost aura or not have at all, we should not try start event.
        if (!player->HasAura(SPELL_SUNFURY_DISGUISE))
            return false;

        if (player->IsAlive() && player->GetQuestStatus(QUEST_INFO_GATHERING) == QUEST_STATUS_INCOMPLETE)
        {
            Creature* Dawnforge = player->FindNearestCreature(CreatureEntry[1], 30.0f);
            if (!Dawnforge)
                return false;

            if (CAST_AI(npc_commander_dawnforge::npc_commander_dawnforgeAI, Dawnforge->AI())->CanStartEvent(player))
                return true;
        }
        return false;
    }
};

/*######
## npc_professor_dabiri
######*/
enum ProfessorDabiriData
{
    SPELL_PHASE_DISTRUPTOR  = 35780,

  //WHISPER_DABIRI          = 0, not existing in database

    QUEST_DIMENSIUS         = 10439,
    QUEST_ON_NETHERY_WINGS  = 10438,
};

#define GOSSIP_ITEM "I need a new phase distruptor, Professor"

class npc_professor_dabiri : public CreatureScript
{
public:
    npc_professor_dabiri() : CreatureScript("npc_professor_dabiri") { }

    //OnQuestAccept:
    //if (quest->GetQuestId() == QUEST_DIMENSIUS)
        //creature->AI()->Talk(WHISPER_DABIRI, player);

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            creature->CastSpell(player, SPELL_PHASE_DISTRUPTOR, false);
            player->CLOSE_GOSSIP_MENU();
        }

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_ON_NETHERY_WINGS) == QUEST_STATUS_INCOMPLETE && !player->HasItemCount(29778))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }
};

/*######
## npc_phase_hunter
######*/

enum PhaseHunterData
{
    QUEST_RECHARGING_THE_BATTERIES  = 10190,

    NPC_PHASE_HUNTER_ENTRY          = 18879,
    NPC_DRAINED_PHASE_HUNTER_ENTRY  = 19595,

    EMOTE_WEAK                      = 0,

    // Spells
    SPELL_RECHARGING_BATTERY        = 34219,
    SPELL_PHASE_SLIP                = 36574,
    SPELL_MANA_BURN                 = 13321,
    SPELL_MATERIALIZE               = 34804,
    SPELL_DE_MATERIALIZE            = 34814,
};

class npc_phase_hunter : public CreatureScript
{
public:
    npc_phase_hunter() : CreatureScript("npc_phase_hunter") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_phase_hunterAI(creature);
    }

    struct npc_phase_hunterAI : public ScriptedAI
    {
        npc_phase_hunterAI(Creature* creature) : ScriptedAI(creature) { }

        bool Weak;
        bool Materialize;
        bool Drained;
        uint8 WeakPercent;

        uint64 PlayerGUID;

        uint32 ManaBurnTimer;

        void Reset()
        {
            Weak = false;
            Materialize = false;
            Drained = false;
            WeakPercent = 25 + (rand() % 16); // 25-40

            PlayerGUID = 0;

            ManaBurnTimer = 5000 + (rand() % 3 * 1000); // 5-8 sec cd

            if (me->GetEntry() == NPC_DRAINED_PHASE_HUNTER_ENTRY)
                me->UpdateEntry(NPC_PHASE_HUNTER_ENTRY);
        }

        void EnterCombat(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                PlayerGUID = who->GetGUID();
        }

        //void SpellHit(Unit* /*caster*/, const SpellInfo* /*spell*/)
        //{
        //    DoCast(me, SPELL_DE_MATERIALIZE);
        //}

        void UpdateAI(uint32 diff)
        {
            if (!Materialize)
            {
                DoCast(me, SPELL_MATERIALIZE);
                Materialize = true;
            }

            if (me->HasAuraType(SPELL_AURA_MOD_DECREASE_SPEED) || me->HasUnitState(UNIT_STATE_ROOT)) // if the mob is rooted/slowed by spells eg.: Entangling Roots, Frost Nova, Hamstring, Crippling Poison, etc. => remove it
                DoCast(me, SPELL_PHASE_SLIP);

            if (!UpdateVictim())
                return;

            // some code to cast spell Mana Burn on random target which has mana
            if (ManaBurnTimer <= diff)
            {
                std::list<HostileReference*> AggroList = me->getThreatManager().getThreatList();
                std::list<Unit*> UnitsWithMana;

                for (std::list<HostileReference*>::const_iterator itr = AggroList.begin(); itr != AggroList.end(); ++itr)
                {
                    if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                    {
                        if (unit->GetCreateMana() > 0)
                            UnitsWithMana.push_back(unit);
                    }
                }
                if (!UnitsWithMana.empty())
                {
                    DoCast(Trinity::Containers::SelectRandomContainerElement(UnitsWithMana), SPELL_MANA_BURN);
                    ManaBurnTimer = 8000 + (rand() % 10 * 1000); // 8-18 sec cd
                }
                else
                    ManaBurnTimer = 3500;
            } else ManaBurnTimer -= diff;

            if (Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID)) // start: support for quest 10190
            {
                if (!Weak && HealthBelowPct(WeakPercent)
                    && player->GetQuestStatus(QUEST_RECHARGING_THE_BATTERIES) == QUEST_STATUS_INCOMPLETE)
                {
                    Talk(EMOTE_WEAK);
                    Weak = true;
                }
                if (Weak && !Drained && me->HasAura(SPELL_RECHARGING_BATTERY))
                {
                    Drained = true;
                    int32 uHpPct = int32(me->GetHealthPct());

                    me->UpdateEntry(NPC_DRAINED_PHASE_HUNTER_ENTRY);

                    me->SetHealth(me->CountPctFromMaxHealth(uHpPct));
                    me->LowerPlayerDamageReq(me->GetMaxHealth() - me->GetHealth());
                    me->SetInCombatWith(player);
                }
            } // end: support for quest 10190

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_bessy
######*/
enum BessyData
{
    Q_ALMABTRIEB    = 10337,
    N_THADELL       = 20464,
    SPAWN_FIRST     = 20512,
    SPAWN_SECOND    = 19881,
    SAY_THADELL_1   = 0,
    SAY_THADELL_2   = 1,
    SAY_BESSY_0     = 0,
    SAY_BESSY_1     = 1
};

class npc_bessy : public CreatureScript
{
public:
    npc_bessy() : CreatureScript("npc_bessy") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == Q_ALMABTRIEB)
        {
            creature->setFaction(113);
            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            creature->AI()->Talk(SAY_BESSY_0);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_bessyAI(creature);
    }

    struct npc_bessyAI : public npc_escortAI
    {
        npc_bessyAI(Creature* creature) : npc_escortAI(creature) { }

        void JustDied(Unit* /*killer*/)
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(Q_ALMABTRIEB);
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 3: //first spawn
                    Talk(SAY_BESSY_1);
                    me->SummonCreature(SPAWN_FIRST, 2449.67f, 2183.11f, 96.85f, 6.20f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(SPAWN_FIRST, 2449.53f, 2184.43f, 96.36f, 6.27f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(SPAWN_FIRST, 2449.85f, 2186.34f, 97.57f, 6.08f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                case 7:
                    Talk(SAY_BESSY_1);
                    me->SummonCreature(SPAWN_SECOND, 2309.64f, 2186.24f, 92.25f, 6.06f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(SPAWN_SECOND, 2309.25f, 2183.46f, 91.75f, 6.22f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                case 12:
                    player->GroupEventHappens(Q_ALMABTRIEB, me);
                    if (me->FindNearestCreature(N_THADELL, 30))
                        Talk(SAY_THADELL_1);
                    break;
                case 13:
                    if (me->FindNearestCreature(N_THADELL, 30))
                        Talk(SAY_THADELL_2, player);
                    break;
            }
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->AI()->AttackStart(me);
        }

        void Reset()
        {
            me->RestoreFaction();
            me->SetReactState(REACT_PASSIVE);
        }
    };
};

/*######
## npc_maxx_a_million
######*/

enum MaxxAMillion
{
    QUEST_MARK_V_IS_ALIVE   = 10191,
    GO_DRAENEI_MACHINE      = 183771
};

class npc_maxx_a_million_escort : public CreatureScript
{
public:
    npc_maxx_a_million_escort() : CreatureScript("npc_maxx_a_million_escort") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_maxx_a_million_escortAI(creature);
    }

    struct npc_maxx_a_million_escortAI : public npc_escortAI
    {
        npc_maxx_a_million_escortAI(Creature* creature) : npc_escortAI(creature) { }

        bool bTake;
        uint32 uiTakeTimer;

        void Reset()
        {
            bTake=false;
            uiTakeTimer=3000;
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 7:
                case 17:
                case 29:
                    //Find Object and "work"
                    if (GetClosestGameObjectWithEntry(me, GO_DRAENEI_MACHINE, INTERACTION_DISTANCE))
                    {
                        // take the GO -> animation
                        me->HandleEmoteCommand(EMOTE_STATE_LOOT);
                        SetEscortPaused(true);
                        bTake=true;
                    }
                    break;
                case 36: //return and quest_complete
                    player->CompleteQuest(QUEST_MARK_V_IS_ALIVE);
                    break;
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_MARK_V_IS_ALIVE);
        }

        void UpdateAI(uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (bTake)
            {
                if (uiTakeTimer < uiDiff)
                {
                    me->HandleEmoteCommand(EMOTE_STATE_NONE);
                    if (GameObject* go = GetClosestGameObjectWithEntry(me, GO_DRAENEI_MACHINE, INTERACTION_DISTANCE))
                    {
                        SetEscortPaused(false);
                        bTake=false;
                        uiTakeTimer = 3000;
                        go->Delete();
                    }
                }
                else
                    uiTakeTimer -= uiDiff;
            }
            DoMeleeAttackIfReady();
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_MARK_V_IS_ALIVE)
        {
            if (npc_maxx_a_million_escortAI* pEscortAI = CAST_AI(npc_maxx_a_million_escort::npc_maxx_a_million_escortAI, creature->AI()))
            {
                creature->setFaction(113);
                pEscortAI->Start(false, false, player->GetGUID());
            }
        }
        return true;
    }
};

/*  ###################################
    # QUEST: Deathblow to the legion  #
    ###################################
*/

enum DeathblowToTheLegion
{
    ADYEN_THE_LIGHTBRINGER  = 61021,
    ANCHORITE_KARJA         = 50001,
    EXARCH_ORELIS           = 50002,
    SOCRETHAR               = 20132,
    KAYLAAN_THE_LOST        = 20794,
    ISHANAH_HIGH_PRIESTESS  = 50005,

    // Quest ID
    DEATHBLOW_TO_THE_LEGION = 10409,
    SOCRETHAR_TP_STONE      = 29796,
};

enum RoleplayActions
{
    // ADYEN TEXTS
    EVENT_ADYEN_SAY_1           = 0,
    EVENT_ADYEN_SAY_2           = 1,
    EVENT_ADYEN_SAY_3           = 2,
    EVENT_ADYEN_SAY_4           = 3,

    // SOCRETHAR TEXT
    EVENT_SOCRETHAR_SAY_1       = 4,
    EVENT_SOCRETHAR_SAY_2       = 5,
    EVENT_SOCRETHAR_SAY_3       = 6,
    EVENT_SOCRETHAR_SAY_4       = 7,
    EVENT_SOCRETHAR_SAY_5       = 8,
    EVENT_SOCRETHAR_SAY_6       = 9,

    // KAYLAAN TEXT
    EVENT_KAYLAAN_SAY_1         = 10,
    EVENT_KAYLAAN_SAY_2         = 11,
    EVENT_KAYLAAN_SAY_3         = 12,
    EVENT_KAYLAAN_SAY_4         = 13,
    EVENT_KAYLAAN_SAY_5         = 14,    // Spawn Ishanah at this point
    EVENT_KAYLAAN_SAY_6         = 15,

    // ISHANAH TEXT
    EVENT_ISHANAH_SAY_1         = 16, // Make kaylaan bow
    EVENT_ISHANAH_SAY_2         = 17,

    // SOCRETHAR ROLEPLAY EVENTS
    EVENT_BUFF_KAYLAAN          = 18,
    EVENT_KILL_ISHANAH          = 19,
    EVENT_KILL_KAYLAAN          = 20,
    EVENT_FINAL_FIGHT           = 21, // On death grant credit to all players on threat list

    // KAYLAAN ROLEPLAY EVENTS
    EVENT_KAYLAAN_START_POINT   = 22,
    EVENT_KAYLAAN_WALK_TO_ADYEN = 23,    // Adyen talks and 3s later he triggers next event
    EVENT_WALK_FRONT_ALDOR_TEAM = 24,
    EVENT_IN_FRONT_OF_ALDOR     = 25,    // Set orientation to adyen and w8 4s
    EVENT_KAYLAAN_REPENT        = 27,   // Waypath, unkneel, remove aura and talk. When he reaches final point, become friendly
    EVENT_KAYLAAN_INSPIRATION   = 28,   // Light bubble and talk
    EVENT_KAYLAAN_RESSURECTION  = 29,   // Ress Ishanah
    EVENT_FIGHT_ALDOR           = 30,
    EVENT_END_ALDOR_FIGHT       = 31,
};

enum Adyen
{
    // ADYEN SPELL EVENTS
    EVENT_CRUSADER_STRIKE       = 0,
    EVENT_HAMMER_OF_JUSTICE     = 1,
    EVENT_HOLY_LIGHT            = 2,

    // ADYEN ROLEPLAY EVENTS
    EVENT_START_PLAYER_READY    = 3,

    // ADYEN SPELLS
    CRUSADER_STRIKE             = 14518,
    HAMMER_OF_JUSTICE           = 13005,
    HOLY_LIGHT                  = 13952,
};

enum Karja
{
    // KARJA SPELL EVENTS
    EVENT_SPELL_HOLY_SMITE  = 0,

    // KARJA ROLEPLAY EVENTS
    EVENT_KARJA_WALK        = 1,

    // KARJA SPELLS
    HOLY_SMITE_KARJA        = 9734,
};

enum Orelis
{
    // ORELIS SPELL EVENTS
    EVENT_SPELL_DEMORALIZING_SHOUT  = 0,
    EVENT_SPELL_HEROIC_STRIKE       = 1,
    EVENT_SPELL_REND                = 2,

    // ORELIS ROLEPLAY EVENTS
    EVENT_ORELIS_WALK               = 3,

    // ORELIS SPELLS
    DEMORALIZING_SHOUT              = 13730,
    HEROIC_STRIKE                   = 29426,
    REND                            = 16509
};

enum Kaylaan
{
    // KAYLAAN SPELL EVENTS
    EVENT_SPELL_BURNING_LIGHT   = 6,
    EVENT_SPELL_CONSECRATION    = 7,
    EVENT_SPELL_HEAL            = 8,
    EVENT_SPELL_KAYLAANS_WRATH  = 9,

    // KAYLAAN SPELLS
    BURNING_LIGHT               = 37552,
    CONSECRATION                = 37553,
    KAYLAANS_WRATH              = 35614,
};

enum Socrethar
{
    // SOCRETHAR SPELL EVENTS # start high to avoid issues with RP enum
    EVENT_SPELL_ANTI_MAGIC_SHIELD   = 40,
    EVENT_SPELL_BACKLASH            = 41,
    EVENT_SPELL_CLEAVE              = 42,
    EVENT_SPELL_FIREBALL_BARRAGE    = 43,
    EVENT_SPELL_NETHER_PROTECTION   = 44,
    EVENT_SPELL_POWER_OF_THE_LEGION = 45,
    EVENT_SPELL_SHADOW_BOLT_VOLLEY  = 46,
    EVENT_SPELL_WRATH_OF_SOCRETHAR  = 47,

    // SOCRETHAR SPELLS
    ANTI_MAGIC_SHIELD               = 37538,
    BACKLASH                        = 37537,
    CLEAVE                          = 15496,
    FIREBALL_BARRAGE                = 37540,
    NETHER_PROTECTION               = 37539,
    POWER_OF_THE_LEGION             = 35596,
    SHADOW_BOLT_VOLLEY              = 28448,
    WRATH_OF_SOCRETHAR              = 35600,
    //WRATH_OF_SOCRETHAR2           = 35598 Not sure if should use this one yet
};

enum Ishanah
{
    // ISHANAH SPELL EVENTS
    EVENT_SPELL_GREATER_HEAL        = 2,
    EVENT_SPELL_ISHANAH_HOLY_SMITE  = 3,
    EVENT_SPELL_POWER_WORD_SHIELD   = 4,
    EVENT_JUST_SPAWNED              = 5, // Start waypath
    
    // ISHANAH SPELLS
    GREATER_HEAL                    = 35096,
    HOLY_SMITE_ISHANAH              = 15238,
    POWER_WORLD_SHIELD              = 22187
};

const Position AdyenSpawnPosition   { 4804.839355f, 3773.218750f, 210.530884f, 5.517495f };
const Position OrelisSpawnPosition  { 4805.345215f, 3774.829346f, 210.535095f, 5.517495f };
const Position KarjaSpawnPosition   { 4803.249512f, 3772.649170f, 210.535095f, 5.517495f };
const Position KaylaanSpawnPosition {}; // TO DO: Record his spawn position
const Position IshanahSpawnPosition {}; // TO DO: Record her spawn position

class deathblow_to_the_legion_trigger : public CreatureScript
{
    public:
        deathblow_to_the_legion_trigger() : CreatureScript("deathblow_to_the_legion_trigger") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new deathblow_to_the_legion_triggerAI(creature);
        }

        struct deathblow_to_the_legion_triggerAI : public ScriptedAI
        {
            deathblow_to_the_legion_triggerAI(Creature* creature) : ScriptedAI(creature), _summons(me) { }

            EventMap _events;
            SummonList _summons;

            void JustSummoned(Creature* cr) { _summons.Summon(cr); }

            void MoveInLineOfSight(Unit* who)
            {
                if (who->GetTypeId() == TYPEID_PLAYER && who->IsAlive())
                {
                    if (!_summons.HasEntry(ADYEN_THE_LIGHTBRINGER))
                    {
                        me->SummonCreature(ADYEN_THE_LIGHTBRINGER, AdyenSpawnPosition, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        me->SummonCreature(EXARCH_ORELIS, OrelisSpawnPosition, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                        me->SummonCreature(ANCHORITE_KARJA, KarjaSpawnPosition, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);
                    }
                }
            }
        };
};

#define GOSSIP_ADYEN_START "I'm ready, Adyen."

class adyen_the_lightbringer : public CreatureScript
{
    public:
        adyen_the_lightbringer(): CreatureScript("adyen_the_lightbringer") { }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (player->GetQuestStatus(DEATHBLOW_TO_THE_LEGION) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ADYEN_START, GOSSIP_SENDER_MAIN, GOSSIP_SENDER_INFO);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            creature->AI()->DoAction(EVENT_START_PLAYER_READY);
            Creature* Orelis = creature->FindNearestCreature(EXARCH_ORELIS, 15.0f, true);
            Creature* Karja = creature->FindNearestCreature(ANCHORITE_KARJA, 15.0f, true);
            Orelis->AI()->DoAction(EVENT_ORELIS_WALK);
            Karja->AI()->DoAction(EVENT_KARJA_WALK);
            return true;
        }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new adyen_the_lightbringerAI(creature);
        }

        struct adyen_the_lightbringerAI : public npc_escortAI
        {
            adyen_the_lightbringerAI(Creature* creature) : npc_escortAI(creature) { }

            EventMap _events;

            void DoAction(int32 param)
            {
                if (param == EVENT_START_PLAYER_READY)
                    me->GetMotionMaster()->MovePath(610210, false);
            }

            void WaypointReached(uint32 uiPointId)
            {
                switch (uiPointId)
                {
                    case 9:
                        if (Creature* socrethar = me->FindNearestCreature(SOCRETHAR, 50.0f, true))
                            socrethar->AI()->DoAction(EVENT_ADYEN_SAY_1);
                        break;
                }
            }

            void EnterCombat(Unit * who)
            {
                AttackStart(who);
                _events.ScheduleEvent(EVENT_CRUSADER_STRIKE, 3000, false);
                _events.ScheduleEvent(EVENT_HAMMER_OF_JUSTICE, 6000, false);
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                if (!me->GetVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
                    
                Unit* target = me->GetVictim();

                switch (_events.GetEvent())
                {
                    case EVENT_CRUSADER_STRIKE:
                        me->CastSpell(target, CRUSADER_STRIKE, false);
                        _events.RepeatEvent(urand(3000, 4500));
                        break;
                    case EVENT_HAMMER_OF_JUSTICE:
                        me->CastSpell(target, HAMMER_OF_JUSTICE, false);
                        _events.RepeatEvent(urand(10000, 14000));
                        break;
                    case EVENT_HOLY_LIGHT:
                        // if low enough will heal and trigger again in 18s.
                        if (me->GetHealthPct() <= 45)
                        {
                            me->CastSpell(me, HOLY_LIGHT, false);
                            _events.RepeatEvent(urand(18000, 22000));
                        }
                        else if (Unit* who = me->FindNearestCreature(ANCHORITE_KARJA, 30.0f, true))
                        {
                            if (who->GetHealthPct() <= 45)
                            {
                                me->CastSpell(who, HOLY_LIGHT, false);
                                _events.RepeatEvent(urand(18000, 22000));
                            }
                        }
                        else if (Unit* who = me->FindNearestCreature(EXARCH_ORELIS, 30.0f, true))
                        {
                            if (who->GetHealthPct() <= 45)
                            {
                                me->CastSpell(who, HOLY_LIGHT, false);
                                _events.RepeatEvent(urand(18000, 22000));
                            }
                        }
                        else
                            _events.RepeatEvent(1000);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class anchorite_karja : public CreatureScript
{
    public:
        anchorite_karja() : CreatureScript("anchorite_karja") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new anchorite_karjaAI(creature);
        }

        struct anchorite_karjaAI : public npc_escortAI
        {
            anchorite_karjaAI(Creature* creature) : npc_escortAI(creature) { }

            EventMap _events;

            void DoAction(int32 param)
            {
                if (param == EVENT_KARJA_WALK)
                {
                    me->GetMotionMaster()->MovePath(500020, false); // TODO: Path needs to be added on db
                }
            }

            void WaypointReached(uint32 wp) { }

            void EnterCombat(Unit* who)
            {
                AttackStart(who);
                _events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, 1); // 1 MS so she starts casting asap
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                if (!me->GetVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.GetEvent())
                {
                    case EVENT_SPELL_HOLY_SMITE:
                        me->CastSpell(me->GetVictim(), HOLY_SMITE_KARJA, false);
                        _events.RepeatEvent(2500);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class exarch_orelis : public CreatureScript
{
    public:
        exarch_orelis() : CreatureScript("exarch_orelis") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new exarch_orelisAI(creature);
        }

        struct exarch_orelisAI : public ScriptedAI
        {
            exarch_orelisAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap _events;

            void DoAction(int32 param)
            {
                if (param == EVENT_ORELIS_WALK)
                {
                    me->GetMotionMaster()->MovePath(500010, false); // TODO: Path needs to be added on db
                }
            }

            void EnterCombat(Unit* who)
            {
                AttackStart(who);
                _events.ScheduleEvent(EVENT_SPELL_DEMORALIZING_SHOUT, 1000);
                _events.ScheduleEvent(EVENT_SPELL_HEROIC_STRIKE, urand(2500, 4000));
                _events.ScheduleEvent(EVENT_SPELL_REND, urand(1500, 6000));
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                if (!me->GetVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                Unit* target = me->GetVictim();

                switch (_events.GetEvent())
                {
                    case EVENT_SPELL_DEMORALIZING_SHOUT:
                        if (me->FindNearestCreature(target->GetGUID(), 10.0f, true))
                        {
                            me->CastSpell(target, HOLY_SMITE_KARJA, false);
                            _events.RepeatEvent(15000);
                        }
                        else
                            _events.RepeatEvent(1000);
                        break;
                    case EVENT_SPELL_HEROIC_STRIKE:
                        me->CastSpell(target, HEROIC_STRIKE, false);
                        _events.RepeatEvent(urand(3000, 4500));
                        break;
                    case EVENT_SPELL_REND:
                        me->CastSpell(target, REND, false);
                        _events.RepeatEvent(urand(8000, 12000));
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
    private:
        EventMap _events;
};

class socrethar : public CreatureScript
{
    public:
        socrethar() : CreatureScript("socrethar") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new socretharAI(creature);
        }

        struct socretharAI : public npc_escortAI
        {
            socretharAI(Creature* creature) : npc_escortAI(creature), _summons(me) { }

            EventMap _events;
            bool DeathblowToTheLegionRunning;
            SummonList _summons;

            void WaypointReached(uint32 /*wp*/) {}

            void Reset()
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            }

            void DoAction(int32 param)
            {
                switch (param)
                {
                    case EVENT_ADYEN_SAY_1:
                        _events.ScheduleEvent(EVENT_ADYEN_SAY_1, 2000);
                        DeathblowToTheLegionRunning = true;
                        break;
                    case EVENT_ADYEN_SAY_3:
                        _events.ScheduleEvent(EVENT_ADYEN_SAY_3, 2000);
                        break;
                    case EVENT_KAYLAAN_SAY_1:
                        _events.ScheduleEvent(EVENT_KAYLAAN_SAY_1, 4000);
                        break;
                }
            }

            void EnterCombat(Unit* who)
            {
                AttackStart(who);
                _events.ScheduleEvent(EVENT_SPELL_ANTI_MAGIC_SHIELD, urand(8000, 15000));
                _events.ScheduleEvent(EVENT_SPELL_BACKLASH, urand(3000, 7000));
                _events.ScheduleEvent(EVENT_SPELL_CLEAVE, urand(1000, 4000));
                _events.ScheduleEvent(EVENT_SPELL_FIREBALL_BARRAGE, urand(8000, 10000));
                _events.ScheduleEvent(EVENT_SPELL_NETHER_PROTECTION, 1);
            }

            void JustSummoned(Creature* cr) { _summons.Summon(cr); }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                if (DeathblowToTheLegionRunning)
                {
                    Creature * adyen = me->FindNearestCreature(ADYEN_THE_LIGHTBRINGER, 50.0f, true);
                    Creature* orelis = me->FindNearestCreature(EXARCH_ORELIS, 50.0f, true);
                    Creature* karja = me->FindNearestCreature(ANCHORITE_KARJA, 50.0f, true);

                    switch (_events.GetEvent())
                    {
                        case EVENT_ADYEN_SAY_1:
                            if (Creature* adyen = me->FindNearestCreature(ADYEN_THE_LIGHTBRINGER, 50.0f, true))
                            {
                                adyen->AI()->Talk(0);
                                _events.ScheduleEvent(EVENT_SOCRETHAR_SAY_1, 11000);
                            }
                            break;
                        case EVENT_SOCRETHAR_SAY_1:
                            Talk(0);
                            _events.ScheduleEvent(EVENT_ADYEN_SAY_2, 7000);
                            break;
                        case EVENT_ADYEN_SAY_2:
                            if (Creature* adyen = me->FindNearestCreature(ADYEN_THE_LIGHTBRINGER, 50.0f, true))
                            {
                                adyen->AI()->Talk(1);
                                _events.ScheduleEvent(EVENT_SOCRETHAR_SAY_2, 11000);
                            }
                            break;
                        case EVENT_SOCRETHAR_SAY_2:
                            Talk(1);
                            _events.ScheduleEvent(EVENT_ADYEN_SAY_2, 7000);
                            if (Creature* kaylaan = me->SummonCreature(KAYLAAN_THE_LOST, KaylaanSpawnPosition, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 240000))
                                kaylaan->AI()->DoAction(EVENT_KAYLAAN_START_POINT);
                            break;
                        case EVENT_ADYEN_SAY_3:
                            if (Creature* adyen = me->FindNearestCreature(ADYEN_THE_LIGHTBRINGER, 50.0f, true))
                            {
                                adyen->AI()->Talk(2);
                                _events.ScheduleEvent(EVENT_KAYLAAN_WALK_TO_ADYEN, 6500);
                            }
                            break;
                        case EVENT_KAYLAAN_WALK_TO_ADYEN:
                            if (Creature* kaylaan = me->SummonCreature(KAYLAAN_THE_LOST, KaylaanSpawnPosition, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 240000))
                            {
                                kaylaan->SetStandState(UNIT_STAND_STATE_STAND);
                                /*
                                    1st waypath is spawn->socrethar (0 after id = 1st)
                                    2nd waypath is socrethar->front of aldor (needs the delay of 1s on 1st point so he can dislay standing) (1 after id = 2nd)
                                    3rd waypath is front of aldor->ishanah (2 after id = 3rd)
                                */
                                kaylaan->GetMotionMaster()->MovePath(207941, false); 
                            }
                            break;
                        case EVENT_KAYLAAN_SAY_1:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                            {
                                kaylaan->AI()->Talk(0);
                                _events.ScheduleEvent(EVENT_KAYLAAN_SAY_2, 9000);
                            }
                            break;
                        case EVENT_KAYLAAN_SAY_2:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                            {
                                kaylaan->AI()->Talk(1);
                                _events.ScheduleEvent(EVENT_KAYLAAN_SAY_3, 8000);
                            }
                            break;
                        case EVENT_KAYLAAN_SAY_3:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                            {
                                kaylaan->AI()->Talk(2);
                                _events.ScheduleEvent(EVENT_ADYEN_SAY_4, 8000);
                            }
                            break;
                        case EVENT_ADYEN_SAY_4:
                            if (Creature* adyen = me->FindNearestCreature(ADYEN_THE_LIGHTBRINGER, 50.0f, true))
                            {
                                adyen->AI()->Talk(3);
                                _events.ScheduleEvent(EVENT_KAYLAAN_SAY_4, 11000);
                            }
                            break;
                        case EVENT_KAYLAAN_SAY_4:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                            {
                                kaylaan->AI()->Talk(3);
                                _events.ScheduleEvent(EVENT_SPELL_POWER_OF_THE_LEGION, 5000);
                            }
                            break;
                        case EVENT_SPELL_POWER_OF_THE_LEGION:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                                me->CastSpell(kaylaan, POWER_OF_THE_LEGION, false);
                            Talk(2);
                            _events.ScheduleEvent(EVENT_FIGHT_ALDOR, 3000);
                            break;
                        case EVENT_FIGHT_ALDOR:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                            {
                                kaylaan->setFaction(1770);
                                kaylaan->AI()->AttackStart(adyen);
                                adyen->AI()->AttackStart(kaylaan);
                                orelis->AI()->AttackStart(kaylaan);
                                karja->AI()->AttackStart(kaylaan);
                            }
                            break;
                        case EVENT_END_ALDOR_FIGHT:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                            {
                                kaylaan->setFaction(1786);
                                kaylaan->CombatStop();
                                kaylaan->ClearInCombat();
                                orelis->CombatStop();
                                orelis->ClearInCombat();
                                karja->CombatStop();
                                karja->ClearInCombat();
                                _events.ScheduleEvent(EVENT_SOCRETHAR_SAY_1, 2000);
                            }
                            break;
                        case EVENT_SOCRETHAR_SAY_4:
                            Talk(3);
                            _events.ScheduleEvent(EVENT_KAYLAAN_SAY_5, 6000);
                            break;
                        case EVENT_KAYLAAN_SAY_5:
                            if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 50.0f, true))
                                kaylaan->AI()->Talk(4);

                            if (Creature* ishanah = me->SummonCreature(ISHANAH_HIGH_PRIESTESS, IshanahSpawnPosition, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 180000))
                                ishanah->GetMotionMaster()->MovePath(500050, false); // TODO: Add her path to the DB
                            break;
                    }
                }

                if (!me->GetVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                if (Creature* kaylaan = me->FindNearestCreature(KAYLAAN_THE_LOST, 100.0f, true))
                    if (kaylaan->GetHealthPct() <= 30)
                        _events.ScheduleEvent(EVENT_END_ALDOR_FIGHT, 1000);

                switch (_events.GetEvent())
                {
                    case EVENT_SPELL_NETHER_PROTECTION:
                        if (!me->HasAura(NETHER_PROTECTION))
                            me->CastSpell(me, NETHER_PROTECTION, false);
                        break;
                    case EVENT_SPELL_ANTI_MAGIC_SHIELD:
                        me->CastSpell(me, ANTI_MAGIC_SHIELD, false);
                        _events.RepeatEvent(urand(20000,25000));
                        break;
                    case EVENT_SPELL_BACKLASH:
                        me->CastSpell(me->GetVictim(),BACKLASH, false);
                        _events.RepeatEvent(urand(3500, 6500));
                        break;
                    case EVENT_SPELL_CLEAVE:
                        me->CastSpell(me->GetVictim(), CLEAVE, false);
                        _events.RepeatEvent(urand(4000, 9000));
                        break;
                    case EVENT_SPELL_FIREBALL_BARRAGE:
                        me->CastSpell(me->GetVictim(), FIREBALL_BARRAGE, false);
                        _events.RepeatEvent(urand(12000, 20000));
                        break;
                }

                DoMeleeAttackIfReady();
            }

        };
};


class kaylaan_the_lost : public CreatureScript
{
    public:
        kaylaan_the_lost() : CreatureScript("kaylaan_the_lost") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new kaylaan_the_lostAI(creature);
        }

        struct kaylaan_the_lostAI : public ScriptedAI
        {
            kaylaan_the_lostAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap _events;
            bool first_waypath_done = false;

            void EnterCombat(Unit* who)
            {
                AttackStart(who);
                _events.ScheduleEvent(EVENT_SPELL_BURNING_LIGHT, urand(1000, 3000));
                _events.ScheduleEvent(EVENT_SPELL_CONSECRATION, urand(1000, 5000));
            }

            void DoAction(int32 param)
            {
                switch (param)
                {
                    case EVENT_KAYLAAN_START_POINT:
                        me->GetMotionMaster()->MovePath(207940, false);
                        break;
                }
            }

            void WaypointReached(uint32 waypoint)
            {
                switch (waypoint)
                {
                    case 5: // 1st waypath
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        if (Creature* socrethar = me->FindNearestCreature(SOCRETHAR, 30.0f, true))
                            socrethar->AI()->DoAction(EVENT_ADYEN_SAY_3);
                        first_waypath_done = true;
                        break;
                    case 3: // 2nd waypath
                        if (first_waypath_done)
                        {
                            me->SetHomePosition(me->GetPosition());
                            if (Creature* adyen = me->FindNearestCreature(ADYEN_THE_LIGHTBRINGER, 30.0f, true))
                                me->SetOrientation(adyen->GetPositionX());
                            if (Creature* socrethar = me->FindNearestCreature(SOCRETHAR, 30.0f, true))
                                socrethar->AI()->DoAction(EVENT_KAYLAAN_SAY_1);
                        }
                        break;
                }
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                if (!me->GetVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                Unit* target = me->GetVictim();

                switch (_events.GetEvent())
                {
                    case EVENT_SPELL_BURNING_LIGHT:
                        me->CastSpell(target, BURNING_LIGHT, false);
                        _events.RepeatEvent(urand(4000,7000));
                        break;
                    case EVENT_SPELL_CONSECRATION:
                        if (me->FindNearestCreature(target->GetGUID(), 10.0f, true))
                            me->CastSpell(me, CONSECRATION, false);
                        _events.RepeatEvent(urand(12000, 15000));
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

class ishanah : public CreatureScript
{
    public:
        ishanah() : CreatureScript("ishanah_high_priestess") { }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new ishanahAI(creature);
        }

        struct ishanahAI : public ScriptedAI
        {
            ishanahAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap _events;

            void DoAction(int32 /*param*/) {}

            void EnterCombat(Unit* who)
            {
                AttackStart(who);
                _events.ScheduleEvent(EVENT_SPELL_HOLY_SMITE, 1000);
            }

            void WaypointReached(uint32 waypoint)
            {
                switch (waypoint)
                {
                    case 3:
                        break;
                }
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                if (!me->GetVictim())
                    return;

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.GetEvent())
                {
                    case EVENT_SPELL_HOLY_SMITE:
                        me->CastSpell(me->GetVictim(), HOLY_SMITE_ISHANAH, false);
                        _events.RepeatEvent(2500);
                        break;
                }

                DoMeleeAttackIfReady();
            }
        };
};

void AddSC_netherstorm()
{
    // Ours
    new npc_captain_saeed();

    // Theirs
    new npc_commander_dawnforge();
    new at_commander_dawnforge();
    new npc_professor_dabiri();
    new npc_phase_hunter();
    new npc_bessy();
    new npc_maxx_a_million_escort();

    // Deathblow to the legion
    new deathblow_to_the_legion_trigger();
    new adyen_the_lightbringer();
    new anchorite_karja();
    new exarch_orelis();
    new kaylaan_the_lost();
    new ishanah();
    new socrethar();
}
