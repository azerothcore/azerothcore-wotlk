-- DB update 2024_09_03_01 -> 2024_09_05_00
DELETE FROM `creature_text` WHERE (`CreatureID` = 23089);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23089, 0, 0, 'This door is all that stands between us and the Betrayer.  Stand aside, friends.', 12, 0, 100, 1, 0, 0, 21563, 0, 'SAY_AKAMA_DOOR'),
(23089, 1, 0, 'I cannot do this alone...', 12, 0, 100, 274, 0, 0, 21548, 0, 'SAY_AKAMA_ALONE'),
(23089, 2, 0, 'I thank you for your aid, brothers.  Our people will be redeemed!', 12, 0, 100, 66, 0, 0, 21554, 0, 'SAY_AKAMA_SALUTE'),
(23089, 3, 0, 'Be wary, friends. The Betrayer meditates in the court just beyond.', 12, 0, 100, 0, 0, 11388, 21555, 0, 'SAY_AKAMA_BETRAYER'),
(23089, 4, 0, 'We\'ve come to end your reign, Illidan. My people, and all of Outland, shall be free!', 14, 0, 100, 25, 0, 11389, 20893, 0, 'SAY_AKAMA_FREE'),
(23089, 5, 0, 'The time has come! The moment is at hand!', 14, 0, 100, 22, 0, 11380, 20894, 0, 'SAY_AKAMA_TIME_HAS_COME'),
(23089, 6, 0, 'I will deal with these mongrels! Strike now, friends! Strike at the Betrayer!', 14, 0, 100, 22, 0, 11390, 21250, 0, 'SAY_AKAMA_MINIONS'),
(23089, 7, 0, 'The Light will bless these dismal halls once again.... I swear it.', 14, 0, 100, 1, 0, 11387, 21514, 0, 'SAY_AKAMA_LIGHT'),
(23089, 8, 0, 'Those who\'ve defiled this temple have all been defeated.  All but one!', 12, 0, 100, 1, 0, 0, 21518, 0, 'SAY_AKAMA_COUNCIL_1'),
(23089, 9, 0, 'Let us finish what we\'ve started.  I will lead you to Illidan\'s abode once you\'ve recovered your strength.', 12, 0, 100, 1, 0, 0, 21520, 0, 'SAY_AKAMA_COUNCIL_2');

DELETE FROM `creature_text` WHERE (`CreatureID` = 22917);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22917, 0, 0, 'Come, my minions. Deal with this traitor as he deserves!', 14, 0, 100, 0, 0, 11465, 21251, 0, 'Illidan SAY_ILLIDAN_MINION'),
(22917, 1, 0, 'Who shall be next to taste my blades?', 14, 0, 100, 0, 0, 11473, 21499, 0, 'Illidan SAY_ILLIDAN_KILL'),
(22917, 1, 1, 'This is too easy!', 14, 0, 100, 0, 0, 11472, 21498, 0, 'Illidan SAY_ILLIDAN_KILL'),
(22917, 2, 0, 'I will not be touched by rabble such as you!', 14, 0, 100, 0, 0, 11479, 21252, 0, 'Illidan SAY_ILLIDAN_TAKEOFF'),
(22917, 3, 0, 'Behold the Flames of Azzinoth!', 14, 0, 100, 0, 0, 11480, 21275, 0, 'Illidan SAY_ILLIDAN_SUMMONFLAMES'),
(22917, 4, 0, 'Stare into the eyes of the Betrayer!', 14, 0, 100, 0, 0, 11481, 21497, 0, 'Illidan SAY_ILLIDAN_EYE_BLAST'),
(22917, 5, 0, 'Behold the power... of the demon within!', 14, 0, 100, 0, 0, 11475, 21066, 0, 'Illidan SAY_ILLIDAN_MORPH'),
(22917, 6, 0, 'You\'ve wasted too much time, mortals. Now you shall fall.', 14, 0, 100, 0, 0, 11474, 22036, 0, 'Illidan SAY_ILLIDAN_ENRAGE'),
(22917, 7, 0, 'I can feel your hatred.', 14, 0, 100, 0, 0, 11467, 0, 0, 'Illidan SAY_ILLIDAN_TAUNT'),
(22917, 7, 1, 'Give in to your fear!', 14, 0, 100, 0, 0, 11468, 0, 0, 'Illidan SAY_ILLIDAN_TAUNT'),
(22917, 7, 2, 'You know nothing of power!', 14, 0, 100, 0, 0, 11469, 21500, 0, 'Illidan SAY_ILLIDAN_TAUNT'),
(22917, 7, 3, 'Such... arrogance!', 14, 0, 100, 0, 0, 11471, 0, 0, 'Illidan SAY_ILLIDAN_TAUNT'),
(22917, 8, 0, 'Akama. Your duplicity is hardly surprising. I should have slaughtered you and your malformed brethren long ago.', 14, 0, 100, 0, 0, 11463, 20867, 0, 'Illidan SAY_ILLIDAN_DUPLICITY'),
(22917, 9, 0, 'Boldly said. But I remain... unconvinced.', 14, 0, 100, 6, 0, 11464, 20868, 0, 'Illidan SAY_ILLIDAN_UNCONVINCED'),
(22917, 10, 0, 'You are not prepared!', 14, 0, 100, 406, 0, 11466, 20884, 0, 'Illidan SAY_ILLIDAN_PREPARED'),
(22917, 11, 0, 'Is this it, mortals? Is this all the fury you can muster?', 14, 0, 100, 0, 0, 11476, 21068, 0, 'Illidan SAY_ILLIDAN_SHADOW_PRISON'),
(22917, 12, 0, 'Maiev... How is it even possible?', 14, 0, 100, 1, 0, 11477, 21069, 0, 'Illidan SAY_ILLIDAN_CONFRONT_MAIEV'),
(22917, 13, 0, 'Feel the hatred of ten thousand years!', 14, 0, 100, 0, 0, 11470, 21501, 0, 'Illidan SAY_ILLIDAN_FRENZY'),
(22917, 14, 0, 'You have won... Maiev. But the huntress... is nothing without the hunt. You... are nothing... without me.', 14, 0, 100, 0, 0, 11478, 21506, 0, 'Illidan SAY_ILLIDAN_DEFEATED');

