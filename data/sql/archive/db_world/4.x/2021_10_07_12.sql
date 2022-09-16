-- DB update 2021_10_07_11 -> 2021_10_07_12
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_11';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_11 2021_10_07_12 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633368419901196100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633368419901196100');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 17500;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(17500, 17499, 0, 'Malown\'s Slam - trigger Surge of Strenght');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_12' WHERE sql_rev = '1633368419901196100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
