-- DB update 2026_10_13_00 -> 2026_10_13_01
--
UPDATE `creature_template` SET `CreatureImmunitiesId` = -361 WHERE (`entry` IN (33168, 33397));