DELETE FROM `creature_text` WHERE (`CreatureID` = 23197);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23197, 0, 0, 'That is for Naisha!', 14, 0, 100, 0, 0, 11493, 21489, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT'),
(23197, 0, 1, 'Bleed as I have bled!', 14, 0, 100, 0, 0, 11494, 0, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT'),
(23197, 0, 2, 'There shall be no prison for you this time!', 14, 0, 100, 0, 0, 11495, 22208, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT'),
(23197, 0, 3, 'Meet your end, demon!', 14, 0, 100, 0, 0, 11500, 0, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TAUNT'),
(23197, 1, 0, 'Their fury pales before mine, Illidan. We have some unsettled business between us.', 14, 0, 100, 6, 0, 11491, 21070, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_APPEAR'),
(23197, 2, 0, 'My long hunt is finally over. Today, Justice will be done!', 14, 0, 100, 5, 0, 11492, 21071, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_JUSTICE'),
(23197, 3, 0, 'There shall be no prison for you this time!', 14, 0, 100, 0, 0, 11495, 22208, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_TRAP'),
(23197, 4, 0, '%s falls to the floor.', 16, 0, 100, 0, 0, 0, 21317, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_DOWN'),
(23197, 5, 0, 'It is finished. You are beaten.', 14, 0, 100, 0, 0, 11496, 21507, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_FINISHED'),
(23197, 6, 0, 'He\'s right. I feel nothing... I am... nothing.', 14, 0, 100, 0, 0, 11497, 21508, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_OUTRO'),
(23197, 7, 0, 'Farewell, champions.', 14, 0, 100, 0, 0, 11498, 21509, 0, 'Maiev Shadowsong SAY_MAIEV_SHADOWSONG_FAREWELL');

DELETE FROM `waypoint_data` WHERE `id` IN (230892, 230893, 230894);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- Path Illidari Council 2
(230892,1,673.1424,354.9833,271.6953,NULL,0,1,0,100,0),
(230892,2,696.67883,380.00977,271.8905,NULL,0,1,0,100,0),
(230892,3,721.36926,374.37347,280.9863,NULL,0,1,0,100,0),
(230892,4,736.7919,352.50674,296.42725,NULL,0,1,0,100,0),
(230892,5,745.5639,336.74622,306.2915,NULL,0,1,0,100,0),
(230892,6,749.1409,319.2256,311.6832,NULL,0,1,0,100,0),
(230892,7,751.4883,308.6376,312.07648,NULL,0,1,0,100,0),
(230892,8,755.7801,304.4006,312.1663,NULL,0,1,0,100,0),
(230892,9,755.7801,304.4006,312.1663,6.2657318115234375,0,0,0,100,0),
-- Path Illidari Council 3
(230893,1,798.9379,294.3112,319.75885,NULL,0,1,0,100,0),
(230893,2,797.5406,276.17447,330.36548,NULL,0,1,0,100,0),
(230893,3,793.6441,254.72418,341.4547,NULL,0,1,0,100,0),
(230893,4,764.82074,238.01302,353.61133,NULL,0,1,0,100,0),
(230893,5,748.4362,235.80513,352.99878,NULL,0,1,0,100,0),
(230893,6,748.4362,235.80513,352.99878,2.129301786422729492,0,0,0,100,0),
-- Face Minions
(230894,1,745.225,304.946,352.98593,3.140537023544311523,0,1,0,100,0),
(230894,2,743.76953,363.82217,352.98837,NULL,2600,1,0,100,0),
(230894,3,752.2771,369.94006,353.15842,NULL,0,1,0,100,0),
(230894,4,799.1155,304.4322,319.75153,NULL,0,1,0,100,0),
(230894,5,799.1155,304.4322,319.75153,3.071779489517211914,0,1,0,100,0);

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_maiev_illidan' WHERE (`entry` = 23197);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23197);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2319700);
UPDATE `creature_template_addon` SET `bytes1` = 0 WHERE (`entry` = 22917);

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 23498;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23498) AND (`source_type` = 0);
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '34429 41913' WHERE (`entry` = 23498);
UPDATE `creature_template` SET `ScriptName` = 'npc_parasitic_shadowfiend' WHERE (`entry` = 23498);

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 22996;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22996);
UPDATE `creature_template` SET `ScriptName` = 'npc_blade_of_azzinoth' WHERE (`entry` = 22996);

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 22997;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22997);
UPDATE `creature_template` SET `ScriptName` = 'npc_flame_of_azzinoth' WHERE (`entry` = 22997);
