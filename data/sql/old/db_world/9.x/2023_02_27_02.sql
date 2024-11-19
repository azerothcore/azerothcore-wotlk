-- DB update 2023_02_27_01 -> 2023_02_27_02
--

DELETE FROM `creature_loot_template` WHERE `entry`= 18201 AND `Item`= 22787;
UPDATE `creature_template` SET `mingold`=0, `maxgold`=0, `lootid`=0 WHERE `entry`=18201;

DELETE FROM `skinning_loot_template` WHERE `Entry`= 2565 AND `Item`= 4234;
UPDATE `creature_template` SET `skinloot`=0 WHERE `entry`=2565;
