-- DB update 2025_01_24_01 -> 2025_01_25_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24674);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24674, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44196, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Initialize - Cast \'Rebirth\''),
(24674, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Reset - Set Invincibility Hp 5%'),
(24674, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44197, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Aggro - Cast \'Burn\''),
(24674, 0, 3, 0, 24, 0, 100, 0, 44226, 1, 5000, 5000, 0, 0, 11, 44202, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Target Buffed With \'Gravity Lapse\' - Cast \'Fireball\''),
(24674, 0, 4, 5, 2, 0, 100, 0, 0, 5, 10000, 10000, 0, 0, 11, 44199, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between 0-5% Health - Cast \'Ember Blast\''),
(24674, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 24675, 3, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between 0-5% Health - Summon Creature \'Phoenix Egg\''),
(24674, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between 0-5% Health - Set Reactstate Passive'),
(24674, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - Between 0-5% Health - Stop Combat'),
(24674, 0, 8, 9, 8, 0, 100, 0, 44199, 0, 0, 0, 0, 0, 28, 44197, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Spellhit \'Ember Blast\' - Remove Aura \'Burn\''),
(24674, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Spellhit \'Ember Blast\' - Set Visibility Off'),
(24674, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 204, 24675, 0, 0, 0, 0, 0, 0, 0, 'Phoenix - On Spellhit \'Ember Blast\' - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24675);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24675, 0, 0, 0, 37, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Initialize - Set Reactstate Passive'),
(24675, 0, 1, 2, 60, 0, 100, 0, 15000, 15000, 0, 0, 0, 0, 142, 100, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Set HP to 100%'),
(24675, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 44199, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Remove Aura \'Ember Blast\''),
(24675, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Set Reactstate Aggressive'),
(24675, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Set In Combat With Zone'),
(24675, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Set Visibility On'),
(24675, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Update - Despawn Instant'),
(24675, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Phoenix Egg - On Just Died - Despawn In 3000 ms');
