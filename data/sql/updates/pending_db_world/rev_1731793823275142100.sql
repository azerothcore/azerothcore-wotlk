DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-45537,-45570,-45571,-48394,-48400,-54994,-54996,-54999,-55062,-55064,-55065);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25507);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25507, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(25507, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning'),
(25507, 0, 2, 0, 25, 0, 100, 769, 0, 0, 0, 0, 0, 0, 11, 59123, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Reset - Cast Banish'),
(25507, 0, 3, 0, 101, 0, 100, 0, 1, 10, 30000, 2000, 2000, 0, 28, 59123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On 1 or More Players in Range - Remove Aura \'Cosmetic - Stun + Immune Permanent (Freeze Anim)\''),
(25507, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 59123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Aggro - Remove Aura \'Cosmetic - Stun + Immune Permanent (Freeze Anim)\''),
(25507, 0, 5, 6, 8, 0, 100, 512, 46476, 0, 0, 0, 0, 0, 28, 59123, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spellhit \'Sunblade Protector Activated\' - Remove Aura \'Cosmetic - Stun + Immune Permanent (Freeze Anim)\''),
(25507, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - On Spellhit \'Sunblade Protector Activated\' - Set In Combat With Zone');

SET @GUID := 48394;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -@GUID);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-@GUID, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(-@GUID, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning');

SET @GUID := 48400;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -@GUID);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-@GUID, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(-@GUID, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning');

SET @GUID := 54999;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -@GUID);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-@GUID, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 18950, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Invisibility and Stealth Detection'),
(-@GUID, 0, 1, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning');
