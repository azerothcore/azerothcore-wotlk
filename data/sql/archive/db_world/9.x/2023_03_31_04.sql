-- DB update 2023_03_31_03 -> 2023_03_31_04
--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 13696;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 13696) AND (`source_type` = 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 178908) AND (`source_type` = 1) AND (`id` IN (4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(178908, 1, 4, 0, 8, 0, 100, 0, 21885, 0, 0, 0, 0, 50, 178904, 90000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vylestem Vine - On Spellhit \'Heal Vylestem Vine\' - Summon Gameobject \'Vylestem Vine\'');
