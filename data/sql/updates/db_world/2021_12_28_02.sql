-- DB update 2021_12_28_01 -> 2021_12_28_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_28_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_28_01 2021_12_28_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640101290532601454'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640101290532601454');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (16329) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(16329,0,0,0,4,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dar''Khan Drathir - On Aggro - Say 0'),
(16329,0,1,0,0,0,100,0,0,0,3000,6000,0,11,20791,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Dar''Khan Drathir - In Combat - Cast ''Shadow Bolt'''),
(16329,0,2,0,0,0,100,0,9000,12000,27000,31000,0,11,21068,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Dar''Khan Drathir - In Combat - Cast ''Corruption'''),
(16329,0,3,0,0,0,100,0,19000,24000,21000,25000,0,11,38660,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Dar''Khan Drathir - In Combat - Cast ''Fear''');
DELETE FROM `creature_text` WHERE `CreatureID`=16329;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(16329,0,0,'Death is the price you shall pay for this insolence!',12,0,100,0,0,0,12223,0,'Dar''Khan Drathir'),
(16329,0,1,'Mortal fools!  The ghouls of Deatholme will feast on your remains!',12,0,100,0,0,0,12224,0,'Dar''Khan Drathir'),
(16329,0,2,'Your deaths shall be slow and painful!',12,0,100,0,0,0,12225,0,'Dar''Khan Drathir');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_28_02' WHERE sql_rev = '1640101290532601454';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
