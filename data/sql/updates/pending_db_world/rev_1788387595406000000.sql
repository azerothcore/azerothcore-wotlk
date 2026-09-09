-- Ulduar: Expedition Base Camp protective bubble should not respawn every 3 minutes
UPDATE `gameobject` SET `spawntimesecs` = 604800 WHERE `guid` = 50363;
