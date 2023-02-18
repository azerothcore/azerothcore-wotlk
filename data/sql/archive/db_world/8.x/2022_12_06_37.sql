-- DB update 2022_12_06_36 -> 2022_12_06_37
-- Ratchet Bruiser (3502)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3502) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3502, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 15000, 20000, 0, 11, 38661, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ratchet Bruiser - In Combat - Cast Net'),
(3502, 0, 1, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 214, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ratchet Bruiser - On Death - Send Zone Under Attack');
DELETE FROM `creature_template_addon` WHERE (`entry` = 3502);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(3502, 0, 0, 0, 0, 0, 0, '18950');
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (19470, 19487, 19488, 19489, 19490, 19503, 19504, 19505, 19506); 

-- Booty Bay Bruiser (4624)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4624) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4624, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 15000, 20000, 0, 11, 12024, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Booty Bay Bruiser - In Combat - Cast Net'),
(4624, 0, 1, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 214, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Booty Bay Bruiser - On Death - Send Zone Under Attack');
DELETE FROM `creature_template_addon` WHERE (`entry` = 4624);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(4624, 0, 0, 0, 0, 0, 0, '18950');
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (76, 77, 160, 161, 162, 163, 164, 165, 178, 182, 589, 590, 591, 592, 593, 594, 596, 597, 598, 599, 649, 650, 651, 652, 653, 654, 655, 656, 657, 679, 680, 681, 682, 683, 686, 687, 688, 689, 692, 693, 694, 695, 696, 697, 698, 699, 700, 715, 716, 717, 718, 719, 2164, 2167); 

-- Gadgetzan Bruiser (9460)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 9460) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9460, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 15000, 20000, 0, 11, 38661, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Gadgetzan Bruiser - In Combat - Cast Net'),
(9460, 0, 1, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 214, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gadgetzan Bruiser - On Death - Send Zone Under Attack');
DELETE FROM `creature_template_addon` WHERE (`entry` = 9460);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(9460, 0, 0, 0, 0, 0, 0, '18950');
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (23560, 23561, 23562, 23563, 23564, 23565, 23566, 23567, 23568, 23569, 23570, 23571, 23572, 23573, 23574, 23575, 23576, 23577, 23578, 23579, 23580, 23581, 23582, 23583, 23584, 23585, 23586, 23587, 23588, 23589, 23590, 23591, 23592, 23593, 23594, 23595, 23596, 24664, 24665);

-- Everlook Bruiser (11190)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 11190) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11190, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 15000, 20000, 0, 11, 38661, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Everlook Bruiser - In Combat - Cast Net'),
(11190, 0, 1, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 214, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Everlook Bruiser - On Death - Send Zone Under Attack');
DELETE FROM `creature_template_addon` WHERE (`entry` = 11190);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(11190, 0, 0, 0, 0, 0, 0, '18950');
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (42278, 42279, 42280, 42281, 42282, 42283, 42284, 42285, 42286, 42287, 42288, 42289, 42290, 42291, 42292, 42293, 42294, 42295);

-- Shadowglen Sentinel (12160)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12160) AND (`source_type` = 0);

-- Huntress Skymane (14378)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 14378) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 14378);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (46216);

-- Cenarion Hold Infantry (15184)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15184) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15184, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Aggro - Say Line 0'),
(15184, 0, 1, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 214, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - On Death - Send Zone Under Attack'),
(15184, 0, 2, 0, 0, 0, 100, 0, 3000, 7000, 6000, 12000, 0, 11, 30223, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - In Combat - Cast Cleave'),
(15184, 0, 3, 0, 14, 0, 100, 0, 10000, 10000, 0, 0, 0, 11, 27620, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Cenarion Hold Infantry - Victim Casting - Cast Snap Kick');
DELETE FROM `creature_template_addon` WHERE (`entry` = 15184);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(15184, 0, 0, 0, 0, 0, 0, '18950');
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (42766, 42767, 42768, 42769, 42770, 42771, 42772, 42773, 42774, 42775, 42776, 42777, 42778, 42779, 42780, 42781, 42782, 42783, 42784, 42785, 42868, 42884, 42885, 42886, 42891, 42892, 42895, 42896, 42897, 42898);

-- Arcane Protector (16504)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16504) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16504, 0, 3, 0, 0, 0, 100, 0, 3000, 13000, 21000, 35000, 0, 11, 29840, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Protector - In Combat - Cast Fist of Stone'),
(16504, 0, 4, 0, 0, 0, 100, 512, 4000, 7000, 20500, 20500, 0, 88, 1650400, 1650402, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Protector - In Combat - Run Script Range'),
(16504, 0, 5, 0, 0, 0, 100, 0, 10000, 20000, 15000, 25000, 0, 11, 29857, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Protector - In Combat - Cast Summon Astral Spark');
DELETE FROM `creature_template_addon` WHERE (`entry` = 16504);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(16504, 0, 0, 0, 0, 0, 0, '18950');
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (135684, 135685, 135686, 135687, 135688, 135689, 135690, 135691);

-- Thrallmar Grunt (16580)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16580) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 16580);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (57492, 57494, 57495, 57496, 57502, 57505, 57506, 57509, 57511, 57523, 57527, 57528, 57530, 57531, 57533, 57537, 57538, 57540);

-- Injured Thrallmar Grunt (16590)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16590) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16590, 0, 0, 0, 1, 0, 30, 0, 129000, 129000, 509000, 509000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Thrallmar Grunt - Out of Combat - Say Line 0'),
(16590, 0, 1, 0, 1, 0, 30, 0, 454500, 454500, 454500, 454500, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Thrallmar Grunt - Out of Combat - Say Line 1'),
(16590, 0, 2, 0, 1, 0, 30, 0, 459000, 459000, 459000, 459000, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Thrallmar Grunt - Out of Combat - Say Line 2'),
(16590, 0, 3, 0, 1, 0, 100, 0, 464000, 464000, 464000, 464000, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Thrallmar Grunt - Out of Combat - Say Line 3');
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 16590);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (57565);

-- Thrallmar Peon (16591)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16591) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 16591);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (57567, 57569, 57572, 57574, 57575, 57576, 57578, 57579, 57580);

-- Thrallmar Wolf Rider (16599)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16599) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 16599);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (57591, 57593, 57594, 57595, 57596, 57597);

