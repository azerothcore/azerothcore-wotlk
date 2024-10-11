-- DB update 2021_08_05_04 -> 2021_08_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_05_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_05_04 2021_08_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627568726175425000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627568726175425000');

-- Changed the spawn time from  2h45 to 24h
UPDATE `creature` SET `spawntimesecs` = 86400 WHERE (`id` = 14343) AND (`guid` IN (51897, 301303, 301304));

-- Added his 3 spawn points to the pool creature and added those 3 to a common pool template (365), with a max of 1 spawn at the same time
DELETE FROM `pool_template` WHERE `entry` = 365;

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (365, 1, "Olm the Wise Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (51897, 301303, 301304);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(51897, 365, 0, "Olm the Wise Spawn 1"),
(301303, 365, 0, "Olm the Wise Spawn 2"),
(301304, 365, 0, "Olm the Wise Spawn 3");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_06_00' WHERE sql_rev = '1627568726175425000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
