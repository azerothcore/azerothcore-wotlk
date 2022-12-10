-- DB update 2022_01_03_20 -> 2022_01_03_21
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_20';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_20 2022_01_03_21 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640656702788330300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640656702788330300');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_item_wraith_scythe_drain_life'; 
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(16414, 'spell_item_wraith_scythe_drain_life');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_21' WHERE sql_rev = '1640656702788330300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
