-- DB update 2024_11_03_00 -> 2024_11_03_01

DELETE FROM `creature` WHERE (`id1` = 25176) AND (`guid` IN (3110422));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(317, 25176, 0, 0, 530, 0, 0, 1, 1, 0, -2159.717041015625, 6638.6787109375, 1.074460387229919433, 0.92502450942993164, 120, 0, 0, 7, 0, 0, 0, 0, 0, '', 45704);
