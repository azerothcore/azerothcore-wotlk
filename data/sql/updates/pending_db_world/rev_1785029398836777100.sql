-- Naxxramas Worshipper must not be charm-immune: Mind Controlling her to cast
-- Widow's Embrace is the core mechanic of the Grand Widow Faerlina encounter.
-- -414 (with CHARM) -> -413 (same set without CHARM), TC has no immunities here.
UPDATE `creature_template` SET `CreatureImmunitiesId` = -413 WHERE `entry` IN (16506, 29274);
