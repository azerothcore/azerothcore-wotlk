-- DB update 2022_12_06_09 -> 2022_12_06_10
-- NOT_SELECTABLE, IMMUNE_TO_PC, IMMUNE_TO_NPC
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33555200 WHERE `entry` IN (24222, 17378, 17407, 17408);
