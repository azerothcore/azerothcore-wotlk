INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626863078498353400');

-- Changed the id of the spell so they use the Sneak that puts them on stealth. Changed the comments to know what spell are they using
UPDATE `smart_scripts` SET `action_param1` = 22766, `comment` = 'Jadefire Shadowstalker - On Respawn - Cast Sneak (Stealth mode)' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 0);
UPDATE `smart_scripts` SET `comment` = 'Jadefire Shadowstalker - On Aggro - Cast Jadefire' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 1);
UPDATE `smart_scripts` SET `action_param1` = 7992, `comment` = 'Jadefire Shadowstalker - On Respawn - Cast Slowing Poison' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 2);

