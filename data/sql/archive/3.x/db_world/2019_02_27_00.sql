-- DB update 2019_02_25_00 -> 2019_02_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_25_00 2019_02_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1550359453246256000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

-- Undercity Fight
-- The Battle for the Undercity - Alliance
SET @WRYNN := 32401;
SET @JAINA := 32402;
SET @BROLL := 32376;
SET @VALEERA := 32378;
SET @SWSOLDIER := 32387;
SET @SWSOLDIER2 := 31639;
SET @ALLIANCETANK := 31638;
SET @ALLIANCEPLANE := 32388;
SET @DEMOLISHER := 31652;
SET @WSGUARD := 31739;
SET @PLAGUEDFELBEAST := 32392;
SET @GUARDIAN := 32390;
SET @DREADLORD := 32391;
SET @BLIGHTDOCTOR := 32397;
SET @COLLABORATOR := 32396;
SET @BETRAYER := 32394;
SET @CHEMIST := 32395;
SET @GENERATOR := 36212;
SET @PUTRESS := 31530;
SET @BLIGHTWORM := 32483;
SET @KHANOK := 32511;
SET @FAILEDEXPERIMENT := 32519;
SET @THRALL := 32518;
SET @SYLVANAS := 32365;
SET @VARIMATHRAS := 31565;
SET @SAURFANG := 32315;
SET @VOICE := 32277;
SET @VOLJIN := 31649;
SET @SPELLPHASE128 := 60815;
SET @SPELLPHASE64 := 59062;
SET @BLIGHTBREATH := 61125;
SET @INGEST := 61123;
SET @SPELLMISSILES := 54900;
SET @BLIGHTEMPOWERMENT := 59449;
SET @WRYNNBUFF := 60964;
SET @QUEST := 13377;
SET @QUEST_H := 13267;
SET @PORTAL := 193956;
SET @CGUID := 3109763;
SET @GGUID := 2134392;

-- ALLIANCE EVENT
UPDATE `creature_template` SET HealthModifier=915.547520661157 WHERE entry=32483;

UPDATE `creature_template` SET InhabitType=4, minlevel=74, maxlevel=75 WHERE entry=@ALLIANCEPLANE;
UPDATE `creature_template` SET minlevel=75, maxlevel=76 WHERE entry=@SWSOLDIER;

UPDATE `creature_template` SET unit_flags=0, minlevel=74, maxlevel=76 WHERE entry IN (@PLAGUEDFELBEAST,@GUARDIAN,@DREADLORD,@BLIGHTDOCTOR,@COLLABORATOR,@BETRAYER,@CHEMIST);
UPDATE `creature_template` SET unit_flags=256 WHERE entry=@WRYNN;
UPDATE `creature_template` SET unit_flags=unit_flags|512, faction=2142 WHERE entry=@JAINA;
UPDATE `creature_template` SET type_flags=type_flags|4096 WHERE entry IN(@WRYNN, @JAINA);
UPDATE `creature_template` SET minlevel=80, maxlevel=80 WHERE entry IN(@BROLL, @VALEERA, @WRYNN, @JAINA);
UPDATE `creature_template` SET unit_flags=32768 WHERE entry=@BLIGHTWORM;
UPDATE `creature_template` SET minlevel=83, maxlevel=83 WHERE entry IN(@BLIGHTWORM, @PUTRESS);
UPDATE `creature_template` SET unit_flags=unit_flags|256|512, flags_extra=flags_extra|128, InhabitType=4 WHERE entry=@GENERATOR;

UPDATE `creature_template` SET ScriptName="npc_varian_wrynn" WHERE entry=@WRYNN;
UPDATE `creature_template` SET ScriptName="npc_jaina_proudmoore_bfu" WHERE entry=@JAINA;
UPDATE `creature_template` SET ScriptName="boss_blight_worm" WHERE entry=@BLIGHTWORM;

DELETE FROM `spell_script_names` WHERE spell_id IN(@INGEST);
INSERT INTO `spell_script_names` (spell_id, Scriptname) VALUES
(@INGEST, 'spell_blight_worm_ingest');

DELETE FROM `creature_text` WHERE CreatureID IN(@WRYNN, @JAINA, @PUTRESS, @THRALL, @SYLVANAS, @VARIMATHRAS, @SAURFANG, @VOICE);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `Text`, `Type`, `Language`, `Sound`, `comment`, `BroadcastTextId`) VALUES
(@WRYNN, 0, 'Heroes of the Alliance, your King calls! Gather behind me at the entrance to the sewers of the Undercity!', 14, 0, 16103, 'Wrynn - Battle for Undercity',32843),
(@WRYNN, 1, 'Hidden inside this defiled city is the wretch responsible for murdering our brothers and sisters at the Wrathgate! He must be brought to justice!', 14, 0, 16104, 'Wrynn - battle for Undercity',32979),
(@WRYNN, 2, 'Soon we will march upon this cursed place and cleanse it of its evil!', 14, 0, 16102, 'Wrynn - Battle for Undercity (Alliance)',32844),
(@WRYNN, 3, 'The hour of redemption is close at hand! Prepare yourselves!', 14, 0, 16101, 'Wrynn - Battle for Undercity (Alliance)',32847),
(@WRYNN, 4, 'The march upon the Undercity begins now! Be empowered by your King''s strength! Follow me, heroes! FOR THE GLORY OF THE ALLIANCE!', 14, 0, 16100, 'Wrynn - Battle for Undercity (Alliance)',32849),
(@WRYNN, 5, 'Onward, brothers and sisters! Destiny awaits!', 14, 0, 16079, 'Wrynn - Battle for Undercity (Alliance)',32856),
(@WRYNN, 6, 'Our descent into the depths of depravity begins! Be on guard! Jaina, lend us your strength!', 12, 0, 16080, 'Wrynn - Battle for Undercity (Alliance)',32858),
(@WRYNN, 7, 'What is this?! Stand your ground! Do not give them an inch!', 12, 0, 16081, 'Wrynn - Battle for Undercity (Alliance)',36090),
(@WRYNN, 8, 'Soldiers, fall in! Guard the halls!', 14, 0, 16082, 'Wrynn - Battle for Undercity',32938),
(@WRYNN, 9, 'Your aberrations are no match for the Alliance, Putress! We''re coming for you!', 14, 0, 16083, 'Wrynn - Battle for Undercity (Alliance)',32937),
(@WRYNN, 10, 'Horde. By the looks of the struggle, they are here in force - somewhere.', 12, 0, 16084, 'Wrynn - Battle for Undercity (Alliance)',32940),
(@WRYNN, 11, 'Stay alert and on guard. There''s no telling what horrors await us.', 12, 0, 16085, 'Wrynn - Battle for Undercity (Alliance)',32941),
(@WRYNN, 12, 'ONWARD!', 12, 0, 16086, 'Wrynn - Battle for Undercity (Alliance)',12821),
(@WRYNN, 13, 'The main chamber is this way! Let''s go!', 12, 0, 16087, 'Wrynn - Battle for Undercity (Alliance)',32945),
(@WRYNN, 14, 'THERE!', 12, 0, 16088, 'Wrynn - Battle for Undercity (Alliance)',24654),
(@WRYNN, 15, 'There''s nowhere to run, monster!', 14, 0, 16089, 'Wrynn - Battle for Undercity (Alliance)',32947),
(@WRYNN, 16, 'And justice is served!', 14, 0, 16090, 'Wrynn - Battle for Undercity (Alliance)',32961),
(@WRYNN, 17, 'What say you now, Putress?', 12, 0, 16091, 'Wrynn - Battle for Undercity (Alliance)',32962),
(@WRYNN, 18, 'Look around you, brothers and sisters. Open your eyes! Look at what they have done to our kingdom!', 12, 0, 16092, 'Wrynn - Battle for Undercity (Alliance)',32963),
(@WRYNN, 19, 'How much longer will we allow these savages free reign in our world?', 12, 0, 16093, 'Wrynn - Battle for Undercity (Alliance)',32964),
(@WRYNN, 20, 'I have seen the Horde''s world. I have been inside their cities. Inside their minds...', 12, 0, 16094, 'Wrynn - Battle for Undercity (Alliance)',32965),
(@WRYNN, 21, 'I know what evil lies in the hearts of orcs.', 12, 0, 16095, 'Wrynn - Battle for Undercity (Alliance)',32966),
(@WRYNN, 22, 'THRALL! HERE?', 12, 0, 16096, 'Wrynn - Battle for Undercity (Alliance)',32968),
(@WRYNN, 23, 'ONWARD! We end this now!', 12, 0, 16097, 'Wrynn - Battle for Undercity (Alliance)',32969),
(@WRYNN, 24, 'The orcs have a battle cry: LOK''TAR OGAR! It means "victory or death." Fitting...', 12, 0, 16098, 'Wrynn - Battle for Undercity (Alliance)',32970),
(@WRYNN, 25, 'To the throne room!', 12, 0, 16099, 'Wrynn - Battle for Undercity (Alliance)',32971),
(@WRYNN, 26, 'I was away for too long. My absence cost us the lives of some of our greatest heroes. Trash like you and this evil witch were allowed to roam free -- unchecked.', 12, 0, 16073, 'Wrynn - Battle for Undercity (Alliance)',32691),
(@WRYNN, 27, 'The time has come to make things right. To disband your treacherous kingdom of murderers and thieves. Putress was the first strike. Many more will come.', 12, 0, 16074, 'Wrynn - Battle for Undercity (Alliance)',32693),
(@WRYNN, 28, 'I''ve waited a long time for this, Thrall. For every time I was thrown into one of your damned arenas... for every time I killed a green-skinned aberration like you... I could only think of one thing.', 12, 0, 16075, 'Wrynn - Battle for Undercity (Alliance)',32697),
(@WRYNN, 29, 'What our world could be without you and your twisted Horde... It ends now, Warchief.', 12, 0, 16076, 'Wrynn - Battle for Undercity (Alliance)',32699),
(@WRYNN, 30, 'ATTACK! FOR STORMWIND! FOR BOLVAR! FOR THE ALLIANCE!', 12, 0, 16077, 'Wrynn - Battle for Undercity (Alliance)',32700),
(@JAINA, 0, 'Right away, your majesty!', 12, 0, 16126, 'Jaina - Battle for Undercity (Alliance)', 32865),
(@JAINA, 1, 'What''s happened here? There are corpses everywhere... the stench... overwhelming...', 12, 0, 16127, 'Jaina - Battle for Undercity (Alliance)',32939),
(@JAINA, 2, 'Varian, stop! I won''t help you do this!', 12, 0, 16128, 'Jaina - Battle for Undercity (Alliance)',32972),
(@JAINA, 3, 'VARIAN, NO! STOP!', 14, 0, 16122, 'Jaina - Battle for Undercity (Alliance)',32709),
(@JAINA, 4, 'It did not have to be like this...', 12, 0, 16123, 'Jaina - Battle for Undercity (Alliance)',32711),
(@PUTRESS, 0, 'Do not let them pass, minions!', 14, 0, 16289, 'Putress - Battle for Undercity (Alliance)',32943),
(@PUTRESS, 1, 'KILL THEM! My work must not be interrupted!', 14, 0, 16290, 'Putress - Battle for Undercity (Alliance)',32944),
(@PUTRESS, 2, 'Stare into the abyss and watch as it blackens your souls!', 14, 0, 16294, 'Putress - Battle for Undercity (Alliance)',32949),
(@PUTRESS, 3, 'You are no match for my creations!', 14, 0, 16295, 'Putress - Battle for Undercity (Alliance)',32952),
(@PUTRESS, 4, 'This cannot be happening!', 14, 0, 16296, 'Putress - Battle for Undercity (Alliance)',32953),
(@PUTRESS, 5, 'It will not end like this! I''ve worked too hard! So many years... I... I will consume more energy!', 14, 0, 16291, 'Putress - Battle for Undercity (Alliance)',32948),
(@PUTRESS, 6, 'The power washes through me! I see... EVERTHING!', 14, 0, 16292, 'Putress - Battle for Undercity (Alliance)',32950),
(@PUTRESS, 7, 'MORE SUFFERING AWAITS!', 14, 0, 16293, 'Putress - Battle for Undercity (Alliance)',32951),
(@THRALL, 0, 'WE ARE VICTORIOUS!', 12, 1, 16212, 'Thrall - Battle for Undercity (Alliance)',32643),
(@THRALL, 1, 'The Undercity belongs to the Horde once more! LOK''TAR!', 12, 1, 16214, 'Thrall - Battle for Undercity (Alliance)',32644),
(@THRALL, 2, 'HEROES OF THE HORDE, YOUR WARCHIEF CALLS!', 14, 0, 16187, 'Thrall - Battle for Undercity (Horde)',32339),
(@THRALL, 3, 'Gather behind me at the gates of the Undercity! Soon we march upon our fallen city and reclaim it - FOR THE HORDE!', 14, 0, 16188, 'Thrall - Battle for Undercity (Horde)',32361),
(@THRALL, 4, 'Blood and thunder, champions of the Horde! We fight on this day for our fallen brothers and sisters! Mourn them not for they all died with honor in their hearts!', 14, 0, 16189, 'Thrall - Battle for Undercity (Horde)',32340),
(@THRALL, 5, 'Though we face great conflict, our might combined shall obliterate those who would oppose us! The grave injustices committed against the Horde will be met by an unstoppable force of reckoning!', 14, 0, 16190, 'Thrall - Battle for Undercity (Horde)',32341),
(@THRALL, 6, 'I call to you great spirits! Grant the Horde your blessing! For on this day our cause is righteous and just!', 14, 0, 16191, 'Thrall - Battle for Undercity (Horde)',32342),
(@THRALL, 7, 'Spirits of wind, carry to Saurfang the Younger the song of war! May ALL of our fallen brethren be vindicated by this battle!', 14, 0, 16192, 'Thrall - Battle for Undercity (Horde)',32362),
(@THRALL, 8, 'The battle for the Undercity begins now! Sound the horns of war! Champions of the Horde, be empowered by the might of your Warchief!', 14, 0, 16193, 'Thrall - Battle for Undercity (Horde)',32363),
(@THRALL, 9, 'ONWARD!', 14, 0, 16195, 'Thrall - Battle for Undercity (Horde)',32366),
(@THRALL, 10, 'Great wind brother, clear our path!', 14, 0, 16196, 'Thrall - Battle for Undercity (Horde)',32367),
(@THRALL, 11, 'You must answer to the elements, demon!', 14, 0, 16197, 'Thrall - Battle for Undercity (Horde)',32368),
(@THRALL, 12, 'Great water spirit, wash away this corruption!', 12, 0, 16194, 'Thrall - Battle for Undercity (Horde)',32369),
(@THRALL, 13, 'ATTACK!!!!', 14, 0, 16198, 'Thrall - Battle for Undercity (Horde)',32396),
(@THRALL, 14, 'The courtyard is ours! Onward to the inner sanctum!', 14, 0, 16199, 'Thrall - Battle for Undercity (Horde)',32460),
(@THRALL, 15, 'HOLD! They''ve destroyed the elevator!', 12, 0, 16200, 'Thrall - Battle for Undercity (Horde)',32461),
(@THRALL, 16, 'Great air spirit, hear my call once more!', 12, 0, 16201, 'Thrall - Battle for Undercity (Horde)',32490),
(@THRALL, 17, 'The spirits of air have heard my call. Cyclones will lower us to safety. Now we jump!', 12, 0, 16202, 'Thrall - Battle for Undercity (Horde)',32491),
(@THRALL, 18, 'We have breached the inner sanctum, heroes! We press on!', 14, 0, 16203, 'Thrall - Battle for Undercity (Horde)',32494),
(@THRALL, 19, 'Lead the way, Dark Lady. We will follow.', 12, 0, 16204, 'Thrall - Battle for Undercity (Horde)',32496),
(@THRALL, 20, 'Is that all, demon? Have you nothing left to throw at us?', 14, 0, 16205, 'Thrall - Battle for Undercity (Horde)',32553),
(@THRALL, 21, 'We come for you! Prepare yourself!', 14, 0, 16206, 'Thrall - Battle for Undercity (Horde)',32564),
(@THRALL, 22, 'COWARD! You think to stop the Warchief of the Horde with pebbles? I will show you the true power of the elements!', 14, 0, 16207, 'Thrall - Battle for Undercity (Horde)',32565),
(@THRALL, 23, 'Great spirits of the earth, help us in our hour of need!', 14, 0, 16208, 'Thrall - Battle for Undercity (Horde)',32575),
(@THRALL, 24, 'LET''S GO! QUICKLY!', 14, 0, 16210, 'Thrall - Battle for Undercity (Horde)',32583),
(@THRALL, 25, 'What is this?', 14, 0, 16211, 'Thrall - Battle for Undercity (Horde)',13820),
(@THRALL, 26, 'WE ARE VICTORIOUS!', 14, 0, 16212, 'Thrall - Battle for Undercity (Horde)',32643),
(@THRALL, 27, 'The Undercity belongs to the Horde once more! LOK''TAR!', 14, 0, 16214, 'Thrall - Battle for Undercity (Horde)',32644),
(@THRALL, 28, 'Dark Lady, join me! You have fought hard and spilled much blood for this right. The Royal Quarter belongs to you!', 12, 0, 16215, 'Thrall - Battle for Undercity (Horde)',32646),
(@THRALL, 29, 'We shall, Sylvanas...', 12, 0, 16216, 'Thrall - Battle for Undercity (Horde)',32648),
(@THRALL, 30, 'Alliance horns? Stay on guard!', 12, 0, 16217, 'Thrall - Battle for Undercity (Horde)',32649),
(@THRALL, 31, 'It ends like it began...', 12, 0, 16218, 'Thrall - Battle for Undercity (Horde)',32728),
(@THRALL, 32, 'All that we have fought for in this world is lost. The hopes and dreams carried by my father and mother... by Doomhammer... Gone...', 12, 0, 16219, 'Thrall - Battle for Undercity (Horde)',32729),
(@THRALL, 33, 'If only you were here right now, old friend. You would know what to do.', 12, 0, 16220, 'Thrall - Battle for Undercity (Horde)',32730),
(@THRALL, 34, '%s nods.', 16, 0, 0, 'Thrall - Battle for Undercity (Horde)',3065),
(@THRALL, 35, 'It''s good to have you back, Varok, old friend. I''m sorry about your boy.', 12, 0, 16221, 'Thrall - Battle for Undercity (Horde)',32735),
(@SYLVANAS, 0, '%s begins to dance.', 16, 0, 0, 'Sylvanas - Battle for Undercity (Horde)',1480),
(@SYLVANAS, 1, 'The shaft is trapped, Warchief. A fall would mean certain death.', 12, 0, 16300, 'Sylvanas - Battle for Undercity (Horde)',32462),
(@SYLVANAS, 2, 'What have they done to my beautiful city!', 12, 0, 16301, 'Sylvanas - Battle for Undercity (Horde)',32489),
(@SYLVANAS, 3, 'The only redemption for the traitors responsible for this will be an agonizing death. My vengeance will be swift and without mercy!', 12, 0, 16302, 'Sylvanas - Battle for Undercity (Horde)',32495),
(@SYLVANAS, 4, 'Very well, Warchief. The Royal Quarter is this way. Stay on guard. There''s no telling what Varimathras and Putress have in store for us.', 12, 0, 16303, 'Sylvanas - Battle for Undercity (Horde)',32497),
(@SYLVANAS, 5, 'HOLD! I sense dark magic. Demon magic... Stand ready!', 12, 0, 16304, 'Sylvanas - Battle for Undercity (Horde)',32520),
(@SYLVANAS, 6, 'The Royal Quarter is just up ahead, Warchief.', 12, 0, 16305, 'Sylvanas - Battle for Undercity (Horde)',32567),
(@SYLVANAS, 7, 'Such will be the fate of all enemies of the Horde, Warchief. Now we must deal with the wretch, Putress.', 12, 0, 16306, 'Sylvanas - Battle for Undercity (Horde)',32647),
(@VARIMATHRAS, 0, 'Welcome to my kingdom of darkness!', 14, 0, 16156, 'Varimathras - Battle for Undercity (Horde)',32375),
(@VARIMATHRAS, 1, 'Did you enjoy my minion''s terrible creation? Potent, is it not?', 14, 0, 16157, 'Varimathras - Battle for Undercity (Horde)',32376),
(@VARIMATHRAS, 2, 'But enough prattling! You wish to reclaim your city? Come then, heroes! Your souls will fuel the host! You will have this place back in pieces!', 14, 0, 16158, 'Varimathras - Battle for Undercity (Horde)',32383),
(@VARIMATHRAS, 3, 'Clever girl...', 14, 0, 16159, 'Varimathras - Battle for Undercity (Horde)',32521),
(@VARIMATHRAS, 4, 'My brothers have grown hungry. Your souls will sate their appetites.', 14, 0, 16160, 'Varimathras - Battle for Undercity (Horde)',32524),
(@VARIMATHRAS, 5, 'Bring down the halls! NOW!', 14, 0, 16161, 'Varimathras - Battle for Undercity (Horde)',32568),
(@VARIMATHRAS, 6, 'Welcome to your future -- what little there is left of it...', 14, 0, 16163, 'Varimathras - Battle for Undercity (Horde)',32580),
(@VARIMATHRAS, 7, 'Too long... Tireless, endless planning... It will not end like this...', 14, 0, 16164, 'Varimathras - Battle for Undercity (Horde)',32610),
(@VARIMATHRAS, 8, 'Need more time... The Master is near...', 14, 0, 16165, 'Varimathras - Battle for Undercity (Horde)',32611),
(@VARIMATHRAS, 9, 'Such power! Can you not feel it, mortals? Cease this foolishness and join me!', 14, 0, 16166, 'Varimathras - Battle for Undercity (Horde)',32612),
(@VARIMATHRAS, 10, 'I will not fail! Not again!', 14, 0, 16167, 'Varimathras - Battle for Undercity (Horde)',39424),
(@VARIMATHRAS, 11, 'I cannot hold... Destabilizing...', 14, 0, 16168, 'Varimathras - Battle for Undercity (Horde)',32614),
(@VARIMATHRAS, 12, 'A thousand-thousand pardons, Master! I will deal with these intruders myself!', 14, 0, 16162, 'Varimathras - Battle for Undercity (Horde)',32579),
(@VARIMATHRAS, 13, 'Years... wasted...', 14, 0, 16169, 'Varimathras - Battle for Undercity (Horde)',32617),
(@VOICE, 0, 'YOU HAVE FAILED ME, VARIMATHRAS!', 14, 0, 16180, 'Distant Voice - Battle for Undercity (Horde)',32618),
(@SAURFANG, 0, 'I know what he would do.', 12, 0, 16286, 'High Overlord Saurfang - Battle for Undercity (Horde)',32731),
(@SAURFANG, 1, 'He would say to you: Thrall. Lead your people.', 12, 0, 16287, 'High Overlord Saurfang - Battle for Undercity (Horde)',32732),
(@SAURFANG, 2, 'Let''s go home, old friend.', 12, 0, 16288, 'High Overlord Saurfang - Battle for Undercity (Horde)',32733);

