INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613057319260756500');

/* Delete Cataclysm text from quest The Nordrassil Summit.  Source: https://wow.gamepedia.com/The_Nordrassil_Summit
*/

DELETE FROM `npc_text` WHERE  `ID`=18268;
DELETE FROM `broadcast_text` WHERE  `ID`=52965;
