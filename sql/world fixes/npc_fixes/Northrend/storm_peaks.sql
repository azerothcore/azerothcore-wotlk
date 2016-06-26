
-- Brunnhildar Riding Bear (29549)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29549;
DELETE FROM smart_scripts WHERE entryorguid IN(29549, -105872, -105871, -105870, -105869) AND source_type=0;
INSERT INTO smart_scripts VALUES (-105872, 0, 0, 1, 1, 0, 100, 1, 5000, 5000, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Riding Bear - Out of Combat - Add Unit Flag');
INSERT INTO smart_scripts VALUES (-105872, 0, 1, 0, 61, 0, 100, 0, 0, 5000, 0, 0, 11, 46674, 2, 0, 0, 0, 0, 10, 106192, 29551, 1, 0, 0, 0, 0, 'Brunnhildar Riding Bear - Out of Combat - Cast Rope Beam Right');
INSERT INTO smart_scripts VALUES (-105872, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 19, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Riding Bear - On Aggro - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (-105871, 0, 0, 0, 1, 0, 100, 1, 5000, 5000, 0, 0, 11, 66206, 2, 0, 0, 0, 0, 10, 106192, 29551, 1, 0, 0, 0, 0, 'Brunnhildar Riding Bear - Out of Combat - Cast Rope Beam Left');
INSERT INTO smart_scripts VALUES (-105870, 0, 0, 1, 1, 0, 100, 1, 5000, 5000, 0, 0, 18, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Riding Bear - Out of Combat - Add Unit Flag');
INSERT INTO smart_scripts VALUES (-105870, 0, 1, 0, 61, 0, 100, 0, 0, 5000, 0, 0, 11, 46674, 2, 0, 0, 0, 0, 10, 106191, 29551, 1, 0, 0, 0, 0, 'Brunnhildar Riding Bear - Out of Combat - Cast Rope Beam Right');
INSERT INTO smart_scripts VALUES (-105870, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 19, 16777216, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Riding Bear - On Aggro - Remove Unit Flag');
INSERT INTO smart_scripts VALUES (-105869, 0, 0, 0, 1, 0, 100, 1, 5000, 5000, 0, 0, 11, 66206, 2, 0, 0, 0, 0, 10, 106191, 29551, 1, 0, 0, 0, 0, 'Brunnhildar Riding Bear - Out of Combat - Cast Rope Beam Left');

-- Brunnhildar Challenger (29366)
REPLACE INTO creature_template_addon VALUES (29366, 0, 0, 0, 4097, 27, '');
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=29366;
DELETE FROM smart_scripts WHERE entryorguid=29366 AND source_type=0;
INSERT INTO smart_scripts VALUES (29366, 0, 0, 0, 1, 0, 100, 0, 0, 1000, 1500, 2500, 10, 35, 36, 37, 38, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Brunnhildar Challenger - Out of Combat - Play Random Emote');

-- Dun Niffelem Spear Chain Bunny (Phase 2) (30246)
UPDATE creature_template SET InhabitType=4, flags_extra=130, AIName='SmartAI', ScriptName='' WHERE entry=30246;
DELETE FROM smart_scripts WHERE entryorguid IN(-142407, -142408) AND source_type=0;
INSERT INTO smart_scripts VALUES (-142407, 0, 0, 0, 60, 0, 100, 0, 0, 1, 20000, 20000, 11, 56379, 0, 0, 0, 0, 0, 10, 142409, 30246, 1, 0, 0, 0, 0, 'Dun Niffelem Spear Chain Bunny (Phase 2) - On Update - Cast Spear Chain Beam');
INSERT INTO smart_scripts VALUES (-142408, 0, 0, 0, 60, 0, 100, 0, 0, 1, 20000, 20000, 11, 56379, 0, 0, 0, 0, 0, 10, 142410, 30246, 1, 0, 0, 0, 0, 'Dun Niffelem Spear Chain Bunny (Phase 2) - On Update - Cast Spear Chain Beam');
DELETE FROM creature WHERE id=30246;
INSERT INTO creature VALUES (142410, 30246, 571, 1, 4, 0, 0, 7393.33, -2841.03, 888.614, 6.14356, 180, 0, 0, 9215, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (142409, 30246, 571, 1, 4, 0, 0, 7215.59, -2712.18, 895.99, 0.034907, 180, 0, 0, 9215, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (142408, 30246, 571, 1, 4, 0, 0, 7347.33, -2809.35, 868.826, 0.122173, 180, 0, 0, 9215, 0, 0, 0, 0, 0);
INSERT INTO creature VALUES (142407, 30246, 571, 1, 4, 0, 0, 7266.99, -2753.76, 870.875, 6.23082, 180, 0, 0, 9215, 0, 0, 0, 0, 0);

-- Thorim (29445)
DELETE FROM smart_scripts WHERE entryorguid=29445 AND source_type=0;
INSERT INTO smart_scripts VALUES (29445, 0, 0, 0, 62, 0, 100, 0, 9926, 0, 0, 0, 85, 56940, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Thorim - On Gossip Option 0 Selected - Cast Thorim Story Kill Credit');
INSERT INTO smart_scripts VALUES (29445, 0, 1, 0, 19, 0, 100, 0, 12924, 0, 0, 0, 85, 56518, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Thorim - On Quest Forging an Alliance Taken - Invoker Cast Clearquests');
