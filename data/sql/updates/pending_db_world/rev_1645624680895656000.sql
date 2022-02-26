INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645624680895656000');

-- Add gossip flag to Expedition Commander, previously 0
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE `entry` IN (33210,34254);
-- Assign the correct menuID to Expedition Commander, previously 0
UPDATE `creature_template` SET `gossip_menu_id` = 10314 WHERE `entry` IN (33210,34254);

