-- DB update 2017_11_21_00 -> 2017_12_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_11_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_11_21_00 2017_12_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1512664376513425042'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1512664376513425042');

UPDATE `creature_template` SET `mechanic_immune_mask` = '65536' WHERE `entry` = '29274';
UPDATE `creature_template` SET `spell2` = '54097' WHERE `entry` = '29274';

DELETE FROM `spell_scripts` WHERE `id` IN
(28732,54097);
INSERT INTO `spell_scripts` (`id`, `effIndex`, command, datalong, datalong2, dataint, `x`) VALUES
(28732, 1, 15, 0, 4, 15953, 100), # Widow's Embrace
(54097, 1, 15, 0, 4, 15953, 100); # Widow's Embrace

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
