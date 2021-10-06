INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633503057492950165');

-- Change the min health to cast healing wave to a friendly from 20% to 50%.
UPDATE `smart_scripts` SET `event_param2` = 50, `comment` = 'Stonesplinter Shaman - On Friendly Between 0-50% Health - Cast \'Healing Wave\'' WHERE (`entryorguid` = 1197) AND (`source_type` = 0) AND (`id` = 1);

-- Add self heal to Stonesplinter Shaman
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1197) AND (`source_type` = 0) AND (`id` =3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1197, 0, 3, 0, 2, 0, 100, 0, 0, 50, 17600, 35700, 0, 11, 547, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stonesplinter Shaman - Between 0-50% Health - Cast \'Healing Wave\'');

