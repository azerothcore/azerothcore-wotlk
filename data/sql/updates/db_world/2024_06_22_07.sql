-- DB update 2024_06_22_06 -> 2024_06_22_07
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256  WHERE `entry` IN (23030, 23330);
