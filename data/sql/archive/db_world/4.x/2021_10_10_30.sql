-- DB update 2021_10_10_29 -> 2021_10_10_30
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_29';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_29 2021_10_10_30 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633629039825879400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633629039825879400');

UPDATE `gameobject` SET `spawntimesecs`=480 WHERE `id`=179487;
UPDATE `gameobject` SET `spawntimesecs`=300 WHERE `id`=179498;
UPDATE `gameobject` SET `spawntimesecs`=180 WHERE `id`=179493;
UPDATE `gameobject` SET `spawntimesecs`=600 WHERE `id`=184741;
UPDATE `gameobject` SET `spawntimesecs`=7200 WHERE `id`=179496;
UPDATE `gameobject` SET `spawntimesecs`=600 WHERE `id`=179494;
UPDATE `gameobject` SET `spawntimesecs`=7200 WHERE `id`=179488;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_30' WHERE sql_rev = '1633629039825879400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
