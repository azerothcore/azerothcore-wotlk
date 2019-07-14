INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562110333242304237');

-- Random movement for Bile Golem, Crypt Fiend, Devouring Ghoul, Patchwork Construct
UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` IN (28201,27734,28249,27736);

-- Fix Prince Keleseth waypoint movement
DELETE FROM `creature_addon` WHERE `guid` = 126025;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(126025,1260250,0,0,0,0,'');

-- Fix Rocknar SAI link error
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 25514 AND `source_type` = 0 AND `id` = 0;

-- Fix Impaled Valgarde Scout SAI link error (quest "Rescuing the Rescuers")
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 24077 AND `source_type` = 0 AND `id` = 0;

-- Fix Ymirjar Flesh Hunter SAI link error in Normal difficulty; fix using "Aimed Shot" in Heroic difficulty
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 26670 AND `source_type` = 0 AND `id` = 18;
UPDATE `smart_scripts` SET `event_type` = 0 WHERE `entryorguid` = 26670 AND `source_type` = 0 AND `id` = 19;
