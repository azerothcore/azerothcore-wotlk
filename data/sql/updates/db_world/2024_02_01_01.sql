-- DB update 2024_02_01_00 -> 2024_02_01_01
-- Add Repair npcflag to 28344 Blazzle
UPDATE `creature_template` SET `npcflag` = (`npcflag` | 4096) WHERE `entry` = 28344;
