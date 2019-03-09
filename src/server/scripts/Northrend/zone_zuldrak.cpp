/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "SpellInfo.h"
#include "Vehicle.h"
#include "SpellAuras.h"

// Ours
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
"Frozen Spider Ichor", "Prismatic Mojo", "Raptor Claw"};


class npc_finklestein : public CreatureScript
{
public:
    npc_finklestein() : CreatureScript("npc_finklestein") { }

        struct npc_finklesteinAI : public ScriptedAI
        {
            npc_finklesteinAI(Creature* creature) : ScriptedAI(creature) {}

            std::map<uint64, uint32> questList;

            void ClearPlayerOnTask(uint64 guid)
            {
                std::map<uint64, uint32>::iterator itr = questList.find(guid);
                if (itr != questList.end())
                    questList.erase(itr);
            }

            bool IsPlayerOnTask(uint64 guid)
            {
                std::map<uint64, uint32>::const_iterator itr = questList.find(guid);
                return itr != questList.end();
            }

            void RightClickCauldron(uint64 guid)
            {
                if (questList.empty())
                    return;

                std::map<uint64, uint32>::iterator itr = questList.find(guid);
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
                            StartNextTask(player->GetGUID(), counter+1);
                            return;
                        }
                        else
                            player->KilledMonsterCredit(28248, 0);
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
            void StartNextTask(uint64 playerGUID, uint32 counter)
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
                        me->MonsterTextEmote("Quickly, get me some...", player, true);
                        me->MonsterTextEmote(itemName, player, true);
                        me->CastSpell(player, auraId, true);
                        break;
                    case 2:
                        me->MonsterTextEmote("Find me some...", player, true);
                        me->MonsterTextEmote(itemName, player, true);
                        me->CastSpell(player, auraId, true);
                        break;
                    case 3:
                        me->MonsterTextEmote("I think it needs...", player, true);
                        me->MonsterTextEmote(itemName, player, true);
                        me->CastSpell(player, auraId, true);
                        break;
                    case 4:
                        me->MonsterTextEmote("Alright, now fetch me some...", player, true);
                        me->MonsterTextEmote(itemName, player, true);
                        me->CastSpell(player, auraId, true);
                        break;
                    case 5:
                        me->MonsterTextEmote("Before it thickens, we must add...", player, true);
                        me->MonsterTextEmote(itemName, player, true);
                        me->CastSpell(player, auraId, true);
                        break;
                    case 6:
                        me->MonsterTextEmote("It's thickening! Quickly get me some...", player, true);
                        me->MonsterTextEmote(itemName, player, true);
                        me->CastSpell(player, auraId, true);
                        break;
                }
            }

            uint32 SelectRandomCode(uint32 counter)  { return (counter * 100 + urand(0,23)); }

            uint32 GetTaskCounter(uint32 itemcode)   { return itemcode / 100; }
            uint32 GetTaskAura(uint32 itemcode)      { return AA_AURA_ID[itemcode % 100]; }
            uint32 GetTaskItemEntry(uint32 itemcode) { return AA_ITEM_ENTRY[itemcode % 100]; }
            const char* GetTaskItemName(uint32 itemcode)  { return AA_ITEM_NAME[itemcode % 100]; }

        };

        bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_ALCHEMIST_APPRENTICE)
                if (creature->AI() && CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI()))
                    CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI())->ClearPlayerOnTask(player->GetGUID());

            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

            if (player->GetQuestStatus(QUEST_ALCHEMIST_APPRENTICE) == QUEST_STATUS_INCOMPLETE)
            {
                if (creature->AI() && CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI()))
                    if (!CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI())->IsPlayerOnTask(player->GetGUID()))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "I'm ready to begin. What is the first ingredient you require?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

                player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            }

            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
        {
            player->CLOSE_GOSSIP_MENU();
            if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
            {
                player->CLOSE_GOSSIP_MENU();
                if (creature->AI() && CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI()))
                    CAST_AI(npc_finklestein::npc_finklesteinAI, creature->AI())->StartNextTask(player->GetGUID(), 1);
            }

            return true;
        }

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_finklesteinAI(creature);
    }
};

