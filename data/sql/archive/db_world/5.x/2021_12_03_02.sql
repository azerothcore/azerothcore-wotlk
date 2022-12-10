-- DB update 2021_12_03_01 -> 2021_12_03_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_03_01 2021_12_03_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638053041040101600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638053041040101600');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_jarien' WHERE `entry` = 16101;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_sothos' WHERE `entry` = 16102;

DELETE FROM `creature_text` WHERE `CreatureID` IN (16101, 16102, 16103, 16104);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16101, 0, 0, 'Hello, brother.', 14, 0, 100, 0, 0, 0, 11971, 0, 'Jarien - ON SUMMON'),
(16101, 1, 0, 'Would-be interlopers, I\'m afraid.', 14, 0, 100, 0, 0, 0, 11973, 0, 'Jarien - ON SUMMON - 1'),
(16101, 2, 0, 'Yes, we shall!', 14, 0, 100, 0, 0, 0, 11975, 0, 'Jarien - ON SUMMON - 2'),
(16101, 3, 0, '%s goes into a rage after seeing $n fall in battle!', 16, 0, 100, 0, 0, 0, 11939, 0, 'Jarien - ON SOTHOS DEATH'),
(16102, 0, 0, 'Hello, sister. What have we here?', 14, 0, 100, 0, 0, 0, 11972, 0, 'Sothos - ON SUMMON'),
(16102, 1, 0, 'Shall we slay them for the impertinence of disturbing our sleep?', 14, 0, 100, 0, 0, 0, 11974, 0, 'Sothos - ON SUMMON - 1'),
(16102, 2, 0, '%s goes into a rage after seeing $n fall in battle!', 16, 0, 100, 0, 0, 0, 11939, 0, 'Sothos - ON JARIEN DEATH'),
(16103, 0, 0, 'Thank you for freeing me, my brother, and all of you! We can finally rest in peace now.', 14, 0, 100, 0, 0, 0, 11819, 0, 'Spirit of Jarien - ON BOTH DEATHS'),
(16104, 0, 0, 'Thank you for freeing me, my sister, and all of you! We can finally rest in peace now.', 14, 0, 100, 0, 0, 0, 11859, 0, 'Spirit of Sothos - ON BOTH DEATHS');

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (16101, 16102);

-- Fix Jarien and Sothos spawn position
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16046 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16046, 0, 0, 1, 38, 0, 100, 1, 1, 1, 0, 0, 0, 12, 16101, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3420.13452, -3056.939697, 136.4981, 0.208907, 'Jarien and Sothos Trigger - On Data Set - Spawn Jarien'),
(16046, 0, 1, 0, 61, 0, 100, 1, 1, 1, 0, 0, 0, 12, 16102, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3427.82251, -3055.582764, 136.4981, 3.319085, 'Jarien and Sothos Trigger - Linked with Previous Event - Spawn Sothos');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_03_02' WHERE sql_rev = '1638053041040101600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
