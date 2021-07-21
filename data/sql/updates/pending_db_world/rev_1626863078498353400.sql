INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626863078498353400');

-- Changed the id of the spell so they use the Sneak that puts them on stealth. Changed the comments to know what spell are they using
UPDATE `smart_scripts` SET `action_param1` = 22766, `comment` = 'Jadefire Shadowstalker - On Respawn - Cast Sneak (Stealth mode)' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 0);
UPDATE `smart_scripts` SET `comment` = 'Jadefire Shadowstalker - On Aggro - Cast Jadefire' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 1);
UPDATE `smart_scripts` SET `comment` = 'Jadefire Shadowstalker - On Aggro - Cast Slowing Poison' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 2);

-- Added to go back to stealth when out of combat
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7110, 0, 3, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 11, 22766, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jadefire Shadowstalker - Out of Combat - Cast Sneak (Stealth mode)');

