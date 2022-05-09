-- DB update 2021_11_22_02 -> 2021_11_22_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_22_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_22_02 2021_11_22_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637182861061114100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637182861061114100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (20619,21075);
INSERT INTO `conditions` VALUES
(13,1,20619,0,0,31,0,3,11663,0,0,0,0,'','Magic Reflection targets Flamewaker Healer'),
(13,1,20619,0,1,31,0,3,11664,0,0,0,0,'','Magic Reflection targets Flamewaker Elite'),
(13,1,21075,0,0,31,0,3,11663,0,0,0,0,'','Damage Shield targets Flamewaker Healer'),
(13,1,21075,0,1,31,0,3,11664,0,0,0,0,'','Damage Shield  targets Flamewaker Elite');

UPDATE `creature_summon_groups` SET `summonType`=7 WHERE `summonerId`=12018 AND `groupid`=1;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_22_03' WHERE sql_rev = '1637182861061114100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
