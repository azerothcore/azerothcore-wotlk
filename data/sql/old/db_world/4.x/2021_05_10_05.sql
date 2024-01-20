-- DB update 2021_05_10_04 -> 2021_05_10_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_10_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_10_04 2021_05_10_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620531160911239800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620531160911239800');

-- Mosh'Ogg Warmonger Entry 709 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (277, 278, 821, 842, 844, 845, 847, 849, 851, 856, 1265, 1289, 1290, 1299, 1306);

-- Mosh'Ogg Mauler Entry 678 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (524, 629, 755, 853, 854, 1050, 1077);

-- Mosh'Ogg Shaman Entry 679 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (273, 274, 275, 276, 525, 624, 625, 627, 855);

-- Mosh'Ogg Lord Entry 680 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (521, 522, 526, 761);

-- Mosh'Ogg Spellcrafter Entry 710 --
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `guid` IN (527, 528, 623, 626, 628, 762, 1093);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
