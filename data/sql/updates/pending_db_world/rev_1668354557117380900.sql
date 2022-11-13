--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=23 AND `SourceGroup`=3443;
INSERT INTO `conditions` VALUES
(23,3443,44977,0,0,8,0,862,0,0,0,0,0,'','Sell Recipe: Dig Rat Stew if player has quest Dig Rat Stew rewarded'),
(23,3443,5051,0,0,8,0,862,0,0,0,0,0,'','Sell Dig Rat if player has quest Dig Rat Stew rewarded');
