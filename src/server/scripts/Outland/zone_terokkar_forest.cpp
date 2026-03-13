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
#include "GameObjectScript.h"
#include "Group.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"

enum fumping
{
    SPELL_SUMMON_SAND_GNOME1            = 39240,
    SPELL_SUMMON_SAND_GNOME3            = 39247,
    SPELL_SUMMON_MATURE_BONE_SIFTER1    = 39241,
    SPELL_SUMMON_MATURE_BONE_SIFTER3    = 39245,
    SPELL_SUMMON_HAISHULUD              = 39248,
};

class spell_q10930_big_bone_worm : public SpellScript
{
    PrepareSpellScript(spell_q10930_big_bone_worm);

    void SetDest(SpellDestination& dest)
    {
        Position const offset = { 0.5f, 0.5f, 5.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q10930_big_bone_worm::SetDest, EFFECT_1, TARGET_DEST_CASTER);
    }
};

class spell_q10930_big_bone_worm_aura : public AuraScript
{
    PrepareAuraScript(spell_q10930_big_bone_worm_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_HAISHULUD, SPELL_SUMMON_MATURE_BONE_SIFTER1, SPELL_SUMMON_MATURE_BONE_SIFTER3 });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        GetUnitOwner()->CastSpell(GetUnitOwner(), RAND(SPELL_SUMMON_HAISHULUD, SPELL_SUMMON_MATURE_BONE_SIFTER1, SPELL_SUMMON_MATURE_BONE_SIFTER3), true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_q10930_big_bone_worm_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_q10929_fumping : public SpellScript
{
    PrepareSpellScript(spell_q10929_fumping);

    void SetDest(SpellDestination& dest)
    {
        Position const offset = { 0.5f, 0.5f, 5.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q10929_fumping::SetDest, EFFECT_1, TARGET_DEST_CASTER);
    }
};

class spell_q10929_fumping_aura : public AuraScript
{
    PrepareAuraScript(spell_q10929_fumping_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_SAND_GNOME1, SPELL_SUMMON_SAND_GNOME3, SPELL_SUMMON_MATURE_BONE_SIFTER1, SPELL_SUMMON_MATURE_BONE_SIFTER3 });
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        GetUnitOwner()->CastSpell(GetUnitOwner(), RAND(SPELL_SUMMON_SAND_GNOME1, SPELL_SUMMON_SAND_GNOME3, SPELL_SUMMON_MATURE_BONE_SIFTER1, SPELL_SUMMON_MATURE_BONE_SIFTER3), true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_q10929_fumping_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum q10036Torgos
{
    NPC_TORGOS                  = 18707
};

class spell_q10036_torgos : public SpellScript
{
    PrepareSpellScript(spell_q10036_torgos);

    void HandleSendEvent(SpellEffIndex  /*effIndex*/)
    {
        if (Creature* torgos = GetCaster()->FindNearestCreature(NPC_TORGOS, 100.0f, true))
            torgos->GetAI()->AttackStart(GetCaster());
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_q10036_torgos::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

enum eQ10923EvilDrawsNear
{
    SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL1      = 39256,
    SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL2      = 39257,
    SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL_AURA  = 39259,

    NPC_AUCHENAI_DEATH_SPIRIT               = 21967
};

class spell_q10923_evil_draws_near_summon : public SpellScript
{
    PrepareSpellScript(spell_q10923_evil_draws_near_summon);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL_AURA });
    }

    void HandleSendEvent(SpellEffIndex  /*effIndex*/)
    {
        if (Creature* auchenai = GetCaster()->FindNearestCreature(NPC_AUCHENAI_DEATH_SPIRIT, 10.0f, true))
            auchenai->CastSpell(auchenai, SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL_AURA, true);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_q10923_evil_draws_near_summon::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

class spell_q10923_evil_draws_near_periodic_aura : public AuraScript
{
    PrepareAuraScript(spell_q10923_evil_draws_near_periodic_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL1, SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL2 });
    }

    void HandlePeriodic(AuraEffect const*  /*aurEff*/)
    {
        PreventDefaultAction();
        GetUnitOwner()->CastSpell(GetUnitOwner(), RAND(SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL1, SPELL_DUSTIN_UNDEAD_DRAGON_VISUAL2), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_q10923_evil_draws_near_periodic_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_q10923_evil_draws_near_visual : public SpellScript
{
    PrepareSpellScript(spell_q10923_evil_draws_near_visual);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        Position const offset = { 0.0f, 0.0f, 20.0f, 0.0f };
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q10923_evil_draws_near_visual::SetDest, EFFECT_0, TARGET_DEST_CASTER_RADIUS);
    }
};

class spell_q10898_skywing : public SpellScript
{
    PrepareSpellScript(spell_q10898_skywing);

    void SetDest(SpellDestination& dest)
    {
        // Adjust effect summon position
        Position const offset = { frand(-7.0f, 7.0f), frand(-7.0f, 7.0f), 11.0f, 0.0f };
        dest.Relocate(*GetCaster());
        dest.RelocateOffset(offset);
    }

    void Register() override
    {
        OnDestinationTargetSelect += SpellDestinationTargetSelectFn(spell_q10898_skywing::SetDest, EFFECT_0, TARGET_DEST_CASTER_RANDOM);
    }
};

/*######
## npc_unkor_the_ruthless
######*/

enum UnkorTheRuthless
{
    SAY_SUBMIT                      = 0,

    FACTION_HOSTILE                 = 45,
    QUEST_DONTKILLTHEFATONE         = 9889,

    SPELL_PULVERIZE                 = 2676
};

class npc_unkor_the_ruthless : public CreatureScript
{
public:
    npc_unkor_the_ruthless() : CreatureScript("npc_unkor_the_ruthless") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_unkor_the_ruthlessAI(creature);
    }

    struct npc_unkor_the_ruthlessAI : public ScriptedAI
    {
        npc_unkor_the_ruthlessAI(Creature* creature) : ScriptedAI(creature) { }

        bool CanDoQuest;
        uint32 UnkorUnfriendly_Timer;
        uint32 Pulverize_Timer;

        void Reset() override
        {
            CanDoQuest = false;
            UnkorUnfriendly_Timer = 0;
            Pulverize_Timer = 3000;
            me->SetStandState(UNIT_STAND_STATE_STAND);
            me->SetFaction(FACTION_HOSTILE);
        }

        void JustEngagedWith(Unit* /*who*/) override { }

        void DoNice()
        {
            Talk(SAY_SUBMIT);
            me->SetFaction(FACTION_FRIENDLY);
            me->SetStandState(UNIT_STAND_STATE_SIT);
            me->RemoveAllAuras();
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            UnkorUnfriendly_Timer = 60000;
        }

        void DamageTaken(Unit* done_by, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!done_by)
                return;

            Player* player = done_by->ToPlayer();
            if (player && me->HealthBelowPctDamaged(30, damage))
            {
                if (Group* group = player->GetGroup())
                {
                    for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
                    {
                        Player* groupie = itr->GetSource();
                        if (groupie && groupie->IsInMap(player) &&
                                groupie->GetQuestStatus(QUEST_DONTKILLTHEFATONE) == QUEST_STATUS_INCOMPLETE &&
                                groupie->GetReqKillOrCastCurrentCount(QUEST_DONTKILLTHEFATONE, 18260) == 10)
                        {
                            groupie->AreaExploredOrEventHappens(QUEST_DONTKILLTHEFATONE);
                            if (!CanDoQuest)
                                CanDoQuest = true;
                        }
                    }
                }
                else if (player->GetQuestStatus(QUEST_DONTKILLTHEFATONE) == QUEST_STATUS_INCOMPLETE &&
                         player->GetReqKillOrCastCurrentCount(QUEST_DONTKILLTHEFATONE, 18260) == 10)
                {
                    player->AreaExploredOrEventHappens(QUEST_DONTKILLTHEFATONE);
                    CanDoQuest = true;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (CanDoQuest)
            {
                if (!UnkorUnfriendly_Timer)
                {
                    //DoCast(me, SPELL_QUID9889);        //not using spell for now
                    DoNice();
                }
                else
                {
                    if (UnkorUnfriendly_Timer <= diff)
                    {
                        EnterEvadeMode();
                        return;
                    }
                    else UnkorUnfriendly_Timer -= diff;
                }
            }

            if (!UpdateVictim())
                return;

            if (Pulverize_Timer <= diff)
            {
                DoCast(me, SPELL_PULVERIZE);
                Pulverize_Timer = 9000;
            }
            else Pulverize_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_isla_starmane
######*/
enum IslaStarmaneData
{
    SAY_PROGRESS_1  = 0,
    SAY_PROGRESS_2  = 1,
    SAY_PROGRESS_3  = 2,
    SAY_PROGRESS_4  = 3,

    QUEST_EFTW_H    = 10052,
    QUEST_EFTW_A    = 10051,
    GO_CAGE         = 182794,
    SPELL_CAT       = 32447,

    EVENT_SPELL_WRATH               = 1,
    EVENT_SPELL_MOONFIRE            = 2,
    EVENT_SPELL_ENTANGLING_ROOTS    = 3,

    SPELL_WRATH                     = 9739,
    SPELL_MOONFIRE                  = 15798,
    SPELL_ENTANGLING_ROOTS          = 33844
};

class npc_isla_starmane : public CreatureScript
{
public:
    npc_isla_starmane() : CreatureScript("npc_isla_starmane") { }

    struct npc_isla_starmaneAI : public npc_escortAI
    {
        npc_isla_starmaneAI(Creature* creature) : npc_escortAI(creature) { }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 0:
                    if (GameObject* Cage = me->FindNearestGameObject(GO_CAGE, 10))
                        Cage->UseDoorOrButton();
                    break;
                case 2:
                    Talk(SAY_PROGRESS_1, player);
                    break;
                case 5:
                    Talk(SAY_PROGRESS_2, player);
                    break;
                case 6:
                    Talk(SAY_PROGRESS_3, player);
                    break;
                case 29:
                    Talk(SAY_PROGRESS_4, player);
                    if (player->GetTeamId() == TEAM_ALLIANCE)
                        player->GroupEventHappens(QUEST_EFTW_A, me);
                    else if (player->GetTeamId() == TEAM_HORDE)
                        player->GroupEventHappens(QUEST_EFTW_H, me);
                    me->SetInFront(player);
                    break;
                case 30:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_WAVE);
                    break;
                case 31:
                    DoCast(me, SPELL_CAT);
                    me->SetWalk(false);
                    break;
            }
        }

        void JustRespawned() override
        {
            me->SetImmuneToAll(true);
            npc_escortAI::JustRespawned();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = GetPlayerForEscort())
            {
                if (player->GetTeamId() == TEAM_ALLIANCE)
                    player->FailQuest(QUEST_EFTW_A);
                else if (player->GetTeamId() == TEAM_HORDE)
                    player->FailQuest(QUEST_EFTW_H);
            }
        }

        void JustEngagedWith(Unit*) override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_WRATH, 0ms);
            events.ScheduleEvent(EVENT_SPELL_MOONFIRE, 4s);
            events.ScheduleEvent(EVENT_SPELL_ENTANGLING_ROOTS, 10s);
        }

        void UpdateEscortAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_WRATH:
                    me->CastSpell(me->GetVictim(), SPELL_WRATH, false);
                    events.ScheduleEvent(EVENT_SPELL_WRATH, 3s);
                    break;
                case EVENT_SPELL_MOONFIRE:
                    me->CastSpell(me->GetVictim(), SPELL_MOONFIRE, false);
                    events.ScheduleEvent(EVENT_SPELL_MOONFIRE, 12s);
                    break;
                case EVENT_SPELL_ENTANGLING_ROOTS:
                    me->CastSpell(me->GetVictim(), SPELL_ENTANGLING_ROOTS, false);
                    events.ScheduleEvent(EVENT_SPELL_ENTANGLING_ROOTS, 20s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        EventMap events;
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_EFTW_H || quest->GetQuestId() == QUEST_EFTW_A)
        {
            creature->SetWalk(true);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, player->GetGUID());
            creature->SetFaction(FACTION_ESCORTEE_N_NEUTRAL_ACTIVE);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_isla_starmaneAI(creature);
    }
};

