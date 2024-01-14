UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (188049, 188130, 188134, 188135, 188137, 188138, 188139, 188143, 188144, 188145, 188146, 188147, 188148, 188149, 188150, 188151, 188152, 188153, 188154);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (188049, 188130, 188134, 188135, 188137, 188138, 188139, 188143, 188144, 188145, 188146, 188147, 188148, 188149, 188150, 188151, 188152, 188153, 188154));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(188049, 1, 0, 0, 62, 0, 100, 0, 9213, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188049, 1, 1, 0, 62, 0, 100, 0, 9213, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188130, 1, 0, 0, 62, 0, 100, 0, 9251, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188130, 1, 1, 0, 62, 0, 100, 0, 9251, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188134, 1, 0, 0, 62, 0, 100, 0, 9254, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188134, 1, 1, 0, 62, 0, 100, 0, 9254, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188135, 1, 0, 0, 62, 0, 100, 0, 9255, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188135, 1, 1, 0, 62, 0, 100, 0, 9255, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188137, 1, 0, 0, 62, 0, 100, 0, 9256, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188137, 1, 1, 0, 62, 0, 100, 0, 9256, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188138, 1, 0, 0, 62, 0, 100, 0, 9257, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188138, 1, 1, 0, 62, 0, 100, 0, 9257, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188139, 1, 0, 0, 62, 0, 100, 0, 9258, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188139, 1, 1, 0, 62, 0, 100, 0, 9258, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188143, 1, 0, 0, 62, 0, 100, 0, 9264, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188143, 1, 1, 0, 62, 0, 100, 0, 9264, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188144, 1, 0, 0, 62, 0, 100, 0, 9265, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188144, 1, 1, 0, 62, 0, 100, 0, 9265, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188145, 1, 0, 0, 62, 0, 100, 0, 9266, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188145, 1, 1, 0, 62, 0, 100, 0, 9266, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188146, 1, 0, 0, 62, 0, 100, 0, 9267, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188146, 1, 1, 0, 62, 0, 100, 0, 9267, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188147, 1, 0, 0, 62, 0, 100, 0, 9268, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188147, 1, 1, 0, 62, 0, 100, 0, 9268, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188148, 1, 0, 0, 62, 0, 100, 0, 9269, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188148, 1, 1, 0, 62, 0, 100, 0, 9269, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188149, 1, 0, 0, 62, 0, 100, 0, 9271, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188149, 1, 1, 0, 62, 0, 100, 0, 9271, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188150, 1, 0, 0, 62, 0, 100, 0, 9272, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188150, 1, 1, 0, 62, 0, 100, 0, 9272, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188151, 1, 0, 0, 62, 0, 100, 0, 9273, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188151, 1, 1, 0, 62, 0, 100, 0, 9273, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188152, 1, 0, 0, 62, 0, 100, 0, 9274, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188152, 1, 1, 0, 62, 0, 100, 0, 9274, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188153, 1, 0, 0, 62, 0, 100, 0, 9275, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188153, 1, 1, 0, 62, 0, 100, 0, 9275, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip'),
(188154, 1, 0, 0, 62, 0, 100, 0, 9276, 0, 0, 0, 0, 11, 46595, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Cast \'Summon Ice Stone Lieutenant, Trigger\''),
(188154, 1, 1, 0, 62, 0, 100, 0, 9276, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ice Stone - On Gossip Option 0 Selected - Close Gossip');

DELETE FROM `creature` WHERE `guid` IN (245628, 245629, 245630, 245631, 245632, 245633);
DELETE FROM `game_event_creature` WHERE (`eventEntry` = 1 AND `guid` IN (245628, 245629, 245630, 245631, 245632, 245633));

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26116, 0, 0, 'You will not stop the Frost Lord from entering this world, mortal. The Tidehunter\'s might will crush that of Ragnaros once and for all, leaving your land a frozen paradise!', 12, 0, 100, 1, 2000, 0, 25372, 0, 'Frostwave Lieutenant intro speech');

UPDATE `creature_text` SET `comment` = 'Hailstone Lieutenant intro speech' WHERE `CreatureID` = 26178; -- Formerly 'Frostwave Lieutenant intro speech'
UPDATE `creature_text` SET `comment` = 'Glacial Templar intro speech' WHERE `CreatureID` = 26216; -- Formerly 'Templar intro speech'

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (26116, 26178, 26204, 26214, 26215, 26216);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (26116, 26178, 26204, 26214, 26215, 26216));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26116, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwave Lieutenant - On Just Summoned - Say Line 0'),
(26178, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hailstone Lieutenant - On Just Summoned - Say Line 0'),
(26204, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chillwind Lieutenant - On Just Summoned - Say Line 0'),
(26214, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frigid Lieutenant - On Just Summoned - Say Line 0'),
(26215, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Lieutenant - On Just Summoned - Say Line 0'),
(26216, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Glacial Templar - On Just Summoned - Say Line 0');

DELETE FROM `spell_script_names` WHERE `spell_id` = 46592 AND `ScriptName` = 'spell_midsummer_summon_ahune_lieutenant';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (46592, 'spell_midsummer_summon_ahune_lieutenant');

/*
GObject GUIDs
guid;id/entry;Data3(gossip_menu)
49453;188148;9269 -- Silithus
49454;188149;9271
49455;188150;9272
54031;188049;9213 -- Ashenvale
54944;188137;9256
54945;188138;9257
81467;188130;9251 -- Desolace
81468;188134;9254
81469;188135;9255
81470;188139;9258 -- Stranglethorn
81471;188143;9264
81472;188144;9265
81473;188145;9266 -- Searing Gorge
81474;188146;9267
81475;188147;9268
81476;188151;9273 -- Hellfire
81477;188152;9274
81478;188153;9275
81479;188154;9276
220100;187882 -- Ahune
*/
