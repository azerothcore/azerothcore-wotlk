-- DB update 2022_12_30_03 -> 2022_12_30_04
--
DELETE FROM `npc_text` WHERE `ID` = 10884;
DELETE FROM `gossip_menu` WHERE `MenuID`=8441 AND `TextID`=10884;
