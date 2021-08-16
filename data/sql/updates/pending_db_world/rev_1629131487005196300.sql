INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629131487005196300');

-- Replace LANG_PINFO_MUTED
UPDATE `acore_string` SET `content_default` = '│ Muted: (Reason: %s, Time: %s, Left %s, By: %s)' WHERE `entry` = 550;
