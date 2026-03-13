/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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
#include "SpellScript.h"

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
                me->DespawnOrUnsummon(10s);
                cow->CastSpell(cow, 44460, true);
                cow->DespawnOrUnsummon(10s);
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
            creature->SetWalk(true);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, player->GetGUID());
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
                    me->SetWalk(false);
                    break;
                case 23:
                    player->GroupEventHappens(QUEST_TRAIL_OF_FIRE, me);
                    me->DespawnOrUnsummon();
                    break;
                case 5:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(true);
                    break;
                case 6:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(false);
                    break;
                case 8:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(true);
                    break;
                case 9:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    break;
                case 10:
                    me->SetWalk(false);
                    break;
                case 13:
                    me->SetWalk(true);
                    break;
                case 14:
                    if (Unit* Trigger = me->FindNearestCreature(NPC_HANES_FIRE_TRIGGER, 10.0f))
                        Trigger->CastSpell(Trigger, SPELL_COSMETIC_LOW_POLY_FIRE, false);
                    me->SetWalk(false);
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
            Start(false, summonerGUID);
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

enum RodinLightningSpells
{
    SPELL_RODIN_LIGHTNING_START = 44787,
    SPELL_RODIN_LIGHTNING_END   = 44791,

    NPC_RODIN                   = 24876
};

struct npc_rodin_lightning_enabler : public ScriptedAI
{
    npc_rodin_lightning_enabler(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        _scheduler.Schedule(1s, [this](TaskContext context)
        {
            if (Creature* rodin = me->FindNearestCreature(NPC_RODIN, 10.0f))
                DoCast(rodin, urand(SPELL_RODIN_LIGHTNING_START, SPELL_RODIN_LIGHTNING_END));

            context.Repeat(2s, 8s);
        });
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        _scheduler.Update();
    }

private:
    TaskScheduler _scheduler;
};

enum HawkHunting
{
    SPELL_HAWK_HUNTING_ITEM = 44408
};

// 44407 - Spell hawk Hunting
class spell_hawk_hunting : public SpellScript
{
    PrepareSpellScript(spell_hawk_hunting);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HAWK_HUNTING_ITEM });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        if (!GetCaster())
            return;

        GetCaster()->CastSpell(GetCaster(), SPELL_HAWK_HUNTING_ITEM, true);
        GetHitUnit()->ToCreature()->DespawnOrUnsummon();
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hawk_hunting::HandleScriptEffect, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Quest 11317, 11322: The Cleansing
######*/

enum TheCleansing
{
    SPELL_CLEANSING_SOUL            = 43351,
    SPELL_SUMMON_INNER_TURMOIL      = 50167,
    SPELL_RECENT_MEDITATION         = 61720,
    SPELL_MIRROR_IMAGE_AURA         = 50218,

    QUEST_THE_CLEANSING_H           = 11317,
    QUEST_THE_CLEANSING_A           = 11322
};

// 43365 - The Cleansing: Shrine Cast
class spell_the_cleansing_shrine_cast : public SpellScript
{
    PrepareSpellScript(spell_the_cleansing_shrine_cast);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RECENT_MEDITATION, SPELL_CLEANSING_SOUL }) &&
            sObjectMgr->GetQuestTemplate(QUEST_THE_CLEANSING_H) &&
            sObjectMgr->GetQuestTemplate(QUEST_THE_CLEANSING_A);
    }

    SpellCastResult CheckCast()
    {
        // Error is correct for quest check but may be not correct for aura and this may be a wrong place to send error
        if (Player* target = GetExplTargetUnit()->ToPlayer())
        {
            if (target->HasAura(SPELL_RECENT_MEDITATION) || (!(target->GetQuestStatus(QUEST_THE_CLEANSING_H) == QUEST_STATUS_INCOMPLETE ||
                target->GetQuestStatus(QUEST_THE_CLEANSING_A) == QUEST_STATUS_INCOMPLETE)))
            {
                Spell::SendCastResult(target, GetSpellInfo(), 0, SPELL_FAILED_FIZZLE);
                return SPELL_FAILED_FIZZLE;
            }
        }
        return SPELL_CAST_OK;
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_CLEANSING_SOUL, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_the_cleansing_shrine_cast::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_the_cleansing_shrine_cast::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 43351 - Cleansing Soul
class spell_the_cleansing_cleansing_soul : public AuraScript
{
    PrepareAuraScript(spell_the_cleansing_cleansing_soul);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_INNER_TURMOIL, SPELL_RECENT_MEDITATION });
    }

    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->SetStandState(UNIT_STAND_STATE_SIT);
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        target->SetStandState(UNIT_STAND_STATE_STAND);
        target->CastSpell(target, SPELL_SUMMON_INNER_TURMOIL, true);
        target->CastSpell(target, SPELL_RECENT_MEDITATION, true);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_the_cleansing_cleansing_soul::AfterApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_the_cleansing_cleansing_soul::AfterRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 50217 - The Cleansing: Script Effect Player Cast Mirror Image
class spell_the_cleansing_mirror_image_script_effect : public SpellScript
{
    PrepareSpellScript(spell_the_cleansing_mirror_image_script_effect);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MIRROR_IMAGE_AURA });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_MIRROR_IMAGE_AURA, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_cleansing_mirror_image_script_effect::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 50238 - The Cleansing: Your Inner Turmoil's On Death Cast on Master
class spell_the_cleansing_on_death_cast_on_master : public SpellScript
{
    PrepareSpellScript(spell_the_cleansing_on_death_cast_on_master);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ uint32(spellInfo->GetEffect(EFFECT_0).CalcValue()) });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (TempSummon* casterSummon = caster->ToTempSummon())
                if (Unit* summoner = casterSummon->GetSummonerUnit())
                    summoner->CastSpell(summoner, GetSpellInfo()->Effects[EFFECT_0].CalcValue(), true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_the_cleansing_on_death_cast_on_master::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_howling_fjord()
{
    new npc_attracted_reef_bull();
    new npc_apothecary_hanes();
    new npc_plaguehound_tracker();
    new npc_razael_and_lyana();
    RegisterCreatureAI(npc_rodin_lightning_enabler);
    RegisterSpellScript(spell_hawk_hunting);
    RegisterSpellScript(spell_the_cleansing_shrine_cast);
    RegisterSpellScript(spell_the_cleansing_cleansing_soul);
    RegisterSpellScript(spell_the_cleansing_mirror_image_script_effect);
    RegisterSpellScript(spell_the_cleansing_on_death_cast_on_master);
}
