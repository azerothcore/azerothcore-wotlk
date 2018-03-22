/*

# SoloCraft #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
These are my extensions to the TrinityCore WoW Server Emulator for WoW version 3.3.5a that are targetted toward
soloing (or with a very small party) the group content in WoW like dungeons and raids at the level the content was
meant for instead of having to come back and solo when you are 20 levels higher than the content.

The goal is to automatically apply stat buffs, HP regeneration, procs like dispelling target regeneration buffs,
and other things to the player based on the instance the player has entered and the size of the party they are in
to make up the non-deal party makeup.


## To-Do ###
------------------------------------------------------------------------------------------------------------------
- Verify player pets are buffed accordingly
- Dispel target regeneration
- Provide unlimited http://www.wowhead.com/item=17333/aqual-quintessence
    - Not Needed (Sadly), the need to douse the runes with Aqual Quintessence was removed in 3.0.8


## Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Server/Player
- Script: Solocraft
- Config: Yes
    - Enable Module
    - Enable Module Announce
    - Set Difficulty for Instance Types
- SQL: No


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.09.04 - Add config options for difficulty levels
- v2017.09.05 - Update strings, Add module announce


### Credits ###
------------------------------------------------------------------------------------------------------------------
- [David Macalaster](https://github.com/DavidMacalaster/Solocraft)
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

#include <map>
//#include "Config.h"
#include "ScriptMgr.h"
#include "Unit.h"
#include "Player.h"
#include "Pet.h"
#include "Map.h"
#include "Group.h"
#include "InstanceScript.h"

namespace {

    class solocraft_player_instance_handler : public PlayerScript {

    public:

        solocraft_player_instance_handler() : PlayerScript("solocraft_player_instance_handler") {
            sLog->outString("scripts.solocraft.player.instance", "[Solocraft] solocraft_player_instance_handler Loaded");
        }

        // Announce Module
        void OnLogin(Player *player)
        {
            //if (sConfigMgr->GetBoolDefault("Solocraft.Enable", true))
            if (true)
            {
                //if (sConfigMgr->GetBoolDefault("Solocraft.Announce", true))
                if (true)
                {
                    ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SoloCraft |rmodule.");
                }
            }
        }

        void OnMapChanged(Player *player) override {
            if (true)
            //if (sConfigMgr->GetBoolDefault("Solocraft.Enable", true))
            {
                Map *map = player->GetMap();
                int difficulty = CalculateDifficulty(map, player);
                int numInGroup = GetNumInGroup(player);
                ApplyBuffs(player, map, difficulty, numInGroup);
            }
        }

    private:

        std::map<uint32, int> _unitDifficulty;

        // Get difficulty values from config
        /*const uint32 D5 = sConfigMgr->GetIntDefault("Solocraft.Dungeon", 5);
        const uint32 D10 = sConfigMgr->GetIntDefault("Solocraft.Heroic", 10);
        const uint32 D25 = sConfigMgr->GetIntDefault("Solocraft.Raid25", 25);
        const uint32 D40 = sConfigMgr->GetIntDefault("Solocraft.Raid40", 40);*/
        const uint32 D5 = 5;
        const uint32 D10 = 10;
        const uint32 D25 = 25;
        const uint32 D40 = 40;

        // Set the instance difficulty
        int CalculateDifficulty(Map *map, Player *player) {
            int difficulty = 1;
            if (map) {
                if (map->Is25ManRaid()) {
                    difficulty = D25;
                }
                else if (map->IsHeroic()) {
                    difficulty = D10;
                }
                else if (map->IsRaid()) {
                    difficulty = D40;
                }
                else if (map->IsDungeon()) {
                    difficulty = D5;
                }
            }
            return difficulty;
        }

        // Get the groups size
        int GetNumInGroup(Player *player) {
            int numInGroup = 1;
            Group *group = player->GetGroup();
            if (group) {
                Group::MemberSlotList const& groupMembers = group->GetMemberSlots();
                numInGroup = groupMembers.size();
            }
            return numInGroup;
        }

        // Apply the player buffs
        void ApplyBuffs(Player *player, Map *map, int difficulty, int numInGroup)
        {
            ClearBuffs(player, map);

            if (difficulty > 1)
            {
                // InstanceMap *instanceMap = map->ToInstanceMap();
                // InstanceScript *instanceScript = instanceMap->GetInstanceScript();

                // Announce to player
                std::ostringstream ss;
                ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered %s - # of Players: %d - Difficulty Offset: %d.";
                ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), numInGroup, difficulty);

                // Adjust player stats
                _unitDifficulty[player->GetGUID()] = difficulty;
                for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
                {
                    // Buff the player
                    player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, float(difficulty * 100), true);
                }

                // Set player health
                player->SetFullHealth();
                if (player->getPowerType() == POWER_MANA)
                {
                    // Buff the player's health
                    player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
                }
            }
        }

        void ClearBuffs(Player *player, Map *map)
        {
            std::map<uint32, int>::iterator unitDifficultyIterator = _unitDifficulty.find(player->GetGUID());
            if (unitDifficultyIterator != _unitDifficulty.end())
            {
                int difficulty = unitDifficultyIterator->second;
                _unitDifficulty.erase(unitDifficultyIterator);

                // Inform the player
                std::ostringstream ss;
                ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " exited to %s - Reverting Difficulty Offset: %d.";
                ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty);

                // Clear the buffs
                for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
                {
                    player->HandleStatModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, float(difficulty * 100), false);
                }
            }
        }
    };
}

class SolocraftScriptsWorld : public WorldScript
{
public:
	SolocraftScriptsWorld() : WorldScript("SolocraftScriptsWorld") { }

	void OnBeforeConfigLoad(bool reload) override
	{
		if (!reload) {
			/*std::string conf_path = _CONF_DIR;
			std::string cfg_file = conf_path + "Settings/modules/mod_solocraft.conf";
#ifdef WIN32
			cfg_file = "Settings/modules/mod_solocraft.conf";
#endif
			std::string cfg_def_file = cfg_file + ".dist";
			sConfigMgr->LoadMore(cfg_def_file.c_str());

			sConfigMgr->LoadMore(cfg_file.c_str());*/
		}
	}
};

void AddSolocraftScripts() {
	new SolocraftScriptsWorld();
    new solocraft_player_instance_handler();
}
