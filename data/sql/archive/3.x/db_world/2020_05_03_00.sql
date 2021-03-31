-- DB update 2020_05_02_01 -> 2020_05_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_02_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_02_01 2020_05_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1584388487036984300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584388487036984300');

DELETE FROM `creature_queststarter` WHERE `quest` IN (8388,13475,8371,8385,13477,13478,13476,8367);
DELETE FROM `creature_questender` WHERE `quest` IN (8388,13475,8371,8385,13477,13478,13476,8367);
DELETE FROM `disables` WHERE `sourceType`=1 AND `entry` IN (8388,13475,8371,8385,13477,13478,13476,8367);
INSERT INTO `disables` (`sourceType`,`entry`,`flags`,`params_0`,`params_1`,`comment`) VALUES
(1,8388,0,'','','Deprecated Quest: For Great Honor'),
(1,13475,0,'','','Deprecated Quest: For Great Honor'),
(1,13476,0,'','','Deprecated Quest: For Great Honor'),
(1,8367,0,'','','Deprecated Quest: For Great Honor'),
(1,8371,0,'','','Deprecated Quest: Concerted Efforts'),
(1,8385,0,'','','Deprecated Quest: Concerted Efforts'),
(1,13477,0,'','','Deprecated Quest: Concerted Efforts'),
(1,13478,0,'','','Deprecated Quest: Concerted Efforts');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
