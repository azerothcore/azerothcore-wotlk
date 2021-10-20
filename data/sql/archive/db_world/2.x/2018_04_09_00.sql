-- DB update 2018_03_29_00 -> 2018_04_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_03_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_03_29_00 2018_04_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1523263107129022148'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1523263107129022148');

REPLACE INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (546, 530, 'instance_the_underbog', 0);
REPLACE INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (547, 530, 'instance_the_slave_pens', 0);
REPLACE INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (557, 530, 'instance_mana_tombs', 0);
REPLACE INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (558, 530, 'instance_auchenai_crypts', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
