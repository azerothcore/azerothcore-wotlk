-- DB update 2020_03_28_00 -> 2020_03_29_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_03_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_03_28_00 2020_03_29_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1583866008487985900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583866008487985900');

UPDATE `creature_template` SET `type_flags`=`type_flags`|134217728, `gossip_menu_id` = 10649 WHERE `entry` = 35477;

DELETE FROM `creature` WHERE `guid` IN (120676);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(120676, 35477, 0, 1, 1, 0, 1, -8827.98, 515.408, 98.6826, 6.00393, 180, 0, 0, 0, 0, 0);

DELETE FROM `gossip_menu` WHERE `MenuID` = 10649;
INSERT INTO `gossip_menu` (`MenuID`, `TextId`) VALUE
(10649, 14752);

DELETE FROM `gossip_menu_option` WHERE `MenuID`=10649;
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`) VALUES
(10649, 0, 0, 'Yes I do!', 35835, 1, 1);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=35477;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (35477) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(35477, 0, 0, 1, 62, 0, 100, 0, 10649, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Little Adeline - On gossip select - Close gossip'),
(35477, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 67554, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Little Adeline - On gossip select - Cast Spell Cascade of Petals');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
