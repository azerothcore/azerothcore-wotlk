-- Burko (18990), Aresella (18991) - Remove Gossip and Vendor npc flags.
UPDATE `creature_template` SET `npcflag` = `npcflag`&~(128|1) WHERE `entry` IN (18990,18991);
