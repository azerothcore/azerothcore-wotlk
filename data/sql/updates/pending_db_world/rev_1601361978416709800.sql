INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601361978416709800');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

-- Reference: http://web.archive.org/web/20150630004928/https://www.wowhead.com/item=44563/pattern-fur-lining-arcane-resist
DELETE FROM `creature_loot_template` WHERE `entry` IN (31702, 32297) AND `item` = 44563;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(32297, 44563, 0, 0.19, 0, 1, 0, 1, 1),
(31702, 44563, 0, 0.06, 0, 1, 0, 1, 1);

