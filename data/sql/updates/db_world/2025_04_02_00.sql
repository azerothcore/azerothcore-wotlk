-- DB update 2025_04_01_07 -> 2025_04_02_00

-- Set Flag Don't Override SAI
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |134217728 WHERE (`entry` IN(28941, 28942));

-- Set Action Lists
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2894100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Say Line 1'),
(2894100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52262, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Cast \'Cornered and Enraged!\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2894101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Reactstate Passive'),
(2894101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51604, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Cast \'Serverside - Stun Self\''),
(2894101, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 14564, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Play Sound 14564'),
(2894101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Emote State 431'),
(2894101, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2894102);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Event Phase 1'),
(2894102, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Reactstate Passive'),
(2894102, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Say Line 0'),
(2894102, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 14564, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Play Sound 14564'),
(2894102, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52716, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Cast \'Terrified\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2894200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Say Line 1'),
(2894200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52262, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Cast \'Cornered and Enraged!\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2894201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Reactstate Passive'),
(2894201, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51604, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Cast \'Serverside - Stun Self\''),
(2894201, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 14561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Play Sound 14561'),
(2894201, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 431, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Emote State 431'),
(2894201, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2894202);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2894202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Event Phase 1'),
(2894202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Set Reactstate Passive'),
(2894202, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Say Line 0'),
(2894202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 14561, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Play Sound 14561'),
(2894202, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52716, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Actionlist - Cast \'Terrified\'');

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28942;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28942);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28942, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 87, 2894200, 2894201, 2894202, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aggro - Run Random Script'),
(28942, 0, 1, 2, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Reset - Remove Aura \'null\''),
(28942, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Reset - Set Reactstate Aggressive'),
(28942, 0, 3, 4, 23, 1, 100, 0, 52716, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Evade (Phase 1)'),
(28942, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Set Event Phase 0 (Phase 1)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28941;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28941);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28941, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 87, 2894100, 2894101, 2894102, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aggro - Run Random Script'),
(28941, 0, 1, 2, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Reset - Remove Aura \'null\''),
(28941, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Reset - Set Reactstate Aggressive'),
(28941, 0, 3, 4, 23, 1, 100, 0, 52716, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Evade (Phase 1)'),
(28941, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - On Aura \'Terrified\' - Set Event Phase 0 (Phase 1)');

-- Set Comments
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 28941) AND (`guid` IN (129730, 129731, 129732, 129733, 129735, 129736, 129749, 129750, 129751, 129760, 129761, 129762, 129763, 129764, 129765, 129766, 129767, 129768));
UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 28942) AND (`guid` IN (129770, 129771, 129774, 129775, 129776, 129783, 129785, 129786, 129787, 129788, 129800, 129801, 129802, 129803, 129804, 129805));

-- Set Specific SmartAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-129730, -129731, -129732, -129733, -129735, -129736, -129749, -129750, -129751, -129760, -129761, -129762, -129763, -129764, -129765, -129766, -129767, -129768, -129770, -129771, -129774, -129775, -129776, -129783, -129785, -129786, -129787, -129788, -129800, -129801, -129802, -129803, -129804, -129805)) AND (`source_type` = 0) AND (`id` IN (3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129730, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129731, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129732, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129733, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129735, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129736, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129749, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129750, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129751, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129760, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129761, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129762, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129763, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129764, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129765, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129766, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129767, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129768, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129770, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129771, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129774, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129775, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129776, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129783, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129785, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129786, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129787, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129788, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129800, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129801, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129802, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129803, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129804, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2'),
(-129805, 0, 3, 0, 1, 0, 10, 0, 6000, 12000, 8000, 25000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Citizen of New Avalon - Out of Combat - Say Line 2');
