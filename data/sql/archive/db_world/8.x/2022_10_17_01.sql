-- DB update 2022_10_17_00 -> 2022_10_17_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`&~1 WHERE `entry` = 15263;
