-- Akama Aura: 41000
-- Illidan Aura: 39656, 43689

/* Akama Close Interaction
[7] NpcFlags: 0
[7] SheatheState: 0
-- Face Illidan Point
X: 745.225 Y: 304.946 Z: 352.98593
Face Illidan Point
*/
/* Akama Reached Point
Set Orientation to Illidan
Save Home PoS
Trigger Illidan Start Scene
Wait 15400
(25) Text: We've come to end your reign, Illidan. My people, and all of Outland, shall be free!
Wait 4040
Emote ID: 1 (OneShotTalk)
Wait 3640
Emote ID: 66 (OneShotSalute)
Wait 10760
(22) Text: The time has come! The moment is at hand!
Wait 1370
Emote ID: 15 (OneShotRoar)
SheatheState: 1
Wait 2430
EmoteState: 333
Wait 5670
Start Attack
*/
/* Illidan Calls Minions
Stop Attack
Wait 6700
(22) Text: I will deal with these mongrels! Strike now, friends! Strike at the Betrayer!
Wait 2830
Emote ID: 5 (OneShotExclamation)
Wait 4870
Return Home
Wait 1200
Flags: 512
Path Minions
DELETE FROM `waypoint_data` WHERE `id`= @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 0, 743.7695, 363.8222, 352.9884, NULL, 2600), -- Akama Teleport
(@PATH, 1, 799.1155, 304.4322, 319.7515, NULL, 0),
(@PATH, 2, 799.1155, 304.4322, 319.7515, 3.071779489517211914, 0);
-- Akama Teleport SpellID: 41077 
X: 752.2771 Y: 369.94006 Z: 353.15842 O: 2.8972466
-- Spawn Illidari Elite (23226)
*/
/* Akama Ending
Maiev Says "He's Right"
753.04553 Y: 369.30273 Z: 353.1165
717.6826 Y: 321.7225 Z: 352.98593
Maiev Despawns
(1) Text: The Light will bless these dismal halls once again.... I swear it.
Wait 3490
Emote ID: 66 (OneShotSalute)
Wait 4850
FaceDirection: 4.073236465454101562
SpellID: 41242
*/

/* Illidan Intro
Akama Faces Illidan
Drop Intro Aura
Wait 2210
Text: Akama. Your duplicity is hardly surprising. I should have slaughtered you and your malformed brethren long ago.
Wait 3460
Emote ID: 6 (OneShotQuestion)
Wait 2430
Emote ID: 6 (OneShotQuestion)
Wait 3650
Emote ID: 6 (OneShotQuestion)
Wait 15200
(6) Text: Boldly said. But I remain... unconvinced.
Wait 3030
Emote ID: 6 (OneShotQuestion)
Wait 9730
(406) Text: You are not prepared!
Wait 1210
SheatheState: 1
Wait 2450
Start Attack
*/
/* Illidan Fly Phase Start
Attack Stop
SpellID: 34098
Emote ID: 254 (OneShotLiftOff)
Disable Gravity & Hover
FaceDirection: 2.837961435317993164
Flags: 34080768
Wait 3640
SoundKitID: 11479 (11479)
Wait 3650
Fly Point 727.6356 Y: 305.62753 Z: 359.1486
*/
/* Illidan Fly Phase Reached Fly Point
SoundKitID: 11480 (11480)
Face Entry: 22515
Wait 1210
SpellID: 39849
Wait 1220
SpellID: 39635
Unload Equipment
Wait 660
Face Entry: 22917
Start Flying Phase Proper
*/
/*Illidan Land
SpellID: 39873
Wait 635
SpellVisualKit: 7668
Wait 580
Load Equipment
Wait 2450
Emote ID: 293 (OneShotLand)
Enable Gravity & Hover
Wait 2430
Clear Threat
Remove Flags
Wait 1210
SpellID: 43689
*/
/* Demon Form Phase
Root
SpellID: 40511
Wait 2630
Text: Behold the power... of the demon within!
Wait 12630
Unroot
*/
/*
Shadow Prison Phase
SpellID: 40647
Stop Attack
Flags: 34080768
Wait 1200
SpellID: 41616
Wait 230
Text: Is this it, mortals? Is this all the fury you can muster?
Wait 9510
SpellID: 40403
Flags: 34342912
Face Maiev
Wait 8550
(1) Text: Maiev... How is it even possible?
Wait 3590
EmoteState: 333
Wait 9750
Flags: 526336
Attack Start
*/
/* Death Phase
SpellID: 34098
Root
SpellID: 41218
Attack Stop
Flags: 788480
Flags: 559104
Wait 1210
SpellID: 41220
Wait 6280
Text: You have won... Maiev. But the huntress... is nothing without the hunt. You... are nothing... without me.
Wait 18040
Unroot
Kill Credit
Die
*/

/* Maiev Spawn
Face Illidan
Wait 25
(6) Text: Their fury pales before mine, Illidan. We have some unsettled business between us.
Wait 2390
Emote ID: 5 (OneShotExclamation)
Wait 12400
(5) Text: My long hunt is finally over. Today, Justice will be done!
Wait 2200
Emote ID: 273 (OneShotYes)
Wait 2430
Emote ID: 15 (OneShotRoar)
Wait 2475
Flags: 557056
Wait 1175
Start Attack
*/
/* Maiev Ending
Illidan Start Death Phase
Wait 1420
Text: It is finished. You are beaten.
Wait 27130
Text: He's right. I feel nothing... I am... nothing.
Wait 10960
Text: Farewell, champions.
Wait 2190
SpellID: 41236
Wait 1620
Despawn
*/

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
(23089, 8, 0, 'Let us finish what we\'ve started.  I will lead you to Illidan\'s abode once you\'ve recovered your strength.', 12, 0, 100, 1, 0, 0, 21520, 0, 'SAY_AKAMA_FINISH'),
(23089, 9, 0, 'Those who\'ve defiled this temple have all been defeated.  All but one!', 12, 0, 100, 1, 0, 0, 21518, 0, 'SAY_AKAMA_COUNCIL_1'),
(23089, 10, 0, 'Let us finish what we\'ve started.  I will lead you to Illidan\'s abode once you\'ve recovered your strength.', 12, 0, 100, 1, 0, 0, 21520, 0, 'SAY_AKAMA_COUNCIL_2');

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
(22917, 8, 0, 'Akama. Your duplicity is hardly surprising. I should have slaughtered you and your malformed brethren long ago.', 14, 0, 100, 6, 0, 11463, 20867, 0, 'Illidan SAY_ILLIDAN_DUPLICITY'),
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

