-- DB update 2021_07_29_01 -> 2021_07_29_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_29_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_29_01 2021_07_29_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627110823308609260'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627110823308609260');

-- Set Dreadscorn respawn to 6.5 hours
UPDATE `creature` SET `spawntimesecs` = 23400 WHERE `id` = 8304 AND `guid` = 3902;

-- Set Gnarl Leafbrother respawn to 40 hours
UPDATE `creature` SET `spawntimesecs` = 144000 WHERE `id` = 5354 AND `guid` = 51842;

-- Set Cranky Benj respawn to 40 hours
UPDATE `creature` SET `spawntimesecs` = 144000 WHERE `id` = 14223 AND `guid` = 90511;

-- Set Azzere the Skyblade respawn to 5 hours
UPDATE `creature` SET `spawntimesecs` = 18000 WHERE `id` = 5834 AND `guid` = 51813;

-- Set Accursed Slitherblade respawn to 26.5 hours
UPDATE `creature` SET `spawntimesecs` = 95400 WHERE `id` = 14229 AND `guid` = 51846;

-- Set Giggler respawn to 13 hours
UPDATE `creature` SET `spawntimesecs` = 46800 WHERE `id` = 14228 AND `guid` = 51847;

-- Set Verifonix respawn to 26.5 hours
UPDATE `creature` SET `spawntimesecs` = 95400 WHERE `id` = 14492 AND `guid` IN (49152, 134231, 134232, 134233, 134234, 134235);

-- Set Diamond Head respawn to 13 hours
UPDATE `creature` SET `spawntimesecs` = 46800 WHERE `id` = 5345 AND `guid` = 51843;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_29_02' WHERE sql_rev = '1627110823308609260';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
