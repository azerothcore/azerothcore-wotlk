-- DB update 2019_11_03_00 -> 2019_11_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_03_00 2019_11_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1559162254925218831'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559162254925218831');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_item_healing_discount' AND `spell_id`=37705;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37705, 'spell_item_eye_of_gruul_healing_discount');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
