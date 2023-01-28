-- DB update 2022_12_25_04 -> 2022_12_25_05
--
UPDATE `creature_loot_template` SET `Chance`=5 WHERE `Entry` IN (17881, 20912) AND `Item`=23572;
UPDATE `creature_loot_template` SET `Chance`=2.5 WHERE `Entry`=18473 AND `Item`=23572;
