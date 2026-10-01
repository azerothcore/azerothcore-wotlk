-- Sar'this (23093) - The Soul Cannon of Reth'hedron (11089): elemental ritual for the Flawless Arcane Essence
-- Sniffed: 3.4.3.52237 (one run) and 4.4.0.54901 (two runs), identical paths, texts and spawn points

-- Gossip: drop the custom "Start the ritual." option, the envoy option starts the ritual while on the quest
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 8725 AND `OptionID` = 1;
UPDATE `gossip_menu_option` SET `VerifiedBuild` = 52237 WHERE `MenuID` = 8725 AND `OptionID` = 0;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 8725 AND `SourceEntry` IN (0, 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8725, 0, 0, 0, 9, 0, 11089, 0, 0, 0, 0, 0, '', 'Sar''this - Show gossip option 0 if quest The Soul Cannon of Reth''hedron is taken');

-- The arcane elemental is summoned by the SAI below, not by the Summon Arcane Elemental send event
DELETE FROM `event_scripts` WHERE `id` = 14860;

-- Summon Fetish (40164) destination
DELETE FROM `spell_target_position` WHERE `ID` = 40164 AND `EffectIndex` = 0;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(40164, 0, 530, -2466.6, 4699.98, 156.65, 3.14159, 52237);

-- Missing Terokkar Trigger at the earth ritual spot
DELETE FROM `creature` WHERE `guid` = 40252 AND `id` = 23102;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`) VALUES
(40252, 23102, 530, 1, 1, -2384.98, 4552.59, 165.77, 0.2443, 120, 52237, 1);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (23094, 23096, 23097, 23098, 23099, 23100, 23102);
UPDATE `creature_template` SET `faction` = 91, `unit_flags` = 256 WHERE `entry` = 23100;

-- Sar'this: NO_MOVE_FLAGS_UPDATE so the movement flag refresh doesn't drop him while the elemental levitates him
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|512 WHERE `entry` = 23093;

DELETE FROM `creature_text` WHERE `CreatureID` IN (23093, 23100);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23093, 0, 0, 'So my blood was not a sufficient payment, eh? Fine, let us recover your arcane essence. After this, I owe Balthas nothing.', 12, 0, 100, 1, 0, 0, 20913, 0, 'Sar''this'),
(23093, 1, 0, '%s places a fetish at the ritual pile.', 16, 0, 100, 16, 0, 0, 20914, 0, 'Sar''this'),
(23093, 2, 0, 'The process is arduous. We must first summon forth acolytes of the elements. You must then destroy these acolytes so that my minions can make preparations.', 12, 0, 100, 0, 0, 0, 20915, 0, 'Sar''this'),
(23093, 3, 0, 'Well done!  Let''s continue.', 12, 0, 100, 1, 0, 0, 20916, 0, 'Sar''this'),
(23093, 4, 0, 'Prepare yourself! The acolyte of water is soon to come...', 12, 0, 100, 0, 0, 0, 20917, 0, 'Sar''this'),
(23093, 5, 0, 'Come forth, acolyte of earth!', 12, 0, 100, 0, 0, 0, 20918, 0, 'Sar''this'),
(23093, 6, 0, 'Fire, show yourself!', 12, 0, 100, 0, 0, 0, 20919, 0, 'Sar''this'),
(23093, 7, 0, 'Now we call forth the arcane acolyte.', 12, 0, 100, 0, 0, 0, 20920, 0, 'Sar''this'),
(23093, 8, 0, 'It is yours my Lord!', 12, 0, 100, 0, 0, 0, 20971, 0, 'Sar''this'),
(23100, 0, 0, 'I require your life essence to maintain my existence in this realm.', 12, 0, 100, 0, 0, 0, 20970, 0, 'Flawless Arcane Elemental');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 23093 AND `summonerType` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(23093, 0, 0, 23096, -2482.2688, 4661.7217, 161.50037, 0.942477762699127197, 4, 300000, 'Sar''this - Acolyte of Air'),
(23093, 0, 1, 23097, -2443.984, 4634.1143, 158.27632, 1.047197580337524414, 4, 300000, 'Sar''this - Acolyte of Water'),
(23093, 0, 2, 23098, -2385.025, 4552.593, 165.76314, 2.146754980087280273, 4, 300000, 'Sar''this - Acolyte of Earth'),
(23093, 0, 3, 23099, -2425.9739, 4444.5195, 167.24365, 1.884955525398254394, 4, 300000, 'Sar''this - Acolyte of Fire'),
(23093, 0, 4, 23100, -2470.5989, 4700.025, 155.98538, 3.159045934677124023, 4, 300000, 'Sar''this - Flawless Arcane Elemental');

-- Paths: Sar'this 966740-966745 (one per ritual leg), minions guid*10 (to the ritual spot) and guid*10+1 (to the pile)
DELETE FROM `waypoint_data` WHERE `id` IN (966740, 966741, 966742, 966743, 966744, 966745, 966750, 966751, 966760, 966761, 966770, 966771, 966780, 966781);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
-- Sar'this - to the ritual pile
(966740, 1, -2520.7363, 4665.9805, 170.46237, NULL, 0, 0, 0, 0, 0, 100, 0),
(966740, 2, -2497.4863, 4677.7305, 159.96237, NULL, 0, 0, 0, 0, 0, 100, 0),
(966740, 3, -2474.8274, 4698.741, 155.34444, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Sar'this - to the air spot
(966741, 1, -2476.9912, 4670.7393, 159.31421, NULL, 0, 0, 0, 0, 0, 100, 0),
(966741, 2, -2480.1553, 4665.2373, 160.28397, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Sar'this - to the water spot
(966742, 1, -2475.0647, 4665.176, 159.62802, NULL, 0, 0, 0, 0, 0, 100, 0),
(966742, 2, -2451.3147, 4661.926, 160.62802, NULL, 0, 0, 0, 0, 0, 100, 0),
(966742, 3, -2434.3147, 4652.426, 160.87802, NULL, 0, 0, 0, 0, 0, 100, 0),
(966742, 4, -2439.974, 4639.614, 157.97209, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Sar'this - to the earth spot
(966743, 1, -2430.419, 4652.3037, 160.94476, NULL, 0, 0, 0, 0, 0, 100, 0),
(966743, 2, -2408.669, 4633.5537, 160.44476, NULL, 0, 0, 0, 0, 0, 100, 0),
(966743, 3, -2407.919, 4618.8037, 161.19476, NULL, 0, 0, 0, 0, 0, 100, 0),
(966743, 4, -2417.419, 4590.0537, 160.94476, NULL, 0, 0, 0, 0, 0, 100, 0),
(966743, 5, -2397.169, 4581.0537, 165.44476, NULL, 0, 0, 0, 0, 0, 100, 0),
(966743, 6, -2389.419, 4571.8037, 165.69476, NULL, 0, 0, 0, 0, 0, 100, 0),
(966743, 7, -2388.364, 4560.494, 165.41743, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Sar'this - to the fire spot
(966744, 1, -2392.2705, 4544.8784, 165.78146, NULL, 0, 0, 0, 0, 0, 100, 0),
(966744, 2, -2408.0205, 4533.6284, 166.28146, NULL, 0, 0, 0, 0, 0, 100, 0),
(966744, 3, -2418.7705, 4514.1284, 166.53146, NULL, 0, 0, 0, 0, 0, 100, 0),
(966744, 4, -2425.0205, 4497.1284, 165.78146, NULL, 0, 0, 0, 0, 0, 100, 0),
(966744, 5, -2429.6772, 4462.2627, 166.1455, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Sar'this - back to the ritual pile
(966745, 1, -2428.6582, 4469.6553, 166.42581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 2, -2425.9082, 4495.1553, 165.67581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 3, -2408.6582, 4533.4053, 166.17581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 4, -2391.9082, 4547.4053, 165.67581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 5, -2391.6582, 4575.4053, 166.17581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 6, -2416.6582, 4588.9053, 160.67581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 7, -2407.9082, 4629.9053, 160.67581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 8, -2433.4082, 4655.4053, 160.67581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 9, -2466.4082, 4662.9053, 159.92581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 10, -2482.4082, 4675.9053, 158.42581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 11, -2481.1582, 4699.9053, 154.92581, NULL, 0, 0, 0, 0, 0, 100, 0),
(966745, 12, -2475.1394, 4700.0474, 155.20612, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Minion of Sar'this (air, 96675)
(966750, 1, -2489.7937, 4719.397, 154.06015, NULL, 0, 0, 0, 0, 0, 100, 0),
(966750, 2, -2494.231, 4699.902, 155.51555, NULL, 0, 0, 0, 0, 0, 100, 0),
(966751, 1, -2473.62, 4706.47, 155.3152, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Minion of Sar'this (water, 96676)
(966760, 1, -2447.2363, 4682.5684, 168.33333, NULL, 0, 0, 0, 0, 0, 100, 0),
(966760, 2, -2439.1711, 4666.5415, 162.53188, NULL, 0, 0, 0, 0, 0, 100, 0),
(966761, 1, -2453.0022, 4660.636, 160.05573, NULL, 0, 0, 0, 0, 0, 100, 0),
(966761, 2, -2472.8137, 4666.549, 159.45682, NULL, 0, 0, 0, 0, 0, 100, 0),
(966761, 3, -2479.3704, 4689.0933, 155.35364, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Minion of Sar'this (earth, 96677)
(966770, 1, -2418.96, 4585.215, 160.52164, NULL, 0, 0, 0, 0, 0, 100, 0),
(966771, 1, -2407.7148, 4621.8384, 160.63263, NULL, 0, 0, 0, 0, 0, 100, 0),
(966771, 2, -2409.0486, 4633.804, 160.17317, NULL, 0, 0, 0, 0, 0, 100, 0),
(966771, 3, -2433.647, 4654.025, 160.58592, NULL, 0, 0, 0, 0, 0, 100, 0),
(966771, 4, -2460.788, 4663.0186, 159.63501, NULL, 0, 0, 0, 0, 0, 100, 0),
(966771, 5, -2480.1487, 4674.124, 158.42819, NULL, 0, 0, 0, 0, 0, 100, 0),
(966771, 6, -2477.52, 4696.75, 155.00604, NULL, 0, 0, 0, 0, 0, 100, 0),
-- Minion of Sar'this (fire, 96678)
(966780, 1, -2408.4812, 4545.998, 164.19621, NULL, 0, 0, 0, 0, 0, 100, 0),
(966780, 2, -2401.6074, 4540.1885, 166.06267, NULL, 0, 0, 0, 0, 0, 100, 0),
(966780, 3, -2415.701, 4524.7017, 166.11513, NULL, 0, 0, 0, 0, 0, 100, 0),
(966780, 4, -2429.487, 4484.633, 167.005, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 1, -2423.84, 4499.896, 165.94519, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 2, -2407.434, 4533.195, 166.11488, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 3, -2390.757, 4551.5806, 165.4837, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 4, -2395.6914, 4579.208, 165.6277, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 5, -2417.9414, 4588.5493, 160.52565, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 6, -2409.0825, 4617.851, 160.69273, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 7, -2408.6985, 4633.0317, 160.15553, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 8, -2434.9668, 4655.1216, 160.58493, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 9, -2468.4978, 4664.003, 159.47131, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 10, -2478.47, 4677.216, 157.5378, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 11, -2477.5417, 4688.904, 155.766, NULL, 0, 0, 0, 0, 0, 100, 0),
(966781, 12, -2472.25, 4694.06, 155.92844, NULL, 0, 0, 0, 0, 0, 100, 0);

-- Each acolyte's essence goes to one specific minion
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` IN (40156, 40187, 40189, 40190);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 40156, 0, 0, 31, 0, 3, 23094, 96675, 0, 0, 0, '', 'Essence of Wind - Target Minion of Sar''this (96675)'),
(13, 1, 40187, 0, 0, 31, 0, 3, 23094, 96676, 0, 0, 0, '', 'Essence of Water - Target Minion of Sar''this (96676)'),
(13, 1, 40189, 0, 0, 31, 0, 3, 23094, 96677, 0, 0, 0, '', 'Essence of Earth - Target Minion of Sar''this (96677)'),
(13, 1, 40190, 0, 0, 31, 0, 3, 23094, 96678, 0, 0, 0, '', 'Essence of Fire - Target Minion of Sar''this (96678)');

