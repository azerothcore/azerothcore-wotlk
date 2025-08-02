-- queststarters / questenders
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE (`entry` IN (16484, 16490, 16493, 16495, 29441));

DELETE FROM `creature_queststarter` WHERE (`quest` IN (9261, 9262, 9263, 9264, 12816)) AND (`id` IN (16484, 16490, 16493, 16495, 29441));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(16484, 9261), -- Lieutenant Nevell
(16490, 9264), -- Lieutenant Lisande
(16495, 9262), -- Lieutenant Beitha
(16493, 9263), -- Lieutenant Dagel
(29441, 12816); -- Lieutenant Julek

DELETE FROM `creature_questender` WHERE (`quest` IN (9261, 9262, 9263, 9264, 12816)) AND (`id` IN (16484, 16490, 16493, 16495, 29441));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(16484, 9261), -- Lieutenant Nevell
(16490, 9264), -- Lieutenant Lisande
(16495, 9262), -- Lieutenant Beitha
(16493, 9263), -- Lieutenant Dagel
(29441, 12816); -- Lieutenant Julek

-- areatrigger
DELETE FROM areatrigger_involvedrelation WHERE id IN (4094, 4096, 4100, 4103, 4105);
INSERT INTO areatrigger_involvedrelation (id, quest) VALUES
(4094, 9260),
(4096, 9260),
(4100, 9265),
(4103, 9264),
(4105, 9262);

