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
#include "GridNotifiers.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include <algorithm>

enum AlchemistItemRequirements
{
    QUEST_ALCHEMIST_APPRENTICE      = 12541,
    NPC_FINKLESTEIN                 = 28205,
};

const uint32 AA_ITEM_ENTRY[24] = {38336, 39669, 38342, 38340, 38344, 38369, 38396, 38398, 38338, 38386, 38341, 38384, 38397, 38381, 38337, 38393, 38339, 39668, 39670, 38346, 38379, 38345, 38343, 38370};
const uint32 AA_AURA_ID[24]    = {51095, 53153, 51100, 51087, 51091, 51081, 51072, 51079, 51018, 51067, 51055, 51064, 51077, 51062, 51057, 51069, 51059, 53150, 53158, 51093, 51097, 51102, 51083, 51085};
const char*  AA_ITEM_NAME[24]  = {"Crystallized Hogsnot", "Ghoul Drool", "Trollbane", "Amberseed", "Shrunken Dragon's Claw",
                                  "Wasp's Wings", "Hairy Herring Head", "Icecrown Bottled Water", "Knotroot", "Muddy Mire Maggot", "Pickled Eagle Egg",
                                  "Pulverized Gargoyle Teeth", "Putrid Pirate Perspiration", "Seasoned Slider Cider", "Speckled Guano", "Spiky Spider Egg",
                                  "Withered Batwing", "Abomination Guts", "Blight Crystal", "Chilled Serpent Mucus", "Crushed Basilisk Crystals",
                                  "Frozen Spider Ichor", "Prismatic Mojo", "Raptor Claw"
                                 };

class npc_finklestein : public CreatureScript
{
public:
    npc_finklestein() : CreatureScript("npc_finklestein") { }

    struct npc_finklesteinAI : public ScriptedAI
    {
        npc_finklesteinAI(Creature* creature) : ScriptedAI(creature) {}

        std::map<ObjectGuid, uint32> questList;

        void ClearPlayerOnTask(ObjectGuid guid)
        {
            std::map<ObjectGuid, uint32>::iterator itr = questList.find(guid);
            if (itr != questList.end())
                questList.erase(itr);
        }

        bool IsPlayerOnTask(ObjectGuid guid)
        {
            std::map<ObjectGuid, uint32>::const_iterator itr = questList.find(guid);
            return itr != questList.end();
        }

        void RightClickCauldron(ObjectGuid guid)
        {
            if (questList.empty())
                return;

            std::map<ObjectGuid, uint32>::iterator itr = questList.find(guid);
            if (itr == questList.end())
                return;

            Player* player = ObjectAccessor::GetPlayer(*me, guid);
            if (player)
            {
                uint32 itemCode = itr->second;

                uint32 itemEntry = GetTaskItemEntry(itemCode);
                uint32 auraId = GetTaskAura(itemCode);
                uint32 counter = GetTaskCounter(itemCode);
                if (player->HasAura(auraId))
                {
                    // player still has aura, but no item. Skip
                    if (!player->HasItemCount(itemEntry))
                        return;

                    // if we are here, all is ok (aura and item present)
                    player->DestroyItemCount(itemEntry, 1, true);
                    player->RemoveAurasDueToSpell(auraId);

                    if (counter < 6)
                    {
                        StartNextTask(player->GetGUID(), counter + 1);
                        return;
                    }
                    else
                        player->KilledMonsterCredit(28248);
                }
                else
                {
                    // if we are here, it means we failed :(
                    player->SetQuestStatus(QUEST_ALCHEMIST_APPRENTICE, QUEST_STATUS_FAILED);
                }
            }
            questList.erase(itr);
        }

