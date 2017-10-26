#include "Define.h"
#include "GossipDef.h"
#include "Item.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "Spell.h"
#include "Configuration/Config.h"

enum vendor
{
    NPC_VENDOR = 54, //Alliance
    NPC_VENDOR2 = 3163, //Horde
    NPC_AUCTION = 9856, //Horde
    NPC_AUCTION2 = 8670 //Alliance
};

enum trainers
{
    //Alliance NPC's
    AROGUE = 918,
    AWARRIOR = 5479,
    AHUNTER = 5515,
    APRIEST = 376,
    APALADIN = 928,
    ADRUID = 5504,
    ASHAMAN = 20407,
    AMAGE = 5497,
    AWARLOCK = 461,

    //Horde NPCS
    HHUNTER = 3406,
    HWARRIOR = 3354,
    HSHAMAN = 3344,
    HPALADIN = 23128,
    HROGUE = 3401,
    HWARLOCK = 3324,
    HMAGE = 5883, 
    HPRIEST = 3045,
    HDRUID = 3033,

    DKTRAINER = 28472
};

enum mounts
{
    HUMAN_MOUNT = 470,
    ORC_MOUNT = 6653,
    GNOME_MOUNT = 17454,
    NIGHTELF_MOUNT = 8394,
    DWARF_MOUNT = 6899,
    UNEAD_MOUNT = 17463,
    TAUREN_MOUNT = 64657,
    TROLL_MOUNT = 8395,
    BLOODELF_MOUNT = 35022,
    DRAENEI_MOUNT = 34406
};

class premium_account : public ItemScript
{
public:
    premium_account() : ItemScript("premium_account") { }

    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override // Any hook here
    {
        if (!sConfigMgr->GetBoolDefault("PremiumAccount", true)) 
            return false;  

        QueryResult result = CharacterDatabase.PQuery("SELECT AccountId FROM premium WHERE active = 1 and AccountId = %u", player->GetSession()->GetAccountId());

        if (!result)
            return false;

        if (player->IsInCombat())
            return false;

        if (player->FindNearestCreature(NPC_AUCTION2, 10.0f) ||
            player->FindNearestCreature(NPC_AUCTION, 10.0f) ||
            player->FindNearestCreature(NPC_VENDOR, 10.0f) ||
            player->FindNearestCreature(NPC_VENDOR2, 10.0f) ||
            player->FindNearestCreature(AROGUE, 10.0f) ||
            player->FindNearestCreature(AWARRIOR, 10.0f) ||
            player->FindNearestCreature(AHUNTER, 10.0f) ||
            player->FindNearestCreature(APRIEST, 10.0f) ||
            player->FindNearestCreature(APALADIN, 10.0f) ||
            player->FindNearestCreature(ADRUID, 10.0f) ||
            player->FindNearestCreature(ASHAMAN, 10.0f) ||
            player->FindNearestCreature(AMAGE, 10.0f) ||
            player->FindNearestCreature(AWARLOCK, 10.0f) ||
            player->FindNearestCreature(HHUNTER, 10.0f) ||
            player->FindNearestCreature(HWARRIOR, 10.0f) ||
            player->FindNearestCreature(HSHAMAN, 10.0f) ||
            player->FindNearestCreature(HPALADIN, 10.0f) ||
            player->FindNearestCreature(HROGUE, 10.0f) ||
            player->FindNearestCreature(HWARLOCK, 10.0f) ||
            player->FindNearestCreature(HMAGE, 10.0f) ||
            player->FindNearestCreature(HPRIEST, 10.0f) ||
            player->FindNearestCreature(HDRUID, 10.0f) ||
            player->FindNearestCreature(DKTRAINER, 10.0f))
            return false;

        player->PlayerTalkClass->ClearMenus();

        if (sConfigMgr->GetBoolDefault("Morph", true))
        {
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Morph", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Demorph", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        }
        if (sConfigMgr->GetBoolDefault("Mount", true))
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT_16, "Mount", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
        if (sConfigMgr->GetBoolDefault("Trainers", true))
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
        if (sConfigMgr->GetBoolDefault("PlayerInteraction", true))
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Player interactions", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, item->GetGUID());

        return false; // Cast the spell on use normally
    }

