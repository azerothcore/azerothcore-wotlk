-- DB update 2023_05_03_01 -> 2023_05_03_02
--
DELETE FROM `creature` WHERE `guid`=87022 AND `id1` = 2683;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES
(87022, 2683, 0, 1, 1, -4923.1, 725.529, 253.1, 6.21499, 300);

UPDATE `creature_template` SET `npcflag` = `npcflag`&~2 WHERE (`entry` = 2683);
