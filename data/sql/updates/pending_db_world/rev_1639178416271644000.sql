INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639178416271644000');

/* Quest Completion for 'Tomb of the Lightbringer'
*/

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1723801) AND (`source_type` = 9) AND (`id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1723801, 9, 2, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Truuen - Action list - Despawns'),
(1723801, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 26, 9446, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Anchorite Truuen - \'Tomb of the Lightbringer\' Quest Credit');