DELETE FROM `script_waypoint` WHERE entry=@WRYNN;
INSERT INTO `script_waypoint` (entry, pointid, location_x, location_y, location_z, point_comment) VALUES
(@WRYNN, 0, 1769.599976, 764.603027, 56.379799, 'Wrynn - Battle for Undercity - Point 0'),
(@WRYNN, 1, 1737.061401, 734.176514, 48.846516, 'Wrynn - Battle for Undercity - Point 1'),
(@WRYNN, 2, 1682.674927, 724.014771, 76.586487, 'Wrynn - Battle for Undercity - Point 2'), 
(@WRYNN, 3, 1668.876953, 726.333923, 79.350388, 'Wrynn - Battle for Undercity - Point 3'),
(@WRYNN, 4, 1659.442505, 728.100220, 80.636276, 'Wrynn - Battle for Undercity - Point 4'),
(@WRYNN, 5, 1650.706177, 730.601318, 80.140228, 'Wrynn - Battle for Undercity - Point 5'),
(@WRYNN, 6, 1640.455078, 731.206543, 78.431183, 'Wrynn - Battle for Undercity - Point 6'),
(@WRYNN, 7, 1630.264893, 729.969604, 76.064507, 'Wrynn - Battle for Undercity - Point 7'),
(@WRYNN, 8, 1623.391113, 727.724854, 73.552124, 'Wrynn - Battle for Undercity - Point 8'),
(@WRYNN, 9, 1614.849243, 725.338257, 69.028702, 'Wrynn - Battle for Undercity - Point 9'),
(@WRYNN, 10, 1609.030518, 721.665405, 67.251274, 'Wrynn - Battle for Undercity - Point 10'),
(@WRYNN, 11, 1602.738281, 717.242432, 64.603981, 'Wrynn - Battle for Undercity - Point 11'),
(@WRYNN, 12, 1599.945068, 710.074402, 61.798687, 'Wrynn - Battle for Undercity - Point 12'),
(@WRYNN, 13, 1596.872314, 700.400757, 57.862572, 'Wrynn - Battle for Undercity - Point 13'),
(@WRYNN, 14, 1594.679688, 691.449402, 54.076141, 'Wrynn - Battle for Undercity - Point 14'),
(@WRYNN, 15, 1593.728149, 682.279663, 51.790394, 'Wrynn - Battle for Undercity - Point 15'),
(@WRYNN, 16, 1595.317505, 674.509521, 49.216564, 'Wrynn - Battle for Undercity - Point 16'),
(@WRYNN, 17, 1598.770386, 666.729309, 45.928894, 'Wrynn - Battle for Undercity - Point 17'),
(@WRYNN, 18, 1604.125122, 659.070557, 52.987282, 'Wrynn - Battle for Undercity - Point 18'),
(@WRYNN, 19, 1611.547852, 652.845032, 37.432785, 'Wrynn - Battle for Undercity - Point 19'),
(@WRYNN, 20, 1618.446655, 649.685547, 36.362904, 'Wrynn - Battle for Undercity - Point 20'),
(@WRYNN, 21, 1627.054077, 648.112671, 33.163338, 'Wrynn - Battle for Undercity - Point 21'),
(@WRYNN, 22, 1635.322021, 647.447998, 29.125357, 'Wrynn - Battle for Undercity - Point 22'),
(@WRYNN, 23, 1643.719238, 647.232239, 25.528500, 'Wrynn - Battle for Undercity - Point 23'),
(@WRYNN, 24, 1652.585449, 647.011597, 23.371178, 'Wrynn - Battle for Undercity - Point 24'),
(@WRYNN, 25, 1661.797974, 646.665466, 19.748022, 'Wrynn - Battle for Undercity - Point 25'),
(@WRYNN, 26, 1669.443848, 643.789185, 16.222963, 'Wrynn - Battle for Undercity - Point 26'),
(@WRYNN, 27, 1678.117676, 640.330322, 11.936049, 'Wrynn - Battle for Undercity - Point 27'),
(@WRYNN, 28, 1683.575317, 635.935852, 10.046909, 'Wrynn - Battle for Undercity - Point 28'),
(@WRYNN, 29, 1686.576904, 629.480652, 8.213016, 'Wrynn - Battle for Undercity - Point 29'),
(@WRYNN, 30, 1690.336060, 622.338562, 4.941149, 'Wrynn - Battle for Undercity - Point 30'),
(@WRYNN, 31, 1694.002075, 615.171814, 3.019691, 'Wrynn - Battle for Undercity - Point 31'),
(@WRYNN, 32, 1694.130249, 610.749695, 2.907817, 'Wrynn - Battle for Undercity - Point 32'),
(@WRYNN, 33, 1693.700684, 603.755859, -0.0658589, 'Wrynn - Battle for Undercity - Point 33'),
(@WRYNN, 34, 1689.332153, 598.286316, -4.565350, 'Wrynn - Battle for Undercity - Point 34'),
(@WRYNN, 35, 1685.521240, 592.829468, -7.215833, 'Wrynn - Battle for Undercity - Point 35'),
(@WRYNN, 36, 1683.787842, 588.381287, -9.208620, 'Wrynn - Battle for Undercity - Point 36'),
(@WRYNN, 37, 1681.923584, 582.116272, -12.279209, 'Wrynn - Battle for Undercity - Point 37'),
(@WRYNN, 38, 1680.744385, 576.785156, -14.403152, 'Wrynn - Battle for Undercity - Point 38'),
(@WRYNN, 39, 1663.923828, 567.914734, -16.738506, 'Wrynn - Battle for Undercity - Point 39'),
(@WRYNN, 40, 1665.390015, 543.867737, -11.672810, 'Wrynn - Battle for Undercity - Point 40'),
(@WRYNN, 41, 1664.583374, 478.784821, -11.890515, 'Wrynn - Battle for Undercity - Point 41'),
(@WRYNN, 42, 1629.231689, 479.139526, -22.868773, 'Wrynn - Battle for Undercity - Point 42'),
(@WRYNN, 43, 1628.975586, 437.496094, -34.263428, 'Wrynn - Battle for Undercity - Point 43'),
(@WRYNN, 44, 1596.610352, 438.078033, -46.335011, 'Wrynn - Battle for Undercity - Point 44'),
(@WRYNN, 45, 1598.358521, 422.436493, -46.385242, 'Wrynn - Battle for Undercity - Point 45'),  /*jaina text 2*/
(@WRYNN, 46, 1590.335083, 420.340851, -45.410774, 'Wrynn - Battle for Undercity - Point 46'),  /*varian text 11,12,13 - putress text 1*/
(@WRYNN, 47, 1564.603638, 422.171417, -62.178089, 'Wrynn - Battle for Undercity - Point 47'),
(@WRYNN, 48, 1551.077881, 414.807404, -61.620495, 'Wrynn - Battle for Undercity - Point 48'),
(@WRYNN, 49, 1513.628052, 405.122131, -62.200069, 'Wrynn - Battle for Undercity - Point 49'),  /*guardian spawn*/
(@WRYNN, 50, 1501.178345, 411.828796, -61.185028, 'Wrynn - Battle for Undercity - Point 50'),  /*dreadlords kammer spawm - varian text 14*/
(@WRYNN, 51, 1494.877441, 420.079041, -62.185028, 'Wrynn - Battle for Undercity - Point 51'),
(@WRYNN, 52, 1504.596924, 427.219635, -64.004326, 'Wrynn - Battle for Undercity - Point 52'),
(@WRYNN, 53, 1507.520386, 436.379578, -65.228706, 'Wrynn - Battle for Undercity - Point 53'),
(@WRYNN, 54, 1502.412598, 444.093079, -63.657303, 'Wrynn - Battle for Undercity - Point 54'),
(@WRYNN, 55, 1492.878906, 449.624390, -61.303787, 'Wrynn - Battle for Undercity - Point 55'),
(@WRYNN, 56, 1481.203491, 448.626282, -61.926937, 'Wrynn - Battle for Undercity - Point 56'),
(@WRYNN, 57, 1470.947510, 441.626587, -64.884033, 'Wrynn - Battle for Undercity - Point 57'),
(@WRYNN, 58, 1459.560913, 439.790375, -65.719994, 'Wrynn - Battle for Undercity - Point 58'),
(@WRYNN, 59, 1453.266724, 445.335358, -65.725746, 'Wrynn - Battle for Undercity - Point 59'),
(@WRYNN, 60, 1437.707886, 461.207367, -70.461746, 'Wrynn - Battle for Undercity - Point 60'),
(@WRYNN, 61, 1431.330811, 455.469543, -70.235573, 'Wrynn - Battle for Undercity - Point 61'),
(@WRYNN, 62, 1418.527588, 442.289429, -77.236946, 'Wrynn - Battle for Undercity - Point 62'),
(@WRYNN, 63, 1419.539307, 437.509705, -77.238396, 'Wrynn - Battle for Undercity - Point 63'),  /*varian pause 5 sek - varian text 15*/
(@WRYNN, 64, 1433.060913, 425.915497, -84.968437, 'Wrynn - Battle for Undercity - Point 64'),
(@WRYNN, 65, 1431.568481, 413.905151, -85.247482, 'Wrynn - Battle for Undercity - Point 65'),  /*varian text 16 - putress text 3 - putress fight*/
(@WRYNN, 66, 1418.656860, 415.891388, -84.964584, 'Wrynn - Battle for Undercity - Point 66'),  /*varian text 17,18,19*/
(@WRYNN, 67, 1410.952026, 402.416718, -84.964584, 'Wrynn - Battle for Undercity - Point 67'),
(@WRYNN, 68, 1399.726563, 412.947327, -77.533615, 'Wrynn - Battle for Undercity - Point 68'),
(@WRYNN, 69, 1392.010620, 417.122741, -77.238647, 'Wrynn - Battle for Undercity - Point 69'),
(@WRYNN, 70, 1373.964722, 400.569214, -73.440285, 'Wrynn - Battle for Undercity - Point 70'),
(@WRYNN, 71, 1369.379150, 393.808319, -72.218079, 'Wrynn - Battle for Undercity - Point 71'),
(@WRYNN, 72, 1365.540161, 381.257690, -69.920845, 'Wrynn - Battle for Undercity - Point 72'),
(@WRYNN, 73, 1370.115479, 369.879608, -70.396088, 'Wrynn - Battle for Undercity - Point 73'),
(@WRYNN, 74, 1380.718506, 366.849944, -65.725105, 'Wrynn - Battle for Undercity - Point 74'), 
(@WRYNN, 75, 1419.407593, 355.772522, -66.002243, 'Wrynn - Battle for Undercity - Point 75'),
(@WRYNN, 76, 1427.617798, 350.418640, -64.184349, 'Wrynn - Battle for Undercity - Point 76'),
(@WRYNN, 77, 1449.683838, 344.867645, -62.260105, 'Wrynn - Battle for Undercity - Point 77'),
(@WRYNN, 78, 1471.418701, 364.907532, -62.187069, 'Wrynn - Battle for Undercity - Point 78'),
(@WRYNN, 79, 1468.382813, 369.370148, -59.438568, 'Wrynn - Battle for Undercity - Point 79'),
(@WRYNN, 80, 1438.317871, 402.571381, -57.817539, 'Wrynn - Battle for Undercity - Point 80'),
(@WRYNN, 81, 1410.944824, 429.138214, -54.993443, 'Wrynn - Battle for Undercity - Point 81'),
(@WRYNN, 82, 1378.896240, 438.826721, -52.780880, 'Wrynn - Battle for Undercity - Point 82'),
(@WRYNN, 83, 1361.706055, 437.253357, -54.116314, 'Wrynn - Battle for Undercity - Point 83'),
(@WRYNN, 84, 1341.773682, 430.280029, -56.126289, 'Wrynn - Battle for Undercity - Point 84'),
(@WRYNN, 85, 1329.199707, 420.427979, -58.596973, 'Wrynn - Battle for Undercity - Point 85'),
(@WRYNN, 86, 1316.311157, 405.356354, -61.681793, 'Wrynn - Battle for Undercity - Point 86'),
(@WRYNN, 87, 1310.210815, 386.160828, -65.063904, 'Wrynn - Battle for Undercity - Point 87'),
(@WRYNN, 88, 1302.375732, 360.250671, -67.294189, 'Wrynn - Battle for Undercity - Point 88');

