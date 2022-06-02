-- DB update 2021_10_21_07 -> 2021_10_21_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_21_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_21_07 2021_10_21_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634677151304244900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634677151304244900');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_dru_bear_form_passive';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(1178,'spell_dru_bear_form_passive'),
(9635,'spell_dru_bear_form_passive');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_21_08' WHERE sql_rev = '1634677151304244900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
