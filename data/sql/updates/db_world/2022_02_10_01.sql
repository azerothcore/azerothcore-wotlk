-- DB update 2022_02_10_00 -> 2022_02_10_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_10_00 2022_02_10_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639953303883016900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639953303883016900');

DELETE FROM `spell_script_names` WHERE `ScriptName`="spell_gen_magic_rooster";
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=65917;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES
(65917, 66122, "Magic Rooster");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_10_01' WHERE sql_rev = '1639953303883016900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
