-- DB update 2024_03_16_00 -> 2024_03_17_00
--
DELETE FROM `creature` WHERE `id1`=3296 AND `guid`=10299;
DELETE FROM `creature_addon` WHERE `guid`=10299;
