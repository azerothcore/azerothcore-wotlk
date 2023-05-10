-- DB update 2023_05_10_06 -> 2023_05_10_07
DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (32197, 40062, 30846);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(32197, 32197, 37113),
(40062, 40062, 40064),
(30846, 30846, 32784);

-- Small Updates
UPDATE `smart_scripts` SET `event_param1` = 9300, `event_param2` = 18200, `event_param3` = 10950, `event_param4` = 23100 WHERE (`entryorguid` = 17626) AND (`source_type` = 0) AND (`id` = 1); -- Laughing Skull Legionnaire
UPDATE `smart_scripts` SET `event_param1` = 8100, `event_param2` = 10100 WHERE (`entryorguid` = 17624) AND (`source_type` = 0) AND (`id` = 1); -- Laughing Skull Warden

-- Complete Rewrites
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (17370, 17491, 17371, 17395, 17400, 17414, 19016, 18894, 17398, 17429, 17397));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17370, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Enforcer - On Aggro - Say Line 0'),
(17370, 0, 1, 0, 0, 0, 100, 0, 4850, 12150, 8500, 18400, 0, 11, 15655, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Enforcer - In Combat - Cast \'Shield Slam\''),
(17370, 0, 2, 0, 0, 0, 100, 0, 1200, 15300, 1200, 21000, 0, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Enforcer - In Combat - Cast \'Strike\''),
(17491, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - On Aggro - Say Line 0'),
(17491, 0, 1, 0, 0, 0, 100, 0, 1200, 9800, 400, 15800, 0, 11, 34969, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - In Combat - Cast \'Poison\''),
(17491, 0, 2, 0, 0, 0, 100, 0, 4800, 4800, 60000, 60000, 0, 11, 6434, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - In Combat - Cast \'Slice and Dice\''),
(17491, 0, 3, 0, 0, 0, 100, 0, 13750, 29150, 13750, 29150, 0, 11, 30832, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Laughing Skull Rogue - In Combat - Cast \'Kidney Shot\''),
(17371, 0, 0, 0, 0, 0, 100, 2, 400, 4750, 3600, 6300, 0, 11, 12739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Shadow Bolt\' (Normal Dungeon)'),
(17371, 0, 1, 0, 0, 0, 100, 4, 400, 4750, 3600, 6300, 0, 11, 15472, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Shadow Bolt\' (Heroic Dungeon)'),
(17371, 0, 2, 0, 0, 0, 100, 0, 600, 8500, 12150, 21750, 0, 11, 32197, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Corruption\''),
(17371, 0, 3, 0, 0, 0, 100, 0, 6600, 10700, 14900, 14900, 0, 11, 13338, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Curse of Tongues\''),
(17371, 0, 4, 0, 0, 0, 100, 4, 2300, 16600, 21850, 43750, 0, 11, 32863, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - In Combat - Cast \'Seed of Corruption\' (Heroic Dungeon)'),
(17371, 0, 5, 0, 1, 0, 100, 0, 12600, 13700, 21900, 24900, 0, 11, 33111, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Warlock - Out of Combat - Cast \'Fel Power\''),
(17395, 0, 0, 0, 0, 0, 100, 2, 0, 0, 3600, 6050, 0, 11, 15242, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast \'Fireball\' (Normal Dungeon)'),
(17395, 0, 1, 0, 0, 0, 100, 4, 0, 0, 3600, 6050, 0, 11, 17290, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast \'Fireball\' (Heroic Dungeon)'),
(17395, 0, 2, 0, 0, 0, 100, 2, 7250, 29200, 14600, 29200, 0, 11, 18399, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast \'Flamestrike\' (Normal Dungeon)'),
(17395, 0, 3, 0, 0, 0, 100, 4, 7250, 29200, 14600, 29200, 0, 11, 16102, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast \'Flamestrike\' (Heroic Dungeon)'),
(17395, 0, 4, 0, 0, 0, 100, 1, 300, 9000, 0, 0, 0, 11, 30853, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast \'Summon Seductress\''),
(17395, 0, 5, 0, 0, 0, 100, 1, 300, 9000, 0, 0, 0, 11, 30851, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - In Combat - Cast \'Summon Felhound Manastalker\''),
(17400, 0, 0, 0, 9, 0, 100, 4, 8, 25, 8700, 14700, 1, 11, 27577, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Felguard Annihilator - Within 8-25 Range - Cast \'Intercept\' (Heroic Dungeon)'),
(17400, 0, 1, 0, 0, 0, 100, 0, 3000, 10950, 8500, 20650, 0, 11, 18072, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felguard Annihilator - In Combat - Cast \'Uppercut\''),
(17400, 0, 2, 0, 13, 0, 100, 0, 6900, 9500, 0, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felguard Annihilator - On Victim Casting - Cast \'Pummel\''),
(17400, 0, 3, 0, 0, 0, 100, 0, 12000, 12000, 12000, 12000, 0, 14, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Felguard Annihilator - In Combat - Reset All Threat'),
(17414, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - On Aggro - Say Line 0'),
(17414, 0, 1, 0, 0, 0, 100, 0, 1000, 8700, 15800, 25500, 0, 11, 30846, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast \'Throw Proximity Bomb\''),
(17414, 0, 2, 0, 0, 0, 100, 0, 300, 8100, 1200, 6600, 0, 11, 40062, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast \'Throw Dynamite\''),
(17414, 0, 3, 0, 0, 0, 100, 0, 5400, 11600, 24300, 24300, 0, 11, 6726, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Technician - In Combat - Cast \'Silence\''),
(19016, 0, 0, 0, 0, 0, 100, 2, 0, 0, 2900, 4800, 0, 11, 11921, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Familiar - In Combat - Cast \'Fireball\' (Normal Dungeon)'),
(19016, 0, 1, 0, 0, 0, 100, 4, 0, 0, 2900, 4800, 0, 11, 14034, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Familiar - In Combat - Cast \'Fireball\' (Heroic Dungeon)'),
(18894, 0, 0, 0, 0, 0, 100, 0, 1050, 3550, 13700, 19400, 0, 11, 18072, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felguard Brute - In Combat - Cast \'Uppercut\''),
(18894, 0, 1, 0, 13, 0, 100, 0, 6900, 9500, 0, 0, 0, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Felguard Brute - On Victim Casting - Cast \'Pummel\''),
(17398, 0, 1, 0, 0, 0, 100, 0, 6000, 18500, 1200, 27950, 0, 11, 22427, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nascent Fel Orc - In Combat - Cast \'Concussion Blow\''),
(17398, 0, 2, 0, 0, 0, 100, 0, 1200, 12150, 12150, 27950, 0, 11, 31900, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Nascent Fel Orc - In Combat - Cast \'Stomp\''),
(17429, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 20500, 20500, 0, 11, 22120, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Orc Neophyte - In Combat - Cast \'Charge\''),
(17429, 0, 1, 0, 0, 0, 100, 0, 1200, 7300, 120000, 120000, 0, 11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fel Orc Neophyte - In Combat - Cast \'Frenzy\''),
(17397, 0, 0, 0, 4, 0, 15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - On Aggro - Say Line 0'),
(17397, 0, 1, 0, 0, 0, 100, 0, 5600, 12300, 9600, 11400, 0, 11, 11978, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - In Combat - Cast Kick'),
(17397, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - At 15% HP - Flee For Assist'),
(17397, 0, 3, 0, 1, 0, 100, 1, 1000, 1000, 0, 0, 0, 11, 31059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Adept - Out Of Combat - Cast Hellfire Channeling');

-- Partial Rewrites
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 17477) AND (`source_type` = 0) AND (`id` IN (2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17477, 0, 2, 0, 0, 0, 100, 2, 200, 2400, 3600, 4800, 0, 11, 15242, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - In Combat - Cast \'Fireball\' (Normal Dungeon)'),
(17477, 0, 3, 0, 0, 0, 100, 4, 200, 2400, 3600, 4800, 0, 11, 17290, 64, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - In Combat - Cast \'Fireball\' (Heroic Dungeon)'),
(17477, 0, 4, 0, 0, 0, 100, 4, 8500, 14800, 6050, 17750, 0, 11, 16144, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hellfire Imp - In Combat - Cast \'Fire Blast\' (Heroic Dungeon)');

UPDATE `conditions` SET `SourceGroup` = 4 WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 6) AND (`SourceEntry` = 17397) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 17477) AND (`ConditionValue2` = 10) AND (`ConditionValue3` = 0);

DELETE FROM `creature_template_addon` WHERE (`entry` IN (17491, 18610, 18615));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17491, 0, 0, 0, 1, 0, 0, '30991'),
(18610, 0, 0, 0, 1, 0, 0, '30991'),
(18615, 0, 0, 0, 1, 0, 0, '8876');

UPDATE `creature_template_addon` SET `auras` = '8876' WHERE (`entry` = 17397);

UPDATE `creature_addon` SET `auras` = '30991' WHERE (`guid` IN (138193, 138237));

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1739500, 1739501));
