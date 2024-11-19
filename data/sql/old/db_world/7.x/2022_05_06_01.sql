-- DB update 2022_05_06_00 -> 2022_05_06_01
--
-- Remove the item Cache of Zanzil's Altered Mixture (8073) from Grand Foreman Puzik Gallywix (7288)

DELETE FROM `creature_loot_template` WHERE `Entry` = 7288 AND `Item` = 8073;

