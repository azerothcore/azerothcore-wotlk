DELETE FROM `gossip_menu` WHERE `MenuID` = 57005;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (57005, 50001);

UPDATE `gossip_menu_option` SET `ActionMenuID` = 57005 WHERE `MenuID` = 5502;

UPDATE `conditions` SET `ConditionValue1` = '1029', `Comment` = 'Only show gossip option if player has completed quest 1029' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 5502` AND `ConditionTypeOrReference` = 8;
