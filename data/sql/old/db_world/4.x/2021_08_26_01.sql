-- DB update 2021_08_26_00 -> 2021_08_26_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_26_00 2021_08_26_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629427468671180105'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629427468671180105');

-- Add movement to Tenders
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15271 AND `guid` IN (54872, 54879, 54874, 54878, 54883, 54898);

-- Add movement to Feral Tenders
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15294 AND `guid` IN (55021, 55038, 55049, 55044);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_26_01' WHERE sql_rev = '1629427468671180105';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
