-- DB update 2024_08_08_00 -> 2024_08_13_00
SET
@ETCDMF           = 32, -- Do not change this one
@BLIZZCON         = 47,
@ETCGRIM          = 81,
@ETCSHATT         = 82,
@CGUID            = 12556,
@DOMINOACTIONLIST = 15;

DELETE FROM `game_event` WHERE `eventEntry` IN (@BLIZZCON, @ETCGRIM, @ETCSHATT);
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(@BLIZZCON, '2008-07-31 12:00:00', '2008-08-05 12:00:00', 5184000, 7200, 0, 0, 'BlizzCon 2007',                      0, 2),
(@ETCGRIM,  '2008-01-02 08:00:00', '2030-12-31 06:00:00', 1440,    15,   0, 0, 'L70ETC Grim Guzzler Concert',        0, 2),
(@ETCSHATT, '2008-01-02 01:55:00', '2030-12-31 06:00:00', 240,     15,   0, 0, 'L70ETC World''s End Tavern Concert', 0, 2);

DELETE FROM `creature` WHERE `guid` IN (6090, 7727, 9411, 26009, 34055, @CGUID+00, @CGUID+01, @CGUID+02, @CGUID+03, @CGUID+04, @CGUID+05, @CGUID+06, @CGUID+07, @CGUID+08, @CGUID+09, @CGUID+10, @CGUID+11, @CGUID+12, @CGUID+13, @CGUID+14, @CGUID+15, @CGUID+16, @CGUID+17, @CGUID+18, @CGUID+19, @CGUID+20, @CGUID+21, @CGUID+22) AND `id1` IN (23619, 23623, 23624, 23625, 23626, 23830, 23845, 23850, 23852, 23853, 23854, 23855, 28206, 28209, 28210);
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`, `CreateObject`) VALUES
-- Grim Guzzler
(@CGUID+00, 23830, 230, 0, 0, 1, 1, 0, 846.56536865234375,  -178.953567504882812, -49.6704864501953125, 2.076941728591918945, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+01, 23845, 230, 0, 0, 1, 1, 0, 851.30133056640625,  -177.158447265625,    -49.6711578369140625, 2.146754980087280273, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+02, 23850, 230, 0, 0, 1, 1, 0, 846.04388427734375,  -177.730331420898437, -49.6703681945800781, 2.111848354339599609, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+03, 23852, 230, 0, 0, 1, 1, 0, 842.71783447265625,  -181.561279296875,    -49.6699752807617187, 1.93731546401977539,  7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+04, 23853, 230, 0, 0, 1, 1, 0, 847.64453125,        -175.845840454101562, -49.6705551147460937, 2.076941728591918945, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+05, 23854, 230, 0, 0, 1, 1, 0, 843.40618896484375,  -178.132888793945312, -49.6699714660644531, 2.042035102844238281, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+06, 23855, 230, 0, 0, 1, 1, 0, 847.55419921875,     -180.630538940429687, -49.6706924438476562, 2.042035102844238281, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+07, 28206, 230, 0, 0, 1, 1, 0, 847.82305908203125,  -181.144210815429687, -49.670745849609375,  1.850049018859863281, 7200, 0, 0, 42,   0, 0, 0, 0, 0, 50664, 2),
(@CGUID+08, 28209, 230, 0, 0, 1, 1, 0, 849.4901123046875,   -179.31683349609375,  -49.6709518432617187, 4.101523876190185546, 7200, 0, 0, 2215, 0, 0, 0, 0, 0, 50664, 2),
(@CGUID+09, 28210, 230, 0, 0, 1, 1, 0, 845.8807373046875,   -182.202728271484375, -49.6704788208007812, 1.186823844909667968, 7200, 0, 0, 2215, 0, 0, 0, 0, 0, 50664, 2),
-- World's End Tavern
(@CGUID+10, 23830, 530, 0, 0, 1, 1, 0, -1750.517578125,     5136.13525390625,     -36.1779632568359375, 2.076941728591918945, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 47966, 2),
(@CGUID+11, 23845, 530, 0, 0, 1, 1, 0, -1745.3955078125,    5136.41455078125,     -36.1779708862304687, 2.0245819091796875,   7200, 0, 0, 4120, 0, 0, 0, 0, 0, 47966, 2),
(@CGUID+12, 23850, 530, 0, 0, 1, 1, 0, -1750.7196044921875, 5136.8251953125,      -36.1779594421386718, 2.111848354339599609, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 47966, 2),
(@CGUID+13, 23852, 530, 0, 0, 1, 1, 0, -1754.9766845703125, 5133.36474609375,     -36.1779670715332031, 1.93731546401977539,  7200, 0, 0, 4120, 0, 0, 0, 0, 0, 47966, 2),
(@CGUID+14, 23853, 530, 0, 0, 1, 1, 0, -1749.0806884765625, 5137.7958984375,      -36.1779632568359375, 2.076941728591918945, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 47966, 2),
(@CGUID+15, 23854, 530, 0, 0, 1, 1, 0, -1752.90771484375,   5136.0673828125,      -36.1779708862304687, 2.042035102844238281, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 47966, 2),
(@CGUID+16, 23855, 530, 0, 0, 1, 1, 0, -1749.9208984375,    5134.271484375,       -36.1779632568359375, 2.042035102844238281, 7200, 0, 0, 4120, 0, 0, 0, 0, 0, 47966, 2),
-- BlizzCon spawns
(@CGUID+17, 23845, 530, 0, 0, 1, 1, 0, -2221.88,            5122.5,               -16.52,               6.08419,              7200, 0, 0, 4120, 0, 0, 0, 0, 0, 0,     0),
(@CGUID+18, 23850, 530, 0, 0, 1, 1, 0, -2208.33,            5123.95,              -20.1186,             2.94598,              7200, 0, 0, 4120, 0, 0, 0, 0, 0, 0,     0), -- Move this guy and also the FX controller
(@CGUID+19, 23852, 530, 0, 0, 1, 1, 0, -2220.98,            5130.86,              -16.5221,             6.01916,              7200, 0, 0, 4120, 0, 0, 0, 0, 0, 0,     0),
(@CGUID+20, 23853, 530, 0, 0, 1, 1, 0, -2219.26,            5124.72,              -16.5406,             6.08812,              7200, 0, 0, 4120, 0, 0, 0, 0, 0, 0,     0),
(@CGUID+21, 23854, 530, 0, 0, 1, 1, 0, -2220.87,            5128.07,              -16.5431,             6.07022,              7200, 0, 0, 4120, 0, 0, 0, 0, 0, 0,     0),
(@CGUID+22, 23855, 530, 0, 0, 1, 1, 0, -2226.86,            5127.81,              -12.9949,             5.91769,              7200, 0, 0, 4120, 0, 0, 0, 0, 0, 0,     0);

DELETE FROM `gameobject` WHERE `id` = 186312;

DELETE FROM `game_event_creature` WHERE `eventEntry` IN (@BLIZZCON, @ETCDMF) AND `guid` IN (6090, 7727, 9411, 26009, 34055, 38214, 39821, 39822, 39883, 39884, @CGUID+17, @CGUID+18, @CGUID+19, @CGUID+20, @CGUID+21, @CGUID+22);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@BLIZZCON, 38214), -- FX Controller
(@BLIZZCON, @CGUID+17), -- Bergrisst Controller
(@BLIZZCON, @CGUID+18), -- Concert Controller
(@BLIZZCON, @CGUID+19), -- Mai'kyl Controller
(@BLIZZCON, @CGUID+20), -- Samuro Controller
(@BLIZZCON, @CGUID+21), -- Sig Controller
(@BLIZZCON, @CGUID+22), -- Chief Thunder-Skins Controller
(@BLIZZCON, 39821), -- Concert Bruiser
(@BLIZZCON, 39822), -- Concert Bruiser
(@BLIZZCON, 39883), -- Concert Bruiser
(@BLIZZCON, 39884); -- Concert Bruiser

DELETE FROM `game_event_gameobject` WHERE `eventEntry` IN (@BLIZZCON, @ETCDMF) AND `guid` IN (3110, 29801, 29806);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(@BLIZZCON, 3110), -- Stage
(@BLIZZCON, 29801), -- Bleachers
(@BLIZZCON, 29806); -- Bleachers

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (23845, 23850, 23852, 23853, 23854, 23855, 25148, 25149, 25150, 25151, 25152, 28206, 28209, 28210);
UPDATE `gameobject_template` SET `ScriptName` = 'go_l70_etc_music' WHERE `entry` = 186312;

DELETE FROM `creature_template_addon` WHERE `entry` = 28206;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(28206, 0, 0, 0, 0, 0, 0, 28782);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (9666, 9667);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9666, 0, 0, 'But I drove my mole machine all the way down here...', 27600, 1, 1, 9667, 0, 0, 0, '', 0, 50664),
(9667, 0, 0, 'I\'m ready.',                                          27602, 1, 1, 0,    0, 0, 0, '', 0, 50664);

DELETE FROM `creature_text` WHERE `CreatureID` = 28210;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28210, 0, 0, 'Let\'s wrap it up, Miz. They\'ll be here in a second.', 12, 0, 100, 0, 0, 0, 27603, 0, 'Ognip Blastbolt');

/*
sai design doc
on event start concert controller calls domino action list (blizzcon/brd)
on blastbolt gossip select concert controller calls domino action list (brd)
on event start shattrath saul calls drumset spawn action list and walks around heralding etc concert (shattrath)
    on certain point reached or timer, shattrath saul calls domino action list
domino action list calls action lists for each subcontroller, fx and members
    also sets up a couple spawns/despawns
fx controller sets up casts
member controllers set up casts and summons

some events need conditions, specifically drumset related ones as they vary by location

members themselves get timed actionlists that repeat? must check timers
    emotes are not consistently timed, deviation up to 10s indicates range, not strictly timed
members also need to cast pumped up spell on invoker for emote

crew mates play emote 133 and stop at a range of (maybe) 5-15s repeatedly while at drumset
*/

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (23619, 23623, 23624, 23625, 23626)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23619, 0, 0, 0, 1,  0, 100, 0, 10000, 25000, 10000, 25000, 0, 80, 2361900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Out of Combat - Run Script'),
(23619, 0, 1, 0, 22, 0, 100, 0, 21,    0,     0,     0,     0, 11, 42741,   0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 21 - Cast \'Pumped Up!\''),
(23623, 0, 0, 0, 1,  0, 100, 0, 10000, 25000, 10000, 25000, 0, 80, 2362300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Out of Combat - Run Script'),
(23623, 0, 1, 0, 22, 0, 100, 0, 21,    0,     0,     0,     0, 11, 42741,   0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 21 - Cast \'Pumped Up!\''),
(23624, 0, 0, 0, 1,  0, 100, 0, 10000, 25000, 10000, 25000, 0, 80, 2362400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai''Kyl - Out of Combat - Run Script'),
(23624, 0, 1, 0, 22, 0, 100, 0, 21,    0,     0,     0,     0, 11, 42741,   0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai''Kyl - Received Emote 21 - Cast \'Pumped Up!\''),
(23625, 0, 0, 0, 1,  0, 100, 0, 10000, 25000, 10000, 25000, 0, 80, 2362500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Out of Combat - Run Script'),
(23625, 0, 1, 0, 22, 0, 100, 0, 21,    0,     0,     0,     0, 11, 42741,   0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 21 - Cast \'Pumped Up!\''),
(23626, 0, 0, 0, 1,  0, 100, 0, 10000, 25000, 10000, 25000, 0, 80, 2362600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Out of Combat - Run Script'),
(23626, 0, 1, 0, 22, 0, 100, 0, 21,    0,     0,     0,     0, 11, 42741,   0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 21 - Cast \'Pumped Up!\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2361900) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2361900, 9, 0, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Actionlist - Play Emote 402'),
(2361900, 9, 1, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Actionlist - Play Emote 403'),
(2361900, 9, 2, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Actionlist - Play Emote 404'),
(2361900, 9, 3, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Actionlist - Play Emote 405');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2362300) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2362300, 9, 0, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Actionlist - Play Emote 402'),
(2362300, 9, 1, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Actionlist - Play Emote 403'),
(2362300, 9, 2, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Actionlist - Play Emote 404'),
(2362300, 9, 3, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Actionlist - Play Emote 405');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2362400) AND (`source_type` = 9) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2362400, 9, 0, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai''Kyl - Actionlist - Play Emote 402'),
(2362400, 9, 1, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai''Kyl - Actionlist - Play Emote 403'),
(2362400, 9, 2, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai''Kyl - Actionlist - Play Emote 404');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2362500) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2362500, 9, 0, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Actionlist - Play Emote 402'),
(2362500, 9, 1, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Actionlist - Play Emote 403'),
(2362500, 9, 2, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Actionlist - Play Emote 404'),
(2362500, 9, 3, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Actionlist - Play Emote 405'),
(2362500, 9, 4, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Actionlist - Play Emote 406'),
(2362500, 9, 5, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Actionlist - Play Emote 407');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2362600) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2362600, 9, 0, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Actionlist - Play Emote 402'),
(2362600, 9, 1, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Actionlist - Play Emote 403'),
(2362600, 9, 2, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Actionlist - Play Emote 404'),
(2362600, 9, 3, 0, 0, 0, 100, 0, 10000, 25000, 0, 0, 0, 5, 405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Actionlist - Play Emote 405');

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (23850, 2385000, 2385001)) AND (`source_type` IN (0, 9)) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23850,   0, 0, 0, 68, 0, 100, 0, @ETCDMF,  0,      0, 0, 0, 80, 2385000, 0, 1, 0, 0, 0, 1,  0,      0,     0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - On Game Event 32 Started - Run Script'),
(23850,   0, 1, 0, 68, 0, 100, 0, @ETCGRIM, 0,      0, 0, 0, 80, 2385000, 0, 1, 0, 0, 0, 1,  0,      0,     0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - On Game Event 81 Started - Run Script'),
(2385000, 9, 0, 0, 0,  0, 100, 0, 0,        0,      0, 0, 0, 50, 186312,  0, 0, 0, 0, 0, 1,  0,      0,     0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Summon Gameobject \'L70ETC Music Doodad\''),
(2385000, 9, 1, 0, 0,  0, 100, 0, 10,       10,     0, 0, 0, 80, 2383000, 0, 1, 0, 0, 0, 11, 23830,  21,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Run Script'),
(2385000, 9, 2, 0, 0,  0, 100, 0, 0,        0,      0, 0, 0, 80, 2385300, 0, 1, 0, 0, 0, 11, 23853,  21,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Run Script'),
(2385000, 9, 3, 0, 0,  0, 100, 0, 3221,     3221,   0, 0, 0, 80, 2385200, 0, 1, 0, 0, 0, 11, 23852,  21,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Run Script'),
(2385000, 9, 4, 0, 0,  0, 100, 0, 0,        0,      0, 0, 0, 80, 2385400, 0, 1, 0, 0, 0, 11, 23854,  21,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Run Script'),
(2385000, 9, 5, 0, 0,  0, 100, 0, 11343,    11343,  0, 0, 0, 80, 2385500, 0, 1, 0, 0, 0, 11, 23855,  21,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Run Script'),
(2385000, 9, 6, 0, 0,  0, 100, 0, 3241,     3241,   0, 0, 0, 80, 2384500, 0, 1, 0, 0, 0, 11, 23845,  21,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Run Script'),
(2385000, 9, 7, 0, 0,  0, 100, 0, 0,        0,      0, 0, 0, 41, 0,       0, 0, 0, 0, 0, 11, 28206,  10,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Despawn Instant'),
(2385000, 9, 8, 0, 0,  0, 100, 0, 253803,   253803, 0, 0, 0, 70, 0,       0, 0, 0, 0, 0, 10, 12563,  28206, 0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Respawn Closest Creature \'[DND] L70ETC Drums\''),
(2385000, 9, 9, 0, 0,  0, 100, 0, 2000,     2000,   0, 0, 0, 41, 0,       0, 0, 0, 0, 0, 15, 186312, 10,    0, 0, 0,          0,        0,          0,                    '[DNT] L70ETC Concert Controller - Actionlist - Despawn Instant'),
(2385001, 9, 0, 0, 0,  0, 100, 0, 0,        0,      0, 0, 0, 12, 28206,   7, 0, 0, 0, 0, 8,  0,      0,     0, 0, -1749.8168, 5134.219, -36.177956, 1.884955525398254394, '[DNT] L70ETC Concert Controller - Actionlist - Summon Creature'); -- Ran by Shattrath Saul

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (23830, 2383000)) AND (`source_type` IN (0, 9)) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2383000, 9, 0,  0, 0, 0, 100, 0, 0,     0,     0, 0, 0, 11, 42500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Lightning Cloud\''), -- to-do: condense these down into an actionlist of the three spells and five timed calls of said actionlist
(2383000, 9, 1,  0, 0, 0, 100, 0, 3221,  3221,  0, 0, 0, 11, 50934, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Earthquake SMALLER\''),
(2383000, 9, 2,  0, 0, 0, 100, 0, 3252,  3252,  0, 0, 0, 11, 42501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Rain of Fire\''),
(2383000, 9, 3,  0, 0, 0, 100, 0, 66294, 66294, 0, 0, 0, 11, 42500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Lightning Cloud\''),
(2383000, 9, 4,  0, 0, 0, 100, 0, 3227,  3227,  0, 0, 0, 11, 50934, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Earthquake SMALLER\''),
(2383000, 9, 5,  0, 0, 0, 100, 0, 3228,  3228,  0, 0, 0, 11, 42501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Rain of Fire\''),
(2383000, 9, 6,  0, 0, 0, 100, 0, 46860, 46860, 0, 0, 0, 11, 42500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Lightning Cloud\''),
(2383000, 9, 7,  0, 0, 0, 100, 0, 3222,  3222,  0, 0, 0, 11, 50934, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Earthquake SMALLER\''),
(2383000, 9, 8,  0, 0, 0, 100, 0, 3233,  3233,  0, 0, 0, 11, 42501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Rain of Fire\''),
(2383000, 9, 9,  0, 0, 0, 100, 0, 97028, 97028, 0, 0, 0, 11, 42500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Lightning Cloud\''),
(2383000, 9, 10, 0, 0, 0, 100, 0, 3225,  3225,  0, 0, 0, 11, 50934, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Earthquake SMALLER\''),
(2383000, 9, 11, 0, 0, 0, 100, 0, 3240,  3240,  0, 0, 0, 11, 42501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Rain of Fire\''),
(2383000, 9, 12, 0, 0, 0, 100, 0, 8081,  8081,  0, 0, 0, 11, 42500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Lightning Cloud\''),
(2383000, 9, 13, 0, 0, 0, 100, 0, 3231,  3240,  0, 0, 0, 11, 50934, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Earthquake SMALLER\''),
(2383000, 9, 14, 0, 0, 0, 100, 0, 3240,  3240,  0, 0, 0, 11, 42501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC FX Controller - Actionlist - Cast \'L70ETC Rain of Fire\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2384500) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2384500, 9, 0, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Bergrisst Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2384500, 9, 1, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 12, 23619, 1, 300000, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Bergrisst Controller - Actionlist - Summon Creature \'Bergrisst\''),
(2384500, 9, 2, 0, 0, 0, 100, 0, 124000, 124000, 0, 0, 0, 11, 25824, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Bergrisst Controller - Actionlist - Cast \'Spotlight\''),
(2384500, 9, 3, 0, 0, 0, 100, 0, 64000,  64000,  0, 0, 0, 28, 25824, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Bergrisst Controller - Actionlist - Remove Aura \'Spotlight\''),
(2384500, 9, 4, 0, 0, 0, 100, 0, 64000,  64000,  0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Bergrisst Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2384500, 9, 5, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 41, 0,     0, 0,      0, 0, 0, 11, 23619, 3, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Bergrisst Controller - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2385200) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2385200, 9, 0, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Mai\'Kyl Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385200, 9, 1, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 12, 23624, 1, 300000, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Mai\'Kyl Controller - Actionlist - Summon Creature \'Mai\'Kyl\''),
(2385200, 9, 2, 0, 0, 0, 100, 0, 268387, 268387, 0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Mai\'Kyl Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385200, 9, 3, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 41, 0,     0, 0,      0, 0, 0, 11, 23624, 3, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Mai\'Kyl Controller - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2385300) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2385300, 9, 0, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Samuro Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385300, 9, 1, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 12, 23625, 1, 300000, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Samuro Controller - Actionlist - Summon Creature \'Samuro\''),
(2385300, 9, 2, 0, 0, 0, 100, 0, 114783, 114783, 0, 0, 0, 11, 42510, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Samuro Controller - Actionlist - Cast \'L70ETC Call Lightning\''),
(2385300, 9, 3, 0, 0, 0, 100, 0, 156825, 156825, 0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Samuro Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385300, 9, 4, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 41, 0,     0, 0,      0, 0, 0, 11, 23625, 3, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Samuro Controller - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2385400) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2385400, 9, 0, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Sig Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385400, 9, 1, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 12, 23626, 1, 300000, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Sig Controller - Actionlist - Summon Creature \'Sig Nicious\''),
(2385400, 9, 2, 0, 0, 0, 100, 0, 268387, 268387, 0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Sig Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385400, 9, 3, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 41, 0,     0, 0,      0, 0, 0, 11, 23626, 3, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Sig Controller - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2385500) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2385500, 9, 0, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Chief Thunder-Skins Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385500, 9, 1, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 12, 23623, 1, 300000, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Chief Thunder-Skins Controller - Actionlist - Summon Creature \'Chief Thunder-Skins\''),
(2385500, 9, 2, 0, 0, 0, 100, 0, 257044, 257044, 0, 0, 0, 11, 42505, 0, 0,      0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Chief Thunder-Skins Controller - Actionlist - Cast \'L70ETC Flare Effect\''),
(2385500, 9, 3, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 41, 0,     0, 0,      0, 0, 0, 11, 23623, 3, 0, 0, 0, 0, 0, 0, '[DNT] L70ETC Chief Thunder-Skins Controller - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28210) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28210, 0, 0, 0, 25, 0, 100, 0, 0,    0, 0, 0, 0, 17, 133,     0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, 'Ognip Blastbolt - On Reset - Set Emote State 133'),
(28210, 0, 1, 2, 62, 0, 100, 0, 9667, 0, 0, 0, 0, 72, 0,       0, 0, 0, 0, 0, 7,  0,     0, 0, 0, 0, 0, 0, 0, 'Ognip Blastbolt - On Gossip Option 0 Selected - Close Gossip'),
(28210, 0, 2, 3, 61, 0, 100, 0, 0,    0, 0, 0, 0, 80, 2385000, 0, 0, 0, 0, 0, 11, 23850, 5, 0, 0, 0, 0, 0, 0, 'Ognip Blastbolt - On Gossip Option 0 Selected - Run Script'),
(28210, 0, 3, 4, 61, 0, 100, 0, 0,    0, 0, 0, 0, 1,  0,       0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, 'Ognip Blastbolt - On Gossip Option 0 Selected - Say Line 0'),
(28210, 0, 4, 0, 61, 0, 100, 0, 0,    0, 0, 0, 0, 80, 2821000, 0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, 'Ognip Blastbolt - On Gossip Option 0 Selected - Run Script'),
(28210, 0, 5, 0, 68, 0, 100, 0, 81,   0, 0, 0, 0, 80, 2821000, 0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0, 0, 0, 0, 'Ognip Blastbolt - On Game Event 81 Started - Run Script');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2821000) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2821000, 9, 0, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 80, 2820900, 0, 0, 0, 0, 0, 11, 28209, 5, 0, 0, 0,         0,          0,          0,     'Ognip Blastbolt - Actionlist - Run Script'),
(2821000, 9, 1, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 69, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 846.874,   -186.739,   -49.754395, 0,     'Ognip Blastbolt - Actionlist - Move To Position'),
(2821000, 9, 2, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 83, 1,       0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Ognip Blastbolt - Actionlist - Remove Npc Flags Gossip'),
(2821000, 9, 3, 0, 0, 0, 100, 0, 2500,   2500,   0, 0, 0, 66, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 0,         0,          0,          2.077, 'Ognip Blastbolt - Actionlist - Set Orientation 2.077'),
(2821000, 9, 4, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 17, 423,     0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Ognip Blastbolt - Actionlist - Set Emote State 423'),
(2821000, 9, 5, 0, 0, 0, 100, 0, 270000, 270000, 0, 0, 0, 69, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 845.88074, -182.20273, -49.75489,  0,     'Ognip Blastbolt - Actionlist - Move To Position'),
(2821000, 9, 6, 0, 0, 0, 100, 0, 2500,   2500,   0, 0, 0, 66, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 0,         0,          0,          1.187, 'Ognip Blastbolt - Actionlist - Set Orientation 1.187'),
(2821000, 9, 7, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 82, 1,       0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Ognip Blastbolt - Actionlist - Add Npc Flags Gossip'),
(2821000, 9, 8, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 17, 133,     0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Ognip Blastbolt - Actionlist - Set Emote State 133');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28209) AND (`source_type` = 0) AND (`id` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28209, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 17, 133, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mizli Crankwheel - On Reset - Set Emote State 133');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 2820900) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2820900, 9, 0, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 69, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 853.608,   -182.679,   -49.755253, 0,     'Mizli Crankwheel - Actionlist - Move To Position'),
(2820900, 9, 1, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 83, 1,       0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Mizli Crankwheel - Actionlist - Remove Npc Flags Gossip'),
(2820900, 9, 2, 0, 0, 0, 100, 0, 2500,   2500,   0, 0, 0, 66, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 0,         0,          0,          2.094, 'Mizli Crankwheel - Actionlist - Set Orientation 2.094'),
(2820900, 9, 3, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 17, 423,     0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Mizli Crankwheel - Actionlist - Set Emote State 423'),
(2820900, 9, 4, 0, 0, 0, 100, 0, 270000, 270000, 0, 0, 0, 69, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 849.4901, -179.31683, -49.755436,  0,     'Mizli Crankwheel - Actionlist - Move To Position'),
(2820900, 9, 5, 0, 0, 0, 100, 0, 2500,   2500,   0, 0, 0, 66, 0,       0, 0, 0, 0, 0, 8,  0,     0, 0, 0, 0,         0,          0,          4.102, 'Mizli Crankwheel - Actionlist - Set Orientation 4.102'),
(2820900, 9, 6, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 82, 1,       0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Mizli Crankwheel - Actionlist - Add Npc Flags Gossip'),
(2820900, 9, 7, 0, 0, 0, 100, 0, 0,      0,      0, 0, 0, 17, 133,     0, 0, 0, 0, 0, 1,  0,     0, 0, 0, 0,         0,          0,          0,     'Mizli Crankwheel - Actionlist - Set Emote State 133');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9666 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9666, 0, 0, 0, 2, 0, 37863, 1, 0, 0, 0, 0, '', 'If player does not have \'Direbrew Remote\'s\' in inventory');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (1, 2)) AND (`SourceEntry` = 23850) AND (`SourceId` = 0) AND (`ElseGroup` IN (1, 2)) AND (`ConditionTypeOrReference` IN (23, 29)) AND (`ConditionTarget` = 1) AND (`ConditionValue1` IN (1584, 3519, 23625)) AND (`ConditionValue2` IN (0, 10)) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 23850, 0, 1, 23, 1, 3519,  0,  0, 0, 0, 0, '', 'Object must be in \'Terokkar Forest\''),
(22, 2, 23850, 0, 2, 23, 1, 1584,  0,  0, 0, 0, 0, '', 'Object must be in \'Blackrock Depths\''),
(22, 2, 23850, 0, 2, 29, 1, 23625, 10, 0, 1, 0, 0, '', 'Object must not have creature \'Samuro\' within 10 yards');

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (25148, 25149, 25150, 25151, 25152)) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25148, 0, 0, 0, 22, 0, 100, 0, 21,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 21 - Play Emote 14'),
(25148, 0, 1, 0, 22, 0, 100, 0, 34,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 34 - Play Emote 14'),
(25148, 0, 2, 0, 22, 0, 100, 0, 58,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 58 - Play Emote 14'),
(25148, 0, 3, 0, 22, 0, 100, 0, 77,  0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 77 - Play Emote 11'),
(25148, 0, 4, 0, 22, 0, 100, 0, 78,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 78 - Play Emote 14'),
(25148, 0, 5, 0, 22, 0, 100, 0, 101, 0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 101 - Play Emote 14'),
(25148, 0, 6, 0, 22, 0, 100, 0, 104, 0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 104 - Play Emote 14'),
(25148, 0, 7, 0, 22, 0, 100, 0, 328, 0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bergrisst - Received Emote 328 - Play Emote 14'),
(25149, 0, 0, 0, 22, 0, 100, 0, 21,  0, 0, 0, 0, 5, 4,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 21 - Play Emote 4'),
(25149, 0, 1, 0, 22, 0, 100, 0, 34,  0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 34 - Play Emote 10'),
(25149, 0, 2, 0, 22, 0, 100, 0, 58,  0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 58 - Play Emote 23'),
(25149, 0, 3, 0, 22, 0, 100, 0, 77,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 77 - Play Emote 14'),
(25149, 0, 4, 0, 22, 0, 100, 0, 78,  0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 78 - Play Emote 66'),
(25149, 0, 5, 0, 22, 0, 100, 0, 101, 0, 0, 0, 0, 5, 3,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 101 - Play Emote 3'),
(25149, 0, 6, 0, 22, 0, 100, 0, 104, 0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 104 - Play Emote 23'),
(25149, 0, 7, 0, 22, 0, 100, 0, 328, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Chief Thunder-Skins - Received Emote 328 - Play Emote 11'),
(25150, 0, 0, 0, 22, 0, 100, 0, 21,  0, 0, 0, 0, 5, 4,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 21 - Play Emote 4'),
(25150, 0, 1, 0, 22, 0, 100, 0, 34,  0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 34 - Play Emote 10'),
(25150, 0, 2, 0, 22, 0, 100, 0, 58,  0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 58 - Play Emote 23'),
(25150, 0, 3, 0, 22, 0, 100, 0, 77,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 77 - Play Emote 14'),
(25150, 0, 4, 0, 22, 0, 100, 0, 78,  0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 78 - Play Emote 66'),
(25150, 0, 5, 0, 22, 0, 100, 0, 101, 0, 0, 0, 0, 5, 3,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 101 - Play Emote 3'),
(25150, 0, 6, 0, 22, 0, 100, 0, 104, 0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 104 - Play Emote 23'),
(25150, 0, 7, 0, 22, 0, 100, 0, 328, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mai\'Kyl - Received Emote 328 - Play Emote 11'),
(25151, 0, 0, 0, 22, 0, 100, 0, 21,  0, 0, 0, 0, 5, 4,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 21 - Play Emote 4'),
(25151, 0, 1, 0, 22, 0, 100, 0, 34,  0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 34 - Play Emote 10'),
(25151, 0, 2, 0, 22, 0, 100, 0, 58,  0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 58 - Play Emote 23'),
(25151, 0, 3, 0, 22, 0, 100, 0, 77,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 77 - Play Emote 14'),
(25151, 0, 4, 0, 22, 0, 100, 0, 78,  0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 78 - Play Emote 66'),
(25151, 0, 5, 0, 22, 0, 100, 0, 101, 0, 0, 0, 0, 5, 3,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 101 - Play Emote 3'),
(25151, 0, 6, 0, 22, 0, 100, 0, 104, 0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 104 - Play Emote 23'),
(25151, 0, 7, 0, 22, 0, 100, 0, 328, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Samuro - Received Emote 328 - Play Emote 11'),
(25152, 0, 0, 0, 22, 0, 100, 0, 21,  0, 0, 0, 0, 5, 4,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 21 - Play Emote 4'),
(25152, 0, 1, 0, 22, 0, 100, 0, 34,  0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 34 - Play Emote 10'),
(25152, 0, 2, 0, 22, 0, 100, 0, 58,  0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 58 - Play Emote 23'),
(25152, 0, 3, 0, 22, 0, 100, 0, 77,  0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 77 - Play Emote 14'),
(25152, 0, 4, 0, 22, 0, 100, 0, 78,  0, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 78 - Play Emote 66'),
(25152, 0, 5, 0, 22, 0, 100, 0, 101, 0, 0, 0, 0, 5, 3,  0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 101 - Play Emote 3'),
(25152, 0, 6, 0, 22, 0, 100, 0, 104, 0, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 104 - Play Emote 23'),
(25152, 0, 7, 0, 22, 0, 100, 0, 328, 0, 0, 0, 0, 5, 11, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sig Nicious - Received Emote 328 - Play Emote 11');