DELETE FROM `creature` WHERE id IN (@WRYNN, @JAINA, @BROLL, @VALEERA, @SWSOLDIER, @ALLIANCETANK, @ALLIANCEPLANE) AND phasemask=128;
DELETE FROM `creature` WHERE id IN (@THRALL, @SYLVANAS, @VOLJIN, @DEMOLISHER, @WSGUARD) AND phasemask=64;
INSERT INTO `creature` (guid, id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation) VALUES
(@CGUID+1, @WRYNN, 0, 1, 128, 1769.597290, 764.603149, 56.379799, 3.538394),
(@CGUID+2, @JAINA, 0, 1, 128, 1771.324097, 760.024414, 55.704029, 2.949347),
(@CGUID+3, @BROLL, 0, 1, 128, 1766.193848, 768.037537, 56.619080, 3.858048),
(@CGUID+4, @VALEERA, 0, 1, 128, 1762.391235, 769.963318, 56.734879, 4.454149),
(@CGUID+5, @SWSOLDIER, 0, 1, 128, 1716.395142, 709.999634, 57.807465, 2.394830),
(@CGUID+6, @SWSOLDIER, 0, 1, 128, 1719.503662, 718.229919, 55.423946, 2.551910),
(@CGUID+7, @SWSOLDIER, 0, 1, 128, 1728.385986, 736.765991, 51.161797, 3.301965),
(@CGUID+8, @SWSOLDIER, 0, 1, 128, 1727.833984, 730.510620, 50.914570, 2.697203),
(@CGUID+9, @SWSOLDIER, 0, 1, 128, 1719.004395, 753.495544, 60.956600, 4.102753),
(@CGUID+10, @SWSOLDIER, 0, 1, 128, 1724.285600, 746.973328, 55.311218, 3.301972),
(@CGUID+11, @ALLIANCETANK, 0, 1, 128, 1745.139038, 724.722717, 47.574627, 2.760039),
(@CGUID+12, @ALLIANCETANK, 0, 1, 128, 1728.556152, 703.220215, 52.028885, 1.868613),
(@CGUID+13, @ALLIANCEPLANE, 0, 1, 128, 1737.992431, 714.137634, 67.690857, 2.795380),
(@CGUID+14, @ALLIANCEPLANE, 0, 1, 128, 1724.187389, 759.409973, 77.101479, 4.146400),
(@CGUID+15, @ALLIANCEPLANE, 0, 1, 128, 1730.264893, 741.177795, 74.171043, 3.946126),
(@CGUID+22, @THRALL, 0, 1, 64, 1945.722415, 234.059845, 43.810997, 3.155253),
(@CGUID+23, @SYLVANAS, 0, 1, 64, 1945.256714, 240.222763, 43.904449, 2.899998),
(@CGUID+24, @VOLJIN, 0, 1, 64, 1945.106445, 245.354813, 44.025818, 3.390873),
(@CGUID+25, @DEMOLISHER, 0, 1, 64, 1946.061523, 253.797592, 44.167881, 3.238506),
(@CGUID+26, @DEMOLISHER, 0, 1, 64, 1941.016968, 219.872681, 45.765697, 3.053928),
(@CGUID+27, @DEMOLISHER, 0, 1, 64, 1914.027710, 255.944031, 52.913757, 3.372014),
(@CGUID+28, @DEMOLISHER, 0, 1, 64, 1912.139648, 267.574860, 53.414268, 3.395576),
(@CGUID+29, @WSGUARD, 0, 1, 64, 1906.703613, 225.307816, 53.251461, 2.865430),
(@CGUID+30, @WSGUARD, 0, 1, 64, 1906.729736, 230.326752, 53.106655, 2.916481),
(@CGUID+31, @WSGUARD, 0, 1, 64, 1903.130005, 243.202081, 53.967991, 3.301327),
(@CGUID+32, @WSGUARD, 0, 1, 64, 1903.377075, 247.629807, 54.400906, 3.430917);

DELETE FROM `gameobject` WHERE id=@PORTAL AND map=0;
INSERT INTO `gameobject` (guid, id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation) VALUES
(@GGUID+0, @PORTAL, 0, 1, 128, 1775.205688, 763.229919, 55.140560, 3.033357);

UPDATE `creature` SET modelid=25341 WHERE id=@ALLIANCETANK;
UPDATE `creature_template` SET `speed_run`=0.8 WHERE `entry`=32401;

DELETE FROM `spell_area` WHERE spell=@SPELLPHASE128 AND AREA IN(85, 1497) AND quest_start=@QUEST;
DELETE FROM `spell_area` WHERE spell=@SPELLPHASE64 AND AREA IN(85, 1497) AND quest_start=@QUEST_H;
INSERT INTO `spell_area` (spell, AREA, quest_start, autocast, quest_start_status) VALUES
(@SPELLPHASE128, 85, @QUEST, 1, 10),  /*Tirisfal*/
(@SPELLPHASE128, 1497, @QUEST, 1, 10), /*Undercity*/
(@SPELLPHASE64, 85, @QUEST_H, 1, 10),
(@SPELLPHASE64, 1497, @QUEST_H, 1, 10);

