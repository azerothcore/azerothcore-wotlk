INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629097518726008500');

-- Remove Text
DELETE FROM `npc_text` WHERE `ID` = 16644;

-- Remove Gossip Menu
DELETE FROM `gossip_menu` WHERE `MenuID` = 11876;

-- Update "Winkey" Template
UPDATE `creature_template` SET `npcflag` = 0 WHERE (`entry` = 7770);