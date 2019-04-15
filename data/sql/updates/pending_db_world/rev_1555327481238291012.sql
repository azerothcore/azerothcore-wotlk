INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555327481238291012');

DELETE FROM `creature_text` WHERE `creatureid` = '22252';

INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(22252,0,0,'Me so hungry! YUM!',12,0,100,0,0,0,21120,0,'Dragonmaw Peon SAY_1'),
(22252,0,1,'It put the mutton in the stomach!',12,0,100,0,0,0,21121,0,'Dragonmaw Peon SAY_1'),
(22252,0,2,'Mmmm! FOOD!',12,0,100,0,0,0,21119,0,'Dragonmaw Peon SAY_1'),
(22252,0,3,'Time for eating?',12,0,100,0,0,0,21118,0,'Dragonmaw Peon SAY_1'),
(22252,1,0,'Hey...me not feel so good.',12,0,100,0,0,0,21122,0,'Dragonmaw Peon SAY_POISONED_1');
