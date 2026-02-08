--
UPDATE `creature_template` SET `npcflag` = `npcflag`&~3 WHERE (`entry` IN (28070, 31366));

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 9669);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9669, 37476, 0, 'Brann, it would be our honor!', 27614, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 9670);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9670, 36142, 0, 'Let\'s move Brann, enough of the history lesson!', 27616, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 10206);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10206, 36412, 0, 'There will be plenty of time for this later Brann, we need to get moving!', 33002, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = 10012);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(10012, 36236, 0, 'We\'re with you Brann! Open it!', 31547, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- Summon Groups. They have the same position, yes
DELETE FROM `creature_summon_groups` WHERE `summonerId` = 28070 AND `summonerType` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(28070, 0, 0, 27983, 943.0883, 401.3776, 206.16098, 3.804817676544189453, 6, 20000, 'Halls of Stone Tribunal - Dark Rune Protector Group'),
(28070, 0, 0, 27983, 943.0883, 401.3776, 206.16098, 3.804817676544189453, 6, 20000, 'Halls of Stone Tribunal - Dark Rune Protector Group'),
(28070, 0, 0, 27983, 943.0883, 401.3776, 206.16098, 3.804817676544189453, 6, 20000, 'Halls of Stone Tribunal - Dark Rune Protector Group'),
(28070, 0, 1, 27984, 967.0001, 376.83203, 206.16098, 3.804817676544189453, 6, 20000, 'Halls of Stone Tribunal - Dark Rune Stormcaller Group'),
(28070, 0, 1, 27984, 967.0001, 376.83203, 206.16098, 3.804817676544189453, 6, 20000, 'Halls of Stone Tribunal - Dark Rune Stormcaller Group'),
(28070, 0, 2, 27985, 964.302, 381.94174, 206.16098, 3.857177734375, 6, 20000, 'Halls of Stone Tribunal - Golem Custodian Group');

-- CreatureText
DELETE FROM `creature_text` WHERE (`CreatureID` = 28070);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28070, 0, 0, 'Now that\'s earnin\' your supper!', 14, 0, 100, 0, 0, 14244, 30525, 0, 'brann SAY_KILL_1'),
(28070, 0, 1, 'Press on; that\'s the way!', 14, 0, 100, 0, 0, 14245, 30526, 0, 'brann SAY_KILL_2'),
(28070, 0, 2, 'Keep it up now. Plenty of death-dealing for everyone!', 14, 0, 100, 0, 0, 14246, 0, 0, 'brann SAY_KILL_3'),
(28070, 1, 0, 'I\'m all kinds of busted up... might not... make it.', 14, 0, 100, 0, 0, 14257, 28121, 0, 'brann SAY_LOW_HEALTH'),
(28070, 2, 0, 'Not yet... not ye--', 14, 0, 100, 0, 0, 14258, 30522, 0, 'brann SAY_DEATH'),
(28070, 3, 0, 'I\'m doin\' everything I can!', 14, 0, 100, 0, 0, 14260, 30562, 0, 'brann SAY_PLAYER_DEATH_1'),
(28070, 3, 1, 'Light preserve ye!', 14, 0, 100, 0, 0, 14261, 30563, 0, 'brann SAY_PLAYER_DEATH_2'),
(28070, 3, 2, 'I hope this is all worth it!', 14, 0, 100, 0, 0, 14262, 30564, 0, 'brann SAY_PLAYER_DEATH_3'),
(28070, 4, 0, 'Time to get some answers! Let\'s get this show on the road!', 14, 0, 100, 0, 0, 14259, 30561, 0, 'brann SAY_ESCORT_START'),
(28070, 5, 0, 'Don\'t worry! Ol\' Brann\'s got yer back! Keep that metal monstrosity busy, and I\'ll see if I can\'t sweet talk this machine into helping ye!', 14, 0, 100, 0, 0, 14274, 31555, 0, 'brann SAY_SPAWN_DWARF'),
(28070, 6, 0, 'This is a wee bit trickier than before... Oh, bloody--incomin\'!', 14, 0, 100, 0, 0, 14275, 27589, 0, 'brann SAY_SPAWN_TROGG'),
(28070, 7, 0, 'What in the name o\' Madoran did THAT do? Oh! Wait: I just about got it...', 14, 0, 100, 0, 0, 14276, 27590, 0, 'brann SAY_SPAWN_OOZE'),
(28070, 8, 0, 'Ha, that did it! Help\'s a-comin\'! Take this, ya glowin\' iron brute!', 14, 0, 100, 0, 0, 14277, 27591, 0, 'brann SAY_SPAWN_EARTHEN'),
(28070, 9, 0, 'Take a moment and relish this with me. Soon... all will be revealed. Okay then, let\'s do this!', 14, 0, 100, 4, 0, 14247, 30523, 0, 'brann SAY_EVENT_INTRO_1'),
(28070, 10, 0, 'Now keep an eye out! I\'ll have this licked in two shakes of a--', 14, 0, 100, 432, 0, 14248, 30552, 0, 'brann SAY_EVENT_INTRO_2'),
(28070, 11, 0, 'Oh, that doesn\'t sound good. We might have a complication or two...', 14, 0, 100, 1, 0, 14249, 30553, 0, 'brann SAY_EVENT_A_1'),
(28070, 12, 0, 'Ah, you want to play hardball, eh? That\'s just my game!', 14, 0, 100, 0, 0, 14250, 30554, 0, 'brann SAY_EVENT_A_3'),
(28070, 13, 0, 'Couple more minutes and I\'ll--', 14, 0, 100, 0, 0, 14251, 30555, 0, 'brann SAY_EVENT_B_1'),
(28070, 14, 0, 'Heightened? What\'s the good news?', 14, 0, 100, 0, 0, 14252, 30556, 0, 'brann SAY_EVENT_B_3'),
(28070, 15, 0, 'So that was the problem? Now I\'m makin\' progress...', 14, 0, 100, 0, 0, 14253, 30557, 0, 'brann SAY_EVENT_C_1'),
(28070, 16, 0, 'Hang on! Nobody\'s gonna\' be sanitized as long as I have a say in it!', 14, 0, 100, 0, 0, 14254, 30558, 0, 'brann SAY_EVENT_C_3'),
(28070, 17, 0, 'Ha! The old magic fingers finally won through! Now let\'s get down to--', 14, 0, 100, 0, 0, 14255, 30559, 0, 'brann SAY_EVENT_D_1'),
(28070, 18, 0, 'Purge? No no no no no.. where did I-- Aha, this should do the trick...', 14, 0, 100, 0, 0, 14256, 30560, 0, 'brann SAY_EVENT_D_3'),
(28070, 19, 0, 'Query? What do you think I\'m here for, tea and biscuits? Spill the beans already!', 14, 0, 100, 0, 0, 14263, 30565, 0, 'brann SAY_EVENT_END_01'),
(28070, 20, 0, 'Tell me how the dwarves came to be, and start at the beginning!', 14, 0, 100, 0, 0, 14264, 30566, 0, 'brann SAY_EVENT_END_02'),
(28070, 21, 0, 'Right, right... I know the earthen were made from stone to shape the deep regions o\' the world. But what about the anomalies? Matrix non-stabilizin\' and what-not?', 14, 0, 100, 0, 0, 14265, 30567, 0, 'brann SAY_EVENT_END_04'),
(28070, 22, 0, 'Necrowhatinthe-- Speak bloody Common, will ye?', 14, 0, 100, 0, 0, 14266, 30568, 0, 'brann SAY_EVENT_END_06'),
(28070, 23, 0, 'Old Gods, huh? So they zapped the earthen with this Curse of Flesh... and then what?', 14, 0, 100, 0, 0, 14267, 30577, 0, 'brann SAY_EVENT_END_08'),
(28070, 24, 0, 'If they killed the Old Gods, Azeroth would\'ve been destroyed...', 14, 0, 100, 0, 0, 14268, 30578, 0, 'brann SAY_EVENT_END_10'),
(28070, 25, 0, 'What protectors?', 14, 0, 100, 0, 0, 14269, 30579, 0, 'brann SAY_EVENT_END_12'),
(28070, 26, 0, 'Aesir and Vanir... Okay, so the Forge o\' Wills started makin\' new earthen... but what happened to the old ones?', 14, 0, 100, 0, 0, 14270, 30580, 0, 'brann SAY_EVENT_END_14'),
(28070, 27, 0, 'Hold everything! The Aesir and Vanir went to war? Why?', 14, 0, 100, 0, 0, 14271, 30581, 0, 'brann SAY_EVENT_END_16'),
(28070, 28, 0, 'This "Loken" sounds like a nasty character. Glad we don\'t have to worry about the likes o\' him anymore. So... if I\'m understandin\' ye right, the original earthen eventually woke up from this stasis, and by that time the destabili-whatever had turned \'em into proper dwarves. Or at least... dwarf ancestors.', 14, 0, 100, 0, 0, 14272, 30582, 0, 'brann SAY_EVENT_END_18'),
(28070, 29, 0, 'Well, now... that\'s a lot to digest. I\'m gonna need some time to take all this in. Thank ye.', 14, 0, 100, 0, 0, 14273, 30583, 0, 'brann SAY_EVENT_END_20'),
(28070, 30, 0, 'Loken?! That\'s downright bothersome... We might\'ve neutralized the iron dwarves, but I\'d lay odds there\'s another machine somewhere else churnin\' out a whole mess o\' these iron vrykul!', 14, 0, 100, 1, 0, 14278, 28591, 0, 'brann SAY_VICTORY_SJONNIR_1'),
(28070, 31, 0, 'I\'ll use the forge to make batches o\' earthen to stand guard... But our greatest challenge still remains: find and stop Loken!', 14, 0, 100, 1, 0, 14279, 30584, 0, 'brann SAY_VICTORY_SJONNIR_2'),
(28070, 32, 0, 'I think it\'s time to see what\'s behind the door near the entrance. I\'m going to sneak over there, nice and quiet. Meet me at the door and I\'ll get us in.', 14, 0, 100, 0, 0, 0, 31660, 0, 'brann SAY_ENTRANCE_MEET');

