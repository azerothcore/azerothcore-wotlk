-- DB update 2026_02_15_07 -> 2026_02_16_00
-- Onyx Blaze Mistress
-- Updates comments, add Conjure Flame Orb
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30681);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30681, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 12000, 13000, 0, 0, 11, 39529, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Blaze Mistress - In Combat - Cast \'Flame Shock\''),
(30681, 0, 1, 0, 0, 0, 100, 0, 8000, 8000, 19000, 22000, 0, 0, 11, 57757, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Blaze Mistress - In Combat - Cast \'Rain of Fire\''),
(30681, 0, 2, 0, 0, 0, 100, 0, 3000, 11000, 8000, 15000, 0, 0, 11, 57753, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Blaze Mistress - In Combat - Cast \'Conjure Flame Orb\''),
(30681, 0, 3, 0, 8, 0, 100, 0, 57753, 0, 0, 0, 0, 0, 11, 57752, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Blaze Mistress - On Spellhit \'Conjure Flame Orb\' - Cast \'Flame Orb Summon\'');

-- Onyx Brood General
-- Update comments, add Draconic Rage 25m, text
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30680);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30680, 0, 0, 0, 60, 0, 100, 0, 0, 0, 600000, 600000, 0, 0, 11, 57740, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - On Update - Cast \'Devotion Aura\''),
(30680, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 7000, 8000, 0, 0, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - In Combat - Cast \'Mortal Strike\''),
(30680, 0, 2, 0, 0, 0, 100, 0, 15000, 15000, 40000, 40000, 0, 0, 11, 57733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - In Combat - Cast \'Draconic Rage\''),
(30680, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - On Just Died - Cast \'Avenging Fury\''),
(30680, 0, 4, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Brood General - On Initialize - Say Line 0');

DELETE FROM `spelldifficulty_dbc` WHERE `ID`=57733;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(57733, 57733, 58942, 0, 0);

DELETE FROM `creature_text` WHERE `CreatureID`=30680;
INSERT INTO `creature_text` (`CreatureID`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextId`) VALUES
(30680, 0, 0, 'Brood Guardians reporting in!', 14, 0, 100, 0, 0, 0, 'Onyx Brood General', 31397);

-- Onyx Sanctum Guardian
-- use 25m spells, update comments, add text
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30453);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30453, 0, 0, 0, 0, 0, 100, 0, 7000, 9000, 17000, 18000, 0, 0, 11, 57728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - In Combat - Cast \'Shockwave\''),
(30453, 0, 1, 0, 0, 0, 100, 0, 13000, 13000, 30000, 30000, 0, 0, 11, 58948, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - In Combat - Cast \'Curse of Mending\''),
(30453, 0, 2, 3, 12, 0, 100, 0, 25, 30, 5000, 5000, 0, 0, 11, 53801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - Target Between 25-30% Health - Cast \'Frenzy\''),
(30453, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - Target Between 25-30% Health - Say Line 0'),
(30453, 0, 4, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onyx Sanctum Guardian - On Initialize - Say Line 1');

DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (58948, 57728);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(58948, 58948, 39647, 0, 0),
(57728, 57728, 58947, 0, 0);

DELETE FROM `creature_text` WHERE `CreatureID`=30453;
INSERT INTO `creature_text` (`CreatureID`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextId`) VALUES
(30453, 0, 0,  '%s goes into a frenzy!', 16, 0, 100, 0, 0, 0, 'Onyx Sanctum Guardian',  38630),
(30453, 1, 0,  'Sanctum Guardians reporting in!', 14, 0, 100, 0, 0, 0, 'Onyx Sanctum Guardian',  31398);

-- Flame Orb
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `flags_extra` = `flags_extra` | (128 | 64) WHERE `entry`=30702;
DELETE FROM `creature_template_movement` WHERE `CreatureId`=30702;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES
(30702, 1, 0, 1, 0, 0, 0);

DELETE FROM `spelldifficulty_dbc` WHERE `ID`=57750;
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`, `DifficultySpellID_3`, `DifficultySpellID_4`) VALUES
(57750, 57750, 58037, 0, 0);

DELETE FROM `creature_template_addon` WHERE (`entry` = 30702);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(30702, 0, 0, 0, 0, 0, 0, '57750 55928');
