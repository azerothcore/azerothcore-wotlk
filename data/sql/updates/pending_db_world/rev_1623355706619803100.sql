INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623355706619803100');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 186283;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 186283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(186283, 1, 0, 0, 8, 0, 100, 0, 42287, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shipwreck Debris - On Spellhit \'Salvage Wreckage\' - Set Lootstate Deactivated');


-- Set Shipwreck Debris gameobject spawntimesecs to 180, it was 900
DELETE FROM `gameobject` WHERE (`id` = 186283) AND (`guid` IN (40784, 40782, 40780, 40778, 40776, 14616, 14609, 11181));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(40784, 186283, 1, 0, 0, 1, 1, -2597.8, -4356.95, -15.2234, 0.279253, 0, 0, 0.139173, 0.990268, 180, 100, 1, '', 0),
(40782, 186283, 1, 0, 0, 1, 1, -2761.82, -4496.42, -21.122, -1.37881, 0, 0, 0.636078, -0.771625, 180, 100, 1, '', 0),
(40780, 186283, 1, 0, 0, 1, 1, -2738.53, -4376.88, -20.0353, 2.18166, 0, 0, 0.887011, 0.461749, 180, 100, 1, '', 0),
(40778, 186283, 1, 0, 0, 1, 1, -2705.81, -4468.4, -9.34198, -2.82743, 0, 0, 0.987688, -0.156434, 180, 100, 1, '', 0),
(40776, 186283, 1, 0, 0, 1, 1, -2738.74, -4420.66, -11.1825, 2.63545, 0, 0, 0.968148, 0.25038, 180, 100, 1, '', 0),
(14616, 186283, 1, 0, 0, 1, 1, -2563.15, -4305, -18.7568, -0.418879, 0, 0, 0.207912, -0.978148, 180, 100, 1, '', 0),
(14609, 186283, 1, 0, 0, 1, 1, -2503.76, -4335.51, -10.131, -2.58309, 0, 0, 0.961262, -0.275637, 180, 100, 1, '', 0),
(11181, 186283, 1, 0, 0, 1, 1, -3022.92, -4480.41, -18.7516, 0.925024, 0, 0, 0.446198, 0.894934, 180, 100, 1, '', 0);

