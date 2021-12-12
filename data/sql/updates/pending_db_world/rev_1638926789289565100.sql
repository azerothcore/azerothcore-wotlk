INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638926789289565100');

/* Remove Remove Oil of Immolation, Restorative Potion, Lesser Stoneshield Potion, Elixir of Detect Undead, 
Elixir of Greater Intellect, Iron Ore and Eternium Ore from creature loot tables where they do not belong.
*/

DELETE FROM `creature_loot_template` WHERE (`Item` IN (8956, 9030, 4623, 9144, 9154, 9179, 23427, 2772));

/* Goblin Rocket Fuel - some NPCs still drop this, no blanket delete necessary
*/

DELETE FROM `creature_loot_template` WHERE (`Entry` = 9201) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 12178) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 13136) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 13416) AND (`Item` IN (9061));
DELETE FROM `creature_loot_template` WHERE (`Entry` = 22576) AND (`Item` IN (9061));
