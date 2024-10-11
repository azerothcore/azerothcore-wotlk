-- DB update 2021_07_23_02 -> 2021_07_23_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_02 2021_07_23_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626953516206751500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626953516206751500');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 13278 AND `spell_effect` = 13493;
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(13278, 13493, 0, 'Gnomish Death Ray');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_03' WHERE sql_rev = '1626953516206751500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
