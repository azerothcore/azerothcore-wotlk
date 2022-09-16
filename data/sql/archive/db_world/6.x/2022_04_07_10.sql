-- DB update 2022_04_07_09 -> 2022_04_07_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_07_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_07_09 2022_04_07_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649181854899342300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649181854899342300');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_utgarde_pinnacle_beast_mark';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48876,'spell_utgarde_pinnacle_beast_mark'),
(59237,'spell_utgarde_pinnacle_beast_mark');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_07_10' WHERE sql_rev = '1649181854899342300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