-- Abedneum (30899) creature_text
DELETE FROM `creature_text` WHERE (`CreatureID` = 30899);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30899, 0, 0, 'Warning: life form pattern not recognized. Archival processing terminated.  Continued interference will result in targeted response.', 14, 0, 100, 0, 0, 13765, 29561, 0, 'abedneum SAY_WARNING'),
(30899, 1, 0, 'Critical threat index. Void analysis diverted. Initiating sanitization protocol.', 14, 0, 100, 0, 0, 13767, 29577, 0, 'abedneum SAY_CRITICAL'),
(30899, 2, 0, 'Alert: security fail-safes deactivated. Beginning memory purge and...', 14, 0, 100, 0, 0, 13768, 29579, 0, 'abedneum SAY_FAILSAFE'),
(30899, 3, 0, 'System online. Life form pattern recognized.  Welcome, Branbronzan.  Query?', 14, 0, 100, 0, 0, 13769, 29580, 0, 'abedneum SAY_ONLINE'),
(30899, 4, 0, 'Accessing prehistoric data... retrieved. In the beginning the earthen were created to--', 14, 0, 100, 0, 0, 13770, 30611, 0, 'abedneum SAY_LORE_1'),
(30899, 5, 0, 'Accessing... In the early stages of it\'s development cycle, Azeroth suffered infection by parasitic necrophotic symbiotes.', 14, 0, 100, 0, 0, 13771, 30612, 0, 'abedneum SAY_LORE_2'),
(30899, 6, 0, 'Designation: Old Gods. Old Gods rendered all systems, including earthen, defenseless in order to facilitate assimilation. This matrix destabilization has been termed the Curse of Flesh. Effects of destabilization increased over time.', 14, 0, 100, 0, 0, 13772, 30613, 0, 'abedneum SAY_LORE_3'),
(30899, 7, 0, 'Acknowledged, Branbronzan. Session terminated.', 14, 0, 100, 0, 0, 13773, 30614, 0, 'abedneum SAY_SESSION_END');

