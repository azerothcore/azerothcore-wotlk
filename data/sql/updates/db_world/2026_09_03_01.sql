-- DB update 2026_09_03_00 -> 2026_09_03_01
--
-- Quest "The Hunter and the Prince" (13361, 13400) - restore the Illidan Stormrage summon
DELETE FROM `event_scripts` WHERE `id` = 20723;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(20723, 0, 10, 32588, 180000, 1, 6351.499, 2306.3413, 475.05063, 1.1115311);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 194023) AND (`source_type` = 1);

UPDATE `gameobject_template` SET `AIName` = '' WHERE `entry` = 194023;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 194023) AND (`SourceId` = 1);

-- Rank 3 gives Illidan a 10 minute corpse decay, so the body lingers in the phase for the next player.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 32588) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32588, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Summoned - Say Line 0'),
(32588, 0, 1, 0, 0, 0, 100, 0, 15000, 16000, 15000, 16000, 0, 0, 11, 60744, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - In Combat - Cast \'Immolation\''),
(32588, 0, 2, 0, 0, 0, 100, 0, 6000, 7000, 6000, 7000, 0, 0, 11, 61101, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - In Combat - Cast \'Pierced Heart\''),
(32588, 0, 4, 0, 0, 0, 100, 0, 19000, 19000, 19000, 19000, 0, 0, 11, 60742, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - In Combat - Cast \'Shear\''),
(32588, 0, 5, 6, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 32797, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Died - Quest Credit \'The Hunter and the Prince\''),
(32588, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 61623, 0, 0, 0, 0, 0, 19, 32326, 100, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Died - Remove Aura \'Echoes from the Past\' From Prince Arthas Menethil'),
(32588, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 61623, 0, 0, 0, 0, 0, 201, 61623, 0, 100, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Died - Remove Aura \'Echoes from the Past\' From Nearby Players'),
(32588, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Illidan Stormrage - On Just Died - Despawn In 5000 ms');
