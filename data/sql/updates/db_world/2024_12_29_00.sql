-- DB update 2024_12_28_02 -> 2024_12_29_00
UPDATE `gossip_menu` SET `TextID` = 7786 WHERE `MenuID` = 12002 AND `TextID` = 50030;
DELETE FROM `npc_text` WHERE `ID` = 50030;
