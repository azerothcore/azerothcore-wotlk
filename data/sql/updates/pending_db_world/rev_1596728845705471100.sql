INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1596728845705471100');
/*
 * Raid: Ulduar
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33773;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 33773);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33773, 0, 0, 0, 0, 0, 100, 0, 500, 500, 30000, 30000, 11, 49576, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - In Combat - Cast \'49576\''),
(33773, 0, 1, 0, 0, 0, 100, 0, 3000, 8000, 7000, 12000, 11, 63722, 0, 0, 0, 0, 0, 17, 12, 65, 1, 0, 0, 0, 0, 'Faceless Horror - In Combat - Cast \'63722\''),
(33773, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 63703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Aggro - Cast \'63703\''),
(33773, 0, 3, 0, 7, 0, 100, 0, 0, 0, 0, 0, 28, 63703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Faceless Horror - On Evade - Remove Aura \'63703\'');
