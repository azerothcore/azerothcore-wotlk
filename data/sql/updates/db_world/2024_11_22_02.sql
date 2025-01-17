-- DB update 2024_11_22_01 -> 2024_11_22_02
--
-- fix(db/Creature) - Bonechewer Behemoth isn't immune to Distract anymore
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 8 WHERE `entry` = 23196;
