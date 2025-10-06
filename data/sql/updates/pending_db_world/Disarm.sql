
-- Remove Disarm Immunity
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 4 WHERE (`entry` = 29306);
