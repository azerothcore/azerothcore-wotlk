--
-- Embalming Slime
UPDATE `creature_template` SET `CreatureImmunitiesId` = -93 WHERE `entry` = 29355;
-- Patchwork Golem, Bile Retcher, and Sludge Belcher
UPDATE `creature_template` SET `CreatureImmunitiesId` = -405 WHERE `entry` IN (16017, 16018, 29347, 29353);
UPDATE `creature_template` SET `CreatureImmunitiesId` = -93 WHERE `entry` IN (16029, 29356);
