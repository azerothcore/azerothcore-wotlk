-- DB update 2026_04_23_02 -> 2026_04_24_00

-- Update SAI.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28406;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28406);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28406, 0, 0, 1, 62, 0, 100, 0, 9765, 0, 0, 0, 0, 0, 64, 12, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Gossip Option 0 Selected - Store Targetlist'),
(28406, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Gossip Option 0 Selected - Remove Npc Flags Gossip'),
(28406, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Gossip Option 0 Selected - Close Gossip'),
(28406, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Gossip Option 0 Selected - Set Orientation Stored'),
(28406, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52996, 2, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Gossip Option 0 Selected - Cast \'Duel!\''),
(28406, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2840600, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Gossip Option 0 Selected - Run Script'),
(28406, 0, 6, 7, 2, 2, 100, 0, 0, 1, 500, 500, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Between 0-1% Health - Set Flags Immune To Players & Immune To NPC\'s (Phase 2)'),
(28406, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 126, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Between 0-1% Health - Remove All Gameobjects (Phase 2)'),
(28406, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 2082, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Between 0-1% Health - Set Faction 2082 (Phase 2)'),
(28406, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Between 0-1% Health - Stop Attack (Phase 2)'),
(28406, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Between 0-1% Health - Stop Attack (Phase 2)'),
(28406, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2840601, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - Between 0-1% Health - Run Script (Phase 2)'),
(28406, 0, 12, 13, 5, 2, 100, 0, 0, 0, 1, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Killed Unit - Set Flags Immune To Players & Immune To NPC\'s (Phase 2)'),
(28406, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 126, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Killed Unit - Remove All Gameobjects (Phase 2)'),
(28406, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2840602, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Killed Unit - Run Script (Phase 2)'),
(28406, 0, 15, 16, 104, 2, 100, 0, 1, 191126, 1, 20, 500, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Less Than 1 Units in Range - Set Flags Immune To Players & Immune To NPC\'s (Phase 2)'),
(28406, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 126, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Less Than 1 Units in Range - Remove All Gameobjects (Phase 2)'),
(28406, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Less Than 1 Units in Range - Stop Attack (Phase 2)'),
(28406, 0, 18, 19, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Less Than 1 Units in Range - Stop Attack (Phase 2)'),
(28406, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2840611, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - On Less Than 1 Units in Range - Run Script (Phase 2)'),
(28406, 0, 20, 0, 0, 0, 100, 0, 1000, 2000, 18000, 22000, 0, 0, 11, 52372, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - In Combat - Cast \'Icy Touch\''),
(28406, 0, 21, 0, 0, 0, 100, 0, 500, 1500, 10000, 14000, 0, 0, 11, 52373, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - In Combat - Cast \'Plague Strike\''),
(28406, 0, 22, 0, 0, 0, 100, 0, 3000, 4000, 4000, 6000, 0, 0, 11, 52374, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - In Combat - Cast \'Blood Strike\''),
(28406, 0, 23, 0, 0, 0, 100, 0, 3000, 4000, 4000, 6000, 0, 0, 11, 52375, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Death Knight Initiate - In Combat - Cast \'Death Coil\'');
