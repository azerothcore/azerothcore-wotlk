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
SDName: Desolace
SD%Complete: 100
SDComment: Quest support: 5561
SDCategory: Desolace
EndScriptData */

/* ContentData
npc_aged_dying_ancient_kodo
EndContentData */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
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

    TIME_SHOP_STOP                      = 10 * MINUTE * IN_MILLISECONDS,
    TIME_HIRE_STOP                      = 4 * MINUTE * IN_MILLISECONDS,

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

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_BODYGUARD_FOR_HIRE)
            creature->AI()->SetGUID(player->GetGUID(), player->GetFaction());

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_cork_gizeltonAI(creature);
    }

    struct npc_cork_gizeltonAI : public npc_escortAI
    {
        npc_cork_gizeltonAI(Creature* creature) : npc_escortAI(creature)
        {
        }

        EventMap events;
        ObjectGuid summons[MAX_CARAVAN_SUMMONS];
        bool headNorth;

        ObjectGuid _playerGUID;
        uint32 _faction;

        void Initialize()
        {
            _faction = 35;
            headNorth = true;
            me->setActive(true);
            events.ScheduleEvent(EVENT_RESTART_ESCORT, 0ms);
        }

        void JustRespawned() override
        {
            npc_escortAI::JustRespawned();
            Initialize();
        }

        void InitializeAI() override
        {
            npc_escortAI::InitializeAI();
            Initialize();
        }

        void JustDied(Unit* killer) override
        {
            RemoveSummons();
            npc_escortAI::JustDied(killer);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            SummonsFollow();
            ImmuneFlagSet(false, 35);
            npc_escortAI::EnterEvadeMode(why);
        }

        void CheckPlayer()
        {
            if (_playerGUID)
                if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                    if (me->IsWithinDist(player, 60.0f))
                        return;

            _playerGUID.Clear();
            _faction = 35;
            ImmuneFlagSet(false, _faction);
        }

        void SetGUID(ObjectGuid playerGUID, int32 faction) override
        {
            _playerGUID = playerGUID;
            _faction = faction;
            SetEscortPaused(false);
            if (Creature* active = !headNorth ? me : ObjectAccessor::GetCreature(*me, summons[0]))
                active->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            events.CancelEvent(EVENT_WAIT_FOR_ASSIST);
        }

        void SetData(uint32 field, uint32 data) override
        {
            if (field == 1 && data == 1)
                if (Player* player = me->SelectNearestPlayer(50.0f))
                    SetGUID(player->GetGUID(), player->GetFaction());
        }

        bool CheckCaravan()
        {
            for (uint8 i = 0; i < MAX_CARAVAN_SUMMONS; ++i)
            {
                if (!summons[i])
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

                summons[i].Clear();
            }
        }

        void SummonHelpers()
        {
            RemoveSummons();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);

            if (Creature* cr = me->SummonCreature(NPC_RIGGER_GIZELTON, *me))
            {
                cr->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                summons[0] = cr->GetGUID();
            }
            if (Creature* cr = me->SummonCreature(NPC_CARAVAN_KODO, *me))
            {
                summons[1] = cr->GetGUID();
            }
            if (Creature* cr = me->SummonCreature(NPC_CARAVAN_KODO, *me))
            {
                summons[2] = cr->GetGUID();
            }

            SummonsFollow();
        }

        void SummonedCreatureDies(Creature* creature, Unit*) override
        {
            if (creature->GetGUID() == summons[0])
                summons[0].Clear();
            else if (creature->GetGUID() == summons[1])
                summons[1].Clear();
            else if (creature->GetGUID() == summons[2])
                summons[2].Clear();
        }

        void SummonedCreatureDespawn(Creature* creature) override
        {
            if (creature->GetGUID() == summons[0])
                summons[0].Clear();
            else if (creature->GetGUID() == summons[1])
                summons[1].Clear();
            else if (creature->GetGUID() == summons[2])
                summons[2].Clear();
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
                    summon->SetFaction(faction);
                    if (remove)
                        summon->SetImmuneToNPC(false);
                    else
                        summon->SetImmuneToNPC(true);
                }
            if (remove)
                me->SetImmuneToNPC(false);
            else
                me->SetImmuneToNPC(true);
            me->SetFaction(faction);
        }

        void WaypointReached(uint32 waypointId) override
        {
            RelocateSummons();
            switch (waypointId)
            {
                // Finished north path
                case 52:
                    me->SummonCreature(NPC_VENDOR_TRON, -694.61f, 1460.7f, 90.794f, 2.4f, TEMPSUMMON_TIMED_DESPAWN, TIME_SHOP_STOP + 15 * IN_MILLISECONDS);
                    SetEscortPaused(true);
                    events.ScheduleEvent(EVENT_RESUME_PATH, TIME_SHOP_STOP);
                    CheckCaravan();
                    break;
                // Finished south path
                case 193:
                    me->SummonCreature(NPC_SUPER_SELLER, -1905.5f, 2463.3f, 61.52f, 5.87f, TEMPSUMMON_TIMED_DESPAWN, TIME_SHOP_STOP + 15 * IN_MILLISECONDS);
                    SetEscortPaused(true);
                    events.ScheduleEvent(EVENT_RESUME_PATH, TIME_SHOP_STOP);
                    CheckCaravan();
                    break;
                // North -> South - hire
                case 77:
                    SetEscortPaused(true);
                    me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                    Talk(SAY_CARAVAN_HIRE);
                    events.ScheduleEvent(EVENT_WAIT_FOR_ASSIST, TIME_HIRE_STOP);
                    break;
                // Sout -> North - hire
                case 208:
                    SetEscortPaused(true);
                    if (Creature* rigger = ObjectAccessor::GetCreature(*me, summons[0]))
                    {
                        rigger->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
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
                    _playerGUID.Clear();
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
                    _playerGUID.Clear();
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
                            float o = (i * M_PI / 2) + (M_PI / 4);
                            float x = me->GetPositionX() + cos(o) * 15.0f;
                            float y = me->GetPositionY() + std::sin(o) * 15.0f;
                            if ((cr = me->SummonCreature((i % 2 == 0 ? NPC_KOLKAR_WAYLAYER : NPC_KOLKAR_AMBUSHER),
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
                            float o = i * 2 * M_PI / 3;
                            float x = me->GetPositionX() + cos(o) * 10.0f;
                            float y = me->GetPositionY() + std::sin(o) * 10.0f;
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
                    events.ScheduleEvent(EVENT_RESTART_ESCORT, 1s);
                    break;
            }
        }

        void UpdateEscortAI(uint32 diff) override
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
                        active->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                    break;
                case EVENT_RESTART_ESCORT:
                    CheckCaravan();
                    SetDespawnAtEnd(false);
                    Start(true, true, ObjectGuid::Empty, 0, false, false, true);
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

    NPC_TEXT_KODO                   = 4449, // MenuID 3650

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
            me->UpdateEntry(RAND(NPC_AGED_KODO, NPC_DYING_KODO, NPC_ANCIENT_KODO), nullptr, false);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetEntry() == NPC_SMEED && me->IsWithinDistInMap(who, 10.0f) && !me->HasAura(SPELL_KODO_KOMBO_GOSSIP))
            {
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();

                DoCast(me, SPELL_KODO_KOMBO_GOSSIP, true);
                if (Creature* smeed = who->ToCreature())
                    smeed->AI()->Talk(SAY_SMEED_HOME);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_KODO_KOMBO_ITEM)
            {
                if (!caster->HasAnyAuras(SPELL_KODO_KOMBO_PLAYER_BUFF, SPELL_KODO_KOMBO_DESPAWN_BUFF)
                        && (me->GetEntry() == NPC_AGED_KODO || me->GetEntry() == NPC_DYING_KODO || me->GetEntry() == NPC_ANCIENT_KODO))
                {
                    me->UpdateEntry(NPC_TAMED_KODO, nullptr, false);
                    EnterEvadeMode();
                    me->GetMotionMaster()->MoveFollow(caster, PET_FOLLOW_DIST, me->GetFollowAngle());

                    caster->CastSpell(caster, SPELL_KODO_KOMBO_PLAYER_BUFF, true);
                    DoCast(me, SPELL_KODO_KOMBO_DESPAWN_BUFF, true);
                }
            }
            else if (spell->Id == SPELL_KODO_KOMBO_GOSSIP)
            {
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->DespawnOrUnsummon(60000);
            }
        }
    };

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->HasAllAuras(SPELL_KODO_KOMBO_PLAYER_BUFF, SPELL_KODO_KOMBO_DESPAWN_BUFF))
        {
            player->TalkedToCreature(creature->GetEntry(), ObjectGuid::Empty);
            player->RemoveAurasDueToSpell(SPELL_KODO_KOMBO_PLAYER_BUFF);
        }

        SendGossipMenuFor(player, NPC_TEXT_KODO, creature->GetGUID());
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_aged_dying_ancient_kodoAI(creature);
    }
};

void AddSC_desolace()
{
    // Ours
    new npc_cork_gizelton();

    // Theirs
    new npc_aged_dying_ancient_kodo();
}
