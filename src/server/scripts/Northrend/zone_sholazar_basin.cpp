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

#include "CombatAI.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "WaypointMgr.h"

enum songOfWindandWater
{
    NPC_SOWAW_WATER_ELEMENTAL           = 28999,
    NPC_SOWAW_WIND_ELEMENTAL            = 28985,
    NPC_SOWAW_WIND_MODEL                = 14516,
    NPC_SOWAW_WATER_MODEL               = 20076,
};

class spell_q12726_song_of_wind_and_water : public SpellScript
{
    PrepareSpellScript(spell_q12726_song_of_wind_and_water);

    void HandleHealPct(SpellEffIndex /*effIndex*/)
    {
        if (Creature* cr = GetHitCreature())
        {
            //cr->UpdateEntry((cr->GetEntry() == NPC_SOWAW_WATER_ELEMENTAL ? NPC_SOWAW_WIND_ELEMENTAL : NPC_SOWAW_WATER_ELEMENTAL));
            cr->SetDisplayId(cr->GetDisplayId() == NPC_SOWAW_WATER_MODEL ? NPC_SOWAW_WIND_MODEL : NPC_SOWAW_WATER_MODEL);
            if (Player* player = cr->GetCharmerOrOwnerPlayerOrPlayerItself())
            {
                CreatureTemplate const* ct = sObjectMgr->GetCreatureTemplate(cr->GetDisplayId() == NPC_SOWAW_WIND_MODEL ? NPC_SOWAW_WIND_ELEMENTAL : NPC_SOWAW_WATER_ELEMENTAL);
                for (uint8 i = 0; i < MAX_CREATURE_SPELLS; ++i)
                    cr->m_spells[i] = ct->spells[i];

                player->VehicleSpellInitialize();
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12726_song_of_wind_and_water::HandleHealPct, EFFECT_2, SPELL_EFFECT_HEAL_PCT);
    }
};

/******
quest Still At It (12644)
******/

enum StillAtIt
{
    NPC_MANUS                   = 28566,
    NPC_WANTS_BANANAS           = 28537,

    QUEST_STILL_AT_IT           = 12644,
    GOSSIP_MANUS_MENU           = 9713,

    SAY_MANUS_START             = 0,
    SAY_MANUS_ORANGE            = 1,
    SAY_MANUS_PAPAYA            = 2,
    SAY_MANUS_BANANA            = 3,
    SAY_MANUS_PRESSUE           = 4,
    SAY_MANUS_HEAT              = 5,
    SAY_MANUS_WELL_DONE         = 6,
    SAY_MANUS_FAILED            = 7,
    SAY_MANUS_END               = 8,
};

class npc_still_at_it_trigger : public CreatureScript
{
public:
    npc_still_at_it_trigger() : CreatureScript("npc_still_at_it_trigger") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_still_at_it_triggerAI(pCreature);
    }

    struct npc_still_at_it_triggerAI : public NullCreatureAI
    {
        bool running;
        bool success;
        ObjectGuid playerGUID;
        ObjectGuid thunderbrewGUID;
        int32 tensecstimer;
        int32 timer;
        uint8 stepcount;
        uint8 currentstep;
        uint8 expectedaction;
        uint8 playeraction;

        npc_still_at_it_triggerAI(Creature* pCreature) : NullCreatureAI(pCreature) {}

        Creature* GetManus() {return ObjectAccessor::GetCreature(*me, thunderbrewGUID);}

        void Reset() override
        {
            running = false;
            success = false;
            playerGUID.Clear();
            thunderbrewGUID.Clear();
            tensecstimer = 0;
            timer = 0;
            stepcount = 0;
            currentstep = 0;
            expectedaction = 0;
            playeraction = 0;
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }

        void Start()
        {
            timer = 5000;
            running = true;
            stepcount = urand(5, 10);
            GetManus()->AI()->Talk(SAY_MANUS_START);
        }