DELETE FROM `waypoint_data` WHERE id IN(@SWSOLDIER*10, ((@SWSOLDIER*10)+1), ((@SWSOLDIER*10)+2), ((@SWSOLDIER*10)+3), @DREADLORD*10, @JAINA*10, (@JAINA*10)+1);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@SWSOLDIER*10, 1, 1687.26, 598.36, -5.22, 0, 0, 1, 0, 100, 0),
(@SWSOLDIER*10, 2, 1673.14, 579.10, -13.93, 0, 0, 1, 0, 100, 0),
(@SWSOLDIER*10, 3, 1661.91, 541.10, -11.69, 0.04, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+1, 1, 1687.26, 598.36, -5.22, 0, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+1, 2, 1673.14, 579.10, -13.93, 0, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+1, 3, 1665.15, 540.85, -11.67, 0, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+1, 4, 1666.42, 475.71, -11.89, 1.92, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+2, 1, 1687.26, 598.36, -5.22, 0, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+2, 2, 1683.50, 574.24, -13.97, 0, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+2, 3, 1686.05, 554.10, -16.99, 2.86, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+3, 1, 1687.26, 598.36, -5.22, 0, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+3, 2, 1683.50, 574.24, -13.97, 0, 0, 1, 0, 100, 0),
((@SWSOLDIER*10)+3, 3, 1676.22, 543.33, -16.08, 1.61, 0, 1, 0, 100, 0),
(@DREADLORD*10, 1, 1451.28, 446.47, -66.10, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 2, 1458.57, 440.21, -65.73, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 3, 1468.53, 441.33, -64.91, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 4, 1479.02, 447.63, -62.22, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 5, 1491.44, 450.06, -61.20, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 6, 1503.07, 442.98, -63.80, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 7, 1507.74, 435.07, -64.23, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 8, 1504.99, 427.69, -64.00, 0, 0, 1, 0, 100, 0),
(@DREADLORD*10, 9, 1495.37, 421.71, -62.18, 0, 0, 1, 0, 100, 0),
(@JAINA*10, 1, 1733.68, 736.60, 49.67, 0, 0, 1, 0, 100, 0),
(@JAINA*10, 2, 1684.00, 732.47, 76.46, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 1, 1666.05, 733.04, 79.92, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 2, 1650.68, 734.12, 80.62, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 3, 1630.44, 735.70, 75.98, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 4, 1616.05, 730.20, 69.88, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 5, 1600.15, 717.58, 63.86, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 6, 1590.42, 691.69, 54.16, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 7, 1587.20, 676.61, 50.55, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 8, 1596.85, 661.04, 42.98, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 9, 1607.72, 646.74, 37.24, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 10, 1618.62, 643.26, 36.51, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 11, 1637.74, 643.18, 28.24, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 12, 1666.07, 642.12, 17.06, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 13, 1679.35, 631.27, 10.92, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 14, 1687.66, 613.39, 2.97, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 15, 1684.68, 603.19, -2.52, 0, 0, 1, 0, 100, 0),
((@JAINA*10)+1, 16, 1675.13, 580.00, -13.72, 0, 0, 1, 0, 100, 0);

-- Battle for the Undercity - Start
DELETE FROM `disables` WHERE  `sourceType`=1 AND `entry`=13267;
SET @QUEST  := 13266;
SET @QUEST2 := 13267;
SET @SPELLPHASE64 := 59062;
SET @SPELLPHASE128 := 60815;
DELETE FROM `spell_area` WHERE spell=@SPELLPHASE64 AND AREA IN(85, 1497) AND quest_start IN (@QUEST, @QUEST2);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES 
(@SPELLPHASE64, 85, @QUEST, @QUEST2, 0, 0, 2, 1, 74, 11), /*Tirisfal*/
(@SPELLPHASE64, 1497, @QUEST, @QUEST2, 0, 0, 2, 1, 74, 11); /*Undercity*/

-- Vol'jin SAI
SET @ENTRY := 31649;
UPDATE `creature_template` SET `AIName`="SmartAI", `ScriptName`="" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,19,0,100,0,13267,0,0,0,75,59062,0,0,0,0,0,7,0,0,0,0,0,0,0,"Vol'jin - On Quest 'The Battle For The Undercity' Taken - Add Aura 'WGH Phase'");

-- 
-- Battle for the Undercity - Horde - Mainevent
SET @CGUID := 3109796;
SET @OGUID := 2134393;
-- Templateadjustements
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80 WHERE  `entry` IN (31739, 31652,32315);
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `faction`=14, `flags_extra`=130, `unit_flags`=256 WHERE `entry` IN (31576, 31577,31811);
UPDATE `creature_template` SET `InhabitType`=4 WHERE  `entry` IN (31811, 32200, 32159, 31814, 32277);
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `faction`=35, `flags_extra`=2, `unit_flags`=256 WHERE `entry` IN (31688);
UPDATE `creature_template` SET `speed_walk`=0.8, `speed_run`=1 WHERE  `entry`=31782;
-- attackable creatures
-- boss
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `faction`=14, `flags_extra`=0 WHERE `entry` IN (31565, 31844, 32511, 32271);
-- 74 -76
UPDATE `creature_template` SET `minlevel`=74, `maxlevel`=76, `faction`=14, `flags_extra`=0 WHERE `entry` IN (32270, 32269, 31528, 31526, 31532, 31516, 31482, 32393, 32391, 31529, 31528, 32159);
-- special unitflags
UPDATE `creature_template` SET `unit_flags`=0 WHERE  `entry` IN (32393, 32391, 31529, 31528, 32159, 31528, 32511, 32269, 32270);
-- creature_addons

-- guards
DELETE FROM `creature_addon` WHERE `guid` IN (3109792,3109793,3109794,3109795,3109787);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(3109792,0,0,0,1,27, ''),
(3109793,0,0,0,1,27, ''),
(3109794,0,0,0,1,27, ''),
(3109795,0,0,0,1,27, ''),
-- voljin mount
(3109787,0,14339,0,1,0, '');

DELETE FROM `creature_template_addon` WHERE `entry`=31576;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(31576,0,0,0,1,0, '59236');

-- SAIs
-- Horde Demolisher SAI
SET @ENTRY := 31652;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,2000,5000,4000,7000,11,62306,2,0,0,0,0,19,15384,200,0,0,0,0,0,"Horde Demolisher - Out of Combat - Cast 'Hurl Boulder'");

-- Whirlwind SAI
SET @ENTRY := 31782;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,10,10,10,10,45,5,5,0,0,0,0,19,31576,9,0,0,0,0,0,"Vortex - Out of Combat - Set Data 5 5");

-- Invisible Stalker [Wrath Gate Horde CE 01] (UC) SAI
SET @ENTRY := 31576;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,38,0,100,0,5,5,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Invisible Stalker [Wrath Gate Horde CE 01] (UC) - On Data Set 5 5 - Despawn Instant");

-- Blight Slinger SAI
SET @ENTRY := 31526;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,5,54,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blight Slinger - On Just Summoned - Disable Combat Movement"),
(@ENTRY,0,1,0,1,0,100,0,2000,5000,12000,15000,11,48211,0,0,0,0,0,19,31577,100,0,0,0,0,0,"Blight Slinger - Out of Combat - Cast 'Blight Bomb'"),
(@ENTRY,0,2,0,1,0,50,0,60000,60000,5000,15000,11,57606,0,0,0,0,0,21,200,0,0,0,0,0,0,"Blight Slinger - Out of Combat - Cast 'Plague Barrel'"),
(@ENTRY,0,3,0,0,0,50,0,60000,60000,5000,15000,11,57606,0,0,0,0,0,21,200,0,0,0,0,0,0,"Blight Slinger - In Combat - Cast 'Plague Barrel'"),
(@ENTRY,0,4,0,0,0,100,0,2000,5000,12000,15000,11,48211,0,0,0,0,0,19,31577,100,0,0,0,0,0,"Blight Slinger - In Combat - Cast 'Blight Bomb'"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,18,514,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blight Slinger - On Just Summoned - Set Flags Not Attackable & Immune To NPC's");

-- Tidal Wave SAI
SET @ENTRY := 31765;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,11,59635,2,0,0,0,0,1,0,0,0,0,0,0,0,"Tidal Wave - On Just Summoned - Cast 'Tidal Wave'"),
(@ENTRY,0,1,2,61,0,100,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,1735.787,238.951,62.796,6.225,"Tidal Wave - On Just Summoned - Move To Position"),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,41,20000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Tidal Wave - On Just Summoned - Despawn In 20000 ms"),
(@ENTRY,0,3,0,1,0,100,0,10,10,10,10,45,5,5,0,0,0,0,9,31576,0,200,0,0,0,0,"Tidal Wave - Out of Combat - Set Data 5 5");

-- Blight Aberration SAI
SET @ENTRY := 31844;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Blight Aberration - On Just Summoned - Say Line 0"),
(@ENTRY,0,1,0,1,0,100,0,4000,4000,4000,4000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Blight Aberration - Out of Combat - Start Attacking"),
(@ENTRY,0,2,0,0,0,100,0,4000,4000,4000,4000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Blight Aberration - In Combat - Start Attacking");

-- Treacherous Guardian SAI
SET @ENTRY := 31532;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,10,0,0,0,0,0,11,59395,0,0,0,0,0,2,0,0,0,0,0,0,0,"Treacherous Guardian - On Aggro - Cast 'Abomination Hook'"),
(@ENTRY,0,1,0,1,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Treacherous Guardian - Out of Combat - Start Attacking");

-- Blight Doctor SAI
SET @ENTRY := 31516;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Blight Doctor - Out of Combat - Start Attacking");

-- Apothecary Chemist SAI
SET @ENTRY := 31482;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Apothecary Chemist - Out of Combat - Start Attacking");

-- Skeleton SAI
SET @ENTRY := 6412;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,41,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Skeleton - On Just Summoned - Despawn In 15000 ms");

-- Grand Apothecary Putress SAI
SET @ENTRY := 31530;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,10000,8000,12000,11,59460,0,0,0,0,0,21,100,0,0,0,0,0,0,"Grand Apothecary Putress - In Combat - Cast 'Throw Blight Barrel'");

-- Felguard Marauder SAI
SET @ENTRY := 32393;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,60,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Felguard Marauder - On Update - Start Attacking");

-- Perfidious Dreadlord SAI
SET @ENTRY := 32391;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,60,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Perfidious Dreadlord - On Update - Start Attacking");

-- Ravishing Betrayer SAI
SET @ENTRY := 31529;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,60,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Ravishing Betrayer - On Update - Start Attacking");

-- Doomguard Pillager SAI
SET @ENTRY := 32159;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,1,54,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Doomguard Pillager - On Just Summoned - Set Reactstate Passive"),
(@ENTRY,0,1,0,61,0,100,0,0,0,0,0,53,1,@ENTRY*100+00,0,0,0,0,1,0,0,0,0,0,0,0,"Doomguard Pillager - On Just Summoned - Start Waypoint"),
(@ENTRY,0,2,3,40,0,100,0,6,@ENTRY*100+00,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Doomguard Pillager - On Waypoint 6 Reached - Set Home Position"),
(@ENTRY,0,3,4,61,0,100,0,6,@ENTRY*100+00,0,0,8,2,0,0,0,0,0,1,0,0,0,0,0,0,0,"Doomguard Pillager - On Waypoint 6 Reached - Set Reactstate Aggressive"),
(@ENTRY,0,4,0,61,0,100,0,6,@ENTRY*100+00,0,0,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Doomguard Pillager - On Waypoint 6 Reached - Start Attacking");

-- Khanok the Impassable SAI
SET @ENTRY := 32511;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Khanok the Impassable - On Just Summoned - Say Line 0"),
(@ENTRY,0,1,0,60,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Khanok the Impassable - On Update - Start Attacking"),
(@ENTRY,0,2,0,0,0,100,0,3000,5000,15000,18000,11,69633,0,0,0,0,0,21,200,0,0,0,0,0,0,"Khanok the Impassable - In Combat - Cast 'Veil of Shadow'");

-- Legion Overlord SAI
SET @ENTRY := 32271;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,60,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Legion Overlord - On Update - Start Attacking");

-- Legion Invader SAI
SET @ENTRY := 32269;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,60,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Legion Invader - On Update - Start Attacking");

-- Legion Dreadwhisperer SAI
SET @ENTRY := 32270;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,60,0,100,0,2000,2000,2000,2000,49,0,0,0,0,0,0,19,32518,200,0,0,0,0,0,"Legion Dreadwhisperer - On Update - Start Attacking");

-- Varimathras SAI
SET @ENTRY := 31565;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,5,6,0,100,0,0,0,0,0,1,13,0,0,0,0,0,1,0,0,0,0,0,0,0,"Varimathras - On Just Died - Say Line 13"),
(@ENTRY,0,1,0,0,0,100,0,5000,10000,20000,20000,75,59434,0,0,0,0,0,21,200,0,0,0,0,0,0,"Varimathras - In Combat - Add Aura 'Carrion Swarm'"),
(@ENTRY,0,2,0,0,0,100,0,4000,8000,18000,25000,11,17238,0,0,0,0,0,2,0,0,0,0,0,0,0,"Varimathras - In Combat - Cast 'Drain Life'"),
(@ENTRY,0,3,0,4,0,100,1,0,10,0,0,75,59424,0,0,0,0,0,1,0,0,0,0,0,0,0,"Varimathras - On Aggro - Add Aura 'Might of Varimathras' (No Repeat)"),
(@ENTRY,0,4,0,0,0,100,0,4000,8000,4000,8000,11,20741,0,0,0,0,0,5,0,0,0,0,0,0,0,"Varimathras - In Combat - Cast 'Shadow Bolt Volley'"),
(@ENTRY,0,5,0,61,0,100,0,0,0,0,0,12,32277,3,20000,0,0,0,8,0,0,0,1290.169,318.852,-27.933,3.861,"Varimathras - On Just Died - Summon Creature 'A Distant Voice'");

-- A Distant Voice SAI
SET @ENTRY := 32277;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,54,0,100,0,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,"A Distant Voice - On Just Summoned - Say Line 5");

-- conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND  `SourceGroup`=1 AND `SourceEntry`=59449;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 1, 59449, 0, 0, 31, 0, 3, 31530, 0, 0, 0, 0, '', 'SPELL_BLIGHT_EMPOWERMENT only targets NPC_PUTRESS');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND  `SourceGroup`=1 AND `SourceEntry`=60224;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 1, 60224, 0, 0, 31, 0, 3, 31811, 0, 0, 0, 0, '', 'Open Portals only targets Portals');

