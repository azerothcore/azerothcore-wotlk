-- DB update 2025_11_28_07 -> 2025_11_28_08
--
SET @CGUID := 20861;
DELETE FROM `creature` WHERE (`id1` = 31881) AND (`guid` = @CGUID);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(@CGUID, 31881, 0, 0, 571, 0, 0, 1, 1, 0, 7505.81, 1707.04, 350.194, 1.53589, 300, 0, 0, 63000, 0, 0, 0, 0, 0, '', '', 0);

UPDATE `creature_template` SET `ArmorModifier` = 0 WHERE (`entry` = 32227);

-- Disable Gravity, allows Parachute on exit
DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (31884, 32227));
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(31884, 0, 0, 1, 0, 0, 0, 0),
(32227, 0, 0, 1, 0, 0, 0, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 18) AND (`SourceGroup` IN (31884, 32227)) AND (`SourceEntry` = 46598) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(18, 31884, 46598, 0, 0, 9, 0, 13310, 0, 0, 0, 0, 0, '', 'Kor\'kron Suppression Turret requires player to be on quest Assault by Air'),
(18, 32227, 46598, 0, 0, 9, 0, 13309, 0, 0, 0, 0, 0, '', 'Skybreaker Suppression Turret requires player to be on quest Assault by Air');

UPDATE `vehicle_template_accessory` SET `summontype`=5 WHERE `entry`=31881 AND `seat_id`=1;
UPDATE `vehicle_template_accessory` SET `summontype`=5 WHERE `entry`=32225 AND `seat_id`=1;

-- Prevent vehicle and passengers to attack players from the opposite faction
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256 WHERE (`entry` IN (32225, 31881, 31882, 31891, 32223, 32225));
