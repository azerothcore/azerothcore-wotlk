-- DB update 2026_08_12_01 -> 2026_08_13_00
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
(25342, 0, 0, 1, 62, 0, 100, 512, 9155, 0, 0, 0, 0, 0, 56, 34842, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option Selected - Add Item \'Warsong Outfit\''),
(25342, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option Selected - Despawn in 30s'),
(25342, 0, 2, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option Selected - Cast \'Naked Caravan Guard - Master Transform\''),
(25342, 0, 3, 4, 8, 0, 100, 513, 45474, 0, 0, 0, 0, 0, 33, 25342, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Spellhit \'Ragefist\'s Torch\' - Quest Credit \'The Honored Dead\''),
(25342, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 50, 182071, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Spellhit \'Ragefist\'s Torch\' - Spawn GO Small Chapel Fire'),
(25342, 0, 5, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Spellhit \'Ragefist\'s Torch\' - Despawn after 30 seconds'),
(25342, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 25340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Respawn - Morph To Creature Dead Caravan Guard Transform'),
(25342, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Respawn - Add Npc Flags Gossip'),
(25342, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Guard - On Gossip Option or Spellhit - Remove Npc Flags Gossip');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25343);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25343, 0, 0, 1, 62, 0, 100, 512, 9156, 0, 0, 0, 0, 0, 56, 34842, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option Selected - Add Item \'Warsong Outfit\''),
(25343, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option Selected - Despawn in 30s'),
(25343, 0, 2, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45713, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option Selected - Cast \'Naked Caravan Guard - Master Transform\''),
(25343, 0, 3, 4, 8, 0, 100, 513, 45474, 0, 0, 0, 0, 0, 33, 25342, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Spellhit \'Ragefist\'s Torch\' - Quest Credit \'The Honored Dead\''),
(25343, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 50, 182071, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Spellhit \'Ragefist\'s Torch\' - Spawn GO Small Chapel Fire'),
(25343, 0, 5, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Spellhit \'Ragefist\'s Torch\' - Despawn after 30 seconds'),
(25343, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 25341, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Respawn - Morph To Creature Dead Caravan Worker Transform'),
(25343, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Respawn - Add Npc Flags Gossip'),
(25343, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dead Caravan Worker - On Gossip Option or Spellhit - Remove Npc Flags Gossip');

DELETE FROM `spell_script_names` WHERE `spell_id` = 45713;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45713, 'spell_naked_caravan_guard_transform');