-- Kaddrak (30898) creature_text
DELETE FROM `creature_text` WHERE (`CreatureID` = 30898);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30898, 0, 0, 'Security breach in progress. Analysis of historical archives transferred to lower-priority queue. Countermeasures engaged.', 14, 0, 100, 0, 0, 13756, 29575, 0, 'kaddrak SAY_SECURITY'),
(30898, 1, 0, 'Accessing... Creators arrived to extirpate symbiotic infection. Assessment revealed that Old God infestation had grown malignant. Excising parasites would result in loss of host--', 14, 0, 100, 0, 0, 13757, 30603, 0, 'kaddrak SAY_LORE_1'),
(30898, 2, 0, 'Correct. Creators neutralized parasitic threat and contained it within the host. Forge of Wills and other systems were instituted to create new earthen. Safeguards were implemented, and protectors were appointed.', 14, 0, 100, 0, 0, 13758, 30604, 0, 'kaddrak SAY_LORE_2'),
(30898, 3, 0, 'Designations: Aesir and Vanir. Or in the common nomenclature, storm and earth giants. Sentinel Loken designated supreme. Dragon Aspects appointed to monitor evolution on Azeroth.', 14, 0, 100, 0, 0, 13759, 30605, 0, 'kaddrak SAY_LORE_3');

