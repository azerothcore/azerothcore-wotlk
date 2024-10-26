-- DB update 2024_06_28_03 -> 2024_06_28_04
DELETE FROM `creature` WHERE `guid` = 1554 AND `id1` = 25952;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(1554, 25952, 547, 3717, 3717, 3, 1, 0, -97.468841552734375, -231.198196411132812, -2.10892963409423828, 1.466076612472534179, 7200, 0, 0, 42, 0, 0, 0, 0, 0, 55141);

UPDATE `creature_template_movement` SET `Flight` = 1 WHERE `CreatureId` = 25952;

DELETE FROM `game_event_creature` WHERE `eventEntry` = 1 AND `guid` = 1554;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(1, 1554);