        // Generate a Task and announce it to the player
        void StartNextTask(ObjectGuid playerGUID, uint32 counter)
        {
            if (counter > 6)
                return;

            Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
            if (!player)
                return;

            // Generate Item Code
            uint32 itemCode = SelectRandomCode(counter);
            questList[playerGUID] = itemCode;

            // Decode Item Entry, Get Item Name, Generate Emotes
            //uint32 itemEntry = GetTaskItemEntry(itemCode);
            uint32 auraId = GetTaskAura(itemCode);
            const char* itemName = GetTaskItemName(itemCode);

            switch (counter)
            {
                case 1:
                    me->TextEmote("Quickly, get me some...", player, true);
                    me->TextEmote(itemName, player, true);
                    me->CastSpell(player, auraId, true);
                    break;
                case 2:
                    me->TextEmote("Find me some...", player, true);
                    me->TextEmote(itemName, player, true);
                    me->CastSpell(player, auraId, true);
                    break;
                case 3:
                    me->TextEmote("I think it needs...", player, true);
                    me->TextEmote(itemName, player, true);
                    me->CastSpell(player, auraId, true);
                    break;
                case 4:
                    me->TextEmote("Alright, now fetch me some...", player, true);
                    me->TextEmote(itemName, player, true);
                    me->CastSpell(player, auraId, true);
                    break;
                case 5:
                    me->TextEmote("Before it thickens, we must add...", player, true);
                    me->TextEmote(itemName, player, true);
                    me->CastSpell(player, auraId, true);
                    break;
                case 6:
                    me->TextEmote("It's thickening! Quickly get me some...", player, true);
                    me->TextEmote(itemName, player, true);
                    me->CastSpell(player, auraId, true);
                    break;
            }
        }

        uint32 SelectRandomCode(uint32 counter)  { return (counter * 100 + urand(0, 23)); }

        uint32 GetTaskCounter(uint32 itemcode)   { return itemcode / 100; }
        uint32 GetTaskAura(uint32 itemcode)      { return AA_AURA_ID[itemcode % 100]; }
        uint32 GetTaskItemEntry(uint32 itemcode) { return AA_ITEM_ENTRY[itemcode % 100]; }
        const char* GetTaskItemName(uint32 itemcode)  { return AA_ITEM_NAME[itemcode % 100]; }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ALCHEMIST_APPRENTICE)
            if (creature->AI() && CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI()))
                CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI())->ClearPlayerOnTask(player->GetGUID());

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        if (player->GetQuestStatus(QUEST_ALCHEMIST_APPRENTICE) == QUEST_STATUS_INCOMPLETE)
        {
            if (creature->AI() && CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI()))
                if (!CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI())->IsPlayerOnTask(player->GetGUID()))
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "I'm ready to begin. What is the first ingredient you require?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        }

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
    {
        CloseGossipMenuFor(player);
        if (uiAction == GOSSIP_ACTION_INFO_DEF + 1)
        {
            CloseGossipMenuFor(player);
            if (creature->AI() && CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI()))
                CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI())->StartNextTask(player->GetGUID(), 1);
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_finklesteinAI(creature);
    }
};

class go_finklestein_cauldron : public GameObjectScript
{
public:
    go_finklestein_cauldron() : GameObjectScript("go_finklestein_cauldron") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        Creature* finklestein = go->FindNearestCreature(NPC_FINKLESTEIN, 30.0f, true);
        if (finklestein && finklestein->AI())
            CAST_AI(npc_finklestein::npc_finklesteinAI, finklestein->AI())->RightClickCauldron(player->GetGUID());

        return true;
    }
};

enum OverlordDrakuru
{
    SPELL_SHADOW_BOLT                     = 54113,
    SPELL_SCOURGE_DISGUISE_EXPIRING       = 52010,
    SPELL_DROP_DISGUISE                   = 54089,
    SPELL_THROW_BRIGHT_CRYSTAL            = 54087,
    SPELL_TELEPORT_EFFECT                 = 52096,
    SPELL_SCOURGE_SPOTLIGHT               = 53104,
    SPELL_SCOURGE_DISGUISE                = 51966,
    SPELL_SCOURGE_DISGUISE_INSTANT_CAST   = 52192,
    SPELL_BLIGHT_FOG                      = 54104,
    SPELL_THROW_PORTAL_CRYSTAL            = 54209,
    SPELL_ARTHAS_PORTAL                   = 51807,
    SPELL_TOUCH_OF_DEATH                  = 54236,
    SPELL_DRAKURU_DEATH                   = 54248,
    SPELL_SUMMON_SKULL                    = 54253,
    SPELL_BLOATED_ABOMINATION_FEIGN_DEATH = 52593,
    SPELL_EXPLODE_ABOMINATION_BLOODY_MEAT = 52523,
    SPELL_EXPLODE_ABOMINATION_MEAT        = 52520,
    SPELL_DRAKURUS_SKULL_MISSILE          = 54250,
    SPELL_BURST_AT_THE_SEAMS_BONE         = 52516,

