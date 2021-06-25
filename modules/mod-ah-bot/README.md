# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore
## Mod-AHBOT
- Latest build status with azerothcore: [![Build Status](https://github.com/azerothcore/mod-ah-bot/workflows/core-build/badge.svg?branch=master&event=push)](https://github.com/azerothcore/mod-ah-bot)


## Important notes

You have to use at least AzerothCore commit [9adba48](https://github.com/azerothcore/azerothcore-wotlk/commit/9adba482c236f1087d66a672e97a99f763ba74b3).

If you use an old version of this module please update the table structure using this SQL statement:

```sql
ALTER TABLE `auctionhousebot` RENAME TO `mod_auctionhousebot`;
```

## Description

An auction house bot for the best core: AzerothCore.

## Installation

```
1. Simply place the module under the `modules` directory of your AzerothCore source. 
1. Import the SQL manually to the right Database (auth, world or characters) or with the `db_assembler.sh` (if `include.sh` provided).
1. Re-run cmake and launch a clean build of AzerothCore.
```

## Edit module configuration (optional)

If you need to change the module configuration, go to your server configuration folder (where your `worldserver` or `worldserver.exe` is)
rename the file mod_ahbot.conf.dist to mod_ahbot.conf and edit it.

## Usage

Edit the module configuration and add a player account ID and a character ID.
This character will sell and buy items in the auction house so give him a good name.

Notes:
- The account used does not need any security level and can be a player account.
- The character used by the ahbot is not meant to be used ingame. If you use it to browse the auction house, you might have issues like "Searching for items..." displaying forever.

## Credits

- Ayase: ported the bot to AzerothCore
- Other contributors (check the contributors list)

