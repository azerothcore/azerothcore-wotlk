INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633030444663834900');

DELETE FROM `smart_scripts` WHERE `entryorguid`=6746 AND `id`>1;
INSERT INTO `smart_scripts` VALUES
(6746,0,2,3,62,0,100,0,21215,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Pala - On gossip option 0 select - Close gossip'),
(6746,0,3,0,61,0,100,0,0,0,0,0,0,85,24751,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Innkeeper Pala - On gossip option 0 select - Player cast Trick or Treat on self');
