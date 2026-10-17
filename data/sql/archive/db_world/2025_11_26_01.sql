-- DB update 2025_11_26_00 -> 2025_11_26_01
--
DELETE FROM `waypoint_data` WHERE `id`=125946;

UPDATE `creature_template_movement` SET `Flight` = 0 WHERE (`CreatureId` = 24083);

DELETE FROM `creature` WHERE (`id1` = 24083) AND (`guid` IN (1971380));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(1971380, 24083, 0, 0, 574, 0, 0, 3, 1, 0, 209.1206, -187.86578, 200.00346, 0.677681, 3600, 0, 0, 71856, 0, 0, 0, 0, 0, '', NULL, 0);

DELETE FROM `vehicle_accessory` WHERE `guid` = 1971380 AND `accessory_entry` = 24849;
INSERT INTO `vehicle_accessory` (`guid`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(1971380, 24849, 0, 0, 'Proto Drake Rider mounted to Enslaved Proto Drake', 6, 30000);

DELETE FROM `creature_movement_override` WHERE `SpawnId`=1971380;
INSERT INTO `creature_movement_override` (`SpawnId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(1971380, 1, 1, 2, 0, 0, 0, NULL);
