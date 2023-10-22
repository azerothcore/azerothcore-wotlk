-- DB update 2023_03_14_05 -> 2023_03_15_00
--
UPDATE `creature_template` SET `ScriptName` = "npc_chesspiece", `flags_extra`=`flags_extra`|0x01000000 WHERE `entry` IN (17469,17211,21748,21664,21750,21683,21747,21682,21726,21160,21752,21684);
UPDATE `creature_template` SET `ScriptName` = "npc_echo_of_medivh" WHERE `entry`=16816;
UPDATE `creature_template` SET `ScriptName` = "npc_chess_move_trigger", `flags_extra`=130 WHERE `entry`=22519;

DELETE FROM `creature` WHERE `id1`=22519;

DELETE FROM `creature_template_addon` WHERE `entry`=22521;
INSERT INTO `creature_template_addon` (`entry`,`bytes2`,`auras`) VALUES
(22521,1,'39383');

UPDATE `creature_template` SET `flags_extra` = 130 WHERE `entry` = 22521;

DELETE FROM `creature_template_spell` WHERE `CreatureID` IN (21684,21683,21682,21664,21160,17211,21752,21750,21747,21748,21726,17469);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(21684, 0, 37146, 12340), -- King Llane
(21684, 1, 30284, 12340),
(21684, 2, 37471, 12340),
(21684, 3, 37474, 12340),
(21683, 0, 37148, 12340), -- Human Conjurer
(21683, 1, 30284, 12340),
(21683, 2, 37462, 12340),
(21683, 3, 37465, 12340),
(21682, 0, 37146, 12340), -- Human Cleric
(21682, 1, 30284, 12340),
(21682, 2, 37455, 12340),
(21682, 3, 37459, 12340),
(21664, 0, 37144, 12340), -- Human Charger
(21664, 1, 30284, 12340),
(21664, 2, 37453, 12340),
(21664, 3, 37498, 12340),
(21160, 0, 37146, 12340), -- Conjured Water Elemental
(21160, 1, 30284, 12340),
(21160, 2, 37427, 12340),
(21160, 3, 37432, 12340),
(17211, 0, 37146, 12340), -- Human Footman
(17211, 1, 30284, 12340),
(17211, 2, 37406, 12340),
(17211, 3, 37414, 12340),
(21752, 0, 37146, 12340), -- Warchief Blackhand
(21752, 1, 30284, 12340),
(21752, 2, 37472, 12340),
(21752, 3, 37476, 12340),
(21750, 0, 37148, 12340), -- Orc Warlock
(21750, 1, 30284, 12340),
(21750, 2, 37463, 12340),
(21750, 3, 37461, 12340),
(21747, 0, 37146, 12340), -- Orc Necrolyte
(21747, 1, 30284, 12340),
(21747, 2, 37456, 12340),
(21747, 3, 37461, 12340),
(21748, 0, 37144, 12340), -- Orc Wolf
(21748, 1, 30284, 12340),
(21748, 2, 37454, 12340),
(21748, 3, 37502, 12340),
(21726, 0, 37146, 12340), -- Summoned Daemon
(21726, 1, 30284, 12340),
(21726, 2, 37428, 12340),
(21726, 3, 37434, 12340),
(17469, 0, 37146, 12340), -- Orc Grunt
(17469, 1, 30284, 12340),
(17469, 2, 37413, 12340),
(17469, 3, 37416, 12340);
 
