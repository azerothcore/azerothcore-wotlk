-- DB update 2019_06_15_00 -> 2019_06_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_15_00 2019_06_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1559857922897245970'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559857922897245970');

DELETE FROM `creature` WHERE `guid` IN (201212,201213,201214);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES
(201212,28083,571,0,0,1,1,20595,0,4828.275,4759.095,-75.660,3.921138,300,5,0,11770,0,1,0,0,0,'',0),
(201213,28083,571,0,0,1,1,20595,0,4767.104,4694.607,-67.343,5.262608,300,5,0,11770,0,1,0,0,0,'',0),
(201214,28083,571,0,0,1,1,20595,0,4859.410,4397.716,-62.169,4.507830,300,5,0,11770,0,1,0,0,0,'',0);

DELETE FROM `pool_template` WHERE `entry` = 201212;
INSERT INTO pool_template (`entry`,`max_limit`,`description`)
VALUES
(201212,1,'Serfex the Reaver Spawn (1 out 4)');

DELETE FROM `pool_creature` WHERE `pool_entry` = 201212;
INSERT INTO pool_creature(`guid`,`pool_entry`,`chance`,`description`)
VALUES
(201212,201212,0,'Serfex the Reaver 1'),
(201213,201212,0,'Serfex the Reaver 2'),
(201214,201212,0,'Serfex the Reaver 3'),
(112864,201212,0,'Serfex the Reaver 4');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 28083 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(28083,0,0,1,4,0,100,0,0,0,0,0,0,28,29147,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - On Aggro - Remove Aura ''Tunnel Bore Passive'''),
(28083,0,1,2,61,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - Linked - Set Root On'),
(28083,0,2,3,61,0,100,0,0,0,0,0,0,19,33554434,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - Linked - Remove Flags Not Attackable & Not Selectable'),
(28083,0,3,0,61,0,100,0,0,0,0,0,0,91,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - Linked - Remove ''UNIT_STAND_STATE_SUBMERGED'''),
(28083,0,4,0,9,0,100,0,1,50,2000,3500,0,11,31747,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Serfex the Reaver - Within Range 1-50yd - Cast Poison'),
(28083,0,5,6,25,0,100,0,0,0,0,0,0,103,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - On Reset - Set Root Off'),
(28083,0,6,7,61,0,100,0,0,0,0,0,0,11,29147,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - Linked - Cast ''Tunnel Bore Passive'''),
(28083,0,7,8,61,0,100,0,0,0,0,0,0,18,33554434,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - Linked - Set Flags Not Attackable & Not Selectable'),
(28083,0,8,0,61,0,100,0,0,0,0,0,0,90,9,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Serfex the Reaver - Linked - Set ''UNIT_STAND_STATE_SUBMERGED'''),
(28083,0,9,0,6,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,9,28215,0,50,0,0,0,0,0,'Serfex the Reaver - On Just Died - Set Data 1 2');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
