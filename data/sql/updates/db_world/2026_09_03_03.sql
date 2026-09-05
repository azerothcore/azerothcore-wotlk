-- DB update 2026_09_03_02 -> 2026_09_03_03
--
-- Thorim's script respawns Loken by GUID. In dynamic respawn mode the despawn destroys the spawn,
-- so the lookup finds nothing. Compatibility mode keeps the object addressable.
DELETE FROM `spawn_group` WHERE `spawnType` = 0 AND `spawnId` = 1955080;
INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`) VALUES
(1, 0, 1955080);

-- Thorim's walk is split in two so he stops at the top of the stairs to yell at Loken. A SmartAI
-- escort ignores the waypoints.delay column, and an action list can only wait on the clock, never
-- on a node, so the stop has to be a path boundary.
DELETE FROM `waypoints` WHERE `entry` = 3039900;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(3039900,1,8695.3,-703.023,933.672,NULL,0,'Thorim - The Reckoning'),
(3039900,2,8688.26,-696.381,932.802,NULL,0,''),
(3039900,3,8680.31,-688.831,930.953,NULL,0,''),
(3039900,4,8672.82,-681.81,929.133,NULL,0,''),
(3039900,5,8666.02,-675.593,927.207,NULL,0,''),
(3039900,6,8659.32,-669.424,924.904,NULL,0,''),
(3039900,7,8652.4,-662.992,922.517,NULL,0,''),
(3039900,8,8650.85,-661.499,923.67,NULL,0,''),
(3039900,9,8646.61,-657.15,923.886,NULL,0,''),
(3039900,10,8640.08,-650.813,923.668,NULL,0,''),
(3039900,11,8636.42,-647.304,923.366,NULL,0,''),
(3039900,12,8632.65,-643.688,924.368,NULL,0,''),
(3039900,13,8628.64,-639.923,925.278,NULL,0,''),
(3039900,14,8624.98,-636.499,926.056,NULL,0,''),
(3039900,15,8620.3,-632.119,926.204,NULL,0,'');

DELETE FROM `waypoints` WHERE `entry` = 3039901;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(3039901,1,8614.32,-626.557,926.204,NULL,0,'Thorim - The Reckoning - Onto The Platform'),
(3039901,2,8607.65,-620.366,926.204,NULL,0,''),
(3039901,3,8600.89,-614.094,925.559,NULL,0,''),
(3039901,4,8594.45,-608.167,925.559,NULL,0,''),
(3039901,5,8588.71,-603.394,925.559,NULL,0,''),
(3039901,6,8582.29,-597.977,925.559,NULL,0,''),
(3039901,7,8577.78,-593.913,925.559,NULL,0,''),
(3039901,8,8573.66,-590.061,925.559,NULL,0,'');

-- One slow lap around the platform, centred on 8575.619 -592.6562 at the height Veranus already
-- flew to. Path does not repeat, so he hovers at the last point until he despawns.
DELETE FROM `waypoints` WHERE `entry` = 3042000;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(3042000,1,8609.17,-636.666,967.317,NULL,0,'Veranus - The Reckoning'),
(3042000,2,8568.224,-647.5,967.317,NULL,0,''),
(3042000,3,8531.609,-626.207,967.317,NULL,0,''),
(3042000,4,8520.775,-585.261,967.317,NULL,0,''),
(3042000,5,8542.068,-548.646,967.317,NULL,0,''),
(3042000,6,8583.014,-537.812,967.317,NULL,0,''),
(3042000,7,8619.629,-559.105,967.317,NULL,0,''),
(3042000,8,8630.463,-600.052,967.317,NULL,0,'');

-- Retimed so Loken appears on the throne as Thorim reaches the top of the stairs, and so the kick
-- and Say Line 4 land together. Thorim walks his path (12 yd/s), he does not run.
-- Last step is a safety net: without it a run that never reaches Loken leaves Thorim alive at the
-- end of his path with no npcflags, unresettable until a server restart.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3039900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3039900,9,0,0,0,0,100,0,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Set Active On'),
(3039900,9,1,0,0,0,100,0,0,0,0,0,0,0,80,3042000,2,0,0,0,0,10,49142,30420,0,0,0,0,0,0,'Thorim - On Script - Run Script \'Veranus\''),
(3039900,9,2,0,0,0,100,0,0,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Remove NPC Flags'),
(3039900,9,3,0,0,0,100,0,0,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 1'),
(3039900,9,4,0,0,0,100,0,3000,3000,0,0,0,0,53,1,3039900,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Start WP Movement'),
(3039900,9,5,0,0,0,100,0,9900,9900,0,0,0,0,70,0,0,0,0,0,0,10,1955080,30396,0,0,0,0,0,0,'Thorim - On Script - Respawn \'Loken\''),
(3039900,9,6,0,0,0,100,0,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,8620.3,-632.119,926.204,2.4006,'Thorim - On Script - Set Orientation'),
(3039900,9,7,0,0,0,100,0,1000,1000,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 2'),
(3039900,9,8,0,0,0,100,0,3000,3000,0,0,0,0,53,1,3039901,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Start WP Movement 2'),
(3039900,9,9,0,0,0,100,0,6600,6600,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 3'),
(3039900,9,10,0,0,0,100,0,1500,1500,0,0,0,0,45,1,1,0,0,0,0,19,30396,30,0,0,0,0,0,0,'Thorim - On Script - Set Data 1 1 On \'Loken\''),
(3039900,9,11,0,0,0,100,0,12000,12000,0,0,0,0,11,56688,0,0,0,0,0,19,30396,30,0,0,0,0,0,0,'Thorim - On Script - Cast \'Thorim\'s Knockback\''),
(3039900,9,12,0,0,0,100,0,500,500,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 4'),
(3039900,9,13,0,0,0,100,0,1500,1500,0,0,0,0,46,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Move Forward'),
(3039900,9,14,0,0,0,100,0,0,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Set Home Position'),
(3039900,9,15,0,0,0,100,0,2000,2000,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 5'),
(3039900,9,16,0,0,0,100,0,2000,2000,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Say Line 6'),
(3039900,9,17,0,0,0,100,0,1000,1000,0,0,0,0,11,56694,0,0,0,0,0,19,30396,100,0,0,0,0,0,0,'Thorim - On Script - Cast \'Lightning Fury\''),
(3039900,9,18,0,0,0,100,0,1500,1500,0,0,0,0,11,56695,0,0,0,0,0,19,30396,100,0,0,0,0,0,0,'Thorim - On Script - Cast \'Thorim\'s Hammer\''),
(3039900,9,19,0,0,0,100,0,0,0,0,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Unequip Weapon'),
(3039900,9,20,0,0,0,100,0,120000,120000,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Thorim - On Script - Despawn After 1 Second');

-- Loken lands short of Thorim rather than on top of him: the knockback has just pushed Thorim away
-- from the throne, so a shorter jump leaves the two facing each other with room between them.
-- Loken walks back to his throne before Say Line 2. MoveTo's target_o is the facing he lands on.
-- The script also never dropped 56696 off Thorim, so he stayed down and despawned lying there.
-- Now the channel is cut and the aura removed before the quest credit goes out.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3039600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3039600,9,0,0,0,0,100,0,2000,2000,0,0,0,0,11,56677,0,0,0,0,0,19,30399,30,0,0,0,0,0,0,'Loken - On Script - Cast \'Loken\'s Knockback\''),
(3039600,9,1,0,0,0,100,0,3000,3000,0,0,0,0,97,40,20,0,0,0,0,1,0,0,0,0,8605.005,-621.528,926.204,0,'Loken - On Script - Jump To Pos'),
(3039600,9,2,0,0,0,100,0,2000,2000,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 1'),
(3039600,9,3,0,0,0,100,0,1000,1000,0,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Play emote \'ONESHOT_POINT\''),
(3039600,9,4,0,0,0,100,0,6000,6000,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Set Home Position'),
(3039600,9,5,0,0,0,100,0,10500,10500,0,0,0,0,11,10689,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Cast \'Knockback\''),
(3039600,9,6,0,0,0,100,0,2000,2000,0,0,0,0,69,25,0,0,0,0,0,8,0,0,0,0,8566.083,-581.791,925.559,5.49993,'Loken - On Script - Move To Pos'),
(3039600,9,7,0,0,0,100,0,7000,7000,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 2'),
(3039600,9,8,0,0,0,100,0,4000,4000,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 3'),
(3039600,9,9,0,0,0,100,0,6000,6000,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 4'),
(3039600,9,10,0,0,0,100,0,1000,1000,0,0,0,0,11,56696,0,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Loken - On Script - Cast \'Loken - Defeat Thorim\''),
(3039600,9,11,0,0,0,100,0,0,0,0,0,0,0,75,56696,0,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Loken - On Script - Add Aura \'Loken - Defeat Thorim\''),
(3039600,9,12,0,0,0,100,0,6000,6000,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 5'),
(3039600,9,13,0,0,0,100,0,7000,7000,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Say Line 6'),
(3039600,9,14,0,0,0,100,0,0,0,0,0,0,0,12,30429,1,60000,0,0,0,8,0,0,0,0,8622.84,-605.789,926.286,4.43314,'Loken - On Script - Spawn \'Runeforged Servant\''),
(3039600,9,15,0,0,0,100,0,0,0,0,0,0,0,12,30429,1,60000,0,0,0,8,0,0,0,0,8586.87,-564.764,925.641,5.16617,'Loken - On Script - Spawn \'Runeforged Servant\''),
(3039600,9,16,0,0,0,100,0,7000,7000,0,0,0,0,1,6,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Loken - On Script - Say Line 7'),
(3039600,9,17,0,0,0,100,0,7000,7000,0,0,0,0,1,7,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'Loken - On Script - Say Line 8'),
(3039600,9,18,0,0,0,100,0,3000,3000,0,0,0,0,92,1,56696,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Interrupt Spell \'Loken - Defeat Thorim\''),
(3039600,9,19,0,0,0,100,0,0,0,0,0,0,0,28,56696,0,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Loken - On Script - Remove Aura \'Loken - Defeat Thorim\''),
(3039600,9,20,0,0,0,100,0,2000,2000,0,0,0,0,11,56941,1,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Cast \'Witness the Reckoning\''),
(3039600,9,21,0,0,0,100,0,0,0,0,0,0,0,45,1,1,0,0,0,0,10,49141,30399,0,0,0,0,0,0,'Loken - On Script - Set Data 1 1 to \'Thorim\''),
(3039600,9,22,0,0,0,100,0,0,0,0,0,0,0,45,1,1,0,0,0,0,10,49142,30420,0,0,0,0,0,0,'Loken - On Script - Set Data 1 1 to \'Veranus\''),
(3039600,9,23,0,0,0,100,0,0,0,0,0,0,0,45,1,1,0,0,0,0,9,30429,0,200,0,0,0,0,0,'Loken - On Script - Set Data 1 1 to \'Runeforged Servant\''),
(3039600,9,24,0,0,0,100,0,0,0,0,0,0,0,11,34427,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Cast \'Ethereal Teleport\''),
(3039600,9,25,0,0,0,100,0,0,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Loken - On Script - Despawn After 1 Second');

-- Veranus flies to the platform edge as before, then circles it once and hovers facing Thorim's
-- body. The end of an escort applies no facing of its own, hence the orientation step.
-- Last step is the same safety net Thorim got: only Loken's script despawns him, so an aborted run
-- parks him out of position and visible for good.
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3042000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3042000,9,0,0,0,0,100,0,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Set Active On'),
(3042000,9,1,0,0,0,100,0,0,0,0,0,0,0,28,54503,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Remove Aura \'Quest Invisibility 2\''),
(3042000,9,2,0,0,0,100,0,24000,24000,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,8609.17,-636.666,967.317,2.12401,'Veranus - On Script - Move To Pos'),
(3042000,9,3,0,0,0,100,0,17000,17000,0,0,0,0,53,3,3042000,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Start WP Movement'),
(3042000,9,4,0,0,0,100,0,52000,52000,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,8630.463,-600.052,967.317,4.1365,'Veranus - On Script - Set Orientation'),
(3042000,9,5,0,0,0,100,0,80000,80000,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Script - Despawn After 1 Second');

-- Dropped the "Respawn Target" row. Respawn() is a no-op on a creature that is alive, and a
-- despawned one is not addressable by GUID, so it could never restore a stranded Thorim.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30420);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30420,0,0,1,38,0,100,512,1,1,0,0,0,0,11,34427,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - On Data Set 1 1 - Cast \'Ethereal Teleport\''),
(30420,0,1,0,61,0,100,512,0,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Veranus - Linked - Despawn After 1 Second');
