-- DB update 2021_12_29_02 -> 2021_12_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_29_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_29_02 2021_12_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640818723105671700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640818723105671700');

-- Variables
SET @ISILLIEN := 1840;
SET @TAELAN := 1842;
SET @TIRION := 12126;
SET @CRIMSON := 12128;
SET @DEATHSPELL := 18969;

-- Quest ender
DELETE FROM `creature_questender` WHERE `id`=@TIRION;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(@TIRION, 5944);

-- Creature Text
DELETE FROM `creature_text` WHERE `CreatureID` IN (@ISILLIEN, @TAELAN, @TIRION);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@ISILLIEN,0,0,'You will not make it to the forest\'s edge, Fordring.',12,0,100,0,0,0,7395,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,1,0,'You disappoint me, Taelan. I had plans for you... grand plans. Alas, it was only a matter of time before your filthy bloodline would catch up with you.',12,0,100,0,0,0,7337,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,2,0,'It is as they say: Like father, like son. You are as weak of will as Tirion... perhaps more so. I can only hope my assassins finally succeeded in ending his pitiful life.',12,0,100,0,0,0,7338,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,3,0,'The Grand Crusader has charged me with destroying you and your newfound friends, Taelan, but know this: I do this for pleasure, not of obligation or duty.',12,0,100,0,0,0,7359,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,4,0,'%s calls for his guardsmen.',16,0,100,22,0,0,7360,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,5,0,'The end is now, Fordring.',12,0,100,0,0,0,7361,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,6,0,'Enough!',12,0,100,0,0,0,7381,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,7,0,'%s laughs.',16,0,100,11,0,0,7382,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,8,0,'Did you really believe that you could defeat me? Your friends are soon to join you, Taelan.',12,0,100,0,0,0,7383,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,9,0,'Tragic. The elder Fordring lives on... You are too late, old man. Retreat back to your cave, hermit, unless you wish to join your son in the Twisting Nether.',12,0,100,0,0,0,7433,0,'Grand Inquisitor Isillien'),
(@ISILLIEN,10,0,'Then come, hermit!',12,0,100,0,0,0,7436,0,'Grand Inquisitor Isillien'),
(@TAELAN,0,0,'I will lead us through Hearthglen to the forest\'s edge. From there, you will take me to my father.',12,0,100,0,0,0,7313,0,'Taelan Fordring'),
(@TAELAN,1,0,'Remove your disguise, lest you feel the bite of my blade when the fury has taken control.',12,0,100,0,0,0,7314,0,'Taelan Fordring'),
(@TAELAN,2,0,'Halt.',12,0,100,0,0,0,7315,0,'Taelan Fordring'),
(@TAELAN,3,0,'%s calls for his mount.',16,0,100,22,0,0,7316,0,'Taelan Fordring'),
(@TAELAN,4,0,'It\'s not much further. The main road is just up ahead.',12,0,100,0,0,0,7329,0,'Taelan Fordring'),
(@TAELAN,5,0,'Isillien!',14,0,100,0,0,0,7370,0,'Taelan Fordring'),
(@TAELAN,6,0,'This is not your fight, stranger. Protect yourself from the attacks of the Crimson Elite. I shall battle the Grand Inquisitor.',12,0,100,0,0,0,7371,0,'Taelan Fordring'),
(@TIRION,0,0,'What have you done,  Isillien? You once fought with honor, for the good of our people... and now... you have murdered my boy... ',12,0,100,1,0,0,7372,0,'Lord Tirion Fordring'),
(@TIRION,1,0,'May your soul burn in anguish, Isillien! Light give me strength to battle this fiend.',12,0,100,15,0,0,7373,0,'Lord Tirion Fordring'),
(@TIRION,2,0,'Face me, coward. Face the faith and strength that you once embodied.',12,0,100,25,0,0,7374,0,'Lord Tirion Fordring'),
(@TIRION,3,0,'A thousand more like him exist. Ten thousand. Should one fall, another will rise to take the seat of power.',12,0,100,0,0,0,7420,0,'Lord Tirion Fordring'),
(@TIRION,4,0,'%s falls to one knee.',16,0,100,0,0,0,7421,0,'Lord Tirion Fordring'),
(@TIRION,5,0,'Look what they did to my boy.',12,0,100,5,0,0,7423,0,'Lord Tirion Fordring'),
(@TIRION,6,0,'Too long have I sat idle, gripped in this haze... this malaise, lamenting what could have been... what should have been.',12,0,100,0,0,0,7429,0,'Lord Tirion Fordring'),
(@TIRION,7,0,'Your death will not have been in vain, Taelan. A new Order is born on this day... an Order which will dedicate itself to extinguishing the evil that plagues this world. An evil that cannot hide behind politics and pleasantries.',12,0,100,0,0,0,7426,0,'Lord Tirion Fordring'),
(@TIRION,8,0,'This I promise... This I vow...',12,0,100,0,0,0,7430,0,'Lord Tirion Fordring');

