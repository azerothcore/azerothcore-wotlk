-- DB update 2021_08_07_01 -> 2021_08_07_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_07_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_07_01 2021_08_07_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1617252770182832100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617252770182832100');

-- Amanitar encounter
DELETE FROM `spell_script_names` WHERE `spell_id`=57283 AND `ScriptName`='spell_amanitar_remove_mushroom_power';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(57283, 'spell_amanitar_remove_mushroom_power');
DELETE FROM `spell_script_names` WHERE `spell_id`=56648;
DELETE FROM `spell_group_stack_rules` WHERE `group_id`=1113;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`, `description`) VALUES
(1113, 8, 'Ahn\'kahet - Potent Fogus and Mini');
DELETE FROM `spell_group` WHERE `id`=1113;
INSERT INTO `spell_group` (`id`, `spell_id`, `special_flag`) VALUES
(1113, 57055, 0),
(1113, 56648, 0);

-- Teldaram
DELETE FROM `spell_script_names` WHERE `spell_id` = 55931 AND `ScriptName`='spell_prince_taldaram_conjure_flame_sphere';
DELETE FROM `spell_script_names` WHERE `spell_id` IN (55895, 59511, 59512) AND `ScriptName` = 'spell_prince_taldaram_flame_sphere_summon';
INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(55931, 'spell_prince_taldaram_conjure_flame_sphere'),
(55895, 'spell_prince_taldaram_flame_sphere_summon'),
(59511, 'spell_prince_taldaram_flame_sphere_summon'),
(59512, 'spell_prince_taldaram_flame_sphere_summon');
UPDATE `creature_text` SET `TextRange`=3,`comment`='prince taldaram SAY_SPHERE_ACTIVATED' WHERE  `CreatureID`=29308 AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `TextRange`=3,`comment`='prince taldaram SAY_REMOVE_PRISON'  WHERE  `CreatureID`=29308 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_template` SET `flags_extra`=`flags_extra` &~ 512 WHERE `entry` IN (29308, 31469);
UPDATE `creature_template` SET `modelid2` = 19725, `flags_extra` = `flags_extra` |64|128 WHERE `entry` IN (30106, 31458);

DELETE FROM `creature_summon_groups` WHERE `summonerId`=29308 AND `summonerType`=0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
(29308, 0, 0, 30181, 519.146, -792.274, 49.4627, 4.15388, 8, 0),
(29308, 0, 0, 30181, 542.994, -762.115, 36.0509, 1.32645, 8, 0),
(29308, 0, 0, 30181, 599.617, -762.315, 35.3111, 1.71042, 8, 0),
(29308, 0, 0, 30181, 506.573, -890.563, 45.1763, 3.35103, 8, 0),
(29308, 0, 0, 30181, 632.232, -774.304, 34.0595, 0.750492, 8, 0),
(29308, 0, 0, 30181, 489.944, -851.356, 52.09, 4.95674, 8, 0),
(29308, 0, 0, 30181, 655.409, -814.264, 35.2257, 0.436332, 8, 0);

-- Jedoga encounter
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=7359;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7359, 11, 0, 0, 'achievement_volunteer_work'),
(7359, 12, 1, 0, '');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=56312;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 56312, 0, 0, 31, 0, 3, 29310, 0, 0, 0, 0, '', 'Spell \'Beam Visual\' targets Jedoga Shadowseeker');

UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName` = 'npc_jedoga_initiand';
UPDATE `creature_template` SET `ScriptName`='npc_twilight_volunteer' WHERE `entry` = 30385;
update `creature_template` SET `modelid1`=169, `modelid2`=11686, `flags_extra`=`flags_extra`|128 WHERE `entry`=30181;
-- "...Immune to all kinds of Crowd Control..."
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|
    1| -- CHARM
    2| -- MECHANIC_DISORIENTED
    8| -- MECHANIC_CHARM
    16| -- MECHANIC_FEAR
    32| -- MECHANIC_GRIP
    64| -- MECHANIC_ROOT
    512| -- MECHANIC_SLEEP
    1024| -- MECHANIC_SNARE
    2048| -- MECHANIC_STUN
    4096| -- MECHANIC_FREEZE
    8192| -- MECHANIC_KNOCKOUT
    65536| -- MECHANIC_POLYMORPH
    8388608| -- MECHANIC_HORROR
    67108864| -- MECHANIC_DAZE
    536870912 -- MECHANIC_SAPPED
WHERE `entry` IN (30385, 31474);

DELETE FROM `spell_script_names` WHERE `spell_id`=56328 AND `ScriptName`='spell_random_lightning_visual_effect';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(56328,'spell_random_lightning_visual_effect');

DELETE FROM `spell_script_names` WHERE `spell_id`=56150 AND `ScriptName`='spell_jedoga_sacrafice_beam';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56150, 'spell_jedoga_sacrafice_beam');

DELETE FROM `creature_text` WHERE `CreatureID`=30385;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(30385,0,0,'I have been chosen!',14,0,100,0,0,0,31179,0,'SAY_CHOSEN'),
(30385,1,0,'I give myself to the master!',14,0,100,0,0,0,30863,0,'SAY_SACRIFICED');

DELETE FROM `creature_summon_groups` WHERE `summonerId`=29310 AND `summonerType`=0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
-- Out of Combat
(29310, 0, 0, 30114, 362.458, -714.166, -16.0964, 0.977384, 6, 10000),
(29310, 0, 0, 30114, 368.781, -713.932, -16.0964, 1.46608,  6, 10000),
(29310, 0, 0, 30114, 364.937, -716.11,  -16.0964, 1.25664,  6, 10000),
(29310, 0, 0, 30114, 362.02,  -719.828, -16.0964, 1.20428,  6, 10000),
(29310, 0, 0, 30114, 368.151, -719.763, -16.0964, 1.53589,  6, 10000),
(29310, 0, 0, 30114, 392.276, -695.895, -16.0964, 3.40339,  6, 10000),
(29310, 0, 0, 30114, 387.224, -698.006, -16.0964, 3.36848,  6, 10000),
(29310, 0, 0, 30114, 389.626, -702.3,   -16.0964, 3.07178,  6, 10000),
(29310, 0, 0, 30114, 383.812, -700.41,  -16.0964, 3.15905,  6, 10000),
(29310, 0, 0, 30114, 385.693, -694.376, -16.0964, 3.59538,  6, 10000),
(29310, 0, 0, 30114, 379.204, -716.697, -16.0964, 2.1293,   6, 10000),
(29310, 0, 0, 30114, 375.4,   -711.434, -16.0964, 2.09439,  6, 10000),
(29310, 0, 0, 30114, 382.583, -711.713, -16.0964, 2.53073,  6, 10000),
(29310, 0, 0, 30114, 379.049, -712.899, -16.0964, 2.28638,  6, 10000),
(29310, 0, 0, 30114, 378.424, -708.388, -16.0964, 2.58309,  6, 10000),
-- Triggers
(29310, 0, 1, 30181, 402.7893, -748.5251, 29.39399, 2.024582, 8, 0 ),
(29310, 0, 1, 30181, 420.1999, -727.0132, 28.88036, 2.042035, 8, 0 );

-- Elder Nadox
DELETE FROM `achievement_criteria_data` WHERE `criteria_id`=7317;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `value1`, `value2`, `ScriptName`) VALUES
(7317, 11, 0, 0, 'achievement_respect_your_elders'),
(7317, 12, 1, 0, '');

-- Trash npcs
-- Eye of Teldaram
DELETE FROM `creature_template_addon` WHERE `entry`=31457;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(31457, 0, 0, 0, 0, 0, 0, '56572');

-- Visuals
-- Special thanks for Docmin (Dr-J) for base data
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry` IN (56711, 56713);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 56711, 64, '', '', 'Disable LOS for Image Channel'),
(0, 56713, 64, '', '', 'Disable LOS for Image Channel');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (56711,56713);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,56711,0,0,31,0,3,30413,132012,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'"),
(13,1,56711,0,1,31,0,3,30413,132013,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'"),
(13,1,56713,0,0,31,0,3,30413,132012,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'"),
(13,1,56713,0,1,31,0,3,30413,132013,0,0,0,"","Group 0: Spell 'Image Channel' targets creature 'Channel Image Target'");
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30111 AND `source_type` = 0 AND `id` IN (4,5);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30179 AND `source_type` = 0 AND `id` IN (4,5);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30319 AND `source_type` = 0 AND `id` IN (5,6);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(30111,0,4,0,1,0,100,1,1000,1000,0,0,0,11,56711,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Worshipper - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30111,0,5,0,1,0,100,1,1000,1000,0,0,0,11,56713,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Worshipper - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30179,0,4,0,1,0,100,1,1000,1000,0,0,0,11,56711,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Apostle - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30179,0,5,0,1,0,100,1,1000,1000,0,0,0,11,56713,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Apostle - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30319,0,5,0,1,0,100,1,1000,1000,0,0,0,11,56711,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Darkcaster - Out of Combat - Cast 'Image Channel' (No Repeat)"),
(30319,0,6,0,1,0,100,1,1000,1000,0,0,0,11,56713,32,0,0,0,0,19,30413,5,0,0,0,0,0,0,"Twilight Darkcaster - Out of Combat - Cast 'Image Channel' (No Repeat)");

-- Herald Volazj - Insanity spell script
DELETE FROM `spell_script_names` WHERE `spell_id`=57496 AND `ScriptName`='spell_herald_volzaj_insanity';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(57496, 'spell_herald_volzaj_insanity');

-- Spell "Shadow Sickle" difficulty data
DELETE FROM `spelldifficulty_dbc` WHERE `ID`=56701;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(56701, 56701, 59104, 0, 0);

--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (60291,60292,60293,60294,60295,60296,60297) AND `ScriptName` = "spell_volazj_whisper";
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(60291,"spell_volazj_whisper"),
(60292,"spell_volazj_whisper"),
(60293,"spell_volazj_whisper"),
(60294,"spell_volazj_whisper"),
(60295,"spell_volazj_whisper"),
(60296,"spell_volazj_whisper"),
(60297,"spell_volazj_whisper");

-- SLAY_ based on https://wow.gamepedia.com/Herald_Volazj and https://wow.gamepedia.com/Shath%27Yar no sniffs for obvious reasons
DELETE FROM `creature_text` WHERE `CreatureID` = 29311;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
/*     0 */ (29311,0,0,"Shgla'yos plahf mh'naus.",14,0,100,0,0,14043,32596,0,"Herald Volazj SAY_AGGRO"),
/*     0 */ (29311,1,0,"Gul'kafh an'shel. Yoq'al shn ky ywaq nuul.",14,0,100,0,0,14044,32603,0,"Herald Volazj SAY_INSANITY"),
/*     0 */ (29311,2,0,"Ywaq ma phgwa'cul hnakf.",14,0,100,0,0,14045,32598,0,"Herald Volazj SAY_SLAY_1"),
/*     0 */ (29311,3,0,"Uulwi gag erh'ongg w'ssh.",14,0,100,0,0,14046,32599,0,"Herald Volazj SAY_SLAY_2"),
/*     0 */ (29311,4,0,"Ywaq puul skshgn: on'ma yeh'glu zuq.",14,0,100,0,0,14047,32600,0,"Herald Volazj SAY_SLAY_3"),
/*     0 */ (29311,5,0,"Iilth vwah, uhn'agth fhssh za.",14,0,100,0,0,14048,32601,0,"Herald Volazj SAY_DEATH_1"),
/*     0 */ (29311,6,0,"Ywaq maq oou; ywaq maq ssaggh. Ywaq ma shg'fhn.",14,0,100,0,0,14049,32602,0,"Herald Volazj SAY_DEATH_2"),

/* 60291 */ (29311,7,0,"They who dine on lost souls know only hunger.",15,0,100,0,0,0,32597,0,"Herald Volazj WHISPER_AGGRO"),
/* 60292 */ (29311,8,0,"Gaze into the void. It is the perpetuity in which they dwell.",15,0,100,0,0,0,32604,0,"Herald Volazj WHISPER_INSANITY"),
/* 60293 */ (29311,9,0,"They are the whisper on the shivering wind.",15,0,100,0,0,0,32605,0,"Herald Volazj WHISPER_SLAY_1"),
/* 60294 */ (29311,10,0,"Their shadow will choke the land for eternity.",15,0,100,0,0,0,32606,0,"Herald Volazj WHISPER_SLAY_2"),
/* 60295 */ (29311,11,0,"They drink your fear: it is the blood of life.",15,0,100,0,0,0,32607,0,"Herald Volazj WHISPER_SLAY_3"),
/* 60296 */ (29311,12,0,"Where one falls, many shall take its place.",15,0,100,0,0,0,32608,0,"Herald Volazj WHISPER_DEATH_1"),
/* 60297 */ (29311,13,0,"They do not die; they do not live. They are outside the cycle.",15,0,100,0,0,0,32609,0,"Herald Volazj WHISPER_DEATH_2");

-- Increase Jedoga prieching text range to map wide
UPDATE creature_text SET `TextRange`=3 WHERE `CreatureID`=29310 AND `GroupID`=5;

-- Taldaram Spheres
-- PS: not sure if "31458" entry actually should be used (its difficulty entry1 of 30106)
UPDATE creature_template SET modelid2 = 0, flags_extra=flags_extra|64|128 WHERE entry IN (30106, 31686, 31687, 31458);

-- Savage Cave Beast should have herbalism loot (copied skinloot from normal mode)
UPDATE creature_template SET skinloot=80007 WHERE entry=31470;

-- Amanitar immunities
UPDATE creature_template SET
    mechanic_immune_mask=1|2|4|8|16|32|64|256|512|1024|2048|4096|8192|65536|131072|8388608|33554432|67108864|536870912,
    skinloot=80007
WHERE entry IN (30258, 31463);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_07_02' WHERE sql_rev = '1617252770182832100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
