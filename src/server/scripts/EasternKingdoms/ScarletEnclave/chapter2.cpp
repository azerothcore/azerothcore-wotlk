/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "SpellInfo.h"
#include "CreatureTextMgr.h"
#include "CombatAI.h"
#include "SpellScript.h"

//How to win friends and influence enemies
// texts signed for creature 28939 but used for 28939, 28940, 28610
enum win_friends
{
    SAY_AGGRO                         = 0,
    SAY_CRUSADER                      = 1,
    SAY_PERSUADED1                    = 2,
    SAY_PERSUADED2                    = 3,
    SAY_PERSUADED3                    = 4,
    SAY_PERSUADED4                    = 5,
    SAY_PERSUADED5                    = 6,
    SAY_PERSUADED6                    = 7,
    SAY_PERSUADE_RAND                 = 8,
    SPELL_PERSUASIVE_STRIKE           = 52781,
    SPELL_THREAT_PULSE                = 58111,
    QUEST_HOW_TO_WIN_FRIENDS          = 12720,
};

class npc_crusade_persuaded : public CreatureScript
{
public:
    npc_crusade_persuaded() : CreatureScript("npc_crusade_persuaded") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_crusade_persuadedAI(creature);
    }

    struct npc_crusade_persuadedAI : public CombatAI
    {
        npc_crusade_persuadedAI(Creature* creature) : CombatAI(creature) { }

        uint32 speechTimer;
        uint32 speechCounter;
        uint64 playerGUID;

        void Reset()
        {
            speechTimer = 0;
            speechCounter = 0;
            playerGUID = 0;
            me->SetReactState(REACT_AGGRESSIVE);
            me->RestoreFaction();
        }

        void EnterCombat(Unit*)
        {
            if (roll_chance_i(33))
                Talk(SAY_AGGRO);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_PERSUASIVE_STRIKE && caster->GetTypeId() == TYPEID_PLAYER && me->IsAlive() && !speechCounter)
            {
                if (Player* player = caster->ToPlayer())
                {
                    if (player->GetQuestStatus(QUEST_HOW_TO_WIN_FRIENDS) == QUEST_STATUS_INCOMPLETE)
                    {
                        playerGUID = player->GetGUID();
                        speechTimer = 1000;
                        speechCounter = 1;
                        me->setFaction(player->getFaction());
                        me->CombatStop(true);
                        me->GetMotionMaster()->MoveIdle();
                        me->SetReactState(REACT_PASSIVE);
                        DoCastAOE(SPELL_THREAT_PULSE, true);

                        sCreatureTextMgr->SendChat(me, SAY_PERSUADE_RAND, NULL, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, player);
                        Talk(SAY_CRUSADER);
                    }
                }
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (speechCounter)
            {
                if (speechTimer <= diff)
                {
                    Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
                    if (!player)
                    {
                        EnterEvadeMode();
                        return;
                    }

                    switch (speechCounter)
                    {
                        case 1:
                            Talk(SAY_PERSUADED1);
                            speechTimer = 8000;
                            break;

                        case 2:
                            Talk(SAY_PERSUADED2);
                            speechTimer = 8000;
                            break;

                        case 3:
                            Talk(SAY_PERSUADED3);
                            speechTimer = 8000;
                            break;

                        case 4:
                            Talk(SAY_PERSUADED4);
                            speechTimer = 8000;
                            break;

                        case 5:
                            sCreatureTextMgr->SendChat(me, SAY_PERSUADED5, NULL, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, player);
                            speechTimer = 8000;
                            break;

                        case 6:
                            Talk(SAY_PERSUADED6);
                            Unit::Kill(player, me);
                            speechCounter = 0;
                            player->GroupEventHappens(QUEST_HOW_TO_WIN_FRIENDS, me);
                            return;
                    }

                    ++speechCounter;
                    DoCastAOE(SPELL_THREAT_PULSE, true);

                } else
                    speechTimer -= diff;

                return;
            }

            CombatAI::UpdateAI(diff);
        }
    };

};

/*######
## npc_koltira_deathweaver
######*/