    QUEST_BETRAYAL                        = 12713,

    NPC_BLIGHTBLOOD_TROLL                 = 28931,
    NPC_LICH_KING                         = 28498,
    NPC_TOTALLY_GENERIC_BUNNY             = 29100,
    NPC_TOTALLY_GENERIC_BUNNY_JSB         = 28960,
    GO_DRAKURUS_LAST_WISH                 = 202357,
    GO_DRAKURUS_BONE                      = 191458,

    ACTION_SUMMON_DRAKURU_LAST_WISH       = 1,
    ACTION_DESTROY_DRAKURU_LAST_WISH      = 2,
    ACTION_REMOVE_SPOTLIGHTS              = 3,

    SUMMON_GROUP_BLIGHTBLOOD_TROLL        = 1,

    EVENT_BETRAYAL_INTRO_1                = 1,
    EVENT_BETRAYAL_INTRO_2                = 2,
    EVENT_BETRAYAL_INTRO_3                = 3,
    EVENT_BETRAYAL_INTRO_4                = 4,
    EVENT_BETRAYAL_EVADE_CHECK            = 5,
    EVENT_BETRAYAL_EPILOGUE_1             = 6,
    EVENT_BETRAYAL_EPILOGUE_2             = 7,
    EVENT_BETRAYAL_EPILOGUE_3             = 8,
    EVENT_BETRAYAL_EPILOGUE_4             = 9,
    EVENT_BETRAYAL_EPILOGUE_5             = 10,
    EVENT_BETRAYAL_EPILOGUE_6             = 11,
    EVENT_BETRAYAL_EPILOGUE_7             = 12,
    EVENT_BETRAYAL_EPILOGUE_8             = 13,
    EVENT_BETRAYAL_EPILOGUE_9             = 14,
    EVENT_BETRAYAL_EPILOGUE_10            = 15,

    SAY_DRAKURU_0                         = 0,
    SAY_DRAKURU_1                         = 1,
    SAY_DRAKURU_2                         = 2,
    SAY_DRAKURU_3                         = 3,
    SAY_DRAKURU_4                         = 4,
    SAY_DRAKURU_5                         = 5,
    SAY_DRAKURU_6                         = 6,
    SAY_DRAKURU_7                         = 7,
    SAY_LICH_7                            = 7,
    SAY_LICH_8                            = 8,
    SAY_LICH_9                            = 9,
    SAY_LICH_10                           = 10,
    SAY_LICH_11                           = 11,
    SAY_LICH_12                           = 12,
};

enum BetrayalState
{
    BETRAYAL_NOT_STARTED,
    BETRAYAL_IN_PROGRESS,
    BETRAYAL_EPILOGUE,
    BETRAYAL_EVADE,
};

struct npc_overlord_drakuru_betrayal : public ScriptedAI
{
    npc_overlord_drakuru_betrayal(Creature* creature) : ScriptedAI(creature), _summons(me), _state(BETRAYAL_NOT_STARTED)
    {
        me->SetControlled(true, UNIT_STATE_ROOT);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (_state != BETRAYAL_EVADE)
            return;
        me->SetFaction(FACTION_UNDEAD_SCOURGE);
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        ScriptedAI::EnterEvadeMode(why);
    }

