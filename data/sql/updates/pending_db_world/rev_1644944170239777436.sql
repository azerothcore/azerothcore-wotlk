INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644944170239777436');

UPDATE `smart_scripts` SET `event_param1` = 0 WHERE `source_type` = 0 AND `action` = 11 AND `event` = 23 AND `entryorguid` = 17664;
UPDATE `smart_scripts` SET `event_param1` = 0 WHERE `source_type` = 0 AND `action` = 71 AND `event` = 1 AND `entryorguid` IN (
    37887,
    38039,
    38040,
    38041,
    38042,
    38043,
    38044,
    38045
);