UPDATE `creature_template` SET `RegenHealth`=0, `BaseAttackTime`=3000 WHERE `entry` IN (21726,21748,21747,21750,21752,17469,21160,21664,21682,21684,21683,17211);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (37465,37476,30012,37144,37148,37151,37152,37153,37472,37461,37454,37502,37428,37413,37471,37474,37459,37453,37498,37427,37406,39384,37462,37455,37463,37456,37144,37146,37148,30284,37469);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ScriptName`,`Comment`) VALUES
(13,1,37146,0,31,3,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,1,30012,0,31,3,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,1,37144,0,31,3,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,1,37148,0,31,3,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,1,37151,0,31,3,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,1,37152,0,31,3,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),
(13,1,37153,0,31,3,22519,0,'',"Move - Target Chess Piece: Karazhan Invisible Stalker"),

(13,3,30284,0,31,3,22519,0,'',"Change Facing - Target Chess Piece: Karazhan Invisible Stalker"),

(13,1,39384,0,31,3,21752,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,1,39384,1,31,3,21750,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,1,39384,2,31,3,21747,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,1,39384,3,31,3,21748,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,1,39384,4,31,3,21726,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,1,39384,5,31,3,17469,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,2,39384,0,31,3,21683,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,2,39384,1,31,3,21684,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,2,39384,2,31,3,21682,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,2,39384,3,31,3,21664,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,2,39384,4,31,3,21160,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),
(13,2,39384,5,31,3,17211,0,'',"Alliance and Horde Chess Spell - Burning Flames - Target Alliance and Horde Pieces"),

(13,1,37471,0,31,3,21683,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,1,37471,1,31,3,21684,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,1,37471,2,31,3,21682,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,1,37471,3,31,3,21664,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,1,37471,4,31,3,21160,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),
(13,1,37471,5,31,3,17211,0,'',"Alliance Chess Spell - Heroism - Target Alliance Pieces"),

(13,1,37459,0,31,3,21752,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,1,37459,1,31,3,21750,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,1,37459,2,31,3,21747,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,1,37459,3,31,3,21748,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,1,37459,4,31,3,21726,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),
(13,1,37459,5,31,3,17469,0,'',"Alliance Chess Spell - Holy Lance - Target Horde Pieces"),

(13,1,37453,0,31,3,21752,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,1,37453,1,31,3,21750,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,1,37453,2,31,3,21747,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,1,37453,3,31,3,21748,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,1,37453,4,31,3,21726,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),
(13,1,37453,5,31,3,17469,0,'',"Alliance Chess Spell - Smash - Target Horde Pieces"),

(13,1,37427,0,31,3,21752,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,1,37427,1,31,3,21750,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,1,37427,2,31,3,21747,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,1,37427,3,31,3,21748,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,1,37427,4,31,3,21726,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),
(13,1,37427,5,31,3,17469,0,'',"Alliance Chess Spell - Geyser - Target Horde Pieces"),

(13,1,37474,0,31,3,21752,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,1,37474,1,31,3,21750,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,1,37474,2,31,3,21747,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,1,37474,3,31,3,21748,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,1,37474,4,31,3,21726,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),
(13,1,37474,5,31,3,17469,0,'',"Alliance Chess Spell - Sweep - Target Horde Pieces"),

(13,1,37465,0,31,3,21752,0,'',"Alliance Chess Spell - Rain of Fire - Target Horde Pieces"),
(13,1,37465,1,31,3,21750,0,'',"Alliance Chess Spell - Rain of Fire - Target Horde Pieces"),
(13,1,37465,2,31,3,21747,0,'',"Alliance Chess Spell - Rain of Fire - Target Horde Pieces"),
(13,1,37465,3,31,3,21748,0,'',"Alliance Chess Spell - Rain of Fire - Target Horde Pieces"),
(13,1,37465,4,31,3,21726,0,'',"Alliance Chess Spell - Rain of Fire - Target Horde Pieces"),
(13,1,37465,5,31,3,17469,0,'',"Alliance Chess Spell - Rain of Fire - Target Horde Pieces"),

(13,1,37498,0,31,3,21752,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,1,37498,1,31,3,21750,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,1,37498,2,31,3,21747,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,1,37498,3,31,3,21748,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,1,37498,4,31,3,21726,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),
(13,1,37498,5,31,3,17469,0,'',"Alliance Chess Spell - Stomp - Target Horde Pieces"),

(13,1,37406,0,31,3,21752,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,1,37406,1,31,3,21750,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,1,37406,2,31,3,21747,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,1,37406,3,31,3,21748,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,1,37406,4,31,3,21726,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),
(13,1,37406,5,31,3,17469,0,'',"Alliance Chess Spell - Heroic Blow - Target Horde Pieces"),

(13,1,37472,0,31,3,21752,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,1,37472,1,31,3,21750,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,1,37472,2,31,3,21747,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,1,37472,3,31,3,21748,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,1,37472,4,31,3,21726,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),
(13,1,37472,5,31,3,17469,0,'',"Horde Chess Spell - Bloodlust - Target Horde Pieces"),

(13,1,37461,0,31,3,21683,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,1,37461,1,31,3,21684,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,1,37461,2,31,3,21682,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,1,37461,3,31,3,21664,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,1,37461,4,31,3,21160,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),
(13,1,37461,5,31,3,17211,0,'',"Horde Chess Spell - Shadow Spear - Target Alliance Pieces"),

(13,1,37502,0,31,3,21683,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,1,37502,1,31,3,21684,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,1,37502,2,31,3,21682,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,1,37502,3,31,3,21664,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,1,37502,4,31,3,21160,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),
(13,1,37502,5,31,3,17211,0,'',"Horde Chess Spell - Howl - Target Alliance Pieces"),

(13,1,37428,0,31,3,21683,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,1,37428,1,31,3,21684,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,1,37428,2,31,3,21682,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,1,37428,3,31,3,21664,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,1,37428,4,31,3,21160,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),
(13,1,37428,5,31,3,17211,0,'',"Horde Chess Spell - Hellfire - Target Alliance Pieces"),

(13,1,37476,0,31,3,21683,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,1,37476,1,31,3,21684,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,1,37476,2,31,3,21682,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,1,37476,3,31,3,21664,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,1,37476,4,31,3,21160,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),
(13,1,37476,5,31,3,17211,0,'',"Horde Chess Spell - Cleave - Target Alliance Pieces"),

(13,1,37469,0,31,3,21683,0,'',"Horde Chess Spell - Poison Cloud - Target Alliance Pieces"),
(13,1,37469,1,31,3,21684,0,'',"Horde Chess Spell - Poison Cloud - Target Alliance Pieces"),
(13,1,37469,2,31,3,21682,0,'',"Horde Chess Spell - Poison Cloud - Target Alliance Pieces"),
(13,1,37469,3,31,3,21664,0,'',"Horde Chess Spell - Poison Cloud - Target Alliance Pieces"),
(13,1,37469,4,31,3,21160,0,'',"Horde Chess Spell - Poison Cloud - Target Alliance Pieces"),
(13,1,37469,5,31,3,17211,0,'',"Horde Chess Spell - Poison Cloud - Target Alliance Pieces"),

(13,1,37454,0,31,3,21683,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,1,37454,1,31,3,21684,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,1,37454,2,31,3,21682,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,1,37454,3,31,3,21664,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,1,37454,4,31,3,21160,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),
(13,1,37454,5,31,3,17211,0,'',"Horde Chess Spell - Bite - Target Alliance Pieces"),

(13,1,37413,0,31,3,21683,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,1,37413,1,31,3,21684,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,1,37413,2,31,3,21682,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,1,37413,3,31,3,21664,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,1,37413,4,31,3,21160,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces"),
(13,1,37413,5,31,3,17211,0,'',"Horde Chess Spell - Vicious Strike - Target Alliance Pieces");

DELETE FROM `creature_text` WHERE `CreatureID`=16816;
INSERT INTO `creature_text` VALUES
(16816,0,0,'Very well. Let the game begin.',14,0,100,0,0,10338,0,0,'Echo of Medivh - EventBegin'),
(16816,1,0,'Perhaps a change is in order.',14,0,100,0,0,10357,0,0,'Echo of Medivh - Cheat 1'),
(16816,1,1,'Time for an alternative scenario.',14,0,100,0,0,10358,0,0,'Echo of Medivh - Cheat 2'),
(16816,1,2,'One must not become too complacent.',14,0,100,0,0,10359,0,0,'Echo of Medivh - Cheat 3'),
(16816,2,0,'%s cheats',16,0,100,0,0,0,21910,0,'Echo of Medivh - CheatEmote'),
(16816,3,0,'Let us see.',14,0,100,0,0,10340,0,0,'Echo of Medivh - Player Loose Pawn 1'),
(16816,3,1,'A transparent stratagem.',14,0,100,0,0,10339,0,0,'Echo of Medivh - Player Loose Pawn 2'),
(16816,3,2,'Ah, the wheels have begun to turn.',14,0,100,0,0,10341,0,0,'Echo of Medivh - Player Loose Pawn 3'),
(16816,4,0,'Foolish! Very foolish!',14,0,100,0,0,10345,0,0,'Echo of Medivh - Player Loose Rook'),
(16816,5,0,'Yes... all according to plan.',14,0,100,0,0,10349,0,0,'Echo of Medivh - Player Loose Knight'),
(16816,6,0,'The slightest loss of concentration is all it takes.',14,0,100,0,0,10347,0,0,'Echo of Medivh - Player Loose Bishop'),
(16816,7,0,'Now it gets interesting.',14,0,100,0,0,10351,0,0,'Echo of Medivh - Player Loose Queen'),
(16816,8,0,'As it should be.',14,0,100,0,0,10354,0,0,'Echo of Medivh - Player Loose King'),
(16816,9,0,'Hmm.',14,0,100,0,0,10342,0,0,'Echo of Medivh - Medivh Loose Pawn 1'),
(16816,9,1,'No matter.',14,0,100,0,0,10344,0,0,'Echo of Medivh - Medivh Loose Pawn 2'),
(16816,9,2,'Interesting.',14,0,100,0,0,10343,0,0,'Echo of Medivh - Medivh Loose Pawn 3'),
(16816,10,0,'A minor concern.',14,0,100,0,0,10346,0,0,'Echo of Medivh - Medivh Loose Rook'),
(16816,11,0,'Yes...of course.',14,0,100,0,0,10350,0,0,'Echo of Medivh - Medivh Loose Knight'),
(16816,12,0,'A necessary sacrifice.',14,0,100,0,0,10348,0,0,'Echo of Medivh - Medivh Loose Bishop'),
(16816,13,0,'Ahh, I should have known.',14,0,100,0,0,10352,0,0,'Echo of Medivh - Medivh Loose Queen'),
(16816,14,0,'And so, the end draws near',14,0,100,0,0,10353,0,0,'Echo of Medivh - Medivh Loose King'),
(16816,15,0,'Nothing less than perfection will do.',14,0,100,0,0,10356,0,0,'Echo of Medivh - Checkmate 1'),
(16816,15,1,'And so it ends.',14,0,100,0,0,10355,0,0,'Echo of Medivh - Checkmate 2'),
(16816,16,0,'The halls of Karazhan shake, as the curse binding the doors of the Gamesman\'s Hall is lifted.',16,0,100,0,0,0,20430,0,'Echo of Medivh - Event Ended');

DELETE FROM `gossip_menu_option` WHERE `menuid` IN (8404,7413,8354,8345,8346,8347,8348,8349,8355,8362,8366,8367,8368);
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry` IN (17469,17211,21748,21664,21750,21683,21747,21682,21726,21160,21752,21684);

UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry` IN (17208,17305,17317,17316);

DELETE FROM `spell_script_names` WHERE `spell_id`=30019;
INSERT INTO `spell_script_names` VALUES
(30019,'spell_control_piece');
