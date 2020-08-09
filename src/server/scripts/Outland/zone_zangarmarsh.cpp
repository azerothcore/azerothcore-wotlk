/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Zangarmarsh
SD%Complete: 100
SDComment: Quest support: 9752, 9785, 9803, 10009. Mark Of ... buffs.
SDCategory: Zangarmarsh
EndScriptData */

/* ContentData
npcs_ashyen_and_keleth
npc_cooshcoosh
npc_elder_kuruti
npc_mortog_steamhead
npc_kayra_longmane
npc_timothy_daniels
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "WorldSession.h"

// Ours
enum eNaturalist
{
    SPELL_MARK_OF_BITE          = 34906,
    GO_CAGE_ENTRY               = 182094,
};

class npc_natrualist_bite : public CreatureScript
{
public:
    npc_natrualist_bite() : CreatureScript("npc_natrualist_bite") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        uint32 menuId = creature->AI()->GetData(1) ? 7540 : 7520;
        player->PrepareGossipMenu(creature, menuId, false);
        player->SendPreparedGossip(creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32  /*action*/) override
    {
        ClearGossipMenuFor(player);
        CloseGossipMenuFor(player);
        if (creature->AI()->GetData(1))
        {
            creature->CastSpell(player, SPELL_MARK_OF_BITE, true);
            player->KilledMonsterCredit(creature->GetEntry(), 0);
            creature->DespawnOrUnsummon(1000);
        }
        else
        {
            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
            Creature* cr;
            if ((cr = creature->SummonCreature(17957, -186, -790, 43.8f, 4.2f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                cr->AI()->AttackStart(creature);
            if ((cr = creature->SummonCreature(17960, -188, -783, 43.8f, 4.2f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                cr->AI()->AttackStart(player);
            if ((cr = creature->SummonCreature(17957, -196, -783, 43.8f, 4.4f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000)))
                cr->AI()->AttackStart(player);
            GameObject* cage = creature->FindNearestGameObject(GO_CAGE_ENTRY, 20.0f);
            if (cage)
                cage->SetGoState(GO_STATE_ACTIVE);
            creature->SetHomePosition(-195.39f, -795.91f, 43.8f, 1.0f);
            creature->AI()->Talk(1);
        }
        return true;
    }

    struct npc_natrualist_biteAI : public ScriptedAI
    {
        npc_natrualist_biteAI(Creature* creature) : ScriptedAI(creature)
        {
            _spoken = 0;
        }

        uint8 _spoken;

        void MoveInLineOfSight(Unit* who) override
        {
            if (!_spoken && !me->IsHostileTo(who))
            {
                _spoken = 1;
                Talk(0);
            }
            ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterCombat(Unit*) override
        { 
            _spoken = 2; 
        }

        uint32 GetData(uint32) const override 
        { 
            return _spoken == 2; 
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_natrualist_biteAI (creature);
    }
};


// Theirs
/*######
## npcs_ashyen_and_keleth
######*/

#define GOSSIP_ITEM_BLESS_ASH     "Grant me your mark, wise ancient."
#define GOSSIP_ITEM_BLESS_KEL     "Grant me your mark, mighty ancient."

enum AshyenAndKeleth
{
    GOSSIP_REWARD_BLESS         = 0,

    NPC_ASHYEN                  = 17900,
    NPC_KELETH                  = 17901,

    SPELL_BLESS_ASH_EXA         = 31815,
    SPELL_BLESS_ASH_REV         = 31811,
    SPELL_BLESS_ASH_HON         = 31810,
    SPELL_BLESS_ASH_FRI         = 31808,

    SPELL_BLESS_KEL_EXA         = 31814,
    SPELL_BLESS_KEL_REV         = 31813,
    SPELL_BLESS_KEL_HON         = 31812,
    SPELL_BLESS_KEL_FRI         = 31807
};

class npcs_ashyen_and_keleth : public CreatureScript
{
public:
    npcs_ashyen_and_keleth() : CreatureScript("npcs_ashyen_and_keleth") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetReputationRank(942) > REP_NEUTRAL)
        {
            if (creature->GetEntry() == NPC_ASHYEN)
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_BLESS_ASH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

            if (creature->GetEntry() == NPC_KELETH)
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_BLESS_KEL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
        }
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF+1)
        {
            creature->setPowerType(POWER_MANA);
            creature->SetMaxPower(POWER_MANA, 200);             //set a "fake" mana value, we can't depend on database doing it in this case
            creature->SetPower(POWER_MANA, 200);

            if (creature->GetEntry() == NPC_ASHYEN)                //check which Creature we are dealing with
            {
                uint32 spell = 0;
                switch (player->GetReputationRank(942))
                {                                               //mark of lore
                    case REP_FRIENDLY:
                        spell = SPELL_BLESS_ASH_FRI;
                        break;
                    case REP_HONORED:
                        spell = SPELL_BLESS_ASH_HON;
                        break;
                    case REP_REVERED:
                        spell = SPELL_BLESS_ASH_REV;
                        break;
                    case REP_EXALTED:
                        spell = SPELL_BLESS_ASH_EXA;
                        break;
                    default:
                        break;
                }

                if (spell)
                {
                    creature->CastSpell(player, spell, true);
                    creature->AI()->Talk(GOSSIP_REWARD_BLESS);
                }
            }

            if (creature->GetEntry() == NPC_KELETH)
            {
                uint32 spell = 0;
                switch (player->GetReputationRank(942))         //mark of war
                {
                    case REP_FRIENDLY:
                        spell = SPELL_BLESS_KEL_FRI;
                        break;
                    case REP_HONORED:
                        spell = SPELL_BLESS_KEL_HON;
                        break;
                    case REP_REVERED:
                        spell = SPELL_BLESS_KEL_REV;
                        break;
                    case REP_EXALTED:
                        spell = SPELL_BLESS_KEL_EXA;
                        break;
                    default:
                        break;
                }

                if (spell)
                {
                    creature->CastSpell(player, spell, true);
                    creature->AI()->Talk(GOSSIP_REWARD_BLESS);
                }
            }
            CloseGossipMenuFor(player);
            player->TalkedToCreature(creature->GetEntry(), creature->GetGUID());
        }
        return true;
    }
};

/*######
## npc_cooshcoosh
######*/

#define GOSSIP_COOSH            "You owe Sim'salabim money. Hand them over or die!"

enum Cooshhooosh
{
    SPELL_LIGHTNING_BOLT    = 9532,
    QUEST_CRACK_SKULLS      = 10009,
    FACTION_HOSTILE_CO      = 45
};

class npc_cooshcoosh : public CreatureScript
{
public:
    npc_cooshcoosh() : CreatureScript("npc_cooshcoosh") { }

    struct npc_cooshcooshAI : public ScriptedAI
    {
        npc_cooshcooshAI(Creature* creature) : ScriptedAI(creature)
        {
            m_uiNormFaction = creature->getFaction();
        }

        uint32 m_uiNormFaction;
        uint32 LightningBolt_Timer;

        void Reset() override
        {
            LightningBolt_Timer = 2000;
            if (me->getFaction() != m_uiNormFaction)
                me->setFaction(m_uiNormFaction);
        }

        void EnterCombat(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (LightningBolt_Timer <= diff)
            {
                DoCastVictim(SPELL_LIGHTNING_BOLT);
                LightningBolt_Timer = 5000;
            } else LightningBolt_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_cooshcooshAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(QUEST_CRACK_SKULLS) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_COOSH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        SendGossipMenuFor(player, 9441, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF)
        {
            CloseGossipMenuFor(player);
            creature->setFaction(FACTION_HOSTILE_CO);
            creature->AI()->AttackStart(player);
        }
        return true;
    }
};

/*######
## npc_elder_kuruti
######*/

#define GOSSIP_ITEM_KUR1 "Greetings, elder. It is time for your people to end their hostility towards the draenei and their allies."
#define GOSSIP_ITEM_KUR2 "I did not mean to deceive you, elder. The draenei of Telredor thought to approach you in a way that would seem familiar to you."
#define GOSSIP_ITEM_KUR3 "I will tell them. Farewell, elder."

class npc_elder_kuruti : public CreatureScript
{
public:
    npc_elder_kuruti() : CreatureScript("npc_elder_kuruti") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (player->GetQuestStatus(9803) == QUEST_STATUS_INCOMPLETE)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_KUR1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        SendGossipMenuFor(player, 9226, creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_KUR2, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, 9227, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ITEM_KUR3, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(player, 9229, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
            {
                if (!player->HasItemCount(24573))
                {
                    ItemPosCountVec dest;
                    uint32 itemId = 24573;
                    InventoryResult msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, itemId, 1, nullptr);
                    if (msg == EQUIP_ERR_OK)
                    {
                        player->StoreNewItem(dest, itemId, true);
                    }
                    else
                        player->SendEquipError(msg, nullptr, nullptr, itemId);
                }
                SendGossipMenuFor(player, 9231, creature->GetGUID());
                break;
            }
        }
        return true;
    }
};

/*######
## npc_mortog_steamhead
######*/
class npc_mortog_steamhead : public CreatureScript
{
public:
    npc_mortog_steamhead() : CreatureScript("npc_mortog_steamhead") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsVendor() && player->GetReputationRank(942) == REP_EXALTED)
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_TRADE)
            player->GetSession()->SendListInventory(creature->GetGUID());
        return true;
    }
};

/*######
## npc_kayra_longmane
######*/

enum Kayra
{
    SAY_START           = 0,
    SAY_AMBUSH1         = 1,
    SAY_PROGRESS        = 2,
    SAY_AMBUSH2         = 3,
    SAY_END             = 4,

    QUEST_ESCAPE_FROM   = 9752,
    NPC_SLAVEBINDER     = 18042
};

class npc_kayra_longmane : public CreatureScript
{
public:
    npc_kayra_longmane() : CreatureScript("npc_kayra_longmane") { }

    struct npc_kayra_longmaneAI : public npc_escortAI
    {
        npc_kayra_longmaneAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset() { }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 4:
                    Talk(SAY_AMBUSH1, player);
                    DoSpawnCreature(NPC_SLAVEBINDER, -10.0f, -5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_SLAVEBINDER, -8.0f, 5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 5:
                    Talk(SAY_PROGRESS, player);
                    SetRun();
                    break;
                case 16:
                    Talk(SAY_AMBUSH2, player);
                    DoSpawnCreature(NPC_SLAVEBINDER, -10.0f, -5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    DoSpawnCreature(NPC_SLAVEBINDER, -8.0f, 5.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                    break;
                case 17:
                    SetRun(false);
                    break;
                case 25:
                    Talk(SAY_END, player);
                    player->GroupEventHappens(QUEST_ESCAPE_FROM, me);
                    break;
            }
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_ESCAPE_FROM)
        {
            creature->AI()->Talk(SAY_START, player);

            if (npc_escortAI* pEscortAI = CAST_AI(npc_kayra_longmane::npc_kayra_longmaneAI, creature->AI()))
                pEscortAI->Start(false, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_kayra_longmaneAI(creature);
    }
};

/*######
## npc_timothy_daniels
######*/

#define GOSSIP_TIMOTHY_DANIELS_ITEM1    "Specialist, eh? Just what kind of specialist are you, anyway?"
#define GOSSIP_TEXT_BROWSE_POISONS      "Let me browse your reagents and poison supplies."

enum Timothy
{
    GOSSIP_TEXTID_TIMOTHY_DANIELS1      = 9239
};

class npc_timothy_daniels : public CreatureScript
{
public:
    npc_timothy_daniels() : CreatureScript("npc_timothy_daniels") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->IsVendor())
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_POISONS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_TIMOTHY_DANIELS_ITEM1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                SendGossipMenuFor(player, GOSSIP_TEXTID_TIMOTHY_DANIELS1, creature->GetGUID());
                break;
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
        }

        return true;
    }
};

/*######
## AddSC
######*/

void AddSC_zangarmarsh()
{
    // Ours
    new npc_natrualist_bite();

    // Theris
    new npcs_ashyen_and_keleth();
    new npc_cooshcoosh();
    new npc_elder_kuruti();
    new npc_mortog_steamhead();
    new npc_kayra_longmane();
    new npc_timothy_daniels();
}
