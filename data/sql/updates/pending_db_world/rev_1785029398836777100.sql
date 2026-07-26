-- On 25-man, Faerlina's Frenzy is countered by Mind Controlling a Naxxramas
-- Worshipper to cast Widow's Embrace, so the 25-man entry must not be
-- charm-immune: -414 (with CHARM) -> -413 (same set without CHARM).
-- The 10-man entry (16506) keeps -414: there the Worshipper cannot be MC'd
-- and is killed next to Faerlina instead (casts Widow's Embrace on death).
UPDATE `creature_template` SET `CreatureImmunitiesId` = -413 WHERE `entry` = 29274;
