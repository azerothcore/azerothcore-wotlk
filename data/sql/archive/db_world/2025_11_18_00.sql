-- DB update 2025_11_17_04 -> 2025_11_18_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (28732, 28733, 28734));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28732, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 6000, 8000, 0, 0, 11, 52532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Warrior - In Combat - Cast \'Strike\''),
(28732, 0, 1, 0, 0, 0, 100, 0, 2000, 10000, 15000, 15000, 0, 0, 11, 49806, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Warrior - In Combat - Cast \'Cleave\''),
(28733, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2500, 0, 0, 11, 52534, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Shadowcaster - In Combat - Cast \'Shadow Bolt\''),
(28733, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 12000, 20000, 0, 0, 11, 52535, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Shadowcaster - In Combat - Cast \'Shadow Nova\''),
(28734, 0, 0, 0, 67, 0, 100, 0, 7000, 7000, 7000, 7000, 0, 5, 11, 52540, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Skirmisher - On Behind Target - Cast \'Backstab\''),
(28734, 0, 1, 0, 0, 0, 100, 0, 5000, 10000, 15000, 15000, 0, 0, 11, 52536, 0, 0, 0, 0, 0, 5, 40, 0, 0, 0, 0, 0, 0, 0, 'Anub\'ar Skirmisher - In Combat - Cast \'Fixate Trigger\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28729) AND (`source_type` = 0) AND (`id` IN (6));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28730) AND (`source_type` = 0) AND (`id` IN (5));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28731) AND (`source_type` = 0) AND (`id` IN (6));

SET @CGUID := 12758;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+8;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`,`dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 28731, 601, 4277, 4405, 3, 1, 0, 543.82611083984375, 665.12335205078125, 776.24530029296875, 1.553343057632446289, 7200, 0, 0, 11210, 0, 0, 0, 0, 0, 64395), -- 28731 (Area: 4405 - Difficulty: 1) CreateObject1 -- silthik
(@CGUID+1, 28730, 601, 4277, 4405, 3, 1, 0, 526.66357421875, 663.6053466796875, 775.80523681640625, 1.239183783531188964, 7200, 0, 0, 11210, 0, 0, 0, 0, 0, 64395), -- 28730 (Area: 4405 - Difficulty: 1) CreateObject1 gashra
(@CGUID+2, 28729, 601, 4277, 4405, 3, 1,  0, 511.809722900390625, 666.493408203125, 776.27813720703125, 0.977384388446807861, 7200, 0, 0, 11210, 0, 0, 0, 0, 0, 64395), -- 28729 (Area: 4405 - Difficulty: 1) CreateObject1 -- narjil
(@CGUID+3, 28733, 601, 4277, 4405, 3, 1, 0, 549.69268798828125, 662.0069580078125, 776.99273681640625, 1.640609502792358398,7200, 0, 0, 5028, 6525, 0, 0, 0, 0, 64395),
(@CGUID+4, 28734, 601, 4277, 4405, 3, 1, 0, 550.046142578125, 668.1309814453125, 776.2789306640625, 1.65806281566619873, 7200, 0, 0, 6285, 0, 0, 0, 0,  0, 64395),
(@CGUID+5, 28732, 601, 4277, 4405, 3, 1, 0, 531.03082275390625, 658.173095703125, 776.2396240234375, 1.343903541564941406, 7200, 0, 0, 6285, 0, 0, 0, 0, 0, 64395),
(@CGUID+6, 28734, 601, 4277, 4405, 3, 1, 0, 521.81475830078125, 659.4708251953125, 776.3131103515625, 1.186823844909667968, 7200, 0, 0, 6285, 0, 0, 0, 0, 0, 64395),
(@CGUID+7, 28733, 601, 4277, 4405, 3, 1, 0, 506.17828369140625, 669.9266357421875, 776.3056640625, 0.855211317539215087, 7200, 0, 0, 5028, 6525, 0, 0, 0, 0, 64395),
(@CGUID+8, 28732, 601, 4277, 4405, 3, 1, 0, 506.515625, 664.38018798828125, 776.97589111328125, 0.92502450942993164, 7200, 0, 0, 6285, 0, 0, 0, 0, 0, 64395);

-- Prevent combat assist
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|33554432 WHERE `entry` IN (28732, 28733, 28734, 28731, 28730, 28729, 28684, 31612, 31616, 31615, 31617, 31608, 31605, 31606);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (12758, 12759, 12760);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `groupAI`) VALUES
(12758, 12758, 11),
(12758, 12762, 11),
(12758, 12761, 11),

(12759, 12759, 11),
(12759, 12763, 11),
(12759, 12764, 11),

(12760, 12760, 11),
(12760, 12765, 11),
(12760, 12766, 11);