enum Koltira
{
    SAY_BREAKOUT1                   = 0,
    SAY_BREAKOUT2                   = 1,
    SAY_BREAKOUT3                   = 2,
    SAY_BREAKOUT4                   = 3,
    SAY_BREAKOUT5                   = 4,
    SAY_BREAKOUT6                   = 5,
    SAY_BREAKOUT7                   = 6,
    SAY_BREAKOUT8                   = 7,
    SAY_BREAKOUT9                   = 8,
    SAY_BREAKOUT10                  = 9,

    SPELL_KOLTIRA_TRANSFORM         = 52899,
    SPELL_ANTI_MAGIC_ZONE           = 52894,

    QUEST_BREAKOUT                  = 12727,

    NPC_CRIMSON_ACOLYTE             = 29007,
    NPC_HIGH_INQUISITOR_VALROTH     = 29001,

    //not sure about this id
    //NPC_DEATH_KNIGHT_MOUNT        = 29201,
    MODEL_DEATH_KNIGHT_MOUNT        = 25278
};

class npc_koltira_deathweaver : public CreatureScript
{
public:
    npc_koltira_deathweaver() : CreatureScript("npc_koltira_deathweaver") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_BREAKOUT)
        {
            creature->SetStandState(UNIT_STAND_STATE_STAND);
            creature->setActive(true);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_koltira_deathweaver::npc_koltira_deathweaverAI, creature->AI()))
                pEscortAI->Start(false, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_koltira_deathweaverAI(creature);
    }

    struct npc_koltira_deathweaverAI : public npc_escortAI
    {
        npc_koltira_deathweaverAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            me->SetReactState(REACT_DEFENSIVE);
        }

        uint32 m_uiWave;
        uint32 m_uiWave_Timer;
        uint64 m_uiValrothGUID;
        SummonList summons;

        void Reset()
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
            {
                m_uiWave = 0;
                m_uiWave_Timer = 3000;
                m_uiValrothGUID = 0;
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->LoadEquipment(0, true);
                me->RemoveAllAuras();
                me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ALL, true);
                summons.DespawnAll();
            }
        }

        void EnterEvadeMode()
        {
            me->DeleteThreatList();
            me->CombatStop(false);
            me->SetLootRecipient(NULL);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                AddEscortState(STATE_ESCORT_RETURNING);
                ReturnToLastPoint();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDebug(LOG_FILTER_TSCR, "TSCR: EscortAI has left combat and is now returning to last point");
#endif
            }
            else
            {
                me->GetMotionMaster()->MoveTargetedHome();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                Reset();
            }
        }

        void AttackStart(Unit* who)
        {
            if (HasEscortState(STATE_ESCORT_PAUSED))
                return;

            npc_escortAI::AttackStart(who);
        }

        void WaypointReached(uint32 waypointId)
        {
            switch (waypointId)
            {
                case 0:
                    Talk(SAY_BREAKOUT1);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    break;
                case 1:
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    break;
                case 2:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    //me->UpdateEntry(NPC_KOLTIRA_ALT); //unclear if we must update or not
                    DoCast(me, SPELL_KOLTIRA_TRANSFORM);
                    me->LoadEquipment();
                    break;
                case 3:
                    SetEscortPaused(true);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    Talk(SAY_BREAKOUT2);
                    DoCast(me, SPELL_ANTI_MAGIC_ZONE);  // cast again that makes bubble up
                    break;
                case 4:
                    me->ApplySpellImmune(0, IMMUNITY_DAMAGE, SPELL_SCHOOL_MASK_ALL, false);
                    SetRun(true);
                    break;
                case 9:
                    me->Mount(MODEL_DEATH_KNIGHT_MOUNT);
                    break;
                case 10:
                    me->Dismount();
                    break;
            }
        }

        void JustSummoned(Creature* summoned)
        {
            if (Player* player = GetPlayerForEscort())
                summoned->AI()->AttackStart(player);

            if (summoned->GetEntry() == NPC_HIGH_INQUISITOR_VALROTH)
                m_uiValrothGUID = summoned->GetGUID();

            summoned->AddThreat(me, 0.0f);
            summoned->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
            summons.Summon(summoned);
        }

        void SummonAcolyte(uint32 uiAmount)
        {
            for (uint32 i = 0; i < uiAmount; ++i)
                me->SummonCreature(NPC_CRIMSON_ACOLYTE, 1642.329f, -6045.818f, 127.583f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
        }

        void UpdateAI(uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (HasEscortState(STATE_ESCORT_PAUSED))
            {
                if (m_uiWave_Timer <= uiDiff)
                {
                    switch (m_uiWave)
                    {
                        case 0:
                            Talk(SAY_BREAKOUT3);
                            SummonAcolyte(3);
                            m_uiWave_Timer = 20000;
                            break;
                        case 1:
                            Talk(SAY_BREAKOUT4);
                            SummonAcolyte(3);
                            m_uiWave_Timer = 20000;
                            break;
                        case 2:
                            Talk(SAY_BREAKOUT5);
                            SummonAcolyte(4);
                            m_uiWave_Timer = 20000;
                            break;
                        case 3:
                            Talk(SAY_BREAKOUT6);
                            me->SummonCreature(NPC_HIGH_INQUISITOR_VALROTH, 1642.329f, -6045.818f, 127.583f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 1000);
                            m_uiWave_Timer = 1000;
                            break;
                        case 4:
                        {
                            Creature* temp = ObjectAccessor::GetCreature(*me, m_uiValrothGUID);

                            if (!temp || !temp->IsAlive())
                            {
                                Talk(SAY_BREAKOUT8);
                                m_uiWave_Timer = 5000;
                            }
                            else
                            {
                                // xinef: despawn check
                                Player* player = GetPlayerForEscort();
                                if (!player || me->GetDistance(player) > 60.0f)
                                {
                                    me->DespawnOrUnsummon();
                                    return;
                                }

                                m_uiWave_Timer = 2500;
                                return;                         //return, we don't want m_uiWave to increment now
                            }
                            break;
                        }
                        case 5:
                            Talk(SAY_BREAKOUT9);
                            me->RemoveAurasDueToSpell(SPELL_ANTI_MAGIC_ZONE);
                            // i do not know why the armor will also be removed
                            m_uiWave_Timer = 2500;
                            break;
                        case 6:
                            Talk(SAY_BREAKOUT10);
                            SetEscortPaused(false);
                            break;
                    }

                    ++m_uiWave;
                }
                else
                    m_uiWave_Timer -= uiDiff;
            }
        }
    };

};

