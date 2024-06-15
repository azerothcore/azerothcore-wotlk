-- DB update 2023_02_28_00 -> 2023_03_01_00
-- Bonechewer Messenger
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=0 AND `entryorguid`=21244 AND `id`=0;
-- Coilskar Cistern
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=0 AND `entryorguid`=-25065 AND `id`=1002;
-- The Botanica
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=9 AND `entryorguid` IN (1842000, 1842002) AND `id`=3;
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=9 AND `entryorguid` IN (1842001, 1842003) AND `id`=5;
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=0 AND `entryorguid` IN (-147029, -147030, -147031, -147032, -147034) AND `id`=1001;
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=0 AND `entryorguid`=-147058 AND `id`=1002;
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=9 AND `entryorguid`=1842100 AND `id`=5;
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=9 AND `entryorguid` IN (1950501, 1950502, 1950503, 1950504) AND `id`=1;
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=0 AND `entryorguid` IN (-147019, -147021, -147022, -147023, -147020, -147024, -147006, -147018, -147005, -147007) AND `id`=1002;
UPDATE `smart_scripts` SET `action_param6`=2 WHERE `source_type`=0 AND `entryorguid`=-147035 AND `id` IN (1001, 1004);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-147040, -147025, -147026));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-147040, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 12500, 13000, 0, 11, 34793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - In Combat - Cast \'Arcane Blast\''),
(-147040, 0, 1, 0, 2, 0, 100, 1, 60, 80, 0, 0, 0, 11, 34791, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - Between 60-80% Health - Cast \'Arcane Explosion\' (No Repeat)'),
(-147040, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 0, 11, 34785, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - Between 20-40% Health - Cast \'Arcane Volley\' (No Repeat)'),
(-147040, 0, 1001, 1002, 10, 0, 100, 1, 0, 90, 0, 0, 1, 45, 1, 1, 0, 0, 0, 0, 10, 147025, 17993, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - Within 0-90 Range Out of Combat LoS - Set Data 1 1'),
(-147040, 0, 1002, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 147026, 17993, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - Within 0-90 Range Out of Combat LoS - Set Data 1 1'),

(-147026, 0, 0, 0, 0, 0, 100, 1, 2000, 4000, 0, 0, 0, 11, 34784, 0, 0, 0, 0, 0, 26, 20, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast \'Intervene\' (No Repeat)'),
(-147026, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 9000, 11000, 0, 11, 29765, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast \'Crystal Strike\''),
(-147026, 0, 2, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 0, 11, 35399, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast \'Spell Reflection\''),
(-147026, 0, 1001, 0, 58, 0, 100, 1, 6, 1799308, 0, 0, 0, 80, 1799301, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Waypoint Finished - Run Script'),
(-147026, 0, 1002, 0, 38, 0, 100, 1, 1, 1, 0, 0, 0, 53, 0, 1799308, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Data Set 1 1 - Start Waypoint'),
(-147026, 0, 1003, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Respawn - Set Sheath Unarmed'),

(-147025, 0, 0, 0, 0, 0, 100, 1, 2000, 4000, 0, 0, 0, 11, 34784, 0, 0, 0, 0, 0, 26, 20, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast \'Intervene\' (No Repeat)'),
(-147025, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 9000, 11000, 0, 11, 29765, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast \'Crystal Strike\''),
(-147025, 0, 2, 0, 0, 0, 100, 0, 8000, 10000, 15000, 20000, 0, 11, 35399, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - In Combat - Cast \'Spell Reflection\''),
(-147025, 0, 1001, 0, 58, 0, 100, 1, 7, 1799309, 0, 0, 0, 80, 1799301, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Waypoint Finished - Run Script'),
(-147025, 0, 1002, 0, 38, 0, 100, 1, 1, 1, 0, 0, 0, 53, 0, 1799309, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Data Set 1 1 - Start Waypoint'),
(-147025, 0, 1003, 0, 11, 0, 100, 1, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodwarder Protector - On Respawn - Set Sheath Unarmed');

UPDATE `creature` SET `position_x`=6.90713, `position_y`=230.813, `position_z`=-5.45704, `orientation`=3.45575 WHERE `id1`=17993 AND `guid`=147025;
UPDATE `creature` SET `position_x`=-8.30962, `position_y`=231.934, `position_z`=-5.45701, `orientation`=0.349066 WHERE `id1`=17993 AND `guid`=147026;
