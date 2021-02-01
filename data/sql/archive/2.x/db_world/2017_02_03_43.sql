-- DB update 2017_02_03_42 -> 2017_02_03_43
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_02_03_42';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_42 2017_02_03_43 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1485734753369055900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1485734753369055900');
-- SET run_speed of (Thunder BluffSilvermoon, Undercity, Stormwind, Ironforge, Exodar, Gnomeregan and Darnassus Champion(s) from 2 to 1.38571)
UPDATE `creature_template` SET `speed_run` = 1.38571  WHERE `entry` IN (35325, 35326, 35327, 35328, 35329, 35330, 35331, 35332);

-- SET run_speed of (Colosos, Marshal Jacob Alerius, Ambrose Boltspark, Lana Stouthammer and Jaelyne Evensong from 2 to 1.14286)
UPDATE `creature_template` SET `speed_run` = 1.14286  WHERE `entry` IN (34657, 34701, 34702, 34703, 34705);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