-- creaturespawns
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+88;
DELETE FROM `creature` WHERE `id` IN (31576, 31577);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES 
-- bomb bunny
(@CGUID, 15384, 0, 0, 0, 1, 64, 0, 0, 1874.08, 237.364, 93.4084, 6.07287, 300, 0, 0, 4121, 0, 0, 0, 0, 0, 0),
-- plaguebunny
(@CGUID+1, 31576, 0, 0, 0, 1, 64, 0, 0, 1878.9, 233.153, 59.7344, 3.03575, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+2, 31576, 0, 0, 0, 1, 64, 0, 0, 1871.73, 238.699, 62.2751, 2.6509, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+3, 31576, 0, 0, 0, 1, 64, 0, 0, 1863.21, 234.608, 62.2751, 3.49363, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+4, 31576, 0, 0, 0, 1, 64, 0, 0, 1854.89, 229.172, 62.2751, 1.80895, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+5, 31576, 0, 0, 0, 1, 64, 0, 0, 1855.02, 236.031, 62.2751, 1.55134, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+6, 31576, 0, 0, 0, 1, 64, 0, 0, 1855.15, 242.756, 62.2753, 1.55134, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+7, 31576, 0, 0, 0, 1, 64, 0, 0, 1858.23, 248.415, 62.2758, 5.42729, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+8, 31576, 0, 0, 0, 1, 64, 0, 0, 1862.38, 246.289, 62.2752, 1.30394, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+9, 31576, 0, 0, 0, 1, 64, 0, 0, 1865.23, 238.806, 62.2752, 2.81191, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+10, 31576, 0, 0, 0, 1, 64, 0, 0, 1877.96, 240.234, 59.9565, 0.438431, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+11, 31576, 0, 0, 0, 1, 64, 0, 0, 1859.32, 227.461, 62.2753, 3.59809, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+12, 31576, 0, 0, 0, 1, 64, 0, 0, 1841.62, 240.558, 62.2522, 2.5056, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+13, 31576, 0, 0, 0, 1, 64, 0, 0, 1842.92, 237.159, 62.2752, 2.03122, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+14, 31576, 0, 0, 0, 1, 64, 0, 0, 1849.7, 238.891, 62.2752, 0.249935, 480, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+15, 31576, 0, 0, 0, 1, 64, 0, 0, 1823.08, 222.426, 60.317, 4.39368, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+16, 31576, 0, 0, 0, 1, 64, 0, 0, 1812.59, 225.765, 59.7123, 3.26664, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+17, 31576, 0, 0, 0, 1, 64, 0, 0, 1798.05, 221.197, 61.3544, 3.66483, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+18, 31576, 0, 0, 0, 1, 64, 0, 0, 1790.04, 216.575, 59.9411, 3.66483, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+19, 31576, 0, 0, 0, 1, 64, 0, 0, 1783.97, 213.077, 59.7476, 3.66483, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+20, 31576, 0, 0, 0, 1, 64, 0, 0, 1778.68, 217.262, 59.718, 1.50656, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+21, 31576, 0, 0, 0, 1, 64, 0, 0, 1783.82, 222.802, 59.5176, 0.363804, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+22, 31576, 0, 0, 0, 1, 64, 0, 0, 1788.33, 227.829, 59.5589, 1.97544, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+23, 31576, 0, 0, 0, 1, 64, 0, 0, 1784.93, 231.663, 59.7863, 3.07343, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+24, 31576, 0, 0, 0, 1, 64, 0, 0, 1777.94, 232.14, 60.1759, 3.07343, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+25, 31576, 0, 0, 0, 1, 64, 0, 0, 1773.18, 231.968, 60.3793, 3.3114, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+26, 31576, 0, 0, 0, 1, 64, 0, 0, 1763.73, 237.786, 60.9243, 3.07579, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+27, 31576, 0, 0, 0, 1, 64, 0, 0, 1756.74, 238.246, 61.223, 3.07579, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+28, 31576, 0, 0, 0, 1, 64, 0, 0, 1746.56, 232.499, 61.8146, 4.09837, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+29, 31576, 0, 0, 0, 1, 64, 0, 0, 1746.06, 231.327, 62.1128, 4.52956, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+30, 31576, 0, 0, 0, 1, 64, 0, 0, 1744.3, 225.265, 62.0763, 3.86275, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+31, 31576, 0, 0, 0, 1, 64, 0, 0, 1741.67, 222.954, 62.044, 3.86275, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+32, 31576, 0, 0, 0, 1, 64, 0, 0, 1737.98, 219.714, 61.9661, 3.86275, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+33, 31576, 0, 0, 0, 1, 64, 0, 0, 1737.98, 219.714, 61.9661, 3.86275, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+34, 31576, 0, 0, 0, 1, 64, 0, 0, 1734.71, 219.279, 62.0795, 2.68466, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+35, 31576, 0, 0, 0, 1, 64, 0, 0, 1733.06, 222.136, 62.4888, 1.50656, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+36, 31576, 0, 0, 0, 1, 64, 0, 0, 1740.24, 230.244, 62.3222, 1.39817, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+37, 31576, 0, 0, 0, 1, 64, 0, 0, 1740.93, 234.846, 62.439, 1.67149, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+38, 31576, 0, 0, 0, 1, 64, 0, 0, 1741.74, 244.187, 62.1851, 1.23795, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+39, 31576, 0, 0, 0, 1, 64, 0, 0, 1744.03, 250.8, 62.0583, 1.23795, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+40, 31576, 0, 0, 0, 1, 64, 0, 0, 1742.58, 257.486, 61.9118, 3.0051, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+41, 31576, 0, 0, 0, 1, 64, 0, 0, 1738.42, 258.057, 61.978, 3.0051, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+42, 31576, 0, 0, 0, 1, 64, 0, 0, 1738.42, 258.057, 61.978, 3.0051, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+43, 31576, 0, 0, 0, 1, 64, 0, 0, 1734.44, 262.346, 62.1117, 2.14038, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+44, 31576, 0, 0, 0, 1, 64, 0, 0, 1768.98, 239.185, 60.8268, 0.0584733, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+45, 31576, 0, 0, 0, 1, 64, 0, 0, 1776.19, 241.782, 60.6032, 1.35674, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+46, 31576, 0, 0, 0, 1, 64, 0, 0, 1777, 248.167, 60.1396, 1.98348, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+47, 31576, 0, 0, 0, 1, 64, 0, 0, 1775.32, 253.42, 59.7834, 1.35674, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+48, 31576, 0, 0, 0, 1, 64, 0, 0, 1776.81, 260.261, 59.5558, 1.35674, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+49, 31576, 0, 0, 0, 1, 64, 0, 0, 1778.68, 265.538, 59.8382, 0.649878, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+50, 31576, 0, 0, 0, 1, 64, 0, 0, 1783.05, 268.377, 59.6135, 0.138584, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+51, 31576, 0, 0, 0, 1, 64, 0, 0, 1789.48, 267.423, 59.6221, 5.24367, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+52, 31576, 0, 0, 0, 1, 64, 0, 0, 1789.67, 262.224, 59.6186, 4.02081, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+53, 31576, 0, 0, 0, 1, 64, 0, 0, 1786.62, 258.541, 59.5238, 4.02081, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+54, 31576, 0, 0, 0, 1, 64, 0, 0, 1786.49, 251.731, 59.4535, 4.60986, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+55, 31576, 0, 0, 0, 1, 64, 0, 0, 1785.77, 244.768, 59.8426, 4.60986, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+56, 31576, 0, 0, 0, 1, 64, 0, 0, 1785.35, 240.702, 60.4073, 4.60986, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+57, 31576, 0, 0, 0, 1, 64, 0, 0, 1794.47, 246.206, 60.3204, 1.53974, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+58, 31576, 0, 0, 0, 1, 64, 0, 0, 1797.73, 254.984, 59.8279, 0.832876, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+59, 31576, 0, 0, 0, 1, 64, 0, 0, 1810.96, 257.323, 59.9768, 6.25369, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+60, 31576, 0, 0, 0, 1, 64, 0, 0, 1816.65, 258.938, 60.0562, 1.12976, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+61, 31576, 0, 0, 0, 1, 64, 0, 0, 1819.64, 265.263, 59.9507, 1.12976, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+62, 31576, 0, 0, 0, 1, 64, 0, 0, 1823.2, 269.927, 60.2139, 0.187279, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+63, 31576, 0, 0, 0, 1, 64, 0, 0, 1829.72, 270.662, 59.9834, 5.85314, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+64, 31576, 0, 0, 0, 1, 64, 0, 0, 1834.98, 264.464, 59.9598, 4.12369, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+65, 31576, 0, 0, 0, 1, 64, 0, 0, 1831.66, 259.237, 59.6257, 4.44178, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+66, 31576, 0, 0, 0, 1, 64, 0, 0, 1829.79, 252.492, 59.7142, 4.44178, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+67, 31576, 0, 0, 0, 1, 64, 0, 0, 1828.86, 249.119, 59.9189, 4.44178, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+68, 31576, 0, 0, 0, 1, 64, 0, 0, 1827.86, 241.552, 60.3116, 4.71746, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+69, 31576, 0, 0, 0, 1, 64, 0, 0, 1827.9, 234.552, 60.5472, 4.71746, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+70, 31576, 0, 0, 0, 1, 64, 0, 0, 1828.01, 229.652, 60.2061, 4.95307, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+71, 31576, 0, 0, 0, 1, 64, 0, 0, 1829.67, 222.854, 60.6297, 4.95307, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+72, 31576, 0, 0, 0, 1, 64, 0, 0, 1831.22, 215.795, 60.3681, 4.59965, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+73, 31576, 0, 0, 0, 1, 64, 0, 0, 1829.98, 210.553, 60.2592, 3.92813, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+74, 31576, 0, 0, 0, 1, 64, 0, 0, 1826.98, 208.253, 60.0893, 3.34144, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+75, 31576, 0, 0, 0, 1, 64, 0, 0, 1823.55, 207.558, 59.9448, 3.34144, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+76, 31576, 0, 0, 0, 1, 64, 0, 0, 1808.84, 204.643, 60.3994, 3.13645, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+77, 31576, 0, 0, 0, 1, 64, 0, 0, 1819.93, 212.898, 61.466, 0.748837, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+78, 31576, 0, 0, 0, 1, 64, 0, 0, 1814.87, 219.419, 59.6503, 3.10582, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+79, 31576, 0, 0, 0, 1, 64, 0, 0, 1818.59, 232.166, 59.8028, 0.46845, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+80, 31576, 0, 0, 0, 1, 64, 0, 0, 1819.01, 243.888, 60.0049, 1.70153, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+81, 31576, 0, 0, 0, 1, 64, 0, 0, 1821.36, 253.183, 60.02, 0.874501, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+82, 31576, 0, 0, 0, 1, 64, 0, 0, 1823.6, 255.991, 59.9793, 1.11012, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+83, 31576, 0, 0, 0, 1, 64, 0, 0, 1825.97, 261.886, 59.8165, 1.69681, 300, 0, 0, 5342, 0, 0, 0, 33554688, 0, 0),
(@CGUID+84, 31577, 0, 0, 0, 1, 64, 0, 0, 1806.04, 222.459, 60.302, 4.59494, 300, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+85, 31577, 0, 0, 0, 1, 64, 0, 0, 1785.33, 224.625, 59.3333, 3.46711, 300, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+86, 31577, 0, 0, 0, 1, 64, 0, 0, 1783.18, 255.054, 59.5311, 1.57352, 300, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+87, 31577, 0, 0, 0, 1, 64, 0, 0, 1824.48, 255.662, 59.9497, 0.0419888, 300, 0, 0, 42, 0, 0, 0, 33554432, 0, 0),
(@CGUID+88, 31577, 0, 0, 0, 1, 64, 0, 0, 1827.12, 223.765, 60.4512, 4.76066, 300, 0, 0, 42, 0, 0, 0, 33554432, 0, 0);

