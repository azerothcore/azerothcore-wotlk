DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2016_08_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;

ALTER TABLE version_db_characters CHANGE COLUMN 2016_08_25_00 2016_11_18_00 bit;

--
-- Do not remove this file when we archive sql under this folder
-- it is needed for pending sql importer
--

COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
