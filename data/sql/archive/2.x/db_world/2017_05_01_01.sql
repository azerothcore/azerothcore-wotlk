-- DB update 2017_05_01_00 -> 2017_05_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_05_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_05_01_00 2017_05_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1489225360977584500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1489225360977584500');

-- Command disable
DELETE FROM `command` WHERE `name` IN (
'disable add quest','disable add map','disable add battleground','disable add spell','disable add outdoorpvp','disable add vmap',
'disable remove quest','disable remove map','disable remove battleground','disable remove spell','disable remove outdoorpvp','disable remove vmap'
);
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('disable add quest',3,'Syntax: .disable add quest $entry $flag $comment'),
('disable add map',3,'Syntax: .disable add map $entry $flag $comment'),
('disable add battleground',3,'Syntax: .disable add battleground $entry $flag $comment'),
('disable add spell',3,'Syntax: .disable add spell $entry $flag $comment'),
('disable add outdoorpvp',3,'Syntax: .disable add outdoorpvp $entry $flag $comment'),
('disable add vmap',3,'Syntax: .disable add vmap $entry $flag $comment'),
('disable remove quest',3,'Syntax: .disable remove quest $entry'),
('disable remove map',3,'Syntax: .disable remove map $entry'),
('disable remove battleground',3,'Syntax: .disable remove battleground $entry'),
('disable remove spell',3,'Syntax: .disable remove spell $entry'),
('disable remove outdoorpvp',3,'Syntax: .disable remove outdoorpvp $entry'),
('disable remove vmap',3,'Syntax: .disable remove vmap $entry');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
