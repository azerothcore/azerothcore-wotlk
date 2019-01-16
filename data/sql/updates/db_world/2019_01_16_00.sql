-- DB update 2019_01_15_00 -> 2019_01_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_15_00 2019_01_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1547598400341720700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547598400341720700');

DELETE FROM `command` WHERE `name` IN ('spy follow', 'spy unfollow', 'spy groupfollow', 'spy groupunfollow', 'spy clear', 'spy status');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('spy follow',          2, 'Syntax: .spy follow [$name]\nStarts reading all the private conversations of that player.'),
('spy unfollow',        2, 'Syntax: .spy unfollow [$name]\nStops reading private messages from that player.'),
('spy groupfollow',     3, 'Syntax: .spy groupfollow [$name]\nStarts reading all the private conversations of that player and his current party.'),
('spy groupunfollow',   3, 'Syntax: .spy groupunfollow [$name]\nStops reading private messages from that player\'s party.'),
('spy clear',           2, 'Syntax: .spy clear\nClears your current spying list, removing every player from it.'),
('spy status',          2, 'Syntax: .spy status\nShows your current spying list.');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
