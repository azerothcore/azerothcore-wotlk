-- DB update 2024_06_24_02 -> 2024_06_24_03
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x00000008 WHERE `entry` IN (19514, 22947, 23576);
