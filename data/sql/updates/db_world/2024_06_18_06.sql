-- DB update 2024_06_18_05 -> 2024_06_18_06
--
UPDATE `creature_text` SET `BroadcastTextId` = 21123 WHERE `BroadcastTextId` = 21223 AND `CreatureID` = 23311;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23311) AND (`source_type` = 0) AND (`id` IN (0, 9, 10, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23311, 0, 0, 1, 8, 0, 100, 513, 40742, 0, 0, 0, 0, 0, 33, 23311, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Disobedient Dragonmaw Peon - On Spell Hit (Booterang) - Give Kill Credit'),
(23311, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disobedient Dragonmaw Peon - Linked with Previous Event - Despawn After 10 seconds'),
(23311, 0, 10, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 17, 233, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disobedient Dragonmaw Peon - Linked with Previous Event - Set Emote State'),
(23311, 0, 11, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 62, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Disobedient Dragonmaw Peon - On Reset - Reset Faction');
