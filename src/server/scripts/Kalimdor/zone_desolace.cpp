/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Desolace
SD%Complete: 100
SDComment: Quest support: 5561
SDCategory: Desolace
EndScriptData */

/* ContentData
npc_aged_dying_ancient_kodo
npc_dalinda_malem
go_demon_portal
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "SpellInfo.h"

// Ours
enum Caravan
{
    QUEST_BODYGUARD_FOR_HIRE            = 5821,
    QUEST_GIZELTON_CARAVAN              = 5943,

    EVENT_RESUME_PATH                   = 1,
    EVENT_WAIT_FOR_ASSIST               = 2,
    EVENT_RESTART_ESCORT                = 3,

    NPC_CORK_GIZELTON                   = 11625,
    NPC_RIGGER_GIZELTON                 = 11626,
    NPC_CARAVAN_KODO                    = 11564,
    NPC_VENDOR_TRON                     = 12245,
    NPC_SUPER_SELLER                    = 12246,

    SAY_CARAVAN_LEAVE                   = 0,
    SAY_CARAVAN_HIRE                    = 1,

    MAX_CARAVAN_SUMMONS                 = 3,

    TIME_SHOP_STOP                      = 10*MINUTE*IN_MILLISECONDS,
    TIME_HIRE_STOP                      = 4*MINUTE*IN_MILLISECONDS,

    // Ambush
    NPC_KOLKAR_WAYLAYER                 = 12976,
    NPC_KOLKAR_AMBUSHER                 = 12977,
    NPC_LESSER_INFERNAL                 = 4676,
    NPC_DOOMWARDER                      = 4677,
    NPC_NETHER                          = 4684,

};

class npc_cork_gizelton : public CreatureScript
{
    public:
        npc_cork_gizelton() : CreatureScript("npc_cork_gizelton") { }

        bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_BODYGUARD_FOR_HIRE)
                creature->AI()->SetGUID(player->GetGUID(), player->getFaction());

            return true;
        }

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_cork_gizeltonAI(creature);
        }

        struct npc_cork_gizeltonAI : public npc_escortAI
        {
            npc_cork_gizeltonAI(Creature* creature) : npc_escortAI(creature)
            {
                memset(&summons, 0, sizeof(summons));
            }

            EventMap events;
            uint64 summons[MAX_CARAVAN_SUMMONS];
            bool headNorth;

            uint64 _playerGUID;
            uint32 _faction;

            void Initialize()
            {
                _playerGUID = 0;
                _faction = 35;
                headNorth = true;
                me->setActive(true);
                events.ScheduleEvent(EVENT_RESTART_ESCORT, 0);
            }

            void JustRespawned()
            {
                npc_escortAI::JustRespawned();
                Initialize();
            }

            void InitializeAI()
            {
                npc_escortAI::InitializeAI();
                Initialize();
            }

            void JustDied(Unit* killer)
            {
                RemoveSummons();
                npc_escortAI::JustDied(killer);
            }

            void EnterEvadeMode()
            {
                SummonsFollow();
                ImmuneFlagSet(false, 35);
                npc_escortAI::EnterEvadeMode();
            }

            void CheckPlayer()
            {
                if (_playerGUID)
                    if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                        if (me->IsWithinDist(player, 60.0f))
                            return;

                _playerGUID = 0;
                _faction = 35;
                ImmuneFlagSet(false, _faction);
            }

            void SetGUID(uint64 playerGUID, int32 faction)
            {
                _playerGUID = playerGUID;
                _faction = faction;
                SetEscortPaused(false);
                if (Creature* active = !headNorth ? me : ObjectAccessor::GetCreature(*me, summons[0]))
                    active->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                events.CancelEvent(EVENT_WAIT_FOR_ASSIST);
            }

            void SetData(uint32 field, uint32 data)
            {
                if (field == 1 && data == 1)
                    if (Player* player = me->SelectNearestPlayer(50.0f))
                        SetGUID(player->GetGUID(), player->getFaction());
            }

            bool CheckCaravan()
            {
                for (uint8 i = 0; i < MAX_CARAVAN_SUMMONS; ++i)
                {
                    if (summons[i] == 0)
                    {
                        SummonHelpers();
                        return false;
                    }

                    Creature* summon = ObjectAccessor::GetCreature(*me, summons[i]);
                    if (!summon || me->GetDistance2d(summon) > 25.0f)
                    {
                        SummonHelpers();
                        return false;
                    }
                }
                return true;
            }

            void RemoveSummons()
            {
                for (uint8 i = 0; i < MAX_CARAVAN_SUMMONS; ++i)
                {
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, summons[i]))
                        summon->DespawnOrUnsummon();

                    summons[i] = 0;
                }
            }

            void SummonHelpers()
            {
                RemoveSummons();
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

                Creature* cr = nullptr;
                if ((cr = me->SummonCreature(NPC_RIGGER_GIZELTON, *me)))
                {
                    cr->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                    summons[0] = cr->GetGUID();
                }
                if ((cr = me->SummonCreature(NPC_CARAVAN_KODO, *me)))
                    summons[1] = cr->GetGUID();
                if ((cr = me->SummonCreature(NPC_CARAVAN_KODO, *me)))
                    summons[2] = cr->GetGUID();

                SummonsFollow();
            }

            void SummonedCreatureDies(Creature* creature, Unit*)
            {
                if (creature->GetGUID() == summons[0])
                    summons[0] = 0;
                else if (creature->GetGUID() == summons[1])
                    summons[1] = 0;
                else if (creature->GetGUID() == summons[2])
                    summons[2] = 0;
            }

            void SummonedCreatureDespawn(Creature* creature)
            {
                if (creature->GetGUID() == summons[0])
                    summons[0] = 0;
                else if (creature->GetGUID() == summons[1])
                    summons[1] = 0;
                else if (creature->GetGUID() == summons[2])
                    summons[2] = 0;
            }

            void SummonsFollow()
            {
                float dist = 1.0f;
                for (uint8 i = 0; i < MAX_CARAVAN_SUMMONS; ++i)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, summons[i]))
                    {
                        summon->GetMotionMaster()->Clear(false);
                        summon->StopMoving();
                        summon->GetMotionMaster()->MoveFollow(me, dist, M_PI, MOTION_SLOT_ACTIVE);
                        dist += (i == 1 ? 9.5f : 3.0f);
                    }
            }

            void RelocateSummons()
            {
                for (uint8 i = 0; i < MAX_CARAVAN_SUMMONS; ++i)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, summons[i]))
                        summon->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            }

            void ImmuneFlagSet(bool remove, uint32 faction)
            {
                for (uint8 i = 0; i < MAX_CARAVAN_SUMMONS; ++i)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, summons[i]))
                    {
                        summon->setFaction(faction);
                        if (remove)
                            summon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                        else
                            summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                    }
                if (remove)
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                else
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                me->setFaction(faction);
            }

            void WaypointReached(uint32 waypointId)
            {
                RelocateSummons();
                switch (waypointId)
                {
                    // Finished north path
                    case 52:
                        me->SummonCreature(NPC_VENDOR_TRON, -694.61f, 1460.7f, 90.794f, 2.4f, TEMPSUMMON_TIMED_DESPAWN, TIME_SHOP_STOP+15*IN_MILLISECONDS);
                        SetEscortPaused(true);
                        events.ScheduleEvent(EVENT_RESUME_PATH, TIME_SHOP_STOP);
                        CheckCaravan();
                        break;
                    // Finished south path
                    case 193:
                        me->SummonCreature(NPC_SUPER_SELLER, -1905.5f, 2463.3f, 61.52f, 5.87f, TEMPSUMMON_TIMED_DESPAWN, TIME_SHOP_STOP+15*IN_MILLISECONDS);
                        SetEscortPaused(true);
                        events.ScheduleEvent(EVENT_RESUME_PATH, TIME_SHOP_STOP);
                        CheckCaravan();
                        break;
                    // North -> South - hire
                    case 77:
                        SetEscortPaused(true);
                        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                        Talk(SAY_CARAVAN_HIRE);
                        events.ScheduleEvent(EVENT_WAIT_FOR_ASSIST, TIME_HIRE_STOP);
                        break;
                    // Sout -> North - hire
                    case 208:
                        SetEscortPaused(true);
                        if (Creature* rigger = ObjectAccessor::GetCreature(*me, summons[0]))
                        {
                            rigger->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                            rigger->AI()->Talk(SAY_CARAVAN_HIRE);
                        }
                        events.ScheduleEvent(EVENT_WAIT_FOR_ASSIST, TIME_HIRE_STOP);
                        break;
                    // North -> South - complete
                    case 103:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                        {
                            if (CheckCaravan())
                                player->GroupEventHappens(QUEST_BODYGUARD_FOR_HIRE, player);
                            else
                                player->FailQuest(QUEST_BODYGUARD_FOR_HIRE);
                        }
                        _playerGUID = 0;
                        CheckPlayer();
                        break;
                    // South -> North - complete
                    case 235:
                        if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                        {
                            if (CheckCaravan())
                                player->GroupEventHappens(QUEST_GIZELTON_CARAVAN, player);
                            else
                                player->FailQuest(QUEST_GIZELTON_CARAVAN);
                        }
                        _playerGUID = 0;
                        CheckPlayer();
                        break;
                    // North -> South - spawn attackers
                    case 83:
                    case 93:
                    case 100:
                    {
                        if (!_playerGUID)
                            return;
                        ImmuneFlagSet(true, _faction);
                        Creature* cr = nullptr;
                        for (uint8 i = 0; i < 4; ++i)
                        {
                            float o = (i*M_PI/2)+(M_PI/4);
                            float x = me->GetPositionX()+cos(o)*15.0f;
                            float y = me->GetPositionY()+sin(o)*15.0f;
                            if ((cr = me->SummonCreature((i%2 == 0 ? NPC_KOLKAR_WAYLAYER : NPC_KOLKAR_AMBUSHER),
                                x, y, me->GetMap()->GetHeight(x, y, MAX_HEIGHT), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                                cr->AI()->AttackStart(me);
                        }
                        if (cr)
                        {
                            AttackStart(cr);
                            me->CallForHelp(50.0f);
                        }
                        break;
                    }
                    // South -> North - spawn attackers
                    case 221:
                    case 228:
                    case 233:
                    {
                        if (!_playerGUID)
                            return;
                        ImmuneFlagSet(true, _faction);
                        Creature* cr = nullptr;
                        for (uint8 i = 0; i < 3; ++i)
                        {
                            float o = i*2*M_PI/3;
                            float x = me->GetPositionX()+cos(o)*10.0f;
                            float y = me->GetPositionY()+sin(o)*10.0f;
                            uint32 entry = NPC_LESSER_INFERNAL;
                            if (i)
                                entry = i == 1 ? NPC_DOOMWARDER : NPC_NETHER;

                            if ((cr = me->SummonCreature(entry, x, y, me->GetMap()->GetHeight(x, y, MAX_HEIGHT), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                                cr->AI()->AttackStart(me);
                        }
                        if (cr)
                        {
                            AttackStart(cr);
                            me->CallForHelp(50.0f);
                        }
                        break;
                    }
                    case 282:
                        events.ScheduleEvent(EVENT_RESTART_ESCORT, 1000);
                        break;

                }
            }

            void UpdateEscortAI(uint32 diff)
            {
                events.Update(diff);
                switch (events.ExecuteEvent())
                {
                    case EVENT_RESUME_PATH:
                        SetEscortPaused(false);
                        if (Creature* talker = headNorth ? me : ObjectAccessor::GetCreature(*me, summons[0]))
                            talker->AI()->Talk(SAY_CARAVAN_LEAVE);

                        headNorth = !headNorth;
                        break;
                    case EVENT_WAIT_FOR_ASSIST:
                        SetEscortPaused(false);
                        if (Creature* active = !headNorth ? me : ObjectAccessor::GetCreature(*me, summons[0]))
                            active->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                        break;
                    case EVENT_RESTART_ESCORT:
                        CheckCaravan();
                        SetDespawnAtEnd(false);
                        Start(true, true, 0, 0, false, false, true);
                        break;
                }

                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }
        };
};


// Theirs
enum DyingKodo
{
    SAY_SMEED_HOME                  = 0,

    QUEST_KODO                      = 5561,

    NPC_SMEED                       = 11596,
    NPC_AGED_KODO                   = 4700,
    NPC_DYING_KODO                  = 4701,
    NPC_ANCIENT_KODO                = 4702,
    NPC_TAMED_KODO                  = 11627,

    SPELL_KODO_KOMBO_ITEM           = 18153,
    SPELL_KODO_KOMBO_PLAYER_BUFF    = 18172,
    SPELL_KODO_KOMBO_DESPAWN_BUFF   = 18377,
    SPELL_KODO_KOMBO_GOSSIP         = 18362

};

class npc_aged_dying_ancient_kodo : public CreatureScript
{
public:
    npc_aged_dying_ancient_kodo() : CreatureScript("npc_aged_dying_ancient_kodo") { }

    struct npc_aged_dying_ancient_kodoAI : public ScriptedAI
    {
        npc_aged_dying_ancient_kodoAI(Creature* creature) : ScriptedAI(creature) {}

        void JustRespawned() override
        {
            me->UpdateEntry(RAND(NPC_AGED_KODO, NPC_DYING_KODO, NPC_ANCIENT_KODO), NULL, false);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetEntry() == NPC_SMEED && me->IsWithinDistInMap(who, 10.0f) && !me->HasAura(SPELL_KODO_KOMBO_GOSSIP))
            {
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                me->GetMotionMaster()->Clear();

                DoCast(me, SPELL_KODO_KOMBO_GOSSIP, true);
                if (Creature* smeed = who->ToCreature())
                    smeed->AI()->Talk(SAY_SMEED_HOME);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_KODO_KOMBO_ITEM)
            {
                if (!(caster->HasAura(SPELL_KODO_KOMBO_PLAYER_BUFF) || me->HasAura(SPELL_KODO_KOMBO_DESPAWN_BUFF))
                    && (me->GetEntry() == NPC_AGED_KODO || me->GetEntry() == NPC_DYING_KODO || me->GetEntry() == NPC_ANCIENT_KODO))
                {
                    me->UpdateEntry(NPC_TAMED_KODO, NULL, false);
                    EnterEvadeMode();
                    me->GetMotionMaster()->MoveFollow(caster, PET_FOLLOW_DIST, me->GetFollowAngle());

                    caster->CastSpell(caster, SPELL_KODO_KOMBO_PLAYER_BUFF, true);
                    DoCast(me, SPELL_KODO_KOMBO_DESPAWN_BUFF, true);
                }
            }
            else if (spell->Id == SPELL_KODO_KOMBO_GOSSIP)
            {
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                me->DespawnOrUnsummon(60000);
            }
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAura(SPELL_KODO_KOMBO_PLAYER_BUFF) && creature->HasAura(SPELL_KODO_KOMBO_DESPAWN_BUFF))
        {
            player->TalkedToCreature(creature->GetEntry(), 0);
            player->RemoveAurasDueToSpell(SPELL_KODO_KOMBO_PLAYER_BUFF);
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_aged_dying_ancient_kodoAI(creature);
    }

};

/*######
## npc_dalinda_malem. Quest 1440
######*/

