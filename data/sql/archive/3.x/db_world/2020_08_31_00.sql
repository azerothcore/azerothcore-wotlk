-- DB update 2020_08_30_00 -> 2020_08_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_30_00 2020_08_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589696719380337546'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589696719380337546');
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256 WHERE `entry` = 5269;
UPDATE `creature` SET `unit_flags`=`unit_flags`|256 WHERE `guid` = 39745;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 5269 AND `id` = 2;
DELETE FROM `smart_scripts` WHERE `entryorguid` = -39745;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(-39745, 0, 0, 0, 14, 0, 100, 0, 1000, 40, 4000, 6000, 0, 11, 11642, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Priest - Friendly Missing Health - Cast Heal'),
(-39745, 0, 1, 0, 0, 0, 100, 0, 0, 3000, 3000, 5000, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Priest - In Combat - Cast Shadow Bolt'),
(-39745, 0, 2, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Atal\'ai Priest - Out of Combat - Remove Unit Flags');
UPDATE `conditions` SET `SourceEntry` = -39745 WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 5269;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
