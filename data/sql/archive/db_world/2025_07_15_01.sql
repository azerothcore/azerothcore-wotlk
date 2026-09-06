-- DB update 2025_07_15_00 -> 2025_07_15_01
-- Update creature '[DNT] Torch Tossing Target Bunny Controller' with sniffed values
-- updated spawns
DELETE FROM `creature` WHERE (`id1` IN (25536)) AND (`guid` IN (46914));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(46914, 25536, 1, 1, 1, 0, 8700.30859375, 932.3953857421875, 15.39370346069335937, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (25536)) AND (`guid` IN (12741, 12742, 12743, 12744, 12745, 12746, 12747));
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(12741, 25536, 0, 1, 1, 0, -4699.91748046875, -1223.1417236328125, 501.74273681640625, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12742, 25536, 0, 1, 1, 0, -8834.6591796875, 860.409912109375, 98.92121124267578125, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12743, 25536, 0, 1, 1, 0, 1821.796630859375, 219.0257720947265625, 60.35529327392578125, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12744, 25536, 1, 1, 1, 0, -1036.5052490234375, 291.666656494140625, 135.8285369873046875, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50172, 1, NULL),
(12745, 25536, 1, 1, 1, 0, 1912.2239990234375, -4337.7275390625, 21.54599571228027343, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50129, 1, NULL),
(12746, 25536, 530, 1, 1, 0, -3794.286865234375, -11503.6953125, -134.666015625, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(12747, 25536, 530, 1, 1, 0, 9805.505859375, -7239.36083984375, 26.12895011901855468, 1.518436431884765625, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (25536)));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` IN (25536));

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25536;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25536);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25536, 0, 0, 0, 1, 0, 100, 0, 3280, 3280, 3280, 3280, 0, 0, 11, 45907, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny Controller - Out of Combat - Cast \'Torch Target Picker\'');

-- Update creature '[DNT] Torch Tossing Target Bunny' with sniffed values
-- new spawns
DELETE FROM `creature` WHERE (`id1` IN (25535)) AND (`guid` BETWEEN 67061 AND 67100);
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(67061, 25535, 0, 1, 1, 0, -4675.45849609375, -1224.6822509765625, 503.43707275390625, 2.513274192810058593, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67062, 25535, 0, 1, 1, 0, -4677.3037109375, -1229.8385009765625, 503.485687255859375, 5.707226753234863281, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67063, 25535, 0, 1, 1, 0, -4678.69775390625, -1219.49658203125, 503.416259765625, 4.345870018005371093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67064, 25535, 0, 1, 1, 0, -4683.9912109375, -1232.7379150390625, 503.450958251953125, 5.672319889068603515, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67065, 25535, 0, 1, 1, 0, -4685.86474609375, -1219.0382080078125, 503.360687255859375, 4.921828269958496093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67066, 25535, 0, 1, 1, 0, -8816.2197265625, 854.91680908203125, 100.76092529296875, 2.513274192810058593, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67067, 25535, 0, 1, 1, 0, -8817.7783203125, 859.74346923828125, 100.935577392578125, 4.345870018005371093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67068, 25535, 0, 1, 1, 0, -8819.544921875, 848.56182861328125, 100.82928466796875, 2.502277135848999023, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67069, 25535, 0, 1, 1, 0, -8821.5283203125, 862.878173828125, 100.6857452392578125, 4.921828269958496093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67070, 25535, 0, 1, 1, 0, -8825.814453125, 845.6329345703125, 100.7208480834960937, 2.617993831634521484, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67071, 25535, 0, 1, 1, 0, 1837.107666015625, 225.5746612548828125, 61.99619293212890625, 3.682644605636596679, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67072, 25535, 0, 1, 1, 0, 1837.2535400390625, 213.0590362548828125, 62.06979751586914062, 3.630284786224365234, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67073, 25535, 0, 1, 1, 0, 1838.25048828125, 218.9720306396484375, 61.92812728881835937, 2.513274192810058593, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67074, 25535, 0, 1, 1, 0, 1840.1614990234375, 222.5590362548828125, 61.98836135864257812, 4.345870018005371093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67075, 25535, 0, 1, 1, 0, 1840.96875, 216.172149658203125, 61.8509368896484375, 5.707226753234863281, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67076, 25535, 1, 1, 1, 0, -1041.6041259765625, 313.09027099609375, 134.989776611328125, 5.707226753234863281, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67077, 25535, 1, 1, 1, 0, -1042.5538330078125, 306.5850830078125, 136.157989501953125, 5.497786998748779296, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67078, 25535, 1, 1, 1, 0, -1048.773193359375, 299.850006103515625, 136.1358795166015625, 4.921828269958496093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67079, 25535, 1, 1, 1, 0, -1049.15087890625, 306.40142822265625, 134.524688720703125, 4.345870018005371093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67080, 25535, 1, 1, 1, 0, -1054.4010009765625, 298.638885498046875, 135.0235443115234375, 5.672319889068603515, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67081, 25535, 1, 1, 1, 0, 1915.6007080078125, -4320.49462890625, 23.73333549499511718, 4.921828269958496093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67082, 25535, 1, 1, 1, 0, 1918.1458740234375, -4314.98291015625, 24.7256317138671875, 5.707226753234863281, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67083, 25535, 1, 1, 1, 0, 1920.54345703125, -4319.4130859375, 23.75618362426757812, 4.345870018005371093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67084, 25535, 1, 1, 1, 0, 1923.9132080078125, -4315.3056640625, 24.48004341125488281, 5.672319889068603515, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67085, 25535, 1, 1, 1, 0, 1925.1492919921875, -4321.26416015625, 23.59164047241210937, 2.513274192810058593, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67086, 25535, 1, 1, 1, 0, 8716.7236328125, 936.3680419921875, 16.6112823486328125, 4.921828269958496093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67087, 25535, 1, 1, 1, 0, 8716.8046875, 928.8211669921875, 17.08502960205078125, 4.345870018005371093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67088, 25535, 1, 1, 1, 0, 8717.232421875, 920.03643798828125, 16.90518951416015625, 3.141592741012573242, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67089, 25535, 1, 1, 1, 0, 8721.142578125, 923.810791015625, 18.2428741455078125, 2.617993831634521484, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67090, 25535, 1, 1, 1, 0, 8722.0048828125, 933.625, 17.7832183837890625, 3.822271108627319335, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67091, 25535, 530, 1, 1, 0, -3804.291748046875, -11485.42578125, -136.533004760742187, 5.270894527435302734, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67092, 25535, 530, 1, 1, 0, -3807.56591796875, -11490.8095703125, -136.608322143554687, 5.777040004730224609, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67093, 25535, 530, 1, 1, 0, -3808.4306640625, -11486.3017578125, -136.543533325195312, 5.660167694091796875, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67094, 25535, 530, 1, 1, 0, -3810.842041015625, -11496.8720703125, -136.652481079101562, 6.161012172698974609, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67095, 25535, 530, 1, 1, 0, -3812.045166015625, -11492.4443359375, -136.653488159179687, 5.672319889068603515, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67096, 25535, 530, 1, 1, 0, 9794.5107421875, -7221.3525390625, 28.45974159240722656, 5.602506637573242187, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67097, 25535, 530, 1, 1, 0, 9799.3681640625, -7222.60791015625, 27.77687263488769531, 5.811946392059326171, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67098, 25535, 530, 1, 1, 0, 9799.3720703125, -7217.6025390625, 28.48725509643554687, 5.295448780059814453, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67099, 25535, 530, 1, 1, 0, 9804.0322265625, -7219.88916015625, 27.82104110717773437, 4.345870018005371093, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL),
(67100, 25535, 530, 1, 1, 0, 9804.1015625, -7214.453125, 28.49527359008789062, 4.502949237823486328, 120, 0, 0, 0, 0, 0, "", 50063, 1, NULL);

-- enable all spawns for eventEntry 1
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1) AND (`guid` IN (SELECT `guid` FROM `creature` WHERE `id1` IN (25535)));
INSERT INTO `game_event_creature` (SELECT 1, `guid` FROM `creature` WHERE `id1` IN (25535));

UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE `entry` = 25535;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25535);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25535, 0, 0, 0, 8, 0, 100, 0, 45907, 0, 0, 0, 0, 0, 11, 45723, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - On Spellhit \'Torch Target Picker\' - Cast \'Target Indicator\''),
(25535, 0, 1, 0, 8, 0, 100, 0, 45907, 0, 0, 0, 0, 0, 11, 46901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - On Spellhit \'Torch Target Picker\' - Cast \'Target Indicator (Cosmetic)\''),
(25535, 0, 2, 0, 8, 0, 100, 0, 46054, 0, 0, 0, 0, 0, 11, 45724, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - On Spellhit \'Torch Toss (land)\' - Cast \'Braziers Hit!\'');

-- 45724 Braziers Hit!
-- SPELL_ATTR0_CU_SINGLE_AURA_STACK
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 45724;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(45724, 4194304);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN(45719, 46651, -45716, -46630) AND `spell_effect` IN (-45716, -46630, -45724) AND `type` = 0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(45719, -45716, 0, '\'Torch Tossing Training Success\' removes \'Torch Tossing Training\''),
(45719, -46630, 0, '\'Torch Tossing Training Success\' removes \'Torch Tossing Practice\''),
(46651, -45716, 0, '\'Torch Tossing Training Success\' removes \'Torch Tossing Training\''),
(46651, -46630, 0, '\'Torch Tossing Training Success\' removes \'Torch Tossing Practice\''),
(-45716, -45724, 0, 'Removing \'Torch Tossing Training\' removes \'Braziers Hit!\''),
(-46630, -45724, 0, 'Removing \'Torch Tossing Practice\' removes \'Braziers Hit!\'');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (45716, 46630, 45907, 45724);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45716, 'spell_torch_tossing_training'),
(46630, 'spell_torch_tossing_training'),
(45907, 'spell_torch_target_picker'),
(45724, 'spell_braziers_hit');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN(46054, 45907)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` IN (1, 31)) AND (`ConditionTarget` = 0) AND (`ConditionValue1` IN (3, 45723)) AND (`ConditionValue2` IN (25535, 0)) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 46054, 0, 0, 31, 0, 3, 25535, 0, 0, 0, 0, '', 'Spell \'Torch Toss (land)\' targets \'[DNT] Torch Tossing Target Bunny\''),
(13, 1, 46054, 0, 0, 1, 0, 45723, 0, 0, 0, 0, 0, '', 'Spell \'Torch Toss (land)\' requires target with aura \'Target Indicator\''),
(13, 1, 45907, 0, 0, 31, 0, 3, 25535, 0, 0, 0, 0, '', 'Spell \'Torch Target Picker\' targets \'[DNT] Torch Tossing Target Bunny\'');