        void CheckAction(uint8 a, ObjectGuid guid)
        {
            if (guid != playerGUID)
                return;

            if (a == expectedaction)
            {
                currentstep++;

                if (Creature* th = ObjectAccessor::GetCreature(*me, thunderbrewGUID))
                    th->HandleEmoteCommand(EMOTE_ONESHOT_CHEER_NO_SHEATHE);

                GetManus()->AI()->Talk(SAY_MANUS_WELL_DONE);

                if (currentstep >= stepcount)
                {
                    GetManus()->AI()->Talk(SAY_MANUS_WELL_DONE);
                    success = true;
                    timer = 3000;
                }
                else
                {
                    expectedaction = 0;
                    timer = 3000;
                }
            }
            else
            {
                GetManus()->AI()->Talk(SAY_MANUS_FAILED);
                Reset();
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override // for banana(51932), orange(51931), papaya(51933)
        {
            if (running)
            {
                uint8 a = 0;
                switch (spellInfo->Id)
                {
                    case 51931:
                        a = 4;
                        break;
                    case 51932:
                        a = 3;
                        break;
                    case 51933:
                        a = 5;
                        break;
                }

                CheckAction(a, caster->GetGUID());
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (running)
            {
                if (timer)
                {
                    timer -= diff;
                    if (timer < 0)
                        timer = 0;
                }
                else if (success)
                {
                    GetManus()->AI()->Talk(SAY_MANUS_END);
                    me->SummonGameObject(190643, 5546.55f, 5768.0f, -78.03f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
                    Reset();
                }
                else if (expectedaction != 0) // didn't make it in 10 seconds
                {
                    GetManus()->AI()->Talk(SAY_MANUS_FAILED);
                    Reset();
                }
                else // it's time to rand next move
                {
                    expectedaction = urand(1, 5);
                    switch (expectedaction)
                    {
                        case 1:
                            GetManus()->AI()->Talk(SAY_MANUS_PRESSUE);
                            break;
                        case 2:
                            GetManus()->AI()->Talk(SAY_MANUS_HEAT);
                            break;
                        case 3:
                            GetManus()->AI()->Talk(SAY_MANUS_BANANA);
                            break;
                        case 4:
                            GetManus()->AI()->Talk(SAY_MANUS_ORANGE);
                            break;
                        case 5:
                            GetManus()->AI()->Talk(SAY_MANUS_PAPAYA);
                            break;
                    }
                    timer = 10000;
                }
            }
        }
    };
};

class npc_mcmanus : public CreatureScript
{
public:
    npc_mcmanus() : CreatureScript("npc_mcmanus") {}

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!player)
            return true;

        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_STILL_AT_IT) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_MANUS_MENU, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*uiSender*/, uint32 uiAction) override
    {
        if (!player)
            return true;

        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            Creature* trigger = creature->FindNearestCreature(NPC_WANTS_BANANAS, 20.0f, true);
            if (trigger && trigger->AI())
                if (!CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->running)
                {
                    CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->playerGUID = player->GetGUID();
                    CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->thunderbrewGUID = creature->GetGUID();
                    CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->Start();
                }
        }

        CloseGossipMenuFor(player);
        return true;
    }
};

class go_pressure_valve : public GameObjectScript
{
public:
    go_pressure_valve() : GameObjectScript("go_pressure_valve") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player)
            return true;

        Creature* trigger = go->FindNearestCreature(NPC_WANTS_BANANAS, 20.0f, true);
        if (trigger && trigger->AI())
            if (CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->running)
                CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->CheckAction(1, player->GetGUID());

        return false;
    }
};

class go_brazier : public GameObjectScript
{
public:
    go_brazier() : GameObjectScript("go_brazier") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        if (!player)
            return true;

        Creature* trigger = go->FindNearestCreature(NPC_WANTS_BANANAS, 20.0f, true);
        if (trigger && trigger->AI())
            if (CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->running)
                CAST_AI(npc_still_at_it_trigger::npc_still_at_it_triggerAI, trigger->AI())->CheckAction(2, player->GetGUID());

        return false;
    }
};

/*######
## npc_vekjik
######*/

