-- DB update 2021_10_21_08 -> 2021_10_21_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_21_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_21_08 2021_10_21_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634671396926649200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634671396926649200');

DELETE FROM `spell_script_names` WHERE `spell_id`=58984;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=58984;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(58984,59646,0,'Shadowmeld: Sanctuary'),
(58984,62196,0,'Shadowmeld: Force deselect');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_21_09' WHERE sql_rev = '1634671396926649200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
