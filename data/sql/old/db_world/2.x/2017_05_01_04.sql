-- DB update 2017_05_01_03 -> 2017_05_01_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_05_01_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_05_01_03 2017_05_01_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1490714789186172000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1490714789186172000');
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_gen_blade_warding';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(64440, 'spell_gen_blade_warding');

-- no cooldown
UPDATE `spell_proc` SET `Cooldown`=0 WHERE `SpellId`=64440;
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
