-- DB update 2026_10_10_08 -> 2026_10_10_09
--
UPDATE `creature_template` SET `CreatureImmunitiesId` = -20 WHERE `entry` = 22006;