class go_finklestein_cauldron : public GameObjectScript
{
public:
    go_finklestein_cauldron() : GameObjectScript("go_finklestein_cauldron") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        Creature* finklestein = go->FindNearestCreature(NPC_FINKLESTEIN, 30.0f, true);
        if (finklestein && finklestein->AI())
            CAST_AI(npc_finklestein::npc_finklesteinAI, finklestein->AI())->RightClickCauldron(player->GetGUID());

        return true;
    }
};

enum eFeedinDaGoolz
{
    NPC_DECAYING_GHOUL                          = 28565,
    GO_BOWL                                     = 190656,
};

class npc_feedin_da_goolz : public CreatureScript
{
public:
    npc_feedin_da_goolz() : CreatureScript("npc_feedin_da_goolz") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_feedin_da_goolzAI(creature);
    }

    struct npc_feedin_da_goolzAI : public NullCreatureAI
    {
        npc_feedin_da_goolzAI(Creature* creature) : NullCreatureAI(creature) { findTimer = 1; checkTimer = 0; ghoulFed = 0; }

        uint32 findTimer;
        uint32 checkTimer;
        uint64 ghoulFed;

        void UpdateAI(uint32 diff)
        {
            if (findTimer)
            {
                findTimer += diff;
                if (findTimer >= 1000)
                {
                    if (Creature* ghoul = me->FindNearestCreature(NPC_DECAYING_GHOUL, 30.0f, true))
                    {
                        ghoul->SetReactState(REACT_DEFENSIVE);
                        float o = me->GetAngle(ghoul);
                        ghoul->GetMotionMaster()->MovePoint(1, me->GetPositionX()+2*cos(o), me->GetPositionY()+2*sin(o), me->GetPositionZ());
                        checkTimer = 1;
                        findTimer = 0;
                    }
                    else
                        findTimer = 1;
                }
                return;
            }

            if (checkTimer)
            {
                checkTimer += diff;
                if (checkTimer >= 1500)
                {
                    checkTimer = 1;
                    if (!ghoulFed)
                    {
                        if (Creature* ghoul = me->FindNearestCreature(NPC_DECAYING_GHOUL, 3.0f, true))
                        {
                            ghoulFed = ghoul->GetGUID();
                            ghoul->HandleEmoteCommand(EMOTE_ONESHOT_EAT);
                        }
                    }
                    else
                    {
                        if (GameObject* bowl = me->FindNearestGameObject(GO_BOWL, 10.0f))
                            bowl->Delete();

                        if (Creature* ghoul = ObjectAccessor::GetCreature(*me, ghoulFed))
                        {
                            ghoul->SetReactState(REACT_AGGRESSIVE);
                            ghoul->GetMotionMaster()->MoveTargetedHome();
                        }

                        if (Unit* owner = me->ToTempSummon()->GetSummoner())
                            if (Player* player = owner->ToPlayer())
                                player->KilledMonsterCredit(me->GetEntry(), 0);

                        me->DespawnOrUnsummon(1);
                    }
                }
            }
        }
    };
};

enum overlordDrakuru
{
    SPELL_SHADOW_BOLT                   = 54113,
    SPELL_SCOURGE_DISGUISE_EXPIRING     = 52010,
    SPELL_THROW_BRIGHT_CRYSTAL          = 54087,
    SPELL_TELEPORT_EFFECT               = 52096,
    SPELL_SCOURGE_DISGUISE              = 51966,
    SPELL_BLIGHT_FOG                    = 54104,
    SPELL_THROW_PORTAL_CRYSTAL          = 54209,
    SPELL_ARTHAS_PORTAL                 = 51807,
    SPELL_TOUCH_OF_DEATH                = 54236,
    SPELL_DRAKURU_DEATH                 = 54248,
    SPELL_SUMMON_SKULL                  = 54253,

    QUEST_BETRAYAL                      = 12713,

    NPC_BLIGHTBLOOD_TROLL               = 28931,
    NPC_LICH_KING                       = 28498,

