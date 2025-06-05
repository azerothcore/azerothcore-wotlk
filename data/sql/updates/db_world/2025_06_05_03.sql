-- DB update 2025_06_05_02 -> 2025_06_05_03
-- Gundrak formations
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (127026,127009,127021,127059,127113);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(127026, 127026, 0, 0, 3, 0, 0), -- Cobras
(127026, 127027, 0, 0, 3, 0, 0),
(127026, 127016, 0, 0, 3, 0, 0),
(127009, 127009, 0, 0, 3, 0, 0),
(127009, 127010, 0, 0, 3, 0, 0),
(127009, 127018, 0, 0, 3, 0, 0),
(127021, 127021, 0, 0, 3, 0, 0),
(127021, 127022, 0, 0, 3, 0, 0),
(127021, 127012, 0, 0, 3, 0, 0),
(127059, 127059, 0, 0, 3, 0, 0), -- lancer/weaver/medicine before Moorabi
(127059, 127065, 0, 0, 3, 0, 0),
(127059, 127047, 0, 0, 3, 0, 0),
(127113, 127113, 0, 0, 3, 0, 0), -- inciter + 2 earthshakers
(127113, 127068, 0, 0, 3, 0, 0),
(127113, 127067, 0, 0, 3, 0, 0);

-- Lancer/Fire Weaver
UPDATE `creature_formations` SET `groupAI`=515 WHERE `memberGUID`=127045 AND `leaderGUID`=127045;
UPDATE `creature_formations` SET `groupAI`=515 WHERE `memberGUID`=127058 AND `leaderGUID`=127045;

-- God hunter/Medicine MANAGE
UPDATE `creature_formations` SET `groupAI`=515 WHERE `memberGUID`=127054 AND `leaderGUID`=127054;
UPDATE `creature_formations` SET `groupAI`=515 WHERE `memberGUID`=127064 AND `leaderGUID`=127054;
-- Note: Packs of 4 hunter/lancer/fire weaver/lancer seem to always social aggro, source looks similar

