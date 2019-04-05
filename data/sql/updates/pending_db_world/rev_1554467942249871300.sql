INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554467942249871300');

DELETE FROM `creature_text` WHERE `creatureid` = '22252';

INSERT INTO `creature_text` VALUES (22252, 0, 0, 'Me so hungry! YUM!', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Peon Say1'),
(22252, 0, 1, 'It put the mutton in the stomach!', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Peon SAY_2'),
(22252, 0, 2, 'Mmmm! FOOD!', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Peon SAY_3'),
(22252, 0, 3, 'Time for eating?', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Peon SAY_4'),
(22252, 1, 4, 'Hey...me not feel so good.', 12, 0, 100, 0, 0, 0, 0, 0, 'Dragonmaw Peon SAY_POISON');