enum Vekjik
{
    GOSSIP_VEKJIK_MENU_1        = 9678,
    GOSSIP_VEKJIK_MENU_2        = 9686,

    GOSSIP_TEXTID_VEKJIK_1       = 13137,
    GOSSIP_TEXTID_VEKJIK_2       = 13138,

    SAY_TEXTID_VEKJIK1          = 0,

    SPELL_FREANZYHEARTS_FURY    = 51469,

    QUEST_MAKING_PEACE          = 12573
};

class npc_vekjik : public CreatureScript
{
public:
    npc_vekjik() : CreatureScript("npc_vekjik") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_MAKING_PEACE) == QUEST_STATUS_INCOMPLETE)
        {
            AddGossipItemFor(player, GOSSIP_VEKJIK_MENU_1, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            SendGossipMenuFor(player, GOSSIP_TEXTID_VEKJIK_1, creature->GetGUID());
            return true;
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_VEKJIK_MENU_2, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GOSSIP_TEXTID_VEKJIK_2, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                CloseGossipMenuFor(player);
                creature->AI()->Talk(SAY_TEXTID_VEKJIK1, player);
                player->AreaExploredOrEventHappens(QUEST_MAKING_PEACE);
                //creature->CastSpell(player, SPELL_FREANZYHEARTS_FURY, true);
                player->KnockbackFrom(creature->GetPositionX(), creature->GetPositionY(), 30.0f, 18.0f);
                break;
        }

        return true;
    }
};

/*######
## avatar_of_freya
######*/

enum Freya
{
    QUEST_FREYA_PACT         = 12621,

    SPELL_FREYA_CONVERSATION = 52045,

    GOSSIP_AVATAR_MENU_1     = 9720,
    GOSSIP_AVATAR_MENU_2     = 9721,
    GOSSIP_AVATAR_MENU_3     = 9722,

    GOSSIP_TEXTID_AVATAR_1   = 13303,
    GOSSIP_TEXTID_AVATAR_2   = 13304,
    GOSSIP_TEXTID_AVATAR_3   = 13305,
};

class npc_avatar_of_freya : public CreatureScript
{
public:
    npc_avatar_of_freya() : CreatureScript("npc_avatar_of_freya") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (player->GetQuestStatus(QUEST_FREYA_PACT) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_AVATAR_MENU_1, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, GOSSIP_TEXTID_AVATAR_1, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                AddGossipItemFor(player, GOSSIP_AVATAR_MENU_2, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, GOSSIP_TEXTID_AVATAR_2, creature);
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                AddGossipItemFor(player, GOSSIP_AVATAR_MENU_3, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
                SendGossipMenuFor(player, GOSSIP_TEXTID_AVATAR_3, creature);
                break;
            case GOSSIP_ACTION_INFO_DEF+3:
                player->CastSpell(player, SPELL_FREYA_CONVERSATION, true);
                CloseGossipMenuFor(player);
                break;
        }
        return true;
    }
};

/*######
## npc_bushwhacker
######*/

class npc_bushwhacker : public CreatureScript
{
public:
    npc_bushwhacker() : CreatureScript("npc_bushwhacker") { }

    struct npc_bushwhackerAI : public ScriptedAI
    {
        npc_bushwhackerAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        void InitializeAI() override
        {
            if (me->isDead())
                return;

            if (TempSummon* summ = me->ToTempSummon())
                if (Unit* summoner = summ->GetSummonerUnit())
                    me->GetMotionMaster()->MovePoint(0, summoner->GetPositionX(), summoner->GetPositionY(), summoner->GetPositionZ());

            Reset();
        }

        void UpdateAI(uint32 /*uiDiff*/) override
        {
            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_bushwhackerAI(creature);
    }
};

/*######
## npc_engineer_helice
######*/

enum EngineerHelice
{
    // Spells
    SPELL_EXPLODE_CRYSTAL       = 62487,
    SPELL_FLAMES                = 64561,

    // Yells
    SAY_WP_1                    = 0,
    SAY_WP_2                    = 1,
    SAY_WP_3                    = 2,
    SAY_WP_4                    = 3,
    SAY_WP_5                    = 4,
    SAY_WP_6                    = 5,
    SAY_WP_7                    = 6,

