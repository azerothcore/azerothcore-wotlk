--
-- From: "Monstrous Kaliri - In Combat - Cast 'Hamstring' (No Repeat) (Normal Dungeon)"
UPDATE `smart_scripts` SET `comment` = 'Monstrous Kaliri - In Combat - Cast \'Hamstring\'' WHERE `entryorguid` = 23051 AND `id` = 0;
-- From: Monstrous Kaliri - In Combat - Cast 'Rend' (No Repeat) (Normal Dungeon)
UPDATE `smart_scripts` SET `comment` = 'Monstrous Kaliri - In Combat - Cast \'Rend\'' WHERE `entryorguid` = 23051 AND `id` = 1;
-- Removes "Swoop" from SAI of Creature "Monstrous Kaliri"
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23051 AND `id` = 2;
