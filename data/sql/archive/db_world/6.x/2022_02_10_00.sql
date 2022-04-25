-- DB update 2022_02_09_00 -> 2022_02_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_09_00 2022_02_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643155057631411400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643155057631411400');

DELETE FROM `creature_text` WHERE `CreatureID` = 6109;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(6109, 0, 0, 'Come, little ones. Face me!', 14, 0, 100, 0, 0, 0, 9071, 2, 'Azuregos - On Teleport'),
(6109, 1, 0, 'This place is under my protection. The mysteries of the arcane shall remain inviolate.', 14, 0, 100, 0, 0, 0, 9072, 2, 'Azuregos - On Aggro'),
(6109, 2, 0, 'Such is the price of curiosity.', 14, 0, 100, 0, 0, 0, 9073, 2, 'Azuregos - On Unit Killed');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_arcane_vacuum', 'spell_mark_of_frost_freeze');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(21147, 'spell_arcane_vacuum'),
(23183, 'spell_mark_of_frost_freeze');

UPDATE `spell_dbc` SET `DurationIndex` = 1, `EffectRadiusIndex_1` = 11 WHERE `ID` = 23183;

SET @NPC := 52349;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@NPC,@PATH,0,0,0,0,0, '');

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH, 1, 2623.38, -5977.86, 100.642, 3.86238, 0, 0, 0, 100, 0),
(@PATH, 2, 2652.61, -6023.30, 97.2364, 4.28178, 0, 0, 0, 100, 0),
(@PATH, 3, 2637.75, -6057.12, 100.789, 4.96744, 0, 0, 0, 100, 0),
(@PATH, 4, 2650.16, -6101.06, 99.1050, 4.99335, 0, 0, 0, 100, 0),
(@PATH, 5, 2659.07, -6142.42, 100.017, 5.61225, 0, 0, 0, 100, 0),
(@PATH, 6, 2699.18, -6169.74, 97.2345, 5.90834, 0, 0, 0, 100, 0),
(@PATH, 7, 2748.81, -6216.27, 102.323, 5.52506, 0, 0, 0, 100, 0),
(@PATH, 8, 2728.22, -6259.92, 99.7664, 1.50304, 0, 0, 0, 100, 0),
(@PATH, 9, 2701.59, -6292.38, 98.4016, 1.01845, 0, 0, 0, 100, 0),
(@PATH, 10, 2665.81, -6316.73, 100.927, 3.15866, 0, 0, 0, 100, 0),
(@PATH, 11, 2639.08, -6319.14, 93.82, 3.16179, 0, 0, 0, 100, 0),
(@PATH, 12, 2609.81, -6316.40, 95.62, 2.8822, 0, 0, 0, 100, 0),
(@PATH, 13, 2593.02, -6298.90, 103.16, 2.55862, 0, 0, 0, 100, 0),
(@PATH, 14, 2502.05, -6238.91, 102.5, 2.55862, 0, 0, 0, 100, 0),
(@PATH, 15, 2484.14, -6233.41, 101.99, 3.24663, 0, 0, 0, 100, 0),
(@PATH, 16, 2450.22, -6182.88, 101.45, 2.20912, 0, 0, 0, 100, 0),
(@PATH, 17, 2411.61, -6157.76, 101.92, 3.54822, 0, 0, 0, 100, 0),
(@PATH, 18, 2361.36, -6203.64, 104.65, 4.13334, 0, 0, 0, 100, 0),
(@PATH, 19, 2336.04, -6248.55, 106.4, 4.62264, 0, 0, 0, 100, 0),
(@PATH, 20, 2361.63, -6203.64, 104.65, 0.89043, 0, 0, 0, 100, 0),
(@PATH, 21, 2406.65, -6164.80, 100.57, 0.92734, 0, 0, 0, 100, 0),
(@PATH, 22, 2407.32, -6147.17, 100.29, 2.08345, 0, 0, 0, 100, 0),
(@PATH, 23, 2352.5 , -6106.48, 110.44, 2.66543, 0, 0, 0, 100, 0),
(@PATH, 24, 2294.35, -6064.86, 107.44, 2.19419, 0, 0, 0, 100, 0),
(@PATH, 25, 2352.5 , -6106.48, 110.44, 2.66543, 0, 0, 0, 100, 0),
(@PATH, 26, 2406.58, -6133.30, 99.69, 5.90284, 0, 0, 0, 100, 0),
(@PATH, 27, 2439.64, -6126.91, 105.12, 0.38778, 0, 0, 0, 100, 0),
(@PATH, 28, 2501.26, -6091.94, 99.97, 0.60926, 0, 0, 0, 100, 0),
(@PATH, 29, 2535.65, -6010.90, 99.62, 1.07893, 0, 0, 0, 100, 0),
(@PATH, 30, 2578.13, -5963.59, 97.82, 0.00136, 0, 0, 0, 100, 0);