    // Quests
    QUEST_DISASTER              = 12688
};

class npc_engineer_helice : public CreatureScript
{
public:
    npc_engineer_helice() : CreatureScript("npc_engineer_helice") { }

    struct npc_engineer_heliceAI : public npc_escortAI
    {
        npc_engineer_heliceAI(Creature* creature) : npc_escortAI(creature) { }

        uint32 m_uiChatTimer;

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();

            switch (waypointId)
            {
                case 0:
                    Talk(SAY_WP_2);
                    break;
                case 1:
                    Talk(SAY_WP_3);
                    me->CastSpell(5918.33f, 5372.91f, -98.770f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5918.33f, 5372.91f, -98.770f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);     //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 2:
                    Talk(SAY_WP_4);
                    break;
                case 7:
                    Talk(SAY_WP_5);
                    break;
                case 8:
                    me->CastSpell(5887.37f, 5379.39f, -91.289f, SPELL_EXPLODE_CRYSTAL, true);
                    me->SummonGameObject(184743, 5887.37f, 5379.39f, -91.289f, 0, 0, 0, 0, 0, TEMPSUMMON_MANUAL_DESPAWN);      //approx 3 to 4 seconds
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    break;
                case 9:
                    Talk(SAY_WP_6);
                    break;
                case 13:
                    if (player)
                    {
                        player->GroupEventHappens(QUEST_DISASTER, me);
                        Talk(SAY_WP_7);
                    }
                    break;
            }
        }

        void Reset() override
        {
            m_uiChatTimer = 4000;
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (Player* player = GetPlayerForEscort())
                    player->FailQuest(QUEST_DISASTER);
            }
        }

        void UpdateAI(uint32 uiDiff) override
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (HasEscortState(STATE_ESCORT_ESCORTING))
            {
                if (m_uiChatTimer <= uiDiff)
                {
                    m_uiChatTimer = 12000;
                }
                else
                    m_uiChatTimer -= uiDiff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_engineer_heliceAI(creature);
    }

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest) override
    {
        if (quest->GetQuestId() == QUEST_DISASTER)
        {
            if (npc_engineer_heliceAI* pEscortAI = CAST_AI(npc_engineer_helice::npc_engineer_heliceAI, creature->AI()))
            {
                creature->GetMotionMaster()->MoveJumpTo(0, 0.4f, 0.4f);
                creature->SetFaction(FACTION_ESCORTEE_N_NEUTRAL_PASSIVE);

                creature->SetWalk(true);
                pEscortAI->Start(false, player->GetGUID());
                creature->AI()->Talk(SAY_WP_1);
            }
        }
        return true;
    }
};

/*#####
## npc_jungle_punch_target
#####*/

enum JunglePunch
{
    ITEM_TANKARD                        = 2705,

    NPC_HEMET                           = 27986,
    NPC_HADRIUS                         = 28047,

    SPELL_KNOCKDOWN                     = 42963,
    SPELL_OFFER                         = 51962,
    QUEST_TASTE_TEST                    = 12645,

    SAY_HEMET_HADRIUS_TAMARA_1          = 0,
    SAY_HEMET_HADRIUS_TAMARA_2          = 1,
    SAY_HEMET_HADRIUS_TAMARA_3          = 2,

    SAY_HEMET_4                         = 3, // unused
    SAY_HEMET_5                         = 4,  // unused

    // Player Say
    SAY_OFFER                           = 28558,
};

enum NesingwaryChildrensWeek
{
    SPELL_ORPHAN_OUT                    = 58818,

    QUEST_THE_MIGHTY_HEMET_NESINGWARY   = 13957,

    ORPHAN_WOLVAR                       = 33532,

    TEXT_NESINGWARY_1                   = 5,

    TEXT_WOLVAR_ORPHAN_6                = 6,
    TEXT_WOLVAR_ORPHAN_7                = 7,
    TEXT_WOLVAR_ORPHAN_8                = 8,
    TEXT_WOLVAR_ORPHAN_9                = 9
};

