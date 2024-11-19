-- DB update 2022_12_22_08 -> 2022_12_22_09
--
DELETE FROM `spell_loot_template` WHERE `Entry`=58160 AND `Item`=13926;
DELETE FROM `creature_loot_template` WHERE `item`=24478 AND `entry` IN (21044, 21126, 21842);
