# mod-level-up

## Description
Award loot boxes on milestone levels (10, 19, 29, ..., 80).

## How to use ingame
Loot boxes are automatically mailed to characters when they reach a milestone level.

## Installation
1. Simply `git clone` the module under the `modules` directory of your AzerothCore source or copy paste it manually.
2. Import the SQL manually to the right Database (auth, world or characters) or with the `db_assembler.sh` (if `include.sh` provided).
3. Re-run cmake and launch a clean build of AzerothCore.

## Edit the module's configuration (optional)
If you need to change the module configuration, go to your server configuration directory (where your `worldserver` or `worldserver.exe` is), copy `LevelUp.conf.dist` to `LevelUp.conf` and edit that new file.

## Credits
* Wobbling Goblin: [repository](https://github.com/wobgob) - [website](https://wobgob.com)
* AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)
