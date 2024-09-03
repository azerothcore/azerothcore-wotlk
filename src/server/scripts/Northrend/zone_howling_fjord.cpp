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

#include "CreatureScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"

// Ours
class npc_attracted_reef_bull : public CreatureScript
{
public:
    npc_attracted_reef_bull() : CreatureScript("npc_attracted_reef_bull") { }

    struct npc_attracted_reef_bullAI : public NullCreatureAI
    {
        npc_attracted_reef_bullAI(Creature* creature) : NullCreatureAI(creature)
        {
            me->SetDisableGravity(true);
            if (me->IsSummon())
                if (Unit* owner = me->ToTempSummon()->GetSummonerUnit())
                    me->GetMotionMaster()->MovePoint(0, *owner);
        }

        void MovementInform(uint32  /*type*/, uint32  /*id*/) override
        {
            if (Creature* cow = me->FindNearestCreature(24797, 5.0f, true))
            {
                me->CastSpell(me, 44460, true);
                me->DespawnOrUnsummon(10000);
                cow->CastSpell(cow, 44460, true);
                cow->DespawnOrUnsummon(10000);
                if (me->IsSummon())
                    if (Unit* owner = me->ToTempSummon()->GetSummonerUnit())
                        owner->CastSpell(owner, 44463, true);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (caster && spellInfo->Id == 44454)
                me->GetMotionMaster()->MovePoint(0, *caster);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_attracted_reef_bullAI(creature);
    }
};

// The cleansing
enum TurmoilTexts
{
    SAY_TURMOIL_0                = 0,
    SAY_TURMOIL_1                = 1,
    SAY_TURMOIL_HALF_HP          = 2,
    SAY_TURMOIL_DEATH            = 3,
};

class npc_your_inner_turmoil : public CreatureScript
{
public:
    npc_your_inner_turmoil() : CreatureScript("npc_your_inner_turmoil") { }

    struct npc_your_inner_turmoilAI : public ScriptedAI
    {
        npc_your_inner_turmoilAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 timer;
        short phase;
        bool health50;

        void Reset() override
        {
            timer = 0;
            phase = 0;
            health50 = false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (timer >= 6000 && phase < 2)
            {
                phase++;
                setphase(phase);
                timer = 0;
            }

            timer += diff;

            DoMeleeAttackIfReady();
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType  /*damagetype*/, SpellSchoolMask  /*damageSchoolMask*/) override
        {
            if (HealthBelowPct(50) && !health50)
            {
                if (TempSummon const* tempSummon = me->ToTempSummon())
                {
                    if (WorldObject* summoner = tempSummon->GetSummonerUnit())
                    {
                        Talk(SAY_TURMOIL_HALF_HP, summoner);
                    }
                }

                health50 = true;
            }
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (TempSummon const* tempSummon = me->ToTempSummon())
            {
                if (WorldObject* summoner = tempSummon->GetSummonerUnit())
                {
                    Talk(SAY_TURMOIL_DEATH, summoner);
                }
            }
        }

        void setphase(short newPhase)
        {
            Unit* summoner = me->ToTempSummon() ? me->ToTempSummon()->GetSummonerUnit() : nullptr;
            if (!summoner || !summoner->IsPlayer())
                return;

            switch (newPhase)
            {
                case 1:
                    Talk(SAY_TURMOIL_0, summoner->ToPlayer());
                    return;
                case 2:
                {
                    Talk(SAY_TURMOIL_1, summoner->ToPlayer());
                    me->SetLevel(summoner->GetLevel());
                    me->SetFaction(FACTION_MONSTER);
                    if (me->GetExactDist(summoner) < 50.0f)
                    {
                        me->UpdatePosition(summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ(), 0.0f, true);
                        summoner->CastSpell(me, 50218, true); // clone caster
                        AttackStart(summoner);
                    }
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_your_inner_turmoilAI(creature);
    }
};

// Theirs
/*######
## npc_apothecary_hanes
######*/
enum Entries
{
    NPC_APOTHECARY_HANES         = 23784,
    NPC_HANES_FIRE_TRIGGER       = 23968,
    QUEST_TRAIL_OF_FIRE          = 11241,
    SPELL_COSMETIC_LOW_POLY_FIRE = 56274,
    SPELL_HEALING_POTION         = 17534
};

class npc_apothecary_hanes : public CreatureScript
{
public:
    npc_apothecary_hanes() : CreatureScript("npc_apothecary_hanes") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_TRAIL_OF_FIRE)
        {
            creature->SetFaction(player->GetTeamId() == TEAM_ALLIANCE ? FACTION_ESCORTEE_A_PASSIVE : FACTION_ESCORTEE_H_PASSIVE);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
        }
        return true;
    }

