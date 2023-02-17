-- Sha'ni Proudtusk - On summon, despawn other clones.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9136;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9136);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9136, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 9136, 5, 0, 0, 0, 0, 0, 0, 'Sha\'ni Proudtusk - On Just Summoned - Despawn Other Clones');
