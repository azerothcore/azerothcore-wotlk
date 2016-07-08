
-- Crazed Indu'le Survivor (32409)
UPDATE creature_template SET mindmg = 304, maxdmg=436 WHERE entry=32409;

-- Scarlet Highlord Daion (32417)
UPDATE creature_template SET mindmg = 304, maxdmg=436 WHERE entry=32417;

-- Kor'kron War Rider (26572)
DELETE FROM npc_spellclick_spells WHERE npc_entry=26572;

-- Anub'ar Cultist (26319)
DELETE FROM smart_scripts WHERE entryorguid=26319 AND source_type=0 AND id IN(11, 12);
INSERT INTO smart_scripts VALUES (26319, 0, 11, 0, 1, 0, 100, 0, 3000, 6000, 15000, 35000, 11, 47257, 32, 0, 0, 0, 0, 11, 26607, 50, 0, 0, 0, 0, 0, 'Anub''ar Cultist - Out of Combat - Cast Empower');

-- Goramosh (26349)
DELETE FROM creature_text WHERE entry=26349;
INSERT INTO creature_text VALUES (26349, 0, 0, 'You''re too late! The accord has been negotiated. Only the details remain. Small details... like you!', 12, 0, 100, 0, 0, 0, 0, 'Goramosh');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=26349;
DELETE FROM smart_scripts WHERE entryorguid=26349 AND source_type=0;
INSERT INTO smart_scripts VALUES (26349, 0, 0, 0, 1, 0, 100, 1, 1000, 1000, 1000, 1000, 11, 46906, 2, 0, 0, 0, 0, 10, 113473, 26298, 0, 0, 0, 0, 0, 'Goramosh - Out of Combat - Cast Surge Needle Beam');
INSERT INTO smart_scripts VALUES (26349, 0, 1, 0, 21, 0, 100, 0, 0, 0, 0, 0, 11, 46906, 2, 0, 0, 0, 0, 10, 113473, 26298, 0, 0, 0, 0, 0, 'Goramosh - On Reached Home - Cast Surge Needle Beam');
INSERT INTO smart_scripts VALUES (26349, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 11, 20828, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goramosh - Between 0-50% Health - Cast Cone of Cold');
INSERT INTO smart_scripts VALUES (26349, 0, 3, 0, 0, 0, 100, 0, 3500, 3500, 3500, 3500, 11, 9672, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Goramosh - In Combat - Cast Frostbolt');
INSERT INTO smart_scripts VALUES (26349, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Goramosh - On Aggro - Say Line 0');

-- Nexus Guardian (26276)
UPDATE creature SET position_x=3256.88, position_y=2623.43, position_z=155.77, spawndist=60 WHERE id=26276 AND guid=111305;
REPLACE INTO creature_addon VALUES (111305, 0, 0, 50331648, 1, 0, '');

-- Wrathgate npcs
-- Angrathar Necrolord (27603)
-- Frail Construct (27604)
-- Colossal Abomination (27605)
-- Plague Eruptor (27611)
-- Angrathar Aberration (27631)
-- Frenzied Gargoyle (27691)
-- Reconstructed Wyrm (27693)
-- Angrathar Geist (27957)
UPDATE creature_template SET exp=2, faction=2042 WHERE entry IN(27603, 27604, 27605, 27611, 27631, 27691, 27693, 27957); -- original 2052, displayed as friendly
UPDATE creature_template SET AIName='CombatAI' WHERE entry=27605;

-- Argent Crusade Rifleman (27351)
REPLACE INTO creature_template_addon VALUES (27351, 0, 0, 0, 4098, 0, '');
DELETE FROM creature_text WHERE entry=27351;
INSERT INTO creature_text VALUES (27351, 0, 0, 'Go with the Light, friend.', 12, 0, 100, 0, 0, 0, 0, 'Argent Crusade Rifleman');
INSERT INTO creature_text VALUES (27351, 0, 1, 'Light take you!', 12, 0, 100, 0, 0, 0, 0, 'Argent Crusade Rifleman');
INSERT INTO creature_text VALUES (27351, 0, 2, 'Ooooh! I think that one''s head exploded.', 12, 0, 100, 0, 0, 0, 0, 'Argent Crusade Rifleman');
INSERT INTO creature_text VALUES (27351, 0, 3, 'They were once people... Now? Undead monsters with an appetite for flesh!', 12, 0, 100, 0, 0, 0, 0, 'Argent Crusade Rifleman');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=27351;
DELETE FROM smart_scripts WHERE entryorguid=27351 AND source_type=0;
INSERT INTO smart_scripts VALUES (27351, 0, 0, 0, 0, 0, 100, 0, 0, 0, 2000, 2000, 11, 15547, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Argent Crusade Rifleman - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (27351, 0, 1, 0, 1, 0, 100, 0, 1000, 15000, 15000, 22000, 11, 48425, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argent Crusade Rifleman - Out of Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (27351, 0, 2, 0, 5, 0, 40, 0, 20000, 20000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Argent Crusade Rifleman - On Kill - Say Line 0');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=48425;
INSERT INTO conditions VALUES (13, 1, 48425, 0, 0, 31, 0, 3, 27290, 0, 0, 0, 0, '', 'Target Hungering Dead');
DELETE FROM spell_script_names WHERE spell_id IN(48425);
INSERT INTO spell_script_names VALUES(48425, 'spell_gen_select_target_count_7_1');

-- Npcs above Azjol'Nerub cave
-- Blighted Elk (26616)
-- Rabid Grizzly (26643)
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(97976, 119475, 119436, 97966) AND id IN(26616, 26643);
