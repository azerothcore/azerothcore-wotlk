-- Watchman Doomgrip: the vault event completion (Secret Door + Secret Safe) is handled by the
-- instance script when all four vault warders and Doomgrip are dead, so drop the old on-death
-- shortcut that opened both on his death alone. The on-aggro unfreeze of nearby Warbringer
-- Constructs is dead code too: the instance script awakens them when the 12th Relic Coffer
-- door opens, before Doomgrip spawns. Keep his combat spells and his aggro yell.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 9476 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9476,0,0,0,0,0,100,0,1000,1000,6000,8000,0,0,11,11971,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Watchman Doomgrip - In Combat - Cast Sunder Armor'),
(9476,0,1,0,2,0,100,0,0,60,30000,30000,0,0,11,15504,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Watchman Doomgrip - Between 0-60% Health - Cast Drink Healing Potion'),
(9476,0,2,0,4,0,100,513,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Watchman Doomgrip - On Aggro - Say Line 0');
