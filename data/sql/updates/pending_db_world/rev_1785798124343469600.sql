--
DELETE FROM `creature_template_model` WHERE (`CreatureID` = 25350);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(25350, 1, 23175, 1, 0, 51831),
(25350, 0, 23173, 1, 1, 51831);

DELETE FROM `creature_template_model` WHERE `CreatureID` IN (25342, 25343);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(25342, 0, 328, 1, 0, 51831),
(25342, 1, 21342, 1, 1, 51831),

(25343, 0, 328, 1, 0, 51831),
(25343, 1, 21342, 1, 1, 51831);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25342);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25342, 0, 0, 1, 62, 0, 100, 512, 9155, 0, 0, 0, 0, 0, 11, 45701, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option Selected - Cast \'Serverside - Create Warsong Outfit\''),
(25342, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option Selected - Despawn in 30s'),
(25342, 0, 2, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option Selected - Cast \'Naked Caravan Guard - Master Transform\''),
(25342, 0, 3, 4, 8, 0, 100, 513, 45474, 0, 0, 0, 0, 0, 33, 25342, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Spellhit \'Ragefist\'s Torch\' - Quest Credit \'The Honored Dead\''),
(25342, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 50, 182071, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Spellhit \'Ragefist\'s Torch\' - Spawn GO Small Chapel Fire'),
(25342, 0, 5, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Spellhit \'Ragefist\'s Torch\' - Despawn after 30 seconds'),
(25342, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2534200, 2534203, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Respawn - Run Random Script'),
(25342, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Respawn - Add Npc Flags Gossip'),
(25342, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option or Spellhit - Remove Npc Flags Gossip');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25343);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25343, 0, 0, 1, 62, 0, 100, 512, 9155, 0, 0, 0, 0, 0, 11, 45701, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option Selected - Cast \'Serverside - Create Warsong Outfit\''),
(25343, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option Selected - Despawn in 30s'),
(25343, 0, 2, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option Selected - Cast \'Naked Caravan Guard - Master Transform\''),
(25343, 0, 3, 4, 8, 0, 100, 513, 45474, 0, 0, 0, 0, 0, 33, 25342, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Spellhit \'Ragefist\'s Torch\' - Quest Credit \'The Honored Dead\''),
(25343, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 50, 182071, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Spellhit \'Ragefist\'s Torch\' - Spawn GO Small Chapel Fire'),
(25343, 0, 5, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Spellhit \'Ragefist\'s Torch\' - Despawn after 30 seconds'),
(25343, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2534300, 2534303, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Respawn - Run Random Script'),
(25343, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Respawn - Add Npc Flags Gossip'),
(25343, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option or Spellhit - Remove Npc Flags Gossip');

/* ModelIDs
23246 -> 23245 -- Guard Orc Male
23247 -> 23250 -- Guard Forsaken Male
23248 -> 23251 -- Guard Orc Female
23249 -> 23252 -- Guard Tauren Male
23124 -> 23253 -- Worker Orc Male
23125 -> 23254 -- Worker Forsaken Male
23126 -> 23255 -- Worker Orc Female
23127 -> 23256 -- Worker Troll Male
*/
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2534200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2534200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23246, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23246'),
(2534201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23247, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23247'),
(2534202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23248, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23248'),
(2534203, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23249, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23249'),

(2534300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23124, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23124'),
(2534301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23125, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23125'),
(2534302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23126, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23126'),
(2534303, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 23127, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - Actionlist - Morph To Model 23127');
