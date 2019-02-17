-- DB update 2017_03_04_17 -> 2017_03_04_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_03_04_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_03_04_17 2017_03_04_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1488307580281293100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1488307580281293100');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_moss_covered_feet';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(6870, 'spell_gen_moss_covered_feet'),
(31399, 'spell_gen_moss_covered_feet');



--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
