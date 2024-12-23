-- Add interrupt immunity to Ashtongue Stormcaller
UPDATE `creature_template` SET `mechanic_immune_mask` = 570559233 WHERE (`entry` = 22846);
