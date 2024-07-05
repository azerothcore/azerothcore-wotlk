-- DB update 2023_03_01_03 -> 2023_03_01_04
-- Delete old custom creature_template entries
DELETE FROM `creature_template` WHERE `entry` IN (
61021, -- Adyen the Lightwarden
50004, -- Adyen Trigger
50002, -- Exarch Orelis
50001  -- Anchorite Karja
);

-- Delete Adyen Trigger
DELETE FROM `creature` WHERE `id1`=50004 AND `guid`=3110359;

DELETE FROM `creature_equip_template` WHERE (`CreatureID` IN (50001, 50002, 61021));

DELETE FROM `creature_template_spell` WHERE (`CreatureID` IN (50001, 50002, 61021));

-- Delete old waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (
610210, -- ADYEN_PATH_ID
500010, -- KARJA_PATH_ID
500020, -- ORELIS_PATH_ID
207940, -- KAYLAAN_PATH_ID1
207941, -- KAYLAAN_PATH_ID2
500050  -- ISHANAH_PATH_ID
);

-- Delete old texts
DELETE FROM `creature_text` WHERE `creatureid`=61021;
DELETE FROM `creature_text` WHERE `creatureid`=18537;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18537, 0, 0, 'We\'re here for you, lost brother.  It is custom to offer you a chance to repent before you are destroyed.  We offer you this chance, as the naaru\'s law commands.', 12, 0, 100, 0, 0, 0, 18389, 0, ''),
(18537, 1, 0, 'We may be few, Socrethar, but our faith is strong.  Something you will never understand.  Now that custom has been served, prepare to meet your end.', 12, 0, 100, 0, 0, 0, 18391, 0, ''),
(18537, 2, 0, 'How... how could you?!', 12, 0, 100, 0, 0, 0, 18393, 0, ''),
(18537, 3, 0, 'Socrethar is clouding your mind, Kaylaan!  You do not mean these words!  I remember training you when you were but a youngling.  Your will was strong even then!', 12, 0, 100, 0, 0, 0, 18397, 0, '');

-- Add proper trigger creature
DELETE FROM `creature` WHERE `id1`=23491;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`) VALUES
(111111, 23491, 530, 3523, 3742, 4819.2363, 3775.88, 210.25194, 5.515240192413330078, 120, 48069);

-- Adyen (18537)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` IN (
18537, -- Adyen the Lightwarden
18538, -- Ishanah
19466, -- Exarch Orelis
19467, -- Anchorite Karja
20132, -- Socrethar
20794, -- Kaylaan the Lost
23491  -- Socrethar Event Trigger
));

-- Orelis (19466)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -69725);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-69725, 0, 0, 0, 1, 0, 100, 512, 0, 30000, 180000, 240000, 0, 80, 1946600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - OOC - Run Script');

-- Karja (19467)
UPDATE `creature_template_addon` SET `bytes1` = 0, `bytes2` = 1 WHERE (`entry` = 19467);
DELETE FROM `creature_addon` WHERE (`guid` = 69727);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(69727, 0, 0, 6, 4097, 0, 0, NULL);

UPDATE `creature` SET `position_x`=4946.936, `position_y`=3849.2083, `position_z`=211.5767, `orientation`=3.892084121704101562, `VerifiedBuild`=48069 WHERE `id1`=20132;

