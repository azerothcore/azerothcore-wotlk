INSERT INTO version_db_world (`sql_rev`) VALUES ('1534115647861309430');

DELETE FROM `command` WHERE `name` IN
('npc set factionid',
'npc set faction temp',
'npc set faction original',
'npc set faction permanent');

INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc set faction temp', 3, 'Syntax: .npc set faction temp #factionid\r\n\r\nTemporarily set the faction of the selected creature to #factionid.'),
('npc set faction original', 3, 'Syntax: .npc set faction original\r\n\r\nRevert the temporal faction of the selected creature.'),
('npc set faction permanent', 3, 'Syntax: .npc set faction permanent #factionid\r\n\r\nPermanently set the faction of the selected creature to #factionid.');
