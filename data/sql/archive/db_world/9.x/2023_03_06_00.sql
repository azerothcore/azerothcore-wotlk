-- DB update 2023_03_05_05 -> 2023_03_06_00
--
UPDATE `creature_loot_template` SET `Chance`=100 WHERE (`Entry` = 21784) AND (`Item`=30800);