-- Waypoints
DELETE FROM `waypoints` WHERE `entry` IN (1853700, 2079400, 2079401, 2079402, 1853800, 1853801);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
-- Adyen
(1853700,1,4819.1963,3769.3455,210.50163,NULL,'Adyen the Lightwarden'),
(1853700,2,4842.374,3776.3086,206.5136,NULL,'Adyen the Lightwarden'),
(1853700,3,4860.4517,3791.8281,199.58647,NULL,'Adyen the Lightwarden'),
(1853700,4,4883.19,3808.0283,198.98213,NULL,'Adyen the Lightwarden'),
(1853700,5,4898.159,3817.5452,208.13782,NULL,'Adyen the Lightwarden'),
(1853700,6,4912.548,3827.1858,211.50491,NULL,'Adyen the Lightwarden'),
(1853700,7,4925.748,3835.356,211.49062,NULL,'Adyen the Lightwarden'),
-- Kaylaan
(2079400,1,4950.1494,3887.8508,212.33162,NULL,'Kaylaan the Lost'),
(2079400,2,4946.882,3872.5073,211.48543,NULL,'Kaylaan the Lost'),
(2079400,3,4939.2324,3853.8499,211.48567,NULL,'Kaylaan the Lost'),
(2079400,4,4941.726,3852.1892,211.46687,NULL,'Kaylaan the Lost'), -- Kneel
(2079401,1,4940.221,3847.4336,211.49857,NULL,'Kaylaan the Lost'), -- Stand by Socrethar
(2079402,1,4938.0044,3834.3682,211.35002,NULL,'Kaylaan the Lost'), -- Stand by Ishanah
-- Ishanah - The Decomposed Waypoints are to avoid floating/flying. If in the future movement is changed then they could be safely removed
(1853800,1 ,4881.5283,3806.9114,199.50269,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,2 ,4883.5283,3808.6614,199.50269,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,3 ,4885.7783,3810.4114,199.50269,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,4 ,4889.5283,3812.4114,202.75269,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,5 ,4894.203,3814.9324,205.52324,NULL,'Ishanah'),
(1853800,6 ,4898.7446,3817.81,208.48784,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,7 ,4907.2446,3822.81,211.73784,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,8 ,4909.8877,3824.375,211.50648,NULL,'Ishanah'),
(1853800,9 ,4910.0957,3824.607,211.6725,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,10,4919.0957,3826.607,211.6725,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,11,4919.5957,3826.607,211.6725,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,12,4922.5957,3827.357,211.6725,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,13,4923.284,3827.5364,211.48683,NULL,'Ishanah'),
(1853800,14,4926.301,3828.2864,211.71806,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,15,4932.801,3829.7864,211.71806,NULL,'Ishanah - Decomposed Waypoint'),
(1853800,16,4933.633,3830.1167,211.43718,NULL,'Ishanah'),
(1853800,17,4935.647,3831.1455,211.39305,NULL,'Ishanah'),
(1853800,18,4937.065,3832.6042,211.42769,NULL,'Ishanah');

-- Spawning Event
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23491);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23491, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar Event Trigger - On Data Set 1 1 - Summon Creature Group 0');

DELETE FROM `creature_summon_groups` WHERE `summonerId`=23491 AND `summonerType`=0 AND `Comment` LIKE 'Deathblow to the Legion%';
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(23491, 0, 0, 18537, 4805.796, 3774.1116, 210.61717, 5.550147056579589843, 6, 60000, 'Deathblow to the Legion - Adyen'),
(23491, 0, 0, 19466, 4804.807, 3775.562, 210.6171, 5.532693862915039062, 6, 60000, 'Deathblow to the Legion - Orelis'),
(23491, 0, 0, 19467, 4803.6367, 3773.8438, 210.61761, 5.602506637573242187, 6, 60000, 'Deathblow to the Legion - Karja');

