INSERT INTO version_db_world (`sql_rev`) VALUES ('1530734106945512205');

UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 7856;
UPDATE `smart_scripts` SET `event_type` = 9, `event_param1` = 2, `event_param2` = 30, `comment` = 'Southsea Freebooter - Within 2-30 Range - Shoot' WHERE `entryorguid` = 7856 AND `id` = 0;
