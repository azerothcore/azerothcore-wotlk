-- DB update 2024_12_17_18 -> 2024_12_18_00

-- Set Flight to Disable Gravity and Rooted on 1

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28850);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(28850, 0, 0, 1, 1, 0, 0, 0);


-- Set SmartAI

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28850;


-- Add SmartAI

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28850);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28850, 0, 0, 0, 1, 0, 100, 513, 1000, 1000, 1000, 1000, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Land Cannon - Out of Combat - Disable Combat Movement (No Repeat)'),
(28850, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 4000, 5000, 0, 0, 11, 52539, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Land Cannon - In Combat - Cast \'Cannonball\'');
