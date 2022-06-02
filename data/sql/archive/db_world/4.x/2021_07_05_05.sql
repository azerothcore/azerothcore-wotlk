-- DB update 2021_07_05_04 -> 2021_07_05_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_05_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_05_04 2021_07_05_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624779042193682155'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624779042193682155');

-- Deletes underlevelled (lvl 18-19) RLT 24078 from lvl 28 Nightbane Dark Runner (ID 205), lvl 28 Dark Strand Voidcaller (ID 2337), lvl 31 Athrikus Narassin (ID 3660), lvl 50 Jadefire Rogue (ID 7106), lvl 54 Scarshield Spellbinder (ID 9098)
DELETE FROM `creature_loot_template` WHERE `Entry` IN (205, 2337, 3660, 7106, 9098) AND `Reference` = 24078;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_05_05' WHERE sql_rev = '1624779042193682155';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
