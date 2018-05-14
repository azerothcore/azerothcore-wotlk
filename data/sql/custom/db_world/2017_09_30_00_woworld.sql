DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'locales_quest' AND COLUMN_NAME = 'Title_loc0';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;

ALTER TABLE `locales_quest` DROP COLUMN `Title_loc0`;

--
-- Do not remove this file when we archive sql under this folder
-- it is needed for pending sql importer
--

COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
ALTER TABLE `locales_quest`ADD COLUMN `Title_loc0` TEXT NULL AFTER `Id`;
