-- DB update 2025_01_09_02 -> 2025_01_10_00
-- Spawn alliance quest giver for Shattered Halls Imprisoned in the Citadel quest
DELETE FROM `creature` WHERE (`id1` = 17288) AND (`guid` IN (151300));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(151300, 17288, 0, 0, 540, 37114, 3714, 2, 1, 0, 120.88, 252.78, -14.57, 0.82, 7200, 0, 0, 6104, 0, 0, 2, 0, 0, '', 0);