-- Marnak (30897) creature_text
DELETE FROM `creature_text` WHERE (`CreatureID` = 30897);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30897, 0, 0, 'Threat index threshold exceeded.  Celestial archive aborted. Security level heightened.', 14, 0, 100, 0, 0, 13761, 29576, 0, 'marnak SAY_THREAT'),
(30897, 1, 0, 'Additional background is relevant to your query: following global combat between Aesir and Vanir--', 14, 0, 100, 0, 0, 13762, 30606, 0, 'marnak SAY_LORE_1'),
(30897, 2, 0, 'Unknown. Data suggests that impetus for global combat originated with prime designate Loken, who neutralized all remaining Aesir and Vanir, affecting termination of conflict. Prime designate Loken then initiated stasis of several seed races, including earthen, giants and vrykul, at designated holding facilities.', 14, 0, 100, 0, 0, 13763, 30607, 0, 'marnak SAY_LORE_2'),
(30897, 3, 0, 'Essentially that is correct.', 14, 0, 100, 0, 0, 13764, 30608, 0, 'marnak SAY_LORE_3');

DELETE FROM `waypoint_data` WHERE `id` IN (280701, 280702);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
-- Escort
(280701, 1 , 1062.9545, 475.52713, 207.73082, NULL, 1),
(280701, 2 , 1051.7512, 474.38412, 208.46428, NULL, 1),
(280701, 3 , 1038.5206, 470.5408, 207.74431 , NULL, 1),
(280701, 4 , 1025.4148, 461.32217, 207.71443, NULL, 1),
(280701, 5 , 1013.8148, 450.56674, 207.71445, NULL, 1),
(280701, 6 , 998.8864, 437.2246, 207.36806  , NULL, 1),
(280701, 7 , 988.21234, 424.72006, 207.41689, NULL, 1),
(280701, 8 , 981.52594, 420.01965, 205.98004, NULL, 1),
(280701, 9 , 973.29675, 421.35568, 205.98004, NULL, 1),
(280701, 10, 961.14746, 421.33258, 205.98004, NULL, 1),
(280701, 11, 951.749, 416.0841, 205.98004   , NULL, 1),
(280701, 12, 944.52466, 406.57574, 205.98004, NULL, 1),
(280701, 13, 945.35394, 395.39194, 205.98003, NULL, 1),
(280701, 14, 946.6389, 386.1174, 205.98001  , NULL, 1),
(280701, 15, 939.6467, 375.48926, 207.41608 , NULL, 1),
-- Fight Start
(280702, 1, 1304.24, 667.208, 189.5993, NULL, 1),
(280702, 2, 1308.33, 666.755, 189.5994, NULL, 1);

/* Points
-- Tribunal Start
-- Cast 51810
X: 897.1759 Y: 331.77386 Z: 203.70638

-- Tribunal End
X: 917.253 Y: 351.925 Z: 203.69878, 3.926990747451782226

-- Tribunal End 2
-- Cast Stealth
X: 935.955 Y: 371.031 Z: 207.41751
-- Despawn

-- Sjonnir Door
X: 1202.91 Y: 667.049 Z: 196.23315
-- EmoteState: 69 for 3200ms
-- Wait 2400ms
X: 1256.33 Y: 667.028 Z: 189.59921
-- EmoteState: 27

-- Sjonnir Dead
-- FaceDirection 3.147235631942749023
-- Loken!? That's downright... 12500ms
-- I'll use this forge... 1000ms
X: 1308.33 Y: 666.755 Z: 189.5994, 0.104719758033752441
*/

