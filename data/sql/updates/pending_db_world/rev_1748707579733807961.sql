-- Remove pre-spawned Ethereal Beacons from Nexus-Prince Shaffar encounter in Mana Tombs, he spawns them via script
DELETE FROM `creature` WHERE `guid` IN (91131,91132,91133) AND `id1`=18431 AND `map`=557;
DELETE FROM `linked_respawn` WHERE `guid` IN (91131,91132,91133);
