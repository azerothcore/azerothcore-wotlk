-- DB update 2020_01_30_00 -> 2020_01_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_01_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_01_30_00 2020_01_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1579128650269731381'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1579128650269731381');

UPDATE `creature` SET `MovementType` = 1, `spawndist` = 20 WHERE `id` = 36173;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 36173 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3617300 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(36173,0,0,1,11,0,100,0,0,0,0,0,0,3,0,11686,0,0,0,0,1,0,0,0,0,0,0,0,0,'Innocuous Scarab - On Respawn - Morph Invisible Model'),
(36173,0,1,0,61,0,100,0,0,0,0,0,0,75,56422,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Innocuous Scarab - Linked - Add Aura ''Nerubian Submerge'''),
(36173,0,2,0,60,0,100,0,40000,90000,50000,100000,0,80,3617300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Innocuous Scarab - On Update - Call Action List'),

(3617300,9,0,0,0,0,100,0,0,0,0,0,0,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Innocuous Scarab - On Script - Demorph'),
(3617300,9,1,0,0,0,100,0,2000,2000,0,0,0,28,56422,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Innocuous Scarab - On Script - Remove Aura ''Nerubian Submerge'''),
(3617300,9,2,0,0,0,100,0,5000,30000,0,0,0,11,56422,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Innocuous Scarab - On Script - Cast Spell ''Nerubian Submerge'''),
(3617300,9,3,0,0,0,100,0,2000,2000,0,0,0,3,0,11686,0,0,0,0,1,0,0,0,0,0,0,0,0,'Innocuous Scarab - On Script - Morph Invisible Model');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
