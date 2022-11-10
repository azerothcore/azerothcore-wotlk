-- Remove incorrect gossip from Roetten Stonehammer
UPDATE `creature_template` SET `gossip_menu_id` = 0 WHERE (`entry` = 5637);
