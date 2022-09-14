-- DB update 2022_09_03_04 -> 2022_09_06_00
--
DELETE FROM `gossip_menu` WHERE `MenuId`=6793 AND `TextId`=8080;
INSERT INTO `gossip_menu` VALUES
(6793,8080);

DELETE FROM `gossip_menu` WHERE `MenuId`=6794 AND `TextId`=8078;
INSERT INTO `gossip_menu` VALUES
(6794,8078);

DELETE FROM `gossip_menu` WHERE `MenuId`=6795 AND `TextId`=8079;
INSERT INTO `gossip_menu` VALUES
(6795,8079);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (6793,6794,6795);
INSERT INTO `conditions` VALUES
(14,6793,8080,0,0,29,0,15727,250,0,0,0,0,'','Show gossip if Cthun is alive'),
(14,6793,8111,0,0,29,0,15727,250,1,0,0,0,'','Show gossip if Cthun is dead'),

(14,6794,8078,0,0,29,0,15727,250,0,0,0,0,'','Show gossip if Cthun is alive'),
(14,6794,8112,0,0,29,0,15727,250,1,0,0,0,'','Show gossip if Cthun is dead'),

(14,6795,8079,0,0,29,0,15727,250,0,0,0,0,'','Show gossip if Cthun is alive'),
(14,6795,8113,0,0,29,0,15727,250,1,0,0,0,'','Show gossip if Cthun is dead');
