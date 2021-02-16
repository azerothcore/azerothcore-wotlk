INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613510617294494000');

/* Update Doctor Gregory Victor's gossip to be blizzlike.  Change entry of unknown gossip to avoid conflict.
*/

UPDATE `creature_template` SET `gossip_menu_id` = 5381 WHERE (`entry` = 12920);
UPDATE `npc_text` SET `ID`='999999' WHERE  `ID`=6573;
DELETE FROM `gossip_menu` WHERE  `MenuID`=5381 AND `TextID`=6573;