-- Spelldifficulty
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN(55700,55703,55602,55603,55659,55613,55622,55635,55636,16172,35946,55624,55599,55597,55530,55663,55348,55521);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(55700, 55700, 59019, 0, 0),
(55703, 55703, 59020, 0, 0),
(55602, 55602, 59021, 0, 0),
(55603, 55603, 59022, 0, 0),
(55659, 55659, 58972, 0, 0),
(55613, 55613, 58971, 0, 0),
(55622, 55622, 58978, 0, 0),
(55635, 55635, 58975, 0, 0),
(55636, 55636, 58977, 0, 0),
(16172, 16172, 58969, 0, 0),
(35946, 35946, 59146, 0, 0),
(55624, 55624, 58973, 0, 0),
(55599, 55599, 58981, 0, 0),
(55597, 55597, 58980, 0, 0),
(55530, 55530, 58991, 0, 0),
(55663, 55663, 58992, 0, 0),
(55348, 55348, 58966, 0, 0),
(55521, 55521, 58967, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (29774,29768,29822,29819,29832,29820,29829,29826,29838,29836));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29774, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 7000, 11000, 0, 0, 11, 55700, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spitting Cobra - In Combat - Cast \'Venom Spit\''),
(29774, 0, 1, 0, 0, 0, 100, 0, 2900, 6600, 10000, 12000, 0, 0, 11, 55703, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spitting Cobra - In Combat - Cast \'Cobra Strike\''),
(29768, 0, 0, 0, 0, 0, 100, 0, 1000, 5000, 7000, 11000, 0, 0, 11, 55602, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Constrictor - In Combat - Cast \'Vicious Bite\''),
(29768, 0, 1, 0, 0, 0, 100, 1, 1000, 1000, 0, 0, 0, 0, 11, 55603, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Constrictor - In Combat - Cast \'Puncturing Strike\' (No Repeat)'),
(29822, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 11000, 17000, 0, 0, 11, 55659, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - In Combat - Cast \'Lava Burst\''),
(29822, 0, 1, 0, 0, 0, 100, 0, 1000, 6000, 7000, 10000, 0, 0, 11, 55613, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - In Combat - Cast \'Flame Shock\''),
(29822, 0, 2, 0, 106, 0, 100, 0, 1000, 15000, 17000, 30000, 0, 10, 11, 61362, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Fire Weaver - On Hostile in Range - Cast \'Blast Wave\''),
(29819, 0, 0, 0, 0, 0, 100, 0, 1000, 6000, 12000, 18000, 0, 0, 11, 6713, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Lancer - In Combat - Cast \'Disarm\''),
(29819, 0, 1, 0, 0, 0, 100, 0, 1000, 12000, 17000, 20000, 0, 0, 11, 40546, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Lancer - In Combat - Cast \'Retaliation\''),
(29819, 0, 2, 0, 0, 0, 100, 0, 1000, 12000, 17000, 20000, 0, 0, 11, 55622, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Lancer - In Combat - Cast \'Impale\''),
(29832, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 11000, 17000, 0, 0, 11, 55635, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Thunderclap'),
(29832, 0, 1, 0, 0, 0, 100, 0, 1000, 9000, 17000, 20000, 0, 0, 11, 55636, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Shockwave'),
(29832, 0, 2, 0, 0, 0, 100, 0, 1000, 15000, 17000, 30000, 0, 0, 11, 55633, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Golem - In Combat - Cast Body of Stone'),
(29820, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 0, 0, 11, 35946, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast \'Shoot\''),
(29820, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 8000, 12000, 0, 0, 11, 55624, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast \'Arcane Shot\''),
(29820, 0, 2, 0, 4, 0, 50, 0, 0, 0, 0, 0, 0, 0, 11, 55798, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - On Aggro - Cast \'Flare\''),
(29820, 0, 3, 0, 0, 0, 100, 0, 1000, 11000, 20000, 32000, 0, 0, 11, 31567, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari God Hunter - In Combat - Cast \'Deterrence\''),
(29829, 0, 0, 0, 0, 0, 100, 0, 4000, 8000, 11000, 17000, 0, 0, 11, 16172, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Earthshaker - In Combat - Cast \'Head Crack\''),
(29829, 0, 1, 0, 0, 0, 100, 0, 1000, 9000, 7000, 11000, 0, 0, 11, 55567, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Earthshaker - In Combat - Cast \'Powerful Blow\''),
(29829, 0, 2, 0, 0, 0, 100, 0, 1000, 8000, 10000, 12000, 0, 0, 11, 55563, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Earthshaker - In Combat - Cast \'Slam Ground\''),
(29826, 0, 0, 0, 16, 0, 100, 0, 55599, 30, 6000, 6000, 0, 0, 11, 55599, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - On Friendly Unit Missing Buff \'Earth Shield\' - Cast \'Earth Shield\''),
(29826, 0, 1, 0, 14, 0, 100, 0, 15000, 30, 7250, 10000, 0, 0, 11, 55597, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - Friendly At 15000 Health - Cast \'Healing Wave\''),
(29826, 0, 2, 0, 15, 0, 100, 0, 30, 10000, 10000, 0, 0, 0, 11, 55598, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Medicine Man - On Friendly Crowd Controlled - Cast \'Cleanse Magic\''),
(29838, 0, 0, 0, 9, 0, 100, 512, 0, 0, 8000, 8000, 5, 40, 11, 55530, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - Within 5-40 Range - Cast \'Charge\''),
(29838, 0, 1, 0, 0, 0, 100, 512, 0, 10000, 8000, 22000, 0, 0, 11, 55663, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Rhino - In Combat - Cast \'Deafening Roar\''),
(29836, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2000, 2000, 0, 0, 11, 55348, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Rider - In Combat - Cast \'Throw\''),
(29836, 0, 1, 0, 0, 0, 100, 0, 0, 10000, 8000, 22000, 0, 0, 11, 55521, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakkari Battle Rider - In Combat - Cast \'Poisoned Spear\'');
