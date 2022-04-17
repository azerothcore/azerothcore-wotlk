-- DB update 2022_04_01_05 -> 2022_04_01_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_01_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_01_05 2022_04_01_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648012632855324300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648012632855324300');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_item_brittle_armor','spell_item_mercurial_shield');
INSERT INTO `spell_script_names` VALUES
(24590,'spell_item_brittle_armor'),
(26465,'spell_item_mercurial_shield');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_01_06' WHERE sql_rev = '1648012632855324300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
