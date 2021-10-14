-- DB update 2019_06_12_00 -> 2019_06_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_12_00 2019_06_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1559684382046240375'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559684382046240375');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (51186,51188,51189);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`)
VALUES
(51186,'spell_item_summon_or_dismiss'),
(51188,'spell_item_summon_or_dismiss'),
(51189,'spell_item_summon_or_dismiss');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
