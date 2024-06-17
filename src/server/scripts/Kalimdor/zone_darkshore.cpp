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
SDName: Darkshore
SD%Complete: 100
SDComment: Quest support: 731, 2078, 5321
SDCategory: Darkshore
EndScriptData */

/* ContentData
npc_kerlonian
npc_prospector_remtravel
EndContentData */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedFollowerAI.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"

// Ours
enum murkdeep
{
    NPC_GREYMIST_HUNTER      = 2206,
    NPC_GREYMIST_WARRIOR     = 2205,
    NPC_GREYMIST_COASTRUNNER = 2202,

    SPELL_SUNDER_ARMOR = 11971,
    SPELL_NET          = 6533,

    EVENT_SPELL_SUNDER_ARMOR = 2,
    EVENT_SPELL_NET          = 3,
};

class npc_murkdeep : public CreatureScript
{
public:
    npc_murkdeep() : CreatureScript("npc_murkdeep") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_murkdeepAI(creature);
    }

    struct npc_murkdeepAI : public ScriptedAI
    {
        npc_murkdeepAI(Creature* c) : ScriptedAI(c) {}

        uint8    phase;
        uint32   spawnTimer;
        EventMap events;

        void Reset() override
        {
            spawnTimer = 0;
            phase      = 0;
            me->SetVisible(false);
            me->SetReactState(REACT_PASSIVE);
        }

        void JustEngagedWith(Unit*) override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_SUNDER_ARMOR, 5s);
            events.ScheduleEvent(EVENT_SPELL_NET, 10s);
        }

        void UpdateAI(uint32 diff) override
        {
            spawnTimer += diff;
            if (spawnTimer >= 5000)
            {
                spawnTimer = 0;
                switch (phase)
                {
                case 0:
                    if (!me->FindNearestCreature(NPC_GREYMIST_WARRIOR, 80.0f, true) && !me->FindNearestCreature(NPC_GREYMIST_HUNTER, 80.0f, true))
                    {
                        Player* player = me->SelectNearestPlayer(100.0f);
                        if (!player)
                            return;

                        phase++;
                        for (int i = 0; i < 3; ++i)
                            if (Creature* cr = me->SummonCreature(NPC_GREYMIST_COASTRUNNER, me->GetPositionX() + irand(-5, 5), me->GetPositionY() + irand(-5, 5), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                                cr->AI()->AttackStart(player);
                    }
                    return;
                case 1:
                    if (!me->FindNearestCreature(NPC_GREYMIST_COASTRUNNER, 80.0f))
                    {
                        Player* player = me->SelectNearestPlayer(100.0f);
                        if (!player)
                            return;

                        phase++;
                        for (int i = 0; i < 2; ++i)
                            if (Creature* cr = me->SummonCreature(NPC_GREYMIST_WARRIOR, me->GetPositionX() + irand(-5, 5), me->GetPositionY() + irand(-5, 5), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                                cr->AI()->AttackStart(player);
                    }
                    return;
                case 2:
                    if (!me->FindNearestCreature(NPC_GREYMIST_WARRIOR, 80.0f))
                    {
                        Player* player = me->SelectNearestPlayer(100.0f);
                        if (!player)
                            return;

                        phase++;
                        if (Creature* cr = me->SummonCreature(NPC_GREYMIST_HUNTER, me->GetPositionX() + irand(-5, 5), me->GetPositionY() + irand(-5, 5), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000))
                            cr->AI()->AttackStart(player);

                        me->SetReactState(REACT_AGGRESSIVE);
                        me->SetVisible(true);
                        AttackStart(player);
                    }
                    return;
                }
            }

            if (!me->IsVisible())
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (events.ExecuteEvent())
            {
            case EVENT_SPELL_SUNDER_ARMOR:
                me->CastSpell(me->GetVictim(), SPELL_SUNDER_ARMOR, false);
                events.ScheduleEvent(EVENT_SPELL_SUNDER_ARMOR, 15s);
                break;
            case EVENT_SPELL_NET:
                me->CastSpell(me->GetVictim(), SPELL_NET, false);
                events.ScheduleEvent(EVENT_SPELL_NET, 25s);
                break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

// Theirs
/*####
# npc_kerlonian
####*/

enum Kerlonian
{
    SAY_KER_START               = 0,
    EMOTE_KER_SLEEP             = 1,
    SAY_KER_SLEEP               = 2,
    SAY_KER_ALERT_1             = 3,
    SAY_KER_END                 = 4,
    EMOTE_KER_AWAKEN            = 5,

    SPELL_SLEEP_VISUAL          = 25148,
    SPELL_AWAKEN                = 17536,
    SPELL_BEAR_FORM             = 18309,
    QUEST_SLEEPER_AWAKENED      = 5321,
    NPC_LILADRIS                = 11219                    //attackers entries unknown
};

/// @todo make concept similar as "ringo" -escort. Find a way to run the scripted attacks, _if_ player are choosing road.
class npc_kerlonian : public CreatureScript
{
public:
    npc_kerlonian() : CreatureScript("npc_kerlonian") {}

    struct npc_kerlonianAI : public FollowerAI
    {
        npc_kerlonianAI(Creature* creature) : FollowerAI(creature) {}

        uint32 FallAsleepTimer;

        void Reset() override
        {
            FallAsleepTimer = urand(10000, 45000);

            DoCastSelf(SPELL_BEAR_FORM);
        }

        void MoveInLineOfSight(Unit* who) override

        {
            FollowerAI::MoveInLineOfSight(who);

            if (!me->GetVictim() && !HasFollowState(STATE_FOLLOW_COMPLETE) && who->GetEntry() == NPC_LILADRIS)
            {
                if (me->IsWithinDistInMap(who, INTERACTION_DISTANCE * 5))
                {
                    if (Player* player = GetLeaderForFollower())
                    {
                        if (player->GetQuestStatus(QUEST_SLEEPER_AWAKENED) == QUEST_STATUS_INCOMPLETE)
                            player->GroupEventHappens(QUEST_SLEEPER_AWAKENED, me);

                        Talk(SAY_KER_END);
                    }

                    SetFollowComplete();
                }
            }
        }

        void SpellHit(Unit* /*pCaster*/, SpellInfo const* pSpell) override
        {
            if (HasFollowState(STATE_FOLLOW_INPROGRESS | STATE_FOLLOW_PAUSED) && pSpell->Id == SPELL_AWAKEN)
                ClearSleeping();
        }

        void SetSleeping()
        {
            SetFollowPaused(true);

            Talk(EMOTE_KER_SLEEP);

            Talk(SAY_KER_SLEEP);

            me->SetStandState(UNIT_STAND_STATE_SLEEP);
            DoCast(me, SPELL_SLEEP_VISUAL, false);
        }

        void ClearSleeping()
        {
            me->RemoveAurasDueToSpell(SPELL_SLEEP_VISUAL);
            me->SetStandState(UNIT_STAND_STATE_STAND);

            Talk(EMOTE_KER_AWAKEN);

            SetFollowPaused(false);
        }

        void UpdateFollowerAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                if (!HasFollowState(STATE_FOLLOW_INPROGRESS))
                    return;

                if (!HasFollowState(STATE_FOLLOW_PAUSED))
                {
                    if (FallAsleepTimer <= diff)
                    {
                        SetSleeping();
                        FallAsleepTimer = urand(25000, 90000);
                    }
                    else
                        FallAsleepTimer -= diff;
                }

                return;
            }

            DoMeleeAttackIfReady();
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_SLEEPER_AWAKENED)
        {
            if (npc_kerlonianAI* pKerlonianAI = CAST_AI(npc_kerlonian::npc_kerlonianAI, creature->AI()))
            {
                creature->SetStandState(UNIT_STAND_STATE_STAND);
                creature->AI()->Talk(SAY_KER_START, player);
                pKerlonianAI->StartFollow(player, FACTION_ESCORTEE_N_NEUTRAL_PASSIVE, quest);
            }
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_kerlonianAI(creature);
    }
};

/*####
# npc_prospector_remtravel
####*/

enum Remtravel
{
    SAY_REM_START               = 0,
    SAY_REM_AGGRO               = 1,
    SAY_REM_RAMP1_1             = 2,
    SAY_REM_RAMP1_2             = 3,
    SAY_REM_BOOK                = 4,
    SAY_REM_TENT1_1             = 5,
    SAY_REM_TENT1_2             = 6,
    SAY_REM_MOSS                = 7,
    EMOTE_REM_MOSS              = 8,
    SAY_REM_MOSS_PROGRESS       = 9,
    SAY_REM_PROGRESS            = 10,
    SAY_REM_REMEMBER            = 11,
    EMOTE_REM_END               = 12,

    QUEST_ABSENT_MINDED_PT2     = 731,
    NPC_GRAVEL_SCOUT            = 2158,
    NPC_GRAVEL_BONE             = 2159,
    NPC_GRAVEL_GEO              = 2160
};

class npc_prospector_remtravel : public CreatureScript
{
public:
    npc_prospector_remtravel() : CreatureScript("npc_prospector_remtravel") {}

    struct npc_prospector_remtravelAI : public npc_escortAI
    {
        npc_prospector_remtravelAI(Creature* creature) : npc_escortAI(creature) {}

        void Reset() override {}

        void JustEngagedWith(Unit* who) override
        {
            if (urand(0, 1))
                Talk(SAY_REM_AGGRO, who);
        }

        void JustSummoned(Creature* /*pSummoned*/) override
        {
            // unsure if it should be any
            // pSummoned->AI()->AttackStart(me);
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (Player* player = GetPlayerForEscort())
            {
                switch (waypointId)
                {
                case 0:
                    Talk(SAY_REM_START, player);
                    break;
                case 5:
                    Talk(SAY_REM_RAMP1_1, player);
                    break;
                case 6:
                    DoSpawnCreature(NPC_GRAVEL_SCOUT, -10.0f, 5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_GRAVEL_BONE, -10.0f, 7.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 9:
                    Talk(SAY_REM_RAMP1_2, player);
                    break;
                case 14:
                    // depend quest rewarded?
                    Talk(SAY_REM_BOOK, player);
                    break;
                case 15:
                    Talk(SAY_REM_TENT1_1, player);
                    break;
                case 16:
                    DoSpawnCreature(NPC_GRAVEL_SCOUT, -10.0f, 5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_GRAVEL_BONE, -10.0f, 7.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 17:
                    Talk(SAY_REM_TENT1_2, player);
                    break;
                case 26:
                    Talk(SAY_REM_MOSS, player);
                    break;
                case 27:
                    Talk(EMOTE_REM_MOSS, player);
                    break;
                case 28:
                    Talk(SAY_REM_MOSS_PROGRESS, player);
                    break;
                case 29:
                    DoSpawnCreature(NPC_GRAVEL_SCOUT, -15.0f, 3.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_GRAVEL_BONE, -15.0f, 5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_GRAVEL_GEO, -15.0f, 7.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 31:
                    Talk(SAY_REM_PROGRESS, player);
                    break;
                case 41:
                    Talk(SAY_REM_REMEMBER, player);
                    break;
                case 42:
                    Talk(EMOTE_REM_END, player);
                    player->GroupEventHappens(QUEST_ABSENT_MINDED_PT2, me);
                    break;
                }
            }
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_ABSENT_MINDED_PT2)
        {
            if (npc_escortAI* pEscortAI = CAST_AI(npc_prospector_remtravel::npc_prospector_remtravelAI, creature->AI()))
                pEscortAI->Start(false, false, player->GetGUID());

            creature->SetFaction(FACTION_ESCORTEE_A_NEUTRAL_PASSIVE);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_prospector_remtravelAI(creature);
    }
};

enum eRabidThistleBear
{
    EVENT_CHECK_FOLLOWING           = 1,
    NPC_RABID_THISTLE_BEAR          = 2164,
    NPC_CAPTURED_RABID_THISTLE_BEAR = 11836,
    OBJECT_BEAR_TRAP                = 111148,
    QUEST_PLAGUED_LANDS             = 2118,
    SPELL_BEAR_CAPTURED_IN_TRAP     = 9439,
    SPELL_THARNARIUMS_HEAL          = 9457
};

class npc_rabid_thistle_bear : public CreatureScript
{
public:
    npc_rabid_thistle_bear() : CreatureScript("npc_rabid_thistle_bear") {}

    struct npc_rabid_thistle_bearAI : public FollowerAI
    {
        npc_rabid_thistle_bearAI(Creature* creature) : FollowerAI(creature)
        {
            Initialize();
        }

        void Initialize()
        {
            me->SetEntry(NPC_RABID_THISTLE_BEAR);
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, 0);
            _playerGUID.Clear();
        }

        void Reset() override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_BEAR_CAPTURED_IN_TRAP)
            {
                if (GameObject* trap = me->FindNearestGameObject(OBJECT_BEAR_TRAP, 5.0f))
                {
                    if (Unit* owner = trap->GetOwner())
                    {
                        if (Player* player = owner->ToPlayer())
                        {
                            _playerGUID = player->GetGUID();
                            me->SetEntry(NPC_CAPTURED_RABID_THISTLE_BEAR);
                            me->SetFaction(FACTION_FRIENDLY);
                            me->GetMotionMaster()->MoveFollow(player, 1.0f, PET_FOLLOW_ANGLE - (PET_FOLLOW_ANGLE / 4));
                            _events.Reset();
                            _events.ScheduleEvent(EVENT_CHECK_FOLLOWING, 1s);
                            player->KilledMonsterCredit(NPC_CAPTURED_RABID_THISTLE_BEAR);
                            me->DespawnOrUnsummon(240000);
                        }
                    }
                }
            }

            if (spellInfo->Id == SPELL_THARNARIUMS_HEAL)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H); // EMOTE_ONESHOT_WOUND
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (me->GetFaction() == FACTION_FRIENDLY)
            {
                _events.Update(diff);
                switch (_events.ExecuteEvent())
                {
                    case EVENT_CHECK_FOLLOWING:
                        Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID);
                        if (!player || me->GetDistance2d(player) > 100.0f || me->GetMotionMaster()->GetCurrentMovementGeneratorType() != FOLLOW_MOTION_TYPE || player->GetQuestStatus(QUEST_PLAGUED_LANDS) == QUEST_STATUS_NONE)
                        {
                            me->DespawnOrUnsummon();
                        }
                        _events.ScheduleEvent(EVENT_CHECK_FOLLOWING, 1s);
                        break;
                }
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
        ObjectGuid _playerGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_rabid_thistle_bearAI(creature);
    }
};

enum eTharnarian
{
    EVENT_POST_QUEST_ONE            = 1,
    EVENT_POST_QUEST_TWO            = 2,
    EVENT_POST_QUEST_THREE          = 3,
    ITEM_THARNARIUMS_HOPE           = 7586,
    GUID_SCRIPT_INVOKER             = 1,
    SAY_BE_CLEANSED                 = 0
};

class npc_tharnarian : public CreatureScript
{
public:
    npc_tharnarian() : CreatureScript("npc_tharnarian") {}

    struct npc_tharnarianAI : public ScriptedAI
    {
        npc_tharnarianAI(Creature* creature) : ScriptedAI(creature)
        {
            Initialize();
        }

        void Initialize()
        {
            _scriptRunning = false;
            _facing        = me->GetOrientation();
        }

        void Reset() override
        {
            _events.Reset();
        }

        void sGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            if (gossipListId == 1)
            {
                CloseGossipMenuFor(player);
                player->AddItem(ITEM_THARNARIUMS_HOPE, 1);
            }
        }

        void SetGUID(ObjectGuid /*guid*/, int32 type) override
        {
            if (type == GUID_SCRIPT_INVOKER && _scriptRunning == false)
            {
                if (Creature* bear = me->FindNearestCreature(NPC_CAPTURED_RABID_THISTLE_BEAR, 5.0f))
                {
                    _bearGUID      = bear->GetGUID();
                    _scriptRunning = true;
                    _events.ScheduleEvent(EVENT_POST_QUEST_ONE, 1s);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_scriptRunning)
            {
                _events.Update(diff);
                switch (_events.ExecuteEvent())
                {
                    case EVENT_POST_QUEST_ONE:
                        if (Creature* bear = ObjectAccessor::GetCreature(*me, _bearGUID))
                        {
                            Talk(SAY_BE_CLEANSED);
                            me->CastSpell(bear, SPELL_THARNARIUMS_HEAL);
                        }
                        _events.ScheduleEvent(EVENT_POST_QUEST_TWO, 4s);
                        break;
                    case EVENT_POST_QUEST_TWO:
                        if (Creature* bear = ObjectAccessor::GetCreature(*me, _bearGUID))
                        {
                            bear->SetUInt32Value(UNIT_FIELD_BYTES_1, 7);
                        }
                        _events.ScheduleEvent(EVENT_POST_QUEST_THREE, 1s);
                        break;
                    case EVENT_POST_QUEST_THREE:
                        if (Creature* bear = ObjectAccessor::GetCreature(*me, _bearGUID))
                        {
                            bear->DespawnOrUnsummon();
                            _scriptRunning = false;
                        }
                        break;
                }
            }

            if (!UpdateVictim())
            {
                return;
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap   _events;
        ObjectGuid _bearGUID;
        bool       _scriptRunning;
        float      _facing;
    };

    bool OnQuestReward(Player* player, Creature* creature, const Quest* _Quest, uint32 /*slot*/) override
    {
        if (_Quest->GetQuestId() == QUEST_PLAGUED_LANDS)
        {
            creature->AI()->SetGUID(player->GetGUID(), GUID_SCRIPT_INVOKER);
        }
        return false;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_tharnarianAI(creature);
    }
};

void AddSC_darkshore()
{
    // Ours
    new npc_murkdeep();
    new npc_rabid_thistle_bear();
    new npc_tharnarian();

    // Theirs
    new npc_kerlonian();
    new npc_prospector_remtravel();
}
