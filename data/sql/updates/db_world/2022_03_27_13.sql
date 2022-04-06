-- DB update 2022_03_27_12 -> 2022_03_27_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_12 2022_03_27_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1647861814144531389'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647861814144531389');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_item_dimensional_ripper_area52';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (36890,'spell_item_dimensional_ripper_area52');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_13' WHERE sql_rev = '1647861814144531389';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
