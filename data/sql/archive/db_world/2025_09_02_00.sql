-- DB update 2025_08_30_03 -> 2025_09_02_00

-- Morbid Carcass, Vault Geist, Rabid Cannibal, Death Knight Master
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (29719, 29720, 29722, 29738));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (29719, 29720, 29722, 29738));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29719, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 8000, 12000, 0, 0, 11, 40504, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Morbid Carcass - In Combat - Cast \'Cleave\''),
(29719, 0, 1, 0, 9, 0, 100, 0, 8000, 12000, 8000, 12000, 8, 40, 11, 50335, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Morbid Carcass - Within 8-40 Range - Cast \'Scourge Hook\''),
(29720, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 97, 20, 10, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vault Geist - On Aggro - Jump To Pos'),
(29720, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 18000, 24000, 0, 0, 11, 36590, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Vault Geist - In Combat - Cast \'Rip\''),
(29738, 0, 0, 0, 0, 0, 100, 0, 0, 0, 20000, 24000, 0, 0, 11, 50688, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Master - In Combat - Cast \'Plague Strike\''),
(29738, 0, 1, 0, 60, 0, 100, 0, 0, 0, 30000, 30000, 0, 0, 11, 50689, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Master - On Update - Cast \'Blood Presence\''),
(29722, 0, 0, 0, 0, 0, 100, 0, 2000, 4000, 18000, 22000, 0, 0, 11, 30639, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rabid Cannibal - In Combat - Cast \'Carnivorous Bite\'');
