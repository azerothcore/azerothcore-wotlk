INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626804070827928100');

-- Changed the param of the shadow bolt so it will stop any spells being casted at the moment
UPDATE `smart_scripts` SET `action_param2` = 1 WHERE (`entryorguid` = 2590) AND (`source_type` = 0) AND (`id` IN (2));

