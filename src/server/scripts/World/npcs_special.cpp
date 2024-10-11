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

#include "CellImpl.h"
#include "Chat.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "GameEventMgr.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "Pet.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SmartAI.h"
#include "SpellAuras.h"
#include "TaskScheduler.h"
#include "WaypointMgr.h"
#include "World.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

enum elderClearwater
{
    EVENT_CLEARWATER_ANNOUNCE           = 1,

    CLEARWATER_SAY_PRE                  = 0,
    CLEARWATER_SAY_START                = 1,
    CLEARWATER_SAY_WINNER               = 2,
    CLEARWATER_SAY_END                  = 3,

    QUEST_FISHING_DERBY                 = 24803,

    DATA_DERBY_FINISHED                 = 1,
};

class npc_elder_clearwater : public CreatureScript
{
public:
    npc_elder_clearwater() : CreatureScript("npc_elder_clearwater") { }

    struct npc_elder_clearwaterAI : public ScriptedAI
    {
        npc_elder_clearwaterAI(Creature* c) : ScriptedAI(c)
        {
            events.Reset();
            events.ScheduleEvent(EVENT_CLEARWATER_ANNOUNCE, 1000, 1, 0);
            finished = false;
            preWarning = false;
            startWarning = false;
            finishWarning = false;
        }

        EventMap events;
        bool finished;
        bool preWarning;
        bool startWarning;
        bool finishWarning;

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_DERBY_FINISHED)
                return (uint32)finished;

            return 0;
        }

        void DoAction(int32 param) override
        {
            if (param == DATA_DERBY_FINISHED)
                finished = true;
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case EVENT_CLEARWATER_ANNOUNCE:
                    {
                        tm strdate = Acore::Time::TimeBreakdown();

                        if (!preWarning && strdate.tm_hour == 13 && strdate.tm_min == 55)
                        {
                            sCreatureTextMgr->SendChat(me, CLEARWATER_SAY_PRE, 0, CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, TEXT_RANGE_MAP);
                            preWarning = true;
                        }
                        if (!startWarning && strdate.tm_hour == 14 && strdate.tm_min == 0)
                        {
                            sCreatureTextMgr->SendChat(me, CLEARWATER_SAY_START, 0, CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, TEXT_RANGE_MAP);
                            startWarning = true;
                        }
                        if (!finishWarning && strdate.tm_hour == 15 && strdate.tm_min == 0)
                        {
                            sCreatureTextMgr->SendChat(me, CLEARWATER_SAY_END, 0, CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, TEXT_RANGE_MAP);
                            finishWarning = true;
                            // no one won - despawn
                            if (!finished)
                            {
                                me->DespawnOrUnsummon();
                                break;
                            }
                        }

                        events.RepeatEvent(1000);
                        break;
                    }
            }
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        QuestRelationBounds pObjectQR;
        QuestRelationBounds pObjectQIR;

        // pets also can have quests
        if (creature)
        {
            pObjectQR  = sObjectMgr->GetCreatureQuestRelationBounds(creature->GetEntry());
            pObjectQIR = sObjectMgr->GetCreatureQuestInvolvedRelationBounds(creature->GetEntry());
        }
        else
            return true;

        QuestMenu& qm = player->PlayerTalkClass->GetQuestMenu();
        qm.ClearMenu();

        for (QuestRelations::const_iterator i = pObjectQIR.first; i != pObjectQIR.second; ++i)
        {
            uint32 quest_id = i->second;
            Quest const* quest = sObjectMgr->GetQuestTemplate(quest_id);
            if (!quest)
                continue;

            if (!creature->AI()->GetData(DATA_DERBY_FINISHED))
            {
                if (quest_id == QUEST_FISHING_DERBY)
                    player->PlayerTalkClass->SendQuestGiverRequestItems(quest, creature->GetGUID(), player->CanRewardQuest(quest, false), true);
            }
            else
            {
                if (quest_id != QUEST_FISHING_DERBY)
                    player->PlayerTalkClass->SendQuestGiverRequestItems(quest, creature->GetGUID(), player->CanRewardQuest(quest, false), true);
            }
        }

        return true;
    }

    bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 /*opt*/) override
    {
        if (!creature->AI()->GetData(DATA_DERBY_FINISHED) && quest->GetQuestId() == QUEST_FISHING_DERBY)
        {
            creature->AI()->DoAction(DATA_DERBY_FINISHED);
            sCreatureTextMgr->SendChat(creature, CLEARWATER_SAY_WINNER, player, CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, TEXT_RANGE_MAP);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_elder_clearwaterAI (pCreature);
    }
};

/*
 * Stranglethorn Vale Fishing Extravaganza World States
 */
enum FishingExtravaganzaWorldStates
{
    STV_FISHING_PREV_WIN_TIME           = 197,
    STV_FISHING_HAS_WINNER              = 198,
    STV_FISHING_ANNOUNCE_EVENT_BEGIN    = 199,
    STV_FISHING_ANNOUNCE_POOLS_DESPAN   = 200
};

enum RiggleBassbait
{
    RIGGLE_SAY_START            = 0,
    RIGGLE_SAY_POOLS_END        = 1,
    RIGGLE_SAY_WINNER           = 2,

    QUEST_MASTER_ANGLER         = 8193,

    EVENT_FISHING_TURN_INS      = 90,
    EVENT_FISHING_POOLS         = 15,

    GOSSIP_EVENT_ACTIVE         = 7614,
    GOSSIP_EVENT_OVER           = 7714
};

class npc_riggle_bassbait : public CreatureScript
{
public:
    npc_riggle_bassbait() : CreatureScript("npc_riggle_bassbait") { }

    struct npc_riggle_bassbaitAI : public ScriptedAI
    {
        npc_riggle_bassbaitAI(Creature* c) : ScriptedAI(c)
        {
            m_uiTimer = 0;
            auto prevWinTime = sWorld->getWorldState(STV_FISHING_PREV_WIN_TIME);
            if (GameTime::GetGameTime().count() - prevWinTime > DAY)
            {
                // reset all after 1 day
                sWorld->setWorldState(STV_FISHING_ANNOUNCE_EVENT_BEGIN, 1);
                sWorld->setWorldState(STV_FISHING_ANNOUNCE_POOLS_DESPAN, 0);
                sWorld->setWorldState(STV_FISHING_HAS_WINNER, 0);
            }
        }

        uint32 m_uiTimer;

        void CheckTournamentState() const
        {
            if (sGameEventMgr->IsActiveEvent(EVENT_FISHING_TURN_INS) && !sWorld->getWorldState(STV_FISHING_HAS_WINNER))
            {
                if (!me->IsQuestGiver())
                {
                    me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                }
                if (sWorld->getWorldState(STV_FISHING_ANNOUNCE_EVENT_BEGIN))
                {
                    me->AI()->Talk(RIGGLE_SAY_START);
                    sWorld->setWorldState(STV_FISHING_ANNOUNCE_EVENT_BEGIN, 0);
                }
            }
            else
            {
                if (me->IsQuestGiver())
                {
                    me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                }
            }
            if (sGameEventMgr->IsActiveEvent(EVENT_FISHING_POOLS))
            {
                // enable announcement: when pools despawn
                sWorld->setWorldState(STV_FISHING_ANNOUNCE_POOLS_DESPAN, 1);
            }
            else
            {
                if (sWorld->getWorldState(STV_FISHING_ANNOUNCE_POOLS_DESPAN))
                {
                    me->AI()->Talk(RIGGLE_SAY_POOLS_END);
                    sWorld->setWorldState(STV_FISHING_ANNOUNCE_POOLS_DESPAN, 0);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (m_uiTimer < diff)
            {
                CheckTournamentState();
                m_uiTimer = 1000;
            }
            else
            {
                m_uiTimer -= diff;
            }
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        if (sWorld->getWorldState(STV_FISHING_HAS_WINNER))
        {
            SendGossipMenuFor(player, GOSSIP_EVENT_OVER, creature->GetGUID());
        }
        else
        {
            SendGossipMenuFor(player, GOSSIP_EVENT_ACTIVE, creature->GetGUID());
        }
        return true;
    }

    bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 /*opt*/) override
    {
        if (quest->GetQuestId() == QUEST_MASTER_ANGLER)
        {
            creature->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            creature->AI()->Talk(RIGGLE_SAY_WINNER, player);
            sWorld->setWorldState(STV_FISHING_PREV_WIN_TIME, GameTime::GetGameTime().count());
            sWorld->setWorldState(STV_FISHING_HAS_WINNER, 1);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_riggle_bassbaitAI (pCreature);
    }
};

enum eTrainingDummy
{
    SPELL_STUN_PERMANENT        = 61204
};

class npc_training_dummy : public CreatureScript
{
public:
    npc_training_dummy() : CreatureScript("npc_training_dummy") { }

    struct npc_training_dummyAI : ScriptedAI
    {
        npc_training_dummyAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetCombatMovement(false);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true); //imune to knock aways like blast wave
        }

        uint32 resetTimer;

        void Reset() override
        {
            me->CastSpell(me, SPELL_STUN_PERMANENT, true);
            resetTimer = 5000;
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!_EnterEvadeMode(why))
                return;

            Reset();
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            resetTimer = 5000;
            damage = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (resetTimer <= diff)
            {
                EnterEvadeMode(EVADE_REASON_NO_HOSTILES);
                resetTimer = 5000;
            }
            else
                resetTimer -= diff;
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_training_dummyAI(creature);
    }
};

class npc_target_dummy : public CreatureScript
{
public:
    npc_target_dummy() : CreatureScript("npc_target_dummy") { }