-- Update gameobject 'Circle' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (181227)) AND (`guid` IN (83038, 83039, 83040, 83041, 83042, 83043, 83044, 83045, 83046, 83047, 83048, 83049));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(83038, 181227, 1, 0, 0, 1, 1, 9948.0205078125, 1932.390625, 1328.691162109375, 3.682650327682495117, 0, 0, -0.96362972259521484, 0.26724100112915039, 120, 255, 1, "", 46248, NULL),
(83039, 181227, 1, 0, 0, 1, 1, 9914.181640625, 1864.6636962890625, 1321.25927734375, 2.914689540863037109, 0, 0, 0.993571281433105468, 0.113208353519439697, 120, 255, 1, "", 46248, NULL),
(83040, 181227, 1, 0, 0, 1, 1, -1545.46875, 51.28591537475585937, 5.394122123718261718, 0.628316879272460937, 0, 0, 0.309016227722167968, 0.95105677843093872, 120, 255, 1, "", 45572, NULL),
(83041, 181227, 0, 0, 0, 1, 1, 1980.00830078125, 305.231231689453125, 41.1893310546875, 0.436331570148468017, 0, 0, 0.216439247131347656, 0.976296067237854003, 120, 255, 1, "", 45572, NULL),
(83042, 181227, 1, 0, 0, 1, 1, 1179.3914794921875, -4564.47509765625, 21.45466232299804687, 0.575957298278808593, 0, 0, 0.284014701843261718, 0.958819925785064697, 120, 255, 1, "", 45572, NULL),
(83043, 181227, 1, 0, 0, 1, 1, 1148.54345703125, -4488.125, 19.8805694580078125, 4.014260292053222656, 0, 0, -0.90630722045898437, 0.422619491815567016, 120, 255, 1, "", 45613, NULL),
(83044, 181227, 0, 0, 0, 1, 1, -9240.787109375, 238.191192626953125, 72.8129730224609375, 4.572763919830322265, 0, 0, -0.75470924377441406, 0.656059443950653076, 120, 255, 1, "", 46158, NULL),
(83045, 181227, 0, 0, 0, 1, 1, -5375.5400390625, -735.15399169921875, 396.021240234375, 0.052358884364366531, 0, 0, 0.02617645263671875, 0.999657332897186279, 120, 255, 1, "", 46158, NULL),
(83046, 181227, 0, 0, 0, 1, 1, -9218.103515625, 318.78509521484375, 73.86499786376953125, 3.019413232803344726, 0, 0, 0.998134613037109375, 0.061051756143569946, 120, 255, 1, "", 45613, NULL),
(83047, 181227, 0, 0, 0, 1, 1, -5273.17236328125, -739.599853515625, 391.00933837890625, 2.513273954391479492, 0, 0, 0.951056480407714843, 0.309017121791839599, 120, 255, 1, "", 45613, NULL),
(83048, 181227, 0, 0, 0, 1, 1, -9244.455078125, 418.84027099609375, 87.46126556396484375, 3.001946926116943359, 0, 0, 0.997563362121582031, 0.069766148924827575, 120, 255, 1, "", 45613, NULL),
(83049, 181227, 0, 0, 0, 1, 1, -9183.8310546875, 416.188262939453125, 89.9123077392578125, 0.401424884796142578, 0, 0, 0.199367523193359375, 0.979924798011779785, 120, 255, 1, "", 45613, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (181227)) AND (`guid` BETWEEN 684 AND 691);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(684, 181227, 530, 0, 0, 1, 1, -4018.017333984375, -12150.943359375, 2.146352052688598632, 0.401424884796142578, 0, 0, 0.199367523193359375, 0.979924798011779785, 120, 255, 1, "", 45942, NULL),
(685, 181227, 530, 0, 0, 1, 1, -4105.47412109375, -12068.884765625, 3.33672499656677246, 4.572763919830322265, 0, 0, -0.75470924377441406, 0.656059443950653076, 120, 255, 1, "", 45435, NULL),
(686, 181227, 530, 0, 0, 1, 1, -4156.29150390625, -12123.388671875, 0.412930011749267578, 3.001946926116943359, 0, 0, 0.997563362121582031, 0.069766148924827575, 120, 255, 1, "", 45435, NULL),
(687, 181227, 530, 0, 0, 1, 1, -4183.55712890625, -12084.744140625, 2.419261932373046875, 3.019413232803344726, 0, 0, 0.998134613037109375, 0.061051756143569946, 120, 255, 1, "", 45435, NULL),
(688, 181227, 530, 0, 0, 1, 1, 9218.56640625, -7347.048828125, 39.06943511962890625, 3.001946926116943359, 0, 0, 0.997563362121582031, 0.069766148924827575, 120, 255, 1, "", 45942, NULL),
(689, 181227, 530, 0, 0, 1, 1, 9252.6943359375, -7315.2275390625, 26.01463890075683593, 3.019413232803344726, 0, 0, 0.998134613037109375, 0.061051756143569946, 120, 255, 1, "", 45942, NULL),
(690, 181227, 530, 0, 0, 1, 1, 9290.8349609375, -7356.06689453125, 24.00287437438964843, 0.401424884796142578, 0, 0, 0.199367523193359375, 0.979924798011779785, 120, 255, 1, "", 45942, NULL),
(691, 181227, 530, 0, 0, 1, 1, 9348.1875, -7351.76904296875, 12.69027996063232421, 4.572763919830322265, 0, 0, -0.75470924377441406, 0.656059443950653076, 120, 255, 1, "", 45572, NULL);

-- enable all spawns for eventEntry 17
DELETE FROM `game_event_gameobject` WHERE (`eventEntry` = 17) AND (`guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` IN (181227)));
INSERT INTO `game_event_gameobject` (SELECT 17, `guid` FROM `gameobject` WHERE `id` IN (181227));

-- TODO: update creature spawns with sniffed values

-- 9260 Investigate the Scourge of Stormwind (A)
-- .go c id 16478
-- done

-- 9261 Investigate the Scourge of Ironforge (A)
-- .go c id 16484
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 9262 Investigate the Scourge of Darnassus (A)
-- .go c id 16495
-- done

-- 9263 Investigate the Scourge of Orgrimmar (H)
-- .go c id 16493
-- has 2 circles and countless mobs in front of orgrimmar, apparently in the wrong spot, does not match quest poi
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 9264 Investigate the Scourge of Thunder Bluff
-- .go c id 16490
-- done

-- 9265 Investigate the Scourge of the Undercity (H)
-- .go c id 16494
-- done

-- 12816 Investigate the Scourge of Silvermoon
-- .go c id 29441
-- missing circle and mobs in front of town
-- missing areatrigger link

-- 12817 Investigate the Scourge of Exodar
-- .go c id 29442
-- missing circle and mobs in front of town
-- missing areatrigger link
