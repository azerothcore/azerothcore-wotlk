DELETE FROM `spell_target_position` WHERE `ID`=17278  AND `EffectIndex`=0;
DELETE FROM `spell_target_position` WHERE `ID`=17237  AND `EffectIndex`=0;
DELETE FROM `spell_target_position` WHERE `ID`=17239  AND `EffectIndex`=0;
DELETE FROM `spell_target_position` WHERE `ID`=17240  AND `EffectIndex`=0;
INSERT INTO `spell_target_position` VALUES
(17278, 0, 329, 3533.95, -2965.1, 125, 0, 0),
(17237, 0, 329, 3838, -3500, 195, 0, 0),
(17239, 0, 329, 3847, -3748, 195, 0, 0),
(17240, 0, 329, 4057, -3665, 182, 0, 0);

DELETE FROM `creature_text` WHERE `CreatureID` = 10399;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10399, 0, 0, 'One of the Ash\'ari Crystals has been destroyed!  Slay the intruders!', 14, 0, 100, 0, 0, 0, 6492, 3, 'Thuzadin Acolyte'),
(10399, 0, 1, 'An Ash\'ari Crystal has fallen! Stay true to the Lich King, my brethren, and attempt to resummon it.', 14, 0, 100, 0, 0, 0, 6526, 3, 'Thuzadin Acolyte'),
(10399, 0, 2, 'An Ash\'ari Crystal has been toppled! Restore the ziggurat before the Slaughterhouse is vulnerable!', 14, 0, 100, 0, 0, 0, 6527, 3, 'Thuzadin Acolyte');

-- Thuzadin Acolyte smart ai
SET @ENTRY := 10399;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Cannot be used with Spell 17237
(@ENTRY, 0, 0, 0, 1, 0, 100, 1, 0, 0, 5200, 5200, 11, 17224, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - Out of Combat - Cast spell (17224) on Self'),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 0, 2000, 3000, 4500, 11, 11660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - In Combat -  Cast spell (11660) with flags combat move on Victim'),
(@ENTRY, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 53267, 10399, 0, 0, 0, 0, 0, 'On death - Creature Thuzadin Acolyte (10399) with guid 53267 (fetching): Talk 0 to invoker'),
(@ENTRY, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 10415, 200, 0, 0, 0, 0, 0, 'On death - Closest alive creature Ash\'ari Crystal (10415) in 200 yards: Set creature data #2 to 2'),
-- Cannot be used with Spell 17224
(@ENTRY, 0, 4, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 17237, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - Out of Combat Cast spell  (17237) on Self'),
(@ENTRY, 0, 5, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 17239, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - Out of Combat Cast spell  (17239) on Self'),
(@ENTRY, 0, 6, 0, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 11, 17240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thuzadin Acolyte - Out of Combat Cast spell  (17240) on Self');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 10399 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES 
(22, 1, 10399, 0, 0, 31, 1, 3, 10399, 53262, 0, 'Object is creature, entry is 10399 and guid is 53262'),
(22, 1, 10399, 0, 1, 31, 1, 3, 10399, 53263, 0, 'Object is creature, entry is 10399 and guid is 53263'),
(22, 1, 10399, 0, 2, 31, 1, 3, 10399, 53264, 0, 'Object is creature, entry is 10399 and guid is 53264'),
(22, 1, 10399, 0, 3, 31, 1, 3, 10399, 53265, 0, 'Object is creature, entry is 10399 and guid is 53265'),
(22, 1, 10399, 0, 4, 31, 1, 3, 10399, 53266, 0, 'Object is creature, entry is 10399 and guid is 53266'),
(22, 3, 10399, 0, 0, 29, 1, 10399, 50, 0, 1, 'There is no creature Thuzadin Acolyte (10399) within range 50 yards to Object'),
(22, 5, 10399, 0, 0, 31, 1, 3, 10399, 53262, 0, 'Object is creature, entry is 10399 and guid is 53262'),
(22, 5, 10399, 0, 1, 31, 1, 3, 10399, 53263, 0, 'Object is creature, entry is 10399 and guid is 53263'),
(22, 5, 10399, 0, 2, 31, 1, 3, 10399, 53264, 0, 'Object is creature, entry is 10399 and guid is 53264'),
(22, 5, 10399, 0, 3, 31, 1, 3, 10399, 53265, 0, 'Object is creature, entry is 10399 and guid is 53265'),
(22, 5, 10399, 0, 4, 31, 1, 3, 10399, 53266, 0, 'Object is creature, entry is 10399 and guid is 53266'),
(22, 6, 10399, 0, 0, 31, 1, 3, 10399, 53268, 0, 'Object is creature, entry is 10399 and guid is 53268'),
(22, 6, 10399, 0, 1, 31, 1, 3, 10399, 53269, 0, 'Object is creature, entry is 10399 and guid is 53269'),
(22, 6, 10399, 0, 2, 31, 1, 3, 10399, 53270, 0, 'Object is creature, entry is 10399 and guid is 53270'),
(22, 6, 10399, 0, 3, 31, 1, 3, 10399, 53271, 0, 'Object is creature, entry is 10399 and guid is 53271'),
(22, 6, 10399, 0, 4, 31, 1, 3, 10399, 53272, 0, 'Object is creature, entry is 10399 and guid is 53272'),
(22, 7, 10399, 0, 0, 31, 1, 3, 10399, 53258, 0, 'Object is creature, entry is 10399 and guid is 53258'),
(22, 7, 10399, 0, 1, 31, 1, 3, 10399, 53259, 0, 'Object is creature, entry is 10399 and guid is 53259'),
(22, 7, 10399, 0, 2, 31, 1, 3, 10399, 53260, 0, 'Object is creature, entry is 10399 and guid is 53260'),
(22, 7, 10399, 0, 3, 31, 1, 3, 10399, 53261, 0, 'Object is creature, entry is 10399 and guid is 53261'),
(22, 7, 10399, 0, 4, 31, 1, 3, 10399, 53257, 0, 'Object is creature, entry is 10399 and guid is 53257');