-- Gossips
DELETE FROM `gossip_menu` WHERE (`MenuID` = 8117);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8117, 10051),
(8117, 10210);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 8117);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8117, 0, 0, 'I\'m ready, Adyen.', 18591, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` IN (14, 15)) AND (`SourceGroup` IN (7735, 8117));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Adyen Gossip
(14, 8117, 10051, 0, 0, 23, 1, 3742, 0, 0, 1, 0, 0, '', 'Show text when outside Socrethar\'s Seat'),
(14, 8117, 10210, 0, 0, 23, 1, 3742, 0, 0, 0, 0, 0, '', 'Show text when inside Socrethar\'s Seat'),
(15, 8117, 0, 0, 0, 23, 1, 3742, 0, 0, 0, 0, 0, '', 'Show gossip option only when inside Socrethar\'s Seat'),
(15, 8117, 0, 0, 0, 29, 1, 20132, 200, 0, 0, 0, 0, '', 'Show gossip option only when Socrethar is alive'),
(15, 8117, 0, 0, 0, 29, 1, 20794, 200, 0, 1, 0, 0, '', 'Show gossip option only when Kaylaan hasn\'t spawned'),
(15, 8117, 0, 0, 0, 9, 0, 10409, 0, 0, 0, 0, 0, '', 'Show gossip option only if player has quest \'Deathblow to the Legion\''),
-- Ishanah Gossip
(14, 7735, 9457, 0, 0, 23, 1, 3703, 0, 0, 0, 0, 0, '', 'Show text only when inside Shattrath'),
(15, 7735, 0, 0, 0, 23, 1, 3703, 0, 0, 0, 0, 0, '', 'Show gossip option only when inside Shattrath'),
(15, 7735, 1, 0, 0, 23, 1, 3703, 0, 0, 0, 0, 0, '', 'Show gossip option only when inside Shattrath');

-- SAI Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 23491);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 23491, 0, 0, 29, 1, 18537, 200, 0, 1, 0, 0, '', 'Do not spawn Socrethar Event group if there is already one spawned within 200y'),
(22, 1, 23491, 0, 0, 29, 1, 20794, 200, 0, 1, 0, 0, '', 'Do not spawn Socrethar Event group if Kaylaan has already spawned within 200y');

-- Spell Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceEntry` IN (35598, 35599, 35600));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 35598, 0, 0, 31, 0, 3, 18538, 0, 0, 0, 0, '', 'Wrath of Socrethar (35598) targets Ishanah'),
(13, 1, 35599, 0, 0, 31, 0, 3, 18538, 0, 0, 0, 0, '', 'Resurrection (35599) targets Ishanah'),
(13, 1, 35600, 0, 0, 31, 0, 3, 20794, 0, 0, 0, 0, '', 'Wrath of Socrethar (35600) targets Kaylaan the Lost');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 184604;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 184604);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(184604, 1, 0, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 111111, 23491, 0, 0, 0, 0, 0, 0, 'Portal to Socrethar\'s Seat - On Just Created - Set Data 1 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (18537, 18538, 19466, 19467, 20132, 20794));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18537, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - On Just Summoned - Set Npc Flags Gossip'),
(18537, 0, 1, 2, 62, 0, 100, 0, 8117, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - On Gossip Option 0 Selected - Store Targetlist'),
(18537, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - On Gossip Option 0 Selected - Close Gossip'),
(18537, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1853700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - On Gossip Option 0 Selected - Run Script'),
(18537, 0, 4, 5, 58, 0, 100, 0, 7, 1853700, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - On Waypoint Finished - Set Data 1 1 on Socrethar (Request Event Start)'),
(18537, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - On Waypoint Finished - Send Target List to Socrethar'),
(18537, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 39, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - On Aggro - Call For Help'),
(18537, 0, 7, 0, 0, 0, 100, 0, 0, 3500, 2000, 7500, 0, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - In Combat - Cast \'Crusader Strike\''),
(18537, 0, 8, 0, 0, 0, 100, 0, 15000, 40000, 20000, 60000, 0, 11, 13005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - In Combat - Cast \'Hammer of Justice\''),
(18538, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 1, 1853800, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - On Data Set 1 1 - Start Waypoint'),
(18538, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - On Data Set 1 1 - Remove Npc Flags Gossip & Questgiver'),
(18538, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - On Data Set 1 1 - Set Faction 250'),
(18538, 0, 3, 0, 40, 0, 100, 0, 18, 1853800, 0, 0, 0, 80, 1853800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - On Waypoint 18 Reached - Run Script'),
(18538, 0, 4, 0, 8, 0, 100, 0, 35598, 0, 0, 0, 0, 11, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - On Spellhit \'Wrath of Socrethar\' - Cast \'Permanent Feign Death\''), -- Yes, these are sniffed
(18538, 0, 5, 0, 8, 0, 100, 0, 35599, 0, 0, 0, 0, 28, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - On Spellhit \'Resurrection\' - Remove Aura \'Permanent Feign Death\''),
(18538, 0, 6, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 39, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - On Aggro - Call For Help'),
(18538, 0, 7, 0, 0, 0, 100, 0, 0, 3500, 2500, 7500, 0, 11, 15238, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - In Combat - Cast \'Holy Smite\''),
(18538, 0, 8, 0, 14, 0, 100, 0, 5000, 40, 30000, 60000, 0, 11, 35096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - Friendly At 5000 Health - Cast \'Greater Heal\''),
(18538, 0, 9, 0, 14, 0, 100, 0, 3000, 40, 45000, 75000, 0, 11, 22187, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - Friendly At 3000 Health - Cast \'Power Word: Shield\''),
(19466, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - On Just Summoned - Set Npc Flag '),
(19466, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1946601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - On Data Set 1 1 - Run Script'),
(19466, 0, 2, 0, 0, 0, 100, 0, 0, 3500, 15000, 21000, 0, 11, 29426, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - In Combat - Cast \'Heroic Strike\''),
(19466, 0, 3, 0, 0, 0, 100, 0, 10000, 15000, 30000, 30000, 0, 11, 16509, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - In Combat - Cast \'Rend\''),
(19466, 0, 4, 0, 0, 0, 100, 0, 7500, 21000, 20000, 45000, 0, 11, 13730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - In Combat - Cast \'Demoralizing Shout\''),
(19467, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Karja - On Just Summoned - Set Npc Flag '),
(19467, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 1946701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Karja - On Data Set 1 1 - Run Script'),
(19467, 0, 2, 0, 0, 0, 100, 0, 3500, 10000, 7500, 15000, 0, 11, 9734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Karja - In Combat - Cast \'Holy Smite\''),
(19467, 0, 3, 0, 14, 0, 100, 0, 4000, 40, 15000, 30000, 0, 11, 35096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Karja - Friendly At 4000 Health - Cast \'Greater Heal\''),
(20132, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2013200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - On Data Set 1 1 - Run Script'),
(20132, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 11, 35596, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - On Data Set 2 2 - Cast \'Power of the Legion\''),
(20132, 0, 2, 0, 38, 0, 100, 0, 3, 3, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 18538, 50, 0, 0, 0, 0, 0, 0, 'Socrethar - On Data Set 3 3 - Set Orientation Closest Creature \'Ishanah\''),
(20132, 0, 3, 0, 38, 0, 100, 0, 4, 4, 0, 0, 0, 80, 2013201, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - On Data Set 4 4 - Run Script'),
(20132, 0, 4, 0, 38, 0, 100, 0, 5, 5, 0, 0, 0, 80, 2013202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - On Data Set 5 5 - Run Script'),
(20132, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35762, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - On Just Died - Cast \'Serverside - Socrethar Quest Credit\''),
(20132, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 19, 18538, 100, 0, 0, 0, 0, 0, 0, 'Socrethar - On Just Died - Add Npc Flags Gossip & Questgiver to Ishanah'),
(20132, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 19, 20794, 100, 0, 0, 0, 0, 0, 0, 'Socrethar - On Just Died - Cleanup Event'),
(20132, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 19, 18537, 100, 0, 0, 0, 0, 0, 0, 'Socrethar - On Just Died - Cleanup Event'),
(20132, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 150000, 0, 0, 0, 0, 0, 19, 18538, 100, 0, 0, 0, 0, 0, 0, 'Socrethar - On Just Died - Cleanup Event'),
(20132, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 19, 19466, 100, 0, 0, 0, 0, 0, 0, 'Socrethar - On Just Died - Cleanup Event'),
(20132, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 60000, 0, 0, 0, 0, 0, 19, 19467, 100, 0, 0, 0, 0, 0, 0, 'Socrethar - On Just Died - Cleanup Event'),
(20132, 0, 12, 0, 23, 0, 100, 0, 37539, 0, 3600, 3600, 0, 11, 37539, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - On Missing Aura \'Nether Protection\' - Cast \'Nether Protection\''),
(20132, 0, 13, 0, 0, 0, 100, 0, 2500, 7500, 15000, 25000, 0, 11, 15496, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast \'Cleave\''),
(20132, 0, 14, 0, 0, 0, 100, 0, 10000, 15000, 40000, 60000, 0, 11, 37538, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast \'Anti-Magic Shield\''),
(20132, 0, 15, 0, 0, 0, 100, 0, 17000, 24000, 10000, 35000, 0, 11, 28448, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast \'Shadow Bolt Volley\''),
(20132, 0, 16, 0, 0, 0, 100, 0, 30000, 40000, 30000, 40000, 0, 11, 37540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast \'Fireball Barrage\''),
(20132, 0, 17, 0, 0, 0, 100, 0, 30000, 45000, 35000, 50000, 0, 11, 37537, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - In Combat - Cast \'Backlash\''),
(20794, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 0, 2079400, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - On Data Set 1 1 - Start Waypoint'),
(20794, 0, 1, 0, 58, 0, 100, 0, 4, 2079400, 0, 0, 0, 80, 2079400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - On Waypoint Finished - Run Script'),
(20794, 0, 2, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 80, 2079401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Between 0-25% Health - Run Script (No Repeat)'),
(20794, 0, 3, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 18538, 50, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - On Data Set 2 2 - Set Orientation Closest Creature \'Ishanah\''),
(20794, 0, 4, 0, 38, 0, 100, 0, 3, 3, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - On Data Set 3 3 - Set Flag Standstate Kneel'),
(20794, 0, 5, 0, 38, 0, 100, 0, 4, 4, 0, 0, 0, 80, 2079402, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - On Data Set 4 4 - Run Script'),
(20794, 0, 6, 0, 8, 0, 100, 0, 35600, 0, 0, 0, 0, 11, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - On Spellhit \'Wrath of Socrethar\' - Cast \'Permanent Feign Death\''),
(20794, 0, 7, 0, 0, 0, 100, 0, 2500, 7500, 3500, 8500, 0, 11, 37552, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - In Combat - Cast \'Burning Light\''),
(20794, 0, 8, 0, 0, 0, 100, 0, 8000, 12000, 12000, 21000, 0, 11, 37553, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - In Combat - Cast \'Consecration\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1853700, 1946601, 1946701, 2013200, 2079400, 2079401, 1853800, 2013201, 2079402, 2013202));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1853700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 19466, 15, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - Actionlist - Set Data 1 1 on Exarch Orelis (Start Follow, Set Faction)'),
(1853700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 19467, 15, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - Actionlist - Set Data 1 1 on Anchorite Karja (Start Follow, Set Faction)'),
(1853700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - Actionlist - Remove Npc Flags Gossip'),
(1853700, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - Actionlist - Set Faction 495'),
(1853700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33600, 0, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - Actionlist - Set Socrethar Flags Immune To Players & Immune To NPC\'s'),
(1853700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1853700, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Adyen the Lightwarden - Actionlist - Start Waypoint'),
(1946601, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - Actionlist - Set Faction 495'),
(1946601, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 2, 120, 0, 0, 0, 0, 19, 18537, 15, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - Actionlist - Start Follow Closest Creature \'Adyen the Lightwarden\''),
(1946601, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Exarch Orelis - Actionlist - Remove Flags Immune To NPC\'s'),
(1946701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Karja - Actionlist - Set Faction 495'),
(1946701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 2, 240, 0, 0, 0, 0, 19, 18537, 15, 0, 0, 0, 0, 0, 0, 'Anchorite Karja - Actionlist - Start Follow Closest Creature \'Adyen the Lightwarden\''),
(1946701, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Karja - Actionlist - Remove Flags Immune To NPC\'s'),
(2013200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 18537, 40, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Say Line 0 (Adyen the Lightwarden)'),
(2013200, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Say Line 0 (Socrethar)'),
(2013200, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 18537, 40, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Say Line 1 (Adyen the Lightwarden)'),
(2013200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 20794, 6, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 4955.0845, 3921.3977, 209.04483, 4.570129871368408, 'Socrethar - Actionlist - Summon Creature \'Kaylaan the Lost\''),
(2013200, 9, 5, 0, 0, 0, 100, 0, 6600, 6600, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Say Line 1 (Socrethar)'),
(2013200, 9, 6, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20794, 100, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Set Data 1 1'),
(2079400, 9, 0, 0, 0, 0, 100, 0, 600, 600, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Flag Standstate Kneel'),
(2079400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 18537, 40, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 2 (Adyen the Lightwarden)'),
(2079400, 9, 2, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Flag Standstate Stand Up'),
(2079400, 9, 3, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 53, 0, 2079401, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Start Waypoint'),
(2079400, 9, 4, 0, 0, 0, 100, 0, 2200, 2200, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 18537, 40, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Orientation Closest Creature \'Adyen the Lightwarden\''),
(2079400, 9, 5, 0, 0, 0, 100, 0, 3800, 3800, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 0 (Self)'),
(2079400, 9, 6, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 1 (Self)'),
(2079400, 9, 7, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 2 (Self)'),
(2079400, 9, 8, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 18537, 40, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 3 (Adyen the Lightwarden)'),
(2079400, 9, 9, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 3 (Self)'),
(2079400, 9, 10, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Data 2 2 on Socrethar - Cast \'Power of the Legion\''),
(2079400, 9, 11, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Faction 14'),
(2079400, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 2 (Socrethar)'),
(2079400, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Invincibility Hp 1'),
(2079400, 9, 14, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 18537, 40, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Start Attacking'),
(2079401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(2079401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Evade'),
(2079401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 3 (Socrethar)'),
(2079401, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 18538, 6, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 4866.1997, 3799.0156, 199.14102, 0.46805843710899353, 'Kaylaan the Lost - Actionlist - Summon Creature \'Ishanah\''),
(2079401, 9, 4, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 18538, 100, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Data 1 1 on Ishanah - Start WP'),
(2079401, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 4 (Self)'),
(2079401, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Flags Immune To Players'),
(1853800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 20794, 50, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Set Data 2 2 on Kaylaan - Set Facing'),
(1853800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Set Data 3 3 on Socrethar - Set Facing'),
(1853800, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 20794, 50, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Say Line 5 (Kaylaan)'),
(1853800, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, 20794, 50, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Set Data 3 3 on Kaylaan - Set Standstate'),
(1853800, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Say Line 0 (Self)'),
(1853800, 9, 5, 0, 0, 0, 100, 0, 6200, 6200, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Say Line 1 (Self)'),
(1853800, 9, 6, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Say Line 4 (Socrethar)'),
(1853800, 9, 7, 0, 0, 0, 100, 0, 3400, 3400, 0, 0, 0, 45, 4, 4, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Ishanah - Actionlist - Set Data 4 4 on Socrethar - Start Script'),
(2013201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35598, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Cast \'Wrath of Socrethar\''),
(2013201, 9, 1, 0, 0, 0, 100, 0, 7300, 7300, 0, 0, 0, 45, 4, 4, 0, 0, 0, 0, 19, 20794, 50, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Set Data 4 4 on Kaylaan - Start Script'),
(2079402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 6'),
(2079402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Remove FlagStandstate Kneel'),
(2079402, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35597, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Cast \'Cancel Power of the Legion\''),
(2079402, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 2079402, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Start Waypoint'),
(2079402, 9, 4, 0, 0, 0, 100, 0, 5600, 5600, 0, 0, 0, 2, 290, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Faction 290'),
(2079402, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Say Line 7'),
(2079402, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 13874, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Cast \'Divine Shield\''),
(2079402, 9, 7, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 11, 35599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Cast \'Resurrection\''),
(2079402, 9, 8, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 45, 5, 5, 0, 0, 0, 0, 10, 71631, 20132, 0, 0, 0, 0, 0, 0, 'Kaylaan the Lost - Actionlist - Set Data 5 5 on Socrethar - Start Last Script'),
(2013202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Say Line 5'),
(2013202, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 11, 35600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Cast \'Wrath of Socrethar\''),
(2013202, 9, 2, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(2013202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 18538, 50, 0, 0, 0, 0, 0, 0, 'Socrethar - Actionlist - Start Attacking');

-- Remove Civilian flag, Add IMMUNE_TO_PLAYERS instead
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~2, `unit_flags`=`unit_flags`|256 WHERE (`entry` IN (19466, 19467, 18538, 18537));
