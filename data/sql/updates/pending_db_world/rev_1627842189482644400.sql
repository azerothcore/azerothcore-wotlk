INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627842189482644400');

-- Walk to waypoint
UPDATE `smart_scripts` SET `action_param1` = 0  WHERE (`entryorguid` = 9598) AND (`source_type` = 0) AND (`id` IN (0));
-- Make Arei (9598) fight on aggro
UPDATE `smart_scripts` SET `action_type` = 20, `target_type` = 2, `comment` = 'Arei - On Aggro - Start Attacking' WHERE (`entryorguid` = 9598) AND (`source_type` = 0) AND (`id` IN (2));
-- Make Arei (9598) from darnassus and help us fight
UPDATE `creature_template` SET `faction` = 79 WHERE (`entry` = 9598);

