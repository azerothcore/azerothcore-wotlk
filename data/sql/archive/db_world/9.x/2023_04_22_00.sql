-- DB update 2023_04_21_00 -> 2023_04_22_00
-- Tamed Kodo - Remove gossip flag & gosip menu.
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(1),`gossip_menu_id` = 0  WHERE `entry` = 11627;
