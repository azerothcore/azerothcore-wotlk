-- DB update 2021_11_05_07 -> 2021_11_05_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_05_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_05_07 2021_11_05_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635873886464817740'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635873886464817740');

-- Condition for source Gossip menu condition type Quest taken
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (3223,3228) AND `SourceEntry` IN (3978,3979,3984,3985) AND `SourceId`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (3223,3228) AND `SourceEntry` IN (0,1,2,3,4) AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 3223, 3978, 0, 0, 8, 0, 5230, 0, 0, 1, 0, 0, '', 'Gossip text requires quest ''Return to the Bulwark'' NOT rewarded'),
(14, 3223, 3979, 0, 0, 8, 0, 5230, 0, 0, 0, 0, 0, '', 'Gossip text requires quest ''Return to the Bulwark'' rewarded'),
(14, 3228, 3984, 0, 0, 8, 0, 5217, 0, 0, 1, 0, 0, '', 'Gossip text requires quest ''Return to Chillwind Camp'' NOT rewarded'),
(14, 3228, 3985, 0, 0, 8, 0, 5217, 0, 0, 0, 0, 0, '', 'Gossip text requires quest ''Return to Chillwind Camp'' rewarded'),
(15, 3223, 0, 0, 0, 8, 0, 5230, 0, 0, 0, 0, 0, '', 'Gossip option 0 requires quest ''Return to the Bulwark'' rewarded'),
(15, 3223, 1, 0, 0, 8, 0, 5230, 0, 0, 0, 0, 0, '', 'Gossip option 1 requires quest ''Return to the Bulwark'' rewarded'),
(15, 3223, 2, 0, 0, 8, 0, 5232, 0, 0, 0, 0, 0, '', 'Gossip option 2 requires quest ''Return to the Bulwark'' rewarded'),
(15, 3223, 3, 0, 0, 8, 0, 5234, 0, 0, 0, 0, 0, '', 'Gossip option 3 requires quest ''Return to the Bulwark'' rewarded'),
(15, 3223, 4, 0, 0, 8, 0, 5236, 0, 0, 0, 0, 0, '', 'Gossip option 4 requires quest ''Return to the Bulwark'' rewarded'),
(15, 3228, 0, 0, 0, 8, 0, 5217, 0, 0, 0, 0, 0, '', 'Gossip option 0 requires quest ''Return to Chillwind Camp'' rewarded'),
(15, 3228, 1, 0, 0, 8, 0, 5217, 0, 0, 0, 0, 0, '', 'Gossip option 1 requires quest ''Return to Chillwind Camp'' rewarded'),
(15, 3228, 2, 0, 0, 8, 0, 5220, 0, 0, 0, 0, 0, '', 'Gossip option 2 requires quest ''Return to Chillwind Camp'' rewarded'),
(15, 3228, 3, 0, 0, 8, 0, 5223, 0, 0, 0, 0, 0, '', 'Gossip option 3 requires quest ''Return to Chillwind Camp'' rewarded'),
(15, 3228, 4, 0, 0, 8, 0, 5226, 0, 0, 0, 0, 0, '', 'Gossip option 4 requires quest ''Return to Chillwind Camp'' rewarded');


UPDATE `creature_template` SET `AIName`="SmartAI", `ScriptName`='' WHERE `entry` IN (11056,11057);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (11056,11057) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1105600 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(11056, 0, 0, 1, 62, 0, 100, 0, 3224, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Close Gossip'),
(11056, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11056, 0, 2, 3, 62, 0, 100, 0, 3225, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Close Gossip'),
(11056, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11056, 0, 4, 5, 62, 0, 100, 0, 3226, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Close Gossip'),
(11056, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11056, 0, 6, 7, 62, 0, 100, 0, 3227, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Close Gossip'),
(11056, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11056, 0, 8, 0, 20, 0, 100, 0, 5803, 0, 0, 0, 80, 1105600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington - On Quest ''Araj''s Scarab'' Rewarded - Run Script'),
(11057, 0, 0, 1, 62, 0, 100, 0, 3224, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Close Gossip'),
(11057, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11057, 0, 2, 3, 62, 0, 100, 0, 3225, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Close Gossip'),
(11057, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11057, 0, 4, 5, 62, 0, 100, 0, 3226, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Close Gossip'),
(11057, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11057, 0, 6, 7, 62, 0, 100, 0, 3227, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Close Gossip'),
(11057, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 17529, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Gossip Option Selected - Cast ''Vitreous Focuser'''),
(11057, 0, 8, 0, 20, 0, 100, 0, 5804, 0, 0, 0, 80, 1105600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Dithers - On Quest ''Araj''s Scarab'' Rewarded - Run Script'),
(1105600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington and Apothecary Dithers - On Script - Remove Npc Flag Questgiver'),
(1105600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington and Apothecary Dithers - On Script - Say Line 0'),
(1105600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 15050, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington and Apothecary Dithers - On Script - Cast ''Psychometry'''),
(1105600, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington and Apothecary Dithers - On Script - Say Line 1'),
(1105600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alchemist Arbington and Apothecary Dithers - On Script - Add Npc Flag Questgiver');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_05_08' WHERE sql_rev = '1635873886464817740';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
