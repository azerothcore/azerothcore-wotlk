-- DB update 2021_05_10_03 -> 2021_05_10_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_10_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_10_03 2021_05_10_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620463648528240165'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620463648528240165');

UPDATE `gameobject` SET `spawntimesecs`= 2700 WHERE FIND_IN_SET (`id`,'324,150082,176643,123848'); -- Small Thorium
UPDATE `gameobject` SET `spawntimesecs`= 2700 WHERE FIND_IN_SET (`id`,'175404,177388'); -- Rich Thorium
UPDATE `gameobject` SET `spawntimesecs`= 604800 WHERE FIND_IN_SET (`id`,'175404') AND `map` = 429; -- Rich Thorium in Uldaman

UPDATE `gameobject` SET `spawntimesecs`= 1800 WHERE FIND_IN_SET (`id`,'2040,150079,176645,123310'); -- Mithril
UPDATE `gameobject` SET `spawntimesecs`= 604800 WHERE FIND_IN_SET (`id`,'2040') AND `map` = 349; -- Mithril Mauradon

UPDATE `gameobject` SET `spawntimesecs`= 2700 WHERE FIND_IN_SET (`id`,'2047,150081,181108,123309'); -- Truesilver
UPDATE `gameobject` SET `spawntimesecs`= 604800 WHERE FIND_IN_SET (`id`,'2040') AND `map` = 349; -- Truesilver Mauradon


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
