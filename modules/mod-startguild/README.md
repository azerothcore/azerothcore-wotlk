# Starting Guild #

### Description ###
------------------------------------------------------------------------------------------------------------------
This module auto-assigns new players to specific guilds.

- New characters are auto-joined to a specified guild on first login only.
- Config: Set ID for Horde and Alliance guilds to use.
- Optional SQL:
    - TIP: Run on a fresh server with no guilds. 
	- Creates two characters on the default admin's account to server as guildmaster of each new guild.
	- Creates both a Horde and Alliance guild with the previously imported characters as guildmaster.
	- Opens all guild bank tab and sets the name, icon, and permissions of each tab.
	- Fills the guild bank with 100 gold.
	
### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Player/Server
- Script: StartGuild
- Config: Yes
- SQL: Yes


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.08.01 - Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
#### An original module for AzerothCore by StygianTheBest ([stygianthebest.github.io](http://stygianthebest.github.io)) ####

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