SET @NPC := 35867;
SET @PATH := @NPC * 10;

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@NPC,@PATH,0,0,4097,0,0, '');

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH, 1, 2578.13, -5963.59, 97.82, 0.00136, 0, 0, 0, 100, 0),
(@PATH, 2, 2535.65, -6010.90, 99.62, 1.07893, 0, 0, 0, 100, 0),
(@PATH, 3, 2501.26, -6091.94, 99.97, 0.60926, 0, 0, 0, 100, 0),
(@PATH, 4, 2439.64, -6126.91, 105.12, 0.38778, 0, 0, 0, 100, 0),
(@PATH, 5, 2406.58, -6133.30, 99.69, 5.90284, 0, 0, 0, 100, 0),
(@PATH, 6, 2352.50, -6106.48, 110.44, 2.66543, 0, 0, 0, 100, 0),
(@PATH, 7, 2294.35, -6064.86, 107.44, 2.19419, 0, 0, 0, 100, 0),
(@PATH, 8, 2352.50, -6106.48, 110.44, 2.66543, 0, 0, 0, 100, 0),
(@PATH, 9, 2407.32, -6147.17, 100.29, 2.08345, 0, 0, 0, 100, 0),
(@PATH, 10, 2406.65, -6164.80, 100.57, 0.92734, 0, 0, 0, 100, 0),
(@PATH, 11, 2361.63, -6203.64, 104.65, 0.89043, 0, 0, 0, 100, 0),
(@PATH, 12, 2336.04, -6248.55, 106.40, 4.62264, 0, 0, 0, 100, 0),
(@PATH, 13, 2361.36, -6203.64, 104.65, 4.13334, 0, 0, 0, 100, 0),
(@PATH, 14, 2411.61, -6157.76, 101.92, 3.54822, 0, 0, 0, 100, 0),
(@PATH, 15, 2450.22, -6182.88, 101.45, 2.20912, 0, 0, 0, 100, 0),
(@PATH, 16, 2484.14, -6233.41, 101.99, 3.24663, 0, 0, 0, 100, 0),
(@PATH, 17, 2502.05, -6238.91, 102.50, 2.55862, 0, 0, 0, 100, 0),
(@PATH, 18, 2593.02, -6298.90, 103.16, 2.55862, 0, 0, 0, 100, 0),
(@PATH, 19, 2609.81, -6316.40, 95.62, 2.8822, 0, 0, 0, 100, 0),
(@PATH, 20, 2639.08, -6319.14, 93.82, 3.16179, 0, 0, 0, 100, 0),
(@PATH, 21, 2665.81, -6316.73, 100.927, 3.15866, 0, 0, 0, 100, 0),
(@PATH, 22, 2701.59, -6292.38, 98.4016, 1.01845, 0, 0, 0, 100, 0),
(@PATH, 23, 2728.22, -6259.92, 99.7664, 1.50304, 0, 0, 0, 100, 0),
(@PATH, 24, 2748.81, -6216.27, 102.323, 5.52506, 0, 0, 0, 100, 0),
(@PATH, 25, 2699.18, -6169.74, 97.2345, 5.90834, 0, 0, 0, 100, 0),
(@PATH, 26, 2659.07, -6142.42, 100.017, 5.61225, 0, 0, 0, 100, 0),
(@PATH, 27, 2650.16, -6101.06, 99.105, 4.99335, 0, 0, 0, 100, 0),
(@PATH, 28, 2637.75, -6057.12, 100.789, 4.96744, 0, 0, 0, 100, 0),
(@PATH, 29, 2652.61, -6023.30, 97.2364, 4.28178, 0, 0, 0, 100, 0),
(@PATH, 30, 2623.38, -5977.86, 100.642, 3.86238, 0, 0, 0, 100, 0);

UPDATE `creature_template` SET `npcflag` = `npcflag`|1, `gossip_menu_id` = 15000 WHERE `entry` = 6109;
DELETE FROM `gossip_menu` WHERE `MenuID` = 15000;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(15000, 7880);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 15000;
INSERT INTO `gossip_menu_option` (`MenuID`,`OptionID`,`OptionIcon`,`OptionText`,`OptionBroadcastTextID`,`OptionType`,`OptionNpcFlag`,`ActionMenuID`,`ActionPoiID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`VerifiedBuild`) VALUES
(15000, 0, 0, 'I am a treasure hunter in search of powerful artifacts. Give them to me and you will not be harmed.', 11016, 1, 1, 0, 0, 0, 0, '', 0, 12340);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_10_00' WHERE sql_rev = '1643155057631411400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
