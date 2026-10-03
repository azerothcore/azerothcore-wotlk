--
-- The Exorcism of Colonel Jules (quest 10935): sniffed timings, path, lines and npcflags; retail-like skull rate, ending and failure
-- Summon Flying Skull: aura 39284 still ticks 39280 every 2 s, but only the SmartAI of Colonel Jules spawns Darkness Released (20% of the ticks)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 39305;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 39305, 0, 0, 31, 0, 3, 22432, 0, 1, 0, 0, '', 'Summon Flying Skull - Caster is not Colonel Jules (only the SmartAI spawns Darkness Released)');

-- Darkness Released: allow flight so the movement-flag update does not drop the SmartAI fly state mid-path
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 22507;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(22507, 0, 1, 1, 0, 0, 0, NULL);

-- Colonel Jules: 'Be gone' while possessed, 'Oh, thank you' once saved (AI data 2 = 1)
DELETE FROM `gossip_menu` WHERE `MenuID` = 8554 AND `TextID` IN (10706, 10707);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8554, 10706),
(8554, 10707);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 8554 AND `SourceEntry` IN (10706, 10707);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8554, 10706, 0, 0, 104, 1, 2, 1, 0, 0, 0, 0, '', 'Colonel Jules - Show text 10706 if he was saved (AI data 2 = 1)'),
(14, 8554, 10707, 0, 0, 104, 1, 2, 1, 0, 1, 0, 0, '', 'Colonel Jules - Show text 10707 if he was not saved (AI data 2 != 1)');

-- Ritual lines: Barada and Jules alternate random lines; Jules's second line is always 20412
DELETE FROM `creature_text` WHERE `CreatureID` = 22431 AND `GroupID` IN (8, 9, 10);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22431, 8, 0, 'Be cleansed with Light, human!  Let not the demonic corruption overwhelm you.', 12, 0, 100, 0, 0, 0, 20403, 0, 'Anchorite Barada'),
(22431, 8, 1, 'Back, foul beings of darkness!  You have no power here!', 12, 0, 100, 0, 0, 0, 20404, 0, 'Anchorite Barada'),
(22431, 8, 2, 'The power of Light compels you!  Back to your pit!', 12, 0, 100, 0, 0, 0, 20405, 0, 'Anchorite Barada'),
(22431, 8, 3, 'In the name of the Light! It is Light that commands you! It is Light that flung you to the depths of darkness!', 12, 0, 100, 0, 0, 0, 20406, 0, 'Anchorite Barada'),
(22431, 8, 4, 'I... must not...falter!', 12, 0, 100, 0, 0, 0, 20407, 0, 'Anchorite Barada'),
(22431, 8, 5, 'The Light is my guide... it is my sustenance!', 12, 0, 100, 0, 0, 0, 20408, 0, 'Anchorite Barada'),
(22431, 8, 6, 'You cannot deceive me, demon!  Your strength wanes just as my faith bolsters!', 12, 0, 100, 0, 0, 0, 20409, 0, 'Anchorite Barada'),
(22431, 8, 7, 'You... will... leave... this... man!', 12, 0, 100, 0, 0, 0, 20410, 0, 'Anchorite Barada');
DELETE FROM `creature_text` WHERE `CreatureID` = 22432 AND `GroupID` IN (5, 6, 7);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22432, 5, 0, 'No!  Not yet!  This soul is ours!', 12, 0, 100, 0, 0, 0, 20412, 0, 'Colonel Jules'),
(22432, 6, 0, 'Give us time... Let the man die... I am no one... I am no one... Fear the anchorite... Fear the anchorite... Barada... Barada.', 12, 0, 100, 0, 0, 0, 20411, 0, 'Colonel Jules'),
(22432, 6, 1, 'I see your ancestors, Anchorite!  They writhe and scream in the darkness... they are with us!', 12, 0, 100, 0, 0, 0, 20415, 0, 'Colonel Jules'),
(22432, 6, 2, 'This is fruitless, draenei!  You and your little helper cannot wrest control of this pathetic human.  He is mine!', 12, 0, 100, 0, 0, 0, 20416, 0, 'Colonel Jules'),
(22432, 6, 3, 'I will tear your soul into morsels and slow roast them over demon fire!', 12, 0, 100, 0, 0, 0, 20417, 0, 'Colonel Jules'),
(22432, 6, 4, 'All is lost, Anchorite!  Abandon what hope remains.', 12, 0, 100, 0, 0, 0, 20418, 0, 'Colonel Jules');

