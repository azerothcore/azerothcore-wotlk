-- DB update 2021_08_06_00 -> 2021_08_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_06_00 2021_08_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627725819856031500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627725819856031500');

DELETE FROM `spell_script_names` WHERE `scriptname`= "spell_mage_combustion_proc";
INSERT INTO `spell_script_names` (`spell_id`,`scriptname`) VALUES (28682, "spell_mage_combustion_proc");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_06_01' WHERE sql_rev = '1627725819856031500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
