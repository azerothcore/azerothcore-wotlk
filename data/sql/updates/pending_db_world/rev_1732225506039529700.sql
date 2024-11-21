--
-- fix(db/Creature) - Bonechewer Behemoth isn't immune to Distract anymore
UPDATE `creature_template` SET `mechanic_immune_mask` = 545468279 WHERE (`entry` = 23196);
