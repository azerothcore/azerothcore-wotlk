-- DB update 2025_04_12_01 -> 2025_04_13_00

-- Add more sniffed SP
DELETE FROM `creature` WHERE (`id1` = 28406) AND (`guid` IN (129500, 129501, 129502, 129503));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(129500, 28406, 0, 0, 609, 0, 0, 1, 1, 1, 2400.0117, -5571.186, 377.0274, 4.69506, 360, 0, 0, 2614, 2117, 0, 0, 0, 0, '', 0, 0, NULL),
(129501, 28406, 0, 0, 609, 0, 0, 1, 1, 1, 2396.4502, -5595.242, 376.9796, 4.26250, 360, 0, 0, 2614, 2117, 0, 0, 0, 0, '', 0, 0, NULL),
(129502, 28406, 0, 0, 609, 0, 0, 1, 1, 1, 2450.6477, -5662.944, 376.9888, 0.33161, 360, 0, 0, 2614, 2117, 0, 0, 0, 0, '', 0, 0, NULL),
(129503, 28406, 0, 0, 609, 0, 0, 1, 1, 1, 2446.806, -5660.285, 376.98868, 3.31612, 360, 0, 0, 2614, 2117, 0, 0, 0, 0, '', 0, 0, NULL);
