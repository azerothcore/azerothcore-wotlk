-- DB update 2018_01_28_02 -> 2018_02_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_01_28_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_01_28_02 2018_02_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1518089572435453900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1518089572435453900');

-- The eggs should not be clickable
UPDATE `gameobject_template` SET `faction`='14' WHERE  `entry`=177807;

-- Grethok the controller should shout "Intruders have breached the hatchery.." when engaged,
UPDATE `smart_scripts` SET `event_type`='4' WHERE  `entryorguid`=12557 AND `source_type`=0 AND `id`=4 AND `link`=0;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
