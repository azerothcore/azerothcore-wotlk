
DELETE FROM `creature_template` where `entry` = 190000;
INSERT INTO `creature_template` (`entry`,`modelid1`,`name`,`subname`,`minlevel`,`maxlevel`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`unit_class`,`unit_flags`,`type`,`InhabitType`,`HoverHeight`,`ScriptName`)
VALUES (190000,21322,'Shadow of Sceicco','Arena watcher' ,1,1,35, 1,1,1.14286,0.1,1,128,7,3,1,'npc_arena_watcher');

DELETE FROM `trinity_string` WHERE `entry` IN (11200,11201,11202,11203,11204);
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES (11200,'Watch the match 2x2 (now games: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES (11201,'Watch the match 3x3 (now games: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES (11202,'Watch the match 5x5 (now games: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES (11203,'Watch the match 1x1 (now games: %u)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `trinity_string` (`entry`,`content_default`,`content_loc1`,`content_loc2`,`content_loc3`,`content_loc4`,`content_loc5`,`content_loc6`,`content_loc7`,`content_loc8`) VALUES (11204,'Follow player',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);   


DELETE FROM `command` WHERE `permission` = 1004;
INSERT INTO `command` (`name`, `permission`, `help`) VALUES ('spect', 1004, 'Syntax: .spect leave/count'); 

		 


 
