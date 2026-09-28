--
-- Let Them Not Rise! (12211): Container of Rats (48268) corpse sequence
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 48268 AND `spell_effect` = 48272;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 48268 AND `ConditionTypeOrReference` = 104;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 48268, 0, 0, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (set in AI data)'),
(17, 0, 48268, 0, 1, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (set in AI data)'),
(17, 0, 48268, 0, 2, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (set in AI data)'),
(17, 0, 48268, 0, 3, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (set in AI data)'),
(17, 0, 48268, 0, 4, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (set in AI data)');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags` = `unit_flags` | 33554434 WHERE `entry` = 27276;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 27276 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27276,0,0,1,54,0,100,0,0,0,0,0,0,0,66,1,0,0,0,0,0,23,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Just Summoned - Set Orientation Summoner'),
(27276,0,1,0,61,0,100,0,0,0,0,0,0,0,46,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Just Summoned - Move Forward 1 Yard'),
(27276,0,2,3,34,0,100,0,8,16777214,0,0,0,0,66,1,0,0,0,0,0,23,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Reached Point - Set Orientation Summoner'),
(27276,0,3,0,61,0,100,0,0,0,0,0,0,0,67,1,0,0,1000,1000,100,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Reached Point - Create Timed Event 1'),
(27276,0,4,0,59,0,100,0,1,0,0,0,0,0,5,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Timed Event 1 Triggered - Play Emote \'Attack Unarmed\''),
(27276,0,5,0,60,0,100,1,10000,10000,0,0,0,0,3,0,11078,0,0,0,0,23,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Update (10s, No Repeat) - Morph Summoner To Model 11078 (Skeleton)');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27202, 27203, 27206, 27207, 27211) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27202,0,0,0,0,0,100,0,500,1000,3000,3500,0,0,11,50740,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - In Combat - Cast Raven Flock'),
(27202,0,1,0,2,0,100,0,0,30,14000,18000,0,0,11,50750,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - Between 0-30% Health - Cast Raven Heal'),
(27202,0,2,3,8,0,100,0,48679,0,0,0,0,0,134,48762,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - On Spellhit Banshee\'s Magic Mirror - Cast A Fall from Grace: Scarlet Raven Priest Image - Master'),
(27202,0,3,4,61,0,100,512,0,0,0,0,0,0,11,48648,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - On Spellhit Banshee\'s Magic Mirror - Cast The Perfect Dissemblance: Summon Player\'s Footman & Credit Credit'),
(27202,0,4,5,61,0,100,512,0,0,0,0,0,0,134,48654,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - On Spellhit Banshee\'s Magic Mirror - Cast The Perfect Dissemblance: Summon Priest\'s Footman'),
(27202,0,5,6,61,0,100,512,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - On Spellhit Banshee\'s Magic Mirror - Say Line 2'),
(27202,0,6,0,61,0,100,512,0,0,0,0,0,0,2,14,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - On Spellhit Banshee\'s Magic Mirror - Set Faction'),
(27202,0,10,11,8,0,100,512,48268,0,0,0,0,0,45,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Raven Priest - On Spellhit \'Container of Rats\' - Set Data 1 1'),
(27202,0,11,12,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,3.5,0,0,0,'Onslaught Raven Priest - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27202,0,12,13,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,3.33,0,0,'Onslaught Raven Priest - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27202,0,13,14,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,2.06,0,0,'Onslaught Raven Priest - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27202,0,14,15,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,-2.06,0,0,'Onslaught Raven Priest - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27202,0,15,0,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,-3.33,0,0,'Onslaught Raven Priest - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27203,0,1,0,4,0,30,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Footman - On Agro - Say'),
(27203,0,10,11,8,0,100,512,48268,0,0,0,0,0,45,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Footman - On Spellhit \'Container of Rats\' - Set Data 1 1'),
(27203,0,11,12,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,3.5,0,0,0,'Onslaught Footman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27203,0,12,13,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,3.33,0,0,'Onslaught Footman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27203,0,13,14,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,2.06,0,0,'Onslaught Footman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27203,0,14,15,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,-2.06,0,0,'Onslaught Footman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27203,0,15,0,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,-3.33,0,0,'Onslaught Footman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27206,0,0,0,6,0,100,512,0,0,0,0,0,0,203,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Knight - On Death - Exit Vehicle'),
(27206,0,2,0,7,0,100,512,0,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Knight - On Evade - Despawn Instant'),
(27206,0,10,11,8,0,100,512,48268,0,0,0,0,0,45,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Knight - On Spellhit \'Container of Rats\' - Set Data 1 1'),
(27206,0,11,12,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,3.5,0,0,0,'Onslaught Knight - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27206,0,12,13,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,3.33,0,0,'Onslaught Knight - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27206,0,13,14,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,2.06,0,0,'Onslaught Knight - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27206,0,14,15,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,-2.06,0,0,'Onslaught Knight - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27206,0,15,0,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,-3.33,0,0,'Onslaught Knight - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27207,0,0,0,0,0,100,0,7000,12000,7000,12000,0,0,11,43410,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Onslaught Workman - In Combat - Cast \'Chop\' (No Repeat)'),
(27207,0,10,11,8,0,100,512,48268,0,0,0,0,0,45,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Workman - On Spellhit \'Container of Rats\' - Set Data 1 1'),
(27207,0,11,12,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,3.5,0,0,0,'Onslaught Workman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27207,0,12,13,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,3.33,0,0,'Onslaught Workman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27207,0,13,14,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,2.06,0,0,'Onslaught Workman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27207,0,14,15,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,-2.06,0,0,'Onslaught Workman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27207,0,15,0,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,-3.33,0,0,'Onslaught Workman - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27211,0,0,0,9,0,100,0,0,0,9000,13000,0,5,11,9080,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Onslaught Executioner - Within 0-5 Range - Cast \'Hamstring\' (No Repeat)'),
(27211,0,1,0,0,0,100,0,5000,8000,12000,15000,0,0,11,43673,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Onslaught Executioner - In Combat - Cast \'Mighty Blow\' (No Repeat)'),
(27211,0,10,11,8,0,100,512,48268,0,0,0,0,0,45,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Executioner - On Spellhit \'Container of Rats\' - Set Data 1 1'),
(27211,0,11,12,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,3.5,0,0,0,'Onslaught Executioner - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27211,0,12,13,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,3.33,0,0,'Onslaught Executioner - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27211,0,13,14,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,2.06,0,0,'Onslaught Executioner - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27211,0,14,15,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,-2.83,-2.06,0,0,'Onslaught Executioner - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\''),
(27211,0,15,0,61,0,100,0,0,0,0,0,0,0,12,27276,3,12000,0,0,0,1,0,0,0,0,1.08,-3.33,0,0,'Onslaught Executioner - On Spellhit \'Container of Rats\' - Summon Creature \'Let Them Not Rise! Rat\'');
