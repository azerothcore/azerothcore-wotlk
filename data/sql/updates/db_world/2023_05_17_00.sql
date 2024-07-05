-- DB update 2023_05_15_00 -> 2023_05_17_00
--
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (-151019,-151020,-151021,-151022,-151023,-151024,-151025,-151026,-151027,-151028,-151029,-151030,-151031,-151032,-151033,-151034,-151019,-151020,-151021,-151022,-151023,-151024,-151025,-151026,-151027,-151028,-151029,-151030,-151031,-151032,-151033,-151034) AND `action_type` = 80 AND `action_param1` IN (1670011, 1670012);

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (-151019,-151020,-151021,-151022,-151023,-151024,-151025,-151026,-151027,-151028,-151029,-151030,-151031,-151032,-151033,-151034,-151019,-151020,-151021,-151022,-151023,-151024,-151025,-151026,-151027,-151028,-151029,-151030,-151031,-151032,-151033,-151034) AND `action_type` = 226;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-151019, 0, 1006, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Respawn - Disable'),
(-151020, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Respawn - Disable'),
(-151021, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Respawn - Disable'),
(-151022, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Respawn - Disable'),
(-151023, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Respawn - Disable'),
(-151024, 0, 1006, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Respawn - Disable'),
(-151025, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Respawn - Disable'),
(-151026, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Respawn - Disable'),
(-151027, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Respawn - Disable'),
(-151028, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Respawn - Disable'),
(-151029, 0, 1006, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Respawn - Disable'),
(-151030, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Respawn - Disable'),
(-151031, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Respawn - Disable'),
(-151032, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Respawn - Disable'),
(-151033, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Respawn - Disable'),
(-151034, 0, 1001, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 226, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Respawn - Disable'),
(-151019, 0, 1007, 1008, 77, 0, 100, 0, 1, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Counter 2/2 - Enable'),
(-151020, 0, 1002, 1003, 38, 0, 100, 0, 3, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 3 1 - Enable'),
(-151021, 0, 1002, 1003, 38, 0, 100, 0, 3, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Data Set 3 1 - Enable'),
(-151022, 0, 1002, 1003, 38, 0, 100, 0, 3, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Heathen - On Data Set 3 1 - Enable'),
(-151023, 0, 1002, 1003, 38, 0, 100, 0, 3, 1, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Data Set 3 1 - Enable'),
(-151024, 0, 1007, 1008, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Data Set 3 2 - Enable'),
(-151025, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 3 2 - Enable'),
(-151026, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Data Set 3 2 - Enable'),
(-151027, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Data Set 3 2 - Enable'),
(-151028, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Darkcaster - On Data Set 3 2 - Enable'),
(-151029, 0, 1008, 1009, 10, 0, 100, 267, 0, 90, 0, 0, 1, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Within 0-90 Range Out of Combat LoS - Enable'),
(-151030, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 3 2 - Enable'),
(-151031, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Reaver - On Data Set 3 2 - Enable'),
(-151032, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Data Set 3 2 - Enable'),
(-151033, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Data Set 3 2 - Enable'),
(-151034, 0, 1002, 1003, 38, 0, 100, 0, 3, 2, 0, 0, 0, 226, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Sharpshooter - On Data Set 3 2 - Enable');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -151019) AND (`source_type` = 0) AND (`id` IN (1009, 1010, 1011));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-151019, 0, 1009, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1670011, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Run Script'),
(-151019, 0, 1010, 0, 58, 0, 100, 0, 0, 1670002, 0, 0, 0, 80, 1670013, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Waypoint Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1670011);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1670011, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1670002, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Start Waypoint'),
(1670011, 9, 1, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Say Line 5');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -151024) AND (`source_type` = 0) AND (`id` IN (1008, 1009, 1010));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-151024, 0, 1008, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1670012, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Linked - Run Script'),
(-151024, 0, 1009, 0, 40, 0, 100, 0, 4, 1670004, 0, 0, 0, 80, 1670014, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - On Waypoint Finished - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1670012);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1670012, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 1670004, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Start Waypoint'),
(1670012, 9, 1, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Hand Legionnaire - Actionlist - Say Line 8');

UPDATE `smart_scripts` SET `event_flags`=257 WHERE `entryorguid`=-151029 AND `source_type`=0 AND `id`=1008 AND `link`=1009;
