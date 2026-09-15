-- DB update 2026_08_07_01 -> 2026_08_07_02
--
UPDATE `creature_template` SET `CreatureImmunitiesId` = -3 WHERE (`entry` = 28619);
