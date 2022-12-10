-- DB update 2022_02_04_05 -> 2022_02_04_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_04_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_04_05 2022_02_04_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643386602617683649'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643386602617683649');
-- Fixes Paladins Lawbringer's 8 set bonus
DELETE FROM `spell_proc_event` WHERE `entry`=21747;
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(21747, 0, 10, 0, 0, 0, 20, 0, 20, 0, 50000);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_04_06' WHERE sql_rev = '1643386602617683649';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
