INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558481800224314500');

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9098;

-- Scarshield Spellbinder
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9098);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9098, 0, 0, 0, 11, 0, 100, 3, 0, 0, 0, 0, 58, 1, 13748, 1100, 3000, 30, 30, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Spellbinder - On Respawn - Install Template (No Repeat) (Normal Dungeon)'),
(9098, 0, 1, 0, 4, 0, 100, 2, 0, 0, 0, 0, 39, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Spellbinder - On Aggro - Call For Help (Normal Dungeon)'),
(9098, 0, 2, 0, 16, 0, 100, 2, 15123, 30, 3000, 6000, 11, 15123, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Spellbinder - On Friendly Unit Missing Buff \'15123\' - Cast \'15123\' (Normal Dungeon)');

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16968;

-- Tunneler
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 16968);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16968, 0, 0, 1, 4, 0, 100, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - On Aggro - Remove UNIT_FLAG_NOT_SELECTABLE'),
(16968, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 28, 29147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Link With Previous - Remove Tunnel Bore Passive'),
(16968, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 37752, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Link With Previous - Cast Stand'),
(16968, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Link With Previous - Root'),
(16968, 0, 4, 5, 25, 0, 100, 0, 0, 0, 0, 0, 11, 29147, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Spawn/Respawn/OOC - Cast Tunnel Bore Passive'),
(16968, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Link With Previous Set UNIT_FLAG_NOT_SELECTABLE'),
(16968, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 37751, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Link With Previous - Cast Submerge'),
(16968, 0, 7, 0, 0, 0, 100, 0, 1000, 1000, 2100, 4500, 11, 31747, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - In Combat - Cast Poison'),
(16968, 0, 8, 0, 0, 0, 100, 0, 10400, 10400, 45000, 50000, 11, 32738, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - In Combat - Cast Bore'),
(16968, 0, 9, 0, 2, 0, 100, 0, 0, 30, 8000, 8000, 11, 32714, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Tunneler - Between 0-30% Health - Cast 8599');

-- Table creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30945; 

-- Vardmadra
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 30945);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30945, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Data Set 1 1 - Set Run On'),
(30945, 0, 1, 2, 61, 0, 100, 0, 1, 1, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 7234.74, 3643.58, 811.807, 5.507, 'Vardmadra - On Data Set 1 1 - Move To Position'),
(30945, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Data Set 1 1 - Say Line 1'),
(30945, 0, 3, 0, 61, 0, 100, 1, 0, 0, 0, 0, 11, 25715, 2, 0, 0, 0, 0, 19, 30924, 200, 1, 0, 0, 0, 0, 'Vardmadra - On Data Set 1 1 - Cast \'Not-So-Honorable Combat: Summon Lady Nightswood\'s Moveto Target Bunny\''),
(30945, 0, 4, 5, 52, 0, 100, 0, 1, 30945, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Text 1 Over - Say Line 2'),
(30945, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30924, 200, 1, 0, 0, 0, 0, 'Vardmadra - On Text 1 Over - Set Orientation Closest Creature \'Possessed Iskalder\''),
(30945, 0, 6, 7, 52, 0, 100, 0, 2, 30945, 0, 0, 1, 0, 10000, 0, 0, 0, 0, 11, 30955, 200, 0, 0, 0, 0, 0, 'Vardmadra - On Text 2 Over - Say Line 0'),
(30945, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 30955, 200, 0, 0, 0, 0, 0, 'Vardmadra - On Text 2 Over - Set Orientation Closest Creature \'Lady Nightswood\''),
(30945, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 30955, 200, 0, 0, 0, 0, 0, 'Vardmadra - On Text 2 Over - Set Data 1 1'),
(30945, 0, 9, 0, 52, 0, 100, 0, 0, 30955, 0, 0, 5, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Text 0 Over - Say Line 3'),
(30945, 0, 10, 0, 52, 0, 100, 0, 3, 30945, 0, 0, 1, 4, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Text 3 Over - Say Line 4'),
(30945, 0, 11, 0, 52, 0, 100, 0, 4, 30945, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Text 4 Over - Despawn Instant'),
(30945, 0, 12, 0, 38, 0, 100, 0, 2, 2, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Vardmadra - On Data Set 2 2 - Despawn Instant');

-- Arakkoa Egg
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 20214 AND `source_type` = 0;

-- Forlorn Spirit
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 2044 AND `source_type` = 0 AND `id` = 0;

DELETE FROM `creature_text` WHERE `CreatureID`=2044 AND `GroupID` IN (0,1,2) AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(2044, 0, 0, 'Who is this mere $r that meddles with that which is past?  May the legend of Stalvan die along with you!', 12, 0, 100, 0, 0, 0, 504, 0, 'Forlorn Spirit'),
(2044, 1, 0, 'Let the legend of Stalvan rest!', 12, 0, 100, 0, 0, 0, 503, 0, 'Forlorn Spirit'),
(2044, 2, 0, 'Toil not in matters of the past, $n!', 12, 0, 100, 0, 0, 0, 0, 0, 'Forlorn Spirit');
