INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547942801355864450');

-- SMART_ACTION_SET_SIGHT_DIST
UPDATE `smart_scripts` SET `action_type` = 121 WHERE `action_type` = 136;

-- SMART_ACTION_FLEE
UPDATE `smart_scripts` SET `action_type` = 122 WHERE `action_type` = 137;

-- SMART_ACTION_ADD_THREAT
UPDATE `smart_scripts` SET `action_type` = 123 WHERE `action_type` = 138;

-- SMART_ACTION_LOAD_EQUIPMENT
UPDATE `smart_scripts` SET `action_type` = 124 WHERE `action_type` = 139;

-- SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT
UPDATE `smart_scripts` SET `action_type` = 125 WHERE `action_type` = 140;

-- SMART_ACTION_REMOVE_ALL_GAMEOBJECTS
UPDATE `smart_scripts` SET `action_type` = 126 WHERE `action_type` = 146;
