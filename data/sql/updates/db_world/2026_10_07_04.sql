-- DB update 2026_10_07_03 -> 2026_10_07_04
--
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (19973, 20557, 22195, 22201, 22204, 22291, 22327, 22392);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19973, 0, 0, 0, 0, 0, 100, 0, 6000, 15000, 18000, 28000, 0, 0, 11, 37633, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Abyssal Flamebringer - IC - Cast Abyssal Strike'),
(20557, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 22911, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Hound - On Aggro - Cast \'Charge\''),
(20557, 0, 1, 0, 0, 0, 100, 0, 5000, 11000, 20000, 27000, 0, 0, 11, 36406, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Hound - In Combat - Cast \'Double Breath\''),
(22195, 0, 0, 0, 0, 0, 75, 0, 2500, 7500, 14000, 18000, 0, 0, 11, 34017, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Speaker - In Combat - Cast \'Rain of Chaos\''),
(22195, 0, 1, 0, 0, 0, 100, 0, 10100, 14100, 122000, 130000, 0, 0, 11, 11980, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrath Speaker - In Combat - Cast \'Curse of Weakness\''),
(22204, 0, 0, 0, 0, 0, 100, 0, 9000, 20000, 13000, 27000, 0, 0, 11, 38356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fear Fiend - IC - Cast Fel Flames'),
(22291, 0, 0, 0, 0, 0, 100, 0, 6300, 12800, 6300, 12800, 0, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Furnace Guard - In Combat - Cast \'Mortal Strike\'');

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (22201, 22327, 22392);
