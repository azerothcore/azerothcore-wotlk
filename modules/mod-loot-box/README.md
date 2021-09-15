# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

## mod-loot-box

### Description
Based on [Genshin Impact](https://genshin.mihoyo.com/en/), provides a module and instructions to create a loot box, custom currency, and custom NPC.

### How to use ingame
1. Acquire currency
2. Buy loot boxes
3. ???
4. PROFIT!

### Requirements
* [WDBXEditor](https://github.com/WowDevTools/WDBXEditor)
* [WoW Spell Editor](https://github.com/stoneharry/WoW-Spell-Editor)
* [MPQ Editor](http://www.zezula.net/en/mpq/download.html)

### Installation
1. Simply `git clone` the module under the `modules` directory of your AzerothCore source or copy paste it manually.
2. Import `eventstore.sql` manually and then use `db_assembler.sh import-all`.
3. In [WoW Spell Editor](https://github.com/stoneharry/WoW-Spell-Editor) create a new spell with `ID` equal to `7931299` based on the "Dummy Spell" `18282`.
4. Give the spell the name "Loot Box", spell description "Open Loot Box.", icon `inv_box_01`, and give it the "Level Up" visual and sound.
7. Copy `Item.dbc` and `ItemExtendedCost.dbc` into WoW Spell Editor's `DBC_335_wotlk` folder.
8. Import `Item.dbc` and `ItemExtendedCost.dbc` into WoW Spell Editor.
9. In WDBXEditor open `Item.dbc` and add a new row setting `ID` to `5621798`, `Sound_Override_Subclassid` to `-1`, and `DisplayInfoID` to `12331`.
10. In WDBXEditor again open `ItemExtendedCost.dbc` and add a new row setting `ID` to `3870075`, `ItemID_1` to `37711`, and `ItemCount_1` to `160`.
11. In WoW Spell Editor export the default DBCs for the server and export the MPQ for the client.
12. In MPQ Editor add `Item.dbc`, and `ItemExtendedCost.dbc` to the MPQ's `DBClientFiles` folder.
13. Copy all the DBCs to your server's `dbc` directory and place the MPQ in the client's `Data` directory.
14. Restart your server and your client. You might have to clear your client's cache by deleting `Cache` in your World of Warcraft client folder.

### Custom NPC
* creature_template: `5126979`
* CreatureDisplayInfo.dbc: `7359065`
* CreatureDisplayInfoExtra.dbc: `2945699`

### Edit the module's configuration (optional)
If you need to change the module configuration, go to your server configuration directory (where your `worldserver` or `worldserver.exe` is), copy `LootBox.conf.dist` to `LootBox.conf` and edit that new file.

### Credits
* Wobbling Goblin: [repository](https://github.com/wobgob) - [website](https://wobgob.com)
* AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)