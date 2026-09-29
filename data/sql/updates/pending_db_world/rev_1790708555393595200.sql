--
-- The Exorcism of Colonel Jules (quest 10935): run once on TBC Classic timings, one Darkness Released source, 2 min credit window, reset and fail cleanly
-- Summon Flying Skull: only the SmartAI of Colonel Jules spawns Darkness Released, not aura 39284
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 39305;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 39305, 0, 0, 31, 0, 3, 22432, 0, 1, 0, 0, '', 'Summon Flying Skull - Caster is not Colonel Jules (only the SmartAI spawns Darkness Released)');

-- Darkness Released: allow flight so the movement-flag update does not drop the SmartAI fly state mid-path
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 22507;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(22507, 0, 1, 1, 0, 0, 0, NULL);

-- Fixed lines of the TBC Classic sequence that no single-line group covers yet
DELETE FROM `creature_text` WHERE `CreatureID` = 22431 AND `GroupID` IN (8, 9, 10);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22431, 8, 0, 'Back, foul beings of darkness!  You have no power here!', 12, 0, 100, 0, 0, 0, 20404, 0, 'Anchorite Barada'),
(22431, 9, 0, 'In the name of the Light! It is Light that commands you! It is Light that flung you to the depths of darkness!', 12, 0, 100, 0, 0, 0, 20406, 0, 'Anchorite Barada'),
(22431, 10, 0, 'You... will... leave... this... man!', 12, 0, 100, 0, 0, 0, 20410, 0, 'Anchorite Barada');
DELETE FROM `creature_text` WHERE `CreatureID` = 22432 AND `GroupID` IN (5, 6, 7);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22432, 5, 0, 'No!  Not yet!  This soul is ours!', 12, 0, 100, 0, 0, 0, 20412, 0, 'Colonel Jules'),
(22432, 6, 0, 'You will not succeed, mortal!  This shell will lie decrepit, blistered and bleeding before I am done with it.  And its spirit will be long cast into darkness.', 12, 0, 100, 0, 0, 0, 20413, 0, 'Colonel Jules'),
(22432, 7, 0, 'Ah!  Cease the incantations, Anchorite!  Cease, or I will show you such pain that your pathetic people have never imagined!', 12, 0, 100, 0, 0, 0, 20414, 0, 'Colonel Jules');

