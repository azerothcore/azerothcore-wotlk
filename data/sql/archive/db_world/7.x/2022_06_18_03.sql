-- DB update 2022_06_18_02 -> 2022_06_18_03
UPDATE `creature_template` SET `npcflag` = 1, `gossip_menu_id` = '21208', `AIName` = 'SmartAI' WHERE (`entry` = 6669);