/*######
## go_skull_pile
######*/

enum SkullPile : uint32
{
    QUEST_ADVERSARIAL_BLOOD                     = 11885,

    GOSSIP_MENU_SKULL_PILE                      = 8660,
    GOSSIP_MENU_TEXT_SKULL_PILE                 = 10888,
    GOSSIP_MENU_TEXT_SKULL_PILE_QUEST           = 11057,

    GOSSIP_OPTION_SUMMON_GEZZARAK_THE_HUNTRESS  = 0,
    GOSSIP_OPTION_SUMMON_DARKSCREECHER_AKKARAI  = 1,
    GOSSIP_OPTION_SUMMON_KARROG                 = 2,
    GOSSIP_OPTION_SUMMON_VAKKIZ_THE_WINDRAGER   = 3,

    SPELL_SUMMON_GEZZARAK_THE_HUNTRESS          = 40632,
    SPELL_SUMMON_DARKSCREECHER_AKKARAI          = 40642,
    SPELL_SUMMON_KARROG                         = 40640,
    SPELL_SUMMON_VAKKIZ_THE_WINDRAGER           = 40644,
};

class go_skull_pile : public GameObjectScript
{
public:
    go_skull_pile() : GameObjectScript("go_skull_pile") { }

    bool OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 action) override
    {
        ClearGossipMenuFor(player);

        if (sender == GOSSIP_SENDER_MAIN)
        {
            SendActionMenu(player, go, action);
            CloseGossipMenuFor(player);
        }
        return true;
    }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if ((player->GetQuestStatus(QUEST_ADVERSARIAL_BLOOD) == QUEST_STATUS_INCOMPLETE) || player->GetQuestRewardStatus(QUEST_ADVERSARIAL_BLOOD))
        {
            AddGossipItemFor(player, GOSSIP_MENU_SKULL_PILE, GOSSIP_OPTION_SUMMON_GEZZARAK_THE_HUNTRESS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            AddGossipItemFor(player, GOSSIP_MENU_SKULL_PILE, GOSSIP_OPTION_SUMMON_DARKSCREECHER_AKKARAI, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            AddGossipItemFor(player, GOSSIP_MENU_SKULL_PILE, GOSSIP_OPTION_SUMMON_KARROG, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            AddGossipItemFor(player, GOSSIP_MENU_SKULL_PILE, GOSSIP_OPTION_SUMMON_VAKKIZ_THE_WINDRAGER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

            SendGossipMenuFor(player, GOSSIP_MENU_TEXT_SKULL_PILE_QUEST, go->GetGUID());
        }
        else
            SendGossipMenuFor(player, GOSSIP_MENU_TEXT_SKULL_PILE, go->GetGUID());

        return true;
    }

    void SendActionMenu(Player* player, GameObject* go, uint32 action)
    {
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                _result = player->CastSpell(player, SPELL_SUMMON_GEZZARAK_THE_HUNTRESS, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                _result = player->CastSpell(player, SPELL_SUMMON_DARKSCREECHER_AKKARAI, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                _result = player->CastSpell(player, SPELL_SUMMON_KARROG, false);
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                _result = player->CastSpell(player, SPELL_SUMMON_VAKKIZ_THE_WINDRAGER, false);
                break;
            default:
                _result = SPELL_CAST_OK;
                break;
        }
        if (_result == SPELL_CAST_OK)
        {
            go->DespawnOrUnsummon();
        }
    }
private:
    SpellCastResult _result;
};

/*######
## go_ancient_skull_pile
######*/

enum AncientSkullPile
{
    ITEM_TIME_LOST_OFFERING = 32720,
    SPELL_SUMMON_TEROKK     = 41004,

    GOSSIP_MENU_ANCIENT_SKULL_PILE        = 8687,
    GOSSIP_MENU_TEXT_ANCIENT_SKULL_PILE   = 11058
};

class go_ancient_skull_pile : public GameObjectScript
{
public:
    go_ancient_skull_pile() : GameObjectScript("go_ancient_skull_pile") {}

    bool OnGossipSelect(Player* player, GameObject* go, uint32 sender, uint32 /*action*/) override
    {
        ClearGossipMenuFor(player);

        if (sender == GOSSIP_SENDER_MAIN)
        {
            CloseGossipMenuFor(player);
            if (player->HasItemCount(ITEM_TIME_LOST_OFFERING, 1))
                go->DespawnOrUnsummon();
            player->CastSpell(player, SPELL_SUMMON_TEROKK);
        }
        return true;
    }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        AddGossipItemFor(player, GOSSIP_MENU_ANCIENT_SKULL_PILE, 0, GOSSIP_SENDER_MAIN, 0);
        SendGossipMenuFor(player, GOSSIP_MENU_TEXT_ANCIENT_SKULL_PILE, go->GetGUID());
        return true;
    }
};

/*######
## npc_slim
######*/

enum Slim
{
    FACTION_CONSORTIUM  = 933
};

class npc_slim : public CreatureScript
{
public:
    npc_slim() : CreatureScript("npc_slim") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsVendor() && player->GetReputationRank(FACTION_CONSORTIUM) >= REP_FRIENDLY)
        {
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
            SendGossipMenuFor(player, 9896, creature->GetGUID());
        }
        else
            SendGossipMenuFor(player, 9895, creature->GetGUID());

        return true;
    }
};

void AddSC_terokkar_forest()
{
    RegisterSpellAndAuraScriptPair(spell_q10930_big_bone_worm, spell_q10930_big_bone_worm_aura);
    RegisterSpellAndAuraScriptPair(spell_q10929_fumping, spell_q10929_fumping_aura);
    RegisterSpellScript(spell_q10036_torgos);
    RegisterSpellScript(spell_q10923_evil_draws_near_summon);
    RegisterSpellScript(spell_q10923_evil_draws_near_periodic_aura);
    RegisterSpellScript(spell_q10923_evil_draws_near_visual);
    RegisterSpellScript(spell_q10898_skywing);
    new npc_unkor_the_ruthless();
    new npc_isla_starmane();
    new go_skull_pile();
    new go_ancient_skull_pile();
    new npc_slim();
}
