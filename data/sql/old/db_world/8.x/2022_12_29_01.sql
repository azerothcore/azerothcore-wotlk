-- DB update 2022_12_29_00 -> 2022_12_29_01
DELETE FROM `gossip_menu` WHERE `MenuID` = 5501;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (5501, 6554);

UPDATE `gossip_menu_option` SET `ActionMenuID` = 5501 WHERE `MenuID` = 5502;

UPDATE `conditions` SET `ConditionValue1` = 1030, `Comment` = 'Only show gossip option if player has completed quest 1030' WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 5502 AND `ConditionTypeOrReference` = 8;

UPDATE `npc_text` SET `ID` = 6554 WHERE  `ID` = 50001;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3691 AND `id`= 7;
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 3691 AND `id` = 6;
