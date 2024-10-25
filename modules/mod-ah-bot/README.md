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
This mod works by selling and bidding auctions in the factions auction house. It can be instructed to do both the operations independently.

## Installation

```
1. Simply place the module under the `modules` directory of your AzerothCore source.
1. Import the SQL manually to the right Database (auth, world or characters).
1. Re-run cmake and launch a clean build of AzerothCore.
```

## Usage

Edit the module configuration and add a player account ID and a character ID.
This character will sell and buy items in the auction house so give him a good name.
If you only specify the account ID, all the characters created within that account will be involved in selling and bidding on the markets.

Specify what operation must be performed (`EnableSeller`, `EnableBuyer` or both).

Notes:
- The account used does not need any security level and can be a player account.
- The character used by the ahbot is not meant to be used ingame. If you use it to browse the auction house, you might have issues like "Searching for items..." displaying forever.

## Edit module configuration (optional)

If you need to change the module configuration, go to your server configuration folder (where your `worldserver` or `worldserver.exe` is)
rename the file mod_ahbot.conf.dist to mod_ahbot.conf and edit it. This will change the overall behavior of the bot.

If you need to change a more specific value (for example the quotas of item sold), you will need to update values int the `mod_auctionhousebot` table or use the command line.

The default quotas of all the auction houses for trade goods are:
- Gray = 0
- White = 27
- Green = 12
- Blue = 10
- Purple = 1
- Orange = 0
- Yellow = 0

The default quotas of all the auction houses for non trade goods items are:
- Gray = 0
- White = 10
- Green = 30
- Blue = 8
- Purple = 2
- Orange = 0
- Yellow = 0

The sum of the percentage for these categories must always be 100, or otherwise the defaults values will be used and the modifications will not be accepted.

## Credits

- Ayase: ported the bot to AzerothCore
- Other contributors (check the contributors list)