//Scarlet courier
enum ScarletCourierEnum
{
    SAY_TREE1                          = 0,
    SAY_TREE2                          = 1,
    SPELL_SHOOT                        = 52818,
    GO_INCONSPICUOUS_TREE              = 191144,
    NPC_SCARLET_COURIER                = 29076
};

class npc_scarlet_courier : public CreatureScript
{
public:
    npc_scarlet_courier() : CreatureScript("npc_scarlet_courier") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_scarlet_courierAI(creature);
    }

    struct npc_scarlet_courierAI : public ScriptedAI
    {
        npc_scarlet_courierAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 uiStage;
        uint32 uiStage_timer;

        void Reset()
        {
            me->Mount(14338); // not sure about this id
            uiStage = 1;
            uiStage_timer = 3000;
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_TREE2);
            me->Dismount();
            uiStage = 0;
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == 1)
                uiStage = 2;
        }

        void UpdateAI(uint32 diff)
        {
            if (uiStage && !me->IsInCombat())
            {
                if (uiStage_timer <= diff)
                {
                    switch (uiStage)
                    {
                    case 1:
                        me->SetWalk(true);
                        if (GameObject* tree = me->FindNearestGameObject(GO_INCONSPICUOUS_TREE, 40.0f))
                        {
                            Talk(SAY_TREE1);
                            float x, y, z;
                            tree->GetContactPoint(me, x, y, z);
                            me->GetMotionMaster()->MovePoint(1, x, y, z);
                        }
                        break;
                    case 2:
                        if (GameObject* tree = me->FindNearestGameObject(GO_INCONSPICUOUS_TREE, 40.0f))
                            if (Unit* unit = tree->GetOwner())
                                AttackStart(unit);
                        break;
                    }
                    uiStage_timer = 3000;
                    uiStage = 0;
                } else uiStage_timer -= diff;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

};

//Koltira & Valroth- Breakout

enum valroth
{
  //SAY_VALROTH1                      = 0, Unused
    SAY_VALROTH_AGGRO                 = 1,
    SAY_VALROTH_RAND                  = 2,
    SAY_VALROTH_DEATH                 = 3,
    SPELL_RENEW                       = 38210,
    SPELL_INQUISITOR_PENANCE          = 52922,
    SPELL_VALROTH_SMITE               = 52926,
    SPELL_SUMMON_VALROTH_REMAINS      = 52929
};

class npc_high_inquisitor_valroth : public CreatureScript
{
public:
    npc_high_inquisitor_valroth() : CreatureScript("npc_high_inquisitor_valroth") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_high_inquisitor_valrothAI(creature);
    }

    struct npc_high_inquisitor_valrothAI : public ScriptedAI
    {
        npc_high_inquisitor_valrothAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 uiRenew_timer;
        uint32 uiInquisitor_Penance_timer;
        uint32 uiValroth_Smite_timer;

        void Reset()
        {
            uiRenew_timer = 1000;
            uiInquisitor_Penance_timer = 2000;
            uiValroth_Smite_timer = 1000;
        }

        void EnterCombat(Unit* who)
        {
            Talk(SAY_VALROTH_AGGRO);
            DoCast(who, SPELL_VALROTH_SMITE);
        }

        void UpdateAI(uint32 diff)
        {
            if (uiRenew_timer <= diff)
            {
                Shout();
                DoCast(me, SPELL_RENEW);
                uiRenew_timer = urand(1000, 6000);
            } else uiRenew_timer -= diff;

            if (uiInquisitor_Penance_timer <= diff)
            {
                Shout();
                DoCastVictim(SPELL_INQUISITOR_PENANCE);
                uiInquisitor_Penance_timer = urand(2000, 7000);
            } else uiInquisitor_Penance_timer -= diff;

            if (uiValroth_Smite_timer <= diff)
            {
                Shout();
                DoCastVictim(SPELL_VALROTH_SMITE);
                uiValroth_Smite_timer = urand(1000, 6000);
            } else uiValroth_Smite_timer -= diff;

            DoMeleeAttackIfReady();
        }

        void Shout()
        {
            if (rand()%100 < 15)
                Talk(SAY_VALROTH_RAND);
        }

        void JustDied(Unit* killer)
        {
            Talk(SAY_VALROTH_DEATH);
            killer->CastSpell(me, SPELL_SUMMON_VALROTH_REMAINS, true);
        }
    };

};

