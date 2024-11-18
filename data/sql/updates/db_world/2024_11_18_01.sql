-- DB update 2024_11_18_00 -> 2024_11_18_01
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-45537,-45570,-45571,-48394,-48400,-54994,-54996,-54999,-55062,-55064,-55065);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25507);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25507, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(25507, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning'),
(25507, 0, 2, 0, 25, 0, 100, 769, 0, 0, 0, 0, 0, 0, 11, 59123, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Reset - Cast Banish'),
(25507, 0, 3, 0, 101, 0, 100, 0, 1, 10, 30000, 2000, 2000, 0, 28, 59123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On 1 or More Players in Range - Remove Aura \'Cosmetic - Stun + Immune Permanent (Freeze Anim)\''),
(25507, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 59123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Aggro - Remove Aura \'Cosmetic - Stun + Immune Permanent (Freeze Anim)\''),
(25507, 0, 5, 6, 8, 0, 100, 512, 46476, 0, 0, 0, 0, 0, 28, 59123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spellhit \'Sunblade Protector Activated\' - Remove Aura \'Cosmetic - Stun + Immune Permanent (Freeze Anim)\''),
(25507, 0, 6, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spellhit \'Sunblade Protector Activated\' - Set In Combat With Zone'),
(25507, 0, 7, 10, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Reached Home - Say Line 3'),
(25507, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spellhit \'Sunblade Protector Activated\' - Say Line 1'),
(25507, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spellhit \'Sunblade Protector Activated\' - Say Line 2'),
(25507, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 59123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Reached Home - Cast \'Cosmetic - Stun + Immune Permanent (Freeze Anim)\'');

SET @GUID := 48394;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -@GUID);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-@GUID, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(-@GUID, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning'),
(-@GUID, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Aggro - Say Line 0');

SET @GUID := 48400;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -@GUID);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-@GUID, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(-@GUID, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning'),
(-@GUID, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Aggro - Say Line 0');

SET @GUID := 54999;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -@GUID);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-@GUID, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(-@GUID, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning'),
(-@GUID, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Aggro - Say Line 0');

DELETE FROM `creature_text` WHERE `CreatureID` = 25507;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `Comment`) VALUES
(25507, 0, 0, 'Enemy presence detected.', 14, 0, 100, 0, 0, 0, 25203, 0, 'Sunblade Protector - On Aggro'),
(25507, 1, 0, 'Local proximity threat detected. Exiting energy conservation mode.', 14, 0, 100, 0, 0, 0, 25201, 0, 'Sunblade Protector - Activated'),
(25507, 2, 0, 'Unit is now operational and attacking targets.', 14, 0, 100, 0, 0, 0, 25206, 0, 'Sunblade Protector - Activated'),
(25507, 3, 0, 'Unit entering energy conservation mode.', 14, 0, 100, 0, 0, 0, 25200, 0, 'Sunblade Protector - Just Reached Home');
