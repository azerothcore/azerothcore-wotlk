INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633841812215829906');

-- Removes loot from Commander Eligor Dawnbringer
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 16115;
-- Tidy loot table entries
DELETE FROM `creature_loot_template` WHERE `Entry` = 16115;

