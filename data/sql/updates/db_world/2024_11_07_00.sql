-- DB update 2024_11_06_08 -> 2024_11_07_00
-- Update creature 'Winter Veil Gifts' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` IN (15745, 15746))
AND (`guid` IN (3565, 3566));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(3565, 15745, 0, 1, 1, 0, -4912.6767578125, -976.28009033203125, 501.53271484375, 2.49582076072692871, 120, 0, 0, 0, 0, 0, "", 52237, 1, NULL),
(3566, 15746, 1, 1, 1, 0, 1629.0364990234375, -4414.37841796875, 16.23163604736328125, 0.436332315206527709, 120, 0, 0, 0, 0, 0, "", 52237, 1, NULL);

-- enable all spawns for eventEntry 52
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 52)
AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (15745, 15746)));
INSERT INTO `game_event_creature` (SELECT 52, `guid` FROM `creature` WHERE `id1` IN (15745, 15746));
