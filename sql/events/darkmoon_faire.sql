
-- Fix Game Events (this should be rewritten every month...)
REPLACE INTO game_event VALUES(3, '2014-11-02 01:01:00', '2020-12-31 06:00:00', 131040, 10079, 376, 'Darkmoon Faire (Terokkar Forest)', 0);
REPLACE INTO game_event VALUES(4, '2014-09-07 01:01:00', '2020-12-31 06:00:00', 131040, 10079, 374, 'Darkmoon Faire (Elwynn Forest)', 0);
REPLACE INTO game_event VALUES(5, '2014-10-05 01:01:00', '2020-12-31 06:00:00', 131040, 10079, 375, 'Darkmoon Faire (Mulgore)', 0);
REPLACE INTO game_event VALUES(23, '2014-09-04 01:01:00', '2020-12-31 06:00:00', 131040, 4320, 0, 'Darkmoon Faire Building (Elwynn Forest)', 0);

-- Fix Blastenheimer 5000 Ultra Cannon
-- Trigger Spawns
DELETE FROM creature WHERE guid IN(247000, 247001, 247002, 247003);
INSERT INTO creature VALUES (247000, 33068, 530, 1, 1, 0, 0, -1805.9, 4964.68, -24.8216, 4.03094, 300, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247001, 15218, 530, 1, 1, 0, 0, -1742, 5457, -12.427, 5.72347, 300, 0, 0, 4121, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247002, 15218, 0, 1, 1, 0, 0, -9571, -18, 62.9345, 5.72347, 300, 0, 0, 4121, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (247003, 33068, 0, 1, 1, 0, 0, -9506.09, -372.595, 57.633, 5.55462, 300, 0, 0, 1, 0, 0, 0, 0, 0);
DELETE FROM game_event_creature WHERE guid IN(247000, 247001, 247002, 247003);
INSERT INTO game_event_creature VALUES (3, 247000);
INSERT INTO game_event_creature VALUES (3, 247001);
INSERT INTO game_event_creature VALUES (4, 247002);
INSERT INTO game_event_creature VALUES (4, 247003);
-- Spell Script
DELETE FROM spell_linked_spell WHERE spell_trigger IN(-24743, 24743, -24832, 24832, -42825, 42825);
INSERT INTO spell_linked_spell VALUES (24743, 24730, 1, 'Cannon Prep - Link Teleport');
INSERT INTO spell_linked_spell VALUES (24743, 24754, 1, 'Cannon Prep - Link Stun');
INSERT INTO spell_linked_spell VALUES (-24743, 24731, 0, 'Cannon Prep Remove - Link Cannon Fire');
INSERT INTO spell_linked_spell VALUES (24832, 24831, 1, 'Cannon Prep - Link Teleport');
INSERT INTO spell_linked_spell VALUES (24832, 24754, 1, 'Cannon Prep - Link Stun');
INSERT INTO spell_linked_spell VALUES (-24832, 24731, 0, 'Cannon Prep Remove - Link Cannon Fire');
INSERT INTO spell_linked_spell VALUES (42825, 42826, 1, 'Cannon Prep - Link Teleport');
INSERT INTO spell_linked_spell VALUES (42825, 24754, 1, 'Cannon Prep - Link Stun');
INSERT INTO spell_linked_spell VALUES (-42825, 42868, 0, 'Cannon Prep Remove - Link Cannon Fire');
DELETE FROM spell_target_position WHERE id IN(24730, 24831, 42826);
INSERT INTO spell_target_position VALUES (24730, 0, 1, -1325.87, 86.6842, 129.79, 3.51259);
INSERT INTO spell_target_position VALUES (24831, 0, 0, -9570.819938, -18.983655274, 62.9345, 4.98);
INSERT INTO spell_target_position VALUES (42826, 0, 530, -1742.128713975, 5456.008318240, -12.427, 4.6);
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry IN(24731, 42868);
INSERT INTO conditions VALUES(13, 3, 24731, 0, 0, 31, 0, 3, 15218, 0, 0, 0, 0, '', 'Target Darkmoon Fire Cannon');
INSERT INTO conditions VALUES(13, 3, 42868, 0, 0, 31, 0, 3, 15218, 0, 0, 0, 0, '', 'Target Darkmoon Fire Cannon');
-- GObject Script
UPDATE gameobject_template SET faction=35, AIName='SmartGameObjectAI', ScriptName='' WHERE entry IN(180515, 186560, 180452);
DELETE FROM smart_scripts WHERE entryorguid IN(180515, 186560, 180452) AND source_type=1;
INSERT INTO smart_scripts VALUES(180515, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastenheimer 5000 - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES(180515, 1, 1, 0, 59, 0, 100, 0, 1, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastenheimer 5000 - On Timed Event - Send GO Custom Anim');
INSERT INTO smart_scripts VALUES(186560, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastenheimer 5000 - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES(186560, 1, 1, 0, 59, 0, 100, 0, 1, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastenheimer 5000 - On Timed Event - Send GO Custom Anim');
INSERT INTO smart_scripts VALUES(180452, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastenheimer 5000 - On Gossip Hello - Create Timed Event');
INSERT INTO smart_scripts VALUES(180452, 1, 1, 0, 59, 0, 100, 0, 1, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blastenheimer 5000 - On Timed Event - Send GO Custom Anim');
-- Triggers Script
UPDATE creature_template SET flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=15218;
UPDATE creature_template SET flags_extra=130, AIName='', ScriptName='' WHERE entry=33068;
DELETE FROM smart_scripts WHERE entryorguid=15218 AND source_type=0;
INSERT INTO smart_scripts VALUES(15218, 0, 0, 0, 8, 0, 100, 0, 24731, 0, 0, 0, 11, 24742, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Darkmoon Faire Cannon - On Spell Hit - Cast Knockback Magic Wings');
INSERT INTO smart_scripts VALUES(15218, 0, 1, 0, 8, 0, 100, 0, 42868, 0, 0, 0, 11, 42867, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Darkmoon Faire Cannon - On Spell Hit - Cast Knockback Magic Wings');
