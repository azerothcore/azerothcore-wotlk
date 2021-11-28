-- DB update 2021_11_09_06 -> 2021_11_09_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_09_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_09_06 2021_11_09_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636293158309628100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636293158309628100');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_deathwhisper_dark_reckoning';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(69483,'spell_deathwhisper_dark_reckoning');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_09_07' WHERE sql_rev = '1636293158309628100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
