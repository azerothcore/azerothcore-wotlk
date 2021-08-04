INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628101702822210800');

-- Removed script where Mosh'Ogg Brute (1142) used Trash. Because it was the only entry it was changed to AggressorAI
UPDATE `creature_template` SET `AIName` = 'AggressorAI' WHERE (`entry` = 1142);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1142) AND (`source_type` = 0) AND (`id` IN (0));

