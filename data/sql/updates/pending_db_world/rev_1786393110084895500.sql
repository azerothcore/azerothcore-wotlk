-- Watchman Doomgrip: the vault event completion (Secret Door + Secret Safe) is handled by the
-- instance script when all four vault warders and Doomgrip are dead, so drop the old on-death
-- shortcut that opened both on his death alone. The on-aggro unfreeze of nearby Warbringer
-- Constructs is dead code too: the instance script awakens them when the 12th Relic Coffer
-- door opens, before Doomgrip spawns. Keep his combat spells and his aggro yell.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 9476 AND `source_type` = 0;
INSERT INTO `smart_scripts` VALUES
(9476,0,0,0,0,0,100,0,1000,1000,6000,8000,0,0,11,11971,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Watchman Doomgrip - In Combat - Cast Sunder Armor'),
(9476,0,1,0,2,0,100,0,0,60,30000,30000,0,0,11,15504,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Watchman Doomgrip - Between 0-60% Health - Cast Drink Healing Potion'),
(9476,0,2,0,4,0,100,513,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Watchman Doomgrip - On Aggro - Say Line 0');
