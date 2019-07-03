INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562149079104513383');

-- The Ebon Blade Prisoners should not be attackable
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 2 WHERE `entry` IN (30186,30194,30196,30195);

-- The Jotunheim Cage should reset after 5 minutes instead of 10 in order to sync with the Ebon Blade Prisoner respawn
UPDATE `gameobject_template` SET `Data3` = 300000 WHERE `entry` = 192135;

-- Jotunheim Warrior, Njorndar Spear-Sister and Mjordin Water Magus have to use "SMART_TARGET_SELF" instead of "SMART_TARGET_ACTION_INVOKER" for their talk action
UPDATE `smart_scripts` SET `target_type` = 1 WHERE `entryorguid` IN (30243,30632,29880) AND `source_type` = 0 AND `action_type` = 1 AND `target_type` = 7;
