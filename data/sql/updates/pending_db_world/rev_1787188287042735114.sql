--
-- Timmy the Cruel
SET @CGUID := 247227;
SET @PATH := @CGUID * 10;

DELETE FROM `spawn_group_template` WHERE `groupId` IN (105, 106);
INSERT INTO `spawn_group_template` (`groupId`, `groupName`, `groupFlags`) VALUES
    (105, 'Stratholme - Timmy the Cruel trigger', 0),
    (106, 'Stratholme - Timmy the Cruel', 4);

DELETE FROM `spawn_group` WHERE `groupId` IN (105, 106) OR `spawnId` IN (54075, 54076, 54138, @CGUID);
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
    (105, 0, 54075),
    (105, 0, 54076),
    (105, 0, 54138),
    (106, 0, @CGUID);

UPDATE `creature` SET `position_x` = 3624.6, `position_y` = -3188, `position_z` = 130.579, `orientation` = 2.99341, `MovementType` = 2, `VerifiedBuild` = 53622, `CreateObject` = 2 WHERE `guid` = @CGUID AND `id` = 10808;

DELETE FROM `creature_addon` WHERE `guid` = @CGUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
    (@CGUID, @PATH, 0, 0, 1, 0, 3, '12787');

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
    (@PATH, 1, 3622.5618, -3187.6912, 130.70120, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 2, 3637.9067, -3196.1228, 128.94208, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 3, 3653.7864, -3202.9502, 127.63325, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 4, 3674.5347, -3204.5970, 126.66777, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 5, 3689.5625, -3191.0405, 127.16926, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 6, 3696.2886, -3171.0410, 127.19991, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 7, 3694.8628, -3156.6287, 127.44449, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 8, 3681.7678, -3154.1362, 127.26646, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 9, 3677.8403, -3162.5703, 126.69397, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 10, 3676.1355, -3175.5400, 126.43660, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 11, 3668.1090, -3185.7537, 126.311264, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 12, 3673.8386, -3194.0088, 126.40000, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 13, 3667.7388, -3203.3460, 126.56412, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 14, 3656.9858, -3204.5164, 127.65019, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 15, 3651.1753, -3196.8152, 127.30198, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 16, 3658.5908, -3188.9165, 126.71776, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 17, 3669.3274, -3183.5960, 126.359184, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 18, 3678.2393, -3171.0085, 126.507866, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 19, 3668.1770, -3166.6174, 126.90177, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 20, 3653.5696, -3174.7020, 127.15160, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 21, 3645.5012, -3185.9297, 127.69186, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 22, 3634.0906, -3178.5388, 129.00195, NULL, 0, 0, 0, 0, 0, 100, 0),
    (@PATH, 23, 3623.9392, -3180.2332, 130.64621, NULL, 0, 0, 0, 0, 0, 100, 0);

DELETE FROM `creature_template_spell` WHERE `CreatureID` = 10808;
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
    (10808, 0, 12787, 12340),
    (10808, 1, 17470, 12340),
    (10808, 2, 8599, 12340);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 10808 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (10808, 0, 0, 0, 0, 0, 100, 0, 10000, 15000, 10000, 15000, 0, 0, 11, 17470, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - In Combat - Cast Ravenous Claw'),
    (10808, 0, 1, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - Between 0-50% Health - Cast Enrage'),
    (10808, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Timmy the Cruel - On Aggro - Say Line 0');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1080800 AND `source_type` = 9;
