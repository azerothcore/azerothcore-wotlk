--

DELETE FROM `creature_loot_template` WHERE `entry` = 18201;

UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE `entry` = 18201;

UPDATE `creature_template` SET `skinloot` =0 WHERE `entry` = 2565;
