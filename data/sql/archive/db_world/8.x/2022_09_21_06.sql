-- DB update 2022_09_21_05 -> 2022_09_21_06
SET @MAP_ID := 533;
-- Fixes Naxxramas portals & teleport orbs
-- Change portal animation from CCW to CW
-- Delete double stacked portals outside Naxxramas in Dragonblight
DELETE FROM `gameobject` WHERE `guid` IN (58826, 59714, 59738, 59743) AND `map` = 571;
-- Swap opposite portal position
-- 10man (id: 196467)
DELETE FROM `gameobject` WHERE `guid` IN (151232, 151234, 151230, 151227);
INSERT INTO `gameobject`
(`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,
`position_x`, `position_y`, `position_z`, `orientation`, `rotation0`,
`rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`,
`ScriptName`, `VerifiedBuild`)
VALUES
(151234, 196467, 571, 0, 0, 1, 1, 3680.62, -1258.41, 244.434, 4.00824, 0.0, 0.0, 0.907575, -0.419889, 300, 0, 1, '', 0),
(151230, 196467, 571, 0, 0, 1, 1, 3659.57, -1280.97, 244.434, 0.866651, 0.0, 0.0, 0.403068, 0.91517, 300, 0, 1, '', 0),
(151232, 196467, 571, 0, 0, 1, 1, 3658.92, -1259.47, 244.434, 5.57904, 0.0, 0.0, 0.344844, -0.93866, 300, 0, 1, '', 0),
(151227, 196467, 571, 0, 0, 1, 1, 3680.62, -1279.77, 244.434, 2.43745, 0.0, 0.0, 0.933127, 0.359547, 300, 0, 1, '', 0);
-- Swap opposite portal position
-- 25man (id: 192671)
DELETE FROM `gameobject` WHERE `guid` IN (151228, 151229, 151231, 151233);
INSERT INTO `gameobject`
(`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,
`position_x`, `position_y`, `position_z`, `orientation`, `rotation0`,
`rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`,
`ScriptName`, `VerifiedBuild`)
VALUES
(151233, 192671, 571, 0, 0, 1, 1, 3680.62, -1258.41, 244.434, 4.00824, 0.0, 0.0, 0.907575, -0.419889, 300, 0, 1, '', 0),
(151229, 192671, 571, 0, 0, 1, 1, 3659.57, -1280.97, 244.434, 0.866651, 0.0, 0.0, 0.403068, 0.91517, 300, 0, 1, '', 0),
(151228, 192671, 571, 0, 0, 1, 1, 3680.62, -1279.77, 244.434, 2.43745, 0.0, 0.0, 0.933127, 0.359547, 300, 0, 1, '', 0),
(151231, 192671, 571, 0, 0, 1, 1, 3658.92, -1259.47, 244.434, 5.57904, 0.0, 0.0, 0.352207, -0.935922, 300, 0, 1, '', 0);
-- Remove unused portal object top of outside Naxxramas in Dragonblight
DELETE FROM `gameobject` WHERE `guid` = 58826 AND `id` = 192613 AND `map` = 571;
-- Remove unused portal object inside Naxxramas
DELETE FROM `gameobject` WHERE `guid` = 65853 AND `map` = @MAP_ID;
-- Remove double stacked portals inside Naxxramas
 DELETE FROM `gameobject` WHERE `id` IN (192663, 192664, 192665, 192666) AND `map` = @MAP_ID;
 -- Update AreaTriggerTeleport to middle of blue portal area
 -- Fix position Orb of Naxxramas and areatrigger
 SET @ORB_TP_TO_SAPPH:= 202278;
 DELETE FROM `gameobject` WHERE `id` = @ORB_TP_TO_SAPPH AND `guid` = 268048 AND `map` = @MAP_ID;
 INSERT INTO `gameobject`
 (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,
 `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`,
 `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`,
 `ScriptName`, `VerifiedBuild`)
 VALUES
(268048, @ORB_TP_TO_SAPPH, @MAP_ID, 0, 0, 3, 1, 2997.5, -3437.73, 304.189, 5.95645, 0.0, 0.0,
-0.162641, 0.986685, 300, 0, 1, '', 0);
-- Update Teleport Positions of spells used by Naxxramas Portal and Orb of Naxxramas (id: 181575, ...) 
SET @DEATH_KNIGHT_PORTAL_EFFECT:= 28444;
SET @SAPPHIRON_ENTRY_SPELL:= 72617;
SET @SAPPHIRON_EXIT_SPELL:= 72613;
DELETE FROM `spell_target_position` WHERE `ID` IN (@DEATH_KNIGHT_PORTAL_EFFECT, @SAPPHIRON_EXIT_SPELL, @SAPPHIRON_ENTRY_SPELL);
INSERT INTO `spell_target_position`
(`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`)
VALUES
(@SAPPHIRON_ENTRY_SPELL, 0, @MAP_ID, 3498.300049, -5349.490234, 144.968002, 1.3698910, 0),
(@SAPPHIRON_EXIT_SPELL, 0, @MAP_ID, 3038.98, -3434.47, 298.22, 1.994, 0),
(@DEATH_KNIGHT_PORTAL_EFFECT, 0, @MAP_ID, 3005.51, -3434.64, 304.195, 6.2831, 0);
-- AreaTrigger (id: 4156) Teleport to Sapphiron's Lair
DELETE FROM `areatrigger_teleport` WHERE `ID` = 4156;
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4156;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4156, 'at_naxxramas_hub_portal');
