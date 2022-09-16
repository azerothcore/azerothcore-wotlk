-- DB update 2020_12_28_00 -> 2020_12_28_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_28_00 2020_12_28_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1608651525587192300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1608651525587192300');

UPDATE `acore_string` SET `content_default`='¦ Last IP: %s (Locked: %s)' WHERE  `entry`=752;
UPDATE `acore_string` SET `content_default`='¦ OS: %s - Latency: %u ms' WHERE  `entry`=749;
UPDATE `acore_string` SET `content_default`='¦ Level: %u (%u/%u XP (%u XP left))' WHERE  `entry`=843;
UPDATE `acore_string` SET `content_default`='¦ Race: %s %s, %s' WHERE  `entry`=844;
UPDATE `acore_string` SET `content_default`='¦ Alive ?: %s' WHERE  `entry`=845;
UPDATE `acore_string` SET `content_default`='¦ Phase: %u' WHERE  `entry`=846;
UPDATE `acore_string` SET `content_default`='¦ Money: %ug%us%uc' WHERE  `entry`=847;
UPDATE `acore_string` SET `content_default`='¦ Map: %s, Zone: %s' WHERE  `entry`=848;
UPDATE `acore_string` SET `content_default`='¦ Guild: %s (ID: %u)' WHERE  `entry`=849;
UPDATE `acore_string` SET `content_default`='¦ Played time: %s' WHERE  `entry`=853;
UPDATE `acore_string` SET `content_default`='¦ Mails: %d Read/%u Total' WHERE  `entry`=854;
UPDATE `acore_string` SET `content_default`='¦ Level: %u' WHERE  `entry`=871;
UPDATE `acore_string` SET `content_default`='¦ Registration Email: %s - Email: %s' WHERE  `entry`=879;
UPDATE `acore_string` SET `content_default`='¦ Player %s %s (guid: %u)' WHERE  `entry`=35400;
UPDATE `acore_string` SET `content_default`='¦ GM Mode active, Phase: -1' WHERE  `entry`=35401;
UPDATE `acore_string` SET `content_default`='¦ Account: %s (ID: %u), GMLevel: %u' WHERE  `entry`=35404;
UPDATE `acore_string` SET `content_default`='¦ Last Login: %s (Failed Logins: %u)' WHERE  `entry`=35405;
UPDATE `acore_string` SET `content_default`='¦ Map: %s, Zone: %s, Area: %s' WHERE  `entry`=35409;
UPDATE `acore_string` SET `content_default`='¦ Registration Email: %s - Email: %s' WHERE  `entry`=35406;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