-- Only an acolyte left alive (ritual abandoned) resets Sar'this, not a corpse decaying
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 14 AND `SourceEntry` = 23093 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 14, 23093, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', 'Sar''this - On Summon Despawned - Only if the summon is alive'),
(22, 14, 23093, 0, 0, 31, 0, 3, 23100, 0, 1, 0, 0, '', 'Sar''this - On Summon Despawned - Not the Flawless Arcane Elemental');

-- Sar'this
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23093 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 2309300 AND 2309312 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23093, 0, 0, 1, 62, 0, 100, 1, 8725, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Gossip Option 0 Selected - Close Gossip (No Repeat)'),
(23093, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2309300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Link - Run Script'),
(23093, 0, 2, 0, 109, 0, 100, 0, 0, 966740, 0, 0, 0, 0, 80, 2309301, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Path 966740 Finished - Run Script'),
(23093, 0, 3, 0, 109, 0, 100, 0, 0, 966741, 0, 0, 0, 0, 80, 2309302, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Path 966741 Finished - Run Script'),
(23093, 0, 4, 0, 82, 0, 100, 0, 23096, 0, 0, 0, 0, 0, 80, 2309303, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Acolyte of Air Died - Run Script'),
(23093, 0, 5, 0, 109, 0, 100, 0, 0, 966742, 0, 0, 0, 0, 80, 2309304, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Path 966742 Finished - Run Script'),
(23093, 0, 6, 0, 82, 0, 100, 0, 23097, 0, 0, 0, 0, 0, 80, 2309305, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Acolyte of Water Died - Run Script'),
(23093, 0, 7, 0, 109, 0, 100, 0, 0, 966743, 0, 0, 0, 0, 80, 2309306, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Path 966743 Finished - Run Script'),
(23093, 0, 8, 0, 82, 0, 100, 0, 23098, 0, 0, 0, 0, 0, 80, 2309307, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Acolyte of Earth Died - Run Script'),
(23093, 0, 9, 0, 109, 0, 100, 0, 0, 966744, 0, 0, 0, 0, 80, 2309308, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Path 966744 Finished - Run Script'),
(23093, 0, 10, 0, 82, 0, 100, 0, 23099, 0, 0, 0, 0, 0, 80, 2309309, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Acolyte of Fire Died - Run Script'),
(23093, 0, 11, 0, 109, 0, 100, 0, 0, 966745, 0, 0, 0, 0, 80, 2309310, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Path 966745 Finished - Run Script'),
(23093, 0, 12, 0, 8, 0, 100, 0, 35519, 0, 0, 0, 0, 0, 80, 2309311, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Spellhit \'White Beam\' - Run Script'),
(23093, 0, 13, 0, 35, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2309312, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - On Summon Despawned - Run Script'),
-- Gossip selected
(2309300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Remove Npc Flag Gossip'),
(2309300, 9, 1, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 0'),
(2309300, 9, 2, 0, 0, 0, 100, 0, 3100, 3100, 0, 0, 0, 0, 232, 966740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Start Path 966740'),
-- At the ritual pile
(2309301, 9, 0, 0, 0, 0, 100, 0, 700, 700, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 1'),
(2309301, 9, 1, 0, 0, 0, 100, 0, 3100, 3100, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.754484, 'Sar''this - Actionlist - Set Orientation'),
(2309301, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Cast \'Summon Fetish\''),
(2309301, 9, 3, 0, 0, 0, 100, 0, 6450, 6450, 0, 0, 0, 0, 232, 966741, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Start Path 966741'),
-- Air
(2309302, 9, 0, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.15407, 'Sar''this - Actionlist - Set Orientation'),
(2309302, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40129, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Cast \'Summon Air Elemental\''),
(2309302, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 2'),
(2309302, 9, 3, 0, 0, 0, 100, 0, 2900, 2900, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 40265, 23102, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Terokkar Trigger (40265)'),
(2309302, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 96675, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Minion of Sar''this (96675)'),
(2309302, 9, 5, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Summon Creature Group 0'),
-- Acolyte of Air died
(2309303, 9, 0, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 3'),
(2309303, 9, 1, 0, 0, 0, 100, 0, 2650, 2650, 0, 0, 0, 0, 232, 966742, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Start Path 966742'),
-- Water
(2309304, 9, 0, 0, 0, 0, 100, 0, 450, 450, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.28567, 'Sar''this - Actionlist - Set Orientation'),
(2309304, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40130, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Cast \'Summon Water Elemental\''),
(2309304, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 4'),
(2309304, 9, 3, 0, 0, 0, 100, 0, 2900, 2900, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 40263, 23102, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Terokkar Trigger (40263)'),
(2309304, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 96676, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Minion of Sar''this (96676)'),
(2309304, 9, 5, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Summon Creature Group 1'),
-- Acolyte of Water died
(2309305, 9, 0, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 3'),
(2309305, 9, 1, 0, 0, 0, 100, 0, 2650, 2650, 0, 0, 0, 0, 232, 966743, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Start Path 966743'),
-- Earth
(2309306, 9, 0, 0, 0, 0, 100, 0, 1550, 1550, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.81141, 'Sar''this - Actionlist - Set Orientation'),
(2309306, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40132, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Cast \'Summon Earth Elemental\''),
(2309306, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 5'),
(2309306, 9, 3, 0, 0, 0, 100, 0, 2900, 2900, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 40252, 23102, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Terokkar Trigger (40252)'),
(2309306, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 96677, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Minion of Sar''this (96677)'),
(2309306, 9, 5, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Summon Creature Group 2'),
-- Acolyte of Earth died
(2309307, 9, 0, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 3'),
(2309307, 9, 1, 0, 0, 0, 100, 0, 2700, 2700, 0, 0, 0, 0, 232, 966744, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Start Path 966744'),
-- Fire
(2309308, 9, 0, 0, 0, 0, 100, 0, 1300, 1300, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.58604, 'Sar''this - Actionlist - Set Orientation'),
(2309308, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40133, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Cast \'Summon Fire Elemental\''),
(2309308, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 6'),
(2309308, 9, 3, 0, 0, 0, 100, 0, 2900, 2900, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 11, 23102, 35, 1, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Terokkar Triggers'),
(2309308, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, 96678, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 1 on Minion of Sar''this (96678)'),
(2309308, 9, 5, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 0, 107, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Summon Creature Group 3'),
-- Acolyte of Fire died
(2309309, 9, 0, 0, 0, 0, 100, 0, 350, 350, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 3'),
(2309309, 9, 1, 0, 0, 0, 100, 0, 2650, 2650, 0, 0, 0, 0, 232, 966745, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Start Path 966745'),
-- Arcane
(2309310, 9, 0, 0, 0, 0, 100, 0, 1450, 1450, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0.00548, 'Sar''this - Actionlist - Set Orientation'),
(2309310, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40134, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Cast \'Summon Arcane Elemental\''),
(2309310, 9, 2, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 7'),
(2309310, 9, 3, 0, 0, 0, 100, 0, 3150, 3150, 0, 0, 0, 0, 28, 40156, 0, 0, 0, 0, 0, 10, 96675, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Remove Aura \'Essence of Wind\' from Minion of Sar''this (96675)'),
(2309310, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 40187, 0, 0, 0, 0, 0, 10, 96676, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Remove Aura \'Essence of Water\' from Minion of Sar''this (96676)'),
(2309310, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 40189, 0, 0, 0, 0, 0, 10, 96677, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Remove Aura \'Essence of Earth\' from Minion of Sar''this (96677)'),
(2309310, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 40190, 0, 0, 0, 0, 0, 10, 96678, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Remove Aura \'Essence of Fire\' from Minion of Sar''this (96678)'),
(2309310, 9, 7, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 107, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Summon Creature Group 4'),
(2309310, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 1, 0, 0, 0, 15, 185856, 30, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Despawn Fetish of Sar''this'),
(2309310, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96675, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96675)'),
-- Given to the Flawless Arcane Elemental
(2309311, 9, 0, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Say Line 8'),
(2309311, 9, 1, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Disable Gravity'),
(2309311, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -2470.6914, 4700.032, 160.24997, 0, 'Sar''this - Actionlist - Move To Position'),
(2309311, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96676, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96676)'),
(2309311, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96677, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96677)'),
(2309311, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96678, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96678)'),
(2309311, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Despawn (Respawn 30s)'),
-- Ritual abandoned
(2309312, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96675, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96675)'),
(2309312, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96676, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96676)'),
(2309312, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96677, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96677)'),
(2309312, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, 96678, 23094, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Do Action 2 on Minion of Sar''this (96678)'),
(2309312, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 1, 0, 0, 0, 15, 185856, 100, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Despawn Fetish of Sar''this'),
(2309312, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sar''this - Actionlist - Despawn (Respawn 30s)');

-- Minions of Sar'this: walk to the ritual spot, take the essence to the pile, beam it until Sar'this is consumed, walk home
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-96675, -96676, -96677, -96678) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 2309400 AND 2309411 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-96675, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, 966750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 1 Done - Start Path 966750'),
(-96675, 0, 1, 0, 8, 0, 100, 0, 40156, 0, 0, 0, 0, 0, 80, 2309400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Spellhit \'Essence of Wind\' - Run Script'),
(-96675, 0, 2, 0, 109, 0, 100, 0, 0, 966751, 0, 0, 0, 0, 80, 2309401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Path 966751 Finished - Run Script'),
(-96675, 0, 3, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2309402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 2 Done - Run Script'),
(-96675, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.68977, 'Minion of Sar''this - On Point 1 Reached - Set Orientation'),
(-96676, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, 966760, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 1 Done - Start Path 966760'),
(-96676, 0, 1, 0, 8, 0, 100, 0, 40187, 0, 0, 0, 0, 0, 80, 2309403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Spellhit \'Essence of Water\' - Run Script'),
(-96676, 0, 2, 0, 109, 0, 100, 0, 0, 966761, 0, 0, 0, 0, 80, 2309404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Path 966761 Finished - Run Script'),
(-96676, 0, 3, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2309405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 2 Done - Run Script'),
(-96676, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.9619, 'Minion of Sar''this - On Point 1 Reached - Set Orientation'),
(-96677, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, 966770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 1 Done - Start Path 966770'),
(-96677, 0, 1, 0, 8, 0, 100, 0, 40189, 0, 0, 0, 0, 0, 80, 2309406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Spellhit \'Essence of Earth\' - Run Script'),
(-96677, 0, 2, 0, 109, 0, 100, 0, 0, 966771, 0, 0, 0, 0, 80, 2309407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Path 966771 Finished - Run Script'),
(-96677, 0, 3, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2309408, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 2 Done - Run Script'),
(-96677, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 4.10152, 'Minion of Sar''this - On Point 1 Reached - Set Orientation'),
(-96678, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 232, 966780, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 1 Done - Start Path 966780'),
(-96678, 0, 1, 0, 8, 0, 100, 0, 40190, 0, 0, 0, 0, 0, 80, 2309409, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Spellhit \'Essence of Fire\' - Run Script'),
(-96678, 0, 2, 0, 109, 0, 100, 0, 0, 966781, 0, 0, 0, 0, 80, 2309410, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Path 966781 Finished - Run Script'),
(-96678, 0, 3, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2309411, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - On Action 2 Done - Run Script'),
(-96678, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.58825, 'Minion of Sar''this - On Point 1 Reached - Set Orientation'),
-- 96675 (air)
(2309400, 9, 0, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 232, 966751, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Start Path 966751'),
(2309401, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 40193, 0, 0, 0, 0, 0, 10, 40264, 23102, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Cast \'White Beam\''),
(2309402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Interrupt Spell'),
(2309402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -2452.38, 4760.84, 153.167, 0, 'Minion of Sar''this - Actionlist - Move To Home'),
-- 96676 (water)
(2309403, 9, 0, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 232, 966761, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Start Path 966761'),
(2309404, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 40225, 0, 0, 0, 0, 0, 10, 40264, 23102, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Cast \'Blue Beam\''),
(2309405, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Interrupt Spell'),
(2309405, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -2430.96, 4701.74, 175.406, 0, 'Minion of Sar''this - Actionlist - Move To Home'),
-- 96677 (earth)
(2309406, 9, 0, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 232, 966771, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Start Path 966771'),
(2309407, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 40227, 0, 0, 0, 0, 0, 10, 40264, 23102, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Cast \'Green Beam\''),
(2309408, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Interrupt Spell'),
(2309408, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -2424.75, 4658.27, 160.535, 0, 'Minion of Sar''this - Actionlist - Move To Home'),
-- 96678 (fire)
(2309409, 9, 0, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 232, 966781, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Start Path 966781'),
(2309410, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 40228, 0, 0, 0, 0, 0, 10, 40264, 23102, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Cast \'Red Beam\''),
(2309411, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 92, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Minion of Sar''this - Actionlist - Interrupt Spell'),
(2309411, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -2419.45, 4562.04, 160.518, 0, 'Minion of Sar''this - Actionlist - Move To Home');

-- Terokkar Triggers: element visuals at each ritual spot
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-40252, -40253, -40254, -40255, -40256, -40257, -40258, -40259, -40260, -40261, -40262, -40263, -40265) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2310200, 2310201) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-40265, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40136, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Lightning Cloud\''),
(-40263, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2310200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Run Script'),
(-40252, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2310201, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Run Script'),
(-40253, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40254, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40255, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40256, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40257, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40258, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40259, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40260, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40261, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(-40262, 0, 0, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40148, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - On Action 1 Done - Cast \'Immolation\''),
(2310200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Water Spout\''),
(2310200, 9, 1, 0, 0, 0, 100, 0, 1800, 1800, 0, 0, 0, 0, 11, 40141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Water Spout\''),
(2310200, 9, 2, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 40141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Water Spout\''),
(2310200, 9, 3, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 40141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Water Spout\''),
(2310200, 9, 4, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 40141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Water Spout\''),
(2310201, 9, 0, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 0, 11, 40147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Rock Torrent\''),
(2310201, 9, 1, 0, 0, 0, 100, 0, 2350, 2350, 0, 0, 0, 0, 11, 40147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Rock Torrent\''),
(2310201, 9, 2, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 40147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Rock Torrent\''),
(2310201, 9, 3, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 40147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Rock Torrent\''),
(2310201, 9, 4, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 40147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Terokkar Trigger - Actionlist - Cast \'Rock Torrent\'');

-- Acolytes: spawn visual (water, earth) and the essence cast on death
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23096, 23097, 23098, 23099) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23096, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40156, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte of Air - On Just Died - Cast \'Essence of Wind\''),
(23097, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40141, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte of Water - On Just Summoned - Cast \'Water Spout\''),
(23097, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40187, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte of Water - On Just Died - Cast \'Essence of Water\''),
(23098, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte of Earth - On Just Summoned - Cast \'Rock Torrent\''),
(23098, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40189, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte of Earth - On Just Died - Cast \'Essence of Earth\''),
(23099, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40190, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Acolyte of Fire - On Just Died - Cast \'Essence of Fire\'');

-- Flawless Arcane Elemental
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23100 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2310000 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23100, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2310000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flawless Arcane Elemental - On Just Summoned - Run Script'),
(2310000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34166, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flawless Arcane Elemental - Actionlist - Cast \'Coalesce\''),
(2310000, 9, 1, 0, 0, 0, 100, 0, 3100, 3100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flawless Arcane Elemental - Actionlist - Say Line 0'),
(2310000, 9, 2, 0, 0, 0, 100, 0, 2800, 2800, 0, 0, 0, 0, 11, 35519, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flawless Arcane Elemental - Actionlist - Cast \'White Beam\''),
(2310000, 9, 3, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flawless Arcane Elemental - Actionlist - Remove Flag Immune To Players');
