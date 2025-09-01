-- DB update 2023_08_14_03 -> 2023_08_14_04
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2 WHERE `entry` IN (26582, 26583);
