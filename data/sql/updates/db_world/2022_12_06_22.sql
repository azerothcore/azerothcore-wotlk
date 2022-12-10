-- DB update 2022_12_06_21 -> 2022_12_06_22
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=17477 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17477,0,0,0,1,0,100,1,1000,1000,0,0,0,11,30540,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hellfire Imp - Out of Combat - Cast Summon Visual'),
(17477,0,1,0,4,0,100,0,0,0,0,0,0,28,30540,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hellfire Imp - On Aggro - Remove Summon Visual'),
(17477,0,2,0,0,0,100,2,1000,3400,3400,4800,0,11,15242,64,0,0,0,0,5,0,0,0,0,0,0,0,0,'Hellfire Imp - In Combat CMC - Cast Fireball (Normal Dungeon)'),
(17477,0,3,0,0,0,100,4,1000,3400,3400,4800,0,11,17290,64,0,0,0,0,5,0,0,0,0,0,0,0,0,'Hellfire Imp - In Combat CMC - Cast Fireball (Heroic Dungeon)'),
(17477,0,4,0,0,0,100,4,6000,9000,6000,9000,0,11,16144,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Hellfire Imp - In Combat - Cast Fire Blast');
