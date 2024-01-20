-- DB update 2023_09_18_04 -> 2023_09_19_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE `entry` IN (17168, 17169, 17170, 17171, 17172, 17173, 17174, 17175, 17176, 17260, 17459);
