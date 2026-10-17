-- DB update 2025_04_02_03 -> 2025_04_02_04
--
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 9286) AND (`OptionID` IN (3, 4, 5));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9286, 3, 0, 'With Kalecgos freed, can you provide a teleport up to Apex Point?', 25538, 1, 1, 0, 0, 0, 0, '', 0, 0),
(9286, 4, 0, 'Now that Lady Sacrolsash and Grand Warlock Alythess have been defeated, can you teleport me to the Witch\'s Sanctum.', 25539, 1, 1, 0, 0, 0, 0, '', 0, 0),
(9286, 5, 0, 'We\'ve cleared the way to Kil\'jaeden! Can you transport me close to the Sunwell?', 25540, 1, 1, 0, 0, 0, 0, '', 0, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25632;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25632);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25632, 0, 0, 0, 62, 0, 100, 0, 9286, 3, 0, 0, 0, 0, 11, 46877, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Moorba - On Gossip Option 3 Selected - Cast \'Teleport to Apex Point\''),
(25632, 0, 1, 0, 62, 0, 100, 0, 9286, 4, 0, 0, 0, 0, 11, 46879, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Moorba - On Gossip Option 4 Selected - Cast \'Teleport to Witch''s Sanctum\''),
(25632, 0, 2, 0, 62, 0, 100, 0, 9286, 5, 0, 0, 0, 0, 11, 46880, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Vindicator Moorba - On Gossip Option 5 Selected - Cast \'Teleport to Sunwell Plateau\'');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (46877, 46879, 46880);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46877, "spell_teleport_to_apex_point"),
(46879, "spell_teleport_to_witchs_sanctum"),
(46880, "spell_teleport_to_sunwell_plateau");

UPDATE `spell_target_position` SET `PositionX`=1861.45, `PositionY`=495.125, `PositionZ`=82.9059, `Orientation`=0.897738 WHERE `ID`=46884 AND `EffectIndex`=0;
DELETE FROM `spell_target_position` WHERE `ID` IN (46881, 46883) AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(46881, 0, 580, 1704.41, 929.617, 53.077, 4.70143, 50664),
(46883, 0, 580, 1816.14, 625.438, 33.404, 1.21032, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9286) AND (`SourceEntry` IN (3,4,5)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9286, 3, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Show gossip option if Kalecgos done AND Eredar Twins not done'),
(15, 9286, 3, 0, 0, 13, 0, 4, 3, 2, 1, 0, 0, '', 'Show gossip option if Kalecgos done AND Eredar Twins not done'),
(15, 9286, 4, 0, 0, 13, 0, 4, 3, 2, 0, 0, 0, '', 'Show gossip option if Eredar Twins done AND M\'uru not done'),
(15, 9286, 4, 0, 0, 13, 0, 5, 3, 2, 1, 0, 0, '', 'Show gossip option if Eredar Twins done AND M\'uru not done'),
(15, 9286, 5, 0, 0, 13, 0, 5, 3, 2, 0, 0, 0, '', 'Show gossip option if M\'uru done');
