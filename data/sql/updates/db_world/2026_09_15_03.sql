-- DB update 2026_09_15_02 -> 2026_09_15_03
-- Aggro talk actions targeted the action invoker without useTalkTarget, so a
-- creature attacker (guardian, totem, NPC) became the talker. Talk from self.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2564 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2564, 0, 0, 0, 4, 0, 5, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Enforcer - On Aggro - Say Line 0 (No Repeat)'),
(2564, 0, 1, 0, 0, 0, 100, 0, 4800, 13100, 30500, 40900, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Enforcer - In Combat - Cast \'Demoralizing Shout\' (No Repeat)'),
(2564, 0, 2, 0, 2, 0, 100, 0, 0, 30, 27200, 46600, 0, 0, 11, 4955, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Boulderfist Enforcer - Between 0-30% Health - Cast \'Fist of Stone\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 25814 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25814, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Aggro - Say Line 1 (Phase 1) (No Repeat)'),
(25814, 0, 1, 2, 8, 0, 100, 512, 46485, 0, 0, 0, 0, 0, 33, 26096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Spellhit \'The Greatmother\'s Soulcatcher\' - Quest Credit \'Souls of the Decursed\''),
(25814, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Spellhit \'The Greatmother\'s Soulcatcher\' - Despawn In 10 ms');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 31258 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31258, 0, 0, 0, 0, 0, 100, 512, 0, 3000, 10000, 10000, 0, 0, 11, 35949, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Chosen Warrior - IC - Cast Bloodthirst (Self)'),
(31258, 0, 1, 0, 0, 0, 100, 512, 0, 1000, 2000, 4000, 0, 0, 11, 15496, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Chosen Warrior - IC - Cast Cleave'),
(31258, 0, 2, 0, 0, 0, 100, 512, 9000, 11000, 13000, 14000, 0, 0, 11, 61227, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Chosen Warrior - IC - Cast Jump Attack'),
(31258, 0, 3, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 61227, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Chosen Warrior - On Agro - Cast Jump Attack'),
(31258, 0, 4, 0, 4, 0, 66, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Chosen Warrior - On Agro - Say');
