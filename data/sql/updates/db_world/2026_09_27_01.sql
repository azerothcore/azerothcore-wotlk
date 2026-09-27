-- DB update 2026_09_27_00 -> 2026_09_27_01
--
UPDATE `creature_template` SET `CreatureImmunitiesId` = -287 WHERE `entry` IN (33113, 34003);
