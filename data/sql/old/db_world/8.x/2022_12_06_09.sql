-- DB update 2022_12_06_08 -> 2022_12_06_09
-- Set IMMUNE_TO_PC & IMMUNE_TO_NPC
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|768 WHERE (`entry` = 18161);
