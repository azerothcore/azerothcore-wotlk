INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624914323095978900');

INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
  (30096, 'LFG is set to 1 player queue for debugging.'),
  (30097, 'LFG is set to normal queue.');

INSERT INTO `command` (`name`, `security`, `help`) VALUES
  ('debug lfg', 3, 'Syntax: .debug lfg\r\nToggle debug mode for lfg. In debug mode GM can start lfg queue with one player.');