    void Reset() override
    {
        events.Reset();
        scheduler.CancelAll();
        _summons.DespawnAll();
        _playerGUID.Clear();
        _lichGUID.Clear();
        me->SetFaction(FACTION_UNDEAD_SCOURGE);
        me->SetVisible(false);
        DoAction(ACTION_SUMMON_DRAKURU_LAST_WISH);
        me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        me->SetImmuneToPC(true);
        _state = BETRAYAL_NOT_STARTED;
        DoAction(ACTION_REMOVE_SPOTLIGHTS);
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
            case ACTION_SUMMON_DRAKURU_LAST_WISH:
                if (!me->FindNearestGameObject(GO_DRAKURUS_LAST_WISH, 80.0f))
                    me->SummonGameObject(GO_DRAKURUS_LAST_WISH, 6185.989, -2029.6979, 590.87787, 0, 0, 0, 0, 0, 0, true, GO_SUMMON_TIMED_DESPAWN);
                break;
            case ACTION_DESTROY_DRAKURU_LAST_WISH:
                if (GameObject* go = me->FindNearestGameObject(GO_DRAKURUS_LAST_WISH, 80.0f))
                    go->Delete();
                break;
            case ACTION_REMOVE_SPOTLIGHTS:
            {
                std::list<Creature*> creatures;
                me->GetCreatureListWithEntryInGrid(creatures, NPC_TOTALLY_GENERIC_BUNNY, 55.0f);
                for (Creature* creature : creatures)
                    creature->RemoveAurasDueToSpell(SPELL_SCOURGE_SPOTLIGHT);
            }
        }
    }

    bool IsPlayerOnQuest(Player* player)
    {
        return player->GetQuestStatus(QUEST_BETRAYAL) == QUEST_STATUS_INCOMPLETE;
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (Player* player = who->ToPlayer())
        {
            bool shouldStartEvent = (_state == BETRAYAL_NOT_STARTED) && IsPlayerOnQuest(player) && player->HasAura(SPELL_SCOURGE_DISGUISE) && player->IsWithinDistInMap(me, 80.0f) && !me->FindNearestGameObject(GO_DRAKURUS_BONE, 80.0f);
            if (shouldStartEvent)
            {
                me->SetVisible(true);
                _state = BETRAYAL_IN_PROGRESS;
                DoAction(ACTION_DESTROY_DRAKURU_LAST_WISH);
                _playerGUID = who->GetGUID();
                events.ScheduleEvent(EVENT_BETRAYAL_INTRO_1, 6s);
                events.ScheduleEvent(EVENT_BETRAYAL_EVADE_CHECK, 10s);
            }
        }
        else
            ScriptedAI::MoveInLineOfSight(who);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        switch (summon->GetEntry())
        {
            case NPC_BLIGHTBLOOD_TROLL:
                if (Creature* target = summon->FindNearestCreature(NPC_TOTALLY_GENERIC_BUNNY, 10.0f, true))
                    target->CastSpell(target, SPELL_TELEPORT_EFFECT, true);
                break;
            case NPC_LICH_KING:
                me->SetFacingToObject(summon);
                _lichGUID = summon->GetGUID();
                summon->GetMotionMaster()->MovePoint(0, 6164.2695, -2016.8978, 590.8636);
                break;
            default:
                break;
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        scheduler.Schedule(0s, [this](TaskContext context)
        {
            if (!me->IsWithinMeleeRange(me->GetVictim()))
                DoCastVictim(SPELL_SHADOW_BOLT);
            context.Repeat(2s);
        }).Schedule(5s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                DoCast(target, SPELL_THROW_BRIGHT_CRYSTAL);
            context.Repeat(6s, 15s);
        }).Schedule(20s, [this](TaskContext context)
        {
            Talk(SAY_DRAKURU_4);
            context.Repeat(10s, 20s);
        });
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*dmgType*/, SpellSchoolMask /*school*/) override
    {
        if (damage >= me->GetHealth() && !me->HasUnitFlag(UNIT_FLAG_NON_ATTACKABLE))
        {
            damage = 0;
            me->RemoveAllAuras();
            me->CombatStop();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            me->SetFaction(2082);
            me->SetImmuneToPC(true);
            events.Reset();
            scheduler.CancelAll();
            events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_1, 4200ms);
            _state = BETRAYAL_EPILOGUE;
        }
    }

    void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
    {
        switch (spellInfo->Id)
        {
            case SPELL_THROW_PORTAL_CRYSTAL:
                if (Aura* aura = target->AddAura(SPELL_ARTHAS_PORTAL, target))
                    aura->SetDuration(77'000);
                break;
            case SPELL_DRAKURUS_SKULL_MISSILE:
                target->CastSpell(target, SPELL_SUMMON_SKULL, true);
                break;
            case SPELL_DROP_DISGUISE:
                target->CastSpell(target, SPELL_SCOURGE_DISGUISE_EXPIRING, true);
                break;
        }
    }

    void SpellHit(Unit* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_TOUCH_OF_DEATH)
        {
            DoCastAOE(SPELL_DRAKURUS_SKULL_MISSILE, true);
            DoCastSelf(SPELL_BLOATED_ABOMINATION_FEIGN_DEATH, true);
            DoCastSelf(SPELL_BURST_AT_THE_SEAMS_BONE, true);
            DoCastSelf(SPELL_BURST_AT_THE_SEAMS_BONE, true);
            DoCastSelf(SPELL_BURST_AT_THE_SEAMS_BONE, true);
            DoCastSelf(SPELL_EXPLODE_ABOMINATION_MEAT, true);
            DoCastSelf(SPELL_EXPLODE_ABOMINATION_BLOODY_MEAT, true);
            DoCastSelf(SPELL_EXPLODE_ABOMINATION_BLOODY_MEAT, true);
            DoCastSelf(SPELL_EXPLODE_ABOMINATION_BLOODY_MEAT, true);
            DoCastSelf(SPELL_DRAKURU_DEATH, true);
            DoAction(ACTION_SUMMON_DRAKURU_LAST_WISH);
            me->SetImmuneToPC(true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);
        switch (events.ExecuteEvent())
        {
            case EVENT_BETRAYAL_EVADE_CHECK:
            {
                if (_state == BETRAYAL_IN_PROGRESS)
                {
                    float radius = 80.0f;
                    std::list<Player*> players;
                    Acore::AnyPlayerInObjectRangeCheck checker(me, radius, true, true);
                    Acore::PlayerListSearcher<Acore::AnyPlayerInObjectRangeCheck> searcher(me, players, checker);
                    Cell::VisitObjects(me, searcher, radius);
                    if (std::ranges::any_of(players, [this](Player* player)
                    {
                        return IsPlayerOnQuest(player);
                    }))
                    {
                        events.Repeat(10s);
                    }
                    else
                    {
                        _state = BETRAYAL_EVADE;
                        EnterEvadeMode(EVADE_REASON_OTHER);
                    }
                }
                break;
            }
            case EVENT_BETRAYAL_INTRO_1:
                Talk(SAY_DRAKURU_0);
                events.ScheduleEvent(EVENT_BETRAYAL_INTRO_2, 4s);
                events.ScheduleEvent(EVENT_BETRAYAL_INTRO_3, 6600ms);
                break;
            case EVENT_BETRAYAL_INTRO_2:
                me->SummonCreatureGroup(SUMMON_GROUP_BLIGHTBLOOD_TROLL);
                break;
            case EVENT_BETRAYAL_INTRO_3:
                Talk(SAY_DRAKURU_1);
                DoCastAOE(SPELL_DROP_DISGUISE);
                events.ScheduleEvent(EVENT_BETRAYAL_INTRO_4, 9600ms);
                break;
            case EVENT_BETRAYAL_INTRO_4:
            {
                Talk(SAY_DRAKURU_2);
                Talk(SAY_DRAKURU_3);
                me->SetImmuneToPC(false);
                std::list<Creature*> creatures;
                me->GetCreatureListWithEntryInGrid(creatures, NPC_TOTALLY_GENERIC_BUNNY, 55.0f);
                for (Creature* creature : creatures)
                    creature->CastSpell(creature, SPELL_SCOURGE_SPOTLIGHT, true);
                break;
            }
            case EVENT_BETRAYAL_EPILOGUE_1:
            {
                Talk(SAY_DRAKURU_5);
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_2, 4800ms);
                DoAction(ACTION_REMOVE_SPOTLIGHTS);
                break;
            }
            case EVENT_BETRAYAL_EPILOGUE_2:
                Talk(SAY_DRAKURU_6);
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_3, 1800ms);
                break;
            case EVENT_BETRAYAL_EPILOGUE_3:
                DoCastSelf(SPELL_THROW_PORTAL_CRYSTAL, true);
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_4, 3600ms);
                break;
            case EVENT_BETRAYAL_EPILOGUE_4:
                me->SummonCreature(NPC_LICH_KING, 6140.4233, -2010.9938, 589.1911, 6.126106, TEMPSUMMON_TIMED_DESPAWN, 77'000);
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_5, 8400ms);
                break;
            case EVENT_BETRAYAL_EPILOGUE_5:
                Talk(SAY_DRAKURU_7);
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_6, 9600ms);
                break;
            case EVENT_BETRAYAL_EPILOGUE_6:
                if (Creature* lich = ObjectAccessor::GetCreature(*me, _lichGUID))
                {
                    lich->AI()->Talk(SAY_LICH_7);
                    lich->AI()->Talk(SAY_LICH_8, 5400ms);
                }
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_7, 7800ms);
                break;
            case EVENT_BETRAYAL_EPILOGUE_7:
                if (Creature* lich = ObjectAccessor::GetCreature(*me, _lichGUID))
                    lich->CastSpell(me, SPELL_TOUCH_OF_DEATH, false);
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_8, 4200ms);
                break;
            case EVENT_BETRAYAL_EPILOGUE_8:
                me->SetVisible(false);
                if (Creature* lich = ObjectAccessor::GetCreature(*me, _lichGUID))
                {
                    lich->AI()->Talk(SAY_LICH_9, 3600ms);
                    lich->AI()->Talk(SAY_LICH_10, 8400ms);
                    lich->AI()->Talk(SAY_LICH_11, 22800ms);
                    lich->AI()->Talk(SAY_LICH_12, 27600ms);
                }
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_9, 32600ms);
                events.ScheduleEvent(EVENT_BETRAYAL_EPILOGUE_10, 37200ms);
                break;
            case EVENT_BETRAYAL_EPILOGUE_9:
                if (Creature* lich = ObjectAccessor::GetCreature(*me, _lichGUID))
                    lich->GetMotionMaster()->MovePoint(0, 6141.2393, -2011.2728, 589.8653);
                break;
            case EVENT_BETRAYAL_EPILOGUE_10:
                _state = BETRAYAL_EVADE;
                EnterEvadeMode(EVADE_REASON_OTHER);
                break;
        }

        if (me->GetFaction() == 2082 || me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
            return;

        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        DoMeleeAttackIfReady();
    }