-- movement for plaguebunnies
UPDATE `creature` SET `spawndist`=3,`MovementType`=1, `spawntimesecs`=900 WHERE `id` IN (31576);
UPDATE `creature` SET `spawndist`=3,`MovementType`=1, `spawntimesecs`=15 WHERE `id` IN (31577);
-- gameobjectspawns
DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+90;
DELETE FROM `gameobject` WHERE `id` IN (193427, 193411, 194935);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES 
(@OGUID+0, 193427, 0, 0, 0, 1, 64, 1960.43, 235.696, 40.3143, 3.18104, 0, 0, 0.999806, -0.0197224, 300, 0, 1, 0),
(@OGUID+1, 193411, 0, 0, 0, 1, 64, 1878.28, 232.168, 84.6498, 3.23287, 0, 0, 0.998959, -0.045624, 300, 0, 1, 0),
(@OGUID+2, 193411, 0, 0, 0, 1, 64, 1874.24, 246.454, 82.7732, 3.14255, 0, 0, 1, -0.000479384, 300, 0, 1, 0),
(@OGUID+3, 193411, 0, 0, 0, 1, 64, 1874.09, 229.207, 75.3687, 3.18968, 0, 0, 0.999711, -0.0240432, 300, 0, 1, 0),
(@OGUID+4, 193411, 0, 0, 0, 1, 64, 1874.23, 245.847, 67.2015, 3.20146, 0, 0, 0.999552, -0.0299315, 300, 0, 1, 0),
(@OGUID+5, 193411, 0, 0, 0, 1, 64, 1874.28, 237.972, 93.9793, 3.42138, 0, 0, 0.990231, -0.139436, 300, 0, 1, 0),
(@OGUID+6, 193411, 0, 0, 0, 1, 64, 1876.28, 230.714, 100.723, 3.03889, 0, 0, 0.998682, 0.0513306, 300, 0, 1, 0),
(@OGUID+7, 193411, 0, 0, 0, 1, 64, 1873.18, 235.87, 101.615, 1.45238, 0, 0, 0.664025, 0.74771, 300, 0, 1, 0),
(@OGUID+8, 193411, 0, 0, 0, 1, 64, 1874.23, 245.683, 89.8034, 2.88573, 0, 0, 0.991828, 0.127582, 300, 0, 1, 0),
(@OGUID+9, 193411, 0, 0, 0, 1, 64, 1874.23, 245.683, 89.8034, 2.88573, 0, 0, 0.991828, 0.127582, 300, 0, 1, 0),
(@OGUID+10, 193411, 0, 0, 0, 1, 64, 1874.58, 226.272, 60.8, 3.19597, 0, 0, 0.99963, -0.0271832, 300, 0, 1, 0),
(@OGUID+11, 193427, 0, 0, 0, 1, 64, 1946.1, 276.333, 40.703, 3.65542, 0, 0, 0.967178, -0.254099, 300, 0, 1, 0),
(@OGUID+12, 194935, 0, 0, 0, 1, 64, 1624.92, 257.038, 62.594, 5.46731, 0, 0, 0.396718, -0.917941, 300, 0, 1, 0),
(@OGUID+13, 194935, 0, 0, 0, 1, 64, 1595.75, 253.342, 60.1496, 4.72117, 0, 0, 0.703994, -0.710205, 300, 0, 1, 0),
(@OGUID+14, 194935, 0, 0, 0, 1, 64, 1595.74, 227.646, 60.1496, 1.5678, 0, 0, 0.706046, 0.708166, 300, 0, 1, 0),
(@OGUID+15, 194935, 0, 0, 0, 1, 64, 1609.64, 248.736, 60.1426, 3.83446, 0, 0, 0.94059, -0.339545, 300, 0, 1, 0),
(@OGUID+16 , 193411, 0, 0, 0, 1, 64, 1453.42, 335.493, -62.5174, 4.05461, 0, 0, 0.897596, -0.440818, 300, 0, 1, 0),
(@OGUID+17 , 193411, 0, 0, 0, 1, 64, 1456.89, 364.333, -59.4405, 1.5649, 0, 0, 0.705019, 0.709188, 300, 0, 1, 0),
(@OGUID+18 , 193411, 0, 0, 0, 1, 64, 1481.88, 388.683, -62.1856, 2.13824, 0, 0, 0.876778, 0.480895, 300, 0, 1, 0),
(@OGUID+19 , 193411, 0, 0, 0, 1, 64, 1511.52, 401.505, -61.2111, 5.1581, 0, 0, 0.533339, -0.845902, 300, 0, 1, 0),
(@OGUID+20 , 193411, 0, 0, 0, 1, 64, 1506.84, 346.802, -60.0886, 2.75871, 0, 0, 0.981731, 0.190274, 300, 0, 1, 0),
(@OGUID+21 , 193411, 0, 0, 0, 1, 64, 1477.54, 307.085, -61.5058, 2.61734, 0, 0, 0.965841, 0.259135, 300, 0, 1, 0),
(@OGUID+22 , 193411, 0, 0, 0, 1, 64, 1543.57, 355.802, -62.1968, 3.74439, 0, 0, 0.954922, -0.296855, 300, 0, 1, 0),
(@OGUID+23 , 193411, 0, 0, 0, 1, 64, 1540.32, 353.585, -56.6931, 1.53742, 0, 0, 0.695208, 0.718809, 300, 0, 1, 0),
(@OGUID+24 , 193411, 0, 0, 0, 1, 64, 1601.04, 378.756, -62.1777, 0.991561, 0, 0, 0.475718, 0.879598, 300, 0, 1, 0),
(@OGUID+25 , 193411, 0, 0, 0, 1, 64, 1603.98, 379.611, -62.1777, 1.46673, 0, 0, 0.669372, 0.742927, 300, 0, 1, 0),
(@OGUID+26 , 193411, 0, 0, 0, 1, 64, 1604.17, 383.102, -57.9169, 0.539957, 0, 0, 0.266711, 0.963777, 300, 0, 1, 0),
(@OGUID+27 , 193411, 0, 0, 0, 1, 64, 1568.78, 412.155, -61.1779, 5.20444, 0, 0, 0.513598, -0.858031, 300, 0, 1, 0),
(@OGUID+28 , 193411, 0, 0, 0, 1, 64, 1602.7, 353.503, -53.858, 5.8249, 0, 0, 0.227142, -0.973862, 300, 0, 1, 0),
(@OGUID+29 , 193411, 0, 0, 0, 1, 64, 1590.49, 330.835, -52.9793, 3.46086, 0, 0, 0.987286, -0.158956, 300, 0, 1, 0),
(@OGUID+30 , 193411, 0, 0, 0, 1, 64, 1590.81, 292.303, -62.1775, 4.28945, 0, 0, 0.839774, -0.542937, 300, 0, 1, 0),
(@OGUID+31 , 193411, 0, 0, 0, 1, 64, 1602.23, 294.641, -62.1775, 4.529, 0, 0, 0.768884, -0.639388, 300, 0, 1, 0),
(@OGUID+32 , 193411, 0, 0, 0, 1, 64, 1602.23, 294.641, -62.1775, 4.529, 0, 0, 0.768884, -0.639388, 300, 0, 1, 0),
(@OGUID+33 , 193411, 0, 0, 0, 1, 64, 1607.56, 290.896, -56.8781, 4.54471, 0, 0, 0.763837, -0.64541, 300, 0, 1, 0),
(@OGUID+34 , 193411, 0, 0, 0, 1, 64, 1614.51, 298.322, -56.8781, 0.853339, 0, 0, 0.413841, 0.910349, 300, 0, 1, 0),
(@OGUID+35 , 193411, 0, 0, 0, 1, 64, 1660.16, 285.825, -62.1776, 0.625572, 0, 0, 0.307711, 0.95148, 300, 0, 1, 0),
(@OGUID+36 , 193411, 0, 0, 0, 1, 64, 1531.4, 285.285, -60.7004, 3.17812, 0, 0, 0.999833, -0.0182612, 300, 0, 1, 0),
(@OGUID+37 , 193411, 0, 0, 0, 1, 64, 1528.29, 281.747, -57.7498, 5.65605, 0, 0, 0.308456, -0.951239, 300, 0, 1, 0),
(@OGUID+38 , 193411, 0, 0, 0, 1, 64, 1537.88, 259.074, -55.5924, 2.54587, 0, 0, 0.955967, 0.293475, 300, 0, 1, 0),
(@OGUID+39 , 193411, 0, 0, 0, 1, 64, 1544.71, 253.619, -56.8771, 5.65998, 0, 0, 0.306586, -0.951843, 300, 0, 1, 0),
(@OGUID+40 , 193411, 0, 0, 0, 1, 64, 1584.04, 299.732, -54.4093, 4.33658, 0, 0, 0.826748, -0.562573, 300, 0, 1, 0),
(@OGUID+41 , 193411, 0, 0, 0, 1, 64, 1582.81, 291.267, -55.0051, 4.5722, 0, 0, 0.754895, -0.655846, 300, 0, 1, 0),
(@OGUID+42 , 193411, 0, 0, 0, 1, 64, 1541.92, 291.825, -62.1813, 2.23957, 0, 0, 0.900006, 0.435878, 300, 0, 1, 0),
(@OGUID+43 , 193411, 0, 0, 0, 1, 64, 1604.12, 278.389, -55.3429, 0.499907, 0, 0, 0.247359, 0.968924, 300, 0, 1, 0),
(@OGUID+44 , 193411, 0, 0, 0, 1, 64, 1592.44, 239.817, -52.1429, 2.90715, 0, 0, 0.993138, 0.116952, 300, 0, 1, 0),
(@OGUID+45 , 193411, 0, 0, 0, 1, 64, 1594.89, 243.881, -50.6695, 0.562737, 0, 0, 0.277671, 0.960676, 300, 0, 1, 0),
(@OGUID+46 , 193411, 0, 0, 0, 1, 64, 1602.41, 239.384, -50.6731, 2.96999, 0, 0, 0.996321, 0.0856981, 300, 0, 1, 0),
(@OGUID+47 , 193411, 0, 0, 0, 1, 64, 1595.21, 234.96, -51.1047, 1.56412, 0, 0, 0.704744, 0.709462, 300, 0, 1, 0),
(@OGUID+48 , 193411, 0, 0, 0, 1, 64, 1586.99, 247.438, -45.8725, 0.16219, 0, 0, 0.0810061, 0.996714, 300, 0, 1, 0),
(@OGUID+49 , 193411, 0, 0, 0, 1, 64, 1586.15, 232.445, -45.4211, 5.65212, 0, 0, 0.310322, -0.950632, 300, 0, 1, 0),
(@OGUID+50 , 193411, 0, 0, 0, 1, 64, 1569.47, 233.672, -43.9897, 4.67823, 0, 0, 0.71908, -0.694927, 300, 0, 1, 0),
(@OGUID+51 , 193411, 0, 0, 0, 1, 64, 1553.55, 261.757, -40.9026, 2.51839, 0, 0, 0.951843, 0.306585, 300, 0, 1, 0),
(@OGUID+52 , 193411, 0, 0, 0, 1, 64, 1578.84, 273.595, -43.1027, 0.719825, 0, 0, 0.352192, 0.935928, 300, 0, 1, 0),
(@OGUID+53 , 193411, 0, 0, 0, 1, 64, 1595.94, 280.278, -43.1027, 0.433154, 0, 0, 0.214888, 0.976639, 300, 0, 1, 0),
(@OGUID+54 , 193411, 0, 0, 0, 1, 64, 1615.92, 279.471, -43.1027, 0.904388, 0, 0, 0.43694, 0.899491, 300, 0, 1, 0),
(@OGUID+55 , 193411, 0, 0, 0, 1, 64, 1567.56, 208.686, -43.1022, 5.05914, 0, 0, 0.574523, -0.818488, 300, 0, 1, 0),
(@OGUID+56 , 193411, 0, 0, 0, 1, 64, 1599.55, 201.64, -43.1022, 6.06052, 0, 0, 0.111102, -0.993809, 300, 0, 1, 0),
(@OGUID+57 , 193411, 0, 0, 0, 1, 64, 1622.07, 208.441, -43.1022, 0.405655, 0, 0, 0.20144, 0.979501, 300, 0, 1, 0),
(@OGUID+58 , 193411, 0, 0, 0, 1, 64, 1629.86, 220.241, -43.1022, 1.16356, 0, 0, 0.549514, 0.835485, 300, 0, 1, 0),
(@OGUID+59 , 193411, 0, 0, 0, 1, 64, 1634.62, 243.272, -43.1022, 1.41489, 0, 0, 0.649895, 0.760024, 300, 0, 1, 0),
(@OGUID+60 , 193411, 0, 0, 0, 1, 64, 1629.99, 261.306, -43.1022, 1.94111, 0, 0, 0.825199, 0.564842, 300, 0, 1, 0),
(@OGUID+61 , 193411, 0, 0, 0, 1, 64, 1589.92, 240.086, -27.6796, 0.456706, 0, 0, 0.226374, 0.974041, 300, 0, 1, 0),
(@OGUID+62 , 193411, 0, 0, 0, 1, 64, 1587.86, 237.634, -36.8898, 0.362458, 0, 0, 0.180238, 0.983623, 300, 0, 1, 0),
(@OGUID+63 , 193411, 0, 0, 0, 1, 64, 1587.47, 277.012, -55.343, 2.29061, 0, 0, 0.910836, 0.412768, 300, 0, 1, 0),
(@OGUID+64 , 193411, 0, 0, 0, 1, 64, 1548.18, 242.907, -41.3605, 0.433146, 0, 0, 0.214884, 0.97664, 300, 0, 1, 0),
(@OGUID+65 , 193411, 0, 0, 0, 1, 64, 1544.82, 244.546, -41.3605, 6.14613, 0, 0, 0.068473, -0.997653, 300, 0, 1, 0),
(@OGUID+66 , 193411, 0, 0, 0, 1, 64, 1540.88, 244.103, -41.3605, 0.923235, 0, 0, 0.445397, 0.895333, 300, 0, 1, 0),
(@OGUID+67 , 193411, 0, 0, 0, 1, 64, 1538.84, 239.788, -41.3605, 1.98352, 0, 0, 0.836991, 0.547217, 300, 0, 1, 0),
(@OGUID+68 , 193411, 0, 0, 0, 1, 64, 1542.63, 235.411, -41.3605, 3.04617, 0, 0, 0.998862, 0.0476949, 300, 0, 1, 0),
(@OGUID+69 , 193411, 0, 0, 0, 1, 64, 1547.68, 237.42, -41.3605, 4.18185, 0, 0, 0.867755, -0.496993, 300, 0, 1, 0),
(@OGUID+70 , 193411, 0, 0, 0, 1, 64, 1805.84, 296.901, 70.398, 1.58611, 0, 0, 0.712501, 0.701671, 300, 0, 1, 0),
(@OGUID+71 , 193411, 0, 0, 0, 1, 64, 1761.15, 276.338, 74.0143, 5.78013, 0, 0, 0.248882, -0.968534, 300, 0, 1, 0),
(@OGUID+72 , 193411, 0, 0, 0, 1, 64, 1775.15, 274.509, 71.9973, 1.4251, 0, 0, 0.653765, 0.756697, 300, 0, 1, 0),
(@OGUID+73 , 193411, 0, 0, 0, 1, 64, 1787.44, 275.035, 74.4691, 0.148827, 0, 0, 0.0743447, 0.997233, 300, 0, 1, 0),
(@OGUID+74 , 193411, 0, 0, 0, 1, 64, 1836.57, 274.92, 73.3538, 6.01182, 0, 0, 0.135266, -0.990809, 300, 0, 1, 0),
(@OGUID+75 , 193411, 0, 0, 0, 1, 64, 1839.66, 265.901, 73.3537, 3.40431, 0, 0, 0.991385, -0.130979, 300, 0, 1, 0),
(@OGUID+76 , 193411, 0, 0, 0, 1, 64, 1765.9, 223.609, 64.2024, 1.52328, 0, 0, 0.690108, 0.723707, 300, 0, 1, 0),
(@OGUID+77 , 193411, 0, 0, 0, 1, 64, 1763.4, 232.135, 66.073, 2.14767, 0, 0, 0.879035, 0.476757, 300, 0, 1, 0),
(@OGUID+78 , 193411, 0, 0, 0, 1, 64, 1763.15, 244.945, 65.5851, 0.812492, 0, 0, 0.395164, 0.918611, 300, 0, 1, 0),
(@OGUID+79 , 193411, 0, 0, 0, 1, 64, 1807.3, 238.017, 62.7538, 1.41725, 0, 0, 0.65079, 0.759257, 300, 0, 1, 0),
(@OGUID+80 , 193411, 0, 0, 0, 1, 64, 1835.5, 201.512, 73.3537, 3.04303, 0, 0, 0.998786, 0.0492627, 300, 0, 1, 0),
(@OGUID+81 , 193411, 0, 0, 0, 1, 64, 1822.18, 201.616, 73.3546, 2.52466, 0, 0, 0.952801, 0.303596, 300, 0, 1, 0),
(@OGUID+82 , 193411, 0, 0, 0, 1, 64, 1774.42, 202.03, 73.3536, 3.11371, 0, 0, 0.999903, 0.013939, 300, 0, 1, 0),
(@OGUID+83 , 193411, 0, 0, 0, 1, 64, 1760.38, 201.995, 73.3546, 3.2433, 0, 0, 0.998707, -0.050834, 300, 0, 1, 0),
(@OGUID+84 , 193411, 0, 0, 0, 1, 64, 1747.98, 189.804, 73.3024, 3.95016, 0, 0, 0.919384, -0.393362, 300, 0, 1, 0),
(@OGUID+85 , 193411, 0, 0, 0, 1, 64, 1747.06, 176.08, 73.3033, 5.39529, 0, 0, 0.429507, -0.903063, 300, 0, 1, 0),
(@OGUID+86 , 193411, 0, 0, 0, 1, 64, 1807.86, 178.109, 70.3984, 4.79838, 0, 0, 0.676061, -0.736846, 300, 0, 1, 0),
(@OGUID+87 , 193411, 0, 0, 0, 1, 64, 1803.19, 178.182, 70.3984, 4.67664, 0, 0, 0.719631, -0.694356, 300, 0, 1, 0),
(@OGUID+88 , 193411, 0, 0, 0, 1, 64, 1843.8, 235.629, 102.325, 0.553304, 0, 0, 0.273136, 0.961975, 300, 0, 1, 0),
(@OGUID+89 , 193411, 0, 0, 0, 1, 64, 1841.7, 234.17, 100.13, 1.05596, 0, 0, 0.503789, 0.863827, 300, 0, 1, 0),
(@OGUID+90 , 193411, 0, 0, 0, 1, 64, 1877.61, 252.04, 65.048, 2.79169, 0, 0, 0.984735, 0.17406, 300, 0, 1, 0);

