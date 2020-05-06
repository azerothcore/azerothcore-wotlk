DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2016_11_06_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;

ALTER TABLE version_db_world CHANGE COLUMN 2016_11_06_02 2016_11_18_00 bit;

--
-- Do not remove this file when we archive sql under this folder
-- it is needed for pending sql importer
--

COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