private:
    SummonList _summons;
    ObjectGuid _playerGUID;
    ObjectGuid _lichGUID;
    BetrayalState _state;
};

/*####
## npc_released_offspring_harkoa
####*/

class npc_released_offspring_harkoa : public CreatureScript
{
public:
    npc_released_offspring_harkoa() : CreatureScript("npc_released_offspring_harkoa") { }

    struct npc_released_offspring_harkoaAI : public ScriptedAI
    {
        npc_released_offspring_harkoaAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            float x, y, z;
            me->GetClosePoint(x, y, z, me->GetObjectSize() / 3, 25.0f);
            me->GetMotionMaster()->MovePoint(0, x, y, z);
        }

        void MovementInform(uint32 Type, uint32 /*uiId*/) override
        {
            if (Type != POINT_MOTION_TYPE)
                return;
            me->DespawnOrUnsummon();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_released_offspring_harkoaAI(creature);
    }
};

/*######
## npc_crusade_recruit
######*/

enum CrusadeRecruit
{
    SPELL_QUEST_CREDIT                       = 50633,
    QUEST_TROLL_PATROL_INTESTINAL_FORTITUDE  = 12509,
    SAY_RECRUIT                              = 0
};

enum CrusadeRecruitEvents
{
    EVENT_RECRUIT_1                          = 1,
    EVENT_RECRUIT_2                          = 2
};

