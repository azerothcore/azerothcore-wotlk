-- DB update 2018_11_25_00 -> 2018_12_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_11_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_11_25_00 2018_12_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1543682164947860900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1543682164947860900');
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35400, '│Player %s %s (guid: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35401, '│ GM Mode active, Phase: -1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35402, '├─ Banned: (Type: %s, Reason: %s, Time: %s, By: %s)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35403, '├─ Muted: (Reason: %s, Time: %s, By: %s)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35404, '│ Account: %s (ID: %u), GMLevel: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35405, '│ Last Login: %s (Failed Logins: %u)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35406, '└ Registration Email: %s - Email: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
UPDATE `trinity_string` SET `content_default` = '│ Map: %s, Zone: %s' WHERE `entry` = 848;
UPDATE `trinity_string` SET `content_default` = '│ Mails: %d Read/%u Total' WHERE `entry` = 854;
INSERT INTO `trinity_string`(`entry`, `content_default`) VALUES (35407, 'No reason given.');
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35408, '<unauthorized>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `trinity_string`(`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (35409, '│ Map: %s, Zone: %s, Area: %s', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