    EVENT_BETRAYAL_1                    = 1,
    EVENT_BETRAYAL_2                    = 2,
    EVENT_BETRAYAL_3                    = 3,
    EVENT_BETRAYAL_4                    = 4,
    EVENT_BETRAYAL_5                    = 5,
    EVENT_BETRAYAL_6                    = 6,
    EVENT_BETRAYAL_7                    = 7,
    EVENT_BETRAYAL_8                    = 8,
    EVENT_BETRAYAL_9                    = 9,
    EVENT_BETRAYAL_10                   = 10,
    EVENT_BETRAYAL_11                   = 11,
    EVENT_BETRAYAL_12                   = 12,
    EVENT_BETRAYAL_13                   = 13,
    EVENT_BETRAYAL_14                   = 14,
    EVENT_BETRAYAL_SHADOW_BOLT          = 20,
    EVENT_BETRAYAL_CRYSTAL              = 21,
    EVENT_BETRAYAL_COMBAT_TALK          = 22,

    SAY_DRAKURU_0                       = 0,
    SAY_DRAKURU_1                       = 1,
    SAY_DRAKURU_2                       = 2,
    SAY_DRAKURU_3                       = 3,
    SAY_DRAKURU_4                       = 4,
    SAY_DRAKURU_5                       = 5,
    SAY_DRAKURU_6                       = 6,
    SAY_DRAKURU_7                       = 7,
    SAY_LICH_7                          = 7,
    SAY_LICH_8                          = 8,
    SAY_LICH_9                          = 9,
    SAY_LICH_10                         = 10,
    SAY_LICH_11                         = 11,
    SAY_LICH_12                         = 12,
};

