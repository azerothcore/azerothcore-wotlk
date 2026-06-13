-- DB update 2026_02_27_03 -> 2026_02_27_04
-- Update gameobject 'Doodad_OrcBonFire01' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (192612)) AND (`guid` IN (50));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(50, 192612, 530, 0, 0, 1, 1, 7567.4794921875, -7359.6064453125, 161.88848876953125, 3.159062385559082031, 0, 0, -0.99996185302734375, 0.008734640665352344, 120, 255, 1, "", 49822, NULL);
