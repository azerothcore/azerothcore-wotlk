-- DB update 2022_10_14_01 -> 2022_10_14_02
--
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` IN (14882, 14883, 14825, 13996);
UPDATE `creature_template` SET `flags_extra` = 33554432 WHERE (`entry` = 15264);
