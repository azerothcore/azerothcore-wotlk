-- DB update 2017_11_14_00 -> 2017_11_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_11_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_11_14_00 2017_11_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1510696617496219500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1510696617496219500');

DELETE FROM `command` WHERE `name`='mmap' OR `name` LIKE 'mmap%';
DELETE FROM `command` WHERE `name` LIKE 'disable add mmap' OR `name` LIKE 'disable remove mmap';
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('mmap', 3, 'Syntax: Syntax: .mmaps $subcommand Type .mmaps to see the list of possible subcommands or .help mmaps $subcommand to see info on subcommands'),
('mmap path', 3, 'Syntax: .mmap path to calculate and show a path to current select unit'),
('mmap loc', 3, 'Syntax: .mmap loc to print on which tile one is'),
('mmap loadedtiles', 3, 'Syntax: .mmap loadedtiles to show which tiles are currently loaded'),
('mmap stats', 3, 'Syntax: .mmap stats to show information about current state of mmaps'),
('mmap testarea', 3, 'Syntax: .mmap testarea to calculate paths for all nearby npcs to player');--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