/*
Event Start:
14:20:06.371
Now keep an eye out! I'll have this licked in two shakes of a--
14:20:18.878
Warning: life form pattern not recognized. Archival processing terminated.  Continued interference will result in targeted response.
14:20:29.819
Oh, that doesn't sound good. We might have a complication or two...
14:20:35.856
Text: Security breach in progress. Analysis of historical archives transferred to lower-priority queue.
14:20:47.788
Ah, you want to play hardball, eh? That's just my game!
Phase 1 Spawning starts
14:21:48.470
Text: Couple more minutes and I'll--
14:21:50.655
Text: Threat index threshold exceeded.  Celestial archive aborted. Security level heightened.
Phase 2 Spawning Starts
14:21:59.128
Text: Heightened? What's the good news?
14:23:28.157
Text: So that was the problem? Now I'm makin' progress...
14:23:33.052
Text: Critical threat index. Void analysis diverted. Initiating sanitization protocol.
14:23:40.306
Text: Hang on! Nobody's gonna' be sanitized as long as I have a say in it!
14:25:10.994
Text: Ha! The old magic fingers finally won through! Now let's get down to--
14:25:15.869
Text: Alert: security fail-safes deactivated. Beginning memory purge and... 
14:25:21.926
Text: Purge? No no no no no.. where did I-- Aha, this should do the trick...
14:25:28.009
Event Finished, Boss Complete, move to point, release chest.
Text: System online. Life form pattern recognized.  Welcome, Branbronzan.  Query?
14:25:36.496
Text: Query? What do you think I'm here for, tea and biscuits? Spill the beans already!
14:25:42.540
Text: Tell me how the dwarves came to be, and start at the beginning!
14:25:47.391
Text: Accessing prehistoric data... retrieved. In the beginning the earthen were created to--
14:25:54.665
Text: Right, right... I know the earthen were made from stone to shape the deep regions o' the world. But what about the anomalies? Matrix non-stabilizin' and what-not?
14:26:06.783
Text: Accessing... In the early stages of it's development cycle, Azeroth suffered infection by parasitic necrophotic symbiotes.
14:26:18.894
Text: Necrowhatinthe-- Speak bloody Common, will ye?
14:26:23.755
Text: Designation: Old Gods. Old Gods rendered all systems, including earthen, defenseless in order to facilitate assimilation. This matrix destabilization has been termed "the Curse of Flesh". Effects of destabilization increased over time.
14:26:46.770
Text: Old Gods, huh? So they zapped the earthen with this Curse of Flesh... and then what?
14:26:54.057
Text: Accessing... Creators arrived to extirpate symbiotic infection. Assessment revealed that Old God infestation had grown malignant. Excising parasites would result in loss of host--
14:27:12.637
Text: If they killed the Old Gods, Azeroth would've been destroyed...
14:27:18.683
Text: Correct. Creators neutralized parasitic threat and contained it within the host. Forge of Wills and other systems were instituted to create new earthen. Safeguards were implemented, and protectors were appointed.
14:27:37.675
Text: What protectors?
14:27:40.504
Text: Designations: Aesir and Vanir. Or in the common nomenclature, storm and earth giants. Sentinel Loken designated supreme. Dragon Aspects appointed to monitor evolution on Azeroth.
14:27:59.484
Text: Aesir and Vanir... Okay, so the Forge o' Wills started makin' new earthen... but what happened to the old ones?
14:28:10.407
Text: Additional background is relevant to your query: following global combat between Aesir and Vanir--
14:28:16.869
Text: Hold everything! The Aesir and Vanir went to war? Why?
14:28:22.921
Text: Unknown. Data suggests that impetus for global combat originated with prime designate Loken, who neutralized all remaining Aesir and Vanir, affecting termination of conflict. Prime designate Loken then initiated stasis of several seed races, including earthen, giants and vrykul, at designated holding facilities.
14:28:46.756
Text: This "Loken" sounds like a nasty character. Glad we don't have to worry about the likes o' him anymore. So... if I'm understandin' ye right, the original earthen eventually woke up from this stasis, and by that time the destabili-whatever had turned 'em into proper dwarves. Or at least... dwarf ancestors.
14:29:10.194
Text: Essentially that is correct.
14:29:12.204
Text: Well, now... that's a lot to digest. I'm gonna need some time to take all this in. Thank ye.
14:29:20.704
Text: Acknowledged, Branbronzan. Session terminated.

-- Phase 1: Only Protectors + 1 Head
14:20:57.884
Protector Spawn
14:21:28.225
Protector Spawn

-- Phase 2: Protectors and Stormcallers + 2 Heads
14:21:58.529
Protector Spawn
14:22:07.427
Stormcaller Spawn
14:22:28.897
Protector Spawn
14:22:47.511
Stormcaller Spawn
14:22:59.256
Protector Spawn
14:23:27.556 Stormcaller Spawn

-- Phase 3: All + 3 Heads
14:23:29.580
Protector Spawn
14:23:51.444
Golem Spawn
14:23:59.941
Protector Spawn
14:24:07.642
Stormcaller Spawn
14:24:30.317
Protector Spawn
14:24:37.600
Golem Spawn
14:24:47.726
Stormcaller Spawn
14:25:00.680
Protector Spawn

No More spawns past this point
*/
