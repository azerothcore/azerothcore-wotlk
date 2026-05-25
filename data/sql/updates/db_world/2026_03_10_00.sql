-- DB update 2026_03_09_02 -> 2026_03_10_00
-- Update gameobject 'Deadmines Doors and Levers' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (16399, 17153, 17154, 16400, 101831, 101834, 101832, 101833, 13965, 16397)) AND (`guid` IN (26182, 26183, 26184, 26185, 26188, 26192, 26197, 26206, 30533, 30534));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(26182, 16399, 36, 0, 0, 1, 1, -168.513961791992187, -579.86077880859375, 19.31592750549316406, 3.124123096466064453, 0, 0, 0.99996185302734375, 0.008734640665352344, 7200, 255, 1, "", 48632, NULL),
(26183, 17153, 36, 0, 0, 1, 1, -262.7137451171875, -482.361083984375, 49.43531036376953125, 6.265733242034912109, 0, 0, -0.00872611999511718, 0.999961912631988525, 7200, 255, 1, "", 48632, NULL),
(26184, 17154, 36, 0, 0, 1, 1, -242.9652099609375, -578.56103515625, 51.13660430908203125, 3.124123096466064453, 0, 0, 0.99996185302734375, 0.008734640665352344, 7200, 255, 1, "", 48632, NULL),
(26185, 16400, 36, 0, 0, 1, 1, -290.29412841796875, -536.96026611328125, 49.43531036376953125, 1.553341388702392578, 0, 0, 0.700908660888671875, 0.713251054286956787, 7200, 255, 1, "", 48632, NULL),
(26188, 101831, 36, 0, 0, 1, 1, -188.1365966796875, -460.31341552734375, 54.5590667724609375, 1.727874636650085449, 0, 0, 0.760405540466308593, 0.649448513984680175, 7200, 255, 1, "", 48632, NULL),
(26192, 101834, 36, 0, 0, 1, 1, -165.404327392578125, -576.9241943359375, 19.30643844604492187, 3.298687219619750976, 0, 0, -0.99691677093505859, 0.078466430306434631, 7200, 255, 1, "", 48632, NULL),
(26197, 101832, 36, 0, 0, 1, 1, -287.28204345703125, -539.8768310546875, 49.43212127685546875, 1.727874636650085449, 0, 0, 0.760405540466308593, 0.649448513984680175, 7200, 255, 1, "", 48632, NULL),
(26206, 101833, 36, 0, 0, 1, 1, -96.9277496337890625, -670.5966796875, 7.40338134765625, 1.902408957481384277, 0, 0, 0.814115524291992187, 0.580702960491180419, 7200, 255, 1, "", 48632, NULL),
(30533, 13965, 36, 0, 0, 1, 1, -191.41455078125, -457.44580078125, 54.43914413452148437, 1.692966461181640625, 0, 0, 0.74895477294921875, 0.662621140480041503, 7200, 255, 1, "", 48632, NULL),
(30534, 16397, 36, 0, 0, 1, 1, -100.501541137695312, -668.7706298828125, 7.410491943359375, 1.815141916275024414, 0, 0, 0.788010597229003906, 0.615661680698394775, 7200, 255, 1, "", 48632, NULL);

-- update SAI
-- Levers
UPDATE `smart_scripts` SET `target_param2` = 16399 WHERE (`source_type` = 1 AND `entryorguid` = 101834 AND `event_type` = 70 AND `target_param1` = 26182);
UPDATE `smart_scripts` SET `target_param2` = 16400 WHERE (`source_type` = 1 AND `entryorguid` = 101832 AND `event_type` = 70 AND `target_param1` = 26185);
-- Sneed
UPDATE `smart_scripts` SET `target_param2` = 16400 WHERE (`source_type` = 0 AND `entryorguid` = 643 AND `event_type` = 6 AND `target_param1` = 26185);
-- Gilnid
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1763 AND `id` = 2);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1763, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 14, 26182, 16399, 0, 0, 0, 0, 0, 0, 'Gilnid - On Just Died - Activate Gameobject');
