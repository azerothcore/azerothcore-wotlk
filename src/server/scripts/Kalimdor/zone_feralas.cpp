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
SDName: Feralas
SD%Complete: 100
SDComment: Quest support: 3520 Special vendor Gregan Brewspewer
SDCategory: Feralas
EndScriptData */

#include "Group.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"

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
            me->SetUnitFlag(UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
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
                me->RemoveUnitFlag(UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                me->SetFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);
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
                            robckbiter->AI()->Talk(TALK_0, me);
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

void AddSC_feralas()
{
    new spell_gordunni_trap();
    new npc_shay_leafrunner();
}
