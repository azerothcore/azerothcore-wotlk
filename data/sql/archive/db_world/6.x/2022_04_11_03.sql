-- DB update 2022_04_11_02 -> 2022_04_11_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_11_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_11_02 2022_04_11_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649370784577886400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649370784577886400');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 23414 AND `spell_effect` IN (-1856, -1857, -26889);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(23414, -1856, 2, 'Nefarian Rogue class call - Vanish'),
(23414, -1857, 2, 'Nefarian Rogue class call - Vanish'),
(23414, -26889, 2, 'Nefarian Rogue class call - Vanish');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_11_03' WHERE sql_rev = '1649370784577886400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