class npc_crusade_recruit : public CreatureScript
{
public:
    npc_crusade_recruit() : CreatureScript("npc_crusade_recruit") { }

    struct npc_crusade_recruitAI : public ScriptedAI
    {
        npc_crusade_recruitAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_COWER);
            _heading = me->GetOrientation();
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_RECRUIT_1:
                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        Talk(SAY_RECRUIT);
                        _events.ScheduleEvent(EVENT_RECRUIT_2, 3s);
                        break;
                    case EVENT_RECRUIT_2:
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(0, me->GetPositionX() + (cos(_heading) * 10), me->GetPositionY() + (std::sin(_heading) * 10), me->GetPositionZ());
                        me->DespawnOrUnsummon(5s);
                        break;
                    default:
                        break;
                }
            }

            if (!UpdateVictim())
                return;
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
        {
            _events.ScheduleEvent(EVENT_RECRUIT_1, 100ms);
            CloseGossipMenuFor(player);
            me->CastSpell(player, SPELL_QUEST_CREDIT, true);
            me->SetFacingToObject(player);
        }

    private:
        EventMap _events;
        float    _heading; // Store creature heading
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_crusade_recruitAI(creature);
    }
};

/*######
## Quest 12916: Our Only Hope!
## go_scourge_enclosure
######*/

