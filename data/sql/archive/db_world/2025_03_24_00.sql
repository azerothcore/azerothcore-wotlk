-- DB update 2025_03_22_02 -> 2025_03_24_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` &~2147483648 WHERE `entry` = 25315;
