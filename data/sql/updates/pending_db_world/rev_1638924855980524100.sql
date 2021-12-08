INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638924855980524100');

/* Update Greatmother Hawkwind Faction
*/

UPDATE `creature_template` SET `faction` = 104 WHERE (`entry` = 2991);