-- go flags
UPDATE `gameobject_template_addon` SET `flags`=4 WHERE  `entry`=194935;

-- scriptassignments
UPDATE `creature_template` SET `ScriptName`='npc_lady_sylvanas_windrunner_bfu' WHERE  `entry`=32365;
UPDATE `creature_template` SET `ScriptName`='npc_thrall_bfu' WHERE  `entry`=32518;

-- npcflags
UPDATE `creature_template` SET `npcflag` = 2 WHERE `entry` = 32518;

-- questflags
UPDATE `quest_template_addon` SET `SpecialFlags`=2 WHERE  `Id`=13267;

-- spelltargetposition
DELETE FROM `spell_target_position` WHERE `id` IN (56347, 60699);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(56347, 0, 0, 1289.48, 314.33, -57.32, 01.03, 0),
(60699, 0, 1, 1179.797, -4148.077, 51.916, 0.434, 0);

-- waypoints thrall
DELETE FROM `script_waypoint` WHERE `entry`=32518;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES 
(32518, 1, 1944.73, 234.148, 44.0474, 3000, 'Thrall Bfu'),
(32518, 2, 1888.247, 236.373, 57.508, 0, 'Thrall Bfu'),
(32518, 3, 1877.9, 237.556, 59.9718, 0, 'Thrall Bfu'), 
(32518, 4, 1874.54, 237.608, 62.2752, 0, 'Thrall Bfu'), 
(32518, 5, 1874.54, 237.608, 62.2752, 0, 'Thrall Bfu'), 
(32518, 6, 1863.62, 237.778, 62.2752, 0, 'Thrall Bfu'), 
(32518, 7, 1862.67, 246.532, 62.2752, 0, 'Thrall Bfu'), 
(32518, 8, 1860.18, 248.416, 62.2752, 0, 'Thrall Bfu'), 
(32518, 9, 1854.9, 247.92, 62.2752, 0, 'Thrall Bfu'), 
(32518, 10, 1853.17, 239.223, 62.2752, 0, 'Thrall Bfu'), 
(32518, 11, 1844.23, 238.472, 62.2752, 0, 'Thrall Bfu'),
(32518, 12, 1817.080, 249.271, 59.974, 0, 'Thrall Bfu'),
(32518, 13, 1793.462, 238.152, 60.585, 0, 'Thrall Bfu'),
(32518, 14, 1767.57, 239.055, 60.8451, 0, 'Thrall Bfu'),
(32518, 15, 1743.4, 239.431, 62.1031, 0, 'Thrall Bfu'),
(32518, 16, 1740.37, 222.003, 62.0531, 0, 'Thrall Bfu'),
(32518, 17, 1720.72, 220.516, 64.2658, 0, 'Thrall Bfu'),
(32518, 18, 1719.71, 226.973, 64.2641, 0, 'Thrall Bfu'),
(32518, 19, 1717.66, 234.643, 62.5978, 0, 'Thrall Bfu'),
(32518, 20, 1706.27, 239.379, 62.5978, 0, 'Thrall Bfu'),
(32518, 21, 1685.27, 239.077, 62.5964, 0, 'Thrall Bfu'),
(32518, 22, 1666.84, 239.806, 62.5964, 0, 'Thrall Bfu'),
(32518, 23, 1641.9, 239.951, 62.592, 0, 'Thrall Bfu'),
(32518, 24, 1620.67, 218.871, 62.5944, 0, 'Thrall Bfu'),
(32518, 25, 1617.78, 221.925, 62.5944, 0, 'Thrall Bfu'),
(32518, 26, 1611.24, 228.911, 60.1416, 0, 'Thrall Bfu'),
(32518, 27, 1608.78, 231.429, 60.1416, 0, 'Thrall Bfu'),
(32518, 28, 1604.46, 234.916, 60.1492, 0, 'Thrall Bfu'),
(32518, 29, 1595.82, 235.367, 60.1492, 0, 'Thrall Bfu'),
(32518, 30, 1586.86, 240.629, 60.1492, 0, 'Thrall Bfu'),
(32518, 31, 1578.68, 240.715, 60.1492, 0, 'Thrall Bfu'),
(32518, 32, 1575.42, 240.69, 60.1492, 0, 'Thrall Bfu'),
(32518, 33, 1563.03, 240.533, 55.2408, 0, 'Thrall Bfu'),
(32518, 34, 1558.878, 240.572,  55.240, 0, 'Thrall Bfu'),
-- after jump
(32518, 35, 1533.33, 240.758, -41.3781, 0, 'Thrall Bfu'),
(32518, 36, 1524.34, 240.821, -41.3899, 0, 'Thrall Bfu'),
(32518, 37, 1525.55, 235.061, -41.3899, 0, 'Thrall Bfu'),
(32518, 38, 1526.56, 228.133, -42.0445, 0, 'Thrall Bfu'),
(32518, 39, 1528.63, 218.123, -43.0565, 0, 'Thrall Bfu'),
(32518, 40, 1530.71, 213.419, -43.0565, 0, 'Thrall Bfu'),
(32518, 41, 1538.71, 216.271, -43.0565, 0, 'Thrall Bfu'),
(32518, 42, 1547.72, 220.016, -43.0764, 0, 'Thrall Bfu'),
(32518, 43, 1556.59, 224.959, -43.1031, 0, 'Thrall Bfu'),
(32518, 44, 1558.63, 229.165, -43.1031, 0, 'Thrall Bfu'),
(32518, 45, 1558.56, 241.733, -43.1031, 0, 'Thrall Bfu'),
(32518, 46, 1560.21, 240.862, -43.1031, 0, 'Thrall Bfu'),
-- stairs up - till stairs down left
(32518, 47, 1569.45, 240.298, -44.7601, 0, 'Thrall Bfu'),
(32518, 48, 1586.3, 240.669, -52.1491, 0, 'Thrall Bfu'),
(32518, 49, 1587.33, 248.973, -52.1506, 0, 'Thrall Bfu'),
(32518, 50, 1595.64, 248.381, -52.151, 0, 'Thrall Bfu'),
(32518, 51, 1596.16, 260.392, -57.1616, 0, 'Thrall Bfu'),
(32518, 52, 1585.79, 257.402, -62.1597, 0, 'Thrall Bfu'),
(32518, 53, 1585.79, 257.402, -62.1597, 0, 'Thrall Bfu'),
(32518, 54, 1581.01, 255.52, -61.9069, 0, 'Thrall Bfu'),
(32518, 55, 1573.75, 262.775, -59.0779, 0, 'Thrall Bfu'),
(32518, 56, 1565.8, 270.507, -60.7023, 0, 'Thrall Bfu'),
(32518, 57, 1553.21, 283.393, -60.7715, 0, 'Thrall Bfu'),
-- stair down left - till stair down right
(32518, 58, 1545.87, 289.971, -62.1821, 0, 'Thrall Bfu'),
(32518, 59, 1572.38, 305.229, -62.1792, 0, 'Thrall Bfu'),
(32518, 60, 1596.81, 308.933, -62.1791, 0, 'Thrall Bfu'),
(32518, 61, 1596.4, 321.779, -62.1791, 0, 'Thrall Bfu'),
-- stair down right - till Khanok Point
(32518, 62, 1596.47, 346.992, -62.1791, 0, 'Thrall Bfu'),
(32518, 63, 1596.93, 368.347, -62.1791, 0, 'Thrall Bfu'),
(32518, 64, 1589.06, 376.615, -62.1791, 0, 'Thrall Bfu'),
(32518, 65, 1589.17, 382.068, -62.1791, 0, 'Thrall Bfu'),
-- won Khanok announce point
(32518, 66, 1570.40, 374.489, -62.177, 0, 'Thrall Bfu'),
-- announcepoint - till front of chamber
(32518, 67, 1560.69, 372.194, -61.62, 0, 'Thrall Bfu'),
(32518, 68, 1546.51, 369.277, -62.1819, 0, 'Thrall Bfu'),
(32518, 69, 1537.62, 367.669, -62.1807, 0, 'Thrall Bfu'),
(32518, 70, 1530.31, 363.665, -57.1518, 0, 'Thrall Bfu'),
(32518, 71, 1527.01, 361.818, -57.1518, 0, 'Thrall Bfu'),
(32518, 72, 1523.22, 368.423, -54.6721, 0, 'Thrall Bfu'),
(32518, 73, 1518.85, 374.974, -51.0651, 0, 'Thrall Bfu'),
(32518, 74, 1514.82, 382.375, -52.2415, 0, 'Thrall Bfu'),
(32518, 75, 1510.26, 390.622, -56.9403, 0, 'Thrall Bfu'),
(32518, 76, 1509.06, 393.642, -57.1529, 0, 'Thrall Bfu'),
(32518, 77, 1505.32, 391.25, -57.1529, 0, 'Thrall Bfu'),
(32518, 78, 1498.05, 386.996, -62.2593, 0, 'Thrall Bfu'),
(32518, 79, 1487.15, 380.27, -62.1865, 0, 'Thrall Bfu'),
(32518, 80, 1472.91, 364.5, -62.1865, 0, 'Thrall Bfu'),
(32518, 81, 1468.84, 369.123, -59.4315, 0, 'Thrall Bfu'),
-- front of chamber till front of valimathras
(32518, 82, 1463.32, 375.153, -59.4508, 0, 'Thrall Bfu'),
(32518, 83, 1458.59, 380.315, -59.4218, 0, 'Thrall Bfu'),
(32518, 84, 1437.06, 403.65, -57.8186, 0, 'Thrall Bfu'),
(32518, 85, 1427.42, 413.787, -56.9018, 0, 'Thrall Bfu'),
(32518, 86, 1411.39, 428.74, -54.993, 0, 'Thrall Bfu'),
(32518, 87, 1403.69, 433.122, -54.7038, 0, 'Thrall Bfu'),
(32518, 88, 1381.07, 438.253, -52.7791, 0, 'Thrall Bfu'),
(32518, 89, 1360.36, 436.695, -54.3051, 0, 'Thrall Bfu'),
(32518, 90, 1343.09, 430.21, -56.1262, 0, 'Thrall Bfu'),
(32518, 100, 1327.67, 418.744, -59.0869, 0, 'Thrall Bfu'),
(32518, 101, 1316.95, 405.483, -61.6812, 0, 'Thrall Bfu'),
(32518, 102, 1310.51, 389.42, -64.3699, 0, 'Thrall Bfu'),
(32518, 103, 1305.78, 371.107, -67.2918, 0, 'Thrall Bfu'),
(32518, 104, 1302.32, 358.314, -67.2964, 0, 'Thrall Bfu'),
-- vitory horde
(32518, 105, 1299.57, 348.107, -65.0272, 0, 'Thrall Bfu'),
(32518, 106, 1285.4, 349.609, -65.0272, 0, 'Thrall Bfu'),
(32518, 107, 1273.32, 347.801, -65.0272, 0, 'Thrall Bfu'),
(32518, 108, 1259.2, 333.983, -65.0272, 0, 'Thrall Bfu'),
(32518, 109, 1261.74, 333.245, -65.0272, 0, 'Thrall Bfu'),
-- victory throne
(32518, 110, 1268.74, 331.421, -63.1383, 0, 'Thrall Bfu'),
(32518, 111, 1274.84, 329.833, -60.0831, 0, 'Thrall Bfu'),
(32518, 112, 1283.23, 321.748, -58.5266, 0, 'Thrall Bfu'),
(32518, 113, 1287.16, 317.115, -57.3209, 0, 'Thrall Bfu'),
-- thrall facing allaince
(32518, 114, 1291.66, 322.46, -57.762, 0, 'Thrall Bfu'),
(32518, 115, 1294.18, 331.684, -60.0831, 0, 'Thrall Bfu'),
(32518, 116, 1297.01, 342.056, -60.0831, 0, 'Thrall Bfu'),
(32518, 117, 1298.1, 346.239, -65.0275, 0, 'Thrall Bfu'),
-- left
(32518, 118, 1308.33, 346.775, -65.027, 16000, 'Thrall Bfu'),
(32518, 119, 1304.43, 348.332, -65.027, 0, 'Thrall Bfu'),
(32518, 120, 1305.80, 353.217, -66.768, 0, 'Thrall Bfu');

