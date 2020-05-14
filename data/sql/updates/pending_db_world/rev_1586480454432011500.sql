INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586480454432011500');

DELETE FROM `command` WHERE `name`='cheat explore';
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('cheat explore', 2, 'Syntax: .cheat explore #flag\r\nReveal or hide all maps for the selected player. If no player is selected, hide or reveal maps to you.\r\nUse a #flag of value 1 to reveal, use a #flag value of 0 to hide all maps.');
