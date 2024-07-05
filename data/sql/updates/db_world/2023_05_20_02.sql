-- DB update 2023_05_20_01 -> 2023_05_20_02
--
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '18950' WHERE (`entry` = 20993);
UPDATE `creature_template_addon` SET `bytes2` = 2 WHERE (`entry` IN (17826, 20183));

DELETE FROM `creature_template_addon` WHERE (`entry` IN (18054,17455,18051,19886,19885,21126,21842,17938,19888,21127,21843,17960,19890,19887,20254,20697,20691,20698));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(18054, 0, 0, 0, 1, 0, 0, ''),
(17455, 0, 0, 0, 1, 0, 0, ''),
(18051, 0, 0, 0, 1, 0, 0, ''),
(19886, 0, 0, 0, 1, 0, 0, ''),
(19885, 0, 0, 0, 1, 0, 0, ''),
(21126, 0, 0, 0, 1, 0, 0, ''),
(21842, 0, 0, 0, 1, 0, 0, ''),
(17938, 0, 0, 0, 1, 0, 0, ''),
(19888, 0, 0, 0, 1, 0, 0, ''),
(21127, 0, 0, 0, 1, 0, 0, ''),
(21843, 0, 0, 0, 1, 0, 0, ''),
(17960, 0, 0, 0, 1, 0, 0, ''),
(19890, 0, 0, 0, 1, 0, 0, ''),
(19887, 0, 0, 0, 1, 0, 0, ''),
(20254, 0, 0, 0, 1, 0, 0, '32368'),
(20697, 0, 0, 0, 1, 0, 0, '37509'),
(20691, 0, 0, 0, 1, 0, 0, '37509'),
(20698, 0, 0, 0, 1, 0, 0, '37509');

UPDATE `creature_addon` SET `bytes2` = 1 WHERE `guid` IN (202625, 202627, 202628, 202629, 202630, 202631, 202697, 202623, 202624, 202614, 202615);
UPDATE `creature_addon` SET `bytes2` = 2 WHERE `guid` IN (138500);

UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` IN (17958, 17957, 21126, 17938, 17940, 21127, 17960, 17961, 17826);

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33555200 WHERE (`entry` = 20307);
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554688 WHERE (`entry` = 20304);

UPDATE `creature_template` SET `lootid` = 18639, `pickpocketloot` = 18639, `mingold` = 881, `maxgold` = 1155 WHERE (`entry` = 20647);
UPDATE `creature_template` SET `lootid` = 18634, `pickpocketloot` = 18634, `mingold` = 881, `maxgold` = 1155 WHERE (`entry` = 20648);
