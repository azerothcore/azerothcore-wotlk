INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626863078498353400');

-- Cast Sneak (id:22766) instead of Sneak (id:11013) to actually enter stealth. Sniffed on Classic
UPDATE `smart_scripts` SET `event_type`= 25, `action_param1` = 22766, `comment` = 'Jadefire Shadowstalker - On Respawn - Cast Sneak (id:22766) (Stealth mode)' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 0);
-- Cast Jadefire (id:13578)
UPDATE `smart_scripts` SET `comment` = 'Jadefire Shadowstalker - On Aggro - Cast Jadefire (id:13578)' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 1);
-- Cast Slowing Poison (id:7992) instead of Slowing Poison (id:14897). Sniffed on Classic
UPDATE `smart_scripts` SET `comment` = 'Jadefire Shadowstalker - On Aggro - Cast Slowing Poison (id:7992)' WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` = 2);

