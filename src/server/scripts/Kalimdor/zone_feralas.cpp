/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Feralas
SD%Complete: 100
SDComment: Quest support: 3520, 2767, Special vendor Gregan Brewspewer
SDCategory: Feralas
EndScriptData */

#include "Group.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SpellScript.h"

/*######
## npc_oox22fe
######*/

enum OOX
{
    SAY_OOX_START           = 0,
    SAY_OOX_AGGRO           = 1,
    SAY_OOX_AMBUSH          = 2,
    SAY_OOX_END             = 3,

    NPC_YETI                = 7848,
    NPC_GORILLA             = 5260,
    NPC_WOODPAW_REAVER      = 5255,
    NPC_WOODPAW_BRUTE       = 5253,
    NPC_WOODPAW_ALPHA       = 5258,
    NPC_WOODPAW_MYSTIC      = 5254,

    QUEST_RESCUE_OOX22FE    = 2767,
    FACTION_ESCORTEE_A      = 774,
    FACTION_ESCORTEE_H      = 775
};

class npc_oox22fe : public CreatureScript
{
public:
    npc_oox22fe() : CreatureScript("npc_oox22fe") { }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_RESCUE_OOX22FE)
        {
            creature->AI()->Talk(SAY_OOX_START);
            //change that the npc is not lying dead on the ground
            creature->SetStandState(UNIT_STAND_STATE_STAND);

            if (player->GetTeamId() == TEAM_ALLIANCE)
                creature->setFaction(FACTION_ESCORTEE_A);

            if (player->GetTeamId() == TEAM_HORDE)
                creature->setFaction(FACTION_ESCORTEE_H);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_oox22fe::npc_oox22feAI, creature->AI()))
                pEscortAI->Start(true, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_oox22feAI(creature);
    }

    struct npc_oox22feAI : public npc_escortAI
    {
        npc_oox22feAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId) override
        {
            switch (waypointId)
            {
                // First Ambush(3 Yetis)
                case 11:
                    Talk(SAY_OOX_AMBUSH);
                    me->SummonCreature(NPC_YETI, -4841.01f, 1593.91f, 73.42f, 3.98f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_YETI, -4837.61f, 1568.58f, 78.21f, 3.13f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_YETI, -4841.89f, 1569.95f, 76.53f, 0.68f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    break;
                //Second Ambush(3 Gorillas)
                case 21:
                    Talk(SAY_OOX_AMBUSH);
                    me->SummonCreature(NPC_GORILLA, -4652.76f, 1956.69f, 67.99f, 3.74f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_GORILLA, -4654.73f, 1959.71f, 47.66f, 3.78f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_GORILLA, -4657.01f, 1963.19f, 67.48f, 3.84f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    break;
                //Third Ambush(4 Gnolls)
                case 30:
                    Talk(SAY_OOX_AMBUSH);
                    me->SummonCreature(NPC_WOODPAW_REAVER, -4425.14f, 2075.87f, 47.77f, 3.77f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_WOODPAW_BRUTE, -4426.68f, 2077.98f, 47.57f, 3.77f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_WOODPAW_MYSTIC, -4428.33f, 2080.24f, 47.43f, 3.87f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    me->SummonCreature(NPC_WOODPAW_ALPHA, -4430.04f, 2075.54f, 46.83f, 3.81f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10000);
                    break;
                case 37:
                    Talk(SAY_OOX_END);
                    // Award quest credit
                    if (Player* player = GetPlayerForEscort())
                        player->GroupEventHappens(QUEST_RESCUE_OOX22FE, me);
                    break;
            }
        }

        void Reset() override
        {
            if (!HasEscortState(STATE_ESCORT_ESCORTING))
                me->SetStandState(UNIT_STAND_STATE_DEAD);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            //For an small probability the npc says something when he get aggro
            if (urand(0, 9) > 7)
                Talk(SAY_OOX_AGGRO);
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->AI()->AttackStart(me);
        }
    };
};

enum GordunniTrap
{
    GO_GORDUNNI_DIRT_MOUND = 144064,
};

class spell_gordunni_trap : public SpellScriptLoader
{
public:
    spell_gordunni_trap() : SpellScriptLoader("spell_gordunni_trap") { }

    class spell_gordunni_trap_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_gordunni_trap_SpellScript);

        void HandleDummy()
        {
            if (Unit* caster = GetCaster())
                if (GameObject* chest = caster->SummonGameObject(GO_GORDUNNI_DIRT_MOUND, caster->GetPositionX(), caster->GetPositionY(), caster->GetPositionZ(), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0))
                {
                    chest->SetSpellId(GetSpellInfo()->Id);
                    caster->RemoveGameObject(chest, false);
                }
        }

        void Register() override
        {
            OnCast += SpellCastFn(spell_gordunni_trap_SpellScript::HandleDummy);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_gordunni_trap_SpellScript();
    }
};

enum WanderingShay
{
    QUEST_WANDERING_SHAY    = 2845,

    SPELL_SHAY_BELL         = 11402,

    NPC_ROCKBITER           = 7765,

    TALK_0                  = 0,
    TALK_1                  = 1,
    TALK_2                  = 2,
    TALK_3                  = 3,
    TALK_4                  = 4,

    EVENT_WANDERING_START   = 1,
    EVENT_WANDERING_TALK    = 2,
    EVENT_WANDERING_RANDOM  = 3,
    EVENT_FINAL_TALK        = 4,
    EVENT_CHECK_FOLLOWER    = 5
};

