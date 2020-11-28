INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605586971095091500');
-- Remove Quest Giver & Gossip flags
UPDATE `creature_template` SET `npcflag` = 0 WHERE (`entry` = 1747);
-- Remove Cataclysm gossip from DB
DELETE FROM `gossip_menu` WHERE (`MenuID` = 11874) AND (`TextID` IN (16642));