/*######
## npc_a_special_surprise
######*/
//used by 29032, 29061, 29065, 29067, 29068, 29070, 29074, 29072, 29073, 29071 but signed for 29032
enum SpecialSurprise
{
    SAY_EXEC_START_1            = 0,                 // speech for all
    SAY_EXEC_START_2            = 1,
    SAY_EXEC_START_3            = 2,
    SAY_EXEC_PROG_1             = 3,
    SAY_EXEC_PROG_2             = 4,
    SAY_EXEC_PROG_3             = 5,
    SAY_EXEC_PROG_4             = 6,
    SAY_EXEC_PROG_5             = 7,
    SAY_EXEC_PROG_6             = 8,
    SAY_EXEC_PROG_7             = 9,
    SAY_EXEC_NAME_1             = 10,
    SAY_EXEC_NAME_2             = 11,
    SAY_EXEC_RECOG_1            = 12,
    SAY_EXEC_RECOG_2            = 13,
    SAY_EXEC_RECOG_3            = 14,
    SAY_EXEC_RECOG_4            = 15,
    SAY_EXEC_RECOG_5            = 16,
    SAY_EXEC_RECOG_6            = 17,
    SAY_EXEC_NOREM_1            = 18,
    SAY_EXEC_NOREM_2            = 19,
    SAY_EXEC_NOREM_3            = 20,
    SAY_EXEC_NOREM_4            = 21,
    SAY_EXEC_NOREM_5            = 22,
    SAY_EXEC_NOREM_6            = 23,
    SAY_EXEC_NOREM_7            = 24,
    SAY_EXEC_NOREM_8            = 25,
    SAY_EXEC_NOREM_9            = 26,
    SAY_EXEC_THINK_1            = 27,
    SAY_EXEC_THINK_2            = 28,
    SAY_EXEC_THINK_3            = 29,
    SAY_EXEC_THINK_4            = 30,
    SAY_EXEC_THINK_5            = 31,
    SAY_EXEC_THINK_6            = 32,
    SAY_EXEC_THINK_7            = 33,
    SAY_EXEC_THINK_8            = 34,
    SAY_EXEC_THINK_9            = 35,
    SAY_EXEC_THINK_10           = 36,
    SAY_EXEC_LISTEN_1           = 37,
    SAY_EXEC_LISTEN_2           = 38,
    SAY_EXEC_LISTEN_3           = 39,
    SAY_EXEC_LISTEN_4           = 40,
    SAY_PLAGUEFIST              = 41,
    SAY_EXEC_TIME_1             = 42,
    SAY_EXEC_TIME_2             = 43,
    SAY_EXEC_TIME_3             = 44,
    SAY_EXEC_TIME_4             = 45,
    SAY_EXEC_TIME_5             = 46,
    SAY_EXEC_TIME_6             = 47,
    SAY_EXEC_TIME_7             = 48,
    SAY_EXEC_TIME_8             = 49,
    SAY_EXEC_TIME_9             = 50,
    SAY_EXEC_TIME_10            = 51,
    SAY_EXEC_WAITING            = 52,
    EMOTE_DIES                  = 53,

