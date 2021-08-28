INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630085433143335851');

SET @ITEM := 13140;

-- Add Ur'dan to loot table
UPDATE `creature_template` SET `lootid`= 14522 WHERE `entry` = 14522;
-- Ur'dan drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 14522 AND `Item`= 13140;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14522, 13140, 0, 3.7, 0, 1, 0, 1, 1, 'Ur\'dan - Blood Red Key');
-- Jaednar Darkweaver drop rate
UPDATE `creature_loot_template` SET `Chance`= 5.6 WHERE `Entry`=7118  AND `Item`=@ITEM;
-- Jaednar Enforcer drop rate
UPDATE `creature_loot_template` SET `Chance`= 5.7 WHERE `Entry`=7120  AND `Item`=@ITEM;
--  Jaednar Warlock drop rate
UPDATE `creature_loot_template` SET `Chance`= 6.2 WHERE `Entry`=7114  AND `Item`=@ITEM;
-- Ulathek drop rate
UPDATE `creature_loot_template` SET `Chance`= 4 WHERE `Entry`=14523 AND `Item`=@ITEM;
-- Jaedenar Legionaire drop rate
UPDATE `creature_loot_template` SET `Chance`=3.1 WHERE `Entry`=9862  AND `Item`=@ITEM;
