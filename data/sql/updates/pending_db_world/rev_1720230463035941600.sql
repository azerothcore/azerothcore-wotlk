--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~16384 WHERE `type` = 9 AND `mechanic_immune_mask`&16384;
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~16384 WHERE `type` = 6 AND `mechanic_immune_mask`&16384 AND `entry` NOT IN (4543, 8317, 11561, 16194, 16215, 16216, 28443);
