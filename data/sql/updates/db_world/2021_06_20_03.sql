-- DB update 2021_06_20_02 -> 2021_06_20_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_20_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_20_02 2021_06_20_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624112508117718400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624112508117718400');


UPDATE `creature_template_locale` SET `Name` = 'Yeti feroz' WHERE `entry` = 2249 AND `locale` IN ('esES','esMX');
UPDATE `creature_template_locale` SET `Name` = 'Yéti féroce' WHERE `entry` = 2249 AND `locale` = 'frFR';
UPDATE `creature_template_locale` SET `Name` = '兇惡的雪人' WHERE `entry` = 2249 AND `locale` = 'zhTW';
UPDATE `creature_template_locale` SET `Name` = '사나운 설인' WHERE `entry` = 2249 AND `locale` = 'koKR';

UPDATE `creature_template_locale` SET `Name` = 'Dyslix Kami-Kaze' WHERE `entry` = 23612 AND `locale` IN ('esES','esMX');
UPDATE `creature_template_locale` SET `Name` = 'Dyslix Fouinargent' WHERE `entry` = 23612 AND `locale` = 'frFR';
UPDATE `creature_template_locale` SET `Name` = '迪司利克思·銀尋' WHERE `entry` = 23612 AND `locale` = 'zhTW';
UPDATE `creature_template_locale` SET `Name` = '디슬릭스 실버그럽' WHERE `entry` = 23612 AND `locale` = 'koKR';

UPDATE `creature_template_locale` SET `Name` = 'Shyn' WHERE `entry` = 8020 AND `locale` IN ('esES','esMX','frFR');
UPDATE `creature_template_locale` SET `Name` = '쉬인' WHERE `entry` = 8020 AND `locale` = 'koKR';
UPDATE `creature_template_locale` SET `Name` = 'Шин' WHERE `entry` = 8020 AND `locale` = 'ruRU';
UPDATE `creature_template_locale` SET `Name` = '夏恩' WHERE `entry` = 8020 AND `locale` = 'zhTW';

DELETE FROM `creature` WHERE `id` = 2870 AND `guid` = 86176;
/* Delete npc from in-game world, not from acore_world.creature_template
See issue #6435 */


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_20_03' WHERE sql_rev = '1624112508117718400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
