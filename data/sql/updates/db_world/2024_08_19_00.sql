-- DB update 2024_08_18_00 -> 2024_08_19_00
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |256 WHERE `entry` IN (23418, 23419);
