-- DB update 2019_06_23_00 -> 2019_06_23_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_23_00 2019_06_23_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1560635682234587998'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560635682234587998');

UPDATE `creature_template` SET `InhabitType` = 1, `HoverHeight` = 5 WHERE `entry` = 32406;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 32406 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 3240600 AND 3240607 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(32406,0,0,1,54,0,100,0,0,0,0,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ominous Cloud - On Just Summoned - Set Aggressive'),
(32406,0,1,2,61,0,100,0,0,0,0,0,0,207,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ominous Cloud - Linked - Set Hover On'),
(32406,0,2,3,61,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ominous Cloud - Linked - Stop Auto Attack'),
(32406,0,3,0,61,0,100,0,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ominous Cloud - Linked - Stop Combat Movement'),
(32406,0,4,0,0,0,100,0,0,0,10000,10000,0,88,3240600,3240607,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ominous Cloud - IC - Call Random Action List'),
(3240600,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,0,10,0,0,'Ominous Cloud - On Script - Jump To Pos'),
(3240601,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,0,-10,0,0,'Ominous Cloud - On Script - Jump To Pos'),
(3240602,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,10,0,0,0,'Ominous Cloud - On Script - Jump To Pos'),
(3240603,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,-10,0,0,0,'Ominous Cloud - On Script - Jump To Pos'),
(3240604,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,7,7,0,0,'Ominous Cloud - On Script - Jump To Pos'),
(3240605,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,7,-7,0,0,'Ominous Cloud - On Script - Jump To Pos'),
(3240606,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,-7,7,0,0,'Ominous Cloud - On Script - Jump To Pos'),
(3240607,9,0,0,0,0,100,0,0,0,0,0,0,97,0.5,0.5,1,0,0,0,1,0,0,0,0,-7,-7,0,0,'Ominous Cloud - On Script - Jump To Pos');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
