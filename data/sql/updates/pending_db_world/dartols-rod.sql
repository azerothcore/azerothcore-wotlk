DELETE FROM `gossip_menu` WHERE `MenuID` = 37553;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (37553, 50001);

UPDATE `gossip_menu_option` SET `ActionMenuID` = 37553 WHERE `MenuID` = 5502;

UPDATE `conditions` SET `ConditionValue1` = '1029', `Comment` = 'Only show gossip option if player has completed quest 1029' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 5502 AND `ConditionTypeOrReference` = 8;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3691 AND `id`= 7;
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 3691 AND `id` = 6;
