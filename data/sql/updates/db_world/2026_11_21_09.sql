-- DB update 2026_11_21_08 -> 2026_11_21_09
-- Duggan Wildhammer: Alliance Generic, attackable by the Horde only
UPDATE `creature_template` SET `faction` = 1055 WHERE `entry` = 10817;
