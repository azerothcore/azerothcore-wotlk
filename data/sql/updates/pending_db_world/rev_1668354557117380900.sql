--
UPDATE `creature_template` SET `type_flags`=`type_flags`|0x08000000, `npcflag`=130 WHERE `entry`=3443;

DELETE FROM `gossip_menu_option` WHERE `MenuId`=10311;
INSERT INTO `gossip_menu_option` VALUES
(10311,0,1,'I want to browse your goods',3370,3,128,0,0,0,0,'',0,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10311;
INSERT INTO `conditions` VALUES
(15,10311,0,0,0,7,0,185,15,0,0,0,0,'','Show vendor flag if player has cooking'),
(15,10311,0,0,0,8,0,862,0,0,0,0,0,'','Show vendor flag if player player has quest Dig Rat Stew rewarded');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=3443;
INSERT INTO `conditions` VALUES
(23,3443,0,0,0,7,0,185,15,0,0,0,0,'','Show vendor flag if player has cooking'),
(23,3443,0,0,0,8,0,862,0,0,0,0,0,'','Show vendor flag if player player has quest Dig Rat Stew rewarded');

