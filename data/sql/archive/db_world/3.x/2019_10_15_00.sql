-- DB update 2019_10_13_00 -> 2019_10_15_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_10_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_10_13_00 2019_10_15_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1570027461404402205'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1570027461404402205');

-- Earthen Elite, Earthen Warder: Set random movement to force fighting against the Iron Dwarves
UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` IN (29980,29981);

-- Loken: Slightly adjust his position on his throne
UPDATE `creature` SET `position_x` = 8563.95, `position_y` = -580.559 WHERE `guid` = 1955080;

-- Loken: Sitting on his throne is now controlled by SAI, not by creature addon
UPDATE `creature_template_addon` SET `bytes1` = 0 WHERE `entry` = 30396;

-- Veranus: Slightly adjust position
UPDATE `creature` SET `position_x` = 8719.71, `position_y` = -751.498, `position_z` = 970.977 WHERE `guid` = 49142;

-- SAI for Veranus, Thorim, Loken and Runeforged Servant
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (30420,30399,30396,30429);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (3042000,3039900,3039600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(30420,0,0,1,38,0,100,0,1,1,0,0,0,11,34427,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Data Set 1 1 - Cast ''Ethereal Teleport'''),
(30420,0,1,0,61,0,100,0,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - Linked - Despawn After 1 Second'),
(30420,0,2,0,1,0,100,0,160000,160000,160000,160000,0,70,0,0,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Veranus - OOC - Respawn Target'),

(3042000,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Set Active On'),
(3042000,9,1,0,0,0,100,0,0,0,0,0,0,28,54503,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Remove Aura ''Quest Invisibility 2'''),
(3042000,9,2,0,0,0,100,0,24000,24000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,8609.17,-636.666,967.317,2.12401,'Veranus - On Script - Move To Pos'),

(30399,0,0,0,11,0,100,0,0,0,0,0,0,71,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Respawn - Equip Weapon'),
(30399,0,1,2,62,0,100,0,9928,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Thorim - On Gossip Option Select - Close Gossip'),
(30399,0,2,3,61,0,100,0,0,0,0,0,0,28,54503,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - Linked - Remove Aura ''Quest Invisibility 2'''),
(30399,0,3,0,61,0,100,0,0,0,0,0,0,80,3039900,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - Linked - Run Script'),
(30399,0,4,0,38,0,100,0,1,1,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Data Set 1 1 - Despawn After 1 Second'),

(3039900,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Set Active On'),
(3039900,9,1,0,0,0,100,0,0,0,0,0,0,80,3042000,2,0,0,0,0,10,49142,30420,0,0,0,0,0,0,'Thorim - On Script - Run Script ''Veranus'''),
(3039900,9,2,0,0,0,100,0,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Remove NPC Flags'),
(3039900,9,3,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 1'),
(3039900,9,4,0,0,0,100,0,3000,3000,0,0,0,53,0,3039900,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Start WP Movement'),
(3039900,9,5,0,0,0,100,0,10000,10000,0,0,0,70,0,0,0,0,0,0,10,1955080,30396,0,0,0,0,0,0,'Thorim - On Script - Respawn ''Loken'''),
(3039900,9,6,0,0,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 2'),
(3039900,9,7,0,0,0,100,0,5000,5000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 3'),
(3039900,9,8,0,0,0,100,0,6000,6000,0,0,0,45,1,1,0,0,0,0,19,30396,30,0,0,0,0,0,0,'Thorim - On Script - Set Data 1 1 On ''Loken'''),
(3039900,9,9,0,0,0,100,0,12000,12000,0,0,0,11,56688,0,0,0,0,0,19,30396,30,0,0,0,0,0,0,'Thorim - On Script - Cast ''Thorim''s Knockback'''),
(3039900,9,10,0,0,0,100,0,2000,2000,0,0,0,46,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Move Forward'),
(3039900,9,11,0,0,0,100,0,2000,2000,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Set Home Position'),
(3039900,9,12,0,0,0,100,0,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 4'),
(3039900,9,13,0,0,0,100,0,2000,2000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 5'),
(3039900,9,14,0,0,0,100,0,2000,2000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 6'),
(3039900,9,15,0,0,0,100,0,1000,1000,0,0,0,11,56694,0,0,0,0,0,19,30396,100,0,0,0,0,0,0,'Thorim - On Script - Cast ''Lightning Fury'''),
(3039900,9,16,0,0,0,100,0,1500,1500,0,0,0,11,56695,0,0,0,0,0,19,30396,100,0,0,0,0,0,0,'Thorim - On Script - Cast ''Thorim''s Hammer'''),
(3039900,9,17,0,0,0,100,0,0,0,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Unequip Weapon'),

(30396,0,0,0,11,0,100,0,0,0,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Respawn - Set Unit Field Bytes1 ''UNIT_STAND_STATE_SIT'''),
(30396,0,1,2,38,0,100,0,1,1,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Data Set 1 1 - Remove Unit Field Bytes1 ''UNIT_STAND_STATE_SIT'''),
(30396,0,2,0,61,0,100,0,0,0,0,0,0,80,3039600,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - Linked - Run Script'),

(3039600,9,0,0,0,0,100,0,2000,2000,0,0,0,11,56677,0,0,0,0,0,19,30399,30,0,0,0,0,0,0,'Loken - On Script - Cast ''Loken''s Knockback'''),
(3039600,9,1,0,0,0,100,0,3000,3000,0,0,0,97,40,20,0,0,0,0,1,0,0,0,0,8611.14,-627.65,926.204,0,'Loken - On Script - Jump To Pos'),
(3039600,9,2,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 1'),
(3039600,9,3,0,0,0,100,0,1000,1000,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Play emote ''ONESHOT_POINT(DNR)'''),
(3039600,9,4,0,0,0,100,0,6000,6000,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Set Home Position'),
(3039600,9,5,0,0,0,100,0,10500,10500,0,0,0,11,10689,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Cast ''Knockback'''),
(3039600,9,6,0,0,0,100,0,3000,3000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 2'),
(3039600,9,7,0,0,0,100,0,2000,2000,0,0,0,69,25,0,0,0,0,0,8,0,0,0,0,8568.76,-606.488,925.559,0,'Loken - On Script - Move To Pos'),
(3039600,9,8,0,0,0,100,0,4000,4000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 3'),
(3039600,9,9,0,0,0,100,0,6000,6000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 4'),
(3039600,9,10,0,0,0,100,0,1000,1000,0,0,0,11,56696,0,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Loken - On Script - Cast ''Loken - Defeat Thorim'''),
(3039600,9,11,0,0,0,100,0,0,0,0,0,0,75,56696,0,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Loken - On Script - Add Aura ''Loken - Defeat Thorim'''),
(3039600,9,12,0,0,0,100,0,6000,6000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 5'),
(3039600,9,13,0,0,0,100,0,7000,7000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 6'),
(3039600,9,14,0,0,0,100,0,0,0,0,0,0,12,30429,1,60000,0,0,0,8,0,0,0,0,8622.84,-605.789,926.286,4.43314,'Loken - On Script - Spawn ''Runeforged Servant'''),
(3039600,9,15,0,0,0,100,0,0,0,0,0,0,12,30429,1,60000,0,0,0,8,0,0,0,0,8586.87,-564.764,925.641,5.16617,'Loken - On Script - Spawn ''Runeforged Servant'''),
(3039600,9,16,0,0,0,100,0,7000,7000,0,0,0,1,6,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Loken - On Script - Say Line 7'),
(3039600,9,17,0,0,0,100,0,7000,7000,0,0,0,1,7,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Loken - On Script - Say Line 8'),
(3039600,9,18,0,0,0,100,0,5000,5000,0,0,0,11,56941,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Cast ''Witness the Reckoning'''),
(3039600,9,19,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Loken - On Script - Set Data 1 1 to ''Thorim'''),
(3039600,9,20,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,10,49142,30420,0,0,0,0,0,0,'Loken - On Script - Set Data 1 1 to ''Veranus'''),
(3039600,9,21,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,9,30429,0,200,0,0,0,0,0,'Loken - On Script - Set Data 1 1 to ''Runeforged Servant'''),
(3039600,9,22,0,0,0,100,0,0,0,0,0,0,11,34427,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Cast ''Ethereal Teleport'''),
(3039600,9,23,0,0,0,100,0,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Despawn After 1 Second'),

(30429,0,0,1,38,0,100,0,1,1,0,0,0,11,34427,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runeforged Servant - On Data Set 1 1 - Cast ''Ethereal Teleport'''),
(30429,0,1,0,61,0,100,0,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Runeforged Servant - Linked - Despawn After 1 Second');

-- Thorim: New waypoint path
DELETE FROM `waypoints` WHERE `entry` IN (30399,3039900); -- Old WP path 30399 not needed anymore
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(3039900,1,8695.3,-703.023,933.672,'Thorim - The Reckoning'),
(3039900,2,8688.26,-696.381,932.802,''),
(3039900,3,8680.31,-688.831,930.953,''),
(3039900,4,8672.82,-681.81,929.133,''),
(3039900,5,8666.02,-675.593,927.207,''),
(3039900,6,8659.32,-669.424,924.904,''),
(3039900,7,8652.4,-662.992,922.517,''),
(3039900,8,8650.85,-661.499,923.67,''),
(3039900,9,8646.61,-657.15,923.886,''),
(3039900,10,8640.08,-650.813,923.668,''),
(3039900,11,8636.42,-647.304,923.366,''),
(3039900,12,8632.65,-643.688,924.368,''),
(3039900,13,8628.64,-639.923,925.278,''),
(3039900,14,8624.98,-636.499,926.056,''),
(3039900,15,8620.3,-632.119,926.204,''),
(3039900,16,8614.32,-626.557,926.204,''),
(3039900,17,8607.65,-620.366,926.204,''),
(3039900,18,8600.89,-614.094,925.559,''),
(3039900,19,8594.45,-608.167,925.559,''),
(3039900,20,8588.71,-603.394,925.559,''),
(3039900,21,8582.29,-597.977,925.559,''),
(3039900,22,8577.78,-593.913,925.559,''),
(3039900,23,8573.66,-590.061,925.559,'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
