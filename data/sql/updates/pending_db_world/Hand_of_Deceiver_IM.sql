
-- Remove Stun and Silence immunities
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`& ~ 2304  WHERE (`entry` = 25588);
