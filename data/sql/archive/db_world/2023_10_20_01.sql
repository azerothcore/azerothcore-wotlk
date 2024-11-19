-- DB update 2023_10_20_00 -> 2023_10_20_01
-- Adyen the Lightwarden
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~256 WHERE `entry` = 18537;
