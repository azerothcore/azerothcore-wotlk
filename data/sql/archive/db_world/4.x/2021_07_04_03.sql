-- DB update 2021_07_04_02 -> 2021_07_04_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_04_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_04_02 2021_07_04_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620337536404777343'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620337536404777343');

-- Timers update for NPC "Flamewaker Protector"
UPDATE `smart_scripts` SET `event_param1`=5000, `event_param2`=5000, `event_param3`=6500, `event_param4`=6500 WHERE `entryorguid`=12119 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=5000, `event_param2`=10000, `event_param3`=7000, `event_param4`=7000 WHERE `entryorguid`=12119 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- Timers update for NPC "Flamewaker"
UPDATE `smart_scripts` SET `event_param1`=3000, `event_param2`=6000, `event_param3`=10000, `event_param4`=13000 WHERE `entryorguid`=11661 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=3000, `event_param3`=4000, `event_param4`=6000 WHERE  `entryorguid`=11661 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `smart_scripts` SET `event_param1`=4000, `event_param2`=9000, `event_param3`=5000, `event_param4`=8000 WHERE `entryorguid`=11661 AND `source_type`=0 AND `id`=2 AND `link`=0;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_04_03' WHERE sql_rev = '1620337536404777343';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
