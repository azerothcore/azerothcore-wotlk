-- DB update 2020_08_19_00 -> 2020_08_19_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_19_00 2020_08_19_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1576659911412868500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1576659911412868500');

DELETE FROM `command` WHERE `name` IN ('bank', 'character check bank', 'character check bag', 'character check profession');

INSERT INTO `command` VALUES
('character check bank', 2, 'Syntax: .character check bank \r\n\r\nShow your bank inventory.'),
('character check bag', 2, 'Syntax: .character check bag [$target_player]\r #bagSlot 1 - 4'),
('character check profession', 2, 'Syntax: .character check profession [$target_player]\r\nShow known professions list for selected player');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