enum Dalinda
{
    QUEST_RETURN_TO_VAHLARRIEL      = 1440
};

class npc_dalinda : public CreatureScript
{
public:
    npc_dalinda() : CreatureScript("npc_dalinda") { }

    struct npc_dalindaAI : public npc_escortAI
    {
        npc_dalindaAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() { }

        void EnterCombat(Unit* /*who*/) { }

        void JustDied(Unit* /*killer*/)
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_RETURN_TO_VAHLARRIEL);
            return;
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();

            switch (waypointId)
            {
                case 1:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    break;
                case 15:
                    if (player)
                        player->GroupEventHappens(QUEST_RETURN_TO_VAHLARRIEL, me);
                    break;
            }
        }

        void UpdateAI(uint32 diff)
        {
            npc_escortAI::UpdateAI(diff);

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_RETURN_TO_VAHLARRIEL)
       {
            if (npc_escortAI* escortAI = CAST_AI(npc_dalinda::npc_dalindaAI, creature->AI()))
            {
                escortAI->Start(true, false, player->GetGUID());
                creature->setFaction(113);
            }
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_dalindaAI(creature);
    }
};

/*######
## go_demon_portal
######*/

enum DemonPortal
{
    NPC_DEMON_GUARDIAN          = 11937,
    QUEST_PORTAL_OF_THE_LEGION  = 5581
};

class go_demon_portal : public GameObjectScript
{
    public:
        go_demon_portal() : GameObjectScript("go_demon_portal") { }

        bool OnGossipHello(Player* player, GameObject* go) override
        {
            if (player->GetQuestStatus(QUEST_PORTAL_OF_THE_LEGION) == QUEST_STATUS_INCOMPLETE && !go->FindNearestCreature(NPC_DEMON_GUARDIAN, 5.0f, true))
            {
                if (Creature* guardian = player->SummonCreature(NPC_DEMON_GUARDIAN, go->GetPositionX(), go->GetPositionY(), go->GetPositionZ(), 0.0f, TEMPSUMMON_DEAD_DESPAWN, 0))
                    guardian->AI()->AttackStart(player);
            }

            return true;
        }
};

void AddSC_desolace()
{
    // Ours
    new npc_cork_gizelton();

    // Theirs
    new npc_aged_dying_ancient_kodo();
    new npc_dalinda();
    new go_demon_portal();
}
