-- Remove incorrect gossip from Roetten Stonehammer
UPDATE `creature_template` SET `npcflag` = 2, `gossip_menu_id` = 0 WHERE (`entry` = 5637);