    struct npc_target_dummyAI : ScriptedAI
    {
        npc_target_dummyAI(Creature* creature) : ScriptedAI(creature)
        {
            me->SetCombatMovement(false);
            deathTimer = 15000;
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_KNOCK_BACK, true); //imune to knock aways like blast wave
        }

        uint32 deathTimer;

        void Reset() override
        {
            me->SetControlled(true, UNIT_STATE_STUNNED); //disable rotate
            me->SetLootRecipient(me->GetOwner());
            me->SelectLevel();
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!_EnterEvadeMode(why))
                return;

            Reset();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->HasUnitState(UNIT_STATE_STUNNED))
                me->SetControlled(true, UNIT_STATE_STUNNED);//disable rotate

            if (deathTimer <= diff)
            {
                me->SetLootRecipient(me->GetOwner());
                me->LowerPlayerDamageReq(me->GetMaxHealth());
                me->KillSelf();
                deathTimer = 600000;
            }
            else
                deathTimer -= diff;
        }

        void MoveInLineOfSight(Unit* /*who*/) override { }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_target_dummyAI(creature);
    }
};

// Theirs
/*########
# npc_air_force_bots
#########*/

enum SpawnType
{
    SPAWNTYPE_TRIPWIRE_ROOFTOP,                             // no warning, summon Creature at smaller range
    SPAWNTYPE_ALARMBOT,                                     // cast guards mark and summon npc - if player shows up with that buff duration < 5 seconds attack
};

struct SpawnAssociation
{
    uint32 thisCreatureEntry;
    uint32 spawnedCreatureEntry;
    SpawnType spawnType;
};

enum AirFoceBots
{
    SPELL_GUARDS_MARK               = 38067,
    AURA_DURATION_TIME_LEFT         = 5000
};

float const RANGE_TRIPWIRE          = 15.0f;
float const RANGE_GUARDS_MARK       = 50.0f;

