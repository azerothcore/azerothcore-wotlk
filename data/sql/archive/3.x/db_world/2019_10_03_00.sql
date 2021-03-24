-- DB update 2019_10_02_00 -> 2019_10_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_10_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_10_02_00 2019_10_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1568383989969278689'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1568383989969278689');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 20071 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(20071,0,0,1,62,0,100,0,8071,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - On Gossip Select - Set Active On'),
(20071,0,1,2,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Say Line 0'),
(20071,0,2,3,61,0,100,0,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Close Gossip'),
(20071,0,3,4,61,0,100,0,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Set NPC Flags'),
(20071,0,4,0,61,0,100,0,0,0,0,0,0,67,1,3000,3000,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Create Timed Event ID 1'),
(20071,0,5,0,59,0,100,0,1,0,0,0,0,53,0,20071,0,0,0,1,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - On Timed Event ID 1 - Start WP'),
(20071,0,6,7,40,0,100,0,15,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,'Wind Trader Marid - WP Reached - Set Orientation'),
(20071,0,7,8,61,0,100,0,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Say Line 1'),
(20071,0,8,9,61,0,100,0,0,0,0,0,0,67,2,4000,4000,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Create Timed Event ID 2'),
(20071,0,9,0,61,0,100,0,0,0,0,0,0,41,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Force Despawn After 5 Minutes'),
(20071,0,10,11,59,0,100,0,2,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - On Timed Event ID 2 - Set Faction'),
(20071,0,11,12,61,0,100,0,0,0,0,0,0,12,20101,4,10000,0,0,0,8,0,0,0,0,4327.28,2133.79,126.42,2.88,'Wind Trader Marid - Linked - Summon Creature'),
(20071,0,12,13,61,0,100,0,0,0,0,0,0,12,20101,4,10000,0,0,0,8,0,0,0,0,4328.97,2140.08,124.66,2.88,'Wind Trader Marid - Linked - Summon Creature'),
(20071,0,13,14,61,0,100,0,0,0,0,0,0,19,768,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Remove Unit Flags'),
(20071,0,14,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,20,0,0,0,0,0,0,0,'Wind Trader Marid - Linked - Attack Start');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
