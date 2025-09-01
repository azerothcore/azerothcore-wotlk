-- DB update 2023_11_12_09 -> 2023_11_13_00
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|256 WHERE `entry` = 17225;
