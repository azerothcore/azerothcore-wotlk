 -- Rogue, elementalist, spiritbinder
UPDATE `creature_template` SET `faction` = 16, `VerifiedBuild` = 53788 WHERE `entry` IN (23318, 23523, 23524);

 -- Shade of Akama
UPDATE `creature_template` SET `faction` = 1692, `VerifiedBuild` = 53788 WHERE `entry` = 22841;

 -- Ashtongue Defender
UPDATE `creature_template` SET `faction` = 1847, `VerifiedBuild` = 53788 WHERE `entry` = 23216;

 -- Sorcerer, channeler
UPDATE `creature_template` SET `faction` = 1849, `VerifiedBuild` = 53788 WHERE `entry` IN (23215, 23421);

-- SAI
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23318) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23318, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 23210, 0, 100, 0, 0, 0, 0, 0, 'Ashtongue Rogue - On Evade - Do Action');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23523) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23523, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 23210, 0, 100, 0, 0, 0, 0, 0, 'Ashtongue Elementalist - On Evade - Do Action');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23524) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23524, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 4, 0, 0, 0, 0, 0, 9, 23210, 0, 100, 0, 0, 0, 0, 0, 'Ashtongue Spiritbinder - On Evade - Do Action');
