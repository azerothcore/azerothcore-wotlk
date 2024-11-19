-- DB update 2021_11_12_01 -> 2021_11_12_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_12_01 2021_11_12_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634947992074110300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634947992074110300');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -24869;

DELETE FROM `spell_script_names` WHERE `spell_id` = -24869 AND `ScriptName` = 'spell_gen_holiday_buff_food';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-24869, 'spell_gen_holiday_buff_food');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_12_02' WHERE sql_rev = '1634947992074110300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
