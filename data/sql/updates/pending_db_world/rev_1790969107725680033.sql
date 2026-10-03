-- Lower Hadronox door adds: attack Hadronox when out of combat and despawn on death, like their 29062-29064 counterparts
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (29096, 29097, 29098);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29096,0,0,0,0,0,100,2,6000,9000,17000,32000,0,0,11,53317,32,0,0,0,0,5,0,0,0,53317,0,0,0,0,'Anub\'ar Champion - In Combat - Cast \'Rend\' (Phase 1) (No Repeat) (Dungeon)'),
(29096,0,1,0,0,0,100,4,4000,7000,15000,18000,0,0,11,59343,32,0,0,0,0,5,0,0,0,59343,0,0,0,0,'Anub\'ar Champion - In Combat - Cast \'Rend\' (Phase 1) (No Repeat) (Dungeon)'),
(29096,0,2,0,105,0,25,2,14000,17000,14000,17000,0,5,11,53394,1,0,0,0,0,7,0,0,0,0,0,0,0,0,'Anub\'ar Champion - Target Casting - Cast \'Pummel\' (Phase 1) (No Repeat) (Dungeon)'),
(29096,0,3,0,105,0,25,4,9000,12000,9000,12000,0,5,11,59344,1,0,0,0,0,7,0,0,0,0,0,0,0,0,'Anub\'ar Champion - Target Casting - Cast \'Pummel\' (Phase 1) (No Repeat) (Dungeon)'),
(29096,0,4,0,1,0,100,0,10000,10000,1000,1000,0,0,49,0,0,0,0,0,0,11,28921,50,1,0,0,0,0,0,'Anub\'ar Champion Out of Combat - Start Attacking'),
(29096,0,5,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anub\'ar Champion - On Just Died - Despawn In 10000 ms'),
(29097,0,0,0,0,0,100,2,4000,7000,9000,12000,0,0,11,53330,32,0,0,0,0,5,0,0,0,53330,0,0,0,0,'Anub\'ar Crypt Fiend - In Combat - Cast \'Infected Wound\' (Phase 1) (No Repeat) (Dungeon)'),
(29097,0,1,0,0,0,100,4,4000,7000,9000,12000,0,0,11,59348,32,0,0,0,0,5,0,0,0,59348,0,0,0,0,'Anub\'ar Crypt Fiend - In Combat - Cast \'Infected Wound\' (Phase 1) (No Repeat) (Dungeon)'),
(29097,0,2,0,0,0,100,2,9000,12000,13000,17000,0,0,11,53322,1,0,0,0,0,5,0,0,0,0,0,0,0,0,'Anub\'ar Crypt Fiend - In Combat - Cast \'Crushing Webs\' (Phase 1) (No Repeat) (Dungeon)'),
(29097,0,3,0,0,0,100,4,9000,12000,10000,13000,0,0,11,59347,1,0,0,0,0,5,0,0,0,0,0,0,0,0,'Anub\'ar Crypt Fiend - In Combat - Cast \'Crushing Webs\' (Phase 1) (No Repeat) (Dungeon)'),
(29097,0,4,0,1,0,100,0,10000,10000,1000,1000,0,0,49,0,0,0,0,0,0,11,28921,50,1,0,0,0,0,0,'Anub\'ar Crypt Fiend Out of Combat - Start Attacking'),
(29097,0,5,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anub\'ar Crypt Fiend - On Just Died - Despawn In 10000 ms'),
(29098,0,0,0,0,0,100,6,0,0,4000,6000,0,0,11,53333,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Anub\'ar Necromancer - Combat CMC - Cast \'Shadow Bolt\' (Dungeon)'),
(29098,0,1,0,0,0,100,6,14000,17000,23000,27000,0,0,11,53334,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anub\'ar Necromancer - Combat - Cast \'Animate Bones\' (Dungeon)'),
(29098,0,2,0,1,0,100,0,10000,10000,1000,1000,0,0,49,0,0,0,0,0,0,11,28921,50,1,0,0,0,0,0,'Anub\'ar Necromancer Out of Combat - Start Attacking'),
(29098,0,3,0,6,0,100,512,0,0,0,0,0,0,41,10000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anub\'ar Necromancer - On Just Died - Despawn In 10000 ms');