    struct npc_Apothecary_HanesAI : public npc_escortAI
    {
        npc_Apothecary_HanesAI(Creature* creature) : npc_escortAI(creature) { }
        uint32 PotTimer;

        void Reset() override
        {
            SetDespawnAtFar(false);
            PotTimer = 10000; //10 sec cooldown on potion
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_TRAIL_OF_FIRE);
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (HealthBelowPct(75))
            {
                if (PotTimer <= diff)
                {
                    DoCast(me, SPELL_HEALING_POTION, true);
                    PotTimer = 10000;
                }
                else PotTimer -= diff;
            }
            if (GetAttack() && UpdateVictim())
                DoMeleeAttackIfReady();
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    me->SetReactState(REACT_AGGRESSIVE);
                    SetRun(true);
                    break;
                case 23:
                    player->GroupEventHappens(QUEST_TRAIL_OF_FIRE, me);
                    me->DespawnOrUnsummon();
                    break;
                case 5:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(false);
                    break;
                case 6:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(true);
                    break;
                case 8:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(false);
                    break;
                case 9:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    break;
                case 10:
                    SetRun(true);
                    break;
                case 13:
                    SetRun(false);
                    break;
                case 14:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    SetRun(true);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_Apothecary_HanesAI(creature);
    }
};

/*######
## npc_plaguehound_tracker
######*/

class npc_plaguehound_tracker : public CreatureScript
{
public:
    npc_plaguehound_tracker() : CreatureScript("npc_plaguehound_tracker") { }

    struct npc_plaguehound_trackerAI : public npc_escortAI
    {
        npc_plaguehound_trackerAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() override
        {
            ObjectGuid summonerGUID;
            if (me->IsSummon())
                if (Unit* summoner = me->ToTempSummon()->GetSummonerUnit())
                    if (summoner->IsPlayer())
                        summonerGUID = summoner->GetGUID();

            if (!summonerGUID)
                return;

            me->SetWalk(true);
            Start(false, false, summonerGUID);
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (waypointId != 26)
                return;

            me->DespawnOrUnsummon();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_plaguehound_trackerAI(creature);
    }
};

/*######
## npc_razael_and_lyana
######*/

enum Razael
{
    QUEST_REPORTS_FROM_THE_FIELD = 11221,
    NPC_RAZAEL = 23998,
    NPC_LYANA = 23778,
    GOSSIP_TEXTID_RAZAEL1 = 11562,
    GOSSIP_TEXTID_RAZAEL2 = 11564,
    GOSSIP_TEXTID_LYANA1 = 11586,
    GOSSIP_TEXTID_LYANA2 = 11588
};

class npc_razael_and_lyana : public CreatureScript
{
public:
    npc_razael_and_lyana() : CreatureScript("npc_razael_and_lyana") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_REPORTS_FROM_THE_FIELD) == QUEST_STATUS_INCOMPLETE)
            switch (creature->GetEntry())
            {
                case NPC_RAZAEL:
                    if (!player->GetReqKillOrCastCurrentCount(QUEST_REPORTS_FROM_THE_FIELD, NPC_RAZAEL))
                    {
                        AddGossipItemFor(player, 8870, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                        SendGossipMenuFor(player, GOSSIP_TEXTID_RAZAEL1, creature->GetGUID());
                        return true;
                    }
                    break;
                case NPC_LYANA:
                    if (!player->GetReqKillOrCastCurrentCount(QUEST_REPORTS_FROM_THE_FIELD, NPC_LYANA))
                    {
                        AddGossipItemFor(player, 8879, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                        SendGossipMenuFor(player, GOSSIP_TEXTID_LYANA1, creature->GetGUID());
                        return true;
                    }
                    break;
            }
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                SendGossipMenuFor(player, GOSSIP_TEXTID_RAZAEL2, creature->GetGUID());
                player->TalkedToCreature(NPC_RAZAEL, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                SendGossipMenuFor(player, GOSSIP_TEXTID_LYANA2, creature->GetGUID());
                player->TalkedToCreature(NPC_LYANA, creature->GetGUID());
                break;
        }
        return true;
    }
};

void AddSC_howling_fjord()
{
    // Ours
    new npc_attracted_reef_bull();
    new npc_your_inner_turmoil();

    // Theirs
    new npc_apothecary_hanes();
    new npc_plaguehound_tracker();
    new npc_razael_and_lyana();
}
