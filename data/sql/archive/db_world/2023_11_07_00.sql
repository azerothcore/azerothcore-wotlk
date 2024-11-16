-- DB update 2023_11_05_00 -> 2023_11_07_00
-- Boots & Gant
UPDATE `creature_template` SET `npcflag` = `npcflag`|512 WHERE `entry` IN (19617,19572);
