-- DB update 2024_11_11_01 -> 2024_11_11_02
--
UPDATE `creature` SET `ScriptName` = '' WHERE `guid` = 320 AND `id1` = 24358;
DELETE FROM `creature` WHERE `guid` = 89357 AND `id1` = 24239;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(89357, 24239, 568, 1, 1, 0, 117.363067626953125, 923.568603515625, 33.97257232666015625, 1.588249564170837402, 604800 , 0, 0, 0, 0, 0, "", 50375, 1, NULL);
