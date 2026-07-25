-- DB update 2026_07_19_02 -> 2026_07_19_03
--
UPDATE `creature_template` SET `CreatureImmunitiesId` = -280 WHERE (`entry` IN (33052, 33116));
