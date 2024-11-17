-- DB update 2024_11_17_01 -> 2024_11_17_02
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`| 256 WHERE `entry` IN (23574, 23863);
