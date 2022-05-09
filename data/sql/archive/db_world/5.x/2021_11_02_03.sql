-- DB update 2021_11_02_02 -> 2021_11_02_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_02_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_02_02 2021_11_02_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635460529340435632'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635460529340435632');

-- Fix quest for beached turtles Darkshore
UPDATE `gameobject_queststarter` SET `quest`=4728 WHERE `id`=175226;
UPDATE `gameobject_queststarter` SET `quest`=4730 WHERE `id`=175227;
UPDATE `gameobject_queststarter` SET `quest`=4733 WHERE `id`=175230;
UPDATE `gameobject_queststarter` SET `quest`=4723 WHERE `id`=175233;
UPDATE `gameobject_queststarter` SET `quest`=4722 WHERE `id`=176190;
UPDATE `gameobject_queststarter` SET `quest`=4732 WHERE `id`=176191;
UPDATE `gameobject_queststarter` SET `quest`=4727 WHERE `id`=176196;
UPDATE `gameobject_queststarter` SET `quest`=4725 WHERE `id`=176197;
UPDATE `gameobject_queststarter` SET `quest`=4731 WHERE `id`=176198;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_02_03' WHERE sql_rev = '1635460529340435632';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
