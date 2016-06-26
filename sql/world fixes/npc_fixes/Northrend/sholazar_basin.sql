
-- Aotona (32481)
UPDATE creature_template SET mindmg=304, maxdmg=436, attackpower=600 WHERE entry=32481;

-- Primordial Drake (28378)
UPDATE creature SET position_z=-20 WHERE id=28378 AND guid=116789;
UPDATE creature SET position_z=-51 WHERE id=28378 AND guid=116790;
UPDATE creature SET position_z=-30 WHERE id=28378 AND guid=116793;
UPDATE creature SET spawndist=10 WHERE spawndist>0 AND id=28378;
REPLACE INTO creature_template_addon VALUES (28378, 0, 0, 0, 1, 0, '');
DELETE FROM creature_addon WHERE guid IN(116779, 116780, 116781, 116785, 116787, 116789, 116790, 116792, 116793) AND path_id=0;
INSERT INTO creature_addon VALUES (116779, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116780, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116781, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116785, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116787, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116789, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116790, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116792, 0, 0, 50331648, 1, 0, '');
INSERT INTO creature_addon VALUES (116793, 0, 0, 50331648, 1, 0, '');

-- Nesingwary Game Warden (30737)
UPDATE creature_template SET spell1=31942, spell2=6533, spell3=23601, spell4=16100, flags_extra=32768, AIName='SmartAI', ScriptName='' WHERE entry=30737;
DELETE FROM smart_scripts WHERE entryorguid=30737 AND source_type=0;
INSERT INTO smart_scripts VALUES (30737, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 18950, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - On Reset - Cast Invisibility and Stealth Detection');
INSERT INTO smart_scripts VALUES (30737, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 149, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - On Death - Send Zone Under Attack');
INSERT INTO smart_scripts VALUES (30737, 0, 2, 0, 0, 0, 100, 0, 0, 0, 2300, 3900, 11, 16100, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - In Combat - Cast Shoot');
INSERT INTO smart_scripts VALUES (30737, 0, 3, 0, 9, 0, 100, 0, 0, 20, 9000, 13000, 11, 6533, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - 0-20 Range - Cast Net');
INSERT INTO smart_scripts VALUES (30737, 0, 4, 0, 9, 0, 100, 0, 5, 30, 8000, 10000, 11, 31942, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Game Warden - 5-30 Range - Cast Multi-Shot');
