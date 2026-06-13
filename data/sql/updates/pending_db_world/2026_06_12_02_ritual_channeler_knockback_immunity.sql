-- Ritual Channeler (NPC 27281) should be immune to knockback effects.
-- Retail behavior: Ritual Channelers are stationary during the sacrifice ritual and
-- cannot be knocked away from their channeling positions by player abilities.
-- creature_immunities ID=-3 grants immunity to KNOCK_BACK (98), PULL_TOWARDS (124),
-- KNOCK_BACK_DEST (144), PULL_TOWARDS_DEST (145).
UPDATE `creature_template` SET `CreatureImmunitiesId` = -3 WHERE `entry` = 27281;
