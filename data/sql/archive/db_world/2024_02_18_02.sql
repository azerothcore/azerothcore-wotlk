-- DB update 2024_02_18_01 -> 2024_02_18_02
-- Update creature 38023 'Crown Sprinkler' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` = 38023) AND (`guid` IN (244596, 244597, 244598, 244599, 244600));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(244596, 38023, 1, 1, 1, 0, 6777.62841796875, -4880.59375, 776.90655517578125, 0.06640588492155075, 120, 10, 1, 0, 0, 0, "", 52237, 2, NULL),
(244597, 38023, 1, 1, 1, 0, 6750.931640625, -4877.4775390625, 772.704833984375, 5.210490703582763671, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244598, 38023, 1, 1, 1, 0, 6734.32666015625, -4913.34375, 770.54388427734375, 5.959794998168945312, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(244599, 38023, 1, 1, 1, 0, 6719.81787109375, -4888.19970703125, 771.9097900390625, 0.665626347064971923, 120, 10, 1, 0, 0, 0, "", 52237, 2, NULL),
(244600, 38023, 1, 1, 1, 0, 6744.2177734375, -4893.55224609375, 770.9835205078125, 1.183032512664794921, 120, 10, 1, 0, 0, 0, "", 52237, 2, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` = 38023) AND (`guid` IN (12500, 12501, 12502, 12503, 12504));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12500, 38023, 1, 1, 1, 0, 6756.2421875, -4936.77099609375, 767.4073486328125, 4.647488594055175781, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12501, 38023, 1, 1, 1, 0, 6760.423828125, -4916.73779296875, 771.50250244140625, 2.868757486343383789, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12502, 38023, 1, 1, 1, 0, 6786.17626953125, -4896.470703125, 772.83807373046875, 2.314360618591308593, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL),
(12503, 38023, 1, 1, 1, 0, 6792.21923828125, -4928.8212890625, 764.412841796875, 2.97106480598449707, 120, 10, 1, 0, 0, 0, "", 52237, 2, NULL),
(12504, 38023, 1, 1, 1, 0, 6799.8212890625, -4882.111328125, 771.7579345703125, 3.310592889785766601, 120, 0, 0, 0, 0, 0, "", 52237, 2, NULL);

-- enable all spawns for eventEntry 8
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 8) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` = 38023));
INSERT INTO `game_event_creature` (SELECT 8, `guid` FROM `creature` WHERE `id1` = 38023);