SpawnAssociation spawnAssociations[] =
{
    {2614,  15241, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Alliance)
    {2615,  15242, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Horde)
    {21974, 21976, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Area 52)
    {21993, 15242, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Horde - Bat Rider)
    {21996, 15241, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Alliance - Gryphon)
    {21997, 21976, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Goblin - Area 52 - Zeppelin)
    {21999, 15241, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Alliance)
    {22001, 15242, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Horde)
    {22002, 15242, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Ground (Horde)
    {22003, 15241, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Ground (Alliance)
    {22063, 21976, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Goblin - Area 52)
    {22065, 22064, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Ethereal - Stormspire)
    {22066, 22067, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Scryer - Dragonhawk)
    {22068, 22064, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Ethereal - Stormspire)
    {22069, 22064, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Stormspire)
    {22070, 22067, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Scryer)
    {22071, 22067, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Scryer)
    {22078, 22077, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Aldor)
    {22079, 22077, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Aldor - Gryphon)
    {22080, 22077, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Aldor)
    {22086, 22085, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Sporeggar)
    {22087, 22085, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Sporeggar - Spore Bat)
    {22088, 22085, SPAWNTYPE_TRIPWIRE_ROOFTOP},             //Air Force Trip Wire - Rooftop (Sporeggar)
    {22090, 22089, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Toshley's Station - Flying Machine)
    {22124, 22122, SPAWNTYPE_ALARMBOT},                     //Air Force Alarm Bot (Cenarion)
    {22125, 22122, SPAWNTYPE_ALARMBOT},                     //Air Force Guard Post (Cenarion - Stormcrow)
    {22126, 22122, SPAWNTYPE_ALARMBOT}                      //Air Force Trip Wire - Rooftop (Cenarion Expedition)
};

class npc_air_force_bots : public CreatureScript
{
public:
    npc_air_force_bots() : CreatureScript("npc_air_force_bots") { }

    struct npc_air_force_botsAI : public ScriptedAI
    {
        npc_air_force_botsAI(Creature* creature) : ScriptedAI(creature)
        {
            SpawnAssoc = nullptr;
            SpawnedGUID.Clear();

            // find the correct spawnhandling
            static uint32 entryCount = sizeof(spawnAssociations) / sizeof(SpawnAssociation);

            for (uint8 i = 0; i < entryCount; ++i)
            {
                if (spawnAssociations[i].thisCreatureEntry == creature->GetEntry())
                {
                    SpawnAssoc = &spawnAssociations[i];
                    break;
                }
            }

            if (!SpawnAssoc)
                LOG_ERROR("sql.sql", "TCSR: Creature template entry {} has ScriptName npc_air_force_bots, but it's not handled by that script", creature->GetEntry());
            else
            {
                CreatureTemplate const* spawnedTemplate = sObjectMgr->GetCreatureTemplate(SpawnAssoc->spawnedCreatureEntry);

                if (!spawnedTemplate)
                {
                    LOG_ERROR("sql.sql", "TCSR: Creature template entry {} does not exist in DB, which is required by npc_air_force_bots", SpawnAssoc->spawnedCreatureEntry);
                    SpawnAssoc = nullptr;
                    return;
                }
            }
        }

        SpawnAssociation* SpawnAssoc;
        ObjectGuid SpawnedGUID;

        void Reset() override {}

        Creature* SummonGuard()
        {
            Creature* summoned = me->SummonCreature(SpawnAssoc->spawnedCreatureEntry, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 300000);

            if (summoned)
                SpawnedGUID = summoned->GetGUID();
            else
            {
                LOG_ERROR("sql.sql", "TCSR: npc_air_force_bots: wasn't able to spawn Creature {}", SpawnAssoc->spawnedCreatureEntry);
                SpawnAssoc = nullptr;
            }

            return summoned;
        }

        Creature* GetSummonedGuard()
        {
            Creature* creature = ObjectAccessor::GetCreature(*me, SpawnedGUID);

            if (creature && creature->IsAlive())
                return creature;

            return nullptr;
        }

        void MoveInLineOfSight(Unit* who) override

        {
            if (!SpawnAssoc)
                return;

            // check if they're hostile
            if (!(me->IsHostileTo(who) || who->IsHostileTo(me)))
                return;

            if (me->IsValidAttackTarget(who))
            {
                Player* playerTarget = who->ToPlayer();

                // airforce guards only spawn for players
                if (!playerTarget)
                    return;

                Creature* lastSpawnedGuard = !SpawnedGUID ? nullptr : GetSummonedGuard();

                // prevent calling ObjectAccessor::GetUnit at next MoveInLineOfSight call - speedup
                if (!lastSpawnedGuard)
                    SpawnedGUID.Clear();

                switch (SpawnAssoc->spawnType)
                {
                    case SPAWNTYPE_ALARMBOT:
                        {
                            if (!who->IsWithinDistInMap(me, RANGE_GUARDS_MARK))
                                return;

                            Aura* markAura = who->GetAura(SPELL_GUARDS_MARK);
                            if (markAura)
                            {
                                // the target wasn't able to move out of our range within 25 seconds
                                if (!lastSpawnedGuard)
                                {
                                    lastSpawnedGuard = SummonGuard();

                                    if (!lastSpawnedGuard)
                                        return;
                                }

                                if (markAura->GetDuration() < AURA_DURATION_TIME_LEFT)
                                    if (!lastSpawnedGuard->GetVictim())
                                        lastSpawnedGuard->AI()->AttackStart(who);
                            }
                            else
                            {
                                if (!lastSpawnedGuard)
                                    lastSpawnedGuard = SummonGuard();

                                if (!lastSpawnedGuard)
                                    return;

                                lastSpawnedGuard->CastSpell(who, SPELL_GUARDS_MARK, true);
                            }
                            break;
                        }
                    case SPAWNTYPE_TRIPWIRE_ROOFTOP:
                        {
                            if (!who->IsWithinDistInMap(me, RANGE_TRIPWIRE))
                                return;

                            if (!lastSpawnedGuard)
                                lastSpawnedGuard = SummonGuard();

                            if (!lastSpawnedGuard)
                                return;

                            // ROOFTOP only triggers if the player is on the ground
                            if (!playerTarget->IsFlying() && !lastSpawnedGuard->GetVictim())
                                lastSpawnedGuard->AI()->AttackStart(who);

                            break;
                        }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_air_force_botsAI(creature);
    }
};

/*########
# npc_chicken_cluck
#########*/

enum ChickenCluck
{
    EMOTE_HELLO         = 0,
    EMOTE_CLUCK_TEXT    = 2,

    QUEST_CLUCK         = 3861
};

class npc_chicken_cluck : public CreatureScript
{
public:
    npc_chicken_cluck() : CreatureScript("npc_chicken_cluck") { }

    struct npc_chicken_cluckAI : public ScriptedAI
    {
        npc_chicken_cluckAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 ResetFlagTimer;

        void Reset() override
        {
            ResetFlagTimer = 120000;
            me->SetFaction(FACTION_PREY);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            // Reset flags after a certain time has passed so that the next player has to start the 'event' again
            if (me->HasNpcFlag(UNIT_NPC_FLAG_QUESTGIVER))
            {
                if (ResetFlagTimer <= diff)
                {
                    EnterEvadeMode();
                    return;
                }
                else
                    ResetFlagTimer -= diff;
            }

            if (UpdateVictim())
                DoMeleeAttackIfReady();
        }

        void ReceiveEmote(Player* player, uint32 emote) override
        {
            switch (emote)
            {
                case TEXT_EMOTE_CHICKEN:
                    if (player->GetQuestStatus(QUEST_CLUCK) == QUEST_STATUS_NONE && rand() % 30 == 1)
                    {
                        me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                        me->SetFaction(FACTION_FRIENDLY);
                        Talk(EMOTE_HELLO);
                    }
                    break;
                case TEXT_EMOTE_CHEER:
                    if (player->GetQuestStatus(QUEST_CLUCK) == QUEST_STATUS_COMPLETE)
                    {
                        me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                        me->SetFaction(FACTION_FRIENDLY);
                        Talk(EMOTE_CLUCK_TEXT);
                    }
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_chicken_cluckAI(creature);
    }

    bool OnQuestAccept(Player* /*player*/, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_CLUCK)
            CAST_AI(npc_chicken_cluck::npc_chicken_cluckAI, creature->AI())->Reset();

        return true;
    }

    bool OnQuestComplete(Player* /*player*/, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_CLUCK)
            CAST_AI(npc_chicken_cluck::npc_chicken_cluckAI, creature->AI())->Reset();

        return true;
    }
};

/*######
## npc_dancing_flames
######*/

enum DancingFlames
{
    SPELL_BRAZIER           = 45423,
    SPELL_SEDUCTION         = 47057,
    SPELL_FIERY_AURA        = 45427
};

class npc_dancing_flames : public CreatureScript
{
public:
    npc_dancing_flames() : CreatureScript("npc_dancing_flames") { }

    struct npc_dancing_flamesAI : public ScriptedAI
    {
        npc_dancing_flamesAI(Creature* creature) : ScriptedAI(creature) { }

        bool Active;
        uint32 CanIteract;

        void Reset() override
        {
            Active = false;
            CanIteract = 0;
            DoCast(me, SPELL_BRAZIER, true);
            DoCast(me, SPELL_FIERY_AURA, false);
            me->UpdateHeight(me->GetPositionZ() + 0.94f);
            me->SetDisableGravity(true);
            me->SendMovementFlagUpdate();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!Active)
            {
                if (CanIteract <= diff)
                {
                    Active = true;
                    CanIteract = 3500;
                    me->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
                }
                else
                    CanIteract -= diff;
            }
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void ReceiveEmote(Player* player, uint32 emote) override
        {
            if (me->IsWithinLOS(player->GetPositionX(), player->GetPositionY(), player->GetPositionZ()) && me->IsWithinDistInMap(player, 30.0f))
            {
                me->SetFacingToObject(player);
                Active = false;

                switch (emote)
                {
                    case TEXT_EMOTE_KISS:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_SHY);
                        break;
                    case TEXT_EMOTE_WAVE:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
                        break;
                    case TEXT_EMOTE_BOW:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
                        break;
                    case TEXT_EMOTE_JOKE:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                        break;
                    case TEXT_EMOTE_DANCE:
                        if (!player->HasAura(SPELL_SEDUCTION))
                        {
                            player->RemoveAurasByType(SPELL_AURA_MOUNTED);
                            DoCast(player, SPELL_SEDUCTION, true);
                        }
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_dancing_flamesAI(creature);
    }
};

/*######
## Triage quest
######*/

enum Doctor
{
    SAY_DOC             = 0,

    DOCTOR_ALLIANCE     = 12939,
    DOCTOR_HORDE        = 12920,
    ALLIANCE_COORDS     = 7,
    HORDE_COORDS        = 6
};

struct Location
{
    float x, y, z, o;
};

static Location AllianceCoords[] =
{
    {-3757.38f, -4533.05f, 14.16f, 3.62f},                      // Top-far-right bunk as seen from entrance
    {-3754.36f, -4539.13f, 14.16f, 5.13f},                      // Top-far-left bunk
    {-3749.54f, -4540.25f, 14.28f, 3.34f},                      // Far-right bunk
    {-3742.10f, -4536.85f, 14.28f, 3.64f},                      // Right bunk near entrance
    {-3755.89f, -4529.07f, 14.05f, 0.57f},                      // Far-left bunk
    {-3749.51f, -4527.08f, 14.07f, 5.26f},                      // Mid-left bunk
    {-3746.37f, -4525.35f, 14.16f, 5.22f},                      // Left bunk near entrance
};

//alliance run to where
#define A_RUNTOX -3742.96f
#define A_RUNTOY -4531.52f
#define A_RUNTOZ 11.91f

static Location HordeCoords[] =
{
    {-1013.75f, -3492.59f, 62.62f, 4.34f},                      // Left, Behind
    {-1017.72f, -3490.92f, 62.62f, 4.34f},                      // Right, Behind
    {-1015.77f, -3497.15f, 62.82f, 4.34f},                      // Left, Mid
    {-1019.51f, -3495.49f, 62.82f, 4.34f},                      // Right, Mid
    {-1017.25f, -3500.85f, 62.98f, 4.34f},                      // Left, front
    {-1020.95f, -3499.21f, 62.98f, 4.34f}                       // Right, Front
};

//horde run to where
#define H_RUNTOX -1016.44f
#define H_RUNTOY -3508.48f
#define H_RUNTOZ 62.96f

uint32 const AllianceSoldierId[3] =
{
    12938,                                                  // 12938 Injured Alliance Soldier
    12936,                                                  // 12936 Badly injured Alliance Soldier
    12937                                                   // 12937 Critically injured Alliance Soldier
};

uint32 const HordeSoldierId[3] =
{
    12923,                                                  //12923 Injured Soldier
    12924,                                                  //12924 Badly injured Soldier
    12925                                                   //12925 Critically injured Soldier
};

/*######
## npc_doctor (handles both Gustaf Vanhowzen and Gregory Victor)
######*/
class npc_doctor : public CreatureScript
{
public:
    npc_doctor() : CreatureScript("npc_doctor") { }

    struct npc_doctorAI : public ScriptedAI
    {
        npc_doctorAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid PlayerGUID;

        uint32 SummonPatientTimer;
        uint32 SummonPatientCount;
        uint32 PatientDiedCount;
        uint32 PatientSavedCount;

        bool Event;

        GuidList Patients;
        std::vector<Location*> Coordinates;

        void Reset() override
        {
            PlayerGUID.Clear();

            SummonPatientTimer = 10000;
            SummonPatientCount = 0;
            PatientDiedCount = 0;
            PatientSavedCount = 0;

            Patients.clear();
            Coordinates.clear();

            Event = false;

            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        void BeginEvent(Player* player)
        {
            PlayerGUID = player->GetGUID();

            SummonPatientTimer = 10000;
            SummonPatientCount = 0;
            PatientDiedCount = 0;
            PatientSavedCount = 0;

            switch (me->GetEntry())
            {
                case DOCTOR_ALLIANCE:
                    for (uint8 i = 0; i < ALLIANCE_COORDS; ++i)
                        Coordinates.push_back(&AllianceCoords[i]);
                    break;
                case DOCTOR_HORDE:
                    for (uint8 i = 0; i < HORDE_COORDS; ++i)
                        Coordinates.push_back(&HordeCoords[i]);
                    break;
            }

            Event = true;
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }

        void PatientDied(Location* point)
        {
            Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);
            if (player && ((player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)))
            {
                ++PatientDiedCount;

                if (PatientDiedCount > 5 && Event)
                {
                    if (player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE)
                        player->FailQuest(6624);
                    else if (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)
                        player->FailQuest(6622);

                    Reset();
                    return;
                }

                Coordinates.push_back(point);
            }
            else
                // If no player or player abandon quest in progress
                Reset();
        }

        void PatientSaved(Creature* savedPatient, Player* player, Location* point)
        {
            if (player && PlayerGUID == player->GetGUID())
            {
                if ((player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE) || (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE))
                {
                    ++PatientSavedCount;

                    if (PatientSavedCount == 15)
                    {
                        if (!Patients.empty())
                        {
                            for (ObjectGuid const& guid : Patients)
                            {
                                if (guid != savedPatient->GetGUID()) // Don't kill the last guy we just saved
                                    if (Creature* patient = ObjectAccessor::GetCreature(*me, guid))
                                        patient->setDeathState(DeathState::JustDied);
                            }
                        }

                        if (player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(6624);
                        else if (player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)
                            player->AreaExploredOrEventHappens(6622);

                        Reset();
                        return;
                    }

                    Coordinates.push_back(point);
                }
            }
        }

        void UpdateAI(uint32 diff) override;

        void JustEngagedWith(Unit* /*who*/) override { }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if ((quest->GetQuestId() == 6624) || (quest->GetQuestId() == 6622))
            CAST_AI(npc_doctor::npc_doctorAI, creature->AI())->BeginEvent(player);

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_doctorAI(creature);
    }
};

/*#####
## npc_injured_patient (handles all the patients, no matter Horde or Alliance)
#####*/

class npc_injured_patient : public CreatureScript
{
public:
    npc_injured_patient() : CreatureScript("npc_injured_patient") { }

    struct npc_injured_patientAI : public ScriptedAI
    {
        npc_injured_patientAI(Creature* creature) : ScriptedAI(creature) { }

        ObjectGuid DoctorGUID;
        Location* Coord;

        void Reset() override
        {
            DoctorGUID.Clear();
            Coord = nullptr;

            //no select
            me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            //no regen health
            me->SetUnitFlag(UNIT_FLAG_IN_COMBAT);

            //prevent using normal bandages
            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_BANDAGE, true);

            //to make them lay with face down
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, UNIT_STAND_STATE_DEAD);

            uint32 mobId = me->GetEntry();

            switch (mobId)
            {
                //lower max health
                case 12923:
                case 12938:                                     //Injured Soldier, 65 seconds to die
                    me->SetHealth(me->CountPctFromMaxHealth(65));
                    break;
                case 12924:
                case 12936:                                     //Badly injured Soldier, 35 seconds to die
                    me->SetHealth(me->CountPctFromMaxHealth(35));
                    break;
                case 12925:
                case 12937:                                     //Critically injured Soldier, 25 seconds to die
                    me->SetHealth(me->CountPctFromMaxHealth(25));
                    break;
            }

            // Schedule health reduction every 1 second
            _scheduler.Schedule(1s, [this](TaskContext context)
            {
                // Reduction of 1% per second, matching WotLK Classic timing
                me->ModifyHealth(me->CountPctFromMaxHealth(1) * -1);
                context.Repeat(1s);
            });
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            Player* player = caster->ToPlayer();
            if (!player || !me->IsAlive() || spell->Id != 20804)
                return;

            if (player->GetQuestStatus(6624) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(6622) == QUEST_STATUS_INCOMPLETE)
                if (DoctorGUID)
                    if (Creature* doctor = ObjectAccessor::GetCreature(*me, DoctorGUID))
                        CAST_AI(npc_doctor::npc_doctorAI, doctor->AI())->PatientSaved(me, player, Coord);

            //make not selectable
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

            //regen health
            me->RemoveUnitFlag(UNIT_FLAG_IN_COMBAT);

            //stand up
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, UNIT_STAND_STATE_STAND);

            Talk(SAY_DOC);

            uint32 mobId = me->GetEntry();
            me->SetWalk(false);

            switch (mobId)
            {
                case 12923:
                case 12924:
                case 12925:
                    me->GetMotionMaster()->MovePoint(0, H_RUNTOX, H_RUNTOY, H_RUNTOZ);
                    break;
                case 12936:
                case 12937:
                case 12938:
                    me->GetMotionMaster()->MovePoint(0, A_RUNTOX, A_RUNTOY, A_RUNTOZ);
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {

            _scheduler.Update(diff);

            if (me->IsAlive() && me->GetHealth() < me->CountPctFromMaxHealth(1))
            {
                me->RemoveUnitFlag(UNIT_FLAG_IN_COMBAT);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->setDeathState(DeathState::JustDied);
                me->SetDynamicFlag(32);

                if (DoctorGUID)
                    if (Creature* doctor = ObjectAccessor::GetCreature((*me), DoctorGUID))
                        CAST_AI(npc_doctor::npc_doctorAI, doctor->AI())->PatientDied(Coord);
            }
        }

        private:
            TaskScheduler _scheduler;

    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_injured_patientAI(creature);
    }
};

void npc_doctor::npc_doctorAI::UpdateAI(uint32 diff)
{
    if (Event && SummonPatientCount >= 24) // Need to keep the event going long enough to save the last few patients
    {
        Reset();
        return;
    }

    if (Event)
    {
        if (SummonPatientTimer <= diff || SummonPatientCount < 6) // Starts with 6 beds filled for both factions
        {
            if (Coordinates.empty())
                return;

            std::vector<Location*>::iterator itr = Coordinates.begin() + rand() % Coordinates.size();
            uint32 patientEntry = 0;

            switch (me->GetEntry())
            {
                case DOCTOR_ALLIANCE:
                    patientEntry = AllianceSoldierId[rand() % 3];
                    break;
                case DOCTOR_HORDE:
                    patientEntry = HordeSoldierId[rand() % 3];
                    break;
                default:
                    LOG_ERROR("scripts", "Invalid entry for Triage doctor. Please check your database");
                    return;
            }

            if (Location* point = *itr)
            {
                if (Creature* Patient = me->SummonCreature(patientEntry, point->x, point->y, point->z, point->o, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000))
                {
                    //303, this flag appear to be required for client side item->spell to work (TARGET_SINGLE_FRIEND)
                    Patient->SetUnitFlag(UNIT_FLAG_PLAYER_CONTROLLED);

                    Patients.push_back(Patient->GetGUID());
                    CAST_AI(npc_injured_patient::npc_injured_patientAI, Patient->AI())->DoctorGUID = me->GetGUID();
                    CAST_AI(npc_injured_patient::npc_injured_patientAI, Patient->AI())->Coord = point;

                    Coordinates.erase(itr);
                }
            }
            SummonPatientTimer = 10000;
            ++SummonPatientCount;
        }
        else
            SummonPatientTimer -= diff;
    }
}

/*######
## npc_garments_of_quests
######*/

/// @todo get text for each NPC

enum Garments
{
    SPELL_LESSER_HEAL_R2    = 2052,
    SPELL_FORTITUDE_R1      = 1243,

    QUEST_MOON              = 5621,
    QUEST_LIGHT_1           = 5624,
    QUEST_LIGHT_2           = 5625,
    QUEST_SPIRIT            = 5648,
    QUEST_DARKNESS          = 5650,

    ENTRY_SHAYA             = 12429,
    ENTRY_ROBERTS           = 12423,
    ENTRY_DOLF              = 12427,
    ENTRY_KORJA             = 12430,
    ENTRY_DG_KEL            = 12428,

    // used by 12429, 12423, 12427, 12430, 12428, but signed for 12429
    SAY_THANKS              = 0,
    SAY_GOODBYE             = 1,
    SAY_HEALED              = 2,
};

class npc_garments_of_quests : public CreatureScript
{
public:
    npc_garments_of_quests() : CreatureScript("npc_garments_of_quests") { }

    struct npc_garments_of_questsAI : public npc_escortAI
    {
        npc_garments_of_questsAI(Creature* creature) : npc_escortAI(creature)
        {
            Reset();
        }

        ObjectGuid CasterGUID;

        bool IsHealed;
        bool CanRun;

        uint32 RunAwayTimer;

        void Reset() override
        {
            CasterGUID.Clear();

            IsHealed = false;
            CanRun = false;

            RunAwayTimer = 5000;

            me->SetPvP(true);
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            // expect database to have RegenHealth=0
            me->SetHealth(me->CountPctFromMaxHealth(70));
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_LESSER_HEAL_R2 || spell->Id == SPELL_FORTITUDE_R1)
            {
                //not while in combat
                if (me->IsInCombat())
                    return;

                //nothing to be done now
                if (IsHealed && CanRun)
                    return;

                if (Player* player = caster->ToPlayer())
                {
                    switch (me->GetEntry())
                    {
                        case ENTRY_SHAYA:
                            if (player->GetQuestStatus(QUEST_MOON) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    Talk(SAY_THANKS, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    Talk(SAY_HEALED, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_ROBERTS:
                            if (player->GetQuestStatus(QUEST_LIGHT_1) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    Talk(SAY_THANKS, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    Talk(SAY_HEALED, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_DOLF:
                            if (player->GetQuestStatus(QUEST_LIGHT_2) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    Talk(SAY_THANKS, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    Talk(SAY_HEALED, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_KORJA:
                            if (player->GetQuestStatus(QUEST_SPIRIT) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    Talk(SAY_THANKS, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    Talk(SAY_HEALED, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                        case ENTRY_DG_KEL:
                            if (player->GetQuestStatus(QUEST_DARKNESS) == QUEST_STATUS_INCOMPLETE)
                            {
                                if (IsHealed && !CanRun && spell->Id == SPELL_FORTITUDE_R1)
                                {
                                    Talk(SAY_THANKS, caster);
                                    CanRun = true;
                                }
                                else if (!IsHealed && spell->Id == SPELL_LESSER_HEAL_R2)
                                {
                                    CasterGUID = caster->GetGUID();
                                    me->SetStandState(UNIT_STAND_STATE_STAND);
                                    Talk(SAY_HEALED, caster);
                                    IsHealed = true;
                                }
                            }
                            break;
                    }

                    // give quest credit, not expect any special quest objectives
                    if (CanRun)
                        player->TalkedToCreature(me->GetEntry(), me->GetGUID());
                }
            }
        }

        void WaypointReached(uint32 /*waypointId*/) override
        {
        }

        void UpdateAI(uint32 diff) override
        {
            if (CanRun && !me->IsInCombat())
            {
                if (RunAwayTimer <= diff)
                {
                    if (Unit* unit = ObjectAccessor::GetUnit(*me, CasterGUID))
                    {
                        switch (me->GetEntry())
                        {
                            case ENTRY_SHAYA:
                            case ENTRY_ROBERTS:
                            case ENTRY_DOLF:
                            case ENTRY_KORJA:
                            case ENTRY_DG_KEL:
                                Talk(SAY_GOODBYE, unit);
                                break;
                        }

                        Start(false, true);
                    }
                    else
                        EnterEvadeMode();                       //something went wrong

                    RunAwayTimer = 30000;
                }
                else
                    RunAwayTimer -= diff;
            }

            npc_escortAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_garments_of_questsAI(creature);
    }
};

/*######
## npc_guardian
######*/

enum GuardianSpells
{
    SPELL_DEATHTOUCH            = 5
};

class npc_guardian : public CreatureScript
{
public:
    npc_guardian() : CreatureScript("npc_guardian") { }

    struct npc_guardianAI : public ScriptedAI
    {
        npc_guardianAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            if (me->isAttackReady())
            {
                DoCastVictim(SPELL_DEATHTOUCH, true);
                me->resetAttackTimer();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_guardianAI(creature);
    }
};

/*######
## npc_sayge
######*/

enum Sayge
{
    SPELL_DMG      = 23768, // dmg
    SPELL_RES      = 23769, // res
    SPELL_ARM      = 23767, // arm
    SPELL_SPI      = 23738, // spi
    SPELL_INT      = 23766, // int
    SPELL_STM      = 23737, // stm
    SPELL_STR      = 23735, // str
    SPELL_AGI      = 23736, // agi
    SPELL_FORTUNE  = 23765  // faire fortune
};

enum SaygeGossip
{
    // Start
    GOSSIP_MENU_SAYGE_HELLO       = 6186,
    NPC_TEXT_SAYGE_HELLO          = 7339,

    // Theif - initial gossip after start
    GOSSIP_MENU_SAYGE_1           = 6185,
    NPC_TEXT_SAYGE_1              = 7340,

    // Slay
    GOSSIP_MENU_SAYGE_SLAY        = 6187,
    NPC_TEXT_SAYGE_SLAY           = 7341,

    // Turn Over
    GOSSIP_MENU_SAYGE_TURN_OVER   = 6208,
    NPC_TEXT_SAYGE_TURN_OVER      = 7361,

    // Confiscate
    GOSSIP_MENU_SAYGE_CONFISCATE  = 6209,
    NPC_TEXT_SAYGE_CONFISCATE     = 7362,

    // Let him go
    GOSSIP_MENU_SAYGE_LET_GO     = 6210,
    NPC_TEXT_SAYGE_LET_GO        = 7363,

    // End
    GOSSIP_MENU_SAYGE_END        = 6211,
    NPC_TEXT_SAYGE_END           = 7364,

    // End - Take fortune
    NPC_TEXT_SAYGE_END_FORTUNE  = 7365, // menuID 6212
};

class npc_sayge : public CreatureScript
{
public:
    npc_sayge() : CreatureScript("npc_sayge") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->HasSpellCooldown(SPELL_INT) ||
            player->HasSpellCooldown(SPELL_ARM) ||
            player->HasSpellCooldown(SPELL_DMG) ||
            player->HasSpellCooldown(SPELL_RES) ||
            player->HasSpellCooldown(SPELL_STR) ||
            player->HasSpellCooldown(SPELL_AGI) ||
            player->HasSpellCooldown(SPELL_STM) ||
            player->HasSpellCooldown(SPELL_SPI))
            {
                SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
            }
        else
        {
            AddGossipItemFor(player, GOSSIP_MENU_SAYGE_HELLO, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        }

        return true;
    }

    void SendAction(Player* player, Creature* creature, uint32 action)
    {
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_1, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2); // Slay
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_1, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3); // Turn over
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_1, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4); // Confiscate
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_1, 3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5); // Let him go
                SendGossipMenuFor(player, NPC_TEXT_SAYGE_1, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2: // Slay
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_SLAY, 0, GOSSIP_SENDER_MAIN + 1, GOSSIP_ACTION_INFO_DEF); // Painfully
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_SLAY, 1, GOSSIP_SENDER_MAIN + 2, GOSSIP_ACTION_INFO_DEF); // Painlessly
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_SLAY, 2, GOSSIP_SENDER_MAIN + 3, GOSSIP_ACTION_INFO_DEF); // Let go
                SendGossipMenuFor(player, NPC_TEXT_SAYGE_SLAY, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 3: // Turn over
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_TURN_OVER, 0, GOSSIP_SENDER_MAIN + 4, GOSSIP_ACTION_INFO_DEF); // Confront
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_TURN_OVER, 1, GOSSIP_SENDER_MAIN + 5, GOSSIP_ACTION_INFO_DEF); // Inform
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_TURN_OVER, 2, GOSSIP_SENDER_MAIN + 2, GOSSIP_ACTION_INFO_DEF); // Ignore
                SendGossipMenuFor(player, NPC_TEXT_SAYGE_TURN_OVER, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 4: // Confiscate
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_CONFISCATE, 0, GOSSIP_SENDER_MAIN + 6, GOSSIP_ACTION_INFO_DEF); // Speak against
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_CONFISCATE, 1, GOSSIP_SENDER_MAIN + 7, GOSSIP_ACTION_INFO_DEF); // Help
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_CONFISCATE, 2, GOSSIP_SENDER_MAIN + 8, GOSSIP_ACTION_INFO_DEF); // Without knowing
                SendGossipMenuFor(player, NPC_TEXT_SAYGE_CONFISCATE, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 5: // Let him go
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_LET_GO, 0, GOSSIP_SENDER_MAIN + 5, GOSSIP_ACTION_INFO_DEF); // Take credit, keep gold
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_LET_GO, 1, GOSSIP_SENDER_MAIN + 4, GOSSIP_ACTION_INFO_DEF); // Take credit, share gold
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_LET_GO, 2, GOSSIP_SENDER_MAIN + 3, GOSSIP_ACTION_INFO_DEF); // Let the knight keep
                SendGossipMenuFor(player, NPC_TEXT_SAYGE_LET_GO, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF: // End
                AddGossipItemFor(player, GOSSIP_MENU_SAYGE_END, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                SendGossipMenuFor(player, NPC_TEXT_SAYGE_END, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 6: // End - Take fortune
                creature->CastSpell(player, SPELL_FORTUNE, false);
                SendGossipMenuFor(player, NPC_TEXT_SAYGE_END_FORTUNE, creature->GetGUID());
                break;
        }
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN:
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 1:
                creature->CastSpell(player, SPELL_DMG, false);
                player->AddSpellCooldown(SPELL_DMG, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 2:
                creature->CastSpell(player, SPELL_RES, false);
                player->AddSpellCooldown(SPELL_RES, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 3:
                creature->CastSpell(player, SPELL_ARM, false);
                player->AddSpellCooldown(SPELL_ARM, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 4:
                creature->CastSpell(player, SPELL_SPI, false);
                player->AddSpellCooldown(SPELL_SPI, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 5:
                creature->CastSpell(player, SPELL_INT, false);
                player->AddSpellCooldown(SPELL_INT, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 6:
                creature->CastSpell(player, SPELL_STM, false);
                player->AddSpellCooldown(SPELL_STM, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 7:
                creature->CastSpell(player, SPELL_STR, false);
                player->AddSpellCooldown(SPELL_STR, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
            case GOSSIP_SENDER_MAIN + 8:
                creature->CastSpell(player, SPELL_AGI, false);
                player->AddSpellCooldown(SPELL_AGI, 0, 2 * HOUR * IN_MILLISECONDS);
                SendAction(player, creature, action);
                break;
        }
        return true;
    }
};

class npc_steam_tonk : public CreatureScript
{
public:
    npc_steam_tonk() : CreatureScript("npc_steam_tonk") { }

    struct npc_steam_tonkAI : public ScriptedAI
    {
        npc_steam_tonkAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override { }
        void JustEngagedWith(Unit* /*who*/) override { }

        void OnPossess(bool apply)
        {
            if (apply)
            {
                // Initialize the action bar without the melee attack command
                me->InitCharmInfo();
                me->GetCharmInfo()->InitEmptyActionBar(false);

                me->SetReactState(REACT_PASSIVE);
            }
            else
                me->SetReactState(REACT_AGGRESSIVE);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_steam_tonkAI(creature);
    }
};

/*######
# npc_wormhole
######*/

enum WormholeMisc
{
    SPELL_BOREAN_TUNDRA         = 67834,
    SPELL_SHOLAZAR_BASIN        = 67835,
    SPELL_ICECROWN              = 67836,
    SPELL_STORM_PEAKS           = 67837,
    SPELL_HOWLING_FJORD         = 67838,
    SPELL_UNDERGROUND           = 68081,

    DATA_SHOW_UNDERGROUND       = 1,

    GOSSIP_MENU_WORMHOLE        = 10668,
};

class npc_wormhole : public CreatureScript
{
public:
    npc_wormhole() : CreatureScript("npc_wormhole") { }

    struct npc_wormholeAI : public PassiveAI
    {
        npc_wormholeAI(Creature* creature) : PassiveAI(creature) { }

        void InitializeAI() override
        {
            _showUnderground = urand(0, 100) == 0; // Guessed value, it is really rare though
        }

        uint32 GetData(uint32 type) const override
        {
            return (type == DATA_SHOW_UNDERGROUND && _showUnderground) ? 1 : 0;
        }

    private:
        bool _showUnderground;
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsSummon())
        {
            if (player == creature->ToTempSummon()->GetSummonerUnit())
            {
                AddGossipItemFor(player, GOSSIP_MENU_WORMHOLE, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1); // Borean Tundra
                AddGossipItemFor(player, GOSSIP_MENU_WORMHOLE, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2); // Howling Fjord
                AddGossipItemFor(player, GOSSIP_MENU_WORMHOLE, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3); // Sholazar Basin
                AddGossipItemFor(player, GOSSIP_MENU_WORMHOLE, 3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4); // Icecrown
                AddGossipItemFor(player, GOSSIP_MENU_WORMHOLE, 4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5); // Storm Peaks

                if (creature->AI()->GetData(DATA_SHOW_UNDERGROUND))
                    AddGossipItemFor(player, GOSSIP_MENU_WORMHOLE, 5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6); // Underground...

                SendGossipMenuFor(player, player->GetGossipTextId(creature), creature);
            }
        }

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1: // Borean Tundra
                CloseGossipMenuFor(player);
                creature->CastSpell(player, SPELL_BOREAN_TUNDRA, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2: // Howling Fjord
                CloseGossipMenuFor(player);
                creature->CastSpell(player, SPELL_HOWLING_FJORD, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 3: // Sholazar Basin
                CloseGossipMenuFor(player);
                creature->CastSpell(player, SPELL_SHOLAZAR_BASIN, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 4: // Icecrown
                CloseGossipMenuFor(player);
                creature->CastSpell(player, SPELL_ICECROWN, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 5: // Storm peaks
                CloseGossipMenuFor(player);
                creature->CastSpell(player, SPELL_STORM_PEAKS, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 6: // Underground
                CloseGossipMenuFor(player);
                creature->CastSpell(player, SPELL_UNDERGROUND, false);
                break;
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_wormholeAI(creature);
    }
};

/*######
## npc_pet_trainer
######*/

enum PetTrainer
{
    PET_UNLEARN      = 6520,
    YES_PLEASE_DO    = 0
};

class npc_pet_trainer : public CreatureScript
{
public:
    npc_pet_trainer() : CreatureScript("npc_pet_trainer") { }

    struct npc_pet_trainerAI : public ScriptedAI
    {
        npc_pet_trainerAI(Creature* creature) : ScriptedAI(creature) { }

        void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
        {
            if (menuId == PET_UNLEARN && gossipListId == YES_PLEASE_DO)
            {
                player->ResetPetTalents();
                player->PlayerTalkClass->SendCloseGossip();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pet_trainerAI(creature);
    }
};

/*######
## npc_locksmith
######*/

/// @todo: Key to the Focusing Iris (And Heroic) Should be given by Alexstrasza, check broadcasttext ID 32832 & 32836
enum LockSmith
{
    // Skeleton Key - Scholomance
    QUEST_THE_KEY_TO_SCHOLOMANCE_A        = 5505,
    QUEST_THE_KEY_TO_SCHOLOMANCE_H        = 5511,
    ITEM_SKELETON_KEY                     = 13704,
    SPELL_SKELETON_KEY                    = 54883,

    // Arcatraz Key
    QUEST_HOW_TO_BRAKE_IN_TO_THE_ARCATRAZ = 10704,
    ITEM_ARCATRAZ_KEY                     = 31084,
    SPELL_ARCATRAZ_KEY                    = 54881,

    // Shatered Halls Key
    QUEST_HOTTER_THAN_HELL_A              = 10758,
    QUEST_HOTTER_THAN_HELL_H              = 10764,
    ITEM_SHATTERED_HALLS_KEY              = 28395,
    SPELL_SHATTERED_HALLS_KEY             = 54884,

    // Searing Gorge Key
    QUEST_AT_LAST                         = 3201,
    ITEM_SEARING_GORGE                    = 5396,
    SPELL_SEARING_GORGE_KEY               = 54880,

    // Shadowforge Key
    QUEST_DARK_IRON_LEGACY                = 3802,
    ITEM_SHADOWFORGE_KEY                  = 11000,
    SPELL_SHADOWFORGE_KEY                 = 54882,

    // Eye of Haramad
    QUEST_THE_EYE_OF_HARAMAD              = 10982,
    ITEM_EYE_OF_HARAMAD                   = 32092,
    SPELL_EYE_OF_HARMAD                   = 54887,

    // Master's Key
    QUEST_RETURN_TO_KHAGDAR               = 9837,
    ITEM_THE_MASTERS_KEY                  = 24490,
    SPELL_THE_MASTERS_KEY                 = 54885,

    // Violet Hold Key
    QUEST_CONTAINMENT                     = 13159,
    ITEM_VIOLET_HOLD_KEY                  = 42482,
    SPELL_VIOLET_HOLD_KEY                 = 67253,

    // Essence-Infused Moonstone
    QUEST_ETERNAL_VIGILANCE               = 11011,
    ITEM_ESSENCE_INFUSED_MOONSTONE        = 32449,
    SPELL_ESSENCE_INFUSED_MOONSTONE       = 40173,

    // Gossip
    GOSSIP_MENU_LOCKSMITH                 = 9823,
};

class npc_locksmith : public CreatureScript
{
public:
    npc_locksmith() : CreatureScript("npc_locksmith") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        // Skeleton Key - Scholomance
        if ((player->GetQuestRewardStatus(QUEST_THE_KEY_TO_SCHOLOMANCE_A) || player->GetQuestRewardStatus(QUEST_THE_KEY_TO_SCHOLOMANCE_H)) &&
                !player->HasItemCount(ITEM_SKELETON_KEY, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        // Arcatraz Key
        if (player->GetQuestRewardStatus(QUEST_HOW_TO_BRAKE_IN_TO_THE_ARCATRAZ) && !player->HasItemCount(ITEM_ARCATRAZ_KEY, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        // Shatered Halls Key
        if ((player->GetQuestRewardStatus(QUEST_HOTTER_THAN_HELL_A) || player->GetQuestRewardStatus(QUEST_HOTTER_THAN_HELL_H)) &&
                !player->HasItemCount(ITEM_SHATTERED_HALLS_KEY, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

        // Searing Gorge Key
        if (player->GetQuestRewardStatus(QUEST_AT_LAST) && !player->HasItemCount(ITEM_SEARING_GORGE, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

        // Shadowforge Key
        if (player->GetQuestRewardStatus(QUEST_DARK_IRON_LEGACY) && !player->HasItemCount(ITEM_SHADOWFORGE_KEY, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 4, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);

        //  Eye of Haramad
        if (player->GetQuestRewardStatus(QUEST_THE_EYE_OF_HARAMAD) && !player->HasItemCount(ITEM_EYE_OF_HARAMAD, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 5, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);

        // Master's Key
        if (player->GetQuestRewardStatus(QUEST_RETURN_TO_KHAGDAR) && !player->HasItemCount(ITEM_THE_MASTERS_KEY, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 6, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);

        // Violet Hold Key
        if (player->GetQuestRewardStatus(QUEST_CONTAINMENT) && !player->HasItemCount(ITEM_VIOLET_HOLD_KEY, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 7, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);

        // Essence-Infused Moonstone
        if (player->GetQuestRewardStatus(QUEST_ETERNAL_VIGILANCE) && !player->HasItemCount(ITEM_ESSENCE_INFUSED_MOONSTONE, 1, true))
            AddGossipItemFor(player, GOSSIP_MENU_LOCKSMITH, 8, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_SKELETON_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_ARCATRAZ_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_SHATTERED_HALLS_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_SEARING_GORGE_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_SHADOWFORGE_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_EYE_OF_HARMAD, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 7:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_THE_MASTERS_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 8:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_VIOLET_HOLD_KEY, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 9:
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_ESSENCE_INFUSED_MOONSTONE, false);
                break;
        }
        return true;
    }
};

/*######
## npc_experience
######*/

enum ExperienceNPCgossip
{
    GOSSIP_MENU_EXP_NPC                   = 10638
};

class npc_experience : public CreatureScript
{
public:
    npc_experience() : CreatureScript("npc_experience") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        auto toggleXpCost = sWorld->getIntConfig(CONFIG_TOGGLE_XP_COST);

        if (!player->HasPlayerFlag(PLAYER_FLAGS_NO_XP_GAIN))
        {
            AddGossipItemFor(player, GOSSIP_MENU_EXP_NPC, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1, toggleXpCost); // "I no longer wish to gain experience."
        }
        else
        {
            AddGossipItemFor(player, GOSSIP_MENU_EXP_NPC, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2, toggleXpCost); // "I wish to start gaining experience again."
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
    {
        auto toggleXpCost = sWorld->getIntConfig(CONFIG_TOGGLE_XP_COST);

        ClearGossipMenuFor(player);

        if (!player->HasEnoughMoney(toggleXpCost))
        {
            player->SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, 0, 0, 0);
            player->PlayerTalkClass->SendCloseGossip();
            return true;
        }

        player->ModifyMoney(-toggleXpCost);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1://xp off
                player->SetPlayerFlag(PLAYER_FLAGS_NO_XP_GAIN);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2://xp on
                player->RemovePlayerFlag(PLAYER_FLAGS_NO_XP_GAIN);
                break;
        }

        player->PlayerTalkClass->SendCloseGossip();
        return true;
    }
};

enum Fireworks
{
    NPC_OMEN                = 15467,
    NPC_MINION_OF_OMEN      = 15466,
    NPC_FIREWORK_BLUE       = 15879,
    NPC_FIREWORK_GREEN      = 15880,
    NPC_FIREWORK_PURPLE     = 15881,
    NPC_FIREWORK_RED        = 15882,
    NPC_FIREWORK_YELLOW     = 15883,
    NPC_FIREWORK_WHITE      = 15884,
    NPC_FIREWORK_BIG_BLUE   = 15885,
    NPC_FIREWORK_BIG_GREEN  = 15886,
    NPC_FIREWORK_BIG_PURPLE = 15887,
    NPC_FIREWORK_BIG_RED    = 15888,
    NPC_FIREWORK_BIG_YELLOW = 15889,
    NPC_FIREWORK_BIG_WHITE  = 15890,

    NPC_CLUSTER_BLUE        = 15872,
    NPC_CLUSTER_RED         = 15873,
    NPC_CLUSTER_GREEN       = 15874,
    NPC_CLUSTER_PURPLE      = 15875,
    NPC_CLUSTER_WHITE       = 15876,
    NPC_CLUSTER_YELLOW      = 15877,
    NPC_CLUSTER_BIG_BLUE    = 15911,
    NPC_CLUSTER_BIG_GREEN   = 15912,
    NPC_CLUSTER_BIG_PURPLE  = 15913,
    NPC_CLUSTER_BIG_RED     = 15914,
    NPC_CLUSTER_BIG_WHITE   = 15915,
    NPC_CLUSTER_BIG_YELLOW  = 15916,
    NPC_CLUSTER_ELUNE       = 15918,

    GO_FIREWORK_LAUNCHER_1  = 180771,
    GO_FIREWORK_LAUNCHER_2  = 180868,
    GO_FIREWORK_LAUNCHER_3  = 180850,
    GO_CLUSTER_LAUNCHER_1   = 180772,
    GO_CLUSTER_LAUNCHER_2   = 180859,
    GO_CLUSTER_LAUNCHER_3   = 180869,
    GO_CLUSTER_LAUNCHER_4   = 180874,

    SPELL_ROCKET_BLUE       = 26344,
    SPELL_ROCKET_GREEN      = 26345,
    SPELL_ROCKET_PURPLE     = 26346,
    SPELL_ROCKET_RED        = 26347,
    SPELL_ROCKET_WHITE      = 26348,
    SPELL_ROCKET_YELLOW     = 26349,
    SPELL_ROCKET_BIG_BLUE   = 26351,
    SPELL_ROCKET_BIG_GREEN  = 26352,
    SPELL_ROCKET_BIG_PURPLE = 26353,
    SPELL_ROCKET_BIG_RED    = 26354,
    SPELL_ROCKET_BIG_WHITE  = 26355,
    SPELL_ROCKET_BIG_YELLOW = 26356,
    SPELL_LUNAR_FORTUNE     = 26522,

    ANIM_GO_LAUNCH_FIREWORK = 3,
    ZONE_MOONGLADE          = 493,
};

Position omenSummonPos = {7558.993f, -2839.999f, 450.0214f, 4.46f};

class npc_firework : public CreatureScript
{
public:
    npc_firework() : CreatureScript("npc_firework") { }

    struct npc_fireworkAI : public ScriptedAI
    {
        npc_fireworkAI(Creature* creature) : ScriptedAI(creature) { }

        bool isCluster()
        {
            switch (me->GetEntry())
            {
                case NPC_FIREWORK_BLUE:
                case NPC_FIREWORK_GREEN:
                case NPC_FIREWORK_PURPLE:
                case NPC_FIREWORK_RED:
                case NPC_FIREWORK_YELLOW:
                case NPC_FIREWORK_WHITE:
                case NPC_FIREWORK_BIG_BLUE:
                case NPC_FIREWORK_BIG_GREEN:
                case NPC_FIREWORK_BIG_PURPLE:
                case NPC_FIREWORK_BIG_RED:
                case NPC_FIREWORK_BIG_YELLOW:
                case NPC_FIREWORK_BIG_WHITE:
                    return false;
                case NPC_CLUSTER_BLUE:
                case NPC_CLUSTER_GREEN:
                case NPC_CLUSTER_PURPLE:
                case NPC_CLUSTER_RED:
                case NPC_CLUSTER_YELLOW:
                case NPC_CLUSTER_WHITE:
                case NPC_CLUSTER_BIG_BLUE:
                case NPC_CLUSTER_BIG_GREEN:
                case NPC_CLUSTER_BIG_PURPLE:
                case NPC_CLUSTER_BIG_RED:
                case NPC_CLUSTER_BIG_YELLOW:
                case NPC_CLUSTER_BIG_WHITE:
                case NPC_CLUSTER_ELUNE:
                default:
                    return true;
            }
        }

        GameObject* FindNearestLauncher()
        {
            GameObject* launcher = nullptr;

            if (isCluster())
            {
                GameObject* launcher1 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_1, 0.5f);
                GameObject* launcher2 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_2, 0.5f);
                GameObject* launcher3 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_3, 0.5f);
                GameObject* launcher4 = GetClosestGameObjectWithEntry(me, GO_CLUSTER_LAUNCHER_4, 0.5f);

                if (launcher1)
                    launcher = launcher1;
                else if (launcher2)
                    launcher = launcher2;
                else if (launcher3)
                    launcher = launcher3;
                else if (launcher4)
                    launcher = launcher4;
            }
            else
            {
                GameObject* launcher1 = GetClosestGameObjectWithEntry(me, GO_FIREWORK_LAUNCHER_1, 0.5f);
                GameObject* launcher2 = GetClosestGameObjectWithEntry(me, GO_FIREWORK_LAUNCHER_2, 0.5f);
                GameObject* launcher3 = GetClosestGameObjectWithEntry(me, GO_FIREWORK_LAUNCHER_3, 0.5f);

                if (launcher1)
                    launcher = launcher1;
                else if (launcher2)
                    launcher = launcher2;
                else if (launcher3)
                    launcher = launcher3;
            }

            return launcher;
        }

        uint32 GetFireworkSpell(uint32 entry)
        {
            switch (entry)
            {
                case NPC_FIREWORK_BLUE:
                    return SPELL_ROCKET_BLUE;
                case NPC_FIREWORK_GREEN:
                    return SPELL_ROCKET_GREEN;
                case NPC_FIREWORK_PURPLE:
                    return SPELL_ROCKET_PURPLE;
                case NPC_FIREWORK_RED:
                    return SPELL_ROCKET_RED;
                case NPC_FIREWORK_YELLOW:
                    return SPELL_ROCKET_YELLOW;
                case NPC_FIREWORK_WHITE:
                    return SPELL_ROCKET_WHITE;
                case NPC_FIREWORK_BIG_BLUE:
                    return SPELL_ROCKET_BIG_BLUE;
                case NPC_FIREWORK_BIG_GREEN:
                    return SPELL_ROCKET_BIG_GREEN;
                case NPC_FIREWORK_BIG_PURPLE:
                    return SPELL_ROCKET_BIG_PURPLE;
                case NPC_FIREWORK_BIG_RED:
                    return SPELL_ROCKET_BIG_RED;
                case NPC_FIREWORK_BIG_YELLOW:
                    return SPELL_ROCKET_BIG_YELLOW;
                case NPC_FIREWORK_BIG_WHITE:
                    return SPELL_ROCKET_BIG_WHITE;
                default:
                    return 0;
            }
        }

        uint32 GetFireworkGameObjectId()
        {
            uint32 spellId = 0;

            switch (me->GetEntry())
            {
                case NPC_CLUSTER_BLUE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BLUE);
                    break;
                case NPC_CLUSTER_GREEN:
                    spellId = GetFireworkSpell(NPC_FIREWORK_GREEN);
                    break;
                case NPC_CLUSTER_PURPLE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_PURPLE);
                    break;
                case NPC_CLUSTER_RED:
                    spellId = GetFireworkSpell(NPC_FIREWORK_RED);
                    break;
                case NPC_CLUSTER_YELLOW:
                    spellId = GetFireworkSpell(NPC_FIREWORK_YELLOW);
                    break;
                case NPC_CLUSTER_WHITE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_WHITE);
                    break;
                case NPC_CLUSTER_BIG_BLUE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_BLUE);
                    break;
                case NPC_CLUSTER_BIG_GREEN:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_GREEN);
                    break;
                case NPC_CLUSTER_BIG_PURPLE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_PURPLE);
                    break;
                case NPC_CLUSTER_BIG_RED:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_RED);
                    break;
                case NPC_CLUSTER_BIG_YELLOW:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_YELLOW);
                    break;
                case NPC_CLUSTER_BIG_WHITE:
                    spellId = GetFireworkSpell(NPC_FIREWORK_BIG_WHITE);
                    break;
                case NPC_CLUSTER_ELUNE:
                    spellId = GetFireworkSpell(urand(NPC_FIREWORK_BLUE, NPC_FIREWORK_WHITE));
                    break;
            }

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);

            if (spellInfo && spellInfo->Effects[0].Effect == SPELL_EFFECT_SUMMON_OBJECT_WILD)
                return spellInfo->Effects[0].MiscValue;

            return 0;
        }

        void Reset() override
        {
            if (GameObject* launcher = FindNearestLauncher())
            {
                launcher->SendCustomAnim(ANIM_GO_LAUNCH_FIREWORK);
                me->SetOrientation(launcher->GetOrientation() + M_PI / 2);
            }
            else
                return;

            if (isCluster())
            {
                // Check if we are near Elune'ara lake south, if so try to summon Omen or a minion
                if (me->GetZoneId() == ZONE_MOONGLADE)
                {
                    if (!me->FindNearestCreature(NPC_OMEN, 100.0f, false) && me->GetDistance2d(omenSummonPos.GetPositionX(), omenSummonPos.GetPositionY()) <= 100.0f)
                    {
                        switch (urand(0, 9))
                        {
                            case 0:
                            case 1:
                            case 2:
                            case 3:
                                if (Creature* minion = me->SummonCreature(NPC_MINION_OF_OMEN, me->GetPositionX() + frand(-5.0f, 5.0f), me->GetPositionY() + frand(-5.0f, 5.0f), me->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                                    minion->AI()->AttackStart(me->SelectNearestPlayer(20.0f));
                                break;
                            case 9:
                                me->SummonCreature(NPC_OMEN, omenSummonPos);
                                break;
                        }
                    }
                }
                if (me->GetEntry() == NPC_CLUSTER_ELUNE)
                    DoCast(SPELL_LUNAR_FORTUNE);

                float displacement = 0.7f;
                for (uint8 i = 0; i < 4; i++)
                    me->SummonGameObject(GetFireworkGameObjectId(), me->GetPositionX() + (i % 2 == 0 ? displacement : -displacement), me->GetPositionY() + (i > 1 ? displacement : -displacement), me->GetPositionZ() + 4.0f, me->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 1);
            }
            else
                //me->CastSpell(me, GetFireworkSpell(me->GetEntry()), true);
                me->CastSpell(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), GetFireworkSpell(me->GetEntry()), true);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_fireworkAI(creature);
    }
};

/*#####
# npc_spring_rabbit
#####*/

enum rabbitSpells
{
    SPELL_SPRING_FLING          = 61875,
    SPELL_SPRING_RABBIT_JUMP    = 61724,
    SPELL_SPRING_RABBIT_WANDER  = 61726,
    SPELL_SUMMON_BABY_BUNNY     = 61727,
    SPELL_SPRING_RABBIT_IN_LOVE = 61728,
    NPC_SPRING_RABBIT           = 32791
};

class npc_spring_rabbit : public CreatureScript
{
public:
    npc_spring_rabbit() : CreatureScript("npc_spring_rabbit") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_spring_rabbitAI(creature);
    }

    struct npc_spring_rabbitAI : public ScriptedAI
    {
        npc_spring_rabbitAI(Creature* creature) : ScriptedAI(creature) { }

        bool inLove;
        uint32 jumpTimer;
        uint32 bunnyTimer;
        uint32 searchTimer;
        ObjectGuid rabbitGUID;

        void Reset() override
        {
            inLove = false;
            rabbitGUID.Clear();
            jumpTimer = urand(5000, 10000);
            bunnyTimer = urand(10000, 20000);
            searchTimer = urand(5000, 10000);
            if (Unit* owner = me->GetOwner())
                me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void DoAction(int32 /*param*/) override
        {
            inLove = true;
            if (Unit* owner = me->GetOwner())
                owner->CastSpell(owner, SPELL_SPRING_FLING, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (inLove)
            {
                if (jumpTimer <= diff)
                {
                    if (Unit* rabbit = ObjectAccessor::GetUnit(*me, rabbitGUID))
                        DoCast(rabbit, SPELL_SPRING_RABBIT_JUMP);
                    jumpTimer = urand(5000, 10000);
                }
                else jumpTimer -= diff;

                if (bunnyTimer <= diff)
                {
                    DoCast(SPELL_SUMMON_BABY_BUNNY);
                    bunnyTimer = urand(20000, 40000);
                }
                else bunnyTimer -= diff;
            }
            else
            {
                if (searchTimer <= diff)
                {
                    if (Creature* rabbit = me->FindNearestCreature(NPC_SPRING_RABBIT, 10.0f))
                    {
                        if (rabbit == me || rabbit->HasAura(SPELL_SPRING_RABBIT_IN_LOVE))
                            return;

                        me->AddAura(SPELL_SPRING_RABBIT_IN_LOVE, me);
                        DoAction(1);
                        rabbit->AddAura(SPELL_SPRING_RABBIT_IN_LOVE, rabbit);
                        rabbit->AI()->DoAction(1);
                        rabbit->CastSpell(rabbit, SPELL_SPRING_RABBIT_JUMP, true);
                        rabbitGUID = rabbit->GetGUID();
                    }
                    searchTimer = urand(5000, 10000);
                }
                else searchTimer -= diff;
            }
        }
    };
};

enum StableMasters
{
    SPELL_MINIWING                  = 54573,
    SPELL_JUBLING                   = 54611,
    SPELL_DARTER                    = 54619,
    SPELL_WORG                      = 54631,
    SPELL_SMOLDERWEB                = 54634,
    SPELL_CHIKEN                    = 54677,
    SPELL_WOLPERTINGER              = 54688,

    STABLE_MASTER_GOSSIP_SUB_MENU   = 9820
};

class npc_stable_master : public CreatureScript
{
public:
    npc_stable_master() : CreatureScript("npc_stable_master") { }

    struct npc_stable_masterAI : public SmartAI
    {
        npc_stable_masterAI(Creature* creature) : SmartAI(creature) { }

        void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
        {
            SmartAI::sGossipSelect(player, menuId, gossipListId);
            if (menuId != STABLE_MASTER_GOSSIP_SUB_MENU)
                return;

            switch (gossipListId)
            {
                case 0:
                    player->CastSpell(player, SPELL_MINIWING, false);
                    break;
                case 1:
                    player->CastSpell(player, SPELL_JUBLING, false);
                    break;
                case 2:
                    player->CastSpell(player, SPELL_DARTER, false);
                    break;
                case 3:
                    player->CastSpell(player, SPELL_WORG, false);
                    break;
                case 4:
                    player->CastSpell(player, SPELL_SMOLDERWEB, false);
                    break;
                case 5:
                    player->CastSpell(player, SPELL_CHIKEN, false);
                    break;
                case 6:
                    player->CastSpell(player, SPELL_WOLPERTINGER, false);
                    break;
                default:
                    return;
            }

            player->PlayerTalkClass->SendCloseGossip();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_stable_masterAI(creature);
    }
};

enum VenomhideHatchlingMisc
{
    ITEM_VENOMHIDE_BABY_TOOTH = 47196,

    MODEL_BABY_RAPTOR              = 29251,
    MODEL_BABY_RAPTOR_REPTILE_EYES = 29274,
    MODEL_ADOLESCENT_RAPTOR        = 29275,
    MODEL_FULL_RAPTOR              = 29276,
};

enum VenomhideHatchlingTexts
{
    TALK_EMOTE_EAT = 0,
};

enum VenomhideHatchlingSpellEmotes
{
    SPELL_SILITHID_MEAT       = 65258,
    SPELL_SILITHID_EGG        = 65265,
    SPELL_FRESH_DINOSAUR_MEAT = 65200,
};

class npc_venomhide_hatchling : public CreatureScript
{
public:
    npc_venomhide_hatchling() : CreatureScript("npc_venomhide_hatchling") {}

    struct npc_venomhide_hatchlingAI : public ScriptedAI
    {
        npc_venomhide_hatchlingAI(Creature* creature) : ScriptedAI(creature) {}

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner->IsPlayer())
            {
                return;
            }

            if (summoner->ToPlayer()->GetItemCount(ITEM_VENOMHIDE_BABY_TOOTH) >= 6)
            {
                me->SetDisplayId(MODEL_BABY_RAPTOR_REPTILE_EYES);
            }
            if (summoner->ToPlayer()->GetItemCount(ITEM_VENOMHIDE_BABY_TOOTH) >= 11)
            {
                me->SetDisplayId(MODEL_ADOLESCENT_RAPTOR);
            }
            if (summoner->ToPlayer()->GetItemCount(ITEM_VENOMHIDE_BABY_TOOTH) >= 16)
            {
                me->SetDisplayId(MODEL_FULL_RAPTOR);
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_SILITHID_EGG || spell->Id == SPELL_SILITHID_MEAT || spell->Id == SPELL_FRESH_DINOSAUR_MEAT)
            {
                Talk(TALK_EMOTE_EAT);
            }
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->GetOwnerGUID() && creature->GetOwnerGUID() == player->GetGUID())
        {
            return false;
        }

        return true;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_venomhide_hatchlingAI(creature);
    }
};

enum ArcaniteDragonling
{
    SPELL_FLAME_BUFFET    = 9658,
    SPELL_FLAME_BREATH    = 8873,

    EVENT_FLAME_BUFFET    = 1,
    EVENT_FLAME_BREATH    = 2
};

struct npc_arcanite_dragonling : public ScriptedAI
{
public:
    npc_arcanite_dragonling(Creature* creature) : ScriptedAI(creature)
    {
        creature->SetCanModifyStats(true);
        creature->SetReactState(REACT_AGGRESSIVE);
    }

    void Reset() override
    {
        me->SetPvP(true);
        events.Reset();
    }

    bool CanAIAttack(Unit const* target) const override
    {
        if (Unit* summoner = me->GetCharmerOrOwner())
        {
            if (target->IsPlayer() && (!summoner->IsPvP() || !target->IsPvP()))
                return false;
        }

        return true;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        events.ScheduleEvent(EVENT_FLAME_BUFFET, 4s);
        events.ScheduleEvent(EVENT_FLAME_BREATH, 12s);
    }

    void IsSummonedBy(WorldObject* summoner) override
    {
        if (summoner->IsCreature() || summoner->IsPlayer())
            me->GetMotionMaster()->MoveFollow(summoner->ToUnit(), PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);

    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        switch (events.ExecuteEvent())
        {
            case EVENT_FLAME_BUFFET:
                DoCastVictim(SPELL_FLAME_BUFFET);
                events.Repeat(12s);
                break;
            case EVENT_FLAME_BREATH:
                DoCastVictim(SPELL_FLAME_BREATH);
                events.Repeat(24s);
                break;
        }

        DoMeleeAttackIfReady();
    }
};

struct npc_crashin_thrashin_robot : public ScriptedAI
{
public:
    npc_crashin_thrashin_robot(Creature* creature) : ScriptedAI(creature)
    {
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        _scheduler.Schedule(180s, [this](TaskContext /*context*/)
        {
            me->KillSelf();
        });
    }

    void UpdateAI(uint32 diff) override
    {
        _scheduler.Update(diff);

        ScriptedAI::UpdateAI(diff);
    }

private:
    TaskScheduler _scheduler;
};

struct npc_controller : public PossessedAI
{
    npc_controller(Creature* creature) : PossessedAI(creature) { }

    void OnCharmed(bool apply) override
    {
        if (!apply)
        {
            me->GetCharmerOrOwner()->InterruptNonMeleeSpells(false);
        }
    }
};

void AddSC_npcs_special()
{
    // Ours
    new npc_elder_clearwater();
    new npc_riggle_bassbait();
    new npc_target_dummy();
    new npc_training_dummy();
    new npc_venomhide_hatchling();

    // Theirs
    new npc_air_force_bots();
    new npc_chicken_cluck();
    new npc_dancing_flames();
    new npc_doctor();
    new npc_injured_patient();
    new npc_garments_of_quests();
    new npc_guardian();
    new npc_sayge();
    new npc_steam_tonk();
    new npc_wormhole();
    new npc_pet_trainer();
    new npc_locksmith();
    new npc_experience();
    new npc_firework();
    new npc_spring_rabbit();
    new npc_stable_master();
    RegisterCreatureAI(npc_arcanite_dragonling);
    RegisterCreatureAI(npc_crashin_thrashin_robot);
    RegisterCreatureAI(npc_controller);
}
