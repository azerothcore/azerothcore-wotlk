INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606162431492361200');
DELETE `creature`, `creature_addon`, `waypoint_data`
FROM
    `creature`, `creature_addon`, `waypoint_data`
WHERE
    `creature`.`guid` = 203340 AND `creature`.`guid` = `creature_addon`.`guid` AND `creature_addon`.`path_id` = `waypoint_data`.`id`;
