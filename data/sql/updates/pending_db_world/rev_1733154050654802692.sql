--
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (18094, 18093, 18092);

DELETE FROM `skinning_loot_template` WHERE `entry` IN (18094, 18093, 18092);
