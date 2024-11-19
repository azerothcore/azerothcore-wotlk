-- DB update 2021_05_06_06 -> 2021_05_06_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_06_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_06_06 2021_05_06_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619822861176792300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619822861176792300');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 8419;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 8419 AND `source_type` = 0 AND `id` BETWEEN 0 AND 3;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(8419, 0, 0, 0, 0, 0, 100, 0, 0, 0, 3000, 5000, 0, 11, 9053, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Idolater - In Combat - Cast Fireball'),
(8419, 0, 1, 0, 0, 0, 100, 0, 6000, 9000, 18000, 22000, 0, 11, 11962, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Idolater - In Combat - Cast Immolate'),
(8419, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Idolater - On Aggro - Say Line 0'),
(8419, 0, 3, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 8734, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Twilight Idolater - On reset - Cast Blackfathom Channeling');

DELETE FROM `creature_text` WHERE `CreatureID` = 8419;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(8419,0,0,"Infidels!",12,0,100,0,0,0,4380,0,"Twilight Idolater"),
(8419,0,1,"You dare interrupt our prayer? Execute them!",12,0,100,0,0,0,4381,0,"Twilight Idolater"),
(8419,0,2,"You will make a fitting sacrifice to Ragnaros.",12,0,100,0,0,0,4382,0,"Twilight Idolater"),
(8419,0,3,"Excellent, fresh blood has arrived.",12,0,100,0,0,0,4383,0,"Twilight Idolater");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
