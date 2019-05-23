INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558651761752003200');

-- Olga's gossip menu needs to be corrected in smart_scripts to register user selection

UPDATE `smart_scripts` SET `event_param1` = 9014 WHERE `entryorguid` = 24639 AND `source_type` = 0 AND `id` = 0;

-- Jack had the wrong gossip_menu_id in his creature_template entry

UPDATE `creature_template` SET `gossip_menu_id` = 9013 WHERE `entry` = 24788;

-- Jack needs the corresponding correction to smart_scripts so the debt item can be placed in character's inventory

UPDATE `smart_scripts` SET `event_param1` = 9013 WHERE `entryorguid` = 24788 AND `source_type` = 0 AND `id` = 3;
