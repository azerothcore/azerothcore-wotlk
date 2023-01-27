--

DELETE FROM `creature_text_locale` WHERE `CreatureID` = 18182 AND `GroupID` IN (0) AND `Locale` IN ('esES','esMX');
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(18182,0,0,'esES',"¿QUIÉN OSA LLAMAR A GUROK DEL INFRAMUNDO?"),
(18182,0,0,'esMX',"¿QUIÉN OSA LLAMAR A GUROK DEL INFRAMUNDO?");

DELETE FROM `creature_text` WHERE `CreatureID` = 18182 AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (18182,0,0,"WHO DARES CALL GUROK FROM THE UNDERNEATH?",14,0,100,0,0,0,0,0,'Gurok');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18182;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18182) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18182, 0, 3, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurok the Usurper - On Just Summoned - Set Flags Immune To Players'),
(18182, 0, 4, 0, 60, 0, 100, 0, 6000, 6000, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurok the Usurper - On Update - Remove Flags Immune To Players'),
(18182, 0, 5, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurok the Usurper - On Just Summoned - Set Visibility Off'),
(18182, 0, 6, 0, 60, 0, 100, 0, 6000, 6000, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurok the Usurper - On Update - Set Visibility On'),
(18182, 0, 7, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 80, 1818200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurok the Usurper - On Just Summoned - Run Script (No Repeat)'),
(18182, 0, 8, 0, 60, 0, 100, 0, 6000, 6000, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 17, 0, 20, 0, 0, 0, 0, 0, 0, 'Gurok the Usurper - On Update - Start Attacking'),
(18182, 0, 9, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182183, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, -875.231, 8692.96, 251.571, 0.779333, 'Gurok the Usurper - On Just Summoned - Summon Gameobject \'Warmaul Skull\''),
(18182, 0, 10, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182183, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, -878.008, 8686.12, 251.571, 1.75379, 'Gurok the Usurper - On Just Summoned - Summon Gameobject \'Warmaul Skull\''),
(18182, 0, 11, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182183, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, -875.252, 8688.8, 251.571, 1.89303, 'Gurok the Usurper - On Just Summoned - Summon Gameobject \'Warmaul Skull\''),
(18182, 0, 12, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182183, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, -882.108, 8687.11, 251.573, 2.97246, 'Gurok the Usurper - On Just Summoned - Summon Gameobject \'Warmaul Skull\''),
(18182, 0, 13, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182183, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, -884.181, 8690.26, 251.571, 0.169548, 'Gurok the Usurper - On Just Summoned - Summon Gameobject \'Warmaul Skull\''),
(18182, 0, 14, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182183, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, -882.756, 8694.1, 251.571, 0.48393, 'Gurok the Usurper - On Just Summoned - Summon Gameobject \'Warmaul Skull\''),
(18182, 0, 15, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 50, 182183, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, -878.823, 8695.38, 251.571, 1.20747, 'Gurok the Usurper - On Just Summoned - Summon Gameobject \'Warmaul Skull\'');


DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1818200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1818200, 9, 0, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Gurok the Usurper - Actionlist - Say Line 0');
