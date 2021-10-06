-- DB update 2021_09_11_01 -> 2021_09_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_11_01 2021_09_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630714167178408255'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630714167178408255');

DELETE FROM `command` WHERE `name` IN ('repairitems', 'gear repair', 'gear stats');

INSERT INTO `command` VALUES
('gear repair', 2, 'Syntax: .gear repair \nRepair all selected player''s items.'),
('gear stats', 0, 'Syntax: .gear stats');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_12_00' WHERE sql_rev = '1630714167178408255';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
