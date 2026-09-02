-- Ulduar: Mechanostriker 54-A template and movement updates
UPDATE `creature_template` SET `unit_flags` = 0, `ScriptName` = 'npc_mechanostriker_54_a' WHERE `entry` IN (34161, 34162);

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (34161, 34162);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(34161, 1, 0, 1, 0, 0, 0, NULL),
(34162, 1, 0, 1, 0, 0, 0, NULL);

DELETE FROM `creature_template_addon` WHERE `entry` IN (34161, 34162);
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `auras`) VALUES
(34161, 0, 50331648, 1, 0, 4, NULL),
(34162, 0, 50331648, 1, 0, 4, NULL);

-- Mechagnome Pilot accessory on Mechanostriker 54-A seat 0
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (34161, 34162);
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(34161, 33216, 0, 1, 'Mechanostriker 54-A - Mechagnome Pilot', 6, 30000),
(34162, 33216, 0, 1, 'Mechanostriker 54-A (1) - Mechagnome Pilot', 6, 30000);

-- Aerial trash pack spawns in Formation Grounds
DELETE FROM `creature` WHERE `guid` BETWEEN 1977400 AND 1977423;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `spawnFlags`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(1977400, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -425.12, 33.45, 424.50, 1.67, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977401, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -430.25, 25.10, 425.20, 1.67, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977402, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -422.80, 24.80, 423.80, 1.67, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977403, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -422.50, -56.20, 424.50, 4.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977404, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -428.10, -64.30, 425.00, 4.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977405, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -420.30, -66.80, 423.90, 4.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977406, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -282.40, 16.20, 424.50, 5.50, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977407, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -287.60, 7.80, 425.10, 5.50, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977408, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -280.10, 8.50, 423.70, 5.50, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977409, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -257.50, -132.80, 424.50, 1.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977410, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -263.20, -140.50, 425.20, 1.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977411, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -255.80, -141.20, 423.80, 1.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977412, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -137.20, -41.50, 424.50, 1.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977413, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -142.50, -49.80, 425.00, 1.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977414, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -135.60, -50.20, 423.90, 1.68, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977415, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -127.30, 134.80, 447.50, 0.78, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977416, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -133.10, 126.90, 448.20, 0.78, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977417, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, -125.40, 126.20, 446.80, 0.78, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977418, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, 18.20, -44.80, 424.50, 3.23, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977419, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, 13.50, -53.20, 425.00, 3.23, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977420, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, 20.80, -53.60, 423.90, 3.23, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977421, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, 73.80, -203.50, 432.50, 4.69, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977422, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, 68.20, -211.80, 433.10, 4.69, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL),
(1977423, 34161, 0, 0, 603, 0, 0, 3, 1, 0, 0, 75.90, -212.30, 431.80, 4.69, 604800, 0, 0, 1, 0, 0, 0, 0, 0, 0, '', NULL, NULL);