class npc_jungle_punch_target : public CreatureScript
{
public:
    npc_jungle_punch_target() : CreatureScript("npc_jungle_punch_target") { }

    struct npc_jungle_punch_targetAI : public ScriptedAI
    {
        npc_jungle_punch_targetAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            sayTimer = 3500;
            sayStep = 0;
            timer = 0;
            phase = 0;
            playerGUID.Clear();
            orphanGUID.Clear();
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!phase && who && who->GetDistance2d(me) < 10.0f)
                if (Player* player = who->ToPlayer())
                    if (player->GetQuestStatus(QUEST_THE_MIGHTY_HEMET_NESINGWARY) == QUEST_STATUS_INCOMPLETE)
                    {
                        playerGUID = player->GetGUID();
                        if (Aura* orphanOut = player->GetAura(SPELL_ORPHAN_OUT))
                            if (orphanOut->GetCaster() && orphanOut->GetCaster()->GetEntry() == ORPHAN_WOLVAR)
                            {
                                orphanGUID = orphanOut->GetCaster()->GetGUID();
                                phase = 1;
                            }
                    }
        }

        void proceedCwEvent(const uint32 diff)
        {
            if (timer <= diff)
            {
                Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
                Creature* orphan = ObjectAccessor::GetCreature(*me, orphanGUID);

                if (!orphan || !player)
                {
                    Reset();
                    return;
                }

                switch (phase)
                {
                    case 1:
                        orphan->GetMotionMaster()->MovePoint(0, me->GetPositionX() + cos(me->GetOrientation()) * 5, me->GetPositionY() + std::sin(me->GetOrientation()) * 5, me->GetPositionZ());
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_6);
                        timer = 5000;
                        break;
                    case 2:
                        orphan->SetFacingToObject(me);
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_7);
                        timer = 5000;
                        break;
                    case 3:
                        Talk(TEXT_NESINGWARY_1);
                        timer = 5000;
                        break;
                    case 4:
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_8);
                        timer = 5000;
                        break;
                    case 5:
                        orphan->AI()->Talk(TEXT_WOLVAR_ORPHAN_9);
                        timer = 5000;
                        break;
                    case 6:
                        orphan->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                        player->GroupEventHappens(QUEST_THE_MIGHTY_HEMET_NESINGWARY, me);
                        Reset();
                        return;
                }
                ++phase;
            }
            else
                timer -= diff;
        }

        void UpdateAI(uint32 diff) override
        {
            if (phase)
                proceedCwEvent(diff);

            if (!sayStep)
                return;

            if (sayTimer < diff)
            {
                if (sayStep == 2)
                {
                    me->SetSheath(SHEATH_STATE_MELEE);
                    SetEquipmentSlots(false, ITEM_TANKARD, EQUIP_UNEQUIP, EQUIP_UNEQUIP);
                }
                else if (sayStep == 3)
                {
                    if (me->GetEntry() == NPC_HEMET)
                        me->SetSheath(SHEATH_STATE_RANGED);
                    else if (me->GetEntry() == NPC_HADRIUS)
                    {
                        me->SetSheath(SHEATH_STATE_UNARMED);
                        me->CastSpell(me, SPELL_KNOCKDOWN, false);
                    }
                    SetEquipmentSlots(true);
                }

                Talk(SAY_HEMET_HADRIUS_TAMARA_1 + sayStep - 1);
                sayTimer = 6000;
                sayStep++;

                if (sayStep > 3) // end
                    sayStep = 0;
            }
            else
                sayTimer -= diff;
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id != SPELL_OFFER)
                return;

            Player* player = caster->ToPlayer();
            if (!player)
                return;

            Quest const* quest = sObjectMgr->GetQuestTemplate(QUEST_TASTE_TEST);
            if (!quest)
                return;

            QuestStatusMap::const_iterator itr = player->getQuestStatusMap().find(QUEST_TASTE_TEST);
            if (itr->second.Status != QUEST_STATUS_INCOMPLETE)
                return;

            for (uint8 i = 0; i < 3; ++i)
            {
                if (uint32(quest->RequiredNpcOrGo[i]) != me->GetEntry())
                    continue;

                if (itr->second.CreatureOrGOCount[i] != 0)
                    continue;

                player->KilledMonsterCredit(me->GetEntry());
                player->Say(SAY_OFFER);
                sayStep = 1;
                break;
            }
        }

    private:
        uint16 sayTimer;
        uint8 sayStep;
        uint32 timer;
        int8 phase;
        ObjectGuid playerGUID;
        ObjectGuid orphanGUID;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_jungle_punch_targetAI(creature);
    }
};

