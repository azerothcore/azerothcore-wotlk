-- DB update 2021_11_09_02 -> 2021_11_09_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_09_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_09_02 2021_11_09_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636371600934152600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636371600934152600');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_mage_polymorph_visual';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(32826,'spell_mage_polymorph_cast_visual');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_09_03' WHERE sql_rev = '1636371600934152600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
