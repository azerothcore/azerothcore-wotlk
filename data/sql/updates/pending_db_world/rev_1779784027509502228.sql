--
-- Place mod-transmog Warpweaver (entry 190010) in front of the
-- two faction-capital banks so players can transmog without a GM
-- having to .npc add one manually after install.
--
--   Stormwind - Trade District, plaza directly in front of the
--                bank doors, facing south toward the doors.
--   Orgrimmar - Valley of Strength, top of the descending bank
--                ramp, facing south toward the ramp.
--
-- Idempotent: deletes any existing transmog spawns in a small
-- bounding box around each placement before re-inserting, so the
-- update is safe to re-apply.

-- Stormwind (map 0) - location captured in-game via .gps in front of the bank.
DELETE FROM `creature` WHERE `id1` = 190010 AND `map` = 0 AND `position_x` BETWEEN -8825 AND -8810 AND `position_y` BETWEEN 625 AND 640;
INSERT INTO `creature`
    (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,
     `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
     `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
     `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`,
     `VerifiedBuild`, `CreateObject`, `Comment`)
VALUES
    (NULL, 190010, 0, 0, 0, 1519, 1519, 1, 1,
     0, -8817.396, 630.66156, 94.163574, 5.3968263,
     300, 0, 0, 1, 0,
     0, 0, 0, 0, '',
     0, 0, 'mod-transmog Warpweaver - Stormwind, in front of bank');

-- Orgrimmar (map 1) - location captured in-game via .gps in front of the bank.
DELETE FROM `creature` WHERE `id1` = 190010 AND `map` = 1 AND `position_x` BETWEEN 1610 AND 1625 AND `position_y` BETWEEN -4380 AND -4365;
INSERT INTO `creature`
    (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,
     `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
     `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`,
     `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`,
     `VerifiedBuild`, `CreateObject`, `Comment`)
VALUES
    (NULL, 190010, 0, 0, 1, 1637, 1637, 1, 1,
     0, 1615.4972, -4374.2935, 26.222826, 2.5195222,
     300, 0, 0, 1, 0,
     0, 0, 0, 0, '',
     0, 0, 'mod-transmog Warpweaver - Orgrimmar, in front of bank');