class npc_shay_leafrunner : public CreatureScript
{
public:
    npc_shay_leafrunner() : CreatureScript("npc_shay_leafrunner") {}

    struct npc_shay_leafrunnerAI : public ScriptedAI
    {
        npc_shay_leafrunnerAI(Creature* creature) : ScriptedAI(creature) {}

        void InitializeAI() override
        {
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
            me->RestoreFaction();

            _events.Reset();
            _playerGUID.Clear();
            _rockbiterGUID.Clear();
        }

        void JustRespawned() override
        {
            InitializeAI();
            me->SetHomePosition(me->GetPosition());
        }

        void MoveInLineOfSight(Unit* target) override
        {
            if (!_playerGUID || target->GetEntry() != NPC_ROCKBITER || !me->IsInRange(target, 0.f, 10.f))
            {
                if (!me->IsInCombat() && !me->GetVictim())
                {
                    if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
                    {
                        if (Unit* victim = player->GetVictim())
                        {
                            if (me->CanStartAttack(victim))
                            {
                                AttackStart(victim);
                            }
                        }
                    }
                }

                return;
            }

            _rockbiterGUID = target->GetGUID();

            Talk(TALK_4, target);

            me->SetControlled(true, UNIT_STATE_ROOT);

            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
            {
                player->GroupEventHappens(QUEST_WANDERING_SHAY, me);
            }

            _events.CancelEvent(EVENT_WANDERING_START);
            _events.ScheduleEvent(EVENT_FINAL_TALK, 5 * IN_MILLISECONDS);
        }

        void EnterEvadeMode() override
        {
            _EnterEvadeMode();

            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
            {
                me->GetMotionMaster()->MoveFollow(player, 3.f, M_PI);
            }
        }

        void FailQuest(Player* player, bool despawn)
        {
            if (player)
            {
                player->FailQuest(QUEST_WANDERING_SHAY);

                if (Group* group = player->GetGroup())
                {
                    for (GroupReference* groupRef = group->GetFirstMember(); groupRef != nullptr; groupRef = groupRef->next())
                    {
                        if (Player* member = groupRef->GetSource())
                        {
                            if (member->GetGUID() != player->GetGUID())
                            {
                                member->FailQuest(QUEST_WANDERING_SHAY);
                            }
                        }
                    }
                }
            }

            if (despawn)
            {
                me->DespawnOrUnsummon(1);
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID))
            {
                FailQuest(player, false);
            }
        }

        void sQuestAccept(Player* player, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_WANDERING_SHAY)
            {
                _playerGUID = player->GetGUID();

                Talk(TALK_0, player);

                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                me->setFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);
                me->GetMotionMaster()->MoveFollow(player, 3.f, M_PI);

                _events.ScheduleEvent(EVENT_WANDERING_START, urand(40 * IN_MILLISECONDS, 70 * IN_MILLISECONDS));
                _events.ScheduleEvent(EVENT_CHECK_FOLLOWER, 30 * IN_MILLISECONDS);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SHAY_BELL)
            {
                _playerGUID = caster->GetGUID();

                Talk(TALK_1, caster);

                me->GetMotionMaster()->MoveIdle();
                me->GetMotionMaster()->MoveFollow(caster, 3.f, M_PI);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (UpdateVictim())
            {
                DoMeleeAttackIfReady();
                return;
            }

            _events.Update(diff);
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_WANDERING_START:
                    {
                        Position pos = me->GetFirstCollisionPosition(15.f, rand_norm() * static_cast<float>(2 * M_PI));
                        me->GetMotionMaster()->MovePoint(0, pos);
                        Talk(TALK_2);
                        _events.ScheduleEvent(EVENT_WANDERING_START, urand(60 * IN_MILLISECONDS, 70 * IN_MILLISECONDS));
                        _events.ScheduleEvent(EVENT_WANDERING_TALK, 3 * IN_MILLISECONDS);
                        _events.ScheduleEvent(EVENT_WANDERING_RANDOM, 8 * IN_MILLISECONDS);
                        break;
                    }
                    case EVENT_WANDERING_TALK:
                        Talk(TALK_3);
                        break;
                    case EVENT_WANDERING_RANDOM:
                        me->SetHomePosition(me->GetPosition());
                        me->GetMotionMaster()->MoveRandom(15.f);
                        break;
                    case EVENT_FINAL_TALK:
                        if (Creature* robckbiter = ObjectAccessor::GetCreature(*me, _rockbiterGUID))
                        {
                            Talk(TALK_0, robckbiter);
                        }
                        me->DespawnOrUnsummon(10 * IN_MILLISECONDS);
                        break;
                    case EVENT_CHECK_FOLLOWER:
                    {
                        Player* player = ObjectAccessor::GetPlayer(*me, _playerGUID);
                        if (!player || !player->IsAlive() || !me->IsInRange(player, 0.f, 50.f))
                        {
                            FailQuest(player, true);
                        }
                        break;
                    }
                    default:
                        break;
                }
            }
        }

    private:
        ObjectGuid _playerGUID;
        ObjectGuid _rockbiterGUID;
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_shay_leafrunnerAI(creature);
    }
};

/*######
## AddSC
######*/

void AddSC_feralas()
{
    new npc_oox22fe();
    new spell_gordunni_trap();
    new npc_shay_leafrunner();
}
