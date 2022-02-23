-- DB update 2021_10_24_05 -> 2021_10_24_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_24_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_24_05 2021_10_24_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634891525914970200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634891525914970200');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (22563, 22564) AND `ScriptName` = 'spell_item_recall';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(22563, 'spell_item_recall'),
(22564, 'spell_item_recall');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_24_06' WHERE sql_rev = '1634891525914970200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