class npc_overlord_drakuru_betrayal : public CreatureScript
{
public:
    npc_overlord_drakuru_betrayal() : CreatureScript("npc_overlord_drakuru_betrayal") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_overlord_drakuru_betrayalAI(creature);
    }

    struct npc_overlord_drakuru_betrayalAI : public ScriptedAI
    {
        npc_overlord_drakuru_betrayalAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
        }

        EventMap events;
        SummonList summons;
        uint64 playerGUID;
        uint64 lichGUID;

        void EnterEvadeMode()
        {
            if (playerGUID)
                if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                    if (player->IsWithinDistInMap(me, 80))
                        return;
            me->setFaction(974);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            ScriptedAI::EnterEvadeMode();
        }

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            playerGUID = 0;
            lichGUID = 0;
            me->setFaction(974);
            me->SetVisible(false);
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
            {
                if (playerGUID)
                {
                    if (who->GetGUID() != playerGUID)
                    {
                        Player* player = ObjectAccessor::GetPlayer(*me, playerGUID);
                        if (player && player->IsWithinDistInMap(me, 80))
                            who->ToPlayer()->NearTeleportTo(6143.76f, -1969.7f, 417.57f, 2.08f);
                        else
                        {
                            EnterEvadeMode();
                            return;
                        }
                    }
                    else
                        ScriptedAI::MoveInLineOfSight(who);
                }
                else if (who->ToPlayer()->GetQuestStatus(QUEST_BETRAYAL) == QUEST_STATUS_INCOMPLETE && who->HasAura(SPELL_SCOURGE_DISGUISE))
                {
                    me->SetVisible(true);
                    playerGUID = who->GetGUID();
                    events.ScheduleEvent(EVENT_BETRAYAL_1, 5000);
                }
            }
            else
                ScriptedAI::MoveInLineOfSight(who);
        }

        void JustSummoned(Creature* cr)
        {
            summons.Summon(cr);
            if (cr->GetEntry() == NPC_BLIGHTBLOOD_TROLL)
                cr->CastSpell(cr, SPELL_TELEPORT_EFFECT, true);
            else
            {
                me->SetFacingToObject(cr);
                lichGUID = cr->GetGUID();
                float o = me->GetAngle(cr);
                cr->GetMotionMaster()->MovePoint(0, me->GetPositionX()+cos(o)*6.0f, me->GetPositionY()+sin(o)*6.0f, me->GetPositionZ());
            }
        }

        void EnterCombat(Unit*)
        {
            Talk(SAY_DRAKURU_3);
            events.ScheduleEvent(EVENT_BETRAYAL_SHADOW_BOLT, 2000);
            events.ScheduleEvent(EVENT_BETRAYAL_CRYSTAL, 5000);
            events.ScheduleEvent(EVENT_BETRAYAL_COMBAT_TALK, 20000);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (damage >= me->GetHealth() && !me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE))
            {
                damage = 0;
                me->RemoveAllAuras();
                me->CombatStop();
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->setFaction(35);
                events.Reset();
                events.ScheduleEvent(EVENT_BETRAYAL_4, 1000);
            }
        }

        void SpellHitTarget(Unit* target, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_THROW_PORTAL_CRYSTAL)
                if (Aura* aura = target->AddAura(SPELL_ARTHAS_PORTAL, target))
                    aura->SetDuration(48000);
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
        {
            if (spellInfo->Id == SPELL_TOUCH_OF_DEATH)
            {
                me->CastSpell(me, SPELL_DRAKURU_DEATH, true);
                me->CastSpell(me, SPELL_SUMMON_SKULL, true);
            }
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);
            switch (events.GetEvent())
            {
                case EVENT_BETRAYAL_1:
                    Talk(SAY_DRAKURU_0);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_BETRAYAL_2, 5000);
                    break;
                case EVENT_BETRAYAL_2:
                    me->SummonCreature(NPC_BLIGHTBLOOD_TROLL, 6184.1f, -1969.9f, 586.76f, 4.5f);
                    me->SummonCreature(NPC_BLIGHTBLOOD_TROLL, 6222.9f, -2026.5f, 586.76f, 2.9f);
                    me->SummonCreature(NPC_BLIGHTBLOOD_TROLL, 6166.2f, -2065.4f, 586.76f, 1.4f);
                    me->SummonCreature(NPC_BLIGHTBLOOD_TROLL, 6127.5f, -2008.7f, 586.76f, 0.0f);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_BETRAYAL_3, 5000);
                    break;
                case EVENT_BETRAYAL_3:
                    Talk(SAY_DRAKURU_1);
                    Talk(SAY_DRAKURU_2);
                    if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                        player->CastSpell(player, SPELL_SCOURGE_DISGUISE_EXPIRING, true);
                    if (Aura* aur = me->AddAura(SPELL_BLIGHT_FOG, me))
                        aur->SetDuration(22000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_4:
                    Talk(SAY_DRAKURU_5);
                    events.ScheduleEvent(EVENT_BETRAYAL_5, 6000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_5:
                    Talk(SAY_DRAKURU_6);
                    me->CastSpell(me, SPELL_THROW_PORTAL_CRYSTAL, true);
                    events.ScheduleEvent(EVENT_BETRAYAL_6, 8000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_6:
                    me->SummonCreature(NPC_LICH_KING, 6142.9f, -2011.6f, 590.86f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 41000);
                    events.ScheduleEvent(EVENT_BETRAYAL_7, 8000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_7:
                    Talk(SAY_DRAKURU_7);
                    events.ScheduleEvent(EVENT_BETRAYAL_8, 5000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_8:
                    if (Creature* lich = ObjectAccessor::GetCreature(*me, lichGUID))
                        lich->AI()->Talk(SAY_LICH_7);
                    events.ScheduleEvent(EVENT_BETRAYAL_9, 6000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_9:
                    if (Creature* lich = ObjectAccessor::GetCreature(*me, lichGUID))
                    {
                        lich->AI()->Talk(SAY_LICH_8);
                        lich->CastSpell(me, SPELL_TOUCH_OF_DEATH, false);
                    }
                    events.ScheduleEvent(EVENT_BETRAYAL_10, 4000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_10:
                    me->SetVisible(false);
                    if (Creature* lich = ObjectAccessor::GetCreature(*me, lichGUID))
                        lich->AI()->Talk(SAY_LICH_9);
                    events.ScheduleEvent(EVENT_BETRAYAL_11, 4000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_11:
                    if (Creature* lich = ObjectAccessor::GetCreature(*me, lichGUID))
                        lich->AI()->Talk(SAY_LICH_10);
                    events.ScheduleEvent(EVENT_BETRAYAL_12, 6000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_12:
                    if (Creature* lich = ObjectAccessor::GetCreature(*me, lichGUID))
                        lich->AI()->Talk(SAY_LICH_11);
                    events.ScheduleEvent(EVENT_BETRAYAL_13, 3000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_13:
                    if (Creature* lich = ObjectAccessor::GetCreature(*me, lichGUID))
                    {
                        lich->AI()->Talk(SAY_LICH_12);
                        lich->GetMotionMaster()->MovePoint(0, 6143.8f, -2011.5f, 590.9f);
                    }
                    events.ScheduleEvent(EVENT_BETRAYAL_14, 7000);
                    events.PopEvent();
                    break;
                case EVENT_BETRAYAL_14:
                    playerGUID = 0;
                    EnterEvadeMode();
                    break;
                    
            }

            if (me->getFaction() == 35 || me->HasUnitState(UNIT_STATE_CASTING|UNIT_STATE_STUNNED))
                return;

            if (!UpdateVictim())
                return;

            switch (events.GetEvent())
            {
                case EVENT_BETRAYAL_SHADOW_BOLT:
                    if (!me->IsWithinMeleeRange(me->GetVictim()))
                        me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    events.RepeatEvent(2000);
                    break;
                case EVENT_BETRAYAL_CRYSTAL:
                    if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                        me->CastSpell(player, SPELL_THROW_BRIGHT_CRYSTAL, true);
                    events.RepeatEvent(urand(6000, 15000));
                    break;
                case EVENT_BETRAYAL_COMBAT_TALK:
                    Talk(SAY_DRAKURU_4);
                    events.RepeatEvent(20000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

/*####
## npc_drakuru_shackles
####*/

enum DrakuruShackles
{
    NPC_RAGECLAW                             = 29686,
    QUEST_TROLLS_IS_GONE_CRAZY               = 12861,
    SPELL_LEFT_CHAIN                         = 59951,
    SPELL_RIGHT_CHAIN                        = 59952,
    SPELL_UNLOCK_SHACKLE                     = 55083,
    SPELL_FREE_RAGECLAW                      = 55223
};

class npc_drakuru_shackles : public CreatureScript
{
public:
    npc_drakuru_shackles() : CreatureScript("npc_drakuru_shackles") { }

    struct npc_drakuru_shacklesAI : public NullCreatureAI
    {
        npc_drakuru_shacklesAI(Creature* creature) : NullCreatureAI(creature)
        {
            _rageclawGUID = 0;
            timer = 0;
        }

        void Reset()
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }

        void UpdateAI(uint32 diff)
        {
            timer += diff;
            if (timer >= 2000)
            {
                timer = 0;
                if (_rageclawGUID)
                    return;

                if (Creature* cr = me->FindNearestCreature(NPC_RAGECLAW, 10.0f))
                {
                    _rageclawGUID = cr->GetGUID();
                    LockRageclaw(cr);
                }
            }
        }

        void LockRageclaw(Creature* rageclaw)
        {
            // pointer check not needed
            me->SetFacingToObject(rageclaw);
            rageclaw->SetFacingToObject(me);

            DoCast(rageclaw, SPELL_LEFT_CHAIN, true);
            DoCast(rageclaw, SPELL_RIGHT_CHAIN, true);
        }

        void UnlockRageclaw(Unit*  /*who*/, Creature* rageclaw)
        {
            // pointer check not needed
            DoCast(rageclaw, SPELL_FREE_RAGECLAW, true);
            _rageclawGUID = 0;
            me->DespawnOrUnsummon(1);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_UNLOCK_SHACKLE)
            {
                if (caster->ToPlayer()->GetQuestStatus(QUEST_TROLLS_IS_GONE_CRAZY) == QUEST_STATUS_INCOMPLETE)
                {
                    if (Creature* rageclaw = ObjectAccessor::GetCreature(*me, _rageclawGUID))
                    {
                        UnlockRageclaw(caster, rageclaw);
                        caster->ToPlayer()->KilledMonster(rageclaw->GetCreatureTemplate(), _rageclawGUID);
                        me->DespawnOrUnsummon();
                    }
                    else
                        me->setDeathState(JUST_DIED);
                }
            }
        }

        private:
            uint64 _rageclawGUID;
            uint32 timer;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_drakuru_shacklesAI(creature);
    }
};

/*####
## npc_captured_rageclaw
####*/

enum Rageclaw
{
    SPELL_UNSHACKLED                         = 55085,
    SPELL_KNEEL                              = 39656,
    SAY_RAGECLAW                             = 0
};

class npc_captured_rageclaw : public CreatureScript
{
public:
    npc_captured_rageclaw() : CreatureScript("npc_captured_rageclaw") { }

    struct npc_captured_rageclawAI : public NullCreatureAI
    {
        npc_captured_rageclawAI(Creature* creature) : NullCreatureAI(creature) { }

        void Reset()
        {
            me->setFaction(35);
            DoCast(me, SPELL_KNEEL, true); // Little Hack for kneel - Thanks Illy :P
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_FREE_RAGECLAW)
            {
                me->RemoveAurasDueToSpell(SPELL_LEFT_CHAIN);
                me->RemoveAurasDueToSpell(SPELL_RIGHT_CHAIN);
                me->RemoveAurasDueToSpell(SPELL_KNEEL);
                me->setFaction(me->GetCreatureTemplate()->faction);
                DoCast(me, SPELL_UNSHACKLED, true);
                Talk(SAY_RAGECLAW);
                me->GetMotionMaster()->MoveRandom(10);
                me->DespawnOrUnsummon(10000);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_captured_rageclawAI(creature);
    }
};


// Theirs
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

        void Reset()
        {
            float x, y, z;
            me->GetClosePoint(x, y, z, me->GetObjectSize() / 3, 25.0f);
            me->GetMotionMaster()->MovePoint(0, x, y, z);
        }

        void MovementInform(uint32 Type, uint32 /*uiId*/)
        {
            if (Type != POINT_MOTION_TYPE)
                return;
            me->DespawnOrUnsummon();
        }
    };

    CreatureAI* GetAI(Creature* creature) const
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

        void Reset()
        {
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_COWER);
            _heading = me->GetOrientation();
        }

        void UpdateAI(uint32 diff)
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_RECRUIT_1:
                        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                        Talk(SAY_RECRUIT);
                        _events.ScheduleEvent(EVENT_RECRUIT_2, 3000);
                        break;
                    case EVENT_RECRUIT_2:
                        me->SetWalk(true);
                        me->GetMotionMaster()->MovePoint(0, me->GetPositionX() + (cos(_heading) * 10), me->GetPositionY() + (sin(_heading) * 10), me->GetPositionZ());
                        me->DespawnOrUnsummon(5000);
                        break;
                    default:
                        break;
                }
            }

            if (!UpdateVictim())
                return;
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/)
        {
            _events.ScheduleEvent(EVENT_RECRUIT_1, 100);
            player->CLOSE_GOSSIP_MENU();
            me->CastSpell(player, SPELL_QUEST_CREDIT, true);
            me->SetFacingToObject(player);
        }

        private:
        EventMap _events;
        float    _heading; // Store creature heading
    };

    CreatureAI* GetAI(Creature* creature) const
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

    bool OnGossipHello(Player* player, GameObject* go)
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



enum StormCloud
{
    STORM_COULD         = 29939,
    HEALING_WINDS       = 55549,
    STORM_VISUAL        = 55708,
    GYMERS_GRAB         = 55516,
    RIDE_VEHICLE        = 43671
};

class npc_storm_cloud : public CreatureScript
{
public:
    npc_storm_cloud() : CreatureScript("npc_storm_cloud") { }

    struct npc_storm_cloudAI : public ScriptedAI
    {
        npc_storm_cloudAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset()
        {
            me->CastSpell(me, STORM_VISUAL, true);
        }

        void JustRespawned()
        {
            Reset();
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (spell->Id != GYMERS_GRAB)
                return;

            if (Vehicle* veh = caster->GetVehicleKit())
                if (veh->GetAvailableSeatCount() != 0)
            {
                me->CastSpell(caster, RIDE_VEHICLE, true);
                me->CastSpell(caster, HEALING_WINDS, true);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_storm_cloudAI(creature);
    }
};

void AddSC_zuldrak()
{
    // Ours
    new npc_finklestein();
    new go_finklestein_cauldron();
    new npc_feedin_da_goolz();
    new npc_overlord_drakuru_betrayal();
    new npc_drakuru_shackles();
    new npc_captured_rageclaw();

    // Theirs
    new npc_released_offspring_harkoa();
    new npc_crusade_recruit();
    new go_scourge_enclosure();
    new npc_storm_cloud();
}
