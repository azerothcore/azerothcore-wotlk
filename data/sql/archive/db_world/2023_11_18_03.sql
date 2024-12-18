-- DB update 2023_11_18_02 -> 2023_11_18_03
-- Update gameobject 187932 'Alliance Bonfire' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` = 187932) AND (`guid` IN (76312));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(76312, 187932, 0, 0, 0, 1, 1, -5233.15625, -2893.372314453125, 337.285888671875, 6.056293010711669921, 0, 0, -0.11320304870605468, 0.993571877479553222, 120, 255, 1, "", 50063, NULL);

DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 1) AND (`guid` IN (76312));
INSERT INTO `game_event_gameobject` (`eventEntry`,`guid`) VALUES
(1, 76312);
