-- DB update 2017_08_19_19 -> 2017_08_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_19_19';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_19_19 2017_08_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1498796247453520600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1498796247453520600');

DROP TABLE IF EXISTS ip2nation;
DROP TABLE IF EXISTS ip2nationCountries;

DELETE FROM `command` WHERE `name` in ('account lock', 'account lock ip', 'account lock country');
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('account lock ip', 0, 'Syntax: .account lock ip [on|off]\nAllow login from account only from current used IP or remove this requirement.'),
('account lock country', 0, 'Syntax: .account lock country [on|off]\nAllow login from account only from current used Country or remove this requirement.');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
