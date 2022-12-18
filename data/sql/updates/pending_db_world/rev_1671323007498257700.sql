--
DELETE FROM `creature_loot_template` WHERE `Entry` = 22454;
UPDATE `creature_template` SET `lootid` = 0 WHERE (`entry` = 22454);
