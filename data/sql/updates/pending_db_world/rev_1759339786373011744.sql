--
SET @CGUID := 20861;
DELETE FROM `creature` WHERE (`id1` = 31881) AND (`guid` = @CGUID);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(@CGUID, 31881, 0, 0, 571, 0, 0, 1, 1, 0, 7505.81, 1707.04, 350.194, 1.53589, 300, 0, 0, 63000, 0, 0, 0, 0, 0, '', '', 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31280);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31280, 0, 0, 0, 60, 1, 70, 512, 5000, 5000, 3000, 4000, 0, 0, 11, 59894, 0, 0, 0, 0, 0, 19, 31884, 90, 0, 0, 0, 0, 0, 0, 'Ymirheim Spear Gun - On Update - Cast \'Launch Spear\' (Phase 1)'),
(31280, 0, 1, 2, 8, 0, 100, 512, 59880, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Spear Gun - On Spellhit \'Suppression Charge\' - Set Event Phase 2'),
(31280, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 3128000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Spear Gun - On Spellhit \'Suppression Charge\' - Run Script'),
(31280, 0, 3, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ymirheim Spear Gun - On Reset - Set Event Phase 1'),
(31280, 0, 4, 0, 60, 1, 70, 512, 5000, 5000, 3000, 4000, 0, 0, 11, 59894, 0, 0, 0, 0, 0, 19, 32227, 90, 0, 0, 0, 0, 0, 0, 'Ymirheim Spear Gun - On Update - Cast \'Launch Spear\' (Phase 1)');

UPDATE `creature_template` SET `ArmorModifier` = 0 WHERE (`entry` = 32227);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceGroup` IN (31884, 32227)) AND (`SourceEntry` = 46598) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 31884, 46598, 0, 0, 9, 0, 13310, 0, 0, 0, 0, 0, '', 'Kor\'kron Suppression Turret requires player to be on quest Assault by Air'),
(18, 32227, 46598, 0, 0, 9, 0, 13309, 0, 0, 0, 0, 0, '', 'Skybreaker Suppression Turret requires player to be on quest Assault by Air');

UPDATE `vehicle_template_accessory` SET `summontype`=5 WHERE `entry`=31881 AND `seat_id`=1;
UPDATE `vehicle_template_accessory` SET `summontype`=5 WHERE `entry`=32225 AND `seat_id`=1;

-- Add immune to PC
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256 WHERE (`entry` IN (32225, 31881));

-- Remove immune to NPC
UPDATE `creature_template` SET `unit_flags` = `unit_flags` & ~256 WHERE (`entry` IN (32227, 31884));

UPDATE `vehicle_template_accessory` SET `minion`=0, `summontype`=5, `summontimer`=0 WHERE `entry`=31881 AND `seat_id`=0;
UPDATE `vehicle_template_accessory` SET `minion`=0, `summontype`=5, `summontimer`=0 WHERE `entry`=32225 AND `seat_id`=0;
