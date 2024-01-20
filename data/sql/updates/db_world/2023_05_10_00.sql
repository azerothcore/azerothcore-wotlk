-- DB update 2023_05_09_02 -> 2023_05_10_00
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (32329, 34163, 34171, 31410, 31407, 22887);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(32329, 32329, 37965),
(34163, 34163, 37967),
(34171, 34171, 37956),
(31410, 31410, 37973),
(31407, 31407, 39413),
(22887, 22887, 40317);

-- Complete Rewrites
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (17871, 17723, 17724, 17731, 17732, 20465, 19632, 17726, 17728, 17771, 17735, 17727, 17729, 17734));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17871, 0, 0, 0, 0, 0, 100, 0, 5600, 6100, 13350, 17000, 0, 11, 32329, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - In Combat - Cast \'Itchy Spores\''),
(17871, 0, 1, 0, 2, 0, 100, 0, 0, 75, 25000, 30000, 0, 11, 34163, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - Between 0-75% Health - Cast \'Fungal Regrowth\''),
(17871, 0, 2, 0, 0, 0, 100, 0, 1200, 8700, 16000, 22000, 0, 11, 31427, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Shambler - In Combat - Cast \'Allergies\''),
(17723, 0, 0, 0, 0, 0, 100, 0, 7100, 9700, 21850, 29250, 0, 11, 32065, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - In Combat - Cast \'Fungal Decay\''),
(17723, 0, 1, 0, 0, 0, 100, 4, 10000, 10000, 10000, 10000, 0, 11, 40318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - In Combat - Cast \'Growth\' (Heroic Dungeon)'),
(17723, 0, 2, 0, 0, 0, 100, 0, 4500, 9600, 18200, 27100, 0, 11, 15550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - In Combat - Cast \'Trample\''),
(17723, 0, 3, 4, 2, 0, 100, 3, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - Between 0-30% Health - Cast \'Enrage\' (Normal Dungeon)'),
(17723, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bog Giant - Between 0-30% Health - Say Line 0 (Normal Dungeon)'),
(17724, 0, 0, 0, 67, 0, 100, 0, 1200, 12500, 0, 0, 0, 11, 34171, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbat - On Behind Target - Cast \'Tentacle Lash\''),
(17731, 0, 0, 0, 0, 0, 100, 0, 5800, 11850, 16300, 21500, 0, 11, 34984, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Fen Ray - In Combat - Cast \'Psychic Horror\''),
(17732, 0, 0, 0, 0, 0, 100, 0, 1600, 3200, 2850, 4900, 0, 11, 32330, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lykul Wasp - In Combat - Cast \'Poison Spit\''),
(17732, 0, 1, 2, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lykul Wasp - Between 0-30% Health - Cast \'Enrage\''),
(17732, 0, 2, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lykul Wasp - Linked - Say Line 0'),
(17732, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 3, 0, 18722, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hack: Lykul Wasp - On Respawn - Morph To Model 18722'),
(20465, 0, 0, 0, 0, 0, 100, 0, 1200, 9600, 15350, 17000, 0, 11, 12097, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Frenzy - In Combat - Cast \'Pierce Armor\''),
(20465, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Frenzy - On Reset - Set Run On'),
(19632, 0, 0, 1, 2, 0, 100, 0, 0, 50, 14000, 18000, 0, 11, 34392, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lykul Stinger - Between 0-50% Health - Cast \'Stinger Rage\''),
(19632, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lykul Stinger - Between 0-50% Health - Say Line 0'),
(19632, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 3, 0, 19367, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hack: Lykul Stinger - On Reset - Morph To Model 19367'),
(17726, 0, 0, 0, 4, 0, 50, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Myrmidon - On Aggro - Say Line 0'),
(17726, 0, 1, 0, 0, 0, 100, 0, 4050, 16450, 10900, 21300, 0, 11, 31410, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Myrmidon - In Combat - Cast \'Coral Cut\''),
(17728, 0, 0, 0, 0, 0, 100, 0, 3650, 8700, 1200, 18250, 0, 11, 12057, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Tribesman - In Combat - Cast \'Strike\''),
(17728, 0, 1, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Tribesman - Between 0-30% Health - Cast \'Enrage\' (No Repeat)'),
(17771, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 900000, 900000, 0, 11, 34880, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - Out of Combat - Cast \'Elemental Armor\''),
(17771, 0, 1, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 31, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Set Random Phase (1-3) (No Repeat)'),
(17771, 0, 2, 0, 0, 1, 100, 2, 0, 0, 3200, 4800, 0, 11, 15497, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat CMC - Cast \'Frostbolt\' (Phase 1) (Normal Dungeon)'),
(17771, 0, 3, 0, 0, 1, 100, 4, 0, 0, 3200, 4800, 0, 11, 12675, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat CMC - Cast \'Frostbolt\' (Phase 1) (Heroic Dungeon)'),
(17771, 0, 4, 0, 0, 1, 100, 2, 8700, 8700, 19000, 19000, 0, 11, 32192, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast \'Frost Nova\' (Phase 1) (Normal Dungeon)'),
(17771, 0, 5, 0, 0, 1, 100, 4, 8700, 8700, 19000, 19000, 0, 11, 15531, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast \'Frost Nova\' (Phase 1) (Heroic Dungeon)'),
(17771, 0, 6, 0, 0, 2, 100, 2, 0, 0, 2400, 3800, 0, 11, 14034, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat CMC - Cast \'Fireball\' (Phase 2) (Normal Dungeon)'),
(17771, 0, 7, 0, 0, 2, 100, 4, 0, 0, 2400, 3800, 0, 11, 15228, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat CMC - Cast \'Fireball\' (Phase 2) (Heroic Dungeon)'),
(17771, 0, 8, 0, 0, 2, 100, 2, 3600, 3600, 12000, 15000, 0, 11, 15241, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast \'Scorch\' (Phase 2) (Normal Dungeon)'),
(17771, 0, 9, 0, 0, 2, 100, 4, 3600, 3600, 9000, 12000, 0, 11, 36807, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast \'Scorch\' (Phase 2) (Heroic Dungeon)'),
(17771, 0, 10, 0, 0, 4, 100, 2, 0, 0, 3100, 4700, 0, 11, 12471, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat CMC - Cast \'Shadow Bolt\' (Phase 3) (Normal Dungeon)'),
(17771, 0, 11, 0, 0, 4, 100, 4, 0, 0, 3100, 4700, 0, 11, 15232, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat CMC - Cast \'Shadow Bolt\' (Phase 3) (Heroic Dungeon)'),
(17771, 0, 12, 0, 0, 4, 100, 2, 7600, 7600, 3600, 10100, 0, 11, 31405, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast \'Corruption\' (Phase 3) (Normal Dungeon)'),
(17771, 0, 13, 0, 0, 4, 100, 4, 7600, 7600, 6700, 6700, 0, 11, 37113, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast \'Corruption\' (Phase 3) (Heroic Dungeon)'),
(17771, 0, 14, 0, 0, 0, 100, 0, 3000, 9000, 15000, 250000, 0, 11, 34880, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - In Combat - Cast \'Elemental Armor\''),
(17771, 0, 15, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Oracle - Between 0-15% Health - Flee For Assist (No Repeat)'),
(17735, 0, 0, 0, 4, 0, 75, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - On Aggro - Say Line 0'),
(17735, 0, 1, 0, 0, 0, 100, 0, 4850, 9400, 1200, 24250, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - In Combat - Cast \'Strike\''),
(17735, 0, 2, 0, 13, 0, 100, 0, 4600, 4600, 0, 0, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - On Victim Casting - Cast \'Shield Bash\''),
(17735, 0, 3, 4, 2, 0, 100, 1, 0, 20, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - Between 0-20% Health - Cast \'Enrage\''),
(17735, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Warrior - Between 0-20% Health - Say Line 1'),
(17727, 0, 0, 0, 4, 0, 50, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Sentry - On Aggro - Say Line 0'),
(17727, 0, 1, 0, 0, 0, 100, 0, 6050, 13750, 1200, 16200, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Sentry - In Combat - Cast \'Strike\''),
(17727, 0, 2, 0, 0, 0, 100, 0, 12000, 15000, 17000, 22000, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathfin Sentry - In Combat - Cast \'Shield Bash\''),
(17729, 0, 0, 0, 0, 0, 100, 0, 850, 1600, 2400, 3600, 0, 11, 22887, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - In Combat - Cast \'Throw\''),
(17729, 0, 1, 0, 0, 0, 100, 0, 8800, 13600, 8200, 13300, 0, 11, 31407, 0, 0, 0, 0, 0, 5, 0, 0, 1, 0, 0, 0, 0, 0, 'Murkblood Spearman - In Combat - Cast \'Viper Sting\''),
(17729, 0, 2, 3, 2, 0, 100, 1, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - Between 0-30% Health - Cast \'Enrage\''),
(17729, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Murkblood Spearman - Linked - Say Line 0'),
(17734, 0, 0, 0, 0, 0, 100, 4, 10000, 10000, 10000, 10000, 0, 11, 40318, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - In Combat - Cast \'Growth\' (Heroic Dungeon)'),
(17734, 0, 1, 2, 2, 0, 100, 3, 0, 30, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - Between 0-30% Health - Cast \'Enrage\' (No Repeat) (Normal Dungeon)'),
(17734, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - Between 0-30% Health - Say Line 0 (No Repeat) (Normal Dungeon)'),
(17734, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 3, 0, 17758, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hack: Underbog Lord - On Respawn - Morph To Model 17758');

DELETE FROM `creature_text` WHERE `CreatureID` IN (17723, 17729, 17734);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17723, 0, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 24144, 0, 'Bog Giant'),
(17729, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 38630, 0, 'Murkblood Spearman'),
(17734, 0, 0, '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 38630, 0, 'Underbog Lord');

DELETE FROM `creature_text` WHERE `CreatureID` = 17735 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17735, 1, 0, '%s becomes enraged!', 16, 0, 100, 0, 0, 0, 24144, 0, 'Wrathfin Warrior');

DELETE FROM `creature_template_addon` WHERE (`entry` IN (17734, 20187));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17734, 0, 0, 0, 1, 0, 0, '21737 32066'),
(20187, 0, 0, 0, 1, 0, 0, '21737 32066');
