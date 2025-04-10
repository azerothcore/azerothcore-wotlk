
-- Remove Stun and Silence immunities
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`& ~ 2048  WHERE (`entry` = 25588);
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`& ~ 256  WHERE (`entry` = 25588);
