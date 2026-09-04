-- Ulduar: Mechanostriker 54-A template and movement updates
UPDATE `creature_template` SET `unit_flags` = 0, `ScriptName` = 'npc_mechanostriker_54_a' WHERE `entry` = 34161;
UPDATE `creature_template` SET `unit_flags` = 0, `ScriptName` = '' WHERE `entry` = 34162;

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (34161, 34162);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(34161, 1, 0, 1, 0, 0, 0, NULL),
(34162, 1, 0, 1, 0, 0, 0, NULL);

DELETE FROM `creature_template_addon` WHERE `entry` IN (34161, 34162);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(34161, 0, 0, 50331648, 1, 0, 0, NULL),
(34162, 0, 0, 50331648, 1, 0, 0, NULL);

-- Mechagnome Pilot accessory on Mechanostriker 54-A seat 0
DELETE FROM `vehicle_template_accessory` WHERE `entry` IN (34161, 34162);
INSERT INTO `vehicle_template_accessory` (`entry`, `accessory_entry`, `seat_id`, `minion`, `description`, `summontype`, `summontimer`) VALUES
(34161, 33216, 0, 1, 'Mechanostriker 54-A - Mechagnome Pilot', 6, 30000),
(34162, 33216, 0, 1, 'Mechanostriker 54-A (1) - Mechagnome Pilot', 6, 30000);

-- AreaTrigger scripts for Mechanostriker scripted event (side alleys)
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5416, 5417);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(5416, 'at_ulduar_mechanostriker_spawn'),
(5417, 'at_ulduar_mechanostriker_spawn');
