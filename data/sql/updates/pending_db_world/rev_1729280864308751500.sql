-- Update gameobject 'Burning Blade Pyre' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (182261, 182262, 182264, 182263))
AND (`guid` IN (22716, 22717, 22719, 268913));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(22716, 182261, 530, 0, 0, 1, 1, -2532.9775390625, 6307.27001953125, 14.02033710479736328, 2.95832991600036621, 0, 0, 0.995804786682128906, 0.091503240168094635, 181, 255, 1, "", 45704, NULL),
(22717, 182262, 530, 0, 0, 1, 1, -2475.288330078125, 6106.3974609375, 91.98321533203125, 1.980946660041809082, 0, 0, 0.836285591125488281, 0.5482940673828125, 181, 255, 1, "", 45704, NULL),
(22719, 182264, 530, 0, 0, 1, 1, -2533.192626953125, 6168.60791015625, 59.93909454345703125, 2.818698406219482421, 0, 0, 0.986995697021484375, 0.160746723413467407, 181, 255, 1, "", 45704, NULL),
(268913, 182263, 530, 0, 0, 1, 1, -2532.986083984375, 6306.90087890625, 14.0279855728149414, 2.818698406219482421, 0, 0, 0.986995697021484375, 0.160746723413467407, 181, 255, 1, "", 45704, NULL);

-- remove duplicate spawns
DELETE FROM `gameobject` WHERE (`id` IN (182263))
AND (`guid` IN (268914, 268915));
DELETE FROM `gameobject_addon` WHERE (`guid` IN (268914, 268915));
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 0) AND (`guid` IN (268914, 268915));

-- Update creature 'Burning Blade Pyre' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` IN (18305, 18306, 18307, 18308))
AND (`guid` IN (65640, 65641, 65642, 65643));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(65640, 18305, 530, 1, 1, 0, -2533.66455078125, 6306.66748046875, 18.541839599609375, 0.977384388446807861, 300, 0, 0, 0, 0, 0, "", 45704, 1, NULL),
(65641, 18306, 530, 1, 1, 0, -2533.37890625, 6168.4443359375, 60.02236557006835937, 2.076941728591918945, 300, 0, 0, 0, 0, 0, "", 45704, 1, NULL),
(65642, 18307, 530, 1, 1, 0, -2475.478759765625, 6106.6171875, 92.0659027099609375, 0.750491559505462646, 300, 0, 0, 0, 0, 0, "", 45704, 1, NULL),
(65643, 18308, 530, 1, 1, 0, -2331.2587890625, 6179.38916015625, 51.05326080322265625, 3.96189737319946289, 300, 0, 0, 0, 0, 0, "", 45704, 1, NULL);

-- add 184642 gameobjects for Spell Focus 1393
DELETE FROM `gameobject` WHERE (`id` IN (184642))
AND (`guid` IN (87, 88));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
-- same spawn position as guid 22717
(87, 184642, 530, 0, 0, 1, 1, -2475.288330078125, 6106.3974609375, 91.98321533203125, 1.980946660041809082, 0, 0, 0.836285591125488281, 0.5482940673828125, 181, 255, 1, "", 0, NULL),
-- same spawn position as guid 22719
(88, 184642, 530, 0, 0, 1, 1, -2533.192626953125, 6168.60791015625, 59.93909454345703125, 2.818698406219482421, 0, 0, 0.986995697021484375, 0.160746723413467407, 181, 255, 1, "", 0, NULL);
