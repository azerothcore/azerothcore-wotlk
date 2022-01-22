-- DB update 2021_09_24_01 -> 2021_09_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_24_01 2021_09_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631783274789936800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631783274789936800');

-- Warning fixes
UPDATE `creature_formations` SET `groupAI`=`groupAI`|512 WHERE (`angle` > 0 OR `dist` > 0) AND `leaderGUID` != `memberGUID` AND NOT (`groupAI` & 512);
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=7209 AND `memberGUID`=7209;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=37523 AND `memberGUID`=37523;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=47613 AND `memberGUID`=47613;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=79524 AND `memberGUID`=79524;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=79720 AND `memberGUID`=79720;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=80219 AND `memberGUID`=80219;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=80235 AND `memberGUID`=80235;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=134935 AND `memberGUID`=134935;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=134944 AND `memberGUID`=134944;
UPDATE `creature_formations` SET `angle`=0, `dist`=0 WHERE `leaderGUID`=134952 AND `memberGUID`=134952;
UPDATE `creature_formations` SET `groupAI` = 1 | 2 WHERE `leaderGUID`=85221 AND `memberGUID`=85221;
UPDATE `creature_formations` SET `groupAI` = 1 | 2 WHERE `leaderGUID`=114937 AND `memberGUID`=114937;
UPDATE `creature_formations` SET `groupAI` = 1 | 2 WHERE `leaderGUID`=248035 AND `memberGUID` != 248035;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_24_02' WHERE sql_rev = '1631783274789936800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
