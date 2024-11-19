-- DB update 2024_05_26_02 -> 2024_05_27_00
-- update DONT_OVERRIDE_SAI_ENTRY
-- #18734
UPDATE `creature_template` SET `flags_extra` = 134217728 WHERE (`entry` = 4300);
UPDATE `creature_template` SET `flags_extra` = 134217728 WHERE (`entry` = 4301);
UPDATE `creature_template` SET `flags_extra` = 134217728 WHERE (`entry` = 4294);
UPDATE `creature_template` SET `flags_extra` = 134217728 WHERE (`entry` = 4295);
UPDATE `creature_template` SET `flags_extra` = 134217728 WHERE (`entry` = 4299);

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 429400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(429400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - Actionlist - Set_Faction Friend'),
(429400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - Actionlist - stop movement'),
-- new add
(429400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 212, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - Actionlist - Stop motion (StopMoving: 1, MovementExpired: 1)'),
(429400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - Actionlist - Set Facing player'),
(429400, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - Actionlist - SetStandState UNIT_STAND_STATE_STAND'),
(429400, 9, 5, 0, 0, 0, 100, 0, 500, 2500, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent  - Actionlist -  SetSheath  SHEATH_STATE_UNARMED'),
(429400, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - Actionlist -  SetSheath  UNIT_STAND_STATE_KNEEL'),
(429400, 9, 7, 0, 0, 0, 50, 0, 1000, 2000, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Monaster AshbringerEvent - Actionlist - Talk 0');

-- #18850 fix
UPDATE `creature_template` SET `flags_extra` = 134217728 WHERE (`entry` = 27202);
UPDATE `creature_template` SET `flags_extra` = 134217728 WHERE (`entry` = 27203);
