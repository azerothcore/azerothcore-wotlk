/*
 * Progressive NPCs
 * Enhanced NPCs with dynamic behaviors, dialogue, and progressive system integration
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Creature.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "WorldSessionMgr.h"
#include <sstream>
#include <iomanip>
#include <vector>

// ============================================================
// PROGRESSIVE MERCHANT NPC
// Sells items based on player's progression tier
// ============================================================
class npc_progressive_merchant : public CreatureScript
{
public:
    npc_progressive_merchant() : CreatureScript("npc_progressive_merchant") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);
        
        // Get player's progression data
        uint32 guid = player->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT current_tier, progression_points, prestige_level FROM character_progression_unified WHERE guid = {}", guid);
        
        uint8 currentTier = 1;
        uint64 progressionPoints = 0;
        uint32 prestigeLevel = 0;
        
        if (result)
        {
            Field* fields = result->Fetch();
            currentTier = fields[0].Get<uint8>();
            progressionPoints = fields[1].Get<uint64>();
            prestigeLevel = fields[2].Get<uint32>();
        }
        
        // Dynamic greeting based on progression
        std::ostringstream greeting;
        greeting << "|TInterface\\Icons\\INV_Misc_Coin_01:30|t |cFF00FFFFProgressive Merchant|r\n\n";
        greeting << "|cFFAAAAFFCurrent Tier:|r " << (int)currentTier << "\n";
        greeting << "|cFFAAAAFFProgression Points:|r " << progressionPoints << "\n";
        greeting << "|cFFAAAAFFPrestige Level:|r " << prestigeLevel << "\n\n";
        
        if (currentTier >= 10)
            greeting << "|cFF00FF00Welcome, Master!|r\n";
        else if (currentTier >= 5)
            greeting << "|cFFFFFF00You're making great progress!|r\n";
        else
            greeting << "|cFFFF0000Keep pushing forward!|r\n";
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, greeting.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_VENDOR, "|TInterface\\Icons\\INV_Box_01:20|t Browse Items", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\INV_Misc_QuestionMark:20|t What can I buy?", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        
        if (action == GOSSIP_ACTION_TRADE)
        {
            player->GetSession()->SendListInventory(creature->GetGUID());
            return true;
        }
        
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            std::ostringstream info;
            info << "|cFF00FFFFAvailable Items:|r\n\n";
            info << "|cFF00FF00Tier 1-5:|r Basic consumables\n";
            info << "|cFFFFFF00Tier 6-10:|r Enhanced items\n";
            info << "|cFFFF0000Tier 11+:|r Legendary items\n\n";
            info << "Items unlock as you progress!";
            
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, info.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Ability_Repair:20|t Back", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
            return true;
        }
        
        OnGossipHello(player, creature);
        return true;
    }
};

// ============================================================
// PROGRESSIVE TRAINER NPC
// Teaches abilities based on progression tier
// ============================================================
class npc_progressive_trainer : public CreatureScript
{
public:
    npc_progressive_trainer() : CreatureScript("npc_progressive_trainer") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);
        
        uint32 guid = player->GetGUID().GetCounter();
        QueryResult result = CharacterDatabase.Query(
            "SELECT current_tier FROM character_progression_unified WHERE guid = {}", guid);
        
        uint8 currentTier = 1;
        if (result)
            currentTier = result->Fetch()[0].Get<uint8>();
        
        std::ostringstream greeting;
        greeting << "|TInterface\\Icons\\Ability_Mage_StudentOfTheMind:30|t |cFF00FFFFProgressive Trainer|r\n\n";
        greeting << "|cFFAAAAFFYour Tier:|r " << (int)currentTier << "\n\n";
        
        if (currentTier >= 5)
            greeting << "|cFF00FF00You've unlocked advanced training!|r\n";
        else
            greeting << "|cFFFF0000Reach Tier 5 for advanced abilities!|r\n";
        
        AddGossipItemFor(player, GOSSIP_ICON_TRAINER, greeting.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "|TInterface\\Icons\\Spell_ChargePositive:20|t Train Me", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        if (action == GOSSIP_ACTION_TRAIN)
        {
            player->GetSession()->SendTrainerList(creature->GetGUID());
            return true;
        }
        
        OnGossipHello(player, creature);
        return true;
    }
};

// ============================================================
// PROGRESSIVE STATUE NPC
// Displays leaderboard and player statistics
// ============================================================
class npc_progressive_statue : public CreatureScript
{
public:
    npc_progressive_statue() : CreatureScript("npc_progressive_statue") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);
        
        // Get top players
        QueryResult topPlayers = CharacterDatabase.Query(
            "SELECT guid, progression_points, current_tier, prestige_level FROM character_progression_unified "
            "ORDER BY progression_points DESC LIMIT 10");
        
        std::ostringstream greeting;
        greeting << "|TInterface\\Icons\\Achievement_Leader_Horde:30|t |cFF00FFFFProgression Leaderboard|r\n\n";
        greeting << "|cFF00FF00Top Players:|r\n\n";
        
        if (topPlayers)
        {
            uint8 rank = 1;
            do
            {
                Field* fields = topPlayers->Fetch();
                uint32 guid = fields[0].Get<uint32>();
                uint64 points = fields[1].Get<uint64>();
                uint8 tier = fields[2].Get<uint8>();
                uint32 prestige = fields[3].Get<uint32>();
                
                // Get player name
                QueryResult nameResult = CharacterDatabase.Query(
                    "SELECT name FROM characters WHERE guid = {}", guid);
                std::string playerName = "Unknown";
                if (nameResult)
                    playerName = nameResult->Fetch()[0].Get<std::string>();
                
                greeting << "|cFFFFFF00#" << (int)rank << "|r " << playerName << "\n";
                greeting << "  Points: " << points << " | Tier: " << (int)tier << " | Prestige: " << prestige << "\n\n";
                
                rank++;
            } while (topPlayers->NextRow() && rank <= 10);
        }
        else
        {
            greeting << "|cFFFF0000No players yet!|r\n";
        }
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, greeting.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "|TInterface\\Icons\\Ability_Repair:20|t Refresh", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            OnGossipHello(player, creature);
            return true;
        }
        
        OnGossipHello(player, creature);
        return true;
    }
};

// ============================================================
// PROGRESSIVE ANNOUNCER NPC
// Announces world events and achievements
// ============================================================
class npc_progressive_announcer : public CreatureScript
{
public:
    npc_progressive_announcer() : CreatureScript("npc_progressive_announcer") { }

    struct npc_progressive_announcerAI : public ScriptedAI
    {
        npc_progressive_announcerAI(Creature* creature) : ScriptedAI(creature)
        {
            _announceTimer = 300000; // 5 minutes
        }

        void UpdateAI(uint32 diff) override
        {
            if (_announceTimer <= diff)
            {
                // Announce random progression tips
                std::vector<std::string> tips = {
                    "|cFF00FF00Tip:|r Complete dungeons on higher difficulties for better rewards!",
                    "|cFF00FF00Tip:|r Upgrade your items to increase your power level!",
                    "|cFF00FF00Tip:|r Prestige to gain permanent bonuses!",
                    "|cFF00FF00Tip:|r Join a guild for guild progression bonuses!",
                    "|cFF00FF00Tip:|r Daily challenges offer bonus progression points!"
                };
                
                if (!tips.empty())
                {
                    uint32 randomTip = urand(0, tips.size() - 1);
                    sWorldSessionMgr->SendServerMessage(SERVER_MSG_STRING, tips[randomTip]);
                }
                
                _announceTimer = 300000; // Reset timer
            }
            else
                _announceTimer -= diff;
        }

    private:
        uint32 _announceTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_progressive_announcerAI(creature);
    }
};

// ============================================================
// PROGRESSIVE PORTAL MASTER
// Teleports players to progressive content areas
// ============================================================
class npc_progressive_portal_master : public CreatureScript
{
public:
    npc_progressive_portal_master() : CreatureScript("npc_progressive_portal_master") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);
        
        std::ostringstream greeting;
        greeting << "|TInterface\\Icons\\Spell_Arcane_TeleportDalaran:30|t |cFF00FFFFPortal Master|r\n\n";
        greeting << "|cFFAAAAFFI can teleport you to various locations!|r\n";
        
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, greeting.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        AddGossipItemFor(player, GOSSIP_ICON_TAXI, "|TInterface\\Icons\\Spell_Arcane_TeleportDalaran:20|t Infinite Dungeon", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        AddGossipItemFor(player, GOSSIP_ICON_TAXI, "|TInterface\\Icons\\Spell_Arcane_TeleportDalaran:20|t Training Grounds", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        AddGossipItemFor(player, GOSSIP_ICON_TAXI, "|TInterface\\Icons\\Spell_Arcane_TeleportDalaran:20|t Progression Hub", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
        
        SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, creature);
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);
        
        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1: // Infinite Dungeon
                player->TeleportTo(631, 529.302f, -2124.49f, 840.857f, 3.14159f); // ICC entrance
                ChatHandler(player->GetSession()).PSendSysMessage("|cFF00FF00Teleported to Infinite Dungeon!|r");
                break;
            case GOSSIP_ACTION_INFO_DEF + 2: // Training Grounds
                player->TeleportTo(0, -8960.0f, 516.0f, 96.0f, 0.0f); // Stormwind
                ChatHandler(player->GetSession()).PSendSysMessage("|cFF00FF00Teleported to Training Grounds!|r");
                break;
            case GOSSIP_ACTION_INFO_DEF + 3: // Progression Hub
                player->TeleportTo(571, 5807.0f, 588.0f, 661.0f, 1.0f); // Dalaran
                ChatHandler(player->GetSession()).PSendSysMessage("|cFF00FF00Teleported to Progression Hub!|r");
                break;
        }
        
        CloseGossipMenuFor(player);
        return true;
    }
};

void AddSC_progressive_npcs()
{
    new npc_progressive_merchant();
    new npc_progressive_trainer();
    new npc_progressive_statue();
    new npc_progressive_announcer();
    new npc_progressive_portal_master();
}

