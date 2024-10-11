-- DB update 2023_11_02_03 -> 2023_11_05_00
UPDATE `gossip_menu` SET `TextID` = 4435 WHERE `MenuID` = 3642 AND `TextID` = 4437;
UPDATE `gossip_menu` SET `TextID` = 4435 WHERE `MenuID` = 4558 AND `TextID` = 4437;

UPDATE `conditions` SET `SourceEntry` = 4435 WHERE `SourceGroup` = 3642 AND `SourceEntry` = 4437;
UPDATE `conditions` SET `SourceEntry` = 4435 WHERE `SourceGroup` = 4558 AND `SourceEntry` = 4437;
