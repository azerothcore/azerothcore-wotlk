-- DB update 2022_11_12_08 -> 2022_11_12_09
-- Remove incorrect gossip from Roetten Stonehammer
UPDATE `creature_template` SET `npcflag` = 2, `gossip_menu_id` = 0 WHERE (`entry` = 5637);
