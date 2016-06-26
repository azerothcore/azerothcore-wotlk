
-- Razormaw (9689)
DELETE FROM event_scripts WHERE id=11087;
INSERT INTO event_scripts VALUES (11087, 0, 10, 17592, 150000, 0, -1121.53, -12600.80, 134.03, 2.86);
REPLACE INTO creature_template_addon VALUES (17592, 0, 0, 50331648, 1, 0, '');
UPDATE creature_template SET InhabitType=3, AIName='SmartAI', ScriptName='' WHERE entry=17592;
DELETE FROM smart_scripts WHERE entryorguid=17592 AND source_type=0;
INSERT INTO smart_scripts VALUES (17592, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 7000, 9000, 11, 31279, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - Combat - Cast Swipe');
INSERT INTO smart_scripts VALUES (17592, 0, 1, 0, 0, 0, 100, 0, 26000, 30000, 26000, 30000, 11, 8873, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - Combat - Cast Flame Breath');
INSERT INTO smart_scripts VALUES (17592, 0, 2, 0, 0, 0, 50, 0, 12000, 12000, 12000, 12000, 11, 14100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - Combat - Cast Terrifying Roar');
INSERT INTO smart_scripts VALUES (17592, 0, 3, 4, 11, 0, 100, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Spawn - Set Active');
INSERT INTO smart_scripts VALUES (17592, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Spawn - Add Unit Flags');
INSERT INTO smart_scripts VALUES (17592, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 60, 1, 250, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Spawn - Set Can Fly');
INSERT INTO smart_scripts VALUES (17592, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Spawn - No Environment Update');
INSERT INTO smart_scripts VALUES (17592, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 53, 1, 17592, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Spawn - Load Path');
INSERT INTO smart_scripts VALUES (17592, 0, 8, 9, 40, 0, 100, 0, 3, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Reach waypoint - Remove Unit Flags');
INSERT INTO smart_scripts VALUES (17592, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Waypoint 10 Reached - Set Home Position');
INSERT INTO smart_scripts VALUES (17592, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 60, 0, 110, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Waypoint 10 Reached - Set Can Fly Off');
INSERT INTO smart_scripts VALUES (17592, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 141, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Waypoint 10 Reached - Set Hover Off');
INSERT INTO smart_scripts VALUES (17592, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Razormaw - On Waypoint 10 Reached - Set Agressive');
DELETE FROM waypoints WHERE entry=17592;
INSERT INTO waypoints VALUES (17592, 1, -1167.07, -12594.71, 133.93, 'Razormaw');
INSERT INTO waypoints VALUES (17592, 2, -1200.90, -12554.55, 129.0, 'Razormaw');
INSERT INTO waypoints VALUES (17592, 3, -1208.03, -12469.59, 94.5, 'Razormaw');
