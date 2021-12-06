INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638737032167850775');

-- Makes quest Lazy Peon broadcast work work only from themselves and not the player (action_para2)
-- Sets it up where the target_type is the player and only triggers with in 20 yards
UPDATE `smart_scripts` SET `action_param2`=1, `target_type`=18, `target_param1`=20 WHERE  `comment`='Lazy Peon - On Script - Play Sound 6197';
