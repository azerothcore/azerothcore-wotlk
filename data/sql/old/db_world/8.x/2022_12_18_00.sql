-- DB update 2022_12_16_04 -> 2022_12_18_00
--
DELETE FROM `creature_loot_template` WHERE `Entry` = 22454;
UPDATE `creature_template` SET `lootid` = 0 WHERE (`entry` = 22454);
