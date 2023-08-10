#######################creature_template  ###################
##fairbanks Use gossip_menu_id 7283
##add gossip menu flag  Prevent red errors when the server starts
UPDATE `creature_template` SET `gossip_menu_id` = 7283, `npcflag` = 1
WHERE (`entry` = 4542);