enum ScourgeEnclosure
{
    QUEST_OUR_ONLY_HOPE                      = 12916,
    NPC_GYMER_DUMMY                          = 29928, // From quest template
    SPELL_GYMER_LOCK_EXPLOSION               = 55529
};

class go_scourge_enclosure : public GameObjectScript
{
public:
    go_scourge_enclosure() : GameObjectScript("go_scourge_enclosure") { }

    bool OnGossipHello(Player* player, GameObject* go) override
    {
        go->UseDoorOrButton();
        if (player->GetQuestStatus(QUEST_OUR_ONLY_HOPE) == QUEST_STATUS_INCOMPLETE)
        {
            Creature* gymerDummy = go->FindNearestCreature(NPC_GYMER_DUMMY, 20.0f);
            if (gymerDummy)
            {
                player->KilledMonsterCredit(gymerDummy->GetEntry(), gymerDummy->GetGUID());
                gymerDummy->CastSpell(gymerDummy, SPELL_GYMER_LOCK_EXPLOSION, true);
                gymerDummy->DespawnOrUnsummon();
            }
        }
        return true;
    }
};

enum ScourgeDisguiseInstability
{
    SCOURGE_DISGUISE_FAILING_MESSAGE_1       = 28552, // Scourge Disguise Failing! Find a safe place!
    SCOURGE_DISGUISE_FAILING_MESSAGE_2       = 28758, // Scourge Disguise Failing! Run for cover!
    SCOURGE_DISGUISE_FAILING_MESSAGE_3       = 28759, // Scourge Disguise Failing! Hide quickly!
};
std::vector<uint32> const scourgeDisguiseTextIDs = { SCOURGE_DISGUISE_FAILING_MESSAGE_1, SCOURGE_DISGUISE_FAILING_MESSAGE_2, SCOURGE_DISGUISE_FAILING_MESSAGE_3 };

class spell_scourge_disguise_instability : public AuraScript
{
    PrepareAuraScript(spell_scourge_disguise_instability);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SCOURGE_DISGUISE_EXPIRING });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        SetDuration(urand(3 * MINUTE * IN_MILLISECONDS, 5 * MINUTE * IN_MILLISECONDS));
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
        {
            if (Player* player = caster->ToPlayer())
            {
                if (player->HasAnyAuras(SPELL_SCOURGE_DISGUISE, SPELL_SCOURGE_DISGUISE_INSTANT_CAST))
                {
                    uint32 textId = Acore::Containers::SelectRandomContainerElement(scourgeDisguiseTextIDs);
                    player->Unit::Whisper(textId, player, true);
                    player->CastSpell(player, SPELL_SCOURGE_DISGUISE_EXPIRING, true);
                }
            }
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_scourge_disguise_instability::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_scourge_disguise_instability::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 54105 - Blight Fog
class spell_blight_fog : public SpellScript
{
    PrepareSpellScript(spell_blight_fog);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if([](WorldObject* target) -> bool
        {
            float z = target->GetPositionZ();
            bool isInBlightFog = (582.0f <= z && z <= 583.0f) || (586.0f <= z && z <= 587.0f);
            return !isInBlightFog;
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_blight_fog::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

void AddSC_zuldrak()
{
    new npc_finklestein();
    new go_finklestein_cauldron();
    RegisterCreatureAI(npc_overlord_drakuru_betrayal);
    new npc_released_offspring_harkoa();
    new npc_crusade_recruit();
    new go_scourge_enclosure();

    RegisterSpellScript(spell_scourge_disguise_instability);
    RegisterSpellScript(spell_blight_fog);
}