-- Colonel Jules paths: lift off, cyclic flight (5 laps in one path so the client keeps him hunched), back to bed
DELETE FROM `waypoints` WHERE `entry` IN (22432, 2243200, 2243201, 2243202);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(2243200, 1, -709.732, 2754.1638, 103.59135, NULL, 0, 'Colonel Jules'),
(2243200, 2, -710.52893, 2754.023, 103.48033, NULL, 0, 'Colonel Jules'),
(2243201, 1, -713.74615, 2744.8594, 103.28578, NULL, 0, 'Colonel Jules'),
(2243201, 2, -713.3903, 2748.8086, 103.48023, NULL, 0, 'Colonel Jules'),
(2243201, 3, -708.5772, 2748.765, 103.78584, NULL, 0, 'Colonel Jules'),
(2243201, 4, -708.2393, 2745.6672, 103.73025, NULL, 0, 'Colonel Jules'),
(2243201, 5, -710.8705, 2743.9126, 103.42468, NULL, 0, 'Colonel Jules'),
(2243201, 6, -713.3903, 2748.8086, 103.48023, NULL, 0, 'Colonel Jules'),
(2243201, 7, -708.5772, 2748.765, 103.78584, NULL, 0, 'Colonel Jules'),
(2243201, 8, -708.2393, 2745.6672, 103.73025, NULL, 0, 'Colonel Jules'),
(2243201, 9, -710.8705, 2743.9126, 103.42468, NULL, 0, 'Colonel Jules'),
(2243201, 10, -713.3903, 2748.8086, 103.48023, NULL, 0, 'Colonel Jules'),
(2243201, 11, -708.5772, 2748.765, 103.78584, NULL, 0, 'Colonel Jules'),
(2243201, 12, -708.2393, 2745.6672, 103.73025, NULL, 0, 'Colonel Jules'),
(2243201, 13, -710.8705, 2743.9126, 103.42468, NULL, 0, 'Colonel Jules'),
(2243201, 14, -713.3903, 2748.8086, 103.48023, NULL, 0, 'Colonel Jules'),
(2243201, 15, -708.5772, 2748.765, 103.78584, NULL, 0, 'Colonel Jules'),
(2243201, 16, -708.2393, 2745.6672, 103.73025, NULL, 0, 'Colonel Jules'),
(2243201, 17, -710.8705, 2743.9126, 103.42468, NULL, 0, 'Colonel Jules'),
(2243201, 18, -713.3903, 2748.8086, 103.48023, NULL, 0, 'Colonel Jules'),
(2243201, 19, -708.5772, 2748.765, 103.78584, NULL, 0, 'Colonel Jules'),
(2243201, 20, -708.2393, 2745.6672, 103.73025, NULL, 0, 'Colonel Jules'),
(2243201, 21, -710.8705, 2743.9126, 103.42468, NULL, 0, 'Colonel Jules'),
(2243202, 1, -710.5018, 2750.7266, 103.75797, NULL, 0, 'Colonel Jules'),
(2243202, 2, -710.211, 2754.36, 102.467, 1.46213, 0, 'Colonel Jules');

