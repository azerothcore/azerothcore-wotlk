-- DB update 2022_08_21_09 -> 2022_08_21_10
--
DELETE FROM `creature_loot_template` WHERE `Entry` IN (4625,11374,12352,27213,27414);
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` IN (4625,11374,12352,27213,27414);