-- Grand Inquisitor Isillien
UPDATE `creature_template` SET `faction`=16, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@ISILLIEN;

DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ISILLIEN AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ISILLIEN, 0, 0, 0, 37, 0, 100, 0, 0, 0, 0, 0, 80, 184000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien  - On AI initialize - Self: Start timed action list id #184000 (update always (2))'),
(@ISILLIEN, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 30000, 30000, 11, 11647, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien  - Every 30 seconds (1s initially)  - Self: Cast spell Power Word: Shield (11647) on Self'),
(@ISILLIEN, 0, 2, 0, 0, 0, 100, 0, 3000, 3000, 8000, 9000, 11, 17287, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - Every 8 - 9 seconds (3 - 3s initially)  - Self: Cast spell Mind Blast (17287) on Victim'),
(@ISILLIEN, 0, 3, 0, 0, 0, 100, 0, 20000, 20000, 20000, 20000, 11, 13639, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien  - Every 20 seconds  - Self: Cast spell Greater Health (13639) on Self'),
(@ISILLIEN, 0, 4, 0, 0, 0, 100, 0, 7000, 8000, 15000, 15000, 11, 17314, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien  - Every 15 - 15 seconds (7 - 8s initially)  - Self: Cast spell Mind Flay (17314) on Victim');

-- Grand Inquisitor Isillien Actionlist 1
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ISILLIEN*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ISILLIEN*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Set UNIT_FLAGS to IMMUNE_TO_PC, IMMUNE_TO_NPC'),
(@ISILLIEN*100, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 1 seconds - Self: Talk 0 to invoker'),
(@ISILLIEN*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2677, -1917, 68, 2.1, 'Grand Inquisitor Isillien - After 4 seconds - Self: Move to position (2677, -1917, 68, 2.1) (point id 0)'),
(@ISILLIEN*100, 9, 3, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 8 seconds - Self: Talk 1 to invoker'),
(@ISILLIEN*100, 9, 4, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 8 seconds - Self: Talk 2 to invoker'),
(@ISILLIEN*100, 9, 5, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 8 seconds - Self: Talk 3 to invoker'),
(@ISILLIEN*100, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 8 seconds - Self: Talk 4 to invoker'),
(@ISILLIEN*100, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 5 seconds - Self: Talk 5 to invoker'),
(@ISILLIEN*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2674, -1920, 68.41, 1.8, 'Grand Inquisitor Isillien - After 0 seconds - Self: Summon creature Crimson Elite (12128) at (2674, -1920, 68.41, 1.8) as summon type timed despawn out of combat (4) with duration 40 seconds'),
(@ISILLIEN*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2684, -1918, 69.52, 2.2, 'Grand Inquisitor Isillien - After 0 seconds - Self: Summon creature Crimson Elite (12128) at (2684, -1918, 69.52, 2.2) as summon type timed despawn out of combat (4) with duration 40 seconds'),
(@ISILLIEN*100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2694, -1875, 66.86, 3.8, 'Grand Inquisitor Isillien - After 0 seconds - Self: Summon creature Crimson Elite (12128) at (2694, -1875, 66.86, 3.8) as summon type timed despawn out of combat (4) with duration 40 seconds'),
(@ISILLIEN*100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2693, -1869, 66.87, 3.9, 'Grand Inquisitor Isillien - After 0 seconds - Self: Summon creature Crimson Elite (12128) at (2693, -1869, 66.87, 3.9) as summon type timed despawn out of combat (4) with duration 40 seconds'),
(@ISILLIEN*100, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 12128, 4, 40000, 0, 0, 0, 8, 0, 0, 0, 2697, -1879, 66.8, 3.8, 'Grand Inquisitor Isillien - After 0 seconds - Self: Summon creature Crimson Elite (12128) at (2697, -1879, 66.8, 3.8) as summon type timed despawn out of combat (4) with duration 40 seconds'),
(@ISILLIEN*100, 9, 13, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 12128, 100, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 2 seconds - Creature Crimson Elite (12128) in 100 yd: Set creature data #1 to 1'),
(@ISILLIEN*100, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 776, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Remove UNIT_FLAGS to PVP_ATTACKABLE, IMMUNE_TO_PC, IMMUNE_TO_NPC'),
(@ISILLIEN*100, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 1842, 30, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Attack Closest alive creature Highlord Taelan Fordring (1842) in 30 yards'),
(@ISILLIEN*100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Set invincibility to 1 HP'),
(@ISILLIEN*100, 9, 17, 0, 0, 0, 100, 0, 45000, 45000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 45 seconds - Self: Talk 6 to invoker'),
(@ISILLIEN*100, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Set home position to current position'),
(@ISILLIEN*100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 11, 18969, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Cast spell Taelan Death (18969) on Self (flags: triggered)'),
(@ISILLIEN*100, 9, 20, 0, 0, 0, 100, 0, 500, 500, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0.5 seconds - Self: Evade'),
(@ISILLIEN*100, 9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Set UNIT_FLAGS to IMMUNE_TO_PC, IMMUNE_TO_NPC'),
(@ISILLIEN*100, 9, 22, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Set invincibility to 0 HP'),
(@ISILLIEN*100, 9, 23, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 6 seconds - Self: Talk 7 to invoker'),
(@ISILLIEN*100, 9, 24, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 3 seconds - Self: Talk 8 to invoker'),
(@ISILLIEN*100, 9, 25, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 5 seconds - Self: Remove UNIT_FLAGS to IMMUNE_TO_PC, IMMUNE_TO_NPC'),
(@ISILLIEN*100, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 50, 0, 0, 0, 0, 0, 0, 'Grand Inquisitor Isillien - After 0 seconds - Self: Attack Closest player in 50 yards'),
(@ISILLIEN*100, 9, 27, 0, 0, 0, 100, 0, 25000, 25000, 0, 0, 12, 12126, 4, 180000, 0, 0, 0, 8, 0, 0, 0, 2642.8, -1913, 71.2, 0.4, 'Grand Inquisitor Isillien - After 25 seconds - Self: Summon creature Lord Tirion Fordring (12126) at (2642.8, -1913, 71.2, 0.4) as summon type timed despawn out of combat (4) with duration 180 seconds');

-- Highlord Taelan Fordring
UPDATE `creature_template` SET `AIName` = 'SmartAI', `scale` = 1.18 WHERE `entry` = @TAELAN;

DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @TAELAN AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TAELAN, 0, 0, 0, 34, 0, 100, 0, 8, 16777215, 0, 0, 43, 0, 2402, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On movement of type POINT_MOTION_TYPE (8) inform, point 16777215 - Self: Mount to model 2402'),
(@TAELAN, 0, 1, 2, 19, 0, 100, 0, 5944, 0, 0, 0, 1, 0, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On player accepted quest In Dreams (5944) - Self: Talk 0 to invoker'),
(@TAELAN, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On link - Self: Set active'),
(@TAELAN, 0, 3, 0, 52, 0, 100, 1, 0, 1842, 0, 0, 53, 0, 1842, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - When text 0 said by creature Highlord Taelan Fordring (1842) is over - Self: Start path #1842, run, do not repeat, Aggressive (2)'),
(@TAELAN, 0, 4, 5, 11, 0, 100, 0, 0, 0, 0, 0, 2, 67, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On respawn  - Self: Set faction to Horde (67)'),
(@TAELAN, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On link - Self: Remove UNIT_FLAGS to IMMUNE_TO_PC, IMMUNE_TO_NPC'),
(@TAELAN, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On link - Self: Remove 7 bytes from UNIT_FIELD_BYTES_1 with Type UNIT_BYTES_1_OFFSET_STAND_STATE (0)'),
(@TAELAN, 0, 7, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 17232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On aggro - Self: Cast spell Devotion Aura (17232) on Self'),
(@TAELAN, 0, 8, 0, 0, 0, 100, 0, 3000, 3000, 5000, 5000, 11, 17281, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - Every 5 seconds (3s initially)  - Self: Cast spell Crusader Strike (17281) on Victim'),
(@TAELAN, 0, 9, 0, 2, 0, 100, 0, 0, 20, 120000, 120000, 11, 17233, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - When health between 0-20% (check every 120000 - 120000 ms) - Self: Cast spell Lay on Hands (17233) on Self'),
(@TAELAN, 0, 10, 11, 40, 0, 100, 0, 1, 0, 0, 0, 1, 1, 6000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On wapoint 1 of any path reached - Self: Talk 1 to invoker'),
(@TAELAN, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 2, 42, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On link - Self: Set faction to Beast - Raptor (42)'),
(@TAELAN, 0, 12, 0, 40, 0, 100, 0, 26, 0, 0, 0, 54, 7000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On wapoint 26 of any path reached - Self: Pause path for 7000 ms'),
(@TAELAN, 0, 13, 14, 55, 0, 100, 0, 26, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On wapoint 26 of any path paused - Self: Talk 2 to invoker'),
(@TAELAN, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On link - Trigger timed event #1 in 3000 - 3000 ms // -meta_wait'),
(@TAELAN, 0, 15, 16, 59, 0, 100, 0, 1, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On timed event 1 triggered - Self: Talk 3 to Self'),
(@TAELAN, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 43, 0, 2402, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On link - Self: Mount to model 2402'),
(@TAELAN, 0, 17, 0, 40, 0, 100, 0, 74, 0, 0, 0, 80, 184200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On wapoint 74 of any path reached - Self: Start timed action list id #184200 (update always (2))'),
(@TAELAN, 0, 18, 0, 8, 0, 100, 0, 18969, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - On spell Taelan Death (18969) hit  - Self: Kill self (Self)');

-- Highlord Taelan Actionlist 1
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @TAELAN*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TAELAN*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 1 seconds - Self: Talk 4 to invoker'),
(@TAELAN*100, 9, 1, 0, 0, 0, 100, 0, 100, 100, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 0.1 seconds - Self: Look at Closest player in 40 yards'),
(@TAELAN*100, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 12, 1840, 4, 120000, 0, 0, 0, 8, 0, 0, 0, 2683.64, -1926.72, 72.14, 2, 'Highlord Taelan Fordring - After 2 seconds - Self: Summon creature Grand Inquisitor Isillien (1840) at (2683.64, -1926.72, 72.14, 2) as summon type timed despawn out of combat (4) with duration 120 seconds'),
(@TAELAN*100, 9, 3, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 4 seconds - Self: Talk 5 to invoker'),
(@TAELAN*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 9, 1840, 0, 40, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 0 seconds - Self: Look at Creature Grand Inquisitor Isillien (1840) in 0 - 40 yards'),
(@TAELAN*100, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 4 seconds - Self: Talk 6 to invoker'),
(@TAELAN*100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 0 seconds - Self: Dismount'),
(@TAELAN*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 0 seconds - Self: Set home position to current position'),
(@TAELAN*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Highlord Taelan Fordring - After 0 seconds - Self: Remove UNIT_FLAGS to PVP_ATTACKABLE');

-- Tirion Fordring
UPDATE `creature_template` SET `unit_flags`=0, `faction`=35, `flags_extra`=2, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@TIRION;

DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @TIRION AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TIRION, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - On AI initialize - Self: Set react state to Aggressive (2)'),
(@TIRION, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 43, 0, 2325, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - On link - Self: Mount to model 2325'),
(@TIRION, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - On link - Self: Set run'),
(@TIRION, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - On link - Self: Set npc flags NONE'),
(@TIRION, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 12126, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - On link - Self: Start path #12126, run, do not repeat, Passive (0)'),
(@TIRION, 0, 5, 0, 40, 0, 100, 0, 1, 0, 0, 0, 80, 1212600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - On wapoint 1 of any path reached - Self: Start timed action list id #1212600 (update always (2))'),
(@TIRION, 0, 6, 0, 7, 1, 100, 0, 0, 0, 0, 0, 80, 1212601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - On evade - Self: Start timed action list id #1212601 (update out of combat (0))'),
(@TIRION, 0, 7, 0, 0, 0, 100, 0, 6000, 10000, 6000, 10000, 11, 18819, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - Every 6 - 10 seconds  - Self: Cast spell Holy Cleave (18819) on Victim');

-- Tirion Fordring Actionlist 1 - Talk and fight
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @TIRION*100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TIRION*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Set home position to current position'),
(@TIRION*100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0.5 seconds - Self: Dismount'),
(@TIRION*100, 9, 2, 0, 0, 0, 100, 0, 500, 500, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0.5 seconds - Self: Set UNIT_FIELD_BYTES_1 with Type UNIT_BYTES_1_OFFSET_STAND_STATE (0) to 8'),
(@TIRION*100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 5 seconds - Self: Remove 8 bytes from UNIT_FIELD_BYTES_1 with Type UNIT_BYTES_1_OFFSET_STAND_STATE (0)'),
(@TIRION*100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Look at Closest alive creature Grand Inquisitor Isillien (1840) in 50 yards'),
(@TIRION*100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Talk 1 to invoker'),
(@TIRION*100, 9, 6, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 10, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 4 seconds - Closest alive creature Grand Inquisitor Isillien (1840) in 50 yards: Talk 10 to invoker'),
(@TIRION*100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Remove UNIT_FLAGS to IMMUNE_TO_PC, IMMUNE_TO_NPC'),
(@TIRION*100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 42, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Set faction to Beast - Raptor (42)'),
(@TIRION*100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Set react state to Aggressive (2)'),
(@TIRION*100, 9, 10, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 9, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 4 seconds - Closest alive creature Grand Inquisitor Isillien (1840) in 50 yards: Talk 9 to invoker'),
(@TIRION*100, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 5 seconds - Self: Talk 2 to invoker'),
(@TIRION*100, 9, 12, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 1840, 50, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 3 seconds - Self: Attack Closest alive creature Grand Inquisitor Isillien (1840) in 50 yards'),
(@TIRION*100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Set event phase to 1');

-- Tirion Fordring Actionlist 2 - After fight talk and quest complete
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @TIRION*100+1 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@TIRION*100+1, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 3 seconds - Self: Talk 3 to invoker'),
(@TIRION*100+1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Dismount'),
(@TIRION*100+1, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 1842, 50, 1, 0, 0, 0, 0, 'Tirion Fordrin - After 3 seconds - Self: Look at Closest dead creature Highlord Taelan Fordring (1842) in 50 yards'),
(@TIRION*100+1, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Talk 4 to invoker'),
(@TIRION*100+1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Set UNIT_FIELD_BYTES_1 with Type UNIT_BYTES_1_OFFSET_STAND_STATE (0) to 8'),
(@TIRION*100+1, 9, 5, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 3 seconds - Self: Talk 5 to invoker'),
(@TIRION*100+1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Remove 8 bytes from UNIT_FIELD_BYTES_1 with Type UNIT_BYTES_1_OFFSET_STAND_STATE (0)'),
(@TIRION*100+1, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 8 seconds - Self: Talk 6 to invoker'),
(@TIRION*100+1, 9, 8, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 9 seconds - Self: Talk 7 to invoker'),
(@TIRION*100+1, 9, 9, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 12 seconds - Self: Talk 8 to invoker'),
(@TIRION*100+1, 9, 10, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 15, 5944, 0, 0, 0, 0, 0, 18, 50, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 1 seconds - Players in 50 yards: Call quest In Dreams (5944) group event happened'),
(@TIRION*100+1, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tirion Fordrin - After 0 seconds - Self: Set npc flags QUESTGIVER');

-- Crimson Elite
UPDATE `creature_template` SET `faction`=16, `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=@CRIMSON;

DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @CRIMSON AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@CRIMSON, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 9000, 10000, 11, 17143, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Elite - Every 9 - 10 seconds (3 - 5s initially)  - Self: Cast spell Holy Strike (17143) on Victim'),
(@CRIMSON, 0, 1, 0, 0, 0, 100, 0, 8000, 9000, 20000, 22000, 11, 14518, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Crimson Elite - Every 20 - 22 seconds (8 - 9s initially)  - Self: Cast spell Crusader Strike (14518) on Victim'),
(@CRIMSON, 0, 2, 0, 38, 0, 100, 0, 1, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 2674, -1906, 66.1, 5.3, 'Crimson Elite - On data 1 set to 1 - Self: Move to position (2674, -1906, 66.1, 5.3) (point id 0)');

-- Waypoints
DELETE FROM `waypoints` WHERE `entry`=@TIRION;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(@TIRION, 1, 2667, -1899, 66.81, 'Tirion Fordring');

DELETE FROM `waypoints` WHERE `entry`=@TAELAN;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(@TAELAN, 1, 2941.47, -1391.79, 167.237, 'Taelan Fordring'),
(@TAELAN, 2, 2940.59, -1393.34, 166.084, 'Taelan Fordring'),
(@TAELAN, 3, 2934.76, -1403.63, 165.943, 'Taelan Fordring'),
(@TAELAN, 4, 2932.09, -1408.34, 165.943, 'Taelan Fordring'),
(@TAELAN, 5, 2917.95, -1402.97, 165.943, 'Taelan Fordring'),
(@TAELAN, 6, 2919.7, -1398.38, 165.88, 'Taelan Fordring'),
(@TAELAN, 7, 2922.96, -1389.76, 160.89, 'Taelan Fordring'),
(@TAELAN, 8, 2925.9, -1386.68, 160.842, 'Taelan Fordring'),
(@TAELAN, 9, 2946.78, -1396.55, 160.842, 'Taelan Fordring'),
(@TAELAN, 10, 2948.71, -1392.82, 160.842, 'Taelan Fordring'),
(@TAELAN, 11, 2951.88, -1386.69, 155.974, 'Taelan Fordring'),
(@TAELAN, 12, 2953.8, -1383.23, 155.949, 'Taelan Fordring'),
(@TAELAN, 13, 2951.18, -1381.97, 155.949, 'Taelan Fordring'),
(@TAELAN, 14, 2946.54, -1379.57, 152.02, 'Taelan Fordring'),
(@TAELAN, 15, 2943.02, -1377.76, 152.02, 'Taelan Fordring'),
(@TAELAN, 16, 2935.55, -1392.66, 152.02, 'Taelan Fordring'),
(@TAELAN, 17, 2920.61, -1385.01, 152.02, 'Taelan Fordring'),
(@TAELAN, 18, 2915.23, -1395.37, 152.02, 'Taelan Fordring'),
(@TAELAN, 19, 2926.44, -1401.34, 152.03, 'Taelan Fordring'),
(@TAELAN, 20, 2930.45, -1403.49, 150.521, 'Taelan Fordring'),
(@TAELAN, 21, 2933.64, -1405.2, 150.521, 'Taelan Fordring'),
(@TAELAN, 22, 2930.83, -1412.74, 150.504, 'Taelan Fordring'),
(@TAELAN, 23, 2924.04, -1426.34, 150.781, 'Taelan Fordring'),
(@TAELAN, 24, 2917.27, -1439.65, 150.664, 'Taelan Fordring'),
(@TAELAN, 25, 2914.56, -1445.08, 149.505, 'Taelan Fordring'),
(@TAELAN, 26, 2911.01, -1452.17, 147.891, 'Taelan Fordring'),
(@TAELAN, 27, 2911.49, -1460.75, 147.348, 'Taelan Fordring'),
(@TAELAN, 28, 2915.27, -1471.79, 146.082, 'Taelan Fordring'),
(@TAELAN, 29, 2917.16, -1477.3, 146.179, 'Taelan Fordring'),
(@TAELAN, 30, 2937.93, -1475.79, 146.786, 'Taelan Fordring'),
(@TAELAN, 31, 2948.62, -1483.6, 146.287, 'Taelan Fordring'),
(@TAELAN, 32, 2950.48, -1502.29, 146.109, 'Taelan Fordring'),
(@TAELAN, 33, 2949.29, -1521.33, 146.274, 'Taelan Fordring'),
(@TAELAN, 34, 2950.6, -1538.69, 146.082, 'Taelan Fordring'),
(@TAELAN, 35, 2930.13, -1562.47, 145.785, 'Taelan Fordring'),
(@TAELAN, 36, 2916.36, -1578.33, 146.147, 'Taelan Fordring'),
(@TAELAN, 37, 2909.48, -1586.26, 146.515, 'Taelan Fordring'),
(@TAELAN, 38, 2902.06, -1590.55, 146.557, 'Taelan Fordring'),
(@TAELAN, 39, 2888.13, -1591.98, 145.702, 'Taelan Fordring'),
(@TAELAN, 40, 2876.43, -1591.6, 144.335, 'Taelan Fordring'),
(@TAELAN, 41, 2862.5, -1593.03, 142.511, 'Taelan Fordring'),
(@TAELAN, 42, 2846.46, -1603.03, 139.023, 'Taelan Fordring'),
(@TAELAN, 43, 2836.07, -1612.41, 135.225, 'Taelan Fordring'),
(@TAELAN, 44, 2827.58, -1620.07, 132.012, 'Taelan Fordring'),
(@TAELAN, 45, 2820.52, -1623.16, 131.22, 'Taelan Fordring'),
(@TAELAN, 46, 2804.83, -1620.19, 129.717, 'Taelan Fordring'),
(@TAELAN, 47, 2791.11, -1617.4, 129.693, 'Taelan Fordring'),
(@TAELAN, 48, 2780.39, -1615.9, 129.044, 'Taelan Fordring'),
(@TAELAN, 49, 2773.01, -1623.84, 128.074, 'Taelan Fordring'),
(@TAELAN, 50, 2766.04, -1631.69, 127.927, 'Taelan Fordring'),
(@TAELAN, 51, 2759.06, -1639.54, 128.336, 'Taelan Fordring'),
(@TAELAN, 52, 2752.08, -1647.38, 127.494, 'Taelan Fordring'),
(@TAELAN, 53, 2745.11, -1655.23, 126.277, 'Taelan Fordring'),
(@TAELAN, 54, 2738.13, -1663.08, 126.679, 'Taelan Fordring'),
(@TAELAN, 55, 2732.03, -1674.53, 126.673, 'Taelan Fordring'),
(@TAELAN, 56, 2725.5, -1682.87, 126.414, 'Taelan Fordring'),
(@TAELAN, 57, 2717.98, -1692.7, 126.476, 'Taelan Fordring'),
(@TAELAN, 58, 2713.38, -1700, 125.79, 'Taelan Fordring'),
(@TAELAN, 59, 2703.08, -1714.3, 122.214, 'Taelan Fordring'),
(@TAELAN, 60, 2694.95, -1729.79, 117.559, 'Taelan Fordring'),
(@TAELAN, 61, 2689.65, -1745.97, 112.656, 'Taelan Fordring'),
(@TAELAN, 62, 2689.05, -1763.33, 106.147, 'Taelan Fordring'),
(@TAELAN, 63, 2690.09, -1774.06, 102.238, 'Taelan Fordring'),
(@TAELAN, 64, 2691.45, -1786.18, 97.3156, 'Taelan Fordring'),
(@TAELAN, 65, 2692.17, -1800.16, 90.1386, 'Taelan Fordring'),
(@TAELAN, 66, 2692.7, -1810.65, 85.387, 'Taelan Fordring'),
(@TAELAN, 67, 2697.55, -1818.24, 81.7822, 'Taelan Fordring'),
(@TAELAN, 68, 2700.73, -1829.26, 76.4334, 'Taelan Fordring'),
(@TAELAN, 69, 2699.39, -1845.15, 71.4784, 'Taelan Fordring'),
(@TAELAN, 70, 2696.58, -1856.38, 68.2104, 'Taelan Fordring'),
(@TAELAN, 71, 2694.06, -1870.35, 66.9045, 'Taelan Fordring'),
(@TAELAN, 72, 2693.26, -1873.62, 66.8413, 'Taelan Fordring'),
(@TAELAN, 73, 2675.36, -1891.94, 66.1742, 'Taelan Fordring'),
(@TAELAN, 74, 2669.33, -1898.11, 66.7004, 'Taelan Fordring');

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=@DEATHSPELL;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, @DEATHSPELL, 0, 0, 31, 0, 3, @TAELAN, 0, 0, 0, 0, '', 'Taelan Death Spell - Target Taelan');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = @TAELAN AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(22, 1, 1842, 0, 0, 23, 1, 203, 0, 0, 1, 'Highlord Taelan Fordring - Object (1) is not in area Mardenholde Keep (203)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_30_00' WHERE sql_rev = '1640818723105671700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
