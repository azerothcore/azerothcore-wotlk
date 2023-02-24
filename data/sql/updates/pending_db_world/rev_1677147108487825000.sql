-- Tamed Kodo - Remove gossip flag & gosip menu.
UPDATE `creature_template` SET `npcflag` = 0,`gossip_menu_id` = 0  WHERE `entry` = 11627;
