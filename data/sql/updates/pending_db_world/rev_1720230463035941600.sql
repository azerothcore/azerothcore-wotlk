--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~16384 WHERE `type` = 9 AND `mechanic_immune_mask`&16384;
