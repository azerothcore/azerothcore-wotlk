-- DB update 2021_08_20_01 -> 2021_08_20_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_20_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_20_01 2021_08_20_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629141434760979400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629141434760979400');

DELETE FROM `spell_proc_event` WHERE `entry` = 56841;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES 
(56841, 0, 9, 0x800, 0x800, 0x800, 0x100, 0, 0, 0, 0);

DELETE FROM `spell_script_names` WHERE `spell_id` = 56841 AND `ScriptName` = 'spell_hun_glyph_of_arcane_shot';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (56841,'spell_hun_glyph_of_arcane_shot');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_20_02' WHERE sql_rev = '1629141434760979400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
