DELETE FROM `creature_text` WHERE `CreatureID`=11077;
INSERT INTO `creature_text` VALUES 
(11077, 0, 0, 'Who dares to approach this cauldron?  Taste my dark blade!', 12, 0, 100, 0, 0, 0, 6495, 0, 'Cauldron Lord Malvinious'),
(11077, 1, 0, '%s emerges from the shadows to defend the cauldron!', 16, 0, 100, 0, 0, 0, 6546, 0, 'Cauldron Lord Malvinious');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11076) AND (`source_type` = 0) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11076, 0, 4, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 10389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Razarch - On Respawn - Cast \'Spawn Smoke\' Spellid 10389');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11077;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11077);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11077, 0, 0, 0, 4, 0, 50, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Malvinious -  On Aggro -  Say Line 0'),
(11077, 0, 1, 2, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 10389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Malvinious -  On Respawn - Cast \'Spawn Smoke\' Spellid 10389'),
(11077, 0, 2, 0, 61, 0, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Cauldron Lord Malvinious  - Linked - Say Line 1');