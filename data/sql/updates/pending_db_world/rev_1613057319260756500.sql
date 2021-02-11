INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613057319260756500');

/* Delete Cataclysm gossip from quest The Nordrassil Summit.  "I believe Aggra is almost here, and the other aspects have assembled.$B$BAre you ready to begin, $n?"  Source: https://wow.gamepedia.com/The_Nordrassil_Summit
*/

DELETE FROM `npc_text` WHERE  `ID`=18268;
DELETE FROM `broadcast_text` WHERE  `ID`=52965;

/* Delete Cataclysm gossip from Wyrtle Spreelthonket.  "It ain't easy gettin' a contract with the Blackrock orcs. I mean, come on! The Blackrock orcs! These guys have been though more battles than Aggramar, AND they're sittin' on a mountain made of dark iron to boot! Cha-ching!"  Source: https://wow.gamepedia.com/Wyrtle_Spreelthonket
*/

DELETE FROM `npc_text` WHERE  `ID`=17425;
DELETE FROM `broadcast_text` WHERE  `ID`=48369;
