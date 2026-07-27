--
-- Quest 11529 "Sorlof's Booty": restore the sniffed cannon chain.
--
-- Clicking The Big Gun used to cast the damage spell itself, instantly, with the
-- clicker as original caster - so Sorlof could be shelled from anywhere on the map by
-- spamming the gun, and the player tagged him and looted his corpse. Sniffs show the
-- click casts the primer, which starts the player's timed Big Gun Assault, which in
-- turn has the gun fire Cannon Assault at Sorlof.
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` = 24992;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(24992, 45045, 3, 0); -- The Big Gun - Big Cannon Assault Primer

-- Resolve the nearby-entry target of Big Gun Assault to the gun the player is manning.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 45013;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 45013, 0, 0, 31, 0, 3, 24992, 0, 0, 0, 0, '', 'Spell Big Gun Assault targets The Big Gun');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (45013, 45045);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45045, 'spell_sorlofs_booty_cannon_primer'),
(45013, 'spell_sorlofs_booty_big_gun_assault');

--
-- Sorlof shadows the Sister Mercy along the shore instead of walking his own loop.
--
-- The ship's stops carry departure events in TaxiPathNode.dbc (path 778), which
-- MotionTransport::DoEventIfAny hands to her GameObjectAI; the script forwards each one
-- to Sorlof as the path he takes to the matching shore position.
UPDATE `gameobject_template` SET `ScriptName` = 'go_sister_mercy' WHERE `entry` = 187038; -- Sister Mercy

-- His movement, boulder assault and death are all script-driven now.
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_sorlof' WHERE `entry` = 24914; -- Sorlof
DELETE FROM `smart_scripts` WHERE `entryorguid` = 24914 AND `source_type` = 0;

-- Sniffed spawn position; the AI walks him from here on the ship's first departure.
UPDATE `creature` SET `position_x` = 97.17545, `position_y` = -4024.8862, `position_z` = 1.5117704, `orientation` = 2.606328010559082031, `MovementType` = 0 WHERE `guid` = 103278; -- Sorlof

-- The boulders land on these: crew triggers dotted over the Sister Mercy's decks and
-- rigging. 44965 has no target cap, so the script picks one of them per throw.
SET @CGUID := 73617;

-- Crew Triggers for Boulder Targets
DELETE FROM `creature` WHERE `id` = 24973 AND `guid` BETWEEN @CGUID+0 AND @CGUID+26;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `CreateObject`, `VerifiedBuild`) VALUES
(@CGUID+0 , 24973, 594, 495, 4077, -20.6305503845214843, 0.87925499677658081, 23.15439796447753906, 2.234021425247192382, 120, 1, 68887),
(@CGUID+1 , 24973, 594, 495, 4077, -26.7290573120117187, 8.964938163757324218, 16.09914779663085937, 1.326450228691101074, 120, 1, 68887),
(@CGUID+2 , 24973, 594, 495, 4077, -28.3763332366943359, 2.132025003433227539, 19.53076934814453125, 2.897246599197387695, 120, 1, 68887),
(@CGUID+3 , 24973, 594, 495, 4077, -16.0938186645507812, 0.273838013410568237, 43.55142974853515625, 4.485496044158935546, 120, 1, 68887),
(@CGUID+4 , 24973, 594, 495, 4077, -18.2567806243896484, 12.23450279235839843, 13.1617746353149414, 4.15388345718383789, 120, 1, 68887),
(@CGUID+5 , 24973, 594, 495, 4077, -21.46112060546875, -0.04458500072360038, 26.67117500305175781, 1.064650893211364746, 120, 1, 68887),
(@CGUID+6 , 24973, 594, 495, 4077, 1.346712946891784667, 13.24960041046142578, 20.16955184936523437, 1.326450228691101074, 120, 1, 68887),
(@CGUID+7 , 24973, 594, 495, 4077, -10.768381118774414, 10.98365497589111328, 11.52657890319824218, 4.590215682983398437, 120, 1, 68887),
(@CGUID+8 , 24973, 594, 495, 4077, 0.120067000389099121, 2.717941045761108398, 9.014368057250976562, 2.827433347702026367, 120, 1, 68887),
(@CGUID+9 , 24973, 594, 495, 4077, -14.4963808059692382, 5.586709022521972656, 19.56297492980957031, 2.652900457382202148, 120, 1, 68887),
(@CGUID+10, 24973, 594, 495, 4077, 2.856342077255249023, 0.252011001110076904, 39.62346649169921875, 2.216568231582641601, 120, 1, 68887),
(@CGUID+11, 24973, 594, 495, 4077, 7.384247779846191406, 4.385578155517578125, 14.35732841491699218, 2.478367567062377929, 120, 1, 68887),
(@CGUID+12, 24973, 594, 495, 4077, -4.44231891632080078, 1.441480040550231933, 30.1070098876953125, 0.104719758033752441, 120, 1, 68887),
(@CGUID+13, 24973, 594, 495, 4077, -0.38327699899673461, 9.437303543090820312, 8.811459541320800781, 4.24114990234375, 120, 1, 68887),
(@CGUID+14, 24973, 594, 495, 4077, -0.61927801370620727, 0.729270994663238525, 15.69870185852050781, 4.712388992309570312, 120, 1, 68887),
(@CGUID+15, 24973, 594, 495, 4077, 2.437870979309082031, 10.67437362670898437, 3.100884199142456054, 5.602506637573242187, 120, 1, 68887),
(@CGUID+16, 24973, 594, 495, 4077, 0.543250977993011474, 0.511954009532928466, 22.23152732849121093, 0.436332315206527709, 120, 1, 68887),
(@CGUID+17, 24973, 594, 495, 4077, 5.890214920043945312, 0.641448020935058593, 56.5892181396484375, 3.228859186172485351, 120, 1, 68887),
(@CGUID+18, 24973, 594, 495, 4077, 2.481215953826904296, -7.58693122863769531, 14.11674880981445312, 2.635447263717651367, 120, 1, 68887),
(@CGUID+19, 24973, 594, 495, 4077, 28.58755874633789062, 7.992822170257568359, 20.73052597045898437, 5.009094715118408203, 120, 1, 68887),
(@CGUID+20, 24973, 594, 495, 4077, 11.99658966064453125, 13.07939910888671875, 10.18214607238769531, 6.230825424194335937, 120, 1, 68887),
(@CGUID+21, 24973, 594, 495, 4077, 21.87375259399414062, 12.49561214447021484, 9.61978912353515625, 3.246312379837036132, 120, 1, 68887),
(@CGUID+22, 24973, 594, 495, 4077, 22.16750526428222656, 1.304870963096618652, 25.48061752319335937, 5.480333805084228515, 120, 1, 68887),
(@CGUID+23, 24973, 594, 495, 4077, 25.33149147033691406, 0.86961299180984497, 46.09729766845703125, 6.213372230529785156, 120, 1, 68887),
(@CGUID+24, 24973, 594, 495, 4077, 32.807464599609375, 3.295629024505615234, 20.36577415466308593, 5.585053443908691406, 120, 1, 68887),
(@CGUID+25, 24973, 594, 495, 4077, 8.728032112121582031, 11.15651130676269531, 3.116890192031860351, 2.39110112190246582, 120, 1, 68887),
(@CGUID+26, 24973, 594, 495, 4077, 20.87360382080078125, 10.74199485778808593, 3.112012147903442382, 4.607669353485107421, 120, 1, 68887);

-- Boulder Assault: 44965 picks a crew trigger inside its 200 yard reach, lands 44966 on
-- it, and 44967 leaves Creeping Flames burning where it struck.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 44965;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 44965, 0, 0, 31, 0, 3, 24973, 0, 0, 0, 0, '', 'Spell Boulder Assault targets Ellis Crew Trigger');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (44965, 44966);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(44965, 'spell_sorlofs_booty_boulder_assault'),
(44966, 'spell_sorlofs_booty_boulder_assault_hit');

-- Serverside Boulder Assault: triggers 44965 at the Ellis Crew Trigger every 3s.
DELETE FROM `creature_addon` WHERE `guid` = 103278;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(103278, 0, 0, 0, 1, 0, 3, '44964'); -- Sorlof

DELETE FROM `waypoint_data` WHERE `id` IN (1032780, 1032781, 1032782, 1032783, 1032784, 1032785);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
-- Pos 1 (spawn)
(1032780, 1, 97.17545, -4024.8862, 1.5117704, NULL),
-- Pos 2
(1032781, 1, 101.15443, -3924.839, 2.2858443, NULL),
(1032781, 2, 92.51937, -3893.2766, 1.7101376, NULL),
(1032781, 3, 113.66331, -3885.0088, 3.9941988, NULL),
-- Pos 3
(1032782, 1, 170.00453, -3834.312, 1.0282993, NULL),
-- Pos 4
(1032783, 1, 234.34787, -3839.6567, 6.5361958, NULL),
(1032783, 2, 260.00797, -3825.02, 4.976329, NULL),
(1032783, 3, 279.02988, -3805.746, 4.17469, NULL),
(1032783, 4, 266.36356, -3775.4158, 3.9740202, NULL),
-- Pos 5
(1032784, 1, 307.11368, -3802.3945, 2.1991935, NULL),
(1032784, 2, 327.66074, -3807.0261, 2.548757, NULL),
(1032784, 3, 356.2998, -3801.8398, 1.4324319, NULL),
(1032784, 4, 390.81516, -3765.8672, 0.9260107, NULL),
-- Return path (inferred - he died at the last position)
(1032785, 1, 356.2998, -3801.8398, 1.4324319, NULL),
(1032785, 2, 327.66074, -3807.0261, 2.548757, NULL),
(1032785, 3, 307.11368, -3802.3945, 2.1991935, NULL),
(1032785, 4, 266.36356, -3775.4158, 3.9740202, NULL),
(1032785, 5, 279.02988, -3805.746, 4.17469, NULL),
(1032785, 6, 260.00797, -3825.02, 4.976329, NULL),
(1032785, 7, 234.34787, -3839.6567, 6.5361958, NULL),
(1032785, 8, 170.00453, -3834.312, 1.0282993, NULL),
(1032785, 9, 113.66331, -3885.0088, 3.9941988, NULL),
(1032785, 10, 92.51937, -3893.2766, 1.7101376, NULL),
(1032785, 11, 101.15443, -3924.839, 2.2858443, NULL),
(1032785, 12, 97.17545, -4024.8862, 1.5117704, NULL);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 24992);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(24992, 0, 0, 1, 1, 0, 0, 0);

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE (`entry` = 23826);
DELETE FROM `creature_template_addon` WHERE (`entry` = 23826);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(23826, 0, 0, 0, 0, 0, 0, '42460');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24911);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24911, 0, 0, 1, 60, 0, 100, 0, 3400, 6200, 3400, 6200, 0, 0, 11, 44961, 64, 0, 0, 0, 0, 10, 103278, 24914, 0, 0, 0, 0, 0, 0, 'Cursed Sea Dog - On Update - Cast \'Shoot\' at Sorlof'),
(24911, 0, 1, 0, 61, 0, 4, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cursed Sea Dog - On Cast \'Shoot\' - Say Line');
