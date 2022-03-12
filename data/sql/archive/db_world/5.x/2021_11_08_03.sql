-- DB update 2021_11_08_02 -> 2021_11_08_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_08_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_08_02 2021_11_08_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635964941654899600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635964941654899600');
DELETE FROM `spell_script_names` WHERE `spell_id`=20478 AND `ScriptName`='spell_geddon_armageddon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(20478, 'spell_geddon_armageddon');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_08_03' WHERE sql_rev = '1635964941654899600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