/*######
## npc_adventurous_dwarf
######*/

enum AdventurousDwarf
{
    QUEST_12634         = 12634,

    ITEM_BANANAS        = 38653,
    ITEM_PAPAYA         = 38655,
    ITEM_ORANGE         = 38656,

    SPELL_ADD_ORANGE    = 52073,
    SPELL_ADD_BANANAS   = 52074,
    SPELL_ADD_PAPAYA    = 52076,

    SAY_DWARF_OUCH      = 0,
    SAY_DWARF_HELP      = 1,

    // Gossips
    GOSSIP_DWARF_MENU   = 9724,
    GOSSIP_DWARF_ORANGE = 0,
    GOSSIP_DWARF_BANANA = 1,
    GOSSIP_DWARF_PAPAYA = 2,
};

class npc_adventurous_dwarf : public CreatureScript
{
public:
    npc_adventurous_dwarf() : CreatureScript("npc_adventurous_dwarf") { }

    struct npc_adventurous_dwarfAI : public ScriptedAI
    {
        npc_adventurous_dwarfAI(Creature* creature) : ScriptedAI(creature)
        {
            Talk(SAY_DWARF_OUCH);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_adventurous_dwarfAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_12634) != QUEST_STATUS_INCOMPLETE)
            return false;

        if (player->GetItemCount(ITEM_ORANGE) < 1)
            AddGossipItemFor(player, GOSSIP_DWARF_MENU, GOSSIP_DWARF_ORANGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        if (player->GetItemCount(ITEM_BANANAS) < 2)
            AddGossipItemFor(player, GOSSIP_DWARF_MENU, GOSSIP_DWARF_BANANA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

        if (player->GetItemCount(ITEM_PAPAYA) < 1)
            AddGossipItemFor(player, GOSSIP_DWARF_MENU, GOSSIP_DWARF_PAPAYA, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        uint32 spellId = 0;

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                spellId = SPELL_ADD_ORANGE;
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                spellId = SPELL_ADD_BANANAS;
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                spellId = SPELL_ADD_PAPAYA;
                break;
        }

        if (spellId)
            player->CastSpell(player, spellId, true);

        creature->AI()->Talk(SAY_DWARF_HELP);
        creature->DespawnOrUnsummon();
        return true;
    }
};

/*######
## Quest The Lifewarden's Wrath
######*/

enum MiscLifewarden
{
    NPC_PRESENCE = 28563, // Freya's Presence
    NPC_SABOTEUR = 28538, // Cultist Saboteur
    NPC_SERVANT = 28320, // Servant of Freya

    WHISPER_ACTIVATE = 0,

