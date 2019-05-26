INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558481800224314500');

-- Scarshield Spellbinder
UPDATE `smart_scripts` SET `event_flags` = 2, `event_type` = 63 WHERE `entryorguid` = 9098 AND `source_type` = 0 AND `id` = 0;

-- Tunneler
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 16968 AND `source_type` = 0 AND `id` = 7;

-- Vardmadra
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 30945 AND `source_type` = 0 AND `id` = 3;

-- Arakkoa Egg
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 20214 AND `source_type` = 0;

-- Forlorn Spirit
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 2044 AND `source_type` = 0 AND `id` = 0;