-- waypoint sylvanas - Spawnpoints till UC Gates
DELETE FROM `waypoint_data` WHERE `id` IN (3236500,32365000,316880,3168800,3173900);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(3236500, 1, 1888.12, 239.214, 57.5389, 0, 0, 1, 0, 100, 0),
-- waypoint sylvanas - UC Gates till Valimathras Intro
(32365000, 1, 1878.07, 236.147, 59.9309, 0, 0, 0, 0, 100, 0),
(32365000, 2, 1873.99, 236.114, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 3, 1867.68, 236.064, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 4, 1864.06, 236.035, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 5, 1861.88, 229.133, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 6, 1861.88, 229.133, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 7, 1856.69, 227.579, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 8, 1853.99, 230.695, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 9, 1853.99, 230.695, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 10, 1853.87, 236.354, 62.2753, 0, 0, 0, 0, 100, 0),
(32365000, 11, 1848.71, 236.182, 62.2753, 0, 0, 0, 0, 100, 0),
-- waypoint whirlwind spawn 1 - Spawnpoint till Valimathras Intro
(316880, 1, 1880, 237.824, 59.4729, 0, 0, 0, 0, 100, 0),
(316880, 2, 1874.53, 238.094, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 3, 1864.51, 238.45, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 4, 1863.06, 233.645, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 5, 1861.4, 228.164, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 6, 1857.78, 228.028, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 7, 1853.63, 228.254, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 8, 1853.23, 231.844, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 9, 1853.03, 237.559, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 10, 1846.6, 237.699, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 11, 1843.31, 236.508, 62.2751, 0, 0, 0, 0, 100, 0),
(316880, 12, 1834.2, 233.346, 59.9925, 0, 0, 0, 0, 100, 0),
(316880, 13, 1834.2, 233.346, 59.9925, 0, 0, 0, 0, 100, 0),
-- waypoint whirlwind spawn 2 - Spawnpoint till Valimathras Intro
(3168800, 1, 1877.77, 238.831, 60.0011, 0, 0, 0, 0, 100, 0),
(3168800, 2, 1871.82, 238.985, 62.2751, 0, 0, 0, 0, 100, 0),
(3168800, 3, 1866.11, 239.132, 62.2751, 0, 0, 0, 0, 100, 0),
(3168800, 4, 1862.72, 241.245, 62.2751, 0, 0, 0, 0, 100, 0),
(3168800, 5, 1862.38, 247.837, 62.2751, 0, 0, 0, 0, 100, 0),
(3168800, 6, 1854.69, 247.941, 62.2751, 0, 0, 0, 0, 100, 0),
(3168800, 7, 1854.02, 241.464, 62.2751, 0, 0, 0, 0, 100, 0),
(3168800, 8, 1850.92, 240.056, 62.2751, 0, 0, 0, 0, 100, 0),
(3168800, 9, 1840.91, 239.836, 61.73, 0, 0, 0, 0, 100, 0),
(3168800, 10, 1832.81, 243.255, 59.9357, 0, 0, 0, 0, 100, 0),
-- Doomguard Pillager
(3173900, 1, 1574.43, 374.9, -62.1772, 0, 0, 1, 0, 100, 0),
(3173900, 2, 1552.25, 369.544, -62.1821, 0, 0, 1, 0, 100, 0),
(3173900, 3, 1542.96, 367.098, -62.1829, 0, 0, 1, 0, 100, 0),
(3173900, 4, 1525.8, 359.98, -57.1519, 0, 0, 1, 0, 100, 0),
(3173900, 5, 1515.02, 352.861, -60.7845, 0, 0, 1, 0, 100, 0),
(3173900, 6, 1511.13, 346.368, -60.0907, 0, 0, 1, 0, 100, 0),
(3173900, 7, 1495.81, 332.048, -60.0952, 0, 0, 1, 0, 100, 0),
(3173900, 8, 1480.89, 319.797, -60.4015, 0, 0, 1, 0, 100, 0),
(3173900, 9, 1476.33, 311.81, -57.1519, 0, 0, 1, 0, 100, 0),
(3173900, 10, 1468.84, 316.665, -54.2759, 0, 0, 1, 0, 100, 0),
(3173900, 11, 1462.64, 319.917, -51.0553, 0, 0, 1, 0, 100, 0),
(3173900, 12, 1444.03, 330.492, -57.1526, 0, 0, 1, 0, 100, 0),
(3173900, 13, 1448.13, 336.164, -59.0239, 0, 0, 1, 0, 100, 0),
(3173900, 14, 1456.4, 347.434, -62.1912, 0, 0, 1, 0, 100, 0),
(3173900, 15, 1470.57, 362.915, -62.1857, 0, 0, 1, 0, 100, 0),
(3173900, 16, 1480.66, 372.619, -62.1857, 0, 0, 1, 0, 100, 0),
(3173900, 17, 1498.48, 386.491, -62.2437, 0, 0, 1, 0, 100, 0),
(3173900, 18, 1508.47, 392.468, -57.1531, 0, 0, 1, 0, 100, 0),
(3173900, 19, 1521.66, 400.009, -62.3005, 0, 0, 1, 0, 100, 0),
(3173900, 20, 1527.85, 403.27, -62.1842, 0, 0, 1, 0, 100, 0),
(3173900, 21, 1546.71, 412.482, -62.1761, 0, 0, 1, 0, 100, 0),
(3173900, 22, 1561.51, 416.615, -62.1763, 0, 0, 1, 0, 100, 0),
(3173900, 23, 1581.73, 415.636, -62.1797, 0, 0, 1, 0, 100, 0),
(3173900, 24, 1602.73, 415.015, -62.1789, 0, 0, 1, 0, 100, 0),
(3173900, 25, 1623.72, 414.409, -62.1775, 0, 0, 1, 0, 100, 0),
(3173900, 26, 1637.7, 413.801, -62.1774, 0, 0, 1, 0, 100, 0),
(3173900, 27, 1664.38, 406.381, -62.1995, 0, 0, 1, 0, 100, 0),
(3173900, 28, 1683.74, 398.242, -62.2532, 0, 0, 1, 0, 100, 0),
(3173900, 29, 1702.95, 385.963, -62.2453, 0, 0, 1, 0, 100, 0),
(3173900, 30, 1719.42, 372.958, -60.4869, 0, 0, 1, 0, 100, 0),
(3173900, 31, 1734.5, 358.384, -60.486, 0, 0, 1, 0, 100, 0),
(3173900, 32, 1746.9, 341.481, -60.4833, 0, 0, 1, 0, 100, 0),
(3173900, 33, 1757.75, 323.507, -62.245, 0, 0, 1, 0, 100, 0),
(3173900, 34, 1767.49, 299.821, -62.1544, 0, 0, 1, 0, 100, 0),
(3173900, 35, 1771.75, 279.27, -62.1764, 0, 0, 1, 0, 100, 0),
(3173900, 36, 1774.98, 258.533, -62.1764, 0, 0, 1, 0, 100, 0),
(3173900, 37, 1774.33, 237.676, -62.1764, 0, 0, 1, 0, 100, 0),
(3173900, 38, 1773.21, 223.721, -62.1764, 0, 0, 1, 0, 100, 0),
(3173900, 39, 1768.56, 191.049, -61.6204, 0, 0, 1, 0, 100, 0);


DELETE FROM `waypoints` WHERE `entry`=3215900;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(3215900, 1, 1582.04, 408.649, -33.0274, 'Doomguard Pillager'),
(3215900, 2, 1591.27, 382.782, -36.0157, 'Doomguard Pillager'),
(3215900, 3, 1626.62, 401.262, -41.3528, 'Doomguard Pillager'),
(3215900, 4, 1596.45, 409.824, -46.6646, 'Doomguard Pillager'),
(3215900, 5, 1612.5, 391.512, -55.0201, 'Doomguard Pillager'),
(3215900, 6, 1583.25, 383.358, -62.2586, 'Doomguard Pillager');

-- creature texts
DELETE FROM `creature_text` WHERE `CreatureID` IN (31739,31844,32511);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
(31739, 0, 0, 'We''ll burn it to the ground before giving it to you!', 14, 0, 100, 0, 0, 0, 32330, 'Horde Guard BfU'),
(31739, 1, 0, 'That wretch Putress won''t get away with this!', 12, 0, 100, 0, 0, 0, 32266, 'Horde Guard BfU'),
(31739, 2, 0, 'For the Horde!', 14, 0, 100, 0, 0, 0, 4921, 'Horde Guard BfU'),
(31844, 0, 0, 'YAAAAAAAARGGGGHHHHH!!!!', 14, 0, 100, 0, 0, 0, 32437, 'Blight Aberration'),
(32511, 0, 0, 'No hope for you!', 11, 0, 100, 0, 0, 0, 32545, 'Khanok');

DELETE FROM `creature_text` WHERE `CreatureID`=32277 AND `GroupID`=5;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `comment`) VALUES 
(32277, 5, 0, 'YOU HAVE FAILED ME, VARIMATHRAS!', 14, 0, 100, 0, 0, 0, 32618, 'A distant voice');

UPDATE `creature_questender` SET `id`=32518 WHERE `id`=31650 AND `quest`=13267;
UPDATE `creature_text` SET `emote`=1 WHERE  `CreatureID` IN (32401, 32402, 32518, 32365, 31565);
UPDATE `creature_template` SET `mechanic_immune_mask`=8388624 WHERE  `entry` IN (31565,31530); -- kahnok & varimathras
UPDATE `creature_template` SET `exp`=2 WHERE  `entry` IN (32365, 32402); -- sylvanas hp
UPDATE `creature_template` SET `HealthModifier`=500 WHERE  `entry`=32365;
UPDATE `creature_model_info` SET `BoundingRadius`=10, `CombatReach`=10 WHERE  `DisplayID` IN (27755, 27992, 27788); -- hitbox von (31844, 32511, 32483);
UPDATE `creature_model_info` SET `BoundingRadius`=2, `CombatReach`=2 WHERE  `DisplayID` = 27611; -- Putress
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=3 AND `SourceGroup`=1637 AND `SourceEntry`=34486;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`, `NegativeCondition`) VALUES
(3,1637,34486,0,0,1,0,60815,0,0,0,"","Do not show loot if we have aura 60815 for undercity fight", 1);

UPDATE `gameobject_template_addon` SET `flags`=`flags`|0x00000800 WHERE `entry` IN (20656, 20655, 20657);

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_undercity_buffs';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (60964, 'spell_undercity_buffs'),
(64670, 'spell_undercity_buffs');

-- CREATURE_FLAG_EXTRA_IGNORE_PATHFINDING 
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x20000000, `InhabitType`=3 WHERE `entry` IN (32401,32391,32390,32395,32394,32392,32397,32396,32387,32510,31739,32519);

-- Vol'jin SAI
SET @ENTRY := 31649;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,19,0,100,0,13267,0,0,0,75,59062,0,0,0,0,0,7,0,0,0,0,0,0,0,"Vol'jin - On Quest '' Taken - Add Aura 'WGH Phase'"),
(@ENTRY,0,1,0,20,0,100,0,13266,0,0,0,7,13267,0,0,0,0,0,7,0,0,0,0,0,0,0,"Vol'jin - On Quest 'A Life Without Regret' Finished - Add Quest 'The Battle For The Undercity'"),
(@ENTRY,0,2,0,1,0,100,0,2000,2000,40000,40000,1,0,30000,0,0,0,0,1,0,0,0,0,0,0,0,"Vol'jin - Out of Combat - Say Line 0");
DELETE FROM `creature_text` WHERE `CreatureID`=31649;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(31649, 0, 0, 'Ello, mon! Da Battle for the Undercity is already going on. Thrall is fighting inside, you might be able to find him. You can also wait for him here, he will be back anytime now.', 14, 0, 100, 0, 0, 0, 0, 0, 'Vol''jin');
-- Conditions for Text Warning
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=3 AND `SourceEntry`=31649;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,3,31649,0,0,29,1,32518,30,0,1,0,0,"","Do Not Run Vol''jin Text announce if Thrall is in range");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