    SPELL_FREYA_DUMMY = 51318,
    SPELL_LIFEFORCE = 51395,
    SPELL_FREYA_DUMMY_TRIGGER = 51335,
    SPELL_LASHER_EMERGE = 48195,
    SPELL_WILD_GROWTH = 52948,
};

class spell_q12620_the_lifewarden_wrath : public SpellScript
{
    PrepareSpellScript(spell_q12620_the_lifewarden_wrath);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FREYA_DUMMY, SPELL_FREYA_DUMMY_TRIGGER, SPELL_LASHER_EMERGE, SPELL_WILD_GROWTH, SPELL_LIFEFORCE });
    }

    void HandleSendEvent(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);

        if (Unit* caster = GetCaster())
        {
            if (Creature* presence = caster->FindNearestCreature(NPC_PRESENCE, 50.0f))
            {
                presence->AI()->Talk(WHISPER_ACTIVATE, caster);
                presence->CastSpell(presence, SPELL_FREYA_DUMMY, true); // will target plants
                // Freya Dummy could be scripted with the following code

                // Revive plants
                std::list<Creature*> servants;
                GetCaster()->GetCreatureListWithEntryInGrid(servants, NPC_SERVANT, 200.0f);
                for (std::list<Creature*>::iterator itr = servants.begin(); itr != servants.end(); ++itr)
                {
                    // Couldn't find a spell that does this
                    if ((*itr)->isDead())
                        (*itr)->Respawn(true);

                    (*itr)->CastSpell(*itr, SPELL_FREYA_DUMMY_TRIGGER, true);
                    (*itr)->CastSpell(*itr, SPELL_LASHER_EMERGE, false);
                    (*itr)->CastSpell(*itr, SPELL_WILD_GROWTH, false);

                    if (Unit* target = (*itr)->SelectNearestTarget(150.0f))
                        (*itr)->AI()->AttackStart(target);
                }

                // Kill nearby enemies
                std::list<Creature*> saboteurs;
                caster->GetCreatureListWithEntryInGrid(saboteurs, NPC_SABOTEUR, 200.0f);
                for (std::list<Creature*>::iterator itr = saboteurs.begin(); itr != saboteurs.end(); ++itr)
                    if ((*itr)->IsAlive())
                        // Lifeforce has a cast duration, it should be cast at all saboteurs one by one
                        presence->CastSpell((*itr), SPELL_LIFEFORCE, false);
            }
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_q12620_the_lifewarden_wrath::HandleSendEvent, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

/*######
## Quest Kick, What Kick? (12589)
######*/

enum KickWhatKick
{
    NPC_LUCKY_WILHELM = 28054,
    NPC_APPLE = 28053,
    NPC_DROSTAN = 28328,
    NPC_CRUNCHY = 28346,
    NPC_THICKBIRD = 28093,

    SPELL_HIT_APPLE = 51331,
    SPELL_MISS_APPLE = 51332,
    SPELL_MISS_BIRD_APPLE = 51366,
    SPELL_APPLE_FALL = 51371,
    SPELL_BIRD_FALL = 51369,

    EVENT_MISS = 0,
    EVENT_HIT = 1,
    EVENT_MISS_BIRD = 2,

    SAY_WILHELM_MISS = 0,
    SAY_WILHELM_HIT = 1,
    SAY_DROSTAN_REPLY_MISS = 0,
};

class spell_q12589_shoot_rjr : public SpellScript
{
    PrepareSpellScript(spell_q12589_shoot_rjr);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MISS_BIRD_APPLE, SPELL_BIRD_FALL, SPELL_MISS_APPLE, SPELL_HIT_APPLE, SPELL_APPLE_FALL });
    }

    SpellCastResult CheckCast()
    {
        if (Unit* target = GetExplTargetUnit())
            if (target->GetEntry() == NPC_LUCKY_WILHELM)
                return SPELL_CAST_OK;

        SetCustomCastResultMessage(SPELL_CUSTOM_ERROR_MUST_TARGET_WILHELM);
        return SPELL_FAILED_CUSTOM_ERROR;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        uint32 roll = urand(1, 100);

        uint8 ev;
        if (roll <= 50)
            ev = EVENT_MISS;
        else if (roll <= 83)
            ev = EVENT_HIT;
        else
            ev = EVENT_MISS_BIRD;

        Unit* shooter = GetCaster();
        Creature* wilhelm = GetHitUnit()->ToCreature();
        Creature* apple = shooter->FindNearestCreature(NPC_APPLE, 30);
        Creature* drostan = shooter->FindNearestCreature(NPC_DROSTAN, 30);

        if (!wilhelm || !apple || !drostan)
            return;

        switch (ev)
        {
            case EVENT_MISS_BIRD:
                {
                    Creature* crunchy = shooter->FindNearestCreature(NPC_CRUNCHY, 30);
                    Creature* bird = shooter->FindNearestCreature(NPC_THICKBIRD, 30);

                    if (!bird || !crunchy)
                        ; // fall to EVENT_MISS
                    else
                    {
                        shooter->CastSpell(bird, SPELL_MISS_BIRD_APPLE);
                        bird->CastSpell(bird, SPELL_BIRD_FALL);
                        wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                        drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);

                        Unit::Kill(bird, bird);
                        crunchy->GetMotionMaster()->MovePoint(0, bird->GetPositionX(), bird->GetPositionY(),
                                                              bird->GetMapWaterOrGroundLevel(bird->GetPositionX(), bird->GetPositionY(), bird->GetPositionZ()));
                        /// @todo Make crunchy perform emote eat when he reaches the bird

                        break;
                    }
                    [[fallthrough]];
                }
            case EVENT_MISS:
                {
                    shooter->CastSpell(wilhelm, SPELL_MISS_APPLE);
                    wilhelm->AI()->Talk(SAY_WILHELM_MISS);
                    drostan->AI()->Talk(SAY_DROSTAN_REPLY_MISS);
                    break;
                }
            case EVENT_HIT:
                {
                    shooter->CastSpell(apple, SPELL_HIT_APPLE);
                    apple->CastSpell(apple, SPELL_APPLE_FALL);
                    wilhelm->AI()->Talk(SAY_WILHELM_HIT);
                    if (Player* player = shooter->ToPlayer())
                        player->KilledMonsterCredit(NPC_APPLE);
                    //apple->DespawnOrUnsummon(); zomg!

                    break;
                }
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_q12589_shoot_rjr::CheckCast);
        OnEffectHitTarget += SpellEffectFn(spell_q12589_shoot_rjr::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/*######
## Quest Dreadsaber Mastery: Stalking the Prey (12550)
######*/

enum ShangoTracks
{
    SPELL_CORRECT_TRACKS   = 52160,
    SPELL_INCORRECT_TRACKS = 52163,
    SAY_CORRECT_TRACKS     = 28634,
    SAY_INCORRECT_TRACKS   = 28635
};

class spell_shango_tracks : public SpellScript
{
    PrepareSpellScript(spell_shango_tracks);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            switch (GetSpellInfo()->Id)
            {
                case SPELL_CORRECT_TRACKS:
                    target->Say(SAY_CORRECT_TRACKS, target);
                    break;
                case SPELL_INCORRECT_TRACKS:
                    target->Say(SAY_INCORRECT_TRACKS, target);
                    break;
                default:
                    break;
            }
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_shango_tracks::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum ReturnedSevenfold
{
    SPELL_FREYAS_WARD           = 51845,
    SPELL_SEVENFOLD_RETRIBUTION = 51856,
    SPELL_DEATHBOLT             = 51855
};

class spell_q12611_deathbolt : public SpellScript
{
    PrepareSpellScript(spell_q12611_deathbolt);

    void HandleScriptEffect(SpellEffIndex /* effIndex */)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();

        if (target->HasAura(SPELL_FREYAS_WARD))
        {
            target->CastSpell(caster, SPELL_SEVENFOLD_RETRIBUTION, true);
        }
        else
        {
            caster->CastSpell(target, SPELL_DEATHBOLT, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_q12611_deathbolt::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_sholazar_basin()
{
    RegisterSpellScript(spell_q12726_song_of_wind_and_water);
    new npc_still_at_it_trigger();
    new npc_mcmanus();
    new go_pressure_valve();
    new go_brazier();
    new npc_vekjik();
    new npc_avatar_of_freya();
    new npc_bushwhacker();
    new npc_engineer_helice();
    new npc_adventurous_dwarf();
    new npc_jungle_punch_target();
    RegisterSpellScript(spell_q12620_the_lifewarden_wrath);
    RegisterSpellScript(spell_q12589_shoot_rjr);
    RegisterSpellScript(spell_shango_tracks);

    RegisterSpellScript(spell_q12611_deathbolt);
}
