-- ============================================
-- Ruby Sanctum: Thiassi (28018) / Antiok (28006)
-- Fix: Vehicle accessory not receiving buff on player interaction
-- ============================================

DELETE FROM creature_template_addon WHERE entry=28006;
DELETE FROM vehicle_template_accessory WHERE entry=28018;
INSERT INTO vehicle_template_accessory (entry, accessory_entry, seat_id, minion, description, summontype, summontimer) VALUES
(28018, 28006, 0, 0, 'Thiassi the Lightning Bringer', 8, 0);

DELETE FROM smart_scripts WHERE entryorguid=28018 AND source_type=0;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, event_param5, event_param6, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_param4, target_x, target_y, target_z, target_o, comment) VALUES
(28018, 0, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50456, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Thiassi the Lightning Bringer - In Combat - Cast Thiassi''s Stormbolt'),
(28018, 0, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 15593, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thiassi the Lightning Bringer - In Combat - Cast War Stomp'),
(28018, 0, 2, 0, 27, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 50494, 0, 0, 0, 0, 0, 19, 28006, 100, 0, 0, 0, 0, 0, 0, 'Thiassi - On Passenger Boarded - Add Shroud of Lightning to Antiok'),
(28018, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 50494, 0, 0, 0, 0, 0, 19, 28006, 100, 0, 0, 0, 0, 0, 0, 'Thiassi - On Death - Remove Shroud of Lightning from Antiok'),
(28018, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 32772, 0, 0, 0, 0, 0, 19, 28006, 100, 0, 0, 0, 0, 0, 0, 'Thiassi - LINK - Remove stunned+unattackable flags from Antiok');

DELETE FROM smart_scripts WHERE entryorguid=28006 AND source_type=0 AND id=5;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, event_param5, event_param6, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_param4, target_x, target_y, target_z, target_o, comment) VALUES
(28006, 0, 5, 0, 26, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50494, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Antiok - On Just Respawned - Cast Shroud of Lightning on self');