    NPC_PLAGUEFIST              = 29053
};

class npc_a_special_surprise : public CreatureScript
{
public:
    npc_a_special_surprise() : CreatureScript("npc_a_special_surprise") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_a_special_surpriseAI(creature);
    }

    struct npc_a_special_surpriseAI : public ScriptedAI
    {
        npc_a_special_surpriseAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 ExecuteSpeech_Timer;
        uint32 ExecuteSpeech_Counter;
        uint64 PlayerGUID;

        void Reset()
        {
            ExecuteSpeech_Timer = 0;
            ExecuteSpeech_Counter = 0;
            PlayerGUID = 0;

            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
        }

        bool MeetQuestCondition(Player* player)
        {
            switch (me->GetEntry())
            {
                case 29061:                                     // Ellen Stanbridge
                    if (player->GetQuestStatus(12742) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29072:                                     // Kug Ironjaw
                    if (player->GetQuestStatus(12748) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29067:                                     // Donovan Pulfrost
                    if (player->GetQuestStatus(12744) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29065:                                     // Yazmina Oakenthorn
                    if (player->GetQuestStatus(12743) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29071:                                     // Antoine Brack
                    if (player->GetQuestStatus(12750) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29032:                                     // Malar Bravehorn
                    if (player->GetQuestStatus(12739) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29068:                                     // Goby Blastenheimer
                    if (player->GetQuestStatus(12745) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29073:                                     // Iggy Darktusk
                    if (player->GetQuestStatus(12749) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29074:                                     // Lady Eonys
                    if (player->GetQuestStatus(12747) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
                case 29070:                                     // Valok the Righteous
                    if (player->GetQuestStatus(12746) == QUEST_STATUS_INCOMPLETE)
                        return true;
                    break;
            }

            return false;
        }

        void MoveInLineOfSight(Unit* who)

        {
            if (PlayerGUID || who->GetTypeId() != TYPEID_PLAYER || !who->IsWithinDist(me, INTERACTION_DISTANCE))
                return;

            if (MeetQuestCondition(who->ToPlayer()))
                PlayerGUID = who->GetGUID();
        }

        void UpdateAI(uint32 diff)
        {
            if (PlayerGUID && !me->GetVictim() && me->IsAlive())
            {
                if (ExecuteSpeech_Timer <= diff)
                {
                    Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);

                    if (!player)
                    {
                        Reset();
                        return;
                    }

                    /// @todo simplify text's selection

                    switch (player->getRace())
                    {
                        case RACE_HUMAN:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_5, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_1, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_5, player); break;
                                case 6: Talk(SAY_EXEC_THINK_7, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_1, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_6, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_ORC:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_6, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_1, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_7, player); break;
                                case 6: Talk(SAY_EXEC_THINK_8, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_1, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_8, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_DWARF:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_2, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_2, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_3, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_2, player); break;
                                case 6: Talk(SAY_EXEC_THINK_5, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_2, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_3, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_NIGHTELF:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_5, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_1, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_6, player); break;
                                case 6: Talk(SAY_EXEC_THINK_2, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_1, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_7, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_UNDEAD_PLAYER:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_3, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_4, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_3, player); break;
                                case 6: Talk(SAY_EXEC_THINK_1, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_3, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_4, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_TAUREN:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_1, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_5, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_8, player); break;
                                case 6: Talk(SAY_EXEC_THINK_9, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_1, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_9, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_GNOME:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_4, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_1, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_4, player); break;
                                case 6: Talk(SAY_EXEC_THINK_6, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_1, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_5, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_TROLL:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_3, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_7, player); break;
                                case 3: Talk(SAY_EXEC_NAME_2, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_6, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_9, player); break;
                                case 6: Talk(SAY_EXEC_THINK_10, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_4, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_10, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_BLOODELF:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_1, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_1, player); break;
                                //case 5: //unknown
                                case 6: Talk(SAY_EXEC_THINK_3, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_1, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_1, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                        case RACE_DRAENEI:
                            switch (ExecuteSpeech_Counter)
                            {
                                case 0: Talk(SAY_EXEC_START_1, player); break;
                                case 1: me->SetStandState(UNIT_STAND_STATE_STAND); break;
                                case 2: Talk(SAY_EXEC_PROG_1, player); break;
                                case 3: Talk(SAY_EXEC_NAME_1, player); break;
                                case 4: Talk(SAY_EXEC_RECOG_2, player); break;
                                case 5: Talk(SAY_EXEC_NOREM_1, player); break;
                                case 6: Talk(SAY_EXEC_THINK_4, player); break;
                                case 7: Talk(SAY_EXEC_LISTEN_1, player); break;
                                case 8:
                                    if (Creature* Plaguefist = GetClosestCreatureWithEntry(me, NPC_PLAGUEFIST, 85.0f))
                                        Plaguefist->AI()->Talk(SAY_PLAGUEFIST, player);
                                    break;
                                case 9:
                                    Talk(SAY_EXEC_TIME_2, player);
                                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                                    break;
                                case 10:
                                    Talk(SAY_EXEC_WAITING, player);
                                    break;
                                case 11:
                                    Talk(EMOTE_DIES);
                                    me->setDeathState(JUST_DIED);
                                    me->SetHealth(0);
                                    return;
                            }
                            break;
                    }

                    if (ExecuteSpeech_Counter >= 9)
                        ExecuteSpeech_Timer = 15000;
                    else
                        ExecuteSpeech_Timer = 7000;

                    ++ExecuteSpeech_Counter;
                }
                else
                    ExecuteSpeech_Timer -= diff;
            }
        }
    };
};

class spell_q12779_an_end_to_all_things : public SpellScriptLoader
{
    public:
        spell_q12779_an_end_to_all_things() : SpellScriptLoader("spell_q12779_an_end_to_all_things") { }

        class spell_q12779_an_end_to_all_things_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q12779_an_end_to_all_things_SpellScript);

            void HandleScriptEffect(SpellEffIndex /*effIndex*/)
            {
                if (GetHitUnit())
                    GetHitUnit()->CastSpell(GetCaster(), GetEffectValue(), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q12779_an_end_to_all_things_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q12779_an_end_to_all_things_SpellScript();
        }
};

void AddSC_the_scarlet_enclave_c2()
{
    new npc_crusade_persuaded();
    new npc_scarlet_courier();
    new npc_koltira_deathweaver();
    new npc_high_inquisitor_valroth();
    new npc_a_special_surprise();

    // Xinef: Should be in chapter III
    new spell_q12779_an_end_to_all_things();
}
