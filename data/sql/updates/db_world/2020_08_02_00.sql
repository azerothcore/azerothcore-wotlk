-- DB update 2020_07_30_00 -> 2020_08_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_30_00 2020_08_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1591204377400264600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1591204377400264600');

-- Quest 3181 must not be taken for this gossip to take place
UPDATE `creature_template` SET `gossip_menu_id`=50000 , `ScriptName`='' WHERE  `entry`=3836;

DELETE FROM `gossip_menu` WHERE `MenuID` IN (50000, 50001, 50002, 50003, 50004, 50005, 50006, 50007);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES 
(50007, 1839),
(50006, 1838),
(50005, 1837),
(50004, 1836),
(50003, 1835),
(50002, 1834),
(50001, 1833),
(50000, 1833);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (50000, 50001, 50002, 50003, 50004, 50005, 50006);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES 
(50003, 0, 0, "Doesn't matter, I'm invulnerable!", 0, 1, 1, 50004, 0, 0, 0, NULL, 0, 0),
(50004, 0, 0, "Yes...", 0, 1, 1, 50005, 0, 0, 0, NULL, 0, 0),
(50005, 0, 0, "Ok, I'll try to remember that.", 0, 1, 1, 50006, 0, 0, 0, NULL, 0, 0),
(50006, 0, 0, "A key? Ok!", 0, 1, 1, 0, 0, 0, 0, NULL, 0, 0),
(50002, 0, 0, "Ok, so what is this other way?", 0, 1, 1, 50003, 0, 0, 0, NULL, 0, 0),
(50001, 0, 0, "But I need to get there, now open the gate!", 0, 1, 1, 50002, 0, 0, 0, NULL, 0, 0),
(50000, 0, 0, "Open the gate please, I need to get to Searing Gorge", 0, 1, 1, 50001, 0, 0, 0, NULL, 0, 0),
(50000, 1, 0, "Umm... Pebblebitty... the gate is open.", 0, 1, 1, 50007, 0, 0, 0, NULL, 0, 0);

DELETE FROM `npc_text` WHERE `ID`=1839;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES 
(1839, NULL, "Ahh... so it is, so it is. Carry on then. Carry on t'yer death.", 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);


DELETE FROM `conditions` WHERE `SourceGroup`=50000 AND `SourceTypeOrReferenceId`=15;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 50000, 0, 0, 0, 14, 0, 3181, 0, 0, 0, 0, 0, '', "Show Gossip 50000 if 'The Horn of the Beast' is rewarded AND"),
(15, 50000, 1, 0, 0, 8, 0, 3201, 0, 0, 0, 0, 0, '', "Show Gossip 50000  if 'At Last!' is not taken");

DELETE FROM `smart_scripts` WHERE `entryorguid`=3836 AND `source_type`=0 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(3836, 0, 0, 0, 62, 0, 100, 0, 50006, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Mountaineer Pebblebitty - On Gossip Option 0 Selected - Close Gossip");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