-- Stone Guard Stok'ton (17493)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17493) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 17493);

-- Caza'rez (17558)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17558) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 17558);

-- Wrathfin Sentry (17727)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17727) AND (`source_type` = 0) AND (`id` IN (3));
DELETE FROM `creature_template_addon` WHERE (`entry` = 17727);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17727, 0, 0, 0, 0, 0, 0, '18950');

-- Coilfang Defender (17958)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17958) AND (`source_type` = 0) AND (`id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17958, 0, 2, 0, 0, 0, 100, 0, 9700, 10900, 22000, 28000, 0, 11, 31554, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Coilfang Defender - In Combat - Cast Spell Reflection');
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 17958);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (79150, 79246, 79274, 79275, 79420, 79421);

-- Arcane Guardian (18103)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18103) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18103, 0, 0, 0, 1, 0, 100, 0, 120000, 120000, 120000, 120000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcane Guardian - Out of Combat - Say Line 0 (No Repeat) (Dungeon)');
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 18103);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (64056, 64058, 64059, 64060);

-- Stonebreaker Peon (19048)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19048) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 19048);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (68351, 68353, 68355, 68356, 68357);

-- Shadowmoon Peon (19355)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19355) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 19355);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (69071);

-- Orgrimmar Peon (19425)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19425) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 19425);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (69482, 69483, 69485, 69486, 69488, 69489);

-- Peon Overseer (19426)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19426) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 19426);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (69491);

-- Injured Grunt (19432)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19432) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 19432);
UPDATE `creature_addon` SET `auras`=18950 WHERE (`guid` IN (69493, 69494, 69496, 69498));

-- Peon Bolgar (19562)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19562) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 19562);

-- Mixie Farshot (19836)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 19836) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 19836);

-- Shadowmoon Eye of Kilrogg (22134)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22134) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 22134);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (77730);

-- Amani Lynx (24043)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24043) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 24043);

-- Sunblade Protector (25507)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25507) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25507, 0, 0, 0, 0, 0, 100, 0, 5800, 6800, 10400, 11400, 0, 11, 46480, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Protector - In Combat - Cast Fel Lightning');
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 25507);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (48394, 48400);

-- 7th Legion Sentinel (27162)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27162) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27162, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 15547, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '7th Legion Sentinel - Out of Combat - Stop Attacking (No Repeat)'),
(27162, 0, 1, 0, 0, 0, 100, 0, 9000, 14000, 17000, 22000, 0, 11, 49481, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, '7th Legion Sentinel - On Aggro - Cast \'Shoot\' (No Repeat)');
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 27162);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (131154, 131155, 131157, 133210, 133215);

-- Nesingwary Game Warden (30737)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30737) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30737, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 214, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - On Death - Send Zone Under Attack'),
(30737, 0, 1, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 0, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - In Combat - Cast Shoot'),
(30737, 0, 2, 0, 9, 0, 100, 0, 0, 20, 9000, 13000, 0, 11, 6533, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - 0-20 Range - Cast Net'),
(30737, 0, 3, 0, 9, 0, 100, 0, 5, 30, 8000, 10000, 0, 11, 31942, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - 5-30 Range - Cast Multi-Shot');
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` = 30737);
UPDATE `creature_addon` SET `auras`=18950 WHERE `guid` IN (97851, 97852, 97853, 97854, 97865, 97866, 97867, 97875, 97876, 97877, 97878, 97879);
