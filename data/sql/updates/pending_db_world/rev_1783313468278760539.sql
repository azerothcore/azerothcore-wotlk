-- Set Patchwork Golem and Bile Retcher stun immunity and Sludge Belcher stunnable for Naxxramas 10/25.
UPDATE `creature_template` SET `CreatureImmunitiesId` = -405 WHERE `entry` IN (16017, 16018, 29347, 29353);
UPDATE `creature_template` SET `CreatureImmunitiesId` = -93 WHERE `entry` IN (16029, 29356);
