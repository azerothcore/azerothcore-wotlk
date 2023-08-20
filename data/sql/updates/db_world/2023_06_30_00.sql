-- DB update 2023_06_29_02 -> 2023_06_30_00
--
UPDATE `creature_loot_template` SET `Chance` = 0, `GroupId` = 1 WHERE (`Entry` = 20303);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18478, 0, 0, 0, 0, 0, 100, 0, 8500, 16800, 10900, 24100, 0, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - In Combat - Cast \'Mortal Strike\''),
(18478, 0, 1, 0, 0, 0, 100, 0, 6500, 11500, 6200, 15700, 0, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - In Combat - Cast \'Sunder Armor\''),
(18478, 0, 2, 0, 1, 0, 100, 512, 30000, 30000, 30000, 30000, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - Out of Combat - Despawn After 30s'),
(18478, 0, 3, 4, 54, 0, 100, 0, 0, 0, 0, 0, 0, 11, 33422, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - On Just Summoned - Cast \'Phase In\''),
(18478, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - On Just Summoned - Set In Combat With Zone'),
(18478, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 116, 900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - On Just Summoned - Set Corpse Delay to 15 Minutes');