-- Anchorite Barada
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 22431);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22431, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243102, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Reset - Run Script \'Reset\''),
(22431, 0, 1, 0, 62, 1, 100, 0, 8539, 0, 0, 0, 0, 0, 80, 2243100, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Run Script \'Exorcism\' (Phase 1)'),
(22431, 0, 2, 0, 62, 14, 100, 0, 8539, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Gossip Option 0 Selected - Close Gossip (Phases 2-4)'),
(22431, 0, 3, 0, 8, 4, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Spellhit - Set Flag Standstate Kneel (Phase 3)'),
(22431, 0, 4, 0, 2, 6, 100, 0, 0, 1, 1000, 1000, 0, 0, 80, 2243101, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Between 0-1% Health - Run Script \'Exorcism Failed\' (Phases 2-3)'),
(22431, 0, 5, 0, 6, 14, 100, 0, 0, 0, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - On Just Died - Do Action \'Exorcism Failed\' (Phases 2-4)');

-- Anchorite Barada actionlists: exorcism (drives both sides' lines), exorcism failed, reset
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2243100, 2243101, 2243102));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Event Phase 2'),
(2243100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Npc Flags Questgiver'),
(2243100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Close Gossip'),
(2243100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Disable Evade'),
(2243100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Active On'),
(2243100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Invincibility Hp 1'),
(2243100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Disable Health Regeneration'),
(2243100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Remove Flag Standstate Kneel'),
(2243100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Run Off'),
(2243100, 9, 9, 0, 0, 0, 100, 0, 1700, 1700, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 0'),
(2243100, 9, 10, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 1'),
(2243100, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Do Action \'Exorcism Started\''),
(2243100, 9, 12, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -707.68, 2747.8, 101.6, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 0'),
(2243100, 9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -710.87, 2747.8, 101.6, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 15, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.57, 'Anchorite Barada - Actionlist - Set Orientation 1.57'),
(2243100, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Home Position'),
(2243100, 9, 17, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Flag Standstate Kneel'),
(2243100, 9, 18, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Event Phase 3'),
(2243100, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39277, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Barada Commands\''),
(2243100, 9, 20, 0, 0, 0, 100, 0, 10100, 10100, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 21, 0, 0, 0, 100, 0, 15600, 15600, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 5'),
(2243100, 9, 22, 0, 0, 0, 100, 0, 5100, 5100, 0, 0, 0, 0, 11, 39278, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Barada Falters\''),
(2243100, 9, 23, 0, 0, 0, 100, 0, 10500, 10500, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 24, 0, 0, 0, 100, 0, 15600, 15600, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 6'),
(2243100, 9, 25, 0, 0, 0, 100, 0, 15600, 15600, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 26, 0, 0, 0, 100, 0, 15600, 15600, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 6'),
(2243100, 9, 27, 0, 0, 0, 100, 0, 15600, 15600, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 28, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 11, 39277, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Barada Commands\''),
(2243100, 9, 29, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 6'),
(2243100, 9, 30, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 31, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 6'),
(2243100, 9, 32, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 33, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 6'),
(2243100, 9, 34, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 35, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 6'),
(2243100, 9, 36, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 8'),
(2243100, 9, 37, 0, 0, 0, 100, 0, 10400, 10400, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Say Line 6'),
(2243100, 9, 38, 0, 0, 0, 100, 0, 6500, 6500, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Event Phase 4'),
(2243100, 9, 39, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Do Action \'Exorcism Succeeded\''),
(2243100, 9, 40, 0, 0, 0, 100, 0, 5400, 5400, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Say Line 7'),
(2243100, 9, 41, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Remove All Auras'),
(2243100, 9, 42, 0, 0, 0, 100, 0, 5100, 5100, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Remove Flag Standstate Kneel'),
(2243100, 9, 43, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -706.95465, 2752.7083, 101.675, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 44, 0, 0, 0, 100, 0, 2600, 2600, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -707.2108, 2754.1055, 101.675, 0, 'Anchorite Barada - Actionlist - Move To Position'),
(2243100, 9, 45, 0, 0, 0, 100, 0, 700, 700, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.74017, 'Anchorite Barada - Actionlist - Set Orientation 2.74017'),
(2243100, 9, 46, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Home Position'),
(2243100, 9, 47, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39321, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Heal Self\''),
(2243100, 9, 48, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Enable Evade'),
(2243100, 9, 49, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Evade'),
(2243101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Event Phase 4'),
(2243101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 3, 0, 0, 0, 0, 0, 19, 22432, 50, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Colonel Jules Do Action \'Exorcism Failed\''),
(2243101, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 17680, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Cast \'Spirit Spawn-out\''),
(2243101, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 0, 41, 0, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Despawn (Respawn 60s)'),
(2243102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Event Phase 1'),
(2243102, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Flag Standstate Kneel'),
(2243102, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Npc Flags Gossip & Questgiver'),
(2243102, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Reactstate Passive'),
(2243102, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Enable Evade'),
(2243102, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 102, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Enable Health Regeneration'),
(2243102, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Active Off'),
(2243102, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Barada - Actionlist - Set Invincibility Hp 0');

-- Colonel Jules
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 22432);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22432, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2243203, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Reset - Run Script \'Reset\''),
(22432, 0, 1, 0, 72, 9, 100, 0, 1, 0, 0, 0, 0, 0, 80, 2243200, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Action \'Exorcism Started\' Done - Run Script \'Exorcism\' (Phases 1 & 4)'),
(22432, 0, 2, 0, 8, 2, 20, 0, 39280, 0, 0, 0, 0, 0, 12, 22507, 3, 40000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Spellhit \'Jules Threatens\' - Summon Creature \'Darkness Released\' (Phase 2)'),
(22432, 0, 3, 0, 72, 2, 100, 0, 2, 0, 0, 0, 0, 0, 80, 2243201, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Action \'Exorcism Succeeded\' Done - Run Script \'Exorcism Succeeded\' (Phase 2)'),
(22432, 0, 4, 0, 58, 4, 100, 0, 0, 2243202, 0, 0, 0, 0, 80, 2243204, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Path 2243202 Finished - Run Script \'Back In Bed\' (Phase 3)'),
(22432, 0, 5, 0, 64, 8, 100, 0, 0, 0, 0, 0, 0, 0, 33, 22432, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Gossip Hello - Quest Credit \'The Exorcism of Colonel Jules\' (Phase 4)'),
(22432, 0, 6, 0, 72, 6, 100, 0, 3, 0, 0, 0, 0, 0, 80, 2243202, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - On Action \'Exorcism Failed\' Done - Run Script \'Exorcism Failed\' (Phases 2-3)');

-- Colonel Jules actionlists: exorcism, exorcism succeeded, exorcism failed, reset, back in bed
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (2243200, 2243201, 2243202, 2243203, 2243204));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2243200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Event Phase 2'),
(2243200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Data 2 0'),
(2243200, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Npc Flags None'),
(2243200, 9, 3, 0, 0, 0, 100, 0, 36300, 36300, 0, 0, 0, 0, 53, 1, 2243200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Start Waypoint Path 2243200'),
(2243200, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 11, 39284, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Threatens, Aura\''),
(2243200, 9, 5, 0, 0, 0, 100, 0, 76300, 76300, 0, 0, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Goes Upright\''),
(2243200, 9, 6, 0, 0, 0, 100, 0, 3700, 3700, 0, 0, 0, 0, 11, 39295, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Vomits, Aura\''),
(2243200, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 2243201, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Start Waypoint Path 2243201'),
(2243200, 9, 8, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 11, 39294, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Goes Upright\''),
(2243201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Event Phase 3'),
(2243201, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Stop Waypoint'),
(2243201, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Remove All Auras'),
(2243201, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39283, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Goes Prone\''),
(2243201, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 2243202, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Start Waypoint Path 2243202'),
(2243202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Event Phase 1'),
(2243202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Npc Flags Gossip'),
(2243202, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Stop Waypoint'),
(2243202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Remove All Auras'),
(2243202, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39283, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Goes Prone\''),
(2243202, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22505, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Despawn Instant \'The Exorcism Bubbling Slimer Bunny (DND)\''),
(2243202, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22506, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Despawn Instant \'Foul Purge\''),
(2243202, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 22507, 100, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Despawn Instant \'Darkness Released\''),
(2243202, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -710.211, 2754.36, 102.467, 1.46213, 'Colonel Jules - Actionlist - Move To Point 1'),
(2243203, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Event Phase 1'),
(2243203, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Npc Flags Gossip'),
(2243203, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Reactstate Passive'),
(2243203, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 39283, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Cast \'Jules Goes Prone\''),
(2243203, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 1, 30, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Fly On'),
(2243203, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 136, 0, 0, 27, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Walk Speed 0.27'),
(2243204, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Event Phase 4'),
(2243204, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Npc Flags Gossip'),
(2243204, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.46213, 'Colonel Jules - Actionlist - Set Orientation 1.46213'),
(2243204, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Colonel Jules - Actionlist - Set Data 2 1');