    void OnGossipSelect(Player* player, Item* item, uint32 /*sender*/, uint32 action)
    {
        switch (action)
        {
        case GOSSIP_ACTION_INFO_DEF + 1: /*Morph*/
        {
            player->CLOSE_GOSSIP_MENU();
            uint32 random = (urand(1, 26)); /* change this line when adding more morphs */
            {
                switch (random)
                {
                case 1: player->SetDisplayId(10134); break;     // Troll Female                 'Orb of Deception'
                case 2: player->SetDisplayId(10135); break;     // Troll Male                   'Orb of Deception'
                case 3: player->SetDisplayId(10136); break;     // Tauren Male                  'Orb of Deception'
                case 4: player->SetDisplayId(10137); break;     // Human Male                   'Orb of Deception'
                case 5: player->SetDisplayId(10138); break;     // Human Female                 'Orb of Deception'
                case 6: player->SetDisplayId(10139); break;     // Orc Male                     'Orb of Deception'
                case 7: player->SetDisplayId(10140); break;     // Orc Female                   'Orb of Deception' 
                case 8: player->SetDisplayId(10141); break;     // Dwarf Male                   'Orb of Deception'
                case 9: player->SetDisplayId(10142); break;     // Dwarf Female                 'Orb of Deception' 
                case 10: player->SetDisplayId(10143); break;    // NightElf Male                'Orb of Deception'
                case 11: player->SetDisplayId(10144); break;    // NightElf Female              'Orb of Deception'
                case 12: player->SetDisplayId(10145); break;    // Undead Female                'Orb of Deception'
                case 13: player->SetDisplayId(10146); break;    // Undead Male                  'Orb of Deception'
                case 14: player->SetDisplayId(10147); break;    // Tauren Female                'Orb of Deception'
                case 15: player->SetDisplayId(10148); break;    // Gnome Male                   'Orb of Deception'
                case 16: player->SetDisplayId(10149); break;    // Gnome Female                 'Orb of Deception'
                case 17: player->SetDisplayId(4527); break;     // Thrall                       'Orgrimmar Boss'
                case 18: player->SetDisplayId(11657); break;    // Lady Sylvanas                'Undercity Boss'
                case 19: player->SetDisplayId(4307); break;     // Cairne Bloodhoof             'Thunderbluff Boss'
                case 20: player->SetDisplayId(17122); break;    // Lor´themar Theron            'Silvermoon City Boss'
                case 21: player->SetDisplayId(3597); break;     // King Magni Bronzebeard       'Ironforge Boss'
                case 22: player->SetDisplayId(5566); break;     // Highlord Bolvar Fordragon    'Stormwind Boss'
                case 23: player->SetDisplayId(7006); break;     // High Tinker Mekkatorque      'Gnomer Boss'
                case 24: player->SetDisplayId(7274); break;     // Tyrande Whisperwind          'Darnassus Boss'
                case 25: player->SetDisplayId(21976); break;    // Arthus Small                 'Arthus'
                case 26: player->SetDisplayId(24641); break;    // Arthus Ghost                 'Arthus Ghost'

                default:
                    break;
                }
            }
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 2: /*Demorph*/
            player->DeMorph();
            player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 3: /*Show Bank*/
            player->GetSession()->SendShowBank(player->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 4: /*Mail Box*/
            player->GetSession()->SendShowMailBox(player->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 5: /*Vendor*/
            if (player->GetTeamId() == TEAM_ALLIANCE)
            {
                Creature* vendor = player->SummonCreature(NPC_VENDOR, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                vendor->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                vendor->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                vendor->setFaction(player->getFaction());
                vendor->MonsterWhisper("Greetings", player, false);
                player->CLOSE_GOSSIP_MENU();
            }
            else
            {
                Creature* vendor = player->SummonCreature(NPC_VENDOR2, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                vendor->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                vendor->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                vendor->setFaction(player->getFaction());
                vendor->MonsterWhisper("Zug Zug", player, false);
                player->CLOSE_GOSSIP_MENU();
            }
        break;
        case GOSSIP_ACTION_INFO_DEF + 6: /*Mount*/
            player->CLOSE_GOSSIP_MENU();
            switch (player->getRace())
            {
            case RACE_HUMAN:
                player->CastSpell(player, HUMAN_MOUNT);
                break;
            case RACE_ORC:
                player->CastSpell(player, ORC_MOUNT);
                break;
            case RACE_GNOME:
                player->CastSpell(player, GNOME_MOUNT);
                break;
            case RACE_NIGHTELF:
                player->CastSpell(player, NIGHTELF_MOUNT);
                break;
            case RACE_DWARF:
                player->CastSpell(player, DWARF_MOUNT);
                break;
            case RACE_DRAENEI:
                player->CastSpell(player, DRAENEI_MOUNT);
                break;
            case RACE_UNDEAD_PLAYER:
                player->CastSpell(player, UNEAD_MOUNT);
                break;
            case RACE_TAUREN:
                player->CastSpell(player, TAUREN_MOUNT);
                break;
            case RACE_TROLL:
                player->CastSpell(player, TROLL_MOUNT);
                break;
            case RACE_BLOODELF:
                player->CastSpell(player, BLOODELF_MOUNT);
                break;
            }
            break;
        case GOSSIP_ACTION_INFO_DEF + 7: /*Auction House*/

            if (player->GetTeamId() == TEAM_HORDE)
            {
                Creature* npc_auction = player->SummonCreature(NPC_AUCTION, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                npc_auction->MonsterWhisper("I will go shortly, i need to get back to Orgrimmar", player, false);
                npc_auction->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                npc_auction->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                npc_auction->setFaction(player->getFaction());
            }
            else
            {
                Creature* npc_auction = player->SummonCreature(NPC_AUCTION2, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                npc_auction->MonsterWhisper("I will go shortly, i need to get back to Stormwind City", player, false);
                npc_auction->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                npc_auction->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                npc_auction->setFaction(player->getFaction());
            }
            player->CLOSE_GOSSIP_MENU();
            break;
        case GOSSIP_ACTION_INFO_DEF + 8: /* Class Trainers*/
            switch (player->getClass())
            {
            case CLASS_ROGUE:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(AROGUE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HROGUE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_WARRIOR:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(AWARRIOR, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HWARRIOR, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_PRIEST:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(APRIEST, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HPRIEST, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_MAGE:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(AMAGE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HMAGE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_PALADIN:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(APALADIN, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HPALADIN, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_HUNTER:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(AHUNTER, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HHUNTER, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_DRUID:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(ADRUID, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HDRUID, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_SHAMAN:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(ASHAMAN, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HSHAMAN, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_WARLOCK:
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    Creature* trainer = player->SummonCreature(AWARLOCK, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                else
                {
                    Creature* trainer = player->SummonCreature(HWARLOCK, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                    trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                    trainer->setFaction(player->getFaction());
                }
                break;
            case CLASS_DEATH_KNIGHT:
                Creature* trainer = player->SummonCreature(DKTRAINER, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000);
                trainer->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                trainer->GetMotionMaster()->MoveFollow(player, PET_FOLLOW_DIST, player->GetFollowAngle());
                trainer->setFaction(player->getFaction());
                break;
            }
            break;
        case GOSSIP_ACTION_INFO_DEF + 9: /*Player Interactions*/
        {
            player->PlayerTalkClass->ClearMenus();
            if (sConfigMgr->GetBoolDefault("Vendor", true))
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Vendor", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            if (sConfigMgr->GetBoolDefault("MailBox", true))
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Mail Box", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            if (sConfigMgr->GetBoolDefault("Bank", true))
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Show Bank", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            if (sConfigMgr->GetBoolDefault("Auction", true))
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_VENDOR, "Auction House", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, item->GetGUID());
            break;
        }
        break;
        }
    }
};


class premium_world : public WorldScript
{
public:
    premium_world() : WorldScript("premiumworld") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string cfg_file = "Settings/modules/mod_premium.conf";
            std::string cfg_def_file = cfg_file + ".dist";

            sConfigMgr->LoadMore(cfg_def_file.c_str());

            sConfigMgr->LoadMore(cfg_file.c_str());
        }
    }
};

void AddSC_premium_account()
{
    new premium_account();
    new premium_world();
}