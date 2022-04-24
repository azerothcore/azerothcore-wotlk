-- DB update 2022_04_23_11 -> 2022_04_23_12
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_11';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_11 2022_04_23_12 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648484936302537243'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648484936302537243');

UPDATE `creature_template_locale` SET `Name`='Necrófago resucitado' WHERE `entry`=26125 AND `locale`='esES';
UPDATE `creature_template_locale` SET `Name`='Necrófago resucitado' WHERE `entry`=26125 AND `locale`='esMX';
UPDATE `creature_template_locale` SET `Name`='Auferstandener Ghul' WHERE `entry`=26125 AND `locale`='deDE';
UPDATE `creature_template_locale` SET `Name`='Goule ressuscitée' WHERE `entry`=26125 AND `locale`='frFR';
UPDATE `creature_template_locale` SET `Name`='Восставший вурдалак' WHERE `entry`=26125 AND `locale`='ruRU';
UPDATE `creature_template_locale` SET `Name`='되살아난 구울' WHERE `entry`=26125 AND `locale`='koKR';
UPDATE `creature_template_locale` SET `Name`='复活的食尸鬼' WHERE `entry`=26125 AND `locale`='zhCN';
UPDATE `creature_template_locale` SET `Name`='復活的食屍鬼' WHERE `entry`=26125 AND `locale`='zhTW';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_12' WHERE sql_rev = '1648484936302537243';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
