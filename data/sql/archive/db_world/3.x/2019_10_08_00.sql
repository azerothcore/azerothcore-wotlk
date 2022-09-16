-- DB update 2019_10_04_00 -> 2019_10_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_10_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_10_04_00 2019_10_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1568988467237730140'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1568988467237730140');

UPDATE `broadcast_text` SET `MaleText` = REPLACE(`MaleText`,'%s','$n'), `FemaleText` = REPLACE(`FemaleText`,'%s','$n') WHERE `ID` = 31843;
UPDATE `broadcast_text_locale` SET `MaleText` = REPLACE(`MaleText`,'%s','$n'), `FemaleText` = REPLACE(`FemaleText`,'%s','$n') WHERE `ID` = 31843;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (57426,57301,58474,58465);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(57426,'spell_item_feast'),
(57301,'spell_item_feast'),
(58474,'spell_item_feast'),
(58465,'spell_item_feast');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
