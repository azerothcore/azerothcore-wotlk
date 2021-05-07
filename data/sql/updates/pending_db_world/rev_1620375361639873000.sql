INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620375361639873000');

-- Remove quest mutual exclusivity
UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE (`ID` IN (990,10752));

-- Remove Cataclysm gossip for Sentinel Selarin
UPDATE `creature_template` SET `gossip_menu_id` = 0, `npcflag` = 2 WHERE (`entry` = 3694);
DELETE FROM `gossip_menu` WHERE `MenuID` = 10268 AND `TextID` = 14259;
DELETE FROM `npc_text` WHERE `id` = 14259;
