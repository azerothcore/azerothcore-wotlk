-- DB update 2023_04_22_08 -> 2023_04_22_09
DELETE FROM `smart_scripts` WHERE `entryorguid` = 619300 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
 (619300,9,0,0,0,0,100,0,4000,4000,0,0,0,11,28406,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash - On Script - Cast Polymorph Backfire'),
 (619300,9,1,0,0,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash - On Script - root'),
 (619300,9,2,0,0,0,100,0,0,0,0,0,0,3,0,11686,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash - On Script - morph'),
 (619300,9,3,0,0,0,100,0,0,0,0,0,0,11,60034,64,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash - On Script - Cast smoke'),
 (619300,9,4,0,0,0,100,0,1000,1000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash - On Script - Despawn');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 6190 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(6190,0,0,0,8,0,100,1,118,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Warrior - On Spellhit \'Polymorph\' - Run Script'),
(6190,0,1,0,8,0,100,1,12824,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Warrior - On Spellhit \'Polymorph\' - Run Script'),
(6190,0,2,0,8,0,100,1,12825,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Warrior - On Spellhit \'Polymorph\' - Run Script'),
(6190,0,3,0,8,0,100,1,12826,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Warrior - On Spellhit \'Polymorph\' - Run Script'),
(6190,0,4,0,0,0,100,0,6000,9000,11000,15000,0,11,6713,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Spitelash Warrior - In Combat - Cast Disarm');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 6193 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6193,0,0,0,8,0,100,1,118,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Screamer - On Spellhit \'Polymorph\' - Run Script'),
(6193,0,1,0,8,0,100,1,12824,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Screamer - On Spellhit \'Polymorph\' - Run Script'),
(6193,0,2,0,8,0,100,1,12825,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Screamer - On Spellhit \'Polymorph\' - Run Script'),
(6193,0,3,0,8,0,100,1,12826,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Screamer - On Spellhit \'Polymorph\' - Run Script'),
(6193,0,4,0,0,0,100,0,7000,9000,12000,15000,0,11,3589,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Screamer - In Combat - Cast Deafening Screech'),
(6193,0,5,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Spitelash Screamer - Between 0-15% Health - Flee For Assist (No Repeat)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 6194 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(6194,0,0,0,8,0,100,1,118,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Serpent Guard - On Spellhit \'Polymorph\' - Run Script'),
(6194,0,1,0,8,0,100,1,12824,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Serpent Guard - On Spellhit \'Polymorph\' - Run Script'),
(6194,0,2,0,8,0,100,1,12825,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Serpent Guard - On Spellhit \'Polymorph\' - Run Script'),
(6194,0,3,0,8,0,100,1,12826,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Serpent Guard - On Spellhit \'Polymorph\' - Run Script'),
(6194,0,4,0,0,0,100,0,6000,8000,9000,13000,0,11,25710,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Spitelash Serpent Guard - In Combat - Cast Heroic Strike'),
(6194,0,5,0,13,0,100,0,20000,30000,0,0,0,11,34783,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Serpent Guard - Target Casting - Cast Spell Reflection');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 6195 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6195,0,0,0,8,0,100,1,118,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Siren - On Spellhit \'Polymorph\' - Run Script'),
(6195,0,1,0,8,0,100,1,12824,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Siren - On Spellhit \'Polymorph\' - Run Script'),
(6195,0,2,0,8,0,100,1,12825,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Siren - On Spellhit \'Polymorph\' - Run Script'),
(6195,0,3,0,8,0,100,1,12826,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Siren - On Spellhit \'Polymorph\' - Run Script'),
(6195,0,4,0,0,0,100,0,0,0,2300,3900,0,11,6660,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Spitelash Siren - In Combat - Cast Shoot'),
(6195,0,5,0,0,0,100,0,3000,5000,12000,16000,0,11,12551,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Spitelash Siren - In Combat - Cast Frost Shot'),
(6195,0,6,0,9,0,100,0,0,8,13000,15000,0,11,11831,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Siren - Within 0-8 Range - Cast Frost Nova'),
(6195,0,7,0,74,0,100,0,0,50,12000,17000,40,11,11640,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Spitelash Siren - On Friendly Between 0-50% Health - Cast \'Renew\''),
(6195,0,8,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Spitelash Siren - Between 0-15% Health - Flee For Assist (No Repeat)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 6196 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6196,0,0,0,8,0,100,1,118,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Myrmidon - On Spellhit \'Polymorph\' - Run Script'),
(6196,0,1,0,8,0,100,1,12824,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Myrmidon - On Spellhit \'Polymorph\' - Run Script'),
(6196,0,2,0,8,0,100,1,12825,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Myrmidon - On Spellhit \'Polymorph\' - Run Script'),
(6196,0,3,0,8,0,100,1,12826,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Myrmidon - On Spellhit \'Polymorph\' - Run Script'),
(6196,0,4,0,0,0,100,0,5000,7000,6000,9000,0,11,11976,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Spitelash Myrmidon - In Combat - Cast Strike');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 7885 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7885,0,0,0,8,0,100,1,118,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Battlemaster - On Spellhit \'Polymorph\' - Run Script'),
(7885,0,1,0,8,0,100,1,12824,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Battlemaster - On Spellhit \'Polymorph\' - Run Script'),
(7885,0,2,0,8,0,100,1,12825,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Battlemaster - On Spellhit \'Polymorph\' - Run Script'),
(7885,0,3,0,8,0,100,1,12826,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Battlemaster - On Spellhit \'Polymorph\' - Run Script'),
(7885,0,4,0,9,0,100,1,5,30,0,0,0,11,22120,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Spitelash Battlemaster - Within 5-30 Range - Cast Charge (No Repeat)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 7886 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7886,0,0,0,8,0,100,1,118,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Enchantress - On Spellhit \'Polymorph\' - Run Script'),
(7886,0,1,0,8,0,100,1,12824,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Enchantress - On Spellhit \'Polymorph\' - Run Script'),
(7886,0,2,0,8,0,100,1,12825,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Enchantress - On Spellhit \'Polymorph\' - Run Script'),
(7886,0,3,0,8,0,100,1,12826,0,0,0,0,80,619300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Enchantress - On Spellhit \'Polymorph\' - Run Script'),
(7886,0,4,0,0,0,100,0,0,0,2400,3800,0,11,15790,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Spitelash Enchantress - In Combat - Cast Arcane Missiles'),
(7886,0,5,0,0,0,100,0,5000,9000,18000,24000,0,11,3443,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Spitelash Enchantress - In Combat - Cast Enchanted Quickness'),
(7886,0,6,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Spitelash Enchantress - Between 0-15% Health - Flee For Assist (No Repeat)');

UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE entry IN (6190,6193,6194,6195,6196,7885,7886);