-- Anchorite Barada
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 22431);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22431, 0, 0, 1, 60, 0, 100, 1, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update - Set Flag Standstate Kneel'),
(22431, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update - Set Npc Flags Gossip & Questgiver'),
(22431, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update - Set Reactstate Passive'),
(22431, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update - Enable Evade'),
(22431, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 102, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update - Enable Health Regeneration'),
(22431, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update - Set Active Off'),
(22431, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Update - Set Event Phase 1'),
(22431, 0, 7, 8, 62, 1, 100, 0, 8539, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Set Event Phase 2 (Phase 1)'),
(22431, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Set Npc Flags None'),
(22431, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Close Gossip'),
(22431, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Disable Evade'),
(22431, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Set Active On'),
(22431, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243100, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Run Script'),
(22431, 0, 13, 0, 62, 14, 100, 0, 8539, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Close Gossip (Phases 2-4)'),
(22431, 0, 14, 15, 6, 14, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Just Died - Set Data 1 3 (Phases 2-4)'),
(22431, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243101, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Just Died - Run Script'),
(22431, 0, 16, 17, 38, 8, 100, 0, 1, 1, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Data Set 1 1 - Enable Evade (Phase 4)'),
(22431, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Data Set 1 1 - Evade');

-- Anchorite Barada actionlists: ritual, death cleanup
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2243100, 2243101));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Disable Health Regeneration'),
(2243100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Remove Flag Standstate Kneel'),
(2243100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Run Off'),
(2243100, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 0'),
(2243100, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 1'),
(2243100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Data 1 1'),
(2243100, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -707.68, 2747.8, 101.6, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 7, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -710.87, 2747.8, 101.6, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 8, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.57, 'Anchorite Barada - Actionlist - Set Orientation 1.57'),
(2243100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Home Position'),
(2243100, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Event Phase 3'),
(2243100, 9, 11, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 11, 39277, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Barada Commands\''),
(2243100, 9, 12, 0, 0, 0, 100, 0, 10500, 10500, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 3'),
(2243100, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39278, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Barada Falters\''),
(2243100, 9, 14, 0, 0, 0, 100, 0, 30500, 30500, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 10'),
(2243100, 9, 15, 0, 0, 0, 100, 0, 9000, 9000, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 16, 0, 0, 0, 100, 0, 11000, 11000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 3'),
(2243100, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39278, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Barada Falters\''),
(2243100, 9, 18, 0, 0, 0, 100, 0, 13000, 13000, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 9'),
(2243100, 9, 19, 0, 0, 0, 100, 0, 24000, 24000, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 10'),
(2243100, 9, 20, 0, 0, 0, 100, 0, 27500, 27500, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 21, 0, 0, 0, 100, 0, 23500, 23500, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 4'),
(2243100, 9, 22, 0, 0, 0, 100, 0, 17500, 17500, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 6'),
(2243100, 9, 23, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 3'),
(2243100, 9, 24, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39278, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Barada Falters\''),
(2243100, 9, 25, 0, 0, 0, 100, 0, 14500, 14500, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Event Phase 4'),
(2243100, 9, 26, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Data 1 2'),
(2243100, 9, 27, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 7'),
(2243100, 9, 28, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Remove All Auras'),
(2243100, 9, 29, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Flag Standstate Kneel'),
(2243100, 9, 30, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Remove Flag Standstate Kneel'),
(2243100, 9, 31, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -707.68, 2747.8, 101.6, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 32, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -707.211, 2754.11, 101.675, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 33, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.74, 'Anchorite Barada - Actionlist - Set Orientation 2.74'),
(2243100, 9, 34, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Home Position'),
(2243100, 9, 35, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Flag Standstate Kneel'),
(2243101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 102, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Enable Health Regeneration');

-- Colonel Jules
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 22432);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22432, 0, 0, 1, 60, 0, 100, 1, 500, 500, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update - Set Npc Flags None'),
(22432, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update - Set Reactstate Passive'),
(22432, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39283, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update - Cast \'Jules Goes Prone\''),
(22432, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 1, 30, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update - Set Fly On'),
(22432, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Update - Set Event Phase 1'),
(22432, 0, 5, 6, 38, 1, 100, 0, 1, 1, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 1 - Set Event Phase 2 (Phase 1)'),
(22432, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243200, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 1 - Run Script'),
(22432, 0, 7, 8, 40, 2, 100, 0, 2, 0, 0, 0, 0, 0, 54, 87000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 2 of Path Any Reached - Pause Waypoint (Phase 2)'),
(22432, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 2 of Path Any Reached - Set Event Phase 3'),
(22432, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 2000, 3000, 10000, 15000, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 2 of Path Any Reached - Create Timed Event 1'),
(22432, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 5, 83500, 83500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 2 of Path Any Reached - Create Timed Event 5'),
(22432, 0, 11, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 6, 88500, 88500, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 2 of Path Any Reached - Create Timed Event 6'),
(22432, 0, 12, 0, 59, 4, 100, 0, 1, 0, 0, 0, 0, 0, 125, 2, 4, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Timed Event 1 Triggered - Trigger Random Timed Event 2-4 (Phase 3)'),
(22432, 0, 13, 0, 59, 4, 100, 0, 2, 0, 0, 0, 0, 0, 12, 22507, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -710, 2754.28, 105.3, 4.7, 'Colonel Jules - On Timed Event 2 Triggered - Summon Creature \'Darkness Released\' (Phase 3)'),
(22432, 0, 14, 15, 59, 4, 100, 0, 3, 0, 0, 0, 0, 0, 12, 22507, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -710, 2754.28, 105.3, 4.7, 'Colonel Jules - On Timed Event 3 Triggered - Summon Creature \'Darkness Released\' (Phase 3)'),
(22432, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 22507, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -713.449, 2745.72, 105.2, 0, 'Colonel Jules - On Timed Event 3 Triggered - Summon Creature \'Darkness Released\''),
(22432, 0, 16, 17, 59, 4, 100, 0, 4, 0, 0, 0, 0, 0, 12, 22507, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -710, 2754.28, 105.3, 4.7, 'Colonel Jules - On Timed Event 4 Triggered - Summon Creature \'Darkness Released\' (Phase 3)'),
(22432, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 22507, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -713.449, 2745.72, 105.2, 0, 'Colonel Jules - On Timed Event 4 Triggered - Summon Creature \'Darkness Released\''),
(22432, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 22507, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, -708.159, 2747.59, 104.885, 0, 'Colonel Jules - On Timed Event 4 Triggered - Summon Creature \'Darkness Released\''),
(22432, 0, 19, 0, 59, 4, 100, 0, 5, 0, 0, 0, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Timed Event 5 Triggered - Cast \'Jules Goes Upright\' (Phase 3)'),
(22432, 0, 20, 0, 59, 4, 100, 0, 6, 0, 0, 0, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Timed Event 6 Triggered - Cast \'Jules Goes Upright\' (Phase 3)'),
(22432, 0, 21, 22, 38, 6, 100, 0, 1, 2, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Set Event Phase 4 (Phases 2-3)'),
(22432, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Remove Timed Event 1'),
(22432, 0, 23, 24, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Remove Timed Event 5'),
(22432, 0, 24, 25, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Remove Timed Event 6'),
(22432, 0, 25, 26, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Stop Waypoint'),
(22432, 0, 26, 27, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Remove All Auras'),
(22432, 0, 27, 28, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39283, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Cast \'Jules Goes Prone\''),
(22432, 0, 28, 29, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22505, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Despawn Instant \'The Exorcism Bubbling Slimer Bunny (DND)\''),
(22432, 0, 29, 30, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22506, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Despawn Instant \'Foul Purge\''),
(22432, 0, 30, 31, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22507, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Despawn Instant \'Darkness Released\''),
(22432, 0, 31, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243201, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 2 - Run Script'),
(22432, 0, 32, 33, 38, 30, 100, 0, 1, 3, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Set Event Phase 1 (Phases 2-5)'),
(22432, 0, 33, 34, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Set Npc Flags None'),
(22432, 0, 34, 35, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Remove Timed Event 1'),
(22432, 0, 35, 36, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Remove Timed Event 5'),
(22432, 0, 36, 37, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 74, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Remove Timed Event 6'),
(22432, 0, 37, 38, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Stop Waypoint'),
(22432, 0, 38, 39, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Remove All Auras'),
(22432, 0, 39, 40, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39283, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Cast \'Jules Goes Prone\''),
(22432, 0, 40, 41, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22505, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Despawn Instant \'The Exorcism Bubbling Slimer Bunny (DND)\''),
(22432, 0, 41, 42, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22506, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Despawn Instant \'Foul Purge\''),
(22432, 0, 42, 43, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22507, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Despawn Instant \'Darkness Released\''),
(22432, 0, 43, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243201, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Data Set 1 3 - Run Script'),
(22432, 0, 44, 45, 34, 8, 100, 0, 8, 1, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 1 Reached - Set Npc Flags Gossip (Phase 4)'),
(22432, 0, 45, 46, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 1 Reached - Set Event Phase 5'),
(22432, 0, 46, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243202, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Point 1 Reached - Run Script'),
(22432, 0, 47, 0, 64, 16, 100, 0, 0, 0, 0, 0, 0, 0, 33, 22432, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Gossip Hello - Quest Credit \'The Exorcism of Colonel Jules\' (Phase 5)');

-- Colonel Jules actionlists: ritual, return to bed, credit window
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2243200, 2243201, 2243202));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243200, 9, 0, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Say Line 0'),
(2243200, 9, 1, 0, 0, 0, 100, 0, 24000, 24000, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Say Line 5'),
(2243200, 9, 2, 0, 0, 0, 100, 0, 10500, 10500, 0, 0, 0, 0, 53, 1, 22432, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Start Waypoint Path 22432'),
(2243200, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 39284, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Threatens, Aura\''),
(2243200, 9, 4, 0, 0, 0, 100, 0, 34000, 34000, 0, 0, 0, 0, 74, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Remove Timed Event 1'),
(2243200, 9, 5, 0, 0, 0, 100, 0, 42000, 42000, 0, 0, 0, 0, 11, 39295, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Vomits, Aura\''),
(2243200, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Say Line 6'),
(2243200, 9, 7, 0, 0, 0, 100, 0, 28000, 28000, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Say Line 7'),
(2243200, 9, 8, 0, 0, 0, 100, 0, 39500, 39500, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Say Line 4'),
(2243201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -710.211, 2754.36, 102.467, 1.46213, 'Colonel Jules - Actionlist - Move To Point 1'),
(2243202, 9, 0, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Npc Flags None'),
(2243202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Event Phase 1'),
(2243202, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 22431, 50, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Data 1 1');
