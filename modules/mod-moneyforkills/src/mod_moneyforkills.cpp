/*

# Money For Kills #

### Description ###
------------------------------------------------------------------------------------------------------------------
- Pays players bounty money for kills of players and creatures.
- Bounty and other amounts can be changed in the config file.
- Bounty can be paid to only the player with killing blow or all players.
- Bounty can be paid to players that are near or far away from the group.
- Dungeon boss kills are announced to the party.
- World boss kills are announced to the world.
- Player suicides are announced to the world.
- Low level player kills are announced to the world.
- Minimum player level for PVP loot can be set in config.


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Server/Player
- Script: MoneyForKills
- Config: Yes
- SQL: No


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2018.12.15 - Added Low Level Player loot option, Change suicide check, World boss kill only announced by leader
- v2018.12.01 - Added Low Level MOB bounty option, Prevent low PVP payouts
- v2017.09.22 - Added PVPCorpseLoot as a config option
- v2017.09.02 - Added distance check, Fixed group payment
- v2017.08.31 - Added boss kills
- v2017.08.24 - Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
#### An original module for AzerothCore by StygianTheBest http://stygianthebest.github.io ####

###### Additional Credits include:
- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [AzerothCore Discord](https://discord.gg/gkt4y2x)
- [EMUDevs](https://youtube.com/user/EmuDevs)
- [AC-Web](http://ac-web.org/)
- [ModCraft.io](http://modcraft.io/)
- [OwnedCore](http://ownedcore.com/)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [AoWoW](https://wotlk.evowow.com/)


### License ###
------------------------------------------------------------------------------------------------------------------
- This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/

#include "Config.h"
#include "Group.h"

bool MFKEnable = true;
bool MFKAnnounceModule = true;
bool MFKKillingBlowOnly = false;
bool MFKMoneyForNothing = false;
bool MFKLowLevelBounty = false;
uint32 MFKMinPVPLevel = 10;
uint32 MFKPVPCorpseLootPercent = 5;
uint32 MFKKillMultiplier = 100;
uint32 MFKPVPMultiplier = 200;
uint32 MFKDungeonBossMultiplier = 10;
uint32 MFKWorldBossMultiplier = 15;

class MFKConfig : public WorldScript
{
public:
    MFKConfig() : WorldScript("MFKConfig") { }

    void OnBeforeConfigLoad(bool reload) override
    {
        if (!reload) {
            std::string conf_path = _CONF_DIR;
            std::string cfg_file = conf_path + "/mod_moneyforkills.conf";
#ifdef WIN32
            cfg_file = "mod_moneyforkills.conf";
#endif
            std::string cfg_def_file = cfg_file + ".dist";
            sConfigMgr->LoadMore(cfg_def_file.c_str());
            sConfigMgr->LoadMore(cfg_file.c_str());
        }
        // Load Configuration Settings
        SetInitialWorldSettings();
    }

    // Load Configuration Settings
    void SetInitialWorldSettings()
    {
        MFKEnable = sConfigMgr->GetBoolDefault("MFK.Enable", true);
        MFKAnnounceModule = sConfigMgr->GetBoolDefault("MFK.Announce", true);
        MFKKillingBlowOnly = sConfigMgr->GetBoolDefault("MFK.KillingBlowOnly", false);
        MFKMoneyForNothing = sConfigMgr->GetBoolDefault("MFK.MoneyForNothing", false);
        MFKLowLevelBounty = sConfigMgr->GetBoolDefault("MFK.LowLevelBounty", false);
        MFKMinPVPLevel = sConfigMgr->GetIntDefault("MFK.MinPVPLevel", 10);
        MFKPVPCorpseLootPercent = sConfigMgr->GetIntDefault("MFK.PVP.CorpseLootPercent", 5);
        MFKKillMultiplier = sConfigMgr->GetIntDefault("MFK.Kill.Multiplier", 100);
        MFKPVPMultiplier = sConfigMgr->GetIntDefault("MFK.PVP.Multiplier", 200);
        MFKDungeonBossMultiplier = sConfigMgr->GetIntDefault("MFK.DungeonBoss.Multiplier", 25);
        MFKWorldBossMultiplier = sConfigMgr->GetIntDefault("MFK.WorldBoss.Multiplier", 100);
    }
};

class MFKAnnounce : public PlayerScript
{

public:
    MFKAnnounce() : PlayerScript("MFKAnnounce") {}

    void OnLogin(Player* player)
    {
        // Announce Module
        if (MFKEnable)
        {
            if (MFKAnnounceModule)
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the|cff4CFF00 MoneyForKills |rmodule.");
            }
        }
    }
};

class MoneyForKills : public PlayerScript
{
public:
    MoneyForKills() : PlayerScript("MoneyForKills") { }

    // Player Kill Reward
    void OnPVPKill(Player* player, Player* victim)
    {
        // If enabled...
        if (MFKEnable)
        {
            // If enabled...
            if (MFKPVPMultiplier > 0)
            {
                std::ostringstream ss;

                // No reward for killing yourself
                if (player->GetName().compare(victim->GetName()) == 0)
                {
                    // Inform the world
                    ss << "|cffFFFFFF" << player->GetName() << "|cffff6060 met an untimely demise!";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                    return;
                }

                // Was the poor bastard worth any loot?
                if (victim->getLevel() <= MFKMinPVPLevel)
                {
                    ss << "|cffFF0000[|cffff6060PVP|cffFF0000]|cffFFFFFF " << victim->GetName()
                       << "|cffFF0000 was slaughtered mercilessly by|cffff6060 " << player->GetName() << "|cffFF0000 !";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                    return;
                }

                // Calculate the amount of gold to give to the victor
                const uint32 VictimLevel = victim->getLevel();
                const int VictimLoot = (victim->GetMoney() * MFKPVPCorpseLootPercent) / 100;    // Configured % of victim's loot
                const int BountyAmount = ((VictimLevel * MFKPVPMultiplier) / 3);                // Modifier

                // Rifle the victim's corpse and chec for loot
                // If they have at least 1 gold
                if (victim->GetMoney() >= 10000)
                {
                    // Player loots 5% of the victim's gold
                    player->ModifyMoney(VictimLoot);
                    victim->ModifyMoney(-VictimLoot);

                    // Inform the player of the corpse loot
                    Notify(player, victim, NULL, "Loot", NULL, VictimLoot);

                    // Pay the player the additional PVP bounty
                    player->ModifyMoney(BountyAmount);
                }
                else
                {
                    // Pay the player the additional PVP bounty
                    player->ModifyMoney(BountyAmount);
                }

                // Inform the player of the bounty amount
                Notify(player, victim, NULL, "PVP", BountyAmount, VictimLoot);

                //return;
            }
        }
    }

    // Creature Kill Reward
    void OnCreatureKill(Player* player, Creature* killed)
    {
        std::ostringstream ss;

        // No reward for killing yourself
        if (player->GetName().compare(killed->GetName()) == 0)
        {
            // Inform the world
            ss << "|cffFFFFFF" << player->GetName() << "|cffff6060 met an untimely demise!";
            sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
            return;
        }

        // If enabled...
        if (MFKEnable)
        {
            // Get the creature level
            const uint32 CreatureLevel = killed->getLevel();
            const uint32 CharacterLevel = player->getLevel();

            // What did the player kill?
            if (killed->IsDungeonBoss() || killed->isWorldBoss())
            {
                uint32 BossMultiplier;

                // Dungeon Boss or World Boss multiplier?
                if (killed->IsDungeonBoss())
                {
                    BossMultiplier = MFKDungeonBossMultiplier;
                }
                else
                {
                    BossMultiplier = MFKWorldBossMultiplier;
                }

                // If enabled...
                if (BossMultiplier > 0)
                {
                    // Reward based on creature level
                    const int BountyAmount = ((CreatureLevel * BossMultiplier) * 100);

                    if (killed->IsDungeonBoss())
                    {
                        // Pay the bounty amount
                        CreatureBounty(player, killed, "DungeonBoss", BountyAmount);
                    }
                    else
                    {
                        // Pay the bounty amount
                        CreatureBounty(player, killed, "WorldBoss", BountyAmount);
                    }
                }
            }
            else
            {
                // If enabled...
                if (MFKKillMultiplier > 0)
                {
                    // Reward based on creature level
                    int BountyAmount = ((CreatureLevel * MFKKillMultiplier) / 3);

                    // Is the character higher level than the mob?
                    if (CharacterLevel > CreatureLevel)
                    {
                        // If Low Level Bounty not enabled zero the bounty
                        if (!MFKLowLevelBounty)
                        {
                            BountyAmount = 0;
                        }
                        else
                        {
                            // Is the creature worth XP or Honor?
                            if (!player->isHonorOrXPTarget(killed))
                            {
                                // BountyAmount = 0;
                            }
                        }
                    }

                    // Pay the bounty amount
                    CreatureBounty(player, killed, "MOB", BountyAmount);
                }
            }
        }
    }

    // Pay Creature Bounty
    void CreatureBounty(Player* player, Creature* killed, string KillType, int bounty)
    {
        Group* group = player->GetGroup();
        Group::MemberSlotList const &members = group->GetMemberSlots();

        if (MFKEnable)
        {
            // If we actually have a bounty..
            if (bounty >= 1)
            {
                // Determine who receives the bounty
                if (!group || MFKKillingBlowOnly == 1)
                {
                    // Pay a specific player bounty amount
                    player->ModifyMoney(bounty);

                    // Inform the player of the bounty amount
                    Notify(player, NULL, killed, KillType, bounty, NULL);
                }
                else
                {
                    // Pay the group (OnCreatureKill only rewards the player that got the killing blow)
                    for (Group::MemberSlotList::const_iterator itr = members.begin(); itr != members.end(); ++itr)
                    {
                        Group::MemberSlot const &slot = *itr;
                        Player* playerInGroup = ObjectAccessor::FindPlayer((*itr).guid);

                        // Pay each player in the group
                        if (playerInGroup && playerInGroup->GetSession())
                        {
                            // Money for nothing and the kills for free..
                            if (MFKMoneyForNothing == 1)
                            {
                                // Pay the bounty
                                playerInGroup->ModifyMoney(bounty);

                                // Inform the player of the bounty amount
                                Notify(playerInGroup, NULL, killed, KillType, bounty, NULL);
                            }
                            else
                            {
                                // Only pay players that are in reward distance	
                                if (playerInGroup->IsAtGroupRewardDistance(killed))
                                {
                                    // Pay the bounty
                                    playerInGroup->ModifyMoney(bounty);

                                    // Inform the player of the bounty amount
                                    Notify(playerInGroup, NULL, killed, KillType, bounty, NULL);
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // Payment/Kill Notification
    void Notify(Player* player, Player* victim, Creature* killed, string KillType, int bounty, int loot)
    {
        std::ostringstream ss;
        std::ostringstream sv;
        int result[3];

        if (MFKEnable)
        {
            // Determine type of kill
            if (KillType == "Loot")
            {
                const int copper = loot % 100;
                loot = (loot - copper) / 100;
                const int silver = loot % 100;
                const int gold = (loot - silver) / 100;
                result[0] = copper;
                result[1] = silver;
                result[2] = gold;
            }
            else
            {
                const int copper = bounty % 100;
                bounty = (bounty - copper) / 100;
                const int silver = bounty % 100;
                const int gold = (bounty - silver) / 100;
                result[0] = copper;
                result[1] = silver;
                result[2] = gold;
            }

            // Payment notification
            if (KillType == "Loot")
            {
                ss << "|cffFF0000[|cffff6060PVP|cffFF0000] You loot|cFFFFD700 ";
                sv << "|cffFF0000[|cffff6060PVP|cffFF0000]|cffFFFFFF " << player->GetName() << "|cffFF0000 rifles through your corpse and takes|cFFFFD700 ";
            }
            else if (KillType == "PVP")
            {
                ss << "|cffFF0000[|cffff6060PVP|cffFF0000]|cffFFFFFF " << player->GetName() << "|cffFF0000 has slain|cffFFFFFF "
                   << victim->GetName() << "|cffFF0000 earning a bounty of|cFFFFD700 ";
            }
            else
            {
                ss << "You receive a bounty of ";
            }

            // Figure out the money (todo: find a better way to handle the different strings)
            if (result[2] > 0)
            {
                ss << result[2] << " gold";
                sv << result[2] << " gold";
            }
            if (result[1] > 0)
            {
                if (result[2] > 0)
                {
                    ss << " " << result[1] << " silver";
                    sv << " " << result[1] << " silver";
                }
                else
                {
                    ss << result[1] << " silver";
                    sv << result[1] << " silver";

                }
            }
            if (result[0] > 0)
            {
                if (result[1] > 0)
                {
                    ss << " " << result[0] << " copper";
                    sv << " " << result[0] << " copper";
                }
                else
                {
                    ss << result[0] << " copper";
                    sv << result[0] << " copper";
                }
            }

            // Type of kill
            if (KillType == "Loot")
            {
                ss << "|cffFF0000 from the corpse.";
                sv << "|cffFF0000.";
            }
            else if (KillType == "PVP")
            {
                ss << "|cffFF0000.";
                sv << "|cffFF0000.";
            }
            else
            {
                ss << " for the kill.";
            }

            // If it's a boss kill..
            if (KillType == "WorldBoss")
            {
                std::ostringstream ss;

                // Is the player in a group? 
                if (player->GetGroup())
                {                     
                    // Only the party leader should announce the boss kill.
                    if (player->GetGroup()->GetLeaderName() == player->GetName())
                    {
                        // Chat icons don't show for all clients despite them showing when entered manually. Disabled until fix is found.
                        // Ex: {rt8} = {skull}
                        ss << "|cffFF0000[|cffff6060 BOSS KILL |cffFF0000]|cffFFFFFF " << player->GetName()
                           << "|cffFFFFFF's group triumphed victoriously over |cffFF0000[|cffff6060 "
                           << killed->GetName() << " |cffFF0000]|cffFFFFFF !";

                        sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                    }         
                }
                else
                {
                    // Solo Kill
                    ss << "|cffFF0000[|cffff6060 BOSS KILL |cffFF0000]|cffFFFFFF " << player->GetName()
                       << "|cffFFFFFF triumphed victoriously over |cffFF0000[|cffff6060 "
                       << killed->GetName() << " |cffFF0000]|cffFFFFFF !";

                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                }
            }
            else if (KillType == "Loot")
            {
                // Inform the player of the corpse loot
                ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());

                // Inform the victim of the corpse loot
                ChatHandler(victim->GetSession()).SendSysMessage(sv.str().c_str());
            }
            else if (KillType == "PVP")
            {
                // Inform the world of the kill
                sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
            }
            else
            {
                if (KillType == "DungeonBoss")
                {
                    // Is the player in a group? 
                    if (player->GetGroup())
                    {
                        // Inform the player of the Dungeon Boss kill
                        std::ostringstream sb;
                        sb << "|cffFF8000 Your party has defeated |cffFF0000" << killed->GetName() << "|cffFF8000 !";
                        ChatHandler(player->GetSession()).SendSysMessage(sb.str().c_str());
                    }
                    else
                    {
                        // Solo Kill
                        std::ostringstream sb;
                        sb << "|cffFF8000 You have defeated |cffFF0000" << killed->GetName() << "|cffFF8000 !";
                        ChatHandler(player->GetSession()).SendSysMessage(sb.str().c_str());
                    }
                }

                // Inform the player of the bounty
                ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
            }
        }
    }
};

void AddMoneyForKillsScripts()
{
    new MFKConfig();
    new MFKAnnounce();
    new MoneyForKills();
}
