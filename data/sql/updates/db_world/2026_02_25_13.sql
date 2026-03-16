-- DB update 2026_02_25_12 -> 2026_02_25_13
-- Update gameobject 'unnamed flames' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (184511, 184512, 184513)) AND (`guid` IN (198, 199, 200));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(198, 184511, 530, 0, 0, 1, 1, 4014.947021484375, 1910.8055419921875, 247.6915130615234375, 3.710935592651367187, 0, 0, -0.95975399017333984, 0.280842065811157226, 120, 255, 1, "", 45704, NULL),
(199, 184512, 530, 0, 0, 1, 1, 4017.040771484375, 1909.5833740234375, 247.8500213623046875, 5.209121227264404296, 0, 0, -0.51158809661865234, 0.85923081636428833, 120, 255, 1, "", 45704, NULL),
(200, 184513, 530, 0, 0, 1, 1, 4015.8291015625, 1909.7274169921875, 247.7547149658203125, 3.043226480484008789, 0, 0, 0.998790740966796875, 0.049163278192281723, 120, 255, 1, "", 45704, NULL);
