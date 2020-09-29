INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601361978416709800');

DELETE FROM `creature_loot_template` WHERE `entry` IN (31702, 32297) AND `item` = 44563;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`) VALUES 
(32297, 44563, 0, 1, 0, 1, 0, 1, 1); -- Cult Researcher: https://db.rising-gods.de/?item=44563#dropped-by
(31702, 44563, 0, 1, 0, 1, 0, 1, 1); -- Frostbrood Spawn: https://www.wowhead.com/item=44563/pattern-fur-lining-arcane-resist
